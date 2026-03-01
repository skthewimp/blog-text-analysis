# Blog Text Analysis

I've been blogging at [noenthuda.com](http://noenthuda.com) since the mid-2000s - close to two decades of writing. At some point I got curious about what all that writing looks like when you treat it as data. This repo is the result.

## What's here

The analysis works in three stages:

1. **Scraping** - `scrape noenthuda.R` crawls through all 334 pages of the blog and pulls every post into a tidy dataframe. `read NED posts.R` does the same thing from a WordPress XML export (faster, and doesn't hammer the server). There's also `read peekabu posts.R` for a companion blog.

2. **Text analysis** - `analyse ned.Rmd` is where the fun stuff happens. TF-IDF to find the distinctive words in each post. K-means clustering on the TF-IDF matrix to see if posts naturally group into topics (they don't, really). LDA topic modeling (which works better). Sentiment analysis using Bing and NRC lexicons, plotted over time - you can see my mood shift across the years, with some interesting life events marked as vertical lines.

3. **Readability** - `fk score.R` and `syllable count.R` compute Flesch-Kincaid readability scores for every post. `ned analysis.Rmd` tracks word count and post frequency over time - turns out my posts have gotten longer and less frequent, which probably surprises nobody.

## The notebooks

- `analyse ned.Rmd` / `.nb.html` - The main analysis: topic modeling, sentiment tracking, n-gram extraction
- `ned analysis.Rmd` / `.nb.html` - Post frequency, word count trends, readability over time

## Data

Data files aren't included in the repo (they contain the full text of personal blog posts). The scraping scripts will regenerate them if you point them at the right blog, or you can parse your own WordPress XML export with `read NED posts.R`.

## Dependencies

R, with `tidyverse`, `tidytext`, `xml2`, `stm`, `topicmodels`, `quanteda`, `rvest`.
