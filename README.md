<h1>Design Patterns in Swift: Visitor</h1>
This repository is part of a series. For the full list check out <a href="https://shirazian.wordpress.com/2016/04/11/design-patterns-in-swift/">Design Patterns in Swift</a>

For a cheat-sheet of design patterns implemented in Swift check out <a href="https://github.com/ochococo/Design-Patterns-In-Swift"> Design Patterns implemented in Swift: A cheat-sheet</a>

<h3>The problem:</h3>
Our customers at <a href="http://www.yourmechanic.com">YourMechanic</a> can request quotes through our website or through their YourMechanic App. We send out an email and create an internal report when such quotes are requested. After the customer views the quote and decides to book it, that quote becomes an appointment. We send out an email and create an internal report when that happens as well. The content of the email and the report are dynamically generated from the information contained in the quote and the appointment.  We need a system that can provide us with an easy and straightforward way of composing these documents. Ideally we hope to achieve this without adding repeated report/email functionality to our already cluttered Quote and Appointment class.

<h3>The solution:</h3>

We define our quote and appointment class to accept visitor object. We then define these objects for emails and reports. When these objects are accepted into their respective visiting classes, they can generate the documents needed without having to be part of that class. The Visitor design pattern has always been a little counter intuitive to understand so we are going to approach this step by step, with as much details as possible.

<!--more-->

Link to the repo for the completed project: <a href="https://github.com/kingreza/Swift-Visitor">Swift - Visitor</a>

Let's begin:

We are going to start off by constructing our objects. This way we can get the easy stuff out of the way. First off we define our car object.

````swift
struct Car {
  let make: String
  let model: String
  let mileage: Int

  init(make: String, model: String, mileage: Int) {
    self.make = make
    self.model = model
    self.mileage = mileage
  }
}
````

For the sake brevity we are going to have our car have a make, model, and mileage property. We initialize these values through a standard initializer. Next we define our mechanic object.

````swift
struct Mechanic {
  let name: String

  init(name: String) {
    self.name = name
  }
}
````

Since the mechanic object will not be playing a major role in our Visitor example, we'll make it as simple as possible. It will be a simple struct that will have a name property. And finally we'll define a customer object that will have a name, email, zip code and address.

````swift
struct Customer {
  let name: String
  let email: String
  let zipcode: String
  let address: String

  init(name: String, email: String, zipcode: String, address: String) {
    self.name = name
    self.email = email
    self.zipcode = zipcode
    self.address = address
  }
}
````

These values are set through a standard initializer. It's been pretty straightforward so far. So here's where things get a little bit more interesting.

````swift
protocol Documentable {
  func accept (documenter: Documenter)
}
````


````swift
protocol Documenter {
  func process(documentable: Quote)
  func process(documentable: Appointment)
}
````

We define two protocols. In this example I've called them Documentable and Documenter. Another way they could have been named is Visitable and Visitor. The class that will implement the Documentable protocol will accept a Documenter visitor. This means the documentable class can delegate the task of generating the needed documents, be it an email or report to its visitor class the Documentor. The class that implements the Documenter, processes the Documentable objects. In our example we have two Documentable objects Quote and Appointment and two Documenter classes ReportDocumenter and EmailDocumenter.

The way we are planning to generate our emails and reports is to have two classes that implement the Documenter protocol: one for emails and another for reports. These Documenter class will have the functionality needed to generate the email and report without being part of the Quote and Appointment classes. By using visitor we can extend the functionalities of our two visitable classes through external visiting objects.

Before looking at these Documenter classes, let's look at our Quote and Appointment class:

````swift
class Quote: Documentable {

  var customer: Customer
  var price: Double
  var car: Car

  init(customer: Customer, price: Double, car: Car) {
    self.customer = customer
    self.price = price
    self.car = car
  }

  func accept (documenter: Documenter) {
    documenter.process(self)
  }
}
````

The Quote class implements the Documentable protocol, which requires it to have an 'accept' method, taking a Documenter as parameter. This function in turn calls the process method on the Documentor, passing itself. When that is called, any subsequent code that is executed will be part of the visitor class's process function. And since the Documentable class is passing itself to the process method of the Visitor class, the Visitor will have access to it outside the Documentable class code base.

Using this pattern you can now add functionalities and new behaviours without having to add anything to the visitable class. Let's come back to this idea once we have everything in place.

````swift
class Appointment: Documentable {

  var customer: Customer
  var mechanic: Mechanic
  var price: Double
  var date: NSDate

  init(customer: Customer, mechanic: Mechanic, price: Double, date: NSDate) {
    self.customer = customer
    self.mechanic = mechanic
    self.price = price
    self.date = date
  }

  func accept (documenter: Documenter) {
    documenter.process(self)
  }
}

````

We do the same thing with our Appointment class. It implements Documentable and like the Quote class, it calls the process method in its Documenter (visitor) object when a Documenter is accepted by it.

Before building our Documenter classes let's build our Email and Report classes. These are the object that our Documenter (visitor) classes will be constructing.

````swift
struct Email {
  let from: String
  let to: String
  let subject: String
  var body: String

  init(from: String = "hi@example.com", to: String, subject: String = "", body: String = "" ) {
    self.from = from
    self.to = to
    self.subject = subject
    self.body = body
  }

  func output() {
    print("From: \(self.from)")
    print("To: \(self.to)")
    print("Subject: \(self.subject)")
    print("Body: \(body)")
  }
}

struct Report {

  let reportType: ReportType
  let title: String
  let content: String

  init(reportType: ReportType, title: String, content: String) {
    self.reportType = reportType
    self.title = title
    self.content = content
  }

  func output() {
    print("Report: \(self.title)")
    print("Content: \(self.content)")
    print("************************\n")
  }
}

enum ReportType: Int {
  case Quote = 0, Appointment
}

````

There is nothing substantially interesting about these classes. The Email struct holds properties (to, from, subject, etc) that you expect to see in an Email object. The Report struct contains similar objects intended to simulate some arbitrary custom report in our internal system. I have added a simple output function for both of these classes that prints their content to the console.

Now let's see how our Documenters (visitor) classes build these objects.

````swift
class EmailDocumenter: Documenter {
  func process(documentable: Quote) {
    var content = "Hello \(documentable.customer.name) \n"
    content += "We have a quote for your \(documentable.car.make) \(documentable.car.model) \n"
    content += "For the services you have requested in \(documentable.customer.address) \n"
    content += "We have generated a quote priced at \(documentable.price) \n"
    let email = Email(to: documentable.customer.email,
                      subject: "Here is a quote for your \(documentable.car.make)",
                      body: content)

    email.output()
  }

  func process(documentable: Appointment) {
    var content = "Hello \(documentable.customer.name) \n"
    content += "We have booked your appointment for \(documentable.date.shortDateAndTime) \n"
    content += "make sure you have not driven your car for an hour before the appointment \n"
    content += "\(documentable.mechanic.name) will be more than happy " +
               "to answer any questions you might have \n"
    content += "You card will be billed for \(documentable.price) " +
                "once the appointment is finished \n"

    let email = Email(to: documentable.customer.email,
                      subject: "Your appointment is set for \(documentable.date.shortDateAndTime)",
                      body: content)

     email.output()

  }
}
````

Let's start with our EmailDocumenter which is the visitor responsible for building our emails. This class implements the Documenter protocol which forces it to implement two process methods, one accepting a Quote and another accepting an Appointment. In the process method for Quote, we take the Quote and use its content to construct an Email. This email ends up being what we send to the customer to inform them about their quote.

The second process function takes an Appointment as a parameter. And naturally builds an Email related to the appointment booked by the customer. To double check and make sure our emails are being constructed correctly we call the output function after they are generated. This will print out their content to the console. 

This class is responsible for building our emails for both Quote and Appointments. As you can see none of this code is in our Quote or Appointment classes. The functionality to generate emails has been separated out of those objects and housed in one central place.

This is ofcourse possible because our Quote and Appointment classes accept Documentors (visitors). Using this we can keep extending new functionalities without mucking around the classes themselves. So let's keep going. We still have a report to build.

````swift
class ReportDocumenter: Documenter {
  func process(documentable: Quote) {
    var content = "Quote for \(documentable.car.make) \(documentable.car.model) was generated \n"
    content += "Customer:\t \(documentable.customer.name) \n"
    content += "Address:\t \(documentable.customer.address) \n"
    content += "Quoted Price:\t \(documentable.price)"

    let report = Report(reportType: .Quote,
                        title: "Quote Generation Report for \(documentable.customer.name)",
                        content: content)

    report.output()
  }
  func process(documentable: Appointment) {
    var content = "Appointment for \(documentable.customer.name) was generated\n"
    content += "Customer:\t \(documentable.customer.name)\n"
    content += "Mechanic:\t \(documentable.mechanic.name)\n"
    content += "Time:\t \(documentable.date.shortDateAndTime)"
    content += "Price:\t \(documentable.price)"

    let report = Report(reportType: .Appointment,
                        title: "Appointment Generation Report for \(documentable.customer.name)",
                        content: content)

    report.output()

  }
}
````

Our ReportDocumenter class (another visitor), much like our EmailDocumenter class implements the Documenter protocol. And like EmailDocumenter, it has two process methods, one taking a Quote and another taking an Appointment. The code within the process methods simply takes the objects passed and uses its properties to build the needed report.

Another benefit of using the Visitor pattern is the fact that you can group similar functionalities together. In our example, the email generation for both Quote and Appointment is in one place and the report generation is in another. Since these two processes are not really related to the Quote or the Appointment or each other, this makes sense.

Now that we have everything in place lets see them in action.

````swift

var joe = Mechanic(name: "Joe Stevenson")
var mike = Mechanic (name: "Mike Dundee")

var reza = Customer(name: "Reza Shirazian",
                    email: "reza@example.com",
                    zipcode: "94043",
                    address: "N Rengstorff ave")

var lyanne = Customer(name: "Lyanne Borne",
                      email: "jb_hhm@example.com",
                      zipcode: "37110",
                      address: "E Main St McMinnvile TN")

var sam = Customer(name: "Sam Lee",
                   email: "lee.sam.3oo@example.com",
                   zipcode: "95060",
                   address: "Pacific Ave, Santa Cruz")

var quote1 = Quote(customer: reza,
                   price: 55.00,
                   car: Car(make: "Ford", model: "Mustang", mileage: 9500))

var quote2 = Quote(customer: lyanne,
                   price: 463.25,
                   car: Car(make: "Chevrolet", model: "Silverado",
                   mileage: 15200))

var quote3 = Quote(customer: sam,
                   price: 1155.00,
                   car: Car(make: "Honda", model: "Civic",
                   mileage: 78000))

var appointment1 = Appointment(customer: reza,
                               mechanic: joe,
                               price: 455.88,
                               date: NSDate.generateDateFromArray([2016, 5, 12, 14, 30, 00])!)

var appointment2 = Appointment(customer: sam,
                               mechanic: mike,
                               price: 554.00,
                               date: NSDate.generateDateFromArray([2016, 5, 23, 20, 00, 00])!)

````

We start be defining our mechanics, customers, quotes and appointments. I used some extensions on NSDate for easy date time creation and formatting. I will include the code for that at end of this article since they're not really related to the visitor design pattern. You can find the repo for the complete solution here: <a href="https://github.com/kingreza/Swift-Visitor">Design Patterns in Swift: Visitor</a>

Once our basic objects are setup, we'll put our quotes and appointments into an array, instantiate our EmailDocumenter and ReportDocumenter and iterate through each quote and appointment, having each accept our Documenter:

````swift
var quotes = [quote1, quote2, quote3]
var appointments = [appointment1, appointment2]

var emailDocumenter = EmailDocumenter()

var reportDocumenter = ReportDocumenter()

for quote in quotes {
  quote.accept(emailDocumenter)
  quote.accept(reportDocumenter)
}

for appointment in appointments {
  appointment.accept(emailDocumenter)
  appointment.accept(reportDocumenter)
}
````

When our Documenter is accepted by a Quote or an Appointment the process method for each Documenter is called, then depending on the type of the object visited, (Quote or Appointment) the correct process method in the Documenter is executed. I suggest putting breakpoints on the accept calls for the Quote or Appointment objects and stepping through the code so you can easily visualise the flow of execution.

With this setup, our main execution results in the following output:

````
From: hi@yourmechanic.com
To: reza@example.com
Subject: Here is a quote for your Ford
Body: Hello Reza Shirazian 
We have a quote for your Ford Mustang 
For the services you have requested in N Rengstorff ave 
We have generated a quote priced at 55.0 

Report: Quote Generation Report for Reza Shirazian
Content: Quote for Ford Mustang was generated 
Customer:	 Reza Shirazian 
Address:	 N Rengstorff ave 
Quoted Price:	 55.0
************************

From: hi@yourmechanic.com
To: jb_hhm@example.com
Subject: Here is a quote for your Chevrolet
Body: Hello Lyanne Borne 
We have a quote for your Chevrolet Silverado 
For the services you have requested in E Main St McMinnvile TN 
We have generated a quote priced at 463.25 

Report: Quote Generation Report for Lyanne Borne
Content: Quote for Chevrolet Silverado was generated 
Customer:	 Lyanne Borne 
Address:	 E Main St McMinnvile TN 
Quoted Price:	 463.25
************************

From: hi@yourmechanic.com
To: lee.sam.3oo@example.com
Subject: Here is a quote for your Honda
Body: Hello Sam Lee 
We have a quote for your Honda Civic 
For the services you have requested in Pacific Ave, Santa Cruz 
We have generated a quote priced at 1155.0 

Report: Quote Generation Report for Sam Lee
Content: Quote for Honda Civic was generated 
Customer:	 Sam Lee 
Address:	 Pacific Ave, Santa Cruz 
Quoted Price:	 1155.0
************************

From: hi@yourmechanic.com
To: reza@example.com
Subject: Your appointment is set for 12/5/2016, 14:30
Body: Hello Reza Shirazian 
We have booked your appointment for 12/5/2016, 14:30 
make sure you have not driven your car for an hour before the appointment 
Joe Stevenson will be more than happy to answer any questions you might have 
You card will be billed for 455.88 once the appointment is finished 

Report: Appointment Generation Report for Reza Shirazian
Content: Appointment for Reza Shirazian was generated
Customer:	 Reza Shirazian
Mechanic:	 Joe Stevenson
Time:	 12/5/2016, 14:30Price:	 455.88
************************

From: hi@yourmechanic.com
To: lee.sam.3oo@example.com
Subject: Your appointment is set for 23/5/2016, 20:00
Body: Hello Sam Lee 
We have booked your appointment for 23/5/2016, 20:00 
make sure you have not driven your car for an hour before the appointment 
Mike Dundee will be more than happy to answer any questions you might have 
You card will be billed for 554.0 once the appointment is finished 

Report: Appointment Generation Report for Sam Lee
Content: Appointment for Sam Lee was generated
Customer:	 Sam Lee
Mechanic:	 Mike Dundee
Time:	 23/5/2016, 20:00Price:	 554.0
************************

Program ended with exit code: 0
````

As you can see for each Quote we have generated an Email and a Report, and we have done the same for each Appointment.

Congratulations you have just implemented the Visitor Design Pattern to solve a nontrivial problem.

The repo for the complete project can be found here: <a href="https://github.com/kingreza/Swift-Visitor">Swift - Visitor.</a>

Download a copy of it and play around with it. See if you can find ways to improve its design, Add more complex functionalities. Here are some suggestions on how to expand or improve on the project:
<ul>
 	<li>Define more documentable objects within the project and extend our documenters to visit and process their data</li>
 	<li>Assume we want to build a receipt for every appointment. How would you extend our current visitor pattern to accommodate this?</li>
</ul>
