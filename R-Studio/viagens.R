?read.csv
?read_csv

install.packages("readr")
library(readr)
library(dplyr)

viagens <- read_delim(file="~/EscolaVirtual/R-Studio/2019_viagem.csv",
                      col_names=TRUE,
                      delim=";",
                      locale=locale(encoding = "Windows-1252")
                     )

?View

glimpse(viagens)
View(viagens)
head(viagens)
dim(viagens)


?summary

summary(viagens)
summary(viagens$`Valor passagens`)

?as.Date

viagens$`Período - Data de início` <- as.Date(
  viagens$`Período - Data de início`, "%d/%m/%Y")

?format

viagens$data.inicio.formatada <- format(
  viagens$`Período - Data de início`, "%Y-%m")

head(viagens$data.inicio.formatada)
tail(viagens$data.inicio.formatada)

hist(viagens$`Valor passagens`)

passagens_filtro <- viagens %>%
  select(`Valor passagens`) %>%
  filter(`Valor passagens` >= 200 & `Valor passagens` <= 5000)

passagens_filtro
hist(passagens_filtro$`Valor passagens`)

summary(viagens$`Valor passagens`)

?boxplot

boxplot(viagens$`Valor passagens`)

?sd

sd(viagens$`Valor passagens`)


# Verificar se existem valores não preenchidos no dataframe

?is.na
?colSums

colSums(is.na(viagens))


# Verificar a quantidade de categorias da coluna Situção

viagens$Situação <- factor(viagens$Situação)
str(viagens$Situação)

# Verificar quantidade de registros em cada categoria
table(viagens$Situação)

# Obtendo valores em percentual de cada categoria
prop <- prop.table(table(viagens$Situação))*100
formatted_prop <- sprintf("%.2f%%", prop)
print(formatted_prop, quote=FALSE)


# Criando dataframe com 15 órgãos que gastam mais

p1 <- viagens %>%
  group_by(`Nome do órgão superior`) %>%
  summarise(`Valor Gasto` = sum(`Valor passagens`)) %>%
  arrange(desc(`Valor Gasto`)) %>%
  top_n(15)

p1$`Valor Gasto` <- formatC(
  p1$`Valor Gasto`,
  format = "f",
  big.mark = ".",
  decimal.mark = ",",
  digits = 2)

p1$`Valor Gasto` <- paste0("R$ ", p1$`Valor Gasto`)

p1


# Alterando os nomes das colunas

names(p1) <- c("Órgão", "Gastos")

p1

library(ggplot2)

#Criando o gráfico
ggplot(p1, aes(x = reorder(Órgão, Gastos), y = Gastos))+
  geom_bar(stat = "identity") + 
  coord_flip() +
  labs(x = "Gastos", y = "Órgão")


# Criando dataframe com 15 cidades que gastam mais
p2 <- viagens %>%
  group_by(Destinos) %>%
  summarise(`Valor Gasto` = sum(`Valor passagens`)) %>%
  arrange(desc(`Valor Gasto`)) %>%
  top_n(15)

p2$`Valor Gasto` <- formatC(
  p2$`Valor Gasto`,
  format = "f",
  big.mark = ".",
  decimal.mark = ",",
  digits = 2)

p2$`Valor Gasto` <- paste0("R$ ", p2$`Valor Gasto`)

names(p2) <- c("Destino", "Gastos")

p2

#Criando o gráfico
ggplot(p2, aes(x = reorder(Destino, Gastos), y = Gastos)) +
  geom_bar(stat = "identity", fill = "#0ba791") +
  geom_text(aes(label = Gastos), vjust = 0.3, size = 3) +
  coord_flip() +
  labs(x = "Gastos", y = "Destino")

options(scipen=999)


# Qual é a quantidade de viagens por mês?
p3 <- viagens %>%
  group_by(data.inicio.formatada) %>%
  summarise(qtd = n_distinct(`Identificador do processo de viagem`))

head(p3)

#Criando o gráfico
ggplot(p3, aes(x=data.inicio.formatada, y=qtd, group=1)) +
  geom_line() +
  geom_point()


install.packages("rmarkdown")
install.packages('tinytex')
library(tinytex)

tinytex::install_tinytex()
