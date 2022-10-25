
######################### Pratica dia 1 ################################
########################################################################
########################################################################

install.packages("ggplot2")
library(ggplot2)

5+5
1986-123
23*3
35/5

1:10

flamengo <- 10
flamengo

vasco <- 1
vasco

flamengo + vasco

flamengo <- "campeao"
flamengo

vasco <- "vice"
vasco

horas <- c(0,1,2,3,4,5,6,7,8,9,10,11,12)
horas

cores <- c("amarelo", "verde", "vermelho")
cores

#Neste caso vamos criar uma função de media
media=function(objeto){sum(objeto)/length(objeto)}
media(horas)

#Para descobrir em qual diretorio se encontra

getwd()

#Para trocar de diretorio
#Isto e de acordo com cada computador e de acordo com sua preferencia.

setwd("/Users/xbaroc/Desktop/…")

notas<- data.frame(alunos=c("Maria","Joao","Pedro","Alice"), notas=c(10,10,10,10))

#Para verificar
View(notas)

#Agora iremos gerar uma tabela que realmente sera pratica para voces, o cronograma de nossa disciplina

cronograma <- data.frame(Dia=c("Segunda-feira", "Terça-feira", "Quarta-feira", "Quinta-feira", "Sexta-feira"), Manha=c("Evolucao do pensamento biogeografico", "Biogeografia da dispersao", "Distribuicao geografica e Biogeografia da America do Sul", "Capacidade de dispersao, correlacoes, e mapas com dados de rasters", "Drivers de dispersao biologica"), Tarde=c("Introducao a linguagem R", "Obtencao de dados do GBIF", "Limpeza de dados e obtencao de informacoes bioclimaticas", "Capacidade de dispersao, correlacoes, e mapas com dados de rasters", "Seminarios"))

#Para verificar

View(cronograma)

# Ou clique do lado (no Environment) em “cronograma”

#Para conhecer as especificacoes de cada funcao utilize “?” anterior ao nome, por exemplo:

?data.frame()

#Existem diversas formas de abrir tabelas no R, mas aqui vamos apren-der a funcao mais simples para abrir dados do GBIF, a read.tsv do pacote readr. Exemplos:


library(readr)

vriesea_gbif<-read_tsv("/Users/xbaroc/Desktop/Disciplina JB/Vriesea_occ/vriesea_occ_gbif.csv",quote="")


#Existem outros argumentos que podem ser utilizados ao abrir uma tabela no R. Provavelmente iremos nos deparar com isso ao longo da disciplina e resolveremos conforme a necessidade.

#Para copiar o “caminho” de uma tabela no seu computador de forma mais facil clique com o botao direito no icone e selecione “Copiar como caminho”. No MacOs clique com o botao direito e tecle “option”, aparecera “copy as a path…”. No Windows voce tera que mudar a direcao das barras.

#Observe que este data frame tem 9737 obs e 50 variables, o que representa 9737 linhas e 50 colunas.
#Para isso voce pode utilizar a funcao print(), contudo como nosso data frame e muito grande, e melhor voce utilizar a função View() ou clicar ao lado.

#Agora suponhamos que voce queira usar somente as primeiras 10 ocorrencias.

vriesea_10_linhas<-vriesea_gbif[c(1:10),]

#Ou somente as ocorrencias 56,88 e 2030
vriesea_56_88_2030<-vriesea_gbif[c(56, 88, 2030),]

#Ou somente excluir uma linha, como por exemplo a linha 44
vriesea_exc_44<- vriesea_gbif[-c(44),]

#Se voce mudar a virgula de lugar no comando, a alteracao ocorre no numero de colunas.
#Funciona da mesma forma para numeros especificos e em linhas
vriesea_10_colunas<-vriesea_gbif[,c(1:10)]
print(vriesea_10_colunas)

#Para saber o nome das colunas e se elas são numéricas ou não
str(vriesea_10_colunas)

#Para selecionar somente uma coluna, como por exemplo a de familia
vriesea_10_colunas$family

#Se quiser saber quais as especies estão incluidas, de forma unica 
vriesea_sp <- unique(vriesea_10_colunas$species)
vriesea_sp

#Se quiser trocar um argumento dentro do seu data frame, como por exemplo o nome da espécie Vriesea carinata.
str(vriesea_10_colunas)
vriesea_10_colunas$species[1]
vriesea_10_colunas$species[1]="Vriesea carinata var. carinata"
vriesea_10_colunas$species[1]

#Se quiser trocar um argumento comum em varias linhas, como no caso de Liliopsida para Monocotiledonea utilize
vriesea_10_colunas$class
vriesea_10_colunas$class=gsub(vriesea_10_colunas$class,pattern = 'Liliopsida', replacement = 'Monocotyledonae')
vriesea_10_colunas$class

#Para saber quais os valores maximos e minimos de uma coluna, como por exemplo a coleta mais antiga e a coleta mais recente
#So funciona para argumentos numericos. Neste caso tive que excluir os na, se nao indicam o máximo
max(na.omit(vriesea_gbif$year))
min(na.omit(vriesea_gbif$year))

#Agora, se quiser obter um data frame apenas com as coletas realizadas em 1778, você deverá filtrar() o dataframe usando o pacote dplyr
library(dplyr)
vriesea_1778<-data.frame(filter(vriesea_gbif, vriesea_gbif$year == 1778))

#Se quiser um obter um data frame apenas com as coletas ocorridas em 1900 ou antes
vriesea_1900<-data.frame(filter(vriesea_gbif, vriesea_gbif$year <= 1900))

#Tambem pode aplicar um filtro utilizando a função subset(). A funcao filter() geralmente te da o argumento exato, a subset() encontra o argumento mesmo se ele estiver no meio de outro.
#Por exemplo: Voce quer achar o argumento "carinata" no meio da coluna de especies, so que esta coluna sempre vai estar acompanhada do nome do genero. Neste caso o indicado e usar a funcao subset()

vriesea_gbif_carinata<- subset(vriesea_gbif, grepl('carinata',vriesea_gbif$species, ignore.case = T))
vriesea_gbif_carinata2<-data.frame(filter(vriesea_gbif, vriesea_gbif$species == "carinata"))

#Alem disso o pacote dplyr tambem faz filtros e subsets. Aqui neste exemplo eu quero eliminar tudo que esta determinado apenas ao nivel de genero, ou seja, deixar apenas especies e taxons infraespecificos
vriesea_gbif_exc_gen<-vriesea_gbif[!(vriesea_gbif$taxonRank %in% "GENUS"), ]
#O argumento "!" no dplyr se refere a deletar algo. 


#Ao final, para salvar um dataframe como .csv, primeiro selecione seu diretorio de destino e salve
setwd('C:/Users/igork/Desktop')
write.csv(vriesea_10_colunas, file='vriesea_10_colunas.csv')

############################################################################################################
#Existem muitas funcoes que voce vai ainda aprender durante a disciplina, mas essas serão as mais basicas.



#Exercicios

#1

install.packages('rgbif')
install.packages("countrycode")
install.packages("sp")
install.packages("rgdal")
install.packages("CoordinateCleaner")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("tidyverse")
install.packages("elevatr")
install.packages("readr")
install.packages("magrittr")
install.packages("speciesgeocodeR")
install.packages("raster")
install.packages("rgbif")
install.packages("scrubr")
install.packages("maps")
install.packages("abjutils")


library(rgbif)
library(countrycode)
library(sp)
library(rgdal)
library(CoordinateCleaner)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(elevatr)
library(readr)
library(magrittr)
library(speciesgeocodeR)
library(raster)
library(scrubr)
library(maps)
library(abjutils)


#2

alunos <- data.frame(nome=c("Maria", "Joao", "Pedro","Alice"),salario=c(1500,1500,2200,2200), nivel=c("Mestrado", "Mestrado", "Doutorado", "Doutorado"))
View(alunos)

#3
tillandsia<-data.frame(filter(vriesea_gbif, vriesea_gbif$elevation > 500))
tillandsia<-tillandsia[,c(9,10)]
tillandsia$genus=gsub(tillandsia$genus,pattern = 'Vriesea', replacement = 'Tillandsia')
tillandsia$species=gsub(tillandsia$species,pattern = 'Vriesea', replacement = 'Tillandsia')

View(tillandsia)


######################### Pratica dia 2 ################################
########################################################################
########################################################################

############# Obtendo dados diretamente pelo R: Pacote rgif ##########
#Este método só é indicado realizar buscas até 100.000 ocorrências.
#Primeiramente deveremos instalar e executar o pacote rgif.

install.packages("rgbif")
library(rgbif)

#Para buscar os dados por aqui, a função utilizada é a occ_data
#Lembra daquelas especificações do site do GBIF? Você pode aplicá-las aqui. Mas vamos começar mais devagar:
#Observe as especificações da função em:
?occ_data

#Vamos obter todos os dados de Vriesea com coordenadas:

vriesea_br<- occ_data(scientificName = 'Vriesea', country = "BR", hasCoordinate = T)

#A planilha com os dados de ocorrência se encontra em $data
View(vriesea_br$data)

#Neste caso "T" significa a mesma coisa que "TRUE". O contrario disso seria "F" ou "FALSE"

#Esquecemos de incluir somente as espécies com especimes preservadas

vriesea_br_pres_sp<- occ_data(scientificName = 'Vriesea', country = "BR", basisOfRecord = "PRESERVED_SPECIMEN", hasCoordinate = T)
View(vriesea_br_pres_sp$data)

#Agora, suponhamos que você queira todas as espécies de Tillandsia do Brasil, com ocorrência entre 0-1000 m de altitude

tillandsia_0_1000<- occ_data(scientificName = 'Tillandsia', country = "BR", basisOfRecord = "PRESERVED_SPECIMEN", hasCoordinate = T, elevation = '0,1000')
View(tillandsia_0_1000$data)

# Ou as Tillandsia que foram coletadas entre 1990 e 2020

tillandsia_1990_2020<- occ_data(scientificName = 'Tillandsia', country = "BR", basisOfRecord = "PRESERVED_SPECIMEN", hasCoordinate = T, year = '1990,2020')
View(tillandsia_1990_2020$data)
# Enfim, existem diversos outros filtros que você poderá aplicar.

# Para obter os "doi" dos dados utilize:
gbif_citation(tillandsia_1990_2020)
#Infelizmente nao da pra obter um unico doi, como na pesquisa pela web

#Para salvar esta planilha, primeiro podemos reduzir o número de colunas, são muitas
library(dplyr)
till<-tillandsia_1990_2020$data
till2 <- till %>%
  dplyr::select(species, decimalLongitude, decimalLatitude, countryCode, individualCount,
                gbifID, family, taxonRank, year,
                basisOfRecord, institutionCode, datasetName)

write.csv(till2, file = 'till.csv')

#Para a nossa disciplina, obteremos estes dados diretamente pela web, de forma mais simples.


#Exercicios

#E5
lentibulariaceae<- occ_data(scientificName = 'Lentibulariaceae', country = "BR", basisOfRecord = "PRESERVED_SPECIMEN", hasCoordinate = T, year = '2000')
View(lentibulariaceae$data)


##################### Plotando mapas simples no R ##############
#Um dos pacotes mais interessantes do R e o ggplot2. Ele te permite vizualizar dados de maneiras bem interessantes
library(ggplot2)

#Primeiramente vamos chamar nossa planilha de dados obtidas no GBIF
#Aqui como exemplo usarei a minha primeira planilha de Vriesea.

library(readr)
vriesea_gbif<-read_tsv("C:/Users/igork/Desktop/Vriesea_occ/vriesea_occ_gbif.csv",quote="")
View(vriesea_gbif)

#Vamos gerar o mapa mundi base primeiro, utilizando o proprio ggplot2
world.inp <- map_data("world")

#Identifique a lat e long
long=vriesea_gbif$decimalLongitude
lat=vriesea_gbif$decimalLatitude

#Pronto, agora pra plotar seus dados utilize
#Nao esqueaa de trocar corretamente os argumentos

g1<-ggplot() + geom_map(data = world.inp, map = world.inp, aes(x = long, y = lat, 
                                                               map_id = region), fill = "grey80") +  geom_point(data = vriesea_gbif, aes(x = decimalLongitude, 
                                                                                                                                         y = decimalLatitude), colour = "darkblue", size = 0.1) + coord_fixed() + theme_bw() + 
  theme(axis.title = element_blank())
g1


#Tem muitas ocorrencias onde nao eram pra estar? Isto a normal, se deve as coletas em Jardins Botanicos, ou erros de identificacao. Mas fiquem tranquilos, amanha trabalharemos na limpeza destes dados.
#Se quiser reduzir a extensão do mapa pelo o limite dos dados


g2<-ggplot() + geom_map(data = world.inp, map = world.inp, aes(x = long, y = lat, 
                                                               map_id = region), fill = "grey80") + xlim(min(vriesea_gbif$decimalLongitude, na.rm = T), 
                                                                                                         max(vriesea_gbif$decimalLongitude, na.rm = T)) + ylim(min(vriesea_gbif$decimalLatitude, na.rm = T), 
                                                                                                                                                               max(vriesea_gbif$decimalLatitude, na.rm = T)) + geom_point(data = vriesea_gbif, aes(x = decimalLongitude, 
                                                                                                                                                                                                                                                   y = decimalLatitude), colour = "darkblue", size = 0.1) + coord_fixed() + theme_bw() + 
  theme(axis.title = element_blank())


g2

#Ou por coordenadas, como no meu exemplo nas Americas
g3<-ggplot() + geom_map(data = world.inp, map = world.inp, aes(x = long, y = lat, 
                                                               map_id = region), fill = "grey80") + xlim(min(-130), 
                                                                                                         max(-25)) + ylim(min(-50), 
                                                                                                                          max(50)) + geom_point(data = vriesea_gbif, aes(x = decimalLongitude, 
                                                                                                                                                                         y = decimalLatitude), colour = "darkblue", size = 0.1) + coord_fixed() + theme_bw() + 
  theme(axis.title = element_blank())


g3

#Para salvar o mapa como pdf
pdf('mapa_occ_vriesea.pdf')
g3
dev.off()
# Parabens! Você ja sabe fazer mapas no R.
# Mas calma, as coisas vao ficar melhores daqui em diante!



######################### Pratica dia 3 ################################
########################################################################
########################################################################

############## Limpeza manual e usando o CoordinateCleaner ##########
#Vamos comeaar chamando nossa planilha base

library(CoordinateCleaner)
library(readr)
vriesea_gbif<-read_tsv("C:/Users/igork/Desktop/Vriesea_occ/vriesea_occ_gbif.csv",quote="")

#Um ponto importante de quando obtemos uma planilha do GBIF e que ela também inclui as especimes chamadas "indet", ou seja, que nao foram identificadas a nivel de especie.
#No caso de apenas um genero, os "indets" serao somente a nível de ganero. No caso de familias teremos indets a nivel de familia e genero.
#Vamos excluir os indets visto que nao consiguiremos saber de qual especie estes pertencem.

library(dplyr)
vriesea_gbif2<-vriesea_gbif[!(vriesea_gbif$taxonRank %in% 'GENUS'), ]

#taxonRank e a coluna que indica a que nivel a especime esta identificada
#Caso esteja trabalhando com família, troque o argumento 'GENUS' por c('FAMILY','GENUS')

#Um fator importante para o CoordinateCleaner e a padronização das siglas dos países de ISO2c para ISO3c
library(countrycode)
vriesea_gbif2$countryCode <- countrycode(vriesea_gbif2$countryCode, origin =  'iso2c', destination = 'iso3c')

#Agora e importante testar a validade das coordenadas antes de seguir a limpeza.
#Esta funcao remove as ocorrencias com coordenadas invalidas.

?cc_val
vriesea_gbif2<-cc_val(
  vriesea_gbif2,
  lon = "decimalLongitude",
  lat = "decimalLatitude",
  value = "clean",
  verbose = TRUE
)

#Agora vamos de fato conhecer as ocorrencias equivocadas
#Esta funcao faz o teste em cima de diversos fatores, como você pode ver em "tests"
#Você podera alterar conforme faça sentido para seu grupo, aumentando e diminuindo buffers 
#Para conhecer os parametros
?clean_coordinates()

#Para realizar as analises
flags <- clean_coordinates(x = vriesea_gbif2,
                           lon = "decimalLongitude",
                           lat = "decimalLatitude",
                           countries = "countryCode",
                           species = "species",
                           tests = c("capitals", "centroids", "equal", "gbif", "institutions", "outliers",
                                     "seas", "zeros")) 

#Para conhecer aonde estao os "flags", ou ocorrencias sinalizadas como possivelmente erradas
summary(flags)

#Para visualizar os flags no mapa
plot(flags, lon = "decimalLongitude", lat = "decimalLatitude")

#Salvar o mapa
pdf('mapa_occ_vriesea_limpo.pdf')
plot(flags, lon = "decimalLongitude", lat = "decimalLatitude")
dev.off()

#Para eliminar estas ocorrencias sinalizadas
vriesea_gbif3 <- vriesea_gbif2[flags$.summary,]

#Salvar a planilha limpa
write.csv(vriesea_gbif3, file= 'vriesea_gbif3.csv')

######## Obtendo dados bioclimaticos atraves de rasters ################
# Veja as especificacoes dos dados bioclimaticos em https://chelsa-climate.org/bioclim/
# Agora este processo vai demorar um pouco mais, os rasters sao muito pesados. 
#Voce nao precisa plotar todos os mapas. Isto e so para ilustrar.

library(raster)

data_name1<-"https://envicloud.os.zhdk.cloud.switch.ch/chelsa/chelsa_V1/climatologies/bio/CHELSA_bio10_01.tif"
r1=raster(data_name1) #BIO1 = Annual Mean Temperature
plot(r1)

data_name2<-"https://envicloud.os.zhdk.cloud.switch.ch/chelsa/chelsa_V1/climatologies/bio/CHELSA_bio10_02.tif"
r2=raster(data_name2) #BIO2 = Mean Diurnal Range (Mean of monthly (max temp - min temp))
plot(r2)

data_name3<-"https://envicloud.os.zhdk.cloud.switch.ch/chelsa/chelsa_V1/climatologies/bio/CHELSA_bio10_03.tif"
r3=raster(data_name3) #BIO3
plot(r3)

data_name4<-"https://envicloud.os.zhdk.cloud.switch.ch/chelsa/chelsa_V1/climatologies/bio/CHELSA_bio10_04.tif"
r4=raster(data_name4) #BIO4
plot(r4)

data_name5<-"https://envicloud.os.zhdk.cloud.switch.ch/chelsa/chelsa_V1/climatologies/bio/CHELSA_bio10_05.tif"
r5=raster(data_name5) #BIO5 = Max Temperature of Warmest Month
plot(r5)

data_name6<-"https://envicloud.os.zhdk.cloud.switch.ch/chelsa/chelsa_V1/climatologies/bio/CHELSA_bio10_06.tif"
r6=raster(data_name6) #BIO6
plot(r6)

data_name7<-"https://envicloud.os.zhdk.cloud.switch.ch/chelsa/chelsa_V1/climatologies/bio/CHELSA_bio10_07.tif"
r7=raster(data_name7) #BIO7
plot(r7)

data_name8<-"https://envicloud.os.zhdk.cloud.switch.ch/chelsa/chelsa_V1/climatologies/bio/CHELSA_bio10_08.tif"
r8=raster(data_name8) #BIO8
plot(r8)

data_name9<-"https://envicloud.os.zhdk.cloud.switch.ch/chelsa/chelsa_V1/climatologies/bio/CHELSA_bio10_09.tif"
r9=raster(data_name9) #BIO9
plot(r9)

data_name10<-"https://envicloud.os.zhdk.cloud.switch.ch/chelsa/chelsa_V1/climatologies/bio/CHELSA_bio10_10.tif"
r10=raster(data_name10) #BIO10
plot(r10)

data_name11<-"https://envicloud.os.zhdk.cloud.switch.ch/chelsa/chelsa_V1/climatologies/bio/CHELSA_bio10_11.tif"
r11=raster(data_name11) #BIO11
plot(r11)

data_name12<-"https://envicloud.os.zhdk.cloud.switch.ch/chelsa/chelsa_V1/climatologies/bio/CHELSA_bio10_12.tif"
r12=raster(data_name12) #BIO12 = Annual Precipitation
plot(r12)

data_name13<-"https://envicloud.os.zhdk.cloud.switch.ch/chelsa/chelsa_V1/climatologies/bio/CHELSA_bio10_13.tif"
r13=raster(data_name13) #BIO13
plot(r13)

data_name14<-"https://envicloud.os.zhdk.cloud.switch.ch/chelsa/chelsa_V1/climatologies/bio/CHELSA_bio10_14.tif"
r14=raster(data_name14) #BIO14 = Precipitation of Driest Month
plot(r14)

data_name15<-"https://envicloud.os.zhdk.cloud.switch.ch/chelsa/chelsa_V1/climatologies/bio/CHELSA_bio10_15.tif"
r15=raster(data_name15) #BIO15 = Precipitation Seasonality (Coefficient of Variation)
plot(r15)

data_name16<-"https://envicloud.os.zhdk.cloud.switch.ch/chelsa/chelsa_V1/climatologies/bio/CHELSA_bio10_16.tif"
r16=raster(data_name16) #BIO16
plot(r16)

data_name17<-"https://envicloud.os.zhdk.cloud.switch.ch/chelsa/chelsa_V1/climatologies/bio/CHELSA_bio10_17.tif"
r17=raster(data_name17) #BIO17
plot(r17)

data_name18<-"https://envicloud.os.zhdk.cloud.switch.ch/chelsa/chelsa_V1/climatologies/bio/CHELSA_bio10_18.tif"
r18=raster(data_name18) #BIO18
plot(r18)

data_name19<-"https://envicloud.os.zhdk.cloud.switch.ch/chelsa/chelsa_V1/climatologies/bio/CHELSA_bio10_19.tif"
r19=raster(data_name19) #BIO19
plot(r19)

#Se quiser testar outras variáveis, como por exemplo elevacao
elev<-raster('/Volumes/IGOR/Rasters/elevation.tif')

# Antes de mais nada, vamos eliminar todas as possiveis ocorrencias duplicadas da nossa planilha, para isso
vriesea_gbif3<-unique(vriesea_gbif3) #no meu caso não haviam duplicatas

#Agora uma das partes mais importantes, a extracao das informacoes do raster para cada ocorrencia.
#Para isto nos vamos criar novas colunas no nosso data frame com estas informacoes

vriesea_gbif3$bio1<-raster::extract(r1,cbind.data.frame(vriesea_gbif3$decimalLongitude,vriesea_gbif3$decimalLatitude))
vriesea_gbif3$bio2<-raster::extract(r2,cbind.data.frame(vriesea_gbif3$decimalLongitude,vriesea_gbif3$decimalLatitude))
vriesea_gbif3$bio3<-raster::extract(r3,cbind.data.frame(vriesea_gbif3$decimalLongitude,vriesea_gbif3$decimalLatitude))
vriesea_gbif3$bio4<-raster::extract(r4,cbind.data.frame(vriesea_gbif3$decimalLongitude,vriesea_gbif3$decimalLatitude))
vriesea_gbif3$bio5<-raster::extract(r5,cbind.data.frame(vriesea_gbif3$decimalLongitude,vriesea_gbif3$decimalLatitude))
vriesea_gbif3$bio6<-raster::extract(r6,cbind.data.frame(vriesea_gbif3$decimalLongitude,vriesea_gbif3$decimalLatitude))
vriesea_gbif3$bio7<-raster::extract(r7,cbind.data.frame(vriesea_gbif3$decimalLongitude,vriesea_gbif3$decimalLatitude))
vriesea_gbif3$bio8<-raster::extract(r8,cbind.data.frame(vriesea_gbif3$decimalLongitude,vriesea_gbif3$decimalLatitude))
vriesea_gbif3$bio9<-raster::extract(r9,cbind.data.frame(vriesea_gbif3$decimalLongitude,vriesea_gbif3$decimalLatitude))
vriesea_gbif3$bio10<-raster::extract(r10,cbind.data.frame(vriesea_gbif3$decimalLongitude,vriesea_gbif3$decimalLatitude))
vriesea_gbif3$bio11<-raster::extract(r11,cbind.data.frame(vriesea_gbif3$decimalLongitude,vriesea_gbif3$decimalLatitude))
vriesea_gbif3$bio12<-raster::extract(r12,cbind.data.frame(vriesea_gbif3$decimalLongitude,vriesea_gbif3$decimalLatitude))
vriesea_gbif3$bio13<-raster::extract(r13,cbind.data.frame(vriesea_gbif3$decimalLongitude,vriesea_gbif3$decimalLatitude))
vriesea_gbif3$bio14<-raster::extract(r14,cbind.data.frame(vriesea_gbif3$decimalLongitude,vriesea_gbif3$decimalLatitude))
vriesea_gbif3$bio15<-raster::extract(r15,cbind.data.frame(vriesea_gbif3$decimalLongitude,vriesea_gbif3$decimalLatitude))
vriesea_gbif3$bio16<-raster::extract(r16,cbind.data.frame(vriesea_gbif3$decimalLongitude,vriesea_gbif3$decimalLatitude))
vriesea_gbif3$bio17<-raster::extract(r17,cbind.data.frame(vriesea_gbif3$decimalLongitude,vriesea_gbif3$decimalLatitude))
vriesea_gbif3$bio18<-raster::extract(r18,cbind.data.frame(vriesea_gbif3$decimalLongitude,vriesea_gbif3$decimalLatitude))
vriesea_gbif3$bio19<-raster::extract(r19,cbind.data.frame(vriesea_gbif3$decimalLongitude,vriesea_gbif3$decimalLatitude))
vriesea_gbif3$elev<-raster::extract(elev,cbind.data.frame(vriesea_gbif3$decimalLongitude,vriesea_gbif3$decimalLatitude))

#Vamos verificar o data frame com as novas colunas?
View(vriesea_gbif3)

#ou so as colunas
View(vriesea_gbif3$bio1)

#Para salvar a planilha com as informacoes dos rasters
write.csv(vriesea_gbif3, file = 'vriesea_gbif3_rasters.csv')

#Exercicios
#E9
max(vriesea_gbif3$elev)
min(vriesea_gbif3$elev)
mean(vriesea_gbif3$elev)
median(vriesea_gbif3$elev)


######################### Pratica dia 4 ################################
########################################################################
########################################################################


#### Capacidade de dispersao atraves da funcao earth.dist #############

#Vamos conhecer a funcao
#Esta funcao retorna uma matriz de distancias em km comparando as listas de latitude e longitude

library(fossil)
?earth.dist

#Para nossa funcao funcionar corretamente, vamos remover algumas colunas do nosso data frame de entrada
#Nao se preocupe, depois resgataremos estas colunas novamente
#Somente manteremos Longitude, Latitude, Especie. Verifique no seu data frame quais os numeros das suas colunas
#Chame a planilha .csv., a ultima salva
#SUPER IMPORTANTE: stringAsFactors = F

frame <- read.csv("C:/Users/igork/Desktop/Setembro_19-23/Disciplina JB/Vriesea_occ/vriesea_gbif3_rasters.csv", stringsAsFactors = F)
frame=frame[,c(24,23,11)] #Ordem: Longitude, Latitude, Especie 
long="decimalLongitude"
lat="decimalLatitude" 
species = "species" 

#Agora, vamos eliminar as ocorrencias muito proximas umas das outras, neste caso arredondaremos as coordenadas ate tres casas decimais
#Antes de fazer isso pense tres casa decimais fara sentido para seu grupo

frame[[long]] = round(frame[[long]],3)
frame[[lat]] = round(frame[[lat]],3)

#Apos realizar este procedimento voce tera varias ocorrencias duplicadas. Vamos elimina-las
#Perceba que para as variaveis bioclimaticas não fizemos este procedimento, visto que teremos um valor por ocorrencia. Aqui teremos um valor por especie.

frame=unique(frame) #eliminar duplicatas (ou ocorrencias muito proximas - 111 m = 0.001 grau)

# Alem disso, pode ser que algumas medidas de grau decimal estao incorretas, com virgula ao inves de ponto. Vamos modifica-las
frame$decimalLatitude=gsub(frame$decimalLatitude,pattern = ',', replacement = '.')
frame$decimalLatitude = as.numeric(as.character(frame$decimalLatitude))
frame$decimalLongitude=gsub(frame$decimalLongitude,pattern = ',', replacement = '.')
frame$decimalLongitude = as.numeric(as.character(frame$decimalLongitude))

#Agora vamos criar uma lista de espécies em ordem alfabetica
#Nesse caso frame[[species]] equivale a frame$species
list_species = sort(unique(frame[[species]]))

#Criar um objeto para servir de base para cada especie. Este numero se refere a ordem da especie no seu data frame
#Posteriormente vamos selecionar (filtrar) os dados somente daquela especie.

sp = list_species[1]
df_temp = frame[frame[[species]]==sp,]

#Agora a funcao earth.dist() vai nos dar uma matriz de distancias entre os pontos de ocorrencia da especie na linha 1
shp=earth.dist(df_temp, dist = T)
shp

#Agora para conhecer as distancias maxima, minima, media e mediana por especie
max(earth.dist(df_temp))
min(earth.dist(df_temp))
mean(earth.dist(df_temp))
median(earth.dist(df_temp))


#Agora vamos conhecer estes valores para todas as espécies
#Para isso vamos utilizar um loop

df_final = data.frame()
for (i in 1:length(list_species)){
  print(i)
  sp = list_species[i]
  df_temp = frame[frame[[species]]==sp,]
  shp=earth.dist(df_temp)
  df_temp = cbind.data.frame(max = max(shp),min = min(shp), mean= mean(shp), median=median(shp))
  df_final = rbind(df_final,df_temp)
}
View(df_final)

#Pode ser que tenha alguns valores em Na. Isto se deve as especies que tem apenas um registro.
#Para juntar os nomes das especies com as informações geradas

frame2=data.frame(list_species)
frame3=data.frame(frame2,df_final)

#Da mesma forma vamos obter as medidas maximas, minimas, medias e medianas de cada variavel bioclimatica.
#Utilizaremos a mesma logica do exemplo anterior. Como exemplo vamos utilizar a bio1

#Temos que chamar novamente a planilha que tem a informacao dos rasters
frame <- read.csv("C:/Users/igork/Desktop/Setembro_19-23/Disciplina JB/Vriesea_occ/vriesea_gbif3_rasters.csv", stringsAsFactors = F)
long="decimalLongitude"
lat="decimalLatitude" 
species = "species" 

list_species = sort(unique(frame[[species]]))
sp = list_species[1]
df_temp = frame[frame[[species]]==sp,]

shp=df_temp
mean(df_temp$bio1)
median(df_temp$bio1)

frame$mean_bio1=NULL
frame$median_bio1=NULL

df_final = data.frame()
for (i in 1:length(list_species)){
  print(i)
  sp = list_species[i]
  df_temp = frame[frame[[species]]==sp,]
  shp=df_temp
  df_temp = cbind.data.frame(mean_bio1 = mean(shp$bio1),median_bio1 = median(shp$bio1),max_bio1=max(shp$bio1),min_bio1=min(shp$bio1))
  df_final = rbind(df_final,df_temp)
}
View(df_final)

frame4 = data.frame(frame3,df_final)

##Para salvar sua lista com informacoes por espécies
write.csv(frame4, file = 'lista_especies_rasters.csv')


###################### Correlacões ############################
#Primeiro deveremos avaliar se a distribuicao dos dados (todas as variaveis numericas) e normal. Para isto utilizaremos o teste de Shapiro-Wilk
#Se o valor de p for maior que 0.05 indica que a distribuicao de dados é normal. Se for menor que 0.05 indica que nao e normal.
#Como exemplo realizaremos o teste apenas para a bio1

shapiro.test(as.numeric(frame4$mean))
shapiro.test(as.numeric(frame4$mean_bio1))

#Este passo sera essencial para decidirmos qual metodo utilizaremos na correlacao. Para dados normais se utiliza o metodo de Pearson, dados nao normais o metodo de Spearman.
#No meu caso, o teste nas duas varaveis apresentou valor de p menor que 0.05, sendo assim utilizaremos Spearman.


library(ggplot2)
library(ggpubr)
library(ggExtra)

# Para plotar a correlacao
bio1<-ggscatter(frame4, x = "mean", y = "mean_bio1", 
                add = "reg.line", conf.int = TRUE, 
                cor.coef = TRUE, cor.method = "spearman",
                xlab = "Dispersal capacity (km)", ylab = "Temperature (C°)\n", alpha=0.1)
bio1

#Para adicionar um histograma marginal para compreender a ditribuicao dos dados
bio1b<-ggMarginal(bio1, type = "histogram",margins = 'y')
bio1b

#Vamos verificar se tem muitos outliers
boxplot(frame4$mean)
boxplot(frame4$mean, plot=FALSE)$out

boxplot(frame4$mean_bio1)
boxplot(frame4$mean_bio1, plot=FALSE)$out

#Removendo os outliers. Opcional!

outliers <- boxplot(frame4$mean, plot=FALSE)$out
frame5<-frame4
frame5<- frame5[-which(frame5$mean %in% outliers),]

outliers <- boxplot(frame5$mean_bio1, plot=FALSE)$out
frame5<- frame5[-which(frame5$mean_bio1 %in% outliers),]

#Verificando novamente
bio1<-ggscatter(frame5, x = "mean", y = "mean_bio1", 
                add = "reg.line", conf.int = TRUE, 
                cor.coef = TRUE, cor.method = "spearman",
                xlab = "Dispersal capacity (km)", ylab = "Temperature (C°)\n", alpha=0.1)
bio1

bio1b<ggMarginal(bio1, type = "histogram",margins = 'y')
bio1b

#Alem disso, se voces tiver valores muito diferentes entre si nas variaveis, voce podera fazer log10. Opcional!

frame4$log10_mean_bio1<-log10(frame4$mean_bio1)
frame4$log10_mean<-log10(frame4$mean)

bio1<-ggscatter(frame4, x = "log10_mean", y = "log10_mean_bio1", 
                add = "reg.line", conf.int = TRUE, 
                cor.coef = TRUE, cor.method = "spearman",
                xlab = "log Dispersal capacity (km)", ylab = "log Temperature (C°)\n", alpha=0.1)
bio1

#Para salvar estas imagens em pdf
pdf("correlation_temp.pdf",width = 10,height =5)
bio1
dev.off()


######### Mapas com dados de rasters ########
#Provavelmente voce percebeu que os dados extraidos se referem a soma das medias mensais, desta forma, para isto devemos dividir por 12 para ter um ideia de media anual
#Para isto deveremos utilizar nossa planilha com dados de coordenadas geograficas, nao a de especies.


frame <- read.csv("/Users/xbaroc/Desktop/vriesea_gbif3_rasters.csv", header=T)

#Para termos a media de temperatura mensal deveremos dividir por 12 o valor obtido dos rasters
frame$bio1_12<-frame$bio1 /12

#Assim como anteriormente, vamos utilizar o ggplot2 para rodar os mapas
library(ggplot2)
world.inp <- map_data("world")

#Identifique a lat e long
long=frame$decimalLongitude
lat=frame$decimalLatitude

library(viridis)

#Se quiser incluir o mapa inteiro
g1<-ggplot() + 
  geom_map(data = world.inp, map = world.inp, aes(x = long, y = lat,  map_id = region),  color = "gray", fill = "grey80")  +
  geom_point(data = frame, aes(x = decimalLongitude,  y = decimalLatitude, fill = bio1_12), shape=21,color='grey90', stroke=0.0001,size=1) +
  coord_fixed() + scale_fill_viridis_c(name = "Temperature (C°)\n", direction = -1, option = "inferno")+ theme_bw() + 
  theme(axis.title = element_blank())
g1

#Se quiser reduzir a extensao do mapa pelo max e min de coordenadas
g2<-ggplot() + 
  geom_map(data = world.inp, map = world.inp, aes(x = long, y = lat,  map_id = region),  color = "gray", fill = "grey80")  +
  geom_point(data = frame, aes(x = decimalLongitude,  y = decimalLatitude, fill = bio1_12), shape=21,color='grey90', stroke=0.0001,size=2) +
  coord_fixed() + scale_fill_viridis_c(name = "Temperature (C°)\n", direction = -1, option = "inferno")+ theme_bw() + 
  theme(axis.title = element_blank()) + xlim(min(frame$decimalLongitude, na.rm = T), max(frame$decimalLongitude, na.rm = T)) +
  ylim(min(frame$decimalLatitude, na.rm = T), max(frame$decimalLatitude, na.rm = T)) 

g2

#Ou por coordenadas fixas, como no meu exemplo nas Americas
g3<-ggplot() + 
  geom_map(data = world.inp, map = world.inp, aes(x = long, y = lat,  map_id = region),  color = "gray", fill = "grey80")  +
  geom_point(data = frame, aes(x = decimalLongitude,  y = decimalLatitude, fill = bio1_12), shape=21,color='grey90', stroke=0.0001,size=2) +
  coord_fixed() + scale_fill_viridis_c(name = "Temperature (C°)\n", direction = -1, option = "inferno")+ theme_bw() + 
  theme(axis.title = element_blank()) + xlim(min(-130), max(-25)) +
  ylim(min(-50), max(50)) 

g3


#Para salvar estes mapas em pdf
pdf("map_temp.pdf",width = 10,height =10)
g2
dev.off()

################################## FIM ##############################

