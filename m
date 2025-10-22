Return-Path: <linux-kernel+bounces-865120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2B8BFC44A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5249A563D4F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3425E34B1B2;
	Wed, 22 Oct 2025 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="puD8JO4+";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="WeO200J3"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010F334A3BD;
	Wed, 22 Oct 2025 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140404; cv=fail; b=uydL1MRRcyl7pDPQS2A1lyeYYpShFAAIbuDSlmnRl344mohkkgOzI2exWYn9d8k6o+/zEnisZ11VuzmFBO/eL8C7lhRRg1d4pRVmUx866AY5Iz3QgIYZwE00zSy0vZY/EOb2Oo/WJb0aypVunzq/85geZqcEHfy6FfEIfe8R3lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140404; c=relaxed/simple;
	bh=c6oZztRV/ouxVVJ5p4HMHuBxUfwDNZv9lPTx2Vg0KDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZbtbpie8IwiRq939SLocCD7kgXJOrlh2j383yfYu3J1gvORv0a+n1DrT6LarEidfxL9nLqAdUuTqqMgaKUrSxtaXRgjtCz7/pZl6pMlwaI6v7dZ8WmZ87hU1Fdv/fBc21ow+6jBRYyjGpN2+UT77+19Ksm7lSzi9p9KyTGuDy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=puD8JO4+; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=WeO200J3; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59M5O60m1194831;
	Wed, 22 Oct 2025 08:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=INVzgODpWXczVd9phGl9o4BZULYn4eqBexLI5Yjfxrs=; b=
	puD8JO4+G9reuuKZL71aQHleznD1Z1SzQwubEm+7YzSdIVdBSnlr2G0DHhSkPpnD
	3NsUptjm4+77YOjWFYvfASdciz6mA000l90/S/9nu50YDAh245fimpGIaA2MqQUR
	Q0IdibaJmUcopUtHPh4xjcytgfwLSAMDK/XQWI2uFUU4FHvIsRJhOHmRB1OoK+17
	T5I4cJUzr9b2KaI6iV8OTe5W/4It+OIQucoRkUsWHTtfTwr/Gp3mpxIbck6s55FB
	SM9IrD3KfpocIOAlrX/tl3+6Zf2BV3eSnmEKHrwod6xGLakdQkVAgq4m54zwR1rz
	0zBGOophUwkNgHAANRmIlg==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022136.outbound.protection.outlook.com [40.107.209.136])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49xs380gdc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 08:39:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNqHfoTbHVe/YDPrHcDCPjQFm5pSGmSjJPvwB2aC0YEwJflWCeutSlsF99H6AA11FJ5+SCcjZRQDluoLPnc2YAA/nWsV8EYa6RU6QAOEP8ZV5ZHYqokfIvXza6E2cxWvrGnbKZLMHzhlDRqtki00Enf3y58gDYDQlvAD7sWNMh2WHGh3v4iUXJWjKBHu/hOTJ/tVymfqgw5BDMWEB+hwwkJKXpuakX5hW1Eg5MrZsFFeUVG+hlJy2uSm0lfsEkjbyjW8ot6wKZ4J1aontxRvpFmGAEsF5DdamFl3ZoU4D4RJvmvbrjiPiGaGqz6hMXXrhU4jGcxbPgpQ1VaqvaUGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INVzgODpWXczVd9phGl9o4BZULYn4eqBexLI5Yjfxrs=;
 b=phuRZHQWd+DvGignv/fE530K21yN0CL2C2GiggIBMvfRNHN7pogcNkgTgdlhu/smHeUmgp7Uy0P6P9oXSUhfMqOQIJpvcr8XKWnzBVAe1c+JHYsCVBcv46xer99ew7atyIjZFkZ6jPqatzzYCX0WB+RlN7mvcqHc1OtHpQ6TLX1DIlKgZpwOzA8YT9ubFvlJDOp5EUzc4SCChvlH3PVsX/XRuniIFABy8Z1pcqpmOzU5JhTD4jc/re5gXEi7GCEwSrft0QgAE20cvCqt6R9WTTVKG7trSR5s190+cgFXKVHmLyuDC6DvFoQgZhuqGb9mqhy6lFEpX35kCLBMNk/84A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INVzgODpWXczVd9phGl9o4BZULYn4eqBexLI5Yjfxrs=;
 b=WeO200J3AaBYDJv7mbp4j/3BBTRxW5fJ4U3Oqv1GbTTNIPY3loeJrCHyucWyhxDKvduwMlnQ0d+bNhUZh8zdL9vcLXggEJsdWsEL70LLTdUSU7ePNDfEbE9imd+N/CLWRXzcPvEXmFl4gxeoKetk59cKsffXa/j5Jg7fjrw+dTY=
Received: from BLAP220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::26)
 by PH0PR19MB4890.namprd19.prod.outlook.com (2603:10b6:510:77::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 22 Oct
 2025 13:39:35 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::9e) by BLAP220CA0021.outlook.office365.com
 (2603:10b6:208:32c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Wed,
 22 Oct 2025 13:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Wed, 22 Oct 2025 13:39:33 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 2AB2440654B;
	Wed, 22 Oct 2025 13:39:32 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id C13B1822540;
	Wed, 22 Oct 2025 13:39:31 +0000 (UTC)
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
Subject: [PATCH v5 01/12] ASoC: cs530x: Update the copyright headers
Date: Wed, 22 Oct 2025 14:38:42 +0100
Message-ID: <20251022133914.160905-2-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022133914.160905-1-vitalyr@opensource.cirrus.com>
References: <20251022133914.160905-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|PH0PR19MB4890:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3e00523b-7667-4f71-1a08-08de11706f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zF+VuHGliUm2JgOL1ScFVxMCP+yxHQYz4AcR0halja51kwYbEoWNb8lkTN9r?=
 =?us-ascii?Q?sENChP58BsoMZ6FVz3e/oTPK66VvoQSCrG8H2WvfzfTpscHxr7GcPI3eEcGe?=
 =?us-ascii?Q?KmcG6i1MxaNLhNZfffTlPDwmh/9SA6JDZ1W7cstjzBPK77fEgwqdpL/yt8Xg?=
 =?us-ascii?Q?5JeyaTXxBYzhnOGapAkrNc/q6U8yzbsouK1PUOE253UwWlGopTEGhdJO9att?=
 =?us-ascii?Q?JdxG5rcsOq0Hs4IDiXLc6PawNNuUnUrZJM0soPtDwHztb7ul8ate02BsQ5Xn?=
 =?us-ascii?Q?7d+IdBwkSxnWTo5xyaCdf3Erq/wxQeF72m9/3fO23YIgaavkZRnIYr/NQjie?=
 =?us-ascii?Q?wbCfcLh4TGGBqZX3C2fczCupDGANRIKhq16pek2LcMMhITzZOl2yYDt9lIre?=
 =?us-ascii?Q?S7TFHXQ49721a5cPjriLVz1paRtL8JK/+JpPaS3e/boUIVZ7AfSLM/RHMztf?=
 =?us-ascii?Q?GdnW53m/Led71WGer1k5YE831j2j9Z42X+/5Av5IHEDTE+jCkgU/lqEaeNet?=
 =?us-ascii?Q?5YgQvRRAkegHXWQAUPmEhsTBElZlgsbfhgS6lmIWC0aIMs5Op7MzkLNk1tew?=
 =?us-ascii?Q?/8O05/811dIdZ9pjTxgpb3dP5PVyj3b+nrFq7Rhh7kf40PqLl0iTIpveO1iP?=
 =?us-ascii?Q?N07md9fGx58DXs9uKyWww+beSe/o/xsUwxqeBWJ7rqRAlxa0kGF80+NpbZpX?=
 =?us-ascii?Q?KyE9OvyWFnHJB6rMi1WK4qhjsZ/fAoIh+MT3daIyzUyB3R20335/l/o/QKc8?=
 =?us-ascii?Q?XP7EhC+8drTU0YzFQPDxM+rZY9mdaUaIh74FWS9lJa+DKZMrkKXAwjI61MzB?=
 =?us-ascii?Q?HaXkv5imbo2FkUkV1I7y6Jb6zu1kNHMwjIh9goJPIfhHyWcqnvNsZfC4JzS4?=
 =?us-ascii?Q?iOQZxx7/VkJgiiAZUl2aKoF/ZlRbSXTeqCirZLJERvIRDEPz2RxH4wEs3zNE?=
 =?us-ascii?Q?7RUaKiT76hMHLuTMF85TqCeXRS6qJ1tfh/H1Yu5JaAXEqw3V6ojbOI1m+e9G?=
 =?us-ascii?Q?KHzycmEiV8xH+DHD3oVVuG8cd5dj793kbzoD+ag6+nsUcY89I4KxmDsI9q2d?=
 =?us-ascii?Q?Ukl1SkPVhoHNRxsX8FneFT5ijOiWMEvLzW1WoxjF+96MzI9Ywi8QAWfNZmbt?=
 =?us-ascii?Q?+3rwh+8di0uCGNZnbzBXctrc3cMH+ESrHOGsAN6CSlOUVvjCsZ3g8MYor3br?=
 =?us-ascii?Q?3iMh0VBjv+EiDHzt6DCKbHMC2Z4AzMF86SxgC8OWReXQhv7out/E5BCxrtKW?=
 =?us-ascii?Q?Zk7iV4YhCph8JHLRgMCXGokh/YjbLT2TVi+PMVJX2kekuwgDDQUgT9XdpB6p?=
 =?us-ascii?Q?0vN57dLJLJclbZEXsXjDvlrAFX56YNKOhyRf/QygL7qSw/fE40mTXzGHB76q?=
 =?us-ascii?Q?nO3UIqLFipSYpwoxaPfjX7sXFitEzk2PaXGfHqUsICqULrayDeXc/YL2yjeP?=
 =?us-ascii?Q?KgMy/nv5L8FgCNfl9Hg3uQNbcozXhzb2hssJZaiQKwb6isEdxM9KcluRaVCk?=
 =?us-ascii?Q?T38mHXWcNRyCDtogC3ROUuvQW5pUBTiYux5yEANv/QZEYOOyWjZxd8WdIS/p?=
 =?us-ascii?Q?0MSPnOT74meKmFH8vFw=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:39:33.0039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e00523b-7667-4f71-1a08-08de11706f2a
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4890
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDExMiBTYWx0ZWRfXxgDdTY0rCXUf
 K4pFze+2NluN4iPoBKOjuW1WCdYFcEuBvRWn2KrE2sx3tAzoVlqR+s7hV6r8SMMuqUmdX5RFyxl
 aYxwHhrf7X+E71RgEbyZyOPuW6dZJIWtnZ9qAfgQdi0v88TeXF4DpPZzLXNzU3b0xDGCeUf1MCA
 CFYrkoPnz/qff2S+B3D0gSGPwIEi3S9NMt3sg6OIfLRQEWP8NGN0qlI5TL9+njTEzSlUN0LR7DO
 RPVZLfccIK5BFnAgyclx5IrVU1qa5fOz1tHEWmVTLTJgBTLA1eC4b7fSu8KAxlBqoQJeN7aaJCB
 98jWcxTRm/DNGsu82o57GXHj8LRXolsr9Mihs1B5IwrRmSUhIaPT+8HqwyJAnQQllAAgK2+VR2n
 386vKJc3NOuazYKDvY/S7HmFUct8HA==
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=68f8de9a cx=c_pps
 a=aZOTJIJ1i17uwAYHC389yQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=SQtk40xCRQeN874b5x4A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: AIgNW0N79a0MKGMpq117IY4MAzUcGbly
X-Proofpoint-ORIG-GUID: AIgNW0N79a0MKGMpq117IY4MAzUcGbly
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x-i2c.c | 4 ++--
 sound/soc/codecs/cs530x.c     | 4 ++--
 sound/soc/codecs/cs530x.h     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs530x-i2c.c b/sound/soc/codecs/cs530x-i2c.c
index 22b1a4d6b61c..be80dcad3647 100644
--- a/sound/soc/codecs/cs530x-i2c.c
+++ b/sound/soc/codecs/cs530x-i2c.c
@@ -2,8 +2,8 @@
 //
 // CS530x CODEC driver
 //
-// Copyright (C) 2024 Cirrus Logic, Inc. and
-//                    Cirrus Logic International Semiconductor Ltd.
+// Copyright (C) 2024-2025 Cirrus Logic, Inc. and
+//                         Cirrus Logic International Semiconductor Ltd.
 
 #include <linux/device.h>
 #include <linux/module.h>
diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 0dbc5fb92290..88084e7d6447 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -2,8 +2,8 @@
 //
 // CS530x CODEC driver
 //
-// Copyright (C) 2024 Cirrus Logic, Inc. and
-//                    Cirrus Logic International Semiconductor Ltd.
+// Copyright (C) 2024-2025 Cirrus Logic, Inc. and
+//                         Cirrus Logic International Semiconductor Ltd.
 
 #include <sound/core.h>
 #include <linux/delay.h>
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index f473e33eb835..b325847036e9 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -2,7 +2,7 @@
 /*
  * CS530x CODEC driver internal data
  *
- * Copyright (C) 2023-2024 Cirrus Logic, Inc. and
+ * Copyright (C) 2023-2025 Cirrus Logic, Inc. and
  *                         Cirrus Logic International Semiconductor Ltd.
  */
 
-- 
2.43.0


