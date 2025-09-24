Return-Path: <linux-kernel+bounces-830549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 572EAB99F46
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3FD019C4C93
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDCB33993;
	Wed, 24 Sep 2025 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe5NoSOu"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FD0433BC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718823; cv=none; b=Fx84U6h+48a7CDWS1Qyp+llsjWEcx1ATp9k68OIVN9O84YkfzTmxCseeDNnursqAXEM4PVAs5A/A1S3qmmapmB+HtlkpREZJDQwLxTPh/b/NvR5wFMrOovOfvB3ny26zgZeubCixIQO0WuBkU5JKOy7nreEgd0c6aGT5zoGw6Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718823; c=relaxed/simple;
	bh=7eCaqspkeWI4vNVpqbFq/9go1dzDlks7hS30C3QwfMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byJiv7ijyLkxPAaa3BVNL15Fk7sjLHFFfmoqM/yOMshsxQkHPKyYI2dxTyDW2hQaCTqAKYBu5mdDgFV27Ip3L8F35/0eXpj+7EnRngWja6yOBmH6o+H8EI6v4dHGzeO1KmxxzS8Dt2wQczm1IA6YtMVJGmuOtK07krczA7Wdf+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe5NoSOu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27d69771e3eso13760965ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758718821; x=1759323621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kOAtSuySMHUL7Eirjuaudouhdhjdq1cQExPV8WIdTNU=;
        b=Pe5NoSOune+NT+mf7HqXTFksA24SyseeVj5j5UKXyTCHmNzV4IdK43ERtQ/c3eY+0K
         HEHWyuyLQO/6STMDRHC0Jy/SxTChvjpO/9uAus3iTTwhhGmzloy++9G/kUOc7VMwc3Ia
         VzlELnQyJfz1qtllQb+toiYCSL3wH+Q8QgJoxbvSVHiGsjJFuxpJd743vcBUzLQvvp7Y
         Y7gTmuijEZWAm9Ce8X+JJrJFenXfHinKhFpRjptIt3VSM6QgtQikwsK+Mjat7qu8Ahah
         2rScSpOvioINTlgtxgHBZiUMfCyaUWPdIQruv6WyGSGUq1ar1gBurcVkmmzE/MOISteA
         AWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758718822; x=1759323622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOAtSuySMHUL7Eirjuaudouhdhjdq1cQExPV8WIdTNU=;
        b=ixv+a3CrB4Z7t/LpvoLCHlNDqDwgVvfTYoCWr2sTRSRdKXu7YrGIyYF/9MN2J3JiPN
         kfrNpyngDN/ItbMY2V3HKFLNXoOhsssKES6zRVE+snkFg7t1YPUfjr37zGPuj6329VAS
         BTDMsNHjAPWvTx7QFSgrf4jX/HB6wRr5olhU8MdW0Fru1lliL39uxMfGwVFvaxtkww9v
         RbvDbfPH7dWTJ5p4XVUd09EmAoKEE0Ir0THv4D7j4NDtgnWtPOuUatTd+tMaozYMP3k1
         AJQyLtFpJn88ccwUF1zGWzULN6u/6AESrDqR5lcxUlAsnzECjhjVCiTrjHpZNselT5/6
         BBcw==
X-Forwarded-Encrypted: i=1; AJvYcCVILARn6jzW9ylTSLt0+7felzg23hVKYAOf6HLue2SoM5m++KMUYgbiFvBT18Tk/Vk55EqzmlRifKXlYNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0+psjP7ggiN0l2v6Tsg+SxMlQTjhE7e8jZALeiGKlXnTMJcF6
	cnP/yWAVyExI+n3wEZCI108G4EGxuSGyGcF54nrym8o0o4JisCPlhL6C
X-Gm-Gg: ASbGncvenrBw1vdRGdWxQZjTtfM6MWKBu3cg1N7xIDtk/vmUS3wqt2sX8I10zKrFjOG
	1o6kCw0UdovmUM5jR+mq10/VBP3UVKfOhZnMXzWkICKblGPzkMGOIRRh9vEVJ67D4dA2eJ0QGHs
	8DjWYJFYEAqmF3Xgi/opNQ1qOR3s4UjlbXZo3OEIH4xDpm3fd7MJsA1X7igz1qkQ8wIvEBP+TTI
	HxXgKVf8NLALUYBAQG/KVfLNtV3DVchrKKKX1GDDsuiiMQ1eveK0m9CcFEhyqX8mQdd6sh+/4uZ
	WybDwiI1lJI6epD9QnKF497tfq/7/537IlMaPJBtaxVxuHgHecdBmF1+dWHWUNg3aeBx+vs56g8
	CGk+hby3cVZBmN7cNnWFObpPbQ/9mhbY=
X-Google-Smtp-Source: AGHT+IEz/eHDv8jJIje+aHMRfCzivvT3GIspIPDR9CA9OdPXfD3ArbyXDsN3eyUmiOe/qYSeJv+Ycg==
X-Received: by 2002:a17:903:1212:b0:269:8d16:42d1 with SMTP id d9443c01a7336-27cc91e1fafmr67773455ad.50.1758718821220;
        Wed, 24 Sep 2025 06:00:21 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3341bdb4cc8sm2383392a91.15.2025.09.24.06.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 06:00:20 -0700 (PDT)
Date: Wed, 24 Sep 2025 10:01:08 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: fix temperature channel
Message-ID: <aNPrlIYGrB8oSsfL@debian-BULLSEYE-live-builder-AMD64>
References: <20250923-iio-adc-ad7124-fix-temperature-channel-v1-1-e421c98c0d72@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923-iio-adc-ad7124-fix-temperature-channel-v1-1-e421c98c0d72@baylibre.com>

Hi,

On 09/23, David Lechner wrote:
> Fix temperature channel not working due to gain and offset not being
> initialized. This was causing the raw temperature readings to be always
> 8388608 (0x800000).

Would
'Fix temperature channel not working due to gain and offset not being
initialized to their default values.'
be a more accurate description?


> 
> To fix it, we just make sure the gain and offset values are set to the
> default values and still return early without doing an internal
> calibration.
> 
> While here, add a comment explaining why we don't bother calibrating
> the temperature channel.
> 
> Fixes: 47036a03a303 ("iio: adc: ad7124: Implement internal calibration at probe time")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
...
>  	for (i = 0; i < st->num_channels; i++) {
> -
> -		if (indio_dev->channels[i].type != IIO_VOLTAGE)
> -			continue;
> -
>  		/*
>  		 * For calibration the OFFSET register should hold its reset default
>  		 * value. For the GAIN register there is no such requirement but
> @@ -1531,6 +1527,13 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
>  		st->channels[i].cfg.calibration_offset = 0x800000;
>  		st->channels[i].cfg.calibration_gain = st->gain_default;
>  
> +		/*
> +		 * Only the main voltage input channels are important enough
> +		 * to be automatically calibrated here.
I think it would be more accurate to just say the offset and callibscale
for temperature channel need to be at default values for the data sheet's
equation for the temperature sensor to be accurate.


> +		 */
> +		if (indio_dev->channels[i].type != IIO_VOLTAGE)
> +			continue;
> +
>  		/*
>  		 * Full-scale calibration isn't supported at gain 1, so skip in
>  		 * that case. Note that untypically full-scale calibration has

Maybe, instead of moving the 'if(... IIO_VOLTAGE)' check, this could alternatively
be set when initializing the temperature channel at ad7124_parse_channel_config().

 	if (num_channels < AD7124_MAX_CHANNELS) {
 		st->channels[num_channels] = (struct ad7124_channel) {
 			.nr = num_channels,
 			.ain = FIELD_PREP(AD7124_CHANNEL_AINP, AD7124_CHANNEL_AINx_TEMPSENSOR) |
 				FIELD_PREP(AD7124_CHANNEL_AINM, AD7124_CHANNEL_AINx_AVSS),
 			.cfg = {
 				.bipolar = true,
+				.calibration_offset = 0x800000,
+				.calibration_gain = st->gain_default,
 			},
 		};
 
 		chan[num_channels] = (struct iio_chan_spec) {
 			.type = IIO_TEMP,


Nevertheless, the current fix looks good to me as it is, so
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

> 
> ---
> base-commit: 411e8b72c181e4f49352c12ced0fd8426eb683aa
> change-id: 20250923-iio-adc-ad7124-fix-temperature-channel-5900f7302886
> 
> Best regards,
> -- 
> David Lechner <dlechner@baylibre.com>
> 
> 

