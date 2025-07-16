Return-Path: <linux-kernel+bounces-733925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2587B07ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1C3565672
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAEB2F5496;
	Wed, 16 Jul 2025 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="GdtmVZFD"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8202F532D;
	Wed, 16 Jul 2025 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682137; cv=none; b=tFYXBNEFjjM6/Wpf6jW+YtwBy3AII0rf89bb+AdaMPPYMeQfhjqEwa4BJOG7m/TQn9t+JPyrxqCCALToHayzCL3ybAJPUec7Kd2qhOWd31rCb/FL8S8wJh4D4kTFYA9r9BNdM8o0VyD65tf/wDMqhjJ/V+YoM3e/13V/emNP1CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682137; c=relaxed/simple;
	bh=+W09G+Txez91PG0u3dbICXsTHJsZszmOf0ugQkIaaeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RN39ykmseIVHp2acbv3JhA1DuQ2UUbpmv6uouTzqTgvuo8bILSuwCG7N4jH+O+rQIWU+iVhxlzA4d7uJKkYIRwo+lMCUWxC49t81LT+GGMVx/LXgoGLhs4OjEtNhGxkmf3NIP2hvH+p7Ot9ivXKPXLOJUamOw7e7nBrjPQQK/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=GdtmVZFD; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id DB969204E5;
	Wed, 16 Jul 2025 18:08:45 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zWVEH2PJBuQV; Wed, 16 Jul 2025 18:08:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1752682123; bh=+W09G+Txez91PG0u3dbICXsTHJsZszmOf0ugQkIaaeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GdtmVZFDjG0lz+7Huklm4/jycmaVtH67HDQs5AJa6TZfEKTzBpnruRYP9bAtsf0EW
	 +rDkAfYaf0HwfeMI2vlLQMKoa0PHcAZbQKmWmG/I+obofupMI1Tv8wyDciVq1FVCtS
	 umMxZpEoGfqsYPsJKsqSXOMJmqYFtSKxR8ta97N3fwk/dwzsC+G7ylqFyeZfxsvBCT
	 pLoDvLEf5o69RTrQX34aKiGe4D20GSLZUdeFMC39/uaFuKB31tdMctt7ARCBLQrblC
	 1T46W4yCEc53FFQu7dpeymOgxG+Nld0G4khR9DiIJwxo7U8LW7QYqJ/fhQxosXBjL7
	 oVKVE2hh1S63g==
Date: Wed, 16 Jul 2025 16:08:26 +0000
From: Yao Zi <ziyao@disroot.org>
To: E Shattow <e@freeshell.de>, Icenowy Zheng <uwu@icenowy.me>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Jisheng Zhang <jszhang@kernel.org>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: dts: starfive: add DT for Orange Pi RV
Message-ID: <aHfOeo7ZITHvg9P9@pie>
References: <20250409091801.855083-1-uwu@icenowy.me>
 <20250409091801.855083-2-uwu@icenowy.me>
 <Z_f30vAuATR1DCWk@pie>
 <8fbd6ffdd053760b6d0980173c7f8af6c09963ba.camel@icenowy.me>
 <e2ec3809-a538-4475-ac3a-db289271fe7a@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2ec3809-a538-4475-ac3a-db289271fe7a@freeshell.de>

On Tue, Jul 15, 2025 at 06:30:57PM -0700, E Shattow wrote:
> On 4/10/25 18:29, Icenowy Zheng wrote:
> > 在 2025-04-10星期四的 16:54 +0000，Yao Zi写道：
> >> On Wed, Apr 09, 2025 at 05:18:01PM +0800, Icenowy Zheng wrote:
> >>> Orange Pi RV is a newly released SBC with JH7110 SoC, single GbE
> >>> port
> >>> (connected to JH7110 GMAC0 via a YT8531 PHY), 4 USB ports (via a
> >>> VL805
> >>> PCIe USB controller connected to JH7110 PCIE0), a M.2 M-key slot
> >>> (connected to JH7110 PCIE1), a HDMI video output, a 3.5mm audio
> >>> output
> >>> and a microSD slot.
> >>>
> >>> Onboard peripherals contain a SPI NOR (which contains the U-Boot
> >>> firmware) and an Ampak AP6256 SDIO Wi-Fi module.
> >>>
> >>> As the schematics isn't available yet, the SDIO Wi-Fi is left
> >>> disabled
> >>> yet.
> >>>
> >>> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> >>> ---
> >>>  arch/riscv/boot/dts/starfive/Makefile         |  1 +
> >>>  .../boot/dts/starfive/jh7110-orangepi-rv.dts  | 73
> >>> +++++++++++++++++++
> >>>  2 files changed, 74 insertions(+)
> >>>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-orangepi-
> >>> rv.dts
> >>>
> >>> diff --git a/arch/riscv/boot/dts/starfive/Makefile
> >>> b/arch/riscv/boot/dts/starfive/Makefile
> >>> index b3bb12f78e7d5..24f1a44828350 100644
> >>> --- a/arch/riscv/boot/dts/starfive/Makefile
> >>> +++ b/arch/riscv/boot/dts/starfive/Makefile
> >>> @@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-starfive-
> >>> visionfive-v1.dtb
> >>>  
> >>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-deepcomputing-fml13v01.dtb
> >>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
> >>> +dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-orangepi-rv.dtb
> >>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
> >>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-
> >>> v1.2a.dtb
> >>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-
> >>> v1.3b.dtb
> >>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-orangepi-rv.dts
> >>> b/arch/riscv/boot/dts/starfive/jh7110-orangepi-rv.dts
> >>> new file mode 100644
> >>> index 0000000000000..bde01f117e0b2
> >>> --- /dev/null
> >>> +++ b/arch/riscv/boot/dts/starfive/jh7110-orangepi-rv.dts
> >>> @@ -0,0 +1,73 @@
> >>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> >>> +/*
> >>> + * Copyright (C) 2025 Icenowy Zheng <uwu@icenowy.me>
> >>> + */
> >>> +
> >>> +/dts-v1/;
> >>> +#include "jh7110-common.dtsi"
> >>> +#include <dt-bindings/leds/common.h>
> >>> +
> >>> +/ {
> >>> +       model = "Xunlong Orange Pi RV";
> >>> +       compatible = "xunlong,orangepi-rv", "starfive,jh7110";
> >>> +
> >>> +       leds {
> >>> +               compatible = "gpio-leds";
> >>> +
> >>> +               led-ack {
> >>> +                       gpios = <&aongpio 3 GPIO_ACTIVE_HIGH>;
> >>> +                       color = <LED_COLOR_ID_GREEN>;
> >>> +                       function = LED_FUNCTION_HEARTBEAT;
> >>> +                       linux,default-trigger = "heartbeat";
> >>> +                       label = "ack";
> >>
> >> Should we sort the properties in alphabet order? i.e. color,
> >> function,
> >> gpios, label then linux,default-trigger. See dts-coding-style.rst,
> > 
> > Well in case of GPIO LED, I think gpios is something like reg? Although
> > this is only my personal feel, and label really needs to be reordered
> > then.
> > 
> 
> Status led description here does instead belong in jh7110-common.dtsi
> since all variant boards are using the same RGPIO3 (fourth GPIO on PMU
> domain).
> 
> >>
> >>> The following order of properties in device nodes is preferred:
> >>>
> >>> 1. "compatible"
> >>> 2. "reg"
> >>> 3. "ranges"
> >>> 4. Standard/common properties (defined by common bindings, e.g.
> >>> without
> >>> vendor-prefixes)
> >>> 5. Vendor-specific properties
> >>> 6. "status" (if applicable)
> >>> 7. Child nodes, where each node is preceded with a blank line
> >>
> >>> +               };
> >>> +       };
> >>> +};
> >>> +
> >>> +&gmac0 {
> >>> +       starfive,tx-use-rgmii-clk;
> >>> +       assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
> >>> +       assigned-clock-parents = <&aoncrg
> >>> JH7110_AONCLK_GMAC0_RMII_RTX>;
> >>> +       status = "okay";
> >>
> >> Vendor property starfive,tx-use-rgmii-clk should go after the common
> >> ones.
> > 
> > Okay, I will fix this (and the one below) in next revision.
> > 
> > Thanks,
> > Icenowy
> 
> Well then does the documentation follow recommended sort ordering?
> 
> https://www.kernel.org/doc/Documentation/devicetree/bindings/leds/common.yaml

I don't think so.

> Looks to me like it is not clear what is going on there with sort
> ordering. The recently accepted dts in-tree are a mix of "who cares?",
> alphabet sort, and preferentially but arbitrarily placing some things
> above others. The documentation is even different than all that.
> 
> Maybe if the documentation should be followed we should follow it, else
> fix the documentation firstly.

Basically agree here, the "sort by alphabetical order" requirement
(described here[1]) doesn't seem to play well in all cases: what Icenowy
claimed sounds reasonable to me and looks more natural than the general
rule. So maybe we should "override" the rule in subsystem-specific
bindings. I suggest raising a formal discussion about leds/common.yaml
and see whether this could land formally in the led's binding, and I'm
willing to do so.

Futhermore, similar order issues don't only occur in the LED binding,
but also, for example, the pinctrl stuff. In the example of
pinctrl-binding.txt[2], pinctrl-names always goes before pinctrl-[0-9]*,
which doesn't follow the general rule as well, and we could see the
opposite is also poppular in the accepted devicetrees. This should be
clarified, too.

> > 
> >>> +};
> >>> +
> >>> +&i2c0 {
> >>> +       status = "okay";
> >>> +};
> >>> +
> >>> +&mmc0 {
> >>> +       /* TODO: Ampak AP6256 Wi-Fi module attached here */
> >>> +       status = "disabled";
> >>> +};
> 
> Orange Pi RV schematic is published now. Please implement this
> description here.
> 
> You may also wish to review the StarFive JH7100 devicetree descriptions
> (and schematic), and additionally the published Milk-V Mars CM / Mars CM
> Lite schematic, for clues about AP6256. The required firmware files'
> intellectual property when during the last discussion about
> linux-firmware was determined to be Synaptics (labeled as Broadcomm) and
> rejected from inclusion due to no clear licensed permission for
> distribution. Maybe it is time to revisit this and find someone willing
> to do the work of resolving the license ambiguity?
> 
> >>> +
> >>> +&mmc1 {
> >>> +       /delete-property/ cd-gpios;
> >>> +       broken-cd;
> >>> +};
> >>> +
> >>> +&pcie0 {
> >>> +       status = "okay";
> >>> +};
> >>> +
> >>> +&pcie1 {
> >>> +       status = "okay";
> >>> +};
> >>> +
> >>> +&phy0 {
> >>> +       motorcomm,tx-clk-adj-enabled;
> >>> +       motorcomm,tx-clk-10-inverted;
> >>> +       motorcomm,tx-clk-100-inverted;
> >>> +       motorcomm,tx-clk-1000-inverted;
> >>> +       motorcomm,rx-clk-drv-microamp = <3970>;
> >>> +       motorcomm,rx-data-drv-microamp = <2910>;
> >>> +       rx-internal-delay-ps = <1500>;
> >>> +       tx-internal-delay-ps = <1500>;
> >>> +};
> >>
> >> Ditto, move the vendor properties below the common ones.
> 
> Yes and, one of us may review what is already in starfive/ dts to fix
> and send a patch for this mess of devicetree sort order. The issue
> repeats every time we look for an existing sample to use.

Oops, I've never expected that there're so many vendor-specific
properties mixed with others in starfive's devicetrees. I'm willing to
clean them up when available, but feel free to take the work since I'm a
little busy.

> >>
> >>> +&pwmdac {
> >>> +       status = "okay";
> >>> +};
> >>> +
> >>> +&spi0 {
> >>> +       status = "okay";
> >>> +};
> >>> -- 
> >>> 2.49.0
> >>>
> >>
> >> Best regards,
> >> Yao Zi
> > 
> 
> B.R.,  -E Shattow

Regards,
Yao Zi

[1]: https://elixir.bootlin.com/linux/v6.16-rc6/source/Documentation/devicetree/bindings/dts-coding-style.rst#L115-L124
[2]: https://elixir.bootlin.com/linux/v6.16-rc6/source/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt#L74-L97

