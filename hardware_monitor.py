import psutil
import serial
from multiprocessing import Process
from time import sleep

def main():
    while True:
        cargaCpu = psutil.cpu_percent(interval=1)
        usoMemoria = psutil.virtual_memory()
        info_title("Uso de CPU: " + str(cargaCpu))
        info_title("Memoria usada %: " + str(usoMemoria.percent))
        info_title("Memoria usada cantidad: " + str((usoMemoria.used / 1000000000)) + 
                   "de: " + str((usoMemoria.total / 1000000000)))
        

def info_title(title):
    print(title)

if __name__ == "__main__":
    p = Process(target=main)
    p.start()
    p.join()