Return-Path: <linux-kernel+bounces-895490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A95C4E170
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55913A9DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E52E331A75;
	Tue, 11 Nov 2025 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="aGDt8242";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="ITj6yjMK"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE6A328250;
	Tue, 11 Nov 2025 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867269; cv=fail; b=TMb+1guUsuuMkR1Z35+l3XSbNTyCIFu/ewaOkWi4GOdsx8QcaBBy+s6F9WB1AeebL3WgwgZtRIpcnV5SPQMIuMANPpBYijw4SmnS68Cw5yBH28jnCZgSoy+K53rWHVX0MiQOJhlE7cR2VOfCsg78o7Z9edNOa33NQDKDdWPajag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867269; c=relaxed/simple;
	bh=aluaafNwWiz71mCHBpdguZlSmT3UE0QqVqCKh0XRJNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=noVuCUNVRQRz9kViH9aYUsOJYsRZGMpKYfS31ZEUFvkh1yDyxBWroMZ4khlayL2YHQ2HnDjDEwouLgE+7vNyUB1q2lwzJ8WCGY9T+IYydMk6fX2hvy40IGHDAP4L/pOlr3l3Nq8qqaBVC51B/88asfGxfcTh3KhcwuHAtsIvR14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=aGDt8242; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=ITj6yjMK; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB60GQs327118;
	Tue, 11 Nov 2025 07:21:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=UC/TfQtMaH6M5HTVrOuLOkmqvkv7QbApCAUaPqE8ngk=; b=
	aGDt82421q381KCiBCdZvW8kPR5u2ReNFbL2R8nFNpxxJNfNSzEn85k+IKTjbvXG
	0E7bY/NEgox5sGBdnLbbvPOlD/fcuaJEexrzSBjvIeqgrNeqvNudbh9oLOV5SQoB
	laoySYABQW+ViRzmi6W++4KMqfMCCPBwknEyalQ0UjuLNERb3+xAd2PO+cbUvBdB
	DDpUW75Rzp+RKA7V41Jh615st9R5Mh+ItR6bHAFsPn7IB7DBKhsvrGgtMj6Iodvb
	7ZWIawSszmrkvTIQFSsGtoWP/bx7evPclpo5BL8KKEVI5cjwqshpCl+k6SKNbocL
	6S5q0kzcvMmLpB8uJ2vy1Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11023117.outbound.protection.outlook.com [40.107.201.117])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4abfvksgcp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 07:21:03 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tcy7TEMPDwSUGPt79WnCNv8dyDM8TyVtor3AACSi6y/Bvpe4v4IWPic6/ZbegvRbHWwcgvwn5onlfO4ZjtG/ZuFSgm0l6XI6gTOzY7bq4/oarIrpDuX5xC1lurHrnPHcHQJVQbDaDdOqKKVt6Uwa/UlualbhGydKE3NO7ntJVl3INs5CAt+RBvNFAjnZ+mch7MT0f4I/BZMbX1+5njmfG/NR7STySLZlFR+85O+VkLAB5HBdlZog2QPGJcEFhaOZ81VGpeoG47ttdANi4MdTiuu7rlIM8qGJAhKARoctrzefu+C8T2vR+AVbRckLpCQtn4jD6wd+emWgtHLlPwimfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UC/TfQtMaH6M5HTVrOuLOkmqvkv7QbApCAUaPqE8ngk=;
 b=udJXs+opdRVGitlRQgOciCStca9eMdX4Zj1DCtvB1w8eTf4j6eLwiI02bVeTUoebhC3jNClujqhoT0j92TmXcvXR29PnuoSHe50AQXd65ixOQDYk1QrU0/9W66OSRTjaY/BJUBifG19xfphmn23ykhgJg0FSTwRIox6BJApSkz8yziZN/U4Xtjsl8vHDuwIlba7QaeeDRsPAcoFKaZGc/jbPOyefB+WPmTb1dx0v+C1D09G5yexwqpyHnP3blflueoZbfzjUeoGXODj99Sd9wDXBAkqvWQbItDBd6O1TZ7h0ov7JfR0uT0VXPBoi/dx3fUKv4fs4sLir5yFZU9BDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC/TfQtMaH6M5HTVrOuLOkmqvkv7QbApCAUaPqE8ngk=;
 b=ITj6yjMKSbIZN9zLEYr29NL/rr0VVy9LLcTUppGdYWVh/yMhfU6wUSHvKWGSwzqdIgd+uFERdTZPFlsIp401/SPKDRyCxwPN3qF3+WOlY5CuLibTmYXLHFIRdymqj9xd7Dethzys+6Pani7v7LGFPJKH71eKFDk8qVlnoTbNP1U=
Received: from CY8PR10CA0046.namprd10.prod.outlook.com (2603:10b6:930:4b::24)
 by SA0PR19MB4302.namprd19.prod.outlook.com (2603:10b6:806:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Tue, 11 Nov
 2025 13:08:53 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::4f) by CY8PR10CA0046.outlook.office365.com
 (2603:10b6:930:4b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 13:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.13
 via Frontend Transport; Tue, 11 Nov 2025 13:08:52 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 2204840654B;
	Tue, 11 Nov 2025 13:08:51 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 08E4682026B;
	Tue, 11 Nov 2025 13:08:51 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 1/2] ASoC: cs35l56: Add control to read CAL_SET_STATUS
Date: Tue, 11 Nov 2025 13:08:49 +0000
Message-ID: <20251111130850.513969-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111130850.513969-1-rf@opensource.cirrus.com>
References: <20251111130850.513969-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SA0PR19MB4302:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7fd597f0-0903-4f48-95dd-08de21237650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tCeZC7eaev1VSsneRMZU9lHRgkvYw4/w8sj9JI/FLtZoKOKYgGthpRjSinPl?=
 =?us-ascii?Q?WqiJqpW5YoFHFMAi4Ku2boHkZnyduui55CVSgfBmNLZU/sKnFkMUuI9/h0Oc?=
 =?us-ascii?Q?ifxKSVfaGmYnKqB2uR+y8z8DqUc+2kH5qTrI5heaagWbxScPsAsKGbMPO7Ep?=
 =?us-ascii?Q?LQafQgU2xoyds9JKwy59f3gDraaX+Tgjfr0cJrPbVLVH87VErL/Ie1+aHGo7?=
 =?us-ascii?Q?mQP4Yavpz0PK1mBUs97OhfK7YObbKrZPXyH/fVNSjquOGAikKtKFmB3Rh92q?=
 =?us-ascii?Q?A3VsTPzY59eYb5H9Ap0/Xrb0E9uCZR7aUkb5o6KuKQ64Xdi7YVkVaEXoGttJ?=
 =?us-ascii?Q?+/IZ3qvcmnMUbnhbWQc4D/4+mc1KtM/Ia2l3lQS4atxhPnp1Rzn92t5cmCA0?=
 =?us-ascii?Q?anqon8p2ew80WUn5uJOPf8wUAXoz08JEV+yjong/wAD2wDH1PwWq3EC70pzn?=
 =?us-ascii?Q?bPFkYOOdwWmP9NSk0EXSU+If6qtdyoWaRrsdd6aW4M1jyzXbplYRbdPHVizS?=
 =?us-ascii?Q?R5e3K14eRIyMgTO5nQht0KOqERu1h8DkSeRzNt2edPimlP9EeGf6TkIPF6h7?=
 =?us-ascii?Q?iNVOEbGz4xRds1iYjcMUPbqgzTv3wAqoQ7JQgIrPNYvG5715IJbR46UwVmAP?=
 =?us-ascii?Q?a0Gl7JJHwTDDDEcNlz4J0qtFGi18IYU+95Y4Ys3tWuspE0Ae32IZtH2u/u5g?=
 =?us-ascii?Q?kDf5G4pYFmdQsHVt6F+AGxp4JmPL+V/X5xWDAsM1vZlg6NR9XabnLIB3Kzwy?=
 =?us-ascii?Q?Gnl0Vsfq9otC/7q0tsb0QxzaxDx0PC6ormmp7TrMqsk9mN0ALE8GBBmmQpoC?=
 =?us-ascii?Q?6Y7/Pid8USY6BpPx7W7ilyFrV5ufQ7ZW0ooSH70MydMxc4WrqkVcJ6H+szR6?=
 =?us-ascii?Q?0PweMAS0Tu5V8TCFiqPgsuFDeWLCuBtbF1J0OdhlWE7dDsCOoBePDARds/e2?=
 =?us-ascii?Q?WGhXCM0M7uK7Gts5p1C8J7+MPzbL1RvKD4unCL5Kuyp12f+ClGRkeuE08Nro?=
 =?us-ascii?Q?2u7eDYf6yjun/ckWQGINC+XN5gmpRLtEIyc7jkLZhNqqkED+T776quWj2D2D?=
 =?us-ascii?Q?EPEy97XMC1TtOdM48VwWD4w02M0r5JF5jjEh83gGeiLoXcAvUUcWnVkjp/AK?=
 =?us-ascii?Q?SRgDfRLi0wx+sA9YLzZOSOz4oEC+BXgoOoW9lR3SAaSM1PCM5qU7bCAKqqiZ?=
 =?us-ascii?Q?i5PjmBniK8U95L3ffr1vvj+7W65sk2ZD7wdTAJ+j3q0v/pDiEfy4eYm6Nx9M?=
 =?us-ascii?Q?/EAyLnSUD8r8icloUTpr0b8UDfZ4y+EIXsPfZLN4KewA8StZ9wVVFXbCA8kE?=
 =?us-ascii?Q?cVUwulqlYNxSS0lXNSUvO2+X13Sp+KDVmNMCKvCZbhAdgxMe4M4BBzLPQcNi?=
 =?us-ascii?Q?Rark8Ej2jxwy84Xj0GDRb11khNXfHmd3NTFX4g6+lnrWEkir66zG1o6cpcGJ?=
 =?us-ascii?Q?h3kX0CUPtJMlJfrs5FYrxtmUqITK+yeuBcHAux2w+x0X/u8blKA3qXzIKRex?=
 =?us-ascii?Q?jfoj91DdZDhifLFMva19cP8b+T2LoWhDjTZt5hBBdiDQNVI89hVMXxUdiEh3?=
 =?us-ascii?Q?5TMFewiOu5FkObSPbAI=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 13:08:52.2838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd597f0-0903-4f48-95dd-08de21237650
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4302
X-Proofpoint-GUID: hmhHQaGSTijfbdxkmVPKToRenLDzjcYx
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=6913383f cx=c_pps
 a=czckzaKnCwXpY126n2X5rw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=ONobNVd33O2BGvCDFCwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEwNiBTYWx0ZWRfX4QmEMOoPyweT
 W9xhb2PjwVQXIBohk6MFRzWCMmP1n+u3fN0VNS0XhPi0ljlJKkYKZbHJbPCsSnH4jmrPNeKiXLs
 Y98dOwsBaT6uGtKqN8hMO+LR4kq8qpyvbFI0GJ42aGXBl8m7yXzt1BlKvBq4HlbMKyztqRUbLor
 3ixRUFd5tPWsCBKGkKG4Z52BIDQGqANiqwjr/Eu+oSvKcrb/vJgb2BRaZH/zcW+s5dZKC6mC1d9
 b8/YaMoP3g9pRHUxj8UXH0dJQfsCiS1bwEiGlsBsFJpK+xsiuNkPmL4V5p6BpjsRqECPkntAW9L
 tsJPgpAxzaFvr7H6E8vFJ53yGJJX5tN4O7Vn+SPqG/RHxYzIGnH91CE/B5t4Ko6cbs1GIIFZMrQ
 WmX04N4T9bmFhlD4W0wLCFNtnH8MyQ==
X-Proofpoint-ORIG-GUID: hmhHQaGSTijfbdxkmVPKToRenLDzjcYx
X-Proofpoint-Spam-Reason: safe

Create an ALSA control to read the value of the firmware
CAL_SET_STATUS control. This reports whether the firmware is
using a calibration blob or the default calibration from the
.bin file.

The firmware only reports a valid value in this register while
audio is actually playing and the internal PLL is locked to the
audio clock. Otherwise it returns a status of "unknown".

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h           |  9 ++++++
 sound/soc/codecs/cs35l56-shared.c | 48 +++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l56.c        | 16 +++++++++++
 3 files changed, 73 insertions(+)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 0a740a99ad31..bd13958bf19d 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -16,6 +16,8 @@
 #include <linux/spi/spi.h>
 #include <sound/cs-amp-lib.h>
 
+struct snd_ctl_elem_value;
+
 #define CS35L56_DEVID					0x0000000
 #define CS35L56_REVID					0x0000004
 #define CS35L56_RELID					0x000000C
@@ -268,6 +270,10 @@
 #define CS35L56_CAL_STATUS_SUCCESS			1
 #define CS35L56_CAL_STATUS_OUT_OF_RANGE			3
 
+#define CS35L56_CAL_SET_STATUS_UNKNOWN			0
+#define CS35L56_CAL_SET_STATUS_DEFAULT			1
+#define CS35L56_CAL_SET_STATUS_SET			2
+
 #define CS35L56_CONTROL_PORT_READY_US			2200
 #define CS35L56_HALO_STATE_POLL_US			1000
 #define CS35L56_HALO_STATE_TIMEOUT_US			250000
@@ -363,6 +369,7 @@ extern const struct regmap_config cs35l63_regmap_i2c;
 extern const struct regmap_config cs35l63_regmap_sdw;
 
 extern const struct cirrus_amp_cal_controls cs35l56_calibration_controls;
+extern const char * const cs35l56_cal_set_status_text[3];
 
 extern const char * const cs35l56_tx_input_texts[CS35L56_NUM_INPUT_SRC];
 extern const unsigned int cs35l56_tx_input_values[CS35L56_NUM_INPUT_SRC];
@@ -396,6 +403,8 @@ ssize_t cs35l56_cal_data_debugfs_write(struct cs35l56_base *cs35l56_base,
 void cs35l56_create_cal_debugfs(struct cs35l56_base *cs35l56_base,
 				const struct cs35l56_cal_debugfs_fops *fops);
 void cs35l56_remove_cal_debugfs(struct cs35l56_base *cs35l56_base);
+int cs35l56_cal_set_status_get(struct cs35l56_base *cs35l56_base,
+			       struct snd_ctl_elem_value *uvalue);
 int cs35l56_read_prot_status(struct cs35l56_base *cs35l56_base,
 			     bool *fw_missing, unsigned int *fw_version);
 void cs35l56_log_tuning(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_dsp);
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index fe0693c3f7de..4fba4127c40c 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -1262,6 +1262,54 @@ void cs35l56_remove_cal_debugfs(struct cs35l56_base *cs35l56_base)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_remove_cal_debugfs, "SND_SOC_CS35L56_SHARED");
 
+const char * const cs35l56_cal_set_status_text[] = {
+	"Unknown", "Default", "Set",
+};
+EXPORT_SYMBOL_NS_GPL(cs35l56_cal_set_status_text, "SND_SOC_CS35L56_SHARED");
+
+int cs35l56_cal_set_status_get(struct cs35l56_base *cs35l56_base,
+			       struct snd_ctl_elem_value *uvalue)
+{
+	struct cs_dsp *dsp = cs35l56_base->dsp;
+	__be32 cal_set_status_be;
+	int alg_id;
+	int ret;
+
+	switch (cs35l56_base->type) {
+	case 0x54:
+	case 0x56:
+	case 0x57:
+		alg_id = 0x9f210;
+		break;
+	default:
+		alg_id = 0xbf210;
+		break;
+	}
+
+	scoped_guard(mutex, &dsp->pwr_lock) {
+		ret = cs_dsp_coeff_read_ctrl(cs_dsp_get_ctl(dsp,
+							    "CAL_SET_STATUS",
+							    WMFW_ADSP2_YM, alg_id),
+					      0, &cal_set_status_be,
+					      sizeof(cal_set_status_be));
+	}
+	if (ret) {
+		uvalue->value.enumerated.item[0] = CS35L56_CAL_SET_STATUS_UNKNOWN;
+		return 0;
+	}
+
+	switch (be32_to_cpu(cal_set_status_be)) {
+	case CS35L56_CAL_SET_STATUS_DEFAULT:
+	case CS35L56_CAL_SET_STATUS_SET:
+		uvalue->value.enumerated.item[0] = be32_to_cpu(cal_set_status_be);
+		return 0;
+	default:
+		uvalue->value.enumerated.item[0] = CS35L56_CAL_SET_STATUS_UNKNOWN;
+		return 0;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_cal_set_status_get, "SND_SOC_CS35L56_SHARED");
+
 int cs35l56_read_prot_status(struct cs35l56_base *cs35l56_base,
 			     bool *fw_missing, unsigned int *fw_version)
 {
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 091a72325507..e1eb7360b058 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -66,6 +66,18 @@ static int cs35l56_dspwait_put_volsw(struct snd_kcontrol *kcontrol,
 
 static DECLARE_TLV_DB_SCALE(vol_tlv, -10000, 25, 0);
 
+static SOC_ENUM_SINGLE_DECL(cs35l56_cal_set_status_enum, SND_SOC_NOPM, 0,
+			    cs35l56_cal_set_status_text);
+
+static int cs35l56_cal_set_status_ctl_get(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
+
+	return cs35l56_cal_set_status_get(&cs35l56->base, ucontrol);
+}
+
 static const struct snd_kcontrol_new cs35l56_controls[] = {
 	SOC_SINGLE_EXT("Speaker Switch",
 		       CS35L56_MAIN_RENDER_USER_MUTE, 0, 1, 1,
@@ -83,6 +95,8 @@ static const struct snd_kcontrol_new cs35l56_controls[] = {
 	SOC_SINGLE_EXT("Posture Number", CS35L56_MAIN_POSTURE_NUMBER,
 		       0, 255, 0,
 		       cs35l56_dspwait_get_volsw, cs35l56_dspwait_put_volsw),
+	SOC_ENUM_EXT("CAL_SET_STATUS", cs35l56_cal_set_status_enum,
+		     cs35l56_cal_set_status_ctl_get, NULL),
 };
 
 static const struct snd_kcontrol_new cs35l63_controls[] = {
@@ -102,6 +116,8 @@ static const struct snd_kcontrol_new cs35l63_controls[] = {
 	SOC_SINGLE_EXT("Posture Number", CS35L63_MAIN_POSTURE_NUMBER,
 		       0, 255, 0,
 		       cs35l56_dspwait_get_volsw, cs35l56_dspwait_put_volsw),
+	SOC_ENUM_EXT("CAL_SET_STATUS", cs35l56_cal_set_status_enum,
+		     cs35l56_cal_set_status_ctl_get, NULL),
 };
 
 static SOC_VALUE_ENUM_SINGLE_DECL(cs35l56_asp1tx1_enum,
-- 
2.47.3


