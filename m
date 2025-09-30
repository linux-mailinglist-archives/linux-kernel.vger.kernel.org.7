Return-Path: <linux-kernel+bounces-837663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C69BACDBD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7568D189E422
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A416D25DAFF;
	Tue, 30 Sep 2025 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISXDESIg"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B90282E1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235782; cv=none; b=pu+ofKeCCYwzLdsF/oM5Utmkmepab1838xUTiTylt833VUU5UnO9cu7e5Kji09OeV7Ycz3aGsucI/LtazN82Ui3V7gOu4AOIsQRmtSSB3R4OoXygfKQbeIkupgG14TaC0sVFLVFQn9uiYFxaUh9g5l8G/igs3wtdixnZPuBXNTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235782; c=relaxed/simple;
	bh=PO4Z7RsWEr9TS2rO1KIU895dXjg9NM9W+FTZoaH+pt4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eQeYzPPMVfZ8pNe5lfawkAljxrftIm9jEhbZDtW7i1ua+TplpvYy8o6zVC96nvh+qpb+UfijpYUCdWQvDu0yoiF5u5jAQkZhOql16XGZQ+NLZsim9oB679HtFxeIBhx78vP/llZbRR7Q4Dtthwpm0NzqbtrY7yKlDwERPM1f3SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISXDESIg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso38269875e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759235778; x=1759840578; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSqMeMxFp62mjfJFrogOyzqpaFj/9basZ/ZOODTQzbQ=;
        b=ISXDESIgTmzX65FDX94xfKhdJodUfiCUDyIj6pH3x+Uy+qxZ0whkv8zWhwselXXfiO
         i3WWzgH0Lm9aS673tqyUYyilK+DWKhzG9IvtrNeRChbc668GNb5y/9fmoiccYu8wTArY
         BOaXMF5Ei97sVT9H8+TgFXuNSDCZULFq3mimRgBY1YiTDb2cXuLuHxzKDtp9Zhi/wOWi
         4GMAQGZ+y0riFdfK6RKwDKNS3NDS3zjQ3N57eY8gbNfQUDF6UA3ZaQ4u57SOc9Z+PBLu
         Cn1CzhAdZ5qaC8NROoYPcnP2M2qF2HqLg6hMAcjPntJ9NxXqFnB7Wo5Jtj6QzWr9Ttxi
         vYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235778; x=1759840578;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WSqMeMxFp62mjfJFrogOyzqpaFj/9basZ/ZOODTQzbQ=;
        b=w6Jie9NrRP3z1x4nV7e8vv+OZyiq+iG3yyN83YTH+RXHVGgQWvSZt0K6tqC2mkz1HJ
         Cqz696ifmUeCFcCdjO9Ocj/K/XooNwQrHhJDB7d6t3m5qnK5mGmwahf0PYqS5h8tP4xf
         152AsjYPLEraUoWvdsjwF3c6qIuB1DEk7SVdJedVYQcIf4UTmvXT9enbsPW3B/3LsZ3b
         PQ09pHdodBY4rYKgy8wQ22vQlmtX2CeRX+QHZaqwR8e7DimG42Ia0bY1J91fGmbYjU+S
         fi0CVa3uqPD4MabfrSCIzH7lI8hKQ4NyZXzFZw6vLx8/iiZoiRr3DumMuw9gsEU0Bd4W
         QOMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5wrgk7dlm77Tn1gvgHIri4scSQQkCigi+U0BGXu9dGWNgdn9TheKVgtD+VnRzzrPy28vDUBLMi6G/3mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRsVC0IHU53F1CCVGM70Yn6XRsuXV5VJuhXwucATyv/nz9nalk
	i2Va6IdDAGH4bKy1PRUWb104lm8qnpe+kaDt4Bl6r7xvKcHWNh7a5MVw
X-Gm-Gg: ASbGncvBxOJcCo092kp5Nd3yF+WhmVGWoGSj1nhgfqeaLKYxaCNtzaLEwODwCxpGQap
	trCyn8804xEfFKucg7dkSkIoDTAStuoVnD/V05a6m4/BvaAJqiI97xEEWlwGoBavlo3NqTWbC6o
	QlaeaAKjaRmkn1Cb2dduv6Ca/Fa6RskaZQQgZ805Xdo9YFilWdRgkfV+NV8nxCQ43kVYl71F7a9
	VHzBx7ma5X6zHZtSnTFGtBRN/dCqelXlWkRfID8L6YIbnciapCRv8Qfmvmh+tz4/ybnYBakpTeJ
	ORjJuDE8q5oj9lmMrduYfSfs1A7ZFvZswkAWOSkxUl3yDJpQkIVgqY28O+htzYuGRGWlHyTtWjs
	1dW87s4qxY8H9RPOGoKb5rM6dSnilBQulU+GzSOMu3FY4TiSE894KxmyERq0WO78OYUbcCrSdl+
	nG
X-Google-Smtp-Source: AGHT+IEEuI/smK29cokzonIQEup8jptWQHmNCN9qD9fPZ7mlvXjddn70CPsdhTyJTjYrc79UGdYl3A==
X-Received: by 2002:a05:600c:820b:b0:46e:5100:326e with SMTP id 5b1f17b1804b1-46e510038cbmr92685285e9.23.1759235778385;
        Tue, 30 Sep 2025 05:36:18 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f536a3sm64007895e9.8.2025.09.30.05.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:36:18 -0700 (PDT)
Message-ID: <b4a85ca93590147c3f5943f5b0183765150c81cc.camel@gmail.com>
Subject: Re: [PATCH v2 2/6] iio: adc: ad4080: prepare driver for multi-part
 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 30 Sep 2025 13:36:46 +0100
In-Reply-To: <20250930103229.28696-2-antoniu.miclaus@analog.com>
References: <20250930103229.28696-1-antoniu.miclaus@analog.com>
	 <20250930103229.28696-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-30 at 10:32 +0000, Antoniu Miclaus wrote:
> Refactor the ad4080 driver to support multiple ADC variants with
> different resolution bits and LVDS CNV clock count maximums.
>=20
> Changes:
> - Add lvds_cnv_clk_cnt_max field to chip_info structure
> - Create AD4080_CHANNEL_DEFINE macro for variable resolution/storage bits
> - Make LVDS CNV clock count configurable per chip variant
> - Use chip_info->product_id for chip identification comparison
>=20
> This prepares the infrastructure for adding support for additional
> ADC parts with different specifications while maintaining backward
> compatibility with existing AD4080 functionality.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> changes in v2:
> =C2=A0- allign all the \ to the left in the channel definition.
> =C2=A0drivers/iio/adc/ad4080.c | 42 ++++++++++++++++++++++---------------=
---
> =C2=A01 file changed, 23 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index b80560aebe2d..fa15b8f63b8a 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c
> @@ -167,6 +167,7 @@ struct ad4080_chip_info {
> =C2=A0	const unsigned int (*scale_table)[2];
> =C2=A0	const struct iio_chan_spec *channels;
> =C2=A0	unsigned int num_channels;
> +	unsigned int lvds_cnv_clk_cnt_max;
> =C2=A0};
> =C2=A0
> =C2=A0struct ad4080_state {
> @@ -414,23 +415,25 @@ static struct iio_chan_spec_ext_info ad4080_ext_inf=
o[] =3D
> {
> =C2=A0	{ }
> =C2=A0};
> =C2=A0
> -static const struct iio_chan_spec ad4080_channel =3D {
> -	.type =3D IIO_VOLTAGE,
> -	.indexed =3D 1,
> -	.channel =3D 0,
> -	.info_mask_separate =3D BIT(IIO_CHAN_INFO_SCALE),
> -	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> -	.info_mask_shared_by_all_available =3D
> -			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> -	.ext_info =3D ad4080_ext_info,
> -	.scan_index =3D 0,
> -	.scan_type =3D {
> -		.sign =3D 's',
> -		.realbits =3D 20,
> -		.storagebits =3D 32,
> -	},
> -};
> +#define AD4080_CHANNEL_DEFINE(bits, storage) {				\
> +	.type =3D IIO_VOLTAGE,						\
> +	.indexed =3D 1,							\
> +	.channel =3D 0,							\
> +	.info_mask_separate =3D
> BIT(IIO_CHAN_INFO_SCALE),			\
> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
> +	.info_mask_shared_by_all_available =3D				\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
> +	.ext_info =3D ad4080_ext_info,					\
> +	.scan_index =3D 0,						\
> +	.scan_type =3D {							\
> +		.sign =3D 's',						\
> +		.realbits =3D (bits),					\
> +		.storagebits =3D (storage),				\
> +	},								\
> +}
> +
> +static const struct iio_chan_spec ad4080_channel =3D AD4080_CHANNEL_DEFI=
NE(20,
> 32);
> =C2=A0
> =C2=A0static const struct ad4080_chip_info ad4080_chip_info =3D {
> =C2=A0	.name =3D "ad4080",
> @@ -439,6 +442,7 @@ static const struct ad4080_chip_info ad4080_chip_info=
 =3D {
> =C2=A0	.num_scales =3D ARRAY_SIZE(ad4080_scale_table),
> =C2=A0	.num_channels =3D 1,
> =C2=A0	.channels =3D &ad4080_channel,
> +	.lvds_cnv_clk_cnt_max =3D AD4080_LVDS_CNV_CLK_CNT_MAX,
> =C2=A0};
> =C2=A0
> =C2=A0static int ad4080_setup(struct iio_dev *indio_dev)
> @@ -463,7 +467,7 @@ static int ad4080_setup(struct iio_dev *indio_dev)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	id =3D get_unaligned_le16(&id);
> -	if (id !=3D AD4080_CHIP_ID)
> +	if (id !=3D st->info->product_id)
> =C2=A0		dev_info(dev, "Unrecognized CHIP_ID 0x%X\n", id);
> =C2=A0
> =C2=A0	ret =3D regmap_set_bits(st->regmap, AD4080_REG_GPIO_CONFIG_A,
> @@ -489,7 +493,7 @@ static int ad4080_setup(struct iio_dev *indio_dev)
> =C2=A0				 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
> =C2=A0			=09
> AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
> =C2=A0			=09
> FIELD_PREP(AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
> -					=C2=A0=C2=A0=C2=A0 AD4080_LVDS_CNV_CLK_CNT_MAX));
> +					=C2=A0=C2=A0=C2=A0 st->info->lvds_cnv_clk_cnt_max));
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0

