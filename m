Return-Path: <linux-kernel+bounces-729415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F4CB03645
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48B43AC8CF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 05:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E56920966B;
	Mon, 14 Jul 2025 05:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmneKnQ6"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9264F1FF7DC;
	Mon, 14 Jul 2025 05:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752472394; cv=none; b=bHATPifn/d9H5AWNaXpR36tPqjXAI0Hj6n3yavx8dXBW+06J3ZXOEY+zWeaJXB3yz+9T0MBweZRCFrOoz08HJDJphO692rqCfWEwI93diSuDqLpPmTPgImKhJ3X9GfykV3U6MWky74HzAImY3NWbuge0kPo8ok+C62RZ9H6kcGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752472394; c=relaxed/simple;
	bh=qlYpCStGJxhcYB0pQltMBcKlGFCTgd5F/SfpIrOdJaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpdDn6L/A6vHLapYSJ4ol3LbmhyWh+CL1cm9cXzyF0gPUPikY5QsGtaAri7Cv85/qfunzXg5Y7YzEgrcKrNrqoc/8kYnEjPHiaLVQnAE2RuwG+KTx9Hl/axS2y7MnhY2SLd667XrgRMHNIhYVUDd8+ASm76K4vhZcGZ4WvyjtbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmneKnQ6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a52874d593so3286874f8f.0;
        Sun, 13 Jul 2025 22:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752472391; x=1753077191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VCZ2zgHNivfrlQy83HcGVg6gs2AAz7FnGq4tvjzUvag=;
        b=bmneKnQ6JzmhcyeLWgXlyr+22+ql2d7dzrOKNeCyKlAgIxDVowH746+gzfUA0nkPBV
         yoRQ7B3u2mlJsiSMPoOOY8VkrS2Oe97fe9MXz6SOPmIrsjV74DKFUP3melXVDScwqHo3
         w5aLOdL1MnSTwlHJZA5yyHIFA6e0vAlNIblKHLSz4aEiCyp1ob1FZmG7FsJOxsjftfmV
         /KMCireHsFptMlsWrNXI/uPT2hGvMGHXjxUT+v+Orqf9IYUOywS1Zk3oeE1HccdepQ/K
         fQIiSy3LndB3P/jfc5ZZn7Yc2ea7SrY78+JJwr1ViJkvZx8pv3FI3idNXPy1atiiIUGq
         qtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752472391; x=1753077191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCZ2zgHNivfrlQy83HcGVg6gs2AAz7FnGq4tvjzUvag=;
        b=d05FqjxwYS1vWZYPb3csdKnytjLk53MFZdmnM5ycuSksXC4FlXqmS4nkYSdFJv9MaF
         62t7fiHJSkBoDWrnoG59q/1e44v4m5MkAvX6bYS8V7DaoShA5tHnuBUipJSCqYst9xmH
         fIgC1u60L5fPM16epGtnzAO81eRZhwIr+7vf3hkFD+/pwr78Gj8qvj8YHtlVRMetSkzS
         /KxNAi8GEoyMT91OFuH6edMg8LQZCNeoSCXqCjhCL93AB6HUF26bzGUExRKPj9vvDWP/
         Xr8FjMXiYmvOs33NcDkqrPF0frCPfWyWBLuIk+oeoQME4/zniUIDrDzii6hKSa63hTiF
         dbmg==
X-Forwarded-Encrypted: i=1; AJvYcCV4hnNbQBsLC2AhIOZ50NEUSbtxaazcZUAUuEwDU5KUVUgHX/N2XskPGahTDZqmAb8TYiy1hU6fUkaaAqTE@vger.kernel.org, AJvYcCWyFxjx/LKDYZftt68BPKyOFvmI6cnQdVPl7a9PIAKI+tEvd2au8bBUyiRTqAu/FE7IEJMalXFNraVy@vger.kernel.org
X-Gm-Message-State: AOJu0YyqmycPII1zpwN9eogEUB5aOHQMfIMLBpvg50uHnoaXQXp/v5wC
	HcOWFSTE40/6WEC6h1EQVxb46aOPYEXFQOM0k067Bl6aJJcsekvf414=
X-Gm-Gg: ASbGncvj1Qw7NmzhByZkmL7wrG6dQrW7VZkhhe7i6w/bwYx+hNyBctKuGbtsgvzL1KK
	p645zTCg9A8js3l2hU+2P0+lPaXn2eNEJR4CsTaBy4SXfhnOAK/Dh3Xgm/GBfBH10HJDoG3XZDG
	xRfUkxN6/QjBK7DtEvg8bU8iM7rdbjsAZUpE90qybLpmB+d8honTjytMu552exURjv2qaqYgP7U
	B29N+LR36SeEhJS5wTpZPKmxPEwdv0BGjiSDb63ed1Iy2ArUEQLdO6j6mCF+Sb4BLWJuJKtiNlm
	/n5lmi7r6WGcrmJPEI1diOdoKJPHg7zrQjiKRYc0cvm5yq2o/znoKJLUsIb88MWt4sPCjUeBmg1
	TVAY+8WpRsQA5HfmiFf+DHD6O3KJkZ3Hbkx6B6A0KiKWB/2wjYebTcSna8q9H6OzuNg==
X-Google-Smtp-Source: AGHT+IF4uJU7s6fXi+Y9jOTJvVuXL0uE2v7zzu2YywbAlMlS+6hlXGxr7DpZydpCkb2LPrj9QmWEsg==
X-Received: by 2002:a05:6000:25f6:b0:3b5:e714:9770 with SMTP id ffacd0b85a97d-3b5f188d771mr10238050f8f.14.1752472390481;
        Sun, 13 Jul 2025 22:53:10 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f13:8500:dd8c:af5b:c87:6021? ([2a02:810b:f13:8500:dd8c:af5b:c87:6021])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560d019f1esm57650915e9.10.2025.07.13.22.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 22:53:09 -0700 (PDT)
Message-ID: <063ec197-bbd7-4ad2-add9-40f028e800b7@gmail.com>
Date: Mon, 14 Jul 2025 07:53:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] arm64: dts: rockchip: Add ROCK 2A/2F, Sige1 and
 NanoPi Zero2
To: Jonas Karlman <jonas@kwiboo.se>, Yao Zi <ziyao@disroot.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250712173805.584586-1-jonas@kwiboo.se>
 <702dc4bb-7b3c-4647-b84f-8516989b0836@gmail.com>
 <9aae8b30-23ae-4866-9ce8-02bbc8b44a82@kwiboo.se>
 <88c7b90d-4c29-453b-9a5c-9679b371a3a9@gmail.com>
 <16d99271-ba04-4ce1-a335-fab1917637c7@kwiboo.se>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <16d99271-ba04-4ce1-a335-fab1917637c7@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonas, Hi Yao,

> Hi Alex,
>
> On 7/13/2025 10:56 PM, Alex Bee wrote:
>> Hi Jonas,
>>
>>> Hi Alex,
>>>
>>> On 7/13/2025 9:13 PM, Alex Bee wrote:
>>>> Hi list, Hi Jonas,
>>>>
>>>>> This series adds dt-bindings and initial device tree for the following
>>>>> Rockchip RK3528A boards:
>>>>> - Radxa ROCK 2A/2F
>>>>> - ArmSoM Sige1
>>>>> - FriendlyElec NanoPi Zero2
>>>> this only sub-related to this series: Is there any particular reason, why
>>>> we call the compatible "rockchip,rk3528" and not "rockchip,rk3528a"? From
>>>> what I can see all boards currently supported (and those in this series)
>>>> are having the RK3528A version of the SoC. I didn't follow the development
>>>> here, but there are differences - I did a quick compare of the datasheets
>>>> of those two SoC versions - it looks like RK3528 version has USB3-DRD
>>>> controller, while RK3528A has USB3 host-only controller. Also it seems to
>>>> have different video codec IPs and the DRAM controller additionally
>>>> supports LPDDR4X.
>>> What datasheet versions did you check? I can only find:
>>> - RK3528 Rev 1.0 (2023-05-22)
>>> - RK3528A Rev 1.2 (2024-04-10)
>> I used
>>
>> 2023-07-12 Revision V1.0
>>
>> which didn't include these features - which is interesting: Why would a
>> SoC vendor not try to sell all features in the first place :)
>>
>> But I now double checked in
>>
>> 2025-05-12 Revision 1.4
>>
>> and you are right: It appears there also for RK3528A.
>>
>> The only difference I could now make out by comparing v1.4 of both versions
>> is the cipher engine: RK3528 additionally supports "SM2/SM3/SM4 cipher" -
>> but still it exists and additionally the different video codec (if mpp
>> userspace library is correct about that).
>>
>> Anyway: My question was more about: Why didn't we choose the correct
>> compatible from the beginning? And of course the dts files would have to be
>> renamed if the compatible is changed, as they are named according to their
>> SoC-compatible.
> Not sure, possible due to lack of technical documentation for this SoC,
> to my knowledge all upstream development has been done without any
> access to a TRM for the SoC.
Hhm, OK: Without any documentation, I'm seeing "RK3528A" silkscreened
directly on the SoC package :)

> Based on vendor code (u-boot and linux) there does not seem to be
> anything special about the A-variant, so my thinking has always been
> that the A-variant may have just been an updated/fixed hw revision and
> is the version that went into newer production devices.
>
> The recently released U-Boot 2025.07 is referencing the filename
> rk3528-radxa-e20c.dtb from the synced devicetree-rebasing tree. So a
> possible rename will affect a future release of U-Boot, and possible
> devices in the field depending on when a rename would land in linux.
>
> For this series I tried to just follow what is currently used for the
> Radxa E20C.
>
> If I am correct there is now also a RK3518 tvbox variant of this SoC,
> do not know how that would fit into all this :-S
Yeah, that's why I started comparing the features - and according to
RK3518's datasheet it only has the features I mentioned in my first mail
for RK3528A minus PCIe and the ability to connect an external ethernet phy
to the gmac controller (it probably has only one). Well, it's version 1.0 of
the datasheet ...

Regards,
Alex

> Regards,
> Jonas
>
>> Regards,
>> Alex
>>> And both list LPDDR4X support and the A-variant seem to list USB3-DRD
>>> support, did you mix them up above?
>>>
>>> I think these SoCs are similar to rk3228/rk3229, rk3228h/rk3328 and now
>>> rk3528/rk3528a, in that only the second variant support VP9 decoding.
>>>
>>> Use of rockchip,rk3528a compatible could be something to change,
>>> could also be something that bootloader set at runtime, similar to
>>> what it does for rk3288w.
>>>
>>>> I guess it would be good to discuss this before this series is merged,
>>>> because re-naming *.dts files after they have been in a release is somewhat
>>>> impossible.
>>> I think renaming the device tree files is unnecessary, as there seem to
>>> be very little difference. All boards I have come across are currently
>>> RK3528A variants. How would we treat the Radxa E20C?, it is not named
>>> rk3528-radxa-e20c.dtb, yet uses the A-variant.
>>>
>>> For mainline U-Boot I have included printing out the SoC-variant,
>>> however the compatible is not adjusted:
>>>
>>>     Model: Radxa E20C
>>>     SoC:   RK3528A
>>>     DRAM:  2 GiB
>>>
>>> Regards,
>>> Jonas
>>>
>>>> Regards,
>>>> Alex
>>>>> The bt/wifi_reg_on pins are described in the device tree using
>>>>> rfkill-gpio nodes.
>>>>>
>>>>> Changes in v3:
>>>>> - Rename led nodes to led-0/led-1
>>>>> - Remove pinctrl* props from sdio0
>>>>> - Collect a-b tags
>>>>>
>>>>> Changes in v2:
>>>>> - Limit sdmmc max-frequency to 100 MHz on ROCK 2A/2F
>>>>> - Drop clock-output-names prop from rtc node on Sige1 and NanoPi Zero2
>>>>> - Drop regulator-boot-on from usb 2.0 host regulators on Sige1
>>>>> - Add bluetooth and wifi nodes on Sige1
>>>>> - Collect t-b tag for NanoPi Zero2
>>>>>
>>>>> These boards can be booted from emmc or sd-card using the U-Boot 2025.07
>>>>> generic-rk3528 target or work-in-progress patches for these boards [1].
>>>>>
>>>>> For working bluetooth on ArmSoM Sige1 the patch "arm64: dts: rockchip:
>>>>> Fix UART DMA support for RK3528" [2] is required.
>>>>>
>>>>> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528
>>>>> [2] https://lore.kernel.org/r/20250709210831.3170458-1-jonas@kwiboo.se
>>>>>
>>>>> Jonas Karlman (6):
>>>>>      dt-bindings: arm: rockchip: Add Radxa ROCK 2A/2F
>>>>>      arm64: dts: rockchip: Add Radxa ROCK 2A/2F
>>>>>      dt-bindings: arm: rockchip: Add ArmSoM Sige1
>>>>>      arm64: dts: rockchip: Add ArmSoM Sige1
>>>>>      dt-bindings: arm: rockchip: Add FriendlyElec NanoPi Zero2
>>>>>      arm64: dts: rockchip: Add FriendlyElec NanoPi Zero2
>>>>>
>>>>>     .../devicetree/bindings/arm/rockchip.yaml     |  17 +
>>>>>     arch/arm64/boot/dts/rockchip/Makefile         |   4 +
>>>>>     .../boot/dts/rockchip/rk3528-armsom-sige1.dts | 465 ++++++++++++++++++
>>>>>     .../boot/dts/rockchip/rk3528-nanopi-zero2.dts | 340 +++++++++++++
>>>>>     .../boot/dts/rockchip/rk3528-rock-2.dtsi      | 293 +++++++++++
>>>>>     .../boot/dts/rockchip/rk3528-rock-2a.dts      |  82 +++
>>>>>     .../boot/dts/rockchip/rk3528-rock-2f.dts      |  10 +
>>>>>     7 files changed, 1211 insertions(+)
>>>>>     create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dts
>>>>>     create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-nanopi-zero2.dts
>>>>>     create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
>>>>>     create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
>>>>>     create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
>>>>>

