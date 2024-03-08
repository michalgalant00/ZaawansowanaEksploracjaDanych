#   p(i)=1/6
#   xi = {1,2,3,4,5,6} - populacja
#   E(xi) = 3,5 (ze wzoru) - abline
#   losowanie używając sample() zamiast rnorm()

# Ustawienie parametrów
p <- 1/6 # Prawdopodobieństwo dla każdej strony kostki
xi <- 1:6 # Możliwe wyniki od 1 do 6
mu <- sum(xi * p) # Wartość oczekiwana (średnia) ze wzoru na wartość oczekiwaną (E(xi))
n <- 10 # Liczba próbek

# Inicjalizacja pustej listy na średnie próbek
x_bar_seq <- NULL

# Zakres liczby próbek
n_seq <- seq(10, 10000, by = 100)

# Wykonanie symulacji
for(i in 1:length(n_seq)) {
  set.seed(31415)
  x <- sample(xi, n_seq[i], replace = TRUE, prob = rep(p, length(xi))) # Losowanie próbek z użyciem sample()
  x_bar <- mean(x)
  x_bar_seq[i] <- x_bar
}

# Wykres
plot(n_seq, x_bar_seq, main='LLN dla kostki szesciennej', col='black', cex=0.4, xlab='n', ylab='x_bar') # Punkty to średnie z danej próby (próba cały czas się zwiększa - n)
lines(x = n_seq, y = x_bar_seq, type = 'l', col = 'red') # Linia łącząca punkty
abline(a = mu, b = 0, col = 'black') # Linia dla wartości oczekiwanej