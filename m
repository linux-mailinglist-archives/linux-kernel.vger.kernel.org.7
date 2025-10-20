Return-Path: <linux-kernel+bounces-860923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C60ABF155B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171723AF1F8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B712313523;
	Mon, 20 Oct 2025 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="BzWkl6yj"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023114.outbound.protection.outlook.com [52.101.83.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ABD31280D;
	Mon, 20 Oct 2025 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964580; cv=fail; b=RgTCBnK0QIJ62N5AKgtX+RFM8G6PeWRymKdXiLBVzb34mZzoe7PuOGYYrUCqISMb1cc83LsuWXObqPMxHOs5wOQeRuqZYgHce1GJ17JezAZDvXK6EBijv2vyev2apP48aNjnVw4P7dlqO6XD6wj0J0sgki6tXLlZIOzQcPW09mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964580; c=relaxed/simple;
	bh=KnKnCqHMhWG2tJ8fbrB/o4G/3abVLsFpHr3VwPqoSow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eMqUbCK7LGH7om+utxYriG53BXPqoJQNgDB9E/oUNJAJlPPLRJtEjoxTMd7eajFVMRWaZ/hwG+5rTDQHuorl8DlrtOsrabrFv81CN6Wz9/0sBWZICM8sZkh2xI4pRsJ2MHU7vq7BLGfE6gboPCmOCAFRgZFoaJAxO+xlWtAjMcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=BzWkl6yj; arc=fail smtp.client-ip=52.101.83.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVDldNHZ4PeovP7yQZjzR/dX/B/IOaBAiwJ7FieGqn8KMMO0I891aVJFuZahldtYSA4U3T7HtouGvW3Xrre2POD0E3mdjBamjEhbjBqkPgLPZf9hckkClEdBexpxOgNSDrgK18/+g7digZXAPuUD/IQTPJbb5cdNuXdSohok8psRvrn33IGujjZ4v+9113FCtNWVCjmU4juaZmFjk2aBEhfGoWjxl7ysQj4uNApbi5P6e94WoPBtY//jpMbj7KJ8xfDICG+y728ArVPOag9+56Qu55ck0MmmEYU7sCAP/MYCMNeLdSWhpKjTO6JKmiKOtqAv7yevt8bsvoifaxZ3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PKRwI0QceB/vpy3o/tGTKLhrMXyHH1Mgbmhw6y4Bws=;
 b=UDBKclpMCIOR3IctnYPgzbsreFp3Fh4SVlQt3MND+IMF2rBKd77LNsLfEcSP9ePdiJAIgSF6ZIMpodj/bVHaAi3shvHNRmLThzlJzgj4ja+6kz8b8CBfRmotpLwN08SK8kHij3ijqJeoykkjk/ffuMJ+nuEEt06ck5ciBsz6X0QMXWgU84WoiqFBNV7VxRDHE6BFYAoqbSh2B2/vLNk2/TdwElbHiwZdMlu05a9imOXLXaH+CvfA4phiYQfL/oqw7m4bMDWBztN5PySW7KwTmOT3oaaXDiP1RzhAz6Ccy3NCEkODOu4BzcxASX9E9efaps2jENzN41Fq9RQdwKgavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PKRwI0QceB/vpy3o/tGTKLhrMXyHH1Mgbmhw6y4Bws=;
 b=BzWkl6yjnVY/wxR1/+/Fx853IEqRkNp8f8yJpmJuoEs0qXsc7O/nnP/aL3La/FUXZSzMfhv4ljWjQjoi7S/677K+a/UaOegX4rsI11/mZ26vzPSCm8degPNiGyjK7+tbcEEG3ScFW8IIBZydk+ogsM9y23+5WNgngwmsd4uxVIxNVf9LkKgnJLFxif5slcc6Du1z0DspuILRqnYcgRL20IerWitF65XBMTnhlM1KASv9SOAMQKlo3WKq3yslda693fgiu4WjzsDSByXvol2VICdlqs74/w7WlIKBfwVDlx/0UOdUNuc4ab1RLMIjZy7XXr/HpFWqUnf8xpWxLvDBJg==
Received: from AM6P195CA0030.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::43)
 by GV4P195MB2745.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:28e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 12:49:30 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:209:81:cafe::fe) by AM6P195CA0030.outlook.office365.com
 (2603:10a6:209:81::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 12:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 12:49:30 +0000
Received: from [127.0.1.1] (172.25.39.168) by Postix.phytec.de (172.25.0.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 20 Oct
 2025 14:49:29 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Mon, 20 Oct 2025 14:49:26 +0200
Subject: [PATCH v6 3/4] arm64: dts: imx8mp pollux: add expansion board
 overlay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251020-imx8mp-pollux-display-overlays-v6-3-c65ceac56c53@phytec.de>
References: <20251020-imx8mp-pollux-display-overlays-v6-0-c65ceac56c53@phytec.de>
In-Reply-To: <20251020-imx8mp-pollux-display-overlays-v6-0-c65ceac56c53@phytec.de>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Peng Fan <peng.fan@nxp.com>, Yannic Moog
	<y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DA:EE_|GV4P195MB2745:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b8e067d-3144-4cd1-589a-08de0fd71c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDUxcmMrNU1FcUR1MGhheXVBRVZCbDd3ZDcxQzVaWmJjRXlXYnIrZ1dWOUgr?=
 =?utf-8?B?eW55T3o4cjV4SG9Nc3NGUXJiSm9Rb01yTnBkSlZnVHBqTFFXM0JYVXpOWTN5?=
 =?utf-8?B?WXUvdUdtaVc4UHo0MVlzbTh0WWF5Z3ZVell5N1FwcFZDU2NuckhUTVdBYlBQ?=
 =?utf-8?B?YldnbmxIakR0MTM4UngwVy9ZRk1MbUJjU3YyODVtSnlCYkFxakhoZXVMTUt3?=
 =?utf-8?B?c2Z2VFd5ZVZmMzVZSGEzWlJnYzducTRPVEQvVDhVNVdSOGtPOE5pMExyeUMr?=
 =?utf-8?B?MW81VnRWdGpBWXRhVXkyMFVQdWlhSHpsNmlpekExbTdZWTZGU3BMbzc5UlJo?=
 =?utf-8?B?V1BtSFFKWU9VSU1VYUkwMWJ5L2JZTXY4aFRYSmhMQVZ5Nkl6bkNpK0pzN055?=
 =?utf-8?B?TUdXQllqa2Q1ajRtcWhCeXBSRGZNNU9wY011VXowSXBwSVVFRTVzNWl5aDlB?=
 =?utf-8?B?MHpiMm1nSzNjVHlydHBMS3p3cnpnQm5CeGJxYzMyWHpHNklDeEt6anR2ZVBs?=
 =?utf-8?B?SUJKWXppRCtESy9PZjV5M1F2bWVaSjdZMzFJUkFvbnIrZVE4YTJsWThaRTM4?=
 =?utf-8?B?dCs2T0s3OWJ2eWtEWjRnVlIzbFU5RU52MnNCa1VKaUc3U2t0cUltblhDMEhU?=
 =?utf-8?B?ekpDT2xXYUxZZndyRExycmRJT2RjVUVNRE9yaGJycnBjMDdVN1RGY013dm9H?=
 =?utf-8?B?VTBBR0VrWjJNVG1FYVpZQ1paWXF6b2lTVXkwOWhFblloQ2lYSEZUOEFHbGhM?=
 =?utf-8?B?Nnlsb2kxbzhtOS9PbW82akROanBFb2NZazJqbU5hT29vcDkyQ0d0c1cwSU5T?=
 =?utf-8?B?NEtkSHZyeG9uOGkyYmlPUW1Ld2VlY0dmeG94S1IzTnVFcnVKMVFqNG5sajFG?=
 =?utf-8?B?bW8yYUNJVGFGeWR0ZWVpRGJkM0x5OXVLeklnQ1k0UGtyMmp5M3UzWEtnM1Z6?=
 =?utf-8?B?NFJrT0R3UnVqb1VLR2xkQzVmbTRxVUtacUVlN3hmdDRuZkdPNHowTXNCTzN4?=
 =?utf-8?B?eVp1RDlCM3J0MGlieUkzTS9oRUN1SzhUY3lTekJBWm15aW9kZU02VDJmNmVR?=
 =?utf-8?B?ZlFHUnN3bE84Y0V6dmhJN0dtSlZNeHE1U21VQUpRRW9kZVR2STR1UnhETDhZ?=
 =?utf-8?B?bk12SjFjYjFTWkxKWHZpQi8vbVlYcnhZUFU3aGVVUklRMzNuckp4eXBRM20v?=
 =?utf-8?B?TTBsSElnN2pFejlhRXA3a2p5VjlHaWtoTDBLUnIxbDVhRWlHc1R3d3lYTlRp?=
 =?utf-8?B?SzJtQTZNRU5qQ21mbmp6MzhiaVV3UGw4WitBcU5xVDRSbWFVbVNIVGk0aExV?=
 =?utf-8?B?N0RsMysybG1XcUN1bjdDcm9FZmNwZ1o3RGp0TUE2TGF2TEVWQjYzbW9Reitp?=
 =?utf-8?B?QnVGYWhsR2Q2RFRrT3NzZXZ1U1pvckw4QjVCMFd0U1dUQXJROCs0eXcvbndY?=
 =?utf-8?B?VS8xN1AvbXFJcm5CK0JyWXVNeXVCOGFWN004U2Yra2V0U2xFTFJsZTRqSmdM?=
 =?utf-8?B?MktXdVJoczF5MzlsOVgrTmduZGlLQm1qcVNnWHFqSnp1OURhT0JUSG1RQ1ZZ?=
 =?utf-8?B?c0VXMjNMaWVWajBaOG4wQkN0NzZGNGw5UG1NZENTcUswNGhQSDlVc2IvdCtP?=
 =?utf-8?B?TkYrc093TWQ3blRONmZNTURkeXY4RmNpZ2xGOUhIV1Z1Qkk0UmxqdHA3TWtQ?=
 =?utf-8?B?cUZkUEJ5VENlVzlCdStaYkdCSnJYdDZESko5Y3ZPWEVCSTQ1T1dJNFBMNHVj?=
 =?utf-8?B?WDJobDZwMVo4QVFBbk8yK01qdEorNE1UVzZ3TTFpVjF2ci9CZ0RRV1lENU1a?=
 =?utf-8?B?VmEweTQwMzZxSkNKN1ZxVVpRM1pUWUdnSFhCb0FNM0ZNK0RQZlV2M3c4UnFY?=
 =?utf-8?B?UElLakhEd2tIdFVPQjdpbFk2TE9hYURZSnRVMEJuTHNBNjYrR1dtb21ybHRt?=
 =?utf-8?B?WEZoTEV0aVJjYVFQUzlZYkphQmJmRVZmcmNmbTVBcFcrVmZhRmY4TG1qL29B?=
 =?utf-8?B?dnMzLzlQNjBLZ0dSbU5Gek4rZk5oUjFTdFYxTlRkS1VvaVl2MWU0Q3ZML1ov?=
 =?utf-8?B?TkI0MHpEekR3REJ0djU5Uyszc0VTK3Z4Y1EySHlYcGJjTWVQUGNYVmkveFBz?=
 =?utf-8?Q?mCvY=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:49:30.3826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8e067d-3144-4cd1-589a-08de0fd71c88
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4P195MB2745

An expansion board (PEB-AV-10) may be connected to the
imx8mp-phyboard-pollux. Its main purpose is to provide multimedia
interfaces, featuring a 3.5mm headphone jack, a USB-A port and LVDS as
well as backlight connectors.
Introduce the expansion board as dtsi, as it may be used standalone as
an expansion board, as well as in combination with display panels. These
display panels will include the dtsi.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 .../imx8mp-phyboard-pollux-peb-av-10.dtsi          | 198 +++++++++++++++++++++
 .../imx8mp-phyboard-pollux-peb-av-10.dtso          |   9 +
 3 files changed, 210 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 805ab9e5942bc9e2b9776e92412f56e969b6b39a..9c121041128972d2239e2cc74df98b0bf7de1ac2 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -220,10 +220,13 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-nitrogen-smarc-universal-board.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
 imx8mp-phyboard-pollux-etml1010g3dra-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
 	imx8mp-phyboard-pollux-etml1010g3dra.dtbo
+imx8mp-phyboard-pollux-peb-av-10-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
+	imx8mp-phyboard-pollux-peb-av-10.dtbo
 imx8mp-phyboard-pollux-ph128800t006-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
 	imx8mp-phyboard-pollux-ph128800t006.dtbo
 imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-etml1010g3dra.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-ph128800t006.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-basic.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..bb740f845855ac06307de2c3835ebb5a03d40fa2
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+#include <dt-bindings/clock/imx8mp-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "imx8mp-pinfunc.h"
+
+&{/} {
+	backlight_lvds0: backlight0 {
+		compatible = "pwm-backlight";
+		pinctrl-0 = <&pinctrl_lvds0>;
+		pinctrl-names = "default";
+		power-supply = <&reg_vcc_12v>;
+		status = "disabled";
+	};
+
+	panel_lvds0: panel-lvds0 {
+		backlight = <&backlight_lvds0>;
+		power-supply = <&reg_vcc_3v3_sw>;
+		status = "disabled";
+
+		port {
+			panel0_in: endpoint {
+				remote-endpoint = <&ldb_lvds_ch0>;
+			};
+		};
+	};
+
+	reg_vcc_12v: regulator-12v {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <12000000>;
+		regulator-min-microvolt = <12000000>;
+		regulator-name = "VCC_12V";
+	};
+
+	reg_vcc_1v8_audio: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "VCC_1V8_Audio";
+	};
+
+	reg_vcc_3v3_analog: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "VCC_3V3_Analog";
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "snd-peb-av-10";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,frame-master = <&dailink_master>;
+		simple-audio-card,mclk-fs = <32>;
+		simple-audio-card,widgets =
+			"Line", "Line In",
+			"Speaker", "Speaker",
+			"Microphone", "Microphone Jack",
+			"Headphone", "Headphone Jack";
+		simple-audio-card,routing =
+			"Speaker", "SPOP",
+			"Speaker", "SPOM",
+			"Headphone Jack", "HPLOUT",
+			"Headphone Jack", "HPROUT",
+			"LINE1L", "Line In",
+			"LINE1R", "Line In",
+			"MIC3R", "Microphone Jack",
+			"Microphone Jack", "Mic Bias";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+		};
+
+		dailink_master: simple-audio-card,codec {
+			sound-dai = <&codec>;
+			clocks = <&clk IMX8MP_CLK_SAI2>;
+		};
+	};
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4_gpio>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	codec: codec@18 {
+		compatible = "ti,tlv320aic3007";
+		reg = <0x18>;
+		pinctrl-0 = <&pinctrl_tlv320>;
+		pinctrl-names = "default";
+		#sound-dai-cells = <0>;
+		reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
+		ai3x-gpio-func = <0xd 0x0>;
+		ai3x-micbias-vg = <2>;
+		AVDD-supply = <&reg_vcc_3v3_analog>;
+		DRVDD-supply = <&reg_vcc_3v3_analog>;
+		DVDD-supply = <&reg_vcc_1v8_audio>;
+		IOVDD-supply = <&reg_vcc_3v3_sw>;
+	};
+
+	eeprom@57 {
+		compatible = "atmel,24c32";
+		reg = <0x57>;
+		pagesize = <32>;
+		vcc-supply = <&reg_vcc_3v3_sw>;
+	};
+};
+
+&ldb_lvds_ch0 {
+	remote-endpoint = <&panel0_in>;
+};
+
+&pwm4 {
+	pinctrl-0 = <&pinctrl_pwm4>;
+	pinctrl-names = "default";
+};
+
+&sai2 {
+	pinctrl-0 = <&pinctrl_sai2>;
+	pinctrl-names = "default";
+	assigned-clocks = <&clk IMX8MP_CLK_SAI2>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <12288000>;
+	clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI2_IPG>,
+		 <&clk IMX8MP_CLK_DUMMY>,
+		 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI2_MCLK1>,
+		 <&clk IMX8MP_CLK_DUMMY>,
+		 <&clk IMX8MP_CLK_DUMMY>,
+		 <&clk IMX8MP_AUDIO_PLL1_OUT>,
+		 <&clk IMX8MP_AUDIO_PLL2_OUT>;
+	clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3", "pll8k",
+		      "pll11k";
+	#sound-dai-cells = <0>;
+	fsl,sai-mclk-direction-output;
+	fsl,sai-synchronous-rx;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL		0x400001c2
+			MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA		0x400001c2
+		>;
+	};
+
+	pinctrl_i2c4_gpio: i2c4gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C4_SCL__GPIO5_IO20	0x1e2
+			MX8MP_IOMUXC_I2C4_SDA__GPIO5_IO21	0x1e2
+		>;
+	};
+
+	pinctrl_lvds0: lvds0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_TXD__GPIO5_IO01	0x12
+		>;
+	};
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_MCLK__PWM4_OUT	0x12
+		>;
+	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_MCLK__AUDIOMIX_SAI2_MCLK	0xd6
+			MX8MP_IOMUXC_SAI2_RXFS__AUDIOMIX_SAI2_RX_SYNC	0xd6
+			MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK	0xd6
+			MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00	0xd6
+			MX8MP_IOMUXC_SAI2_RXD0__AUDIOMIX_SAI2_RX_DATA00 0xd6
+		>;
+	};
+
+	pinctrl_tlv320: tlv320grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28	0x16
+			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22	0x16
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..95078618ee095af5c8b09f62945c125e69990baf
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtso
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include "imx8mp-phyboard-pollux-peb-av-10.dtsi"

-- 
2.51.0


