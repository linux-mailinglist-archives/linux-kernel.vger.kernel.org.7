Return-Path: <linux-kernel+bounces-782059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C42B31A76
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B74FA06D5D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5052F309DA1;
	Fri, 22 Aug 2025 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHQ8ESyY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9E2307AEF;
	Fri, 22 Aug 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870919; cv=none; b=ZnksKxdmC9ujUsGJHGWH9VRTRZeVjvHp0ARzzuYnLEYvwrhYywu08zq876m8E8/d9szSX/SbGWv3u4Np20rP4NZ6JEyxXl0lYpgQQDKV2pOSq6JGl4j7BtU2qiKsyyJCOcypxHpyYWbTGRhhg4ZeapMxkNwStMn53Nw0fKwgJkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870919; c=relaxed/simple;
	bh=hbDP41EtQ/FUPUSL8pbgPa2jVAAbBlM0004U5mA0n7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXvoDy7GCmCMcMfCFeYxKeRrTJHmmjLKhqJ8hhxSYgToKu7JYMWcfsCw3S0RXqdb/HiDt6l2e9BKtTWEsZiYPh4QICn5oo138stBIXpVqbrGPUiZ9LQP8ftSh1UUJxJj7vExXlhKn6kOtE70o6grJ+dtmi9xo/1OXAiAm803x9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHQ8ESyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D04C4CEED;
	Fri, 22 Aug 2025 13:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755870918;
	bh=hbDP41EtQ/FUPUSL8pbgPa2jVAAbBlM0004U5mA0n7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YHQ8ESyYL6LoahS5ivoKDB7vgSysNu5b4+OWH1ry+juiqSZUfXAPuCmE4Jr1TX/Xe
	 r3j/9TGds9LdGpA0DQ7+D83GRDMblI6fA5bixuSX9ZBL3NFesbWKqztag2eNXuLZCy
	 ZohfZNa9BiooCo5MLIIm5da0bZcI/0uFrx9P5ialMl9li4xDeAsdUr+KY3vTPGooud
	 Gy/Mp4d1aTwvBgwUMaVAyqc+7qYt1STx5BC85T/yKp82GxcZOSJHrgWs5Q94m6Mp1h
	 VjhX/KVXKsWiQlSDUrd6tn3iCIxLXZvlukdLEciXgoVEO0S1l6gRcYAVh40t3+ZGMr
	 Z1X30fnYDMCoA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1upSEe-0000000CBJt-2vWe;
	Fri, 22 Aug 2025 15:55:16 +0200
Date: Fri, 22 Aug 2025 15:55:16 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Linux Doc Mailing List <linux-doc@vger.kernel.org>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Trevor Gross <tmgross@umich.edu>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 04/11] scripts: sphinx-build-wrapper: add a wrapper for
 sphinx-build
Message-ID: <hjooonedrtoykg6qgg7kvat2ovtv6dtr3ulih6nowkds4teyuc@khetujrxwugv>
References: <cover.1755258303.git.mchehab+huawei@kernel.org>
 <88a95c7f6996cafb247d6706060173b17a46d570.1755258303.git.mchehab+huawei@kernel.org>
 <87plco5tb9.fsf@trenco.lwn.net>
 <20250822040645.75d5faf4@foz.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822040645.75d5faf4@foz.lan>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Fri, Aug 22, 2025 at 04:06:45AM +0200, Mauro Carvalho Chehab wrote:
> Em Thu, 21 Aug 2025 14:11:06 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
> 
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> > 
> > > There are too much magic inside docs Makefile to properly run
> > > sphinx-build. Create an ancillary script that contains all
> > > kernel-related sphinx-build call logic currently at Makefile.
> > >
> > > Such script is designed to work both as an standalone command
> > > and as part of a Makefile. As such, it properly handles POSIX
> > > jobserver used by GNU make.
> > >
> > > It should be noticed that, when running the script alone,
> > > it will only take care of sphinx-build and cleandocs target.
> > > As such:
> > >
> > > - it won't run "make rustdoc";
> > > - no extra checks.
> > >
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  .pylintrc                    |   2 +-
> > >  scripts/sphinx-build-wrapper | 627 +++++++++++++++++++++++++++++++++++
> > >  2 files changed, 628 insertions(+), 1 deletion(-)
> > >  create mode 100755 scripts/sphinx-build-wrapper  
> > 
> > As a whole I like the idea of this - I would rather be reading code in
> > Python than in makefilese.  But I have some overall notes...
> > 
> > I am a bit dismayed by the size of it; this is many times the amount of
> > code it allows us to remove from the makefile.  Perhaps there's nothing
> > to be done for that, but ...
> 
> True:
> 
>  7 files changed, 922 insertions(+), 200 deletions(-)
> 
> Yet, a lot of them are blank lines, comments, docstrings and 
> argparse. Also, there are some improvements on it, like the PDF
> build error handling logic (more below).
> 
> One of the things I wanted to do is precisely better describe
> what it does. The Makefile has lots of magic and complex macros
> that, even the ones that wrote it have headaches trying to understand
> after some time not looking on it.
> 
> Also, part of it will be dropped at the next patch series when
> we will get rid of userspace-api/media/Makefile:
> 
> 	$ git diff 182fa089db0b..parse_headers scripts/sphinx-build-wrapper|diffstat -p1 
> 	 scripts/sphinx-build-wrapper |   48 ---------------------
> 	 1 file changed, 48 deletions(-)

After sleeping on it, IMO the best would be if we change the order:
Let's place the series related to parse-headers.pl/kernel-images.py
first. 

Then, on this series, I can suppress the code that has support for
the media build Makefile (reducing those 48 lines), making the
patches cleaner.

I'll also change this series to place the new wrapper under
tools/docs, splitting part of it on a library. The final code
will be bigger due to the library, but it will become more
modular and with a cleaner implementation.

> 
> I guess there are some space to clean it up a little bit, for instance
> getting rid of most of the env vars and passing them as command
> line only. Yet, I opted to be a bit conservative at the cleanups at the
> env vars to reduce the risk of breaking something.
> 
> > Is there value in the SphinxBuilder class?  Just because you can create
> > classes in Python doesn't mean that you have to; I'm not sure why you
> > would create one here rather than just doing it all at the module level.
> 
> On Python, I prefer using classes, as:
> 
> 1. I don't like passing lots of arguments to functions;
> 2. Python doesn't have struct. The closest concept of struct in Python
>    is a data class;
> 3. Classes help to avoid global vars. In this specific case, the size of 
>    its data "struct" (e.g. class variables) is not small, as it has to
>    parse lots of environment vars, and several of those are used on
>    multiple places.
> 
> > Is the "search for a newer Python" code really going to be useful for
> > anybody? 
> 
> Well, I could have written it in shell script or Perl ;-)
> 
> Seriously, the rationale was not to search for a newer Python code, but
> instead, to have a place were it is easier to understand what's
> going on and adjust to our actual needs.
> 
> I actually started it because of the pdfdocs check: doing make
> pdfdocs currently will return an error code when building docs
> no matter what. Fixing it inside the Makefile would be doable, but
> complex and would likely require an script anyway (or a script-like
> code embedded on it).
> 
> Now, instead of adding yet another hack there, why not do it
> right?
> 
> > It seems like a lot of work (and code) to try to quietly patch
> > things up for somebody who has some sort of a strange setup.
> 
> My idea was not to support some strange setup, but to I had a few
> goals. Mainly:
> 
> 1. to have the simplest possible Makefile without loosing anything;
> 2. to be able to call the script directly, as it helps debugging;
> 3. to remove that ugly for sphinx-build call macro logic inside
>    Makefile, with is hard to understand and even harder to touch;
> 4. to fix a known bug with the current approach with regards
>    to PDF build: no matter if PDF build succeeded or not, it
>    always return an error code;
> 5. to have a summary of the PDF build. Even with latexmk, the
>    PDF build is a way too noisy, being hard to check what broke
>    and what succeeded.
> 6. to make easier to build PDFs in interactive mode (I added this
>    later at the development cycle).
> 
> -
> 
> For the future, if time permits, there are two possible improvements
> 
> a) I'd like to change the way SPHINXDIRS work. Right now, it is a very
>    dirty hack, that makes sphinx-build becalled several times (one for
>    each dir), and breaks cross-references.
> 
>    I'd like to be able to allow building multiple dirs at the
>   same time, with a proper index between them.
> 
> b) By having this in python, we can do other cleanups like:
> 
>    - instance convert sphinx-pre-install into a class, calling
>      it directly there;
>    - pick the logic inside conf.py that handles SPHINXDIRS and
>      latex documents.
> 
> In summary, the advantage is that it is a lot easier to fine tune
> the script in the proper way than to add more hacks to docs Makefile.
> 
> > Please, no "except Exception:"  (or the equivalent bare "except:").
> 
> Ok.
> 
> > That bit of locale tweaking shows up in enough places that it should
> > maybe go into a little helper module rather than being repeatedly
> > open-coded?
> 
> Do you mean this?
> 
>         # The sphinx-build tool has a bug: internally, it tries to set
>         # locale with locale.setlocale(locale.LC_ALL, ''). This causes a
>         # crash if language is not set. Detect and fix it.
>         try:
>             locale.setlocale(locale.LC_ALL, '')
>         except Exception:		# I'll replace it with locale.Error
>             self.env["LC_ALL"] = "C"
>             self.env["LANG"] = "C"
> 
> This was also added later, to fix a current Sphinx (or Python?) bug.
> 
> Try to run sphinx-build on a Debian-based or Gentoo distro without 
> setting any locale (which is the default after installing them):
> 
> 	# sphinx-build --help
> 	Traceback (most recent call last):
> 	  File "/usr/bin/sphinx-build", line 8, in <module>
> 	    sys.exit(main())
> 	             ~~~~^^
> 	  File "/usr/lib/python3/dist-packages/sphinx/cmd/build.py", line 546, in main
> 	    locale.setlocale(locale.LC_ALL, '')
> 	    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^
> 	  File "/usr/lib/python3.13/locale.py", line 615, in setlocale
> 	    return _setlocale(category, locale)
> 	locale.Error: unsupported locale setting
> 
> 	# LC_ALL=C sphinx-build --help
> 	usage: sphinx-build [OPTIONS] SOURCEDIR OUTPUTDIR [FILENAMES...]
> 	...
> 
> 
> Well, sphinx-build will crash even if called with "--help". Btw, 
> spinx-build is following Python recommendation of using '':
> 	https://docs.python.org/3/library/locale.html#locale.setlocale
> 
> Ok, we could drop that, but on the other hand it is just 5 LOC.
> (actually it can be 4 LOC, as self.env["LANG"] = "C" is not really needed 
> to avoid the crash).
> 
> One thing I'm in doubt is with regards to --venv command line argument.
> It could be dropped, or it could be auto-detected. The code is also
> small, and IMHO it could help for the ones using venv:
> 
>         # If venv parameter is specified, run Sphinx from venv
>         if venv:
>             bin_dir = os.path.join(venv, "bin")
>             if os.path.isfile(os.path.join(bin_dir, "activate")):
>                 # "activate" virtual env
>                 self.env["PATH"] = bin_dir + ":" + self.env["PATH"]
>                 self.env["VIRTUAL_ENV"] = venv
>                 if "PYTHONHOME" in self.env:
>                     del self.env["PYTHONHOME"]
>                 print(f"Setting venv to {venv}")
>             else:
>                 sys.exit(f"Venv {venv} not found.")
> 
> Btw, this is the kind of code that makes sense to be inside some
> library.
> 
> Thanks,
> Mauro

-- 
Thanks,
Mauro

