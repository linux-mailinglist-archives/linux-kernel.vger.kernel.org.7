Return-Path: <linux-kernel+bounces-856641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA852BE4AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A919E1A62575
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22464343202;
	Thu, 16 Oct 2025 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Bu6RG757";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="hi4A4Vd4"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304482E2F04;
	Thu, 16 Oct 2025 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633357; cv=fail; b=Idq6DW4aY53HnECiU5Ad0bmO5hYZju2Q3FpqsgMXtDjokeScuTQJsq0iAXreUO8VT95a54jjRY+CMLMEWhgAcYf3WCKrBlOhcU/ZGilG4BMNyQI1q25119prOL2zDPIRnXm0GryM2rRsUkX4lRv5btNT8cATABCmtdcbj5bak88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633357; c=relaxed/simple;
	bh=V+mPpeH0+wG87aVEkvBSI3YjgqBRsVwdFkLpKUXR520=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBvXmzOTS0cZMPL7th2HHOc8jToVILQoRpvZnUGuWrTMlLgWiVdW2O3SQm8MRgOjw4/X3ubFeC1oEsvtRmst2N+IKErEoYMWCUjU+qg12c1sGCu3oBv79VtSqVN6gsYgGuXeFzkTASrLIeeCxRmcZ0/AXi+YKE44rk50fUKF8Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Bu6RG757; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=hi4A4Vd4; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GDTFSs4017904;
	Thu, 16 Oct 2025 11:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ElpuoXzvXliDRcAMVKqJ8c/WeTNHCYgy1BgcAAlmbiY=; b=
	Bu6RG757olHXZvZ8aZ5FT/DcSA3e1ECTMW2yP0ChIwyKPdi9UiAUQ9fmVQG461qx
	xAT+g54qg4zn/2SlLzuNVsSROCrB3v6r0wq16/3trZg5vHRPV0kQ/1YKOsjrCjzU
	Bs0oOEUDFVzrNSF8j8zVSK5pdsTnJSYEor8tBQGa8A6F7Hs3zNJRWVvQYFxPZmsG
	1zJOp8BXysJkmG1ypEsnEK0UNoXoRvnR7WCfTYIOaTlupnjlAehFFom6e2RxA/np
	LUT3jZrupZAUHi9S8BPQMRHfOMlsLH47mIAAPA3YnwjIztj+ZyNmZ01Eci9YD1aT
	1yezks00LFQA/Gkga9Qmnw==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022087.outbound.protection.outlook.com [52.101.48.87])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mngak0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:49:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z13qaYhDvIZtGx2kKoaxsYm8VJVBs9hv64IRjZYe+70JqpmX85LRwRHsbUue8TC0u6hNvxxurzGj7qIuP0RPnlYYOSeb43YHV3r8+qq0FzG2yO4bwyScudSbAmMivUahSQiuQK2RtIx1gVCTKMIQ0eIrEQCtyxvsX0F0vUZ7aTFcPW6OQR9nZBPWhJCanntrYGcBeHPVA1hGFEuO8UhMg4Lf7AMYkyVnNp5jPsEX94dr+5Wkpo1ClQOsOqCwD2wCjCHVyY3LbjXA8dR4XRewDVzs5UO48k+mKQIum9ftecVsw+5YBSvH78IyLKC9OWDmNK/GZya+PTi1j5MY/Ja19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElpuoXzvXliDRcAMVKqJ8c/WeTNHCYgy1BgcAAlmbiY=;
 b=iey0p3zZG2hRWAwtiP9aY8yb4loieFAFPmRt61gR0Y4yY1Z1TBD78p6f+BNPY4nh+ID5Qq3AxeHGXqekmiwreQQUW5yg1bEc3yTa7TJbfdtZCCcTJye3Z1k3IxpWIKPM4REn4+QTTDbCj7WC4eQHliGcFlVcaZvCwO+DO9T8PAyxUEV2rQzC4RHkTjH3G09g4SzrUHO1M7ehcVurlbpSEL7H1sW+IDp/u3nqZKt3JWs1wduwzWZZI7Cx4Cwjyzpv39tsWCghb88oj7gci82K51mS5UqSSZU7JteaZTBmeA4i2tEhZxV9s7C2Jn87fe6salrCk8Juv5DScnT2ONpRHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElpuoXzvXliDRcAMVKqJ8c/WeTNHCYgy1BgcAAlmbiY=;
 b=hi4A4Vd4SRZ3N87LTb/gr/psYSVYtjbNehyP9XGhl7UbyXYITvggQt3S6rRUbSVNnR9BLVXKty4QfDVrIj0QPGlJ/urQG6cGuQmY3XaKhVL/SsRQ4uBE4NxN0nnVxYOP9dJCfsLNTtnCE6j3ZsXIdEiHifCZQIV5AOyQLTnKwKM=
Received: from BN9PR03CA0418.namprd03.prod.outlook.com (2603:10b6:408:111::33)
 by DM4PR19MB5787.namprd19.prod.outlook.com (2603:10b6:8:64::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 16:49:04 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::1d) by BN9PR03CA0418.outlook.office365.com
 (2603:10b6:408:111::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 16:49:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:49:03 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id A0BF840654B;
	Thu, 16 Oct 2025 16:49:01 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 4498A820249;
	Thu, 16 Oct 2025 16:49:01 +0000 (UTC)
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
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v2 08/11] ASoC: cs530x: Correct MCLK reference frequency values
Date: Thu, 16 Oct 2025 17:48:26 +0100
Message-ID: <20251016164847.138826-9-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016164847.138826-1-vitalyr@opensource.cirrus.com>
References: <20251016164847.138826-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|DM4PR19MB5787:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fa07f587-c63d-41e5-02c6-08de0cd3ea07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?anTX8sbc/2IP+Dth38SIHMFlTiQqTi2KmE8zx19biXyLfXV0VLbnVTGkN6Zm?=
 =?us-ascii?Q?GCk8+UWzG2kaCzYPCJfglnBurti7IUb0ZTJVGAG96IcZUXEIUnVEAZ6+4JdF?=
 =?us-ascii?Q?0o929LlHc90cXTiFvffwtt6U8j1+R54JfJMLf3RyADaPQ3xLiRY9L7MUedh2?=
 =?us-ascii?Q?JDflc17kY9iPZU0JBjN/gaeILTL8wnW8EKjC14gJChXu83scklFT9OZOfU5x?=
 =?us-ascii?Q?fKVqNFeMBkmii14yU3ZyXNucXdk883rUdg+h7mNdkh25Lg6DUj6cOIK8EV5/?=
 =?us-ascii?Q?ceLs5ISSd54PjCBWSFCt6RojFB6SxwgwqBMzzMpFFOTPwWICwFBIlFGM3H2L?=
 =?us-ascii?Q?dHjLKzV955D2dDWwYIgzNvsBgh81q0zZc/13GW2aLl2xJZrgX2rSv13QlXZF?=
 =?us-ascii?Q?YxlaTmksVDKZqIWqqikfh4LR35oyvTobnNt2ID8cZUcGyqUDK2UVvp9FbMu3?=
 =?us-ascii?Q?r9x71ahe59ZEniesagKdqQiBnNBXudRorpPgsm5zthUjYooRmemCRfd4/2qa?=
 =?us-ascii?Q?NxjGIyy3mE5Z2rO2an4TXvqT1Vg/EMO3/4bAw92WU+XiP+VZICrJNR4mx0LQ?=
 =?us-ascii?Q?iB2wAeChKGSMF6JeU/S2BrMbXcvTVBQxfEkEUczU6yDK5jiPY9WxNWXU/+Nk?=
 =?us-ascii?Q?7fy0mLdUTZ/Ozfk8vH1qTXOJRQNCHzol8xs1BXNLiDX/agann04dAplg1uyP?=
 =?us-ascii?Q?loYsfH9jGf1cQ5a6mrD/PpoqavY9FQtVGrYQKnL5AVkkmV5qX0hm7Wlv/GNt?=
 =?us-ascii?Q?zGmqQHmw1mivqGN8lGscyiahP/kqkM0yTclvp0SqqrmejSuOwQdFmYwxm2uu?=
 =?us-ascii?Q?8fCUY5HKDadj5WbZnl4Ou0HZ5iuEoWS3y05b4gfNj9oTlRK0+LH0wSyjrwHW?=
 =?us-ascii?Q?w3cNzxZ6+sUCQE+OtGkFX3aAZaxFaE3HKpPAxUhLr1dXoPxCUrMHjPVMIBkO?=
 =?us-ascii?Q?MkZAG76H960RRuMS12buNfwRn/GW1EHqHA1aMuGUD8IgIgPocHMxZOReEFfu?=
 =?us-ascii?Q?4io8W84xMxvXlX5QzkfIKbn7UwqdX1Dma87IRxHKrVCJ5mkjCtgyLTzJAzRh?=
 =?us-ascii?Q?uE8C9/oa5DCT9GE9lKQtMiALKAX/lbG8vJm4YjDXpfYIj3MEGLS3+RuWttbk?=
 =?us-ascii?Q?BOM3Jvzn+WJEiLvZRFVMHw2vuGxiNHXESzXqBPIhBuhQ5BIuIXfaMqaC6ZeJ?=
 =?us-ascii?Q?PY3hPtZbrMAJgZkIOfUC8RxA1vzzktf98F3828kjOQf5UlWe6Jcvr2R10rxV?=
 =?us-ascii?Q?LjN4y/Llqp7ObU0iLnQ8RaB8pdfn7pqOt6aG2ytyZi8cWGoqKczkL0/sKBd6?=
 =?us-ascii?Q?qoNx4UuSOg0j9LfjappVy6u3OL0/R0Li/Q2BoX2pEK9Nm7vCOugs4cOILq6Y?=
 =?us-ascii?Q?TQ/dLn+GDP4X57FWXsQOGkioNX/behSVpJeYfhuYOLrCX/XlJ8FITCLuXfwf?=
 =?us-ascii?Q?NjjQym8yQQSSsQSIGU4l8/Ae5r36P0jDQcqkZWwksxV+l2cCAkwBZlxCvpk/?=
 =?us-ascii?Q?O3AtZ41Ng8Fg6WVSqbluBUXgN7h74wlC1d/Hfo2tRcrIdpCxdozawApKOHXO?=
 =?us-ascii?Q?+bo9A5EvFreICwHeTVQ=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:49:03.1375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa07f587-c63d-41e5-02c6-08de0cd3ea07
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB5787
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f12203 cx=c_pps
 a=uG80++rjBOzHqXi85Z+aBw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=_mdxinBoC9VrpwbbToMA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: gOoFzBEjjAikSG646Lf9bHtlBqhdxkmu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMSBTYWx0ZWRfXyypNaJCVoK06
 ChjK+750abRXIj6/0eBXGcQzMTR+RfmvPC1RBGG6i0xuaCOawbtsLf+5msSnJw/+OXyKkAKPnAr
 YHtdCcwdDeH5QFeMAHN40nz0C6D9LQQ7Qb7QWyqXXQDVRytauo+Q2f6N7sZRY/MEof/OcrMITpt
 4C58rvX2tZOf6X3NSV3GGepo+RoK0+H2qRnEVbV6RTASkPt1XTto/qjM97+3IOc7go8QHN2SL6z
 gkSx8GKJlGNy7bm4zEcgBIMCn3nD5SZXXArQdjzzaEuj1xDHVjTRdTmIrf4sk1zy5p6w4kPlYaz
 4jvutEHD4tiXO18Ox6BgYUhAgYi6bW2WV7a6z/t1e+iGjEbwnTGIppsikGEdRO6H5s04qImNrH3
 E5bRyd/D2AWxruF8x4eulfws1w1hzQ==
X-Proofpoint-GUID: gOoFzBEjjAikSG646Lf9bHtlBqhdxkmu
X-Proofpoint-Spam-Reason: safe

The MCLK frequency must be 49.152 MHz (for 48 kHz-related
sample rates) or 45.1584 MHz (for 44.1 kHz-related sample rates).

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c | 9 ++++++---
 sound/soc/codecs/cs530x.h | 6 ++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index cdd050c0fa2b..f0c3ed931fa8 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -1100,9 +1100,12 @@ static int cs530x_set_sysclk(struct snd_soc_component *component, int clk_id,
 
 	switch (source) {
 	case CS530X_SYSCLK_SRC_MCLK:
-		if (freq != 24560000 && freq != 22572000) {
-			dev_err(component->dev, "Invalid MCLK source rate %d\n",
-				freq);
+		switch (freq) {
+		case CS530X_SYSCLK_REF_45_1MHZ:
+		case CS530X_SYSCLK_REF_49_1MHZ:
+			break;
+		default:
+			dev_err(component->dev, "Invalid MCLK source rate %d\n", freq);
 			return -EINVAL;
 		}
 		break;
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index 758d9b1eb39d..c48a29cad702 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -174,6 +174,12 @@
 /* IN_VOL_CTL5 and OUT_VOL_CTL5 */
 #define CS530X_INOUT_VU			BIT(0)
 
+/* MCLK Reference Source Frequency */
+/* 41KHz related */
+#define CS530X_SYSCLK_REF_45_1MHZ	45158400
+/* 48KHz related */
+#define CS530X_SYSCLK_REF_49_1MHZ	49152000
+
 /* System Clock Source */
 #define CS530X_SYSCLK_SRC_MCLK		0
 #define CS530X_SYSCLK_SRC_PLL		1
-- 
2.43.0


