Return-Path: <linux-kernel+bounces-777923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0867BB2DF3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59701C81CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F134D26F45A;
	Wed, 20 Aug 2025 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cGHetTcO";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="JCNRRK9I"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFD6274B5D;
	Wed, 20 Aug 2025 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699759; cv=fail; b=qgbDskka6gnL1YaAEzXYBpml5O54XSHh8OVsrp0bJJE5Rh7IY4sdhQMas1R2PLtul6qhsBbipgwFhzkrMBeWHlXW0LjukmzC7M/nBeH4Q9dIWbTRf0hm84vyO+OIo2l6MCoj7u7jXgafDLOu4K9QAfUk4nr7U2ru93LkUO4fCVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699759; c=relaxed/simple;
	bh=Jz4kPbAM2cqTulyAzHZyqdLH6CakcHrhfouNj+x6Y90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qp9LyZeaFieytEonEPuQqiKicox/3TeuQvCrRuyhkydjnJ5sz2iFM8JbIZIS9kmafMDbi/K4uDoLm2dpi2CH5itFP42htBUjt5qHoKrBZUCnnZNbsb77lJKZH/yupQvGgadchs7WkYR8VQ28ahin1XtgmXWQrd7jrH7+0Qi17pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cGHetTcO; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=JCNRRK9I; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57JJZ6QL368910;
	Wed, 20 Aug 2025 09:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=jwkwWlQ71XUBtFwKKZwtyD94AbT+R3s1KXhcNLtp7jY=; b=
	cGHetTcOVTOaNDHOsS76kjAlbbHNMKzLSopfrFz3NB8Op3GHmE12nZ4OduvIMId8
	sq1UwziDR3XvsfbS50RxAg/YY+gDjIy4e8VfQxf4xsgCby+FXUmUzhOzyvor2tQu
	+Z5PCD03Ig+zQyODvbpp2NuZw3EjSUgKOl0XA38z8L7BKk+cD9hB6VA0G8CZV2wE
	tmhEmAkw0T4z1VxqjkLw6Xb2oyOfwKVltkelqNDcQJNPHNThCagWleyjbrI8oi0i
	uVPtNOmf3ocIctMuL0niHzMSEGAyye5MVwxU/64bSD5/OGBEYKruHmYcUpsjBaI1
	HvQsBgQqxOwJ9yXkfFQzRQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2107.outbound.protection.outlook.com [40.107.223.107])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 48myd99bs4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 09:22:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNaFBEmf74PtlMM3fx0PuNXtSiyDm/Mx9QLJ0dTbaS4jUA990byjcBfCU308GVi28q2miY+x07rTLZEC+U/J97dOeOs7KkAdZvt9EDC4fL0ot8q2QUcESyEdRhhtWMFZp5lN1R5MBMuMjg7iCR3mtDZUSQHDfe6Ryt15StCiRgSIT9JFCwH8mXAlfKFZ0YWMozVHKvkj4gvGGgoYes45ennxpOBAfibtTrTc69KDMEgHQeMgVonS9j2KRS7GJU5gdi4O1f888bvgRfKFMB09VL2gjQmANa11sLqiGlONBnHXFGxY1cpTg2x879vo1steBqcGoxpI5Aln0YMKqdgHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwkwWlQ71XUBtFwKKZwtyD94AbT+R3s1KXhcNLtp7jY=;
 b=FddfvUyC+j7ik2rQ9PFh31e7S6OmH7cBsrTqy/gJfxdihOZ47DPD/0JWW8hn8+ql9ZugEi/0jmaAyRKyJ52T53IFxVJdZlyI3jMyCIwznhlRCij8qXQ5ZqF1nV3BshCt3/AF2JWiw4gmgAygYCQGFvo0mfgFC1hle9T6uIb6C7rpT4aljcvciMJX/Jch31RM0mlwniGcUGg6YUrNrwj3ZlQjaEjzlqMPkDCnw4+RQ/42cN1smWQpuoFr9pPVD2pPauUGzaQxRDBdXNxaBOp2Jicp/VOVfFH9/Nr3HzrLu9rI7lQSx7fn+UixTZ1cRdfAEQjBpHqZuqZTpv7e+PxKFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwkwWlQ71XUBtFwKKZwtyD94AbT+R3s1KXhcNLtp7jY=;
 b=JCNRRK9ItGBugLU2DHLs6DK+q3EqDoKbypiZFWBdsoomGFb+ChifVLjxhh18aniymX33v6gohkMC1fsHcoUmJPfrSWZUc6EhjGTOkRGjoWPb4lPCYu0a5u9jHQ3LZLVtoSy08klBbvOiWP+5pDr9rDG/biJjeCDXBiYEM5Dd5mA=
Received: from BN9PR03CA0096.namprd03.prod.outlook.com (2603:10b6:408:fd::11)
 by SN7PR19MB7817.namprd19.prod.outlook.com (2603:10b6:806:2ee::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 14:22:30 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:408:fd:cafe::9c) by BN9PR03CA0096.outlook.office365.com
 (2603:10b6:408:fd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 14:22:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Wed, 20 Aug 2025 14:22:29 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 1AEEA406555;
	Wed, 20 Aug 2025 14:22:28 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E900082024A;
	Wed, 20 Aug 2025 14:22:27 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 3/3] ASoC: cs35l56: Remove SoundWire Clock Divider workaround for CS35L63
Date: Wed, 20 Aug 2025 15:22:02 +0100
Message-ID: <20250820142209.127575-4-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820142209.127575-1-sbinding@opensource.cirrus.com>
References: <20250820142209.127575-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|SN7PR19MB7817:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 29afbab0-5a8a-41a9-9a85-08dddff4fec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jPDWHLA6HpNZ83esLo+CmgcZOcjKgdKFcgKVc5dR9kpDTvTw20s4m8YIESP6?=
 =?us-ascii?Q?CGl8WfNUzWn1rmt6VIJHk4PsVbwYGXs9q4HbsgSuzq8U5eK9AXLTikw9gG3O?=
 =?us-ascii?Q?wD7Zano49ryM5I/7FzUyHP6pDdS7u/Jw2aCQOdAvHrSmwlblo0zIaRCVYSKN?=
 =?us-ascii?Q?9++eIigzP02O8j+jewepi5TvE1UX7oHTl2BgQBTV4fXP22/vmBDl52vKK1hn?=
 =?us-ascii?Q?nB/ahPSRowprYD+o/Tz5/mlyntb45zidRHjvw/DAoINscmXP56oyzt5AapP2?=
 =?us-ascii?Q?FhtB3UTCHREsBWiZt3dV5fuKop6qhb4etIGGQqsZA2HC+Ra7itj1ZdB3SNyt?=
 =?us-ascii?Q?z2FxO0qgLloMLTqLTqWs3glmzd3fZ7k/XtDoiKkNyH1UnIh+s9vYJhE2RL0R?=
 =?us-ascii?Q?9FIfApmVQmYABJJYfMmvvXBiaSGBzkDKLNYK+ngO5KSgL9yj2fvKoc8WI5zz?=
 =?us-ascii?Q?aqq7LQ2frM6mZbutG7UsbBgrFLr0lFgz/nCqtRpkcK+WK2Apa1DFud7i0/8i?=
 =?us-ascii?Q?s9tauorL7tINhKLfAZEwAWwE+13kipZvZNG/JnOQBhPmidaSx5jNWFy6EpOi?=
 =?us-ascii?Q?N9UU2wY4/hBeCXc5GsWTmgZphdGj+R5LzIquOfAuOIL3zyQ72ipVIbL/JT8n?=
 =?us-ascii?Q?xxH+Kwt7Tr4QvOhzCnB/eU7E8c6pBdBk8Is9WPpHweZhByB6SfnY3O9kntTY?=
 =?us-ascii?Q?7f+qwmCJwKkTiZxnXioL9knXLCWcVM44rs/3kb+JJ82r2ERNqX8pksHkGEh4?=
 =?us-ascii?Q?v1sIz/MmmqSZvuHxE/fL6z7azSqFZTklz/2VmFu5OEnrHeWppZ5S0rfwrYWn?=
 =?us-ascii?Q?siJ3+Bt5DjFTlkHngQ6nl0WvGgCaUuUx6R5Nw4CRp7E+jWQBgeMKN+mKWXip?=
 =?us-ascii?Q?XlrUn2vs6JhVOl1F1CAb70mgXXxdGEc6UAKVO2guhVSuie1UyJkSrcY1S4VI?=
 =?us-ascii?Q?mWagOKckZUJgJVHJZmXGFA40b+j0Vmx8WHe2c1577ULpiB58Y7/D5Yr3liFK?=
 =?us-ascii?Q?/61KpbaeSjcobgbotudu7l1nZw1I+spia2Dw7sPwWWn0APWNBSrh6CPx6oQD?=
 =?us-ascii?Q?zA59I4O4aIGqh/oW7DRXFDcE4F7GsNJi+u38RlgULtz72cRTn4AUdotwAwDl?=
 =?us-ascii?Q?vBN9orJRDDSsYBLOiOCzECJuSAP6TRj6hooXvw7ScEf8++CMKPX8ia1SMfdK?=
 =?us-ascii?Q?9NwFwimOyk9RTaYFuaKcWw/DILtOo8JsJGEhs/hpAY0oIX5DQBnWnem30sK0?=
 =?us-ascii?Q?tWmf1FLE4cb2J5wVCY/AHpn4dBEY2xnlX0mQyN5O7C6KY7S85uWQmypoU4+c?=
 =?us-ascii?Q?OWK5llSqTdJNc1nJVVAB/KhCUTTPQER8HpyTGnCRXyg9kdqI8kj4tHwtE1S8?=
 =?us-ascii?Q?SRbHWMJpC1sq9HG9uL4mKBKpJS8NPLn6X1o7xiVdF4rEFM0NSPYYtJcAYw07?=
 =?us-ascii?Q?0gm3ikhH/QkPVWrfQMMQ43KMSdEuB7bzvY2G7ZLdhLQ1VDYstOemDKjyDVPX?=
 =?us-ascii?Q?yBMHZfGKy3IOXPCdRqb39+n/korsRzuVHjoV?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(61400799027)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 14:22:29.3526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29afbab0-5a8a-41a9-9a85-08dddff4fec1
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB7817
X-Proofpoint-ORIG-GUID: ApXKrvtnNA4De-JpL5KUgLxR7azbbWpx
X-Proofpoint-GUID: ApXKrvtnNA4De-JpL5KUgLxR7azbbWpx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEyNyBTYWx0ZWRfXwvf7ZUBF00Kw
 x6r0hKmGglaQEs3REguWwDV0poPwZqbLLX20AJFx5TuqxzEHCZw/iuC5K/AYh4bTFSdQHs8Gl+V
 hTqxT5UaS4CQnIaXQwujTtychSDAdhYOY0GnkKz94KDA8+XnRkQuOvmW2oPmelTY/SRi7lkXxGQ
 TDLci+Jmhfd1DEpCxY1J9WrXNzsSN5Unb2YcgMWByQX5ZwEIHaQW+8jjvmQhgHGs6J5Uxp3Fr3t
 SDUj9sOs4W6GeoxjBWTrAcxoA9zoQCOpL4toflSzZpkOuRVAlIDK8DLTnlncxd8KQJsnrOFT9FB
 /JAqsIltD4bA/BcF3PTxq1ZySIdqF3ueaFzzUgg9uEEUk/U52U+UAPq0tVMtsjw1maaet1DratF
 fANKQ/i8lUXQdta81Ick3ctVtfG4aA==
X-Authority-Analysis: v=2.4 cv=WIwmnnsR c=1 sm=1 tr=0 ts=68a5da2b cx=c_pps
 a=aVHjp9ag5SOPUVfpuEL+cA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=2OwXVqhp2XgA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=Eqq7O2SyaTNHdlpsiP4A:9
X-Proofpoint-Spam-Reason: safe

Production silicon for CS36L63 has some small differences compared to
pre-production silicon. Remove soundwire clock workaround as no
longer necessary. We don't want to do tricks with low-level clocking
controls if we don't need to.

Fixes: 978858791ced ("ASoC: cs35l56: Add initial support for CS35L63 for I2C and SoundWire")

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56-sdw.c | 69 ----------------------------------
 sound/soc/codecs/cs35l56.h     |  3 --
 2 files changed, 72 deletions(-)

diff --git a/sound/soc/codecs/cs35l56-sdw.c b/sound/soc/codecs/cs35l56-sdw.c
index ee14031695a1..3905c9cb188a 100644
--- a/sound/soc/codecs/cs35l56-sdw.c
+++ b/sound/soc/codecs/cs35l56-sdw.c
@@ -393,74 +393,6 @@ static int cs35l56_sdw_update_status(struct sdw_slave *peripheral,
 	return 0;
 }
 
-static int cs35l63_sdw_kick_divider(struct cs35l56_private *cs35l56,
-				    struct sdw_slave *peripheral)
-{
-	unsigned int curr_scale_reg, next_scale_reg;
-	int curr_scale, next_scale, ret;
-
-	if (!cs35l56->base.init_done)
-		return 0;
-
-	if (peripheral->bus->params.curr_bank) {
-		curr_scale_reg = SDW_SCP_BUSCLOCK_SCALE_B1;
-		next_scale_reg = SDW_SCP_BUSCLOCK_SCALE_B0;
-	} else {
-		curr_scale_reg = SDW_SCP_BUSCLOCK_SCALE_B0;
-		next_scale_reg = SDW_SCP_BUSCLOCK_SCALE_B1;
-	}
-
-	/*
-	 * Current clock scale value must be different to new value.
-	 * Modify current to guarantee this. If next still has the dummy
-	 * value we wrote when it was current, the core code has not set
-	 * a new scale so restore its original good value
-	 */
-	curr_scale = sdw_read_no_pm(peripheral, curr_scale_reg);
-	if (curr_scale < 0) {
-		dev_err(cs35l56->base.dev, "Failed to read current clock scale: %d\n", curr_scale);
-		return curr_scale;
-	}
-
-	next_scale = sdw_read_no_pm(peripheral, next_scale_reg);
-	if (next_scale < 0) {
-		dev_err(cs35l56->base.dev, "Failed to read next clock scale: %d\n", next_scale);
-		return next_scale;
-	}
-
-	if (next_scale == CS35L56_SDW_INVALID_BUS_SCALE) {
-		next_scale = cs35l56->old_sdw_clock_scale;
-		ret = sdw_write_no_pm(peripheral, next_scale_reg, next_scale);
-		if (ret < 0) {
-			dev_err(cs35l56->base.dev, "Failed to modify current clock scale: %d\n",
-				ret);
-			return ret;
-		}
-	}
-
-	cs35l56->old_sdw_clock_scale = curr_scale;
-	ret = sdw_write_no_pm(peripheral, curr_scale_reg, CS35L56_SDW_INVALID_BUS_SCALE);
-	if (ret < 0) {
-		dev_err(cs35l56->base.dev, "Failed to modify current clock scale: %d\n", ret);
-		return ret;
-	}
-
-	dev_dbg(cs35l56->base.dev, "Next bus scale: %#x\n", next_scale);
-
-	return 0;
-}
-
-static int cs35l56_sdw_bus_config(struct sdw_slave *peripheral,
-				  struct sdw_bus_params *params)
-{
-	struct cs35l56_private *cs35l56 = dev_get_drvdata(&peripheral->dev);
-
-	if ((cs35l56->base.type == 0x63) && (cs35l56->base.rev < 0xa1))
-		return cs35l63_sdw_kick_divider(cs35l56, peripheral);
-
-	return 0;
-}
-
 static int __maybe_unused cs35l56_sdw_clk_stop(struct sdw_slave *peripheral,
 					       enum sdw_clk_stop_mode mode,
 					       enum sdw_clk_stop_type type)
@@ -476,7 +408,6 @@ static const struct sdw_slave_ops cs35l56_sdw_ops = {
 	.read_prop = cs35l56_sdw_read_prop,
 	.interrupt_callback = cs35l56_sdw_interrupt,
 	.update_status = cs35l56_sdw_update_status,
-	.bus_config = cs35l56_sdw_bus_config,
 #ifdef DEBUG
 	.clk_stop = cs35l56_sdw_clk_stop,
 #endif
diff --git a/sound/soc/codecs/cs35l56.h b/sound/soc/codecs/cs35l56.h
index bd77a57249d7..40a1800a4585 100644
--- a/sound/soc/codecs/cs35l56.h
+++ b/sound/soc/codecs/cs35l56.h
@@ -20,8 +20,6 @@
 #define CS35L56_SDW_GEN_INT_MASK_1	0xc1
 #define CS35L56_SDW_INT_MASK_CODEC_IRQ	BIT(0)
 
-#define CS35L56_SDW_INVALID_BUS_SCALE	0xf
-
 #define CS35L56_RX_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
 #define CS35L56_TX_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE \
 			    | SNDRV_PCM_FMTBIT_S32_LE)
@@ -52,7 +50,6 @@ struct cs35l56_private {
 	u8 asp_slot_count;
 	bool tdm_mode;
 	bool sysclk_set;
-	u8 old_sdw_clock_scale;
 	u8 sdw_link_num;
 	u8 sdw_unique_id;
 };
-- 
2.43.0


