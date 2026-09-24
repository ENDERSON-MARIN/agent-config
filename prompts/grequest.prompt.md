---
description: Revisa as mudanças e abre um pull request no GitHub
agent: agent
---

Revise as mudanças da branch atual e abra um pull request no GitHub.

Passos:
1. Rode `git status`, `git branch --show-current` e `git log --oneline -10` para contexto.
2. Rode `git diff origin/main...HEAD --stat` (ou contra a branch base correta) e revise o diff completo. Se encontrar algo errado (secrets, arquivos temporários, mudanças não relacionadas), PARE e reporte antes de criar o PR.
3. Verifique se a branch já foi enviada ao remoto; se não, faça push com `git push -u origin <branch>` primeiro.
4. Crie o PR com `gh pr create --title "<título>" --body "<resumo>"`. Use o título informado pelo usuário se houver; caso contrário, sugira um título no padrão conventional em minúsculas.
5. Retorne a URL do PR criado.

Regras:
- A base padrão é `main` — confirme se o projeto usa outra.
- O corpo do PR deve resumir: o que mudou, por quê e como validar.
- Se `gh` não estiver disponível, informe como instalar/autenticar (`gh auth login`) em vez de falhar silenciosamente.
