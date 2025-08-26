Return-Path: <linux-kernel+bounces-787084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E81B3713A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48911BA6DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3CB2E3AE6;
	Tue, 26 Aug 2025 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jgs1T0bQ"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC421CD1F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228843; cv=none; b=eE9QG8/dJSHWwbEqXNDxfFRrwzyAGZ4lFLTRItE3W7kPir4dtWjhMYLYiUeQIhgMKbwkziVD+5pa1oekNGFkqSPNN2TuiXaWGhpndPvcLgQo7p6WwcwdFmCIIqgcEfF5ocZXdMGPbRGbTOVRmZI6k4B8tjCOi7nfNeqbvWTgHNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228843; c=relaxed/simple;
	bh=t8IwPQqNJiRPMzBJsf54cWWfn0K+k0YIvxSOPZmYjDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2m2M+sHLsMeiBgDcvmkVzp6IoY2VzWHLCYLfOefFzwIi6SWWYW0CXeYKY9ljI1dlvqRR3BjkChtMXAYuCegfRq3V8iZsYWN0DDOeIadS/IRTH3L1UkkYvT1UP/WEys+UzCMvM5m3An0u+2GdkHsnBX//kSy2tDlyUWXGv7sna8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jgs1T0bQ; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-314bccf2472so1853241fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756228840; x=1756833640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nLH5ebccMJNg2fmiEZ6mELPUvyqcTFcov8uXGnh7hPs=;
        b=jgs1T0bQSyzBiGPxN+FAYjwKrx4hL39EJSW2foG3lLnd65BVSgLvPd0lsurp+aMwr5
         8OfLCXOew3BOg/Hw3DwBRfNJRwhVCDhbfsCa02nmQx/REW5vAzgW8DR8oF0uJkMMd5do
         Qb4eQLNtVrzpdalTzBAxW2lecjrRzCZN1U1F3p/tTTDLZcJCddHCrz31JU4GePMT0Vu/
         8Ork9wUMIGQHqT/qhXjkVk56av9CcLkSIn4LUq/jXD9eanVemrxNdD6hwQxraQ9A9eCQ
         psZ1zchPmnEKQC7CTrdiD+GX/eFj07EyUTwtoa1ndjkySVuLuDbmP+q+81Uq/oQVSq5a
         RduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756228840; x=1756833640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLH5ebccMJNg2fmiEZ6mELPUvyqcTFcov8uXGnh7hPs=;
        b=dd0HJFSlZwNnmh400h6AYQvsKyx9PkXoedsQZ+MtAAlUaxZDoRd/1gXP+O58eOlpy2
         tF0UB/WhrWYdPAq9iVXgPfZ9IBBLU1C6VoAvqRVIpesXf0XQsgpR+cDRoAUujKU7iZmY
         Z/Y6mNlXIDHAJuD1odKNlBKkNn3lpM89gA2DGNLKmNL30ga1uqRH9UkNgo96T/pqPw8D
         qOq7bIUcy4B9F2anrHQ8HExSOP1/fg3mDGPxn6W4Hozv6KkuUy0JndIDIXoiQZ8YziAU
         fHudp187vtpIrwFQPdx+lI19klwnUpOQqMmpMfSdDpAzrrc/3F3oBoo4ZqOdYqrxEbpL
         wd/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW26qwfXRuw30/vIZIn7jtm6nrAuAUnamy8s74nVDSAPDXgCj7apatSskoNGnYYihjSfRjUlbwQWpvDvws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaWn1zxZEYR6Ok9CbXX3wvcm46xorLTOnigT7m5f2tI2SHA0pO
	1b7tuaIsjS0PIcGFThSFXhIFV0H0tDtWxVErWvjFP8uhpYL6rx5XOGpN51iiAW6vnCI=
X-Gm-Gg: ASbGncueaZgomsng7KyMIrEMq7x2mbC1ujlikNLV9K1IFKwr3R10BDxemt31YDOgpUG
	DFOlawPm/ZZ6Q88UezdiKS8mKHBRsdsqMyKo622seBkhOdVOEVEUZRPxnEDb1ze1WXibBrPCxFa
	g7Ila7GjcLop5i6Zl2LOQjB5U4CfOADojYpcMWAH1EXLpO9CeSzNd6d732dmbwccFqjkP2tiSef
	bF+X/rKYpcdkP4O9COVELpRaqznPP+w0c480mvQAtQW0YstUFcWC+3k0IcW/Z3EB4ZrVY0PNMiH
	27cHDBEAbA3aZ+nERmAauDGhjd286mzaQSSCGd1W8F/swEAuAkPLgRUmnpgr8gNrPKM7DBe3JGw
	s6M2d185mN8FTFcE7/BhQEn++RZO/1gbS7yMVbSZ3+XDqrgKK3dQiZbI1eVu3Z/Tg9hnkcLc40Q
	wyIWwIm4ibow==
X-Google-Smtp-Source: AGHT+IGLRA6KlL/el+5xyazskMojzEi/VZ5zSOO1th1Lvm0JoJbB1wRq23JboidQMDj1JKuA+jwtEw==
X-Received: by 2002:a05:6871:4184:b0:30b:c4e1:7936 with SMTP id 586e51a60fabf-314dcad7aa1mr7362127fac.7.1756228840359;
        Tue, 26 Aug 2025 10:20:40 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb? ([2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-314f79c54basm2650246fac.5.2025.08.26.10.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 10:20:39 -0700 (PDT)
Message-ID: <45170936-3eeb-4b7a-b75b-560660979b72@baylibre.com>
Date: Tue, 26 Aug 2025 12:20:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] iio: mcp9600: Add support for IIR filter
To: Ben Collins <bcollins@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
 <20250825-mcp9600-iir-v7-4-2ba676a52589@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250825-mcp9600-iir-v7-4-2ba676a52589@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/25 7:10 PM, Ben Collins wrote:
> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> to allow get/set of this value.
> 
> Use filter_type[none, ema] for enabling the IIR filter.
> 
> Signed-off-by: Ben Collins <bcollins@kernel.org>
> ---
>  drivers/iio/temperature/mcp9600.c | 147 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 147 insertions(+)
> 
> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> index aa42c2b1a369edbd36e0d6d6d1738ed0069fd990..d3309e30628ae5cdc74378403952ba285990f4c0 100644
> --- a/drivers/iio/temperature/mcp9600.c
> +++ b/drivers/iio/temperature/mcp9600.c
> @@ -31,6 +31,7 @@
>  #define MCP9600_STATUS_ALERT(x)		BIT(x)
>  #define MCP9600_SENSOR_CFG		0x05
>  #define MCP9600_SENSOR_TYPE_MASK	GENMASK(6, 4)
> +#define MCP9600_FILTER_MASK		GENMASK(2, 0)
>  #define MCP9600_ALERT_CFG1		0x08
>  #define MCP9600_ALERT_CFG(x)		(MCP9600_ALERT_CFG1 + (x - 1))
>  #define MCP9600_ALERT_CFG_ENABLE	BIT(0)
> @@ -94,6 +95,27 @@ static const int mcp9600_tc_types[] = {
>  	[THERMOCOUPLE_TYPE_R] = 'R',
>  };
>  
> +enum mcp9600_filter {
> +	MCP9600_FILTER_TYPE_NONE,
> +	MCP9600_FILTER_TYPE_EMA,
> +};
> +
> +static const char * const mcp9600_filter_type[] = {
> +	[MCP9600_FILTER_TYPE_NONE] = "none",
> +	[MCP9600_FILTER_TYPE_EMA] = "ema",
> +};
> +
> +static const int mcp_iir_coefficients_avail[7][2] = {
> +	/* Level 0 is no filter */
> +	{ 0, 524549 },
> +	{ 0, 243901 },
> +	{ 0, 119994 },
> +	{ 0,  59761 },
> +	{ 0,  29851 },
> +	{ 0,  14922 },
> +	{ 0,   7461 },
> +};
> +
>  static const struct iio_event_spec mcp9600_events[] = {
>  	{
>  		.type = IIO_EV_TYPE_THRESH,
> @@ -119,6 +141,8 @@ struct mcp_chip_info {
>  struct mcp9600_data {
>  	struct i2c_client *client;
>  	u32 thermocouple_type;
> +	int filter_level;
> +	int filter_enabled;
>  };
>  
>  static int mcp9600_config(struct mcp9600_data *data)
> @@ -129,6 +153,9 @@ static int mcp9600_config(struct mcp9600_data *data)
>  
>  	cfg  = FIELD_PREP(MCP9600_SENSOR_TYPE_MASK,
>  			  mcp9600_type_map[data->thermocouple_type]);
> +	/* The chip understands 0 as "none", and 1-7 as ema filter levels. */
> +	if (data->filter_enabled)
> +		FIELD_MODIFY(MCP9600_FILTER_MASK, &cfg, data->filter_level + 1);
>  
>  	ret = i2c_smbus_write_byte_data(client, MCP9600_SENSOR_CFG, cfg);
>  	if (ret < 0) {
> @@ -146,7 +173,11 @@ static int mcp9600_config(struct mcp9600_data *data)
>  			.address = MCP9600_HOT_JUNCTION,		       \
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	       \
>  					      BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE) | \
> +					      BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) | \

Does the filter actually only apply to the hot junction and not the
cold junction? There is a mismatch between this being info_mask_separate
and the filter_type being IIO_SHARED_BY_ALL.

Not related to this patch, but the comment same applies to
IIO_CHAN_INFO_THERMOCOUPLE_TYPE - I missed that in previous reviews.

>  					      BIT(IIO_CHAN_INFO_SCALE),	       \
> +			.info_mask_separate_available =                        \
> +					      BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
> +			.ext_info = mcp9600_ext_filter,			       \
>  			.event_spec = &mcp9600_events[hj_ev_spec_off],	       \
>  			.num_event_specs = hj_num_ev,			       \
>  		},							       \
> @@ -162,6 +193,57 @@ static int mcp9600_config(struct mcp9600_data *data)
>  		},							       \
>  	}
>  
> +static int mcp9600_get_filter(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan)
> +{
> +	struct mcp9600_data *data = iio_priv(indio_dev);
> +
> +	return data->filter_enabled ? MCP9600_FILTER_TYPE_EMA :
> +		MCP9600_FILTER_TYPE_NONE;
> +}
> +
> +static int mcp9600_set_filter(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      unsigned int mode)
> +{
> +	struct mcp9600_data *data = iio_priv(indio_dev);
> +	int new_type;

This variable name is a little confusing. It looks like it should
rather be:

	bool new_filter_enabled;

> +
> +	switch (mode) {
> +	case MCP9600_FILTER_TYPE_NONE:
> +		new_type = 0;
> +		break;
> +
> +	case MCP9600_FILTER_TYPE_EMA:
> +		new_type = 1;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Do not reset the filter if we don't need to. */
> +	if (data->filter_enabled == new_type)
> +		return 0;
> +
> +	data->filter_enabled = new_type;
> +	return mcp9600_config(data);
> +}
> +
> +static const struct iio_enum mcp9600_filter_enum = {
> +	.items = mcp9600_filter_type,
> +	.num_items = ARRAY_SIZE(mcp9600_filter_type),
> +	.get = mcp9600_get_filter,
> +	.set = mcp9600_set_filter,
> +};
> +
> +static const struct iio_chan_spec_ext_info mcp9600_ext_filter[] = {
> +	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &mcp9600_filter_enum),
> +	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL,
> +			   &mcp9600_filter_enum),
> +	{ }
> +};
> +
>  static const struct iio_chan_spec mcp9600_channels[][2] = {
>  	MCP9600_CHANNELS(0, 0, 0, 0), /* Alerts: - - - - */
>  	MCP9600_CHANNELS(1, 0, 0, 0), /* Alerts: 1 - - - */
> @@ -216,6 +298,69 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
>  		*val = mcp9600_tc_types[data->thermocouple_type];
>  		return IIO_VAL_CHAR;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		if (!data->filter_enabled)
> +			return IIO_VAL_EMPTY;

This brings us back to the earlier discussion of what should this
be when the filter is disabled. Mathematically, it would be infinite.

I wonder if it would be reasonable to return "inf" here since many
floating point parsers will already handle that as a valid value.

> +
> +		*val = mcp_iir_coefficients_avail[data->filter_level][0];
> +		*val2 = mcp_iir_coefficients_avail[data->filter_level][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

