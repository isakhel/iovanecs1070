#!/usr./bin/env python
import sys

def reduced_mapped():
    """
    reduces mapped values
    add ones for same words
    """
    current_word = None
    current_count = 0

    #loop through output
    #from mapper.py

    for line in sys.stdin:
        line = line.strip()
        word, count = line.split("\t",1)
        
        count = int(count)
        if current_word == word:
            current_count += count
        else:
            #if there is a current word that is not none
            #and its not the same as the word 
            # we are currently on in our iterations
            if current_word:
                print(current_word + "\t" +str(current_count))
                current_count = count
                current_word = word
        if current_word ==word:
            print(current_word +"\t" +str(current_count))
    if __name__ =="__main__":
        reduced_mapped()

