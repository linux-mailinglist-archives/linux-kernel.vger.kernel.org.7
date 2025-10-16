Return-Path: <linux-kernel+bounces-856026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5B2BE2F04
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454073E615C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B344932BF4E;
	Thu, 16 Oct 2025 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="UaYccx2T";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="reQFi77h"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22A0324B11;
	Thu, 16 Oct 2025 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611389; cv=fail; b=MSrDm2lozISiSFamS/MYsW/r48U60QyyrGj3Doz+wDA4t4hugkhuomnXlQvvkbDftWCcvnNmSOz2oj7oDmQ490nyE6TpuMcM6l1SvHmF1wkGrOzULyTKFYKzeV0XSQiUTxDeyTeQoLwFlBZfpWUwOcRz1DH3VGlOJ/XaRQboPsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611389; c=relaxed/simple;
	bh=yNQzTz4LGiHjYITwEhjRllr45+edbbouQg4uiQygpIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mc/+6NqpJc44Rm/p9TAThdLr4Py3wS/jUzLjcgb+UULtz+/M+7qZheBfzSGZCxjmMDj4PTnkfhpCMwuArqf63QOln4fZHiR4tjlyX25doRztjMWrhBuB7GvG5d7RzK41mdPBI6loiFXtkbQrlez8RSvbYh2nQPlfmRLBIpPGC4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=UaYccx2T; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=reQFi77h; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59FLMCHR1728776;
	Thu, 16 Oct 2025 05:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=c6ovHgj0CvjYXZ/cHJnhStqygCCRz5MepGwYornyhmk=; b=
	UaYccx2TPIK2ePRlHV7gKdcQCDlCkgrY3OqBkwZymnypDEhW5S1dIfHsGa8HUVGO
	+fwJ1DNxnpXvm+FMAnmccISPhCPYc9YRk2DJ+Pd68Eqn1E3h39MiFBn8fy0JMvaP
	O6azZdXuAx48gJFElQX6jxcerzDy3IUb9MaoUXF1A4Rar9TfazTS0ntttc2Mp0XT
	XOAKicjQpyop9DAfthZ+vQBx7q43SfKmdk3QXrc4a3+hZs8wMJ/Xw26vKfU9Qx/N
	L4Zg2dYdt1TlmU/LIwgV/ppfW8gdO+K7dlOpEq+x8VshH+es4ZwrVNOXkBlGwhuq
	wzA8cDLyPhzHmLMpSBgDRw==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020128.outbound.protection.outlook.com [52.101.61.128])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49sdb448a4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 05:42:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdRakwj6cBVteX0pFbKUZjQ62Q4QNslgoRl89R2i7ys+LfT2ULyxnDlRftNR1bEfDIjxC+oiC1pkyuyzm0wssdyDzyrJafDT6/gFUdWxnKzXoWJ+/v5gN028snEVh4YdLjtyO1KLft79LTeq8d3L7lHQJC9g1qesY0UTmqEmSuZ9ViRtXzyRduIQebh612xQ01CEmg2YZWZPgZ3iqfdUMRn3a4FQFUqFvRUwaMeaeEIUJKv5wIAcrAMqhXgx9BpD1m9yNjJU4ltA3DsYMrQ4fac9865qaf5f+1hFKobikVW/IRl+fAboPjm0mypDxiOqjbtCReIjUiv21pR5IO1LDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6ovHgj0CvjYXZ/cHJnhStqygCCRz5MepGwYornyhmk=;
 b=YhcB19ct0j8j6QJ7+xBqMLCaLEBs/LyhfwYk/mf9Xglepxeo/LYbjlmWCBFMjWH2Kw8ouQWladzN8lV6DK5HxofYrElBWfiHFcDhpiAG4u/H21klgCdwMLAb4DgKdulKV2QALohmygJR62Ud+AesXPAf1RReFmsBJqOA2rgjauTpU30m7JkJvvBTzroWIq4tPk7MX+Ew/9pTFQsyKYCCyG72bIkyQrQE6f4zAQmxC591zdDTxePYVRlDIyTgKBEJcKDVHw47t7xWfZXCN2n8kJ8ugTOHIAn+7hPRVwFpSl32d8Ephxtzfw4P066Iqk6YZHqsH1THZ78q1sX65RawyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6ovHgj0CvjYXZ/cHJnhStqygCCRz5MepGwYornyhmk=;
 b=reQFi77hZWb/xvf2+DqA/0gPavd+BYiJB/Y6NEWMtwUTLSp0hBrnieLvD9y1epa2r/6cYIO8v/d/uJIn280zWRDporYgwsTwjUvfiguAWxNbfh26No8CTxEynA+qQYWNE0hiedtxQ/b3q383IF4EgOCwlbJiZep5NkZrCwYl5go=
Received: from BN0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:408:e7::13)
 by PH7PR19MB5797.namprd19.prod.outlook.com (2603:10b6:510:1d4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 10:42:44 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::31) by BN0PR03CA0038.outlook.office365.com
 (2603:10b6:408:e7::13) with Microsoft SMTP Server (version=TLS1_3,
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
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id D093E406553;
	Thu, 16 Oct 2025 10:42:42 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id BA8AC820249;
	Thu, 16 Oct 2025 10:42:42 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 03/11] ASoC: cs35l56: Add common code for factory calibration
Date: Thu, 16 Oct 2025 11:42:34 +0100
Message-ID: <20251016104242.157325-4-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|PH7PR19MB5797:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 22f160bb-171f-48eb-2cae-08de0ca0bd03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KSby2rHIkKMi+rtTQHgK6WEF2fTxANgyAWf9OkN9Gm2EIco/xgUjvEjLdqZ5?=
 =?us-ascii?Q?IVoSlMaYSflzNueMZDUgmsbqgySVGWMAeHbz/zHmU5h1GBMA1TbsuqgCMt4b?=
 =?us-ascii?Q?JrqO9U0mR7BpLpfeFmX0E/AYgp8zIIGKJ1cxjV3ywnzsoo2Tyy95afYBwdNc?=
 =?us-ascii?Q?G4tXrnu4Bun1fSOcG78/cnMki63fqKzLGIzrSRj1wx+Nbaa3nE4wkAELiAg2?=
 =?us-ascii?Q?mKqYLwJUQfV78trjoLkG7RTcclpa7FeuSehrVoweL9KmK/HFw3SbAjrHdqSP?=
 =?us-ascii?Q?YVD+nlVb9An6zOjT8WD1fAA0qETlQA/VeINEZfIpo7rJ88Ze3D4r7SYIfPyL?=
 =?us-ascii?Q?3YOQ+gp1eGT7WJFPz65fLn7DB6tUZLEJl4iFhZ0gxoejdFadduutxA/Wb0IL?=
 =?us-ascii?Q?eqT5WWg/PJgWbo+H4Id3Nnomjgt4fnbu1sgGQlBm7ozr7pdWBnYUN1lS1VSa?=
 =?us-ascii?Q?pPjwiOSe/px2m4+MgWppoGl0qDBvWqZmNYOqVaBJPlI0SVQcvH3LigxkEez8?=
 =?us-ascii?Q?qRXM7irtfUbdawIl80ext73O6i+/yzxdM1A7ukKzNlRMT6vzM/C/zMWX1G3x?=
 =?us-ascii?Q?SPWt/Y0NWrTq4WYqqXq/zE+v74Dnp/QWgr2viDUWjWqg9NSfh18vpNzXT86E?=
 =?us-ascii?Q?QL1f/5C+BUMNsPM6fWHoRI2DqIeKy/hSSgZAaHpmQvnj9ik4Yy/pABi9Scrl?=
 =?us-ascii?Q?tTVac8DDcblDoBhjrTy5t5fQIi/k4L7L+maKBu053xxzyT99LafkeuQjr50H?=
 =?us-ascii?Q?uRgAlWyJNavPAGdsm7MxMWGdjuMeK6OfQ7BGMWBDocxd6QEm3He6ukto+Yst?=
 =?us-ascii?Q?7CcCydSULFPF/oRiBanoLiaRZuOZURE3TJWc5oAQ3NyJx8+XxoDWN4Kg0Wqg?=
 =?us-ascii?Q?mco1RxUCn0zJuYgpu8n80Meh7FMXP15qksVnwp5rdCVzQmQTKxt91iYqB4Dq?=
 =?us-ascii?Q?ZcoiS1GQiDnsmm5awNpCEj8unQCk8sJ6UrnN9Q4yuEn1p/hIbncLeQ0WHuU3?=
 =?us-ascii?Q?uoj1ocHelpRSo69sNfmbEmAJSe+CRfgRm/p6UIITMuSxwmLuTZ+WZut/P0SR?=
 =?us-ascii?Q?W72zpy3Kk5HJNIG0H3+hTfbyitlUgj55fWHqcLL9kPcNoLJaRgV+enVD2TCz?=
 =?us-ascii?Q?uIXEG//zsBuOL1McTmjvDCg0DslxZ23r1IsHEUhCdD+TUbDQY6YsbbrXdx7w?=
 =?us-ascii?Q?Po3r/rAR2RAmbzGzLScUY5Cpg4M1osMYbS/g5cHk7bVl8u9g0fRZ6C7kp2mv?=
 =?us-ascii?Q?eviFobqWsJa53flwVRCRqyKyp/aMztr/wmzbWTMmOT3yGTulo5hYowfu2lqy?=
 =?us-ascii?Q?4eG4BPzDF9lQsrowQI0Sk7cKKorqmxPKruUpgnfKDs3lLOnG5D4u17ycUYYI?=
 =?us-ascii?Q?2t/UJR+2sw12xbTAiVdQoZVBnE6kmy4Nm7eRjBlQmv4wh9AAa5tNBpT3e+d7?=
 =?us-ascii?Q?mE1WnJloFxY5ZptE9do8KiW3BE9iLIps7XObQMKZ1oEqrmt0EQ1DW7/TnLTO?=
 =?us-ascii?Q?YT2FmLiA4AtfQGbrejJRmOLIXm20U3wEiUxyo7jb7RoVUCVyGog6tW4m7Who?=
 =?us-ascii?Q?YRUci4/FWeIE8lQmnIk=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:42:43.6516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f160bb-171f-48eb-2cae-08de0ca0bd03
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5797
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA4MCBTYWx0ZWRfXxqx63oNBHkLF
 lgeC91RXdUV8oKdAWjaZq7qikTlF6LnrxWj9yw6qdMdgH8042B0xcfipPtj/MqkOE8D3NsyMZnb
 yOpRXh2VIWP+ARSq0XLVsCwF+uyDdiI54KUSSCcYGp5wWwB05wanVO0cScE8k2MsZn+Io5ar/cp
 SAWCDDbAGrmuJHEglzyvcgTAzFVd8KEBd54yu2DLEgRH/X4ro1RFGftXCA/Aiz0Pea8gOgtFWEf
 KJhjrl8VfvZ9uu3URdozqVbnRHVwQh01egoRmwFsD9wKaOEP6lGQOKh2aoWoc3Fu1816H0DTEla
 wGcZEVJilpRTNvoTrT5JnYnKMSb+qO9xGdfjFfJZQdWkVk9KKeOxUhOlsf7IW347+Q9L3nVwJGj
 NjCqWZW70P1LrJfcsNhGlgk4t8Ij+w==
X-Proofpoint-GUID: K7Q-RFzC8KH8zokxdjHpjhWny80SPuRK
X-Authority-Analysis: v=2.4 cv=PPICOPqC c=1 sm=1 tr=0 ts=68f0cc2b cx=c_pps
 a=8h7WK4dQWB09CNKj11a7yw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=vH_VZnYPvUgQ1igPj3EA:9
X-Proofpoint-ORIG-GUID: K7Q-RFzC8KH8zokxdjHpjhWny80SPuRK
X-Proofpoint-Spam-Reason: safe

Add core code to support factory calibration. This can be used by both
the ASoC and HDA drivers.

This code consists of implementations of sysfs handlers for three
sysfs files used to start factory calibration and read the results.

Sysfs is used here so that access will be restricted. These are mainly
intended to be used by manufacturers and in service centres after a
repair. It is not something that a normal user should ever touch.

Calibration affects the matching of the amp hardware to the external
speakers. If not done correctly (either accidentally or maliciously) it can
cause the speakers to be under-protected. The PC manufacturer's tunings can
limit the allowed range of a calibration result but some speakers have very
wide manufacturing tolerances, so the allowed range could be wide.

This is not a full implementation of sysfs files. There are some
requirements to synchronize with the rest of the amp driver, and the way
this is done is significantly different between ASoC and HDA. Therefore
cs35l56-shared.c provides the main part of the sysfs file handlers, but the
files themselves are defined in the ASoC and HDA drivers with suitable
handling before calling into this shared code.

The cal_data sysfs allows the calibration to be read and also for a
previous calibration to be written (for systems where the storage is not
something directly accessible to drivers, such as on filesystems). As a
precaution cal_data can only be written if the driver does not already have
valid calibration. Code outside the kernel should treat the content of
cal_data as an opaque blob, so the struct definition is not exported as a
user API.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h           |  18 +++
 sound/soc/codecs/Kconfig          |   3 +
 sound/soc/codecs/cs35l56-shared.c | 253 +++++++++++++++++++++++++++++-
 3 files changed, 269 insertions(+), 5 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index ec9b1072d6be..4ed738615021 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -62,6 +62,8 @@
 #define CS35L56_IRQ1_MASK_8				0x000E0AC
 #define CS35L56_IRQ1_MASK_18				0x000E0D4
 #define CS35L56_IRQ1_MASK_20				0x000E0DC
+#define CS35L56_MIXER_NGATE_CH1_CFG			0x0010004
+#define CS35L56_MIXER_NGATE_CH2_CFG			0x0010008
 #define CS35L56_DSP_MBOX_1_RAW				0x0011000
 #define CS35L56_DSP_VIRTUAL1_MBOX_1			0x0011020
 #define CS35L56_DSP_VIRTUAL1_MBOX_2			0x0011024
@@ -177,6 +179,9 @@
 /* IRQ1_EINT_8 */
 #define CS35L56_TEMP_ERR_EINT1_MASK			0x80000000
 
+/* MIXER_NGATE_CHn_CFG */
+#define CS35L56_AUX_NGATE_CHn_EN			0x00000001
+
 /* Mixer input sources */
 #define CS35L56_INPUT_SRC_NONE				0x00
 #define CS35L56_INPUT_SRC_ASP1RX1			0x08
@@ -243,6 +248,7 @@
 #define CS35L56_MBOX_CMD_AUDIO_PLAY			0x0B000001
 #define CS35L56_MBOX_CMD_AUDIO_PAUSE			0x0B000002
 #define CS35L56_MBOX_CMD_AUDIO_REINIT			0x0B000003
+#define CS35L56_MBOX_CMD_AUDIO_CALIBRATION		0x0B000006
 #define CS35L56_MBOX_CMD_HIBERNATE_NOW			0x02000001
 #define CS35L56_MBOX_CMD_WAKEUP				0x02000002
 #define CS35L56_MBOX_CMD_PREVENT_AUTO_HIBERNATE		0x02000003
@@ -264,6 +270,9 @@
 #define CS35L56_RESET_PULSE_MIN_US			1100
 #define CS35L56_WAKE_HOLD_TIME_US			1000
 
+#define CS35L56_CALIBRATION_POLL_US			(100 * USEC_PER_MSEC)
+#define CS35L56_CALIBRATION_TIMEOUT_US			(5 * USEC_PER_SEC)
+
 #define CS35L56_SDW1_PLAYBACK_PORT			1
 #define CS35L56_SDW1_CAPTURE_PORT			3
 
@@ -294,6 +303,7 @@ struct cs35l56_fw_reg {
 struct cs35l56_base {
 	struct device *dev;
 	struct regmap *regmap;
+	struct cs_dsp *dsp;
 	int irq;
 	struct mutex irq_lock;
 	u8 type;
@@ -359,6 +369,14 @@ int cs35l56_runtime_suspend_common(struct cs35l56_base *cs35l56_base);
 int cs35l56_runtime_resume_common(struct cs35l56_base *cs35l56_base, bool is_soundwire);
 void cs35l56_init_cs_dsp(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_dsp);
 int cs35l56_get_calibration(struct cs35l56_base *cs35l56_base);
+ssize_t cs35l56_calibrate_sysfs_store(struct cs35l56_base *cs35l56_base,
+				      const char *buf, size_t count);
+ssize_t cs35l56_cal_ambient_sysfs_store(struct cs35l56_base *cs35l56_base,
+					const char *buf, size_t count);
+ssize_t cs35l56_cal_data_sysfs_read(struct cs35l56_base *cs35l56_base,
+				    char *buf, loff_t pos, size_t count);
+ssize_t cs35l56_cal_data_sysfs_write(struct cs35l56_base *cs35l56_base,
+				     const char *buf, loff_t pos, size_t count);
 int cs35l56_read_prot_status(struct cs35l56_base *cs35l56_base,
 			     bool *fw_missing, unsigned int *fw_version);
 void cs35l56_log_tuning(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_dsp);
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 160c07699a8b..5917bf5a72f8 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -896,6 +896,9 @@ config SND_SOC_CS35L56_SDW
 	help
 	  Enable support for Cirrus Logic CS35L56 boosted amplifier with SoundWire control
 
+config SND_SOC_CS35L56_CAL_SYSFS_COMMON
+	bool
+
 config SND_SOC_CS40L50
 	tristate "Cirrus Logic CS40L50 CODEC"
 	depends on MFD_CS40L50_CORE
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 1ecfc38d8eb4..dc6e49e3421a 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -6,11 +6,15 @@
 //                    Cirrus Logic International Semiconductor Ltd.
 
 #include <linux/array_size.h>
+#include <linux/cleanup.h>
 #include <linux/firmware/cirrus/wmfw.h>
 #include <linux/gpio/consumer.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/types.h>
 #include <sound/cs-amp-lib.h>
 
@@ -206,6 +210,8 @@ static bool cs35l56_readable_reg(struct device *dev, unsigned int reg)
 	case CS35L56_IRQ1_MASK_8:
 	case CS35L56_IRQ1_MASK_18:
 	case CS35L56_IRQ1_MASK_20:
+	case CS35L56_MIXER_NGATE_CH1_CFG:
+	case CS35L56_MIXER_NGATE_CH2_CFG:
 	case CS35L56_DSP_VIRTUAL1_MBOX_1:
 	case CS35L56_DSP_VIRTUAL1_MBOX_2:
 	case CS35L56_DSP_VIRTUAL1_MBOX_3:
@@ -263,6 +269,8 @@ static bool cs35l56_common_volatile_reg(unsigned int reg)
 	case CS35L56_IRQ1_EINT_1 ... CS35L56_IRQ1_EINT_8:
 	case CS35L56_IRQ1_EINT_18:
 	case CS35L56_IRQ1_EINT_20:
+	case CS35L56_MIXER_NGATE_CH1_CFG:
+	case CS35L56_MIXER_NGATE_CH2_CFG:
 	case CS35L56_DSP_VIRTUAL1_MBOX_1:
 	case CS35L56_DSP_VIRTUAL1_MBOX_2:
 	case CS35L56_DSP_VIRTUAL1_MBOX_3:
@@ -724,15 +732,11 @@ static void cs35l56_issue_wake_event(struct cs35l56_base *cs35l56_base)
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
@@ -741,6 +745,17 @@ int cs35l56_runtime_suspend_common(struct cs35l56_base *cs35l56_base)
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
 
@@ -839,6 +854,8 @@ void cs35l56_init_cs_dsp(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_ds
 	cs_dsp->mem = cs35l56_dsp1_regions;
 	cs_dsp->num_mems = ARRAY_SIZE(cs35l56_dsp1_regions);
 	cs_dsp->no_core_startstop = true;
+
+	cs35l56_base->dsp = cs_dsp;
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_init_cs_dsp, "SND_SOC_CS35L56_SHARED");
 
@@ -942,6 +959,232 @@ int cs35l56_get_calibration(struct cs35l56_base *cs35l56_base)
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
+ssize_t cs35l56_calibrate_sysfs_store(struct cs35l56_base *cs35l56_base,
+				      const char *buf, size_t count)
+{
+	static const char * const options[] = { "factory" };
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_SND_SOC_CS35L56_CAL_SYSFS_COMMON))
+		return -ENXIO;
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
+EXPORT_SYMBOL_NS_GPL(cs35l56_calibrate_sysfs_store, "SND_SOC_CS35L56_SHARED");
+
+ssize_t cs35l56_cal_ambient_sysfs_store(struct cs35l56_base *cs35l56_base,
+					const char *buf, size_t count)
+{
+	unsigned long val;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_SND_SOC_CS35L56_CAL_SYSFS_COMMON))
+		return -ENXIO;
+
+	ret = pm_runtime_resume_and_get(cs35l56_base->dev);
+	if (ret)
+		return ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret) {
+		ret = -ENXIO;
+		goto out;
+	}
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
+EXPORT_SYMBOL_NS_GPL(cs35l56_cal_ambient_sysfs_store, "SND_SOC_CS35L56_SHARED");
+
+ssize_t cs35l56_cal_data_sysfs_read(struct cs35l56_base *cs35l56_base,
+				    char *buf, loff_t pos, size_t count)
+{
+	if (!IS_ENABLED(CONFIG_SND_SOC_CS35L56_CAL_SYSFS_COMMON))
+		return -ENXIO;
+
+	if (!cs35l56_base->cal_data_valid)
+		return 0;
+
+	return memory_read_from_buffer(buf, count, &pos, &cs35l56_base->cal_data,
+				       sizeof(cs35l56_base->cal_data));
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_cal_data_sysfs_read, "SND_SOC_CS35L56_SHARED");
+
+ssize_t cs35l56_cal_data_sysfs_write(struct cs35l56_base *cs35l56_base,
+				     const char *buf, loff_t pos, size_t count)
+{
+	const struct cirrus_amp_cal_data *cal_data = (const void *)buf;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_SND_SOC_CS35L56_CAL_SYSFS_COMMON))
+		return -ENXIO;
+
+	if (count != sizeof(*cal_data))
+		return -EMSGSIZE;
+
+	ret = cs35l56_stash_calibration(cs35l56_base, cal_data);
+	if (ret)
+		return ret;
+
+	return count;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_cal_data_sysfs_write, "SND_SOC_CS35L56_SHARED");
+
 int cs35l56_read_prot_status(struct cs35l56_base *cs35l56_base,
 			     bool *fw_missing, unsigned int *fw_version)
 {
-- 
2.47.3


