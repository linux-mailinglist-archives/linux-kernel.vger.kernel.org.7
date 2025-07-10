Return-Path: <linux-kernel+bounces-724791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5941AFF6F7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2920F16B6A3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D820C27FB32;
	Thu, 10 Jul 2025 02:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYRDqzqS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1533D1FDD;
	Thu, 10 Jul 2025 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752115543; cv=none; b=c1BhRJfBYj1Z4LpYGv2Pwo8YVSgZr1aONNX/bho+5amzbB6DMv9czBZn2ueFP5Q/W1+s+qMumZn5jwZ1vDBD/CRBbxxqk+ArdjavWHmDNKBmnCoJ/3PKKhBlin+HMz8wXHhXdjZ07006PX1ivPbCBuKjJnM/yC0Ro9NW/NlszFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752115543; c=relaxed/simple;
	bh=DbJ7pzvyLSajFxPAjFNYWqJERvyPy80AQtVzVHLDCDs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=mm7XKxJ6HU0UpQaLc5x227LCBgo+WD+u9lJooqTl5JZJIGAiIANIQaBLs3T9hDFdpCvavrqNKRC9hGrHQJUxGbJjcEqO4b8n3TErWF+Y4w/h2dvAFG8y4bbr3BhHGYa/MctnH/7Jnf6rLfN8r24qsiY16CQkeiyoeDY2c/F2cU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYRDqzqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCC7C4CEF5;
	Thu, 10 Jul 2025 02:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752115542;
	bh=DbJ7pzvyLSajFxPAjFNYWqJERvyPy80AQtVzVHLDCDs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=GYRDqzqSMAPcWOjTOiM60Ttb6B3Tgp727qClmWixa6Lmprs6KTULXchOBDZS1dneb
	 jjYdqNG7sjQC5hxzo9WY3uCEY26EP4xQMTcOMGBm6BFE54ll1Vg3ixMjoxA+wvS92S
	 sfby6XDLjyiJKvPGAMuwqNMnjfsYWyz6LaxrINr9TaEPSdsdV7EESzwYaxljdcLcAo
	 hv5hr6PpZNpT+s5/1yvPYKLam2UEE+w5AoiuZAzr/ARbxumVnlGiy71X/j0zi5566c
	 U8Bm//c/RGf8W9+FjLr+om46N0KscL9sAsrvO3xfbQgJEa+7uv0FgNlSm/zZ+ClN8N
	 ZMYoaDDS+X2TQ==
Date: Wed, 09 Jul 2025 21:45:41 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Chukun Pan <amadeus@jmu.edu.cn>, 
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>, 
 linux-arm-kernel@lists.infradead.org
To: Yao Zi <ziyao@disroot.org>
In-Reply-To: <aG3vPsUd-FPkhi-S@pie.lan>
References: <20250708224921.2254116-1-jonas@kwiboo.se>
 <20250708224921.2254116-3-jonas@kwiboo.se> <aG3vPsUd-FPkhi-S@pie.lan>
Message-Id: <175211539781.410915.4272303348693567023.robh@kernel.org>
Subject: Re: [PATCH 2/6] arm64: dts: rockchip: Add Radxa ROCK 2A/2F


On Wed, 09 Jul 2025 04:25:34 +0000, Yao Zi wrote:
> On Tue, Jul 08, 2025 at 10:48:52PM +0000, Jonas Karlman wrote:
> > The ROCK 2A and ROCK 2F is a high-performance single board computer
> > developed by Radxa, based on the Rockchip RK3528A SoC.
> >
> > Add initial device tree for the Radxa ROCK 2A and ROCK 2F boards.
> >
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > ---
> > Schematics:
> > - https://dl.radxa.com/rock2/2a/v1.2/radxa_rock_2a_v1.2_schematic.pdf
> > - https://dl.radxa.com/rock2/2f/radxa_rock2f_v1.01_schematic.pdf
> > ---
> >  arch/arm64/boot/dts/rockchip/Makefile         |   2 +
> >  .../boot/dts/rockchip/rk3528-rock-2.dtsi      | 292 ++++++++++++++++++
> >  .../boot/dts/rockchip/rk3528-rock-2a.dts      |  82 +++++
> >  .../boot/dts/rockchip/rk3528-rock-2f.dts      |  10 +
> >  4 files changed, 386 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
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
> 
> Regards,
> Yao Zi
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/v6.16-rc1-34-g7f9509791507 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for aG3vPsUd-FPkhi-S@pie.lan:

arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dtb: /soc/power-management@ff600000: failed to match any schema with compatible: ['rockchip,rk3528-pmu', 'syscon', 'simple-mfd']
arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dtb: /soc/power-management@ff600000/power-controller: failed to match any schema with compatible: ['rockchip,rk3528-power-controller']
arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dtb: gpu@ff700000 (rockchip,rk3528-mali): compatible: 'oneOf' conditional failed, one must be fixed:
	['rockchip,rk3528-mali', 'arm,mali-450'] is too short
	'allwinner,sun8i-a23-mali' was expected
	'rockchip,rk3528-mali' is not one of ['allwinner,sun4i-a10-mali', 'allwinner,sun7i-a20-mali', 'allwinner,sun8i-h3-mali', 'allwinner,sun8i-r40-mali', 'allwinner,sun50i-a64-mali', 'rockchip,rk3036-mali', 'rockchip,rk3066-mali', 'rockchip,rk3128-mali', 'rockchip,rk3188-mali', 'rockchip,rk3228-mali', 'samsung,exynos4210-mali', 'st,stih410-mali', 'stericsson,db8500-mali', 'xlnx,zynqmp-mali']
	'rockchip,rk3528-mali' is not one of ['allwinner,sun50i-h5-mali', 'amlogic,meson8-mali', 'amlogic,meson8b-mali', 'amlogic,meson-gxbb-mali', 'amlogic,meson-gxl-mali', 'hisilicon,hi6220-mali', 'mediatek,mt7623-mali', 'rockchip,rk3328-mali']
	'allwinner,sun7i-a20-mali' was expected
	'arm,mali-400' was expected
	from schema $id: http://devicetree.org/schemas/gpu/arm,mali-utgard.yaml#
arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dtb: /soc/gpu@ff700000: failed to match any schema with compatible: ['rockchip,rk3528-mali', 'arm,mali-450']
arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dtb: /soc/power-management@ff600000: failed to match any schema with compatible: ['rockchip,rk3528-pmu', 'syscon', 'simple-mfd']
arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dtb: /soc/power-management@ff600000/power-controller: failed to match any schema with compatible: ['rockchip,rk3528-power-controller']
arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dtb: gpu@ff700000 (rockchip,rk3528-mali): compatible: 'oneOf' conditional failed, one must be fixed:
	['rockchip,rk3528-mali', 'arm,mali-450'] is too short
	'allwinner,sun8i-a23-mali' was expected
	'rockchip,rk3528-mali' is not one of ['allwinner,sun4i-a10-mali', 'allwinner,sun7i-a20-mali', 'allwinner,sun8i-h3-mali', 'allwinner,sun8i-r40-mali', 'allwinner,sun50i-a64-mali', 'rockchip,rk3036-mali', 'rockchip,rk3066-mali', 'rockchip,rk3128-mali', 'rockchip,rk3188-mali', 'rockchip,rk3228-mali', 'samsung,exynos4210-mali', 'st,stih410-mali', 'stericsson,db8500-mali', 'xlnx,zynqmp-mali']
	'rockchip,rk3528-mali' is not one of ['allwinner,sun50i-h5-mali', 'amlogic,meson8-mali', 'amlogic,meson8b-mali', 'amlogic,meson-gxbb-mali', 'amlogic,meson-gxl-mali', 'hisilicon,hi6220-mali', 'mediatek,mt7623-mali', 'rockchip,rk3328-mali']
	'allwinner,sun7i-a20-mali' was expected
	'arm,mali-400' was expected
	from schema $id: http://devicetree.org/schemas/gpu/arm,mali-utgard.yaml#
arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dtb: /soc/gpu@ff700000: failed to match any schema with compatible: ['rockchip,rk3528-mali', 'arm,mali-450']
arch/arm64/boot/dts/rockchip/rk3528-nanopi-zero2.dtb: /soc/power-management@ff600000: failed to match any schema with compatible: ['rockchip,rk3528-pmu', 'syscon', 'simple-mfd']
arch/arm64/boot/dts/rockchip/rk3528-nanopi-zero2.dtb: /soc/power-management@ff600000/power-controller: failed to match any schema with compatible: ['rockchip,rk3528-power-controller']
arch/arm64/boot/dts/rockchip/rk3528-nanopi-zero2.dtb: gpu@ff700000 (rockchip,rk3528-mali): compatible: 'oneOf' conditional failed, one must be fixed:
	['rockchip,rk3528-mali', 'arm,mali-450'] is too short
	'allwinner,sun8i-a23-mali' was expected
	'rockchip,rk3528-mali' is not one of ['allwinner,sun4i-a10-mali', 'allwinner,sun7i-a20-mali', 'allwinner,sun8i-h3-mali', 'allwinner,sun8i-r40-mali', 'allwinner,sun50i-a64-mali', 'rockchip,rk3036-mali', 'rockchip,rk3066-mali', 'rockchip,rk3128-mali', 'rockchip,rk3188-mali', 'rockchip,rk3228-mali', 'samsung,exynos4210-mali', 'st,stih410-mali', 'stericsson,db8500-mali', 'xlnx,zynqmp-mali']
	'rockchip,rk3528-mali' is not one of ['allwinner,sun50i-h5-mali', 'amlogic,meson8-mali', 'amlogic,meson8b-mali', 'amlogic,meson-gxbb-mali', 'amlogic,meson-gxl-mali', 'hisilicon,hi6220-mali', 'mediatek,mt7623-mali', 'rockchip,rk3328-mali']
	'allwinner,sun7i-a20-mali' was expected
	'arm,mali-400' was expected
	from schema $id: http://devicetree.org/schemas/gpu/arm,mali-utgard.yaml#
arch/arm64/boot/dts/rockchip/rk3528-nanopi-zero2.dtb: /soc/gpu@ff700000: failed to match any schema with compatible: ['rockchip,rk3528-mali', 'arm,mali-450']
arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dtb: /soc/power-management@ff600000: failed to match any schema with compatible: ['rockchip,rk3528-pmu', 'syscon', 'simple-mfd']
arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dtb: /soc/power-management@ff600000/power-controller: failed to match any schema with compatible: ['rockchip,rk3528-power-controller']
arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dtb: gpu@ff700000 (rockchip,rk3528-mali): compatible: 'oneOf' conditional failed, one must be fixed:
	['rockchip,rk3528-mali', 'arm,mali-450'] is too short
	'allwinner,sun8i-a23-mali' was expected
	'rockchip,rk3528-mali' is not one of ['allwinner,sun4i-a10-mali', 'allwinner,sun7i-a20-mali', 'allwinner,sun8i-h3-mali', 'allwinner,sun8i-r40-mali', 'allwinner,sun50i-a64-mali', 'rockchip,rk3036-mali', 'rockchip,rk3066-mali', 'rockchip,rk3128-mali', 'rockchip,rk3188-mali', 'rockchip,rk3228-mali', 'samsung,exynos4210-mali', 'st,stih410-mali', 'stericsson,db8500-mali', 'xlnx,zynqmp-mali']
	'rockchip,rk3528-mali' is not one of ['allwinner,sun50i-h5-mali', 'amlogic,meson8-mali', 'amlogic,meson8b-mali', 'amlogic,meson-gxbb-mali', 'amlogic,meson-gxl-mali', 'hisilicon,hi6220-mali', 'mediatek,mt7623-mali', 'rockchip,rk3328-mali']
	'allwinner,sun7i-a20-mali' was expected
	'arm,mali-400' was expected
	from schema $id: http://devicetree.org/schemas/gpu/arm,mali-utgard.yaml#
arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dtb: /soc/gpu@ff700000: failed to match any schema with compatible: ['rockchip,rk3528-mali', 'arm,mali-450']






