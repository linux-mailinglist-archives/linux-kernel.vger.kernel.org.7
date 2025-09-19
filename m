Return-Path: <linux-kernel+bounces-823953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21370B87CF3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A7E7C3BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148E323C8C7;
	Fri, 19 Sep 2025 03:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qdl8Y53U"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741AB261B9D;
	Fri, 19 Sep 2025 03:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758252559; cv=none; b=LiGe43YVfriDXes+v3K68AEEQ87MvJkw3TB9HtI8ZKkMZ+uKT3sQUn/jgVr5Pb//6A8cA6xXrnzMWVYlQF/68tOhsy0NnjW5HvLHPmJFw5LkVJZtmw/k2AL7RdaJ3pUIn35N+Eza7yQ7O6LIQTbuJxRlFuwfTvX3Kzw0Ce2SAd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758252559; c=relaxed/simple;
	bh=XX/ETdVeB+tWiTK6nhzx1udiFh8XwGiFmQJIW3mpeHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQPFC58WHvzPKbjKocposzQz0nhuEPy3kd2gED4e57k4lN2v29V6pIX7ms/80bkcy/ytd1Vy9EPfHwGDwjABSwodwUrTnVb2KDBYVpSEClGpPt/8AhcZbitVrFig5yeHbWrK8KcQkjUSvPylblxCvARuBane5wDJ580wdddevvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Qdl8Y53U; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58J3TAdj151745;
	Thu, 18 Sep 2025 22:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758252550;
	bh=LY00hGaHj82HQ41hMnhsfZ2aVqFf+c85vwEv6CG/hV8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Qdl8Y53USuhdTiunKo6fQa1kmkalr2rwMIlXc+e+xwlV5rBVYStbd6KMRaqkCHIhI
	 xvgDXGuzujZKGsbjZ8iwDAnsul5PLLeukW07Sn5byg23qn2vigU6kSMm8JWWygBACh
	 cZ1qUMb3TGHrPnPTvihf5GiYt2b01ReLPnFgxCRM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58J3TAsQ2029083
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 18 Sep 2025 22:29:10 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 18
 Sep 2025 22:29:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Sep 2025 22:29:10 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58J3T8mY1901500;
	Thu, 18 Sep 2025 22:29:09 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <s-ramamoorthy@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am62d2-evm: Enable PMIC
Date: Fri, 19 Sep 2025 08:58:06 +0530
Message-ID: <20250919032806.707926-3-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919032806.707926-1-p-bhagat@ti.com>
References: <20250919032806.707926-1-p-bhagat@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add support for TPS65224 PMIC family on wakeup I2C0 bus. This 
device provides regulators (bucks and LDOs), along with GPIOs, 
and monitors SOC's MCU error signal.

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts | 91 ++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
index 9a74df221f2a..155abd97b799 100644
--- a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
@@ -214,6 +214,14 @@ AM62DX_MCU_IOPAD(0x0030, PIN_OUTPUT, 0) /* (C8) WKUP_UART0_RTSn */
 		>;
 		bootph-all;
 	};
+
+	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
+		pinctrl-single,pins = <
+			AM62DX_MCU_IOPAD(0x004c, PIN_INPUT, 0) /* (D13) WKUP_I2C0_SCL */
+			AM62DX_MCU_IOPAD(0x0050, PIN_INPUT, 0) /* (E13) WKUP_I2C0_SDA */
+		>;
+		bootph-all;
+	};
 };
 
 /* WKUP UART0 is used for DM firmware logs */
@@ -464,6 +472,89 @@ &main_i2c2 {
 	status = "okay";
 };
 
+&wkup_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	tps65224: pmic@48 {
+		compatible = "ti,tps65224-q1";
+		reg = <0x48>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+		interrupt-parent = <&main_gpio1>;
+		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
+		ti,primary-pmic;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		buck12-supply = <&vcc_3v3_sys>;
+		buck3-supply = <&vcc_3v3_sys>;
+		buck4-supply = <&vcc_3v3_sys>;
+		ldo1-supply = <&vcc_3v3_sys>;
+		ldo2-supply = <&vcc_3v3_sys>;
+		ldo3-supply = <&vcc_3v3_sys>;
+
+		regulators {
+			buck12: buck12 {
+				regulator-name = "vdd_core";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+				bootph-all;
+			};
+
+			buck3: buck3 {
+				regulator-name = "dvdd1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+				bootph-all;
+			};
+
+			buck4: buck4 {
+				regulator-name = "vdds_ddr";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+				bootph-all;
+			};
+
+			ldo1: ldo1 {
+				regulator-name = "vdda_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+				bootph-all;
+			};
+
+			ldo2: ldo2 {
+				regulator-name = "dvdd3v3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+				bootph-all;
+			};
+
+			ldo3: ldo3 {
+				regulator-name = "vddr_core";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+				bootph-all;
+			};
+		};
+	};
+};
+
 &sdhci0 {
 	/* eMMC */
 	non-removable;
-- 
2.34.1


