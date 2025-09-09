Return-Path: <linux-kernel+bounces-808460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8730B50003
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286634E2D02
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E73350D43;
	Tue,  9 Sep 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="PCwmCMC/"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58B2350824
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429322; cv=none; b=f7QouEbU98SfonoE0tpSt55ZfCXZlIZvdhS4u8i+JZEUE851C+eRZmpZV8PR2pXk4ueUnLrCNA9B4OooR4b6IrXyRqvMuMnKRXKyk8dmcOp1mVWJYaPKQl+zOMoVuspGDa7jl3+UNAEhkzM50URs3fUuEnlOwY+JfGEl5p29/bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429322; c=relaxed/simple;
	bh=P7x9255MnfuiYafmjHNbXRip9GN7mHNwfnJnWg28lP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fV3OKA9NDzydBzxwR3WhrzmAEGmQTCBurdgvdMmhPIv8it/cspaqbYVEjmbHWTeY0WArpi6L6XCwv7MNmH9y7tob5JobWTyLgY5SLv+7kw4a17sFKI4RYiTTOW2R4yUaCXvrfu3QENAAqE6CazFGBHYG0CBwXwJDLLRFyonOh4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=PCwmCMC/; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1757429315;
 bh=n77eKdHmtRFhvCg5KGI+mU9uC0njog5zrjYXHjKe4bc=;
 b=PCwmCMC/0U5vPcfCf2Hpk9ZcKRtETlcYpM33uzLOHF73clp9zNhNzEtzDB8T+UBgZMXxjWiP9
 7SQiHm/pWDAqPrzkInnTMx85DjwVIhxZEbsn0im5CW2bfxRwwohSaBaAF80hcYDXZ1paw3GfCiZ
 ZkMfmunqCao8O7ZmxIXzmNzUJ7vm8Fi/YA6ErfN7OXFcEFcd2FPWq0aeu077b2+k7fpS6fld6YX
 HdUlvO2F5D2qLLmHN/tZik96iavynIQu6KpKeYfwCtq2116wTnj6U8P2QJKohofOc6qtIG0hc3Q
 bfTPkUmZV+/HPQFbnQwesoAaRhqO5h/TkXI7mIH+b7Sw==
X-Forward-Email-ID: 68c03e3e13ca9ca995732310
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.14
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <7d3c3b29-f89f-4801-8fd7-d6d0645095af@kwiboo.se>
Date: Tue, 9 Sep 2025 16:48:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Radxa E24C
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>,
 Chukun Pan <amadeus@jmu.edu.cn>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250727144409.327740-1-jonas@kwiboo.se>
 <20250727144409.327740-4-jonas@kwiboo.se>
 <B055BC95C67D129C+d7a2ff39-8367-48cf-8697-f12fd9f885a4@radxa.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <B055BC95C67D129C+d7a2ff39-8367-48cf-8697-f12fd9f885a4@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/2025 2:28 PM, FUKAUMI Naoki wrote:
> Hi Jonas,
> 
> On 7/27/25 23:44, Jonas Karlman wrote:
>> The Radxa E24C is a compact, high-performance network computer
>> developed by Radxa, based on the Rockchip RK3528A SoC.
>>
>> Add initial device tree for the Radxa E24C.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> ---
>> Schematics: https://dl.radxa.com/e/e24c/docs/radxa_e24c_v1200_schematic.pdf
>> ---
>>   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>>   .../boot/dts/rockchip/rk3528-radxa-e24c.dts   | 519 ++++++++++++++++++
>>   2 files changed, 520 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
>> index 0662fcf00628..dc62fd5305be 100644
>> --- a/arch/arm64/boot/dts/rockchip/Makefile
>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
>> @@ -92,6 +92,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-armsom-sige1.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-nanopi-zero2.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-radxa-e20c.dtb
>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-radxa-e24c.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-rock-2a.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-rock-2f.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3562-evb2-v10.dtb
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts
>> new file mode 100644
>> index 000000000000..225f2b0c5339
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts
>> @@ -0,0 +1,519 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/leds/common.h>
>> +#include "rk3528.dtsi"
>> +
>> +/ {
>> +	model = "Radxa E24C";
>> +	compatible = "radxa,e24c", "rockchip,rk3528";
>> +
>> +	aliases {
>> +		ethernet0 = &gmac1;
>> +		i2c0 = &i2c0;
>> +		i2c1 = &i2c1;
>> +		i2c5 = &i2c5;
>> +		mmc0 = &sdhci;
>> +		mmc1 = &sdmmc;
>> +		rtc0 = &hym8563;
>> +		rtc1 = &rk805;
>> +		serial0 = &uart0;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:1500000n8";
>> +	};
>> +
>> +	adc-keys {
>> +		compatible = "adc-keys";
>> +		io-channels = <&saradc 0>;
>> +		io-channel-names = "buttons";
>> +		keyup-threshold-microvolt = <1800000>;
>> +		poll-interval = <100>;
>> +
>> +		button-maskrom {
>> +			label = "MASKROM";
>> +			linux,code = <KEY_SETUP>;
>> +			press-threshold-microvolt = <0>;
>> +		};
>> +	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&gpio0_a0_user>;
>> +
>> +		button-user {
>> +			gpios = <&gpio0 RK_PA0 GPIO_ACTIVE_LOW>;
>> +			label = "USER";
>> +			linux,code = <BTN_1>;
> 
> I prefer to assign BTN_0 to the 1st button :)

The E20C (and other RK boards) already use BTN_1 for user button, it
only seem to be the recently added E54C that is using BTN_0.

For consistency I suggest we keep using BTN_1 for this user button and
possible fixup E54C, if you want to use same button for all variants.

Regards,
Jonas

> 
> Best regards,
> 
> --
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.
> 
>> +			wakeup-source;
>> +		};
>> +	};

[snip]

