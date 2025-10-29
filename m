Return-Path: <linux-kernel+bounces-876440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7352DC1B7F2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1718188E988
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7541D34F465;
	Wed, 29 Oct 2025 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM288K1s"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0BC34DB53
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749244; cv=none; b=snNiFi7T0KzemeKuO81iVz33f9Lr6Aa3McgDvx0/O4H7fb7puRHW3EQv/tl8b0hjn9+D1ZEj9XtbW+ZaCLz96pCzUDRB1kvSmz6+ESy7Ka9pcaDK1JIb3Wa/OY9OPO8PsMQfxQHxjylPlZwaXdcvGERlH4k/h+X1kR8uKYEkbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749244; c=relaxed/simple;
	bh=LTP67G+nQEoavdX5Wqu457R19zx0Ya1qFOJgtgAcoUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPyH4+0copfGlmxn5uBjvhu9qSbdH9c9GoUNiuG/FtMO8EBZ1Rx6xF/Yfb9dqvXqldhPProdozFjf09h2iqtD2yAkbUdnpyBIDZ99nm4pDX836qYhrWpJqtE54r7g0AUaArmFl6SRn/in7J3G98A/BjTUou5e3DlDBGywu8RxEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PM288K1s; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63c556b4e0cso6301690a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761749241; x=1762354041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8y7IaEKl9ZSpE7jjzq1dSeS8kFbTxAEVZQkW1AF3jcE=;
        b=PM288K1sfc5A4Y24S8iNRievBziGWuT7SU/q9fNQRDvhqwutGEWjs9YApCinTSbr9z
         RNmQPd/zQH/hHzxXnfjVajK936l7VqI2pIx3N3grAfp9Qx3kGO5qtha3YgX3dxrDCYuI
         j91zXH4uj3lKt9aFHrhzGRPnuhBm9cvqYM8rbAJxv4oAXX+QtzNX4Yii+DvJXzv6Q5DZ
         PxF/lWgyVQay78EGmZsBfuJS4zGctPZnpCZz4tcyNhUS9kK51SEP7g7ZS4uIlTjpgjt+
         DK79vXNN6IiuR2mYo6dPv+lU91w/FLyvFk5zygd+FIHuV6zw9B/DJwclf83SiDfmBLkR
         uOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749241; x=1762354041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8y7IaEKl9ZSpE7jjzq1dSeS8kFbTxAEVZQkW1AF3jcE=;
        b=SY+vwdVMTl8AwzDkGDA2OquYuDePB6knI5nwSHHXJYKoSO/d/67RV+zrs8/c68bO0z
         7Eo785IL6jzCXLWxlRMqDB7UcSmtYHiloPL1+MQM6CJ8ARdHBQxzDIeL6xGT3/5mGlH7
         Z69ljjqFbJVcO8/3PcFH8sxZArae8HcadMRzvH9cN/NIS4PfoM7aO4xaWucayEMlal3W
         18JLdFvvVZi3X/ijhEvn+qf8u1aQEhwtpSsTN8UyMGqGCj8WI5gVyAyfaVB88eSHuKw3
         Ib0NrhN/EgvBXUNNEqPIZievzA8p6TxPhTA7VSXr8H7xhg3F81+zxtq16fgQzRnYZW6A
         WJAg==
X-Forwarded-Encrypted: i=1; AJvYcCUtx/toyto/UANRu586mL5vxs53n69tgYD9tBIFpJYZzaFPXi6pkTB9zrWcfz4L+G4uyOtmtEz4fk2/iKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy67hCt5DuJ+F+fPSF22F7960pGEs64RcNHl/iMarktz6KSt8xa
	M5M3cBR0pp2iItjLyF8rIXbjJfGaONLoECBUTiPln9/19zSrZEIAOGVf
X-Gm-Gg: ASbGncujA6gNhsXqJ5OWrAjUOCEmNXwpFMfFCpTg5+k1NHzQRAoLy1URw4r2dnBxmD3
	bXw2LkE+BtWKQz3hLqsU9xj4Xji1g7nlZuAZ0fywwi9Itcr9G023BVbrwk3EthZjMEVnJSbMaUr
	+FiCt0c681GwS8RAZJJou/2Hv4wwIMBfy+A/MUIXe4fV8bMH2iXoBhqIBN25/RpZmksnk82imWf
	kKFHzJaja8Hu0nLykr1K3hqQWGkLD/m5XqO268nvEzc7Kz18Nmfu+dDxCVc8tM9YIbYmzA3KSr+
	lPGuR627BSkdvsNd3Hciv73S8NR/qF7Dmpr77I2JEVk+nGF9DOWwfi2kswUN+B43f/5zWqmMPel
	+X6obnXKjVoUROLUbY/snpMjeX4Isy47n0TPhyiJiy9MVPq1F0xTElj3+j/7TmSgWaulZb/4wlB
	ITGgJfCoXBNhrS6nF8sTDKNscl77Xk0G9h
X-Google-Smtp-Source: AGHT+IHgORKDGPw+ITEWuAutZRKq+hGzvmS0B08lzp6+SYDYojWyhecKTsUlp7KruwEoQhiFvx9elA==
X-Received: by 2002:a05:6402:5207:b0:639:c9c2:3956 with SMTP id 4fb4d7f45d1cf-640442692d9mr2330509a12.28.1761749241215;
        Wed, 29 Oct 2025 07:47:21 -0700 (PDT)
Received: from [10.25.210.164] ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef9a5cbsm12168527a12.23.2025.10.29.07.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:47:20 -0700 (PDT)
Message-ID: <20a3325e-d8be-4a1d-890d-bf112d170bcc@gmail.com>
Date: Wed, 29 Oct 2025 07:47:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250821105634.1893-1-laurentiumihalcea111@gmail.com>
 <20250821105634.1893-3-laurentiumihalcea111@gmail.com>
 <e25494da-9d27-4416-ac79-317c8b9a6653@kernel.org>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <e25494da-9d27-4416-ac79-317c8b9a6653@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/24/2025 4:29 AM, Krzysztof Kozlowski wrote:
> On 21/08/2025 12:56, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> AIPS5 is actually AIPSTZ5 as it offers some security-related
>> configurations. Since these configurations need to be applied before
>> accessing any of the peripherals on the bus, it's better to make AIPSTZ5
>> be their parent instead of keeping AIPS5 and adding a child node for
>> AIPSTZ5. Also, because of the security configurations, the address space
>> of the bus has to be changed to that of the configuration registers.
>>
>> Finally, since AIPSTZ5 belongs to the AUDIOMIX power domain, add the
>> missing 'power-domains' property. The domain needs to be powered on before
>> attempting to configure the security-related registers.
>>
>> The DT node name is not changed to avoid potential issues with DTs in
>> which this node is referenced.
>>
>> Co-developed-by: Daniel Baluta <daniel.baluta@nxp.com>
>> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Where did it happen?


https://lore.kernel.org/lkml/Z+xY4wZ8ZFSOJhGS@lizhi-Precision-Tower-5810/ <https://lore.kernel.org/lkml/Z+xY4wZ8ZFSOJhGS@lizhi-Precision-Tower-5810/>


>
>> ---
>>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> index bb24dba7338e..b62bb821cf61 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> @@ -1396,12 +1396,14 @@ eqos: ethernet@30bf0000 {
>>  			};
>>  		};
>>  
>> -		aips5: bus@30c00000 {
>> -			compatible = "fsl,aips-bus", "simple-bus";
>
> This breaks all the users. I understood explanation as "it is better",
> no real reasons.


sorry, a rather poor choice of wording on my part....


the reason we're doing this change is because we need to configure the bridge's

security-related registers. If we don't, masters such as the DSP core won't be able to

access the peripherals connected to this bridge after the AUDIOMIX PD is turned off

and then on. The configuration needs to be done before any of the masters attempt to

perform transactions to the peripherals.


yes, this change is not ideal and we've had problems caused by this

(see https://lore.kernel.org/lkml/20250707234628.164151-2-laurentiumihalcea111@gmail.com/ <https://lore.kernel.org/lkml/20250707234628.164151-2-laurentiumihalcea111@gmail.com/>)

so if you have any suggestions that would be much appreciated.


>
> No, you cannot do that.
>
> Best regards,
> Krzysztof

