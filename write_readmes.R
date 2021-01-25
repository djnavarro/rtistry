library(here)
library(brio)
library(tidyverse)



# helper functions --------------------------------------------------------

# writes a single img html tag
tagify <- function(img, folder, width) {
  paste0('<img src="', folder, "/", img, '" width = "', width, '"> ')
}

# writes img tags for all jpg files in the folder
write_tags <- function(folder, width = "30%") {
  folder %>% 
    list.files(pattern = ".*\\.jpg$") %>% 
    map_chr(~tagify(.x, folder, width)) %>% 
    paste(collapse = " ")
}

# writes simple markdown readme
write_readme <- function(folder) {
  lines <- c(
    paste0("# ", str_to_title(folder)), 
    "",
    write_tags(folder),
    ""
  )
  write_lines(lines, here(folder, "README.md"))
}



# locate the galleries and write readmes ----------------------------------

galleries <- list.dirs(recursive = FALSE) %>% 
  str_subset("./[^.]") %>% 
  str_remove("^./")

walk(galleries, write_readme)
