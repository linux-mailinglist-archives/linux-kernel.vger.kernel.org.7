Return-Path: <linux-kernel+bounces-809304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC61B50BB0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1CE1C63EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE9D253932;
	Wed, 10 Sep 2025 02:45:03 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867B6246760;
	Wed, 10 Sep 2025 02:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472302; cv=none; b=ArbB5zAMfniZdxEg1M4gyzpmpa3wmiKLgY1j/0Yt1/xexM74qNYtzTuy9EEoYtFTQxxo9H6vF6USzflxKEIk8QkKziJdyKaVEHNVcqq3MPAmQqsoL/sU6aJ3WUZ/DpBIS0hIOi70SyJbqLPzdV+rUnh6a79TrJjvRjjroxQdlaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472302; c=relaxed/simple;
	bh=c2GgqaCCU6MCybKkX3fh3H6ioby4mdMWd3h6PdjqnKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J90YeEjfA8URbEyzBuen171NF3DOcsI9nobUngk28Bb7PopepqpqOfF0OgufXNax9C4b5dPXFT8eEeZZufkOe3nn1KZ1TxGWJCtcovxaL21v3csBLf1hf3OhqHbmEXKMwqXtPtYNhwl09q85W47HirPWYumnFA3t2RIhXSecY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1757472216t68456359
X-QQ-Originating-IP: 17bfSa2F654IBMiotK29/iMQ0Y0VqjXIV2xOVHSsz2c=
Received: from [IPV6:240f:10b:7440:1:e5ed:636d ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Sep 2025 10:43:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1856156394840416114
Message-ID: <AF1546E3BE23C6D5+08234a44-4321-45da-9c74-5690f3437e03@radxa.com>
Date: Wed, 10 Sep 2025 11:43:30 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Radxa E24C
To: Jonas Karlman <jonas@kwiboo.se>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>,
 Chukun Pan <amadeus@jmu.edu.cn>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250727144409.327740-1-jonas@kwiboo.se>
 <B055BC95C67D129C+d7a2ff39-8367-48cf-8697-f12fd9f885a4@radxa.com>
 <7d3c3b29-f89f-4801-8fd7-d6d0645095af@kwiboo.se> <17232684.geO5KgaWL5@diego>
 <a443fca9-e660-4a7a-b637-ec840ac8ed1e@kwiboo.se>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <a443fca9-e660-4a7a-b637-ec840ac8ed1e@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NDtUtlvFer7vF80qLC4s/JK3islawpqQwIo1XTtrY7c+MywMujiMYhNh
	/5vTvNeKr3IptPQTnhzXcbxrMkLyNiiWb82VcyIUyaeEPDxX7YbIJPN+9gSDUaQfUkBaxcD
	EJXpigyyzk7US7RwWXQoJwvKqJoYgYidl5VI+qY9/vEdvVwq33cLKn2CNiBIJyFLm1GCF1C
	/5dQmdnQZeJYWFP3IkEBjZph1ZfISnvA/f7h3sBfVGs3Csb8NE336SkndWkZR8nXDQQk3tk
	gjumFae8smy+rETr+2L25FdzVX3tTXEtVXjRTPbUkP/ViuYGutLh1N2CmrBaMWg3zpWpvNj
	YG+5LkfOn8y23bvfvBJ002uGcRVp2h2KbmQgFrqgllkwKbefTVxsPT/SxpCZByn4DQaaF1T
	VegZyJoOuGXd8j3TjAAuYJRpGiEuuPIJH037TKdozH2REIynME6SXg08dztLnPkSRI7TGKk
	AuW5t/ehbsj83nzyaMXVqbZzZYvcrabURHmGTpAz13YRC09XiVg/k5feWSIcwuOzkkJIJn6
	YjuFAjd3jK49BgYeVJXalp0vJmWWwRz81Z36EVxDd5IHYcWThn/JG0ejVMZmwXmTY2Gtd0P
	fELJ/SSuEjuYJfg/PMfRLRmrmoma1MOm5wK8q5rZKQMd+gWBohHvog5K3You1JnrgW0fL9T
	bMbRbtYoh16GsRHkZwVdL4a3rJzar2KrCzl1xC1dcAmHGAwF3FQmQ1cevDmJ2OaBjPksfki
	A4W2YPnpzylrJXQ/mML+2sEx3ZTR4h+cdSUrU5b3WNmw7cgOgn1MsPVe4gzdVYfveNsxDed
	8xL2lLnq73YT01B373CZmZXF5zWkw/Rv+wAhNX07wx6WSsmComnrWHju9RoTiuBOxCx8G34
	S5bXweQJxujbGyAa+kGMQbZOv94kLMs4CvXVi7LfdAqWaTg1NSR+04AGdwbyjq5dXU0Ae0Q
	CxIgiaarNTR86Db1+kstUTXuuV9Sg49FY+vJ9EQj/evJP1UtsroQVWj+A
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Hi Jonas, Heiko,

On 9/10/25 04:36, Jonas Karlman wrote:
> On 9/9/2025 5:39 PM, Heiko Stübner wrote:
>> Am Dienstag, 9. September 2025, 16:48:25 Mitteleuropäische Sommerzeit schrieb Jonas Karlman:
>>> On 9/9/2025 2:28 PM, FUKAUMI Naoki wrote:
>>>> Hi Jonas,
>>>>
>>>> On 7/27/25 23:44, Jonas Karlman wrote:
>>>>> The Radxa E24C is a compact, high-performance network computer
>>>>> developed by Radxa, based on the Rockchip RK3528A SoC.
>>>>>
>>>>> Add initial device tree for the Radxa E24C.
>>>>>
>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>>>> ---
>>>>> Schematics: https://dl.radxa.com/e/e24c/docs/radxa_e24c_v1200_schematic.pdf
>>>>> ---
>>>>>    arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>>>>>    .../boot/dts/rockchip/rk3528-radxa-e24c.dts   | 519 ++++++++++++++++++
>>>>>    2 files changed, 520 insertions(+)
>>>>>    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
>>>>> index 0662fcf00628..dc62fd5305be 100644
>>>>> --- a/arch/arm64/boot/dts/rockchip/Makefile
>>>>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
>>>>> @@ -92,6 +92,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
>>>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-armsom-sige1.dtb
>>>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-nanopi-zero2.dtb
>>>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-radxa-e20c.dtb
>>>>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-radxa-e24c.dtb
>>>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-rock-2a.dtb
>>>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-rock-2f.dtb
>>>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3562-evb2-v10.dtb
>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts
>>>>> new file mode 100644
>>>>> index 000000000000..225f2b0c5339
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts
>>>>> @@ -0,0 +1,519 @@
>>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>>> +
>>>>> +/dts-v1/;
>>>>> +
>>>>> +#include <dt-bindings/input/input.h>
>>>>> +#include <dt-bindings/leds/common.h>
>>>>> +#include "rk3528.dtsi"
>>>>> +
>>>>> +/ {
>>>>> +	model = "Radxa E24C";
>>>>> +	compatible = "radxa,e24c", "rockchip,rk3528";
>>>>> +
>>>>> +	aliases {
>>>>> +		ethernet0 = &gmac1;
>>>>> +		i2c0 = &i2c0;
>>>>> +		i2c1 = &i2c1;
>>>>> +		i2c5 = &i2c5;
>>>>> +		mmc0 = &sdhci;
>>>>> +		mmc1 = &sdmmc;
>>>>> +		rtc0 = &hym8563;
>>>>> +		rtc1 = &rk805;
>>>>> +		serial0 = &uart0;
>>>>> +	};
>>>>> +
>>>>> +	chosen {
>>>>> +		stdout-path = "serial0:1500000n8";
>>>>> +	};
>>>>> +
>>>>> +	adc-keys {
>>>>> +		compatible = "adc-keys";
>>>>> +		io-channels = <&saradc 0>;
>>>>> +		io-channel-names = "buttons";
>>>>> +		keyup-threshold-microvolt = <1800000>;
>>>>> +		poll-interval = <100>;
>>>>> +
>>>>> +		button-maskrom {
>>>>> +			label = "MASKROM";
>>>>> +			linux,code = <KEY_SETUP>;
>>>>> +			press-threshold-microvolt = <0>;
>>>>> +		};
>>>>> +	};
>>>>> +
>>>>> +	gpio-keys {
>>>>> +		compatible = "gpio-keys";
>>>>> +		pinctrl-names = "default";
>>>>> +		pinctrl-0 = <&gpio0_a0_user>;
>>>>> +
>>>>> +		button-user {
>>>>> +			gpios = <&gpio0 RK_PA0 GPIO_ACTIVE_LOW>;
>>>>> +			label = "USER";
>>>>> +			linux,code = <BTN_1>;
>>>>
>>>> I prefer to assign BTN_0 to the 1st button :)
>>>
>>> The E20C (and other RK boards) already use BTN_1 for user button, it
>>> only seem to be the recently added E54C that is using BTN_0.
>>>
>>> For consistency I suggest we keep using BTN_1 for this user button and
>>> possible fixup E54C, if you want to use same button for all variants.
>>
>> Yep, that would also keep the amount of userspace-facing changes
>> minimal.
> 
> I mixed up e54c and e52c so my statement was not fully correct above,
> however there is a mixed use of BTN_1 and BTN_0 for user button:
> 
> - rk3588s-nanopi-r6c/r6s uses BTN_1, added in v6.9-rc1
> - rk3588-friendlyelec-cm3588-nas uses BTN_1, added in v6.11-rc1
> - rk3582-radxa-e52c uses BTN_0, added in v6.14-rc1
> - rk3528-radxa-e20c uses BTN_1, added in v6.15-rc1
> - rk3576-nanopi-m5 uses BTN_1, added in v6.17-rc1
> 
> Majority seem to be using BTN_1 for a user button.

If we can unify to BTN_1 even if it breaks backward compatibility, I 
wouldn't be opposed to it.

(I remember a "sync with others" patch being rejected in the past, but I 
might be remembering it wrong.)

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Regards,
> Jonas
> 
>>
>> Heiko
>>
>>
>>
> 
> 


