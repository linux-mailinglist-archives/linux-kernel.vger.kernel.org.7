Return-Path: <linux-kernel+bounces-813390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5CEB54474
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4D818885DF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806982D4800;
	Fri, 12 Sep 2025 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xi6LesXp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76C62E401;
	Fri, 12 Sep 2025 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757664411; cv=none; b=Xzy/zHuPqd/QJ8LWxUX30kKWgoekceARj8nz6So+5CYPL8KPTzrK9CMCaPqPPoKXA5k9EVu1UcdetAXxQYFNf46RCaa4ZvpdSaYFX6T7AWNBsWQzOZHReqrC4Ha5iYx7y8izbAgtcAg9qcUieTtzEYFwkzydCkQPs1fL28Wjg8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757664411; c=relaxed/simple;
	bh=JIDNigBEQ26LMxGdb3Stg7SADUM2py3C9JqZNK5PaBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2W0UFqo+a5ztUXNhRqH3Q3iVRF96mSii7sTuwIu9SnE7liEEq+/zAzXoRGUDagPkHHhFA8xVbHdn+kF7Kf6frWa2W5BdUJ4daiTwaGApsSeBWTWadKyzPk9wGu70HHvEIfgZLYPhernEI/Nkcfp4prxJqRjiHAEgpBNngsnuak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xi6LesXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061DEC4CEF5;
	Fri, 12 Sep 2025 08:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757664411;
	bh=JIDNigBEQ26LMxGdb3Stg7SADUM2py3C9JqZNK5PaBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xi6LesXpM5el8fvLzaOJ/6hXe8hKRX727RutnRMh+D5yeUkpSfHrWY3NlCZ10qHKj
	 9OJpk08TH9Cq5TmKLQthA1Ntm+s0J1lIyMOc5S/iiZrXQ2gVXRkorZ2H5PCfswHWQf
	 oEr20N5QU1MnJwHzI553WVNyow9NMueYI+9OewiwCR+xV6UuILGkuIf9iDQzmZ0C2d
	 A/HGRK6nBKFSqkgIBykCSzIHNv5gurGb3xRkmsr6WfafvYU8rgDokziBwhrYlQGszf
	 8BvoRfv54yuwiz+nm0J4iLAs3iWMieKEMWh2gLD/+QE/4yGk9RueqOY0U65s1weRPs
	 6clf7PV+Rk1Og==
Date: Fri, 12 Sep 2025 10:06:45 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl
 <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a
 wrapper for sphinx-build
Message-ID: <20250912100645.15c79351@foz.lan>
In-Reply-To: <87ldmkojo5.fsf@trenco.lwn.net>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
	<e019f951190a732f9ac0b21bcda7e49af3bd5cbd.1756969623.git.mchehab+huawei@kernel.org>
	<e13837a0ac46dffe39c600d11fdf33f538bdc9c3@intel.com>
	<20250910145926.453f5441@foz.lan>
	<45888ca6c88071c754784495b4ef69460ea67b4f@intel.com>
	<fuv4p45tvjfdvwu2625s2l2kvcw64p4ohherlwyum3vmogmrfz@yb47nt66xgm6>
	<87zfb1p0r3.fsf@trenco.lwn.net>
	<a1333c717bb5bcea7f7c616cbf8604fa259c3158@intel.com>
	<87ldmkojo5.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Em Thu, 11 Sep 2025 13:47:54 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Jani Nikula <jani.nikula@linux.intel.com> writes:
>=20
> > On Thu, 11 Sep 2025, Jonathan Corbet <corbet@lwn.net> wrote: =20
> >> A couple of times I have looked into using intersphinx, making each bo=
ok
> >> into an actually separate book.  The thing I always run into is that
> >> doing a complete docs build, with working references, would require
> >> building everything twice.  This is probably worth another attempt one
> >> of these years... =20

There are a couple of different usecase scenarios for building docs.

1) The first and most important one is to produce book(s) for people
   to use. This is usually done by some automation, and the result is
   placed on places like:
	- https://docs.kernel.org/

   and on subsystem-specific places like:
	- https://linuxtv.org/downloads/v4l-dvb-apis-new/

for scenario (1), taking twice the time to build is not an issue, as
nobody will be sitting on a chair waiting for the build to finish.

On such scenario, SPHINXDIRS is important on subsystem-specific docs.
For instance, on media, we use SPHINXDIRS to pick parts of 3 different
books:

	- Documentation/admin-guide/media/
	- Documentation/driver-api/media/
	- Documentation/userspace-api/media/

What media automation does, once per day, is:

	# Non-essencial parts of index.rst dropped
	cat <<END >Documentation/media/index.rst
	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
	Linux Kernel Media Documentation
	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

	.. toctree::

	        admin-guide/index
        	driver-api/index
	        userspace-api/index
	END

	rsync -uAXEHlaSx -W --inplace --delete Documentation/admin-guide/media/ Do=
cumentation/media/admin-guide
	rsync -uAXEHlaSx -W --inplace --delete Documentation/driver-api/media/ Doc=
umentation/media/driver-api
	rsync -uAXEHlaSx -W --inplace --delete Documentation/userspace-api/media/ =
Documentation/media/userspace-api

	make SPHINXDIRS=3D'media' CSS=3D'$CSS' DOCS_THEME=3D'$DOCS_THEME' htmldocs
	make SPHINXDIRS=3D'media' pdfdocs
	make SPHINXDIRS=3D'media' epubdocs

2) CI tests. Here, taking more time usually is not a problem, except
   when CI is used before pushing stuff, and the developer has to wait
   it to finish before pushing.

For scenario (2), a build time increase is problematic, as, if it now
takes twice the time, a change like that will require twice the
resources for the build with may increase costs.

3) developers who touched docs. They want a way to quickly build and
   verify the output for their changes.

Here, any time increase is problematic, and SPHINXDIRS play an important=20
hole by allowing them to build only the touched documents.

For instance, when I was developing Netlink yaml plugin, I had to use
dozens of times:

	make SPINXDRS=3DDocumentation/netlink/specs/ htmldocs

If I had to build the entire documentation every time, the development
time would increase from days to weeks.

Looking on those three scenarios, the only one where intersphinx is
useful is (1).

=46rom my PoV, we should support intersphinx, but this should be optional.
Also, one has to point from where intersphinx will point unsolved
symbols. So, we would need something like:

	make SPHINXREFMAP=3Dintersphinx_mapping.py htmldocs

where intersphinx_mapping.py would be a file containing intersphinx
configuration. We would add a default map at Documentation/, while
letting it to be overridden if some subsystem has different requirements
or is using a different CSS tamplate or not using alabaster.

> > I think the main factor in that should be whether it makes sense from
> > overall documentation standpoint, not the technical details.

Agreed.

> > Having several books might make sense. It might even be helpful in
> > organizing the documentation by audiences. But having the granularity of
> > SPHINXDIRS with that would be overkill.=20

On the contrary. SPHINXDIRS granuarity is very important for scenario (3).

> > And there needs to be a book to
> > bring them together, and link to the other books, acting as the landing
> > page. =20
>=20
> Well, I think that the number of existing directories needs to be
> reduced rather further.  I made progress in that direction by coalescing
> all the arch docs under Documentation/arch/.  I would like to do
> something similar with all the device-specific docs, creating
> Documentation/devices/.  Then we start to get to a reasonable number of
> books.

I don't think reducing the number of books should be the goal, but,
instead, to have them with a clear and coherent organization with focus
on the audience that will be actually using them.

After reorg, we may have less books. That's fine. But it is also fine
if we end with more books.

I lost the battle years ago, but I still believe that, at least for
some subsystems like media, i2c, DRM, security and others, a=20
subsystem-specific book could be better. After all, the audience for
such subsystems is very specialized.

> > I believe it should be possible to generate the intersphinx inventory
> > without generating the full html or pdf documentation. So I don't think
> > it's actually two complete docs builds. It might speed things up to have
> > a number of independent documentation builds. =20
>=20
> That's a good point, I hadn't looked into that part.  The builder phase
> takes a lot of the time, if that could be cut out things would go
> faster.=20

Indeed, but we need to double check if .doctree cache expiration will
happen the right way for all books affected by a partial build.

During this merge window, I sent a RFC patch in the middle of a comment
with a conf.py logic to detect Sphinx cache expiration. I remember I
added a comment asking if we should upstream it or not, but, as nobody
answered, I ended forgetting about it.

If we're willing to experiment with that, I recommend looking on such
patch and add a variant of it, enabled via V=3D1 or via some debug
parameter.

The goal would be to check if a change on a file will ensure that all
books using it will have cache expiration and be rebuilt.

> > As to the working references, IIUC partial builds with SPHINXDIRS
> > doesn't get that part right if there are references outside of the
> > designated dirs, leading to warnings. =20
>=20
> That is true.  My point though is that, to get the references right with
> a *full* build, a two-pass approach is needed though, as you suggest,
> perhaps the first pass could be faster.

How fast? during development time, SPHINXDIRS means a couple of seconds:

	$ make clean; time make SPHINXDIRS=3D"peci" htmldocs
	...
	real    0m1,373s
	user    0m1,348s

Even more complex builds, even when picking more than one book, like this:

	$ make clean; time make SPHINXDIRS=3D"driver-api/media/ userspace-api/medi=
a/" htmldocs
	...
	real    0m11,801s
	user    0m31,381s
	sys     0m6,880s

it still fits at the seconds range. Can interphinx first pass have a
similar build time?

Thanks,
Mauro

