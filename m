Return-Path: <linux-kernel+bounces-816637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FA3B576A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB60A168A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1952C2FC876;
	Mon, 15 Sep 2025 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LAUYFlg2"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013031.outbound.protection.outlook.com [40.93.196.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF92B1EBFE0;
	Mon, 15 Sep 2025 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932646; cv=fail; b=DiKWaI38oiP+RiAQbiA6m28Ii7p4DLmHoXztkmMJvLN6IdETncsCkUr7BVDFVSEE452hq6W8fjW+56CRGlrEKLYhkkOpwOSPaCx+6kb/bUFWNVcofIaHWYNK+FBe+ZPdVGQupJrzehQCLJ9wUlsZojz2l2Qsz1copg8S3m4GGhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932646; c=relaxed/simple;
	bh=JQlsl8A6uwG94BwoYZpaui7XdpVa+SECRoF/Rfkz2As=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uiyEQ8jGvnOsSDa+B88VtoQPGy4fLtQtT+PzkZPFf9SFbRbHSIfZ4Z7nUbH4MkR8Nz9x5KMZ3uoDGKEcHiQzRC/cBSm7d3kSLcJ1yRtApqE1EOWEtrDHk8Pc1/tlufpiB5HrjVid1k/Dd5REK9lAhow3MRXdcGUN27zhV3caD4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LAUYFlg2; arc=fail smtp.client-ip=40.93.196.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LahUHwWUGeFHgyJHLuaKsOakBgnce1FGjjXPy+9dRJ8OKOrWh5EJv9WqR8Jc2XVCSE9v0JCPWZpHfjpWhGuBI4PvzZTI7db+w/JQGUFXNdRbZnYrUDUfbuQonH6DIsCRFUUuunsmSfBNoODprHpe5L949fsYZN/yabYt3Fa63cjla3ssvHr7zkrn35q1+YAGGk0vJq+/iK17N0qD14KZWwWo4W3gNMAb/2JVH6a8lwNtdTuPezMGQzcxPSu+7j/M68XVbqGP2Q2QAV3jvzhVMeUO/DUiS17qb2ZedDttYWq8gQXNLZIUs0r8AU6qFMfaHIGUkVqVXKga/FQuwqvN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDP94Cm/B5DkpiU2NC0o7Axt63toAaM5K+SeJIaozUY=;
 b=SnTEaJcw9q2LJdeyaxZSKC89NQiFQFtgge5ItHAfvvo2SI+YLXVgwDnteufwwNTuRt2nXY3ZZT7IbtEY2nUsb2ZEDDL0ufqUaKpPQsqWGOOV/kcVAHtj6nmpCKrWR/ZNYdE62txmjImgR5UbYJNpD6J9nV04fuKkenN9i9gT1x9ignpzdS5+tcEq3U5v/Vue2vAvat7NqSczG6ZCOQcAfbtmggRgwNm3KBqKlDzyFn9UyKvCe8pKeWAMcfRl6IW3oijck709crR6+bLxleB9/idJOQDYMBDK+mPa3d6mWLHfEXdBj+mYeO0MYWchuPNON8Qpzc0sFR1b7gPaUBRviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDP94Cm/B5DkpiU2NC0o7Axt63toAaM5K+SeJIaozUY=;
 b=LAUYFlg2ssPZN8N4yqTPME0CRo0zSBSk8zFOa7aFTUviqYolC7milHyEx/fCQ6xkvJipcANv/pr/d4QIVdp06s1hWWwaCeOXK3oXbAdWOGfjqjDwCJBuiXLU7dNWitFa7zZp9AoN2GPfApWkqBWN/AntrdCr+KPQOknxor6C85c=
Received: from BY3PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:39a::20)
 by PH8PR12MB6698.namprd12.prod.outlook.com (2603:10b6:510:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 10:37:19 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::1b) by BY3PR03CA0015.outlook.office365.com
 (2603:10b6:a03:39a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 10:37:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 15 Sep 2025 10:37:19 +0000
Received: from amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 03:37:16 -0700
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <arnd@arndb.de>, <linux@roeck-us.net>,
	<Anand.Umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>, "Naveen Krishna
 Chatradhi" <naveenkrishna.chatradhi@amd.com>
Subject: [PATCH v2 1/6] misc: amd-sbi: Add helper function to prepare I3C support
Date: Mon, 15 Sep 2025 10:36:44 +0000
Message-ID: <20250915103649.1705078-1-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|PH8PR12MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 05db77d7-19e3-4c1e-b230-08ddf443d8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+nbV/WxRfCXohdQPjndGvy30OAZt84LUGR4PKmBq5A1kOrJ9T3675Z6ORbyK?=
 =?us-ascii?Q?qZICicCyocMYg+dgILnvMt3GJQycpXI5b3nAxiiFnH7D/Ghf2LvwsAhpjqz8?=
 =?us-ascii?Q?eH8YEcgQt63ViO4dSJnGkp7IrlH2V6yjF+EvDKbMQnkXCu+xiEShYCnOpThZ?=
 =?us-ascii?Q?WvnLStMFtjSVO84xp7W125M9nrSQA6YWfTnfVNQ9Khcg8l+1eNA2niUySwi8?=
 =?us-ascii?Q?VqT32fqumduiWMdUqqfdN6ogIQjIlvRmBMJdMkYkAqoC0f41oX271vQdnAph?=
 =?us-ascii?Q?aN/55YuYoRL9B1hsjXgw4F3WT4nS34beHlad721o4nMdcpYmsSmpJE8L0JPT?=
 =?us-ascii?Q?mpQ/iA8aaWKSCsH6HjAqI0sbW2AHAqcXNw2JNkAm7RCKjAJrjjt42Zctl5HA?=
 =?us-ascii?Q?2bryyPswklfqb+qggIbh5WlqWxx485lLcj72rugV7DYErH7ttf8/9Qq9QcFK?=
 =?us-ascii?Q?wAZ3w2yg39fxEcxo0/dmTs1CUAnis4SpHJIWKnrYD19zu2LHMgHgAydGKJvr?=
 =?us-ascii?Q?kOOov21Y67gYmCSMhLCwujbZIXqh/3bumCVOz3jEbl4urV/JIJd6PRr9eOzY?=
 =?us-ascii?Q?fZxvhTVw95/VSKdTrmKLGKXE/o5Fcr5OlTQ2MUxQ/HdHiwUrsZ6zRZsmp+7k?=
 =?us-ascii?Q?yMjDToKTpqwbYfzhWRuZDTOg2bXk1Qzre2wyuMQkbONFLRcJqPHx0dsLxJUA?=
 =?us-ascii?Q?o4p4Tpz3gYS7Ev3r5QSpgf1KEQ6YPZ5MgWeBWEd2y6QO7RTdhaiDETGw9t4O?=
 =?us-ascii?Q?XHSmrLC03Lmr7x3ByCf7w7vTCaw0leiFgjM9jhASbZm/nivvairYjrU50G/7?=
 =?us-ascii?Q?DBSqlXHdfdzIoVR7sZ3nQ7Ppewc8J0qL/1zJD4jPzio9kGciOIZaQh9QzLT6?=
 =?us-ascii?Q?v6ykQoYGAbLdYGyKr5okfk3rwerVuiwDCvVj25JSu3vyn6YliTzwZKSnAznS?=
 =?us-ascii?Q?9iAEGUvnhrehJXvvxe3yKnoaHIKVJsaUzinuJ5yzuV8BCViKA77OBF3SD0wz?=
 =?us-ascii?Q?+/n1tnh//79hXXr0eTrwyx+kSrG8UA1Uf5JFhPhjNZx0XFaF/va14Yj195oz?=
 =?us-ascii?Q?zzrWU4CqbpEkplacPyIDRHQMOVn8A9EkbEjnYiODacC0r+s1veMgeon5AGDW?=
 =?us-ascii?Q?vOIInALdtTaelPGAPXQDcjeZU0g6ve2mDuvi1RZ9r0+OZLU4cjHic+QzUeVt?=
 =?us-ascii?Q?VsGOehq0fKSc6VuZvB7+144KDDlY0LLwvsd63dnaWRlWMEceXQaM7mdxasNy?=
 =?us-ascii?Q?L/SxxSTTpFOnQEJYdaGKgpEU+T8wj0UdhhyVX41GkcUfvneHZ459Vu1LNfI8?=
 =?us-ascii?Q?4HtmWiJxgc5UNIsfX510B8ymfMuGpnKkldsoG1mLWJC9jP57CtRjixyj9lzN?=
 =?us-ascii?Q?l1PPdKS+KfFJMeazUl1rKz+GJmpjeqgf1w7IWtEVuGGABi29ipTNSl2RVnG0?=
 =?us-ascii?Q?/2+o8obSk31+0/UhRUk4szGfKJv/3folYaGCiLvgOi6pExvE6Lit3rBEdkCd?=
 =?us-ascii?Q?5npVUrJJaZONW5qJo0QW8RLCCySgLiWfVArd?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:37:19.0641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05db77d7-19e3-4c1e-b230-08ddf443d8b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698

New AMD processors support APML connection over I3C.
Move the code, common for both I2C and I3C to new helper
function, "sbrmi_common_probe()"
While at it, renaming the static structure regmap_config "sbrmi_i2c_regmap_config"
to "sbrmi_regmap_config" to avoid confusion.

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---

Changes from v1:
- New patch, as per suggestion to use same module for i2c and i3c
- Patch series is applied over "char-misc-next", commit ID: e2258cfd9b9809002ad52f1f763ff192e612a1fe

 drivers/misc/amd-sbi/rmi-i2c.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/amd-sbi/rmi-i2c.c b/drivers/misc/amd-sbi/rmi-i2c.c
index f891f5af4bc6..d41457a52376 100644
--- a/drivers/misc/amd-sbi/rmi-i2c.c
+++ b/drivers/misc/amd-sbi/rmi-i2c.c
@@ -50,26 +50,18 @@ static int sbrmi_get_max_pwr_limit(struct sbrmi_data *data)
 	return ret;
 }
 
-static int sbrmi_i2c_probe(struct i2c_client *client)
+static int sbrmi_common_probe(struct device *dev, struct regmap *regmap, uint8_t address)
 {
-	struct device *dev = &client->dev;
 	struct sbrmi_data *data;
-	struct regmap_config sbrmi_i2c_regmap_config = {
-		.reg_bits = 8,
-		.val_bits = 8,
-	};
 	int ret;
 
 	data = devm_kzalloc(dev, sizeof(struct sbrmi_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
+	data->regmap = regmap;
 	mutex_init(&data->lock);
 
-	data->regmap = devm_regmap_init_i2c(client, &sbrmi_i2c_regmap_config);
-	if (IS_ERR(data->regmap))
-		return PTR_ERR(data->regmap);
-
 	/* Enable alert for SB-RMI sequence */
 	ret = sbrmi_enable_alert(data);
 	if (ret < 0)
@@ -80,7 +72,8 @@ static int sbrmi_i2c_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	data->dev_static_addr = client->addr;
+	data->dev_static_addr = address;
+
 	dev_set_drvdata(dev, data);
 
 	ret = create_hwmon_sensor_device(dev, data);
@@ -89,6 +82,23 @@ static int sbrmi_i2c_probe(struct i2c_client *client)
 	return create_misc_rmi_device(data, dev);
 }
 
+static struct regmap_config sbrmi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int sbrmi_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &sbrmi_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return sbrmi_common_probe(dev, regmap, client->addr);
+}
+
 static void sbrmi_i2c_remove(struct i2c_client *client)
 {
 	struct sbrmi_data *data = dev_get_drvdata(&client->dev);
-- 
2.25.1


