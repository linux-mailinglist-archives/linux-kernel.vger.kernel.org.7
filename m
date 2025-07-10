Return-Path: <linux-kernel+bounces-724660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9CFAFF58C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04A85A1DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E414872622;
	Thu, 10 Jul 2025 00:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="goaCz47L"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE38D29D0D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752105648; cv=none; b=Ucrk7NlPOoJdzu9Mbl/UC5tiCeCZhaRBqkFnLyqKIJwilZa2DLTi6mShOvloi+c53e5adMCAof4DomqHMbHb5aQlOCmKaCh1uCKy+hXaOtz8HHywFD+/vUijUgQbjkYsA0FP0FulEkbTGTUOd3xb1a9Ljnsad6k28GQGzMSXqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752105648; c=relaxed/simple;
	bh=LJYyGTSErihblfOKFi6BylxXoGQ687UZBJYL9fnodBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0my2KDSTap27kOVJ1n0T0vPtqL3HEzljyaFI7cBHtiYPoSReObASvyuOINRM+p1JFehJGnc/JS5a9oQmGUO2v7W1AlP2/ariTFvWznS7GdH0oMfTQuN9ZeLWCo3t3AwhLppBugd6ZuY2DsydFVT/1fas7fhYYIlhwKviO53sfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=goaCz47L; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1752105646;
 bh=vkPooPX6zi3QRoM9CrTsbZoAxP36NlshDQEMrww4eZw=;
 b=goaCz47L+Jrhu8tQhXmV1srCl8J8AiScNfOF85pJoHjRepBGsn0rsM/ldtfrS2tM6Yq9bQT++
 sPLYJum9TMTH0yotgaJ96kqPT5mpQZ011kN4V1hDZ2aWq0BWnIcxOeCtfeIvaktZieZsqsaw9x/
 PWEANK6Kw2/FlTmayzx9YcAozgTd7h03YUnMWBNrPeBur45x7gFDvmihPsV8T4vrASn5VaZ+w67
 iqgRJbQbwQUaqrHm5u5QHwJRsdNxGKVcsX+wClbMcTA6bfIj1RsyjPVz+SXr1FRi1gKYaq2FPaA
 w4ZMLH+2Lmpmdl/mAOXXNkFfwJRkkSI4eJ18LcepMPKQ==
X-Forward-Email-ID: 686f02a6cecacbdaffda9867
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <87c6249a-96f1-4557-b4eb-70e69e6d773f@kwiboo.se>
Date: Thu, 10 Jul 2025 02:00:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] arm64: dts: rockchip: Add ArmSoM Sige1
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 robh@kernel.org, ziyao@disroot.org
References: <20250708224921.2254116-5-jonas@kwiboo.se>
 <20250709070003.53484-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250709070003.53484-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/9/2025 9:00 AM, Chukun Pan wrote:
> Hi,
> 
>> +	vcc5v0_usb1_host: regulator-5v0-vcc-usb1-host {
>> +		compatible = "regulator-fixed";
>> ...
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> ...
>> +	vcc5v0_usb2_host: regulator-5v0-vcc-usb2-host {
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> ...
> 
> I think these two regulators do not need boot-on?

Agree, will remove the boot-on in v2.

> 
>> +	rfkill {
>> +		compatible = "rfkill-gpio";
>> +		label = "rfkill-wlan";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&wifi_reg_on_h>;
>> +		radio-type = "wlan";
>> +		shutdown-gpios = <&gpio1 RK_PA6 GPIO_ACTIVE_HIGH>;
>> +	};
> 
> Why not use mmc-pwrseq instead of rfkill?

Not sure, have changed to use mmc-pwrseq in v2.

> 
>> +	rfkill-bt {
>> +		compatible = "rfkill-gpio";
>> +		label = "rfkill-bt";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&bt_reg_on_h>;
>> +		radio-type = "bluetooth";
>> +		shutdown-gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
>> +	};
> 
> Why not use shutdown-gpios of bcm43438-bt?

Sure, will use that in v2.

> 
>> +&i2c0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&i2c0m0_xfer>;
>> +	status = "okay";
>> +
>> +	hym8563: rtc@51 {
>> +		compatible = "haoyu,hym8563";
>> +		reg = <0x51>;
>> +		#clock-cells = <0>;
>> +		clock-output-names = "hym8563";
> 
> CLKOUT pin is not connected.

Thanks, will remove the clock-output-names for the Sige1 and the NanoPi
Zero2 in v2, #clock-cells seem to be required by the dt-bindings.

> 
>> +&sdio0 {
>> +	bus-width = <4>;
>> +	cap-sd-highspeed;
>> +	cap-sdio-irq;
>> +	disable-wp;
>> +	keep-power-in-suspend;
>> +	no-mmc;
>> +	no-sd;
>> +	non-removable;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&sdio0_bus4>, <&sdio0_clk>, <&sdio0_cmd>, <&clkm1_32k_out>;
> 
> I recommend using clkm1_32k_out at the sdio-pwrseq node.

Will do so in v2.

> 
>> +	sd-uhs-sdr104;
>> +	vmmc-supply = <&vcc_3v3>;
>> +	vqmmc-supply = <&vcc_1v8>;
>> +	status = "okay";
> 
> Maybe `brcm,bcm4329-fmac` nodes can be added here?

Will add to in v2.

> 
>> +&uart2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart2m1_xfer>, <&uart2m1_ctsn>, <&uart2m1_rtsn>;
>> +	uart-has-rtscts;
>> +	status = "okay";
> 
> You can add `brcm,bcm43438-bt` nodes here:
> 
> 	bluetooth {
> 		compatible = "brcm,bcm43438-bt";
> 		device-wakeup-gpios = <&gpio3 RK_PC3 GPIO_ACTIVE_HIGH>;
> 		host-wakeup-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
> 		shutdown-gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
> 		...
> 	};

Will use something similar in v2.

See [1] for fixups I am testing for v2.

[1] https://github.com/Kwiboo/linux-rockchip/commits/next-20250708-rk3528-boards/

Regards,
Jonas

> 
> Thanks,
> Chukun
> 
> --
> 2.25.1
> 


