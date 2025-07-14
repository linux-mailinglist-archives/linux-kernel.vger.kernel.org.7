Return-Path: <linux-kernel+bounces-729223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBC2B0338C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 02:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB66174F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 00:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CF2322A;
	Mon, 14 Jul 2025 00:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="DOr7V3q+"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55126360
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752451461; cv=none; b=LWzv8OC+8UWn0GdGPXDiQlpuvAJ66FbdxRuVwY114+IQN9Uz8rS91jYzi0A2S/Ygam9t/V6cYIC5D8LVHW8OCOHnHwfyulFGGJ+EBNq1v+7ofF8T5eutp1Wm0HAtkT5n6wY3AaB3K89Bd+8aPw0fKDzZF6rYJ+R96TYJlAbQBHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752451461; c=relaxed/simple;
	bh=JHgv0USbm9wcIZSV+I50kTz5M7xY8oq6+TS1ZEEC3WM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hH89FDlNDKHzAETsPgC4smqqts1L4pvC141D/yiqG09UsN59UyGI+t6gvyCDJoQn/UqeyLjMkeHV/XUgw2h/cIdo2wD6nMxEIcD8pTpXeit7CaycPNPWqeMtO2u4FjnMTzovoh1fTV5L5cSsd/lqByjWKHB6fUknbsmwDmJywOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=DOr7V3q+; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1752451458;
 bh=09+tGkfgsm4KwscqPR7hMZNk1h0y9NoFhShrUUaWQ88=;
 b=DOr7V3q+a2zy1CBy8rxSxoWD7UOBIMDX8bhGGQUrf3e+Yk56pFwVPZvj9jqaKrpB4tfGssshB
 FQ7MlrjcS/WtFHdmMHMi5bE6mUPk3pKbM2Fpek6ewTY9RflAzZE9fyEHGZY8hTW4vhBrZgOMKtw
 fk4URoIwuXPf9cz5orQpWH0NcgrDkd+SRq+SBbktXKU3l6FkPIJ35ix+nWADA7QYqnILHJOWId2
 vlpiN86e6/AOFfyJLzk8G+w1EJgsM0qmFDS7/kLO/K4iFunVKDkpTfmEFEVknklXdTmrNDQyO6c
 XoW7UhLbAUv8YD4q8ITwFWN80iS1AePknJgF8nxaIj9Q==
X-Forward-Email-ID: 687449765bca601a1a1d3609
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <16d99271-ba04-4ce1-a335-fab1917637c7@kwiboo.se>
Date: Mon, 14 Jul 2025 02:04:01 +0200
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
 <9aae8b30-23ae-4866-9ce8-02bbc8b44a82@kwiboo.se>
 <88c7b90d-4c29-453b-9a5c-9679b371a3a9@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <88c7b90d-4c29-453b-9a5c-9679b371a3a9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alex,

On 7/13/2025 10:56 PM, Alex Bee wrote:
> Hi Jonas,
> 
>> Hi Alex,
>>
>> On 7/13/2025 9:13 PM, Alex Bee wrote:
>>> Hi list, Hi Jonas,
>>>
>>>> This series adds dt-bindings and initial device tree for the following
>>>> Rockchip RK3528A boards:
>>>> - Radxa ROCK 2A/2F
>>>> - ArmSoM Sige1
>>>> - FriendlyElec NanoPi Zero2
>>>
>>> this only sub-related to this series: Is there any particular reason, why
>>> we call the compatible "rockchip,rk3528" and not "rockchip,rk3528a"? From
>>> what I can see all boards currently supported (and those in this series)
>>> are having the RK3528A version of the SoC. I didn't follow the development
>>> here, but there are differences - I did a quick compare of the datasheets
>>> of those two SoC versions - it looks like RK3528 version has USB3-DRD
>>> controller, while RK3528A has USB3 host-only controller. Also it seems to
>>> have different video codec IPs and the DRAM controller additionally
>>> supports LPDDR4X.
>> What datasheet versions did you check? I can only find:
>> - RK3528 Rev 1.0 (2023-05-22)
>> - RK3528A Rev 1.2 (2024-04-10)
> I used
> 
> 2023-07-12 Revision V1.0
> 
> which didn't include these features - which is interesting: Why would a
> SoC vendor not try to sell all features in the first place :)
> 
> But I now double checked in
> 
> 2025-05-12 Revision 1.4
> 
> and you are right: It appears there also for RK3528A.
> 
> The only difference I could now make out by comparing v1.4 of both versions
> is the cipher engine: RK3528 additionally supports "SM2/SM3/SM4 cipher" -
> but still it exists and additionally the different video codec (if mpp
> userspace library is correct about that).
> 
> Anyway: My question was more about: Why didn't we choose the correct
> compatible from the beginning? And of course the dts files would have to be
> renamed if the compatible is changed, as they are named according to their
> SoC-compatible.

Not sure, possible due to lack of technical documentation for this SoC,
to my knowledge all upstream development has been done without any
access to a TRM for the SoC.

Based on vendor code (u-boot and linux) there does not seem to be
anything special about the A-variant, so my thinking has always been
that the A-variant may have just been an updated/fixed hw revision and
is the version that went into newer production devices.

The recently released U-Boot 2025.07 is referencing the filename
rk3528-radxa-e20c.dtb from the synced devicetree-rebasing tree. So a
possible rename will affect a future release of U-Boot, and possible
devices in the field depending on when a rename would land in linux.

For this series I tried to just follow what is currently used for the
Radxa E20C.

If I am correct there is now also a RK3518 tvbox variant of this SoC,
do not know how that would fit into all this :-S

Regards,
Jonas

> 
> Regards,
> Alex
>>
>> And both list LPDDR4X support and the A-variant seem to list USB3-DRD
>> support, did you mix them up above?
>>
>> I think these SoCs are similar to rk3228/rk3229, rk3228h/rk3328 and now
>> rk3528/rk3528a, in that only the second variant support VP9 decoding.
>>
>> Use of rockchip,rk3528a compatible could be something to change,
>> could also be something that bootloader set at runtime, similar to
>> what it does for rk3288w.
>>
>>> I guess it would be good to discuss this before this series is merged,
>>> because re-naming *.dts files after they have been in a release is somewhat
>>> impossible.
>> I think renaming the device tree files is unnecessary, as there seem to
>> be very little difference. All boards I have come across are currently
>> RK3528A variants. How would we treat the Radxa E20C?, it is not named
>> rk3528-radxa-e20c.dtb, yet uses the A-variant.
>>
>> For mainline U-Boot I have included printing out the SoC-variant,
>> however the compatible is not adjusted:
>>
>>    Model: Radxa E20C
>>    SoC:   RK3528A
>>    DRAM:  2 GiB
>>
>> Regards,
>> Jonas
>>
>>> Regards,
>>> Alex
>>>> The bt/wifi_reg_on pins are described in the device tree using
>>>> rfkill-gpio nodes.
>>>>
>>>> Changes in v3:
>>>> - Rename led nodes to led-0/led-1
>>>> - Remove pinctrl* props from sdio0
>>>> - Collect a-b tags
>>>>
>>>> Changes in v2:
>>>> - Limit sdmmc max-frequency to 100 MHz on ROCK 2A/2F
>>>> - Drop clock-output-names prop from rtc node on Sige1 and NanoPi Zero2
>>>> - Drop regulator-boot-on from usb 2.0 host regulators on Sige1
>>>> - Add bluetooth and wifi nodes on Sige1
>>>> - Collect t-b tag for NanoPi Zero2
>>>>
>>>> These boards can be booted from emmc or sd-card using the U-Boot 2025.07
>>>> generic-rk3528 target or work-in-progress patches for these boards [1].
>>>>
>>>> For working bluetooth on ArmSoM Sige1 the patch "arm64: dts: rockchip:
>>>> Fix UART DMA support for RK3528" [2] is required.
>>>>
>>>> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528
>>>> [2] https://lore.kernel.org/r/20250709210831.3170458-1-jonas@kwiboo.se
>>>>
>>>> Jonas Karlman (6):
>>>>     dt-bindings: arm: rockchip: Add Radxa ROCK 2A/2F
>>>>     arm64: dts: rockchip: Add Radxa ROCK 2A/2F
>>>>     dt-bindings: arm: rockchip: Add ArmSoM Sige1
>>>>     arm64: dts: rockchip: Add ArmSoM Sige1
>>>>     dt-bindings: arm: rockchip: Add FriendlyElec NanoPi Zero2
>>>>     arm64: dts: rockchip: Add FriendlyElec NanoPi Zero2
>>>>
>>>>    .../devicetree/bindings/arm/rockchip.yaml     |  17 +
>>>>    arch/arm64/boot/dts/rockchip/Makefile         |   4 +
>>>>    .../boot/dts/rockchip/rk3528-armsom-sige1.dts | 465 ++++++++++++++++++
>>>>    .../boot/dts/rockchip/rk3528-nanopi-zero2.dts | 340 +++++++++++++
>>>>    .../boot/dts/rockchip/rk3528-rock-2.dtsi      | 293 +++++++++++
>>>>    .../boot/dts/rockchip/rk3528-rock-2a.dts      |  82 +++
>>>>    .../boot/dts/rockchip/rk3528-rock-2f.dts      |  10 +
>>>>    7 files changed, 1211 insertions(+)
>>>>    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dts
>>>>    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-nanopi-zero2.dts
>>>>    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
>>>>    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
>>>>    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
>>>>


