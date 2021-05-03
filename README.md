# Pewlett_Hackard_Analysis

## Purpose of the Project
The purpose of our project is to determine the number of retiring employees by title and identify which employees are eligible to participate in the mentorship program. Our retiring employees by title information will show the titles of all employees born between January, 1 1952 and December, 31 1955. First we created a query that retrieved the employees information, such as employee number, first name, and last name from the employees database table. We then retrieve the title, from date, and to date information from the titles database table in our Pewlett Hackard query. We joined both of these table under the shared primary key, Employee Number, and filtered the data by birth date and put the information into a new table. For the next two parts of deliverable 1 we created a unique titles table to find the first occurance of the employee number in our new table by using the DISTINCT ON function and for the last part of the deliverable we did ORDER BY COUNT to show us the total number of each title from our unique titles table that we created. The second deliverable, we wrote a query that retrieved columns from our employees and department employee table, filtered data on current employees born in 1965 then ordered the table by employee number.

## The Results
Upon examination of the Retirement Titles Table, of the 510,000, there are 90,398 Titles that are within retirement range, or around 19.3% of the company.

![Screen Shot 2021-05-02 at 20 50 33](https://user-images.githubusercontent.com/79731109/116835423-161f8b00-ab88-11eb-8cb9-97b45e89fcb1.png)

After looking at the retirement table, we look at possible employees who are eligible to take part in the mentorship program. There are 1549 out of 510,000 employees that are eligible to take aprt in the mentorship program, or around 0.3% of the company.

## Conclusion
With about a fifth of the company eligible for retirement or take part in the mentorship program, Corporate has some time to look into filling roles as each employee heads towards to retirement. This will allow the company to be able to analyze any feedback from their senior employees and examine their tenure with the company.
