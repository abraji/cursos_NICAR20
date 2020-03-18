# por enquanto, não se preocupe com esta parte - bônus sobre visualização
library(tidyverse)
USArrests <- USArrests %>% 
  rownames_to_column(var = "state")

# look at the data
View(USArrests)

# Esse conjunto de dados contém estatísticas, em detenções por 100.000 habitantes por agressão, assassinato e estupro em cada um dos 50 estados dos EUA em 1973. Também é fornecida a porcentagem da população que vive em áreas urbanas.
# Murder 	 Murder arrests (per 100,000)
# Assault  Assault arrests (per 100,000)
# UrbanPop Percent urban population
# Rape 	 	 Rape arrests (per 100,000) 


ggplot(data=USArrests, aes(x=Assault,y=Murder)) +
  geom_point() +
  labs(x="Assault Arrests (per 100,000 people)",y="Murder Arrests (per 100,000 people)") +
  geom_smooth(method="lm") +
  theme_minimal()


ggplot(data=USArrests, aes(x=reorder(state,Murder),y=Murder)) +
  geom_col() +
  labs(x=NULL,y=NULL,title="Murder Arrests in 1973",subtitle="per 100,000 people") +
  coord_flip() +
  theme_minimal()




