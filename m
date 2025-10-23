Return-Path: <linux-kernel+bounces-866262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26936BFF51C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B959F19C45E1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4171B7F4;
	Thu, 23 Oct 2025 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aFzqkcmp"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F896280A51
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761200405; cv=fail; b=VAYR/80wIaaDHLVXcfG9lXWehS+EGOOEYTx5uhh/zEF6FdqQcmhbK5UaOKmcuDfKCaeQV637MQnMZFRiU3bXC8m56+5ffUD4HLqOpNao5iHytDYTkEL3X/8jvqXe4308IYxBz7d4n6zycjZkgFf5jQ4ptHSICe8vQNMatsFLz18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761200405; c=relaxed/simple;
	bh=2bpU/gaqkNZ8oR40DgZevph0dAUlrj9pIGjWTO2bJQ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oU035XbqCG0RLPqtU2pyn7KjRgrO7Cy/0O/LU1qZL72RNprik+jQR500M5ePWGInnkcS6ROKQyHRbQq9O0vizI33zzzp11q479lsHoUzJn/K3fnY4x75/bn/J8CvMD26/wB5kZclMQETde7WOMPlo9EtNzIGG7rxUoloKb27Yjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aFzqkcmp; arc=fail smtp.client-ip=52.101.62.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejrAUdjtgxhVxKJ0GNLigwRiHekkm9f9wf81MNgMw/Y2kgwY4sUT5WoAjl1BfvZIih/V6ELJg+pE06x3gl5fZk9+8P/jxMDhpI/o5+NCPCRl7JsDj6xmG4H4/Q5S0q8Mkf6N16PNOq+sMeWjwjcHSMG0fWbCVc1dvO4n7TGZcNH4d4YNp1Cy7HFk2yn9Ye0qpTw75Xi5NB77eBLX1v6kogzYCsOjvzShVOvoc/zle047bkFsKfqvude6B1bXxtbxBvz5JGKKK1DAEhh6aUzT1yE+wFU2xFJ8CZJQIVnx1DfvttMXMdR1JH+k/wYpg+Ei7g/NtevaGLvw+FzWvKy8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIRsEEfx0oN85T6egk+pbUHC4bo6l8sT0TB5rGZzKTc=;
 b=MdVhjbjLJrWGFr+qJsHfeo7qxqcxpkyUzpyU/w7IJYY0sBAbyXvcSz2Z9mrbfruCkGZ6TZIqcA4XuqjhTKj+XVNFXsGLb2pXnaLqJY/eSNqCBj9O59q4wl3yN8zvefMOYcEt0g2te76LOxKJYmoGZTQR+LYOhPpJodoExLUasnlOhuWSC5czxDxN2k8MuomnMXJQQiVVbZkCZv20nDOfjO1gsxgnBcg5YEwT6h/aTnWWvEweEK8YGE4u2zhxumB8AHktUUzTbhxGaULQANoWdK4G+Bx39nkXkDR5+PZP3XPrCXKfHwHS+VGsXQej29RaRg8ENXNiiH8Dxjhpo+p+og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIRsEEfx0oN85T6egk+pbUHC4bo6l8sT0TB5rGZzKTc=;
 b=aFzqkcmp6ZujCFwd7Yo+AcU8ZG/vHczdE70gcddZpYn1v5XgNkaLiwXaG2GtZH1SKGYZADXUQEmEx1dPo1kBsBpyNap83JAO/J5cBHsC1zGIYSgmcpaY/3zpM5d7TiuZUGgUbwE6r9wZrqL9k/NLQo7rYIqUTxJ0h7rniTlTHDreWbs6uxCmzGx6PKNDOGIRTK7CEwL32bRRkFkiTJRyiRE+YBHkAKaicfOaJ8JthjR8unTdKtI7Qd9WCwW+fvHWW6Od/T7RbmPaz9+2zoAIQjOFq9aIxvZJloWK1z511SmGaFeCG/RqlLjkc1KdrFl1Waw6auvxjVawGAK/ST85QQ==
Received: from PH0PR07CA0030.namprd07.prod.outlook.com (2603:10b6:510:5::35)
 by DS0PR12MB6462.namprd12.prod.outlook.com (2603:10b6:8:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 06:19:56 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::34) by PH0PR07CA0030.outlook.office365.com
 (2603:10b6:510:5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 06:19:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 06:19:55 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 22 Oct
 2025 23:19:44 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 22 Oct 2025 23:19:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 23:19:40 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Aya Levin
	<ayal@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Simon Horman <horms@kernel.org>, Shay Drory
	<shayd@nvidia.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, "Parav
 Pandit" <parav@nvidia.com>, Amir Tzin <amirtz@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net] driver core: auxiliary bus: Fix sysfs creation on bind
Date: Thu, 23 Oct 2025 09:19:27 +0300
Message-ID: <1761200367-922346-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DS0PR12MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: b1cbd27b-5a91-4be6-5bdd-08de11fc2f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WWlnQUIWfASVIxRhSalfHwVcwHd2mEc0xoXxXRzeAvZiUccs92269x6AnZLT?=
 =?us-ascii?Q?N9tfftkzvm9lnDwXcCDB54izLucsYAM9CCZa52+MExl3QQgrby/JqPqM2TvA?=
 =?us-ascii?Q?Q3akLvX9Y11uQA2R7jVZW10lo+q0lfVDEG2zANwc6PdHBdcDG1GF1VGc3WEy?=
 =?us-ascii?Q?O69YCBbp65205xBmFzui5/uFLMdUlr39fzKAWqeFRhchbEf8lZZiha7IKIPJ?=
 =?us-ascii?Q?0rR1tegw0/r8yqOYFjXyXeGQuFdp2Gn+bL2e3bGVWW1tX4lqwaSriQACu4Pw?=
 =?us-ascii?Q?PHVtR64Hvo9MI2uNFHk2opGOMWwH/ai/uf11c8EO+g2vXafsYU6EAspD5Oft?=
 =?us-ascii?Q?BjJx5kdjQeRehib8MzJ8URLsllcZiyPCeQ8qsDwTyf6dW6gCnuzQJjkFnqqt?=
 =?us-ascii?Q?UK5iMDzTRCLJYcMN4H/wiJu5t2fULF2mTKrwqBGsHE0/BJ0ufafI+7u8QpbY?=
 =?us-ascii?Q?KeQNITHysiBKlpkgtNU1JI53v2JWY/oA6o/2fIUVnyNsURZYT9JkHcX64rkV?=
 =?us-ascii?Q?mgKRYWPR6WRU4omORW4BGxjU0GGN5xmV3oYnjKeGzmEqakwmQmy1coKmSsm1?=
 =?us-ascii?Q?kKQf8cRMgD2Rg7axEBYZ6u3SpPydJ+71OPqlymvCpSMvCV43eSXKugU8g/qn?=
 =?us-ascii?Q?L/LN5bcpAv7Tv460FpWZEacYTC2XqgT2AuvlhtGIt8vBqDQp4VEy7iBJDq2w?=
 =?us-ascii?Q?KIvLMhvNmeW0HPhlA6p+bfnaPEPwfsEaO3y5i2Ra0xW2UOiGqvsnFV28KNFR?=
 =?us-ascii?Q?u3QexohLJjNKJPl8knRnxh49ZYId4mcJzlfJTGNjhnUpi+zD5DO728ow5XXM?=
 =?us-ascii?Q?jB9I/bSV/eB/2GRi1ErdOMU8fi8kPwGjGiybL8h3HAO5r1RhqzSnGpAuddPi?=
 =?us-ascii?Q?uXlWRKMEDaizY3+3whRYb+sjucdeG6nIPkUbJ94PvmYnDnrZmI2vUHDDSJ5Q?=
 =?us-ascii?Q?0qE9MGO+luhADyx7Q4mq70REchqbOzz66sMe3gcjpKeQANvpIIJMcAPTHKrq?=
 =?us-ascii?Q?OqxiiskdIORs9pftmrQlrMZ6AyaPH33g1wFU5bq2FC7uIXWCadx417n7heWQ?=
 =?us-ascii?Q?n1iLUXrJ2XrV4oNA9AEJ44nEi+eaOpKuR2OubBG4P/PEPsaYChu2z5AJ5CYF?=
 =?us-ascii?Q?PK/+gOEbnpyHUrkOjm9kUZpCGOI8Z39edBLpPZTwJvoSE1sLb3+O3V9UROWs?=
 =?us-ascii?Q?e1ofdwi0UNKiEGhKv6/UuyZFVGtGeU01J485y6uBkBGZI6tnizHUjgWFci0/?=
 =?us-ascii?Q?PqmzsLJcZfCn136u37P1yVzat+rBUBQKNdMpB5xe3PUz1+twlUUCDDCdNRwH?=
 =?us-ascii?Q?qDiaUHXv6zNuW8ZmOqGerXt5oFHvP89WvxA4WSwwMoYr695JU7vzyW5PoWlG?=
 =?us-ascii?Q?rC/jbRPjzDPtC1R9jU1Ps7YmMmcHESKxTQrJu5D0e7FxALrnZJLYmlJ0mZi6?=
 =?us-ascii?Q?5dHaO1nA6HTmrhlsAIS9ReC5Ks9tFu11MS50tZ2k6OOoFmk0n19ZLPED9ZEt?=
 =?us-ascii?Q?22qXnSoVKZ29Nu35Ce5kkL8S56Shemlwyu1Cbr/5tpcri/+hspagdwWeE9OE?=
 =?us-ascii?Q?am6CG4RsDzUpw3rk8dY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 06:19:55.5941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cbd27b-5a91-4be6-5bdd-08de11fc2f5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6462

From: Amir Tzin <amirtz@nvidia.com>

In case an auxiliary device with IRQs directory is unbinded, the
directory is released, but auxdev->sysfs.irq_dir_exists remains true.
This leads to a failure recreating the directory on bind [1].

Using the attributes group visibility interface, expose the IRQs
attributes group if"f the xarray storing IRQs entries is not empty. Now
irq_dir_exists field is redundant and can be removed.

[1]
[] mlx5_core.sf mlx5_core.sf.2: mlx5_irq_affinity_request:167:(pid 1939):
   Failed to create sysfs entry for irq 56, ret = -2
[] mlx5_core.sf mlx5_core.sf.2: mlx5_eq_table_create:1195:(pid 1939):
   Failed to create async EQs
[] mlx5_core.sf mlx5_core.sf.2: mlx5_load:1362:(pid 1939):
   Failed to create EQs

Fixes: a808878308a8 ("driver core: auxiliary bus: show auxiliary device IRQs")
Signed-off-by: Amir Tzin <amirtz@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/base/auxiliary.c       |  13 +++-
 drivers/base/auxiliary_sysfs.c | 117 +++++++++++++++++++++++++--------
 include/linux/auxiliary_bus.h  |  26 ++++++--
 3 files changed, 118 insertions(+), 38 deletions(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 04bdbff4dbe5..b0fb31279257 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -225,7 +225,16 @@ static int auxiliary_bus_probe(struct device *dev)
 		return ret;
 	}
 
-	return auxdrv->probe(auxdev, auxiliary_match_id(auxdrv->id_table, auxdev));
+	ret = auxiliary_bus_irq_dir_res_probe(auxdev);
+	if  (ret)
+		return ret;
+
+	ret = auxdrv->probe(auxdev,
+			    auxiliary_match_id(auxdrv->id_table, auxdev));
+	if (ret)
+		auxiliary_bus_irq_dir_res_remove(auxdev);
+
+	return ret;
 }
 
 static void auxiliary_bus_remove(struct device *dev)
@@ -235,6 +244,7 @@ static void auxiliary_bus_remove(struct device *dev)
 
 	if (auxdrv->remove)
 		auxdrv->remove(auxdev);
+	auxiliary_bus_irq_dir_res_remove(auxdev);
 }
 
 static void auxiliary_bus_shutdown(struct device *dev)
@@ -294,7 +304,6 @@ int auxiliary_device_init(struct auxiliary_device *auxdev)
 
 	dev->bus = &auxiliary_bus_type;
 	device_initialize(&auxdev->dev);
-	mutex_init(&auxdev->sysfs.lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(auxiliary_device_init);
diff --git a/drivers/base/auxiliary_sysfs.c b/drivers/base/auxiliary_sysfs.c
index 754f21730afd..8ae3ec62b3db 100644
--- a/drivers/base/auxiliary_sysfs.c
+++ b/drivers/base/auxiliary_sysfs.c
@@ -13,30 +13,71 @@ struct auxiliary_irq_info {
 	char name[AUXILIARY_MAX_IRQ_NAME];
 };
 
+static struct attribute auxiliary_irq_attr = {
+	.mode = 0,
+	.name = "DUMMY",
+};
+
 static struct attribute *auxiliary_irq_attrs[] = {
-	NULL
+	[0] = &auxiliary_irq_attr,
+	[1] = NULL,
 };
 
+static bool auxiliary_irq_dir_group_visible(struct kobject *kobj)
+{
+	struct auxiliary_device *auxdev;
+	struct device *dev;
+
+	dev = container_of(kobj, struct device, kobj);
+	auxdev = container_of(dev, struct auxiliary_device, dev);
+
+	return !xa_empty(&auxdev->sysfs.irqs);
+}
+
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(auxiliary_irq_dir);
+
 static const struct attribute_group auxiliary_irqs_group = {
 	.name = "irqs",
 	.attrs = auxiliary_irq_attrs,
+	.is_visible = SYSFS_GROUP_VISIBLE(auxiliary_irq_dir),
 };
 
-static int auxiliary_irq_dir_prepare(struct auxiliary_device *auxdev)
+void auxiliary_bus_irq_dir_res_remove(struct auxiliary_device *auxdev)
 {
-	int ret = 0;
+	struct device *dev = &auxdev->dev;
 
-	guard(mutex)(&auxdev->sysfs.lock);
-	if (auxdev->sysfs.irq_dir_exists)
-		return 0;
+	sysfs_remove_group(&dev->kobj, &auxiliary_irqs_group);
+	xa_destroy(&auxdev->sysfs.irqs);
+	mutex_destroy(&auxdev->sysfs.lock);
+}
 
-	ret = devm_device_add_group(&auxdev->dev, &auxiliary_irqs_group);
-	if (ret)
-		return ret;
+int auxiliary_bus_irq_dir_res_probe(struct auxiliary_device *auxdev)
+{
+	struct device *dev = &auxdev->dev;
 
-	auxdev->sysfs.irq_dir_exists = true;
+	mutex_init(&auxdev->sysfs.lock);
 	xa_init(&auxdev->sysfs.irqs);
-	return 0;
+	return sysfs_create_group(&dev->kobj, &auxiliary_irqs_group);
+}
+
+static struct auxiliary_irq_info *auxiliary_irq_info_init(int irq)
+{
+	struct auxiliary_irq_info *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return NULL;
+
+	sysfs_attr_init(&info->sysfs_attr.attr);
+	snprintf(info->name, AUXILIARY_MAX_IRQ_NAME, "%d", irq);
+	info->sysfs_attr.attr.name = info->name;
+
+	return info;
+}
+
+static void auxiliary_irq_info_destroy(struct auxiliary_irq_info *info)
+{
+	kfree(info);
 }
 
 /**
@@ -55,36 +96,41 @@ static int auxiliary_irq_dir_prepare(struct auxiliary_device *auxdev)
  */
 int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
 {
-	struct auxiliary_irq_info *info __free(kfree) = NULL;
 	struct device *dev = &auxdev->dev;
+	struct auxiliary_irq_info *info;
+	bool sysfs_add_error = false;
 	int ret;
 
-	ret = auxiliary_irq_dir_prepare(auxdev);
-	if (ret)
-		return ret;
-
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	info = auxiliary_irq_info_init(irq);
 	if (!info)
 		return -ENOMEM;
 
-	sysfs_attr_init(&info->sysfs_attr.attr);
-	snprintf(info->name, AUXILIARY_MAX_IRQ_NAME, "%d", irq);
-
+	mutex_lock(&auxdev->sysfs.lock);
 	ret = xa_insert(&auxdev->sysfs.irqs, irq, info, GFP_KERNEL);
 	if (ret)
-		return ret;
+		goto unlock;
+
+	ret = sysfs_update_group(&dev->kobj, &auxiliary_irqs_group);
+	if (ret)
+		goto irq_erase;
 
-	info->sysfs_attr.attr.name = info->name;
 	ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
 				      auxiliary_irqs_group.name);
-	if (ret)
-		goto sysfs_add_err;
+	if (ret) {
+		sysfs_add_error = true;
+		goto irq_erase;
+	}
 
-	xa_store(&auxdev->sysfs.irqs, irq, no_free_ptr(info), GFP_KERNEL);
+	mutex_unlock(&auxdev->sysfs.lock);
 	return 0;
 
-sysfs_add_err:
+irq_erase:
 	xa_erase(&auxdev->sysfs.irqs, irq);
+	if (sysfs_add_error)
+		sysfs_update_group(&dev->kobj, &auxiliary_irqs_group);
+unlock:
+	mutex_unlock(&auxdev->sysfs.lock);
+	auxiliary_irq_info_destroy(info);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_add);
@@ -97,17 +143,30 @@ EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_add);
  * This function should be called to remove an IRQ sysfs entry.
  * The driver must invoke this API when IRQ is released by the device.
  */
-void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq)
+int auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq)
 {
-	struct auxiliary_irq_info *info __free(kfree) = xa_load(&auxdev->sysfs.irqs, irq);
 	struct device *dev = &auxdev->dev;
+	struct auxiliary_irq_info *info;
+	int err;
 
+	mutex_lock(&auxdev->sysfs.lock);
+	info = xa_load(&auxdev->sysfs.irqs, irq);
 	if (!info) {
+		mutex_unlock(&auxdev->sysfs.lock);
 		dev_err(&auxdev->dev, "IRQ %d doesn't exist\n", irq);
-		return;
+		return -ENOMEM;
 	}
+
 	sysfs_remove_file_from_group(&dev->kobj, &info->sysfs_attr.attr,
 				     auxiliary_irqs_group.name);
 	xa_erase(&auxdev->sysfs.irqs, irq);
+	err = sysfs_update_group(&dev->kobj, &auxiliary_irqs_group);
+	if (err)
+		dev_err(&auxdev->dev,
+			"Failed to update IRQs group, irq %d\n", irq);
+
+	mutex_unlock(&auxdev->sysfs.lock);
+	auxiliary_irq_info_destroy(info);
+	return err;
 }
 EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_remove);
diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index 4086afd0cc6b..06c247b647ab 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -61,7 +61,6 @@
  * @sysfs: embedded struct which hold all sysfs related fields,
  * @sysfs.irqs: irqs xarray contains irq indices which are used by the device,
  * @sysfs.lock: Synchronize irq sysfs creation,
- * @sysfs.irq_dir_exists: whether "irqs" directory exists,
  *
  * An auxiliary_device represents a part of its parent device's functionality.
  * It is given a name that, combined with the registering drivers
@@ -146,7 +145,6 @@ struct auxiliary_device {
 	struct {
 		struct xarray irqs;
 		struct mutex lock; /* Synchronize irq sysfs creation */
-		bool irq_dir_exists;
 	} sysfs;
 };
 
@@ -222,23 +220,37 @@ int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
 #define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, KBUILD_MODNAME)
 
 #ifdef CONFIG_SYSFS
+void auxiliary_bus_irq_dir_res_remove(struct auxiliary_device *auxdev);
+int auxiliary_bus_irq_dir_res_probe(struct auxiliary_device *auxdev);
 int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq);
-void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev,
-				       int irq);
+int auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq);
 #else /* CONFIG_SYSFS */
+static inline void
+auxiliary_bus_irq_dir_res_remove(struct auxiliary_device *auxdev)
+{
+}
+
+static inline int
+auxiliary_bus_irq_dir_res_probe(struct auxiliary_device *auxdev)
+{
+	return 0;
+}
+
 static inline int
 auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
 {
 	return 0;
 }
 
-static inline void
-auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq) {}
+static inline int
+auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq)
+{
+	return 0;
+}
 #endif
 
 static inline void auxiliary_device_uninit(struct auxiliary_device *auxdev)
 {
-	mutex_destroy(&auxdev->sysfs.lock);
 	put_device(&auxdev->dev);
 }
 

base-commit: c0178eec8884231a5ae0592b9fce827bccb77e86
-- 
2.31.1


