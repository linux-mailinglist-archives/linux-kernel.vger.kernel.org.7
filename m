Return-Path: <linux-kernel+bounces-777716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBFBB2DD07
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB87176681
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620FE319877;
	Wed, 20 Aug 2025 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="KfLcNyEk";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="XuLlHFoV"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45D62DECA3;
	Wed, 20 Aug 2025 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755694270; cv=fail; b=RueFTIzokfVvN0fsW7MIdALXpf4ytX4G4lMSk/TFw5e2ayyTWzd1kz9GpfUh+AxhbpPDDW66bGPXwZd8ZxVLMfosjDrx8HL5OUs9tzp1wImhv/g7G1xSnHR4loAU9zQUjbAUwMoWnQ00S69qq/fU7rg17h7XiHpzcTJvkUQ9Yio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755694270; c=relaxed/simple;
	bh=x8+NFzRjeMUsMak6480YA1PqMX8+coWLV2hT+2+3xFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqFkZt/Pr1Otz2TjWDT5wyZ7ncXoOnOHxVs2iqzKPelomO6W1wyo0bpybb3tgc93cdWuJWIxpFXXCe/9Hl3PlrnHp2zKENHcIcN1e2HHSD5CsVFphMmnz2EULrI1097tgqs3DJ0QDZvabF0CT3ZqCqHoB7xBK+2SfaeTzBrzglA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=KfLcNyEk; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=XuLlHFoV; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57JJYrkO368685;
	Wed, 20 Aug 2025 07:51:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=yozTj0/f1c5jh3L8zj9gvJya937f6IUR9XK0PekjSX8=; b=
	KfLcNyEknDEDb+AWQcdq+ggew41YmL9vJ+ObktBM+O9zl4s6XLyYvYGHTttDdAXG
	dyMGSXs7uS/Ep4qTy/M6e7py/TvCVxnkqkOE0OnEa6Id7Jkwe6YygQR1sJwlWDUe
	41mSLjyURTObg/zsS9HR7XiOTNtfSZ9QGFfAkuvuEQflVRJ5ykGuvXddKqDwI2mx
	4JPnms/07j2eUDcy6dzxim4e/NzlXRyBOBjkgr7CyvVvpvnMWJVH0uUFXKWc0Qjv
	Vg6xP8WUCZSHs6n/964ALWQh3TpC13PD0GMx+pTM5d1xwFTWgl0jg7CbCn9L2Xhh
	oJ8ncuAFfdkzwMF3IZHRBA==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2136.outbound.protection.outlook.com [40.107.100.136])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 48myd9971q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 07:51:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEeVHtPleSuJ0EfNBSNH8IrRVu/DIcpaAm5MNXXvm9w/Q+9LWYWa/WDKWaAvYySsaO1H6f6+lZZHUPUJxnWYTimptO4aABnDcX0Wq6tedUuZpwGXoh1TdLDw+jtQfLxUyWawmZbBJzV4oAgKZalInkh5O77FjBISxG9AyCu0hXYBS2wswjnEmGOx0qjtEAW0S3FDImcqjvyY1f+DzqXpYF8PtfzIAZlJADNWZsAS/ND2MULPJjgazeebT1K6+zP/VcyQKeTRyQd/itjrTPy5bE4RWm8oZcq7fAjw/z1A5f5q0JzCG3Wd51pEXY1SFDFgbUKhKMOVKS7Hhsqt8qvMvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yozTj0/f1c5jh3L8zj9gvJya937f6IUR9XK0PekjSX8=;
 b=aB5gM3tjttBeohEBov3Mk2TvM9CINw5gyZJjTTtuThMSIQXGS0JBFNlud90rbgJ8uKKmtNOVBHTr5SdQO7ckNH0piKvrHN8C/tXCml49R7Q6oXYMnyziLkyynM6PEKmwnhMtsCu92JTT1aIShPM02kLrDgN5J+xON1w4YTBks6lvV2MDtOZ8AFbcM5uzU57lIqN8ic4JgmtGlvDo6yDQ42+BahLSTaIuaYRVwOquW+RdGHazDrX4dSEJDEIItx3nVi1HVxGq0T5mzmTSRY1GBmioD7tkp6FfQYbqvIatx1t9ffxl6tTjWEuWc5wB0yFyWU3Su14FWGHAv9kR2XUmIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yozTj0/f1c5jh3L8zj9gvJya937f6IUR9XK0PekjSX8=;
 b=XuLlHFoVbhR5F+Qk5zAZotD7DqZPcQRcUGs1beuA/cOr71wI6EsVIJS6PIlk6OcwyU8sGo20EXVoJfK0eqYyEoX656zENZ9Q/Rg0cngmC/VfEQ7BtIiZoZlqSM1h+EJjAHFjYK1rAsr4h5rwy4NoGm6tlwjeBxk/A60hGA9hss0=
Received: from MW4PR04CA0317.namprd04.prod.outlook.com (2603:10b6:303:82::22)
 by DS0PR19MB8776.namprd19.prod.outlook.com (2603:10b6:8:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 12:51:01 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:82:cafe::36) by MW4PR04CA0317.outlook.office365.com
 (2603:10b6:303:82::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.24 via Frontend Transport; Wed,
 20 Aug 2025 12:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.0
 via Frontend Transport; Wed, 20 Aug 2025 12:51:00 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 50AAA406553;
	Wed, 20 Aug 2025 12:50:59 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 2977E82024A;
	Wed, 20 Aug 2025 12:50:59 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 3/3] ASoC: cs35l56: Remove SoundWire Clock Divider workaround for CS35L63
Date: Wed, 20 Aug 2025 13:50:36 +0100
Message-ID: <20250820125045.117740-4-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820125045.117740-1-sbinding@opensource.cirrus.com>
References: <20250820125045.117740-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DS0PR19MB8776:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8e8b6870-94be-42e0-706f-08dddfe8374e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Km5lHT6WOwIZ3pslVLfYrOpQpWPY5ch5TxBHRb5ghBJomtM3VWowVKv0rWYC?=
 =?us-ascii?Q?xF8UuG2vwORy3iQizLEPV8qCXGpE/G6X2DfhAgC9dhJsI6lxzTw8pmTEPb+M?=
 =?us-ascii?Q?1U9pXNjvGTklHnpmlNjYfgp4AbOduILocs14HqTKrWNjcAcoH+ZUQc3kRXMV?=
 =?us-ascii?Q?GFaBzK9FhZybul162kql1zJbJS6n+tYpepoNlq6ccZATPPIrzEPZZEBQlboG?=
 =?us-ascii?Q?pXpkTJWUaT1cFrark/eq/l+ou1xpj5Oa/VFgBe+EF1IbU0mSE/nHr/M3VG3N?=
 =?us-ascii?Q?aAKmWxyWOBDEdh97GAidg1ccoOxd1rB3SmX/yZqE4ap9OByVPknsLwDz1DZF?=
 =?us-ascii?Q?O/2sxPwmQxV8cwqJnIQGIaR0wRiUNR63fqp2LcXr+wE6ZNxG/jzie0b1gAiG?=
 =?us-ascii?Q?DY3/GCu38ff3ceD6SgJLYJ/KdTGNNB+vA8E94GZIwm4KTazuKOxF7V+jmhtd?=
 =?us-ascii?Q?HeBBmwv0xBhTaD95zRKY3wEwV9UgUp3OIwIl6jC3G7KWcsdlPn4ILZxhdk4O?=
 =?us-ascii?Q?d0z2Ah+B0R8dlLVcaxOUIquL11VLlJPF+XIobm2HHe2K3PjU8uwgEKfC1m+H?=
 =?us-ascii?Q?vLp5dfj7HvH1PkEoBsM9gjRvFgvLQsRl/eCVmL9OlPUaT4DXqp697Ism/e8U?=
 =?us-ascii?Q?5fiCe7fmlhAFPO0iajQI6xkyDbA3ufiIwWihlv4Jlk4qjwiG8kqnUrv71R5t?=
 =?us-ascii?Q?ZIx3loRe4rSmklkhlqD2nlZ/XqsFeJEIGoIrq6xzIcSMN4fEoZRGQJay8Y9r?=
 =?us-ascii?Q?jjhNZGw21PtwgIkihEz3NDfttJPc09NCr9b5LNXIe7fYFLy1fPc0ZQ2G+637?=
 =?us-ascii?Q?yJwrtBs1TpSpLEArLB4T0i7eKVg2p7jwHff5rOBhrEPc9klywtCCQC+g+MT6?=
 =?us-ascii?Q?D3fL6vkR8WMX3YF1wSc2VamGkj8tePIlPYSME5RlXs23Fq76+yS/+YpfjSlq?=
 =?us-ascii?Q?Q3sj2JZXsfloNniulnxiEWQnHPTuNfNSrin8eo1yztnlhGDyZIFjKjWtYVEd?=
 =?us-ascii?Q?NCD0U//odODmcspetTgzqlPkxz0qbtAzUOv47CzjOUKhNSkbfRQNBL2f4CZ3?=
 =?us-ascii?Q?PVauXMHdZLvJBLLr/QvVFm/Q59+17a7Kx5faYPMhqoXq1kjWDez6w+KGHbU0?=
 =?us-ascii?Q?iDqfLBHcb0B67phpOo9D/6TWMwXmbDsC1/aPGFgPKa7ziGvwNirwIFNQSuts?=
 =?us-ascii?Q?vJZH6C3yFg76H/g3g7Yqq99ZTSJ4KSniD/jhwrlH4v3G8hFpwMO/n8edx4ht?=
 =?us-ascii?Q?1c2hqZH2ZpfFQUcXaLCwMuBhhH3upGX/Ft3zKP+tU27uXL0Uh4edzVIMSHAq?=
 =?us-ascii?Q?8jis9C+r8ESuwQ1WyiugPgr/Ks8eO/4DknNHDyjwUDaf9fv6xDr/IIJSdq0/?=
 =?us-ascii?Q?0ebSB3jIwTGQi/9LWQM5P0dGC8TBQJpDFJUiZ43T529DLCWRuVZ3+gfK9XoQ?=
 =?us-ascii?Q?qiBJDck49WmBV3GNiaP67g4g5A+DTzEf826K0XOUZRO9+7pG0H1nsyDqC98f?=
 =?us-ascii?Q?ML1K6bTs4HLHMxXoNY8GRAPKliAPdzuzVzLB?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:51:00.6502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8b6870-94be-42e0-706f-08dddfe8374e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB8776
X-Proofpoint-ORIG-GUID: 4ytZwmh2TZqd90Gt86I8TH_SEjMvLI47
X-Proofpoint-GUID: 4ytZwmh2TZqd90Gt86I8TH_SEjMvLI47
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDExMyBTYWx0ZWRfX9xMQLqgipOms
 gt0XkNUK5lql0zzXHZGwghDUwDP1DtVGZDaJxhxrjhR6iYTTY5NUs/Bzjtypos+c/g7eZ8PnYCI
 lxfK1OBqe0KCAwImZu3PEdQEipqRKBQxoEO0AjwBciTIq5Myab23Lbmpbvd79gccp9RR7KhXxPE
 bWjTCKGKuaJnuW/UZtAanRFYNzJAqrnR+BMSp1mjoyX2S2ia6qZbV8pXKRSLzrc3B9WLgYasE1k
 zDXLScEJQLHfZ0VzNi5rz2aGVwjMyi4gO0McBQzDQQh/dT2AoDLBvLFApSiVIz3FgnPfd68gMQP
 drXruSnu7ZTgVTIlzPkTZSiQaOLpN2jDUeTWJnKrPUw/+mVbZepf+tTkyDRNJuKm7eYEp+LT1jb
 o95bz7uHyZkIFZYCg9v6egUNzRCXVg==
X-Authority-Analysis: v=2.4 cv=WIwmnnsR c=1 sm=1 tr=0 ts=68a5c4b9 cx=c_pps
 a=D0xTqnO8G3g1I/JDCPG9pA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=2OwXVqhp2XgA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=Eqq7O2SyaTNHdlpsiP4A:9
X-Proofpoint-Spam-Reason: safe

Production silicon for CS36L63 has some small differences compared to
pre-production silicon. Remove soundwire clock workaround as no
longer necessary. We don't want to do tricks with low-level clocking
controls if we don't need to.

Fixes: d3197a09a117 ("ASoC: cs35l56: Add initial support for CS35L63 for I2C and SoundWire")

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56-sdw.c | 69 ----------------------------------
 sound/soc/codecs/cs35l56.h     |  3 --
 2 files changed, 72 deletions(-)

diff --git a/sound/soc/codecs/cs35l56-sdw.c b/sound/soc/codecs/cs35l56-sdw.c
index ee14031695a1..3905c9cb188a 100644
--- a/sound/soc/codecs/cs35l56-sdw.c
+++ b/sound/soc/codecs/cs35l56-sdw.c
@@ -393,74 +393,6 @@ static int cs35l56_sdw_update_status(struct sdw_slave *peripheral,
 	return 0;
 }
 
-static int cs35l63_sdw_kick_divider(struct cs35l56_private *cs35l56,
-				    struct sdw_slave *peripheral)
-{
-	unsigned int curr_scale_reg, next_scale_reg;
-	int curr_scale, next_scale, ret;
-
-	if (!cs35l56->base.init_done)
-		return 0;
-
-	if (peripheral->bus->params.curr_bank) {
-		curr_scale_reg = SDW_SCP_BUSCLOCK_SCALE_B1;
-		next_scale_reg = SDW_SCP_BUSCLOCK_SCALE_B0;
-	} else {
-		curr_scale_reg = SDW_SCP_BUSCLOCK_SCALE_B0;
-		next_scale_reg = SDW_SCP_BUSCLOCK_SCALE_B1;
-	}
-
-	/*
-	 * Current clock scale value must be different to new value.
-	 * Modify current to guarantee this. If next still has the dummy
-	 * value we wrote when it was current, the core code has not set
-	 * a new scale so restore its original good value
-	 */
-	curr_scale = sdw_read_no_pm(peripheral, curr_scale_reg);
-	if (curr_scale < 0) {
-		dev_err(cs35l56->base.dev, "Failed to read current clock scale: %d\n", curr_scale);
-		return curr_scale;
-	}
-
-	next_scale = sdw_read_no_pm(peripheral, next_scale_reg);
-	if (next_scale < 0) {
-		dev_err(cs35l56->base.dev, "Failed to read next clock scale: %d\n", next_scale);
-		return next_scale;
-	}
-
-	if (next_scale == CS35L56_SDW_INVALID_BUS_SCALE) {
-		next_scale = cs35l56->old_sdw_clock_scale;
-		ret = sdw_write_no_pm(peripheral, next_scale_reg, next_scale);
-		if (ret < 0) {
-			dev_err(cs35l56->base.dev, "Failed to modify current clock scale: %d\n",
-				ret);
-			return ret;
-		}
-	}
-
-	cs35l56->old_sdw_clock_scale = curr_scale;
-	ret = sdw_write_no_pm(peripheral, curr_scale_reg, CS35L56_SDW_INVALID_BUS_SCALE);
-	if (ret < 0) {
-		dev_err(cs35l56->base.dev, "Failed to modify current clock scale: %d\n", ret);
-		return ret;
-	}
-
-	dev_dbg(cs35l56->base.dev, "Next bus scale: %#x\n", next_scale);
-
-	return 0;
-}
-
-static int cs35l56_sdw_bus_config(struct sdw_slave *peripheral,
-				  struct sdw_bus_params *params)
-{
-	struct cs35l56_private *cs35l56 = dev_get_drvdata(&peripheral->dev);
-
-	if ((cs35l56->base.type == 0x63) && (cs35l56->base.rev < 0xa1))
-		return cs35l63_sdw_kick_divider(cs35l56, peripheral);
-
-	return 0;
-}
-
 static int __maybe_unused cs35l56_sdw_clk_stop(struct sdw_slave *peripheral,
 					       enum sdw_clk_stop_mode mode,
 					       enum sdw_clk_stop_type type)
@@ -476,7 +408,6 @@ static const struct sdw_slave_ops cs35l56_sdw_ops = {
 	.read_prop = cs35l56_sdw_read_prop,
 	.interrupt_callback = cs35l56_sdw_interrupt,
 	.update_status = cs35l56_sdw_update_status,
-	.bus_config = cs35l56_sdw_bus_config,
 #ifdef DEBUG
 	.clk_stop = cs35l56_sdw_clk_stop,
 #endif
diff --git a/sound/soc/codecs/cs35l56.h b/sound/soc/codecs/cs35l56.h
index bd77a57249d7..40a1800a4585 100644
--- a/sound/soc/codecs/cs35l56.h
+++ b/sound/soc/codecs/cs35l56.h
@@ -20,8 +20,6 @@
 #define CS35L56_SDW_GEN_INT_MASK_1	0xc1
 #define CS35L56_SDW_INT_MASK_CODEC_IRQ	BIT(0)
 
-#define CS35L56_SDW_INVALID_BUS_SCALE	0xf
-
 #define CS35L56_RX_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
 #define CS35L56_TX_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE \
 			    | SNDRV_PCM_FMTBIT_S32_LE)
@@ -52,7 +50,6 @@ struct cs35l56_private {
 	u8 asp_slot_count;
 	bool tdm_mode;
 	bool sysclk_set;
-	u8 old_sdw_clock_scale;
 	u8 sdw_link_num;
 	u8 sdw_unique_id;
 };
-- 
2.43.0


