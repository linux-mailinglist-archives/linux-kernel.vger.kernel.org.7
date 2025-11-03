Return-Path: <linux-kernel+bounces-882776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17720C2B710
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5491898E8D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0323016EE;
	Mon,  3 Nov 2025 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qm1zZ+o+"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1E926CE33
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169644; cv=none; b=bPr60G6nSe43uToaoqMU9Z7o8Lhaz5bnniR8Lw8i18EBwdmHcZDH+myX1zXesbHAcYR6SjcTnKuqa/39RGcr8n+vGEf5bi3987CAuPfGEFUqc46wEXnJww1L9abKQYaRGWiNoBeJzggS/hBAvoulXwXrvDdnvULUArBF4ylJXAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169644; c=relaxed/simple;
	bh=cuQUH77MkBh0VUBEfQGuQkOtLJDnbqOfJIHSvLF3Blg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NTh5crxLjaxyuv4/pCIblfBcWaSAwwihr6P5yeN1dMXoLMHvKBhgMdson6GTdDiv5iAduC/nHt7CkoILphaljKPMmeyL6+pExxLMT1I31yOq5aNifuaMCkUXGhoPv/v401o7aeIHJIq++aeRXBgY/jlExrBYIwWJNK/ee9WZMjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qm1zZ+o+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4298b865f84so1888734f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 03:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762169640; x=1762774440; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vOloNiz/LIv+fxFQ4H8D3qzw660SR91t+vlAvFfeGIo=;
        b=Qm1zZ+o+uZFKnjRV9heoNFHkbIeApl9qHzONenf88RFQO61+ioJpy0ZW1TqyRCeAM9
         akUU/2guK4zn97emgosIuPDn/lWcZrfCtxOtaY1mSJU1egvWOtd9l5Wc04AG1j0x+PmW
         oYe6fSFvbOAFMRqPVy6qTanEnLmNAG/Wm/FCP2pa6qDAhMKT6rcgOhVObVx4H/DIFGzT
         CX5y0VUC0tMBc/zHbeDeuDWOw/cMO+eUxHspQifuUZX9W287zvRkYAhJgU9yV6DKGF8O
         MjBHBKe3hemuMv6zaxeB1ZHkgjVwaUA/RoXO1JnbrKHRG7o09fQ60lL2fT9l4u801LGe
         emTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762169640; x=1762774440;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vOloNiz/LIv+fxFQ4H8D3qzw660SR91t+vlAvFfeGIo=;
        b=uNLu/rOs/uZu6B6w4Mh6QfmeDJy+VGq6jypRYdas0+9ZNB/B46YqOa/NkgOkzOHFao
         vXyXMzFGI9V+1r9bkETJvz0bfP5V7IZAjR6vCpRuyVGoN9nbpCSBA+q0UfeO7b94maqX
         oGymeDP3KSza/+n5xcajwXjaZkA2ZC3uf1r3q2CJ0ZnZaL/7ZvfkxTRKrHABlCRih+6x
         LcPm7WrJqem9aPJAwYBeXmfGaLVfOFU4KlFQFDkEYJMdw2bJSIq8glddVgicF/m0LKx8
         UjBvD3felth+u3y9jldbMx231Gw1TrTftkAeCJZ4T9dS4t4XOHjDCV7pNOrIiCo+Xijs
         RSkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Q8945cRkUjv6bW4J3ELxBdt++izYnYm+JNXWATR2KjF3cE8Zq5Lhep3w6zLmv36leYCjjCwXyEkAp5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJXcX+aPu2PTX5XkXvju1VkXR5UfM5Snphp9kJ+eTDIoX7As9t
	tQYhb6bhG7IQnBrOrgHYF9V12KX9aWzGFl1tTO583U4qt0wSeBSIfZHX
X-Gm-Gg: ASbGncsFdAAxG4BwDPjPIlIzkbICKexFMkn0/DVRnUBTP3lBf4KIfgsjpoW+zhDxc6N
	aI0ezPRUaz8yjjLk/sgSGSm9WiCtTglAoXWH47aWAbi8wzGAomDc/eCII/qfutwC9u+TsNdRKPi
	DsUwCpMFNa5gvV258XA46HoWNG0Tu1qx3XL4iy6jO6ftuN80ZOh1yZazrieq7AEvQD5v9mP+KnV
	jAX1T2BqYTnRFuzXu6dDSoyZmIecMbbPEbvMqduyu9gRE8bshvI8ElB362OVi9GCiLbnE9NBSsm
	wHKQ0WL8QsexK53L/qPbuMIO+nVbb8mQ2EmyV0f0GvnXa6ZtfMg8z5b3QUIZ0rcly+v8eW+GMTf
	iNRFkglS0Z5iW0z6oW30LuUKvypep2z/lp5PLI5Ixgq78IqT0iJD4C2VUWbnk0z2DTdFg4kqLG4
	V6qXYRYXiO
X-Google-Smtp-Source: AGHT+IHEgZpMAanIx/WNbbiJiPaCSI2QOctFxePvc+vMhoOiDgHLLdOJk4neydoG/A7CpeJvkw4SLA==
X-Received: by 2002:a05:6000:24c7:b0:3ec:de3c:c56 with SMTP id ffacd0b85a97d-429bd68cf3fmr10670694f8f.16.1762169640205;
        Mon, 03 Nov 2025 03:34:00 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e1d47sm20034750f8f.23.2025.11.03.03.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 03:33:59 -0800 (PST)
Message-ID: <20e485b69419ffd518c7aeb16881df429b0a4873.camel@gmail.com>
Subject: Re: [PATCH v2 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>,  Wolfram
 Sang <wsa+renesas@sang-engineering.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner	 <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,  Andy Shevchenko	
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven	 <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>, Liam Girdwood	 <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pascal Eberhard	
 <pascal.eberhard@se.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Date: Mon, 03 Nov 2025 11:34:35 +0000
In-Reply-To: <20251029144644.667561-3-herve.codina@bootlin.com>
References: <20251029144644.667561-1-herve.codina@bootlin.com>
	 <20251029144644.667561-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 15:46 +0100, Herve Codina (Schneider Electric) wrote:
> The Renesas RZ/N1 ADC controller is the ADC controller available in the
> Renesas RZ/N1 SoCs family. It can use up to two internal ADC cores (ADC1
> and ADC2) those internal cores are not directly accessed but are handled
> through ADC controller virtual channels.
>=20
> Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.co=
m>
> ---

Not much to add to Andy's review. Looks in good shape... Just one small rem=
ark
from me. With it and Andy's stuff addressed:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +
> =C2=A0drivers/iio/adc/Makefile=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/rzn1-adc.c | 493 ++++++++++++++++++++++++++++++++++=
+++
> =C2=A03 files changed, 504 insertions(+)
> =C2=A0create mode 100644 drivers/iio/adc/rzn1-adc.c
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 58a14e6833f6..113f6a5c9745 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1403,6 +1403,16 @@ config RZG2L_ADC
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the
> =C2=A0	=C2=A0 module will be called rzg2l_adc.
> =C2=A0
> +config RZN1_ADC
> +	tristate "Renesas RZ/N1 ADC driver"
> +	depends on ARCH_RZN1 || COMPILE_TEST
> +	help
> +	=C2=A0 Say yes here to build support for the ADC found in Renesas
> +	=C2=A0 RZ/N1 family.
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the
> +	=C2=A0 module will be called rzn1-adc.
> +
> =C2=A0config SC27XX_ADC
> =C2=A0	tristate "Spreadtrum SC27xx series PMICs ADC"
> =C2=A0	depends on MFD_SC27XX_PMIC || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d008f78dc010..ba7a8a63d070 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -123,6 +123,7 @@ obj-$(CONFIG_ROHM_BD79112) +=3D rohm-bd79112.o
> =C2=A0obj-$(CONFIG_ROHM_BD79124) +=3D rohm-bd79124.o
> =C2=A0obj-$(CONFIG_ROCKCHIP_SARADC) +=3D rockchip_saradc.o
> =C2=A0obj-$(CONFIG_RZG2L_ADC) +=3D rzg2l_adc.o
> +obj-$(CONFIG_RZN1_ADC) +=3D rzn1-adc.o
> =C2=A0obj-$(CONFIG_SC27XX_ADC) +=3D sc27xx_adc.o
> =C2=A0obj-$(CONFIG_SD_ADC_MODULATOR) +=3D sd_adc_modulator.o
> =C2=A0obj-$(CONFIG_SOPHGO_CV1800B_ADC) +=3D sophgo-cv1800b-adc.o
> diff --git a/drivers/iio/adc/rzn1-adc.c b/drivers/iio/adc/rzn1-adc.c
> new file mode 100644
> index 000000000000..52ec13adddef
> --- /dev/null
> +++ b/drivers/iio/adc/rzn1-adc.c
> @@ -0,0 +1,493 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/N1 ADC driver
> + *
> + * Copyright (C) 2025 Schneider-Electric
> + *
> + * Author: Herve Codina <herve.codina@bootlin.com>
> + *
> + * The RZ/N1 ADC controller can handle channels from its internal ADC1 a=
nd/or
> + * ADC2 cores. The driver use ADC1 and/or ADC2 cores depending on the pr=
esence
> + * of the related power supplies (AVDD and VREF) description in the devi=
ce-tree.
> + */

...

>=20
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +

If I'm not missing nothing, there's no real need to pass in indio_dev. So, =
why not
passing rzn1_adc directly and avoid the pointer arithmetic's in the pm call=
backs?

- Nuno S=C3=A1


