Return-Path: <linux-kernel+bounces-859395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBC3BED7FA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 20:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A316F405B9F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 18:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD62627A12D;
	Sat, 18 Oct 2025 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LcfooaHr"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE5C21CA0D
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760813751; cv=none; b=NbqjdtLiUkKEvXMTGTGUQIuOEBt248qCDN40rd0Biy5fppWNp1ys5VLfGTIRZvN+E+w9yNJJBLqK8v3S2KH+0joM3eyupEg8SEhoY2LLlRBearWpT9FfmqUTKjmv/jcXkNCk5E1XOUb96WW1tXZLfBuZDwAeD48KdfDk+RWY3Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760813751; c=relaxed/simple;
	bh=KnqOHVF7mxydtC1tf2E/ukwvy4QzPm/w1bnmxxXfVq0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qq2tsHN2HQ+kWeHm5JfSYFc1Rzb2u03lC3vSUNIyWR0mMJ7CRSeHDSrGmQ8KSX++bLeejDEgu5rdSKhI/eROwE8ZbPQ7w5XdWwytZqyriozSTzE2af6nuhmIYec9bDBoxCHEP0oIBvKOd7tHv3P/SPeJhzx4GVMVRa0a7g3SNzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LcfooaHr; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so2397562a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 11:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760813746; x=1761418546; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnqOHVF7mxydtC1tf2E/ukwvy4QzPm/w1bnmxxXfVq0=;
        b=LcfooaHr6vgoKGNrJyM3ioJ8lZETXYSK//m1J6tFXJ8KdeTS+BF8JGtPOTuELNSCuv
         YEj+NcVMTZIIQPLZW8s8SaDSkEV6EboTw2NepXCBhVQGtcGdnzodLcuv8/9LHem1NzOu
         XcaJD8zkGykLKo/MIeuyDCCMdtojlxedMje8OrCD61v8tCXHeU+x+Fgyw8KX2CGbqxp7
         NfPpL95ecTAdRoDFfmoj5IBPzfpMjtVvvNW9tZ2De+968Z2I2LxgZ+c6VxSjPE/PrkCQ
         izW9rP4K/P4jFQEf2i7gtncZ+N9KzZkNy3860evs4zcwkUNKylxnTrhiSiYyMRc9h7nP
         xV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760813746; x=1761418546;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KnqOHVF7mxydtC1tf2E/ukwvy4QzPm/w1bnmxxXfVq0=;
        b=l2U3SgzVYbXBL+C+cgPn1Kgcexsl1vswmRCpnJBT7bDZ+qlP3AooHoEJeYGH+33zwt
         hlDMUxCKhaUAImgfLnueRyjYTfqZzg1wQ0gmb/se55Ji+aT+bHNzCnOn3Ejw2nXzI9GD
         kS1tvjeISVxmeWmtK14U3mNSrUX/Vp2n274Aus4K1Ag6IrxN+8+x4QmCplXON9fYUQDD
         s9Tlmy77JqG9iyRv81+tPPtKQ151c6u6WWnQGI+PCcsSWT3vjjzi6EfeBplNJA/+H+2w
         jddkHiabFjyQ/MLPb4YDQD5Lc8qpMuuT9vn4f+SHO9QA+DEuP/9m0nv8swNQSvTe60hc
         36JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhsDEqAMZ3FcaLXxhMkSH04oVb6dTRvmyC6x7mnfS36ortxrlFWaaSKtoakUzWKI3KQiEFZ44TxFZb7vI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB3ylQGg/t//7oH+G/I7Okf+6eIcUXIvg/tmJAF42qumviy6PU
	rHOkVBzlEtXAFWWpD0Jm8LccgXWYJ+5buem1F3YnpVWkcH0M61+IOuXlyqThbL4qSxk=
X-Gm-Gg: ASbGncvJzQR1mxyzK6hf+I94TNIf+YZ2mpavwG8vF7h42uz/D6tno02IrkprydG3Dyl
	BNrDBZe4suxT5+aHA7YdydsQtBapBHOtMy+dOX9csUnAVPhHUtTWoh91K8g5/bXSqPoeHcCmBAl
	HTkpcdicGF/Pij1f0Yj1jlqkLGDHQVhehJToaHpXc1zC/u6nMrjN1A1Mp7ZQgNAbcaa+isywaAN
	zFIPaSwZExU0oxzgQS8nMMzsl3HMXDVPbx5QK1iETnqr0ro2RsGQMfZx7L0GeSKlvPItvzltz+R
	jwS8+WCqbQHmMqHIJ4tXpShoFFTaFAxKcJ3eJqYOHzUu/rqqThJWLS4r3lL2jxNKHNuR9o8cpAy
	EX3J60P7yt/Mh+EwaVmTs76EN+ziVqri62gPhdRm+qs8y9ddX1CxiJgsOLOZ0PtORIcy6MEpwh8
	zrhNpEgYX/sCJ3aiES2Q7QN6qCPTlUniYLEIdqK6e9vgGRb0FmZaG6
X-Google-Smtp-Source: AGHT+IFq3EZn9lNvjOiy5AW8Eyzrqv6jxyoa+a9idWvwFRf2zmWDAQd+B8XvHOKyUYsr6SZa2QCzrQ==
X-Received: by 2002:a05:6402:278a:b0:628:7716:357c with SMTP id 4fb4d7f45d1cf-63c1f6e513fmr6997724a12.25.1760813746464;
        Sat, 18 Oct 2025 11:55:46 -0700 (PDT)
Received: from [10.203.83.237] (mob-176-247-37-226.net.vodafone.it. [176.247.37.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c58320842sm1444915a12.22.2025.10.18.11.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 11:55:45 -0700 (PDT)
Message-ID: <41f72463394e5e9110f5c889049e9592d3a8efa8.camel@baylibre.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix array size for
 st_lsm6dsx_settings fields
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 18 Oct 2025 20:55:40 +0200
In-Reply-To: <aPPOu431u8MPUN0p@smile.fi.intel.com>
References: <20251017173208.1261990-1-flavra@baylibre.com>
	 <aPPOu431u8MPUN0p@smile.fi.intel.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-a6v3PjjMJW06K0heS6lu"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-a6v3PjjMJW06K0heS6lu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2025-10-18 at 20:30 +0300, Andy Shevchenko wrote:
> On Fri, Oct 17, 2025 at 07:32:08PM +0200, Francesco Lavra wrote:
> > The `decimator` and `batch` fields of struct st_lsm6dsx_settings
> > are arrays indexed by sensor type, not by sensor hardware
> > identifier; moreover, the `batch` field is only used for the
> > accelerometer and gyroscope.
> > Change the array size for `decimator` from ST_LSM6DSX_MAX_ID to
> > ST_LSM6DSX_ID_MAX, and change the array size for `batch` from
> > ST_LSM6DSX_MAX_ID to 2; move the enum st_lsm6dsx_sensor_id
> > definition so that the ST_LSM6DSX_ID_MAX value is usable within
> > the struct st_lsm6dsx_settings definition.
>=20
> ...
>=20
> > +enum st_lsm6dsx_sensor_id {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ST_LSM6DSX_ID_GYRO,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ST_LSM6DSX_ID_ACC,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ST_LSM6DSX_ID_EXT0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ST_LSM6DSX_ID_EXT1,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ST_LSM6DSX_ID_EXT2,
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ST_LSM6DSX_ID_MAX,
>=20
> Is it a termination entry? (Looks like that to me) Can we drop trailing
> comma
> while at it?

Yes, it's a termination entry, I will drop the trailing comma.

> > +};

--=-a6v3PjjMJW06K0heS6lu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmjz4qwACgkQ7fE7c86U
Nl9mSgv+NJB88dUdy9TmKxhAapf8e+6vde+0VNX2XFNvWqi62if1oagntf1sRFUg
7Ynwb7vvH1y/B4/I/Ef/irknoq4rg5ZwWf7q+SWu7ZtSQ0uaZWJXivibn0154Xhe
wAsrpitQDFoYh//P47sq5ANBdrKIGXYGpXxm3TjXJkva0dnl6uG0Mfs3J6bDbf0P
ycvEtGtF41RmF5v6diBkEDImt4Je0YYw8eLRWxlqPZDqs9BiYhcn8C78ReZuQ9WS
YBLK+3nFWQk5Yi/E/Ol8iD4nGcAgvKlU4JnU/CAoKjSzhmgi3/59g+smIkFfthSe
/eofoMUPY+rlQUK/HPBuHQpR08ItZYn+Nl7pJRc93y6xGVUTjIpJvihDAGZHZTTu
prpQnxhfStDC25NxEb+0I/856DJnsJb/hR/lZaRBSA7Oa7nHBzwKHM9oHGGeAYEs
07dbrQvG1KcvCDXq17Q5Ut0fpSHr/V3vbRuXu2HqXan0aFyr4zfr8v/xpo2oZqud
zf9bO42B
=+zej
-----END PGP SIGNATURE-----

--=-a6v3PjjMJW06K0heS6lu--

