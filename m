Return-Path: <linux-kernel+bounces-770195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0348B27859
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49897AC14D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6DE2BE7BC;
	Fri, 15 Aug 2025 05:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEzW9qpE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F59D23BF9B;
	Fri, 15 Aug 2025 05:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235114; cv=none; b=KJJYvOENYaBMnehVSzMDb3KDE4x3z6cZMVWszzV0UbopxeQgqHFV/WVlKbGefW7VnRttk+ZNC4RSXGMtlXJ6wlGFYBSMYysiGHGjEXUyI43iDf8buyKCodxDS5BuD1y4YJmoO0FHfrIzE5fHwvSe7Z6miVSYmYV7+Ac8cJhe4+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235114; c=relaxed/simple;
	bh=vL2h/HKTuso5czWzilNldbroxhtjYjFRBbrr8i+Z5gg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iy3p7+znMSOaptY1K0aVN+05Ke9tBM9LvfRJQpa/o8eaOryYD4OM07OLTo8rOmLxZveCrQLB1QG7KcYPl50P3gl6NcrZvQ0oU5cvsLPzMQDhecrqrt7EiPS4npiz0I1LT/d4ua7uSO3hi1y3yyJJSN4ew9jYs93HeniBqmXCp34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEzW9qpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1B8C4CEF4;
	Fri, 15 Aug 2025 05:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755235113;
	bh=vL2h/HKTuso5czWzilNldbroxhtjYjFRBbrr8i+Z5gg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HEzW9qpEijiNtiJtd4MuTLseCX2F7GJ+o1E9t/gZRSiWzfPa8r9Ds6eAxz3FQBI0r
	 kZjWpcSU9J0hCQwlVqWJJVdWKx647tdmemo+xl/me1NxTVFELzTNZpWv/eRjRO5qH6
	 t3K1KMX6Z5NigOfnzcxVKbvCuGHgc/w5vmb18DY2gvjiW2+Q7TqNNU2H9fPvoTLkMs
	 vCc/20Pkp4jTkZmbeNBmhP037a362kDtlvAyNUW9qak78uu6rNPtdCyROfMK0V58pN
	 Vs1JNcbJqgofP8Hw5lCh3kVZgDF6/NZdO6tASPymndSbfal+jKkQ1SsaNpKyFd+fr3
	 lkYBBArEnTHUw==
Date: Fri, 15 Aug 2025 07:18:29 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 07/13] docs: move sphinx-pre-install to tools/doc
Message-ID: <20250815071829.3d5163fc@foz.lan>
In-Reply-To: <87wm76f1t5.fsf@trenco.lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
	<20250813213218.198582-8-corbet@lwn.net>
	<20250814013600.5aec0521@foz.lan>
	<871ppehcod.fsf@trenco.lwn.net>
	<20250814080539.2218eb4e@foz.lan>
	<87wm76f1t5.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Em Thu, 14 Aug 2025 07:52:22 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>=20
> > This series is big (51 patches) because it needs to fix thousands of
> > broken cross references on media. I may end splitting it on two series
> > to make easier for review, one for the script and another for media doc
> > fixes. =20
>=20
> That might help, yes.
>=20
> > Such series affect this RFC as it is creating a tools/docs and placing=
=20
> > there the parse-headers.py code as:
> >
> > 	 tools/docs/lib/parse_data_structs.py                                 =
 |  230 +++++++++++++++--------------------
> > 	 tools/docs/parse-headers.py                                          =
 |    5=20
> >
> > Now, if you prefer tools/doc instead and/or place the libs elsewhere,
> > we have a couple of options:
> >
> > 1. rebase my series to do the changes. I suspect that there won't
> >    be much conflicts, but this may delay a little bit sending you
> >    what I have;
> >
> > 2. add a patch at the end moving stuff elsewhere;
> >
> > 3. on your series, move them elsewhere.
> >
> > What do you prefer? =20
>=20
> Between "tools/doc" and "tools/docs" I don't really have overly strong
> feelings; if you work has the latter we can just stick with that.  If
> you propose "tools/Documentation", though, expect resistance :)

<joke>
Heh, I'm tempted to propose:
	/Documentation -> /docs
or
	/Documentation -> /Docs
</joke>

Ok, so let's keep tools/docs then. We need to decide about python
lib. On my series, I'm placing at tools/docs/lib, but I guess we
can change it later.

=46rom my side, I would prefer to have a single directory for tools,
as we may place there things that aren't specific to docs.

For instance, I have my own class that I use for command execution,
using asyncio. The rationale is that it allows output messages in
real time without needing to wait for the entire process to end(*).

(*) I recently discovered a way to do that without needing asyncio,
    which makes the code a little bit simpler.

Either using asyncio or not, a class for such purpose is something
that multiple tools could use. So, a generic dir like tools/lib,=20
lib/python, ... IMO makes sense.

> As I said, my series was an RFC to see what it would look like; it did't
> take all that long the first time around, and will be even quicker to
> redo on top of a new base, whatever that turns out to be.

With regards to the RFC, IMO we still may need to discuss how we'll end=20
placing libraries under a LIBDIR. IMO, your RFC should also propose
a directory structure. I mean, we could have something like:

	LIBDIR     # either tools/docs/lib, tools/lib, lib/python or whatever
	|
	+---> common
	\---> docs
		|
	    	+---> kdoc
	    	\---> abi

We could instead do:
	- flatten "common" to LIBDIR; or:
	- flatten "docs" to LIBDIR; or:
	- flatten both but keeping kdoc, abi, ... directories inside
	  LIBDIR; or:
	- have a completely flatten directory with everything
	  under LIBDIR.

=20
> Thanks,
>=20
> jon



Thanks,
Mauro

