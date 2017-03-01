reset()
import timeit
print
##identical columns and rows  $\binom{2m}{2} \times 2^{2m} \times 2 $   clause and each clause have $2 \times 2m$ literal
# generate cnf based on original expression and tseytin transformation


# def noidentic_tse_cnf(m):
#     list_comb2 = Combinations(2*m,2);
#     for jj in list_comb2:
#         for i in xrange(2*m):
#             print '-x_'+str(i)+'_'+str(jj[0])+' V '+ '-x_'+str(i)+'_'+str(jj[1])+' V '+ 'A_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])
#             print 'x_'+str(i)+'_'+str(jj[0])+' V '+ '-A_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])
#             print 'x_'+str(i)+'_'+str(jj[1])+' V '+ '-A_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])
#             print 'x_'+str(i)+'_'+str(jj[0])+' V '+ 'x_'+str(i)+'_'+str(jj[1])+' V '+ 'B_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])
#             print '-x_'+str(i)+'_'+str(jj[0])+' V '+ '-A_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])
#             print '-x_'+str(i)+'_'+str(jj[1])+' V '+ '-A_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])        
#             print 'A_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])+' V '+ 'B_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])+' V '+ '-C_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])
#             print '-A_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])+' V '+ 'C_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])
#             print '-B_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])+' V '+ 'C_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])
#         print '-D_'+str(jj[0])+'_'+str(jj[1])  ,
#         for i in xrange(2*m):
#             print 'V C'+'_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1]) , 
#         print 
#         for i in xrange(2*m):
#             print 'D_'+str(jj[0])+'_'+str(jj[1])+' V C'+'_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])   

# # x_ij  :=> (i*(2*m) + (j+1)                                                                             )  
# # A_ijk :=> ((2*m)^2 +                         (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
# # B_ijk :=> ((2*m)^2 +   binomial(2*m,2)*2*m + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
# # C_ijk :=> ((2*m)^2 + 2*binomial(2*m,2)*2*m + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
# # D_ijk :=> ((2*m)^2 + 3*binomial(2*m,2)*2*m + 1 + ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)                )
# def noidentic_tse_cnf_dim(m):
#     list_comb2 = Combinations(2*m,2);
#     def X(i,j):
#         return i*(2*m) + (j+1)     
#     def A(i,j,k):
#         return ((2*m)^2 + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
#     def B(i,j,k):
#         return ((2*m)^2 +   binomial(2*m,2)*2*m + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
#     def C(i,j,k):
#         return ((2*m)^2 + 2*binomial(2*m,2)*2*m + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
#     def D(j,k):
#         return ((2*m)^2 + 3*binomial(2*m,2)*2*m + 1+ ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)                )
#     for jj in list_comb2:
#         for i in xrange(2*m):
#             print '-x_'+str(i)+'_'+str(jj[0])+' V '+ '-x_'+str(i)+'_'+str(jj[1])+' V '+ 'A_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])
#             print [-X(i,jj[0]), - X(i,jj[1]), A(i,jj[0],jj[1])  ]
#             print 'x_'+str(i)+'_'+str(jj[0])+' V '+ '-A_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])
#             print [X(i,jj[0]), -A(i,jj[0],jj[1])  ]
#             print 'x_'+str(i)+'_'+str(jj[1])+' V '+ '-A_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])
#             print [X(i,jj[1]), -A(i,jj[0],jj[1])  ]
#             print 'x_'+str(i)+'_'+str(jj[0])+' V '+ 'x_'+str(i)+'_'+str(jj[1])+' V '+ 'B_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])
#             print [X(i,jj[0]), X(i,jj[1]),- B(i,jj[0],jj[1])  ]
#             print '-x_'+str(i)+'_'+str(jj[0])+' V '+ '-B_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])
#             print [-X(i,jj[0]),- B(i,jj[0],jj[1])  ]
#             print '-x_'+str(i)+'_'+str(jj[1])+' V '+ '-B_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])
#             print [-X(i,jj[1]),- B(i,jj[0],jj[1])  ]
#             print 'A_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])+' V '+ 'B_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])+' V '+ '-C_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])
#             print [A(i,jj[0],jj[1]),B(i,jj[0],jj[1]),-C(i,jj[0],jj[1]) ]
#             print '-A_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])+' V '+ 'C_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])
#             print [-A(i,jj[0],jj[1]),C(i,jj[0],jj[1]) ]
#             print '-B_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])+' V '+ 'C_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])
#             print [-B(i,jj[0],jj[1]),C(i,jj[0],jj[1]) ]
#             print 'D_'+str(jj[0])+'_'+str(jj[1])+' V C'+'_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1])
#             print [D(jj[0],jj[1]),C(i,jj[0],jj[1]) ]
#         print '-D_'+str(jj[0])+'_'+str(jj[1])  ,
#         for i in xrange(2*m):
#             print 'V -C'+'_'+str(i)+'_'+str(jj[0])+'_'+str(jj[1]) , 
#         print 
#         print [D(jj[0],jj[1]) ]+ [-C(i,jj[0],jj[1]) for i in xrange(2*m)] 

# def noidentic_tse_cnf_dim_v2(m):
#     list_comb2 = Combinations(2*m,2);
#     def X(i,j):
#         return i*(2*m) + (j+1)     
#     def Ac(i,j,k):
#         return ((2*m)^2 + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
#     def Bc(i,j,k):
#         return ((2*m)^2 +   binomial(2*m,2)*2*m + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
#     def Cc(i,j,k):
#         return ((2*m)^2 + 2*binomial(2*m,2)*2*m + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
#     def Dc(j,k):
#         return ((2*m)^2 + 3*binomial(2*m,2)*2*m +1+ ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)                )
#     def Ar(i,j,k):
#         return ((2*m)^2 + binomial(2*m,2) + 3*binomial(2*m,2)*2*m   + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
#     def Br(i,j,k):
#         return ((2*m)^2 + binomial(2*m,2) + 4*binomial(2*m,2)*2*m + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
#     def Cr(i,j,k):
#         return ((2*m)^2 + binomial(2*m,2) + 5*binomial(2*m,2)*2*m + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
#     def Dr(j,k):
#         return ((2*m)^2 + binomial(2*m,2) + 6*binomial(2*m,2)*2*m +1+ ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)                )
#     for jj in list_comb2:
#         for i in xrange(2*m):
#             print '----'
#             print [-X(i,jj[0]), - X(i,jj[1]), Ac(i,jj[0],jj[1])  ]
#             print [X(i,jj[0]), -Ac(i,jj[0],jj[1])  ]
#             print [X(i,jj[1]), -Ac(i,jj[0],jj[1])  ]
#             print [X(i,jj[0]), X(i,jj[1]), Bc(i,jj[0],jj[1])  ]
#             print [-X(i,jj[0]),- Bc(i,jj[0],jj[1])  ]
#             print [-X(i,jj[1]),- Bc(i,jj[0],jj[1])  ]
#             print [Ac(i,jj[0],jj[1]),Bc(i,jj[0],jj[1]),-Cc(i,jj[0],jj[1]) ]
#             print [-Ac(i,jj[0],jj[1]),Cc(i,jj[0],jj[1]) ]
#             print [-Bc(i,jj[0],jj[1]),Cc(i,jj[0],jj[1]) ]
#             print [Dc(jj[0],jj[1]),Cc(i,jj[0],jj[1]) ]
#             print '---'
#             print [-X(jj[0],i), - X(jj[1],i), Ar(i,jj[0],jj[1])  ]
#             print [X(jj[0],i), -Ar(i,jj[0],jj[1])  ]
#             print [X(jj[1],i), -Ar(i,jj[0],jj[1])  ]
#             print [X(jj[0],i), X(jj[1],i), Br(i,jj[0],jj[1])  ]
#             print [-X(jj[0],i),- Br(i,jj[0],jj[1])  ]
#             print [-X(jj[1],i),- Br(i,jj[0],jj[1])  ]
#             print [Ar(i,jj[0],jj[1]),Br(i,jj[0],jj[1]),-Cr(i,jj[0],jj[1]) ]
#             print [-Ar(i,jj[0],jj[1]),Cr(i,jj[0],jj[1]) ]
#             print [-Br(i,jj[0],jj[1]),Cr(i,jj[0],jj[1]) ]
#             print [Dr(jj[0],jj[1]),Cr(i,jj[0],jj[1]) ]
#         print [Dc(jj[0],jj[1]) ]+ [-Cc(i,jj[0],jj[1]) for i in xrange(2*m)]
#         print [Dr(jj[0],jj[1]) ]+ [-Cr(i,jj[0],jj[1]) for i in xrange(2*m)] 



# def noidentic_tse_cnf_dim_list(m):
#     def X(i,j):
#         return i*(2*m) + (j+1)     
#     def Ac(i,j,k):
#         return ((2*m)^2 + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
#     def Bc(i,j,k):
#         return ((2*m)^2 +  binomial(2*m,2)*2*m + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
#     def Cc(i,j,k):
#         return ((2*m)^2 + 2*binomial(2*m,2)*2*m + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
#     def Dc(j,k):
#         return ((2*m)^2 + 3*binomial(2*m,2)*2*m +1+ ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)                )
#     def Ar(i,j,k):
#         return ((2*m)^2 + binomial(2*m,2) + 3*binomial(2*m,2)*2*m   + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
#     def Br(i,j,k):
#         return ((2*m)^2 + binomial(2*m,2) + 4*binomial(2*m,2)*2*m + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
#     def Cr(i,j,k):
#         return ((2*m)^2 + binomial(2*m,2) + 5*binomial(2*m,2)*2*m + (i+1) + 2*m * ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)  )
#     def Dr(j,k):
#         return ((2*m)^2 + binomial(2*m,2) + 6*binomial(2*m,2)*2*m +1+ ( binomial(2*m,2)-binomial(2*m-j,2)+k-j-1)                )
#     list_comb2 = Combinations(2*m,2);
#     clause_list=[]
#     for jj in list_comb2:
#         for i in xrange(2*m):
#             clause_list.append( [-X(i,jj[0]), - X(i,jj[1]), Ac(i,jj[0],jj[1])  ])
#             clause_list.append( [X(i,jj[0]), -Ac(i,jj[0],jj[1])  ])
#             clause_list.append( [X(i,jj[1]), -Ac(i,jj[0],jj[1])  ])
#             clause_list.append( [X(i,jj[0]), X(i,jj[1]), Bc(i,jj[0],jj[1])  ])
#             clause_list.append( [-X(i,jj[0]),- Bc(i,jj[0],jj[1])  ])
#             clause_list.append( [-X(i,jj[1]),- Bc(i,jj[0],jj[1])  ])
#             clause_list.append( [Ac(i,jj[0],jj[1]),Bc(i,jj[0],jj[1]),-Cc(i,jj[0],jj[1]) ])
#             clause_list.append( [-Ac(i,jj[0],jj[1]),Cc(i,jj[0],jj[1]) ])
#             clause_list.append( [-Bc(i,jj[0],jj[1]),Cc(i,jj[0],jj[1]) ])
#             clause_list.append( [Dc(jj[0],jj[1]),Cc(i,jj[0],jj[1]) ])
#             clause_list.append( [-X(jj[0],i), - X(jj[1],i), Ar(i,jj[0],jj[1])  ])
#             clause_list.append( [X(jj[0],i), -Ar(i,jj[0],jj[1])  ])
#             clause_list.append( [X(jj[1],i), -Ar(i,jj[0],jj[1])  ])
#             clause_list.append( [X(jj[0],i), X(jj[1],i), Br(i,jj[0],jj[1])  ])
#             clause_list.append( [-X(jj[0],i),- Br(i,jj[0],jj[1])  ])
#             clause_list.append( [-X(jj[1],i),- Br(i,jj[0],jj[1])  ])
#             clause_list.append( [Ar(i,jj[0],jj[1]),Br(i,jj[0],jj[1]),-Cr(i,jj[0],jj[1]) ])
#             clause_list.append( [-Ar(i,jj[0],jj[1]),Cr(i,jj[0],jj[1]) ])
#             clause_list.append( [-Br(i,jj[0],jj[1]),Cr(i,jj[0],jj[1]) ])
#             clause_list.append( [Dr(jj[0],jj[1]),Cr(i,jj[0],jj[1]) ])
#         clause_list.append( [Dc(jj[0],jj[1]) ]+ [-Cc(i,jj[0],jj[1]) for i in xrange(2*m)])
#         clause_list.append( [Dr(jj[0],jj[1]) ]+ [-Cr(i,jj[0],jj[1]) for i in xrange(2*m)] )
#     return(clause_list)

# def no_identical_orig(m):
#     list_comb=Combinations(xrange(2*m))
#     list_2comb=Combinations(xrange(2*m),2)
#     clause_list=[]
#     for i in  list_2comb:
#         for k in list_comb:
#             clause_row=[]
#             clause_col=[]
#             for j in xrange(2*m):
#                 if j in k:
#                     clause_row.append([-(i[0]*2*m+(j+1)), -((i[1]*2*m)+(j+1))])
#                     clause_col.append([-((j*2*m)+(i[0]+1)), -((j*2*m)+(i[1]+1))])
#                 else:
#                     clause_row.append([(i[0]*2*m)+(j+1), (i[1]*2*m)+(j+1)])
#                     clause_col.append([(j*2*m)+(i[0]+1), (j*2*m)+(i[1]+1)])
#             clause_list.append(flatten(clause_col))
#             clause_list.append(flatten(clause_row))
            
            
#     return clause_list


# print
# tic = timeit.default_timer()
# print len(noidentic_tse_cnf_dim_list(7))
# print timeit.default_timer()-tic
# tic = timeit.default_timer()
# print len(no_identical_orig(7))
# print timeit.default_timer()-tic

B=matrix([[9,9,1,9,9,9], # unique solution
           [0,0,9,1,9,9],
           [0,9,9,9,9,9],
           [9,9,9,9,9,9],  
           [9,9,9,1,9,9],
           [9,9,9,9,0,9]])

load("binario_sat_cnf_tseytin.sage")
#load("binario_sat_cnf.sage")
load("binario_exh.sage")
# load("binario_gb.sage")
# load("binario_smt_bv.sage")

nn = B.ncols(); m=int(nn/2)
# M={}
# for i in xrange(nn):
#     for j in xrange(nn):
#         if B[i,j] != 9:
#             M[i,j] = B[i,j]


# F=binpuzzle2mpolynomials(nn, M)
# time G = F.groebner_basis()
# for g in G:
#     print g

print solvepuzzle(B)


binario_cnf_sat = binario_generate_cnf(m,B)
solver = SAT(solver="cryptominisat")
for clause in binario_cnf_sat:
    solver.add_clause(tuple(clause))
solution = [];
for i in solver()[1:]:
    if i == True:
        solution.append(1)
    elif i == False:
        solution.append(0)
solution = matrix(GF(2),2*m,solution[0:nn^2])
print solution
