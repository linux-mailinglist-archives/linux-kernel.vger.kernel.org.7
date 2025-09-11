Return-Path: <linux-kernel+bounces-811973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A260B5311E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBDF97BF303
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F6232A806;
	Thu, 11 Sep 2025 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIjki2mz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDAF32A801;
	Thu, 11 Sep 2025 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590683; cv=none; b=lcLZKtNRDybHj4kfRnw9dy7T/wlChLatg14vLWGKaZErFp/+XfGG1X4h8+M9IBdLFvtkxnKkISsY0cSSNPdXE5MfEyUrsLCJ6Si5fhoxoYFamDHRZZxb8Ag68J1LlnA0qWhrgg/Er+A4LV9NjOX9hOOvlYJ3EXz/8lrUUr7estM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590683; c=relaxed/simple;
	bh=AuNxrGnRVYvi5d8A4ikjl7xUWU5g2dvqqItFHrICQN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjTj1Ngh15wmBKOhIEbTQTYS2UtsOdi0ekynoO8j15nBe3vGydYXlsQ3b0S/XuKDjDqWwEReGNxXPkO7AyrywQEUyQyL6sxTcHhIxx26IK8M9HOjasIndGuS/4hRKO2iIox2tw90cYhb6feXrRbG0tbRx6OIM3W6sg9hgkCMcdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIjki2mz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B48FC4CEF0;
	Thu, 11 Sep 2025 11:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757590682;
	bh=AuNxrGnRVYvi5d8A4ikjl7xUWU5g2dvqqItFHrICQN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IIjki2mz3LZHae0uGnXSBzsAFo5Kybm4WzHOpD5/f39MC82FNU6wEg8ynlAAdfiIm
	 McEyDtykBSnaYXCv8tWQv93Ub4Hkn2MmoZb8GgiiYgzDCqbfZWXnrLx1Z3E7o1mc9F
	 wAib6A4KWn0Nco2AoF8IIHG16eSHjrTjUJCnbh1UbAXFnlBnjoy1LbuX9bPwsaGYwN
	 8HpwERfH//yKjH6/4aLWKm/E+69OGg8I7RoDjeP/vrJ8NzVbxJKyEGb1H/1brkUrU3
	 f7UYfqhOMMp8OGNqduLZeqoiLcAbPdZtR0lXkbd0FWa3i9TPjFRhmCSiV8Z8XtD51D
	 NIYgo4X2bEduw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uwfcl-00000007F3w-2JZu;
	Thu, 11 Sep 2025 13:37:59 +0200
Date: Thu, 11 Sep 2025 13:37:59 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a wrapper
 for sphinx-build
Message-ID: <fuv4p45tvjfdvwu2625s2l2kvcw64p4ohherlwyum3vmogmrfz@yb47nt66xgm6>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
 <e019f951190a732f9ac0b21bcda7e49af3bd5cbd.1756969623.git.mchehab+huawei@kernel.org>
 <e13837a0ac46dffe39c600d11fdf33f538bdc9c3@intel.com>
 <20250910145926.453f5441@foz.lan>
 <45888ca6c88071c754784495b4ef69460ea67b4f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45888ca6c88071c754784495b4ef69460ea67b4f@intel.com>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Thu, Sep 11, 2025 at 01:23:55PM +0300, Jani Nikula wrote:
> On Wed, 10 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > Em Wed, 10 Sep 2025 13:46:17 +0300
> > Jani Nikula <jani.nikula@linux.intel.com> escreveu:
> >
> >> On Thu, 04 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >> > There are too much magic inside docs Makefile to properly run
> >> > sphinx-build. Create an ancillary script that contains all
> >> > kernel-related sphinx-build call logic currently at Makefile.
> >> >
> >> > Such script is designed to work both as an standalone command
> >> > and as part of a Makefile. As such, it properly handles POSIX
> >> > jobserver used by GNU make.
> >> >
> >> > On a side note, there was a line number increase due to the
> >> > conversion:
> >> >
> >> >  Documentation/Makefile          |  131 +++----------
> >> >  tools/docs/sphinx-build-wrapper |  293 +++++++++++++++++++++++++++++++
> >> >  2 files changed, 323 insertions(+), 101 deletions(-)
> >> >
> >> > This is because some things are more verbosed on Python and because
> >> > it requires reading env vars from Makefile. Besides it, this script
> >> > has some extra features that don't exist at the Makefile:
> >> >
> >> > - It can be called directly from command line;
> >> > - It properly return PDF build errors.
> >> >
> >> > When running the script alone, it will only take handle sphinx-build
> >> > targets. On other words, it won't runn make rustdoc after building
> >> > htmlfiles, nor it will run the extra check scripts.  
> >> 
> >> I've always strongly believed we should aim to make it possible to build
> >> the documentation by running sphinx-build directly on the
> >> command-line. Not that it would be the common way to run it, but to not
> >> accumulate things in the Makefile that need to happen before or
> >> after. To promote handling the documentation build in Sphinx. To be able
> >> to debug issues and try new Sphinx versions without all the hacks.
> >
> > That would be the better, but, unfortunately, this is not possible, for 
> > several reasons:
> >
> > 1. SPHINXDIRS. It needs a lot of magic to work, both before running
> >    sphinx-build and after (inside conf.py);
> 
> Makes you wonder if that's the right solution to the original
> problem. It was added as a kind of hack, and it stuck.

The problem is, IMHO, due to the lack of flexibility of sphinx-build:
It should have a way on it to do partial documentation builds.

On our specific case, given that building docs takes so much time,
SPHINXDIRS is needed, as it allows to quickly check how a change is
output.

I use it a lot at devel time.

Also, media documentation builds depend on it:

    https://linuxtv.org/downloads/v4l-dvb-apis-new/

And probably other subsystems do the same, confining docs into
a subsystem-specific document.

> 
> > 2. Several extensions require kernel-specific environment variables to
> >    work. Calling sphinx-build directly breaks them;
> 
> The extensions shouldn't be using environment variables for
> configuration anyway. Add config options and set them in conf.py like
> everything else?

Agreed, but that's a separate problem, and should be addressed outside
this path changeset.

This one give one step on such direction by passing some parameters
via -D instead of env, but still conf.py and scripts are handling
them on a very particular way.

> > 3. Sphinx itself doesn't build several targets alone. Instead, they create
> >    a Makefile, and an extra step is needed to finish the build. That's 
> >    the case for pdf and texinfo, for instance;
> 
> That's not true for the Makefile currently generated by
> sphinx-quickstart. Granted, I haven't used Sphinx much for pdf output.

At the beginning, we were relying on the auto-generated pdf makefiles
only, but this had several issues (I can't recall them anymore). So,
we ended to a more complex proccess.

Yet, still broken, as, no matter if using sphinx quickstart way
or not, one needs to run (directly or indirectly) the produced
Makefile inside Documentation/output/.../latex to generate files,
and it will still always return non-zero, even if all PDFs are
built.

The real fix for it is outside our hands: someone needs to change
the way PDF is produced with a proper PDF builder instead of latex
and integrate at Sphinx tree.

There are some OOT docutils and/or sphinx pdf builders. We tried for
a while rst2pdf, but never worked for the Kernel source.

> 
> > 4. Man pages generation. Sphinx support to generate it is very poor;
> 
> In what way?

Have you ever tried to use it?

    "This builder produces manual pages in the groff format. 
     You have to specify which documents are to be included in 
     which manual pages via the man_pages configuration value."
    (https://www.sphinx-doc.org/en/master/usage/builders/index.html#sphinx.builders.manpage.ManualPageBuilder)

I tried when we were migrating to Sphinx. In summary:
    - Each man page requires an entry on a list;

        man_pages = [
            ('man/func', 'func', 'Func Documentation', [authors], 1),
            ...
        ]

    - Each man page requires a .rst file;
    - Each man page .rst file requires an specific format, like this:

        func(9)
        =======

        NAME
        ----
        func - ...

        SYNOPSIS
        --------
...

        DESCRIPTION
        -----------
...

      E.g. it is basically a troff source "converted" to .rst.

> > 5. Rust integration adds more complexity to the table;
> >
> > I'm not seeing sphinx-build supporting the above needs anytime soon,
> > and, even if we push our needs to Sphinx and it gets accepted there,
> > we'll still need to wait for quite a while until LTS distros merge
> > them.
> 
> I'm not suggesting to add anything to Sphinx upstream.

Without Sphinx upstream changes, I can't see how we'll get rid of
sphinx-build pre/post processing.

> >> This patch moves a bunch of that logic into a Python wrapper, and I feel
> >> like it complicates matters. You can no longer rely on 'make V=1' to get
> >> the build commands, for instance.
> >
> > Quite the opposite. if you try using "make V=1", it won't show the
> > command line used to call sphinx-build anymore.
> >
> > This series restore it.
> >
> > See, if you build with this series with V=1, you will see exactly
> > what commands are used on the build:
> >
> > 	$ make V=1 htmldocs
> > 	...
> > 	python3 ./tools/docs/sphinx-build-wrapper htmldocs \
> > 	        --sphinxdirs="." --conf="conf.py" \
> >         	--builddir="Documentation/output" \
> > 	        --theme= --css= --paper=
> > 	python3 /new_devel/docs/sphinx_latest/bin/sphinx-build -j25 -b html -c /new_devel/docs/Documentation -d /new_devel/docs/Documentation/output/.doctrees -D kerneldoc_bin=scripts/kernel-doc.py -D version=6.17.0-rc1 -D release=6.17.0-rc1+ -D kerneldoc_srctree=. /new_devel/docs/Documentation /new_devel/docs/Documentation/output
> > 	...
> >
> >
> >
> >> Newer Sphinx versions have the -M option for "make mode". The Makefiles
> >> produced by sphinx-quickstart only have one build target:
> >> 
> >> # Catch-all target: route all unknown targets to Sphinx using the new
> >> # "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
> >
> > I didn't know about this, but from [1] it sounds it covers just two
> > targets: "latexpdf" and "info".
> 
> sphinx-build -M help gives a list of 24 targets.

Ok, but those are the extra ones. Btw, I'm almost sure we tried it for
latexpdf in the early days. Didn't work well. I guess the problem as
related to returned error codes that are always causing make pdfdocs
to return errors.
 
> > The most complex scenario is still not covered: SPHINXDIRS.
> >
> > [1] https://www.sphinx-doc.org/en/master/man/sphinx-build.html
> >
> >> %: Makefile
> >>         @$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
> >> 
> >> That's all.
> >
> > Try doing such change on your makefile. it will break:
> >
> > 	- SPHINXDIRS;
> > 	- V=1;
> > 	- rustdoc
> 
> I know it does. That's the problem.

The wrapper fixes it by handling the pre/post sphinx-build logic
at the right way.

See, this series doesn't change the need or the implementation logic
for pre/post sphinx-build steps(*). It just moves them to a wrapper,
while getting rid of all small hacky scripts that are needed to make
them work.

We can and should still pursue the goal of simplifying pre/post
steps.

(*) The only change is for PDF: after the series, the return code
    is now zero if all PDF files build, non-zero otherwise.

    This makes easier for humans and for CI to be sure that there 
    are nothing at the .rst files causing PDF builds to break.

> 
> > and will still be dependent on variables that are passed via
> > env from Kernel makefile. So, stil you can't run from command
> > line. Also, if you call sphinx-build from command line:
> >
> > 	$ sphinx-build -j25 -b html Documentation Documentation/output
> > 	...
> > 	      File "<frozen os>", line 717, in __getitem__
> > 	    KeyError: 'srctree'
> >
> > It won't work, as several parameters that are required by conf.py and by
> > Sphinx extensions would be missing (the most important one is srctree, but
> > there are others in the line too).
> >
> >> The proposed wrapper duplicates loads of code that's supposed to be
> >> handled by sphinx-build directly.
> >
> > Once we get the wrapper, we can work to simplify it, but still I
> > can't see how to get rid of it.
> 
> I just don't understand the mentality of first adding something complex,
> and then working to simplify it.

It doesn't make it more complex. Quite the opposite:

- it ports what we have as-is to a script;
- it drops hacky glues that were added over time on 4 different files
  to handle sphinxdirs, jobserver, parallelism, second build steps,
  man pages generation;
- it fixes the return code issue with pdf builds.

As all pre/post steps are now in a single place, it makes it easier to
maintain.

> Don't make it a Rube Goldberg machine in the first place.
> 
> >> Including the target/builder names.
> >
> > True, but this was a design decision taken lots of years ago: instead
> > of:
> > 	make html
> >
> > we're using:
> >
> > 	make htmldocs
> >
> > This series doesn't change that: either makefile or the script need
> > to tho the namespace conversion.
> 
> In the above Makefile snippet that conversion would be $(@:docs=)

The same could be done at python. Yet, I opted there to use a dict
mainly because:

- we're not consistent about where files will be stored:
  with sphinx-quickstart, html files goes into _build/html. On our
  build system, we dropped "/html";
- we have some specific rules about where the final PDF files will
  be stored;
- we need to map what builder is used, because of the second step.

So, instead of having code checking for those specifics, I opted to
place on a dict, as it makes clearer and easier to maintain.

> The clean Makefile way of checking for having Sphinx and the required
> versions of Python and dependencies etc. would be a .PHONY target that
> just checks, and doesn't do *anything* else. It shouldn't be part of the
> sphinx-build rules.
> 
> PHONY += check-versions
> check-versions:
> 	sphinx-pre-install --version-check
> 
> htmldocs: check-versions
> 	...
> 
> Or something like that.

The problem with that is that we shouldn't run sphinx-pre-install for
cleandocs or non-doc targets.

Anyway, this series doesn't touch sphinx-pre-install call. It is still
inside docs Makefile.

What we can do in the future is to convert sphinx-pre-install code into
a library and then call a check_versions() method from it at the wrapper
script, like:

    SphinxPreInstal().check_versions()     # or something equivalent

And then dropping it from the build system. Yet, this is out of the scope
of this series.
 
-- 
Thanks,
Mauro

