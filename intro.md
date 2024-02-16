# Introduction

LaTeX is an excellent program to typeset documents. Overleaf used to be an excellent
online editor for making collaborative LaTeX typeset documents. However, with
increased commercialization of Overleaf, it has become increasingly difficult
to create and collaborate on documents with Overleaf. Currently, the free version
of Overleaf only allows you 1 collaborator for a repository. Plus there have
been numerous restrictions placed on the compilation speed and time. If you're
considering compiling your PhD thesis in Overleaf, or creating a document that
contains a lot of heavy images, chances are that you won't really be able to
do it practically, without having to purchase (atleast) your standard plan 
costing $300 USD a year!

Alternatively, you could consider deploying Overleaf Community Edition using
Docker Compose. It provides a straightforward method for hosting and managing
collaborative LaTeX editing environments on your own server.
 The Overleaf Community Edition is free to use and offers a powerful platform
 for collaborative writing and editing of LaTeX documents,
 with the added advantage of self-hosting, giving you full control over your 
 documents and collaboration environment.


## What is Overleaf community edition?
Overleaf Community Edition is an open-source version of the popular online 
LaTeX editor, Overleaf. It allows you to create, edit, and collaborate on LaTeX
documents in real-time, making it ideal for academic and professional writing 
projects. With Overleaf Community Edition, you can host you own instance of the
platform, enabling greater customization and control over your LaTeX editing
environment.

### Advantages of self-hosting Overleaf Community Edition

1. **Control and Privacy**: Self-hosting Overleaf Community Edition allows you
to maintain control over your data and privacy. By hosting the platform on your
own server, you can ensure that sensitive documents and information remain
secure within your own infrastructure.

2. **Customization**: Self-hosting provides you with the flexibility to 
customize your Overleaf environment to meet your specific needs. You can
configure the platform according to your preferences, including user management,
access controls, and integration with other tools and services.

3. **Scalability**: Hosting Overleaf Community Edition on a dedicated server
enables you to scale your environment according to your requirements.
Whether collaborating on small projects or managing large-scale academic
initiatives, self-hosting allows for seamless scalability and resource allocation.

4. **Free Collaboration**: Most importantly, you don't have to pay a penny to
start collaborating on LaTeX documents with your colleagues!

5. **No compilation restrictions**: Since you're hosting your own application,
you won't be restricted by Overleaf online's restrictions on compilation time
and volume! Feel free to develop as many big projects as you want!

## How this guide is structured

Overleaf officially recommends their Overleaf toolkit for installaing the
community edition. However, I found their guide very difficult to implement.
Additionally, their documentation presumes a lot of knowledge about Linux and
Docker. Therefore, this guide has been developed to ease and faciliate the 
process of self-hosting Overleaf Community Edition.

## Requirements

The only thing you require is a Ubuntu/Linux server that can host Overleaf and
a willingness to get this done!

## How to contribute?

Since this guide is a work in progress, please feel free to help develop this
guide further with screenshots and more detailed step-by-step.
