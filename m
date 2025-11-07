Return-Path: <linux-kernel+bounces-889799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EA8C3E8DA
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 06:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64FEC3AA7B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 05:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9497293B5F;
	Fri,  7 Nov 2025 05:56:34 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485FF2848AA;
	Fri,  7 Nov 2025 05:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762494994; cv=none; b=AQLPclXgLWdtFcT0+5dScTtyKyb57wISlVBCF3vLGR26eV/a6mPs8D9ydEBcFKhHJJ8n/unZ42ZZKVhMBj0THHj86HJA4g7RuR7SGYoxbxUjVjpdcqqVFGyE4P02DTOtQmnPGymowCOQn4U/34PENuiE5rvQJKkKLKXUruIBI4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762494994; c=relaxed/simple;
	bh=+wgkmN6EN4R4vgcjEVKkG6hTRcEvviCepiWVL4XFeuU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GaBR/b+lKzIVvhwOk8FI9tEt/BDZlSGQXj57Ck0VP4RIrduUHjKe+JLzoBpzHTQQvzsP6VKQ4NVEuD+QE3YagyvLIfWsILU53m84VIBKgO0s7sKiCo1Kb44eugj5xMfSd5AsnT8qf4hwMMMlzOMnecPwc0uQhwOAhSLAOQctyl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 7 Nov
 2025 13:56:30 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 7 Nov 2025 13:56:29 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, <bmc-sw@aspeedtech.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, <jk@codeconstruct.com.au>, Lee Jones
	<lee@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
	<will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson
	<bjorn.andersson@oss.qualcomm.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Nishanth Menon <nm@ti.com>,
	<nfraprado@collabora.com>, Taniya Das <quic_tdas@quicinc.com>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/5] Introduce ASPEED AST27xx BMC SoC
Date: Fri, 7 Nov 2025 13:56:24 +0800
Message-ID: <20251107055629.4075519-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This introduces initial support for the Aspeed AST27xx SoC and the AST2700
Evaluation Board (EVB) to the Linux kernel. The AST27xx is the 8th
generation Baseboard Management Controller (BMC) SoC from Aspeed,
featuring improved performance, enhanced security, and expanded I/O
capabilities compared to previous generations.

AST27xx SOC Family
 - https://www.aspeedtech.com/server_ast2700/
 - https://www.aspeedtech.com/server_ast2720/
 - https://www.aspeedtech.com/server_ast2750/

Bindings Dependencies: check with "make CHECK_DTBS=y W=1 arch/arm64/boot/dts/aspeed/ dtbs"
- scu/silicon-id: Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
- gpio: Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
Binding dependency patch:
- intc: Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml 
 - https://lore.kernel.org/all/20251030060155.2342604-2-ryan_chen@aspeedtech.com/ (Acked-by)

v7:
- remove aspeed,ast2x00-scu.yaml modify
- separate aspeed-g7.dtsi to aspeed-g7-a35.dtsi and aspeed-g7-common.dtsi
- move aliases to ast2700-evb.dts file

v6:
- rebased on v6.18-rc1
- aspeed,ast2x00-scu.yaml
 - fixed dt-binding yaml issuse report.

v5:
- modify ast27XX 7th generation description to 8th generation.
- aspeed.yaml
 - modify missing blank line.
- Kconfig.platforms
 - modify ast27XX 7th generation to 8th generation.

v4:
- make CHECK_DTBS=y arch/arm64/boot/dts/aspeed/ fix.
- modify commit message remove itemlize.
- remove modify aspeed,ast2700-intc.yaml patch.
- aspeed.yaml
 - Add AST2700 board compatible.
- aspeed-g7.dtsi
 - modify all size-cells from 1 to 2.
 - add serial aliases, gpio, mdio, uart0 ~ 14.
 - add firmware for optee, reserved memory for atf and optee.
 - modify cpu@0 to cpu0: cpu@0.
 - fix intc-ic for yaml dependency.
- ast2700-evb.dts
 - update stdout-path = "serial12:115200n8";

v3:
- https://lore.kernel.org/all/20241212155237.848336-1-kevin_chen@aspeedtech.com/
- Split clk and reset driver to other commits, which are in series of
  "Add support for AST2700 clk driver".
- For BMC console by UART12, add uart12 using ASPEED INTC architecture.

aspeed,ast2700-intc.yaml
- Add minItems to 1 to fix the warning by "make dtbs_check W=1".
- Add intc1 into example.

Kconfig.platforms
  - Remove MACH_ASPEED_G7.

Ryan Chen (6):
  dt-bindings: arm: aspeed: Add AST2700 board compatible
  arm64: Kconfig: Add Aspeed SoC family (ast27XX) Kconfig support
  arm64: dts: aspeed: Add initial AST27xx SoC device tree
  arm64: dts: aspeed: Add AST2700 Evaluation Board
  arm64: configs: Update defconfig for AST2700 platform support

 .../bindings/arm/aspeed/aspeed.yaml           |   6 +
 arch/arm64/Kconfig.platforms                  |   6 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/aspeed/Makefile           |   4 +
 arch/arm64/boot/dts/aspeed/aspeed-g7-a35.dtsi | 148 ++++++++
 .../boot/dts/aspeed/aspeed-g7-common.dtsi     | 345 ++++++++++++++++++
 arch/arm64/boot/dts/aspeed/ast2700-evb.dts    |  26 ++
 arch/arm64/configs/defconfig                  |   1 +
 8 files changed, 537 insertions(+)
 create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
 create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7-a35.dtsi
 create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7-common.dtsi
 create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts

-- 
2.34.1


