Return-Path: <linux-kernel+bounces-638041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DF9AAE0BD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 15:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031BF9A032D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 13:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7447288C28;
	Wed,  7 May 2025 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qSqkbLQX"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA13A209F2E
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624512; cv=none; b=HzKkQO4LnQrzIRXkoRdvet304adSvXhY4F4k7IkKwEGZS7cgD+VcheFB1qLrtelYUqs2crUa0vERzh9WlwxCFcYVJuXgndiL954mYHv7orXKJHqleZL4WjQJO323lT90+We9Q2NaXmo4XbTUZVCEh0PSWRyj2vMoAVnuwXR9r+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624512; c=relaxed/simple;
	bh=SKO83lrLPvLSrF0yvTjpxd10hpm9cNWWzdkME6QznkM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KoCkJLWZw/HTNPWzUSzj0/jrMmkBLrSI0+ymXCq4kxOyBzVfWNGmBiGGqyu2atW+z1Hgu4byWXvpYmxp9uMHXvrjiDJDVHslwN8oeugp/G8oOuLrQB6nBOFNCAvJC4dvMUb129ZrAHijdj/sIw+aXFlMESFcZAxn4LIURuAv5Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qSqkbLQX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso61364525e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 May 2025 06:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746624508; x=1747229308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/xS6ETeJO5OOeAvcPqqiLsohwdJ2YixHGZA6tkjlU0Q=;
        b=qSqkbLQXOLHXRxpof2oo2bp2TThJJlzrPTOJSKiru91QD5kl93KaW6azcZZ46jEx0e
         5BQD7GNHeeDt09Gabgv94zwyZOPWT1JyYA1IVD6c1cHfaHw7XNqZSE1MN9lYSUlftBzT
         5TKd3G+bLZEi+DFazrNn697sbxynlTEfuLVeZENqflsLU8IgQCQqZmR1W+j9Z7bdD2Cd
         TcOvJ0Qp0bbggwa/Zd0GMb2dk5PfVpCwfo6Bov7/evkzmtKSXe3SGDCRFOoS+TySgx25
         5ThKqs7tjMRH6WMIURaMKb+xiTInUJdGWmS084Mx9tz0XBQWQ0IkevIEoe84oM+W9Pnh
         pgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746624508; x=1747229308;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xS6ETeJO5OOeAvcPqqiLsohwdJ2YixHGZA6tkjlU0Q=;
        b=I7rYn7XMTTQnybIgAlmV2gEgea+eHfhJ2iB9vjJabXthVjZJW1VZp0WellRbZ1763k
         +6AxFOE5HBqFPHxBBBbHToN/faWs1OV52MyFI1mTG0Kvx87Mors/nUx8UUFis4JixULv
         jqcq9ulN6++yxE6tWYs46308zgfDgh+FtNCjjSB61tUQBCbJOSgGZ4p0pVxN64sVBEt9
         A97B3OFJsPNHNtcQbl+xwfjDvLKQXO11GBnWE8ebgJlkajAhKY5mqUjRL+dydt2ZEVuX
         7ambwSrjSFAhiQBcG/69hHi1o8FDPrDyIhnbOZcnpJW6/He0xToyA8HmOnlgO8It9IAZ
         obrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4rsZtTXXzggBvtTnl3BPSj5sdLpYm0luRRC8TmwHWlkkdsv9jhEV3HseXtrcJ9GrdR7chUqfHnYGtkT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNiUBdJWdhdNyQ+RxrN2MPtPIm12d7SJFLnR1aMC7KGqkUQ8Nt
	yMxO6jiTOaNc5RqDXPwYcC6S3MX5rwd04QS8pd6VJoqdZQiMqme0LYDOsJNNqmI=
X-Gm-Gg: ASbGncvVKiXsxJ64yzPFj1jUp8FTb/QkjbeU8HI4gAn/fL3nv4HyHKKdw48SptFMFYh
	+kqpGUKkcYKv/yMbAKc1Cu5iMbjJmVNUSASUkJi5nGgI69xEkXzXcx9NBrUE3fwhz+Etfdmn+Xk
	uMeRg3zl2eqesC5kqRQWpLbw21BkFlH5UAx7lnE6/Mk1ZDa5LOILNj3OYYol2IVACRkYuGtf+3J
	MXO1bOeeKlQu5r+4Dv5r8h5OjUYGEmC4KpTFbL7ILLHTBO5U1xWDaobbu9t/8GrpeqgpOquaLRn
	egsqWBjCHFXHb0Qn/B/jZ1PBJqN7a8Qsv4OkoL6JwdDOEHLqWAIW3q+rRdiZDFn7lvvJYXXbHrZ
	uayqaCrcii301jimMQW5uvC0=
X-Google-Smtp-Source: AGHT+IF9bN7HF5C+wDfG9X0dS/E0vyZNUnflXtn/dJ+qoLVi6CW6CxKO2dfUEyTuyw8A+h4DJSAqyA==
X-Received: by 2002:a05:600c:1ca3:b0:43d:2230:300f with SMTP id 5b1f17b1804b1-441d44734e6mr28815835e9.0.1746624507957;
        Wed, 07 May 2025 06:28:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e50:3860:705c:8900:5dbf:b4ab? ([2a01:e0a:e50:3860:705c:8900:5dbf:b4ab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd33103dsm1051115e9.10.2025.05.07.06.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 06:28:27 -0700 (PDT)
Message-ID: <b1949ec7-a0b3-4c4c-a439-93afced7bb0c@baylibre.com>
Date: Wed, 7 May 2025 15:28:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Guillaume La Roque <glaroque@baylibre.com>
Subject: Re: [PATCH] arm64: Kconfig.platforms: remove useless select for
 ARCH_K3
To: Nishanth Menon <nm@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Davis <afd@ti.com>, vishalm@ti.com, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250504-kconfig-v1-1-ab0216f4fa98@baylibre.com>
 <20250505123615.yqzdv7dlel7kyojf@degrease>
 <fa33b7d6-8e28-40bc-9219-41dab643e88f@baylibre.com>
Content-Language: en-US, fr
In-Reply-To: <fa33b7d6-8e28-40bc-9219-41dab643e88f@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Nishanth,

if i remove MAILBOX it's  enabled by some  non TI drivers and/or 
ARCH_XXX which have it in deps so all TI drivers are still enabled 
properly but not sure it's safe.
and PM_GENERIC_DOMAINS look OK to remove it.

if i try a defconfig based on android defconfig (more simple than 
default defconfig) with only ARCH_K3 enabled i need to set 
CONFIG_MAILBOX flag to still have same TI drivers enabled.
let me know what you want to do.

Guillaume
Le 05/05/2025 à 15:15, Guillaume La Roque a écrit :
> Hi,
>
> Le 05/05/2025 à 14:36, Nishanth Menon a écrit :
>> On 13:24-20250504, Guillaume La Roque wrote:
>>> After patch done on TI_MESSAGE_MANAGER[1] and TI_SCI_PROTOCOL[2] driver
>>> select on ARCH_K3 are not needed anymore.
>>>
>>> Remove it and give possibility to enable this driver in modules.
>>>
>>> [1] https://lore.kernel.org/all/20180828005311.8529-1-nm@ti.com/
>>> [2] 
>>> https://lore.kernel.org/all/20250220-ti-firmware-v2-1-ff26883c6ce9@baylibre.com/
>>>
>>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>>> ---
>>>   arch/arm64/Kconfig.platforms | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/Kconfig.platforms 
>>> b/arch/arm64/Kconfig.platforms
>>> index 8b76821f190f..5b63a42c4dff 100644
>>> --- a/arch/arm64/Kconfig.platforms
>>> +++ b/arch/arm64/Kconfig.platforms
>>> @@ -138,8 +138,6 @@ config ARCH_K3
>>>       select PM_GENERIC_DOMAINS if PM
>>>       select MAILBOX
>>>       select SOC_TI
>>> -    select TI_MESSAGE_MANAGER
>>> -    select TI_SCI_PROTOCOL
>>>       select TI_K3_SOCINFO
>>>       help
>>>         This enables support for Texas Instruments' K3 multicore SoC
>>>
>> While at this, is it possible to remove MAILBOX and PM_GENERIC_DOMAINS
>> from select and make them as modules?
>>
> good point i will confirm  and come back to you.

