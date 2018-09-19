# DESC: This program used to exact meaningful titles from 'GOOD' label (精品区) and record urls, with a method of containing character '司命'.
# DATE: 2018/09/19
# NAME: likewen623
# ID: 容夏@流月城
# ENCODING: UTF-8


library(rvest)


site <- 'http://tieba.baidu.com/f?kw=%E5%8F%A4%E5%89%91%E5%A5%87%E8%B0%AD%E7%BD%91%E7%BB%9C%E7%89%88&ie=utf-8&tab=good'

url_gj <- read_html(site)

tiezi_title <- html_nodes(url_gj, ".j_th_tit")

# ### text
# html_text(tiezi_title, trim = TRUE)
# length(html_text(tiezi_title, trim = TRUE))
# tiezi_title[[1]]
# 
# xml_attrs(xml_child(tiezi_title[[1]], 2))[["title"]]
# xml_attrs(xml_child(tiezi_title[[2]]))[["title"]]
# 
# 
# xml_attrs(tiezi_title[[2]])[["title"]]  ### length(xml_children(tiezi_title[[2]])) == 0
# 
# 
# xml_attrs(xml_child(tiezi_title[[1]], 2))[["href"]]


### match title ###
title_pattern = '司命'
title_match <- function(title){
  if (grepl(title_pattern, title) == TRUE){
    return(TRUE)
  }
  else{
    return(FALSE)
  }
}

### get title's url list ###
title_list_url = ''
for (i in 1:length(html_text(tiezi_title, trim = TRUE))){
  if(length(xml_children(tiezi_title[[i]])) == 0) {
    cat(i, '\n')
    if (title_match(xml_attrs(tiezi_title[[i]])[["title"]])){
      title_list_url = c(title_list_url, xml_attrs(tiezi_title[[i]])[["href"]])
    }
  }
  else{
    cat(i, '\n')
    if (title_match(xml_attrs(xml_child(tiezi_title[[i]], length(xml_children(tiezi_title[[i]]))))[["title"]])){
      title_list_url = c(title_list_url, xml_attrs(xml_child(tiezi_title[[i]], length(xml_children(tiezi_title[[i]]))))[["href"]])
    }
  }
}

title_list_url = unique(title_list_url[2:length(title_list_url)])


### export url list###
write.table(title_list_url, 'title_list.txt', row.names = F, col.names = F, quote = FALSE)





