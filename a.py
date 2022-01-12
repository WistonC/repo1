largest = None
smallest = None
nums = list()
def numCheck(v):
    try:
        return int(v)
    except ValueError:
        print ("Invalid input")
        return "error"

while True:
    num = input("Enter a number: ")    
    if num == "done":
        break
    if numCheck(num) == "error":
        continue
    else:
        nums.append(numCheck(num))

smallest=largest=nums[0]
for n in nums:
    if n<smallest:
        smallest=n
    if n>largest:
        largest=n

print("Maximum is ", largest)
print("Minimum is ", smallest)
