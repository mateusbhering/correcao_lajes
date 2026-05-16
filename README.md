# MAQLAJES — Correção de Lajes no AutoCAD

Macro em AutoLISP para padronização automática de textos e layers em projetos de lajes no AutoCAD.

## O que faz

1. **Cria o estilo de texto ROMANS** caso ainda não exista no desenho.
2. **Apaga objetos do layer `PA_DIV_BLO`** (divisórias de bloco desnecessárias).
3. **Move textos de armadura** para posições padrão (elementos com altura 10 não são movidos):
   - Layer `ARR_LONG_INF_TXT` → deslocamento de +25 mm em Y
   - Layer `ARR_TRANS_INF_TXT` → deslocamento de -25 mm em X
4. **Edita todos os textos selecionados** (TEXT e MTEXT):
   - Aplica o estilo **ROMANS**
   - Corrige alturas: `13.333 → 12.5` e `16.667 → 15.0`
   - Ajusta fator de largura: `0.95` para textos do layer `TEXTO_TABELAS`, `1.0` para os demais
   - Insere espaço antes de `c/` e `c=` no conteúdo do texto

## Como usar

1. Carregue o arquivo no AutoCAD via `APPLOAD` ou arrastando o `.lsp` para o desenho.
2. Execute o comando `MAQLAJES` na linha de comando.
3. Selecione os objetos da laje quando solicitado e pressione Enter.

## Requisitos

- AutoCAD com suporte a AutoLISP
- Fonte `romans.shx` disponível no caminho de suporte do AutoCAD
