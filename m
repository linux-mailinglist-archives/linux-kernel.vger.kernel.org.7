Return-Path: <linux-kernel+bounces-672080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6CEACCA94
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 17:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94BBE173322
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 15:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C988A23C503;
	Tue,  3 Jun 2025 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DcOey/rx"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A662823C4ED
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748965933; cv=none; b=YitGGmVEL8p4ub9s9Bn2V7sKhBXo3O9vJPwOXc6pdJU1uVcbLzmi0+8c9TWk1tKcSKwk5e6mP1/GXh0cR7mfLzehjIIM3IMBy5+FxmJYXQjoOfR6O2ssRp6gg7jbuPq8S/AH3aQdb9g2KnpJqRQkgWRSF86uBZ/Au6LewgRc12Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748965933; c=relaxed/simple;
	bh=B/nAD6AdfuQ75e2MBabWGMF6/ocLULn1XFpYA5+J6fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXaQrHOqa1Wceb/2Uigzk4YUCOpx8P5jf+OrxjxHdQ+v+zQsqib+8MlytyYXP5+hi2328bCWieQkI4JDNkXuVS9Rhv6pHkBhaygLCSWTR7ko8IYuPwN2pKwVgwySLx92SFk8OhL9D/FGyZLHr0QyLCfi1CieTyn3TpRJfFI6jgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DcOey/rx; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2d09d495c6cso1255837fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jun 2025 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748965929; x=1749570729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZ+JUXoSO+vIrYi8VTnQeOUxjfv3ek7WnXtZxEwnZfs=;
        b=DcOey/rxVGGec2hIT0lyu7gvghGv6IHIEP0a2zUaxSaEEFn5rirH/2xjTSFzfFflAo
         xbdHXjtQzND7ApbVQZ5CmB4uIRVipidUFzEPTRaypsz72akYkz0OUMHhBfMB+gFuwb9p
         sPq9FU1H33YGTQnJjUE8t7GFw3ofNNh8UBysYk6JlXF+j1ZsXWa5vIdN+LDuMGTusyXl
         n2W6/DLcuCGXfjarwBDpmHjaafmpCP6NnFP/eky1jfo7Tx65T56lCew+RXClCPKd2o/Q
         XHxMqFHHiT7mk9xt2ydmR93R9oFrC4KfkBcxLUXwidUGhL+coOA5238RfAC7Wkv5/MxA
         /eHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748965929; x=1749570729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZ+JUXoSO+vIrYi8VTnQeOUxjfv3ek7WnXtZxEwnZfs=;
        b=sPvuoqQuWRI9DJRm1Tnzb8PAGRqNCpwbuFfXPRrbCI6kFtAlGu9OQdvJxupl3N0rik
         8tqbQOirG3bo8+3qaUmOruHmzSLTZSaz4ZqWa2N2QApp+Xubo8lZXRPHQLmxkbOg7B4x
         Wngfhm9I1XUhbGP0gGzyEDjdtK67efNKWhX/dNWAesKN1l5CKwxfmyWFkMEzb5HIe7iM
         /t0pn2G1pXN0X5xmEay/Mw10pfDjBysdG9WyODD+bjJvuEnKXDW9NYTVEQKrUsAdkHc/
         YZLFSo3SSqFIvHtsxKZQmWGr/5QlgfhHSxyozzQ90KjjsoLQGMFz4ZN+yNnuK0U8KWnI
         bdDg==
X-Forwarded-Encrypted: i=1; AJvYcCVUiM2U2pIqC7DLdskkDeP8beXWW4S6omXpd4/q8oZcXYHNdTyr6Lo2HmtLRY3gjulIOtSA8ObXwX+DeG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBR48o8UcR5zZsIACTraoSTgKGIw+roGlyYtIRxUnGiEFoAlTA
	WfRaW7qwGzaKSYYihCeiS6ONjl1LhQtZN0m+nKFhdUMxuq3p5TeVXT96S2yM0cofj9U=
X-Gm-Gg: ASbGnculBALfHcYugactsgRd235fj0eV51QDqnbFtMDaWih908xFKgnT4/dXflWyNk1
	Zr4H0uXykn8ExxiDY+frW27rVIPnz2WpJuCgks6bK2W/d40P6phmN0zOGQCKVveJz3GDQrJIs0y
	np41xWgdRlx2hJmsAHZ6zDmTIrrMhk/JWJgiF9XK/YVKBkERrwijHo08mNUWdjbR1oZ9/TaUvUO
	Ff2U5IOyNMa4J/uOstRCl39h4el7ON5BNN5ozvmWgbPHhr/gPlpO1nybAy9xL7B0llNI0Rjha3R
	9HnLRAMUGKpCAUjqfkPm6VBZJDMbzoAsJOpwEs7Qqav6SK3mbbHcEbcuzNNHJjuon2PjwN1I799
	gdPFGN9njZV2WKoKTLjyW4D/Q5z5AKWW5KojV
X-Google-Smtp-Source: AGHT+IFmmiAtHmbyTwYNGTdrO3ErD/rnYdR4DEzbtZByS5yxSX9f+Dnu/BkXtS/pA+tGNWGGjhkyLg==
X-Received: by 2002:a05:6870:648a:b0:29f:a0b8:6f7f with SMTP id 586e51a60fabf-2e92a21ffe7mr9812334fac.12.1748965929437;
        Tue, 03 Jun 2025 08:52:09 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:e835:af77:41c:3a1f? ([2600:8803:e7e4:1d00:e835:af77:41c:3a1f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e906b8080esm2265977fac.31.2025.06.03.08.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 08:52:07 -0700 (PDT)
Message-ID: <ebdc963c-d1f7-41fd-a49e-803bfb7a4408@baylibre.com>
Date: Tue, 3 Jun 2025 10:52:06 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/6] iio: adc: ad7606: add gain calibration support
To: Angelo Dureghello <adureghello@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250603-wip-bl-ad7606-calibration-v8-0-2371e7108f32@baylibre.com>
 <20250603-wip-bl-ad7606-calibration-v8-6-2371e7108f32@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250603-wip-bl-ad7606-calibration-v8-6-2371e7108f32@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/3/25 9:36 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add gain calibration support, using resistor values set on devicetree,
> values to be set accordingly with ADC external RFilter, as explained in
> the ad7606c-16 datasheet, rev0, page 37.
> 
> Usage example in the fdt yaml documentation.
> 
> Tested-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>

The patch has changed significantly since these tags were given, so
these tags should have been dropped.

> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/adc/ad7606.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/iio/adc/ad7606.h |  6 +++++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index e0a666cc0e14255754e74daa9e1e88bc4ad1665c..22dcb52ced57d4305db6401605c064fc438d5be4 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -33,6 +33,10 @@
>  
>  #include "ad7606.h"
>  
> +#define AD7606_CALIB_GAIN_MIN	0
> +#define AD7606_CALIB_GAIN_STEP	1024
> +#define AD7606_CALIB_GAIN_MAX	(63 * AD7606_CALIB_GAIN_STEP)
> +
>  /*
>   * Scales are computed as 5000/32768 and 10000/32768 respectively,
>   * so that when applied to the raw values they provide mV values.
> @@ -125,6 +129,7 @@ static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
>  				   struct iio_chan_spec *chan);
>  static int ad7616_sw_mode_setup(struct iio_dev *indio_dev);
>  static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev);
> +static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev);
>  
>  const struct ad7606_chip_info ad7605_4_info = {
>  	.max_samplerate = 300 * KILO,
> @@ -180,6 +185,7 @@ const struct ad7606_chip_info ad7606b_info = {
>  	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
>  	.sw_setup_cb = ad7606b_sw_mode_setup,
>  	.offload_storagebits = 32,
> +	.calib_gain_setup_cb = ad7606_chan_calib_gain_setup,
>  	.calib_offset_avail = ad7606_calib_offset_avail,
>  	.calib_phase_avail = ad7606b_calib_phase_avail,
>  };
> @@ -195,6 +201,7 @@ const struct ad7606_chip_info ad7606c_16_info = {
>  	.scale_setup_cb = ad7606c_16bit_chan_scale_setup,
>  	.sw_setup_cb = ad7606b_sw_mode_setup,
>  	.offload_storagebits = 32,
> +	.calib_gain_setup_cb = ad7606_chan_calib_gain_setup,
>  	.calib_offset_avail = ad7606_calib_offset_avail,
>  	.calib_phase_avail = ad7606c_calib_phase_avail,
>  };
> @@ -246,6 +253,7 @@ const struct ad7606_chip_info ad7606c_18_info = {
>  	.scale_setup_cb = ad7606c_18bit_chan_scale_setup,
>  	.sw_setup_cb = ad7606b_sw_mode_setup,
>  	.offload_storagebits = 32,
> +	.calib_gain_setup_cb = ad7606_chan_calib_gain_setup,
>  	.calib_offset_avail = ad7606c_18bit_calib_offset_avail,
>  	.calib_phase_avail = ad7606c_calib_phase_avail,
>  };
> @@ -355,6 +363,36 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
>  	return 0;
>  }
>  
> +static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	unsigned int num_channels = st->chip_info->num_adc_channels;
> +	struct device *dev = st->dev;
> +	int ret;
> +
> +	device_for_each_child_node_scoped(dev, child) {

Now that I had a deep dive into this in v7, I'm wondering what is the
benefit of having a separate function and iterating over child nodes
a second time compared to just having a bool flag in chip_info and
doing this in the existing iterator in ad7606_probe_channels().

It seems like we could do the same thing in much fewer lines of code
if we avoid adding a callback.

> +		u32 reg, r_gain;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return ret;
> +
> +		/* Chan reg is a 1-based index. */
> +		if (reg < 1 || reg > num_channels)
> +			return -EINVAL;
> +
> +		r_gain = 0;
> +		ret = fwnode_property_read_u32(child, "adi,rfilter-ohms",
> +					       &r_gain);

ret is set but never read here.

> +		if (r_gain > AD7606_CALIB_GAIN_MAX)
> +			return -EINVAL;
> +
> +		st->r_gain[reg - 1] = r_gain;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
>  					  struct iio_chan_spec *chan)
>  {
> @@ -1352,6 +1390,21 @@ static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev)
>  	return st->bops->sw_mode_config(indio_dev);
>  }
>  
> +static int ad7606_set_gain_calib(struct ad7606_state *st)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < st->chip_info->num_adc_channels; i++) {
> +		ret = st->bops->reg_write(st, AD7606_CALIB_GAIN(i),
> +					  DIV_ROUND_CLOSEST(st->r_gain[i],
> +					  AD7606_CALIB_GAIN_STEP));

I think typical kernel style would be to have at least one more tab
on this line (assuming aligning to "(" makes the line too long).

> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ad7606_probe_channels(struct iio_dev *indio_dev)
>  {
>  	struct ad7606_state *st = iio_priv(indio_dev);
> @@ -1444,6 +1497,13 @@ static int ad7606_probe_channels(struct iio_dev *indio_dev)
>  	if (slow_bus)
>  		channels[i] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(i);
>  
> +	/* Getting gain calibration values for all channels. */
> +	if (st->sw_mode_en && st->chip_info->calib_gain_setup_cb) {
> +		ret = st->chip_info->calib_gain_setup_cb(indio_dev);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	indio_dev->channels = channels;
>  
>  	return 0;
> @@ -1620,6 +1680,12 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  		st->chip_info->sw_setup_cb(indio_dev);
>  	}
>  
> +	if (st->sw_mode_en && st->chip_info->calib_gain_setup_cb) {
> +		ret = ad7606_set_gain_calib(st);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(ad7606_probe, "IIO_AD7606");
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index f613583a7fa4095115b0b28e3f8e51cd32b93524..a5b0d318e2f4d73d3708288536e807957c5de68c 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -50,6 +50,7 @@ struct ad7606_state;
>  typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
>  				       struct iio_chan_spec *chan);
>  typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
> +typedef int (*ad7606_calib_gain_setup_cb_t)(struct iio_dev *indio_dev);
>  
>  /**
>   * struct ad7606_chip_info - chip specific information
> @@ -66,6 +67,7 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
>   * @init_delay_ms:	required delay in milliseconds for initialization
>   *			after a restart
>   * @offload_storagebits: storage bits used by the offload hw implementation
> + * @calib_gain_setup_cb: callback to setup of gain calibration
>   * @calib_offset_avail: pointer to offset calibration range/limits array
>   * @calib_phase_avail:  pointer to phase calibration range/limits array
>   */
> @@ -81,6 +83,7 @@ struct ad7606_chip_info {
>  	bool				os_req_reset;
>  	unsigned long			init_delay_ms;
>  	u8				offload_storagebits;
> +	ad7606_calib_gain_setup_cb_t	calib_gain_setup_cb;
>  	const int			*calib_offset_avail;
>  	const int			(*calib_phase_avail)[2];
>  };
> @@ -131,6 +134,7 @@ struct ad7606_chan_scale {
>   * @data:		buffer for reading data from the device
>   * @offload_en:		SPI offload enabled
>   * @bus_data:		bus-specific variables
> + * @r_gain:		array to store gain calibration resistor value in ohm
>   * @d16:		be16 buffer for reading data from the device
>   */
>  struct ad7606_state {
> @@ -161,6 +165,8 @@ struct ad7606_state {
>  	bool				offload_en;
>  	void				*bus_data;
>  
> +	int				r_gain[AD760X_MAX_CHANNELS];

This isn't used outside of probe, so we could possibly get away with
putting it somewhere else.

> +
>  	/*
>  	 * DMA (thus cache coherency maintenance) may require the
>  	 * transfer buffers to live in their own cache lines.
> 


