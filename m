Return-Path: <linux-kernel+bounces-724659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EB3AFF587
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C621C22A23
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43A723B637;
	Wed,  9 Jul 2025 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="uPabgflY"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363D23B631
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752105387; cv=none; b=ejpPrNOYulhgSfEkx0f6+CWzYy9FvQN+Pdvgcx5T5dHtT4u7e8xzmuLIg6z0z6700x4ij61QmpQtOe42Ym9HFUYJRezDHE2wmvOJv/s41DAR5A1NsporVWAfqwTy8FFuATU/PNrmAEggWPM3yk0VjXApEqR1xkDuaQE0PzF0VdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752105387; c=relaxed/simple;
	bh=wzNeuH4AgfJ+srhdUxKvu59sPMiOo4UVbGX3w1hfgNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpHfI0/G37hZkwNwGugGf0YLZQT+U8PHEhVWzKzrtUKPYp9iCo1mDyq7JRACeYW2oP/kT1Wejdaur5YPQrm+xabRb7EMxOs0etyY7ASpdJ1MZfY0Rtc8T7LmgN/f0lU4iae6/plQ4qWQ+ioTIBrL4Do10D1M0DwfRqq+epHDbZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=uPabgflY; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1752105378;
 bh=2DQ9gjXXuEt0O2/rJn65m+kWyPKUAoslRtuiFDYcZeU=;
 b=uPabgflYG12oBh7sVs2aSBOHGbE00EujMp7u7jQogofXujZyyk6zYHxLn0a/8G95Yc4LSMGpp
 zbZF4akcDOYN9uQr6eKUOuFh5HMAH79bvq02ZSal1S71BB66TMitALxaITGGtZ7wukBfwMqyB4d
 9bRMLT83eVuT4aOW2Fk7dJAzZ2rTRc3Cs8wjiMep0RQtUwyHkc7jmDYXUyUzEIW2a/pFbeZHW+h
 o/6IsJA7IUQ1p6Ar2xVMl8FVnEQZ3ILpSu7Di2AcBCpWvB2laSw11DVgUZ+iGqtLiKLyNUtSNLF
 x6o+1LEyJ1GCUDECbVaOEAbEaolcm1VuBUx9DLRQ9ozg==
X-Forward-Email-ID: 686f0196c4bb2e06178a2682
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <5ce03a37-1b60-4328-8d04-07bf835def94@kwiboo.se>
Date: Thu, 10 Jul 2025 01:56:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] arm64: dts: rockchip: Add Radxa ROCK 2A/2F
To: Yao Zi <ziyao@disroot.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250708224921.2254116-1-jonas@kwiboo.se>
 <20250708224921.2254116-3-jonas@kwiboo.se> <aG3vPsUd-FPkhi-S@pie.lan>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <aG3vPsUd-FPkhi-S@pie.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/9/2025 6:25 AM, Yao Zi wrote:
> On Tue, Jul 08, 2025 at 10:48:52PM +0000, Jonas Karlman wrote:
>> The ROCK 2A and ROCK 2F is a high-performance single board computer
>> developed by Radxa, based on the Rockchip RK3528A SoC.
>>
>> Add initial device tree for the Radxa ROCK 2A and ROCK 2F boards.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> Schematics:
>> - https://dl.radxa.com/rock2/2a/v1.2/radxa_rock_2a_v1.2_schematic.pdf
>> - https://dl.radxa.com/rock2/2f/radxa_rock2f_v1.01_schematic.pdf
>> ---
>>  arch/arm64/boot/dts/rockchip/Makefile         |   2 +
>>  .../boot/dts/rockchip/rk3528-rock-2.dtsi      | 292 ++++++++++++++++++
>>  .../boot/dts/rockchip/rk3528-rock-2a.dts      |  82 +++++
>>  .../boot/dts/rockchip/rk3528-rock-2f.dts      |  10 +
>>  4 files changed, 386 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
>>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
>>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
>  
> While testing the patch on my Rock 2A board, I noticed one of my SDcard
> that works perfectly on Radxa E20C and NanoPi Zero 2 cannot be correctly
> read out under UHS-125-SDR mode,
> 
> 	# dd if=/dev/mmcblk1 of=/dev/null bs=4M count=4
> 	[   18.616828] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
> 	[   19.193315] mmc1: Skipping voltage switch
> 	[   19.202046] mmc1: tried to HW reset card, got error -110
> 	[   19.213312] mmcblk1: recovery failed!
> 	[   19.213709] I/O error, dev mmcblk1, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 256 prio class 0
> 	[   19.225201] mmcblk1: recovery failed!
> 	[   19.225530] I/O error, dev mmcblk1, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> 	[   19.226283] Buffer I/O error on dev mmcblk1, logical block 0, async page read
> 	dd: /dev/mmcblk1: I/O error
> 
> which could be reproduced stably.
> 
> the SDMMC controller issued interesting messages during the tuning
> process,
> 
> 	[    0.665246] mmc_host mmc1: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
> 	[    0.851940] dwmmc_rockchip ffc30000.mmc: All phases work, using default phase 90.
> 
> but actually it doesn't work with phase = 90. If the frequency is
> limited to 100MHz with max-frequency = <100000000> instead of the
> default 150MHz, tuning results in a very different phase,
> 
> 	[    0.665483] mmc_host mmc1: Bus speed (slot 0) = 99600000Hz (slot req 100000000Hz, actual 99600000HZ div = 0)
> 	[    1.166340] dwmmc_rockchip ffc30000.mmc: Successfully tuned phase to 141
> 
> and the card works, too. If I set rockchip,default-sample-phase to 141
> in devicetree, the card could work at full 150MHz as well.
> 
> I think there's something wrong with the tuning process, or the board's
> design cannot always run reliably at 150MHz.
> 
> Could you reproduce similar failures on Radxa 2A? If so, it may be
> necessary to lower the SDMMC's maximum frequency for the board.

I have not been able to reproduce this issue on any of my ROCK 2A or 2F
boards, my boards seem to tune phase to around 250-265 for the sd-cards
I tested.

Could you try with something like this:

diff --git a/arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi b/arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
index fc23c51836b15..a82791db55699 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
@@ -285,6 +285,10 @@
 	status = "okay";
 };
 
+&sdmmc_clk {
+	rockchip,pins = <2 RK_PA5 1 &pcfg_pull_up_drv_level_3>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0m0_xfer>;


Changing clk drive strength seem to be something that has been done in
Radxa vendor kernel [1], could be something that we can include if it
fixes your issue.

The kernel I tested was built from [2].

[1] https://github.com/radxa/kernel/commit/e9b33cbc97a902560d3f3b43b4d36a1a0ac68a50
[2] https://github.com/Kwiboo/linux-rockchip/commits/next-20250708-rk3528-boards/

Regards,
Jonas

> 
> Regards,
> Yao Zi


