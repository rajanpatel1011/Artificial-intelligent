acct = ['ACCT 840', 'ACCT 765', 'ACCT 715', 'ACCT 665'];
chem = ['CHEM 820', 'CHEM 785', 'CHEM 725', 'CHEM 625'];
engy = ['ENGY 805', 'ENGY 790', 'ENGY 720', 'ENGY 685'];
csci = ['CSCI 755', 'CSCI 640', 'CSCI 610', 'CSCI 710'];
eeng = ['EENG 740', 'EENG 635', 'EENG 825', 'EENG 720'];

all_courses = [acct, chem, engy, csci, eeng];

student1 = ['CSCI 640', 'CSCI 610', 'ENGY 685', 'EENG 635'];
student2 = ['ENGY 805', 'ENGY 720', 'CSCI 755', 'EENG 740'];
student3 = ['CHEM 820', 'CHEM 725', 'CSCI 710', 'EENG 635'];
student4 = ['ACCT 765', 'ACCT 665', 'CSCI 610', 'EENG 720'];

all_students = [student1, student2, student3, student4];

def getCourse(subject):
	for course in all_courses:
		if (subject in course):
			print subject, "exists in this course : ", course, "\n"

def printUpperCourses():
	print "Following are all upper level courses :\n"
	for course in all_courses:
		for subject in course:
			if(int(subject[-3:-2]) > 6):
				print subject,"\n"

def printCoursesCount():
	count = 0
	for course in all_courses:
		for subject in course:
			if(subject[:4] == 'CSCI' or subject[:4] == 'EENG'):
				count=count+1
	print "There are total ",count," CSCI AND EENG COURSES"

def findStudentScheduleLevel():
	for student in all_students:
		result = [];
		for course in student:
			if(course[:4] == 'CSCI' or course[:4] == 'EENG' or int(course[-3:-2]) > 6):
				result.append(1)
			elif(course[:4] != 'CSCI' and course[:4] != 'EENG' and int(course[-3:-2]) < 7):
				result.append(2)
			else:
				result.append(3)
		if(all(x == result[0] for x in result) and result[0] == 1):
			print student, "has taken hard course"
		elif(all(x == result[0] for x in result) and result[0] == 2):
			print student, "has taken easy course"
		else:
			print student, "has taken Medium Course"

getCourse('CSCI 610')
printUpperCourses()
printCoursesCount()
findStudentScheduleLevel()