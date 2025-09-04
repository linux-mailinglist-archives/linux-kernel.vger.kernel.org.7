Return-Path: <linux-kernel+bounces-800460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD462B437E3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46AE21B23721
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A868C2EC567;
	Thu,  4 Sep 2025 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqkL1uLt"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BFA29AAEA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980289; cv=none; b=dCcOsuqIJqPvE1fG7CIl3qLnvZV4UhjoWYYFAaToulpTzbe0kYECV664vbbYAhIBKUBHk4NJnIb3LYREiAWvu7fYhWrcFWT3hfn6BFQaaRHjNzwRQU+z8M9VeOI3nn3aPoV5/Ew7P6WZeP0E/JMmWUmWxSuYhKtASlGibsQoa2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980289; c=relaxed/simple;
	bh=UwZNvRadpxpxIRVf3m84OtosJaq4M967tWbwpaNg/Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8Yn8VmSNPM9aYEw1lQnf7DvlgKN2XXoVBVjle12m3DwFpo7ieadvH6jiS3FYuKhuWs+BJkt8maVszzTrm1+3tfHU9IjBYXoSXqtA8gBDth5GyrXGNVNGZqYmd1giizQi9/f5Vzz9m76n7tf8QO3iOKp81cENcJ+PA/TxI6LH2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqkL1uLt; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77263a06618so135038b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 03:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756980287; x=1757585087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UwZNvRadpxpxIRVf3m84OtosJaq4M967tWbwpaNg/Xk=;
        b=aqkL1uLtP+uZjVynqHy2IuHnzwE6U38zMQCnL+CCztoTONLvmKuoO+0gH26AOZP8hw
         CoVljzMi9BfbqhTh7pTej5WTplV108FHAIAlP+37xcfIbtXHi06h5tVyKkNUGN9rFJCv
         7ZbwpNxBd7XT4+NwCktwJ3Jb4M7XKp1EaJtAqbYVmNfCVZgOPTZjShoSESDha3rp1Xj1
         iycSEV4/nf+3459t5SIArCRFM2GIho0Mg+Oqscuq78Ha3syV/l5d1sCwSVkU6Z85E1FE
         Fme5abrcsDVz/8aqa+JGGIBLe5Q/2G0Za/tPv65hRlNJHqNEv71wCXe342B/CNTRKftS
         fQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756980287; x=1757585087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwZNvRadpxpxIRVf3m84OtosJaq4M967tWbwpaNg/Xk=;
        b=Jd7VKdAgSw03S7DyL9AJitMwlBNhAfyv4uNXl82zrj2s/ggg0k+e5qkvZ3PlUdIQ8n
         YlAlQOXO62e+E2AODHfkjjlwCzWJGmX4VOujChq2sFgnikcMIpJnVFcg+HvugHSJpMLs
         U8e+oLw7XZ01tZQ4f8Xh+6407qbygf23NTIj2rmot80syvB+VQEaYYJTvFv4a+eIJbUd
         cREvgXt/jDgvTa0w0Fj7Qb5zyHr0ZZwjNG7ti5leoeoRTIDm8ocLlN98n9rtcfOuoQ/y
         a2dzvSQQ9JYpAED6mDsZaZV+PNXpzt8V5poYDxst6VJl2sSlZOk5osheQcUHm3sfKbIn
         7YBw==
X-Gm-Message-State: AOJu0YwLycb6pSdO+myqEiANocb3tmyf8DoDHxVZCyGC6/rN/CXQa8j0
	u71aV8z5+cjmkbrMd7xv5lh7i/Vyird8YVX9Ezyh3ddzIJo6CBzky6oz
X-Gm-Gg: ASbGnctb3flY4yjBrhwGMmRsR8mKUGvvsnzFsZ6WH10sZS+nvydAO0i56bR+1VMMgIX
	tgTAMIVPPCiVrP/d9SP55BDyc31rdA/4LUMAPMYC/BP56nOHDpcZBThRkp+kWMa6nzO5AP4ofWu
	fynvK/S7IP/oewCbA86dMYBXN6IzXoUofGTHYxIYJGcmAIf1oYXDVFW7yJAFb8MKhzUkZCtBY8o
	8jZPPvGO3lA1IedxYkwY1fNT+lwySFaKPrKwgwQk9pumU5dMC+LOiXsoe27OcAqARSEMSsVNVo6
	i5wqtzkMfKw0+Ld5qTBPFN/i3c5k7rvJi+/BWlhjNPeWZcY6eaehiB1n3JVJ/GCdbLXV1ZtfJmJ
	MxoCKWtKGE1J4PZdjDBDK6rdmJwggYI0=
X-Google-Smtp-Source: AGHT+IF+X1SXhSvLsR2STae5B7BzOvXd3uYUXi34g9hAOLpClEHMDf7lkVlOfzMYCE6WICcwBjc7Ww==
X-Received: by 2002:a05:6a20:244c:b0:240:a2fb:f8b4 with SMTP id adf61e73a8af0-243c832443fmr17655871637.1.1756980286943;
        Thu, 04 Sep 2025 03:04:46 -0700 (PDT)
Received: from hobbes ([2600:70ff:f833:0:8e07:c9e8:902c:6ffa])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28ad188sm16564555a12.26.2025.09.04.03.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 03:04:45 -0700 (PDT)
Date: Thu, 4 Sep 2025 00:04:40 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] fork: simplify overcomplicated if conditions
Message-ID: <ka3dhrfkc42ydbiiqa4ygr545ndydcpekjco36sdwf2nypuy33@vpsgevacmzjv>
References: <357638f71edc7f1d9814b1851a64e09a8895bffc.1756968204.git.joeypabalinas@gmail.com>
 <tzjq757k4tt7k2mkcapttjuax6zgzr3nl7ivusuvxfmok5kvb4@vub2gw7vp7vu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ymzzeawwxc2g3zor"
Content-Disposition: inline
In-Reply-To: <tzjq757k4tt7k2mkcapttjuax6zgzr3nl7ivusuvxfmok5kvb4@vub2gw7vp7vu>


--ymzzeawwxc2g3zor
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] fork: simplify overcomplicated if conditions
MIME-Version: 1.0

On Thu, Sep 04, 2025 at 10:56:44AM +0100, Kiryl Shutsemau wrote:
> On Wed, Sep 03, 2025 at 08:46:29PM -1000, Joey Pabalinas wrote:
> > Since `((a & (b|c)) =3D=3D (b|c))` is the same thing as `(a & (b|c))`, =
use
> > the second version which is simpler.
>=20
> Huh? No it is not the same thing.
>=20
> a =3D 1;
> b =3D 1;
> c =3D 2;
>=20
> (a & (b|c)) is 1 which is true.
> ((a & (b|c)) =3D=3D (b|c)) is false.

Ah, you are right. My mistake.

--=20
Cheers,
Joey Pabalinas

--ymzzeawwxc2g3zor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEx6b1SGGPTKxTmPDYqoHu9CTxowIFAmi5ZDgACgkQqoHu9CTx
owLh+w//U4ZIZrFjLogDei6exnHDOuFwna9rLLOTeaNNuCkYQ/bYafNjDKPxGRiG
8G8+8Zp5E8ikB+OjsL9Hv5QlOEcSd/d/iDg0Gz7WP5QqWj40zn9i4RD1mKyOPRvk
n856U0I63VRyihPXU9HfxD10hEkK4HY+B+6u68qt3MYom7imTqWWNJEEkdeHYhUV
U/80q7aLhADIPwdI+dimNX5vy2GPZ0NDhPnuBgHev6dyhSBypbaGTY5Obluwa4qJ
b8aTS9mD5gj1ig2W3P4LJWZQcarTxgC0Qgqtndwil5gta8Fsdwm6xhpMa6WKwXda
F8YeUzc1QzWFp4OFsOcGHdLikesUGFQvkq1Dyolq3HIvkZWYJoRsXi0Y3hynvldc
GKG64E1mbHd7u6l8pHTGPjgstUyji3IuUGLrz17hST5lO7SXKcq4SuEtquA/2Fnu
QHtlXmD3g9Jp42A6k9FRBjpdTV06KxMZK+aFpSOgaa2pgOJYJB5XkjvlByBlWWez
M6ujDIyXC4DryasgAAUhDK4w9wd9VporBa6dlWqmxVRE1QJgmOjqlEVjstQK2Psq
IbUQt1UZaJ3KoQulTcQjKJVUjCstQ3sL6M92iSvt2dqvJ1US6TB8t5QQthrh+wGn
k1abKf4f+8MxDnzmgKBkF5psz+dFfjlI8QWXBWEInRsYBBIJSEk=
=zIT4
-----END PGP SIGNATURE-----

--ymzzeawwxc2g3zor--

