package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.RoundingMode;

public class WeatherBean implements Serializable {

    private String city;

    private String country;

    private String clouds;

    private double temperature;

    private String date;

    public WeatherBean(String city, String country) {
        this.city = city;
        this.country = country;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public String getClouds() {
        return clouds;
    }

    public void setClouds(String clouds) {
        this.clouds = clouds;
    }

    public double getTemperature() {
        return temperature;
    }
    // Convert temperature from Kelvin to Celsius
    public void setTemperature(double temperature) {;
        this.temperature = temperature-272.15;
    }
    // remove decimals
    public double roundTemperature(){
        BigDecimal bd = new BigDecimal(temperature).setScale(2, RoundingMode.HALF_UP);
        double newTemperature = bd.doubleValue();
        return newTemperature;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }




}

