Return-Path: <linux-kernel+bounces-891472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6297AC42BA4
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 12:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40AE04E1D55
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 11:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F143009EA;
	Sat,  8 Nov 2025 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ItA0zn8p"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC7521ABC1;
	Sat,  8 Nov 2025 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762600120; cv=fail; b=oVweHMXvghbWt1o6jD13+ZwbRLaCauM4ag2UVbqzBV3Vnn+MoFSXKuXpoTomrbjIpCjWwsacjaf6VskiHdXT4KkcMVnYMNg/+/99T36ENKk4LAxIY8noBDHEvv8TI4LmrHNIMdeqoL/i96fQV+vDrxzwUwyfpg/RG56jBEgx428=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762600120; c=relaxed/simple;
	bh=kx7DX+9g8L7Fbh8Ep0JA9CExHxpJgIU0P5pZTvtVSEI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PIdUzE+GdzufU+v0eWNYjzO0YWY1p+AMz/3mYRlwI1VTCdYxB8yjlC0HwE6y4//eBr1+0UclpLQkqqBKr+csbB1qxeIHT3CEor5p7DhApTGdzMsJZNfbEGueRVTpbJHKsqy1WtxXRe6DaQjeS+qmwby/Fyw8uI3QuvvQUEaaDMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ItA0zn8p; arc=fail smtp.client-ip=52.101.61.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcltEBsFV+d+RfnfcNvLXLubQMFA8mNVUe5L59KPe//R5VVesQ8AYJh8AcmVi9KI8GS+/Uw09qmmNxgrYmI7MxmnCcFVhTZXqqz25zKUoSk9eTQnysStsFQGUHyLTrer6UOPs+Foho8xzoK1vmbNQs31M4Z+YvTM7LMPgid1ktOqD/XAysY9zIeTKbuSV8uc3pmlP3qKQH5fW0Yq7Dw/hhlsovax0fNPeiYBewM6fCbaMiNijMP8oa0iFoGic5zJy7Fr+l600aimNw2rDDELhoViltE3iHlkisMuA5azDanZwnlmtwoGjwWitOjYhcaSuYhNYgVIIb1HNAKcLyF6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2aZPtH1GC0scDj8mJ++yLwfLSaqQFvnt8gmYqukmeo=;
 b=Q3LgzG7rRHCqIejALPxTQ+Q3fxUUSgqNEa2Eue8ap+ca05+qTw+twX1r7+Nlt5posO5PiEDSiqFSdVDE1MmJI5nMpA0XK2sxQ9W4+0bzjx4QzL17d1mLugbvkCcKOAD4+CRG4JsiAn0x/HZwgilMBPCmJYSCJuV/FZ4VkaBF3yPflpJnYZiyHBmev6RNxW8jsDO+JGJ6im7odXF7DV61FVhengh3y0UkmjSdMZ83m6id2Hz8WuurvScg5wxVVeGHBvgGh4uH5/ByNf0kvrZ/6MI/3fKitzqgDoG6661BeJj41wiYiULX9IxR2ISbngo69+5RsHjNBCErxbTdYSWdOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=google.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2aZPtH1GC0scDj8mJ++yLwfLSaqQFvnt8gmYqukmeo=;
 b=ItA0zn8pHsYiuh044ZqmWBpJPshMque7kzC6TjCBp2DyZUXIZgYQG8Fml+7yzoqjGvAGMbnVs7NVZYBu3l/FKx/k8fQtoxuZmWs0DPX/FZT0l39ll5fIAKaHAtNOfVrhBvFPAqBqEBzyRG0qSRkqURhKKXP8Sh8Qf6MfEa3fvL8=
Received: from DS7PR03CA0269.namprd03.prod.outlook.com (2603:10b6:5:3b3::34)
 by IA1PR10MB7359.namprd10.prod.outlook.com (2603:10b6:208:3fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Sat, 8 Nov
 2025 11:08:35 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::c2) by DS7PR03CA0269.outlook.office365.com
 (2603:10b6:5:3b3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Sat, 8
 Nov 2025 11:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Sat, 8 Nov 2025 11:08:34 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 8 Nov
 2025 05:08:32 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 8 Nov
 2025 05:08:32 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 8 Nov 2025 05:08:32 -0600
Received: from lelvem-mr05.itg.ti.com ([10.250.165.138])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A8B8OGe356676;
	Sat, 8 Nov 2025 05:08:24 -0600
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>, <tiwai@suse.de>
CC: <andriy.shevchenko@linux.intel.com>, <13916275206@139.com>,
	<shenghao-ding@ti.com>, <baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<k-yi@ti.com>, <henry.lo@ti.com>, <robinchen@ti.com>, <jesse-ji@ti.com>,
	<will-wang@ti.com>, <jim.shil@goertek.com>, <toastcheng@google.com>,
	<chinkaiting@google.com>
Subject: [PATCH v1 1/2] ASoC: tas2781: Add tas2568/5806m/5806md/5830 support
Date: Sat, 8 Nov 2025 19:07:58 +0800
Message-ID: <20251108110759.2409-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|IA1PR10MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: f1860f4c-febb-462f-108b-08de1eb728e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0yN5Bu4nQKssCQAUG5kcfaEX9I07btDqIS+WTHjdBaQFSbvmO+VPXrnqQEKy?=
 =?us-ascii?Q?yTPGidBiZMZ4OKkEJ35nCUdEAwS1EwFcTn4uuAyMu7U/cMkT/LWAdckIugE6?=
 =?us-ascii?Q?GE/uJDM5UVxiAIFA36yscLfX6rSU5rBaftFvQSdQDATY6moec1ITTxMuBfBB?=
 =?us-ascii?Q?GoMLfetbYf+z/mpyfwBY1MMSbmNXS1lqpVIuM+RGd/Rt/Bdf6M46gX/g5Gwd?=
 =?us-ascii?Q?IFYd1ZtmMDZw29QhvQbbe1RzWogrw6ZypdIBMF3YaZD4VrTXVRsXbPqx0SLm?=
 =?us-ascii?Q?GBadvpizHBWD2Mtxncmz+fM+BYBz/db5yOv3tlBuQAH9Bz47KDiyH1Q6sJrZ?=
 =?us-ascii?Q?u6GtkNt9zYR2CEQtqjXk6evzGMwH4dNK1/cfd8lCb6xKQtkkRuZ4POGVJzBf?=
 =?us-ascii?Q?EUMjGBM3B6VJYQfDrmZPuK4GwvXIA5dLTFekNBC/A1TMhtj23H7iDIoGHLzY?=
 =?us-ascii?Q?apqU4ilIApNACvboM76QUkDJInzN8CTvOihD4nu0z3sx7CscNh+GCpphoMoK?=
 =?us-ascii?Q?TfGJ4ZogzcchSNdmBtWEbtEvoW6560KwcfCpk4yFILyPVEjFgeqqbkmqaJvP?=
 =?us-ascii?Q?fCDRobk/RHq0dBJBXcVH5fklthi/UKHNyKok+EisBimLWeCaukJcD2d/Jf8Q?=
 =?us-ascii?Q?bTN0YMTOjwzRLCLCui0iOO6SMQmyCQCHAsLdgy8Q2EM2O0sIzWdTsO2aWHwg?=
 =?us-ascii?Q?+rBy+mKBFeDhgXJvb/h0cRXvkzoY92uyDRw4mzPMudRMc9NjVzMoAMcltY4D?=
 =?us-ascii?Q?L/cR9hq5pGd7gB30Dc+A+MvPmTUH79J1/yD4eOCpCrg1d1Vz8e2hxKki/V4y?=
 =?us-ascii?Q?66by6pJ6GLXkD0M0CNEfMr3WHISInHi91mVZDDCwZSX8C0BYt/5nnOjT+P2g?=
 =?us-ascii?Q?EaeJ1i4YEaNoC298F0aPOzaehBiq1keTC7EU+6dZOpxqGmjqqThPLlvIlMrf?=
 =?us-ascii?Q?CqSTOL08zrDvYUcZetzUSyrq5UsU1B/JhOR/CLiGKvHivaRAvX9WFtQT7wDO?=
 =?us-ascii?Q?eQuJEDWjlvSA+MDv3orddXnOeOjw6xLAF5B/AEII+uQomHTRKmtpUv1Vo+Mq?=
 =?us-ascii?Q?qZNp3hYI3nRHNdpqNKM1K9tZknkobqcTRIrtYcPhJQW7IBsF8qwzK91cyJIp?=
 =?us-ascii?Q?aDabzM4z4QFZIRxMjYDq5GA8OrwVCThYZcoGOn5t7Z0XULPVB7VVfwADt/Xx?=
 =?us-ascii?Q?9zQ1KQC5a08iR/57bIWwOuWCc5gMz8iIPc4dZUtcSXkPsL2Upz20KLq2vOLs?=
 =?us-ascii?Q?ZxPSIQF6NJYeMtY+2BPRtmS964XjW3h/fHrSWfbO1n++P3RwbMuozImS+57/?=
 =?us-ascii?Q?4Y7lkh9seu1ohhZc4S5jrLosnLRW6vtCxb52eP96DWein7gY0wDk9CrC+SNM?=
 =?us-ascii?Q?LomL+khpDeTwFt4q55yoTZFhvhfAmMzQQ4K60R0G/rt0GOyuJRKG8G/DRgGr?=
 =?us-ascii?Q?dv2B3teD+bEnc1X1rd4oPjhM8V30L5qTHZ7IhY4/3wF/fCJvHAwBya51rfnf?=
 =?us-ascii?Q?Ng+pe4kfZmJEkHvFFzNqGfhEbM+iW4MLE6kVv8QjTsJ6HtdWEOXksKZRra4L?=
 =?us-ascii?Q?/eIyY6Feozz1yWDOzd0=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 11:08:34.6368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1860f4c-febb-462f-108b-08de1eb728e3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7359

TAS5806M, TAS5806MD, TAS5830 has on-chip DSP without current/voltage
feedback, and in same family with TAS58XX.
TAS2568 is in family with TAS257X.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 include/sound/tas2781.h        |  4 ++++
 sound/soc/codecs/tas2781-i2c.c | 24 +++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index c3b4c43dd2bf..879eb16cbc1f 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -117,15 +117,19 @@ enum audio_device {
 	TAS2120,
 	TAS2320,
 	TAS2563,
+	TAS2568,
 	TAS2570,
 	TAS2572,
 	TAS2781,
 	TAS5802,
+	TAS5806M,
+	TAS5806MD,
 	TAS5815,
 	TAS5822,
 	TAS5825,
 	TAS5827,
 	TAS5828,
+	TAS5830,
 	TAS_OTHERS,
 };
 
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 7bd98ff5a250..e8d9db401086 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -105,15 +105,19 @@ static const struct i2c_device_id tasdevice_id[] = {
 	{ "tas2120", TAS2120 },
 	{ "tas2320", TAS2320 },
 	{ "tas2563", TAS2563 },
+	{ "tas2568", TAS2568 },
 	{ "tas2570", TAS2570 },
 	{ "tas2572", TAS2572 },
 	{ "tas2781", TAS2781 },
 	{ "tas5802", TAS5802 },
+	{ "tas5806m", TAS5806M },
+	{ "tas5806md", TAS5806MD },
 	{ "tas5815", TAS5815 },
 	{ "tas5822", TAS5822 },
 	{ "tas5825", TAS5825 },
 	{ "tas5827", TAS5827 },
 	{ "tas5828", TAS5828 },
+	{ "tas5830", TAS5830 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, tasdevice_id);
@@ -125,15 +129,19 @@ static const struct of_device_id tasdevice_of_match[] = {
 	{ .compatible = "ti,tas2120" },
 	{ .compatible = "ti,tas2320" },
 	{ .compatible = "ti,tas2563" },
+	{ .compatible = "ti,tas2568" },
 	{ .compatible = "ti,tas2570" },
 	{ .compatible = "ti,tas2572" },
 	{ .compatible = "ti,tas2781" },
 	{ .compatible = "ti,tas5802" },
+	{ .compatible = "ti,tas5806m" },
+	{ .compatible = "ti,tas5806md" },
 	{ .compatible = "ti,tas5815" },
 	{ .compatible = "ti,tas5822" },
 	{ .compatible = "ti,tas5825" },
 	{ .compatible = "ti,tas5827" },
 	{ .compatible = "ti,tas5828" },
+	{ .compatible = "ti,tas5830" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tasdevice_of_match);
@@ -1643,6 +1651,7 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 	case TAS2118:
 	case TAS2120:
 	case TAS2320:
+	case TAS2568:
 	case TAS2570:
 	case TAS2572:
 		goto out;
@@ -1670,9 +1679,7 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 	}
 	tas_priv->fw_state = TASDEVICE_DSP_FW_ALL_OK;
 
-	/* There is no calibration required for
-	 * TAS5802/TAS5815/TAS5822/TAS5825/TAS5827/TAS5828.
-	 */
+	/* There is no calibration required for TAS58XX. */
 	if (tas_priv->chip_id < TAS5802) {
 		ret = tasdevice_create_cali_ctrls(tas_priv);
 		if (ret) {
@@ -1728,11 +1735,14 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 		case TAS2563:
 		case TAS2781:
 		case TAS5802:
+		case TAS5806M:
+		case TAS5806MD:
 		case TAS5815:
 		case TAS5822:
 		case TAS5825:
 		case TAS5827:
 		case TAS5828:
+		case TAS5830:
 			/* If DSP FW fail, DSP kcontrol won't be created. */
 			tasdevice_dsp_remove(tas_priv);
 		}
@@ -1883,6 +1893,7 @@ static int tasdevice_codec_probe(struct snd_soc_component *codec)
 	case TAS2118:
 	case TAS2120:
 	case TAS2320:
+	case TAS2568:
 	case TAS2570:
 	case TAS2572:
 		p = (struct snd_kcontrol_new *)tas2x20_snd_controls;
@@ -1894,11 +1905,14 @@ static int tasdevice_codec_probe(struct snd_soc_component *codec)
 		size = ARRAY_SIZE(tas2781_snd_controls);
 		break;
 	case TAS5802:
+	case TAS5806M:
+	case TAS5806MD:
 	case TAS5815:
 	case TAS5822:
 	case TAS5825:
 	case TAS5827:
 	case TAS5828:
+	case TAS5830:
 		p = (struct snd_kcontrol_new *)tas5825_snd_controls;
 		size = ARRAY_SIZE(tas5825_snd_controls);
 		break;
@@ -2072,15 +2086,19 @@ static const struct acpi_device_id tasdevice_acpi_match[] = {
 	{ "TXNW2120", TAS2120 },
 	{ "TXNW2320", TAS2320 },
 	{ "TXNW2563", TAS2563 },
+	{ "TXNW2568", TAS2568 },
 	{ "TXNW2570", TAS2570 },
 	{ "TXNW2572", TAS2572 },
 	{ "TXNW2781", TAS2781 },
 	{ "TXNW5802", TAS5802 },
+	{ "TXNW806M", TAS5806M },
+	{ "TXNW806D", TAS5806MD },
 	{ "TXNW5815", TAS5815 },
 	{ "TXNW5822", TAS5822 },
 	{ "TXNW5825", TAS5825 },
 	{ "TXNW5827", TAS5827 },
 	{ "TXNW5828", TAS5828 },
+	{ "TXNW5830", TAS5830 },
 	{},
 };
 
-- 
2.25.1


