Return-Path: <linux-kernel+bounces-729180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FE2B032DC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 22:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6AD77A2DB8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 20:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA88D2882B7;
	Sun, 13 Jul 2025 20:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="rSAtKDyq"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9C8281513
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 20:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752437659; cv=none; b=I5jpr89kAVCDeHZDIgKlSrqo1Wwvnynk4w8tlruH0bamNo6tpcs7kXEbUfZ5tLk1f7We/EHWk/nPLg6zDukcginvRa2KzQxx6OzPzDOQ6Ho5WMP5l8m7ZKW9m9pSua/pZLI06VqmRwfjir3EJU8MEe/Yja6oTkgqwE732bsujAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752437659; c=relaxed/simple;
	bh=BN4bZzKyAGnUpxNNYUJzY+9AYLPqzKsfs7yx8xV6g74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RTlNCta2w0cgpE4AxfmIyGCCSe5RB+hQGTC+IJb9+/H9Iw82QCGHKetDYDs71mRlfNCCNLQlPpdTm21eBxWqkOZ6u3wZvg6ykTpuUnBVc5V7BrhbNWkywvYLRgQ+Iu/W50049slUSP0B7a3+oWkfKyVm1B1lg30zjCdPRnH181E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=rSAtKDyq; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1752437649;
 bh=4U+mcZEzIP2ITFV/NhCq+SDVBQUz67IM7MGDWjmhx2c=;
 b=rSAtKDyqBvW3G8PN5DD57nFwUE//WHDiLBslqRO0nnhRElQfQIJb2tM0EAfZWjcsRJ9clorK9
 k+Pdh2mZvcOp2wyN5jNyfmIlJm7ODR4gwwvCc7pBsauecbEc42+Za1nyIR7jzlj5yPgQz5dVxGN
 UYg1wXAnPaRWmCLsSkgH20iKXNOibFPHTsgschp6LeyNTpPieicusmivdRnp8ihJA7uC2kGNOPK
 wMDF9BElis7fDtCxqzRAwpxJw+T9EaA/m/QbyIMDQv5noIDHUfmkaVg5E0H+asxbgh6QjVPxI2y
 FMoPMmNFdGii58jBrmcMN1tTgyWMT+Omzvs26bSUAIOQ==
X-Forward-Email-ID: 6874138a1bd28f931143727b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <9aae8b30-23ae-4866-9ce8-02bbc8b44a82@kwiboo.se>
Date: Sun, 13 Jul 2025 22:13:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] arm64: dts: rockchip: Add ROCK 2A/2F, Sige1 and
 NanoPi Zero2
To: Alex Bee <knaerzche@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>,
 Chukun Pan <amadeus@jmu.edu.cn>, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250712173805.584586-1-jonas@kwiboo.se>
 <702dc4bb-7b3c-4647-b84f-8516989b0836@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <702dc4bb-7b3c-4647-b84f-8516989b0836@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alex,

On 7/13/2025 9:13 PM, Alex Bee wrote:
> Hi list, Hi Jonas,
> 
>> This series adds dt-bindings and initial device tree for the following
>> Rockchip RK3528A boards:
>> - Radxa ROCK 2A/2F
>> - ArmSoM Sige1
>> - FriendlyElec NanoPi Zero2
> 
> 
> this only sub-related to this series: Is there any particular reason, why
> we call the compatible "rockchip,rk3528" and not "rockchip,rk3528a"? From
> what I can see all boards currently supported (and those in this series)
> are having the RK3528A version of the SoC. I didn't follow the development
> here, but there are differences - I did a quick compare of the datasheets
> of those two SoC versions - it looks like RK3528 version has USB3-DRD
> controller, while RK3528A has USB3 host-only controller. Also it seems to
> have different video codec IPs and the DRAM controller additionally
> supports LPDDR4X.

What datasheet versions did you check? I can only find:
- RK3528 Rev 1.0 (2023-05-22)
- RK3528A Rev 1.2 (2024-04-10)

And both list LPDDR4X support and the A-variant seem to list USB3-DRD
support, did you mix them up above?

I think these SoCs are similar to rk3228/rk3229, rk3228h/rk3328 and now
rk3528/rk3528a, in that only the second variant support VP9 decoding.

Use of rockchip,rk3528a compatible could be something to change,
could also be something that bootloader set at runtime, similar to
what it does for rk3288w.

> I guess it would be good to discuss this before this series is merged,
> because re-naming *.dts files after they have been in a release is somewhat
> impossible.

I think renaming the device tree files is unnecessary, as there seem to
be very little difference. All boards I have come across are currently
RK3528A variants. How would we treat the Radxa E20C?, it is not named
rk3528-radxa-e20c.dtb, yet uses the A-variant.

For mainline U-Boot I have included printing out the SoC-variant,
however the compatible is not adjusted:

  Model: Radxa E20C
  SoC:   RK3528A
  DRAM:  2 GiB

Regards,
Jonas

> 
> Regards,
> Alex
>>
>> The bt/wifi_reg_on pins are described in the device tree using
>> rfkill-gpio nodes.
>>
>> Changes in v3:
>> - Rename led nodes to led-0/led-1
>> - Remove pinctrl* props from sdio0
>> - Collect a-b tags
>>
>> Changes in v2:
>> - Limit sdmmc max-frequency to 100 MHz on ROCK 2A/2F
>> - Drop clock-output-names prop from rtc node on Sige1 and NanoPi Zero2
>> - Drop regulator-boot-on from usb 2.0 host regulators on Sige1
>> - Add bluetooth and wifi nodes on Sige1
>> - Collect t-b tag for NanoPi Zero2
>>
>> These boards can be booted from emmc or sd-card using the U-Boot 2025.07
>> generic-rk3528 target or work-in-progress patches for these boards [1].
>>
>> For working bluetooth on ArmSoM Sige1 the patch "arm64: dts: rockchip:
>> Fix UART DMA support for RK3528" [2] is required.
>>
>> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528
>> [2] https://lore.kernel.org/r/20250709210831.3170458-1-jonas@kwiboo.se
>>
>> Jonas Karlman (6):
>>    dt-bindings: arm: rockchip: Add Radxa ROCK 2A/2F
>>    arm64: dts: rockchip: Add Radxa ROCK 2A/2F
>>    dt-bindings: arm: rockchip: Add ArmSoM Sige1
>>    arm64: dts: rockchip: Add ArmSoM Sige1
>>    dt-bindings: arm: rockchip: Add FriendlyElec NanoPi Zero2
>>    arm64: dts: rockchip: Add FriendlyElec NanoPi Zero2
>>
>>   .../devicetree/bindings/arm/rockchip.yaml     |  17 +
>>   arch/arm64/boot/dts/rockchip/Makefile         |   4 +
>>   .../boot/dts/rockchip/rk3528-armsom-sige1.dts | 465 ++++++++++++++++++
>>   .../boot/dts/rockchip/rk3528-nanopi-zero2.dts | 340 +++++++++++++
>>   .../boot/dts/rockchip/rk3528-rock-2.dtsi      | 293 +++++++++++
>>   .../boot/dts/rockchip/rk3528-rock-2a.dts      |  82 +++
>>   .../boot/dts/rockchip/rk3528-rock-2f.dts      |  10 +
>>   7 files changed, 1211 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dts
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-nanopi-zero2.dts
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
>>
> 


