Return-Path: <linux-kernel+bounces-837801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035E9BAD386
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE6377A3C73
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FF23043C3;
	Tue, 30 Sep 2025 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lj9IjFqo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8392FFDFC;
	Tue, 30 Sep 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243193; cv=none; b=rO9me92MB3It9NW29aQAX8/cMIh2vwoAYr1kCdTD38sSzS8IllevB2v1g62XN/+dLjN9FsmWV/Y6Rn4IN9M2ok7L3DQjflHM3zVHiO42GawfMIT8xtI+KhhW3/86d/02VAIsdCdzxEI4W7j1VZo4zsYsAVy/8Orx6SdeuX+anEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243193; c=relaxed/simple;
	bh=9SE2KEAKijrBS96OOPfZTS3b5qqN02DuPyJ8e63F/6o=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=rfuUNDkluOoUo8w+GM1x60G0FMalVcA4W3/5aPTGLe9dUiMWHBjllyA5VWkMt81rkulIDwmXg7feHHeyT+yC9E1So2t0o34LRnj7NLnQguskqQy/33qJRCgOj9g1SuKe1QtE0YSF/tBUwICqmqTA3GheMpZJeS3oS7iJ22gQy7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lj9IjFqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168AEC113D0;
	Tue, 30 Sep 2025 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759243193;
	bh=9SE2KEAKijrBS96OOPfZTS3b5qqN02DuPyJ8e63F/6o=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Lj9IjFqoFazTFnsi/bS5qfrL70o48qeM2oCEa8G7VKTZF9TzP0eEzb1Ri4fnlnL/8
	 9Np1PxY/pxArTl7lj8IzjMitjSB6cicesgvrw3f7nWO8efzPsdn+XeYOXsg+qcQ1p1
	 vX14wK0nUy9mwURZhnB/Mu2TaVm3Hww7BbvSm4UrX6hPHV/7Vb8vhtZefgapKrM6Vc
	 WfxlFMXnOhb+TYu/KlSK52LZm0MMKjPWU6yJzUc98cuiUCbl5PwXkvMN3Bs6DVeE9X
	 FBEEMhy5hP/BLr8BoYZKAEdeId/3hDIQXR8UwPDtS6tKthgAW0biPqfbo56SlSEx2x
	 i2G8ljMDQR0Pg==
Date: Tue, 30 Sep 2025 09:39:52 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Kevin Hilman <khilman@baylibre.com>
To: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
References: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
Message-Id: <175924309248.2873967.7183764824867817305.robh@kernel.org>
Subject: Re: [PATCH 00/19] clk: amlogic: Add PLLs and peripheral clocks for
 A4 and A5 SoCs


On Tue, 30 Sep 2025 17:37:13 +0800, Chuan Liu wrote:
> This patch series includes changes related to the PLL and peripheral
> clocks for both the A4 and A5 SoCs.
> 
> The patches for A5 were previously submitted up to V3 by Xianwei.
> https://lore.kernel.org/all/20250103-a5-clk-v3-0-a207ce83b9e9@amlogic.com/
> After friendly coordination, I’ve taken over and continued the
> submission as part of this series. The dt-bindings patch retains Rob's
> original "Reviewed-by" tag, and I hope this hasn’t caused any
> additional confusion.
> 
> Both A4 and A5 belong to the Audio series. Judging by their names, one
> might assume that A5 is an upgrade to A4, but in fact, A5 was released
> a year earlier than A4.
> 
> Since there are differences in the PLLs and peripheral clocks between
> the A4 and A5 SoCs (especially the PLL), and taking into account factors
> such as memory footprint and maintainability, this series does not
> attempt to merge the two into a shared driver as was done for
> G12A/G12B/SM1.
> 
> This patch series includes all related dt-bindings, driver, and dts
> changes for the PLLs and peripheral clocks. Following our past convention
> for clock-related submissions, the dts changes are placed at the end
> and submitted separately. If this ordering makes it harder for
> maintainers to review or pick patches, please feel free to point it out.
> 
> Co-developed-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
> Chuan Liu (19):
>       dt-bindings: clock: Add Amlogic A4 SCMI clock controller
>       dt-bindings: clock: Add Amlogic A4 PLL clock controller
>       dt-bindings: clock: Add Amlogic A4 peripherals clock controller
>       clk: amlogic: Optimize PLL enable timing
>       clk: amlogic: Correct l_detect bit control
>       clk: amlogic: Fix out-of-range PLL frequency setting
>       clk: amlogic: Add A4 PLL clock controller driver
>       clk: amlogic: Add A4 clock peripherals controller driver
>       arm64: dts: amlogic: A4: Add scmi-clk node
>       arm64: dts: amlogic: A4: Add PLL controller node
>       arm64: dts: amlogic: A4: Add peripherals clock controller node
>       dt-bindings: clock: Add Amlogic A5 SCMI clock controller support
>       dt-bindings: clock: Add Amlogic A5 PLL clock controller
>       dt-bindings: clock: Add Amlogic A5 peripherals clock controller
>       clk: amlogic: Add A5 PLL clock controller driver
>       clk: amlogic: Add A5 clock peripherals controller driver
>       arm64: dts: amlogic: A5: Add scmi-clk node
>       arm64: dts: amlogic: A5: Add PLL controller node
>       arm64: dts: amlogic: A5: Add peripheral clock controller node
> 
>  .../clock/amlogic,a4-peripherals-clkc.yaml         | 122 +++
>  .../bindings/clock/amlogic,a4-pll-clkc.yaml        |  61 ++
>  .../clock/amlogic,a5-peripherals-clkc.yaml         | 134 ++++
>  .../bindings/clock/amlogic,a5-pll-clkc.yaml        |  63 ++
>  arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        |  80 ++
>  arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        |  87 ++
>  drivers/clk/meson/Kconfig                          |  53 ++
>  drivers/clk/meson/Makefile                         |   4 +
>  drivers/clk/meson/a1-pll.c                         |   1 +
>  drivers/clk/meson/a4-peripherals.c                 | 764 ++++++++++++++++++
>  drivers/clk/meson/a4-pll.c                         | 242 ++++++
>  drivers/clk/meson/a5-peripherals.c                 | 883 +++++++++++++++++++++
>  drivers/clk/meson/a5-pll.c                         | 476 +++++++++++
>  drivers/clk/meson/clk-pll.c                        |  76 +-
>  drivers/clk/meson/clk-pll.h                        |   2 +
>  .../clock/amlogic,a4-peripherals-clkc.h            | 129 +++
>  include/dt-bindings/clock/amlogic,a4-pll-clkc.h    |  15 +
>  include/dt-bindings/clock/amlogic,a4-scmi-clkc.h   |  42 +
>  .../clock/amlogic,a5-peripherals-clkc.h            | 132 +++
>  include/dt-bindings/clock/amlogic,a5-pll-clkc.h    |  24 +
>  include/dt-bindings/clock/amlogic,a5-scmi-clkc.h   |  44 +
>  21 files changed, 3406 insertions(+), 28 deletions(-)
> ---
> base-commit: 01f3a6d1d59b8e25a6de243b0d73075cf0415eaf
> change-id: 20250928-a4_a5_add_clock_driver-2b7c9d695633
> 
> Best regards,
> --
> Chuan Liu <chuan.liu@amlogic.com>
> 
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
 Base: using specified base-commit 01f3a6d1d59b8e25a6de243b0d73075cf0415eaf

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/amlogic/' for 20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com:

Error: arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi:119.19-20 syntax error
FATAL ERROR: Unable to parse input tree
make[3]: *** [scripts/Makefile.dtbs:131: arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dtb] Error 1
make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/amlogic] Error 2
make[2]: Target 'arch/arm64/boot/dts/amlogic/amlogic-a4-a113l2-ba400.dtb' not remade because of errors.
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1480: amlogic/amlogic-a4-a113l2-ba400.dtb] Error 2
make: *** [Makefile:248: __sub-make] Error 2
make: Target 'amlogic/meson-gxl-s905x-hwacom-amazetv.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905d-sml5442tw.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905d-phicomm-n1.dtb' not remade because of errors.
make: Target 'amlogic/meson-s4-s805x2-aq222.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905w-p281.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-s912-libretech-pc.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12a-sei510.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-q200.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905x-khadas-vim.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxlx-s905l-p271.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-mecool-kiii-pro.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-vega-s96.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12a-fbx8am.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-bananapi-cm4-cm4io.dtb' not remade because of errors.
make: Target 'amlogic/amlogic-c3-c308l-aw419.dtb' not remade because of errors.
make: Target 'amlogic/meson-axg-s400.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-nexbox-a1.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-dreambox-one.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-khadas-vim2.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-wetek-core2.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12a-radxa-zero.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-vega-s95-telos.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905x-libretech-cc-v2.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-a311d-khadas-vim3.dtb' not remade because of errors.
make: Target 'amlogic/meson-axg-jethome-jethub-j100.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-gsking-x.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-vega-s95-pro.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-q201.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905d-p230.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-a311d-bananapi-m2s.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-wetek-play2.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905d-mecool-kii-pro.dtb' not remade because of errors.
make: Target 'amlogic/meson-axg-jethome-jethub-j110-rev-2.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-odroidc2.dtb' not remade because of errors.
make: Target 'amlogic/amlogic-s7d-s905x5m-bm202.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-gt1-ultimate.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12a-x96-max.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905d-libretech-pc.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905d-p231.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-ugoos-am3.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-x96-air.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905x-vero4k.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-vega-s95-meta.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905w-tx3-mini.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-minix-neo-u9h.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s805x-libretech-ac.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-a95xf3-air-gbit.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-khadas-vim3l.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905d-vero4k-plus.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-h96-max.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-bananapi-cm4-mnt-reform2.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905x-p212.dtb' not remade because of errors.
make: Target 'amlogic/meson-a1-ad401.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-odroid-go-ultra.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-radxa-zero2.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-x96-air-gbit.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-dreambox-two.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-bananapi-m5.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12a-u200.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxm-rbox-pro.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-p201.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-a95xf3-air.dtb' not remade because of errors.
make: Target 'amlogic/amlogic-a4-a113l2-ba400.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s805y-xiaomi-aquaman.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-bananapi-m2-pro.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-p200.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-odroid-c4.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-s922x-bananapi-m2s.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-sei610.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-odroid-hc4.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-odroid-n2l.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905x-libretech-cc.dtb' not remade because of errors.
make: Target 'amlogic/amlogic-c3-c302x-aw409.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905x-nexbox-a95x.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-a311d-libretech-cc.dtb' not remade because of errors.
make: Target 'amlogic/amlogic-t7-a311d2-khadas-vim4.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s905w-jethome-jethub-j80.dtb' not remade because of errors.
make: Target 'amlogic/meson-sm1-s905d3-libretech-cc.dtb' not remade because of errors.
make: Target 'amlogic/amlogic-a5-a113x2-av400.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-wetek-hub.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-s922x-khadas-vim3.dtb' not remade because of errors.
make: Target 'amlogic/amlogic-s6-s905x5-bl209.dtb' not remade because of errors.
make: Target 'amlogic/amlogic-t7-a311d2-an400.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-kii-pro.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-odroid-n2.dtb' not remade because of errors.
make: Target 'amlogic/meson-a1-ad402.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-nexbox-a95x.dtb' not remade because of errors.
make: Target 'amlogic/meson-axg-jethome-jethub-j110-rev-3.dtb' not remade because of errors.
make: Target 'amlogic/amlogic-s7-s805x3-bp201.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-odroid-n2-plus.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-gtking-pro.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-ugoos-am6.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxl-s805x-p241.dtb' not remade because of errors.
make: Target 'amlogic/meson-g12b-gtking.dtb' not remade because of errors.
make: Target 'amlogic/meson-gxbb-nanopi-k2.dtb' not remade because of errors.






