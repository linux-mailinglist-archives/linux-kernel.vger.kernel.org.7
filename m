Return-Path: <linux-kernel+bounces-866782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92467C00A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E5514F1CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B6E30C604;
	Thu, 23 Oct 2025 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PqYNlnTY";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="lWoxM68e"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D6430BF78;
	Thu, 23 Oct 2025 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217727; cv=fail; b=Z6wfliQ7hlIVd5njrrzvvAk3MgHOzaQS1DJdi0++8PXUZa762R/oi0Vrx8eCJlqGlV2t0mfSoCeppNaXCYzEC5MBi/RWBVhVFzyAS5Hp3rQc2Tnpyc5Z89gUVbDY1n+vKSk9LfH+ChA5JOMhlZey4rZ+SSbbZo8YImor+4a2NoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217727; c=relaxed/simple;
	bh=DO3/FAlwsnHZvJLBXwpv0rzklj2ZMlvWIMt0s4gMIh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SFvy0Y6kptRbBye1hjVj4FvN64dLJmSlCcOPPxujzjdJrJoGw7orl9+SUobub+TefXo4ab11X7QYciZFF1eCHEnN6qzKS5ZZgVKsR2pVVjyYDyXzg1RDFOnTIBuFkncKcRbmJTuu9d/63F8Zg5Gsspr7xsZMOP5xrOm84dsRRi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PqYNlnTY; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=lWoxM68e; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59MLKMEW1194831;
	Thu, 23 Oct 2025 06:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=/dfEz18T2J6quGJK
	jWgo1Q3raKJ+33SFCWf0yPwZFwI=; b=PqYNlnTY4C/P22pbCcVX3SMOonTTqMAM
	aveIugtdogQouuV2WeRylCEgdTGHFw6SjUlrnaecwhQE8za6+U8kmlgG6xk0O8Yu
	gkmYTIKuzRsjAd7w4kLd/fIP9Cfs/fkxD/FUUeky4nVCjtGhg4JWRyyyWaBMXrx9
	fYjmJjgJfxFt5olbPbYM6KKf2oIXYaF/0NmOyXPYVjaICJcGVK7WYCQldaCdqa1z
	Fro16lYcKz0FS+n/83BKgbWIbtOjvAc8wYv0cMGtXLN0SFJNvtYe46UIWCPlmEm1
	UuBgLkg5TRHyg7c7ti7EH0Sp/XHulCnGhdJRTNdpiDXpIAdsoGgdYw==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020120.outbound.protection.outlook.com [52.101.56.120])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49xs3820mg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 06:08:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+JWcxWF0m1pFrOtrFV3zUZtNH5MXaols57CkUBtkuKFSu88QiwKknCAqGhM3msby6zFwNWy+NvAz0C6DH/S73Ak/Mio1J1eYR8WGXxSnY22MZcYOG4uXtJ2m48FI/iL3jMWqSn5yIO8cPNfnroO31XPhGwVTf8HqjmEfGb5bEg5uw8g+gkA3Am6EaCktGYe/q/SgeqWulMrLwClCRSyNA8ALO1jT6HgPEcCT8muNEkTfxgCkp4hRvoZZLmMbcrquaBiizHEyI7M2pm/xF4IusIPdF8UUEj6nEYYXnwf/J99d/eXrQKYlFDUcJRsjMXWdNLatVRC4TZOwHZlLaiJJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dfEz18T2J6quGJKjWgo1Q3raKJ+33SFCWf0yPwZFwI=;
 b=n4PjZF2nu/C5BthzCYfGc/c9k8Mal0nOPDlJnT2O6WnbzbswTd8UuMa5uJcTmwWIfZdaSY47QYad1fR6N1tHE8eb/L0lcaCeq720/akw4APEVf+Czq4LTb2N/jmLFsTP3yv/fX3A/m7/OqYgYltaRDgj3rDip8jFFhMND0wQKTal0i96LDMDEthRJ9NmA63eFQsyWzEZioiepeQz/Q02bEvKi1sJXmKgAyd1hfdCiHd/wd5KPTxe86BGLPVfiZclcSy72JSRFxSb1nCL0WAlBoUFOm/rzj0Y9NuwaGovx8AvynPniQdHyubmgSrtKVWCaBR20Pw1o6RZ7HVparkEgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dfEz18T2J6quGJKjWgo1Q3raKJ+33SFCWf0yPwZFwI=;
 b=lWoxM68eKr42czoW1A115kNV5ye1iw0kn94iBq8JlxZCV8R0dsEGgS0YGDxMewUHvH1AtCf4N2E7NAnJeTp9GyNdagosIRacFcV8PnnIcti1Koldmq9+kynchU/S6zYIgef4gOUK2tt0ro9Ez+sR24BqQiHJC7ulXK+jXMsNFTY=
Received: from DS7PR03CA0258.namprd03.prod.outlook.com (2603:10b6:5:3b3::23)
 by BLAPR19MB4420.namprd19.prod.outlook.com (2603:10b6:208:285::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 11:08:38 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::36) by DS7PR03CA0258.outlook.office365.com
 (2603:10b6:5:3b3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 11:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Thu, 23 Oct 2025 11:08:36 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 01E1E406547;
	Thu, 23 Oct 2025 11:08:35 +0000 (UTC)
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.69.19])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id A685B820244;
	Thu, 23 Oct 2025 11:08:34 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: yung-chuan.liao@linux.intel.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH] ASoC: soc_sdw_utils: add cs35l57 support
Date: Thu, 23 Oct 2025 12:08:24 +0100
Message-ID: <20251023110824.1587-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|BLAPR19MB4420:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: da46c073-c89c-4740-dc89-08de12248349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iRRxT9+ODEu0trMxtqtQtAlDxDvW4tZyxsLb6qYY72Tt77oXrExh5d5oD6jE?=
 =?us-ascii?Q?WugAGdzTMuvHHke1rtQ6/rUzVie0+fhH8JAJhyj/dT42z3Oa02dFMZxc2G8J?=
 =?us-ascii?Q?C/Hj/Qbt4x+/EIHhjLUBER53yehk3SG2nf6sZ8/LcWHUrrT26nDUf0zeFg8y?=
 =?us-ascii?Q?i6GjOEm8CxZzG5YHv9VBQIgWx12JOJEyjH4XZiqyuIkawIjUdahJZpeEf/jm?=
 =?us-ascii?Q?hLDv4M8o2XfPrQi3IyxuF8gvce5ezoc+JRvaLXAYV/9TGP3TqJ5kqT298eUn?=
 =?us-ascii?Q?gRGf/AEkbFGxEWEKNDQohH6/7jD9FLietOrbzzuLWgddiDP/bfu0ChOGgMtB?=
 =?us-ascii?Q?jgCLs6vxWp/X/CD0DNEWR/fw28+TWd5/jD6Z5xkBAJP8Uw84hruQRv55unGR?=
 =?us-ascii?Q?iwzOeRhaYA/oq9WhuZ4ozs1aiQdBy9J0gKJ/ObfyGlQsIlG3Bu1xJ2z8lQ4L?=
 =?us-ascii?Q?aracP2mI/Qmt3O+q481epnoaQc6PUst+/OdV25ZGHy7uGKDSTko978m2IJO8?=
 =?us-ascii?Q?ylpYLM+knfgPHPNlHCiv4QQjnb7M9duQ8StTky0hJyy2IPHTV5nw1rhY8N+q?=
 =?us-ascii?Q?2OggsenqH+vjf5NAScv6FTyjZLmc530QhgYvrHW+VJeP0cvzhDMj9Y2aZD1K?=
 =?us-ascii?Q?2jRXkYxVA2kcc2QKGWSWMrSrOfPUW/0MuzudUKFIOaYdJijtj8EMvStMm6xA?=
 =?us-ascii?Q?fw5jdYKU8cA0j+xI1M549mIf+tJZS0PGRgGV9eSHw5igGvo2KXDR1oilWRHY?=
 =?us-ascii?Q?eQlXhYntcL8VlNo7HugBfRXFwOSBaUofVl1FO4Z2uBbgAVCgToIClMCtC02B?=
 =?us-ascii?Q?mNv6z+IUN2Nhn+sMjLY/BuQRZSJIcwfTOulYOLMuldQKyIf2RaxrtPrUbEs9?=
 =?us-ascii?Q?COzarPC3lZwzE2ttzgc9X1uT4MbAV1FVRjZp1aUsF+aRINJx4uad7iJLvN90?=
 =?us-ascii?Q?c9RKC2xj3DQwdd19zOY1df5rz+K1RklAA8v05nBMBqJeE7EYeyeVBFA0mDte?=
 =?us-ascii?Q?mOR4eRuZHsM9rFv41Ji0EcLmAqaBxyp73GgKDrAe7WJ74/qkvU2nXLXemXAW?=
 =?us-ascii?Q?2GoO+eQgeg1nOCoV5JgAhLcmKJvf5v5Pw6FK/iN7PJIGycxCZdEUf/eTAgTv?=
 =?us-ascii?Q?pDdgJlfPO2Q7odS2c7PaxdNpeSXbWdM2alenj/zPQBmeLTDdo1ym+dkd2Ss7?=
 =?us-ascii?Q?WZVR8F0Kjmqa7i9ZAyWmbUj1GzAMyQU3oFEXRalhMvzQy3bJ1qOCiqcMAVJS?=
 =?us-ascii?Q?om0cstqGoVt6F+7uD/B5Gfp7WV5xM1SqAqDMN/18+EOUBeE5dnSQCVHi4l5c?=
 =?us-ascii?Q?stqbwZAwUz0D8Bgujw2SdbU3D9qZeKlP8nSpsagIcRC3DoTdzyBfnqTN+Jvl?=
 =?us-ascii?Q?61Z0l39CUbpfDu9vDtZJEqehHwhrOKX6LlpcCMdCEro+lk4olXEdnbmpcooa?=
 =?us-ascii?Q?kqTb/5bynTdusIkEs0S5mVmJNK+Xf17ovf4hqJZPqvgu5DJwXEy9xvBKpB9A?=
 =?us-ascii?Q?XMDN7RWtWsylgCVkAujXL2XQIIPe/XrmmzX85Apq8TM5EyQDXndEovFF7BNV?=
 =?us-ascii?Q?mehnF9bBUbwwkRFQO0M=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 11:08:36.1342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da46c073-c89c-4740-dc89-08de12248349
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4420
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDEwMSBTYWx0ZWRfXyiiKasKMTARd
 wUmqRyNIfPkgH2GUd+/oadNn9CO1uGq022skXfT/5TjZs24F7mN0X+CPEFnfcQvGfNwswU6N7yO
 VSFzgiPrcQYYtKMuZb0+Z6DUDgMNwimvlJXFHcYiY3mn2rc/o/M5yZn0s0mR9TonsEVovy48/Iy
 ThwXWQiaKEs3qamV+bwCWVQjmNz3hMog1KR9agAAIRokpxZflx2g2q/wfzSodbTScmsSxrUhjGG
 d7t6xGyCh6Q5rMKdk//q2hUbmiZGNtfI4ul9RUI377p0AMvu0oyQ1sf4qFOHqF1TedwUECBxaUw
 a86PMfD8ce4K3gVY0MCdrjp4bjNSJId0i6TjEo4a1qyHU5it5zZjD8wfMen/6nyexst/q8PU0MI
 W8h9LXT1QS93/FftsHadanJVEZaRaw==
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=68fa0cb8 cx=c_pps
 a=aU9leGltzW+WU5hfHysV/A==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=w1d2syhTAAAA:8 a=mlZLeVKwfFaRoF9MOUwA:9
X-Proofpoint-GUID: mDSclIsVdGg24FevQlVOB5nIXwEs-Go_
X-Proofpoint-ORIG-GUID: mDSclIsVdGg24FevQlVOB5nIXwEs-Go_
X-Proofpoint-Spam-Reason: safe

From: Bard Liao <yung-chuan.liao@linux.intel.com>

cs35l57 uses the same codec driver as cs35l56.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/sdw_utils/soc_sdw_utils.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/soc/sdw_utils/soc_sdw_utils.c b/sound/soc/sdw_utils/soc_sdw_utils.c
index cfa6255be387..b4b25372b0ef 100644
--- a/sound/soc/sdw_utils/soc_sdw_utils.c
+++ b/sound/soc/sdw_utils/soc_sdw_utils.c
@@ -581,6 +581,33 @@ struct asoc_sdw_codec_info codec_info_list[] = {
 		},
 		.dai_num = 2,
 	},
+	{
+		.part_id = 0x3557,
+		.name_prefix = "AMP",
+		.dais = {
+			{
+				.direction = {true, false},
+				.dai_name = "cs35l56-sdw1",
+				.component_name = "cs35l56",
+				.dai_type = SOC_SDW_DAI_TYPE_AMP,
+				.dailink = {SOC_SDW_AMP_OUT_DAI_ID, SOC_SDW_UNUSED_DAI_ID},
+				.init = asoc_sdw_cs_amp_init,
+				.rtd_init = asoc_sdw_cs_spk_rtd_init,
+				.controls = generic_spk_controls,
+				.num_controls = ARRAY_SIZE(generic_spk_controls),
+				.widgets = generic_spk_widgets,
+				.num_widgets = ARRAY_SIZE(generic_spk_widgets),
+			},
+			{
+				.direction = {false, true},
+				.dai_name = "cs35l56-sdw1c",
+				.dai_type = SOC_SDW_DAI_TYPE_AMP,
+				.dailink = {SOC_SDW_UNUSED_DAI_ID, SOC_SDW_AMP_IN_DAI_ID},
+				.rtd_init = asoc_sdw_cs_spk_feedback_rtd_init,
+			},
+		},
+		.dai_num = 2,
+	},
 	{
 		.part_id = 0x3563,
 		.name_prefix = "AMP",
-- 
2.43.0


