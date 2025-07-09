Return-Path: <linux-kernel+bounces-723718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E16AFEA46
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E993587676
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B92292B33;
	Wed,  9 Jul 2025 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="DPBeqLJ8";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="JCtW3fR7"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25215262D0C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067883; cv=fail; b=UEEaH/VUN05UDxB1twXnHMHbr4mC1/8Lfonspvff3DeL9l0Lnk/8nUSCOMHD4vvTUFJSmSIEufyIY52Eyxe065ynhwmpsHRqtUCbbisII+CwDCp9NzjgpPFSUc6LBWz8lqrplYBhilC0MN66i1GoGuqO4o5RrpqWeeaxu1Xynz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067883; c=relaxed/simple;
	bh=/ec/mIXQ2OczoxP6KP2ka6azw1WXig3LyV1681ZpjzI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Fa8SIz6Ilf2HdMXhw39Td2SxJo3XGkhsZ+R5InDNWpqHrb/NGMKH9r3JcKLnpxWbUudVMcTZq0IZz5HggRYaI4jeayeceqCYI5RX8m6l787yE4PMXQgvxNcVPFyGR3c+2RHRpXqtpjwpAZSI71A/zMeLVHmANULO8rb8Hc24fCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=DPBeqLJ8; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=JCtW3fR7; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5694wpsp032092;
	Wed, 9 Jul 2025 08:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=nLj4rorXycthc5Ul
	SNWoO85BblUm4JZG7wlhmAaM5Hw=; b=DPBeqLJ8NCGwy3HMUGqhUAxCMZgEkdQn
	C45iunsZXPKef6nyZTckVbnkl8qxROdmm/vu+Cr6M4qiQzzjCyvR7atBeIJIaCgN
	xOqtM1XkwfNuM8DbP725H5UyLN1gmx3y7CJSU7ft6xl2x37fhg4FmWfP3utCx1+R
	b7BdeRy3eLxoQTyd5rBtwx1VF/a+iIbR8iO24yqWYrL054yrvLev+rMBnvL3lbHg
	8iA6B5aL9z9vfFfM2hX9AaNt34qH9usjCm53j2XPJsL1UJG6IniIGIY8xivOUab3
	2yxrJJ7MIbZk7zNnouVvzi2DBDGZQbvIzTzoG26Cr1m5QNyGQ22mxQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2130.outbound.protection.outlook.com [40.107.244.130])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 47sev68tj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 08:31:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDl9Qy8l8NgGTArcj9TNbr6ZstP13JlJ5BYPrw7/JXaOg0ykrtoaeE+G/CaIK384OgCkU6beV7CqnEtIVfxrn8x96dnFZQRAMo0DA81cr8FgbjBGgHa2PvA1uObtzaUghyPDvh5DrUQFJgZyaQzGC57qENt7Abjyi+AeoSvkGbIEnJ07ALLkk5J2HJUbIg2LSq/aeQdrXAnpLEeO/Uv1lzMvgjr8PILKHojHp4s1ctPA9Cq/cFO2MfM68uI6U62xTE13rVZmn2gfuHSkNJW/75qUn/NWg+MO07z5rgR9XgHfuQfjJ2IBYZosCz5eZyZtdSvjt5fyDWqfR2/b3WZ1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLj4rorXycthc5UlSNWoO85BblUm4JZG7wlhmAaM5Hw=;
 b=b2LaZLmuAOFuk5TEcyaIj2tEjpJKWTBFff8tUxi25e6xNR9r4LIptxzDOnhiMVcMjB3VknyB3vBtRcoavZuwIDmIUw6BlkJ7hyGRjubgzy2DIUhatEB1n8tTvT9/wCyYTlx923CwC6sG1Mb/mx/J39fIpPovqOkYfR2/wLy4gfw56VwOomSh5QkHLL9YXFhr7XsNwVVBq6L5pXngPe0cyEIy799+/mJd4raY4e2vJnkbwrzmOjosMgdYDP+5zzzRBHiXaO8ByCNMoP2kBLjaGOqpW6Wpn9qgtusx8Rm9sgu/TTJIVGmAJe974kYSOSF1CR9RT8HPcrCeF1S+GqAE+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=9elements.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLj4rorXycthc5UlSNWoO85BblUm4JZG7wlhmAaM5Hw=;
 b=JCtW3fR7ucAvitwfNM1wxYy0JQC8xx+hx6YpnKPx+lP9NtxTDM0XMxA5UwOETAOtkt3+UH0DGlkUO2CDMGcfwV1X+GgpmRXqhMujQLaQoiNVy13PTkC1cqqtJxoYQmgAULug+HVG1b3A7+UEtJkY3uxYwEDZRGL6MuCfvusjdC8=
Received: from SJ0PR03CA0121.namprd03.prod.outlook.com (2603:10b6:a03:33c::6)
 by LV5PR19MB9105.namprd19.prod.outlook.com (2603:10b6:408:2fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 13:31:09 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::9b) by SJ0PR03CA0121.outlook.office365.com
 (2603:10b6:a03:33c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 13:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Wed, 9 Jul 2025 13:31:08 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 1EFC8406545;
	Wed,  9 Jul 2025 13:31:07 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id EFF2982024B;
	Wed,  9 Jul 2025 13:31:06 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: lee@kernel.org
Cc: patrick.rudolph@9elements.com, naresh.solanki@9elements.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH] mfd: Minor Cirrus/Maxim Kconfig order fixes
Date: Wed,  9 Jul 2025 14:31:03 +0100
Message-Id: <20250709133103.3482015-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|LV5PR19MB9105:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 56c6e472-b6b9-49f5-14ea-08ddbeecdd7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?clg0PbEsVQZxqhwB8LY8Rub9zCEFwEx9oqc8VZHaDVfE9CfM/7DcTNiCfQaC?=
 =?us-ascii?Q?c0ha1qqDLQ6+wBZ+AF0dDiIrcxEyAgT1aT77QOu9clThlMe48rCz8cM/ziSt?=
 =?us-ascii?Q?MUf785AxlwMnxeOe0AZTMx3vnbvoO8qY60D4VqkgZs6VROL6biCkKLP3r97T?=
 =?us-ascii?Q?Fquu1eyl3PeiTDoj5polH4nOkk1nglYqK9pNv6mOxaprePPZp/W5B3sCddUF?=
 =?us-ascii?Q?xWvISNfL0myh8clsMIUkGLkcaDADLSTCXgAXsPosPNLLxXd7uWNmD8REF5ze?=
 =?us-ascii?Q?pAYiQsq+hDBHeMRkisZxxebpwLW0QnQTqBlw1MQv85aAAVtsMDHUAO/tT4Fe?=
 =?us-ascii?Q?gi7jS4OUF2Na/OS+GKWI8WwIUGROfh4bo26+PFi8w9ufImnfmkEg29F7Rcq4?=
 =?us-ascii?Q?YSlJxW6PsmAXGVRZ49g4BQfo0WqA3JQ+KWuJ62yxlUNYt+epJuz4ep/iUjec?=
 =?us-ascii?Q?py3oKf5w7OVA+uudY/wKDv0Gm0D4dWuVY5rxVH93PXYMLEbcybYEneiHf8CV?=
 =?us-ascii?Q?j5Rhj/faxIwGUDp9lWNU5LyDb9YRB0nmf0VCHU0jS8d/ME19G6IyiomFubjF?=
 =?us-ascii?Q?/uSwZ6rKnCFwXvOIUyOkS8sh3kzsrOrs8PJd96hpgjHUMrQ4Mkb1Ag5wJ21X?=
 =?us-ascii?Q?iRYQVY4k0LOyZxsz8TGg/YiaZZhiJqRYLulGJm/rwwRx3qBxGkU2yLsWixj3?=
 =?us-ascii?Q?fz8TI+eXdxgjQct1jm0PTVYVCvYcz4uYalzVxrxOxntDdNuvdCcolLMeQf97?=
 =?us-ascii?Q?e16QCBJtWcnZK7NKsNO5XSzjJ44GUmfDPVhBHSi/+rGvdBy2y4jI1wNIEg1q?=
 =?us-ascii?Q?Y3zjExkFLBUXLbfKcWP4Ijlopjyb9sKixbvrdopfQkOC0M8vWUe0c4q7AHqe?=
 =?us-ascii?Q?I8buK+lex2pOutCMXv1Dr023jAuxXMA5A1Bnd00GD+CTvYh4sPWCU5diwueJ?=
 =?us-ascii?Q?lrVdsd+pj6SfikGbOD5SKee32CQRRxsrE8AyTLDYjI9Mnsl+BU2ePlpLqKuI?=
 =?us-ascii?Q?Q3JjQOZujbdv6nbB6tiKXkwf18YRx82vxyNvyZTwAV1U7iK/J12NVBqLMyJ5?=
 =?us-ascii?Q?N4tp2D8/Ju3jBqiYp8yJZRMR5Oj2/LBCXCQ+Omk8ohdsgKzziYqQcM1CK/hx?=
 =?us-ascii?Q?TSUY83oCR1byRMugtnOON9rKSUOVscKKvidUOg12YKZutc9s/mJwshWmdUXH?=
 =?us-ascii?Q?lAzafhU8DzhsSNbPwalCKs++2Vn3sFRE+sBIJuqTbkiKV6YvohyLPNAcAhmy?=
 =?us-ascii?Q?Fb/ayP3YyYV4eiiIG7cYwLKfvPaKVluSExpqwjtpLPskZVk/q7QcORjevSbZ?=
 =?us-ascii?Q?xIzzjGfSK20NQjQi8rE2/BOygQpHh3oqzJg37SWpSQ4zgFokQbfVFVctmAUU?=
 =?us-ascii?Q?xWFzzvmyxfJ28/Jh+kUBYscYbMKNmOZfhcJVH7HPIU8BrOHuLEd8NdMQnhaq?=
 =?us-ascii?Q?HKSldyfSge8S7KkWulwF+QCAfLstT74ePoVTC10JvgDBqaTpWtcl+ZzUkbLc?=
 =?us-ascii?Q?rQiFYK21OgBCsnnLzet7ql+UGKFXFRFgF6Z/?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 13:31:08.5536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c6e472-b6b9-49f5-14ea-08ddbeecdd7e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR19MB9105
X-Authority-Analysis: v=2.4 cv=Zb8dNtVA c=1 sm=1 tr=0 ts=686e6f25 cx=c_pps a=QnyYytinJDQ/Y26vOVSMKA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Wb1JkmetP80A:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=PaONUsG56cGdRVWtTHAA:9 a=0W9TD_AsGAYKDBPL:21
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDEyMiBTYWx0ZWRfX59Hf8v4g2sO3 Q1WwDf3+wJF7Zlx+oggc2mDGxK7cKl4+hCJ/sIZLDJhOkJ0X+tPHDAPl5jzrjjVesnv9ckctKAg TaSGN9fcKUekGkgkHJiuwdpk/xRtMfiDBfNT50hYZHMBD9/a+Q55q55lRvmZbFn1m992VEWIPgs
 ANv3AuDtaQQ9+DV2BsCBZ1duFQyOwqNXoFGYOkiSyxUEyltqXOsMHbQFPahZGSctwzUFncSWvjO VGW8NO0eHeKQWnPhPaX+NS1oBTAe98uQFt6jAKezzUKee1fH6RCMn52Rjyd2ZLlpRK92g9NGOg+ ZAko3OgdOO/J6rNFBHk+cNyEQpYnI4lwgtOGTQlaPJp+OfnCTMe/OFRxUridIhMR7/ezI0skE1W
 AUi7dji7hiR7b+K8EhfMiZtVoEOXFa84db5vFVbk8UE4eyBZmXLRY4V65UfC7NHhHH3q24vu
X-Proofpoint-ORIG-GUID: 6LI6MNVlVovDEV8zyWhR1GAXmd5JN4lG
X-Proofpoint-GUID: 6LI6MNVlVovDEV8zyWhR1GAXmd5JN4lG
X-Proofpoint-Spam-Reason: safe

Move some Cirrus parts so they are grouped together alphabetically in
menuconfig. Also move the Maxim 5970 out of the middle of the Cirrus
parts and put it with the other Maxim parts. No functional changes
just alphabetising.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/Kconfig | 96 ++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index c635790afa75..c86e41d14431 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -261,6 +261,36 @@ config MFD_CROS_EC_DEV
 	  To compile this driver as a module, choose M here: the module will be
 	  called cros-ec-dev.
 
+config MFD_CS40L50_CORE
+	tristate
+	select MFD_CORE
+	select FW_CS_DSP
+	select REGMAP_IRQ
+
+config MFD_CS40L50_I2C
+	tristate "Cirrus Logic CS40L50 (I2C)"
+	select REGMAP_I2C
+	select MFD_CS40L50_CORE
+	depends on I2C
+	help
+	  Select this to support the Cirrus Logic CS40L50 Haptic
+	  Driver over I2C.
+
+	  This driver can be built as a module. If built as a module it will be
+	  called "cs40l50-i2c".
+
+config MFD_CS40L50_SPI
+	tristate "Cirrus Logic CS40L50 (SPI)"
+	select REGMAP_SPI
+	select MFD_CS40L50_CORE
+	depends on SPI
+	help
+	  Select this to support the Cirrus Logic CS40L50 Haptic
+	  Driver over SPI.
+
+	  This driver can be built as a module. If built as a module it will be
+	  called "cs40l50-spi".
+
 config MFD_CS42L43
 	tristate
 	select MFD_CORE
@@ -285,6 +315,14 @@ config MFD_CS42L43_SDW
 	  Select this to support the Cirrus Logic CS42L43 PC CODEC with
 	  headphone and class D speaker drivers over SoundWire.
 
+config MFD_LOCHNAGAR
+	bool "Cirrus Logic Lochnagar Audio Development Board"
+	select MFD_CORE
+	select REGMAP_I2C
+	depends on I2C=y && OF
+	help
+	  Support for Cirrus Logic Lochnagar audio development board.
+
 config MFD_MADERA
 	tristate "Cirrus Logic Madera codecs"
 	select MFD_CORE
@@ -314,16 +352,6 @@ config MFD_MADERA_SPI
 	  Support for the Cirrus Logic Madera platform audio SoC
 	  core functionality controlled via SPI.
 
-config MFD_MAX5970
-	tristate "Maxim 5970/5978 power switch and monitor"
-	depends on I2C && OF
-	select MFD_SIMPLE_MFD_I2C
-	help
-	  This driver controls a Maxim 5970/5978 switch via I2C bus.
-	  The MAX5970/5978 is a smart switch with no output regulation, but
-	  fault protection and voltage and current monitoring capabilities.
-	  Also it supports upto 4 indication leds.
-
 config MFD_CS47L15
 	bool "Cirrus Logic CS47L15"
 	select PINCTRL_CS47L15
@@ -830,6 +858,16 @@ config MFD_88PM886_PMIC
 	  This includes the I2C driver and the core APIs _only_, you have to
 	  select individual components like onkey under the corresponding menus.
 
+config MFD_MAX5970
+	tristate "Maxim 5970/5978 power switch and monitor"
+	depends on I2C && OF
+	select MFD_SIMPLE_MFD_I2C
+	help
+	  This driver controls a Maxim 5970/5978 switch via I2C bus.
+	  The MAX5970/5978 is a smart switch with no output regulation, but
+	  fault protection and voltage and current monitoring capabilities.
+	  Also it supports upto 4 indication leds.
+
 config MFD_MAX14577
 	tristate "Maxim Semiconductor MAX14577/77836 MUIC + Charger Support"
 	depends on I2C
@@ -1942,14 +1980,6 @@ config MFD_VX855
 	  VIA VX855/VX875 south bridge. You will need to enable the vx855_spi
 	  and/or vx855_gpio drivers for this to do anything useful.
 
-config MFD_LOCHNAGAR
-	bool "Cirrus Logic Lochnagar Audio Development Board"
-	select MFD_CORE
-	select REGMAP_I2C
-	depends on I2C=y && OF
-	help
-	  Support for Cirrus Logic Lochnagar audio development board.
-
 config MFD_ARIZONA
 	select REGMAP
 	select REGMAP_IRQ
@@ -2307,36 +2337,6 @@ config MCP_UCB1200_TS
 
 endmenu
 
-config MFD_CS40L50_CORE
-	tristate
-	select MFD_CORE
-	select FW_CS_DSP
-	select REGMAP_IRQ
-
-config MFD_CS40L50_I2C
-	tristate "Cirrus Logic CS40L50 (I2C)"
-	select REGMAP_I2C
-	select MFD_CS40L50_CORE
-	depends on I2C
-	help
-	  Select this to support the Cirrus Logic CS40L50 Haptic
-	  Driver over I2C.
-
-	  This driver can be built as a module. If built as a module it will be
-	  called "cs40l50-i2c".
-
-config MFD_CS40L50_SPI
-	tristate "Cirrus Logic CS40L50 (SPI)"
-	select REGMAP_SPI
-	select MFD_CS40L50_CORE
-	depends on SPI
-	help
-	  Select this to support the Cirrus Logic CS40L50 Haptic
-	  Driver over SPI.
-
-	  This driver can be built as a module. If built as a module it will be
-	  called "cs40l50-spi".
-
 config MFD_VEXPRESS_SYSREG
 	tristate "Versatile Express System Registers"
 	depends on VEXPRESS_CONFIG && GPIOLIB
-- 
2.39.5


