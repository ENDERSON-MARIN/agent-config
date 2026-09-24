---
description: Promove um asset local para o repo central agent-config
---

Promova um asset (skill, command, prompt, agent, preset MCP ou template de rule) para o repo central `agent-config` em `$ARGUMENTS` (caminho do checkout local; padrao: `../agent-config`).

Passos:
1. Identifique o tipo pelo caminho/conteudo: `SKILL.md` -> `skills/<nome>/`, command opencode -> `commands/`, prompt Copilot -> `prompts/`, subagente -> `agents/`, preset MCP -> `mcp/`, template -> `rules/`.
2. Valide que o asset foi usado e testado em pelo menos um projeto real — sem prova de uso, PARE e avise (o central nao e lixeira de experimentos).
3. Copie para a pasta correspondente, removendo especificidades do projeto de origem (generalize; especifico fica no overlay do projeto).
4. Rode `node scripts/gen-manifests.js` no `agent-config` para atualizar os hashes.
5. Rode a validacao (`node -e` checando JSONs + grep de secrets, como em `docs/agent-setup.md`).
6. Sugira mensagem de commit conventional em minusculas (`feat:` para asset novo, `fix:` para correcao) e peca confirmacao antes de commitar — nunca commite secrets.

Se `$ARGUMENTS` estiver vazio, pergunte o caminho do checkout do `agent-config`.
