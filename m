Return-Path: <linux-kernel+bounces-871588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC755C0DB81
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8D13B4EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5739323D289;
	Mon, 27 Oct 2025 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdilJ13k"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20510230BD9
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569416; cv=none; b=CzlLzFY3/+SU0Cf6DqmYaepjpuOBtFdwj39QrU4HXDmY4NuqIH+Oui8YENSXRC4cWagSSEPMxps3ViWznGCiAW3uvK8SPcB/dkozDNBPcswUOUR/qjMVt8mec73+O/f6HTblo//+8O5HZK5cfDdfSdMPi/zVXv07X+8zDGfi2NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569416; c=relaxed/simple;
	bh=owXMmrUEulQkN2rVdVY6lyV7ab44pQVgz91FSsM7Eio=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kSYKL18KCF4FR6pv/mY1xj86O5WQaH3zUOA+iD4DnGkNhRT+e4IqtC8MaSTILJNsNP3guzwHgb8gdsNO5VrZc2Q8iT871/7e12nVxjFIDSZe1u8Ob0ty/H+doxQrFgfwFe4agrMaJHHZfKy2XPlQm4FBwqUNILv5ccvz9oUhQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdilJ13k; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-592fd97c03eso3752914e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761569412; x=1762174212; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lGLcTGux1kGK6VFWv3kDuODuaRdX7ioGDfZAgAbkDOA=;
        b=BdilJ13kLz8u6mn+ofF8A7UsmFRsEBLOX6VQkR7iavkJzRpKiVMYbVTVOvWXSEXjaJ
         ACucpnvZw6R+z1aYpEzZoGIvmz39e/lOIoxe1Eiz3LQJyhocOhYXygGmDpOU9ExVLmP6
         3jfu0ObCl1861cB5/+QoQOqLSPh0AOZUsMqaR75jRPxb0OuML2NKKQ/cBogutUCfClTl
         OWtCad4kGCwgi3WU7cT61Z2PppBRFPb2qEeoadrqTzFT2iWV6rJNOr/GsLKZPlnQ0ud0
         w5Msr2bDKxT6Wq5lSEI/2g/jOGW2KpbbyLxg8v8ZxPf4qhLGFVASyr0Ya8ZYurTqyk47
         6+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761569412; x=1762174212;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGLcTGux1kGK6VFWv3kDuODuaRdX7ioGDfZAgAbkDOA=;
        b=mwjGR2qVlny+YSOxaYaLXXbs91WyOgwCkAh43D1Sxl0EkOP/OCvOgNyWA6TZisEXZp
         iBneYzukM82SwLHFEu5iLqpI8cw7RQuMx3Pge227ovj4UOoA7tvGRQm1V8xlOWA7juJy
         q7LecrnBCY6bZP5CC0BhU3PNQIN9wdi7MoZrhM6nbrSWg/37heXKdYBlLnp1KzvX+pU5
         6LWfNPTuOph3OAEnQt08LBfw9gfUjOOOu/GXQkWlRI95tEb8pp0qKUD0qXjToWBm76mt
         I952emtGTL8/EsVTZe2qzqMKh6npWcYMJ90cuyhRdnLzx/o21rBspWWeTqdR72Ems8S+
         ueGg==
X-Forwarded-Encrypted: i=1; AJvYcCVjk1VH6jz3tK/vDJB87DLKTtescPA9d82f+DKrkdQNUGQeYPRqeC/8YpYaU/rYJ94o28J/ggXUcCFvf+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+1X1Pd5voW+cXxcyMul7QZdmlMIndyeltu3DAh1EVqkm2BRrJ
	PhcmoBhxC5Rzt/ZLD57R66P+M2cWmDQxSRJIEe+DIK4QDjld0EGKsYsv
X-Gm-Gg: ASbGncui3i3+Wdv5Ws93UV8zQPg86JccOBjc5oR33ROwhHRAsqa/MWz6pu2WiVhMlyp
	7p9BPs2pf6Gen7vBbdO6e4vzbVpU2KUcjLH7tUaB0AcVxMUD0acJMub/AqpRL76/ZQchy7w5C9M
	TcwfISl6/qTcnK2MQ6V1LXuwZIcoJfpMG4VL4tGiJw8emvUdj/2Mirh6MykICA0R5bBSTWSIPe7
	Ljj5Fh2+rG+Q2adyaOaG+BdDMh1DaeaqoEU//tqXNnL48e6i38pvFBdf05qJFeL154qQi9KsLKO
	BQ9XNg6Jy+o3aY24kgFTvJjNszTOVHd0zkgBHhfwWROvfCH0/HqZb+RDc32HV5Pjs+hD8b9OFUT
	Eyf14CCAIqLnHDi4VBlatRbNWwQDahCmpZtMmxxAhh8N85C2UbTpaKZ/nghPN0pxjKZjuquUCq7
	hkPyW1w+s=
X-Google-Smtp-Source: AGHT+IGP+TQYuhYnZerRm1alrcw337STtAJ2lCoFQRd7f1FQqiSzuno7UJBqjZ5UYTDXiT87Xmq4JQ==
X-Received: by 2002:a05:6512:3b27:b0:581:d8:a930 with SMTP id 2adb3069b0e04-591d85755dfmr12215972e87.52.1761569411934;
        Mon, 27 Oct 2025 05:50:11 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f68563sm2264179e87.67.2025.10.27.05.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:50:10 -0700 (PDT)
Date: Mon, 27 Oct 2025 14:50:07 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: accel: rohm: use regmap_reg_range()
Message-ID: <cover.1761569177.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bffzJvZ3LHWNe2DG"
Content-Disposition: inline


--bffzJvZ3LHWNe2DG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Use regmap_reg_range() when initializing regmap_range arrays

Clean-up couple of ROHM drivers which assign the reg_ranges directly.
This reduces couple of lines of code.

NOTE: Changes are compile-tested only.

---

Matti Vaittinen (2):
  iio: adc: rohm-bd79112: Use regmap_reg_range()
  iio: adc: rohm-bd79124: Use regmap_reg_range()

 drivers/iio/adc/rohm-bd79112.c | 13 ++++--------
 drivers/iio/adc/rohm-bd79124.c | 39 ++++++++--------------------------
 2 files changed, 13 insertions(+), 39 deletions(-)

--=20
2.51.0


--bffzJvZ3LHWNe2DG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmj/amwACgkQeFA3/03a
ocWtmQgAsMPzUfEy3bEHK5m1KsrSD3hzdQnnjlz4yKGzIdRBk9E9SjLfC1m4r2qu
vmw0tIO+R8jWAX3LbCaqj88mvJFaiCbFmjZM6EyfIheA4DjNL34HRizcMBqLR5Fh
V2Tq9kRv9kampBlozv4bLuaHNdTwXhvgEH/vzbilxiZPQJm+Ng8Ho6fyJgbz6zK7
Y0uKDY4OCdKlFcm7qDm6tES5SSGd5Ir5xAT+FKXIZVe88P0I2G0ZyznYlkkkPwVh
qEPUDrWbjH8OO6DXTcMzS3a5a59LbXKJlC5GBl6OsQm7IJa1983TRp580Fn+EmOM
Z2LEky/HL+7h/gLo9CyoujKsDn7bfQ==
=0V+h
-----END PGP SIGNATURE-----

--bffzJvZ3LHWNe2DG--

