Return-Path: <linux-kernel+bounces-816639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C685FB576A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79461A22D52
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE962FD7B2;
	Mon, 15 Sep 2025 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kd6YAo6T"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010027.outbound.protection.outlook.com [52.101.193.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98FB2F90F9;
	Mon, 15 Sep 2025 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932653; cv=fail; b=KYPgrmtWJhrZCTC5cuuvFS1Bn9k/6RXuIcbPFufML9MzHUHAJ4Bt00D5r2Y7yjRHqazXGlKIh2PTGkh30ny6uGtBYL+IWRi2qxeZDdbY8vlLo6HATmonf1NmCEyEWOPZb8wG0qbbv8sJGI5njfHjGCTzKFu8ruCyOv0pgYVwCLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932653; c=relaxed/simple;
	bh=MlDW1tuV0NF8uogw/TrjYqdUnQBrpeXawYETxXtZPsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONVijQCp3LgytU2ek3X8bMD89iawoKC2t+QorT77JoHWWB9RrwgxNjCCc3b/BE80Hpau8hKHUzKmqhU8Rx26vDtNbvVNIfJ8GKA9efPy49TUwCNfEAX8lCtgeF3zYRyvkfJnfrlEaAEobpi00Emb/uD0756xpCF2cReME8iIWbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kd6YAo6T; arc=fail smtp.client-ip=52.101.193.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKWAG3s/RfrUa+cAtls1gZNXf2fkFZhQ8C0PaPFObgr+2kXADGEyjIeKu++9fn8FUk1gvr0OVjGmLgIrldTC89ky56D0eM9uxfrv661wDetQZE0hlfeuUFv9KDT1yQv9JSzYVwp6YeZr5Hi/is9showH16+ukxDdxTKLL0j2NyMxVV93VmTC2iDTWgiAiCoqoLzqRCKkqeRMzERRiRVWEqLAjQRPB63I4nB75a9kCcyaZ9K5orifYyrr4kcEQXpkO7Sk2yjYIldvQKocyXT0F3SgrUCD6Jfy4JBGXn0p+XI6Ix59vHmpJNy87FQN+lEzVPAM4aLEveO0uN4vVDIaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHQRW/vV8xUoDA4+xHipzF2BI6Y9tsYMuTHG+Auf4d4=;
 b=nKBT9E1XzD5WfUHYMrazRQKekZeVstUjPrvkK/Obn1h7TxjxMIpEbfzX/95/WCSGBALV6TjhRPvTCSYvj1giQBdKAMvfG/qL1ZIcsvInS8yxJ3y4Yre1ebBnXsNYWWHjkT2OOg2G5L5h7k4g4q+Z2aD21Z+pG92jp7FTLpZ0ZmSxSUwv/iXAQmeeu9iCmEeYy1s8NCkPLT9zAo2O/lJDTE4iRSoClop0C10tqUx/iErB+bZMKJQ87OC2EIV5XVLGOGg4S43EPzW6U1/9knSRqjDK+pH8QepIcPY+n891wlRM7kH+9mG3FgM9PtgAeXTMwQYFyRSy9LbjGdJr1NAEew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHQRW/vV8xUoDA4+xHipzF2BI6Y9tsYMuTHG+Auf4d4=;
 b=Kd6YAo6Tp8xX/us1z/EfOV5b93u5MWFzB+N+mXGWWvQxCUf0q3Y1wtoRnh98pKDrqs4ss2doER1YyeFrupx4/f0rQFup4lMFNFUO7wKgssW6OckpyusCcRNef3cdkRRF22GEg6qYRanqwenQcUhM20HJTrwNgK/kXNBpu4F7fIs=
Received: from SJ0PR03CA0380.namprd03.prod.outlook.com (2603:10b6:a03:3a1::25)
 by SA1PR12MB9245.namprd12.prod.outlook.com (2603:10b6:806:3a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 10:37:28 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::f7) by SJ0PR03CA0380.outlook.office365.com
 (2603:10b6:a03:3a1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 10:37:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 10:37:27 +0000
Received: from amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 03:37:24 -0700
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <arnd@arndb.de>, <linux@roeck-us.net>,
	<Anand.Umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>, "Naveen Krishna
 Chatradhi" <naveenkrishna.chatradhi@amd.com>
Subject: [PATCH v2 3/6] misc: amd-sbi: Add support for Turin platform
Date: Mon, 15 Sep 2025 10:36:46 +0000
Message-ID: <20250915103649.1705078-3-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|SA1PR12MB9245:EE_
X-MS-Office365-Filtering-Correlation-Id: 02791db3-9ec2-4b1b-abe3-08ddf443ddf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vQ0uaeJA4dxbHI60pm38vaoJlTGuJ3eQBqCHOztoHVD93+TjoN7t08r8Zq88?=
 =?us-ascii?Q?SKJ0HrPsBnD9yaTt+c7H4QQfF+2lOaUWh4tEI7bJiPpk98w3KvfsA8FJG4B7?=
 =?us-ascii?Q?c1gRZiYFcfdZc4BELySrv753ybnCTrOTV2YENiGBEZ6JG0pZgwQcp+xgg8uL?=
 =?us-ascii?Q?Fr57UJUEqKRcu2817T9DzZONMPajptS4MM0/UE5V2pRP7bdeFRM/hNt7fbuK?=
 =?us-ascii?Q?GP7IqS81lf9luSxvQ5K+ss0kzMr9xDmDlmO7lzmIpAQ+ypb6DuaxTaAn7jWA?=
 =?us-ascii?Q?8lR5rKFoLpFcxoDPUOh3MovxEvsllvf3i8ocXlWB85Ec1kDyBqsgAX4Yl6k5?=
 =?us-ascii?Q?rU76Wk0IZ4AFtCdHTYYNJOGRfg8iXlAy+AoxD0qwkTLyPVQRUtyIIH+/SAFA?=
 =?us-ascii?Q?kUkuKjWTcSY1aA05rrCy3ZAYTnPPcXPVy5K2yKfY7lNaYwi9VGuu4rjZtCeK?=
 =?us-ascii?Q?caXYKOy4nt54PtaJ73U+xhOrHHD82utONEryEomE1o9qBJPrstmZbcHHhLku?=
 =?us-ascii?Q?bSr6FZaBpyZqjN1A4Ncr8PZ15Mdq4ffJ+EQNzOwSXUKLNMl1NC4UOZ9Z6Khl?=
 =?us-ascii?Q?scxhSL8LmG1mlQ37WY463oZhKsfxOo3NugIzCD8i35FDGr3LndlRLaOWGF4K?=
 =?us-ascii?Q?9u+Uix6JVpnN8nduRZRNs2+XncjTtJzQ11g6KB1pVwmSGPZeiYPGl0vgzy99?=
 =?us-ascii?Q?Iwafg6JMpi4gno86VnOJdaUPRaN/uuaDRCcgc1IPBn0MDwlUXWr5a7B4PHZr?=
 =?us-ascii?Q?xRjOtwJ16IxSfAqvWss+0QWjJEGVxd/4x9JwKVGDToyfpUe/DJ8YQOvmUeZb?=
 =?us-ascii?Q?ngCwsyQpECYKU+Nj79nRTE3QvQgw/XuzOG8BHd9VTrT0nFCVDmrgHOXs3ApN?=
 =?us-ascii?Q?3LiCabQ6fweRls/nUdgsWb35+gWyOFJ6TmZphAoTxhClGtODS8pi8TqpIUQ4?=
 =?us-ascii?Q?jbWB1Gjdk/O+tiUvcjvtWFsk8hK+kjxMupyrhf2odDQwAe7FlATSDopfEZZC?=
 =?us-ascii?Q?zVrhFW4lCgnCnz++J0T/AHv2HCYd3dfAX4ibIuruDbO+R5MidOYfKrpDrT+2?=
 =?us-ascii?Q?LKAh0XfFrK+5TaZkdPNHHq/D7Zy3AKuXjDWAu7i8CCenjL2vDf7T9IFnE+S0?=
 =?us-ascii?Q?pF7AIsk9ARwF2opIinvaE0sVXPEaPUjrCoG/fEuFakRDCW5dUu6BtWckjLeL?=
 =?us-ascii?Q?B+1Zs5/VvvQsR7HBkkQ5IVPTVt/GfXYNNlh2AWKv+4n/bx4Zzn3CPyVEHjB2?=
 =?us-ascii?Q?kx7+qR7J6nV2G6nWGcB2YaxPAaxzlkS32SbXzjpPkOG/iOozDUG5sQJnCd+Q?=
 =?us-ascii?Q?JDVtbVViU3Y7E9Uv0Iy2/xqKe5nAtAvGZzYa1ZXKt8wme1ASkW6GXD0yBIaX?=
 =?us-ascii?Q?NxAONamJoTdrIcw6dn96IDEWD693+2DhwSPylUIZfNtm3nYQiabH0PIrDvhE?=
 =?us-ascii?Q?SV00vXIuIDTtwseaMBArX/bbsFpt68lkkREWMbWoveaALGD7H0ATEhwWWU18?=
 =?us-ascii?Q?Y3WSRJbNOAhlZXloS6hVedjoyNcVUxNOZEgJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:37:27.8947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02791db3-9ec2-4b1b-abe3-08ddf443ddf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9245

- RMI registers addresses in AMD new platforms are 2 bytes,
  on previous processors the address size is 1 byte.
- Implement logic to identify register address size at runtime.
- The identification is done in first transaction using the
  Revision register.
- The revision register can be read using 1 byte in both, older and
  newer platforms.
- However, sending 1 byte on later platform can cause unrecoverable error.

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
Changes since v1:
 - New patch

 drivers/misc/amd-sbi/rmi-i2c.c | 47 ++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/misc/amd-sbi/rmi-i2c.c b/drivers/misc/amd-sbi/rmi-i2c.c
index 087c57bb0f37..f0cc99000b69 100644
--- a/drivers/misc/amd-sbi/rmi-i2c.c
+++ b/drivers/misc/amd-sbi/rmi-i2c.c
@@ -18,6 +18,8 @@
 #include <linux/regmap.h>
 #include "rmi-core.h"
 
+#define REV_TWO_BYTE_ADDR	0x21
+
 static int sbrmi_enable_alert(struct sbrmi_data *data)
 {
 	int ctrl, ret;
@@ -89,15 +91,40 @@ static struct regmap_config sbrmi_regmap_config = {
 	.val_bits = 8,
 };
 
+static struct regmap_config sbrmi_regmap_config_ext = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
 static int sbrmi_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct regmap *regmap;
+	int rev, ret;
 
 	regmap = devm_regmap_init_i2c(client, &sbrmi_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
+	ret = regmap_read(regmap, SBRMI_REV, &rev);
+	if (ret)
+		return ret;
+
+	/*
+	 * For Turin and newer platforms, revision is 0x21 or later. This is
+	 * to identify the two byte register address size. However, one
+	 * byte transaction can be successful.
+	 * Verify if revision is 0x21 or later, if yes, switch to 2 byte
+	 * address size.
+	 * Continuously using 1 byte address for revision 0x21 or later can lead
+	 * to bus corruption.
+	 */
+	if (rev >= REV_TWO_BYTE_ADDR) {
+		regmap = devm_regmap_init_i2c(client, &sbrmi_regmap_config_ext);
+		if (IS_ERR(regmap))
+			return PTR_ERR(regmap);
+	}
 	return sbrmi_common_probe(dev, regmap, client->addr);
 }
 
@@ -141,11 +168,31 @@ static int sbrmi_i3c_probe(struct i3c_device *i3cdev)
 {
 	struct device *dev = i3cdev_to_dev(i3cdev);
 	struct regmap *regmap;
+	int rev, ret;
 
 	regmap = devm_regmap_init_i3c(i3cdev, &sbrmi_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
+	ret = regmap_read(regmap, SBRMI_REV, &rev);
+	if (ret)
+		return ret;
+
+	/*
+	 * For Turin and newer platforms, revision is 0x21 or later. This is
+	 * to identify the two byte register address size. However, one
+	 * byte transaction can be successful.
+	 * Verify if revision is 0x21 or later, if yes, switch to 2 byte
+	 * address size.
+	 * Continuously using 1 byte address for revision 0x21 or later can lead
+	 * to bus corruption.
+	 */
+	if (rev >= REV_TWO_BYTE_ADDR) {
+		regmap = devm_regmap_init_i3c(i3cdev, &sbrmi_regmap_config_ext);
+		if (IS_ERR(regmap))
+			return PTR_ERR(regmap);
+	}
+
 	/*
 	 * AMD APML I3C devices support static address.
 	 * If static address is defined, dynamic address is same as static address.
-- 
2.25.1


