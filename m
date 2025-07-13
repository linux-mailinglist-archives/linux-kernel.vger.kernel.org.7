Return-Path: <linux-kernel+bounces-729168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E86DEB032B9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 21:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DF91895640
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 19:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76788289373;
	Sun, 13 Jul 2025 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9+6gTCv"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2420522FE0A;
	Sun, 13 Jul 2025 19:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752434029; cv=none; b=OjHiv6eWIOxRRAsMS5w/s+EU4YX7j0ZjDI3Ig2L4R45wuY0AI7cUZENeOj61yoZ43ZZj42ztFGHUIq6aFWNR/39devOrsl3Jit/CbEAptWFizuQRxbF7wOQQgvJomomtAQKzeQvnGd9pOQ9cF9SmIsNsvInYTCgOhc2tC0bwOrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752434029; c=relaxed/simple;
	bh=Pr4ssuwJ7eYc7plzhN80jbG9ao5jLX8Hv+LiySw9cag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGi/NrkvowcYLkGPN6dIlPlLZVkL6PdPN0/5TIY3ttpnJh9dWnZD9dJu4EU83c80dcMKpDHKQ8FWaPOpt7FuoVQtkPYyghqur9IjLzZb2jhaZ6DZQ8Mz8UevOWUp7F51PX3qt5AlxuQMrCaMoWjp5mYukCThl63kKWeeCyMkeEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9+6gTCv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso1689466f8f.0;
        Sun, 13 Jul 2025 12:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752434026; x=1753038826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oooQh8dqRVPvirrZcwVugQF+meU4R3k+F/AmmfY0OUo=;
        b=X9+6gTCvE3iwMIQFbB3Ca8/SFnrhz5+xSLyJCGG8u1uaBGSwcFhAFFnUH4+tG2cHHz
         BgmjGCs7+aNVVoav9HxgVhbis7Glk7iXsTGJuux89zdldPqNrPVMBdHWHITnfmyHGxM4
         jLQMZGYVkyAIz51T4rMIQQTIHLpOm+nCoWlhwr5/qwE6wTUzjVeJLirGvZ3jDMCblPJB
         odReozhagg/dnrvhTuNbTaqeRtlFPKZYL0Xk/gx0SZ8HY2wnPD+nEnYvD9HC/e1DFvip
         /JuR/tkQ520ut//wjay+wUT2pR4dTd2bBrhOU36W60bJqCLBcpHHrq0GPUbNmic3i1hJ
         vLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752434026; x=1753038826;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oooQh8dqRVPvirrZcwVugQF+meU4R3k+F/AmmfY0OUo=;
        b=ezXmWN65CWct0w0073vwQb4gf5SPNGWRDha+oLPh7WRg4lDWgn0HzQSGQO1ZNIPr7t
         AjDzVKYEIPafgJmgNKANDU+1RXXPMH1FzCB5c34FXtw+CUGYJVg3zS/P45QjXDjozQl/
         XqDOKsEn3UFLFxYdE2kXYA+9kBjoVg8MTEH2bHplqwpr3KXa/ybFMCBxmDRO82+KGZfC
         wfrC6rcb2Q09A/nLNoKRvPK1RfCdusPQKsOIbAb0o6zET6MElIOcGJingVWBR2DSR+HS
         sqIf6lVRCsGXxYIyA0BUbRPf+skAYzzJ5aJ62wMoK34lsfhomu4hVoaF+X+3dv3zw3gj
         YTbg==
X-Forwarded-Encrypted: i=1; AJvYcCVbeHLi/0Ovvc/VljU+tiFDMFl0YiYhxwTSbGKPCiST1mtCkqhWZ/poF51Se3a2HaJeaWQSPzqAu2W3cyFw@vger.kernel.org, AJvYcCWtIsGdZWOEja7GSppEn12RP0zr/vMQtL0somsFJD8r7B/VKw6OFP5362aRLjd293A7TLTs5WjluWXh@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo+ljpn9lhIeud6f68zXFTrTPi8ibNylOtuI7RppHD0I85+EYk
	PpsnF3ObFxG2+QbknVlOtH+FmCVrbsSU3Nc9JwkDG2jKraCYP1PzAlE=
X-Gm-Gg: ASbGncv4sX18vapjfH9828Qps48k5ad6wXEWKPth7FomrUx8pVAIPj5JMFgSPC54l+t
	6plxxgOjzNogrbkbAD7YgSzErZKGURGM/MsUY5s1acd18Xu9vFHJ/oP4juuoMCK8iJX3i6qtYhb
	heutmdlWXBocgJhAX7kUFddXm+pl0qMx7GRP7zCnbfjqHhDepHL5mt0iGGlvrRu/RUJmX29x15V
	lOo3hl7iEiOnlyeH3/SCAEQac/0UeZgghzB7ZjPVbNCqWzjU726ohCyO6FL8jAjQMjb5YikiiZ+
	pcPjzz+iiGZqwButvUQYcNQagsK/ugiNBzZt70lSi719zm1133bp9GLFNFGKwCDOPlCe7yfbTEB
	aK38t7LtruThsYkCtkkVfMKTayYVHuADNZYK/KwEAfJCPUA8+p5WE/aNa5pUHU+owrLrbpgtZXd
	mLvB4=
X-Google-Smtp-Source: AGHT+IGNeHGBggvz35vdEjlIEqgBSfIcQabUpCb1c+vu131AXZr+/1qIYQWvMa0z8By/1rVOgsbfPw==
X-Received: by 2002:a05:6000:21c8:b0:3b5:f165:14e1 with SMTP id ffacd0b85a97d-3b5f18b41b0mr6088573f8f.38.1752434025843;
        Sun, 13 Jul 2025 12:13:45 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f13:8500:80da:6526:1e81:c18f? ([2a02:810b:f13:8500:80da:6526:1e81:c18f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45615a4551bsm23035615e9.37.2025.07.13.12.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 12:13:45 -0700 (PDT)
Message-ID: <702dc4bb-7b3c-4647-b84f-8516989b0836@gmail.com>
Date: Sun, 13 Jul 2025 21:13:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] arm64: dts: rockchip: Add ROCK 2A/2F, Sige1 and
 NanoPi Zero2
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250712173805.584586-1-jonas@kwiboo.se>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20250712173805.584586-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi list, Hi Jonas,

> This series adds dt-bindings and initial device tree for the following
> Rockchip RK3528A boards:
> - Radxa ROCK 2A/2F
> - ArmSoM Sige1
> - FriendlyElec NanoPi Zero2


this only sub-related to this series: Is there any particular reason, why
we call the compatible "rockchip,rk3528" and not "rockchip,rk3528a"? From
what I can see all boards currently supported (and those in this series)
are having the RK3528A version of the SoC. I didn't follow the development
here, but there are differences - I did a quick compare of the datasheets
of those two SoC versions - it looks like RK3528 version has USB3-DRD
controller, while RK3528A has USB3 host-only controller. Also it seems to
have different video codec IPs and the DRAM controller additionally
supports LPDDR4X.
I guess it would be good to discuss this before this series is merged,
because re-naming *.dts files after they have been in a release is somewhat
impossible.

Regards,
Alex
> 
> The bt/wifi_reg_on pins are described in the device tree using
> rfkill-gpio nodes.
> 
> Changes in v3:
> - Rename led nodes to led-0/led-1
> - Remove pinctrl* props from sdio0
> - Collect a-b tags
> 
> Changes in v2:
> - Limit sdmmc max-frequency to 100 MHz on ROCK 2A/2F
> - Drop clock-output-names prop from rtc node on Sige1 and NanoPi Zero2
> - Drop regulator-boot-on from usb 2.0 host regulators on Sige1
> - Add bluetooth and wifi nodes on Sige1
> - Collect t-b tag for NanoPi Zero2
> 
> These boards can be booted from emmc or sd-card using the U-Boot 2025.07
> generic-rk3528 target or work-in-progress patches for these boards [1].
> 
> For working bluetooth on ArmSoM Sige1 the patch "arm64: dts: rockchip:
> Fix UART DMA support for RK3528" [2] is required.
> 
> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528
> [2] https://lore.kernel.org/r/20250709210831.3170458-1-jonas@kwiboo.se
> 
> Jonas Karlman (6):
>    dt-bindings: arm: rockchip: Add Radxa ROCK 2A/2F
>    arm64: dts: rockchip: Add Radxa ROCK 2A/2F
>    dt-bindings: arm: rockchip: Add ArmSoM Sige1
>    arm64: dts: rockchip: Add ArmSoM Sige1
>    dt-bindings: arm: rockchip: Add FriendlyElec NanoPi Zero2
>    arm64: dts: rockchip: Add FriendlyElec NanoPi Zero2
> 
>   .../devicetree/bindings/arm/rockchip.yaml     |  17 +
>   arch/arm64/boot/dts/rockchip/Makefile         |   4 +
>   .../boot/dts/rockchip/rk3528-armsom-sige1.dts | 465 ++++++++++++++++++
>   .../boot/dts/rockchip/rk3528-nanopi-zero2.dts | 340 +++++++++++++
>   .../boot/dts/rockchip/rk3528-rock-2.dtsi      | 293 +++++++++++
>   .../boot/dts/rockchip/rk3528-rock-2a.dts      |  82 +++
>   .../boot/dts/rockchip/rk3528-rock-2f.dts      |  10 +
>   7 files changed, 1211 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dts
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-nanopi-zero2.dts
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
> 


