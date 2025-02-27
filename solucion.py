class Rectangulo:
    def __init__(self, base, altura):
        self.base = base
        self.altura = altura

    def calcular_area(self):
        return self.base * self.altura

    def calcular_perimetro(self):
        return 2 * (self.base + self.altura)

# Uso de la clase para evitar duplicación
rect1 = Rectangulo(5, 10)
rect2 = Rectangulo(7, 3)

print("Área 1:", rect1.calcular_area())
print("Perímetro 1:", rect1.calcular_perimetro())
print("Área 2:", rect2.calcular_area())
print("Perímetro 2:", rect2.calcular_perimetro())
