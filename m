Return-Path: <linux-kernel+bounces-858413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534DBBEA9CB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C371A677CE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE0E2E5B0E;
	Fri, 17 Oct 2025 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="SPXTX1LD";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="nhHhSISg"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76332DA743;
	Fri, 17 Oct 2025 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717791; cv=fail; b=VpCclCnpiWFZrALXJdlzukqrl4tIX95d+Z183TximkbFrCzZr8Ex4J3hAGsBVpOl4kcsi+vx2wFlIT0JQ+clttk0jUESo/DbPh+VLfjWvx4IREQbFj9Va6uXkRgdYZbKgjbYHMy1182DEt13xqonY87ejWpeyS/OvUxF78V4lLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717791; c=relaxed/simple;
	bh=QfzAbrZ7QP7zm+iYfmvYX+uXRJkeIsEL0rpxVlVTVW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SK7pRfdpIvlQkeANuEQvr9bbCRzKUKhZhKL4ibbcLxMqL1jncRMBVAF0wQiT97jtdiuSIz1ZOVctDpUITruXE7WAN6P7rc1iRNK+YTSuZV1+AFsDQyfhbeLZ0ZVw09tPbrLXI/a5Fs1Cn3MSUDwgKTs7VldwTUVcPS1RJAA6/TQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=SPXTX1LD; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=nhHhSISg; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59H7kLPe4017610;
	Fri, 17 Oct 2025 11:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=efLGpdUsijDroiFjFKocPw+52LoKKBoglMzHJWAmAaU=; b=
	SPXTX1LDJ2oPZEo5QMBHqcbhVLb/J1RtnHPsXKgkdgKESV7UYxP9MWhsUufpYs3f
	DG/z7F5KjA3k/UZ3brNMLSdY0AWI1z7M3AdRlBflfl/wo2r8SPbi/cCAjEpJbIsF
	znXt7YbrVnvSdBAzTR10CCKuem9LTm11o43BbvqrfCfFCG/EWzTh2sZNf8E867B+
	tfz1lYlZiX3rgIug8Fmk9LCzox6+4yyHwAd0F1xbmM0zxp/MKk3G0/T4Bjem7zR4
	v0jZCytpvqPhDCdlTnwB/ALRav0J6F9m4EQUNG56ODWyiLdafGD2J+xqe3WueGi9
	osMQGomhG7rymZ7ahhy7Ug==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020109.outbound.protection.outlook.com [52.101.56.109])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mnhsbn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 11:16:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoO3Uga3gOkfc2oIUCGwa6/Dd2Vc8atrPvkxOu97CEJJ0jaftcOy4GoNhACoLay1RRlSYpnrSH2MLfyu1WAkDWZkLhpDOtoCPRDiOCMuPduZ6GORNDgBseNNIbV9VCgcJeMUueIj+zzMddLPbbk4ZlB3tjzEUuZLTswSx7WiKQ7gQVTehb0OxXTXt1q9vVtBVcGEc6OgClMKFdHiY+z0ueTzBhgGI/70kiVTFA+dc8CDr/KKUMjGsK1l1xqenzRdd98LictjAPYDsf+JhVPqnk3kNsWc2eNEmfekjquUvC/4ouOc+MMCXT3f3OpWWnxZW414BuyQzvy3IrK1Ogotyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efLGpdUsijDroiFjFKocPw+52LoKKBoglMzHJWAmAaU=;
 b=lRpcsu/u+6yNijhatA7v+y45GA/flgq7keUD8O32h0kTFJ7wAIiW/OA2HldBiIWFBVL5XohqP3aTcqNnLHWruELrVV6ej0OQYbw8GJ7XbLL1ZCFvUjAlTF+nReSBNnihoPhnBMaieDP4lJHipI0gGPk2/xpmRQwHEUYd99wMxwNWl8oEe9HjdRUxWxJ0wYphK3JNLlFukfJ4WEecmx1KJzkJPFPz3dj1oe4x5IWxAP7yXFy6ubGq9S2WB++K18dg6NSoa/KTYm3gThVNy0edjBD+xzYpk38wU9tHRMJ1XMTc1aXh9Uf0KLFA+kvzppeEW2+3iuYDAiRYLfSaN9qeNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efLGpdUsijDroiFjFKocPw+52LoKKBoglMzHJWAmAaU=;
 b=nhHhSISgx9rl2Gy1GXNXqr2fvmvTgBSH9inBgu1+KY2PjrclW1sTstVOyqZjQuABhJlYAPq1dGKR9ScZXLUtPraPfJkzHwNzxDfIzQ4uPk380wOjbpC32375laSNSns+YJuD3gSsy+gGXXwooeFL1KtiFQS3D5OzV3uPKh0qd4g=
Received: from CH5P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::23)
 by BL1PR19MB6034.namprd19.prod.outlook.com (2603:10b6:208:39d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 16:15:56 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::7) by CH5P222CA0016.outlook.office365.com
 (2603:10b6:610:1ee::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 16:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 16:15:55 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 56B78406552;
	Fri, 17 Oct 2025 16:15:54 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id F3BD4820249;
	Fri, 17 Oct 2025 16:15:53 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v4 02/11] ASoC: cs530x: Update the copyright headers
Date: Fri, 17 Oct 2025 17:15:29 +0100
Message-ID: <20251017161543.214235-3-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017161543.214235-1-vitalyr@opensource.cirrus.com>
References: <20251017161543.214235-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|BL1PR19MB6034:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 471dd2a6-24c1-44dc-0246-08de0d98739f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CzSapLiCtykN2p1YjE5kH4dtnIPs+T+D/cb347/7QXRwL6IlrSMmQ6Z8xXcK?=
 =?us-ascii?Q?B4fi0wAiTfLiAZ/VJXFDgAqBbE2aeB4/ggmV078OOVbCkEWlw5Ns4JB1vurZ?=
 =?us-ascii?Q?extrT7yhC1eCo6pieqDIr72zzKUHyolGnjGne0Fa+1bomEF1rO1qA+X62ec4?=
 =?us-ascii?Q?38IqNPZeV0pRUCjLPGtZt7FMGdZ8O2TYh37o+brTf6pJBX07Cbpy7TvwCZBS?=
 =?us-ascii?Q?5Rkz3w/u0aZ54SKO2X7H/7hEwgl8QFlY4Vh7+MN+QD9pmsMZ7h+egle12PIS?=
 =?us-ascii?Q?g5jh1mF4EqtB0pExgor9046HxnOnjg8Fl7D/k/DGTIXCmfLMuoyhp0Nw2C3j?=
 =?us-ascii?Q?kWJVE1oflbk079d603KiRX50y4wUFcFjuofLDk5n1IV3n3g3kV0x0+cpwzdE?=
 =?us-ascii?Q?ClwUWYzbW2HFMtdP//nkwteKW4w23sDMmYkh5+dOhhfyqddx6mkZ+3XJ2GE4?=
 =?us-ascii?Q?+xJx1migfcNJBpcUk8bvnbb+fbkd2AWLbsVt/QhtmHQnrjOi4M5GreZvFXkq?=
 =?us-ascii?Q?sMi7y6LlqnCQ97r1VdPkJiYvrJiGdzLyZWE2x2iXqm6M3gF7bMdDA++pq9Lf?=
 =?us-ascii?Q?XF68xcisrqy6m4tU1wIiHu8ISZRP8REDFCbmzLz6KwAAK7BdGS4ZxVrTCmeK?=
 =?us-ascii?Q?vPQA69dMi4D+AGP2vJZMkiLW51Bt9IdKGfwdNcudspDC06LNsMYYsgqlG13u?=
 =?us-ascii?Q?9VdNc0g/ipwLdIzczuzlYwqgB1MCEQDN73ln7JH/MOaTj9T7R7lTO0YYsLWa?=
 =?us-ascii?Q?gaXFkeTf4sWO3qD8sr7919SCXS/nlWZBCnnDDmSFchC1ZQj9VIjD2gS42e7f?=
 =?us-ascii?Q?LyDBW8sMYiDqDIlOOoPVqG6jbZdSsKNdGtrh6a8hy/pA1hmffAj3z2ETE5XW?=
 =?us-ascii?Q?CZR4KGphvMcHh+MFDlN22OIQbLlx468Bg9fnxR0Qrb95eA6DRfPBxzSPCWRd?=
 =?us-ascii?Q?zLlKyfrKjnbHcFnuRuVMmxMYSfl2ZFJuMolvXl2jdkN0EqclsIbRVBN8bxmz?=
 =?us-ascii?Q?D4a/7t2OyrmXG8BapJEvQ/6j3g40SQduqzQQBOADCLG/CiZzhaI/t0LfVnlR?=
 =?us-ascii?Q?EcsQOhijQ3OQr7adpbS0csayakoZDHnq25Pu2dd+98JKEekT9nc7ByWshWIH?=
 =?us-ascii?Q?4hJYKYPVHywPqG+aXLP76rlyAwyRvEeggj60zEJ6veYcUCBo3hw5FTT9FzRb?=
 =?us-ascii?Q?yvMpYDpB2nKrVsJ3PG6Fzy0ahzk/gmofcD9Sj62H8+SiH6+ZASUnb7jVvkFy?=
 =?us-ascii?Q?M6Gk4670+1PkRjiLip5eNg5SxI1L3Tyr2A8wbKpMi6U88WM+7gheFwrGNdiu?=
 =?us-ascii?Q?o/KJ+1K9YYayrsY1XtK2Nz3+wUooTs3mmkvYWZ43Ec5zCEpx2zINbYDt6L0l?=
 =?us-ascii?Q?Qo5j8WTft9UFWw/m6kbg4Brdx1rT1fERM3j7aQZQG//j196PRPrz6S5C6+38?=
 =?us-ascii?Q?ZWeX1nKFEdKURjYFkQ/cix8o6LwXryenYXCdiiVnf+LXWC/gx9RhMAwBz7L8?=
 =?us-ascii?Q?GMZmZPneyj2ZrFeY1iqJq+KPPgUHoAG76VV5PCIzTcNXo/rOMtxmqkIURxvm?=
 =?us-ascii?Q?yrDXa+zDERHJjh6ZG+o=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:15:55.6491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 471dd2a6-24c1-44dc-0246-08de0d98739f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR19MB6034
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f26bc4 cx=c_pps
 a=hjBpXxoQfMlz7yq7ll+NbQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=w1d2syhTAAAA:8 a=SQtk40xCRQeN874b5x4A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: R-Uli-kpW7C5Sqyj2XENR78TzuW0iu98
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDEyMCBTYWx0ZWRfX8XE44Vwf58qw
 g/ENC2CF09IWxNcV/pdNtWFKSlT1vijnGv6E/I8HJRhS6ldBr8SDDJ2N5BvfDGvHC+tg5GJqpEK
 Gxel7VzRqKnWNL6GAiZeMNzbbCuTgGmeAnKciakJVO72EmUmqOqk7Kwtt3tmd/6dzzFtu+agsx/
 D2fhig4cZx+QKXnwGLxsz5yMC3Sa9SjsOPFPTcUERfFzF4eC1RJCvOxpbBpOd/5bExtEJWlTvMl
 fjNgs/DyHKHeUV26mkUuJKfAR6eLYnokHEHdUWRbkrbgROKIjyJEU30mKxZhbvok8BKnU+/sAFP
 u3wH9c7SOOyblXaa/c/pDBVLpE+Uz6UJQuiC6kB+ljN0NP6kjvDGTeQPrPq2zApJPOsF2HxiqSV
 +zEfn6vjOBg3HPFcidkve7UOrf2obw==
X-Proofpoint-GUID: R-Uli-kpW7C5Sqyj2XENR78TzuW0iu98
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x-i2c.c | 4 ++--
 sound/soc/codecs/cs530x.c     | 4 ++--
 sound/soc/codecs/cs530x.h     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs530x-i2c.c b/sound/soc/codecs/cs530x-i2c.c
index 22b1a4d6b61c..be80dcad3647 100644
--- a/sound/soc/codecs/cs530x-i2c.c
+++ b/sound/soc/codecs/cs530x-i2c.c
@@ -2,8 +2,8 @@
 //
 // CS530x CODEC driver
 //
-// Copyright (C) 2024 Cirrus Logic, Inc. and
-//                    Cirrus Logic International Semiconductor Ltd.
+// Copyright (C) 2024-2025 Cirrus Logic, Inc. and
+//                         Cirrus Logic International Semiconductor Ltd.
 
 #include <linux/device.h>
 #include <linux/module.h>
diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 535387cd7aa3..d016e8298a69 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -2,8 +2,8 @@
 //
 // CS530x CODEC driver
 //
-// Copyright (C) 2024 Cirrus Logic, Inc. and
-//                    Cirrus Logic International Semiconductor Ltd.
+// Copyright (C) 2024-2025 Cirrus Logic, Inc. and
+//                         Cirrus Logic International Semiconductor Ltd.
 
 #include <sound/core.h>
 #include <linux/delay.h>
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index f473e33eb835..b325847036e9 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -2,7 +2,7 @@
 /*
  * CS530x CODEC driver internal data
  *
- * Copyright (C) 2023-2024 Cirrus Logic, Inc. and
+ * Copyright (C) 2023-2025 Cirrus Logic, Inc. and
  *                         Cirrus Logic International Semiconductor Ltd.
  */
 
-- 
2.43.0


