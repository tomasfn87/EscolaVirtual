library(readr)
library(dplyr)

diabetes <- read_delim(file="~/EscolaVirtual/R-Studio/diabetes.csv",
                       col_names=TRUE,
                       delim=",",
                       locale=locale(encoding = "Windows-1252")
                      )

View(diabetes)

?str
str(diabetes)

colSums(is.na(diabetes))

table(diabetes$Outcome)

diabetes$Outcome <- as.factor(diabetes$Outcome)

summary(diabetes$Insulin)

boxplot(diabetes)

boxplot(diabetes$Insulin)

hist(diabetes$Insulin)

diabetes2 <- diabetes %>%
  filter(Insulin <= 250)

boxplot(diabetes2$Insulin)

boxplot(diabetes2)

hist(diabetes2$Pregnancies)
hist(diabetes2$Age)
hist(diabetes2$BMI)

summary(diabetes2$Insulin)


install.packages("caTools")
library(caTools)


# Divisão dados em treinamento (70%) e teste (30%)
set.seed(123)
index = sample.split(diabetes2$Pregnancies, SplitRatio = .70)
index
table(index)

train = subset(diabetes2, index == TRUE)
test = subset(diabetes2, index == FALSE)

dim(diabetes2)
dim(train)
dim(test)

install.packages("caret")
install.packages("e1071")

library(caret)
library(e1071)

?caret::train

# Treinando a primeira versão do modelo - KNN
modelo <- train(
  Outcome ~., data = train, method = "knn")

modelo$results
modelo$bestTune


# Treinando a segunda versão do modelo - testando o comportamento do modelo com outros valores de k
modelo2 <- train(
  Outcome ~., data = train, method = "knn",
  tuneGrid = expand.grid(k = c(1:20)))

modelo2$results
modelo2$bestTune

plot(modelo2)


# Treinando a terceira versão do modelo - Naive bayes
install.packages("naivebayes")
library(naivebayes)

modelo3 <- train(
  Outcome ~., data = train, method = "naive_bayes")

modelo3$results
modelo3$bestTune

plot(modelo3)


install.packages("randomForest")
library(randomForest)

modelon4 <- train(
  Outcome ~., data = train, method = "rpart2"
)
modelon4

# Verificando a importância das váriaveis para o aprendizado do modelo
varImp(modelon4$finalModel)
# As colunas "Insulin e Blood Pressure" não contribuem muito para o aprendizado do modelo  


# Treinando o modelo sem as colunas "Insulin e BloodPressure" - train[,c(-3,-5)] exclui as colunas
modelon4_1 <- train(
  Outcome ~., data = train[,c(-3,-5)], method = "rpart2"
)
modelon4_1

# Visualizando a arvore de decisão
plot(modelon4_1$finalModel)
text(modelon4_1$finalModel)


install.packages("kernlab")
library(kernlab)

set.seed(100)
modelo5 <- train(
  Outcome ~., data = train, method = "svmRadialSigma"
  ,preProcess=c("center")
)

modelo5$results
modelo5$bestTune

?predict

# Testando o modelo com os dados de teste
predicoes <- predict(modelo5,test)

predicoes

?caret::confusionMatrix

confusionMatrix(predicoes, test$Outcome)

novos.dados <- data.frame(
  Pregnancies = c(3),           
  Glucose = c(111.50),
  BloodPressure = c(70),
  SkinThickness = c(20),          
  Insulin = c(47.49),
  BMI = c(30.80),       
  DiabetesPedigreeFunction = c(0.34),
  Age = c(28)                     
)

novos.dados

previsao <- predict(modelo5,novos.dados)

resultado <- ifelse(previsao == 1, "Positivo","Negativo")
resultado
print(paste("Resultado:",resultado), quote=FALSE)


# Criando o arquivo com os resultados das predições
write.csv(predicoes,'~/EscolaVirtual/R-Studio/resultado.csv')

# Lendo o arquivo de previsões que foi gerado
resultado.csv <- read.csv('~/EscolaVirtual/R-Studio/resultado.csv')

# Alterando o nome das colunas do dataframe
names(resultado.csv) <- c('Indice','Valor previsto')

# Visualizando o dataframe
glimpse(resultado.csv)
