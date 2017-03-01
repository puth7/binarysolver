#import sage.logic.propcalc as propcalc

## new algorithm for 2nd constraint (recursive)

def dec2bin_recursive(a): #a is integer
    m = ceil(log(a+1,2))
    s = [] # s is the binary representation of a
    for k in xrange(m):
        s.append(ss(a,k+1))
    return(s)

def ss(i,k): #i integer, k index: 1,2,...
    m = ceil(log(i+1,2))
    if k > m:
        return( 'error. index exeed limit' )
    elif k == m:
        s = 1
    elif  k == 1:
        s = mod(ss(i-1,1)+1,2)
    else:
        s=mod(ss(i-1,k)+ss(i-1,k-1),2)
    return(s)

# print list(reversed(dec2bin_recursive(6)))
####
#recursive formula for balancedness (arithmatic)
def zz(x,i,k): #x vector, i index x,   k index z : 0,1,...
    m = ceil(log((i+1)+1,2))-1
    if k > m:
        z= 0
    if i == 0 and k == 0:
        z = x[0]
    elif k == 0:
        z = mod(zz(x,i-1,k) + x[i],2)
    elif k<m:
        mem = 1
        for l in xrange(k):
            mem = mem and zz(x,i-1,l)
        z = mod((mem and x[i]) + zz(x,i-1,k),2)
    elif k==m:
        mem = 1
        for l in xrange(k):
            mem = mem and zz(x,i-1,l)
        z = (mem and x[i]) or zz(x,i-1,k)
    #print z,'z|',k,'k|', i,'i|', m,'m|'
    return(z)

def binsum_recur(x):# x is a binary vector
    z = []
    n = len(x)-1
    m = ceil(log(n+2,2))
    for k in xrange(m):
        z.append(zz(x,n,k))
    return(z)
        
x=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
print len(x), 'len x: ', x
#print zz(x,3,3)

print sum(x), bin(sum(x))
print list(reversed(binsum_recur(x)))

### iterative algorithm for 2nd constraint (aritthmatic )
def binsum_iter(x):
    z={}
    n=len(x)
    for i in xrange(n):
        for k in xrange(n+1):
            z[i,k] = 0
    #print '\n'
    for i in xrange(n):
        m=ceil(log(i+1+1,2))
        #print i,m
        for k in xrange(m):
            #print i,k
            if i==0 and k==0:
                z[i,k] = x[0]
            elif k==0:
                z[i,k] = mod(z[i-1,k]+x[i],2)
            elif k<m-1:
                mem = 1
                for l in xrange(k):
                    mem = mem and z[i-1,l]
                z[i,k] = mod((mem and x[i]) + z[i-1,k],2)
            elif k==m-1:
                mem = 1
                for l in xrange(k):
                    mem = mem and z[i-1,l]
                z[i,k] = (mem and x[i]) or z[i-1,k]
            #print '|m',m,'|i',i,'|k',k,'|z',z[i,k]
    return z
 
z = binsum_iter(x)
#print x
print [z[len(x)-1,k] for k in xrange(ceil(log(len(x)+1,2)),-1,-1)]

#######
#recursive formula (logical formula)
def zz(x,i,k): #x vector, i index x,   k index z : 0,1,...
    m = ceil(log((i+1)+1,2))-1
    if k > m:
        z= 0
    if i == 0 and k == 0:
        z = x[0]
    elif k == 0:
        z = (zz(x,i-1,k) and (not x[i])) or ((not zz(x,i-1,k)) and x[i])  # mod(zz(x,i-1,k) + x[i],2)
    elif k<m:
        mem = 1
        for l in xrange(k):
            mem = mem and zz(x,i-1,l)
        z = ((mem and x[i]) and (not zz(x,i-1,k))) or ((not (mem and x[i])) and zz(x,i-1,k)) # mod((mem and x[i]) + zz(x,i-1,k),2)
    elif k==m:
        mem = 1
        for l in xrange(k):
            mem = mem and zz(x,i-1,l)
        z = (mem and x[i]) or zz(x,i-1,k)
    #print z,'z|',k,'k|', i,'i|', m,'m|'
    return(z)

def binsum_recur(x):# x is a binary vector
    z = []
    n = len(x)-1
    m = ceil(log(n+2,2))
    for k in xrange(m):
        z.append(zz(x,n,k))
    return(z)
        

print len(x), 'len x: ', x

print list(reversed(binsum_recur(x)))

### iterative algorithm for 2nd constraint (logical formula)
def binsum_iter(x):
    z={}
    n=len(x)
    for i in xrange(n):
        for k in xrange(n+1):
            z[i,k] = False
    #print '\n'
    for i in xrange(n):
        m=ceil(log(i+1+1,2))
        #print i,m
        for k in xrange(m):
            #print i,k
            if i==0 and k==0:
                z[i,k] = x[0]
            elif k==0:
                z[i,k] = (z[i-1,k]  and (not x[i]))  or ((not z[i-1,k])  and  x[i])  
            elif k<m-1:
                mem = True
                for l in xrange(k):
                    mem = mem and z[i-1,l]
                z[i,k] = ((mem and x[i]) and (not z[i-1,k])) or ((not (mem and x[i])) and z[i-1,k]) 
            elif k==m-1:
                mem = True
                for l in xrange(k):
                    mem = mem and z[i-1,l]
                z[i,k] = (mem and x[i]) or z[i-1,k]
            #print '|m',m,'|i',i,'|k',k,'|z',z[i,k]
    return z
 
z = binsum_iter(x)
#print x
print [z[len(x)-1,k] for k in xrange(ceil(log(len(x)+1,2)),-1,-1)]

#########



#recursive formula (logical formula, symbolic, x as variable)
def zz(x,i,k): #x vector, i index x,   k index z : 0,1,...
    m = ceil(log((i+1)+1,2))-1
    if k > m:
        z= 0
    if i == 0 and k == 0:
        z = x[0]
    elif k == 0:
        z = (zz(x,i-1,k) and (not x[i])) or ((not zz(x,i-1,k)) and x[i])  # mod(zz(x,i-1,k) + x[i],2)
    elif k<m:
        mem = 1
        for l in xrange(k):
            mem = mem and zz(x,i-1,l)
        z = ((mem and x[i]) and (not zz(x,i-1,k))) or ((not (mem and x[i])) and zz(x,i-1,k)) # mod((mem and x[i]) + zz(x,i-1,k),2)
    elif k==m:
        mem = 1
        for l in xrange(k):
            mem = mem and zz(x,i-1,l)
        z = (mem and x[i]) or zz(x,i-1,k)
    #print z,'z|',k,'k|', i,'i|', m,'m|'
    return(z)

def binsum_recur(x):# x is a binary vector
    z = []
    n = len(x)-1
    m = ceil(log(n+2,2))
    for k in xrange(m):
        z.append(zz(x,n,k))
    return(z)
        
x = seqvar('x',3)
print len(x), 'len x: ', x

print list(reversed(binsum_recur(x)))

### iterative algorithm for 2nd constraint (logical formula, symbolic, x as variable)
def binsum_iter(x):
    z={}
    n=len(x)
    for i in xrange(n):
        for k in xrange(n+1):
            z[i,k] = '0'
    #print '\n'
    for i in xrange(n):
        m=ceil(log(i+1+1,2))
        #print i,m
        for k in xrange(m):
            #print i,k
            if i==0 and k==0:
                z[i,k] = x[0]
            elif k==0:
                z[i,k] = '('+z[i-1,k] + ' & '+ '~' + x[i] + ')' + ' | ' + '('+'~' + z[i-1,k]  + ' & '+ x[i]+')'  
            elif k<m-1:
                mem = '1'
                for l in xrange(k):
                    mem = mem +' & '+ z[i-1,l]
                z[i,k] = '('+'('+mem +' & '+ x[i]+')' +' & '+ '~'+ z[i-1,k]+')' +' | '+  '('+'~'+'('+mem +' & '+x[i]+')'+' & '+z[i-1,k]+')' 
            elif k==m-1:
                mem = '1'
                for l in xrange(k):
                    mem = mem +' & '+z[i-1,l]
                z[i,k] = '('+mem +' & '+ x[i]+')' +' | '+ z[i-1,k]
            #print '|m',m,'|i',i,'|k',k,'|z',z[i,k]
    return z
 
z = binsum_iter(x)
#print x
print [z[len(x)-1,k] for k in xrange(ceil(log(len(x)+1,2)),-1,-1)]

#########

#recursive formula (logical formula, symbolic, x and z as variable)
def zz(x,i,k): #x vector, i index x,   k index z : 0,1,...
    m = ceil(log((i+1)+1,2))-1
    if k > m:
        z= 0
    if i == 0 and k == 0:
        z = x[0]
    elif k == 0:
        z = (zz(x,i-1,k) and (not x[i])) or ((not zz(x,i-1,k)) and x[i])  # mod(zz(x,i-1,k) + x[i],2)
    elif k<m:
        mem = 1
        for l in xrange(k):
            mem = mem and zz(x,i-1,l)
        z = ((mem and x[i]) and (not zz(x,i-1,k))) or ((not (mem and x[i])) and zz(x,i-1,k)) # mod((mem and x[i]) + zz(x,i-1,k),2)
    elif k==m:
        mem = 1
        for l in xrange(k):
            mem = mem and zz(x,i-1,l)
        z = (mem and x[i]) or zz(x,i-1,k)
    #print z,'z|',k,'k|', i,'i|', m,'m|'
    return(z)

def binsum_recur(x):# x is a binary vector
    z = []
    n = len(x)-1
    m = ceil(log(n+2,2))
    for k in xrange(m):
        z.append(zz(x,n,k))
    return(z)
        
x = seqvar('x',3)
print len(x), 'len x: ', x

print list(reversed(binsum_recur(x)))

### iterative algorithm for 2nd constraint (logical formula, symbolic, x and z as variable)
def binsum_iter(x):
    z={}
    n=len(x)
    for i in xrange(n):
        for k in xrange(n+1):
            z[i,k] = '0'
    for i in xrange(n):
        m=ceil(log(i+1+1,2))
        #print i,m
        for k in xrange(m):
            #print i,k
            if i==0 and k==0:
                z[i,k] = x[0]
            elif k==0:
                z[i,k] = '('+'z'+'_'+str(i-1)+'_'+str(k) + ' & '+ '~' + x[i] + ')' + ' | ' + '('+'~' + 'z'+'_'+str(i-1)+'_'+str(k)  + ' & '+ x[i]+')'  
            elif k<m-1:
                mem = '1'
                for l in xrange(k):
                    mem = mem +' & '+ 'z'+'_'+str(i-1)+'_'+str(l)
                z[i,k] = '('+'('+mem +' & '+ x[i]+')' +' & '+ '~'+ 'z'+'_'+str(i-1)+'_'+str(k)+')' +' | '+  '('+'~'+'('+mem +' & '+x[i]+')'+' & '+'z'+'_'+str(i-1)+'_'+str(k)+')' 
            elif k==m-1:
                mem = '1'
                for l in xrange(k):
                    mem = mem +' & '+z[i-1,l]
                z[i,k] = '('+mem +' & '+ x[i]+')' +' | '+ 'z'+'_'+str(i-1)+'_'+str(k)
            #print '|m',m,'|i',i,'|k',k,'|z',z[i,k]
    return z
 
z = binsum_iter(x)
#print x
print [z[len(x)-1,k] for k in xrange(ceil(log(len(x)+1,2)),-1,-1)]



###  simulation ##
#m = 2 # the size is 2m x 2m
#aa=arrvar('a',m)

#####generate
#balanced
#listpbal=Combinations(2*m,m+1)
#vcon2=balancearraylogic(aa,listpbal,m)
#vcon2_sat=balance_list_sat(m)

#identical columns and rows
# listunique=[[0,1]] #Combinations(2*m,2)
# vcon3=identicalcolrowlogic(aa,listunique,m)
# vcon3_sat=no_identical(m)
    
#no 3 consecutive 1 & no consecutive 0
# vcon1=no3conseclogic(aa,m)
# vcon1_sat=no_consecutive(m)

# ## all conditions
# allcondlogic=conjunct([vcon1,vcon2,vcon3])

#####print
# print("------------ balance:")
#print(vcon2)
#print(vcon2_sat)
# print("------------ unique col & row:")
# print(vcon3)
# print(vcon3_sat)
# print("------------ no 3 consequtive:")
# print(vcon1)
# print(vcon1_sat)
# print("------------ all constrains:")
# print(allcondlogic)

#####solve
# s=propcalc.formula(vcon2)
# s.convert_cnf_recur()
# print  s
#s.satformat()
# s.is_satisfiable()

# solver1=SAT()
# for clause in vcon1_sat:
#     solver1.add_clause(tuple(clause))
# solution1=[];
# for i in solver1()[1:]:
#     if i==True:
#         solution1.append(1)
#     elif i==False:
#         solution1.append(0)
# solution1=matrix(GF(2),2*m,solution1)
# print '\n',solution1

# solver2=SAT()
# for clause in vcon2_sat:
#     solver2.add_clause(tuple(clause))
# solution2=[];
# for i in solver2()[1:]:
#     if i==True:
#         solution2.append(1)
#     elif i==False:
#         solution2.append(0)
# solution2=matrix(GF(2),2*m,solution2)
# print '\n',solution2

# solver3=SAT()
# for clause in vcon3_sat:
#     solver3.add_clause(tuple(clause))
# solution3=[];
# for i in solver3()[1:]:
#     if i==True:
#         solution3.append(1)
#     elif i==False:
#         solution3.append(0)
# solution3=matrix(GF(2),2*m,solution3)
# print '\n',solution3

# solver=SAT()
# for clause in vcon1_sat:
#     solver.add_clause(tuple(clause))
# for clause in vcon2_sat:
#     solver.add_clause(tuple(clause))
# for clause in vcon3_sat:
#     solver.add_clause(tuple(clause))
# solution=[];
# for i in solver()[1:]:
#     if i==True:
#         solution.append(1)
#     elif i==False:
#         solution.append(0)
# solution=matrix(GF(2),2*m,solution)
# print '\n',solution

## partially solved puzzle
# if assigned to partial solved puzzle,
# follow the procedure below:
# 1. delete corresponding variable for in filled cell
# 2. if the filled cell equal to 1, delete the clause corresponding to the filled cell with entries 1
# 3. solve
# 4. replace cell with the original one.

# B4=matrix([[9,9,9,9],
#            [9,0,0,9],
#            [9,0,9,9],
#            [9,9,1,9]])

# B6=matrix([[9,9,1,9,9,9], # unique solution
#            [0,0,9,1,9,9],
#            [0,9,9,9,9,9],
#            [9,9,9,9,9,9],  
#            [9,9,9,1,9,9],
#            [9,9,9,9,0,9]])

# B8=matrix([[9,0,9,9,9,9,9,9],
#            [9,9,9,1,9,1,9,9],
#            [9,9,0,9,9,9,9,9],
#            [9,1,9,9,9,9,9,9],
#            [9,9,9,9,1,9,9,9],
#            [9,0,9,9,9,1,9,9],
#            [9,0,9,9,0,9,9,9],
#            [9,9,9,9,0,9,0,9]])

# B8_2=matrix([[9,0,9,9,9,9,9,9],
#              [9,9,9,1,9,1,9,0],
#              [9,9,0,9,9,9,9,9],
#              [9,1,9,9,9,9,9,9],
#              [9,9,9,9,1,9,9,9],
#              [9,0,9,9,9,1,9,9],
#              [9,0,9,9,0,9,9,9],
#              [9,9,9,9,0,9,0,9]])

# B8_3=matrix([[9,9,9,9,9,9,9,0],  # 
#              [9,0,0,9,9,1,9,9],
#              [9,0,9,9,9,1,9,0],
#              [9,9,1,9,9,9,9,9],
#              [0,0,9,1,9,9,1,9],
#              [9,9,9,9,1,9,9,9],
#              [1,1,9,9,9,0,9,1],
#              [9,1,9,9,9,9,9,1]])

# B8_4=matrix([[9,9,9,9,9,9,9,9], # multiple solution, blank puzzle
#              [9,9,9,9,9,9,9,9],
#              [9,9,9,9,9,9,9,9],
#              [9,9,9,9,9,9,9,9],
#              [9,9,9,9,9,9,9,9],
#              [9,9,9,9,9,9,9,9],
#              [9,9,9,9,9,9,9,9],
#              [9,9,9,9,9,9,9,9]])

# B10=matrix([[9,1,9,1,9,9,9,9,1,9],
#             [0,9,0,9,9,9,9,9,9,9],
#             [9,9,9,9,9,9,1,1,9,9],
#             [9,9,1,9,9,9,9,9,9,9],
#             [0,9,9,9,9,9,9,9,9,9],
#             [9,9,9,9,9,9,9,0,0,9],
#             [1,9,9,9,9,9,9,1,9,1],
#             [9,9,0,9,9,9,0,9,9,9],
#             [9,9,9,9,9,9,0,9,1,9],
#             [9,9,9,9,0,9,9,0,9,9]])

# B12=matrix([[9,9,9,9,9,9,9,0,0,9,1,9], # unique solution
#             [9,9,1,9,9,9,9,9,9,9,1,9],
#             [9,9,9,0,9,0,9,9,0,9,9,0],
#             [9,9,9,9,9,0,9,9,9,9,9,9],
#             [9,1,1,9,1,9,9,1,9,0,9,9],
#             [9,1,1,9,0,9,0,0,9,9,9,9],
#             [9,9,9,9,9,9,9,9,9,9,1,9],
#             [1,9,9,0,0,9,9,9,0,9,9,9],
#             [9,9,9,9,9,9,9,9,9,9,9,9],
#             [9,9,1,9,9,9,9,9,1,9,9,9],
#             [9,9,9,0,9,9,0,9,9,0,9,0],
#             [9,9,1,0,9,9,9,0,9,9,9,9]])

# B14=matrix([[9,9,9,9,1,0,9,9,9,9,9,9,9,1],
#             [1,9,9,9,9,0,9,9,9,1,9,1,9,1],
#             [9,9,1,9,9,9,1,9,9,9,9,9,9,9],
#             [0,9,9,9,9,1,1,9,9,9,9,0,9,1],
#             [0,9,0,9,9,9,9,9,1,9,9,9,9,1],
#             [9,0,9,9,9,9,9,9,0,9,9,9,9,9],
#             [9,9,1,9,9,9,9,9,9,1,9,9,1,9],
#             [9,9,1,9,0,9,9,1,9,9,0,9,9,9],
#             [9,9,9,9,9,1,9,1,9,9,9,9,1,9],
#             [0,9,1,0,9,1,9,9,9,9,0,9,9,9],
#             [9,9,1,9,9,9,9,9,9,9,0,0,9,9],
#             [9,9,9,0,9,9,9,9,9,9,9,9,9,9],
#             [9,1,9,9,9,9,9,9,9,0,9,9,9,9],
#             [9,9,0,9,9,9,0,9,9,9,9,0,9,9]])
#-----#
# tic=timeit.default_timer()
# A=B14
# m=len(A[0])/2
# fixed_cell=[]
# for i in xrange(2*m):
#     for j in xrange(2*m):
#         if A[i,j]==1:
#             fixed_cell.append([i*(2*m)+(j+1)])
#         if A[i,j]==0:
#             fixed_cell.append([-(i*(2*m)+(j+1))])


# #####generate
# vcon1_sat=balance_list_sat(m); vcon2_sat=no_identical(m); vcon3_sat=no_consecutive(m)
# #balanced
# #vcon1_sat=balance_list_sat(m)

# #identical columns and rows
# #vcon2_sat=no_identical(m)
    
# #no 3 consecutive 1 & no consecutive 0
# #vcon3_sat=no_consecutive(m)

# #####print
# # print("------------ balance:")
# # print(vcon1_sat)
# # print("------------ unique col & row:")
# # print(vcon2_sat)
# # print("------------ no 3 consequtive:")
# # print(vcon3_sat)


# #####solve######

# # solver1=SAT()
# # for clause in vcon1_sat:
# #     solver1.add_clause(tuple(clause))
# # for clause in fixed_cell:
# #     solver1.add_clause(tuple(clause))
# # solution1=[];
# # for i in solver1()[1:]:
# #     if i==True:
# #         solution1.append(1)
# #     elif i==False:
# #         solution1.append(0)
# # solution1=matrix(GF(2),2*m,solution1)
# # print '\n',solution1

# # solver2=SAT()
# # for clause in vcon2_sat:
# #     solver2.add_clause(tuple(clause))
# # for clause in fixed_cell:
# #     solver2.add_clause(tuple(clause))
# # solution2=[];
# # for i in solver2()[1:]:
# #     if i==True:
# #         solution2.append(1)
# #     elif i==False:
# #         solution2.append(0)
# # solution2=matrix(GF(2),2*m,solution2)
# # print '\n',solution2

# # solver3=SAT()
# # for clause in vcon3_sat:
# #     solver3.add_clause(tuple(clause))
# # for clause in fixed_cell:
# #     solver3.add_clause(tuple(clause))
# # solution3=[];
# # for i in solver3()[1:]:
# #     if i==True:
# #         solution3.append(1)
# #     elif i==False:
# #         solution3.append(0)
# # solution3=matrix(GF(2),2*m,solution3)
# # print '\n',solution3
# toc=timeit.default_timer()-tic;print '\n','time/duration: ', toc
# tic=timeit.default_timer()
# #solver:

# solver=SAT()
# for clause in vcon1_sat:
#     solver.add_clause(tuple(clause))
# for clause in vcon2_sat:
#     solver.add_clause(tuple(clause))
# for clause in vcon3_sat:
#     solver.add_clause(tuple(clause))
# for clause in fixed_cell:
#     solver.add_clause(tuple(clause))
# toc=timeit.default_timer()-tic;print '\n','time/duration: ', toc    
# tic=timeit.default_timer()

# #postcomputation:   
# solution=[];
# for i in solver()[1:]:
#     if i==True:
#         solution.append(1)
#     elif i==False:
#         solution.append(0)
# solution=matrix(GF(2),2*m,solution)
# print '\n',solution

# toc=timeit.default_timer()-tic;print '\n','time/duration: ', toc

