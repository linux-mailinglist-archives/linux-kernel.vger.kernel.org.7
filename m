Return-Path: <linux-kernel+bounces-735387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A921EB08E97
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5D3169DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BA02F6F99;
	Thu, 17 Jul 2025 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="SjB7dQWG"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazrln10223024.outbound.protection.outlook.com [52.103.171.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC1D2D6419;
	Thu, 17 Jul 2025 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.171.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760445; cv=fail; b=aasblaWEuX/PumFDS45DtzEDuAtc/DtE7KEkAUOhyLliHo7MFhJRgv81dafxYnZmW+F/nGiaNO+W2QMtxPKwanG5cpHHDy9FKGowLWRSeNGo/9J4KtLYtTsD5r7YZiIeIXmWMS8QCGkiSrp5ig8WTsl3mmfrt+j+CLb+mitfUhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760445; c=relaxed/simple;
	bh=yfBcsoZR/Jw2E44igxP022kqQ/6fSawOgq0D+SbSgcs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nUBSWDbMuYXFoLfNjCtavnWMo1t9UioiBAxvziAG0cQ48gjDZjta7F2H+G177PTF4vnehHHG2ms69w/CNfurAuD8SH6BnBA8Yj55xh94TNRAgg1xbOPYiOQ/hVSk7B6ynvFA0efAsJ1viMa41MWZXa1PkriizD5phAcUZ96ODOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=SjB7dQWG; arc=fail smtp.client-ip=52.103.171.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htNS9XRU71r8OAWajImq2HgtPpsTpLebRSY7Raqe75EXsnnupdZugBTpC00vMmXu7bg9BzkkNvR9JoePOgtOd0unOM8DPh41joFaMlgwm+Ep7Ipr582jbnXBHpK9qU0oCAa5eAdt7/MVpB4j7HMKleJtveh8knVUG57fxVo5ifQ1owqPkraGBW4qXXDnhMPrJC1sknWXCxVPlVGVXCT2V0z1nThhFaELX4VphMPhc+C1SQIHyVV2QIV96j7DNXh5JiEnvyZZ4btlwhsYIzAAKT55d0wcXDdJz33pPVyRDwlQVFBu1ogaLeG5Zy1MFvrAFqeat5OUxljUd3rpOg9Jng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuEumtwGw7nMtGOm3NA/Oj137znBiQwBOdKPZ2BTzk8=;
 b=PjDURnGHhAv+VYRl3T8lWLAefhHRtiNfEITh9Bx/ruwFqWWT62SEMG5oYi83SGBNpv7IJVbydO2cWHLEMk9bHpC3qmImJTt1vbZ43DqS7O8ZuUH4uezt1uAHk0Nbrct54mLuD1GALh9A7ePrhxg+PWF/yfCZbDjS6Nj0HjpkbvdVaGK5nR6Ixb41HWqrn9doGrBByNra1DFMhXEO8wInLoCJmFEKXfLjimYdWWoAFE44zALziv3hP5fD+6fyDx706KnFw5FRE3ZM3d6tFLY6GD0GZxio8/LLzc2+r/P93Wwv9msLPegLmYW5GnYvh8i1klhe//j1tm1X6i6M0vkTEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 211.75.126.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=taln60.nuvoton.co.il;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuEumtwGw7nMtGOm3NA/Oj137znBiQwBOdKPZ2BTzk8=;
 b=SjB7dQWGIgPNtPlGwZl4Ck3lKI2ubD3vJvqyGlOs9dVXL2NeJwkok0NErzMvZrvZ7U6nyq7X7zrAO88B6FijfSwEQ0sd0LtMyVDjegccSMeP5YFBnpb4rD/tWmjAeO27EftDzwYqiP7MRNHGILdZmSo6h4xB87u/KytjAyssQCY=
Received: from SG2PR02CA0003.apcprd02.prod.outlook.com (2603:1096:3:17::15) by
 PUZPR03MB7113.apcprd03.prod.outlook.com (2603:1096:301:11a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 13:53:46 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096:3:17:cafe::1a) by SG2PR02CA0003.outlook.office365.com
 (2603:1096:3:17::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Thu,
 17 Jul 2025 13:53:45 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 211.75.126.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 13:53:44 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 17 Jul
 2025 21:53:41 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 17 Jul
 2025 21:53:41 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 17 Jul 2025 21:53:41 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 097DB5F630;
	Thu, 17 Jul 2025 16:53:40 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 06E7BDC084A; Thu, 17 Jul 2025 16:53:40 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
	<joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
	<benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 2/2] arm64: dts: nuvoton: npcm845-evb: Add peripheral nodes
Date: Thu, 17 Jul 2025 16:53:36 +0300
Message-ID: <20250717135336.3974758-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717135336.3974758-1-tmaimon77@gmail.com>
References: <20250717135336.3974758-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|PUZPR03MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9c9a07-9c34-4105-7497-08ddc5395887
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35950700016|82310400026|48200799018|61400799027|7416014|376014|7093399015|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eqnSmsrkd64ZoIzXSXQatQIUuoNjFzLk9jM5//GWxluEzha0x7wpLblWTsqN?=
 =?us-ascii?Q?tWxAqnbU1IkDLDPI+IXKTPMm4qaKYatb3fq2IAJH4c4QBpRTCKfOpNtk89s7?=
 =?us-ascii?Q?1z27CmQ+3qCJN6f/1Ljdbarc90Mpjz3kLHjnjYf+KkP59AXCXbeDON0H5pNm?=
 =?us-ascii?Q?omichIjUKBr9QqncHoQvW/Io4fDDaiU6EcPkxc3EWzi7VnQdTwabzwu6NLR7?=
 =?us-ascii?Q?zZKTakU26R0OOxVMq+uPO8QGeRKv/dbiXv28LPAYZfz26WYXKFdMxt0vl6OG?=
 =?us-ascii?Q?/OXRgu5lG4c5DilIAvQBd/W+7pAy7yB0pI7E7oy9ajtRY0Hs5F++nUmKfTE8?=
 =?us-ascii?Q?E+JMYkwwLiUwEMNs2+i13UduyccnpNOdIs6TDFNtcxV1Zk8I8nXVZFteNROD?=
 =?us-ascii?Q?guPEA0LY6YSjCZ39cJTSbqvVxUbFg3/VKlZ5TPRhhmTS9uks32d9p++p9NZR?=
 =?us-ascii?Q?tphjdcOT6pisselcuvXA5YQS067efQs23T+Iw5gYxMJgi9Az0Sf69fzCwAZ6?=
 =?us-ascii?Q?7ozCMyWQAMAVw/x8EdS9NTRxQuXNzEvFQ25bM/rXcEzBsnr/KnNUIIfkoQzi?=
 =?us-ascii?Q?FTqIQhw65npO9cPDyhgP0BnBoII8rcanknnWAQWfD7MEaAchgG5tot17Jy+L?=
 =?us-ascii?Q?rwprsPO5tU/dNgIS6nqsZluA1ICT5eDnXA2jt8WqI3GDlRmRZackpYczKm8W?=
 =?us-ascii?Q?NKP1SndjYXD/O6chQzE37ltQ2k6jYreRD9vsS4Z+NshCz5Hm1V28FVmGgI/L?=
 =?us-ascii?Q?DuELbSENBIVIKI12c8+71NubSr7L9ugG2oLjzUastRF28XMczaK5f65zQOB4?=
 =?us-ascii?Q?5U6Worc5peuq5/fwtPbVrXeVooSHxYlIIlfieQ+1kot1nt2dZenzSqGW/vF5?=
 =?us-ascii?Q?IiEHqsD2VhYjUXZQH1B0g0Nc6lMyP4rFIElzXeoSZHV8JPIR8F/6XdoqUq8B?=
 =?us-ascii?Q?aw/lyB6lfw/2wtSJBpVrHvc2t0w6VGZPg/qjgTCJctmT2IpTpYvlWb7JF8b0?=
 =?us-ascii?Q?XmRoxqGhysWC7Pgkd2pPO9oYpj64GhyY0r9+B4i0Oc4r/5bA7ljJA6emyluv?=
 =?us-ascii?Q?Y3f/oZbo777P/3kmgeLu3d0lNZGJd004T0QoinDMyjI+oMAyigofvflrvhGP?=
 =?us-ascii?Q?P8gf3pt/iroB6VUZmFFYg91lpKHdJu2M41asVvprtnsJf3LS0Am9mOe10jaB?=
 =?us-ascii?Q?ONNucXuh+A1QzMF4p9EGW+RZ6Qvp+/OoK7Nb2b3hOHt4dgNaI/DHAQo61ptz?=
 =?us-ascii?Q?mZIUTAZDCw4RbvH/BzCkcdW0MtHHruNd7eve8HT7j+YUqYudLb2yN5e5Ok7r?=
 =?us-ascii?Q?gO0QiBRrIabW2qM1qidc1eT/jm9SgGS9guA/1YDiVzIERPoZaGMolt0R5TJ6?=
 =?us-ascii?Q?YVkaa+ghNsbt+m67GlobZzT19FQKO54uNU8qnh1uUgYRUnMZVmGKAPyhW/xu?=
 =?us-ascii?Q?hacrOu/WeQurTXT7oJxTTlPgUuv/IRbjw5GrhDo2860p3OC0r7/1opQQYsLI?=
 =?us-ascii?Q?lCGv0m2GDab8tC/pPVUG+f69HO/hKpaxvFIZ?=
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(35950700016)(82310400026)(48200799018)(61400799027)(7416014)(376014)(7093399015)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 13:53:44.3656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9c9a07-9c34-4105-7497-08ddc5395887
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7113

Enable peripheral support for the Nuvoton NPCM845 Evaluation Board by
adding device nodes for Ethernet controllers, MMC controller, SPI
controllers, USB device controllers, random number generator, ADC,
PWM-FAN controller, I2C controllers, and PECI interface.
Include MDIO nodes for Ethernet PHYs, reserved memory for TIP, and
aliases for device access.
This patch enhances functionality for NPCM845-EVB platform.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../boot/dts/nuvoton/nuvoton-npcm845-evb.dts  | 445 ++++++++++++++++++
 1 file changed, 445 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
index 2638ee1c3846..46d5bd1c2129 100644
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
@@ -10,6 +10,42 @@ / {
 
 	aliases {
 		serial0 = &serial0;
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
+		ethernet3 = &gmac3;
+		mdio-gpio0 = &mdio0;
+		mdio-gpio1 = &mdio1;
+		fiu0 = &fiu0;
+		fiu1 = &fiu3;
+		fiu2 = &fiux;
+		fiu3 = &fiu1;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &i2c7;
+		i2c8 = &i2c8;
+		i2c9 = &i2c9;
+		i2c10 = &i2c10;
+		i2c11 = &i2c11;
+		i2c12 = &i2c12;
+		i2c13 = &i2c13;
+		i2c14 = &i2c14;
+		i2c15 = &i2c15;
+		i2c16 = &i2c16;
+		i2c17 = &i2c17;
+		i2c18 = &i2c18;
+		i2c19 = &i2c19;
+		i2c20 = &i2c20;
+		i2c21 = &i2c21;
+		i2c22 = &i2c22;
+		i2c23 = &i2c23;
+		i2c24 = &i2c24;
+		i2c25 = &i2c25;
+		i2c26 = &i2c26;
 	};
 
 	chosen {
@@ -25,12 +61,421 @@ refclk: refclk-25mhz {
 		clock-frequency = <25000000>;
 		#clock-cells = <0>;
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		tip_reserved: tip@0 {
+			reg = <0x0 0x0 0x0 0x6200000>;
+		};
+	};
+
+	mdio0: mdio@0 {
+		compatible = "virtual,mdio-gpio";
+		gpios = <&gpio1 25 GPIO_ACTIVE_HIGH>,
+			<&gpio1 26 GPIO_ACTIVE_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy0: ethernet-phy@1 {
+		};
+	};
+
+	mdio1: mdio@1 {
+		compatible = "virtual,mdio-gpio";
+		gpios = <&gpio2 27 GPIO_ACTIVE_HIGH>,
+			<&gpio2 28 GPIO_ACTIVE_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy1: ethernet-phy@1 {
+		};
+	};
+};
+
+&gmac1 {
+	phy-mode = "rgmii-id";
+	snps,eee-force-disable;
+	status = "okay";
+};
+
+&gmac2 {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&r1_pins
+			&r1oen_pins>;
+	phy-handle = <&phy0>;
+	status = "okay";
+};
+
+&gmac3 {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&r2_pins
+			&r2oen_pins>;
+	phy-handle = <&phy1>;
+	status = "okay";
 };
 
 &serial0 {
 	status = "okay";
 };
 
+&fiu0 {
+	status = "okay";
+	spi-nor@0 {
+		compatible = "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-rx-bus-width = <1>;
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+		partitions@80000000 {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bbuboot1@0 {
+				label = "bb-uboot-1";
+				reg = <0x0000000 0x80000>;
+				read-only;
+				};
+			bbuboot2@80000 {
+				label = "bb-uboot-2";
+				reg = <0x0080000 0x80000>;
+				read-only;
+				};
+			envparam@100000 {
+				label = "env-param";
+				reg = <0x0100000 0x40000>;
+				read-only;
+				};
+			spare@140000 {
+				label = "spare";
+				reg = <0x0140000 0xC0000>;
+				};
+			kernel@200000 {
+				label = "kernel";
+				reg = <0x0200000 0x400000>;
+				};
+			rootfs@600000 {
+				label = "rootfs";
+				reg = <0x0600000 0x700000>;
+				};
+			spare1@D00000 {
+				label = "spare1";
+				reg = <0x0D00000 0x200000>;
+				};
+			spare2@F00000 {
+				label = "spare2";
+				reg = <0x0F00000 0x200000>;
+				};
+			spare3@1100000 {
+				label = "spare3";
+				reg = <0x1100000 0x200000>;
+				};
+			spare4@1300000 {
+				label = "spare4";
+				reg = <0x1300000 0x0>;
+			};
+		};
+	};
+};
+
+&fiu1 {
+	status = "okay";
+	spi-nor@0 {
+		compatible = "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-rx-bus-width = <2>;
+		spi-tx-bus-width = <2>;
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+		partitions@A0000000 {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			system1@0 {
+				label = "spi1-system1";
+				reg = <0x0 0x0>;
+			};
+		};
+	};
+};
+
+&fiu3 {
+	pinctrl-0 = <&spi3_pins>, <&spi3quad_pins>;
+	status = "okay";
+	spi-nor@0 {
+		compatible = "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-rx-bus-width = <1>;
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+		partitions@A0000000 {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			system1@0 {
+				label = "spi3-system1";
+				reg = <0x0 0x0>;
+			};
+		};
+	};
+};
+
+&fiux {
+	spix-mode;
+};
+
+&sdhci {
+	status = "okay";
+};
+
+&udc0 {
+	status = "okay";
+};
+
+&udc1 {
+	status = "okay";
+};
+
+&udc2 {
+	status = "okay";
+};
+
+&udc3 {
+	status = "okay";
+};
+
+&udc4 {
+	status = "okay";
+};
+
+&udc5 {
+	status = "okay";
+};
+
+&udc6 {
+	status = "okay";
+};
+
+&udc7 {
+	status = "okay";
+};
+
+&mc {
+	status = "okay";
+};
+
+&peci {
+	status = "okay";
+};
+
+&rng {
+	status = "okay";
+};
+
+&adc {
+	#io-channel-cells = <1>;
+	status = "okay";
+};
+
 &watchdog1 {
 	status = "okay";
 };
+
+&pwm_fan {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins &pwm1_pins
+		&pwm2_pins &pwm3_pins
+		&pwm4_pins &pwm5_pins
+		&pwm6_pins &pwm7_pins
+		&fanin0_pins &fanin1_pins
+		&fanin2_pins &fanin3_pins
+		&fanin4_pins &fanin5_pins
+		&fanin6_pins &fanin7_pins>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	fan@0 {
+		reg = <0x00>;
+		fan-tach-ch = /bits/ 8 <0x00 0x01>;
+		cooling-levels = <127 255>;
+	};
+	fan@1 {
+		reg = <0x01>;
+		fan-tach-ch = /bits/ 8 <0x02 0x03>;
+		cooling-levels = /bits/ 8 <127 255>;
+	};
+	fan@2 {
+		reg = <0x02>;
+		fan-tach-ch = /bits/ 8 <0x04 0x05>;
+		cooling-levels = /bits/ 8 <127 255>;
+	};
+	fan@3 {
+		reg = <0x03>;
+		fan-tach-ch = /bits/ 8 <0x06 0x07>;
+		cooling-levels = /bits/ 8 <127 255>;
+	};
+	fan@4 {
+		reg = <0x04>;
+		fan-tach-ch = /bits/ 8 <0x08 0x09>;
+		cooling-levels = /bits/ 8 <127 255>;
+	};
+	fan@5 {
+		reg = <0x05>;
+		fan-tach-ch = /bits/ 8 <0x0A 0x0B>;
+		cooling-levels = /bits/ 8 <127 255>;
+	};
+	fan@6 {
+		reg = <0x06>;
+		fan-tach-ch = /bits/ 8 <0x0C 0x0D>;
+		cooling-levels = /bits/ 8 <127 255>;
+	};
+	fan@7 {
+		reg = <0x07>;
+		fan-tach-ch = /bits/ 8 <0x0E 0x0F>;
+		cooling-levels = /bits/ 8 <127 255>;
+	};
+};
+
+&pspi {
+	cs-gpios = <&gpio0 20 GPIO_ACTIVE_LOW>;
+	status = "okay";
+	Flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <1000000>;
+		partition@0 {
+			label = "spi1_spare0";
+			reg = <0x0 0x0>;
+		};
+	};
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	eeprom@50 {
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	tmp100@48 {
+		compatible = "tmp100";
+		reg = <0x48>;
+		status = "okay";
+	};
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&i2c13 {
+	status = "okay";
+};
+
+&i2c14 {
+	status = "okay";
+};
+
+&i2c15 {
+	status = "okay";
+};
+
+&i2c16 {
+	status = "okay";
+};
+
+&i2c17 {
+	status = "okay";
+};
+
+&i2c18 {
+	status = "okay";
+};
+
+&i2c19 {
+	status = "okay";
+};
+
+&i2c20 {
+	status = "okay";
+};
+
+&i2c21 {
+	status = "okay";
+};
+
+&i2c22 {
+	status = "okay";
+};
+
+&i2c23 {
+	status = "okay";
+};
+
+&i2c24 {
+	status = "okay";
+};
+
+&i2c25 {
+	status = "okay";
+};
+
+&i2c26 {
+	status = "okay";
+};
-- 
2.34.1


