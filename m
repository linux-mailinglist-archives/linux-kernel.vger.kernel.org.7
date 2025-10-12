Return-Path: <linux-kernel+bounces-849454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63F6BD0274
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 14:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E97189140D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 12:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F50B2749C4;
	Sun, 12 Oct 2025 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PK5ameuj"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A787022332E
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760273243; cv=none; b=F4etz5+Vq4QmEZYtMgusmlYRBc5v9K8vQAyHwljHdCvTeYbyUhcRi835+Q51Hss5Bq+UygkYN4x/609q+3NcwkPL31OkZ98PfcnIcnhGR9AVuDBgEYiPFeSTZTgxnTwJ1osy6uK+AflRLbbW5tguJ/tVKqjok4ui+BjAF+c0WP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760273243; c=relaxed/simple;
	bh=CBBYnJpjOU4vyevnhDhjveUxsy0q7jAyMChntHTAues=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W99+eGqJ+UViKkPGiR4fqHbodXbyelxm2VDZRbieJG1ihcnnmHYMO1nja0SbVIPWLJKptOTBVd8O9Zq0Mo4LktQxWyZQ7Hlf5/ghOlG6RhrHby9394SpPPJjm4IeOwKgNAJIurJqJSvWRxvQam958N4aWHYgVMXrMEgjYicfma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PK5ameuj; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso2602815a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 05:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760273239; x=1760878039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MhkPjWye0v/CRg6Sux+Zj23A52ehYTsrcw/cUMPqez0=;
        b=PK5ameujmujMbxqQ6De3wHRBKSHMypl381w7sTUTR1skq0II1+36/YOw36lQqnFAkT
         /XcHUZZOEA48yOS46veRxoM5YgYF3xHc5PnKlrwNwxYnwJP8P2invy4C2yAKg4uYjgiB
         XDljXNaWq7pKBL49ptnBos2UrfRqwN1Tt6/xMz6MBDivvcr5jsUHxmPyf8Fk/ZgcHybw
         K2YXQ450DbPGvwo0pAHw4DbSsHGvIffHGmKBKMiI0dLBi/fMbuZCEmGy4qxUrrt750wF
         72fOmXOfrfWLUipB/iMP98Xs5uo/mVYwmXj0I1OX8Au7boZ3Nc8bdKvbkinUnTUhUshA
         +qFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760273239; x=1760878039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhkPjWye0v/CRg6Sux+Zj23A52ehYTsrcw/cUMPqez0=;
        b=EYg9J1miGWVAn5Mow77Ml7dP+jYr3dbumGng3QNeRcMwvVrhV9kiErgWMk5Sxn2dQl
         uxIqfNpFffGEIvL08mj8T4zPUWCqcVlh0ZfY7vecoL2m9eFCTq0qrEkkMd4locJRhvq0
         sAWziuHhL8gTZJGmByaftuwe2EKkBSlYVEcWjqyQGVFqMYZnuZTtAu37bewletCgL2yd
         EEwNbm+vBGgO8wToiG20pZwo1p4XcdLVH1j2ULkc2nHhd58MbGPyaxI4i5p+OpY5vEA7
         1SZ8FahQMPeNj9OyfxTlK7V3CnhglzzWcjEd6ctlQJoH+b7z2+RiGK1vZenq8LX5LYU2
         lkzA==
X-Forwarded-Encrypted: i=1; AJvYcCV5DLaTQTvQVf0dsJlzoPrpbkVMiixrUv+hvQQ7XbDI5pwNE8CAbdb3NW6hBP+YtZlnYNHHrHvXC2K4umQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1PRbkORQiw54Ob172O6FTkS3xz+90U0mNaG/kT4+15nPsa5hs
	tCMGGKAmWXysqkQLpEB1sKuHBMlxpjOMBBgxbFbwOffsn/4iywck62bdNqf0UdcbUvg=
X-Gm-Gg: ASbGncvIR9kviYZGog76J4S+k9ymErRfQil8B+mHKky/o8EVWIUsF1TIjHKF05YMdBR
	v0wV/Tm5hLCvh4d7PizCaiS3T36m7Y0jq1jU+VYaaREi4QAkpk7DySRIc8Yb13IR5hmPNcBp1TA
	mRiX5Xqp70HlZyGm/kXDx2sYLYam8KmCO163umzcWmEW4B0KRYkILMazig9mjtciCkZnorg8lOi
	LEn3gWMOKeR2EMVZB/yJiy6uJLOWgc4McCWpKA2dyySjbrpGyKxOhNX9OVIWIRo8dbPhKPsPDA+
	RLCFStipVMGN1MIckQFSrht9ot4aAdycI2A+fDPAcFypDHTO1MdtBkZ+5PIay+zLMawTS6Cq0YD
	LdgPy2pAAvczeKRse829tXVwZGUfT5yyoTCd1HEtKnYcApg==
X-Google-Smtp-Source: AGHT+IG3Lin9fp5Y+TvdZgmG3Cp7Bgv9FLi+0botQEgTHu/FgzwkhVJoMv/Si/w+XlinrToToa/q1A==
X-Received: by 2002:a05:6402:5205:b0:634:5297:e3bc with SMTP id 4fb4d7f45d1cf-639d5b5e42bmr17124135a12.6.1760273238733;
        Sun, 12 Oct 2025 05:47:18 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63a52b1d644sm6951247a12.17.2025.10.12.05.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 05:47:17 -0700 (PDT)
Date: Sun, 12 Oct 2025 14:47:13 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>
Subject: Re: [PATCH v2] iio: adc: ad7124: fix temperature channel
Message-ID: <l6bq6yqq6iqac3jlnwhzpymbne5e2ulkupl544qlyot3po546g@5seccwwkxrns>
References: <20251010-iio-adc-ad7124-fix-temperature-channel-v2-1-b51b411faf36@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="grh6t46vmthgfam7"
Content-Disposition: inline
In-Reply-To: <20251010-iio-adc-ad7124-fix-temperature-channel-v2-1-b51b411faf36@baylibre.com>


--grh6t46vmthgfam7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] iio: adc: ad7124: fix temperature channel
MIME-Version: 1.0

Hello David,

On Fri, Oct 10, 2025 at 03:24:31PM -0500, David Lechner wrote:
> Fix temperature channel not working due to gain and offset not being
> initialized.  For channels other than the voltage ones calibration is
> skipped (which is OK).  However that results in the calibration register
> values tracked in st->channels[i].cfg all being zero.  These zeros are
> later written to hardware before a measurement is made which caused the
> raw temperature readings to be always 8388608 (0x800000).
>=20
> To fix it, we just make sure the gain and offset values are set to the
> default values and still return early without doing an internal
> calibration.
>=20
> While here, add a comment explaining why we don't bother calibrating
> the temperature channel.
>=20
> Fixes: 47036a03a303 ("iio: adc: ad7124: Implement internal calibration at=
 probe time")
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Changes in v2:
> - Improved commit message.
> - Expanded code comment.

I like both improvements, thanks!

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

--grh6t46vmthgfam7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjro04ACgkQj4D7WH0S
/k5Xfwf9HrjoGT+YGLNrvWcqiZQXyCzR+q/R7M/WDAese1yLBIs8Db7Sxje8cv0e
RHv0Xbkp9i7iIIQo9Jy2ObgS+gTDae+c1HLzGnU8J9IC4/Zyavxo/pNy/lme0C1V
4N5pDxB8vlUkh65VSvQy6JIDY9HBS/gtyNg7mrhPEZPmq7Q2J7Tm+c4HoQV0LJik
hhUX0qxv/HJCZgtEeBXkeaCzE5jx4T4RXXXm6E84HgjtLqFSvdI/4gFAy1e7A41W
/KpBFjGq9aB1gfhESiBLW9gqyjx3LDUcVWFMloeWipcXmC+1SOC3rsn6Nt8VmN5J
dmSHh+W+6EFSyY+yA7osqMvevuj9nA==
=PFQ1
-----END PGP SIGNATURE-----

--grh6t46vmthgfam7--

