import torch

print(f'This is a test script for the DEI cluster')
print(f'PyTorch version: {torch.__version__}')
print(f'CUDA available: {torch.cuda.is_available()}')

#get the number of cores and amount of memory
import os
print(f'Number of cores: {os.cpu_count()}')
print(f'Memory: {os.sysconf("SC_PAGE_SIZE") * os.sysconf("SC_PHYS_PAGES") / (1024.**3)} GB')

print("Let's fucking go!!!")

from time import time

# do some computation
start_time = time()
sum = 0
for i in range(200_000_000):
    result = i * i * (i - 1)
    if sum > 300_000_000: sum -= result
    else: sum += result
    # do something with the result
print(f'computation time: {(time() - start_time):.2f} s, sum = {sum}')

print("LET'S FUCKING GOOOOOOO!!!!!!!!!!!!!!")