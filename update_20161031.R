# Read in existing cmc_partners
cmc <- read.csv("cmc_partners.csv", stringsAsFactors = FALSE)[,-1]

# Create Unique Organizations List
orgs <- data.frame(Organization = unique(cmc$Affiliation))

#Write out Unique Organizations List
write.csv(orgs,"cmc_orgs.csv",row.names = FALSE)

