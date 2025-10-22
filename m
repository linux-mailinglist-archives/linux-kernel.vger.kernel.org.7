Return-Path: <linux-kernel+bounces-864548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EB8BFB0A5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92F01888732
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6231430FC36;
	Wed, 22 Oct 2025 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N3c3SpV5"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FDB305967
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123766; cv=none; b=eHMDBxpkvpRUGtowd56L6aM1prVAnHHTl37LLlGvuqDd3fy8THSfNH+DXmzrpPXHbaL5pTjUNM4TZPgkQ13uNs2GW9jSl9wRZSsuurOmem3d1EMzlrbQSzZsTUKt+Kt5RdHc0TCMzYx3cpCLtKGPtLyQVqUVpjU45gUBoU5a99k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123766; c=relaxed/simple;
	bh=RAn9DUN+XwBeOn/ARjMhyZhD6sfiWfeYDtT/mcFMGBs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zcg1lCARTAmcvpq8O6Fyv1mQ2+of606i3W8IYox87gp7C0UZw7zSqAzgs/H1RDJPNfRXCwdNDZqY1GjboVGh6cLYI34BOqaOJx6ns2ZBQUvf98aOw4yiiI7XF1AH8BJFNIVdYtt9a4g+VG6xlhQYta7qjIlV64jwjLHD6oYWbKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N3c3SpV5; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 87A9AC0B8B2;
	Wed, 22 Oct 2025 09:02:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 36F36606DC;
	Wed, 22 Oct 2025 09:02:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 00CFE102F2424;
	Wed, 22 Oct 2025 11:02:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761123760; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oDRCUkMoCDby5S/aZrDjp1VXkak+fQdoG5RdkGXcB4Y=;
	b=N3c3SpV57p5/GKS5PSw7jmNA1udiZ4jXASbHWVwRfwDneehJCGrqoNujIJH7dGUKy0P8SW
	Gwrpaj8sBhW97sO2TJlj8vA7fDjThqucjwNAkTfRgMBJkr8p00UXfw91V42W6vvZ5JfYG7
	/JcxDVomjRkPhkCUi0EjhpriqPlXzOYXf7jxDf/1NgdjYTNRQTC49WHgvkdL2eG1X9H7uy
	AHbENFrT5qNHYN54ydrdcpWeFSohXnMloWLAIJPKC6d0LrS9ldokxcFZ5I5ZRpgMDEtssH
	8QdrA8u6UmMSsYRO7b6XVxk3mYwdc6y3gp651iSnUuhM67xdB46zehcfJ1INfw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Chen-Yu Tsai
 <wens@csie.org>,  Jernej Skrabec <jernej.skrabec@gmail.com>,  Samuel
 Holland <samuel@sholland.org>,  Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,  Wentao Liang <vulab@iscas.ac.cn>,  Johan
 Hovold <johan@kernel.org>,  Maxime Ripard <mripard@kernel.org>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  linux-mtd@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-sunxi@lists.linux.dev,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/15] mtd: rawnand: sunxi: rework pattern found
 registers
In-Reply-To: <20251020101311.256819-6-richard.genoud@bootlin.com> (Richard
	Genoud's message of "Mon, 20 Oct 2025 12:13:01 +0200")
References: <20251020101311.256819-1-richard.genoud@bootlin.com>
	<20251020101311.256819-6-richard.genoud@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 22 Oct 2025 11:02:36 +0200
Message-ID: <87plaftikz.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Richard,

On 20/10/2025 at 12:13:01 +02, Richard Genoud <richard.genoud@bootlin.com> =
wrote:

> On H6/H616, the register ECC_PAT_FOUND is at its own address, and not
> part of ECC status register.
> So, introduce the pattern found register offset in sunxi_nfc_caps, along
> with its mask.
>
> Also, introduce a non compile-time field_get() because FIELD_GET() and
> u32_get_bits() don't work with non compile-time constant.
> https://lore.kernel.org/lkml/cover.1739540679.git.geert+renesas@glider.be/
>
> No functional change.
>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  drivers/mtd/nand/raw/sunxi_nand.c | 36 ++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sun=
xi_nand.c
> index 8f5d8df19e33..4cfb5d3e9c06 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -29,6 +29,9 @@
>  #include <linux/iopoll.h>
>  #include <linux/reset.h>
>=20=20
> +/* non compile-time field get */
> +#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) -
> 1))

I see there are already 26 users for this, let's hope it gets merged
soon and this one dropped.

Not a blocker for me.

Miqu=C3=A8l

