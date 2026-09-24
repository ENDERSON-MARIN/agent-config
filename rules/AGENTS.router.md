<!-- Template de router AGENTS.md. Copie para a raiz do projeto e preencha
     os TODOs. Regra de ouro: este arquivo fica enxuto (~40-60 linhas);
     o detalhe mora em <canonico>/ e e lido sob demanda com Read. -->

# <PROJETO> — router de instructions

<1-2 linhas: o que e o projeto, stack principal, layout de pastas>.

> Fonte canonica de regras: `<CANONICO>/*.md` (tambem carregado via `opencode.json`).
> NAO pre-carregar tudo. Use `Read` sob demanda conforme a tabela abaixo.

## Regra critica (sempre vale)

<TODO: 3-5 linhas com a invariante inegociavel do projeto.
Ex: tenant isolation, regra de seguranca, constraint de dominio.
Se nao houver, remova esta secao.>

## Roteamento por tarefa

| Tarefa | Ler com `Read` antes de codar |
| --- | --- |
| Qualquer tarefa | `<CANONICO>/general.instructions.md` |
| <TODO: area 2, ex: produto/UX> | `+ <CANONICO>/product.instructions.md` |
| <TODO: area 3, ex: backend> | `+ <CANONICO>/tech.instructions.md` + `structure.instructions.md` |
| <TODO: area 4, ex: frontend> | `+ <CANONICO>/tech.instructions.md` + `structure.instructions.md` |
| `*.test.*`, `tests/`, `__tests__/` | `+ <CANONICO>/testing.instructions.md` |

## Minimo operacional

- <TODO: gerenciador de pacotes e cwd correto; ex: pnpm, nunca npm/yarn>.
- <TODO: comando de teste padrao; ex: `pnpm vitest run --reporter=verbose "<filtro>"`>.
- <TODO: padroes: kebab-case, TypeScript com interfaces, etc>.
- Commits so quando pedido, Conventional Commits minusculas (`feat:`, `fix:`, `test:`, `docs:`, `refactor:`).
- Biblioteca externa? Invocar subagente `@docs` (Context7); validar UI no browser? `@ui-check` (Playwright). Nunca chamar tools MCP direto.
- MCPs pos-MVP (<TODO: listar>) desabilitados — se precisar, perguntar ao usuario antes de habilitar.
