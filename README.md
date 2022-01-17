# praatscriptingtutorial.com

This is the source code for praatscriptingtutorial.com.

It's an old project so I'm not spending a ton of time making this all very pretty.

At time of writing, I'm migrating this content from a Django app I wrote in 2016,
to be a very simple static site served from s3. There are of course a lot of ways
this site (and the content) could be improved, but I'm favoring my own learning
more devops-y things like serving a static site from s3, and having a repeatable
deployment process (getting some terraform practice, for example). Since this is
an old project, I haven't yet added some niceties like linting, prettier, typescript,
etc., as these are things I already know how to do.

Before I cut over from my old Django deployment, I still have more to do (CNAME
migrations, SSL certs), before I cut this over, but it's very possible I'll get
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

I was using the LTS 16.13.2.

### Install yarn

### Install dependencies

Run `yarn`.

### Run the development server

`yarn start`

Go to `localhost:8000` and you can see the site.

See `package.json::scripts::start` for what the start command does. In short, it
will read the templates in `templates/`, and output them to `html/`.
The files in `html/` are not meant to be edited by hand.

See `package.json::scripts` for other available scripts.

As you make changes, the `nodemon` package will rerun the dev script whenever you
save a relevant file.

## Deploying

To push changes to the website, hosted in AWS S3, run terraform.

You'll need AWS credentials for my account.

cd into the terraform folder.

`terraform init`
`terraform apply`