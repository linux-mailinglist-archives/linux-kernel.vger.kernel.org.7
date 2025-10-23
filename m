Return-Path: <linux-kernel+bounces-866558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482CC0016B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC721A07DDE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762D32FDC23;
	Thu, 23 Oct 2025 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="nAuTC4BW";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="IVuWl87V"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F37A2FB99B;
	Thu, 23 Oct 2025 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210244; cv=fail; b=KgakrFxmPOi11+KXugChvbK+CvlxLb4/a1haQc3yPYCmSDXo71qlEYDAayy5BBiYfBVHNwzHhhtolHYQTNAQs2eYwrAeszp+jhHgrh2usFvEkyvDFijjvjStnfJxlvjUTI2jov8UOV7nCT/d9ZQ61EvRHZFCkg+PE3zuiinVECI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210244; c=relaxed/simple;
	bh=VkWNmAom4yZLs2kIIQVbTHaSWDcVsPwBuAv57jzRieE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDUtK/y4+xyo6ojOU0onvuL29DjASZ9FSXx1t38TUI3HxygqTS6vvY3WYYXKm9KDO1aUtem9lFyZhjONJcKNRPXl5fIExZkk8Q4H9bumpbU8kRfji8DpeyU/AgOg/fAGWmRjn15YBDmeWIBID8t1wO4/O9da85L0zcti9NQIUdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=nAuTC4BW; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=IVuWl87V; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59MJkocO3660629;
	Thu, 23 Oct 2025 04:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=0bSUPCjIGHj/aI9WNbzu7CO6henZigYWn0VxlHDtUqQ=; b=
	nAuTC4BWTWBwUvtu9xT50cFXbS0pg4u/wpguthoAKcbj8USJf3H1YVMrHLWcKZtK
	Yi97377oB/5Sc03RFhYv+MsRAruPoDPs2Ymzfr8Ze5FlzOVRvd9hb5SenfKoDh1o
	wR+BfcVnJjcUWMuPoh5MWHoHfBeFzsC/MO98/oOf/ceBpxl6QPepy488cLjwgR2a
	8UsepWdMq5tNGkGCG8A6jUdE/AIFi+YXL6NZEU2hRsDQDsLj+DhKXh8MmZAm+8fA
	cVqw5X4h2oBxoofMazAQGe6ftuqNT4+OwwxXp/cZ+iADMYTkDfsM8zMAJlKke2eT
	59OTJaa+u5Dp5CZKbIVuAA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020127.outbound.protection.outlook.com [52.101.193.127])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49xqmqsx3x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 04:03:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOQhgnHNODbJVNgupq0YaUmRox40P8U35kRRE38tTLh8W+TaTJmfZE60wNWXR5FezqjUqSQwqm4sLdOvggtGw1XpbJQ4jRmhuyLRqR9GwpCg04qXWKs9H5J0xwXMjQZVywENZXGZ4KSzx6evf/BA7A7VQwGjFOS4vYGe58GsX2ZR0B2KkwOJdoE6nGOrZkPajNOfvddnar3W4FwqkMipujVniNKsIf0HjIAky+Z3YscRK+zIBV2AB+TM44J31Y3uANUe5/f8CzbBkhWkI04k77/fcZR/tYze9NrSCm3i5ZMIQt+XHTrJ8Pn/pDIi1Hx92MOT28D5jLgspNp3G2sI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bSUPCjIGHj/aI9WNbzu7CO6henZigYWn0VxlHDtUqQ=;
 b=dkUcRJNAD3pK7n2lJsRj8KYi9+Vu5pann89kORINbj10MZjhGeDRQiAQPBcRuubK5GlIIJsZHo0GIoWjYJH8j+ZbSHui4YdCUNRQamq0xTLjK2aO025qccJVr+ik1yQl8cc/AVhCsnQCPAZ/4B1KTBN5pqlM2kddCZbLj8RuRqFdiNox7xbZxndZRxJSgA2sCuVMorvIQniO0f5kScANpWvLSdYGuWYdw6BwT20r1xjVCHtNR+pcOwL7MwPC1sASw02l+tYSTmADJ+H9igyH5C+2zq9nXcL4Q/NTe+0qbl2Pti2LsE54wlaqvdfKglGRUgTFNLw06yQSFg4xeYRuJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bSUPCjIGHj/aI9WNbzu7CO6henZigYWn0VxlHDtUqQ=;
 b=IVuWl87VIWVbbxkPwx8W0ZoMZBPp0vKz7hLFjiC8sWKhaKULt1xjHmqD2zXUzgTqaPJ5+8e+7QVxvrHCBXYwIRFpuGHar7IaeeHzHqkbNPjSKOBAruqJtOhXtccJNS7P+LXIsNHRqvEdQDhtardGj3UtCvB71LJ71LUO4EOsQpo=
Received: from CH0PR07CA0004.namprd07.prod.outlook.com (2603:10b6:610:32::9)
 by CH9PR19MB9299.namprd19.prod.outlook.com (2603:10b6:610:2dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 09:03:40 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::33) by CH0PR07CA0004.outlook.office365.com
 (2603:10b6:610:32::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 09:03:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Thu, 23 Oct 2025 09:03:38 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id EED46406553;
	Thu, 23 Oct 2025 09:03:37 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 95BEE820244;
	Thu, 23 Oct 2025 09:03:37 +0000 (UTC)
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
Subject: [PATCH v6 03/12] ASoC: cs530x: Remove unused struct members and constants
Date: Thu, 23 Oct 2025 10:03:11 +0100
Message-ID: <20251023090327.58275-4-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|CH9PR19MB9299:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 11c90a7f-78bd-46af-a09f-08de12130ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NfaLEcVo3CnrHD6larnFLemN85lYRoYOXA2TkqdvSk0GvKHZG2Jy8I0Y74o7?=
 =?us-ascii?Q?E59kA30yxP2QAzwGgftbE+FH9XbZ/AedAXMk13RpiG2ptXqa0tbD9jiuPixP?=
 =?us-ascii?Q?tqCCvxhpWGFwJB0eZIFlwP8o4MxPxSSDRRV0FrKLrExgB71fI+uLsHSkh/P7?=
 =?us-ascii?Q?4gSucx7mYD7tGGwU0ti5wJeKEnCah6Zs4BoLApjD74fm6PdjqNkC8hCFH5r2?=
 =?us-ascii?Q?rNBy+uzrC8BrwM1DBPn8JZCuWOnijMl0TMDrZ8myPPKoMUidhgeMSVjEvHPy?=
 =?us-ascii?Q?i3FUDpV30GZu1sc0PbQcvkqn554TcUrAYwN8e3uunJOsSmUFL5tuRoLt0RhE?=
 =?us-ascii?Q?jPJNEQbiJ/V2tI06ELW/hu8UFBPjl0kqL3fFkj49I/YSxHEzCDajpnrp8h4t?=
 =?us-ascii?Q?xP1TskqeSpWMzgDRZABZ6hYyM9p0+b62YvI/4Z/zE9vS10iDwwiHEqHl9/G1?=
 =?us-ascii?Q?PCrZd743SKfQnRM0V7nURvLGPOezqag2mJJwhqJPVB4rBgBDSbb5AJM3UCsO?=
 =?us-ascii?Q?aMMic6Rp0m99/aDEPJcFpt3E1uG7aRZwpCK2U2F626hMNDb842R+qDPbXRPU?=
 =?us-ascii?Q?tv4aIktAkBBnItjde2jvDKv2u5FxM7FCmb2ciU4NX4tSJQVC+vr+NTfmT0ln?=
 =?us-ascii?Q?prM95qkwiG2W0Jq2rJvzRpSz8ePkHDYqKZt7ES276PiFvF/vyUIEm2NyDHD5?=
 =?us-ascii?Q?QWqDGutoYY9rZ0Xb243ZcyF/Dugr2prZ/jeEIyCtvt+wCTtEAXFiE2eAXxa0?=
 =?us-ascii?Q?OyHlBpblT66CeK9/ASIIWRMN1mgIvZ10O8OGdM75Nz8UrLexUYmyp5jnrepC?=
 =?us-ascii?Q?kIoExHUDKzAs4aZLLU6ZMGjb65URlULypnHAW8Rt+NblauN3ERaDcU9EoITO?=
 =?us-ascii?Q?a8pYReRwsfj8LcvvWKDo9wg5Fvp3jWHcdXsKax0iCR485gD53YHE3eTyOIZp?=
 =?us-ascii?Q?T9wS/Yb6tIlq3QRJR3iAK7sY/22gV8kIpXPEQi6GQkU7oGQyVYI5rk3v/7aG?=
 =?us-ascii?Q?+mXlyAhwHaidXmog83WicirRPnV0kqcTJ+kwd6o1OmGfKmPcuuchlZ9b6Emz?=
 =?us-ascii?Q?oItf7Di8Dj1wI/vL/buf+15eWvBZfckfK5cR0nCVaJUiENcCMqbXRuV0LnU1?=
 =?us-ascii?Q?Ai7Fqqz4IwEY5GO8HOcbZ/+u78Bx2IyzZSc0/+G5qEHXb0tYmz6ozi19BXUB?=
 =?us-ascii?Q?FkQEkIzX2V0QgamrWf5Ujv9su4IgGZIA1yIRsAH1ArszUAGPFCqBgc/xAstb?=
 =?us-ascii?Q?JI4Se8NY5D3QqHTZNN4xvL7pyY8S8Yr1rRol+mTRjHQ4Mrulp865P5/lLCUO?=
 =?us-ascii?Q?RaYyTz8WoSCM6jijAlqnys6Y/V3DgdbZeqoWUVJO9ECFvIp5NF2hrKjzJliq?=
 =?us-ascii?Q?EWZ+SdOE6PK+5kZU2gTe4iuqLCHEnC/51COWEtjbpJRpA8kkwu1H3hJWZogq?=
 =?us-ascii?Q?VdnmdBpsZhI7yQjoOWMv8vldZ2ZlZsMgE31X+vSXpiMm2dD84dZbg+oSfxQE?=
 =?us-ascii?Q?BOw4fGcjpLHPSjrg0TqZm+71EW+MkECmwA4toyE+cEcBIVpop1RNH30RQuDv?=
 =?us-ascii?Q?vhWmuqi32V0PmMvauM4=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(376014)(7416014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:03:38.9995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c90a7f-78bd-46af-a09f-08de12130ea6
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR19MB9299
X-Authority-Analysis: v=2.4 cv=G6gR0tk5 c=1 sm=1 tr=0 ts=68f9ef6e cx=c_pps
 a=toP0yf9I8NDWex+H5c71Ew==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=w1d2syhTAAAA:8 a=BLJqTvj1dVcXa0-LLpIA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: -DL-fBNNQfz0CazRqX7WSugxz52eFFzM
X-Proofpoint-GUID: -DL-fBNNQfz0CazRqX7WSugxz52eFFzM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDA4MCBTYWx0ZWRfX6eWcIIGTLLhu
 ZextnrPLLdmI2zMnALgpyC2QpuSj3+jrhcY5f3ornS5JRcPbi74P44hDGVbbwUT13bXEaCiPKVT
 6luiPg5XpWYSGmLZKWs2fwGUcpVtAwAOn97ikvl2rlvdDQZcjchqDaIJJh/uy7P+HM6utvMChCJ
 HRz99xqQpumJE5n1LjqNw9GTGut1YjHJF3IMOhQBQKPpFPiBTHvmtJYCebST8dZs9RkMNuH/UkH
 +GWtP5mtJH8dllF+0kTQY6Gz/apngN72sBnLUhbPTcyGiIE3csYdK29Z6dcCDsgZY0bYdwOJvJR
 D1rXW9OYF34xoeZ6JxC7GR6e5Vqg3Lzt2T+8KKTp6BGsfSt7LUxUP6xS4ikjxcko3MCe76Nhk5V
 OBtRYq6723OY4nVakfBdgjE2ZysAAA==
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c | 6 ------
 sound/soc/codecs/cs530x.h | 5 +----
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 3a59eeba5e55..3de748fa5255 100644
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
index b325847036e9..5b47c1ae2a09 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -99,7 +99,7 @@
 #define CS530X_TDM_EN_MASK		BIT(2)
 #define CS530X_ASP_FMT_I2S		0
 #define CS530X_ASP_FMT_LJ		1
-#define CS530X_ASP_FMT_DSP_A		0x6
+#define CS530X_ASP_FMT_DSP_A		6
 
 /* TDM Slots */
 #define CS530X_0_1_TDM_SLOT_MASK	GENMASK(1, 0)
@@ -207,11 +207,8 @@ struct cs530x_priv {
 
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


