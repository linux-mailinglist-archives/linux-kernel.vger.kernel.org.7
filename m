Return-Path: <linux-kernel+bounces-729879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68545B03CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5543AE077
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129DF2459F7;
	Mon, 14 Jul 2025 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="eMn9DzTK";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="mTds+LmY"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012AE244668;
	Mon, 14 Jul 2025 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490943; cv=fail; b=ajmZh8mmVrrKAq1atLshmLO7efXATRyOcG9D7DplVtYLEcp2y98rBTUMbruAyJtFPqLwso2o88IizhP70o+OErar0nQ8qKVPS2/HZ7UysRQrvtiXXLYJlgZ8Q6jrm1o1QYh9LrLE2lqBFlLueSNlZL+kq+PyZ80c8CSb/S0WU9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490943; c=relaxed/simple;
	bh=32M38ZM0vM9AXgEo/aMCUvhXp7wXfnV6WYuGKV6a8Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AqYZSV44UX3RY35U2spcA0q8pk7CTmTkGqX7n5J0f0TXXSq22dZTZZe0xS5H92T72xt+gPmhkI9zQQvmCOk90Z22n0glUNveccMeb3icZwUX/3nlw4eEp4ExmYOwmO/UfpZy/8jCMFTi7d8n+/gxSILuE60zJNtBR+KdHkxTW2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=eMn9DzTK; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=mTds+LmY; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E4mXnu005105;
	Mon, 14 Jul 2025 06:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=itT5DRiJ4Di4PhaX
	3NqFWhcIPDex2DnuDR2YjTAkG8A=; b=eMn9DzTKP58ERsKdYXuaaH3RYJUvbFis
	Ks4BzPBkDqZsqYZaX7bNmSEdzRzVAGAJw1V0yRlurU/Ib60UFtqdQMVkk6WyNeiI
	gN3XxzpOF3FylRfvRSbzxlhe5ZcLMSR6kD0MAVfDuoFKMbmpyojd2ucpVX1y6ezr
	Sx6IMwnswMUW574Zw0v9C1L0bcd7nwr3OD1xyQhtC6uW8APlR50O9t748wybTmMP
	CsNiOJHYT6g1NCdOO5tYHDGPJf0m9kq3k+C1GPPq56qGC9glF5jeEJEMxcFYUunV
	knBMVFHiMr9FpTD+mV0OxzeLG0Z+pEo9GEIX62ap0MIyv6XRdGSMwg==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2114.outbound.protection.outlook.com [40.107.212.114])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 47un42a9nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 06:02:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/o0m+A6EGmOlbCPtu8BlKpToBIybZ7HS3vwsuUWJCpkl14iUFai3L1svuJlHkkDWLIdJTYrz4t5SHCv1AmhlDZCNvJyJHlOpSOBxYmfArwHdO+UOiTJhaNyyQ72yLD+iPWY5uSOegFC08B+dHvI96hnTzOI7eVGWPn6adI2SedydfVjT5j42uzZUK3EPfzgVhgh4CYOz8/sFC4GK+AfBIhjQA4XXdc9cPV6Qk4A33tFL4wchKevYG117dblu5Uml2UTS+Z8LaOWXmkzXc8ilcobrJHG/WpZQtRVLh/oMFzp98i8Lb8yI4xDifjkwXY/bbbkcRsOcKvr4KDsiRvSYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itT5DRiJ4Di4PhaX3NqFWhcIPDex2DnuDR2YjTAkG8A=;
 b=gxwo1fKgqlK7wvp/hooUGfk0nnUnhA5UTXyWlTLvql5WcH924G62jApNygnAARxLJPOGBeMpbemkiiAStLm6gd87m+RaZi6ElUnmeFPyrloSE9Ie7yYE4fZB5CYWWvb2F6+kznAFnZv2Oer2h0d7puBnhp/YiaweNcWuyTY77TGp0aJfv2ZRBQJ+05ujDSq+ygb8J1uDd8pfoHSKLtlFRUHiYiqAtDR5PV0FUHePetr+3A/5FGrWAL87NS1aUBQU0oXa4yPVS+M8EfC8gFYtGtffSK17gqJYcbhq1VSlND9ifI8/VpvDYP1pjzKRkOF1FL8ZXWA/hpk69HQskA5clg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itT5DRiJ4Di4PhaX3NqFWhcIPDex2DnuDR2YjTAkG8A=;
 b=mTds+LmYpgAyv85aBXnUP8NxRGGEpHuvBFwG93lMBf2I5yn9AkwOTYWjnDHCMtDgs3GhpRMa0z/uPVXMJY7zfCS6ZmzkSWu9ZL6stOZOw+GVZGh1aTfWIzgtSgx4K958G4G8qbTTipYGZYAPKMDx06TX/M71YZbjFFPt6nyjDz4=
Received: from MN2PR06CA0015.namprd06.prod.outlook.com (2603:10b6:208:23d::20)
 by CO1PR19MB5206.namprd19.prod.outlook.com (2603:10b6:303:f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.16; Mon, 14 Jul
 2025 11:02:06 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:23d:cafe::23) by MN2PR06CA0015.outlook.office365.com
 (2603:10b6:208:23d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 11:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.1
 via Frontend Transport; Mon, 14 Jul 2025 11:02:04 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 9CE69406540;
	Mon, 14 Jul 2025 11:02:03 +0000 (UTC)
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.90.194.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 077DE820249;
	Mon, 14 Jul 2025 11:02:01 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH] ALSA: hda/cs35l56: Workaround bad dev-index on Lenovo Yoga Book 9i GenX
Date: Mon, 14 Jul 2025 12:01:54 +0100
Message-ID: <20250714110154.204740-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|CO1PR19MB5206:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 496b483d-f927-4087-b615-08ddc2c5de22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mdXlxAG69UlKrHhQGKinMO2XLYB/bL+vDc2iv/u2GVfpvtmqByPiqYMCsCdx?=
 =?us-ascii?Q?EplZuY00+i1F89iq//cEOf6LO+KfzB/MYi4QJUhW6043YNolcG2bzHzEKd56?=
 =?us-ascii?Q?W09JEPlkY0buxnhTSx/Fdy3A1I0ZoPazqpOXTaoUrkh1AP90K1t2qv9OHluc?=
 =?us-ascii?Q?BGqlAhwREajRMX3nKOr6H5wO4+IiZZDJi6HvSIllVq83mFmcR225kJ6syhBz?=
 =?us-ascii?Q?9EYO23q1a+5PvEIYULlBZZ7IQBCBjXtaxf/fE4QEJzUHuHtROgZYcfjqwPKG?=
 =?us-ascii?Q?NMGLVQVdSQYCToaEpnwxFIX1eebqfbfOY8DvfO+ltotYx28s0R6SKcv0tf8y?=
 =?us-ascii?Q?mXALrdAHAjvDMF6zAVPS+yo7wdhdOzYom7YSU8BJI7BxX8oMMTXUR8/d4R7G?=
 =?us-ascii?Q?jTplhgSFtk8Z65E+2tec5RYkcRrJfWFBd3PeNBF5N2vTxj4cIaHdQlU18kJX?=
 =?us-ascii?Q?kfvQsE9+a1fFzBKfiLACQzhQ6xD2UqbIsSdntYTO70CReEnPzoWX7mbKEWhm?=
 =?us-ascii?Q?s/qT4cXMkfaA06Mn3Wuhq7oq+JupKelPVOm6Pk1jD1e5oep7FLzk5zuCGFA/?=
 =?us-ascii?Q?9wu8Ukviy2Yc/t+cZ+8Q0+1Uo9FkNLaFTxkoVLj0gif7HS01G1O1Hxx2x00P?=
 =?us-ascii?Q?rV1y9qFN1vGxwL3c5yxphq5LgT4QV6l8xD2zI+sKaFce1xND5Mm5/LyDFPKl?=
 =?us-ascii?Q?1oGr5Y5G6g7Zjgl45kIutnietNf+39Ty3zV+iBpaqwNVdsQiYg7qK3LKWWcs?=
 =?us-ascii?Q?yrFFuvTuqCbBv1oXcrTllm+EwjLbC8NbUcAnLrbbEcxqlowwEHFZuSfNigpb?=
 =?us-ascii?Q?NjpHKYc/tYtgt44Vi00KamZIAeygpYc7PHFWefsWPzDjiCoxdBA2w9QDu6S1?=
 =?us-ascii?Q?XGuqb7I5czBouY0XjO8uxRESf/Fu6yRvFAWthihBcaDWosArFblXSEcwuAsO?=
 =?us-ascii?Q?5o9OtRT8AUMahWd3H+tcOSV9Pgk9yLusoKkpZ0WQl5YPUgaHlTdVnrIVt4c/?=
 =?us-ascii?Q?Y6SNw1TMRhBjn9hZ1wh9E/sYZeXRZdiOr+XT6JIvodOr3jMti5VxvIAhKKip?=
 =?us-ascii?Q?Dpnv1VHKQQwUon6VCfYqICWaF6LX9mi2kp81paYvKgrbyugof0cCc64ZOB7F?=
 =?us-ascii?Q?U231jjz/LOcTrDlRg8mkgAr1en2YVAld1yd5kPofOKnXpO+cmyPzZWBQLS+r?=
 =?us-ascii?Q?99u+pe9wNr/xKLCh4qG7lL1KSRQz9/fAs6ZHVmGsxgEYqMn4xtL6oTSTfS6D?=
 =?us-ascii?Q?moFy8sSLPNUdG0wfIVKckwMxVQX83Fib7cD70Qkxhv/rJIkAqF1V+ukZeLCK?=
 =?us-ascii?Q?cRUtWUq/04/RFifv5Z9vSGYC22G5dnB5xHSbHa/e41Iiq/CyQo4/jKwHeCOM?=
 =?us-ascii?Q?lAQwzwe1TEiUw4FtEt3SB0Rnh1gJn8SwY8CQ2O3eWeAhBn5gIJVOVVtcKnD7?=
 =?us-ascii?Q?09XRJosw7an28IgNwyZJeIvajSVyC1oSBJ4HDCV64/daTVZMnTVORi1JMLCl?=
 =?us-ascii?Q?FzGOnouXaOUcR92nqO8M9WC5qDpOIMq0qu+V6/1Qb/h7pfIAB0cc3RbxAQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 11:02:04.5493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 496b483d-f927-4087-b615-08ddc2c5de22
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB5206
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA2NCBTYWx0ZWRfXwiq3FMffk9YL 8PRmWlS4pojtCgBHgeAgfiDUTxweGcY3AOQVNOD6ww9p+uslWIVjFeF5s4Qs6H1PQ5BCs+ZvBPc wo0EFrrMK5j2mm/o9Sx9+jqKdR9UNm3yD/skSeCPdMCXmiVsOkBinqjI1qR9w7uRCDsHCmxQMjn
 vV3IqdEkUfb0kqYIpUOEllECvEH7AOxDbQ6iVagq5Tjpmdr8NHWu4w+tEzyRLnXBrOPTx396FX3 KXGkb4r1HwAgA0JuvV86FVsO3UzgQLtGA+958+VR+PhiGBJFye9w1RzF9tlfoVJ38KsqZCwITrU 5isgX73yX/EFHLjPTJgI3OeXOaNvzZTfhVbnSuAP2Pds8qbCGqXFYO+OC73juDD4hVsA9AYu9SW
 0cgEiiXeGwCiaT53DNMjVDv7DuSoI86yFgstVmwdwvHX3eHX9XZsuT+KaonOFqhHzoggcuvg
X-Proofpoint-ORIG-GUID: 9KdwDK4fQmkHCQWK5ZweOxFmcRLEaOp3
X-Authority-Analysis: v=2.4 cv=F6tXdrhN c=1 sm=1 tr=0 ts=6874e3b2 cx=c_pps a=5HJYKXKL7ZUh0UQAKaNj8A==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Wb1JkmetP80A:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=pGLkceISAAAA:8 a=HlEgHlYANQK5sGcjT1QA:9
X-Proofpoint-GUID: 9KdwDK4fQmkHCQWK5ZweOxFmcRLEaOp3
X-Proofpoint-Spam-Reason: safe

The Lenovo Yoga Book 9i GenX has the wrong values in the cirrus,dev-index
_DSD property. Add a fixup for this model to ignore the property and
hardcode the index from the I2C bus address.

The error in the cirrus,dev-index property would prevent the second amp
instance from probing. The component binding would never see all the
required instances and so there would not be a binding between
patch_realtek.c and the cs35l56 driver.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reported-by: Brian Howard <blhoward2@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220228
---
This patch is based on 6.16. I have tested that it also applies on the new
HDA structure using a 3-way merge.
---
 sound/pci/hda/cs35l56_hda.c | 114 ++++++++++++++++++++++++++----------
 1 file changed, 84 insertions(+), 30 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 235d22049aa9..c9c8ec8d2474 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -874,6 +874,52 @@ static int cs35l56_hda_system_resume(struct device *dev)
 	return 0;
 }
 
+static int cs35l56_hda_fixup_yoga9(struct cs35l56_hda *cs35l56, int *bus_addr)
+{
+	/* The cirrus,dev-index property has the wrong values */
+	switch (*bus_addr) {
+	case 0x30:
+		cs35l56->index = 1;
+		return 0;
+	case 0x31:
+		cs35l56->index = 0;
+		return 0;
+	default:
+		/* There is a pseudo-address for broadcast to both amps - ignore it */
+		dev_dbg(cs35l56->base.dev, "Ignoring I2C address %#x\n", *bus_addr);
+		return 0;
+	}
+}
+
+static const struct {
+	const char *sub;
+	int (*fixup_fn)(struct cs35l56_hda *cs35l56, int *bus_addr);
+} cs35l56_hda_fixups[] = {
+	{
+		.sub = "17AA390B", /* Lenovo Yoga Book 9i GenX */
+		.fixup_fn = cs35l56_hda_fixup_yoga9,
+	},
+};
+
+static int cs35l56_hda_apply_platform_fixups(struct cs35l56_hda *cs35l56, const char *sub,
+					     int *bus_addr)
+{
+	int i;
+
+	if (IS_ERR(sub))
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(cs35l56_hda_fixups); i++) {
+		if (strcasecmp(cs35l56_hda_fixups[i].sub, sub) == 0) {
+			dev_dbg(cs35l56->base.dev, "Applying fixup for %s\n",
+				cs35l56_hda_fixups[i].sub);
+			return (cs35l56_hda_fixups[i].fixup_fn)(cs35l56, bus_addr);
+		}
+	}
+
+	return 0;
+}
+
 static int cs35l56_hda_read_acpi(struct cs35l56_hda *cs35l56, int hid, int id)
 {
 	u32 values[HDA_MAX_COMPONENTS];
@@ -898,39 +944,47 @@ static int cs35l56_hda_read_acpi(struct cs35l56_hda *cs35l56, int hid, int id)
 		ACPI_COMPANION_SET(cs35l56->base.dev, adev);
 	}
 
-	property = "cirrus,dev-index";
-	ret = device_property_count_u32(cs35l56->base.dev, property);
-	if (ret <= 0)
-		goto err;
-
-	if (ret > ARRAY_SIZE(values)) {
-		ret = -EINVAL;
-		goto err;
-	}
-	nval = ret;
-
-	ret = device_property_read_u32_array(cs35l56->base.dev, property, values, nval);
-	if (ret)
-		goto err;
-
+	/* Initialize things that could be overwritten by a fixup */
 	cs35l56->index = -1;
-	for (i = 0; i < nval; i++) {
-		if (values[i] == id) {
-			cs35l56->index = i;
-			break;
-		}
-	}
-	/*
-	 * It's not an error for the ID to be missing: for I2C there can be
-	 * an alias address that is not a real device. So reject silently.
-	 */
-	if (cs35l56->index == -1) {
-		dev_dbg(cs35l56->base.dev, "No index found in %s\n", property);
-		ret = -ENODEV;
-		goto err;
-	}
 
 	sub = acpi_get_subsystem_id(ACPI_HANDLE(cs35l56->base.dev));
+	ret = cs35l56_hda_apply_platform_fixups(cs35l56, sub, &id);
+	if (ret)
+		return ret;
+
+	if (cs35l56->index == -1) {
+		property = "cirrus,dev-index";
+		ret = device_property_count_u32(cs35l56->base.dev, property);
+		if (ret <= 0)
+			goto err;
+
+		if (ret > ARRAY_SIZE(values)) {
+			ret = -EINVAL;
+			goto err;
+		}
+		nval = ret;
+
+		ret = device_property_read_u32_array(cs35l56->base.dev, property, values, nval);
+		if (ret)
+			goto err;
+
+		for (i = 0; i < nval; i++) {
+			if (values[i] == id) {
+				cs35l56->index = i;
+				break;
+			}
+		}
+
+		/*
+		 * It's not an error for the ID to be missing: for I2C there can be
+		 * an alias address that is not a real device. So reject silently.
+		 */
+		if (cs35l56->index == -1) {
+			dev_dbg(cs35l56->base.dev, "No index found in %s\n", property);
+			ret = -ENODEV;
+			goto err;
+		}
+	}
 
 	if (IS_ERR(sub)) {
 		dev_info(cs35l56->base.dev,
-- 
2.43.0


