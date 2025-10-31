Return-Path: <linux-kernel+bounces-880116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC54AC24EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2173B6A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77506345726;
	Fri, 31 Oct 2025 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwzKI244"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E753A34403D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912428; cv=none; b=Hcv0/uBC3YsyUoNAu0A1YeqiV9lXftuLIfadBBhW1TbZQTE5pzxSPBjXaNjvxqTTqE4vw7SAL42HkNYjMNlEq0VZjiBx56ekks07EbTBYJb6/duu7wHte42l/JmQmogeH8BN6r5S1I4KHDJXaZ4KTp1v3WdqRZuV0+k1FyvoC4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912428; c=relaxed/simple;
	bh=QdfcKgydSkRm0A8GQzQXVINVhev5YokC6RzzW3M0ueA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SY7yhJHKD+jh5JeqSplQMKBtwIu9GUocUHseaFj8BrPqiI0RtA+V9ont+82w8d3hVovpp8GVWnlmpbNdpjc5XfzbSFjriMZCHe+QgUs6Z0EvdyVOW6XXKfHmxNRKjesnDxKFoWsfTvuirQMnE3ZEpxuNUSi6ijA36bPcJngHvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwzKI244; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-378d65d8184so27640791fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761912425; x=1762517225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+wNT7KW8FpybzoaA+6FfZ6C32T5hx5xiEfdag3k3wE=;
        b=KwzKI2443RijErWYu4cl00L0syz5MC2rHdkgSLEWH4DPGUMs0ccrLqzJ0S5ruQAex1
         sMvDS7t3GnTjq3FpHst5tKk5JTDawJJIPblNPxRnK+ds/vI5ck30DDKxb2IHFX7KkYbS
         Mhgy/48fpaLpHxhfYIvka6+o/y7PNv6zHoBNGHG+NOO7fG15RloVXaqAGzoVSA/aNneU
         G40DQYhXV4fD3d2KR7gzhoEVDiqFSaiq5SGiz4JNtMGRGvCefgw2sgXgaExiUXEyL7Sl
         ZiwRJcuB3FMUzBV+NHsA1ecR1Q635sD8qm6qr4Rk/VSyax4pDeSGsS9DMu/s0vCpfL51
         L48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761912425; x=1762517225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+wNT7KW8FpybzoaA+6FfZ6C32T5hx5xiEfdag3k3wE=;
        b=UZKra8tmZodeUSvz5Jh7MGbR34hwtD7JvdchAXy/xyVYc5sZ5jaAel/WmkGxoLGBid
         tlUFGFKZvh+H3vKa2g7UgZISLkn0F3EnDVQRC/nvAs4rCVcl53qAZWaruxVg2oGcJS3A
         0xnI4u2upGUQ8diCOVzQKcVtQydckhmwncpwGwMYd4aY4U/4tk6Xfnf1Z0bBfke50v8M
         lTIz5PEvKssXR19cvwJfC0BaFdnEOhX6gMLMWWukPGJPv2d8Ikx3JsdbKjAZHTIpER+R
         D0qX98hmkvzNpHR5LbPse57+g0h2o5rIfdFezRvZeMKFbTUSo5B/pcclbFs5oz88YuHi
         hOWA==
X-Forwarded-Encrypted: i=1; AJvYcCUn4rq94MyVb6iq0COJNgRWh8R+fIJm1qOqqhWmkncGZ+u7JyU6vwo8mEgTYYAEVDSBH1k71vSNEyt+04w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3VVZ/dFMVLpGLn/uWmDqXbBTj6yFlK3oOyLtoax/A/ZH3rcF+
	3adeu3hE+fBpdXghBgpax9tOUJyRVGA1dI0/zj5wU6Wxqp42J5dhTWn/6oTol3uW
X-Gm-Gg: ASbGnct/g19y4UXGfPGthWFkisIKEvuNOpG0Rn44X9RotMB9Ye4KsTq8+x00fTRzBXI
	tH/9fK6vGWDSQo4URko+XRheN/COD1cMtQxZHh7d48rQpYYty2Q/GhYh4Jdo/FiznPsHypJeN58
	R2V+BF5Zdby7r9gyzPGZbEv0hipXtl3P2blKLN7eab0DJJdsVCIzOq6AZvhLkNW+EEOmIqY20vU
	hIVN0ue9F80i/loxAqHBPia91/Aq9mHovMkuVPw+CR0AzxRrG2fJKGhpsevyIcvEoz9Lrjx9cvI
	tovTYDSVNwAfd0FqpzWmD2VW85kHqwyZCESFybXJcKQI55BxiMfY4/TDvggXTvWEk00KW08qiDh
	XelGZVlPXuO6j8w6KSQvMPAZo7NXlHqnZbO6hnk168wuUm3VFO4qNzk1IriYlCU2XMD4fMYyXG2
	YerdEdLU0akHS0btuXMhAxzibRZ+oxjKYpTtg4rC8SxBfVyde9MUDqVcPsN5r7fUJCVZHP
X-Google-Smtp-Source: AGHT+IH/ICNj/bMV5RVGbwRdK/Ejd2emYkz7dh/g7c7spskiA/UNWUDs1dQqtabTPzVdNpWwUCQDtw==
X-Received: by 2002:a2e:8689:0:b0:36a:925e:cf3c with SMTP id 38308e7fff4ca-37a18dc7311mr10659721fa.31.1761912424618;
        Fri, 31 Oct 2025 05:07:04 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a1bfb3e70sm3216571fa.12.2025.10.31.05.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 05:07:03 -0700 (PDT)
Message-ID: <0beeacba-c484-43c0-80fb-66b2e0293681@gmail.com>
Date: Fri, 31 Oct 2025 14:07:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: freescale: add Ka-Ro Electronics
 tx8m-1610 COM
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: Maud Spierings <maudspierings@gocontroll.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
 <26fc62bb-3484-4812-b576-6640eef72c49@gmail.com>
 <20251030130006.0221957a@karo-electronics.de>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20251030130006.0221957a@karo-electronics.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/10/2025 14:00, Lothar Waßmann wrote:
> Hi,
> 
> On Thu, 30 Oct 2025 13:01:52 +0200 Matti Vaittinen wrote:
>> On 30/10/2025 10:54, Lothar Waßmann wrote:
>>> Hi,
>>>
>>> On Wed, 29 Oct 2025 16:35:25 +0100 Maud Spierings wrote:
>>>> Hi Matti,
>>>>
>>>> On 10/29/25 11:05, Matti Vaittinen wrote:
>>>>> On 29/10/2025 11:48, Lothar Waßmann wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Wed, 29 Oct 2025 10:42:17 +0200 Matti Vaittinen wrote:
>>>>>>> On 29/10/2025 09:11, Lothar Waßmann wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On Tue, 28 Oct 2025 14:10:04 +0100 Maud Spierings wrote:
>>>>>>>>> On 10/28/25 13:42, Maud Spierings wrote:
>>>>>>>>>> On 10/28/25 13:15, Matti Vaittinen wrote:
>>>>>>>> [...]
>>>>>>>>>>> Could/Should this be described using the:
>>>>>>>>>>> 'rohm,feedback-pull-up-r1-ohms' and
>>>>>>>>>>> 'rohm,feedback-pull-up-r2-ohms'? If I understand the comment
>>>>>>>>>>> correctly, that might allow the driver to be able to use correctly
>>>>>>>>>>> scaled voltages.
>>>>>>>>>>>
>>>>>>>>>>> https://elixir.bootlin.com/linux/v6.18-rc1/source/Documentation/
>>>>>>>>>>> devicetree/bindings/regulator/rohm,bd71837-regulator.yaml#L108
>>>>>>>>>>   
>>
>> // snip
>>
>>>>>>>
>>>>>>> If real voltages aren't matching what is calculated by the driver, then
>>>>>>> the voltages requested by regulator consumers will cause wrong voltages
>>>>>>> to be applied. Debug interfaces will also show wrong voltages, and the
>>>>>>> safety limits set in the device-tree will not be really respected.
>>>>>>>
>>>>>>> I think this would be well worth fixing.
>>>>>>>      
>>>>>> Before doing the real-life test I did the same calculation that's done
>>>>>> in the driver to be sure that it will generate the correct values:
>>>>>> bc 1.07.1
>>>>>> Copyright 1991-1994, 1997, 1998, 2000, 2004, 2006, 2008, 2012-2017
>>>>>> Free Software Foundation, Inc.
>>>>>> This is free software with ABSOLUTELY NO WARRANTY.
>>>>>> For details type `warranty'.
>>>>>> fb_uv=0
>>>>>> r1=2200
>>>>>> r2=499
>>>>>> min=800000
>>>>>> step=10000
>>>>>> # default voltage without divider
>>>>>> min+30*step
>>>>>> 1100000
>>>>>> min=min-(fb_uv-min)*r2/r1
>>>>>> step=step*(r1+r2)/r1
>>>>>> min
>>>>>> 981454
>>>>>> step
>>>>>> 12268
>>>>>> # default voltage with divider
>>>>>> min+30*step
>>>>>> 1349494
>>>>>>
>>>>>> Probably we need to use this value rather than the nominal 135000 as
>>>>>> the target voltage in the DTB.
>>>>>
>>>>> Yes. When the driver calculates the voltages which match the actual
>>>>> voltages, then you should also use the actual voltages in the device-tree.
>>>>>       
>>>>   
>>
>> // snip
>>
>>>>
>>>> Then setting 1349494 as the actual voltage makes it fully work.
>>>> Otherwise it complains:
>>>> buck6: failed to apply 1350000-1350000uV constraint: -EINVAL
>>>>
>>>> Final debug output now:
>>>> [    0.327807] rohm-bd718x7 0-004b: buck6: old range min 800000, step 10000
>>>> [    0.327813] rohm-bd718x7 0-004b: new range min 981454, step 12268
>>>> [    0.327819] rohm-bd718x7 0-004b: regulator 'buck6' has FB pull-up
>>>> configured
>>>>
>>>> I will add this fix to the next version of this patchset and include
>>>> your requested change in the dts.
>>>>   
>>> Does it also work with min/max settings in the DTS that are taken from
>>> the designated value +/- 5% tolerance margin, so that the DTS contains
>>> reasonable values determined by the HW requirements, rather than some
>>> artificial number that is enforced by the SW behaviour?
>>
>> I am unsure what you mean by "artificial number that is enforced by the
>> SW behaviour"?
>>
> The nominal voltage that is required by the consumer is 1.35 V. That's
> the voltage I would expect to set as target for the regulator.
> If that voltage cannot be achieved exactly, I would prefer to have the
> intended voltage listed explicitly rather than listing a value that
> accidentally can be achieved by the regulator but has nothing to do with
> the requirements of the consumer.

Ah. Thanks for the explanation. I get it now - sorry for the noise.

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

