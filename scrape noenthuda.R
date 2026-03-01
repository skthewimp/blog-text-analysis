require(RCurl)
require(XML)
posts <- c()

for(i in i:334) {
  url <- paste('http://noenthuda.com/blog/page/',i,'/',sep='')
  doc <- htmlParse(url)
  posts <- c(posts, xpathSApply(doc, "//a/@href"))
  free(doc)
}

posts <- as.vector(posts)
posts <- gsub('#comments', '', posts)
posts <- gsub('#respond', '', posts)
posts <- unique(posts)
blogs <- posts[grepl('http://noenthuda.com/blog/20', posts)]
blogs <- sort(blogs)

for(blog in blogs[(which(blogs==blog)+1):length(blogs)]) {
  blogPage <- read_html(blog)
  title <- blogPage %>% html_nodes("h1") %>% html_text()
  blogContent <- blogPage %>% html_nodes("p") %>% html_text()
  blogContent <- blogContent[2:which(grepl('Enter your email address to subscribe to this blog and receive notifications of new posts by email.', blogContent))[1]-1]
  year <- as.numeric(unlist(strsplit(blog, '\\/'))[5])
  month <- as.numeric(unlist(strsplit(blog, '\\/'))[6])
  day <- as.numeric(unlist(strsplit(blog, '\\/'))[7])
  numParagraphs <- length(blogContent)
  
  thisPost <- tibble(url=blog, title=title, content=paste(blogContent, collapse=' '), year=year, month=month,day=day, paraCount=numParagraphs)
  if(exists('allPosts'))
    allPosts <- allPosts %>% bind_rows(thisPost) else
      allPosts <- thisPost
  print(paste(which(blogs==blog),blog, year, month, day, Sys.time()))
}

save(blogs, allPosts, file='allNEDLinks.RData')

