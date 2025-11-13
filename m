Return-Path: <linux-kernel+bounces-898845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AC0C5623F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B0E7D346BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2331B330B26;
	Thu, 13 Nov 2025 07:59:45 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022123.outbound.protection.outlook.com [52.101.126.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6EA322C67;
	Thu, 13 Nov 2025 07:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763020784; cv=fail; b=LnbNhulMV/tGgy4ahyfviNHoHDfiotqZXiydCwLvGd3ZnxP6jRQ9kRr/7i5KiBpwqDxG5gUiwXDMQecS1033aLvTxcuvkNQZElYGcexPtK46JcuiXTmavTvJfAThRc2IJfHNQ4S8pjOOhccRZSomKmwgKvEMI7aNwy8fLBSfmnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763020784; c=relaxed/simple;
	bh=zIprVD0VPxLxOodtV8oTXKFQDzYaymQuwL67hZHfzng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b77I3HAi2Ajtgd0slwR5e+Ll/Kqj1EToCAeHaO1YOaMm4D2MC3Mc5a8lYOiaYv1+VDJ/bmvhQEulMHzZnob0fOey/Zase8w/RWn2HwTcvkQw4MRjzOC3DsnZ4E8Dx30GHqYVjbaWoDAKzm5TXHuxxWU2dAbOe5r+Q07UBWSIJJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnP6SZQQNZ3vfCMZ6H4cm5qCpGl8SXVybcNQCWD0PXIsABSmrhqWrOmftQVuy0mwuRBGtruXmrCeJNeaIHRr1r9wXMS5MFwpsg8ju/nLZI0Z1eQ27Ldu18cAJS7A0TNkUp16lFdBg38BS+H+s2HsoS81X4x6XooZKNh7fxqQU1Gc8xo51dy89bdCozYzJ8Jyouk4RYRU/qPFy8q9TqthX8x03cViYzbJT8x8Sy2aE2vIr1A9p+AuC0i9vDxvP5iiStVHthK9PsU3CKgkMuDZVXGLLywa1xa4uHPExtHCpba6X7fu8mAbgFl//0j5x8kMIf+/5mMcDjrFMKQnmHdnsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIeEKVDhghw7d0BpT76q+ggnJLdQV1omJEjV+n/umSs=;
 b=ohzvTpech1lFxQAmaL4PkkJzNFh9uwqN5K2GGv9GbWlAdFW3DYW+5E2ys4edNvxa3mYsrw5zDgJBZH4aIjP+c6aJtLdxcFcoOVy0ZSL4Q0gOOURgCc4DfzYp/5EIu4sCxj5ABzHPvhtAMmbnIP+xbljqwHM6YqqvFB0ayiT+c3xTpgGa3uvG7rhst9YMlE0PbLQjHrNPvBeehaZ/VqSidwS4RU3Z7/H5kdGZ2NRkqLOxWoTm9J1ojTSMhTihcaDvKLDIgZPPjBV6xS/P1ul5ETTXPkk5fx5cu8eygmpFAyaNZbWbqXkj+UTlOuxRUFEtuSr550nrJ4rdQ7EjLUra5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SEWP216CA0126.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2b9::8)
 by TYZPR06MB5905.apcprd06.prod.outlook.com (2603:1096:400:337::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 07:59:37 +0000
Received: from OSA0EPF000000CA.apcprd02.prod.outlook.com
 (2603:1096:101:2b9:cafe::f6) by SEWP216CA0126.outlook.office365.com
 (2603:1096:101:2b9::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 07:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CA.mail.protection.outlook.com (10.167.240.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 07:59:36 +0000
Received: from localhost.localdomain (unknown [172.16.64.196])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9E77E41C017B;
	Thu, 13 Nov 2025 15:59:35 +0800 (CST)
From: Gary Yang <gary.yang@cixtech.com>
To: p.zabel@pengutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	cix-kernel-upstream@cixtech.com,
	Gary Yang <gary.yang@cixtech.com>
Subject: [PATCH v2 1/3] dt-bindings: reset: add sky1 reset controller
Date: Thu, 13 Nov 2025 15:59:33 +0800
Message-ID: <20251113075935.774359-2-gary.yang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251113075935.774359-1-gary.yang@cixtech.com>
References: <20251113075935.774359-1-gary.yang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CA:EE_|TYZPR06MB5905:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aeab52d2-9435-4935-d476-08de228a970e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QyBuXLvbVpyR2A970pzRMfC7wozPLJHPi7ooTCBzlWuFvUWAmhw/F/ZbT2lY?=
 =?us-ascii?Q?A2nWuasqAjssm4irMfEWqzRyk40Gfix5vQEOgvQ+L6pWl1Ja9rEFraxRPswb?=
 =?us-ascii?Q?gNd57XhoNuKe4y3UVlHXtLL1zwQ6/MSUqV+03gmUxiXPQyyYvGNPa8BL7xlz?=
 =?us-ascii?Q?oKTQ5Rh9IZzKgJ4pGVq7kKlCC1LayjvmIQMMpUus0VhBMa4TSKzZflXx+qlJ?=
 =?us-ascii?Q?B7oizzpRxaQQhL4G3PLFE/8+sJLk3rHPcNmkeA51YBRnKEneIBHXuWERy193?=
 =?us-ascii?Q?9SqrhtPxBsVyl26YL/iY3vQy++sqI0neNaCTg2FQDu5WJ2k2CdDKDKU9YL0x?=
 =?us-ascii?Q?wVQzgLUyy8VaFy9rAK4M+EkP1jWeWLh09Kr8DsASFGRquogqUypgrvVM3SBf?=
 =?us-ascii?Q?7viLKEEirpJ6F01B9/Ldog8kq+hnQgkLflBLGctfJkhSHzLSH8mInsFCp11x?=
 =?us-ascii?Q?K9wyARZVjmSf9zrizj5eP1pV2CGjtjQ7bKpEOyiRJcoFl65k0lgjQN4nKM0r?=
 =?us-ascii?Q?tO2tvhBkwouY9QwBKJzynD7BMf2vmxpXG4TCV6jCQZf9hfq92zhBstzUYejp?=
 =?us-ascii?Q?1XJI8dM3qso3nsTKyO8KcmgZYMYtQA5mNocAiLQfVQUyJqG1KJmprnYDe1jb?=
 =?us-ascii?Q?HdjVF/TOvdQ/aPYqMSIVR8Ocaikdbar04JW6XCbgHab/FhwRPV0nIm6zp2fO?=
 =?us-ascii?Q?Y3qCqvJc4p1UvE/MTLLDr6oZQpqk/YlKGeQt6Sl/ALe6rWOGjo3JeJ86IoJP?=
 =?us-ascii?Q?XrWdt0V5ZIpPWnO4T0BOkWGM5kSmgjoSnqMHHKvkVkntpVt+Tb75QX2IFN/X?=
 =?us-ascii?Q?W9Ws4V96S6LprJr9SsYbz33EmUjRw4Km23DlX508OMN0BsnyNSq6anjHqB8g?=
 =?us-ascii?Q?CGf1q7paI6qpxWzJ0dQXXvGjStl0LsFu63URRORgr1wCPXbFfanvJDfOpH/h?=
 =?us-ascii?Q?542NgilNoSWVaXhCPMGm4to6r6zwK1QM0FGoFmVCIK4z+zW2dHIZnR4NAp1h?=
 =?us-ascii?Q?PoxEIu89Zx0SC9rsHeuPsxpPiRRi8TGQixd+avYEDjarQHgFQVExS8iy1mZT?=
 =?us-ascii?Q?CN44qP8214WX6ioCi3gG8OtLgAZwmiJnTwrflIiAzUc/mRHJPaufNgSXHX7S?=
 =?us-ascii?Q?X28c8aIoBulVOydDa+SsOL0tWODHmN6WwT+MVUfVmso10xL+Pu5FkrpjVCPJ?=
 =?us-ascii?Q?a/Jqr0y0Z5BOg03cyGc2KVnyKNd1PYiTinczfhUNhJeJS5zYSqqQmrnzhiXt?=
 =?us-ascii?Q?Z/R14vzI5p8+gsw1sI+QhTlPjTctCerhk9nqLqtNaR+Gtxc0w7qV2Myfh280?=
 =?us-ascii?Q?BqlGFue5FqHU5Gi3cdJrThagBTVwEbZASfkKCUJk26qrVN3o07Em6iZqzhdD?=
 =?us-ascii?Q?9V/OlgawLchgXbZHmMWMB57O+71txGkBaR78WPMWeqqFq/cqVgDhzS+5KunW?=
 =?us-ascii?Q?RgG/hvaMkIIb0lK3TIPi1VvDY6gq2CfSpTcBRJo+qkeFwGIhfKtGn60Zbje0?=
 =?us-ascii?Q?1DNHDaEO4HsD6ZVXPeMt/bYk8zJhBt06Bnq4?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 07:59:36.5741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeab52d2-9435-4935-d476-08de228a970e
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CA.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5905

There are two reset controllers on Cix sky1 Soc.
One is located in S0 domain, and the other is located
in S5 domain.

Signed-off-by: Gary Yang <gary.yang@cixtech.com>
---
 .../bindings/reset/cix,sky1-rst.yaml          |  48 +++++
 include/dt-bindings/reset/cix,sky1-rst-fch.h  |  42 +++++
 include/dt-bindings/reset/cix,sky1-rst.h      | 164 ++++++++++++++++++
 3 files changed, 254 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/cix,sky1-rst.yaml
 create mode 100644 include/dt-bindings/reset/cix,sky1-rst-fch.h
 create mode 100644 include/dt-bindings/reset/cix,sky1-rst.h

diff --git a/Documentation/devicetree/bindings/reset/cix,sky1-rst.yaml b/Documentation/devicetree/bindings/reset/cix,sky1-rst.yaml
new file mode 100644
index 000000000000..6339ed3f296a
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/cix,sky1-rst.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/cix,sky1-rst.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CIX Sky1 Reset Controller
+
+maintainers:
+  - Gary Yang <gary.yang@cixtech.com>
+
+description: |
+  CIX Sky1 reset controller can be used to reset various set of peripherals.
+  There are two reset controllers, one is located in S0 domain, the other
+  is located in S5 domain.
+
+  See also:
+  - include/dt-bindings/reset/cix,sky1-rst.h
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - cix,sky1-rst
+          - cix,sky1-rst-fch
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/cix,sky1-rst.h>
+    reset-controller@16000000 {
+      compatible = "cix,sky1-rst", "syscon";
+      reg = <0x16000000 0x1000>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/reset/cix,sky1-rst-fch.h b/include/dt-bindings/reset/cix,sky1-rst-fch.h
new file mode 100644
index 000000000000..8e67d7eb92aa
--- /dev/null
+++ b/include/dt-bindings/reset/cix,sky1-rst-fch.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Author: Jerry Zhu <jerry.zhu@cixtech.com> */
+#ifndef DT_BINDING_RESET_FCH_SKY1_H
+#define DT_BINDING_RESET_FCH_SKY1_H
+
+/* func reset for sky1 fch */
+
+#define SW_I3C0_RST_FUNC_G_N	0
+#define SW_I3C0_RST_FUNC_I_N	1
+#define SW_I3C1_RST_FUNC_G_N	2
+#define SW_I3C1_RST_FUNC_I_N	3
+#define SW_UART0_RST_FUNC_N	4
+#define SW_UART1_RST_FUNC_N	5
+#define SW_UART2_RST_FUNC_N	6
+#define SW_UART3_RST_FUNC_N	7
+#define SW_TIMER_RST_FUNC_N	8
+
+/* apb reset for sky1 fch */
+#define SW_I3C0_RST_APB_N	9
+#define SW_I3C1_RST_APB_N	10
+#define SW_DMA_RST_AXI_N	11
+#define SW_UART0_RST_APB_N	12
+#define SW_UART1_RST_APB_N	13
+#define SW_UART2_RST_APB_N	14
+#define SW_UART3_RST_APB_N	15
+#define SW_SPI0_RST_APB_N	16
+#define SW_SPI1_RST_APB_N	17
+#define SW_I2C0_RST_APB_N	18
+#define SW_I2C1_RST_APB_N	19
+#define SW_I2C2_RST_APB_N	20
+#define SW_I2C3_RST_APB_N	21
+#define SW_I2C4_RST_APB_N	22
+#define SW_I2C5_RST_APB_N	23
+#define SW_I2C6_RST_APB_N	24
+#define SW_I2C7_RST_APB_N	25
+#define SW_GPIO_RST_APB_N	26
+
+/* fch rst for xspi */
+#define SW_XSPI_REG_RST_N	27
+#define SW_XSPI_SYS_RST_N	28
+
+#endif
diff --git a/include/dt-bindings/reset/cix,sky1-rst.h b/include/dt-bindings/reset/cix,sky1-rst.h
new file mode 100644
index 000000000000..72c0d6a60452
--- /dev/null
+++ b/include/dt-bindings/reset/cix,sky1-rst.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Author: Jerry Zhu <jerry.zhu@cixtech.com> */
+#ifndef DT_BINDING_RESET_SKY1_H
+#define DT_BINDING_RESET_SKY1_H
+
+/* reset for csu_pm */
+
+#define SKY1_CSU_PM_RESET_N		0
+#define SKY1_SENSORHUB_RESET_N		1
+#define SKY1_SENSORHUB_NOC_RESET_N	2
+
+/* reset group0 for s0 domain modules */
+#define SKY1_DDRC_RESET_N		3
+#define SKY1_GIC_RESET_N		4
+#define SKY1_CI700_RESET_N		5
+#define SKY1_SYS_NI700_RESET_N		6
+#define SKY1_MM_NI700_RESET_N		7
+#define SKY1_PCIE_NI700_RESET_N		8
+#define SKY1_GPU_RESET_N		9
+#define SKY1_NPUTOP_RESET_N		10
+#define SKY1_NPUCORE0_RESET_N		11
+#define SKY1_NPUCORE1_RESET_N		12
+#define SKY1_NPUCORE2_RESET_N		13
+#define SKY1_VPU_RESET_N		14
+#define SKY1_ISP_SRESET_N		15
+#define SKY1_ISP_ARESET_N		16
+#define SKY1_ISP_HRESET_N		17
+#define SKY1_ISP_GDCRESET_N		18
+#define SKY1_DPU_RESET0_N		19
+#define SKY1_DPU_RESET1_N		20
+#define SKY1_DPU_RESET2_N		21
+#define SKY1_DPU_RESET3_N		22
+#define SKY1_DPU_RESET4_N		23
+#define SKY1_DP_RESET0_N		24
+#define SKY1_DP_RESET1_N		25
+#define SKY1_DP_RESET2_N		26
+#define SKY1_DP_RESET3_N		27
+#define SKY1_DP_RESET4_N		28
+#define SKY1_DP_PHY_RST_N		29
+
+/* reset group1 for s0 domain modules */
+#define SKY1_AUDIO_HIFI5_RESET_N	30
+#define SKY1_AUDIO_HIFI5_NOC_RESET_N	31
+#define SKY1_CSIDPHY_PRST0_N		32
+#define SKY1_CSIDPHY_CMNRST0_N		33
+#define SKY1_CSI0_RST_N			34
+#define SKY1_CSIDPHY_PRST1_N		35
+#define SKY1_CSIDPHY_CMNRST1_N		36
+#define SKY1_CSI1_RST_N			37
+#define SKY1_CSI2_RST_N			38
+#define SKY1_CSI3_RST_N			39
+#define SKY1_CSIBRDGE0_RST_N		40
+#define SKY1_CSIBRDGE1_RST_N		41
+#define SKY1_CSIBRDGE2_RST_N		42
+#define SKY1_CSIBRDGE3_RST_N		43
+#define SKY1_GMAC0_RST_N		44
+#define SKY1_GMAC1_RST_N		45
+#define SKY1_PCIE0_RESET_N		46
+#define SKY1_PCIE1_RESET_N		47
+#define SKY1_PCIE2_RESET_N		48
+#define SKY1_PCIE3_RESET_N		49
+#define SKY1_PCIE4_RESET_N		50
+
+/* reset group1 for usb phys */
+#define SKY1_USB_DP_PHY0_PRST_N		51
+#define SKY1_USB_DP_PHY1_PRST_N		52
+#define SKY1_USB_DP_PHY2_PRST_N		53
+#define SKY1_USB_DP_PHY3_PRST_N		54
+#define SKY1_USB_DP_PHY0_RST_N		55
+#define SKY1_USB_DP_PHY1_RST_N		56
+#define SKY1_USB_DP_PHY2_RST_N		57
+#define SKY1_USB_DP_PHY3_RST_N		58
+#define SKY1_USBPHY_SS_PST_N		59
+#define SKY1_USBPHY_SS_RST_N		60
+#define SKY1_USBPHY_HS0_PRST_N		61
+#define SKY1_USBPHY_HS1_PRST_N		62
+#define SKY1_USBPHY_HS2_PRST_N		63
+#define SKY1_USBPHY_HS3_PRST_N		64
+#define SKY1_USBPHY_HS4_PRST_N		65
+#define SKY1_USBPHY_HS5_PRST_N		66
+#define SKY1_USBPHY_HS6_PRST_N		67
+#define SKY1_USBPHY_HS7_PRST_N		68
+#define SKY1_USBPHY_HS8_PRST_N		69
+#define SKY1_USBPHY_HS9_PRST_N		70
+
+/* reset group1 for usb controllers */
+#define SKY1_USBC_SS0_PRST_N		71
+#define SKY1_USBC_SS1_PRST_N		72
+#define SKY1_USBC_SS2_PRST_N		73
+#define SKY1_USBC_SS3_PRST_N		74
+#define SKY1_USBC_SS4_PRST_N		75
+#define SKY1_USBC_SS5_PRST_N		76
+#define SKY1_USBC_SS0_RST_N		77
+#define SKY1_USBC_SS1_RST_N		78
+#define SKY1_USBC_SS2_RST_N		79
+#define SKY1_USBC_SS3_RST_N		80
+#define SKY1_USBC_SS4_RST_N		81
+#define SKY1_USBC_SS5_RST_N		82
+#define SKY1_USBC_HS0_PRST_N		83
+#define SKY1_USBC_HS1_PRST_N		84
+#define SKY1_USBC_HS2_PRST_N		85
+#define SKY1_USBC_HS3_PRST_N		86
+#define SKY1_USBC_HS0_RST_N		87
+#define SKY1_USBC_HS1_RST_N		88
+#define SKY1_USBC_HS2_RST_N		89
+#define SKY1_USBC_HS3_RST_N		90
+
+/* reset group0 for rcsu */
+#define SKY1_AUDIO_RCSU_RESET_N			91
+#define SKY1_CI700_RCSU_RESET_N			92
+#define SKY1_CSI_RCSU0_RESET_N			93
+#define SKY1_CSI_RCSU1_RESET_N			94
+#define SKY1_CSU_PM_RCSU_RESET_N		95
+#define SKY1_DDR_BROADCAST_RCSU_RESET_N		96
+#define SKY1_DDR_CTRL_RCSU_0_RESET_N		97
+#define SKY1_DDR_CTRL_RCSU_1_RESET_N		98
+#define SKY1_DDR_CTRL_RCSU_2_RESET_N		99
+#define SKY1_DDR_CTRL_RCSU_3_RESET_N		100
+#define SKY1_DDR_TZC400_RCSU_0_RESET_N		101
+#define SKY1_DDR_TZC400_RCSU_1_RESET_N		102
+#define SKY1_DDR_TZC400_RCSU_2_RESET_N		103
+#define SKY1_DDR_TZC400_RCSU_3_RESET_N		104
+#define SKY1_DP0_RCSU_RESET_N			105
+#define SKY1_DP1_RCSU_RESET_N			106
+#define SKY1_DP2_RCSU_RESET_N			107
+#define SKY1_DP3_RCSU_RESET_N			108
+#define SKY1_DP4_RCSU_RESET_N			109
+#define SKY1_DPU0_RCSU_RESET_N			110
+#define SKY1_DPU1_RCSU_RESET_N			111
+#define SKY1_DPU2_RCSU_RESET_N			112
+#define SKY1_DPU3_RCSU_RESET_N			113
+#define SKY1_DPU4_RCSU_RESET_N			114
+#define SKY1_DSU_RCSU_RESET_N			115
+#define SKY1_FCH_RCSU_RESET_N			116
+#define SKY1_GICD_RCSU_RESET_N			117
+#define SKY1_GMAC_RCSU_RESET_N			118
+#define SKY1_GPU_RCSU_RESET_N			119
+#define SKY1_ISP_RCSU0_RESET_N			120
+#define SKY1_ISP_RCSU1_RESET_N			121
+#define SKY1_NI700_MMHUB_RCSU_RESET_N		122
+
+/* reset group1 for rcsu */
+#define SKY1_NPU_RCSU_RESET_N			123
+#define SKY1_NI700_PCIE_RCSU_RESET_N		124
+#define SKY1_PCIE_X421_RCSU_RESET_N		125
+#define SKY1_PCIE_X8_RCSU_RESET_N		126
+#define SKY1_SF_RCSU_RESET_N			127
+#define SKY1_RCSU_SMMU_MMHUB_RESET_N		128
+#define SKY1_RCSU_SMMU_PCIEHUB_RESET_N		129
+#define SKY1_RCSU_SYSHUB_RESET_N		130
+#define SKY1_NI700_SMN_RCSU_RESET_N		131
+#define SKY1_NI700_SYSHUB_RCSU_RESET_N		132
+#define SKY1_RCSU_USB2_HOST0_RESET_N		133
+#define SKY1_RCSU_USB2_HOST1_RESET_N		134
+#define SKY1_RCSU_USB2_HOST2_RESET_N		135
+#define SKY1_RCSU_USB2_HOST3_RESET_N		136
+#define SKY1_RCSU_USB3_TYPEA_DRD_RESET_N	137
+#define SKY1_RCSU_USB3_TYPEC_DRD_RESET_N	138
+#define SKY1_RCSU_USB3_TYPEC_HOST0_RESET_N	139
+#define SKY1_RCSU_USB3_TYPEC_HOST1_RESET_N	140
+#define SKY1_RCSU_USB3_TYPEC_HOST2_RESET_N	141
+#define SKY1_VPU_RCSU_RESET_N			142
+
+#endif
-- 
2.49.0


