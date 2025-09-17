Return-Path: <linux-kernel+bounces-820712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 602A9B7E7A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6831BC5775
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AE4323416;
	Wed, 17 Sep 2025 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xl0pRa4B"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F9A2FBDFF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113251; cv=none; b=adV++IPuOg3OjC4h7KcBx/KT6ba1lDLnZLdex0KXcUdw4hmFRclMRAh8IO/FHJgehdj2QqY/y+wtqQOkAfQYO+U63VmjxW9BZ6Sl7Jj0f5/9J5jFO1URqDl9DiKW5amlL9PkBxpATqA0Md3bBpczdTb+mcnLQEB7CX4dFSwZil4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113251; c=relaxed/simple;
	bh=OpFjrz8zqyAOuDDEavL83RJ8Trpvvw84g1TSZSRsq/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K28jvXqpd5R58ugRQcv+MNhZdWraaT1ZgVUf45ES5tYnstzyhg0M13wowPvkxdOFHGaHi/QSv3mAI4LZJt0ouLDU/fsBHiFuYWY1P9yx0XBa+7m2n9c1O2NUz7oDA8093szTxR796spNZ07/Iwa9sww3L4Ghv3DfLOpDH1BQlbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xl0pRa4B; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b0787fc3008so937263966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758113246; x=1758718046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OpFjrz8zqyAOuDDEavL83RJ8Trpvvw84g1TSZSRsq/o=;
        b=xl0pRa4BIirS0C0dFTJ/dW+xk8U5t6HlNa1G/ySOuv+k0h/p7O4dLGjFTF/MGExHAW
         TPzml1vDfNLBlCqwa/UBJwzmgP2Sdy83nOUA8zBHQtqIazy0D2PaM2A3RPhLlXcr/BKr
         DG2HJ6bFsq2b6395UWCEjRYKyqmw0xFNcBzKYnfxRYQbd0uyglQZ98AtCHVCL1qQm3gz
         tiTvJPReFqvyGJKGAOmnPEd4bnpdA+9+pFXcclg3XCyYKXe+SiAH4Jnl5J28WPE5DEUs
         n0IPqIvc4z9rDp835TH3OafrV66TqAtQBZeChXtqORbqLLoDXt4HWcy1vXkfPF6NX6fh
         lpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758113246; x=1758718046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpFjrz8zqyAOuDDEavL83RJ8Trpvvw84g1TSZSRsq/o=;
        b=PJHxO3TLGHiBXywHmkBYiAElArPqy6RFWXJC9oSmI9wmbyCFrsUw5EP72bxKTgawiR
         RTVuwTE/DysaulDObD1OZyAJVBJNp4fdipGvHOKfhZAmlw7YF/KmHuQgbte19Or3aXfD
         yKANUQYp1sx0NKoCGEyS9eHJoyLOGWxr4d9woWK4q+vg6RJ0BeIO3/7+4o+sy53KkuOB
         DS0K/lm/2rn07AHzYd7/QyAzKn2I05iBcG+sFfgq8/aCya3AXxCOb+Kfjy0yB/R5mdM2
         qgIPf4Zo0ojj1mrYW06+2o7uwRM+qlOXAuPSFQaktnKP3uMV7GUrZs6N/JD7Fh3qx041
         pndA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ6K9kaK2RuPQZBaTiSe05l0rYQHBrGrmsh/EBQ1mpsXfrUVNsSa8PAdxatP3r4R/H3KFLAShM5UwXVac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQotGKCQ5GGyX0E09lZIJ1tOHJu7IP+G1jMa/HfsQlth5t2718
	4W5M/sCM6d5A+9nENNQ+DxzGBpuJregLu03+6NEb3RvnF/k2wXuEJiHbmvY4v+7In1o=
X-Gm-Gg: ASbGnctkl/EcIKdXOcMkKyjOwei68ghdiCiU3bZKE8T4CJLyHhPu8UuqK8TckQSKMp8
	KLrfwTQIOjQEwsbotJdZBGxq6pU+p223/NyOs150+j6UPTQcxG2q5rzIA95tzrIbhlDMUx577qd
	+vMU8Wg/6+kBsDbEjGE0MEG4pxOKtlKt2IAUme4XlE5btRPtYi/YMU/0uGFnKn54mprG47DhQIe
	1jX/MzjJPpn4+aZ3MN9CcaIcLMkivi7/s3Paf1Xy498wD0bZyf9tCskmaU3J2ZSTL2Hm6EeuN0v
	rsgqOBE6p1RqjyURYZg4vmalXqRd7/oRWdM7CHF70hP8GtUpT9u1F2pN5aaqSn1uQ7h9mSBTT+Y
	5aB4ASaQAPYtWH09imy0WoLpr97M=
X-Google-Smtp-Source: AGHT+IHgG+feaLFS5lYK61xigE0As4f8SIEZukBQyUiZyyvMqVLGwJC7y1Bl5VWs3fMe9SZIDZZJTw==
X-Received: by 2002:a17:906:f591:b0:b07:c905:af33 with SMTP id a640c23a62f3a-b1bc02f669dmr228527266b.65.1758113246285;
        Wed, 17 Sep 2025 05:47:26 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b30da289sm1339567666b.17.2025.09.17.05.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:47:25 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:47:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, 
	srini@kernel.org, vkoul@kernel.org, kishon@kernel.org, sre@kernel.org, 
	krzysztof.kozlowski@linaro.org, linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	kernel@collabora.com, wenst@chromium.org, casey.connolly@linaro.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <er7dkmzutsu3ooegeihjzngi6l3hol5iaohecr3n5bolfse3tj@xeedlx2utwym>
References: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
 <20250916084445.96621-3-angelogioacchino.delregno@collabora.com>
 <t3uk3k4h3l53yajoe3xog2njmdn3jhkmdphv3c4wnpvcqniz4n@opgigzazycot>
 <aMlnp4x-1MUoModr@smile.fi.intel.com>
 <mknxgesog6aghc6cjzm63g63zqbqvysxf6ktmnbrbtafervveg@uoiohk3yclso>
 <CAHp75Vf7KrsN7Ec9zOvJoRuKvkbrJ5sMv7pVv6+88tPX-j_9ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ah6qgcyytq6i6rrs"
Content-Disposition: inline
In-Reply-To: <CAHp75Vf7KrsN7Ec9zOvJoRuKvkbrJ5sMv7pVv6+88tPX-j_9ZA@mail.gmail.com>


--ah6qgcyytq6i6rrs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
MIME-Version: 1.0

Hello Andy,

On Tue, Sep 16, 2025 at 07:20:20PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 16, 2025 at 6:11=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > On Tue, Sep 16, 2025 at 04:35:35PM +0300, Andy Shevchenko wrote:
> > > On Tue, Sep 16, 2025 at 03:24:56PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > On Tue, Sep 16, 2025 at 10:44:40AM +0200, AngeloGioacchino Del Regn=
o wrote:
>=20
> ...
>=20
> > > > > +MODULE_IMPORT_NS("SPMI");
> > > >
> > > > If it's exactly the files that #include <linux/spmi.h> should have =
that
> > > > namespace import, you can put the MODULE_IMPORT_NS into that header.
> > >
> > > Which makes anyone to import namespace even if they just want to use =
some types
> > > out of the header.
> >
> > Notice that I carefully formulated my suggestion to cope for this case.
>=20
> And I carefully answered.

I tend to disagree. If that anyone only wants some type from the header
but not the namespace, the if part of my statement isn't given any more.
Still your reply felt like objection while logically it's not.

> Your proposal won't prevent _other_ files to
> use the same header in the future without needing a namespace to be
> imported.

Oh yes. But that's true for every change: If you change it further you
have to cope for what is already there.

> > > This is not good solution generally speaking. Also this will
> > > diminish one of the purposes of _NS variants of MODULE*/EXPORT*, i.e.=
 make it
> > > invisible that some of the code may become an abuser of the API just =
by someone
> > > include the header (for a reason or by a mistake).
> >
> > Yeah, opinions differ. In my eyes it's quite elegant.
>=20
> It's not a pure opinion,

That's your opinion :-)

> it has a technical background that I
> explained. The explicit usage of MODULE_IMPORT_NS() is better than
> some header somewhere that might even be included by another and be
> proxied to the code that doesn't need / want to have this namespace to
> be present. Puting MODULE_IMPORT_NS() into a _header_ is a minefield
> for the future.

Well, for a deliberate abuser the hurdle to have to add the explicit
MODULE_IMPORT_NS() isn't that big. And a mistaken abuser won't explode,
just generate a few bytes overhead that can be fixed when noticed.

In my opinion that is an ok cost for the added elegance.

Best regards
Uwe

--ah6qgcyytq6i6rrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjKrdcACgkQj4D7WH0S
/k5EEgf8CdFx6+6iEV1AE4GeSJAKaBL6T9A2o7N08nLq8lg9b0873yxBoHXcU5fC
aJjF55sEwR98xGntE7kk39pH49RCG8ugwvBfJUnq75LJiKU4gyhg9P3OPFnLShiJ
I6m5bqGNDlAwq3dSuYSiDSr/4wi/Rq4mPKqRZoCT0WHQz9CWes6CdQPuRMSKYeJF
5VvswQqZGx5s73s0oi9UinWZ1/t/tX8KTjVeEgkmosNDtXb8rSwQbmfIUqnuCv0m
ZjvuFwKtei8Q90Ro1LSW+QP0R1bN1ydWluw6cGH65qE7Yqpb/P49Yupan3C0YEsr
nJJjRh4HIIADYdzeEZWvvrOcN8LC8Q==
=NvWc
-----END PGP SIGNATURE-----

--ah6qgcyytq6i6rrs--

