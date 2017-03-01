reset()
load("binpuzzle_gb.sage")
load("solvepuzzle_exh.sage")
load("satbinariocnf_ver2.sage")
import timeit


#-----#

A=B12
m=A.nrows()/2
number_of_blank=sum(list(list(a).count(9) for a in A))
                                                                                                                    
"""### exhausive search
tic=timeit.default_timer()
A1 = solvepuzzle(A)
toc_exh_c = timeit.default_timer()-tic;print 2*m,'x',2*m,'|blanks: ',number_of_blank,'| comp exh        : ', toc_exh_c      
#print '------------------------------------------'

"""
### SATsolver
tic =timeit.default_timer()
fixed_cell =[]
for i in xrange(2*m):
    for j in xrange(2*m):
        if A[i,j] == 1:
            fixed_cell.append([i*(2*m)+(j+1)])
        if A[i,j] == 0:
            fixed_cell.append([-(i*(2*m)+(j+1))])
#generate
vcon1_sat=no_consecutive(m); vcon2_sat = balance_list_sat(m); vcon3_sat=no_identical(m);
toc_sat_p = timeit.default_timer()-tic;print 2*m,'x',2*m,'|blanks: ',number_of_blank,'| precomp sat: ', toc_sat_p
print len(vcon1_sat)
print len(vcon2_sat)
print len(vcon3_sat)

"""
##solver:
tic = timeit.default_timer()
solver = SAT(solver="cryptominisat")
for clause in vcon1_sat:
    solver.add_clause(tuple(clause))
for clause in vcon2_sat:
    solver.add_clause(tuple(clause))
for clause in vcon3_sat:
    solver.add_clause(tuple(clause))
for clause in fixed_cell:
    solver.add_clause(tuple(clause))
toc_sat_c = timeit.default_timer()-tic;print 2*m,'x',2*m,'|blanks: ',number_of_blank,'| comp sat        : ', toc_sat_c        

#postcomputation:
tic = timeit.default_timer()
solution = [];
for i in solver()[1:]:
    if i == True:
        solution.append(1)
    elif i == False:
        solution.append(0)
solution = matrix(GF(2),2*m,solution)
toc_sat_a = timeit.default_timer()-tic;print 2*m,'x',2*m,'|blanks: ',number_of_blank,'| after comp sat    : ', toc_sat_a
#print '------------------------------------------'


### groebner basis
#precomputation
tic = timeit.default_timer()
n = 2*m
M = {}
for i in xrange(n):
    for j in xrange(n):
        if A[i,j] != 9:
            M[i,j] = A[i,j]
F = binpuzzle2mpolynomials(n,M)
toc_groeb_p = timeit.default_timer()-tic; print 2*m,'x',2*m,'|blanks: ',number_of_blank,'| precomp groebner: ', toc_groeb_p
# computation
tic = timeit.default_timer()
G = F.groebner_basis()
toc_groeb_c = timeit.default_timer()-tic; print 2*m,'x',2*m,'|blanks: ',number_of_blank,'| comp groebner   : ', toc_groeb_c     
"""

"""
#Generate random puzzle ( not need to have unique solution)
print '\n';
for m in [3]:
    timing=[]
    for numblank in [i+1 for i in [0..30]]:
        A = matrix(2*m,2*m,[9 for i in xrange((2*m)^2)])
        A = solvepuzzle_rand(A)
        number_of_blank = numblank           #2,3,5,7,9,11,...
        location_index = cartesian_product([Set(xrange((2*m))), Set(xrange((2*m)))])
        set_of_blank_cell = Subsets(location_index,number_of_blank)
        index_of_blank_cell = set_of_blank_cell.random_element()
        for i in index_of_blank_cell:
            A[i[0],i[1]] = 9
        
        ### exhausive search
        tic=timeit.default_timer()
        A1 = (solvepuzzle(A)) 
        toc_exh_c = timeit.default_timer()-tic;print 2*m,'x',2*m,'|blanks: ',number_of_blank,'| comp exh        : ', toc_exh_c
        print '------------------------------------------'
        timing.append([number_of_blank, toc_exh_c])
    

        ### SAT solver
        tic = timeit.default_timer()
        fixed_cell = []
        for i in xrange(2*m):
            for j in xrange(2*m):
                if A[i,j] == 1:
                    fixed_cell.append([i*(2*m)+(j+1)])
                if A[i,j] == 0:
                    fixed_cell.append([-(i*(2*m)+(j+1))])
        #generate
        vcon1_sat=no_consecutive(m); vcon2_sat = balance_list_sat(m); vcon3_sat=no_identical(m);
        toc_sat_p = timeit.default_timer()-tic;print 2*m,'x',2*m,'|blanks: ',number_of_blank,'| precomp sat     : ', toc_sat_p
    
        ##solver:
        tic = timeit.default_timer()
        solver = SAT(solver="cryptominisat")
        for clause in vcon1_sat:
            solver.add_clause(tuple(clause))
        for clause in vcon2_sat:
            solver.add_clause(tuple(clause))
        for clause in vcon3_sat:
            solver.add_clause(tuple(clause))
        for clause in fixed_cell:
            solver.add_clause(tuple(clause))
        toc_sat_c = timeit.default_timer()-tic;print 2*m,'x',2*m,'|blanks: ',number_of_blank,'| comp sat        : ', toc_sat_c    

        #postcomputation:   
        tic = timeit.default_timer()
        solution = [];
        for i in solver()[1:]:
            if i == True:
                solution.append(1)
            elif i == False:
                solution.append(0)
        solution = matrix(GF(2),2*m,solution)
        toc_sat_a = timeit.default_timer()-tic;print 2*m,'x',2*m,'|blanks: ',number_of_blank,'| after comp sat  : ', toc_sat_a
        print '------------------------------------------'
            
    
        ### groebner basis
        #precomputation
        tic = timeit.default_timer()
        n = 2*m
        M = {}
        for i in xrange(n):
            for j in xrange(n):
                if A[i,j] != 9:
                    M[i,j] = A[i,j]
        F = binpuzzle2mpolynomials(n, M)
        toc_groeb_p = timeit.default_timer()-tic; print 2*m,'x',2*m,'|blanks: ',number_of_blank,'| precomp groebner: ', toc_groeb_p
        # computation
        tic = timeit.default_timer()
        G = F.groebner_basis()
        toc_groeb_c = timeit.default_timer()-tic; print 2*m,'x',2*m,'|blanks: ',number_of_blank,'| comp groebner   : ', toc_groeb_c     
        print '======================================================='
        timing.append([number_of_blank,toc_exh_c , toc_sat_p, toc_sat_c, toc_sat_a, toc_groeb_p, toc_groeb_c])
    print m, timing
"""



