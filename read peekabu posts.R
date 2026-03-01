require(xml2)
pri <- as_list(read_xml('lifeofpri'))[[1]][[1]]

posts <- pri[names(pri)=='item']

for(post in posts) {
  post <- post[names(post) != 'comment'] 
  for(i in 1:length(post)) {
    if(length(post[[i]])==2)
      post[post[[i]][[1]][[1]]] <- post[[i]][[2]][[1]] else
        if(length(post[[i]])==1)
          post[[i]] <- post[[i]][[1]]
  }
  post <- post[names(post) != 'postmeta' & names(post) != 'description' & names(post) != 'comment' & names(post) != 'post_password']
  post <- post[lapply(post, length) > 0]
  post <- as.tibble(as.data.frame(post))
  if(exists('postDF'))
    postDF <- postDF %>% bind_rows(post) else
      postDF <- post
}

postCats <- postDF %>% 
  select(title, post_name, post_id, contains('category')) %>%
  gather(Number, Category, -title, -post_name, -post_id) %>% 
  select(-Number) %>% 
  filter(!is.na(Category))

postDF <- postDF %>% 
  select(-contains('X_'), -contains('category'), -encoded.1) %>% 
  mutate(
    Date=as.Date(substr(post_date,1,10)),
    post_time_gmt=as.POSIXct(post_date_gmt, format='%Y-%m-%d %H:%M:%OS'),
    post_time_local=as.POSIXct(post_date, format='%Y-%m-%d %H:%M:%OS'),
    content=tolower(encoded)
    ) 
  




