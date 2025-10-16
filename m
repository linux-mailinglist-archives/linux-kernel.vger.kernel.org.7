Return-Path: <linux-kernel+bounces-856029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C271FBE2F07
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B800D3B9EAF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D29732D436;
	Thu, 16 Oct 2025 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Kpu+pRE+";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="RaPnyFc1"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF09F324B37;
	Thu, 16 Oct 2025 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611391; cv=fail; b=ZYEzuOfdjSNlVmx96R4Cosl4LuZt/IEeTBEVDCl/W+B0BXwOtl/is+i/yaW+OyV9QVejRttVMoXMMbBaDzFq2k76L/B/g4sTRm85QbeDcg5MAw7a8E9P9eqT54xo8rr7qwz4DPX6E3JR8dQ88UuZff4nGREWbzTI6YD8jIBBLbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611391; c=relaxed/simple;
	bh=FQ7UZlVELcjZgjKQjNasYALWJmgz7+VXSDXphGExO1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnt2Fn2fQOq1ORMa2UF821Xci10aSN0FUtYuYP8aeE0mrTIp13L+NKYjqDOM5TqLQSIfLTyBb/HNmjSGIS+96IPcPneuLDmhZ7mxYf/byJ5abVrsOaIit56mYMIuYrtBBYubcGzKi63nZXb9wzvHAt1Auo/si4sTDuPgIwyIIxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Kpu+pRE+; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=RaPnyFc1; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59G9oCCU648147;
	Thu, 16 Oct 2025 05:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=lthRXyn0c+A5/Sw/F3g3Z1vbY8O5qid4NfzABOcSPjQ=; b=
	Kpu+pRE+B3xo8u1tP3AuO0yPtaociipkHshEDOqyb4iMTiVKfvi7IdDiFO7j8kRQ
	5MXeGimIs0dnT9SRC0g18z2m5lr1RmLIghepBaNcH3Af1c/fUfGatQKTZiq+ukFJ
	QpSUjJwmhTqLS+ipYK4qt4sRmROL3mljUDo26NuANMPKMCwoR019M+DlI6SBgCdV
	TH5RagdLtmkRNOAQTmW2dr0v7pY8FNqPgLdpf5plnLuvrMtdSqbYHcZyhl2gi6xI
	Ct1nrD4QoOCrGasC5/C42Qf4P7WZF4MaE+hpI9KNctcGKRGLMUDE9AtmWJhggfGs
	1TJzwhz88bxT4X3OXWTJIQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022120.outbound.protection.outlook.com [40.107.200.120])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49sdb448a2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 05:42:50 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQ/sD/GhRepmGaigrPoc+ztgG7OFMb3O2/jvc5lqEvU/XEwxime/HoRM6U0PXbxavJENgVUZsJkPFbT0/2BCcJG1Mwztv1PduCwqvulWJxoCQ63n/GHq5ueHnkvTI+0/Z2RLr9kEqOdaHmzV1sSs2UQ6xUmoEN2vATj2kJa1e2cCmQAqazNTww++WFmWke2dlHjC4p4NXg5/XRdaWOd3/z4JXk36yt6Irmleyu7sGrHAnaeLdC4yVne1zD50LD5yYomRDceoZC5xek7mwdbRKzlu0dtqO7pdrnsQRm80BSKC/TR5Bmn6J0K8ho9xIOyDBM0ts3RBN85u2CakE3sFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lthRXyn0c+A5/Sw/F3g3Z1vbY8O5qid4NfzABOcSPjQ=;
 b=o80ofdK4w5sXHLkM8Ri5jTgVl6AfV3EH9C4n9gHK70QXd5XCsO7uLW3U4+lYl/re7N95QrVyplxc+Y/v0EsEpZjx/r+P3ke1V1+s5oNG8nIlkC5/R1SsvuOPx1bp4fYp3aPkzLD5C9o/6MK9Gn9TVavx8UlCW9v/5oILVW2QIHCCCHDdGbmGvFcBCOPIe7y2n98zwHm4BRxwIAJPcuEaY26y2P1iHOyAo5K2DmztaAp2N9ZtFh0DTnUxTmLpnQyJCq+qZZ5yxEmQ7fxCvG59cAlTdM/Z8NpjdunQIzynrDWUxckOwvIHuMLbOGZBMfhUCEoxekTySxj4VvzCxSrl+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lthRXyn0c+A5/Sw/F3g3Z1vbY8O5qid4NfzABOcSPjQ=;
 b=RaPnyFc1BKAUNO4zP1fmJqDhhXKj/TufFMwzn45kamdN8wFZQ6TjF7pf6jlYVrDnGmvPkxUP6w6Bx/t0zgcWwDyD01Dm7wTzFHkVItNK7BjAN9bjHKwSbNa8x9XIUZBO4y2g21lJfPDiZPBFgRT6lE0G9oVYAR9nxXrJG1CbXCM=
Received: from MN0PR02CA0022.namprd02.prod.outlook.com (2603:10b6:208:530::25)
 by DM6PR19MB4247.namprd19.prod.outlook.com (2603:10b6:5:2b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 10:42:44 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::29) by MN0PR02CA0022.outlook.office365.com
 (2603:10b6:208:530::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Thu,
 16 Oct 2025 10:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 10:42:43 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id C2AA240654B;
	Thu, 16 Oct 2025 10:42:42 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 9FB09822540;
	Thu, 16 Oct 2025 10:42:42 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 01/11] ASoC: cs35l56: Read silicon ID during initialization and save it
Date: Thu, 16 Oct 2025 11:42:32 +0100
Message-ID: <20251016104242.157325-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016104242.157325-1-rf@opensource.cirrus.com>
References: <20251016104242.157325-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DM6PR19MB4247:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7d5cc973-1243-4de5-c1c2-08de0ca0bcfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iRR4S8O1bV+N8my+N9q+4uvOHvH+msNUOnntS6VsGbkt8xqV/s3lYoKS3msx?=
 =?us-ascii?Q?PSWxckDcmCI3MixhhMgKjndpPGbBWn/jc06FBCILbdzSJljxbIg/QD2EWbuv?=
 =?us-ascii?Q?W6EHnEwcNLmMN+XAMp1q3mVCJSzZl1+BoBrFdZBVuTn7PtSlTlDc+zlg614D?=
 =?us-ascii?Q?j85tv5ESTNMsrcNJg0zuPx0KzQPtQAd5q+PkSc1cGU86qYc1WxqGuCzwW18+?=
 =?us-ascii?Q?kv8QU5h7sLO9wKYoG9nPTvKYPOJMItHEolQmElmStE6TygNaWVF6MCfS3UVG?=
 =?us-ascii?Q?327ngH5ZHqz3Ft3t0sjmYPDV2Gd6VlpBAfuFqDYJb4s/0Ntub551dHMHCp58?=
 =?us-ascii?Q?Ba7sq7B8wGbnEVLDwcMEntC23iq5LF8WiqH4XCb9HBcHjUQvmI7NOsWhAw7Y?=
 =?us-ascii?Q?fBx8JioeXsBNhYgb08bEqWzOxouaOjDcczpUpO9h78V3wqX8gMSL4t63rYuL?=
 =?us-ascii?Q?J+KIxdXbIcSl5Yb9kGHwWDJBqu4K6tWodVTgVkiPEWi0PkfcWV6uNDX/KjOl?=
 =?us-ascii?Q?zyEjh9iP2vloMlnDjssDfSCRWA07jqUP6KnxFxATLiR7ab9bL8fn6n+vBGYp?=
 =?us-ascii?Q?+fIONfkJJMu13CCafvqETIdC4xiqdWaIGSvxGr6/AwJqPjB/+k+obI0XNjJS?=
 =?us-ascii?Q?S5qKmT3HtpmUtk5Z0pe8ZN86mnuLoZ/hKFwigp3UuBOeQyzMHlCHM9hV9mz1?=
 =?us-ascii?Q?0Qge0dQ80ZXDkop7TQF2gTHmuTskR7ipZlTuLZ9XTVY0NfUAdrvTHCOedI2S?=
 =?us-ascii?Q?Lbw3VXXGm6MIJVsU3tTliuxeFZNNM7H6mDUK+mLKFon4hyXCLUSNtw1XLnRE?=
 =?us-ascii?Q?m1D5MIXVHBnJPHoffwo7s65O67PQFB4ThOM+1LdzGBBC8YvrRgotfG97Brya?=
 =?us-ascii?Q?C5sX9p2I/C4RDsqlvFQkT50W5VWP99eDOoGQFPkiZN4glvDj2bst8SOun9By?=
 =?us-ascii?Q?BOxNywk0gaDS1OwFJ9l+6w3KrBxF2QRWMEghH1t+WghH1p4+NcJxq7Bmv+tM?=
 =?us-ascii?Q?lo9fvPaBDmaHQqjGB6On2y78VsLORVI/g1xlKK+oFQZOs3GnIfmcSVzL8EcD?=
 =?us-ascii?Q?jbHaA56YAgnykJO0DyPP1QeeaM9V8JWmVho/EUj3FUTBpXiWvqV+sGl14hRi?=
 =?us-ascii?Q?egq6//blm0TPJhgBadCOh/AnnD1saghqb91w/uLlchnF5UPuzE1yjQ/hCL0p?=
 =?us-ascii?Q?53DWrRhDxyjpEbP8d/Wx5WZ7pNf3uReJG+dDYksKp5tFsslPV4qZ3EGPlRm/?=
 =?us-ascii?Q?/d8gxoKlrDpzflmEf52PXJLzLKpts1PDpdORJASxi7A3hzyPdvK2xbQX3JEc?=
 =?us-ascii?Q?JqieoSoRyqdiFK5YWt4dXno6hKHp6mZxyu5M7z++Cpwv/Ulbuc/w8sM45lvr?=
 =?us-ascii?Q?d1BNzRH7szSWqZkjg6q0yID+aoPOVFk06R0tgzPKCLgLlbcAiACMI9ojoRM6?=
 =?us-ascii?Q?QLdJp7edEqQ9mmBcaJHj447CxQKnwM35LCYommyucNSu0F8tg4UeJ/gsHuRq?=
 =?us-ascii?Q?QDEOycg/EnHwmAutlnNrbYbLL0038QxI0iVUY3Kp1apMJ6ehYB+PZ5CTtFTD?=
 =?us-ascii?Q?Y3LuzgzyFe6ZpabXb6w=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:42:43.6028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5cc973-1243-4de5-c1c2-08de0ca0bcfb
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4247
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA4MCBTYWx0ZWRfX4UvyZAGHCATy
 zuMWKd/YwCfIHfRHAH07l7qY3pP008xef03iNajWtKnDDP2izDW3/G6YD/T4kXzUoetNuMjqZL6
 vWIUyLlLzkNxVEhN4fiZ4wnUP9Hg53qiBc7LrMesagkkc36iRLpKpfFLLt6CQMeGuUxTLnmYwbc
 VLlnqhtXeQBuAvyP8hBmD17BBI1sP1sltdsBGYqOMONY1Bive6ZpvJd64GlQwECm1MkHGIMAwed
 ivHPptGHR5oM5N57bjxlOaoZAcBWULPAYtdbtKtvj4cKalOmwukYD+3FellABxbnAQSOV0sij/t
 sjnFMuGrdV0d0wOKR5HUBbR6T1dnaFT3VhGyzs432iKU1II/W37LjDVJzOnw27ySxHsP8Perf8v
 1nFojBfuE7Dk2hfAsSJcNNnAYfqgBA==
X-Proofpoint-GUID: oueNDLSMmUm0xDn4Bup1w-zF-dLKVmEz
X-Authority-Analysis: v=2.4 cv=PPICOPqC c=1 sm=1 tr=0 ts=68f0cc2a cx=c_pps
 a=3SCk7X9PwWHtu4c5+rqWlQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=nj95HRKCm9CT-uqgyqgA:9
X-Proofpoint-ORIG-GUID: oueNDLSMmUm0xDn4Bup1w-zF-dLKVmEz
X-Proofpoint-Spam-Reason: safe

Read the silicon ID from the amp during one-time cs35l56_hw_init()
and store it in struct cs35l56_base, instead of reading it from
registers every time it is needed.

Note that marking it non-volatile without a default in regmap isn't
a suitable alternative because this causes regcache_sync() to always
write the cached value out to the registers. This could trigger a bus
fault interrupt inside the amp, which we want to avoid.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h           |  1 +
 sound/soc/codecs/cs35l56-shared.c | 53 +++++++++++++++----------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index ab044ce2aa8b..ec9b1072d6be 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -309,6 +309,7 @@ struct cs35l56_base {
 	struct cs35l56_spi_payload *spi_payload_buf;
 	const struct cs35l56_fw_reg *fw_reg;
 	const struct cirrus_amp_cal_controls *calibration_controls;
+	u64 silicon_uid;
 };
 
 static inline bool cs35l56_is_otp_register(unsigned int reg)
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 9e6b9ca2f354..1ecfc38d8eb4 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -853,7 +853,7 @@ struct cs35l56_pte {
 } __packed;
 static_assert((sizeof(struct cs35l56_pte) % sizeof(u32)) == 0);
 
-static int cs35l56_read_silicon_uid(struct cs35l56_base *cs35l56_base, u64 *uid)
+static int cs35l56_read_silicon_uid(struct cs35l56_base *cs35l56_base)
 {
 	struct cs35l56_pte pte;
 	u64 unique_id;
@@ -870,14 +870,15 @@ static int cs35l56_read_silicon_uid(struct cs35l56_base *cs35l56_base, u64 *uid)
 	unique_id |= (u32)pte.x | ((u32)pte.y << 8) | ((u32)pte.wafer_id << 16) |
 		     ((u32)pte.dvs << 24);
 
-	*uid = unique_id;
+	cs35l56_base->silicon_uid = unique_id;
 
 	return 0;
 }
 
-static int cs35l63_read_silicon_uid(struct cs35l56_base *cs35l56_base, u64 *uid)
+static int cs35l63_read_silicon_uid(struct cs35l56_base *cs35l56_base)
 {
 	u32 tmp[2];
+	u64 unique_id;
 	int ret;
 
 	ret = regmap_bulk_read(cs35l56_base->regmap, CS35L56_DIE_STS1, tmp, ARRAY_SIZE(tmp));
@@ -886,9 +887,11 @@ static int cs35l63_read_silicon_uid(struct cs35l56_base *cs35l56_base, u64 *uid)
 		return ret;
 	}
 
-	*uid = tmp[1];
-	*uid <<= 32;
-	*uid |= tmp[0];
+	unique_id = tmp[1];
+	unique_id <<= 32;
+	unique_id |= tmp[0];
+
+	cs35l56_base->silicon_uid = unique_id;
 
 	return 0;
 }
@@ -915,33 +918,14 @@ static const struct cirrus_amp_cal_controls cs35l63_calibration_controls = {
 
 int cs35l56_get_calibration(struct cs35l56_base *cs35l56_base)
 {
-	u64 silicon_uid = 0;
 	int ret;
 
 	/* Driver can't apply calibration to a secured part, so skip */
 	if (cs35l56_base->secured)
 		return 0;
 
-	switch (cs35l56_base->type) {
-	case 0x54:
-	case 0x56:
-	case 0x57:
-		ret = cs35l56_read_silicon_uid(cs35l56_base, &silicon_uid);
-		break;
-	case 0x63:
-		ret = cs35l63_read_silicon_uid(cs35l56_base, &silicon_uid);
-		break;
-	default:
-		ret = -ENODEV;
-		break;
-	}
-
-	if (ret < 0)
-		return ret;
-
-	dev_dbg(cs35l56_base->dev, "UniqueID = %#llx\n", silicon_uid);
-
-	ret = cs_amp_get_efi_calibration_data(cs35l56_base->dev, silicon_uid,
+	ret = cs_amp_get_efi_calibration_data(cs35l56_base->dev,
+					      cs35l56_base->silicon_uid,
 					      cs35l56_base->cal_index,
 					      &cs35l56_base->cal_data);
 
@@ -1111,6 +1095,21 @@ int cs35l56_hw_init(struct cs35l56_base *cs35l56_base)
 			   CS35L56_TEMP_ERR_EINT1_MASK,
 			   0);
 
+	switch (cs35l56_base->type) {
+	case 0x54:
+	case 0x56:
+	case 0x57:
+		ret = cs35l56_read_silicon_uid(cs35l56_base);
+		break;
+	default:
+		ret = cs35l63_read_silicon_uid(cs35l56_base);
+		break;
+	}
+	if (ret)
+		return ret;
+
+	dev_dbg(cs35l56_base->dev, "SiliconID = %#llx\n", cs35l56_base->silicon_uid);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_hw_init, "SND_SOC_CS35L56_SHARED");
-- 
2.47.3


