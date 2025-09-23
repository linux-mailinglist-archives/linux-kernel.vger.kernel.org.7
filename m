Return-Path: <linux-kernel+bounces-829026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0FEB96162
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198593A7776
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540571F4165;
	Tue, 23 Sep 2025 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BYz13249"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30917F4F6;
	Tue, 23 Sep 2025 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635420; cv=fail; b=g+8OhHYck+nkTXNTf+UHSj98Hr5jxzc5oEMAAnVzAF+YGDHLebyO0U59nv6wzeTSnT/wfnBloLEj3+eVIe+dXvOSJF+CeZvrf9aE7FgavG4yAodkWaAysQyncaCmYpg8N416TipBvar+zBOo1X65sLkDwudtOyw3pd6Wm+3JJj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635420; c=relaxed/simple;
	bh=O7c4E/Q/O79ttQwOQIFsjFmtRIMPLvcZ171LJhQf78c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eL48UylP/aSiqBPap6VjLxEdsLxtPkPUZE/UcZiz/u+mfjxF+JYQgIhamCqFLX7UnN7EeHtsEJ3sT93Y7ClvubHaphPygHF3AT6l2SxemwBqWR3gGbkSCFt0Zpakg6J73V3m5GFH3gDkUTGDowNAJi8RW9NFBo0OdM4tSsQ3LGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BYz13249; arc=fail smtp.client-ip=52.101.62.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLgqwwZWcPWWq7R3IV2WzKXPrOGCrfnPh93anhUo2ty+ZKqsG2BSnuIP0DgXktPIHYQhfO9dZ2I/m90bxHrJ+Q5mmIXcZUR4/KO/CiFN7M3laHJ4wPN2dVabuIHg+cm3Pu7jsYJFmq1okc9w5Hxrx28A9U2ijdm/vVGKr0UFO2E0L2MkEV9jnJnpdzao7rj1SMPBTiUCc1k8A6Cji5GuIukOYmGncVOUB0pU9ePT3FMEoQRVSg0Pwrv1E3bCm3WoR/12gFrY4D1GPlfGy2Qnj2riJyJCki2noEaya8pB97nNDdt4hstysKhfcTYXoEGrIgaT68I2niucgz4eI5EKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=He+6nAVscTZ/+6VNm/99J4fk5PqAv2IHYdxEV3qaYuQ=;
 b=cGM7yp8mye1gpswLXgNcggMbfG4sccpFfSf8Y6MNxjShV5s51nxZ9WOEPV4umMEams8QCfpIV8cbrar5G/8Gwb3k2QwQ/TeJxNlY/u6wq9A22xjlTegw4VcFEUsRmATBl/Al2QZRM7tpF8DkY2Fqb1Ncn38PWlxPj8mYXFX6PQ1zEZ7I/w/IomBwi+fQa3+C4cetxiXyrkUKxQs2eZwpflvUD2Lgvfyo2N49Of2RSxZoyo+U2nEFu+cKCEqV7KuaLH/N9N8coU9qoVKjAdDxvOId07HYuALSv4JH+t52oRuWXPrHrqAk21bJWTNqrlAPZu7ZOjBQ//lFn7kduFI8gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=He+6nAVscTZ/+6VNm/99J4fk5PqAv2IHYdxEV3qaYuQ=;
 b=BYz132497V3vRMG2J6mMKJDQxze/ej8Wf0y8NfyxxlCH7zlIZkDMJLMOkSgkvPgdDG9JENOifgE31dkjfB7JxNnYpImM47lUN6Yj23SXCHlFSxhhLl2WDRhjyz+a3C8C8vHkdtd0vKkavrkMzD+xjmzCf/U6yU6rFbBgpBDBym0HQq4IRxZiC8Ks2eZkWKk/nsomJLzHZd8EQOecMl0TXyaqsTbcSDp3y5SJa4KcGQRYi/JqY/cwHxyPLQyR8Z4xcD69XaNQcmoFHvBRE17f9YMo9LhJ4o7rAsNC1CQsaskf37nrsfoVTR8mlZbR/83dGi9EuXYYy/z4S6vOjLDnUA==
Received: from CH0PR03CA0330.namprd03.prod.outlook.com (2603:10b6:610:118::22)
 by DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 13:50:15 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::18) by CH0PR03CA0330.outlook.office365.com
 (2603:10b6:610:118::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Tue,
 23 Sep 2025 13:50:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 13:50:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 23 Sep
 2025 06:50:03 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 23 Sep
 2025 06:50:02 -0700
Received: from r-build-bsp-02.mtr.labs.mlnx (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 23 Sep 2025 06:49:59 -0700
From: Ciju Rajan K <crajank@nvidia.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<tglx@linutronix.de>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
CC: <christophe.jaillet@wanadoo.fr>, <platform-driver-x86@vger.kernel.org>,
	<vadimp@nvidia.com>, Ciju Rajan K <crajank@nvidia.com>
Subject: [PATCH platform-next v3 1/1] [PATCH platform-next] platform/mellanox: mlxreg-hotplug: Add support for handling interrupt storm
Date: Tue, 23 Sep 2025 16:49:54 +0300
Message-ID: <20250923134954.3016697-1-crajank@nvidia.com>
X-Mailer: git-send-email 2.47.2
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DM4PR12MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9d7653-653d-48f7-cdb9-08ddfaa8200b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NcDsYh9l8EFW75Fx6Py0WLMwYdXjuW/tk5OJ5BnGy0CoDSo6aPbY+LYX49T8?=
 =?us-ascii?Q?s0EA8Eu5rAJ8g9GwYOFx1WAx7oMmlHMr0gS8SHB2GyrKtvrxF1hfsXO/HZcb?=
 =?us-ascii?Q?I5qSPCwOXVGqJLDuyHjrqz9d2fBt4t+byf0bazlLqNpTqyHmXA+V1+TTMIp4?=
 =?us-ascii?Q?Au28n5llkKDDOB29OkZ8SojFaCvhv2Xh2TSo5mqCFvooz0IC+jqbvhTIOkhl?=
 =?us-ascii?Q?BOiMhzFBCf8+b+TsA8CTu7QD52ABigwqeFmCqTJW67VKf2fFAjBWsvqFvqz7?=
 =?us-ascii?Q?lkqZtw6UBxHPHgq1fYwwmGGF6oJmShaRFV2nP4Tt/kYccs9jw3vEzkHQWKRQ?=
 =?us-ascii?Q?lJ0H2m+v9GAZrBvBjKqHGY1d3bocgyM3KseJ4IwvogcunelleMhj++n7je+k?=
 =?us-ascii?Q?S49X0K5ncrVLkHZ0VqFCRdw6ZFFwu/l8Wtlc9LA/IDkv8lGh1+e8i45RejP0?=
 =?us-ascii?Q?aNUAGHj907tHGPH73bbO8rc6prU8WTqaobKO3TSxRx2zHMbk/A6joIakLNuI?=
 =?us-ascii?Q?gO81LBCwpWlPsKpEWiD83ktHaoZtst8qBi5Lbf903d3mdcucE5dU9D9gqgaR?=
 =?us-ascii?Q?cx6qipuQxHHhH7/hYg4nATqS3qzbai5UjIm3as9q7sA4C1Y7L/34eQ+X9X+0?=
 =?us-ascii?Q?fZu2G3J+16Qq/WpMFHAQeTuJWGAW8vVAvUOWxFl65cYih5UbfkxO7KfJLdp7?=
 =?us-ascii?Q?VZjbMCNS7e3wVtliR9C0AGGDQ1Zo9FW4PJ3BP5G6r4uzn47E/ykM9jXUnklh?=
 =?us-ascii?Q?AKWLpjEoUPtZb+mfwB1eGNNIzc5eL2BAHEX7LjNc52vkmxRpWEDw91h43WzO?=
 =?us-ascii?Q?X0oXlufNZNKwXamfFeWGmu9nagWQ2aLZOgMFWXApEiv61N1c+gLxhGVx8e67?=
 =?us-ascii?Q?IhD9ZbencjUr6cPkydHzuVMIR96qiIDAu5WuPjTKO3T35a6e+3BypOKSCjl3?=
 =?us-ascii?Q?hId5AgLcq3zc6a4fXnhSf8PIhWjvz/Y7aTMEIAEnbfcDBki/d1gQ2yaGXc/8?=
 =?us-ascii?Q?palb9OtKwXdDMypRVqAbL8Gw5XOZ7FdTPPfRkyfFpa1zZMEAwD55ELQx0ZAu?=
 =?us-ascii?Q?S6Snzl/2NfkBnsdq8mvUqy7/Xi2EdQImV+Nc8sJMjLpKYLqQ76WrLi+5Gce0?=
 =?us-ascii?Q?DAatOvsi0LyhE+J1CSRFrJykDdW3eTqRHgGs8m2BcONaKISWhT4MWTI5fare?=
 =?us-ascii?Q?YiAwZ9wQol6me7J1tG7hxbbuIekkUHviwdg3UcGqUFpzlinik8FpVOfX6nL/?=
 =?us-ascii?Q?wux1szDVdpD/bj3jaUZ7TLKqaSSGt/INxQw6idvSyjRSs2WMKUvZ5RtcM8nn?=
 =?us-ascii?Q?Z76PL5irQ+jRjpAizmNQ72XgcW5wuI7yJvzUgw/f1pmfKI3BoveNWnJGfgIv?=
 =?us-ascii?Q?N6yvhrhHqpkhpYhN8Ef4cb5Tmu6Ch83le2l6a0LbXoonVFS0h75YogbbieqC?=
 =?us-ascii?Q?IkifnhGMYDM9p8KT33AXXdXKknXayZqrpRRDPecKwjA2qYjyS6Zz8TI7UKYK?=
 =?us-ascii?Q?Kt/LnL+THw8I5YF2ZwDZTyUDF3T9CGLgn2BA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:50:15.3860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9d7653-653d-48f7-cdb9-08ddfaa8200b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279

In case of broken hardware, it is possible that broken device will
flood interrupt handler with false events. For example, if fan or
power supply has damaged presence pin, it will cause permanent
generation of plugged in / plugged out events. As a result, interrupt
handler will consume a lot of CPU resources and will keep raising
"UDEV" events to the user space.

This patch provides a mechanism to detect device causing interrupt
flooding and mask interrupt for this specific device, to isolate
from interrupt handling flow. Use the following criteria: if the
specific interrupt was generated 'N' times during 'T' seconds,
such device is to be considered as broken and will be closed for
getting interrupts. User will be notified through the log error
and will be instructed to replace broken device.

Add fields for interrupt storm handling.
Extend structure mlxreg_core_data with the following fields:
 'wmark_cntr'   - interrupt storm counter.
 'wmark_window' - time window to count interrupts to check for storm.

Extend structure mlxreg_core_item with the following field:
 'storming_bits' - interrupt storming bits mask.

Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Signed-off-by: Ciju Rajan K <crajank@nvidia.com>
--

v2->v3

Comments pointed out by Ilpo:
- Merged variable declarations and implementation to a single patch.
- Moved the wmark_cntr increments to else block to allow recalculation
  of the time window.

v0->v2

Comments pointed out by Ilpo:
- Renamed the macro MLXREG_HOTPLUG_WM_WINDOW to MLXREG_HOTPLUG_WM_WINDOW_MS to indicate milli seconds
- Removed the timestamp stored in wmark_high_ts and used jiffies directly
- Calculating the time window and storing it in the new variable wmark_window.
- Removed the variables wmark_low_ts and wmark_high_ts
- Used continue statement inside the time window check

Changes added by Ciju:
- Renamed variable wmark_low_cntr to wmark_cntr
- Fixed the time window to check for interrupt storm
---
 drivers/platform/mellanox/mlxreg-hotplug.c | 33 ++++++++++++++++++++--
 include/linux/platform_data/mlxreg.h       |  6 ++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index d246772aafd6..f72eaaa14aba 100644
--- a/drivers/platform/mellanox/mlxreg-hotplug.c
+++ b/drivers/platform/mellanox/mlxreg-hotplug.c
@@ -11,6 +11,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/platform_data/mlxreg.h>
 #include <linux/platform_device.h>
@@ -30,6 +31,11 @@
 #define MLXREG_HOTPLUG_ATTRS_MAX	128
 #define MLXREG_HOTPLUG_NOT_ASSERT	3
 
+/* Interrupt storm definitions */
+#define MLXREG_HOTPLUG_WM_COUNTER	100
+/* Time window in milliseconds */
+#define MLXREG_HOTPLUG_WM_WINDOW_MS	3000
+
 /**
  * struct mlxreg_hotplug_priv_data - platform private data:
  * @irq: platform device interrupt number;
@@ -366,11 +372,34 @@ mlxreg_hotplug_work_helper(struct mlxreg_hotplug_priv_data *priv,
 	for_each_set_bit(bit, &asserted, 8) {
 		int pos;
 
+		/* Skip already marked storming bit. */
+		if (item->storming_bits & BIT(bit))
+			continue;
+
 		pos = mlxreg_hotplug_item_label_index_get(item->mask, bit);
 		if (pos < 0)
 			goto out;
 
 		data = item->data + pos;
+
+		/* Interrupt storm handling logic. */
+		if (data->wmark_cntr == 0) {
+			data->wmark_window = jiffies +
+				msecs_to_jiffies(MLXREG_HOTPLUG_WM_WINDOW_MS);
+		}
+		if (data->wmark_cntr >= MLXREG_HOTPLUG_WM_COUNTER - 1) {
+			if (time_after(data->wmark_window, jiffies)) {
+				dev_err(priv->dev,
+					"Storming bit %d (label: %s) - interrupt masked permanently. Replace broken HW.",
+					bit, data->label);
+				/* Mark bit as storming. */
+				item->storming_bits |= BIT(bit);
+				continue;
+			}
+			data->wmark_cntr = 0;
+		} else {
+			data->wmark_cntr++;
+		}
 		if (regval & BIT(bit)) {
 			if (item->inversed)
 				mlxreg_hotplug_device_destroy(priv, data, item->kind);
@@ -390,9 +419,9 @@ mlxreg_hotplug_work_helper(struct mlxreg_hotplug_priv_data *priv,
 	if (ret)
 		goto out;
 
-	/* Unmask event. */
+	/* Unmask event, exclude storming bits. */
 	ret = regmap_write(priv->regmap, item->reg + MLXREG_HOTPLUG_MASK_OFF,
-			   item->mask);
+			   item->mask & ~item->storming_bits);
 
  out:
 	if (ret)
diff --git a/include/linux/platform_data/mlxreg.h b/include/linux/platform_data/mlxreg.h
index f6cca7a035c7..453c8dfd7eb9 100644
--- a/include/linux/platform_data/mlxreg.h
+++ b/include/linux/platform_data/mlxreg.h
@@ -131,6 +131,8 @@ struct mlxreg_hotplug_device {
  * @regnum: number of registers occupied by multi-register attribute;
  * @slot: slot number, at which device is located;
  * @secured: if set indicates that entry access is secured;
+ * @wmark_cntr: interrupt storm counter;
+ * @wmark_window: time window to count interrupts to check for storm;
  */
 struct mlxreg_core_data {
 	char label[MLXREG_CORE_LABEL_MAX_SIZE];
@@ -151,6 +153,8 @@ struct mlxreg_core_data {
 	u8 regnum;
 	u8 slot;
 	u8 secured;
+	unsigned int wmark_cntr;
+	unsigned long wmark_window;
 };
 
 /**
@@ -167,6 +171,7 @@ struct mlxreg_core_data {
  * @ind: element's index inside the group;
  * @inversed: if 0: 0 for signal status is OK, if 1 - 1 is OK;
  * @health: true if device has health indication, false in other case;
+ * @storming_bits: interrupt storming bits mask;
  */
 struct mlxreg_core_item {
 	struct mlxreg_core_data *data;
@@ -180,6 +185,7 @@ struct mlxreg_core_item {
 	u8 ind;
 	u8 inversed;
 	u8 health;
+	u32 storming_bits;
 };
 
 /**
-- 
2.47.2


