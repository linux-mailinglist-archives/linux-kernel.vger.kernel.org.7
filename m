Return-Path: <linux-kernel+bounces-836489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CC5BA9D74
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685413AB2CA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228EC30BBA5;
	Mon, 29 Sep 2025 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JprmrIwl"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A762BF00B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759160835; cv=none; b=Y30auOuVOxevGWYntOcbz91iUHdKNNwYNX7WFsAfzRaA/KERDoVA2frtwOrW41TDFeiYjUp0hqM8Fvs8yaBGpncaP/LQaZnpPvX7jCOwz6s6Uc81k4GD9VyAaFQw/QLpGQyrrO37kzshG2p0/1RolJ1Cd4s1VVFg6lz9H3oGPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759160835; c=relaxed/simple;
	bh=dHV6fr+dv8yeafKARztxV5sCqMeDZmZT3iZ2JptyU9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjI6bRleYT9OhjJys+mqbZgn7jbxZIxNWkDmNqTtkc+oP+cG6aeAiSP/3xMajBsOCj4KdM9Q3S/nzQrC0+PYAYqalf1/E7VcJalmOieoGYiI+NXWFDeWtoOJjCPP+6KRwOmd38Q7oB0qHxd4sBj1jmbqgPV53/SnfOMpYQWRWKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JprmrIwl; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3612c38b902so21821661fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759160831; x=1759765631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mj16NYHSePARtauWGJMZX4OHrp+lmJKr7bOaSlQ4c+k=;
        b=JprmrIwlCikAhjOGWHEqccbfMzhM01g/AhMjVUJGnEhcqXk5tpa6M0Ng0B3PmqVS84
         mUjb3cACoTUUAe2MbxXvEfkOPaA/8AHJcoyMbvNMkg/yYLMcS4FaT1its7sOByyA6yCS
         6IUMfX9Ntgll/T+QQFRKBo0Dg6zURFq8sH553/zyH4xkFbZerqsRATklz5fD92J8/iIT
         RXJqFWmQ/GUIb+iTt9JHyf9RMhWMYX2KH4daID0nmoqFEeTkW8z/LKJBrQhRWF7U/tzA
         b+jJr+YGqL+GRGQzoVsAcBmJYMr+SbWhaRY+d3XswF1vq37epBHJn05Gwd0xW0ERwYb0
         hjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759160831; x=1759765631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mj16NYHSePARtauWGJMZX4OHrp+lmJKr7bOaSlQ4c+k=;
        b=j/9G7c1X5SeCbVTssbqAniB5tNm02K82jvq7FFoLkMREFBx71xh5+bLbvN0H4c3Anr
         t/ecyAss+JrN3DTEwU8/G+IK7rhkRRDi9rwqTEpTiAEIb78fVcIMaAYs9uU8POUlNnd5
         DOzAOu+oGo5Sulyhw1JlC/yw4+b3gh/rSu7WLHURoEVr78kBZNbHK9Hh4+gvadVTQdtK
         IOZr6Ut8Akg7IFRtfk5fRSJGLwQyGZAcelGBFLKDU02Z/NEDjXMOxzIi4da1wpmVIgoP
         ykXyUlFEKsPeOT1DBTmtakXWmfnZeYSJtv1dC/2zRfgh0DVeK3BLs7mk87giWSRc4Jz8
         PFyw==
X-Forwarded-Encrypted: i=1; AJvYcCVG4h+OMIm9nSHZ2OCSNWvgTWQaNP+jguBkUP8mI+j4Nsv0b3l1CXru6O/kNYzn/b2Lc35HshBmmCqd3F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYkb/8thYnhjwNyphZEZij9j6ECfCcEAKVAr2RJdhUxMogaEcJ
	Cj8yCpGf5nQx2dHts+bhvx6CgTf4nGE8iQov91pXy8eGOlrT6pUN4RnF+OxHxRjNDsj2WYmNTiW
	nv/6qnO6qf0qQvGVGUOIZtpajpMFMPRzX14tRAMnGiQ==
X-Gm-Gg: ASbGncuQAYO5jgswQkhrBeldCg6zKS1pxqw6BHrS0pxyms1mDQtsKWV+Ny67VLfFMVW
	rwN8mINeeMlxyPLJPdb9FdRvYbpZZs61yugGfb0Q1MazeHRYpLDKS4nFW2ezNDjE5nvvSXTHpnG
	U9pfANlhhSgbI7R8uYlSeekxTXlQxRAOYKNMV8iCAcD+E33PrtEfgQVvs76Pqfe03YVvgLY7rsp
	0Vw5BI=
X-Google-Smtp-Source: AGHT+IGX9f1TpZoODQmAxA8Tak+SZcsyNzqaQ6/XhEFMQL3Dbia52WbpUT464G1ke86qG0dZIH+qKmVdMN4xCd/ez68=
X-Received: by 2002:a05:651c:981:b0:36b:f63:2785 with SMTP id
 38308e7fff4ca-36f7f2485d7mr60972211fa.27.1759160831132; Mon, 29 Sep 2025
 08:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929145909.111243-1-antoniu.miclaus@analog.com>
In-Reply-To: <20250929145909.111243-1-antoniu.miclaus@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 29 Sep 2025 17:46:59 +0200
X-Gm-Features: AS18NWAke2Vzy58yaVK0orZeedCnzUntMDrOOf2F7kNqhH8hiHHVjH4H4JS4ka4
Message-ID: <CAMknhBG5nPMnSUnPA_4OyX+c=WiCJqTdm-QLwQGo4fdkfR8w9w@mail.gmail.com>
Subject: Re: [PATCH 1/5] iio: adc: ad4080: prepare driver for multi-part support
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 4:59=E2=80=AFPM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:
>
> Refactor the ad4080 driver to support multiple ADC variants with
> different resolution bits and LVDS CNV clock count maximums.
>
> Changes:
> - Update AD4080_CHIP_ID to correct value 0x50
> - Add lvds_cnv_clk_cnt_max field to chip_info structure
> - Create AD4080_CHANNEL_DEFINE macro for variable resolution/storage bits
> - Use AD4080_REG_PRODUCT_ID_L register for chip identification
> - Make LVDS CNV clock count configurable per chip variant
>
> This prepares the infrastructure for adding support for additional
> ADC parts with different specifications while maintaining backward
> compatibility with existing AD4080 functionality.
>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/adc/ad4080.c | 46 ++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index 6e61787ed321..9f670c290a55 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c
> @@ -125,7 +125,7 @@
>
>  /* Miscellaneous Definitions */
>  #define AD4080_SPI_READ                                                B=
IT(7)
> -#define AD4080_CHIP_ID                                         GENMASK(2=
, 0)
> +#define AD4080_CHIP_ID                                         0x50

This sounds like a bug fix, so should be in a separate patch with a Fixes: =
tag

>
>  #define AD4080_LVDS_CNV_CLK_CNT_MAX                            7
>
> @@ -167,6 +167,7 @@ struct ad4080_chip_info {
>         const unsigned int (*scale_table)[2];
>         const struct iio_chan_spec *channels;
>         unsigned int num_channels;
> +       unsigned int lvds_cnv_clk_cnt_max;
>  };
>
>  struct ad4080_state {
> @@ -414,23 +415,25 @@ static struct iio_chan_spec_ext_info ad4080_ext_inf=
o[] =3D {
>         { }
>  };
>
> -static const struct iio_chan_spec ad4080_channel =3D {
> -       .type =3D IIO_VOLTAGE,
> -       .indexed =3D 1,
> -       .channel =3D 0,
> -       .info_mask_separate =3D BIT(IIO_CHAN_INFO_SCALE),
> -       .info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -                       BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> -       .info_mask_shared_by_all_available =3D
> -                       BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> -       .ext_info =3D ad4080_ext_info,
> -       .scan_index =3D 0,
> -       .scan_type =3D {
> -               .sign =3D 's',
> -               .realbits =3D 20,
> -               .storagebits =3D 32,
> -       },
> -};
> +#define AD4080_CHANNEL_DEFINE(bits, storage) {\

At least add one space before \. Although I think aligning all \ on
the right is preferred for readability.

> +       .type =3D IIO_VOLTAGE,\
> +       .indexed =3D 1,\
> +       .channel =3D 0,\
> +       .info_mask_separate =3D BIT(IIO_CHAN_INFO_SCALE),\
> +       .info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) |\
> +                       BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),\
> +       .info_mask_shared_by_all_available =3D\
> +                       BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),\
> +       .ext_info =3D ad4080_ext_info,\
> +       .scan_index =3D 0,\
> +       .scan_type =3D {\
> +               .sign =3D 's',\
> +               .realbits =3D (bits),\
> +               .storagebits =3D (storage),\
> +       },\
> +}
> +
> +static const struct iio_chan_spec ad4080_channel =3D AD4080_CHANNEL_DEFI=
NE(20, 32);
>
>  static const struct ad4080_chip_info ad4080_chip_info =3D {
>         .name =3D "ad4080",
> @@ -439,6 +442,7 @@ static const struct ad4080_chip_info ad4080_chip_info=
 =3D {
>         .num_scales =3D ARRAY_SIZE(ad4080_scale_table),
>         .num_channels =3D 1,
>         .channels =3D &ad4080_channel,
> +       .lvds_cnv_clk_cnt_max =3D AD4080_LVDS_CNV_CLK_CNT_MAX,
>  };
>
>  static int ad4080_setup(struct iio_dev *indio_dev)
> @@ -458,11 +462,11 @@ static int ad4080_setup(struct iio_dev *indio_dev)
>         if (ret)
>                 return ret;
>
> -       ret =3D regmap_read(st->regmap, AD4080_REG_CHIP_TYPE, &id);
> +       ret =3D regmap_read(st->regmap, AD4080_REG_PRODUCT_ID_L, &id);

If there is also a high word, then this should probably be
regmap_bulk_read() to read the entire product ID.

>         if (ret)
>                 return ret;
>
> -       if (id !=3D AD4080_CHIP_ID)
> +       if (id !=3D st->info->product_id)
>                 dev_info(dev, "Unrecognized CHIP_ID 0x%X\n", id);
>
>         ret =3D regmap_set_bits(st->regmap, AD4080_REG_GPIO_CONFIG_A,
> @@ -488,7 +492,7 @@ static int ad4080_setup(struct iio_dev *indio_dev)
>                                  AD4080_REG_ADC_DATA_INTF_CONFIG_B,
>                                  AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_C=
LK_CNT_MSK,
>                                  FIELD_PREP(AD4080_ADC_DATA_INTF_CONFIG_B=
_LVDS_CNV_CLK_CNT_MSK,
> -                                           AD4080_LVDS_CNV_CLK_CNT_MAX))=
;
> +                                           st->info->lvds_cnv_clk_cnt_ma=
x));
>         if (ret)
>                 return ret;
>
> --
> 2.43.0
>
>

