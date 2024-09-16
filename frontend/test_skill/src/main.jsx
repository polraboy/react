import React, { useEffect, useState } from 'react';
import ReactDOM from 'react-dom/client';

function App() {
  const [allCars, setAllCars] = useState([]);
  const [carData, setCarData] = useState({ economicCars: [], expensiveCars: [], luxuriousCars: [] });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [updatingCar, setUpdatingCar] = useState(null);
  const [updateError, setUpdateError] = useState(null);

  useEffect(() => {
    console.log('Fetching data...');
    Promise.all([
      fetch('http://localhost:3000/cars').then(res => res.json()),
      fetch('http://localhost:3000/cars_view').then(res => res.json())
    ])
      .then(([allCarsData, categorizedCarsData]) => {
        console.log('Received all cars data:', allCarsData);
        console.log('Received categorized cars data:', categorizedCarsData);
        setAllCars(allCarsData);
        setCarData(categorizedCarsData);
        setLoading(false);
      })
      .catch((error) => {
        console.error('Fetch error:', error);
        setError(error.message);
        setLoading(false);
      });
  }, []);

  const handleUpdate = async (car) => {
    setUpdatingCar(car);
  };

  const submitUpdate = async (e) => {
    e.preventDefault();
    setUpdateError(null);
    const updates = {
      Brand: e.target.brand.value,
      Model: e.target.model.value,
      Price: parseFloat(e.target.price.value)
    };

    try {
      const response = await fetch(`http://localhost:3000/update-car/${updatingCar.SerialNo}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(updates),
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || 'Failed to update car data');
      }

      // Refresh the data after update
      const [allCarsData, categorizedCarsData] = await Promise.all([
        fetch('http://localhost:3000/cars').then(res => res.json()),
        fetch('http://localhost:3000/cars_view').then(res => res.json())
      ]);

      setAllCars(allCarsData);
      setCarData(categorizedCarsData);
      setUpdatingCar(null);
    } catch (error) {
      console.error('Error updating car data:', error);
      // Handle error (e.g., show an error message to the user)
    }
  };

  if (loading) return <div style={styles.message}>Loading...</div>;
  if (error) return <div style={styles.error}>Error: {error}</div>;

  const CarTable = ({ cars, title }) => (
    <div>
      <h2 style={styles.subtitle}>{title}</h2>
      {cars.length === 0 ? (
        <p>No cars in this category.</p>
      ) : (
        <table style={styles.table}>
          <thead>
            <tr>
              <th style={styles.th}>Serial No</th>
              <th style={styles.th}>Brand</th>
              <th style={styles.th}>Model</th>
              <th style={styles.th}>Price (THB)</th>
              <th style={styles.th}>Action</th>
            </tr>
          </thead>
          <tbody>
            {cars.map((car) => (
              <tr key={car.SerialNo}>
                <td style={styles.td}>{car.SerialNo}</td>
                <td style={styles.td}>{car.Brand}</td>
                <td style={styles.td}>{car.Model}</td>
                <td style={styles.td}>{car.Price ? car.Price.toLocaleString() : 'N/A'}</td>
                <td style={styles.td}>
                  {car.SerialNo === '15220494' && (
                    <button onClick={() => handleUpdate(car)}>Update</button>
                  )}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );

  return (
    <div style={styles.container}>
      <h1 style={styles.title}>Car Information</h1>
      {updatingCar && (
        <div style={styles.updateForm}>
          <h3>Update Car: {updatingCar.SerialNo}</h3>
          {updateError && <div style={styles.error}>{updateError}</div>}
          <form onSubmit={submitUpdate}>
            <input name="brand" defaultValue={updatingCar.Brand} required />
            <input name="model" defaultValue={updatingCar.Model} required />
            <input name="price" type="number" defaultValue={updatingCar.Price} required />
            <button type="submit">Submit Update</button>
            <button type="button" onClick={() => {
              setUpdatingCar(null);
              setUpdateError(null);
            }}>Cancel</button>
          </form>
        </div>
      )}
      <CarTable cars={allCars} title="All Cars" />
      <CarTable cars={carData.economicCars} title="Economic Cars (≤ 1 million THB)" />
      <CarTable cars={carData.expensiveCars} title="Expensive Cars (> 1 million THB)" />
      <CarTable cars={carData.luxuriousCars} title="Luxurious Cars (> 5 million THB)" />
    </div>
  );
}

const styles = {
  error: {
    color: 'red',
    marginBottom: '10px',
  },
  container: {
    fontFamily: 'Arial, sans-serif',
    maxWidth: '800px',
    margin: '0 auto',
    padding: '20px',
  },
  title: {
    textAlign: 'center',
    color: '#333',
  },
  subtitle: {
    color: '#444',
    marginTop: '30px',
  },
  table: {
    width: '100%',
    borderCollapse: 'collapse',
    marginTop: '10px',
  },
  th: {
    backgroundColor: '#f2f2f2',
    color: '#333',
    fontWeight: 'bold',
    padding: '10px',
    textAlign: 'left',
    borderBottom: '2px solid #ddd',
  },
  td: {
    padding: '10px',
    borderBottom: '1px solid #ddd',
  },
  error: {
    color: 'red',
    textAlign: 'center',
    marginTop: '20px',
  },
  message: {
    textAlign: 'center',
    marginTop: '20px',
  },
  updateForm: {
    marginBottom: '20px',
    padding: '10px',
    border: '1px solid #ddd',
    borderRadius: '5px',
  },
};

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(<App />);