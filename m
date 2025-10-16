Return-Path: <linux-kernel+bounces-856416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB888BE41FA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 765E55070E3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B19343D91;
	Thu, 16 Oct 2025 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="A6CXVdgH";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="L1CjYYFm"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409AC2E54BF;
	Thu, 16 Oct 2025 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627233; cv=fail; b=KfSOrO+wk/WbNI9/YZa7pO+l/fY+59n7c13KWkZ6nRrcqNMSWQicw/SqOawMnN7Nt4O/w+uVc4JO5UWLESSNSg6g2wgm0Oy/s19djsbw1Z4TGqSHh+OEN+eGnhYHNriTpxpL00iVN0NQh8PIMNaSafHoqB4Ce+H83IrLaMQeWVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627233; c=relaxed/simple;
	bh=IqrwFFO4vqURFCvTwDDSIQqUipqVlegE3LUKUcJLZ1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PgWccdNBCdOOEDJE0kznPE/eON1sdOL+sIb1NTPHqcGoVDQl9zLrR7IAqoyhwOwza0e7Abco2i2XdMgb5vGpNn+34P+561BWFrSTfeXWisc9RLXSzB0Oxhl8CA14dRcPp+pHvwnB6xou05D8fSfiJsxWI/Z+F/ni30yg3KjwdX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=A6CXVdgH; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=L1CjYYFm; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GDTFLA4017904;
	Thu, 16 Oct 2025 10:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=0aitLASn3XhNnvIaOSF5VhaA4/Z1y2m10m9UOvCOLjE=; b=
	A6CXVdgHL+3BnxoOwKr3c5uNKDbLkKM9Dx0/TBK+s60PGVTBL+QjgyG1gZAFG9Pg
	Csy/tkPnpvblVulj2fmoLKseu3W56dK/hB3mp01qK/qrN+W7kT+/3Wq6HWiWxJ6G
	Ns+Je8hH/xw5dup0Tx0ShHjUHrMk2z79JejPFJZwAxjBjpxR7TRMIOY0ysv0zYvT
	0mHBzWS+9MjfgEme27AxB5ULIHvOvhtekHjjzknR2l1+QqkMyGRaPbTWgCB/VHsM
	JDehAjsAPai9VTm8XOxT69RKuJ604Mxo9zLzeGr0lN9oSitO00PCLUiLIwb80oJ4
	cqSkojuSIh0arhcrEJsLpg==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022094.outbound.protection.outlook.com [40.107.209.94])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mng589-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 10:07:06 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEH9eghjHUg+kjvTp6kHKl2VKMIXooboNVxeEJLljyJ7QhwKfcngVsbAvIiPutLYZXNCJq3AzAX92t2SAaleyqy/v+nREpRUqvDw9tRsm0RFL0vy6vCFcGhI/moP9xrIKAK8cbr1uoHU+AxsQi2BmoibcaQmJ3sb4ZM+PlxiYOFRGFIYaTZl1MNbXeeaWDEPXIIocrcC95g+7UrCVTq8P2KV0hYQq9xsK3hGtknc6luXtryltUsJisA1ji9As9U3jTBaTG04lplZU8KWXgKM6CZY4OAQltABPM0dK50Hm2m3WnToNcUdHfClHFgVCyZMCqM0fBbtMcrhuWHuXzeKTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aitLASn3XhNnvIaOSF5VhaA4/Z1y2m10m9UOvCOLjE=;
 b=oIIU3JVpHKBDARl67UivY41eMVIXPHB0PIx65BZ+HrAjC36A566vlyGqXcwmV9QbUSVvJW4j+we/N6VJmJV3mP/Bl0oAmYh/uvms0mhFB7VeX9njuTjkP8514GWJiTCV0WnPtnTroMzUiN+blEiJ7fRR3DG0wtdfiECZxum2NL8uoWLbCf/2IV6ON9JHvVIjAt8Hz8yH1lN3ZOspHydJLUOv30nUEojSrm0IKt02yTjPHIjchis2xhmGbsdM6SWkox9hDSYL9G3UdgX/0b8BNHxXax7ix/j8gUlL8WYm7u0EoMMw5Pwz9OieCxgC9vipAmVOir/JsGtsXIZXNraIVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=amd.com smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aitLASn3XhNnvIaOSF5VhaA4/Z1y2m10m9UOvCOLjE=;
 b=L1CjYYFmyQv/6euZu/q4ZmHuVdmJm+vxheA1vUx7egabXQeQMkMNPm38QOS+qUkEt/Lwy+9SwtpgaqMBcGI/CcW8cm5GUkXmmSH8FqrghhlHeMwP+TE81gg9f4akAV5cNi/KDJaJQpLS9B7iNyEOiOwcwnFkqn9kVX5AS4KCFQI=
Received: from CH2PR18CA0049.namprd18.prod.outlook.com (2603:10b6:610:55::29)
 by DS2PR19MB9433.namprd19.prod.outlook.com (2603:10b6:8:2d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 15:07:02 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::71) by CH2PR18CA0049.outlook.office365.com
 (2603:10b6:610:55::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Thu,
 16 Oct 2025 15:07:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 15:07:02 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 28DAA406552;
	Thu, 16 Oct 2025 15:07:01 +0000 (UTC)
Received: from lonswws01.ad.cirrus.com (lonswws01.ad.cirrus.com [198.90.188.26])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id F2439820249;
	Thu, 16 Oct 2025 15:07:00 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, Vijendar.Mukunda@amd.com,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH 2/2] ASoC: amd: amd_sdw: Propagate the PCI subsystem Vendor and Device IDs
Date: Thu, 16 Oct 2025 15:06:49 +0000
Message-ID: <20251016150649.320277-3-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016150649.320277-1-simont@opensource.cirrus.com>
References: <20251016150649.320277-1-simont@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|DS2PR19MB9433:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ce5cb43c-28a1-4e14-ddb7-08de0cc5a95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zRtYETNwhLS/2lml+3oGGNoIJmT83YQ/nCEF1ksnVSfdQVoj7TfrILP5TJLK?=
 =?us-ascii?Q?/GBzOedkGko6ffnoTUTvsqaOjIWIsVrS5XaamuQxngeo1ChP7T1qObzcvHe0?=
 =?us-ascii?Q?/EAFQhz/IqmW8IPTae0XwK65cHl2Mp9FaVEqloEEOTAHvJ4OX/PRo54FgrMX?=
 =?us-ascii?Q?4T0z1yH7CvHoxU9zNzEw72Utarmdp9I7fmzgWtghbpE0uwDZ9AyFLNDfkRp5?=
 =?us-ascii?Q?MH8VfTewb4KAPm2SDehVKdfy7nNoGUAYHSzry5lLyAfK+rVynUkUbABgVTzB?=
 =?us-ascii?Q?/Yaq6mVU50Gu+qGQqSm3vnXBgNcDTTkEo0bSy8U0u/IO5uCl5H6PG58+orXo?=
 =?us-ascii?Q?Qtia8nSczKecnuDrdHUvExecHn/hhcIi/+IWeb4s1L5oosYsjTTsx7K08yIB?=
 =?us-ascii?Q?m4eU4hB0RgeXj09UGsEn3Jw8ZjUH4UqIPnj9+IoxP5pbPuMh+nf41sh9wL5S?=
 =?us-ascii?Q?UkzSLsYAvfr7F9C7tz54szkEbNS8bvDoR1sQhzUwSrLqA1hwPH8E22fyQpVK?=
 =?us-ascii?Q?27Lwt1mYYrkiwNgu9kXfgvrUF1SrJ3dPtGRH+aTiQSyqcOdRX+/HSB+4t2BT?=
 =?us-ascii?Q?AJALUK2jQzjnbaItainiXKHd4SiEdZQhJKNPq1pCzwPoguRHDGgEs3/A2UbQ?=
 =?us-ascii?Q?jp8RKSFsiIdpDV5Sjk3G9VU6BzIJytHgeFJtOf0bWpmNxe48Iu7zJ5/k/iBU?=
 =?us-ascii?Q?2OZAhiODADvd6xxuBrz+cJ5hPUkJM6ojCggN8kR13wA/kS2JZ1p0pmD4EwCY?=
 =?us-ascii?Q?lk7St5NcyeqXablxMilVlFNdayuVb2qURHeLisJ3hqllldGYmBApqkk5pLDf?=
 =?us-ascii?Q?kQk1LRTy1aRxBM95ajALPuiOX/EuLeWXm7Z2OTtNa4rrFv7pColDEU5fOF8n?=
 =?us-ascii?Q?B/U8ud+0PtEP0D75XTZ6xYd42LYBxUeFo8VG7DeMLWZkdDVjKdgdsquajzpo?=
 =?us-ascii?Q?kr/oEsC4g1du8Ksq3wXItLm8tDiX9IbUDEghqP4SWqhSAX1TlLhxbAboDL2Z?=
 =?us-ascii?Q?kD53lJnSkTWP0trWsFOqun6XeWEp+c6jWjwn7PNvU2SVQQOFg5wdWhjazfwf?=
 =?us-ascii?Q?GegZNs286YvSbn8xf+SeSOQI8pCDfI/52hC+Ea//jAxmR/Yah74WCj0I+qDF?=
 =?us-ascii?Q?RWj/fohLEueDzdVUFt8YgI33YEyz5xji8Rn4oFhb4SgYVoeJngbxWQ8NZ0X7?=
 =?us-ascii?Q?a4EGStPP5isl05R/DcTI5b4f+nDpnXugdMY+8/EgZy1M/Rd7wh/p8xD0cGzE?=
 =?us-ascii?Q?gzx0RoIQivlg8hZrEPdkniPB2nnUlcxQJTnb9bKkA3QNOB/lZQkapqjBeNwl?=
 =?us-ascii?Q?5bqc3pJZiGdVz9W9kT9kKL51mWx/1JyohgkV4yC0KlWXP4VHnEGDG2/XghFk?=
 =?us-ascii?Q?Lu//gAUHhX6gPRhCytDP6tdagvIvZQ3Xje4m9vvRsMRNwpw0jw9T0UsobgAd?=
 =?us-ascii?Q?X1FChO+d+23zYpSdrlyxeXyvLIGRmn6K+CVhX76FkvAaAS4dtjBaslhJ5z3w?=
 =?us-ascii?Q?Nbml8356jyL0zo9T5sjbapzKbLfu//03INmF6O4bMmnTtxk/YHm9wt7ZpBTz?=
 =?us-ascii?Q?al+gmbax9H4rr7fuv5E=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 15:07:02.0326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5cb43c-28a1-4e14-ddb7-08de0cc5a95b
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR19MB9433
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f10a1a cx=c_pps
 a=xEISQLFg+j67td7pU4ma9Q==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=qByZkzyfr5i96nhDVsYA:9
 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: Hyo4XriQI3IjH33H6Zf4MPVHH7CFWN_q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDExMCBTYWx0ZWRfX8MK6YcLg2gBv
 lFWBLxNfjPXOvPmfs4gjO4Z51kkS+Vw6U4xiPOcrfait+nj4dqxsyrq15t0I/RIckdx4puF1Xef
 8NS1r0ZNLJde5bU7+s2vEeb9yX93UFzVXTa3ADQm77h9vlujuvxQmpzKHMbMPClQF6VgTOeL6KZ
 E/ZNHFNJUKR3/Qb/7DbzHs0cAdJas+U68HOTbajd71MHr+Qlbm8Kr6VPbIjNeWeUQ+sb1+6670r
 YRutvRIpwTsQi50htrdzannsYqE+T95AOjTdyhdNos6ICpmLAUAIkmbGLpmVyRETLvzAt0mtYUv
 WtDfB/dRAr9pwyiwkJ8uGizxNOfZ6XR8JmMxWyS+5mK11M/Mo0gkUMjYXaXbnF5Ia5Tgr+A59Y4
 KhReCWs7vrRAiQ3oSwJE/6rCxLLWcQ==
X-Proofpoint-GUID: Hyo4XriQI3IjH33H6Zf4MPVHH7CFWN_q
X-Proofpoint-Spam-Reason: safe

Extend the ACP SoundWire legacy machine driver to propagate the PCI
subsystem Vendor and Device IDs so that they may be used by component
drivers for SKU specific variation.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/soc/amd/acp/acp-sdw-legacy-mach.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/amd/acp/acp-sdw-legacy-mach.c b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
index 5a3cfedacbaf..54f823f7cecf 100644
--- a/sound/soc/amd/acp/acp-sdw-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
@@ -463,6 +463,10 @@ static int mc_probe(struct platform_device *pdev)
 	card->late_probe = asoc_sdw_card_late_probe;
 
 	snd_soc_card_set_drvdata(card, ctx);
+	if (mach->mach_params.subsystem_id_set)
+		snd_soc_card_set_pci_ssid(card,
+					  mach->mach_params.subsystem_vendor,
+					  mach->mach_params.subsystem_device);
 
 	dmi_check_system(soc_sdw_quirk_table);
 
-- 
2.43.0


