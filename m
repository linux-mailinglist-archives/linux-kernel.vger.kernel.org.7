Return-Path: <linux-kernel+bounces-827888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5582B935CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F151176F82
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078B923C516;
	Mon, 22 Sep 2025 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tTCFSCQ5"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613591A9F93
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575947; cv=none; b=cPf6Qquie+sJ2XeB/7Fx5c5FQ4K2jjtgBOsf1h/+qxfayiiO3PfrDjgDk61U56lN1WZtygPiZC+BXMhT4qnTNMIJL7g9I43TT9IJuz0qFSLyU7sZ/WnDHMCHXxK/9rh7WIXhLdBTDF8foVzSpbv4G4BNqbvP+Q705M7RbhXfwiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575947; c=relaxed/simple;
	bh=MI5tLMZdBGbBrKXk75JOzF8Rb3NYMcK9pA4kRzdaLXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICSt8x1/yez8saCldnQ1ydsHtb5yx5uoAyiYBoQc1jCKqKgXvFeMMKaeHTX+GEWTnexJM1NnGQNrIaK05Y+UydEyNqHSvP+jvHHIIKJ4g/H1e5quJSveNPRpPVA5+dAuQTkrUeeXv6+1tGtfennDxFc+exrgowaXwJqHUyWN7DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tTCFSCQ5; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-34112cbfc85so1355409fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758575943; x=1759180743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q2c4nwkNiyMR3avhrupjYBq5ngF3Pu57vNUIHIWJPCM=;
        b=tTCFSCQ55ZVKCKLAwd0slkA5ye3VfNjSD6RkbYvnZa5U0ElDVNvrlczAmEXSLSC7/r
         Qc8b0dhJzapxAjGOakJ0wdLbGt18V5vRILdKePM1Eq8isQ8e8aeK0mMYeHMTfFwMGlVD
         lEVrGM06bN/vKG/xYbA6dCXdyUvMwmYXPzcaf8gf18q/domTC71mZoG+2YyMf3m1oONW
         onUbo6tn/bsTez/c5RVWFjFWvjWayU1lHxa60PVpYIolUouwDEeV5wzvZERBkBCCXbiv
         QgCHCqFJwEM/E57Bz3dcDXmhj0FHg3+udVxHrTizAp5hPEfvF1SHv3I5LKyXafuBu4RC
         RacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758575943; x=1759180743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2c4nwkNiyMR3avhrupjYBq5ngF3Pu57vNUIHIWJPCM=;
        b=vKd7js3sYFB1shj860GjKN2+D5Cc2KKtaZpXakHjs54oygtoFKRKWhMyEevAQfpgwa
         OOLLsmRivZcSkkrt7khr2rWFytbXHas/NLZFo0jJRhm2HdVUShKfJpg0oqGplxoegWSH
         b3s0Z734jI6dw8PC0WDw3DrV5W151uaXDxc+4No0lB7XPKv2KJxdP6ZNVgcvUAqMDSSO
         Dt9V/kXXoU+pkLFsiNfhZVaeEX8cEM2FhCLnvyOCYZEEcotk69eNJ/qXIRzijpxUBq43
         mHHmtyqBOebJxZvW3vhNq6w3z7jcaTecmTUrLEbqa0mEzSXVb91pDTPMceaOFpezIU+C
         XF/Q==
X-Gm-Message-State: AOJu0Yyk+dyt9j5KQZJgnBagZA9Jisihs3UdCu18yjfk9BXFcvuY4S/V
	k6bWP3zTj/lCb7shdhoeI18z0cwlH4zpB9o0ywSOhNA1LfRWDn/7uJ2BmYSC8oIM3p4=
X-Gm-Gg: ASbGncvH0/v7eZNWwwNbmeI4Vw2ibmiQq/20QYqLCgUoDWtQADmFT9M9MQ+Mbpc+pe/
	WMwEEh0oVS7+9uupRzItDBSuCqlxXM1rW/nyeEGf35cPuP4ric89ez01Hu6V2pCn0oDRhWEI94i
	RJdm+LbxKInTYGwWKNtjEKqnWZbJosyQT11FCYzHELOT5AZT6EtHzNJg0o89OXbRI4lYiYXyQCh
	F9U9RElZdwCWgrP64RWgEuMIfOXasT5Z6fnxip09lGv25ORSA14QmcXkpn8uC6Gyey/63HiWCff
	CGb9008y1xixs3bBBKzz6Jl+pTrfi2ZHqdPFFN4s1oY5Yjaad2/jRFfRDqi1ZQugv/tRdX1MYjL
	VhIN0el6nb+sNfvgqfnrLplf3w7XFrf+jscu0dZLBFVCDKR5mcKLjePWhT8gIxR/kC5P4Ww7eqX
	Q=
X-Google-Smtp-Source: AGHT+IEy2v9bgZwS7bCF+QjAPCajER2/ekE30YoyHmLioI13RbWg+IXdCZ7A77duoSqvHz2Nge2WYg==
X-Received: by 2002:a05:6870:ab05:b0:31d:63f9:b247 with SMTP id 586e51a60fabf-34c858e36c4mr153841fac.25.1758575943355;
        Mon, 22 Sep 2025 14:19:03 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:505f:96cd:1359:fff4? ([2600:8803:e7e4:1d00:505f:96cd:1359:fff4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-349992164b2sm691181fac.15.2025.09.22.14.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 14:19:02 -0700 (PDT)
Message-ID: <69cbe12f-3202-499e-a135-a00ff6ec9c51@baylibre.com>
Date: Mon, 22 Sep 2025 16:19:01 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iio: mpl3115: add support for sampling frequency
To: Antoni Pokusinski <apokusinski01@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux@roeck-us.net, rodrigo.gobbi.7@gmail.com,
 naresh.solanki@9elements.com, michal.simek@amd.com,
 grantpeltier93@gmail.com, farouk.bouabid@cherry.de,
 marcelo.schmitt1@gmail.com
References: <20250921133327.123726-1-apokusinski01@gmail.com>
 <20250921133327.123726-4-apokusinski01@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250921133327.123726-4-apokusinski01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/25 8:33 AM, Antoni Pokusinski wrote:
> When the device is in ACTIVE mode the temperature and pressure measurements
> are collected with a frequency determined by the ST[3:0] bits of CTRL_REG2
> register.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
>  drivers/iio/pressure/mpl3115.c | 80 ++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> index cf34de8f0d7e..2f1860ca1f32 100644
> --- a/drivers/iio/pressure/mpl3115.c
> +++ b/drivers/iio/pressure/mpl3115.c
> @@ -28,6 +28,7 @@
>  #define MPL3115_INT_SOURCE 0x12
>  #define MPL3115_PT_DATA_CFG 0x13
>  #define MPL3115_CTRL_REG1 0x26
> +#define MPL3115_CTRL_REG2 0x27
>  #define MPL3115_CTRL_REG3 0x28
>  #define MPL3115_CTRL_REG4 0x29
>  #define MPL3115_CTRL_REG5 0x2a
> @@ -46,6 +47,8 @@
>  #define MPL3115_CTRL_ACTIVE BIT(0) /* continuous measurement */
>  #define MPL3115_CTRL_OS_258MS (BIT(5) | BIT(4)) /* 64x oversampling */
>  
> +#define MPL3115_CTRL_ST (BIT(3) | BIT(2) | BIT(1) | BIT(0))

Can be simplified with GENMASK(3, 0).

Would also be more clear to call it MPL3115_CTRL_REG2_ST.
Otherwise it looks like it overlaps with the bits above
and below.

> +
>  #define MPL3115_CTRL_IPOL1 BIT(5)
>  #define MPL3115_CTRL_IPOL2 BIT(1)
>  
> @@ -53,6 +56,25 @@
>  
>  #define MPL3115_CTRL_INT_CFG_DRDY BIT(7)
>  
> +static const unsigned int mpl3115_samp_freq_table[][2] = {
> +	{ 1,      0},
> +	{ 0, 500000},
> +	{ 0, 250000},
> +	{ 0, 125000},
> +	{ 0,  62500},
> +	{ 0,  31250},
> +	{ 0,  15625},
> +	{ 0,   7812},
> +	{ 0,   3906},
> +	{ 0,   1953},
> +	{ 0,    976},
> +	{ 0,    488},
> +	{ 0,    244},
> +	{ 0,    122},
> +	{ 0,     61},
> +	{ 0,     30},

Didn't check these all, but got 30.5... for the last one, which
would round to 31. Not that it matters much in this case. ;-)

> +};
> +
>  struct mpl3115_data {
>  	struct i2c_client *client;
>  	struct iio_trigger *drdy_trig;
> @@ -163,10 +185,60 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = i2c_smbus_read_byte_data(data->client, MPL3115_CTRL_REG2);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret &= MPL3115_CTRL_ST;

FIELD_GET() would be appropriate here.

> +
> +		*val = mpl3115_samp_freq_table[ret][0];
> +		*val2 = mpl3115_samp_freq_table[ret][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	}
>  	return -EINVAL;
>  }
>  
> +static int mpl3115_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type, int *length,
> +			      long mask)
> +{
> +	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
> +		return -EINVAL;
> +
> +	*type = IIO_VAL_INT_PLUS_MICRO;
> +	*length = ARRAY_SIZE(mpl3115_samp_freq_table) * 2;
> +	*vals = (int *)mpl3115_samp_freq_table;
> +	return IIO_AVAIL_LIST;
> +}
> +
> +static int mpl3115_write_raw(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct mpl3115_data *data = iio_priv(indio_dev);
> +	int i, ret;
> +
> +	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(mpl3115_samp_freq_table); i++)
> +		if (val == mpl3115_samp_freq_table[i][0] &&
> +		    val2 == mpl3115_samp_freq_table[i][1])
> +			break;
> +
> +	if (i == ARRAY_SIZE(mpl3115_samp_freq_table))
> +		return -EINVAL;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG2, i);

This potentially clears some unrelated bits. I guess it is not a problem for
now since those bit aren't used, but could be easy to overlook in the future.

Also, FIELD_PREP() would be appropriate.

> +	iio_device_release_direct(indio_dev);
> +	return ret;
> +}
> +
>  static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -224,6 +296,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
>  		.type = IIO_PRESSURE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available =
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.scan_index = 0,
>  		.scan_type = {
>  			.sign = 'u',
> @@ -237,6 +312,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
>  		.type = IIO_TEMP,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available =
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.scan_index = 1,
>  		.scan_type = {
>  			.sign = 's',
> @@ -307,6 +385,8 @@ static const struct iio_trigger_ops mpl3115_trigger_ops = {
>  
>  static const struct iio_info mpl3115_info = {
>  	.read_raw = &mpl3115_read_raw,
> +	.read_avail = &mpl3115_read_avail,
> +	.write_raw = &mpl3115_write_raw,
>  };
>  
>  static int mpl3115_trigger_probe(struct mpl3115_data *data,


