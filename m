Return-Path: <linux-kernel+bounces-604480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFF4A894FB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 09:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E648F189A100
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 07:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FBC27FD5F;
	Tue, 15 Apr 2025 07:27:37 +0000 (UTC)
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021116.outbound.protection.outlook.com [52.101.129.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB63275114;
	Tue, 15 Apr 2025 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702054; cv=fail; b=H8kRdIAO1Ay6GSpQ2sZ2NK4hTa3fkbdR+UmDRw9vPoPEkn6jiAoDzmGk9C1sapodWVlBYg8JKlMM41UArDNl2xQ5t9YL2Q+IXkEA1Dd1Gm0x1Bjk9wMu2/KQT6ynzLycNzhUUP/QSYqYGacW/0k/hlN/ic/Gf5HsRQFEUdkzbOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702054; c=relaxed/simple;
	bh=W1aLi1HGZa3/6ge0k4R6bq139Zfp3sz3R1/TvbZSP+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mM8rcvgtge7nfpeoRTUNf+Ywa0Y89gQBCTl+sJNg+cFlTn3sUhELIo7MM/tanYX9bV74KloSwJhfcK6jHK1OAPhMuYN9Xe9Kdmvwc4tA9y6nbjL6gz0KvZrh2cd4wnHuGODLz3MJhCXZIvHuj+sfovgNreqhzNIYmzuDmZGjzUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.129.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHD0jCbnN18VoAKkCv3uVrzrB5XHRzMHX1iE8NZgMhlSBYYk1EZVs1GBgxP8JLjFscx5rTf3Y60dLK7yUYXuxltdy+oTCkKf7nWd19J+/xy4XJj1I5Pltaf0Ag6huR2032MicS/JosW6RAE5dAFt3aIUL9ze8618SKP0qYVA/gGr1aAUJ8IJdFtJnqZvGQYrZ69ET3CE0AA0XJyZAVRqp1nvPpumCl72szBVHcjQHDAs1He8uNB8k7mrGQW24okrcvUfEBcHSRjbdeQuWiDYDFtvTDxuTE51d1LigVjkwbUAvvbNHz3R2tpc5Xslhtt7ERjusaFqosZttaGBawkjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlMqcEH7ICwHImMStA5irWbQciEXISsBuQLSmJqXM7I=;
 b=bmd/QupzwGnBYI/2GGrI4O5XVc1bHWLL4VglLzDQBowp/dtYz+tY22gYmhN7DzpdfmIwzyjJhySniret4umwyXM/HjVp9M82l6t6uDd+omNDItyh53xyk7uLEus4hVqyM2kfVEbpi+AK1kP4EnfycPl6xgJr33mqCU+s1eXEHQE/KwMNPe8vi0ii6BgXQNdiDv44En7i06PKGfSL+i/bI3ya/zprZHqIBSkmHce8eLv7RUK/786DbVkruit4gmWG/Mw6cH4qtTbBGhE2xjIX9rSltX3750rr0H2AV0z9ipjDug/7Rlu02Okrl7FcECXRXN7rbdXUFx++iLp3crf9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCPR01CA0173.jpnprd01.prod.outlook.com (2603:1096:400:2b2::11)
 by TY1PPF72AEE94FE.apcprd06.prod.outlook.com (2603:1096:408::91a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 07:27:26 +0000
Received: from TY2PEPF0000AB83.apcprd03.prod.outlook.com
 (2603:1096:400:2b2:cafe::30) by TYCPR01CA0173.outlook.office365.com
 (2603:1096:400:2b2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Tue,
 15 Apr 2025 07:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB83.mail.protection.outlook.com (10.167.253.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 07:27:25 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id D5B0A4160CA9;
	Tue, 15 Apr 2025 15:27:24 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: soc@kernel.org,
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
	kajetan.puchalski@arm.com,
	Guomin Chen <Guomin.Chen@cixtech.com>,
	Peter Chen <peter.chen@cixtech.com>,
	Gary Yang <gary.yang@cixtech.com>,
	Lihua Liu <Lihua.Liu@cixtech.com>
Subject: [PATCH v6 06/10] mailbox: add CIX mailbox driver
Date: Tue, 15 Apr 2025 15:27:20 +0800
Message-Id: <20250415072724.3565533-7-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415072724.3565533-1-peter.chen@cixtech.com>
References: <20250415072724.3565533-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB83:EE_|TY1PPF72AEE94FE:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 20d9a251-78a4-4485-8340-08dd7beef89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FvPCPqSbgs7dimoft/ZYSllW6+rXykjXQb6AhJBBBUSF7a6cfPe/V+MSTpDn?=
 =?us-ascii?Q?SGSmvdZNilyMN+bfLUwTkR8B1PMOUgAtstEsXh18UlWT9Sh25tMMDPL5L85G?=
 =?us-ascii?Q?y7fj7SY1EKH61JzluP6ZMbqaV2IxK+PSDBUL+fg4GaVMRP1Aa6/xTVNxKkkM?=
 =?us-ascii?Q?bpNE0nUfqPWjuNh2YY7wdWxEjzPJNMa8Uf1KUeewp9gHIW5Ne7SYZ0z+Sa9J?=
 =?us-ascii?Q?LnQ0zCyePj27voVz4uxir7CbnCO7iKX4U8j0qmcVRQksNtBOLdLeA6dY20Ba?=
 =?us-ascii?Q?EQBgVoHGYMEyMnA1bfbLNyjuwZXstVEPAazxGSx9vDu3qVufl7+hXTH4Zo5s?=
 =?us-ascii?Q?JJu+jlXIqP7Un7CzH/wRCMdYqa1PcvhlWRtD8J/DegOIwkZW2f1X7jWuJ74R?=
 =?us-ascii?Q?GAdvSrYxzf3eiam+mn2pLk54sjeJ0HRs8K6tUHhzfuA+oMiLGY24AD4kmKMS?=
 =?us-ascii?Q?98X6MEgBOfNs5ExoVmY2jpltDoY0qfhyHMhCyrSJ1w6alRhApokakHUYhWBS?=
 =?us-ascii?Q?M4PnVDG//8OEJnYMV3cLKnuHL+zczAic1fjHvnhB8YvI14X4O7/VerP1hBUr?=
 =?us-ascii?Q?tj9FKCpbv0+XkD+KP7C4AL7bZkXYx2FtFnjnQx4g/f10THMGuyky33qaXeOb?=
 =?us-ascii?Q?4HiaBaacUqxc7PF/C/MFXVX2JecGq4jGjrD0p7+k6paI5pgrX/JRRllKT3YI?=
 =?us-ascii?Q?SEKSk+YWytrkyDNvbUBdyNc1fKFXSQOCq0BqV6/+ilOo4/oPm/uAKiQnzA1P?=
 =?us-ascii?Q?Hxj1JM60qxUcIBbB6zDcluzv4bJtt/QPTXHGlkJkcsR/lHKHWms+SNi8p3Fb?=
 =?us-ascii?Q?tblGV9v/l62SxJs34p2p7nm35icd8azCU9EZd+JD/9jFFUWlBwM9Gg7M9Ean?=
 =?us-ascii?Q?0x1uVnrvfZRxujV1XJG4rp5ZHeWkjhwWqZLmwgJaIgzOerBetgELdK6R2ZVZ?=
 =?us-ascii?Q?ctNb3ENW6P14TCqAt+0q/i0GBCKIgXBVZnm3dWZgukwYehFK7rTsc2XCpCcj?=
 =?us-ascii?Q?hRR5au6Vjg25tljI1+8rmlEDsJ3Kc0L1EnWeoPbUGiR+w2yKWElv/OrZFvzz?=
 =?us-ascii?Q?f4Y4Sve002h7XgNZEDUa/5+Mtp92UZCXyim+GOCln1qG1hfJPxB2culYU8c0?=
 =?us-ascii?Q?GaJYt1vUNAB0ZgFsy2eSUBHQIhBxfikK/+yWrV62sIf2xZSJCYnFlvxCTPlk?=
 =?us-ascii?Q?kKetAYf5rNdz9186NQQGbKrVwPVsLwOqMAEyDyEYne19TqKokXkIKxHuZ9oy?=
 =?us-ascii?Q?KVarxrLK5VLa8bxIODAUIJms91UrxoeJl+JwYUTgg7EkggOaPbdI1qgHlFod?=
 =?us-ascii?Q?9/xEvaYvLZNRUR5ABfULeP7cMn8mTCAH1OuHgVnglM9J7bVg+KaojfDi8vz/?=
 =?us-ascii?Q?qNKxrDzN12Qy3XyOJeQpsjj9ER2j/goFXx6JggMNXiO+d4JwDBN42oqgaU6R?=
 =?us-ascii?Q?n2VYVZ34OsMaub1ZkTgaKExS2jV2BhgaOLhNnCccsP5uK1yWuaco3KNuhzXe?=
 =?us-ascii?Q?aMyveE5Ye7zXwlGE6ig2eimFnG0a1htIICdF?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 07:27:25.7638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d9a251-78a4-4485-8340-08dd7beef89d
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB83.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF72AEE94FE

From: Guomin Chen <Guomin.Chen@cixtech.com>

The CIX mailbox controller, used in the Cix SoCs, like sky1.
facilitates message transmission between multiple processors
within the SoC, such as the AP, PM, audio DSP, SensorHub MCU,
and others.

Reviewed-by: Peter Chen <peter.chen@cixtech.com>
Signed-off-by: Gary Yang <gary.yang@cixtech.com>
Signed-off-by: Lihua Liu <Lihua.Liu@cixtech.com>
Signed-off-by: Guomin Chen <Guomin.Chen@cixtech.com>
---
Changes for v6:
- Add support for differentiating mailboxs, some's io space are
used by scmi share memory

Changes for v3:
- Fixed some code style issues in the driver

 drivers/mailbox/Kconfig       |  10 +
 drivers/mailbox/Makefile      |   2 +
 drivers/mailbox/cix-mailbox.c | 632 ++++++++++++++++++++++++++++++++++
 3 files changed, 644 insertions(+)
 create mode 100644 drivers/mailbox/cix-mailbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index ed52db272f4d..3231facf03b2 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -330,4 +330,14 @@ config THEAD_TH1520_MBOX
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
index 9a1542b55539..97a5a7068c10 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -70,3 +70,5 @@ obj-$(CONFIG_QCOM_CPUCP_MBOX)	+= qcom-cpucp-mbox.o
 obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
 
 obj-$(CONFIG_THEAD_TH1520_MBOX)	+= mailbox-th1520.o
+
+obj-$(CONFIG_CIX_MBOX)	+= cix-mailbox.o
diff --git a/drivers/mailbox/cix-mailbox.c b/drivers/mailbox/cix-mailbox.c
new file mode 100644
index 000000000000..c2783dd7d145
--- /dev/null
+++ b/drivers/mailbox/cix-mailbox.c
@@ -0,0 +1,632 @@
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
+/* Register define */
+#define REG_MSG(n)	(0x0 + 0x4*(n))			/* 0x0~0x7c */
+#define REG_DB_ACK	REG_MSG(CIX_MBOX_MSG_LEN)	/* 0x80 */
+#define ERR_COMP	(REG_DB_ACK + 0x4)		/* 0x84 */
+#define ERR_COMP_CLR	(REG_DB_ACK + 0x8)		/* 0x88 */
+#define REG_F_INT(IDX)	(ERR_COMP_CLR + 0x4*(IDX+1))	/* 0x8c~0xa8 */
+#define FIFO_WR		(REG_F_INT(MBOX_FAST_IDX+1))	/* 0xac */
+#define FIFO_RD		(FIFO_WR + 0x4)			/* 0xb0 */
+#define FIFO_STAS	(FIFO_WR + 0x8)			/* 0xb4 */
+#define FIFO_WM		(FIFO_WR + 0xc)			/* 0xb8 */
+#define INT_ENABLE	(FIFO_WR + 0x10)		/* 0xbc */
+#define INT_ENABLE_SIDE_B	(FIFO_WR + 0x14)	/* 0xc0 */
+#define INT_CLEAR	(FIFO_WR + 0x18)		/* 0xc4 */
+#define INT_STATUS	(FIFO_WR + 0x1c)		/* 0xc8 */
+#define FIFO_RST	(FIFO_WR + 0x20)		/* 0xcc */
+
+/* [0~7] Fast channel
+ * [8] doorbell base channel
+ * [9]fifo base channel
+ * [10] register base channel
+ */
+#define CIX_MBOX_CHANS		(11)
+
+/*
+ * The maximum transmission size is 32 words or 128 bytes.
+ */
+#define CIX_MBOX_MSG_LEN	(32)	/* Max length = 32 words */
+#define MBOX_MSG_LEN_MASK	(0x7fL)	/* Max length = 128 bytes */
+
+#define MBOX_FAST_IDX		(7)
+#define MBOX_DB_IDX		(8)
+#define MBOX_FIFO_IDX		(9)
+#define MBOX_REG_IDX		(10)
+
+#define MBOX_TX		(0)
+#define MBOX_RX		(1)
+
+#define DB_INT_BIT	BIT(0)
+#define DB_ACK_INT_BIT	BIT(1)
+
+#define FIFO_WM_DEFAULT		CIX_MBOX_MSG_LEN
+#define FIFO_STAS_WMK		BIT(0)
+#define FIFO_STAS_FULL		BIT(1)
+#define FIFO_STAS_EMPTY		BIT(2)
+#define FIFO_STAS_UFLOW		BIT(3)
+#define FIFO_STAS_OFLOW		BIT(4)
+
+#define FIFO_RST_BIT		BIT(0)
+
+#define DB_INT			BIT(0)
+#define ACK_INT			BIT(1)
+#define FIFO_FULL_INT		BIT(2)
+#define FIFO_EMPTY_INT		BIT(3)
+#define FIFO_WM01_INT		BIT(4)
+#define FIFO_WM10_INT		BIT(5)
+#define FIFO_OFLOW_INT		BIT(6)
+#define FIFO_UFLOW_INT		BIT(7)
+#define FIFO_N_EMPTY_INT	BIT(8)
+#define FAST_CH_INT(IDX)	BIT((IDX)+9)
+
+#define SHMEM_OFFSET 0x80
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
+	bool tx_irq_mode;	/* flag of enabling tx's irq mode */
+	void __iomem *base;	/* region for mailbox */
+	unsigned int chan_num;
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
+	u32 buf[CIX_MBOX_MSG_LEN]; /* buf[0] must be the byte length of this array */
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
+		iowrite32(val, priv->base + offset - SHMEM_OFFSET);
+	else
+		iowrite32(val, priv->base + offset);
+}
+
+static u32 cix_mbox_read(struct cix_mbox_priv *priv, u32 offset)
+{
+	if (priv->use_shmem)
+		return ioread32(priv->base + offset - SHMEM_OFFSET);
+	else
+		return ioread32(priv->base + offset);
+}
+
+static bool mbox_fifo_empty(struct mbox_chan *chan)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+
+	return ((cix_mbox_read(priv, FIFO_STAS) & FIFO_STAS_EMPTY) ? true : false);
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
+	len = ((u32 *)msg)[0] & MBOX_MSG_LEN_MASK;
+	return DIV_ROUND_UP(len, 4);
+}
+
+static int cix_mbox_send_data_db(struct mbox_chan *chan, void *data)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+
+	/* trigger doorbell irq */
+	cix_mbox_write(priv, DB_INT_BIT, REG_DB_ACK);
+
+	return 0;
+}
+
+static int cix_mbox_send_data_reg(struct mbox_chan *chan, void *data)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	int i;
+	union cix_mbox_msg_reg_fifo *msg = data;
+	u32 len;
+
+	if (!data)
+		return -EINVAL;
+
+	len = mbox_get_msg_size(data);
+	for (i = 0; i < len; i++)
+		cix_mbox_write(priv, msg->buf[i], REG_MSG(i));
+
+	/* trigger doorbell irq */
+	cix_mbox_write(priv, DB_INT_BIT, REG_DB_ACK);
+
+	return 0;
+}
+
+static int cix_mbox_send_data_fifo(struct mbox_chan *chan, void *data)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	int i;
+	union cix_mbox_msg_reg_fifo *msg = data;
+	u32 len, val_32;
+
+	if (!data)
+		return -EINVAL;
+
+	len = mbox_get_msg_size(data);
+	cix_mbox_write(priv, len, FIFO_WM);
+	for (i = 0; i < len; i++)
+		cix_mbox_write(priv, msg->buf[i], FIFO_WR);
+
+	/* Enable fifo empty interrupt */
+	val_32 = cix_mbox_read(priv, INT_ENABLE);
+	val_32 |= FIFO_EMPTY_INT;
+	cix_mbox_write(priv, val_32, INT_ENABLE);
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
+	if (index < 0 || index > MBOX_FAST_IDX) {
+		dev_err(priv->dev, "Invalid Mbox index %d\n", index);
+		return -EINVAL;
+	}
+
+	cix_mbox_write(priv, arg[0], REG_F_INT(index));
+
+	return 0;
+}
+
+static int cix_mbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	struct cix_mbox_con_priv *cp = chan->con_priv;
+
+	if (priv->dir != MBOX_TX) {
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
+	int_status = cix_mbox_read(priv, INT_STATUS);
+
+	if (priv->dir == MBOX_RX) {
+		/* rx interrupt is triggered */
+		if (int_status & DB_INT) {
+			cix_mbox_write(priv, DB_INT, INT_CLEAR);
+			mbox_chan_received_data(chan, NULL);
+			/* trigger ack interrupt */
+			cix_mbox_write(priv, DB_ACK_INT_BIT, REG_DB_ACK);
+		}
+	} else {
+		/* tx ack interrupt is triggered */
+		if (int_status & ACK_INT) {
+			cix_mbox_write(priv, ACK_INT, INT_CLEAR);
+			mbox_chan_received_data(chan, NULL);
+		}
+	}
+}
+
+static void cix_mbox_isr_reg(struct mbox_chan *chan)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	u32 int_status;
+	u32 data[CIX_MBOX_MSG_LEN];
+	int i;
+	u32 len;
+
+	int_status = cix_mbox_read(priv, INT_STATUS);
+
+	if (priv->dir == MBOX_RX) {
+		/* rx interrupt is triggered */
+		if (int_status & DB_INT) {
+			cix_mbox_write(priv, DB_INT, INT_CLEAR);
+			data[0] = cix_mbox_read(priv, REG_MSG(0));
+			len = mbox_get_msg_size(data);
+			for (i = 0; i < len; i++)
+				data[i] = cix_mbox_read(priv, REG_MSG(i));
+
+			/* trigger ack interrupt */
+			cix_mbox_write(priv, DB_ACK_INT_BIT, REG_DB_ACK);
+			mbox_chan_received_data(chan, data);
+		}
+	} else {
+		/* tx ack interrupt is triggered */
+		if (int_status & ACK_INT) {
+			cix_mbox_write(priv, ACK_INT, INT_CLEAR);
+			mbox_chan_txdone(chan, 0);
+		}
+	}
+}
+
+static void cix_mbox_isr_fifo(struct mbox_chan *chan)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	u32 data[CIX_MBOX_MSG_LEN] = { 0 };
+	int i = 0;
+	u32 int_status, status, val_32;
+
+	int_status = cix_mbox_read(priv, INT_STATUS);
+
+	if (priv->dir == MBOX_RX) {
+		/* FIFO waterMark interrupt is generated */
+		if (int_status & (FIFO_FULL_INT | FIFO_WM01_INT)) {
+			cix_mbox_write(priv, (FIFO_FULL_INT | FIFO_WM01_INT), INT_CLEAR);
+			do {
+				data[i++] = cix_mbox_read(priv, FIFO_RD);
+			} while (!mbox_fifo_empty(chan) && i < CIX_MBOX_MSG_LEN);
+
+			mbox_chan_received_data(chan, data);
+		}
+		/* FIFO underflow is generated */
+		if (int_status & FIFO_UFLOW_INT) {
+			status = cix_mbox_read(priv, FIFO_STAS);
+			dev_err(priv->dev, "fifo underflow: int_stats %d\n", status);
+			cix_mbox_write(priv, FIFO_UFLOW_INT, INT_CLEAR);
+		}
+	} else {
+		/* FIFO empty interrupt is generated */
+		if (int_status & FIFO_EMPTY_INT) {
+			cix_mbox_write(priv, FIFO_EMPTY_INT, INT_CLEAR);
+			/* Disable empty irq*/
+			val_32 = cix_mbox_read(priv, INT_ENABLE);
+			val_32 &= ~FIFO_EMPTY_INT;
+			cix_mbox_write(priv, val_32, INT_ENABLE);
+			mbox_chan_txdone(chan, 0);
+		}
+		/* FIFO overflow is generated */
+		if (int_status & FIFO_OFLOW_INT) {
+			status = cix_mbox_read(priv, FIFO_STAS);
+			dev_err(priv->dev, "fifo overlow: int_stats %d\n", status);
+			cix_mbox_write(priv, FIFO_OFLOW_INT, INT_CLEAR);
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
+	if (priv->dir != MBOX_RX)
+		return;
+
+	int_status = cix_mbox_read(priv, INT_STATUS);
+
+	if (int_status & FAST_CH_INT(cp->index)) {
+		cix_mbox_write(priv, FAST_CH_INT(cp->index), INT_CLEAR);
+		data = cix_mbox_read(priv, REG_F_INT(cp->index));
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
+	int ret;
+	int index = cp->index;
+	u32 val_32;
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
+		if (priv->dir == MBOX_TX) {
+			/* Enable ACK interrupt */
+			val_32 = cix_mbox_read(priv, INT_ENABLE);
+			val_32 |= ACK_INT;
+			cix_mbox_write(priv, val_32, INT_ENABLE);
+		} else {
+			/* Enable Doorbell interrupt */
+			val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
+			val_32 |= DB_INT;
+			cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
+		}
+		break;
+	case CIX_MBOX_TYPE_FIFO:
+		/* reset fifo */
+		cix_mbox_write(priv, FIFO_RST_BIT, FIFO_RST);
+		/* set default watermark */
+		cix_mbox_write(priv, FIFO_WM_DEFAULT, FIFO_WM);
+		if (priv->dir == MBOX_TX) {
+			/* Enable fifo overflow interrupt */
+			val_32 = cix_mbox_read(priv, INT_ENABLE);
+			val_32 |= FIFO_OFLOW_INT;
+			cix_mbox_write(priv, val_32, INT_ENABLE);
+		} else {
+			/* Enable fifo full/underflow interrupt */
+			val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
+			val_32 |= FIFO_UFLOW_INT|FIFO_WM01_INT;
+			cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
+		}
+		break;
+	case CIX_MBOX_TYPE_FAST:
+		/* Only RX channel has intterupt */
+		if (priv->dir == MBOX_RX) {
+			if (index < 0 || index > MBOX_FAST_IDX) {
+				dev_err(priv->dev, "Invalid index %d\n", index);
+				return ret;
+			}
+			/* enable fast channel interrupt */
+			val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
+			val_32 |= FAST_CH_INT(index);
+			cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
+		}
+		break;
+	default:
+		dev_err(priv->dev, "Invalid channel type: %d\n", cp->type);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void cix_mbox_shutdown(struct mbox_chan *chan)
+{
+	struct cix_mbox_priv *priv = to_cix_mbox_priv(chan->mbox);
+	struct cix_mbox_con_priv *cp = chan->con_priv;
+	u32 val_32;
+	int index = cp->index;
+
+	switch (cp->type) {
+	case CIX_MBOX_TYPE_DB:
+	case CIX_MBOX_TYPE_REG:
+		if (priv->dir == MBOX_TX) {
+			/* Disable ACK interrupt */
+			val_32 = cix_mbox_read(priv, INT_ENABLE);
+			val_32 &= ~ACK_INT;
+			cix_mbox_write(priv, val_32, INT_ENABLE);
+		} else if (priv->dir == MBOX_RX) {
+			/* Disable Doorbell interrupt */
+			val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
+			val_32 &= ~DB_INT;
+			cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
+		}
+		break;
+	case CIX_MBOX_TYPE_FIFO:
+		if (priv->dir == MBOX_TX) {
+			/* Disable empty/fifo overflow irq*/
+			val_32 = cix_mbox_read(priv, INT_ENABLE);
+			val_32 &= ~(FIFO_EMPTY_INT | FIFO_OFLOW_INT);
+			cix_mbox_write(priv, val_32, INT_ENABLE);
+		} else if (priv->dir == MBOX_RX) {
+			/* Disable fifo WM01/underflow interrupt */
+			val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
+			val_32 &= ~(FIFO_UFLOW_INT | FIFO_WM01_INT);
+			cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
+		}
+		break;
+	case CIX_MBOX_TYPE_FAST:
+		if (priv->dir == MBOX_RX) {
+			if (index < 0 || index > MBOX_FAST_IDX) {
+				dev_err(priv->dev, "Invalid index %d\n", index);
+				break;
+			}
+			/* Disable fast channel interrupt */
+			val_32 = cix_mbox_read(priv, INT_ENABLE_SIDE_B);
+			val_32 &= ~FAST_CH_INT(index);
+			cix_mbox_write(priv, val_32, INT_ENABLE_SIDE_B);
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
+	int i;
+	struct cix_mbox_con_priv *cp;
+
+	for (i = 0; i < CIX_MBOX_CHANS; i++) {
+		cp = &priv->con_priv[i];
+		cp->index = i;
+		cp->chan = &priv->mbox_chans[i];
+		priv->mbox_chans[i].con_priv = cp;
+		if (cp->index <= MBOX_FAST_IDX)
+			cp->type = CIX_MBOX_TYPE_FAST;
+		if (cp->index == MBOX_DB_IDX) {
+			cp->type = CIX_MBOX_TYPE_DB;
+			priv->use_shmem = true;
+		}
+		if (cp->index == MBOX_FIFO_IDX)
+			cp->type = CIX_MBOX_TYPE_FIFO;
+		if (cp->index == MBOX_REG_IDX)
+			cp->type = CIX_MBOX_TYPE_REG;
+	}
+}
+
+static int cix_mbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cix_mbox_priv *priv;
+	int ret;
+	const char *dir_str;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
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


