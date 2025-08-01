Return-Path: <linux-kernel+bounces-753079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1910B17E62
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B85565006
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC7B211A35;
	Fri,  1 Aug 2025 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yN93m34G"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171FA1F3D54
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037309; cv=none; b=txggQPZQfUAS5vCTO21NkmGJuGncS/HOO6Ovz49T18Au7F1idcMQtiN1TXcC8ZIiffzRsbCZzzxFKBMZB33sVtl/UDesSZAcrIqv6R2yODzqsboZOIrLOQA2IjyizkpUQiQdgWEZk8+TcDQL/jACafXx8YxfinLX8jaLysYdndQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037309; c=relaxed/simple;
	bh=FqOy+mMo2rR0EN6LQz9aSmLP9UV6EGx2ngQ1VQrZuL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQPfkWKsx74Brb8lBt82ps4Z3wsuYSnQZ2qykSdEwZnvXTna2gvnVOFB9tc3mbKX3syJ6wz5916vHb49CA0VKN4lQe3gfDNsbu+f202Q/xG289ZMyPPciA8h8aspFypH4KjEcRkvOlGn2mEoPd+VewNmJdqwEHYOMMIZhn4hpD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yN93m34G; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b788feab29so809197f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 01:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754037306; x=1754642106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jiFqr0OPCqHVXSpWzCqecK/S1S4l0jHxVTGQ1xBrzUE=;
        b=yN93m34G00mdZcGkmDfnWBPdYnktFU30yHCmG8IptjaCrlfoB2/nDC+x3DeWlpX6xI
         acbvszas8Wm6f0f2PPk+KfDwd6lI5pH3mlMMZ3MkLhaCRV7XtDubi2f37RKu60A/v4hL
         SKlAaJEPEghJJzTgiXZlWC6BqhoWq8EIQpijiRSmMjJcauGZf0UEwLEgMgGqz0QtoPIO
         SHjCpTmtHbQauthU1I64v5d1mHDh1jcnyHyHt+gwFyKr7KvVj5tkeARwYEo3n2N+ClUr
         kQ9MJv7XzWP0XOKmZz8wPCVebTseV/RcC5BvqlQNY3TIsAvxI+oWb5sgFv1wssQSWbc4
         R8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754037306; x=1754642106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jiFqr0OPCqHVXSpWzCqecK/S1S4l0jHxVTGQ1xBrzUE=;
        b=Vo+FoukxbTkWCTxLkemacBt8oS+MWEqo0CDUBpw+i4UmDiYrD4vnamXGaq3rx+DmES
         PN2RqPMvj4RSD76ls3hhck353BunD6I/nsVlIbSuYW8IruF9IV4Hd3GXuxUDTWTyhorT
         WwIyp0wmCMtfLrmqyvh9rwC+HpMYCGr2fyzLnLbv5J5bceMlIEUm73pMRTb046aH4qHh
         9bgHCDKTbek1/4kuFzMJ/2qjA+HWHUl/l46dkmeopXeOs4TTRK/43d1JeeBpXBXLtxcS
         L7QGB8nWte7gaWk06PtFRW/+Z5EJ091tgKukaU84KMJj8UbHWQPdCc18+2HwNM1tss4K
         NkmA==
X-Forwarded-Encrypted: i=1; AJvYcCXCEv8WeuOvmB2r8ZZylFGIhv12jC6pd8d0fvU0dSCgI4lx8iVIT1Zz5P84av7W2+Lf4mruTr2gT7O9UJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcunjqLsc5abfREtHkGaYn1eaHm7S5Fx35QoKxr4b7SR22IPx8
	izvLeh2hYLu5bydF6Lt1hcIuqyRbb7nP1S54RFQEl5UPmpqTSr1b8AMhM+KFeQPvLLo=
X-Gm-Gg: ASbGnct9WAlEEauesOMgTW/9VhaIJ0dw+/9SYcwzg2u2ClqzX4xKYEV/Z8O0ZFGxlyq
	8r1qW2GUuianSFMsK4Qpgpe3mz95cLo8sKHFnqvLfbMzv6E1nUuU9Ivt7SDh7HM1Ob3R4TFmc2q
	ee5vN9eV/tsQKCTWpY3WmI4GjK9TJ0ObShp3zPvIjmgvGWWWMQkQf6gt8MSqNN3x8qow2IDzQH5
	FODvt+hNf3BQHj9b6v7cHEd6mKXM04wELVdh+ULWXp+ekHsZe4nOEG/Wlj7TrVipPZOva0c1l+r
	hy6OV4bdNfy/pUIx7xruqig1eKqsOtv3PLT1nXe4Ngh+v5SicELRapGBRljmxqvyz9g7TyWSVBH
	VDyTfrzt+eYgDmLHfJBWi1jpOKXMD9iXqoW25oWP3bKKUJi52cKbiC8ICq3LELA==
X-Google-Smtp-Source: AGHT+IGS+73xkShFl6cO1Qu7hyyuX9oTyEOMrN6GMT2KH3N0L9G6LCMIuM6NsKe0gCwLrUaUqn7Ybg==
X-Received: by 2002:a05:6000:2884:b0:3b7:99cb:16ed with SMTP id ffacd0b85a97d-3b799cb1a28mr6844043f8f.40.1754037306324;
        Fri, 01 Aug 2025 01:35:06 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458953f8e02sm92820875e9.32.2025.08.01.01.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 01:35:05 -0700 (PDT)
Message-ID: <164402ad-2762-4d6b-aa34-38ff1b506600@linaro.org>
Date: Fri, 1 Aug 2025 10:35:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] arm64: dts: s32g2: Add the STM description
To: Frank Li <Frank.li@nxp.com>
Cc: mbrugger@suse.com, chester62515@gmail.com,
 ghennadi.procopciuc@oss.nxp.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, s32@nxp.com, kernel@pengutronix.de,
 festevam@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Thomas Fossati <thomas.fossati@linaro.org>
References: <20250730195022.449894-1-daniel.lezcano@linaro.org>
 <20250730195022.449894-2-daniel.lezcano@linaro.org>
 <aIp+XTCSpNGee2qx@lizhi-Precision-Tower-5810>
 <5be6d858-01e1-4c2d-bd5c-0e3385251af7@linaro.org>
 <aIv6L30mf5bzUqup@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aIv6L30mf5bzUqup@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/08/2025 01:20, Frank Li wrote:
> On Wed, Jul 30, 2025 at 11:15:40PM +0200, Daniel Lezcano wrote:

[ ... ]

>>>> +			compatible = "nxp,s32g2-stm";
>>>> +			reg = <0x4011c000 0x3000>;
>>>> +			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>>>> +			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
>>>> +			clock-names = "counter", "module", "register";
>>>> +			status = "disabled";
>>>
>>> why not default enable.
>>
>> The S32G2 and S32G3 can have different variants with 2, 4, 8 Cortex-A53 and
>> 3 or 4 Cortex-M7. We enable the same number of CPUs present on the system.
>>
>> AFAIU:
>> 	S32G233A : 2 x Cortex-A53
>> 	S32G274A : 4 x Cortex-A53
>>
>> 	S32G399A : 8 x Cortex-A53
>> 	S32G379A : 4 x Cortex-A53
>>
>> Otherwise we would have to do the opposite, that is disable the unused ones
>> in the s32g274a-rdb2.dts, s32g399a-rdb3.dts and other dts which include the
>> s32g2.dtsi and s32g3.dtsi.
>>
> 
> That's fine by default disabled. but what's impact if it is enable but no
> one use it?

At the first glance I would say we call the probe function for nothing, 
so adding an extra overhead. When repeated into multiple drivers that 
increases the boot time significantly. It is certainly a good practice 
as a rule of thumb to enable only the ones we really need.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

