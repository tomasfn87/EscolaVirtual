message <- "De starka kvinnor springer ned gatan."
print(message, quote = FALSE)

# This is a comment.

?print


# Installing and importing packages

install.packages("ggplot2")

library(ggplot2)

?ggplot2


# Vectors

cidade <- c("Araras",
             "Leme",
             "Rio Claro",
             "Conchal",
             "Caconde",
             "Mogi Mirim"
            )

cidade

temperatura <- c(32,
                 29,
                 30,
                 31,
                 30,
                 31,
                 33
                )

regiao <- c(1,
            2,
            2,
            1,
            3,
            2,
            1
           )

?c()

# Acessando elementos
cidade[1]
cidade[6]

# Acessando intervalo de elementos
cidade[2:5]

# Copiando um vetor

cidade1 <- cidade

# Excluindo segundo elemento da consulta
cidade1[-2]

# Alterando um elemento do vetor
cidade1[2] <- "Limeira"

# Acrescentando um elemento ao vetor
cidade[7] <- "Limeira"

cidade1 <- NULL
cidade1


# Factors

UFs.Sudeste <- factor(c("SP", "MG", "RJ", "ES"))
UFs.Sudeste

grau.instrucao <- factor(c("Nivel Médio",
                           "Superior",
                           "Nivel Médio",
                           "Fundamental"),
                         levels = c("Fundamental",
                                    "Nivel Médio",
                                    "Superior"),
                         ordered = TRUE)

grau.instrucao


# List

?list()

pessoa <- list(sexo = "M", cidade = "São Paulo", idade = 36)

pessoa

# Acessando primeiro elemento da lista
pessoa[1]
pessoa["sexo"]

# Acessando valor do primeiro elemento da lista
pessoa[[1]]
pessoa[["sexo"]]

pessoa[["cidade"]] <- "Uppsala"
pessoa[["cidade"]]
pessoa[["idade"]] <- NULL

pessoa[c("cidade", "sexo")]

cidades <- list(cidade      = cidade,
                temperatura = temperatura,
                regiao      = regiao
               )

cidades


# Dataframes

# Criando dataframe com vetores

df <- data.frame(cidade, temperatura, regiao)
df

# Criando dataframe com lista

df1 <- data.frame(cidades)
df1

# Recuperando valor 1 da coluna 2

df[1, 2]

# Recuperando todas as linhas da coluna 1
df[ ,1]

# Recuperando todas as colunas da linha 1
df[1, ]

#  Selecionando as 4 últimas linhas da primeira e da última coluna
df[c(4:7), c(1, 3)]

# Obter nomes das colunas
names(df)

# Obter dimensões (linhas x colunas)
dim(df)

# Verificando os tipos de dados
str(df)

# Acessar coluna #1 - Horizontal
df$cidade

# Acessar coluna #2 - Vertical
df["cidade"]


# Matrices
?matrix

m <- matrix(seq(1:15), nrow = 5)
m

m1 <- matrix(seq(1:25),
             ncol = 5,
             byrow = TRUE,
             dimnames = list(c(seq(1:5)),
                             c('A','B','C','D','E')
                            )
            )
m1

# Filtrando a matriz
m1[c(2:4), c("C","D","E")]


# Loops

# For
?seq

for (i in seq(10)) {
  print(i)
}

# While

i <- 0
while (i <= 10) {
  i <- i + 1
  print(i)
}


# Controle de fluxo
A <- 8
if (A > 9) {
  print("A é maior do que 9.", quote = FALSE)
} else if (A == 9) {
  print("A é igual a 9.", quote = FALSE)
} else {
  print("A é menor do que 9.", quote = FALSE)
}



# Funções
funcTest <- function(text) {
  a <- "Received text: "
  a <- paste0(a, text)
  a <- paste0(a, ".")
  print(a, quote = FALSE)
}

funcTest("nothing")


# Usando o Grupo de funções 'apply'

?apply

x <- seq(1:9)
matriz <- matrix(x, ncol=3)
matriz

result1 <- apply(matriz, 1, sum)
result1

result2 <- apply(matriz, 2, sum)
result2


?lapply

numeros.p <- c(2,4,6,8,10,12)
numeros.i <- c(1,3,5,7,9,11)
numeros <- list(numeros.p, numeros.i)
numeros

lapply(numeros, mean)

?sapply
sapply(numeros, mean)


# Graphics

?mtcars
carros <- mtcars[,c(1,2,9)]

?head
head(carros)

?hist
hist(carros$mpg)
hist(carros[["mpg"]])

?plot
plot(carros$mpg, carros$cyl)

ggplot(carros, aes(am)) + geom_bar()


# Join

install.packages("dplyr")
library(dplyr)

?dplyr

dfdplyrdf1 <- data.frame(Produto = c(1,2,3,5), Preco = c(15,10,15,20))
head(df1)

df2 <- data.frame(Produto = c(1,2,3,4), Nome = c("A","B","C","D"))
head(df2)

df3 <- left_join(df1, df2, "Produto")
head(df3)

df4 <- right_join(df1, df2, "Produto")
head(df4)

df5 <- inner_join(df1, df2, "Produto")
head(df5)


?iris
head(iris)
glimpse(iris)

# Filtrando dados - apenas 'versicolor'
versicolor <- filter(iris, Species == "versicolor")
dim(versicolor)

# Selecionando algumas linhas específicas
slice(iris, 49:52)

# Selecionando algumas colunas específicas
head(select(iris, 2:4))

# Excluindo algumas colunas
head(select(iris, -Sepal.Width))

iris2 <- mutate(iris, nova.coluna = Sepal.Length + Sepal.Width)
head(iris2[,c("Sepal.Length", "Sepal.Width", "nova.coluna")])


?arrange
head(select(iris, Sepal.Length)) %>%
arrange(Sepal.Length)


?group_by

iris %>% group_by(Species) %>%
  summarise(mean(Sepal.Length))


install.packages("tidyr")
library(tidyr)

dfDate <- data.frame(Produto = c('A','B','C'),
                     A.2015  = c(10,12,20),
                     A.2016  = c(20,25,35),
                     A.2017  = c(15,20,30)
                    )

head(dfDate)


?gather

dfDate2 <- gather(dfDate, "Ano", "Quantidade", 2:4)
dfDate2


?separate
dfDate3 <- separate(dfDate2, Ano, c("A", "Ano"))

dfDate3 <- dfDate3[-2]
dfDate3

dfDate3$Mes <- c('01', '02', '03')
dfDate3


?unite

dfDate4 <- dfDate3 %>%
  unite(Ano_Mes,Mes,Ano,sep="/")
dfDate4


