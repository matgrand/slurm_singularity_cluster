import torch

print(f'This is a test script for the DEI cluster')
print(f'PyTorch version: {torch.__version__}')
print(f'CUDA available: {torch.cuda.is_available()}')

#get the number of cores and amount of memory
import os
print(f'Number of cores: {os.cpu_count()}')
print(f'Memory: {os.sysconf("SC_PAGE_SIZE") * os.sysconf("SC_PHYS_PAGES") / (1024.**3)} GB')


print("Let's fucking go!!!")

from time import sleep
sleep(30) # sleep just to make the program last more

print("LET'S FUCKING GOOOOOOO!!!!!!!!!!!!!!")