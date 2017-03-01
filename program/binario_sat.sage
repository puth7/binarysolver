#import sage.logic.propcalc as propcalc

##misc function
def negat(v): # put ~ on each entry of v. v is an sequence
    vv=list('~'+str(a) for a in v)
    return(vv)
            
def negat2(aa): # put ~ on each entry of aa. aa is an dict
    aa1={}
    for key in aa:
        aa1[key]='~'+str(aa[key])
    return(aa1)

def seqvar(x,n):
    xx={}
    for i in range(n):
        xx[i]=str(x)+'_'+str(i)
    return(xx)

def arrvar(a,m):#creating an dict array with variable a (2m * 2m)
    aa={}
    for i in range(2*m):
        for j in range(2*m):
            aa[i,j]=str(a)+'_'+str(i)+'_'+str(j)
    return(aa)

def disjunct(v): # create or (disjunctive)
    nv=len(v)
    fv='('
    for i in range(nv):
        if(i==0):
            fv=fv+str(v[i])
        else:
            fv=fv+'|'+str(v[i])       
    fv=fv+')'
    return(fv) #fv is the disjunctive formula for  v

def conjunct(v): #create and(conjuctive) formula
    nv=len(v)
    fv='('
    for i in range(nv):
        if(i==0):
            fv=fv+str(v[i])
        else:
            fv=fv+'&'+str(v[i])       
    fv=fv+')'
    return(fv) #fv is the conjunctive formula for  v

## identical column and rows
def icrlpart1col(aa,i,p):
    v1=list(aa[i,j] for j in p)
    v0=negat(v1)
    v1=conjunct(v1)
    v0=conjunct(v0)
    vv=disjunct([v1,v0])
    return(vv)

def icrlpart1row(aa,j,p):
    v1=list(aa[i,j] for i in p)
    v0=negat(v1)
    v1=conjunct(v1)
    v0=conjunct(v0)
    vv=disjunct([v1,v0])
    return(vv)

def icrlpart2(aa,p,m,stat): #changed to return negat(vv)
    vv=[]
    if (stat=='col'):
        for i in range(2*m):
            v=icrlpart1col(aa,i,p)
            vv.append(v)
        vv=conjunct(vv)
        return(vv)
    elif(stat=='row'):
        for j in range(2*m):
            v=icrlpart1row(aa,j,p)
            vv.append(v)
        vv=conjunct(vv)
        return('~'+str(vv))
    else:
        print('error, stat must me row or col')
    return()
        
def icrlpart3(aa,listp,m,stat):
    vv=[]
    for p in listp:
        v=icrlpart2(aa,p,m,stat)
        vv.append(v)
    vv=conjunct(vv)
    return(vv)

def identicalcolrowlogic(aa,listp,m):  #debugged
    vv=[]
    v1=icrlpart3(aa,listp,m,'row')
    # v2=icrlpart3(aa,listp,m,'col')
    # vv=conjunct([v1,v2])
    return(v1)

##balanced condition
# do for m+1 length sequence: v   ? why
#create the clause
def therow(aa,listp,m,i):# logical formula for a row i (balanced)
    listfv=[]
    for p in listp:
        v=list(aa[i,j] for j in p)
        fv=disjunct(v)
        listfv.append(fv)
    rowf=conjunct(listfv)
    return(rowf)

def thecol(aa,listp,m,j):# logical formula for a col j : (balanced)
    listfv=[]
    for p in listp:
        v=list(aa[i,j] for i in p)
        fv=disjunct(v)
        listfv.append(fv)
    colf=conjunct(listfv)
    return(colf)

def alltherow(aa,listp,m) :# logical formula for all row (balanced)
    listallrow=[]
    for i in range(2*m):
        rowfi=therow(aa,listp,m,i)
        listallrow.append(rowfi)
    allrowf=conjunct(listallrow)
    return(allrowf)
    
def allthecol(aa,listp,m,): # logical formula for all column (balanced )
    listallcol=[]
    for i in range(2*m):
        colfi=thecol(aa,listp,m,i)
        listallcol.append(colfi)
    allcolf=conjunct(listallcol)
    return(allcolf)

def balrayf(aa,listp,m): # every (m+1) choice, there must be one atoms to be true
    allrowf=alltherow(aa,listp,m)
    allcolf=allthecol(aa,listp,m)
    arrayf=conjunct([allrowf,allcolf])
    return(arrayf)

def balancearraylogic(aa,listp,m): # logical formula for balanced array
    vv1=balrayf(aa,listp,m)
    aa0=negat2(aa)
    vv0=balrayf(aa0,listp,m)
    vvv=conjunct([vv1,vv0])
    return(vvv)

##no 3 consecutive 1 and no 3 consecutive 0        
def n3clpart1row(aa,i,jj):
    p=[jj..jj+2]
    v2=list(aa[i,j] for j in p)
    v1=negat(v2)
    v1=disjunct(v1)
    v2=disjunct(v2)
    v=conjunct([v1,v2])
    return(v)

def n3clpart1col(aa,ii,j): #no 3 cons for column j
    p=[ii..ii+2]
    v2=list(aa[i,j] for i in p)
    v1=negat(v2)
    v1=disjunct(v1)
    v2=disjunct(v2)
    v=conjunct([v1,v2])
    return(v)

def n3clpart2(aa,m,i,stat):
    if(stat=='row'):
        v=list(n3clpart1row(aa,i,jj) for jj in xrange(2*m-2))
        v=conjunct(v)
        return(v)
    elif(stat=='col'):
        v=list(n3clpart1col(aa,jj,i) for jj in xrange(2*m-2))
        v=conjunct(v)
        return(v)
    else:
        print("error. stat not correct")

def n3clpart3(aa,m,stat):
    v=list(n3clpart2(aa,m,i,stat) for i in range(2*m))
    v=conjunct(v)
    return(v)

def no3conseclogic(aa,m):
    vv=[]
    v1=n3clpart3(aa,m,'col')
    v2=n3clpart3(aa,m,'row')
    vv=conjunct([v1,v2])
    return(vv)




###  simulation ##
# m = 4 # the size is 2m x 2m
# aa=arrvar('a',m)

#####generate
#balanced
# listpbal=Combinations(2*m,m+1)
# vcon1=balancearraylogic(aa,listpbal,m)
# vcon1_sat=balance_list_sat(m)

#identical columns and rows
# listunique=[[0,1]] #Combinations(2*m,2)
# vcon2=identicalcolrowlogic(aa,listunique,m)
# vcon2_sat=no_identical(m)
    
#no 3 consecutive 1 & no consecutive 0
# vcon3=no3conseclogic(aa,m)
# vcon3_sat=no_consecutive(m)

# ## all conditions
# allcondlogic=conjunct([vcon1,vcon2,vcon3])

#####print
# print("------------ balance:")
# print(vcon1)
# print(vcon1_sat)
# print("------------ unique col & row:")
# print(vcon2)
# print(vcon2_sat)
# print("------------ no 3 consequtive:")
# print(vcon3)
# print(vcon3_sat)
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
