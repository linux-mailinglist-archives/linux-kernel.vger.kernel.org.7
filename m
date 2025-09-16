Return-Path: <linux-kernel+bounces-819057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CBEB59ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6798C189F7A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3F2343D90;
	Tue, 16 Sep 2025 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="iegQpZ/N"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C379330E0F5;
	Tue, 16 Sep 2025 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034040; cv=none; b=VodLQ21SQVb9ME6IQwBEk6vTmgWjy51bxdvaBpBjEkNaaScC96DTORZgwsFsz8vWplxTlP8adJldhY7hKqCLaU3b59wYJCkg7X7Bn0cNobpJHZHIT9StRmzh8liGGMlMvUx6oRXSdN6UjQOU8KJdM9KablSijTfgznDkXudhMes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034040; c=relaxed/simple;
	bh=/dTeJXdPxUT53/ruJthxURTgDXuMrYo4Vt5Nrzhj828=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Elhh7f1DAUpXNlhEZ8Us7wb7mSb4k2an/am4IqoMXfPN7nIKWclUT84FhFceN3K6fLT5Nx/lf6+TDljJ5d3jYTJ5ug2m9qu/0HB0F0sh5dq/sGVhljwfib9rHMrg/pK2es48x9KbTQBB094ntse50m5cafxnPihpPVja8PFvL8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=iegQpZ/N; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from Monstersaurus.lan (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6BBDC8D4;
	Tue, 16 Sep 2025 16:45:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1758033956;
	bh=/dTeJXdPxUT53/ruJthxURTgDXuMrYo4Vt5Nrzhj828=;
	h=From:To:Cc:Subject:Date:From;
	b=iegQpZ/Nnu/0NTRKHBLZgQ57/302Okt9v041Ht7QjnlH8DT9U+6kRbLbND+1+tNcx
	 sXagert615SuTGfA2XlbPcR4SZw9z86g2k72Z9cq7jk8IsK+ckaCSkEwvE0mLb1ahU
	 O/sKQBPjHJul0BeJuBATD5n9UVExtcLDhsdKgj6Q=
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: [PATCH] arm64: dts: freescale: debix-som-a-bmb-08: Enable HDMI output
Date: Tue, 16 Sep 2025 15:47:09 +0100
Message-ID: <20250916144710.1285650-1-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the HDMI output on the Debix SOM A board, using the HDMI encoder
present in the i.MX8MP SoC.

Enable and configure all nodes required for the HDMI port usage.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

---

This replicates 4880ee1c9046 ("arm64: dts: imx8mp-debix-model-a: Enable
HDMI output") to support the Debix SOM as well.


 .../freescale/imx8mp-debix-som-a-bmb-08.dts   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a-bmb-08.dts b/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a-bmb-08.dts
index d241db3743a9..04619a722906 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a-bmb-08.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a-bmb-08.dts
@@ -22,6 +22,18 @@ chosen {
 		stdout-path = &uart2;
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_out>;
+			};
+		};
+	};
+
 	reg_baseboard_vdd3v3: regulator-baseboard-vdd3v3 {
 		compatible = "regulator-fixed";
 		regulator-min-microvolt = <3300000>;
@@ -222,6 +234,28 @@ flash: flash@0 {
 	};
 };
 
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmi>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			hdmi_tx_out: endpoint {
+				remote-endpoint = <&hdmi_connector_in>;
+			};
+		};
+	};
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
 &i2c4 {
 	expander0: gpio@20 {
 		compatible = "nxp,pca9535";
@@ -276,6 +310,10 @@ ethmac2: mac-address@c {
 	};
 };
 
+&lcdif3 {
+	status = "okay";
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -430,6 +468,15 @@ MX8MP_IOMUXC_NAND_DATA03__FLEXSPI_A_DATA03      0x82
 		>;
 	};
 
+	pinctrl_hdmi: hdmigrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x1c3
+			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x1c3
+			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x19
+			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x19
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL			0x400001c2
-- 
2.50.1


