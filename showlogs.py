import os
import argparse
from time import time, sleep

def find_file_with_largest_integer(directory):
    files = os.listdir(directory)
    # print(f'Files in {directory}: \n{files}')
    largest_integer = float('-inf')
    largest_file = None
    for file in files:
        if file.startswith('output.'):
            n = file.split('.')[1]
            try:
                n = int(n)
                if n > largest_integer:
                    largest_integer = n
                    largest_file = file
            except ValueError:
                pass
    return largest_file

# Parse command line arguments
parser = argparse.ArgumentParser(description='Remove all files except the one with the largest integer in the filename.')
parser.add_argument('directory', type=str, help='The directory path')
args = parser.parse_args()

#show example of how to use the script
print("Example: python showlogs.py /path/to/directory")
print(f'Watching logs in {args.directory}...')

# Call the function to remove files
most_recent_file = find_file_with_largest_integer(args.directory)
line_idx = 0
print(f'Most recent file: {most_recent_file}')

while True:
    new_most_recent_file = find_file_with_largest_integer(args.directory)
    if new_most_recent_file != most_recent_file:
        most_recent_file = new_most_recent_file
        line_idx = 0
        print(f'Most recent file: {most_recent_file}')
        sleep(0.1)
    try:
        with open(os.path.join(args.directory, most_recent_file), 'r') as file:
            lines = file.readlines()
            if len(lines) > line_idx:
                for line in lines[line_idx:]:
                    print(line, end='')
                line_idx = len(lines)
    except Exception as e:
        print(f'Error: {e}')
        continue
    sleep(2.4)