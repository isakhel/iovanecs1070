# CSC1 1300 
# Machine Problem 6 - Iovane Sakhelashvili
#
#
# This program takes in a text file containing information about students containing their 
# 5 digit ID, Name, and a variable number of test scores (0-3)
# I create a Student class with the following instance variables and methods:
# 
# 
# 4 Instance Variables:
#   _stuID str - 5 characters, 2 alpha (initials), 3 numeric (random)
#   _name list - 2 str elements, first name, last name
#   _testScores list - int values (could be empty, no tests taken)
#   _avg float - the average of _testScores (0.0 if no tests taken)
# 
# 6 Public Instance Methods:
#   getID(self) return _stuID
#   getName(self) return _name
#   getTestScores(self) return _testScores
#   getAvg(self) return _avg
#   setName(self, firstName, lastName) Change the 2 elements in _name to
#   firstName and lastName.
#   addTest(self, testScore) Append 1 testScore onto _testScores,
#   then call _calcAvg() to set _avg to
#   the updated value.
#
# 1 Private Instance Method:
#   _calcAvg(self) called by addTest() to keep _avg accurate every time
#   a new test score is added, returns a float value that
#   is the average of the test scores, 0.0 if no test scores



class Student:
    
    def __init__(self, stuID):
        self._ID = stuID
        self._name = ["",""]
        self._testScores = []
        self._average = 0.0
    
    def getID(self):
        return self._ID

    def getName(self):
        return self._name

    def getTestScores(self):
        return self._testScores

    def getaverage(self):
        return self._average    
    
    def setName(self, fName, lName):
        self._name = [fName, lName]

    def _calcAverage(self):
        return sum(self._testScores)/len(self._testScores)


    def addTest(self, input):
        self._testScores.append(int(input))
        self._average = self._calcAverage()
    

    # For debugging purposes
    def __str__(self):
        return f"""Student: {self._ID} {self._name[0]} {self._name[1]}
Test Scores: {' '.join(str(score) for score in self._testScores)}
Test Average: {self._average:.2f}"""
    def __repr__(self):
        return f"{self._ID} {self._name[0]} {self._name[1]} {' '.join(str(score) for score in self._testScores)}"


def getScores():
    studentList = []
    with open("mp6data.txt", 'r') as file:
        lines = file.readlines()
        for line in lines:
            myline = line.strip()
            sections = myline.split()
            sectionlen = len(sections)
            student = Student(sections.pop(0))
            student.setName(sections.pop(0),sections.pop(0))
            
            i = 3

            while i < sectionlen:
                student.addTest(sections.pop(0))
                i +=1
            studentList.append(student)
    return studentList


def printroster(roster):
    print("Student in Roster: \n")
    for person in roster:
        print(person)
        print()
        

myroster = getScores()

printroster(myroster)



    



        


