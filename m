Return-Path: <linux-kernel+bounces-856425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E630BE4239
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2691D421A48
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8C42727E0;
	Thu, 16 Oct 2025 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="f9hkZdUS";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="JZy7DeVy"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEC42DF141;
	Thu, 16 Oct 2025 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627335; cv=fail; b=uvTLRjcfe797jYytI0yFjJ5BJEFNI8GsB8H48/L/vdpwv4ZC/1t3TkmWITTICJtHss9ZCi3QJOEt+ww4/j0yCFbOWtRFZRXsgyir4vNza9ghtYMhs6JIZHQ2IsBxIp+J/yQXe+4mlY9qwLaMJMiltTJimXtVNVael9bDO/abDNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627335; c=relaxed/simple;
	bh=hGixKRSX7o5TLO4SYvwH3QcXZRSSJP3k7SN2Vx7QAIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HBzu5084s2cPQmiNaD5e10VSrm8P/KnzujJWJxTLxeRI75AmcbTse1K5b72lrlW0S6UkLchJmWvijm6iqeam1pdJTPg2BjF3c84I4TK31X0yFQ6P5e2s3xPAY96bJA1FcFUkUVDv2SfLiKkkUtDv2dM5KdqAU+0Fv3SiNuAeyI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=f9hkZdUS; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=JZy7DeVy; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GDSw1Y4017610;
	Thu, 16 Oct 2025 10:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=K+y5dGbdkClm2MAe
	AEmseKpbNCrDJhqA8IXdfqGFr10=; b=f9hkZdUSvXZPlYvg8o9dq2KeGwFosbbh
	ZFXnr1NyyeNgR1v2ggyVTKC1JdT/IOZWZd6DO5o0MBaUenY3RQWLxGSXcCE4mcDQ
	+7vWdgzeYFyReFL2wQGkiFRN6BFil5ogltLzbmAg0kAbytEid0HxiUi4rV1ualk5
	LeGdMMUfHgapzHEZA6eAIFsa7i6D/OzKoujTK31sh+jB+kSYiQAfk97/2tz974rE
	gVELKabe7pPjJjIHl2pVyy64+6TxqZMJvjPfy501dEKSyXFmuZxP85xZGGo7CslZ
	mbaLxHB1M/XcXu+GZHHExspRPPvKPCag6MSJ853Hgbwai+poCk2eSA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022125.outbound.protection.outlook.com [40.93.195.125])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mng5b5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 10:08:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVsQGRJNrJwceRuzb5B2oH3X6xmiRTkvpF6ZrWpVW9NNvJMGRhPrH+AHMW/F0c+MrNAfMtJPyrpgO28rFzIrRj27u/786Lm7B+khyUv0JVsnHuIcEF+BVk8pKCurSmz4xAKUZwdb6s4v394rSt4hxzHafJqNsdk5D2Ntv8lE6gYHVg4xP4lkm6XvE2kNMAccjVy/rbA9SMXNIKFTP2ffa/r1/94oV9U5AxnxKXp473km/GOwJkxtr5q0GAlbPqHaLQHMbUQ4eJG3sxeQNTVguEI6Ui9vjzwj4JUnR7m+8LhelZSMXynj8rRGmYmEeamM7LInpIoNTOIFcEv0ED5oiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+y5dGbdkClm2MAeAEmseKpbNCrDJhqA8IXdfqGFr10=;
 b=vJgo+74SgjfU2q8NPuEEOQCOr78PO0lcOiQE6v7Ijbk+qTgCHXbzKVJbnKGh9Ec4XlCks5E2vWr4xfuHz1kb0vcXQhe8VWg5vAc6Cpg7EwPfiP5K1LhAX0Zt7FxUqTB34c8jER8C8nf9142d7dQNds5KomUBfUlcBfUQfLmvukOI/CfQfII1Tn0dWc20SOvJ9AFHhIQU3GF95gpGE77MuSAtCsCYShqJDtSoR5pFnQAOLhrAvgztl9xotPWUlOSquARkrA/lkAbv9yJw7ufUB0kpDfHMu2STDLUJ4loFjXCPEEjKoTF563oJ9P//IGMXSAiSY4jGJPIHXzxgJ/vzgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=amd.com smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+y5dGbdkClm2MAeAEmseKpbNCrDJhqA8IXdfqGFr10=;
 b=JZy7DeVyTLjl9JTAGEnQhP7grNQ26b9xB1zmubgFq1Aassxm5p7y/Q7dX3C6RU+Qnn498HcRrxR9ddUZalihRuzy5KnP5d0xkVIWI1SmJ96GwPnCxw1DpaFq3SzArmHw58uIqYxSSFFZkU+55qzoXPi6TTE5jzWzcUJVZMAJBg4=
Received: from PH7P221CA0080.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::34)
 by BL0PR1901MB4724.namprd19.prod.outlook.com (2603:10b6:208:1c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 15:08:45 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:328:cafe::91) by PH7P221CA0080.outlook.office365.com
 (2603:10b6:510:328::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 15:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 15:08:44 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 34413406547;
	Thu, 16 Oct 2025 15:08:43 +0000 (UTC)
Received: from lonswws01.ad.cirrus.com (lonswws01.ad.cirrus.com [198.90.188.26])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id EE720820249;
	Thu, 16 Oct 2025 15:08:42 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, Vijendar.Mukunda@amd.com,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH] ASoC: amd: acp: Add ACP7.0 match entries for cs35l56 and cs42l43
Date: Thu, 16 Oct 2025 15:08:37 +0000
Message-ID: <20251016150837.320886-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|BL0PR1901MB4724:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0ef79e1a-6157-4515-a190-08de0cc5e678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?STMghR4YELFnE15p8LT8Ara/uzWsEoi7/b5wJu5mVHy5vR9njDAuULCsB4Oe?=
 =?us-ascii?Q?ZqjTrd0JLCCzFyfWXNEM7uDwW7xYu5beeug2l4vCV0TTx3pB/a+6ukavrRBU?=
 =?us-ascii?Q?f1hL8jJLNgmdFva4Cop2bnQN2F8JvZXcAQqY9V1XjdipBNKBlRSWyQOVpU3T?=
 =?us-ascii?Q?df9H2+thgGYgU5Gt2kzUQ6ROsLjQlVDf0j7tJ+AkYmYshOzxdt/gUR6Bhh85?=
 =?us-ascii?Q?9vDHa+sRv0w+YdNisvkZ8ZvWri44/ZFrb+r5sE7PlfcPQttSYW/DmLBaQjUZ?=
 =?us-ascii?Q?DGjX8mWOt03bXO7AHN8faU7bDJOWOE/z/NBkMVcJMXzO4QyDIxeqWztNU+Y8?=
 =?us-ascii?Q?qLuqDpgRuMm+1sn08eUWZG2JdPPpAl8/35DRVHOZBOpf3DgiuWXsR65dXwwf?=
 =?us-ascii?Q?aafiN7CdoaZNm6fln9UHpCzDspCKUezYO6NGe15LCi2S778BCtMYJgYYDOBp?=
 =?us-ascii?Q?GrEe5qjxHyhfb1Fd6giZcCWzDjXmMEb5hkOx75xVvThFVHz3h7CBMsaHzDdW?=
 =?us-ascii?Q?ugSVM8FK0EDVyPudgIarP913JGgJwLfxPw1vOGwFiFEGMSWPcC06Sdk4e+3A?=
 =?us-ascii?Q?BZWlugklttWS+LO3MdwNN4ebVnTZFnjkuwEQQsyiNJz97B+L+jqjxTnYClAM?=
 =?us-ascii?Q?qHiUezKFFp0s+8iJzC3w//x8GKrlrThSjeNhWI/jVVddZ8jcIjKPGsHQv7ID?=
 =?us-ascii?Q?BFiAmdkaPv15MHEw0nqSZ8yy8FaVDWSyCGh7N5SyhJSmzRcPqV8T6oFDUIA6?=
 =?us-ascii?Q?QZikQ7G6dk08Df9b22RD/wNiEQocVfZoHJobqo/A/4ku9L0u0HQvNZN+cAnX?=
 =?us-ascii?Q?j7BNaD5o4qkHPDpplIHawzUABMBqzaBHdhQX5JgML3VzZ4YxZLkM+qHqKeP0?=
 =?us-ascii?Q?KSN9pQ3S4R4ZLa441Y8XcVd93LzVPcx2CIK85NSr3kR8eii9gtXjAAMQ57Zm?=
 =?us-ascii?Q?apHdwruOx7pAzf4wJFKr1ioHddn9pbiHQ66BL8OV/oiaPTVk3LKHXUUQIGwW?=
 =?us-ascii?Q?K9UAu1CwNX7HZscli9G4OjrwPjhsyfwTTzRi/2YwAq8aBjS1nILeRPjkEE3F?=
 =?us-ascii?Q?mDaoCDWx16G7bnEckIj3R/1wrZ5hKyQW2Gh9rCMRo2zgXPgRrRuNWR+O2tIj?=
 =?us-ascii?Q?A3l0cBRuoLtjzf/S+hOd5/6SL+tnqt2+/jd9hOVXl6VkR2dR303jYfA7oCSl?=
 =?us-ascii?Q?pP4P8l02IvaWblPk9t90Y6NlPE9VS6ZcNxS+ZOfIMurKmY9aocVYiOqhAIUP?=
 =?us-ascii?Q?/7bJGnrMWeR0GaOiIr7aCkWbEPWw83rXaySFda1+tT3L7rB/ZPaX95DPSnZo?=
 =?us-ascii?Q?DHMth14nmOqZN7hokbtoxMAmSOuVoBCk1tHrpHSLKC163VQgBYl/ue5yklpe?=
 =?us-ascii?Q?/ZLp2UXV2eg/+Fvu3bmKId1Lq0d5iqmYhg8MQSbcfuNsbbdWLMlgc+LlMA7/?=
 =?us-ascii?Q?7SJqVFggcc40CwubwfqUcgVNXcBFAQ9xV/v+2vbmGDAUOXP93dOU2SRr/PPc?=
 =?us-ascii?Q?1qqXTcJG1MyOaaSbecosj2B4rvT0my12GlkoeC5UjYoqBLTafqUtOr+px9Ok?=
 =?us-ascii?Q?Qb4kdQFAxIlo8d9DKUc=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 15:08:44.4990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef79e1a-6157-4515-a190-08de0cc5e678
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB4724
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f10a7f cx=c_pps
 a=Cjv2mA+u7YWQeGlDvlytMQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=w1d2syhTAAAA:8 a=32g9PYb5q3eW87rltrEA:9
X-Proofpoint-ORIG-GUID: i4tPo0XWHeBCOeNBJ5eWL5GRqFXKlaBy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDExMCBTYWx0ZWRfX8BEKu0ISNq7c
 IHlloGwSWZGXT1tCF1XfoJpybWspT0YPRZKydE8Vw24LMWN+nmEsozap5aDkZ8ZTY+V8nFRz+hm
 0SxdCQWtLpB58WaOSW6KOskUENupC0kSupIu/rCNQ85ki9lA6AMpBN7RZ8MnIzFbolUQHVt0t1U
 8sq76phvkRb/SoCvp+/CZdQzHVodyz3XjqgzeDTRHGMO3tt3gczWPEtEXreUuNBHyXZ7y21xMMC
 Qt3S+MMZqtD+hC2kLNzJfS81hEb+gklbIrI/x3TLNPxJl/407O1KffqXvZTyuHHavlVRzo/JeQJ
 izMyBk8b6bH2BR+IED+QTiQg3EO5Po4U9hT0dKybDllwODIq8X95xjUscj4Us9eU+j+DrkaxGFz
 ce9CtDNCtJMv4uX7vzitVHiLGMw4QA==
X-Proofpoint-GUID: i4tPo0XWHeBCOeNBJ5eWL5GRqFXKlaBy
X-Proofpoint-Spam-Reason: safe

This adds some match entries for a few system configurations:

cs42l43 link 0 UID 0
cs35l56 link 1 UID 0
cs35l56 link 1 UID 1
cs35l56 link 1 UID 2
cs35l56 link 1 UID 3

cs42l43 link 1 UID 0
cs35l56 link 1 UID 0
cs35l56 link 1 UID 1
cs35l56 link 1 UID 2
cs35l56 link 1 UID 3

cs35l56 link 1 UID 0
cs35l56 link 1 UID 1
cs35l56 link 1 UID 2
cs35l56 link 1 UID 3

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/soc/amd/acp/amd-acp70-acpi-match.c | 157 +++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/sound/soc/amd/acp/amd-acp70-acpi-match.c b/sound/soc/amd/acp/amd-acp70-acpi-match.c
index dcecac792e6d..871b4f054a84 100644
--- a/sound/soc/amd/acp/amd-acp70-acpi-match.c
+++ b/sound/soc/amd/acp/amd-acp70-acpi-match.c
@@ -30,6 +30,20 @@ static const struct snd_soc_acpi_endpoint spk_r_endpoint = {
 	.group_id = 1
 };
 
+static const struct snd_soc_acpi_endpoint spk_2_endpoint = {
+	.num = 0,
+	.aggregated = 1,
+	.group_position = 2,
+	.group_id = 1
+};
+
+static const struct snd_soc_acpi_endpoint spk_3_endpoint = {
+	.num = 0,
+	.aggregated = 1,
+	.group_position = 3,
+	.group_id = 1
+};
+
 static const struct snd_soc_acpi_adr_device rt711_rt1316_group_adr[] = {
 	{
 		.adr = 0x000030025D071101ull,
@@ -112,6 +126,134 @@ static const struct snd_soc_acpi_adr_device rt1320_1_single_adr[] = {
 	}
 };
 
+static const struct snd_soc_acpi_endpoint cs42l43_endpoints[] = {
+	{ /* Jack Playback Endpoint */
+		.num = 0,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+	{ /* DMIC Capture Endpoint */
+		.num = 1,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+	{ /* Jack Capture Endpoint */
+		.num = 2,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+	{ /* Speaker Playback Endpoint */
+		.num = 3,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+};
+
+static const struct snd_soc_acpi_adr_device cs42l43_0_adr[] = {
+	{
+		.adr = 0x00003001FA424301ull,
+		.num_endpoints = ARRAY_SIZE(cs42l43_endpoints),
+		.endpoints = cs42l43_endpoints,
+		.name_prefix = "cs42l43"
+	}
+};
+
+static const struct snd_soc_acpi_adr_device cs42l43_1_cs35l56x4_1_adr[] = {
+	{
+		.adr = 0x00013001FA424301ull,
+		.num_endpoints = ARRAY_SIZE(cs42l43_endpoints),
+		.endpoints = cs42l43_endpoints,
+		.name_prefix = "cs42l43"
+	},
+	{
+		.adr = 0x00013001FA355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "AMP1"
+	},
+	{
+		.adr = 0x00013101FA355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "AMP2"
+	},
+	{
+		.adr = 0x00013201FA355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_2_endpoint,
+		.name_prefix = "AMP3"
+	},
+	{
+		.adr = 0x00013301FA355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_3_endpoint,
+		.name_prefix = "AMP4"
+	},
+};
+
+static const struct snd_soc_acpi_adr_device cs35l56x4_1_adr[] = {
+	{
+		.adr = 0x00013301FA355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "AMP1"
+	},
+	{
+		.adr = 0x00013201FA355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "AMP2"
+	},
+	{
+		.adr = 0x00013101FA355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_2_endpoint,
+		.name_prefix = "AMP3"
+	},
+	{
+		.adr = 0x00013001FA355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_3_endpoint,
+		.name_prefix = "AMP4"
+	},
+};
+
+static const struct snd_soc_acpi_link_adr acp70_cs42l43_l1_cs35l56x4_l1[] = {
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(cs42l43_1_cs35l56x4_1_adr),
+		.adr_d = cs42l43_1_cs35l56x4_1_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr acp70_cs42l43_l0_cs35l56x4_l1[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(cs42l43_0_adr),
+		.adr_d = cs42l43_0_adr,
+	},
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(cs35l56x4_1_adr),
+		.adr_d = cs35l56x4_1_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr acp70_cs35l56x4_l1[] = {
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(cs35l56x4_1_adr),
+		.adr_d = cs35l56x4_1_adr,
+	},
+	{}
+};
+
 static const struct snd_soc_acpi_link_adr acp70_rt722_only[] = {
 	{
 		.mask = BIT(0),
@@ -151,6 +293,21 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sdw_machines[] = {
 		.links = acp70_4_in_1_sdca,
 		.drv_name = "amd_sdw",
 	},
+	{
+		.link_mask = BIT(0) | BIT(1),
+		.links = acp70_cs42l43_l0_cs35l56x4_l1,
+		.drv_name = "amd_sdw",
+	},
+	{
+		.link_mask = BIT(1),
+		.links = acp70_cs42l43_l1_cs35l56x4_l1,
+		.drv_name = "amd_sdw",
+	},
+	{
+		.link_mask = BIT(1),
+		.links = acp70_cs35l56x4_l1,
+		.drv_name = "amd_sdw",
+	},
 	{},
 };
 EXPORT_SYMBOL(snd_soc_acpi_amd_acp70_sdw_machines);
-- 
2.43.0


