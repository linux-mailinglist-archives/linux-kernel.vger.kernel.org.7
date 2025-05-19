Return-Path: <linux-kernel+bounces-654172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6318ABC4CD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 18:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CC47A1250
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 16:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8273287512;
	Mon, 19 May 2025 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Mwb4TPgw"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A98F283FDC
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672848; cv=none; b=Z4JfjDPJ3DDk1shg9BmJXpPaMKgacVESDgoBp9Ya1o4bGZym5gmhk51frA+Jkxv3eZX+z+wvW/bW2+0yF/Y8jTe4AqYhBBLdFnkZtFfLcuDZ39RzRFdskUjnjIRkX4eL7ZwGWLESaLirn0ohAU798b2to3kzFsSVAv1/0YYP/Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672848; c=relaxed/simple;
	bh=+LbGvO0IL9htaGDo2jxSFU5mMPt08NBRUB/FEzz/8sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ks6+JEO9wosOKnpCE1OuiXCMYm6nMnpKf4e5tsF/u01soXdh0xBYfTMrWwNfH9xmYuhR4JzW4Yd9AqeVIFnK3P5AkwkThuTgyChl9Okwv5xXxaoVvyihE5LYLQ/OlQgzBIopfhXrcgz1pFhRCI4qFKpaggKKWQq7+UG+DdrYpdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Mwb4TPgw; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=+LbG
	vO0IL9htaGDo2jxSFU5mMPt08NBRUB/FEzz/8sg=; b=Mwb4TPgwmkVvYu59dJJG
	iK6hZJhSxK/4JCs2ya6AfeZIgWRT4hc63ipdMhQSQcXip7pj/cwdbOqdSn0B5/8e
	3IyW/YAK+xHpV4UEMDVtASnuCCuZ9q21NXRd6wD1nzWGNODSthcgv3hBT0+GzRjq
	87osj9k4OSDrBx/0cRJw+S0ZvRFOs9+IYVUyUDNrHTEWOZI4efIsboAUjsR1Fkcf
	L98tjNdzUGasutVe+6qpDa/PX+zhUw5ehktEtMH5S+xlfc6kNQi0Canke4TTa0rT
	/ga67CpuQPEA2aS3+blhOMMuISdvu3Uztiw0ozBXzAG7UCjYtEKGrWZVtjN4A7UY
	HA==
Received: (qmail 2565292 invoked from network); 19 May 2025 18:40:42 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 May 2025 18:40:42 +0200
X-UD-Smtp-Session: l3s3148p1@8a/PyX816rRZz6uL
Date: Mon, 19 May 2025 18:40:14 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Harshal <embedkari167@gmail.com>
Cc: jdelvare@suse.com, skhan@linuxfoundation.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] docs: i2c: fix spelling mistake
Message-ID: <aCte7oUUMIYSow-z@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Harshal <embedkari167@gmail.com>, jdelvare@suse.com,
	skhan@linuxfoundation.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20250516100445.8484-1-embedkari167@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cmgRhpjTpldy9DG0"
Content-Disposition: inline
In-Reply-To: <20250516100445.8484-1-embedkari167@gmail.com>


--cmgRhpjTpldy9DG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 03:34:38PM +0530, Harshal wrote:
> fix resistors spelling in i2c-parport.rst
>=20
> Signed-off-by: Harshal <embedkari167@gmail.com>

I ended up applying a similar patch with more precise descriptions and a
full contributor name. But still, thanks and happy hacking!


--cmgRhpjTpldy9DG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmgrXu4ACgkQFA3kzBSg
KbboKw/7BhagxXCJXRmB6ajcF+qFlo257T6uCMVkdh0jpg8u0SctHvoN8AunxspO
2Q4BXzeAnxZp5yxuhH5AndXeDsO5i1DbO10P7poIXvly0l3rNoMOoyg60iFhv9MI
vnkLx7YA5CZoISu+kedx8csVHr5J9n/uZbiyHslOGo53VdoxQ/WS87wB8d1qFFEu
x2+6RnRKy1HRWrnAtA4KmltzE+3TnyOHSpbggvhA+S7u+56halkO68VMhU62pS7D
erQTfiIlnawqtJ5oBmI86Iu42QQoRyUa+UZ1gq2+8yaZYuwwS89wDcUVw6BuCqJX
jVjjanQKvm3ZJv1poEXVFPPN4evOifiVuuPDNDoDXT9e6CiELMqU1oq9EQZrAqt/
bvDLTzpr48WiqurnrY+LjKKmpu5bG+E3zFQyw3m8qPdQOqfyqAFDtS+ukipgFaun
f47ajxMeoK4UcSriQiTEkN9ktuJ47ZbYwr6k7kHwOA13RvSPvJhzFXRLJ+mP6Q9q
oBm8wtBZ81NcvP2Tok6BPxVlmwHBmx3eP74h1zo+S+PjvYx971btvg2NuY6yWLXl
x23XD0sYe/t879WIwgoDEzxEvWwOvAeF7A3c/Fswbdgw8sgYmE925GRrUoxjNua2
ER3Q6XY0UbgMvITFh2FQOmEevxDLmqGmWUW8t8FywW5l6Z9+4Z4=
=/P+d
-----END PGP SIGNATURE-----

--cmgRhpjTpldy9DG0--

