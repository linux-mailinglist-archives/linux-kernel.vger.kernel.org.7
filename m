Return-Path: <linux-kernel+bounces-732907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9031AB06D92
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E317E503E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8AA2EA46E;
	Wed, 16 Jul 2025 06:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r983+AW8"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F042E9ED8;
	Wed, 16 Jul 2025 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752645693; cv=none; b=eOhZKJVtezwxSEYbt/Ma1ZyzYa+BhNlIp+yyfeWlIpUmUaXuvQ0we1NvckcSZiP1s52CltxjiEYCdsmXjFWWqoeY8s7NEnEpf0mqC50c7eg76MjEB774Zuj1xONdoAa72ArFhJfz+46dpwMTvhzS1VbzX45/Zqb8VhuOjO64w3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752645693; c=relaxed/simple;
	bh=HeTzR7SnMEep9Lks+TH8yh8SylpZ16gVU/YJI565usU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYeEK2dyzVw+N1JJIgIFzjbzt9XdFS/r6nFsPY3jUNJESCR0t+m6XkFvwvj2u4qPvI6B9rQEGg5uNy3VYsNyoUNPx/WOl6ixSyPwfrXUhRLEe2oOpLFCW/cWwFxmLKSV/yHWCIzMUoW1CvLCnu3qBh8tlhO6ea2DLPPQenBGwdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r983+AW8; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56G61RDD2432916;
	Wed, 16 Jul 2025 01:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752645687;
	bh=G6zqXe5pVBIsCrti9HFsAGQfL6mflrZuLCKhZI3cLY0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=r983+AW8PgM3JpIbP6zY9/5LhwiqHqdznApqaEBP9rilqnUtXREURJz95fWQeYQrQ
	 nXJTYP8p9s2dQV6ylj7L89K6OLOZIJaEMUNhDFsrqb1oC0cZRaDPYUK2SK5KMkjPHl
	 hvj0IWG+tmA+mFT2d5m+NvNACLLOFZeRkAhSD7Ak=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56G61Ret3321712
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 16 Jul 2025 01:01:27 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 16
 Jul 2025 01:01:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 16 Jul 2025 01:01:27 -0500
Received: from localhost (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com [172.24.227.166])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56G61P823833093;
	Wed, 16 Jul 2025 01:01:26 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <devarsht@ti.com>, <j-choudhary@ti.com>
Subject: [PATCH v3 6/7] arm64: dts: ti: k3-j721s2-common-proc-board: Enable DisplayPort-1
Date: Wed, 16 Jul 2025 11:31:13 +0530
Message-ID: <20250716060114.52122-7-j-choudhary@ti.com>
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

Enable DSI display for J721S2 EVM.

Add the endpoint nodes to describe connection from:
DSS => DSI Bridge => DSI to eDP bridge => DisplayPort-1

Set status for all required nodes for DisplayPort-1 as 'okay'.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 .../dts/ti/k3-j721s2-common-proc-board.dts    | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index 793d50344fad..9e43dcff8ef2 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -93,6 +93,28 @@ vdd_sd_dv: gpio-regulator-TLV71033 {
 			 <3300000 0x1>;
 	};
 
+	dp1_pwr_3v3: regulator-dp1-prw {
+		compatible = "regulator-fixed";
+		regulator-name = "dp1-pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&exp4 1 GPIO_ACTIVE_HIGH>; /* P1 - DP1_PWR_SW_EN */
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
+
 	transceiver1: can-phy1 {
 		compatible = "ti,tcan1043";
 		#phy-cells = <0>;
@@ -563,3 +585,74 @@ &main_mcan5 {
 	pinctrl-0 = <&main_mcan5_pins_default>;
 	phys = <&transceiver4>;
 };
+
+&dss {
+	/*
+	 * DSS on J721S2-EVM supports DP on VP0 and DSI on VP2.
+	 * These clock assignments are chosen to enable the following outputs:
+	 * VP0 - DisplayPort SST
+	 * VP2 - DSI
+	 */
+	status = "okay";
+	assigned-clocks = <&k3_clks 158 2>,
+			  <&k3_clks 158 14>;
+	assigned-clock-parents = <&k3_clks 158 3>,
+				 <&k3_clks 158 16>;
+};
+
+&dss_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	port@2 {
+		reg = <2>;
+
+		dpi2_out: endpoint {
+			remote-endpoint = <&dsi0_in>;
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
+&dsi_edp_bridge_ports {
+	port@0 {
+		reg = <0>;
+
+		dp1_in: endpoint {
+			remote-endpoint = <&dsi0_out>;
+		};
+	};
+
+	port@1 {
+		reg = <1>;
+
+		dp1_out: endpoint {
+			remote-endpoint = <&dp1_connector_in>;
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
+};
-- 
2.34.1


