# Test Code for cachematrix.R
Monday, August 11, 2014  

part 1

##  Two required functions for the project:



```r
## the makeCacheMatrx function has an internal field called inverse,
## it is used to cache the result of computation of the inverse of an matrix.
## it does not compute the inverse itself, rather it let the caller sets it when 
## cacheSolve function is called repeatedly. the first time it is called, the inverse is null,
## and the inverse is computed and stored. the next time it is called, since it is already stored,
## it is retrieved directly without the recomputation.



makeCacheMatrix <- function(x = matrix()) {
  inverse <- NULL
  
  get <- function () return (x)
  
  set <- function (y) {
    x <<- y
    inverse <<- NULL
  }
  
  getinverse <- function () return (inverse)
  setinverse <- function (inv) {inverse <<- inv}
  
  ## return the following 4 internal functions as the result of calling this function
  list (
    get = get, 
    set = set, 
    getinverse = getinverse, 
    setinverse = setinverse 
  )
}

## this function first check if 
## the inverse is already stored, if so, return it, else it computes the 
## the inverse, store it inside the makeCacheMatrix function (using the setinverse call),
## then returns the inverse to the caller

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  iv <- x$getinverse()
  if(!is.null(iv)) {
    message("getting cached data")
    return(iv)
  }
  data <- x$get()
  iv <- solve(data, ...)
  x$setinverse(iv)
  iv  
}
```
part 2

## Test code and results of testing the above two functions


```r
a = makeCacheMatrix( x = matrix (c(2, 4, 3, 1, 5, 7, 7, 4, 2), ncol = 3))

a$get()
```

```
##      [,1] [,2] [,3]
## [1,]    2    1    7
## [2,]    4    5    4
## [3,]    3    7    2
```

```r
a$getinverse()
```

```
## NULL
```

```r
cacheSolve(a)
```

```
##         [,1]    [,2]    [,3]
## [1,] -0.3051  0.7966 -0.5254
## [2,]  0.0678 -0.2881  0.3390
## [3,]  0.2203 -0.1864  0.1017
```

```r
a$getinverse()
```

```
##         [,1]    [,2]    [,3]
## [1,] -0.3051  0.7966 -0.5254
## [2,]  0.0678 -0.2881  0.3390
## [3,]  0.2203 -0.1864  0.1017
```

```r
cacheSolve(a)
```

```
## getting cached data
```

```
##         [,1]    [,2]    [,3]
## [1,] -0.3051  0.7966 -0.5254
## [2,]  0.0678 -0.2881  0.3390
## [3,]  0.2203 -0.1864  0.1017
```

```r
a$set( matrix(c(2, 4, 5, 1, 5, 7, 7, 4, 2), ncol = 3))

a$getinverse()
```

```
## NULL
```

```r
cacheSolve(a)
```

```
##      [,1]   [,2]   [,3]
## [1,]    6 -15.67 10.333
## [2,]   -4  10.33 -6.667
## [3,]   -1   3.00 -2.000
```

```r
a$getinverse()
```

```
##      [,1]   [,2]   [,3]
## [1,]    6 -15.67 10.333
## [2,]   -4  10.33 -6.667
## [3,]   -1   3.00 -2.000
```

```r
cacheSolve(a)
```

```
## getting cached data
```

```
##      [,1]   [,2]   [,3]
## [1,]    6 -15.67 10.333
## [2,]   -4  10.33 -6.667
## [3,]   -1   3.00 -2.000
```

