Return-Path: <linux-kernel+bounces-847370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0F7BCAA95
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 21:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F05B4E30D8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 19:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F312C2571D4;
	Thu,  9 Oct 2025 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d9HgJu3v"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BF5255F2D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760037133; cv=none; b=tHUXqEksCA2pHVQ/DjII97n7P3VWBwqaToHQ2kNP6QFCPhmaGVlyNvbodNu71GH2a2Bj3fcWn2uYklRbH7tLGYc76mKX9aMpN79R24tLFjjdMSciNNh9Oxkzs8y3ngUoSn52TIzNj8QOb2SmP8CZWjN9+aIVzerNxQA3GFuYeaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760037133; c=relaxed/simple;
	bh=n1pgm9KXQpsmFTJTlrRTqqoc3StRiW8H6U0QmRxjVIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bemUA2ALZzgUh5lf4tZJW6l9B7Pda1hMVqn7pMv3jebrw42KMwUv3LBHLqCX38ieRwuMatxtLIDB8K+9udXDFFZCGBxcpXE5ku346YvCftH3afd8sA6awcU7YAQ3wMGzN7+suvdIq59bsb4Q89fnck6MdrsDryrBL5Z8XnOLl7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d9HgJu3v; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-789fb76b466so1235962b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 12:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760037127; x=1760641927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EwOoGI07ldKNXakHc31vPQT9U2zxbYTfJdNYRER5vcU=;
        b=d9HgJu3vW9MKHQkFwYU3PbzAyaO/2F4IrrQ55xALGSkFD4BdBTv4D8rxhEYRVZywQ0
         2Y5em49M0Ngn1pzEo4sDa7ClL2Z7MrGrTyrPKJFRnsqlyOVEjIMT21bxE72IkvI8gTg4
         aqf06165OsxMeJlYpmUW5PzWfbC19DscI+wZcnrxDta499QbSjzdGzRQkuVGTet8DJHa
         fmyDaJZCudN6YFn6ZEQo8+XtDAg+b8W3vLJuhBDXlmJAFgY05+nUaypKT+/5DBtvYNv8
         ZJ7wFiWUaByPm9IZ8Bbn4O74ZXaZfIK3pEbARGOzR3RVuIUMS4TVBsCCzuGLP4TudW13
         bSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760037127; x=1760641927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwOoGI07ldKNXakHc31vPQT9U2zxbYTfJdNYRER5vcU=;
        b=BNbCCoHIsgh/fJC9OR9zeRorbxnWiKAJiut2vJ7Jk0Kw1E9569sIzVR6J4Dy0orUJY
         OQA5NSrWc0ZOuvWUIclJLmdraqi1+TV3L0oi13b6QilfL2l9z3Trq5Z8RHj3FPM2C/YS
         6NN+dDtsOT4IFBgpmQULlyZBN+hww69wAoqDdFBFgDHlu8ia46eVH4dehK1M3Dkwiq2E
         l5rkby8nrZvoBjFfdJxMh68rxls4h85E265w1ioEjVhv654ZnzLhakgwGyClBKTSFfkc
         kpLPeTyvYE4jab5oVyfRmgmv7w1iLV2AN1B14DHEFDJeBSO/WfHn6vlOu/oHx4bMqVdl
         g2Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXdMGea5Z6v6z12SlzVTPyY4rfYgjB//tf6JWa0pS54bSuYaVo/49dKL6eAL0nyexqJBtjofWX/CBDn1Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz34/yAv+q8dl3bgH04nNjpzoRJNf93n5JUIj/kkuWN7pb1ym80
	TjisFd3v5ueibsVUuk/y/LLrNeEPb9+lA9YRpodfWUhP8bucre1pDSKAMDt3FYjXfQ==
X-Gm-Gg: ASbGncvN63wBWeCHRcRkI9fY6flj4+Ugp+WmVxPUz6jC78wBiNSeDjH0lFfm+rrVamj
	LkpeojQhcLVy7RX1nl2OLdmT+JWuW0jJ6sPKy39XUSQMb5bBYCi6UsV7bmIFOTWtzrY3hoTivKA
	N/8yRRdeV/H2kjJRY4RxUx8a6FnXQGfkbcGlsWqstuojQyh1yvJ5gWQJBEFVGqHYHvPRmcPp6ok
	aZO9e8e4oqCYOnT1tR0ke45zaUyVQWd/sRIN2IBEYZlixN0Nlu/ZJWDOg75U4MvcadNFTS7j3zm
	EExn6jEH4Y2xzQR5LOr8UCPnqMYOn/TNP3HZ64ZGN7Iqm9r5UWjroKLA69zeqJFkHXmz2e/lM1z
	KE0W/o+8Mw70pT+wKkPu/hR9om6k/JS5A3GRyD5nL1NryVC+/KydVSmEOR6/OnqCBCliBbTzLh0
	n1RtThXDkIiw==
X-Google-Smtp-Source: AGHT+IH72sDrXwwkrDO6FWG06LbsT+R2CV7vzjUVeXBnwqtete9TvLbCDH2IOKZiEWq/Wu1NWkJrRA==
X-Received: by 2002:a05:6a00:2389:b0:77f:68a4:a88 with SMTP id d2e1a72fcca58-7938762f6cdmr9925673b3a.21.1760037126658;
        Thu, 09 Oct 2025 12:12:06 -0700 (PDT)
Received: from google.com (232.92.83.34.bc.googleusercontent.com. [34.83.92.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09659esm480905b3a.45.2025.10.09.12.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 12:12:05 -0700 (PDT)
Date: Thu, 9 Oct 2025 19:12:02 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: akuchynski@chromium.org, abhishekpandit@chromium.org,
	krzk+dt@kernel.org, robh@kernel.org, bleung@chromium.org,
	heikki.krogerus@linux.intel.com, ukaszb@chromium.org,
	tzungbi@kernel.org, devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] usb: typec: cros_ec_ucsi: Load driver from OF and
 ACPI definitions
Message-ID: <aOgJAtdd_M62cnR6@google.com>
References: <20251009010312.2203812-1-jthies@google.com>
 <20251009010312.2203812-3-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ck64/QEIf9Tlz/RB"
Content-Disposition: inline
In-Reply-To: <20251009010312.2203812-3-jthies@google.com>


--ck64/QEIf9Tlz/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 01:03:07AM +0000, Jameson Thies wrote:
> Add support for cros_ec_ucsi to load based on "google,cros-ec-ucsi"
> compatible devices and "GOOG0021" ACPI nodes.
>=20
> Signed-off-by: Jameson Thies <jthies@google.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/usb/typec/ucsi/cros_ec_ucsi.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/typec/ucsi/cros_ec_ucsi.c b/drivers/usb/typec/uc=
si/cros_ec_ucsi.c
> index eed2a7d0ebc6..62b80ad85a68 100644
> --- a/drivers/usb/typec/ucsi/cros_ec_ucsi.c
> +++ b/drivers/usb/typec/ucsi/cros_ec_ucsi.c
> @@ -5,11 +5,13 @@
>   * Copyright 2024 Google LLC.
>   */
> =20
> +#include <linux/acpi.h>
>  #include <linux/container_of.h>
>  #include <linux/dev_printk.h>
>  #include <linux/jiffies.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_usbpd_notify.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> @@ -235,7 +237,6 @@ static void cros_ucsi_destroy(struct cros_ucsi_data *=
udata)
>  static int cros_ucsi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> -	struct cros_ec_dev *ec_data =3D dev_get_drvdata(dev->parent);
>  	struct cros_ucsi_data *udata;
>  	int ret;
> =20
> @@ -244,8 +245,11 @@ static int cros_ucsi_probe(struct platform_device *p=
dev)
>  		return -ENOMEM;
> =20
>  	udata->dev =3D dev;
> +	if (is_acpi_device_node(dev->fwnode) || is_of_node(dev->fwnode))
> +		udata->ec =3D dev_get_drvdata(dev->parent);
> +	else
> +		udata->ec =3D ((struct cros_ec_dev *)dev_get_drvdata(dev->parent))->ec=
_dev;
> =20
> -	udata->ec =3D ec_data->ec_dev;
>  	if (!udata->ec)
>  		return dev_err_probe(dev, -ENODEV, "couldn't find parent EC device\n");
> =20
> @@ -326,10 +330,24 @@ static const struct platform_device_id cros_ucsi_id=
[] =3D {
>  };
>  MODULE_DEVICE_TABLE(platform, cros_ucsi_id);
> =20
> +static const struct acpi_device_id cros_ec_ucsi_acpi_device_ids[] =3D {
> +	{ "GOOG0021", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, cros_ec_ucsi_acpi_device_ids);
> +
> +static const struct of_device_id cros_ucsi_of_match[] =3D {
> +	{ .compatible =3D "google,cros-ec-ucsi", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cros_ucsi_of_match);
> +
>  static struct platform_driver cros_ucsi_driver =3D {
>  	.driver =3D {
>  		.name =3D KBUILD_MODNAME,
>  		.pm =3D &cros_ucsi_pm_ops,
> +		.acpi_match_table =3D cros_ec_ucsi_acpi_device_ids,
> +		.of_match_table =3D cros_ucsi_of_match,
>  	},
>  	.id_table =3D cros_ucsi_id,
>  	.probe =3D cros_ucsi_probe,
> --=20
> 2.51.0.710.ga91ca5db03-goog
>=20

--ck64/QEIf9Tlz/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCaOgJAgAKCRBzbaomhzOw
wtyVAP0TLJub+b5vagwrk3iMRa/VWY57prIisehNkOjcgtnzmwD9FkRZPL6JqvbZ
fL2S6Q1rkPu0rq5K0Fteq+E+dV7jbgw=
=d2GV
-----END PGP SIGNATURE-----

--ck64/QEIf9Tlz/RB--

