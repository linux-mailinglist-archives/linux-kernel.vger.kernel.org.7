Return-Path: <linux-kernel+bounces-850902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B4DBD4938
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3EA40538A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0340D3195EC;
	Mon, 13 Oct 2025 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vm4q6bOO"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA563191C4
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369290; cv=none; b=eF2gLntDyNIuVqE30zedScc+7uh7eXEyihyDkvX2LTGvSwepGyvHe+DHqsGNFFx4+0UwsLtU1mAonv6Lv16qwCmbBvUy+g+VoMHXHKrTPgQg9hcgzAynYWGmD/4ksa7+hkagnamAFMztsf2PUQHOWMq9b3E5hUVJBkW3gxsVWz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369290; c=relaxed/simple;
	bh=CZuoBd64iHqF+1cqnvZpQh8AHcZ5oHGTeR+IzCmdBTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/ZVL/xUq1Eb8U1WPeVG1xU/pw1SlJcYUEzW76C30XEt435xhSWXkG9ZZC1XT7Pb9Yos7YxTmswdEvhC+/A/0+5/EDEkb7zvp79wcHRJO30BUPzaa/bohbJhPVQBz7Chrkz8WDPQiumDyUbperkZed/5uU8X1kjT/+1mpsDPutY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vm4q6bOO; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5BDFFC093AF;
	Mon, 13 Oct 2025 15:27:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4E7376067B;
	Mon, 13 Oct 2025 15:28:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C8135102F2274;
	Mon, 13 Oct 2025 17:28:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760369285; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=DH7a2TSjC2EHRtCltLIXQ56Gx/zxJGstZzcrhDDVRTc=;
	b=vm4q6bOOFq44I9xd7zWEfS4NDHsjVzBwyWgLd1oaepsy9fQ1gnZ86zupCQCfUs2GePKDPo
	9W12689n6cTZH9S5zOdzCicGXXah0xzp5z7ny+hwz0NvtBXzDUJx6CJ0xcjeUyPpwKSHHl
	yALkEOIThvFKahA/LehQEPX5AcjcTmRZyULPkA9X1H7knPqMu14iJXpDOaJa1LJW1WEoB6
	niAW8NSmxpCvtydMC/d+wTFFwqPDzP4bbo4PLt9lrGgFFXTXTkgcrGXhimSlnoMSEWXS6d
	tFJ/cJCeXzB3GGR63ubM+XSSJdNSSjD6RGrIs35BFn5ZJMYcP2nI0/9JFMxqLw==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Johan Hovold <johan@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v2 15/15] arm64: dts: allwinner: h616: add NAND controller
Date: Mon, 13 Oct 2025 17:26:45 +0200
Message-ID: <20251013152645.1119308-16-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251013152645.1119308-1-richard.genoud@bootlin.com>
References: <20251013152645.1119308-1-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The H616 has a NAND controller quite similar to the A10/A23 ones, but
with some register differences, more clocks (for ECC and MBUS), more ECC
strengths, so this requires a new compatible string.

Add the NAND controller node and pins in the device tree.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index ceedae9e399b..bb53c6c63836 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
@@ -304,6 +304,42 @@ mmc2_pins: mmc2-pins {
 				bias-pull-up;
 			};
 
+			/omit-if-no-ref/
+			nand_pins: nand-pins {
+				pins = "PC0", "PC1", "PC2", "PC5", "PC8", "PC9",
+				       "PC10", "PC11", "PC12", "PC13", "PC14",
+				       "PC15", "PC16";
+				function = "nand0";
+			};
+
+			/omit-if-no-ref/
+			nand_cs0_pin: nand-cs0-pin {
+				pins = "PC4";
+				function = "nand0";
+				bias-pull-up;
+			};
+
+			/omit-if-no-ref/
+			nand_cs1_pin: nand-cs1-pin {
+				pins = "PC3";
+				function = "nand0";
+				bias-pull-up;
+			};
+
+			/omit-if-no-ref/
+			nand_rb0_pin: nand-rb0-pin {
+				pins = "PC6";
+				function = "nand0";
+				bias-pull-up;
+			};
+
+			/omit-if-no-ref/
+			nand_rb1_pin: nand-rb1-pin {
+				pins = "PC7";
+				function = "nand0";
+				bias-pull-up;
+			};
+
 			/omit-if-no-ref/
 			spi0_pins: spi0-pins {
 				pins = "PC0", "PC2", "PC4";
@@ -377,6 +413,21 @@ iommu: iommu@30f0000 {
 			#iommu-cells = <1>;
 		};
 
+		nfc: nand-controller@4011000 {
+			compatible = "allwinner,sun50i-h616-nand-controller";
+			reg = <0x04011000 0x1000>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_NAND>, <&ccu CLK_NAND0>,
+				<&ccu CLK_NAND1>, <&ccu CLK_MBUS_NAND>;
+			clock-names = "ahb", "mod", "ecc", "mbus";
+			resets = <&ccu RST_BUS_NAND>;
+			reset-names = "ahb";
+			dmas = <&dma 10>;
+			dma-names = "rxtx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		mmc0: mmc@4020000 {
 			compatible = "allwinner,sun50i-h616-mmc",
 				     "allwinner,sun50i-a100-mmc";

