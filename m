Return-Path: <linux-kernel+bounces-866555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B307CC0014A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532863A4A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328062FB963;
	Thu, 23 Oct 2025 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="A4lGoWj8";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="JwK2S30i"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC162EA15B;
	Thu, 23 Oct 2025 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210239; cv=fail; b=SZTdPJwANH7rPTZgkwCdyA16CQWuC3/PeENwGXYwmBdW4+3PuilowbATqSCvRq/uB0VHlPIazFZG+CYdVGiRAo743Hs9Cc6IAqYDQOZpSSvqQTWxF4TIo5GTLkZAT1uiWdZ3ETepwAA8IUjo3kRjOfaH+Byfvb5IRf1lhpgVBDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210239; c=relaxed/simple;
	bh=58Igzqo8xPvA5GczFjIdPzhCfiyLVgtxCDASU6XfFrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dwyDpLJKId2YZKCUXdoZmzK68K0xzYjHLvU+jEfzd2/SeQ4+nD4ztFDqypWkMo8r0wRiMvLtMPTG6ZLQCnZBw5H5DGxOk20kUDr10FWh20Dppbdx9V8zlrPxQVCmw6PpT2fUP8XiVnU+f0GKwsLxF5FYhcGt74LLJcV6kUe7pqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=A4lGoWj8; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=JwK2S30i; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59N3xgFh3465752;
	Thu, 23 Oct 2025 04:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=s6N25oPFsBmRPjjfuO3BEgscceGN68YB7QwHApGCrM8=; b=
	A4lGoWj87JTKbxQgR/OvGHjfhshVWy2maduA0LdfaOHvjGW9AgYKT3xGObHVOcxN
	B3ftib/EDG8MOWvFHg5j58xJDdpN3SrI/TdWP0PB00EGxPqkzkCsLGXlAI6oUJvo
	e+zmXUW4kwrdEUEkaa1qR0ckatpuajBXhqsgWJHlihL8h1e0pmxnjahqmprRiqa1
	tYaPNXNqAVNT1hjly/xrGFIN7ordieYLEtQoc46aPMHtiguxOF+kstnynGxfvWQv
	YblaR3VGwh+DPhaB4gIJE153YTB7CSfPSvmq0CY/tC/lHMgoT7Rp9iFgqTaTtWFH
	vX4PU2obK5no42YtPI7xlQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020118.outbound.protection.outlook.com [52.101.61.118])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49xs381v5y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 04:03:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9xkyEU6cMqVpIzc4hQak5yhArbsfE7Do9jKwVUcPuBCc4xMcgEG9X2zrO9XM0uu+HLq6QBxlfrrq4eI7xA7eryjLA2/LHMYY5j8bPKdb38MYVak4n/IQJJbLDqIL57Cw/QPXAaLCl2pFiyzq1Bp/d/zUVhT70x1DQTkSdkP7FYA37BPbeerxIfLgTegbf+nPI3ORSriUxE9ZRmKWqsoCSq7G4ivQ6Ng39Fe+sLaOUScjoTFNDa17+fMpg5kLY4jk2YHxwYuLK/ZsIxIDlHo40foOH2BmKzy8NxURVT4COSYSPkUzvksUTTeGGPV2M1IPIT8XzRoVK7ZXZQ1W9EZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6N25oPFsBmRPjjfuO3BEgscceGN68YB7QwHApGCrM8=;
 b=jlR85ygqkjFpiQr0Jc/+qB+EH1q8SEdQBMn7gEoBPXj4FPxZKsUPcJFK4I7M/hef/Pr2LglWVeQsV2Xlt0ARdyQRTqK+U0KqBUQ/HQUMcH5I8mtOn7bqJWLSez7k+eiRhW+cl8Fsu4SfPnAViBLRUCQDBhQa6sDrkRkawKz8b4aE+ET7YOyv0+4ySSsUOexJgs8Pi2kpAA38obKr4C30/QCF5yhpfhij+6so0rtVc/tqmjmKnstGK4SFmFL6ONBomgwGF2gFo28cuUklRC5eDA0LS5Gkw/HsZ+nFauTT+SpK17XD3pJpkz5b+mmWkMflPMOYnrmyW7JJJdXPbiecvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6N25oPFsBmRPjjfuO3BEgscceGN68YB7QwHApGCrM8=;
 b=JwK2S30i0LXyq4CyqtOdAuF+5LBXcza/ooHVuKYwuvZ+ZZct5FJpas7Snef9Hqlkyl1dYKulOVtQJNjQS4prCpFYgy4oHlwyfpSJ13qiT9uYeszuqrgL3DNS9RCFdSElQSlOdkb60fegzAtfI2doEllBxOwPC7RnuB6PSWpmF7Q=
Received: from MN2PR14CA0013.namprd14.prod.outlook.com (2603:10b6:208:23e::18)
 by DS2PR19MB9244.namprd19.prod.outlook.com (2603:10b6:8:2d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 09:03:41 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::17) by MN2PR14CA0013.outlook.office365.com
 (2603:10b6:208:23e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 09:03:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Thu, 23 Oct 2025 09:03:41 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 710DF406552;
	Thu, 23 Oct 2025 09:03:40 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 17CBE822540;
	Thu, 23 Oct 2025 09:03:40 +0000 (UTC)
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
Subject: [PATCH v6 09/12] ASoC: cs530x: Correct MCLK reference frequency values
Date: Thu, 23 Oct 2025 10:03:17 +0100
Message-ID: <20251023090327.58275-10-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|DS2PR19MB9244:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bc642b08-b544-4095-cf61-08de12130ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8M3dV8wEXDQ10jMGKM2CN3QBoBS1UlHhWUUjRav2oQGqy8xVODTS6+PPiSF/?=
 =?us-ascii?Q?V9Ex6wvLzypWS3TJUCFWK1ClCN7z2UTvNi7KqmVKdSKo0Iw+yqNv25QokrzB?=
 =?us-ascii?Q?de+TEC0D85CPjYI2U7C752EOIZBmvST53Ek0ulDC6Lz6z94HnIHyJdbCjJ0j?=
 =?us-ascii?Q?4GlyVjBjyMrjrQEGuB16DRMZ800V+1s77TyPEpOOoU4BSpZyQaT2EV6i2M6R?=
 =?us-ascii?Q?KN4bb/Oan/8KIeuXokrDV9z9emieNrWfmgNTWs0pseFyl1ujWMg0fm9toUwC?=
 =?us-ascii?Q?9i5H4AnjMUAKGiL++H9vqht9AdrVBxwca3QSLcw69+mOGq8RZ4U9DkDvdF32?=
 =?us-ascii?Q?vQLSWQ2TOeNAo3tdRbx0pIqMxq2w1d6DSERXhDofgNNu9p3eTGZmHvQtshnZ?=
 =?us-ascii?Q?mj3uwmrI+ARpCR860izBM1+LHwQIzxEooioE/o6U0pWQeaUSxp2DqZOwUsyG?=
 =?us-ascii?Q?QDV4IPhWpL0K8QeJgAPR0gpVUnfItQkMlmxgd3WIPTWfk7tMVk2+vwU6cgkL?=
 =?us-ascii?Q?q9us7H/0uAdhyZ61YTFE6ItGSJo12+Hpd++TYnumqvd91VShgJLGV79GDdXr?=
 =?us-ascii?Q?ikgWIaJxiXYsjiT0ZA5DsJa9/uMfl9HvGRVMRDqcDmF2bTdbCXGV3MoD9mpV?=
 =?us-ascii?Q?iuM07X0nNABBoWyLcDKQtjwYGlLARVvs9cJnh5aAlpouGx45xcOwpY0OuiBT?=
 =?us-ascii?Q?ZR3ffnF3wiHHVnzA80erUEQgJ2ZCbBfE6/zubF1BDceiCOzo0Q0IdlQw3qh/?=
 =?us-ascii?Q?2DZXpqu81ON8hD87fCZNDq8+nIEhHsqBzdxXYAUl7GMaV0DZfVwhffX/gtbZ?=
 =?us-ascii?Q?2OvHIHNBezkQ49+q3TGIPxDMqKacJuD35QBjM+48yXUKRhAbumKe31vYIQt6?=
 =?us-ascii?Q?Vsn91+oLBxvAOxWvjb9vPHiVhFOB9sQNL8XakPKuZJ4ssDhYXFvIdF9qlb4X?=
 =?us-ascii?Q?LaIz/RIH0y0i3Zr5sbud0NpM18qOLhfw6Uoati8OCkS3t7Z6LSVF9O6qb/t1?=
 =?us-ascii?Q?lyFNPohwaiPOmIOYO6OV9oVpcJjWQECr2HIFj0DHGke0MenvVzF9akrz7WSC?=
 =?us-ascii?Q?s/5nUnoDx8RFQUdAOEhB+3f0ld1U1zY+dvU1F1W0KWw57UcVCHbxV4YL/1ik?=
 =?us-ascii?Q?552tPDAoKpnttzlGmeTrpDIRIGtjyFCLqe6IotLVpKIldQF7qQpZW2Og+G7w?=
 =?us-ascii?Q?IKGFLN6MKdV0BhhTH2lWSNWQI5275dlaJvlO7Ud+5CfFsxxgGsWW2c0y8tvO?=
 =?us-ascii?Q?lY/eJ7yrLSeXLcfUvHCEAKDSzGna7DbGhZTV4dbDNR8mE6w7a5rsGveR8iFr?=
 =?us-ascii?Q?ApIm/pNVWqPyEal4vur2M3Iqtbt3uJdLamBdGgV8KESAgsoV/mJCBGIfohxq?=
 =?us-ascii?Q?UpooD6b/N+SHejw2tnf8lamZUbB217Qta1x+/Imba4EgIQsdJU4zqlImxjfG?=
 =?us-ascii?Q?/VSqFvF3F9EZC1FV8PeAe8MT3+mTHja9wtBj8mnLIIZ1EkRckBigwnhYhWAf?=
 =?us-ascii?Q?Si2FmhV5t8LSIlWsTHkXAD2CBHV9omP1fw5fjyeFkc4ZFLVUk5BBGsJW1O0/?=
 =?us-ascii?Q?0A5Tfy/OxKq6c5pB128=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:03:41.2824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc642b08-b544-4095-cf61-08de12130ff9
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR19MB9244
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDA4MCBTYWx0ZWRfXxCLkNeCaLz96
 gSAsGFNZPOvEIgcqpNmt3YKNpVOKmCBGatpDYR+69Be004Bx7NWe9o9XosSd1cYWhGlYb4hnVfs
 pvZI6U50LP7FTDRrBEz2obwx3Q7hG3FRcDEF0TCWeXa4Jm+5fmQknonu5ryc5Np5onbLbcTUiLc
 XbMarhmLschQGdaqGFx9UGTZ8LnK0yE0TUQxVn9TuEXjH3V45MKEbqxOFUoG8XbzUxmBIhvI3M5
 Y5/unegp57Oyns98P+iRJkQSw9CDRnk7lRk3Qn1L9DGNGTjECPqUcmok4Sp6hzwnkx2lOkClnaL
 Esd+1CX4VPnAJ0kGl5ds8T+vuXTuoNIK7MaJwJZeduHT2d+NH00PSf9sJtwf+AF9FAFJXHkdyU8
 /oZGbWrL40yJibD1tMQnbltCQrGWRQ==
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=68f9ef71 cx=c_pps
 a=fMm6ob6OrxBSxP8bamoiPg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=_mdxinBoC9VrpwbbToMA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: G6VRkq59HxI_5KHJHSwAPu9JYZ_6xUWv
X-Proofpoint-ORIG-GUID: G6VRkq59HxI_5KHJHSwAPu9JYZ_6xUWv
X-Proofpoint-Spam-Reason: safe

The MCLK frequency must be 49.152 MHz (for 48 kHz-related
sample rates) or 45.1584 MHz (for 44.1 kHz-related sample rates).

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c | 9 ++++++---
 sound/soc/codecs/cs530x.h | 6 ++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 7dd9e5d19336..19fac4a90368 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -1100,9 +1100,12 @@ static int cs530x_set_sysclk(struct snd_soc_component *component, int clk_id,
 
 	switch (source) {
 	case CS530X_SYSCLK_SRC_MCLK:
-		if (freq != 24560000 && freq != 22572000) {
-			dev_err(component->dev, "Invalid MCLK source rate %d\n",
-				freq);
+		switch (freq) {
+		case CS530X_SYSCLK_REF_45_1MHZ:
+		case CS530X_SYSCLK_REF_49_1MHZ:
+			break;
+		default:
+			dev_err(component->dev, "Invalid MCLK source rate %d\n", freq);
 			return -EINVAL;
 		}
 		break;
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index d11711715ba8..2c773c4b6b92 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -200,6 +200,12 @@
 /* IN_VOL_CTL5 and OUT_VOL_CTL5 */
 #define CS530X_INOUT_VU			BIT(0)
 
+/* MCLK Reference Source Frequency */
+/* 41KHz related */
+#define CS530X_SYSCLK_REF_45_1MHZ	45158400
+/* 48KHz related */
+#define CS530X_SYSCLK_REF_49_1MHZ	49152000
+
 /* System Clock Source */
 #define CS530X_SYSCLK_SRC_MCLK		0
 #define CS530X_SYSCLK_SRC_PLL		1
-- 
2.43.0


