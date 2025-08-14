Return-Path: <linux-kernel+bounces-768923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 378A5B267F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159011CE3D40
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162BE3002D4;
	Thu, 14 Aug 2025 13:38:13 +0000 (UTC)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D484126C17
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178692; cv=none; b=qOR5zKFuF1UaU7x6RsJ2NZOmPj0exTlW/RrWbNk+e17Uc6Dgg/BHRQV4BhTCG3T0C+l5tFBg7v/q+RDft4S4fvRY0Bcx24Fa06ouk8EGkX8NZs1gqGtMWTti8mmvjdZTWJMr/WPlvzXHgenC+THauzOwHR5Uw+6RP9r57xPk7OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178692; c=relaxed/simple;
	bh=kjNhRQU46zPw6eZW1goIH1qTFXm0+Dww60I9vuUUvuQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7a08wuj0BOOoUNx6rfzcqIZ/JJ9A2Fr2ON0R6WdgJxGV7EyLx/Ygghs95yIO+aa5p7pzv1DYpjIcw+fYsAt4n99M3wHoIb2tn5hfKfSYVMaTmjuXJYw51PTpGsx1GI5WzUMPOa8u38oAs7u3xRL1IQC/ApGjZcQmwS6pq6CRHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Aug 2025 09:38:02 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: David Lechner <dlechner@baylibre.com>, 
	Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: mcp9600: Add support for IIR filter
Message-ID: <2025081409-ubiquitous-cuckoo-76acbd@boujee-and-buff>
Mail-Followup-To: David Lechner <dlechner@baylibre.com>, 
	Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20250813151614.12098-1-bcollins@watter.com>
 <20250813151614.12098-6-bcollins@watter.com>
 <a9c8457f-a364-46e2-9e31-ceab0e1c9894@baylibre.com>
 <2025081408-umber-axolotl-e6c6dd@boujee-and-buff>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zwmlvwkrslhe7sks"
Content-Disposition: inline
In-Reply-To: <2025081408-umber-axolotl-e6c6dd@boujee-and-buff>
X-Migadu-Flow: FLOW_OUT


--zwmlvwkrslhe7sks
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 5/5] iio: mcp9600: Add support for IIR filter
MIME-Version: 1.0

On Thu, Aug 14, 2025 at 09:06:39AM -0500, Ben Collins wrote:
> On Wed, Aug 13, 2025 at 05:52:04PM -0500, David Lechner wrote:
> > On 8/13/25 10:15 AM, Ben Collins wrote:
> > > MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> ...=20
> > >  static int mcp9600_read(struct mcp9600_data *data,
> > > @@ -186,6 +189,9 @@ static int mcp9600_read_raw(struct iio_dev *indio=
_dev,
> > >  	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> > >  		*val =3D mcp9600_tc_types[data->thermocouple_type];
> > >  		return IIO_VAL_CHAR;
> > > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > > +		*val =3D data->filter_level;
> >=20
> > We can't just pass the raw value through for this. The ABI is defined
> > in Documentation/ABI/testing/sysfs-bus-iio and states that the value
> > is the frequency in Hz.
> ...
> > For example, for 3 Hz sample rate (18-bit samples), I got:
> >=20
> >   n  f_3dB (Hz)
> >   1  0.58774
> >   2  0.24939
> >   3  0.12063
> >   4  0.05984
> >   5  0.02986
> >   6  0.01492
> >   7  0.00746
> >=20
> > I had to skip n=3D0 though since that is undefined. Not sure how we
> > handle that since it means no filter. Maybe Jonathan can advise?
>=20
> Thanks for notes. If I'm reading for datasheet formula right,
>=20
> k =3D 2 / (2^n + 1)
>=20
> So n=3D0 would be k=3D1. I did this formula for n=3D[0-7] and get:
>=20
> n	k
> 0	1.00000
> 1	0.66667
> 2	0.40000
> 3	0.22222
> 4	0.11765
> 5	0.06061
> 6	0.03077
> 7	0.01550
>=20
> I'm not versed in filter frequency, but would these be the correct
> values to use for the coefficients?

This seems to be what I was looking for:

Got it. For a 1-pole IIR low-pass of the form
y_t =3D y_{t-1} + k(x_t - y_{t-1}), the =E2=80=933 dB cutoff is

f_c =3D \frac{-\ln(1-k)}{2\pi}\,f_s

Using your k=3D\frac{2}{2^n+1} and a sample rate f_s =3D 3\ \text{Hz}, the =
equivalent =E2=80=933 dB cutoff frequencies are:

n	k		f_c (Hz)	time constant =CF=84 (s) =3D 1/(2=CF=80 f_c)
0	1.0000000000	=E2=88=9E		0.0000
1	0.6666666667	0.5245487288	0.3034
2	0.4000000000	0.2439012692	0.6525
3	0.2222222222	0.1199938006	1.3264
4	0.1176470588	0.0597609987	2.6632
5	0.0606060606	0.0298512716	5.3316
6	0.0307692308	0.0149219903	10.6658
7	0.0155038760	0.0074605397	21.3329

Notes:
	=E2=80=A2	n=3D0 (k=3D1) is just =E2=80=9Ctrack the input=E2=80=9D (no smoo=
thing), so f_c\to\infty.
	=E2=80=A2	If you=E2=80=99re using a different sampling rate, multiply the =
f_c values above by \frac{f_s}{3}.

--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--zwmlvwkrslhe7sks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmid5rkACgkQXVpXxyQr
Is9fyQ/+OKoIn9Epb1KWsfjJww7W4m6YWnMhPXqMHAs+mrfMkdLeDtIZWRMXKQPS
YjClxXItlARNxkqLIJQXu4rG/XMFqlQQEtflM4UVxtjgeiaomwF06gX5rhRLcHA0
2ytmxQvxixWNBA4n8gJWqqIk3Uqbsyk0LtsHezXaQz9RgyP+6Q3WT6nGP35pIRyv
BLYinLeREUlH7s6xn2Kho1wW0F2JNjxhT9MuvVH3LulWPl4UPuMtYRXR/XDTqEpD
6RMrjRqh7yNeM5retwEq3gdahOlyd6cP0EY0IZsCZTFkA55YpWL0LjdoaUFAdFVs
gwmDhWzFubk3Hb/dyZ7Y+83B3JTtHOVElgk4IW7qP8x00RQX/C6ye4YuZeq8dc/U
8tb/PVfvR/i9EdkCGokuBk+o3dnL+OT+CqLFzwvLeOF+lyQKbJ7rCxypdMpxy8JW
Gaz2ZDVU21ZurN10sDNheoTQfjEclWzmmFAJCv4QUmoLdw3EzyjSB+7GD2NqaCBb
hIm2MR7DgaUaENCFOw9ZLsUApVf2ZZSVbM27xGlppHf9fQz8VuIO7cS7zonqKFqJ
75x7sAao2pYJW7FFm2rlP1kvzSENSkwblzBrF7k6aWhUevMk0N31Qn+4ZxLMldWi
jfS1V87ksxvGRWWXxwrlfsZTKTxMTd92b5n2XYBUNsy2Q4w5/LI=
=nMht
-----END PGP SIGNATURE-----

--zwmlvwkrslhe7sks--

