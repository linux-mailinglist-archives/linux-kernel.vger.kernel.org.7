Return-Path: <linux-kernel+bounces-856666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B13F3BE4C04
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C464359CBF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2829D34AB09;
	Thu, 16 Oct 2025 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ZDsoLqxR";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="xLSKSwQ1"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E8C341AA8;
	Thu, 16 Oct 2025 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633941; cv=fail; b=Tj3oY+Boi9+4piYL4oRgz4ldQwy1XyLH1qi88p9uM7hUtml2UuCB6PunQVKjQbTg1tqqqTwrmoWMBFOw45vOMh6my0TOZ7Ig7BMxOmxnIsbWEFIAO8NX7cwPhpnj989OX2mEV5Os6DQ57orTx0W00IqB/wJWAKoL+IhjwRltQmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633941; c=relaxed/simple;
	bh=QfzAbrZ7QP7zm+iYfmvYX+uXRJkeIsEL0rpxVlVTVW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QiI6eA9zupXiLzF4FgReZZYTq0xl2n33/bEJjBwkfBK7iT6v57Mzxbue1Xy94KU1ifhS+Rqj43/d30oxA7mClM+/6OTpA+Wb91S9FlUUXIJPBDrOBkxQss9k5/MV6XK0z16XLW2Tb5IBFOzgxo9kx2KUt6mXuwF2JtXQnJyngMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ZDsoLqxR; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=xLSKSwQ1; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GDT1ph4017700;
	Thu, 16 Oct 2025 11:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=efLGpdUsijDroiFjFKocPw+52LoKKBoglMzHJWAmAaU=; b=
	ZDsoLqxRXd7JFedBKt3nWUSvEqzUIPZFl1Jaepki/m/20kCJU5p8ANZn9iRZJhNJ
	gk+VZeLDhchsF8OYWbJCTCjNiVPNzfqjE7LtvjYUfG+8fl7L0qcX6Ee1LkwTs3Dd
	E5NZqwFT4WpVsO9oRp9zU4Ikmsd0km3uUP/NObZfObjGWf6XLX/4swwduR7SaGci
	AZ6BONUXMgm+eImTqGzsTbT64lRkUY3wJ7RA3GmPAEYq+qCMGf37qveLdv/yZemX
	/EFT/wl1hiookYROtwHwQ+Thb5hPVA6x+Q3KwEJJLLOleRuh3J9qm7GUTiwJZ/7p
	6e0HxrRkGegNmPpipOxX8w==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020118.outbound.protection.outlook.com [52.101.56.118])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mngb3d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:58:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmLnnZg8enl1Mqlf6L5t8GulMva7YK93rWw3Ty3x7QOWEaXGUzLZCPHMP9rvvCEAB4dvYm6gC3FIXEkTkaRr1BIOEOHK0i0z6zft9VtVBquNmHLwjQh/GKp92Wb2f7QhtEBNkTieQqBrjcgsPvr3jo/0cBSo0VzcIS64HCBKWLBsWjlMF27384xwBudBQXxAVF3e8zYFUtNw70Hw9+VcdHwa6DGNnaBrincbrpLNY+zEAyMjQlr4LeXuXRmNxaaCdKJVkvcCTebu4lqmeAJPUYASjEg7rTPGgo+raj54L1ygE46mJ/WUbN9uWbTyCg6LCZ7f8D1tGMeBF/t7euLzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efLGpdUsijDroiFjFKocPw+52LoKKBoglMzHJWAmAaU=;
 b=NhMTAbAjf2xCQW8ogdkEHCHQQhdwQnG4RIxzqlZB6aQmkxTORbMX7EEnJHFxiiODoQdYAD2TQSV6nGuoOHczLTeuA1ZAHjmg0RDVza0ifcEmGxr7mN+cuHc/qPaWjfVbi8zbSeuuibCsp8CiYBkhHiDVQM7YJIIISNCFNZ0z2ZoaNtpZT9BmuA5S0WTOEDbAVkTHWgumPt3Q8moWLVaiYeD8XZEw7X5OVpege1LwuVEuTcHL6Qy3nnj65J/CdqOjRcNa+O/GDNEEvh97Gp47XiE8leEv+lioD0vovyOFsBCefwZki0wdOeK4aDRHbxQhAyGBrhDmqFumIMCcTij7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efLGpdUsijDroiFjFKocPw+52LoKKBoglMzHJWAmAaU=;
 b=xLSKSwQ1dgfeA1T6bC3bjJlZClE0ji8Vhthi9OtDADPMhFwr20LS51tXRs5bEEoJH08xh7ZqiwPtIzcwo33qZVsN3oIA5ZpsOVQaEa2ZQLVJTqh8bLeDx3DDUK8lcD7pU+dSRsfRU+cmcroYugDD2CbS7g9PUvFEVPWVJNjTBKw=
Received: from MW4PR04CA0101.namprd04.prod.outlook.com (2603:10b6:303:83::16)
 by DS3PR19MB9581.namprd19.prod.outlook.com (2603:10b6:8:2dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 16:58:49 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::5e) by MW4PR04CA0101.outlook.office365.com
 (2603:10b6:303:83::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 16:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:58:47 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 71E02406552;
	Thu, 16 Oct 2025 16:58:45 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 1C023820244;
	Thu, 16 Oct 2025 16:58:45 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v3 02/11] ASoC: cs530x: Update the copyright headers
Date: Thu, 16 Oct 2025 17:58:13 +0100
Message-ID: <20251016165835.143832-3-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016165835.143832-1-vitalyr@opensource.cirrus.com>
References: <20251016165835.143832-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|DS3PR19MB9581:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d8054c0b-d642-4d96-d550-08de0cd54615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wKNX+gF2z/o00XiHnop/4gpcX6h6RK4eF7etF+SfvYy71rt3rxfCXELgmUSR?=
 =?us-ascii?Q?CjiRl5tEy+Fazy/7ajfq8C/0zjtRD0igr3kbzlDJg4C3zBtUdYUbiFgivJ4r?=
 =?us-ascii?Q?a++lnOMgFNAU/xEo9q9aXNSgFUPG/oeSDoJSvmkGb5KAgRhBc+N3UZ2m8WVz?=
 =?us-ascii?Q?tSZ6dl0Iwu3dgkR8ea/giZQBztSrsTL5zzFSfjmg+ZVkzabhj4mxwCoz00qJ?=
 =?us-ascii?Q?tADxBLUbQAv3USqjaDT5Lo531D0BR2Uw1g89lFottTmecBdN4qfXc14KM+mL?=
 =?us-ascii?Q?60GJ+hKMly36M5Q63BSOsMUQ05LWMDLciNcgxyG+VkndLZkjD2qdQb7+iSho?=
 =?us-ascii?Q?tuys+StIh3Kxztj87l45m3H9oiibYPeOv9xQFjIK5yVjGO53s4yPPwmGX9nk?=
 =?us-ascii?Q?vZxgqCAXkbD7RkphPTozkkTm3+h79L2YcUw2APRbbRSQ5PRLYRUU6oyORWD8?=
 =?us-ascii?Q?Wz6pYdCYCiVoQ7+HRay+idDnwDotZXRItpgxD7B6yw8cU/4NGG85+eisdl+4?=
 =?us-ascii?Q?40GnitO8J6j0MOqj4+PNg9MSL9x8INZS4h03zcz2THNvt4Vp3WWr0UdsoSwv?=
 =?us-ascii?Q?AcKEgkuAsPAFCFOLgA5yQqIaK7yc/Cx2YsXKDfnFT2YGq+IiH1N3um57TlpO?=
 =?us-ascii?Q?4OLqlPPOAfYhgkjvU8TOO24LWzuw3ZE8PAAUzcLpV3cDUsUjCMtmzVf9tF6N?=
 =?us-ascii?Q?GAtoIydjb0zcp/EJXB4aK+xc61+DfxuOoKM5y6j1UJuIp6f1Wh45YmTiD+nr?=
 =?us-ascii?Q?JBQCO6KssMKVR6s2NQdiJFT+JoQVg2eBB2rPg5TQLsR/Nqfvfal7Frcm9+hD?=
 =?us-ascii?Q?F9R/ZX0GC+x2lslji3eFzbkL6C7NO+dFbI93Kv19h9j6jdpOu1wATNtKGmcB?=
 =?us-ascii?Q?BBneGkb8YuNrXyHdS0+LHSpWB6LaCcRA1ylN+Pl2Sn/QXn8r2OU4BvshWUJT?=
 =?us-ascii?Q?bbL871K73pUR9aiu+4wm6YN1UScWPYiKBsBdWE04vFsziMLMyxjppjuGzVRk?=
 =?us-ascii?Q?eP8yHF9c8qv6TTT/wv3sAK2gwuCGm3yCrHLg0mVYxHNGZivJUTuswg5HD6jz?=
 =?us-ascii?Q?srEXVpoxsePr3PBjWtkveRSg/E6dOvMa9b9PdPUnuT20FCHCvZBKHQ8lNOLH?=
 =?us-ascii?Q?ArRWYTx/dAD5Uzn/rYvXkxkBJm8qgEZyknDXfkTNBegRbgKksNxS/grQ5kAe?=
 =?us-ascii?Q?0RULMDLNR6giCJZywCv3nWFph3x545Py8Awoxqxd0ojcmGPRmsAchLTctSvy?=
 =?us-ascii?Q?9fZwcXmXV7K/pUFvPVadScVTL66DVNWvZPLiGWeDUDHzTRcHcanK9A+Isodk?=
 =?us-ascii?Q?UmvQVSa9fWW2DzOBx7cv0DS875TbWbxSzYpHva3JvVmgAUjhDQXHl+2DK7xQ?=
 =?us-ascii?Q?4cj36ztH4KCbqUz+RLj9A2pL1Wq5t1yGFCV/ySI4uH1Y038B4EsfGr0oMN17?=
 =?us-ascii?Q?Gb98ddarVBFXYv6UI7CU0C8R6AMssgrIZQHXBaw4ZqRwEsIfLfuv+oKwp/PB?=
 =?us-ascii?Q?ycmQcKLxQmf8OwqJrVVMLu7N78jlCtHm0kB/UhyK4CLkn/MYsYo+Z6ua57u0?=
 =?us-ascii?Q?txZ579EQ8iNJ7OIvM0o=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(7416014)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:58:47.3198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8054c0b-d642-4d96-d550-08de0cd54615
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR19MB9581
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f1244b cx=c_pps
 a=WTYiPbwPEgbs67/cDcbz6g==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=SQtk40xCRQeN874b5x4A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: a4-VjLZ1_8DPKwGFbkw8Y7-RYUQ0Hz9I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMyBTYWx0ZWRfX4Vlcuib9Fi2r
 t2lvsFP3cCYpcQGYU4g7rcY42j7MAVA2DDLvj1WWFAjXMM2azCHizz80L55RsuM4rTmBwBCWnVe
 S3NCDKlFezvh2ab68a1MNqgTq4IryT0URboKtg6q0nGkTx4kFEzI18yRjRp0p4K9NjBmpgipd5C
 yjp1tbPCuBfq3kJFPiwvwPEq2Gwk5T71pTtGnAI/KmYO/dNDNWCeQyiSGZIGpSGebAmPwzXCXSS
 bnBC9NU3sVjZHH7tESycNM2S8xtMr9sbakEcNmL5G7X9bVOfHM/gn19a2cEUdMx1pQRzxoZdSSx
 5XMjbsxrtqg6jhqUJINUVHtTFF2AIPXdaxKcDqN98lq2vARe4FfToTgNuXrc1hhf8NSZaNLAeTz
 hxLuHE7cdMnYk5wzyS0l8y/aGMK9OA==
X-Proofpoint-GUID: a4-VjLZ1_8DPKwGFbkw8Y7-RYUQ0Hz9I
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x-i2c.c | 4 ++--
 sound/soc/codecs/cs530x.c     | 4 ++--
 sound/soc/codecs/cs530x.h     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs530x-i2c.c b/sound/soc/codecs/cs530x-i2c.c
index 22b1a4d6b61c..be80dcad3647 100644
--- a/sound/soc/codecs/cs530x-i2c.c
+++ b/sound/soc/codecs/cs530x-i2c.c
@@ -2,8 +2,8 @@
 //
 // CS530x CODEC driver
 //
-// Copyright (C) 2024 Cirrus Logic, Inc. and
-//                    Cirrus Logic International Semiconductor Ltd.
+// Copyright (C) 2024-2025 Cirrus Logic, Inc. and
+//                         Cirrus Logic International Semiconductor Ltd.
 
 #include <linux/device.h>
 #include <linux/module.h>
diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 535387cd7aa3..d016e8298a69 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -2,8 +2,8 @@
 //
 // CS530x CODEC driver
 //
-// Copyright (C) 2024 Cirrus Logic, Inc. and
-//                    Cirrus Logic International Semiconductor Ltd.
+// Copyright (C) 2024-2025 Cirrus Logic, Inc. and
+//                         Cirrus Logic International Semiconductor Ltd.
 
 #include <sound/core.h>
 #include <linux/delay.h>
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index f473e33eb835..b325847036e9 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -2,7 +2,7 @@
 /*
  * CS530x CODEC driver internal data
  *
- * Copyright (C) 2023-2024 Cirrus Logic, Inc. and
+ * Copyright (C) 2023-2025 Cirrus Logic, Inc. and
  *                         Cirrus Logic International Semiconductor Ltd.
  */
 
-- 
2.43.0


