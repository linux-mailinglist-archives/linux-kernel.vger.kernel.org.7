Return-Path: <linux-kernel+bounces-816638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E780B576A3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0A91A2298F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC9D2FD1D9;
	Mon, 15 Sep 2025 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yAlq8k63"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B0B1EBFE0;
	Mon, 15 Sep 2025 10:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932652; cv=fail; b=cb3l6v/a0HChj6qnpvw4YveX9NuQVMJ591XNq0i3bSpEZ7LnSSyG3TcbV3cgdh4D9JtriYc92TwdV+0ipXCYRyoWaGL8Kn6AAPN9ItKY31Zg5w59E9xzNRcFA5rQ/Y2sVaqEQVWNDTZfpbU2lFGqbS30SHIHjJNYLpRTzcBTzto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932652; c=relaxed/simple;
	bh=kd0vlpjV8t8lM2Dbj8RYI1ufIoLfHleNR4uI7unJ7BM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghoMVOzQyJNpyHuWHjM1aM9KQvd1ri4jcXxs44WVCJ4zcbyKDH93BzT18GYFgF9Bv3gGeDsi/4grfDjiLoYpcO+1GSgFazdxpSbn5en9IotVJLgN9RjRbO8v8eYoMIkBrMHsQuTIICm+IXFk2K/q/s33mOxZyFjquVTtQWMyJ9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yAlq8k63; arc=fail smtp.client-ip=52.101.48.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHODrHKV4DV5UefLaaqhnJRBTlMGz/BDIXDleECZhdPADEeM6Zqvd1Mj9fdPUfWND5OdOsLp8zswZ4SyO5SHo2k4s6w7+VtSL/PrkKc1iz/+HZcVNAs1ZemWCxMpZ7TSN0myv7CyNgzt92H9G4AIUmpo1hLKYNKEifUjLMXnsCKo6HHBBNBavNwTibogRfctsQt9ILFxDPb46GpLwpQnSVK4XjkFpfBf3ixcob45vnLiMI0gJEi+1VWh6s5qjpLd9DSgahaio2xf/PT9LHXc8oqe7LfL7cuT3LFBNjk/aMxJ1RzLGAMGuDDqAaYHiFMWQleEAzObT86+fGFQ3HjowA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dor91iOMYvFSF6oweNnb6jot4Qz6Cq9F53rOZdqFsaY=;
 b=e4RZn6Ts7K0D/wGHmP4FimiZu11yXbvlg02zp1Xy7vxW3B9ZPuIFHK/5RgUA/OcTOyppL7H6OBUzIXCb5bb8K8JyvnGNcY8519K+41HtvMOXQP1dDjxqHQjuArfpoIJT9bwrPYeSsSj05+8Ip3mv9g3y3pVPWoUZdGffxtOmBpcr/qAIycHz5sV9i5UtBL+u2Adc4oiJkXDg2/fuchgK9AHxB/tDG47kx6L1cwrnoPOarUbZ6QjL91SMaFpp8j8fFqA72abN2QxxSkwmLa4KpDP6kj9+6I+VkqscwpzHLU9cyBe09yFzFBr846FLj4mfkXY4TeZt1FXyLWAHDCVHpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dor91iOMYvFSF6oweNnb6jot4Qz6Cq9F53rOZdqFsaY=;
 b=yAlq8k63cRV3LNpSfit0oiB6Td2jvtFc+is2QRReHYFS+oNwCQrpriUfccRAdTRE5FPaf8+IL9Kck/TtHhuV1sGXtyycrur5+fx72v9Vqzsws1KZeKIsOyaCyRtphLfWlasz0UYXqlzmPsba4PXhMuC+u+WgcSXrj4tYWRdeDNk=
Received: from SJ0PR03CA0381.namprd03.prod.outlook.com (2603:10b6:a03:3a1::26)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 10:37:24 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::67) by SJ0PR03CA0381.outlook.office365.com
 (2603:10b6:a03:3a1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 10:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 10:37:24 +0000
Received: from amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 03:37:21 -0700
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <arnd@arndb.de>, <linux@roeck-us.net>,
	<Anand.Umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>, "Naveen Krishna
 Chatradhi" <naveenkrishna.chatradhi@amd.com>
Subject: [PATCH v2 2/6] misc: amd-sbi: Add support for SB-RMI over I3C
Date: Mon, 15 Sep 2025 10:36:45 +0000
Message-ID: <20250915103649.1705078-2-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250915103649.1705078-1-akshay.gupta@amd.com>
References: <20250915103649.1705078-1-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df927b5-ed0c-4f56-6307-08ddf443dbaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k91IHX7GX15TA0MTwSx9t0JLiSTMyO8JBmikkGnO++psL/vlouDN4Cru1bgn?=
 =?us-ascii?Q?Cd73XauArO6OP5pqOc37Y7M3H+eZn9FFxb9f2waDTfY7d75EEZecm+mfnacb?=
 =?us-ascii?Q?lg469yYmouNB3FYrqkK59dDKDBbFPnF4uKTctEw2MLAT8cIHqI3PnXkJQH8b?=
 =?us-ascii?Q?ArwiVlSRubDwElputH2EeWWQ0y27tXhIpIi0JxitA9LNtBR2EA5aRufbq5Qo?=
 =?us-ascii?Q?CZOxSn0QXu0A3p3bFhHPy3SDbJB05z+ciI+vIhKujDH3CdB9yca7nFMyu7id?=
 =?us-ascii?Q?SwuhtGPthUx6H07ztP6szGB95Df7yaY9DBBSLX6zEL89WAEQ2wNxVINK3gBs?=
 =?us-ascii?Q?r+f7yJQKxesC8gZCvM4d0Vi3X6aTFIoRYqOoBeNB3Ki4R2vuizV8JzgQuF+6?=
 =?us-ascii?Q?MPhAaumyTne97xPzAIi7YK9qQCnrRcy/7fvAOHqhm7l0dq9mh3GSe3Gz2w3U?=
 =?us-ascii?Q?eL3JBxHB1GwVJuCYPhGGiRkzBh633lipHc7yrDRT74FWsYVPrF8w8WdlQU2K?=
 =?us-ascii?Q?CRBrF7lGjU/59aBgR7YpSgLXS1+5NDEAoVQr8jUYV8xP5cUiegx7MIrMevaf?=
 =?us-ascii?Q?Qo6/uqZ8cP2B7Q774TkJgAkPwHK6wNf7TcQ5StuFEP2CjEQEf+zIGmY/dxfI?=
 =?us-ascii?Q?wNKBbGFTZ3HvQkKyNQ3aBXpjcHX/t8jKD3FgKd2jAkQWzvh+FaSqoeV/QlVD?=
 =?us-ascii?Q?Q1SezhCn9QJV/K0TTvEkGGvzczFDW8LTrk5zkGNY5zny5cBrUCUHAe/b7MvN?=
 =?us-ascii?Q?KubQ/SO9YpgcTHTDHVXmDiREsmet8IV6i2XXtzSk0nP37p9O/GDCJb+UToRt?=
 =?us-ascii?Q?z7WS0ZSqLB6t9l587VUs/tjhKF4FPD2fIg/BySBZ+Km4m2KzZODtsZssZzuF?=
 =?us-ascii?Q?q1C8KsK25ggUvw0dgTb8nRJJlAIjCmTNzuQxFbkDBeW8XqwqEddZhZ600POf?=
 =?us-ascii?Q?O/dN9Lmko52RDjbh8J6YEmrWaKOmXn13fSzklH0+SG3DTnAlOmn0BMUf/FDF?=
 =?us-ascii?Q?mFSwbXqIMoO1sy5FIzvyrbSM6bag2XT549xQnle/Zk3uzeCsfkQsCqtj6iNF?=
 =?us-ascii?Q?A/2yvntvt8La10BFH+QiGf467tdTrRVQiH9KCDBsezx3LKher6ajBvC4i7dh?=
 =?us-ascii?Q?gr74V41dGebtpJoW2ZCV5zown/5pcuveb8o05n45T3Ryc14xSF0oeqlDUbZt?=
 =?us-ascii?Q?ZDefO7gXE1N00CE6wpvNswtDekDyMzAJamd9Q4EZe9KWAdAsUZdg1uLsR3H+?=
 =?us-ascii?Q?hBwYQXrQom2Nt72nqmE7EQpb9AQX3+ydcqcA8gcFdktjnZKi4iH8YsanQ6ZM?=
 =?us-ascii?Q?Ypdst3R4ei+A5IkkVFPuo1AkkL6mJU+0YmunTUwT8wtJpIxHoNwIjKYSb8gn?=
 =?us-ascii?Q?CE7Wmydq2IlmeZcbes+N+oO2/wa3mHdTMn/PYt+6+uL7utNt6MlLZ2+G4jtI?=
 =?us-ascii?Q?ecvL9eZV6ypaWVZEJTOIenGHJYY0HBzM83TFra8trq81rkFPrSOB6Z75pb7Z?=
 =?us-ascii?Q?M/IQ5HltDEXEv5VCy7NZHrEPTh1ItE73vnNk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:37:24.0509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df927b5-ed0c-4f56-6307-08ddf443dbaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532

AMD EPYC platforms with zen5 and later support APML(SB-RMI)
connection to the BMC over I3C bus for faster data transfer
up to 12.5 Mhz.
I2C and I3C is supported in same file using module_i3c_i2c_driver()
with probe based on dts entry.
AMD APML I3C devices support static address for backward compatibility to I2C.
I3C static address can be used to assign I3C device dynamic address.

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
Changes from v1:
- Address reviewer's comment
- Single module file for both i2c and i3c,
  hence no change in common function 
 drivers/misc/amd-sbi/Kconfig   |  4 ++-
 drivers/misc/amd-sbi/rmi-i2c.c | 45 +++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/amd-sbi/Kconfig b/drivers/misc/amd-sbi/Kconfig
index 4aae0733d0fc..acf0450ba220 100644
--- a/drivers/misc/amd-sbi/Kconfig
+++ b/drivers/misc/amd-sbi/Kconfig
@@ -3,8 +3,10 @@ config AMD_SBRMI_I2C
 	tristate "AMD side band RMI support"
 	depends on I2C
 	select REGMAP_I2C
+	depends on I3C || !I3C
+	select REGMAP_I3C if I3C
 	help
-	  Side band RMI over I2C support for AMD out of band management.
+	  Side band RMI over I2C/I3C support for AMD out of band management.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called sbrmi-i2c.
diff --git a/drivers/misc/amd-sbi/rmi-i2c.c b/drivers/misc/amd-sbi/rmi-i2c.c
index d41457a52376..087c57bb0f37 100644
--- a/drivers/misc/amd-sbi/rmi-i2c.c
+++ b/drivers/misc/amd-sbi/rmi-i2c.c
@@ -9,6 +9,8 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/i3c/device.h>
+#include <linux/i3c/master.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -135,7 +137,48 @@ static struct i2c_driver sbrmi_driver = {
 	.id_table = sbrmi_id,
 };
 
-module_i2c_driver(sbrmi_driver);
+static int sbrmi_i3c_probe(struct i3c_device *i3cdev)
+{
+	struct device *dev = i3cdev_to_dev(i3cdev);
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i3c(i3cdev, &sbrmi_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	/*
+	 * AMD APML I3C devices support static address.
+	 * If static address is defined, dynamic address is same as static address.
+	 * In case static address is not defined, I3C master controller defined
+	 * dynamic address is used.
+	 */
+	return sbrmi_common_probe(dev, regmap, i3cdev->desc->info.dyn_addr);
+}
+
+static void sbrmi_i3c_remove(struct i3c_device *i3cdev)
+{
+	struct sbrmi_data *data = dev_get_drvdata(&i3cdev->dev);
+
+	misc_deregister(&data->sbrmi_misc_dev);
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
+module_i3c_i2c_driver(sbrmi_i3c_driver, &sbrmi_driver);
 
 MODULE_AUTHOR("Akshay Gupta <akshay.gupta@amd.com>");
 MODULE_AUTHOR("Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>");
-- 
2.25.1


