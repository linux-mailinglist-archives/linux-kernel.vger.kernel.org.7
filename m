Return-Path: <linux-kernel+bounces-858415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A7FBEA9D1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2461A677BE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9002B2E7162;
	Fri, 17 Oct 2025 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ZNnTuoSR";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Ncgd5Qf8"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FD229DB64;
	Fri, 17 Oct 2025 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717791; cv=fail; b=mYxvXD6QgFGLMHkMI41wL24ek5wCko93YWWICS0uX8aPEc1m9r4NeG/0TWZqTqM+nJhMWpLT6OHhzGc+GAax+wfjW1rFErwC1VIFHgL9tTEFN1fX+SiBo2HX8p3fDk2/BTEJAH+lSyKnpV4ZNjRivTTlC3SPcaP6eWoXjOFuqu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717791; c=relaxed/simple;
	bh=a0xbbPhJV6WCvc+c2G2xOHWwlKNuPSAr5JUlCNW5Vz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXiA2LkiddboLtc41Qt0POrsATyUEopTGLZfV0P/c0UVNoIiSKkKpf/rfOMBVssHgD2K2UKWOLhhPhbrmCv2EwzkuqTMtk9SkrmYsJ6HRvl7CCAJ1GW7FRg26MCFVS2ve52bFI/hVAzPFQgbMRlsRHo/0Ba+K3UwHOvOGsJ3mb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ZNnTuoSR; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Ncgd5Qf8; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GNlV3G859456;
	Fri, 17 Oct 2025 11:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=CDoyyxXqya6DChI8Uu/FCa7bZGLzX4UWT0ihRm0yw2o=; b=
	ZNnTuoSRSLBGbQmNkTw7BbxCSQ4bT4KALAWD/TKIkAWGeE5dhIG0peYlmgCIgnJq
	ytlIhmI5rzKAEMH5otdU8uxhd5+0LJTX/Gqas+Tri/sU5vt4FaH79kclzgs8ZVki
	DvQC1DArjt3ZMuoyHqmk5x2+gHWNM+KY+YYPMP8rlbmpIHMn1sg4wa/B5luVCJl1
	ObjziPXxfZKgozGHsdHzmNG3xofNI01dyPAvfn535DhUosgs0wAKU1fcK67Ysauh
	2Gktu6OUVICN0TzFhRHTyCBChqdh6CoC8MEVvhPRUJJAQc9ut4WHZtZUqv+JhXDd
	6ShSMMjFIjcXh7Zz3gxzJA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020101.outbound.protection.outlook.com [52.101.85.101])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mnhsbh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 11:16:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHG7k7WPfZesX5aKihj/xXgW3ljANT+x6lI3j1KfS7BCBc6CKT+YjsNXuw3OB5Ru4Bq3U39i9XZ1ll2JCE9lPtB2VybI8aKc/SQStsJkB5Wjy+mMtjvOyadlsS/L63EgNfaeRHtAwohtUZxnVRK5mrIAygJxGqKM41fK9G+bKsCYzOeLaD5qv6OOeOYVfdEuJdmkVXdOW5SFkxvHZVf21koeBwc7R5RJ8nXjYkc73qxt4WPRC/G+nOadwG3EU1FOQgrq6zN8Tb9VF27JYf1g2BRWBdbqhN2jvdraTuYfgF3uoZRmmeDbPvC807EFYuHNLYfFXoUbtS6KQ43yno/s9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDoyyxXqya6DChI8Uu/FCa7bZGLzX4UWT0ihRm0yw2o=;
 b=coxrUxXChSq9yPoWxuHoYCDnHRn2X0kpspQ3HQMkQp+JnhbvDJsXy1ccEaoy60u1BoKgsZbnDTgarTbIZcPAQCFoP2p6l3rbA2ox897RN4k97CbUVP+STU1Cz0zOgdeVI/8ixBPaFa4VaOS6AH8rpsK1DNSK14UimR8ZqIDzl9gonJcK2cPHjc/5/fv/nWfR2iBqD1T5Dw54pCBPbG0ROOChl5kugu3JSQk/qtIHZSoDp5eBZPXcrxiJqom1CuGXC7dghm+vXJ2IZbYjElx1qt872YONScHiAQ0/6qyQEYXF9b8tIjbiuBsL0bbh3WKe03b7dXCGwKUYnUdo4RacDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDoyyxXqya6DChI8Uu/FCa7bZGLzX4UWT0ihRm0yw2o=;
 b=Ncgd5Qf80RxtFNkdkXec5UBGqsJky+btMRKYFT4Qi3sN3HoiKXd2kS6r0/H8z/lND0E3s6tMcQPK+V8Rc5GhD//SQwStqgkg061FJiUhgcpsRhcM0NMvtvcNvenl+oqwFkrOCl/U4Lv3kFts4iSoOTovQ3zKNvD8WzdPseLQBRU=
Received: from BN0PR07CA0030.namprd07.prod.outlook.com (2603:10b6:408:141::13)
 by CY8PR19MB7060.namprd19.prod.outlook.com (2603:10b6:930:54::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 16:15:58 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::1b) by BN0PR07CA0030.outlook.office365.com
 (2603:10b6:408:141::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 16:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 16:15:58 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id C12C8406561;
	Fri, 17 Oct 2025 16:15:56 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 6681B822540;
	Fri, 17 Oct 2025 16:15:56 +0000 (UTC)
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
Subject: [PATCH v4 08/11] ASoC: cs530x: Check the DEVID matches the devtype
Date: Fri, 17 Oct 2025 17:15:35 +0100
Message-ID: <20251017161543.214235-9-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|CY8PR19MB7060:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 88aae064-726a-48a0-fdc3-08de0d987501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6MI7bq4zl9hOxRCa1JV36WHG8E9CQjoZVUUczmCH6hrGnh/LhsXFm/g/DOC4?=
 =?us-ascii?Q?NeIwruIjJkJReKqp9KW1ziBhTKaEIjpGjqP2vpKKM93qVS/F0yMplonHbgdT?=
 =?us-ascii?Q?KgQElW0fp9LHhQLr1fPRzaxKeKACuHu05dJX+2pU5qC8VVfX7coeOqWqiQtA?=
 =?us-ascii?Q?6tfxPug2zDUqO1aE1fAB/SyV0GGOO8nZVyEkN4D147sVM15J8ZXjPnfXJQEw?=
 =?us-ascii?Q?/bCytsBceJf1cZx4Na3fl+1Tl+9IqR3qEAy1KXqf26R3HtlqxJ4lbIDtgvw/?=
 =?us-ascii?Q?GBBo7Txa3HDBNJq4IXkLIGY8hkIKORmkERIkXT6W2Zhg5APeE9ts0LOh1UPJ?=
 =?us-ascii?Q?oZYvCbLZzkX46vQAFkSYAiVsmKcN8DNDMlH0Z9aVVyzc5PPJP/FQBa8AGdxT?=
 =?us-ascii?Q?D5QRaYVlcM81akvjrBtURpmF7/FvDDboiSSPQ/9Mra0rQ//VQhxvQcHm0N9+?=
 =?us-ascii?Q?AqjxNJXcGMCKYn2S/9E/02b9RxRnoiJNSR7yUN33kC5h0FmSnqJERYJVrJeY?=
 =?us-ascii?Q?+T5BZjflr6ahe1QUZ+GmPlllu4YU4pViS2+4baBpb7sRaryckq3CSYGaUy45?=
 =?us-ascii?Q?ZW/seXcLFW6Qq4CZJExXOqKAwupVD2lVHqWPuVvGTGPJRMK5Zzy0bgxghz5t?=
 =?us-ascii?Q?QH/NgkcNeSp0UazLf/99CExb5/I2Y6ZHg4ZbOfQM+rC4Ds11bE4GemBhVyJt?=
 =?us-ascii?Q?b5NcP0AEFbBuA2G43QwOSRtRQJRF8jGQJcSNTKqCecF6PeHGHtm8Srt3KyqQ?=
 =?us-ascii?Q?Wkc2criKEUGF7ff6lfwaf0RnUTaQI0T/Wx2IbCaoqU5pSCJOrsoFljRBw0Zd?=
 =?us-ascii?Q?BIMDN9/iFTzEntYtCC0t/So0KcGIJgP0l/m4gInoMibdafNBP7HUrl/d+2d7?=
 =?us-ascii?Q?7oUXcAL17CRD7ktygifYufZRrsRxOXHVF7SJ7RuA12pnv9li+pSwuEUef8++?=
 =?us-ascii?Q?0IBJSX4OMlABfWY7ljeAqcRsgy+8MqX9RJz5GS80aA2TObzOSqr5svSU5deQ?=
 =?us-ascii?Q?dTXM0RalbrEBQqVbilgFRQ0NMTwb6+lJ9zcV5/DvB+Pn3596gcdQnDEtSY79?=
 =?us-ascii?Q?+7Lyg9BV+tjBwM9mPtStxFmcBGQJHlWhCxLoo02fGdFh/l/5aEHb0WNxS97A?=
 =?us-ascii?Q?z9Y1HheqJXMci7QaLgqIE1P8/mSjIa94nDOcYKkDEOTeH8+zFXw5/tM7ubuu?=
 =?us-ascii?Q?BDBkEiKngKk4fczD8pntDjELLjx7i9R2S2+K/f+VFjvzkfGtUppTTRp0tzBR?=
 =?us-ascii?Q?5ovwVEur0tow9Y4aXjtAXobz7dFqWmE6YjgTAwC+/9p3bvboG4xh8x3vr2LW?=
 =?us-ascii?Q?/+II1kKy4pTZB24CDlGw6zo211QnRNaWT0lJRioVPmFEmoCl6OyXDnCEBZM/?=
 =?us-ascii?Q?2cpCSAjYC4kIx5CFNNfLPyU22Kn/D/gBfaq+jruIBvqQNJgQhABAFMHqtxjy?=
 =?us-ascii?Q?ZR13+F/mcP96bD0ymdcGIR6yTd84XoTX4fh7GWz2FFKeb/uh7QjcUCF5qq4l?=
 =?us-ascii?Q?aS4KbOlroNTyVbZgypg1lVUFszxLnYJ/iDlfw2S8CxpXqkBC01L/8KFpBGo0?=
 =?us-ascii?Q?vZbG0CUeYvIM2G0HNdM=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:15:58.0373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88aae064-726a-48a0-fdc3-08de0d987501
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7060
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f26bc2 cx=c_pps
 a=kPg5dDEhcxiqFsFFPyJETw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=Ueq04TJKjEWbJfMvJoAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: ITjQoFZvcfBkgItk8PNO4npsBN31evlX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDEyMCBTYWx0ZWRfX0vpmCLaB/0+L
 8n9C/WZ8pIoPHH7hCr/11ZPAu5b8186imeo60bTWvPZP1X9o6J91MqYeerFGs2cUWEDb2zSTb1z
 pU5QHgOCZUDBi1LSI0y/aO9gxQteeVvApch7Y1w1I8kdXhKrcGwf9Tqv+Nljo5ZpyeBaCJwdniA
 73fi4McNpzRm1FTzxVBjwPR8Qz6su8BLd0F/Otvqc+AYWpt3tkO4kyJdLvqjGvwEwBg1I6HBQQb
 qjAV6g6FXmt6oYTuS8HvlhxyvFp/+x82811dLnCI3LHwsHOXsKfpXZp0Q5KHKIQDQFvaVw66pOw
 9KOw5KUgLOAVlkLwPhKon0/t/RFm1lKW5UTYqJfo5WpCS5O6t71QMtpaEoP3Us1fH1UbbYuItj6
 TB1XqCOTK69iEXfUKlXWqqwUwgF3fw==
X-Proofpoint-GUID: ITjQoFZvcfBkgItk8PNO4npsBN31evlX
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

If the read device ID is not the expected devtype derived from the
compatible device match then fail the probe as other configuration
details may be incorrect.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c |  6 ++++++
 sound/soc/codecs/cs530x.h | 14 +++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 25dbf401b15d..cdd050c0fa2b 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -1181,6 +1181,12 @@ static int cs530x_check_device_id(struct cs530x_priv *cs530x)
 				     dev_id);
 	}
 
+	if (cs530x->devtype != dev_id) {
+		dev_err(dev, "Read device ID 0x%x is not the expected devtype 0x%x\n",
+			dev_id, cs530x->devtype);
+		return -EINVAL;
+	}
+
 	dev_dbg(dev, "Device ID 0x%x Rev ID 0x%x (%d in %d out)\n", dev_id, rev,
 		cs530x->num_adcs, cs530x->num_dacs);
 
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index c10a6766cc7a..758d9b1eb39d 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -185,13 +185,13 @@
 #define CS530X_NUM_SUPPLIES		2
 
 enum cs530x_type {
-	CS4282,
-	CS4302,
-	CS4304,
-	CS4308,
-	CS5302,
-	CS5304,
-	CS5308,
+	CS4282 = CS530X_2CH_CODEC_DEV_ID,
+	CS4302 = CS530X_2CH_DAC_DEV_ID,
+	CS4304 = CS530X_4CH_DAC_DEV_ID,
+	CS4308 = CS530X_8CH_DAC_DEV_ID,
+	CS5302 = CS530X_2CH_ADC_DEV_ID,
+	CS5304 = CS530X_4CH_ADC_DEV_ID,
+	CS5308 = CS530X_8CH_ADC_DEV_ID,
 };
 
 /* codec private data */
-- 
2.43.0


