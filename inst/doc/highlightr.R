## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(highlightr)
comment_example_rename <- dplyr::rename(comment_example, page_notes=Notes)

toks_comment <- token_comments(comment_example_rename)

## ----message=FALSE, warning=FALSE---------------------------------------------
transcript_example_rename <- dplyr::rename(transcript_example, text=Text)

toks_transcript <- token_transcript(transcript_example_rename)

## ----message=FALSE, warning=FALSE---------------------------------------------
collocation_object <- collocate_comments_fuzzy(toks_transcript, toks_comment)

head(collocation_object)


## ----message=FALSE, warning=FALSE---------------------------------------------
merged_frequency <- transcript_frequency(transcript_example_rename, collocation_object)

## ----message=FALSE, warning=FALSE---------------------------------------------
freq_plot <- collocation_plot(merged_frequency)

## ----message=FALSE, warning=FALSE---------------------------------------------

page_highlight <- highlighted_text(freq_plot)


## ----message=FALSE, warning=FALSE---------------------------------------------
collocation_object_nonfuzzy <- collocate_comments(toks_transcript, toks_comment)

head(collocation_object_nonfuzzy)


## ----message=FALSE, warning=FALSE---------------------------------------------
merged_frequency_nonfuzzy <- transcript_frequency(transcript_example_rename, collocation_object_nonfuzzy)

freq_plot_nonfuzzy <- collocation_plot(merged_frequency_nonfuzzy, colors=c("#15bf7e", "#fcc7ed"))

page_highlight_nonfuzzy <- highlighted_text(freq_plot_nonfuzzy)

## ----message=FALSE, warning=FALSE---------------------------------------------
collocation_object_2col <- collocate_comments(toks_transcript, toks_comment, collocate_length = 2)

head(collocation_object_2col, n=7)


## ----message=FALSE, warning=FALSE---------------------------------------------
merged_frequency_2col <- transcript_frequency(transcript_example_rename, collocation_object_2col)

freq_plot_2col <- collocation_plot(merged_frequency_2col)

page_highlight_2col <- highlighted_text(freq_plot_2col)

