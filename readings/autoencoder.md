# Autoencoder

Autoencoder is a **unsupervised** artificial neural network, that learns how to reduce the dimensions, and the noise in data.

**It learns how to:**
1. efficiently compress and encode data
2. reconstruct the reduced encoded data back to a representation that is as close to the original data as possible

**Autoencoder Components:**
1. Encoder: it compresses the data into an encoded representation and reduces the dimensions
2. Bottleneck: a layer that contains the data that is compressed to the lowest dimension
3. Decoder: reconstruct the data from the encoded representation to a representation that is as close to its original data as possible
4. Reconstruction Loss: measures how the decoder performs, that is how close is the output to the original data.

![](images/autoEncoder.png)

**Uses:**
- Dimension reduction(nonlinear, Principle Component Analysis reduces dimension with a linear approach)
- Reduce noise in data
- Generative modeling
- Efficient coding
- Superior in learning underlying features in many domains, including computer vision, speech recognition, and language modeling 

**Basic Model**

***The Encoder***
The encoder will transform the high dimensional input data X, into a low dimensional hidden representation h:
$$
h = f(X) = s_f(W* X + b)
$$
- $s_f$ is activation function, e.g. Sigmoid, TanH, or ReLU
- W is weight matrix
- b is bias

***The Decoder***
The decoder will transform the low dimensional h back to the original high dimension representation $x'$
$$
x' = g(h) = s_g(W'*h + b')
$$
- $s_g$ is activation function, e.g. Sigmoid, TanH, or ReLU
- W' is weight matrix
- b' is bias

***The Cost Function***
1. Regression task, use Squared Error: $SE(x, x') = \sum(x-x')^2$
2. Classification task, use Cross Entropy: $ CE(x, x') = -\sum_{i=1}^{n} (x_i*log(x'_i) + (1-x_i)*log(1-x'_i)) $
3. Add regularization term (l2-norm) to the parameters 


**Articles**
[Auto encoder, what is it and what is it userd for part1](https://towardsdatascience.com/auto-encoder-what-is-it-and-what-is-it-used-for-part-1-3e5c6f017726)