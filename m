Return-Path: <linux-kernel+bounces-857650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE63BE7592
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33977428B44
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECE32D24BF;
	Fri, 17 Oct 2025 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I01NWFiH"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48166263C91
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691709; cv=none; b=bu0tMVW2fPNWX3VVzre5HiiZjilJkOYn9ctDFNpGmYO10coyj6wLC6W3vyiWI7bejBNJln3H0O1xbbKcG+ObgzR7sdwubivr3qh8mTShZtWi40y9Ryo8HO4yJXssRKUqE7TBIsfXy3tqoWZ6cTIyEia4SJIhSIB4roJ4tCjJMCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691709; c=relaxed/simple;
	bh=djPFq2gC3Dt2nGEV5JtwRUan8R7/PSxIqukec0osdPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHU2UrZ3+fyesH9gh+hhTSQFvMbjG5z83g7CU5jhCZa9+4pqdKTLId2kmse82pOFBOxcl50XESyOL4v1ywqCUcHpQNjYXm//kG1h1BNWlVXy2JFfRU4RFcgmK4tWmhU4VXzA5ujFCtyY83WpBShyRfJWaMgR5gs12psso3F5AS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I01NWFiH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so1072654f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760691706; x=1761296506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iKxKNbwNQkJ4t2h3+ChbVVYFS7tJ5MtBs9u+B3K37UU=;
        b=I01NWFiHjYHwR7mBS2Sb0F50alLe8BulqmC+qmZx7eqPO1MuNPNkC9xAiUbE1BR5mv
         V79iAw9NBfX+tadlmaLD7Nd3u3/v2K2MZ4UKxdaqWCRSySbvRT4MoVK6WmesLhsuDldy
         6LGQOGnWsURCqiZOR6m1rrU5m4otzqvQuNdp0MtAhSzwuNzrAo9NKYo/mZv2wqS+okDt
         Wnal8lnlvg8flXri2Pd7Ral0kzw+Y4rt3Gaq+uw+iwWGVae7LpqnqEPiVG5KYDd4OFvD
         7dFRVQGtezgUlMHyAW5FOdJfrfxcYvGAYdXbSUeQ6Bz6rW4OGHv5Vt7BjIdOk/vJTl6C
         zbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691706; x=1761296506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKxKNbwNQkJ4t2h3+ChbVVYFS7tJ5MtBs9u+B3K37UU=;
        b=iD/EQI6dy+cHtL+qx1U2rUpaGQ72CDVEqP5TImrdgDE1xm7j5pXpbE+MvllxE75lVV
         AdSHpUaPvgMtzS88vjmgHq9uFzJ+ABJsNioyn3jwySg40WPp7lq9o4JLnnATq2MyeVMc
         jJXeIjqSXg28kY9984Iuy8lmvXKxJEtd2jvav/MRYwai7URnjTHUB6pgVMEX8QDVIFIb
         sO+ZD7sAe1ne5F3uXw7+yanjv/m1GDELFqMmbuidYOiAcB8dq1PkHAtxRqX/JHYGaD34
         LPUTFss2q607wCM0n2Lty9JOLTmqFDKZp2xMjklDLIKZHFyy3kZFFoIhFH3G0bxqDrUW
         tY5A==
X-Forwarded-Encrypted: i=1; AJvYcCUcyJWU+lX8NbDcpVQqtJIU8YA7FOMo45lJeOoKtLikPHKdyLNzRIcb44NJ0RF4riroQiTkhkbojl4Z+V8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLP2zVApUzHvjQVN1+3dSX64qRNgWt6NfQfkoWFjy3kQqt+xfk
	UvwQmpg49IpmuhxGtyMxvBPjfZSyUd1vdHol+99cKTPmv6+rXaUAMC2AXt9LbFi43D4=
X-Gm-Gg: ASbGnct8d/KMFY7YObl8jqOF23CpKykYvPvciVxl6juUMz3pNLvZqOLBSfP3Zm/OoB5
	K1daZPTOXVLfHWSYHvHEDoKQB6ZcOWV5hyoHTIt8z52vz9yt6E7z8pIWOhy3JiGXXJ86En7ZZgz
	GOi2zr63iv+pL7CwOLj0zhjhIpKAzwwIpgQ6zs6XwW7UVn8RdsDTKo0WXvFSbBCj3o+70seOMEl
	8zqmm5h+HHw74gdXFl1HjG9nfY5e9YgvZ6tch6H6B/9CzD62DMyI+D3cy54K27HyYaUuBMHclFN
	BRAvpkcgTyZgaTy+1VC4sIK+Z9013CfxBqX8VkMH/72JD1Aea2cKP959+0KVheHza8ruJq4VL9J
	ECC+FhwXVR1KRlVGYUnB5PpKRcreZ5Jc5UFUF6ULhBjdHAug140KIOaTycTCdzsws/bCJSylzxi
	VEREIGdwzTWBKBB4rGicLTV9HfFkbFIWl8/RIu776CTYzNh8gqklDRFhY=
X-Google-Smtp-Source: AGHT+IHfJonJhWahWTiwtz0KvkOGbv6zgJWv7y5VwWJlO4+UNFuOt7HIqplliOl6LmCWRzK2SmhOrA==
X-Received: by 2002:a05:6000:2087:b0:427:921:8972 with SMTP id ffacd0b85a97d-42709218a43mr446976f8f.40.1760691704830;
        Fri, 17 Oct 2025 02:01:44 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:1b84:3139:75f4:2ca6? ([2a05:6e02:1041:c10:1b84:3139:75f4:2ca6])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4270516f930sm4722303f8f.31.2025.10.17.02.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 02:01:44 -0700 (PDT)
Message-ID: <1bfa9a86-0a80-416a-b653-8d14f5ebd891@linaro.org>
Date: Fri, 17 Oct 2025 11:01:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250919135618.3065608-1-daniel.lezcano@linaro.org>
 <20250919135618.3065608-3-daniel.lezcano@linaro.org>
 <20250920102742.4cadb734@jic23-huawei>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250920102742.4cadb734@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/20/25 11:27, Jonathan Cameron wrote:

[ ... ]

>> +static void nxp_sar_adc_remove(struct platform_device *pdev)
>> +{
>> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>> +	struct nxp_sar_adc *info = iio_priv(indio_dev);
>> +
>> +	nxp_sar_adc_stop_conversion(info);
> 
> I assume this is safe even if no start has happened and is here so
> that the driver remove can run whilst buffered capture is still going on?
> That should be done by the core as part of unwinding the register().
> So I'd not expect a need for it here. This may be a side effect of the
> ordering issue mixing devm and not causes.  The same is true of some
> of these other calls - I haven't checked them all.
> 
>> +	nxp_sar_adc_channels_disable(info, NXP_SAR_ADC_CH_MASK);
>> +	nxp_sar_adc_dma_channels_disable(info, NXP_SAR_ADC_CH_MASK);
>> +	nxp_sar_adc_dma_cfg(info, false);
>> +	nxp_sar_adc_disable(info);
>> +	dmaengine_terminate_sync(info->dma_chan);
> 
> Mixing devm and non devm is a never a good idea. Here one possible issue is that
> the userspace interfaces are only torn down when devm unwind gets to unwind
> devm_iio_device_register();  That happens well after this code has ripped down the
> dma engine that a channel read will try to use.  It might be safe to do that
> but it certainly makes the driver harder to reason about.
> 
> A simple 'rule' is once you first call a non devm function in probe that needs unwinding
> in remove, you cannot call any more devm functions.   Whilst there are lots of cases
> that are safe, this approach ensures none of the cases that aren't sneak in and makes
> review straight forward.
> 
> devm_add_action_or_reset() can often be used to keep the chain of devm calls running,
> sometimes covering everything such that we don't need a remove callback.
> 
>> +}

Actually I think these calls are not relevant. If we remove the 
nxp_sar_adc_remove() function, the iio core code will unregister the device.

All operations are doing on/off in the different callbacks (raw_read, 
postenable, predisable). When the device is unregistered it is not 
possible to have an ongoing conversion, a channel enabled or the adc 
enabled, as well as the DMA. IINW, we can just remove this block of code.

[ ... ]



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

