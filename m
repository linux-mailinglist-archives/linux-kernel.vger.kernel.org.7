Return-Path: <linux-kernel+bounces-798183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B8AB41A69
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D471BA44AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDF82741CD;
	Wed,  3 Sep 2025 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Zc1MzSIU";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Dh4tzCCs"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25F81922F6;
	Wed,  3 Sep 2025 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892776; cv=fail; b=LQVF4GHDVOOQ6/N76A+8kxqiEZ8oHBBGqN0gq8ccdOdaw/aNTBbiVDCSdPhIiigkg25lQJODCJPYUzcHYQk7RePjXW9j3+Hj65X1rqNnfZdPu9NPj5mcQLd60cld9zh5kmkwaw/o1Ob93K2c65Jc1Xc5/ej7rcFlK2Yn/BsP0F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892776; c=relaxed/simple;
	bh=IyzUE1/0wYPpEP7wGfJAgUMe+dATxs2xHVYIJFSM4L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlv3W0C6rfvpuC8KiUKaf6kT66+i6USzG2Ung0dYf+fHFXdRL1f6RIlGm1MbZwa7/0qwnpph6nxvCjeoHOlw0wHjPTlVtZyId3BVVswZ7+teZwUWZevCxOpbozH3LKgL9u+FPIQfu8LFYmMpBpyDQbjt3ucUfTNt8YXZdQ0uiVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Zc1MzSIU; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Dh4tzCCs; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 582IRcuR1987260;
	Wed, 3 Sep 2025 04:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=/2k2z2JGOB1TkxhT9PeQH/FC7bHLo9usvB1q+EbVfJo=; b=
	Zc1MzSIUbNgZ5gQOL7sfC0Z3rUFoLUue1i+xEKSVouy5woFWyqMVDdk87yO/QFle
	G0nxZnfIfhKEIeGtncpuK849E1f2Ai327tIC8FR8BeofH/pVrk4MvUkZRXwV8NwH
	WnyIjDHsaRsb1lKThM1vtqVssh2/HX5ORJqPXx5FyvMb290D4UBXMreMdr8UnZaW
	9XZl3HntK6vbqar3G+/hIVewxmG/64hVn3+n74MbBbkvapv0IBgdifHeW+JuuD9f
	wKRbslM8vCTAf7olZWzxmgtRayzk6PSY3mSZjvRahdLVXU1kGNGlHqRuxw+TRI2h
	cJBtnAjRoBCYpIFXohhr+A==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02hn2245.outbound.protection.outlook.com [52.100.159.245])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 48vensc6d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 04:45:59 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5k5QCn8VrFG32qYDzS+yE6foOBh6HVzPC+s3KtoMqA5zsBBGD9QgPMRhcwGPJMvDdaHVcoE3+QvnIoupNhs4DONdbiHMFL1bpyXTe4KQEU8KVKaA7EJeBP8lnYPQk7MR8YJ9UShS4OC1BT8jVZqOKHJZpl8VfYpSJQOCFsw8fNbBG8XXg3i6KaKiDd43/0ZLxawD3tO63MU1PAZ05InhR+yflEBADZ4YUq0NpYd7hCRuAOO6QVvxWFuxsvW2KUNRBoMA5oCNcERbG+dd0Hc1jjVBHtlZAvVAhREQMdFuhZM+L09Rb8epWK4ZSuZxx1ysxuge59RkhN0WrwDTFvZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2k2z2JGOB1TkxhT9PeQH/FC7bHLo9usvB1q+EbVfJo=;
 b=yajtYlq9h4vmakhvQ5CGnoGuOPT5GhvCKrGslLKTHJQvqHkVPlmYqKE7h8HC4sDys8brM9PCbhrmO6cenyr2/cqtlljAS++SyuALt2r8YrPSlb7WRyB++TtsyPB9rQ6fnAXPAUXP63S11pTj6c/e0NBbzB3qt3VosVJO8yErapeFeQ/++Ta9o/M2Q3gpqTFdQCOZVfKI0LKEHGBayGaVqNDNUdVBPi9NBb/Ywn87AZB+mK6UCESonu5IhGeym07CnuMvpr2XhZ5i1CD4f0NnORxTok6BgLRYlNPfzsXhrtF5liBctmhstyFxqDW9ov/y0rzHKKNiC2GvEVvNrcXM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2k2z2JGOB1TkxhT9PeQH/FC7bHLo9usvB1q+EbVfJo=;
 b=Dh4tzCCsjn5CiXqXjO9eLKXIGxDN5oDFCUxSY9PXpt9rgf7pI/y6jJrSWBgY9LINlBDdl7K1B5z0O6dH37wwcXl/xqWIvw7qomZtfXbImIZYMKz0Iw+toGD4duJTHNsFerhN+PMIYv7/KNoK9EtY68crAaC35WP6RVI91HKPwK4=
Received: from CH0PR07CA0001.namprd07.prod.outlook.com (2603:10b6:610:32::6)
 by CO6PR19MB4737.namprd19.prod.outlook.com (2603:10b6:5:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 09:45:56 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::df) by CH0PR07CA0001.outlook.office365.com
 (2603:10b6:610:32::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Wed,
 3 Sep 2025 09:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Wed, 3 Sep 2025 09:45:54 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 43AEB40654E;
	Wed,  3 Sep 2025 09:45:53 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 2E61682026C;
	Wed,  3 Sep 2025 09:45:53 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org, lee@kernel.org
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH 4/6] ASoC: cs42l43: Shutdown jack detection on suspend
Date: Wed,  3 Sep 2025 10:45:47 +0100
Message-ID: <20250903094549.271068-5-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250903094549.271068-1-ckeepax@opensource.cirrus.com>
References: <20250903094549.271068-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|CO6PR19MB4737:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6d532ca1-7804-4775-ac86-08ddeacead2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|61400799027|82310400026|36860700013|34020700016|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LAu3Iur+Sw3iZgr1p1LjfxP+/QoIqQYJyizzMmZP41FiVCAHigPtU6eGeA7y?=
 =?us-ascii?Q?q8ak0DiPqAdFce4JQNGrQGcO4UAxIWbD6JL3/qKb1+mTzSX28rEbOgg65zO/?=
 =?us-ascii?Q?GSriNo6YP4oZLzyMqhYGuRZWvsBHm9N2eAyQGCXFO3HPyKJBwiSu/wZuSyIU?=
 =?us-ascii?Q?30JYIRPSLxw2xrfdaMxZJTFEAlDj3HtLe6MlUTMNlCzS/ZWi1luJsDNWSnYH?=
 =?us-ascii?Q?mrCBpfiF3/rQzLfphWCSXMskukvJECY+cW0Do13ItukUcIQF12po9Hyb/+he?=
 =?us-ascii?Q?DYsSCfm8xrhRLFa62iBsb7G4iMmUxGkLlNjmYTGYTWnaK/gCUBLmP8rCFNuX?=
 =?us-ascii?Q?0GfIYz0SrVDYIzm5la16ko5UJzhRHsOiUts8ys0IopHhZCaBc2DA1aRaCbc3?=
 =?us-ascii?Q?3OlXjJ85JHvGym1wVkZySZidJvUe8ZtUaXwcftBNMHQm+2Zm1y/Cxbf7IGun?=
 =?us-ascii?Q?fVR4PXDLdsEDafwBZCnxGmWbb/eqSOMZ+h5aOQ9tVuXXYA7e9s48toziDKEu?=
 =?us-ascii?Q?DhEpyoXtXmzkFHG2S5GtOchnFASpuyQIXpeuGYq0xb9+rVRBA1Fdo52f7qeU?=
 =?us-ascii?Q?34iBuVrTpPxGEpRhUNnk3Kf9Y6DCmmtTJQKmsf9isVyT90NmOjZNp9x1ItR5?=
 =?us-ascii?Q?7YobKT2acDZwR1Pttlw+6I2m6TKUiRMoWY7OG4Pgbz1v9J7IWl5ObnpaoU/k?=
 =?us-ascii?Q?msQE1TmS16NqMoXPJ9EyKi4hVixCA7VjKNLDI8+zfjMzfgdzAaB0Wi84X5NQ?=
 =?us-ascii?Q?v4pUAqWukV/E6EpqpNA8kRVkeC3Mrtf6moFeXOh/adwqznV6qlJjTdUmz5Lw?=
 =?us-ascii?Q?TZJ4jgHmMlNexClDRQENoAzmn7r2kkR6KOwiWeHR8nTmnkhELa0ggynH8Vuv?=
 =?us-ascii?Q?/uc+3tJ7BjuLgofwJde76GYw3AFyfLtgxjbCNQgq/AqLTRTJH6rMmAls2dbX?=
 =?us-ascii?Q?4/Qh1NslZPCNIPDgPfBT4MHXvGycUczLz1HK2DHAevteQNM+RkYATSV7gfMx?=
 =?us-ascii?Q?wS0uZeXCHxW6j6rZUdHfG67QjAxES/qCl/Dlv7te+1jLf2Y6o6Kz4u5yWhM6?=
 =?us-ascii?Q?Di8BFq2Orr7IMl91kdLY2iOCc+gIiH5cG8b/OX1V25IZs+vExOjZ3q6BPnZ5?=
 =?us-ascii?Q?GhF3+6qnDNUoq1m2XgUKbqIi0EIPiSEx7BRg4gTD8wfCTRw97yTt2fTAa/fq?=
 =?us-ascii?Q?YZsLDEvmqIPpNOsrd3G2SsS1okZZsUCQ4J6bzMXIhl7CidxJwGaVssfJTz+f?=
 =?us-ascii?Q?3dOuUA3LmgLNWbhvD4uuL6Hsbv3JoW7Kj1g2/orPAwhf/n+WZaRV99Me2hbv?=
 =?us-ascii?Q?NmhDszuxMXzCK8igM22YdDch/UVveTlDDZeTl1w/RhZBuv1fsrQO52K+eY8t?=
 =?us-ascii?Q?qSB/5vAz+tpaY99BvTlVHPWu0SobiUXQLUE1OuFHkPOIaNhIpG8XNAAkHNF3?=
 =?us-ascii?Q?KvOWdzIJd0q7XnWMlFSzVFjRtc+/b5ypBX0rYMhuWK43ozRszzHGasvjhdko?=
 =?us-ascii?Q?O0e7T/fc8LXGw67WuXJ0oL9etIrDoZzd1fFG?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(61400799027)(82310400026)(36860700013)(34020700016)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:45:54.3782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d532ca1-7804-4775-ac86-08ddeacead2d
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR19MB4737
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDA5NyBTYWx0ZWRfX2rctihLzn1ji
 JPVlUnfxLXEWckMlThM97rt8aMB7TpE19bdnpfwpTgJ6g0Ne5xJ4Idz9OsGrF/pLcm+gLRiXAcr
 MsPZiVXDhGahwlE4mC5nOfmwGF3lMrBaljMbVNovqseAWozBFo7sWf6MwKgDmokBLVyizHEU7Zm
 dYjFADPUD33czrmxoP36uBJHOMVJcGu0jrezcTxQxWSHclr96HO1bamkM+tcg1lOxWfAI4tLaot
 Q5T/DhXnvO2e5AYHfrHeS3vulQoyaGl0fwjUudA5rYMVudaWpgs5rKmRMcLfa5SfLcskjwbDKIa
 +LlIBJsqdxGZPhVXc3vDO7K+qJhDe6CdZJnXkcmV+/r7HvAgQZs+B50jDwordo=
X-Authority-Analysis: v=2.4 cv=BY/Y0qt2 c=1 sm=1 tr=0 ts=68b80e57 cx=c_pps
 a=eVRsmZEBXFlQPGjYG4AgSQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=mz1aAddHEDVMvu6kbNAA:9
 a=jZz-an6Pvt0H8_Yc_ROU:22
X-Proofpoint-GUID: vuNik4BLczY0Oa3oC67VkBAg6YHAef4X
X-Proofpoint-ORIG-GUID: vuNik4BLczY0Oa3oC67VkBAg6YHAef4X
X-Proofpoint-Spam-Reason: safe

Fully power down the jack detection on system suspend since the device
will not be powered up during.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l43-jack.c | 8 +++++---
 sound/soc/codecs/cs42l43.c      | 2 ++
 sound/soc/codecs/cs42l43.h      | 1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l43-jack.c b/sound/soc/codecs/cs42l43-jack.c
index 2a0a4986a9ce8..867e23d4fb8d8 100644
--- a/sound/soc/codecs/cs42l43-jack.c
+++ b/sound/soc/codecs/cs42l43-jack.c
@@ -684,7 +684,7 @@ static int cs42l43_run_type_detect(struct cs42l43_codec *priv)
 	}
 }
 
-static void cs42l43_clear_jack(struct cs42l43_codec *priv)
+void cs42l43_clear_jack(struct cs42l43_codec *priv)
 {
 	struct cs42l43 *cs42l43 = priv->core;
 
@@ -703,8 +703,6 @@ static void cs42l43_clear_jack(struct cs42l43_codec *priv)
 	regmap_update_bits(cs42l43->regmap, CS42L43_HS2,
 			   CS42L43_HSDET_MODE_MASK | CS42L43_HSDET_MANUAL_MODE_MASK,
 			   0x2 << CS42L43_HSDET_MODE_SHIFT);
-
-	snd_soc_jack_report(priv->jack_hp, 0, 0xFFFF);
 }
 
 void cs42l43_tip_sense_work(struct work_struct *work)
@@ -753,6 +751,8 @@ void cs42l43_tip_sense_work(struct work_struct *work)
 
 		cs42l43_clear_jack(priv);
 
+		snd_soc_jack_report(priv->jack_hp, 0, 0xFFFF);
+
 		if (cs42l43->sdw && priv->jack_present) {
 			pm_runtime_put(priv->dev);
 			priv->jack_present = false;
@@ -903,6 +903,8 @@ int cs42l43_jack_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *u
 
 	cs42l43_clear_jack(priv);
 
+	snd_soc_jack_report(priv->jack_hp, 0, 0xFFFF);
+
 	if (!override) {
 		queue_delayed_work(system_long_wq, &priv->tip_sense_work, 0);
 	} else {
diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index 405926149a137..b61df09f20cf4 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -2422,6 +2422,8 @@ static int cs42l43_codec_suspend(struct device *dev)
 	cancel_delayed_work_sync(&priv->tip_sense_work);
 	cancel_delayed_work_sync(&priv->hp_ilimit_clear_work);
 
+	cs42l43_clear_jack(priv);
+
 	return pm_runtime_force_suspend(dev);
 }
 
diff --git a/sound/soc/codecs/cs42l43.h b/sound/soc/codecs/cs42l43.h
index 0951ad3525efe..b2fa2cd1d99f8 100644
--- a/sound/soc/codecs/cs42l43.h
+++ b/sound/soc/codecs/cs42l43.h
@@ -132,6 +132,7 @@ static inline int cs42l43_sdw_add_peripheral(struct snd_pcm_substream *substream
 int cs42l43_set_jack(struct snd_soc_component *component,
 		     struct snd_soc_jack *jack, void *d);
 void cs42l43_bias_sense_timeout(struct work_struct *work);
+void cs42l43_clear_jack(struct cs42l43_codec *priv);
 void cs42l43_tip_sense_work(struct work_struct *work);
 irqreturn_t cs42l43_bias_detect_clamp(int irq, void *data);
 irqreturn_t cs42l43_button_press(int irq, void *data);
-- 
2.47.2


