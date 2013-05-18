import sys
name = "_" + sys.argv[1] + "_" + sys.argv[2]
w0 = int(sys.argv[1])
w1 = int(sys.argv[2])
if sys.argv[5] == '1':
    w0 = 1
    w1 = 1

print name
print "Testing on " + "test" + name + ".dat"
testSet = open(sys.argv[4],'r')
predictSet = open(sys.argv[3],'r')
p = predictSet.readline()
t = testSet.readline()

T1 = 0.0
P1 = 0.0
Rel = 0.0
Error = 0.0
Total = 0.0

while t != '' and p != '':
    if t[0] == '1' :
        T1 = T1 + w1
        Total = Total + w1
    else :
        Total = Total + w0
    if p[0] != '-' and int(p[0]) > 0:
        p = '1'
    if p[0] == '1' and t[0] != '1':
        P1 = P1 + w0
    if t[0] == '1' and p[0] == '1':
        Rel = Rel + w1
        P1 = P1 + w1
    if t[0] != p[0]:
        Error = Error + 1
    p = predictSet.readline()
    t = testSet.readline()

print T1,P1,Rel,Error
print "Error rate:", Error / Total
print "Recall:", Rel / T1
print "Precision:", Rel / P1
print Error / Total, '\t', Rel / T1, '\t', Rel / P1

