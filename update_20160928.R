# Read in existing cmc_partners
cmc <- read.csv("cmc_partners.csv", stringsAsFactors = FALSE)[,-1]
#Edits
#Pat Tarpey
cmc$E.mail.Address[cmc$E.mail.Address=="ptarpey@winnepesauki.org"] <- 
  "ptarpey@winnipesaukee.org"

#Edwin Wong 
cmc$E.mail.Address[cmc$E.mail.Address=="Wonge@wscu.edu"] <- 
  "Wonge@wcsu.edu"

#Tim Green
cmc$E.mail.Address[cmc$E.mail.Address=="tim.green@rochesternh.gov"] <- 
  "tim.green@rochesternh.net"

#Peter Kulbacki
cmc$E.mail.Address[cmc$E.mail.Address=="peter.kulbacki@hanovernh.gov"] <- 
  "peter.kulbacki@hanovernh.org"

#Amy Ansenault
cmc$E.mail.Address[cmc$E.mail.Address=="amyarsenault@awatersheds.org"] <- 
  "amyarsenault@awwatersheds.org"

#Additions
cmc <- rbind(cmc,c("Charlie","Crespi","charles.cyp.crespi@gmail.com",
  "Acton Wakefield Watersheds Alliance","http://awwatersheds.org/"))

#Write out updates
write.csv(cmc,"cmc_partners.csv",row.names = FALSE)

