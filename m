Return-Path: <linux-kernel+bounces-798186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE21DB41A71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95C547B59D6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6358F25F96D;
	Wed,  3 Sep 2025 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="MZIac0Av";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="jlEHBvZV"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008A4272802;
	Wed,  3 Sep 2025 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892777; cv=fail; b=BUU5AEUpFH2LvPsTS9XIsX3IwvEojfkMFq6iYUczVgShfIrIuLB3cz9fq9MfS9LJjZEgjEmiE+qX4Koo7lEKGmBNI7DI5di+nxezPwOyBeyoZ87jQcgVhUHU3Ps2f5x3SsJRnjLtNC7tJQnaqG7iYWE1TrfI7uyxUN9D4g1Sz0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892777; c=relaxed/simple;
	bh=o6LFQclfA99Y63Xj2n835Bfjmv47PbvzpJh5dnjaD6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zm6fd0Jmxm5WdM5I3ZWF9IOizAGEbJ/V7FPNNPX94MtKkCoiJxOlf0XnNST+zbguTo5ci+Z5HQJdK65h6Ap3e8uf+di7XwIXvTvBBO2X5rdDjcZsvI3GzKhzogMW0X88zB9Bza1Gcg8Kkjxe3nUt+YO2zd0b7UCv/G8/0Yr/Q/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=MZIac0Av; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=jlEHBvZV; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 582GW6sY3194543;
	Wed, 3 Sep 2025 04:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=WgADcaugluWe61r97qE4GJqpqFwgZGletQOxkU45hIg=; b=
	MZIac0AvlXZmoB0Tbc37q0uZHLGVKJ2Y1KoywcyexpQNrb2igsF9R4YWZyn2/4N+
	NaJRRrn662NSXmYuUs0Nsr3MSMsMWMKHtQuVzuOKitPcKrRrr2jx3TUdgS6sw5MH
	IN2ngDuYigf/xaNGqyqs4wK9G4Ce4nj13iiQOAMuHiMOzYeluYfH4735OQL/9ke/
	GU9LbLra638PzwrtjqoEXAe3o7+Yc0IC2Xx8gVLRDuxMyFz2pdwv8Oy4mDkgYt5m
	4n3EyPSBHnpCeybBhPyyTQv04/CKRWaboKif7tFODYPgXeZwKsL5BREAzcB4uwaZ
	1ki8pjOEDRPx383bRuHyyg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11hn2228.outbound.protection.outlook.com [52.100.172.228])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 48wce2avdv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 04:46:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECwjmvgQlC8pF8nGIlHxJ0fOjaqWBDLjiX1p42EXslDhfTjGyUYItjnV/Nie9P4jreFZhwAnlE0pgVKQQ0frZo1MEUM/W1xsFVr8W6Vbi/p9ffvoMVwh5m4IcK85e0QBR7EeKJS4sWEKo2kMmBC5LITFBIhcBXVhjJ4XeDJz/GbN4j6UjNuun6CUVTXTIrTUoye0Wpq1DL+sOjg1gh6mpD4BuAniGEDJk+10aI0niuDLWgkG2e7EHkYBXdaxt/N4H7mSFvZLSOwhCYjwWLdw8CbsC05NY+OtLgGzI3Q7OmkPmqX4oLYxTTg+v6wIDflbamQxmLz0bXJDAGCYS1WK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgADcaugluWe61r97qE4GJqpqFwgZGletQOxkU45hIg=;
 b=CT9a8UpprYSNRSg4Be+sA9r9RftV46VcWV9XlqZ/djEbIsjfRIPSjyGo1tdi0o3LFciI5Ei0HzCNbTlc4UtdWWjYHxVWeAQwXU9smv9MikLRH+LyLELTJmbqZaLLY249TUfiQ8mWR47FzfaZeYi0MC5o9zu95ij8TPGXuFk/X8DNvxVciOORuSVMq83uGII1XIUeuxXWyhrV+pgGjmVKmgbiRBcFtxZzkZCMU4Hxg+VM08VAEAcNtiWnwI+gi9B6vag9MZqz5WICgYxmyYHeBs0dCLVysJt8SXGZMaQvHjiXkc9AXDDmiH+VprJOvZo66hpomAVRuciYk6HFLQQINQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgADcaugluWe61r97qE4GJqpqFwgZGletQOxkU45hIg=;
 b=jlEHBvZVhn+N5HU23/Mka4Ks28WjI6iyiqZa0VDpf0pqi1ixp0HyAVkufJIoez5fYM/fYGNruHwnaKU9eUvP7FyVtSThzbsq1oKTYHypmnNDrscuFsZj68UCmqaikv/geZDE1ejAy8UR3yXsb7+/mS4vCh3TD6CWyCFJLvqPAQE=
Received: from BN9PR03CA0640.namprd03.prod.outlook.com (2603:10b6:408:13b::15)
 by SA0PR19MB4320.namprd19.prod.outlook.com (2603:10b6:806:81::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 09:45:56 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:13b:cafe::af) by BN9PR03CA0640.outlook.office365.com
 (2603:10b6:408:13b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Wed,
 3 Sep 2025 09:45:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.0
 via Frontend Transport; Wed, 3 Sep 2025 09:45:56 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 49C67406558;
	Wed,  3 Sep 2025 09:45:53 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 340AE820273;
	Wed,  3 Sep 2025 09:45:53 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org, lee@kernel.org
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH 6/6] mfd: cs42l43: Remove IRQ masking in suspend
Date: Wed,  3 Sep 2025 10:45:49 +0100
Message-ID: <20250903094549.271068-7-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250903094549.271068-1-ckeepax@opensource.cirrus.com>
References: <20250903094549.271068-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|SA0PR19MB4320:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 58b680a7-1353-4c61-cd43-08ddeaceae57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|34020700016|61400799027|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CsN3Y56TX24LlIAEdfGB/XqCKuJQXSnhS8e3hvMPHFhUJb2SJIMbdfjyjuHP?=
 =?us-ascii?Q?TDAF4hx6EcELe4sqzFq6qFZRYh+mFSSzwLgB/KpinhOflY99cDwZ3i7i7BWg?=
 =?us-ascii?Q?fYgXWUCRoqrD70KiYlhbNooaFMYUsGPMwoc4VzQXDwPUBH5XR2vJqmjJ7HyH?=
 =?us-ascii?Q?HjWzGXZaDrzD5CboPXol6jEZiyGFkqsUHeBhQr36jhVivGr6OfPN+q2epwXi?=
 =?us-ascii?Q?NHr+4wGWUarR4za2IBKnYU/XFTpvBFWZXlUyXLMhmlRNzjcmZmqFV/+4Tcwx?=
 =?us-ascii?Q?zN7nd+ZyEDAZ749KMjXIFZZ4vMGwAjhitw3hUEkg22aXwKLRJCrVtEUqSgDd?=
 =?us-ascii?Q?5FxhYl3CqtknpZzvDfO/LTJcYnP1uGbBqCBem8TNqL+R3ODlflcVxq4RBXsR?=
 =?us-ascii?Q?Gb+AdFZzI4b8NrG/iPEczyCvmcbUQ0FaeP+A5+Rc4xPAwdQywi1aa6xuBlkM?=
 =?us-ascii?Q?Tgn5C9HP+UXV8MjemesAQYUzOHl61oSqK9ggncmQjf3fRQvnyVDmQ1f1tfXT?=
 =?us-ascii?Q?FTAU9SnfiBTIVfngotVKUXajlSUX1kkPyiT1cB0hQ9g2LCVn0icCGQ+FAJh2?=
 =?us-ascii?Q?Y70nroe5SimXdMTO+msTz/d/6DS6AWF07D+GOwdi/KijiI9m0GlIqn8VGz4r?=
 =?us-ascii?Q?4gdxg5V5wTq8mk2iBFvWyAW3936vNofCJgBkL73f5SIXkKrGJyO4Frr8JXoZ?=
 =?us-ascii?Q?Bqd/IF3trGK/Swp2VOjFOY8uqVBesdmcUDeEacbxqP62zu/Md4I7YSbH9wwo?=
 =?us-ascii?Q?dQK90ka96W2yJNlPWd7jkkigEvZrXPN9UNOO60/YrWhRVfcfQi8rTPTEVncJ?=
 =?us-ascii?Q?9nI8fR6XH0WLtf+32ihj6pgU/M9D8akqYGl4AhSD77J/BBoOzdUoW4GFaQj0?=
 =?us-ascii?Q?9MOwyYG+f81i406HqJJSAod+n3o07PWdj5pzb5lUsB5IHtTlQdwNgDjQzO6X?=
 =?us-ascii?Q?LXcXqTviT3r58g8ev+U3r6b9+fTQGt5FrsAj2Tf3Mb5Ck4zdcRwQkoRbDDtE?=
 =?us-ascii?Q?tnT8C0NDYIm7VnWNksWJ5H7IA+uHedeqF/x5E9rA7366RBQ+HofxOwFikujq?=
 =?us-ascii?Q?FG/FtYGepiC5EEt6cDeqNqN92Q1j47YnTCVefCNn2fP8l3QSm96xQiFN6nX6?=
 =?us-ascii?Q?RcbLR053HH34u9g9UfiuXhj7Uaukbq2/xOBODfB6qzWUry/OmRObuAx0Cujy?=
 =?us-ascii?Q?LxgK07TptMvuxTRZ6rR0JT3VYJkW9EHzYtb/OwidpY1z2x175LAW1qjUfzyO?=
 =?us-ascii?Q?dftVuYya90CORT4o9dRaxCosAmbCBrduwtZHatYWqTWcpyM9SkCIu44YhviQ?=
 =?us-ascii?Q?jSLeeeajYRnh8RNmf+5XO56FU7TUhchC3XS5yqNqJ8DSqhrzCJTqxd/OPr45?=
 =?us-ascii?Q?flCaH5zcG5rL32VTeeHH0t9X8deVfuXNMFIkqgGNmAYWqBS0ttnxFZWoGKTV?=
 =?us-ascii?Q?90kqffbTMljk9GSivYO1ej7Xnt/uIFmOUAabRkgD7hSUDObbwJb+wyYJf/Nw?=
 =?us-ascii?Q?NKsWinsuMfLDAuZh8bVUS4s3gl9PT/9udxLO?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(34020700016)(61400799027)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:45:56.3406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b680a7-1353-4c61-cd43-08ddeaceae57
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4320
X-Proofpoint-ORIG-GUID: r3m9fC0akehJqbnd4xIszINkhVHcyhuH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDA5NyBTYWx0ZWRfXxDdKMzjejIsI
 anD+v6tJXkY/9r6OBsi4MKVkpBd0/T3mnGMTJTN75KttRbhhXXI65R6GAXVYaeUNFzlSJpQ7Kem
 HHgn+Q29YOPP4vBlQjqmIsAwnYPn8QVkI6CtaaniTEWvH9f/hIRqPI8gpMDQ7UVlLTdn71kj9wD
 WvG6KeMg0yIjvC3XL1MBAfgvm/y49XsUBcMc/zr/uoHih21/UeFWn1bfSIxnbCwJI3HIR6WEphN
 GWPebzwX5vtOJ7klTQhmbOZ4Fk6YNTpeJrOhgKZZ+J+Nv9tg9yF/v006GMFQerhbRYJXYZWFPv0
 T3O6/j54mZ1eAKY0CZG4UPtVzqqw/Q6MQFtGdC4Jxw4SgrH9I/kHmWX+dgUOj8=
X-Authority-Analysis: v=2.4 cv=EvfSrTcA c=1 sm=1 tr=0 ts=68b80e58 cx=c_pps
 a=TfT5oGIBKUOXOh1H16nFbQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=s4LoxV2n_K51Rj4AR4IA:9 a=jZz-an6Pvt0H8_Yc_ROU:22
X-Proofpoint-GUID: r3m9fC0akehJqbnd4xIszINkhVHcyhuH
X-Proofpoint-Spam-Reason: safe

Now the individual child drivers mask their own IRQs there is no need
for the MFD code to do so anymore.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/cs42l43.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 959298c8232f4..107cfb983fec4 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -1117,24 +1117,6 @@ EXPORT_SYMBOL_NS_GPL(cs42l43_dev_probe, "MFD_CS42L43");
 static int cs42l43_suspend(struct device *dev)
 {
 	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
-	static const struct reg_sequence mask_all[] = {
-		{ CS42L43_DECIM_MASK,			0xFFFFFFFF, },
-		{ CS42L43_EQ_MIX_MASK,			0xFFFFFFFF, },
-		{ CS42L43_ASP_MASK,			0xFFFFFFFF, },
-		{ CS42L43_PLL_MASK,			0xFFFFFFFF, },
-		{ CS42L43_SOFT_MASK,			0xFFFFFFFF, },
-		{ CS42L43_SWIRE_MASK,			0xFFFFFFFF, },
-		{ CS42L43_MSM_MASK,			0xFFFFFFFF, },
-		{ CS42L43_ACC_DET_MASK,			0xFFFFFFFF, },
-		{ CS42L43_I2C_TGT_MASK,			0xFFFFFFFF, },
-		{ CS42L43_SPI_MSTR_MASK,		0xFFFFFFFF, },
-		{ CS42L43_SW_TO_SPI_BRIDGE_MASK,	0xFFFFFFFF, },
-		{ CS42L43_OTP_MASK,			0xFFFFFFFF, },
-		{ CS42L43_CLASS_D_AMP_MASK,		0xFFFFFFFF, },
-		{ CS42L43_GPIO_INT_MASK,		0xFFFFFFFF, },
-		{ CS42L43_ASRC_MASK,			0xFFFFFFFF, },
-		{ CS42L43_HPOUT_MASK,			0xFFFFFFFF, },
-	};
 	int ret;
 
 	ret = pm_runtime_resume_and_get(dev);
@@ -1143,14 +1125,6 @@ static int cs42l43_suspend(struct device *dev)
 		return ret;
 	}
 
-	/* The IRQs will be re-enabled on resume by the cache sync */
-	ret = regmap_multi_reg_write_bypassed(cs42l43->regmap,
-					      mask_all, ARRAY_SIZE(mask_all));
-	if (ret) {
-		dev_err(cs42l43->dev, "Failed to mask IRQs: %d\n", ret);
-		return ret;
-	}
-
 	disable_irq(cs42l43->irq);
 
 	ret = pm_runtime_force_suspend(dev);
-- 
2.47.2


