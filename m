Return-Path: <linux-kernel+bounces-878065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FAFC1FB04
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36B714E598C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F742C2340;
	Thu, 30 Oct 2025 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWKjYhS1"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A9253F07
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822119; cv=none; b=tzCuXlGkFNAJhG7yW52EIWxuZ+I3KOJK3B33d+YUOu1EaxNFxsz5Q0yCka0zeNHTVgn3oFbLfmYLbxnuTJr4QIoBDuCOD919ztHb8i/DrfU9PCn1U/Vesgro+am5ZXgtPsV3gYDgKw2V3Hf/FX4EgHqid1jWsjHoilgs4UEQCC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822119; c=relaxed/simple;
	bh=1DV21IpadLbe4eYTaHnc0P1T2OopeHa/ssPOoqFQHNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNe4qkgkimjXX+DJhfbFuAeOFKk5z0HC7SJPlIRxl7mLQpFsc74OzwWcOGgALnrBVaZLVrnFuCOZvEpa3KZ/zG/OAewc+NhUdOiVaXRAxCRnbGf8T+7imMllqmCjFcQxgX0t6mdTi5J8w8gZxekaycDbSmh8sREr9IwlLvyW1aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWKjYhS1; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59052926cf9so1034180e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761822115; x=1762426915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b8MLj8j7e7YQRcZlE+KIJJ5vGAzqn6SgU3Y1AxaodS0=;
        b=GWKjYhS1UhxWQ8UYou5cBCS4hjISnY4+5oaBF2ExYijn9JaY1ctYEUSmjnmnYDehnb
         wrPuPRPNit9G4DhO12D+2+GPeLgVkFzUZKEewJL4q8SCwHxUWyhXNl7aDdBBqxEItqfE
         q1hhkC/9MXF+1xuKRv57wDjmJW6VpL6IDem0gBNUzMdDJzGiZelI1la8T6Ndj3xaTfmr
         +aS3FDPh+tE7+QbqkCHcxU0DD7pBotefquGY0Zvhs/OjXSiogQvP8kExwRmVYvB6q3/t
         l6C9n680sA9iBzz8mrnZhu3qMCQu+cZvFapxMFd3HxRmdo/i0ra0dgzdReQOyx1cBTFs
         ZdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761822115; x=1762426915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8MLj8j7e7YQRcZlE+KIJJ5vGAzqn6SgU3Y1AxaodS0=;
        b=g1jitAaa3J/P4ChrMYOIsiUsnPHqo59eK5tR+atAvN9BTwDpLAcvxvjk/UgCDr36hi
         jugM6lnLaYBmWfVowOfCgS05eDvzQqR8+Z3Ck5NAhJl2qDvCsWpp/cNyXPyg0Bht+f1I
         NOiXmYYJpQ+O29UsjUrpC5IoBU7h7KP1nSp4D1D633Vu/SZV+0S1RbdQ+YjElU8z6qTY
         MxIkswv7w703Bs3WZVTUh32kV81XNp2WlpV45KYMZBitxePsRc0OThqirZnIz/yAfCwG
         e37Ol3SFT3ZyCoJdiCP8QRZoEg6spp29WE6OLObR7sGNOPeYPGvguhOLhglQP/XTq11F
         OtWw==
X-Forwarded-Encrypted: i=1; AJvYcCUYVA8GmTVbgWP0qF/tJiFDkhxVHHLwNCu6MGcKrxQphCaOTWEhGqGMdKgeybvMokxjDO8aVTh0EUuqgYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZF48xhY0wauf+11HKPgTbBFGX6NHEZVpu/Tg6fWSeQghmGn/D
	/cS64erLbGLMga+WjDkdR4s4Z4oLVOPWlwvlltEQ6ng36Gnni02OARNg
X-Gm-Gg: ASbGncvz4aTnynYmD0fr3MPEQCjLMbDCR8zBzpI/Smn6fKz3dh3vA4m6g1EYxCp1utr
	TmB7pXKSgVYlSnJUpg+nKq1iqOLi7FvdaUoiLtYymWwSyJAEtBgSvh/UrYYMoK7D0Wt/50C0rOt
	45aWKO+mXcwr3Dum2f6eQOZInmXhJqVGWarLzPqozh2EgHN1qvJk6aO/VKTE73ZK7vW8CUOrEgk
	uQHvsk0uRBBPjNfyK0qwR8TrlEKr2tB5zDNycnFG9+f2UhvhNR67qu/DNxzqoPrgUwc23iHqY0O
	/HnKwaE0L7w07xWlgcRxQv7gEovj5wih6HZ7JfQAVc0OEID6lcE6DCkezTALUKkdv+6eEa4Bhjo
	1nFRr1RWMAPu7wHZ+LxuxHpSJytH9D7sfxf394WkKlFABHtL5COHMBINnZla4/3Q2SzhoReGmdG
	96VIHZ77PJ7qB6tK0xFzm+UN1PrPGBrPZ7bCE3vUJikZBfuqr/VyRIW0aFIQ==
X-Google-Smtp-Source: AGHT+IFVbeOcG1ymZvuui/950bfgz6qYiN2j/R5NM5+LVOvsYbyPSuDJ4V+PPpYZdgVHGMjGt2TR7Q==
X-Received: by 2002:a05:6512:4007:b0:585:5cb5:590 with SMTP id 2adb3069b0e04-59412a3654amr2238284e87.11.1761822113991;
        Thu, 30 Oct 2025 04:01:53 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f68e9fsm4592248e87.71.2025.10.30.04.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 04:01:53 -0700 (PDT)
Message-ID: <26fc62bb-3484-4812-b576-6640eef72c49@gmail.com>
Date: Thu, 30 Oct 2025 13:01:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: freescale: add Ka-Ro Electronics
 tx8m-1610 COM
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>,
 Maud Spierings <maudspierings@gocontroll.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20251022-mini_iv-v2-0-20af8f9aac14@gocontroll.com>
 <20251022-mini_iv-v2-3-20af8f9aac14@gocontroll.com>
 <a7012995-c2a8-48a3-abe1-5c227272f21c@gmail.com>
 <65202d1f-6c4f-4d4e-9fef-85cfb74ec768@gocontroll.com>
 <938f85b0-4c9b-463a-960a-f5f4e4092480@gocontroll.com>
 <20251029081138.2161a92a@karo-electronics.de>
 <4a47b9b5-f482-41b6-a441-7728572c5a0c@gmail.com>
 <20251029104838.44c5adcf@karo-electronics.de>
 <d05c62c9-7ed7-46e4-aa4d-27172741b5ee@gmail.com>
 <0667e026-99f3-4233-b3f6-e38273961d49@gocontroll.com>
 <20251030095434.1dc06df2@karo-electronics.de>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20251030095434.1dc06df2@karo-electronics.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/10/2025 10:54, Lothar Waßmann wrote:
> Hi,
> 
> On Wed, 29 Oct 2025 16:35:25 +0100 Maud Spierings wrote:
>> Hi Matti,
>>
>> On 10/29/25 11:05, Matti Vaittinen wrote:
>>> On 29/10/2025 11:48, Lothar Waßmann wrote:
>>>> Hi,
>>>>
>>>> On Wed, 29 Oct 2025 10:42:17 +0200 Matti Vaittinen wrote:
>>>>> On 29/10/2025 09:11, Lothar Waßmann wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Tue, 28 Oct 2025 14:10:04 +0100 Maud Spierings wrote:
>>>>>>> On 10/28/25 13:42, Maud Spierings wrote:
>>>>>>>> On 10/28/25 13:15, Matti Vaittinen wrote:
>>>>>> [...]
>>>>>>>>> Could/Should this be described using the:
>>>>>>>>> 'rohm,feedback-pull-up-r1-ohms' and
>>>>>>>>> 'rohm,feedback-pull-up-r2-ohms'? If I understand the comment
>>>>>>>>> correctly, that might allow the driver to be able to use correctly
>>>>>>>>> scaled voltages.
>>>>>>>>>
>>>>>>>>> https://elixir.bootlin.com/linux/v6.18-rc1/source/Documentation/
>>>>>>>>> devicetree/bindings/regulator/rohm,bd71837-regulator.yaml#L108
>>>>>>>>

// snip

>>>>>
>>>>> If real voltages aren't matching what is calculated by the driver, then
>>>>> the voltages requested by regulator consumers will cause wrong voltages
>>>>> to be applied. Debug interfaces will also show wrong voltages, and the
>>>>> safety limits set in the device-tree will not be really respected.
>>>>>
>>>>> I think this would be well worth fixing.
>>>>>   
>>>> Before doing the real-life test I did the same calculation that's done
>>>> in the driver to be sure that it will generate the correct values:
>>>> bc 1.07.1
>>>> Copyright 1991-1994, 1997, 1998, 2000, 2004, 2006, 2008, 2012-2017
>>>> Free Software Foundation, Inc.
>>>> This is free software with ABSOLUTELY NO WARRANTY.
>>>> For details type `warranty'.
>>>> fb_uv=0
>>>> r1=2200
>>>> r2=499
>>>> min=800000
>>>> step=10000
>>>> # default voltage without divider
>>>> min+30*step
>>>> 1100000
>>>> min=min-(fb_uv-min)*r2/r1
>>>> step=step*(r1+r2)/r1
>>>> min
>>>> 981454
>>>> step
>>>> 12268
>>>> # default voltage with divider
>>>> min+30*step
>>>> 1349494
>>>>
>>>> Probably we need to use this value rather than the nominal 135000 as
>>>> the target voltage in the DTB.
>>>
>>> Yes. When the driver calculates the voltages which match the actual
>>> voltages, then you should also use the actual voltages in the device-tree.
>>>    
>>

// snip

>>
>> Then setting 1349494 as the actual voltage makes it fully work.
>> Otherwise it complains:
>> buck6: failed to apply 1350000-1350000uV constraint: -EINVAL
>>
>> Final debug output now:
>> [    0.327807] rohm-bd718x7 0-004b: buck6: old range min 800000, step 10000
>> [    0.327813] rohm-bd718x7 0-004b: new range min 981454, step 12268
>> [    0.327819] rohm-bd718x7 0-004b: regulator 'buck6' has FB pull-up
>> configured
>>
>> I will add this fix to the next version of this patchset and include
>> your requested change in the dts.
>>
> Does it also work with min/max settings in the DTS that are taken from
> the designated value +/- 5% tolerance margin, so that the DTS contains
> reasonable values determined by the HW requirements, rather than some
> artificial number that is enforced by the SW behaviour?

I am unsure what you mean by "artificial number that is enforced by the 
SW behaviour"?

As far as I understand, the PMIC operation is altered by modifying the 
feedback-pin voltage, right? So, the HW _really_ outputs something else 
but the 'PMIC nominal voltage'? When this hardware connection to the 
feedback-pin is done, the nominal voltage is never really seen anywhere 
else but the PMIC data-sheet, right?

> E.g.:
> 	regulator-min-microvolts = <(135000 - 6750)>;
> 	regulator-min-microvolts = <(135000 + 6750)>;
> Thus, the nominal value of the voltage is explicitly shown in the DTS
> file.

I don't know why there should be two different min values? Assuming the 
latter should be max - I have no problem seeing a range of allowed 
voltages in constrains - if the hardware can tolerate voltages within 
the range.

In my opinion, the values used should however reflect the _actual_ 
output voltage, taking the effect of the feedback-pin modification into 
account. This is also what using the:
'rohm,feedback-pull-up-r1-ohms'
'rohm,feedback-pull-up-r2-ohms'
and the pull-up voltage property allows one to use.

In general, regulator consumers expect to get the _actual_ voltage the 
regulator outputs, via regulator APIs. Think for example of an ADC 
getting reference voltage from a regulator. If it asks for used voltage 
and gets 1350000uV from the regulator subsystem it will use that to 
calculate the scale. If voltage really is something else, altered by a 
feedback-pin connection, the ADC will be having offset. I don't know if 
voltages reported by the framework matter in your specific use-case - 
but it doesn't mean letting the regulator subsystem use bogus voltages 
is right.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

