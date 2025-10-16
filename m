Return-Path: <linux-kernel+bounces-856646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B72CBE4B01
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2813A5011
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE703570D1;
	Thu, 16 Oct 2025 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GvpaYQVI";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="H1PaLZql"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF54133CEA0;
	Thu, 16 Oct 2025 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633359; cv=fail; b=C8CovqzFVsInTAcj7hHubGINElE/ttO7LN5ahFLlQxCpw/lEwn/3Hgtwk3qbzLCfvvUkabOHUNoOGK+XkKFboYwzvqHPayAp0dmBBBNfYfWkMal4IZuoxhKXS22FjhxcbyBm2nnpaloJP373INFJkMuu7NZ27+3E64QjR1iJFtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633359; c=relaxed/simple;
	bh=9ka1CNkqu4qof1rW5DIqRZU7SOE78ZPiN/7rOVhtwV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E08MbTmC2DcguvjlWmMHOnVgy/d9u2UL+JH/WBu4YJsZ8kM9CXLA/DMNp0/ENCX34pZOnOvUgpMWgbdxmJ0KPFDLGlG61O8Z1GiDRUZPajKWrWkXwYDCic3haOal6ZZgAIAEE8RcAEMQBSIu2lNHAiZlgI7+p+CfZW8LlNkn5yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=GvpaYQVI; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=H1PaLZql; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GGUOY6298627;
	Thu, 16 Oct 2025 11:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=0/mQ75kraEDh1WVg7siN+QNcMFFvqtt0wx0k0TNBytc=; b=
	GvpaYQVI4oHp7Foykvrh2E0Bam8k84EdiPNunuzjVZt3CD6Gmibvp5uVP3myN2SI
	C0ja9RWHgqMHaPxnN8cibN81pJ7zPChc4Sc6im4fQWb3/pDLdpUMTX/Z4WYjUcpT
	+AcDE8/X4JUICm9g+Ls7sXpQvtNkdKLJEjCT7G9EMfd4+5k1vHyruRRIkO2nNwm0
	8VSaLfgtmaF+wlK/s3nbUa61iyJgYMv3b8dyPCMURzq4JI8a8ECBQryDKmNPFFMz
	NpLQgpSD+mfDQw/eeYDpx564CHXRgZCySWnkFVuS2c6MYSmbOCm9lCAKdB/c1Mxg
	WrnyRk6EP2ka+2IosZg0pQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021124.outbound.protection.outlook.com [52.101.52.124])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhj91u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:49:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQ5w124gHM1gIBkPpe5hkjR4GPot/ClNpRm2kRwoibNzHTlnheQPpWDtP0NEZv8Mx9IJUfdWr2S0lbX9RaGsa/zBCjRICYq5gsqbyFSf7uDaz4guTDEt6y6FbHYTCooDi8lAsdTCqNA6VgfpkMfSxXig3yzHzd9Gm2hHPRBsjndDPDQbBE8kpGUe0nfMS011iX/Pui8560keekEWovyH5Lh1+7t6BHi1NtcuuQJWFrhNjM348YccJnHhZedwP6k4ypDISBb+oBKYhdupOweHSKVTxxgTrxk6UOdmkCCtvVD2lvCf1BIy/R43TM4JAZCSe19POFIcQLJvyMFvQFYRCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/mQ75kraEDh1WVg7siN+QNcMFFvqtt0wx0k0TNBytc=;
 b=vPM9kykeLTcwVxhHIy4bM2l4C13MkDXiH3Dliw32+LwGwWy2pAV03tPp6ala6nCk1lC504cZvYq8xgkNniak4aAH02pIIf20SxIidROzd0Uon8Rmje7cY/3dAOZqXyrHRsAsALg2iHwPJqsdkNp/LvNqf35I764udrEyHkm9+8PXMlmrx+vi54XOmvOT89c9flq6K61+SdbeOuBqW8rYdqEWyZe3q10pwtzrT4GFvSJQv+6OzyiEB+E08rvgfzBmtG2S3U2WQNSoovAVAaumDxbpEDj/w5guZjtAxxeJpi5I0HxHuaqdYaUOrISNHikJH8EIsYWqUATUs1EFdTLCyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/mQ75kraEDh1WVg7siN+QNcMFFvqtt0wx0k0TNBytc=;
 b=H1PaLZql2BIYTMM0C1/cZ+oaFAsrP8Qv4TetBGtnmNyCOAsk1QJtAtz1oz0aNO1hk9kVHjuaaS6dV3z9tmQ94MmuHlFjMfb9+CzJ2NEbfZKzLUbxLtkGG15F1y+WVI4hvFfCr3JBXUICocy2eshMLYeI/N+tTGwMVDEC7OesmnA=
Received: from MN2PR18CA0007.namprd18.prod.outlook.com (2603:10b6:208:23c::12)
 by DS0PR19MB8343.namprd19.prod.outlook.com (2603:10b6:8:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 16:49:02 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23c:cafe::44) by MN2PR18CA0007.outlook.office365.com
 (2603:10b6:208:23c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 16:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:49:01 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id A0ABF406553;
	Thu, 16 Oct 2025 16:48:59 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 4CCD7822540;
	Thu, 16 Oct 2025 16:48:59 +0000 (UTC)
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
Subject: [PATCH v2 03/11] ASoC: cs530x: Sort #include directives and tydy up whitespaces
Date: Thu, 16 Oct 2025 17:48:21 +0100
Message-ID: <20251016164847.138826-4-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016164847.138826-1-vitalyr@opensource.cirrus.com>
References: <20251016164847.138826-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|DS0PR19MB8343:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7de10d7c-6172-41ee-76de-08de0cd3e8a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C3kpQWl2/x7iSqIg/2TgcameWTMPiKBudouJlnwlRHIdbEPwF2vh8pKIuKpZ?=
 =?us-ascii?Q?JHCN404wEE9cAUqJGICxZqsI8peQYYovcVemd6IUIjbPBPsoourbLrb/x6xD?=
 =?us-ascii?Q?QKdK+LIKiZ+PO0NID68bUyxfn4h7VA5WOWXoTpQT2cTxTah0Gp9k/5CfkhQx?=
 =?us-ascii?Q?hmOTbsUCQfZz0fFBQVZGYft1oMSHOhT9TazhJ2F2274Y+LK9JybNxatXb2kS?=
 =?us-ascii?Q?V0+5i6rJ88eoGCxL2Pw/MSoQoJBGpc3HrNzmEQFAb7qEn3Frxsn2VqAmnXDF?=
 =?us-ascii?Q?gwMMltqbYFpSY+2RHG82wvp1nhmpz6k9p0a8hX2FNO3C9u0UWZonNe6ExK88?=
 =?us-ascii?Q?kg1Ke5yGPs5/Tl07MVFsfGXSQyRxKzHwNwbXGUHeNS5dAK1EGxtK1Zkf/aSo?=
 =?us-ascii?Q?Iv3n9VMD1MNqA3XT6iH+cILnnwx9tDd1eLY0+cLZqxA8qUQHAEhkR7stUECd?=
 =?us-ascii?Q?qqz0Zk7TzPl0sqrzgYJO+l9Yssyoc2mFu/uSzAOMOJzL2UF7c4Sm/q8tiGcq?=
 =?us-ascii?Q?EdjpbGklK0OtrYwl8xoNndFaZd1YGL5SZgp4tvGaZwAEh7CJt52EVbjioTOy?=
 =?us-ascii?Q?MfVDXgagNyeY4kx2qtwJgzWPY2nYDxCLA1iRCa/XM+sMzOu6VFiJR0BaFt8A?=
 =?us-ascii?Q?laKmZpUiJ5P3esoJq4O5OyA1yaLDWuZ1G5SC1qyzdN468OUunSogrNxmYaL9?=
 =?us-ascii?Q?H43k2jTeC1nQD2j/BbsNy9KAIB8kw4Noi9G7sFh27jggeYdnMI7ha9TLCdCV?=
 =?us-ascii?Q?fBKRkvKsXF3cA/uYPXkkYsvN31+yHSAjLIGjW9Vsq9RBrChQ3N9fsdir1gHp?=
 =?us-ascii?Q?sMtYGGKXYsz479eYHax9Pdsn42LW3Qq+pMlDu6fcwfzUogRiN6a2rqo5Vjbo?=
 =?us-ascii?Q?yfXfMeSQCNAyVlvThkGnvIJiFrwZOE7AbOvF1Mxh0VhHa7N92Cmf2582lvUJ?=
 =?us-ascii?Q?BXFIna3u0sjG8ZaanklsNxHIbXvB6NdqcTftaAvx3eXDgFYbidZZDXe5Rc5x?=
 =?us-ascii?Q?e8YMfZw1tinSI+IXNOsAmqN7EkuzAiTkP0GkiTBRFEenCwXI1+D5Dzn5MlHM?=
 =?us-ascii?Q?qf+oWiGxYpPG1/PEJuWXH0HAjpxt9/l4WQ7QORuPfYWb5/jDSzWJ/XrgLZUJ?=
 =?us-ascii?Q?BrRq8EcpKDtGmer+SncOm/rngPEMrD10qzeJqU8Wx3aImfP2FSlKITRRpHJD?=
 =?us-ascii?Q?tzhBCJGp0wFY7ic4FQWue4fbGelGH5fEu4ZBePcjfaKAI4m0P56f0QG4Geuz?=
 =?us-ascii?Q?Ds2xlogG/50/C07j4jHCi8EYEzBacdRFpSYPcmuKad2KX8XFQU4rTUKOE/sf?=
 =?us-ascii?Q?t2YZx+qHb7jydgOMJpqq2vlicsKUHC0SYsohQdhFmLzdppYg4P3XwQn+hPUX?=
 =?us-ascii?Q?GXCgu6PNwMyl3fqxLbFl9zw003TnuBudfhBSRMp6aZI6j2EfRDnQnztWYR6k?=
 =?us-ascii?Q?yjwXi/9I4+5PVl8jbxJf+ihBQrapX8rFztsfSk4D3ZJn8TkL8dADBTgRhDWF?=
 =?us-ascii?Q?YQGv0/c+A0jOQJCi2vdW+wfqdBYdcFJxdCCFb99Sj0QAodkKn11acqynFETx?=
 =?us-ascii?Q?Mfz0SYuwIrL9SNe9LIo=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:49:01.0673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de10d7c-6172-41ee-76de-08de0cd3e8a5
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB8343
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMSBTYWx0ZWRfX7B1vSK9SI6Nw
 m7JKL4npAfkiHrSs4uYRbigWsJ83Mjvlw0fhbLUitJh/T86+0p3HEgokS8BvKZPiz43ZCUkUu/4
 FNbsXMRgARBlxMimOVaIVX+xYveaEHwwUmgtsXLCXHqEj4jvNxs6qCIFRZ/FodYxWgzqDI+vP7s
 Rmyd6/SPKIyqhcx9IOVPv+/6czohQkppyklsu76BkbOReRzI3bZPb7A5WGjTvyEStD9v4dqV/vm
 FG07mtd5GbMstSb8Uiz7DnB4lFvR4G2G1Yg2kOXQXQBpw3HtAg5UdLdhcEZMmfzhH80AY2j8Ll2
 cXKcmHwmQtoT6fsjIVzKztrsokfc6A8vuAoYJOToI7+2ToHr2Y7ucqzAe0bmGkbX/z6hwRA2zIa
 pZsSrQZlagpmDnQilbOW8NIkXfgnfg==
X-Proofpoint-ORIG-GUID: sA0H7xBDcpJ58z53lHr7Gb758LCJZXWM
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f12202 cx=c_pps
 a=VOnUWlUrRp4hX9ZrTSiZOw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=w1d2syhTAAAA:8 a=wFt9MVH1Lw3u3H5ftKQA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: sA0H7xBDcpJ58z53lHr7Gb758LCJZXWM
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x-i2c.c |  2 +-
 sound/soc/codecs/cs530x.c     | 49 ++++++++++++++++-------------------
 2 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/cs530x-i2c.c b/sound/soc/codecs/cs530x-i2c.c
index be80dcad3647..d6b7883ba7b9 100644
--- a/sound/soc/codecs/cs530x-i2c.c
+++ b/sound/soc/codecs/cs530x-i2c.c
@@ -48,7 +48,7 @@ static int cs530x_i2c_probe(struct i2c_client *client)
 	cs530x->regmap = devm_regmap_init_i2c(client, &cs530x_regmap);
 	if (IS_ERR(cs530x->regmap))
 		return dev_err_probe(&client->dev, PTR_ERR(cs530x->regmap),
-			      "Failed to allocate register map\n");
+				     "Failed to allocate register map\n");
 
 	cs530x->devtype = (uintptr_t)i2c_get_match_data(client);
 	cs530x->dev = &client->dev;
diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index d016e8298a69..8bbce589b3b4 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -5,17 +5,17 @@
 // Copyright (C) 2024-2025 Cirrus Logic, Inc. and
 //                         Cirrus Logic International Semiconductor Ltd.
 
-#include <sound/core.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
-#include <sound/initval.h>
 #include <linux/module.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
 #include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/tlv.h>
 
@@ -104,7 +104,7 @@ static bool cs530x_writeable_register(struct device *dev, unsigned int reg)
 }
 
 static int cs530x_put_volsw_vu(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
+			       struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
@@ -224,7 +224,7 @@ SOC_SINGLE("ADC8 Invert Switch", CS530X_IN_INV, CS530X_IN8_INV_SHIFT, 1, 0),
 };
 
 static int cs530x_adc_event(struct snd_soc_dapm_widget *w,
-			     struct snd_kcontrol *kcontrol, int event)
+			    struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct cs530x_priv *cs530x = snd_soc_component_get_drvdata(component);
@@ -236,9 +236,9 @@ static int cs530x_adc_event(struct snd_soc_dapm_widget *w,
 		break;
 	case SND_SOC_DAPM_POST_PMU:
 		regmap_clear_bits(regmap, CS530X_IN_VOL_CTRL1_0 +
-				 (w->shift * 2), CS530X_IN_MUTE);
+				  (w->shift * 2), CS530X_IN_MUTE);
 		regmap_clear_bits(regmap, CS530X_IN_VOL_CTRL1_0 +
-				 ((w->shift+1) * 2), CS530X_IN_MUTE);
+				  ((w->shift + 1) * 2), CS530X_IN_MUTE);
 
 		cs530x->adc_pairs_count--;
 		if (!cs530x->adc_pairs_count) {
@@ -249,9 +249,9 @@ static int cs530x_adc_event(struct snd_soc_dapm_widget *w,
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
 		regmap_set_bits(regmap, CS530X_IN_VOL_CTRL1_0 +
-			       (w->shift * 2), CS530X_IN_MUTE);
+				(w->shift * 2), CS530X_IN_MUTE);
 		regmap_set_bits(regmap, CS530X_IN_VOL_CTRL1_0 +
-			       ((w->shift+1) * 2), CS530X_IN_MUTE);
+				((w->shift + 1) * 2), CS530X_IN_MUTE);
 		return regmap_write(regmap, CS530X_IN_VOL_CTRL5,
 				    CS530X_IN_VU);
 	default:
@@ -263,16 +263,12 @@ static int cs530x_adc_event(struct snd_soc_dapm_widget *w,
 
 static const struct snd_kcontrol_new adc12_ctrl =
 	SOC_DAPM_SINGLE_VIRT("Switch", 1);
-
 static const struct snd_kcontrol_new adc34_ctrl =
 	SOC_DAPM_SINGLE_VIRT("Switch", 1);
-
 static const struct snd_kcontrol_new adc56_ctrl =
 	SOC_DAPM_SINGLE_VIRT("Switch", 1);
-
 static const struct snd_kcontrol_new adc78_ctrl =
 	SOC_DAPM_SINGLE_VIRT("Switch", 1);
-
 static const struct snd_kcontrol_new in_hpf_ctrl =
 	SOC_DAPM_SINGLE_VIRT("Switch", 1);
 
@@ -450,7 +446,7 @@ static int cs530x_set_bclk(struct snd_soc_component *component, const int freq)
 }
 
 static int cs530x_set_pll_refclk(struct snd_soc_component *component,
-				  const unsigned int freq)
+				 const unsigned int freq)
 {
 	struct cs530x_priv *priv = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap = priv->regmap;
@@ -492,7 +488,6 @@ static int cs530x_hw_params(struct snd_pcm_substream *substream,
 	int ret = 0, fs = params_rate(params), bclk;
 	unsigned int fs_val;
 
-
 	switch (fs) {
 	case 32000:
 		fs_val = CS530X_FS_32K;
@@ -540,7 +535,7 @@ static int cs530x_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (!regmap_test_bits(regmap, CS530X_CLK_CFG_0,
-			     CS530X_PLL_REFCLK_SRC_MASK)) {
+			      CS530X_PLL_REFCLK_SRC_MASK)) {
 		ret = cs530x_set_pll_refclk(component, bclk);
 		if (ret)
 			return ret;
@@ -614,7 +609,7 @@ static bool cs530x_check_mclk_freq(struct snd_soc_component *component,
 }
 
 static int cs530x_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
-				 unsigned int rx_mask, int slots, int slot_width)
+			       unsigned int rx_mask, int slots, int slot_width)
 {
 	struct snd_soc_component *component = dai->component;
 	struct cs530x_priv *cs530x = snd_soc_component_get_drvdata(component);
@@ -686,8 +681,8 @@ static const struct snd_soc_dai_driver cs530x_dai = {
 };
 
 static int cs530x_set_pll(struct snd_soc_component *component, int pll_id,
-			   int source, unsigned int freq_in,
-			   unsigned int freq_out)
+			  int source, unsigned int freq_in,
+			  unsigned int freq_out)
 {
 	struct cs530x_priv *cs530x = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap = cs530x->regmap;
@@ -743,7 +738,6 @@ static int cs530x_component_probe(struct snd_soc_component *component)
 					       cs530x_in_sum_4ch_controls,
 					       num_widgets);
 		break;
-
 	case CS5308:
 		cs530x_add_12_adc_widgets(component);
 		cs530x_add_34_adc_widgets(component);
@@ -775,7 +769,7 @@ static int cs530x_component_probe(struct snd_soc_component *component)
 }
 
 static int cs530x_set_sysclk(struct snd_soc_component *component, int clk_id,
-				int source, unsigned int freq, int dir)
+			     int source, unsigned int freq, int dir)
 {
 	struct cs530x_priv *cs530x = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap = cs530x->regmap;
@@ -895,8 +889,8 @@ int cs530x_probe(struct cs530x_priv *cs530x)
 	int ret, i;
 
 	cs530x->dev_dai = devm_kmemdup(dev, &cs530x_dai,
-					sizeof(*(cs530x->dev_dai)),
-					GFP_KERNEL);
+				       sizeof(*(cs530x->dev_dai)),
+				       GFP_KERNEL);
 	if (!cs530x->dev_dai)
 		return -ENOMEM;
 
@@ -914,10 +908,10 @@ int cs530x_probe(struct cs530x_priv *cs530x)
 		return dev_err_probe(dev, ret, "Failed to enable supplies");
 
 	cs530x->reset_gpio = devm_gpiod_get_optional(dev, "reset",
-						      GPIOD_OUT_HIGH);
+						     GPIOD_OUT_HIGH);
 	if (IS_ERR(cs530x->reset_gpio)) {
 		ret = dev_err_probe(dev, PTR_ERR(cs530x->reset_gpio),
-			      "Reset gpio not available\n");
+				    "Reset gpio not available\n");
 		goto err_regulator;
 	}
 
@@ -947,7 +941,8 @@ int cs530x_probe(struct cs530x_priv *cs530x)
 	cs530x->dev_dai->capture.channels_max = cs530x->num_adcs;
 
 	ret = devm_snd_soc_register_component(dev,
-			&soc_component_dev_cs530x, cs530x->dev_dai, 1);
+					      &soc_component_dev_cs530x,
+					      cs530x->dev_dai, 1);
 	if (ret) {
 		dev_err_probe(dev, ret, "Can't register cs530x component\n");
 		goto err_reset;
-- 
2.43.0


