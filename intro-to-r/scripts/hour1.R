
# step 0: carregar pacotes ---------------------------------------------------


# quando você usa um pacote em um computador pela primeira vez, é necessário instalá-lo
# install.packages("tidyverse")
# para esta classe, os pacotes que precisamos já devem estar instalados

library(tidyverse)
library(janitor)
library(lubridate)




# step 1: ler dados ----------------------------------------------------

# read_csv() é do pacote readr, que faz parte do tidyverse
employees <- read_csv("data/raw/baton_rouge/employee_salaries.csv")

# Para sua informação, esses dados são de https://data.brla.gov/Government/City-Parish-Employee-Annual-Salaries/g9vh-zeiw 


# sua vez!  
# leia o arquivo employee_salaries_legacy.csv and assign it to an object named employees_legacy
# Para sua informação, esses dados são de https://data.brla.gov/Government/Legacy-City-Parish-Employee-Annual-Salaries/g5c2-myyj




# step 2: o que são esses dados?! ----------------------------------------------

# existem várias funções úteis para explorar os dados que acabamos de carregar
colnames(employees) #retorna os nomes das colunas

str(employees) #exibe de maneira compacta a estrutura interna de um objeto R

dim(employees) #exibe ou define a dimensão de um objeto - número de linhas e colunas

nrow(employees) #número de linhas

head(employees) #mostra seis primeiras linhas

employees

# bônus: o que usamos na hour0 para abrir aquele belo visualizador interativo?
# clique duas vezes em employees em Global Environment ou execute:
# View(employees)



# step 3: limpe nomes de colunas ----------------------------------------------

# Some of our columns are named things like `LAST NAME`
# R tecnicamente permitirá isso, mas nomes de colunas com espaços são MUITO irritantes para trabalhar com.
# vamos usar clean_names() do pacote janitor para tornar os nomes das colunas mais bonitos. (substitua espaços por _, faça minúsculas)

employees <- employees %>% clean_names()

# %>% é chamdo de 'pipe' no the tidyverse. 
# (não é o mesmo que um pipe como este |)
# isto permite conectar operações e funções
# se você estiver lendo código em voz alta, pense nisso como dizendo 'então'

# obtenha ajuda com uma função dentro do RStudio
?clean_names
?colnames

# sua vez! 
# olhe os nomes das colunas agora para ver como eles mudaram.





# step 4: tabelas dinâmicas ---------------------------------------------------

# uma ótima maneira de explorar seus dados, especialmente colunas sem muitos valores diferentes, é a função count()
# é bem parecido com tabelas dinâmicas no excel, se você estiver familiarizado com isso.

employees %>% count(year)


# sua vez! 
# quais departamentos estão nos dados?



# você pode especificar a ordem de classificação que count() usa
employees %>% count(department_number,sort=TRUE)
# você também pode pedir para mostrar todas as linhas
employees %>% count(department_number,sort=TRUE) %>% print(n=Inf)
# e você pode obter contagens para combinações de 2 ou mais variáveis
employees %>% count(department_number,department_name,sort=TRUE) %>% print(n=Inf)





# step 5: explorar dados com verbos dplyr -----------------------------------

# essas funções são todas do pacote dplyr, que faz parte do tidyverse


# existem 39 variáveis em nossos dados! Às vezes, queremos apenas olhar para alguns deles.
# select() permite escolher apenas algumas variáveis
employees %>% select(year, last_name, first_name, department_name, base_pay)


# vamos encontrar o funcionário com o menor salário base: (
# arrange() define a ordem das linhas. (como 'classificar' no excel.)
# passe arrange() a variável que você deseja ordenar.
employees %>% arrange(base_pay)

# podemos encadear uma View () se for melhor para olhar.
employees %>% arrange(base_pay) %>% View()

# ou encadear um select()
employees %>% 
  arrange(base_pay) %>%
  select(year, last_name, first_name, department_name, base_pay)

# sua vez! organizar pelo sobrenome


#por padrão, organizar pedidos em ordem crescente, mas você também pode organizar ordens em ordem decrescente
employees %>% 
  arrange(desc(base_pay)) %>%
  select(year, last_name, first_name, department_name, base_pay)

# e você pode pedir por várias variáveis
employees %>% 
  arrange(last_name, first_name) %>%
  select(year, last_name, first_name, department_name, base_pay)



# finalmente, você pode escolher apenas manter algumas linhas, usando filter()
# mantenha apenas 2019!
employees %>% 
  filter(year==2019) %>% 
  arrange(last_name, first_name) %>%
  select(year, last_name, first_name, department_name, base_pay)

# mantenha apenas 2019, para pessoas com sobrenome Jones
employees %>% 
  filter(year==2019 & last_name=="JONES") %>% 
  arrange(last_name, first_name) %>%
  select(year, last_name, first_name, department_name, base_pay)


# sua vez! manter apenas funcionários do departamento de polícia em 2019


# sua vez! use filter() e count() e veja quais cargos existem no departamento de polícia, em 2019




