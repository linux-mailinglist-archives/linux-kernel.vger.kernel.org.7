Return-Path: <linux-kernel+bounces-889734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF4BC3E5CB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 04:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6F014E892C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 03:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1AF2E7BDE;
	Fri,  7 Nov 2025 03:38:29 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023143.outbound.protection.outlook.com [52.101.127.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBFF13D891;
	Fri,  7 Nov 2025 03:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486708; cv=fail; b=IZMEJadqvt8Gp7TDAFNTh7jy6CFcj11/rwcVBlDpNuTatQu+QOArSSIXsbwRwkPFlSAYYglfnPi9YeAdgPeu4njzNG6aG4ET5O3kkWlSMOaD5ZnXyWfWpWv09vHOgTrT9rIKNikDc+CA1UtNnUv9MsPzqOwIagT2dWMpN9khHaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486708; c=relaxed/simple;
	bh=kI6jlw162Vve7kR3l3YbzoEEaPe37Wis7XfVxxMFRtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zy5CBJtr58QUJwTPMHJhXwmwq4Hj2q5ZS57Z+5vjSHmMKHPacmEU6yeZ6coFVBWyp55v7PqQK3vrOggT+kh5s0bJyqvh678VzvJ250CjB02HqeWqGeJTnB2nZF4qMtRWNAcmrM2F79g92/dss8i7UWIke2sS2A2IlQsR8GtUez4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzGPmxHlHAgJ6Nt9dUiQM1H1huGqv4Q3i9qq+aOjKHawD2Vc5JsqG5+p3GA4WumjDobDeM0RFU9tstAdbWGC4M0dp2PI+FpcTuOq8ygvs4ktFK3AK+6RhWOtKQsmOSQW9sVdnupVmc3YavfeYxIwQLijlN3xjjZ/7QnQPXdvZS0buWUTvOQBlm6JbmSdUpq7yHP+3MWxD8m9yVRbnCSbVmGxIBmZNRScV4K3DxczXtWL7agsZ9qtEukU/RDwb3oHFY1AWLnpq8ZcNni0hErCXgj74Owhcms+ARP+cKtz30MhcVRtVZC8cugX4bQCLdHr1RmQP43KLU3eJQYaDMCvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvP1HxbboZzoHg2lvuovkfKMXJOVDsP+NlJ3F4umdjw=;
 b=OjXYXygjHUBQtTPANrg0lzEmIQk0DxoGfqWDVC8bkAJPRhlZ47GRgBSQPTIYXeCfDOy9L3lfgggfk8hzAYD2HvhUSSj14YgM6wRAf8UbfSoV6lWBrTyOumg7zvZ5AolT++NlG0vOrzyYTce6zkWqUYlEO687g7pVcvJfrgxodUTlBVSXFt55C2ToV+fTFYkzV+XdZpwRKWzSrNl7KG7TdqT033KZLL4jLWUDcESjAUpGEUOp+YW8JrCG5RYFpiJkpK77Q3pZl1UumzOmIQhd9UcDYAhKnhCmwPE381EDF+BCB/dNrSGJF//iFUb4Wzo6XSqfCO7MWJ5X9Msn0J/kgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0047.apcprd02.prod.outlook.com (2603:1096:300:59::35)
 by SE2PPFD0F78DFE1.apcprd06.prod.outlook.com (2603:1096:108:1::7eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 03:38:21 +0000
Received: from OSA0EPF000000CD.apcprd02.prod.outlook.com
 (2603:1096:300:59:cafe::28) by PS2PR02CA0047.outlook.office365.com
 (2603:1096:300:59::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 03:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CD.mail.protection.outlook.com (10.167.240.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 03:38:20 +0000
Received: from localhost.localdomain (unknown [172.16.64.196])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id CCD8541604E2;
	Fri,  7 Nov 2025 11:38:19 +0800 (CST)
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
Subject: [PATCH 1/3] dt-bindings: reset: add sky1 reset controller
Date: Fri,  7 Nov 2025 11:38:17 +0800
Message-ID: <20251107033819.587712-2-gary.yang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251107033819.587712-1-gary.yang@cixtech.com>
References: <20251107033819.587712-1-gary.yang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CD:EE_|SE2PPFD0F78DFE1:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0feff1fe-f6b8-47e4-8333-08de1daf1917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gF6CHt8cn8bJJ0RexFPYeJiMps3qLoY3rOQn2XguRuOzql1hvtKlw45BQIO6?=
 =?us-ascii?Q?WSzjyOxEKcPfVqWVwh9HkWpjpP1UqIGXXCB4mC75L6W5UB2B6nwwwki+hxxy?=
 =?us-ascii?Q?/gV5ifTMNhuBuXg4yuMlJy83e4/N79NU6HItfg4gDWWmuwy3nk1SAup4NyFo?=
 =?us-ascii?Q?F7gsXZYs+nzk6Bh7yx9uW33TH8CYnp4J3oPAbhQwqkCKeFzQwOfMBpnQWFhT?=
 =?us-ascii?Q?7CHuJk6RCg7ujwBaLUZhAB9ntQB2iKHRQ2mriCV2EQA4SakQ/PDP0ozBtKpZ?=
 =?us-ascii?Q?A9FD5hh57J+GK7Rds2VI92cl5TJ6HEm78nDwSZbnCeMYAaQYjdAfvvoV+04i?=
 =?us-ascii?Q?JIPDJ2o9LbzSZLK32QJZ0Sqq9CJmFagrRCCgvTH5AgbAUC+7bbYTR1K4bXgY?=
 =?us-ascii?Q?UgFhbMoDj3xDxM/xBUv8nEUQC4at02hwx7zlS6rfkwUn9G0GNvRxfN0OlQuB?=
 =?us-ascii?Q?mbJNdViBcNUg8jjQyPLKljPm8qXIXOj/bbcq5w1xagw+AzlPDohjLRM0Ik1F?=
 =?us-ascii?Q?9qImQOfkZ+lUDiqA2MxM+NOIeixwzKb+PvuNP5U8DvGcTdR/sgRbtNTo9lQs?=
 =?us-ascii?Q?bvNPkoZel3Ya20z487fYOa1bp+7/N0Z6q2W4blnPVKXsj94HqJLq8aMOlM3E?=
 =?us-ascii?Q?p3BT7Rq2Lpd0Xz9zKXh0BaOnX3YHhRSTdPtFa9hvfKdCQZZe1aGrT6eZ3Zww?=
 =?us-ascii?Q?OKCEWzaw1MztBEe256yudPhL3lZClm1XRDPI0FeU9zkW5qOA92Ad+vOx3igA?=
 =?us-ascii?Q?PpK2eguIfvRgqgKlyvMVdDunvmV7jLUG+Ba6z+tSvCeGif7eoS5puCVu+ubl?=
 =?us-ascii?Q?bq9ks1VV9LnzS+O04T65jE92fzEa71VJ9/kD3PDJPkgIeswaG3CjolDQQbkX?=
 =?us-ascii?Q?jzDR89KzLOaWTx01JERqmT1L7bi7d6uCaMd8m33b3eTcsbaf4JFcJeLAjH6g?=
 =?us-ascii?Q?539MOU7EuBI2bSwVVmUCyPjdq2O6yA37iN6QWiZGp3tsqyxvQaH6kU5uv2pC?=
 =?us-ascii?Q?nEa/Oxw54l5WCpI5YFP1nk0ijQghFAGI8mCxaYef4ON3rWbezEkFZucrDTFz?=
 =?us-ascii?Q?kx1kZVzZZFvm/ZeqQOVNgeKY/8tfxK//u4EfvPWoly2s0MYitiH+wBQcNtKt?=
 =?us-ascii?Q?tqqyDoLBAmc4Zx3UK7UZmcnF5ddZN7S4/WeY8JjU9G4d8bKVu76ttHK8HTzL?=
 =?us-ascii?Q?z48tWUqW6bDwaQTymGxtmOC7PXHKE2jjXIzX5lXwxKlQENvK96g/K5Q0I44U?=
 =?us-ascii?Q?CXBpAuCxZpaD4KF80nLD0T4UHeSpDWDF0ykOLNV5eq3sgVlyCP+BTHZzxj33?=
 =?us-ascii?Q?3+ks64fBSzKVPaJ1nxLqw80J8VAbTxS03ef7rC3yGMgR/2Ml/bXWlY/A/lCr?=
 =?us-ascii?Q?taaHKhc5sK7DXZU7t62IwTM/+ViSNjPoH1v1nGV9/jOrN1VV6LskxSoVBz8X?=
 =?us-ascii?Q?B8SbvoWmtwbnXiRJ97vpQ1osOX6HKgEqAGXZmlsta5YD+8JHGS/c11FbbhLM?=
 =?us-ascii?Q?gAMjfBlaV79JJp+zeQuqoE8iY0y9fM53CLV/?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 03:38:20.8455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0feff1fe-f6b8-47e4-8333-08de1daf1917
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CD.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFD0F78DFE1

There are two reset controllers on Cix sky1 Soc.
One is located in S0 domain, and the other is located
in S5 domain.

Signed-off-by: Gary Yang <gary.yang@cixtech.com>
---
 .../bindings/reset/cix,sky1-rst.yaml          |  48 +++++
 include/dt-bindings/reset/cix,sky1-rst-fch.h  |  45 +++++
 include/dt-bindings/reset/cix,sky1-rst.h      | 167 ++++++++++++++++++
 3 files changed, 260 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/cix,sky1-rst.yaml
 create mode 100644 include/dt-bindings/reset/cix,sky1-rst-fch.h
 create mode 100644 include/dt-bindings/reset/cix,sky1-rst.h

diff --git a/Documentation/devicetree/bindings/reset/cix,sky1-rst.yaml b/Documentation/devicetree/bindings/reset/cix,sky1-rst.yaml
new file mode 100644
index 000000000000..72de480b064c
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
+  - dt-bindings/reset/cix,sky1-rst.h
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
+    maxItems: 2
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
+      reg = <0x0 0x16000000 0x0 0x1000>;
+      #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/reset/cix,sky1-rst-fch.h b/include/dt-bindings/reset/cix,sky1-rst-fch.h
new file mode 100644
index 000000000000..08c43bd64cf1
--- /dev/null
+++ b/include/dt-bindings/reset/cix,sky1-rst-fch.h
@@ -0,0 +1,45 @@
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
+#define SKY1_FCH_RESET_NUM	29
+
+#endif
+
diff --git a/include/dt-bindings/reset/cix,sky1-rst.h b/include/dt-bindings/reset/cix,sky1-rst.h
new file mode 100644
index 000000000000..232d59f0fb25
--- /dev/null
+++ b/include/dt-bindings/reset/cix,sky1-rst.h
@@ -0,0 +1,167 @@
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
+#define SKY1_RESET_NUM				143
+
+#endif
+
-- 
2.49.0


