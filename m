Return-Path: <linux-kernel+bounces-721716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B418EAFCD00
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E983A5709
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C902DF3C6;
	Tue,  8 Jul 2025 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RI/W+5OD"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049142DC342
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983846; cv=none; b=cTBwxz5OCBc34yKADX3QyLdMHUhMI5U85y5NhRiFxrP6J8IceWDpZ+/cLY4sdwmKSNP+lZpfnUR2F6s9A/uO0X1yhAJejipgUsbsjgtWOJJe8lbWHKQQojtn0CaWcnndKbWmI7Uh81Ub3b2EhZFcQovTwnfIONShxoAQxjb3XBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983846; c=relaxed/simple;
	bh=6qVC/81iUn3tvRiNiz2aMOEHOZyxb34pDt1UwQ+S4AQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFJZs2n2YzhekuIEUYOB3w9IfFikhvN0qHkj9U8bdc0xnYdOuU8VD2IYGtsG7r59wBkZMCKQqrup+BII2npa9ADMIms1Ij1r/MD3PQYU1ju86ADRRUxp2DZWvteGbpr9qNE/0AaqhcSWqO50F4H8q2KkvwY/tSRrRTzaZK3CMr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RI/W+5OD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so3339187f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751983843; x=1752588643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JbFRXo7PvgTjLeuBlkvvrU8m32Gx42ivaN7h1EVraoQ=;
        b=RI/W+5OD4JGeOgco/m1iHxKano6L3aZTkvGscBqbRU6u2aAWnSsA6M4x5I7eTWe2W+
         ulPBIn13053KUvO9Iq9JJdsLmHPKWT8vEGJagC2nxthe+KEwN4eaaNFI+B7jOp3KX8BZ
         1MrqpyPxyo6EOTwkWM1DlIUdVxo0Kh3nFQSdZuRUmJ1bImXPHDYgpNN4K6UhlebVAVkw
         H5y6aDF8+/6M0CztG/SWhyEUBx3O+axohvGaIKs5L94UB2D0olhVyn6VS4dvs6qtxVNJ
         hw9tkfOCkiPRdxmf/BZsppC69/D4661OoIYeaHtfAcmErUtt+WZjMsdX7yl/KmpzOHc8
         6PpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751983843; x=1752588643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbFRXo7PvgTjLeuBlkvvrU8m32Gx42ivaN7h1EVraoQ=;
        b=JUmo86b1o0eOHQRaZNSPHRAHCrl4TK2HhBTjBKizosl960+7EWsvXjZVP/kS08LXD9
         B8vMtB79QYzDfj7THXZoGdYv4K4l8+/sSOG7kKCHRu9mrD5V49V317nA+KpXQkJboBYL
         SGrhULykE+O90VUGXKBJyZ3u5Fe8c+BvPQ3JngTE0OV2QcqXIjfjZ94sHChZ7sv3vKNM
         csHKrQfvNfaVjE+1xhYaTKsKKsr9fC3hMIbVoq4NLteLhCbLeRpxc5G8x1UbevdIfhgC
         k0l8nW+S8GQzr6Ibdrz6vhLAOAjTdeZ3eBHzsMIe62QqN1Ywnq2gH9i+r5z4g3TFUv9D
         yE3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrR166Bl4YMfT/Bl+Os2e86OfkY6Xp0IvrbWR1w34SvMLJjzOAJfYgTcO5bbMzRFJWL4YrM6L1qYH7mro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzf3opaAp1ngRyscilfP8GX9K3lcmE5xaLKzfbmi+YreEIOoFN
	XM324CYGeIBdWISZcophVf419/s/W6BJVNwzAvAyd8kl/TwGX2LvajvwGNd+jJLWsx8=
X-Gm-Gg: ASbGnctFw9mm4C16972lFUe+DI75CftvZCVB3bxgaKq0gilmNRgEKcMAj7vw9Gzt2da
	9EMNyb3MTHy1uBjjRaUFmEhZVZTIF3vBYGKwCKK1KW0vfLZG83BB3cdSaJJc9tAGI9fpLpVEKJe
	fI4QfRGr8gGPGfLgqNoeda7BBTxLE5pbQgcuvc3iXXpI+zCbaZ1Wf/FVXkjqB9UGnpCthT/RSd7
	S167mLUB0WXUv1xHnGARqvXirD4LFDyR8NQL47nUMfu9516C3UGeOQq+u6ehcbctQplgo6jYxwH
	5hRN4fir+hZCulg4jsid4Qer2tghHOvq5CX0hURwsP/9HsqiBcc9WHNhDFAhZfiAjAKBtqCfQAZ
	iJmacnOpjvgx8Dn6lVLhXmimhNg==
X-Google-Smtp-Source: AGHT+IGpLRnIy1Pa7Ys8993jpdk99/IfEELNXoxq2vTwNBbSHflnXa/ydsmKxydaHxoVrMXZjys/ew==
X-Received: by 2002:a5d:64c4:0:b0:3b3:9c56:49bf with SMTP id ffacd0b85a97d-3b5ddeccdf1mr3118796f8f.56.1751983842948;
        Tue, 08 Jul 2025 07:10:42 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b47285c6c9sm12946983f8f.89.2025.07.08.07.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:10:42 -0700 (PDT)
Message-ID: <fc2956c4-4b09-4573-abcc-df5258488e6d@linaro.org>
Date: Tue, 8 Jul 2025 16:10:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource: timer-tegra186: Enable WDT at probe
To: Jon Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: Kartik Rajput <kkartik@nvidia.com>, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20250703110415.232741-1-kkartik@nvidia.com>
 <aGuYuHx5qlKCur8P@mai.linaro.org>
 <58d948d3-bbc9-4fca-9393-ce995a4e2567@nvidia.com>
 <5e8714a9-cd2c-4dfb-a624-8a1adba91da1@linaro.org>
 <rq2mdqmg5hnyg6tqluw6vsk4iecgvcm7muhwzr2bhwoi4y7bvi@3cvxzduzw5og>
 <031fd310-f484-488e-a6e3-88802f42d821@nvidia.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <031fd310-f484-488e-a6e3-88802f42d821@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/07/2025 13:42, Jon Hunter wrote:
> 
> On 08/07/2025 12:22, Thierry Reding wrote:
>> On Tue, Jul 08, 2025 at 12:03:52AM +0200, Daniel Lezcano wrote:
>>> On 07/07/2025 23:19, Jon Hunter wrote:
>>>>
>>>> On 07/07/2025 10:51, Daniel Lezcano wrote:
>>>>> On Thu, Jul 03, 2025 at 04:34:15PM +0530, Kartik Rajput wrote:
>>>>>> Currently, if the system crashes or hangs during kernel boot before
>>>>>> userspace initializes and configures the watchdog timer, then the
>>>>>> watchdog won’t be able to recover the system as it’s not running. 
>>>>>> This
>>>>>> becomes crucial during an over-the-air update, where if the newly
>>>>>> updated kernel crashes on boot, the watchdog is needed to reset the
>>>>>> device and boot into an alternative system partition. If the watchdog
>>>>>> is disabled in such scenarios, it can lead to the system getting
>>>>>> bricked.
>>>>>>
>>>>>> Enable the WDT during driver probe to allow recovery from any 
>>>>>> crash/hang
>>>>>> seen during early kernel boot. Also, disable interrupts once 
>>>>>> userspace
>>>>>> starts pinging the watchdog.
>>>>>
>>>>> Please resend with proper recipients (linux-watchdog@, Wim Van
>>>>> Sebroeck, Guenter Roeck) and the changelog.
>>>>
>>>> ACK.
>>>>
>>>>> Can someone take the opportunity to split this watchdog code and move
>>>>> it in the proper watchdog drivers directory ?
>>>>
>>>> I understand that this was mentioned before, but Thierry previously
>>>> objected to this for this particular driver [0].
>>>
>>> Yes but meanwhile we found that the auxiliary device is designed for 
>>> this
>>> situation.
>>
>> Honestly, adding auxiliary bus into the mix is total overkill here. I
>> always thought with all the tools we have today it'd be easy enough to
>> have drivers spread across subsystems if that's what's best.
>>
>> But if y'all think this is the way, then sure, we'll do that.
> 
> 
> Yes we are happy to conform to whatever is preferred. However, this is 
> really a fix and IMO outside the scope of any refactoring work. I have 
> been pushing the necessary people at NVIDIA to get fixes upstream so 
> that any known issues are fixed. Hence, I would prefer to handle the 
> refactoring separately.


Yes, absolutely


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

