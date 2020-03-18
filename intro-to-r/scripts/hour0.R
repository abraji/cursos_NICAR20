# bem-vindo(a) ao R!
# este é um script, salvo como 'hour0.R' no seu computador. é apenas um arquivo de texto simples.
# as linhas que começam com # são comentários. linhas que não começam com # são código!


# código pode ser tão simples quanto uma operação aritmética
1+2

# tente executar o código na linha 7 acima (1+2) ou todos os demais quiser
# eu recomendo colocar o cursor na linha 7 e pressione Command + Enter (Mac) ou Ctrl + Enter (Windows/Linux)


# código também pode envolver o uso de uma *FUNCTION*, como no excel
sum(1,2)
# as coisas que colocamos dentro da função são chamadas *ARGUMENTS*

# também há algo chamado *OBJECT*
# cada objeto tem um nome ('my_special_number') e algo que ele armazena.
# neste caso, nosso objeto my_special_number apenas armazena um único valor numérico, 1
# execute as duas linhas abaixo e veja que o objecto é criado
# e pode agora ser chamado sozinho, bem como fica listado em Global Environment-values
my_special_number <- 1

my_special_number

# você pode usar objetos como argumentos para funções
sum(my_special_number,2)

# O RStudio completará automaticamente os nomes de funções e objetos para você!
# digite 'my_' or 'sum' e veja o que acontece


# você vê um pop-up? pressione enter ou tab para que o RStudio preencha o resto


# nomes de funções e objetos fazem distinção entre maiúsculas e minúsculas, podem dar erro por isso
Sum(my_special_number,2)

MY_SPECIAL_NUMBER


# Objetos também podem armazenar um conjunto de dados (dataset)!
# No R, os datasets podem ser armazenados em alguns formatos diferentes, incluindo 'matrix', table', 'tibble', 'data.table', e 'data.frame'
# Por enquanto, não se preocupe. Geralmente você pode tratá-los da mesma forma.
class(HairEyeColor)
# HairEyeColor vem embutido com o R, e é por isso que não está listado no seu ambiente

# Vamos dar uma olhada nesses dados!
# usaremos a função View
View(HairEyeColor)
