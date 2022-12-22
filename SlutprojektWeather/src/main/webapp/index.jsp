
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<link rel="stylesheet" href="./stylesheet/style.css">
<head>
    <title>JSP - Hello World</title>
</head>
<body>

<div class="weather-info-container">
    <h1 class="date">${wBean.getDate()}</h1>
    <p> ${wBean.getCity()} ${wBean.getCountry()} <br>${wBean.getClouds()} <br>${temperature}</p>
</div>

<div class="form-container">
<form action="<%=request.getContextPath()%>/OWServlet" method="get">
        <input type="text" name="city" id="city" placeholder="Enter city.."
               onfocus="this.placeholder =''" onblur="this.placeholder = 'Enter city..'"/>
        <input type="text" name="country" id="country" placeholder="Enter country.."
               onfocus="this.placeholder =''" onblur="this.placeholder = 'Enter country..'"/>
        <button type="submit">search</button>
</form>
</div>

<% // check if acceptCookie exist assign SearchhistoryCookieValue to the cookie.getValue();
    String searchHistoryCookieValue = null;
    if (request.getCookies() != null) {
        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("cityCookie")) {
                searchHistoryCookieValue = cookie.getValue();
                break;
            }
        }
    }
    // Split and print out the value of the cookie
    if (searchHistoryCookieValue != null) {
        String[] cityCountryValues = searchHistoryCookieValue.split("xem");
        for (int i = 0; i < cityCountryValues.length; i++) {
            String[] cityCountryPair = cityCountryValues[i].split("/");
            String city = cityCountryPair[0];
            String country = cityCountryPair[1];
            request.setAttribute("city" + i, city);
            request.setAttribute("country" + i, country);
            out.println("<div class='search-history-container'>");
            out.println("<p><a href='OWServlet?city=" + city + "&country=" + country + "'>" + city + "/" + country + "</a></p>");
            out.println("</div>");
        }
    }
%>

<div class="popup-content" id="popup-show">
    <form>
        <h1>Allow Cookies</h1>
        <p>This website uses cookies to offer you a better browsing experience.
            Find out more on &nbsp;<a href="https://www.youtube.com/watch?v=dQw4w9WgXcQ&ab_channel=RickAstley"> how
                we use cookies and how you can change your settings.</a>.</p>
        <img src="./media/cookie/ckmonster1.png" id="ckmonster">
        <button type="button" id="cookie-accept">ACCEPT</button>
        <button type="button" id="cookie-cancel">CANCEL</button>
    </form>
</div>

<script>
    const cookieBox = document.querySelector(".popup-content"),
        acceptBtn = cookieBox.querySelector(".popup-content #cookie-accept");
    cancelBtn = cookieBox.querySelector(".popup-content #cookie-cancel")

    // if user clicks accept create a cookie called acceptCookie with value true - Expires after 10min
    cancelBtn.onclick = ()=>{
        document.cookie = "acceptCookie=false; max-age=" +60*10;
        cookieBox.classList.add("hide");
    }
    acceptBtn.onclick = ()=>{
        document.cookie = "acceptCookie=true; max-age=" +60*10;
        cookieBox.classList.add("hide");
    }
    // if the cookie exists hide the cookie popup
    let checkCookie = document.cookie.indexOf("acceptCookie=true");
    let checkCookieFalse = document.cookie.indexOf("acceptCookie=false");
    if(checkCookie !== -1 || checkCookieFalse !== -1){
        cookieBox.classList.add("hide");
    }
</script>
</body>
</html>
