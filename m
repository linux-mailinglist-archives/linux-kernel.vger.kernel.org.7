Return-Path: <linux-kernel+bounces-798188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF64B41A76
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321811651C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760382F1FD2;
	Wed,  3 Sep 2025 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="YZ3/c7i1";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="RcJxNvVt"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D6B2E6CD2;
	Wed,  3 Sep 2025 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892778; cv=fail; b=jLnkDtW/83VVjXmR+NwUjJakbQqHIkzWJy3kyFPAiTXRfLjpXodGNqrQ+iDMDCe0v5CzLVQj6SMuA+zZBsdn6MOXsRLxdwS06zqlLmdNuKR97oyDSPDFK4qb/HntAZpPZbRLTc3aX9DenTpZ7DmP7s+zD90x+9mlv26O0Klxq00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892778; c=relaxed/simple;
	bh=uMDA6twjeHSetU41kw//nHyImZuVu5PFerZWkdhalcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DixzPl+ZCLb5fpeW00Bg98N63OUTyHLrTEXcG6FRwlIM5mFnos+hIRWc+7X1rNnNKo9Cg8y89RjUCWJqFiliGblXRjLJ08T2lK8Z7fUidGtjdWADDSS7+DQP6mdRWn0cZP3m1rg+VvTtCnvF8Q2M5pbYC9SQARDZuy4u5Zf92jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=YZ3/c7i1; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=RcJxNvVt; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 582MFqVu232307;
	Wed, 3 Sep 2025 04:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=vQkZDihrgrO2B/NifV687co5tvKi7bV3BW0ZaHlmm7o=; b=
	YZ3/c7i1RNjuMp2reeZMMuMQ9aekQdJjtq0cTyUN6qQnstZOwA7s05mpZdcBMXOT
	Sx8hR2Ysf1yJFS44+/bHtMaGSAHNZ+ssierp+bgjnJal64FbyCktXDxIDVMHy5Y6
	uyKplQ9jGq2YthqX2yUabP8h+9suZY94fBMBV4b5wpRcK1hTODbcLIvM1m7WE4cz
	E6WMvJIHpYhmkiYmxQm6A9MbvojB8CtIhEdvFhLZkaUxQNUimx/diuL7wflldkon
	XmcW8uhF4EdwzxxT95v5DH3h0LaIcjYF1sKCde4j+QSDCmxRcfTb4KqPNEeStCxS
	f0rEyJoYy+/fwsN/PQwmqg==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11hn2223.outbound.protection.outlook.com [52.100.173.223])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 48vensc6d6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 04:46:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuqdewU7TrLYcetvwHtikCdOCbMHMNgnjKzBzqVJTQL7bmtytAm86qk/rOdWY5JRhDeY87+fftAAKC7a2yVGqgFOgwuPHsQbRkGuAOvFTqMcB/j1JCx5vG+f0pX7Zyst7dE3z+kTUjJXQeMjj+llTYA6U0vfHK3qO1JrhByyRR8cdtBGc9TnDZxl2CvKVY4R32w9kF6vdn5e0ZqTGnQlQwZxCrOLYvg4a8WWSdRdF7uJMr5taTBC3gR3O/AIqx2izJ9xNgtI0DHUrGj1LyFuwaN/FX0r1lPlgUZL9c8VwC0+dsF4oe4Mt9xIgVD3qdMee/ywVgso61QE6FUYzfzb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQkZDihrgrO2B/NifV687co5tvKi7bV3BW0ZaHlmm7o=;
 b=XmgbrIr6yiOQ+OUAb7GNsRoe+EoXu4kcpS0muyGbAxZls+QlOMnPmrpVCfpVZxp0zfDgjkJsRJ3RNa3HJSNswWxUD+wLKE4OlR18abIQg53kNAHY9EppDC5jo+btVyPgKHQ0jFd0qYuxg1CYtTJJpeWTrWctqANrOAtJimIZzz6o82088OUveIwmu/PGgq+junwrwL/4Sujhq8DI6eNEyXBpQmM+eXGzNP4B/+XcZJ5a1AT1yc0C7V0ZcNMdrvTYvmqps1NIR+yA/gOErPJuNTxo0ENd3NT5aHyZV4MR3PxSCBM0Hf8sdFM5FTFtS4rBW9UpqOFHxqOqkpUHarO0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQkZDihrgrO2B/NifV687co5tvKi7bV3BW0ZaHlmm7o=;
 b=RcJxNvVt8YdPwc0xYdQyjgkJeUX1+1fjTbvjLZeYFBF/lEJhCHyDf0YCgJM58n6YxKBi5QPGvLsifa0FF1XoI3GsXKEGuHzxGCCA4mNe8mx/Ng1YS2yrUrYcLy56fOjfqbBf7niFU3tBHGCV/R1C+ZnZYX7ICPHt/Xm8/GsemNk=
Received: from CH2PR15CA0013.namprd15.prod.outlook.com (2603:10b6:610:51::23)
 by LV3PR19MB8645.namprd19.prod.outlook.com (2603:10b6:408:277::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 09:45:55 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::8f) by CH2PR15CA0013.outlook.office365.com
 (2603:10b6:610:51::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 09:45:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Wed, 3 Sep 2025 09:45:54 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 2DA3A406541;
	Wed,  3 Sep 2025 09:45:53 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 19DB982025A;
	Wed,  3 Sep 2025 09:45:53 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org, lee@kernel.org
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH 1/6] ASoC: cs42l43: Rename system suspend callback and fix debug print
Date: Wed,  3 Sep 2025 10:45:44 +0100
Message-ID: <20250903094549.271068-2-ckeepax@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|LV3PR19MB8645:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e6080817-4088-4a88-a4a5-08ddeacead01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|34020700016|61400799027|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V1plhToI5L9Ul4cekcNO87a/Dj40UcEst5y3OtATXS8oAZeksWSlJmAYM9LL?=
 =?us-ascii?Q?kMmQQKSxad0aO7Tycoex+YxUJqsYFdrFxufvf6qXuCa3C1f3PjrgkJFrh863?=
 =?us-ascii?Q?T4uXJPNnh06mrrMqk7kZ24KZLmPn3EAuHBoPt2R3jREoxpVPNwfuH9P97Gvf?=
 =?us-ascii?Q?TEs6//0XkoQ1+yKdydF9INcBC1DxetNZhDuPnrfzvFFwa6SAef4p78WRMJd6?=
 =?us-ascii?Q?0FVMgRXJzDJCgBudXaZ04Ux2yZox5tLX7ceVLa5dfel0hwk+4aA4WD9uEgRc?=
 =?us-ascii?Q?XYO1I+2S4mI63/uUSAkQJLSVute51nSK3SQw3Um8wf8CAUr4dIt2ZHnt6IfV?=
 =?us-ascii?Q?Z8JAaPH5oz3A7bGpD8Y5yAeTd7WAFTvUdvU6aOQzHSQdhV/5Rih1uVHvnQjK?=
 =?us-ascii?Q?lWtdnwvoZpJbu1iqE/N0ZYFPs/moztmgY6KizVGoSrz0dCSdpdx5ZThVTaks?=
 =?us-ascii?Q?M7APW966Waf1xHC94TPVifg+3w/MSyNI6AnIjuVkbnOFgGRx2S38gjROZ1KF?=
 =?us-ascii?Q?BBByLLJmH8sDEyHjLEDk7txoLRbrzN9n98wCp5qqjAqZnMwZYptsdpZTHaP3?=
 =?us-ascii?Q?RO8gx1gWWQ6YEO0zLojCKsbRyaQbJUtyOD4AAuG8CMlUbwiBbHF7yY7wa4K8?=
 =?us-ascii?Q?JmuNvB5W2Jti55zVEtOGP3Ul0ktQPADJglvX/36amvqFyFDJzpe4ofNv6Tpt?=
 =?us-ascii?Q?UyTydfkXUsGVX3bTEOmA4tfnpbSCzeBXdthrpPZqONeyH0eKzcBLYhsyzizG?=
 =?us-ascii?Q?J9a7KNEeB0eqyb5U4LzexwR18VK0T9IzfGw50XepBV5AN+NrkqsIL1+Vm1ql?=
 =?us-ascii?Q?STUe43Kv1c41fAaJUcJwZLBalGiALl0rc/S2AOkfqgrVaNHyoUVOpuFpzdku?=
 =?us-ascii?Q?nGXzm7PkDNCokJNvM5sRWoYFGnZau1iW0k6OkgoFGpZp7wsOiwZaQo6E9kLj?=
 =?us-ascii?Q?+W+thkB2+7jOmWuTQi3YqLNfJr8mFKq2INISH2d8VGn4uZowGJvBTJlmB5MA?=
 =?us-ascii?Q?MQSd1CaNfGN5UjwpwwYHU8hdJzbo7rSFFHaWLs+9TT/NIdGTipR7pSDoxK7X?=
 =?us-ascii?Q?CtM1Vr5OiZZcUczTHHYyTTuKr1VfJMz9U/Wy/5NsR7WF8L6bqZFIj9QEZKlN?=
 =?us-ascii?Q?R6r4WfJ6WCJfaSznmi/xya0MNLVtMW5ik22P0uVAUo6fZrn6vjzPdqBut1Dw?=
 =?us-ascii?Q?9tqLRoryx4j461NVQCm5Zso0SQyc70rpsEYg7vU99Rxx8n3FBJQjQytvokNe?=
 =?us-ascii?Q?U20xTXiE9bTyrnA0CL49VcMV6FssN6Kow1sHUZxnpV1tioKbUWW06D+SySxD?=
 =?us-ascii?Q?UufBKAhu7ftBHjt10WBskj/ddgCDy0A+tjkSHbneomWcpxlkHZOoOezXVSxR?=
 =?us-ascii?Q?3j2KrY4sm/ulSXOP4+y66MGl77Si4qtxcbSd5L/5LnQHeqOp1DZEpL8jpFUF?=
 =?us-ascii?Q?j3OzIAn5Fr42DgXK4JFEnCCnlw12ZB6NXANZYrG+lEXMA0UkNqAonxqlaaha?=
 =?us-ascii?Q?7dKkxiI3XVZSIWHTLh5lhVnHPRXrF3IPuRO0?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(34020700016)(61400799027)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:45:54.0897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6080817-4088-4a88-a4a5-08ddeacead01
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8645
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDA5NyBTYWx0ZWRfX6bYfemJlterl
 N5xoY2lKCjDh1KiukrdoPFKQ9Ag6VA6oCsc+U10aGLKasQ4a/FVcd9IpKJ3UgoPy27j+gwu8bYj
 LFKqor0H5sBsoZeVHe++DGJJCKjSsbPg2v2lJX+LWF2FqRkIs4Mk/N2iTkYo+ewbj6gDLifdPGi
 tTJ6Htz72IRSXGz6cClNABjvQBaHITyUoyZ41mgmQCoS0vhrOpxyS2jW2hVSC12WWXUdQiXVYet
 J5Q7QqRMQTN8+OnwadVDgagwNXbRu2DF9jeV8GmtL9Z3VMwcavcQYfdQAtl3NtzJ/bVX2TgAKeC
 PvwyDnJK4fRBN9BHTmnUNQQTPQLkqzsuKqyntZVwWzGIWaURDXVeyeb57eN45A=
X-Authority-Analysis: v=2.4 cv=BY/Y0qt2 c=1 sm=1 tr=0 ts=68b80e60 cx=c_pps
 a=6sg/H9X2hAOIoUO5KNDVHw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=6Bu7agoeOIQKrqNxcLoA:9 a=jZz-an6Pvt0H8_Yc_ROU:22
X-Proofpoint-GUID: I_OgjCgrAoAZ92jA1Rs2FqK4BFVTLYFe
X-Proofpoint-ORIG-GUID: I_OgjCgrAoAZ92jA1Rs2FqK4BFVTLYFe
X-Proofpoint-Spam-Reason: safe

There is some confusion around cs42l43_codec_runtime_force_suspend().
This function is the system suspend callback, however the name and
the debug print both use the words runtime. Rename the function to
the simpler cs42l43_codec_suspend() and correct the debug print.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l43.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index b0c27d696c58a..4d17799415817 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -2386,11 +2386,11 @@ static int cs42l43_codec_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int cs42l43_codec_runtime_force_suspend(struct device *dev)
+static int cs42l43_codec_suspend(struct device *dev)
 {
 	struct cs42l43_codec *priv = dev_get_drvdata(dev);
 
-	dev_dbg(priv->dev, "Runtime suspend\n");
+	dev_dbg(priv->dev, "System suspend\n");
 
 	priv->suspend_jack_debounce = true;
 
@@ -2401,7 +2401,7 @@ static int cs42l43_codec_runtime_force_suspend(struct device *dev)
 
 static const struct dev_pm_ops cs42l43_codec_pm_ops = {
 	RUNTIME_PM_OPS(NULL, cs42l43_codec_runtime_resume, NULL)
-	SYSTEM_SLEEP_PM_OPS(cs42l43_codec_runtime_force_suspend, pm_runtime_force_resume)
+	SYSTEM_SLEEP_PM_OPS(cs42l43_codec_suspend, pm_runtime_force_resume)
 };
 
 static const struct platform_device_id cs42l43_codec_id_table[] = {
-- 
2.47.2


