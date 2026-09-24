// Regenera manifests/*.json com sha256 do conteudo atual.
// Uso: node scripts/gen-manifests.js [--source owner/repo]
// O manifesto trava versoes; o instalador confere o hash antes de copiar.
const fs = require("fs");
const path = require("path");
const crypto = require("crypto");

const root = path.join(__dirname, "..");
const source = process.argv.includes("--source")
  ? process.argv[process.argv.indexOf("--source") + 1]
  : "ENDERSON-MARIN/agent-config";

const sha = (f) => crypto.createHash("sha256").update(fs.readFileSync(f)).digest("hex");
const list = (dir, ext) =>
  fs.existsSync(path.join(root, dir))
    ? fs.readdirSync(path.join(root, dir)).filter((f) => f.endsWith(ext)).sort()
    : [];

const skills = {};
const lockPath = path.join(root, "manifests", "skills-lock.json");
let external = {};
if (fs.existsSync(lockPath)) {
  try {
    const prev = JSON.parse(fs.readFileSync(lockPath, "utf8")).skills || {};
    // Preserva entradas externas (referencias a repos terceiros): so o lock
    // local e regenerado; refs externas sao curadoria manual.
    const localDirs = new Set(fs.existsSync(path.join(root, "skills")) ? fs.readdirSync(path.join(root, "skills")) : []);
    for (const [k, v] of Object.entries(prev)) {
      if (!localDirs.has(k)) external[k] = v;
    }
  } catch {}
}
for (const d of fs.existsSync(path.join(root, "skills")) ? fs.readdirSync(path.join(root, "skills")).sort() : []) {
  const f = path.join("skills", d, "SKILL.md");
  if (fs.existsSync(path.join(root, f))) skills[d] = { source, sourceType: "github", skillPath: f.replace(/\\/g, "/"), computedHash: sha(path.join(root, f)) };
}
fs.writeFileSync(path.join(root, "manifests", "skills-lock.json"), JSON.stringify({ version: 1, skills: { ...external, ...skills } }, null, 2) + "\n");

const section = (dir, ext) => {
  const assets = {};
  for (const f of list(dir, ext)) assets[f] = { path: path.join(dir, f).replace(/\\/g, "/"), computedHash: sha(path.join(root, dir, f)) };
  return { version: 1, source, assets };
};
fs.writeFileSync(path.join(root, "manifests", "commands.json"), JSON.stringify(section("commands", ".md"), null, 2) + "\n");
fs.writeFileSync(path.join(root, "manifests", "prompts.json"), JSON.stringify(section("prompts", ".prompt.md"), null, 2) + "\n");
fs.writeFileSync(path.join(root, "manifests", "agents.json"), JSON.stringify(section("agents", ".md"), null, 2) + "\n");
fs.writeFileSync(path.join(root, "manifests", "mcp.json"), JSON.stringify(section("mcp", ".json"), null, 2) + "\n");
fs.writeFileSync(path.join(root, "manifests", "rules.json"), JSON.stringify(section("rules", ".md"), null, 2) + "\n");

console.log("manifests atualizados em manifests/ (source=" + source + ")");
