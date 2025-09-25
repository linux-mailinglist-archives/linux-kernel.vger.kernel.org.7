Return-Path: <linux-kernel+bounces-832520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74382B9F8F5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C29172DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E06235362;
	Thu, 25 Sep 2025 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfZscC8p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359D4233145
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806685; cv=none; b=OZgq08wcjPc/In8ddU56ePmbrowzvBezHAee31maYXeHHJTUeiZc4czIKaCQNaEqcQWNHXMl9cAZguDCoNvqbd7xmv1xRbkbNudhdSMDEV0RPC4C+KZCcR9qnGf604PGxa4Jist4ahlGt1efxxsnD37Owi/FDGrcmQREnq/CZf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806685; c=relaxed/simple;
	bh=SX4RkyWyb0dLw63KqZpnqdjBxIDHLITsflCHJr714Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6BSSuCRxivJSiGaErvWzcSZ9ADS3jhvax+o+8BV8/vhFTU+qSp5p3ZiwtXQS68UurI+63ZZz2pIHfU6Fi+8nQzIsaQAJrmWGMSwOsXtNo21hfeoeclcEnFM2WT2hMrGMyCHgFAvf8UDbki/vdeaJXgTYFrZJrXrJUwVzWbvwTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfZscC8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFEDC4CEF0;
	Thu, 25 Sep 2025 13:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758806684;
	bh=SX4RkyWyb0dLw63KqZpnqdjBxIDHLITsflCHJr714Is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mfZscC8pFbalJeGuE/QFf3wrMZjWywowhXEIKnSTyqUgHkHYkEmE1dxGIJQUu8diN
	 ZslpGSo/fm4TRiw4mYKsvnlfJIwIuQXYdeUk0r1tnA4ZkV85HQcNyeTVVBQo3c9yzc
	 C8sbgnarZmCXyRt5Z2AD1aqeJXqwV9rmycn4YVxTJJYG6gIQgWg/mfGUK4cLevxj1b
	 5Id/Klxu1XbWPb5YGfHZrdu+ZtHmKAxGEhPFB8IfYTqcpbCyDPgjHMtKFfGxIMEVZb
	 tKXCVYVCASQ3MCiO5pjdxx438pd+wFGrVAV5XaV56KUN1XjQ43PqR/FmMgwVMDassM
	 UQG4M5C/I3eYQ==
Date: Thu, 25 Sep 2025 15:24:37 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Marco Elver <elver@google.com>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Michal Hocko <mhocko@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v1 1/3] array_size.h: Add ENDOF()
Message-ID: <kutf23ggormqot722rp5prqjaqiyrnvj6s3xcjsqsr3lomdvs7@cgdhfowymkkv>
References: <cover.1758806023.git.alx@kernel.org>
 <0b3d2fde03a0b11643d5a9bb56d7a903c58320cf.1758806023.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l4m2femru3eeu6zf"
Content-Disposition: inline
In-Reply-To: <0b3d2fde03a0b11643d5a9bb56d7a903c58320cf.1758806023.git.alx@kernel.org>


--l4m2femru3eeu6zf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Marco Elver <elver@google.com>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Michal Hocko <mhocko@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v1 1/3] array_size.h: Add ENDOF()
Message-ID: <kutf23ggormqot722rp5prqjaqiyrnvj6s3xcjsqsr3lomdvs7@cgdhfowymkkv>
References: <cover.1758806023.git.alx@kernel.org>
 <0b3d2fde03a0b11643d5a9bb56d7a903c58320cf.1758806023.git.alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <0b3d2fde03a0b11643d5a9bb56d7a903c58320cf.1758806023.git.alx@kernel.org>

On Thu, Sep 25, 2025 at 03:20:37PM +0200, Alejandro Colomar wrote:
> This macro is useful to calculate the second argument to
> sprintf_trunc_end(), avoiding off-by-one bugs.

D'oh!  This commit message needs updating.  Please amend with:

	This macro is useful to calculate the end of an array (that is,
	a pointer to one after its last element), avoiding off-by-one
	bugs.

Cheers,
Alex

>=20
> Cc: Kees Cook <kees@kernel.org>
> Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Marco Elver <elver@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> Message-ID: <37b1088dbd01a21d2f9d460aa510726119b3bcb0.1752193588.git.alx@=
kernel.org>
> ---
>  include/linux/array_size.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/include/linux/array_size.h b/include/linux/array_size.h
> index 06d7d83196ca..781bdb70d939 100644
> --- a/include/linux/array_size.h
> +++ b/include/linux/array_size.h
> @@ -10,4 +10,10 @@
>   */
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_arra=
y(arr))
> =20
> +/**
> + * ENDOF - get a pointer to one past the last element in array @a
> + * @a: array
> + */
> +#define ENDOF(a)  (a + ARRAY_SIZE(a))
> +
>  #endif  /* _LINUX_ARRAY_SIZE_H */
> --=20
> 2.51.0
>=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--l4m2femru3eeu6zf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjVQo4ACgkQ64mZXMKQ
wql8VA//dwdjf6UlSRW+nEzgZddpnQAmcWt2oroNyTcWpbIUz2CP9hQeB76fNxXV
wEr3dhPZoTr2r7to9YX/A774WAETADLGqfdtBKWhWalIqBWlNJB0tWX7M7smMd8x
34DwUFZRT3J2GIiMRLbLXYbwZRwNnlZJ7uWCxdoGWPt+sGbE6sC8JR6IuEt4rLJF
xGstRZJPeT2iIpL8mOFqOK+nxugo7a69otvCR9Bh8anrmORSqO4WYCOCQ16JNeHk
13iaF2uPWv9u1ytqsrCS0yJSitDyVx8jgdbit+NeajGtWhNsIBr+Oj7U2FX5lcF4
J6yGUTBb6vLVG2z3u5HNypUYpEbkEeoPNdE8XwhXHZp5RbUkIe8MiFg7jZtAyGeM
1fWCldC6UUI4tNbiAerTuqgT1YcavCorJ/io847GqsDXAVMMv3AyaDhNaFsHKLvO
HWu045ZSA53nYyM1e2WLk7dABreCzUnP/cKYEkZlpd3c4h+mcETIlwmEBMcXSqSz
dS1iwbrUnVEXFDZMYdGbq2EHOdTtQtGS942GfyKBh0X96BmoZ5v3S727gvR+8qzM
qTFn4fOOAWzi8fF5vuRfIZtJyb84lUCFMw0PDKGoHEyx23uF5KzRI2ba3bX6stZW
CkWIeeq+I0SVjAxd2gwM0QnZja9wCxd1jD5F+aw3pIekBf0zLxY=
=GuXf
-----END PGP SIGNATURE-----

--l4m2femru3eeu6zf--

