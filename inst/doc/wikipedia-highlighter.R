## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----data, eval=FALSE---------------------------------------------------------
# 
# class_of_interest <- ".mw-content-ltr" ## ids are #id-name, classes are .class-name
# 
# editurl <- "https://en.wikipedia.org/w/index.php?title=Highlighter&action=history&offset=&limit=150"
# editclass_of_interest <- ".mw-changeslist-date"
# 
# url_list1 <- editurl %>%
#   read_html() %>%
#   html_nodes(editclass_of_interest) %>%
#   map(., list()) %>%
#   tibble(node = .) %>%
#   mutate(link = map_chr(node, html_attr, "href") %>% paste0("https://en.wikipedia.org", .))
# 
# editurl2 <- "https://en.wikipedia.org/w/index.php?title=Highlighter&action=history&dir=prev&limit=150"
# 
# url_list2 <- editurl2 %>%
#   read_html() %>%
#   html_nodes(editclass_of_interest) %>%
#   map(., list()) %>%
#   tibble(node = .) %>%
#   mutate(link = map_chr(node, html_attr, "href") %>% paste0("https://en.wikipedia.org", .))
# 
# url_list <- rbind(url_list1, url_list2)
# 
# wiki_pages <- data.frame(page_notes = rep(NA, dim(url_list)[1]))
# 
# for (i in 1:dim(url_list)[1]){
# 
#   wiki_list <-  url_list$link[i] %>%
#     read_html() %>%
#     html_node(class_of_interest) %>%
#     html_children() %>%
#     map(., list()) %>%
#     tibble(node = .) %>%
#     mutate(type = map_chr(node, html_name)) %>%
#     filter(type == "p") %>%
#     mutate(text = map_chr(node, html_text)) %>%
#     mutate(cleantext = str_remove_all(text, "\\[.*?\\]") %>% str_trim()) %>%
#     plyr::summarise(cleantext = paste(cleantext, collapse = "<br> "))
# 
#   wiki_pages$page_notes[i] <- wiki_list$cleantext[1]
# 
# }
# 

## ----setup--------------------------------------------------------------------
library(highlightr)

toks_comment <- token_comments(highlightr::wiki_pages)

## -----------------------------------------------------------------------------

transcript_example_rename <- data.frame(text=wiki_pages[1,])

toks_transcript <- token_transcript(transcript_example_rename)


## -----------------------------------------------------------------------------

collocation_object <- collocate_comments_fuzzy(toks_transcript, toks_comment)

head(collocation_object)


## -----------------------------------------------------------------------------

merged_frequency <- transcript_frequency(transcript_example_rename, collocation_object)


freq_plot <- collocation_plot(merged_frequency)

page_highlight <- highlighted_text(freq_plot, labels=c("(fewest articles)", "(most articles)"))

## -----------------------------------------------------------------------------

transcript_example_rename2 <- data.frame(text=wiki_pages[dim(wiki_pages)[1],])

toks_transcript2 <- token_transcript(transcript_example_rename2)

collocation_object2 <- collocate_comments_fuzzy(toks_transcript2, toks_comment)


merged_frequency2 <- transcript_frequency(transcript_example_rename2, collocation_object2)


freq_plot2 <- collocation_plot(merged_frequency2)

page_highlight2 <- highlighted_text(freq_plot2, labels=c("(fewest articles)", "(most articles)"))


