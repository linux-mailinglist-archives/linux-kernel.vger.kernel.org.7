Return-Path: <linux-kernel+bounces-871487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E00C0D6C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BE254E1825
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2963002B0;
	Mon, 27 Oct 2025 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UO3Rs6Ki"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC22B2F618F
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567135; cv=none; b=YJ0dEOvBrMHiL8AGR9HfDcLNFux83mUhLHf8P+EiCxsszoUBbZciNF7OYNhAf8ATuAXZ7QLDzh58Gh3wZdTrSK7mC4tDay160BXgzkj6Hrr99yYZo2Z2UEND63nBJBG0Tvo1Zj/GOSmuzJjclrgBPY6FKc1LiaY6rypz71ipF4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567135; c=relaxed/simple;
	bh=neRVK38tIywa27dnhQPyLnP9IAAEQzuLZr/+gAVv1sM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZutRlET/0aN4VZ7st6w2kZ3C+L9DsDopgkObMohnYUnvuEs7ir+M+kFN5FhuoYWxTIswH3tGixnry6OB9DSCTPmdKx0DcpWLxVJscxE7b8+88xeUrzYTACOL8B4aV4Te0hNSGX4b63jfGZOy6M+x3L8mf9ffxSxPcxnVVKbIFHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UO3Rs6Ki; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57f0aa38aadso5391254e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761567132; x=1762171932; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1K6xkbSLXCZfpQRV3G8+Fp5c6I0KD/SmqImBeUSbSlI=;
        b=UO3Rs6Kisp4G5cnjYExwCVFbWpCA4UF6Su5mxFdmKn4lmwDvKyeOOmb/p4fc4wRPrW
         ed0Orl7a4kli4ClW7KIzEyK1TNyjC7L/S/3nb8LD9nHQA6xtGGkVnLDSrRDRbk/aD7qv
         h4MyLCLXrCScDmXZk2B+u4Uog/pM7hIq5O59yy2l8FBXprzqIBzP/qq4vkrKYLBdFaya
         CBlEPVztX0sn/60QhgC6U7JT/qsGCoZREVqawx+MnrK/WIR+LIEf8o8SLGpnYOByjwYq
         JP7m63XjDcHLHx0XZ0xhAzgHhGnWfWP0BL6Hx6A8h/qpyEkKO4+DiXmRTnAXWpP9e6rZ
         Fxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761567132; x=1762171932;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1K6xkbSLXCZfpQRV3G8+Fp5c6I0KD/SmqImBeUSbSlI=;
        b=m7kWVthzeah9I5cecPINGSWoerjJxp0Z95GmLqD8fpGhR1bVxblhdkv1FSxNGjMgaF
         l8K7VRGi07Tn1D3r2XvL+7XiXZq13tafGQVoIFtuk8p5m19nbMtEZ2MtW7mxHYEZlWhx
         IahIhwNclzz+gWRtlQ4IUrq7kDMNZNhkIsIrLec8FnvUHOcrRXwPt/fqPz++qZAOukPK
         J9LGz0XeFQr0hvynHU8LXnjqvUfaul5IGjFomgqFqC7xNIzhYLt0d2tbZ48XKxCsM1fB
         Gbbef7FCzPyw/ckcNQf3SXTtJbxYSqpMLcWRKWpls3c2oGI4/JPh/Kr3FesGJfpRNvqS
         sRCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrKFuTmYc2GiSlayY1hsqqMcZLB3Teqsa1/sKIA2Za0voKNKzLjdHexUd/43/1bHGXJEAaQc3BURhGTJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUI4tmBRj2sheT88E1MCm2z8PSDRefNXkG+IQSa5wXmMRzD94E
	Q6MwBmfD5hR/1hwbpYTnMF3nNs6UhD4lshNn60zGDx3PTLc8B173VjQ+
X-Gm-Gg: ASbGncu74KosC7RVbhPm/nhQI8O1/buFc188ddIyykStjI5OnXzHDitjFHcC8nIn46f
	mI0UTy67CQ9QDjCK8bz3rQvbE3UzUTeckZGdcZczNySoqmbdVrgiEE3V2VpNOXaGGVAKwgrnSDz
	W/ms3xclaXWR9zQgV+CAtAs6wRf5vXqNiSrlPM5fniQ63rc2/NvJonWnI4GWwkwuL5b2OQxK/RH
	EDwTtZTvwZVJtpuAKfdj/zkyTOqJUqPIpFLIBfS4jfuwLPUgy/84f41SXGGU1+6ELJ3b3+Q0UGe
	JcQ23eMq1wP9EV4JKD3u9Rzi5Z1vDyaz3g0j6I81AP2IKlaBkMd7VZXobzlPFKcLwDfcVQqrlEx
	4XAw/tzne7zZ/DzBCvK69ouySbhMX9FJvgKE4VZUOHgpUINLXxilZ8CFhgdp0R9bN/C4wDT0kZk
	C8+b7zCto=
X-Google-Smtp-Source: AGHT+IGy6D0tTIvVlILglNSBOCB1p6ZX7q5m9QWQkAui7e9xRl72tUYo/wvl9R2uMieLBXpDMY+FPw==
X-Received: by 2002:a05:651c:435c:20b0:379:348:80e2 with SMTP id 38308e7fff4ca-37903488e1cmr3163511fa.9.1761567131490;
        Mon, 27 Oct 2025 05:12:11 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0d3d6dsm20154341fa.38.2025.10.27.05.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:12:10 -0700 (PDT)
Date: Mon, 27 Oct 2025 14:12:06 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: bd718x7: Use regmap_reg_range()
Message-ID: <aP9hlpRO-0vmEHBZ@mva-rohm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z+I+fUiFL9PykcUI"
Content-Disposition: inline


--Z+I+fUiFL9PykcUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Initializing the regmap_ranges using direct assignment to the range_min
and range_max members is a slightly verbose. In general we can make it a
tad cleaner when using the regmap_reg_range() macro.

The rohm-bd718x7.c is doing this open-coded initialization. It's not
really bad as there is only one range defined, but it is still worth
converting it to use the regmap_reg_range() so no-one uses it as a bad
example.

Additionally, the regmap_access_table expects a pointer to an array of
ranges. This is a tad more obvious when we use an array with single
range, instead of claiming a pointer to a range struct being a single
element array.

Use regmap_reg_range() when initializing the regmap_range structure and
use a real one-element array instead of a pointer to a struct.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/mfd/rohm-bd718x7.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
index 25e494a93d48..ff714fd4f54d 100644
--- a/drivers/mfd/rohm-bd718x7.c
+++ b/drivers/mfd/rohm-bd718x7.c
@@ -72,14 +72,13 @@ static const struct regmap_irq_chip bd718xx_irq_chip =
=3D {
 	.init_ack_masked =3D true,
 };
=20
-static const struct regmap_range pmic_status_range =3D {
-	.range_min =3D BD718XX_REG_IRQ,
-	.range_max =3D BD718XX_REG_POW_STATE,
+static const struct regmap_range pmic_status_range[] =3D {
+	regmap_reg_range(BD718XX_REG_IRQ, BD718XX_REG_POW_STATE),
 };
=20
 static const struct regmap_access_table volatile_regs =3D {
-	.yes_ranges =3D &pmic_status_range,
-	.n_yes_ranges =3D 1,
+	.yes_ranges =3D &pmic_status_range[0],
+	.n_yes_ranges =3D ARRAY_SIZE(pmic_status_range),
 };
=20
 static const struct regmap_config bd718xx_regmap_config =3D {
--=20
2.51.0


--Z+I+fUiFL9PykcUI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmj/YX8ACgkQeFA3/03a
ocWMYwf9Ew0ePEMBVZttU8K7xJmHtwySiaFB1Rc7BXyLitAPKjD8NL1L8X/kHlVF
yt5D7tY8pociB+hxY0B5Fn6YwyGwN45cHj/Di58WxN4V5YTNjcgDHbyPeC+ey6Zc
M+NhBCS0pI9Yqk3eyJxXaHPPKETRhsLd5vxIVgjdlTBMJgS6pAeadC6YOsL1Tq+b
+3LPHJeVYIt1UeCMCG2rhU5Lja+FrVyLlijigpDSfmADuSIOx5Fxacb49AsaKP6s
HRLIjHLZT1AtgHTvnWyD7nhGyeKXTqW1xLBbLjltjIjXFutxF7yQtl+mMaaAPz5Z
5v56+LgDXkNeQWrOOCaMiGT1/TRc5g==
=gFSh
-----END PGP SIGNATURE-----

--Z+I+fUiFL9PykcUI--

