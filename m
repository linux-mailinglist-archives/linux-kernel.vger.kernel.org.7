Return-Path: <linux-kernel+bounces-873202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3506AC1355F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F4C1891137
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7D42E091C;
	Tue, 28 Oct 2025 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VfW+i13n"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E542DF6F5;
	Tue, 28 Oct 2025 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761636998; cv=none; b=eski3rjJUllvVgtduLg/RluldTzSapZVKpH7FyBhe9EQawTqzAJoA5DEB30OmUcU5w3Ti2Gk/gfn2JBtpl4XG+yzoIdRzfDyji/lX6M09lX2Z52EhK73FnyllRv3uWT6JxJ0kKGcfpciy5FBpts81T6B8EGJmy2LiDzhxmF2U24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761636998; c=relaxed/simple;
	bh=Om0lvRWPDe6Ehq3RNTwvwbhIRct+e1KTrLwqUuXzyS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEmJBtdjZ7eoZ2gpnXdTsAh/6ILEGkzWDaFuXBAAbIc/JLdo5i25Qg95G+K8+t4rJSXX5jRIj9lsbiHGb5/v+LTkP0KLidJVONeQ0ND/Rxdh39+Qt8xiT6JNNPcaUWK/ERtYMs/dPk9GGlayXgGLPJMlQCTcmY86B4+Uy58BdsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VfW+i13n; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8046D1A16F7;
	Tue, 28 Oct 2025 07:36:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 56327606AB;
	Tue, 28 Oct 2025 07:36:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 935F4102F251B;
	Tue, 28 Oct 2025 08:36:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761636994; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=HDL+cduKGo0iwjImHuxRFOSxsiEzs6TUgE6gWmABSIg=;
	b=VfW+i13nyaovNMhOgJDRHw3FVtH49cPKUE/qlj/T3LX2zoZz8OaUuNkQidN4SvX+UxhxmX
	zAlRe30kXPqneuD46fPFB1Sk3osgunGsMn4ln0on/w604ivEwkGk7XIQ8ffKdyPByVRoh2
	sjAZ72dzOLO+ScPme5ueaQGv27fjYaS7fCQVMW5RNdCiOH7vxCWzgc9ASauxrcPEjo5AyR
	jxKqDPwBmDk64gC5RjIViG5XKDYfZVA92J7upzyz1QJPKOcyJNRuU0I52g1yri0xsPqVBI
	oPc5ufrAS98mXp0AihVw9/N3ukKYmO5bv0+K/hA/14f8Xgvy1DVsYP5IoR83iA==
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
Subject: [PATCH v4 16/16] arm64: dts: allwinner: h616: add NAND controller
Date: Tue, 28 Oct 2025 08:35:09 +0100
Message-ID: <20251028073534.526992-17-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028073534.526992-1-richard.genoud@bootlin.com>
References: <20251028073534.526992-1-richard.genoud@bootlin.com>
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
-- 
2.47.3


