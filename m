Return-Path: <linux-kernel+bounces-578500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4843DA732DF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 14:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD8D17D3D2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 13:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFA7215186;
	Thu, 27 Mar 2025 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="NlY3hP6P";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="YIRKOeGJ"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE3C2080E7;
	Thu, 27 Mar 2025 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743080444; cv=fail; b=vBqV+omMA/y3Xmc5ljI7pp6x90XyfLESAVWi0XgMGAGFYUbO+VTZlEjv8jft0OKU+qNg8ZsNKBYMMSyfD0xCcWVYffpQ+8SWQv3yIVrGRG9KjJZl5ZQJJqJlqxxdlOkW59cPPqu/EfUIb1dOWnjFmP/Oh3pFXpNb1kK8/DVbObM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743080444; c=relaxed/simple;
	bh=tJG2Sazi0BUo74qTxyNbNJ/fyybb4EgGNdaeyZfHaaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3mxLEK+qd1r9/CcqVuV+C/xzWdZcQ0VAElxPfCjlfVmVuNo4lWsvQfHSTJ3fGiWqIOXP5eua3LOg+za2d4wRz8z8k0w4bBsncSfrBUwVCvX6ISK1rCw4nwM52lK5ZBZYgXyX+GjWnCapZqw1xzfabm9Vq+BhEdFNNhG4BN0Ksw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=NlY3hP6P; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=YIRKOeGJ; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R8ZkpT032284;
	Thu, 27 Mar 2025 08:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=l3EaKWMZkap09D7CsI56PjE5mCECqTX8c45Loa9lEUI=; b=
	NlY3hP6PaEj/6dWKhiM9dXqrcWs0vr+8YEI3ohPInfWfYu1kMhfmKaRqNxbBVVU9
	BAlkL4h5CnsKcybHbyqDCUVwG8UjU5vQMyQKBr+DvThDsgHlfcgkXuy+DHquC92F
	KLfKmZhQw5KWXS3f6HPBdxYY9oZ2gbAkdlM9QUx2gtsaiIUar41y7uxMyjKzAPB/
	jhnFJeJS6aaPt8nY9JsH+g+qcmqnD8Ue5hUi3NZHQ4QgwjconSz9AN9yU8DNrIuj
	TUm/lnaVEDVyS15SRHhghJLva3jPFu3Hh3RNH8S/NihMuPFeFpfelo0xe+ycSqkm
	9Td/fEOCkUhj58lNrWRMJw==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45kmrgvq53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 08:00:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgYm4cuJPwCULu8sryV3cQeukkDX7+PLe6CKaBfjAq1A5J3u7LcBW8eG5sGiDbXBR5o3O2rgGe+I7voP/NBhHR2P1gFtjOSvW/nIEiciIn+0jmEY1kfIv+vrAGBb+dlF/HbuS0j7+BdfkVaM6ronpyT4MSd1V4mc1mf2Qrknf7Oz7t0YTOUmHJD0RmpvEIr75ldheuPI/ijRHmBZrSy3rPYqbhJqdPsucq36W7q9B3YFYF2hFsY2ShaqeK0YHo5GvEJgUYVB8OP5PRvvTCHb/ZTP3SorpeHF2z5CiAS/K3PBvrynoRn9qYQWRL5Z/PHVRBdXdicFVhI1b5gVPUHmlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3EaKWMZkap09D7CsI56PjE5mCECqTX8c45Loa9lEUI=;
 b=D0AlbCc4Q2DF6ziU64HXk7LxfNke+/LbpcchlFBkvbWBNLx72gEYy5IDOtEweAM+31mQ5WM+lS7iLywMRyGhDxLGt5wtOD5sMHambFMXJQhZ2DhlF+GC07OzigZgMsHqHEWtq1wRIph/GamHWEZ3Jsj0IIQZ5lARf3eP5Oye7cBzZ54YtwPBcVIF1ePZ9WkvOscIv8kPbyD/SVvwsxJTb/I+dMAVsxv9bu7AQm/+3NkKbhDLEu2Hrqtn7DCegNLMu0mNSPsd4SmcEmoUe73WGxTR2/GUy/4OnJD1pL5tifP7F+rExPGgqo5QVutSnq1pxGQ7/ZGUaRyqwfd5q/oQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3EaKWMZkap09D7CsI56PjE5mCECqTX8c45Loa9lEUI=;
 b=YIRKOeGJdjBdXWBe832s+0OkxCM+qR+P3IpXmggHlnz2ywBZsuGl7SoV3yTK+hJu2NsE3eMO6AA1BpbwAXs1CRqcdI4uvq56LdGUumieqKx+6tyMHvCY+TIpS/LPVtclU0xN/ObKwW3ZFOpGn6HSANUWF7GNtc0hx0ORnDOIlxE=
Received: from CH0PR07CA0018.namprd07.prod.outlook.com (2603:10b6:610:32::23)
 by SA1PR19MB6870.namprd19.prod.outlook.com (2603:10b6:806:257::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 13:00:15 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::3) by CH0PR07CA0018.outlook.office365.com
 (2603:10b6:610:32::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.44 via Frontend Transport; Thu,
 27 Mar 2025 13:00:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Thu, 27 Mar 2025 13:00:14 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 00197406543;
	Thu, 27 Mar 2025 13:00:13 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id CAC7882255D;
	Thu, 27 Mar 2025 13:00:12 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, pierre-louis.bossart@linux.dev,
        yung-chuan.liao@linux.intel.com, peter.ujfalusi@linux.intel.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH v2 2/3] ASoC: SDCA: Create ALSA controls from DisCo
Date: Thu, 27 Mar 2025 13:00:11 +0000
Message-Id: <20250327130012.3378732-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250327130012.3378732-1-ckeepax@opensource.cirrus.com>
References: <20250327130012.3378732-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|SA1PR19MB6870:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c145f8ed-07a4-402c-c38f-08dd6d2f50cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/LVO5irCTd4OBNTTiYWuTcoJyxuH7g7Rs0cVo2IKm/0LpE1/+ER58rRa4Lv+?=
 =?us-ascii?Q?D5c3SpOKqBda5oP4HLrXl/2xWs2loRF29cTuGXZhyYQ9C8xlgNyXHSmN/E8m?=
 =?us-ascii?Q?cLGrMJyf+DDijMiveMwrfmEL9BMxBItlkuZ70MXoCRol1DKnJX4RL9wUbbgq?=
 =?us-ascii?Q?atf1ZKOgPWkLsj+gaciT24nQBllvp7pW/V4sH1bdbsmSx8kIOTEjqpegi7BU?=
 =?us-ascii?Q?nqpwJbfcEGcn8g9s1coHAIor1YhH0fKztOdr3r8lE2gLo8EQCnyIdhsf8d8r?=
 =?us-ascii?Q?x9Na+dX44K5KWcEoVAM1f//k9seOOBoUzb3kIiSHNyPO2i6V+0fNM0MuiHGl?=
 =?us-ascii?Q?YuVjghNwZCmcLiCtX0MRLreZK9NpsN7PH7rqFb8ysRh+bRW3hrwlHvYJGBrl?=
 =?us-ascii?Q?Ixqok/lrgJDxz4sk7plFZxF2a+3jxJYonV1CxpRBUgZqybuGDm9sFxG8ij9U?=
 =?us-ascii?Q?54hP/Qxedk/QaVqngPgI0gIvw0Y75puuNh8upWwlZc0+id/UowsB44Vw92pJ?=
 =?us-ascii?Q?dmdxiwvOGrdK2qq4HJoWihRQ4/3EW+VFG1CfJE+AbLqK4q/Z8kJII1zjK2LS?=
 =?us-ascii?Q?zuMxWaUZ1jVrr/YNXYH4WQ8Ao64BjZkMCmE2+xmYKCTgI224ehyuBMa5L+9B?=
 =?us-ascii?Q?cR9Uagzgtjlw89q2u6syn4WMU4H+XAspXcjLZKe6VgyIeuYwXYlnvOnF5Ttz?=
 =?us-ascii?Q?ULVtNjdX2axnwY5za6od6opPKIaYW24OTTXVNGo+je527EsJXLem3r3tE8RV?=
 =?us-ascii?Q?XJsvp34WdwatACszErkCcUj3UhA47c9HJ8n5/RFYdpWEiDyovNihU2UY2mH+?=
 =?us-ascii?Q?5zrJeVQLiX5HJf5jFXY1KULGAZ22ePVWQQzqthC9nHSW+IgphouctqvlwnL9?=
 =?us-ascii?Q?T9XgpZceDoQZEiDmiJu4U6JhXOTzySYjyM/+diQhHTw7l9CuPBw8zTKi0Nnm?=
 =?us-ascii?Q?rGQg/EBCZ8w2VxVP2xsR4Fgwp/uI594BeWfO9w1enFQNbkxKvXD9BE/RlCCP?=
 =?us-ascii?Q?8BMMe4JpilinCWawz4eno9tmgAhWAOn5PVVn172g2pfrpJRa7D5CRHPRrjHk?=
 =?us-ascii?Q?zJwZi0vTTptKoAWdVmrlN+SfRkrrmEDJgKA94kOjTzz1cc6jITWXOZTkQsu+?=
 =?us-ascii?Q?D7Jiztv3yDemH7S+0kEeijjiOx31UeVW2PWCTSETmZhszKKoLCZOCTro29E6?=
 =?us-ascii?Q?JAY6uZN/VvQFJlPHUvdqij0xJs1E9wUlj3N/LK79fSCNDFg8fk0IV8K6780L?=
 =?us-ascii?Q?2f4fuy7mLN4oz5kSlguFpCsR81TaFn6YFx/gX3Q+nXM6kYPtXgDbqZLpU8lH?=
 =?us-ascii?Q?VhOFIUVbO22saoebvcrousM1/AUd/e7sFYvgKSB4Ph+B5oorf6BGD8KcUAfz?=
 =?us-ascii?Q?6BVHPSUVpmVciCfZmv9Dqj9jMZ64gIRCtG7qd1yC1qe+Sz0nulAkGpBY5sra?=
 =?us-ascii?Q?vXu3H8T+c7hrX9u0b+1/brKUC+lhgEeNUhZPdbPnet+iersW/p/fk2ZQyRfA?=
 =?us-ascii?Q?DmqtzefWQA565Zo=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 13:00:14.0531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c145f8ed-07a4-402c-c38f-08dd6d2f50cd
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB6870
X-Authority-Analysis: v=2.4 cv=GrdC+l1C c=1 sm=1 tr=0 ts=67e54be7 cx=c_pps a=o99l/OlIsmxthp48M8gYaQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Vs1iUdzkB0EA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=x5gQ8A518QfWKtYHqdsA:9 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-GUID: oTW3JEk89FJ0wkylzs24dC6uK91evQff
X-Proofpoint-ORIG-GUID: oTW3JEk89FJ0wkylzs24dC6uK91evQff
X-Proofpoint-Spam-Reason: safe

Use the previously parsed DisCo information from ACPI to create the
ALSA controls required by an SDCA Function. This maps all User and
Application level SDCA Controls to ALSA controls. Typically controls
marked with those access levels are just volumes and mutes.

SDCA defines volume controls as an integer in 1/256ths of a dB and
then provides a mechanism to specify what values are valid (range
templates). Currently only a simple case of a single linear volume
range with a power of 2 step size is supported. This allows the code
to expose the volume control using a simple shift. This will need
expanded in the future, to support more complex ranges and probably
also some additional control types but this should be sufficient to
for a first pass.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v1.

 include/sound/sdca_asoc.h     |   6 +-
 include/sound/sdca_function.h |  10 ++
 sound/soc/sdca/sdca_asoc.c    | 191 +++++++++++++++++++++++++++++++++-
 3 files changed, 202 insertions(+), 5 deletions(-)

diff --git a/include/sound/sdca_asoc.h b/include/sound/sdca_asoc.h
index 414d461b6fc4..d19e7e969283 100644
--- a/include/sound/sdca_asoc.h
+++ b/include/sound/sdca_asoc.h
@@ -12,16 +12,20 @@
 
 struct device;
 struct sdca_function_data;
+struct snd_kcontrol_new;
 struct snd_soc_component_driver;
 struct snd_soc_dapm_route;
 struct snd_soc_dapm_widget;
 
 int sdca_asoc_count_component(struct device *dev, struct sdca_function_data *function,
-			      int *num_widgets, int *num_routes);
+			      int *num_widgets, int *num_routes, int *num_controls);
 
 int sdca_asoc_populate_dapm(struct device *dev, struct sdca_function_data *function,
 			    struct snd_soc_dapm_widget *widgets,
 			    struct snd_soc_dapm_route *routes);
+int sdca_asoc_populate_controls(struct device *dev,
+				struct sdca_function_data *function,
+				struct snd_kcontrol_new *kctl);
 
 int sdca_asoc_populate_component(struct device *dev,
 				 struct sdca_function_data *function,
diff --git a/include/sound/sdca_function.h b/include/sound/sdca_function.h
index 83fedc39cf71..77ffb1f4e1ca 100644
--- a/include/sound/sdca_function.h
+++ b/include/sound/sdca_function.h
@@ -206,6 +206,16 @@ enum sdca_fu_controls {
 	SDCA_CTL_FU_LATENCY				= 0x10,
 };
 
+/**
+ * enum sdca_volume_range - Column definitions for Q7.8dB volumes/gains
+ */
+enum sdca_volume_range {
+	SDCA_VOLUME_LINEAR_MIN				= 0,
+	SDCA_VOLUME_LINEAR_MAX				= 1,
+	SDCA_VOLUME_LINEAR_STEP				= 2,
+	SDCA_VOLUME_LINEAR_NCOLS			= 3,
+};
+
 /**
  * enum sdca_xu_controls - SDCA Controls for Extension Unit
  *
diff --git a/sound/soc/sdca/sdca_asoc.c b/sound/soc/sdca/sdca_asoc.c
index c91660f8dd4f..a3184189eda0 100644
--- a/sound/soc/sdca/sdca_asoc.c
+++ b/sound/soc/sdca/sdca_asoc.c
@@ -21,6 +21,7 @@
 #include <sound/soc.h>
 #include <sound/soc-component.h>
 #include <sound/soc-dapm.h>
+#include <sound/tlv.h>
 
 static struct sdca_control *selector_find_control(struct sdca_entity *entity,
 						  const int sel)
@@ -69,13 +70,24 @@ static struct sdca_control_range *selector_find_range(struct device *dev,
 	return control_find_range(dev, entity, control, cols, rows);
 }
 
+static bool exported_control(struct sdca_control *control)
+{
+	/* No need to export control for something that only has one value */
+	if (control->has_fixed)
+		return false;
+
+	return control->layers & (SDCA_ACCESS_LAYER_USER |
+				  SDCA_ACCESS_LAYER_APPLICATION);
+}
+
 int sdca_asoc_count_component(struct device *dev, struct sdca_function_data *function,
-			      int *num_widgets, int *num_routes)
+			      int *num_widgets, int *num_routes, int *num_controls)
 {
-	int i;
+	int i, j;
 
 	*num_widgets = function->num_entities - 1;
 	*num_routes = 0;
+	*num_controls = 0;
 
 	for (i = 0; i < function->num_entities - 1; i++) {
 		struct sdca_entity *entity = &function->entities[i];
@@ -97,6 +109,11 @@ int sdca_asoc_count_component(struct device *dev, struct sdca_function_data *fun
 
 		if (entity->group)
 			(*num_routes)++;
+
+		for (j = 0; j < entity->num_controls; j++) {
+			if (exported_control(&entity->controls[j]))
+				(*num_controls)++;
+		}
 	}
 
 	return 0;
@@ -771,16 +788,172 @@ int sdca_asoc_populate_dapm(struct device *dev, struct sdca_function_data *funct
 }
 EXPORT_SYMBOL_NS(sdca_asoc_populate_dapm, "SND_SOC_SDCA");
 
+static int control_limit_kctl(struct device *dev,
+			      struct sdca_entity *entity,
+			      struct sdca_control *control,
+			      struct snd_kcontrol_new *kctl)
+{
+	struct soc_mixer_control *mc = (struct soc_mixer_control *)kctl->private_value;
+	struct sdca_control_range *range;
+	int min, max, step;
+	unsigned int *tlv;
+	int shift;
+
+	if (control->type != SDCA_CTL_DATATYPE_Q7P8DB)
+		return 0;
+
+	/*
+	 * FIXME: For now only handle the simple case of a single linear range
+	 */
+	range = control_find_range(dev, entity, control, SDCA_VOLUME_LINEAR_NCOLS, 1);
+	if (!range)
+		return -EINVAL;
+
+	min = sdca_range(range, SDCA_VOLUME_LINEAR_MIN, 0);
+	max = sdca_range(range, SDCA_VOLUME_LINEAR_MAX, 0);
+	step = sdca_range(range, SDCA_VOLUME_LINEAR_STEP, 0);
+
+	min = sign_extend32(min, control->nbits - 1);
+	max = sign_extend32(max, control->nbits - 1);
+
+	/*
+	 * FIXME: Only support power of 2 step sizes as this can be supported
+	 * by a simple shift.
+	 */
+	if (hweight32(step) != 1) {
+		dev_err(dev, "%s: %s: currently unsupported step size\n",
+			entity->label, control->label);
+		return -EINVAL;
+	}
+
+	/*
+	 * The SDCA volumes are in steps of 1/256th of a dB, a step down of
+	 * 64 (shift of 6) gives 1/4dB. 1/4dB is the smallest unit that is also
+	 * representable in the ALSA TLVs which are in 1/100ths of a dB.
+	 */
+	shift = max(ffs(step) - 1, 6);
+
+	tlv = devm_kcalloc(dev, 4, sizeof(*tlv), GFP_KERNEL);
+	if (!tlv)
+		return -ENOMEM;
+
+	tlv[0] = SNDRV_CTL_TLVT_DB_SCALE;
+	tlv[1] = 2 * sizeof(*tlv);
+	tlv[2] = (min * 100) >> 8;
+	tlv[3] = ((1 << shift) * 100) >> 8;
+
+	mc->min = min >> shift;
+	mc->max = max >> shift;
+	mc->shift = shift;
+	mc->rshift = shift;
+	mc->sign_bit = 15 - shift;
+
+	kctl->access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_READWRITE;
+	kctl->tlv.p = tlv;
+
+	return 0;
+}
+
+static int populate_control(struct device *dev,
+			    struct sdca_function_data *function,
+			    struct sdca_entity *entity,
+			    struct sdca_control *control,
+			    struct snd_kcontrol_new **kctl)
+{
+	const char *control_suffix = "";
+	const char *control_name;
+	struct soc_mixer_control *mc;
+	int index = 0;
+	int ret;
+	int cn;
+
+	if (!exported_control(control))
+		return 0;
+
+	if (control->type == SDCA_CTL_DATATYPE_ONEBIT)
+		control_suffix = " Switch";
+
+	control_name = devm_kasprintf(dev, GFP_KERNEL, "%s %s%s", entity->label,
+				      control->label, control_suffix);
+	if (!control_name)
+		return -ENOMEM;
+
+	mc = devm_kmalloc(dev, sizeof(*mc), GFP_KERNEL);
+	if (!mc)
+		return -ENOMEM;
+
+	for_each_set_bit(cn, (unsigned long *)&control->cn_list,
+			 BITS_PER_TYPE(control->cn_list)) {
+		switch (index++) {
+		case 0:
+			mc->reg = SDW_SDCA_CTL(function->desc->adr, entity->id,
+					       control->sel, cn);
+			mc->rreg = mc->reg;
+			break;
+		case 1:
+			mc->rreg = SDW_SDCA_CTL(function->desc->adr, entity->id,
+						control->sel, cn);
+			break;
+		default:
+			dev_err(dev, "%s: %s: only mono/stereo controls supported\n",
+				entity->label, control->label);
+			return -EINVAL;
+		}
+	}
+
+	mc->min = 0;
+	mc->max = (0x1ull << control->nbits) - 1;
+
+	(*kctl)->name = control_name;
+	(*kctl)->private_value = (unsigned long)mc;
+	(*kctl)->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	(*kctl)->info = snd_soc_info_volsw;
+	(*kctl)->get = snd_soc_get_volsw;
+	(*kctl)->put = snd_soc_put_volsw;
+
+	ret = control_limit_kctl(dev, entity, control, *kctl);
+	if (ret)
+		return ret;
+
+	(*kctl)++;
+
+	return 0;
+}
+
+int sdca_asoc_populate_controls(struct device *dev,
+				struct sdca_function_data *function,
+				struct snd_kcontrol_new *kctl)
+{
+	int i, j;
+	int ret;
+
+	for (i = 0; i < function->num_entities; i++) {
+		struct sdca_entity *entity = &function->entities[i];
+
+		for (j = 0; j < entity->num_controls; j++) {
+			ret = populate_control(dev, function, entity,
+					       &entity->controls[j], &kctl);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS(sdca_asoc_populate_controls, "SND_SOC_SDCA");
+
 int sdca_asoc_populate_component(struct device *dev,
 				 struct sdca_function_data *function,
 				 struct snd_soc_component_driver *component_drv)
 {
 	struct snd_soc_dapm_widget *widgets;
 	struct snd_soc_dapm_route *routes;
-	int num_widgets, num_routes;
+	struct snd_kcontrol_new *controls;
+	int num_widgets, num_routes, num_controls;
 	int ret;
 
-	ret = sdca_asoc_count_component(dev, function, &num_widgets, &num_routes);
+	ret = sdca_asoc_count_component(dev, function, &num_widgets, &num_routes,
+					&num_controls);
 	if (ret)
 		return ret;
 
@@ -792,14 +965,24 @@ int sdca_asoc_populate_component(struct device *dev,
 	if (!routes)
 		return -ENOMEM;
 
+	controls = devm_kcalloc(dev, num_controls, sizeof(*controls), GFP_KERNEL);
+	if (!controls)
+		return -ENOMEM;
+
 	ret = sdca_asoc_populate_dapm(dev, function, widgets, routes);
 	if (ret)
 		return ret;
 
+	ret = sdca_asoc_populate_controls(dev, function, controls);
+	if (ret)
+		return ret;
+
 	component_drv->dapm_widgets = widgets;
 	component_drv->num_dapm_widgets = num_widgets;
 	component_drv->dapm_routes = routes;
 	component_drv->num_dapm_routes = num_routes;
+	component_drv->controls = controls;
+	component_drv->num_controls = num_controls;
 
 	return 0;
 }
-- 
2.39.5


