Return-Path: <linux-kernel+bounces-828953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DFFB95ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EB1D4E066B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAA0324B27;
	Tue, 23 Sep 2025 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="bofplfd7";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="bCAN77WZ"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778E6323F60;
	Tue, 23 Sep 2025 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632634; cv=fail; b=ASlGT6jS1ZTOo23fuKZ151K7gIo0NcTVTnJsQ1gjNoH1o+r+YY4B9Uifwis5JzHCaAdH2D1TCG6NIhrGBrdY7Uid54QDTBvU5lSLTqwPXu2othTRmtba7iiPlDjxwnrZX9RBNyj4zD8pteJo4ErBNEKathFSoWV1How+ykYQgvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632634; c=relaxed/simple;
	bh=LvRbrihAaW4gKYnC1mg/FGCPupi4fvKQGMrBGejRGww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVu263XCho/v48zLsvgCUUPe0xgaU0wEG50KB05IBIrBSI78GQWLzYvRz8/lM6myPsYsdTn/YYppykq+5c4e+fzehfwNFc9sku9qVOlKXaj02h9//jl2uwbWgTVaIIu3x9xeFVCMoAE3cob2kSdk8b4fBf1xE5MjFV2CKE5w16Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=bofplfd7; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=bCAN77WZ; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58N0isTD1433331;
	Tue, 23 Sep 2025 08:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=XgabmR0KJk52m1s9ezkXROX1Gt0Az2KX53rKDKC5VhI=; b=
	bofplfd7E+wG/GA39lEJifTtQcCU7nG5Sbtcp0bO3mlt3lTxfheoHqxeeW6EMjvq
	cSyW52SmAGkcU1qV/F8zXbE1sVrBqJhNB+2B1FnYx7w8I0Qqd2a4zk51mFXoq9Hw
	avzvVMOzYKK2uZ4642xWqn0ycknRUpYZJJaIZSaRS446HsrMG2q1sSnB4FRy/z8A
	ndxSp0m/m2fr/KdAjBQ5biKsViuMhfdXeobrWeF3K2sI9UAdqNmL6JGF3fVVso9y
	EnNJ5rrwf6HnN5XY9r9NarJ0Lb1tuu9q2D5MSsW50dw8/d+ihuAthzHtmEcVnVPU
	TYARvtPRK4N1jx/gPc5KBQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11021121.outbound.protection.outlook.com [52.101.57.121])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49b90y185d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 08:03:34 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHYlkikoeONdhRzH0pnjripp91Krj16Lh0gHe3gsKPwKIzsug1/KRHFt3RLyL1W76fPM9Hf6IKu3/T/jnWxQaLM5Esge0ryhZnfN3C5ogVP7NbHPJbTUpSWIV1i8xQz/rY6gZfruuDtjuMVQ3+DczlN5iMCa9EvQc/CSTEUWMsOUEwQSRoJBEvjdAP9P5U5wfTydu2c4GkPH2OrgxvnBTQ8n6Xin6O1qL0VIGoMw/EFHSq8XTrBeJdGqafzbXH42Ab6qNy1T4WjXst7pTK2aZkCEFOv9pZOHR2Xrxf3kz9qmAeVU74Mh53P15sYrdBC/JFasUT1ZL98kEVOiZmXTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgabmR0KJk52m1s9ezkXROX1Gt0Az2KX53rKDKC5VhI=;
 b=tsoqStSSYBGuQ+FTEPvPtTNGx/czNc7EkpK/Ku8yISx6V9sasb5GRvN4T/qiD0ssVdIBakyhkpsrmucRK2k7QoXuuukEvB1YeqL+DwZojyfbYtQZsdqnli3LTw7BbTF3FXs7Q/eT844i1OnzBdgq6+hBHRTi9Oieh5/odfkdgtSe3z0H1NPusvMTH4l5GqiIRye36qWE04AUdENesp2y1NBNHkSttIsfctdNjK4IYcq1+SXZnqmXVnFBL2+gubwzVfkrNpxI2CU8xVsdoXTqGUAePSxwQh8EbZIdoDg1lheH0/P6KUdQ3zN3S6LBlYupiP3/q5yKCo2fNcfZAJ2LwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgabmR0KJk52m1s9ezkXROX1Gt0Az2KX53rKDKC5VhI=;
 b=bCAN77WZNjcIRjJUx3IzGe/v7nlideZZN7OpnCKCG41gQPz3kN7XEdREtCGnWoLIgwrwW4afM+L8On3q96OJ1wvSvKuereiBbzi+yPT+dfaFA1ymnh9hWWOMOC5ImYw518bL0xkclFQhFlcjDtAmDyhqfzMFhd8RO2usFYQiRCw=
Received: from BN9PR03CA0413.namprd03.prod.outlook.com (2603:10b6:408:111::28)
 by DM6PR19MB4060.namprd19.prod.outlook.com (2603:10b6:5:249::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 13:03:28 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:111:cafe::b2) by BN9PR03CA0413.outlook.office365.com
 (2603:10b6:408:111::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 13:03:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.0
 via Frontend Transport; Tue, 23 Sep 2025 13:03:28 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 50FD5406552;
	Tue, 23 Sep 2025 13:03:27 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 3181C82026B;
	Tue, 23 Sep 2025 13:03:27 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 2/2] ASoC: cs35l56: Add support for CS35L56 B2 silicon
Date: Tue, 23 Sep 2025 14:03:26 +0100
Message-Id: <20250923130326.510570-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923130326.510570-1-rf@opensource.cirrus.com>
References: <20250923130326.510570-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DM6PR19MB4060:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 37dd6a7b-b0f7-49fd-de18-08ddfaa196cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|61400799027|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ornBFgeySeNB1axLeIpEilLPZeZQwE+N3eQ3jhpiCDq6WWIlxTguXwwOyA8O?=
 =?us-ascii?Q?T8TBJHMCIaQ0kQCQL43qpqlLAPteMtJf9RqEYty7kSqwBpSw3MnpjsgejI7l?=
 =?us-ascii?Q?hcLIx4wFgv9JhO6eBBZ580efWtftl4Ct+EuzSnywvQbWvs00IEF8BCWAFiVT?=
 =?us-ascii?Q?5Ta9nyDXEV+eRiLCdCcJK4aQRVSP++ooYykxOOyJedbKHdVTHqud0tr934P3?=
 =?us-ascii?Q?ua47nlHhneZ4v85PHYajNsxUuL1qlD2rjnta8CDW5u4RwLGe7Hl0RUAEhJQ+?=
 =?us-ascii?Q?zd/cE+wq9H8OjWjLt+gFPtxJuuD3tXUogO9mPGkmT5M5qjlU/fOoqGwhpHqX?=
 =?us-ascii?Q?hzyEzwPXcAfsQofsJDWbZK24B9w4vOLghzAta1i962JfuPZFmqlcARewt41j?=
 =?us-ascii?Q?yNuHewCnoFnqz/+ZvkyQPZrgSESjtEctezMJE39dGhcj4I55Iz+3eUTkMDQJ?=
 =?us-ascii?Q?6h1SVFfCQPCb0wFaZxECLX2OmGu5b28F8WvsaKVCoNoPv49RtHyT1ap8rFsL?=
 =?us-ascii?Q?MtzS0xxtWNPQgcB3u8dOccAURRALDPhIwdJymIU/Fc0Dt480ppSSR02YD+0X?=
 =?us-ascii?Q?Sx+mQkuCAVh/SS/krnL6WxYtXoxK4WphVhjAIo0W0Hhmg6J8Y4V6emMVOcYc?=
 =?us-ascii?Q?wZ1UleUAQU7Y8IukqN5/8TOjCGwn8XqSWkbknRn91A3tI9zRYyKUce15IyvK?=
 =?us-ascii?Q?WR0q94ehNGoiQOM3EFjavM/lTklM87Qq43RGOFS4gdLYMOoxiBpKgq1orS57?=
 =?us-ascii?Q?xJ75uF4jagF0WXY1t4frzFpwRd1cgzvRxf6qpwwLqUXKeVaW3C0uS4fLmALW?=
 =?us-ascii?Q?ksIRzUwfGjkbwLzZQL2wxUmmcY7x1tua6n6xPb0Za/jcm6OabTyuwFSjt1ME?=
 =?us-ascii?Q?LFOdLkYhhmJZbZztSKUsLUhy/1NkfSL8JyqQdmiNFSrwyJQb7ncVaZEhyhHC?=
 =?us-ascii?Q?Xvh4WIlossm54WYfARxo2grD1Vb57L6qHrVMAqeUFUMc9gm8jKo4mjDStBNv?=
 =?us-ascii?Q?cGoAWfVqjx7nnHA/rNvxL/t3X4D6nfZSeyKULh344nak13NbkjRbj4pOsFOI?=
 =?us-ascii?Q?D90iSULzvtOmQFQSCtpmFdRQUUV3bbjyuYhwR9yvHejMETtT0ipvLX4XDzy3?=
 =?us-ascii?Q?TbdLUwjqiy2i4LGW68B9XWf4cpVMLXfs6CDNtZYntb+VJ/bUDwzUhm+RHGT2?=
 =?us-ascii?Q?2X8+xWbnH4TtPDBh7u5E7nry7a0M44YUiJpuAck7kvY8QMyixUiliE9t+eyZ?=
 =?us-ascii?Q?BYKR7oU4IIARSQtg5FZ4aFyo1uul7eJsgNGp+VxOESlkj541ADPWEwMhIv+5?=
 =?us-ascii?Q?1SH5QnM2WmCma0Hbg9tBA7OprDzUTKmUiium0xZ/74Tn8rIerUnz87GfErz1?=
 =?us-ascii?Q?38BPoMpyAq2xEnDW2l0OrNwrhzAOPP6K0E7lbKaPn4RaHWkeu8xHgpNLjn8k?=
 =?us-ascii?Q?+GeItsUUTZLOThBuhDgeBu7BA9uZdqlBCWPps7WeoogDouuv2J0MsFyeALJy?=
 =?us-ascii?Q?h5vgcBplR+gbWK8pcSeG/dFjjk/h4CAhFweP?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(61400799027)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:03:28.1196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37dd6a7b-b0f7-49fd-de18-08ddfaa196cf
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4060
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyMSBTYWx0ZWRfX4hVgag8O2B/R
 9n+sYz3zRXIVzT0/RV29+j1cYg8oRhOu8E5irzRQA2FOZBl6AhxFZ1L6gECqtPL7zd9n0mnUdTc
 jnVyUXYQM3y8AzIOgR3+nSN9uERuC5Wa2bEQUnsfs4pv0/rOf00PvsCkvz1Vx26Sw0f8oRgSPzW
 JGUN5X5ipQDHBTA3nbDGp6Q+oNZFxBytRTmC8OYpW+qDR5Ysc41i7TQ3R/XWUrwPysGdnzQ15nq
 Ns+JFBDBZPNHD2GA0qzJrOzhMkshQe30Nzllkq6q7w0y5UmW7NOBiNF6lIJDe4K8i9gR1CzgHD7
 lWSesYBWP9JHMuisAyIQPElZWpe8UffrkzVIt0xgvy6qNzYV2AixPSd232Me8o=
X-Proofpoint-ORIG-GUID: o8b-2Q5MQSiqsESd--BCJvrlk2-GwY3D
X-Authority-Analysis: v=2.4 cv=A6BsP7WG c=1 sm=1 tr=0 ts=68d29aa6 cx=c_pps
 a=twImIRnwXVHz+pcTAbAWxA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=6TPL5HL8Id3p-lPlDfIA:9
X-Proofpoint-GUID: o8b-2Q5MQSiqsESd--BCJvrlk2-GwY3D
X-Proofpoint-Spam-Reason: safe

This adds support for changed firmware addresses on the B2 revision of
CS35L56 silicon.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h           |  2 ++
 sound/soc/codecs/cs35l56-shared.c | 40 +++++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 20dc3ee6378d..ab044ce2aa8b 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -85,7 +85,9 @@
 #define CS35L56_DSP1_XMEM_UNPACKED24_0			0x2800000
 #define CS35L56_DSP1_FW_VER				0x2800010
 #define CS35L56_DSP1_HALO_STATE				0x28021E0
+#define CS35L56_B2_DSP1_HALO_STATE			0x2803D20
 #define CS35L56_DSP1_PM_CUR_STATE			0x2804308
+#define CS35L56_B2_DSP1_PM_CUR_STATE			0x2804678
 #define CS35L56_DSP1_XMEM_UNPACKED24_8191		0x2807FFC
 #define CS35L56_DSP1_CORE_BASE				0x2B80000
 #define CS35L56_DSP1_SCRATCH1				0x2B805C0
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 03ea66f08787..9e6b9ca2f354 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -320,6 +320,17 @@ static const struct cs35l56_fw_reg cs35l56_fw_reg = {
 	.posture_number = CS35L56_MAIN_POSTURE_NUMBER,
 };
 
+static const struct cs35l56_fw_reg cs35l56_b2_fw_reg = {
+	.fw_ver = CS35L56_DSP1_FW_VER,
+	.halo_state = CS35L56_B2_DSP1_HALO_STATE,
+	.pm_cur_stat = CS35L56_B2_DSP1_PM_CUR_STATE,
+	.prot_sts = CS35L56_PROTECTION_STATUS,
+	.transducer_actual_ps = CS35L56_TRANSDUCER_ACTUAL_PS,
+	.user_mute = CS35L56_MAIN_RENDER_USER_MUTE,
+	.user_volume = CS35L56_MAIN_RENDER_USER_VOLUME,
+	.posture_number = CS35L56_MAIN_POSTURE_NUMBER,
+};
+
 static const struct cs35l56_fw_reg cs35l63_fw_reg = {
 	.fw_ver = CS35L63_DSP1_FW_VER,
 	.halo_state = CS35L63_DSP1_HALO_STATE,
@@ -335,7 +346,14 @@ static void cs35l56_set_fw_reg_table(struct cs35l56_base *cs35l56_base)
 {
 	switch (cs35l56_base->type) {
 	default:
-		cs35l56_base->fw_reg = &cs35l56_fw_reg;
+		switch (cs35l56_base->rev) {
+		case 0xb0:
+			cs35l56_base->fw_reg = &cs35l56_fw_reg;
+			break;
+		default:
+			cs35l56_base->fw_reg = &cs35l56_b2_fw_reg;
+			break;
+		}
 		break;
 	case 0x63:
 		cs35l56_base->fw_reg = &cs35l63_fw_reg;
@@ -502,6 +520,11 @@ static const struct reg_sequence cs35l56_system_reset_seq[] = {
 	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_SYSTEM_RESET),
 };
 
+static const struct reg_sequence cs35l56_b2_system_reset_seq[] = {
+	REG_SEQ0(CS35L56_B2_DSP1_HALO_STATE, 0),
+	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_SYSTEM_RESET),
+};
+
 static const struct reg_sequence cs35l63_system_reset_seq[] = {
 	REG_SEQ0(CS35L63_DSP1_HALO_STATE, 0),
 	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_SYSTEM_RESET),
@@ -524,9 +547,18 @@ void cs35l56_system_reset(struct cs35l56_base *cs35l56_base, bool is_soundwire)
 	case 0x54:
 	case 0x56:
 	case 0x57:
-		regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
-						cs35l56_system_reset_seq,
-						ARRAY_SIZE(cs35l56_system_reset_seq));
+		switch (cs35l56_base->rev) {
+		case 0xb0:
+			regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
+							cs35l56_system_reset_seq,
+							ARRAY_SIZE(cs35l56_system_reset_seq));
+			break;
+		default:
+			regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
+							cs35l56_b2_system_reset_seq,
+							ARRAY_SIZE(cs35l56_b2_system_reset_seq));
+			break;
+		}
 		break;
 	case 0x63:
 		regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
-- 
2.39.5


