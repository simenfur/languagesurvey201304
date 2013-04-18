setwd("~/projects/languagesurvey201304/.")

survey <- read.csv("./LanguageSurvey.csv")
languages <- read.csv("./ResultsInit.csv")

row.names(languages) <- languages$X
languages$X <- NULL

for (i in 1:nrow(survey))  {
  programmer <- survey[i,]
  
  knownLanguages <- strsplit(as.character(survey[i,"Kjennskap"]), ", ")
 
  for(knownLanguage in knownLanguages[[1]]){
  	languages[knownLanguage, "Knows"] <- languages[knownLanguage, "Knows"] + 1
  }

  worksWith <- as.character(programmer$Jobber.med)
  wants <- as.character(programmer$Vil.jobbe.med)
  

  languages[worksWith, "Uses"] <- languages[worksWith, "Uses"] + 1
  languages[wants, "Wants"] <- languages[wants, "Wants"] + 1

  if (worksWith == wants) 
      languages[worksWith, "Loyal"] <- languages[worksWith, "Loyal"] + 1
  else 
      languages[wants, "Trendy"] <- languages[wants, "Trendy"] + 1
}

languages$KnowsPercent <- round(languages$Knows / sum(languages$Uses), digits=2)
languages$UsePercent <- round(languages$Uses / sum(languages$Uses), digits=2)
languages$LoyaltyPercent <- round(languages$Loyal / languages$Uses, digits=2)
languages$TrendyPercent <- round(languages$Trendy / sum(languages$Trendy), digits=2)
languages$ApplicantsForJob <- round(languages$Trendy / (languages$Jobs+5), digits=2)

write.csv(languages, "./LanguageAnalysis.csv")
