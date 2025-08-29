Return-Path: <linux-kernel+bounces-792392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF11B3C348
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B69F5A1041
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7CD23372C;
	Fri, 29 Aug 2025 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="H3O+12gQ"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B872566
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496832; cv=none; b=O3W1Uw5GYAZBPFAxNSXu+T8R47jxIINCc/Kh+XEybOaOPJ73taeTYWoUCGJV5bbZiDyixDgbbRQZ1qeKZFC8XJOiuiYhj9My5QB18JLZM9+jhOs3BIw7di52pZKvxno1xlhU4gtdah2exKoFhI/PLCCr3EDg1DodsRKE1jTUTFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496832; c=relaxed/simple;
	bh=01xYwzEgQqARR+trB3+eOkbrnHfqiRT5HTlVuT4VGJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=khnFUBuAfqPuRKQlgvdq+oKLp+2nRp+jFJ01L6kFy4FhbT1VGv1JAr04mpVq0kqZbpDEU9pNDf/ZjNbSYQWC2+rCH8G9KHO0WHJJzBqIY+SPgcjM0a/fOWUZD1ctLkl71J4Ct/WMsGrkS6nfXxz/Ax2yxTiGfjifxz6CIdEptB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=H3O+12gQ; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74526ca79beso1902139a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756496828; x=1757101628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JVGUg0SDLAjEzLHUVtikB/WVSwbBEdHlzNQeODDBtr8=;
        b=H3O+12gQhMEoHO+spTEJmboBEeydxF0GtBvT+vg+4/AqsbIcOdFPk/gpwx9h+fOtwo
         O+/UDYztpqt1tZUnZ5Db452Ue2g/xhtOXAC6sFOd1BteRdP8f0javz8rX50QtaSZqJ5w
         rDpkdOO+PXORbNJMLJLSFUg4IXSvYc15kfJbAw1i3RU7jt2MoO1zXO4JxNQUpCXaIFQe
         aG/DwSBb21ISzOuzZ4vTK6JC/y1w/8fas1AxunVEa+o0wbdTDRPNsyKWxTB0RqaVehPQ
         rz+rK/479O4f1dQOk9tmrTEwDN0IBjIEHVgax1BAP/OcUXhan9fcwtgDaFPk55vgC7wX
         ZJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496828; x=1757101628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVGUg0SDLAjEzLHUVtikB/WVSwbBEdHlzNQeODDBtr8=;
        b=RgGSh1JFXWoeWWkKt2OKf1hoEWGjmMkZFIQEHTayzpuA7fEES0xfbsdJUVs0VKtjuX
         m7Wav0/QOh4r4Oh7DY5YDiwWAXuA0bWCKV4gsTWiiqvnjhJNdlXGtjQQD1/zGj678Ecs
         I4q0KJbNfTjxpSGmGLeQDDnYr6k9hr1CLkqHgKY6aCdyH+Zq1zgNSRqIKBPsLVyAUnS6
         W0+3nugLkFLBor0y30O4NGwLQCDUaBbiXc0YInS5P6OOhehX/ziFr/HTKpoNRChvNdiH
         uVfwdHiatHkqa2wA1w977wfRLe9BqLux3NWskMDpG18ycLCxZKgWPnJP+bELTmT86FQQ
         pDqw==
X-Forwarded-Encrypted: i=1; AJvYcCWOkndG0jFjOYw0IJa3jz3JP2onhUuvZyGs3Y6zRkgYDsqD447Of/TCTfptJf57x4+KW+ZMQmJfcD8xpko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzkPdfgd7uYGUQ+NpuD/mCl+gRKSoyHCX9XPXN7SY4trePaZnw
	Wb4icOR9eQwCLvHNxv5DKXw7z2lxvPe76WxdNq+cqub48KRyJadBoS/EOGgKGIgApUKLe2GHWMP
	57op7
X-Gm-Gg: ASbGncsnIJHISI+M89uCv+RLRRnopHc4Bk+3XdD7o/cwnOaPbKCJKivXJhk6tcVe4jj
	NUk2A+eU0cQkBzH8ZizvyGOfuOHBclkwNwcXE+z3vP5YXJYko04fcNQvzZZlNztREptRLPWdfXs
	sCIYPM4IHWWztRJ0vMvl9mz2AlAcM7jlXywc6eW8jnO/wuxi8X+BKn2ryZ3zY4w6fF67Hs5+pTD
	u3LU7CkdqJ6B6ohJ5sovGDjy56D7tHHYnA9P3bjCjsZdASmg2nWeFR/rjLizcCaoyCDNWZVoReY
	si3a9Bg5u5MY4uL7J3jviOJPwMFJKuCIdgsStrdUbHivMCphDQ9vaRckcvnDccHdZ6ZjNKhf1vx
	c2G6q4Vcj5FPK/TMYFrLB2o7dHJirkQk761Kq0cWp9c+jnNqzKNqKidVSL0tsqgmFLT+rZIvOJp
	M=
X-Google-Smtp-Source: AGHT+IHkZbHxDOuHzCi5F+tf8HGqWEtfZdGb6ilH+q4mQdnXgfq0WBgXtPNPqptAdN4u6rI4AG7U/w==
X-Received: by 2002:a05:6808:a5c7:10b0:437:ae34:16b7 with SMTP id 5614622812f47-437ae341c86mr6947930b6e.31.1756496828382;
        Fri, 29 Aug 2025 12:47:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d0a:2553:5881:1318? ([2600:8803:e7e4:1d00:8d0a:2553:5881:1318])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-315afc5a74asm1579763fac.11.2025.08.29.12.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 12:47:07 -0700 (PDT)
Message-ID: <1350f948-85d3-410d-9e9c-8d0fe4237a32@baylibre.com>
Date: Fri, 29 Aug 2025 14:47:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] iio: add power and energy measurement modifiers
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250829115227.47712-1-antoniu.miclaus@analog.com>
 <20250829115227.47712-3-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250829115227.47712-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 6:41 AM, Antoniu Miclaus wrote:
> Add new IIO modifiers to support power and energy measurement devices:
> 
> Power modifiers:
> - IIO_MOD_ACTIVE: Real power consumed by the load
> - IIO_MOD_REACTIVE: Power that oscillates between source and load
> - IIO_MOD_APPARENT: Magnitude of complex power
> - IIO_MOD_FUND_REACTIVE: Reactive power at fundamental frequency
> - IIO_MOD_FACTOR: Power factor (ratio of active to apparent power)
> 
> Signal quality modifiers:
> - IIO_MOD_RMS: Root Mean Square value

The message doesn't match what got implemented in the patch.

> 
> These modifiers enable proper representation of power measurement
> devices like energy meters and power analyzers.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 8c9098668772..9e372ed38552 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -153,6 +153,10 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_PITCH] = "pitch",
>  	[IIO_MOD_YAW] = "yaw",
>  	[IIO_MOD_ROLL] = "roll",
> +	[IIO_MOD_RMS] = "rms",
> +	[IIO_MOD_ACTIVE] = "active",
> +	[IIO_MOD_REACTIVE] = "reactive",
> +	[IIO_MOD_APPARENT] = "apparent",
>  };
>  
>  /* relies on pairs of these shared then separate */
> @@ -190,6 +194,7 @@ static const char * const iio_chan_info_postfix[] = {
>  	[IIO_CHAN_INFO_ZEROPOINT] = "zeropoint",
>  	[IIO_CHAN_INFO_TROUGH] = "trough_raw",
>  	[IIO_CHAN_INFO_CONVDELAY] = "convdelay",
> +	[IIO_CHAN_INFO_POWERFACTOR] = "powerfactor",
>  };
>  /**
>   * iio_device_id() - query the unique ID for the device
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index ad2761efcc83..34eebad12d2c 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -70,6 +70,7 @@ enum iio_chan_info_enum {
>  	IIO_CHAN_INFO_ZEROPOINT,
>  	IIO_CHAN_INFO_TROUGH,
>  	IIO_CHAN_INFO_CONVDELAY,
> +	IIO_CHAN_INFO_POWERFACTOR,
>  };
>  
>  #endif /* _IIO_TYPES_H_ */
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 3c3cc1497a1e..6d269b844271 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -109,6 +109,10 @@ enum iio_modifier {
>  	IIO_MOD_ROLL,
>  	IIO_MOD_LIGHT_UVA,
>  	IIO_MOD_LIGHT_UVB,
> +	IIO_MOD_RMS,
> +	IIO_MOD_ACTIVE,
> +	IIO_MOD_REACTIVE,
> +	IIO_MOD_APPARENT,
>  };
>  
>  enum iio_event_type {


Do we need to add these to tools/iio/iio_event_monitor.c as well?

