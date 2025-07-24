Return-Path: <linux-kernel+bounces-744731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B127B1105A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B544E6C34
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045FC2EBB83;
	Thu, 24 Jul 2025 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OEXC8xYz"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B5C2EAD14
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378170; cv=none; b=lH7ax1mj2iYss4eRs//HqNz56gXhaQz6Y9iX14WBiwsV3CVbmVkdHvRstvLeFmZY7NJn6vC6eWQATwinsPSTgsuBcm/JZf4vs5VH1ixQu6J+wu9K37hrNf3eIFtIDz4IlFfjRIjmpd/gFoVBX2vXEoqF6Q1rRyHQsTHtE5F+T9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378170; c=relaxed/simple;
	bh=RG1EgSA3MMa83VII11z39CQWpRWIOPcQT4R4UfvPLCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BL+kn85oaGom+8hLNMknkWh7R6muZwd0U0P+/nA5Lchpn0F9s23FA1Ai/J9+hdTG7W8DmgIoTLR1sUauDabC1zFgvVcok5pyO1HYpA3AdSF361oMdesVYaUAspvpgCzsCTlj8auoAcNoeWd7yrOIIH7QqCQhZttJ+V2mwJN1aO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OEXC8xYz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so1078713f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753378167; x=1753982967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J+lCOF2YJwaI25dD2rRePotewyad67jxCtko+PrR7CQ=;
        b=OEXC8xYzlLyaOabwMT++TAfBBc0wnY5Un+qBKq5EMyy8ugp4EMoEvUS8Czv6qtY2en
         b4YniI/2gMApFuRDgqpf3ruBpB0Q25U7YF8wOMQ1W8c+gvrK0IiMxfQYRL1aWqDO8pyL
         Sic2oLW3s2iuqen8+nR39ho2xT8wZJofPAD0r13bXXe027UtApUSUq3zCvJ8ncE/B3wO
         Z8qakxRU2kCbwe6eebZFfaphSHt5lirAPAfQk4qfGhr2PAD3l3WPqKJ7VXj1pSNdIj4w
         o4cb9UEmcK2pUpQk2apfWA5seEHvDx0/wm6jEa4C3g5q4L4QpemJsXprp3r4pD3ynmf8
         h91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753378167; x=1753982967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J+lCOF2YJwaI25dD2rRePotewyad67jxCtko+PrR7CQ=;
        b=vssPBNsRqCxp7E/rEM1szgKZeawlkEWYMuriOR88itlC185bIrbwces5pBGLJjqIHC
         C5mrgjbCvTS5+QFQcDIaeHtADbMJL8r/GyyGl1YXh/2YjiP0rGnp8NBa71/dsaDyq3My
         3ePaZA1i03i+x850GmH+EDXBb/e2SkJ/8VonPxa3gzYpkiw1uQbRCy3wXGxOPJXav4sW
         5hQ4Xw0c2YMEDokFsrfAcnzhQZKE6ZkfgSluLVmh3upPM42thQx9mfLRFt6tqjnfbf1v
         wzPWbreI0W8IrxLQ/N80BMbL8b8dIg2TWdLLZXc2nWWDzfHvYKgr8BkNZJFmQnQKFhkc
         1j0A==
X-Forwarded-Encrypted: i=1; AJvYcCVkfkpwSvvVoBV+4jbx0LWGgBogWtyAW6zkGG1r4Z0LrOMhLJxtm0hrzmdujdhjt3XbNwZU1l5RDsSmcAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUzz/C3wZ35jnkiNiww5dg4n0kTEZqoS4pU79eRlK74wZM1XDm
	Q0Zdk4d2pnouFvkEbmycyqpZZJfLDAoFgRkXm7H1U5mjWRB5YpiRJ7fTqiLbZMG2FeY=
X-Gm-Gg: ASbGnctXS7jWK8Tm//nCjpIZFCPITDD4kvVKM1Ggc9OZoFzRzl1qcLPYL/WLlojTtQ3
	KLItCLOvPe5lZd1WPEJweR6C7gBc9+DfPvKhzWd+TauY06bk1P/uNrIkmUIm4w3rb2fcIkMXpUB
	vCKzKCcG3nDNtEEdwq0FdNF+xu+Jy62Mj83d8fTZx18vd6e9WsH2WhJPinUeOL+zG2jQ0NTUjqz
	FmjPAAXzL3hW8Mx2Vz6tBFQTnTnWKWS6f2NV65ux5kWKy22d9a4jIejwUsowRqwxrfZNaAz9kC2
	NzUL0y3No58XTcSIfYVBwVcJwNcEmWltpmIaTIX6U4ks9Hxm8jXVLaUvQcd4eGJiQozbU05dMMs
	wEJNuEzP+I0+8W28OtJ1eFODS2QeIJWQr+aVLdADPYyGybtwC2yxOZBxvmBh/8SfSUDhfIQX+
X-Google-Smtp-Source: AGHT+IHTFXlusppGaJd4s0ulaPmjKqRFpUR3CdOs6uuJH+6TEHT3Jg3/z2WGGlyjBiE1ICdaFAY6dg==
X-Received: by 2002:a05:6000:2901:b0:3b6:13a1:8861 with SMTP id ffacd0b85a97d-3b768ef8e92mr7301349f8f.38.1753378166644;
        Thu, 24 Jul 2025 10:29:26 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b76fcad156sm2735775f8f.40.2025.07.24.10.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 10:29:25 -0700 (PDT)
Message-ID: <c51c45ef-e769-406f-ac2f-53c90bc78d8d@linaro.org>
Date: Thu, 24 Jul 2025 19:29:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/20] clocksource/drivers/vf_pit: Rework the base address
 usage
To: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, tglx@linutronix.de
Cc: S32@nxp.com, linux-kernel@vger.kernel.org
References: <20250705160129.3688026-1-daniel.lezcano@linaro.org>
 <20250705160129.3688026-4-daniel.lezcano@linaro.org>
 <6b478a82-5087-44b6-b2e6-acb494fe1e22@oss.nxp.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6b478a82-5087-44b6-b2e6-acb494fe1e22@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/07/2025 14:03, Ghennadi Procopciuc wrote:
> On 7/5/2025 7:01 PM, Daniel Lezcano wrote:
> [...]
> 
>> -static int __init pit_clockevent_init(struct pit_timer *pit, unsigned long rate, int irq)
>> +static int __init pit_clockevent_init(struct pit_timer *pit, void __iomem *base,
>> +				      unsigned long rate, int irq)
>>   {
>> +	/*
>> +	 * PIT0 and PIT1 can be chained to build a 64-bit timer, so
>> +	 * choose PIT3 as clockevent and leave PIT0 and PIT1 unused
>> +	 * for anyone else who needs them.
>> +	 */
>> +	pit->clkevt_base = base + PIT_CH(3);
>> +
> 
> This description is somewhat misleading, as it refers to PIT instances, whereas the code actually operates on PIT channels 0 and 1.
> 
Actually it is what we have already in the driver, it is just moved 
around. I'll take the opportunity to change the content if it matters. 
What about:

"The channels 0 and 1 can be chained to build a 64-bit timer. Let's use 
the channel 3 as a clockevent and leave the channels 0 and 1 unused for 
anyone else who needs them."

?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

