library(textrecipes)
library(animals)

animals <- animals %>%
  filter(!is.na(mean_weight)) %>%
  mutate(mean_weight = log(mean_weight))

rec_spec <- recipe(mean_weight ~ text, data = animals) %>%
  step_tokenize(text) %>%
  step_stopwords(text) %>%
  step_tokenfilter(text, max_tokens = 1000) %>%
  step_tf(text)

animals <- prep(rec_spec) %>%
  bake(new_data = NULL) %>%
  rename(weight = mean_weight)

colnames(animals) <- gsub("_text", "", colnames(animals))

readr::write_csv(animals, "data/animals.csv")
