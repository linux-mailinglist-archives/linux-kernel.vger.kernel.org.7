Return-Path: <linux-kernel+bounces-816701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E315AB57754
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391D816D59E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5102FC011;
	Mon, 15 Sep 2025 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjCwXYbH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34A926E173;
	Mon, 15 Sep 2025 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933890; cv=none; b=S422ZKk1sUcUrkzlGG/YVUYWen3fAgq8W3iY/0uXhGS408twTs7ANLkSybznWK/FtgeEdflosi5NBwyEVLWnjfzEVbehJcz0ks9sBt+WU897KXtUSE1UvpVbsATHkOsb31YSsk5rfr0lBvryA6yoI1JnZAU9VuyRSRxztX5rxt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933890; c=relaxed/simple;
	bh=UMjiqQGGASpETzIQzNIVWDM+E7z66liCCjZ/iIlYQP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHKfn5u44ZFBMLDSzSYeIx/XlpjcZ8p59ii+6OmpcQ+GnJ9tB2xTDXvrM4KeA0BQeRPl8iE0SfdjX6UsuJmTs1O/TIN10AfwFA1SO48y/wBOc1S9FihKmbbNfQxW1sxmGHTEPkXFatsr4OJYy+yLPLK5U+LlyMfKQs47LPxGaco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjCwXYbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6ABC4CEF1;
	Mon, 15 Sep 2025 10:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757933890;
	bh=UMjiqQGGASpETzIQzNIVWDM+E7z66liCCjZ/iIlYQP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mjCwXYbHyg32bLezmVTYiM7e8AWhNhKhTEAxDAc2o3+Y7Dcxa4ahiaDUsFeeVqiWc
	 w/pa3B4t+JfLR9jL0VPDFMDRk7AdPcCGjIkTA8EmRdd6+7eayJ01UVoleef20/HcwG
	 mdMEOM9SP+LSNme/UxprK2xXOJKwxIvCZpc7M0Br6SjtAEMK/qvIFhZ0BMUPNhrTn9
	 MGpnoZHQS7IFAZCbkyCd+sjdiMV9+BTmc2U0k6Pr66mDllg9gRPVvHfB48mBB/C3ew
	 eOi9qUVFbFehISCbIom0bQHVhBCYMDCeEbppcf4Xo5clZuZGNtUzfLEceGTOLavkD2
	 brr8o7GFeqU+g==
Date: Mon, 15 Sep 2025 12:58:05 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: corbet@lwn.net, jani.nikula@linux.intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a
 wrapper for sphinx-build
Message-ID: <20250915125805.25b48d09@foz.lan>
In-Reply-To: <aa2aa8d2-f7f1-4f04-a9b0-f08160f9ea81@gmail.com>
References: <20250910153334.0b3e1440@foz.lan>
	<28c45f53-a3ff-428f-ba99-ebb09e0581d3@gmail.com>
	<20250912130420.6c14dbbd@foz.lan>
	<f3d142be-3980-4d4e-9d66-c03276694bf9@gmail.com>
	<6hhhn5go2yb7ecdrqtuti23i6pfgckqbdk5nhuhn2ijrhmvvmw@awswbm3tvmwp>
	<aa2aa8d2-f7f1-4f04-a9b0-f08160f9ea81@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 15 Sep 2025 17:27:17 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Fri, 12 Sep 2025 16:50:36 +0200, Mauro Carvalho Chehab wrote:
> > On Fri, Sep 12, 2025 at 11:03:43PM +0900, Akira Yokosawa wrote:  
> >> On Fri, 12 Sep 2025 13:04:20 +0200, Mauro Carvalho Chehab wrote:  
> [...]
> 
> >>> I saw it here on multiple distros including Fedora (which is the one
> >>> I use on my desktop). Media jenkins CI running on Debian always suffered
> >>> from such issues, up to the point I started ignoring pdf build results.
> >>>  
> >>
> >> So please provide exact steps for me to see such errors.  
> >
> > Sorry, but I don't have enough time to try reproducing it again
> > (plus, I'm ran out of disk space on my /var partition forcing me to
> > reclaim the space used by my test containers).  
> 
> There is no urgency on my side.  Please take your time.
> 
> >  
> >>
> >> I don't have any issues after strictly following the suggestions from
> >> sphinx-pre-install under Fedora.
> >>
> >> I even invoked [...]/output/latex/Makefile manually after running
> >> "make latexdocs" by:
> >>
> >>   - cd [...]/output/latex/
> >>   - make PDFLATEX="latexmk -xelatex" LATEXOPTS="-interaction=batchmode -no-shell-escape" -j6 -O all
> >>
> >> , and all the PDFs were built without any issues.
> >>
> >> Quite puzzling ...
> >>
> >> Or does your Fedora have some Noto CJK variable fonts installed?  
> >
> > On my main desktop, yes, that's the case: it currently has some
> > Noto CJK fonts installed. I wasn't aware about such issues
> > with Fedora until today, when I noticed your check script.
> >  
> 
> Good. That should be a step forward, I guess.
> 
> I know you have repeatedly said it is not the purpose of this series
> to fix those issues in your images, but I have an impression that it is
> closely related to testing sphinx-pre-install, and the objective of this
> series is to make the testing/debugging of sphinx-pre-install easier for
> you.

No, that's not the case. Yes, it helped me to test the script, but the
goal here is completely unrelated, and it actually solves a problem
I suffered a lot with CI jobs: I do want to know as soon as possible
when a patch to media breaks uAPI and/or kAPI books. I had a CI job
running to test such cases here:

	https://builder.linuxtv.org/view/Kernel/job/media.git_drivers_build/

and on other pipelines, but I had to disable and/or ignore PDF builds,
with ended culminating with that "|| exit" line on docs makefile, as
this was causing CI to always report errors, even when PDF was successfully
built.

For such purpose, having a reliable SUCCESS return code when the docs
are built is a must.

> But, at least for me, the behavior you want for "pdfdocs" is not
> ideal for regular testing of .rst and kernel-doc changes in kernel
> source side.  I want "make pdfdocs" to give up earlier rather than later.
> It should leave relevant info near the bottom of terminal log.

For me, the most important data is what documents broke between
two builds. That's why at the end I want to have the failed docs.

Yet, I guess we can have a solution that may be satisfying what
you want and what I want: only print success when V=1. When V=1,
it can just print the failed ones at the end.

> Now, here are my responses to your arguments:
> 
> > In any case, this changeset fix it on several ways:
> > 
> > - A failure while building one pdf doesn't prevent building other
> >   files. With make, it may stop before building them all (if we drop
> >   the "|| exit");  
> 
> Didn't you mean "(if we keep the "|| exit"); ???
> 
> If you drop the "|| exit", which will cause false-negatives.
> And you are going to test every PDFs at the final stage of pdfdocs
> to catch such false-positives.
> 
> Sounds like a plan.

No, it doesn't.

Dropping it causes false-positives. That's the root cause why we
had to add it in the first place. Try looking at latexmk and xelatex
man pages: there are no descriptions about what they're supposed
to return, and, on practical experiments, return code == 0 doesn't mean
that all PDF builds worked. It means something else.

Heh, looking at latexmk, besides the "explicit" codes it has, it seems
it just returns whatever xelatex returns.

Also, if you see, for instance:
	https://math.nist.gov/~BMiller/LaTeXML/manual/errorcodes/

Latex has 3 types of errors:
	Warnings
	Errors
	Fatals

Only "Fatals" are certain to cause PDF build failures. "Errors"
can be a lot of things and they usually are OK during Sphinx build,
as they're usually minor visual glitches.

I'm yet to find a document clearly describing what it returns
for each case, but I'm pretty sure trusting on xelatex return
code is the wrong thing to do: this never worked.

> > - It prints a summary reporting what PDF files were actually built,
> >   so it is easy for the developer to know what broke (and it is
> >   also easily parsed by a CI);
> > - The return code is zero only if all docs were built.  
> 
> I agree this is an improvement, but if we get rid of the loop construct
> in the Makefile, we can forget about said false-negatives, can't we? 

No. See above.

> How about something like the following approach?
> 
> Let's think of SPHINXDIRS="admin-guide core-api driver-api userspace-api"
> 
> In this case "make latexdocs" will generate
> 
>     output/admin-guide/latex/
>     output/core-api/latex/
>     output/driver-api/latex/
>     output/userspace-api/latex/
> 
> They will have identical boiler-plate files latex builder would emit,
> and subdir-specific files such as:
> 
>     output/admin-guide/latex/admin-guide.tex
>                              c3-isp.dot
>                              c3-isp.pdf
>                              c3-isp.svg
>                              conn-states-8.dot
>                              conn-states-8.pdf
>                              conn-states-8.svg
>                              disk-states-8.dot
>                              disk-states-8.pdf
>                              disk-states-8.svg
>                              ...
>     output/core-api/latex/core-api.tex
>     output/driver-api/latex/driver-api.tex
>                             DOT-1e98886fceca6e25a115532f5efebb44c09dc98b.dot
>                             DOT-1e98886fceca6e25a115532f5efebb44c09dc98b.pdf
>                             DOT-1e98886fceca6e25a115532f5efebb44c09dc98b.svg
>                             DOT-289c17ebc0291f90ccaf431961707504464a78d4.dot
>                             DOT-289c17ebc0291f90ccaf431961707504464a78d4.pdf
>                             DOT-289c17ebc0291f90ccaf431961707504464a78d4.svg
>                             ...
>     output/userspace-api/latex/userspace-api.tex
>                                DOT-1e98886fceca6e25a115532f5efebb44c09dc98b.dot
>                                DOT-1e98886fceca6e25a115532f5efebb44c09dc98b.pdf
>                                DOT-1e98886fceca6e25a115532f5efebb44c09dc98b.svg
>                                DOT-289c17ebc0291f90ccaf431961707504464a78d4.dot
>                                DOT-289c17ebc0291f90ccaf431961707504464a78d4.pdf
>                                DOT-289c17ebc0291f90ccaf431961707504464a78d4.svg
>                                ...
>                           
> 
> At a pre-processing stage of pdfdocs, you create output/latex/ and
> symlink subdir-specific files needed for latexmk/xelatex into there.
> (Copying them should work too.)
> 
>     output/latex/admin-guide.tex --> ../admin-guide/latex/
>                  c3-isp.pdf      --> ../admin-guide/latex/
>                  conn-states-8.pdf --> ../admin-guide/latex/
>                  disk-states-8.pdf --> ../admin-guide/latex/
>                  ...
>                  core-api.tex --> ../core-api/latex/
>                  driver-api.tex --> ../driver-api/latex/
>                  DOT-1e98886fceca6e25a115532f5efebb44c09dc98b.pdf --> ../driver-api/latex/
>                  DOT-289c17ebc0291f90ccaf431961707504464a78d4.pdf --> ../driver-api/latex/
>                  ...
>                  userspace-api.tex --> ../userspace-api/
>                  DOT-1e98886fceca6e25a115532f5efebb44c09dc98b.pdf --> ../userspace-api/latex/
>                  DOT-289c17ebc0291f90ccaf431961707504464a78d4.pdf --> ../userspace-api/latex/
>                  ...
> 
> The latexmk stage would now be identical to the SPHINXDIRS="." case,
> meaning it won't need the loop in the recipe.
> Furthermore, post-processing would be almost the same as the default
> case.

This won't work, as we may have "duplicated" non-identical names, like:

	SPHIHXDIRS="userspace-api/media Documentation/driver-api/media/"

both will produce media.tex files, with completely different contents.

> As a bonus, "make -j -O" will work as the same as full pdfdocs build.

This series doesn't break "make O=output_dir -j".

> If you are interested, I think I can prepare a PoC patch, probably
> after v6.18-rc1.
> 
> If your sphinx-build-wrapper's latexdocs stage can be adjusted so that
> said pre-processing of pdfdocs can be made unnecessary, that would be
> even better.

It can be adjusted to whatever we want, provided that we find a
solution that works fine. It is a lot easier to do such kind
of changes in Python than in Makefile. At the plus side, adding
documentation to each step of the build process is easier.

IMHO, long term solution is to change SPHINXDIRS into something
like:

	make O=doc_build SPHINXTITLE="Media docs" SPHINXDIRS="admin-guide/media userspace-api/media driver-api/media/"

would create something similar to this(*):

	doc_build/sphindirs/
		|
		+--> index.rst
		+--> admin-guide -> {srcdir}/Documentation/admin-guide/media/
		+--> usespace-api -> {srcdir}/Documentation/admin-guide/media/
		\--> driver-api -> {srcdir}/Documentation/admin-guide/media/

And then build, without any loops, using doc_build/sphindirs/ as
the sphinx-build sourcedir.

The problem of such approach is to avoid cross-references using
:doc:.

(*) this is oversimplified: it probably needs to copy
    files, as Sphinx blocks symlinks like that. Also,
    the actual linkname may be different - all we need
    there is an unique name.

In any case, before we start looking into ways to avoid
SPHINXDIRS loop, IMO we'll be best served once we merge this
series and have the entire hacks on a single file without
depending on 4 independent scripts and relying on "|| exit"
hacks.

Thanks,
Mauro

