#install.packages(c("knitr", "rmarkdown"))

### initialization ###
father_path = 'D:/Desktop/SimingStrategy'
setwd(father_path)

library(rmarkdown)
library(knitr)
library(rvest)

### read urls###

url_list = readLines('title_list.txt')

url_list = lapply(url_list, function(x) paste0('http://tieba.baidu.com', x, '?see_lz=1'))

### main loop ###
for (i in 1:length(url_list)){
  title_header <- html_nodes(read_html(url_list[[i]]), ".core_title_txt")
  header = html_text(title_header, trim = TRUE)[[1]]
  cat(i, '\n')
  rmarkdown::render("scrape_test.Rmd",
                    encoding = 'UTF-8',
                    params = list(
                      url = url_list[[i]],
                      file_number = i,
                      father_path = father_path),
                    output_file = "TEST.pdf",
                    output_format = 'pdf_document')  
}
