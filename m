Return-Path: <linux-kernel+bounces-845898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93693BC66DF
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 223AF350B23
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24B52C1580;
	Wed,  8 Oct 2025 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FSB5gdmg"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72832C2340
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950617; cv=fail; b=LW7HNwZSoWGbzGd6uNAtVtjIrFFt65rYe35A5ZGi/OXliRdY27vcsYshUI214DWAPEbMiSTeT/J5mo+LeFoR+sdpOyZLCiX/RptwSLViYV7HcBQmxRMT1koPWfMCMRjuaI4pFGz5/YLAMvBKAprPDHnvCDIWEFMo+5EpxLRhKls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950617; c=relaxed/simple;
	bh=BPTOi6ttMNgIbbZWnlAZHDydVd8WTzT+9f/LnaOnvD8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTsEJN5jJD4oiH5FEWDQzo9pZK3Lt026tbKNXmWN0/W15BE5pcblzvdNBo5FM8290IlsCCfpgJGfPRgTB9rnrvR1gzJlzvmCU2N1C+vBo0qsUGGsH0aiP9JwBEsGu6PJQcFeP/yROW5BtPgiY7RnFGI/YnYynU6b40GEfdZQhZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FSB5gdmg; arc=fail smtp.client-ip=52.101.43.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmTA1NDn/BCdHrZokXMpLqmCYMmvDueeDHXVj2pfJvQYxBT8pchd5RXpqkYMz4uzBKvdAOGAlXaM0TidsM1gES1DO0Sq6B5sboYs5Fgcmx0YzbNBVeCkep3KMWne4smqD+GlV6Dq47W5PMjjWyimYN3FqXZIIjqybnJvatiWdpoMHKFQy0rhYV46o0iUx8VjGvcP8fwZezG3aX2dVLt8QlIPfhzBd568ylxFwr56JxsnixeJSdsnORgpPMVleEh5kvzKtSrLdf1Zx+Np6Gofvy/zjyxitnbSGGwg2L4EBSlsh/zx62ft1/CXP2qTXOPyzZLBepESsN7y6o6tx+56QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BRfeeZGZh3+oKfXlY2bcwZghQirtOG/oCAELffLJtQ=;
 b=NDAUuFK6yz+XavYB3m20OS28FK8/ZqIEnavHvbncIvbHjYu+zYN2ZthzvZmkQWUeYjpQKtGIHudM87Sq3dgV1QZJf2DkLcE59RGKBC4ggkwAi7jGrJ78fzOoxUAcD8gKpiON0N9dB973cnQkCQTHDfZ+jOxI2WKSK31FpUCEIRBGKJBTdgBZSFKC90jKmlGBsWvJ5sJPrlLGqiCWCJvJnTK5Hv6HlgfpCFO/eUZRYJmCuyG36h8ZB4o/ft+Y/C/yxyS0zT1AXN6RdysCzg2Krnsd3RULbtHU0kftC0uHpcuOE8lwZmlw8iW+/pNN8Ng1OicRHU73mCf0tq1Cj5Xrig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BRfeeZGZh3+oKfXlY2bcwZghQirtOG/oCAELffLJtQ=;
 b=FSB5gdmg28NgMF1CorScYklaAehlzbHTDFPi1Z4t4y7BqXVB5hwMQiiq9k3ykpqeWh6EPCMJGOcU/yGkvgDGVSraANdSk3cJ/U/qorumCUZaJGYHw4E7bv3sPuguXdWAWCoK4yNoMSEeGRjIVS+PgtIFC9JP4QEZAH5IGpxUr8b71l2ku67YtONLsBFtTaH5REWwuERGci7jsf7K+1fkNLXJbqq7sijdcIdzoaFP3syldiYkk5tLySs4xcxbyXrb0hlJ27o6NAADOZOeGh0D4B6L7FteF5qow/4pjgyYtpk0PoLk5focfobn2zkegwFdGZHzVGbDLXPhPBdx0AKvcQ==
Received: from MW4PR03CA0306.namprd03.prod.outlook.com (2603:10b6:303:dd::11)
 by LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 19:09:58 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::69) by MW4PR03CA0306.outlook.office365.com
 (2603:10b6:303:dd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 8 Oct 2025 19:09:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 19:09:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 8 Oct
 2025 12:09:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Oct 2025 12:09:42 -0700
Received: from build-vvidwans-focal-20250627.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Wed, 8 Oct 2025 12:09:42 -0700
From: Vedashree Vidwans <vvidwans@nvidia.com>
To: <salman.nabi@arm.com>, <lpieralisi@kernel.org>, <mark.rutland@arm.com>,
	<sudeep.holla@arm.com>, <andre.przywara@arm.com>
CC: <ardb@kernel.org>, <chao.gao@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <sdonthineni@nvidia.com>,
	<vsethi@nvidia.com>, <vwadekar@nvidia.com>, Vedashree Vidwans
	<vvidwans@nvidia.com>
Subject: [RFC PATCH 2/3] firmware: smccc: LFA: refactor, add device node support
Date: Wed, 8 Oct 2025 19:09:06 +0000
Message-ID: <20251008190907.181412-3-vvidwans@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251008190907.181412-1-vvidwans@nvidia.com>
References: <20251008190907.181412-1-vvidwans@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|LV2PR12MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 5711667d-379a-48e6-9b95-08de069e45ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PlAalFvmwOH3L1VIK3r90u3xUD9+7EVcCvXJEUagnyugXGTrFiLkVzrpBo29?=
 =?us-ascii?Q?ETlK2bfQQoZq7g2rHoLRu4v30Hl1Paj0FEoRCi4xdwlMi8sUQdEMGiG0Bjt0?=
 =?us-ascii?Q?NDV32rRyq8f1EFP0hXSCN9Zd0wmbRrTnPxwLGnw+AFJyAS3pItI58PMh5AE5?=
 =?us-ascii?Q?19cgcfZWeT2bBFduoVBFBnkQBXlVfQLb95Nhhg2GXCjzt7xTYGHiQ1+yhD81?=
 =?us-ascii?Q?OF54j36SY8Y/u8hoNbocn4wlHcjQl+E5kGGTMT2ISDpLxElNxqselbkuUdYU?=
 =?us-ascii?Q?AUZSZKHsfqnD7h5n9KLvgtjgrSNbkRHcrc9vIz2EhCBAbqrGm8vMLf9BKWbG?=
 =?us-ascii?Q?sk3BJwwSm4VyjKDoHVl99WyShhHQ0Zu+ML28uA96cgqTL2EGPp3w5RwYV0rg?=
 =?us-ascii?Q?JH6vmcTp51M7JSuafBI0vAu8O9Jr8yy/IFHjsBrCo77Ov4l2pad0n3EFlSc1?=
 =?us-ascii?Q?W7bRqImqJWztJWV3U0Wrfy/M1nE5Q/ebCoH4sk3JBDRxwb8Mi4dNZUnlBb3F?=
 =?us-ascii?Q?pUqJOLFEoh7o5Iq1KoPskKr5DPiOkRsjlWM0Za92qhmG7zAh6sHdumAU5MM/?=
 =?us-ascii?Q?znvCD3JU+ZLAZQeIEifJyvppLMZ4Cxoqgne3qgsLPatGsHur7mdKhmw2KdE/?=
 =?us-ascii?Q?u8xHivJVF2BqQETgiEdDOgsQ6mMI1UjXCGrN6U+DEXIvne5Od89WF+3wkceH?=
 =?us-ascii?Q?79VZxcHlwGAGzKM7bR+pyMChWeKsQKCV7R3kdnXGnbwxa8Mh+V/gPmPcY/U1?=
 =?us-ascii?Q?5+YrUDGUUFZjihH2MQe4pC7w1PWVNuq11sIJaSrO6iU6yoe1hSjRf4RF0Dxh?=
 =?us-ascii?Q?SOX/yMkY1cM3S9s0f39Ik97hCRLCR1GgtOkYVIK4Huno2Mae0vphdrT6+9FO?=
 =?us-ascii?Q?4JGX08HGLX8b3mQYiTx/pqtgx90aPmKEdrG+146Ea2zIw9JzYWigs/jG/am3?=
 =?us-ascii?Q?R01tzYhs1dyn1B/fPeyUSoQC+q3p2ZGZgd5LTS63uGC9Ka1rNnu3xnXA+3wA?=
 =?us-ascii?Q?w1WcH7CRKFj3kGbjOZvM3Rtbwo7ONue7myUB+XIlVw5HS01SQm2eL+p7jXWW?=
 =?us-ascii?Q?pjYlhBxs+lFnenhfZiy+uursc7elNk3cClwa20rkEcOqiIcm8lANzd+LzJWu?=
 =?us-ascii?Q?MVCfMPqKqviOnEAsi5OIH6Cul7BUhjoShg0DDWesr0ObtJDdsxmL3Ga7XcWj?=
 =?us-ascii?Q?JPKxbpUUBBOFn07yLRusAdcvYWLd250qM+jRoy+5WlVJHJ93HzhcBfHMRXVe?=
 =?us-ascii?Q?VUABCCtn+zUn34XhxpJApANh9tqvt2upBx4f4kDYG7Ur0hiITD8R/NoVvpIf?=
 =?us-ascii?Q?32x+o4cfcUF8a3qBqbAXKLWipsm5KBi0nzcOgqe+KY6kigprnM1XMK4fl2XN?=
 =?us-ascii?Q?nQzgG7ZtXL8Gq5PdFHM3w8fKdCfVnj0izRAn0cNls3x5v0hz9M6KRbjymRki?=
 =?us-ascii?Q?l+7mReO8MMPL2o5KaHLJBjcKrno18NHf7Tj31cazZrMhrEnJo1ZDOAC+hHqi?=
 =?us-ascii?Q?grwRRZvf610WxwEILFFmKQTB/nXpLZ1SBxPpn+tLLMsillaTSI+5OnhdfJVy?=
 =?us-ascii?Q?P0x0ZnqDL7lDf2yidQM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 19:09:57.6595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5711667d-379a-48e6-9b95-08de069e45ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5893

- Add support for LFA device node in the kernel driver. Implement
probe() to register LFA interrupt and threaded interrupt service
function.
- CPUs will be rendezvoused during activation.
- On IRQ, driver will query FW components then triggers activation of
capable and pending components.
- Mutex synchronization is implemented to avoid concurrent LFA updates
through interrupt and sysfs interfaces.
- Refactor LFA CANCEL logic into independent lfa_cancel() function.
- Enhance PRIME/ACTIVATION functions to touch watchdog and implement
timeouts.

Signed-off-by: Vedashree Vidwans <vvidwans@nvidia.com>
---
 drivers/firmware/smccc/lfa_fw.c | 299 ++++++++++++++++++++++++++++----
 1 file changed, 262 insertions(+), 37 deletions(-)

diff --git a/drivers/firmware/smccc/lfa_fw.c b/drivers/firmware/smccc/lfa_fw.c
index 49f7feb6a211b..b36b8d7457c30 100644
--- a/drivers/firmware/smccc/lfa_fw.c
+++ b/drivers/firmware/smccc/lfa_fw.c
@@ -16,7 +16,15 @@
 #include <linux/uuid.h>
 #include <linux/array_size.h>
 #include <linux/list.h>
-
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
+#include <linux/nmi.h>
+#include <linux/ktime.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+
+#define DRIVER_NAME	"ARM_LFA"
 #define LFA_ERROR_STRING(name) \
 	[name] = #name
 #undef pr_fmt
@@ -34,6 +42,18 @@
 #define LFA_1_0_FN_ACTIVATE		LFA_1_0_FN(5)
 #define LFA_1_0_FN_CANCEL		LFA_1_0_FN(6)
 
+/* CALL_AGAIN flags (returned in res.a1[0]) */
+#define LFA_PRIME_CALL_AGAIN		BIT(0)
+#define LFA_ACTIVATE_CALL_AGAIN		BIT(0)
+
+/* Prime loop limits, TODO: tune after testing */
+#define LFA_PRIME_BUDGET_US		30000000 /* 30s cap */
+#define LFA_PRIME_POLL_DELAY_US		10       /* 10us between polls */
+
+/* Activation loop limits, TODO: tune after testing */
+#define LFA_ACTIVATE_BUDGET_US		20000000 /* 20s cap */
+#define LFA_ACTIVATE_POLL_DELAY_US	10       /* 10us between polls */
+
 /* LFA return values */
 #define LFA_SUCCESS			0
 #define LFA_NOT_SUPPORTED		1
@@ -114,8 +134,9 @@ static const struct fw_image_uuid {
 };
 
 static struct kobject *lfa_dir;
+static DEFINE_MUTEX(lfa_lock);
 
-static int get_nr_lfa_components(void)
+static unsigned long get_nr_lfa_components(void)
 {
 	struct arm_smccc_1_2_regs args = { 0 };
 	struct arm_smccc_1_2_regs res = { 0 };
@@ -130,11 +151,40 @@ static int get_nr_lfa_components(void)
 	return res.a1;
 }
 
+static int lfa_cancel(void *data)
+{
+	struct image_props *attrs = data;
+	struct arm_smccc_1_2_regs args = { 0 };
+	struct arm_smccc_1_2_regs res = { 0 };
+
+	args.a0 = LFA_1_0_FN_CANCEL;
+	args.a1 = attrs->fw_seq_id;
+	arm_smccc_1_2_invoke(&args, &res);
+
+	/*
+	 * When firmware activation is called with "skip_cpu_rendezvous=1",
+	 * LFA_CANCEL can fail with LFA_BUSY if the activation could not be
+	 * cancelled.
+	 */
+	if (res.a0 == LFA_SUCCESS) {
+		pr_info("Activation cancelled for image %s",
+			attrs->image_name);
+	} else {
+		pr_err("Firmware activation could not be cancelled: %ld",
+		       (long)res.a0);
+		return -EIO;
+	}
+
+	return res.a0;
+}
+
 static int call_lfa_activate(void *data)
 {
 	struct image_props *attrs = data;
 	struct arm_smccc_1_2_regs args = { 0 };
 	struct arm_smccc_1_2_regs res = { 0 };
+	ktime_t end = ktime_add_us(ktime_get(), LFA_ACTIVATE_BUDGET_US);
+	int ret;
 
 	args.a0 = LFA_1_0_FN_ACTIVATE;
 	args.a1 = attrs->fw_seq_id; /* fw_seq_id under consideration */
@@ -148,9 +198,32 @@ static int call_lfa_activate(void *data)
 	 */
 	args.a2 = !(attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous);
 
-	do {
+	for (;;) {
+		/* Touch watchdog, ACTIVATE shouldn't take longer than watchdog_thresh */
+		touch_nmi_watchdog();
 		arm_smccc_1_2_invoke(&args, &res);
-	} while (res.a0 == 0 && res.a1 == 1);
+
+		if ((long)res.a0 < 0) {
+			pr_err("ACTIVATE for image %s failed: %s",
+				attrs->image_name, lfa_error_strings[-res.a0]);
+			return res.a0;
+		}
+		if (!(res.a1 & LFA_ACTIVATE_CALL_AGAIN))
+			break; /* ACTIVATE successful */
+
+		/* SMC returned with call_again flag set */
+		if (ktime_before(ktime_get(), end)) {
+			udelay(LFA_ACTIVATE_POLL_DELAY_US);
+			continue;
+		}
+
+		pr_err("ACTIVATE timed out for image %s", attrs->image_name);
+		ret = lfa_cancel(attrs);
+		if (ret == 0)
+			return -ETIMEDOUT;
+		else
+			return ret;
+	}
 
 	return res.a0;
 }
@@ -159,8 +232,24 @@ static int activate_fw_image(struct image_props *attrs)
 {
 	struct arm_smccc_1_2_regs args = { 0 };
 	struct arm_smccc_1_2_regs res = { 0 };
+	ktime_t end = ktime_add_us(ktime_get(), LFA_PRIME_BUDGET_US);
 	int ret;
 
+	if (attrs->may_reset_cpu) {
+		pr_err("Firmware component requires unsupported CPU reset");
+		return -EINVAL;
+	}
+
+	/*
+	 * We want to force CPU rendezvous if either cpu_rendezvous or
+	 * cpu_rendezvous_forced is set. The flag value is flipped as
+	 * it is called skip_cpu_rendezvous in the spec.
+	 */
+	if (!(attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous)) {
+		pr_warn("CPU rendezvous is expected to be selected.");
+		return -EAGAIN;
+	}
+
 	/*
 	 * LFA_PRIME/ACTIVATE will return 1 in res.a1 if the firmware
 	 * priming/activation is still in progress. In that case
@@ -169,20 +258,36 @@ static int activate_fw_image(struct image_props *attrs)
 	 */
 	args.a0 = LFA_1_0_FN_PRIME;
 	args.a1 = attrs->fw_seq_id; /* fw_seq_id under consideration */
-	do {
+	for (;;) {
+		/* Touch watchdog, PRIME shouldn't take longer than watchdog_thresh */
+		touch_nmi_watchdog();
 		arm_smccc_1_2_invoke(&args, &res);
-		if (res.a0 != LFA_SUCCESS) {
-			pr_err("LFA_PRIME failed: %s\n",
-				lfa_error_strings[-res.a0]);
 
+		if ((long)res.a0 < 0) {
+			pr_err("LFA_PRIME for image %s failed: %s\n",
+				attrs->image_name, lfa_error_strings[-res.a0]);
 			return res.a0;
 		}
-	} while (res.a1 == 1);
+		if (!(res.a1 & LFA_PRIME_CALL_AGAIN))
+			break; /* PRIME successful */
 
-	if (attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous)
-		ret = stop_machine(call_lfa_activate, attrs, cpu_online_mask);
-	else
-		ret = call_lfa_activate(attrs);
+		/* SMC returned with call_again flag set */
+		if (ktime_before(ktime_get(), end)) {
+			udelay(LFA_PRIME_POLL_DELAY_US);
+			continue;
+		}
+
+		pr_err("PRIME timed out for image %s", attrs->image_name);
+		ret = lfa_cancel(attrs);
+		if (ret == 0)
+			return -ETIMEDOUT;
+		else
+			return ret;
+	}
+
+	ret = stop_machine(call_lfa_activate, attrs, cpu_online_mask);
+	if (ret != 0)
+		return lfa_cancel(attrs);
 
 	return ret;
 }
@@ -286,23 +391,23 @@ static ssize_t activate_store(struct kobject *kobj, struct kobj_attribute *attr,
 					 image_attrs[LFA_ATTR_ACTIVATE]);
 	int ret;
 
-	if (attrs->may_reset_cpu) {
-		pr_err("Firmware component requires unsupported CPU reset\n");
-
-		return -EINVAL;
+	if (!mutex_trylock(&lfa_lock)) {
+		pr_err("Mutex locked, try again");
+		return -EAGAIN;
 	}
 
 	ret = activate_fw_image(attrs);
 	if (ret) {
 		pr_err("Firmware activation failed: %s\n",
 			lfa_error_strings[-ret]);
-
+		mutex_unlock(&lfa_lock);
 		return -ECANCELED;
 	}
 
 	pr_info("Firmware activation succeeded\n");
 
 	/* TODO: refresh image flags here*/
+	mutex_unlock(&lfa_lock);
 	return count;
 }
 
@@ -311,26 +416,11 @@ static ssize_t cancel_store(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct image_props *attrs = container_of(attr, struct image_props,
 						 image_attrs[LFA_ATTR_CANCEL]);
-	struct arm_smccc_1_2_regs args = { 0 };
-	struct arm_smccc_1_2_regs res = { 0 };
-
-	args.a0 = LFA_1_0_FN_CANCEL;
-	args.a1 = attrs->fw_seq_id;
-	arm_smccc_1_2_invoke(&args, &res);
+	int ret;
 
-	/*
-	 * When firmware activation is called with "skip_cpu_rendezvous=1",
-	 * LFA_CANCEL can fail with LFA_BUSY if the activation could not be
-	 * cancelled.
-	 */
-	if (res.a0 == LFA_SUCCESS) {
-		pr_info("Activation cancelled for image %s\n",
-			attrs->image_name);
-	} else {
-		pr_err("Firmware activation could not be cancelled: %s\n",
-		       lfa_error_strings[-res.a0]);
-		return -EINVAL;
-	}
+	ret = lfa_cancel(attrs);
+	if (ret != 0)
+		return ret;
 
 	return count;
 }
@@ -418,6 +508,11 @@ static int create_fw_images_tree(void)
 	int ret, num_of_components;
 
 	num_of_components = get_nr_lfa_components();
+	if (num_of_components <= 0) {
+		pr_err("Error getting number of LFA components");
+		return -ENODEV;
+	}
+
 	args.a0 = LFA_1_0_FN_GET_INVENTORY;
 	for (int i = 0; i < num_of_components; i++) {
 		args.a1 = i; /* fw_seq_id under consideration */
@@ -437,6 +532,125 @@ static int create_fw_images_tree(void)
 	return 0;
 }
 
+static int refresh_fw_images_tree(void)
+{
+	int ret;
+	/*
+	 * Ideally, this function should invoke the GET_INVENTORY SMC
+	 * for each firmware image and update the corresponding details
+	 * in the firmware image tree node.
+	 * There are several edge cases to consider:
+	 *    - The number of firmware components may change.
+	 *    - The mapping between firmware sequence IDs and
+	 *      firmware image UUIDs may be modified.
+	 * As a result, it is possible that the firmware image tree nodes
+	 * will require updates. Additionally, GET_INVENTORY SMC provides
+	 * all current and revised information. Therefore, retaining the
+	 * existing fw_images_tree data is not justified. Reconstructing
+	 * the firmware images tree will simplify the code and keep data
+	 * up-to-date.
+	 */
+	// Clean current inventory details
+	clean_fw_images_tree();
+
+	// Update new inventory details
+	ret = create_fw_images_tree();
+	if (ret != 0)
+		kobject_put(lfa_dir);
+
+	return ret;
+}
+
+static irqreturn_t lfa_irq_thread(int irq, void *data)
+{
+	struct image_props *attrs = NULL;
+	int ret;
+
+	mutex_lock(&lfa_lock);
+
+	// Update new inventory details
+	ret = refresh_fw_images_tree();
+	if (ret != 0)
+		goto exit_unlock;
+
+	/*
+	 * Execute PRIME and ACTIVATE for each FW component
+	 * Start from first FW component
+	 */
+	list_for_each_entry(attrs, &lfa_fw_images, image_node) {
+		if ((!attrs->activation_capable) || (!attrs->activation_pending)) {
+			/* LFA not applicable for this FW component, continue to next component */
+			continue;
+		}
+
+		ret = activate_fw_image(attrs);
+		if (ret) {
+			pr_err("Firmware %s activation failed: %s\n",
+				attrs->image_name, lfa_error_strings[-ret]);
+			goto exit_unlock;
+		}
+
+		pr_info("Firmware %s activation succeeded", attrs->image_name);
+	}
+
+	// Update new inventory details
+	ret = refresh_fw_images_tree();
+	if (ret != 0)
+		goto exit_unlock;
+
+exit_unlock:
+	mutex_unlock(&lfa_lock);
+	return IRQ_HANDLED;
+}
+
+static int __init lfa_probe(struct platform_device *pdev)
+{
+	int err;
+	unsigned int irq;
+
+	err = platform_get_irq_byname_optional(pdev, "fw-store-updated-interrupt");
+	if (err < 0)
+		err = platform_get_irq(pdev, 0);
+	if (err < 0) {
+		pr_err("Interrupt not found, functionality will be unavailable.");
+
+		/* Bail out without failing the driver. */
+		return 0;
+	}
+	irq = err;
+
+	err = request_threaded_irq(irq, NULL, lfa_irq_thread, IRQF_ONESHOT, DRIVER_NAME, NULL);
+	if (err != 0) {
+		pr_err("Interrupt setup failed, functionality will be unavailable.");
+
+		/* Bail out without failing the driver. */
+		return 0;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id lfa_of_ids[] = {
+	{ .compatible = "arm,armhf000", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, lfa_of_ids);
+
+static const struct acpi_device_id lfa_acpi_ids[] = {
+	{"ARMHF000"},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, lfa_acpi_ids);
+
+static struct platform_driver lfa_driver = {
+	.probe = lfa_probe,
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = lfa_of_ids,
+		.acpi_match_table = ACPI_PTR(lfa_acpi_ids),
+	},
+};
+
 static int __init lfa_init(void)
 {
 	struct arm_smccc_1_2_regs args = { 0 };
@@ -464,22 +678,33 @@ static int __init lfa_init(void)
 	pr_info("Arm Live Firmware Activation (LFA): detected v%ld.%ld\n",
 		res.a0 >> 16, res.a0 & 0xffff);
 
+	err = platform_driver_register(&lfa_driver);
+	if (err < 0)
+		pr_err("Platform driver register failed");
+
+
 	lfa_dir = kobject_create_and_add("lfa", firmware_kobj);
 	if (!lfa_dir)
 		return -ENOMEM;
 
+	mutex_lock(&lfa_lock);
 	err = create_fw_images_tree();
 	if (err != 0)
 		kobject_put(lfa_dir);
 
+	mutex_unlock(&lfa_lock);
 	return err;
 }
 module_init(lfa_init);
 
 static void __exit lfa_exit(void)
 {
+	mutex_lock(&lfa_lock);
 	clean_fw_images_tree();
+	mutex_unlock(&lfa_lock);
+
 	kobject_put(lfa_dir);
+	platform_driver_unregister(&lfa_driver);
 }
 module_exit(lfa_exit);
 
-- 
2.25.1


