Return-Path: <linux-kernel+bounces-821299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AEAB80F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA80217DA6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D172FB603;
	Wed, 17 Sep 2025 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Q+dcALXa";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="c/uBUi8p"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11302F7AC4;
	Wed, 17 Sep 2025 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125180; cv=fail; b=k5K6LM1FEKgdy4zADx7HGjGXiGrNrI9ojyaF8azCntqLTVZBXxYy5pnHvrTOPLGTb6YUbmRDJuqPpkdyjeGmLjdwNrxPoBMmCvdVEkzmi8nOBb1f6T4NLKjTCMFFdT6b3suqg7vP0aGCScr5lUy7an3kVmb0qJavh3VcMa3p+NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125180; c=relaxed/simple;
	bh=0/g6lFq3wh/2SlpRzduvp6gTzH/yw4ugL65tj08dOVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UsBvDf6W2oZmtZdx/FPZ8I93yx4GV8l7MtZZaW90FMrgFKBrF9VMx84Xe1/MKm6hjGi3GEFp4dckK12L2Zc1FwyVqrytiJfqchw4mgHE50XCGglyWh/aaDCOuKkGELda9IPT5h/Fa9JdkC1LadcxFDePTvQ1n2U8g7BJ1Iv5jAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Q+dcALXa; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=c/uBUi8p; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58HB4s7t2719007;
	Wed, 17 Sep 2025 11:06:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=++MRtrCY6FLHhUfd
	WewZhm2zOwlEqIkHG0MavpWm8iU=; b=Q+dcALXaAdlxUrgZgCFnw6CiLLlYc1K7
	RiSTyLBpesIhlxo7x3tlxHk5DrbcD6zMbtBhRcI6fnShIURQZhopRuME3ZJzJY1n
	0bOV+E+hgh60jw1fg/uhRwDVsKaYqG5Um+0A22PIaTI69/EpMIAiTXTJBwhYtzfe
	zYxPMgp1KCSkTwT9ccR633VN5M9Qn7h13go7x50XIm0/7iwWcP31DS6gCJPCPqZK
	NQNODzyDzpc/E0qFkshNj+W9Dvi4e18s6KFFpvqFtB0WNhlUr6n1TWJ/QFy317Y7
	seENCHMbYEfl+YbYv0R91rYR+oR/2FaC8deCJz0HmGXShsPD4iJJeA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2138.outbound.protection.outlook.com [40.107.220.138])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 497fyksbwx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 11:06:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEUbcPK3o0Vhu/z0UIbrSLyrKdOqPpB71aPCUmjR3MUVEuOQ/CtSkaZyp5lr3xOOF1W+SEhjKwFCqXOsF7TyNREANn1gOqVYz2EMGHg8l/Sy6LYdtgQCUABkOfIpSeV3ctlfHINQtTGTwvPAI7lpN7VpHsY+82JWo5DjGB/2PvjoM9c9aUE60DzJaP1XMWK1OD9YwE9ZRNcUFwi/tHot1ov91XzFj3CGk62JtEhito5hZhT8WPkzZneBqjLGVh50PRrCFy5Zcw4A4lPXiN1b8396RfhpG1EaS8puMjh5RgVMLnQ0tkTwfneLaM1uPAckxKyEixl8dA7pFpETWoSS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++MRtrCY6FLHhUfdWewZhm2zOwlEqIkHG0MavpWm8iU=;
 b=o/Te8EIzTTmtIJM9UEed34/yIrd7+bU9PTfddXIs2RTBREYoIsKM11jzMS0MTuRBB2VA5FiLMoAtKYTNtYWaI+XGMTDC3gNM2v9otaEcSm3+LYxx7kqYtAWXjGy4Rz7Z0XqD3wDYRB2qsBbH5oGS3JHXpkd+Lx+3Z5egjpGB5uMQ6sMLS8eqOYZLBgwJECt7g9WcZ3V0QcfdCnbJiQ5OSGAcpWomi6ylsLt9T6wLGrSulTaYDC7PALgzsxCXpbL5eNvAdrdi6zBNJJf35V+9kqoGvxKc/b9QxAWCAYZ+HOLUfOh5NIdVGlKC74qhpe9tnxdsNtuJCinXJ8Mzvj+T4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++MRtrCY6FLHhUfdWewZhm2zOwlEqIkHG0MavpWm8iU=;
 b=c/uBUi8pHY3qL95B0pXPUEqU5pblQAaGeIqdRqFpnZaK2Dl/AUR84hbhl13oSawdUg8Q8wFwWnp87eDmPY97rrlFG+lZRvMfw2o60NExousd6jIkFyxXGHwi5xV4G2li8pC7DjwWO1sYavQDaYRrRq4435FGbP+3g+B2aaGPShI=
Received: from DM6PR02CA0144.namprd02.prod.outlook.com (2603:10b6:5:332::11)
 by EA3PR19MB9545.namprd19.prod.outlook.com (2603:10b6:303:2b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 16:06:11 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::f8) by DM6PR02CA0144.outlook.office365.com
 (2603:10b6:5:332::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 16:06:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Wed, 17 Sep 2025 16:06:10 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 67E93406543;
	Wed, 17 Sep 2025 16:06:09 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 4F51982024A;
	Wed, 17 Sep 2025 16:06:09 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: tiwai@suse.com, yung-chuan.liao@linux.intel.com
Cc: pierre-louis.bossart@linux.dev, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH] ALSA: hda: intel-dsp-config: Prevent SEGFAULT if ACPI_HANDLE() is NULL
Date: Wed, 17 Sep 2025 17:06:09 +0100
Message-Id: <20250917160609.461718-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|EA3PR19MB9545:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 80e79493-83a3-46f6-e738-08ddf6041eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ktug4XkS03coF7S9IPoAVFJ/03m9ffEGs3O8dKOnJKWpTti77K7VUp47dhdl?=
 =?us-ascii?Q?+N8ogdWkmSz3JzvAJ/iCeh37HST03bjwM7QBepsI+v3mmiRhSNlCwkrW/jrI?=
 =?us-ascii?Q?uZ26Gv/DJrp/VHZe0oAU+ENj42EkjkV73DxT3tNVvQHLKXiAsk5fNFYL/5mU?=
 =?us-ascii?Q?MUqXvgcgKzfYaQL8JPyYrTaALsJfWA09Mf6fKA0pNrc/UplAzZ0+wQq/EPfo?=
 =?us-ascii?Q?pyiY6R26xv4O7WDc6XZ+s2Q1oK4Hn0PDwqyQziqPkLHp0YbbUtG5EMArpcHM?=
 =?us-ascii?Q?ZpKZVl+Cp2r4RVVookxaSEeN0YTyNeqBPI2CzUVrwY1GVYmQdfGe9KSTWG5S?=
 =?us-ascii?Q?OZyUC8emFCMiEcf1qYo2cabf3nLVcbWCzM424xJYcUhFTGFKG8+T4ctXCR5Z?=
 =?us-ascii?Q?HkMhvUWE3LfRpkAa+0c65D+Hf0bV9ltb1r7mdh/YgOW59s9ngfsVAxxlMNKG?=
 =?us-ascii?Q?ZyLwp4010zLpZu+w4taY8QdrJRv1X0ZR6IOYGESC4PkrIslaX3nQ/vORqQbR?=
 =?us-ascii?Q?92Q2H3MvXRek1SZ9CtzYamoRlLQ5czSxfzm274RQKiib4luM5RqqWmmro1y8?=
 =?us-ascii?Q?5Czc/He/+dQLWfdsCBpzOlcXl9vGtCX5wqAOJGew/ng7Kli1eMp9/HLts3Cl?=
 =?us-ascii?Q?EffWEx/MM5cKZaNUmXLcHiKR4xwIsjZkL0gA9UFfzbyunVOE2SGlEk8Gqcc1?=
 =?us-ascii?Q?Wtuu0g+0pQrwk1IZ9LynMD48i/I3Zw21Az2dm+YpA6/DSxrdTCY8VPMC+rUL?=
 =?us-ascii?Q?b66+11sf5CfprFOhZB3zRyjTbALUrz+rp5/YgoM/apHlvlItjMx/7yn6XgeG?=
 =?us-ascii?Q?aFGe2coICtb3wki8mWa4k4e9BrzKPDTRdicjpeNSQ/raDmp3yIEvA3K7Urrd?=
 =?us-ascii?Q?BE6MyEZGKKMsSg00QzgbSvODY5+eq6bKBbbmlFK6WFD+5qvuE3rFp2oqzAGb?=
 =?us-ascii?Q?t2PKrPJkhf/I1/WYChjOO2afNOx+rZPHbTin1lalZ21hv/xrON5HvVNl/w0t?=
 =?us-ascii?Q?xBPzIgylhsxzYb8Sj4TYaWYMKBfND1NeeiNJ4As+8FPdZzcgZcbFIx+HumkR?=
 =?us-ascii?Q?4PEbdWqaYI2qAJRlz7H6L7la6v0Dc+863TZOyUvp4yfW2HqU6ZO0N6kZZ/Hq?=
 =?us-ascii?Q?jYSIJviB+iqnHoLLlSBlFZ5ds2GL2F+7oU7lc8k6afkxawoaPIRwkmA7utFS?=
 =?us-ascii?Q?ru3AMy/0CwWVxQri6kDeMMD4ghPCRcoKNQ5LYQ81ziejCcCN2kgHzcAg8wlt?=
 =?us-ascii?Q?msj5Pnx5wgdxdBjao9LNjffKltvETiUDpepsdPVlEnW2d9K5y3cKT3sa755A?=
 =?us-ascii?Q?meoQf6YV/G9ZZ/yv7K8b9lJMg9jHgVm4co2mYgDVx+Sp2E9rqWCP/vr1eQ5E?=
 =?us-ascii?Q?birgG/lCM/BvLhM4appfuGqPnLsgxIm+JzeI6mt3GoUgxcBQ37b799LCzpQp?=
 =?us-ascii?Q?kBTkZx5tyz9JfaWKpJxN1sgojLAQ5PPZPBcd9gOoQXwKf2vyRTp49c4Ylt5A?=
 =?us-ascii?Q?8ZpkXp++y2iiro7SzpbXAymDn8SpOq2q4QDG?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 16:06:10.8867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e79493-83a3-46f6-e738-08ddf6041eae
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR19MB9545
X-Proofpoint-GUID: jAegjDPe6tM9TsxPnkFlPOxklg2oSv5q
X-Proofpoint-ORIG-GUID: jAegjDPe6tM9TsxPnkFlPOxklg2oSv5q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE1NyBTYWx0ZWRfX0DxghWvvja+o
 Yb+yRBpfbSJepYA1Tup4xRIIIdo0QcZ1N53m+OtKmWKxFQlfhWfkdHmwSS0l9+oao1eKq0hRhzC
 fFShc4sb5Jwp2Xq0c1vaM/ngD3k0tHuzOqt+Zx996xR21GRPjpOayTKCq97dvz2O7rxi/NvfFxN
 w1/rgfE0dJb117ejs3ZgUkZSnDGU/rLg0N544FqN/oZs+zI6TdF4OaYEtv189LLsgjs7gSYal9Z
 vLrCb1HPwiQppzn7LCR9cxXeHkyH+k22yhT5S13+6ZkG0OtmxsY8khROzW85awi6Lr1de6pKn+J
 YjGS4l0CBUdFxZbDc94rYJuxQfC7Qb866jphgKl7LKRpQHM/8c3LV9oNgUCRho=
X-Authority-Analysis: v=2.4 cv=KvRN2XWN c=1 sm=1 tr=0 ts=68cadc76 cx=c_pps
 a=5HixKquiyx8Pok2ot0WeLw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=ho6PHurOjkAcaGS-XKMA:9
X-Proofpoint-Spam-Reason: safe

Check in snd_intel_dsp_check_soundwire() that the pointer returned by
ACPI_HANDLE() is not NULL, before passing it on to other functions.

The original code assumed a non-NULL return, but if it was unexpectedly
NULL it would end up passed to acpi_walk_namespace() as the start
point, and would result in

[    3.219028] BUG: kernel NULL pointer dereference, address:
0000000000000018
[    3.219029] #PF: supervisor read access in kernel mode
[    3.219030] #PF: error_code(0x0000) - not-present page
[    3.219031] PGD 0 P4D 0
[    3.219032] Oops: Oops: 0000 [#1] SMP NOPTI
[    3.219035] CPU: 2 UID: 0 PID: 476 Comm: (udev-worker) Tainted: G S
AW   E       6.17.0-rc5-test #1 PREEMPT(voluntary)
[    3.219038] Tainted: [S]=CPU_OUT_OF_SPEC, [A]=OVERRIDDEN_ACPI_TABLE,
[W]=WARN, [E]=UNSIGNED_MODULE
[    3.219040] RIP: 0010:acpi_ns_walk_namespace+0xb5/0x480

This problem was triggered by a bugged DSDT that the kernel couldn't parse.
But it shouldn't be possible to SEGFAULT the kernel just because of some
bugs in ACPI.

Fixes: 0650857570d1 ("ALSA: hda: add autodetection for SoundWire")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/hda/core/intel-dsp-config.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/core/intel-dsp-config.c b/sound/hda/core/intel-dsp-config.c
index c15284742899..2a9e35cddcf7 100644
--- a/sound/hda/core/intel-dsp-config.c
+++ b/sound/hda/core/intel-dsp-config.c
@@ -650,6 +650,8 @@ static int snd_intel_dsp_check_soundwire(struct pci_dev *pci)
 	int ret;
 
 	handle = ACPI_HANDLE(&pci->dev);
+	if (!handle)
+		return -ENODEV;
 
 	ret = sdw_intel_acpi_scan(handle, &info);
 	if (ret < 0)
-- 
2.39.5


