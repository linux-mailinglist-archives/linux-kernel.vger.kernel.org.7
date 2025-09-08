Return-Path: <linux-kernel+bounces-806285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B82AAB49494
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0592A207E16
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C57030FC2F;
	Mon,  8 Sep 2025 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GLtaLn+a";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="jAVrqaH1"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8163A30F950;
	Mon,  8 Sep 2025 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347140; cv=fail; b=n+zkTJqTQiT3sfVYt9r9CGvx1++BTiFf+CzlYPe9ibUEeTMtnaa2I36CtNR7Nl4emUEQ/wTXLu0cxnQbtCqa3G3llaxzz2Kqf54y0X08AwFdUAOiwa5587okabtfkL0RyvZyycQk1CIFh1t5rKs2NyXnjqjlfPGNdfO6eC0Iroc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347140; c=relaxed/simple;
	bh=wJhnQMsUsI9rAjc0BNjA1XOBKL7QbUrGwXxQp9Iz5Lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oULb4vgm6qDVQxuYfTZ4MVF+YtXzp90K2Urt+P9qFkL8N8pUGY7W+PYVCk25wz3vbm3HbF0PcWoOI8VPc/htvPBT55lHWYQ89H62BmuPx2f6lpu27Q77KI95TbvWXg9Y1Y4Y0zkPpWwlrTt6nugBUZindzikNwycYA61Os14NOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=GLtaLn+a; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=jAVrqaH1; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5888Uljj2152512;
	Mon, 8 Sep 2025 10:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=h4Dfr0hD8yE9FJXgyaN7BRfYnhLiGIoENqRcYFsQiR4=; b=
	GLtaLn+aNvZBMuZzI3adria7MIVu1tNvr7bgdAxj+NRdo6GSxxub02anl44O5wf0
	44bLHbPc09s9aZNU6Wb9eg4Opixcv5weg7iHRyPwbN8BjOYMPio7e1c5ewKG5TxY
	MVtZ1VvL+kfWRHVEYAfQggtATtFsKdYd76VluPU8hQ2AGa5l6MBNDmEvySu/MpfC
	6JFXjnhrmQnTj40egqZFsaVtGooAsraKtJGPGXk6VtDWLlLlxqp1RhWrc9aOfWdL
	czgKB3YiWsOGOsN010gyZolb7FVRFyLNkvr+tKOF70wVJ/SnbsEhl7vZJp/wKfBs
	C+0zJrfA0oFczJZoojMaFA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2117.outbound.protection.outlook.com [40.107.220.117])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 491upq8grh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 10:58:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdCxPAJ1hrjxkJPr2QOww9fKWns5VYVvL0XoxwlMsWInlPqo9NzeKyFCe/WcUTBwbjuiqwe1BZj9QsNLAGMpVX73pEYt8lH+pjp5786wIdbQ3QL76s1Ve+t7UXiPrWjEwGu+K3zR8I5gDbH8OO0wZtFygCFrb9sgMCYTGtR5CxwdiQ7rX1hiy70ngnPy2kTCRRop2Cg5tnu7Eq3opCmcHb8JJkfsZIYIyr1MewTyInpNAUrHmYgdi+8177UKZp+jmSGGhaH7TTkUIDtmw6HGB2NRxWT71p7ZjafCZJSQv2qsxc6cm3972t0dVWNkefr21sBx46JSe5rS9hx+dIw3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4Dfr0hD8yE9FJXgyaN7BRfYnhLiGIoENqRcYFsQiR4=;
 b=CZ68G7K26IN/Tlb61tHfiL6Wb6Wax7ezC5YnldhvvFBgyPzYa2Y0eDT5OIUZ48XzIf/oHZ+6LyOlcGZW3jqAFZwSGHDZMqab+nINH/K/sZgNSdVEFCjEZrth3uRMdkcQxhUeYdUfkBkHpYPyUJOTRKR/UF3HMXGPuqW6dT17dNqunO2CMu1Eb9Ebn1WGCr92jfAf411R5N1QLrr7imesutf4VyTWa3QkLRHym8PLDIF9LokjSZCfRaE1aI5dyXahKwu2t6sZGSmig/YA06LWEgGbgqOrjutBOnrkOgUajUdgem3isTtUnMPGogDaTsl0Ry/yr7vzKxTgrc87ixdHCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4Dfr0hD8yE9FJXgyaN7BRfYnhLiGIoENqRcYFsQiR4=;
 b=jAVrqaH1SZgAT2LSVOiUt1HQmLQck8ah/nGhFVzWmsvAqbcjZyvX0zcCHP4bNaORfPhU/KFywacKay1reu8XD76YSmzHQBjC30FlTbvNyOEArmTSV2qNpkxnLbaHbEhbtmmQnlXxlpTN/fR86kXRCTh6AkKbl16xHR2bkxiXsFY=
Received: from BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28)
 by DS0PR19MB7926.namprd19.prod.outlook.com (2603:10b6:8:161::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 15:58:45 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::91) by BY3PR05CA0023.outlook.office365.com
 (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.14 via Frontend Transport; Mon,
 8 Sep 2025 15:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 15:58:45 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 9FB25406558;
	Mon,  8 Sep 2025 15:58:42 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 9775E820247;
	Mon,  8 Sep 2025 15:58:42 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 5/6] ASoC: cs-amp-lib: Add HP-specific EFI variable for calibration data
Date: Mon,  8 Sep 2025 16:58:41 +0100
Message-Id: <20250908155842.599459-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250908155842.599459-1-rf@opensource.cirrus.com>
References: <20250908155842.599459-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|DS0PR19MB7926:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 968659f0-5855-4ea6-887b-08ddeef09765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S/b2WsPjqBggLWVRcVLAYTKRlj9QSW6oHxUpUyrcJ/Qaa6pUVHrXMuDHZw2K?=
 =?us-ascii?Q?qZxN+FMDl64ElsXBpHw16hyx5IU4TbtGlMbibkcJoj+ntwONnJj49RHV+ZOK?=
 =?us-ascii?Q?C2SQYslfyuH75sjN6dh2IBggqV+fRI6c4is5t8c0ldX3jPKljrLgxr2PmC2p?=
 =?us-ascii?Q?IzYVYpr9qURXeNmEW14I1VWH4Mr+VgMzJJA7OTDh8qb7kd/h41h1vVBkoSrT?=
 =?us-ascii?Q?VBPsaslmhR6V+QrQP/XBlq3lqMxbbe/BXZjkgigv+winRN3Wolj3mXGvysfu?=
 =?us-ascii?Q?OUPcNP3LExOh8Gh70jsgMbgiUb6aCVjjOJEcrH/YZp3HO9pz1QINm/b4DGOx?=
 =?us-ascii?Q?ugPw5l6puPmmtCBxY3nw9aqqwqyMi9tZpeOGAkbMdFyYBlfqGGsK0IqfqKjH?=
 =?us-ascii?Q?CBYQt61X/OJtLjuZyo348CnCaKfXHoHgO27iwT9iuVkUZlDgWIiN4ci/k8Rp?=
 =?us-ascii?Q?fx9Kht6OCbxB3M1Tbf+gp5KK0TPO4bsChXDMwjw5N7vxnGdRvdhqfVNxXqbq?=
 =?us-ascii?Q?6JSMDE0j4/4nRydQ9Q56/E9NVk/qhY9SvA57qCcn+NoeM6uDlU7+nzr8oWCz?=
 =?us-ascii?Q?HURAXb6w72B8nFb0vqQuMvUanj/fla0qotbRTnA2dOzqqFmEDrb20V3FWdX1?=
 =?us-ascii?Q?/1jgoKnHnqDguwwfCbXjRJIjB4MNdrbjI0ob6ERLsEMhZt0wPV1GwZ7bOSu7?=
 =?us-ascii?Q?eAtSQXXTWHMoWqq9XrwYUhRXMXOgAPEYZYfKKkvF4aoLSyA41nYD/C1wPC4+?=
 =?us-ascii?Q?yuljneiORgFZldv/wJrzo+eYH5hNLKzQZjzgJfHXIzkJd9lLMBsHVxTrk0vZ?=
 =?us-ascii?Q?i0AJzdJ6Fo1PiQH1A1dusH3/JYNqOLej7bPa8E6VFjMgtbsU3tWCJ8lBZs9d?=
 =?us-ascii?Q?WlyL5wE5wm5JFwDhVcN2sGUH/6XbGvvNtRNlpZlfONy9c/P7j72Fr8tAEYLa?=
 =?us-ascii?Q?bhPK3ND0FiRt6hk87ezPCoWDnmul0JAsMDdXU+LqFujMfmEf288KgjmgHZCs?=
 =?us-ascii?Q?bjosEA+JCdmVu14WSqdCUiF7Wi1kX3L1Vzk9y5ixhfWTXoFGeILFoJCl69V9?=
 =?us-ascii?Q?F/9bgV++tKa5m5RXt8Jaon8CoGaCDlmDY9y0yDbQdZGzqVM3zdTDIEtVkUe4?=
 =?us-ascii?Q?oevd53avlgklaBRGXbKkiEbWFJFqKbyitI6Rlki0QHYWObGGviFBBM8yTV4M?=
 =?us-ascii?Q?zwXjOnqXRe8o92YhFGKcx6j6VJb01hWIRUkAVGT2yMFpC9f0NmIXZzxWI66O?=
 =?us-ascii?Q?dVKmfU7XQcAt1AZ1gn7gkYVf/YDFPNsQFEMRE2v3jW3wH52TWRByryZAiLVP?=
 =?us-ascii?Q?yxcliy/+35zl5W1dovgwmNae9GB2GblsoIZDbtKoVNF1xHxHnF7SJKcUnYaR?=
 =?us-ascii?Q?yrfDGfxYNtwN8xiRMJ2RNXvdlVhYfKcj1z8DexUqocJ5mxwc7Ut/elsfajgG?=
 =?us-ascii?Q?1MuKRLCmyL/N1k+LCmJXgP3cBkQHzdRiq1XYrzdG3DBGwdVEjVIkBEJlUsOV?=
 =?us-ascii?Q?bhDjB7sIdJjH7fWzQnhq14LEprH0Iu5xa149?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:58:45.2658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 968659f0-5855-4ea6-887b-08ddeef09765
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7926
X-Authority-Analysis: v=2.4 cv=DMuP4zNb c=1 sm=1 tr=0 ts=68befd3f cx=c_pps
 a=Gqw+4yJV85EtGHpvYtJK2w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=gujROYcaeV9tRZqipvkA:9
X-Proofpoint-GUID: PRTS8-qawMoFFkQx3jxbJLQENeHB5R8W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1NyBTYWx0ZWRfX+mREDBk0bKqh
 Vu8TvKjvG0dCdRgGkKu4TyzN9BxpAb2R27Y5R1HKKdW1XpugAb1kJ1RjD7Xe+LKUOxkyVLGCxEI
 tHIocnRHu1fCQp2qX7m6QeO2wxQRgE3Nh9usrldIbpbOBWyOKi9nzXJDoD4v5ACY/HfYq5sudQK
 0Dz4Sys1NVeTFrLQlY+G/tkz/HpxICk8Aj6/DfVtzPQYtFb8CdaLRYHKsESOCRzy4HzGGFc/sFZ
 sVSlOa5+Y5JBC7ZFSgI/PZv9C5LQDBhYjiFbySzCkx+0CrX+v2XyMk69wXD23hVwbABNJ15kTL+
 jjUkpdsjfSjVD+9X9ST1DPafOKPuP8UAikbKuFpIcRCTc6gGP7VG2v963xtbH4=
X-Proofpoint-ORIG-GUID: PRTS8-qawMoFFkQx3jxbJLQENeHB5R8W
X-Proofpoint-Spam-Reason: safe

Search for an HP-specific EFI variable for calibration before falling
back to the normal Cirrus Logic EFI variable.

Future HP models will use an HP-defined EFI variable for storage of
amp calibration data. The content is the same as the normal Cirrus
Logic EFI variable.

The first step in cs_amp_get_cal_efi_buffer() is to get the size of
the EFI variable, so this has been made a loop that walks through an
array of possible variables.

A small change is needed to the KUnit test, which is included in this
patch. Originally the cs_amp_lib_test_get_efi_variable() hook function
asserted that the passed name and GUID matched the Cirrus Logic EFI
variable. Obviously this will fail because the code now tries the HP
definition first. The function has been changed to return EFI_NOT_FOUND
instead, which emulates the normal behaviour of trying to get the HP
variable on a system that has the Cirrus variable.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs-amp-lib-test.c |  5 ++--
 sound/soc/codecs/cs-amp-lib.c      | 37 ++++++++++++++++++++++++------
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/cs-amp-lib-test.c b/sound/soc/codecs/cs-amp-lib-test.c
index e7492afa041e..c090498cbf78 100644
--- a/sound/soc/codecs/cs-amp-lib-test.c
+++ b/sound/soc/codecs/cs-amp-lib-test.c
@@ -204,8 +204,9 @@ static efi_status_t cs_amp_lib_test_get_efi_variable(efi_char16_t *name,
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, guid);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, size);
 
-	KUNIT_EXPECT_MEMEQ(test, name, expected_name, sizeof(expected_name));
-	KUNIT_EXPECT_MEMEQ(test, guid, &expected_guid, sizeof(expected_guid));
+	if (memcmp(name, expected_name, sizeof(expected_name)) ||
+	    efi_guidcmp(*guid, expected_guid))
+		return -EFI_NOT_FOUND;
 
 	if (!buf) {
 		*size = priv->cal_blob->size;
diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index 9b51d056d863..8434d5196107 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -28,6 +28,24 @@
 #define HP_SPEAKER_ID_EFI_GUID \
 	EFI_GUID(0xc49593a4, 0xd099, 0x419b, 0xa2, 0xc3, 0x67, 0xe9, 0x80, 0xe6, 0x1d, 0x1e)
 
+#define HP_CALIBRATION_EFI_NAME L"SmartAmpCalibrationData"
+#define HP_CALIBRATION_EFI_GUID \
+	EFI_GUID(0x53559579, 0x8753, 0x4f5c, 0x91, 0x30, 0xe8, 0x2a, 0xcf, 0xb8, 0xd8, 0x93)
+
+static const struct cs_amp_lib_cal_efivar {
+	efi_char16_t *name;
+	efi_guid_t *guid;
+} cs_amp_lib_cal_efivars[] = {
+	{
+		.name = HP_CALIBRATION_EFI_NAME,
+		.guid = &HP_CALIBRATION_EFI_GUID,
+	},
+	{
+		.name = CIRRUS_LOGIC_CALIBRATION_EFI_NAME,
+		.guid = &CIRRUS_LOGIC_CALIBRATION_EFI_GUID,
+	},
+};
+
 static int cs_amp_write_cal_coeff(struct cs_dsp *dsp,
 				  const struct cirrus_amp_cal_controls *controls,
 				  const char *ctl_name, u32 val)
@@ -146,12 +164,17 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 	unsigned long data_size = 0;
 	u8 *data;
 	efi_status_t status;
-	int ret;
+	int i, ret;
+
+	/* Find EFI variable and get size */
+	for (i = 0; i < ARRAY_SIZE(cs_amp_lib_cal_efivars); i++) {
+		status = cs_amp_get_efi_variable(cs_amp_lib_cal_efivars[i].name,
+						 cs_amp_lib_cal_efivars[i].guid,
+						 &data_size, NULL);
+		if (status == EFI_BUFFER_TOO_SMALL)
+			break;
+	}
 
-	/* Get real size of UEFI variable */
-	status = cs_amp_get_efi_variable(CIRRUS_LOGIC_CALIBRATION_EFI_NAME,
-					 &CIRRUS_LOGIC_CALIBRATION_EFI_GUID,
-					 &data_size, NULL);
 	if (status != EFI_BUFFER_TOO_SMALL)
 		return ERR_PTR(-ENOENT);
 
@@ -165,8 +188,8 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 	if (!data)
 		return ERR_PTR(-ENOMEM);
 
-	status = cs_amp_get_efi_variable(CIRRUS_LOGIC_CALIBRATION_EFI_NAME,
-					 &CIRRUS_LOGIC_CALIBRATION_EFI_GUID,
+	status = cs_amp_get_efi_variable(cs_amp_lib_cal_efivars[i].name,
+					 cs_amp_lib_cal_efivars[i].guid,
 					 &data_size, data);
 	if (status != EFI_SUCCESS) {
 		ret = -EINVAL;
-- 
2.39.5


