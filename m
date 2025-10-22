Return-Path: <linux-kernel+bounces-865118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE90BFC465
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 836A3562EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B1434A78A;
	Wed, 22 Oct 2025 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="pwTRE20w";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="xt2FhNV2"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C44348454;
	Wed, 22 Oct 2025 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140401; cv=fail; b=BZ/YWJuQXva45wdzeLBGuhwWdfPBhS9RoFzrOv/tQaTsNIiyTGGXaFFd81IOewPJmYGdFHEPkRv3kaZvqHiAfg0rGn97Owas1pEoZOrSGM69evwRrdf3lj3IZhktniA6cDMYT9itsgcy18oGrVoP43eq+y9cOd7AVx6T+BCekPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140401; c=relaxed/simple;
	bh=VkWNmAom4yZLs2kIIQVbTHaSWDcVsPwBuAv57jzRieE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1SA23p17Oiy0rDkD6viP/0MUr4Ka4XziIyJgvL4QuUBsjaTfXPFX3toINQrDjWYz/JKdODMCLSCA49fVR1mfPchPcuPN/IUtdtv5hEpJGXdlhW2KPqf1b+qNBsyROAEcAcrEWaG7xb9exooMy+MBtGwCN1D8OBrheS/iQLGpJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=pwTRE20w; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=xt2FhNV2; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59M3j1f13660649;
	Wed, 22 Oct 2025 08:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=0bSUPCjIGHj/aI9WNbzu7CO6henZigYWn0VxlHDtUqQ=; b=
	pwTRE20wGDmvjcBRUECp3ZyhTDlWuiKlH2xSiLJat9GZKoOQlJDLTSQi5sa1ZJlu
	4viHzl2m4ET41OPSnXGiYFepXXZJgSCtppMfHzrFf+e2Ayy7BzxUeVixbU8UFAFV
	MYhlWE7FKKcjmnzKRoV7urDk7n6pO02wFWvlDO0oPQorVulA6xr9cZHLVoR1Wt9i
	CXRVfWpWvtduD2V8QDuHMCoOMegEAKcwtUwVF+nrkz05b425YxeHVV9YQSGui90a
	uVLuEoPzOzkp2yf6u8ArbPeUGUyQtUMACu9sTCXz8NOz3QiVrdQbFwYGX3/lw+mr
	qcmzciZkgOb+mnaIxahsBA==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022098.outbound.protection.outlook.com [52.101.48.98])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49xqmqrjq4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 08:39:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dItma8JxWaJ7CoBDVFRU5hhg3j3eH4F5sK2atN3KywrINj6VZ8B1EaUKFRGjBvbTc0R0cUc19G5/t6zx3NdUIsO5d2q7nG+vOQ3rm/2dhY0g41altXVDdN82zs04OT6kzIsOkIxxt12LpKhW9GuT3iAA6/3H99XlIb9arqDSuTSn+6yQe8TZ3TN5+WNYLsw2FE/EW5BkG5zLF8iYKdd4IbDlcZopAJuB6UBbUwxd7yGI0jMVj9cqnqSvecnLbxzR+bfviRByi5Kjxa02j7yiAsTAegX85qq2RON9ucGOUfT76gCg5CgvZPXGBeYamY7bUKLR4GlJuqh1FFiKrc3jwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bSUPCjIGHj/aI9WNbzu7CO6henZigYWn0VxlHDtUqQ=;
 b=wGbyk08jKT6MnbultZzYVbtj0/1moIds31zgwYt/o15wyMefNWLmzfvJ1Za2JzbE1g0vL5eLla5tIuXlnpX8JmD0iDv9qTKcRuhI4Nw1ihRcWKQgUBdoibdWgHaOvynJOWWBVjgugJ+8KI64qRClHRQ4c7UrwxGWYlEpKE5pAdGl3Mx9AeU23ru6N4E+u2jgGOeVvdKFY5LBYmP5uhpit1j8gBrMK+HgNk1h6XC+MlpBPNR6kdiHDLgZlc7yHgcIEVp4FWrxoqgUR9VVmRyUcQQKo9PK5coJL7Oh3UR1LazZivei2FUmGT4miNuE1k3qnYqgkYZR/R7MvLGBGI6YVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bSUPCjIGHj/aI9WNbzu7CO6henZigYWn0VxlHDtUqQ=;
 b=xt2FhNV21kND9QJLCPsaUQ3NK4xKIzbPybPRTWwc4Ax0yumpvtE+CzR8B8x8Q49uTCJVwTiclaon0xxnrWkZpjLBC2YjDjmgV6+zzd9mQof0BNtOSNsZTvdo0JbmdjDi/TDStxlnoP7Kh8OwgvX/JtQfLby4lUhPuIi1Q3ywn8k=
Received: from MW4PR03CA0025.namprd03.prod.outlook.com (2603:10b6:303:8f::30)
 by SJ4PPFBE5DF3644.namprd19.prod.outlook.com (2603:10b6:a0f:fc02::a4a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:39:38 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::62) by MW4PR03CA0025.outlook.office365.com
 (2603:10b6:303:8f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Wed,
 22 Oct 2025 13:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.0
 via Frontend Transport; Wed, 22 Oct 2025 13:39:34 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id E5951406553;
	Wed, 22 Oct 2025 13:39:32 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 87E41822540;
	Wed, 22 Oct 2025 13:39:32 +0000 (UTC)
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
Subject: [PATCH v5 03/12] ASoC: cs530x: Remove unused struct members and constants
Date: Wed, 22 Oct 2025 14:38:44 +0100
Message-ID: <20251022133914.160905-4-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SJ4PPFBE5DF3644:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 821e9e8c-5351-4afd-81e9-08de11707031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7iOsdHqqyMzbbO/AngH0N7fUFD4l6+10mHbYFVNDqvR7GaVv8B7z1ukpMH4o?=
 =?us-ascii?Q?7H8yaspv9ZT+v0Gs0M80CBnpWecHkDPLmLNv2tTGj1Y8hhFtUPvwaOh/QfDG?=
 =?us-ascii?Q?iMGDq8pPyd11OmTyxOsaL9YRTx7sCRA519y+zLTCsy5iiVvSa6ZC4ltYhwEU?=
 =?us-ascii?Q?f/Fu5ZyFiR3ylGfLJ8WX0jauamluyIb2z3XrQ+II+K36QgYAxIAazCJF7B8R?=
 =?us-ascii?Q?UOPRoKkXAR41f3so8tsZbZgA8kvTXADwO//jicRqpAwOk3sqiaAa82FJO3FS?=
 =?us-ascii?Q?XuvI7XIn+Hl1426sSd14YF0AoEG4FScHwB7L/TVC1BDpkJWwyAVCvv+kgadj?=
 =?us-ascii?Q?KvO70/fPazlXF9HEod3UN0ERU4RYDh2H+KMqYq93gLmyA/ipWoK5dbg2qYrT?=
 =?us-ascii?Q?v8UWrIp3y4L0/AZ+5FCHe+YouOkwljlj6wpSJhKeeuw6q1PIsKI0eel/5RX1?=
 =?us-ascii?Q?IoDsaMZmgv9uN9nhqqPBXS9QTPqn0NzaYjpnHLgVQ68TzVoEv7jkmkoQsYMX?=
 =?us-ascii?Q?TqR6500ocQWnXQZvdo5AAJXNEFDqt3h8gb5PIXSgTCAL5CRDRfVRKtzJO3YF?=
 =?us-ascii?Q?6+BL52i8ElUJDiT5foY9JErMMeGsY5kYmKLL/H1k7wVZWpseMr8eyhbiVK6q?=
 =?us-ascii?Q?Y5W/yGd6IiVjX+1+cxv0XC5FGAEF2jX+2v5FKEUI8SwG4ufdGMi/vgJa16Fv?=
 =?us-ascii?Q?HpbDUvp+ziDm0bPytJ271HjEx1NAp39YlgvBNfNux9XwOoalKac/7NWxWMA9?=
 =?us-ascii?Q?cpVp5TmCD+saECV9XqIe9UeDfv58trqzjKhOomFAdeK8UwMqupOsbnp9fonf?=
 =?us-ascii?Q?oHlDrXwYx4EpbMhwTxufEroNWdeHrkP2oOSZm1A703z7FqypVrmMbtnWUEkD?=
 =?us-ascii?Q?yqZ37Npm/YPPiNBmovOEqjOwbo96WnyIqpeWb3baVJRIOjPRf03eFCyZsoW2?=
 =?us-ascii?Q?cytgsi9ZvhLTRFlVxEyUV+38/qGCds1vhLHpqZJe4pJO/16ZyMhV5vhLtQvj?=
 =?us-ascii?Q?7TrNNIiUCMC98UBd8AP0PGfsa8oCHB6lw6tIHitVX6lXwT6Xm8yI4T5fybh/?=
 =?us-ascii?Q?63V4XjEnhgWU7ISXh/h9A3riOicpFgJdcLtnjO28R7Yo5PlJNXnumsno2LIc?=
 =?us-ascii?Q?Muumgf7URUwxR8PdiqTU8uiBZWA8wi3I2xsgSjjkqY3PM7OLCWLOWDekK4YA?=
 =?us-ascii?Q?Oy9hPYGaR6h960hZJ7/hNxHMaUObXSH4sU0HygA097cKUM5vV8hYqWwtQ84r?=
 =?us-ascii?Q?Yl9AbQ+LlsfXGT9oUrNOLSBc5KZD4afZz8gX6lHvogENZXVyE2A4M8hNUZOd?=
 =?us-ascii?Q?oq2+TPl8s4G46itAw5vFXsdU91+QJdppcBx7igmdZk1EizxD5I5GW6CC/kSl?=
 =?us-ascii?Q?n6g2wjv0SL5dHzBmgXXn7sDBXYbzPr9iuiU9foD5B8FUSLwwoxyLiEWEFRDa?=
 =?us-ascii?Q?Op5EbdLNuguymJL5CzEX+DHO8WrQ0ZbDoGfQe4nu65l/S1sHFqRiIpETacXa?=
 =?us-ascii?Q?bYzGsfmnZcyvRuF2eZh6EtEubAheJbNkp4TGmHLA8xKHl5z77bjnuOqtqO2o?=
 =?us-ascii?Q?3uu/Qhp4RwZeEXU3xUI=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:39:34.6209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 821e9e8c-5351-4afd-81e9-08de11707031
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFBE5DF3644
X-Authority-Analysis: v=2.4 cv=G6gR0tk5 c=1 sm=1 tr=0 ts=68f8de9d cx=c_pps
 a=JnPQUT+nmGgr9A6OKrSlWA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=BLJqTvj1dVcXa0-LLpIA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 9tJssofy5DXXlVBeYE2NBIv826tIJISJ
X-Proofpoint-GUID: 9tJssofy5DXXlVBeYE2NBIv826tIJISJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDExMiBTYWx0ZWRfXyJUuZfInF2zK
 L6BLzlIT2XOr+ssIZsWVJdZyefL00WAL4lcJPUDE0gnmPzSvTAeCS2RG2iNGG/b3X1fZjU87tWk
 /wUohrVbkluFLI9FB2sOukvj/hA66k3L2y38hx8hIV68EbzN5AoTXsgfW2f4p665zXl1MtirEve
 1wu6IUApHCc/7mdQiRXUGs4YC5wJqu0gLvYhT9h7QwIv7yxtBKHvtdNK8YCAa03MQUSMZZYIXdy
 mtfitP+DG0kVCjIO4Q7exo44Y8hNuSRK6EQ3rDVILMYjOFQPJjJTVeFyrixBBLsWZxp6+yj45/t
 X3E6Mq6lGf1YNVKSCAxwHCFusEnJAX7KAzCrbntSCzjAanP/687NHXMmsdNPRw8PYsyi70V4LUL
 5To1HzOKrPU1pYYXoMirdJC5dAmVSA==
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c | 6 ------
 sound/soc/codecs/cs530x.h | 5 +----
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 3a59eeba5e55..3de748fa5255 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -21,9 +21,6 @@
 
 #include "cs530x.h"
 
-#define CS530X_MAX_ADC_CH	8
-#define CS530X_MIN_ADC_CH	2
-
 static const char *cs530x_supply_names[CS530X_NUM_SUPPLIES] = {
 	"vdd-a",
 	"vdd-io",
@@ -517,7 +514,6 @@ static int cs530x_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	cs530x->fs = fs;
 	regmap_update_bits(regmap, CS530X_CLK_CFG_1,
 			   CS530X_SAMPLE_RATE_MASK, fs_val);
 
@@ -781,8 +777,6 @@ static int cs530x_set_sysclk(struct snd_soc_component *component, int clk_id,
 				freq);
 			return -EINVAL;
 		}
-
-		cs530x->mclk_rate = freq;
 		break;
 	case CS530X_SYSCLK_SRC_PLL:
 		break;
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index b325847036e9..5b47c1ae2a09 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -99,7 +99,7 @@
 #define CS530X_TDM_EN_MASK		BIT(2)
 #define CS530X_ASP_FMT_I2S		0
 #define CS530X_ASP_FMT_LJ		1
-#define CS530X_ASP_FMT_DSP_A		0x6
+#define CS530X_ASP_FMT_DSP_A		6
 
 /* TDM Slots */
 #define CS530X_0_1_TDM_SLOT_MASK	GENMASK(1, 0)
@@ -207,11 +207,8 @@ struct cs530x_priv {
 
 	struct regulator_bulk_data supplies[CS530X_NUM_SUPPLIES];
 
-	unsigned int mclk_rate;
-
 	int tdm_width;
 	int tdm_slots;
-	int fs;
 	int adc_pairs_count;
 
 	struct gpio_desc *reset_gpio;
-- 
2.43.0


