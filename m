Return-Path: <linux-kernel+bounces-822889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC676B84E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840387C4814
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC4622157F;
	Thu, 18 Sep 2025 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="LIhU+3w6"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5704D1F9F70
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203490; cv=none; b=aOX7HEbf98ywx/PFjRWsNl9/b4+6XK1keafMJytzjlChnwCbGjbUJv/41lvtvWneL6FyufJeMVx7Ms+GOMOgH1hyOrJjeu6FgtQFPFtRYQnYPP0BhPDe+rJAv5uSVsLHzqe7GTFVxUerxsJ0JNk2P7lZo5RTxSBVEeKC8rDnBB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203490; c=relaxed/simple;
	bh=Fvc5zCFgxQNXp10SMLlcISau9kDno376afrlmJIocKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZK+oCjGnIGSDm5dRT+DTZCgl3W96lh7yuNBtONRFXZshvxrCKM46jpDF4l6CfvuaJHcSGQPuP5T6p3BZYKLQiO6dPPAonGVFWt1iTuhX7dHIZAJ3ZIfNO61cGK8GTyl9ZKw7YGFT2l2R6By+hVYwqX9kKRDCnV3ukpySF1bsxCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=LIhU+3w6; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-88c3944558bso22092939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758203486; x=1758808286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vM4y9eRdzyomlugDECoWGADI8eAEH9U89ng3nFm0pbU=;
        b=LIhU+3w6v2hoojCIH5HBJFdAXvT1im8s5B1KesqPJt7jUVhM4YAddlUYYuoqSJnE2B
         iqXMvebmhDN6itw07ilBGh8bdMgQzT2CYMc0ZQU42pdkNd/hmJ72j7l2G24qvBfx/1Hl
         gbAc73Qt8JaF/XuNURxubv013Ru6mVFRJ4mgOEpWh2hasNOb7WbdmZ424u2rdjoct8aQ
         mV8g6JB1Wm76kjhXX+20InOdDGRsFDymwek8m854+0cwBwrP3iwZmTgb5SLO3FC4yZ5C
         B75rouOO9Nb+R6/L30Uhasqc7qoDF/tsU4K0b0f+h1rwvoR5zvOvYgJMq+faYlLqrwQo
         FFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758203486; x=1758808286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vM4y9eRdzyomlugDECoWGADI8eAEH9U89ng3nFm0pbU=;
        b=rw9r1tv81RvEY3wZwIhFw++oK/KMI3XSLGuFGk132fBK8FJ5KwmenVjarjbSlhkUJk
         9NTfBI4wMTsAcUPCTX6s1Nf5PwE61S87nCyb93VXBbqsM5jUAUKcByLeKLBfBdi8auTv
         mNRiBRfPAHvy2Xokmz7YZAbJ7pFfUrW3e4GJxTaqRGosffJZKsU9+VwRytaeBmPWaFrA
         6ixjmZC22uPji8U+OaDvsEvSpfuEYuWGoFNGu3EGDxufARGkS7sJkitq/w2xcnUNt+k4
         uwpAsEVD8/Q2+BGFB7o03ma7bfUxQRJtJedsDputKR78UBR/2Nu4b7LVdADFct8/tEe/
         p3YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIloMaUCmv4xPPoQ3KnVTY+iG3VJ2/tAg+FZxpDfpdbI7gMgzVnVDEwxvlgBIOWqAeBjiwqWSVvjPTcyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeKpCSFwSZzLf9sxWzXEieMJFmsZuUEAVviI0mKRQSYdEavYrt
	dI0ZzIlyKo9nHI/hMCM8NR9RvtshhmTxqbaCRrHiOw4Cd648PhW8pXK0IzSeawoI5ok=
X-Gm-Gg: ASbGncuIWcl6AT9cBUIhC+hKPc7dNmMfGTs9aSJDnkENyzBWYxlL5E4/btaPUOWZLam
	PW8N7ysg0Nqy2Oe0VePuzfpx9rNjjteOGIscNW6nBCTiKdjjjqSda8iaGeHx+MxrsaOQahPanTO
	I1QV18riAYFS/XVmwZ3VhNZ3/JLh/w4CZuc6Fo3+dOM2x3eJzmp5CTMcpbH5MfTIqkgeywBr80e
	N1E+/iHVVs6cGkJ5OLHxHAUc6QtdGjYuImmbsN8rLGWFPU3wH9amdNos/JsHN37qvq3L0pCRZfn
	yD55/8oxDa2ilKV+HxJaKuZQjoEO123tG2cB5SYraI8OkHBP9th8rRQ9PiwregDtvWhKhdSuiD5
	rQ+wmKyK7DcMrgFkAFJ/S+uFDSBu6SH777jVzZR6D7nfhxmnIZMC+C5GU7kcTA59naNhBO2UnNT
	SzgnQxL+SNBdJ3HgnV
X-Google-Smtp-Source: AGHT+IHGLUiTqtzLxz7lFW1lX9Y3PBwmaxFa80wh+wM2x5l9w0PsCrOK+nmIqYNhug9aW0T3WfX/Vg==
X-Received: by 2002:a05:6602:3413:b0:887:55f8:5dea with SMTP id ca18e2360f4ac-89d296b6ed1mr938651239f.14.1758203486168;
        Thu, 18 Sep 2025 06:51:26 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a484d05729sm81694739f.28.2025.09.18.06.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 06:51:25 -0700 (PDT)
Message-ID: <5956e320-7cbb-4d9a-95a7-720cfa6b9654@riscstar.com>
Date: Thu, 18 Sep 2025 08:51:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] riscv: dts: spacemit: define a SPI controller node
To: Yixun Lan <dlan@gentoo.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-4-elder@riscstar.com>
 <20250918133209-GYB1273705@gentoo.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250918133209-GYB1273705@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 8:32 AM, Yixun Lan wrote:
> Hi Alex,
> 
> On 17:07 Wed 17 Sep     , Alex Elder wrote:
>> Define a node for the fourth SoC SPI controller (number 3) on
>> the SpacemiT K1 SoC.
>>
>> Enable it on the Banana Pi BPI-F3 board, which exposes this feature
>> via its GPIO block:
>>    GPIO PIN 19:  MOSI
>>    GPIO PIN 21:  MISO
>>    GPIO PIN 23:  SCLK
>>    GPIO PIN 24:  SS (inverted)
>>
>> Define pincontrol configurations for the pins as used on that board.
>>
>> (This was tested using a GigaDevice GD25Q64E SPI NOR chip.)
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   .../boot/dts/spacemit/k1-bananapi-f3.dts      |  6 ++++++
>>   arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 20 +++++++++++++++++++
>>   arch/riscv/boot/dts/spacemit/k1.dtsi          | 19 ++++++++++++++++++
>>   3 files changed, 45 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
>> index 6013be2585428..380d475d2f3f3 100644
>> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
>> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
>> @@ -44,6 +44,12 @@ &pdma {
>>   	status = "okay";
>>   };
>>   
>> +&spi3 {
> ..
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&ssp3_0_cfg>;
> Can you swap the order of these two pinctrl properties?
> Yes, we currently have some inconsistency in tree, I plan to fix during next cycle

Sure, I'll do that.

>> +	status = "okay";
>> +};
>> +
>>   &uart0 {
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&uart0_2_cfg>;
>> diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
>> index 3810557374228..16c953eca2aaa 100644
>> --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
>> +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
>> @@ -28,4 +28,24 @@ pwm14-1-pins {
>>   			drive-strength = <32>;
>>   		};
>>   	};
>> +
>> +	ssp3_0_cfg: ssp3-0-cfg {
>> +		ssp3-0-no-pull-pins {
>> +			pinmux = <K1_PADCONF(75, 2)>,	/* SCLK */
>> +				 <K1_PADCONF(77, 2)>,	/* MOSI  */
>> +				 <K1_PADCONF(78, 2)>;	/* MISO */
>> +
>> +			bias-disable;
>> +			drive-strength = <19>;
>> +			power-source = <3300>;
>> +		};
>> +
>> +		ssp3-0-frm-pins {
>> +			pinmux = <K1_PADCONF(76, 2)>;	/* FRM (frame) */
>> +
>> +			bias-pull-up = <0>;
>> +			drive-strength = <19>;
>> +			power-source = <3300>;
>> +		};
>> +	};
>>   };
>> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
>> index 66b33a9110ccd..a826cc1ac83d5 100644
>> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
>> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
>> @@ -834,6 +834,25 @@ storage-bus {
>>   			#size-cells = <2>;
>>   			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>;
>>   
>> +			spi3: spi@d401c000 {
>> +				compatible = "spacemit,k1-spi";
>> +				reg = <0x0 0xd401c000 0x0 0x30>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				clocks = <&syscon_apbc CLK_SSP3>,
>> +					 <&syscon_apbc CLK_SSP3_BUS>;
> ..
>> +				clock-names = "core",
>> +					      "bus";
> can you simply put them together in one line? it's kind of tedious to split..

Sure I can do that.  I've seen it both ways.

>> +				resets = <&syscon_apbc RESET_SSP3>;
>> +				interrupts-extended = <&plic 55>;
> why use interrupts-extended?

Because it specifies both the controller and interrupt number
explicitly.  Why *not* use interrupts-extended?

>> +				spacemit,k1-ssp-id = <3>;
>> +				dmas = <&pdma 20>,
>> +				       <&pdma 19>;
> .. em, so the SPI will use pdma, then probably you should also adjust Kconfig to
> select PDMA driver?

You're right.  Thanks for catching that.

					-Alex

> 
>> +				dma-names = "rx",
>> +					    "tx";
>> +				status = "disabled";
>> +			};
>> +
>>   			emmc: mmc@d4281000 {
>>   				compatible = "spacemit,k1-sdhci";
>>   				reg = <0x0 0xd4281000 0x0 0x200>;
>> -- 
>> 2.48.1
>>
>>
> 


