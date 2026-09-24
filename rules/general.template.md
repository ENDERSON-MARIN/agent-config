---
description: <TODO: descricao de 1 linha>
applyTo: "**/*"
---

# <PROJETO> - Regras Gerais (template)

> Fonte canonica para agentes que leem `.github/instructions/`.
> Preencha os TODOs e remova as secoes que nao se aplicam.

<TODO: 1 paragrafo — o que e o projeto e a stack principal.>

## Regras de trabalho

- Leia o contexto local e os arquivos relacionados antes de editar.
- Preserve a arquitetura, os padroes e as APIs publicas existentes.
- Corrija a causa raiz, mantendo o escopo da tarefa pequeno.
- <TODO: padroes de codigo e gerenciador de dependencias>.
- Nao reverta alteracoes existentes feitas pelo usuario, formatter ou outra automacao.
- Nao adicione secrets, `.env` ou dados reais ao repositorio; use apenas `.env.example` com valores ficticios.
- Ao alterar uma biblioteca externa, consulte a documentacao da versao instalada antes de assumir APIs ou assinaturas.

## <TODO: regra critica do dominio, se houver>

<TODO: ex: multi-tenancy — toda query em tabelas X deve filtrar tenantId via contexto do middleware, nunca do payload.>

## MCPs - uso sob demanda (economia de tokens)

- MCPs ficam negados no agente padrao (`permission: deny` em `opencode.json`); nunca chame tools `context7_*` / `playwright_*` diretamente.
- Biblioteca externa? Invoque o subagente `@docs` (Context7, liberado so nele): 1 rodada `resolve-library-id` + `query-docs` por lib, depois implemente sem reconsultar.
- Validar UI/fluxo no browser? Invoque o subagente `@ui-check` (Playwright, somente-leitura de codigo); nunca use browser para ler codigo — prefira `Read`/`Grep`.
- <TODO: listar MCPs pos-MVP> ficam com `enabled: false` (zero contexto). Se a tarefa exigir um deles, PARE e pergunte ao usuario antes de habilitar — nunca habilite sozinho.

## Git e comunicacao

- Nao faca commit ou crie branch sem solicitacao explicita.
- Quando um commit for solicitado, use Conventional Commits em minusculas (`feat:`, `fix:`, `test:`, `docs:`, `refactor:`).
