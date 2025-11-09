Return-Path: <linux-kernel+bounces-892114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE78C445C9
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 20:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE548346279
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 19:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374F621CC64;
	Sun,  9 Nov 2025 19:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J45COeLS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9AB4C81
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762715928; cv=none; b=c2pH/+wpbe3wQU18nur9KRSWLZfeJNuqtgaphAg09j7tUGsR7qvOQmEqLy6KXEf4jm8idlwrFRcoLmkfz5C0GZ1TFjW4xmxhQFZCw68hDaOAvSty3oKSQYjECa+fdhqA0rqcP0XO0ct58EJ/20FzutQzW1JmqnrYSdTG+iDNG6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762715928; c=relaxed/simple;
	bh=mGFvQbV410JR8d38Ezb4gyjc5nTCZrcnscZyJrRogmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZMb5qYk356jD7DoFLW/S2FZeVam6jU2rlBJQGMox+mY6d1XHRcvi//7AXuaoRN2NCbbeJ/NCxsaLVUkuM8I2vhfTU3LGGLDv7nZSwNHHMl1oM3W9V3h16mPYN2HLPVsjmTZtBdQHw9SCa4T0PgElZ8U0g4vCS32opi+8Rhln30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J45COeLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC68C4AF09;
	Sun,  9 Nov 2025 19:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762715927;
	bh=mGFvQbV410JR8d38Ezb4gyjc5nTCZrcnscZyJrRogmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J45COeLS4iiRx2lGH1UmcAlTVXtMps6JMUVjoumd0oykEBxIGguvdKu886OnkWZpj
	 IfL8axmWB3ZPtmdF2LXn2HJLlAstacUjMSujpNlHBuFUtfR7SU55W1i0UYKEi/Yi8+
	 qYOEUZDTrVKHwOf64cXcCDNcEOdcv6kFzQZfZBo8ggDjyo9M72bSJFBkTgLYC/CYyO
	 XeuHhkK861vtA6Ll4jA3H42vuXzVB66Yx5joPMQ9eBAyG+yNEq6GagFHhIWbjTZWDS
	 brgNwp1jqifaHGmotw/4+GpFI7okxfqph31kBH2dtBGZx8bduPYUbvEsVwlJrGFXr2
	 KvLt00G2ojF2w==
Date: Sun, 9 Nov 2025 20:18:41 +0100
From: Alejandro Colomar <alx@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/4] array_size.h: Add ARRAY_END()
Message-ID: <amjs73mcxeq2zcni5rkbbugm7jgboejrtk6qxfov76hr2fca6m@zjdljyhkkaqs>
References: <cover.1758806023.git.alx@kernel.org>
 <cover.1762711279.git.alx@kernel.org>
 <2cb4ddff93b3d3037ef8d094de94227982117f87.1762711279.git.alx@kernel.org>
 <alpine.DEB.2.21.2511091903580.25436@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2mnclewibysqbpeg"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2511091903580.25436@angie.orcam.me.uk>


--2mnclewibysqbpeg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/4] array_size.h: Add ARRAY_END()
Message-ID: <amjs73mcxeq2zcni5rkbbugm7jgboejrtk6qxfov76hr2fca6m@zjdljyhkkaqs>
References: <cover.1758806023.git.alx@kernel.org>
 <cover.1762711279.git.alx@kernel.org>
 <2cb4ddff93b3d3037ef8d094de94227982117f87.1762711279.git.alx@kernel.org>
 <alpine.DEB.2.21.2511091903580.25436@angie.orcam.me.uk>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2511091903580.25436@angie.orcam.me.uk>

Hi Maciej,

On Sun, Nov 09, 2025 at 07:05:40PM +0000, Maciej W. Rozycki wrote:
> On Sun, 9 Nov 2025, Alejandro Colomar wrote:
>=20
> > diff --git a/include/linux/array_size.h b/include/linux/array_size.h
> > index 06d7d83196ca..b5775b8f13de 100644
> > --- a/include/linux/array_size.h
> > +++ b/include/linux/array_size.h
> > @@ -10,4 +10,10 @@
> >   */
> >  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_ar=
ray(arr))
> > =20
> > +/**
> > + * ARRAY_END - get a pointer to one past the last element in array @a
> > + * @a: array
> > + */
> > +#define ARRAY_END(a)  (&(a)[ARRAY_SIZE(a)])
>=20
>  Why `a' rather than `arr' as with the other macro?

It's simpler, and equally informative.  I wish ARRAY_SIZE() would have
also used 'a'.  On the other hand, consistency is important.  I'll make
it 'arr'.

Thanks!


Have a lovely night!
Alex


>=20
>   Maciej

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--2mnclewibysqbpeg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmkQ6REACgkQ64mZXMKQ
wqlxpg/8DCZ43s63Y4S4kHX7NRY5OVoa64fFe+SDhiM+Aq3FGWYWusa8kZIHgo86
/lLSLyZwQciCGXCENn4yiKkCYv76FEiCZY29kelAF4sEf4perL4IbX4MrChkWSLO
LcFvRC6qs52Qzp3Rd3c3sImkcz2Cbogeku+w3W1n2G5K7DL8O8qrcLtFYAZTMn1u
lQMCyBfh/izbE0ymjYnlFk20VansUxSWb7V534tSK6cezHfHCvmoimAB5pe1psPC
e1H4uSP9wiXoG9Td/WylTu2JGp7WF/c/3vwEfYYYD24QvgW9nvBiP/WsSqBx8I/E
tihbCcT3oiL7rhcXcebnJ25Yea+tPMbaYIvq6UT+8exXWRwf37j+763w4lfrxIiz
1ux+b11LsQ1gMKidaGMdfz6IMJvVX+f2mkuTQxARS9f7tqIiHSKU4TDKntReDsiV
gjh4yjNrX2kDnj4Ss7hkPbRNzyh048TKgk4fnH2MUDRTyR0rI2yGqZ9HbqsAMo31
+y+07K/VjAQLSNeE/P8a73QjZFm7SR0kU5crpuTjonCNGjQZkw+EcZsCvZcTFV4R
hvzJC4S/v5rkfPOguAGOM1CvJXGrYiKH91JnVavvy8toezhEmO16Pyge8aOralaH
YlX1X+n1yY4VKuxDfZxd+cwzMzIvns8du+xNCOrJvUy49YkQPMo=
=e0eB
-----END PGP SIGNATURE-----

--2mnclewibysqbpeg--

