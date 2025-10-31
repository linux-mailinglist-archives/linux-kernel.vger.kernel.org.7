Return-Path: <linux-kernel+bounces-879647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1099C23A6E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5ED3B9F27
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6E8285C8C;
	Fri, 31 Oct 2025 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PrpmTPir"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A823167272
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897787; cv=none; b=Ck9CCU4UGl5P1g2kyQTZ/ymMFyuOY9CtVIxG8+y+Osbevdi+d5Gq8RMI6ENS0EzrH+cnUaBsQ9wCmrbnVcihaabiLCTD2WjZm2tfU1YnSmMwOSR+57krrQltPONmi6AJ1St06g03zW1SMh+FaHScAJyEbv3rpLIeluEthVj3YA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897787; c=relaxed/simple;
	bh=rP/EAMI45WYJlvg0iRFxgh/OmWO0tg41yWxJgWgYAAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apVIuDApJhxpghY/ClNaqIg88IFqnXGkbmyGtmQqCTZtupVSq3nTMEihVbX2DHWXxT94Y7bpIOiBc9X2Hzj7oHViYuAYGv6KygQKk1qGBu0ooqHB7LzcmkoVfVNzn8juiHA9+2hjWuCVIIxgT+R68Sun2nBETdwh2jMDKpExgZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PrpmTPir; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4770e7062b5so13826525e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761897783; x=1762502583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iuxiUkBLx8vKlnec9/5CywDzn8GdyQUbr0sVZo29GFE=;
        b=PrpmTPirpG7QvI3eiWvG2RVErrKFQJCllGhmqkOf4oIeeMGoi/eejISvRZO6cNHrnG
         j87SMro0V3O+zfgFdDaUXl3qqeyKIhAMX32ZQCF/gWwQdU5LO+d3Tg3gjLjblA4LldZ/
         FfDYx5DzE+XFX6Tuy4KDHp2W1JJF/wAOnBHBFAJR7ToPX8DQai0zILIe/I2Qmy9V7nTo
         gbMiceQOfxWZiKt3Pi74MSBEkfWrTcSYmpL1GDsSazZCpgKR7tOw6YyXYc+STRtydoQb
         DWOKytn/eVYM7Ur82NrKQ1ztIk4wcb2KywgUtMyxs9s3s8BiaXwqu3MhR06mc4Gme26d
         nH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761897783; x=1762502583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuxiUkBLx8vKlnec9/5CywDzn8GdyQUbr0sVZo29GFE=;
        b=MW5QntyrBhCBR67w0+ZA5z9KuM9oKoQXV3czEp+YcekPvanEyMZzau7E6Y9VDbbxvc
         baylvcB+m3ui2hpgS6AErRnNu7mBVs8HBiYseZvjd3A/q24EsWk4Lj+sMdww75PJHPG4
         z/8vcfrB+bvwx/4JIN0fzQ4V2sPqV7ifjKZHzyJtTYrcS6m82HsQtvc8wNtPxzUCUVGs
         Edoyw0caquiC3Fpdz5f4w9tjn1PMYbRwn+8M4g7YW67wq06YwwU1kPWBhpFYn0/XvCBu
         nopcfg8oMW/glle2Y3m+J4kMuW/tEXBz+wnEK5ouWx07tP4+aCyOEqrBeqRj1BxMPRyX
         5TLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVofkxGXfiHdLM2vfoLR7qR2+RnJyKg7UoqjcG0tZla9ppfAuEU7pqj8DiY7wCBW+iF0ayNscbASJH8SJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YySgxStCaJ3j2I78sdhJHnUGDeQm3FMEmyodLMYfc+HvBGLlTYS
	N1/TTfaOzzGeHUNllo/7VdLdFI6GxzJfk7Yuj8ToLXZPVh7ox8PB3fvMpty6oxl7H+Y=
X-Gm-Gg: ASbGnctUGW2DBZzXdSIhYDNenP3SrBYW7b2kaLfoiPHmVoUxawnqK+YoU4+UYgoHg6C
	C0EyZ9+YhNOhFK2dPZbn1fzUb48iEwZLqvYGH6Zp+6CUC6olOtC+F1fhYTeSDv63P+nl3JgNGIp
	85TurGHbJAvJiyfVphG+Tb75yGd2ypSlei7gpLbP1/RKGUMyhebeMv8HzD7h879b9zz50YalZW7
	xClooMTF94+MeGRQgugd4mkEGeE66LPxGYhETYhukYYqp28oly78bNkAPKMngehcYlppZG3unWz
	7WlxmSP3k1Xzsu81Fwj2PE/gv911t2qlurNOUZQqYc1nIb6OPUJdrwFxDhf2WzCaHBfw1N35eQD
	jSAPSHX2SQtMT+Xc5sHLDT4C6iEnTjPKCmdzeOH83LDzqkksvmgz4/hPQjpxsdfusu89NNepiMC
	GeqOiVHB0gpVqhjKU1mCe0t8eWEUJv5+JNrcNjBNu7bKsiiqiTyOTBtSvzW5Ny
X-Google-Smtp-Source: AGHT+IErZEMZ8RsUWbyCgbeb1Q5ZNzR29K+yKSMn2AYjlqALM0mnJriWuWEedLWtLw+5aAf7+4a+8A==
X-Received: by 2002:a05:600c:3149:b0:45d:e6b6:55fe with SMTP id 5b1f17b1804b1-477308e5d8amr25954095e9.34.1761897782651;
        Fri, 31 Oct 2025 01:03:02 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:2b:468c:c228:91bf? ([2a05:6e02:1041:c10:2b:468c:c228:91bf])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429c114ca0csm2361827f8f.21.2025.10.31.01.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 01:03:02 -0700 (PDT)
Message-ID: <2316cd4e-737d-4596-b713-2f29928ab26c@linaro.org>
Date: Fri, 31 Oct 2025 09:03:01 +0100
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
 <050f96d5-e60c-4b33-b6d2-24fb3925e378@linaro.org>
 <aQMvqHGN7r6babgw@smile.fi.intel.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aQMvqHGN7r6babgw@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/30/25 10:28, Andy Shevchenko wrote:
> On Thu, Oct 30, 2025 at 09:27:21AM +0100, Daniel Lezcano wrote:
>> On 10/18/25 22:12, Andy Shevchenko wrote:
>>> On Fri, Oct 17, 2025 at 06:42:38PM +0200, Daniel Lezcano wrote:
> 
> ...
> 
>>>> +#include <linux/circ_buf.h>
>>>
>>> Why not kfifo?
>>
>> I'm sorry but I don't get your comment.
>>
>> Do you mean why not use kfifo.h or use kfifo API and change all the code
>> using the circ_buf by the kfifo ?
> 
> Yes, I mean why use circ_buf API and not kfifo API.

Ok, thanks for the clarification.

At the first glance, the resulting code with the kfifo API would look 
nicer. However, on one side, the current code was largely tested and it 
is running on a production system, on the other side the IIO framework 
will evolve with the cyclic DMA support and this driver would be 
converted to it when ready.

I can convert to kfifo but if it is changed again for the new IIO cyclic 
DMA, I'm not sure it is worth the effort.


[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

