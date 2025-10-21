Return-Path: <linux-kernel+bounces-862671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86399BF5E25
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6190E3B26B5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3440032C949;
	Tue, 21 Oct 2025 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CXLmk7Ic";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="K5yG3DC3"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB065320391;
	Tue, 21 Oct 2025 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043836; cv=fail; b=JVwTZ9wlja5I3Bzp5fZSqjbdq2kuTV+RWsQB25zEG2YJWwNk31hbHy8G4BVHFme4M2VcVI9m0tvDtWcunETd3BlHz7VE62uY5UQmTBeesibT9Hp3yKTLWeA3wfVBQAI1pHUqZtBKTE3AbpV4edER8jKjDdiEN8jkNoEbew/X+so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043836; c=relaxed/simple;
	bh=fskXtZg2QWqzpCit0v/eKpCkJ/p9j3CQikCzS5gG8qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9/QDzDhpivYZHUrSqhRt6oOD7hHgesPwSf2b5jCHwDyDhch9kIMPyxSg/lAgEAoAQGbtGpY4j+9I4knwOBSobEtlsBFKHeAnJfMxNU/pRbFfQ8JtkTCydyI0PEGU7FlswCgiW788M41FS9WabVzELkncdwqLHYUt2MjrP7TFTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=CXLmk7Ic; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=K5yG3DC3; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59L4jHCt952328;
	Tue, 21 Oct 2025 05:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=MFjJ87ZyfeVITZTbJxj9KihRa221EyZNB537gqjCSqU=; b=
	CXLmk7IcV83GKqUrjwhoWYiVr2dJD9g48mzUkMheP4OKp2udd6tF6A5AjlBrgOPp
	Uswu+x/cpfSEidCiRlSO/9VhLUlp6ZhAwxsWkXhc8wfCSrLQva1vH9I8pDH/a4qp
	t4h8aAFaClwj7Gdrk+1YjBl/6B6ZcK7HRH0Dqc6uS45YGh7Gjm1jwOzL43ckIVhQ
	R7HPc6wkExENOlu7lo0+3yhRrlYWi1XTDLMH6IJNP3cEkpGBT2Kas7SSpJDhWK2E
	buEXU/5m9B4ckBWxYHN9n4kFSGmJEdXoDYdY3qeOOzaM0P3/1ogDP14klSWOudga
	duAUe4U4VfyEgquEhKMocA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020101.outbound.protection.outlook.com [52.101.193.101])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49wnc4sdqj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 05:50:30 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2P+lEViM1G3MUMUNaP8CT88fCH40OuJBIdL9PcOIZKxJWOtf3JVa4aMsWW8ndWHPORYrXdCTBIRixOxuHVe4Mb1JJkYJIMqxrnxlnFMSrZMZJGGKH6D4pQ0Ic1BkUd8EsE674YaVMz5tqoNnnnuzMntHBSK7sRh5jtYFN9WVmcPtI0WzcNU0nS1pvPBAflakiNxESNDPqKAQayAk90rJ7ZVz25c5bKv9Vlnwf2lI7zKXjtWD6rl55NaoE6zuTPykqP+nokxroC7fhvELiFWkpizts8GGETgc8HYYJGcYPREVryIhlH/NMeL0GFvipZIx12ByxNjm3uevpMyjmcmsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFjJ87ZyfeVITZTbJxj9KihRa221EyZNB537gqjCSqU=;
 b=cpQyylNe9Hi3jp4Z8Nyc6qUCKd2nSXFsLdVMVALBho4c3pvw+x9uDjf9lJOyx0H1YhIq0wcDvTso6/JBE5G6OQJh7wqNVrtdAG0a5fl6bA8Qk3jnnrglg059zvxieb5LgB1Qy/UOnbahkXIuSlIlwKK9tu9v9Fdnx9j7isoJ6hU6VEsnEsOPkxFAioC9RZOc+B3qkf9xgigG5B0+7X3Fio31hMLFVNnCQx6359RXNSW8n4UWzIWm/X+sLYL+90knGgTrij2a+m5FVBc2Bm6K1DR1pKfKNiiU43Lka4rFBO4xYtIqQwkUiU3MlrJYkG3k1Tv7dbZ2H++p5LiotZQhsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFjJ87ZyfeVITZTbJxj9KihRa221EyZNB537gqjCSqU=;
 b=K5yG3DC3QUt9wl04yrEbWiWw2SNH+AbClKCPu+X2s4Ylu9MQIPRX4JFwfg49EvnED0o8TV9zOTuf3foPwHRB7HhaOL1YXd5mhVzAkfcRPBYya2hCbLHFnp2Vs4AhXU1mrHKWBrSp4yBaia+tnuAnggd4c28teyt0HYwjHyBQI6E=
Received: from BYAPR11CA0098.namprd11.prod.outlook.com (2603:10b6:a03:f4::39)
 by CY8PR19MB6916.namprd19.prod.outlook.com (2603:10b6:930:60::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 10:50:27 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::37) by BYAPR11CA0098.outlook.office365.com
 (2603:10b6:a03:f4::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 10:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Tue, 21 Oct 2025 10:50:26 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id BD623406569;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 9286482255C;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH v2 10/11] ALSA: hda/cs35l56: Set cal_index to the amp index
Date: Tue, 21 Oct 2025 11:50:21 +0100
Message-ID: <20251021105022.1013685-11-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|CY8PR19MB6916:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 73deb663-58d4-451e-fb54-08de108fa539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2KbESIEfdaELc6i+d6vaMtagezRNVqhP2eKet1eESxbs2RBZhVMQhV42bCpC?=
 =?us-ascii?Q?D6rDz0VbeKjuNmClrDqBkFZ/TAkG3FwfUz4jA4uG3uVxQp4zjctKYZaqRu/1?=
 =?us-ascii?Q?f/Gihut1TdN2Lnj411Ga6tDFx0M7wTILBsQ6FaZDVUJeMRG5orWVdcwSBPf/?=
 =?us-ascii?Q?OmdfneIJDjMZxUy/R5HTuptSLkb/xUQcCnk4cWa5yWLbyrlHTEPk656SgrmC?=
 =?us-ascii?Q?MNscCfixXMQCvSssZBKBBw4hu+MMmKPdcaJ4Fc1j90I3Qxn4gtXDpWVHBlTJ?=
 =?us-ascii?Q?n+l6XBIGp+WlxIQKzwPKsebYWNg10SB5IGZ7sNveGauFyzS1eA+qG9H6/7j/?=
 =?us-ascii?Q?+fVGjZh120sPKgaZGToLjuyCa+Sn5iOstQVBbTsgqJlFJmMzHRKV95lzPslD?=
 =?us-ascii?Q?JzKhHFM6Y4QJHF4S8I0aACj5W4vtrYCZ+1yvTJJcj0ANHetRK6xKs9ykHMjU?=
 =?us-ascii?Q?Fs0w5mTfs7uzcFNa3v3mjzHoo2c8Jz7g59n5rTcQWyoiJtAeKu2wLtFDmQje?=
 =?us-ascii?Q?gKFQJHbPxOe7Vnq3x5Mt1EvUnxYHhjDOu8ddE4HrinZ37OUqL022hnMXlX0Z?=
 =?us-ascii?Q?I7FDuJKCd+uJ2Tx5Rtiy4R04HCy8C/GV97YEDImCpbLbeXUQstt0ASEfMw/b?=
 =?us-ascii?Q?eqLpKxOoYM5ZcrHpNiJl5liD5ESMHpnRIMy2HbLJdKO/1dnnrbd8ZuKC50oH?=
 =?us-ascii?Q?dMPVj20KDM5d0UX48OtbnLIeQiP3DA4imCyJKUYmzHdWApuzEg/XFY8oIh1E?=
 =?us-ascii?Q?hFAL3a2i1l0+9CfL94hJWSZ1tiVTD1BbJC3bIMib8vGqCuOd3Fk9TXO30BtF?=
 =?us-ascii?Q?di3ooznSL00/ZdFAalCz2hBQMH+iGo+PI4CI+KTE70vCYjWGTmbj/Q6YL5T4?=
 =?us-ascii?Q?l+K2fogQPF1z44VfGB8nHThRvFANuYb8KpiUPVVjO5KQUv70OybUTTIq167s?=
 =?us-ascii?Q?O3qHibHhTyLz7YzQgvGEYlj5TytFs21XMNS7vyZVpskhx+inzt8ZxR9xy3mc?=
 =?us-ascii?Q?UlJVqmGmMKZ4W7qT6Q+PZiLFyqLY9qx0jsGE/EwpE2ozG6Ml3xAB8Qf+OJ03?=
 =?us-ascii?Q?BFC8nDxV/qyRHO1LHSo2153POCfEaZxFtsCJJz6FeMLHQ4Jf0lOduX682LeP?=
 =?us-ascii?Q?KvTLCXUZjfNhM8STVdvBQV2W645oAhFKG0hja1Wy063sraplJVndHg0Ov8lQ?=
 =?us-ascii?Q?UDt1nGbxfXEYoLRhTPCx7nonngF89J4CKCVXQNjI4zvHhWh2a09RIjl94XGO?=
 =?us-ascii?Q?Ecta127Hq3lBaJTNKM/jqsAE8ehSWmOw0u0h4Ktz0HShCfVOMhp1REL6ryD0?=
 =?us-ascii?Q?2N/T+ml8dLYIRMIwbKSB2OkkSQEHgqZRtUawu+3NtpPDdOafvnFmbCJBbRQu?=
 =?us-ascii?Q?cdJvS9GN0dgvXVLIjzE0Ds0m+6F1Me0rfzDmbSdEMnFbSOQdZ6F1SabyuroJ?=
 =?us-ascii?Q?0mhTQYlXh8LOw0qcVyBUWPC9FgWvAB0Rwmw46HB/ztjq4as9v2D4jg3eKDLq?=
 =?us-ascii?Q?P/NpDCAgbDPmGeIgm5KRS5jfi0ZmZKn8moDh9tvtLMQbTQ1bGhACZrRaQmsg?=
 =?us-ascii?Q?LANiH+v8S5VhIBmznG8=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 10:50:26.8193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73deb663-58d4-451e-fb54-08de108fa539
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB6916
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDA4NSBTYWx0ZWRfX4D1o8pk7Vqkn
 VtRs9cNh6s3QHjLrisogFAiDa9pKEC3RMm1eZaqGKO3Hd/cfOJjQ8nIvaWlJCpUkByHc+Aej+wB
 V02NvxeV/NJuDQ6vuL8VvgBVrLHk5owUlSuxkgcqTjAsQLR9nP51VCq/OxpBrR9bax/z3CFX7b9
 ICRhlqF+3Dg5cv1RlwhXKGm899c0tFELtTUY3zVuSXtMDf9KTSXZGzwh4ArQrjwAFHRyDcpJYAo
 HDLZngXce4G8h/3Uf1iPq9t/1F6Zl0pZedF6/DInxlgKXwu6qTsxV9doB1h7U2o02qyxIWJmS2d
 3enyvn8lm9uA58eOr3Lv7wJgiI2FrKeD6CjLCEirnclqoWjDQA9M1N+hH63YKowoj3CGsZYXc5s
 PtatXOOjzqgwhoO+gYmM4npIq3QqZw==
X-Proofpoint-GUID: Dq5Asd9eaN3-Wluace_SwmgiPclCTa26
X-Proofpoint-ORIG-GUID: Dq5Asd9eaN3-Wluace_SwmgiPclCTa26
X-Authority-Analysis: v=2.4 cv=bf1mkePB c=1 sm=1 tr=0 ts=68f76576 cx=c_pps
 a=IAlGFxvWO5AZskdmYTP3vQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=yyqevtf6Vn7-8GcW_JgA:9
X-Proofpoint-Spam-Reason: safe

Set cs35l56_base->cal_index to the (zero-based) amp index derived
from cirrus,dev-index property.

This is so that factory calibration data will be written to the UEFI
array in the slot equal to the amp index, for compatibility with the
Windows driver.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
No changes since V1.

 sound/hda/codecs/side-codecs/cs35l56_hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/side-codecs/cs35l56_hda.c b/sound/hda/codecs/side-codecs/cs35l56_hda.c
index 03f565312459..f7ba92e11957 100644
--- a/sound/hda/codecs/side-codecs/cs35l56_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l56_hda.c
@@ -1154,7 +1154,7 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
 	}
 
 	cs35l56->base.type = hid & 0xff;
-	cs35l56->base.cal_index = -1;
+	cs35l56->base.cal_index = cs35l56->index;
 
 	cs35l56_init_cs_dsp(&cs35l56->base, &cs35l56->cs_dsp);
 	cs35l56->cs_dsp.client_ops = &cs35l56_hda_client_ops;
-- 
2.47.3


