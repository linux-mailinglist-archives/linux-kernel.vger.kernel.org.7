Return-Path: <linux-kernel+bounces-825775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A4DB8CCC3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 018574E10C3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 16:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA5C30277E;
	Sat, 20 Sep 2025 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/qrcZPW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2427B329;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385493; cv=none; b=IRSyeQKDJQ7oYmB7wws0rQmWjK6eRd8E1onVTGURbyEPQlX0UXVlqldNqfZ5LH7ChCYn4NYgChcqEe7URHwhXjTBCZ2jNA8TVzhjk8a+iuro5C2HuaBDI0k8gG6H1XEfmuLJKEh8wuDuf+99Z2UUqEZtdzzFgL1YpIp6b0tLxlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385493; c=relaxed/simple;
	bh=qb2+EkBXp7Hgrg+P1wF5GIqdIOe/IYDimtrwxuCDjmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UGmCMO69RAW+nta9BptTfvTULCb/0oMmD3wFCf8E+wTQnsSwMq6EE3Jci0agMd3mVwVA1p5JMrpxrW6Vc3kzxMnPz/eoOCKXgU+MmnavnGgaOEy0wfI9IprR2BPPZG6BeKxT1EHjZCm71ar98g94YXIrkD+LfBcEDnL61mt2Mss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/qrcZPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D867C113CF;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758385493;
	bh=qb2+EkBXp7Hgrg+P1wF5GIqdIOe/IYDimtrwxuCDjmY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=F/qrcZPWLw7tQe9MPG1XnGMnfhs3LFogPoB66NSxfnupZ4kB94+6FTQTT2mT4JRYh
	 9yVbrZfDqcMfULLP/ge8vdGq9hVNtM3IlDRDJQl8B2vKuVpBWvBDpY9mV9yKRz7yR4
	 onxgpfZW3wNPPfNbr5SBplumk0d85wg2y2F03s6C49lihE9WAT397Ig1fZEZYx7xIF
	 3NmZZfpDLU0N7D/3ubbfUVgx+w/4CfI+OYnqBObXTImN2DMfp9pAiTvnrOD99286IN
	 cRgkvfkZLtCirrvEeKVynuAWy7o36/Dvc3XC4SwGSEyJhcd6TRO6U1D0CnQukiHMYs
	 B9IqE6Nud0xSg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A34CAC5AD;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
From: Cristian Cozzolino via B4 Relay <devnull+cristian_ci.protonmail.com@kernel.org>
Date: Sat, 20 Sep 2025 20:23:29 +0200
Subject: [PATCH 04/10] ARM: dts: mediatek: mt6582: sort nodes and
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-mt6582-v1-4-b887720f577d@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758392693; l=3996;
 i=cristian_ci@protonmail.com; s=20250620; h=from:subject:message-id;
 bh=Z1S2PzSFTRUHdm6e5KvQH8f0VJGVi1iLBc3KX94/HbU=;
 b=FQWueJz6fpe77OaZh5ItLntT/nNPCZOu63nJSRYJV7jq1NjhxWRXdvUnJxw9UR4CUIP3IznxY
 UHp1qlhmqfVCmY0/5UixAQOQI4bbNxzXkG2hfTt/7J2KCsgnT8JYP8a
X-Developer-Key: i=cristian_ci@protonmail.com; a=ed25519;
 pk=xH5IvIPUNHV1Q8R0/pq2CfuVFR/wTiAyuyi6IwedjZY=
X-Endpoint-Received: by B4 Relay for cristian_ci@protonmail.com/20250620
 with auth_id=438
X-Original-From: Cristian Cozzolino <cristian_ci@protonmail.com>
Reply-To: cristian_ci@protonmail.com

From: Cristian Cozzolino <cristian_ci@protonmail.com>

Sort fixed clocks nodes by clock frequency and memory mapped device
nodes by reg address. Also, sort properties as shown in dt-bindings
examples.

Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
---
 arch/arm/boot/dts/mediatek/mt6582.dtsi | 46 +++++++++++++++-------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/mediatek/mt6582.dtsi b/arch/arm/boot/dts/mediatek/mt6582.dtsi
index 37d2b8786188aecb65c0a6e0d31aabc3b66e2bd7..8ada8c6518661509ebee647367064187f4376ab9 100644
--- a/arch/arm/boot/dts/mediatek/mt6582.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt6582.dtsi
@@ -13,8 +13,8 @@ / {
 	interrupt-parent = <&sysirq>;
 
 	cpus {
-		#address-cells = <1>;
 		#size-cells = <0>;
+		#address-cells = <1>;
 
 		cpu@0 {
 			device_type = "cpu";
@@ -38,22 +38,22 @@ cpu@3 {
 		};
 	};
 
-	system_clk: dummy13m {
+	uart_clk: dummy26m {
 		compatible = "fixed-clock";
-		clock-frequency = <13000000>;
 		#clock-cells = <0>;
+		clock-frequency = <26000000>;
 	};
 
-	rtc_clk: dummy32k {
+	system_clk: dummy13m {
 		compatible = "fixed-clock";
-		clock-frequency = <32000>;
 		#clock-cells = <0>;
+		clock-frequency = <13000000>;
 	};
 
-	uart_clk: dummy26m {
+	rtc_clk: dummy32k {
 		compatible = "fixed-clock";
-		clock-frequency = <26000000>;
 		#clock-cells = <0>;
+		clock-frequency = <32000>;
 	};
 
 	soc {
@@ -62,6 +62,11 @@ soc {
 		compatible = "simple-bus";
 		ranges;
 
+		watchdog: watchdog@10007000 {
+			compatible = "mediatek,mt6582-wdt", "mediatek,mt6589-wdt";
+			reg = <0x10007000 0x100>;
+		};
+
 		timer: timer@11008000 {
 			compatible = "mediatek,mt6577-timer";
 			reg = <0x10008000 0x80>;
@@ -71,18 +76,17 @@ timer: timer@11008000 {
 		};
 
 		sysirq: interrupt-controller@10200100 {
-			compatible = "mediatek,mt6582-sysirq",
-				     "mediatek,mt6577-sysirq";
+			compatible = "mediatek,mt6582-sysirq", "mediatek,mt6577-sysirq";
+			reg = <0x10200100 0x1c>;
+			interrupt-parent = <&gic>;
 			interrupt-controller;
 			#interrupt-cells = <3>;
-			interrupt-parent = <&gic>;
-			reg = <0x10200100 0x1c>;
 		};
 
 		gic: interrupt-controller@10211000 {
 			compatible = "arm,cortex-a7-gic";
-			interrupt-controller;
 			#interrupt-cells = <3>;
+			interrupt-controller;
 			interrupt-parent = <&gic>;
 			reg = <0x10211000 0x1000>,
 			      <0x10212000 0x2000>,
@@ -91,8 +95,7 @@ gic: interrupt-controller@10211000 {
 		};
 
 		uart0: serial@11002000 {
-			compatible = "mediatek,mt6582-uart",
-				     "mediatek,mt6577-uart";
+			compatible = "mediatek,mt6582-uart", "mediatek,mt6577-uart";
 			reg = <0x11002000 0x400>;
 			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&uart_clk>;
@@ -100,8 +103,7 @@ uart0: serial@11002000 {
 		};
 
 		uart1: serial@11003000 {
-			compatible = "mediatek,mt6582-uart",
-				     "mediatek,mt6577-uart";
+			compatible = "mediatek,mt6582-uart", "mediatek,mt6577-uart";
 			reg = <0x11003000 0x400>;
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&uart_clk>;
@@ -109,8 +111,7 @@ uart1: serial@11003000 {
 		};
 
 		uart2: serial@11004000 {
-			compatible = "mediatek,mt6582-uart",
-				     "mediatek,mt6577-uart";
+			compatible = "mediatek,mt6582-uart", "mediatek,mt6577-uart";
 			reg = <0x11004000 0x400>;
 			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&uart_clk>;
@@ -118,18 +119,11 @@ uart2: serial@11004000 {
 		};
 
 		uart3: serial@11005000 {
-			compatible = "mediatek,mt6582-uart",
-				     "mediatek,mt6577-uart";
+			compatible = "mediatek,mt6582-uart", "mediatek,mt6577-uart";
 			reg = <0x11005000 0x400>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&uart_clk>;
 			status = "disabled";
 		};
-
-		watchdog: watchdog@10007000 {
-			compatible = "mediatek,mt6582-wdt",
-				     "mediatek,mt6589-wdt";
-			reg = <0x10007000 0x100>;
-		};
 	};
 };

-- 
2.49.0



