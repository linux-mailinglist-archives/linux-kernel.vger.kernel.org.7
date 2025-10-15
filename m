Return-Path: <linux-kernel+bounces-854175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E082BDDC47
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14856403C66
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA55C31A7E1;
	Wed, 15 Oct 2025 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="LvG/dXnl";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="lWFa+Cen"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C2C30BF4B;
	Wed, 15 Oct 2025 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520429; cv=fail; b=HpNpSro2fUalJHk2iV+yGS8eEaX/YGeg9i3zjcekQBW6vYoXc6x2Jq6DCSgm2ZmkpTVCTpJnOD85J+V5Xumc7wBH8OJxVYonjhjERm7NBfy+boFWPfhwKoPt7vCrlyMT7B4PfnIy6fWkjFBjOuGS6tpyxQVJYqH4ZjqoF+DWPkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520429; c=relaxed/simple;
	bh=NqQAOcGlctMDyQpUis2A2Eomo2hAAKbjo7vpro+5RI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5jbJPwFxMmX1ESENNeqWPPuMW46RmQmHTiNiWqvdbgM0PY3dEjm/bRaHd6UA0ZF8C2JDy2/qr9WM/UcTaiELDLBOahL3qiCFtPXrvtiqp3/iV/dDk3ai5YuQvxjOuid2KdqQHW8qtuxoJUnSj9EFtHxMJZS/xhp1nDJHy9fLqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=LvG/dXnl; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=lWFa+Cen; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59F3oLUN648147;
	Wed, 15 Oct 2025 04:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=gF4RzLnEdb4jvFS3csLDfuUZflsmb3NvmD+lsOoUNnw=; b=
	LvG/dXnleCqIg3xDxchGwchi43VaPKu/EK6IY/+8Q3MheMzsAkt/+3bXV3qBs3Va
	kRetPLBuipxr/XdEUBKSyOvf5/nmwo5o56OcIu/59H7F4dp+d2OK6th4tgWIhy08
	+VNWtpMWXI7VTmHd7zWdDKV1oExPbFzSWvvfuaK+a65CQrH0RzZil8gohwJSnD72
	j3o456nRmU675f6XngNrilYNEzWwmDZXtlp6dFCG+wnO0mGsuEOJG2DYL4nbH4ai
	CKDJEwsPrs9t2Poao/tN3LUks/FG1E15UCQCgpxqT2UXSZJhCMDatJ9heI7i//8A
	6QbwZMCvL/7FP2EvZtLyJw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020074.outbound.protection.outlook.com [52.101.193.74])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49sdb42fme-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 04:26:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbbEhf3Ok1EwOguhlyiDfv0DclTJWe6vIrVLgrp1Qb61+ZRhshj5FxYh0VMN+ljqYeGhJEr7dL4B99xq+6J7pE6V/Dlm1M6Wn1T0V1vxJ703xg7G1mt4ATtyqz3rI83mETNaUNCz4QxtChK/Uk6taPJ7DkA6eRmWkY96Vk/L0TF2L2Pd5PhVIYPO6Xie5yhZfa4xfWA9jHiF6za/D6jnXazNU7P38/gTMCQ2a6QV70TSFxjc9BaPiOtx4HFwC3QK+Rps0kTiQYlA/8dphsLp9uccWGXahoXjLtZNAB/7/QI3vibEI6cuWu0yQihZ5vw9HGurF2ZFzFCIsHuZDbYjzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gF4RzLnEdb4jvFS3csLDfuUZflsmb3NvmD+lsOoUNnw=;
 b=gaejT6R6BA9LCHsVU8BoDjrgwxn5H78oMTPvXY1RNkPWz2obhGIAwcZ7txGCwoXwwZsvAabtNBEQlgGs+KBh+e16fXLgzVjXRESjQvWWdd16ppT3Fzrl3jOz1T2GL3Zpy6gxyxHaH6oLYw6N/bHv+lDvG3vLCB5MtpdwGVr82Ps899Xw5xgxoyl0hx06jfVp73l0TEejQwy4w35PslwZpwG4ZfoazvxOPtoPhI4PwMSc78uGz6eEHv9MknH/S4xehHrB5zK83f4vwZP3WeWOVLqqJKBU/HGmpfW9lmzAHqSliAHPZ5eaMrgZxuSicMs8aQ3g11zZIX2cPZ8Un37jjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gF4RzLnEdb4jvFS3csLDfuUZflsmb3NvmD+lsOoUNnw=;
 b=lWFa+Cendxai+K5rZowYZ2o14UFVk2XJfcuvtgIrHJ/mH+CM7CzrDHRM5frkpV7OrNwDnRk9PdHOVXAA3EO6U4FB/1ITMIuQaSFEvqrnyfH2C4BajDC+Yy2mLO2F/GrWIdT+tnWZ7ge85lSlQTTbqhTm1xd5L/A2/4wDCpMdTR8=
Received: from BYAPR07CA0042.namprd07.prod.outlook.com (2603:10b6:a03:60::19)
 by SA0PR19MB4303.namprd19.prod.outlook.com (2603:10b6:806:89::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 09:26:42 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::a0) by BYAPR07CA0042.outlook.office365.com
 (2603:10b6:a03:60::19) with Microsoft SMTP Server (version=TLS1_3,
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
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 6B78D406556;
	Wed, 15 Oct 2025 09:26:40 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 32365822540;
	Wed, 15 Oct 2025 09:26:40 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH 7/8] ASoC: cs530x: Add SPI bus support for cs530x parts
Date: Wed, 15 Oct 2025 10:26:10 +0100
Message-ID: <20251015092619.52952-8-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|SA0PR19MB4303:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 96dd06e6-f214-4ec9-5843-08de0bccf3a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XU50/yYA1pnD2nSTEU03sQcaxxIs0p5SyXmJ47onmxH6wunrJJZWIUGPQ9ko?=
 =?us-ascii?Q?u6cWf+94kx9XOsVn4nXIYpaBsMFCMp6dsds3iPAFgPEkWWA6gjFmLM0xTyoz?=
 =?us-ascii?Q?f6I94Yik6pcKJi94Vjg4VS0NJwIal1pMwzW9xyOd3VxYmsKo8EFlriN3vD5p?=
 =?us-ascii?Q?g4ckoOvTP3g44UzbOJPz5yBSeGm/YkCmroRcV/MkRMXg9AwTvy+rJKS9XEha?=
 =?us-ascii?Q?f5Q4n3/F3BEbjz4gjtqQn4ivEmsLn5XvId1KVseAnR4C9Rvn1oSqaXMf6N96?=
 =?us-ascii?Q?ILCBQICzbXounh1nmV09KEbrSsZ8Gg3PQg/X6xa8KVOIvgU3rbdfUUYS5AUo?=
 =?us-ascii?Q?3CJpimkHvy9pee+7GM9igfpad5mybB5H7edxARGd/v/7R/WDBkPRuc4+a5XP?=
 =?us-ascii?Q?/yjWyBEVdjGQt+v8xNiNJsuH4qbUiQX2L44nKu6KQu6gRacDFS0zKalqAXGl?=
 =?us-ascii?Q?8x7qemGE9+DmbIHtWfRExpXcu8j6rr+BFgILuZ3N/f+WYqsJtNbZukf/A1B8?=
 =?us-ascii?Q?Sea0bwY8OV/WotXNqIOkknZ8Y+/7LIDl8jqAGZHy+jnykz4jxuZ3rOz+BcK0?=
 =?us-ascii?Q?usWVVmIw5d1r0CPW4pHy428uL+qayefeS/Av47gi/xj0viUR9Br/ycdfugPI?=
 =?us-ascii?Q?aiF2v7W1Mf3VeDu9fLp7wXyj4IIm4KsOJLfufm+ffwV9eydGAvs3MpplqSb+?=
 =?us-ascii?Q?LKmTrOu7RnFP4sOSWTk7ZjWvs/lEDuHrjrdnN45iwVfQhNyHtKvMB80Wh7AT?=
 =?us-ascii?Q?HNp802I3H/NtCnJSj+Es22k1m7JJResLqWteKqlznhHUrPVtpVEktGnUWeJd?=
 =?us-ascii?Q?AJ8CHcnkye3LXtZmwqorbkDONNw9H0Qq+DsWDvwLPgugyz01rSa1VmkAV/7M?=
 =?us-ascii?Q?6/ToZziDyrVork2LtxyEze2Zq/GeKLLppP0rRrlUfvczbKYvSUZ/Zkvl44zY?=
 =?us-ascii?Q?88iUk3r8sBFOd/LcirLzGWWLq5dD2IUr1+6jKEwlr966X7il/uoLNynLhMp4?=
 =?us-ascii?Q?rOOohaAb6byyH+eFn2czumiIuEPCyjCFOXOa9TYjqCtexnp9Y4IcNnzFpTls?=
 =?us-ascii?Q?rIfdvPfMhXiWNWLDy6njii1X1IskvNfzVCdPfcIpKSYiLt3++OwajTDadmS7?=
 =?us-ascii?Q?MkhGzZmulyyVH3Jh6yX7GJkEoC81ZFJSqQ70JHuk6fx4U1oasSDJdfw0gIBR?=
 =?us-ascii?Q?hYTrBTuGqgUf9L5PjTNdKuwOQGdNEHdkor9Umy2llnqAIIH1avssn9LCevMV?=
 =?us-ascii?Q?ECvqMP5cbQieaLCY0QkEGlD0+3ROCY4T0JcIMVkAy77+569ecMl+h5UjaAj/?=
 =?us-ascii?Q?aHhjeB/oVM7XMDlCX9yM3k+xm9OpKExRuls4FPVBY3q4pVLT2iFRpygb0YZ0?=
 =?us-ascii?Q?bd2sLf5UynYljYvZi6wbPRYIxUXP2ybu8BwFL0UMggNqDoFq8Zft0TB+Glvm?=
 =?us-ascii?Q?H+2mY6o4qsQKm3ih9i0xGGg+N3iyxKYSgGTLBTCdTksL5DtdrYC7Nnpu2HDw?=
 =?us-ascii?Q?AHX2ZH8FhZ5thC5pnJnwYC74XE8dKqKVlr1+t0Lh/GJRgOkYI2e8/3Unyk9z?=
 =?us-ascii?Q?aQAZPvUy+tFsr3Q0GPk=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:26:41.8789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96dd06e6-f214-4ec9-5843-08de0bccf3a6
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4303
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDA3MSBTYWx0ZWRfX/3FZJdqV4674
 dRKUvCCQDROkNGrFMoCydUTMZip6wmH6qYSCQp88TMtzntFNgoXEnFZv9RDi4mFpl5CkTjmBZWi
 iqz/GRLN2un/g7vW32AJSC7VFJYUnQt4RcBJsny+a78/LAyQd4G0rUx8nL3Qf/8UAU+9q23y68k
 5crYocMM778gikPXawXiQzHtl+PGA6z+v9rvfU3ZZOdfjM39daot60KY4ZTw+gZIjABRK9iaCag
 FLbKnpFUug0cfGgo10i4hD355k58DqxuXMCJ9mNnrDXT77rW05SE4pzg0xxLi8uLi7gAqvKWj/n
 WglOIgHGd77UnZTlZByU21Zu4s71HlxeTsOyK4mm9hZYB19RQ+eCj9AJO2J2+kH+2XBLUQDvFeP
 FUZhXfnmUZ9NDObZMmk8okKjvLrPXA==
X-Proofpoint-GUID: NsrCjXqvUwTcWudU8IoRRFnPTOO_7Jwy
X-Authority-Analysis: v=2.4 cv=PPICOPqC c=1 sm=1 tr=0 ts=68ef68d7 cx=c_pps
 a=1AroyRkDHmFDIQmzFtfJ8w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=0hqhs4pA57X8KY1vVdsA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: NsrCjXqvUwTcWudU8IoRRFnPTOO_7Jwy
X-Proofpoint-Spam-Reason: safe

cs530x family has 2 control buses I2C and SPI
This patch adds SPI support.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/Kconfig      | 10 ++++
 sound/soc/codecs/Makefile     |  2 +
 sound/soc/codecs/cs530x-spi.c | 92 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs530x.c     | 21 ++++++++
 sound/soc/codecs/cs530x.h     |  1 +
 5 files changed, 126 insertions(+)
 create mode 100644 sound/soc/codecs/cs530x-spi.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 160c07699a8b..ef49f71e8b34 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -106,6 +106,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_CS48L32
 	imply SND_SOC_CS53L30
 	imply SND_SOC_CS530X_I2C
+	imply SND_SOC_CS530X_SPI
 	imply SND_SOC_CX20442
 	imply SND_SOC_CX2072X
 	imply SND_SOC_DA7210
@@ -1082,6 +1083,15 @@ config SND_SOC_CS530X_I2C
 	  Enable support for Cirrus Logic CS530X ADCs
 	  with I2C control.
 
+config SND_SOC_CS530X_SPI
+	tristate "Cirrus Logic CS530x ADCs (SPI)"
+	depends on SPI_MASTER
+	select REGMAP_SPI
+	select SND_SOC_CS530X
+	help
+	  Enable support for Cirrus Logic CS530X ADCs
+	  with SPI control.
+
 config SND_SOC_CX20442
 	tristate
 	depends on TTY
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index bd95a7c911d5..39138d96a720 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -115,6 +115,7 @@ snd-soc-cs48l32-y := cs48l32.o cs48l32-tables.o
 snd-soc-cs53l30-y := cs53l30.o
 snd-soc-cs530x-y := cs530x.o
 snd-soc-cs530x-i2c-y := cs530x-i2c.o
+snd-soc-cs530x-spi-y := cs530x-spi.o
 snd-soc-cx20442-y := cx20442.o
 snd-soc-cx2072x-y := cx2072x.o
 snd-soc-da7210-y := da7210.o
@@ -546,6 +547,7 @@ obj-$(CONFIG_SND_SOC_CS48L32)	+= snd-soc-cs48l32.o
 obj-$(CONFIG_SND_SOC_CS53L30)	+= snd-soc-cs53l30.o
 obj-$(CONFIG_SND_SOC_CS530X)	+= snd-soc-cs530x.o
 obj-$(CONFIG_SND_SOC_CS530X_I2C)	+= snd-soc-cs530x-i2c.o
+obj-$(CONFIG_SND_SOC_CS530X_SPI)	+= snd-soc-cs530x-spi.o
 obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
 obj-$(CONFIG_SND_SOC_CX2072X)	+= snd-soc-cx2072x.o
 obj-$(CONFIG_SND_SOC_DA7210)	+= snd-soc-da7210.o
diff --git a/sound/soc/codecs/cs530x-spi.c b/sound/soc/codecs/cs530x-spi.c
new file mode 100644
index 000000000000..dbf1e7bbec19
--- /dev/null
+++ b/sound/soc/codecs/cs530x-spi.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// CS530x CODEC driver
+//
+// Copyright (C) 2025 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+
+#include "cs530x.h"
+
+static const struct of_device_id cs530x_of_match[] = {
+	{
+		.compatible = "cirrus,cs4282",
+		.data = (void *)CS4282,
+	}, {
+		.compatible = "cirrus,cs4302",
+		.data = (void *)CS4302,
+	}, {
+		.compatible = "cirrus,cs4304",
+		.data = (void *)CS4304,
+	}, {
+		.compatible = "cirrus,cs4308",
+		.data = (void *)CS4308,
+	}, {
+		.compatible = "cirrus,cs5302",
+		.data = (void *)CS5302,
+	}, {
+		.compatible = "cirrus,cs5304",
+		.data = (void *)CS5304,
+	}, {
+		.compatible = "cirrus,cs5304",
+		.data = (void *)CS5308,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, cs530x_of_match);
+
+static const struct spi_device_id cs530x_spi_id[] = {
+	{ "cs4282", CS4282 },
+	{ "cs4302", CS4302 },
+	{ "cs4304", CS4304 },
+	{ "cs4308", CS4308 },
+	{ "cs5302", CS5302 },
+	{ "cs5304", CS5304 },
+	{ "cs5308", CS5308 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, cs530x_spi_id);
+
+static int cs530x_spi_probe(struct spi_device *spi)
+{
+	struct cs530x_priv *cs530x;
+	struct device *dev = &spi->dev;
+	int ret;
+
+	cs530x = devm_kzalloc(dev, sizeof(struct cs530x_priv), GFP_KERNEL);
+	if (cs530x == NULL)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, cs530x);
+
+	cs530x->regmap = devm_regmap_init_spi(spi, &cs530x_regmap_spi);
+	if (IS_ERR(cs530x->regmap)) {
+		ret = PTR_ERR(cs530x->regmap);
+		dev_err(dev, "Failed to allocate register map: %d\n", ret);
+		return ret;
+	}
+
+	cs530x->devtype = (unsigned long)spi_get_device_match_data(spi);
+	cs530x->dev = &spi->dev;
+
+	return cs530x_probe(cs530x);
+}
+
+static struct spi_driver cs530x_spi_driver = {
+	.driver = {
+		.name		= "cs530x",
+		.of_match_table = cs530x_of_match,
+	},
+	.id_table	= cs530x_spi_id,
+	.probe		= cs530x_spi_probe,
+};
+
+module_spi_driver(cs530x_spi_driver);
+
+MODULE_DESCRIPTION("SPI CS530X driver");
+MODULE_IMPORT_NS("SND_SOC_CS530X");
+MODULE_AUTHOR("Vitaly Rodionov <vitalyr@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 027d936c0912..6df1b37fc6c4 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -12,6 +12,7 @@
 #include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/spi/spi.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
@@ -1142,6 +1143,26 @@ const struct regmap_config cs530x_regmap_i2c = {
 };
 EXPORT_SYMBOL_NS_GPL(cs530x_regmap_i2c, "SND_SOC_CS530X");
 
+const struct regmap_config cs530x_regmap_spi = {
+	.reg_bits = 16,
+	.pad_bits = 16,
+	.val_bits = 16,
+
+	.reg_stride = 2,
+
+	.reg_format_endian = REGMAP_ENDIAN_BIG,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+
+	.max_register = CS530X_MAX_REGISTER,
+	.writeable_reg = cs530x_writeable_register,
+	.readable_reg = cs530x_readable_register,
+
+	.cache_type = REGCACHE_MAPLE,
+	.reg_defaults = cs530x_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(cs530x_reg_defaults),
+};
+EXPORT_SYMBOL_NS_GPL(cs530x_regmap_spi, "SND_SOC_CS530X");
+
 static int cs530x_check_device_id(struct cs530x_priv *cs530x)
 {
 	struct device *dev = cs530x->dev;
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index 8675a86d7d95..8af7921b3c3e 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -221,6 +221,7 @@ struct cs530x_priv {
 };
 
 extern const struct regmap_config cs530x_regmap_i2c;
+extern const struct regmap_config cs530x_regmap_spi;
 int cs530x_probe(struct cs530x_priv *cs530x);
 
 #endif
-- 
2.43.0


