Return-Path: <linux-kernel+bounces-794065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A1AB3DC54
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339A9189CAF8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005B4268C40;
	Mon,  1 Sep 2025 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="pIPSfRk0";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="oGNhIhBd"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AEB2F39C2;
	Mon,  1 Sep 2025 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715222; cv=fail; b=Mwn7Cqa6/5Lv112aGdAupyKHIm8QtyT2twAbII0oVezlAhRb13iQJiNbbkjw/ycXmiRRGNvl8R6FmSKUcmZwiF39PmOyhEjMJR5lBJOnRJq/w/iCuzv/HJvBUHv8kxrtZz1veeBDUILQuO4lnpShu6x7HzFR30swV3r3kO+qlCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715222; c=relaxed/simple;
	bh=ErTtuT7P28CJJlHjY5Jrb4VDmT42xD+uw8+vD4Oi2mM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qsnZQWNY+0Xkpi+6rBCRgjt2wjpDzsz/x0BIuyfwc8Pk2tbr2szEmlK7lE1844JuoyM/AjIQWBC5Czpdaca4711ShqsdiFhjmOJjlJcpH1UMXyaAk84HNIT7WQZqG6Epr+0JMwLJ2uEpZz3nL/+SwE3ndIDtYINFnF3I79iNXkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=pIPSfRk0; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=oGNhIhBd; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57VLSbQJ672664;
	Mon, 1 Sep 2025 02:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=fT94xM0TKO3gd9ZZ
	3q7aivurKbc8XGJsKe7j+4R+HpA=; b=pIPSfRk08bJO3edklJwcvwoLb3ikDfoA
	1HIYlTxlggcIeu6QPMEEH+s4/jTdMCk9ZdoMbaNJ9pq33jLa8+61OsxvllMJSUQL
	nE1n9CGeyzg89kAXfWoCWI9wdGRtYohBMn4aFzLbhyrS567k6rq3acVreo9+APPW
	bViYjSpoAphKo1Cyo1FwoVzgcrNmuKcWyqZlxxe0gBhSyJ059mms/Gfi4RifTqTB
	net9dXiC3iE4bD1qt87pAyOyhD5ORfww8/jkMRip1594NlQAk0P5gjT3490iDqhj
	MtJY74K1zb1trR38isrX08iW2kV2w3VYJevtwZMiA9Y2NZdHM30wqQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12hn2201.outbound.protection.outlook.com [52.100.167.201])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 48uwqhsm8x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 02:58:15 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmPrD9IHkmmheht+YWF5+NNfj8nuc2REVjdBp5bBI+RfGeCBhNyhPwYQc7a4DKSYDwi+KqouJsYYTVjkSAyb4g2fgJTZiCONYWVC987kk+6tDtesR04YEZy76TFrEZzRxjkmHChL97zxqf+m0pbwUEjG9PrbKUVU0aG1FxgOWslAmC3kR91qa5S0NL9IJ+7/5gfaVXXit4oxMps5ieGQHSw1XeX+6XikIi1OZKW0uGHXhptO3j/+WMc8wjRQnE2C3dvOrt3rY3u3x765IcWXM8S6Bp3NLctRmFx5ejxsuWR+0i1CLjydVh9UekDNSVeq5WwnO5Pj3LVawWg+FqdG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fT94xM0TKO3gd9ZZ3q7aivurKbc8XGJsKe7j+4R+HpA=;
 b=cx7c3inVpRp3+x/Hn3+nYOk4Y+lN3NQ2KT3hmuIi5xVoH0JYO+PMxSVdLCGGgl13L/nrXO9ONaIkgj8EV6epj0xrldmEHqN3rEK3RkB8dcrHyA1T8V5FgjDTvH8bxNwCtguV9sqFpXyf6nfr5HGdGM4sUcuS1g9b1K/0Fs1f/KHieqfkmXgjAwyaUEASeoTqcWn5rrDX5ddtwxHQtsn8TAI6WJfBzA6gMGvCG6V+OBZ5gB0Pvv7fO1h6rPPXnNgnrtsHqEnBTu5Mkyru/H3nnOA7T37yibN6TgWorAMavOayt1Khz8nHJCrz0MAnEcNSruh6JIUQWFKel7J6d5zpBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fT94xM0TKO3gd9ZZ3q7aivurKbc8XGJsKe7j+4R+HpA=;
 b=oGNhIhBdI9H24RCHZBNo2wePCFI0uij4mrjDADPuYdu+KckcXf6f0d+4UUbc9gz0QUf7dE9fRCX02xnMN3ik8U7A94qcFVOTGYD+vvLVYCgjrBeD/mX8agJUv6llyiESFq12e+X5LY+LyjYIcVh79VIjnCBa33BfKBDdNjUNvYU=
Received: from MW4PR02CA0022.namprd02.prod.outlook.com (2603:10b6:303:16d::15)
 by MW4PR19MB5493.namprd19.prod.outlook.com (2603:10b6:303:18e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 07:58:06 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::3e) by MW4PR02CA0022.outlook.office365.com
 (2603:10b6:303:16d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.28 via Frontend Transport; Mon,
 1 Sep 2025 07:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Mon, 1 Sep 2025 07:58:04 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 864C9406543;
	Mon,  1 Sep 2025 07:58:03 +0000 (UTC)
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 72E9A820247;
	Mon,  1 Sep 2025 07:58:03 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: [PATCH] ASoC: SDCA: Add quirk for incorrect function types for 3 systems
Date: Mon,  1 Sep 2025 08:57:46 +0100
Message-ID: <20250901075755.2070983-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|MW4PR19MB5493:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9a026c0f-7535-441f-c849-08dde92d485a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|34020700016|36860700013|376014|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ipPA6DVrt0LvNTzXAEp2Tw2A7Bjtn/RkAHYfOJwyxSKciQL/9U4+wOIavnzn?=
 =?us-ascii?Q?bSy5DaVjfIzLr4cRl5GnXuJNvWPPizAreYUlyqJ5jECOZw7U20m1qmIF6FHf?=
 =?us-ascii?Q?DKKfccM5iwWeUtAD/535SfpEB3B71HktDfMKojM8/shuHfnwr8G584cHUO14?=
 =?us-ascii?Q?sLaP5YFIeNamR77gXcCIxF0kmejHx4uf9rhYl5mpn/8w7XQfXfHYrQIOQERa?=
 =?us-ascii?Q?VMMRnUcOIe65i3t+TrUI9Tew/Y5ExTrTXJe7GQIe6u3EAXulU68ETy/PRpun?=
 =?us-ascii?Q?4m5x+l2pJOR7aVCXzFU6G1sL7tOwxJmnKqZ9s0nm7G1nC0z1l7YwzTrZ05VC?=
 =?us-ascii?Q?Xe1bvi+ZUpoGSpUhgnneqfiWJAE9LHg2HUpzzVMBGhLPKejJ5jm/6ETsq9lP?=
 =?us-ascii?Q?LbI/bn4fk2RhEa6+qIIYOUjPqZPuqw/ytL+bJ7whHREnc+2+88wCMpj1k0nq?=
 =?us-ascii?Q?iWkM0cSVq4cK2rKAZotWNM6vW3DN4plQDIKdZCw9Z3KFJlmEVXXxnsN5zyZ6?=
 =?us-ascii?Q?3tzo6M/eIh2+9LN1P5seJywp6ydXTdaFt83xtQyWUR30nrJpxxOQ2gl9Vdhv?=
 =?us-ascii?Q?0+ZrzySzL/G+pVAreFlmXnPswK15flEK53dKhBArh9DeB5QulOXWZ5+HTSJn?=
 =?us-ascii?Q?zAWWyiclbm57oogxZMpGKAJS2srZyVm2a7/0dXgahKRUlCtW8w4LwxjqxmPY?=
 =?us-ascii?Q?HCDLctRms6OjueG8DghZqQfnqdgMvo2KX5r3VyRK1pCH0lFy3EhMOUPCDNm9?=
 =?us-ascii?Q?HbtpclyS4WExbmJ0l9wnGQXsCaBYAHZ1BaAc1D3noCV3G1Z10Qe+qgIaSKYR?=
 =?us-ascii?Q?Myj3SzFEkfOiYUMSkNrcK1Hb0k81MHo0BVKlc9Gk2N04iG+Uy4M/2iwx4sMk?=
 =?us-ascii?Q?c38wOWWg8Iz2C1SsCXNq/LcnXIDurN5B+/mSu7IDz9/AG6YGL6WOCgDDw/K3?=
 =?us-ascii?Q?4vPfHP3tk0uD5V2+UWXd+A35s2P5KVQ9DYmx9qjm68JZlVIdYAV+yvSO+6f0?=
 =?us-ascii?Q?2P0ALabRTUC9dkP3lAbxkr0lrmY7sdd8PTsjthoMCTm9AZ8yA5vG37mX3C8O?=
 =?us-ascii?Q?KmaIEaMv/R9uqNU5K8sBb+2ftSwUlCDiB6103g7p/m+0hQ/AKc2XVcBrGcu1?=
 =?us-ascii?Q?W4i9WsA9DXAkwb7Ui6jZCbSILMhSdyyPAOQoS3Cbwi9CMOUu8aO/hkUaQOsj?=
 =?us-ascii?Q?Rv2+8uzvuD5KRy/v/njWEfZ4ohQLOXqFcoj1WgZrAvCgWUjQqSmbC51lLFEz?=
 =?us-ascii?Q?Ioomi9gZf+xXcv/Xw/zGrqvNOlFWxv6hrwo5+NXJAUVx4SUSVv13blEQzDmN?=
 =?us-ascii?Q?MHsKdZW39+dW+e/L8ijnqUMVmaS48FvvQbPheujS+bf/PH1G6FLbPZGbl66V?=
 =?us-ascii?Q?N7FwXNrjvQ7+/9IsdTLqS0nX4GoG7rsnAhv/YZJLIpLImuliTJjuDRXQnwkr?=
 =?us-ascii?Q?ne9eCJJ5rkP0WhfYhww3L4IIN+rGtLiHtIB9BpUsFHqpsqQrz2Kd+lZvwz3H?=
 =?us-ascii?Q?GwM8IK2n+csJPktF9SB/3bOCfZGgrTq3/o8Z?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(34020700016)(36860700013)(376014)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 07:58:04.9907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a026c0f-7535-441f-c849-08dde92d485a
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB5493
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDA4MyBTYWx0ZWRfX4IgGA2WSwOMr
 e65vu3hr+/y/4zQuQZo5hipgrk0LG1986tbN73Y6112NFNBSeFPRcG0FY6NMn2EhRoPe09tSUEF
 uEo+1cXIZLWIj4XK12RUGa+e8Q9pQDT8P0Ozv8Waj/qN7dEUhXe/XNQd0ieYL/lNdLOPjDknmy7
 5F1AETBh109XvkAE478Mx5FhQZZxSL7e6rU0O4UM3DVAs7EwYK9OhdqqhVu/kcmG7Ts6lbXvqyd
 fa20QoH2+vKTe3qBqHytDqQAIjUszfPYdVyWMvJJDtI8Vxj5SpI9Agfvi9WVYSnaBoEA0nYNPpg
 aCkeFv3J4tFvdVskVJWd+3iKKfD0NCdVQFX6zBA1wH94PjJcR6URdsG/YdBcCs=
X-Proofpoint-ORIG-GUID: Qk3KIbQzZ1UKL0nUqIqD68iETHlArKcz
X-Proofpoint-GUID: Qk3KIbQzZ1UKL0nUqIqD68iETHlArKcz
X-Authority-Analysis: v=2.4 cv=O/85vA9W c=1 sm=1 tr=0 ts=68b55218 cx=c_pps
 a=mzzhM2yiSHVbR8Wpub5gQw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=Q1flO4m3JuMZ2y0tUaUA:9 a=jZz-an6Pvt0H8_Yc_ROU:22
X-Proofpoint-Spam-Reason: safe

Certain systems have CS42L43 DisCo that claims to conform to version 0.6.28
but uses the function types from the 1.0 spec. Add a quirk as a workaround.

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
 include/sound/sdca.h            |  1 +
 sound/soc/sdca/sdca_device.c    | 20 ++++++++++++++++++++
 sound/soc/sdca/sdca_functions.c | 13 ++++++++-----
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/include/sound/sdca.h b/include/sound/sdca.h
index 5a5d6de78d728..9c6a351c9d474 100644
--- a/include/sound/sdca.h
+++ b/include/sound/sdca.h
@@ -46,6 +46,7 @@ struct sdca_device_data {

 enum sdca_quirk {
 	SDCA_QUIRKS_RT712_VB,
+	SDCA_QUIRKS_SKIP_FUNC_TYPE_PATCHING,
 };

 #if IS_ENABLED(CONFIG_ACPI) && IS_ENABLED(CONFIG_SND_SOC_SDCA)
diff --git a/sound/soc/sdca/sdca_device.c b/sound/soc/sdca/sdca_device.c
index 0244cdcdd109a..4798ce2c8f0b4 100644
--- a/sound/soc/sdca/sdca_device.c
+++ b/sound/soc/sdca/sdca_device.c
@@ -7,6 +7,7 @@
  */

 #include <linux/acpi.h>
+#include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/soundwire/sdw.h>
@@ -55,11 +56,30 @@ static bool sdca_device_quirk_rt712_vb(struct sdw_slave *slave)
 	return false;
 }

+static bool sdca_device_quirk_skip_func_type_patching(struct sdw_slave *slave)
+{
+	const char *vendor, *sku;
+
+	vendor = dmi_get_system_info(DMI_SYS_VENDOR);
+	sku = dmi_get_system_info(DMI_PRODUCT_SKU);
+
+	if (vendor && sku &&
+	    !strcmp(vendor, "Dell Inc.") &&
+	    (!strcmp(sku, "0C62") || !strcmp(sku, "0C63") || !strcmp(sku, "0C6B")) &&
+	    slave->sdca_data.interface_revision == 0x061c &&
+	    slave->id.mfg_id == 0x01fa && slave->id.part_id == 0x4243)
+		return true;
+
+	return false;
+}
+
 bool sdca_device_quirk_match(struct sdw_slave *slave, enum sdca_quirk quirk)
 {
 	switch (quirk) {
 	case SDCA_QUIRKS_RT712_VB:
 		return sdca_device_quirk_rt712_vb(slave);
+	case SDCA_QUIRKS_SKIP_FUNC_TYPE_PATCHING:
+		return sdca_device_quirk_skip_func_type_patching(slave);
 	default:
 		break;
 	}
diff --git a/sound/soc/sdca/sdca_functions.c b/sound/soc/sdca/sdca_functions.c
index f26f597dca9e9..13f68f7b6dd6a 100644
--- a/sound/soc/sdca/sdca_functions.c
+++ b/sound/soc/sdca/sdca_functions.c
@@ -90,6 +90,7 @@ static int find_sdca_function(struct acpi_device *adev, void *data)
 {
 	struct fwnode_handle *function_node = acpi_fwnode_handle(adev);
 	struct sdca_device_data *sdca_data = data;
+	struct sdw_slave *slave = container_of(sdca_data, struct sdw_slave, sdca_data);
 	struct device *dev = &adev->dev;
 	struct fwnode_handle *control5; /* used to identify function type */
 	const char *function_name;
@@ -137,11 +138,13 @@ static int find_sdca_function(struct acpi_device *adev, void *data)
 		return ret;
 	}

-	ret = patch_sdca_function_type(sdca_data->interface_revision, &function_type);
-	if (ret < 0) {
-		dev_err(dev, "SDCA version %#x invalid function type %d\n",
-			sdca_data->interface_revision, function_type);
-		return ret;
+	if (!sdca_device_quirk_match(slave, SDCA_QUIRKS_SKIP_FUNC_TYPE_PATCHING)) {
+		ret = patch_sdca_function_type(sdca_data->interface_revision, &function_type);
+		if (ret < 0) {
+			dev_err(dev, "SDCA version %#x invalid function type %d\n",
+				sdca_data->interface_revision, function_type);
+			return ret;
+		}
 	}

 	function_name = get_sdca_function_name(function_type);
--
2.47.2


