CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission

if [[ -f ./student-submission/ListExamples.java ]]
then
    echo "ListExamples.java is present"

else
    exit 
fi

mkdir testerDir 

cp ./student-submission/ListExamples.java testerDir

cp TestListExamples.java testerDir


if [[ -f ./testerDir/ListExamples.java ]]
then

    echo "ListExamples is in the Directory"

fi

if [[ -f ./testerDir/TestListExamples.java ]]
then

    echo "TestListExamples is in the Directory"

fi

cd ./testerDir

javac -cp ..:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar *.java > error-output.txt 2>&1

if [[ $? -ne 0 ]] 
then

    echo "Tester didn't compile properly, Check again"

    rm -rdf testerDir

    exit

fi

java -cp ..:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > output.txt

if [[ $? -ne 0 ]]
then

    grep "Failures: *" output.txt > grep-results.txt

    echo `cat grep-results.txt`

fi

rm -rdf testerDir

echo 'Finished cloning'

