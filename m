Return-Path: <linux-kernel+bounces-821861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD6FB8279E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC454868C4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD79E1FF1C4;
	Thu, 18 Sep 2025 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQTiS6cV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00D028F5;
	Thu, 18 Sep 2025 01:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758158070; cv=none; b=P6RTh0lOOgq9VAyfHCJxapvc6v5C2cuFzKl+DvXxP69A+7qS0PHYHIj2jGIDgIhEz3ikKPQnaNt1EYX64iUchYF7TXnRwJstRwor9X6LMvSlDC/ns1a410iIUcFMuTV8jX017/VP4zG9E6B55YZhGf9iCai8V9kFsYv7ltNFX44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758158070; c=relaxed/simple;
	bh=g3c8XhEz0bPJ7eh9V+y3pI2GRwX8vp7wDlq6Xzmvofo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=mXqZNdXmHY5m7vHywcBsJ43EwiRKSB3fZYKtUO1oto6kT/mvRazkwlSozGA/8/S6OkzES5mcZX1PZwEpO8XkUMQ5z0yj6OFLkKUTPuOp+qiIIkBoul0fuxDWa0tozEVm0F0eph18NljZM7k76XhJ4NvqcTstRlkYYiHnYERH1IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQTiS6cV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74863C4CEE7;
	Thu, 18 Sep 2025 01:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758158070;
	bh=g3c8XhEz0bPJ7eh9V+y3pI2GRwX8vp7wDlq6Xzmvofo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=mQTiS6cVe6C5naZ9M5DZ6pnoyBwC8juaDbIpaPSjcRH3Wk7A6jygwu7H09GU9dIla
	 WjOUNunVqVuhjMT+MONnQxpQNf+ZPYP4wAnuTn8tZMy2fTVB2AwcYlz+c6NmGEerYM
	 5IdwUWNU1g7mcI7D0/UblSwouph9m0SIm406U9RFaB3JlF6xJeGfN3UVIMMVIemQeN
	 lI1GjEFs+vaxX8SJQh69XTyoX4dG5t6ZdoCPCK9v0YIy6oEGdqbuFvsAMvbWdk483N
	 PycgCnHHXk90xgOGKGufygKDBk/zjjsjXx+AeclLN19O3k1kZA+xiRGIp0+BisYF3X
	 mS8WLfropyk2Q==
Date: Wed, 17 Sep 2025 20:14:28 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
To: Rebecca Cran <rebecca@bsdio.com>
In-Reply-To: <20250917180428.810751-1-rebecca@bsdio.com>
References: <20250917180428.810751-1-rebecca@bsdio.com>
Message-Id: <175815739133.3885492.1346225052792549378.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] Add device tree for ASRock Rack ALTRAD8 BMC


On Wed, 17 Sep 2025 12:04:24 -0600, Rebecca Cran wrote:
> The ASRock Rack ALTRAD8 BMC is an Aspeed AST2500-based BMC for the
> ALTRAD8UD-1L2T and ALTRAD8UD2-1L2Q boards with an Ampere Altra
> processor. The BMC runs OpenBMC.
> 
> These patches add a device tree and binding for the BMC.
> 
> **Changes between v1 and v2**
> 
> - Reordered nodes to be in alphabetical order.
> - Removed status lines.
> - Fixed naming.
> 
> There are still several warnings from
> make CHECK_DTBS=y ARCH=arm W=1 aspeed/aspeed-bmc-asrock-altrad8.dtb
> I believe the only one which is reporting an issue in my dts file (as opposed
> to included files) is the first, and that's because the code partition contains
> the TF-A and UEFI areas. I couldn't see a way to suppress it.
> 
> aspeed-bmc-asrock-altrad8.dts:578.16-581.6: Warning (unique_unit_address_if_enabled): /ahb/spi@1e630000/flash@0/partitions/code@400000: duplicate unit-address (also used in node /ahb/spi@1e630000/flash@0/partitions/tfa@400000)
> aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/memory-controller@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2500-sdram-edac']
> aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/syscon@1e6e2000/p2a-control@2c: failed to match any schema with compatible: ['aspeed,ast2500-p2a-ctrl']
> aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2500-gfx', 'syscon']
> aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/timer@1e782000: failed to match any schema with compatible: ['aspeed,ast2400-timer']
> aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/pwm-tacho-controller@1e786000: failed to match any schema with compatible: ['aspeed,ast2500-pwm-tacho']
> aspeed-bmc-asrock-altrad8.dtb: fan@0: aspeed,fan-tach-ch: b'\x00\x08' is not of type 'object', 'integer', 'array', 'boolean', 'null'
> 	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> aspeed-bmc-asrock-altrad8.dtb: fan@1: aspeed,fan-tach-ch: b'\x01\t' is not of type 'object', 'integer', 'array', 'boolean', 'null'
> 	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> aspeed-bmc-asrock-altrad8.dtb: fan@2: aspeed,fan-tach-ch: b'\x02\n' is not of type 'object', 'integer', 'array', 'boolean', 'null'
> 	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> aspeed-bmc-asrock-altrad8.dtb: fan@3: aspeed,fan-tach-ch: b'\x03\x0b' is not of type 'object', 'integer', 'array', 'boolean', 'null'
> 	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> aspeed-bmc-asrock-altrad8.dtb: fan@4: aspeed,fan-tach-ch: b'\x04\x0c' is not of type 'object', 'integer', 'array', 'boolean', 'null'
> 	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> aspeed-bmc-asrock-altrad8.dtb: fan@5: aspeed,fan-tach-ch: b'\x05\r' is not of type 'object', 'integer', 'array', 'boolean', 'null'
> 	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> aspeed-bmc-asrock-altrad8.dtb: fan@6: aspeed,fan-tach-ch: b'\x06\x0e' is not of type 'object', 'integer', 'array', 'boolean', 'null'
> 	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> aspeed-bmc-asrock-altrad8.dtb: fan@7: aspeed,fan-tach-ch: b'\x07\x0f' is not of type 'object', 'integer', 'array', 'boolean', 'null'
> 	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> aspeed-bmc-asrock-altrad8.dtb: lpc@1e789000 (aspeed,ast2500-lpc-v2): reg-io-width: 4 is not of type 'object'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
> aspeed-bmc-asrock-altrad8.dtb: lpc@1e789000 (aspeed,ast2500-lpc-v2): lpc-snoop@90: 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
> aspeed-bmc-asrock-altrad8.dtb: kcs@24 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
> aspeed-bmc-asrock-altrad8.dtb: kcs@28 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
> aspeed-bmc-asrock-altrad8.dtb: kcs@2c (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
> aspeed-bmc-asrock-altrad8.dtb: kcs@114 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
> aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2500-lhc']
> aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2500-ibt-bmc']
> aspeed-bmc-asrock-altrad8.dtb: gpio@1c (nxp,pca9557): '#address-cells', '#size-cells', 'gpio@0', 'gpio@1', 'gpio@2', 'gpio@3', 'gpio@4', 'gpio@5', 'gpio@6', 'gpio@7' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#
> 
> 
> Rebecca Cran (2):
>   dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8 board
>   ARM: dts: aspeed: add device tree for ASRock Rack ALTRAD8 BMC
> 
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml |   1 +
>  arch/arm/boot/dts/aspeed/Makefile                        |   1 +
>  arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts   | 633 ++++++++++++++++++++
>  3 files changed, 635 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts
> 
> 
> base-commit: 5aca7966d2a7255ba92fd5e63268dd767b223aa5
> --
> 2.47.3
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
 Base: using specified base-commit 5aca7966d2a7255ba92fd5e63268dd767b223aa5

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250917180428.810751-1-rebecca@bsdio.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/memory-controller@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2500-sdram-edac']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/syscon@1e6e2000/p2a-control@2c: failed to match any schema with compatible: ['aspeed,ast2500-p2a-ctrl']
arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr630.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2500-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2500-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/timer@1e782000: failed to match any schema with compatible: ['aspeed,ast2400-timer']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/pwm-tacho-controller@1e786000: failed to match any schema with compatible: ['aspeed,ast2500-pwm-tacho']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: fan@0: aspeed,fan-tach-ch: b'\x00\x08' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: fan@1: aspeed,fan-tach-ch: b'\x01	' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: fan@2: aspeed,fan-tach-ch: b'\x02
' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: fan@3: aspeed,fan-tach-ch: b'\x03\x0b' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: fan@4: aspeed,fan-tach-ch: b'\x04\x0c' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: fan@5: aspeed,fan-tach-ch: b'\x05
' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: fan@6: aspeed,fan-tach-ch: b'\x06\x0e' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: fan@7: aspeed,fan-tach-ch: b'\x07\x0f' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: lpc@1e789000 (aspeed,ast2500-lpc-v2): reg-io-width: 4 is not of type 'object'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: lpc@1e789000 (aspeed,ast2500-lpc-v2): lpc-snoop@90: 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: kcs@24 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: kcs@28 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: kcs@2c (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: kcs@114 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2500-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2500-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: gpio@1c (nxp,pca9557): '#address-cells', '#size-cells', 'gpio@0', 'gpio@1', 'gpio@2', 'gpio@3', 'gpio@4', 'gpio@5', 'gpio@6', 'gpio@7' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#






