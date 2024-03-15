# rozkład dla wzrostu w jakiejś populacji ludzi
# n = 10 # zwiększanie n da większą dokładność
# mu = 175
# sigma = 10
# 
# k = 100
# 
# x_bar_seq = NULL
# for (i in 1:k) {
#   x = rnorm(n, mu, sigma)
#   x_bar = mean(x)
#   x_bar_seq[i] = x_bar
#   z = x_bar_seq[i] = x_bar
# }
# 
# hist(x_bar_seq, xlim=c(168, 182))
# abline(v=mean(x_bar_seq), col='red')


# ???
# na rozkładzie dyskretnym (rzut monetą) 
# n = 20000 # zwiększanie n da większą dokładność
# k = 100 # ?
# xi = 0:1
# 
# x_bar_seq = NULL
# for (i in 1:k) {
#   x = sample(0:1, n, replace=TRUE)
#   x_bar = mean(x)
#   x_bar_seq[i] = x_bar
# }
# 
# hist(x_bar_seq)
# abline(v=mean(x_bar_seq), col='red')

# to samo co w 1. ale bimodalny (z podzialem na plcie)
# n = 100
# k = 100
# muM = 180
# muF = 165
# sigmaM = 4
# sigmaF = 3
# 
# # dla jednej proby
# xM = rnorm(n, muM, sigmaM)
# xF = rnorm(n, muF, sigmaF)
# # hist(c(xM, xF))
# 
# x_bar_seq = NULL
# for (i in 1:k) {
#   xM = rnorm(n, muM, sigmaM)
#   xF = rnorm(n, muF, sigmaF)
#   x = c(xM, xF)
#   x_bar = mean(x)
#   x_bar_seq[i] = x_bar
# }
# 
# hist(x_bar_seq)
# abline(v=mean(x_bar_seq), col='red')


# jeszcze cos innego
n = 100
k = 100
mu = 180
sigma = 4

x_bar_seq = NULL
for (i in 1:k) {
  x = rnorm(n, mu, sigma)
  x_bar = (mean(x) - mu)*sqrt(n)
  x_bar_seq[i] = x_bar
}

sr = mean(x_bar_seq)
hist(x_bar_seq)
abline(v=sr, col='red') # granice: srednia-+odchylenie std


# wysamplowac k razy daną srednią liczoną dla rozkładu n i potem nakładaną na ten wykres z lab0 + 3sigmy
# generowanie roznych rozkladow/roznych zmiennych


