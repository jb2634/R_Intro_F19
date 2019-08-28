summarizePois = function(mean, n_numbers, n_replicates, debug = F) { 
  
  # Summarize n_samples random poisson distributions
  
  # Mean is the mean of the simulation
  # n_numbers is how many numbers to simulate
  # n_replicates is how many replicates of this simulation to perform.
  
  # Use `debug = T` to enable the debugger
  # Use the `next` controls above the console to step through the function.
  # Observe the environment, what is in it, and how it changes as you step through the function.
  
  if(debug){browser()}
  
  # Create a list to carry all of the summaries
  outList = list()
  
  for(n in 1:n_replicates){
    
    # Simulate Poisson random variables with mean `mean` and length `length_out`
    out = rpois(n = n_numbers, lambda = mean)
    
    # Summarize this simulation
    outSummary = summary(out)
    
    # Save this summary into the list
    outList[[n]] = outSummary
    
  }
  
  # Return what we want.
  return(outList)
  
}