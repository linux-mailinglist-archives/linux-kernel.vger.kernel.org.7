Return-Path: <linux-kernel+bounces-720928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420C2AFC237
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0041B4A6B29
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490C8217659;
	Tue,  8 Jul 2025 05:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="lxr5bmWu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="FA4FCOkg"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB27D645
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 05:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751953368; cv=none; b=Fzx7KfQZbD2XWT2/tOmRMjwqX1gViJIGt7O3lM5LOlC5SiRAv1N1PnuW2UchEYRnhFjejnV1kr91godEKNrSg2vP1lZvlEiEEeA2PHzXEuf4U/U6SSB9g3FHqbj8GXvmPOYDDA1r7M3MO0QTGQ6T4JxvG/WEpadwbX+kMLccEFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751953368; c=relaxed/simple;
	bh=3jcIvRz/64vaLlE9f3ifS9mjbukbBwJ2fIUNnmNWkLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRDivRMYK7BMYfj3CIccl9dm7d/MouNZgm2wgl8hYKMupqmc6LuBoLsVtvM6PHxzuEGS37H9NFo+erv5bfNYNtCCdXKA0IrsBOXF133HrO/YgJU2g2YFNtc4yC+3OTzXcdP6Z2ZL6vi/msE0AfLOxBfdzXvKBjKjteInrHMEmOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=lxr5bmWu; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=FA4FCOkg reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1751953365; x=1783489365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dvdZlbFLOSBCY4Q+zQ5tbPvu2hRNVALGGd8gtRrbH20=;
  b=lxr5bmWuhkmE0DfRbj4d6wYPYcZ5uWpMzCqrvvShRetTfCrs8wyJtzyB
   kSas7/D+5YlJk/0Oqlsi+aw553znyED6P5O5Jfrh8k1ms2u2QagutplDc
   Y3Nhr3wWnWVRmEDsKVrJL3AYl7lNdNm8nZ0lDFVAvjeRN0oJAbvszB/JW
   tUmAeHDG19quFcpMv/uEpa2prD5YajqdzknGS6E/uh6eqHF+VNEbY41MT
   BZPlcQLFwTzYMHv3kfUBD5S0PsNQ14qZsiOgZZxU2YiD598IXZQc0tLMO
   jTo254MImxMWW2Vm0NMestEVR9MNiJPjqk+1lAFe0R0vHEhLPnBncupAz
   w==;
X-CSE-ConnectionGUID: Yty2a/IFR5uTPnZ2V+JqOQ==
X-CSE-MsgGUID: q/MyEStvROGTY0KNcv0DwA==
X-IronPort-AV: E=Sophos;i="6.16,296,1744063200"; 
   d="scan'208";a="45074462"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 08 Jul 2025 07:42:37 +0200
X-CheckPoint: {686CAFCD-17-B791C630-E7A1546C}
X-MAIL-CPID: E002399BF6E21CDA14271D361A9972B7_2
X-Control-Analysis: str=0001.0A006399.686CAFF4.003D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C7F09165CE8;
	Tue,  8 Jul 2025 07:42:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1751953353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvdZlbFLOSBCY4Q+zQ5tbPvu2hRNVALGGd8gtRrbH20=;
	b=FA4FCOkggEqJexNoCfYbgVEUeqWSYLw17WBBOatPcWtuFupyU9vNDPsMu0P412fQnRKPJv
	N7Ua713dS9QyNVT3OVhjYeJ/BC6WDUQLfLze01bmtGRKH/dX55N4jzMyxbY5DRZDiLLaUV
	iIiAE8WK2ksuzqHFv1HkgNd1Tw42fTWWhIDELjqBNsUayRKttJeqBgVLNcYhyPyh/msNTQ
	/eNUJoV/TAJ8dsWK+V9nR+HclQBpb+8AoGDAQ1MOymKbKf631JAbksRto+6yfBQwESsP+I
	7/nEyxU0ayhJlRyv4N5XL6fZFXbdWY8jXhK2dB18OKxOIZO/D62FbtcAtusvBw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Fabio Estevam <festevam@gmail.com>,
 Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
Subject: Re: [PATCH 1/2] bus: imx-aipstz: allow creating pdevs for child buses
Date: Tue, 08 Jul 2025 07:42:31 +0200
Message-ID: <22762518.EfDdHjke4D@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250707234628.164151-2-laurentiumihalcea111@gmail.com>
References:
 <20250707234628.164151-1-laurentiumihalcea111@gmail.com>
 <20250707234628.164151-2-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Dienstag, 8. Juli 2025, 01:46:27 CEST schrieb Laurentiu Mihalcea:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>=20
> devm_of_platform_populate() passes a NULL as the bus OF match table
> to the underlying of_platform_populate(), meaning child bus devices
> of the AIPSTZ bridge will not have its children devices created. Since
> some SoCs (e.g. i.MX8MP) use this particular setup (e.g. SPBA bus, which
> is a child of AIPSTZ5 and has multiple child nodes), the driver needs to
> support it.
>=20
> Therefore, replace devm_of_platform_populate() with of_platform_populate()
> and pass a reference to the bus OF match table to it. For now, the only
> possible child buses are simple buses.
>=20
> Since the usage of devres is dropped, the complementary operation of
> of_platform_populate() needs to be called during the driver's removal.
>=20
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> Fixes: 796cba2dd4d9 ("bus: add driver for IMX AIPSTZ bridge")
> Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Closes: https://lore.kernel.org/lkml/5029548.31r3eYUQgx@steina-w/#t

Thanks, with this SAI devices are probed again.

Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  drivers/bus/imx-aipstz.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/bus/imx-aipstz.c b/drivers/bus/imx-aipstz.c
> index 6610251f41c7..5fdf377f5d06 100644
> --- a/drivers/bus/imx-aipstz.c
> +++ b/drivers/bus/imx-aipstz.c
> @@ -26,6 +26,11 @@ static void imx_aipstz_apply_default(struct imx_aipstz=
_data *data)
>  	writel(data->default_cfg->mpr0, data->base + IMX_AIPSTZ_MPR0);
>  }
> =20
> +static const struct of_device_id imx_aipstz_match_table[] =3D {
> +	{ .compatible =3D "simple-bus", },
> +	{ }
> +};
> +
>  static int imx_aipstz_probe(struct platform_device *pdev)
>  {
>  	struct imx_aipstz_data *data;
> @@ -49,7 +54,13 @@ static int imx_aipstz_probe(struct platform_device *pd=
ev)
>  	pm_runtime_set_active(&pdev->dev);
>  	devm_pm_runtime_enable(&pdev->dev);
> =20
> -	return devm_of_platform_populate(&pdev->dev);
> +	return of_platform_populate(pdev->dev.of_node, imx_aipstz_match_table,
> +				    NULL, &pdev->dev);
> +}
> +
> +static void imx_aipstz_remove(struct platform_device *pdev)
> +{
> +	of_platform_depopulate(&pdev->dev);
>  }
> =20
>  static int imx_aipstz_runtime_resume(struct device *dev)
> @@ -83,6 +94,7 @@ MODULE_DEVICE_TABLE(of, imx_aipstz_of_ids);
> =20
>  static struct platform_driver imx_aipstz_of_driver =3D {
>  	.probe =3D imx_aipstz_probe,
> +	.remove =3D imx_aipstz_remove,
>  	.driver =3D {
>  		.name =3D "imx-aipstz",
>  		.of_match_table =3D imx_aipstz_of_ids,
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



