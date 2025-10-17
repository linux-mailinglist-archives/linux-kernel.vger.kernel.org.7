Return-Path: <linux-kernel+bounces-858409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C63BEABCC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09D355C2EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3932C21DA;
	Fri, 17 Oct 2025 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qaLDDEIn";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="tQI1/utG"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB562836A4;
	Fri, 17 Oct 2025 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717779; cv=fail; b=lw25/bkVoc+UXj7e47wYqfycRty3KRrLdMQtsqSDzhSBEBkRsy5JdjV2usUMVPm2Cf2p/QG43rFuAkj2Bf5ErzuOnbbU4QUX42CQRLgLn6SjJ7Ql0Z0rvVyKLWG8UcF5OuZJQQc93I0/q5yWCDHBscdPZYBsu0KIQURr6U4NrSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717779; c=relaxed/simple;
	bh=EGvR+BiQkn1WhjPN54f7oc+ordmzsUUiXl3IPccQ43Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAr9kmnrDHBKotfYispxhd75VIalEJB6ovzRnSu/Le+ekyFwK180zvWVk2OFBMqUkK7P0XLYvBC0Bs8QY7OVC+d7nXrSSlGAOW7s2pHsKRAKdqfaLglHJ//emWCxXIDjEvRZP2N9mvSPaMZJqq/lTwSQxl9ieJKk/3xRPqlCJLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=qaLDDEIn; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=tQI1/utG; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59H0Yklu4021107;
	Fri, 17 Oct 2025 11:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=o96B4YQDp5yWxqLUNuwVwxWkfNI1kaZXYyGO4U9jV3g=; b=
	qaLDDEInsZeqCLrwxiXi6JQASlKQiRREAjdFSqQtdAh8txWjRQSKvIfw4xqZ2f+p
	LQ9MMfVymDJR3PBISmCSFxIvP4Mpt6nB5Xz3oTJY2YP69wH0W1XI3iq1j+IC+Mtc
	0FJINND7/C+jyUujkHajR4dF8LzOvRzPvktwsKx2MvRQHdbjEkj25eLnScT7hdxk
	pbs1HTcJQg4HaM4p2gCgeLhN10CoLZsB6RY+91TSU+uLNvGLR8c3/DyaBqBc7Y2D
	HH4GG86B3lluWapbHd5hkNFq3zR1rsJFkmlko2yQ3jWYdhncGmwUHY2zu1zTcJxu
	t1YXRsJfwx/GIXMDBWuEmA==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021116.outbound.protection.outlook.com [52.101.62.116])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49ubc98w6v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 11:15:59 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmjJSRfMODy5uPPT4o3UzTUZHb0pebTJ33xasXxTsXMJhLN3Nw5WZXBofd2+tF3b6lkZ0KkGyO+Q9R6fCLQBexsvvOhRnWbuVwbpP6oXTNFaTwCOJfp6a3vtd8ycXWd084pswmKaw2y4/Y04nnCfTT1cZTzhyTT9SEvLrANvHijCp5oFDS4SDOVAeubQCDZ9/yQW9WqixA6lVdzGXecfzZRPQk6ExYV5rIDZ2TtVXN0puyEHz6LFYbH7ZOOGWu/CXc6o0HgCpdo35BAHQaiAnmSljnwSrHXJ2gKVLzvKFfwqSmgGMKueAixbakoamHbyxN+aUmqaHdKiTJsEz5LJVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o96B4YQDp5yWxqLUNuwVwxWkfNI1kaZXYyGO4U9jV3g=;
 b=A6AuOJT3IabEU+v4C/skEVlzdVUhptg9Jh7AYvshPNXab+XeZCDE0yxfXh56aEFx+Q4lYfm9V8VX15FitJ7GprP7M1UTd9ust9nK8mDeg5ComxuPoqnaBgHfRWwrWtv7gUyjVXS08MYiv2DltN3v1By2A0q2XGwXtPNaEY8TykKeYOqJt93jcumnYU4lqsVWQIwqoDwOQ1YcMqjmWaq6OrVpEttQD/RAYLfG5uVeR84ec9jXaAT73BS3pFunx2ZOoF7M66D52eBeLeu+75XpTzrRdimFbo8OR9+Z+1C2/rGn2kze2jr0tUOPSdV+3yH6zoNZN5qislBqe+GOkfuI4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o96B4YQDp5yWxqLUNuwVwxWkfNI1kaZXYyGO4U9jV3g=;
 b=tQI1/utGpJjb7qQT/pSsVAy3E147wxRWNbXKV0tQYqQloUNbjsQGbcHLXkoya0oC0HbuCpCv2k2xpat5Y+MB8//zxUpXgAfp4QjMHindbK118tlOeN8KPF/y4IJuANuIcBRAF/ZiJcF2FqGxK8beGuTiCB65g73Ww1+qafsE3H0=
Received: from MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14) by
 DM4PR19MB7922.namprd19.prod.outlook.com (2603:10b6:8:18e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Fri, 17 Oct 2025 16:15:56 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:907:0:cafe::58) by MW2PR16CA0001.outlook.office365.com
 (2603:10b6:907::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 16:15:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 16:15:55 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id ED0DC40654B;
	Fri, 17 Oct 2025 16:15:53 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 93850822540;
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
        Simon Trimmer <simont@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v4 01/11] ASoC: cs530x: Correct log message with expected variable
Date: Fri, 17 Oct 2025 17:15:28 +0100
Message-ID: <20251017161543.214235-2-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|DM4PR19MB7922:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b49c9c06-a738-4c11-c9ab-08de0d98736a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HbvL8YNrBT5ZE97e7BRF593bydPUGD7TSRYzL374m1YAcFp/elays35g+4w3?=
 =?us-ascii?Q?nRmsQR/J903nfM+v3roafYGnq7y3wLYNMvPgKUr221/104dpBGVY6q+sCMSj?=
 =?us-ascii?Q?VjJPAFSRBpgLsFabn3WWdUQ7BtvVTfgl1IZJ/MPB8uHAAqIoD/NxsX4rIA22?=
 =?us-ascii?Q?cot7N/JY/lo/ZuTIHeAMCn6XtXSCfDcfnaooQCc/VhKmvDNxGZLFVzAz5HG5?=
 =?us-ascii?Q?iyTQlTA/Y0lv8c0kdw0DtpJHlmu5A60f1Esj6HAi8pkbgyJYhmn2GiS+HaDN?=
 =?us-ascii?Q?zkacviuApr4nHOkzLG3K92B5EE/NnVfxqVObX+NiYoOJAjm3R02rlybSZKJz?=
 =?us-ascii?Q?aDKkxP8f3Bdp+yJqB/XuzNRyUJu2UoCOnn/NlTTj9ANtrII03zvQO04sQL7y?=
 =?us-ascii?Q?ukhNwe4lntXbNuG7H+sy1sUoWalbr+lSXnCMOG6w3Jaa0AxLz8yb0QDnwpUV?=
 =?us-ascii?Q?Yb4sbbnvL400pJG+wbjErhZIdMqsJTq+goRgFlE3dBm9fam4coyvHK0vBGSl?=
 =?us-ascii?Q?JX1CeKF+k3zz5NRxYuhD//4o5UhvZpEnIAXF3q+QCLhzKG/IG16Lao5wsgTG?=
 =?us-ascii?Q?+5OsuQAXeT/WugtovgTQwqW8IRs5G7OfgEZl3RKKi8Zo/IWyY6g0CfsTjcYM?=
 =?us-ascii?Q?I42mXNL6jMV9b+awIWmClwfJIjx0FG+bzdQ/Drl/KHAaHZVC03CKmxVSEz6Y?=
 =?us-ascii?Q?mVBQxFpC/86irASnTrFoyFUz8iEEDba0vorSKqEOrz9tXNIZXTSnw5xATMD3?=
 =?us-ascii?Q?DygIuVOSMVu0anr2t41Oa7SHLPXTnRs36KBykTraZ/Rc0srvgonDm1ORKa50?=
 =?us-ascii?Q?34z5UlRekGX30oIm1dkY8HjVUPJhkPgJEq2lKkEy1YAYhUovAQIX0pVL0qI1?=
 =?us-ascii?Q?quOMwv7nPuK04SXAeFHmMSxVMCsKBRdvTOAYFsCXUR6sfp1zraWWhLPM49OE?=
 =?us-ascii?Q?4yG3/rbPrXDSpAnZjO6K7Wg6dNyWiPIYdDmpDJf+7WkYQY/B+NhbPkDyCllm?=
 =?us-ascii?Q?36qsYCJN7EE3hzGokTOsisgCA+ZuKIHqNgG7WUHwEuAE0TjUCR62DUTmGaz0?=
 =?us-ascii?Q?KoB7tyDYgjJkBeZEdYeqPjNht8g5K5oojX1Sxwx63hwSjtDG0m3yBC/MAnnw?=
 =?us-ascii?Q?O1tfJepQCljLhDDPM5zY8DjixzhKP5x+deW1V13mxnxFFgoX+4hte+Gzv7nV?=
 =?us-ascii?Q?7+32kbTKemXFM2cznHTEIcJqrHLh92erCEjYtrvMXMqEwYy1VSn5MdBUsoY6?=
 =?us-ascii?Q?Ssap6500lZAKAWgaxkeBeaQp+V4Uw6PNWncNj/wcPhuzZD6RHekST9YQ9udG?=
 =?us-ascii?Q?cDsyolGwcdrob/Kw/MdrvpJTRWkmJ/pkMHr4Ojj8v0TfQWnd7NQF6wesfY7C?=
 =?us-ascii?Q?r4Uy7txyNQCFKsVIncA7zEzJ4ydjrq73N4cENT79KdzCk6DLXYa6ZFIejPJu?=
 =?us-ascii?Q?EPSJNHYJqlkMnu+Dm7pWfBNCbtfsr6jDe65KU+zuqK2QqBbefWQMUkU8p2aM?=
 =?us-ascii?Q?cjE52P+HowEXNq6oBT8iARrd2exI71PElKjsuUors3RUgspCmWy3joQls0ek?=
 =?us-ascii?Q?pxGsoRV4qz9bozsTYv4=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(7416014)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:15:55.2478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b49c9c06-a738-4c11-c9ab-08de0d98736a
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB7922
X-Proofpoint-ORIG-GUID: 85RXNk7wy_GfCjsSs8uRmu-T88NLZp5m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDEyMCBTYWx0ZWRfXyece+RQID4zm
 D7Tob4RhsqLXnxkb0MOVTlEcdu1vTTCxz7ZCQV8SIQnD73SpVdpVlaAse+MWNGDvx6fSj6QMv2t
 53FDysKs12iKuVLmmue90X54WmUxAkUvZ8f9T0HZ9HMpBvgwvIchIkINuYsZv/VAuA50qAZpejx
 wjwsspZHz8CUfRLOuu/OKf2Mel0rNsQEQIa4YtaQ55oGQ5PAjrT5cl3QuTfsSUvI9SeVO91qCvm
 0mSHgSHhXAfZkOhs9JgvCxQydRIfRVtUlbZNODLFRs5sOrN6RVTd2JJ88HYE9xFd8pIm0JbQ0BH
 ihYVxWtihBvvr3SbR3Z4vxXLvNYEJNy6Bf9JIRBZ1E5KHOrfPqJIQMdFQw/7x+1nUzAsgeUd+TN
 REWp1jDhnsrNh32L9t3gmywxeAREQA==
X-Proofpoint-GUID: 85RXNk7wy_GfCjsSs8uRmu-T88NLZp5m
X-Authority-Analysis: v=2.4 cv=H7bWAuYi c=1 sm=1 tr=0 ts=68f26bbf cx=c_pps
 a=9Rg/qTnvelsXqi2P0wmk1A==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=Q_cYDw76ORux1IEp9KIA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

The function used one parameter for the switch statement, but logged a
different parameter when it defaulted.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index b9eff240b929..535387cd7aa3 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -793,7 +793,7 @@ static int cs530x_set_sysclk(struct snd_soc_component *component, int clk_id,
 	case CS530X_SYSCLK_SRC_PLL:
 		break;
 	default:
-		dev_err(component->dev, "Invalid clock id %d\n", clk_id);
+		dev_err(component->dev, "Invalid sysclk source: %d\n", source);
 		return -EINVAL;
 	}
 
-- 
2.43.0


