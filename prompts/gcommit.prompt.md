---
description: Cria um commit git seguindo Conventional Commits
agent: agent
---

Crie um commit git com a mensagem informada pelo usuário.

Passos:
1. Rode `git status` e `git diff --stat` para inspecionar o que será commitado.
2. Se houver arquivos não relacionados à mudança (ex: `.env`, secrets, arquivos temporários), NÃO os inclua — avise ao usuário.
3. Adicione apenas os arquivos pretendidos com `git add <arquivos>`. Nunca use `git add -A` sem conferir antes.
4. Crie o commit com `git commit -m "<mensagem>"`.
5. Mostre o resumo do commit criado (`git show --stat HEAD`).

Regras:
- Mensagem em letras minúsculas, prefixo conventional: `feat:`, `fix:`, `refactor:`, `test:`, `docs:`.
- Nunca commite `.env` ou secrets — apenas `.env.example` com valores fictícios.
- Se a mensagem não foi informada, analise o diff e sugira uma mensagem, mas peça confirmação antes de commitar.
