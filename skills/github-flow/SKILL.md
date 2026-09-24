---
name: github-flow
description: Fluxo GitHub e git para tarefas repetitivas (branch, commit, push, pull, PR). Use quando o usuário pedir gbranch, gcommit, gpush, gpull, grequest ou qualquer operação de branch, commit, push, pull ou pull request.
---

# GitHub Flow

Convenções para operações git/GitHub em qualquer projeto.

## Branches (`gbranch`)

- Nomes em minúsculas com prefixo conventional: `feat/...`, `fix/...`, `refactor/...`, `test/...`, `docs/...`.
- Criar com `git checkout -b <nome>` ou `git switch -c <nome>`.
- Nunca crie branch com a árvore suja sem confirmar com o usuário primeiro.

## Commits (`gcommit`)

- Mensagens em minúsculas, Conventional Commits: `feat:`, `fix:`, `refactor:`, `test:`, `docs:`.
- Antes de commitar, inspecione `git status` e `git diff --stat`.
- Adicione apenas arquivos pretendidos (`git add <arquivos>`); nunca `git add -A` sem conferir.
- Nunca commite `.env` ou secrets — apenas `.env.example` com valores fictícios.
- Mensagem vazia: sugira uma pelo diff e peça confirmação antes de commitar.

## Push (`gpush`)

- Primeira vez: `git push -u origin <branch>`; depois: `git push`.
- Nunca use `--force` sem pedido explícito.

## Pull (`gpull`)

- Com árvore suja: pare e pergunte sobre `git stash` antes; nunca stash sem confirmação.
- `git pull` (ou `git pull origin <branch>` sem upstream); confirme com `git log --oneline -5`.
- Conflito: pare e mostre os arquivos em conflito em vez de resolver sozinho.

## Pull Requests (`grequest`)

- Base padrão `main` (confirmar se o projeto usa outra).
- Revise o diff completo antes de abrir o PR; reporte problemas em vez de prosseguir.
- Use `gh pr create --title --body`; corpo com o que mudou, por quê e como validar.
- Retorne sempre a URL do PR.

## Segurança

- Commit, push e PR somente quando explicitamente solicitados.
- Push rejeitado: mostrar o erro e sugerir próximos passos, nunca forçar.
