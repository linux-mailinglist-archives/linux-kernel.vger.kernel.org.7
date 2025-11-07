Return-Path: <linux-kernel+bounces-889735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9401AC3E5D1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 04:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B022B4EACAC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 03:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2C62F9DA4;
	Fri,  7 Nov 2025 03:38:31 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022126.outbound.protection.outlook.com [52.101.126.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6580C16132F;
	Fri,  7 Nov 2025 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486710; cv=fail; b=UpVYtHBQnxrIMU8m7wNqaqLtUBr2nqYxR5s+VLE/oDE+jxxlbItZQLvDeKrqRUe9/09gSPnD3UW7RSZGSNgBNDDAnJZ8S58rwJol1XXjn+PgxdrXU+AkDvweIoJF6gixAqp/mfNcM82dzBrZ9paYYiZVTnNU5yxuLWtX1sAeUXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486710; c=relaxed/simple;
	bh=MYpebQ2dKenAtQk+MifG5nYnRuOcPrJTBIkIM0WjSJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QiG8SACoLaN5l+dZtL4WGqjv25O5Lk5hrFqgAAHHaSCYMZUHBxLhKa4J+Nm/HjNCJomUuraaPKFjgQ+8e9Fc5xI+UlXapVvCdcMBws9z1n26TqZPp2lvuOr4R0iYHwdGy3sKYYTpW6k5+QrhSLlkpZ4gyTh65y//70UKYr3JAKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HP48DjckwhOaUUBMaJwy/9vNT3d0gs+it6U1IIY0oEVdyup5XD3HnAUfBRph7f8+eD6xmCdO8VT38sQWUQmgh8PWMzMApk2zg4htIGTX71SndqmWW7XKn5l5E0J85IM81lrT9maovQT8+O9Vce/a40poCnScPRn+kjsP2571XX76CyfvkBD2aXRF79nV0Ix7mMFTK1iq1i83LH+TyPKquDVk6DXvbBCyQLoT6cOL38PyizapPEsO+9ZVo2nNht2p+V8hBrCgQRgel09v+CCdS8wdrB8HrmU0qtxUPgVhWA1nwJpHfBDlx9k/jD0nzkx5eJCvMWTQ1xlNCRWs80Y47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+04j2gyEQbU6hWqZssQuI1xjbt8mPTvP7jkhKEC8Y4E=;
 b=kgiWN9yPEeZHeK4vAxDeKbV1+UAxFsAkZSwUk8aB8LVsnjpH1XFdFUKjX7HsvaW6LDFrNZ0ixf1DNGFSCKz4LzwSqJl5+edlqV8aLJ5WQrFbcG8It9+KJpGBKsbvQHEeZFIwIJ0cN0nSPwCUekwE0wGIyDTZTCjbmBtVcvuP9jGs5tXRtmfXz2V//+ifqZwbAUz9fbZW+QAeUYM94A090UiMNMvW/bhBOFRQbHor2iCiXR2KZGgcVQWTUiXdI+iOO39ys4F4G53Q9tNB18ONZL7nJHJUsckKYh9v+LQAZ5XRK5tDJCa87KGdBju3CRgwL4gQ4ouF6uvTo3qmJuq5EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR06CA0211.apcprd06.prod.outlook.com (2603:1096:4:68::19) by
 JH0PR06MB6798.apcprd06.prod.outlook.com (2603:1096:990:3c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.12; Fri, 7 Nov 2025 03:38:23 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:4:68:cafe::72) by SG2PR06CA0211.outlook.office365.com
 (2603:1096:4:68::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 03:38:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 03:38:20 +0000
Received: from localhost.localdomain (unknown [172.16.64.196])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id DBAF141604E6;
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
Subject: [PATCH 2/3] Reset: cix: add support for cix sky1 resets
Date: Fri,  7 Nov 2025 11:38:18 +0800
Message-ID: <20251107033819.587712-3-gary.yang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CF:EE_|JH0PR06MB6798:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8d2e5519-5eeb-40de-3da8-08de1daf18fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NLgCIfzmlw2dIE7ehQLZd8I61uP3jkk5lNpRup+SisWKxLRoTmAKR5LRNOYu?=
 =?us-ascii?Q?5eBKvIqpHye8V9hmmhSG203D9v5Q6Ng4E5AG808jM8rYmMww7Inm4L/+Ia/m?=
 =?us-ascii?Q?lHhHaUDQ7Cpt9z7gtHkszlJ792RutxHIPMCdRJyuSn9/zKAXWBlOvu3pWMYU?=
 =?us-ascii?Q?1aVCp9+IQLzTMt1Rec1rKZ7Y1QE+TsrxdCdJjwJosiQaS3K5ZwBfdIaNAAHR?=
 =?us-ascii?Q?P79D2Zp38sS/+YjxVDMosDDtMJnfA1ym6WdZkXXhehVPokInOScDpX5/CpZy?=
 =?us-ascii?Q?MqGsRR+LkH/EwB135i/wZB9/QTeRsvEe/iu3/D6//lKIj7a+zWe+iWKYrYKu?=
 =?us-ascii?Q?USbSURK/uERIwBvRcYla95+2QAyN68UgWQc6GEM12YPFqeZIBWMRZMfMukd5?=
 =?us-ascii?Q?1wfLr+8QCeM/x+9VHdEMbi77/J58UfjDLO+6ML8oF8DsWnIYtaSO536nVsnv?=
 =?us-ascii?Q?UxDDeDO9Wdf41Nxc0nVLcn37xROtqVXNhhlqc8dIwBoIF/ShQOdv3JU6a4CU?=
 =?us-ascii?Q?yDe/2qPMLMNpuCoZ3Ow/GoHyKGbtFnSHDB9Fdsfnoy2v9og5UVuVkYTE7lnF?=
 =?us-ascii?Q?7OUOiT2ypA3XQZO+UOuE0VVt/5P26phQ/Qht0CotHT4ysIwSplD0J0JRi0h0?=
 =?us-ascii?Q?kItE5QVJKLELU+2E7ouqH/tONoXxhu5katsTbWXgnfjFOfYCXMNTZfGuk0C4?=
 =?us-ascii?Q?LiJxWEsHnuB3zst/g7qiFi+uWYit5w7mj+btmB9vBQs92YL3+nnp2gCzvLZY?=
 =?us-ascii?Q?rpvBYJzUas6AjXD8mn1wxO+/3SGCiilQUU4diu8PRIGDa4HqWSXtuDWhRi7i?=
 =?us-ascii?Q?dilHiDzb7cAtbb25QuNInbyXO2RrYoM4NIl38HVJmNX8ECB9l92sNiTy7rxk?=
 =?us-ascii?Q?jNb/XfSmX6QDfcv+6qw4JnTgETnY5Ep9b4LYila5QaBFrQx8B9Z5w/YRwJqt?=
 =?us-ascii?Q?MfuNfbdWjO0SoNLeg/0dBDUb1oZgLHZBxiLEoyQwrI1i0hJB9qyZw+Y6PxT6?=
 =?us-ascii?Q?rimJAmuhV9o1lmw2kWMWaHIUB18sNi+v2IrHNh3mFK2d6FnYN+aG58gMffpS?=
 =?us-ascii?Q?cYAzVxHoqfLC9/5Wzvkfv0FCxx73RIN36UfU5crVr2tgmdksW9KjzdrOfztr?=
 =?us-ascii?Q?nHW5K0YfC1mnbHHfym1Lwf8tgIkqhOTczK5QYQ4wo3d+xWZS8AuLuekqC5LZ?=
 =?us-ascii?Q?TfzXkzAnVzpV9nSkjgR3yD5qmKSRq8HzhRaLF+puWdJ5hh7wmS2zegXMMjiz?=
 =?us-ascii?Q?5frz5SgiUeOcIs0pKWsNQqcrUxSqfbKbYunyIw5w40WLjmzQdHLuh5M0BlSU?=
 =?us-ascii?Q?OJuw31U11B/2oY6Ki5Dg3p9/14q8VPokB3zd9egQ/GQPN4cic951lUWlzwAn?=
 =?us-ascii?Q?JDOZHhFwUiPV8VBM2qyeqvdE8R3qjga48ZrBAwAr/l+I/6Sxyp0y7OSWNRRA?=
 =?us-ascii?Q?ltJLIMaRBT6vXvIA3n4dQlQfn2lN3rDhonHN9oQvpyvgwLCCsDHIgYyEpNkq?=
 =?us-ascii?Q?7ydZmWVO2BvWXjYfyHrQRKGcDzSnK+GXLaZbQifR0MjEHxlKIfIiJPsbkim/?=
 =?us-ascii?Q?L10tTm0qQ//M+9v+T8I=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 03:38:20.6926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2e5519-5eeb-40de-3da8-08de1daf18fc
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6798

There are two reset controllers on Cix Sky1 Soc.
One is located in S0 domain, and the other is located
in S5 domain.

Signed-off-by: Gary Yang <gary.yang@cixtech.com>
---
 drivers/reset/Kconfig      |   7 +
 drivers/reset/Makefile     |   1 +
 drivers/reset/reset-sky1.c | 403 +++++++++++++++++++++++++++++++++++++
 3 files changed, 411 insertions(+)
 create mode 100644 drivers/reset/reset-sky1.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 78b7078478d4..45768cd3b135 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -278,6 +278,13 @@ config RESET_SIMPLE
 	   - SiFive FU740 SoCs
 	   - Sophgo SoCs
 
+config RESET_SKY1
+	bool "Cix Sky1 reset controller"
+	depends on HAS_IOMEM
+	depends on ARCH_CIX || COMPILE_TEST
+	help
+	  This enables the reset controller for Cix Sky1.
+
 config RESET_SOCFPGA
 	bool "SoCFPGA Reset Driver" if COMPILE_TEST && (!ARM || !ARCH_INTEL_SOCFPGA)
 	default ARM && ARCH_INTEL_SOCFPGA
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index f7934f9fb90b..a878ac4a6e4b 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
 obj-$(CONFIG_RESET_RZV2H_USB2PHY) += reset-rzv2h-usb2phy.o
 obj-$(CONFIG_RESET_SCMI) += reset-scmi.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
+obj-$(CONFIG_RESET_SKY1) += reset-sky1.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_SPACEMIT) += reset-spacemit.o
 obj-$(CONFIG_RESET_SUNPLUS) += reset-sunplus.o
diff --git a/drivers/reset/reset-sky1.c b/drivers/reset/reset-sky1.c
new file mode 100644
index 000000000000..14aa7292c0d5
--- /dev/null
+++ b/drivers/reset/reset-sky1.c
@@ -0,0 +1,403 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *
+ * CIX System Reset Controller (SRC) driver
+ *
+ * Author: Jerry Zhu <jerry.zhu@cixtech.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/reset/cix,sky1-rst.h>
+#include <dt-bindings/reset/cix,sky1-rst-fch.h>
+
+#define SKY1_RESET_SLEEP_MIN_US		10000
+#define SKY1_RESET_SLEEP_MAX_US		20000
+
+struct sky1_src_signal {
+	unsigned int offset, mask;
+};
+
+struct sky1_src_variant {
+	const struct sky1_src_signal *signals;
+	unsigned int signals_num;
+};
+
+struct sky1_src {
+	struct reset_controller_dev rcdev;
+	struct regmap *regmap;
+	const struct sky1_src_signal *signals;
+};
+
+enum {
+	CSU_PM_RESET				= 0x304,
+	SENSORHUB_RESET				= 0x308,
+	SENSORHUB_NOC_RESET			= 0x30c,
+
+	RESET_GROUP0_S0_DOMAIN_0		= 0x400,
+	RESET_GROUP0_S0_DOMAIN_1		= 0x404,
+	RESET_GROUP1_USB_PHYS			= 0x408,
+	RESET_GROUP1_USB_CONTROLLERS		= 0x40c,
+
+	RESET_GROUP0_RCSU			= 0x800,
+	RESET_GROUP1_RCSU			= 0x804,
+
+};
+
+static const struct sky1_src_signal sky1_src_signals[SKY1_RESET_NUM] = {
+	/* reset group1 for s0 domain modules */
+	[SKY1_CSU_PM_RESET_N]		= { CSU_PM_RESET, BIT(0) },
+	[SKY1_SENSORHUB_RESET_N]	= { SENSORHUB_RESET, BIT(0) },
+	[SKY1_SENSORHUB_NOC_RESET_N]	= { SENSORHUB_NOC_RESET, BIT(0) },
+	[SKY1_DDRC_RESET_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(0) },
+	[SKY1_GIC_RESET_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(1) },
+	[SKY1_CI700_RESET_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(2) },
+	[SKY1_SYS_NI700_RESET_N]	= { RESET_GROUP0_S0_DOMAIN_0, BIT(3) },
+	[SKY1_MM_NI700_RESET_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(4) },
+	[SKY1_PCIE_NI700_RESET_N]	= { RESET_GROUP0_S0_DOMAIN_0, BIT(5) },
+	[SKY1_GPU_RESET_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(6) },
+	[SKY1_NPUTOP_RESET_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(7) },
+	[SKY1_NPUCORE0_RESET_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(8) },
+	[SKY1_NPUCORE1_RESET_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(9) },
+	[SKY1_NPUCORE2_RESET_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(10) },
+	[SKY1_VPU_RESET_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(11) },
+	[SKY1_ISP_SRESET_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(12) },
+	[SKY1_ISP_ARESET_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(13) },
+	[SKY1_ISP_HRESET_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(14) },
+	[SKY1_ISP_GDCRESET_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(15) },
+	[SKY1_DPU_RESET0_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(16) },
+	[SKY1_DPU_RESET1_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(17) },
+	[SKY1_DPU_RESET2_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(18) },
+	[SKY1_DPU_RESET3_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(19) },
+	[SKY1_DPU_RESET4_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(20) },
+	[SKY1_DP_RESET0_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(21) },
+	[SKY1_DP_RESET1_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(22) },
+	[SKY1_DP_RESET2_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(23) },
+	[SKY1_DP_RESET3_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(24) },
+	[SKY1_DP_RESET4_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(25) },
+	[SKY1_DP_PHY_RST_N]		= { RESET_GROUP0_S0_DOMAIN_0, BIT(26) },
+
+	/* reset group1 for s0 domain modules */
+	[SKY1_AUDIO_HIFI5_RESET_N]	= { RESET_GROUP0_S0_DOMAIN_1, BIT(0) },
+	[SKY1_AUDIO_HIFI5_NOC_RESET_N]	= { RESET_GROUP0_S0_DOMAIN_1, BIT(1) },
+	[SKY1_CSIDPHY_PRST0_N]		= { RESET_GROUP0_S0_DOMAIN_1, BIT(2) },
+	[SKY1_CSIDPHY_CMNRST0_N]	= { RESET_GROUP0_S0_DOMAIN_1, BIT(3) },
+	[SKY1_CSI0_RST_N]		= { RESET_GROUP0_S0_DOMAIN_1, BIT(4) },
+	[SKY1_CSIDPHY_PRST1_N]		= { RESET_GROUP0_S0_DOMAIN_1, BIT(5) },
+	[SKY1_CSIDPHY_CMNRST1_N]	= { RESET_GROUP0_S0_DOMAIN_1, BIT(6) },
+	[SKY1_CSI1_RST_N]		= { RESET_GROUP0_S0_DOMAIN_1, BIT(7) },
+	[SKY1_CSI2_RST_N]		= { RESET_GROUP0_S0_DOMAIN_1, BIT(8) },
+	[SKY1_CSI3_RST_N]		= { RESET_GROUP0_S0_DOMAIN_1, BIT(9) },
+	[SKY1_CSIBRDGE0_RST_N]		= { RESET_GROUP0_S0_DOMAIN_1, BIT(10) },
+	[SKY1_CSIBRDGE1_RST_N]		= { RESET_GROUP0_S0_DOMAIN_1, BIT(11) },
+	[SKY1_CSIBRDGE2_RST_N]		= { RESET_GROUP0_S0_DOMAIN_1, BIT(12) },
+	[SKY1_CSIBRDGE3_RST_N]		= { RESET_GROUP0_S0_DOMAIN_1, BIT(13) },
+	[SKY1_GMAC0_RST_N]		= { RESET_GROUP0_S0_DOMAIN_1, BIT(14) },
+	[SKY1_GMAC1_RST_N]		= { RESET_GROUP0_S0_DOMAIN_1, BIT(15) },
+	[SKY1_PCIE0_RESET_N]		= { RESET_GROUP0_S0_DOMAIN_1, BIT(16) },
+	[SKY1_PCIE1_RESET_N]		= { RESET_GROUP0_S0_DOMAIN_1, BIT(17) },
+	[SKY1_PCIE2_RESET_N]		= { RESET_GROUP0_S0_DOMAIN_1, BIT(18) },
+	[SKY1_PCIE3_RESET_N]		= { RESET_GROUP0_S0_DOMAIN_1, BIT(19) },
+	[SKY1_PCIE4_RESET_N]		= { RESET_GROUP0_S0_DOMAIN_1, BIT(20) },
+
+	/* reset group1 for usb phys */
+	[SKY1_USB_DP_PHY0_PRST_N]		= { RESET_GROUP1_USB_PHYS, BIT(0) },
+	[SKY1_USB_DP_PHY1_PRST_N]		= { RESET_GROUP1_USB_PHYS, BIT(1) },
+	[SKY1_USB_DP_PHY2_PRST_N]		= { RESET_GROUP1_USB_PHYS, BIT(2) },
+	[SKY1_USB_DP_PHY3_PRST_N]		= { RESET_GROUP1_USB_PHYS, BIT(3) },
+	[SKY1_USB_DP_PHY0_RST_N]		= { RESET_GROUP1_USB_PHYS, BIT(4) },
+	[SKY1_USB_DP_PHY1_RST_N]		= { RESET_GROUP1_USB_PHYS, BIT(5) },
+	[SKY1_USB_DP_PHY2_RST_N]		= { RESET_GROUP1_USB_PHYS, BIT(6) },
+	[SKY1_USB_DP_PHY3_RST_N]		= { RESET_GROUP1_USB_PHYS, BIT(7) },
+	[SKY1_USBPHY_SS_PST_N]			= { RESET_GROUP1_USB_PHYS, BIT(8) },
+	[SKY1_USBPHY_SS_RST_N]			= { RESET_GROUP1_USB_PHYS, BIT(9) },
+	[SKY1_USBPHY_HS0_PRST_N]		= { RESET_GROUP1_USB_PHYS, BIT(10) },
+	[SKY1_USBPHY_HS1_PRST_N]		= { RESET_GROUP1_USB_PHYS, BIT(11) },
+	[SKY1_USBPHY_HS2_PRST_N]		= { RESET_GROUP1_USB_PHYS, BIT(12) },
+	[SKY1_USBPHY_HS3_PRST_N]		= { RESET_GROUP1_USB_PHYS, BIT(13) },
+	[SKY1_USBPHY_HS4_PRST_N]		= { RESET_GROUP1_USB_PHYS, BIT(14) },
+	[SKY1_USBPHY_HS5_PRST_N]		= { RESET_GROUP1_USB_PHYS, BIT(15) },
+	[SKY1_USBPHY_HS6_PRST_N]		= { RESET_GROUP1_USB_PHYS, BIT(16) },
+	[SKY1_USBPHY_HS7_PRST_N]		= { RESET_GROUP1_USB_PHYS, BIT(17) },
+	[SKY1_USBPHY_HS8_PRST_N]		= { RESET_GROUP1_USB_PHYS, BIT(18) },
+	[SKY1_USBPHY_HS9_PRST_N]		= { RESET_GROUP1_USB_PHYS, BIT(19) },
+
+	/* reset group1 for usb controllers */
+	[SKY1_USBC_SS0_PRST_N]		= { RESET_GROUP1_USB_CONTROLLERS, BIT(0) },
+	[SKY1_USBC_SS1_PRST_N]		= { RESET_GROUP1_USB_CONTROLLERS, BIT(1) },
+	[SKY1_USBC_SS2_PRST_N]		= { RESET_GROUP1_USB_CONTROLLERS, BIT(2) },
+	[SKY1_USBC_SS3_PRST_N]		= { RESET_GROUP1_USB_CONTROLLERS, BIT(3) },
+	[SKY1_USBC_SS4_PRST_N]		= { RESET_GROUP1_USB_CONTROLLERS, BIT(4) },
+	[SKY1_USBC_SS5_PRST_N]		= { RESET_GROUP1_USB_CONTROLLERS, BIT(5) },
+	[SKY1_USBC_SS0_RST_N]		= { RESET_GROUP1_USB_CONTROLLERS, BIT(6) },
+	[SKY1_USBC_SS1_RST_N]		= { RESET_GROUP1_USB_CONTROLLERS, BIT(7) },
+	[SKY1_USBC_SS2_RST_N]		= { RESET_GROUP1_USB_CONTROLLERS, BIT(8) },
+	[SKY1_USBC_SS3_RST_N]		= { RESET_GROUP1_USB_CONTROLLERS, BIT(9) },
+	[SKY1_USBC_SS4_RST_N]		= { RESET_GROUP1_USB_CONTROLLERS, BIT(10) },
+	[SKY1_USBC_SS5_RST_N]		= { RESET_GROUP1_USB_CONTROLLERS, BIT(11) },
+	[SKY1_USBC_HS0_PRST_N]		= { RESET_GROUP1_USB_CONTROLLERS, BIT(12) },
+	[SKY1_USBC_HS1_PRST_N]		= { RESET_GROUP1_USB_CONTROLLERS, BIT(13) },
+	[SKY1_USBC_HS2_PRST_N]		= { RESET_GROUP1_USB_CONTROLLERS, BIT(14) },
+	[SKY1_USBC_HS3_PRST_N]		= { RESET_GROUP1_USB_CONTROLLERS, BIT(15) },
+	[SKY1_USBC_HS0_RST_N]		= { RESET_GROUP1_USB_CONTROLLERS, BIT(16) },
+	[SKY1_USBC_HS1_RST_N]		= { RESET_GROUP1_USB_CONTROLLERS, BIT(17) },
+	[SKY1_USBC_HS2_RST_N]		= { RESET_GROUP1_USB_CONTROLLERS, BIT(18) },
+	[SKY1_USBC_HS3_RST_N]		= { RESET_GROUP1_USB_CONTROLLERS, BIT(19) },
+
+	/* reset group0 for rcsu */
+	[SKY1_AUDIO_RCSU_RESET_N]		= { RESET_GROUP0_RCSU, BIT(0) },
+	[SKY1_CI700_RCSU_RESET_N]		= { RESET_GROUP0_RCSU, BIT(1) },
+	[SKY1_CSI_RCSU0_RESET_N]		= { RESET_GROUP0_RCSU, BIT(2) },
+	[SKY1_CSI_RCSU1_RESET_N]		= { RESET_GROUP0_RCSU, BIT(3) },
+	[SKY1_CSU_PM_RCSU_RESET_N]		= { RESET_GROUP0_RCSU, BIT(4) },
+	[SKY1_DDR_BROADCAST_RCSU_RESET_N]	= { RESET_GROUP0_RCSU, BIT(5) },
+	[SKY1_DDR_CTRL_RCSU_0_RESET_N]		= { RESET_GROUP0_RCSU, BIT(6) },
+	[SKY1_DDR_CTRL_RCSU_1_RESET_N]		= { RESET_GROUP0_RCSU, BIT(7) },
+	[SKY1_DDR_CTRL_RCSU_2_RESET_N]		= { RESET_GROUP0_RCSU, BIT(8) },
+	[SKY1_DDR_CTRL_RCSU_3_RESET_N]		= { RESET_GROUP0_RCSU, BIT(9) },
+	[SKY1_DDR_TZC400_RCSU_0_RESET_N]	= { RESET_GROUP0_RCSU, BIT(10) },
+	[SKY1_DDR_TZC400_RCSU_1_RESET_N]	= { RESET_GROUP0_RCSU, BIT(11) },
+	[SKY1_DDR_TZC400_RCSU_2_RESET_N]	= { RESET_GROUP0_RCSU, BIT(12) },
+	[SKY1_DDR_TZC400_RCSU_3_RESET_N]	= { RESET_GROUP0_RCSU, BIT(13) },
+	[SKY1_DP0_RCSU_RESET_N]			= { RESET_GROUP0_RCSU, BIT(14) },
+	[SKY1_DP1_RCSU_RESET_N]			= { RESET_GROUP0_RCSU, BIT(15) },
+	[SKY1_DP2_RCSU_RESET_N]			= { RESET_GROUP0_RCSU, BIT(16) },
+	[SKY1_DP3_RCSU_RESET_N]			= { RESET_GROUP0_RCSU, BIT(17) },
+	[SKY1_DP4_RCSU_RESET_N]			= { RESET_GROUP0_RCSU, BIT(18) },
+	[SKY1_DPU0_RCSU_RESET_N]		= { RESET_GROUP0_RCSU, BIT(19) },
+	[SKY1_DPU1_RCSU_RESET_N]		= { RESET_GROUP0_RCSU, BIT(20) },
+	[SKY1_DPU2_RCSU_RESET_N]		= { RESET_GROUP0_RCSU, BIT(21) },
+	[SKY1_DPU3_RCSU_RESET_N]		= { RESET_GROUP0_RCSU, BIT(22) },
+	[SKY1_DPU4_RCSU_RESET_N]		= { RESET_GROUP0_RCSU, BIT(23) },
+	[SKY1_DSU_RCSU_RESET_N]			= { RESET_GROUP0_RCSU, BIT(24) },
+	[SKY1_FCH_RCSU_RESET_N]			= { RESET_GROUP0_RCSU, BIT(25) },
+	[SKY1_GICD_RCSU_RESET_N]		= { RESET_GROUP0_RCSU, BIT(26) },
+	[SKY1_GMAC_RCSU_RESET_N]		= { RESET_GROUP0_RCSU, BIT(27) },
+	[SKY1_GPU_RCSU_RESET_N]			= { RESET_GROUP0_RCSU, BIT(28) },
+	[SKY1_ISP_RCSU0_RESET_N]		= { RESET_GROUP0_RCSU, BIT(29) },
+	[SKY1_ISP_RCSU1_RESET_N]		= { RESET_GROUP0_RCSU, BIT(30) },
+	[SKY1_NI700_MMHUB_RCSU_RESET_N]		= { RESET_GROUP0_RCSU, BIT(31) },
+
+	/* reset group1 for rcsu */
+	[SKY1_NPU_RCSU_RESET_N]			= { RESET_GROUP1_RCSU, BIT(0) },
+	[SKY1_NI700_PCIE_RCSU_RESET_N]		= { RESET_GROUP1_RCSU, BIT(1) },
+	[SKY1_PCIE_X421_RCSU_RESET_N]		= { RESET_GROUP1_RCSU, BIT(2) },
+	[SKY1_PCIE_X8_RCSU_RESET_N]		= { RESET_GROUP1_RCSU, BIT(3) },
+	[SKY1_SF_RCSU_RESET_N]			= { RESET_GROUP1_RCSU, BIT(4) },
+	[SKY1_RCSU_SMMU_MMHUB_RESET_N]		= { RESET_GROUP1_RCSU, BIT(5) },
+	[SKY1_RCSU_SMMU_PCIEHUB_RESET_N]	= { RESET_GROUP1_RCSU, BIT(6) },
+	[SKY1_RCSU_SYSHUB_RESET_N]		= { RESET_GROUP1_RCSU, BIT(7) },
+	[SKY1_NI700_SMN_RCSU_RESET_N]		= { RESET_GROUP1_RCSU, BIT(8) },
+	[SKY1_NI700_SYSHUB_RCSU_RESET_N]	= { RESET_GROUP1_RCSU, BIT(9) },
+	[SKY1_RCSU_USB2_HOST0_RESET_N]		= { RESET_GROUP1_RCSU, BIT(10) },
+	[SKY1_RCSU_USB2_HOST1_RESET_N]		= { RESET_GROUP1_RCSU, BIT(11) },
+	[SKY1_RCSU_USB2_HOST2_RESET_N]		= { RESET_GROUP1_RCSU, BIT(12) },
+	[SKY1_RCSU_USB2_HOST3_RESET_N]		= { RESET_GROUP1_RCSU, BIT(13) },
+	[SKY1_RCSU_USB3_TYPEA_DRD_RESET_N]	= { RESET_GROUP1_RCSU, BIT(14) },
+	[SKY1_RCSU_USB3_TYPEC_DRD_RESET_N]	= { RESET_GROUP1_RCSU, BIT(15) },
+	[SKY1_RCSU_USB3_TYPEC_HOST0_RESET_N]	= { RESET_GROUP1_RCSU, BIT(16) },
+	[SKY1_RCSU_USB3_TYPEC_HOST1_RESET_N]	= { RESET_GROUP1_RCSU, BIT(17) },
+	[SKY1_RCSU_USB3_TYPEC_HOST2_RESET_N]	= { RESET_GROUP1_RCSU, BIT(18) },
+	[SKY1_VPU_RCSU_RESET_N]			= { RESET_GROUP1_RCSU, BIT(19) },
+
+};
+
+enum {
+	FCH_SW_RST_FUNC			= 0x008,
+	FCH_SW_RST_BUS			= 0x00c,
+	FCH_SW_XSPI			= 0x010,
+};
+
+static const struct sky1_src_signal sky1_src_fch_signals[SKY1_FCH_RESET_NUM] = {
+	/* resets for fch_sw_rst_func */
+	[SW_I3C0_RST_FUNC_G_N]	= { FCH_SW_RST_FUNC, BIT(0) },
+	[SW_I3C0_RST_FUNC_I_N]	= { FCH_SW_RST_FUNC, BIT(1) },
+	[SW_I3C1_RST_FUNC_G_N]	= { FCH_SW_RST_FUNC, BIT(2) },
+	[SW_I3C1_RST_FUNC_I_N]	= { FCH_SW_RST_FUNC, BIT(3) },
+	[SW_UART0_RST_FUNC_N]	= { FCH_SW_RST_FUNC, BIT(4) },
+	[SW_UART1_RST_FUNC_N]	= { FCH_SW_RST_FUNC, BIT(5) },
+	[SW_UART2_RST_FUNC_N]	= { FCH_SW_RST_FUNC, BIT(6) },
+	[SW_UART3_RST_FUNC_N]	= { FCH_SW_RST_FUNC, BIT(7) },
+	[SW_TIMER_RST_FUNC_N]	= { FCH_SW_RST_FUNC, BIT(20) },
+
+	/* resets for fch_sw_rst_bus */
+	[SW_I3C0_RST_APB_N]	= { FCH_SW_RST_BUS, BIT(0) },
+	[SW_I3C1_RST_APB_N]	= { FCH_SW_RST_BUS, BIT(1) },
+	[SW_DMA_RST_AXI_N]	= { FCH_SW_RST_BUS, BIT(2) },
+	[SW_UART0_RST_APB_N]	= { FCH_SW_RST_BUS, BIT(4) },
+	[SW_UART1_RST_APB_N]	= { FCH_SW_RST_BUS, BIT(5) },
+	[SW_UART2_RST_APB_N]	= { FCH_SW_RST_BUS, BIT(6) },
+	[SW_UART3_RST_APB_N]	= { FCH_SW_RST_BUS, BIT(7) },
+	[SW_SPI0_RST_APB_N]	= { FCH_SW_RST_BUS, BIT(8) },
+	[SW_SPI1_RST_APB_N]	= { FCH_SW_RST_BUS, BIT(9) },
+	[SW_I2C0_RST_APB_N]	= { FCH_SW_RST_BUS, BIT(12) },
+	[SW_I2C1_RST_APB_N]	= { FCH_SW_RST_BUS, BIT(13) },
+	[SW_I2C2_RST_APB_N]	= { FCH_SW_RST_BUS, BIT(14) },
+	[SW_I2C3_RST_APB_N]	= { FCH_SW_RST_BUS, BIT(15) },
+	[SW_I2C4_RST_APB_N]	= { FCH_SW_RST_BUS, BIT(16) },
+	[SW_I2C5_RST_APB_N]	= { FCH_SW_RST_BUS, BIT(17) },
+	[SW_I2C6_RST_APB_N]	= { FCH_SW_RST_BUS, BIT(18) },
+	[SW_I2C7_RST_APB_N]	= { FCH_SW_RST_BUS, BIT(19) },
+	[SW_GPIO_RST_APB_N]	= { FCH_SW_RST_BUS, BIT(21) },
+
+	/* resets for fch_sw_xspi */
+	[SW_XSPI_REG_RST_N]	= { FCH_SW_XSPI, BIT(0) },
+	[SW_XSPI_SYS_RST_N]	= { FCH_SW_XSPI, BIT(1) },
+};
+
+static struct sky1_src *to_sky1_src(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct sky1_src, rcdev);
+}
+
+static int sky1_reset_update(struct sky1_src *sky1src,
+			     unsigned long id, unsigned int value)
+{
+	const struct sky1_src_signal *signal = &sky1src->signals[id];
+
+	return regmap_update_bits(sky1src->regmap,
+				  signal->offset, signal->mask, value);
+}
+
+static int sky1_reset_set(struct reset_controller_dev *rcdev,
+			  unsigned long id, bool assert)
+{
+	struct sky1_src *sky1src = to_sky1_src(rcdev);
+	unsigned int value = assert ? 0 : sky1src->signals[id].mask;
+
+	return sky1_reset_update(sky1src, id, value);
+}
+
+static int sky1_reset(struct reset_controller_dev *rcdev,
+			     unsigned long id)
+{
+	sky1_reset_set(rcdev, id, true);
+	usleep_range(SKY1_RESET_SLEEP_MIN_US,
+		     SKY1_RESET_SLEEP_MAX_US);
+
+	sky1_reset_set(rcdev, id, false);
+
+	/*
+	 * Ensure component is taken out reset state by sleeping also after
+	 * deasserting the reset, Otherwise, the component may not be ready
+	 * for operation.
+	 */
+	usleep_range(SKY1_RESET_SLEEP_MIN_US,
+		     SKY1_RESET_SLEEP_MAX_US);
+	return 0;
+}
+
+static int sky1_reset_assert(struct reset_controller_dev *rcdev,
+			     unsigned long id)
+{
+	return sky1_reset_set(rcdev, id, true);
+}
+
+static int sky1_reset_deassert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	return sky1_reset_set(rcdev, id, false);
+}
+
+static int sky1_reset_status(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	unsigned int value = 0;
+	struct sky1_src *sky1_src = to_sky1_src(rcdev);
+	const struct sky1_src_signal *signal = &sky1_src->signals[id];
+
+	regmap_read(sky1_src->regmap, signal->offset, &value);
+	return !(value & signal->mask);
+}
+
+static const struct reset_control_ops sky1_src_ops = {
+	.reset    = sky1_reset,
+	.assert   = sky1_reset_assert,
+	.deassert = sky1_reset_deassert,
+	.status   = sky1_reset_status
+};
+
+static const struct sky1_src_variant variant_sky1 = {
+	.signals = sky1_src_signals,
+	.signals_num = ARRAY_SIZE(sky1_src_signals),
+};
+
+static const struct sky1_src_variant variant_sky1_fch = {
+	.signals = sky1_src_fch_signals,
+	.signals_num = ARRAY_SIZE(sky1_src_fch_signals),
+};
+
+static const struct regmap_config sky1_src_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.name = "src",
+};
+
+static int sky1_reset_probe(struct platform_device *pdev)
+{
+	struct sky1_src *sky1src;
+	struct device *dev = &pdev->dev;
+	void __iomem *base;
+	const struct sky1_src_variant *variant = device_get_match_data(dev);
+
+	sky1src = devm_kzalloc(dev, sizeof(*sky1src), GFP_KERNEL);
+	if (!sky1src)
+		return -ENOMEM;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	sky1src->regmap = devm_regmap_init_mmio(dev, base, &sky1_src_config);
+	if (IS_ERR(sky1src->regmap)) {
+		dev_err(dev, "Unable to get sky1-src regmap");
+		return PTR_ERR(sky1src->regmap);
+	}
+
+	sky1src->signals = variant->signals;
+	sky1src->rcdev.owner     = THIS_MODULE;
+	sky1src->rcdev.nr_resets = variant->signals_num;
+	sky1src->rcdev.ops       = &sky1_src_ops;
+	sky1src->rcdev.of_node   = dev->of_node;
+	sky1src->rcdev.dev       = dev;
+
+	return devm_reset_controller_register(dev, &sky1src->rcdev);
+}
+
+static const struct of_device_id sky1_reset_dt_ids[] = {
+	{ .compatible = "cix,sky1-rst", .data = &variant_sky1 },
+	{ .compatible = "cix,sky1-rst-fch", .data = &variant_sky1_fch },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, sky1_reset_dt_ids);
+
+static struct platform_driver sky1_reset_driver = {
+	.probe	= sky1_reset_probe,
+	.driver = {
+		.name		= KBUILD_MODNAME,
+		.of_match_table	= sky1_reset_dt_ids,
+	},
+};
+static int __init reset_sky1_init(void)
+{
+	return platform_driver_register(&sky1_reset_driver);
+}
+subsys_initcall(reset_sky1_init);
+
+static void __exit reset_sky1_exit(void)
+{
+	platform_driver_unregister(&sky1_reset_driver);
+}
+module_exit(reset_sky1_exit);
+
+MODULE_AUTHOR("Jerry Zhu <jerry.zhu@cixtech.com>");
+MODULE_DESCRIPTION("Cix Sky1 reset driver");
+MODULE_LICENSE("GPL");
-- 
2.49.0


