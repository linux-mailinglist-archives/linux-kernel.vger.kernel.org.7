Return-Path: <linux-kernel+bounces-751133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD6AB16597
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA205801B2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF4F2DECBF;
	Wed, 30 Jul 2025 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDka26ri"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F722E1730;
	Wed, 30 Jul 2025 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896876; cv=none; b=Viuzpm955hJCWJ0Cz0MH7GsAUX0JFHbrlyCk/UwQyQjLK/Z8w6VeWFEHG6NSDQZzYYg817cMTOh4FadLkaQe1BjKgIzMxKxf1sV3RXE1Cd2oGXgBrqP3I4yKO/jQ9ZTojRJvAOMNJK+l55vE1DQ3AAF0jdU5k4+ZZ2CkJJ+Fze0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896876; c=relaxed/simple;
	bh=D1dL3gmNG0kL9WbM7ic03uMC58TkVVhk/y6yBvxp0FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhB+flrNwp6RMm97hXGGd+Z/yjN4MNNxKsmfaaElUhaqmJ6BsfW/AAtFeLBnacgwt5PdWkj8Cs9jELPaQPsD0fcO2WbWaSRSiPcfKteeogcc3uzsdYETrnwuGQIS6JZ4mfPX8Qkvkhwi90xghLh87JcLnk4GtcqtBoFZ6FCyJPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDka26ri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728E4C4CEE3;
	Wed, 30 Jul 2025 17:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753896876;
	bh=D1dL3gmNG0kL9WbM7ic03uMC58TkVVhk/y6yBvxp0FM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDka26rizjwaK0Ndd0b71enHl+i38hQgeA4/y49WSOlzUHjwZNJ+6XlVAvbiiO6A7
	 QDGoNqgFk/QEUcKzKYu3mNrVoyme7Y4K1gm7VagjvCtjvSdQ8qJ6OIdT5xzp0Dc+q0
	 vRcvxd4WIEA69mYwLpL2ilYI4uTcXt4cRRIbl3NPY6d00ndVi6kkf/DbPzy6XibHLG
	 bD1UcGdkND32H256S8nTIAmAKDwSe7+Ve5DKtKAPheiwj8k/3EFIhgXbgAElHwE/Z5
	 Y1sduTPi3IINI70yH6ikbrakMlXPTdYivsTYrs/9GdcXdobVP+cS8j91q2z7to3Drm
	 kkfB5DQL2mx4w==
Date: Wed, 30 Jul 2025 18:34:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Greg KH <greg@kroah.com>, corbet@lwn.net, linux-doc@vger.kernel.org,
	workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <c814bee7-9fac-42b7-af8a-aae0567d6435@sirena.org.uk>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
 <aIpKCXrc-k2Dx43x@lappy>
 <a1022055-52bd-4948-9399-908b29ca140a@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m3m/JDs+hLe7vKCQ"
Content-Disposition: inline
In-Reply-To: <a1022055-52bd-4948-9399-908b29ca140a@lucifer.local>
X-Cookie: Linux is obsolete


--m3m/JDs+hLe7vKCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 30, 2025 at 05:59:25PM +0100, Lorenzo Stoakes wrote:
> On Wed, Jul 30, 2025 at 12:36:25PM -0400, Sasha Levin wrote:

> > Some sort of a "traffic light" system:

> >  1. Green: the subsystem is happy to receive patches from any source.

> >  2. Yellow: "If you're unfamiliar with the subsystem and using any
> >  tooling to generate your patches, please have a reviewed-by from a
> >  trusted developer before sending your patch".

> >  3. No tool-generated patches without prior maintainer approval.

> This sounds good, with a default on red. Which would enforce the opt-in
> part.

That's probably a bit much - I suspect we don't want to default block
coccinelle for example.  It's going to be very tool and technology
dependent, probably the main thing that's generally applicable is going
to be that people should say if and how they've used tools.

--m3m/JDs+hLe7vKCQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiKV6UACgkQJNaLcl1U
h9DTJgf8Da351rBfCFEZTOi0H/3TU5/qnMziaS+NLwRm+JbxbB+fXNYsuk5eHnUp
7rFQwjjxuuM5eLcIHM2snMKlMag0iCe+DtUZhtrUck7okQlhqlvqDTec/pPZu8ht
/mHaGN/PP682QtCgyZIJZkk1xSGxAACaYIkFoANDGkEn1nhpshRaYp2ivgAfA4+3
B18Mntvv3B8S3oZ58zq/PnOUh9fwj7xcG5UPWfJTHmDVfTYiWv+RbJt1BKzuDcF9
EbwBKBKTYDWxXdIgEsqIUXHEyH9rLawRZ29ul+k6XLfwFIQhZaSj4ZIMIWftJd14
FKtM3dq95ytrDysMvkR5QCLriiJRhg==
=iImI
-----END PGP SIGNATURE-----

--m3m/JDs+hLe7vKCQ--

