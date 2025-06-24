Return-Path: <linux-kernel+bounces-699770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C718AAE5F20
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 10:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4041920755
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 08:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D748525A659;
	Tue, 24 Jun 2025 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dWEatX0J"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A763525A2AB;
	Tue, 24 Jun 2025 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753596; cv=none; b=ubbdB7GjtDB4uJ7vs7sdDHvqdRClsgniLleZxSHkK1jyTZyIziHmJ5D63A9tOhcVuYndiVsOlyC6TDp8BKpXb+tF6HTziMYJNJnuyAeNVwvcR6ghm/OHcDlejRD6pTr2resnkoBnDETggQqag6lNsUU2DFTJvNATjOXcjnFsjGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753596; c=relaxed/simple;
	bh=a9gPC3hAeynqQc8OYfrBKNMOnVtTlG+LdvhB9M89GWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhlLAhPahzxX1VbOwJ36FTGFfDXgtbxr5o1dLYQAmvyTgiMltL2k69BtT8CGCWkkcAib6AWnnUfnjSdatVlYjjj6rsPAg3y4tRv7WVa+I4UqxLJqlebIoNnMDELIJIqORVaYAVjuQao11CJIqSZYLPZLL109upAC9zdq1Q/IJZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dWEatX0J; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55O8QSPV1731128;
	Tue, 24 Jun 2025 03:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750753588;
	bh=cdT6uLvt7v0OlGBZcXbpnLNPp3K3v9W/E3AD3dZIWto=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=dWEatX0JsXjRtUeWFuRxaWKkwhdwQzU8Ez2OQMUrnfi8NN5tzBvhgit80P6CU4HS2
	 fkhZY1Jk5C74s/hWiYIvgJC6jyIRAPAE/oAux7MJHk8lU7SmFLu9qr3bpeolgcA1cx
	 nRbVxfsYh0ku5XkzT+cTlr07ydKEFMC30rnhlZR4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55O8QS8j1551294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 24 Jun 2025 03:26:28 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 24
 Jun 2025 03:26:28 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 24 Jun 2025 03:26:27 -0500
Received: from localhost (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com [172.24.227.214])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55O8QR7A1183643;
	Tue, 24 Jun 2025 03:26:27 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <devicetree@vger.kernel.org>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devarsht@ti.com>, <u-kumar1@ti.com>,
        <j-choudhary@ti.com>
Subject: [PATCH v2 4/7] arm64: dts: ti: k3-j721s2-common-proc-board: Add main_i2c4 instance
Date: Tue, 24 Jun 2025 13:56:16 +0530
Message-ID: <20250624082619.324851-5-j-choudhary@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624082619.324851-1-j-choudhary@ti.com>
References: <20250624082619.324851-1-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add dt node for main_i2c4 instance along with required pinmuxing.
Also add the gpio expander 'exp4' required by display connector.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 .../dts/ti/k3-j721s2-common-proc-board.dts    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index e2fc1288ed07..793d50344fad 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -148,6 +148,13 @@ J721S2_IOPAD(0x060, PIN_INPUT_PULLUP, 13) /* (AC27) MCASP2_AXR1.I2C3_SDA */
 		>;
 	};
 
+	main_i2c4_pins_default: main-i2c4-default-pins {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x014, PIN_INPUT_PULLUP, 8) /* (AD25) I2C4_SCL */
+			J721S2_IOPAD(0x010, PIN_INPUT_PULLUP, 8) /* (AF28) I2C4_SDA */
+		>;
+	};
+
 	main_i2c5_pins_default: main-i2c5-default-pins {
 		pinctrl-single,pins = <
 			J721S2_IOPAD(0x01c, PIN_INPUT, 8) /* (Y24) MCAN15_TX.I2C5_SCL */
@@ -370,6 +377,23 @@ exp2: gpio@22 {
 	};
 };
 
+&main_i2c4 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c4_pins_default>;
+	clock-frequency = <400000>;
+
+	exp4: gpio@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "DP0_PWR_SW_EN", "DP1_PWR_SW_EN", "UB981_PDB",
+				  "UB981_GPIO0", "UB981_GPIO1", "UB981_GPIO2",
+				  "UB981_GPIO3", "PWR_SW_CNTL_DSI0#";
+	};
+};
+
 &main_i2c5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c5_pins_default>;
-- 
2.34.1


