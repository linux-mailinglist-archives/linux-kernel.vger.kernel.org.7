Return-Path: <linux-kernel+bounces-856649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE54BE4AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7724F1A655F3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B6A36996A;
	Thu, 16 Oct 2025 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VGm2GV+D";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="bzjnlL22"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577B434F46E;
	Thu, 16 Oct 2025 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633362; cv=fail; b=FLM+foBlqusSZda2n7H1N6aSc3d6K45Cv7n/jOB2Opv1r/Vaiv4fsx1/I+QhMxo+pRrGxelPO2yPSfrPQOXtkfxT6QchB32WYgHipFJN0D41hikJkP1S0o11fPYrM1uh/boWXI42aKg1II3lU4+2pe+DMkUGyanzIzMvTGNouXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633362; c=relaxed/simple;
	bh=ThIMJSqoRy+tRj1ekVlf8paXPbiQdKvteSTBc7DnWjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NfTCTKWme0voBQ2B8RoPByZo0eFXg9y56yxfIYtAz0tY/v8Kb292DKR9Wbn6lSne6nOKvi1HrGFgmwCkO1rAjjthcf8sc5h7fUUuKydC6SnnOSGaH0jvCDqcOnh2Lzzckbt1H+R047YvMBjLTjO0ifhjdcnuyV1rrlcuoc3xkeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=VGm2GV+D; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=bzjnlL22; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59FNj9KL298651;
	Thu, 16 Oct 2025 11:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=mQrBsJ/ApE/uMXZNJiEakG/6Ykphmnad4m4LnRuhi0Y=; b=
	VGm2GV+DOEGxc03KFHY52wlalPxuDqMFx7hzI5FtHcFGCILhlajHbCllw147WrJ7
	oBcMsDFmErlyKtoGLXSzipliOLkxxZkQIKoh3RAzQximrnXWuac7lpVag3+kc7T/
	n0qOj0tEXUvDwgJvtloZ5oHbpCFatfoqEgevwTK9UcYeQzdzsK/aiA6q6VAKCP22
	HIdBwi+zi4wveOfDIbUVeWnVcyuaFQbyct5icf20ISn8lL9GbkJHF2k5dyTjOeH4
	FeK/GFtxEJePWfRNC38tSdv5245L3FLo2UeSAIWy2ag3nFUC3NKAbdPJqcqU3k8r
	sfeE/D0TZ2cXWUGH6ZYt6Q==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021094.outbound.protection.outlook.com [40.107.208.94])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhj921-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:49:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+oYf0P+IeJxpXzyo05LCB4wALnm6RvmiPvcG3Gm4i1TZ8o0YmL7sJDKJcIbFTO7cR8DTCYe7efsCrtopKcEiZ4I6m4p045gcRg3K7JfeKSaLATHwweGSguCReL+3wooMAy+2pc6LL7Qf+XCOPkVlw1UYPga6pQMK3GbWjZbm5YOy+wa6CJdpopM8Itof8uEn3ralDTgMf8wWb4SFOJUWmKCGfWPvo9q5VJSWC8qqM3jvBc+45OigUCGfjWFAKPaX5sGsBnzbfwoJUpwOKHasJjYYS66JedWXgEYuZl+l/UeR3pilpK0mLHIzqMgoyjxz9yOTT+4QrdtUYpyIsJUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQrBsJ/ApE/uMXZNJiEakG/6Ykphmnad4m4LnRuhi0Y=;
 b=hM3ypOQt8gp5V1GP5tnOygRTxGG9SgekjDQ56Ff8D6IlFYl79B4WM2LGWH3+Jq9VROT62djIfB7xHtUpw5/Y3ekSrINBPFc5flVsjuxQAChA3DADk6XjzZK3r/znDzAsQQONpmWDXYpcvENRXPoUN8nbiujslO/PDy/TuDwcxoEYECEXnThtLRhbJ357fA5LeFUcQYcstIeBQOC0CruT8aPdoza1NW5mgeowbTOe0XCpuF/Se8wAa1aGU3LA/1oxiU3C0KF2Y/KWYnfZNMxLiRnuxC345lGDePdUdFKQ1TgYHTUy/BqTmk3ncoLvTLt0jXe6pXItInxAOIjW1xDpFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQrBsJ/ApE/uMXZNJiEakG/6Ykphmnad4m4LnRuhi0Y=;
 b=bzjnlL22MBdeVb6otwtu7LSbnnR+WCptUiL0k9/lr2G6KxIHfJlHd1qD3Sjq3VROAm8ULxKEbvf+MJLXGayBqgr7zuu13MMXDNAym0lZRvhu7fqveX/Fdxl1LIhyzoYtXO3iyFcOCKiKA4rXb/T8p0/bX3i9Iga5njbn5Xypy7Q=
Received: from BN9PR03CA0445.namprd03.prod.outlook.com (2603:10b6:408:113::30)
 by DS0PR19MB6527.namprd19.prod.outlook.com (2603:10b6:8:c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 16:49:04 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::53) by BN9PR03CA0445.outlook.office365.com
 (2603:10b6:408:113::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Thu,
 16 Oct 2025 16:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:49:02 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 0D80D406547;
	Thu, 16 Oct 2025 16:49:02 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id A7758822540;
	Thu, 16 Oct 2025 16:49:01 +0000 (UTC)
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
        Simon Trimmer <simont@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v2 09/11] ASoC: cs530x: Rename i2c related structures
Date: Thu, 16 Oct 2025 17:48:27 +0100
Message-ID: <20251016164847.138826-10-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016164847.138826-1-vitalyr@opensource.cirrus.com>
References: <20251016164847.138826-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|DS0PR19MB6527:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0b5fde87-fccd-454b-b7c2-08de0cd3e9ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2vhvqnSHLlyJQ4b0uBNxW+tq3uL2RmoSCkhOD+3vnDwzSYP61mXzO28aTE/n?=
 =?us-ascii?Q?m/0PHGFMC4vuSNiA/CEuuIyfohU86k2kSTgd8E2A86vT6VbrQo9DTRH1Bmve?=
 =?us-ascii?Q?mD0QVwa2/AXjJCI+luJE4Kfk3JWthdNjgCsCTYL56EMm6m/7Zmjv2kzc3tl4?=
 =?us-ascii?Q?oQOI8yBxykIOoS8jdLRJEejHWfvVOq28bPpl9ePDMvNuekhQowjtjp/+DRyk?=
 =?us-ascii?Q?x59DOvFmhQIDm/vp/MVkfuDnKX8fQ+C1zF5TRyiKtU+HhVQ0qkds+SFzKb6t?=
 =?us-ascii?Q?HPyjoW1aUncMlgmC1QhSJ6saOWJcMkaQSS49wxjB00kNsnQHwMKZ9nOKeXO3?=
 =?us-ascii?Q?8U8f4aC5MRtEoNyzz7Bl8RyDbRRDJonXO/oQsRichch4Lnem0BtWZ9nPUFTv?=
 =?us-ascii?Q?vgBP2lypz+KRq2qwrihk2bvitQz4SuFPRVJytucS9FavAjeCNWl/s/b5BfTt?=
 =?us-ascii?Q?G/JXgFA3UhL9gG6ZAP9YKf2PBJ1oGkFzkNAjjcCSKzYRgDBDC5yiAvIuIXKJ?=
 =?us-ascii?Q?bAhjmHLpDWYI07RnXff+wIw6zKsDcQkTkKSwpIvThhK+zPuH0xFCLld8mMhN?=
 =?us-ascii?Q?uVhFzaj4BFFpNtf0yua6qGMb/dy83dEdfQhrTuYo9XNQKQii4DUTNSB8iqID?=
 =?us-ascii?Q?QZIT1TE2VZP0yQzIAs+ixm+Ij80cZk1r6rd78/3NzYPdk3Jb84LN4iKHR4Yj?=
 =?us-ascii?Q?Wku/jWm0FGrSVdN8MdeXZz5KKfgBkb/WBYsymjHKpaHOz9p1o7eNqUa83+rj?=
 =?us-ascii?Q?rpFY/4xJZLB+LAtzw3Plh2X4Sp9MKSBkYqUHAI5UV3FUfZyRIsdDFn0+6bT5?=
 =?us-ascii?Q?YGCcyMq72QfOcHWB7YvYe+Tu32PmTltPraFSmhR6MPzYQjxRJjahE0Wa9vBH?=
 =?us-ascii?Q?7BnMxDDilfZKwyUcMpBuwcE67gphGCrQ1ZFIQKQvgZOlBmFFaZTL3vG83XUc?=
 =?us-ascii?Q?FzPOzdEzTdiVr38/3Avwhk8/ERPAmxrK1lmtuj14Z5OInNCGQw4aR307fAEL?=
 =?us-ascii?Q?ONK5J3FEjzTHa8ijbseVUoYYIFjOPKRvYSEqVhushaUc+vUBLTIJ+0dixNLX?=
 =?us-ascii?Q?KE4C/JXayJhgUFhhEEl7G952mkFOZuBC9GzPwbKrcXJtPqyrZ86QB8mdwBwg?=
 =?us-ascii?Q?Li5hj/PXBnQSxEbWSJ34nbFv5hSb5L9AjvvA3zNOY0V8QWUnMe33v5/nem57?=
 =?us-ascii?Q?O4sUaM0iF3/Mgt0sxV/dpXg+5MuJ0mumN3JbeOqPmG01XW/wfZ4l2tplsWCR?=
 =?us-ascii?Q?6VnAzy3HjN76PCPKb0rxuZ0p9dhSAxi3JIU2+G4bv3sGUZLA7AZrIiO1WRYQ?=
 =?us-ascii?Q?fAXhO1UzTGtqLUXy80yOMK8NiESAxoLypm0AF+dT2gC/3Uiwt36XPnGa+oQr?=
 =?us-ascii?Q?gyxgBovY8PY6Y8jn/IAZs6WTMfl3eNTOs6aenU43OEs8NmYv/xKoPlwmZi8o?=
 =?us-ascii?Q?r2WWY9l4d8dwrnMVOMt25HU1W0N0VeMqnOJk1xOngQhyAzT+gW9eqTewmk6Q?=
 =?us-ascii?Q?R53QHLCA/1QhHF96thTUNmOkzKl9S3qjKA+N5m6GSber6r7QWN+Kt21qFmiq?=
 =?us-ascii?Q?8FnCUeBLpqGtKM7J5fM=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:49:02.9162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5fde87-fccd-454b-b7c2-08de0cd3e9ac
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB6527
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMSBTYWx0ZWRfX0WtHiCr7GgZN
 UQytracnUnIawSRFpbxMCe8QH7x/yqR87ZFdcDuyauUJZBcreSVuzOoVkPLDJfQM3muzf5tW77d
 zyQB/KCpBp8076JS75aaARhXfvkpZksexj+IUBKcJGibkSqbDaJEuEbrO1Xnr2RPa2StFj97aJb
 g82YLiilr9Z7qcYVzdI3yut0KBc/6YyMKU7ht0tmMzH0PZr08iaFzBxh2Mb3nS5Z/LpNdg+Dr54
 b5hueeNjr6EvLLwpFdt4oFUDGng3tPgNnMz8BPyW5CpMedjETjDJaqI9fNEsOfofTMOGW8qBORn
 rwHrz+nz7e0A6vZ8TzFIcsN2fQ238GsRiQCLRa7lFowCvl4mPSVKxV8wY2W4p+Qd21ifvBhnQx3
 e7Af189EG39MBDeHr68Wb8B0uRbH8Q==
X-Proofpoint-ORIG-GUID: Tmqf5EDrP7aPPRTPapQLier7YHTSII39
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f12207 cx=c_pps
 a=Dy1/g0x6RHl9kMZQX3cATQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=edWlu9fVkWd-uG4zv8wA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Tmqf5EDrP7aPPRTPapQLier7YHTSII39
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

In preparation for SPI support these structures should be renamed to
reflect that they are for i2c.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x-i2c.c | 2 +-
 sound/soc/codecs/cs530x.c     | 4 ++--
 sound/soc/codecs/cs530x.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs530x-i2c.c b/sound/soc/codecs/cs530x-i2c.c
index ab410826f777..52b02ceaa7e3 100644
--- a/sound/soc/codecs/cs530x-i2c.c
+++ b/sound/soc/codecs/cs530x-i2c.c
@@ -61,7 +61,7 @@ static int cs530x_i2c_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, cs530x);
 
-	cs530x->regmap = devm_regmap_init_i2c(client, &cs530x_regmap);
+	cs530x->regmap = devm_regmap_init_i2c(client, &cs530x_regmap_i2c);
 	if (IS_ERR(cs530x->regmap))
 		return dev_err_probe(&client->dev, PTR_ERR(cs530x->regmap),
 				     "Failed to allocate register map\n");
diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index f0c3ed931fa8..027d936c0912 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -1128,7 +1128,7 @@ static const struct snd_soc_component_driver soc_component_dev_cs530x = {
 	.endianness		= 1,
 };
 
-const struct regmap_config cs530x_regmap = {
+const struct regmap_config cs530x_regmap_i2c = {
 	.reg_bits = 16,
 	.val_bits = 16,
 
@@ -1140,7 +1140,7 @@ const struct regmap_config cs530x_regmap = {
 	.reg_defaults = cs530x_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(cs530x_reg_defaults),
 };
-EXPORT_SYMBOL_NS_GPL(cs530x_regmap, "SND_SOC_CS530X");
+EXPORT_SYMBOL_NS_GPL(cs530x_regmap_i2c, "SND_SOC_CS530X");
 
 static int cs530x_check_device_id(struct cs530x_priv *cs530x)
 {
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index c48a29cad702..8675a86d7d95 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -220,7 +220,7 @@ struct cs530x_priv {
 	struct gpio_desc *reset_gpio;
 };
 
-extern const struct regmap_config cs530x_regmap;
+extern const struct regmap_config cs530x_regmap_i2c;
 int cs530x_probe(struct cs530x_priv *cs530x);
 
 #endif
-- 
2.43.0


