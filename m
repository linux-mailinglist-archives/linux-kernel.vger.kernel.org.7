Return-Path: <linux-kernel+bounces-865115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE52BFC477
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C186561F77
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E963491D9;
	Wed, 22 Oct 2025 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="UKRWh0kH";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="JJxRpOtV"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BB4347FC3;
	Wed, 22 Oct 2025 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140399; cv=fail; b=B7eLKMamey8R6HJL01A9yQXagLns6xF8tI92MBtBj2se0+9k0iF2hG2gveSYwqnUxWQC3mSjM7/CykqK5Oowc3r+flcO5Avimn44zgHtMie+/lI00NuwfJKInIlnPnavhSOtC9hI7Riyt8U+1EqTbXen+YmE66d88EtmxGHBCUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140399; c=relaxed/simple;
	bh=58Igzqo8xPvA5GczFjIdPzhCfiyLVgtxCDASU6XfFrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVUJnK+SyLSiu70wDBBx0AykXPZbAqXDXR5k7PnU8bGYfragpjlCbZq+wcM5BTiOd5uF5fWcvloaIcZH0g5nfJ1LRHHDOogwqBlV4SceVpHhU8SFJBau/6qsY7Nl9UyM+aNt3boyaN5i/Za5G3t/pXl4ej2wJtC5II4Rl4SYUTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=UKRWh0kH; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=JJxRpOtV; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59M3j1ad3660629;
	Wed, 22 Oct 2025 08:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=s6N25oPFsBmRPjjfuO3BEgscceGN68YB7QwHApGCrM8=; b=
	UKRWh0kHucn2/F19WzCUqIt1w0r0uQb4ZQwrQKwWcYtG5FNCVMnGja1n+EPoF+JB
	1izHKB+PMAtv8s0kztowMQ4LkpkXV6Ac20ALkCNWDn00kXJTMrj+IN0mTAkmQ/ey
	OWfwzBr/Ydan8qbstBf52N/QkxmF4QCALscsWXj69l8srywACk7IIAiY7DoQwiIO
	nGK6lbXX7JUGVPrfuHhT6dUy7SA4ejNZ/uch/h6pZfL2/25fGUDhCYYrxvKS94Pk
	aEbhyq/gxIPg8t6R/3Wy/u1xQbDCkoh2FbrTLjE6saYYqHHhvms0Qa0VFIICG0BR
	YOR+WYHzEd2E//oltWcq6A==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023099.outbound.protection.outlook.com [40.93.201.99])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49xqmqrjq1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 08:39:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5CLBzH8S/WCfAORmxC1VoTnLp4CSwgCrKDadLN3hDifwji3JP9yiMkpGyemNaOYJCRQfAKj/XC1yAv4U8mE8aq+hZa0ynsfDhQ5cQlpbSvQE1HF228E8lfu9gk2ojc1b+XedOuU8c94Q6D/ZCUoBpHltmq1Lw+/orAkgtpIRzmqH8reBf+cYYZ8tCD+NywlU4QBOTOBeHO8xA10GKKvRJolDJyiw6YZAXhRWTN/ihqNY+Kd6yCicF3LrwFbj3bUI+izyAhCk+2W5zdKXNb0HNxGXApMhgEAe8kqoso0EwYjrK/aun6cxR1lP6Zk7YhQC/N7zy2H3+msfSKWAvj/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6N25oPFsBmRPjjfuO3BEgscceGN68YB7QwHApGCrM8=;
 b=ArYkCB37aE683gbv3vtqJ7OLdriV3FPCNWSldDzOZPsgzJ5evKz5O3tLBSmobf4+Ir+41q1k/o05jg9joXlKPLSnCeUnEvRABNHZdkati9ji9AgDTsFDj2Svchjlneo4gnLvGocOIIAMRTB76QPx2am5loDRl4P/AunSLgA0JN07iswH2xI6qizqIIHaJ080kt9qYvvdSWbXn/Eo4DkljfZxQ0dFrhBDBaz3E8jdSATiHujOjIxJKIDWk3pz+qii3tnCalTA9yQueKvOUTn1t4MCkame5WhGl/6EOjofrEC8e2s0RXNpcVY9f21SV2KYx1tyivuaCiOcM0md3rLq3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6N25oPFsBmRPjjfuO3BEgscceGN68YB7QwHApGCrM8=;
 b=JJxRpOtVM9mhFgcWPq5ZfJWoJJOUVVXU4vM9FyOSQlik8vpqCCSM8rmUN++dOZJ1/g6xoVHnaNWDI3PuDtJkfUc83ikk5kt2JcBJGzti+gtboN598580+lJuvnYrTR54z6bfMmyA1OKGube96U2Gbqle3ApBXHEuzGsVs1Th0V0=
Received: from SA0PR11CA0195.namprd11.prod.outlook.com (2603:10b6:806:1bc::20)
 by MN2PR19MB3981.namprd19.prod.outlook.com (2603:10b6:208:1ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 22 Oct
 2025 13:39:37 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::52) by SA0PR11CA0195.outlook.office365.com
 (2603:10b6:806:1bc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Wed,
 22 Oct 2025 13:39:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Wed, 22 Oct 2025 13:39:36 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 48560406552;
	Wed, 22 Oct 2025 13:39:35 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E4E6E822541;
	Wed, 22 Oct 2025 13:39:34 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v5 09/12] ASoC: cs530x: Correct MCLK reference frequency values
Date: Wed, 22 Oct 2025 14:38:50 +0100
Message-ID: <20251022133914.160905-10-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022133914.160905-1-vitalyr@opensource.cirrus.com>
References: <20251022133914.160905-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|MN2PR19MB3981:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ad86b6fd-92f1-48d3-773d-08de1170714e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|61400799027|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t/a2z7TzN12S3cG8oh7CyfahdL017Ho23ViKhmra7n8Qy4DuNd11RhhTqiUG?=
 =?us-ascii?Q?mMICV1PGdbV9vrQE9qWdGhXWNMgCQD9i4H/sIfwvahhrVZFpDLniesJ7fe2w?=
 =?us-ascii?Q?f46pN+yQoorQtrK7/yGyEYxldelj1vsZDaeSJO0kZY7lWN4qRu+sfgfeLy8Y?=
 =?us-ascii?Q?jvHCEH/takJh7tdBipZPZiw1UX4A1P/k8oVBWJFhhcdLWZcsnQQI7TBYD5Jk?=
 =?us-ascii?Q?NGF3LDKLepD9ju9uAmPtvHLt7eKIAn3oUsKIicefZcUWzNoOIKw/VqajUqQV?=
 =?us-ascii?Q?jmN6aOuBRC9KL8tuuk2LzFwWVlCE5K949FsYYomiQKSzmfTPFYvR9zK+Yo/G?=
 =?us-ascii?Q?z0uMqxeUCVWlAVbwk5wSMZDwtXLM6Ods5AmR6f+LysZl1A4bamYs9rivHU1A?=
 =?us-ascii?Q?zwDueoSL4BamyrBOFrb3TOmEeDBaQ8EnhypoSBMDdOp9NBDyTqA3WB8ee3mv?=
 =?us-ascii?Q?vy58Uo/t44lj1xknP8RbumoV/ye0F5LSLuW2Da9nCE/sh6x9goWsLct7vI9M?=
 =?us-ascii?Q?8IS20P1iozmb6JWPwCbw+ZV5nEWXbbZZ3VydL7NkUXCzmOqh016U2DNBtIZS?=
 =?us-ascii?Q?WgkiMMF261oHW3hBC4PTXZqzuSFFgovFEX06pmQGcWygkQdHzJtP/+cB1hbo?=
 =?us-ascii?Q?2NA39SuDlbp3N9LaO/JYKaCSBmIvyrLKXuVPQUVM7uQDBMkKrLvza7mHmaoN?=
 =?us-ascii?Q?31RlVIhvPuE9oah3B8wWtAQxDqNn1v+lAXOcu9Qf0mBDvmvDzHCz8malCrv4?=
 =?us-ascii?Q?f+/kSNIp0P6HTvzGvj1MUddflpwmIsSMaSLfxgDHUuJYDX0ZxJkClp/C95KU?=
 =?us-ascii?Q?UrPeUzbnpU3oH6f2mwcDQIDRKdGMgjBc6JQEpOyRohBpjDl8farLWCU6S0fQ?=
 =?us-ascii?Q?QJFXwu/lM/yngU/KOzVClfZso0e7ZJRiGLGGs8zbX4Tj4z8ZXFTsPJVV9ecv?=
 =?us-ascii?Q?ShgDZCFiXkzCkYLl5UFVpyfTRKfvoiyLBqwlflWOo+xsc8oKYWyNGRyosSLL?=
 =?us-ascii?Q?kFpZuHcrdtuUrijzY8CMUxTPnqAvFOH2ectU5VJE+35Nl1ju5DuVAZz52ObD?=
 =?us-ascii?Q?2sK5j2ZNhfi2UntzDHDYCUA90Hr7wrMUb1vCAfh+6i3mw/cimt5/OBcMktqk?=
 =?us-ascii?Q?f8YaHq0R9zFBCwxs0LjuzudFbyMx+T/v+K+g98jNRmgsMHWxGylzzCdD3dSh?=
 =?us-ascii?Q?GcIx18CaJjLULJRSY/PhqDfky/ARdgxtb9TqYTc3mlYVIJ7E42lABQ2loQBq?=
 =?us-ascii?Q?PgMhEUtFBa0d+VsVrFlZIzTbcGlCCnuY6FNVIg9wEa4MoTdY2xPqzVezt4ki?=
 =?us-ascii?Q?D2+V7HWDk8dTIwPPZKPMlIeDLYDCXshw+R9j8kyYFEe6nv3dmbuuvybhd/nn?=
 =?us-ascii?Q?hTg8XbYLC0cZVczd3EYlifBQaWlXjWSelUVkoZ+lqVmjJhRKkhAHnqhFWqDL?=
 =?us-ascii?Q?oXwJuFTWjKZgK8Akb4u92EtLmCqTq5aNCQ0X2igwkMyoSW4ue1SCBk6sXHjR?=
 =?us-ascii?Q?nwTor1sqVQI2sGf66OF1qL470cSZr2F2BaZ3TsgxLVAbmyPPlgxZjZrEZdof?=
 =?us-ascii?Q?7nz5TPJMVAyYiyz+poA=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(61400799027)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:39:36.5412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad86b6fd-92f1-48d3-773d-08de1170714e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3981
X-Authority-Analysis: v=2.4 cv=G6gR0tk5 c=1 sm=1 tr=0 ts=68f8de9b cx=c_pps
 a=ajv5h6Eily4lkhfMD1AUMQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=_mdxinBoC9VrpwbbToMA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: XLYixCem5J99ONtEl3b9Y6NRqX26Hbj1
X-Proofpoint-GUID: XLYixCem5J99ONtEl3b9Y6NRqX26Hbj1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDExMiBTYWx0ZWRfX8XkJD0qyQwhq
 T392/yE8cvKl8WtsqbrivSZLALTztubhLj5eTPcDKk0+z04BHbpwzgm4lUa6UYUKSjmee542f18
 FWAgnu0RLfC3qYBzVv331JxHD0Ng0fnC+hztYHIVgKNQXaPRIkvUiJ2iFGXx7UAYc2t7yMNAO2D
 MN1WmDdf9dVArg5oqmB4pH8OTMs8Baj9a60PNRjc3/keSFWNdGqruK3FfGNf2RM86Q2sFZl7lWV
 n9MTX6cgJ69/JBons7sBlYm7z+ADsRznGhvQ4SH3aaY3ofo4QWtZjmrbxmoX617mgFEGL0DQiZw
 QGWaEnlsg+9YagD4FTn7f6cd1JaXEquWgO9+kj75RlOSOjc0gHThx918xhpJUeJ7gO1X6k2e7/N
 03Dv4cicUD/eESNoBy1D1P5/tn8l6Q==
X-Proofpoint-Spam-Reason: safe

The MCLK frequency must be 49.152 MHz (for 48 kHz-related
sample rates) or 45.1584 MHz (for 44.1 kHz-related sample rates).

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c | 9 ++++++---
 sound/soc/codecs/cs530x.h | 6 ++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 7dd9e5d19336..19fac4a90368 100644
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
index d11711715ba8..2c773c4b6b92 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -200,6 +200,12 @@
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


