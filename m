Return-Path: <linux-kernel+bounces-798187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52559B41A72
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E3B160597
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B142E92D0;
	Wed,  3 Sep 2025 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="bFWXAnCN";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="lpoEDt/H"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8A3270EA5;
	Wed,  3 Sep 2025 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892778; cv=fail; b=aPLblXHjeNU16rNQw9MtUISnEV0BN9R3D+1vFKsUATJ/Pu+Ak7XvfBKKFLbJknUla9lYUGpz8g+EtN7mkobfXm3zUtr9SlysPHtg88A6FDlCxiPnImb1wNpsMo4mIHf/MScevSkC5/ipsbElpZtRHJm8VmC0TWsJl0JAc11WfMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892778; c=relaxed/simple;
	bh=TcpV9lrrpkaZ5LwlTkwpFEKvF1H6c3ZsjKNSoEweLAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnWAlyaLB8UTjW59zEUL/740q4smrlk0tvTXiNJgJsxrjkOzNhip+vbAXZ7PGUu9TF8zGiP0uMudF9Z3nzjxZo8rB3PDU2LIIcLU2N14VWPvUcauq8m/SiEtXOcz3nYRniw5cG30Ak3NHnEj61WsXUIR1CBzS9Kk8AlCYEoiybM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=bFWXAnCN; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=lpoEDt/H; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5834oIup858992;
	Wed, 3 Sep 2025 04:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=1JS2GqWAEBa5huokXYLwTrGnM7JThX4/T5SOpoCCYDw=; b=
	bFWXAnCNMfSQNSBsoiOjBM3yr88T77Si03tk7IZStvPFejuoMoZDYG/IiUHkbeaZ
	vp/3Zb/HqOdp1PIp+wCF0E6w/FNKPvoILBLxKdE7sbYcLULDWGq6lESiCHlo2D1o
	jUEXvq3JEMFOUUf2QfhJwmMnRzRGvxpXzwK/tiuS8OOtsx4/5NUZfiQVcVUVTr5A
	vsmc885pGqFfHmhH/qg4BrUvO55xrYXsfJcqfnnejcEBmQ/WN26l/LKsULc9lU79
	dc8qBxYDwpYlIhTU5y4iG9L4+hAHr/jMRTCBiN101pphe9cRixc84MaxYBN2lG5h
	d9W0PrEma3bIGeSNN7myNw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10hn2213.outbound.protection.outlook.com [52.100.156.213])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 48vensc6d4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 04:46:01 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sejGN86CZozrovixuVM4xP16W5Z8ioo57kzqT0x54hJpNOFAGvpdmVjEbwOYBYy7sw41P+ExEMXk/rpEEML6XvkmvbTLoQs6zqkeGakULWj36mYUSGToAzvfEYqZCoKL/miHRELuP4HBu08KkhWCFuz0WJFE4ftJcn7YoH6V+XSik/hG3yZrgXPsjIlk/75QOt1AIIQCL6wROoPkZXThEtmq9KUEoFNagBsItR2WKcsLYH8B4bqN2bizO5CAoQigBxo5QXs18WS7YTGQfGXX3oiRq90x3UlAit0DbllMg5TggCXjii/9hx4klDB+QAGdCvu5hlSagtYftUcF6P8k/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JS2GqWAEBa5huokXYLwTrGnM7JThX4/T5SOpoCCYDw=;
 b=CD+QqhZq6vbVtERImGV6m0Xk9zm01YuWEPDaU75yAIWZb0Ruy1YmM31JJ+aYBU0WC70DmF4HEeIjzdohw66OnYrI01EAMMy/gNPOYXZ08Kdjk5ckoylgNgrt0zEvUoDhwz0SE43olKB0ld+KUCHHw/aiYdsCjps7a3lor6XGGTG2Aqr9ts0fwiLEz5UbqaZp0wXoJMnsV9zBTcCyhj/vMH7BmY9PoyQ25VrkU/ivSFvkxxiqvYpEa4LQu1ngEU1wU00DCOxv5l+VLWoeYjKziZ6Yy/DxsfpdWHUrTE4k3S+hatAsJq9OE+ZD+wVrJNgp32tS+BAGb8L4ujY4Y241bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JS2GqWAEBa5huokXYLwTrGnM7JThX4/T5SOpoCCYDw=;
 b=lpoEDt/Hydg1o5S+LUs4+ydC0e4Z7Pv89DIqA2R9ZHD7ziWn0+uBhZM34V7AtVcVMtU2NtR04hdfXVz1tmMmCR/NRB5AKoYdcAGd/wM3/s9ckVZkFzuRuF7A7VnnaDiMYIwhSKDysBxFEW+cR0PtqWdzOW88EwK5U+Q06rMfG1I=
Received: from BN0PR04CA0136.namprd04.prod.outlook.com (2603:10b6:408:ed::21)
 by SA6PR19MB8676.namprd19.prod.outlook.com (2603:10b6:806:41b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 09:45:57 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::2) by BN0PR04CA0136.outlook.office365.com
 (2603:10b6:408:ed::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Wed,
 3 Sep 2025 09:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.0
 via Frontend Transport; Wed, 3 Sep 2025 09:45:56 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 42EAA406545;
	Wed,  3 Sep 2025 09:45:53 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 2B4BB82026B;
	Wed,  3 Sep 2025 09:45:53 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org, lee@kernel.org
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH 3/6] ASoC: cs42l43: Disable IRQs in system suspend
Date: Wed,  3 Sep 2025 10:45:46 +0100
Message-ID: <20250903094549.271068-4-ckeepax@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|SA6PR19MB8676:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: baf3eb52-acff-46b7-1967-08ddeaceae52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|34020700016|82310400026|36860700013|376014|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oPkHJ8KBTekqGvITdNVx9bCfNFDQ2FoZFIPq+8wwu33KoO4/Kcfcz+V7oPMu?=
 =?us-ascii?Q?osxYtMM8Xj/n11guxkCeK/6gJm/o/SB2qw9EnhjSB9MThMJQgJD5/S4E+sDW?=
 =?us-ascii?Q?QW0izHivmBAaJ2Y8WDm0wuEsBFvCF7Cd+UftaZPfWvXCH1KsL8IYO7A6KMpH?=
 =?us-ascii?Q?wpwynqjqZ9vGmlIfsX/CSGPydvmziDDi5PT6EYgq64b4Kk8L6phbWLvsTop6?=
 =?us-ascii?Q?0bTr1/AEO/YBtilw8EKcAwNUf2rMhyKRHhQSodkrcKcbunO255jYw9ngAU8c?=
 =?us-ascii?Q?eBgkz/c0c5U6+Bmbdu+tXDquUy579eVrk545udmtW9Y0NeSCogRQIebchu8c?=
 =?us-ascii?Q?MJv1mDVCotP9MhkJvJ/4n8hZRxOMm6LFZc97/09QBG2UckYyw/IOCtPcP+IT?=
 =?us-ascii?Q?7iO8gsxwSxZoqiIPQ7hk5ol21OuOB6qM0yERGvUqMl2gMWjP60mTv5KkFZij?=
 =?us-ascii?Q?9VKFjB3xv4GFCYcX3zED757iQ3bEzalMzSOM1toKHvHQ6zkJUIcSlbsAa5vA?=
 =?us-ascii?Q?ik9nq2TKiNd2wUZepXqHHQQ0kjvk+mB9pshZpWQ/ozGGA3o6eHx8+SQUj4/5?=
 =?us-ascii?Q?cXl0mtB74I/tEphTENcplvpCKESEaSekW/DzFgTI4V3EvlgB0qX0RH9LcQti?=
 =?us-ascii?Q?LDlHB3xTfhfTWP3JOdN9bq+u7JCoRH9n15hj+bf1fuY8syK8yNGcCgx1bQE9?=
 =?us-ascii?Q?gjQbgAJd1MFSN8qSDCZ4ut9za0sNsoThKsRtzK8gWmVK5HGrnFUb/Jq6Bdp/?=
 =?us-ascii?Q?EDQMMwv16KD15wP7PQ0hSHYnfbONgoTxpREDiqVS5ROT2KkkZ6x9lmfQbT9B?=
 =?us-ascii?Q?F6l+hlJ8J0kM6bdvYBWwBdcCI+oHVvpPPXTIy+JpQ2AEEKDeLpokUmqbCve9?=
 =?us-ascii?Q?/Kyo2Obr/ud/c02lDaRfs4BeGIa3/3usXcnrd99m73B6mgbvNHA9+6i38qEP?=
 =?us-ascii?Q?6iyLbyVJT42GkzKk0VXa0HwA95wT9mm4L+F4jmoUopoVIZTM0EDyP5FGkEwv?=
 =?us-ascii?Q?kgEGMKFAGCqtOqOeL3z/746djWHprBmYkynLRKCP0tkw2JSy6vjej/Mp9W/m?=
 =?us-ascii?Q?zACcphqAvBTwpDU72iartALYW4RZ8Gu9M8/3zEOprJLlCjx4c/a+LBh6qBah?=
 =?us-ascii?Q?fcfuNEHAAovHdpcRSQVloEUlQrUlIFWR2ZfHiuV+YxB4fLRvoGSLk71ZgXcV?=
 =?us-ascii?Q?pb1EK0hJpBJoRAe5reDvEkmcmSZyF3JtGRe/WUq8zfLhzWVOT1m8XJuzCM01?=
 =?us-ascii?Q?dtwXMSiYEQEaZVpSuyBsk46JQronkM8DXHEPrJPvSS42dATjtLSRSIJrjnOl?=
 =?us-ascii?Q?Kvc3Q9x1b+8vY5+ZgmmuqIYZxxppVHKG4QV0rZVk82mgBRMFeBJMr+3VP1CS?=
 =?us-ascii?Q?CVeICSZ8iDqB16MdqCYXrzaM+WIe/yddg0AX5P8p+C0SBD2xy+HESBFIgg/G?=
 =?us-ascii?Q?aDMEFzi3EB81llmHNfTlCrPTS9nmD/TpXTJzZ3MlCKbYq6iSCqQBq/Uqh1Be?=
 =?us-ascii?Q?yggmFyyF+D1e4bV3lEN5+LwJkcsYrP4e5YPh?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(34020700016)(82310400026)(36860700013)(376014)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:45:56.3097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baf3eb52-acff-46b7-1967-08ddeaceae52
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR19MB8676
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDA5NyBTYWx0ZWRfX2zxxFE5Vcv6g
 2JtRrdhfdcJB0dWO8WJ8Tg1hyvUw+iDo2qiM1RnGElSf2oU4DQAhL4c0quj/f7hfJEpzb4tS7FA
 gsRMobGoQs/6B4nBhK9hBlW8pYjRFpPeu5X5yZlkrH0h6xRlgnfsFJtIVHPM9RVLCmS8Gd5JXAw
 +c57xSW6Sz2rcH6S1Vj8lmJjard9NDGDVLdKQYy2ebOS/ZOuI3lpdMezE/UwBakR6epsAtTDY0/
 jcFRxkd45MaPKPDOHMyi1olwUSGb6p/WoitGhXN0kwIjjMLHZxsrKYm2XKzNPf7c6o8m+AuIz1+
 66Pnqj5jDjjNtVzxJZ22X2aHv4k0em6r/agjpCrlHBguDjXH241x0hWIu7xF58=
X-Authority-Analysis: v=2.4 cv=BY/Y0qt2 c=1 sm=1 tr=0 ts=68b80e59 cx=c_pps
 a=iNF5YVRtssmCLvDReD0Rxg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=WGF-i4tbfY4VCuSaCLUA:9 a=jZz-an6Pvt0H8_Yc_ROU:22
X-Proofpoint-GUID: FXqVLiCypbHdKkkrx05kEiurPLCGYide
X-Proofpoint-ORIG-GUID: FXqVLiCypbHdKkkrx05kEiurPLCGYide
X-Proofpoint-Spam-Reason: safe

Currently the MFD driver disables all the IRQs upon entering system
suspend, however there are some issues with this approach. As this
device uses runtime force suspend.

The regmap IRQ handler can run, claim a PM runtime reference and get
scheduled, the MFD can then force suspend. When the IRQ thread gets
rescheduled it will try to access volatile registers on the
suspended device. Furthermore, this race also applies to work queue
items scheduled by the IRQ handlers.

As the MFD code doesn't know about the individual work queue items, the
end drivers must mask their own IRQs and sync in any work queues as part
of entering system suspend. Update the code here to do so.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l43.c | 78 ++++++++++++++++++++++++++++++--------
 sound/soc/codecs/cs42l43.h |  1 +
 2 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index 241f7d013189c..405926149a137 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -2229,12 +2229,29 @@ static int cs42l43_request_irq(struct cs42l43_codec *priv,
 	return 0;
 }
 
+static void cs42l43_disable_irq(struct cs42l43_codec *priv, unsigned int irq)
+{
+	int ret;
+
+	ret = irq_find_mapping(priv->dom, irq);
+	if (ret > 0)
+		disable_irq(ret);
+}
+
+static void cs42l43_enable_irq(struct cs42l43_codec *priv, unsigned int irq)
+{
+	int ret;
+
+	ret = irq_find_mapping(priv->dom, irq);
+	if (ret > 0)
+		enable_irq(ret);
+}
+
 static int cs42l43_shutter_irq(struct cs42l43_codec *priv, unsigned int shutter,
-			       const char * const open_name,
-			       const char * const close_name,
+			       const char * const open_name, unsigned int *open_irq,
+			       const char * const close_name, unsigned int *close_irq,
 			       irq_handler_t handler)
 {
-	unsigned int open_irq, close_irq;
 	int ret;
 
 	switch (shutter) {
@@ -2242,26 +2259,26 @@ static int cs42l43_shutter_irq(struct cs42l43_codec *priv, unsigned int shutter,
 		dev_warn(priv->dev, "Manual shutters, notifications not available\n");
 		return 0;
 	case 0x2:
-		open_irq = CS42L43_GPIO1_RISE;
-		close_irq = CS42L43_GPIO1_FALL;
+		*open_irq = CS42L43_GPIO1_RISE;
+		*close_irq = CS42L43_GPIO1_FALL;
 		break;
 	case 0x4:
-		open_irq = CS42L43_GPIO2_RISE;
-		close_irq = CS42L43_GPIO2_FALL;
+		*open_irq = CS42L43_GPIO2_RISE;
+		*close_irq = CS42L43_GPIO2_FALL;
 		break;
 	case 0x8:
-		open_irq = CS42L43_GPIO3_RISE;
-		close_irq = CS42L43_GPIO3_FALL;
+		*open_irq = CS42L43_GPIO3_RISE;
+		*close_irq = CS42L43_GPIO3_FALL;
 		break;
 	default:
 		return 0;
 	}
 
-	ret = cs42l43_request_irq(priv, close_name, close_irq, handler, IRQF_SHARED);
+	ret = cs42l43_request_irq(priv, close_name, *close_irq, handler, IRQF_SHARED);
 	if (ret)
 		return ret;
 
-	return cs42l43_request_irq(priv, open_name, open_irq, handler, IRQF_SHARED);
+	return cs42l43_request_irq(priv, open_name, *open_irq, handler, IRQF_SHARED);
 }
 
 static int cs42l43_codec_probe(struct platform_device *pdev)
@@ -2325,14 +2342,16 @@ static int cs42l43_codec_probe(struct platform_device *pdev)
 	}
 
 	ret = cs42l43_shutter_irq(priv, val & CS42L43_MIC_SHUTTER_CFG_MASK,
-				  "mic shutter open", "mic shutter close",
+				  "mic shutter open", &priv->shutter_irqs[0],
+				  "mic shutter close", &priv->shutter_irqs[1],
 				  cs42l43_mic_shutter);
 	if (ret)
 		goto err_pm;
 
 	ret = cs42l43_shutter_irq(priv, (val & CS42L43_SPK_SHUTTER_CFG_MASK) >>
 				  CS42L43_SPK_SHUTTER_CFG_SHIFT,
-				  "spk shutter open", "spk shutter close",
+				  "spk shutter open", &priv->shutter_irqs[2],
+				  "spk shutter close", &priv->shutter_irqs[3],
 				  cs42l43_spk_shutter);
 	if (ret)
 		goto err_pm;
@@ -2386,19 +2405,48 @@ static int cs42l43_codec_runtime_resume(struct device *dev)
 static int cs42l43_codec_suspend(struct device *dev)
 {
 	struct cs42l43_codec *priv = dev_get_drvdata(dev);
+	int i;
 
 	dev_dbg(priv->dev, "System suspend\n");
 
 	priv->suspend_jack_debounce = true;
 
-	pm_runtime_force_suspend(dev);
+	for (i = 0; i < ARRAY_SIZE(cs42l43_irqs); i++)
+		cs42l43_disable_irq(priv, cs42l43_irqs[i].irq);
+
+	for (i = 0; i < ARRAY_SIZE(priv->shutter_irqs); i++)
+		if (priv->shutter_irqs[i])
+			cs42l43_disable_irq(priv, priv->shutter_irqs[i]);
+
+	cancel_delayed_work_sync(&priv->bias_sense_timeout);
+	cancel_delayed_work_sync(&priv->tip_sense_work);
+	cancel_delayed_work_sync(&priv->hp_ilimit_clear_work);
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static int cs42l43_codec_resume(struct device *dev)
+{
+	struct cs42l43_codec *priv = dev_get_drvdata(dev);
+	int ret, i;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(cs42l43_irqs); i++)
+		cs42l43_enable_irq(priv, cs42l43_irqs[i].irq);
+
+	for (i = 0; i < ARRAY_SIZE(priv->shutter_irqs); i++)
+		if (priv->shutter_irqs[i])
+			cs42l43_enable_irq(priv, priv->shutter_irqs[i]);
 
 	return 0;
 }
 
 static const struct dev_pm_ops cs42l43_codec_pm_ops = {
 	RUNTIME_PM_OPS(NULL, cs42l43_codec_runtime_resume, NULL)
-	SYSTEM_SLEEP_PM_OPS(cs42l43_codec_suspend, pm_runtime_force_resume)
+	SYSTEM_SLEEP_PM_OPS(cs42l43_codec_suspend, cs42l43_codec_resume)
 };
 
 static const struct platform_device_id cs42l43_codec_id_table[] = {
diff --git a/sound/soc/codecs/cs42l43.h b/sound/soc/codecs/cs42l43.h
index f4ef93d1fc2a4..0951ad3525efe 100644
--- a/sound/soc/codecs/cs42l43.h
+++ b/sound/soc/codecs/cs42l43.h
@@ -45,6 +45,7 @@ struct cs42l43_codec {
 	struct cs42l43 *core;
 	struct snd_soc_component *component;
 	struct irq_domain *dom;
+	unsigned int shutter_irqs[4];
 
 	struct clk *mclk;
 
-- 
2.47.2


