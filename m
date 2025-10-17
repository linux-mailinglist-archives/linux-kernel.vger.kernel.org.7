Return-Path: <linux-kernel+bounces-858408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EEABEA9B0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4787C1A66BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7999327A45C;
	Fri, 17 Oct 2025 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qa1/4QY4";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="E3LC/SKG"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD88B28312E;
	Fri, 17 Oct 2025 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717779; cv=fail; b=R2ccNxuTm7E8Ap3STbKN4dzJHuVgO3YMo8P2yHhzMExO+pIi9kuaTK50YcQqXEPPw2teQGJu6mLGGppCHfADuvfQk6N0fmbKQos7tWBMG1cKuZZbK0YdMV6Y85SMP+nZ5k5xFT9SiYFSL3qeomqKsQuZdQ0s665u7AAb8A0epQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717779; c=relaxed/simple;
	bh=5MbjxicHLwnGNMda2kCOSyZxtPBWWjv2zl3BsvOJQrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daYNs2y/Edu6EnvF3awBFFA0kAv7OCQmOZxh4I/aJfYz3OA4fC4Ar5U56qRG69tjbUCvQWw33Vm+Jm+a1Evq9X+kTaO/C5L+51CEoMkRHI2EThBtc5xTzeK+jTYWKzlD5LCVvOy1lLpHmpmrjv34JG1S9kJstacZuAoERYqzCcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=qa1/4QY4; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=E3LC/SKG; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59H0Ya1x4020959;
	Fri, 17 Oct 2025 11:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=u1cZjPoXmSxFu27qCu90v4ejFktyMRictvKJOqrR3bQ=; b=
	qa1/4QY4zjLWNk8ZW+Zfvx65GY5gWcIz9mh0i4BugVBtWam7p+ILRwnWUV1KJRo5
	iM/iBuIMewQQUuhCxCSQoKcHz0Pa+BQaM1f1i5WrccI7oDRUqzAJVQzpS2cRDu4Q
	QpY/OW08RiFx2jSds5OaSMOdbo1Fr0IJVUxrsYnyFn0VZz21J8Jbo3Gi0Xt+CguZ
	H6iQoZYdUeUlkxmHX97b0HpyVvIbxahZYKBoTqwRo8UoiUAucr4MwY57Ha46EneQ
	AYixN8bLCKid9sWtfCQaGnpyd/uHddmFpYKCievtP/iJlDX8r+13ravdTpSpmDT6
	okmNCVzj52k1t/AjMMdZWA==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023086.outbound.protection.outlook.com [40.93.201.86])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49ubc98w6w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 11:16:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkQH8bpQLgUAr/Q+por2IWncwq7LkPD+MJ8+xXsHwurWU4p6e/N8pjgE5mu5xnDSLc6L4wWVpm6ukgP1RYje1ijkxAOCVCJjZ0G+c1aqH0m/8SXNY86U69VwXI7YGW81e3FBdR6aJcvff4tzKaKGEzKslZlAmRf1guIVdbLAtNYJp6dgle0iPrlw4TrA9s9LlqVXVlEESb+E9lT8VRgpWiOeCjn/wzjgxhTWQuH0yXIFOBbdcbJjxZiGDduZ0Ps8+TDuDlH5WWCqrTydOyzyWhEnRu4XFkxIGSzhxcEgzQaE9JIeDywTSTl2S0HR2nDRfz9jxxRFRnet1aYIdtBbcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1cZjPoXmSxFu27qCu90v4ejFktyMRictvKJOqrR3bQ=;
 b=RDsg7JiIX1Gl4s/h8gk47ezIHG35DTEjq5xbY1+/hQyKu4gejbtp4qiq+AWQWkgcQyZ0ezPzv4NQHx4p092vJy0V8pf47XG8xdTHBdlBH51048XI6S37IeSC+S41nKNqPfuXGXILFa7C8qbc4dBkg4Zh8VnyF2Czyky+5MiEkqTUVLRsei02zbVvv8nvIpnGNshr8tuMfc9PF4HE38g8SaxQt4dci2BbEUWsPrSKcn81TpYRzAU6K9MPQtJ1pNYjnEXsIAiXmHuF6ETSBYFc/rqdfY5dmqhv2P67k6WWoAydXDAkV2E3X1VSpoKHZgg2EHWxrft8FzkTa3z3uRBNRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1cZjPoXmSxFu27qCu90v4ejFktyMRictvKJOqrR3bQ=;
 b=E3LC/SKGHyJAFC03LGE3lXKLo9GjV9EeEiAeHqb9m8hjt+dpchqsYgEsSj1/OL67FyGUSe52iii/UIcYcLRjxOCGINbVsITzhulhyht8pKRUXZQIsGVLAcy5yrCv2YqyZWugT5t018ONC5EGhg1DUacfMUbcJXwLDdNC/OmTNJA=
Received: from BN0PR07CA0016.namprd07.prod.outlook.com (2603:10b6:408:141::21)
 by BN0PR19MB5262.namprd19.prod.outlook.com (2603:10b6:408:151::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 16:15:56 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::3) by BN0PR07CA0016.outlook.office365.com
 (2603:10b6:408:141::21) with Microsoft SMTP Server (version=TLS1_3,
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
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 16:15:55 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 286A1406555;
	Fri, 17 Oct 2025 16:15:55 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id BC94D822540;
	Fri, 17 Oct 2025 16:15:54 +0000 (UTC)
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
Subject: [PATCH v4 04/11] ASoC: cs530x: Remove unused struct members and constants
Date: Fri, 17 Oct 2025 17:15:31 +0100
Message-ID: <20251017161543.214235-5-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|BN0PR19MB5262:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2a1a2886-8971-4b11-8737-08de0d9873ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MDHqvwC1l2qXFCqYotKtaQwBqTUPTgSHqmY0Y94QPjBUJd3fcKzs4rJlhbpY?=
 =?us-ascii?Q?nRQVIRhe5m/p+9KkZXLMfk4XIikwMoCdblsD2S0Se5iQCkGxs3Xt6bDXxrHz?=
 =?us-ascii?Q?qw8t1rY0eI41YttmNer6Fz6GNtsiOhcB3eDVw/LQh6GymL03DWEdtnpq2Egr?=
 =?us-ascii?Q?znkv3tvlf1ICmUm+ixXm6BaUjOwQ9Z+BTBd+W72WSeHCLi5uo3Rb7EF95ylI?=
 =?us-ascii?Q?0W9xiS1ZuPbRIRuoG3dI3cK1+Cv0CjAasFH3JfNbttxBZ0o2II7nz739MjeW?=
 =?us-ascii?Q?i9gWCT+dpZAUSFDRJTfHFtItDLhXDjhxCMMJwi3OcsJpkyeJ3i/n7Fi5xNxK?=
 =?us-ascii?Q?EMIqTo3Wpm7/WvthjGSdGA4mSa7RB7J1G+821YZpXG/2QFwtNYrnbse1x2s8?=
 =?us-ascii?Q?c+jtZ6APXbAvTODQ/LK1/LRkEmg9fIHoMj/Nr0yG8bd8h+NTjeJ/RbORzCuK?=
 =?us-ascii?Q?5dj7dZtPN/z6LGP+1Lqe2bqDlWjKvvogwQORCtweU/YOSx2iSO/Og3FMglTq?=
 =?us-ascii?Q?u1qh6JdTVrmez+F58084t3y7MEcyRYTQ0pg09pQwHZ77HV9ccW3lhawqxUSQ?=
 =?us-ascii?Q?qAfCCDIfSdB7zXE0y3QzjGT2aWAMqGu3W23RjSaxbca9sJPwNpaKyeZYzSTW?=
 =?us-ascii?Q?70i/vO5QqHrpDt3QTjJecIh7d4KF6IR2HAs95zPGSQrlMd7bI/qyeG+ungmb?=
 =?us-ascii?Q?gioEKGI4A0lVlnxOxrU/wuu5FLpr0oY+1mPMvIp7321H24BJxj4DX2/AswMG?=
 =?us-ascii?Q?CF1DDbYp3asDTD13DIoByVfdF3xSSLDKqalEli72f9TA4pb+WH4Q7bNZCgZg?=
 =?us-ascii?Q?MOmWRaKIaVkp6V69BwnWkodvLFxNFmmnCjhsU+Khl274tx16+1879piTfUNP?=
 =?us-ascii?Q?Ax5eJp55piQtbfyhQw7Ox0g7lcDblwh7VQyFFE5jGdNepTQVuNW9L0nfKdhx?=
 =?us-ascii?Q?fLI3CtXiFXP0K/9xwwXvSJROMbrFz6DbwLBo0vOAWVnIh0Zbr/taNqw7DwSF?=
 =?us-ascii?Q?m5I7gQWS+PIJV+Z5lzjVB3qTxNLY/jlGX7FpTVSYwis7YBNpkiz3fhGZJcIO?=
 =?us-ascii?Q?oPkDCe9GNuKf72k4xy22AoMxplHHDcM2vUW9FuhXbZfWYsSj+qlZbAP51m/+?=
 =?us-ascii?Q?xe/B5HkHj902b9/L8QsmrSwzhTnKRacHGVdZ4FqIHZez6lYPdKPhD4f/X+Nn?=
 =?us-ascii?Q?A6He2rQVpjl3TU7jrWDes4pTeFeJiN+g2tcWe7WIjJIv/qg83BM6/OFp4nXd?=
 =?us-ascii?Q?uZPYPrR4HGIRn9TeuE8l/aft5JWaIxgbRTo0o5DncdwvS4JicPtb+sdnhCAf?=
 =?us-ascii?Q?XwEIJLs5y/iy8+1Abv3ZINe+ipwLBfe3ZzS5SMDjJjPR1qocbBjeouXC0O6j?=
 =?us-ascii?Q?GBNxqZ/f6Vi6DN8IObbqpPrqkBwJJAsAN9CR7TAooD1XQtNl4/7yL+M/sMDh?=
 =?us-ascii?Q?NIFbB1SAOHb+Ox22TEdfhPJSTbnDhZ3gDtCkoxLhEKxW+N2FhnF2ysd/f0x2?=
 =?us-ascii?Q?EfE4YFcqxKxYYrWwq0h2iQzkajCAAp60bM7oUEiNTXY4B0B0rceuOsv/t0UN?=
 =?us-ascii?Q?Qa0GOjZo22MolFBEKIs=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:15:55.9962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1a2886-8971-4b11-8737-08de0d9873ca
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR19MB5262
X-Proofpoint-ORIG-GUID: asgEG9YvzI9O-8UpUxDEd-5NYZ4MlTee
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDEyMCBTYWx0ZWRfX+tPO1dEurgkP
 DUoRtwvsV6ATno/DmhoTxcAfL7P2nPJt0rTr2FWO/wp6xrEKcLJ1AgPEW18SlazJDrf+J2Yna4w
 i3ATj/TQlUMoZzcrjqqjbN2iErvLl4v6MLTmM74NJV60r+zWs/KTbuXlReGmjVi0Nd7Wf2eHup6
 83EPHw3DGg1CNnOALggknRwD9tgDHPCHeeOBwN1jUb7SkeKTn4N8e+R8NbLZZuBrXSsO6VHaiac
 WD3Vg4uGCF8sEn9t6uskaYMRuGEd7deET/nJuAtu/WoxRgyFRqg5Qxgw4QK9WMQuc9giVw7Iq7K
 Uhre7MmXHoHV21/rDIZ/oEFOSCT/j0+mzRVv8ZA/5L5xC2gNcYDGHmTRpErW88cyhbrcRvzTuig
 gzeXAWsqcnaSGDwvM3cPF/ACJQk75Q==
X-Proofpoint-GUID: asgEG9YvzI9O-8UpUxDEd-5NYZ4MlTee
X-Authority-Analysis: v=2.4 cv=H7bWAuYi c=1 sm=1 tr=0 ts=68f26bc0 cx=c_pps
 a=abZUFfWgJRaQ0xfFFz1/lg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=8v0jFsMaT9EysKbcgnkA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
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


