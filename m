Return-Path: <linux-kernel+bounces-722546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A46AFDBED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9AB91891EEA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA0323817A;
	Tue,  8 Jul 2025 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PClW/fYt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF42221287;
	Tue,  8 Jul 2025 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752018240; cv=none; b=MqJVEpn4pIz2xdViFcsNQe7F6kwFDXzOtzNdezKtwft6clGTvIBYMcawpFIaAmzcQwGnOvc0SZc0uSOKQjwlQQwu+aNIMS3MWH1rG15xvd/8Gi8q67qXH7u8XbIwIxyDAuhu3fpfIFMhceySrnnFWTDzd/VNSwwXzXiVTw1IvDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752018240; c=relaxed/simple;
	bh=MyHT24SU4d/OcfVR/HORIYcHNaCz1cEMNkXoEh69ZOo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=OC20gSiKnamyYqzQaK+pLDVckJqBjfTRvYbl6kYSZkmeyxNSPc1A/ASuTMZ1lTZeiix/8sjgLj8J+o2Xa4wUTaj7+zRLE0t/IwqTb2BcqXt4E8HSECgxkLd4SwTTJtZvRxQ3BI2Gidn0tn3yZQ9D4IbbAc/ngsZZexDQ/W2UZ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PClW/fYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EFFC4CEED;
	Tue,  8 Jul 2025 23:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752018240;
	bh=MyHT24SU4d/OcfVR/HORIYcHNaCz1cEMNkXoEh69ZOo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=PClW/fYtohaIktOF+FL8cPr1pQY2uHqmLdpn3Narwo4dhyTfotSE+H2YjPxKG3yV9
	 D4lw/mLJz9irTCvegar9j6ZhpDEseN3k0Mj44mvkAz+AomKwChUnI3+MekE395asHE
	 fg5JQSMYnLiXwyGTTn01N1nMChGQZxFVWlIdD6YGhZpGBoCCo3ViO6DkcZWLZSXx/C
	 O7j3dYexyLDf5T01V/4G14o3ffiyWEyzlfFvjBeO/P13R3MDgU1NEq88ojEc3eG18p
	 uTKxsMmsyPyXJt6MlvGHI/wVViJFea0CGhqlxiygTONu0nRsa4D5EFIHa7FWwjpu1G
	 oCidF3T0Fx4bA==
Date: Tue, 08 Jul 2025 18:43:58 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 Nishanth Menon <nm@ti.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Tero Kristo <kristo@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
In-Reply-To: <20250708184841.72933-1-stefano.radaelli21@gmail.com>
References: <20250708184841.72933-1-stefano.radaelli21@gmail.com>
Message-Id: <175201817452.1646137.6353612128009692552.robh@kernel.org>
Subject: Re: [PATCH v1 0/3] Add support for Variscite VAR-SOM-AM62P5 and
 Symphony board


On Tue, 08 Jul 2025 20:48:32 +0200, Stefano Radaelli wrote:
> This patch series adds support for the Variscite VAR-SOM-AM62P system on module
> and the Symphony carrier board.
> 
> The VAR-SOM-AM62P is a compact SOM based on the TI AM62P Sitara processor,
> featuring up to 8GB DDR4 memory, eMMC storage, Gigabit Ethernet, and various
> peripheral interfaces. The Symphony board is a feature-rich carrier board that
> showcases the SOM capabilities.
> 
> The series includes:
> - Device tree bindings documentation
> - SOM device tree with common peripherals
> - Symphony carrier board device tree with board-specific features
> 
> The implementation follows the standard SOM + carrier board pattern where the
> SOM dtsi contains only peripherals mounted on the module, while carrier-specific
> interfaces are enabled in the board dts.
> 
> Tested on VAR-SOM-AM62P with Symphony carrier board.
> 
> Stefano Radaelli (3):
>   dt-bindings: arm: ti: Add bindings for Variscite VAR-SOM-AM62P
>   arm64: dts: ti: Add support for Variscite VAR-SOM-AM62P
>   arm64: dts: ti: Add support for Variscite VAR-SOM-AM62P Symphony Board
> 
>  .../devicetree/bindings/arm/ti/k3.yaml        |   5 +
>  .../dts/ti/k3-am62p5-var-som-symphony.dts     | 545 ++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi | 379 ++++++++++++
>  3 files changed, 929 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
> 
> 
> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> prerequisite-patch-id: 7e8493f8ed01ee319f827119ffdac7531afbbc4d
> --
> 2.43.0
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
 Base: using specified base-commit d7b8f8e20813f0179d8ef519541a3527e7661d3a
 Deps: looking for dependencies matching 1 patch-ids

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/ti/' for 20250708184841.72933-1-stefano.radaelli21@gmail.com:

ti,pindir-d0-out-d1-in: size (4) error for type flag
ti,pindir-d0-out-d1-in: size (4) error for type flag
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: / (variscite,am62p-var-som): pwrseq@0: 'anyOf' conditional failed, one must be fixed:
	'reg' is a required property
	'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: pinctrl@4084000 (pinctrl-single): 'wkup_clkout0_pins_default' does not match any of the regexes: '-pins(-[0-9]+)?$|-pin$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: pinctrl@f4000 (pinctrl-single): 'btgrp', 'extcon-pins-default', 'main-i2c0-pins-default', 'main-i2c1-pins-default', 'main-i2c3-pins-default', 'main-mcan0-pins-default', 'main-mcasp1-pins-default', 'main-mdio1-pins-default', 'main-mmc1-pins-default', 'main-mmc2-pins-default', 'main-rgmii2-pins-default', 'main-uart2-pins-default', 'main-uart6-pins-default', 'main-usb1-pins-default', 'main_spi0-pins-default', 'main_spi2-pins-default', 'ov5640-pins-default', 'pca9534_irq_default', 'pinctrl-wifi-default', 'pinmux_emmc_pwrseq_pins', 'restouchgrp', 'uart5-pins-default', 'vdd-mmc1-pins-default', 'vdd-sd-dv-pins-default' do not match any of the regexes: '-pins(-[0-9]+)?$|-pin$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: serial@2850000 (ti,am64-uart): Unevaluated properties are not allowed ('bluetooth_iw61x' was unexpected)
	from schema $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: bluetooth_iw61x (nxp,88w8987-bt): $nodename:0: 'bluetooth_iw61x' does not match '^bluetooth(@.*)?$'
	from schema $id: http://devicetree.org/schemas/net/bluetooth/nxp,88w8987-bt.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: camera@3c (ovti,ov5640): 'AVDD-supply' is a required property
	from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov5640.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: camera@3c (ovti,ov5640): 'DVDD-supply' is a required property
	from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov5640.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: camera@3c (ovti,ov5640): 'DOVDD-supply' is a required property
	from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov5640.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: gpio@20 (nxp,pca9534): 'eth_mdio_enable_hog', 'eth_som_vselect_hog', 'usb3_sel_hog' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: usb3_sel_hog: $nodename:0: 'usb3_sel_hog' does not match '-hog(-[0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-hog.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: eth_som_vselect_hog: $nodename:0: 'eth_som_vselect_hog' does not match '-hog(-[0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-hog.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: eth_mdio_enable_hog: $nodename:0: 'eth_mdio_enable_hog' does not match '-hog(-[0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-hog.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: spi@20100000 (ti,am654-mcspi): ti,pindir-d0-out-d1-in: 1 is not of type 'boolean'
	from schema $id: http://devicetree.org/schemas/spi/omap-spi.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: spi@20100000 (ti,am654-mcspi): Unevaluated properties are not allowed ('ti,pindir-d0-out-d1-in' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/omap-spi.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: spi@20120000 (ti,am654-mcspi): ti,pindir-d0-out-d1-in: 1 is not of type 'boolean'
	from schema $id: http://devicetree.org/schemas/spi/omap-spi.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: spi@20120000 (ti,am654-mcspi): Unevaluated properties are not allowed ('ti,pindir-d0-out-d1-in' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/omap-spi.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: usb@f900000 (ti,am62-usb): 'connector' does not match any of the regexes: '^pinctrl-[0-9]+$', '^usb@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/usb/ti,am62-usb.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: usb@f900000 (ti,am62-usb): usb@31000000:port@0:reg:0:0: 0 is less than the minimum of 1
	from schema $id: http://devicetree.org/schemas/usb/ti,am62-usb.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: usb@f900000 (ti,am62-usb): usb@31000000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'dr_mode', 'maximum-speed', 'port@0', 'snps,usb2-gadget-lpm-disable', 'snps,usb2-lpm-disable', 'usb-role-switch' were unexpected)
	from schema $id: http://devicetree.org/schemas/usb/ti,am62-usb.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: usb@31000000 (snps,dwc3): port@0:reg:0:0: 0 is less than the minimum of 1
	from schema $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: usb@31000000 (snps,dwc3): Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'dr_mode', 'maximum-speed', 'port@0', 'snps,usb2-gadget-lpm-disable', 'snps,usb2-lpm-disable', 'usb-role-switch' were unexpected)
	from schema $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: connector (gpio-usb-b-connector): compatible: 'oneOf' conditional failed, one must be fixed:
	['gpio-usb-b-connector', 'usb-c-connector'] is too long
	'gpio-usb-b-connector' is not one of ['usb-a-connector', 'usb-b-connector', 'usb-c-connector']
	'samsung,usb-connector-11pin' was expected
	'usb-b-connector' was expected
	from schema $id: http://devicetree.org/schemas/connector/usb-connector.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: gpio-keys (gpio-keys): 'back', 'home', 'menu' do not match any of the regexes: '^(button|event|key|switch|(button|event|key|switch)-[a-z0-9-]+|[a-z0-9-]+-(button|event|key|switch))$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/input/gpio-keys.yaml#
arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dtb: gpio-leds (gpio-leds): 'heartbeat' does not match any of the regexes: '(^led-[0-9a-f]$|led)', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#






