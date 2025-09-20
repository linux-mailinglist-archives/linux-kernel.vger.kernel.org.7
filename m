Return-Path: <linux-kernel+bounces-825774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF33B8CCC0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A1C5618BC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851AA30277A;
	Sat, 20 Sep 2025 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyQwP0bI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFAD2798F0;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385493; cv=none; b=oN9QP+j5uEL3k4GA/aoP/+jqQAn0R2PUqoP+C7iPOKAKC7MFJLqu2Se/84+ACXgzwEnhKvvsOp+Vevwdi99GojRvasrl47qaSgEBTzMdAotJrxUkzTZToa8rCYeehOT5GldV6oxcta2t2+XrPYObbsiO0h6v6uv9sACyIpbZgPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385493; c=relaxed/simple;
	bh=vr+vUucMTlHCNRTrav6CDTy/w5gINTD8DBlVa8EbYeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RFDUFZD9FdzbUOh7BTlRYF0vVOH6WxNT0XysNTAgpGLxKpMvVPIL4uTQ+/wznNqzT1AROVIDJVlMOsmSp2MiOWkdHjcxYdZiDZOCqgR2OcNqBiChMv6LdSEvtycv3RvDyEJS7du4s5LyNCXetHE2CllqjpvI1DcRKNMivWZ79Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyQwP0bI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 432B0C4CEFB;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758385493;
	bh=vr+vUucMTlHCNRTrav6CDTy/w5gINTD8DBlVa8EbYeg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MyQwP0bIvozkCW66sMKeL/nIC5Kw9BjmZTVDLQlaseG54xYANBthiySy66N3qC8Rk
	 Gk5WACLw/XuqR+whggOcZZr8TgVMBj/xv4Kohdw/1veE6T4/syshAGJ6E17NOG1dWQ
	 tCJhvdRI6cv6/mZYXRVFV8Wap5n6Z+egXNU/SiEzTh2lV7Y5CxfD5Czk7ZVkTH2A4D
	 OkLHdTLOG6aTihTnyGLnjpou1158deB0wh1PRVKY+KXdiZTTdf5cAVQcEFZxBrGXtZ
	 En2T4FDU+nuAWC8HLv+gL71aIygeso6+qmlKlP3n+Ofz3EFHn85Z3CBSBGVNVGZx6B
	 MpNtuUKrPprIg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3425ACAC5A5;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
From: Cristian Cozzolino via B4 Relay <devnull+cristian_ci.protonmail.com@kernel.org>
Date: Sat, 20 Sep 2025 20:23:28 +0200
Subject: [PATCH 03/10] ARM: dts: mediatek: mt6582: move MMIO devices under
 soc node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-mt6582-v1-3-b887720f577d@protonmail.com>
References: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
In-Reply-To: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 Cristian Cozzolino <cristian_ci@protonmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758392693; l=4612;
 i=cristian_ci@protonmail.com; s=20250620; h=from:subject:message-id;
 bh=ygAMw2Q0SfkqnJBPfSCrpCT2WbyasWzsR4XcmLR13kA=;
 b=iYsV2k3gqnQRfJBNS7hWnK0zwFbYkC0sD2NkURCWkQsSwMGSTCgk/CMS5NtaUoD8dBNihHCaI
 GFvlo8/As1mAwsDJAAePOfGBuOtx51MKWZ0txLBmWR71Z3OTuzzO6dT
X-Developer-Key: i=cristian_ci@protonmail.com; a=ed25519;
 pk=xH5IvIPUNHV1Q8R0/pq2CfuVFR/wTiAyuyi6IwedjZY=
X-Endpoint-Received: by B4 Relay for cristian_ci@protonmail.com/20250620
 with auth_id=438
X-Original-From: Cristian Cozzolino <cristian_ci@protonmail.com>
Reply-To: cristian_ci@protonmail.com

From: Cristian Cozzolino <cristian_ci@protonmail.com>

Memory mapped devices are part of soc. So, add such node and move those
devices into it.

Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
---
 arch/arm/boot/dts/mediatek/mt6582.dtsi | 129 +++++++++++++++++----------------
 1 file changed, 68 insertions(+), 61 deletions(-)

diff --git a/arch/arm/boot/dts/mediatek/mt6582.dtsi b/arch/arm/boot/dts/mediatek/mt6582.dtsi
index 4263371784cd15db7af0ceb49dd069b62b623639..37d2b8786188aecb65c0a6e0d31aabc3b66e2bd7 100644
--- a/arch/arm/boot/dts/mediatek/mt6582.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt6582.dtsi
@@ -56,73 +56,80 @@ uart_clk: dummy26m {
 		#clock-cells = <0>;
 	};
 
-	timer: timer@11008000 {
-		compatible = "mediatek,mt6577-timer";
-		reg = <0x10008000 0x80>;
-		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&system_clk>, <&rtc_clk>;
-		clock-names = "system-clk", "rtc-clk";
-	};
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
 
-	sysirq: interrupt-controller@10200100 {
-		compatible = "mediatek,mt6582-sysirq",
-			     "mediatek,mt6577-sysirq";
-		interrupt-controller;
-		#interrupt-cells = <3>;
-		interrupt-parent = <&gic>;
-		reg = <0x10200100 0x1c>;
-	};
+		timer: timer@11008000 {
+			compatible = "mediatek,mt6577-timer";
+			reg = <0x10008000 0x80>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&system_clk>, <&rtc_clk>;
+			clock-names = "system-clk", "rtc-clk";
+		};
 
-	gic: interrupt-controller@10211000 {
-		compatible = "arm,cortex-a7-gic";
-		interrupt-controller;
-		#interrupt-cells = <3>;
-		interrupt-parent = <&gic>;
-		reg = <0x10211000 0x1000>,
-		      <0x10212000 0x2000>,
-		      <0x10214000 0x2000>,
-		      <0x10216000 0x2000>;
-	};
+		sysirq: interrupt-controller@10200100 {
+			compatible = "mediatek,mt6582-sysirq",
+				     "mediatek,mt6577-sysirq";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
+			reg = <0x10200100 0x1c>;
+		};
 
-	uart0: serial@11002000 {
-		compatible = "mediatek,mt6582-uart",
-			     "mediatek,mt6577-uart";
-		reg = <0x11002000 0x400>;
-		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&uart_clk>;
-		status = "disabled";
-	};
+		gic: interrupt-controller@10211000 {
+			compatible = "arm,cortex-a7-gic";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
+			reg = <0x10211000 0x1000>,
+			      <0x10212000 0x2000>,
+			      <0x10214000 0x2000>,
+			      <0x10216000 0x2000>;
+		};
 
-	uart1: serial@11003000 {
-		compatible = "mediatek,mt6582-uart",
-			     "mediatek,mt6577-uart";
-		reg = <0x11003000 0x400>;
-		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&uart_clk>;
-		status = "disabled";
-	};
+		uart0: serial@11002000 {
+			compatible = "mediatek,mt6582-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0x11002000 0x400>;
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
 
-	uart2: serial@11004000 {
-		compatible = "mediatek,mt6582-uart",
-			     "mediatek,mt6577-uart";
-		reg = <0x11004000 0x400>;
-		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&uart_clk>;
-		status = "disabled";
-	};
+		uart1: serial@11003000 {
+			compatible = "mediatek,mt6582-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0x11003000 0x400>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
 
-	uart3: serial@11005000 {
-		compatible = "mediatek,mt6582-uart",
-			     "mediatek,mt6577-uart";
-		reg = <0x11005000 0x400>;
-		interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&uart_clk>;
-		status = "disabled";
-	};
+		uart2: serial@11004000 {
+			compatible = "mediatek,mt6582-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0x11004000 0x400>;
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart3: serial@11005000 {
+			compatible = "mediatek,mt6582-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0x11005000 0x400>;
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
 
-	watchdog: watchdog@10007000 {
-		compatible = "mediatek,mt6582-wdt",
-			     "mediatek,mt6589-wdt";
-		reg = <0x10007000 0x100>;
+		watchdog: watchdog@10007000 {
+			compatible = "mediatek,mt6582-wdt",
+				     "mediatek,mt6589-wdt";
+			reg = <0x10007000 0x100>;
+		};
 	};
 };

-- 
2.49.0



