Return-Path: <linux-kernel+bounces-828793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57668B957A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5561619029BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B202032144C;
	Tue, 23 Sep 2025 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sfj2y5vs"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A88321442;
	Tue, 23 Sep 2025 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624317; cv=fail; b=OvEEgtuKX6z42CahwCqTYraIqQiaIL8wDN6XnGeMdZkw2XrCYk0tuN6VAOPhQv4cxQSvD92m7dcdPkJwPNKlbjhzAkybvEniclzkrU9yNkFwA/tiYeiAPS9lYdBRjNqW+8Gfxciw58hTZsaAizlYy7rnUriAZgIw8OljuTr47uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624317; c=relaxed/simple;
	bh=L1+U6Y16gwKrSwx0BVEzhx+t7FLtXT0NskF7OsBJOfY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3CcH13O3XXf8A5upC8K2aEIOGB35dDK9lOmkbXx/4vk7bmEA8BQJls8Kzdu31YzFLq4xpvD1poF90MTGdhEnAnhyTdcvIpsZhEv4eAOIYIdckFqCcb27VsIkzbb5ZbHPOLO8Hmmsji4r5BS65u+jGEIVzGRB5saqVF7Oi2SEfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sfj2y5vs; arc=fail smtp.client-ip=52.101.62.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTG2tvqQbmZZVOWWLtwd/40dmE0A7MoxO1zEFD1ahhKYnrwfgGd0HEBB/8qsuBN/OylkU3wcVM8UMji0KXmygOkMABBl2H8MRWch6J14RB75KOiLEg/lZC7e+yqNvgelgBtlDdCw1JNtCGeiE2/x1E59JxO5oXCdLueBOsJdpf21pzmnJd6LpZJvXhyp9wNKfOz5wTBKA6GK8T2z1w66A5qgeHQMofWsbVLWFVOZqtfwQ9Ow2MdWtGraV87gZLNr64BOu/aUy6NIPREtlkIl2tXpNo8dPdYDbhMxthC8o1P6OX2qan1auEcTniqpYmkYMNAwBXtiDjpu+rl/J6N8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBL+i12PJhxIyqCqwKVbOtnD8g3Dp23rfMlz+RIx4hE=;
 b=BQSTU+/aXT8jKGETVQ0NLBJZh5pa+qmbbQDyH3EkYa664Rcq5me0Vh0Y7c+BfZhq6STWX+VOs8Qo/IeOTSw3PqzBeV0VOY9QKAPBzEXHknaFSx5JgRLK4lqmt34i0cAGt80rTDJVxUX1Bdzjkybjx5gDHywOBDZZzP2/pr2z0Q4pTPfnBzT2CjBi/sfRCA/AK9VrwM3ZnHtx34Iec5RwQmPLeIMzrIPnwhGI/oiwDjKz8WuIOJHlhX7O9AzJyPoFKqrfN+jw48c0qH/NZoZ7HGyHdlT7azSmiN26B906X+baG8mU+eYnmIjw4oDgWSowkis3rZokP3jLQZPCkVIWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBL+i12PJhxIyqCqwKVbOtnD8g3Dp23rfMlz+RIx4hE=;
 b=Sfj2y5vscF9HDjChF20g+7S6g13Pd7LiyWlR4juamkcYA+a0qbspUbjsgBv6KDAPsEvzoHwKD6Ws0/uxASKGEOJoR8efs7qQ83FsSNI0XMxS5IPhQz5c9mzlwdMgujFTQqR74aA4PfurFqNEAsZ2hZNpbtb/8+UuhZSweOEf6AGXnp5SpNZ9P0HNd/M4VCygXdKBWbylSUzu336XCqjOjq3I/C8ePlYAFXTWA6XaLTh0BP3Up2SP5+gv7p3n4YR+cgwjye0APMfR1s2L+vtOahpMMpesz0tV2WAL2VaneYyfQQLOz8lBpD6E1HkYHPkAZZWCEI0+PPgjxaVmmOk1tQ==
Received: from DM6PR14CA0053.namprd14.prod.outlook.com (2603:10b6:5:18f::30)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 10:45:10 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:18f:cafe::38) by DM6PR14CA0053.outlook.office365.com
 (2603:10b6:5:18f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 10:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 10:45:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 23 Sep
 2025 03:45:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 23 Sep 2025 03:45:04 -0700
Received: from r-build-bsp-02.mtr.labs.mlnx (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 03:45:01 -0700
From: Ciju Rajan K <crajank@nvidia.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<tglx@linutronix.de>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
CC: <christophe.jaillet@wanadoo.fr>, <platform-driver-x86@vger.kernel.org>,
	<vadimp@nvidia.com>, Ciju Rajan K <crajank@nvidia.com>
Subject: [PATCH platform-next v2 2/2] [PATCH platform-next 2/2] platform/mellanox: mlxreg-hotplug: Add support for handling interrupt storm
Date: Tue, 23 Sep 2025 13:44:52 +0300
Message-ID: <20250923104452.2407460-3-crajank@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250923104452.2407460-1-crajank@nvidia.com>
References: <20250923104452.2407460-1-crajank@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9e8b3e-7627-4ec6-9f07-08ddfa8e44c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tuFtQW/J5km0HBkXvXTB2MqMb5Elc+mbtkzy5EW/P7Sm9UBcCUBu4a77J9GD?=
 =?us-ascii?Q?3GqY3qYWiF1y3Nxv9Tn7xpILvbkzaVOr5hu7sne8aNXFVvXk1+DYAYYbofc7?=
 =?us-ascii?Q?Q/MN3qo/uVvieOyDy/fQFVTN5cxBr4w//pUO8XpC80bTM1TcFo01HndnFcCF?=
 =?us-ascii?Q?sRiNNXwN/mxlF/YEJ+Sbjzxm0k/mi49QJTe3lK36gQoMqXDpijNPiviS2qDE?=
 =?us-ascii?Q?fnG6Ju0usb/+eSCWo5Z4u5wUkN0xeVqwimlZlalO7yqMHsb44ROVl3ZOxX98?=
 =?us-ascii?Q?GvpCNzPJiE2Fq2+zYIxW4XDPjwpgNg1sTUUeAg426F15CEAfx8oU4wAwJjua?=
 =?us-ascii?Q?WhT9PvKEPjFHN6EUjMLeXQEV8w/fBpl7+COjO/u76HF9x3den/Ds3u0JyKl2?=
 =?us-ascii?Q?cbAtFLd/cNYgJlI37Zd52tleBcxg8PJRfWxI/Pd8J2FlAcVU9Ca89LM92EOW?=
 =?us-ascii?Q?98FeN1FIedx9LanWvXmDQzsmf1HIRctqDYGCemjgG6R0TX7xwSJgwSFOr82c?=
 =?us-ascii?Q?g4fHfDx9YQDwjYcE+MqBbLx9zp3GTEkdjeROpxn2YhLe/TMlUko3ZmDlazlt?=
 =?us-ascii?Q?g9HlRf+Izf7tXEnqUZ7pKs7RZ7uuczZQwu06/u3phKgd2GCTDKQTipSHl0AO?=
 =?us-ascii?Q?3jAqxauLQFKnUX2WO6m9OqpkeDjd93uIk6qY6ORLrcu6ovo18L8nloFty3bU?=
 =?us-ascii?Q?RHnPyCcJXbk8rWLLK1XUiwT+4Ntgy/AAGqVuzq1Ju3+G4GQeC9GXaIduQpHy?=
 =?us-ascii?Q?d8wSUVZiy9CjpfFC5hPdqYe4IlV7WqnNbNZU1LTGgZsphNl4fIDofM558i4d?=
 =?us-ascii?Q?0KnRpl0/RuqdJpCoGefZ+S+h4MQTYVNxi4ZhqHXkp2HnkZ2Mo2Y9If/sVwIF?=
 =?us-ascii?Q?k+DZus0ZBN1AdQ4SXUmmf9a6LZvs582wYqIX4df3++OwqOEipC3C8U6k9Wzn?=
 =?us-ascii?Q?WR7hlMycUiLL5inj2AA625G1zZGEayoXzbs84cXcn7x0xsIcOrLDv2eRatv/?=
 =?us-ascii?Q?9CSK5UqlAf0oIPzOXLYqlGTsGimtW5zo7QcipK7ZYuLB1zfme1enj2gNz548?=
 =?us-ascii?Q?HspUQacNBlN2saKNeSbRwP29vc4BBxFsZuV50QwwK5nCwhkNNWHO0aYPozIG?=
 =?us-ascii?Q?0FnkMi/vh6EW2DlT+cSRWzGkkx4uTYM3V68Mc96zHWNyH0BRif47neJAU10E?=
 =?us-ascii?Q?4DASkgU15N+/iqW3Mvp3GlL9frjiJz+32eBxofYuGiZwN+iAHytfwwrjJDze?=
 =?us-ascii?Q?Y1hhQURS89DA9+OP5LQMLzwLiAXkvxM6y12b5/GQ8nRRy/fFiSH1VN8mrYEK?=
 =?us-ascii?Q?9Y0Ex8spxhxeEYX7b8d9UD8oitoTZw9hBG30tAD1cocm6TAk7Lnyaad2Y4zf?=
 =?us-ascii?Q?/iNSs9CiJjzkfPtjnsEQP8qruiLAYOEM66zKLEVXdYAPp/HzGU5It7upRD5z?=
 =?us-ascii?Q?8QK/5VRL66M6uLH57G9owtIQ6uQPrPKTOytNnk0zeYVmzheaWh5n0QklzGC8?=
 =?us-ascii?Q?TjQh5rh8Sui5om5KN5hL+BexJlJryFpCmESr?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 10:45:10.1411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9e8b3e-7627-4ec6-9f07-08ddfa8e44c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012

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

Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Signed-off-by: Ciju Rajan K <crajank@nvidia.com>
---
 drivers/platform/mellanox/mlxreg-hotplug.c | 32 ++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index d246772aafd6..ae0115ea1fd1 100644
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
@@ -366,11 +372,33 @@ mlxreg_hotplug_work_helper(struct mlxreg_hotplug_priv_data *priv,
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
+		if (data->wmark_cntr == 0)
+			data->wmark_window = jiffies +
+				msecs_to_jiffies(MLXREG_HOTPLUG_WM_WINDOW_MS);
+
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
+		}
+		data->wmark_cntr++;
 		if (regval & BIT(bit)) {
 			if (item->inversed)
 				mlxreg_hotplug_device_destroy(priv, data, item->kind);
@@ -390,9 +418,9 @@ mlxreg_hotplug_work_helper(struct mlxreg_hotplug_priv_data *priv,
 	if (ret)
 		goto out;
 
-	/* Unmask event. */
+	/* Unmask event, exclude storming bits. */
 	ret = regmap_write(priv->regmap, item->reg + MLXREG_HOTPLUG_MASK_OFF,
-			   item->mask);
+			   item->mask & ~item->storming_bits);
 
  out:
 	if (ret)
-- 
2.47.2


