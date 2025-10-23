Return-Path: <linux-kernel+bounces-866556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B701FC00150
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432F81A61340
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E08A2FB973;
	Thu, 23 Oct 2025 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="mqJgk55f";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="xICwaVwK"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7FE296BB9;
	Thu, 23 Oct 2025 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210240; cv=fail; b=nfm95aikjz7mXgzo/9c5fvng9VPqPuFqhcrwNAnstjU9A1WJD4NOScfQ+qFf5HclnaCc3ZQmYgXy3ni7qsaWLcgBLrywNYtDa54FFMn3vAXXnGSGsXpBiN2wIYLGIMAV7GravgrKh4xkO9z5Ia28L7RlmbUn6ngvt9IIK9CrOpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210240; c=relaxed/simple;
	bh=t30BYAtdH46QAgD28rvZtFsG2wT4MdLu0uGqK9DdCag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nm1FlnAbf43DBc2Am795NU3bBQmnp64Ks+Qsy02stCxSaMnrMY0cIt1COhG03HLMZhsqcR148wfEQu4AufG7fFwo166ApNdNoIYiR1mVoAaYwZPuFrdfTq68KPY8ExKAE4RFFi21Vs36tuhH3ARZKDvorjPFjZv2F98HWSgosqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=mqJgk55f; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=xICwaVwK; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59N3xgFg3465752;
	Thu, 23 Oct 2025 04:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=O1HVVDlUxLFStcyvLl/ndK44DE0fiJgeLjZvMrrGncY=; b=
	mqJgk55fuF6uZyMmq6mRj+cVaQppuWZzS+S4AoyCdrxQyi1EeuzcpwQzNtW5WSsF
	M7+bO4HbAtMiCRABC8797FQRSoSx1GjuKwh0CtnQp9BluqiNI7G40EEcP1XsCTsJ
	jA024WYt1OMmaegNZAd9AMmjiFeERNAHuGywz3Hi/YgQcWSu4o/mG8mCrg1+wgXw
	aOSrJBS90BP9lmoppMtOutcrc0bal2oo0+hiSILSBgj/d1toKv0kmKZ6MHFEo9z2
	tcIweVNmX4/rt1ykEzMznExLTuTqZw67zbh0EbFBdFjJ9JCNuqd2eMDh1RA7GoSM
	b2MDvi8y3juMgUnBlSjhhQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020116.outbound.protection.outlook.com [52.101.201.116])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49xs381v5x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 04:03:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opsRw1nT61hzZ4JRrhvSY/KFHRbzNnUWqyc1qoJRza06fAeJy0utavdykidKETLyP30G1eQgUkjuqM7HVIIK7gbKrhG0fIHOk6G4YILjlKQpeDxhqk1Yiszhkq8k27EkitWST020zFxtah7vILSWLppxa2ddQKbvoW9jgYH9ykmxKXzWflQzeHAjY91oaa8f9smkS7OxzdLtiWGNctsHoVR5aM3YqDT+DMvK0ZYPgBlH39+vDfwaqtnN2E+VVys04LWgqiIr5drPUEjrJ7PWkB/y0ZKP8QADhZ23WBDXei2d3JiM+NtVc+XiT/AVmq3NgRPQ+1QPEyjjpVDB8hllvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1HVVDlUxLFStcyvLl/ndK44DE0fiJgeLjZvMrrGncY=;
 b=J1uEgu/W/KRR9/lVaLOl/vmc85c4i6z9ftDdivRn6v7GtXMotbC9+Itzrek617bJ66TtXSWtX6aDIASCx3H3RXeoNQdqGbG5fxoBKrPJjGXvXEooYWiOvbDyYbpddD+iDx3upDw9/Zc98xGqDKQbHmvlaqXdCP6wwoli45EGIqzL6RQMrBrYuGTo4oxtmEoR7ENk1FYTIOrufu+q0Wj4foMXrB2XuU3X8cecQhjYcDmc8iddd/SNefP03+TK9OmcqFEwpxKylwq51zt7GXp2UZKTmdN7G/Ob0F+JNbww9sDNG2k8c2X5C4oky0eJNp0REs2SV+kRQs9Xb37wNfwVOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1HVVDlUxLFStcyvLl/ndK44DE0fiJgeLjZvMrrGncY=;
 b=xICwaVwKvNRnH6vMZi8jYTOkdiILPJpnIJiwE3wNLtgK6f+PDg9O3I8+HurA04lAGAzp1BmitUCmWXiXtSNsGi9UUfP+PrAzxgn4D7GdzflRwPRB7ulknytPDB0xj+f8H31izXIRui0pC6NQCld/Ut48GMA38tHD7u7qYVeTntc=
Received: from MN2PR08CA0010.namprd08.prod.outlook.com (2603:10b6:208:239::15)
 by SN7PR19MB7041.namprd19.prod.outlook.com (2603:10b6:806:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 09:03:41 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::ff) by MN2PR08CA0010.outlook.office365.com
 (2603:10b6:208:239::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 09:03:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Thu, 23 Oct 2025 09:03:40 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 9B296406559;
	Thu, 23 Oct 2025 09:03:39 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 3A821820244;
	Thu, 23 Oct 2025 09:03:39 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v6 07/12] ASoC: cs530x: Rename bitfield to reflect common use for ADC and DAC
Date: Thu, 23 Oct 2025 10:03:15 +0100
Message-ID: <20251023090327.58275-8-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023090327.58275-1-vitalyr@opensource.cirrus.com>
References: <20251023090327.58275-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|SN7PR19MB7041:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ae10a268-4f49-477e-69da-08de12130fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|61400799027|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qIUgjsUhHKTiLaDRnS6J6bw2W5Ia5JNlW8C5UVZvndTrzmZM7FwCLKaC+kkH?=
 =?us-ascii?Q?Fjjh8AzynJsnmezkcDRJhhMAMEKop5/HxtimHDqJksVPbf3TKa56LPnJZFuX?=
 =?us-ascii?Q?sSLUuXDcgzh0AueHzrEiTFc5Ewj1CsRAYS1i96atTfMtXouYsW2P/+Xl/c8o?=
 =?us-ascii?Q?PwETvYU+9gJ1tVmPRisp6ckHXleHduz5rRKga7XTriMv4/BGgPlwiYksvmap?=
 =?us-ascii?Q?ik4enIw6qnOI3hhfT3oGWyf/LkBDd0lQz9gc6pwkR79KEqehGEH3AhpdJoU4?=
 =?us-ascii?Q?osIhjCCWwXW6Xpr4L8qHRnG4FNIWpzLgPqLpkBE+hqejNQnpmd+HKgFzAXy4?=
 =?us-ascii?Q?lm7yjbvaLgv2h76MCNG4iJPzSt2NEyRuPVY2xyFBfGc2mxFntSL2U5vY3Fdd?=
 =?us-ascii?Q?8tTzQQ36emj5KXcCEJZgoSJ2DEmEd5458NLpTsVJO4gtbmU3MzHPdFFJqvWP?=
 =?us-ascii?Q?N+WaiHKXadQzgfRY0nIz2hKkHWeU+24xEBYKXdS2hXUjRYtKM3lzt1smcNtX?=
 =?us-ascii?Q?FPdUXTQihKIVC6FHNJ7K7DApaqjlupRZLdMxWohINhD6fDX+Ls8fjWj2Ya8M?=
 =?us-ascii?Q?NVPnPgkVV8kHH19oQbHUjvsbYQOWpPQ5uGpypMCKT4LDYLStVXcw/YG2HeAM?=
 =?us-ascii?Q?+WUCqM79isCQIzsEpOvqlBqTg8q5eAtwXiEhEQn1WbE8t7A1r6TopbU5D2SQ?=
 =?us-ascii?Q?io5pXBYB18NhEuVFot9oGeTly7Y+fW/ucc1qJ3LRurix4xb2EVUPhYwzNbCY?=
 =?us-ascii?Q?jFCWSuqdPbO3Q5WQ3iYKjfspRLm5kSW/4kq7QLJ5pb9V+0fvWa9KevDqKvra?=
 =?us-ascii?Q?0KCRBUQja5Q6Giquz89HWhp47O3s5xi8ITbUr7J7R999mWAEUy36YO4zZ0C1?=
 =?us-ascii?Q?mdAUzt9qroDHeL15Y1NlPQvVxq5NSKSWGH09NRkOTgzewHnk2vQu23dK22hA?=
 =?us-ascii?Q?JADTgQFi7FIQ5JOzyIsfB5xjgb+E/UQV7QvrlqStCGYTQUTa528HCiq3U2Ly?=
 =?us-ascii?Q?81qlndQ0B3lq/1NnaClSEE9tRbQvNgnnkffh0dBhbe5IEEFbCHCqc0Z53VeS?=
 =?us-ascii?Q?2Ofbl0VFe2Rvwy5yc83EtbsqRg/etXcmvvDUILvTXGQXedEn91c1GJ5Bp5Ka?=
 =?us-ascii?Q?eTb3LcglyhDbDzUTkA91VeupZE27kP6TBtBWGRIK7SClistPn/KMTqIxBVhp?=
 =?us-ascii?Q?dueg8+7IGYjagB0c27obAyWzk3CK1oavM+VtECxEQ0+mV6YTmb4u4+Y3QTAw?=
 =?us-ascii?Q?etFbcKG4Q9jM5sA2ge/HFHNYLuBadWnZ1EWEYDOJBxlsYsjvs5IUPrZcB1aD?=
 =?us-ascii?Q?DRm2miyLe0y+73IwtoENtjM/9WM1edHm5gdBhsSb+FMDmOa8lHihR4RNyJ3O?=
 =?us-ascii?Q?Wz1J2Meg05LXV8SNsMTPsju3ZqFVBIQj7C4xplVBjgSq3G4vGGPwYIl9/g4Z?=
 =?us-ascii?Q?OfcTLIcGslFpU+LmbVTZVTKzgmkHlHYwQ7y52BQAgFVVbxt6iCiqzCRBo6nz?=
 =?us-ascii?Q?w0zNN/OrCdyyQXVhz5Jf4HxIsbDB4myeIX5UeWGchY0qQy7OZUwZ8V2zrrf7?=
 =?us-ascii?Q?NnTSlJMaqWAagYcQ8Go=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(61400799027)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:03:40.8615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae10a268-4f49-477e-69da-08de12130fb9
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB7041
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDA4MCBTYWx0ZWRfX52AP7WamdxDU
 p5d5foBkqjsoPZKlT7UpfSA/i/FfpSN46FTPT5SctAe0Y+Z+OOJcUCO86Mkp8NXEFmL5UwXCkMN
 zCjJrTbIcyBk7jU5/n/jeanGwttvAcAFYoWRaDrojVWOfUgY5jzi7C1Si2GRspYCRQbLeXGamXI
 XGcFMQQ4zJ0Jv82TRAVTl9BYTMBTSdEioFgosxgfPRdKvT3+7C7Xmok/FfN7WN8HvnRQX9nyGDt
 Uq19DrdWOZpRMxQFgdK//EmWj8fy/lC0+RDQn9Z6EptvXYkH6tvR0jt5dBnmv88d3zEbEIJY04F
 uTdfv53VX3bah9nw49UqJdDshDkeUYylpqzaXSIgg6YjfV5Gag5uAWPxGpJNPfTuQvDX3SRWs82
 tc+V3lA085xA6LXYC5h6YON7dsiQ+g==
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=68f9ef71 cx=c_pps
 a=3HzPxjwlbby21TQhxie9EQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=8pIFU9epQc3EzPgbZ4kA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 8Y1MTlq9e-E24FXJhJf4HYELTjrsxsfq
X-Proofpoint-ORIG-GUID: 8Y1MTlq9e-E24FXJhJf4HYELTjrsxsfq
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 4b0bf1c3b985..193d7af5cfd5 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -141,8 +141,8 @@ static int cs530x_put_volsw_vu(struct snd_kcontrol *kcontrol,
 	if (ret)
 		goto volsw_err;
 
-	/* Write IN_VU bit for the volume change to take effect */
-	regmap_write(regmap, CS530X_IN_VOL_CTRL5, CS530X_IN_VU);
+	/* Write INOUT_VU bit for the volume change to take effect */
+	regmap_write(regmap, CS530X_IN_VOL_CTRL5, CS530X_INOUT_VU);
 
 volsw_err:
 	snd_soc_dapm_mutex_unlock(dapm);
-- 
2.43.0


