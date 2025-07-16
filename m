Return-Path: <linux-kernel+bounces-732908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBF2B06D90
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23961AA8621
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEEA2EA72C;
	Wed, 16 Jul 2025 06:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oNnIfuEs"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43852EA48C;
	Wed, 16 Jul 2025 06:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752645696; cv=none; b=TA+GleHHc4AxFhaIJBqt8TkODWuHvhaBMCUjj3WowgcYnbYXRA5RY5w7i5jPc/uA3CwoAJDg8FlOPXvddClmiQntiSx52qzL37fzr3bErUM8pbdv3Bn8yk/gQnwauecuRAiw3IAiYBTWPOmx/N5Lzfddr8CPnrbeVSMKiVQf5aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752645696; c=relaxed/simple;
	bh=a9gPC3hAeynqQc8OYfrBKNMOnVtTlG+LdvhB9M89GWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ew1C5bRV8CMDjRpj1l+YucwvGfC91eWedkW+IyzA2dlGUUqnp+tma2dEC3RA3C2C9Vwt7WVKlpMnP25J3SnIbvAlFueT0npa38GGWsFp3MWdaNd5i+4fiE0xw1aGvmKzZUbqP69sUu3tZeJ+x/UAceaLbA1NjqrSBh7aqVv6c7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oNnIfuEs; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56G61Nl92779980;
	Wed, 16 Jul 2025 01:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752645683;
	bh=cdT6uLvt7v0OlGBZcXbpnLNPp3K3v9W/E3AD3dZIWto=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=oNnIfuEshX9GFXX0l92jgSjZlaaLE158rLYIK0dSwhhHkq2KgpFllx5wcmbGHbgL7
	 CZl+YVWflOF4FJzW+gyFIGkwU0lcKI0RwmICOkeTZD8j5o8jA3C9uQysg7q7lL6rxj
	 3vLe4fCHYafMSJImrG/pBqUuXwD0+sdnN3+c06sI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56G61NK21145911
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 16 Jul 2025 01:01:23 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 16
 Jul 2025 01:01:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 16 Jul 2025 01:01:23 -0500
Received: from localhost (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com [172.24.227.166])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56G61MGc3833036;
	Wed, 16 Jul 2025 01:01:22 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <devarsht@ti.com>, <j-choudhary@ti.com>
Subject: [PATCH v3 4/7] arm64: dts: ti: k3-j721s2-common-proc-board: Add main_i2c4 instance
Date: Wed, 16 Jul 2025 11:31:11 +0530
Message-ID: <20250716060114.52122-5-j-choudhary@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716060114.52122-1-j-choudhary@ti.com>
References: <20250716060114.52122-1-j-choudhary@ti.com>
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


