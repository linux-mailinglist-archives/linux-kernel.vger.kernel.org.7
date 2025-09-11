Return-Path: <linux-kernel+bounces-812741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5006B53C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F11161DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142A42512EE;
	Thu, 11 Sep 2025 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bBo1Debg"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A022DC794
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757617282; cv=none; b=Tjzk/3o3IbIoj/e03vSoZj4WVv66Q5axgkZHibbPJMmR0kNP0Rs2EEMWOMzLj3hhwoxG/4wLIzzraMhSh7LsjjQGhEUpILMeZ4y7brqc9jXs4Pu5HgIn5KSnU5p8zfq5k6FY6IAD8DHjZd1Nbfm9t2w0EDm8vKlgwulVvzi2ozA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757617282; c=relaxed/simple;
	bh=iNSdi8waQkKMEng9ruRDLzVSv65292Ob9iM0hJksiT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUJNkZTv3lJehU6B2bB9t4iT7jMd2DEb5s2cKmV3p7JqoCJpcNukRMK/YDup1W/FR8jS8E5ZqLFbm5yjPuG/c8LRfh8ORYCsYKe1IVKEfSmd49jlDYB4cHneB5NRH3EMq0TLd5zyDyrKrYuR6HdCZdN2eEKesyPqRfPm6IQe81U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bBo1Debg; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-61e74d053cfso266720eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757617279; x=1758222079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fthKq2rW3gORdFxE06iIbkm3SFnx/Wct4rEjy2bskcs=;
        b=bBo1Debgcxq/z/Tdf9x7g3qFYatU+hs/r499zQrMyT9vrGwKn0z1EmHEKESVs9MvKE
         NTQPKjFt1ae0ihjRb502uh15Rjt1M7gdbAttqKiesFHWd4/Hfj3j85XcyHL+Hp0UpcOR
         Wmn2UGtPtSDKUYqOemR25ztePeJabyLhmTfX7ZvilvinyySn6HHR3IWEskWCiqcX05q0
         Qg5S+1ASClg+x1N9UWNRGQ+7MUXmzprNCO+9BkIk/RxmeuoKZYevrAdJ0EPHjO/yi/02
         1lo21w3f8KVzpmXhYXQzGYtUJ0IHTO2qbJuaZV56MUJ95jQLf9s9hOwnx7zWVMI5+rdd
         lPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757617279; x=1758222079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fthKq2rW3gORdFxE06iIbkm3SFnx/Wct4rEjy2bskcs=;
        b=gzLJTcVRaz+cUC8zcvnm2igbPyGNQp7eKxu2QHqOXr/CZWOq7vWZNTK9cCdzP2nNgd
         DRNOQV9og/Aa+oUllg4Ef+vDEl3irTcAK1kY8Wf2gmdXlRyFiSpFg6u+23jZqjPNtiQ8
         RgAas2cdhmiqXBPvwT3W9edxmdYZlqh1aLpNlf0hU2GivT6cFY8wWMAMebx4+JazD1jo
         0iYxM1ZG6WzL7h7Gyd3avPjS5na5MUKdKkBlMqfkOCoZdpqVs1Dx9Jzuc3pxHfPwRY2P
         rzeIyxs9Q1wVzpwqf73OGtPJ/eSs8ya5Dkhk/TZCzKHhuB4STM6ZNS3op83Wtx00gneN
         TB0w==
X-Forwarded-Encrypted: i=1; AJvYcCXjIZwYK4lBNZwwfQujADVxBP2y8m8GVV++MVLeDOeGfnxNlQsOu0mxm66MW4JfCCLCLEWy6zARh7w7CHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqZct5M+6S9Nfl3OurCl5yo50zhnAz2BsIPw1m/LGcZ3hFE4rU
	E1dwL02LzUKZ4GcmanmlIyef8gRtAslMAZ/EX+UbgX5b0VBnMrIAk7LdFWN4+yznKL0=
X-Gm-Gg: ASbGnctckK6D2xpqnND72mxmxaORDq6TSpN6qdua08KnFlwqmCfQiGtejiFZNl+Nr/X
	LirSYr3XVv74n+eWwknvxpsc9kXG1SbY7J5NQM3jqnGlyVMibzjGxhWhU35fcqm6U4bSXf4aEVZ
	9d5juyZ0EAs6OoiRnDDdsKRLT7HK4/ufwsyni33dQ3JydVOtEXZAAb5Lt2W+E+HSfcDFIWX+VGw
	ja79+gyyBTkbUFJ9LUfvcNEsUoYmMowfEriEhbiMA58gfI5rsWWkxz4BtrsWIVe900GmQCaUmaU
	5usatco8g4sUG1MSvUxKBZtWpQnkz9/0Du1g1hkkumPKYdogrvPChp6Gt00ToQ2YdmZurjwx+MQ
	W3zO30hI652Dt0+DbqbHxprODLoWq9pkTiYyvxB/g+2QbB8nYeye0wbGmcazNVlIg6WUm1JKLDm
	SnNNUfKhCBZQ==
X-Google-Smtp-Source: AGHT+IG/WjqpLxUF8gahCWiYxp4DdbPjm4+PK7gdmbSkpf8+fsZcBh3p4ZtjWEJ/jdx0r0UonKQdJA==
X-Received: by 2002:a05:6820:509:b0:621:a61e:c54 with SMTP id 006d021491bc7-621bed56e66mr291001eaf.2.1757617279052;
        Thu, 11 Sep 2025 12:01:19 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d684:59db:8b2a:5451? ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-621b7d83b68sm191994eaf.26.2025.09.11.12.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:01:18 -0700 (PDT)
Message-ID: <74607630-3ee3-43b0-88b0-37ea1bef6dc5@baylibre.com>
Date: Thu, 11 Sep 2025 14:01:17 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] iio: accel: bma220: split original driver
To: Petre Rodan <petre.rodan@subdimension.ro>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
 <20250910-bma220_improvements-v2-4-e23f4f2b9745@subdimension.ro>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250910-bma220_improvements-v2-4-e23f4f2b9745@subdimension.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 2:57 AM, Petre Rodan wrote:
> In preparation for the i2c module, move the original code into multiple
> source files without any other functional change.
> 
> Create the additional bma220_core module.
> Fix checkpatch warning about GPL v2 license in bma220_spi.c.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
> Changes:
> - split out open firmware table modification into separate patch
> - bma220_write_raw() exits without dev_err() based on similar feedback
>   from David
> - change includes in bma220.h
> - include bma220.h in bma220_core.c
> - add mutex.h and pm.h includes to bma220_core.c
> - cleanup struct spacing in bma220_spi.c
> ---
>  drivers/iio/accel/Kconfig       |   9 +-
>  drivers/iio/accel/Makefile      |   3 +-
>  drivers/iio/accel/bma220.h      |  19 +++
>  drivers/iio/accel/bma220_core.c | 313 ++++++++++++++++++++++++++++++++++++++++
>  drivers/iio/accel/bma220_spi.c  | 307 ++-------------------------------------
>  5 files changed, 354 insertions(+), 297 deletions(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 8c3f7cf55d5fa432a4d4662b184a46cd59c3ebca..2cc3075e26883df60b5068c73b0551e1dd02c32e 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -218,15 +218,20 @@ config BMA180
>  
>  config BMA220
>  	tristate "Bosch BMA220 3-Axis Accelerometer Driver"
> -	depends on SPI

I think we still want to keep `depends on SPI`. (And later add `|| I2C`)

There isn't much point in allowing this on systems that it can't
communicate with.


>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> +	select BMA220_SPI if SPI
>  	help
>  	  Say yes here to add support for the Bosch BMA220 triaxial
>  	  acceleration sensor.
>  
>  	  To compile this driver as a module, choose M here: the
> -	  module will be called bma220_spi.
> +	  module will be called bma220_core and you will also get
> +	  bma220_spi if SPI is enabled.
> +
> +config BMA220_SPI
> +	tristate
> +	depends on BMA220
>  
>  config BMA400
>  	tristate "Bosch BMA400 3-Axis Accelerometer Driver"

