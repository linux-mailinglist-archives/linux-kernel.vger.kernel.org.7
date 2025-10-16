Return-Path: <linux-kernel+bounces-856668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5166BE4C22
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEAF518987D0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE3F34F486;
	Thu, 16 Oct 2025 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Q4RkWRzy";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="LdGoekKh"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14BB262A6;
	Thu, 16 Oct 2025 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633942; cv=fail; b=ZIt7XkU/h3faYAjglpagBfV1fzlNgQ5Kp3ph5paUBw6BQdV3iYwNCjUgiPdroL1s6xEtf48Ay36Qb32jXvWQTSVlsv4pIOZdZCiK0EIouGkx9G0O+x8oi9vucOqmoLBahMcGgxhR5+sTv1l5LX+ILxzL2otHj5iqOdd61D4/E34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633942; c=relaxed/simple;
	bh=ThIMJSqoRy+tRj1ekVlf8paXPbiQdKvteSTBc7DnWjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKpuwm857kwgCHw9eL+w3wxsX3TSbcbkrtP+8WkiQYJgwWetZkTs/KiQu+yXxsNtKnbj6gbNZxoHkWRasLxpLfwCc/TJnlNkW2FjHog3uXDShYRys/hM3e+3Lf7BfVKIPoHxejUb0/2jytzSZiK/V3N1hIbEzsY4lLqz17d0qbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Q4RkWRzy; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=LdGoekKh; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GGUOYj298627;
	Thu, 16 Oct 2025 11:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=mQrBsJ/ApE/uMXZNJiEakG/6Ykphmnad4m4LnRuhi0Y=; b=
	Q4RkWRzynu078/jbJuC1rwnBUKvbrZqjlPW7CsPyeP5DJb6H3Pt3iQ/7E4SkEKxK
	h+Aon5keX/eAQ9eZqp7dFWdRPqlc+VRMBOhP2qxtqRwZ+p7AKj+SVoiS8exEkWoj
	+jXRcyYC5MmkU1TPuYD/fvFy+ZHQloAAz1uvRsj1L6ytpoAEknuDaTN9mlIsxAcH
	DDt9NVNFPst7Dir2S4vpIDcj/hBiS7kBjB/LNPwlEssyGYiPylHNSn0jATOcy0dV
	zButvbs5FHwxE/Q7Vn3CblJx1CLoEmHlVFb01XwgBlYkHX06nh0ySKzh4qDcU0Ey
	UdV58TgHF0S6qZ0GtOfW3Q==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022139.outbound.protection.outlook.com [52.101.48.139])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhj9gw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:58:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytTUzKDKwBtP0aQIF2EmCn3uH8hQXnxL5DEcP06JJlKeLxNZODDuE/famib+icjWh6PCT6zwXOvBM0dDw2TAF+ENI20nw25ramjnTXuTpeJXHYeucnMCbO7NdoxOTzy3EmGSZjuH3RYxWIeiFcQriPdQoxJGLS687G6lWBpDoYHKZCKjHit6gwvBzNuEyM+mec5dfOA0T04+bVh8k4KF2q/Z2lg1rGZ1YHgk/Df7D9eJC9zFH9stPnTO97ZSXAQsJOIR5DXRLowIulHRz1bjxh7udjm4Rw3F3C9I+xlig6tW+Nhv4K/j+i8Udl2e4947Iw6X2mk9KJr5cBXndTniHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQrBsJ/ApE/uMXZNJiEakG/6Ykphmnad4m4LnRuhi0Y=;
 b=jOeym4zK5Aa51FJ923QXwf0gVjhNzcQ9PcIycuvfriuRB7Y5qlhsj5AvgZDHRTMqzQVw/4aqpN0SD5ciliA1gpTVYYUyGYz+V77mw6roDw31MMalpwczNUFW28oXRiWbqBRxvmLc5fYtHA3iV0aSZ6SYRr79SBuVTD22gPnuc5PARB4d91m9r61c8VrUADSPvK5+FGMI5S7Jh4np+m1+FQmDuv+pn2HNHGSXK7T9nBZBFAFRSNjfBg3VkvTCpuAW+i41bDnOP/w0vt5slpURorIwiOVncenSEOZzWJqcarC5Vsd+2lSwSHsipk1Iknp4xreEN9k4incbecVxWO2E8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQrBsJ/ApE/uMXZNJiEakG/6Ykphmnad4m4LnRuhi0Y=;
 b=LdGoekKhDoYBXAQn9uSnSdhi8HLVpA4TrIguqz3RlNLLX2IhTWnySwkAznV7Zz/GSW0NORzzNWRtrrnLOvLIP18GihnZwB0XRlxjHKfOK9OVBeYok4xJOptHVzyvQUX2gCoQ3stOaopvjf/HUkebzbuJl3jfffmVyjWDWzNqQkY=
Received: from BN9PR03CA0081.namprd03.prod.outlook.com (2603:10b6:408:fc::26)
 by DS3PR19MB9608.namprd19.prod.outlook.com (2603:10b6:8:2db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 16:58:50 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:fc:cafe::f8) by BN9PR03CA0081.outlook.office365.com
 (2603:10b6:408:fc::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 16:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.0
 via Frontend Transport; Thu, 16 Oct 2025 16:58:50 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 2AD72406565;
	Thu, 16 Oct 2025 16:58:48 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id C7199820244;
	Thu, 16 Oct 2025 16:58:47 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v3 09/11] ASoC: cs530x: Rename i2c related structures
Date: Thu, 16 Oct 2025 17:58:20 +0100
Message-ID: <20251016165835.143832-10-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016165835.143832-1-vitalyr@opensource.cirrus.com>
References: <20251016165835.143832-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|DS3PR19MB9608:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0f290e4b-057c-4984-60a8-08de0cd547d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?axXV561pBeilSkm7YOinrduQm8SxWfjLY4naBe1tpVsI9hqvFk84pvvURw+H?=
 =?us-ascii?Q?GZSgCiogzMcUg0NU9CTwWNuzTHCQpslArQqhMcBIgq5Wp3XzlOMzFdHFKoFd?=
 =?us-ascii?Q?1Jvd+Ak9140HqX3jrOf8UAxG4/wnCNBEensKQVD5Cav/Jnt5XV3AAKdG0VpN?=
 =?us-ascii?Q?K8LIkPhTskgGgW7xaQNNIZpHUs98HN2Y/cIZBjMPHLlDwLZzgKs2mSyr6wO7?=
 =?us-ascii?Q?j/8HwqWeW3O5Y6vKPIEOp0uhIjaAzQ+RjPJlZsqUkQesWDls4z1dK4ewOnwD?=
 =?us-ascii?Q?pUT0R2sk/CqgTwR9eQd7WokgRRielHdorFVmK6DPU//pLpdJoQUFmMhdPAFt?=
 =?us-ascii?Q?PLxnPu8TH3sgLPHy07SXxUYcJLhxDzkiZ285G1pIfpgL66ZsQMr13RNicyGD?=
 =?us-ascii?Q?weS7lTUX05xlQvklR9y5Rzakdq5UBg2dZLjViC7tJf8xzDqSB++czET4m7ci?=
 =?us-ascii?Q?D3TcXLNV+yXH0I2EK9FEKzXjGlRUTkr2MW/T4Z7RXcwlVlxZ9O0q+WHoGEJW?=
 =?us-ascii?Q?Bc/VROT5nFaBATkbkU63YasNBmQccP4Zasw0wCRnicTScOzrloCs/rwSwPh9?=
 =?us-ascii?Q?Oy/6NGvdxrYH0rly69I78iVW1QhF5h49Mu9bujEK4Iw3SZ994Zhsck5eEIoV?=
 =?us-ascii?Q?sdk0Fv5aUvT3WZz0nnrVKROgZ+S2IW75itn4yVolrlBFY3MrTlxntk78htMk?=
 =?us-ascii?Q?eIaoWmxJh4A2TdEXbmebBu/xoouDA0HYKvjdRK/YsDOTT4xKSPJL4jlgEAT5?=
 =?us-ascii?Q?gYMMTn0woyrOawFgGqD3VaXNfLx/b1OPmx49z3wIPKVUrGXcaiJIntOd4F6+?=
 =?us-ascii?Q?gO3Kf/0O5evcH2iTHNrE7r4ZQZRGqL9TAkQc9/AHjVOc/4PSK0KXEjjylheL?=
 =?us-ascii?Q?pqqUb3qBIBBa8+tjW6pdLDfCCA23s6xPEQrWQazd0lGPrWsteQ/IjEaFB+8Y?=
 =?us-ascii?Q?WoktX9cUzDxSRZwrRl5rEn+T2ce8kbbpyUi81OF7bKE7zNn2dPLgcLMb2ja2?=
 =?us-ascii?Q?dZrb5vf5Z9UiDEh7Wh+dlejv026ry5HlplAaaknHo2rPZZL9AiqF5KWXL7gG?=
 =?us-ascii?Q?AVBNS1pzmBVjcGVdhXV6JSErBjA1uhAxS46dvXoGQK4mkkXKkjo/nuF47k7p?=
 =?us-ascii?Q?akN8yWMgHMDiuCZ1hvOrzlgtRNBLdPZ2tKOiJV85P90MvtMSWJapC4c1xJx6?=
 =?us-ascii?Q?0fhgRF35hY4a8NUd/0cWAAnuKvlMAJoWCq75BAQnDVkddR0BtQvIuLVzX3yY?=
 =?us-ascii?Q?omw+3pgUZFrVJp3NL2SQN7/iWq7DoUBUc5L1FWjRwSSxivHvPrHewqm/fwJL?=
 =?us-ascii?Q?YwCpMA4Hi4JZ/OtubYgasqtgMdDCphHTN6sqKe81QKl83WdxWkU+pHzcrq5z?=
 =?us-ascii?Q?v9SqyHiJ7hpvCpcNeCa9J8almsmNwINfDPXTYrJStEV3U86aAbaKKz5u2X13?=
 =?us-ascii?Q?/6g80EUthZQAPneW9TbrZUmveW256CCgun376TQT/qJ9gZvAmWDhpxjT/LeM?=
 =?us-ascii?Q?PtysY21CeAvumZdWE3vr8XPJNppAuZoOiTfAWX8srRF6Iqp/0HjOIK6y1M/0?=
 =?us-ascii?Q?0WHrYe2N/ZuT9eZ4coc=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(82310400026)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:58:50.3845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f290e4b-057c-4984-60a8-08de0cd547d6
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR19MB9608
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMyBTYWx0ZWRfX3e7SearbI0Gt
 40D3wY10dOPO8/D/DcE10mY5DonlbAkWgu2FMeCySjZRqI+tSv7xwtgZfh3wInAjyPd98RB3Seg
 Wj277HJ5mWhUG/20NCBTHlkNv2eb8SKWCw9GYRJPoZ+r0QuiQh1eLwlzb3mjh8AiaTwaxLxiuab
 I+jse6lkNEkd2fx4mwkGDCFcsHZ1VSnNtuo4Ue+CiZDGjaQZBAiqrOUc4eOX59QbuksGoF4vnJK
 amdVQnvJcYJG1O2ml5/kbutS+c1GpfrLgzPJPUcloi1BxbSoKEEVhj614acIl/ejAPHdWzRozqY
 dHSHcOmWMbWKKILtBxs8+4uITmk+Hqz4Jd9r1wjhAc4PBe6jbzELVI/MIZwX0uE4fVTn8fucTfy
 emOZJp0Hy0/+scqm1eNAwtiKUwfGfQ==
X-Proofpoint-ORIG-GUID: RALFlLi0qIl4MR_RA6bMd2cRNgqXaOno
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f1244c cx=c_pps
 a=s29O/COy1YFP/2RSJs/JUw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=edWlu9fVkWd-uG4zv8wA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: RALFlLi0qIl4MR_RA6bMd2cRNgqXaOno
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

In preparation for SPI support these structures should be renamed to
reflect that they are for i2c.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x-i2c.c | 2 +-
 sound/soc/codecs/cs530x.c     | 4 ++--
 sound/soc/codecs/cs530x.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs530x-i2c.c b/sound/soc/codecs/cs530x-i2c.c
index ab410826f777..52b02ceaa7e3 100644
--- a/sound/soc/codecs/cs530x-i2c.c
+++ b/sound/soc/codecs/cs530x-i2c.c
@@ -61,7 +61,7 @@ static int cs530x_i2c_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, cs530x);
 
-	cs530x->regmap = devm_regmap_init_i2c(client, &cs530x_regmap);
+	cs530x->regmap = devm_regmap_init_i2c(client, &cs530x_regmap_i2c);
 	if (IS_ERR(cs530x->regmap))
 		return dev_err_probe(&client->dev, PTR_ERR(cs530x->regmap),
 				     "Failed to allocate register map\n");
diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index f0c3ed931fa8..027d936c0912 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -1128,7 +1128,7 @@ static const struct snd_soc_component_driver soc_component_dev_cs530x = {
 	.endianness		= 1,
 };
 
-const struct regmap_config cs530x_regmap = {
+const struct regmap_config cs530x_regmap_i2c = {
 	.reg_bits = 16,
 	.val_bits = 16,
 
@@ -1140,7 +1140,7 @@ const struct regmap_config cs530x_regmap = {
 	.reg_defaults = cs530x_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(cs530x_reg_defaults),
 };
-EXPORT_SYMBOL_NS_GPL(cs530x_regmap, "SND_SOC_CS530X");
+EXPORT_SYMBOL_NS_GPL(cs530x_regmap_i2c, "SND_SOC_CS530X");
 
 static int cs530x_check_device_id(struct cs530x_priv *cs530x)
 {
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index c48a29cad702..8675a86d7d95 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -220,7 +220,7 @@ struct cs530x_priv {
 	struct gpio_desc *reset_gpio;
 };
 
-extern const struct regmap_config cs530x_regmap;
+extern const struct regmap_config cs530x_regmap_i2c;
 int cs530x_probe(struct cs530x_priv *cs530x);
 
 #endif
-- 
2.43.0


