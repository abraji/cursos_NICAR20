library(tidyverse)
library(janitor)
library(lubridate)
library(scales)


# vamos começar de novo reimportando os dados
employees <- read_csv("data/raw/baton_rouge/employee_salaries.csv") %>% clean_names()



# step 1: crie novas variáveis/colunas ----------------------------------------------

# use mutate() do pacote dplyr para fazer novas variáveis

employees <- employees %>% 
  mutate(
    ot_pay_pct = total_ot_pay/base_pay,    
    extra_pay_pct = (gross_pay-base_pay)/base_pay
  )

# vamos ver como funcionou olhando algumas linhas
employees %>% 
  select(last_name, base_pay, total_ot_pay, gross_pay, ot_pay_pct, extra_pay_pct)


# sua vez! 
# use verbos do dplyr (select, filter, arrange) para procurar o funcionário que recebeu o pagamento de mais horas extras em 2019


# procure o funcionário que recebeu o pagamento de mais horas extras em 2019, como uma porcentagem do salário-base.




# step 2: datas -----------------------------------------------------------

str(employees)

# current_hire_date e employment_end_date, ambos contêm informações de data, mas estão sendo armazenados como cadeias de texto ('chr')

# vamos usar o pacote lubridate para transformá-los em datas
# (lubridate faz parte do conjunto, então você precisa carregar o pacote separadamente)
# mdy - mês, dia, ano
employees <- employees %>% 
  mutate(
    current_hire_date_clean = mdy(current_hire_date),
    employment_end_date_clean = mdy(employment_end_date)
  )

employees %>% 
  select(year,last_name,current_hire_date,current_hire_date_clean,employment_end_date,employment_end_date_clean,employment_status) %>% 
  View()

str(employees)

# agora podemos classificar as variáveis de data

# sua vez! 
# encontre o funcionário mais antigo da biblioteca em 2019





# step 3: strings ---------------------------------------------------------

# e se quisermos o nome completo em uma variável, em vez de separados em primeiro e último?
# o pacote stringr (parte de tidyverse) é útil para trabalhar com strings (como variáveis de caracteres)
# str_c() concatinates strings
employees <- employees %>% 
  mutate(
    full_name = str_c(last_name,first_name)
  )

employees %>% 
  select(last_name,first_name,full_name) 

# hummm. não parece muito certo!
employees <- employees %>% 
  mutate(
    full_name = str_c(last_name,first_name,sep=", ")
  )

employees %>% 
  select(last_name,first_name,full_name) 



# step 4: resumir ---------------------------------------------------------------

departments_2019 <- employees %>% 
  filter(year==2019) %>%
  group_by(year,department_name) %>% 
  summarize(
    employees = n(),
    base_pay=sum(base_pay),
    total_ot_pay=sum(total_ot_pay)
  ) %>% 
  mutate(
    ot_pay_pct = total_ot_pay/base_pay
  ) 




# step 5: visualizar -------------------------------------------------------


# viz 1: vamos ver quanto cada departamento gasta em horas extras
# gráfico de barras como ponto de partida
ggplot(data=departments_2019, aes(x=department_name,y=ot_pay_pct)) +
  geom_col() 


# final completo da viz com melhorias
department_barchart <- departments_2019 %>%
 mutate(department_name=str_to_title(department_name)) %>%
 ggplot(aes(x=reorder(department_name,ot_pay_pct),y=ot_pay_pct)) +
 geom_col() +
 scale_y_continuous(labels=percent) +
 labs(x=NULL,y="Overtime Pay") +
 coord_flip() +
 theme_minimal()

# save it out as an image :)
ggsave(
  plot=department_barchart,
  filename="visualizations/department_barchart.jpeg"
)


# viz 2: distribuição de salários
# histograma como ponto de partida
employees %>% 
  filter(year==2019) %>% 
  ggplot(aes(x=gross_pay)) +
  geom_histogram()

# sua vez! você pode fazer parecer melhor?


# facetas
employees %>% 
  filter(year==2019 & department_name %in% c("POLICE DEPARTMENT","LIBRARY BOARD OF CONTROL","FIRE DEPARTMENT")) %>% 
  ggplot(aes(x=gross_pay)) +
  geom_histogram() +
  facet_grid(department_name~.)




# replicar com dados antigos ----------------------------------------------------

# sua vez!
# leia o arquivo employee_salaries_legacy.csv e atribua a um objeto chamado employees_legacy

# que anos são cobertos?

# você pode calcular a porcentagem de horas extras para cada departamento?

# você pode recriar nosso gráfico de barras para 2008?






# step 7: salve seus dados --------------------------------------------------

# isso é útil se você deseja compartilhar seus dados com um colega de trabalho ou voltar mais tarde!

# salve como csv
write_csv(employees, "data/cleaned/employees.csv")
# save como rds (R data format)
write_rds(employees, "data/cleaned/employees.rds")
# salve o department-level resumo que fizemos
write_csv(departments_2019, "data/cleaned/departments_2019.csv")


