Return-Path: <linux-kernel+bounces-858411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D791FBEAB56
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 825FB5A4E84
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74A52E06D2;
	Fri, 17 Oct 2025 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="AMP2XfjW";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="fYh8qO06"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE1A2D9ECE;
	Fri, 17 Oct 2025 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717789; cv=fail; b=Omtn171lKOWR47pwh53W4zlLCyvXST27htxGuLRG/DBTd50+zK3V+B6aO5BX1thRHTFRiPF+0ubqGYqP8FJjxsKBW+x/GCWY14LqkEx7YouLcC0ILCjOgBAyKbclQwMw0/E2kLSW3gmUla9Ho0eG80DIko+YNgoI7XI629InmdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717789; c=relaxed/simple;
	bh=HS2Uo9naVxxtKpYwUc0L+cG+1ST1OUNnCxXY31GY65w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGiAiz8TBNNsopOrwaz9o8LcQ9CgPG/Pz/Yy14F9+o245vCiPTGQ3rEeFCPFSNxUGVNrpNFkSlsmMwmqcEyhvxW+TeB1TxftRsyF9pnfj3/gJ6rFDEXitqx/ro4Y111FCSirtqZGB0bKHD6a2xtVIsytbrn1wAjr5gYzYKQTuKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=AMP2XfjW; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=fYh8qO06; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59H4oTaJ1356329;
	Fri, 17 Oct 2025 11:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=P4z/GWhVAMtRz5fD3jQi3LjVqI6tJLg75b+A4g0PhRQ=; b=
	AMP2XfjWJg043r6GnXPNuS0u2+GXHlyu3U/2Qbr3UfarFBcpczW+cQghWSyoMBDW
	fqkh5pCfLWXhIx1v7b6Fpnj73VMmDH6iU/uvbkVOnME+K5wIzPcHa/BTntB7KBLQ
	qnHZDQcH3y4STyV8NNLnS51ZXJlhyO2l7m7l3ojU1ll98pXTeR7zDYW9y/pSMitC
	WIXzvWAxPK4U/+YrVtfQgV5rv8Ywi24K32XEJAUVHfs+j4keWXOAL0t7oCLOkl8n
	+Tl2B36sZDkCbElJryaSyKrbuBu35fNwoPH0sGPIm4H/241K4DnK/6/JHWJ3t3i0
	5eSFBg/eyy2ntUTS+GwoKg==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021090.outbound.protection.outlook.com [40.107.208.90])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mnhsbd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 11:16:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcPuVadBvGhZLp18M3ZgaHDkSmn4n/TdRxUKTiFRT33f5SliGoIX31YcNiun/LcncV5lAwxR87gSrBVHlxp2emcfC3PKWtlzYtHXVPEGKPgSE7rYeXAZOlPSpm/tbl3gBj8wVK5pg/kv5IMKTgz+n/lzz6msnspUslgQvzDc6xvEJR5jyqVmQ7QVteGHeBjiv7T/0KR06l07ljq6olu725n2vAJMk/bRhXyZuxV2AuNM1G2/Kv0CC0/Pgz4R16bO7jFN+A9kA42rhbq4yVbLsDzjLIPxuNGg7aQZgweVqL2WmAJnnNuVTaeDiWZPQ34j11rYiIuJwjXFMmFGd8M+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4z/GWhVAMtRz5fD3jQi3LjVqI6tJLg75b+A4g0PhRQ=;
 b=NeiQNnkzMLR8of7/2bp1PfOiIZpOXkX8Ad5Lc89trlit8Y1Zpcg3KdORb+A8EMcVAlFbRrbsiBOzvfg+zARCW6yh9OZ/nDog1lQYNxdIsUEAfdksn2QPWNKsEF1zdm+jbCPXzjd3Aso6DseRzX8q2svvFDHloK/G/AG9xjnj84GcHPMjgwj5sq/Nji/bC3SJtaj1Ul/lDrAJiAT8Q7eljDN/W8IQuTRJxgULbrlKLQULBPARLvxdaPMl/fIpW9aQ8M6HLwNCIWOy5UM0Wh8a8U16fbDaNKqX94rpCu8DMqcAR12/NllP7oNIyi0Dfx/miFuBe+9EtrtSI2Xx/VV4DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4z/GWhVAMtRz5fD3jQi3LjVqI6tJLg75b+A4g0PhRQ=;
 b=fYh8qO06O2h63ZgOCd1Y2qVASkobHMhm5kO/O9T4sByVRl87+DALxYJ5lx5kB4atEvK+Xb0qSkSiA4WUw0T+ysWB4JyoeLFZ3glviU+yfuK46tyQpNhuhuFwiKua/gT4BzTCIRvwhyLRLBJS/w1XAEAKHt1HRNFCLaJ/fHXy/iQ=
Received: from SA9PR13CA0093.namprd13.prod.outlook.com (2603:10b6:806:24::8)
 by MW4PR19MB6823.namprd19.prod.outlook.com (2603:10b6:303:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 16:15:58 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:806:24:cafe::12) by SA9PR13CA0093.outlook.office365.com
 (2603:10b6:806:24::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7 via Frontend Transport; Fri,
 17 Oct 2025 16:15:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 16:15:57 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 801F6406559;
	Fri, 17 Oct 2025 16:15:55 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 27E88822541;
	Fri, 17 Oct 2025 16:15:55 +0000 (UTC)
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
Subject: [PATCH v4 05/11] ASoC: cs530x: Correct constant naming
Date: Fri, 17 Oct 2025 17:15:32 +0100
Message-ID: <20251017161543.214235-6-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|MW4PR19MB6823:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d9e649f9-70a4-49df-8f4b-08de0d987486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n8G8Z+f/P5ftJzynnoZ9rx8xV98Df1oMh/T3ngF5yUYGlLK73G/5M0rEYZe4?=
 =?us-ascii?Q?kb3pGfc8985Q9z0Dl7dkX9G/FlNm1JnHebxb3PqlGTTYEa0GZZc3qYU1sGsh?=
 =?us-ascii?Q?VsLAlnTlDTIBfL29Jk8OoCK433jEPF/bkvpKNfKZxl5oB5dAX5+sPxRvMhOP?=
 =?us-ascii?Q?oSlwRHEP8Qi8wviLkBrsIN2nCzIBQDT4jyfCEl92miDv3ryU7hQuLqk6KVfy?=
 =?us-ascii?Q?aHbCKr0qst6PXxOcmVW8spt7IcXkcuJUb0bloLU2XVlR09yYvfn6SYMXaMC9?=
 =?us-ascii?Q?X8Jb2Q3xyPxBIxB78CX2ozv050Buzx0HIUrifkuqI3bL3+TK5oLjwvEN3jhm?=
 =?us-ascii?Q?rgbiJXbyUUY9+x/H+PzyB7B6uFRvDGkCEVzBXIosIf36Suc8mQ7QOYSlUNew?=
 =?us-ascii?Q?6H3ZrWfPwNMTZt2frwpFDRslTt4rXvW5/+18W6C6bTCTOZ03Nys2PDrWyvjx?=
 =?us-ascii?Q?TpsTT5UMGK5lYd/eet/6ECGXMR/Ydgp+rE+7k1zLP5261I5DYcz/s2EUsHyO?=
 =?us-ascii?Q?QpEz1kXhbb92ojUrziIUH6nBqLQAlYEkDeCg0nHwLCVh59lhsqOVyvxA61JO?=
 =?us-ascii?Q?ZSN3SheENR8hWrze4VT0y7UCcvy0IJqKYGYSVTm11k//xx6LIL6KS9c/lqVO?=
 =?us-ascii?Q?w4WgY37qLXhRzugWYdL5oQPqUKvI0mBbjcXCYFCCZ4moDHAoMi7JK3dh0KXd?=
 =?us-ascii?Q?PPdq2d9/rZtcOxOZujIEUrB7j+aD0X0xFvKqsNR3kGJC0LjNV4/ASw5fs8mH?=
 =?us-ascii?Q?HKPx3kwsGMU+AMBO0w3u5hcd0mNKMYH3zlO8fNkCXCQIB2302Y71oMnVS0i4?=
 =?us-ascii?Q?Zc5LL+s+ynrYR7MnmcokmzKtLLQ9VuglhRk2h3Tq4FVwGNYR5GmDIVX7hwO8?=
 =?us-ascii?Q?ZZHT7o73tajkfJWN5YpsA6u/qvRaHhLfbZmY8XHRJENZ3pXMQDgebm0zyRqI?=
 =?us-ascii?Q?geVWMBVc4Fc7TIkpodj19K6vWuWHV5iyP9LxVYanMTu0YigFMS+/hKQ9aWZM?=
 =?us-ascii?Q?cdJF+UupYKJm20TnHhBet7Qy1GjWXIQK1O8/2FbzpMjFGgmkM2KZDDei+DTQ?=
 =?us-ascii?Q?smJ0Ep8YYvRXkDuRWhOQsH4P0fLe9gbIUhzLY7Oa23xukLfghTPAFU326MxJ?=
 =?us-ascii?Q?ESOy8ZOY65sQMxnJuFIXXKiY1tyVVV9BF4ywRXd/pjDLya8eHlYxWBNRZhWJ?=
 =?us-ascii?Q?kC7YOchqYf6OM/P82aJVNUG/40lhMjvNNDInMZZuDbWqKHHaMfKNGIizlAh1?=
 =?us-ascii?Q?FHtjQLLKzr7V5FlTA9aL52faDqVxi5Xplh88XRVlyoDUeYqD1tYf6rS+OwOl?=
 =?us-ascii?Q?B3MidpBlxj6Tz0vvAElj2p0OgK9aUD8eAoYZY128dYSUQlqM6xulb15T01Xu?=
 =?us-ascii?Q?m00e7z69kwVnFoQCslgQwqFCl2UuxT9gBXpvTxH9We1RExRoFSJH4wlCsaKd?=
 =?us-ascii?Q?L9cURgvzqis0ZV+3OkqIGMT9SSEnFyLCauZql97YfixMQddnYah6ZcvsoLeV?=
 =?us-ascii?Q?zEg5eFuyYvqf2mqDniGv96WZZrOZQOzoCrsr9dGsD8Yoyi9WwpvRxVoWgTBe?=
 =?us-ascii?Q?jvm3dtbQxjeFMYprmxA=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:15:57.1612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e649f9-70a4-49df-8f4b-08de0d987486
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB6823
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f26bc0 cx=c_pps
 a=AOb1yOGEV8Ho27kyBPrkwg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=zWlGrJBK1FuhkNR3vBAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: B5s11lf84XZRzLJ81y0Dg2nvKB4vACSQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDEyMCBTYWx0ZWRfX5jQwysIm7u4+
 PBnxWtVC0wFEkbBOiUsT4Bly8HqE3X03AUDTnCOS6bNaV+mDkcjc1X+nCfv6h0u5/EmFaU0PL34
 0KCpzTl6BcSdzNhaMH8TqAQUW68UbdWQ6uMRV7NjVwAnM/FLTw3nrX8vXH4yvusl6+SgISKW2ie
 p6tWPeWtCGH7kjasOpDalAvBKgxw2E1uePAgKHL6qvJiNO9U9TwWswQjIidpYsSYD0I0LYrqR3V
 vWFGJca9aP3C64DUyIom/ZN7aDwhg9MNHirt4b/U3xh5UdBWYld/Lqmb5JLdVvtcsRyECLBBZDK
 tLV88ZDffSTnoSIJX1N26LcmFvlCXiTW9cBQrhYwtQMmRKzBOvaEqUN18jwTWCIYMG7npP0V2sH
 dJH4SsKIy4RYlecy29Df7OM76MYXNw==
X-Proofpoint-GUID: B5s11lf84XZRzLJ81y0Dg2nvKB4vACSQ
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c | 10 +++++-----
 sound/soc/codecs/cs530x.h | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 4add46ef93cb..336ed5f225ea 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -491,23 +491,23 @@ static int cs530x_hw_params(struct snd_pcm_substream *substream,
 		break;
 	case 44100:
 	case 48000:
-		fs_val = CS530X_FS_48K_44P1K;
+		fs_val = CS530X_FS_44P1K_48K;
 		break;
 	case 88200:
 	case 96000:
-		fs_val = CS530X_FS_96K_88P2K;
+		fs_val = CS530X_FS_88P2K_96K;
 		break;
 	case 176400:
 	case 192000:
-		fs_val = CS530X_FS_192K_176P4K;
+		fs_val = CS530X_FS_176P4K_192K;
 		break;
 	case 356800:
 	case 384000:
-		fs_val = CS530X_FS_384K_356P8K;
+		fs_val = CS530X_FS_356P8K_384K;
 		break;
 	case 705600:
 	case 768000:
-		fs_val = CS530X_FS_768K_705P6K;
+		fs_val = CS530X_FS_705P6K_768K;
 		break;
 	default:
 		dev_err(component->dev, "Invalid sample rate %d\n", fs);
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index 165adb88f4a4..cdd54bfa259f 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -69,11 +69,11 @@
 /* CLK_CFG_1 */
 #define CS530X_SAMPLE_RATE_MASK		GENMASK(2, 0)
 #define CS530X_FS_32K			0
-#define CS530X_FS_48K_44P1K		1
-#define CS530X_FS_96K_88P2K		2
-#define CS530X_FS_192K_176P4K		3
-#define CS530X_FS_384K_356P8K		4
-#define CS530X_FS_768K_705P6K		5
+#define CS530X_FS_44P1K_48K		1
+#define CS530X_FS_88P2K_96K		2
+#define CS530X_FS_176P4K_192K		3
+#define CS530X_FS_356P8K_384K		4
+#define CS530X_FS_705P6K_768K		5
 
 /* ASP_CFG */
 #define CS530X_ASP_BCLK_FREQ_MASK	GENMASK(1, 0)
-- 
2.43.0


