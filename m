Return-Path: <linux-kernel+bounces-856028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EADCCBE2F16
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07B91882518
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3FF32D421;
	Thu, 16 Oct 2025 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dEc3yf4N";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="JoiNbbhT"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF13632548C;
	Thu, 16 Oct 2025 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611390; cv=fail; b=qB9hwHkgP5/QDrE7ogvGDJmdLYeENACmHIV0Hd21MvWICLUlztZeM5n2/XXKQY7A91JN+QAHb7ZiuqUt8xsBZETOHzIWx+DVLXH1WamXamQA3gVJlJ2t99AIRbskISVfTF2Q4TjiZAaOeQe+nhZc5NJRv1EH67FGwm/+XM63AzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611390; c=relaxed/simple;
	bh=xe9isHURiGCSCnrPZv1iNkKHBJbtBslRmrIgkwQwQc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Er8DZFJVBCXok2VuEt0dbNUmS8AwRKmTVwmY898lFWrGBprZA6YbK9uPb88JzGRzq8kjCnWvvAJKVRvguVbizIrnpB7kzPfmKG6sz7xiK/jAA+2O8D/x+mw1fuTRFIjCjri19hYY6QoRN6k3Hc4LClp41i+F6NCLDiAUF8EgWd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=dEc3yf4N; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=JoiNbbhT; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59G9oCCV648147;
	Thu, 16 Oct 2025 05:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=K2q66aE5vwdHFLLDQ2AzsfwIuxcNDVy0+9Dpe54jNJI=; b=
	dEc3yf4NwAdEY02GidkHAgzGMPbq6hAQW9eH9J+offwNfxNwlzkREx8FkehEqew8
	VQ+CJE+mVHL/ZGl28wn4BtGZ5SppUaxN2hHG/zXniuGZYm83TVyrpOUziEWjb/QK
	YdhUDJx++f5V5ELejfQW/CSUC1Lrz0hxoz5c6KqYFYxC01upncUHlsgBvizTZObz
	wLV/Ao5OVPk7AgGlRdVUHMPSJv7IDscdUPNdxt53mqJeVDUB8UI5l+5Hl6ildsOK
	Fp0deEQEKz0rNMvRpZCLA/+DXUKqvnqRG/Joc1Jg3wK7AJ2KnbfQj3J+Angh0GsT
	Qgskb85FRFNDWFdXvDGF8Q==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022133.outbound.protection.outlook.com [40.107.209.133])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49sdb448a3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 05:42:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vq7bC3pA+8l1Z6ZlacNQKBhwh3ovn1Q81l+F80yRIUGHQzAryPczOSF0PLujvPklv5aiIsf7I0ogg8Im9HrnfTFEQWPWmERDAatAnSrg9p+C0q3RlwwA9nMT4HD9Yf/fBenHBppxmFbMeVu27V0vPgOPO/nnlUknIkYVL/qeKse9/dUtBnYXdgR7Rp0y0vp9k09NqPfUYFjzdzxu/KRkuGthrLFxuiGU3AKAEUJMZMkC8eiQ+xU5f4yRHEpUKniHVD08+VcswSGeYS6ch8yw9ad9RwoSofwKluBtCC7ZsS8CU8I9YxAlv0oE6LMoC4vvN4HYmap5fpusvpsq0YF2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2q66aE5vwdHFLLDQ2AzsfwIuxcNDVy0+9Dpe54jNJI=;
 b=SYkn3oXawKsL2IXTsHTupMrDDiQvQ9+fTL3+H9nSALVMqdCgXtl8EcCZUB1vazWaf15mN/DwlVAJP7U0BmqkKiCMAPjskpLiOsGCLZ45RVckeqrFRXfA3CUyOm3z2mBebBjz3T6SX3h+E4z6KQwVS04nGOBnFyux/nhMg0dK0Bx/2ovGsRMcgmiPFK87oZA8lnHxCtCmah84tuQHvaHWtjPABY0svNshmlBMVdoxfMQ6Qay29KF4qoYBO3EPnFYoi93jiChYl95OAXk7qnjohbjQ3eAhm/2YTj3WNfsLKxKr2lSLQvLhPm0MjSCG1XUga7jIKoCd4yI934EHZxwYvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2q66aE5vwdHFLLDQ2AzsfwIuxcNDVy0+9Dpe54jNJI=;
 b=JoiNbbhTEVpqzUZ6ICvMuOsAI5BD0OQSHKaWAk+FAVNhv563RrD6KC06z6HiDhUecxCaAd4kcVDEwceVwavwJVsWVzAe0XjbHCmsIrnZUYEEaSFNkrel1DUm3jpoE6hc4P9Xg6t0zA2gnkN0CljIwRahLLYrLMsoz6hkO4zdcJ0=
Received: from BN0PR03CA0037.namprd03.prod.outlook.com (2603:10b6:408:e7::12)
 by DS7PR19MB6023.namprd19.prod.outlook.com (2603:10b6:8:82::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 10:42:44 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::66) by BN0PR03CA0037.outlook.office365.com
 (2603:10b6:408:e7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 10:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 10:42:43 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id DB1D8406555;
	Thu, 16 Oct 2025 10:42:42 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id BED37822542;
	Thu, 16 Oct 2025 10:42:42 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 04/11] ASoC: cs35l56: Create sysfs files for factory calibration
Date: Thu, 16 Oct 2025 11:42:35 +0100
Message-ID: <20251016104242.157325-5-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DS7PR19MB6023:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d74a6c52-e409-41bb-17c3-08de0ca0bd0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?POfHs+Tf2ljNUdNXrTsP3y1uDXE03xI1dBPg1VZTkJiYUmm69iXh5i8S6ZdT?=
 =?us-ascii?Q?BBH/eqjZIW5+fY8Nrb/HWMS1otTaJi8zS2RKP3LiWI2jYKFN6P0mAb6gFlZi?=
 =?us-ascii?Q?0xkSBQJqBaUFZyGNTKK1Ln1S+T3tScPGE9PIlFoT5bUxxR7GKLzFI2bQTd51?=
 =?us-ascii?Q?5oXGL4aH5ZNmUfRfRKVtdUXxyumfLcKZnIJJnQhI1JRpGwyHHNBTOqfCHhce?=
 =?us-ascii?Q?LodiagZZ3+gI3r/ZZK2F/gXpf4SpMqnYCJYUCA0PSeZO0CUdNUjwUwidV+J1?=
 =?us-ascii?Q?FIaIzLhDWOAS3rZ6URG8fbmc9wNiDM1w6k84x59MvdcTveY4QHyyXClr/62F?=
 =?us-ascii?Q?JTXcZcfhdpGNR6j9FY1qlYYd0znqAqfsSDMv3Y/p6P+U9w26tuPo9fZ2nXKl?=
 =?us-ascii?Q?N04Oct0UqKVOqCiY5yNgFxqo2u4NVbrxQQWGhT6CKHAqeZHrkkG9PL7WL5qb?=
 =?us-ascii?Q?+RO8K2quieYDKzfEDphHWcVqCl9ejuZiyobnVU2YygXy+tOtndDs+IK8IfIw?=
 =?us-ascii?Q?alNVV9fOP9zPO3rOidBVwwqbsk/oP7dDxpraAsmRm5L4o6C8wT7aSL0VY61X?=
 =?us-ascii?Q?39ZgXqm5Oz7TECwIq5vPszzT3Qe8MrmcoUyfVw2IKLAFsAi7ujXGRJ5TETrl?=
 =?us-ascii?Q?WyNeZPwSYPbReKIFAyFI9XcAw+Djs6mt1ahj4ZSUSxm9/4nbpFS8oWL9f7yQ?=
 =?us-ascii?Q?n2JpDkPbgE7bw2n2SB+VjrT65cCVNvAlJw7nEffWQj4Joq1SIQf0fwEWkZzO?=
 =?us-ascii?Q?5sDPjQ8ORag30zw09D2hNqmLniYKjXIm+l/Q65BZQXHqRxlQxU+BGH515w9e?=
 =?us-ascii?Q?jrAGqQD/lHEyfh2VPa0p+Q7qUfCjbrYdJVL3gUgvV9WTveRAzzfEyNSNb3mQ?=
 =?us-ascii?Q?CsbuNRAgY5HJ6eumw8sWFo4KIm5TSf1J+0W8z74cho5Ou9TixAfM/dmTfwsv?=
 =?us-ascii?Q?J6zfXk1xHNNK/Sokti96qAMtNdj8lCneu6G+F6jIny34GPwna1V3+uHiJ7Un?=
 =?us-ascii?Q?wOFnqoXtLaVDqUSTqC/3hgKcyCLnBr1Mx/G/FkoOH8dyyRpYOkjYIZMnJ8Cm?=
 =?us-ascii?Q?+1m7OjOq++dmEg2woY8OE5tuz8QPME259Y4x2jHPUo0RSMOVTmb4p8i8zCMX?=
 =?us-ascii?Q?FYxW2uiw/WHWULoHPeOxVhiCdjH4lwRbYNEnmw+aD7zyRxTcV06gdz67M/wo?=
 =?us-ascii?Q?biRZ+sTyWEB0Ko051m55IwW+W8XdFGB5ROrDLtFh0AgdQk2tADMQPMeBn1Sn?=
 =?us-ascii?Q?m81SmVF52j84tq2Iueg+QkU10oX+tYZIYUeV1k7oRD7de6CePyLPhjHMbBM5?=
 =?us-ascii?Q?iWKmNsOGw/QYecu5JXgR8Aqu6/muskSNfZTnA/5qHwA9261T3N/LocXgRMHD?=
 =?us-ascii?Q?fltIXJxY23uglYlR3A17zDq5TYS7fCw7tbcuR3LGMIfZ2xuKWtIatH0LaqFE?=
 =?us-ascii?Q?U/WijqiaKR7l4f+x8cA6sJxsjpeHY573X2+Q8iBkfCeVgXJTEepNPyDHPSSw?=
 =?us-ascii?Q?zBQITcvtTp+rOavIEaIZY3eEc4JHbMWKaPjC0jx8KdBIW6Wp3A4R4Ey2q5vD?=
 =?us-ascii?Q?hZ8PfPSlxDBdpMS+uHM=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:42:43.7233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d74a6c52-e409-41bb-17c3-08de0ca0bd0e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB6023
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA4MCBTYWx0ZWRfXyHo2TYCt4yFJ
 zZMULgZ9EpZpE1LiZNflcNFxtytzrJAt4i6/6emoh8fQkdw2xbzRdrrQ82kVxnBJNOV4E45sWTj
 g/kxOpp4UrhdsPkNmlIEnh8JSY7fPpPlVCZPZZR2r8HYoSetofKpse70BDbuuWkSIILafrDUuD+
 n+FdTSvgm9/i74J0rjOgjeAUKrqCQQVTA0iraQLwxNeEual7Q0iDtxmV5lpCShCu0MqC4624UYC
 5q8aphzfygf0faiwjg/f1+4Pkduc+9GB++dUj3dqiSf5ttwx40aMWOuDZqhHVujrCyQk4cftDGc
 cvBgDhfMDgBTvaNzSRzxeOsf44KzfEc1uIeo5Y8wT255PS1Iz7Z/0yEWt8cHA4hfVdGefoH/wJx
 yGimkRNesW3lLykNInSm+KigG5iC/g==
X-Proofpoint-GUID: 0VUiJAzeQ0-YCXRmZIMe9yK3WvXKVQ-u
X-Authority-Analysis: v=2.4 cv=PPICOPqC c=1 sm=1 tr=0 ts=68f0cc2b cx=c_pps
 a=o+9IzLN2JPavfcgUIASn6g==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=pkDbqoULcYAe4JYMWOoA:9
X-Proofpoint-ORIG-GUID: 0VUiJAzeQ0-YCXRmZIMe9yK3WvXKVQ-u
X-Proofpoint-Spam-Reason: safe

Create sysfs files that can be used to perform factory calibration.

During manufacture, the production line must perform a factory calibration
of the amps. This patch adds this functionality via sysfs files.

Sysfs is used here to restrict access to the factory calibration.
It is only intended to be used during manufacture. It is not something
that a normal user should ever touch. Calibration affects the matching of
the amp hardware to the external speakers. If not done correctly it can
cause the speakers to be under-protected.

As this is only needed during manufacture, there is no need for this to be
available in a normal system so a Kconfig item has been added to enable
this. The new Kconfig option is inside a sub-menu because items do not
group and indent if the parent is invisible or there are multiple parent
dependencies. Anyway the sub-menu reduces the clutter.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/Kconfig   |  15 +++
 sound/soc/codecs/cs35l56.c | 182 +++++++++++++++++++++++++++++++++++++
 2 files changed, 197 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 5917bf5a72f8..4bb57223ef82 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -899,6 +899,21 @@ config SND_SOC_CS35L56_SDW
 config SND_SOC_CS35L56_CAL_SYSFS_COMMON
 	bool
 
+menu "CS35L56 driver options"
+	depends on SND_SOC_CS35L56
+
+config SND_SOC_CS35L56_CAL_SYSFS
+	bool "CS35L56 create sysfs for factory calibration"
+	default N
+	select SND_SOC_CS35L56_CAL_SYSFS_COMMON
+	help
+	  Create sysfs entries used during factory-line manufacture
+	  for factory calibration.
+	  This is not needed for normal use.
+
+	  If unsure select "N".
+endmenu
+
 config SND_SOC_CS40L50
 	tristate "Cirrus Logic CS40L50 CODEC"
 	depends on MFD_CS40L50_CORE
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 2c1edbd636ef..930991dd4b6f 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -10,6 +10,7 @@
 #include <linux/completion.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
@@ -22,6 +23,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/soundwire/sdw.h>
+#include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <sound/cs-amp-lib.h>
@@ -250,6 +252,8 @@ static const struct snd_soc_dapm_widget cs35l56_dapm_widgets[] = {
 	SND_SOC_DAPM_SIGGEN("VDDBMON ADC"),
 	SND_SOC_DAPM_SIGGEN("VBSTMON ADC"),
 	SND_SOC_DAPM_SIGGEN("TEMPMON ADC"),
+
+	SND_SOC_DAPM_INPUT("Calibrate"),
 };
 
 #define CS35L56_SRC_ROUTE(name) \
@@ -286,6 +290,7 @@ static const struct snd_soc_dapm_route cs35l56_audio_map[] = {
 	{ "DSP1", NULL, "ASP1RX1" },
 	{ "DSP1", NULL, "ASP1RX2" },
 	{ "DSP1", NULL, "SDW1 Playback" },
+	{ "DSP1", NULL, "Calibrate" },
 	{ "AMP", NULL, "DSP1" },
 	{ "SPK", NULL, "AMP" },
 
@@ -874,6 +879,175 @@ static void cs35l56_dsp_work(struct work_struct *work)
 	pm_runtime_put_autosuspend(cs35l56->base.dev);
 }
 
+static struct snd_soc_dapm_context *cs35l56_power_up_for_cal(struct cs35l56_private *cs35l56)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(cs35l56->component);
+	int ret;
+
+	ret = snd_soc_component_enable_pin(cs35l56->component, "Calibrate");
+	if (ret)
+		return ERR_PTR(ret);
+
+	snd_soc_dapm_sync(dapm);
+
+	return dapm;
+}
+
+static void cs35l56_power_down_after_cal(struct cs35l56_private *cs35l56)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(cs35l56->component);
+
+	snd_soc_component_disable_pin(cs35l56->component, "Calibrate");
+	snd_soc_dapm_sync(dapm);
+}
+
+static ssize_t calibrate_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
+	struct snd_soc_dapm_context *dapm;
+	ssize_t ret;
+
+	dapm = cs35l56_power_up_for_cal(cs35l56);
+	if (IS_ERR(dapm))
+		return PTR_ERR(dapm);
+
+	snd_soc_dapm_mutex_lock(dapm);
+	ret = cs35l56_calibrate_sysfs_store(&cs35l56->base, buf, count);
+	snd_soc_dapm_mutex_unlock(dapm);
+
+	cs35l56_power_down_after_cal(cs35l56);
+
+	return ret;
+}
+
+static ssize_t cal_temperature_store(struct device *dev, struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(dev);
+	struct snd_soc_dapm_context *dapm;
+	ssize_t ret;
+
+	dapm = cs35l56_power_up_for_cal(cs35l56);
+	if (IS_ERR(dapm))
+		return PTR_ERR(dapm);
+
+	ret = cs35l56_cal_ambient_sysfs_store(&cs35l56->base, buf, count);
+	cs35l56_power_down_after_cal(cs35l56);
+
+	return ret;
+}
+
+static ssize_t cal_data_read(struct file *filp, struct kobject *kobj,
+			     const struct bin_attribute *battr, char *buf, loff_t pos,
+			     size_t count)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(kobj_to_dev(kobj));
+	struct snd_soc_dapm_context *dapm;
+	ssize_t ret;
+
+	dapm = cs35l56_power_up_for_cal(cs35l56);
+	if (IS_ERR(dapm))
+		return PTR_ERR(dapm);
+
+	ret = cs35l56_cal_data_sysfs_read(&cs35l56->base, buf, pos, count);
+	cs35l56_power_down_after_cal(cs35l56);
+
+	return ret;
+}
+
+static int cs35l56_new_cal_data_apply(struct cs35l56_private *cs35l56)
+{
+	struct snd_soc_dapm_context *dapm;
+	int ret;
+
+	if (!cs35l56->base.cal_data_valid)
+		return -ENXIO;
+
+	if (cs35l56->base.secured)
+		return -EACCES;
+
+	dapm = cs35l56_power_up_for_cal(cs35l56);
+	if (IS_ERR(dapm))
+		return PTR_ERR(dapm);
+
+	snd_soc_dapm_mutex_lock(dapm);
+	ret = cs_amp_write_cal_coeffs(&cs35l56->dsp.cs_dsp,
+				      cs35l56->base.calibration_controls,
+				      &cs35l56->base.cal_data);
+	if (ret == 0)
+		cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_REINIT);
+	else
+		ret = -EIO;
+
+	snd_soc_dapm_mutex_unlock(dapm);
+	cs35l56_power_down_after_cal(cs35l56);
+
+	return ret;
+}
+
+static ssize_t cal_data_write(struct file *filp, struct kobject *kobj,
+			      const struct bin_attribute *battr, char *buf, loff_t pos,
+			      size_t count)
+{
+	struct cs35l56_private *cs35l56 = dev_get_drvdata(kobj_to_dev(kobj));
+	int ret;
+
+	ret = cs35l56_cal_data_sysfs_write(&cs35l56->base, buf, pos, count);
+	if (ret == -ENODATA)
+		return count;	/* Ignore writes of empty cal blobs */
+	else if (ret < 0)
+		return -EIO;
+
+	ret = cs35l56_new_cal_data_apply(cs35l56);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static const DEVICE_ATTR_WO(calibrate);
+static const DEVICE_ATTR_WO(cal_temperature);
+static const BIN_ATTR_RW(cal_data, sizeof_field(struct cs35l56_base, cal_data));
+
+static const struct attribute *cs35l56_cal_attributes[] = {
+	&dev_attr_calibrate.attr,
+	&dev_attr_cal_temperature.attr,
+	NULL
+};
+
+static void cs35l56_create_calibration_sysfs(struct cs35l56_private *cs35l56)
+{
+	struct device *dev = cs35l56->base.dev;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_SND_SOC_CS35L56_CAL_SYSFS))
+		return;
+
+	ret = sysfs_create_files(&dev->kobj, cs35l56_cal_attributes);
+	if (ret)
+		goto err;
+
+	ret = sysfs_create_bin_file(&dev->kobj, &bin_attr_cal_data);
+	if (ret)
+		goto err;
+
+	return;
+err:
+	dev_err_probe(dev, ret, "Failed creating calibration sysfs\n");
+}
+
+static void cs35l56_remove_calibration_sysfs(struct cs35l56_private *cs35l56)
+{
+	struct device *dev = cs35l56->base.dev;
+
+	if (!IS_ENABLED(CONFIG_SND_SOC_CS35L56_CAL_SYSFS))
+		return;
+
+	sysfs_remove_files(&dev->kobj, cs35l56_cal_attributes);
+	sysfs_remove_bin_file(&dev->kobj, &bin_attr_cal_data);
+}
+
 static int cs35l56_set_fw_suffix(struct cs35l56_private *cs35l56)
 {
 	if (cs35l56->dsp.fwf_suffix)
@@ -971,6 +1145,12 @@ static int cs35l56_component_probe(struct snd_soc_component *component)
 	if (ret)
 		return dev_err_probe(cs35l56->base.dev, ret, "unable to add controls\n");
 
+	ret = snd_soc_component_disable_pin(component, "Calibrate");
+	if (ret)
+		return ret;
+
+	cs35l56_create_calibration_sysfs(cs35l56);
+
 	queue_work(cs35l56->dsp_wq, &cs35l56->dsp_work);
 
 	return 0;
@@ -982,6 +1162,8 @@ static void cs35l56_component_remove(struct snd_soc_component *component)
 
 	cancel_work_sync(&cs35l56->dsp_work);
 
+	cs35l56_remove_calibration_sysfs(cs35l56);
+
 	if (cs35l56->dsp.cs_dsp.booted)
 		wm_adsp_power_down(&cs35l56->dsp);
 
-- 
2.47.3


