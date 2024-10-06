#!/bin/bash
apt update
apt install -y nginx

# Install the Azure CLI
apt install -y azure-cli

# Create a directory and an HTML file with content
mkdir -p /var/www/html/budget-manager

# Create a simple HTML file with the portfolio content and display the images
cat <<EOF > /var/www/html/budget-manager/index.html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Budget Manager - Easiest Way To Track Your Transactions!</title>
    <link rel="shortcut icon" href="./images/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="style.css"> <!-- Include CSS file -->
</head>

<body>


    <main>
        <div class="outer-wrap">
            <div class="inner-wrap">

                <!-- Heading section -->
                <section class="heading">
                    <p class="title">Budget Manager</p>
                    <p class="subtitle">Easiest Way To Track Your Transactions!</p>
                </section>

                <!-- Transaction control section -->
                <section class="transaction-control">
                    <div class="actions">
                        <h3>Add Transactions</h3>

                        <!-- Form to add transactions -->
                        <form class="add">
                            <input type="text" name="source" placeholder="Source" autocomplete="off">
                            <input type="number" name="amount" placeholder="Amount" autocomplete="off">
                            <input type="submit" value="Add Transaction">
                        </form>
                    </div>
                    <div class="stats">
                        <h3>Statistics</h3>
                        <!-- Statistics display -->
                        <p class="balance">
                            Balance: ₹<span id="balance"></span>
                        </p>
                        <p class="income">
                            Income: ₹<span id="income"></span>
                        </p>
                        <p class="expense">
                            Expense: ₹<span id="expense"></span>
                        </p>
                    </div>
                </section>

                <!-- Transaction history section -->
                <section class="transaction-history">
                    <h3>Transaction History</h3>
                    <div class="records">
                        <div class="income">
                            <h3>Income</h3>
                            <ul class="income-list">

                            </ul>
                        </div>
                        <div class="expense">
                            <h3>Expense</h3>
                            <ul class="expense-list">

                            </ul>

                        </div>
                    </div>
                </section>
            </div>
        </div>
    </main>
    <script src="./index.js"></script><!-- Include JavaScript file -->
</body>

</html>
EOF

cat <<EOF > /var/www/html/budget-manager/style.css
/* Importing external fonts and Bootstrap Icons library */
@import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
@import url("https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css");

/* Define global variables in root */
:root {
    --box-shadow: rgba(0, 0, 0, 0.16) 0px 1px 4px;
}

/* Resetting default styles and setting common styles for all elements */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-size: 16px;
    font-family: 'Poppins', sans-serif;
    text-decoration: none;
    list-style: none;
}


/* Heading styles */
h3 {
    text-align: center;
    margin-bottom: 15px;
    text-decoration: underline solid #393E46 3px;
    font-size: 24px;
}

/* Layout styles */
.outer-wrap {
    width: 100%;
    min-height: 100vh;
    background-color: #f5f7fa;
    padding: 30px;
}

.inner-wrap {
    max-width: 12000px;
    margin: auto;
}

/* Heading section styles */
.heading {
    margin: 30px auto;
    padding: 0px 20px;
}

.heading .title {
    font-size: 30px;
    color: #000000;
    font-weight: 500;
    text-align: center;
}

.heading .subtitle {
    font-size: 20px;
    color: #000000;
    font-weight: 300;
    text-align: center;
}

/* Transaction control section styles */
.transaction-control {
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
    gap: 10px;
    margin: 30px auto;
}

/* Action and stats container styles */
.actions,
.stats {

    flex-grow: 1;
    background-color: #FFFFFF;
    padding: 20px;
    box-shadow: var(--box-shadow);
    border-radius: 5px;
    margin: 0px 10px;
}

/* Add transaction form styles */
.actions .add {
    display: flex;
    flex-direction: column;
    margin: 10px;
}

.actions .add input {
    font-size: 18px;
    padding: 5px;
    margin: 10px;
}

.actions .add input[type="submit"] {
    padding: 7px 15px;
    border-radius: 5px;
    border: 0px;
    background-color: #2666CF;
    color: #FFFFFF;
    cursor: pointer;
    box-shadow: var(--box-shadow);
}


/* Statistics styles */
.stats p {
    background-color: #bed7ff;
    margin: 24px 10px;
    padding: 10px 20px;
    box-shadow: var(--box-shadow);
    font-size: 18px;
    border-radius: 2px;
    text-align: center;
}

.stats p.balance {
    background-color: #fff2dd92;
    border-right: 10px solid #f6c065;

}

.stats p.income {
    background-color: #e7fff1ad;
    border-right: 10px solid #16c77a;
}

.stats p.expense {
    background-color: #fff2dd92;
    border-right: 10px solid #eb596e;
}

.stats p span {
    font-size: 18px;
}

.transaction-history {
    margin: 40px 10px;
    background-color: #FFFFFF;
    border-radius: 10px;
    padding: 30px 0px;
    box-shadow: var(--box-shadow);
}

/* Records container styles */
.records {
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
    gap: 20px;
    margin: 20px;
}

.records div {
    flex-grow: 1;
    padding: 10px;
}

/* Record item styles */
.records li {
    display: flex;
    background-color: #FFFFFF;
    padding: 10px;
    margin: 12px 0px;
    min-width: 250px;
    box-shadow: var(--box-shadow);
}

/* Income record item styles */
.records .income li {
    border-left: 10px solid #2ecc71;
}

/* Expense record item styles */
.records .expense li {
    border-left: 10px solid #df5e5e;
}

.records li p:first-child {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
}

/* Record item content styles */
.records span {
    font-size: 20px;
}

.records span#time {
    color: #717171;
    font-size: 12px;
}

/* Delete icon styles */
.records i.delete {
    margin-left: 15px;
    color: #082032;
    cursor: pointer;
    font-size: 20px;
}

.records i.delete:hover {
    color: #b42b51;
}
EOF

cat <<EOF > /var/www/html/budget-manager/index.js
// Selecting DOM elements
const form = document.querySelector(".add");
const incomeList = document.querySelector("ul.income-list");
const expenseList = document.querySelector("ul.expense-list");
const balance = document.getElementById("balance");
const income = document.getElementById("income");
const expense = document.getElementById("expense");

// Retrieving transactions from local storage or initializing an empty array
let transactions = localStorage.getItem("transactions") !== null ? JSON.parse(localStorage.getItem("transactions")) : [];


// Function to update statistics displayed on the page
function updateStatistics() {
    // Calculating total income
    const updatedIncome = transactions
                                .filter(transaction => transaction.amount > 0)
                                .reduce((total, transaction) => total += transaction.amount, 0);

    console.log(updatedIncome);

    // Calculating total expense
    const updatedExpense = transactions
                                .filter(transaction => transaction.amount < 0)
                                .reduce((total, transaction) => total += Math.abs(transaction.amount), 0)

    // Calculating updated balance
    updatedBalance = updatedIncome - updatedExpense;
   
    // Updating DOM with updated statistics
    balance.textContent = updatedBalance;
    income.textContent = updatedIncome;
    expense.textContent = updatedExpense;
}

// Function to generate HTML template for transaction record
function generateTemplate(id, source, amount, time) {
    return `<li data-id="${id}">
    <p>
        <span>${source}</span>
        <span id="time">${time}</span>
        
    </p>
    ₹<span>${Math.abs(amount)}</span>
    
    <i class="bi bi-trash delete"></i>
</li>`
}

// Function to add transaction record to the DOM
function addTransactionDOM(id, source, amount, time) {

    if (amount >= 0) {
        incomeList.innerHTML += generateTemplate(id, source, amount, time);
    } else {
        expenseList.innerHTML += generateTemplate(id, source, amount, time);
    }
}

// Function to add a new transaction
function addTransaction(source, amount) {

    const time = new Date();
    const transaction = {
        id: Math.floor(Math.random() * 100000),
        source: source,
        amount: amount,
        time: `${time.toLocaleTimeString()} ${time.toLocaleDateString()}`
    };

    // Adding transaction to the array and updating local storage
    transactions.push(transaction);
    localStorage.setItem("transactions", JSON.stringify(transactions));

     // Adding transaction record to the DOM
    addTransactionDOM(transaction.id, source, amount, transaction.time)
}

// Event listener for form submission
form.addEventListener("submit", event => {
    event.preventDefault();
    if(form.source.value.trim() === "" || form.amount.value === ""){
        // Alerting user if input values are empty
        return alert ("Uh-oh! Hold on a moment! 🛑 Please add proper values to continue your financial journey with us! 💼💰");
          
    }

    // Adding transaction and updating statistics
    addTransaction(form.source.value.trim(), Number(form.amount.value))
    updateStatistics();
    form.reset();
})


// Function to display existing transactions on page load
function getTransaction() {
    transactions.forEach(transaction => {
        if (transaction.amount > 0) {
            incomeList.innerHTML += generateTemplate(transaction.id, transaction.source, transaction.amount, transaction.time);

        } else {
            expenseList.innerHTML += generateTemplate(transaction.id, transaction.source, transaction.amount, transaction.time);

        }
    });
}

// Function to delete a transaction
function deleteTransaction(id) {
    transactions = transactions.filter(transaction => {
        return transaction.id !== id;
    });

    // Updating local storage after deleting transaction
    localStorage.setItem("transactions", JSON.stringify(transactions));

}

// Event listeners for delete buttons in income and expense lists
incomeList.addEventListener("click", event => {
    if (event.target.classList.contains("delete")) {
        event.target.parentElement.remove();
        deleteTransaction(Number(event.target.parentElement.dataset.id)); 
        updateStatistics();
    }
});

expenseList.addEventListener("click", event => {
    if (event.target.classList.contains("delete")) {
        event.target.parentElement.remove();
        deleteTransaction(Number(event.target.parentElement.dataset.id));
        updateStatistics();
    }
});

// Function to initialize the page
function init(){
    updateStatistics();
    getTransaction();
}

init(); // Initializing the page
EOF

# Update the Nginx configuration file
cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80;
    server_name localhost;

    root /var/www/html/budget-manager;
    index index.html;

    location / {
        try_files /$uri /$uri/ =404;
    }

    location /budget-manager/ {
        alias /var/www/html/budget-manager/;
        index index.html;
    }
}
EOF

# Test the Nginx configuration
nginx -t

# Restart Nginx to apply changes
systemctl restart nginx
systemctl enable nginx