Return-Path: <linux-kernel+bounces-806284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3C7B49491
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA431BC252C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDDB21171B;
	Mon,  8 Sep 2025 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Uvr1Lftp";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="b1MQZcxP"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B430EF63;
	Mon,  8 Sep 2025 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347137; cv=fail; b=s5zWB/MKDFL55vOE/QUEr3OwvtqmbZ/4e1uAtiwg96LD8il1z1Bky1PneZFE8IBsg4tJ5B/HfSoXjCEe3yuQ5nDNqbwTj5Rkg+xH0KuZ4mAYH382RfaFAsjcbE6cEKVe7oHU0tS5MwuxMII647sjckHbShLet2UOJdQHGe+Qw9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347137; c=relaxed/simple;
	bh=1CXFuIug/yMLtcH2kEgCQcxzk39tVwXaIoGV0g95s7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ni1QBJZPeZerVJCVR/wVJoNhpsxKd6FfZ12KY1+nyUtDima1VVsbsTwQ/9+e/VhMK4yz0+xp8Fl+wvlo2ctds9wKj81yxmvh/id9jxsTCw0naQqIxL4Zl/95skYghv11qLU5NtVGYMqQWSK2ChFfjWrS1zBesPa2iaNR6OYjkRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Uvr1Lftp; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=b1MQZcxP; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 588FuZL7812472;
	Mon, 8 Sep 2025 10:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=CPaObkdmYNBB+lBLl2984mLFb2yavzxJczSJv86UtP0=; b=
	Uvr1LftppQTgjWasmd8+irkqO+iD7f4JOH7Fh+8OjHG29wGViAeaSVF5ifXZf0s6
	68zFYw4lFJ/5wQJxHtUpN/CklX0EH4Mvm5/RAInsbimuzxvgVapA2/ssrHuVyX0Z
	V+pDH1GlmgPe5KZ/eKXNgQSgzehO6hz2K43JnhBYjYQbSriHiFLPiqkSaek6SWqH
	cmsnSTYVR2LohiW7NGbfer/PXUYQf2XyTl+GjpAik6qsWcoKdVuEyaPVhVzzE2l2
	nqOM0VC8BIb9NUOP92Y0CPJm89R88PWgvJOcZ+e1WwhYGqZITo5XFGZ4FsnCGPb3
	eSDLV5wgGzI/mgBFJ6USgg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2109.outbound.protection.outlook.com [40.107.223.109])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49227r803r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 10:58:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iafsuiMmS8IgaBk9nms4ojKZenp+skD0WT2OSuouov9vVXiGGJBr04CByLcpXHJrYUhteJUfUvc/5aklJkJ5Tj/A9WH3OvVxxyjChtyce0vePrdwdFvCByVTkMeYZOF1Uu/BHw76bpv7fzJMQsXW5EQ6H3BLoBhj0RCuWatclEwlFSLax/VkRDg7QHFJiFsYXdZ/Qw4PzqdjTRtLVaa7l70X765di9r+FD7Mp85xP82eZbadWbOoMwNu2HLKb/2KHl4mfF6t9iEcO3Yf/Rak7eJnb4NAQFXVQ2Lg1km0duUQ5dB1RmIafgJFNYt3di0j7eLvF3WrnMMHAeZaJ8lLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPaObkdmYNBB+lBLl2984mLFb2yavzxJczSJv86UtP0=;
 b=M85ufXTfr1Syl9XFz8B1KweNgjJgr+erFDxOrdDM0e2ACykFRkfjeClMqBmTj8uHe1kvAzmro52imnIjG/LJqw5S/6D83fb7S4iGX5fZPbZ5szThFE4RC/rXL0K8k8wI0Q2rmqmwly6AtbdHjjtbc0BbmQGLHQMNVwqfpp9wA31Nk5pokX1RhmXYwLdqAxPiqEbVp1BM3pcfCWvLkSe2e42+x7T9efzd5K8ScuZpdPkhM9VMJJGLxOziG3htmglrs3pVOMfPTC8+a2LD0gQYFZ6cnOBJTJcrq2aXXtj4MwjZrjq48phvWvD29NUd+KjKvy7ghSnuCcZW2dKNajflUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPaObkdmYNBB+lBLl2984mLFb2yavzxJczSJv86UtP0=;
 b=b1MQZcxPhwR0dBzIciknRmccq4rB6Bl+sNiBDD1WaR/2diCqOnATrZ4Zmxvpq+c5NgMFNZ2dNpPCKegjEeL2gcCm83d3UEmHaYTsFcZVX+O3tFi72o8j44iUEYAnjDyCwOpYnx9sHQcngnxyXFa0J61kYFvvpoIQoYfDtO3gIsE=
Received: from DM6PR02CA0056.namprd02.prod.outlook.com (2603:10b6:5:177::33)
 by SA1PR19MB8847.namprd19.prod.outlook.com (2603:10b6:806:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 15:58:47 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:177:cafe::5c) by DM6PR02CA0056.outlook.office365.com
 (2603:10b6:5:177::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 15:58:44 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 9CD7740654F;
	Mon,  8 Sep 2025 15:58:42 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 8A2E282026C;
	Mon,  8 Sep 2025 15:58:42 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 4/6] ASoC: cs-amp-lib-test: Add tests for cs_amp_get_vendor_spkid()
Date: Mon,  8 Sep 2025 16:58:40 +0100
Message-Id: <20250908155842.599459-5-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|SA1PR19MB8847:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8991deb9-22ec-4f0e-0933-08ddeef09718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v5cbk+n9OgCGqb2X/8sKJMj8F8Biy+hOdiCLbHlUCUIAl60nlyoP+8WCyemS?=
 =?us-ascii?Q?D6AhXT/It2MmJ2I6PslS2x7xlZkg85c6p7z89Bg6hwsDLOfVSuQzwk6NjUIW?=
 =?us-ascii?Q?6+0ACmdSZryyL5aZg+ffV98xswPgXPVY2ZiqOFKg29x74HoOja1b2KZ8GFCn?=
 =?us-ascii?Q?5EO0jxUm/jaaiMwSg0165dUYJtK6sKH9EC9NdGy1LzkWGUi9buYWLfTRIDdg?=
 =?us-ascii?Q?3BcvAMOb87fpkMMckLZRVtjmJ7jPIHf7SjxC4J077PBT0q7VHVZ9rvZf6wa5?=
 =?us-ascii?Q?4lyOd1xL8dDrRRzId4H6KxbTegQWT7uQWfjKwqq8eSw6Pv0wNdw4Zh6f2Aff?=
 =?us-ascii?Q?lcMPlfC23fWm+9gh25in6EGUWWYTYJw15xUhHGf2n8SsDOD3vJkfzkT2PH1S?=
 =?us-ascii?Q?mKfYnFiXuLlAt1rTxOsXhH8yRdEGkbGnw/ixXus5HAMuCGCaI48VPS/8bdph?=
 =?us-ascii?Q?s+6QmdCjF4UgJ9rngSdb2xb+JH0enH/Nyl/Af7lCPgNLbtDN1q62riawYdFP?=
 =?us-ascii?Q?cmmM/IZjxqUI9YZuKFK43+HxjAAZ+6QvC2DsA2jIE9BAl5jmHWiwa9LMsau9?=
 =?us-ascii?Q?/NddAEbmGGzYnibWZ1CnyISVc1ndhtuAZllKB2j6gTpqAOUOLQtIJIne3bto?=
 =?us-ascii?Q?pSHRqoIiQr+bjg831LHnyfFzJKX3m6LrdIS0Fy+0VhlaeV9Sx8x7rOl4k8rQ?=
 =?us-ascii?Q?P8EduECj1SvKu3vFZf4t4iIbHzTqXUrpR6Z2HpC0UtiXzeKusG2XO4Ykwjv9?=
 =?us-ascii?Q?rPp4MyjT585YuroH8ZjQ8+OHGa5hSvWUhTC2Gq8xCndx8/0Pq66AvKErdarR?=
 =?us-ascii?Q?6C5EpOIotFEzYd5npMo6kq+96Z2eFQmUhBsFmT6n99KbX61wnWhWPf1+3sZr?=
 =?us-ascii?Q?Nvj8SO/HmjMltuP8LLoLkNYLOZTkVF4t1GghVF+M6KkDmA1HZFdtS4UJvlrv?=
 =?us-ascii?Q?QHiY9bSj8AmJMybG3boZFzOubUOtgnEcsgkggpxITEANlHUGEADQS4l6Iz15?=
 =?us-ascii?Q?+BVtneJ2AV9HhzhsNkSuUaPfa0bAw9FvwUdrslgUOiJtNlr2vBaOYLjdFPEv?=
 =?us-ascii?Q?o+d/eijin+3sk9A/eOwM6Im3UC5rRgQ1RAvXDa0+SUMpg3Wh9xj4Y/DQ3uIi?=
 =?us-ascii?Q?wylN/FSkQTnTuf2rd++jS2XyxvH36YDtwQWKln9KPW2lXIIXg1kWkzSZsv+c?=
 =?us-ascii?Q?Gh4KqX2XyCIqU05iSrwzb6CQ22qB6kTd5TGIhTqUwDklwdKlUR8gldJXh+3x?=
 =?us-ascii?Q?B/L19Z9CCP7i4Oe6bPwmdS2uyBlE23qVjJ5/NFu21P/YHigvUeRUZCeZ4bGx?=
 =?us-ascii?Q?j9DzSfW9z9Ac+dkqE+KyR9gEd+JPuOkEMq7rRTF1IwTswdDKI36eaCcdXued?=
 =?us-ascii?Q?vaP99X5/1534nvNpFyqt0Dz/ZaQBzsrIjGk5syMS/aNARkliZgUVRr+zCbLq?=
 =?us-ascii?Q?31CbfL4Dx76LXZFFXhnQ/YJOx+OSS1YE0CXmG8AuSHVBGAdDiVBPSR/8Izp3?=
 =?us-ascii?Q?q/8G1Qc/boy0C5VQvtoPJ8YIP9MYAfbQQh5/?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:58:44.8506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8991deb9-22ec-4f0e-0933-08ddeef09718
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB8847
X-Authority-Analysis: v=2.4 cv=f+FIBPyM c=1 sm=1 tr=0 ts=68befd3c cx=c_pps
 a=JCInGfjmQJ+O+leRUSAC4A==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=VFd6b9-Wlax7agovK-8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1NyBTYWx0ZWRfX0py/OiBNDEmW
 XRPgmTOk7njoBwsoyf7usuHalohX6+Ryb8C4OaDXxcVCZu+G+5R0eDc0/VkouLFJqbfGKhpW7uU
 6ZfwQ6X5csMhAf4ZcW5gx+2kJmRAKVSRVrZE4hm8NoqvcJw1xjgRtpY9JJYeLFJkAbUPJdJ+zCI
 ZPG0yfxhdi6mCXNbDxgxUZK8Vv/Lia/xvWA4tGuV14OLHM5Nhvnj+jYkAhsjtT2eR4sdrij8gx9
 bfhZs6kRA2Mm+O5hK9VjBsRUB8STLsVnsrB9UjSq09uRS6H+WdK8QCP8yB3lsmznUs/MqTCU1wH
 ZzU+N2nJ3aPOOzSeI2w5g/94zcsfaacU5Ad+3o8LwTjjP+4Oz21UEyr0AgQUqA=
X-Proofpoint-GUID: phxarWg4V1CllDJhmRxz9woLOdxdTwSw
X-Proofpoint-ORIG-GUID: phxarWg4V1CllDJhmRxz9woLOdxdTwSw
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


