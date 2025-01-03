# -*- coding: utf-8 -*-
"""
Created on Thu Jan  2 14:46:12 2025

@author: LIU_I_CHIA
"""
import re

def find_most_frequent_words(file_path):
    
    try:
        with open(file_path, 'r') as file:
            text = file.read()
        
        # use regular expressions to cut strings and convert them to lowercase
        word_list = re.split(r'[,\s!\n.]+', text)
        lower_word_list = [word.lower() for word in word_list if word]
        
        # count word frequency
        word_count = {}
        for word in lower_word_list:
            if word in word_count:
                word_count[word] += 1
            else:
                word_count[word] = 1
            
        # find max count and word
        max_count = max(word_count.values())
        max_words = [word for word, count in word_count.items() if count == max_count]
    
        return max_count, max_words
    
    except FileNotFoundError:
        print(f"File {file_path} does not exist, please confirm whether the path is correct.")
        return [], 0
    
    except Exception as e:
        print(f"An error occurred: {e}")
        return [], 0


file_path = './words.txt'
max_count, max_words = find_most_frequent_words(file_path)
for word in max_words:
    print(f"{max_count} {word}")