Return-Path: <linux-kernel+bounces-808007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3FCB4AC0C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D46D3B4BD0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC85322A35;
	Tue,  9 Sep 2025 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="pAyB/mtD";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="cxJ1C0Uu"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D6322531;
	Tue,  9 Sep 2025 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417454; cv=fail; b=ZR6iyExShmrnz94lAiO7rKZlecpKwgkkcYca6eeSMvgVcF/JlBcy2bxb8hX8eutO/8AZQlJfe/l6SxIoTi4rTmucK2ZqwwdaHlinCXYMARoimP3+ViDmt4RqLiQav99vERkKD08hK+HxMWO11QBJK48qyWFimEGogrvJZWgQwtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417454; c=relaxed/simple;
	bh=1CXFuIug/yMLtcH2kEgCQcxzk39tVwXaIoGV0g95s7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0krqU9eT/w0SvZFm+gGu4cFycp5rx0537l6hFeYz9qL7lxBFrQUOOZooPKUmHjVK+5/Kf4F62t3PEOFQ5C4XRh4hBDeqbS+xGpcqEZQjeOp1w07adEGYXW2tIbaJmYrfdWXOj4FxWYdBbumDqLVhqtCkWi/TJZsN76AO1vUwig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=pAyB/mtD; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=cxJ1C0Uu; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5894chE14162663;
	Tue, 9 Sep 2025 06:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=CPaObkdmYNBB+lBLl2984mLFb2yavzxJczSJv86UtP0=; b=
	pAyB/mtD4Kev0ipQc6SCAN6MGuWyiK5sk+/wHkkYJVXJj2RQVSdB6eprB0QISzpW
	YfzNLgNa7cdE+obTJGilqlgxjT8fvHaWjN5Prrld5/jwg3uzyxx21BuJ9z5GElB4
	uIboXxTxEHs11EbujGl0MzKiwkxHD9bPSs5Kf88J87ZBisAOe/XdwvTFp0j6/yEM
	gzldAJHSFg9soNnTAoon2w2YS5b7T6zABFaUWpj8gV0w3+EcLEjeIPqQwswu4489
	70wjBAD9yygsw+FianUlZPs1tYe5Xw5bqVPRQ3CI332WF8KGyXsmfXGZ/BNiVqJy
	4Ank89c4l6/8U19B7/JsHw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2107.outbound.protection.outlook.com [40.107.237.107])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 491upq9k42-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:30:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itwvrcQIlv+QQ8XzKJ5Y3O9bfBOf7/ePuJZA0k6Y3wAOitB18Ucdmxs7DEKHB578+kv/THbpu1szYzQ/CzEXtfsW4ZwS6x6JCxJMaNxZjq/9TDI3MpeyEtePsHtpRMj85yLrFNliwDeDHByf+1GzRh0jQAG0+v67wpfudvRPIiE3IhmOM1U0SoeQ6c4F8qOZoMNemdMYMezYgGKnsUz17nPcZz76QxtWlQGhPNyekL8YmQducX/tkPwWffOABBQhCXGLKSv77cCqkRfwpwf90pL30iIPW74Nqf6RFMAuRVURM3v5Fl+9athmY4pJNP0VN7NwTGgKUc3jo89oIMGwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPaObkdmYNBB+lBLl2984mLFb2yavzxJczSJv86UtP0=;
 b=CWDQ2xDY+lmJrlAS8eZn8sItV6MrX/H98ykb4Q3RdhEquYaBkzzWHV41FKWzLBhteDj5bQz0Kei5fprBGBEPTnPDSRWtGCkBT4v2pWX1wkwB3DoqPl6lsW/XsLYwBy4/Rp++fTFLG0AeR/HvrcKXA1maPOqE+XcecBIA+k7ci9mxL23tksyJIMKQVAacN1iMTV3t0GDQlCPO2U1aP2M4Dt6RArA1M8a0KsNRj1ehlhc4kMS0tl2nJTgoVXAXg6oLL7i7FEPdHjS0OdD3gVzy8oQXgcjCO23rhItYKhYCtI7MgtFIYLja1UBFVmDD+FuZZXpli4wKFTVAU9iVycvvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPaObkdmYNBB+lBLl2984mLFb2yavzxJczSJv86UtP0=;
 b=cxJ1C0UuwFpN2NLUWXlSu7sj3xN/gMSNBZ0bQ7jJmTbi/WKtzdTKcooCOxPuipMdqJtgmV1O806y9momcxuInU+2gvjxW2kFp8Uxdxa7kJLIuT5zIOOXS/17dSgysB84bAahjHwalNKsAKFa3Zvp/LGJed/XXRi61NNbNZMDhdA=
Received: from BY5PR17CA0026.namprd17.prod.outlook.com (2603:10b6:a03:1b8::39)
 by IA1PR19MB7964.namprd19.prod.outlook.com (2603:10b6:208:44f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:30:45 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::be) by BY5PR17CA0026.outlook.office365.com
 (2603:10b6:a03:1b8::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 11:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Tue, 9 Sep 2025 11:30:41 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 4467840654E;
	Tue,  9 Sep 2025 11:30:40 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 329F682025A;
	Tue,  9 Sep 2025 11:30:40 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH v2 4/6] ASoC: cs-amp-lib-test: Add tests for cs_amp_get_vendor_spkid()
Date: Tue,  9 Sep 2025 12:30:37 +0100
Message-Id: <20250909113039.922065-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250909113039.922065-1-rf@opensource.cirrus.com>
References: <20250909113039.922065-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|IA1PR19MB7964:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2d4ca1c8-4f0d-488c-acad-08ddef944f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lZ1adSxfhSR1KUe+nDC/qOzqvFNEubYxJWUpD6P6cAM+sYQTBOA5qYxa/Ptf?=
 =?us-ascii?Q?IM9DfFIedJtaWNWiCuoe9hVDxwKG4444q2rMng8vw3DYMKYG66WpW5vYnfWq?=
 =?us-ascii?Q?XaVslk/41jfeBKZDjRZt8c1iRHGhmCnH4RC94gIq9NTv09hA1/cL0JOUVYSL?=
 =?us-ascii?Q?pbJB/4JWJbmU9E5u82orH/kx671wO/TFGDe/outxCg1sfQWyG2dKOf3VE7Hs?=
 =?us-ascii?Q?qhZcB9jr4I5bpzLSiDKgljBIaiJ6zdNItZ7hb5CvygAjTlYeA1MG0kTAmGto?=
 =?us-ascii?Q?OOVmBSpww9SYvev3NVlGy2vX1l8Eq2jygLQ2VAx8J4Uosoar+IS2Ip/mT2AI?=
 =?us-ascii?Q?t1H82VeViucJKGbm7fGGR3TRdY0y8z5OU7rnD0TboBTyhxYzvONgkR26NG1O?=
 =?us-ascii?Q?sGyHFmMJOe17qtRFLUOgM9BHh7E7KJ/PfkebI6OeI7XkeFv+9wKSmaMZewtu?=
 =?us-ascii?Q?XDYN6qJ+IRCfzlezu6tkYtjfRI3xoGxiUpvihGp0UQ61DOwAnwpXzXn0sQGh?=
 =?us-ascii?Q?BTGCX/UmE+cQzQtD/w5THiJauGQzT6sG48iu8+TWLf/NAt+CGftH0U0MeUJt?=
 =?us-ascii?Q?ARs6hV3ZxAAUuZHMiwB1WZc56EvvhjP4clxxgQnA2H5mol4Umfdgy9vM0sRi?=
 =?us-ascii?Q?smfwV9166ZLWXhGnwkGHX37QDZmDcMjRtSW9Ap+P2BcQ1EU/ngY/JW6ctN8X?=
 =?us-ascii?Q?8E2z5Tn7LSQmDPIuKi820A1+7ybZxffpRawLPPx59BwPDMODf0hGdgTuXvEJ?=
 =?us-ascii?Q?rHps/6etC0Xx3wzyjTAXClDDQ2i7uAf1FRrf93/gUulUP8Ptlere7RdSB/eO?=
 =?us-ascii?Q?ZJ9hNpiZbP7QXuqzuRneaeFeTy+z5/K20iJ0MoSzPglRUWqimiCKHs5r56yz?=
 =?us-ascii?Q?sK/TminFjp3VYciU9sCZEcg8MsrogsnHjLGqnY93e15M7b7GQhjnORcNqG5X?=
 =?us-ascii?Q?7WuZWcQewAwsFaywp7dw/XcTVwvi+Su7XE5nCcQhIMPlIKdaOgrQAuSqNxIj?=
 =?us-ascii?Q?E6sbysdXynNxtI9mjuiDKBmun0DN4HPD5237I5vABafs02zv57WM5OEUBC1N?=
 =?us-ascii?Q?VTOiStjx5oPbdKCdFSD+v9HrtX+Cxhvp7wVv60+t8THuMpwL7W1xL4Eq/5a3?=
 =?us-ascii?Q?oDa144mjvp8/rrXgqwOQ5tJ/00TdqsyjO0x+s4cXkoSzEV9OleG5D/Y2mKjo?=
 =?us-ascii?Q?8eqAF7HuXIFl7Xg9hmrNFS66ocdln4MaWGeyQVbme6+BBj3sE/PQf+3qUOd3?=
 =?us-ascii?Q?Cr2mXAOmVZcaQXKuHYOPq8qj12jOuaoHpJhiBMJe2r8RZp7otwaTNiIAA91I?=
 =?us-ascii?Q?02WiT37/+jgiWo7ZMgawJEHTVN77olysvElQHlAOy1h/dES2syMpwEUeK9bj?=
 =?us-ascii?Q?AddNCE3a0DJ6A9EYfwklbk9IH25da0iJZ7D1lsouziKbLTtXPIZEFAQr9FSP?=
 =?us-ascii?Q?AucZMzmXRBltCULvVcDy6eHTKzh4arGZ53JOVhLFLggmpmPC1ubFK4WBMC9T?=
 =?us-ascii?Q?bCATaCBng6XkWURQSaCA77LrAztaqW8ZASJH?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:30:41.6507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4ca1c8-4f0d-488c-acad-08ddef944f39
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB7964
X-Authority-Analysis: v=2.4 cv=DMuP4zNb c=1 sm=1 tr=0 ts=68c00fe9 cx=c_pps
 a=uh+8t3r8MFU2BVWJWTlZiQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=VFd6b9-Wlax7agovK-8A:9
X-Proofpoint-GUID: gqqzkLOpm0HSHhSnZ_ZDviKPzgGtFQf2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA5MDExNCBTYWx0ZWRfX0Nbqbql5VZAP
 tZWN2aP12jDoq6Duz0jLNnhIzdhyd9vGzMx1X9ZbFYPid40ock/1Jv4QlBhNxA8nq6E1bBHitHj
 4uhXZBDzZLaPPh/GvTeojK92uiZ4Sn4BXM0UjAiJex+oeBYWQU2hNxlDbpdr7F8+tuXDrN6bwcN
 aoTUr7n3yalLMk/dIbNgoU3mYErGiqmMF3tPAcWAkPfFFUOSU9ZemCxuNuSlYJvU/OZdDNmYMG4
 Jh6HGYxtfLUSaiGMueNgR5QbhD09lsOP9txpfEThEwUDOUYhsc7xeNAB2cW0qoCslgW38mwi58Q
 +tnUAJ9Rp3bDIQiRbVhBY9aexL3Lyox5BVJ51esBiVuagAQMPPvMe0NESG0AW8=
X-Proofpoint-ORIG-GUID: gqqzkLOpm0HSHhSnZ_ZDviKPzgGtFQf2
X-Proofpoint-Spam-Reason: safe

Add test cases for cs_amp_get_vendor_spkid() for the Lenovo speaker ID
UEFI variable.

This is a simple set of cases:
- EFI variable is not found
- EFI variable size is larger than the expect 1 byte
- EFI variable has invalid value 0
- Lenovo UEFI variable valid values are interpreted correctly
- HP UEFI variable valid values are interpreted correctly

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs-amp-lib-test.c | 196 +++++++++++++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/sound/soc/codecs/cs-amp-lib-test.c b/sound/soc/codecs/cs-amp-lib-test.c
index f53650128fc3..e7492afa041e 100644
--- a/sound/soc/codecs/cs-amp-lib-test.c
+++ b/sound/soc/codecs/cs-amp-lib-test.c
@@ -19,6 +19,14 @@
 #include <linux/random.h>
 #include <sound/cs-amp-lib.h>
 
+#define LENOVO_SPEAKER_ID_EFI_NAME L"SdwSpeaker"
+#define LENOVO_SPEAKER_ID_EFI_GUID \
+	EFI_GUID(0x48df970e, 0xe27f, 0x460a, 0xb5, 0x86, 0x77, 0x19, 0x80, 0x1d, 0x92, 0x82)
+
+#define HP_SPEAKER_ID_EFI_NAME L"HPSpeakerID"
+#define HP_SPEAKER_ID_EFI_GUID \
+	EFI_GUID(0xc49593a4, 0xd099, 0x419b, 0xa2, 0xc3, 0x67, 0xe9, 0x80, 0xe6, 0x1d, 0x1e)
+
 KUNIT_DEFINE_ACTION_WRAPPER(faux_device_destroy_wrapper, faux_device_destroy,
 			    struct faux_device *)
 
@@ -642,6 +650,185 @@ static void cs_amp_lib_test_write_cal_data_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, entry->value, data.calStatus);
 }
 
+static void cs_amp_lib_test_spkid_lenovo_not_present(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_none);
+
+	KUNIT_EXPECT_EQ(test, -ENOENT, cs_amp_get_vendor_spkid(dev));
+}
+
+static efi_status_t cs_amp_lib_test_get_efi_variable_lenovo_d0(efi_char16_t *name,
+							       efi_guid_t *guid,
+							       unsigned long *size,
+							       void *buf)
+{
+	struct kunit *test = kunit_get_current_test();
+
+	if (efi_guidcmp(*guid, LENOVO_SPEAKER_ID_EFI_GUID) ||
+	    memcmp(name, LENOVO_SPEAKER_ID_EFI_NAME, sizeof(LENOVO_SPEAKER_ID_EFI_NAME)))
+		return EFI_NOT_FOUND;
+
+	KUNIT_ASSERT_EQ(test, *size, 1);
+	*size = 1;
+	*(u8 *)buf = 0xd0;
+
+	return EFI_SUCCESS;
+}
+
+static efi_status_t cs_amp_lib_test_get_efi_variable_lenovo_d1(efi_char16_t *name,
+							       efi_guid_t *guid,
+							       unsigned long *size,
+							       void *buf)
+{
+	struct kunit *test = kunit_get_current_test();
+
+	if (efi_guidcmp(*guid, LENOVO_SPEAKER_ID_EFI_GUID) ||
+	    memcmp(name, LENOVO_SPEAKER_ID_EFI_NAME, sizeof(LENOVO_SPEAKER_ID_EFI_NAME)))
+		return EFI_NOT_FOUND;
+
+	KUNIT_ASSERT_EQ(test, *size, 1);
+	*size = 1;
+	*(u8 *)buf = 0xd1;
+
+	return EFI_SUCCESS;
+}
+
+static efi_status_t cs_amp_lib_test_get_efi_variable_lenovo_00(efi_char16_t *name,
+							       efi_guid_t *guid,
+							       unsigned long *size,
+							       void *buf)
+{
+	struct kunit *test = kunit_get_current_test();
+
+	KUNIT_ASSERT_EQ(test, 0, efi_guidcmp(*guid, LENOVO_SPEAKER_ID_EFI_GUID));
+	KUNIT_ASSERT_EQ(test, *size, 1);
+	*size = 1;
+	*(u8 *)buf = 0;
+
+	return EFI_SUCCESS;
+}
+
+static void cs_amp_lib_test_spkid_lenovo_d0(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_lenovo_d0);
+
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_get_vendor_spkid(dev));
+}
+
+static void cs_amp_lib_test_spkid_lenovo_d1(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_lenovo_d1);
+
+	KUNIT_EXPECT_EQ(test, 1, cs_amp_get_vendor_spkid(dev));
+}
+
+static void cs_amp_lib_test_spkid_lenovo_illegal(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_lenovo_00);
+
+	KUNIT_EXPECT_LT(test, cs_amp_get_vendor_spkid(dev), 0);
+}
+
+static efi_status_t cs_amp_lib_test_get_efi_variable_buf_too_small(efi_char16_t *name,
+								   efi_guid_t *guid,
+								   unsigned long *size,
+								   void *buf)
+{
+	return EFI_BUFFER_TOO_SMALL;
+}
+
+static void cs_amp_lib_test_spkid_lenovo_oversize(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_buf_too_small);
+
+	KUNIT_EXPECT_LT(test, cs_amp_get_vendor_spkid(dev), 0);
+}
+
+static efi_status_t cs_amp_lib_test_get_efi_variable_hp_30(efi_char16_t *name,
+							   efi_guid_t *guid,
+							   unsigned long *size,
+							   void *buf)
+{
+	struct kunit *test = kunit_get_current_test();
+
+	if (efi_guidcmp(*guid, HP_SPEAKER_ID_EFI_GUID) ||
+	    memcmp(name, HP_SPEAKER_ID_EFI_NAME, sizeof(HP_SPEAKER_ID_EFI_NAME)))
+		return EFI_NOT_FOUND;
+
+	KUNIT_ASSERT_EQ(test, *size, 1);
+	*size = 1;
+	*(u8 *)buf = 0x30;
+
+	return EFI_SUCCESS;
+}
+
+static efi_status_t cs_amp_lib_test_get_efi_variable_hp_31(efi_char16_t *name,
+							   efi_guid_t *guid,
+							   unsigned long *size,
+							   void *buf)
+{
+	struct kunit *test = kunit_get_current_test();
+
+	if (efi_guidcmp(*guid, HP_SPEAKER_ID_EFI_GUID) ||
+	    memcmp(name, HP_SPEAKER_ID_EFI_NAME, sizeof(HP_SPEAKER_ID_EFI_NAME)))
+		return EFI_NOT_FOUND;
+
+	KUNIT_ASSERT_EQ(test, *size, 1);
+	*size = 1;
+	*(u8 *)buf = 0x31;
+
+	return EFI_SUCCESS;
+}
+
+static void cs_amp_lib_test_spkid_hp_30(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_hp_30);
+
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_get_vendor_spkid(dev));
+}
+
+static void cs_amp_lib_test_spkid_hp_31(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_hp_31);
+
+	KUNIT_EXPECT_EQ(test, 1, cs_amp_get_vendor_spkid(dev));
+}
+
 static int cs_amp_lib_test_case_init(struct kunit *test)
 {
 	struct cs_amp_lib_test_priv *priv;
@@ -737,6 +924,15 @@ static struct kunit_case cs_amp_lib_test_cases[] = {
 	/* Tests for writing calibration data */
 	KUNIT_CASE(cs_amp_lib_test_write_cal_data_test),
 
+	/* Test cases for speaker ID */
+	KUNIT_CASE(cs_amp_lib_test_spkid_lenovo_not_present),
+	KUNIT_CASE(cs_amp_lib_test_spkid_lenovo_d0),
+	KUNIT_CASE(cs_amp_lib_test_spkid_lenovo_d1),
+	KUNIT_CASE(cs_amp_lib_test_spkid_lenovo_illegal),
+	KUNIT_CASE(cs_amp_lib_test_spkid_lenovo_oversize),
+	KUNIT_CASE(cs_amp_lib_test_spkid_hp_30),
+	KUNIT_CASE(cs_amp_lib_test_spkid_hp_31),
+
 	{ } /* terminator */
 };
 
-- 
2.39.5


