Return-Path: <linux-kernel+bounces-798185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F391B41A6D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B027A7B5905
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CB82E8DFC;
	Wed,  3 Sep 2025 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="TC2s5bBH";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="B/cCUrYj"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C952270EC1;
	Wed,  3 Sep 2025 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892777; cv=fail; b=TFYij2DVMKTsraWyAxhUtFY0aD4/8OXDK6j2huo4k/LhpbgaV2uW6Ct/0q51/2q8adCwRlxFjDcI2ldEl7o22tzwVKRHq7rxHNG9jecfgYE0PAd5EvvIT4lTJ0pUWSkwHXMFH31Ua3Mmf8iqO5hRzuOk/wzrdwqVNivAQCw/+pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892777; c=relaxed/simple;
	bh=9JZhAuTTx1sNL1ggSSyCc4Hrs2ZSZNawsID1fcWN4Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzmmmU/n4ToERGYK1mEuWJw+R4cdQyDhTwT3PfPM5lp7+aRhIcQAENT0sz6pzRVBQ6i54pHF96wynKYoAZNizHflAMHr6ZLq9DtH+zF5RTgNcyvB7FsLzAvRrXrVBdI5w7jMsBpfxD7yujG4iUck5cXhQP7MCb3IiL5YsPlRUy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=TC2s5bBH; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=B/cCUrYj; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 582JWgRB2223743;
	Wed, 3 Sep 2025 04:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=8lKjWFsLa+KCgupoKtYv6MeRMyfqv/iP9ishrotg+dA=; b=
	TC2s5bBHQIZUdCfIpBsisVWMNqNOWpQd/i+mCWVaJ5LDa4Lx/MsiiK7CSJ8iq4/r
	OpE+JgwD9yJ9aYp5UNORObtIrzSjM11loIw2jMgJWcAAFDZqfbpzX0x1ZdIbNy9m
	i0PaumKkPUTolFHtycGMMJIWFVIu0DrNYWCa7r4HEeo7nCyCF2Jj+QVHhXNeaxyE
	hv8xn+c/EMc8jmuD5c6R3Re18qWMQV8FLqwUaPmZz6BXd4pUJQ/vs50T5jjvf2Pk
	hGRU5w2kVvPPhlDTJUudhjf3+Ol3KlFoebWudhudfdylM/LTad+5PdOkDUVmama3
	VECj3drDWnt6O/+bM6GVXQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12hn2202.outbound.protection.outlook.com [52.100.167.202])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 48vensc6d3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 04:46:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLEt8IKIJJtYAylYBg14gaLF1BUhzP8d93gfkFP6RgIci/RszTbLG0LS6vKhVx3uXtFddcnkpjbLCB/bHmEabXaGn1BxYil4XABL+GVW2O1ZsqcYBrVhi6StP5XDCZjLuVpgiPPXcZNglb937RhXSVQmUnx9L3r0D/1F648cAWLq/bzrHkspKTBf2qtdTjhFtwhCnJmecanhGI2aWontLoVK4h0qdQgGJfA0kqPlbbqCj0CXyo3s+OElS5W5QM59TD0dsb7qK0BtK+QQq61afNjwENfqwOQpB6pO/nALKBcFHqjTQKqW4wmzvlOaXXTD0t4TF0uQGeM4X3aiEPGHaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lKjWFsLa+KCgupoKtYv6MeRMyfqv/iP9ishrotg+dA=;
 b=JWFUQo4DS3ZSJWGAnvYjRSLUBEnXZ/cVxD/0TkSZv/yOLp3bQSUdhQA3QewwUdLp0U3nSfbXyKLSjDYfCHZzemrlELUAvKYHIhTcwn4Tv1MFf17Fj1sX4d2wcPn/GIeaeyoDAULeCOQCE2VsMlrLBoWCeBUhE+wC4sSPicOCCXsXskaaIhAE6D6GGhNLmsZ2sVou8RnESgA2iYT/XsBUVjtx2iyX3Xs0ncOwAh9OW7PUChdTZniThu5yLLvjKULKEfODl62Pfmxx/zYWD9CyxhhF6VejV0acvBCUdjJTiENmSVvhgivziEWzoz34yW3h4Oi7P+zT5aGQKF45GS/Fww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lKjWFsLa+KCgupoKtYv6MeRMyfqv/iP9ishrotg+dA=;
 b=B/cCUrYjbG1Vk35XdiYGPtoF27T7fRUSrYztT+Zf1ieHNOBRIjt0vuB2VKGQqJos3bHIfN4CMJJArJkQSuQickpB08RVe9NIhm64cTFCehNN9dduHK/7pQLDS+CelqkZd8dzijPB5NZnxKin1R2zEEZxdfhvrqB845fIstPQuvY=
Received: from BN9PR03CA0639.namprd03.prod.outlook.com (2603:10b6:408:13b::14)
 by SJ1PR19MB6355.namprd19.prod.outlook.com (2603:10b6:a03:456::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 09:45:55 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:13b:cafe::f5) by BN9PR03CA0639.outlook.office365.com
 (2603:10b6:408:13b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Wed,
 3 Sep 2025 09:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.0
 via Frontend Transport; Wed, 3 Sep 2025 09:45:54 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 3EFFB406542;
	Wed,  3 Sep 2025 09:45:53 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 27B14820247;
	Wed,  3 Sep 2025 09:45:53 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org, lee@kernel.org
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH 2/6] ASoC: cs42l43: Store IRQ domain in codec private data
Date: Wed,  3 Sep 2025 10:45:45 +0100
Message-ID: <20250903094549.271068-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250903094549.271068-1-ckeepax@opensource.cirrus.com>
References: <20250903094549.271068-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|SJ1PR19MB6355:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 321278db-673d-4933-622c-08ddeaceacff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|61400799027|34020700016|36860700013|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8PWO9VpxBcuxdiQmIIfu0+RAPUCRTDU+dJHvJnE7K8FAXFsaBEAM6Cgp762b?=
 =?us-ascii?Q?3S7FbhDSDFbeWUbmmeG6DFva7Nj2MAHM/Qp1TLnIR2XmGTLlmIKRIucONjt9?=
 =?us-ascii?Q?0yBXZmJWzEOH+pbCUGlFAK7dThm/P3v4iRnkxCjyrpkWZsymd4GdPnCkfz6S?=
 =?us-ascii?Q?wcDFH1wg08EKMS+dYU+ZkfNH6PKgh4lhEALLhOwRChIoRE7xCT5mjDPlYe+R?=
 =?us-ascii?Q?j+wAXkZfVnDDk1jZ9CjGmSOiEk28FjM9sTDr9BYzdvCaVi5Pbpxx7bC4jVHJ?=
 =?us-ascii?Q?LUVbRs5IJZ9tWBKHF7JtnRvBML0pNP/scYgTzhHK+BSuXlpcEKevxSSNvFkp?=
 =?us-ascii?Q?tvWwhiGgZwMrA9GaI1sZlxL2ur2gEVCM89djD4Z9ShmlfLN0aGGWAV7JWQC+?=
 =?us-ascii?Q?D5zIVdQqLudy1qF9OYp5FVslZK6DxaWbpl7fb/xo0C8TThqJuBDjaR6/wEm8?=
 =?us-ascii?Q?kGrO3tDchlLyhpyYQvV99/cVZzfmYZM4DTGek39raH3uRbP2uVI1AoN2Ex44?=
 =?us-ascii?Q?HfuJiizQxVac93AcWyfgCXbXJSyKaF2QEHHSYh8YRWg/ZkJ34P4FlRL/K99V?=
 =?us-ascii?Q?KYsohW3n6QV4m1UrlvV8BVuAoNt98b0DQzGYCuuzR5YXOzAJsqt+oq+3htF0?=
 =?us-ascii?Q?Uhbbj7cEFdXnYmzws3S55Rtm6Z0ncQ7/QK1/LVqYzisFYDnYdW6tBCdJHdp/?=
 =?us-ascii?Q?aaa8kSYdDdmezS593md5MILI4aXH9gcTQUmRqqc15m9Bz+x9zvWoA1voiunW?=
 =?us-ascii?Q?uO8NU3gbXyMbmP4mt3WFaWDmOxrg2R17i/qI5NWwm3Yb9JwoSLq7aNb5Exvn?=
 =?us-ascii?Q?YhCHFf0cGhVywpHDySqSYXa4GMs5VnPUbGwC5n8F+ktTg3gzWJ2FAPp8GI4F?=
 =?us-ascii?Q?vzK7Ikx8Hb6uZT8w76w6L+z2Q5dBxQBsglGlRu+Q1SJTX2XhzFOvaFdhKKJJ?=
 =?us-ascii?Q?fdquZqXlzv3T7f3Btp9LJPJuSfa9KBHZ/Gz5I1kAj5Y+NcAzt0X0YP2aodgC?=
 =?us-ascii?Q?nTEU2c+NRT5+W9x2UxhL9Ko8Nipqg6OAU99zwe2xLmEQN6uE3F69mF184BHq?=
 =?us-ascii?Q?+FS0qtlP5LpE708QlQVu0fA4lLNe+jfXt9TlC0d2oFKflXC3LqHARcjYOmUw?=
 =?us-ascii?Q?3ZLc0jPwcDkp/CNtr2lIE7adNtQCiYHBbDmWisokQFOmHnflqGaQIu9ocJ9V?=
 =?us-ascii?Q?YLn4MQ2pftHUDm+mOs1MGR2MPSMY1c9Sxe5uvfCMGBRDo2hpM5C2VYg9Qykc?=
 =?us-ascii?Q?s3Qf7hA72hk81rl2JDD7YDNFUoKX3W4ILe0ncOyzQAF50YDrKzarKSwjl8SA?=
 =?us-ascii?Q?swPNsI5keOn+qM0jmXIYHxoWcWd1rMSyMk8Wqk0BuuhQeZ8o1ottx13ox3zB?=
 =?us-ascii?Q?kocAlCk0oSTROjfFGStTuOzoHoMoaWNnMxH55/6zLPVsQ9v6OWnw2P6iV1et?=
 =?us-ascii?Q?tGGyTM2NiPzh0uFW0td5duBwRTKKLPIUgABeMXv1bZlYEkTOiCcUgTJc+rLU?=
 =?us-ascii?Q?zar3QIA63XSbpFUexQ4fMeB/N7YKu3dW69Dt?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(61400799027)(34020700016)(36860700013)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:45:54.0857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 321278db-673d-4933-622c-08ddeaceacff
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR19MB6355
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDA5NyBTYWx0ZWRfX0/Y79HlYKB7f
 VxU/zHpRjgF2gsq9m1RNIJYqsjoyivDAJHd3J0rUkEHnltU/dRdWIW4NCi0oo9Gzrycrxl5HoGH
 rDfqIlDIEWdnx117HJzOcjX7+gzWt91MoOwtmcLhVeX1UgzLKxtr7QVANbKez646lmpQN69TqwJ
 fmOgz916vFnnE5xDf85Rbb2zFW3zlA370VhCNBomOzb5NdFAuYH8eBJ0yM4EK+NoPH7Zu8+zwAX
 vNbtEoIPIVz/Igfb7NME55eTzzI209zX/hXDGc1wH60nvbbRukHrLq91Sa6GUO/Dhu4GeYjA0yU
 5RU9IGg3tb5TNxh0go6L6Lg7SPdPP1qZ/+SGPAcUlRk/oqjElSJ/e4BeZY2n8o=
X-Authority-Analysis: v=2.4 cv=BY/Y0qt2 c=1 sm=1 tr=0 ts=68b80e58 cx=c_pps
 a=8hBjwRI3TeAgKlFXmFed3w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=ISzjgLl2UIzaD__TBtgA:9 a=jZz-an6Pvt0H8_Yc_ROU:22
X-Proofpoint-GUID: JWle6MO9jzMtoI3rKRf8gj1bswekTYZK
X-Proofpoint-ORIG-GUID: JWle6MO9jzMtoI3rKRf8gj1bswekTYZK
X-Proofpoint-Spam-Reason: safe

To support future refactoring store a pointer to the IRQ domain in the
codec private data allowing easier access to it outside of probe.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l43.c | 29 +++++++++++++----------------
 sound/soc/codecs/cs42l43.h |  1 +
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index 4d17799415817..241f7d013189c 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -2210,13 +2210,12 @@ static const struct cs42l43_irq cs42l43_irqs[] = {
 };
 
 static int cs42l43_request_irq(struct cs42l43_codec *priv,
-			       struct irq_domain *dom, const char * const name,
-			       unsigned int irq, irq_handler_t handler,
-			       unsigned long flags)
+			       const char * const name, unsigned int irq,
+			       irq_handler_t handler, unsigned long flags)
 {
 	int ret;
 
-	ret = irq_create_mapping(dom, irq);
+	ret = irq_create_mapping(priv->dom, irq);
 	if (ret < 0)
 		return dev_err_probe(priv->dev, ret, "Failed to map IRQ %s\n", name);
 
@@ -2230,8 +2229,7 @@ static int cs42l43_request_irq(struct cs42l43_codec *priv,
 	return 0;
 }
 
-static int cs42l43_shutter_irq(struct cs42l43_codec *priv,
-			       struct irq_domain *dom, unsigned int shutter,
+static int cs42l43_shutter_irq(struct cs42l43_codec *priv, unsigned int shutter,
 			       const char * const open_name,
 			       const char * const close_name,
 			       irq_handler_t handler)
@@ -2259,25 +2257,20 @@ static int cs42l43_shutter_irq(struct cs42l43_codec *priv,
 		return 0;
 	}
 
-	ret = cs42l43_request_irq(priv, dom, close_name, close_irq, handler, IRQF_SHARED);
+	ret = cs42l43_request_irq(priv, close_name, close_irq, handler, IRQF_SHARED);
 	if (ret)
 		return ret;
 
-	return cs42l43_request_irq(priv, dom, open_name, open_irq, handler, IRQF_SHARED);
+	return cs42l43_request_irq(priv, open_name, open_irq, handler, IRQF_SHARED);
 }
 
 static int cs42l43_codec_probe(struct platform_device *pdev)
 {
 	struct cs42l43 *cs42l43 = dev_get_drvdata(pdev->dev.parent);
 	struct cs42l43_codec *priv;
-	struct irq_domain *dom;
 	unsigned int val;
 	int i, ret;
 
-	dom = irq_find_matching_fwnode(dev_fwnode(cs42l43->dev), DOMAIN_BUS_ANY);
-	if (!dom)
-		return -EPROBE_DEFER;
-
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -2285,6 +2278,10 @@ static int cs42l43_codec_probe(struct platform_device *pdev)
 	priv->dev = &pdev->dev;
 	priv->core = cs42l43;
 
+	priv->dom = irq_find_matching_fwnode(dev_fwnode(cs42l43->dev), DOMAIN_BUS_ANY);
+	if (!priv->dom)
+		return -EPROBE_DEFER;
+
 	platform_set_drvdata(pdev, priv);
 
 	mutex_init(&priv->jack_lock);
@@ -2314,7 +2311,7 @@ static int cs42l43_codec_probe(struct platform_device *pdev)
 		goto err_pm;
 
 	for (i = 0; i < ARRAY_SIZE(cs42l43_irqs); i++) {
-		ret = cs42l43_request_irq(priv, dom, cs42l43_irqs[i].name,
+		ret = cs42l43_request_irq(priv, cs42l43_irqs[i].name,
 					  cs42l43_irqs[i].irq,
 					  cs42l43_irqs[i].handler, 0);
 		if (ret)
@@ -2327,13 +2324,13 @@ static int cs42l43_codec_probe(struct platform_device *pdev)
 		goto err_pm;
 	}
 
-	ret = cs42l43_shutter_irq(priv, dom, val & CS42L43_MIC_SHUTTER_CFG_MASK,
+	ret = cs42l43_shutter_irq(priv, val & CS42L43_MIC_SHUTTER_CFG_MASK,
 				  "mic shutter open", "mic shutter close",
 				  cs42l43_mic_shutter);
 	if (ret)
 		goto err_pm;
 
-	ret = cs42l43_shutter_irq(priv, dom, (val & CS42L43_SPK_SHUTTER_CFG_MASK) >>
+	ret = cs42l43_shutter_irq(priv, (val & CS42L43_SPK_SHUTTER_CFG_MASK) >>
 				  CS42L43_SPK_SHUTTER_CFG_SHIFT,
 				  "spk shutter open", "spk shutter close",
 				  cs42l43_spk_shutter);
diff --git a/sound/soc/codecs/cs42l43.h b/sound/soc/codecs/cs42l43.h
index 3ea36362b11a4..f4ef93d1fc2a4 100644
--- a/sound/soc/codecs/cs42l43.h
+++ b/sound/soc/codecs/cs42l43.h
@@ -44,6 +44,7 @@ struct cs42l43_codec {
 	struct device *dev;
 	struct cs42l43 *core;
 	struct snd_soc_component *component;
+	struct irq_domain *dom;
 
 	struct clk *mclk;
 
-- 
2.47.2


