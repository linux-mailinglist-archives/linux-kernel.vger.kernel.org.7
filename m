Return-Path: <linux-kernel+bounces-843970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2363ABC0B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B8CF4F5700
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D085B2D592E;
	Tue,  7 Oct 2025 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUZk0Fb8"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF2A2D94BB
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826090; cv=none; b=PA+SsldGpcYv8RpqYUH+fkM0HnslIYm0P98YPWrBUkvi5O4OQwDs45G+0bQjiR3Bq6qsp2sRCYdf7Lpl6g5WcEHMmQ0kwPVYUiIN/Nf7J2zPiZfoL0UMsn0pru3Bc2sd5JccQE4BH59XomiPUDnYXcvOaO+mBg5f/V2vTUNvKZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826090; c=relaxed/simple;
	bh=GUSjLjlYDEl8o6/jXjuzBG5/s1EogFROA51N25GkeDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjUlc6SR4KYa1Mnes8Jsh6iTK1rCQc8AWDMOvktEGo7BJ5twYhTUJZH6TNhCsheQBA6JWv7XWg+DR+fuL4yhpO0SjvUllp00ItgOkcziufZyOo9I3UtVgwB9TuzfiUl2e664ikATeV0MemkirpxdzkqwTnP0Qv6yGUqOAzZKB3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUZk0Fb8; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-36a448c8aa2so48521071fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 01:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759826087; x=1760430887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N4czLOo5ZnN18HLnOcC7pqQ0t9QPNLqdBoEDTR9BH/I=;
        b=mUZk0Fb8f9hWI98v4xxsInXObeVr8oqrgB9R0/IwE1M9YVV3VGz+Sr5UpDrQAbG++J
         kwy6COdt8ZLpkvq1UUl6h+cDMS1cP1f0cCLK7A7L4Kwewo1U1uO+UtU1nSeLHH0O5Gco
         S64RPPU4OaOe4qcZCUp1hnC6xoz4qys8kROWCj+1fJY35K1uaj9nrG5aLa0q55P6UJkZ
         5nOdjbdylg1f7zeDDttzoFdYi9rl4ABdcvg3jDI42Q4L0Krq0gdzHIYJX7jMi1v4cohm
         n6fSo0FraSyifJVjFT5RaoqJyfVLP4TcdqTTiH18lONXVuKWigIPdbVt0DLKg7FjcnrU
         w6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759826087; x=1760430887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4czLOo5ZnN18HLnOcC7pqQ0t9QPNLqdBoEDTR9BH/I=;
        b=lejd0etZ5wpYwKvGtlSwU1AquTt9EAgnnGnV5quhJpMq2D7x0hpKAyVIbOFUH+T+VN
         kQvG5koQDxj1p8wuhLebECEfl7sU5PcGeCnRA8xs54gxxKP76N8mJPvkEdEXfm0jdhI2
         q3LGfw7MOfHS3C0+Ttslz7sioz8Li/yNXO+rl1reoVbpVuijtIS+zHx/1dilwHxNdDIR
         cI7wnHjd5rZGzuDgSSUngGFiX3TsKpkX9fUPFPBkmHBYRPa1d4Bl6GSCybd61GdNTTbi
         i3NZ0xajcGzTNGFzcr2YYiCrOqvrZU4v+tKYEMHdGDe3QQgl9DI1kCKMk3iWANm7jaO7
         946g==
X-Forwarded-Encrypted: i=1; AJvYcCUVu68pfds5iPFbEcrb6BWogiptJ1DMp2OFIlNH6ohf+lL0Fltr3v4hMPjC9W4cmVOgY+QEP8O7Q7CFQ8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxndPTA83uIcY7UbuyguD/bwGQOagGfGHwnumHinn/NvXtYzfKu
	s1sbZt+e4s6FuNdJlh4jshx2Z7B4v6sCNK5xpSNM2/tblT3KsV8SmU41
X-Gm-Gg: ASbGncs1uwuVTUXkb/IKxp84Y9NcT2WpHNUj/J9hs+Tn7uS/NzIy+BXrr3gklGlztgH
	IFQQJvmHCMHAAFBMDbCfO7KvznUbk+KTXad8JYYUGypfC/5UU49nDwIWCeGMCUJc+P1v8TVCp3C
	JhLI02Wve0mOB9zIHxW4KlSs7NUPtIX33SY7pdoXHiuua/rTNCooWIamYiRWymTPd/46HdRgC1I
	kS7aahLaQq0o6xG1nyqx6QCsIMXNgbhlPId8/aL4FmYhDDokobodwbkH3NezT/fRZuhqjg34Dal
	ESmmVAR+UteWsgmDGvXjKYe2b7Yd49FBMPBpXbMyqNSi+73GJPfzCpz+b0WtfcBClRfA0IeeE1c
	syhbqJWV36JSZuJUFHHBUdItfFMpDlPj5g9P45x5KjqbAG15MpzC154vd9R9AgmwH
X-Google-Smtp-Source: AGHT+IFJwLelYLgNdfM+CTGIlVmgHDyXSlhZErg/oypat4GW4z8fl0IXAAmciErEk8L811heCPgGOA==
X-Received: by 2002:a2e:bcc2:0:b0:372:8cc8:fc3d with SMTP id 38308e7fff4ca-374c36a532bmr52952751fa.1.1759826087055;
        Tue, 07 Oct 2025 01:34:47 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f39d2f9asm7808841fa.2.2025.10.07.01.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 01:34:45 -0700 (PDT)
Date: Tue, 7 Oct 2025 11:34:42 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [RFC PATCH 10/13] clk: clk-bd718x7: Support BD72720 clk gate
Message-ID: <73e5485c34db0667b505bf73b597e0b3cd1b6060.1759824376.git.mazziesaccount@gmail.com>
References: <cover.1759824376.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4M+VUMaCtdns8Dyt"
Content-Disposition: inline
In-Reply-To: <cover.1759824376.git.mazziesaccount@gmail.com>


--4M+VUMaCtdns8Dyt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The BD72720 has similar simple clk gate as a few other ROHM PMICs.

Add support for BD72720 clk gate.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/clk/Kconfig       |  4 ++--
 drivers/clk/clk-bd718x7.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 4d56475f94fc..9742a3d0c1cb 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -474,8 +474,8 @@ config COMMON_CLK_BD718XX
 	tristate "Clock driver for 32K clk gates on ROHM PMICs"
 	depends on MFD_ROHM_BD718XX || MFD_ROHM_BD71828
 	help
-	  This driver supports ROHM BD71837, BD71847, BD71850, BD71815
-	  and BD71828 PMICs clock gates.
+	  This driver supports ROHM BD71837, BD71847, BD71850, BD71815,
+	  BD71828, and BD72720 PMICs clock gates.
=20
 config COMMON_CLK_FIXED_MMIO
 	bool "Clock driver for Memory Mapped Fixed values"
diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
index ac40b669d60b..1cae974e6d1d 100644
--- a/drivers/clk/clk-bd718x7.c
+++ b/drivers/clk/clk-bd718x7.c
@@ -19,7 +19,8 @@
 #define BD71828_REG_OUT32K	0x4B
 /* BD71837 and BD71847 */
 #define BD718XX_REG_OUT32K	0x2E
-
+/* BD72720 */
+#define BD72720_REG_OUT32K	0x9a
 /*
  * BD71837, BD71847, and BD71828 all use bit [0] to clk output control
  */
@@ -118,6 +119,10 @@ static int bd71837_clk_probe(struct platform_device *p=
dev)
 		c->reg =3D BD71815_REG_OUT32K;
 		c->mask =3D CLK_OUT_EN_MASK;
 		break;
+	case ROHM_CHIP_TYPE_BD72720:
+		c->reg =3D BD72720_REG_OUT32K;
+		c->mask =3D CLK_OUT_EN_MASK;
+		break;
 	default:
 		dev_err(&pdev->dev, "Unknown clk chip\n");
 		return -EINVAL;
@@ -146,6 +151,7 @@ static const struct platform_device_id bd718x7_clk_id[]=
 =3D {
 	{ "bd71847-clk", ROHM_CHIP_TYPE_BD71847 },
 	{ "bd71828-clk", ROHM_CHIP_TYPE_BD71828 },
 	{ "bd71815-clk", ROHM_CHIP_TYPE_BD71815 },
+	{ "bd72720-clk", ROHM_CHIP_TYPE_BD72720 },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, bd718x7_clk_id);
@@ -161,6 +167,6 @@ static struct platform_driver bd71837_clk =3D {
 module_platform_driver(bd71837_clk);
=20
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
-MODULE_DESCRIPTION("BD718(15/18/28/37/47/50) and chip clk driver");
+MODULE_DESCRIPTION("BD718(15/18/28/37/47/50) and BD72720 chip clk driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:bd718xx-clk");
--=20
2.51.0


--4M+VUMaCtdns8Dyt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmjk0KIACgkQeFA3/03a
ocU5WQf459k37WyeXVlkrKuVW7Svb4MOFVMVF+lU5Ux0Ov1BTXkwmyryvKWnRVcU
m8N29E9g+ugj9vvNdnEVMKYcFM1F5VhGz1NdmIZ07SCDA8hw0/efqI7kE/0ye1g6
+5AQgMLpSxOnUy7gXAJnQXIASTfn+fkMTVmuSARJwV/VO2Rvhe3R97uOXTczzhxF
BGFkeZXLr5ZM0p/UWKwoWk4GBtPNADjXnIgoQ+nGxnosR6YgwHNkWnNvs/O+XhM5
Hdew+uEBnmvmrjPpGKI00q5xV+6HC74toCTut0C4JZq2LwhXELCmrPJUhowOWV2s
12St76wJX1azrQiHe7ecQR+O8RYL
=XN3R
-----END PGP SIGNATURE-----

--4M+VUMaCtdns8Dyt--

