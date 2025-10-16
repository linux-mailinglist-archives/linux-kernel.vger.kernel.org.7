Return-Path: <linux-kernel+bounces-856017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD53BE2DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D3203508F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5080C3191B7;
	Thu, 16 Oct 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WbLtwi/D";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="D2xta79h"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3295F2D0C7D;
	Thu, 16 Oct 2025 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611377; cv=fail; b=FbMDhaS2zkHkW7QFFQj4KOhsVFM0O1ChK6UQinE2wiLvM/mOHmN5aOPhYGY9m/5xuCQHr/TS1JgFnjv6QbTvToUM6INyv0yR352Dcr48ID0XL60QcpPU4+dMdPYnaGgPGtcScDlXyX5uYv773NBCglazFHq9vwm30JxDfeoARaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611377; c=relaxed/simple;
	bh=Cgk9IY3u/WIJhEImYCl7n0SAzHAo1ogDATxJ4kvx4aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/KrxbWEoTReBxKvX1q6AX5734M4kW5VZQHlAq3qlGi/mK4NV1tjePKIb1gFq1qKmoRGNqn4y/fPzta2Lv6HpA6RU5u8AUofDa35FEatfwvAZ6x4ZPCBpjT2nV8HQxovJbHfOdmUpSdzuPtjpGFMt398oG/I/+wmX57LD+dU5Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=WbLtwi/D; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=D2xta79h; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59G8fDdC2477160;
	Thu, 16 Oct 2025 05:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=07aQvwIWOtN4aDdY5MQWVzSxBzrdKpz/FkcV+YgUI/8=; b=
	WbLtwi/DpqE83FFurVPpH7MoNTQmIgidLpVtcOkVLz6WPvldSIQ2Y2vZ5Aew/A4R
	uxP7Z7B7vVkKAFHcol6uDP7feLXrQwazCJpJ+lI21No09k9kL/7AnI6bqZwL1YoQ
	RhsT8nrxL0PNQkxvc5T7Vt7Lo6mlBcsVTjXANkYNGQwwq6ZmC+5GorZy87+1CvHZ
	XSfG6J9j+wRoN6mO+849P5hiZLGCtC1i0TAs79nkRGJndl81xKZYfSP/uCjmZ/W4
	8rM/DhYHYpao/lQ7dVFtI/dfYCT5n3Z8XFqx3WJHM4Q1dJPFCPNCAQQTcubacU4j
	zubNjaNG2UCJWUzQNCtB/w==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020099.outbound.protection.outlook.com [52.101.85.99])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhhpx1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 05:42:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZL543IwP4ayQnNiCcXAq5zkhZOXdzLmZjn0hJIyXt3Dp4SrEZ5DrnF+vQAeFiMPc3cT6cfE9bITlgnKNYc9MKNStGARTI4JxOLVH0k4alGQxcd6gxZ24ywxXpcqa2LxJurwMatuop5Nwr1Y6FxhVpBPE9wD5vHLYA6RXM8J9QDFy1FJJKYXxJI9Kpy3xm1acHPayniVbs/MemoTckOiJNXB+OFIg6P3brHOGAY5lMHMprmDfNxqVdL3NpjvKlM9AJmHPmQ+n+NSDDtx6SNlzBt+DYIEJKGxDfT1axglqAmsvrtORsY1P5wnA+qqWcjI5ei8Hm5WUpf226MH63LODGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07aQvwIWOtN4aDdY5MQWVzSxBzrdKpz/FkcV+YgUI/8=;
 b=M0aholpOMYOI+7wsiRn4c5FP8nmNwgjdsDA8Qu1JGOwt6pPbuwLbyI+bKcKjKaSEbNIWmqvwRxDFhzFqea1zqtDUcqkLX6hxjSUEtwEc+HjbqWu+hfo9kr6m6fOaWusmF7elMV1HT3bLSJhRHz0sEbpxGC98K9aBiD5v3E/ZX5hTrs9qYtBQgrEIfyDM93pYIc5tYPjEka98DoPj+26DWc8Nu6vOqxAxnV5EVhgDgveejGqced9sdybY3g0+on+aKPSYqwBWTCVm7ZRb3p/actLgMOFrWtb7+Qnfa5Q4LtHt9K7OMzSfHQBsRU6lzFarmvJ9Mm66CvhaxHzm0uKcTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07aQvwIWOtN4aDdY5MQWVzSxBzrdKpz/FkcV+YgUI/8=;
 b=D2xta79hm7egNlfpk+Xu+p6KKZ2/xRysubg7XWQKLrAEXPX7MvnHaqTH1E9iWKZoRGHUKrmABXwinoz1C/0eS8D/mxgppLsn7V/wf5qw1u1HIUx1AQIc/q2jL358coq1hMwTgkV+w/ZCm743yYirKmHtlc2q0Nr+v+HS58wUCvI=
Received: from MN2PR08CA0028.namprd08.prod.outlook.com (2603:10b6:208:239::33)
 by SA1PR19MB4992.namprd19.prod.outlook.com (2603:10b6:806:1ab::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 10:42:47 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::a9) by MN2PR08CA0028.outlook.office365.com
 (2603:10b6:208:239::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Thu,
 16 Oct 2025 10:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 10:42:45 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id F2D92406561;
	Thu, 16 Oct 2025 10:42:42 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id D41AB820249;
	Thu, 16 Oct 2025 10:42:42 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 07/11] ASoC: cs-amp-lib: Return attributes from cs_amp_get_efi_variable()
Date: Thu, 16 Oct 2025 11:42:38 +0100
Message-ID: <20251016104242.157325-8-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016104242.157325-1-rf@opensource.cirrus.com>
References: <20251016104242.157325-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|SA1PR19MB4992:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f038846d-1cef-40bc-bab1-08de0ca0be0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?89KYtlQ7+drrs7voaVRA/1NiSKsI3lIs2guHyXlcTvfXfwRAZXa51Uo1XiRY?=
 =?us-ascii?Q?POkdxYiBqxM362g9SlMClEUvX5rRFToHcVEIqTFGVcf61Cv2erpyh59Z7skp?=
 =?us-ascii?Q?QH8K9LT0rU7R6zjNYgibGedv7ouHOU4lk+DfPbXvqOXewIQCdFIXdsWdRc0S?=
 =?us-ascii?Q?m320kBbFuR2gtXkf+FY77umWZP/ERGMGWvRLbwNBb1YVyuNUWk/agC61M8pU?=
 =?us-ascii?Q?lzcBZ2KXY/0mdR4IOwez7bczcRWkz0A40sTo133YX6A7ceLEEd9fN8TLMrMC?=
 =?us-ascii?Q?3HIoN0aYO7CIZPGl+OpDFEOXHqDUjJerteGjXNbZuDe3mPESb52y6KO7WFJT?=
 =?us-ascii?Q?GqPQfSP2W2nMaPZ/1Rgkt2lWvG/SKmANssUZPKfS2M59UgJ6Xr9y+YIrtKqQ?=
 =?us-ascii?Q?kwWHJMEuiUbdqUDBTGnf/od4L3Uz5SUOa9LijYbvWAlJINhveP7bj9KT9IE6?=
 =?us-ascii?Q?CdGKuze3dPbUikSPvJa7Q51+X1BRo7jO864ihAgy23NJW6OFiI8Ui8alUQqk?=
 =?us-ascii?Q?PPzGWlk2aw/W9Chark07EXiaZpiHXN02V/CqFYvR+m5NScCxlgrO06U4FhTS?=
 =?us-ascii?Q?oN2jWVVQ9BnBg70FvVYnXaL9qS5XyydzNtyBPlqCOc2AqM5lQIvlEGr3HPnd?=
 =?us-ascii?Q?rrgC2Yo6cQUXT7+jZpylzWYJLa+B1ll7ZzGW57IapLdwKk993c0qTxRMROBw?=
 =?us-ascii?Q?QZR6cAJ8/pHYwIN09ci/5NDnBcgEbA/xFZauPXkOUOtUHdQiVs2/TvaxXcEg?=
 =?us-ascii?Q?JshmyCNpnn1oIKl8Ry/qhpxywVgT7AMSQH0w0PbQqWcgphndGd6KV2mcZQ3I?=
 =?us-ascii?Q?0hDbXU5bYVXgDXv4tXe0kp/0g/mQa3ZyFG4tADlHTPMigQTfo2/cfsAnQEEN?=
 =?us-ascii?Q?psMyd/UuL/X7jPLuYDwLmMBgUTbVsGDD/pyXBPaWrf94O7SIzRI1AhopYbKO?=
 =?us-ascii?Q?X61zaNg8D3UrPpkU8/Qy37CyEv2RKzc8ufWrfud+3f3RlAvWROjN9IVfpKDb?=
 =?us-ascii?Q?oZwhcmaZY5713OI0dhcTuUl3J8NkBletZ1wR6Ti6VRGODjEsasHzTzdb8fvh?=
 =?us-ascii?Q?zqAXv2Q9Hvfk0I0gyCaj0NAPE76Uqhk+vg6I/JSvasjfYfsbGeZzXnyVJdjz?=
 =?us-ascii?Q?mscLayRlA36yR8RMW/r3IT5j1UY71XjvaCp/phMipSBDMc2imEw+XtHisZ6E?=
 =?us-ascii?Q?OYTu2vhgfyfdLatdYDFDTRZ8/1NdG9xua7bptqQ2wG3ZUqR2LxZvQpD0p6Vj?=
 =?us-ascii?Q?4lM4VI3JnASV3upIgIxW3Ou1Zp8Qsaf7zyN6LY+ashn26bFExhp+IIT5grsX?=
 =?us-ascii?Q?ehPk5kDxnOEi0JpoUTh7pRDvmszC/lDqAQOrzYcKNo/IiWv+2gayHIoxz+/X?=
 =?us-ascii?Q?8ButH/lsvNQptgUp3t+eOqKwlwdTKttlrUqgDBivKaLV0Vg6Ac2B8ToBS3aq?=
 =?us-ascii?Q?spjjT9rtdOsb+Uf8Mbn/ZggeOq12V85vd/uz7rYVIAB06zwQYGgjeJxthOwm?=
 =?us-ascii?Q?s/6fLjIq2YmGjOYHavO0XB1mjuS3VIi6JwN19NAdezdBrMe4d7bCEV9niYzn?=
 =?us-ascii?Q?keWulqCbqm4YqgGi/8I=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(376014)(61400799027)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:42:45.3865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f038846d-1cef-40bc-bab1-08de0ca0be0b
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB4992
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA4MCBTYWx0ZWRfX1Tkzl2l2ucN6
 l29Vl/vy/fbEH4+sihTeXKz/4fY+muo5Hd0GSykcTjYpcZmCN5/wMmw7vIaaTPNk1nTOiKF2lKa
 Y5aJdCa+4TTVNEOH+UoGIK4ZwGhuTDmFlx21evBpsU9mUCvohO0/IfiyU4yMMvdsFwqXMmBjt+N
 UGzRdIUW4BLqoeiTEgTj3qNKnp2ZcQZFfF911vC0hrUxnam+pC+eqHZCAFE7uzUbw+dUZlFy8Ap
 CpaAnrBT53M/OAvQQSS0hYzIAQmobEGi7be3C+F1kLIwztVP17PyL4D1aysnlI2YcsmKqbsWbcQ
 N9NbuEb/l+yLbPXqRMI7cDbz4TyuDxE5rKkyzS8TkeJT5pGRelUWjE2TzX5OpnDKj4c+zWKJG2r
 ftMxUUtUSu4AUzBSJJ/HvRuN/ZYx/w==
X-Proofpoint-ORIG-GUID: rv6O3ek7NeHEgtjYFHZk1ll-hfWJxXl1
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f0cc2b cx=c_pps
 a=GGH+j3rhJf5zTl2H81NwCw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=w1d2syhTAAAA:8 a=BfivipjO2gqBdDjawAAA:9
X-Proofpoint-GUID: rv6O3ek7NeHEgtjYFHZk1ll-hfWJxXl1
X-Proofpoint-Spam-Reason: safe

Add a pointer argument to cs_amp_get_efi_variable() to optionally
return the EFI variable attributes.

Originally this function internally consumed the attributes from
efi.get_variable(). The calling code did not use the attributes
so this was a small simplification.

However, when writing to a pre-existing variable we would want to
pass the existing attributes to efi.set_variable(). This patch
deals with the change to return the attribute in preparation for
adding code to update the variable.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs-amp-lib.h         |  1 +
 sound/soc/codecs/cs-amp-lib-test.c | 23 +++++++++++++++++++++++
 sound/soc/codecs/cs-amp-lib.c      | 15 ++++++++++-----
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/sound/cs-amp-lib.h b/include/sound/cs-amp-lib.h
index 485daadd13a1..09c54b1bbe6c 100644
--- a/include/sound/cs-amp-lib.h
+++ b/include/sound/cs-amp-lib.h
@@ -65,6 +65,7 @@ static inline u64 cs_amp_cal_target_u64(const struct cirrus_amp_cal_data *data)
 struct cs_amp_test_hooks {
 	efi_status_t (*get_efi_variable)(efi_char16_t *name,
 					 efi_guid_t *guid,
+					 u32 *returned_attr,
 					 unsigned long *size,
 					 void *buf);
 
diff --git a/sound/soc/codecs/cs-amp-lib-test.c b/sound/soc/codecs/cs-amp-lib-test.c
index b19aaacd7f2b..d3419f48297e 100644
--- a/sound/soc/codecs/cs-amp-lib-test.c
+++ b/sound/soc/codecs/cs-amp-lib-test.c
@@ -90,6 +90,7 @@ static u64 cs_amp_lib_test_get_target_uid(struct kunit *test)
 /* Redirected get_efi_variable to simulate that the file is too short */
 static efi_status_t cs_amp_lib_test_get_efi_variable_nohead(efi_char16_t *name,
 							    efi_guid_t *guid,
+							    u32 *returned_attr,
 							    unsigned long *size,
 							    void *buf)
 {
@@ -122,6 +123,7 @@ static void cs_amp_lib_test_cal_data_too_short_test(struct kunit *test)
 /* Redirected get_efi_variable to simulate that the count is larger than the file */
 static efi_status_t cs_amp_lib_test_get_efi_variable_bad_count(efi_char16_t *name,
 							       efi_guid_t *guid,
+							       u32 *returned_attr,
 							       unsigned long *size,
 							       void *buf)
 {
@@ -165,6 +167,7 @@ static void cs_amp_lib_test_cal_count_too_big_test(struct kunit *test)
 /* Redirected get_efi_variable to simulate that the variable not found */
 static efi_status_t cs_amp_lib_test_get_efi_variable_none(efi_char16_t *name,
 							  efi_guid_t *guid,
+							  u32 *returned_attr,
 							  unsigned long *size,
 							  void *buf)
 {
@@ -192,6 +195,7 @@ static void cs_amp_lib_test_no_cal_data_test(struct kunit *test)
 /* Redirected get_efi_variable to simulate reading a cal data blob */
 static efi_status_t cs_amp_lib_test_get_efi_variable(efi_char16_t *name,
 						     efi_guid_t *guid,
+						     u32 *returned_attr,
 						     unsigned long *size,
 						     void *buf)
 {
@@ -218,11 +222,18 @@ static efi_status_t cs_amp_lib_test_get_efi_variable(efi_char16_t *name,
 
 	memcpy(buf, priv->cal_blob, priv->cal_blob->size);
 
+	if (returned_attr) {
+		*returned_attr = EFI_VARIABLE_NON_VOLATILE |
+				 EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				 EFI_VARIABLE_RUNTIME_ACCESS;
+	}
+
 	return EFI_SUCCESS;
 }
 
 static efi_status_t cs_amp_lib_test_get_hp_cal_efi_variable(efi_char16_t *name,
 							    efi_guid_t *guid,
+							    u32 *returned_attr,
 							    unsigned long *size,
 							    void *buf)
 {
@@ -249,6 +260,12 @@ static efi_status_t cs_amp_lib_test_get_hp_cal_efi_variable(efi_char16_t *name,
 
 	memcpy(buf, priv->cal_blob, priv->cal_blob->size);
 
+	if (returned_attr) {
+		*returned_attr = EFI_VARIABLE_NON_VOLATILE |
+				 EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				 EFI_VARIABLE_RUNTIME_ACCESS;
+	}
+
 	return EFI_SUCCESS;
 }
 
@@ -787,6 +804,7 @@ static void cs_amp_lib_test_spkid_lenovo_not_present(struct kunit *test)
 
 static efi_status_t cs_amp_lib_test_get_efi_variable_lenovo_d0(efi_char16_t *name,
 							       efi_guid_t *guid,
+							       u32 *returned_attr,
 							       unsigned long *size,
 							       void *buf)
 {
@@ -805,6 +823,7 @@ static efi_status_t cs_amp_lib_test_get_efi_variable_lenovo_d0(efi_char16_t *nam
 
 static efi_status_t cs_amp_lib_test_get_efi_variable_lenovo_d1(efi_char16_t *name,
 							       efi_guid_t *guid,
+							       u32 *returned_attr,
 							       unsigned long *size,
 							       void *buf)
 {
@@ -823,6 +842,7 @@ static efi_status_t cs_amp_lib_test_get_efi_variable_lenovo_d1(efi_char16_t *nam
 
 static efi_status_t cs_amp_lib_test_get_efi_variable_lenovo_00(efi_char16_t *name,
 							       efi_guid_t *guid,
+							       u32 *returned_attr,
 							       unsigned long *size,
 							       void *buf)
 {
@@ -874,6 +894,7 @@ static void cs_amp_lib_test_spkid_lenovo_illegal(struct kunit *test)
 
 static efi_status_t cs_amp_lib_test_get_efi_variable_buf_too_small(efi_char16_t *name,
 								   efi_guid_t *guid,
+								   u32 *returned_attr,
 								   unsigned long *size,
 								   void *buf)
 {
@@ -894,6 +915,7 @@ static void cs_amp_lib_test_spkid_lenovo_oversize(struct kunit *test)
 
 static efi_status_t cs_amp_lib_test_get_efi_variable_hp_30(efi_char16_t *name,
 							   efi_guid_t *guid,
+							   u32 *returned_attr,
 							   unsigned long *size,
 							   void *buf)
 {
@@ -912,6 +934,7 @@ static efi_status_t cs_amp_lib_test_get_efi_variable_hp_30(efi_char16_t *name,
 
 static efi_status_t cs_amp_lib_test_get_efi_variable_hp_31(efi_char16_t *name,
 							   efi_guid_t *guid,
+							   u32 *returned_attr,
 							   unsigned long *size,
 							   void *buf)
 {
diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index d510e0e065ca..2630ea6a8f3a 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -244,15 +244,20 @@ EXPORT_SYMBOL_NS_GPL(cs_amp_write_ambient_temp, "SND_SOC_CS_AMP_LIB");
 
 static efi_status_t cs_amp_get_efi_variable(efi_char16_t *name,
 					    efi_guid_t *guid,
+					    u32 *returned_attr,
 					    unsigned long *size,
 					    void *buf)
 {
 	u32 attr;
 
-	KUNIT_STATIC_STUB_REDIRECT(cs_amp_get_efi_variable, name, guid, size, buf);
+	if (!returned_attr)
+		returned_attr = &attr;
+
+	KUNIT_STATIC_STUB_REDIRECT(cs_amp_get_efi_variable, name, guid,
+				   returned_attr, size, buf);
 
 	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
-		return efi.get_variable(name, guid, &attr, size, buf);
+		return efi.get_variable(name, guid, returned_attr, size, buf);
 
 	return EFI_NOT_FOUND;
 }
@@ -287,7 +292,7 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 	for (i = 0; i < ARRAY_SIZE(cs_amp_lib_cal_efivars); i++) {
 		status = cs_amp_get_efi_variable(cs_amp_lib_cal_efivars[i].name,
 						 cs_amp_lib_cal_efivars[i].guid,
-						 &data_size, NULL);
+						 NULL, &data_size, NULL);
 		if (status == EFI_BUFFER_TOO_SMALL)
 			break;
 	}
@@ -307,7 +312,7 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 
 	status = cs_amp_get_efi_variable(cs_amp_lib_cal_efivars[i].name,
 					 cs_amp_lib_cal_efivars[i].guid,
-					 &data_size, data);
+					 NULL, &data_size, data);
 	if (status != EFI_SUCCESS) {
 		ret = -EINVAL;
 		goto err;
@@ -451,7 +456,7 @@ static int cs_amp_get_efi_byte_spkid(struct device *dev, const struct cs_amp_spk
 	int i, ret;
 
 	size = sizeof(spkid);
-	status = cs_amp_get_efi_variable(info->name, info->guid, &size, &spkid);
+	status = cs_amp_get_efi_variable(info->name, info->guid, NULL, &size, &spkid);
 	ret = cs_amp_convert_efi_status(status);
 	if (ret < 0)
 		return ret;
-- 
2.47.3


