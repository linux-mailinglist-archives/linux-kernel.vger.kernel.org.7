Return-Path: <linux-kernel+bounces-803716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34919B4640C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E344F1C8658C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E672868A9;
	Fri,  5 Sep 2025 19:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uzU2HdaD"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786C3283121
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102371; cv=none; b=a91N97DxERkVxY0KnBtDviDkt4CjBN6VrsCcVF5YxzTp9dpa63qLu68PTLD1okeeIWtW/dRF7bwhQQk1kjnWVsidhBV+kyRIFM1+3wikhqh1Pc3yYtnQHfAdEc+wrNCe0tgbL6vFVR6ItXMlL6tzb4NSp5inJ2CmWbegmtE5Z90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102371; c=relaxed/simple;
	bh=a/JV8A5G5nUlEZdYoKuMxsVvh45VgOaostPKBr7+uLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ApI6JtlzwBjPpOPWSwwAjRN3ljkL9VfRWMr5rBo7sbvjPmsQ96mKfVnjOayAtQrx8uSUJHMCQoma08w4/SbWiAyjM1QzZvKvWVel5zIXWsZFQA2pc8uMJrfyoQdrfuJc4l0u2VmlGr3v7D4DdZKKrotBLUuSict4iaObUpWTieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uzU2HdaD; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-61e73b1544fso910113eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757102368; x=1757707168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFR/qTe+EjunSfm8G+3G1jdMJoO0CoueuRNYqBhRg2g=;
        b=uzU2HdaD4ZbysLu+TPYfrLl4L0Ovmi4mOoyWrLcU/6/6EsvR12mRGV4XTFyJrC6FkN
         bIL5aMjbvWkC+FFAESkHI76rHvAAmGKcgfllYPpprWy0YprBrAGK3rn8Ny/Qkt/Iu+Do
         gAZ5nzPQ0+x1kT97yM15tAoUT/Aq1LZEzbk88/GNMlsSNXqW9+KAoj3guyQz8fPtqGEm
         nObR45dbd79YzESzywlo1mvkz9n1ByabcgPbW3G/ODIsmJEYSbZ/zRETsA3wGQY8jepQ
         nRkAt0K0p2yCmEHSf1vecQUS3jAGNK/Zu1+fM0Q3vgaJltkaP+e5ZSWw0HOnn2/jTdJc
         37iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102368; x=1757707168;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFR/qTe+EjunSfm8G+3G1jdMJoO0CoueuRNYqBhRg2g=;
        b=o0UBL5UzutIV5Nq5ozGR8IX5CPix/9bRalOsh4zPqoIt2a2AG81EdBCrSrp+9r8hoE
         I3IA2YCwtllPvUFIECvSPXnSXA+VFMNVwIuM/qCe4MrYFSVHdLQbqaeA9vm410VYta32
         CrLXkjtF/K/3fMCD527npgsE1LUSUR8ri9+JTZfMtbUSrxsp0rzEOAvQMGB1hKjd0T8j
         x48dY8uZs1W6jQcMlytQ0N1/MaqFMDKLyaqj8gB0P4agcN4ako5FNihsueiHpyLmzHF5
         BRJif0C/tqqdEAKRvcjcosdaZcJK3bzipJL7MO6EwZfTOrcfX6+Dpk/D/ypk6Eb+OYer
         yoSg==
X-Forwarded-Encrypted: i=1; AJvYcCW2zchkC/e2V+cv+nQQqPb2YPCYxPsNsvVZHFqxS/AfbFPNBFnQoEs3Q0pci0+iTFlToq9ohTHbbYue4M0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0LHWavN7HwPEv8ZWzx64oRC6GSoWzrPdlEro++joGpE6QQxkM
	PZe64CP0s8tl6G5h1DmC2wJxvlxbGRAG95UPOHnRbAn+tQYBklUvqeBQlFSOdhn6D9Q=
X-Gm-Gg: ASbGncsQIvJsCuS+HwaerlDbTb7wqcFnGOz/HXkjhnSzPqKqp5ul2nxgMLpUYyVHrQi
	YF/gsLiRLvnpAfbqz/YwJMaNR166YnGxrMP7gMdQdmqTKL7XBWdSira3GAoVpJm/cOBBp3GKcJL
	UN0lAH/LStnOPkxgUDEQQrDiP+etzgTrP+LU4JZcJmSygId6DTP8lgwHF59/xmokZbOzPuunNjl
	z2J/OoNjBYzn6O6EUe65v3foiabvu0rjCpPWx51tk5W+nAsAC0RvTiIy5nCr0JiiiTJ9Ssca8Ba
	fSjvQEn4giyIKYoLcUG38unrvaY9OgL1UGbO3jPknsXJx6TkFd4p82F9SySdrftTpgSxzMyFD+4
	O9JX+h6LecQBHKnJgSol0XxGdGVVynbTb7fKl8b+RNdQ6649OQXvbnWjrurKniz2f/e7KMhwg
X-Google-Smtp-Source: AGHT+IEHh2lFTOh4uKfrurbVep0wcCUizsaolUYPgwaH94RRZXYqurYKFtUABG/PLJ82S8PBBjhL+A==
X-Received: by 2002:a05:6808:1244:b0:439:8e9:637c with SMTP id 5614622812f47-43b29b4c490mr6359b6e.25.1757102368483;
        Fri, 05 Sep 2025 12:59:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:52e:cda3:16cc:72bb? ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-438237053d2sm2290875b6e.30.2025.09.05.12.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 12:59:28 -0700 (PDT)
Message-ID: <cf18ede2-2077-41f4-a49c-adb3c13c4c44@baylibre.com>
Date: Fri, 5 Sep 2025 14:59:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] iio: accel: BMA220 add LPF cut-off frequency
 mapping
To: Petre Rodan <petre.rodan@subdimension.ro>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
 <20250901194742.11599-7-petre.rodan@subdimension.ro>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250901194742.11599-7-petre.rodan@subdimension.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 2:47 PM, Petre Rodan wrote:
>  - add mapping for the low pass filter cut-off frequency.
>  - make valid values visible for both the cut-off frequency and the scale.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
>  drivers/iio/accel/bma220_core.c | 60 ++++++++++++++++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
> index 86347cf8ab1e..e60acd62cf96 100644
> --- a/drivers/iio/accel/bma220_core.c
> +++ b/drivers/iio/accel/bma220_core.c
> @@ -4,6 +4,15 @@
>   *
>   * Copyright (c) 2016,2020 Intel Corporation.
>   * Copyright (c) 2025 Petre Rodan  <petre.rodan@subdimension.ro>
> + *
> + *
> + * Device register to IIO ABI mapping:
> + *
> + * Register                  | IIO ABI (sysfs)                | valid values
> + * --------------------------+--------------------------------+---------------
> + * scale (range)             | in_accel_scale                 | see _available
> + * cut-off freq (filt_config)| in_accel_filter_low_pass_...   | see _available
> + * ---------------------------------------------------------------------------
>   */
> 
>  #include <linux/bits.h>
> @@ -135,13 +144,23 @@
> 
>  #define BMA220_DEVICE_NAME			"bma220"
> 
> +#define BMA220_COF_1000HZ			0x0
> +#define BMA220_COF_500HZ			0x1
> +#define BMA220_COF_250HZ			0x2
> +#define BMA220_COF_125HZ			0x3
> +#define BMA220_COF_64HZ				0x4
> +#define BMA220_COF_32HZ				0x5
> +
>  #define BMA220_ACCEL_CHANNEL(index, reg, axis) {			\
>  	.type = IIO_ACCEL,						\
>  	.address = reg,							\
>  	.modified = 1,							\
>  	.channel2 = IIO_MOD_##axis,					\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
> +	    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),		\
> +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) |\
> +	    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),		\
>  	.scan_index = index,						\
>  	.scan_type = {							\
>  		.sign = 's',						\
> @@ -172,6 +191,7 @@ struct bma220_data {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	struct mutex lock;
> +	u8 lpf_3db_freq_idx;
>  	u8 range_idx;
>  	struct iio_trigger *trig;
>  	struct {
> @@ -188,6 +208,18 @@ static const struct iio_chan_spec bma220_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
> 
> +/*
> + * Available cut-off frequencies of the low pass filter in Hz.
> + */
> +static const int bma220_lpf_3db_freq_hz_table[][2] = {
> +	[BMA220_COF_1000HZ] = {1000, 0},
> +	[BMA220_COF_500HZ] = {500, 0},
> +	[BMA220_COF_250HZ] = {250, 0},
> +	[BMA220_COF_125HZ] = {125, 0},
> +	[BMA220_COF_64HZ] = {64, 0},
> +	[BMA220_COF_32HZ] = {32, 0},

If all of these are integer values, why do we need 2-D table?

> +};
> +
>  static const unsigned long bma220_accel_scan_masks[] = {
>  	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
>  	0
> @@ -309,6 +341,11 @@ static int bma220_read_raw(struct iio_dev *indio_dev,
>  		*val = bma220_scale_table[index][0];
>  		*val2 = bma220_scale_table[index][1];
>  		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		index = data->lpf_3db_freq_idx;
> +		*val = bma220_lpf_3db_freq_hz_table[index][0];
> +		*val2 = bma220_lpf_3db_freq_hz_table[index][1];
> +		return IIO_VAL_INT_PLUS_MICRO;

Why not IIO_VAL_INT?

>  	}
> 
>  	return -EINVAL;
> @@ -353,6 +390,22 @@ static int bma220_write_raw(struct iio_dev *indio_dev,
>  				"failed to set measurement range\n");
>  		data->range_idx = index;
> 
> +		return 0;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		index = bma220_find_match(bma220_lpf_3db_freq_hz_table,
> +					  ARRAY_SIZE(bma220_lpf_3db_freq_hz_table),
> +					  val, val2);
> +		if (index < 0)
> +			return -EINVAL;
> +
> +		ret = regmap_update_bits(data->regmap, BMA220_REG_FILTER,
> +					 BMA220_FILTER_MASK,
> +					 FIELD_PREP(BMA220_FILTER_MASK, index));
> +		if (ret < 0)
> +			dev_err(data->dev,
> +				"failed to set low pass filter\n");

Should `return ret;` here rather than logging error.

> +		data->lpf_3db_freq_idx = index;
> +
>  		return 0;
>  	}
> 
> @@ -370,6 +423,11 @@ static int bma220_read_avail(struct iio_dev *indio_dev,
>  		*type = IIO_VAL_INT_PLUS_MICRO;
>  		*length = ARRAY_SIZE(bma220_scale_table) * 2;
>  		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		*vals = (const int *)bma220_lpf_3db_freq_hz_table;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		*length = ARRAY_SIZE(bma220_lpf_3db_freq_hz_table) * 2;
> +		return IIO_AVAIL_LIST;
>  	default:
>  		return -EINVAL;
>  	}
> --
> 2.49.1
> 


