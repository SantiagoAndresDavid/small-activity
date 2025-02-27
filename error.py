# Código duplicado para calcular el área y el perímetro de un rectángulo

def calcular_area1(base, altura):
    return base * altura

def calcular_perimetro1(base, altura):
    return 2 * (base + altura)

def calcular_area2(base, altura):
    return base * altura

def calcular_perimetro2(base, altura):
    return 2 * (base + altura)

# Llamadas a funciones duplicadas
print("Área 1:", calcular_area1(5, 10))
print("Perímetro 1:", calcular_perimetro1(5, 10))
print("Área 2:", calcular_area2(7, 3))
print("Perímetro 2:", calcular_perimetro2(7, 3))
