Return-Path: <linux-kernel+bounces-742790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83D8B0F6B3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B1716EB8A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F217F2F5323;
	Wed, 23 Jul 2025 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IAt3x+zs"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ACD2F50B8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283282; cv=none; b=aEoyRkxhOdRKPlfEa5WYTCK0GZLmz3BKxV3UE53bTx7hYwZGk1gk4JEQxyPjn8vjNhWHCJz2wzzzACOLuyJx8XDXELMAbdqxKyT6xpbcq8j0hwFUrPsh9KgAzWPUBAJZyzCm8fxLvArG2svAvGdpHmOCqbtlnicb8iGnKp8JDd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283282; c=relaxed/simple;
	bh=cJwHuDTTCzAQgnGkdfA7YOzuTVv2xd12iLSHq8VAjVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7OM6pR1PkVLOIumEmSf6jTHCNtItJvBn5gaqxQ8RkOvGMbjlZoD2bXvO5zQjmQIkuGKT4FBp+xRKfuBzSZRDXAmAnugtf1t0ORzVxLn6g9RO/bJS9FTOLKevWPXFCpyZrxslfNVDA5eIiux3YXamY5F16PacHfmeI979MD4XMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IAt3x+zs; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-41baecbdd36so13424b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753283278; x=1753888078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U79N67VMcpNHZisXl45BR0VTpPIGtcLgjPOjmiuU2Ag=;
        b=IAt3x+zsrYu/vqxRYSLrcS09eHG4wAu8Tj0iY0XTGm5ek60IjrJ/gIGHCQzx0nG+N4
         lNjSR5bcsWvau2rLinbWHLbyqBeAno/0s+BvUj4sqyz8j67i6pruXxjv0gjALFeQvst+
         Hlh/5J9A43i/j460WccAb3H8z8KGwJ+rxhrAs6OqVw5GoAqzbPw/Roz9BELF5KoAvPxZ
         mU7TOXD+daY/99lcQbfw58nYnJmHMoBPhULUarIxd1gzfOUt7fNV405CCKVFby71XYPv
         dTrVbB7l4hSXinr26b95xvduC2dMCUCxf455ErJ9aEtWH6srh16rB1fIQsyBcdQqWEks
         jqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753283278; x=1753888078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U79N67VMcpNHZisXl45BR0VTpPIGtcLgjPOjmiuU2Ag=;
        b=wVm7LB6G1aeGcu6i5UZ/yDYa5yeQ2JW14vOGBXZAhK3IuNl8C8ALlia1I+G4JvNo5u
         KirK4LK21QG9ALI0As9nbGEhwFnt+V6gnCPbpLqNb/9CjEwIgcw77ryh1DrOu3CrR1E5
         RCQwAYQuat5IjzFHXuESQh4bi5tQa7yxSuuxVqz68CB/9GfglBawJfUB3a/h99NsPiwT
         v1DjMBT7unot69jAuov8s5gnB3o2/ckRIoFGN9PuWRNxPuqCv8ULA5R7XsWqI2PVbfyN
         PkmqMNUFBYiBA6c4McW5ULAvCvnMdeeggMpvdFMVrcnj9o2m77lL9whYlAMlAoUL1dMr
         PK5A==
X-Forwarded-Encrypted: i=1; AJvYcCVJlRSZNb4rkqce9G9QoISWToXjrZu1YSh/JaXa41wfLWdph+qfhLaF0CwH3l96WKGIYNHqNR0AwfPOgEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZuO/7KjPLi3X/GoeOmj0MjxVFDhlDcWEGio6H7OR5uNXq6VY2
	bVILqZqf4gT94a/toZZ0yGz2rrSqNljurrNQf7sUXb/eFjqVq9UmopeSZMxQvMGV1u4=
X-Gm-Gg: ASbGncsyz0Yw87uRmBqadPdJ2PTaUZZ7ucYT/o+Fi/kWQsnooF8Ak4sQLYTtcPHzuGR
	cFPM8PHIxdrrZv9pLJ0Qv+1oAG3H4cfrFFjFnqfq4LODTbNaGzfj3sDthzoVqtLGL0f59kAi3IT
	9PNPa9waPL5qiUuiG7afwAHtvCij6wmOXTWLJgUK8UKqz80NV6v0fYtFSpQO0FIGI5UrOtaROpm
	eooUMGgO5AQZ8RACtsizUlxgEc83LIwCcHtx0x0+B3xoXQaHppUjU8xhiEiaXdcSwRc56spLlDE
	k/1xorhqZqSgDkENkyTBZcIhHLffMUl4m4JAHP/wDw8a3JzJnjpZ4Ze0SY6U9vgenCkzzNjnjME
	Y+7OELg65IvYwvLG606pgq+3wWdaItO8/3h5Yl+2d6l2HqxG5n31L+Jc8UuxR6U7942VzdC2a
X-Google-Smtp-Source: AGHT+IFXi7MK91x9eyasXM8kNa5sIqhFwhEC0U46aSD837WPjl2LPJciZeEEI4nVXofP070Rj/214g==
X-Received: by 2002:a05:6808:199f:b0:41f:dced:3c01 with SMTP id 5614622812f47-426ce78369fmr2533669b6e.39.1753283278515;
        Wed, 23 Jul 2025 08:07:58 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:11dd:c0f5:968d:e96? ([2600:8803:e7e4:1d00:11dd:c0f5:968d:e96])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd565cb1dsm3621858b6e.39.2025.07.23.08.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 08:07:57 -0700 (PDT)
Message-ID: <57e16589-3d9c-49c1-ba91-abae23143803@baylibre.com>
Date: Wed, 23 Jul 2025 10:07:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: hx9023s: use IIO_DECLARE_BUFFER_WITH_TS()
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722-iio-use-more-iio_declare_buffer_with_ts-8-v1-1-36188a3f214f@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250722-iio-use-more-iio_declare_buffer_with_ts-8-v1-1-36188a3f214f@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 5:54 PM, David Lechner wrote:
> Use stack-allocated IIO_DECLARE_BUFFER_WITH_TS() to declare the buffer
> that gets used with iio_push_to_buffers_with_ts().
> 
> We change from a struct to IIO_DECLARE_BUFFER_WITH_TS() since
> HX9023S_CH_NUM is 5 making channels[] larger than 8 bytes and therefore
> the timestamp is not always as the same position depending on the number
> of channels enabled in the scan.
> 
> And since the data structure is not used outside of the scope of the
> interrupt handler, the array does not need to be in the driver state
> struct and can just be stack-allocated.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/proximity/hx9023s.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> index 33781c3147286fb3e2f022201ccf7e908d0b6b12..1203fa4bc7512ea85b55d537e2459104b52407b9 100644
> --- a/drivers/iio/proximity/hx9023s.c
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -143,12 +143,6 @@ struct hx9023s_data {
>  	unsigned long chan_in_use;
>  	unsigned int prox_state_reg;
>  	bool trigger_enabled;
> -
> -	struct {
> -		__le16 channels[HX9023S_CH_NUM];
> -		aligned_s64 ts;
> -	} buffer;
> -
>  	/*
>  	 * Serialize access to registers below:
>  	 * HX9023S_PROX_INT_LOW_CFG,
> @@ -928,6 +922,7 @@ static const struct iio_trigger_ops hx9023s_trigger_ops = {
>  
>  static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
>  {
> +	IIO_DECLARE_BUFFER_WITH_TS(__le16, channels, HX9023S_CH_NUM);

Ooof. I remembered to zero-initialize all of the scan structs in the other
similar patches, but forgot we need to do the same with the array to avoid
leaking uninitialized stack to usespace.

	IIO_DECLARE_BUFFER_WITH_TS(__le16, channels, HX9023S_CH_NUM) = { };

>  	struct iio_poll_func *pf = private;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct hx9023s_data *data = iio_priv(indio_dev);
> @@ -950,11 +945,11 @@ static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
>  
>  	iio_for_each_active_channel(indio_dev, bit) {
>  		index = indio_dev->channels[bit].channel;
> -		data->buffer.channels[i++] = cpu_to_le16(data->ch_data[index].diff);
> +		channels[i++] = cpu_to_le16(data->ch_data[index].diff);
>  	}
>  
> -	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
> -				    sizeof(data->buffer), pf->timestamp);
> +	iio_push_to_buffers_with_ts(indio_dev, channels, sizeof(channels),
> +				    pf->timestamp);
>  
>  out:
>  	iio_trigger_notify_done(indio_dev->trig);
> 

