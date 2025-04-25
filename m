Return-Path: <linux-kernel+bounces-620629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A778A9CD69
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 17:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0B987AE094
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 15:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD0328A3F9;
	Fri, 25 Apr 2025 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0e4gtQ4M"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E80288C9F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745595815; cv=none; b=V0iQmYMoisTZq0LFNMeuwpw+U/FGsfROneCjLZ4/K0TPRLbCYDS73CPyNJMH+ruGgxc/ZAfb2HYrLFE1uZzGGiRGKSu71iLqQ45CIeJRa0Rgu1uL3PcfDwkiN5E9HZZ/lrw/Kh4V9RHYkoB6Tkh5mNhxqLHlQZZtMx7FK+rlqTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745595815; c=relaxed/simple;
	bh=T7WQdbuZEYuuRqG8sEYxVDJ4OWpRqmcHVT22rNlj0zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkOQgDtcJ+lqyXCpAlcWtqz6LoGnxOW0NfDZqPiWApm0IlkMt18odEPo3+tOX5B9q2KSXZS9Rhr53mOtZfZlTWX0eBdwKR5EPs3otWQPitLBiNQ6zoW5rgEUAvHs0nF3sOV05v8oHQAtpi1NFyAXBjYMXwFPL5KriO1WiJnyKas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0e4gtQ4M; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72c47631b4cso1533728a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 08:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745595811; x=1746200611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZLfxV+qkM+BsTneNqL6B/oPvkwVgnc6zuHICYxdPJlI=;
        b=0e4gtQ4MpimP3/zHQaW4cU1JqwEm8+WFNdhihBhUVnKAYI8zrvjDygvr7Az7z11Wv8
         Sm1nRQnkSDR/b+Me9Af7Qq7m/GabNwgLvVQ0FE04uj3tKRckiDWKWS8IRVz7OyIM6D2r
         +8TBXYrCz/bYJd6DaaHYcqsZ2YS92KRXlxRsBB0rezVkoNyKiwWgrDK7jizYXo0pXVHR
         tYViG/UifD0JyHpr5OJY1XuZy0z+73sRF/2O39AtjKqEFEWJ3S0y3hUTTnF8YSHamP5u
         GiYeznCqWmPXL/PyuiudTH0fZM+Rtf8FnH47Aw/4wWKmKJOSOV+NHSly4jHM5doM8iT8
         IzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745595811; x=1746200611;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLfxV+qkM+BsTneNqL6B/oPvkwVgnc6zuHICYxdPJlI=;
        b=g8z19qcufwzl3snWfo0IUjzJkGTGyVlm019pJiNIwSsh6mvM3yB2BmMnhVa7OzHnS1
         geCtnWTfNrY6hyX7niAazErKR6dGvaFqcc+TwRN17euyMoNBtZ/hs2q1fayuYYCAOK4F
         nqtN7yShI1Csx1qAgddvDG6NSCyM4YrpXaxcLr5rU3dr4v6ORk7uJCymvs4JWpLpXwRy
         nzN3UzM8lwSarDdtTmZ0xzfZZF9ckcfP7/HxZgAI9+J86eGp4YhQbXkhM3rkkab6k9Dk
         iPKNn8g4bqA+7s3iQEdsRDAnmDSL/6BxroiNwFZ+2vrE9Fb1eDVOoE4sSd9R5HrfObIS
         UI6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUa2iydQQsUyMUBgL1Hft72mKFNLudo83xm5mWHXLUw2JFtVwHwll4zd/hFGXs6t+gt6xb6jTZSFN9Z1N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkriCj7lXsQwFYPrkbQ98IgoeVvWK2A8AUm2TVRHhahPtrL82M
	t9Ru+3QpZzYDK+oYwrV31TZrD/wzb6+vGcnaC8kaQE2gsDBfXv9cRnE4s3bHtyk=
X-Gm-Gg: ASbGncttJWRMYxt22inbM+oiL6ko+AJwiYb98xFQH5bPkFoThIFhLWb2cbST6pbG6re
	bXs5pHa/S5EC55OKVd2gLB1dJn9lT8IH86weJtroVBsXX8u1Lri0EO34d40TuyBZ95PNOVGN7G/
	B3nDihBlGWSpS98UsjoIIDUcgoddH5NZhyvIdQVroJZKsm08tBWCrnoZqwP5hjRU88BdPvahxy/
	j71yO3xRHLOxMAAOYmYBAsZgRIfiZRLB6LLayUmnxTGhZKS4N8hX+FaVrbJ3lcRuCs6Pn81v8/I
	SLKbz4F5QWopmpPFv2HVy8MJxbofygvK+UliWXAvUePojdSFa4Akr3sah7QwdfPwxK7Sok6j0f/
	ZlT3Rxffddns+
X-Google-Smtp-Source: AGHT+IGLd0wZdeUiV37lpsqaR5TgFw5rpRRrsdFeVVx3TmOWBRMGj34vcjx+StViUVnHPC3rT2kltA==
X-Received: by 2002:a05:6830:4992:b0:72c:320b:f0ed with SMTP id 46e09a7af769-7305cbfe0cdmr1892482a34.27.1745595810921;
        Fri, 25 Apr 2025 08:43:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:96a3:e28:3f6:dbac? ([2600:8803:e7e4:1d00:96a3:e28:3f6:dbac])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f1a0207sm725489a34.18.2025.04.25.08.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 08:43:30 -0700 (PDT)
Message-ID: <6d0ff620-ec1a-4b17-9b5d-b9c48078271a@baylibre.com>
Date: Fri, 25 Apr 2025 10:43:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] iio: adc: ad7192: Refactor filter config
To: Alisa-Dariana Roman <alisadariana@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
References: <20250425132051.6154-1-alisa.roman@analog.com>
 <20250425132051.6154-2-alisa.roman@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250425132051.6154-2-alisa.roman@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/25 8:20 AM, Alisa-Dariana Roman wrote:
> It is not useful for users to set the 3db filter frequency or the
> oversampling value. Remove the option for these to be set by the user.
> 
> The available arrays for 3db filter frequency and oversampling value are
> not removed for backward compatibility.
> 
> The available array for 3db filter frequency is dynamic now, since some
> chips have 4 filter modes and others have 16.

The available array only makes sense if the matching attribute is writeable.
As mentioned in my reply to the cover letter, I think we should keep it
writeable for backwards compatibility. But we don't need to extend it to allow
writing new options, so keeping the previous available array seems fine to me.

> 
> Expose the filter mode to user, providing an intuitive way to select
> filter behaviour.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  drivers/iio/adc/ad7192.c | 455 +++++++++++++++++++++++++--------------
>  1 file changed, 288 insertions(+), 167 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 530e1d307860..1846dc4e90b0 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -165,9 +165,9 @@
>  #define AD7192_EXT_FREQ_MHZ_MAX	5120000
>  #define AD7192_INT_FREQ_MHZ	4915200
>  
> -#define AD7192_NO_SYNC_FILTER	1
> -#define AD7192_SYNC3_FILTER	3
> -#define AD7192_SYNC4_FILTER	4
> +#define AD7192_FILTER_DIV	1024
> +#define AD7192_FS_MIN		1
> +#define AD7192_FS_MAX		1023
>  
>  /* NOTE:
>   * The AD7190/2/5 features a dual use data out ready DOUT/RDY output.
> @@ -182,6 +182,25 @@ enum {
>  	AD7192_SYSCALIB_FULL_SCALE,
>  };
>  
> +enum ad7192_filter_mode {
> +	AD7192_FILTER_SINC4,
> +	AD7192_FILTER_SINC3,
> +	AD7192_FILTER_SINC4_CHOP,
> +	AD7192_FILTER_SINC3_CHOP,
> +	AD7192_FILTER_SINC4_AVG2,
> +	AD7192_FILTER_SINC3_AVG2,
> +	AD7192_FILTER_SINC4_CHOP_AVG2,
> +	AD7192_FILTER_SINC3_CHOP_AVG2,
> +	AD7192_FILTER_SINC4_AVG8,
> +	AD7192_FILTER_SINC3_AVG8,
> +	AD7192_FILTER_SINC4_CHOP_AVG8,
> +	AD7192_FILTER_SINC3_CHOP_AVG8,
> +	AD7192_FILTER_SINC4_AVG16,
> +	AD7192_FILTER_SINC3_AVG16,
> +	AD7192_FILTER_SINC4_CHOP_AVG16,
> +	AD7192_FILTER_SINC3_CHOP_AVG16,
> +};
> +
>  enum {
>  	ID_AD7190,
>  	ID_AD7192,
> @@ -190,11 +209,24 @@ enum {
>  	ID_AD7195,
>  };
>  
> +struct ad7192_filter_config {
> +	enum ad7192_filter_mode		filter_mode;
> +	unsigned int			f_order;

I assume f means filter? Can we spell that out everywhere we have f_order (in
function names too)?

> +	u8				sinc3_en;
> +	u8				chop_en;
> +	u8				avg_val;
> +	enum iio_available_type		samp_freq_avail_type;

If this is always IIO_AVAIL_RANGE, then we don't need this field.

> +	int				samp_freq_avail_len;

If this is always 2, we don't need this field either.

> +	int				samp_freq_avail[2][2];

Range has 3 elements, start, step, stop. This only has 2.

> +};
> +
>  struct ad7192_chip_info {
>  	unsigned int			chip_id;
>  	const char			*name;
>  	const struct iio_chan_spec	*channels;
>  	u8				num_channels;
> +	const struct ad7192_filter_config	*filter_configs;
> +	u8					num_filter_modes;
>  	const struct ad_sigma_delta_info	*sigma_delta_info;
>  	const struct iio_info		*info;
>  	int (*parse_channels)(struct iio_dev *indio_dev);
> @@ -210,13 +242,16 @@ struct ad7192_state {
>  	u32				mode;
>  	u32				conf;
>  	u32				scale_avail[8][2];
> -	u32				filter_freq_avail[4][2];
> +	u32				(*filter_freq_avail)[2];
> +	u8				num_filter_modes;
>  	u32				oversampling_ratio_avail[4];
>  	u8				gpocon;
>  	u8				clock_sel;
>  	struct mutex			lock;	/* protect sensor state */
>  	u8				syscalib_mode[8];
>  
> +	enum ad7192_filter_mode		filter_mode;
> +
>  	struct ad_sigma_delta		sd;
>  };
>  
> @@ -282,7 +317,200 @@ static const struct iio_enum ad7192_syscalib_mode_enum = {
>  	.get = ad7192_get_syscalib_mode
>  };
>  
> -static const struct iio_chan_spec_ext_info ad7192_calibsys_ext_info[] = {
> +#define AD7192_FILTER_CONFIG(_filter_mode, _f_order, _sinc3_en, _chop_en, _avg_val)	\
> +{									\
> +		.filter_mode = (_filter_mode),				\
> +		.f_order = (_f_order),					\
> +		.sinc3_en = (_sinc3_en),				\
> +		.chop_en = (_chop_en),					\
> +		.avg_val = (_avg_val),					\
> +		.samp_freq_avail_type = IIO_AVAIL_RANGE,		\
> +		.samp_freq_avail_len = 2,		\
> +		.samp_freq_avail = {					\
> +			{ AD7192_INT_FREQ_MHZ,				\
> +				(_f_order) * AD7192_FILTER_DIV * AD7192_FS_MAX },	\
> +			{ AD7192_INT_FREQ_MHZ,				\
> +				(_f_order) * AD7192_FILTER_DIV * AD7192_FS_MIN },	\

These ranges don't make sense to me. Shouldn't we be calculating it during probe
based on the actual clock rate?

> +		},							\
> +}
> +
> +static const struct ad7192_filter_config ad7192_filter_configs[] = {
> +	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC4,		1, 0, 0, 1),
> +	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC3,		1, 1, 0, 1),
> +	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC4_CHOP,		4, 0, 1, 1),
> +	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC3_CHOP,		3, 1, 1, 1),
> +};
> +
> +static const struct ad7192_filter_config ad7192_filter_configs_avg[] = {
> +	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC4,		1, 0, 0, 1),
> +	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC3,		1, 1, 0, 1),
> +	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC4_CHOP,		4, 0, 1, 1),
> +	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC3_CHOP,		3, 1, 1, 1),
> +
> +	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC4_AVG2,		5, 0, 0, 2),
> +	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC3_AVG2,		4, 1, 0, 2),
> +	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC4_CHOP_AVG2,	5, 0, 1, 2),
> +	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC3_CHOP_AVG2,	4, 1, 1, 2),
> +
> +	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC4_AVG8,		11, 0, 0, 8),
> +	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC3_AVG8,		10, 1, 0, 8),
> +	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC4_CHOP_AVG8,	11, 0, 1, 8),
> +	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC3_CHOP_AVG8,	10, 1, 1, 8),
> +
> +	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC4_AVG16,		19, 0, 0, 16),
> +	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC3_AVG16,		18, 1, 0, 16),
> +	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC4_CHOP_AVG16,	19, 0, 1, 16),
> +	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC3_CHOP_AVG16,	18, 1, 1, 16),
> +};
> +
> +static const char *const ad7192_filter_modes_str[] = {
> +	[AD7192_FILTER_SINC4] =			"sinc4",
> +	[AD7192_FILTER_SINC3] =			"sinc3",
> +	[AD7192_FILTER_SINC4_CHOP] =		"sinc4+chop",
> +	[AD7192_FILTER_SINC3_CHOP] =		"sinc3+chop",
> +	[AD7192_FILTER_SINC4_AVG2] =		"sinc4+avg2",
> +	[AD7192_FILTER_SINC3_AVG2] =		"sinc3+avg2",
> +	[AD7192_FILTER_SINC4_CHOP_AVG2] =	"sinc4+chop+avg2",
> +	[AD7192_FILTER_SINC3_CHOP_AVG2] =	"sinc3+chop+avg2",
> +	[AD7192_FILTER_SINC4_AVG8] =		"sinc4+avg8",
> +	[AD7192_FILTER_SINC3_AVG8] =		"sinc3+avg8",
> +	[AD7192_FILTER_SINC4_CHOP_AVG8] =	"sinc4+chop+avg8",
> +	[AD7192_FILTER_SINC3_CHOP_AVG8] =	"sinc3+chop+avg8",
> +	[AD7192_FILTER_SINC4_AVG16] =		"sinc4+avg16",
> +	[AD7192_FILTER_SINC3_AVG16] =		"sinc3+avg16",
> +	[AD7192_FILTER_SINC4_CHOP_AVG16] =	"sinc4+chop+avg16",
> +	[AD7192_FILTER_SINC3_CHOP_AVG16] =	"sinc3+chop+avg16",
> +};

We need to make these match the values already defined in the ABI docs as much
as we can.

I see in the datasheets that there is a REJ60 bit in the MODE register, so I
would expect to see "sinc3+rej60" in this list as well.

We already have "sinc3+sinc1" that is defined as 'Sinc3 + averaging by 8' so
"sinc3+avg8" would be redunant. And given that this driver already uses
the oversampling_ratio attribute to control the avg2/8/16, I'm wondering if we
can keep that instead of introducing more filter types.

I also wonder if "sinc3+pf1" could be used for "sinc3+chop" since it is defined
as a device-specific post filter. Or make the case that "chop" is common enough
that it deseres it's own name.

I'm not the best expert on filters though, so I'm sure Jonathan will have some
better wisdom to share here.

Here is the existing list. If we have any filter types that don't fit into the
existing ones, we will need to have a separate patch to add those to the
documentation too.


What:		/sys/bus/iio/devices/iio:deviceX/filter_type_available
What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_type_available
KernelVersion:	6.1
Contact:	linux-iio@vger.kernel.org
Description:
		Reading returns a list with the possible filter modes. Options
		for the attribute:

		* "sinc3" - The digital sinc3 filter. Moderate 1st
		  conversion time. Good noise performance.
		* "sinc4" - Sinc 4. Excellent noise performance. Long
		  1st conversion time.
		* "sinc5" - The digital sinc5 filter. Excellent noise
		  performance
		* "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
		  time.
		* "sinc3+rej60" - Sinc3 + 60Hz rejection.
		* "sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st conversion
		  time.
		* "sinc3+pf1" - Sinc3 + device specific Post Filter 1.
		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
		* "wideband" - filter with wideband low ripple passband
		  and sharp transition band.



> +static int ad7192_set_filter_mode(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan,
> +				  unsigned int val)
> +{
> +	struct ad7192_state *st = iio_priv(indio_dev);
> +	const struct ad7192_filter_config *filter_config = &st->chip_info->filter_configs[val];

Seems dangerous to access an array without checking that val is in range first,
especially since it comes from userspace.

> +	u16 old_samp_freq, div;
> +	int i, ret;

Probably should have iio_device_claim_direct() here to make sure we can't change
the filter mode in the middle of a buffer read.

> +
> +	old_samp_freq = ad7192_get_f_adc(st);
> +
> +	st->filter_mode = val;
> +
> +	div = DIV_ROUND_CLOSEST(st->fclk, ad7192_get_f_order(st) * old_samp_freq);
> +	if (div < AD7192_FS_MIN || div > AD7192_FS_MAX)
> +		return -EINVAL;
> +
> +	st->mode &= ~AD7192_MODE_RATE_MASK;
> +	st->mode |= FIELD_PREP(AD7192_MODE_RATE_MASK, div);
> +
> +	st->mode &= ~AD7192_MODE_SINC3;
> +	st->mode |= FIELD_PREP(AD7192_MODE_SINC3, filter_config->sinc3_en);
> +
> +	st->conf &= ~AD7192_CONF_CHOP;
> +	st->conf |= FIELD_PREP(AD7192_CONF_CHOP, filter_config->chop_en);
> +
> +	for (i = 0; i < ARRAY_SIZE(st->oversampling_ratio_avail); i++) {
> +		if (filter_config->avg_val != st->oversampling_ratio_avail[i])
> +			continue;
> +
> +		st->mode &= ~AD7192_MODE_AVG_MASK;
> +		st->mode |= FIELD_PREP(AD7192_MODE_AVG_MASK, i);
> +	}
> +
> +	ret = ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, st->conf);
> +	if (ret < 0)
> +		return ret;
> +
> +	ad7192_update_filter_freq_avail(st);
> +
> +	return 0;
> +}
> +
> +static int ad7192_get_filter_mode(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan)
> +{
> +	struct ad7192_state *st = iio_priv(indio_dev);
> +
> +	return st->filter_mode;
> +}
> +
> +static const struct iio_enum ad7192_filter_mode_enum = {
> +	.items = ad7192_filter_modes_str,
> +	.num_items = ARRAY_SIZE(ad7192_filter_modes_str),
> +	.set = ad7192_set_filter_mode,
> +	.get = ad7192_get_filter_mode,
> +};
> +
> +static const struct iio_chan_spec_ext_info ad7192_ext_info[] = {
>  	{
>  		.name = "sys_calibration",
>  		.write = ad7192_write_syscalib,
> @@ -292,6 +520,9 @@ static const struct iio_chan_spec_ext_info ad7192_calibsys_ext_info[] = {
>  		 &ad7192_syscalib_mode_enum),
>  	IIO_ENUM_AVAILABLE("sys_calibration_mode", IIO_SHARED_BY_TYPE,
>  			   &ad7192_syscalib_mode_enum),
> +	IIO_ENUM("filter_mode", IIO_SHARED_BY_ALL, &ad7192_filter_mode_enum),
> +	IIO_ENUM_AVAILABLE("filter_mode", IIO_SHARED_BY_ALL,
> +			   &ad7192_filter_mode_enum),

As in the ABI docs above, this needs to be "filter_type", not "filter_mode". It
would make sense to rename the functions and variables as well. (We recently
standardized this across all existing drivers.)

>  	{ }
>  };

Since some chips don't support averaging, we will need two different ext_info
now so that filter_type_available is correct for those chips.

>  
> @@ -650,15 +881,22 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
>  	st->oversampling_ratio_avail[2] = 8;
>  	st->oversampling_ratio_avail[3] = 16;
>  
> -	st->filter_freq_avail[0][0] = 600;
> -	st->filter_freq_avail[1][0] = 800;
> -	st->filter_freq_avail[2][0] = 2300;
> -	st->filter_freq_avail[3][0] = 2720;
> +	return 0;
> +}
>  
> -	st->filter_freq_avail[0][1] = 1000;
> -	st->filter_freq_avail[1][1] = 1000;
> -	st->filter_freq_avail[2][1] = 1000;
> -	st->filter_freq_avail[3][1] = 1000;
> +static int ad7192_filter_setup(struct ad7192_state *st)
> +{
> +	unsigned int num_modes = st->chip_info->num_filter_modes;
> +
> +	st->filter_freq_avail = devm_kcalloc(&st->sd.spi->dev, num_modes,
> +					     sizeof(*st->filter_freq_avail),
> +					     GFP_KERNEL);
> +	if (!st->filter_freq_avail)
> +		return -ENOMEM;
> +
> +	st->num_filter_modes = num_modes;
> +
> +	ad7192_update_filter_freq_avail(st);

As mentioned elsewhere, I would just keep the existing implementation for the
3db_frequency_available attribute and add some comments that it is for backwards
compatibility only.



> @@ -936,7 +1050,7 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		}
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		*val = DIV_ROUND_CLOSEST(ad7192_get_f_adc(st), 1024);
> +		*val = DIV_ROUND_CLOSEST(ad7192_get_f_adc(st), AD7192_FILTER_DIV);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>  		*val = ad7192_get_3db_filter_freq(st);
> @@ -957,7 +1071,7 @@ static int __ad7192_write_raw(struct iio_dev *indio_dev,
>  			      long mask)
>  {
>  	struct ad7192_state *st = iio_priv(indio_dev);
> -	int i, div;
> +	int i, div, ret;
>  	unsigned int tmp;
>  
>  	guard(mutex)(&st->lock);
> @@ -982,32 +1096,20 @@ static int __ad7192_write_raw(struct iio_dev *indio_dev,
>  		if (!val)
>  			return -EINVAL;
>  
> -		div = st->fclk / (val * ad7192_get_f_order(st) * 1024);
> -		if (div < 1 || div > 1023)
> +		div = st->fclk / (val * ad7192_get_f_order(st) * AD7192_FILTER_DIV);
> +		if (div < AD7192_FS_MIN || div > AD7192_FS_MAX)
>  			return -EINVAL;
>  
>  		st->mode &= ~AD7192_MODE_RATE_MASK;
>  		st->mode |= FIELD_PREP(AD7192_MODE_RATE_MASK, div);
> -		ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
> +
> +		ret = ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
> +		if (ret)
> +			return ret;

This looks like an unrelated fixup, so please put that in a separate patch.
Actually 2 patches, one for adding the macros and one for checking the return
value.


