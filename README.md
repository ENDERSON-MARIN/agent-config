# agent-config — stack agentico central

Repo central de configuracoes de agentes (opencode, VSCode/Copilot, Kiro e futuros).
Clone em qualquer computador e rode o instalador para replicar o ambiente.

## Instalacao em 1 comando (no projeto destino)

```powershell
# Windows — a partir do diretorio do projeto:
& ..\agent-config\scripts\install-agent.ps1 -Source ..\agent-config -Target . -Ide all
```

Opcoes: `-Ide opencode|vscode|all` (padrao `all`), `-Force` para sobrescrever arquivos existentes.

## O que instala

| Origem (central) | Destino (projeto) | Lazy? |
| --- | --- | --- |
| `commands/*.md` | `.opencode/commands/` | sim, no invoke |
| `prompts/*.prompt.md` | `.github/prompts/` | sim |
| `agents/*.md` | mescla `agent` no `opencode.json` | sim, via `@` |
| `mcp/base.opencode.json` | mescla `mcp`+`permission` no `opencode.json` | sim, deny-by-default |
| `mcp/base.vscode.json` | `.vscode/mcp.json` | sim |
| `rules/*` | templates para `AGENTS.md` / `.github/instructions/` | sim, router |
| `skills/*/SKILL.md` | via `manifests/skills-lock.json` (instalador roda `npx skills add` por entrada) | sim, por description |

## Regras do central

- Sem secrets: so placeholders `{env:...}` / `${env:...}`. Valores vivem em env vars da maquina (ver `env.agent.example`).
- MCPs pos-MVP sempre `enabled: false` (zero contexto); habilitar exige pergunta ao usuario.
- Promover asset novo: use o command `gpromote` ( so entra com prova de uso em projeto real).
- Auditar defasagem: command `gcheck-updates`.
- Regenerar hashes apos qualquer edicao: `node scripts/gen-manifests.js`.
