library(dplyr)
library(lubridate)
library(RTextTools)

maf <- read.csv("~/WildIsolates/FelixDB/FelixDB.csv")
labguru <- read.csv("~/WildIsolates/FelixDB/labguru db-Table 1.csv")
wb <- read.csv("~/WildIsolates/wormbase_wildisolates.csv")
mmp <- read.csv("~/WildIsolates/FelixDB/MMP WI Origins-Table 1.csv")

maff <- maf %>%
    filter(GENOTYPE %in% c("wild  isolate",
                           "wild isolate",
                           "wild Isolate",
                           "Wild isolate",
                           "wild isolate ",
                           "wild isolate  ",
                           "wild isolate, ",
                           "Wild isolate."),
SPECIES == "Caenorhabditis elegans") %>%
    rename(strain = STRAIN)
lgf <- labguru %>% filter(Genotype == "wild type") %>%
    rename(strain = Name)
wbf <- wb %>% filter(species == "Caenorhabditis elegans")
mmpf <- mmp %>% rename(strain = Strain)

################## MAF ##################

# Correct MAF FROM column to real names matching wormbase
maff$FROM <- as.character(maff$FROM)
maff$FROM[maff$FROM == "MAF" | maff$FROM == " MAF"] <- "Marie-Anne Felix"
maff$FROM[maff$FROM == "Antoine Barrière" | maff$FROM == "A. Barrière"] <- "Antoine Barriere"
maff$FROM[maff$FROM == "D. Baïlle"] <- 
maff$FROM[maff$FROM == "Tony Bélicard"] <- "Tony Belicard"
maff$FROM[maff$FROM == "Elie Dolgin - from Dolgin box"] <- "Elie Dolgin"
maff$FROM[maff$FROM == "Lise Frézal (LF)"
          | maff$FROM == "LF"
          | maff$FROM == "LF "] <- "Lise Frezal"
maff$FROM[maff$FROM == "SM"] <- "Sarah Marsh"
maff$FROM[maff$FROM == "MB"] <- "Michalis Barkoulas"
maff$FROM[maff$FROM == "AR"] <- "Aurelien Richaud"
maff$FROM[maff$FROM == "John DeModena, Kelley Thomas"] <- "John DeModena"
maff$FROM[maff$FROM == "FB"] <- "Fabrice Besnard"
maff$FROM[maff$FROM == "R. Luallen & MAF"] <- "Robert Luallen"
maff$FROM[maff$strain == "JU848"] <- "Jean-Antoine Lepesant"

# Get dates from Mary Anne Felix's Data 
datepos <- regexpr("[0-9]{1,2}\\s+[A-Z][a-z]{2,8}\\.?\\s+[0-9]{2,4}", maff$COMMENTS)
View(data_frame(test, maff$date))

dates <- dmy(substr(maff$COMMENTS, datepos, datepos+attr(datepos ,"match.length")))

# Correct for parsing errors
for (i in seq_along(dates)) {
    x <- dates[i]
    if (!is.na(x)){
        if (year(x) < 2000) {
            dates[i] <- x + years(2000)
        } else {
            dates[i] <- x
        }
    } else {
        dates[i] <- NA
    }
}

maff$date <- dates

maff$date[maff$strain == "JU360"] <- lubridate::mdy("9/16/2002")
maff$date[maff$strain == "JU361"] <- lubridate::mdy("9/16/2002")
maff$date[maff$strain == "JU362"] <- lubridate::mdy("9/16/2002")
maff$date[maff$strain == "JU363"] <- lubridate::mdy("9/16/2002")
maff$date[maff$strain == "JU364"] <- lubridate::mdy("9/16/2002")
maff$date[maff$strain == "JU365"] <- lubridate::mdy("9/16/2002")
maff$date[maff$strain == "JU366"] <- lubridate::mdy("9/16/2002")
maff$date[maff$strain == "JU367"] <- lubridate::mdy("9/16/2002")
maff$date[maff$strain == "JU368"] <- lubridate::mdy("9/16/2002")
maff$date[maff$strain == "JU369"] <- lubridate::mdy("9/16/2002")
maff$date[maff$strain == "JU370"] <- lubridate::mdy("9/16/2002")
maff$date[maff$strain == "JU371"] <- lubridate::mdy("9/16/2002")

maff$date[maff$strain == "JU393"] <- lubridate::mdy("9/02/2002")
maff$date[maff$strain == "JU394"] <- lubridate::mdy("9/02/2002")
maff$date[maff$strain == "JU395"] <- lubridate::mdy("9/02/2002")
maff$date[maff$strain == "JU396"] <- lubridate::mdy("9/02/2002")
maff$date[maff$strain == "JU397"] <- lubridate::mdy("9/02/2002")
maff$date[maff$strain == "JU398"] <- lubridate::mdy("9/02/2002")
maff$date[maff$strain == "JU399"] <- lubridate::mdy("9/02/2002")
maff$date[maff$strain == "JU400"] <- lubridate::mdy("9/02/2002")
maff$date[maff$strain == "JU401"] <- lubridate::mdy("9/02/2002")
maff$date[maff$strain == "JU402"] <- lubridate::mdy("9/02/2002")

maff$date[maff$strain == "JU814"] <- lubridate::mdy("7/13/2005")
maff$date[maff$strain == "JU815"] <- lubridate::mdy("7/13/2005")
maff$date[maff$strain == "JU816"] <- lubridate::mdy("7/13/2005")
maff$date[maff$strain == "JU817"] <- lubridate::mdy("7/13/2005")
maff$date[maff$strain == "JU818"] <- lubridate::mdy("7/13/2005")
maff$date[maff$strain == "JU819"] <- lubridate::mdy("7/13/2005")
maff$date[maff$strain == "JU820"] <- lubridate::mdy("7/13/2005")
maff$date[maff$strain == "JU821"] <- lubridate::mdy("7/13/2005")
maff$date[maff$strain == "JU822"] <- lubridate::mdy("7/13/2005")

maff$date[maff$strain == "JU1395"] <- lubridate::mdy("1/03/2008")

maff$date[maff$strain == "ED3048"] <- lubridate::mdy("4/02/2008")
maff$date[maff$strain == "ED3049"] <- lubridate::mdy("4/02/2008")

maff$date[maff$strain == "ED3049"] <- lubridate::mdy("6/09/2013")


# The location of as many missing MAF strains as possible

locationpos <- regexpr("-?[0-9]{1,3}[\\.,][0-9]*\\s?[,;]\\s?-?[0-9]{1,3}[\\.,][0-9]*", maff$COMMENTS)
latlon <- substr(maff$COMMENTS, locationpos, locationpos+attr(locationpos ,"match.length")-1)
semicolon <- sapply(latlon, function(x){ifelse(grepl(";", x), return(x), return(NA))})
comma <- sapply(latlon, function(x){ifelse(grepl(";", x), return(x), return(NA))})

semicolon











setdiff(maff$strain, wbf$strain)
mafwbmissing <- maff %>% filter(strain %in% setdiff(maff$strain, wbf$strain))

setdiff(lgf$strain, wbf$strain)
lgwbmissing <- lgf %>% filter(strain %in% setdiff(lgf$strain, wbf$strain))

setdiff(mmpf$strain, wbf$strain)
mmpfwbmissing <- mmpf %>% filter(strain %in% setdiff(mmpf$strain, wbf$strain))


colnames(wb)

maff$date <- dmy(maff$COMMENTS)

lg$date <- 







selected <- final %>% select(-SPECIES,
                             -GENOTYPE,
                             -OTHER.NAMES,
                             -SysID,
                             -Genotype,
                             -Outcrossed,
                             -Date.frozen,
                             -Box.name,
                             -X,
                             -Obtained.from.Supp..Table.10)

reordered <- selected %>% select(strain,
                                 Isolation.date,
                                 Year.Isolated,
                                 Gps.latitude,
                                 latitude,
                                 Gps.longitude
                                 )






one <- dplyr::full_join(wbf, maff, by="strain")
two <- dplyr::full_join(one, lgf, by="strain")
final <- dplyr::full_join(two, mmpf, by="strain")

final$strain[grepl("^[a-zA-Z0-9]*$", final$strain)]
