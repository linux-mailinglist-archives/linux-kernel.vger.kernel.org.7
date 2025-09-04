Return-Path: <linux-kernel+bounces-801321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 926F5B443A5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1016C188EB38
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D7642050;
	Thu,  4 Sep 2025 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgCxiFYj"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9105247283
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004778; cv=none; b=pesVB165z1H2vkaH6uoVhpJQg6pLIYMJJY21WQa1CxtTpZ2WUgDV1qq6Ei93A5T5C3TtUOgwbtZpTTSb/IirQTWV23q8pbDta0boxSW4klDpm7arvwJYLmu+8WE0dhto3AKKv4irk5KhV/S+S75T22bShHWv2phUIBgX73aa6Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004778; c=relaxed/simple;
	bh=7fvOz14syBHStBNZy4sYRSSBrNYheDkpZc1heoV3si8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amtxxCzR1NDla5rHwKEKJhB3ZMxL9AxbxlH6NYII4ql5emyG9zQ4x41QEO2MClX7OWrWv/9glBRgNoy6pn/XAB4iiP4jQ2J/zMs1THZfdB/l4ggRHPzgopZOo6CeImlqK8sacoo2DCiyuDYk5i2t2TsAoSVq3Lx+OghllTbHMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fgCxiFYj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dd16c484dso6379745e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757004775; x=1757609575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xFh89iR809PVR/b4+ILAvd+FMJiKpRfITsgR1aQ1ciM=;
        b=fgCxiFYjvONXUxH8Fv4gWtI7BDc3qzsItZayOnkLbCWNz0bRUceFWIRlUB0j0b+CCP
         5/3qUH4o8HiPDFngtrez6Pubh1XTKk96vLJNMv9PNV7mK+axW/iJDwAhDUQXhfo+30ap
         Ntp/CRPHIuZgnc3xYw/l6/nYotOZjuLpcSVgeoT3dlgdj9xgqehvsT0/W1J1kMf0StRQ
         1N9MRJ2xUOrDrgARXTcRlYnQn8JBznw+qXOrPXX8tXGoVTjd68UTPoLJSoLniNpk6P4w
         Pb87SN2BNka5AF/SNem9VdXQy+wLqhTlO4C5OnvKZaqG31m9kDEoIBupqgUc6HoDq5/P
         BrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004775; x=1757609575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFh89iR809PVR/b4+ILAvd+FMJiKpRfITsgR1aQ1ciM=;
        b=V/ugyewZFSga+9Sj8z3kVI8y5HM0vUcVTtF7x5mXvmsod262a/AVow6gLrUf2/WO6w
         QVxpsEflkj6xcwEt/7+5rCkCdztwbNc/TphiQGo3cBpjpV1ck1dXbxfEJdVW27Hu9FqU
         8wr7V5qCCaV/270vMTlUh/WuwVWu+t2UwTQqgPzxuAxMIqmZ44WYX+FlSXj5kcFYae+a
         C745pzndpOzJbO9j8XukF9wfQvpogfdEGPMeCtaJnPjLNRpKpe2cByNGQL0ZN6xR7zYp
         i1iynbp+3V/5pyTEupxIwzzr1YT5g/PlVZqcjmk2isJKBwykmNVIdAnxCQH0MITwrijY
         Ip4w==
X-Forwarded-Encrypted: i=1; AJvYcCWv8aT4MUp5qs6FqdgtqefxRJsNwhRgf4Mi4F8qKujsteOMH4U/mj34nfcs84GgaBr7YPS6fTfxK8QvXdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM7BD1dn9gc5IlIKUtQAtOH7iMIxcRDXfd+K/RevjdiclMrvWw
	WvVpQJr3XUHTVTQtRXicw98fFylq+rBuV/EbcgExG/RE4Q25b+N7JxRHSrFWUNNvtg4=
X-Gm-Gg: ASbGnct0BpBCgM5NJYImpvqQMstCXOsP+yOP6KL9JrIMGvJCNHpIrDX/ixQoElmPBqe
	twLZwIhlRpU0k+lE1xZwntECl0d5vV4ECrM1nr6iNm/qziON2CGCS4IvfnOcZ7M1kDj4rlWUMuE
	28gy5AC6sch2+3QeRV/8EwO6PP9XjiAHjmiSA0g9ER26MwBj7QCxXUuRp/j3ElvzICxw7II0ngQ
	5q0rCHjMSB3Yzz1Qm7kEQ7iMEe3DC00peTJLL8IpYe/cQbyO9F9cjmyjOCFLsO8pErtNKrmQ2ER
	Wlrhf6cLWnZrRXqtcSIpHN/Jgm498Uq0ZQUoFtFeB49MoDDs6BeDBGUHQcNTRzyCujjvqTujW6G
	2k79OF+rWsNFlE9AIaYiOppH8O4dQcLab3/r4S9XQwLxjcpuw+f0S4g6977A6mu1pIJyBN4UIlX
	8kH8wAWMBFkbUeY6RprWd8vAs=
X-Google-Smtp-Source: AGHT+IF/3UAqS8oVgCQ/U/GWGmEsXBPfC2dj5lpBtR7xMDWEaxaLpTFZgIdSL6vjxf+WzDQruLwXDQ==
X-Received: by 2002:a05:600c:3baa:b0:45b:8b3e:9f7b with SMTP id 5b1f17b1804b1-45b8b3ea15cmr138645635e9.3.1757004774916;
        Thu, 04 Sep 2025 09:52:54 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:1ca0:c789:48cd:e2f9? ([2a05:6e02:1041:c10:1ca0:c789:48cd:e2f9])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45cb5693921sm91433315e9.0.2025.09.04.09.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 09:52:54 -0700 (PDT)
Message-ID: <9d4e7851-a874-413b-974c-d499ed59f553@linaro.org>
Date: Thu, 4 Sep 2025 18:52:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
 <aLgrGlpNrDTC5LAd@smile.fi.intel.com>
 <a34efc36-0100-4a7f-b131-566413ab88ae@linaro.org>
 <aLlAugdr-hwMNIje@smile.fi.intel.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aLlAugdr-hwMNIje@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/09/2025 09:33, Andy Shevchenko wrote:
> On Wed, Sep 03, 2025 at 05:28:09PM +0200, Daniel Lezcano wrote:
>> On 03/09/2025 13:48, Andy Shevchenko wrote:
>>> On Wed, Sep 03, 2025 at 12:27:56PM +0200, Daniel Lezcano wrote:

[ ... ]

>>>> +	ret = read_poll_timeout(readl, msr, !(msr & REG_ADC_MSR_CALBUSY),
>>>
>>> Why not readl_poll_timeout()?
>>>
>>>> +				NXP_SAR_ADC_WAIT_US,
>>>> +				NXP_SAR_ADC_CAL_TIMEOUT_US,
>>>> +				true, REG_ADC_MSR(base));
>>>> +	if (ret)
>>>> +		return ret;
>>>
>>>> +	if (!(msr & REG_ADC_MSR_CALFAIL))
>>>> +		return 0;
>>>
>>> I would expect standard pattern — "errors first", but here either works.
>>
>> Does it mean this chunk of code can be preserved or do you prefer an error
>> block followed with a return 0 ?
> 
> Up to you. Only the question above (readl_poll_timeout() use) stays unanswered
> so far.

It is a typo, it should be readl_poll_timeout() as you suggested

[ ... ]


Thanks

   -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

