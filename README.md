<h1>Design Patterns in Swift: Visitor</h1>
This repository is part of a series. For the full list check out <a href="https://shirazian.wordpress.com/2016/04/11/design-patterns-in-swift/">Design Patterns in Swift</a>

<h3>The problem:</h3>
When a quote is requested or an appointment is booked we send out an email to the customer, and build an internal report for the quote and the appointment. The content of the email and report are dependant on the customer's address, their car make model, price and the mechanic selected for the service. We need a system that can provide us with an easy and straightforward way of composing these documents. Ideally we hope to achieve this without adding the report/email functionality to our already cluttered Quote and Appointment class.

<h3>The solution:</h3>

Link to the repo for the completed project: <a href="https://github.com/kingreza/Swift-Visitor"> Swift - Visitor </a>

