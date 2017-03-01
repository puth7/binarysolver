import timeit
############################
"""
    Binary Puzzle to Multivariate Polynomial Converter
    AUTHOR : Rusydi H. Makarim <makarim@cwi.nl>

    REFERENCES :
    [UtomoPellikaan15] P.H. Utomo and R. Pellikaan. *Binary Puzzle as Erasure
    Decoding Problem*; Available at http://www.win.tue.nl/~ruudp/paper/72.pdf.
"""

def binpuzzle2mpolynomials(n, M, use_constraint3=True):
    if (n % 2 != 0):
        raise ValueError("The size n must be multiple of 2");
    F = []
    var_names = [ "x_%s_%s" % (i, j) for i in xrange(n) for j in xrange(n) ]
    R = BooleanPolynomialRing(n**2, var_names, order="deglex")
    #set all known values
    for m in M:
        f = R("x_%s_%s" % (m[0], m[1])) + M[m]
        F.append(f)
    ###constraint 1
    def constraint1(x):
        x1, x2, x3 = x[0], x[1], x[2]
        f = x1*x2 + x1*x3 + x1 + x2*x3 + x2 + x3 + 1
        return f
    #row
    for i in xrange(n):
        for j in xrange(n-2):
            x1 = R("x_%s_%s" % (i, j))
            x2 = R("x_%s_%s" % (i, j + 1))
            x3 = R("x_%s_%s" % (i, j + 2))
            F.append( constraint1([x1, x2, x3]) )
    #column
    for j in xrange(n):
        for i in xrange(n-2):
            x1 = R("x_%s_%s" % (i, j))
            x2 = R("x_%s_%s" % (i + 1, j))
            x3 = R("x_%s_%s" % (i + 2, j))

            F.append( constraint1([x1, x2, x3]) )
    ###constraint 2
    def constraint2(U, x):
        f = 0
        for u in U:
            m = 1
            for k in xrange(n):
                m = m * x[k]**u[k]
            f = f + m
        return f + 1
    V = VectorSpace(GF(2), n)
    U = []
    for v in V:
        if ((binomial(v.hamming_weight(), n / 2) % 2) == 1):
            U.append(v)
    #row
    for i in xrange(n):
        x = [ R("x_%s_%s" % (i, j)) for j in xrange(n) ]
        F.append( constraint2(U, x) )
    #column
    for j in xrange(n):
        x = [ R("x_%s_%s" % (i, j)) for i in xrange(n) ]
        F.append( constraint2(U, x) )
    ###constraint 3
    if (use_constraint3):
        def constraint3(U, x, y):
            f = 0
            for u in U:
                m = 1
                for k in xrange(n):
                    m = m * (x[k] + y[k])**u[k]
                f = f + m
            return f
        #row
        for i in xrange(n):
            row_vars1 = [ R("x_%s_%s" % (i, k)) for k in xrange(n) ]
            for j in xrange(i+1, n):
                row_vars2 = [ R("x_%s_%s" % (j, k)) for k in xrange(n) ]
                F.append( constraint3(V[:], row_vars1, row_vars2) )
        #column
        for i in xrange(n):
            col_vars1 = [ R("x_%s_%s" % (k, i)) for k in xrange(n) ]
            for j in xrange(i+1, n):
                col_vars2 = [ R("x_%s_%s" % (k, j)) for k in xrange(n) ]
                F.append( constraint3(V[:], col_vars1, col_vars2) )
    return Sequence(F);

# puzzle yang tidak memiliki solusi
# B0=matrix(GF(2),12)


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


# B10_2=matrix([[0,0,9,9,9,1,9,9,9,9],
#               [9,9,9,1,1,9,9,9,9,9],
#               [0,9,9,9,0,9,9,9,1,9],
#               [9,9,9,1,9,9,9,0,9,9],
#               [0,0,9,9,0,9,9,9,9,9],
#               [9,9,9,1,9,9,9,9,9,9],
#               [9,0,9,9,9,9,9,9,1,9],
#               [9,9,1,9,9,9,9,9,9,0],
#               [9,9,9,9,1,9,9,0,9,9],
#               [9,9,9,9,9,9,9,9,9,9]])


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
# #-----#
# B=B10_2

# n = B.ncols()
# M={}
# for i in xrange(n):
#     for j in xrange(n):
#         if B[i,j] != 9:
#             M[i,j] = B[i,j]


# time F=binpuzzle2mpolynomials(n, M)
# #F = binpuzzle2mpolynomials(n, M)
# time G = F.groebner_basis()
# for g in G:
#     print g
# #print F,'\n',G
# toc=timeit.default_timer()-tic;print '\n','time/duration: ', toc
