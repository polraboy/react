const express = require('express');
const cors = require('cors');
const mysql = require('mysql');

const app = express();
app.use(cors());

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'testskill_acg'
});

connection.connect((err) => {
  if (err) {
    console.error('Error connecting to the database: ' + err.stack);
    return;
  }
  console.log('Connected to the database');
});

const getCarsByView = (viewName) => {
  return new Promise((resolve, reject) => {
    const query = `SELECT * FROM ${viewName}`;
    connection.query(query, (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
};

app.get('/cars', (req, res) => {
  const query = `
    SELECT SerialNo, Brand, Model, Price
    FROM car
  `;

  connection.query(query, (error, results) => {
    if (error) {
      console.error('Error fetching data: ', error);
      res.status(500).json({ error: 'An error occurred while fetching data' });
      return;
    }
    res.json(results);
  });
});

app.get('/cars_view', async (req, res) => {
  try {
    const economicCars = await getCarsByView('economiccar');
    const expensiveCars = await getCarsByView('expensivecar');
    const luxuriousCars = await getCarsByView('luxuriouscar');

    res.json({
      economicCars,
      expensiveCars,
      luxuriousCars
    });
  } catch (error) {
    console.error('Error fetching data: ', error);
    res.status(500).json({ error: 'An error occurred while fetching data' });
  }
});
const updateCarData = (serialNo, updates) => {
  return new Promise((resolve, reject) => {
    // First, check if the car is in the ExpensiveCar view
    const checkQuery = 'SELECT * FROM expensivecar WHERE SerialNo = ?';
    connection.query(checkQuery, [serialNo], (checkError, checkResults) => {
      if (checkError) {
        reject(checkError);
        return;
      }

      const isExpensiveCar = checkResults.length > 0;

      // If it's an expensive car, ensure the new price is still > 1,000,000
      if (isExpensiveCar && updates.Price <= 1000000) {
        reject(new Error('Price must be greater than 1,000,000 for ExpensiveCar'));
        return;
      }

      // Proceed with the update
      const updateQuery = 'UPDATE car SET ? WHERE SerialNo = ?';
      connection.query(updateQuery, [updates, serialNo], (updateError, updateResults) => {
        if (updateError) {
          reject(updateError);
        } else {
          resolve(updateResults);
        }
      });
    });
  });
};

app.put('/update-car/:serialNo', async (req, res) => {
  const { serialNo } = req.params;
  const updates = req.body;

  try {
    await updateCarData(serialNo, updates);
    res.json({ message: 'Car data updated successfully' });
  } catch (error) {
    console.error('Error updating car data: ', error);
    if (error.message === 'Price must be greater than 1,000,000 for ExpensiveCar') {
      res.status(400).json({ error: error.message });
    } else {
      res.status(500).json({ error: 'An error occurred while updating car data' });
    }
  }
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});