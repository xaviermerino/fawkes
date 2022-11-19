export MODE="high"
export BATCH=40

for directory in "/home/ubuntu/pubfig83/"*;
do
  echo $directory
  python "/home/ubuntu/fawkes/fawkes/protection.py" -d "$directory" --mode $MODE --batch-size $BATCH
  echo "Directory ${directory} was processed!"
  echo
done

echo "Done processing all!"
