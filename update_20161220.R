# Read in existing cmc_partners
cmc <- read.csv("cmc_partners.csv", stringsAsFactors = FALSE)

# Add new names from Hilary
cmc <- rbind(cmc,c("Hilary","Snook","snook.hilary@epa.gov", 
                   "United States Environmental Protection Agency Region 1", 
                   "https://www.epa.gov/aboutepa/epa-region-1-new-england"))

# Edit busted ones
cmc$E.mail.Address[cmc$E.mail.Address == "james@mychamplain.net"] <- 
  c("james@mychamplain.net")

cmc$E.mail.Address[cmc$E.mail.Address == "wayne@mychamplain.net"] <- 
  c("")

cmc$E.mail.Address[cmc$E.mail.Address == "infoo@libertyconcretecutting.com"] <- 
  c("info@libertyconcretecutting.com")

cmc$E.mail.Address[cmc$E.mail.Address == "lpazarls@comcast.net"] <-
  c("lpazaris@comcast.net")
cmc$Last.Name[cmc$Last.Name == "Gill-Pazarls"] <-
  c("Gill-Pazaris")

cmc$E.mail.Address[cmc$E.mail.Address == "bingyby@comcast.net"] <-
  c("")

cmc$E.mail.Address[cmc$E.mail.Address == "Jjimmartel41@gmail.com"] <-
 c("jimmartel41@gmail.com")

cmc$E.mail.Address[cmc$E.mail.Address == "darkng49@gmail.com"] <-
  c("")

cmc$E.mail.Address[cmc$E.mail.Address == "mdrnhart@gmail.com"] <-
  c("")

cmc$E.mail.Address[cmc$E.mail.Address == "awwaqco@gmail.com"] <-
  c("")

cmc$E.mail.Address[cmc$E.mail.Address == "mmcarthy@newfairfield.org"] <-
  c("mmccarthy@newfairfield.org")

cmc$E.mail.Address[cmc$E.mail.Address == "amyarsenault@awatersheds.org"] <-
  c("amyarsenault@awwatersheds.org")

cmc$E.mail.Address[cmc$E.mail.Address == "peter.kulbacki@hanovernh.org"] <-
  c("peter.kulbacki@hanovernh.org")

cmc$E.mail.Address[cmc$E.mail.Address == "teriko.macconnell@sawyer-college.edu"] <-
  c("teriko.macconnell@colby-sawyer.edu")

cmc$E.mail.Address[cmc$E.mail.Address == "Wonge@wcsu.edu"] <-
  c("wonge@wcsu.edu")

# Create Email List To Read Into Listserv
x <- cmc[cmc$E.mail.Address != "",]
cmc_listserv <- data.frame(paste(x$E.mail.Address,x$First.Name,x$Last.Name))

#Write out Email List
write.table(cmc_listserv,"cmc_listserv_20161220.csv",row.names = FALSE,
            quote = FALSE,col.names = FALSE)
write.csv(cmc,"cmc_partners.csv",row.names = FALSE)
