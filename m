Return-Path: <linux-kernel+bounces-813832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CE1B54B41
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564EE461830
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F7530148C;
	Fri, 12 Sep 2025 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9Xa87mo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A825341C62;
	Fri, 12 Sep 2025 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677299; cv=none; b=uB7cAUaxwrEYaUB7n4HdAFWZbY6QQSoMxIQJU4uUGCMWsngPC8mVeNqgsc3UC5h3s+rcgAiUNTrmNIR/Y30zQolMK4rYm/2lC3wmZHoL5E9lKqjwQEQ8sr5CFW72HBV7vng97x72dliniLWpQ2ylkzVdx0PNbzQ7le/oPF31MQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677299; c=relaxed/simple;
	bh=Q7N7MY3MRjBFALP4I4GoCVVT2TGAxSB9pK6gNyq8I/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8hAsLoA475PYSBuQwNfcqp4nUjuPvO7pvN2xVY4bCeU+YAdF1FFcYx89QuJYA1WM68Ob08oHlGJxwrXrkZjt7Uu/rPq5cVPw2KdMVo76NCoDEzOh1jvKUWM0gFHhG/x957LVAMmyF6AFuIk+FO8mRAPtxSzSwJ6DSCbZbc42hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9Xa87mo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EB7C4CEF4;
	Fri, 12 Sep 2025 11:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757677298;
	bh=Q7N7MY3MRjBFALP4I4GoCVVT2TGAxSB9pK6gNyq8I/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T9Xa87mon84u7/qtE+c7XBpbs7d5nDNHtJ6z64fz1Run0iuKMPo8bcMQfZ7jpk/HB
	 EWNZEQZdnQ7I8jElpF2mRpNVxfAhuRcRs5kG7KqGNWqm6s5hLEBPml87TXOpyvnGMG
	 I5BurZusuR5zbhZshkc4cO/6vwFXQzvq0jG1fRC7WuDXWyDW5mqvH42rat54LY8Bhh
	 H9p/P1otqVTxlcWYqnVdfeBUcJvYDqqFVTVYyeO/V+4LaL4zXAwM7KzQgtG3b259ct
	 ykXXtJa+EgVhEhc2Q217Dbd5DeJMMLzikTd506HWTXNaUys8fTotIZfJyUoj/OTFlr
	 +ETg0UFBWVIVQ==
Date: Fri, 12 Sep 2025 13:41:33 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl
 <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a
 wrapper for sphinx-build
Message-ID: <20250912134133.71428d97@foz.lan>
In-Reply-To: <1e5ea0314833519fdfda3a75c79fd046d41c086d@intel.com>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
	<e019f951190a732f9ac0b21bcda7e49af3bd5cbd.1756969623.git.mchehab+huawei@kernel.org>
	<e13837a0ac46dffe39c600d11fdf33f538bdc9c3@intel.com>
	<20250910145926.453f5441@foz.lan>
	<45888ca6c88071c754784495b4ef69460ea67b4f@intel.com>
	<fuv4p45tvjfdvwu2625s2l2kvcw64p4ohherlwyum3vmogmrfz@yb47nt66xgm6>
	<87zfb1p0r3.fsf@trenco.lwn.net>
	<a1333c717bb5bcea7f7c616cbf8604fa259c3158@intel.com>
	<87ldmkojo5.fsf@trenco.lwn.net>
	<20250912100645.15c79351@foz.lan>
	<1e5ea0314833519fdfda3a75c79fd046d41c086d@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 12 Sep 2025 13:16:12 +0300
Jani Nikula <jani.nikula@linux.intel.com> escreveu:

> On Fri, 12 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > Em Thu, 11 Sep 2025 13:47:54 -0600
> > Jonathan Corbet <corbet@lwn.net> escreveu:
> >  
> >> Jani Nikula <jani.nikula@linux.intel.com> writes:
> >>   
> >> > On Thu, 11 Sep 2025, Jonathan Corbet <corbet@lwn.net> wrote:    
> >> >> A couple of times I have looked into using intersphinx, making each book
> >> >> into an actually separate book.  The thing I always run into is that
> >> >> doing a complete docs build, with working references, would require
> >> >> building everything twice.  This is probably worth another attempt one
> >> >> of these years...    
> >
> > There are a couple of different usecase scenarios for building docs.
> >
> > 1) The first and most important one is to produce book(s) for people
> >    to use. This is usually done by some automation, and the result is
> >    placed on places like:
> > 	- https://docs.kernel.org/
> >
> >    and on subsystem-specific places like:
> > 	- https://linuxtv.org/downloads/v4l-dvb-apis-new/
> >
> > for scenario (1), taking twice the time to build is not an issue, as
> > nobody will be sitting on a chair waiting for the build to finish.
> >
> > On such scenario, SPHINXDIRS is important on subsystem-specific docs.
> > For instance, on media, we use SPHINXDIRS to pick parts of 3 different
> > books:
> >
> > 	- Documentation/admin-guide/media/
> > 	- Documentation/driver-api/media/
> > 	- Documentation/userspace-api/media/
> >
> > What media automation does, once per day, is:
> >
> > 	# Non-essencial parts of index.rst dropped
> > 	cat <<END >Documentation/media/index.rst
> > 	================================
> > 	Linux Kernel Media Documentation
> > 	================================
> >
> > 	.. toctree::
> >
> > 	        admin-guide/index
> >         	driver-api/index
> > 	        userspace-api/index
> > 	END
> >
> > 	rsync -uAXEHlaSx -W --inplace --delete Documentation/admin-guide/media/ Documentation/media/admin-guide
> > 	rsync -uAXEHlaSx -W --inplace --delete Documentation/driver-api/media/ Documentation/media/driver-api
> > 	rsync -uAXEHlaSx -W --inplace --delete Documentation/userspace-api/media/ Documentation/media/userspace-api
> >
> > 	make SPHINXDIRS='media' CSS='$CSS' DOCS_THEME='$DOCS_THEME' htmldocs
> > 	make SPHINXDIRS='media' pdfdocs
> > 	make SPHINXDIRS='media' epubdocs  
> 
> I was actually wondering how [1] was built. So it's not a complete build
> of anything upstream, but rather something cobbled together downstream.

It used to be a direct build from upstream. I had to do this hack when
we decided to split subsystem docs on 3 separate books.

> So your scenario (1) above is actually *two* wildly different scenarios.
> 
> And if upstream needs to cater for pretty much random subsets of
> documentation being built, cherry-picking documentation from here and
> there, I don't know what hope there is in radically refactoring how
> documentation gets built upstream.
> 
> I presume you have one or more of a) get bunch of broken link warnings
> at build, b) get broken links in the output, c) avoid links outside of
> your subset altogether.

There aren't many broken links, and this is not due to (c): almost all
cross-references we have are between media kAPI and media uAPI. Those
were solved when we artificially joined two books and used SPHINXDIRS
feature to produce the docs.

If we had intersphinx support, I would be building the docs in
separate using the standard SPHINXDIRS logic to create such
cross references, pointing to linuxtv.org for media docs and to
docs.kernel.org for other ones.

> 
> [1] https://linuxtv.org/downloads/v4l-dvb-apis-new/
> 
> > 2) CI tests. Here, taking more time usually is not a problem, except
> >    when CI is used before pushing stuff, and the developer has to wait
> >    it to finish before pushing.
> >
> > For scenario (2), a build time increase is problematic, as, if it now
> > takes twice the time, a change like that will require twice the
> > resources for the build with may increase costs.
> >
> > 3) developers who touched docs. They want a way to quickly build and
> >    verify the output for their changes.
> >
> > Here, any time increase is problematic, and SPHINXDIRS play an important 
> > hole by allowing them to build only the touched documents.  
> 
> This is actually problematic, because the SPHINXDIRS partial builds will
> give you warnings for unresolved references that are just fine if the
> entire documentation gets built.

True, but if you pick them before/after a chanseset, you can notice
if the warning was introduced or not by the changeset. Only if it was
introduced by the patchset you need to wait 3 minutes for the full build.

> > For instance, when I was developing Netlink yaml plugin, I had to use
> > dozens of times:
> >
> > 	make SPINXDRS=Documentation/netlink/specs/ htmldocs
> >
> > If I had to build the entire documentation every time, the development
> > time would increase from days to weeks.
> >
> > Looking on those three scenarios, the only one where intersphinx is
> > useful is (1).  
> 
> It's also helpful for 3, and it could be helpful for 2 if CI only checks
> some parts of the documentation.

I'm not arguing against intersphinx. I do think having it is something
we need to aim for.

The question is: does it replace SPHINXDIRS by providing quick builds
if only some of the books were changed?

> > From my PoV, we should support intersphinx, but this should be optional.  
> 
> Per my understanding making this somehow optional is not easily
> achieved. And you end up with a bunch of extra complexity.

True, but I guess extra complexity is unavoidable: intersphinx
requires a list of books with reference locations, with is not the
same for everyone.

This is what expect once we have intersphinx in place:

Use linuxtv.org URLs for all references from:
	- Documentation/admin-guide/media/
	- Documentation/driver-api/media/
	- Documentation/userspace-api/media/

everything else: from kernel.org.

As they were generated from media next branch.

If implement it for DRM, in a way to track what DRM next branches
have, and if you have kapi, uapi and per-driver apis on different
books, you will probably want to solve intersphinx dependencies with 
a FDO specific "search" order, like:

	- xe and i915 books: from intel next branches;
	- amd books: from amd next branches;
	- drm core: from drm-next;
	- everything else: from kernel.org.

So, it is not just making it optional: you also need to provide a
way to allow it to be adjusted were it is needed. IMO, the easiest
way would be to have a separate .py file with intersphinx specifics:

	make SPHINXREFMAP=intersphinx_mapping.py htmldocs

This way, I could create a media_mapping.py file that would include
intersphinx_mapping.py and replace some defaults to do my own mapping.

> > Also, one has to point from where intersphinx will point unsolved
> > symbols. So, we would need something like:
> >
> > 	make SPHINXREFMAP=intersphinx_mapping.py htmldocs
> >
> > where intersphinx_mapping.py would be a file containing intersphinx
> > configuration. We would add a default map at Documentation/, while
> > letting it to be overridden if some subsystem has different requirements
> > or is using a different CSS tamplate or not using alabaster.
> >  
> >> > I think the main factor in that should be whether it makes sense from
> >> > overall documentation standpoint, not the technical details.  
> >
> > Agreed.
> >  
> >> > Having several books might make sense. It might even be helpful in
> >> > organizing the documentation by audiences. But having the granularity of
> >> > SPHINXDIRS with that would be overkill.   
> >
> > On the contrary. SPHINXDIRS granuarity is very important for scenario (3).  
> 
> Sphinx does support incremental builds, and it's only the very first
> build that's slow. IMO a handful of books that you can actually build
> without warnings (unlike SPHINXDIRS) with incremental builds is a good
> compromise.

That's not quite true: when Sphinx detects a missing file, it expires
the caches related to it and don't do incremental builds anymore. I had
to write a patch during the last development cycle due to that, as -rc1
came up with a broken reference because of a file rename. This was only
solved 3 months after the fact.

> >> > And there needs to be a book to
> >> > bring them together, and link to the other books, acting as the landing
> >> > page.    
> >> 
> >> Well, I think that the number of existing directories needs to be
> >> reduced rather further.  I made progress in that direction by coalescing
> >> all the arch docs under Documentation/arch/.  I would like to do
> >> something similar with all the device-specific docs, creating
> >> Documentation/devices/.  Then we start to get to a reasonable number of
> >> books.  
> >
> > I don't think reducing the number of books should be the goal, but,
> > instead, to have them with a clear and coherent organization with focus
> > on the audience that will be actually using them.
> >
> > After reorg, we may have less books. That's fine. But it is also fine
> > if we end with more books.
> >
> > I lost the battle years ago, but I still believe that, at least for
> > some subsystems like media, i2c, DRM, security and others, a 
> > subsystem-specific book could be better. After all, the audience for
> > such subsystems is very specialized.
> >  
> >> > I believe it should be possible to generate the intersphinx inventory
> >> > without generating the full html or pdf documentation. So I don't think
> >> > it's actually two complete docs builds. It might speed things up to have
> >> > a number of independent documentation builds.    
> >> 
> >> That's a good point, I hadn't looked into that part.  The builder phase
> >> takes a lot of the time, if that could be cut out things would go
> >> faster.   
> >
> > Indeed, but we need to double check if .doctree cache expiration will
> > happen the right way for all books affected by a partial build.
> >
> > During this merge window, I sent a RFC patch in the middle of a comment
> > with a conf.py logic to detect Sphinx cache expiration. I remember I
> > added a comment asking if we should upstream it or not, but, as nobody
> > answered, I ended forgetting about it.
> >
> > If we're willing to experiment with that, I recommend looking on such
> > patch and add a variant of it, enabled via V=1 or via some debug
> > parameter.
> >
> > The goal would be to check if a change on a file will ensure that all
> > books using it will have cache expiration and be rebuilt.
> >  
> >> > As to the working references, IIUC partial builds with SPHINXDIRS
> >> > doesn't get that part right if there are references outside of the
> >> > designated dirs, leading to warnings.    
> >> 
> >> That is true.  My point though is that, to get the references right with
> >> a *full* build, a two-pass approach is needed though, as you suggest,
> >> perhaps the first pass could be faster.  
> >
> > How fast? during development time, SPHINXDIRS means a couple of seconds:
> >
> > 	$ make clean; time make SPHINXDIRS="peci" htmldocs
> > 	...
> > 	real    0m1,373s
> > 	user    0m1,348s
> >
> > Even more complex builds, even when picking more than one book, like this:
> >
> > 	$ make clean; time make SPHINXDIRS="driver-api/media/ userspace-api/media/" htmldocs
> > 	...
> > 	real    0m11,801s
> > 	user    0m31,381s
> > 	sys     0m6,880s
> >
> > it still fits at the seconds range. Can interphinx first pass have a
> > similar build time?  
> 
> Probably not. Can you add links from media to non-media documentation
> without warnings? Probably not also.

No, but I can count on my fingers the number of times I made such
changes: 99.9% of the time, doc changes aren't on the few docs that
have subsystem interdependencies. Even the number of dependencies
between media kapi and uapi are not high.

Thanks,
Mauro

