## required libraries:
## note: you need to register twitteR credentials before running!
library(ggplot2)
library(EBImage) 
library(jpeg)
library(grid)
library(twitteR)
library(ROAuth)




im.func.1 = function(image, k.cols = 10){
  # creating a dataframe:
  test.mat = matrix(image,ncol = 3)
  df = data.frame(test.mat)
  colnames(df) = c("r","g","b")
  df$y = rep(1:dim(image)[1],dim(image)[2])
  df$x = rep(1:dim(image)[2], each = dim(image)[1])
  
  # extracting colors:
  k2 = kmeans(df[,1:3],k.cols)
  
  # adding centers back:
  fit.test = fitted(k2)
  
  df$r.pred = fit.test[,1]
  df$g.pred = fit.test[,2]
  df$b.pred = fit.test[,3]
  
  return(df)
  
}

num.to.let = function(x1){
  ref.dat = data.frame(num = 10:15, let = LETTERS[1:6])
  out = as.character(x1)
  if(x1 %in% 10:15){out = as.character(ref.dat$let[which(ref.dat$num == x1)])}
  return(out)
}

rgb.func = function(vec){
  #note: vec is a triple of color intensities
  r1 = floor(255*vec[1])
  g1 = floor(255*vec[2])
  b1 = floor(255*vec[3])
  
  x1 = r1 %/% 16
  x2 = r1 %% 16
  x3 = g1 %/% 16
  x4 = g1 %% 16
  x5 = b1 %/% 16
  x6 = b1 %% 16
  
  x1 = num.to.let(x1)
  x2 = num.to.let(x2)
  x3 = num.to.let(x3)
  x4 = num.to.let(x4)
  x5 = num.to.let(x5)
  x6 = num.to.let(x6)
  
  out = paste("#",x1,x2,x3,x4,x5,x6, sep = "")
  return(out)
  
}

dot.size.func = function(n){
  dot = 1
  if(n>10000){dot = .5}
  if(n<5000){dot = 2}
  if(n<2000){dot = 3}
  if(n<1000){dot = 4}
  if(n<500){dot = 5}
  if(n<200){dot = 6}
  if(n>30000){dot = NA}
  return(dot)
}

general.func = function(user){
  
  get.em = getUser(user, cainfo = "cacert.pem")
  img = readImage(get.em$profileImageUrl)
  n.follow = get.em$followersCount
  
  dot.size = dot.size.func(n.follow)
  
  dat1 = data.frame(x = runif(n.follow,0,dim(img)[2]),
                    y = runif(n.follow,0,dim(img)[1]),
                    radius = rep(dot.size,n.follow))
  
  temp = im.func.1(img,k.cols = 10)
  
  dat1$x.round = round(dat1$x,0)
  dat1$y.round = round(dat1$y,0)
  
  dat1$x.round[dat1$x.round == 0] = 1
  dat1$y.round[dat1$y.round == 0] = 1
  
  
  
  dat1 = merge(dat1,temp,by.x = c("x.round","y.round"), by.y = c("x","y"))
  
  # splice in the colors:
  dat1$col = apply(dat1[9:11],1,rgb.func)
  
  ## trying out a different plot:
  dat1$x = max(dat1$x) - dat1$x
  
  g = rasterGrob(img, interpolate = TRUE)
  
  p = ggplot(dat1,aes(x = y, y = x, col = col)) + geom_point(size = dat1$radius) + scale_colour_identity() +
    ylim(min(temp$x),max(temp$x)) +
    xlim(min(temp$y),max(temp$y + 50)) +
    theme_bw() +
    theme(line = element_blank(),
          text = element_blank(),
          line = element_blank(),
          title = element_blank()) +
    annotation_custom(g, xmin = max(temp$y) + 2, xmax = max(temp$y) + 50, ymin = -Inf, ymax = Inf)
  
  return(print(p))
}


t.start = Sys.time()
general.func("revodavid")
t.end = Sys.time()
t.end - t.start


ggsave("RD.png", width = 8.25, height =4.42)