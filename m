Return-Path: <linux-kernel+bounces-874779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52712C170E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52B43A5D71
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF602DEA7D;
	Tue, 28 Oct 2025 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SoYAQ+8l"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013003.outbound.protection.outlook.com [40.107.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3036B2DE6EF;
	Tue, 28 Oct 2025 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687463; cv=fail; b=rtTgv5Wdv/kIx3J4qUmN4khBqPbxhk4hH8kzWn+AhCPk2idUaT1qBl+W3M1HrKFIncE19NRL/Snmw2O5lfZtYXz4sfmlcx0nKWT40akyEiA9EQ7hpj47jAt6WUBYf7roUAB/7JQufSScUzDFnRceifhhoTWL78rfSWJVZYr+U6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687463; c=relaxed/simple;
	bh=uI7+28RVGbM69UR1Wbcm2p94E6CCXxuCnurojSTTkfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qd9vubtobC/btEhF3xepHH4V/JopZmpUlYLAOVfuGnkKxd5J5T7w7zw0QIyX75C9pw4/Ss38y4OffNfAZb2IOEJgzT+LcRFTMOPTbcilN1pQJXiljD1bBx1zuXzOI4swIolJt3+fQewS0/S3r22CA24ihG3tBJlyO7adlMcT+fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SoYAQ+8l; arc=fail smtp.client-ip=40.107.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jn6t0AfCYYGswtskLe/pNJBrB+rXkDAhY7xyUDrdDkupGLJsh05z8a4gPOvU3I/eA5TxKh0KDPJzJd9KMiHonGX2zWgAt25u2k8fMr/rVoBU8JWL1/tr4aViLTbdN7/6s95ZKnXD3qvYtzUFdMcozTaJav2Qcj7CGu/4y5C5OpizgPWTmhZ1npeyBcmazKyXliCPiinTKSuLFPcTSotlal1LfT0U36A+e6oMVAeyCLVsfG9zdx0B2F2PY3JOBee52qHWSSkui8ZS/RSqiBUmz32ymX/mJwz23tkqJRxjPRQw/y3K0L0c/3Yc5JFCcUDR3EKhIwddAbbuqQIuN2PDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDLc0zxUq6Lzd3IE27Ezfr/loqGRFV7S8iikk8RHAcw=;
 b=Cz7cr/cPBPWnQJYdOemPilaOmViShBh6/jACW0JhNDOI563j8/XNSUvOIGS+Ezu6sI+6joDdaxZZEWsHSmwQWllFwbNGfeFnTmSK8rqL1LtsrWqtG42qoolmZ4L8d/ZdYRZhv3K7QxNIyE23v1RBk+fH24ilrm1NIaNQGFv17uX1d58YhVFOy8w0FlMNq3qai6pGeS0x2AXv1M5NUV76h9d4DUHcO7qDyh5riWcnsU/tJxoGFY5j+RoI2emBVbaLtUULpq733bVHvvhDpwDR1D1r/VGpPJE8lBqpjtC7Ze+EE3ZAC90JpQttM6vsuIJAJmBh1rr3PDFdR0gjpnSZQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDLc0zxUq6Lzd3IE27Ezfr/loqGRFV7S8iikk8RHAcw=;
 b=SoYAQ+8lFYeU7wHwAAqUdVmKM2ElIFJxyMM7v0l5dZJMmuttTfCYlz+L/cOUmBQjYzvYWbpJEV5H67psnRAgRFxkaUfqkdfvLYyXrzI7i4bxa1l7N6X2N7X+njEwV44QgXthPFhEjCIcG5QgKoYAH3aJfFAihbFrTaXXRgacLiE=
Received: from PH7P220CA0056.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::14)
 by PH0PR10MB5579.namprd10.prod.outlook.com (2603:10b6:510:f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 21:37:38 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::36) by PH7P220CA0056.outlook.office365.com
 (2603:10b6:510:32b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.20 via Frontend Transport; Tue,
 28 Oct 2025 21:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 21:37:38 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 16:37:28 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 16:37:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Oct 2025 16:37:27 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59SLbQrc2969806;
	Tue, 28 Oct 2025 16:37:27 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
	<s-ramamoorthy@ti.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-am62d2-evm: Enable PMIC
Date: Wed, 29 Oct 2025 03:06:45 +0530
Message-ID: <20251028213645.437957-3-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028213645.437957-1-p-bhagat@ti.com>
References: <20251028213645.437957-1-p-bhagat@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH0PR10MB5579:EE_
X-MS-Office365-Filtering-Correlation-Id: b541fcb5-8e1f-46cd-9de5-08de166a3751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|34020700016|34070700014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sdPGFmt6e93ACKEE7G0MRnUVtzovIFuAa9wlRtYQEJe9/AtDKHdzPsIJvaQy?=
 =?us-ascii?Q?sWs7B8u5ogQC70jk/GMbiAG87gNMzb/1POMDsX/MrQr+eM2rwhA+A/GHe108?=
 =?us-ascii?Q?i7Q4D3eoquBcbZKNNl16JlZ4OYU6oNedpBSi/D+AA7VeQCYLfrG/Bs5r6I5u?=
 =?us-ascii?Q?9OnSQOQ5Z0qCuz/NCmlC9+6R8h/LPKFVnu4wVnPl5LI/gGjXjLz3sTttSFCX?=
 =?us-ascii?Q?SMFq8WGfd0kbIIyveTXJs79FtuVBjySXflk38vcaO89zJejOev6iMBi1u/OR?=
 =?us-ascii?Q?iXmaiO1I57S4xuz9lgHWvMzd8QJ/vDzclj245DgCyoB/tuFtmLqC1wlAh/QW?=
 =?us-ascii?Q?EsHLAFgIVGLMiv48fXeRG8NnKYi24diMcV7+CdbF1Dwm175FjBKa9WHnWNhg?=
 =?us-ascii?Q?bjpLvgndAueSSgAfeiAqu1pdHcuUU1ylp7cHmnHwbaqD8OefRp8pLqZ0ShYx?=
 =?us-ascii?Q?/J4jd1+nRHBKjK5GUfh/YGRoUsz5U2+ck4aANUVgzrhlOa/0EW0+74ejdL3e?=
 =?us-ascii?Q?8Wow6CzTBgLb8R6ZyjR0K7lMF/75r0LEx7yBwG3aYdhMBFyQn1pMC59Tfyua?=
 =?us-ascii?Q?NsUMbDOcWQ8sVYiRxwYOugCuUmZFlQpavRgRb96HJwD33rvhJObbZ5CZznRR?=
 =?us-ascii?Q?k5Fr1zVUAi4UH5796jaNNIdtB4NV6hPVGXbUYELbjPjLuOTo0OlHdJ6YSD0W?=
 =?us-ascii?Q?MSz5mZNYJPwViv8qV7ISuMjk0A7FPivWpxuud6SXSr7MDxO1QRf3WhwF9tDJ?=
 =?us-ascii?Q?PqaMeZBasuWM3GgN+2n+D1JHD8umHrIKHVjzPa1hGDhLliiqmOpFqXLmIK64?=
 =?us-ascii?Q?dxe8rfup63tJ15m2O0g0r+m0PZC8WNPRyCk1CdRqdCpgJADUFUjvH7zWZ7tf?=
 =?us-ascii?Q?xAcP+A8lPr39wyCsYD6MjeAZm6djEvBpuOdG7XUHYH1IEk1Naw1xm6ezaamb?=
 =?us-ascii?Q?5H8FB+AoVtznHbtbZXix5KBxQJsecW+iasg5msGEPyHBtt+uaq319CTTgXfb?=
 =?us-ascii?Q?FP9v/0hUkxcYje4J2WKSydYdVuHkVkbE1E8DOtaazZ6fP/4YRosHMgFwYabG?=
 =?us-ascii?Q?O7F/X9YGmJFCYr5DOfby1QR1ordCZQj1l8BHBQFqEWXuktotaAoPwQD/mZY7?=
 =?us-ascii?Q?w5A5rrtQHlvd3M7IFHrvSV7+5s+sn1YmwAMvxJ2uDsCnBIHvTlUmmD0UHf0m?=
 =?us-ascii?Q?jZ2kvvJ8eBPcSQx9Rc3Spaiw24l6CpsG7fJPqR8XWxZfy809E/N37xvw1Bub?=
 =?us-ascii?Q?OH2J7UyM8r1ganVwlUluoiVpVWgzoANIhEXQ9OpeG7LVBl1LmVzNhlOrV8KT?=
 =?us-ascii?Q?JlBRXHqGL4XBEtFrRRjtlG7iLkGZ4kd+u1EOnbLYf0w736LoLMmR9dKG8bKm?=
 =?us-ascii?Q?FU719c09awuR1N0O5GnMxshWFggg6uuVPK2iR2gmpsEzj9/9xWS3HNFKfdfa?=
 =?us-ascii?Q?Trgw4YhY7bOlyJi04+RcMhhdKJIPRLDx9Do9DO+zq3elVfelCLFNFhQAaJsZ?=
 =?us-ascii?Q?seem+7I8BI4YE373dy581TZ0+J+lByj+YyeDybwFUt97aFjmCSykFWA6hYNP?=
 =?us-ascii?Q?qnMIHPp/i/qKa8S6JRY=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(34020700016)(34070700014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 21:37:38.2717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b541fcb5-8e1f-46cd-9de5-08de166a3751
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5579

Add support for TPS65224 PMIC family on wakeup I2C0 bus. This
device provides regulators (bucks and LDOs), along with GPIOs,
and monitors SOC's MCU error signal.

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
Reviewed-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>
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


