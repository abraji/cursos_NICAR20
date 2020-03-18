library(tidyverse)
library(janitor)
library(lubridate)


# para retomar de onde paramos, vamos carregar de volta nossos dados limpos de 'employees'
employees <- read_rds("data/cleaned/employees.rds")


# step 1: identificar linhas com exclusividade --------------------------------------------------

# para entender bem seus dados, você quer saber qual variável ou combinação de variáveis,
# pode ser usado para identificar exclusivamente cada linha.

# geralmente, sabemos que os dados dos funcionários têm uma linha por funcionário por ano.
# mas especificamente, quais variáveis podemos usar para identificar cada funcionário/ano único?

employees %>% nrow() # quantas linhas
employees %>% select(uniqueid) %>% n_distinct() # quantos uniqueid únicos existem
employees %>% select(year,uniqueid) %>% n_distinct() # quantos uniqueid únicos existem em cada ano

# repetições >1 em cada ano de uniqueid
employees %>% 
  group_by(year,uniqueid) %>% 
  filter(n()>1) %>% 
  View()

# essa é apenas uma maneira de remover duplicatas e é específica da nossa situação,
# onde não nos importamos com quais duplicatas mantemos.
employees_deduped <- employees %>% 
  group_by(year,uniqueid) %>% 
  filter(row_number()==1) %>% 
  ungroup()

employees_deduped %>% nrow()



# step 2: junte dois conjuntos de dados! --------------------------------------------------------------

# vamos ler dados sobre mandados ativos do tribunal da cidade
# leia mais sobre os dados aqui: https://data.brla.gov/Public-Safety/City-Court-Warrants/3j5u-jyar 
warrants <- read_csv("data/raw/baton_rouge/warrants_2020.01.27_18.45.30.csv") %>% clean_names() 

# crie um novo objeto chamado employee_2019 que tenha apenas dados de 2019
employees_2019 <- employees %>% filter(year==2019)

head(warrants$name)
head(employees_2019$full_name)

# junte os dois para encontrar a sobreposição
overlap <- inner_join(
  warrants,
  employees_2019,
  by=c("name"="full_name")
)
# join types: https://dplyr.tidyverse.org/reference/join.html


# case_when() é uma função útil para recodificar valores.
overlap <- overlap %>% 
  mutate(
    case_type_desc = case_when(
      case_type=="CMISD" ~ "Criminal Misdemeanor", 
      case_type=="DV" ~ "Domestic Violence", 
      case_type=="CCTRAF" ~ "Traffic Offense", 
      case_type=="PP" ~ "Partial Payment Account", 
      case_type=="CCDWI" ~ "Driving While Intoxicated",
      TRUE ~ "other"
    )
  )


overlap %>% count(case_type,case_type_desc)

# filtra apenas dois valores
overlap %>% filter(case_type_desc %in% c("Driving While Intoxicated","Domestic Violence")) %>% View()
