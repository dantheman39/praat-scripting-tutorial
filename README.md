# praatscriptingtutorial.com

This is the source code for praatscriptingtutorial.com.

It's an old project so I'm not spending a ton of time making the site itself very pretty.
I _am_ using it as a bit of playground for learning more about deployment and cloud
infrastructure.

At time of writing, I'm migrating this content from a Django app I wrote in 2016,
to be a very simple static site served from s3. There are of course a lot of ways
this site (and the content) could be improved, but I'm favoring my own learning of
more devops-y things like serving a static site from s3, and having a repeatable
deployment process (getting some more terraform practice, for example). Since this is
an old project, I haven't yet added some niceties like linting, prettier, typescript,
etc., as these are things I already know how to do.

Before I cut over from my old Django deployment, I still have more to do (CNAME
migrations, SSL certs), but it's very possible I'll get
distracted and not follow through for a while ...

# If you're a linguist and want to suggest a change

You can open an issue on this repository, or open a pull request. Note that
you want to edit the .njk files, and not the .html files, which are generated
automatically.

## You want to build the site locally

This uses a couple of node scripts to take simple nunjucks templates and compile them
to html. I wrote a very janky express server that will serve the site locally for
quick development.

### Install Node

I was using the LTS 16.13.2, for the record, but hopefully that won't matter too much.

### Install yarn (or use npm instead)

### Install dependencies

Run `yarn`.

### Run the development server

`yarn start`

Go to `localhost:8000` and you can see the site.

See `package.json::scripts::start` for what the start command does. In short, it
will read the templates in `templates/`, and output them to `html/`.
The files in `html/` are not meant to be edited by hand. A very naïve `express`
server will serve the files, and `nodemon` watches for changes (though you'll have
to refresh your browser to view them).

See `package.json::scripts` for other available scripts.

## WIP use API gateway and lambda function to allow users to submit a contact form

This is just getting underway. So far I've been able to successfully build a hello-world
lambda function via a container, which is built and pushed to ECR with terraform.

A summary from the AWS docs for some dev tips:

### Run built image locally and send an event

```
cd send_contact_email
docker build -t send-contact-email .
docker run -p 9000:8080 -t send-contact-email

# in another terminal window
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
```

## Deploying

I deploy this to my AWS account using terraform. At time of writing no one except
me has credentials to push to my account.
