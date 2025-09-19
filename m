Return-Path: <linux-kernel+bounces-824651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0870B89C82
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED32D1B24B41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15E630CB58;
	Fri, 19 Sep 2025 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="KMMc8Sg3";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="NWqcHnna"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A12D63F8;
	Fri, 19 Sep 2025 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758290568; cv=fail; b=JfFip2UDbyI2LgXUstNZ/6WXmiUfb26nmM0zx904NXY1lcIFbU5nQdLQHRjKJH6yiuICvhJBFYBVmdQPWDI/3YuX4sc/QQMwsr/9XddbrnNiVP95/757uFC5oppR5RXfUCgEDheEI4NiY5Tte+ZD29qxvlDsMqTeqo5ShUtArzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758290568; c=relaxed/simple;
	bh=ZJ4+RQnjliFzzjIJ84CD0+Gmlv7FS8uevkbL4hr0CbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dXerp4LvIrxy+OYcIvJv+b/NDInOsKFb/0UNtpaZ6Q9zXC4EwrMyXpDsEmUkwW9wFTLeKHNcyQs7VR7E+abTQ+bO9uuxTqgLox/Kx/3nmACFcgnl8Rx9ZQUCTVz5ldyTs6ERfvNJxqGRa+YgdIqnVtYraccUSFyGqnkszCe6TIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=KMMc8Sg3; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=NWqcHnna; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58JB7vdQ2719007;
	Fri, 19 Sep 2025 09:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=eIsAzDegODRO2uTJ
	bliYniuSekbW+9ah34oPBVSGn7M=; b=KMMc8Sg3nxaTx1xRxKU+eITmAC4skFn+
	Q4WjQ3TVPDRfsnqfHlN6/a1BiUi0S6VWUcIxkdAcTImC6+yYsRM/2IonZdMmsF2d
	dC6WPf6hqBBPbIs04M27mcKXv8iningxoSw2n9AwrhK0SFDUJzleNeMkvZiK8+Yp
	D4T0Sm17ymRK1cw89w4F+IKhmKTrL39AQ8m4mGVy1IdyOlHHem1PV+B6Bf1U5QAd
	fRetKbAunkWhTCVt7PFJKZYmywRY6rRlhrDIWw++mX2pDTR9fESzF5ikSyoRUxP0
	RF4PMiuiV6KA4w+xO8H+1mG0EwBWcBzv4DzvkAhLXS/VRjASdIC1pg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2130.outbound.protection.outlook.com [40.107.243.130])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 497fykv580-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 09:02:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVFwv7I/7xs6ZV4z1iC3NyeAQHH9F4IOlmTyKDOJTtZIHNVzkTj/FjroKsWnCbUbWDsaPDknbePPVD4bJ0Oft2/G6XgO71Qs6IkrEb7nyo6PzgCpDRrjvcIiBheSiBlMGOw7pia2KQUQ5FRslHKKPVwdlo08UdMj1rZ/puuCVehwH3Jf6ZsjgZmwHbXQNW1PXc5yVM/nw+2dubqRPK3OwFf/QZ46SZ+Uqb8FXgL1/A30afDQVbeeY+bnuD9OhjAhRMHA3IDNh8IV8HtJpJK9SXkul0d5YaBmFCOUhHFyP9vbAAaOYiF0qI3smlwmPT2uuuQqd2JjBKn9gKjNi543GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIsAzDegODRO2uTJbliYniuSekbW+9ah34oPBVSGn7M=;
 b=rHRQEXZvp6fVE4D81y1ZhrGn+RGZm3vsMd6V58SxCqFUgzckdnqsNBkY3WeKDgblteZHO6pzE1QEAcHXKLISX1t4XnOlA5yi6YI7KKGqtOq3Guduq5D+x/sQcJifmqaNjiJTI/FU66wnBN9h3NjcXn9Vv+HaPrnF9gNlqIRb2tJ/6UYBoAfAFu6bXyiYrNyuNnIqAqqna9Z+Juljb+DYb9G8SDnGsV5ye40mVkjHm8OmrQifDdgaO084HaNZe66OlE6sYORhwjbl6iM5pMx7GTCrCIo/yimQPHcZjlr13s5X9IZ9RiWWCaeBGMVvOC2fZAKTQ78Sx/Mrj14ETmSSnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIsAzDegODRO2uTJbliYniuSekbW+9ah34oPBVSGn7M=;
 b=NWqcHnnareZPYHh3547KzVVvb12Neyv5VYTBdNtYzNKbv5quzFUuMZcZ5jAkEzhTCNUdawZDAR7IRYXu79sQ8EJT4xRL3Xk35ZwMGyci2/YYVJr0jYeSeHkQ8YKWEYYZBa9uFyiF5QCbKtT0L7Zj+6Ji/vChXyNpSt7FtUJ+4sU=
Received: from BN9PR03CA0912.namprd03.prod.outlook.com (2603:10b6:408:107::17)
 by MW3PR19MB4171.namprd19.prod.outlook.com (2603:10b6:303:45::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 14:02:38 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::e4) by BN9PR03CA0912.outlook.office365.com
 (2603:10b6:408:107::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Fri,
 19 Sep 2025 14:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Fri, 19 Sep 2025 14:02:37 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 35FA2406547;
	Fri, 19 Sep 2025 14:02:36 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 26A34820247;
	Fri, 19 Sep 2025 14:02:36 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, yung-chuan.liao@linux.intel.com,
        peter.ujfalusi@linux.intel.com, kai.vehmanen@linux.intel.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH] ASoC: Intel: sof_sdw: Prevent jump to NULL add_sidecar callback
Date: Fri, 19 Sep 2025 15:02:35 +0100
Message-Id: <20250919140235.1071941-1-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|MW3PR19MB4171:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e2305f3a-c96f-4d82-fc52-08ddf7853087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?czHiiTNIMwtEW2vhATpjv933vFP0yxthJS70FYloedXzslp5EUolM4hIUFck?=
 =?us-ascii?Q?xPa5m8zhtI6GaOnPaOQuuZ5YABOhY628gsJRYkYsgMwwidpcvTdzp6h8jFiG?=
 =?us-ascii?Q?qtLB4hZ44M2rOhCIWJbY2aQK5f3l/jC7WZ3jQrHAmctS4sO53e2Ls7eocejW?=
 =?us-ascii?Q?YWpbDxWJuiyQQc072P3YqhrO60WPLlAIosqHCOh7IT1dIWcF/hFqA0bE/KYG?=
 =?us-ascii?Q?vJ9AF81J6SfXq/b2WNve0l3v3q9iSF8RY/QAXKeMCDSyHo1x858xotcF+Du1?=
 =?us-ascii?Q?ObqsDw+oMMCa3PHVnjUGYGDoZHLSlWVO9YJFRPnC5uukWe9DLzIgi7HbcPKH?=
 =?us-ascii?Q?vHIMqrcJfSamWmLpS/sQDjQxH68y+uAu4okdrIPcEcK5glsL1Y/zmehDHs8F?=
 =?us-ascii?Q?by74BC93vtjy4hxgqwXu2DLhCBF8VygEpjAZkf0KMqSSm9OO/k3ui9yvAzI6?=
 =?us-ascii?Q?pJ+2D5rbfmRXXbrEnzbk9pO2yEo4B8ByJ7buC/QFVEINrxXNHg94NHlC5yoD?=
 =?us-ascii?Q?cHhhWEyVeNi6jSlcvORb6MLV+N91Wwxr9pfcHGud0RPV1AUEhOhH8fA0guo1?=
 =?us-ascii?Q?+OmtK7KRZh4Q+OU8bit/t/ceSfSvZdk9lsOUQ2HbVm8sJryyqreSvBo+M4EL?=
 =?us-ascii?Q?2cDYMniZ4kbmX+hxja9AW90bdb+TMiIY1szin5DH6XREzC9TlxwRegPPUWqD?=
 =?us-ascii?Q?rSm68ZzisQx4okwEB8kD7taGjZ+np3yixg5BxgpedUw6FZeOoIjbm0tcirzh?=
 =?us-ascii?Q?u/UseJFZ7mcWvSoOgRd/G8Vdl+Xu4lM3i/03Dqp/cAVHzy8pzxMU5Nuu+3iT?=
 =?us-ascii?Q?E+MZFVtxXroG0vDwBWZWJIVqho7MfAc/tjwig0nyyXGbsYDALs23wuyzXqWB?=
 =?us-ascii?Q?cbuMGrZJ0nbs9QwxVkgE4FiBfSllpCN3NgmAFsbKGGkdR5IZXgCZ9JVDfTqS?=
 =?us-ascii?Q?JFuzr6LdwgtGUxi25PnusKLbBSnO1moW/NBREmWCBnHQI85lptwCQcnCExUx?=
 =?us-ascii?Q?d8MTCZCamLQJ3Vd4vPZFbUOgoDsp2EuC1l9xK1l0DOq4soNv1T5/xhgtH9QS?=
 =?us-ascii?Q?7A49mTYkelsbikpm3fS116Rf46J8EKGEkkfWvYqQIkTwfeB028kcA7ik3jwS?=
 =?us-ascii?Q?5ryLmQS30qz6cVaBvLbj+C/ldc6v8oBQp30PcjUH0UlHWDo41iMS6eFKqtp8?=
 =?us-ascii?Q?XYQShURmBRci6jXPSjN/879wxAW8aEEPGAv35tTiM3iOBEFhXV9fDulGZv5h?=
 =?us-ascii?Q?ZeyAUQAdmwzfW9s8Z/vBp11uwKCcq+5dERQhuNgYvOCpOYUpWRPDhIKHYBkq?=
 =?us-ascii?Q?54oQRF343Nrv/MqcVVVCGd8YISw1xUZ4Y5/EenLhVUSe4CCV54UqIQAkLnAe?=
 =?us-ascii?Q?G9fj/cYVsJL8aRIWNJFp8BJJy5CggVWUr2X6foYWRAINg2Qle3lVn0CFtB9m?=
 =?us-ascii?Q?pi9DANvGer9mKyoKThgKHyhwAS6idZWO6Dw+88sU4UlIMVVeXJio1XWOR1In?=
 =?us-ascii?Q?Y2yFfD2/JMacKZUz1wQUDq+9gMWh8ugXSIOd?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 14:02:37.1322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2305f3a-c96f-4d82-fc52-08ddf7853087
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR19MB4171
X-Proofpoint-GUID: pCdIRtgFCXxqThWANUm2IE4msyhAGIHS
X-Proofpoint-ORIG-GUID: pCdIRtgFCXxqThWANUm2IE4msyhAGIHS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDEzMSBTYWx0ZWRfX4ebSgf1jRCW7
 ecXmoYJYmHZCSV8sH20QmbB7RhqY5PB3RbD6k1tX+eBlgLU0dn36dpX2eUwcF2j7R9xcy1wp0We
 aHin43keJ9Wxbix+WKWR98QF1ovVCwRJSxhhfNV/jsbZaDyqPrhfEsXQWEsSAfScW3GxvDwNN4P
 I+0wwCjbXOxn2zP1YvFz4/e39mp9vTvLu1v6C5cx9f+Rxq0gdtZIpWiZZgPGzX3PM7aNyNyxcny
 YngyHgQjSXqvrgkB6+bYVLK5znfN6ABSMIcFEi5e9m4I2XSnrNOrMH8a8JJiTN8kZVJxbF5V/pe
 K13voABYBukNCoMVy54z/9bBQaCvG+O6Kn632oHjkb7kJtkp5VbyH0ARY6cx84=
X-Authority-Analysis: v=2.4 cv=KvRN2XWN c=1 sm=1 tr=0 ts=68cd6281 cx=c_pps
 a=AkQMgfLE9l6RAPU6jSJUeg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=q4X4NvG0OMMpVmH8aR0A:9
X-Proofpoint-Spam-Reason: safe

In create_sdw_dailink() check that sof_end->codec_info->add_sidecar
is not NULL before calling it.

The original code assumed that if include_sidecar is true, the codec
on that link has an add_sidecar callback. But there could be other
codecs on the same link that do not have an add_sidecar callback.

Fixes: da5244180281 ("ASoC: Intel: sof_sdw: Add callbacks to register sidecar devices")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/intel/boards/sof_sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 28f03a5f29f7..c013e31d098e 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -841,7 +841,7 @@ static int create_sdw_dailink(struct snd_soc_card *card,
 			(*codec_conf)++;
 		}
 
-		if (sof_end->include_sidecar) {
+		if (sof_end->include_sidecar && sof_end->codec_info->add_sidecar) {
 			ret = sof_end->codec_info->add_sidecar(card, dai_links, codec_conf);
 			if (ret)
 				return ret;
-- 
2.39.5


