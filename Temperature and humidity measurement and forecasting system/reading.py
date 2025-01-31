import serial
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
import numpy as np
import time

# Configure the serial port
ser = serial.Serial('COM4', 9600, timeout=1)  # Replace 'COM4' with your port
time.sleep(2)  # Wait for the connection to initialize

# Initialize data lists
temperatures = []
humidities = []
timestamps = []

# Function to send data
def send_data(data):
    if ser.is_open:
        ser.write(data.encode())  # Convert the string to bytes and send
    else:
        print("Serial port is not open.")

# Function to predict temperature and humidity at a given future_time
def predict_values(timestamps, temperatures, humidities, future_time):
    if len(timestamps) < 3:
        return None, None, None, None  # Not enough data to fit a quadratic model

    # Fit quadratic models for temperature and humidity
    time_relative = np.array(timestamps) - timestamps[0]  # Normalize time
    temp_coeff = np.polyfit(time_relative, temperatures, 2)
    hum_coeff = np.polyfit(time_relative, humidities, 2)

    # Create models
    temp_model = np.poly1d(temp_coeff)
    hum_model = np.poly1d(hum_coeff)

    # Create a time grid from now to future_time (60 seconds ahead)
    current_time = timestamps[-1]
    pred_time_points = np.linspace(current_time, future_time, 20)  # 20 points over the next 60s
    pred_time_relative = pred_time_points - timestamps[0]         # shift by first timestamp

    # Evaluate models over the next 60 seconds
    predicted_temps = temp_model(pred_time_relative)
    predicted_hums = hum_model(pred_time_relative)

    return pred_time_points, predicted_temps, pred_time_points, predicted_hums

# Real-time plotting function
def update(frame):
    global temperatures, humidities, timestamps

    # Read data from the serial port
    if ser.in_waiting > 0:
        line = ser.readline().decode('utf-8').strip()  # Read and decode a line
        try:
            # Parse temperature and humidity
            temp, hum = map(float, line.split(','))
            current_time = time.time()
            temperatures.append(temp)
            humidities.append(hum)
            timestamps.append(current_time)

            # Keep only the last 50 data points
            if len(temperatures) > 50:
                temperatures.pop(0)
                humidities.pop(0)
                timestamps.pop(0)

            # Predict temperature/humidity 60 seconds from now
            future_time = current_time + 60
            pt, pt_val, ph, ph_val = predict_values(timestamps, temperatures, humidities, future_time)

            # If we got valid predictions
            if pt is not None and pt_val is not None:
                # Define an 'error' flag if needed
                error = 0
                if temp > 40 or hum > 33:
                    error = 1

                # We'll send the *last point* predicted (at future_time),
                # which is pt_val[-1], ph_val[-1].
                # Adjust as desired.
                prediction = f"{pt_val[-1]:.2f},{ph_val[-1]:.2f},{error}"
                send_data(prediction)

        except ValueError:
            pass  # Skip invalid data

    # Clear the plot
    plt.cla()

    # Plot the actual temperature and humidity
    plt.plot(timestamps, temperatures, label='Temperature (°C)', color='red')
    plt.plot(timestamps, humidities, label='Humidity (%)', color='blue')

    # If predictions exist, plot them as dashed lines
    # We re-call predict_values() here to retrieve the curves:
    if len(timestamps) >= 3:
        future_time = timestamps[-1] + 60
        pt, pt_val, ph, ph_val = predict_values(timestamps, temperatures, humidities, future_time)
        if pt is not None:
            # Predicted temperature in dashed red
            plt.plot(pt, pt_val, '--', color='red', label='Predicted Temperature')
            # Predicted humidity in dashed blue
            plt.plot(ph, ph_val, '--', color='blue', label='Predicted Humidity')

    # Formatting
    plt.xlabel('Time (s)')
    plt.ylabel('Value')
    plt.legend(loc='upper right')
    plt.title('Real-Time Temperature and Humidity (Measured & Predicted)')

# Create the figure and animation
fig = plt.figure()
ani = FuncAnimation(fig, update, interval=1000)  # Update every second
plt.show()

# Close the serial port when done
ser.close()
