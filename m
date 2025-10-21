Return-Path: <linux-kernel+bounces-862680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5C8BF5E43
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51B45502858
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1ED330B3C;
	Tue, 21 Oct 2025 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="oNdCZHw/";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="t23WU2vt"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9E232E12F;
	Tue, 21 Oct 2025 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043844; cv=fail; b=I8zk2YvNh2+vmZursy+HiZ3s3RCf2eXKqkahD3paW7/56kq/w9svyxdn2S/izj4rSBT37xJYWXW5Ayy2MkIaM1tGR89QS6D6UU7BmZ6Iena4BpR/gV0YOEUrbd4jrrOfzm4mPB12znvijtyMXVoi/2S6oKtcf5nECqXjIkcP+nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043844; c=relaxed/simple;
	bh=0ZEL86kBkWLGw7UC+OwcengFF/nzBppifdtSs8fuAYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkYkHQXs+Ai+aqCheIpck6YHR3/3Eok/x1dNcOarJSWiFWtFcmPYAE2z1/KvpgL8RzZCc7wO/k5mM2N0snSLyg3FA0WKM6k8rVdblaWUXk2GiOH5d3mAO+ZEAothx+xkJB60Ai0Q+WdLWPB3FksJ90Q3m7j/iekhv1G2xb6SlWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=oNdCZHw/; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=t23WU2vt; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59LASk2E2958765;
	Tue, 21 Oct 2025 05:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Ws9njbi6cPnvmUlP4d3RwhxBMnic1Q+r4SD6pIZKl4w=; b=
	oNdCZHw/gLbW5b3z8b9u/w9XAnD7MuaX8WHuh/Ea+Zbif10KkoEKSUGWB+AIRgOG
	z6OfO9fWe+in1mN6Cdqapjra28zaI/834Wpje6EFi8kzVOOvh8/UdmAP1azk/uak
	Yj8nC+t/e9jUOhD6vBC7YoQAgrw1rnRA2MNebSnpJexCAxyCdTDWwJ+SrGerM2+e
	7aHvbUq6JWcqYaSAYuBXvPtmhUhgTcU/2RKM22QPyUftj3P3lTCFyGgJ6iWCRm2v
	TkeOIo79BctJ7TcQnc8pRL3iqqnf9oiEsDbobUEk9HDUyUpEZ3SIgHwIcMlbdFKb
	BFFmzyzWpepgKosjALuEVg==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023140.outbound.protection.outlook.com [40.93.201.140])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49v7aj3eg3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 05:50:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTa1HRvK/5LlIB6ijFSO2LGtqB6G0sj/Ukl8VtEAL+e2qSb0TrI3zQhPq8fvJHTwjDj4Fp8pps8aNxxSdyDo1hjNrFoxMsQcCog3G8DJYoK9VO6F3zSfIPsS8od29ZkUYgNxRUiFJ+fpNN7P4vjNsSf8x5XCCsGF8a3az9CMeA1d13MEpV9EmqWVogEJ4eIY3WRsi/UNHdmpTbLXzi6YxHEGLfE9n5T9BqX3Z+MVzGGOYweWxjHR5YmwywXWI5nQ3/2um0ncp7N4zJEJ1gFO5EoKPdDyYx2xPCYnLn4A3gz3g3J1bDZxiZgzww1h7FDT10CBy/0nXISlPYxoD7xfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws9njbi6cPnvmUlP4d3RwhxBMnic1Q+r4SD6pIZKl4w=;
 b=SERLfXXvXkxf9R3ul4sCU3U1AjwKY+OeiYpC/SUWiWLUMEGAazev8sCYkhqAP76xm3pEWlKCPSa55O5IJUMxHwAb4z1eHglUxram25/YhIUPQ1W5z9bx64u6ln1da5vqqZYb/dAyViMGt4U8jpLdv0+CPPNmD69+6QzNB1YGufjZSoP/2rgxEa1uCEui2wECV1fhfo6SHWoyyjsm46ubqXaIcZXh+JKoawelh9w1yi+G3w03E1Z5nTS6HknGcSHpcCzmleh2N+rgI13YAjwBSZkMEIB3OsAMJcHD4ErvutFAZKKa/HM/heADiH1HUsQEQsIa1yRop7NUrTBA3ljftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ws9njbi6cPnvmUlP4d3RwhxBMnic1Q+r4SD6pIZKl4w=;
 b=t23WU2vtf0TUK8cNQKOVcm4SlymLwY2E6yLFzE2CSl9hPrJt1aPvaQCRZ5n/o01K8xW8rbbOi1UcR3AEPJbhsxRsXb8ga4s+u/BTQ+FW4kAGTw1PMOgR63tfvfvPGxKoMCLU3sULiZe3Hg0Vdc2lSc5tXyDRIgFP92T7RtK5+WA=
Received: from BL1PR13CA0209.namprd13.prod.outlook.com (2603:10b6:208:2be::34)
 by MW3PR19MB4284.namprd19.prod.outlook.com (2603:10b6:303:44::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 10:50:28 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2be:cafe::9d) by BL1PR13CA0209.outlook.office365.com
 (2603:10b6:208:2be::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 10:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Tue, 21 Oct 2025 10:50:27 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id BF6C8406578;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 96FDE82255D;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH v2 11/11] ASoC: cs-amp-lib-test: Add test cases for cs_amp_set_efi_calibration_data()
Date: Tue, 21 Oct 2025 11:50:22 +0100
Message-ID: <20251021105022.1013685-12-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|MW3PR19MB4284:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fed726e5-7038-4616-64eb-08de108fa59f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xy7M0S9V/64K/qk/g/A6SPasRLSQQb73I13xS1YbUWGXhq5pgjbP5IsiijeS?=
 =?us-ascii?Q?2wVlqld2lokAf5P/oVHWQFvX7XFxqv6kNmbwt4ZvrEeNprDTcuvibS4OR/oK?=
 =?us-ascii?Q?bs/vTBcF2jDrERIr0ik8S5Nf9MI01DR4UC2ijm30jwhlVz5eZMeih1A8ca+5?=
 =?us-ascii?Q?YwjfCVfxXustK4jpQHnSEEKvKixZFx40g/2bIBMgHEif85MnslQs2/uWvvQt?=
 =?us-ascii?Q?349hbLuTq19ryoBMIobDd2kLrZ89kfcAozLx33Pf8LvwxErBu8hT//3VUewu?=
 =?us-ascii?Q?4er9M7Gi89EVzN9z395/di6TKTLc7dRg3eY+SLQIsYJxvUank/OLozpREc4u?=
 =?us-ascii?Q?8pCJ/ZyABTgN+VsfuVZSYlMFKZ2Xh4zQXeAlvJ7kymzo1SApKIHs7M2/j3j7?=
 =?us-ascii?Q?w1kCoc9wtHkLQiR4iYySE7xrtrGDmTWZzJtTv1PBOfCa9by2iYaMM1yH83Kf?=
 =?us-ascii?Q?msvKA9HEyb4BCrJYTrP3Oqly82H5bVo4Y6MM6T8YJdspd4jF1ad5Fx2dmbDM?=
 =?us-ascii?Q?BNcZcRd9UxN8xyRfu5CNtLf9fz2a/MDzSjou4Xq51gMgKe7OJvYzEGshEzO3?=
 =?us-ascii?Q?9UYoeCs/p1jqjsAVmhTnDuWO6g76bDNwfapkV9cy2BRc2m65XLoyP4hvMJQ5?=
 =?us-ascii?Q?FRR8CSLHKdLHQ1Yx1dgg/UMkoR33RXlCWSWtv0UFsPC6Q3lmT2oIRDoQBL0c?=
 =?us-ascii?Q?cHGz13CMK3RJEArAGdaQsl/3dD82I7YqIpd/j9tcxwqAaRFi4X0ytujdx386?=
 =?us-ascii?Q?sv2gkdW1j5XH6cgbuPaDuLu/9S4kVaY1xBzMzHnaqj7vLAVOPctMARX0OsgR?=
 =?us-ascii?Q?zzEahTr7eh315JFQAwVMHhCNCbqLtOPlBnwlgwTJg7J/q6fm2nv/oCGTponM?=
 =?us-ascii?Q?2f/xnBf6jUDoFZUvA6BrqfDy3xRO81VoT0QqG0FAht0lL5JoNT9gnmr8AdMq?=
 =?us-ascii?Q?M2QwoYiwFXwUVIoibnCMJSFbVDCC6p/DqWoOsLs6nRnSrnAX+I7snQIdEqEr?=
 =?us-ascii?Q?hyHP9aCAEChTpdfwufAj9tCvKcw6l95x7GqoXzQWGzvkz+Metw4bprNj10xy?=
 =?us-ascii?Q?Xun0vBw1mh/jJkqwQJQhzC2VvqFclSP+/McbUxpBcSAu5IvRDGt8DMwL4/Zp?=
 =?us-ascii?Q?bUucuKc8XpEwZASOqSIwRrKFbUIXKWtIKx0FW/edvUWJlEh/mV7SUNAbGU9F?=
 =?us-ascii?Q?jI0beD2n9ucj1V/tno3E8vSS7NMX9sBfHI+z0ObQAGAD3m55kfADBnMz/XTA?=
 =?us-ascii?Q?Obxm/yLtUFwnnIO20ne9Z6oXRfdJ+ZjjMTZ78rnAcFUnqBUzpAN1hjDtoH08?=
 =?us-ascii?Q?8TotDB8fNVXlhAMnu1/dcNyZxyGqKZufU/ney/mlcSWjL7qfKY4mCsd+gzW/?=
 =?us-ascii?Q?aYcQAB3Hy11NlUQMEx/4rwXffurcycWiWTHsjfz7pJQncRvRTGhvUrKT7RKz?=
 =?us-ascii?Q?aFsx2vteS+/yqHRMeciOUSTLwbJAYU8Z0oP5vEdGguewggGj8gsZVl2HbmEn?=
 =?us-ascii?Q?UUKBbF9MuPKqco6Xv11IGtJCgNJky/Jx+mCpGahZpI3vJeRQRhIKwhLy45pq?=
 =?us-ascii?Q?UdNfZkAGuhUwufN0Xck=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 10:50:27.6167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fed726e5-7038-4616-64eb-08de108fa59f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR19MB4284
X-Proofpoint-ORIG-GUID: Lsubxj_M_RO5ATTihEaX-iH5eIaw8YTx
X-Proofpoint-GUID: Lsubxj_M_RO5ATTihEaX-iH5eIaw8YTx
X-Authority-Analysis: v=2.4 cv=bdNmkePB c=1 sm=1 tr=0 ts=68f76577 cx=c_pps
 a=Yd/70bDpgrqg65f6KmCseQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=DhBJ85K0pojyqza_LUEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDA4NSBTYWx0ZWRfX1qSaOFKbT9On
 UPfYRmXhpFaFB0M98RIqfxIaTQBtr+1UwvZuOlyHKJwcyFljE6U7wQh9rA5VzFDuiy06hacSpJk
 PQAaB6dV8MFhPyiXuIHXnDNR/BtmMVuo5gfBTtkyWhdOHcNyQe+XWyLfvZhtqiQMFSgDPd+QQkK
 8YGbdMlcb9ihcw11Tz41k0B4iPNWJ+eAMAImr1JPethCVy3RHZP8XwH0wA6QsY1Jv6IYc6AsfRC
 u3tja8rZ4a3Ez5cglEALvX/l+a9ecq653LSHUXI8SWKriLkFAP9hATt3BdO7uT4brMJ04WsUnw5
 ZGFsw0RxZF/bM8GLKJv081JWEwmPrKYHJeih2dIgLYcnwdV8ZsoM5cCic+Av658GKZ67skE0SP9
 Tfk4LAKWmjccz3bezNLqKMnNhRp4iQ==
X-Proofpoint-Spam-Reason: safe

Add a set of test cases for cs_amp_set_efi_calibration_data().

Broadly there are two type of behavior being tested:

How the EFI is updated:
- Create a new EFI
- Overwrite part of existing content
- Overwrite part of zero-filled preallocated content
- Grow the file to append new content

And how the location within the content is chosen:
- Overwrite a specific array entry
- Overwrite an entry with the same calTarget (silicon ID)
- Overwrite a free entry
- Append after existing data

Plus some cases for error conditions.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
No changes since V1.

 include/sound/cs-amp-lib.h         |    5 +
 sound/soc/codecs/cs-amp-lib-test.c | 1399 +++++++++++++++++++++++++++-
 sound/soc/codecs/cs-amp-lib.c      |    1 +
 3 files changed, 1397 insertions(+), 8 deletions(-)

diff --git a/include/sound/cs-amp-lib.h b/include/sound/cs-amp-lib.h
index 240bc53a9307..61e00017c9aa 100644
--- a/include/sound/cs-amp-lib.h
+++ b/include/sound/cs-amp-lib.h
@@ -71,6 +71,11 @@ struct cs_amp_test_hooks {
 					 u32 *returned_attr,
 					 unsigned long *size,
 					 void *buf);
+	efi_status_t (*set_efi_variable)(efi_char16_t *name,
+					 efi_guid_t *guid,
+					 u32 attr,
+					 unsigned long size,
+					 void *buf);
 
 	int (*write_cal_coeff)(struct cs_dsp *dsp,
 			       const struct cirrus_amp_cal_controls *controls,
diff --git a/sound/soc/codecs/cs-amp-lib-test.c b/sound/soc/codecs/cs-amp-lib-test.c
index b00ba65badd5..51799a9c86a3 100644
--- a/sound/soc/codecs/cs-amp-lib-test.c
+++ b/sound/soc/codecs/cs-amp-lib-test.c
@@ -19,6 +19,10 @@
 #include <linux/random.h>
 #include <sound/cs-amp-lib.h>
 
+#define CIRRUS_LOGIC_CALIBRATION_EFI_NAME L"CirrusSmartAmpCalibrationData"
+#define CIRRUS_LOGIC_CALIBRATION_EFI_GUID \
+	EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4, 0x3d, 0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3)
+
 #define LENOVO_SPEAKER_ID_EFI_NAME L"SdwSpeaker"
 #define LENOVO_SPEAKER_ID_EFI_GUID \
 	EFI_GUID(0x48df970e, 0xe27f, 0x460a, 0xb5, 0x86, 0x77, 0x19, 0x80, 0x1d, 0x92, 0x82)
@@ -27,6 +31,10 @@
 #define HP_SPEAKER_ID_EFI_GUID \
 	EFI_GUID(0xc49593a4, 0xd099, 0x419b, 0xa2, 0xc3, 0x67, 0xe9, 0x80, 0xe6, 0x1d, 0x1e)
 
+#define HP_CALIBRATION_EFI_NAME L"SmartAmpCalibrationData"
+#define HP_CALIBRATION_EFI_GUID \
+	EFI_GUID(0x53559579, 0x8753, 0x4f5c, 0x91, 0x30, 0xe8, 0x2a, 0xcf, 0xb8, 0xd8, 0x93)
+
 KUNIT_DEFINE_ACTION_WRAPPER(faux_device_destroy_wrapper, faux_device_destroy,
 			    struct faux_device *)
 
@@ -35,6 +43,7 @@ struct cs_amp_lib_test_priv {
 
 	struct cirrus_amp_efi_data *cal_blob;
 	struct list_head ctl_write_list;
+	u32 efi_attr;
 };
 
 struct cs_amp_lib_test_ctl_write_entry {
@@ -48,6 +57,20 @@ struct cs_amp_lib_test_param {
 	int amp_index;
 };
 
+static struct cirrus_amp_efi_data *cs_amp_lib_test_cal_blob_dup(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct cirrus_amp_efi_data *temp;
+
+	KUNIT_ASSERT_EQ(test, struct_size(priv->cal_blob, data, priv->cal_blob->count),
+			priv->cal_blob->size);
+	temp = kunit_kmalloc(test, priv->cal_blob->size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, temp);
+	memcpy(temp, priv->cal_blob, priv->cal_blob->size);
+
+	return temp;
+}
+
 static void cs_amp_lib_test_init_dummy_cal_blob(struct kunit *test, int num_amps)
 {
 	struct cs_amp_lib_test_priv *priv = test->priv;
@@ -68,9 +91,15 @@ static void cs_amp_lib_test_init_dummy_cal_blob(struct kunit *test, int num_amps
 	for (i = 0; i < num_amps; i++)
 		priv->cal_blob->data[i].calTime[0] |= 1;
 
-	/* Ensure that all UIDs are non-zero and unique. */
-	for (i = 0; i < num_amps; i++)
+	/*
+	 * Ensure that all UIDs are non-zero and unique.
+	 * Make both words non-zero and not equal values, so that
+	 * tests can verify that both words were checked or changed.
+	 */
+	for (i = 0; i < num_amps; i++) {
 		*(u8 *)&priv->cal_blob->data[i].calTarget[0] = i + 1;
+		*(u8 *)&priv->cal_blob->data[i].calTarget[1] = i;
+	}
 }
 
 static u64 cs_amp_lib_test_get_target_uid(struct kunit *test)
@@ -198,9 +227,8 @@ static efi_status_t cs_amp_lib_test_get_efi_variable(efi_char16_t *name,
 						     unsigned long *size,
 						     void *buf)
 {
-	static const efi_char16_t expected_name[] = L"CirrusSmartAmpCalibrationData";
-	static const efi_guid_t expected_guid =
-		EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4, 0x3d, 0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3);
+	static const efi_char16_t expected_name[] = CIRRUS_LOGIC_CALIBRATION_EFI_NAME;
+	static const efi_guid_t expected_guid = CIRRUS_LOGIC_CALIBRATION_EFI_GUID;
 	struct kunit *test = kunit_get_current_test();
 	struct cs_amp_lib_test_priv *priv = test->priv;
 
@@ -222,9 +250,56 @@ static efi_status_t cs_amp_lib_test_get_efi_variable(efi_char16_t *name,
 	memcpy(buf, priv->cal_blob, priv->cal_blob->size);
 
 	if (returned_attr) {
-		*returned_attr = EFI_VARIABLE_NON_VOLATILE |
-				 EFI_VARIABLE_BOOTSERVICE_ACCESS |
-				 EFI_VARIABLE_RUNTIME_ACCESS;
+		if (priv->efi_attr)
+			*returned_attr = priv->efi_attr;
+		else
+			*returned_attr = EFI_VARIABLE_NON_VOLATILE |
+					 EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					 EFI_VARIABLE_RUNTIME_ACCESS;
+	}
+
+	return EFI_SUCCESS;
+}
+
+#define CS_AMP_LIB_ZERO_FILLED_BLOB_SIZE \
+	struct_size_t(struct cirrus_amp_efi_data, data, 8)
+
+/* Redirected get_efi_variable to simulate reading a prealloced zero-filled blob */
+static efi_status_t cs_amp_lib_test_get_efi_variable_all_zeros(efi_char16_t *name,
+							       efi_guid_t *guid,
+							       u32 *returned_attr,
+							       unsigned long *size,
+							       void *buf)
+{
+	static const efi_char16_t expected_name[] = CIRRUS_LOGIC_CALIBRATION_EFI_NAME;
+	static const efi_guid_t expected_guid = CIRRUS_LOGIC_CALIBRATION_EFI_GUID;
+	struct kunit *test = kunit_get_current_test();
+	struct cs_amp_lib_test_priv *priv = test->priv;
+
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, name);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, guid);
+
+	if (memcmp(name, expected_name, sizeof(expected_name)) ||
+	    efi_guidcmp(*guid, expected_guid))
+		return -EFI_NOT_FOUND;
+
+	if (!buf) {
+		*size = CS_AMP_LIB_ZERO_FILLED_BLOB_SIZE;
+		return EFI_BUFFER_TOO_SMALL;
+	}
+
+	KUNIT_ASSERT_EQ(test, *size, struct_size(priv->cal_blob, data, 8));
+	priv->cal_blob = kunit_kzalloc(test, CS_AMP_LIB_ZERO_FILLED_BLOB_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv->cal_blob);
+	memset(buf, 0, CS_AMP_LIB_ZERO_FILLED_BLOB_SIZE);
+
+	if (returned_attr) {
+		if (priv->efi_attr)
+			*returned_attr = priv->efi_attr;
+		else
+			*returned_attr = EFI_VARIABLE_NON_VOLATILE |
+					 EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					 EFI_VARIABLE_RUNTIME_ACCESS;
 	}
 
 	return EFI_SUCCESS;
@@ -789,6 +864,1292 @@ static void cs_amp_lib_test_write_ambient_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, entry->value, 18);
 }
 
+static efi_status_t cs_amp_lib_test_set_efi_variable(efi_char16_t *name,
+						     efi_guid_t *guid,
+						     u32 attr,
+						     unsigned long size,
+						     void *buf)
+{
+	static const efi_char16_t expected_name[] = CIRRUS_LOGIC_CALIBRATION_EFI_NAME;
+	static const efi_guid_t expected_guid = CIRRUS_LOGIC_CALIBRATION_EFI_GUID;
+	struct kunit *test = kunit_get_current_test();
+	struct cs_amp_lib_test_priv *priv = test->priv;
+
+	KUNIT_ASSERT_NOT_NULL(test, name);
+	KUNIT_ASSERT_NOT_NULL(test, guid);
+
+	if (memcmp(name, expected_name, sizeof(expected_name)) ||
+	    efi_guidcmp(*guid, expected_guid))
+		return -EFI_NOT_FOUND;
+
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+	KUNIT_ASSERT_NE(test, 0, size);
+
+	kunit_kfree(test, priv->cal_blob);
+	priv->cal_blob = kunit_kmalloc(test, size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv->cal_blob);
+	memcpy(priv->cal_blob, buf, size);
+	priv->efi_attr = attr;
+
+	return EFI_SUCCESS;
+}
+
+static efi_status_t cs_amp_lib_test_set_efi_variable_denied(efi_char16_t *name,
+							    efi_guid_t *guid,
+							    u32 attr,
+							    unsigned long size,
+							    void *buf)
+{
+	return EFI_WRITE_PROTECTED;
+}
+
+#define CS_AMP_CAL_DEFAULT_EFI_ATTR			\
+		(EFI_VARIABLE_NON_VOLATILE |		\
+		 EFI_VARIABLE_BOOTSERVICE_ACCESS |	\
+		 EFI_VARIABLE_RUNTIME_ACCESS)
+
+static void cs_amp_lib_test_create_new_cal_efi(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	struct cirrus_amp_cal_data data;
+	int i;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_none);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/* For unspecified number of amps */
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_EQ(test, CS_AMP_CAL_DEFAULT_EFI_ATTR, priv->efi_attr);
+	KUNIT_EXPECT_GE(test, priv->cal_blob->count, 1);
+	KUNIT_EXPECT_LE(test, priv->cal_blob->count, 8);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, priv->cal_blob->count),
+			priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	for (i = 1; i < priv->cal_blob->count; i++)
+		KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[i], sizeof(data)));
+
+	/* For 2 amps */
+	priv->cal_blob = NULL;
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 2, &data));
+	KUNIT_EXPECT_EQ(test, CS_AMP_CAL_DEFAULT_EFI_ATTR, priv->efi_attr);
+	KUNIT_EXPECT_EQ(test, 2, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 2), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[1], sizeof(data)));
+
+	/* For 4 amps */
+	priv->cal_blob = NULL;
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 4, &data));
+	KUNIT_EXPECT_EQ(test, 4, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 4), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[1], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+
+	/* For 6 amps */
+	priv->cal_blob = NULL;
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[1], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+}
+
+static void cs_amp_lib_test_create_new_cal_efi_indexed(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_none);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/* In slot 0 */
+	priv->cal_blob = NULL;
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 0, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[1], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+
+	/* In slot 1 */
+	priv->cal_blob = NULL;
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 1, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[0], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+
+	/* In slot 5 */
+	priv->cal_blob = NULL;
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 5, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[5], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[0], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[1], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+}
+
+static void cs_amp_lib_test_create_new_cal_efi_indexed_no_max(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	struct cirrus_amp_cal_data data;
+	int i;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_none);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/* In slot 0 with unspecified number of amps */
+	priv->cal_blob = NULL;
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 0, -1, &data));
+	KUNIT_EXPECT_GE(test, priv->cal_blob->count, 1);
+	KUNIT_EXPECT_LE(test, priv->cal_blob->count, 8);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, priv->cal_blob->count),
+			priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	for (i = 1; i < priv->cal_blob->count; i++)
+		KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[i], sizeof(data)));
+
+	/* In slot 1 with unspecified number of amps  */
+	priv->cal_blob = NULL;
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 1, -1, &data));
+	KUNIT_EXPECT_GE(test, priv->cal_blob->count, 2);
+	KUNIT_EXPECT_LE(test, priv->cal_blob->count, 8);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, priv->cal_blob->count),
+			priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[0], sizeof(data)));
+	for (i = 2; i < priv->cal_blob->count; i++)
+		KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[i], sizeof(data)));
+
+	/* In slot 5 with unspecified number of amps  */
+	priv->cal_blob = NULL;
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 5, -1, &data));
+	KUNIT_EXPECT_GE(test, priv->cal_blob->count, 6);
+	KUNIT_EXPECT_LE(test, priv->cal_blob->count, 8);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, priv->cal_blob->count),
+			priv->cal_blob->size);
+	for (i = 0; (i < 5) && (i < priv->cal_blob->count); i++)
+		KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[i], sizeof(data)));
+
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[5], sizeof(data));
+	for (i = 6; i < priv->cal_blob->count; i++)
+		KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[i], sizeof(data)));
+}
+
+static void cs_amp_lib_test_grow_append_cal_efi(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/* Initially 1 used entry grown to 2 entries */
+	cs_amp_lib_test_init_dummy_cal_blob(test, 1);
+	KUNIT_ASSERT_EQ(test, 1, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 2, &data));
+	KUNIT_EXPECT_EQ(test, CS_AMP_CAL_DEFAULT_EFI_ATTR, priv->efi_attr);
+	KUNIT_EXPECT_EQ(test, 2, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 2), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+
+	/* Initially 1 entry grown to 4 entries */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 1);
+	KUNIT_ASSERT_EQ(test, 1, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 4, &data));
+	KUNIT_EXPECT_EQ(test, 4, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 4), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+
+	/* Initially 2 entries grown to 4 entries */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 2);
+	KUNIT_ASSERT_EQ(test, 2, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 4, &data));
+	KUNIT_EXPECT_EQ(test, 4, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 4), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+
+	/* Initially 1 entry grown to 6 entries */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 1);
+	KUNIT_ASSERT_EQ(test, 1, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+
+	/* Initially 4 entries grown to 6 entries */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+}
+
+static void cs_amp_lib_test_grow_append_cal_efi_indexed(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/* Initially 1 entry grown to 2 entries using slot 1 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 1);
+	KUNIT_ASSERT_EQ(test, 1, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 1, 2, &data));
+	KUNIT_EXPECT_EQ(test, 2, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 2), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+
+	/* Initially 1 entry grown to 6 entries using slot 1 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 1);
+	KUNIT_ASSERT_EQ(test, 1, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 1, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+
+	/* Initially 2 entries grown to 6 entries using slot 2 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 2);
+	KUNIT_ASSERT_EQ(test, 2, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 2, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+
+	/* Initially 2 entries grown to 6 entries using slot 4 */
+	kunit_kfree(test, original_blob);
+	kunit_kfree(test, priv->cal_blob);
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 2);
+	KUNIT_ASSERT_EQ(test, 2, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 4, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+}
+
+static void cs_amp_lib_test_cal_efi_all_zeros_add_first(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	struct cirrus_amp_cal_data data;
+	int i;
+
+	/* Simulate a BIOS reserving EFI space that is entirely zero-filled. */
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_all_zeros);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/*
+	 * Add an entry. The header should be filled in to match the
+	 * original EFI variable size.
+	 */
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 8), priv->cal_blob->size);
+	KUNIT_EXPECT_EQ(test, 8, priv->cal_blob->count);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	for (i = 1; i < priv->cal_blob->count; i++) {
+		KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[i].calTime[0]);
+		KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[i].calTime[1]);
+	}
+}
+
+static void cs_amp_lib_test_cal_efi_all_zeros_add_first_no_shrink(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	struct cirrus_amp_cal_data data;
+	int i;
+
+	/* Simulate a BIOS reserving EFI space that is entirely zero-filled. */
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_all_zeros);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/*
+	 * Add an entry. The header should be filled in to match the
+	 * original EFI variable size. A number of amps less than the
+	 * available preallocated space does not shrink the EFI variable.
+	 */
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 4, &data));
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 8), priv->cal_blob->size);
+	KUNIT_EXPECT_EQ(test, 8, priv->cal_blob->count);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	for (i = 1; i < priv->cal_blob->count; i++) {
+		KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[i].calTime[0]);
+		KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[i].calTime[1]);
+	}
+}
+
+static void cs_amp_lib_test_cal_efi_all_zeros_add_first_indexed(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	struct cirrus_amp_cal_data data;
+	int i;
+
+	/* Simulate a BIOS reserving EFI space that is entirely zero-filled. */
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_all_zeros);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/*
+	 * Write entry to slot 2. The header should be filled in to match
+	 * the original EFI variable size.
+	 */
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 2, -1, &data));
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 8), priv->cal_blob->size);
+	KUNIT_EXPECT_EQ(test, 8, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[0].calTime[0]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[0].calTime[1]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[1].calTime[0]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[1].calTime[1]);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[2], sizeof(data));
+	for (i = 3; i < priv->cal_blob->count; i++) {
+		KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[i].calTime[0]);
+		KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[i].calTime[1]);
+	}
+}
+
+static void cs_amp_lib_test_cal_efi_all_zeros_add_first_indexed_no_shrink(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	struct cirrus_amp_cal_data data;
+	int i;
+
+	/* Simulate a BIOS reserving EFI space that is entirely zero-filled. */
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_all_zeros);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/*
+	 * Write entry to slot 2. The header should be filled in to match
+	 * the original EFI variable size. A number of amps less than the
+	 * available preallocated space does not shrink the EFI variable.
+	 */
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 2, 4, &data));
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 8), priv->cal_blob->size);
+	KUNIT_EXPECT_EQ(test, 8, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[0].calTime[0]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[0].calTime[1]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[1].calTime[0]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[1].calTime[1]);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[2], sizeof(data));
+	for (i = 3; i < priv->cal_blob->count; i++) {
+		KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[i].calTime[0]);
+		KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[i].calTime[1]);
+	}
+}
+
+static void cs_amp_lib_test_grow_append_cal_efi_indexed_no_max(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+	int i;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/* Initially 1 entry adding slot 1 */
+	cs_amp_lib_test_init_dummy_cal_blob(test, 1);
+	KUNIT_ASSERT_EQ(test, 1, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 1, -1, &data));
+	KUNIT_EXPECT_GE(test, priv->cal_blob->count, 2);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, priv->cal_blob->count),
+			priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	for (i = 2; i < priv->cal_blob->count; i++)
+		KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[i], sizeof(data)));
+
+	/* Initially 1 entry adding slot 3 */
+	cs_amp_lib_test_init_dummy_cal_blob(test, 1);
+	KUNIT_ASSERT_EQ(test, 1, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 3, -1, &data));
+	KUNIT_EXPECT_GE(test, priv->cal_blob->count, 4);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, priv->cal_blob->count),
+			priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[1], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[3], sizeof(data));
+	for (i = 4; i < priv->cal_blob->count; i++)
+		KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[i], sizeof(data)));
+
+	/* Initially 2 entries adding slot 3 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 2);
+	KUNIT_ASSERT_EQ(test, 2, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 3, -1, &data));
+	KUNIT_EXPECT_GE(test, priv->cal_blob->count, 1);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, priv->cal_blob->count),
+			priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[3], sizeof(data));
+	for (i = 4; i < priv->cal_blob->count; i++)
+		KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[i], sizeof(data)));
+
+	/* Initially 4 entries adding slot 4 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 4, -1, &data));
+	KUNIT_EXPECT_GE(test, priv->cal_blob->count, 1);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, priv->cal_blob->count),
+			priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[4], sizeof(data));
+	for (i = 5; i < priv->cal_blob->count; i++)
+		KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[i], sizeof(data)));
+
+	/* Initially 4 entries adding slot 6 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 6, -1, &data));
+	KUNIT_EXPECT_GE(test, priv->cal_blob->count, 1);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, priv->cal_blob->count),
+			priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[6], sizeof(data));
+	for (i = 7; i < priv->cal_blob->count; i++)
+		KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[i], sizeof(data)));
+}
+
+static void cs_amp_lib_test_grow_cal_efi_replace_indexed(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/* Initially 1 entry grown to 2 entries overwriting slot 0 */
+	cs_amp_lib_test_init_dummy_cal_blob(test, 1);
+	KUNIT_ASSERT_EQ(test, 1, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 0, 2, &data));
+	KUNIT_EXPECT_EQ(test, 2, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 2), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[1], sizeof(data)));
+
+	/* Initially 2 entries grown to 4 entries overwriting slot 1 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 2);
+	KUNIT_ASSERT_EQ(test, 2, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 1, 4, &data));
+	KUNIT_EXPECT_EQ(test, 4, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 4), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+
+	/* Initially 4 entries grown to 6 entries overwriting slot 1 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 1, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+
+	/* Initially 4 entries grown to 6 entries overwriting slot 3 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 3, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+
+	/* Initially 6 entries grown to 8 entries overwriting slot 4 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 6);
+	KUNIT_ASSERT_EQ(test, 6, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 4, 8, &data));
+	KUNIT_EXPECT_EQ(test, 8, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 8), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[6], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[7], sizeof(data)));
+}
+
+static void cs_amp_lib_test_grow_cal_efi_replace_by_uid(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/* Initially 1 entry grown to 2 entries overwriting slot 0 */
+	cs_amp_lib_test_init_dummy_cal_blob(test, 1);
+	KUNIT_ASSERT_EQ(test, 1, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[0].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 2, &data));
+	KUNIT_EXPECT_EQ(test, 2, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 2), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[1], sizeof(data)));
+
+	/* Initially 2 entries grown to 4 entries overwriting slot 1 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 2);
+	KUNIT_ASSERT_EQ(test, 2, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[1].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 4, &data));
+	KUNIT_EXPECT_EQ(test, 4, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 4), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+
+	/* Initially 4 entries grown to 6 entries overwriting slot 1 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[1].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+
+	/* Initially 4 entries grown to 6 entries overwriting slot 3 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[3].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+
+	/* Initially 6 entries grown to 8 entries overwriting slot 4 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 6);
+	KUNIT_ASSERT_EQ(test, 6, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[4].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 8, &data));
+	KUNIT_EXPECT_EQ(test, 8, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 8), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[6], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[7], sizeof(data)));
+}
+
+static void cs_amp_lib_test_cal_efi_replace_by_uid(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 6);
+	KUNIT_ASSERT_EQ(test, 6, priv->cal_blob->count);
+
+	/* Replace entry matching slot 0 */
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[0].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[4], &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+
+	/* Replace entry matching slot 4 */
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[4].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+
+	/* Replace entry matching slot 3 */
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[3].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[4], &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+
+	/* Replace entry matching slot 5 */
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[5].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[4], &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[5], sizeof(data));
+}
+
+static void cs_amp_lib_test_cal_efi_replace_by_index(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 6);
+	KUNIT_ASSERT_EQ(test, 6, priv->cal_blob->count);
+
+	/*
+	 * Replace entry matching slot 0.
+	 * data.calTarget is deliberately set different to current calTarget
+	 * of the slot to check that the index forces that slot to be used.
+	 */
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = ~priv->cal_blob->data[0].calTarget[0];
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 0, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[4], &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+
+	/* Replace entry matching slot 4 */
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = ~priv->cal_blob->data[4].calTarget[0];
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 4, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+
+	/* Replace entry matching slot 3 */
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = ~priv->cal_blob->data[3].calTarget[0];
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 3, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[4], &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+
+	/* Replace entry matching slot 5 */
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = ~priv->cal_blob->data[5].calTarget[0];
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 5, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[4], &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[5], sizeof(data));
+}
+
+static void cs_amp_lib_test_cal_efi_deduplicate(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+	int i;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/*
+	 * Replace entry matching slot 0.
+	 * An active entry in slot 1 for the same UID should be marked empty.
+	 * Other entries are unaltered.
+	 */
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[1].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 0, -1, &data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[1].calTime[0]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[1].calTime[1]);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+
+	/*
+	 * Replace entry matching slot 1.
+	 * An active entry in slot 0 for the same UID should be marked empty.
+	 * Other entries are unaltered.
+	 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[0].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 1, -1, &data));
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[0].calTime[0]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[0].calTime[1]);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+
+	/*
+	 * Replace entry matching slot 1.
+	 * An active entry in slot 3 for the same UID should be marked empty.
+	 * Other entries are unaltered.
+	 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[3].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 1, -1, &data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[3].calTime[0]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[3].calTime[1]);
+
+	/*
+	 * Worst case, all entries have the same UID
+	 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	for (i = 0; i < priv->cal_blob->count; i++) {
+		priv->cal_blob->data[i].calTarget[0] = 0xe5e5e5e5;
+		priv->cal_blob->data[i].calTarget[1] = 0xa7a7a7a7;
+	}
+	memcpy(data.calTarget, priv->cal_blob->data[2].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 2, -1, &data));
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[0].calTime[0]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[0].calTime[1]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[1].calTime[0]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[1].calTime[1]);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[3].calTime[0]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[3].calTime[1]);
+}
+
+static void cs_amp_lib_test_cal_efi_find_free(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 6);
+	KUNIT_ASSERT_EQ(test, 6, priv->cal_blob->count);
+
+	/*
+	 * Slot 0 is empty.
+	 * data.calTarget is set to a value that won't match any existing entry.
+	 */
+	memset(&priv->cal_blob->data[0].calTime, 0, sizeof(priv->cal_blob->data[0].calTime));
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa;
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[4], &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+
+	/* Slot 4 is empty */
+	memset(&priv->cal_blob->data[4].calTime, 0, sizeof(priv->cal_blob->data[4].calTime));
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa;
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+
+	/* Slot 3 is empty */
+	memset(&priv->cal_blob->data[3].calTime, 0, sizeof(priv->cal_blob->data[3].calTime));
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa;
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[4], &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+
+	/* Replace entry matching slot 5 */
+	memset(&priv->cal_blob->data[5].calTime, 0, sizeof(priv->cal_blob->data[5].calTime));
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa;
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[4], &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[5], sizeof(data));
+}
+
+static void cs_amp_lib_test_cal_efi_bad_cal_target(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+
+	/* Zero calTarget is illegal */
+	get_random_bytes(&data, sizeof(data));
+	memset(data.calTarget, 0, sizeof(data.calTarget));
+	KUNIT_EXPECT_LT(test, cs_amp_set_efi_calibration_data(dev, -1, -1, &data), 0);
+	KUNIT_EXPECT_LT(test, cs_amp_set_efi_calibration_data(dev, 0, -1, &data), 0);
+	KUNIT_EXPECT_LT(test, cs_amp_set_efi_calibration_data(dev, 0, 2, &data), 0);
+}
+
+static void cs_amp_lib_test_cal_efi_write_denied(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable_denied);
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+
+	/* Unspecified slot */
+	KUNIT_EXPECT_LT(test, cs_amp_set_efi_calibration_data(dev, -1, -1, &data), 0);
+	KUNIT_EXPECT_MEMEQ(test, original_blob, priv->cal_blob, original_blob->size);
+
+	/* Unspecified slot with size */
+	KUNIT_EXPECT_LT(test, cs_amp_set_efi_calibration_data(dev, -1, 6, &data), 0);
+	KUNIT_EXPECT_MEMEQ(test, original_blob, priv->cal_blob, original_blob->size);
+
+	/* Specified slot */
+	KUNIT_EXPECT_LT(test, cs_amp_set_efi_calibration_data(dev, 1, -1, &data), 0);
+	KUNIT_EXPECT_MEMEQ(test, original_blob, priv->cal_blob, original_blob->size);
+
+	/* Specified slot with size */
+	KUNIT_EXPECT_LT(test, cs_amp_set_efi_calibration_data(dev, 1, 6, &data), 0);
+	KUNIT_EXPECT_MEMEQ(test, original_blob, priv->cal_blob, original_blob->size);
+}
+
+static void cs_amp_lib_test_cal_efi_attr_preserved(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 6);
+	KUNIT_ASSERT_EQ(test, 6, priv->cal_blob->count);
+	memset(&priv->cal_blob->data[0], 0, sizeof(priv->cal_blob->data[0]));
+	get_random_bytes(&data, sizeof(data));
+
+	/* Set a non-standard attr to return from get_efi_variable() */
+	priv->efi_attr = EFI_VARIABLE_HARDWARE_ERROR_RECORD;
+
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_EQ(test, priv->efi_attr, EFI_VARIABLE_HARDWARE_ERROR_RECORD);
+}
+
+static efi_status_t cs_amp_lib_test_set_hp_efi_cal_variable(efi_char16_t *name,
+							    efi_guid_t *guid,
+							    u32 attr,
+							    unsigned long size,
+							    void *buf)
+{
+	static const efi_char16_t expected_name[] = HP_CALIBRATION_EFI_NAME;
+	static const efi_guid_t expected_guid = HP_CALIBRATION_EFI_GUID;
+	struct kunit *test = kunit_get_current_test();
+	struct cs_amp_lib_test_priv *priv = test->priv;
+
+	KUNIT_ASSERT_NOT_NULL(test, name);
+	KUNIT_ASSERT_NOT_NULL(test, guid);
+
+	if (memcmp(name, expected_name, sizeof(expected_name)) ||
+	    efi_guidcmp(*guid, expected_guid))
+		return -EFI_ACCESS_DENIED;
+
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+	KUNIT_ASSERT_NE(test, 0, size);
+
+	kunit_kfree(test, priv->cal_blob);
+	priv->cal_blob = kunit_kmalloc(test, size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv->cal_blob);
+	memcpy(priv->cal_blob, buf, size);
+	priv->efi_attr = attr;
+
+	return EFI_SUCCESS;
+}
+
+/*
+ * If the HP EFI exists it should be the one that is updated.
+ */
+static void cs_amp_lib_test_cal_efi_update_hp(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_hp_cal_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_hp_efi_cal_variable);
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 6);
+	KUNIT_ASSERT_EQ(test, 6, priv->cal_blob->count);
+
+	/* Replace entry matching slot 4 */
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = ~priv->cal_blob->data[4].calTarget[0];
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 4, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+}
+
 static void cs_amp_lib_test_spkid_lenovo_not_present(struct kunit *test)
 {
 	struct cs_amp_lib_test_priv *priv = test->priv;
@@ -1072,6 +2433,28 @@ static struct kunit_case cs_amp_lib_test_cases[] = {
 	KUNIT_CASE(cs_amp_lib_test_read_cal_data_test),
 	KUNIT_CASE(cs_amp_lib_test_write_ambient_test),
 
+	/* Test cases for writing cal data to UEFI */
+	KUNIT_CASE(cs_amp_lib_test_create_new_cal_efi),
+	KUNIT_CASE(cs_amp_lib_test_create_new_cal_efi_indexed),
+	KUNIT_CASE(cs_amp_lib_test_create_new_cal_efi_indexed_no_max),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_all_zeros_add_first),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_all_zeros_add_first_no_shrink),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_all_zeros_add_first_indexed),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_all_zeros_add_first_indexed_no_shrink),
+	KUNIT_CASE(cs_amp_lib_test_grow_append_cal_efi),
+	KUNIT_CASE(cs_amp_lib_test_grow_append_cal_efi_indexed),
+	KUNIT_CASE(cs_amp_lib_test_grow_append_cal_efi_indexed_no_max),
+	KUNIT_CASE(cs_amp_lib_test_grow_cal_efi_replace_indexed),
+	KUNIT_CASE(cs_amp_lib_test_grow_cal_efi_replace_by_uid),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_replace_by_uid),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_replace_by_index),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_deduplicate),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_find_free),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_bad_cal_target),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_write_denied),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_attr_preserved),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_update_hp),
+
 	/* Test cases for speaker ID */
 	KUNIT_CASE(cs_amp_lib_test_spkid_lenovo_not_present),
 	KUNIT_CASE(cs_amp_lib_test_spkid_lenovo_d0),
diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index 7038574e3f4b..d8f8b0259cd1 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -727,6 +727,7 @@ EXPORT_SYMBOL_NS_GPL(cs_amp_create_debugfs, "SND_SOC_CS_AMP_LIB");
 
 static const struct cs_amp_test_hooks cs_amp_test_hook_ptrs = {
 	.get_efi_variable = cs_amp_get_efi_variable,
+	.set_efi_variable = cs_amp_set_efi_variable,
 	.write_cal_coeff = cs_amp_write_cal_coeff,
 	.read_cal_coeff = cs_amp_read_cal_coeff,
 };
-- 
2.47.3


