#### Hacker Rank 

data.frame(matrix(nrow = 1, ncol = 2))
#
# Complete the 'sockMerchant' function below.
#
# The function is expected to return an INTEGER.
# The function accepts following parameters:
#  1. INTEGER n
#  2. INTEGER_ARRAY ar
#


# unique
# iterate thru unique and count how many in the original list, add to total sum
# 
# sockmerchant <- function(n,ar){
#   unique.values <- unique(ar)
#   count <- rep(0, length(unique.values))
#   for (i in 1:length(unique.values)){
#     count[i] <- sum(ar == unique.values[i])
#   }
#   temp <- count/2
#   pairs <- floor(temp)
#   return(sum(pairs))
# }
# 
# sockMerchant <- function(n, ar) {
#  un <- unique(ar)
#  
#      
#    }
#  }
#   
# }


other_angle <- function(a, b){
  third <- "hi"
  return (third)
}


##### REMOVE SMALLEST FROM ITS POSITION, IF MORE THAN 1 REMOVE FIRST OCCURRENCE
#### mine

remove_smallest <- function(numbers){
  if (length(numbers) == 0){
    return (numbers)
  } else {
    for (i in 1:length(numbers)){
      if (numbers[i] == min(numbers)) { # if the number is the same as the min, del the i
        num1 <- numbers[-i]
      }
    }
    return (num1)
  }
}
remove_smallest(integer(0))

#### fast way LOL
remove_smallest <- function(numbers) {
  numbers[-which.min(numbers)]
}

remove_smallest <- function(n) n[-which.min(n)]

length(c(2, 2, 1, 4, 5))

min(integer(0))
which.min(integer(0))


#######

# small_enough <- function(vector, limit) {
#  a <- 0
#  for (i in vector) {
#    if (i > limit) {
#      a = a + 1
#    }
#  }
#  a == 0
# }
# 
# small_e <- function(vector, limit) {
#   all(vector <= limit)
# }
# 
# 
# # if num is more than limit, a > 0. so if a = 0 then they are all below
# is_pangram <- function(s){
#   all(letters %in% unlist(strsplit(tolower(s), "")))
# }
#  

########
renumber <- function(lines) {
  fin = "c("
  for (i in lines) {
    fin <- paste(fin,which(lines == i),": ", i,",") 
  }
  print(paste(fin,")"))
}
      
      