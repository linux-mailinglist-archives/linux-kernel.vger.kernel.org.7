Return-Path: <linux-kernel+bounces-864294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B480EBFA70D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845233A3C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007B3221F26;
	Wed, 22 Oct 2025 07:05:48 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED78E22D78A;
	Wed, 22 Oct 2025 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116747; cv=none; b=NwN836bnHv/IoIL6qGt1bzzoaIjSCpO51VYNfmCVEO79MVF2niCKtzs8leSzoNPPasWlSczFQokOwP61plnk7ja3wfND0wudvf7zsdqViE82AN+KRu3YbuxQ29ya22T8onCdGxfTwXAaQoT+rltwc7rSdnKj5UZugbDTnThwuJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116747; c=relaxed/simple;
	bh=VMaTNvQHQT9xEFTc+wXNIs2Do+MtqqL5HJzvMo4Hot4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z9yfWdXfiJpTzGnqowf7NDZlktodGPlHJy/cpMsqdT1fo9lUjwUzi3liv3PEiFv17QZ/rq3HEKFh1BPnqARCZooNufdR0VczH7/qCZLCmIdy4DFjTeGo2GrOROWKQdrGXv0e1Ba7NQwxPO3fn9wSOljGMr3WsV+qfIQpjA+6reM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 22 Oct
 2025 15:05:43 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 22 Oct 2025 15:05:43 +0800
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
Subject: [PATCH v6 0/6] Introduce ASPEED AST2700 BMC SoC
Date: Wed, 22 Oct 2025 15:05:37 +0800
Message-ID: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This introduces initial support for the Aspeed AST2700 SoC and the AST2700
Evaluation Board (EVB) to the Linux kernel. The AST27XX is the 8th
generation Baseboard Management Controller (BMC) SoC from Aspeed,
featuring improved performance, enhanced security, and expanded I/O
capabilities compared to previous generations.

AST27XX SOC Family
 - https://www.aspeedtech.com/server_ast2700/
 - https://www.aspeedtech.com/server_ast2720/
 - https://www.aspeedtech.com/server_ast2750/

Bindings Dependencies:
- scu/silicon-id: Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
- gpio: Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
- mdio: Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
- intc0: Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc0.yaml
- intc1: Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc1.yaml
 - https://lore.kernel.org/all/20251022065507.1152071-2-ryan_chen@aspeedtech.com/T/#u (Reviewing)

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
  dt-bindings: mfd: aspeed,ast2x00-scu: allow #size-cells range
  arm64: dts: aspeed: Add initial AST2700 SoC device tree
  arm64: dts: aspeed: Add AST2700 Evaluation Board
  arm64: configs: Update defconfig for AST2700 platform support

 .../bindings/arm/aspeed/aspeed.yaml           |   6 +
 .../bindings/mfd/aspeed,ast2x00-scu.yaml      |   2 +-
 arch/arm64/Kconfig.platforms                  |   6 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/aspeed/Makefile           |   4 +
 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi     | 516 ++++++++++++++++++
 arch/arm64/boot/dts/aspeed/ast2700-evb.dts    |  22 +
 arch/arm64/configs/defconfig                  |   1 +
 8 files changed, 557 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
 create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
 create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts

-- 
2.34.1


