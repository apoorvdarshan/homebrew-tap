import { createHash } from "node:crypto";
import { readFile, writeFile } from "node:fs/promises";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const root = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const headers = {
  Accept: "application/vnd.github+json",
  "User-Agent": "apoorvdarshan-homebrew-tap",
  "X-GitHub-Api-Version": "2022-11-28",
};

if (process.env.GITHUB_TOKEN) {
  headers.Authorization = `Bearer ${process.env.GITHUB_TOKEN}`;
}

const projects = [
  {
    repository: "apoorvdarshan/TetherShot",
    cask: "Casks/tethershot.rb",
    assets(version) {
      return {
        universal: `TetherShot-${version}-universal.dmg`,
      };
    },
    update(content, version, digests) {
      return replaceOnce(
        replaceOnce(content, /version "[^"]+"/, `version "${version}"`),
        /sha256 "[a-f0-9]{64}"/,
        `sha256 "${digests.universal}"`,
      );
    },
  },
  {
    repository: "apoorvdarshan/browser-cookie-bridge",
    cask: "Casks/browser-cookie-bridge.rb",
    assets() {
      return {
        arm: "Browser-Cookie-Bridge-arm64.dmg",
        intel: "Browser-Cookie-Bridge-x64.dmg",
      };
    },
    update(content, version, digests) {
      return replaceOnce(
        replaceOnce(content, /version "[^"]+"/, `version "${version}"`),
        /sha256 arm:\s+"[a-f0-9]{64}",\n\s+intel: "[a-f0-9]{64}"/,
        `sha256 arm:   "${digests.arm}",\n         intel: "${digests.intel}"`,
      );
    },
  },
];

let changed = false;

for (const project of projects) {
  const release = await getJSON(
    `https://api.github.com/repos/${project.repository}/releases/latest`,
  );
  const version = release.tag_name?.match(/^v(\d+\.\d+\.\d+)$/)?.[1];
  if (!version) {
    throw new Error(
      `${project.repository} latest tag is not a stable semantic version: ${release.tag_name}`,
    );
  }

  const digests = {};
  for (const [key, assetName] of Object.entries(project.assets(version))) {
    const asset = release.assets.find((candidate) => candidate.name === assetName);
    if (!asset) {
      throw new Error(`${project.repository} is missing release asset ${assetName}`);
    }
    digests[key] = await assetSHA256(asset);
  }

  const caskPath = resolve(root, project.cask);
  const before = await readFile(caskPath, "utf8");
  const after = project.update(before, version, digests);
  if (after !== before) {
    await writeFile(caskPath, after);
    changed = true;
    console.log(`Updated ${project.cask} to ${version}`);
  } else {
    console.log(`${project.cask} is current at ${version}`);
  }
}

const npmPackage = "@apoorvdarshan/crossposter";
const npmMetadata = await getJSON(
  "https://registry.npmjs.org/@apoorvdarshan%2fcrossposter/latest",
  { "User-Agent": headers["User-Agent"] },
);
const npmVersion = npmMetadata.version?.match(/^(\d+\.\d+\.\d+)$/)?.[1];
const npmTarball = npmMetadata.dist?.tarball;
if (!npmVersion || !npmTarball) {
  throw new Error(`${npmPackage} latest npm release is not a stable semantic version`);
}

const npmDigest = await urlSHA256(npmTarball);
const formulaPath = resolve(root, "Formula/crossposter.rb");
const formulaBefore = await readFile(formulaPath, "utf8");
const formulaAfter = replaceOnce(
  replaceOnce(
    formulaBefore,
    /url "https:\/\/registry\.npmjs\.org\/@apoorvdarshan\/crossposter\/-\/crossposter-[^"]+\.tgz"/,
    `url "${npmTarball}"`,
  ),
  /sha256 "[a-f0-9]{64}"/,
  `sha256 "${npmDigest}"`,
);
if (formulaAfter !== formulaBefore) {
  await writeFile(formulaPath, formulaAfter);
  changed = true;
  console.log(`Updated Formula/crossposter.rb to ${npmVersion}`);
} else {
  console.log(`Formula/crossposter.rb is current at ${npmVersion}`);
}

console.log(changed ? "Homebrew package updates written." : "All packages are already current.");

async function getJSON(url, requestHeaders = headers) {
  const response = await fetch(url, { headers: requestHeaders });
  if (!response.ok) {
    throw new Error(`GitHub API request failed (${response.status}): ${url}`);
  }
  return response.json();
}

async function assetSHA256(asset) {
  const declared = asset.digest?.match(/^sha256:([a-f0-9]{64})$/)?.[1];
  if (declared) return declared;

  const response = await fetch(asset.browser_download_url, {
    headers: {
      "User-Agent": headers["User-Agent"],
    },
    redirect: "follow",
  });
  if (!response.ok || !response.body) {
    throw new Error(`Could not download ${asset.name} for hashing`);
  }

  return streamSHA256(response.body);
}

async function urlSHA256(url) {
  const response = await fetch(url, {
    headers: { "User-Agent": headers["User-Agent"] },
    redirect: "follow",
  });
  if (!response.ok || !response.body) {
    throw new Error(`Could not download ${url} for hashing`);
  }

  return streamSHA256(response.body);
}

async function streamSHA256(body) {
  const hash = createHash("sha256");
  for await (const chunk of body) hash.update(chunk);
  return hash.digest("hex");
}

function replaceOnce(content, pattern, replacement) {
  if (!pattern.test(content)) {
    throw new Error(`Expected cask pattern was not found: ${pattern}`);
  }
  return content.replace(pattern, replacement);
}
