# perlin-flow-field
My personal implementation of a perlin flow field in Processing 3.

## How to use
The program can be used "manual mode" or "automatic mode" by changing the value of the _automate_ variable found in the _setup_ function.
It currently supports 3 different color themes, chosen at random:
1. White trails on black background
2. Black trails on white background
3. Colored trails on black background


### Manual mode
* The sketch will start drawing as soon as it is run
* Press space bar to save the current frame
* Click on the sketch to reset it

### Automatic mode
* The sketch will start drawing as soon as it is run
* Once the drawing hits a set number of generated frames, it automatically saves the current frame as image in the corresponding folder and starts drawing again


## Example Images
### White on black
![White on black](https://github.com/lorossi/perlin-flow-field/blob/master/examples/white_on_black.png?raw=true)
(my personal favourite)
### Black on white
![Black on white](https://github.com/lorossi/perlin-flow-field/blob/master/examples/black_on_white.png?raw=true)
### Colored
![Black on white](https://github.com/lorossi/perlin-flow-field/blob/master/examples/colored.png?raw=true)
