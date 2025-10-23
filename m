Return-Path: <linux-kernel+bounces-866563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 053D9C00192
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C111A615BF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8C23054FB;
	Thu, 23 Oct 2025 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="o0/ANKE8";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="rUZC6+Uv"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092652FE047;
	Thu, 23 Oct 2025 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210249; cv=fail; b=dwRkUV9fYNyXlpyM983O+7yEfS6BQLguDg20t9MIgbj0V65KRPiMWEoNabIhiOBjb3G1BHgC583omBD9nSANtkM50vK7yReo51Qd+cXjzh29qzr4BPeQTbtNgSgJj42TFUkWL4zief7oTQJQ8IWS5PXx6S8O723o2ZqkZSMp30w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210249; c=relaxed/simple;
	bh=j3cvHh9MKY4mj2K0VuusgiaIEb5eBFknZsjNhYfs8HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUm8wP006ikdsSTt+zF8S8Ap+V3X7J6kA2dEPTdm/T0acKE5J+qoB9UNdZKDxCGAvWCajGLGdLDV1jD/R8/6VEat+MfowodYMVrP8DxnH/zCkDWTGb3XnWcXVDFZ4KMdkcaJQOvoT3WZcF+HpWxOhpwQ/SGAjyY0r9uqUcJGdCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=o0/ANKE8; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=rUZC6+Uv; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59MJfFdR3659668;
	Thu, 23 Oct 2025 04:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=C7tq3lVWKxkqFLfXDYYdP63ukeARPmz5S97ApwnO+qQ=; b=
	o0/ANKE8JVeQsNwo+0XFBG9ABY+b9x0pTL0lQHdUcI5ZdOSsa8ErkGBws1C1PlXw
	qDUTFWIkYQrMjZm8wr6tl/LF+Ys5DMikfbU93n1oufPlBBy1DwRMvxIhU2+PQPku
	Z/9dwXxSMZGK06GIrEmiLO0YIwl9DWoRthQrv0ZgzSligDijBAY5Md0smzmhLkXf
	S7gC+FeaibVDBLXlQvR4c1a8+mlALlqMwHmC4rZ1/m9Ih1jZYMnInWgAnOKr+YY9
	grKsREACndCi6fjEwzCAviTY/GWaJdUo0osNAXNQDwsH1XzB7Lfrv1sBsq6H0IVj
	smYgsm+9lKfIX4me/Agr7g==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022124.outbound.protection.outlook.com [40.93.195.124])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49xqmqsx4a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 04:03:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBY8bw+1rsd0uM/aiU7XFR7KaFhlmmc4F+nUJ8KLnxhwAKWJ2+CEKvaSRUcQlkzqIHZVjb4k/19QJZo7wStoPrMiXgwtj2eP4rNY41pl3n+xr/54oGrfwY9cgZ6oYaL5g34POWqDtKP3y7IN1WO10NQWdYSIXRKsoNTGuWoZTOr2hBy3LcHFZZ+ZE2zzO44GFbyipEknuZ8KldsRzdjT1TBPMaiEfR0pN+TQVRgbvh0Vtkz2UsO8/ks8KOvxkXrHuSBjuvzxnXP5qyRPFi61IPX4vjqwoz2xqQXhleuHBNFrl/+jxdAs89Wv0rngIJNTxyLU74gTb3fmcmiCo2tOHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7tq3lVWKxkqFLfXDYYdP63ukeARPmz5S97ApwnO+qQ=;
 b=CoOQKAdyKuVsplrR35JqMMzBnKWaCIn2qjkRbS8gxbNAoPYKa9OG/cXvkcFqIssUaySWIvBswYnaHOybx5J9Pg9cjXJAtPtycDaldpknbZJu4Olzy+UPrGNYm9SBciLwwIOcIGgMkam9fyBFre/ySTkm/UnQbbqxbX5kb3xnQnU3bWTYI3X7aj0Tl9NIKw7kkQCJLi95qbkFQqgCZjvt+/guWQBTRTy7vQJaBLvRUD9o5OzZQMfIQcPFDCwtCzhzXjt9QEohTFU1hW0s+KleTiddYQTkSa+H3QFUK9J01Pw0oIc4ac3WtXYLjPtzkC9V+AJzoK1aTn7r8PDmU7CKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7tq3lVWKxkqFLfXDYYdP63ukeARPmz5S97ApwnO+qQ=;
 b=rUZC6+UvM6Cjre//Ia51IvlppCNfXJvARrfa4gcUBeUfk23ywDgApmLK1d5M6LzSwUWWNzJ2Wf3WXKjhEeIZ/yCMLbt/FpET+2vlvSvWZFFM79SN3p5VQ2Zo3YD1dzvQEoaSNQLPdTqtyzqc69vVZV/9LIa1bHDf6Cc2QZX1BK4=
Received: from MN2PR15CA0036.namprd15.prod.outlook.com (2603:10b6:208:1b4::49)
 by CO1PR19MB5030.namprd19.prod.outlook.com (2603:10b6:303:d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 09:03:43 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::41) by MN2PR15CA0036.outlook.office365.com
 (2603:10b6:208:1b4::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 09:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Thu, 23 Oct 2025 09:03:42 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id AF82B40655D;
	Thu, 23 Oct 2025 09:03:41 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 56146820244;
	Thu, 23 Oct 2025 09:03:41 +0000 (UTC)
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
Subject: [PATCH v6 12/12] ASoC: cs530x: Add SPI bus support for cs530x parts
Date: Thu, 23 Oct 2025 10:03:20 +0100
Message-ID: <20251023090327.58275-13-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|CO1PR19MB5030:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e4072495-e2ad-415f-4140-08de121310f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oYNdgUBwIuhEzqzrzMDtB5KJZKeNf3zJb//tIgTnelJh7wup84xtnYYo5s2+?=
 =?us-ascii?Q?WWmnJwqHGMLQJQahECrvxWyYzp60ZOMtJEAy3ixSY9LpWTyW3JoH7M6msX5s?=
 =?us-ascii?Q?ejf90UCcS7nKm2x1tbrDXwH2hy+/w55t15DqW0v2hEiVj/VWQIpHk5yJhzA/?=
 =?us-ascii?Q?thqrMtrp8QFeJBjAn1KGRZkGBeB4kNWHWn6TEfC4ZqVNJtQ1v95jLMACGHqa?=
 =?us-ascii?Q?r+OzyEXcChAoZ5gZPQorGFD1sRPX71PIXYzPMK8b9GCmtWSwKU6Xj3FbhwNI?=
 =?us-ascii?Q?abqZ8wGBKuRPeZFr7/OeYHHwWfcbX8tQ9G7vkhxpa8oy6KfMPGJBjrhjRabI?=
 =?us-ascii?Q?FS7YtYov5M0fMPu67ogVQl0/yX65AxwrciZ5it1+tvYNzCCPQS3tSY9iDYWA?=
 =?us-ascii?Q?uK634D9J4FKrzfz+quAwQg6WcpHhLg1ZQWHCM/BRBMbYH5Cg/by+5UumKN1c?=
 =?us-ascii?Q?RrAGR+/DDaRt5BQwgHlsE2YLGWGPeyThEwclbI1/9EgO+ep1IUtKtiF/c//6?=
 =?us-ascii?Q?9A1m/lnBwq83uW/1S+2AcKnB/geTgC+P2vItWCrGYyM2b0RQna2hQd8FVbxR?=
 =?us-ascii?Q?xqZa6GKDu5g8SBUToZQ+/JXVlXv0vT22Xkzdzaf+rdxGuOv8piw4r1gl4q8I?=
 =?us-ascii?Q?JO2en0+D+A9KZSS6Wz6ugFUFZBXkkNMv6bnn1FxL9l3beiXTL5Hro7Ot8gFn?=
 =?us-ascii?Q?4r4IMVTw8B1h5vkD49EFFGGLULtsDpmZ633ABFcMu1XvuteNz4RpSVYRuu63?=
 =?us-ascii?Q?rgdS0JsCcXoiK8HUIaWTqD7YGf78faYHSMPNXGW4gxho82PGCkd36mhqvDlZ?=
 =?us-ascii?Q?rViNJa4rmeg7J3lEeWjn2sC/xTUlZqNBoqHb0qXqybVMqO4MPv3av+1tVkXT?=
 =?us-ascii?Q?OiddinciFzvHv1BIURRWFALqW/4nlWrgjr4lU0Fta9HkX5HxwwEhqlnh8ruI?=
 =?us-ascii?Q?FXEuOag6BaOAGN9MoR9sO+1NX9kjzMM28j7xYkdx5Lnkgt4KW+Oy3G2WJ95m?=
 =?us-ascii?Q?b/Nocq81mKHd/WBRkTfXxXe4DCkPjVJ0vwfSloLjgPwD351MjInz08FgBuzb?=
 =?us-ascii?Q?HCuWc9v5cQkGNw9NtPyEfJvceBFoSGV/vbcPCj0D31CcuMuRLtkHXFLv7pIN?=
 =?us-ascii?Q?aIiOmPrqpBgyGCm/sZtOtH0DgjrWxBvGMtMWgak1XyoBIWufaaKH5RTbvg8O?=
 =?us-ascii?Q?S+h+9cn2UBsdsQNmFflexqzkfYcIT3Iz7jOo0BIOCkAn3U0i9TuvdlXPD4s9?=
 =?us-ascii?Q?JrByjJ7wmGGwCbbDzLF6Y0I2OVmvHwiqVncb9aTNyET3GCW4CmuC/lrwUB77?=
 =?us-ascii?Q?H0VsWVPmw6VCoxtL3cTy8a34wmGB3non+rHBYk4rPJbcm79tO7IMp5k5gIEy?=
 =?us-ascii?Q?2+TwmOcnoD2pIwQRUksGUTQ/NJKvjuhbE6cKPlbbd65kEM/8o58+EQARWtzx?=
 =?us-ascii?Q?Rzac+sJfm/QMBrJD3X+xiUsjwT3KlzIo6uSJY28Se17d7XKUbkN5GgoPjOIC?=
 =?us-ascii?Q?94FOOSAJSi2zY1b/kKloQIk2PMb4DzDBM6VQfUYhQMq15t0u1Wal4fGIG0L+?=
 =?us-ascii?Q?PWUuHzEXtLk993rgsXg=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:03:42.9252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4072495-e2ad-415f-4140-08de121310f5
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB5030
X-Authority-Analysis: v=2.4 cv=G6gR0tk5 c=1 sm=1 tr=0 ts=68f9ef75 cx=c_pps
 a=JfrOOz/EZnIsV6BwmOw2aQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=0hqhs4pA57X8KY1vVdsA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: mAvT99jRfg05W8bcMtNQR4_Tq5SLZoFJ
X-Proofpoint-GUID: mAvT99jRfg05W8bcMtNQR4_Tq5SLZoFJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDA4MCBTYWx0ZWRfX44VF19rmZmBJ
 p7M0Wn7ZISHtyiJx2/eJQRRch2+8tQ2PZWI75iQYcLSB3WOftK1SIZ+22GEBqjtIdMly593uvOC
 0WdqTAvdF21Ko9G5cttavSTBWXPU+pehzUAfXVQ4YfopMJfXlua3Xu5QFOvuqgS6c3z5+eQ5Szq
 IkQFW+1CzHOPZPan6ssdf39M/UY3nRpKSjf1fLWjpEoBoWUef+ubws3CxVYjhZAzjvtHkkuJ3Nf
 O5daacH4+V/42bYkA2Irg61Acki0XoSlcRhXhoOpUb8fWOYMXWc3o51qbpYPezs1rJEr8/bI9Nl
 C94MMXGUrlb+ahPu5UUJMY6urJIiT2I60O5RhLEsK8SyABOm4S0VE9SvqgYud0L9KWQIbG8HtCy
 FyRbgqGfNb6xTRwBq9IhWzT831kuZA==
X-Proofpoint-Spam-Reason: safe

Cirrus Logic cs530x device family has 2 control buses I2C and SPI.
This patch adds SPI support.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/Kconfig      | 10 ++++
 sound/soc/codecs/Makefile     |  2 +
 sound/soc/codecs/cs530x-spi.c | 92 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs530x.c     | 21 ++++++++
 sound/soc/codecs/cs530x.h     |  1 +
 5 files changed, 126 insertions(+)
 create mode 100644 sound/soc/codecs/cs530x-spi.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 160c07699a8b..ef49f71e8b34 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -106,6 +106,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_CS48L32
 	imply SND_SOC_CS53L30
 	imply SND_SOC_CS530X_I2C
+	imply SND_SOC_CS530X_SPI
 	imply SND_SOC_CX20442
 	imply SND_SOC_CX2072X
 	imply SND_SOC_DA7210
@@ -1082,6 +1083,15 @@ config SND_SOC_CS530X_I2C
 	  Enable support for Cirrus Logic CS530X ADCs
 	  with I2C control.
 
+config SND_SOC_CS530X_SPI
+	tristate "Cirrus Logic CS530x ADCs (SPI)"
+	depends on SPI_MASTER
+	select REGMAP_SPI
+	select SND_SOC_CS530X
+	help
+	  Enable support for Cirrus Logic CS530X ADCs
+	  with SPI control.
+
 config SND_SOC_CX20442
 	tristate
 	depends on TTY
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index bd95a7c911d5..39138d96a720 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -115,6 +115,7 @@ snd-soc-cs48l32-y := cs48l32.o cs48l32-tables.o
 snd-soc-cs53l30-y := cs53l30.o
 snd-soc-cs530x-y := cs530x.o
 snd-soc-cs530x-i2c-y := cs530x-i2c.o
+snd-soc-cs530x-spi-y := cs530x-spi.o
 snd-soc-cx20442-y := cx20442.o
 snd-soc-cx2072x-y := cx2072x.o
 snd-soc-da7210-y := da7210.o
@@ -546,6 +547,7 @@ obj-$(CONFIG_SND_SOC_CS48L32)	+= snd-soc-cs48l32.o
 obj-$(CONFIG_SND_SOC_CS53L30)	+= snd-soc-cs53l30.o
 obj-$(CONFIG_SND_SOC_CS530X)	+= snd-soc-cs530x.o
 obj-$(CONFIG_SND_SOC_CS530X_I2C)	+= snd-soc-cs530x-i2c.o
+obj-$(CONFIG_SND_SOC_CS530X_SPI)	+= snd-soc-cs530x-spi.o
 obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
 obj-$(CONFIG_SND_SOC_CX2072X)	+= snd-soc-cx2072x.o
 obj-$(CONFIG_SND_SOC_DA7210)	+= snd-soc-da7210.o
diff --git a/sound/soc/codecs/cs530x-spi.c b/sound/soc/codecs/cs530x-spi.c
new file mode 100644
index 000000000000..dbf1e7bbec19
--- /dev/null
+++ b/sound/soc/codecs/cs530x-spi.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// CS530x CODEC driver
+//
+// Copyright (C) 2025 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+
+#include "cs530x.h"
+
+static const struct of_device_id cs530x_of_match[] = {
+	{
+		.compatible = "cirrus,cs4282",
+		.data = (void *)CS4282,
+	}, {
+		.compatible = "cirrus,cs4302",
+		.data = (void *)CS4302,
+	}, {
+		.compatible = "cirrus,cs4304",
+		.data = (void *)CS4304,
+	}, {
+		.compatible = "cirrus,cs4308",
+		.data = (void *)CS4308,
+	}, {
+		.compatible = "cirrus,cs5302",
+		.data = (void *)CS5302,
+	}, {
+		.compatible = "cirrus,cs5304",
+		.data = (void *)CS5304,
+	}, {
+		.compatible = "cirrus,cs5304",
+		.data = (void *)CS5308,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, cs530x_of_match);
+
+static const struct spi_device_id cs530x_spi_id[] = {
+	{ "cs4282", CS4282 },
+	{ "cs4302", CS4302 },
+	{ "cs4304", CS4304 },
+	{ "cs4308", CS4308 },
+	{ "cs5302", CS5302 },
+	{ "cs5304", CS5304 },
+	{ "cs5308", CS5308 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, cs530x_spi_id);
+
+static int cs530x_spi_probe(struct spi_device *spi)
+{
+	struct cs530x_priv *cs530x;
+	struct device *dev = &spi->dev;
+	int ret;
+
+	cs530x = devm_kzalloc(dev, sizeof(struct cs530x_priv), GFP_KERNEL);
+	if (cs530x == NULL)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, cs530x);
+
+	cs530x->regmap = devm_regmap_init_spi(spi, &cs530x_regmap_spi);
+	if (IS_ERR(cs530x->regmap)) {
+		ret = PTR_ERR(cs530x->regmap);
+		dev_err(dev, "Failed to allocate register map: %d\n", ret);
+		return ret;
+	}
+
+	cs530x->devtype = (unsigned long)spi_get_device_match_data(spi);
+	cs530x->dev = &spi->dev;
+
+	return cs530x_probe(cs530x);
+}
+
+static struct spi_driver cs530x_spi_driver = {
+	.driver = {
+		.name		= "cs530x",
+		.of_match_table = cs530x_of_match,
+	},
+	.id_table	= cs530x_spi_id,
+	.probe		= cs530x_spi_probe,
+};
+
+module_spi_driver(cs530x_spi_driver);
+
+MODULE_DESCRIPTION("SPI CS530X driver");
+MODULE_IMPORT_NS("SND_SOC_CS530X");
+MODULE_AUTHOR("Vitaly Rodionov <vitalyr@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 9fcae9b85a45..f8f409d0b035 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -12,6 +12,7 @@
 #include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/spi/spi.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
@@ -1142,6 +1143,26 @@ const struct regmap_config cs530x_regmap_i2c = {
 };
 EXPORT_SYMBOL_NS_GPL(cs530x_regmap_i2c, "SND_SOC_CS530X");
 
+const struct regmap_config cs530x_regmap_spi = {
+	.reg_bits = 16,
+	.pad_bits = 16,
+	.val_bits = 16,
+
+	.reg_stride = 2,
+
+	.reg_format_endian = REGMAP_ENDIAN_BIG,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+
+	.max_register = CS530X_MAX_REGISTER,
+	.writeable_reg = cs530x_writeable_register,
+	.readable_reg = cs530x_readable_register,
+
+	.cache_type = REGCACHE_MAPLE,
+	.reg_defaults = cs530x_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(cs530x_reg_defaults),
+};
+EXPORT_SYMBOL_NS_GPL(cs530x_regmap_spi, "SND_SOC_CS530X");
+
 static int cs530x_check_device_id(struct cs530x_priv *cs530x)
 {
 	struct device *dev = cs530x->dev;
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index 2a7b7d01ecfb..1e2f6a7a589c 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -247,6 +247,7 @@ struct cs530x_priv {
 };
 
 extern const struct regmap_config cs530x_regmap_i2c;
+extern const struct regmap_config cs530x_regmap_spi;
 int cs530x_probe(struct cs530x_priv *cs530x);
 
 #endif
-- 
2.43.0


