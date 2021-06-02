p <- get_googlemap("seoul", zoom = 14) %>% ggmap()
p
subway <- fread("D:/SKKU 2021/Daeyong/Project/Dataset/subway.csv")
subway
subway$'전철역명' <- ifelse(str_detect(subway$'전철역명', "역"), subway$'전철역명', paste0(subway$'전철역명',"역"))
subway_latlon <- mutate_geocode(subway, 전철역명)
subway_latlon

bus <- fread("D:/SKKU 2021/Daeyong/Project/Dataset/bus.csv")
str(bus)
bus