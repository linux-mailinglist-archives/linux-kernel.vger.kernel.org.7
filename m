Return-Path: <linux-kernel+bounces-771013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9936FB28197
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE834B64C40
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01DC224AE8;
	Fri, 15 Aug 2025 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pbKFxKK/"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E2221F0E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267924; cv=none; b=mi24sWsFt+yKDEJuQrQIDuaRNIYdfVQCvU+UuEmLw2Say2VYgfM+CZGVXvcX2/fQdzk0I+4Ii0ZG6f4VwJE6qColhlGDQOEiz36x2y7R1Lt6Ws/jtudttKJDVSPwR7ohqMQDwBAL8NlHB9k/2WTd2Sohl+oJTWWqX5uxyokqchA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267924; c=relaxed/simple;
	bh=ThvZL1gYcgGj6oCu/NGA2d8Jv6mfpv54pet+KNasSYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Uw3LsSqHXGannmv8fvcioBLaaaRXsLOMTk7TV/TTc0QSoj6YjtbJUnYiU/ioncGHmGSkHisPjyaHwKrm4cvrmwNZkUno/Rn8yjC6WH0jgao5jnDoxN1eUFXLtMgM7JK1B/mmGdss6lJzPS9xq1B+Wcv1x1N3vKABODpG0o8LE6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pbKFxKK/; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-435de764e08so1271518b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755267921; x=1755872721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ye22YyV2y9xB45/jvEVGA2mq1kbx2lrk+Wp6XRfzvok=;
        b=pbKFxKK/cHb7cOblIlru7LcijYF+ezwBhU+CEGlAUWFZawN3JH/q/YO9pzgHby5Oyc
         uBDo3PbyiTM5XR8MzgH22mCDSx1ZDFSdmShW5BaqwFEnEl88rHprTS9b7DKAYgfxqk+W
         DRrOZmcMWwOUUu5qK8CkgQb4RotiexA4BUHlkBEWB1tH6XIbBIjXJXlwmO9Oyd2QTG/f
         gEdhPfx7VUbZ7gywUaH/WSaOnyR0Z2bDbUdIHkP/+Ld4URL2QXYpAKx9DaTrtkSa1wB6
         vy45DVdR8gbRohBvRfNZ7JUMGWRKQjR18LTWAhGEbEI5ezDPAFEfulzT5QIHMjkLKZS7
         E3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755267921; x=1755872721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ye22YyV2y9xB45/jvEVGA2mq1kbx2lrk+Wp6XRfzvok=;
        b=YuAu129+MXBLQsPA2S+M7ZuWTsW+Q5zCjAz59+agS45bocw+tk0p4U9QV1seVYjdIX
         W2lSq1pn2VcTrTz/r8rowo7AhUSLycPcq6VN8jN6tXW8it9fAbr8SBIiHacUdjSngh+S
         NJsVrc6yCRPtWPe1p9udpBEBRqPu+1Vo5VHv4j1SUTwBCjgTYJORV6H9OftbAvcm6ABe
         AVg8a1jGmUT3S8Ght3GNbaBiLV6bU+8p6YETglZN3lHeUt/WVhEK28X4AggRCilWRVIk
         n9ZbiKU+VIZ0xQxuSe74LLxm98Zflw5vaIwjcq4XQ1knLAiopi8Et/lme7YSxak0byOC
         2+eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn3z8gznM02F6FdWl0hT+MOd3iNoDS6NFyoFaiNz/EMqzPZNLN2gFlOwOIhKE4DrsDEhMU1NHb1R5ZZ3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIHp9iqFNyxzK4jqsRsQQFQkFlYZJglbpiU3Xk4MuVYTsZ99Ms
	s7FYe6/vfx5O1oPGzTpX5znf5Wk5D8Qzkjv8lbmQT1BazasOxoy2FCq2vCdpdIbXgSI=
X-Gm-Gg: ASbGnctmHLyoc5c//o6FY5Au7Kd4em0GgkxoRcBFurMQ60txof/yBPo6atNt+Zz+P/n
	8zaFbjsAI750MnHlXkzHTB4/wjzGPmPYvvBAPgaEx3Xfzxawd9Hoy4Mu66okY4GCuis10Ivf/n3
	cPHErYzpsAgiTJlVLGLXmJJU/dx1/S3cRyzQPklhsZJcjjiWFRZXk+/jaVJk5Y+tvCl0dazvcQP
	PsSATcgHUhHJ57U4rNXMn7PcBvP34j5B7Gll/4Bqf3vqEPH7i4npg+c3yhEMSsOg8OSd2jaqi5L
	swaVoFgzh42nkJH+xn9pZ3mb3x7tGQjSuRXmj7rVJivhdWkgnZnlXFvmebZAEDcnLGf+BvWd+PC
	Z7mFAMb92bH8Zn9Yl24HTRKOrlkaF8otMArxcg9QkhKIC0Ro4bkkQtw08IBhNoOYNYi49qE5g
X-Google-Smtp-Source: AGHT+IEmDZvr2u2IlQtIqIyZH4Dr1kBYmIwFRgzbd9RvDinAWn4YDrH9nrYxIe5OThOMKnhV75ua9Q==
X-Received: by 2002:a05:6808:1910:b0:435:80b6:d27e with SMTP id 5614622812f47-435ec3b14b7mr1093912b6e.10.1755267920849;
        Fri, 15 Aug 2025 07:25:20 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c? ([2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ed1e96adsm246927b6e.26.2025.08.15.07.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 07:25:20 -0700 (PDT)
Message-ID: <8b739044-2854-441d-b744-b014deea4eea@baylibre.com>
Date: Fri, 15 Aug 2025 09:25:18 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: use min() to improve code
To: Qianfeng Rong <rongqianfeng@vivo.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250815080649.582775-1-rongqianfeng@vivo.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250815080649.582775-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 3:06 AM, Qianfeng Rong wrote:
> Use min() to reduce code in inv_icm42600_buffer_update_fifo_period()
> and inv_icm42600_buffer_update_watermark(), and improve readability.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> index 7c4ed981db04..91d166de1231 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> @@ -9,6 +9,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/delay.h>
> +#include <linux/minmax.h>

Would be nice to put this in alphabetical order the best we can.

>  
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/common/inv_sensors_timestamp.h>
> @@ -112,10 +113,7 @@ void inv_icm42600_buffer_update_fifo_period(struct inv_icm42600_state *st)
>  	else
>  		period_accel = U32_MAX;
>  
> -	if (period_gyro <= period_accel)
> -		period = period_gyro;
> -	else
> -		period = period_accel;
> +	period = min(period_gyro, period_accel);
>  
>  	st->fifo.period = period;

Might as well just drop the local variable in this one and save
another line (and a blank line).

>  }
> @@ -238,10 +236,7 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
>  		else
>  			latency = latency_accel - (latency_gyro % latency_accel);
>  		/* use the shortest period */

We could remove the comment as well since it should be
obvious from the code.

> -		if (period_gyro <= period_accel)
> -			period = period_gyro;
> -		else
> -			period = period_accel;
> +		period = min(period_gyro, period_accel);
>  		/* all this works because periods are multiple of each others */
>  		watermark = latency / period;

Could probably also drop the local variable here and still fit everything on one line.

>  		if (watermark < 1)


