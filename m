Return-Path: <linux-kernel+bounces-747520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE71AB134C0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF171883C57
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1154E21FF5F;
	Mon, 28 Jul 2025 06:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uKC/0+dW"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BEC9461;
	Mon, 28 Jul 2025 06:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753683068; cv=fail; b=VLq0kDLRHvuSeWIpIxoVMqn05BZxrf5V1gUYEu56I/iCgWfqWENsUf1u+ghsPuJYR9HDSSwrkS6nYi5UwMKsiiPZA+9KbGGk4QNYlQWyxqbT/dl1sLaIJ+hu2uS2P6tKKmJV/K/SjAMZSpQe776iNT40+JY0jxnEIiYY5yRdoRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753683068; c=relaxed/simple;
	bh=xV07XOWMaiCcwc2pNtLnAXhsJGawF746bJxnMfP0ozA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rW9Jgen1WT36iraEyiS1uclCCJ3jg/46p8547Suzi4WNdzD8oHE0E4SPBAsrjoeVmUaWtHVBlFLll8ZFqyBi7jt5BsDh3bxoP2N3XLxbUGQsQRzYXkpEYKLNHOwYzDV9TLNOSlAQJF2DyBNnwi0bxNrzkc0FlVlbXCJE+pG1zWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uKC/0+dW; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gagr6iXdEA0Bsh8lVP454fs78RIPp/1ZT7AB6R2GTLiiWMrBjXTVxmuScC0oqUZ6PayiMyAUuW6tOJ8eKQ7yRiHUN+zjM2ulOZDJI0gD0HQMN8RavmeOF6SL24+wl5nd3GNzz/DYtr28T7n9HxPoHUFU5+OVHIwGX/q+JYm/fOn1uVZdBHd+6Aq7+R4dtU1O+x0CXOKcsIbhULye65l/ncrOiKnNcopteFg3Tz/l/U82AfZztIXyvjVbaRIkMYiLAOHmeN4aATIHI6nAkuYcrxlHYGY6tdCEQBvp71fvdikGXgBzOeVDk/9lCnPODhl/ZZIyF2RSFb6T7cwDCUmhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p83mSeWseQ9wgfPlsc+TlLNYlklaetGevFgODNZGqF4=;
 b=IDGtePbRjwBTQJZwQSwKhlBExyLbALZt2cIW0Kc73YTqBnBiHtAoGzDo3qwRC1m+viXb2nOxN8Uy0J5YsDEYJVHgjYvvSXqch7oYcJl1azC9FrfkJSXpUDml/1vmLe6jcoMmMA4odA08JhdDHAKMCrDH7aRiR5SWxfi5MvsFi4o9eup41jMy8yuBO/2k7i1DFzgpF2R0WcOhBEWZdaBTSj9wVzt1OSbHbOzBqZyaNoandxslPDULlSysmXxQygCbVlOw2Iy/mL3wVuZrJ6QjkLa8Jn6nuRoqyD6s2pvb+6Ph15aZu2YZfK+jo9GHdvYVQ9UVgX0JW4FA21iHlbIiVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p83mSeWseQ9wgfPlsc+TlLNYlklaetGevFgODNZGqF4=;
 b=uKC/0+dWrodNDuRVsvgQFjmIGwMIV4gGMQ5zliSrJIDwJpdi8cDtcYsZhLxOmV8bC+DwFWU8eQDCF60WidfkYlRICcn0lVzKyZ+VDjyp7NrVKjkRvX7i4V4Z8Y2AV1KdOGt2W7OUVLRPCnzBGMKBLih+sTFMpGiuoJabA5zb1uA=
Received: from MW4PR04CA0228.namprd04.prod.outlook.com (2603:10b6:303:87::23)
 by CY1PR12MB9582.namprd12.prod.outlook.com (2603:10b6:930:fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:11:03 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:303:87:cafe::61) by MW4PR04CA0228.outlook.office365.com
 (2603:10b6:303:87::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.25 via Frontend Transport; Mon,
 28 Jul 2025 06:11:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Mon, 28 Jul 2025 06:11:02 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 01:10:58 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <arnd@arndb.de>, <linux@roeck-us.net>,
	<Anand.Umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>, "Naveen Krishna
 Chatradhi" <naveenkrishna.chatradhi@amd.com>
Subject: [PATCH v1 1/5] misc: amd-sbi: Split core driver as separate module
Date: Mon, 28 Jul 2025 06:10:29 +0000
Message-ID: <20250728061033.1604169-1-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|CY1PR12MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf50a74-49df-439d-310b-08ddcd9d87cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bfnGr0WIRQ2VP0tNhfNlDcCYO2lsOd0VEhfO23eVRzxAsICJdx6kdOUlZMeg?=
 =?us-ascii?Q?ubp63gd336hw5gfKDbsEE8gaMVVnv+aPR6I035JuLa0HaQIigq2lG5kOu6F2?=
 =?us-ascii?Q?UsEZmpLYpHgzZpfJ73sMhEc5tn0BnKelL6BZqgOhNy14AMnVYb0Kyz4dJGcG?=
 =?us-ascii?Q?CqV5K8GvofiAfyQ/R6Jf7yLIhx9sHgG2EtylIWY19VxQ1UKQY4QEu++mG8ua?=
 =?us-ascii?Q?CXrwrqD530ZpkANw7TaRHPiYEIUO3LzepnYs2IH5CaUq0GQHqi5pHngGjOlO?=
 =?us-ascii?Q?NTMBjY0xTkyBhGSL66GLsZEUCcXJpnxKNvCr4iCDDWaLNTw+e3hRke8QI026?=
 =?us-ascii?Q?fpBK2qzpwFlQCGJqQ0nPMBwiXjB7qrkJIkCPuDOQKwxDWb4aSnQD+1RaOIaf?=
 =?us-ascii?Q?Jh0ifCqJBeF2klYiL3qQYwSYGITUHiTHKHzM9PXtigFtSxsFG410E5eZNxVs?=
 =?us-ascii?Q?mjmH19QiyPrEfbpJgOvH/CcAn9c3mu1ZP+o2ydxv/Na8JcU+ufQ578D1MX4n?=
 =?us-ascii?Q?78gMkE1syseNUgETe7miiDNHKBdE+eLQiRzsXhQAWD+A2FEGSZhheT2UtmXZ?=
 =?us-ascii?Q?RZ1OlwqsMVFO68aQ0qFSgrKnuLt8fOdtcz0l7Jt2kusJoNGurg1762EWkd1a?=
 =?us-ascii?Q?D+LKMelcK/+sO4dc1wjD0y4QwAaaTRvw6EBNCPzp7p9xQaAqgI+ylG3oXZ8p?=
 =?us-ascii?Q?CJOBhCQ+E/I85V1YlxzseQ/ueNr47vxgUyvgpfAVMd1oqkkQDYs+HAMvtf7m?=
 =?us-ascii?Q?RPxu5XVut55X+9YMN3Z+/lCtT+pM5GLZZqIjOS4EJ6Ddofy8DgeA/sRgVr1V?=
 =?us-ascii?Q?npwGo/U0PIjAj7nhBdxJJzqv/pOY2JlUX2CGbsVgWcVC3V93P89bJId4rvOF?=
 =?us-ascii?Q?rW2vltENEa0yfSK5hInpefcjwW9lAZzGxT9KKMyUjyJRmnaEkk//HEkvl3nc?=
 =?us-ascii?Q?43k8cEH0q0jKJdm/XONfR7g64AwtWWQd6X804PAw7AX/vd3qDQA9v4qEG/Xr?=
 =?us-ascii?Q?9QHLt4immHxYvSnzmlFYco3Q8oZKlYgoxLpHhSH7bbJPyu6nGcelSxFZJx4t?=
 =?us-ascii?Q?RiR/FOdp4W4b/1bvTEKk+uz5cJN4PdBFDo9P+UGpvvOIhiKhCN3uI2Io2LSy?=
 =?us-ascii?Q?Ju1es0OcaUWlRqqg1BucEgPwm7gcmV+qkmtN0vXkl5lVW+js0G+0tPISIDLW?=
 =?us-ascii?Q?Tc+g8Fl8Hb6zpUMa4MMcjyidkxdmAzei+x8y6AjEWF7bKz6lbQzvXARBu5Lx?=
 =?us-ascii?Q?P/O1G9u70WFsDpvQSnOR4LgeiH7Wvou4bTZJXP1sezOY2SXO65l6e1fbJoem?=
 =?us-ascii?Q?5HzU6/TBNl9DBymT3wY1EEFPQd/5lYQggMstySba8WnDajQToJakPfICPnPR?=
 =?us-ascii?Q?1SpBf34acSa2F3xSAARfJ47yMVFf1Nf2D18j448gz7IWKmHZCCFQIts83cjD?=
 =?us-ascii?Q?SJSOynAswpdOhx8IGYlvWRq0i3FLbwC/IFIfdtGPNUcttH5GCz5HCJs2+Kk6?=
 =?us-ascii?Q?jqK41mNTpkQb7Nu8JDOh/gdNtq7ldSbjR0u0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:11:02.7198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf50a74-49df-439d-310b-08ddcd9d87cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9582

This change is in preparation for enabling SB-RMI access
over I3C along with present I2C bus.
Split the core APIs into a separate module, export those APIs
to be used by the I2C and I3C modules.
Introduce a config option in Kconfig and update Makefile accordingly.

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
 drivers/misc/amd-sbi/Kconfig     | 11 ++++++++++-
 drivers/misc/amd-sbi/Makefile    |  6 ++++--
 drivers/misc/amd-sbi/rmi-core.c  |  5 +++++
 drivers/misc/amd-sbi/rmi-hwmon.c |  4 ++++
 drivers/misc/amd-sbi/rmi-i2c.c   |  1 +
 5 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/amd-sbi/Kconfig b/drivers/misc/amd-sbi/Kconfig
index 4840831c84ca..9b1abeb6ab1a 100644
--- a/drivers/misc/amd-sbi/Kconfig
+++ b/drivers/misc/amd-sbi/Kconfig
@@ -1,7 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+menu "AMD side band Interface(APML)"
+
+config AMD_SBRMI
+	bool
+
 config AMD_SBRMI_I2C
-	tristate "AMD side band RMI support"
+	tristate "AMD side band RMI support over I2C"
 	depends on I2C
+	select AMD_SBRMI
 	help
 	  Side band RMI over I2C support for AMD out of band management.
 
@@ -16,3 +23,5 @@ config AMD_SBRMI_HWMON
 	  This provides support for RMI device hardware monitoring. If enabled,
 	  a hardware monitoring device will be created for each socket in
 	  the system.
+
+endmenu
diff --git a/drivers/misc/amd-sbi/Makefile b/drivers/misc/amd-sbi/Makefile
index 38eaaa651fd9..6f3090fb9ff3 100644
--- a/drivers/misc/amd-sbi/Makefile
+++ b/drivers/misc/amd-sbi/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
-sbrmi-i2c-objs  		+= rmi-i2c.o rmi-core.o
-sbrmi-i2c-$(CONFIG_AMD_SBRMI_HWMON)	+= rmi-hwmon.o
+obj-$(CONFIG_AMD_SBRMI)		+= sbrmi_core.o
+sbrmi_core-y			:= rmi-core.o
+obj-$(CONFIG_AMD_SBRMI_HWMON)	+= rmi-hwmon.o
+sbrmi-i2c-y			:= rmi-i2c.o
 obj-$(CONFIG_AMD_SBRMI_I2C)	+= sbrmi-i2c.o
diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index 3dec2fc00124..6a7d0bb33bf8 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -352,6 +352,7 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	mutex_unlock(&data->lock);
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(rmi_mailbox_xfer, "AMD_SBRMI");
 
 static int apml_rmi_reg_xfer(struct sbrmi_data *data,
 			     struct apml_reg_xfer_msg __user *arg)
@@ -482,3 +483,7 @@ int create_misc_rmi_device(struct sbrmi_data *data,
 
 	return misc_register(&data->sbrmi_misc_dev);
 }
+EXPORT_SYMBOL_NS_GPL(create_misc_rmi_device, "AMD_SBRMI");
+
+MODULE_DESCRIPTION("AMD SB-RMI common driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/amd-sbi/rmi-hwmon.c b/drivers/misc/amd-sbi/rmi-hwmon.c
index f4f015605daa..e5d234549b5c 100644
--- a/drivers/misc/amd-sbi/rmi-hwmon.c
+++ b/drivers/misc/amd-sbi/rmi-hwmon.c
@@ -6,6 +6,7 @@
  */
 #include <linux/err.h>
 #include <linux/hwmon.h>
+#include <linux/module.h>
 #include <uapi/misc/amd-apml.h>
 #include "rmi-core.h"
 
@@ -118,3 +119,6 @@ int create_hwmon_sensor_device(struct device *dev, struct sbrmi_data *data)
 							 &sbrmi_chip_info, NULL);
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
+EXPORT_SYMBOL(create_hwmon_sensor_device);
+
+MODULE_IMPORT_NS("AMD_SBRMI");
diff --git a/drivers/misc/amd-sbi/rmi-i2c.c b/drivers/misc/amd-sbi/rmi-i2c.c
index f891f5af4bc6..e90ab0a5f8eb 100644
--- a/drivers/misc/amd-sbi/rmi-i2c.c
+++ b/drivers/misc/amd-sbi/rmi-i2c.c
@@ -127,6 +127,7 @@ static struct i2c_driver sbrmi_driver = {
 
 module_i2c_driver(sbrmi_driver);
 
+MODULE_IMPORT_NS("AMD_SBRMI");
 MODULE_AUTHOR("Akshay Gupta <akshay.gupta@amd.com>");
 MODULE_AUTHOR("Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>");
 MODULE_DESCRIPTION("Hwmon driver for AMD SB-RMI emulated sensor");
-- 
2.25.1


