Return-Path: <linux-kernel+bounces-856648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79715BE4AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 483014F61AA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213F7369969;
	Thu, 16 Oct 2025 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="e5ob8tlI";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="baEQZ8RK"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B74D341AD7;
	Thu, 16 Oct 2025 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633360; cv=fail; b=oYeTPwWqSFcYpBYR3mtr1HRoW9uBMsLM5Z4nOjjFnlK1cRUzxpCx7Atu3NLpES4/fbgHGcjuKlaCaQKv0qvetLIcIEEB7vc2vfiDwHWU+vwa3qYgGLKvaubvG3JzlGFgxxm41Ras2CcteugOHpgwhNm3TXxobn65XI4OaRVLAT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633360; c=relaxed/simple;
	bh=5MbjxicHLwnGNMda2kCOSyZxtPBWWjv2zl3BsvOJQrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5nl1qEdf3fMZcIbwigsvZp6wFZmaZ6ms1PEInQxhnIW8IwdVkZV+wI85IBzyPHGzN9Ja8dFACT2z7gGutl4nOf3ppNFXxBy6js3htfFLhCKHeJIukxhVj3ijmIwt0ythhtfS3zdMXjSBfgRZNfWPFfJY9wD9MfXlXk/EPrkFhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=e5ob8tlI; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=baEQZ8RK; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GDTFSt4017904;
	Thu, 16 Oct 2025 11:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=u1cZjPoXmSxFu27qCu90v4ejFktyMRictvKJOqrR3bQ=; b=
	e5ob8tlIEDVHsHxBeHHFaVzKh9aUAYjsio0KwLTn0p7d1oaMOizj1E3uKJQbLz39
	3xlzujspVD8qrBBV5dyWkUCsVLQLXrc2NOjUqPTyuZyXyLv4+oe9wBxOoy6xlJ7S
	Iz/eIFAC6KW+FxXnZpZz53jLCsjbMpmMQbYMh7WIMkZzq9rH4tYyD8ZDno8dV/bo
	IwjJnBJJUh6WaHAUlZazhYZRtBW8OfZSWRdsMATU2vamtuvnKQMjkc4HpC6mNpd5
	P/8hohmVR2vgh/kPT91ZYUjjYnMjIL51PCe+D6xI3WY6GvtzxPZ/hXa7JpyBqI3i
	Tuh+EH7FuUiqvjqTohOo2Q==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022100.outbound.protection.outlook.com [52.101.48.100])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mngak4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:49:09 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkVA1OqRbJxEyC8qUxvPTJb62c5T4OY3UA/knHhAQGdseft6uNLSgtIAyvdNmKe6I4YNe2qLB9Upsn+4HISTGbdL6d2LhmwkehA4zoaXFNOtFug84HsKG3qqvGvSwGPktlmRR1EmimsWA4B4VZH6I6YMMb9gMLBZldtd+GmPq/G8MU0yBIw4JTf5XQJAIZ5YC6SydxOe9skhHP0gfPgGPrYTkMNCuPf6IuxjHDOV32BuLoVrIcp8iab+5j3+dTM7hIxdMO+CjLQXIXC/fjzda6tPFxz76BKbJoVUNuoZ4ex2kALZsjki0BEq7ZCYZnaLbdcg7UsusWUHXboup2MUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1cZjPoXmSxFu27qCu90v4ejFktyMRictvKJOqrR3bQ=;
 b=KDrwrFB9XHv5iWhBVmRNCU+qT3YIuiBtSgCF8zLa18eV4sThwbk7Cd/Fh22GtrCLOIhFcRRdi2bUi7aqtEl+Uum5ZRDrL8FGQdLTHffoSjh60gYslxO+NLqgipsoUCy8V3qkOqegz91HM6N34tBeosw9TeQ/AtYLj1jRYh5ImRRqAWA0vsn3MWRx4oAgs6hdtytBy6xwrIPGF0OZymiJXhRVLLWBLnDncxNAb9arWdoZciaatXPhLjwDNhPDzXNDTD24r4hfJjZRxxBp8uyYq/2mlaKmg/UrGzYh/v1ByAFmSQ4YT+m0UrKX2SsacdreeR4OZDNsD5xq4sN90+KC7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1cZjPoXmSxFu27qCu90v4ejFktyMRictvKJOqrR3bQ=;
 b=baEQZ8RKT0dYcqZ3xt4UqLnUDNvD7RRpNAEwi+i8X8ouTaqxrEiG2cWRbFK1bD+msGKpYvWU+ATo8k08IwiHq6QJacL3Yk1gA3/I/Z8UCGYFLzyWVjSwD5BeghGq4rl6WFy7Yq9NSEmSw2TmLlPRax+oO3NFRZ5iMKIu85YTw9M=
Received: from SN6PR05CA0028.namprd05.prod.outlook.com (2603:10b6:805:de::41)
 by DS7PR19MB7627.namprd19.prod.outlook.com (2603:10b6:8:e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 16:49:02 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::b) by SN6PR05CA0028.outlook.office365.com
 (2603:10b6:805:de::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Thu,
 16 Oct 2025 16:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:49:01 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 07AEE406555;
	Thu, 16 Oct 2025 16:49:00 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id A62D7822541;
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
Subject: [PATCH v2 04/11] ASoC: cs530x: Remove unused struct members and constants
Date: Thu, 16 Oct 2025 17:48:22 +0100
Message-ID: <20251016164847.138826-5-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|DS7PR19MB7627:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2ff6346e-7bcf-4722-1a2e-08de0cd3e902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5tbVFM+XMaEHNomHgKOmD/oeIVWsmRpQs+1jjyqfZ+6wHLZZjVGxlm/mJgxb?=
 =?us-ascii?Q?FuRw5sr+r5RbNNHL0tHh4viim8lUrmszX5j9AkKZARxjGeZa1tl9NyW2k0EC?=
 =?us-ascii?Q?yQVVRvAt5ewB9ox8rLOjr84wWPP6NQzXjvrDC3moAXH8sJZHMQ0Vyl60ZYkG?=
 =?us-ascii?Q?l2++Ff4wg7PTGnUllfPuStAtqzCbU5OcxDpcY+IJ7pV2xLLb1yxU4nXnWubV?=
 =?us-ascii?Q?HuvhA6qz6JuwC4/fk2OuMq7XYLj67WzYHPt1K/C5gmPlQ+MulZQeZgcvtFvu?=
 =?us-ascii?Q?24PI8UtFoqH3VYY9zw+W2LmxDKXTPIx95PcrEbRK4yOymDRjkoftIvG2gRWD?=
 =?us-ascii?Q?ACPCojgMFefzlweaFa3f8sNVcuYcOY9JkDUg4MhECZkt1KDZciIuCez0v4aw?=
 =?us-ascii?Q?2junP4UMqvw1hyRapIbeoZGbftRu9o1xaPqhdKZ9ykXSMFQ6oVm2h7Zc20Un?=
 =?us-ascii?Q?ceXnDWFDouumpPjWpaSdkZCbi616WW94a6coICGGxrNSXXvDQIqkuror52b3?=
 =?us-ascii?Q?BKBLwVqFq75fFX0ftrmME9rmbNKV5QcuiJIIk5mi3RUy38875vSRthvwAfbP?=
 =?us-ascii?Q?xmWqET5OknA/2FpO+PwCiP7WFrNE9tcnEv+NtfbwFH8wYgTT2cc1Baz24W2x?=
 =?us-ascii?Q?nA4umZbe2TBV7UX3nfIchnzwNhbbvyvZsRR3qQm8cP/KHrnmvdQn71hzgtWr?=
 =?us-ascii?Q?NkpC+c4xrdNbVxxMeKZTjaxdOTQXz++P9u0SAP0fQKY+Qapyv4ek3mIbV3+E?=
 =?us-ascii?Q?VNS1doe2AGZlyrNNewqPQH6S+vBmRSPHW8ko95edtDESTvDc9s/MYnbkNtgr?=
 =?us-ascii?Q?RVDR2yPqRuNst2FZ01bdACwUeLE7IQ2Bn2PSz6lSbdxih90CAxNQ2LdfrETf?=
 =?us-ascii?Q?pzds2IPQRqP+cX7IW7CsMwb9rldrST2kDkRVUKRv4tRozdMTIP8rPgKyIg2g?=
 =?us-ascii?Q?dhlVMpRYCUqHNxnfEh4gQndAiujAzYmuHt6rBfFKyp7pi6TULehftn90Lzyn?=
 =?us-ascii?Q?B4zUcQkjqLFi3UPvm3JLaPUVP0BWjRLk+dtxP27nfLbB0Lg5TrU53neD47Mp?=
 =?us-ascii?Q?TzneAjsmhVDdosK2204MHBvD275VbZticw0oJVcqjxe+2lxOQOPIhTUTO4CH?=
 =?us-ascii?Q?tLg1Qvv54GFc4INzZNDVuL/SCPyvvLlUnDCx139fodVNyu6vFsXx8csFvF4C?=
 =?us-ascii?Q?FOt77x4Y05tMnSbezhMIeeUoe12Hf0JwUr8NeaZ5b+I5cSBeZ9DhnWJrMns7?=
 =?us-ascii?Q?TcQyizjdsFIFCbd7T0jQBofKRScdXZxxRnhQJqYFlg5yJv94qWD9ynO1jtzR?=
 =?us-ascii?Q?NDyv0IFMiqadPSN7T/dFyBeEL0laLX2vdz8elqOa0kJ7X1ptKhIee3r+gtZo?=
 =?us-ascii?Q?Ou1tJWioG1LnqhPRJ6wC5MCHKd7Fx8RZkEQe43V8qxrAyGPsHgFo+vZYQbvY?=
 =?us-ascii?Q?sK+NvQx2UmvgRucq+5Hf8iSgIkb8SiQH/4HokTyB3fhXOD8JIKpcSEP2gYTQ?=
 =?us-ascii?Q?3lxv1TBwHRwCkHZ+tZcyI0zt3QhS13MwuvL67mCCKeljRM7biaGsvBObR6Bw?=
 =?us-ascii?Q?1YcJyJqrw53kPhLNYGE=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:49:01.7176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff6346e-7bcf-4722-1a2e-08de0cd3e902
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB7627
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f12205 cx=c_pps
 a=Cp5ldMHt6+7N9HJPz7VB8w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=8v0jFsMaT9EysKbcgnkA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 4_BoqJwOLeij4HGQTKShmyeGEZuDk6RO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMSBTYWx0ZWRfX+qp24+zgKjEU
 F1HGy9UbQu2NmcLaR1/vVo0y2gl3zVHPdKan5gb3qqcf5CPQejpm1YQP6nAW3M+nhERcJakhO/Q
 EzkVVuke1Z6jswy1zHtK0pb99bBj8mQGVYzNZgrSX0J7qyxmHDifFTHE52F+WKhV+gozt4R3fvJ
 degkHrEQGssMCaXuJsBCCLtJftMGmB3XKrVQcxtKTaFk7RLyc5y46oQPKtd/RSC39gSU2HAGwmy
 Bz92nQ7TMeOSVfpruVrcU/CRUWjmEnE8K4tITaREPTvSJjdOveBYd+BWj2s9Wd2P1V7Vfwu/ib3
 11SpxJTCBhCqtgkG0c5ogc3n4n0xrSLH0HFVI7NkMjcNn82nthr88j9QkHlKhTWo21gsOWcaszu
 3xnPPevAgeziM6WNUtXeVA+/ThQyMQ==
X-Proofpoint-GUID: 4_BoqJwOLeij4HGQTKShmyeGEZuDk6RO
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


