Return-Path: <linux-kernel+bounces-732187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12653B0632E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BEF21AA03B2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6887622E406;
	Tue, 15 Jul 2025 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s7pKic11"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958DC18DF80
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593988; cv=none; b=oK+Vd+tanKs7sLSdsVtDJz3Y62A78QG5QsdLTSz1+KqjX0qpxMXqBylyCXgSYXcJbisvYQga6hQ9gpLm6JNib6JjiJlK4MJJDQUrIcrr1cnQxe75zch9yibrQ4jLFyccz7E1cQXWXwqh+iH59t4/dH4A/mFs1oP2pfmSW95RTzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593988; c=relaxed/simple;
	bh=7aGKHc2Np+XbNUQMrhLQMB2XWOGfrK7O14TT49QD3Mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxwIx770cz+yHbEkmoHQSlcUHB1YNBiuzRY4kX1sIiDOpFoZzB9QnVx0dLC9b5XEK3f4quLGgWcgxQeORTb+dCdebeyChhwLGqHYrPRq/urSRgb76lTamPlTYOwecTwJ+zWfUVgpE+Lj6YU6zgdlaxOIFKf2Tu0V2J84FS7MMmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=s7pKic11; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-73e58d5108dso526359a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752593984; x=1753198784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oHMSZXGHjG3cnxxpv+F4hCDUwtj7rcH94p6C5/rKK8o=;
        b=s7pKic11iuU3lj78C/By1W/yWNOYe1h43UMdiI6gmyghpy/yaL9aQ+38fiNtTDlNr/
         xV4SduM1RCn7zRxzdxrHLBiFtenGXExA7ikWuKlLN6D+q7dClhV/YlsrW4OVu4VkbWO7
         TXM8sfQcJIpaLwV64O+bKGk6gEHYa8amC0foHdx/4SRgxg+v0XXn1rkOS3l7obkwdsdJ
         Qhs+bXyC7R4rsL0jhtv4rOT71CxmppXZGc+RnN0QPQmMaQZ1uEchSWyetImqGDaay3Da
         PKSTaCsgzJ8oG6Q4lQrR0iKmn7uXzXtv3duSKkXHmG429oUqk17l+GCPmzMAQ342CHNX
         76Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752593984; x=1753198784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHMSZXGHjG3cnxxpv+F4hCDUwtj7rcH94p6C5/rKK8o=;
        b=JFWDDz7fh9tRgVqbVF0BDWdQ3SVoQ+XrFcOQziaWsA6l/S1krH2IM0LJl1OsLgG3aY
         nneWxL3SAd3uMGLcD4rDkB5vgIDdBJNurArDDmYbrF6oPUcqYHr2+5xcSxe05AVBX0Ng
         cOwzs7kfRc6zz/VWXPF0hyvJWVjYTjlOmynLQeCk5O98bNS+WTRLgBEk4OE4paFj8vsY
         aOhJ0kqRJmqEbGVcFTvy+v02gOTCdc3bQKX1sWTQgrMK1Jbp/rv9C4jX29l/t6gnE6Ql
         w0u3w7gFKqwxYh/ztfYrcTvTc7kBSsuQnDrZhaXYR6g6ky03vz70Q+oVpB8/5nmBSpSd
         OQpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNOMtOB+YAtjKWKHc3FDhEtMEDGUlrv2MDknLncvoBPFjMw/4rRh7WyN5RmruvOwIbfXX3tPLLO0p07qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+yHiosgtiPktq0uApoR441HbKcI82D0LbTilw56bp6Xi5IYDG
	oNNlqwa0nluVxSvASgfxYPi+qyM+OoVvQi/lGLQAsi0CBzfIi3lBT9oUuOD9zg14k4c=
X-Gm-Gg: ASbGncv6XGTcqct5amUciDylJUdGZWfS9RSzb3fk9KcENwaMSxlPcrGDjSsUbUZQsLv
	rqmdnYLiOF1gy472whGZ72gRK913YZTboMSCl+/VSjhXIjTnnirEzvI/1yjWW0IwqD1Sci4eXO2
	sa4ZcHiBX1y4w1mUhd8epZDyA9WLKq3XT0HZBShhEwIpCRI/+ZYKif3XxWn8UfzbbHa6dqbSdJp
	bJAGpEqJ6Afszu/UOCOL/iFj8s3QiA1C1SCtuKt6DPfBpG8kN7wORfETIrykd5JIWhUJFg2gov5
	iT915/gANJPHWH2oBS/NiiQTBqAJsoCVB87vswPE34lKq8eWts2fEwHn975movrOSUKUAbFj14T
	mTxeUZUOSdxSILPT78s4he0VZ74vxThqEOc5dUwH6YeZqyTUf5HTRNiskgFLQ3r02Ey1PLrokIN
	0=
X-Google-Smtp-Source: AGHT+IGCXpyi7JRvj87b8OJVoULAjXVkSVf5nyx+0RKOo3uFYj9IpKPJVceIqBiIv+MPARbM4Dea2Q==
X-Received: by 2002:a05:6870:9112:b0:2d5:2955:aa5c with SMTP id 586e51a60fabf-2ff2b11e58emr10650765fac.0.1752593984382;
        Tue, 15 Jul 2025 08:39:44 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1e73:344d:50e5:ce0b? ([2600:8803:e7e4:1d00:1e73:344d:50e5:ce0b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff11680db6sm2676553fac.25.2025.07.15.08.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 08:39:43 -0700 (PDT)
Message-ID: <fff304f3-1278-41f3-87e4-70036aac21d8@baylibre.com>
Date: Tue, 15 Jul 2025 10:39:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: select
 CONFIG_IIO_BUFFER_DMAENGINE
To: Arnd Bergmann <arnd@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250715064053.3484105-1-arnd@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250715064053.3484105-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 1:40 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added support for SPI offloading causes a link error
> when the dmaengine buffer helpers are unavailable:
> 
> arm-linux-gnueabi-ld: drivers/iio/adc/ad_sigma_delta.o: in function `devm_ad_sd_setup_buffer_and_trigger':
> ad_sigma_delta.c:(.text+0x6b8): undefined reference to `devm_iio_dmaengine_buffer_setup_with_handle'
> 
> Fixes: 219da3ea842a ("iio: adc: ad_sigma_delta: add SPI offload support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index d43edc7b0c0f..e2649739a2da 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -23,6 +23,7 @@ config AD_SIGMA_DELTA
>  	tristate
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> +	select IIO_BUFFER_DMAENGINE
>  
>  config AD4000
>  	tristate "Analog Devices AD4000 ADC Driver"

Thanks, but I think [1] is a more complete fix.

[1]: https://lore.kernel.org/linux-iio/20250714-iio-ad_sigma_delta-fix-kconfig-selects-v1-1-32e0d6da0423@kernel.org/

