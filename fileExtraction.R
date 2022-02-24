library('RPostgres')
library('sys')

args=commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied", call.=FALSE)
}

setwd("~/")
w2tforecasting <- paste("Workspaces", "covid-19-Infektion_Tod_in_Deutschland", sep="/")
setwd(w2tforecasting)
getwd()
today <- Sys.Date()
date <- format(today, format="%Y_%m_%d")
folder_name <- paste("Week", date, sep="_")
print(folder_name)
if (!dir.exists(folder_name)) {dir.create(folder_name)}

setwd(folder_name)
#connections
con <- dbConnect(drv = Postgres(),
                 user = "where2test",
                 password = "P4rtyP4rr0t",
                 host = "where2testadm.hzdr.de",
                 port = 32771,
                 dbname="db_where2test"
)

sql_querry <- paste ("select", "*", "from", args[1], ";", sep=" ")

#set dataframe using the querry of sql
DATA <- dbGetQuery(con, sql_querry)

if (!dir.exists(Arxiv) {dir.create(Arxiv)}

filename_kreise_date <- paste("Arxiv/", date,"_Germany_Counties_COVID19_Death_Infections", "csv", sep=".")
filename_kreise <- paste("Actual_Germany_Counties_COVID19_Death_Infections", "csv", sep=".")

write.csv(DATA, filename_kreise_date, row.names = FALSE)
write.csv(DATA, filename_kreise, row.names = FALSE)
dbDisconnect(con)