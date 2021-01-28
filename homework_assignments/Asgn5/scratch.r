cutoff <- 40
baseline <- 0.001
enrich <- 0.05
ngenes <- 1e4
top <- sample(c(0,1), size = cutoff, replace = T, prob = c(1-enrich, enrich))
bot <- sample(c(rep(0, (1-baseline) * (ngenes - cutoff) + sum(top)), rep(1, ngenes*baseline - sum(top))),
                size = ngenes-cutoff, replace = F)
alldat <- c(top, bot)
epval <- numeric(ngenes)
escore <- numeric(ngenes)
for (i in 1:ngenes) {
  epval[i] <- phyper(
    q = sum(ranked_list[1:i])-1,
    m = baseline*ngenes,
    n = (1-baseline) * ngenes,
    k = i,
    lower.tail = F,
    log.p = F
  )
  expected = baseline * i
  ## ENRICMENT FUNCTION:
  escore[i] <- sum(alldat[1:i]) - expected
}
plot(x=1:ngenes, y=escore, type='l', xlim=c(0,100))
plot(x=1:ngenes, y=escore, type='l')
abline(h=0)
# plot(x=1:ngenes, y=epval)
# abline(h=log(0.05), col = 'red', lty=2)

