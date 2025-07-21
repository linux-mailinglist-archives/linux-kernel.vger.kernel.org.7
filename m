Return-Path: <linux-kernel+bounces-739482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6018AB0C6CD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EFF417EBB2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B452D8767;
	Mon, 21 Jul 2025 14:45:20 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022100.outbound.protection.outlook.com [52.101.126.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C91B2DD5F3;
	Mon, 21 Jul 2025 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109116; cv=fail; b=D/X/muz2JR+EM7xHKgUiR4cxNDD2Kc9TBbcq93OBKsM2/qZWdc2+eTzLqLu+U0f7QW0l2iYHZe7zhuY6n5sMkeBQGAXe1fBbzZeScL5KKHZ73q0nPf2AFlkEU/VxI7GrWdjiWT+ZD8yvbv8PLF0vYP51mKXbEtdcyxh0aMMS+0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109116; c=relaxed/simple;
	bh=6GXiKSPSaUXzvzgyfM+4PkoCWT2zxKrczcwJTzvERt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5lrPU69XNGY/ADAH3JIUB5NFoN872O16W8jsk1tctZCK6cRXdfnVbuIPlAcUwZq3Rw8G2lNdVbP/0HlqLuT+8tqx6YYCXHJeNRLhdA8KoImOHZjORqKSMWqvTq+nwexV3r9gteRFnLP1cRVdcGX/6R9H47iVz5Y9VoocLxf6Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+nkoUTudgXPeKQQO0WYIAUizt/N6xOUqNxbAR+3owaBjrKwfuVXelwGkdqOhJzLmzhzZLxZsEiHid+7dHSaQhfgDY2szsE9cIbzzPSy5IaJyvuzBriJCHzfa9+nUG4dIjey35k2cSBTS1kO8WwSD1pu46Pti1XkrFoxVrmuMlx/08AUV0Ok5Dw96RQBT5HcgX4xJ8sF6jFExDbGEmiduE1HPu7rxm3fbkoHl0ACYISX+qDaU/FGV2VY5j/8TtOLE/P1iwYbCNG1KxuKKuEa2xzDJuZmE/r9eugcNrbs8l5ciXidAn5tzSteRfB29a9m6hDFQcTqDq+RLpbPZRrqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P70Ukp9ue8V5mL6v6m+fwt6ViMoVO9mWK/3+GO3kpDU=;
 b=qg5X4yeBmd7f1zauSA3sVPdyfRPq61LPMbMWTbLOYcNSo807G1DKc5etfiBXXZtmdQO05XHNiAlJoGDx+BdBKe/sVSUCeGH7t2IChfHWJDscW6jM5oBqdNsK4f5UmLjXeh7qwdfVI4kAdrNwY4+3gUw/xbQh9ss/ev+hDGhiW7du+2MW3MByEKUcnNaUJSJnQ9dDpI5u6p/b1Qsbm72Xexi+H/uzo4w4m3uiqaQuBAwV1fJzcP+Nqc0BOHlPof/DEzqMoP3c+6Oopfz4/z1BJEDoHDlVzx5GuWlf71r7uPHyZo7+WwyW2KizrYsJPXzTD+valz/FnuN+2yBXmqNtNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYBP286CA0039.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:10a::27)
 by OSQPR06MB7277.apcprd06.prod.outlook.com (2603:1096:604:29a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Mon, 21 Jul
 2025 14:45:08 +0000
Received: from TY2PEPF0000AB84.apcprd03.prod.outlook.com
 (2603:1096:404:10a:cafe::79) by TYBP286CA0039.outlook.office365.com
 (2603:1096:404:10a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 14:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB84.mail.protection.outlook.com (10.167.253.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 14:45:07 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id B45BC416050F;
	Mon, 21 Jul 2025 22:45:00 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: soc@lists.linux.dev,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	jassisinghbrar@gmail.com
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	maz@kernel.org,
	sudeep.holla@arm.com,
	kajetan.puchalski@arm.com,
	eballetb@redhat.com,
	Guomin Chen <Guomin.Chen@cixtech.com>,
	Peter Chen <peter.chen@cixtech.com>,
	Gary Yang <gary.yang@cixtech.com>,
	Lihua Liu <Lihua.Liu@cixtech.com>
Subject: [PATCH v11 5/9] mailbox: add CIX mailbox driver
Date: Mon, 21 Jul 2025 22:44:56 +0800
Message-Id: <20250721144500.302202-6-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250721144500.302202-1-peter.chen@cixtech.com>
References: <20250721144500.302202-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB84:EE_|OSQPR06MB7277:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ae68b795-3b78-4ebf-94f1-08ddc8652fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GDQhxzH+JVI0Nud0Dmm3XxrBl6NkZHQudqpof4mhYe7aVxIL8fAG+bxpmCtq?=
 =?us-ascii?Q?tbDZPhbdyQMuj3fHnM70fimEkbc3G71PjC8CRSpTfSXU20kLFzKu4rpCsaWN?=
 =?us-ascii?Q?QNPOID+MxYT6VWMCGUlzZINx2m14qHoQRrxuUhVrRqwB6bBf5VcefmaUgpyp?=
 =?us-ascii?Q?TNWkBtKv/51H+cXzNRJ9ljLc5ljfmuYDFYRyUPwCkjz487EHf02tm5a8RDeT?=
 =?us-ascii?Q?Ps/EmXURH2AtlfpHw0Z0wwGWRtQa7wUyTP7yAvHcUgruobxS39bk0uJu7jun?=
 =?us-ascii?Q?9u/OSX7mR2VwRIkusSY29S/JPRoMPoHSDkLuLplijQbFTVVS98cWKrGrhmUc?=
 =?us-ascii?Q?kdnltjUfNvs9GXW+SQVLvoynCDn2Wb6SDPYZNQdZWgpSYXynyD05SouQEZ/C?=
 =?us-ascii?Q?wUO1MjDvBcjE7qhEc4J+I7oj6HNMHB86znCPjybdmmQXb44pljJCBlee23N/?=
 =?us-ascii?Q?YcTQ5QPRWrNFI1YFPyleIPIgM+8TITMNjbAmyyed0xEQmUBbdmAi4fug2Ssf?=
 =?us-ascii?Q?jAknZ6ThixQ4PEroXHLOX828LBG7cy0oOB2ZnFs7yIK/RcCoMn7Qw8M6hu3e?=
 =?us-ascii?Q?xPaDtFQAvPX3i4bayo/KjWTnJ77txEIG6ZuXS3uNeOtyIXvu/e3tj4vTxX3g?=
 =?us-ascii?Q?LZMr6pszRNTUAT5wSp2WachQvhWl5G77txfAFM3LNAxfNzh20zG1em1AgL/6?=
 =?us-ascii?Q?yh74p/W3XuJsXb64OFEvPWv2pmnK1kkdQcONbuSGPhwoUxLYHUm7ixm7mt5V?=
 =?us-ascii?Q?+iymxCPWmAduIZFaZFs2p4D/PtcaWr3E9KqzbHldw6zwQfveBCMnK+YCCbu3?=
 =?us-ascii?Q?sMHbpPuRhvPuOH/KCjPk7zwKax9qcy5q5IShqiCtxtleq3cocF+xmF8r4r0H?=
 =?us-ascii?Q?WCX6xt2QtbfSxfU71294A9nSk4hKtxoKt0fMgruhnjCnxycY5Bu730JTh1Gr?=
 =?us-ascii?Q?aKF0o2P2tnp3K9XvYexeQo2Gi7XVej/w4MHXlOERgt21k0Y3ok+/6nEUejLj?=
 =?us-ascii?Q?JIm1fSVZ1lXaXMSO3SBrut5vYsdm5GWiXd3CneJqeS83jjlaBSvcvq4HXlni?=
 =?us-ascii?Q?wPvYM6FphVB/vWD8z7WvqtnH0iwNkx47b8WarJySmJaEE2VDvSNKl6uy6m99?=
 =?us-ascii?Q?0NC+GU7H/sHTd62D8g/1dG5lYPFAkH3pyIRrc6U/MXQspdjr4Em4bXkAVixw?=
 =?us-ascii?Q?9PNHMlANmHuIF3OSRthd6fckBfJ18d57nk9MX51uVIFIHRvkjLove5TO5bpT?=
 =?us-ascii?Q?pNhEOHja1ca614MLqBttp3XLR4mTmX4yeSZkJle5kvCBgjzEdqUpntLTe59C?=
 =?us-ascii?Q?5HuVnzB2948Llxv4A33Z+0sa/ktSXYHEyAuFyiBL272Wn2vc19eWFPpz0D0z?=
 =?us-ascii?Q?WztP0XhJiWpfRj+qY76rFUpYHZJzz3qKEIQzjyz7BtBwsy7XvYOFreGzadpF?=
 =?us-ascii?Q?qemMR/L/1drgU9lCGrwvpI8UGGsbJPvhLwu88C8ZfjG86IHt3CmoH8uGRxAa?=
 =?us-ascii?Q?t022t4cQNQc3GywhhTuHjMqksAQ9I6057gOT?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 14:45:07.5040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae68b795-3b78-4ebf-94f1-08ddc8652fe6
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB84.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7277

From: Guomin Chen <Guomin.Chen@cixtech.com>

The CIX mailbox controller, used in the Cix SoCs, like sky1.
facilitates message transmission between multiple processors
within the SoC, such as the AP, PM, audio DSP, SensorHub MCU,
and others.

Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
Reviewed-by: Peter Chen <peter.chen@cixtech.com>
Signed-off-by: Guomin Chen <Guomin.Chen@cixtech.com>
Signed-off-by: Gary Yang <gary.yang@cixtech.com>
Signed-off-by: Lihua Liu <Lihua.Liu@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
Changes for v11:
- Add Jassi Brar's Acked-by tag.

Changes for v10:
- Move macro definitions above where they are used.
- Prefix the macro definition name with CIX.
- Update variable names and remove unused members.
- Fix the misuse of the use_shmem flag.
- Add some comments for use_shmem.

Changes for v9:
- Move macro definitions above where they are used
- Remove the brackets around the number
- Merging and sorting local variable definitions
- free the irq in the error path

Changes for v3 (As mailbox patch set):
- Update MODULE_AUTHOR.
- Remove the extra blank lines.

Changes for v2 (As mailbox patch set):
- Update the real name and email address.
- Remove the ACPI header files.
- Update the Copyright from 2024 to 2025.
- Update the Module License from "GPL" to "GPL v2"
- Add an interface for message length to limit potential out-of-bound access

 drivers/mailbox/Kconfig       |  10 +
 drivers/mailbox/Makefile      |   2 +
 drivers/mailbox/cix-mailbox.c | 645 ++++++++++++++++++++++++++++++++++
 3 files changed, 657 insertions(+)
 create mode 100644 drivers/mailbox/cix-mailbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 68eeed660a4a..4fef4797b110 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -340,4 +340,14 @@ config THEAD_TH1520_MBOX
 	  kernel is running, and E902 core used for power management among other
 	  things.
 
+config CIX_MBOX
+        tristate "CIX Mailbox"
+        depends on ARCH_CIX || COMPILE_TEST
+        depends on OF
+        help
+          Mailbox implementation for CIX IPC system. The controller supports
+          11 mailbox channels with different operating mode and every channel
+          is unidirectional. Say Y here if you want to use the CIX Mailbox
+          support.
+
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 13a3448b3271..786a46587ba1 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -72,3 +72,5 @@ obj-$(CONFIG_QCOM_CPUCP_MBOX)	+= qcom-cpucp-mbox.o
 obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
 
 obj-$(CONFIG_THEAD_TH1520_MBOX)	+= mailbox-th1520.o
+
+obj-$(CONFIG_CIX_MBOX)	+= cix-mailbox.o
diff --git a/drivers/mailbox/cix-mailbox.c b/drivers/mailbox/cix-mailbox.c
new file mode 100644
index 000000000000..5bb1416c26a5
--- /dev/null
+++ b/drivers/mailbox/cix-mailbox.c
@@ -0,0 +1,645 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 Cix Technology Group Co., Ltd.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "mailbox.h"
+
+/*
+ * The maximum transmission size is 32 words or 128 bytes.
+ */
+#define CIX_MBOX_MSG_WORDS	32	/* Max length = 32 words */
+#define CIX_MBOX_MSG_LEN_MASK	0x7fL	/* Max length = 128 bytes */
+
+/* [0~7] Fast channel
+ * [8] doorbell base channel
+ * [9]fifo base channel
+ * [10] register base channel
+ */
+#define CIX_MBOX_FAST_IDX	7
+#define CIX_MBOX_DB_IDX		8
+#define CIX_MBOX_FIFO_IDX	9
+#define CIX_MBOX_REG_IDX	10
+#define CIX_MBOX_CHANS	11
+
+/* Register define */
+#define CIX_REG_MSG(n)	(0x0 + 0x4*(n))			/* 0x0~0x7c */
+#define CIX_REG_DB_ACK	CIX_REG_MSG(CIX_MBOX_MSG_WORDS)	/* 0x80 */
+#define CIX_ERR_COMP	(CIX_REG_DB_ACK + 0x4)		/* 0x84 */
+#define CIX_ERR_COMP_CLR	(CIX_REG_DB_ACK + 0x8)		/* 0x88 */
+#define CIX_REG_F_INT(IDX)	(CIX_ERR_COMP_CLR + 0x4*(IDX+1))	/* 0x8c~0xa8 */
+#define CIX_FIFO_WR		(CIX_REG_F_INT(CIX_MBOX_FAST_IDX+1))	/* 0xac */
+#define CIX_FIFO_RD		(CIX_FIFO_WR + 0x4)			/* 0xb0 */
+#define CIX_FIFO_STAS	(CIX_FIFO_WR + 0x8)			/* 0xb4 */
+#define CIX_FIFO_WM		(CIX_FIFO_WR + 0xc)			/* 0xb8 */
+#define CIX_INT_ENABLE	(CIX_FIFO_WR + 0x10)		/* 0xbc */
+#define CIX_INT_ENABLE_SIDE_B	(CIX_FIFO_WR + 0x14)	/* 0xc0 */
+#define CIX_INT_CLEAR	(CIX_FIFO_WR + 0x18)		/* 0xc4 */
+#define CIX_INT_STATUS	(CIX_FIFO_WR + 0x1c)		/* 0xc8 */
+#define CIX_FIFO_RST	(CIX_FIFO_WR + 0x20)		/* 0xcc */
+
+#define CIX_MBOX_TX		0
+#define CIX_MBOX_RX		1
+
+#define CIX_DB_INT_BIT	BIT(0)
+#define CIX_DB_ACK_INT_BIT	BIT(1)
+
+#define CIX_FIFO_WM_DEFAULT		CIX_MBOX_MSG_WORDS
+#define CIX_FIFO_STAS_WMK		BIT(0)
+#define CIX_FIFO_STAS_FULL		BIT(1)
+#define CIX_FIFO_STAS_EMPTY		BIT(2)
+#define CIX_FIFO_STAS_UFLOW		BIT(3)
+#define CIX_FIFO_STAS_OFLOW		BIT(4)
+
+#define CIX_FIFO_RST_BIT		BIT(0)
+
+#define CIX_DB_INT			BIT(0)
+#define CIX_ACK_INT			BIT(1)
+#define CIX_FIFO_FULL_INT		BIT(2)
+#define CIX_FIFO_EMPTY_INT		BIT(3)
+#define CIX_FIFO_WM01_INT		BIT(4)
+#define CIX_FIFO_WM10_INT		BIT(5)
+#define CIX_FIFO_OFLOW_INT		BIT(6)
+#define CIX_FIFO_UFLOW_INT		BIT(7)
+#define CIX_FIFO_N_EMPTY_INT	BIT(8)
+#define CIX_FAST_CH_INT(IDX)	BIT((IDX)+9)
+
+#define CIX_SHMEM_OFFSET 0x80
+
+enum cix_mbox_chan_type {
+	CIX_MBOX_TYPE_DB,
+	CIX_MBOX_TYPE_REG,
+	CIX_MBOX_TYPE_FIFO,
+	CIX_MBOX_TYPE_FAST,
+};
+
+struct cix_mbox_con_priv {
+	enum cix_mbox_chan_type type;
+	struct mbox_chan	*chan;
+	int index;
+};
+
+struct cix_mbox_priv {
+	struct device *dev;
+	int irq;
+	int dir;
+	void __iomem *base;	/* region for mailbox */
+	struct cix_mbox_con_priv con_priv[CIX_MBOX_CHANS];
+	struct mbox_chan mbox_chans[CIX_MBOX_CHANS];
+	struct mbox_controller mbox;
+	bool use_shmem;
+};
+
+/*
+ * The CIX mailbox supports four types of transfers:
+ * CIX_MBOX_TYPE_DB, CIX_MBOX_TYPE_FAST, CIX_MBOX_TYPE_REG, and CIX_MBOX_TYPE_FIFO.
+ * For the REG and FIFO types of transfers, the message format is as follows:
+ */
+union cix_mbox_msg_reg_fifo {
+	u32 length;	/* unit is byte */
+	u32 buf[CIX_MBOX_MSG_WORDS]; /* buf[0] must be the byte length of this array */
+};
+
+static struct cix_mbox_priv *to_cix_mbox_priv(struct mbox_controller *mbox)
+{
+	return container_of(mbox, struct cix_mbox_priv, mbox);
+}
+
+static void cix_mbox_write(struct cix_mbox_priv *priv, u32 val, u32 offset)
+{
+	if (priv->use_shmem)
+		iowrite32(val, priv->base + offset - CIX_SHMEM_OFFSET);
+	else
+		iowrite32(val, priv->base + offset);
+}
+
+static u32 cix_mbox_read(struct cix_mbox_priv *priv, u32 offset)
+{
+	if (priv->use_shmem)
+		return ioread32(priv->base + offset - CIX_SHMEM_OFFSET);
+	else
+		return ioread32(priv->base + offset);
+}
+
+static bool mbox_fifo_empty(struct mbox_chan *chan)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+
+	return ((cix_mbox_read(priv, CIX_FIFO_STAS) & CIX_FIFO_STAS_EMPTY) ? true : false);
+}
+
+/*
+ *The transmission unit of the CIX mailbox is word.
+ *The byte length should be converted into the word length.
+ */
+static inline u32 mbox_get_msg_size(void *msg)
+{
+	u32 len;
+
+	len = ((u32 *)msg)[0] & CIX_MBOX_MSG_LEN_MASK;
+	return DIV_ROUND_UP(len, 4);
+}
+
+static int cix_mbox_send_data_db(struct mbox_chan *chan, void *data)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+
+	/* trigger doorbell irq */
+	cix_mbox_write(priv, CIX_DB_INT_BIT, CIX_REG_DB_ACK);
+
+	return 0;
+}
+
+static int cix_mbox_send_data_reg(struct mbox_chan *chan, void *data)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	union cix_mbox_msg_reg_fifo *msg = data;
+	u32 len, i;
+
+	if (!data)
+		return -EINVAL;
+
+	len = mbox_get_msg_size(data);
+	for (i = 0; i < len; i++)
+		cix_mbox_write(priv, msg->buf[i], CIX_REG_MSG(i));
+
+	/* trigger doorbell irq */
+	cix_mbox_write(priv, CIX_DB_INT_BIT, CIX_REG_DB_ACK);
+
+	return 0;
+}
+
+static int cix_mbox_send_data_fifo(struct mbox_chan *chan, void *data)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	union cix_mbox_msg_reg_fifo *msg = data;
+	u32 len, val, i;
+
+	if (!data)
+		return -EINVAL;
+
+	len = mbox_get_msg_size(data);
+	cix_mbox_write(priv, len, CIX_FIFO_WM);
+	for (i = 0; i < len; i++)
+		cix_mbox_write(priv, msg->buf[i], CIX_FIFO_WR);
+
+	/* Enable fifo empty interrupt */
+	val = cix_mbox_read(priv, CIX_INT_ENABLE);
+	val |= CIX_FIFO_EMPTY_INT;
+	cix_mbox_write(priv, val, CIX_INT_ENABLE);
+
+	return 0;
+}
+
+static int cix_mbox_send_data_fast(struct mbox_chan *chan, void *data)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	struct cix_mbox_con_priv *cp = chan->con_priv;
+	u32 *arg = (u32 *)data;
+	int index = cp->index;
+
+	if (!data)
+		return -EINVAL;
+
+	if (index < 0 || index > CIX_MBOX_FAST_IDX) {
+		dev_err(priv->dev, "Invalid Mbox index %d\n", index);
+		return -EINVAL;
+	}
+
+	cix_mbox_write(priv, arg[0], CIX_REG_F_INT(index));
+
+	return 0;
+}
+
+static int cix_mbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	struct cix_mbox_con_priv *cp = chan->con_priv;
+
+	if (priv->dir != CIX_MBOX_TX) {
+		dev_err(priv->dev, "Invalid Mbox dir %d\n", priv->dir);
+		return -EINVAL;
+	}
+
+	switch (cp->type) {
+	case CIX_MBOX_TYPE_DB:
+		cix_mbox_send_data_db(chan, data);
+		break;
+	case CIX_MBOX_TYPE_REG:
+		cix_mbox_send_data_reg(chan, data);
+		break;
+	case CIX_MBOX_TYPE_FIFO:
+		cix_mbox_send_data_fifo(chan, data);
+		break;
+	case CIX_MBOX_TYPE_FAST:
+		cix_mbox_send_data_fast(chan, data);
+		break;
+	default:
+		dev_err(priv->dev, "Invalid channel type: %d\n", cp->type);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void cix_mbox_isr_db(struct mbox_chan *chan)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	u32 int_status;
+
+	int_status = cix_mbox_read(priv, CIX_INT_STATUS);
+
+	if (priv->dir == CIX_MBOX_RX) {
+		/* rx interrupt is triggered */
+		if (int_status & CIX_DB_INT) {
+			cix_mbox_write(priv, CIX_DB_INT, CIX_INT_CLEAR);
+			mbox_chan_received_data(chan, NULL);
+			/* trigger ack interrupt */
+			cix_mbox_write(priv, CIX_DB_ACK_INT_BIT, CIX_REG_DB_ACK);
+		}
+	} else {
+		/* tx ack interrupt is triggered */
+		if (int_status & CIX_ACK_INT) {
+			cix_mbox_write(priv, CIX_ACK_INT, CIX_INT_CLEAR);
+			mbox_chan_received_data(chan, NULL);
+		}
+	}
+}
+
+static void cix_mbox_isr_reg(struct mbox_chan *chan)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	u32 int_status;
+
+	int_status = cix_mbox_read(priv, CIX_INT_STATUS);
+
+	if (priv->dir == CIX_MBOX_RX) {
+		/* rx interrupt is triggered */
+		if (int_status & CIX_DB_INT) {
+			u32 data[CIX_MBOX_MSG_WORDS], len, i;
+
+			cix_mbox_write(priv, CIX_DB_INT, CIX_INT_CLEAR);
+			data[0] = cix_mbox_read(priv, CIX_REG_MSG(0));
+			len = mbox_get_msg_size(data);
+			for (i = 1; i < len; i++)
+				data[i] = cix_mbox_read(priv, CIX_REG_MSG(i));
+
+			/* trigger ack interrupt */
+			cix_mbox_write(priv, CIX_DB_ACK_INT_BIT, CIX_REG_DB_ACK);
+			mbox_chan_received_data(chan, data);
+		}
+	} else {
+		/* tx ack interrupt is triggered */
+		if (int_status & CIX_ACK_INT) {
+			cix_mbox_write(priv, CIX_ACK_INT, CIX_INT_CLEAR);
+			mbox_chan_txdone(chan, 0);
+		}
+	}
+}
+
+static void cix_mbox_isr_fifo(struct mbox_chan *chan)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	u32 int_status, status;
+
+	int_status = cix_mbox_read(priv, CIX_INT_STATUS);
+
+	if (priv->dir == CIX_MBOX_RX) {
+		/* FIFO waterMark interrupt is generated */
+		if (int_status & (CIX_FIFO_FULL_INT | CIX_FIFO_WM01_INT)) {
+			u32 data[CIX_MBOX_MSG_WORDS] = { 0 }, i = 0;
+
+			cix_mbox_write(priv, (CIX_FIFO_FULL_INT | CIX_FIFO_WM01_INT),
+						CIX_INT_CLEAR);
+			do {
+				data[i++] = cix_mbox_read(priv, CIX_FIFO_RD);
+			} while (!mbox_fifo_empty(chan) && i < CIX_MBOX_MSG_WORDS);
+
+			mbox_chan_received_data(chan, data);
+		}
+		/* FIFO underflow is generated */
+		if (int_status & CIX_FIFO_UFLOW_INT) {
+			status = cix_mbox_read(priv, CIX_FIFO_STAS);
+			dev_err(priv->dev, "fifo underflow: int_stats %d\n", status);
+			cix_mbox_write(priv, CIX_FIFO_UFLOW_INT, CIX_INT_CLEAR);
+		}
+	} else {
+		/* FIFO empty interrupt is generated */
+		if (int_status & CIX_FIFO_EMPTY_INT) {
+			u32 val;
+
+			cix_mbox_write(priv, CIX_FIFO_EMPTY_INT, CIX_INT_CLEAR);
+			/* Disable empty irq*/
+			val = cix_mbox_read(priv, CIX_INT_ENABLE);
+			val &= ~CIX_FIFO_EMPTY_INT;
+			cix_mbox_write(priv, val, CIX_INT_ENABLE);
+			mbox_chan_txdone(chan, 0);
+		}
+		/* FIFO overflow is generated */
+		if (int_status & CIX_FIFO_OFLOW_INT) {
+			status = cix_mbox_read(priv, CIX_FIFO_STAS);
+			dev_err(priv->dev, "fifo overlow: int_stats %d\n", status);
+			cix_mbox_write(priv, CIX_FIFO_OFLOW_INT, CIX_INT_CLEAR);
+		}
+	}
+}
+
+static void cix_mbox_isr_fast(struct mbox_chan *chan)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	struct cix_mbox_con_priv *cp = chan->con_priv;
+	u32 int_status, data;
+
+	/* no irq will be trigger for TX dir mbox */
+	if (priv->dir != CIX_MBOX_RX)
+		return;
+
+	int_status = cix_mbox_read(priv, CIX_INT_STATUS);
+
+	if (int_status & CIX_FAST_CH_INT(cp->index)) {
+		cix_mbox_write(priv, CIX_FAST_CH_INT(cp->index), CIX_INT_CLEAR);
+		data = cix_mbox_read(priv, CIX_REG_F_INT(cp->index));
+		mbox_chan_received_data(chan, &data);
+	}
+}
+
+static irqreturn_t cix_mbox_isr(int irq, void *arg)
+{
+	struct mbox_chan *chan = arg;
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	struct cix_mbox_con_priv *cp = chan->con_priv;
+
+	switch (cp->type) {
+	case CIX_MBOX_TYPE_DB:
+		cix_mbox_isr_db(chan);
+		break;
+	case CIX_MBOX_TYPE_REG:
+		cix_mbox_isr_reg(chan);
+		break;
+	case CIX_MBOX_TYPE_FIFO:
+		cix_mbox_isr_fifo(chan);
+		break;
+	case CIX_MBOX_TYPE_FAST:
+		cix_mbox_isr_fast(chan);
+		break;
+	default:
+		dev_err(priv->dev, "Invalid channel type: %d\n", cp->type);
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int cix_mbox_startup(struct mbox_chan *chan)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	struct cix_mbox_con_priv *cp = chan->con_priv;
+	int index = cp->index, ret;
+	u32 val;
+
+	ret = request_irq(priv->irq, cix_mbox_isr, 0,
+			  dev_name(priv->dev), chan);
+	if (ret) {
+		dev_err(priv->dev, "Unable to acquire IRQ %d\n", priv->irq);
+		return ret;
+	}
+
+	switch (cp->type) {
+	case CIX_MBOX_TYPE_DB:
+		/* Overwrite txdone_method for DB channel */
+		chan->txdone_method = TXDONE_BY_ACK;
+		fallthrough;
+	case CIX_MBOX_TYPE_REG:
+		if (priv->dir == CIX_MBOX_TX) {
+			/* Enable ACK interrupt */
+			val = cix_mbox_read(priv, CIX_INT_ENABLE);
+			val |= CIX_ACK_INT;
+			cix_mbox_write(priv, val, CIX_INT_ENABLE);
+		} else {
+			/* Enable Doorbell interrupt */
+			val = cix_mbox_read(priv, CIX_INT_ENABLE_SIDE_B);
+			val |= CIX_DB_INT;
+			cix_mbox_write(priv, val, CIX_INT_ENABLE_SIDE_B);
+		}
+		break;
+	case CIX_MBOX_TYPE_FIFO:
+		/* reset fifo */
+		cix_mbox_write(priv, CIX_FIFO_RST_BIT, CIX_FIFO_RST);
+		/* set default watermark */
+		cix_mbox_write(priv, CIX_FIFO_WM_DEFAULT, CIX_FIFO_WM);
+		if (priv->dir == CIX_MBOX_TX) {
+			/* Enable fifo overflow interrupt */
+			val = cix_mbox_read(priv, CIX_INT_ENABLE);
+			val |= CIX_FIFO_OFLOW_INT;
+			cix_mbox_write(priv, val, CIX_INT_ENABLE);
+		} else {
+			/* Enable fifo full/underflow interrupt */
+			val = cix_mbox_read(priv, CIX_INT_ENABLE_SIDE_B);
+			val |= CIX_FIFO_UFLOW_INT|CIX_FIFO_WM01_INT;
+			cix_mbox_write(priv, val, CIX_INT_ENABLE_SIDE_B);
+		}
+		break;
+	case CIX_MBOX_TYPE_FAST:
+		/* Only RX channel has intterupt */
+		if (priv->dir == CIX_MBOX_RX) {
+			if (index < 0 || index > CIX_MBOX_FAST_IDX) {
+				dev_err(priv->dev, "Invalid index %d\n", index);
+				ret = -EINVAL;
+				goto failed;
+			}
+			/* enable fast channel interrupt */
+			val = cix_mbox_read(priv, CIX_INT_ENABLE_SIDE_B);
+			val |= CIX_FAST_CH_INT(index);
+			cix_mbox_write(priv, val, CIX_INT_ENABLE_SIDE_B);
+		}
+		break;
+	default:
+		dev_err(priv->dev, "Invalid channel type: %d\n", cp->type);
+		ret = -EINVAL;
+		goto failed;
+	}
+	return 0;
+
+failed:
+	free_irq(priv->irq, chan);
+	return ret;
+}
+
+static void cix_mbox_shutdown(struct mbox_chan *chan)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	struct cix_mbox_con_priv *cp = chan->con_priv;
+	int index = cp->index;
+	u32 val;
+
+	switch (cp->type) {
+	case CIX_MBOX_TYPE_DB:
+	case CIX_MBOX_TYPE_REG:
+		if (priv->dir == CIX_MBOX_TX) {
+			/* Disable ACK interrupt */
+			val = cix_mbox_read(priv, CIX_INT_ENABLE);
+			val &= ~CIX_ACK_INT;
+			cix_mbox_write(priv, val, CIX_INT_ENABLE);
+		} else if (priv->dir == CIX_MBOX_RX) {
+			/* Disable Doorbell interrupt */
+			val = cix_mbox_read(priv, CIX_INT_ENABLE_SIDE_B);
+			val &= ~CIX_DB_INT;
+			cix_mbox_write(priv, val, CIX_INT_ENABLE_SIDE_B);
+		}
+		break;
+	case CIX_MBOX_TYPE_FIFO:
+		if (priv->dir == CIX_MBOX_TX) {
+			/* Disable empty/fifo overflow irq*/
+			val = cix_mbox_read(priv, CIX_INT_ENABLE);
+			val &= ~(CIX_FIFO_EMPTY_INT | CIX_FIFO_OFLOW_INT);
+			cix_mbox_write(priv, val, CIX_INT_ENABLE);
+		} else if (priv->dir == CIX_MBOX_RX) {
+			/* Disable fifo WM01/underflow interrupt */
+			val = cix_mbox_read(priv, CIX_INT_ENABLE_SIDE_B);
+			val &= ~(CIX_FIFO_UFLOW_INT | CIX_FIFO_WM01_INT);
+			cix_mbox_write(priv, val, CIX_INT_ENABLE_SIDE_B);
+		}
+		break;
+	case CIX_MBOX_TYPE_FAST:
+		if (priv->dir == CIX_MBOX_RX) {
+			if (index < 0 || index > CIX_MBOX_FAST_IDX) {
+				dev_err(priv->dev, "Invalid index %d\n", index);
+				break;
+			}
+			/* Disable fast channel interrupt */
+			val = cix_mbox_read(priv, CIX_INT_ENABLE_SIDE_B);
+			val &= ~CIX_FAST_CH_INT(index);
+			cix_mbox_write(priv, val, CIX_INT_ENABLE_SIDE_B);
+		}
+		break;
+
+	default:
+		dev_err(priv->dev, "Invalid channel type: %d\n", cp->type);
+		break;
+	}
+
+	free_irq(priv->irq, chan);
+}
+
+static const struct mbox_chan_ops cix_mbox_chan_ops = {
+	.send_data = cix_mbox_send_data,
+	.startup = cix_mbox_startup,
+	.shutdown = cix_mbox_shutdown,
+};
+
+static void cix_mbox_init(struct cix_mbox_priv *priv)
+{
+	struct cix_mbox_con_priv *cp;
+	int i;
+
+	for (i = 0; i < CIX_MBOX_CHANS; i++) {
+		cp = &priv->con_priv[i];
+		cp->index = i;
+		cp->chan = &priv->mbox_chans[i];
+		priv->mbox_chans[i].con_priv = cp;
+		if (cp->index <= CIX_MBOX_FAST_IDX)
+			cp->type = CIX_MBOX_TYPE_FAST;
+		if (cp->index == CIX_MBOX_DB_IDX)
+			cp->type = CIX_MBOX_TYPE_DB;
+		if (cp->index == CIX_MBOX_FIFO_IDX)
+			cp->type = CIX_MBOX_TYPE_FIFO;
+		if (cp->index == CIX_MBOX_REG_IDX)
+			cp->type = CIX_MBOX_TYPE_REG;
+	}
+}
+
+static int cix_mbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cix_mbox_priv *priv;
+	struct resource *res;
+	const char *dir_str;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	/*
+	 * The first 0x80 bytes of the register space of the cix mailbox controller
+	 * can be used as shared memory for clients. When this shared memory is in
+	 * use, the base address of the mailbox is offset by 0x80. Therefore, when
+	 * performing subsequent read/write operations, it is necessary to subtract
+	 * the offset CIX_SHMEM_OFFSET.
+	 *
+	 * When the base address of the mailbox is offset by 0x80, it indicates
+	 * that shmem is in use.
+	 */
+	priv->use_shmem = !!(res->start & CIX_SHMEM_OFFSET);
+
+	priv->irq = platform_get_irq(pdev, 0);
+	if (priv->irq < 0)
+		return priv->irq;
+
+	if (device_property_read_string(dev, "cix,mbox-dir", &dir_str)) {
+		dev_err(priv->dev, "cix,mbox_dir property not found\n");
+		return -EINVAL;
+	}
+
+	if (!strcmp(dir_str, "tx"))
+		priv->dir = 0;
+	else if (!strcmp(dir_str, "rx"))
+		priv->dir = 1;
+	else {
+		dev_err(priv->dev, "cix,mbox_dir=%s is not expected\n", dir_str);
+		return -EINVAL;
+	}
+
+	cix_mbox_init(priv);
+
+	priv->mbox.dev = dev;
+	priv->mbox.ops = &cix_mbox_chan_ops;
+	priv->mbox.chans = priv->mbox_chans;
+	priv->mbox.txdone_irq = true;
+	priv->mbox.num_chans = CIX_MBOX_CHANS;
+	priv->mbox.of_xlate = NULL;
+
+	platform_set_drvdata(pdev, priv);
+	ret = devm_mbox_controller_register(dev, &priv->mbox);
+	if (ret)
+		dev_err(dev, "Failed to register mailbox %d\n", ret);
+
+	return ret;
+}
+
+static const struct of_device_id cix_mbox_dt_ids[] = {
+	{ .compatible = "cix,sky1-mbox" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, cix_mbox_dt_ids);
+
+static struct platform_driver cix_mbox_driver = {
+	.probe = cix_mbox_probe,
+	.driver = {
+		.name = "cix_mbox",
+		.of_match_table = cix_mbox_dt_ids,
+	},
+};
+
+static int __init cix_mailbox_init(void)
+{
+	return platform_driver_register(&cix_mbox_driver);
+}
+arch_initcall(cix_mailbox_init);
+
+MODULE_AUTHOR("Cix Technology Group Co., Ltd.");
+MODULE_DESCRIPTION("CIX mailbox driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


