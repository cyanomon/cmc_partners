#Install tidyverse
#c('broom', 'forcats', 'haven', 'hms', 'lubridate', 'modelr', 'purrr', 'readr', 'readxl', 'rvest')
library(tidyverse)

#Read in sources for names and emails
outlook <- read_csv("cmc_partner_list.csv",trim_ws = TRUE)
name_add <- read_csv("cyano_group.csv",trim_ws = TRUE)

#Get names in correct format from name_add
#Drop | APHL, (DEC)
name_add$Name <- gsub(" \\| APHL","",name_add$Name)
name_add$Name <- gsub(" \\(DEC\\)","",name_add$Name)
name_add$Name <- gsub(" \\(DEP\\)","",name_add$Name)

#fix last, first
for(i in seq_along(name_add$Name)){
  x <- strsplit(name_add$Name[i], ",")
  if(length(x[[1]])==2){
    name_add$Name[i] <- paste(x[[1]][2],x[[1]][1])
  }
}
name_add$Name <- stringr::str_trim(name_add$Name)
name_add$Name <- stringr::str_to_title(name_add$Name)

#Split into two columns
name_add <- extract(name_add,Name,c("First Name","Last Name"),"([^ ]+) (.*)")
names(name_add)[3]<- "E-mail Address"

#Join both together keeping all
outlook2 <- full_join(outlook,name_add,by="E-mail Address")

#Create one row per name...  Few with same email, multiple names..
dup_email <- outlook2$'E-mail Address' %in% outlook2$`E-mail Address`[duplicated(outlook2$`E-mail Address`)]
outlook2[dup_email,]$`First Name.x` <- outlook2[dup_email,]$`First Name.y`
outlook2[dup_email,]$`Last Name.x` <- outlook2[dup_email,]$`Last Name.y`

#Move names from name_add to outlook name position.
na_name <- is.na(outlook2$`First Name.x`)
outlook2$`First Name.x`[na_name] <-outlook2$`First Name.y`[na_name]
outlook2$`Last Name.x`[na_name] <-outlook2$`Last Name.y`[na_name]
outlook2$`E-mail Display Name` <- paste(outlook2$`First Name.x`,outlook2$`Last Name.x`)

#Back to original names
names(outlook2)[c(2,4)] <- c("First Name", "Last Name")

#Combine Affilitations
outlook2$Affiliation.y[is.na(outlook2$Affiliation.y)] <- outlook2$Affiliation.x[is.na(outlook2$Affiliation.y)]
outlook2$WEB.y[is.na(outlook2$WEB.y)] <- outlook2$WEB.x[is.na(outlook2$WEB.y)]

cmc_partners <- outlook2 %>%
  select(`First Name`, `Last Name`, `E-mail Address`, Affiliation.y, WEB.y) %>%
  arrange(Affiliation.y)

names(cmc_partners)[4:5]<-c("Affiliation","Web")

#Cleaned up version for dissemination
#Proposing (on 9/15/16) to move this to google sheets and have additions to 
#sheet done via a google forms.
write.csv(cmc_partners,"../cmc_partners.csv")


#Work on cleaning up Affiliation names
#orgs <- read_csv("cmc_partners_2016_09_09_cleaned.csv")
#names(orgs)<-c("Affiliation","State", "WEB", "Logo")
#org_join <- full_join(outlook2,orgs) %>%
#  select(Affiliation,WEB)
#org_join<-unique(org_join) %>%
#  arrange(Affiliation)
#Need to match emails w/o orgs to orgs...
#Manual!!
#write.csv(org_join,"cleaned_orgs.csv")
#write.csv(outlook2,"cleaned_cmc_member.csv")

#Need to figure out logos

#Spit out table from the cleaned, final list

