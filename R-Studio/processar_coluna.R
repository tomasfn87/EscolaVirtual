vector <- c(100, 200, 300, 400, 500)
vector

df <- data.frame(base_value = vector)
df

df$bonus_1 <- ifelse(df$base_value <= 100,
                     df$base_value * 1.2,  # raise by 20%
              ifelse(df$base_value >  100 & df$base_value <= 200,
                     df$base_value * 1.18, # raise by 18%
              ifelse(df$base_value >  200 & df$base_value <= 300,
                     df$base_value * 1.16, # raise by 16%
              ifelse(df$base_value >  300 & df$base_value <= 400,
                     df$base_value * 1.14, # raise by 14%
              ifelse(df$base_value >  400 & df$base_value <  500,
                     df$base_value * 1.12, # raise by 12%
                     df$base_value * 1.1   # raise by 10%
                    )))))
df

calc_bonus <- function(num) {
  if (num <= 100) {
    return(num * 1.2)
  } else if (num > 100 & num <= 200) {
    return(num * 1.18)
  } else if (num > 200 & num <= 300) {
    return(num * 1.16)
  } else if (num > 300 & num <= 400) {
    return(num * 1.14)
  } else if (num > 400 & num <  500) {
    return(num * 1.12)
  } else {
    return(num * 1.1)
  }
}

df$bonus_2 <- sapply(df$base_value, calc_bonus)
df
