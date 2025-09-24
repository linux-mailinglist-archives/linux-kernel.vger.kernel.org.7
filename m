Return-Path: <linux-kernel+bounces-830457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA024B99B57
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A948E3256E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4D0301016;
	Wed, 24 Sep 2025 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="mPDzk83F"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023096.outbound.protection.outlook.com [52.101.83.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4A12E7BA5;
	Wed, 24 Sep 2025 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715164; cv=fail; b=h/gtt7d6xidJ+LldzCICSZmvlkoGgDrz03SOea+s167qgY8DtVpL1+JUjkJq72xx8gaiAykwW+vuz90M+APeFP2+8S8mJXG1p7T7G6Ji4U2e0C21bOej2BGF/FR5s+utiz5mdQtpG/ZgLR7rp8hRgP4hK7unb0OG7ObrQ+QPXpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715164; c=relaxed/simple;
	bh=pgBYqIKD4efDwzO6Hl+jAtchVzPbd0hWYzUEF2lu1D8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Wf+EmGoE6vKXrvjQjZ3fNdX0HKjG1gnHMP9V8Uj3bvqoZwHtT8PAf+EyC99LPgy1PkBmc8DLzSXEte5onQSFhCpCHk9Ak2F06KtgSe+CQDQTxSMZ/YIM0IRHuqU6j1boAgcqdDD1EcOd1+XvqwR5UFFN9rCALD4Rxo9dh3j1s58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=mPDzk83F; arc=fail smtp.client-ip=52.101.83.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGZubi/+4rtWcjIqbFOpkB9ynU0+68FO4R7PdMeHy1/gf92LEHUjEeRFbn122p26IZark+tkeq+RwECNJevM8QzBbCdo0hmQ2lA56BBJTtQlgi0LMxXR0ozT0zvtjhXZoE6ERFr8t83SHbuBBWcQTqdN9jpk2Is3F0qRvH0/rlKyeWXchNatSh9Omdz5hDApKrf0ntzVVPTPDylNzTnypls9yuNQTun6zNZqycaiINbHuqedURC82uSmd8QozDjuRC4e//+M3SiOUP8eYHX6eanY/dENJm9MKHgm5ZlDcQb0zvdjbW3fmPSYXW4Ub1IzgS7E63FAHtTJlSiLWt4tOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqRirEjJ9lqkj4loTYKO4WuTlP2YmO8/8J1iEIONCMU=;
 b=zQZyCL5RuNh5VliNy4zF1G3geSgcG7cdDhDp2pSuW1SU8GckejIeVivweet/0X1KxBWHYNe91+4YRvNBauikgiA3NYY61TO6rxe+IVjwEMCkJnOcMVeirWOC/s7m9GvETqGEuaTqWrmYWseqewAoUO5TTPBj6zRxy6tCSLQBB8dojGlAZ5DIPqSHQHBV7jdN16TF6kbYLBD7GpsPltWcId8GkYxAL4visecUcr1GwnEy+dAyv4rnt0qx434hfglkygvBUhpWDh1NkT0rKbFusvsMroyxbii7sg+jFKkBSEEc9P/UHuvwXG0tX+hMbCObuF3RKj5cFCcIkgEpVBLOzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqRirEjJ9lqkj4loTYKO4WuTlP2YmO8/8J1iEIONCMU=;
 b=mPDzk83FZ8/aaonNi2UbqQleJV/IgCg08Ysple1Jid9i/ye12SERuO88bhzQoDOSYBiT8MJqCv8sTjvdub6nZHYrTGX2e1w5cnnvOmwaFEtSh5Zctnb/GEhBDKLQMzjJXjwtijFNTa3nqnZWUkQxzkfmPANulL37s4OzPWuOwi1vmIlFIi14V78XJuur/8qb7ji2lhxTdiLSwKIgoSLsw1hz5mG4UgvvL//NmUDUji/pM1dT2HkAsI91tHcO39fGsrxLv7LYsh/ValMARLBHalMyAFgZ4u08XKuecaLgxOHbcG1HM/9yk1X0PH6O2kazu52IupVVo7cFImPEA2mi+w==
Received: from DB7PR03CA0091.eurprd03.prod.outlook.com (2603:10a6:10:72::32)
 by AS8P195MB1223.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 11:59:11 +0000
Received: from DB1PEPF000509EB.eurprd03.prod.outlook.com
 (2603:10a6:10:72:cafe::ec) by DB7PR03CA0091.outlook.office365.com
 (2603:10a6:10:72::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Wed,
 24 Sep 2025 11:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509EB.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 11:59:11 +0000
Received: from [127.0.1.1] (172.25.39.168) by Postix.phytec.de (172.25.0.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 13:59:10 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 24 Sep 2025 13:59:05 +0200
Subject: [PATCH v2 2/3] arm64: dts: imx8mp pollux: add expansion board
 overlay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250924-imx8mp-pollux-display-overlays-v2-2-600f06b518b9@phytec.de>
References: <20250924-imx8mp-pollux-display-overlays-v2-0-600f06b518b9@phytec.de>
In-Reply-To: <20250924-imx8mp-pollux-display-overlays-v2-0-600f06b518b9@phytec.de>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EB:EE_|AS8P195MB1223:EE_
X-MS-Office365-Filtering-Correlation-Id: 275a22c7-5e16-4847-3985-08ddfb61c65c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3NpTmV6YXNhQjZmWkdZZDdjNVJ1Witua3Y0MGxQZHBCOFR2UDFiZ1RJUFQ3?=
 =?utf-8?B?WjBwKzJEd1VrY1JJYTExdWZnd3FtVnA1ZXJ2UTlQQ01pS3hncTRxb3lPeDZn?=
 =?utf-8?B?Lzl6ekxiVnJSeXBNeTNCcFRmMzllWkIvRXNFUk91TnU0U3M0bVlaaW16b0Fw?=
 =?utf-8?B?TDhQQzZLaEV1VHorY0dzdmtuUWd0OURiNmNTeFlMMnNKNjNwL1FJaW5HdUcw?=
 =?utf-8?B?ZjlIeXE4ZU5ORG15UW1uRzJwZHlHaW9rSGxOWFRidm8za0laa215d0llVTY0?=
 =?utf-8?B?aEFDd3ZYUVQ4eUZMYmp6cVVXUk40M3JWdHVBVGRFRTFKWXE4VFFWYnBWKy9a?=
 =?utf-8?B?OXNVWXlqOWlsaDMrbE1KeXA0OVprdTNia0ZpaHFaZ2w1V1lRUmVYNGVlbkRJ?=
 =?utf-8?B?bjMwUkhFcitLRDZGUDlrTDhKU1dHQVVMZS95QW9TbWczRlJGWUVZcXJZZmoy?=
 =?utf-8?B?cmVGNmlGK3U1L1dhakVhNUtGSG9pNnpTbU90SnJ6RXlyUmRsSlFvclJnL1Nk?=
 =?utf-8?B?a3BXNEZTZ1JVWXE0WTYvckFXWVlXZDhTdVk0L3NmZTdJVER4UkFWRUs4Uy9R?=
 =?utf-8?B?ZXNnNXlacGxBTVFZWktDWjNTbHhxTFJmMytGMzdJL2NFOFNlWGtVdjJiV2lw?=
 =?utf-8?B?bmk4QWtmZU04TG1DQ3d2K0ppL21lUnhGbE00NEl0cFM0bkJTcWRManBHWXNi?=
 =?utf-8?B?WkVWdUdMTVNEdTF3b3NEOWN1VndCbFNmM1ZPMFBFQWQzNnZMdUxsdnQ4RjBX?=
 =?utf-8?B?N0lURDJzU3E2M3lNVHlKanI5dlQ0YU0zTmVSSTQ1WEpIZTl2KzJYRjd4S0Jl?=
 =?utf-8?B?NjJIL1YzMFdhOUpLY0o2VE1SOGlOMVErUzg2b3UrbWtnUWo0NTQxTjdGanAw?=
 =?utf-8?B?QlUvUjVJSkYrOWwyOUh1cUxSRi82T0RPVDhUaEdJNXVzMFRDR2VNNUV0c2Zk?=
 =?utf-8?B?WXRXakpFdUlmUHFDelQrWFp0WnJiMXhBdWlxQUdKcEQrbTRtc1gyQkJqekZm?=
 =?utf-8?B?QlhTY0Z5dTZtYU5zdGdRRWFEQlg2d3RTT01LcWljKytrQnlxSG1yYWpRN3VS?=
 =?utf-8?B?NE84cTFxVGRpb0gxT0ZjSFJjWTRJclRLVzRBZ1EwOW1TWGQ5cWpLS1dxaXNn?=
 =?utf-8?B?U05VQjV6WXVoV0o1aDdiTEdrRnlRdzVFSGRUeFVSRTV5M0JRNFhrYStWWHhm?=
 =?utf-8?B?U1NET0hWUzJjNVZrTkFPS0pTT0tCbVJ4UTVoUHpoaFQ5b3JWOWlxbGJWWTlC?=
 =?utf-8?B?TVl3MkpScWRvbjVyZ25EUUZKTTZ4ZmFSeGlxSU5Da1pZdkQwTk5Cb3BGLzdT?=
 =?utf-8?B?MXN0WFMycmMxSTNyNXZXYnJNNjR6MHVaS2ZNV0xCcWZKSkJ6cExXeE4reU05?=
 =?utf-8?B?b0hwcEF3cVpLYVNTcnNTMEo0eitMRFRodGIrYmhJUWd4d0tOV25iNFpTbFFr?=
 =?utf-8?B?QXFqZGNIM1lQSmExUUZaWll5c1BDTUdZMjgxUGFzUlE4Y3EwL0N0ZVNFcVlr?=
 =?utf-8?B?NzJBTlYrU05XZ1hYVXBxNlJ4bWVEaW1jYVVnY3VLREN6Ky8xcE1NMkVReVkx?=
 =?utf-8?B?R2VQS0l0M3F0T3ZDWkJwN21SNm5kV0dXTU0xVlhBbSswcm0zcGhLc1pMdm52?=
 =?utf-8?B?UHpaak1JK0JYbzBzcytwS01lbUdVRTZlRG82K3NMdjN2RHpaTUxQL3FXcW9s?=
 =?utf-8?B?eUZ0cGRtalc0Nys3a1RNbDNxL244Z20vRkNDOHR5TXZXWXh0ejV1dUVNaGkv?=
 =?utf-8?B?WlZtaVhFOHhQTE5ETjBwRkxyRUFXNW1QMEVUT3ZhNTg3dGlWeHc0TlkzaTVJ?=
 =?utf-8?B?NytjVms3bm9ONFErcE1CcnV0ajRXV3QxM1NVWVdTRXRuTHVUM2krRzVZUFlI?=
 =?utf-8?B?ZHp0eEd3Myt1YlNRWEVTVlE1RmFPMzFXNmhqbXdQYUczVDhqL2gvN25seG9k?=
 =?utf-8?B?SXpDb0pNa05vTkk1ck9BbCtyV1BXZVhuZjhqQUJnRnVkb0VGdVl4eWxZUjlZ?=
 =?utf-8?B?cjZwZU1nWkNOUlV0TGtWc3ExMUdRb3VVcENnY2F1NWhxMVd2d1FRZ25iNXZG?=
 =?utf-8?Q?FviRHh?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 11:59:11.4043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 275a22c7-5e16-4847-3985-08ddfb61c65c
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1223

An expansion board (PEB-AV-10) may be connected to the
imx8mp-phyboard-pollux. Its main purpose is to provide multimedia
interfaces, featuring a 3.5mm headphone jack, a USB-A port and LVDS as
well as backlight connectors.

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
index 0000000000000000000000000000000000000000..4653af62b582ead04aed2cffde11ef0b142be343
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
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
index 0000000000000000000000000000000000000000..52020c9361cc8fc84823fcae93aa3651332b91d2
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtso
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
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


