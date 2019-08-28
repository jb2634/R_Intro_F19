# Introduction to plotting in R

# Don't forget to try the vignettes at the bottom of each help page!

# Setup ----------------------------------------------------------------------------------------------------------------------------------

if(!require(ggplot2)){install.packages("ggplot2")} # Load the library for ggplot2 as we will use it late.r

# Save data from internal `datasets` package as a new object.
# This dataset is observations of CO2 uptake by plants originating from
# different locations, and with different temperature treatments performed.
CO2 = datasets::CO2
?CO2
# Remind us what it looks like - three columns of character vectors represented as 'factors', and two numeric columns
head(CO2)

# More specific information about the structure (str) of the data
str(CO2)

# Visualization types --------------------------------------------------------------------------------------------------------------------------------------------

## Plots of data distribution in one dimension ######################

### Histogram - group the data into bins (default or custom defined) spanning the range of the data and display frequency of each bin.
?hist

### Density - Smooth out the data and display density (analogous to continuous frequency) of data along the range of the data.
?density # Combine with plot() to vizualize; i.e. plot(density(x))

### Dotchart - Display all point values along one dimension.
?dotchart


## Plots in two-dimension ###########################

### Ordinary point plotting
?plot # Plot points along x and y axes. Follow with points() for additional points from related data, or lines(); examples below.

### Grid plotting with grid cell values
?image # Plot a raster 'image', which is a set of coordinates x & y, and cell values z. 

### Box plot - Group the data along discrete factors, and display median, interquartile range (whiskers), and outliers
?boxplot



# What makes a good visualization? 
# * Plots should have a **purpose**, a clearly defined set of variables and a message being conveyed. 
# * Plots should be succinct and uncluttered so as to allow easy interpretation of the purpose. 
# * Plots should be comprehensive, representing the data accurately and fairly.

# Explore the data with simpler plots, then make them pretty!


# Visualization 1 ------------------------------------------------------------------------------------------------

# Changing ambient CO2 should affect CO2 uptake - less CO2 available might imply a slower uptake rate. Can we visualize this?

# We have two numeric vectors within the dataframe ; this is a good candidate for a simple point plot
class(CO2$conc)
class(CO2$uptake)


# Plot opens up the plotting window defaulting to the ranges of the data initially passed to plot()

plot(x = CO2$conc, y = CO2$uptake) # Commentary:
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# There's some increase in uptake at the lower end of the concentration
# gradient, but it doesn't really increase much after ~250 mL/L

# It may imply that CO2 concentration is only a limiting factor at very low
# levels and does not drive uptake at higher concentrations
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# Format the plot a little better. If the line gets too long, you can add breaks AFTER commas.

plot(x = CO2$conc, y = CO2$uptake, 
     xlab = 'CO2 Concentration mL/L', 
     ylab = 'Plant CO2 Uptake umol/m^2 sec', 
     main = 'Plant CO2 Uptake Under Ambient CO2 Concentration Gradient')

# Do the same in ggplot2

# In ggplot we have geoms that handle different types of plots, and we typically want to use data frames. 
# Variables are passed into a function `aes()`; these are things related to the data values themselves.

# ggplot2 skeleton is as follows

# Example:

# p = ggplot() +                                                  ### The function to get the plot started ggplot(). Add plot types, or 'geoms' after using the plus (+). 
                                                                  ### Optionally pass data inside parentheses. Can save to object (as shown), or plot directly without saving (no asssignment).

#   geom_point(data = data, aes(x = x_column_name,                ### Add a layer. Specify the data frame to be used in `data`. Specify VARIABLES within aes(). Specify FIXED characters outside.
#                               y = y_column_name), color = 'blue') +

#   geom_point(data = other_data, aes(x = x_column_name,          ### Add another layer from different data. NOTICE here that the color is now set to be dependent upon the `z` column in `other_data`.
#                                     y = y_column_name, 
#                                     color = z_column_name)) +  

#   geom_text(aes(x = 0, y = 0, label = 'label text'))            ### Add another layer. NOTICE that x and y are technically 'fixed' in this example, but position information almost always goes into aes().

#   ggtitle("Main title") + xlab("X label") + ylab("Y label")     ### Add labels and such; note this doesn't have to come last.

# Don't try to memorize all of the geom's; you'll become familiar with them through experience.

# Make the above plot:

ggplot() + 
  geom_point(data = CO2, aes(x = conc, y = uptake), color = 'violet') + 
  ggtitle("Plant CO2 Uptake Under Ambient CO2 Concentration Gradient") + 
  xlab("CO2 Concentration mL/L") + ylab("Plant CO2 Uptake umol/m^2 sec")

# What if we want color to depend on something, say where the plant came from?
# We can specify color to depend upon a column in the data frame, but we move
# the color argument INSIDE aes() now. ggplot automatically adds a legend:

ggplot() + 
  geom_point(data = CO2, aes(x = conc, y = uptake, color = Type)) + 
  ggtitle("Plant CO2 Uptake Under Ambient CO2 Concentration Gradient") + 
  xlab("CO2 Concentration mL/L") + ylab("Plant CO2 Uptake umol/m^2 sec")

# Adds a little more insight - Quebec plants almost always take up more CO2 than MS plants at the same ambient concentration!



# Visualization 2 ------------------------------------------------------------------------------------------------

# Biological processes are usually temperature mediated. We should expect higher
# respiration (CO2 uptake) with higher temperatures. What are the temp
# treatments? 'levels' extracts the unique factors from a 'factor' vector. In
# this case, 'chilled' and 'nonchilled' represented as 1's and 2's

levels(CO2$Treatment)

# We're interested in the distribution of uptake as it relates to treatment. How can we visualize this?
# * Box plot - grouping along a discrete variable (treatment) and display distribution of data
# * Density plot with line type determined by factor
# * Points colored by factor

# Split data frame by treatment. Makes two lists of CO2$uptake separated by treatment. 
# Note : if you wrap any assignment with parentheses like below, it will automatically print the object you just assigned.
(CO2_split = split(CO2$uptake, CO2$Treatment))

# Box plot - 'split' first by treatment and plot
boxplot(CO2_split)

# Do the same in ggplot: notice how much simpler it is to separate factors...
ggplot() + 
  geom_boxplot(data = CO2, aes(x = Treatment, y = uptake))

# Sometimes good to add the data on as well, for visualization. 
# Use alpha (transparency) to make it less intrusive and visualize density of data
ggplot() + 
  geom_boxplot(data = CO2, aes(x = Treatment, y = uptake)) + 
  geom_point(data = CO2, aes(x = Treatment, y = uptake), alpha = 0.1)



# Commentary:
# Chilled plants seem to take up slightly less CO2 (though we haven't tested for significance!)

# Plot density - notice that the window of the first plot cuts off the second! 
plot( density (CO2_split$chilled) )
lines( density( CO2_split$nonchilled ) , lty=3)

# Need to set window to all the data first

plot(x = c(-1,60), y = c(0,0.043), type = 'n')
lines( density( CO2_split$chilled) )
lines( density( CO2_split$nonchilled ) , lty=3)

# Nice, but it would take a lot less work if it were automatic. Do this in ggplot

ggplot(data = CO2) + 
  geom_density(aes(x = uptake, linetype = Treatment)) # So much simpler - one command! No splitting, no fiddling with windows.

# Exercises -----------------------------------------------------------------------------

# Use the trees dataset. Observe the structure (str) of the dataset and plot all three variables on one chart.

# Variables are girth, height, and volume; volume is dependent upon girth and height.
# Use ggplot, and geom_point, or find another way to represent these data if you want.

ggplot(data = trees) + 
  geom_point(aes(x = Girth, y = Height, color = Volume)) + 
  theme(axis.title.x = element_text(angle = 45), 
        axis.text.x = element_text(angle = 45) ,
        legend.background = element_rect(fill = 'gray50'))



library(plotly)

plot_ly(data = trees) %>% 
  add_markers(x = ~Girth, y = ~Height, z = ~Volume)

# Make your plot pretty! Using the `theme()` layer, change the background colors, and at least one other feature, to something that appeals you.

# using the adk_elevation dataset, plot the population distribution of Adirondacks elevation, and the sample distribution, in one graph.
# Modify the alpha (transparency) levels appropriately (if applicable)

ggplot() + 
  geom_density(data = adk_elevation, aes(x = Elevation, color = Type), alpha = 0.2) + 
  scale_color_manual(values = c('red', 'blue'))

ggplot() + 
  geom_boxplot(data = adk_elevation, aes(x = Type, y = Elevation, fill = Type)) + 
  coord_flip()

ggplot() + 
  geom_violin(data = adk_elevation, aes(x = Type, y = Elevation))

ggplot() + 
  geom_point(data = adk_elevation, aes(x = Type, y = Elevation), position = position_jitter(width = 0.2), alpha = 0.1)
             