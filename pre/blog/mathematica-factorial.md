2020-08-21 21:26 -0500 // programming, mathematica

# Factorial in Mathematica

\noindent Here is a list of (mostly) increasingly stupid ways
of calculating the factorial of `n` in Mathematica. [EXCERPT]
(some of them only work for `n>0` or `n>1`)

<pre style='font-size:10pt'>n!
Gamma[n+1]
n!!(n-1)!!
D[x^n,{x,n}]
1##&amp;@@Range@n
1~Pochhammer~n
x~Product~{x,n}
E^Tr[Log/@Range@n]
n~FactorialPower~n
Log/@Range@n//Exp@*Tr
Permanent@Array[1&amp;,{n,n}]
Denominator@LaguerreL[n,x]
GroupOrder@SymmetricGroup@n
Length@Permutations@Range@n
Module[{m=1},Nest[m++#&amp;,1,n]]
1/Series[E^x,{x,0,n}][[3,-1]]
Delete@0/@Times@@Sum[0@x,{x,n}]
1/Nest[#~Integrate~x&amp;,1,n]/.x-&gt;1
AlternatingFactorial/@{n-1,n}//Tr
Length@Det@Array[Unique[]&amp;,{n,n}]
Times@@FixedPointList[#+1&amp;,1,n-1]
Denominator@RegionMeasure@Ball[2n]
Nest[Depth[#]@#&amp;,1,n]//.x_@y_-&gt;x*y
Denominator@Residue[f@z/z/z^n,{z,0}]
1//Composition@@Table[y#&amp;/.y-&gt;x,{x,n}]
1+Tr@Table[Pochhammer[2,x-1]x,{x,n-1}]
{n,1}//.{x_?Positive,y_}:&gt;{x-1,x*y}//Tr
FindSequenceFunction[{1,2,6,24},x]/.x-&gt;n
Times@@Reap[n//.x_?Positive:&gt;Sow@x-1][[2,1]]
Numerator@Moment[ExponentialDistribution@x,n]
ToString@n&lt;&gt;FromCharacterCode@33//ToExpression
GroupOrder@GraphAutomorphismGroup@CompleteGraph@n
Tr@Flatten@Nest[ConstantArray[#,Length@#+1]&amp;,1,n]
Abs@Numerator@FunctionExpand@Binomial[n,k]/.k-&gt;1/2
RecurrenceTable[a@x==a[x-1]x&amp;&amp;a@0==1,a,{x,n}][[-1]]
(RSolve[a@x==x*a[x-1]&amp;&amp;a@0==1,a@x,x]/.x-&gt;n)[[1,1,2]]
TuringMachine[{{s_,v_}-&gt;{s*v,v+1,0}},{1,{1}},n][[-1,1,1]]
Block[{x=n},ToExpression@#]&amp;@StringReverse@ToString@Not@x
First@ToExpression@StringReplace[ToString@Range@n,&quot;,&quot;-&gt;&quot;*&quot;]
Expand@MatrixPower[({{x,x},{0,1}}),n][[1,2]]/.x^y_.-&gt;Log@y//Exp
(DSolve[f&apos;@x==PolyGamma[0,x]f@x&amp;&amp;f@1==1,f@x,x]/.x-&gt;n+1)[[1,1,2]]
Times@@Cases[CoefficientRules@Factor[(x^n-1)/(x-1)],{x_}:&gt;x+1,2]
Length@SubstitutionSystem[{x_:&gt;ConstantArray[x+1,x]},{1},{n}][[1]]
DSolve[f@x==Sum[D[f@x,{x,k}],{k,n}],f@x,x]//.{x-&gt;0,Plus-&gt;Times,_@x_:&gt;x}//Last
Nest[(#[[0]]+1)@@ConstantArray[#,#[[0]]]&amp;,1@0,n]/.Except[0,_Integer]-&gt;Sequence//Length@*f
Cases[PowersRepresentations[n(1+n)(1+2n)/6,n,2],{1,x___/;DuplicateFreeQ@{x},n}:&gt;x*n][[1]]
n/(n-1)Times@@Module[{f},f[a_?NumberQ]:=Sow@a;Reap@FindInstance[0&lt;x&lt;n&amp;&amp;f@x==n-1,x,Integers]][[2,1]]</pre>
