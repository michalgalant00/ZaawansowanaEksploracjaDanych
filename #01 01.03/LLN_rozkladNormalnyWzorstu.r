# rozklad normalny (srednia, odchylenie std)
mu = 175
sigm = 20

x = seq(from=0, to=230, by=0.1)


res = dnorm(x, mean=mu, sd=sigm)

plot(x=x, y=res,
     main='Normal PDF', type='p', cex=0.2, col='red',
     xlim=c(min(x), max(x)),
     xlab='x', ylab='f(x)', las=1)

# ===============
mu = 180
sigma = 20
n = 10

set.seed(31415) # ziarno do losowania
x = rnorm(n, mean=mu, sd=sigma) # losowanie n wartości losowych z rozkładu normalnego o danych parametrach
x_bar = mean(x)

n_seq = seq(10, 10000, by=100)
length(n_seq)

x_bar_seq = NULL


mu = 180
sigma = 20

for(i in 1:length(n_seq))
{
  set.seed(31415)
  x = rnorm(n_seq[i], mean=mu, sd=sigma)
  x_bar = mean(x)
  x_bar_seq[i] = x_bar
}


plot(n_seq, x_bar_seq, main='LLN', col='black', cex=0.4, xlab='n', ylab='x_bar') # punkty to srednie z danej proby (proba caly czas sie zwieksza - n)
lines(x=n_seq, y=x_bar_seq, type='l', col='red')
abline(a=mu, b=0, col='black')