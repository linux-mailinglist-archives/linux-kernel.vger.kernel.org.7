Return-Path: <linux-kernel+bounces-862677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC64EBF5E37
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBED5460E93
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A10432E73F;
	Tue, 21 Oct 2025 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="TWm75BGz";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Ov+hRTLe"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828F932C959;
	Tue, 21 Oct 2025 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043840; cv=fail; b=PIPzGdw0dqvsrzy61M7kd6wei4XUSnnh5NgJsZjrRm8LRZyoQ37M3wecC7i2JVkFdysaXZarkiKQ1DtqZZOOdtJb7abM/3KtC7V3r53Pt2zA8SdUfm/rXmsfsgZWLDnAuHfqXxzBExgICaqQbZX9mlKOtKb6/YbRM7nj/u7TSTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043840; c=relaxed/simple;
	bh=IioPaLA4Pv5PWU+RDIN7pzpXTNVkSTRTfJ1O58qAjNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1LWGPmzmxj/d/rsWVPmOW7SJG6R1k6Lf+QCzJwuwzoU/UIE7vTb0fJD/Yw6nMUR+04Pd/zrP2Lxj7onn8ZP9z+0JCQcBAeoBWpYoSkaBcfk1g9ISAOvAFuS3m/XvTOXojru53jqk3xl7GF3RtdAv4DqzXLLn67dBCVMKqLm5Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=TWm75BGz; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Ov+hRTLe; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59KEAbcC3744837;
	Tue, 21 Oct 2025 05:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=bn82dMdAFFniYAsIpMMlhGemyy4oDmLfJln1+aQEmPU=; b=
	TWm75BGzOzDEiL8qkq1uKbbaMJ7Kj7T+nemTP+4i8hInLzkE+X2xd0qi9QuDA0/f
	MtLiSImdjEE2GhL0ZvKSP00bd0C2/zYdLHCE8jKeq6AnQECJUHrmaG590vkCMHj9
	NcA/X4XCBZawcDfhtHtZrw4ckAtxCK6YxQGqf0LHjTHDcf0N24XhokD0Rf9Uc0YF
	HY//Gg7YSdq5xTf4ecRUGvO2phczz8f0B5izB7K4ctZljDkE3jLzc5QK1LMtaQwz
	irz1ZF8Rq2Plel5ZA+/7XIPBxCW5D5ktNl6BEjq8uSRTb/xgE9apLhI6FExkrYZF
	hpyywfwa+aWpEn+l9fXWvQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11023129.outbound.protection.outlook.com [40.107.201.129])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49wnc4sdqn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 05:50:33 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMM0AMT/1VE3Xx9atiDutOuHlynhdI/yA7e9nRF5mTycFKPKeiZEMk8gyKK59e6slZ4GduPN2E4QdZmGbfbC47JN+l3sFMD4snq5nmFC44J8/wnPIf1jTqOBfUMffBVsoIigtNZvRdUYhd7FVx06nZWhSSbbrwm1ya6zcgps3AdACuHFWQRphOzZO/+j1E//7ZgGh7aL7I7NG+lRNKARY/5Vc/f/S2E/VRkmBZb70B7rtheMdkAQ0VW5iVpRXPaF9pvySFkIikrgqWS9pKeVpc+BReyNiTk/owZSjrdNOzCyzbB3cYQ4Ms7zuUP1je5xdDtoD+Gk5nIHh/i+Jj1yLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bn82dMdAFFniYAsIpMMlhGemyy4oDmLfJln1+aQEmPU=;
 b=Lup9JtAhMy0r3qjGVRxb7gA0Vc334WEG/75Z76lYtlglZzGcl2w+allTzNu/tl93u9jhhhWspGw9iG4u+VgIkkYazqcMiHZelYAMUw5lEaSI+T9UYq3GSbmS22eq74ovEBwUxqofEHhuvLLbYnzxVFOAqDKYNSkcJovVhTJGtWAqYjwfVzE0uyqxodhV8JIaCJktvbUYE+4yfZqo4gNJK6p2vwQMIJ3iUxdpLh8VrjMVdctpYhbYs79BShO+DaXT4Y/dD29wsKECGOPiZpeGJCX6g6E35m/OSr2GOtNAbHPQje9LIyWWXIR+gFr3xLcSqIFsllC2RCdXmoInryG8tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bn82dMdAFFniYAsIpMMlhGemyy4oDmLfJln1+aQEmPU=;
 b=Ov+hRTLe37YY6dP1TPNb6WOD8dYaGn43s56QXCnwcJpN2AuYPZCDqRo09ksN7BZvjdHeJuekeSxh0QVcQyN1BSalhk5QB7Ljq0xznVDDPys2KJljjS+SwfpwZtbgy49gxolznBwDodNkvZnsfeY74oRvK9StJRgkyNc6GZ89vcM=
Received: from MN2PR08CA0011.namprd08.prod.outlook.com (2603:10b6:208:239::16)
 by CH3PR19MB8261.namprd19.prod.outlook.com (2603:10b6:610:195::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 10:50:28 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:239:cafe::e6) by MN2PR08CA0011.outlook.office365.com
 (2603:10b6:208:239::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Tue,
 21 Oct 2025 10:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Tue, 21 Oct 2025 10:50:26 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id B61FB40655D;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 7FE74822546;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH v2 07/11] ASoC: cs-amp-lib: Return attributes from cs_amp_get_efi_variable()
Date: Tue, 21 Oct 2025 11:50:18 +0100
Message-ID: <20251021105022.1013685-8-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021105022.1013685-1-rf@opensource.cirrus.com>
References: <20251021105022.1013685-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CH3PR19MB8261:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e23d9a94-405b-442e-a1bb-08de108fa4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gTVV+7gxaq7PA4mMPg5VtrifjPr6ik+urYLnXXt4u1kC0+/twaRgyn5xaHKa?=
 =?us-ascii?Q?3LCB9/i3MddSYAvo25n+iau6DraL0psSkOxtCgxOiwZJ9q+ZWdhr/TXo5B/H?=
 =?us-ascii?Q?yQCCUmauXOzWUlfSznQIySbfNkX5RwRQZLv8s9hzJ08EnlOBeOY0Dk9S7htT?=
 =?us-ascii?Q?NSegk/gUCOfii36M3ncNDihtJVvmWAWeFJ4n2oTOWqTkgsiQymPQrjJF/L+s?=
 =?us-ascii?Q?jVl7ykWd2d63lIr6UEhENWhTNaOShzIJAz1zJsSJvW6yjtHFxi3e/ett5ird?=
 =?us-ascii?Q?7liCkJCSTbG/hvzfsTK8pEw2eaI8Mr0dIGmjWYdXwLQPeljgQ7moM/5/GDo7?=
 =?us-ascii?Q?tSh40tAfNvMmc5xB02/0GVSe3iCvPgliyRD9Jy2ImvppqfZ5BvYuNQYIiWBA?=
 =?us-ascii?Q?zyMcd5KZPzxHMimahEXTUxb++K8s6BsvjfMNfc1Jm6+dD/NR7oUNIxBTsqxO?=
 =?us-ascii?Q?VA0pqIB2/gRna3WfQlE3q2fI5qPxX3+3ollWeIIz62BgvfvZhr46+j+onMoe?=
 =?us-ascii?Q?5k+/AACtlDXGTlHXBzPWdEm9rnY22v3JmyKLYZjFHFqiV++VsUXKTknIlxAD?=
 =?us-ascii?Q?n86hLc0/TixhSO7TGblyeCUJxVvfoi6bCttymAUCuBiW7BEfLVrbeVSLpQ38?=
 =?us-ascii?Q?0eT30t3zmlraTb63ZPdThc6nOPDR2wfTT/N3+fueJw4UbGJqAGzUtoLmZZ+y?=
 =?us-ascii?Q?yB76+fylvDLgvp+piwi863Z7I3AR/mIx8s5cff2hnOHI1Du0P2AZ3hw1O3nP?=
 =?us-ascii?Q?KNOfmV/Mwhha0OuI2g6IFYmSgUhsHyeYez00KOJ8bZ3/gUJCBksPRHo9VITd?=
 =?us-ascii?Q?4ZBrlJxOizHIaND9TfW9mOBmd4t7sNkM/aSCL2Xy+YHWzzphb4bSCoqFJNvH?=
 =?us-ascii?Q?DtM3VF+td1Iu7vjiNfADUgPQtvHku0aufhp2kwxQCzHQ86CquHHBK7shfSLZ?=
 =?us-ascii?Q?m9FaUSHVXY11OqHs2CKoqvRCB9x4ihZKykaMCixRCUEABISPRP+TczdntzWV?=
 =?us-ascii?Q?fo1HFyXAc3dLLZn2s1udSVwBx3tPLh9x42IShFIYSCBh09wiA43w7h3K3NqL?=
 =?us-ascii?Q?hdfzQADqA+ziGZogZk0JXwZt7VL3VmDDpgwiX1hrc1YkS1C1qDkRlUs0AXeR?=
 =?us-ascii?Q?2AAYYpwH+AeePrdSR6OOPVxteqQLCJ0SPKamEN8q+PDMWwyubI0grsUr+tLc?=
 =?us-ascii?Q?ruP+4mWTMHY1G1HUVcFvKgrFJ335hmMHcVuEYol1xrsJL8VQdFaDIH8wWqeh?=
 =?us-ascii?Q?W5rfBb1mAwr8OYCFu5xJ5vmT3wg22bjpVhKF3+2Of+55QXi99V/p4+bBECts?=
 =?us-ascii?Q?BNTTX6eGDr/WMyruHaV/pjgRH+BIVdKCgHkW8RK68h4VO0xAMEi2saUsQO/w?=
 =?us-ascii?Q?vYq/d737N65XyVXgxEWvSwoMepAnx0RdiQQLWdDHbb5fOjIFAXOsyXnwMsiR?=
 =?us-ascii?Q?zlXhR+1oWyPFn36BG7rMph3HHx3iYVC0Q6YzcOG4HDvYHFnE0bk4E6CVkmen?=
 =?us-ascii?Q?WDEYLo2v3hFjJJGH2NTYzmFpd65vbCBo3rn/8wvBZR3ViFVXlrx3e8/nlTwB?=
 =?us-ascii?Q?7ugzrCdtdIcf0nhibL0=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 10:50:26.4603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e23d9a94-405b-442e-a1bb-08de108fa4ee
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB8261
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDA4NSBTYWx0ZWRfX6Tgj8bbIZ+1Q
 fjnalToCKXdeZVqn5MqzqEGq6X1v24okVsjja943hNgAdI4Wf/ZZpU+qika5MhqilifppVNX/P3
 Hl+NTq7uRqvo0Mxqy9DY9KtBWk7wL8gG/KQ2SWJ7Bte5xk2BgB4YD+c4Kma7nsMU+xTpZF84Xvx
 LvmeNKn22m+M2JKRpNuMl+3YIK2Lu7Gz/A+iUMuydHsXIdZv7PKCNxKy7iFUUjSsxqOzn9Uc2pL
 JGrnc9wP5mLMnC+Eq0S1J9Yz5wXUFUw3SzXDbdYDXAO69Sc3uUxhfYDXkwwhpYS7bWYHoMgv+z5
 LZa7+KsPSm9RWwP/TykZsggM8cXRDIlPTQi+zWLnAQoRxtadDRTyI7u0DSuQrL59UrWtm2rHRtA
 +KXXhsrDJkcVgnhyFM5Gy0gIZoyUnw==
X-Proofpoint-GUID: 72iG1hYbn0TqaXQOOEFftvEf_4IrmDXb
X-Proofpoint-ORIG-GUID: 72iG1hYbn0TqaXQOOEFftvEf_4IrmDXb
X-Authority-Analysis: v=2.4 cv=bf1mkePB c=1 sm=1 tr=0 ts=68f76579 cx=c_pps
 a=roYWoV4TocsuA6t8t8h9Ow==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=BfivipjO2gqBdDjawAAA:9
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
No changes since V1.

 include/sound/cs-amp-lib.h         |  1 +
 sound/soc/codecs/cs-amp-lib-test.c | 23 +++++++++++++++++++++++
 sound/soc/codecs/cs-amp-lib.c      | 15 ++++++++++-----
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/sound/cs-amp-lib.h b/include/sound/cs-amp-lib.h
index efa744133a35..2e5616a5e1f7 100644
--- a/include/sound/cs-amp-lib.h
+++ b/include/sound/cs-amp-lib.h
@@ -66,6 +66,7 @@ static inline u64 cs_amp_cal_target_u64(const struct cirrus_amp_cal_data *data)
 struct cs_amp_test_hooks {
 	efi_status_t (*get_efi_variable)(efi_char16_t *name,
 					 efi_guid_t *guid,
+					 u32 *returned_attr,
 					 unsigned long *size,
 					 void *buf);
 
diff --git a/sound/soc/codecs/cs-amp-lib-test.c b/sound/soc/codecs/cs-amp-lib-test.c
index 6878941a8f57..b00ba65badd5 100644
--- a/sound/soc/codecs/cs-amp-lib-test.c
+++ b/sound/soc/codecs/cs-amp-lib-test.c
@@ -89,6 +89,7 @@ static u64 cs_amp_lib_test_get_target_uid(struct kunit *test)
 /* Redirected get_efi_variable to simulate that the file is too short */
 static efi_status_t cs_amp_lib_test_get_efi_variable_nohead(efi_char16_t *name,
 							    efi_guid_t *guid,
+							    u32 *returned_attr,
 							    unsigned long *size,
 							    void *buf)
 {
@@ -121,6 +122,7 @@ static void cs_amp_lib_test_cal_data_too_short_test(struct kunit *test)
 /* Redirected get_efi_variable to simulate that the count is larger than the file */
 static efi_status_t cs_amp_lib_test_get_efi_variable_bad_count(efi_char16_t *name,
 							       efi_guid_t *guid,
+							       u32 *returned_attr,
 							       unsigned long *size,
 							       void *buf)
 {
@@ -164,6 +166,7 @@ static void cs_amp_lib_test_cal_count_too_big_test(struct kunit *test)
 /* Redirected get_efi_variable to simulate that the variable not found */
 static efi_status_t cs_amp_lib_test_get_efi_variable_none(efi_char16_t *name,
 							  efi_guid_t *guid,
+							  u32 *returned_attr,
 							  unsigned long *size,
 							  void *buf)
 {
@@ -191,6 +194,7 @@ static void cs_amp_lib_test_no_cal_data_test(struct kunit *test)
 /* Redirected get_efi_variable to simulate reading a cal data blob */
 static efi_status_t cs_amp_lib_test_get_efi_variable(efi_char16_t *name,
 						     efi_guid_t *guid,
+						     u32 *returned_attr,
 						     unsigned long *size,
 						     void *buf)
 {
@@ -217,11 +221,18 @@ static efi_status_t cs_amp_lib_test_get_efi_variable(efi_char16_t *name,
 
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
@@ -248,6 +259,12 @@ static efi_status_t cs_amp_lib_test_get_hp_cal_efi_variable(efi_char16_t *name,
 
 	memcpy(buf, priv->cal_blob, priv->cal_blob->size);
 
+	if (returned_attr) {
+		*returned_attr = EFI_VARIABLE_NON_VOLATILE |
+				 EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				 EFI_VARIABLE_RUNTIME_ACCESS;
+	}
+
 	return EFI_SUCCESS;
 }
 
@@ -786,6 +803,7 @@ static void cs_amp_lib_test_spkid_lenovo_not_present(struct kunit *test)
 
 static efi_status_t cs_amp_lib_test_get_efi_variable_lenovo_d0(efi_char16_t *name,
 							       efi_guid_t *guid,
+							       u32 *returned_attr,
 							       unsigned long *size,
 							       void *buf)
 {
@@ -804,6 +822,7 @@ static efi_status_t cs_amp_lib_test_get_efi_variable_lenovo_d0(efi_char16_t *nam
 
 static efi_status_t cs_amp_lib_test_get_efi_variable_lenovo_d1(efi_char16_t *name,
 							       efi_guid_t *guid,
+							       u32 *returned_attr,
 							       unsigned long *size,
 							       void *buf)
 {
@@ -822,6 +841,7 @@ static efi_status_t cs_amp_lib_test_get_efi_variable_lenovo_d1(efi_char16_t *nam
 
 static efi_status_t cs_amp_lib_test_get_efi_variable_lenovo_00(efi_char16_t *name,
 							       efi_guid_t *guid,
+							       u32 *returned_attr,
 							       unsigned long *size,
 							       void *buf)
 {
@@ -873,6 +893,7 @@ static void cs_amp_lib_test_spkid_lenovo_illegal(struct kunit *test)
 
 static efi_status_t cs_amp_lib_test_get_efi_variable_buf_too_small(efi_char16_t *name,
 								   efi_guid_t *guid,
+								   u32 *returned_attr,
 								   unsigned long *size,
 								   void *buf)
 {
@@ -893,6 +914,7 @@ static void cs_amp_lib_test_spkid_lenovo_oversize(struct kunit *test)
 
 static efi_status_t cs_amp_lib_test_get_efi_variable_hp_30(efi_char16_t *name,
 							   efi_guid_t *guid,
+							   u32 *returned_attr,
 							   unsigned long *size,
 							   void *buf)
 {
@@ -911,6 +933,7 @@ static efi_status_t cs_amp_lib_test_get_efi_variable_hp_30(efi_char16_t *name,
 
 static efi_status_t cs_amp_lib_test_get_efi_variable_hp_31(efi_char16_t *name,
 							   efi_guid_t *guid,
+							   u32 *returned_attr,
 							   unsigned long *size,
 							   void *buf)
 {
diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index f9f79da3a9ea..c5791cbeb5b8 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -245,15 +245,20 @@ EXPORT_SYMBOL_NS_GPL(cs_amp_write_ambient_temp, "SND_SOC_CS_AMP_LIB");
 
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
@@ -288,7 +293,7 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 	for (i = 0; i < ARRAY_SIZE(cs_amp_lib_cal_efivars); i++) {
 		status = cs_amp_get_efi_variable(cs_amp_lib_cal_efivars[i].name,
 						 cs_amp_lib_cal_efivars[i].guid,
-						 &data_size, NULL);
+						 NULL, &data_size, NULL);
 		if (status == EFI_BUFFER_TOO_SMALL)
 			break;
 	}
@@ -308,7 +313,7 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 
 	status = cs_amp_get_efi_variable(cs_amp_lib_cal_efivars[i].name,
 					 cs_amp_lib_cal_efivars[i].guid,
-					 &data_size, data);
+					 NULL, &data_size, data);
 	if (status != EFI_SUCCESS) {
 		ret = -EINVAL;
 		goto err;
@@ -452,7 +457,7 @@ static int cs_amp_get_efi_byte_spkid(struct device *dev, const struct cs_amp_spk
 	int i, ret;
 
 	size = sizeof(spkid);
-	status = cs_amp_get_efi_variable(info->name, info->guid, &size, &spkid);
+	status = cs_amp_get_efi_variable(info->name, info->guid, NULL, &size, &spkid);
 	ret = cs_amp_convert_efi_status(status);
 	if (ret < 0)
 		return ret;
-- 
2.47.3


