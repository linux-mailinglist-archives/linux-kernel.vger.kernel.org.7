Return-Path: <linux-kernel+bounces-729190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3EDB032F4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 22:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15FBD189A042
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 20:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5B328136F;
	Sun, 13 Jul 2025 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGvV+GOe"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A21E1EF38E;
	Sun, 13 Jul 2025 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752440225; cv=none; b=I1DgrETrFZvsGbFf0QIxbl8XGq4Qd9V+Xhnj42X7PL0eAU6TyE0lQ9Nm263XNggQAmcED4lZPNhTnW0yFyKof28ijP17YVGF01QKEX+CrdH66NNs3ehk9r7sJFAVso9UTOaabhU6kNCCxauqJLFUvQDFIUqwvMRMaPkL+hQ2w4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752440225; c=relaxed/simple;
	bh=HVfT6Cp9lcHpsfqof+rUDaP3i545Ens5DFdV6jn6Aes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAAUVAhclZ9OP2FwHPB7lhYMXmh2QJmilncxdNgx9TbdadaEsZmqrD/XTMQ9rMmxBHVX0dgIZwJnpeHHu+pU2V1FKpJ0349KjUw3dlkbHdURBKYtsIqMsDuNLQmbQyRypkPLFaSyGgDnN8Ode+nfPwGqoq4mnzdu//4vclPf6MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGvV+GOe; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so7929105e9.2;
        Sun, 13 Jul 2025 13:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752440222; x=1753045022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=to7crXpmc3tk8K8ESb5T/YynsyRL1Ajh9nnIinlJZZM=;
        b=PGvV+GOehfWrle3P9xKAdKQzDx+BdMNNZqY2dAznCcZQBtW0rBq8KswlzDLEHqTnQi
         jNwHRvXKndtyyA9FH6j/fK3/sFaLWj0VIVZUvaLX5SxmQ8JRgs7TjvZYgjaCshdH7RWJ
         5Vurb1A6i5chmBYZU8BN/cfvc7xI70g8opoXl9uudssL/hzoPwnKrPcgNT0GF3FTQnmu
         sQtN5W+jZ2f9NKI+m5lmLipkWTRLozdgSfvvmWmxME7HXjuPd8Bj3qhlYyCXHgbSDeUa
         UAF1TUBZMw1+8IrOwIR4Qc0xxoIKe0HDX38vuwJKmXcESGKwwEdn+5AaUy3lNVPujfpz
         R3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752440222; x=1753045022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=to7crXpmc3tk8K8ESb5T/YynsyRL1Ajh9nnIinlJZZM=;
        b=j1uTBhAdiVnmRmNO2OngT567otroAFinCvvSIw10HpBF5rjKzAWfwSkhApsiFCaTa5
         2hoj/TDoH9B9xuGF5dzW6aTPkxm/ekrTaIwrlwOrjRJ3qE4SXGdhpqCndUzNn4kOzsis
         2EDM2Hd9YIaSQV3YHf9vrdB4aDA7cKdYJxjygQq+dMY/9cnSc/oqZc40e9XmWO37/xv3
         h2UlM8bG9hwHPNI0f2VNIBP2KtwwADatv15YlSr1fMQvKfan1VF6ylpuUWNnw/vkuo1q
         OI+a85nIk03+QfQBMvzR2/BTPBFNbMGgeQm72kBErIM2M/VyTw+xhMSFAT0d10kfwnr1
         RFyg==
X-Forwarded-Encrypted: i=1; AJvYcCVG1iTcp2OO6O7o2DdtNdehj2s5OopxF5H5lzcAMhhNx/hVa8G+YiMIzHsBLw2IwC88cPy+oTuCU8lfFZ7I@vger.kernel.org, AJvYcCWc36jPWWA9wgWs+/B7gSlPSDWcK5ajrWw3iCzHL1kOAshJ5BPLbPnmYmajLpD1d33ll93JSVjYta6M@vger.kernel.org
X-Gm-Message-State: AOJu0YwBrMFl1kzOoFCqnEraKN0wsMk6hFCEeACHlTtyFDZhc6lkPEfI
	nJ6N9bt/1+sgMhOK17XLmRkORA4D8bjdHkJKtsOB50EIuxGWwNWvPXU=
X-Gm-Gg: ASbGncs9bxSAW4+bmLmE4EPrhodQasiVvjc5gx0Tv0L/er546oU4GBr8EvwAXcQMSft
	/296JWnB6Eui1O7u8ag93iuOwMxUaPVMwDNGrt4U+220Kj5dHXASAlbjjxhjz4eZEepE7buOLkH
	0GT/uj4/FeU/Aw/1a397qn+oF/SL34p502nJlgP3g3xBRHfPV+w8Fw62OuDsOBYBKf6fz/alHfF
	D93rVEF7tRy4aMGuil31faz8ifb3SBCgdiOL6KZkBXw1goJ7IRNCBgMT3AzRcEmhs9AMW2Q/5QG
	I0C3FS92pYwcXj3jcPz8U52ECKU9adNC9XqzVZjfrr0Cqa/X8CeC9hg9HgGatkpye8Kh7GtQ0O3
	2Vo14ZfLr2o9Goyl2jPfaX+vXEQ/0jcS4ygK5rhNS8MKMQl/wyJBmCfgqvBOxfmDoCBh1
X-Google-Smtp-Source: AGHT+IF5La+hY8Yrg7YwlzCxMrCYulsyoeM7g42TWSERJAPSWP3FmuZJ9Rfhs1Cyvy8o8wqIAENgjw==
X-Received: by 2002:a05:600c:4591:b0:451:edc8:7806 with SMTP id 5b1f17b1804b1-454fe10f716mr93836375e9.32.1752440221829;
        Sun, 13 Jul 2025 13:57:01 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f13:8500:303c:fa0e:1d48:e93b? ([2a02:810b:f13:8500:303c:fa0e:1d48:e93b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc91e3sm10476269f8f.43.2025.07.13.13.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 13:57:00 -0700 (PDT)
Message-ID: <88c7b90d-4c29-453b-9a5c-9679b371a3a9@gmail.com>
Date: Sun, 13 Jul 2025 22:56:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] arm64: dts: rockchip: Add ROCK 2A/2F, Sige1 and
 NanoPi Zero2
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>,
 Chukun Pan <amadeus@jmu.edu.cn>, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250712173805.584586-1-jonas@kwiboo.se>
 <702dc4bb-7b3c-4647-b84f-8516989b0836@gmail.com>
 <9aae8b30-23ae-4866-9ce8-02bbc8b44a82@kwiboo.se>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <9aae8b30-23ae-4866-9ce8-02bbc8b44a82@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonas,

> Hi Alex,
>
> On 7/13/2025 9:13 PM, Alex Bee wrote:
>> Hi list, Hi Jonas,
>>
>>> This series adds dt-bindings and initial device tree for the following
>>> Rockchip RK3528A boards:
>>> - Radxa ROCK 2A/2F
>>> - ArmSoM Sige1
>>> - FriendlyElec NanoPi Zero2
>>
>> this only sub-related to this series: Is there any particular reason, why
>> we call the compatible "rockchip,rk3528" and not "rockchip,rk3528a"? From
>> what I can see all boards currently supported (and those in this series)
>> are having the RK3528A version of the SoC. I didn't follow the development
>> here, but there are differences - I did a quick compare of the datasheets
>> of those two SoC versions - it looks like RK3528 version has USB3-DRD
>> controller, while RK3528A has USB3 host-only controller. Also it seems to
>> have different video codec IPs and the DRAM controller additionally
>> supports LPDDR4X.
> What datasheet versions did you check? I can only find:
> - RK3528 Rev 1.0 (2023-05-22)
> - RK3528A Rev 1.2 (2024-04-10)
I used

2023-07-12 Revision V1.0

which didn't include these features - which is interesting: Why would a
SoC vendor not try to sell all features in the first place :)

But I now double checked in

2025-05-12 Revision 1.4

and you are right: It appears there also for RK3528A.

The only difference I could now make out by comparing v1.4 of both versions
is the cipher engine: RK3528 additionally supports "SM2/SM3/SM4 cipher" -
but still it exists and additionally the different video codec (if mpp
userspace library is correct about that).

Anyway: My question was more about: Why didn't we choose the correct
compatible from the beginning? And of course the dts files would have to be
renamed if the compatible is changed, as they are named according to their
SoC-compatible.

Regards,
Alex
>
> And both list LPDDR4X support and the A-variant seem to list USB3-DRD
> support, did you mix them up above?
>
> I think these SoCs are similar to rk3228/rk3229, rk3228h/rk3328 and now
> rk3528/rk3528a, in that only the second variant support VP9 decoding.
>
> Use of rockchip,rk3528a compatible could be something to change,
> could also be something that bootloader set at runtime, similar to
> what it does for rk3288w.
>
>> I guess it would be good to discuss this before this series is merged,
>> because re-naming *.dts files after they have been in a release is somewhat
>> impossible.
> I think renaming the device tree files is unnecessary, as there seem to
> be very little difference. All boards I have come across are currently
> RK3528A variants. How would we treat the Radxa E20C?, it is not named
> rk3528-radxa-e20c.dtb, yet uses the A-variant.
>
> For mainline U-Boot I have included printing out the SoC-variant,
> however the compatible is not adjusted:
>
>    Model: Radxa E20C
>    SoC:   RK3528A
>    DRAM:  2 GiB
>
> Regards,
> Jonas
>
>> Regards,
>> Alex
>>> The bt/wifi_reg_on pins are described in the device tree using
>>> rfkill-gpio nodes.
>>>
>>> Changes in v3:
>>> - Rename led nodes to led-0/led-1
>>> - Remove pinctrl* props from sdio0
>>> - Collect a-b tags
>>>
>>> Changes in v2:
>>> - Limit sdmmc max-frequency to 100 MHz on ROCK 2A/2F
>>> - Drop clock-output-names prop from rtc node on Sige1 and NanoPi Zero2
>>> - Drop regulator-boot-on from usb 2.0 host regulators on Sige1
>>> - Add bluetooth and wifi nodes on Sige1
>>> - Collect t-b tag for NanoPi Zero2
>>>
>>> These boards can be booted from emmc or sd-card using the U-Boot 2025.07
>>> generic-rk3528 target or work-in-progress patches for these boards [1].
>>>
>>> For working bluetooth on ArmSoM Sige1 the patch "arm64: dts: rockchip:
>>> Fix UART DMA support for RK3528" [2] is required.
>>>
>>> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528
>>> [2] https://lore.kernel.org/r/20250709210831.3170458-1-jonas@kwiboo.se
>>>
>>> Jonas Karlman (6):
>>>     dt-bindings: arm: rockchip: Add Radxa ROCK 2A/2F
>>>     arm64: dts: rockchip: Add Radxa ROCK 2A/2F
>>>     dt-bindings: arm: rockchip: Add ArmSoM Sige1
>>>     arm64: dts: rockchip: Add ArmSoM Sige1
>>>     dt-bindings: arm: rockchip: Add FriendlyElec NanoPi Zero2
>>>     arm64: dts: rockchip: Add FriendlyElec NanoPi Zero2
>>>
>>>    .../devicetree/bindings/arm/rockchip.yaml     |  17 +
>>>    arch/arm64/boot/dts/rockchip/Makefile         |   4 +
>>>    .../boot/dts/rockchip/rk3528-armsom-sige1.dts | 465 ++++++++++++++++++
>>>    .../boot/dts/rockchip/rk3528-nanopi-zero2.dts | 340 +++++++++++++
>>>    .../boot/dts/rockchip/rk3528-rock-2.dtsi      | 293 +++++++++++
>>>    .../boot/dts/rockchip/rk3528-rock-2a.dts      |  82 +++
>>>    .../boot/dts/rockchip/rk3528-rock-2f.dts      |  10 +
>>>    7 files changed, 1211 insertions(+)
>>>    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dts
>>>    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-nanopi-zero2.dts
>>>    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
>>>    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
>>>    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
>>>

