package controller;

import model.WeatherBean;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.GetWeather;

import java.io.IOException;


@WebServlet(name = "OWServlet", value = "/OWServlet")
public class OWServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String city = request.getParameter("city");
        String country = request.getParameter("country");

        // Create wBean object with city and country as parameters
        WeatherBean wBean = new WeatherBean(city.toUpperCase(), country.toUpperCase());
        // Create weather object with wBean object as parameter
        GetWeather weather = new GetWeather(wBean);


//      check if acceptCookie exist
        Cookie[] cookies = request.getCookies();
        String acceptCookieValue = null;
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("acceptCookie")) {
                // acceptCookieValue stores the cookie value if the cookie acceptCookie exists
                acceptCookieValue = cookie.getValue();
                break;
            }
        }

        // if the value of acceptCookie is not null we create a new cookie named cityCookie
        // and if the cookie already exists with the name cityCookie we add new values to it

        if (acceptCookieValue != null && acceptCookieValue.equals("true")) {
            String cityCookieValue = wBean.getCity() + "/" + wBean.getCountry();
            Cookie cityCookie = new Cookie("cityCookie", cityCookieValue);
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cityCookie")) {
                    cityCookie.setValue(cookie.getValue() + "xem" + cityCookieValue);
                    break;
                }
            }
            response.addCookie(cityCookie);
        }

        // Set cloud and temperature
        wBean.setClouds(weather.getValueFromTag("clouds", "name"));
        wBean.setTemperature(Double.parseDouble(weather.getValueFromTag("temperature", "value")));

        // Splitting the date value so that only the date is shown.
        String[] date = weather.getValueFromTag("lastupdate", "value").split("T");
        wBean.setDate(date[0]);
        request.setAttribute("wBean", wBean);
        request.setAttribute("temperature", wBean.roundTemperature() + "°C");

        getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
