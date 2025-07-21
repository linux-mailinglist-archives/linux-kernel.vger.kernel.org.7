Return-Path: <linux-kernel+bounces-739380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E9AB0C593
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A99B3ADA02
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407A12D97B6;
	Mon, 21 Jul 2025 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="lM0tnwqo";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="tn6V/FKt"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE6C23741;
	Mon, 21 Jul 2025 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106082; cv=fail; b=Gpp43XwsowJd8/l2BxcaA3JljW/3TOlZg/uAfyqsniYD3I2YjllipEaxnPxMsTmtZq7Q7Vd/QA3pjMgA/WQG7MovH45OG5LbVv0c6PunCWXACMMVoSLBRdq3gKpRVuDurMLmAqfePpqD0HL5hbSILpmwYoHERUzTUmG7j5nZL9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106082; c=relaxed/simple;
	bh=5pGWQg0gj26TLP/DEzv92TUp6Ctah23p58ouuEmTLhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ppX234m3qRe3HgcgGLpy4u4F/DTed3PFv1XQSP7075h0Kzm7mYaK8IYIrTu8TU5w1jeU6WZa0j5WoUpSMb/heWSUIwe9c81ZW10CinNEcAs/Nq5pWcD7xoI6SwX6tAaynIqxrda8LLxRpVRymegn44XyAn08xN0QxLz6oH7Gs+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=lM0tnwqo; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=tn6V/FKt; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56L8EdNe025137;
	Mon, 21 Jul 2025 08:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=Rzhq6LfoI2AgaoOU
	89RQL1zfmejOHzqtNWnc1DM2rpA=; b=lM0tnwqo2R6EBZaNMHGEkprtE01cycRI
	eigV8CyUTsl+x6cQ4mk7/yRqaXU8Ab3exQ5dyALT3JdYt9QwiAbWiMsUIT+xHUtp
	hIjVKwAjx6mQ3lz3yITlKs8HXGeVJykoRLe4dBZwFfMsCRSju76s4ZIHOGdk5nt7
	QH8uWSSypCRHO3iA79r93YWBrPaAFI5f669k6LNiKvhZ7zMfKBQmgH8AR5tPCgW0
	BeVvkXs0c/YnV/+RBaqWA/PqW4/+UN/dm1xXsAh5qdrrXBreFrpcsSBVENwBladi
	gXJs7XY5mgHmy7k1MDGyaFvNXe3hJsScNSK/ftdd1R45kZBpiBe33Q==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2102.outbound.protection.outlook.com [40.107.236.102])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4807sg21ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 08:54:25 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfP55g2IAp4yisxTeNxOHpgyVgRRKZYCprg+5i0+ezr4YWwKXRIoKwyAnhFksbIklA8JZ89LnnvxOhsshs87cg4ctJtA2pxx2OlR5uF1sr8xb3Fl65kaCPeXBirc3kaz3hq/jz+jzqwt4kznyNVSTI6iA++CIR4tUMExITde3tj2Dx+BDqhH/bDbuiyCU2FfRHlkkDOaJkKT5wMsUNkYznfFOa1XCruT869hmVH51YzFRPyVcaSwOxydIJaV/uE9LuC2Ucrzkfd5tvwJbFQWgsjl34L71xv0ifx5KeNypJbSfvtAlZZKEaPKW0WwgXGzNUyGot49o3XSmGQywM5c1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rzhq6LfoI2AgaoOU89RQL1zfmejOHzqtNWnc1DM2rpA=;
 b=G9tE2MtxAAqjoEVsa3EijA/mfT5TEIU7LiecAxZsKOQugaj4RA7tFsOZWOSdZzcsNcE11jlHRU/OsbXjAFA++aebo6cmZEyMO7/zdx8Giwey+nyoGIF2TvOsaIyY0YFe6zXOMtnUr7Y/Ywqvpb4Ya/Awpq99GVKIE6nZ8WnbnrxScIBjDopaJxTf4ptE0WHjgAVJweQtV12FlFUUVKDAjou0RmRoLQgI0jHVASl9hTfMzgKK08VToCT8sAyn8fOmzxnveF3QzppC6KjWJBQtqL5FgN3Hi8Dx6Khv1Fc9OQg2s+6H8bJjPL00cOg8/rAKnZiiNFp/DaTWtlUfaiOZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rzhq6LfoI2AgaoOU89RQL1zfmejOHzqtNWnc1DM2rpA=;
 b=tn6V/FKtvbjM8a+GOcRVrRj8+vKH4QeRYr/XYBngw75/mdas/+tEt2zL6xgUqe6uOSEnEsg3UzhMk8fsfDtkO0DkwMykUhmnyY0PiwqIgqPUsXzsvdXGoMm5z+35Z2VltI44uTfefrnth4/VjWNs6ZdcxHPZUzskr/jhqHAqZUw=
Received: from SJ0PR13CA0227.namprd13.prod.outlook.com (2603:10b6:a03:2c1::22)
 by MN0PR19MB6382.namprd19.prod.outlook.com (2603:10b6:208:3c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Mon, 21 Jul
 2025 13:54:19 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::11) by SJ0PR13CA0227.outlook.office365.com
 (2603:10b6:a03:2c1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Mon,
 21 Jul 2025 13:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Mon, 21 Jul 2025 13:54:18 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 2C0FD406541;
	Mon, 21 Jul 2025 13:54:16 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E40FD820249;
	Mon, 21 Jul 2025 13:54:15 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1] ALSA: hda/realtek: Add support for ASUS Commercial laptops using CS35L41 HDA
Date: Mon, 21 Jul 2025 14:54:05 +0100
Message-ID: <20250721135406.366912-1-sbinding@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|MN0PR19MB6382:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2406ac49-891e-4b49-301d-08ddc85e166e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?73E5xA4b/hs3jT0HvzSW2LS+M0bV5IgrJ0LIdC1HjAECQu2oWouRnTXi0uhw?=
 =?us-ascii?Q?ugob6lDqcPzKiEzWS79bs+7Av1a123FvHVo6QCZ25YocPvzdpBRHadYlTJpw?=
 =?us-ascii?Q?HaiOEb1PvX5YjKUUiJ8fYv5FkpbxHUEzIHUaLWOZmTgbKOyl4MF8foEINwxD?=
 =?us-ascii?Q?1FPxbWjCrxz9oXk/qNwxKpJY3vhUr2bhhGo6wQvpIYp5UBVUT5gsCyxNJ9sa?=
 =?us-ascii?Q?roPBJJxIVxyWD3eTorEhSGwEVRb9WlhrIVXo/AsS1HwkJcJGlkGQWDF9hMeU?=
 =?us-ascii?Q?9hzt4Qk43YP4G0hjrITPIzzD+QRPZpYyina5FYN32UzDcapdtWpZuwJ8hlTD?=
 =?us-ascii?Q?bVzVk4ATurp/cBpV49SfUNTYFX/VW9nyl6ze7tz93iSkL+cPkAfg0QOQRwpf?=
 =?us-ascii?Q?UuUcv5Q3rKlsrOF4EQ38E9x/lL63zZaquwJT9zywd5TSqUz7CxyfWgUuTxoy?=
 =?us-ascii?Q?csQfQUXo9xd0NWWtYN2ywXS7c7Ns/x/Fxv5iIErtF23dWDzp9saITpi3Pkmz?=
 =?us-ascii?Q?F5tfcU6E837E+odXOc4aILtn53p5or4HWEwU2JOT3CjU4Ug+4eRWpDoLOnG2?=
 =?us-ascii?Q?U+pXX5URHuzCkmV5FEy8HQq9cyKjbXn9chF61v/NXWc04jb9uGiOPLMxyYM7?=
 =?us-ascii?Q?KS3J1zdCQQENPQX72Z7YO07BrKWtFppIANoGfpER21r6bAsPyiMIZznwTZbB?=
 =?us-ascii?Q?1w8q1cPogXHKIZG/8CJ5D1gS9JIem7b6Lj+uXzn5+0ojpllhnE0uU6xERLqF?=
 =?us-ascii?Q?BXlaPSuN6RQ2gaz5PN95nW0B+WaUsdgXAmV6J5ePc3Wc5oV3zNMJxikaPyO/?=
 =?us-ascii?Q?dMprPDkszccMEHQzbf9bN5RCA7g8q9UsN0BuzPWiIk2wUcj5ryHsaQ7abInT?=
 =?us-ascii?Q?VXUmXtJi2qg3z5awdOTCnlvbpeBgR4OnmQMAZKzpndv9bRr0nJwNsAYY6GN6?=
 =?us-ascii?Q?a675BzhmS9KJyk0g6uyElYv3Yqll8xeTb+IajTFFJjQnvNxKAJzLKDoQKANt?=
 =?us-ascii?Q?6Xkg43gOBFL/PRBtVowEh7hNXlXBymt3nqKGgAfMtVnCkHgYrKwdOqhTozPn?=
 =?us-ascii?Q?wjzfqDyN9VewmIwwNMLYYXlmy8xOv1aDiZOvMpNrF6Uw8ifnjH+2s4NfEWoJ?=
 =?us-ascii?Q?1s8beSzPQXdnCIm4gtxFIz6zYI0DNpCSj1A+qMkP54WQS4RRvp68faDTuoQO?=
 =?us-ascii?Q?7iOkdUKdMniCADEnRww9uPmBVWt/QqBxC3BassWaPn4YumkLxD4FgIKmMSB/?=
 =?us-ascii?Q?eDGuXDWk7803/2LEPVi7QxCCt0BM7CyVrHcwamO+amXNlDCZg7wCC/zOYlZz?=
 =?us-ascii?Q?cfEPT2V802252qhtv1ecY63XE2oMHoVtzpVsMFdnfRun+Codj89+Tt4KYMl/?=
 =?us-ascii?Q?n1U4Jc1EcvC5Qs4+wRdoKfBEDp7ViogapOun4hiOjxHa46pv7b3bXaRlCTri?=
 =?us-ascii?Q?ALx/DNT4gmCYt/8Vz/mWFPu6FbxBsf4hxSlsYP/Pb1a2ugw35HGnenm/Hsta?=
 =?us-ascii?Q?9fnwVFXWTjeBN2N08ci74cEV0+l61jfnLp2L?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 13:54:18.2007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2406ac49-891e-4b49-301d-08ddc85e166e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB6382
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDA4MSBTYWx0ZWRfX+6QNc6JMk/j4 94J09D4MyWFFQ1dQXVy89xMJSN7gMugMujOvCpP5PFuVaC69cn7E6ozIabd9X5HbzUxcQ6ZCRKG OHHYwiYsuTB8PN1YVy5ilvFMLrpDBroARrfY1G4v/6IysYaygMQz4BZARwmVJ7gg0YIBlAkGy7H
 QRBQQz9Rs6wjj7JI1Red9yLfyLksEJM833Xr3ltDoZh0ftmki99LkeD+CuV+nnWAO+v/Rc4fVuG tfufAZ848LzXRfeByOBMICniYf7Lv2yI4nv8KLjWpZ09KUU8dx1v7WxAkUxDcWaesI4kQ3WFAW1 lr3QnqyDNsYyyjVmqBGGY9pK9gWxrJ3EzPprYivb69DjhiKrwveUJll8gFfhLxpZOKwEPX6zfEo HR8VlEfC
X-Proofpoint-GUID: NPlMSCAHTQ1F4iHnc6y-HRwKZ_WD36xM
X-Authority-Analysis: v=2.4 cv=O/85vA9W c=1 sm=1 tr=0 ts=687e4691 cx=c_pps a=G6ldE1qBn6ExQWwk5g5X6g==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Wb1JkmetP80A:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=7UmbU82e9aggkHxpME0A:9
X-Proofpoint-ORIG-GUID: NPlMSCAHTQ1F4iHnc6y-HRwKZ_WD36xM
X-Proofpoint-Spam-Reason: safe

Add support for ASUS PM3406CKA and PM3606CKA.

Laptops use 2 CS35L41 Amps with HDA, using Internal boost, with I2C

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/hda/codecs/realtek/alc269.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index dc3ee1256c2b..88fc835c7088 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6682,6 +6682,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1043, 0x1433, "ASUS GX650PY/PZ/PV/PU/PYV/PZV/PIV/PVV", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1454, "ASUS PM3406CKA", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1460, "Asus VivoBook 15", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1463, "Asus GA402X/GA402N", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1473, "ASUS GU604VI/VC/VE/VG/VJ/VQ/VU/VV/VY/VZ", ALC285_FIXUP_ASUS_HEADSET_MIC),
@@ -6776,6 +6777,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x31d0, "ASUS Zen AIO 27 Z272SD_A272SD", ALC274_FIXUP_ASUS_ZEN_AIO_27),
 	SND_PCI_QUIRK(0x1043, 0x31e1, "ASUS B5605CCA", ALC294_FIXUP_ASUS_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x31f1, "ASUS B3605CCA", ALC294_FIXUP_ASUS_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x3391, "ASUS PM3606CKA", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x3a20, "ASUS G614JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x3a30, "ASUS G814JVR/JIR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x3a40, "ASUS G814JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
-- 
2.43.0


