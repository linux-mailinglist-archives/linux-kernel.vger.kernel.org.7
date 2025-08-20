Return-Path: <linux-kernel+bounces-777717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDF6B2DD0B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CF61BC1B04
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1745131771B;
	Wed, 20 Aug 2025 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="m13545sE";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Ur7Jw7FW"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D111B31AF38;
	Wed, 20 Aug 2025 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755694276; cv=fail; b=My+m9UNBlVV6P3+8taTvtRwxJaqkRlADfdH+I020NB8mI67xyVn/fkiM0h23IaceF6G/sv1YKclhswRsrDenVEnKAtUkwhiTWpYkOBn/euppuu4mhW+bbos62IS0aYqr6iE4jb+KhrMoyheVKfdN8RORNFjxFruAALyOfyqsJz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755694276; c=relaxed/simple;
	bh=KkvmobLrvGiN5HSRfhFLn0nhYtkYCtq/T8YtCBPmNGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcOWEDekbDxryOWVDfo6BATaelUHyppnFUfma+9XaBurOUtLdXW4+v7IAoQ7AHVuvRl6/tWW9RlCC7UxjchTYLyNTM88K3BxTtLLHUtKce8u74LXlgWyItvbRmcxr1qMjDRYhos8p0ID+s40T8qiToQJdPkZnl8YFpAsLbSeSFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=m13545sE; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Ur7Jw7FW; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57JJZ8QU732167;
	Wed, 20 Aug 2025 07:51:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Xg8qHdTvTBOJbyT063CTm+3q3zhkzcpQJKZrpMeWnNA=; b=
	m13545sE+7KGayItDWJEQm2yNaqLDtP3+MuF6fyEBo1vCplmV28Sg4uId3KyMsum
	+Bq0Zb78oLwCwUEHCaIO6YZcVK/gcxF+/F61Q8vNhwrp5I99SngVNp33Ae8o/SQ7
	Pj/+6icNldQYXrUYZ/IHGibqUqHAHg/9A7vetYLLjmwAr/h546P4BAPUAc2kZ6Z6
	QCIsm35t7QFL7pRywv5YH0nVynzlqgWorj2Ke5zN8DO9R5EwAWX+b3927PyrWdgC
	shqUNtoZdb8FEw9aNDdRnZ0YqQF53Q6N7QQrlBq6HKet0ESuwKUYbAfoUeuWPV9I
	0tuFUXQFHAreew/qdTd1fA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2131.outbound.protection.outlook.com [40.107.244.131])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 48myd597dj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 07:51:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaMyLbgWz54TOl64kjALPrQ7v1T43aU3Cry4pTH/GKXhkX6/+Nf6HiWCPpFgnRuHHPXstaji2LN3k5yTPie7U0kIrCpZHjV2XWKqgfvqk6G0X1quZlLPWbjZybcORngH9FOCFz5kgSAhtbeSDqAdK1pc0kyOt3KY4GQxyalwLQbiObYS1jdNJHi3fzvf9/GfiHyV/Z2NLQAflFhZygkxo9AF65lywmSSteW3BkNxpc/zffBGFqlGa3qLxUrrOnh01pXSeWUu7vRJ/ERqJMU6EYvrS5Vy+S1fHo5zge9Pd2c74uKazgZkJJiQxKcxLVRlmp87xEHosiBwiMcVDBfIGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xg8qHdTvTBOJbyT063CTm+3q3zhkzcpQJKZrpMeWnNA=;
 b=hlff4g7XaDmWW+JkcAMfMg6QblfwrHQNak4v6ZeyQh/S3cOhXa9fbLLqmlfcwdGEjA+ow+Ia95RRL74kiWKZe/Cs4Lkz4HhHRFPdzWYrMHG2qUqaSNnOOTJUylU7osiihEI8cN8Jtf3bCO19sEhapIB82fi9EvzfkjK9zzUUMYtqkKAWUQJForTG/JMyGtaHjbCzLkqUKO0p6/Qo6wBJuI1NiWKisQnomNghUzongMwckIotW0bquU+sFlNPahTdvSSW3JE9bhi2FN3gGz3SLNYogApDioQz7OVNEWgIM0UF3ANzPg8GWENx41ZNEFrEZK+rp6rT0JCgWKZdPgsT9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xg8qHdTvTBOJbyT063CTm+3q3zhkzcpQJKZrpMeWnNA=;
 b=Ur7Jw7FW4AFyq+lfFkQS4UZ1qS8Sf2OXtQgWxgRldFMTfQWhvFcAxIPJaSZw4R2dpl74XgBYyyrO/Y5Zc68+NMtMzacWoYW2Zk+fnBJ348g0vda/Tgaa4L+Coi+gy1evzANrnisinfY1drSp32ocQz7J2RYqCEgP1inHfpui4jQ=
Received: from MW4PR04CA0304.namprd04.prod.outlook.com (2603:10b6:303:82::9)
 by DM3PPFC1DE74F70.namprd19.prod.outlook.com (2603:10b6:f:fc00::757) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 12:51:02 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:82:cafe::11) by MW4PR04CA0304.outlook.office365.com
 (2603:10b6:303:82::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 12:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.0
 via Frontend Transport; Wed, 20 Aug 2025 12:51:00 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 25CB3406552;
	Wed, 20 Aug 2025 12:50:59 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id ED61382024A;
	Wed, 20 Aug 2025 12:50:58 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 2/3] ASoC: cs35l56: Handle new algorithms IDs for CS35L63
Date: Wed, 20 Aug 2025 13:50:35 +0100
Message-ID: <20250820125045.117740-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820125045.117740-1-sbinding@opensource.cirrus.com>
References: <20250820125045.117740-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|DM3PPFC1DE74F70:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 79ebaa90-07e2-41b2-9ab8-08dddfe83731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yl0CYHwr7azuMSnI3GcqGHAZFrF1KljX7koN9QjLIXPMutCRWTmMq+avOjSs?=
 =?us-ascii?Q?h6WQp/gIHNSR7cAolhHT6b7ulAYT4MuQcA+WA0jlVgDrugMkpLEbG9JYOuIU?=
 =?us-ascii?Q?H8LuaNsfs+tRzYDQ5tAaep9NV4uqkGjrbztFtOwf5s7uSLtra+8dJ75yQkx+?=
 =?us-ascii?Q?noC35NfuPf/te7Smig8DJgk5Noe0OftZ8GGZginM9raEVPNRvP5LKXq0Z/iL?=
 =?us-ascii?Q?+5jsmAaBrlztbB43CodQJ39Ei27aEEXLGTJAiZuWGPtHiENnv4n99eOrScxk?=
 =?us-ascii?Q?qtsl+07rvdB3i6qiNVaOvo3tbUTqGBUxLpM8K1f1hgDBs7DGRNMB5Kt3cAJB?=
 =?us-ascii?Q?lgyuvrq+UFNU2WKplw6j8+GZpDThGIT7Sn8VmhWxNzWf4zWzaLkN/RkOTOjb?=
 =?us-ascii?Q?Sv6ZVpvna6sGxOWt9uj4Z3+FpDG33p9+3xGImK7IfQOnpFBfi+FkA1qhmuY4?=
 =?us-ascii?Q?kd8K4oJmFC5tL6gjSVgIyUYhISlvHTfbsYmPUidh6Bkff+bgIa55XcpxLX6x?=
 =?us-ascii?Q?c643DzstGsI+YwPcfli4BN9NByZHl8PC0dfhpzrnRhNrMhsxXHUpSgTBnFxp?=
 =?us-ascii?Q?pYzrq4ex5kSj7Yvw6vUlGCvRCVPEavCuZV45XOr6GcBJnL1EKvmjB2Ln+K3L?=
 =?us-ascii?Q?4aZwYQkRzsTCgr7Acjv9iKlrawI6iUOY+XFHMNEZNoWvSQB3IPtwTVi2hT2+?=
 =?us-ascii?Q?38xUukU6GWaI4nHn8cHdiz/M55dNVzcodDl6PspUb3BeL0ZhX1jao5M4yKW4?=
 =?us-ascii?Q?xjuQFQA9JrXr23OEYkG8Mvppuf5l9GWatD2eTBc3K8HOFRuS6IQ5pVHK2r1U?=
 =?us-ascii?Q?sZZzxSmIz0qfbC68TZtGqE5eH2amveH4awiGrX+oHVx1b1ak0hH1dzIy3VaE?=
 =?us-ascii?Q?SEA1wGzQg9WchbK1PL8aZtI0qP7n/KIt/niw0k7fTudi2jG3ITx/ptUcV3vm?=
 =?us-ascii?Q?1AUrHjOvNqrgxbz07Fmw5w4SF/W5LH/O6xSNJLDPSh2+06eubzN5lOTQNiA2?=
 =?us-ascii?Q?bloAtNi05fuz2BVBj5a+O7nqsBSZtLHtFh+qIVplN8uB2phIhM9LZkP29sR4?=
 =?us-ascii?Q?wdknsYGETJCBJyHVmPEHVpqHr8TsOzXXPQ00jWb8T2HsNYjmDsxPozHkSmjv?=
 =?us-ascii?Q?b9lghodPxYZzrdFoqGLvVUGj3VntOWyhqG5HlaDsoIuutnAi/PVFFftKY7rG?=
 =?us-ascii?Q?n7iy4PXlmov70FC8DUC7lqNGXfB+WgUJs7nI/ajpWv5UYKFT9caLfYP9ZjHB?=
 =?us-ascii?Q?xB1ttzeAOBysUThmnx6RP23ylzbqu+3bxs7EREoGQiXNV4M66cyFji+hB+75?=
 =?us-ascii?Q?+KoKEgj//ho60uioe/B16kfkQ+VhVhb+yb7LLZupf90MEcgGTTejEBZnVVT/?=
 =?us-ascii?Q?zbUINa/B0NiBPy9lnMr1flTrW83qD1fFyBjww0TgGQ/MlPXiSCpH4hWjJ9V6?=
 =?us-ascii?Q?xMjEOum7RIMH4ogD7m58P9OBjwAOSWZXmOtUQzqk9xmPj4R+rs8qucPXa5xG?=
 =?us-ascii?Q?IJpvwjwvehXcgcY9Tos0A3Itt/UFixj93TNg?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:51:00.4603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ebaa90-07e2-41b2-9ab8-08dddfe83731
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC1DE74F70
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDExMyBTYWx0ZWRfX3v8YOw0pfN1i
 DejZVFVBNaC7Pg6YXzFqbRUVw7AJ1OZB7629nG8kffATWbi2Hb+I+5+lrryQZTW1vL39AimLwmU
 q0fB0PdEfuKBW/cAEaZ21XbLa+WP22SWOmbHFkh5oOefafv9Ytdcq6GALlawbuIa+8oaiywgVvM
 ULTDEMOlh/3WxEwnel8g265773R2dgf2slsKOLUPzJLzsuIMmE+EPTXxDzllb9RtdEqQgbmrsDK
 kZCP13Jx4e2gHWnFqibzHF75QTENUg0lkKgcugW0jIWdNZWrsDktVUqgDi/EI5TcFdA5nzZSNvU
 jlSM6WqFf6HISAWrc9Lh6GJLtBFqhK6DvJGEVR/Q6+X66HWCv/LHZdtoDnax1FCAesq7lAoQGBy
 CUBkCV+8LO7eJS7TPqToOXcW0CT78Q==
X-Proofpoint-ORIG-GUID: OTsYJ62HL5MWLvCGf3T3GMQIqMyHqVfe
X-Authority-Analysis: v=2.4 cv=EpWLbScA c=1 sm=1 tr=0 ts=68a5c4b9 cx=c_pps
 a=OlAd6myHLz+OteJZ2xboiA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=2OwXVqhp2XgA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=rSAZ-gJm6b_PRif3JyQA:9
X-Proofpoint-GUID: OTsYJ62HL5MWLvCGf3T3GMQIqMyHqVfe
X-Proofpoint-Spam-Reason: safe

From: Richard Fitzgerald <rf@opensource.cirrus.com>

CS35L63 uses different algorithm IDs from CS35L56.
Add a new mechanism to handle different alg IDs between parts in the
CS35L56 driver.

Fixes: d3197a09a117 ("ASoC: cs35l56: Add initial support for CS35L63 for I2C and SoundWire")

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 include/sound/cs35l56.h           |  1 +
 sound/soc/codecs/cs35l56-shared.c | 29 ++++++++++++++++++++++++++---
 sound/soc/codecs/cs35l56.c        |  2 +-
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index f44aabde805e..7c8bbe8ad1e2 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -306,6 +306,7 @@ struct cs35l56_base {
 	struct gpio_desc *reset_gpio;
 	struct cs35l56_spi_payload *spi_payload_buf;
 	const struct cs35l56_fw_reg *fw_reg;
+	const struct cirrus_amp_cal_controls *calibration_controls;
 };
 
 static inline bool cs35l56_is_otp_register(unsigned int reg)
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index ba653f6ccfae..850fcf385996 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -838,6 +838,15 @@ const struct cirrus_amp_cal_controls cs35l56_calibration_controls = {
 };
 EXPORT_SYMBOL_NS_GPL(cs35l56_calibration_controls, "SND_SOC_CS35L56_SHARED");
 
+static const struct cirrus_amp_cal_controls cs35l63_calibration_controls = {
+	.alg_id =	0xbf210,
+	.mem_region =	WMFW_ADSP2_YM,
+	.ambient =	"CAL_AMBIENT",
+	.calr =		"CAL_R",
+	.status =	"CAL_STATUS",
+	.checksum =	"CAL_CHECKSUM",
+};
+
 int cs35l56_get_calibration(struct cs35l56_base *cs35l56_base)
 {
 	u64 silicon_uid = 0;
@@ -912,19 +921,31 @@ EXPORT_SYMBOL_NS_GPL(cs35l56_read_prot_status, "SND_SOC_CS35L56_SHARED");
 void cs35l56_log_tuning(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_dsp)
 {
 	__be32 pid, sid, tid;
+	unsigned int alg_id;
 	int ret;
 
+	switch (cs35l56_base->type) {
+	case 0x54:
+	case 0x56:
+	case 0x57:
+		alg_id = 0x9f212;
+		break;
+	default:
+		alg_id = 0xbf212;
+		break;
+	}
+
 	scoped_guard(mutex, &cs_dsp->pwr_lock) {
 		ret = cs_dsp_coeff_read_ctrl(cs_dsp_get_ctl(cs_dsp, "AS_PRJCT_ID",
-							    WMFW_ADSP2_XM, 0x9f212),
+							    WMFW_ADSP2_XM, alg_id),
 					     0, &pid, sizeof(pid));
 		if (!ret)
 			ret = cs_dsp_coeff_read_ctrl(cs_dsp_get_ctl(cs_dsp, "AS_CHNNL_ID",
-								    WMFW_ADSP2_XM, 0x9f212),
+								    WMFW_ADSP2_XM, alg_id),
 						     0, &sid, sizeof(sid));
 		if (!ret)
 			ret = cs_dsp_coeff_read_ctrl(cs_dsp_get_ctl(cs_dsp, "AS_SNPSHT_ID",
-								    WMFW_ADSP2_XM, 0x9f212),
+								    WMFW_ADSP2_XM, alg_id),
 						     0, &tid, sizeof(tid));
 	}
 
@@ -974,8 +995,10 @@ int cs35l56_hw_init(struct cs35l56_base *cs35l56_base)
 	case 0x35A54:
 	case 0x35A56:
 	case 0x35A57:
+		cs35l56_base->calibration_controls = &cs35l56_calibration_controls;
 		break;
 	case 0x35A630:
+		cs35l56_base->calibration_controls = &cs35l63_calibration_controls;
 		devid = devid >> 4;
 		break;
 	default:
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index b1c65d8331e7..2c1edbd636ef 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -695,7 +695,7 @@ static int cs35l56_write_cal(struct cs35l56_private *cs35l56)
 		return ret;
 
 	ret = cs_amp_write_cal_coeffs(&cs35l56->dsp.cs_dsp,
-				      &cs35l56_calibration_controls,
+				      cs35l56->base.calibration_controls,
 				      &cs35l56->base.cal_data);
 
 	wm_adsp_stop(&cs35l56->dsp);
-- 
2.43.0


