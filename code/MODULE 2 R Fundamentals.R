# MODULE 2 - R fundamentals
#
# (c) Copyright 2015-2020 - AMULET Analytics
# ---------------------------------------------------------------

# Subsetting

x <- c("a", "b", "c", "c", "d", "a")  # Define character vector
x[1]
#[1] "a"

x[2]
#[1] "b"

x[1:4]              # Select elements 1 through 4
#[1] "a" "b" "c" "c"

x[x > "a"]          # Select all elements with value > "a"
#[1] "b" "c" "c" "d"

u <- x > "a"        # Create a logical vector
u
#[1] FALSE TRUE TRUE TRUE TRUE FALSE

x[u]                # Use logical vector as an index for x
#[1] "b" "c" "c" "d"


# ---------------------------------------------------------------

# Subsetting a matrix

# Matrices can be subsetted in the usual way with (i, j) type 
# indices.
#
# NOTE: a matrix does NOT have to be square.

x <- matrix(1:6, 2, 3)
#     [,1] [,2] [,3]
#[1,]    1    3    5
#[2,]    2    4    6

x[1, 2]     # A single element
#[1] 3

x[2, 1]     # A single element
#[1] 2

x[1, ]      # first row. This notation is used all the time!!
#[1] 1 3 5

x[, 2]      # 2nd column
#[1] 3 4


# ---------------------------------------------------------------

# More subsetting a matrix

# By default, when a single element of a matrix is retrieved, it is returned as a vector
# of length 1 rather than a 1x1 matrix. This behavior can be turned off by setting drop=FALSE

x <- matrix(1:6, 2, 3)
x[1, 2]       # A vector of 1 element, NOT a 1x1 matrix
#[1] 3

x[1, 2, drop = FALSE]   # Preserve dimension of x so get a matrix
#     [,1]
#[1,]    3


# ---------------------------------------------------------------

# Even more subsetting a matrix

# Similarly, subsetting a single column or a single row will give you a vector, not a
# matrix (by default)

x <- matrix(1:6, 2, 3)
x[1, ]                 # This is an integer vector with 3 elems
#[1] 1 3 5

# Class is "matrix"
x[1, , drop = FALSE]   # Take 1st row of matrix, create 1x3 matrix
#     [,1] [,2] [,3]
#[1,]    1    3    5


# ---------------------------------------------------------------

# Subsetting lists

x <- list(foo = 1:4, bar = 0.6)    # Define a ragged list
x
#$foo
#[1] 1 2 3 4
#
#$bar
#[1] 0.6

x[1]                 # Print 1st element of list x     
#$foo
#[1] 1 2 3 4

class(x[1])          # Class "list"

x$foo                # Print integer vector

class(x$foo)         # Class "integer"


x[[1]]             # Class "integer" vector
#[1] 1 2 3 4

class(x[[1]])      # Class "integer"

# --------------------------------------------

x[2]

class(x[2])         # Class "list"

x$bar               # Class "numeric"
#[1] 0.6

x[[2]]

class(x[[2]])       # Class "numeric"

x[["bar"]]         # Class "numeric"
#[1] 0.6

x["bar"]           # Class "list"
#$bar
#[1] 0.6


# ---------------------------------------------------------------

# More subsetting lists

# Extracting multiple elements of a list.

x <- list(foo = 1:4, bar = 0.6, baz = "hello")
x
#$foo
#[1] 1 2 3 4

#$bar
#[1] 0.6

#$baz
#[1] "hello"

# Now select out element 1 and 3
x[c(1, 3)]    # c(1,3) is a vector of element numbers
#$foo
#[1] 1 2 3 4
#$baz
#[1] "hello"


# ---------------------------------------------------------------

# Even more subsetting lists 

# The [[ operator can be used with computed indices; $ can only be used with literal names.

x <- list(foo = 1:4, bar = 0.6, baz = "hello")

name <- "foo"   # Save the name of the list element

x[[name]]       ## computed index for `foo'
#[1] 1 2 3 4

x$name          ## element `name' doesn't exist!
#NULL

x$foo
#[1] 1 2 3 4    ## element `foo' does exist


# ---------------------------------------------------------------

# Subsetting nested elements of a list

# The [[ can take an integer sequence.

x <- list(a = list(10, 12, 14), b = c(3.14, 2.81))
x
#$a
#$a[[1]]
#[1] 10
#
#$a[[2]]
#[1] 12
#
#$a[[3]]
#[1] 14
#
#
#$b
#[1] 3.14 2.81

class(x$a)     # First element is a list
#[1] "list"

class(x$b)     # Second element is a numeric vector
#[1] "numeric"


x[[c(1, 3)]]     # Element 3 of the list
#[1] 14

x[[1]][[3]]      # Another way of doing it
#[1] 14

x[[c(2, 1)]]     # First element of the vector
#[1] 3.14


# ---------------------------------------------------------------

# Partial matching on names

# Partial matching of names is allowed with [[ and $.

x <- list(aardvark = 1:5)

x$a               # "a" for aardvark
#[1] 1 2 3 4 5

x[["a"]]
#NULL

x[["a", exact = FALSE]]
#[1] 1 2 3 4 5

# ---------------------------------------------------------------
# subset() function
# ---------------------------------------------------------------

# subset() function's handling of NAs
x <- c(6, 1:3, NA, 12)    # Vector with NA
x
#[1]  6  1  2  3 NA 12

# Ordinary filtering ignores NAs, and leaves them in result
x[x > 5]
#[1]  6 NA 12   

# Use subset() to exclude NAs in result ONLY WITH VECTORS!
subset(x, x>5)  
#[1]  6 12

# ---------------------------------------------------------------
# subset() complex expressions

# First time we'll use a data set (from BaseR)
data(airquality)
head(airquality)

# Notice Ozone and Solar.R variables have NAs
summary(airquality)    

# Simple logical expression
# NAs not removed in results when using data frame
# NOTE: result is a data frame
subset(airquality, Temp > 80, select = c(Ozone, Temp))

# Complex logical expression
subset(airquality, Temp > 80 & Ozone < 50, select = c(Ozone, Temp))

# All variables EXCEPT Temp
subset(airquality, Day == 1, select = -Temp)

# Select a "sequence" of variables
subset(airquality, select = Ozone:Wind)

# Qualified naming not required, but still works
subset(airquality, airquality$Temp > 80)

# Create a temporary data frame consisting of only Temp values
filtered_temp <- subset(airquality,airquality[,5] == 6, select=Temp)
# Calculate the mean for the filtered Temp variable
mean(filtered_temp$Temp)
#[1] 79.1

# This works too
filtered_temp <- subset(airquality,airquality[,5] == 6, select=Temp)
bad <- is.na(filtered_temp)  # Useful IF there had been NAs
mean(filtered_temp[!bad])
#[1] 79.1

# This works too
mean(subset(airquality$Temp,airquality$Month == 6))
#[1] 79.1

# Extract all values of Solar.R in airquality where Month==5. 
# Note some NAs
airquality$Solar.R[airquality$Month==5]
#[1] 190 118 149 313  NA  NA 299  99  19 194  NA 256 290 274  65 334 307  78 322  44
#[21]   8 320  25  92  66 266  NA  13 252 223 279

# Since Solar.R has missing values (NA), this mean() won't work
mean(subset(airquality$Solar.R,airquality$Month == 5))  
#[1] NA

# This one uses a technique to get rid of NAs found in the R help
mean(subset(airquality$Solar.R,
            airquality$Month == 5 & !is.na(airquality$Solar.R)))
#[1] 181.2963

# Or we can use mean() to get rid of NAs
mean(subset(airquality$Solar.R,airquality$Month == 5),na.rm=TRUE)
#[1] 181.2963

# For ordinary vectors, the result is simply 
# x[subset & !is.na(subset)].
# This behavior of subset() is ONLY true for vectors
v <- c(1, 2, NA, 4)
vna <- subset(v, v<4)
#[1] 1 2


# ---------------------------------------------------------------

# Exclude more than one variable from a subset

# Exclude 4th variable, Temp
aq_subset <- airquality[,-4]   

# Exclude 2nd, 4th variable: Solar.R, Temp
aq_subset <- airquality[,c(-2, -4)]  


# ---------------------------------------------------------------

# Removing NA values 

x <- c(1, 2, NA, 4, NA, 5)

bad <- is.na(x)
bad
#[1] FALSE FALSE  TRUE FALSE  TRUE FALSE

x[!bad]        # Introducing the bang "!" operator NOT
#[1] 1 2 4 5


# ---------------------------------------------------------------

# More removing NA values

x <- c(  1,   2, NA,   4, NA,  5)
y <- c("a", "b", NA, "d", NA, "f")
good <- complete.cases(x, y)   # Find where both are non-missing
good
#[1] TRUE TRUE FALSE TRUE FALSE TRUE

x[good]      # Eliminate NAs
#[1] 1 2 4 5

y[good]      # Eliminate NAs
#[1] "a" "b" "d" "f"


# ---------------------------------------------------------------

# Even more removing NA values

# airquality data frame found in Base R: 153x6
# rows 5, 6 are have NAs
data(airquality)
airquality[1:6, ]     # Extract first 6 rows, all columns

# Create a logical index of complete rows
good <- complete.cases(airquality)

# Show first 6 complete rows. NOTE: new syntax!
airquality[good, ][1:6, ]


# ---------------------------------------------------------------
# NA vs. NULL vs. NaN vs. empty string ""
# NOTE: we won't go over all examples, but please do so yourself
# ---------------------------------------------------------------

# R has two closely related null-like values: NA and NULL. 
# Both are used to represent missing or undefined values. 

# NA is a logical constant of length 1 which contains the 
# missing value indicator. 

# NULL represents the null object in R. It is often returned by 
# expressions and functions whose values are undefined. 

NA
#[1] NA

class(NA)
#[1] "logical"

# NA is a logical values that when evaluated in an expression 
# yields NA. This is expected behavior of a value that handles 
# logical indeterminancy.
NA > 1
#[1] NA

# Now let's try NULL
# NULL is its own thing and does not yield any response when 
# evaluated in an expression (which is NOT how we'd want/expect 
# NA to work)
NULL

class(NULL)
#[1] "NULL"

NULL > 1
#logical(0)

# Subtle differences in the treatment of NA and NULL

# NOTE: for any vector, matrix, array, NA represents a missing 
# value, NULL does not!

# NULL not allowed in a vector
v <- c(1, NA, NULL)    # Define a vector where NULL disappears!
v
#[1]  1 NA

v[1] <- NULL     # Not allowed
#Error in v[1] <- NULL : replacement has length zero


# Define a list where NULL does not disappear!
li <- list(1, NA, NULL)  
li
#[[1]]
#[1] 1

#[[2]]
#[1] NA

#[[3]]
#NULL


# Oddly, assigning NULL to list elements removes them!
li <- list(1,2,3)
li
#[[1]]
#[1] 1

#[[2]]
#[1] 2

#[[3]]
#[1] 3

# Unlike vectors, you can remove a list element by setting it 
# to NULL
li[[1]] <- NULL
li
#[[1]]
#[1] 2

#[[2]]
#[1] 3

# Trying to access a list element by a non-existant name 
# yields NULL
li$aa
NULL

li[['aa']]
NULL

# Moral of the story: NA wrt the basic vector behaves like NULL 
# in other languages. NULL is almost never what you want to use. 

x <- NULL
x > 5
logical(0)

y <- NA
y > 5
#[1] NA

z <- NaN
z > 5
#[1] NA

is.null(x)
#[1] TRUE

is.na(y)
#[1] TRUE

is.nan(z)
#[1] TRUE

# y has NA, and NA is not the same as NULL
is.null(y)    
#[1] FALSE

# # Can't use is.na() on a NULL value, since no value to check
is.na(x)      
#Warning message:
#  In is.na(x) : is.na() applied to non-(list or vector) of type 'NULL'


# ---------------------------------------------------------------
# How about NA and NULL in statistical functions? 
# ---------------------------------------------------------------

vy <- c(1, 2, 3, NA, 5)
mean(vy)    # Mean is meaningless (excuse pun) with any NAs
#[1] NA

mean(vy, na.rm=TRUE)   # na.rm=TRUE argument removes all NAs
#[1] 2.75

vz <- c(1, 2, 3, NaN, 5)
vz
#[1]   1   2   3 NaN   5

sum(vz)      # Can't sum a vector with NaN values
#[1] NaN

sum(vz, na.rm=TRUE)  # na.rm=TRUE works on NaN values too
#[1] 11

vx <- c(1, 2, 3, NULL, 5)
vx                 # NULL value disappears
#[1] 1 2 3 5

sum(vx)            # So no problem summing
#[1] 11

# Removing missing values from a vector
vy
#[1]  1  2  3 NA  5

vy <- vy[!is.na(vy)]   # Remove all NAs
#[1] 1 2 3 5

vz
#[1]   1   2   3 NaN   5

vz <- vz[!is.nan(vz)]   # Remove all NaNs
#[1] 1 2 3 5


# ---------------------------------------------------------------
# Emptry string in R 

c1 <- character(5)  # Define character vector length 5
c1
#[1] "" "" "" "" ""

empty_str <- ""
empty_str
#[1] ""

class(empty_str)
#[1] "character"

# Length of the vector with 1 element - emptry string
length(empty_str)   
#[1] 1

chr_vector <- character(2)
chr_vector
#[1] "" ""

chr_vector[3] <- "three"    # Add a new element
chr_vector
#[1] ""      ""      "three"

chr_vector[5] <- "five"     # Add 5th element, no 4th though!
chr_vector
#[1] ""      ""      "three" NA      "five"







