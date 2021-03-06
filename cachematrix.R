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

