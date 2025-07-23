Return-Path: <linux-kernel+bounces-741837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9DEB0E98D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D21E1C820A5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9703C2147FB;
	Wed, 23 Jul 2025 04:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4Ywp0M+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B451820DD52;
	Wed, 23 Jul 2025 04:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753244347; cv=none; b=Vp0LFtIv0w+vgLZUR00HKd2j8O8fFJyCFW0vOg/6pvHUscDalQwTyEVIf5uSPZNH9Y9NmcZ+G2EhxmT5RzIET09ud0vb2OgW7Gc7kYPfp7Nnuhh0JVjhCPYcO7WFgDDGuBUNaT68gMPEAsC5FSFgIbi563Bd+4ghnE/7sqmPIQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753244347; c=relaxed/simple;
	bh=GacNtb7sskwb36O4NWQBdsR5VCTCEGIjnMoDH5/Rf+g=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=M02vMJKBm7fe/RNWGqYt3ub2Nw1XhZ4j1YTlFkBBjcWQ0Tfsv2E3UpyM3/NGeBE659lbU9H2TXqCt48Akl8A1J2SoIGLvST1PLqKnYGaKJ8ocplt2EepwgYG7VIc/IZW74/0BBlAVLwW8QV6VCIpN5db+jxohlINteptaRDuIqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4Ywp0M+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AC9C4CEE7;
	Wed, 23 Jul 2025 04:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753244346;
	bh=GacNtb7sskwb36O4NWQBdsR5VCTCEGIjnMoDH5/Rf+g=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=n4Ywp0M+HOmdlM2E2S1SUOJyvHJFHYQoVbYrlxUQgtibf2i+wnBM6r3ufWFqFnjut
	 6OvIniy+jzyYeK27UyZCdmNJKPC9zoSppxpwA5kbsWMwJMZot95doY54YCP6Zc4obb
	 HPIg9aahsrcdeGtXWVh+mosSroHorTEQBX5c7HnBXNliSwVwE5EKHJkO/bBCwi0iQ1
	 8wT9+2NDOwcKwA0bZflhf3hREsifLsJHJk1vvprGfkVYOXSaM4nbAO7ZzEcXxAWUkz
	 /AD1kQ6eKF75vmjOezJc7/g7QtNpEXeRlfZiDqKtnBmXRF9LwfxelSD1Y7gjR0s4Km
	 w9kWO4QZ2L+qQ==
Date: Tue, 22 Jul 2025 23:19:05 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: conor+dt@kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
 joel@jms.id.au, linux-arm-kernel@lists.infradead.org, 
 andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org, 
 devicetree@vger.kernel.org
To: Donald Shannon <donalds@nvidia.com>
In-Reply-To: <20250723014239.22667-1-donalds@nvidia.com>
References: <20250723014239.22667-1-donalds@nvidia.com>
Message-Id: <175324420395.1136488.7622581130155119218.robh@kernel.org>
Subject: Re: [PATCH v6 0/2] Adding device tree and binding for NVIDIA
 GB200-UT3.0b


On Tue, 22 Jul 2025 18:42:37 -0700, Donald Shannon wrote:
> Patch 1 adds the binding for the NVIDIA GB200-UT3.0b platform.
> Patch 2 adds the device tree for the NVIDIA GB200-UT3.0b platform.
> 
> This is an Aspeed AST2600 based unit testing platform for GB200.
> UT3.0b is different than nvidia-gb200nvl-bmc due to networking topology
> differences, additional gpio expanders, and voltage regulator gating
> some devices.
> 
> Reference to Ast2600 SOC [1].
> Reference to Blackwell GB200NVL Platform [2].
> 
> Link: https://www.aspeedtech.com/server_ast2600/ [1]
> Link: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]
> Signed-off-by: Donald Shannon <donalds@nvidia.com>
> ---
> Changes v1 -> v2:
>   - Changed phy-mode to rgmii-id [Lunn]
>   - Removed redundant max-speed for mac0 [Lunn]
>   - Fixed typo from gb200nvl to gb200 in Makefile
> Changes v2 -> v3:
>  - Fixed whitespace issues [Krzysztof]
>  - Fixed schema validation issues from my end ( there are still issues
>  with the aspeed dtsi file that are not related to this new dts)
>  [Herring]
>  - Reordered to follow style guide [Krzysztof]
>  - Removed redundant status okays
>  - Changed vcc to vdd for the power gating on the gpio expanders
> Changes v3 -> v4:
>   - Added changelog [Krzysztof]
>   - Added nvidia,gb200-ut30b board binding [Krzysztof]
>   - Removed unused imports
>   - Reordered a couple other style guide violations
>   - Added back in a couple needed "status okay"s
> Changes v4 -> v5:
>  - Resumed my patch after a pause
>  - Don't plan to make this include of nvidia-gb200nvl-bmc due to some
>  platform differences
>  - Fixed io expanders that weren't gated by the 3.3V standby regulator
>  - Fixed incorrect interrupt pin for one IO expander
>  - Removed some IO expanders and I2C busses
> Changes v5 -> v6:
>  - Fixed subject line
>  - Added missing gpio-key compatible type to buttons
> ---
> 
> Donald Shannon (2):
>   dt-bindings: arm: aspeed: Add NVIDIA GB200-UT3.0b  board
>   ARM: dts: aspeed: Add NVIDIA GB200 UT3.0b board
> 
>  .../bindings/arm/aspeed/aspeed.yaml           |    1 +
>  arch/arm/boot/dts/aspeed/Makefile             |    1 +
>  .../aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts  | 1028 +++++++++++++++++
>  3 files changed, 1030 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts
> 
> 
> base-commit: 05adbee3ad528100ab0285c15c91100e19e10138
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
 Base: using specified base-commit 05adbee3ad528100ab0285c15c91100e19e10138

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250723014239.22667-1-donalds@nvidia.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/apb/fsi@1e79b000/cfam@0,0/hub@3400/cfam@5,0/hub@3400: failed to match any schema with compatible: ['fsi-master-hub']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: timer (arm,armv7-timer): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /sdram@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: bus@1e600000 (aspeed,ast2600-ahbc): compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dtb: /gpio-fsi/cfam@0,0/i2c@1800: failed to match any schema with compatible: ['ibm,fsi-i2c-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: syscon@1e6e2000 (aspeed,ast2600-scu): 'smp-memram@180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^pinctrl-[0-9]+$', '^silicon-id@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/syscon@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: adc@1e6e9000 (aspeed,ast2600-adc0): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: adc@1e6e9100 (aspeed,ast2600-adc1): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: crypto@1e6fa000 (aspeed,ast2600-acry): 'aspeed,ahbc' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: lpc@1e789000 (aspeed,ast2600-lpc-v2): reg-io-width: 4 is not of type 'object'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: lpc@1e789000 (aspeed,ast2600-lpc-v2): lpc-snoop@80: 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: kcs@24 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: kcs@28 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: kcs@2c (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: kcs@114 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/sdc@1e740000/sdhci@1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/sdc@1e740000/sdhci@1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: fsi@1e79b000 (aspeed,ast2600-fsi-master): compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/fsi@1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: fsi@1e79b100 (aspeed,ast2600-fsi-master): compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/fsi@1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: /ahb/apb/dma-controller@1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: buttons (gpio-keys): button-power: 'anyOf' conditional failed, one must be fixed:
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: buttons (gpio-keys): button-power: 'oneOf' conditional failed, one must be fixed:
		'interrupts' is a required property
		'interrupts-extended' is a required property
	'gpios' is a required property
	from schema $id: http://devicetree.org/schemas/input/gpio-keys.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: buttons (gpio-keys): button-power: 'linux,code' is a required property
	from schema $id: http://devicetree.org/schemas/input/gpio-keys.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: buttons (gpio-keys): button-power: Unevaluated properties are not allowed ('gpio' was unexpected)
	from schema $id: http://devicetree.org/schemas/input/gpio-keys.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: buttons (gpio-keys): button-uid: 'anyOf' conditional failed, one must be fixed:
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: buttons (gpio-keys): button-uid: 'oneOf' conditional failed, one must be fixed:
		'interrupts' is a required property
		'interrupts-extended' is a required property
	'gpios' is a required property
	from schema $id: http://devicetree.org/schemas/input/gpio-keys.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: buttons (gpio-keys): button-uid: 'linux,code' is a required property
	from schema $id: http://devicetree.org/schemas/input/gpio-keys.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dtb: buttons (gpio-keys): button-uid: Unevaluated properties are not allowed ('gpio' was unexpected)
	from schema $id: http://devicetree.org/schemas/input/gpio-keys.yaml#






