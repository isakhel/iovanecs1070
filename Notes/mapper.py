#! usr/bin/env python
#Docker and linting lookup
import sys


def mapper():
    """
    Read in sentence and maps the values
    Mapping values means it will give a count of 1 to every word in a sentence

    Words are defined if there is a space between them
    """

    #stdin  = standard inout
    for line in sys.stdin:
        #strip whitespace at beginning and end of line
        line = line.strip()

        #split line into words
        words = line.split()
        return words


        #process word and assign value
        for word in words:
            print(word +"\t1")
            sys.stdout.flush()


if __name__ == "__main__":
    mapper()