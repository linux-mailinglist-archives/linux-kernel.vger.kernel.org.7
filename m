Return-Path: <linux-kernel+bounces-726177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E518B00913
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9D83A8EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C4E2EFDA2;
	Thu, 10 Jul 2025 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="gv/sH+/5"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BFD21CC56;
	Thu, 10 Jul 2025 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165747; cv=none; b=lJs+HL/Y5wwu0z3KVZf/XYzVcUsm597pW/nnqAD8s2CWFh0pXYSUI8SU6WbzFD0iFN8ur9Xv9yAgz57jmy80SPbogwCj/HxMZyL4weu5903h9tc7cuR6+fqsICCJklPJTlR48d3sSxnpgDmh9aEDMB/TyyI11LW3VQXbyzQ90L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165747; c=relaxed/simple;
	bh=mQqMyl9/MnIY7zxTIxu7RP2oDFmYoRQUKeOu0Q7Oz4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7X0ddm2MVGKQc1YRtYC6e2gAZND8nV1wqeTZRd/wOShD2m0WQi8tNh/h39SzIUCMf79hVxeItHwx1FhqBAeBQBTGxdHqELffsXWBpzCvf/CD2FemM1E3mFLiZ+LNr9qT8QrKwjjxLmtTqwFccgTS+sVO97RxvSnBCOM/+4GNmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=gv/sH+/5; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7653922C34;
	Thu, 10 Jul 2025 18:42:09 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uHNKzZGcUZmC; Thu, 10 Jul 2025 18:42:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1752165728; bh=mQqMyl9/MnIY7zxTIxu7RP2oDFmYoRQUKeOu0Q7Oz4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gv/sH+/5bBVpo/ZWtroqIAelUeppO2E6EN8uHUU1JzacvVD+a5Rg1MRvjup+XwY/9
	 tlawYJKWW5+jLu9ywUmo2PYUl5sqIXHcFHIEUtHYZ2BmrNVgGmXnjQE1I6vlyz5DAS
	 03Um+Q8IoUBHCwE7rK2S+aAbjuuDxy1smLLEY6b0XluBGYrGc0SOFitE0k+KnlHrPy
	 oiG/PRzP/oTip3vQJDDymQaU+1a5oVgaNCHRz4o2b/tqpjZqpIg7NV986t7EjatTYa
	 Uv+vKTJSyi5B3qzA2KpTUlflYW3pB8OtHvB9G0hc2rqCu6niBIP1EBVYih4DKQeN5a
	 ctWkFP/kyZyQA==
Date: Thu, 10 Jul 2025 16:41:48 +0000
From: Yao Zi <ziyao@disroot.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] arm64: dts: rockchip: Add Radxa ROCK 2A/2F
Message-ID: <aG_tTPRYZPYHMpf7@pie.lan>
References: <20250708224921.2254116-1-jonas@kwiboo.se>
 <20250708224921.2254116-3-jonas@kwiboo.se>
 <aG3vPsUd-FPkhi-S@pie.lan>
 <5ce03a37-1b60-4328-8d04-07bf835def94@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ce03a37-1b60-4328-8d04-07bf835def94@kwiboo.se>

On Thu, Jul 10, 2025 at 01:56:02AM +0200, Jonas Karlman wrote:
> Hi,
> 
> On 7/9/2025 6:25 AM, Yao Zi wrote:
> > On Tue, Jul 08, 2025 at 10:48:52PM +0000, Jonas Karlman wrote:
> >> The ROCK 2A and ROCK 2F is a high-performance single board computer
> >> developed by Radxa, based on the Rockchip RK3528A SoC.
> >>
> >> Add initial device tree for the Radxa ROCK 2A and ROCK 2F boards.
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >> ---
> >> Schematics:
> >> - https://dl.radxa.com/rock2/2a/v1.2/radxa_rock_2a_v1.2_schematic.pdf
> >> - https://dl.radxa.com/rock2/2f/radxa_rock2f_v1.01_schematic.pdf
> >> ---
> >>  arch/arm64/boot/dts/rockchip/Makefile         |   2 +
> >>  .../boot/dts/rockchip/rk3528-rock-2.dtsi      | 292 ++++++++++++++++++
> >>  .../boot/dts/rockchip/rk3528-rock-2a.dts      |  82 +++++
> >>  .../boot/dts/rockchip/rk3528-rock-2f.dts      |  10 +
> >>  4 files changed, 386 insertions(+)
> >>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
> >>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
> >>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
> >  
> > While testing the patch on my Rock 2A board, I noticed one of my SDcard
> > that works perfectly on Radxa E20C and NanoPi Zero 2 cannot be correctly
> > read out under UHS-125-SDR mode,
> > 
> > 	# dd if=/dev/mmcblk1 of=/dev/null bs=4M count=4
> > 	[   18.616828] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
> > 	[   19.193315] mmc1: Skipping voltage switch
> > 	[   19.202046] mmc1: tried to HW reset card, got error -110
> > 	[   19.213312] mmcblk1: recovery failed!
> > 	[   19.213709] I/O error, dev mmcblk1, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 256 prio class 0
> > 	[   19.225201] mmcblk1: recovery failed!
> > 	[   19.225530] I/O error, dev mmcblk1, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> > 	[   19.226283] Buffer I/O error on dev mmcblk1, logical block 0, async page read
> > 	dd: /dev/mmcblk1: I/O error
> > 
> > which could be reproduced stably.
> > 
> > the SDMMC controller issued interesting messages during the tuning
> > process,
> > 
> > 	[    0.665246] mmc_host mmc1: Bus speed (slot 0) = 148500000Hz (slot req 150000000Hz, actual 148500000HZ div = 0)
> > 	[    0.851940] dwmmc_rockchip ffc30000.mmc: All phases work, using default phase 90.
> > 
> > but actually it doesn't work with phase = 90. If the frequency is
> > limited to 100MHz with max-frequency = <100000000> instead of the
> > default 150MHz, tuning results in a very different phase,
> > 
> > 	[    0.665483] mmc_host mmc1: Bus speed (slot 0) = 99600000Hz (slot req 100000000Hz, actual 99600000HZ div = 0)
> > 	[    1.166340] dwmmc_rockchip ffc30000.mmc: Successfully tuned phase to 141
> > 
> > and the card works, too. If I set rockchip,default-sample-phase to 141
> > in devicetree, the card could work at full 150MHz as well.
> > 
> > I think there's something wrong with the tuning process, or the board's
> > design cannot always run reliably at 150MHz.
> > 
> > Could you reproduce similar failures on Radxa 2A? If so, it may be
> > necessary to lower the SDMMC's maximum frequency for the board.
> 
> I have not been able to reproduce this issue on any of my ROCK 2A or 2F
> boards, my boards seem to tune phase to around 250-265 for the sd-cards
> I tested.
> 
> Could you try with something like this:
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi b/arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
> index fc23c51836b15..a82791db55699 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
> @@ -285,6 +285,10 @@
>  	status = "okay";
>  };
>  
> +&sdmmc_clk {
> +	rockchip,pins = <2 RK_PA5 1 &pcfg_pull_up_drv_level_3>;
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0m0_xfer>;
> 
> 
> Changing clk drive strength seem to be something that has been done in
> Radxa vendor kernel [1], could be something that we can include if it
> fixes your issue.

This seems to improve the situation a little, but doesn't solve the
issue. Among more than ten times of testing, the tuning process only
worked twice.

> The kernel I tested was built from [2].

I've tried this branch as well, but things don't improve.

Do you consider lower the clock-frequency acceptable?

> [1] https://github.com/radxa/kernel/commit/e9b33cbc97a902560d3f3b43b4d36a1a0ac68a50
> [2] https://github.com/Kwiboo/linux-rockchip/commits/next-20250708-rk3528-boards/
> 
> Regards,
> Jonas
> 
> > 
> > Regards,
> > Yao Zi
> 

Regards,
Yao Zi

