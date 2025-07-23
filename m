Return-Path: <linux-kernel+bounces-742820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C51B0F711
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1409AA280C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBA51F099C;
	Wed, 23 Jul 2025 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="QFDGo4B5"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B800C2E0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284650; cv=none; b=Rwo/RJMnFVwmJulIfGpPvPu8yr+2g0eGvm//g9NQI1g3xq/miy0Fq/g01UQHninTD968jsBb0caOkYhUo1Hr0zMWGIcjupHDOybexw1ctSR7PDdy2da31zuMvEA8mD4yIyiI/fbPPNZbFA5a9bTxtcbA0s5UllaMO+YvUyCjglg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284650; c=relaxed/simple;
	bh=4XuTuV98wrsBdokF6KRDhzrpVkiFivv+qg6FgYZ880s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGhZ8LyrA6QeYCVbLy2bAIpHK70eEbnliiPTPAqdl67KaCgd5ZfYY5klo5skv2CexQH9tpkpIlXx6X0V6tTpbS6bBAdKlH7hNhG4lch6bHQvqg5GNJl+509YRpukIEU/B3vpUM4CP3oLVmUc8hLwsh+jJDSFn6PQ99RGn80+laY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=QFDGo4B5; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1753284646;
 bh=FhP6rOtQvB4VYIXnnNpu3xwHjjjJTBlHfuZIWCxLQIE=;
 b=QFDGo4B5m0tg9VX0Vj0FuilN2HlsgI0r0Ha641c1fVx6BGQFOaIjZAwrzsI7E2IE9xsmsTuPc
 QerK7pHvynk5/jYbuTmrAgnxEXNY1fodmzhlUpn40xzfrsBxigAgehrXFvgPtawCn8FTAZkMbih
 0fpAT9+jM/cC3ZNIvfSQW46wZkxDMPfWWhJdj4whOTuzIg89W3InMVBlKoGwk1aIqPfZwfsvNvB
 jF07mGBZhrFz/E/SSW1M+5Qiv6uP73UFmZF6XVHr8TS5mmVc6nAZxHgLsC8gGHO6zaUCgoUK3Jo
 zAnI96Npk1k1c3gO58MGzbXqI6pdG+KJKYW0e0FBasMw==
X-Forward-Email-ID: 68810025cb0ee86f9731e6c0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <94357eb2-d8aa-4928-8816-9f6529530170@kwiboo.se>
Date: Wed, 23 Jul 2025 17:30:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] arm64: dts: rockchip: Add USB nodes for RK3528
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
 kishon@kernel.org, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-rockchip@lists.infradead.org, robh@kernel.org, vkoul@kernel.org,
 ziyao@disroot.org
References: <20250723122323.2344916-8-jonas@kwiboo.se>
 <20250723143006.1083489-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250723143006.1083489-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Chukun,

On 7/23/2025 4:30 PM, Chukun Pan wrote:
> Hi,
> 
>> The DWC3 node does not contain any default phys because out of current
>> and pending supported boards only one board, ROCK 2A, can use USB3.
>> Remaining boards use the Naneng Combo PHY for PCIe instead of USB3.
> 
> I have other RK3528 boards with USB3 and can test this in a few days.
> Or do you think that usb3-phy should be added in the dts of the device?

That is what I did for ROCK 2A testing I added the usb3-phy to the board
dts. Mostly for two reasons, first because I did not want to make this
series fully depend on the naneng-combphy series. And secondly because
the ROCK 2A also have some sort of GPIO controlled mux for USB3 and PCIe
signals that may affect how usb3 support is described in the device tree.

I am open to ideas on how or what default phys to include in soc dtsi.

For the ROCK 2A usb3-phy example, please see the commit "arm64: dts:
rockchip: Enable USB 3.0 port on ROCK 2A" at [1].

[1] https://github.com/Kwiboo/linux-rockchip/commits/next-20250722-rk3528/

> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>> index 85bc3f5aa2c7..3e51a3f51e05 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
>> @@ -243,6 +243,29 @@ soc {
>>  		#address-cells = <2>;
>>  		#size-cells = <2>;
>>
>> +		usb_host0_xhci: usb@fe500000 {
>> +			compatible = "rockchip,rk3528-dwc3", "snps,dwc3";
>> +			reg = <0x0 0xfe500000 0x0 0x400000>;
>> +			clocks = <&cru CLK_REF_USB3OTG>,
>> +				 <&cru CLK_SUSPEND_USB3OTG>,
>> +				 <&cru ACLK_USB3OTG>;
>> +			clock-names = "ref_clk", "suspend_clk", "bus_clk";
>> +			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
>> +			power-domains = <&power RK3528_PD_VPU>;
>> +			resets = <&cru SRST_A_USB3OTG>;
>> +			dr_mode = "otg";
>> +			phy_type = "utmi_wide";
>> +			snps,dis_enblslpm_quirk;
>> +			snps,dis-del-phy-power-chg-quirk;
>> +			snps,dis-tx-ipgap-linecheck-quirk;
>> +			snps,dis-u1-entry-quirk;
>> +			snps,dis-u2-entry-quirk;
>> +			snps,dis-u2-freeclk-exists-quirk;
>> +			snps,parkmode-disable-hs-quirk;
>> +			snps,parkmode-disable-ss-quirk;
> 
> Maybe "snps,dis_u2_susphy_quirk" is needed?

Maybe, it did not seem to be needed when I tested USB2.0 only or USB3.0,
will run some more tests on my boards.

Any issues you know that snps,dis_u2_susphy_quirk would help fix?

For my latest USB testing I have included a few USB related changes in
U-Boot, e.g. early disable of U3 port. Will push and updated rk3528
branch [2] once source.denx.de is fully back online again.

[2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528

> Downstream kernels add this on USB2.0 only devices:
> https://github.com/rockchip-linux/kernel/blob/develop-5.10/arch/arm64/boot/dts/rockchip/rk3528-demo.dtsi#L474
> 
>> +		u2phy: usb2phy@ffdf0000 {
>> +			u2phy_otg: otg-port {
>> +			u2phy_host: host-port {
> 
> I think it would be better to call it usb2phy, usb2phy0_otg and usb2phy0_host?
> In this way, we can put these USB nodes close together in the device's dts.

From what I could see these nodes are named u2phy for 8 other Rockchip
SoCs and only named usb2phy for 3. So I went with what the majority seem
to be calling them.

I fully understand wanting to sort them closer, however we also have the
forthcoming combphy for USB3 that also will be sorted away from the usb
controller nodes. Hopefully someone more can chime in on node naming
suggestions :-)

Regards,
Jonas

> 
> --
> 2.25.1
> 
> 


