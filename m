Return-Path: <linux-kernel+bounces-856674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 110E7BE4C44
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 896F6356A87
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4728E3321C0;
	Thu, 16 Oct 2025 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="e3AFAV2j";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="vIhw++HX"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC5350D4C;
	Thu, 16 Oct 2025 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633946; cv=fail; b=U0Opy3UZ1pBpzkdFF+lJJAPQL5nJsG5bfLJaETXQcR4gsea1an2MNVChbWfTlPhyGRy6iwoHmTtKlTJgxE51UunH4830orPxcsJJDYfmuMbE1SwHJhW+1mIFvJCAARlX5Z+iBCrw2UZAo/zVoe4lyyCKNmmVnXcOuMR8bNepfLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633946; c=relaxed/simple;
	bh=V+mPpeH0+wG87aVEkvBSI3YjgqBRsVwdFkLpKUXR520=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgbBvn8kHcTHLK4tarQDxyVRfiXAwHTEYizD8iF3tbxZub/GWW+4R4ILDqMTSobVCpiPDwydFtOlFhHLDxCZ6nmk01cR4Ud6k3BGooraw43fVk0TK59DGwYHrWgq/0r12WtJxar2uoA4j7McmLJ1LTT57JOx99wfM2IrGZ87R3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=e3AFAV2j; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=vIhw++HX; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GGSm6P298642;
	Thu, 16 Oct 2025 11:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ElpuoXzvXliDRcAMVKqJ8c/WeTNHCYgy1BgcAAlmbiY=; b=
	e3AFAV2jOfflOxJBJpGHMfkplV5vLVCbT12m306HcTzZW+sis0WM6h3fuxDKcgav
	gPCsec6Nr7zdA4zLg3qnntmVMcYBGIMG0AGGNMjV7tlXsCf5Jc6EFcR7K7byRv7t
	iiyQ/mFe18met73+oiaxfhfZ81INKUb8JhdkGf81IKi1oIUqscQ2Siz5HtpWFaND
	Zh8sShNXJV6SYUB+z1OI05wifmf9LYYDSCrxktsgbrFd1eMoFNdog638Ws4t9o03
	Te2vm1zfOj2W+LItdYOoO4b79f5TjwbnJqG+YHMTpzgM5X1iOzU2z1pPKsP8xW9e
	J61Wq3VC3Z+M5xGrKVSkIQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021098.outbound.protection.outlook.com [52.101.62.98])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhj9h0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:58:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iw80lYamM2c2Aw71EsA+iF3JSgBbCkJzZk5ZV8nMvMJ+vM2Mtbsu99MbCzowY2ZxljNTKV7lX4jPiNRl6RyYuxv6Ph9KK4RyihJKhuwLMVWPcK5RWiGTh3F43I0+9G6oOqGEOw8CXJRr1p+V+HQKfMtG3QJ6a3Z4320Uuw9y4LqiMMlJDZ0i6twFXiRhhC3jg1P+cJ1YvLZ8CcN7KM++GTVW5GHsOk8BJ5bwKh4kkPHiI4DHMytdeYd/2OIjSbs4kaDhRIGjlXu0QBtN7uL0QYGCJnhK8c9WDoKkmmKHYmWTHz133NLuxJoccmwV1atYCxWZ/yTjTLT5XDii2oDSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElpuoXzvXliDRcAMVKqJ8c/WeTNHCYgy1BgcAAlmbiY=;
 b=CWTShw260AqgqottupoMHhYxyhpQJD4nc1uGmUpUfDTN+GSUFxOcHx0yC3OWEetkGFHBvV5moftq8+CFcxrG1IVuPN/Jxq5XkUvb/C+88mo3v2E110MKdjKEz/wkUGK8BhG56STJJlc2W7zTrs0ScomvcDn3B9TCBY2BpoxTEcfyxm+78GJcLAtEtMS+ZgRqwvpPGXZWsfjG/scajnzv/i1bYz8lX2F+9ds0CPrbp3CPLl+bz5VdM/zVNHqrhCmm20P4cDT23vZEwPfSsqqsRc9L3SvIyDEzW3nSxQVEqvy94QO3qAFithaoCaQmvucHITa2QQgBCPUv28tWgSjYeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElpuoXzvXliDRcAMVKqJ8c/WeTNHCYgy1BgcAAlmbiY=;
 b=vIhw++HXJJCfr9l95mbN7oqD3iRpzqVCDMrSIKBMpW0eCuHyTjdCI6Rvxya4Y9FD5k7n3Oq0ZY/EdzjzXxD45r/iCE0foArtAqUb129ueD8HrKyn8rfTaWw8IZTClO+E9vFWSwYyEtOqn4uxMDSOuz/IMASs9OxMZlccZ1IPHcU=
Received: from BN9PR03CA0081.namprd03.prod.outlook.com (2603:10b6:408:fc::26)
 by DS7PR19MB5949.namprd19.prod.outlook.com (2603:10b6:8:7c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Thu, 16 Oct 2025 16:58:51 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:fc:cafe::a4) by BN9PR03CA0081.outlook.office365.com
 (2603:10b6:408:fc::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 16:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.0
 via Frontend Transport; Thu, 16 Oct 2025 16:58:50 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id BF11C406561;
	Thu, 16 Oct 2025 16:58:47 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 6A20E820244;
	Thu, 16 Oct 2025 16:58:47 +0000 (UTC)
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
Subject: [PATCH v3 08/11] ASoC: cs530x: Correct MCLK reference frequency values
Date: Thu, 16 Oct 2025 17:58:19 +0100
Message-ID: <20251016165835.143832-9-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|DS7PR19MB5949:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0f653ff9-bb49-4852-bce2-08de0cd547ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p6BxTJMfmViXOTcCWgQqUtMagVO52hjf+0I0ZwE4+/liYXzZhw5PVqBEAntj?=
 =?us-ascii?Q?ZMeTWrRpWntdgwjL//Xpyeq3jXnDAc2rdvuSSm6vInAAvND2PF9SB7+ZDpCG?=
 =?us-ascii?Q?aVTZt3KvQJSIT/qcBTKNfC8v5tCsjFqfp6mujApepEhmI38Z5lgqs+rUtF6h?=
 =?us-ascii?Q?3VOn+b3CeJlCEcMEHzg3L7KQ0pfgIvDbvw4x7+K3wNvM9BpbypvsTVLpSIiM?=
 =?us-ascii?Q?CxPiAKs+dPPGZu7NQULmKIYaMpm6NoVGDBwscYblNeN/wnzOKPVZcr6+rMvL?=
 =?us-ascii?Q?e/PunEvWP5zFoa1QJE1pvODj83NTpLKIMoUGfTb39pPBTUfVgMU3ILKuvz+V?=
 =?us-ascii?Q?C81vLU6FGmFYB6+3/g/mPILgCY7hWyZG/Q47D0FaK1mBUGSf9Ykd3GdGnaAq?=
 =?us-ascii?Q?oHr+Yax0tH8FlyMNT2ZkR7J139XsJxpvfP3HoABYlW9oY2Qwkvp/eWG4O//G?=
 =?us-ascii?Q?oiAP5QbM18pYysAxLyC3xZCbX7zKsspqgU8igJJ8X9xTw1K2cKYQ5zKoIuRE?=
 =?us-ascii?Q?3Ql+SjBvDpaeNAN5rOkyOZYr0jwLVfaPmH2zG6/Kv1TrMer68+/KuhTHQipa?=
 =?us-ascii?Q?llbIcXlkaJqYwfMu13qFnSf125WGjc5GddEdfe5Ps6SDcKq/w4+TpznrwXsR?=
 =?us-ascii?Q?ZIakyETqMXjRu1PWCXFQwQv30qkB7p8yfHJDPkykLwOIfDw6HCtNJVZjkuq9?=
 =?us-ascii?Q?UOLo9jzSYohtGaW2XYeSmYWYbfxPi52oIWepfjxXxY79Ku7QH+hVXy6Jm3+V?=
 =?us-ascii?Q?BmzLUgJC1WCkVa5YmE+AT6NvCvn4rduQyx+Vsa3DGCJCF5KE+zF9BZ9O7qT1?=
 =?us-ascii?Q?1Av4/pOIfF6rAOln3EvBjJaz9vrha8D1NObNy/co5b5+5c5Rduvybzgh21/i?=
 =?us-ascii?Q?sfRhBpva1ACmggTzUaix5ziMZghHQrdWRQ9z/jz2i58wpUAiJuh/E9X0ioi5?=
 =?us-ascii?Q?fN8aJrB5mtos1/MEw1CAB7wuu6AAG6lLiJA7AG0Mji7P9ZXPeeqWDoj0GA1W?=
 =?us-ascii?Q?zstRFX7jI+mksJh2bxisKwVtM134dicik4Pz+s2fnZ5l0oDIolxbDdmqC6b3?=
 =?us-ascii?Q?/RUJ1FCTweqKmBWbWjw9W2hIDYOabFS9DOTDyeZLohdVE+ZEzOu+NNeDY8YP?=
 =?us-ascii?Q?dmSojEvuTnGKs4i0gBUmT65EOIU4eaixl0BEH5WKtPRXBDmB/Ayk607/PL+4?=
 =?us-ascii?Q?Bi/z7aVmbnj7i2u6DgSJF6A1nBKDJxrwRqzvMcTdkzu1bNi3Aman8X9QSA1p?=
 =?us-ascii?Q?qiZvetkcdne9EHWTmOOO9vfIheBlwcX5JWr4STByU9STxETPANphwqYXSNcA?=
 =?us-ascii?Q?uLlqAqoj8Ew8hwPHeSQjc1jwEXSR3SUufFaqjQBoiFdbqVLMgmbBUlbIFyTj?=
 =?us-ascii?Q?T4IAYsUu4b32Mni7FkPpyB0ZA49abjM9mupGY+ZTzwSIACUIwJwnWz1XvU4I?=
 =?us-ascii?Q?WzVNn0hnLPwkUmYufcXhMfloF5VLO2IQd5UJC5hy3iPNsq6XmegdtPmM0EqB?=
 =?us-ascii?Q?FEUUSwsVc5f/IVXA8/faXTUCMYjDSuVF1qVokyPwRzKSz5yDNRmCmhnAmgsB?=
 =?us-ascii?Q?SvjH898JPH1mguFYxe0=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(61400799027)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:58:50.1060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f653ff9-bb49-4852-bce2-08de0cd547ab
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB5949
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMyBTYWx0ZWRfX2Rh6WTC7EztC
 8BA+B600gBqtAZCm9Y5C+RVLXByUOzSYPxFyfYvZIy7lSf/AM/jqfrUitL4ZlFfRhdocDPy9IQY
 KK3nbvcZBIoPa1CnFzDDPWHIBQKERXC0pZx33lagGBQoxqT3xJIfADK+oQfrBF5wTtbAn6Kck7y
 Wl4izZfRkVZMH/m7ZP/OnTFuQJcuqv0k+eAOPcwfiCEVFnM840sd64tefvr+NH4bIw2Oq+gwbdp
 hntypVM3MNZeLSjeKgo71EP24UVOuDoddvRHT5WvQ9zmrYkQ45sNIoiJQIXqGsn/LDOKGyNylVj
 KpK2n7sT+PJKGFRSAWBkIJEAQr1BYBTGBOGaZOy6hnJyNhm93W4ChVVjrSEsYVjxEG+RM3J1Ddn
 pxmqdK+cM92uz6hqeY1Lu7FWWv4wqQ==
X-Proofpoint-ORIG-GUID: Mb5rbmrP5eX_XuLIs1FWkXJtWLAdVGV7
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f1244d cx=c_pps
 a=B7IIg8ZWzcecfbiAWLR44Q==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=_mdxinBoC9VrpwbbToMA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Mb5rbmrP5eX_XuLIs1FWkXJtWLAdVGV7
X-Proofpoint-Spam-Reason: safe

The MCLK frequency must be 49.152 MHz (for 48 kHz-related
sample rates) or 45.1584 MHz (for 44.1 kHz-related sample rates).

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c | 9 ++++++---
 sound/soc/codecs/cs530x.h | 6 ++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index cdd050c0fa2b..f0c3ed931fa8 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -1100,9 +1100,12 @@ static int cs530x_set_sysclk(struct snd_soc_component *component, int clk_id,
 
 	switch (source) {
 	case CS530X_SYSCLK_SRC_MCLK:
-		if (freq != 24560000 && freq != 22572000) {
-			dev_err(component->dev, "Invalid MCLK source rate %d\n",
-				freq);
+		switch (freq) {
+		case CS530X_SYSCLK_REF_45_1MHZ:
+		case CS530X_SYSCLK_REF_49_1MHZ:
+			break;
+		default:
+			dev_err(component->dev, "Invalid MCLK source rate %d\n", freq);
 			return -EINVAL;
 		}
 		break;
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index 758d9b1eb39d..c48a29cad702 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -174,6 +174,12 @@
 /* IN_VOL_CTL5 and OUT_VOL_CTL5 */
 #define CS530X_INOUT_VU			BIT(0)
 
+/* MCLK Reference Source Frequency */
+/* 41KHz related */
+#define CS530X_SYSCLK_REF_45_1MHZ	45158400
+/* 48KHz related */
+#define CS530X_SYSCLK_REF_49_1MHZ	49152000
+
 /* System Clock Source */
 #define CS530X_SYSCLK_SRC_MCLK		0
 #define CS530X_SYSCLK_SRC_PLL		1
-- 
2.43.0


