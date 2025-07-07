Return-Path: <linux-kernel+bounces-720426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5B7AFBB8F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7D747AAFF0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E3B26A1D9;
	Mon,  7 Jul 2025 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kz2KgJzV"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E39A26A0D5;
	Mon,  7 Jul 2025 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915320; cv=none; b=V3G+Jdz5sBpIgcKza8euBFXeM90B+mvS2TsvrO7Xz9TVTEzdYG6rXLzU7PTqF+sOdrG7dv0m58ohTN0KIgfM8e1Jji0DWz2uOewJAfhnmWafH16R7QBSyBDMdhLt8FR/tg+Y/5aPylk5MNl7YHZ34mlu9B2ejZg9beU6168khOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915320; c=relaxed/simple;
	bh=8tmgbOODpqXAz69qvJ5O94Ewtt+UMmTEQs3Nx3MdaHg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ezy/A+HJa788xlNiAt7Voz6YENG8U3UlUJF1uvD4iwUU3JnezA8RKws/zN5LOurp4xGgYtJwBo4f//GhGwmoyx9jh0RLHw8+/Mtw9AdJddu5yI11E90/S+EsrgKD+OHUQaEb5qlfhRt8xyTpHN90lKhGIjqUKJrgOp7YVsZnI+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Kz2KgJzV; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 567J8VYl297638;
	Mon, 7 Jul 2025 14:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751915311;
	bh=md0BwfJmA9gIM32S1QSqVz0A4WkieDc/rC2kd1592Is=;
	h=From:To:CC:Subject:Date;
	b=Kz2KgJzVbLbG9C2Y4p063ZMVoZvqVLJOruBaIZtB9NBEVmEITNMOxk2SvnePFH+RP
	 hz6XRx/J10/X0nOjiXnZsqIF6ynuu8CQSe7UFFOLoqen3y1af1sP+u4yVyZTP7RbCv
	 nUpHZJnrLNMsK6d8Dypc9xtxk0X7udKFS+oKyT78=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 567J8VUg2503220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 7 Jul 2025 14:08:31 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 7
 Jul 2025 14:08:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 7 Jul 2025 14:08:30 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 567J8Ubv436914;
	Mon, 7 Jul 2025 14:08:30 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] arm64: dts: ti: k3-am62*: Move eMMC pinmux to top level board file
Date: Mon, 7 Jul 2025 14:08:30 -0500
Message-ID: <20250707190830.3951619-1-jm@ti.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This moves pinmux child nodes for sdhci0 node from k3-am62x-sk-common
to each top level board file. This is needed since we require internal
pullups for AM62x SK and not for AM62 LP SK since it has external
pullups on DATA 1-7.

Internal pulls are required for AM62 SK as per JESD84 spec
recommendation to prevent unconnected lines floating.

Fixes: d19a66ae488a ("arm64: dts: ti: k3-am625-sk: Enable on board peripherals")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- patch was split from series [0]
- merge conflict fix with disable-wp

v1[0]: https://lore.kernel.org/linux-mmc/20250624221230.1952291-1-jm@ti.com/
---
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts      | 24 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts        | 24 +++++++++++++++++++
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 24 -------------------
 3 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
index aafdb90c0eb7..4609f366006e 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
@@ -74,6 +74,22 @@ vddshv_sdio: regulator-4 {
 };
 
 &main_pmx0 {
+	main_mmc0_pins_default: main-mmc0-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (V3) MMC0_CMD */
+			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (Y1) MMC0_CLK */
+			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (V2) MMC0_DAT0 */
+			AM62X_IOPAD(0x210, PIN_INPUT, 0) /* (V1) MMC0_DAT1 */
+			AM62X_IOPAD(0x20c, PIN_INPUT, 0) /* (W2) MMC0_DAT2 */
+			AM62X_IOPAD(0x208, PIN_INPUT, 0) /* (W1) MMC0_DAT3 */
+			AM62X_IOPAD(0x204, PIN_INPUT, 0) /* (Y2) MMC0_DAT4 */
+			AM62X_IOPAD(0x200, PIN_INPUT, 0) /* (W3) MMC0_DAT5 */
+			AM62X_IOPAD(0x1fc, PIN_INPUT, 0) /* (W4) MMC0_DAT6 */
+			AM62X_IOPAD(0x1f8, PIN_INPUT, 0) /* (V4) MMC0_DAT7 */
+		>;
+	};
+
 	vddshv_sdio_pins_default: vddshv-sdio-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x07c, PIN_OUTPUT, 7) /* (M19) GPMC0_CLK.GPIO0_31 */
@@ -144,6 +160,14 @@ exp2: gpio@23 {
 	};
 };
 
+&sdhci0 {
+	bootph-all;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc0_pins_default>;
+	status = "okay";
+};
+
 &sdhci1 {
 	vmmc-supply = <&vdd_mmc1>;
 	vqmmc-supply = <&vddshv_sdio>;
diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 2fbfa3719345..d240165bda9c 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -106,6 +106,22 @@ vcc_1v8: regulator-5 {
 };
 
 &main_pmx0 {
+	main_mmc0_pins_default: main-mmc0-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (Y3) MMC0_CMD */
+			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1) MMC0_CLK */
+			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (AA2) MMC0_DAT0 */
+			AM62X_IOPAD(0x210, PIN_INPUT_PULLUP, 0) /* (AA1) MMC0_DAT1 */
+			AM62X_IOPAD(0x20c, PIN_INPUT_PULLUP, 0) /* (AA3) MMC0_DAT2 */
+			AM62X_IOPAD(0x208, PIN_INPUT_PULLUP, 0) /* (Y4) MMC0_DAT3 */
+			AM62X_IOPAD(0x204, PIN_INPUT_PULLUP, 0) /* (AB2) MMC0_DAT4 */
+			AM62X_IOPAD(0x200, PIN_INPUT_PULLUP, 0) /* (AC1) MMC0_DAT5 */
+			AM62X_IOPAD(0x1fc, PIN_INPUT_PULLUP, 0) /* (AD2) MMC0_DAT6 */
+			AM62X_IOPAD(0x1f8, PIN_INPUT_PULLUP, 0) /* (AC2) MMC0_DAT7 */
+		>;
+	};
+
 	main_rgmii2_pins_default: main-rgmii2-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -195,6 +211,14 @@ exp1: gpio@22 {
 	};
 };
 
+&sdhci0 {
+	bootph-all;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc0_pins_default>;
+	status = "okay";
+};
+
 &sdhci1 {
 	vmmc-supply = <&vdd_mmc1>;
 	vqmmc-supply = <&vdd_sd_dv>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index ee8337bfbbfd..13e1d36123d5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -203,22 +203,6 @@ AM62X_IOPAD(0x0b4, PIN_INPUT_PULLUP, 1) /* (K24/H19) GPMC0_CSn3.I2C2_SDA */
 		>;
 	};
 
-	main_mmc0_pins_default: main-mmc0-default-pins {
-		bootph-all;
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (Y3/V3) MMC0_CMD */
-			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1/Y1) MMC0_CLK */
-			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (AA2/V2) MMC0_DAT0 */
-			AM62X_IOPAD(0x210, PIN_INPUT, 0) /* (AA1/V1) MMC0_DAT1 */
-			AM62X_IOPAD(0x20c, PIN_INPUT, 0) /* (AA3/W2) MMC0_DAT2 */
-			AM62X_IOPAD(0x208, PIN_INPUT, 0) /* (Y4/W1) MMC0_DAT3 */
-			AM62X_IOPAD(0x204, PIN_INPUT, 0) /* (AB2/Y2) MMC0_DAT4 */
-			AM62X_IOPAD(0x200, PIN_INPUT, 0) /* (AC1/W3) MMC0_DAT5 */
-			AM62X_IOPAD(0x1fc, PIN_INPUT, 0) /* (AD2/W4) MMC0_DAT6 */
-			AM62X_IOPAD(0x1f8, PIN_INPUT, 0) /* (AC2/V4) MMC0_DAT7 */
-		>;
-	};
-
 	main_mmc1_pins_default: main-mmc1-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -457,14 +441,6 @@ &main_i2c2 {
 	clock-frequency = <400000>;
 };
 
-&sdhci0 {
-	bootph-all;
-	status = "okay";
-	non-removable;
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mmc0_pins_default>;
-};
-
 &sdhci1 {
 	/* SD/MMC */
 	bootph-all;
-- 
2.49.0


