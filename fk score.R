
pri <- postDF %>%
  select(Date, content, title, post_id) %>% 
  mutate(
    content=gsub("<.*?>", "",content),
    content=tolower(content), 
    content=gsub("[^0-9a-z \\.\\']", '', content),
    wordCount = str_count(content, '\\s+') + 1,
    sentenceCount = str_count(content, '[[:alnum:] ][.!?]') + 1, 
    syllableCount = sapply(content, english_syllable_count), 
    FK=0.39 * wordCount/sentenceCount + 11.58 * syllableCount / wordCount - 15.59)

save(pri, postDF, postCats, file='peekabu fk.RData')
