Return-Path: <linux-kernel+bounces-892706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01200C45A33
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66B31883C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A239C23A98D;
	Mon, 10 Nov 2025 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nU39OciU"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103EC2192F5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766946; cv=none; b=U3H0X1AM6C5a2CdPhNSIm23YC/M/AIsLmQl9QW69e1hyYSsDW35AI7JSKu3PeSiHCi4fAmNPUW/Xk1jha4sf9e19+EVnkpjNj/LpSfhgAdMd3s8qhD77KIXtzyBAlLo7SLxVVGqmosr29s29UevwVW0uvy3Vm901b44p7SW8EP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766946; c=relaxed/simple;
	bh=cQCq9mf+4odA3iUdRoOEUQPVNJLSpTjSlhgginhi9m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXTzqJ7JMxjaoZ0/G+Q7QwcoPFaFwlpDJCf4ecLniOYHCtMz7IeLD8hODjktpKSr/bX97IJTiolCjqcUdB0CWRUMhSvrIXWpbNi3gd/32rLbQgeBOs6PqKLVh7ntUEG63zcNf/zobjdRPEhm+fBxppaQ8ICNSLKpmBBZxMFOBJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nU39OciU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47755de027eso18762615e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762766941; x=1763371741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yy2Y3SJbuc6h3iInMfmhynFq9n8Y39FAnrKgiWA6qd4=;
        b=nU39OciU6xlalCppBfMHmG2Ki88rc+8SK7ABBNIHuRhHhotVhMVevQ7Ofmw0WQ4RbS
         ptCnqjtGiOtUo2tlqv3i9cfZmAgsAohZM8UM8TaiQyDBfpiG5Xb1Wywar/EVQ9nErMjS
         dFpcatjHFjm91/PN5v1OzeowjCY6FbfpZl8toKNxFv8XDQLpuhuuaCK7PytLMAPMEGa6
         Xtzy/Oo0sjtCpQV90RizvlBZtll4wIgJDdGxynj9PBeSvUtskUMKCNvMEbbyTtNH8KuM
         wVq1YSTGFLxZxhQHA50rDKkpFewYz2sU5qxOrknpZll280kKADD1VRRTVfberFH4FHPb
         9lzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762766941; x=1763371741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yy2Y3SJbuc6h3iInMfmhynFq9n8Y39FAnrKgiWA6qd4=;
        b=S9CBfqS50QoRTGi0mn8UFoQ7Q+p8b0gOMaNBCH+dWFWtBG2t54OVs5tluzTtYSxvAR
         HxHCDV2aIkTCzqCgQuI4p212MX9Be89Q8eXBk/1QYm1W02ryMB/MI7vNHhWQwqE+gxyN
         rgw1FwXzX2mZefI5WZqxtZwCQB11dkbKULbN3VpmkU5kqbrZDFpj8OB4u/bxtQGGrB4E
         QTOPbuXHmVF+U752ObMegpEGUERrSSi9ZNK4ppIzvkohecNwCO8VMeIjhFLMOMfLtuSb
         RcPIX5enlgr03afZXsh72DZG4MRQXuAm4Lemz1U56c+FtMNStqbqFGATMZaSEKLxce2Z
         +Jhg==
X-Forwarded-Encrypted: i=1; AJvYcCUdYRja1gGB9MrrNkIIHzrd47aQoH7+MVQPO1dl4ZQDoZG/liEzn7tpR6f2p0BKi/HrTBX47dKNmurIWYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvxllmyLjQp8vhAe9/s4sy0X2N5YKV8/3teGCl65C4ienWYllN
	2l/PAr8y0In/kXywDYhXvC6fQ68DqqWVpBWtlDc62+sPPtvDcMvcoI26Hph+SLp+Q68=
X-Gm-Gg: ASbGncuafsY1agyvZolBgpQtiW1lWhNbYwrCwez4G4a4+lxgtrcTBWdCu9cihaP6Rg7
	IhTwbBLGWlMiHxoS7hDIWlaeHOwaome9wA1qx8xg118E0+W2pq6ycdpuMX7g42E8uJNJraq6jkt
	1gkcgIqMdbB8DQnegs5/+7MadI06PqD3EWI5yI1fxdcCiGN71evdGNvaudzQRhG+TI8I23UZv3Q
	tTpGYDoXfGqP6QE8pkWkyn+/QxWBuDbV++fJqfPGLL7GfrUNciTQ8UMWmbu7B40MiO9e/2AZmzJ
	aeVFQX1LXeVqgVQbIqvaRn3ojfYSHPvEVsu6/M+4a153xTT5ro1in/F2xgc/1xbQaJ9cj6nSZCh
	FUOreL27wtRty3jIsXA28IzOcuOs32YC+hfwxsOwHhaER3rhLtVOEyLtzkEP6Qb2rtTNbgvA315
	Dn5xMi2VRL2JbupJ/q
X-Google-Smtp-Source: AGHT+IGRrEV2Y5FWsA2ScUyXO8LRGfeCzTu8A6LXyew1cnLNeQXucI/waFNT0uIfIF1Jhc8bs3HOiw==
X-Received: by 2002:a05:600c:4453:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-47773277296mr66813835e9.30.1762766941281;
        Mon, 10 Nov 2025 01:29:01 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675cd25sm21324511f8f.22.2025.11.10.01.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 01:29:00 -0800 (PST)
Message-ID: <3a2f9b58-bbdf-4977-b06b-9f43a4555274@linaro.org>
Date: Mon, 10 Nov 2025 11:28:57 +0200
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
 <b9b10943-0ece-495f-a6a8-403fc1ab9213@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <b9b10943-0ece-495f-a6a8-403fc1ab9213@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/25 9:14 AM, Krzysztof Kozlowski wrote:
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
> 
> So chipid@1000_0000
> 
>>
>> 0x1000_0000 is the base address of the OTP controller (OTP_CON_TOP).
> 
> 
> and efuse@1000_0000 from your other patchset and your sentence above.
> 
> Please add them to DTS and check for warnings.

One would get an unique_unit_address warning, yes.

> 
>>
>> "CHIPID block" tells it's a device, no? But now I think it was just an
>> unfortunate datasheet description. Do you have an advice on how I shall
>> treat this next please? Maybe register to the soc interface directly from
>> the OTP controller driver?
> I think in the SoC it is impossible or at least never happening that you
> create two devices for the same address, therefore either chipid is a
> device or efuse is a device.
> 
Right. The ChipID "block" does not have its own registers. It references
the OTP registers. I'll describe just the efuse device in the DT and
register to the soc interface directly from the efuse driver. Please let
me know if you think there's a better way to handle this.

Thanks,
ta

