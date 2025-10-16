Return-Path: <linux-kernel+bounces-856670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3696ABE4C56
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70C70544C63
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A1C3570A8;
	Thu, 16 Oct 2025 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="NMfhVHi0";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Xg8LSodG"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E060345731;
	Thu, 16 Oct 2025 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633944; cv=fail; b=WDaKAvEoFskRoAsUxEx6avfzhfX4kBGcwPA1eAlC9pE/5FAWtqZMtpTslTWq6ulX9dU3hkeVxvhCuQiOJqtalN88SqOfd4m+jgVYPhIdhxc2DpxkD5EqaknVaKsmL6seljCKbvXviagpA6OCeXecodkGs3CYzngMH75zKYmZ8E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633944; c=relaxed/simple;
	bh=5MbjxicHLwnGNMda2kCOSyZxtPBWWjv2zl3BsvOJQrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sL2QpeZW4OocmM3xwz69t8AcKBPqGvoAJP0OdOHIi0jcnbNRcnBKFNx9ySgUflapNEU6Llf38vontjfuCApzyPffNcJiibRaPxoP7sDK+v1WRkHEU8IU0REBcV0YfdOCYm1wEQq/3/JpSWUf1bHhRVHnd9MUSqf7Q7JD0eeXFsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=NMfhVHi0; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Xg8LSodG; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GGnUL6298651;
	Thu, 16 Oct 2025 11:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=u1cZjPoXmSxFu27qCu90v4ejFktyMRictvKJOqrR3bQ=; b=
	NMfhVHi0VknYqwFDBUyXbcMnGV60vA9c3q4IzcN/m7uC3N+V9N2O6aRBJfmynN2V
	gPiC2FHnetYoN+Y3/DCDtSiZPPuFzdT/4xRguHmlJuyHdU4lE7QhAe5nmAKgra9W
	j7MPvIxIYf7cPpvj7CyKkWjwOKGC/64BS2FP/De71ciffSnPpELqm2yWPMf2655m
	WPG6RrSbbnLhnVZpvfKeKXWGfT9VPJXJcUj0at9wwWM1/hGkEBoQ2FP4UNKGJtOg
	2MW9/EjGnfyQobBmlCC36Cdj4G+ItwhfZ0cVW+41K1t2ZWq4rMik7VZ4OXBVA5Hq
	Tx/cgsUtvT32rOh7HutMhA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020142.outbound.protection.outlook.com [52.101.56.142])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhj9gv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:58:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpEuOwJNWpT/dO1QTKp3/dGMJzIseJqog+Vkmfg1jYUGle3d+Zt5hxPoqc34sD4S7vsgnGCZ4jY96BTKpfIfUpH8qh2D+fkw+Vv8pYYNMCFJxD3SyjeRTh+8Q8C9rZpCkvaqmsAkwUnw/Sw1A4zpKmoBWeC2w+u6BbemeVlEdWqR4kAz/1mwB8PWnw58oN9ZpuQAnM3/ujvsjqrNQOP4R8WRrClRIajiwwTjaC9CGQwTETtkFYqaCEMUwHw0d13umis/oZxotk9ylPCd4tJFUzTOGRmA4WqqIK1rjBCDfb1GlRlXP6kWFVlX4evNrH6Mv7yZQiegM138RAbukb/sKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1cZjPoXmSxFu27qCu90v4ejFktyMRictvKJOqrR3bQ=;
 b=NhGiZk6SHbtz57s5XpDrJ09xqxchXiNNXivnICkLKaH/nS9ZR0if195ZdwBNs53j8zjRmz399aLS35C4w3pAaeZ22TIP1siM+hRckGuKoflHCs+rHRXq29TMQRBuVBNpULhxlYxjVBqLEfY5+Y+Ggn6CGBZi8vbyGLLNvk9WxYM+6AIKMaiTcgdCk/Qj+H2T9TzfYK5a/9rU8GrFeYoYWejXEceFeJHPFFRKPd6ohmYxjO0zr6oRMsmi9AhFcDurBVy2UlGDomlwDlx9aG3rJAuwxytGFwuNpUiURbX3PloKmS0e+3X3cayGEgg1hALAld0faVnwuCw/lDH5zvtm6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1cZjPoXmSxFu27qCu90v4ejFktyMRictvKJOqrR3bQ=;
 b=Xg8LSodG3r805WTbqI8kysxT2o+8CzvtG6O7HwO7Ht3J+yaNFedg7P3EwCWfjSB6d2M125qjH+Lcda+Tp1TxRJgiiSAttwoKkVS71nyMfxwsLrXywJ1IFB8MRStDmZWHblA6kLorDXH+q/W1C8LFABXoUh4Uuk+LJaCIRfhdq6Y=
Received: from SA1P222CA0049.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::26)
 by BLAPR19MB4577.namprd19.prod.outlook.com (2603:10b6:208:290::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 16 Oct
 2025 16:58:48 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:2d0:cafe::35) by SA1P222CA0049.outlook.office365.com
 (2603:10b6:806:2d0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Thu,
 16 Oct 2025 16:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:58:47 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 34452406555;
	Thu, 16 Oct 2025 16:58:46 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id D5CC4820244;
	Thu, 16 Oct 2025 16:58:45 +0000 (UTC)
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
Subject: [PATCH v3 04/11] ASoC: cs530x: Remove unused struct members and constants
Date: Thu, 16 Oct 2025 17:58:15 +0100
Message-ID: <20251016165835.143832-5-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016165835.143832-1-vitalyr@opensource.cirrus.com>
References: <20251016165835.143832-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|BLAPR19MB4577:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ef508ab8-1e66-43eb-81e1-08de0cd54607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Ey3zXERt9Fw6h6s32SkIOJqyk21YrBlbI6mh/EPSbsft4z4ro6bNpebyG09?=
 =?us-ascii?Q?6VnQIDsSiF1sYT/ISz8dDvw9XwncAAi5Y1u8tJNJ7EjM3qZUbvCLHBaUSmM1?=
 =?us-ascii?Q?0yGu7OwVMdadRsyeI58oruPFXIGG8Lyv92+ieg3+ijvLJ/wkC462DDG1L117?=
 =?us-ascii?Q?hT4GKpa83Be3ENtQnZjvt54vlipYHfMurfuTXc4Yq1FseWBFAqx5aoHF1OZU?=
 =?us-ascii?Q?BxUiEGJ+jw4dQteYvPFkSuILYDd9Yc0bN3r1j0cAfQejk8o9RyhPkt+sUMhA?=
 =?us-ascii?Q?jtCanoGohRI2pDdsszJZpbtTmCQ3W+9li5dPxsdHhT+16sysbJSFlXEuww7I?=
 =?us-ascii?Q?RW4gIarYRmo7EEMO9GNsR/Q8oWnYvVacJqMydXQPdBiqXkiz4TSBr53nEVdE?=
 =?us-ascii?Q?9GrstW/S1VaA8pWyYJNudoABJj/6k9AUxrbQUCQvGs+JNK6tTk6372bDDNGy?=
 =?us-ascii?Q?xqlNbI9Hv4IHruI0cpT+smAz5f6T0BHpoiSIwGaxRq2ubKaDDTK/+504HKI9?=
 =?us-ascii?Q?Gby+w0ylp+fadFS4P6DWak/aAGFXTCDAtSl4H87geSTGv08UNO7yNHFcNXj0?=
 =?us-ascii?Q?z7ZLR0utlDI9HqYpqbl0yTLa1W+v8n20nBcJfYvDWk4g8QKrpj3Uf9x2CrtP?=
 =?us-ascii?Q?4Qz2CzR4D/rtR/1VQU6CqjbX3NTuUgS7AcuRUnek7AkKNC5qbrDINWv3Lrx5?=
 =?us-ascii?Q?C8N1s1slx2MN7nS85lE2wvsDCox5rrlb9jqDWI8hq2QoOvWCY9BfCgXHns/4?=
 =?us-ascii?Q?zoy0MxO50aeoE+dFniNtM72WuFQk6yVElit9ta2tADyv9eIi4/YWs6jXZ2V1?=
 =?us-ascii?Q?V9hqF+nTUkRuFVKW2lDmTfcYHVwLXW9qqQJETzp8KLxZfube1iwYqiZ6o4XH?=
 =?us-ascii?Q?z2rw58YVzrYHJQ9e1tpl/3qgGF5Zawst5tuUXrbup3rm6BJHw/x5nBZeH9Mv?=
 =?us-ascii?Q?wF/NCaybRIXeVaN17TtWfvFtOhPwsh/BmOYATviIa38X0+rWRD90sSZuReG6?=
 =?us-ascii?Q?Ydp8PVODZSa/dTMuMb58lCcr/20r+HAAdtHT8vC72TRDzkimGja0LC5P5GF3?=
 =?us-ascii?Q?DmOuoTIqdkW6Sm12NEmQbBHSYcMy9qtW8ejcAf1E/J6bFitImKNJulPG9nK9?=
 =?us-ascii?Q?bU7oU4jT0FD0VTGFAJejVL4oa6PyCTRKKb1kmgDPc391C2nHx/rcHY3I7ilJ?=
 =?us-ascii?Q?sKv6oQ+FIXHRa9/FUsVSqCzIJdpJmCsjYzxou60EUz24XWcpQOlwCWhnxijD?=
 =?us-ascii?Q?7jF3TXpYzwqmU/TN2gm5f9XW1JzF+C41GY4Qr4Atp+aNCFKAf1XmmOHo47GB?=
 =?us-ascii?Q?BR9Xt1PrqxYH4Z9YVChPrDtq64SiwdC6p3oYJ0U+8CDtSochIyrjfKwlgyMA?=
 =?us-ascii?Q?aV2QAdfuZrmHI0gcv4OjfsRdXyWZghyfwRSD3JrYG5Bw07DVRGSpa6qJDd6q?=
 =?us-ascii?Q?79lL+jYzv8IWPqilIcRRvjI6dYAogYWKGF7P1rPjjoikG6stUPsOFRTpd3LP?=
 =?us-ascii?Q?EDd/JMIFpobVqTeTudi+rXvn6FTVchSZEUS8kuwyZqasLApi05YFN8bMgwq3?=
 =?us-ascii?Q?xfQ/3q3ydi7ZWnL59rM=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:58:47.2856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef508ab8-1e66-43eb-81e1-08de0cd54607
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4577
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMyBTYWx0ZWRfX8mFQ1fG8UrWk
 dOYPlSk+Nm21DxGsUyXpPJqxGR6h5IE5v6kJO21utHvPFiErxllVEPNb+dlmdJk741kLkT2VEo6
 +hqWEg1RVP7sYF3Oj7avqbvOZhupbVSe+tLfW+hsb5FPm0cTuANtg1hPFtyikjA+0/04/hLJzBA
 zPHgGM2ofqiWX9WL2YPVv2WiajAlLeSUcZ1xR0Zpzvy+t4aZQv7AKs2WRpsRBmfX6CU8VN2DTUe
 gFcNr//zw2F5c0gER7mYhmL9uFODaw/zWWFQBaatlnngQC7jpia9eX4n6pIp5OFrzrtujce0YF4
 0M311FGIAsR6/5+YLUoYK++N3nUbeISNGLdAA2IKE7bzm6KSJP9/HNqGrOjCnQN9e1Wv+Dfpxn5
 IwJpRA8m5UCsS38XuQB2mW2pUoebPQ==
X-Proofpoint-ORIG-GUID: Ao4wBwoV4sNVu237_fVyyQl7BUQIkVAI
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f1244c cx=c_pps
 a=O/EYF111MzuH6KO3ZCP4VA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=8v0jFsMaT9EysKbcgnkA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Ao4wBwoV4sNVu237_fVyyQl7BUQIkVAI
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c |  6 ------
 sound/soc/codecs/cs530x.h | 29 +----------------------------
 2 files changed, 1 insertion(+), 34 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 8bbce589b3b4..4add46ef93cb 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -21,9 +21,6 @@
 
 #include "cs530x.h"
 
-#define CS530X_MAX_ADC_CH	8
-#define CS530X_MIN_ADC_CH	2
-
 static const char *cs530x_supply_names[CS530X_NUM_SUPPLIES] = {
 	"vdd-a",
 	"vdd-io",
@@ -517,7 +514,6 @@ static int cs530x_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	cs530x->fs = fs;
 	regmap_update_bits(regmap, CS530X_CLK_CFG_1,
 			   CS530X_SAMPLE_RATE_MASK, fs_val);
 
@@ -781,8 +777,6 @@ static int cs530x_set_sysclk(struct snd_soc_component *component, int clk_id,
 				freq);
 			return -EINVAL;
 		}
-
-		cs530x->mclk_rate = freq;
 		break;
 	case CS530X_SYSCLK_SRC_PLL:
 		break;
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index b325847036e9..165adb88f4a4 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -52,10 +52,6 @@
 
 /* Register Fields */
 
-/* REVID */
-#define CS530X_MTLREVID			GENMASK(3, 0)
-#define CS530X_AREVID			GENMASK(7, 4)
-
 /* SW_RESET */
 #define CS530X_SW_RST_SHIFT		8
 #define CS530X_SW_RST_VAL		(0x5A << CS530X_SW_RST_SHIFT)
@@ -79,9 +75,6 @@
 #define CS530X_FS_384K_356P8K		4
 #define CS530X_FS_768K_705P6K		5
 
-/* CHIP_ENABLE */
-#define CS530X_GLOBAL_EN		BIT(0)
-
 /* ASP_CFG */
 #define CS530X_ASP_BCLK_FREQ_MASK	GENMASK(1, 0)
 #define CS530X_ASP_PRIMARY		BIT(5)
@@ -95,11 +88,10 @@
 #define CS530X_ASP_FMT_MASK		GENMASK(2, 0)
 #define CS530X_ASP_TDM_SLOT_MASK	GENMASK(5, 3)
 #define CS530X_ASP_TDM_SLOT_SHIFT	3
-#define CS530X_ASP_CH_REVERSE		BIT(9)
 #define CS530X_TDM_EN_MASK		BIT(2)
 #define CS530X_ASP_FMT_I2S		0
 #define CS530X_ASP_FMT_LJ		1
-#define CS530X_ASP_FMT_DSP_A		0x6
+#define CS530X_ASP_FMT_DSP_A		6
 
 /* TDM Slots */
 #define CS530X_0_1_TDM_SLOT_MASK	GENMASK(1, 0)
@@ -163,22 +155,6 @@
 /* IN_VOL_CTL5 */
 #define CS530X_IN_VU			BIT(0)
 
-/* PAD_FN */
-#define CS530X_DOUT2_FN			BIT(0)
-#define CS530X_DOUT3_FN			BIT(1)
-#define CS530X_DOUT4_FN			BIT(2)
-#define CS530X_SPI_CS_FN		BIT(3)
-#define CS530X_CONFIG2_FN		BIT(6)
-#define CS530X_CONFIG3_FN		BIT(7)
-#define CS530X_CONFIG4_FN		BIT(8)
-#define CS530X_CONFIG5_FN		BIT(9)
-
-/* PAD_LVL */
-#define CS530X_CONFIG2_LVL		BIT(6)
-#define CS530X_CONFIG3_LVL		BIT(7)
-#define CS530X_CONFIG4_LVL		BIT(8)
-#define CS530X_CONFIG5_LVL		BIT(9)
-
 /* System Clock Source */
 #define CS530X_SYSCLK_SRC_MCLK		0
 #define CS530X_SYSCLK_SRC_PLL		1
@@ -207,11 +183,8 @@ struct cs530x_priv {
 
 	struct regulator_bulk_data supplies[CS530X_NUM_SUPPLIES];
 
-	unsigned int mclk_rate;
-
 	int tdm_width;
 	int tdm_slots;
-	int fs;
 	int adc_pairs_count;
 
 	struct gpio_desc *reset_gpio;
-- 
2.43.0


