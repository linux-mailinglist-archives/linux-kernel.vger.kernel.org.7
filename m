Return-Path: <linux-kernel+bounces-732903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF73CB06D85
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008E8566698
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898BE2E92AC;
	Wed, 16 Jul 2025 06:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KoYcpJj5"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C068246BA7;
	Wed, 16 Jul 2025 06:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752645686; cv=none; b=YwSt11oYEb3P1/s/zjT8EezEKPcJwXEFUhzZkQjwB2s0gR/5qqpsrM+JgPXhjsLom/eHCR3OAURhEkGmIlZjSSwvb5uPtf217Ql6/WbFFnexFF/GaUg1SIifxwivZFTkYts1FaWYg9ibT9RqK1MSAgMNDoolAl+sWLqTmpcnqGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752645686; c=relaxed/simple;
	bh=NzpnwAKNOroiG9Is8Ab4jaStduOIzvE5582cGxYbxEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFqOFIOpvsRzJfjSQ/JoqShfuVRFT3SeXwZ2ZLU5KosUoI1kEhAYgsO+OP48x5z/5yjqGg1ear58q47Oi5sppQizLioFaUBeFUOkBs6m7bReN1c7MuChMLR10C5KKEU8MrVs0ZnYsSWyG8QT365uOPaBVpVCIAa8zAnxcB7rd/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KoYcpJj5; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56G61Jeo2432908;
	Wed, 16 Jul 2025 01:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752645679;
	bh=V6Jx7tymbv7CFfVuioCoeqVpv/okvvgwHXucpnHXpPU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KoYcpJj5J29U7NdEo40tE/J5AFz6Xw/Bxo1PePX58jgaYQFjTaj4ouzxBVD51mLjw
	 lvicjBOc0t/2siqdMIGv+eDq9tN2allUDrfqBAJ3KRYh6CfsZkrm5cXM5YPuXBaSGl
	 sxKYDiLSNzFI06UWnGVlBTTkGFswoj/SicO8Jx3c=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56G61Jb5622864
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 16 Jul 2025 01:01:19 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 16
 Jul 2025 01:01:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 16 Jul 2025 01:01:19 -0500
Received: from localhost (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com [172.24.227.166])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56G61IoZ4147917;
	Wed, 16 Jul 2025 01:01:19 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <devarsht@ti.com>, <j-choudhary@ti.com>
Subject: [PATCH v3 2/7] arm64: dts: ti: k3-j784s4-j742s2-evm-common: Enable DisplayPort-1
Date: Wed, 16 Jul 2025 11:31:09 +0530
Message-ID: <20250716060114.52122-3-j-choudhary@ti.com>
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

Enable DSI display for J784S4 EVM.

Add DT node for DSI-to-eDP bridge. The DSI to eDP bridge is
SN65DSI86 on the board.

Add the endpoint nodes to describe connection from:
DSS => DSI => SN65DSI86 bridge => DisplayPort-1

Set status for all required nodes for display as 'okay'.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 .../dts/ti/k3-j784s4-j742s2-evm-common.dtsi   | 121 +++++++++++++++++-
 1 file changed, 120 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
index fa656b7b13a1..7b2d8d140c33 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
@@ -301,6 +301,52 @@ codec_audio: sound {
 		clock-names = "cpb-mcasp-auxclk", "cpb-mcasp-auxclk-48000",
 			      "cpb-codec-scki", "cpb-codec-scki-48000";
 	};
+
+	vsys_io_1v8: regulator-vsys-io-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_io_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_io_1v2: regulator-vsys-io-1v2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_io_1v2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	edp1_refclk: clock-edp1-refclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <19200000>;
+	};
+
+	dp1_pwr_3v3: regulator-dp1-prw {
+		compatible = "regulator-fixed";
+		regulator-name = "dp1-pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&exp4 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	dp1: connector-dp1 {
+		compatible = "dp-connector";
+		label = "DP1";
+		type = "full-size";
+		dp-pwr-supply = <&dp1_pwr_3v3>;
+
+		port {
+			dp1_connector_in: endpoint {
+				remote-endpoint = <&dp1_out>;
+			};
+		};
+	};
 };
 
 &wkup_gpio0 {
@@ -1340,12 +1386,26 @@ &mhdp {
 };
 
 &dss_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	/* DP */
-	port {
+	port@0 {
+		reg = <0>;
+
 		dpi0_out: endpoint {
 			remote-endpoint = <&dp0_in>;
 		};
 	};
+
+	/* DSI */
+	port@2 {
+		reg = <2>;
+
+		dpi2_out: endpoint {
+			remote-endpoint = <&dsi0_in>;
+		};
+	};
 };
 
 &main_i2c4 {
@@ -1360,6 +1420,65 @@ exp4: gpio@20 {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	bridge_dsi_edp: bridge-dsi-edp@2c {
+		compatible = "ti,sn65dsi86";
+		reg = <0x2c>;
+		clock-names = "refclk";
+		clocks = <&edp1_refclk>;
+		enable-gpios = <&exp4 2 GPIO_ACTIVE_HIGH>;
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
+				dp1_in: endpoint {
+					remote-endpoint = <&dsi0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				dp1_out: endpoint {
+					remote-endpoint = <&dp1_connector_in>;
+				};
+			};
+		};
+	};
+};
+
+&dsi0_ports {
+	port@0 {
+		reg = <0>;
+
+		dsi0_out: endpoint {
+			remote-endpoint = <&dp1_in>;
+		};
+	};
+
+	port@1 {
+		reg = <1>;
+
+		dsi0_in: endpoint {
+			remote-endpoint = <&dpi2_out>;
+		};
+	};
+};
+
+&dphy_tx0 {
+	status = "okay";
+};
+
+&dsi0 {
+	status = "okay";
 };
 
 &dp0_ports {
-- 
2.34.1


