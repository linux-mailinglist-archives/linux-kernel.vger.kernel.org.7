Return-Path: <linux-kernel+bounces-796569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4D6B402AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6631F4E3E8F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8633081A8;
	Tue,  2 Sep 2025 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFPc0Bif"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B22307AE6;
	Tue,  2 Sep 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819101; cv=none; b=tK6IWICm9za0/q4Uzjsbzyg1ZkGur8qxY2QnD5W60xV/Mw2g/pGonf9HBUt42o3ewzS9RWmnpN62EPw+QZ0ZY6fTY3ft31DSnHetYy1ddAyypx9nyjO0DKwbohoKareJ05nF/3EaQHx5dUqaweeJAwTaZtJtQOMhMFrSkOhGWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819101; c=relaxed/simple;
	bh=nva1mBFyuVVPLmXTARaBeIiR0B0nMGh017Yl7IN3WDQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=f4QcU9J/YTyC5XnD5HqHP+laczDuSuFSzvhvkb//gUzBLxORnFPoLmmn14EdiQ2W0GygvAnLl7nIiNnI5622tX69wsmb/9qpYIVTMhp44fEDcidzNbxU8HK9vv6l27Xuwi6EO2d+cVuxGVzHVx//NTXIv26O5eThBGbaz8avEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFPc0Bif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C42EC4CEF4;
	Tue,  2 Sep 2025 13:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756819100;
	bh=nva1mBFyuVVPLmXTARaBeIiR0B0nMGh017Yl7IN3WDQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=pFPc0BifN8nXlB5qQF3uMhlUA2pS/cvrdR7LZYW9cfLFnPrqKhQFg8HjdWMjkJSE6
	 /2DAUy4Ow72fxShmqCwuvTiaivE2iaaYrs3CaRCSLz4MDrEggMLXEoHOdZU7WtVYM4
	 MEndwIA0vPKw4cTPzji1gUMPgiqc+rB4UpEb+PurhEiWcQ/BVdcLdovRKdc41HaapM
	 75mA1fV9TJqGmNZF/F2wZLUNbkbGmvmkYfp8SMpmk0pUj/e4hJFI665+JmZx5p9jSn
	 YV/YMps4fSvpGyBnJ2r8tz0J4tPp0+KmQ1svnfeQk0qLMqKuWbfwYjyb9rezfsfz/o
	 7F12oFvJN6sXQ==
Date: Tue, 02 Sep 2025 08:18:18 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: soc@lists.linux.dev, Conor Dooley <conor+dt@kernel.org>, 
 dkodihalli@nvidia.com, Arnd Bergmann <arnd@arndb.de>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 nfraprado@collabora.com, linux-arm-kernel@lists.infradead.org, 
 Will Deacon <will@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Yuxiao Zhang <yuxiaozhang@google.com>, Joel Stanley <joel@jms.id.au>, 
 Eric Biggers <ebiggers@google.com>, Taniya Das <quic_tdas@quicinc.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, spuranik@nvidia.com, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 linux-kernel@vger.kernel.org, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 linux-aspeed@lists.ozlabs.org, Rom Lemarchand <romlem@google.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Mo Elbadry <elbadrym@google.com>, 
 leohu@nvidia.com, Catalin Marinas <catalin.marinas@arm.com>, 
 devicetree@vger.kernel.org, William Kennington <wak@google.com>, 
 wthai@nvidia.com
To: Ryan Chen <ryan_chen@aspeedtech.com>
In-Reply-To: <20250901031311.1247805-1-ryan_chen@aspeedtech.com>
References: <20250901031311.1247805-1-ryan_chen@aspeedtech.com>
Message-Id: <175678731287.878052.15508784585002236677.robh@kernel.org>
Subject: Re: [PATCH v5 0/5] Introduce ASPEED AST2700 BMC SoC


On Mon, 01 Sep 2025 11:13:06 +0800, Ryan Chen wrote:
> This introduces initial support for the Aspeed AST2700 SoC and the AST2700
> Evaluation Board (EVB) to the Linux kernel. The AST27XX is the 8th
> generation Baseboard Management Controller (BMC) SoC from Aspeed,
> featuring improved performance, enhanced security, and expanded I/O
> capabilities compared to previous generations.
> 
> AST27XX SOC Family
>  - https://www.aspeedtech.com/server_ast2700/
>  - https://www.aspeedtech.com/server_ast2720/
>  - https://www.aspeedtech.com/server_ast2750/
> 
> Bindings Dependencies:
> - intc-ic: Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> - scu/silicon-id: Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
> - gpio: Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> - mdio: Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> 
> v5:
> - modify ast27XX 7th generation description to 8th generation.
> - aspeed.yaml
>  - modify missing blank line.
> - Kconfig.platforms
>  - modify ast27XX 7th generation to 8th generation.
> 
> v4:
> - make CHECK_DTBS=y arch/arm64/boot/dts/aspeed/ fix.
> - modify commit message remove itemlize.
> - remove modify aspeed,ast2700-intc.yaml patch.
> - aspeed.yaml
>  - Add AST2700 board compatible.
> - aspeed-g7.dtsi
>  - modify all size-cells from 1 to 2.
>  - add serial aliases, gpio, mdio, uart0 ~ 14.
>  - add firmware for optee, reserved memory for atf and optee.
>  - modify cpu@0 to cpu0: cpu@0.
>  - fix intc-ic for yaml dependency.
> - ast2700-evb.dts
>  - update stdout-path = "serial12:115200n8";
> 
> v3:
> - https://lore.kernel.org/all/20241212155237.848336-1-kevin_chen@aspeedtech.com/
> - Split clk and reset driver to other commits, which are in series of
>   "Add support for AST2700 clk driver".
> - For BMC console by UART12, add uart12 using ASPEED INTC architecture.
> 
> aspeed,ast2700-intc.yaml
> - Add minItems to 1 to fix the warning by "make dtbs_check W=1".
> - Add intc1 into example.
> 
> Kconfig.platforms
>   - Remove MACH_ASPEED_G7.
> 
> Ryan Chen (5):
>   dt-bindings: arm: aspeed: Add AST2700 board compatible
>   arm64: Kconfig: Add Aspeed SoC family (ast27XX) Kconfig support
>   arm64: dts: aspeed: Add initial AST2700 SoC device tree
>   arm64: dts: aspeed: Add AST2700 Evaluation Board
>   arm64: configs: Update defconfig for AST2700 platform support
> 
>  .../bindings/arm/aspeed/aspeed.yaml           |   6 +
>  arch/arm64/Kconfig.platforms                  |   6 +
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/aspeed/Makefile           |   4 +
>  arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi     | 452 ++++++++++++++++++
>  arch/arm64/boot/dts/aspeed/ast2700-evb.dts    |  22 +
>  arch/arm64/configs/defconfig                  |   1 +
>  7 files changed, 492 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
>  create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
>  create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts
> 
> --
> 2.34.1
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
 Base: attempting to guess base-commit...
 Base: tags/v6.17-rc1 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/aspeed/' for 20250901031311.1247805-1-ryan_chen@aspeedtech.com:

arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@12101b00 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@12101b00 (aspeed,ast2700-intc-ic): interrupts: [[0, 192, 4], [0, 193, 4], [0, 194, 4], [0, 195, 4], [0, 196, 4], [0, 197, 4], [0, 198, 4], [0, 199, 4], [0, 200, 4], [0, 201, 4]] is too long
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: syscon@12c02000 (aspeed,ast2700-scu0): #size-cells: 1 was expected
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: syscon@14c02000 (aspeed,ast2700-scu1): compatible: ['aspeed,ast2700-scu1'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: syscon@14c02000 (aspeed,ast2700-scu1): 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: syscon@14c02000 (aspeed,ast2700-scu1): '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: syscon@14c02000 (aspeed,ast2700-scu1): '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18100 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18100 (aspeed,ast2700-intc-ic): interrupts-extended: [[5, 0]] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18110 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18110 (aspeed,ast2700-intc-ic): interrupts-extended: [[5, 1]] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18120 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18120 (aspeed,ast2700-intc-ic): interrupts-extended: [[5, 2]] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18130 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18130 (aspeed,ast2700-intc-ic): interrupts-extended: [[5, 3]] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18140 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18140 (aspeed,ast2700-intc-ic): interrupts-extended: [[5, 4]] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18150 (aspeed,ast2700-intc-ic): #interrupt-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@14c18150 (aspeed,ast2700-intc-ic): interrupts-extended: [[5, 5]] is too short
	from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#






