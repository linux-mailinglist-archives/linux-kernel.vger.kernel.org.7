Return-Path: <linux-kernel+bounces-732909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02165B06D94
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AA350572B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2112EA747;
	Wed, 16 Jul 2025 06:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TpnwFaIA"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2D22E88B2;
	Wed, 16 Jul 2025 06:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752645701; cv=none; b=sJX5W215zgZGie9oAK0hJuSoMjAF86YH/8ccHeHthWjsqYj1waYSJurccb8UAwPKZ8VfHXrG/lIXEXQP4B2n0KJSy1I28dgrBpLERGPF3lws+N9YBD252T5WblQ4XYHRLYixDr/AKd0ynmYe4ileCXggEQESgKG+Pm8wiFSkpxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752645701; c=relaxed/simple;
	bh=LHRTEvUUM2wFe7/UOSfbcrTixO0+FchDqCCzEeMPXbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=un03y11jE58viUlI9BPxlBapqo5OFdKLlmBgwYjKaMutEgOZnM/TQ7+IXrZpAtX0vi9ZHtlSHTNDuHlgYSak5t8PniE06RS0YX2Gnxp9TL9VnGfnVVo6c4IxXN7yLjMiTeA7CoT351KXsBzUcZ3mm6J8T53BPzOUA+QOLY7eqjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TpnwFaIA; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56G61Tkk2780004;
	Wed, 16 Jul 2025 01:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752645689;
	bh=EfhC+fRBJi2ioYPPzzT0wvQ4hQqFwGQeBV9kL8bT9Wo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=TpnwFaIAeVZDZWZeMdiR5udHdhP3/5QlDajy21MmJGWNrIr+ySQFbthptPTNHaBZ8
	 UtnyMJEW5iaD2Q2KjkLgS/cWcGsq87E2o9TqyESqdivxYlHGoRcjIQio2VVpW+Za7l
	 2TGQ/mZCljgBzK6LBPFbkjnUj8eODIbT0f7LeoT4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56G61T5w1794725
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 16 Jul 2025 01:01:29 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 16
 Jul 2025 01:01:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 16 Jul 2025 01:01:28 -0500
Received: from localhost (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com [172.24.227.166])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56G61RAb3833131;
	Wed, 16 Jul 2025 01:01:28 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <devarsht@ti.com>, <j-choudhary@ti.com>
Subject: [PATCH v3 7/7] arm64: dts: ti: k3-am68-sk: Enable DSI on DisplayPort-0
Date: Wed, 16 Jul 2025 11:31:14 +0530
Message-ID: <20250716060114.52122-8-j-choudhary@ti.com>
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

Enable DSI support for AM68-SK platform.

Add DT node for DSI2eDP bridge. The DSI to eDP bridge is sn65dsi86
on the board.

Add the endpoint nodes to describe connection from:
DSS => DSI => SN65DSI86 bridge => DisplayPort-0

Set status for all required nodes for DisplayPort-0 as 'okay'.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index e84c504c87d2..cf42a001b2ef 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -135,6 +135,34 @@ transceiver4: can-phy3 {
 		max-bitrate = <5000000>;
 	};
 
+	edp0_refclk: clock-edp0-refclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <19200000>;
+	};
+
+	dp0_pwr_3v3: regulator-dp0-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "dp0-pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&exp2 2 GPIO_ACTIVE_HIGH>;     /*P0 - DP0_3V3 _EN */
+		enable-active-high;
+	};
+
+	dp0: dp0-connector {
+		compatible = "dp-connector";
+		label = "DP0";
+		type = "full-size";
+		dp-pwr-supply = <&dp0_pwr_3v3>;
+
+		port {
+			dp0_connector_in: endpoint {
+				remote-endpoint = <&dp0_out>;
+			};
+		};
+	};
+
 	connector-hdmi {
 		compatible = "hdmi-connector";
 		label = "hdmi";
@@ -615,6 +643,39 @@ exp2: gpio@20 {
 		gpio-line-names = "HDMI_PDn","HDMI_LS_OE",
 				  "DP0_3V3_EN","eDP_ENABLE";
 	};
+
+	bridge_dsi_edp: bridge-dsi-edp@2c {
+		compatible = "ti,sn65dsi86";
+		reg = <0x2c>;
+		clock-names = "refclk";
+		clocks = <&edp0_refclk>;
+		enable-gpios = <&exp2 3 GPIO_ACTIVE_HIGH>;
+		vpll-supply = <&vsys_io_1v8>;
+		vccio-supply = <&vsys_io_1v8>;
+		vcca-supply = <&vsys_io_1v2>;
+		vcc-supply = <&vsys_io_1v2>;
+
+		dsi_edp_bridge_ports: ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				dp0_in: endpoint {
+					remote-endpoint = <&dsi0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				dp0_out: endpoint {
+					remote-endpoint = <&dp0_connector_in>;
+				};
+			};
+		};
+	};
 };
 
 &main_sdhci1 {
@@ -711,6 +772,15 @@ dpi_out0: endpoint {
 			remote-endpoint = <&tfp410_in>;
 		};
 	};
+
+	/* DSI */
+	port@2 {
+		reg = <2>;
+
+		dpi0_out: endpoint {
+			remote-endpoint = <&dsi0_in>;
+		};
+	};
 };
 
 &serdes_ln_ctrl {
@@ -768,3 +838,30 @@ &usb0 {
 	phys = <&serdes0_usb_link>;
 	phy-names = "cdns3,usb3-phy";
 };
+
+&dphy_tx0 {
+	status = "okay";
+};
+
+&dsi0 {
+	status = "okay";
+};
+
+&dsi0_ports {
+
+	port@0 {
+		reg = <0>;
+
+		dsi0_out: endpoint {
+			remote-endpoint = <&dp0_in>;
+		};
+	};
+
+	port@1 {
+		reg = <1>;
+
+		dsi0_in: endpoint {
+			remote-endpoint = <&dpi0_out>;
+		};
+	};
+};
-- 
2.34.1


