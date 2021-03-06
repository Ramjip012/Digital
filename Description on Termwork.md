# Digital

I have done Term work on DIgital filter Implementation using verilog.

Signal separation is needed when a signal has been contaminated with interference, noise, or other signals.Noises added to the sine wave using Random Function.Since the outputs are in real values, it is converted to Integers and scaling is done to avoid decimal points.
Scaled integer values are converted into Binary and exported as a Data File.
Exported data file consists of 16-bit values of generated sine wave , that value is given as an input to the filter design.
signals are usually created by sampling at regular intervals of time.
common way of sampling is at equal intervals in space.
When you see the term time domain in DSP, remember that it may actually refer to samples taken over time, or it may be a general reference to any domain that the samples are taken 
There are two ways for making an Digital filter.
The most straightforward way to implement a digital filter is by convolving the input signal with the digital filter's impulse response.There is also another way to make digital filters, called recursion. When a filter is implemented by convolution, each sample in the output is calculated by weighting the samples in the input, and adding them together. Recursive filters are an extension of this, using previously calculated values from the output, besides points from the input. Instead of using a filter kernel, recursive filters are defined by a set of recursion coefficient
recursive filters are also called Infinite Impulse Response or IIR filters. In comparison, filters carried out by convolution are called Finite Impulse Response or FIR filters.

**Algorithm**

Generated a sine wave using sinusoidal function in MATLAB with 1 voltage amplitude and 5 Hz frequency
Noises added to the sine wave using Random Function
Since the outputs are in real values, it is converted to Integers and scaling is done to avoid decimal points
Scaled integer values are converted into Binary and exported as a Data File
Exported data file consists of 16-bit values of generated sine wave , that value is given as an input to the filter design.

**Input Wave:**

Waves Generated from MATLAB
![image](https://user-images.githubusercontent.com/100188885/155134931-2aedec28-4d2d-4066-9200-d73306bd6aa2.png)

![image](https://user-images.githubusercontent.com/100188885/155135022-2c11cfa1-c8d0-4740-9959-f1752862171a.png)

![image](https://user-images.githubusercontent.com/100188885/155135069-8991610b-a250-4fa6-999e-0a8bdf53e77a.png)

 
 **Designing Co-Efficient of a Low pass Butterworth filter**
 
 Desired Output:
Passband Ripple (??p) - 25db
Stopband Attenuation (??s) - 70db
Passband cut-off frequency (??p) - 150 rad/sec
Stopband cut-ff frequency (??p) - 1000 rad/sec

**Calculating order and Cut-off frequency**

![image](https://user-images.githubusercontent.com/100188885/155135394-40a90ca5-2a62-4c15-9d84-1b19002271be.png)
N = 2.573
So, N = 3

**Cut-off frequency and transfer function**

??c =????p/ (10^(0.1 * ??p) - 1)^ (1/2N)
??c??= 150/ (10^(0.1 * 25) - 1)^ (1/6)
??c = 57.498 rad/sec

H(s) = 1/ ((1+s)*(1+s+s^2))
H(s/??c) = 1/ (1 + 0.017s)(1 + 0.017s + 0.00028s^2)


**Calculating Coefficients**

B0 = 1.3
B1 = -0.00154
B2 = 0.0018
B3 = -0.0021

Scaling factor used is 2^10. After scaling,
B0 = (13)d = (01101)b
B1 = (16)d?? ??= (10000)b
B2 = (18)d?? ??= (10011)b
B3 = (21)d?? ?? ??= (10101)b

**Word Lengths**

Discrete representation: 0.0013 -1.57x(n) + 0.0018x(n-1) - 0.0021x(n-2)
Coefficients ??? 5 bits
Parameter ??? 16 bits
Data-in????? 16 bits
Data-out ??? 16 bits

**Matlab Frequency Response**

![image](https://user-images.githubusercontent.com/100188885/155136305-d2885f0b-4fb7-493e-a7ec-248944e28be2.png)

**RTL Diagram**

![image](https://user-images.githubusercontent.com/100188885/155136409-bea54b15-8a1a-40eb-ae06-83ee0df8b494.png)






