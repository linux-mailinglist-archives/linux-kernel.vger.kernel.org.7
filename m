Return-Path: <linux-kernel+bounces-747521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AD6B134C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EB73B9AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E901321CFFD;
	Mon, 28 Jul 2025 06:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fnXeKW2k"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C0722126A;
	Mon, 28 Jul 2025 06:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753683072; cv=fail; b=MrYlKuIx2b9fBTT2ghX+3FGagtDSoV9rS02SpkdmKHcnPxW8kAlVddEuICA+MOuqAbzXO+Ydls4ubYQrInsNp87MlJ9rAaTq/S+eY8Cxqx6sy40Tg93E4hEsibTXImTa19LFuqV0vJfZMwq/ty9L7P+51RSM4wVUjGjlngzDA34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753683072; c=relaxed/simple;
	bh=hORbyD5NIFQ/R6mDye87uM3uNv/ZBAe1BOtNbeZL6mE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGWVngEmG7UgcRJfunsVzJRAq0y3wLrUUmyX/aevOuz4tdqoHx6pSE9vv6tJl2uYbQS7Z4SuyrbJtkbpwGRivGVl9HWGYeqzPkfXTBuf6XVHRXTG9Mh/vfY/kSJt4YziqUBuD5Q20T715LTg2z1+vRQLD+2RtILlSSegekzUsaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fnXeKW2k; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SE4ugCMsEU+oAZEp1IH16o/UY4sy2ZvBintWa8NHO29+imPnvCBAQ4IfwZHybMMO9RfGXkz25n0IafYlOPxc0JqnV7FqTH9IjUyvrFu6ByLik+12X4gOqaCIMDUBafYdBmGOi9AVROEFcNxcAACB10LL7U+xa5DyMbet9385qUhx26pyP29ztOTo/gQL/sA64XkZD4y92eNwiizWhmXUOKmvnsNTPMR68n/SVtMBRlj0RKJ+pmSRvz41tfNZv1X7MXeZkJYKbhKMaGdhfAdizOnZ3uM9k73d3DXDldupfVpzxVFY++m0/yUlMe0L53RdG8kFgpohJRZMCvrCA5SPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wtIjF/5ZOzLqR5C4rRofyYdm22l5/+kQXlO87Vt5hk=;
 b=p4rwAyTBrHkb/zK8WgRtzRdLBjam7zHxO/3iLk7qFAFI47i0XGx+eO9XDNW8+gL8SxEgQG5rP8XxV+RRZyMJtkPrX3wcdYNBkUF5z1yGtbErinz4kFdlt+j8tnPfcRnWKS6r9oaTIyEieEVjkofBqOALSirpryKP9qGPFIKW66WFwOeqECZ0gT5PN9H2panW+jaiHRRkYwVqB7zD7wDr8xZil6pI3hbR45Htlf8qEdgQiAW1uFqWmBETkrhxkVOYsumt3S/yx7CsmAKJMbr4Kxe6jZfZRarbDgxXNbWrgcGU3I2ud/MAjtFmz1tXwUcXLplH/5GfR9+k+qeUjUtTLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wtIjF/5ZOzLqR5C4rRofyYdm22l5/+kQXlO87Vt5hk=;
 b=fnXeKW2kkLfBbZluwIKTljTbmIq/tEb3k7638uV6uR1YBK3H3xODk04aQ6PCL6g9Thly9pHb6BSmSxHbpx0IU95kWtk3dKr9A+vRQiyMYnN6qy3L7lVvPl7NFM7TvhfK3cDX1d3yeywydHS+a1Z1ASG3990FoPzg65GuFJrUpoE=
Received: from MW4PR04CA0229.namprd04.prod.outlook.com (2603:10b6:303:87::24)
 by CY8PR12MB7492.namprd12.prod.outlook.com (2603:10b6:930:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:11:07 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:303:87:cafe::f8) by MW4PR04CA0229.outlook.office365.com
 (2603:10b6:303:87::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.25 via Frontend Transport; Mon,
 28 Jul 2025 06:11:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Mon, 28 Jul 2025 06:11:07 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 01:11:02 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <arnd@arndb.de>, <linux@roeck-us.net>,
	<Anand.Umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>, "Naveen Krishna
 Chatradhi" <naveenkrishna.chatradhi@amd.com>
Subject: [PATCH v1 2/5] misc: amd-sbi: Add support for SB-RMI over I3C
Date: Mon, 28 Jul 2025 06:10:30 +0000
Message-ID: <20250728061033.1604169-2-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250728061033.1604169-1-akshay.gupta@amd.com>
References: <20250728061033.1604169-1-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|CY8PR12MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 4814dc49-6e50-4fd9-173b-08ddcd9d8a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NdSPNcUzX0SxgbQQNxvCkmRmuf+z5un+ymhtfeXCN8Yc4A/QF2Ax5mLg87h2?=
 =?us-ascii?Q?YPXmLmqm09CJgunOznWmvJQ/Pwby7hc9YRSvhlD0WLWo+3xud5JlUhtQOTDo?=
 =?us-ascii?Q?jclhGCQXRJTTjiD+SLcV58GK37xjrXA10AQ6W6CBPhezhG9pV3IhjueGowWr?=
 =?us-ascii?Q?eqHIZtQNqQ2Kt1TqkNpZZdX4O0Jpa5BsSpeQ3iNhVw40KzaQyonxbX0qQctI?=
 =?us-ascii?Q?cSuN+zM34Q3ApTTVXja7+p7k038650ACCJxd8ZEwVZQGDwQsss06cCfn5Iks?=
 =?us-ascii?Q?hnWn81Oo2Q+KuQNOrSKMHKO5zBTJyJFPiQwub0WdA6m8RjIiIATJ8swLrY4K?=
 =?us-ascii?Q?RP/MAAPDqlIU+4FMDOpnmGyff0LbNj7JYl+ndtrHSEy4ncw5Uf00F1eGKlDe?=
 =?us-ascii?Q?dJOQ6/OgS6s3mYrtee7IVt64YqnR+1t/yn2HsTXIK7ZXb7uN0XauUygvZkbw?=
 =?us-ascii?Q?pq3OHfCWP0MrLn0EPdWvOem272nJssJaG5sWdBictoQF66rYJ2RO0BsG5rM2?=
 =?us-ascii?Q?8u/bCbOEvu4esCayin1NqVWA3RAeANcbvrSrNLFT2XcWU07FYfNuRa8M9jEQ?=
 =?us-ascii?Q?ayzX6WXidXoYMan1crMe44Q8i5hostEKHIDudpmH/qUvPZW9I1t4Teb0rucr?=
 =?us-ascii?Q?wQYheuuaYcJp9PycxmyHKyOy7qyhBETy2zsrWYUEt23lN4Vyd1m7cOF39pe/?=
 =?us-ascii?Q?3gQwVbgdyiN41SC6vZPLspSoc67zRsRg1B47+4XU4pxR7wsmXPAcD+l72dz3?=
 =?us-ascii?Q?wH7qccwgDMM2QUIMz/CkJKuwoe95v1RvChD/dtKjj9i7qkC8Q3fu8ES52bm2?=
 =?us-ascii?Q?Z+fdI7ytvpTOK7oUbXfS6oDVV7TWHt2ARl1kjcRl3ST4RX5tjBhXHA+lOh/I?=
 =?us-ascii?Q?oun1LevT+zcOLbLFyQCqwh5hiVX537PlFSpQAXUI9zN361Q+RN5zMjzQa0Nf?=
 =?us-ascii?Q?4yVumhWjDcya7/2oIkWBkNilhcT3aeKd+weAf5wPQ/cYDNNt9bzZ/OSd7nGp?=
 =?us-ascii?Q?3bBBg5FVVa/2SsJ+VcXilPyFjxXTXfti4SKRl9dFEQmRPLklXeL5drk8FGg5?=
 =?us-ascii?Q?FkyMV0pu+Ag4SO580BMqFVJHoIgbtIwt8dvYa6WESYlyEHfAlgoNhi7SGpdi?=
 =?us-ascii?Q?18NBzPjxAg1bEKYQNMHjv+kTvtrGgMRmD+NbiQzA3dudK0+8/QEeZVrYw2Vr?=
 =?us-ascii?Q?uWH91lvkOW/es9PgZM0c+q0/mkcDK6F6mAeFNBk6824lYYTFkQp3eV1O2HcU?=
 =?us-ascii?Q?Bztv0/ANTIAcAB1Bi+rHzXEZ3Dl7RV6K5gKWVOEqoEp1Ri1JecmfdplNmgHh?=
 =?us-ascii?Q?sCScNZxdWqa2nJjrvTr392z1mRfS4E21Rz+1HFjfDPB2o+Q+g2pkiaJxRv+E?=
 =?us-ascii?Q?Of02cKZB//NwzRb1PX2fLxPN3VIcV69s/R6GVlLtgZJv73HPKL48XcRAPz/7?=
 =?us-ascii?Q?Zw5oVAVBFTksm0RnT8YQfznWSZ8n1WN8+I1EqPJAtuLZA0brRauoYNERt7gE?=
 =?us-ascii?Q?af2uBaMiL/l3TOD6NqXX7/Xcx8zZksrazkW8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:11:07.1951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4814dc49-6e50-4fd9-173b-08ddcd9d8a7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7492

AMD EPYC platforms with zen5 and later support APML(SB-RMI)
connection to the BMC over I3C bus for improved efficiency.
Add the same functionality supported by rmi-i2c.c over I3C bus.

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
 drivers/misc/amd-sbi/Kconfig   |  15 +++-
 drivers/misc/amd-sbi/Makefile  |   2 +
 drivers/misc/amd-sbi/rmi-i3c.c | 133 +++++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/amd-sbi/rmi-i3c.c

diff --git a/drivers/misc/amd-sbi/Kconfig b/drivers/misc/amd-sbi/Kconfig
index 9b1abeb6ab1a..838cf98805d9 100644
--- a/drivers/misc/amd-sbi/Kconfig
+++ b/drivers/misc/amd-sbi/Kconfig
@@ -15,10 +15,21 @@ config AMD_SBRMI_I2C
 	  This driver can also be built as a module. If so, the module will
 	  be called sbrmi-i2c.
 
+config AMD_SBRMI_I3C
+	tristate "AMD side band RMI support over I3C"
+	depends on I3C
+	select AMD_SBRMI
+	select REGMAP_I3C
+	help
+	  Side band RMI over I3C support for AMD out of band management.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called sbrmi-i3c.
+
 config AMD_SBRMI_HWMON
 	bool "SBRMI hardware monitoring"
-	depends on AMD_SBRMI_I2C && HWMON
-	depends on !(AMD_SBRMI_I2C=y && HWMON=m)
+	depends on (AMD_SBRMI_I2C || AMD_SBRMI_I3C) && HWMON
+	depends on !(AMD_SBRMI_I2C=y && HWMON=m) || !(AMD_SBRMI_I3C=y && HWMON=m)
 	help
 	  This provides support for RMI device hardware monitoring. If enabled,
 	  a hardware monitoring device will be created for each socket in
diff --git a/drivers/misc/amd-sbi/Makefile b/drivers/misc/amd-sbi/Makefile
index 6f3090fb9ff3..e43d4058a0f0 100644
--- a/drivers/misc/amd-sbi/Makefile
+++ b/drivers/misc/amd-sbi/Makefile
@@ -4,3 +4,5 @@ sbrmi_core-y			:= rmi-core.o
 obj-$(CONFIG_AMD_SBRMI_HWMON)	+= rmi-hwmon.o
 sbrmi-i2c-y			:= rmi-i2c.o
 obj-$(CONFIG_AMD_SBRMI_I2C)	+= sbrmi-i2c.o
+sbrmi-i3c-y  			:= rmi-i3c.o
+obj-$(CONFIG_AMD_SBRMI_I3C)	+= sbrmi-i3c.o
diff --git a/drivers/misc/amd-sbi/rmi-i3c.c b/drivers/misc/amd-sbi/rmi-i3c.c
new file mode 100644
index 000000000000..b960743afad1
--- /dev/null
+++ b/drivers/misc/amd-sbi/rmi-i3c.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * rmi-i3c.c - Side band RMI over I3C support for AMD out
+ *             of band management
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i3c/device.h>
+#include <linux/i3c/master.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include "rmi-core.h"
+
+static int sbrmi_enable_alert(struct sbrmi_data *data)
+{
+	int ctrl, ret;
+
+	/*
+	 * Enable the SB-RMI Software alert status
+	 * by writing 0 to bit 4 of Control register(0x1)
+	 */
+	ret = regmap_read(data->regmap, SBRMI_CTRL, &ctrl);
+	if (ret < 0)
+		return ret;
+
+	if (ctrl & 0x10) {
+		ctrl &= ~0x10;
+		return regmap_write(data->regmap, SBRMI_CTRL, ctrl);
+	}
+
+	return 0;
+}
+
+static int sbrmi_get_max_pwr_limit(struct sbrmi_data *data)
+{
+	struct apml_mbox_msg msg = { 0 };
+	int ret;
+
+	msg.cmd = SBRMI_READ_PKG_MAX_PWR_LIMIT;
+	ret = rmi_mailbox_xfer(data, &msg);
+	if (ret < 0)
+		return ret;
+	data->pwr_limit_max = msg.mb_in_out;
+
+	return ret;
+}
+
+static int sbrmi_i3c_probe(struct i3c_device *i3cdev)
+{
+	struct device *dev = &i3cdev->dev;
+	struct sbrmi_data *data;
+	struct regmap_config sbrmi_i3c_regmap_config = {
+		.reg_bits = 8,
+		.val_bits = 8,
+	};
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(struct sbrmi_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	mutex_init(&data->lock);
+
+	data->regmap = devm_regmap_init_i3c(i3cdev, &sbrmi_i3c_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	/* Enable alert for SB-RMI sequence */
+	ret = sbrmi_enable_alert(data);
+	if (ret < 0)
+		return ret;
+
+	/* Cache maximum power limit */
+	ret = sbrmi_get_max_pwr_limit(data);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * AMD APML I3C devices support static address
+	 */
+	if (i3cdev->desc->info.static_addr)
+		data->dev_static_addr = i3cdev->desc->info.static_addr;
+	else
+		data->dev_static_addr = i3cdev->desc->info.dyn_addr;
+
+	dev_set_drvdata(dev, data);
+
+	ret = create_hwmon_sensor_device(dev, data);
+	if (ret < 0)
+		return ret;
+	return create_misc_rmi_device(data, dev);
+}
+
+static void sbrmi_i3c_remove(struct i3c_device *i3cdev)
+{
+	struct sbrmi_data *data = dev_get_drvdata(&i3cdev->dev);
+
+	misc_deregister(&data->sbrmi_misc_dev);
+	/* Assign fops and parent of misc dev to NULL */
+	data->sbrmi_misc_dev.fops = NULL;
+	data->sbrmi_misc_dev.parent = NULL;
+	dev_info(&i3cdev->dev, "Removed sbrmi-i3c driver\n");
+}
+
+static const struct i3c_device_id sbrmi_i3c_id[] = {
+	/* PID for AMD SBRMI device */
+	I3C_DEVICE_EXTRA_INFO(0x112, 0x0, 0x2, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(i3c, sbrmi_i3c_id);
+
+static struct i3c_driver sbrmi_i3c_driver = {
+	.driver = {
+		.name = "sbrmi-i3c",
+	},
+	.probe = sbrmi_i3c_probe,
+	.remove = sbrmi_i3c_remove,
+	.id_table = sbrmi_i3c_id,
+};
+
+module_i3c_driver(sbrmi_i3c_driver);
+
+MODULE_IMPORT_NS("AMD_SBRMI");
+MODULE_AUTHOR("Akshay Gupta <akshay.gupta@amd.com>");
+MODULE_AUTHOR("Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>");
+MODULE_DESCRIPTION("AMD SB-RMI driver over I3C");
+MODULE_LICENSE("GPL");
-- 
2.25.1


