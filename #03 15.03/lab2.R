# średnia
my_mean = function(x) {
  return (sum(x) / length(x))
}

# wariancja
my_var = function(x) {
  return (sum((x - my_mean(x))^2) / length(x))
}

# 
my_sd = function(x) {
  return (sqrt(my_var(x)))
}

# TODO moze poprawic - dziala zaleznie od przypadku
# kwantyl q
my_quantile = function(x, q) {
  x = sort(x)
  n = length(x)
  mid = (n * q)
  
  if (n %% 2 == 1) {
    # Nieparzysta liczba elementów
    return(x[round(mid)])
  } else {
    # Parzysta liczba elementów
    lower_value <- x[floor(mid)]
    upper_value <- x[ceiling(mid)]
    return((lower_value + upper_value) / 2)
  }
}


x = rnorm(100, mean=0, sd=1)

summary(x)
#    Min.   1st Qu.   Median  Mean     3rd Qu.  Max. 
# -3.61742 -0.91145  0.01365 -0.08311  0.61839  2.01567 - konkretne wartosci dla danego wektora
my_quantile(x, 0.5)



# wygenerowac wzbior wrostow i wagi dla poszczegolnych krajow
# ?
dgp_p1 = function(n, seed=NULL) {
  if (!is.null(seed)) set.seed(seed)
  
  if (is.null(f)) f = function(x) 1 + 2*x
  
  x1 = rnorm(n, m=1, sd=2)
  eps = rnorm(n, m=0, sd=2)
  y = f(x1) + eps
  
  res = data.frame(y=y, x=x1)
  return (list(dataset(res=res)))
}


dgp_heights = function(n, seed=NULL) {
  if (!is.null(seed)) set.seed(seed)
  
  x1 = sample(c(0,1), n, replace=TRUE, prob=c(0.5, 0.5))
  eps = rnorm(n, m=0, sd=1)
  
  y = 164.7 + (13.7)*x1 + (1-x1)*7.07*eps + x1*7.59*eps
  
  sex = factor(x1)
  levels(sex) = c("female", "male")
  
  res = data.frame(height = round(y,2), sex=sex)
  return (res)
}


tmp = dgp_heights(n=10000, seed=31)
dta = tmp$dataset
head(dta)

par(mfrow=c(2,1))
hist(dta[dta&sex=='male','height'], xlab='male', main='')
title('Distribution of MALE heights')


# wygenerowac dane na podstawie jakichs danych - przecietne itd
# dla wybranego kraju, w latach 1880 i 1980
# country    year    height    sex     weight


