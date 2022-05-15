import matplotlib.pyplot as plt
import matplotlib.image as mpimg

def showImage(path):
    img = mpimg.imread(path)
    imgplot = plt.imshow(img)
    plt.show()

def showImages(path_arr, ncol, nrow):
    for i, path in enumerate(path_arr):
        sp = plt.subplot(nrow, ncol, i + 1)
        sp.axis("Off")
        img = mpimg.imread(path)
        plt.imshow(img)
    plt.show()