Return-Path: <linux-kernel+bounces-737676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D55B0AF3C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 11:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAC7B1AA42F3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 09:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B05238C3F;
	Sat, 19 Jul 2025 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoALTdGx"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973651E3772;
	Sat, 19 Jul 2025 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752919119; cv=none; b=gTFi9ScalRyEws652lCIp2Klh/LX+TmIG2Gai/sVXJP23QJyNOx5K7fyUw241Do6Mn3zPJItVELbrEl7wgV2hw9w5Uxd81Qu1D1+/Pwr5/yeWipOprPBg6R5xQZoKqMo/PxngDsbfCzPMWG0q/A+qpq2ELUB+A/KU/7oBgH6syk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752919119; c=relaxed/simple;
	bh=hs7ib4BgcgrdxIG+O52EFoUGVvzde8nhVPvDCjuIrtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roAbdY8u+0ItRan68DuU71jvXxdaA/rGt/NK44k/7Nu2jZol5Q4YYKgc2WsEv+OPIDxc63+XFnGot7piJJ1lu1eW+u2PdEOCZX5nKrmhpX9vkRW6KO/vh1TNMITpmxJ89T3/sXKa8/D4r45HUxSYv6+3HCUYe21kYfzIcxwWDjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoALTdGx; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae6f8d3bcd4so497145166b.1;
        Sat, 19 Jul 2025 02:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752919115; x=1753523915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xu0eHIAbZ8YoFp9mG6OmxRR19wlP9Vw9CC33jTH/cSM=;
        b=CoALTdGxN/bDguV7DjftVW4PiE+rDA9x1ZxsG83lAHcawJJotelOXN7OFI01bcjs1O
         j6ZB5H3NexBjeymB9APCe7N5/zL9bt7yKODNLkKqMM4MRpYO3z2O4zUJU/uZ4w5nH4XA
         m7fKIdtYTx1YLQvordHquVDB3H7C3O1XCgHMaWMZnIxOGZIUaSnxJcVwHwEn2IywO7qO
         EZs0vK7SZVCtfI3OyWGJ/gBWKCErKqFX2gJb31yP+Zw8hM0wU8DWrwmf8oVIHtUzB47w
         kshURosReczKkFAPRZ8q9Me/5xTcJA47wSYb+aIzYHvJ8AT4Om6nG3RM7/IWjZu1/Coh
         sOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752919115; x=1753523915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xu0eHIAbZ8YoFp9mG6OmxRR19wlP9Vw9CC33jTH/cSM=;
        b=nvEKLa3T5AaHxnZbH8iKuDdBsND1bRst7zvYtk/IqcjruH9NKdrcI0V6YwGXdoitCl
         YIBDN6cNPOxkacEtOOSMOoGzpR+dm7nfisNT1RJcvq5PcZ0my0OjxhaHRe8zbtnf+p17
         73Q7Dlgoae3vweRhNqsXYErmXEPDw78y6/HEqkV1zV3M4mt6G5D75xi/lzhACUd/zacx
         /YM9cXx1OW1BMAU36FEak5BrAcuq6sNmlxBqtYFHAF4pjxsdf9Q2iVcruZ5iTTq4Gv+B
         RFaiC7gnSBrHOwwGECmNHH28NqrJrVXf2Nli0/TA3aQRqjrzX1TJdMM2fBM2bkfNuCtK
         tqJA==
X-Forwarded-Encrypted: i=1; AJvYcCUapb+3ZPgJ0uB7UFkSEjGKE2iFVktzkg97O0Rvsm54dkmhDehgXnvQ3z8gjhHsdGcCZPWOD2UhpwjR@vger.kernel.org, AJvYcCVuvWrvVgZ3s7fv17p7rveuRHs4tLlLYN5H4gKMr8S5FLYv/sBGgXEIqG7s2BOrcCPRMO9yloeblhReSA9k@vger.kernel.org
X-Gm-Message-State: AOJu0YwDy6x6Uc7F9+NeWREkW7BI9Nsz0bqWTCE/5wPt8v6khy9Skkrh
	ve6Vvwdz1uyZ0qpofoP3TqtiRxmJ/QTYX0N8NplhaQ0NVP4ATQDBrYk=
X-Gm-Gg: ASbGncund7Jc3gmZegPXOU7MeBP6EARyS3x5wSzqHhD4PLGA5G77j71e/a41IW/6Raf
	4gtFH4siE2S2ZLIHBXiONBXwfNkTdQA7PBd4YqONYqmLwAe1ZZEzUnllvtmGJ3LLkWmH+0lIyLA
	ugmMVj8Qct6DaLhqFIi8Mq/JeLRKVL3n/0jlSjKgbN2XFVP1bHMr0KwNpzZBPsRBf7t5eUNcbhI
	ktXm6VAanT1BZsfzEzCXRwzQp1yUIdCBLSE9YoZL024CLR5zxK7yFsJMYgCOtv5AccAF3XAlv+J
	tKmoKVdJLvDdVTfu2JY7RrNDVlj76T3Oaxr0ziEMrGOnrHvLWQXyOK7NN5dBXZGiYxj3/R2mIcx
	bjtCyMishVTuyzjz8cYOLyY5+0S1BYf8wjE7rohCjrjPcOu4WSu35E93ej2r+C4CZsR/R
X-Google-Smtp-Source: AGHT+IF5sBy8y7SSwQAQOjt1/u4yI/eL6f3AIZ67usdJy63oiXow7Kbazieb7CW57vQ705lEiDq+7A==
X-Received: by 2002:a17:907:3f95:b0:ae3:5da3:1a23 with SMTP id a640c23a62f3a-ae9c99c0d2bmr1216983766b.21.1752919114187;
        Sat, 19 Jul 2025 02:58:34 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f13:8500:e8ef:8c02:6b1e:381c? ([2a02:810b:f13:8500:e8ef:8c02:6b1e:381c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca30d2esm276702766b.86.2025.07.19.02.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jul 2025 02:58:33 -0700 (PDT)
Message-ID: <104a501d-b9b2-494e-b073-932ddadd7129@gmail.com>
Date: Sat, 19 Jul 2025 11:58:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] arm64: dts: rockchip: Add ROCK 2A/2F, Sige1 and
 NanoPi Zero2
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>, Yao Zi <ziyao@disroot.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250712173805.584586-1-jonas@kwiboo.se>
 <16d99271-ba04-4ce1-a335-fab1917637c7@kwiboo.se>
 <063ec197-bbd7-4ad2-add9-40f028e800b7@gmail.com> <11576357.nUPlyArG6x@diego>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <11576357.nUPlyArG6x@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 15.07.25 um 20:56 schrieb Heiko Stübner:
> Am Montag, 14. Juli 2025, 07:53:09 Mitteleuropäische Sommerzeit schrieb Alex Bee:
>> Hi Jonas, Hi Yao,
>>
>>> Hi Alex,
>>>
>>> On 7/13/2025 10:56 PM, Alex Bee wrote:
>>>> Hi Jonas,
>>>>
>>>>> Hi Alex,
>>>>>
>>>>> On 7/13/2025 9:13 PM, Alex Bee wrote:
>>>>>> Hi list, Hi Jonas,
>>>>>>
>>>>>>> This series adds dt-bindings and initial device tree for the following
>>>>>>> Rockchip RK3528A boards:
>>>>>>> - Radxa ROCK 2A/2F
>>>>>>> - ArmSoM Sige1
>>>>>>> - FriendlyElec NanoPi Zero2
>>>>>> this only sub-related to this series: Is there any particular reason, why
>>>>>> we call the compatible "rockchip,rk3528" and not "rockchip,rk3528a"? From
>>>>>> what I can see all boards currently supported (and those in this series)
>>>>>> are having the RK3528A version of the SoC. I didn't follow the development
>>>>>> here, but there are differences - I did a quick compare of the datasheets
>>>>>> of those two SoC versions - it looks like RK3528 version has USB3-DRD
>>>>>> controller, while RK3528A has USB3 host-only controller. Also it seems to
>>>>>> have different video codec IPs and the DRAM controller additionally
>>>>>> supports LPDDR4X.
>>>>> What datasheet versions did you check? I can only find:
>>>>> - RK3528 Rev 1.0 (2023-05-22)
>>>>> - RK3528A Rev 1.2 (2024-04-10)
>>>> I used
>>>>
>>>> 2023-07-12 Revision V1.0
>>>>
>>>> which didn't include these features - which is interesting: Why would a
>>>> SoC vendor not try to sell all features in the first place :)
>>>>
>>>> But I now double checked in
>>>>
>>>> 2025-05-12 Revision 1.4
>>>>
>>>> and you are right: It appears there also for RK3528A.
>>>>
>>>> The only difference I could now make out by comparing v1.4 of both versions
>>>> is the cipher engine: RK3528 additionally supports "SM2/SM3/SM4 cipher" -
>>>> but still it exists and additionally the different video codec (if mpp
>>>> userspace library is correct about that).
>>>>
>>>> Anyway: My question was more about: Why didn't we choose the correct
>>>> compatible from the beginning? And of course the dts files would have to be
>>>> renamed if the compatible is changed, as they are named according to their
>>>> SoC-compatible.
>>> Not sure, possible due to lack of technical documentation for this SoC,
>>> to my knowledge all upstream development has been done without any
>>> access to a TRM for the SoC.
>> Hhm, OK: Without any documentation, I'm seeing "RK3528A" silkscreened
>> directly on the SoC package :)
> So ... the TRM I meanwhile got, calls itself
> 	"Rockchip RK3528A Technical Reference Manual"
> in the title and
> 	"RK3528A TRM (Part 1)"
> on each page.
>
> The one thing with an "A" I remember was the rk3066a. There even was
> a rk3066b variant ... which was quite different, but I've never seen any
> products using that variant.
>
> So for the things to do:
>
> - renaming devicetree _files_ later is no problem ... the given "guarantee"
>    is that the kernel is supposed to boot with an old devicetree blob, you
>    found in the attic ;-) . (if it follows established bindings)
> - renaming compatibles is more difficult - and a lot of stuff already
>    calls itself rk3528 - without-a in a bunch of bindings.
>
> So part of me just sees continuing without-a as the way to go, that
> rk3518 mentioned below even has a different number ;-)
>
> And wait until an actual rk3528 b-c-whatever variant needing different
> stuff comes along.
The issue I was seeing is that there actually *is* a variant called
'RK3528' which at least according to the latest datasheets slightly differs
from 'RK3528A'. We are doing development based on 'RK3528A' and calling it
'rockchip,rk3528' which might make it hard to add the non-A-variant in
future (unless we call it 'rockchip,the-actual-rk3528').
>
> Heiko
>
>
>>> Based on vendor code (u-boot and linux) there does not seem to be
>>> anything special about the A-variant, so my thinking has always been
>>> that the A-variant may have just been an updated/fixed hw revision and
>>> is the version that went into newer production devices.
>>>
>>> The recently released U-Boot 2025.07 is referencing the filename
>>> rk3528-radxa-e20c.dtb from the synced devicetree-rebasing tree. So a
>>> possible rename will affect a future release of U-Boot, and possible
>>> devices in the field depending on when a rename would land in linux.
>>>
>>> For this series I tried to just follow what is currently used for the
>>> Radxa E20C.
>>>
>>> If I am correct there is now also a RK3518 tvbox variant of this SoC,
>>> do not know how that would fit into all this :-S
>> Yeah, that's why I started comparing the features - and according to
>> RK3518's datasheet it only has the features I mentioned in my first mail
>> for RK3528A minus PCIe and the ability to connect an external ethernet phy
>> to the gmac controller (it probably has only one). Well, it's version 1.0 of
>> the datasheet ...
>>
>> Regards,
>> Alex
>>
>>> Regards,
>>> Jonas
>>>
>>>> Regards,
>>>> Alex
>>>>> And both list LPDDR4X support and the A-variant seem to list USB3-DRD
>>>>> support, did you mix them up above?
>>>>>
>>>>> I think these SoCs are similar to rk3228/rk3229, rk3228h/rk3328 and now
>>>>> rk3528/rk3528a, in that only the second variant support VP9 decoding.
>>>>>
>>>>> Use of rockchip,rk3528a compatible could be something to change,
>>>>> could also be something that bootloader set at runtime, similar to
>>>>> what it does for rk3288w.
>>>>>
>>>>>> I guess it would be good to discuss this before this series is merged,
>>>>>> because re-naming *.dts files after they have been in a release is somewhat
>>>>>> impossible.
>>>>> I think renaming the device tree files is unnecessary, as there seem to
>>>>> be very little difference. All boards I have come across are currently
>>>>> RK3528A variants. How would we treat the Radxa E20C?, it is not named
>>>>> rk3528-radxa-e20c.dtb, yet uses the A-variant.
>>>>>
>>>>> For mainline U-Boot I have included printing out the SoC-variant,
>>>>> however the compatible is not adjusted:
>>>>>
>>>>>      Model: Radxa E20C
>>>>>      SoC:   RK3528A
>>>>>      DRAM:  2 GiB
>>>>>
>>>>> Regards,
>>>>> Jonas
>>>>>
>>>>>> Regards,
>>>>>> Alex
>>>>>>> The bt/wifi_reg_on pins are described in the device tree using
>>>>>>> rfkill-gpio nodes.
>>>>>>>
>>>>>>> Changes in v3:
>>>>>>> - Rename led nodes to led-0/led-1
>>>>>>> - Remove pinctrl* props from sdio0
>>>>>>> - Collect a-b tags
>>>>>>>
>>>>>>> Changes in v2:
>>>>>>> - Limit sdmmc max-frequency to 100 MHz on ROCK 2A/2F
>>>>>>> - Drop clock-output-names prop from rtc node on Sige1 and NanoPi Zero2
>>>>>>> - Drop regulator-boot-on from usb 2.0 host regulators on Sige1
>>>>>>> - Add bluetooth and wifi nodes on Sige1
>>>>>>> - Collect t-b tag for NanoPi Zero2
>>>>>>>
>>>>>>> These boards can be booted from emmc or sd-card using the U-Boot 2025.07
>>>>>>> generic-rk3528 target or work-in-progress patches for these boards [1].
>>>>>>>
>>>>>>> For working bluetooth on ArmSoM Sige1 the patch "arm64: dts: rockchip:
>>>>>>> Fix UART DMA support for RK3528" [2] is required.
>>>>>>>
>>>>>>> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528
>>>>>>> [2] https://lore.kernel.org/r/20250709210831.3170458-1-jonas@kwiboo.se
>>>>>>>
>>>>>>> Jonas Karlman (6):
>>>>>>>       dt-bindings: arm: rockchip: Add Radxa ROCK 2A/2F
>>>>>>>       arm64: dts: rockchip: Add Radxa ROCK 2A/2F
>>>>>>>       dt-bindings: arm: rockchip: Add ArmSoM Sige1
>>>>>>>       arm64: dts: rockchip: Add ArmSoM Sige1
>>>>>>>       dt-bindings: arm: rockchip: Add FriendlyElec NanoPi Zero2
>>>>>>>       arm64: dts: rockchip: Add FriendlyElec NanoPi Zero2
>>>>>>>
>>>>>>>      .../devicetree/bindings/arm/rockchip.yaml     |  17 +
>>>>>>>      arch/arm64/boot/dts/rockchip/Makefile         |   4 +
>>>>>>>      .../boot/dts/rockchip/rk3528-armsom-sige1.dts | 465 ++++++++++++++++++
>>>>>>>      .../boot/dts/rockchip/rk3528-nanopi-zero2.dts | 340 +++++++++++++
>>>>>>>      .../boot/dts/rockchip/rk3528-rock-2.dtsi      | 293 +++++++++++
>>>>>>>      .../boot/dts/rockchip/rk3528-rock-2a.dts      |  82 +++
>>>>>>>      .../boot/dts/rockchip/rk3528-rock-2f.dts      |  10 +
>>>>>>>      7 files changed, 1211 insertions(+)
>>>>>>>      create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dts
>>>>>>>      create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-nanopi-zero2.dts
>>>>>>>      create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
>>>>>>>      create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
>>>>>>>      create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
>>>>>>>
>
>
>

