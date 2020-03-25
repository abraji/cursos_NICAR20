## NICAR 2020: Localizando uma história: Usando o processamento de linguagem natural (avançado)

### Descrição

Já se sentiu perdido debruçado sobre um enorme arquivo? Deseja criar histórias interessantes de redes sociais, arquivos de bate-papo ou fóruns com facilidade (relativa)?

Por que não tentar usar um pouco de processamento de linguagem natural (PNL ou NLP em inglês)!

Esta sessão mostrará como aplicar uma mistura de linguística e IA ao mundo da Internet baseado em texto. Você aprenderá alguns conceitos básicos da PNL e como aplicá-los a textos online usando o pacote spacy do Python. Você poderá sair desta sessão pronto para começar a pesquisar seus dados!

Para tirar o máximo proveito desta sessão, familiaridade com Python é ideal.

O material deste workshop é baseado no currículo do Advanced Data Journalism, co-ministrado por Lam Thuy Vo e Maddy Varner na [Craig Newmark Graduate School of Journalism](https://www.journalism.cuny.edu/), Outono 2019.

- Os slides da apresentação deste workshop podem ser encontrados [aqui](https://docs.google.com/presentation/d/135HEZHdgMt-kAuPR1uE6r_TC1ZKSUOgEMh7monZAC-o/edit?usp=sharing)
- Um mirror disto está disponível [aqui](https://github.com/varner/nicar2020-nlp-workshop)
- Deseja ainda MAIS maneiras de investigar a redes sociais? Confira o livro de Lam, [_Mining Social Media_](https://nostarch.com/miningsocialmedia)!

### Instalação

Este workshop usa Jupyter notebooks e python3. Para instalar os pacotes relevantes, execute:

`pip install -r requirements.txt`

Este workshop usa `spacy`, um pacote de processamento de linguagem natural para python. Utilizamos um modelo de inglês pré-treinado. Para baixar, execute:

`python3 -m spacy download en_core_web_sm`

Para instalar o modelo para português instale:

`python3 -m spacy download pt_core_news_sm`
