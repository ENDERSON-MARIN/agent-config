---
description: Lista configs agentic defasadas em relacao ao agent-config central
---

Compare os hashes pineados neste projeto com o `main` do repo central `agent-config` e reporte o que esta defasado.

Passos:
1. Localize o checkout do central em `$ARGUMENTS` (padrao: `../agent-config`); se ausente, use `git ls-remote` ou `curl` nos manifestos do remoto — nunca falhe silenciosamente, informe o que faltou.
2. Compare: `skills-lock.json` -> `manifests/skills-lock.json`, commands instalados -> `manifests/commands.json`, presets MCP -> `manifests/mcp.json`.
3. Liste por asset: atual (hash igual) vs defasado (hash diferente) vs ausente no projeto.
4. Para cada defasado, mostre o diff do asset (`diff`/`git diff --no-index`) e sugira bump individual — nunca atualize tudo sem confirmacao.

Se `$ARGUMENTS` estiver vazio, pergunte o caminho do checkout do `agent-config`.
