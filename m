Return-Path: <linux-kernel+bounces-856088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FEFBE30C2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E0019A15F9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60D73164BF;
	Thu, 16 Oct 2025 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="mOr9EIWI";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="RbOCGYTY"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F417D7263B;
	Thu, 16 Oct 2025 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760613993; cv=fail; b=Keozod+G4iiuWfPDjj9JVwlZOG8JTtZUzyr3Eec1kaYeC33D6VGsBlBL3Q3udVi0eYYr3BEv/n/yDb2E+kA99kQLVwbZawTQt/kegxjnLsj1lRiP3nfGjkJXFfqdlgLmuSvKrLNHhIsbqoPHlqGPA2EerLHpA3VD8k97ri0gDaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760613993; c=relaxed/simple;
	bh=z46hgaXMG9WXM47QFvcwcugcokiaismIdRdx0wzplBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WIAO2SInojsRG+Z5ipjPCfA3kqbJ7yNei1xh8y+LwLDmIbO6ewQdlXB8tGdqUyssM6xm6LpwFA79yTdypeUZjU23vMbCIQH6mOO1TfZmUGw2flfQ77+DBSYIhmehokeOLpKQdY9uJSNNltGT6Z74+hCbnKZvagnef9HCVl1BNHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=mOr9EIWI; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=RbOCGYTY; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59FLY4JI1728970;
	Thu, 16 Oct 2025 06:26:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=LqRERCEgaXiv5Cq0
	GvchfSHVlV1m/uTSI0UhHJ9/c2k=; b=mOr9EIWIq8Wm6qZwIlt+xs7kU02i+THY
	DBrmaDK+mRJPF0i8lyLYxUlawzkcd0zHl4pa0xvbjadqARP86WrNnFkZOaCK/Jgd
	Ac6Ekd74muEDTXKpVdELN0M/ZrABVKxm+B/Mw/8eyfe1mSkUMNd/WkrDGTRHaPTU
	aYCtdxN4TbMyXrx4y8js+Bd6kd6U+5k8NPohjR6A5zZh1NNnrrb72o76i2KcZ0DH
	dNjiEKXVhALbb+v7HDb6YEW6EQSn4Zxxv3B/GZBFYLf6vGi8CAEx43xkh5WPEvll
	V5WECSaRBGELRE3aOVka8rKaR/5VCMaZtMJj0foURVi+z6Q2C+Mr7Q==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020108.outbound.protection.outlook.com [52.101.85.108])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49sdb449jb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 06:26:25 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shAv5bTIAMThJkE2wiwQT/3JLFKuC8wArT3VdmaJgNF7qdTTmWRhvPoOG3p2pBl+B1ALi7QXKdIQSWObgkH/CkCA+dj0Q/hkpDb5IQ3de68j76LE+V1uB6xMvDhUj1ZPQ/g/Cr9qb9HV/f2vLMsfGaafgsEgdfApLJtcyRJ3rsw+XRNdjTlvwK+wdyMQAqiHtpjuycx7/qMMOmtHJ1LIP0Jcu2Y/Gji8Hu2KmWSI2HOYGHkJGon3dskLDuge/PRdrXDoZgve2kZO0I5EgRr6dQHxAaL6O1NcLhCVPEWt51JIl6t/lsRaqp7oje7Lz0HOj2yfnV2kDczUpKCzXqCmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqRERCEgaXiv5Cq0GvchfSHVlV1m/uTSI0UhHJ9/c2k=;
 b=fgD7HRYRfgb1haCg62OtfboTzqz99iF9nrt6xb8X79rKWweqw7ZA4GCjxrnusq8gC83ALooX2k456fisLO0fJ91+/xM1CEOE0LEeKAb4vcqmv6bo711Od/PiPYjDgtkCzpZFWygGw/satrIEv0GyyJsjskAMqJidReWK4O0hws55B6UbIwo1kqVNTMmfXxltdtdFhnm8Nu0+oCMzbG9S31TcoaLTseZCkpSsoUOcsxZxFAS0KlbpPORzEOjcH0jW3xF5reNHlIEyzm3H00wMJnymozDNaPgscKKY3DLv+1yA1hcDtpkFKEfJ1Iw9XdP66GMuHbwddyXJFVGUDP+FGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqRERCEgaXiv5Cq0GvchfSHVlV1m/uTSI0UhHJ9/c2k=;
 b=RbOCGYTYnhl4jnLQVpVkw6oGwdzp0mxrfGocmTy1hkhFIb4Sb9kx8Z9HwBLCAlAuEbeY2WXKRLpp7E6ghe2PHk9voRwiHLkF2jvQKK7U3K9MGJTm7tPnrqyLqC0e4w/SR9OMbthhqXOLvhLJcSUZtYApfAym+6ANvwy1xbu4byk=
Received: from CH5P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::18)
 by DS7PR19MB8919.namprd19.prod.outlook.com (2603:10b6:8:256::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 11:26:16 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::18) by CH5P220CA0020.outlook.office365.com
 (2603:10b6:610:1ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Thu,
 16 Oct 2025 11:26:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 11:26:16 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 42B92406547;
	Thu, 16 Oct 2025 11:26:15 +0000 (UTC)
Received: from lonswws01.ad.cirrus.com (lonswws01.ad.cirrus.com [198.90.188.26])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 07633820249;
	Thu, 16 Oct 2025 11:26:15 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, yung-chuan.liao@linux.intel.com,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH] ASoC: Intel: soc-acpi-intel-ptl-match: Remove cs42l43 match from sdw link3
Date: Thu, 16 Oct 2025 11:26:01 +0000
Message-ID: <20251016112601.187020-1-simont@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|DS7PR19MB8919:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5b1a4089-7f2d-4bd7-76f3-08de0ca6d239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s0ez71YwtKMrPGFX0xLgLeaPFD5PwQsqLUwC/ZQihAG8J/5tSgOqyl0MBHHg?=
 =?us-ascii?Q?FfCaMxG9U5SAl45CcqTiIWasPwHT8M/Q8CTf19V0+Yl9KZr+hKrYlv1t9DLL?=
 =?us-ascii?Q?IqoxzZYFqqqATRzjjJj/kldF4esBT0yL6ZhhULB0q6taXRv5bkXYLLEyYywo?=
 =?us-ascii?Q?1MCpuTw09sRsTnVPnujV5nBth7Canw9GdpURZcL2qzEnrOc9B48XNZjpQHMp?=
 =?us-ascii?Q?9VSEebBH5uHs1S2zU4s/hJXLVlJehRH54gYAMuicpuRkaRgYJlbxU5cTowwe?=
 =?us-ascii?Q?u03SXzoOIvLMSez2VAaotw7wmcyICYo6AG/e9WlzR/qi5m9byd34tqckl+os?=
 =?us-ascii?Q?ad4CybfebvL0hpHTzbHEFguGGdRxEKsrGp+OqisFz/gtSYaI7oZT38uPwYCl?=
 =?us-ascii?Q?f+THOqGTebdGsz2IAK/hJXuRB53ei3lgV1jHE1lQOAo9RPMEQNhRpLrMbwYe?=
 =?us-ascii?Q?YxYEWC9dbgclBP48I0+PmwOySq4y57Vz/OK1ll7gepggouJWa1l7ikf3gYE8?=
 =?us-ascii?Q?wKbWCsA6GvzloaWJH0G42JznKo1okrpsuQMdx9ndybg9Ucu0TUWgFXJuGzx7?=
 =?us-ascii?Q?ekicgctIa6r1Jms9KOPflwspEAhVhfj6H0H0R6tOwemYDvNXuN5zzybXE+lS?=
 =?us-ascii?Q?17VdF95a/ApBBA0sNRV0rVE7+Aa90zEQPjELYuV5Qe6bWeLw9FnPJJ3xTHDc?=
 =?us-ascii?Q?YjGt3nksVcvidZZPkibAps1cXYyoJk8LElq4YPZeo9lv7V2MTGgy6Yb5FED5?=
 =?us-ascii?Q?w296BJtzr4a+Q2k5raFj+sgUNMrUytuUCy0ikYGVFpyiEy/0DrQRW0CyjyPX?=
 =?us-ascii?Q?FDFfoXGUf+lPQY++4/FupJUGJ2nuwTQqaBDMgYhb0dgMyro1wnC/subX5l0w?=
 =?us-ascii?Q?PLaycEB6vHz/saoYrf2/ScUskhy1fC40eyIjJdCq3FqoUdqBct/XSJsubbQg?=
 =?us-ascii?Q?i44nVj4YYjsBAvb4ld6zHVnHM8uLZ487YxEfqg9Capu0CAFef/dmQF2AOiO7?=
 =?us-ascii?Q?DxBPPgDtsRxIjJIFEvqty3FrCunOtEidFk8IaPUVshj9HDZ76rw15k29D5JL?=
 =?us-ascii?Q?o0DQI5OjPtp/bxd1+aSGcFu2BHHB239P17UYvG15PQQWMi/QVzFgLpUmcA1z?=
 =?us-ascii?Q?JxTohplikDPERzFVEc0GVHd9JAMLn9t/JiV7cqjmJBSQS1gzr/azDzWO6i5s?=
 =?us-ascii?Q?1OLaVA1McZZXF1lMR4OkqGOiOCu293U+sTkcpYb/rHPgvRmpIft3hiW6C8HT?=
 =?us-ascii?Q?iHNyWIUEaq15xiRM0PutnHsSkR/YDFJZtDHgtGt2k4N7No2RmHaFEEb5bIz+?=
 =?us-ascii?Q?paxBqANHqe0mseFgCg2GW9VC16tDip1zc0+c3Dw+cbLneRN+HGLKUF5B9vg2?=
 =?us-ascii?Q?QL0ozMl27u8I9pSpHi4SEQMCuYqS0VosXdP9IxKxa8eYUUlZA782YKdyS/Gm?=
 =?us-ascii?Q?bKmITX4FdmeJ2ZQafZTVYSE8R+AEAyNp4kd5A1pBTpG2y2d16zFCycUBEHSO?=
 =?us-ascii?Q?D426yb0gWC2JdLOZUQA4VlfD/KcsrgyL+kaGWlDcl4OwdQCW9BlK2sTuCdPj?=
 =?us-ascii?Q?peXCHmDKdKX56xIOV4M=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 11:26:16.1946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1a4089-7f2d-4bd7-76f3-08de0ca6d239
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB8919
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA4NSBTYWx0ZWRfX4V8EPM5g03+p
 AsJJHmFeMbm76M21bm/V3Wx9t0wrxvvzxfN3pT0BSDyLqhS0UTboGekC9dZDBrLKrAEQsWyBXX6
 xunzkahOxfJN3dUDp58XD2sO44bajtp7lVaAwbWxVxjtVg+Qx9PNUSnwWGvd36hdyCSfzFA9GhE
 R5vf5yeP0zVGN9HzXpiOqFCGZBzrUTRWJcHwj3Pl/H7WGz5IVxFBKzHZDeclLzkSoSSIYJYTOcS
 N8q5xH18UcdsK30kwfrETRAsQG6+WtZfE75WiZ6aKAsFFrvd8810ewTK2dje7I5yt+668YDyZgI
 h6uZ+EKWikfXV+QmRSstmcarVwSVwgxSCrBaHol4d+oYdjaIpmuGtp+LM0HihO+nTayjqSFxyRf
 IW3NL3wTjSQKWCsPRmWEGgBMNlBU+A==
X-Proofpoint-GUID: x4mIwJJHm84OS6b77ImobAjyAKejnntv
X-Authority-Analysis: v=2.4 cv=PPICOPqC c=1 sm=1 tr=0 ts=68f0d661 cx=c_pps
 a=l6WPzq2nfbAxniYbonYZnA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=Np-OjBUBkVp4nTsJVhwA:9
X-Proofpoint-ORIG-GUID: x4mIwJJHm84OS6b77ImobAjyAKejnntv
X-Proofpoint-Spam-Reason: safe

Removing this match entry ensures that a PTL system comprising of a
cs42l43 codec on link3 will use function topologies.

Previously the behaviour would be use the monolithic topology associated
with this codec match table entry in preference to function topologies
and if the system had a number of smart amplifiers then they would not
be instantiated.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 .../intel/common/soc-acpi-intel-ptl-match.c   | 52 -------------------
 1 file changed, 52 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
index 3c8b10e21ceb..4853f4f31786 100644
--- a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
@@ -227,33 +227,6 @@ static const struct snd_soc_acpi_endpoint cs42l43_amp_spkagg_endpoints[] = {
 	},
 };
 
-static const struct snd_soc_acpi_endpoint cs42l43_endpoints[] = {
-	{ /* Jack Playback Endpoint */
-		.num = 0,
-		.aggregated = 0,
-		.group_position = 0,
-		.group_id = 0,
-	},
-	{ /* DMIC Capture Endpoint */
-		.num = 1,
-		.aggregated = 0,
-		.group_position = 0,
-		.group_id = 0,
-	},
-	{ /* Jack Capture Endpoint */
-		.num = 2,
-		.aggregated = 0,
-		.group_position = 0,
-		.group_id = 0,
-	},
-	{ /* Speaker Playback Endpoint */
-		.num = 3,
-		.aggregated = 0,
-		.group_position = 0,
-		.group_id = 0,
-	},
-};
-
 static const struct snd_soc_acpi_adr_device cs42l43_2_adr[] = {
 	{
 		.adr = 0x00023001fa424301ull,
@@ -305,15 +278,6 @@ static const struct snd_soc_acpi_adr_device cs35l56_3_3amp_adr[] = {
 	}
 };
 
-static const struct snd_soc_acpi_adr_device cs42l43_3_adr[] = {
-	{
-		.adr = 0x00033001FA424301ull,
-		.num_endpoints = ARRAY_SIZE(cs42l43_endpoints),
-		.endpoints = cs42l43_endpoints,
-		.name_prefix = "cs42l43"
-	}
-};
-
 static const struct snd_soc_acpi_adr_device rt711_sdca_0_adr[] = {
 	{
 		.adr = 0x000030025D071101ull,
@@ -486,15 +450,6 @@ static const struct snd_soc_acpi_link_adr ptl_cs42l43_l2_cs35l56x6_l13[] = {
 	{}
 };
 
-static const struct snd_soc_acpi_link_adr ptl_cs42l43_l3[] = {
-	{
-		.mask = BIT(3),
-		.num_adr = ARRAY_SIZE(cs42l43_3_adr),
-		.adr_d = cs42l43_3_adr,
-	},
-	{}
-};
-
 static const struct snd_soc_acpi_link_adr ptl_rt721_l0[] = {
 	{
 		.mask = BIT(0),
@@ -712,13 +667,6 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_sdw_machines[] = {
 		.sof_tplg_filename = "sof-ptl-rt722.tplg",
 		.get_function_tplg_files = sof_sdw_get_tplg_files,
 	},
-	{
-		.link_mask = BIT(3),
-		.links = ptl_cs42l43_l3,
-		.drv_name = "sof_sdw",
-		.sof_tplg_filename = "sof-ptl-cs42l43-l3.tplg",
-		.get_function_tplg_files = sof_sdw_get_tplg_files,
-	},
 	{
 		.link_mask = BIT(3),
 		.links = ptl_sdw_rt712_vb_l3_rt1320_l3,
-- 
2.43.0


