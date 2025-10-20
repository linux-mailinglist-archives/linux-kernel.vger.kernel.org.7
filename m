Return-Path: <linux-kernel+bounces-860605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E56BF0803
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C80D188D5DC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96393002D3;
	Mon, 20 Oct 2025 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mOLWAHZM"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681792FE567
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955258; cv=none; b=oADCkCsHDie5bizvn+X+knJ7h5oxHvJXmWrQbkEwSs70r4G4Z5ERqX67D+sO9BMQC01Cgj5Gk2LAevBvIT0sJMPvSCib5zMhhO0We0ukW96Ldh+MHju6XJkAJ4y5EnPvyYlvo3gCQg/osz2DgYX3fs5MBA/vmtoKyDCHjE3A/CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955258; c=relaxed/simple;
	bh=GgwJ7fWaulAietrHBtr8pXhbFEbm/bkrRwvdjItYaJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHZO/D9pcXjfl0c1QwIeb2/ERBsT1zD8HOJPmPXzaguNev7Ks9mA8BuCsC++XPUgGl1Vlz2WTCaU5LU+Pwy6QsT5akz6LIiEXM/Sxg5Dtbk7GIVBD7UukhIausrpaqGV4wcVX4pYUFpuE/RzWqf00H5YFum46zN/UVMld/73ddI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mOLWAHZM; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A8E09C0AFE4;
	Mon, 20 Oct 2025 10:13:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3A2E7606D5;
	Mon, 20 Oct 2025 10:14:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2346102F23B3;
	Mon, 20 Oct 2025 12:14:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760955254; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=rZByAZ4a1Es55m5EId/mrhQ7knVrzCU0ipEljdw7k+I=;
	b=mOLWAHZMEHaJ5DWrJzd5+jqoy2/ZuEto+BJiYKEPYIpIZznZ1Qpmclm7yQxwlw9M1ZrM4f
	QntYP/j3GqyB/SyXjRR16YLDSWgkO0vEQWE3zXUCzWYHZ1RBUmq3XAMBtgVf5m3OacbPlF
	1LBUPIQp3Ovz4QkHPu8ukKB1TOjDgPxU7aqf3wsAHT7busdUDwGc18E0eUwS/Wyzf68+k3
	s2vkBLgrjp000yuOw46dETNd/O81ldxNW15bxro6cfvCCl94KF3oYctxWNsFbEG0JHPQLY
	IaS36Q+uq5lzXVUouUtuWUlp+z1iVWIi3SSPWg0uKkf1a1gLLnJyaSb9Ve71pw==
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
Subject: [PATCH v3 15/15] arm64: dts: allwinner: h616: add NAND controller
Date: Mon, 20 Oct 2025 12:13:11 +0200
Message-ID: <20251020101311.256819-16-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020101311.256819-1-richard.genoud@bootlin.com>
References: <20251020101311.256819-1-richard.genoud@bootlin.com>
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
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index ceedae9e399b..2a4d70298655 100644
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
@@ -377,6 +413,22 @@ iommu: iommu@30f0000 {
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
+			status = "disabled";
+		};
+
 		mmc0: mmc@4020000 {
 			compatible = "allwinner,sun50i-h616-mmc",
 				     "allwinner,sun50i-a100-mmc";

