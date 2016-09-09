#Install tidyverse
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



orgs <- read_csv("cmc_partners_2016_09_09_cleaned.csv")
