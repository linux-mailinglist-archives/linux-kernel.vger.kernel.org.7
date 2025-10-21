Return-Path: <linux-kernel+bounces-862676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D691BF5E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA2CC4FD874
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8685032E745;
	Tue, 21 Oct 2025 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BTNR2jSM";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="ym4Z/yg2"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C265E32C935;
	Tue, 21 Oct 2025 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043839; cv=fail; b=lVN8BNGXIflOL89QyfAKbH3epWgRtZ7ubU/YT/VWEYuOeHnBIsBCXXH9T4d7ll/3vKgsFhjaBQe91y9KK53b8s2eC2ArQHvryhXGnmDkQIlHQ5sWtB6fmC/4MSfLNRtIsZBQeBhcbY36zas/i/i1imA6wvyNnRmwZbN5SS95M24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043839; c=relaxed/simple;
	bh=nipDsDkuk1QvDFyL42evDMtR2DmL03RSUWvc1B0X/IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIkDMPReofJPEGLYmuTXix6yqUHURq1bFaHk9sr6ZiQHowBucDAON9MxNZn3fyRtL7WeLbFwOT/TENb7JJzdtH/1m1GCty7rA8aINnqlOUcvEyh0wDzVDtIa2ETz+YH8Kb32HV438Q/3a/kV0D8VY+IdBh2lNNO2Y+fu6ZfQ2sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BTNR2jSM; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=ym4Z/yg2; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59L9021r941361;
	Tue, 21 Oct 2025 05:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=W/2VS7P03zRrZVR2i2nKw5NrfvIPu/CruEGB6xUCfbE=; b=
	BTNR2jSMUODGfEG60sqMbSxJK1oNj+a7ZkkhfohFjPhpOkqUBzTwYOrMfPsF96RB
	PCcwYPV6HETRBeUq8KfDBh/vqKwCWoVLKpomez80kqWPODZSWhGvQYHpfte/2KJK
	vR9zTtketcMyOk1+sNCCd5mmFZMPul2lLvsTqaE3fH0NAS1kpaCb/ASmziYAN7zR
	bjZRHoucVG6ADqgMjsEDWD+ocOVom379LwZfkgyJ2urZzdai+xjIZ+dAr4YF1M8B
	2PUjx9qrqXgGXIKGnrWmBud5B8RexWXO4DqBo1cl34PBNN8RCgFuxdrmZhAhFSze
	L2j7CRurV1UGg3ONDI5q2Q==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021090.outbound.protection.outlook.com [52.101.52.90])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49v7aj3eg5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 05:50:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlInu4GHVOfHaSQVPkuSOO4Zh3KqkegE611s97o5ZlkuAd9o5QkXD7OxJJw4w10Ic35BKo48gsODW00BHdXEhTJ17/ZG7r0uRdR88yOvSP6yITIEB51fFJPaFmmVIx7RXhQTepBmMo3w7B0/MVfw5yvJftlabGzXS7uALgn5VlUvzfL5axKf3IQsrSLA6gG1k6hyijNE60nsMiDe5QBC6dR1Blad9ZePm61z5DbbAT49zFUqiFq9ZIshl6rSN58KtePW2vO+3uG0bt51bSna4hlroE/fawwRGzj5LvUuk2a7ZM4CpgTkakf7dG/5agRC2e8G+/xbICfzPGt58iJ3wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/2VS7P03zRrZVR2i2nKw5NrfvIPu/CruEGB6xUCfbE=;
 b=fY7iVxUPY3yVk6NAV11hKpQcLePizdJ2VUkzlxD1G3u39/YeiEJKLNrDU2IhxNIlSMdZKapVSohT/0sio4B1s1NKEV86RRyqOAaOojHsht8yTgKSf+M2EpU7X97Ue2w4zvMaybOnOo0/jOEjt6yBd+WToJzyUJQcg+Rwf2l0lONON4YpIVOtbvoBmQ3gEpYzze7RL+2RD9muQAnzFRLJoVTV8pcmngFwkqlhdKdwoIT4Tf7Eu1zEKhZjjrSFtgG//v0gZ45R7WkfP0NkogtgsSs1oFdZ5kEfDQjsQ3pMK2TR27phdIduBuhLRrWVK+LVQc4DCtkrOq3ddsAyhYr/8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/2VS7P03zRrZVR2i2nKw5NrfvIPu/CruEGB6xUCfbE=;
 b=ym4Z/yg2sFjM4Lb3pt+s6Ik0SBb5stVG9iDwBNd6rf1by3RctNzA4R0fI6kUw3iF1Hs5jrLUJvqedmzkgcWoPQ8iTdOHy2tmKS8qy2lFdIJOKYwk41QMSYNgdnGaNdRk6oVBbap+afhlEUDLd6hdjRvrSfwTl4Zb6MUy5BnSe4g=
Received: from BYAPR21CA0004.namprd21.prod.outlook.com (2603:10b6:a03:114::14)
 by PH7PR19MB5751.namprd19.prod.outlook.com (2603:10b6:510:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Tue, 21 Oct
 2025 10:50:25 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::37) by BYAPR21CA0004.outlook.office365.com
 (2603:10b6:a03:114::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.4 via Frontend Transport; Tue,
 21 Oct 2025 10:50:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Tue, 21 Oct 2025 10:50:24 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id ADFFF406553;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 70699822542;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH v2 03/11] ASoC: cs35l56: Add common code for factory calibration
Date: Tue, 21 Oct 2025 11:50:14 +0100
Message-ID: <20251021105022.1013685-4-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|PH7PR19MB5751:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 57e29a28-97a3-48a9-9a51-08de108fa397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?izatq5Krsa+QDTZHFltbvfRgSANY0KV3yfb5M1OuaPDyuCqELpbXYsXLSefC?=
 =?us-ascii?Q?YwFsIP02TGPQnPe09JbqubpgKdTjWAyzbQMnevlTu11+ZjT9SrxsCHmkb5re?=
 =?us-ascii?Q?samZuqGV1cSFt2TNAEcic5f2AMWa4jHf7WdyLoU2N525dXXL9hmY1qSuvsau?=
 =?us-ascii?Q?MRpTsKr8HvWP2zHX4Cr35eBzoo1E4iD+evKkbGQqe+s99yHNV3h/hOwP9Lx1?=
 =?us-ascii?Q?qLt+haRPPPKKQAixSwTBmzWjGueWKo4gV3BKopmA6mmEHPdZkRh6MIhlKWnR?=
 =?us-ascii?Q?0UAr32qQcrJoNmbVdXNgJtAeBbu9/SJ2akMnAP1dVLNAGIAv2GocOjU6XNTT?=
 =?us-ascii?Q?dBq8Y2tYKnjxLGJO4fhURHRTYhvvD8+6nwqlPvpjKM1yi/rSU2Y4ovMS0NFr?=
 =?us-ascii?Q?lY7+Ij/zXFx5vnt7e/H0JbXxHZeIvsfPPLQWD8haBqlRFoq4dCu18bXmt0uK?=
 =?us-ascii?Q?Xg6k/flDcuZuIsqFfA4lgMmDvmrEaHbbXJ0YB6VuEaJSZdbQTd3W1t6D6OaE?=
 =?us-ascii?Q?/LeivtMaezrw2PU6P3EyYMDiGQQEJh1VdKuBQHoNPA4KC0AGLJ5V8cXoUqwI?=
 =?us-ascii?Q?ZUsbq6rDZweo2z9bzCm4383e5GspqoxR4u16nks1LBnFpe0HfG00FPa9w/41?=
 =?us-ascii?Q?AB/wEiLVMCk6CnXBSK3hSuZkjT5qUvmOSD/ZoWl8XxZpJUzwbRDyeKbptaj3?=
 =?us-ascii?Q?lRe+rb8yJDzOAPdLpgnWUR84pcOw6cMRImlY9mpP4AuENzsx/hLYQ7Py5X5x?=
 =?us-ascii?Q?sxj5Q4z5chrJlPM1LZp5jYFXB56kHp4DqrgpOl41gGKhFoqou10qLyJr6KXi?=
 =?us-ascii?Q?opTFVTqhCs2XFpIPbuNrSrGNAAiqzKHaK5UFDWke36lFOZt4WkOd9r8XoWfm?=
 =?us-ascii?Q?XG911QqroAlBlWbwYDHT8PMYASJzI3MPmIuxCgiQfek8p2uj3QZoBtvNdDck?=
 =?us-ascii?Q?ucs3gxAZ15K99y+wUEq4GUnOFSMUIid3vkua6f484g4kzQtlzKG76hZzhGlw?=
 =?us-ascii?Q?2899qUwckFWzo/7vgeSyjedTJc4xnssDeAkBH2/DGwmAl2Tj3vbkFml3NH0R?=
 =?us-ascii?Q?GIA0bkbIJBn4WORnvdV9CWH5IuiDTifB9vC8FiPofIt4o8mcEjQnWtqCnWOZ?=
 =?us-ascii?Q?mj0eq2U9ogoQ52KjKZwpZHRjO53p6U014G29Mm6/9o8JsmhwgOP22O5VFBDn?=
 =?us-ascii?Q?NNiRmnRTPWU7HwlWkGpLK4rXArBDKl6EKwp5W0aPla8ttK2KJwzPuKKoSVZC?=
 =?us-ascii?Q?aYp0NRAleflExGlvj5f711c/8oOKvzhp+yarsi5DNZfjRpsfFnCiXy98gUlu?=
 =?us-ascii?Q?PdV55Fk1M6+PToeOf941jWZVSarMzQZRI9lEFXUPPMYqdYCr3Sg/9VYOkRVc?=
 =?us-ascii?Q?+jnof8edSzHjTbUIBcZNUV3n8BHXmIHk0d09pYlC/31HY2XFbKECC5lL7yup?=
 =?us-ascii?Q?sKh4F7oDggD2mBAaUzSqnMDyrMv4FzkkJHCOsbJggXZjxFBhxRjn092f6YIc?=
 =?us-ascii?Q?ti/9Zz9X3CYfkuFUkUDBunxcYPUCg85zFWzUkvItbVJz0tssl2R1pRzw5vGA?=
 =?us-ascii?Q?bKWQFZLl/jRddfNXSAk=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 10:50:24.0828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e29a28-97a3-48a9-9a51-08de108fa397
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5751
X-Proofpoint-ORIG-GUID: snNYJtQ0DAG7Rz_8apg-ns7xiVJJmuyB
X-Proofpoint-GUID: snNYJtQ0DAG7Rz_8apg-ns7xiVJJmuyB
X-Authority-Analysis: v=2.4 cv=bdNmkePB c=1 sm=1 tr=0 ts=68f76577 cx=c_pps
 a=i3X4t2Xqt3CcVAOequVlKw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=1V4PQ12dt87U5XisZtsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDA4NSBTYWx0ZWRfX7Kwb235mEFSN
 KRD/dT/31rDml0+f1LYIhVL7H596T9P1lCsb4ytckWw6VFP4UtQwcZ+39iqD9mYy8ArmJ870gIX
 u8861ao4Sw+5or4F9lt8tBFeulvu19dogZP0Glcs0XtoLhsjycrrXgWBW9MQD9KAbwivDWFNcf5
 r5WAIJqwGt87W8lZ4cvd6BtOH/65KPKruIRH8s1aNg+dqqBo93dqlTqSN2KehvC45f/kVg88RWF
 E6kzD04LONm30HY2voRKeSTM62bSEQlCJvqY4GbICY5iwN4Sw+lhdruVWGTWKVkkjeK13urLtM9
 4AZ90FAfxXClf8FuIVucDmDNJzAXRDGSPTmm+MxZjvyxmEHRhRgvfZoB+W18VGhfVKbrGg6VyKo
 xThzAaY6/NVcdHsNB3iniC4j0HVAew==
X-Proofpoint-Spam-Reason: safe

Add core code to support factory calibration. This can be used by both
the ASoC and HDA drivers.

This code consists of implementations of debugfs handlers for three
debugfs files used to start factory calibration and read the results.

This is not a full implementation of debugfs files. There are some
requirements to synchronize with the rest of the amp driver, and the way
this is done is significantly different between ASoC and HDA. Therefore
cs35l56-shared.c provides the main part of the file handlers, but the
files themselves are defined in the ASoC and HDA drivers with suitable
handling before calling into this shared code.

The cal_data file allows the calibration to be read and also for a
previous calibration to be written (for systems where the storage is not
something directly accessible to drivers, such as on filesystems). Code
outside the kernel should treat the content of cal_data as an opaque blob,
so the struct definition is not exported as a user API.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
Changes in V2:
- File callbacks rewritten to be debugfs callbacks instead of
  sysfs callbacks.
- Added a function to create the debugfs files.

 include/sound/cs35l56.h           |  33 ++++
 sound/soc/codecs/Kconfig          |   3 +
 sound/soc/codecs/cs35l56-shared.c | 300 +++++++++++++++++++++++++++++-
 3 files changed, 331 insertions(+), 5 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index ec9b1072d6be..349b896ee737 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -9,6 +9,7 @@
 #ifndef __CS35L56_H
 #define __CS35L56_H
 
+#include <linux/debugfs.h>
 #include <linux/firmware/cirrus/cs_dsp.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
@@ -62,6 +63,8 @@
 #define CS35L56_IRQ1_MASK_8				0x000E0AC
 #define CS35L56_IRQ1_MASK_18				0x000E0D4
 #define CS35L56_IRQ1_MASK_20				0x000E0DC
+#define CS35L56_MIXER_NGATE_CH1_CFG			0x0010004
+#define CS35L56_MIXER_NGATE_CH2_CFG			0x0010008
 #define CS35L56_DSP_MBOX_1_RAW				0x0011000
 #define CS35L56_DSP_VIRTUAL1_MBOX_1			0x0011020
 #define CS35L56_DSP_VIRTUAL1_MBOX_2			0x0011024
@@ -177,6 +180,9 @@
 /* IRQ1_EINT_8 */
 #define CS35L56_TEMP_ERR_EINT1_MASK			0x80000000
 
+/* MIXER_NGATE_CHn_CFG */
+#define CS35L56_AUX_NGATE_CHn_EN			0x00000001
+
 /* Mixer input sources */
 #define CS35L56_INPUT_SRC_NONE				0x00
 #define CS35L56_INPUT_SRC_ASP1RX1			0x08
@@ -243,6 +249,7 @@
 #define CS35L56_MBOX_CMD_AUDIO_PLAY			0x0B000001
 #define CS35L56_MBOX_CMD_AUDIO_PAUSE			0x0B000002
 #define CS35L56_MBOX_CMD_AUDIO_REINIT			0x0B000003
+#define CS35L56_MBOX_CMD_AUDIO_CALIBRATION		0x0B000006
 #define CS35L56_MBOX_CMD_HIBERNATE_NOW			0x02000001
 #define CS35L56_MBOX_CMD_WAKEUP				0x02000002
 #define CS35L56_MBOX_CMD_PREVENT_AUTO_HIBERNATE		0x02000003
@@ -264,6 +271,9 @@
 #define CS35L56_RESET_PULSE_MIN_US			1100
 #define CS35L56_WAKE_HOLD_TIME_US			1000
 
+#define CS35L56_CALIBRATION_POLL_US			(100 * USEC_PER_MSEC)
+#define CS35L56_CALIBRATION_TIMEOUT_US			(5 * USEC_PER_SEC)
+
 #define CS35L56_SDW1_PLAYBACK_PORT			1
 #define CS35L56_SDW1_CAPTURE_PORT			3
 
@@ -291,9 +301,16 @@ struct cs35l56_fw_reg {
 	unsigned int posture_number;
 };
 
+struct cs35l56_cal_debugfs_fops {
+	const struct debugfs_short_fops calibrate;
+	const struct debugfs_short_fops cal_temperature;
+	const struct debugfs_short_fops cal_data;
+};
+
 struct cs35l56_base {
 	struct device *dev;
 	struct regmap *regmap;
+	struct cs_dsp *dsp;
 	int irq;
 	struct mutex irq_lock;
 	u8 type;
@@ -309,6 +326,7 @@ struct cs35l56_base {
 	struct cs35l56_spi_payload *spi_payload_buf;
 	const struct cs35l56_fw_reg *fw_reg;
 	const struct cirrus_amp_cal_controls *calibration_controls;
+	struct dentry *debugfs;
 	u64 silicon_uid;
 };
 
@@ -359,6 +377,21 @@ int cs35l56_runtime_suspend_common(struct cs35l56_base *cs35l56_base);
 int cs35l56_runtime_resume_common(struct cs35l56_base *cs35l56_base, bool is_soundwire);
 void cs35l56_init_cs_dsp(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_dsp);
 int cs35l56_get_calibration(struct cs35l56_base *cs35l56_base);
+ssize_t cs35l56_calibrate_debugfs_write(struct cs35l56_base *cs35l56_base,
+					const char __user *from, size_t count,
+					loff_t *ppos);
+ssize_t cs35l56_cal_ambient_debugfs_write(struct cs35l56_base *cs35l56_base,
+					  const char __user *from, size_t count,
+					  loff_t *ppos);
+ssize_t cs35l56_cal_data_debugfs_read(struct cs35l56_base *cs35l56_base,
+				      char __user *to, size_t count,
+				      loff_t *ppos);
+ssize_t cs35l56_cal_data_debugfs_write(struct cs35l56_base *cs35l56_base,
+				       const char __user *from, size_t count,
+				       loff_t *ppos);
+void cs35l56_create_cal_debugfs(struct cs35l56_base *cs35l56_base,
+				const struct cs35l56_cal_debugfs_fops *fops);
+void cs35l56_remove_cal_debugfs(struct cs35l56_base *cs35l56_base);
 int cs35l56_read_prot_status(struct cs35l56_base *cs35l56_base,
 			     bool *fw_missing, unsigned int *fw_version);
 void cs35l56_log_tuning(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_dsp);
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 160c07699a8b..6bb24325c2d0 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -896,6 +896,9 @@ config SND_SOC_CS35L56_SDW
 	help
 	  Enable support for Cirrus Logic CS35L56 boosted amplifier with SoundWire control
 
+config SND_SOC_CS35L56_CAL_DEBUGFS_COMMON
+	bool
+
 config SND_SOC_CS40L50
 	tristate "Cirrus Logic CS40L50 CODEC"
 	depends on MFD_CS40L50_CORE
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 1ecfc38d8eb4..eeb830e3f743 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -6,11 +6,18 @@
 //                    Cirrus Logic International Semiconductor Ltd.
 
 #include <linux/array_size.h>
+#include <linux/cleanup.h>
+#include <linux/debugfs.h>
 #include <linux/firmware/cirrus/wmfw.h>
+#include <linux/fs.h>
 #include <linux/gpio/consumer.h>
+#include <linux/kstrtox.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/types.h>
 #include <sound/cs-amp-lib.h>
 
@@ -206,6 +213,8 @@ static bool cs35l56_readable_reg(struct device *dev, unsigned int reg)
 	case CS35L56_IRQ1_MASK_8:
 	case CS35L56_IRQ1_MASK_18:
 	case CS35L56_IRQ1_MASK_20:
+	case CS35L56_MIXER_NGATE_CH1_CFG:
+	case CS35L56_MIXER_NGATE_CH2_CFG:
 	case CS35L56_DSP_VIRTUAL1_MBOX_1:
 	case CS35L56_DSP_VIRTUAL1_MBOX_2:
 	case CS35L56_DSP_VIRTUAL1_MBOX_3:
@@ -263,6 +272,8 @@ static bool cs35l56_common_volatile_reg(unsigned int reg)
 	case CS35L56_IRQ1_EINT_1 ... CS35L56_IRQ1_EINT_8:
 	case CS35L56_IRQ1_EINT_18:
 	case CS35L56_IRQ1_EINT_20:
+	case CS35L56_MIXER_NGATE_CH1_CFG:
+	case CS35L56_MIXER_NGATE_CH2_CFG:
 	case CS35L56_DSP_VIRTUAL1_MBOX_1:
 	case CS35L56_DSP_VIRTUAL1_MBOX_2:
 	case CS35L56_DSP_VIRTUAL1_MBOX_3:
@@ -724,15 +735,11 @@ static void cs35l56_issue_wake_event(struct cs35l56_base *cs35l56_base)
 	cs35l56_wait_control_port_ready();
 }
 
-int cs35l56_runtime_suspend_common(struct cs35l56_base *cs35l56_base)
+static int cs35l56_wait_for_ps3(struct cs35l56_base *cs35l56_base)
 {
 	unsigned int val;
 	int ret;
 
-	if (!cs35l56_base->init_done)
-		return 0;
-
-	/* Firmware must have entered a power-save state */
 	ret = regmap_read_poll_timeout(cs35l56_base->regmap,
 				       cs35l56_base->fw_reg->transducer_actual_ps,
 				       val, (val >= CS35L56_PS3),
@@ -741,6 +748,17 @@ int cs35l56_runtime_suspend_common(struct cs35l56_base *cs35l56_base)
 	if (ret)
 		dev_warn(cs35l56_base->dev, "PS3 wait failed: %d\n", ret);
 
+	return ret;
+}
+
+int cs35l56_runtime_suspend_common(struct cs35l56_base *cs35l56_base)
+{
+	if (!cs35l56_base->init_done)
+		return 0;
+
+	/* Firmware must have entered a power-save state */
+	cs35l56_wait_for_ps3(cs35l56_base);
+
 	/* Clear BOOT_DONE so it can be used to detect a reboot */
 	regmap_write(cs35l56_base->regmap, CS35L56_IRQ1_EINT_4, CS35L56_OTP_BOOT_DONE_MASK);
 
@@ -839,6 +857,8 @@ void cs35l56_init_cs_dsp(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_ds
 	cs_dsp->mem = cs35l56_dsp1_regions;
 	cs_dsp->num_mems = ARRAY_SIZE(cs35l56_dsp1_regions);
 	cs_dsp->no_core_startstop = true;
+
+	cs35l56_base->dsp = cs_dsp;
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_init_cs_dsp, "SND_SOC_CS35L56_SHARED");
 
@@ -942,6 +962,276 @@ int cs35l56_get_calibration(struct cs35l56_base *cs35l56_base)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_get_calibration, "SND_SOC_CS35L56_SHARED");
 
+static int cs35l56_stash_calibration(struct cs35l56_base *cs35l56_base,
+				     const struct cirrus_amp_cal_data *data)
+{
+
+	/* Ignore if it is empty */
+	if (!data->calTime[0] && !data->calTime[1])
+		return -ENODATA;
+
+	if (cs_amp_cal_target_u64(data) != cs35l56_base->silicon_uid) {
+		dev_err(cs35l56_base->dev, "cal_data not for this silicon ID\n");
+		return -EINVAL;
+	}
+
+	cs35l56_base->cal_data = *data;
+	cs35l56_base->cal_data_valid = true;
+
+	return 0;
+}
+
+static int cs35l56_perform_calibration(struct cs35l56_base *cs35l56_base)
+{
+	const struct cirrus_amp_cal_controls *calibration_controls =
+		cs35l56_base->calibration_controls;
+	struct cs_dsp *dsp = cs35l56_base->dsp;
+	struct cirrus_amp_cal_data cal_data;
+	struct cs_dsp_coeff_ctl *ctl;
+	bool ngate_ch1_was_enabled = false;
+	bool ngate_ch2_was_enabled = false;
+	int cali_norm_en_alg_id, cali_norm_en_mem;
+	int ret;
+	__be32 val;
+
+	if (cs35l56_base->silicon_uid == 0) {
+		dev_err(cs35l56_base->dev, "Cannot calibrate: no silicon UID\n");
+		return -ENXIO;
+	}
+
+	switch (cs35l56_base->type) {
+	case 0x54:
+	case 0x56:
+	case 0x57:
+		if (cs35l56_base->rev < 0xb2) {
+			cali_norm_en_alg_id = 0x9f22f;
+			cali_norm_en_mem = WMFW_ADSP2_YM;
+		} else {
+			cali_norm_en_alg_id = 0x9f210;
+			cali_norm_en_mem = WMFW_ADSP2_XM;
+		}
+		break;
+	default:
+		cali_norm_en_alg_id = 0xbf210;
+		cali_norm_en_mem = WMFW_ADSP2_XM;
+		break;
+	}
+
+	ret = pm_runtime_resume_and_get(cs35l56_base->dev);
+	if (ret)
+		return ret;
+
+	ret = cs35l56_wait_for_ps3(cs35l56_base);
+	if (ret)
+		goto err_pm_put;
+
+	regmap_update_bits_check(cs35l56_base->regmap, CS35L56_MIXER_NGATE_CH1_CFG,
+				 CS35L56_AUX_NGATE_CHn_EN, 0, &ngate_ch1_was_enabled);
+	regmap_update_bits_check(cs35l56_base->regmap, CS35L56_MIXER_NGATE_CH2_CFG,
+				 CS35L56_AUX_NGATE_CHn_EN, 0, &ngate_ch2_was_enabled);
+
+	scoped_guard(mutex, &dsp->pwr_lock) {
+		ctl = cs_dsp_get_ctl(dsp,
+				     calibration_controls->status,
+				     calibration_controls->mem_region,
+				     calibration_controls->alg_id);
+		if (!ctl) {
+			dev_err(cs35l56_base->dev, "Could not get %s control\n",
+				calibration_controls->status);
+			ret = -ENXIO;
+			goto err;
+		}
+
+		val = cpu_to_be32(0);
+		ret = cs_dsp_coeff_write_ctrl(cs_dsp_get_ctl(dsp,
+					      "CALI_NORM_EN",
+					      cali_norm_en_mem,
+					      cali_norm_en_alg_id),
+					      0, &val, sizeof(val));
+		if (ret < 0) {
+			dev_err(cs35l56_base->dev, "Could not write %s: %d\n", "CALI_NORM_EN", ret);
+			goto err;
+		}
+
+		ret = cs35l56_mbox_send(cs35l56_base, CS35L56_MBOX_CMD_AUDIO_CALIBRATION);
+		if (ret)
+			goto err;
+
+		if (read_poll_timeout(cs_dsp_coeff_read_ctrl, ret,
+				      (val == cpu_to_be32(1)),
+				      CS35L56_CALIBRATION_POLL_US,
+				      CS35L56_CALIBRATION_TIMEOUT_US,
+				      true,
+				      ctl, 0, &val, sizeof(val))) {
+			dev_err(cs35l56_base->dev, "Calibration timed out (CAL_STATUS: %u)\n",
+				be32_to_cpu(val));
+			ret = -ETIMEDOUT;
+			goto err;
+		}
+	}
+
+	cs35l56_base->cal_data_valid = false;
+	memset(&cal_data, 0, sizeof(cal_data));
+	ret = cs_amp_read_cal_coeffs(dsp, calibration_controls, &cal_data);
+	if (ret)
+		goto err;
+
+	dev_info(cs35l56_base->dev, "Cal status:%d calR:%d ambient:%d\n",
+		 cal_data.calStatus, cal_data.calR, cal_data.calAmbient);
+
+	cal_data.calTarget[0] = (u32)cs35l56_base->silicon_uid;
+	cal_data.calTarget[1] = (u32)(cs35l56_base->silicon_uid >> 32);
+	cs35l56_base->cal_data = cal_data;
+	cs35l56_base->cal_data_valid = true;
+
+	ret = 0;
+
+err:
+	if (ngate_ch1_was_enabled) {
+		regmap_set_bits(cs35l56_base->regmap, CS35L56_MIXER_NGATE_CH1_CFG,
+				CS35L56_AUX_NGATE_CHn_EN);
+	}
+	if (ngate_ch2_was_enabled) {
+		regmap_set_bits(cs35l56_base->regmap, CS35L56_MIXER_NGATE_CH2_CFG,
+				CS35L56_AUX_NGATE_CHn_EN);
+	}
+err_pm_put:
+	pm_runtime_put(cs35l56_base->dev);
+
+	return ret;
+}
+
+ssize_t cs35l56_calibrate_debugfs_write(struct cs35l56_base *cs35l56_base,
+					const char __user *from, size_t count,
+					loff_t *ppos)
+{
+	static const char * const options[] = { "factory" };
+	char buf[8] = { 0 };
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_SND_SOC_CS35L56_CAL_DEBUGFS_COMMON))
+		return -ENXIO;
+
+	if (*ppos)
+		return -EINVAL;
+
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, from, count);
+	if (ret < 0)
+		return ret;
+
+	switch (sysfs_match_string(options, buf)) {
+	case 0:
+		ret = cs35l56_perform_calibration(cs35l56_base);
+		if (ret < 0)
+			return ret;
+		break;
+	default:
+		return -ENXIO;
+	}
+
+	return count;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_calibrate_debugfs_write, "SND_SOC_CS35L56_SHARED");
+
+ssize_t cs35l56_cal_ambient_debugfs_write(struct cs35l56_base *cs35l56_base,
+					  const char __user *from, size_t count,
+					  loff_t *ppos)
+{
+	unsigned long val;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_SND_SOC_CS35L56_CAL_DEBUGFS_COMMON))
+		return -ENXIO;
+
+	if (*ppos)
+		return -EINVAL;
+
+	ret = pm_runtime_resume_and_get(cs35l56_base->dev);
+	if (ret)
+		return ret;
+
+	ret = kstrtoul_from_user(from, count, 10, &val);
+	if (ret < 0)
+		goto out;
+
+	ret = cs_amp_write_ambient_temp(cs35l56_base->dsp, cs35l56_base->calibration_controls, val);
+out:
+	pm_runtime_put(cs35l56_base->dev);
+
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_cal_ambient_debugfs_write, "SND_SOC_CS35L56_SHARED");
+
+ssize_t cs35l56_cal_data_debugfs_read(struct cs35l56_base *cs35l56_base,
+				      char __user *to, size_t count,
+				      loff_t *ppos)
+{
+	if (!IS_ENABLED(CONFIG_SND_SOC_CS35L56_CAL_DEBUGFS_COMMON))
+		return -ENXIO;
+
+	if (!cs35l56_base->cal_data_valid)
+		return 0;
+
+	return simple_read_from_buffer(to, count, ppos, &cs35l56_base->cal_data,
+				       sizeof(cs35l56_base->cal_data));
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_cal_data_debugfs_read, "SND_SOC_CS35L56_SHARED");
+
+ssize_t cs35l56_cal_data_debugfs_write(struct cs35l56_base *cs35l56_base,
+				       const char __user *from, size_t count,
+				       loff_t *ppos)
+{
+	struct cirrus_amp_cal_data cal_data;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_SND_SOC_CS35L56_CAL_DEBUGFS_COMMON))
+		return -ENXIO;
+
+	/* Only allow a full blob to be written */
+	if (*ppos || (count != sizeof(cal_data)))
+		return -EMSGSIZE;
+
+	ret = simple_write_to_buffer(&cal_data, sizeof(cal_data), ppos, from, count);
+	if (ret)
+		return ret;
+
+	ret = cs35l56_stash_calibration(cs35l56_base, &cal_data);
+	if (ret)
+		return ret;
+
+	return count;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_cal_data_debugfs_write, "SND_SOC_CS35L56_SHARED");
+
+void cs35l56_create_cal_debugfs(struct cs35l56_base *cs35l56_base,
+				const struct cs35l56_cal_debugfs_fops *fops)
+{
+	if (!IS_ENABLED(CONFIG_SND_SOC_CS35L56_CAL_DEBUGFS_COMMON))
+		return;
+
+	cs35l56_base->debugfs = cs_amp_create_debugfs(cs35l56_base->dev);
+
+	debugfs_create_file("calibrate",
+			    0200, cs35l56_base->debugfs, cs35l56_base,
+			    &fops->calibrate);
+	debugfs_create_file("cal_temperature",
+			    0200, cs35l56_base->debugfs, cs35l56_base,
+			    &fops->cal_temperature);
+	debugfs_create_file("cal_data",
+			    0644, cs35l56_base->debugfs, cs35l56_base,
+			    &fops->cal_data);
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_create_cal_debugfs, "SND_SOC_CS35L56_SHARED");
+
+void cs35l56_remove_cal_debugfs(struct cs35l56_base *cs35l56_base)
+{
+	debugfs_remove_recursive(cs35l56_base->debugfs);
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_remove_cal_debugfs, "SND_SOC_CS35L56_SHARED");
+
 int cs35l56_read_prot_status(struct cs35l56_base *cs35l56_base,
 			     bool *fw_missing, unsigned int *fw_version)
 {
-- 
2.47.3


