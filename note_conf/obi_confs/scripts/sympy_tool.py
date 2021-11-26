import sys
# sys.path.append("/usr/local/lib/python3.9/site-packages")
from sympy import *

SYMPY_AVAILABLE = True

def main():
    if not SYMPY_AVAILABLE:
        return
    # x, y, z, t = symbols('x y z t')
    a ,b ,c ,d ,e ,f ,g ,h ,i ,j ,k ,l ,m ,n ,o ,p ,q ,r ,s ,t ,u ,v ,w ,x ,y ,z = symbols('a b c d e f g h i j k l m n o p q r s t u v w x y z')

    print(latex(eval(input())), end="")

if __name__ == "__main__":
    main()
