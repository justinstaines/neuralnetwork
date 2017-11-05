#! /bin/sh
input1=1
input2=1
target=0
e=2.718281828459045235360287471352
#weight1=0.8
weight1=( $(cut -d ',' -f1 neuralnetweights.csv ) )
weight2=( $(cut -d ',' -f2 neuralnetweights.csv ) )
weight3=( $(cut -d ',' -f3 neuralnetweights.csv ) )
weight4=( $(cut -d ',' -f4 neuralnetweights.csv ) )
weight5=( $(cut -d ',' -f5 neuralnetweights.csv ) )
weight6=( $(cut -d ',' -f6 neuralnetweights.csv ) )
weight7=( $(cut -d ',' -f7 neuralnetweights.csv ) )
weight8=( $(cut -d ',' -f8 neuralnetweights.csv ) )
weight9=( $(cut -d ',' -f9 neuralnetweights.csv ) )
#weight2=0.4
#weight3=0.3
#weight4=0.2
#weight5=0.9
#weight6=0.5
#weight7=0.3
#weight8=0.5
#weight9=0.9
#loop=0
#while [ $loop -le 100 ]; do
#((loop+=1))
hidden1=`echo "($weight1 * $input1) + ($input2 * $weight4)" | bc`
hidden2=`echo "($weight2 * $input1) + ($input2 * $weight5)" | bc`
hidden3=`echo "($weight3 * $input1) + ($input2 * $weight6)" | bc`
hiddensum1=`echo - | awk -v var1="$e" -v  var2="$hidden1" '{print (1/(1+(var1 ^ -var2)))}'`
hiddensum2=`echo - | awk -v var1="$e" -v  var2="$hidden2" '{print (1/(1+(var1 ^ -var2)))}'`
hiddensum3=`echo - | awk -v var1="$e" -v  var2="$hidden3" '{print (1/(1+(var1 ^ -var2)))}'`
#weight7=0.3
#weight8=0.5
#weight9=0.9
output1=`echo "($hiddensum1 * $weight7)" | bc`
output2=`echo "($hiddensum2 * $weight8)" | bc`
output3=`echo "($hiddensum3 * $weight9)" | bc`
outputsum=`echo "($output1 + $output2 + $output3)" | bc`
targetcalc=`echo - | awk -v var1="$e" -v  var2="$outputsum" '{print (1/(1+(var1 ^ -var2)))}'`
sumerror=`echo "($target - $targetcalc)" | bc`
echo "input1" $input1
echo "input2" $input2
echo "target" $target
echo "targetcalc" $targetcalc