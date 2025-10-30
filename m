Return-Path: <linux-kernel+bounces-878086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9700C1FBDF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BA8421505
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DB8357729;
	Thu, 30 Oct 2025 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jJkOgNkM"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFAA354AFD
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822617; cv=none; b=a2NRBVMQV3SadRcxcTyGdMc+4s8q8GTW5GV7TiDNrRsGHL/V7QwDXtclijhQBriwO/igKnyg5+DKM/SNs5RcjQS8lzaCL6/v0bN4gycLd3jMJ/jMBJKNZfLvQ92jvLnrQB6Q+Den3RNGb+7V6WMiLIQdFPKhuJ68+xo1Vj6mIQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822617; c=relaxed/simple;
	bh=srpFniX3yl7JxiR0/frqTk4AVmEfCdSV1AkSd+7s0no=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i0bwCCJlAysDizuDX5qCXlLJhqxWfnWHkIHLeg9GV8axSItKBlqVBGSwOv4jDQmdopZU6+rgewKK+mlMaeuKdXro3ujn/WzRjNf5hZgdrLMYXmhwLtjFiQ9kS20upHUgH/9Z+WvldI6uKhoSUyZfEmFpjpsrIiHp1jHk73X9cMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jJkOgNkM; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63e076e24f2so1728017a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761822613; x=1762427413; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srpFniX3yl7JxiR0/frqTk4AVmEfCdSV1AkSd+7s0no=;
        b=jJkOgNkM37ov1uf1tsRx8IAXQGFOVSNtu6YUwaPFs9vh+a9/6bZksfGrcvI2GvxdaR
         hxkcq+GxU8CqdCYr/B7GbRpC+/twoiLW7637SpWcTw7rgOYbkSFOz5RY13Oi2NFpmmBw
         oB0WxQKwczAnyRce/1kK8ZWXPe77jStM4Ika74K4k/8i1XAffePM8004r5won5QRXG+M
         UnXc3ZzczWiG4KxlybShSYEGvugDva/SVfAJfsC8Bg/72GUYxTmNhyiJTZGffzbOBVSg
         IpGmgNSmy6mMX5GUkswRuI93TXFu6qZBvWZ6EXF18i1SW5mQyX5cJWkfjNZm/Vr86RvZ
         ba4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761822613; x=1762427413;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=srpFniX3yl7JxiR0/frqTk4AVmEfCdSV1AkSd+7s0no=;
        b=EtriK7y6t/qZ8JK4fv5Dhw+W5NKLBdX07LkxMw8cv18n/hQM3/1MU4X56fHvsARxqZ
         V0LmKjNgf6vonP2rgPZTifs6mGjO01P7KSycZRAxnyQMz8Py7pY8l510XGTSIPxIEEGK
         i5E1Om0YpJthuaQ6CyyAHlYLllANUpJzWojGg1rN/Hhb82wcV9j17tb4Yy5Z1eEP2ktG
         EjQNw35P5R1cpuBPYM3fn2ZaQaMSXql36XdkCTaTR5brZDASKyND0uZiZEWHgrKYZ39d
         IrpDKzdh6oAmF/r90PC/Ex8DWPOGO3pBBlk3Fqck6DondIbFKl6NR/wN6O93nDLhAA5Q
         vPlw==
X-Forwarded-Encrypted: i=1; AJvYcCXboDmtkEiNWJK7wlq8OQrukYTptHsy7pPz5/4AL7Cxmzagt1Wtl3VwhHmIPFh83Q8CoidEMXNYQUBxVgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiHr4i+DjGpaNmx7I7Uymf1SGsh2x+Zur2qjkaGc5/bFo0wX02
	5Mew4gSTH26F5cwhd9DddJlObSuKymXr2Ztq+20yfbcDpcAbpDU0NnGgZY2tmyv9R2E=
X-Gm-Gg: ASbGncsi3Qi/0p0z6tDt0tbdr5mNNbxFLKu/O5/Fo1O8yp4oLTp4lfnSVPspOQQqYZ9
	dZdRaxwBepzLlHft+tlZBbADPMOPwQFoKPh4JqCxFqy0Cqhhal/udtl9IS6+LRjlSehndZL7V91
	6QWTiKiQn+K+zwiCHbGdkIJbveIJKM548ZzlyHhUNDQQwMcaPVE72IwUs4Idkk039O53X2Sw3I3
	iXk/uo+D1KVsTu9NzmcJYEDq6P+RfbNhey+kgtpBd5OpdlXzPzl1ESzivIfVJrZVrrn9y4VLwdk
	L5PG0ngOFDX6dWPJeI3miFXJ2qFoy9ePWHQokyLQvEuXFWZRosPQYuB8g57F/ccV+BOzsodgx8z
	jK9SWIbFG/nxruJ4RkeD0QmoIJKHeEb2TekTexW3692Xe0a7sLUSM7O/qTiaPqu2XDPz7FZhV2a
	LwtTLxJOB12EQqBDJka4u3rSRLt2cS2PtXzBn99Q==
X-Google-Smtp-Source: AGHT+IEMy6Q1oVfCA7kOHufpyRMQfxrT03VvOtfa8ULh72vNR7/VOPlqHgk5byrCPbPiO9mnD2vGiQ==
X-Received: by 2002:a05:6402:1e91:b0:63e:1354:d9bd with SMTP id 4fb4d7f45d1cf-640619de97dmr2509958a12.8.1761822613380;
        Thu, 30 Oct 2025 04:10:13 -0700 (PDT)
Received: from [10.203.83.89] (mob-176-247-57-96.net.vodafone.it. [176.247.57.96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64068f74a56sm1233507a12.15.2025.10.30.04.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:10:12 -0700 (PDT)
Message-ID: <32a7741bc568243c8a19d691b922d9a8c2cba429.camel@baylibre.com>
Subject: Re: [PATCH 6/9] iio: imu: st_lsm6dsx: remove event_threshold field
 from hw struct
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 30 Oct 2025 12:10:08 +0100
In-Reply-To: <aQMbb6BUBHQUXX9y@smile.fi.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
	 <20251030072752.349633-7-flavra@baylibre.com>
	 <aQMbb6BUBHQUXX9y@smile.fi.intel.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-YXdLMjj7ZYMrUjIedbVD"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-YXdLMjj7ZYMrUjIedbVD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-10-30 at 10:01 +0200, Andy Shevchenko wrote:
> On Thu, Oct 30, 2025 at 08:27:49AM +0100, Francesco Lavra wrote:
> > This field is used to store the wakeup event detection threshold
> > value. When adding support for more event types, some of which may
> > have different threshold values for different axes, storing all
> > threshold values for all event sources would be cumbersome. Thus,
> > remove this field altogether, and read the currently configured
> > value from the sensor when requested by userspace.
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*val =3D (data & reg->mask) =
>> __ffs(reg->mask);
>=20
> Seems like yet another candidate for field_get() macro.

FIELD_GET() can only be used with compile-time constant masks.
And apparently this is the case with u8_get_bits() too, because you get a
"bad bitfield mask" compiler error if you try to use u8_get_bits().

--=-YXdLMjj7ZYMrUjIedbVD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmkDR5AACgkQ7fE7c86U
Nl8VpQv7BsnACu5vGi6B5cv0RtJ1W/zSm50gIbZxC+n35KVqE0w+ptS7Pn+Wv1Gc
0Mj4V71N8yVjV2TalJizvbMRqeT3qt/EcwHxYzYGIUFDs9/deEAViC3Tn0oWFwSM
2R3iYC39CBvUGj6olHka775YrfRHuCK1wmPQE2Axo3+36YisXvrgNPOBiJDHktpg
1fjrkMAiUHZx8gXSk+rkhzGzYEJKlH1raTeZGUD1n5WKBFYkK5KoIiv0vAbjrrem
Ztrcuem+6BzzkM11p3LM8uoYMjF7l7ohpoP77umdNia5Hxq3fiGLPtsrkfVM24iq
KxCy9pl5N9Mkn4bAW6aTjI6ypMAWbiZczrfegr5n3SWU6PUzU+izs+5nG9d3D+kK
JCEcNyCT0Z45ee5P46UWRQxhhZlQ6RMsuoCoRWnfqcLeZagltkeeZ9niAx/LVTAC
TaH062TFCUq6eKUmCvEHzqncWLaMy0baoKCjgw4vd8fgo6zXsb1gXNNc3+5r2oOm
uun5pL9o
=mtTm
-----END PGP SIGNATURE-----

--=-YXdLMjj7ZYMrUjIedbVD--

