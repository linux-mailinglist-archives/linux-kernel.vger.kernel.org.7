Return-Path: <linux-kernel+bounces-855855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F14BE27F8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C37248292A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD512D5C9E;
	Thu, 16 Oct 2025 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jL/upKJr";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="yzYITi7Y"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B396127B32B;
	Thu, 16 Oct 2025 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608147; cv=fail; b=C26wVtN53KqTmvft58B64okcA62FVJWpwMya6ZvpuEJmD3UZom+vgygtDoywsOClJzE69dKoINgLilMwsKHM2WLegc1bijgvRXm9avbFF9cH+v+M1s1eGRXUVZfF6HCWoOQoYMlv0Rwr0k72Cxdn3NBFC2vF4B7dQVw74Kw8sJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608147; c=relaxed/simple;
	bh=paRS1iPtTebKE7Yr10XlLhkl6Iu4E/Ax1fIpP+N+sjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WF7E377RS/ubA/k7wuscn7h4jts4SKpqXPins1+L0ivP3VA19WudxWNONx0TIBXkR0pR3okGMNKpVtzkLiGFHTtfwuGPDCBHyr/1e6V3FeKWh97IcYwcSubFxn4+U1VwL9qXKe4BiSL9T3/CwifaKk6XZSy6RL7cqSXPpFNtzfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=jL/upKJr; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=yzYITi7Y; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59FN6m1W298627;
	Thu, 16 Oct 2025 04:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=+waaRa7bBZFzb5p4
	hb+mxaMIxMNJhC7YjaizblBK3B8=; b=jL/upKJrbbmv+bp8no/ms1uMzeeykrXD
	mvSd5kdobgi8TDCVW5utCIJoDvxemF7pRpnBOF3HtHDnBP0+ML2Js0xjshHP2cQy
	pRjVgGZ7gtZhiQTTm6YSqSMppWmk3/yAo44MK6fU9+gqTqduNGxruFNnNqHi6Smh
	VK4+UYDrT+O/BGEJznD6UqHIYNmEUk1HHChh/YhHZUbaVF0VrIKIMGp2DdHT5CRR
	EafJtce7ucN1DP5EoLOpYX0G7qD7LziHSCAHUeSr6oIG5pfsRdcZK4dEFt5NDBWo
	QtR3TD0muy3aw/sIYvyYvR/HQjH0jGVTv+PFyIgOhykt4wRIEZrk0Q==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022094.outbound.protection.outlook.com [52.101.48.94])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhhmyj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 04:48:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csQrKqgoc3toYY8iy6GD5sTc6nYy6XAOzQub/PtmT/6ejw9EqclImaZ5Aw6hlLzM8LnMVwnB0lBHq2yE2dhwd1onuyTN+NMGTmSrDuB/GHQlrF7sK3DmsUGQGpoFardRIz3N+rTMnSMJ+/4aDHLgQTWFf9EZ1iMlCeW20rC3cqEfZ014jUy2dzf1J1Blt8QVHxBH+y2McP0KVJ2XPVYFO0luh0r/i6XB0VTiuEJ17zTFmKFDOg1bRo87cp/a4dMPnPhqg+tVoYHdkHIJpMeM2JyXWTyTiQCmt+NX9hCDl75mnzkBQG9F4EktLiC/5g5aWmyvvlqqJubpyhXTTnxT9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+waaRa7bBZFzb5p4hb+mxaMIxMNJhC7YjaizblBK3B8=;
 b=Z667GOmX4flAWqjCSOpyLDgMzO0MoJpawwzDyIO+m4Y6YFaFtWuL3PwDQSjGuNKQCwyr286t9kC9wrzNTv/K6bD6P5YFTpBC1wWB2ENXJNTyCs8v1vzc/OdelcJWYZ6MRHDP+6cZ7ouDGOL57HloxfXhi+MVF/2TC1WZuBMaXJqalLVS80XI7XLpl20kLqH39NPJtCF6BDOOgUJt78DZxw6xRCUqzEqmUhd+A8iFIYUTwEfC3gocu3qnVCktPxNKYqoIr3CASswjGah1CVNIEe98KcI9pJn1Dbm5l9qCBpD/ALya7isjj5KLGdv67eqrhmYzgafzwVsZdeR7jgdllA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+waaRa7bBZFzb5p4hb+mxaMIxMNJhC7YjaizblBK3B8=;
 b=yzYITi7YKLird1dZQj4c9besIn1E/ZsX3HT/jOI3Xl44us/p4ZH4lhCiOP4w4N4qZ4hJd1O2YIJhmfD6MdxuXdzp7a5HO+HxIkY3pjcxkAuEmFDreRLrvTia+g2ux3zoeojhm4zkTaULyZUeWMe+TIz7/PLA1lkdubrzZFWen3o=
Received: from SJ0PR03CA0341.namprd03.prod.outlook.com (2603:10b6:a03:39c::16)
 by PH7PR19MB6806.namprd19.prod.outlook.com (2603:10b6:510:1b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 09:48:47 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::2d) by SJ0PR03CA0341.outlook.office365.com
 (2603:10b6:a03:39c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Thu,
 16 Oct 2025 09:48:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 09:48:46 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id F3606406547;
	Thu, 16 Oct 2025 09:48:44 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id D0EDB820249;
	Thu, 16 Oct 2025 09:48:44 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH] ASoC: cs-amp-lib-test: Fix missing include of kunit/test-bug.h
Date: Thu, 16 Oct 2025 10:48:44 +0100
Message-ID: <20251016094844.92796-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|PH7PR19MB6806:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e049527b-b9dd-415f-b999-08de0c9933de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mFjgVQGKMiPu9hh+l7k/mucbQGSF+IS5nWkikuBV9MbYC35ymqBOryJAn+JS?=
 =?us-ascii?Q?HSDdBMldpuPLNb1lYmdHBbAdkan/u0RiPbnQuCliSD/5RWTTh2Yrnrj/jVLr?=
 =?us-ascii?Q?nbIyOoYrRpczOYWylxK5UWHRanDfisu2Q71V0i5IFAkUbis6oxc6fTSOEEqh?=
 =?us-ascii?Q?GlgbiiZgIC+gZvByHE2sQQnn3pLVL5A2ooF6sPzuEzMeHBBwG97NaOd/CJk3?=
 =?us-ascii?Q?klUaA8DS6dKagTo5q3jSgyoSIV2+VBqwAuvGlpvT6mnwNxAh9E1Uy5+I4i+B?=
 =?us-ascii?Q?PSXFtReLVa0S0nT3NAsiy5YO8bo+VkAKmhjfmHxwnBGegXfFyMxZiOdeabED?=
 =?us-ascii?Q?NZgM03xBdHafRqEXRIBE5WJUa+DAt1yEfBN+UV1JrIiRXJ7dAYE8cDbWecPn?=
 =?us-ascii?Q?azfTVDhf+YJFLMtHgHePFOF6/mCGzrLPSrxpkQ5voGWnMlKiS6alRgXkGFv4?=
 =?us-ascii?Q?YDr32MR6+002iLjWSzu+/MEhi8ajKuwdObo3VbzKsjixT4AEoSzKQI2+c4Li?=
 =?us-ascii?Q?ASMfUnfuB4KatSbQltOl2u5S4pL6g7R7BLuROwfowWRdLEX/YvoMduDJdUWz?=
 =?us-ascii?Q?G9Lvjd7DVnFXh1E6TaEcmO1/P3drZPM+1k+93d9BF3Lq6bFPELVPctU8YYVw?=
 =?us-ascii?Q?ROTBsf7vw69knZsru7004p2iVemjt343ibQo+vU3OPrmjMLbyeDLMeDlhNX+?=
 =?us-ascii?Q?M6KzqzhKAgs0E1PPYFZpd1FajW6+kpcGnEzDI+O6ySrZf9ASNUw9Th6ZowQA?=
 =?us-ascii?Q?S/YX4KBYG5c6TmSbc8REq2UG1oAhrB0xNN9WF83XU0nj/vg5kReoof2vzIUH?=
 =?us-ascii?Q?CklmiBJgexgQ41TJhxaTJ3d5dyFtzAne2knxMxguRfQyJfTL8RATed4urgIm?=
 =?us-ascii?Q?xjWbNzILrFAPSFrMYGpTIYHIbjggWXwimsJhI7rxbcXamYlzCHgSlYLxcB21?=
 =?us-ascii?Q?4lc1a6MDEb5KsL2XJhJMtZxhBef0pBy7UmQeL31OnyB/DZnaxKHr406N1ca0?=
 =?us-ascii?Q?48Ry9L8vfswi+5cL2LH6wrYC1pO3p2Gs/OzmCTdx3NuaEk46Iwj0OM6AvpsE?=
 =?us-ascii?Q?AdOjPDpZRWz7VxUGcSdKPw0ujO/ZOtqV57yVFs8HIOTbjkdj7+geHnJH2SW+?=
 =?us-ascii?Q?m2Fxh80cjmfYSgpF/hTv6FgRASvitmANjM6J9uwnoz6wSBApi1rE8hYKhkji?=
 =?us-ascii?Q?Bw5q/dUDihWyL1IHpLOvo3BTcftSZyVRkLMVMm3ZcoGyC7jm5+M5NJEJOHem?=
 =?us-ascii?Q?+docXy1tPYG2mkryB3cGDLAJMyIbRVi8tHru2jKwFbnncK4Mq/8ruGgcN+TH?=
 =?us-ascii?Q?9fBPW0y4wnMCK+QOu7IvbzqBuozRUZSyTytjFnnzqIUqPRf7aQtBlAj3PiDs?=
 =?us-ascii?Q?iGs/8dZOx9vJzSTBl/lOusqKlnOWCSwj6fZiuxQKQFdt9VfphWZbUcjMdAnP?=
 =?us-ascii?Q?1zx5yaszfuSmLsLKvxdcXJ2R0UJzJenGLSggSPkBxPyJaVLK0kXsMu5p60iR?=
 =?us-ascii?Q?RCEjajk1cXTzUTboUpG632oX1c5oi/qLGliaTwK0u2iAtzcRCsogTOZC1p2Y?=
 =?us-ascii?Q?y2gQVWDyBtWDbh/Z+UU=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 09:48:46.9697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e049527b-b9dd-415f-b999-08de0c9933de
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6806
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA3NCBTYWx0ZWRfX/vY+NuXJpdNj
 sDaJdE0F/sBK/ZHEBrHWKb0OeVeKLXNfrs9VCF0cZh6kgqS8f7Bi9h3cxcfQ+rR/T97OJ8/NQqR
 2pax0tv8KFOke1bGd5MnxF2aN1y37x47dwyZ4NRqRpCYnl/tD7W1RY4+h+DeZijQMccEkYw37Xz
 GUc+4VoBiA8s+15IkqVZ5l2YYnizZgM7VfqBojHhHGEA9S83LBwAE5xCev0ykQFXnB3C5D9tvCV
 5ritIwkCxfXDeam04Z9Wii5d44IWXrWM8MO5+LqT51+E6i/TnqHanOPWBZ/TRL4MKIHVZZ0kZNI
 j2EaoX5O1J1SObv0w8YzD69Dk7E7rr70ZRnEHUAO6FB8HVV3dCxc67GdR1/8eql+hEk41H9Gs5L
 UVAO6+Gpr84qecRZSQQdK0teX/S4vA==
X-Proofpoint-ORIG-GUID: w44uzLwtn35cLiItrU8ie7w4KCBRWt1G
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f0bf83 cx=c_pps
 a=kWDUzu7Sg0boEHrzbzcNEA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=DBs-fRHfoGwBX52xYIkA:9
X-Proofpoint-GUID: w44uzLwtn35cLiItrU8ie7w4KCBRWt1G
X-Proofpoint-Spam-Reason: safe

cs-amp-lib-test uses functions from kunit/test-bug.h but wasn't
including it.

This error was found by smatch.

Fixes: 177862317a98 ("ASoC: cs-amp-lib: Add KUnit test for calibration helpers")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs-amp-lib-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs-amp-lib-test.c b/sound/soc/codecs/cs-amp-lib-test.c
index 2fde84309338..3406887cdfa2 100644
--- a/sound/soc/codecs/cs-amp-lib-test.c
+++ b/sound/soc/codecs/cs-amp-lib-test.c
@@ -7,6 +7,7 @@
 
 #include <kunit/resource.h>
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 #include <kunit/static_stub.h>
 #include <linux/device/faux.h>
 #include <linux/firmware/cirrus/cs_dsp.h>
-- 
2.47.3


