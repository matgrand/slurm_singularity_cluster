import os
import argparse

def find_file_with_largest_integer(directory):
    files = os.listdir(directory)
    largest_integer = float('-inf')
    largest_file = None

    for file in files:
        if os.path.isfile(os.path.join(directory, file)):
            try:
                integer = int(os.path.splitext(file)[0])
                if integer > largest_integer:
                    largest_integer = integer
                    largest_file = file
            except ValueError:
                pass

    return largest_file

def remove_files_except_largest(directory):
    largest_file = find_file_with_largest_integer(directory)

    if largest_file:
        for file in os.listdir(directory):
            if os.path.isfile(os.path.join(directory, file)) and file != largest_file:
                os.remove(os.path.join(directory, file))

    return largest_file

# Parse command line arguments
parser = argparse.ArgumentParser(description='Remove all files except the one with the largest integer in the filename.')
parser.add_argument('directory', type=str, help='The directory path')
args = parser.parse_args()

# Call the function to remove files
most_recent_file = remove_files_except_largest(args.directory)

previous_line = ''
while True:
    with open(os.path.join(args.directory, most_recent_file), 'r') as file:
        #get last line
        lines = file.readlines()
        last_line = lines[-1]
        if last_line != previous_line:
            print(last_line)
            previous_line = last_line
        else:
            pass