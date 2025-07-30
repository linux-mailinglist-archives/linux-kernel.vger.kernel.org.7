Return-Path: <linux-kernel+bounces-751234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6C2B166C1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9D34E0A39
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13CF132122;
	Wed, 30 Jul 2025 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2FTHKHX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4773D2E041E;
	Wed, 30 Jul 2025 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753902976; cv=none; b=TgqaXthqDjhtyumeFzd6fZ+slSvo3E3eqWp2BwZ/94RpTt5rtQsHDKj84z7SmT3n1X+OYdydjIeALTd363fM3Fxy5CZK0HQhxvI+3MlaW8teIsZekeK6v8kkAqwzva4jyAIO6LYnLt+6NlyaDOr+ZAma20OTTRhysZ6GoPmVFNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753902976; c=relaxed/simple;
	bh=paLp1BIdybL/evtNtAmmQvBrCLdADwDu+YfF/9iOkZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAKv9UjZhn0fL1nHkAbzJaqNMqVKlLW100iPdVrjtMHWdDygCofEjkqEdNYVqukEM+bvh5Hr2wbJV7xbx9JWFT8oGoH6dqPNa6k5UgDV7p6o0SoLoL1c790ePhGdkoHP/qgZO3Az5gjv47yQ7h2zhaPUGU4xUKlu75q1YIC5hec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2FTHKHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0C9C4CEE3;
	Wed, 30 Jul 2025 19:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753902974;
	bh=paLp1BIdybL/evtNtAmmQvBrCLdADwDu+YfF/9iOkZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J2FTHKHXXsApc9DRvtw/hZ/5ILuA/V0ChK176O5TYMVvtfFqe+GfHJyqOSXrqLEzQ
	 P/Uyd8PsFI485XxMeNmse7t5LeqGey1XWbVh1dTqElH5faQFC5FejxHd3k6KdIm9xK
	 SlwhpD9+GyHSBvCMavl1r7d7X/juWKAGbwYvR6WCUjvFOMkn8PqBEsqX8v1dvn91jX
	 2y3O4YS4WitZuZiH2az4xM2HRUoCuYbBSzBUFEFnhE7LiCrV6ZvZKCCnF3c87kxswC
	 QHhYh9dQK4tWhmgzq4u9j0bA9lq+a444bVU3TrXCWPhYg0MnB2pev7rpITDZV0E1S7
	 dbnSzT8I/nBJw==
Date: Wed, 30 Jul 2025 20:16:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sasha Levin <sashal@kernel.org>,
	Greg KH <greg@kroah.com>, corbet@lwn.net, linux-doc@vger.kernel.org,
	workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <d9564214-49d6-4129-976f-4fba123a8a31@sirena.org.uk>
References: <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
 <aIpKCXrc-k2Dx43x@lappy>
 <a1022055-52bd-4948-9399-908b29ca140a@lucifer.local>
 <aIpSlhPTC9G1AqvO@lappy>
 <eaf1366f-4b28-4312-a820-1cd04796ff1d@lucifer.local>
 <20250730133220.6e7e9370@gandalf.local.home>
 <eafe2f1f-c8f4-41d4-b590-94509093eca3@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7mkIjPwjkTEnJFaA"
Content-Disposition: inline
In-Reply-To: <eafe2f1f-c8f4-41d4-b590-94509093eca3@lucifer.local>
X-Cookie: Linux is obsolete


--7mkIjPwjkTEnJFaA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 30, 2025 at 07:04:13PM +0100, Lorenzo Stoakes wrote:
> On Wed, Jul 30, 2025 at 01:32:20PM -0400, Steven Rostedt wrote:

> > If the maintainer starts getting too many submissions, then they can update
> > the MAINTAINERS file to say "stop all AI patches to me!". Just like we have
> > an opt-in for to not be part of the get_maintainer.pl "touched this file"
> > with the .get_maintainer.ignore script.

> Again I really don't think this aligns with what maintainers will want.

I suspect this may be more varied than you're expecting, and that the
attitudes of people maintaining core kernel things are going to be on
average different to those of people working more with driver code.  TBH
I'm also concerned about submitters just silently using this stuff
anyway regardless of what we say, from that point of view there's
something to be said for encouraging people to be open and honest about
it so it can be taken into consideration when looking at the changes
that get sent.

This is all modulo the general licensing and other non-technical issues
of course.

> But again I think that is better settled or at least addressed at the
> maintainers summit.

I do expect that it'll be discussed there.

--7mkIjPwjkTEnJFaA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiKb3gACgkQJNaLcl1U
h9B/cQf+Jr5NjBC9M7eVpZSgsK7Oeyxb+p8DBNVgeP/HCZcx1GuvV9FW+7BHubzv
Ws0/2vp8o9GXxLHaCqnGmyJ5ncM484LLwadGz4vGeEXKJj3pGzFSREnWlF+Y33Hj
vn0QgHI0vPPaNWmscN84I8zVIFFn537fwVc5N0dM1Db8Q6INTZJEvuXewLnmoefD
E1flpsfoeIj5+ceIsSUSHPJ0eqG5W6blvjePG0U8HY7RPUYUkiOa8qFFKrYVMMLR
6bnixvmbXsPU0sejbGG79arGrKQN7HRi5tByXGZJXA82RsScOvPAJaJOlNQBIL0F
nPOhqLDk/dhePJp8JphJx6T3XEcT+w==
=IAmt
-----END PGP SIGNATURE-----

--7mkIjPwjkTEnJFaA--

