Return-Path: <linux-kernel+bounces-806283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F053B4948F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389E31692CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FDE30F7FC;
	Mon,  8 Sep 2025 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="KsvdhuiH";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="M0AHfy1B"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABD630DEC6;
	Mon,  8 Sep 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347135; cv=fail; b=ams8R1ZpuPhvBSF6ibiYEmmyBU3OaHFEJCWKBdKjB7fL9l46Ri5251FBl4rew7nw2fuUnVVLCITRfkp3lLOTMox28rdHMoGuDeOoFlf4VUU26piUMMBM0zHvb0mhekwMpLc/XjipPqNcOwQ3Kkm2YY9oF7GzkLP3LjlpTMe/eXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347135; c=relaxed/simple;
	bh=dgqUvgurBWL6vstHKCZHHz6jiQsOHyYp9ZPneVqWgog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCQsHFbAZ1TOTQDjkZ7Y6EtM1CGEH+jkdAIG6XWbVq/JTnQK29YPLmydxLNnuv/XLqsSherAuaFNho7UIi9fEIFqWoIvIe6+x9F9BpGbGLcAZQOcgEY4T5lQM/RmTLgDHO4xzbGbQaxdrnBZIzn/PBgYH5/nP06f+7ZY4evbawc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=KsvdhuiH; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=M0AHfy1B; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5888UUxX2151922;
	Mon, 8 Sep 2025 10:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=x9gRks5JjcsSpCMHUpNR/NWaGqDlrevQD7rqImIrMdQ=; b=
	KsvdhuiHaMWULhFzJ9qTB47pdu6FOe6JXK2xeHbKiwV65n2VtIMnEjHVyyVtCQMu
	8DD84Y7twbvAnwGwY/mBy5k0seeNnfbOogDIs5tYjzH9HU1V57PJkbRAnu3JHxko
	yWzQ84hZR0rTU81dZudbarDWU1NEF8TF3S8rH20YJF1QlVeh6+72iS8AErgRQz4+
	n3nYx7JABpFNrhuxSu3JPE2X5M7r896SfnKZmQYZePEv2LntlkBkdZjD3toGxVFm
	nkQkjg159XXwoRHxzXZw15BNgFLKqSd9x+Om/hzMPaI0cHcjlZFP0mdeqbZvDDzh
	8awB2VoL+bKxXlMlECnilg==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2137.outbound.protection.outlook.com [40.107.95.137])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 491upq8grc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 10:58:50 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pO/bSAWaXzYz5/3JG78wtYdR38sQXyAWd4sjh/lqbzhNNh01Fxw/nplDBaPoMw0peUTqzq36lcDQ5LI9TSqYFIxdFs7R6DnZJ/j/AJMPAFMmhulh950+Hrc9S7i7gFE9q+xyfklEfVVf/m9Ab3yYJbNaqQ/QwCHqQfsSFOWbJYFpiZUiSEnjJL3FCV4JYrRq8lLn8lE+fpBJqNm2M1XVjppL9+CQlQnKE5W9pc7MGuCsunGcNo7pw+b6ncO1wsSh5kY2T+NdY/uv1w7XPgXopjABjuv2wwJG8A2G5vpDNRZzkCiNZUgSQv8G/4n9s5g+aHStZ2dPeSnVGAH2VuD+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9gRks5JjcsSpCMHUpNR/NWaGqDlrevQD7rqImIrMdQ=;
 b=Sl5/y0TkDfjKuVPuNXnw4Ek1HUNGBEt6Ql0JtOonQ9c3ndVySwOoIKrRwOcTN3fSxuDvYrLOZhffQFWhjne3L4QMriYJG7iJMONlSyzacjOliRdvBCK5lGUJfjoe/ZGDDeYrw42fnfAo0APMp5YOOdoIhgNYSzmDq1WPDlqyGZ55aD3VyIla4ZN4qB0vlc1f4/MxB+qnW0NKCqEtjqfnAWVlo4qSfhYGhOQc4Xz0wxLps7tJeOwT4oQmoUziPxEoLV23X4amk5U4+ipXAREkBs770kebYpI2kRsRWo2xtUblnAhF9/PRpVMbsi3beERbLvYMjv6KmBGc8DXEG8KRvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9gRks5JjcsSpCMHUpNR/NWaGqDlrevQD7rqImIrMdQ=;
 b=M0AHfy1BmnadNpt/1LsOZZ0IP+ED2+qkEw4KXLTVHWoQ7kd3Iqw+cjxZl29cDM23iVkBgXlSEML2IoxYI3nXv02lG80jfkHNS+5dnum5oLGteIa91FjJuVE1WAcT0Vzo2Isyuc1EfTEpY14FVGWQ2gAUy1RaLi7NbJIsLrd/Zns=
Received: from DS7PR03CA0013.namprd03.prod.outlook.com (2603:10b6:5:3b8::18)
 by CH9PR19MB9370.namprd19.prod.outlook.com (2603:10b6:610:2db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 15:58:44 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::6d) by DS7PR03CA0013.outlook.office365.com
 (2603:10b6:5:3b8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13 via
 Frontend Transport; Mon, 8 Sep 2025 15:58:43 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 99C6240654E;
	Mon,  8 Sep 2025 15:58:42 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 87DA482026B;
	Mon,  8 Sep 2025 15:58:42 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 3/6] ASoC: cs35l56: Check for vendor-specific speaker ID value
Date: Mon,  8 Sep 2025 16:58:39 +0100
Message-Id: <20250908155842.599459-4-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|CH9PR19MB9370:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ca1150c2-ca9d-4f11-1c97-08ddeef09686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wqpoj5j3ULmbvl4mA6OrZ+17UltiPZ3i8Vcd4VjDqTdidz5WN3aEPNvBziE7?=
 =?us-ascii?Q?JgpVuJtr4lDVU/En9GBgUOKCbBqPyZZynt5etYTtOtCwk8gQQ+d3VBlBDGFr?=
 =?us-ascii?Q?xId0UQgBgeclE2qW8L5b/dtCGmZSkVkaPKXLRdbxZQfksPSC3qJM93n89hxV?=
 =?us-ascii?Q?gRerw0Gx4LZ08d9asaOpZYeI7usFk9TIAvaKRGm6KiyQGJUqiDc4s05ZwPOf?=
 =?us-ascii?Q?tGg8NCBPrhV4bMJHfJBH9RcjseGYJ15tHUEiG3ssnI8p0JB5GFuvm2b03d2i?=
 =?us-ascii?Q?uM/YKBhQ8yc1bjUAfcQ66wztIibtBws53eemDBnj/t94XnH4VLAVo2Muve44?=
 =?us-ascii?Q?yELrrXHqzr1GckkkAv/lsP+eAKWgs9+CxDLwhofLsX/TIKFCWv0cPjI+0ROf?=
 =?us-ascii?Q?VkpOc6a+lz4nGbOldxyQFAdNPZCbwktRG3urCW0OpmRdlUPFPhhZZdQPYFtK?=
 =?us-ascii?Q?M/42qdXclx1bq5+GKvx0j6+95Hn7L1wZd68LfDD8Iw8/uSL0iIBjFGj624GH?=
 =?us-ascii?Q?C2oxCv8t/S+EEKaRBhfrVb+T4c5R7BTH6XEWQEUgwCt/jLjCReNnEMRY4+eo?=
 =?us-ascii?Q?sP2j8Wzasf6QjuzX9Io7iYccAcL524kA34H+BGi3hyabbbdbz8bWhwqvaAYX?=
 =?us-ascii?Q?4VqHYKW98qZPdOOy+NLSQU+0068983qlBVwU+DpxIw2MWbvH/XiyRIaYjWol?=
 =?us-ascii?Q?4IkikMFrYOHDGu79gLfzOraTuaoGe/OUm0lxuCGbyoFCTZmrgTKrapbka223?=
 =?us-ascii?Q?L0vuGqJ3V39aqDSmAcpHJKiR5AlE5LnRktfQdBi/6PGOm8g6hp32366hIlBb?=
 =?us-ascii?Q?NWNaIcVU3rSRP/unZtvkWBnOaT6QxoHilgUx95F+rz5fIIms+QtnBdpVewBL?=
 =?us-ascii?Q?3Qlc9itmVDRjpIAy/k2h6kFn1NoU5Z6VMYHVOlOXYWbr0/ITJiYr2S5d7rcO?=
 =?us-ascii?Q?KRvSrjiNPJhXrVFjtpLIDgQZFdivv7lPbf81xElkUH6jssCc19isLLvDdKZd?=
 =?us-ascii?Q?dpWl9AQJW1CjQrNuei2z//FHbuSDmuvf9AxAPO98FvQzBpPA/YQ7v9FUg55a?=
 =?us-ascii?Q?qu0n0URQ3VK5nsxgqGB0FNo7PC9UCLruYW/2WIWO/FXKJztPiM6KKxfjSszU?=
 =?us-ascii?Q?uKQQ+xC0jy1yURLe5540kKo4Wkrqu5XZEPgcaF/BVjpl0UxCWoykP8+fAxhv?=
 =?us-ascii?Q?WzPmy2qs047+4ygjkWLSO0bkLjI/yoteXVj+RiBzhvalqmk3YSKNYol+B3E9?=
 =?us-ascii?Q?K0zRiwDjsWiLrCMt1A1jTZ360HzADN1QSJZ84wHcOIf49UltkQEYrQHX7GM+?=
 =?us-ascii?Q?eSmj/jqBGlHG91Opk5Ef4xkSEbgA4U0XErXqabrPXUYsXpIThuBBLl6mmuaw?=
 =?us-ascii?Q?Ocw8+J8F1nOo//sB9OvrdbJgiqo16jZ2i44yb8K5iLVa/OPW84CABhoD9JEm?=
 =?us-ascii?Q?r3dy6xPw+4H84GE2GGe0FDoNoE+vXEPHze2g5WaKe4g9VvOcrJh++eaEyLbr?=
 =?us-ascii?Q?E6eAIChyspLaX22w+d2m+eRTNbTWB4vxyqzV?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:58:43.8391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1150c2-ca9d-4f11-1c97-08ddeef09686
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR19MB9370
X-Authority-Analysis: v=2.4 cv=DMuP4zNb c=1 sm=1 tr=0 ts=68befd3a cx=c_pps
 a=FUT2VZ02y2sEaM13OGTzjA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=9YM_IZES8PAWDyRG2q4A:9
X-Proofpoint-GUID: Rem6pXxivpekMeIAbGJGFnfa8N4vB2s6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1NyBTYWx0ZWRfX94lStJWI3nKL
 tB0MOJbUS6Eaeibs1jsJtT+RBWhw8X0rGoik1Dz+w97Pkh0Qxn6qrDVwRNqwQSZTEpXEXmDHY4C
 Xn988ZsJoeNVxFOY3CsCIXzbUsJ4mHKkM6EkxrpmidmFdb5ALIz4Se1aQ+5rP5ApGfbypYKkkpo
 dhpWUnsn+5wamKXY0a3dj1J0jgl4zVE55GWVF/3hK5pQ9b/LKJ4OBD6vl2RWRxkzoJE0yGBZSGk
 PR+5S+F+bnj0xOvtIAvJqfoFMVzVdRp3/TsKBuu3CpuA1ayvZ8uH/Q52Kssw/CMqKihg/LpjkWj
 xz2NrrvNpA+dY01N0rjE7wiOHeAiN6Qj1aJ4cHJYeoc3ARCfX32Hyq1zRS76BU=
X-Proofpoint-ORIG-GUID: Rem6pXxivpekMeIAbGJGFnfa8N4vB2s6
X-Proofpoint-Spam-Reason: safe

Call cs_amp_get_vendor_spkid() to get use a vendor-specific speaker ID
value, if one exists.

The speaker ID is used to load an appropriate set of firmware files for the
speakers, and is usually read from a GPIO. Some manufacturers are instead
using a custom UEFI variable for the speaker ID.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56-shared.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 850fcf385996..95d018ecb953 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -1054,7 +1054,17 @@ int cs35l56_get_speaker_id(struct cs35l56_base *cs35l56_base)
 	u32 speaker_id;
 	int i, ret;
 
-	/* Attempt to read the speaker type from a device property first */
+	/* Check for vendor-specific speaker ID method */
+	ret = cs_amp_get_vendor_spkid(cs35l56_base->dev);
+	if (ret >= 0) {
+		dev_dbg(cs35l56_base->dev, "Vendor Speaker ID = %d\n", ret);
+		return ret;
+	} else if (ret != -ENOENT) {
+		dev_err(cs35l56_base->dev, "Error getting vendor Speaker ID: %d\n", ret);
+		return ret;
+	}
+
+	/* Attempt to read the speaker type from a device property */
 	ret = device_property_read_u32(cs35l56_base->dev, "cirrus,speaker-id", &speaker_id);
 	if (!ret) {
 		dev_dbg(cs35l56_base->dev, "Speaker ID = %d\n", speaker_id);
-- 
2.39.5


