Return-Path: <linux-kernel+bounces-877770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F5FC1EFAA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE713A84EC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF429338599;
	Thu, 30 Oct 2025 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTVQqxHd"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B83A2A1C7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812847; cv=none; b=adOljr1i94DLPk4fzPpwzToAop3KhlDx4CgBy6Qj9vWJ4sPE/ByW32/l/hlny95o47yQij7OYuClqIfMeG99r6bLfFjfwDoLmbCaBu8YjR4E9q1cwTL2fjt06fstm4jJQi1k6lNp8fz45RhXrFGm2yazbDsnExCft00fHEqg6JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812847; c=relaxed/simple;
	bh=UDQb1+mEWC8Kf1gDMEyhFiMaB5sUmGPqCh+7teEp0uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PuWpEza8CwPeLmtVwzx/Rn60VBE+RoTAqvSNAu+NexyMLKXc/C/c3v4C3VmLDV5YTgSENmqtWr6mfGNosnGVI1cgconUXKHEueizRNo4rT3JVS+gT5or/9HPVx56FAaY13aDNpJUR1mqYBYa2qU04iUDs29A62Io+sxNui9sk/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eTVQqxHd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4770c34ca8eso6397825e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761812843; x=1762417643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Cx0kxFaBCbR91JhvRx0ITZZstWHSbBwKql2sLDgf/c=;
        b=eTVQqxHdvR8f6FZR3vhYwHzTaOI+Iqd0AidYzy/cQ6Ctqe1GOfwMfzLV1dD+hBdKMe
         /UwURHlukUYdg5P/svRVgpEQTFajBSlJeqOa6oDt7V3Rp77Eh3olF+4NwKLVzcquCynp
         XaQYXnsOCrUYemZFQgZibun5vI0IDiZFcj4tCZC7KEf5oKhtWBvAo4LOxvr2xWcL9Q1p
         dl+Fo+Ve+5YPDy5wFmAC1s8TbRwPp94YOg/UxAg2iKlD0tGc2tyG0HN/3gl6URGWgLNv
         flCPO5ph9AKOsTfvsM65h8mcTnD37+HXivzXWB+mZ+TjwRiBA3drP9vPnEwGev3EmW8N
         /qzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761812843; x=1762417643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Cx0kxFaBCbR91JhvRx0ITZZstWHSbBwKql2sLDgf/c=;
        b=CkG9eQFSSAqdLCVyCG4hvHkkNbo+f5Cq9mPyYEh9OY4jjcKdDEtkmoCGUeBGDKK5B7
         yXrCRwNZttBf75RsqHFUAvd3PpwbFcJIwkqUBd95LhQ+m/nFGYLY9PBER9xUe8uKcn5i
         7sQL96IG7sjGKgLFc+QETf7wuGcTYO88Qb1XbZUfTjSDl4o8Xj8dk2zda1/0HI3zofvX
         hcQINrGvp3RYlDDAVU+pwfmA0o46Hff4VuHaPkYLjYRVxA8jLpo1PjTD7vLQimS590II
         DFaLwUvjXKzPODx/8aht15yzoSpshtwxhZ9E5dHP3xHfe4cd+ldUv6BelXJH2LFr5CAv
         Io9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtLhJCVLGlym7ndCULXYmyRspGGj/D+RFOzymFxu8+OSHfdderaX3aJeWZHDGzGV0LS85oVt61mJakXxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygZqagrPQSe54hY1XCzG3Vj8MQ9hhm8Zjns9SV5bAyz6RPTRes
	CFB56lIaOzsENTLGQgA95/DVU+OS7XeJI5yof9Xc0r6f1xxBIYL17GEhx5+e9IxIvSg=
X-Gm-Gg: ASbGncuWoFNKF0467akMWJizI16HgDYQR7xNVoT/NHJP1N1zaXIuCqHeXwCwAf8z2rY
	ncfvHC6NvkA4bK+mm9lKLm6MnjHX+uMZNjsBQLiv8nyOZHCbk6x5BZ1eiFn2t2GFy/hs2TEJu+h
	1Ebjm2JZVLXzygt3b6PL/Em+kG+Hhmvx2kwRvv4ohlHm4uCvBoWX3+nF2vhAweexNQX1KgVBR34
	KxY/QfzW1wt2sEmtJw7La6ypXp3uLgeJl8MO09zWkgz96J4g0vtfipha5cst+qUcI1O6EivjjNb
	T/xtMnwsv5W5Y/RX41EIKIa9S+KrQQUHkWr/xGffrR7HyXPIILgG9hOx6MV4ZxSlbWymt7BYXsX
	R5YpOsgCa5Ku2JqMPisQ1B7Vk9bEHhXKBZbLYNa3a3hgEUGnaf+oUUixH2YydTrTeWz3uAskHG2
	NaXFrTMtB/pVf9hI4RqN2CyVDbv034qqkTuxSmyBlSpw6WD/ChKH/R4a8=
X-Google-Smtp-Source: AGHT+IEpOqqQd6suUlzGZQizli8cmv6trmiqjxQtOiZEhtbP++rOooGf2lSVBQRYJvEyQY/YzRO1Ig==
X-Received: by 2002:a05:600c:4e52:b0:477:c37:2ea7 with SMTP id 5b1f17b1804b1-47726009fe6mr20555685e9.21.1761812843457;
        Thu, 30 Oct 2025 01:27:23 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7e89:8fed:3647:15c8? ([2a05:6e02:1041:c10:7e89:8fed:3647:15c8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-477289e7fd2sm28493615e9.16.2025.10.30.01.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 01:27:22 -0700 (PDT)
Message-ID: <050f96d5-e60c-4b33-b6d2-24fb3925e378@linaro.org>
Date: Thu, 30 Oct 2025 09:27:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20251017164238.1908585-1-daniel.lezcano@linaro.org>
 <20251017164238.1908585-3-daniel.lezcano@linaro.org>
 <aPP0uVZu1T7tTQGo@ashevche-desk.local>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aPP0uVZu1T7tTQGo@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Andy,

On 10/18/25 22:12, Andy Shevchenko wrote:
> On Fri, Oct 17, 2025 at 06:42:38PM +0200, Daniel Lezcano wrote:
>> From: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
>>
>> The NXP S32G2 and S32G3 platforms integrate a successive approximation
>> register (SAR) ADC. Two instances are available, each providing 8
>> multiplexed input channels with 12-bit resolution. The conversion rate
>> is up to 1 Msps depending on the configuration and sampling window.
>>
>> The SAR ADC supports raw, buffer, and trigger modes. It can operate
>> in both single-shot and continuous conversion modes, with optional
>> hardware triggering through the cross-trigger unit (CTU) or external
>> events. An internal prescaler allows adjusting the sampling clock,
>> while per-channel programmable sampling times provide fine-grained
>> trade-offs between accuracy and latency. Automatic calibration is
>> performed at probe time to minimize offset and gain errors.
>>
>> The driver is derived from the BSP implementation and has been partly
>> rewritten to comply with upstream requirements. For this reason, all
>> contributors are listed as co-developers, while the author refers to
>> the initial BSP driver file creator.
>>
>> All modes have been validated on the S32G274-RDB2 platform using an
>> externally generated square wave captured by the ADC. Tests covered
>> buffered streaming via IIO, trigger synchronization, and accuracy
>> verification against a precision laboratory signal source.
> 
> ...
> 
>> +#include <linux/circ_buf.h>
> 
> Why not kfifo?

I'm sorry but I don't get your comment.

Do you mean why not use kfifo.h or use kfifo API and change all the code 
using the circ_buf by the kfifo ?
> ...
> 
>> +#define NXP_SAR_ADC_IIO_BUFF_SZ		(NXP_SAR_ADC_NR_CHANNELS + (sizeof(u64) / sizeof(u16)))
> 
> Hmm... Don't we have some macros so we can avoid this kind of hard coding?

I don't find such a macro, do you have a pointer ?

> ...
> 
>> +	ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk)) * 80U);
> 
> Do you need those 'U':s? clk_get_rate() already returns unsigned value of the
> same or higher rank than int. No?

May be not needed, but harmless. I can remove them if you want

>> +static int nxp_sar_adc_start_conversion(struct nxp_sar_adc *info, bool raw)
>> +{
>> +	u32 mcr;
>> +
>> +	mcr = readl(NXP_SAR_ADC_MCR(info->regs));
>> +
>> +	FIELD_MODIFY(NXP_SAR_ADC_MCR_NSTART, &mcr, 0x1);
>> +	FIELD_MODIFY(NXP_SAR_ADC_MCR_MODE, &mcr, !raw);
> 
> !raw, which is boolean, as a parameter to FIELD_MODIFY() seems a bit odd to me,
> perhaps simple
> 
> 	raw ? 0 : 1
> 
> would work better?

Sure
> (Note, optimizer of the complier will avoid any branching)
> 
>> +	writel(mcr, NXP_SAR_ADC_MCR(info->regs));
>> +
>> +	return 0;
>> +}
> 
> ...
> 
>> +	dma_samples = (u32 *)dma_buf->buf;
> 
> Is it aligned properly for this type of casting?

TBH, I don't know the answer :/

How can I check that ?

>> +	dmaengine_tx_status(info->dma_chan, info->cookie, &state);
> 
> No return value check?

The return value is not necessary here because the caller of the 
callback will check with dma_submit_error() in case of error which 
covers the DMA_ERROR case and the other cases are not useful because the 
residue is taken into account right after.

It could be written differently with the DMA_COMPLETE check but the 
result will be the same. I prefer to keep the current implementation 
which has been tested.

>> +static const struct nxp_sar_adc_data s32g2_sar_adc_data = {
>> +	.vref_mV = 1800,
>> +	.model = "s32g2-sar-adc"
> 
> Keep a trailing comma as here it's not a termination member.
Ok, I'll add it

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

