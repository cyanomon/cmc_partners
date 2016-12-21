# Read in existing cmc_partners
cmc <- read.csv("cmc_partners.csv", stringsAsFactors = FALSE)

# Add new names from Hilary
cmc <- rbind(cmc,c("Bryan","Milstead","milstead.william@epa.gov", 
                   "United States Environmental Protection Agency Atlantic Ecology Division", 
                   "https://www.epa.gov/aboutepa/about-atlantic-ecology-division-aed-epas-national-health-and-environmental-effects-research"))



#Write out Email List
x <- cmc[cmc$E.mail.Address != "",]
cmc_listserv <- data.frame(paste(x$E.mail.Address,x$First.Name,x$Last.Name))
write.table(cmc_listserv,"cmc_listserv_20161221.csv",row.names = FALSE,
            quote = FALSE,col.names = FALSE)
write.csv(cmc,"cmc_partners.csv",row.names = FALSE)
