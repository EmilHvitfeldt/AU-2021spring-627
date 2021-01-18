new_render <- function(dir = "readings") {

  old_names <- fs::dir_ls(dir)

  new_names <- basename(old_names)

  if (any(new_names %in% fs::dir_ls())) {
    stop("Files in folders can not have same name as main files")
  }

  fs::file_move(old_names, new_names)

  rmarkdown::render_site()

  fs::file_move(new_names, old_names)
}

new_render()
browseURL("_site/index.html")
