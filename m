Return-Path: <linux-kernel+bounces-882750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 602F5C2B51E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B73FA3412DA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED38302141;
	Mon,  3 Nov 2025 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4g6jvJJ"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212B43019B8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169223; cv=none; b=gYcUJNbxsreQ7OE5GlgkGUhVYcJRV5Y8OhgN63j+pTwi8utvPdqgwf883G2lxcA6d9kAEYTETRR3Qyzm082beILPinHDuJB4dm48x8NKBGj+qP0Nctwd/cusQHAplP+foocqE+swAWLrQxz5VZKrQn1J+IoKT892q7iXEpQioOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169223; c=relaxed/simple;
	bh=lGE7Ybu/RDSIulxrNCxHK7fYM0+Qcge2/3uQRKIybAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6pePIqtxVjYkBM1/r4vq/DPX+GxktSaLeRVVYAApaK55aDSwGI3UqcGsIAru6sO11Eix971q2XwoqqqMCa1GuJY5btrSuIuF1JlEs2Wkb9sqahQmDTv3ywtW7krKCTdndDPmtky2oWSO1ukjUCZcZCqAtMPWWg64AZwZg1gET8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e4g6jvJJ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so4931261a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 03:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762169219; x=1762774019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qjmy8XjX+bzyGd/5u6oANywBcBczevKHZ7vCYGJEnxc=;
        b=e4g6jvJJclnb+Bh7nUITeQ9pEDiyXGS235zjqhzozRUfnn8CyyR5clYo7iuFiA6Cgk
         vKmVxhDeuS07H7ObjDJQEaYUd1oF+Lv0F9Yl2vM81WMw1TEInOXkmnhLnvGafPgVJ5nb
         bZrKAciwkJDRT0/rhD8eEmOxdDMszZe2dcu+KZw86aCWuuAfjxaKVSTV4mKxImYtsF+f
         dMOcC+7uzVqRujYWgTBrsoJuaSnKU8wIA1874aVaaAT4W7apTVEtyIUn33Fnp5expoC/
         /DoqUh2e9H/u/7g7dTrlKN8w9EJkLBVNv+9e4Q2Z0/fvi7xq7p0qPgzAi2zP63UGqE08
         g4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762169219; x=1762774019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qjmy8XjX+bzyGd/5u6oANywBcBczevKHZ7vCYGJEnxc=;
        b=IimWl+r93+n2qPI8sYBHx05tdQ9X9yWXB5H9MK/Uhev4nrxN4kpF5e01aQ/DlRz52T
         AlZ3az6x/r1VCdGVNMSkqTnDPmsF7JVVwbwfrEthI7LNS+EqIIHHq+UUFn1Rr655lM48
         tCPYowF1YdN+CbzCkGBNWVq5jHsrzyLbRz06DssHnmWkRYFt8g9VfvfqCbRoSYgK0IGg
         OQ9X9SPBfz6iYOrluaF5Q7NOXiXjUZQrctQH42Nc6wR0neJzx8s8U0TwydvAelOzvw+D
         2gWP50Uh1DxY0tQUPJ8eTJt7c9qfy9hCbXHilz8rLE4pWO77qPaoZo6n+H0Ri+tBQRNY
         Yobg==
X-Forwarded-Encrypted: i=1; AJvYcCUV23mp5qy206nlvO3zWNiUmsI+DndNUQBw8JUw4I+T0yL6HaW+qtYAobG7IE3zQH8bBplkJQjlWys62KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7YVb5vLPtQ7cFPxpLDfTqb0LwgVdHwRQm6jbudCzhxcEqQyHH
	/RO45cYbbd/KStZTC2RKbVccuGhR06wtEGhHZbF/Vb1FnHVJm/Xw3RGLBWYpaR1UfHo=
X-Gm-Gg: ASbGncsSZlx5Pa96+K+YXbFcGs6nr74Fb9GyGxyH7xSuBwo4mRZxWd7bWKXPrTvZf+l
	Xq30tdX8aL0l9dEd54gWaQAajkYL8aO6lZtcC2fXdexOs35A0Rcj/IqrWHQjSmPxM4Dl3CLgxvO
	V4g2UpugYVUjPVsa2XiG20tM6vCzVB61Naq62QkW1K8xilAUEZ+CuBVU/1zuXNNWlD4bCFpyv1P
	XLhZhF99uwRF022trSS+MngsscblRVggQ38z6IIyD+hrJKrRfV1xNaT5LuuYe3RWCJPZji3IexZ
	gsjsM0NRwkYdAIxZfjyDzbgjEtgSNAkldL1aDt/WAb10X1E6X9A/PUyXfNlsR9zYXmTSuz3rSAR
	NAX3NCwwgSLK5YirtSjlfEk6GZBAyCUM7ES1SuTw2jOMpm+9za6H7iadyFogbCWa4D1QUG95QLG
	eA9ew4ZeH4tHqdT9m9pVEj1KI=
X-Google-Smtp-Source: AGHT+IHivtvy/jRPu0I8Ces/TDhvBY7TVA9tDT88jLA028aX3ASpmqQ3KfJYVYM1rOEorR2QyolQYQ==
X-Received: by 2002:a05:6402:4402:b0:640:a26e:3d76 with SMTP id 4fb4d7f45d1cf-640a26e4208mr5484730a12.27.1762169219448;
        Mon, 03 Nov 2025 03:26:59 -0800 (PST)
Received: from [172.20.10.10] ([213.233.110.172])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640af968e5dsm4801329a12.19.2025.11.03.03.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 03:26:58 -0800 (PST)
Message-ID: <c5c81744-48a2-4f3f-9ac3-2420af7caaac@linaro.org>
Date: Mon, 3 Nov 2025 13:26:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] arm64: dts: exynos: gs101: add the chipid node
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 semen.protsenko@linaro.org, willmcvicker@google.com,
 kernel-team@android.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251031-gs101-chipid-v1-0-d78d1076b210@linaro.org>
 <20251031-gs101-chipid-v1-10-d78d1076b210@linaro.org>
 <20251103-pompous-lean-jerboa-c7b8ee@kuoka>
 <b82af744-ebbd-4dc8-8ccb-c7e4f2a6b04d@linaro.org>
 <abd5b16b-1467-449c-b452-7699cbe5d9f5@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <abd5b16b-1467-449c-b452-7699cbe5d9f5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/25 1:01 PM, Krzysztof Kozlowski wrote:
> On 03/11/2025 11:50, Tudor Ambarus wrote:
>>
>>
>> On 11/3/25 12:18 PM, Krzysztof Kozlowski wrote:
>>> On Fri, Oct 31, 2025 at 12:56:09PM +0000, Tudor Ambarus wrote:
>>>> Add the chipid node.
>>>>
>>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>>>> ---
>>>>  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>>>> index d06d1d05f36408137a8acd98e43d48ea7d4f4292..11622da2d46ff257b447a3dfdc98abdf29a45b9a 100644
>>>> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>>>> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
>>>> @@ -467,6 +467,12 @@ opp-2802000000 {
>>>>  		};
>>>>  	};
>>>>  
>>>> +	chipid {
>>>> +		compatible = "google,gs101-chipid";
>>>
>>> That's not a real device, sorry.
>>>
>>> I had some doubts when reading the bindings, then more when reading
>>> driver - like chipid probe() was basically empty, no single device
>>> access, except calling other kernel subsystem - and now here no single
>>> actual hardware resource, except reference to other node.
>>>
>>> Are you REALLY REALLY sure you have in your datasheet such device as
>>> chipid?
>>>
>>> It is damn basic question, which you should start with.
>>
>> Documentation says that  GS101 "includes a CHIPID block for the software
>> that sends and receives APB interface signals to and from the bus system.
>> The first address of the SFR region (0x1000_0000) contains the product ID."
>>
>> 0x1000_0000 is the base address of the OTP controller (OTP_CON_TOP).
>>
>> "CHIPID block" tells it's a device, no? But now I think it was just an
>> unfortunate datasheet description. Do you have an advice on how I shall
>> treat this next please? Maybe register to the soc interface directly from
>> the OTP controller driver?
>>
> 
> 
> Huh, then I am confused, because:
> 1. That's the same message as in other Exynos and it has SFR region
> 2. Your binding said there is no SFR region.
> 3. Anyway, please post complete DTS, so if this has SFR region it must
> have proper reg entry. You cannot skip it.
> 
> Of course next question would be what is the OTP controller...

The CHIPID block, which has a dedicated chapter and all :), consists of two
registers:

Product ID
Address = Base Address (0x1000_0000) + 0x0000, Reset Value = 0xE383_0000

Chipid 3
Address = Base Address (0x1000_0000) + 0x0010, Reset Value = 0x0000_0000

While the Product ID is fixed (fused I assume), the CHIPID registers:
"depend on the OTP value. When the power-on sequence progresses, the OTP
values are loaded to the registers. These registers can read the loaded
current OTP values."

OTP values are from the OTP memory (32Kbit) from address 5'b00000, 160 bits
in total. Even if not explicitly stated, I think the OTP controller copies
the CHIP ID from the OTP memory to its registers, so that the "CHIPID block"
can access them. You notice that the reset value of the CHIPID OTP registers
is zero. They're then filled at power-on.

This is all. I lean towards thinking the CHIPID block is not really a device.
It's just a way software gets the product and chip IDs, which is by querying
the OTP registers. I think I lean towards registering to the soc interface
directly via the OTP device. Or maybe you think differently?

Thanks,
ta



