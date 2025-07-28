Return-Path: <linux-kernel+bounces-748417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BE6B140F6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C384E54DC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F0F2750FD;
	Mon, 28 Jul 2025 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="apYcas1z"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6EF212B2F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722583; cv=none; b=hzCgOZRdcN3xjZuNT6L7Mj9x24tUGFThWzTmVPGzKt9/R3kZbVIVVysiTZu+ol136WZRlOB02TDNCjXweo8VrEyDu0RODJRD3H6UrJgn4UeVAFcQuFz/TdImsT6x9L7QSP70gdisOZRMR2h8o3/mCC80RFtRiMH8lojNvRFzwAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722583; c=relaxed/simple;
	bh=1RRB5mcT6XkxVvImVlknYsFQxEXTXSs1Fy1yDu34bZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCHV6v0DkVwOBJi9ZVVU7LG+3trRFaUVhcHp8b0Rd5s4o9XOQ+vZkzU9dL3Bre7bzAYmXMoZg7Bfl+v7kpyX6OPCdd1Dc04uQKkhw8GzyU1vqyYqnCmvmPXQSIvyh+VEnpRDwpHtvNJboiPtezS7+9NaEg7ftaLE4/+MXR5KBUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=apYcas1z; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1753722580;
 bh=o1SAkKfZM3NhF3wZAPT2jfOda4w4lWqHgHvXSycv5Gc=;
 b=apYcas1zRvWrusiROXe1jSQkmSJA5WYX12wDbJ5QxExI3w/CDIgBbp/Pu9MscBV9Y4HtVV7My
 Uwz/+//yfpq5I0Etpl4q+3fpE2ZpvyNuuVnX/VTCnaqKHOmYN49XrHCaXEDYeNWTm/+NIGBad1N
 2lM6IMe+eWbjMHKZYbmctoBzOimZRKSyuLUVYSNkIYjJsKU5eG0RlIaEAxQCt3AceGHnRumoO9H
 LoL07U4xuP8ShO+pp4WLlBeu4G+kVUcjCQru7E6bGvGrqvbSoBRtvjI7/v8p5nGATGHo9Np+XVd
 B9BLIazpP6cVTe3lHFeFJlNY4YzhxiXR/MxOrIU/1ApQ==
X-Forward-Email-ID: 6887aebc351ec66b15a29e9b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <e2fd11db-543a-43eb-b118-9f246ff149b5@kwiboo.se>
Date: Mon, 28 Jul 2025 19:09:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Radxa E24C
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 robh@kernel.org, ziyao@disroot.org
References: <20250727144409.327740-4-jonas@kwiboo.se>
 <20250728125015.988357-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250728125015.988357-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chukun,

On 7/28/2025 2:50 PM, Chukun Pan wrote:
> Hi,
> 
>> +	avddl_1v1: avddh_3v3: avdd_rtl8367rb: regulator-avdd-rtl8367rb {
>> +		compatible = "regulator-fixed";
>> +		enable-active-high;
>> +		gpios = <&gpio1 RK_PC3 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&gpio_8367_en>;
>> +		regulator-name = "avdd_rtl8367rb";
> 
> I don't see the avdd_rtl8367rb regulator in the schematics. It looks like
> DVDDIO (RTL8367RB power) is connected to AVDDH_3V3 via a magnetic bead.

Both avddl_1v1 and avddh_3v3 are controlled by the same gpio, I do not
remember if using two regulators with same gpios is supported, can only
remember it being an issue in the past, so I opted to just describe it
as a single regulator and gave it a new name and added labels for the
name used in schematic.

Would calling it vdd_8367 (after gpio_8367_en) be better or do you have
any other suggestion on how to describe these?

I will at least add a comment related to this regulator for v2.

> 
>> +&gmac1 {
>> +	clock_in_out = "output";
>> +	phy-mode = "rgmii-id";
>> +	phy-supply = <&avdd_rtl8367rb>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&rgmii_miim>, <&rgmii_tx_bus2>, <&rgmii_rx_bus2>,
>> +		    <&rgmii_rgmii_clk>, <&rgmii_rgmii_bus>, <&gmac1_rstn_l>;
> 
> Should the pinctrl of gmac1_rstn_l be written together with the
> reset-gpios of the rtl8367rb switch?

When defining pinctrl to the mdio1 node they are not applied, and there
was issues probing the switch when using reset-gpios of the switch.
So I opted to describe the switch reset as the mdio bus reset.

I guess we should describe the HW and not work around SW issues, will
change in v2.

> 
> ```
> reset-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
> pinctrl-0 = <&gmac1_rstn_l>;
> ```
> 
>> +&i2c0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&i2c0m0_xfer>;
>> +	status = "okay";
>> +
>> +	rk805: pmic@18 {
>> +		compatible = "rockchip,rk805";
>> +		reg = <0x18>;
>> +		interrupt-parent = <&gpio4>;
>> +		interrupts = <RK_PB2 IRQ_TYPE_LEVEL_LOW>;
>> +		#clock-cells = <1>;
>> +		clock-output-names = "rk805-clkout1", "rk805-clkout2";
> 
> The clkout pin is not connected, but the dt-bindings require it.
> Maybe clock-output-names could be made optional?

Seem the using just #clock-cells = <0> is valid without
clock-output-names, will use that in v2, thanks.

> 
> +&mdio1 {
> +	reset-delay-us = <25000>;
> +	reset-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
> +	reset-post-delay-us = <100000>;
> +};
> 
> I don't think this is correct, reset-gpios should be written on the
> rtl8365mb switch node. The switch driver has defined the reset time.

See above, I had issues using the reset-gpios of the switch, because the
switch was probed twice, once deferred by gmac, and by the second probe
failed with -BUSY because of the reset-gpios still being claimd by the
first probe.

I can change to describe the reset pin in the switch, however that will
likely mean Ethernet is unusable until the issue in devres/gpiolib is
tracked down and fixed by someone.

> 
> ```
> &mdio1 {
> 	switch@29 {
> 		compatible = "realtek,rtl8365mb";
> 		reg = <29>;
> 		reset-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
> ```

As mentioned above, this caused probe issues and an unusable switch.
I would rather skip describing this reset pin as it does not seem to be
needed it self reset when the regulator is powered on.

Any thoughts on what is better of the two? Skip describing the reset pin
or describe it and leave the switch possible unusable? Probing gmac
before the switch should leave it in a working state.

Regards,
Jonas

> 
> Thanks,
> Chukun
> 
> --
> 2.25.1
> 
> 


