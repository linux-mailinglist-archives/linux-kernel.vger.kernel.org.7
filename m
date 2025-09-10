Return-Path: <linux-kernel+bounces-809827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F5BB51287
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9247C465FF2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23557313E09;
	Wed, 10 Sep 2025 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NOrfmqUa"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D42B3128A4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496737; cv=none; b=VVKAs7LwgImwqRzllB7gVxgYxUjhmiIr3EzD9hPQvlM4gzatlNCfMz72c0Wi2Kz4XHywxXU+47veHLuCEZ5aBR6BICFklQC/DIoqdobSVh0rUS3/Nuyx5OQpgup/pT4qZQRtYLRP2u5/F3nrstfiGTAjkH9xVno499AY6atzMMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496737; c=relaxed/simple;
	bh=m3KCjgCecrKECVcLyzim60fdiAsnWmjj1IH8DIxwg9s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fHTDzsr7f1ccbfS2fGhiMJBM3/OZ3AXNdRwZ2K11R+twpGIt55+N0otNb5eU7o5WZVRY/DYwgZe+EGo0cua8wFiSrKxKvkAQv/70lR1wCjMc9K3CBmdUCIW55vuU8tQLa3V176SjGn3lYrIPcg9GdsyIHE/uXOdHV7jS85d3ckk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NOrfmqUa; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b0428b537e5so1054774566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757496733; x=1758101533; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7j9yViv+8HMHUAzNJoRK1al60MZn3M6CnFS/PX6jcN0=;
        b=NOrfmqUaEmbdBM85QHls1LUdmRzTI6dhanGPZAzrgg3xR/kLjo1f4Q1QM0lxpsWY5A
         /i1/G6ypxGitfLXpYSic8Tvwdq5L1u9iOEhxXygsPjmE1MHPB5SHzKZrlChRS7FzfpRq
         UqhNHVI7Wkle56CFPAemjwPc9qsEUtgM4oyPJCzSiqLoodyIWKvZH46JF/oRd3p4wvzk
         DHBA8w58zEvZN8PkLUjtPh/FxA/UfwJnP9K2ATl3R28GzgxK8MMzBVOSzWlVmXPJfmbf
         /ojTQRQmsrImsp4MuRSaWeUzRfi1vGVESacMTh2cSK2VCpuzLzHkdinpCT552ZzEcHzG
         uLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757496733; x=1758101533;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7j9yViv+8HMHUAzNJoRK1al60MZn3M6CnFS/PX6jcN0=;
        b=IDunfwarnpDUtGPyO1/gCCoCg/+iKhaubkQsTO0rb0zpyMmchpb1jvyfAA1YBJudXU
         cOu2rNOgPvxr0TV7uEf6xZw/nx8RUYPGhHpxLhcab/KkYLOPsmNtS8PBBZKkZlUC8yXI
         cLVj1prvaGftQRg/qnMw9Ds4c3MbPpi1LSANtkSnLw41EViHYCU781Nudy42X2sbfR35
         6WoTblMz4a76yMztudv6PjpVerZW27SqDmVpdGx8bY27tDWyepIXhLtc66Noiyz6jN7P
         2XqCyF6wKZ9g0Ucx4cEa8zSeOflzt929hwqlMLplULjN+RsNBPZJNaO9r2duPiklBIks
         qbPA==
X-Forwarded-Encrypted: i=1; AJvYcCWpN1aL46g5GyOSGM+MVPcyPYcXH9wpLm8A+8pLnuITGc9Svj5RdukJenTeK60O+n4BR+Zg+aLkSiazlCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz78Q7afCjKnhTEzCdOpZWYsHdNUweR65VLDSXXkVKjLTUVTv74
	xmzi09qzlzZVLaoODqImaV5cSuJnyKF76APPt8FTdt2DmdTMAQkX5SckCWAt9Xe/pDdXgsaOHvj
	ygeNR
X-Gm-Gg: ASbGncsRVSgp2t60apE68aYvBvQJDgFn45PS1QOoZZQ/oOL8wyJAaQYxxffK3fmYUC1
	8DE62raKQVCjTVhdH8FtxkkULPUV3tz/wAxwuFleEiSJUaSFFsgaqojxGfMeZCmtBXdXI5t7cyv
	ZeFmn58JLkQ2YmYRl4z6pJIifLQoswkGz0u42R/N8W1XxdhvY+zFjN5xBoQanlcLFgZNHpuihTc
	QILFju5B31hm9BSWutlxIY2R+lZ5DQr9o2pOOY5dOLJDDzSA8+zBqpHwelcV972KOAL6nXZchhU
	08PKsE70DrBwsU642LLEPzO/c/lFUV3e/M+5TohIAMN78yl1WNIDqBRPO21ltFySP8lCAmhgIZP
	16lt1JlnOHU+xkt7FnI9ZOI0aTQ==
X-Google-Smtp-Source: AGHT+IGA4Zcnb0ILlOND+lEWZd/hv9wE3sdjItcCquByImXi6CsFHQC07RViEIhCG+j7au6+DHb7jw==
X-Received: by 2002:a17:907:1ca7:b0:af9:6bfb:58b7 with SMTP id a640c23a62f3a-b04b13cd4f7mr1248204066b.5.1757496732625;
        Wed, 10 Sep 2025 02:32:12 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b0783454ca6sm134541966b.108.2025.09.10.02.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=c8c126d18224ffbaa6f014dea6cc608a9bf2a8767f13193554804a621e13;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 10 Sep 2025 11:32:04 +0200
Message-Id: <DCP0LDEOSFXS.1E937SV1347BX@baylibre.com>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@pengutronix.de>
Subject: Re: [PATCH v2 7/7] can: m_can: add optional support for reset
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Chandrasekar Ramakrishnan"
 <rcsekar@samsung.com>, "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
 "Patrik Flykt" <patrik.flykt@linux.intel.com>, "Dong Aisheng"
 <b29396@freescale.com>, "Varka Bhadram" <varkabhadram@gmail.com>, "Wu Bo"
 <wubo.oduw@gmail.com>, "Philipp Zabel" <p.zabel@pengutronix.de>
X-Mailer: aerc 0.20.1
References: <20250909-m_can-fix-state-handling-v2-0-af9fa240b68a@pengutronix.de> <20250909-m_can-fix-state-handling-v2-7-af9fa240b68a@pengutronix.de>
In-Reply-To: <20250909-m_can-fix-state-handling-v2-7-af9fa240b68a@pengutronix.de>

--c8c126d18224ffbaa6f014dea6cc608a9bf2a8767f13193554804a621e13
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Sep 9, 2025 at 7:53 PM CEST, Marc Kleine-Budde wrote:
> In some SoCs (observed on the STM32MP15) the M_CAN IP core keeps the
> CAN state and CAN error counters over an internal reset cycle. The
> STM32MP15 SoC provides an external reset, which is shared between both
> M_CAN cores.
>
> Add support for an optional external reset. Take care of shared
> resets, de-assert reset during the probe phase in
> m_can_class_register() and while the interface is up, assert the reset
> otherwise.
>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/m_can/m_can.c | 26 +++++++++++++++++++++++---
>  drivers/net/can/m_can/m_can.h |  1 +
>  2 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index 9528af8500af..93085bf1c267 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -23,6 +23,7 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> =20
>  #include "m_can.h"
> =20
> @@ -1834,6 +1835,7 @@ static int m_can_close(struct net_device *dev)
> =20
>  	close_candev(dev);
> =20
> +	reset_control_assert(cdev->rst);
>  	m_can_clk_stop(cdev);
>  	phy_power_off(cdev->transceiver);
> =20
> @@ -2076,11 +2078,15 @@ static int m_can_open(struct net_device *dev)
>  	if (err)
>  		goto out_phy_power_off;
> =20
> +	err =3D reset_control_deassert(cdev->rst);
> +	if (err)
> +		goto exit_disable_clks;
> +
>  	/* open the can device */
>  	err =3D open_candev(dev);
>  	if (err) {
>  		netdev_err(dev, "failed to open can device\n");
> -		goto exit_disable_clks;
> +		goto out_reset_control_assert;
>  	}
> =20
>  	if (cdev->is_peripheral)
> @@ -2136,6 +2142,8 @@ static int m_can_open(struct net_device *dev)
>  	else
>  		napi_disable(&cdev->napi);
>  	close_candev(dev);
> +out_reset_control_assert:
> +	reset_control_assert(cdev->rst);
>  exit_disable_clks:
>  	m_can_clk_stop(cdev);
>  out_phy_power_off:
> @@ -2426,15 +2434,23 @@ int m_can_class_register(struct m_can_classdev *c=
dev)
>  		}
>  	}
> =20
> +	cdev->rst =3D devm_reset_control_get_optional_shared(cdev->dev, NULL);
> +	if (IS_ERR(cdev->rst))
> +		return PTR_ERR(cdev->rst);

Should this print an error message here?

Best
Markus

> +
>  	ret =3D m_can_clk_start(cdev);
>  	if (ret)
>  		return ret;
> =20
> +	ret =3D reset_control_deassert(cdev->rst);
> +	if (ret)
> +		goto clk_disable;
> +
>  	if (cdev->is_peripheral) {
>  		ret =3D can_rx_offload_add_manual(cdev->net, &cdev->offload,
>  						NAPI_POLL_WEIGHT);
>  		if (ret)
> -			goto clk_disable;
> +			goto out_reset_control_assert;
>  	}
> =20
>  	if (!cdev->net->irq) {
> @@ -2463,8 +2479,10 @@ int m_can_class_register(struct m_can_classdev *cd=
ev)
>  		 KBUILD_MODNAME, cdev->net->irq, cdev->version);
> =20
>  	/* Probe finished
> -	 * Stop clocks. They will be reactivated once the M_CAN device is opene=
d
> +	 * Assert reset and stop clocks.
> +	 * They will be reactivated once the M_CAN device is opened
>  	 */
> +	reset_control_assert(cdev->rst);
>  	m_can_clk_stop(cdev);
> =20
>  	return 0;
> @@ -2472,6 +2490,8 @@ int m_can_class_register(struct m_can_classdev *cde=
v)
>  rx_offload_del:
>  	if (cdev->is_peripheral)
>  		can_rx_offload_del(&cdev->offload);
> +out_reset_control_assert:
> +	reset_control_assert(cdev->rst);
>  clk_disable:
>  	m_can_clk_stop(cdev);
> =20
> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.=
h
> index bd4746c63af3..7b7600697c6b 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -86,6 +86,7 @@ struct m_can_classdev {
>  	struct device *dev;
>  	struct clk *hclk;
>  	struct clk *cclk;
> +	struct reset_control *rst;
> =20
>  	struct workqueue_struct *tx_wq;
>  	struct phy *transceiver;


--c8c126d18224ffbaa6f014dea6cc608a9bf2a8767f13193554804a621e13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaMFFlRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNd
BAEAj9W/dnoOTAfrBCX2wANYS7jxLzRhHgCwtyZnKvgaOUABAPPeFMzctgSz+QPJ
TLyTsKfoplKPDLrDiUpwDiXFlHYC
=JgQT
-----END PGP SIGNATURE-----

--c8c126d18224ffbaa6f014dea6cc608a9bf2a8767f13193554804a621e13--

