Return-Path: <linux-kernel+bounces-854177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 839F7BDDC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89DD5503744
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29B831A7F4;
	Wed, 15 Oct 2025 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="pPcV9qiE";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Ux70JiPf"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BB130BB9A;
	Wed, 15 Oct 2025 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520430; cv=fail; b=g/kxkMofwaeYqWIjzp/L8CYqz8334CtXP6MARr1lhnI5nnm+ibgfHJ/2EfGLzwN0ldxEOA2HL3cEXrgMeLObtavbe64dH7nm9u6ko1VxxhrcMG+j2D3tvb3TtsdsDiGBuLDl1/uxMRu5g9IfpXEUl6iMyDNZXPBcZuQWcBw8I6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520430; c=relaxed/simple;
	bh=V+mPpeH0+wG87aVEkvBSI3YjgqBRsVwdFkLpKUXR520=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOIpYPTbgu+s3hEBwSUTpLpa4qxs3h2as0TWmEjUPh5mSGkejBf7MfSh3a9NLu1ctO0VdrqGzLsuRrIz8pbNN8P0D06lra2yxS9VMBwmiYqtoo2x31BofIYJ+mz1CbmrtlLA7IR+vLY97JaJE9yLVALrDZ4Hbzp6OUrq87pHS08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=pPcV9qiE; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Ux70JiPf; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59F3oLUM648147;
	Wed, 15 Oct 2025 04:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ElpuoXzvXliDRcAMVKqJ8c/WeTNHCYgy1BgcAAlmbiY=; b=
	pPcV9qiE+oxRgs1tcg3vtRJhGIaFsggxrlCRIRS2Lu7rkxU6hqmUZndjYmWseGiK
	U3NTajkd+7qEUfURA57HKF3GmiK9hPf/q5TxsSlBiNeR39aMOvJ6eaRdQXVxblQ2
	DrWi+xHaD5tNtnp9vUywzvGKWziT0KPNmKpSK94qS7Z2mfk9A+0n4aJuCtwNf7Ei
	mCyU3HUkWA9NGjgSntcsiGV+JEk0oA/oHZOl8EH6o8/Bz4tH2RAMx+b6rqzKwu6V
	kWhKUfwR6yTITS9/ZlNw0t60FvWRaUxrF9DMiZ7x0Bggp4H7ZLCas/HrjVXfscd5
	nUwzHvJ5cUiyu2XF6/xOAA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020097.outbound.protection.outlook.com [40.93.198.97])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49sdb42fmd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 04:26:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVsY7vM0r0VI5XXNGUlNKPmuiyXEWEgX/63Kz/F/QoFqJQOZlez3FwsOKH8hAbccG4ypudMkgOld8qvCBRwD6h7Re6U1aD0q2I4kWkHMhLR+3Yx4DjlqqtVAXmIluAV0TgbT7KtWIFWxlnp/WXiib14a6e2avajwAv/eyeObSolwOpnFEzY6bkCe/xmxb4tHa6cbKwTqd9vGLVYyX7UurGwhpZHABMDQ3IdR0k1frHtkQPR0h/lgZKazpXN6GvuYxNpMPJRoL7T3A0OvlAyYwm+RqAfhq+mCeG3nvk/e598+Rqw4bt4tGQeHKrMuDaX8khTN99I36xt78YwcROSorA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElpuoXzvXliDRcAMVKqJ8c/WeTNHCYgy1BgcAAlmbiY=;
 b=GF7YWB0naqf4j06pRb84aBC83poqmmEFPYEc4SmiXeNiOuMe6czDbUdp1otM5yvaaBVQqF4F8mrLiBQlvLxT8Ihu4z/dXXp0ml2CFzDWWFvw92F4Wkcts2TIUKZgdxGS0aGJa61MZTReRJimfqHlul+QzWkEkXrfwbbZH4AZ0YXNrwtHUFeA83rDBJ6z+WH3JU7oCOOUxx/jK/I8V+ktbqYdAuB6FCkoAE1m2q/E1B2lNjmhJeB2pgvk86NNy3t+w/gBkesnsxiqwXDhO695zenJT8+O2xzASB32RulbQGCmUWW37DwZkW395a8fyV1Np8h7GFtQI3ixv/EPmXH4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElpuoXzvXliDRcAMVKqJ8c/WeTNHCYgy1BgcAAlmbiY=;
 b=Ux70JiPfY9G4p9GtFSEJb41NWTpGRabqsedzbIkGLjxwyBm0GSlNcgbbtb3UA12nuVKCNefDQBModDh3Fp8CGKAnzE5AWJZeJdVilb9nVr+rjvIxfzc/qH+/sw649Dqr8dIdfc1bvlAA0b5J+bz0/0p4bxUhEX6Y+nI+b2qcytc=
Received: from BYAPR07CA0052.namprd07.prod.outlook.com (2603:10b6:a03:60::29)
 by SJ4PPF911AD0615.namprd19.prod.outlook.com (2603:10b6:a0f:fc02::a3c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Wed, 15 Oct
 2025 09:26:42 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::7b) by BYAPR07CA0052.outlook.office365.com
 (2603:10b6:a03:60::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 09:26:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Wed, 15 Oct 2025 09:26:41 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id DA5C7406553;
	Wed, 15 Oct 2025 09:26:39 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id A18C1820249;
	Wed, 15 Oct 2025 09:26:39 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH 5/8] ASoC: cs530x: Correct MCLK reference frequency values
Date: Wed, 15 Oct 2025 10:26:08 +0100
Message-ID: <20251015092619.52952-6-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015092619.52952-1-vitalyr@opensource.cirrus.com>
References: <20251015092619.52952-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|SJ4PPF911AD0615:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 30a496a6-9b16-4c02-2778-08de0bccf34e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mlK8w9cMYbpS0Z320Cp7vKbq+One70Lhj4YSbVIJeMTxPw8JC9f02ZWAp5g2?=
 =?us-ascii?Q?WDqAD+5wJer3ZWd3+OOlj0aLElzjsNroQ+imAa5AdS2mIQU+idhAH7pLxh57?=
 =?us-ascii?Q?oijeuBh6Ls3txl4Yafm1Nf1hPSMmM77sWOfDFzwAfOdNqULmmgckSxBoW2QR?=
 =?us-ascii?Q?ivP+swyOva2WL6GPcnKgZ/8ne6tG4G1wUkjXKt8IxclmqkgbLIWQYO907WRQ?=
 =?us-ascii?Q?hMTtcYFgt917PuvKrywLYcHIWWPTjdlSTYrtO/2FEqP6BQL5Qs6ARQV1goQY?=
 =?us-ascii?Q?EDKoAQm/S+l6U3pwb/K0VZ5D06nukGHvmtGehwI9+7C6RCSyGWdEx7+C0O5K?=
 =?us-ascii?Q?YSddAOyLz7OZXDeH1cLl6GpPUpxFEmauRq+ebVH+IzzdbsC6yrMr5AoJRABN?=
 =?us-ascii?Q?19wNaEdeWQc5ZHhKCvglH0Mryy8TCww3BZ8uGw8dOBnmnF6kgvDjd+TG6tV0?=
 =?us-ascii?Q?Zo0CsaqSCHtkWYu0CoTlGwONjbAVtXDxnPZVi40dJ0+DVLo07P85ooXlAfee?=
 =?us-ascii?Q?z4dqLUtv/AWD84sfFs8gznflF9YtNGtvtv+00yoW7nfT/NjMAa+vxM4LikgO?=
 =?us-ascii?Q?RTE8d3bMq4QzbFTdErj3pEMrC/EsvIUS1SeM+ZUq7Mc2T/yPoO1mVOWvV29i?=
 =?us-ascii?Q?nQt5VlkhNvOBu6mYEkLmof8OP8CdNMYwk5lc8+WG/tXhR3M251HGEDRvnzKT?=
 =?us-ascii?Q?RkUxHvsIYBW+s9/meRyfftSpAyHpJIvcpEmpDjPfu2l2klgh0BRTbejp+34P?=
 =?us-ascii?Q?BKvbOIGvJti3lJQ/fC7Aaj5xSCiSh8K98yNLUHedm7PUxQa8KXGgrv6zn6C0?=
 =?us-ascii?Q?b4Jq1+120Qb65f+IQzEzHQtw8mZd9swefuzi4QjA5Rlaw7gszdxI3EBFfEvW?=
 =?us-ascii?Q?OrXsP83qdGlQbQupvY1u1EEo2qcDj9R5pMEWsDdQIECrGo82xNp2XTgYTu97?=
 =?us-ascii?Q?1skbIMj4x9EvqDEpMHV0tFw6L49KMUgwddpM7YTQlAVGr+RdGH8AH4aVg6Dc?=
 =?us-ascii?Q?C2KaVK/cqjAec9yhyjz10dlCVgk6P9z17z1/kthz7ohRDKd4X7t63lFmIokW?=
 =?us-ascii?Q?Rt114yJfDXYJMn/HgH39UWJyyGShogDc5FZFka/tBIxNmgy8Zhv1fWlsr1U1?=
 =?us-ascii?Q?ZKSCKhmspyQ0IE/IZpqeXlP42PQxkS8o7IP8NCYBGGqW53z03exWnJRBYC01?=
 =?us-ascii?Q?RzoMe2q9gAntndN3oLw5COriMoZ4dDkRDNdKTRiV6DX6+yKA8QezNVOuNMac?=
 =?us-ascii?Q?tEwBC+3zGv/0IvaTGM2FtI4IeIZRc0Hs3KOzG1M1KvCS2YDfDgKuooDYy4DW?=
 =?us-ascii?Q?Q/Yit4efsZ+qxP9OzYXerEVghsVDP3sCuZ7aHBkH/bx/fdJF+r/nj1r2kEjw?=
 =?us-ascii?Q?+oyhegcYlJs1QIfL86VNlrdxfOfBz2uR0cwH5eD+C0FhooIAuVbwpwbA47RP?=
 =?us-ascii?Q?ip9hF6DmGv8/M+en17Aa1W1nVAq3601Q50FJYqG7ac+R2912dLSs+WV9Ohrr?=
 =?us-ascii?Q?W5ND0AKroiucVYsEdDMiwZ1716Wz29k7XPxtK7DZ71M/IYE/tcFH+hW6TRpL?=
 =?us-ascii?Q?kPsS0EaBF0sbzWIksKc=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(61400799027)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:26:41.3008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a496a6-9b16-4c02-2778-08de0bccf34e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF911AD0615
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDA3MSBTYWx0ZWRfX+7cLJVwo4jRE
 Tr3TUlfLYLCmhfA0N1L3J9oCxR9G8eYRT9uDXV8IdHWma19WBCByoNX+tdRGjYLPuST5Q3uZsSE
 gCBDNGSX4umrbOqZYNTfaZpjJZa9MnA73R8kW9vnZfs/Tjvpi6J6VgWh71+hG2LdC6C0NIqL49D
 2es+B910k6bI1y9g/vDbjgRV+lpedkNEP+BbjMW449fgydeVpiOwljFIPKjphcIEwQgVCjv5X5u
 /wDrEZ0xR7Vd3i3Ib+U9rbbFZk5JFLPH4wWMCXNaPc/K5QBjIVRsFSIaBI/sh9lrIrHl8r0rxFx
 BaMA+bBA2a1vtCxHp6RPS6ajMABN28wT/+02HiNjEdbSRRxC9Ii7WJIfHM2qGtwqORyqagf35Sn
 5Txq7BJvGul9tq0GiTWcM0IQ5l5fWQ==
X-Proofpoint-GUID: Y9cxRf9ORFFhurVChksAH8znbVS_apaq
X-Authority-Analysis: v=2.4 cv=PPICOPqC c=1 sm=1 tr=0 ts=68ef68d5 cx=c_pps
 a=5BiOTAOk3jKv4rDosWfOTQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=_mdxinBoC9VrpwbbToMA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: Y9cxRf9ORFFhurVChksAH8znbVS_apaq
X-Proofpoint-Spam-Reason: safe

The MCLK frequency must be 49.152 MHz (for 48 kHz-related
sample rates) or 45.1584 MHz (for 44.1 kHz-related sample rates).

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c | 9 ++++++---
 sound/soc/codecs/cs530x.h | 6 ++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index cdd050c0fa2b..f0c3ed931fa8 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -1100,9 +1100,12 @@ static int cs530x_set_sysclk(struct snd_soc_component *component, int clk_id,
 
 	switch (source) {
 	case CS530X_SYSCLK_SRC_MCLK:
-		if (freq != 24560000 && freq != 22572000) {
-			dev_err(component->dev, "Invalid MCLK source rate %d\n",
-				freq);
+		switch (freq) {
+		case CS530X_SYSCLK_REF_45_1MHZ:
+		case CS530X_SYSCLK_REF_49_1MHZ:
+			break;
+		default:
+			dev_err(component->dev, "Invalid MCLK source rate %d\n", freq);
 			return -EINVAL;
 		}
 		break;
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index 758d9b1eb39d..c48a29cad702 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -174,6 +174,12 @@
 /* IN_VOL_CTL5 and OUT_VOL_CTL5 */
 #define CS530X_INOUT_VU			BIT(0)
 
+/* MCLK Reference Source Frequency */
+/* 41KHz related */
+#define CS530X_SYSCLK_REF_45_1MHZ	45158400
+/* 48KHz related */
+#define CS530X_SYSCLK_REF_49_1MHZ	49152000
+
 /* System Clock Source */
 #define CS530X_SYSCLK_SRC_MCLK		0
 #define CS530X_SYSCLK_SRC_PLL		1
-- 
2.43.0


