Return-Path: <linux-kernel+bounces-822634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ED3B845BA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356ED4A4171
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B346302179;
	Thu, 18 Sep 2025 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="elkMJm4M"
Received: from mail-m3290.qiye.163.com (mail-m3290.qiye.163.com [220.197.32.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D283303C9F;
	Thu, 18 Sep 2025 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194948; cv=none; b=dawTaAtzZTUgTzeTh09NNi8C81LEQpJbSPnk9K7yudl+fVt28QtDKQZex9Hs6t8ykbT5XP4lNSVWPTRMvbW8/MhxQR2MrwrWR2rEcFrTFLgLUh6TojXHkzjVmt0rT4h00XABZ1Wr9BD5Ux4C7h14MecGTUpELy4ycHAIsKks6Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194948; c=relaxed/simple;
	bh=vQI2TjYREI6b2KyqLW/S/h5Czv3Jrz2pSsHWszwquyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gd6td7WAzrcObSro6MOrYAZ+21t6mi/6pZwk5Zyz2dSuJ6dYjuwclPEv6QWDnpIzItxcOh18kfVQe4KH4emu+2Dg0VYesv7kzo+INcX3tAjXxxcGOn4cqzzQHqgKW3h8JQP59+i8DyGLVhiO3QpqYNTMjXGbzQ0ycHD2d3AMMXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=elkMJm4M; arc=none smtp.client-ip=220.197.32.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.153] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 23446c063;
	Thu, 18 Sep 2025 19:28:53 +0800 (GMT+08:00)
Message-ID: <404b35bb-e32b-4830-8d34-d0cfd0a262ff@rock-chips.com>
Date: Thu, 18 Sep 2025 19:28:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: rockchip: Enable DisplayPort for
 rk3588-evb2
To: Quentin Schulz <quentin.schulz@cherry.de>, Chaoyi Chen
 <kernel@airkyi.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 FUKAUMI Naoki <naoki@radxa.com>, Jonas Karlman <jonas@kwiboo.se>,
 Peter Robinson <pbrobinson@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250918062825.194-1-kernel@airkyi.com>
 <ecc96b5a-2062-43f4-9959-b4e2b126d9f3@cherry.de>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <ecc96b5a-2062-43f4-9959-b4e2b126d9f3@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a995c959e2a03abkunmced0bb073b07de
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0kYTlYZTUNCSE9DTktNShhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=elkMJm4McaadIkkxl9fxLZoKq6Ze48UUrVlEjcI3WVLV40memdMgXm0I6AlCiX9ppEReD/3c/Nm7xJFq6PpWmPM2GkBysoDpOXA7mmd0Zi3S9um4ewP5ED4b9LA5oLOuzjAq6qC//pV6KmZVkqUt5oA+K/XdNzWO1RJv+q3qbuo=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=oRwpANH20f3O41DZeZFj63uF99IcxizRzfbRD2S6WOw=;
	h=date:mime-version:subject:message-id:from;

Hi Quentin,

On 9/18/2025 6:39 PM, Quentin Schulz wrote:
> Hi Chaoyi Chen,
>
> On 9/18/25 8:28 AM, Chaoyi Chen wrote:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> The rk3588 evb2 board has a full size DisplayPort connector, enable
>> for it.
>>
>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>> ---
>>
>> Changes in v2:
>>
>> - Link to V1: https://lore.kernel.org/all/20250916080802.125-1-kernel@airkyi.com/
>> - Fix invalid DP connector type
>> - Add more comment about dclk_vp2 parent clock
>>
>>   .../boot/dts/rockchip/rk3588-evb2-v10.dts     | 48 +++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts
>> index 91fe810d38d8..60ba6ac55b23 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts
>> @@ -25,6 +25,18 @@ chosen {
>>           stdout-path = "serial2:1500000n8";
>>       };
>>   +    dp-con {
>> +        compatible = "dp-connector";
>> +        label = "DP OUT";
>> +        type = "full-size";
>> +
>> +        port {
>> +            dp_con_in: endpoint {
>> +                remote-endpoint = <&dp0_out_con>;
>> +            };
>> +        };
>> +    };
>> +
>>       hdmi-con {
>>           compatible = "hdmi-connector";
>>           type = "a";
>> @@ -106,6 +118,24 @@ vcc5v0_usbdcin: regulator-vcc5v0-usbdcin {
>>       };
>>   };
>>   +&dp0 {
>> +    pinctrl-0 = <&dp0m0_pins>;
>> +    pinctrl-names = "default";
>> +    status = "okay";
>> +};
>> +
>> +&dp0_in {
>> +    dp0_in_vp2: endpoint {
>> +        remote-endpoint = <&vp2_out_dp0>;
>> +    };
>> +};
>> +
>> +&dp0_out {
>> +    dp0_out_con: endpoint {
>> +        remote-endpoint = <&dp_con_in>;
>> +    };
>> +};
>> +
>>   &gpu {
>>       mali-supply = <&vdd_gpu_s0>;
>>       sram-supply = <&vdd_gpu_mem_s0>;
>> @@ -916,6 +946,17 @@ &usb_host1_xhci {
>>   };
>>     &vop {
>> +    /*
>> +     * If no dedicated PLL was specified, the GPLL would be automatically
>> +     * assigned as the PLL source for dclk_vop2. As the frequency of GPLL
>> +     * is 1188 MHz, we can only get typical clock frequencies such as
>> +     * 74.25MHz, 148.5MHz, 297MHz, 594MHz.
>> +     *
>> +     * So here we set the parent clock of VP2 to V0PLL so that we can get
>> +     * any frequency.
>> +     */
>> +    assigned-clocks = <&cru DCLK_VOP2_SRC>;
>> +    assigned-clock-parents = <&cru PLL_V0PLL>;
>
> Are those board-specific? Considering the VOP and DP/HDMI/... controllers/PHYs are all internal to the SoC, would it make sense to have those specified in the SoC DTSI? I'm not familiar with the video output stack so maybe it doesn't apply here or is a bad idea, so I'm not actually asking for a change here, just asking a question :)

Yep, they are board-specific. Because the V0PLL may be used for non-display applications.



>
> Cheers,
> Quentin
>
>
-- 
Best,
Chaoyi


