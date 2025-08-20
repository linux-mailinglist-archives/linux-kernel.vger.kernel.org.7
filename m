Return-Path: <linux-kernel+bounces-777715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C043B2DD06
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A4E172A78
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C91319864;
	Wed, 20 Aug 2025 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="iZz+eu1c";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="C9VvIZDq"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8232DCF58;
	Wed, 20 Aug 2025 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755694270; cv=fail; b=oeVUvtOZSzisPKRt6mAb1PSb8ki3Pg5cKzugW5n/5bpfOM2oD5SLsAHcZadkUxFyXVR9ukCrNigWFBELoxOUCNoVeFgtH3qPyIiIzOG26m9IQJ05rkmZ9Lwaxvrl4RQcad0hCBYc5lu4Fa+IFz4546N+rHOo5NWDWmhJ55s27Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755694270; c=relaxed/simple;
	bh=QyXRQTJKX34qST6LzG0fQ9Zz/YLCCESzUMmwqEf8KfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+BBCdoISfmoJBx3cL8U/+SwL94viszYiKBw0LEHvlmiGNL7pANpLQheUVdvbENmfT5p1r/VVssoeZPgCGXNBH38AjIYJ53LtuqIpjxyet04lXTQY6IfDpfsq/zhohhEEOLNYK/f4k/hFGNE8FRE56k89gk9cyHYq50V8OPYuH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=iZz+eu1c; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=C9VvIZDq; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57JJYrkN368685;
	Wed, 20 Aug 2025 07:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=PC1hlDwTO7bYoMTBOUfRP66TGLX4O1chZ3G9U4nw8BU=; b=
	iZz+eu1cayQdJyTZE5WRQkWNOfptY5bKrC2M+JBuq8s1oFyWUP42LSbMiqp/1tw1
	PehyNNeqtCvYH/PRjTqFLEcfr0PMV7AmVtiRg5a13XWp5SJa8z7yT9cps+gWAspF
	xnXwURtvv5vyxovkz4hkP2eG6pI1tVxuFOY/VLoUR/OHOcMrXtd/qsevw8N2nebB
	WFlus7gtkq/T1FMjYJfBYFY9Mnv+WmgkbFA0xai1syfz+y1OrVIe1zDAZ9qcuk2Z
	qSTXNtmAdtlmS3ZSTmqSF6lCUuyk3xPAhhz1Dai8821ENvo78sGfGjtpXBxEsE6V
	xtNyypDvZauY5xW5MofCaw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2120.outbound.protection.outlook.com [40.107.223.120])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 48myd9971n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 07:51:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eqhq5Et6jqgH1yYZkbVtC0iTIKfDkLoRVcgeu9NqQ19tTzhHiYXde7OIpEKrnY5VR1Xw3rF+oP8JdQWtNKsyRVPg8CEsOHZj0xRwkiW2GuBgbA4kPNrqdxV9YQ+l17Ujn2pa8UlAWf7YLQyMcu61xGHAtDk+eWwURNK/zuUY+3XvuHWfi7sA70x/kbHYZxdb1I7cXsENIj5ZpQNrPlbBJGq/f5d+u4ljj+ZtHCOSkFyOnFhwIfMPlIV1CpS6r63FYUXIhhWIGshHVQlImPxDbXtDHz5NYL6mkFNmRL1iOue5mbAiC9ZTprK1aeys1e6lpejVTuLVY2bOKg/sHLiT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PC1hlDwTO7bYoMTBOUfRP66TGLX4O1chZ3G9U4nw8BU=;
 b=DB9Rbqu1AeQ3nKdvP4skTHNbrn3IUaa4Bi7rkIJHX9Ns5W7IM7Q7aZc76y2LtO73NabArEfX/BBG7xBKF21fZQg4v4PWglE+tGIOOyDzzodN+drG2fm/TQ7g450EOL43EMziSEFcAkBsKVkOvW4GoK8LDXyh8DPcqr6VVde0yYfpgG8yNIJd3WHYRqCzJealMj2kJmRx6ajZe6j+aUxMSNdZWHZtYpezXubyBoeImXbij+7JfK1XHaDWFZQ/OUU+X2QPzWwuSMrm7w3xaIkhaSD8Wud+7tW5gHM2Mq5wBHdNrMcvwrwfThrcyfVv/YzqBLPLeYcyug3MVHlUdRN9QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PC1hlDwTO7bYoMTBOUfRP66TGLX4O1chZ3G9U4nw8BU=;
 b=C9VvIZDqObSPxGlCjHMS0itV+zJenvG2QBSkj38Zkvspsxwys4lnVXpCYtaBmokhJge7SkfCsHv7Z42Jh604xJjzumYH31FjAKKr8BtsH24SF1rzZ9tZMJb/ovRY0C7dcT6BqZgxeE09UXN+aeIB4W6Ts9A9oFq9RR12FKPsCgQ=
Received: from BN9PR03CA0196.namprd03.prod.outlook.com (2603:10b6:408:f9::21)
 by PH7PR19MB8236.namprd19.prod.outlook.com (2603:10b6:510:2e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 12:51:01 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:408:f9:cafe::ef) by BN9PR03CA0196.outlook.office365.com
 (2603:10b6:408:f9::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 12:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Wed, 20 Aug 2025 12:51:00 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id EA3DA40654B;
	Wed, 20 Aug 2025 12:50:58 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id C2C1C82024B;
	Wed, 20 Aug 2025 12:50:58 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 1/3] ASoC: cs35l56: Update Firmware Addresses for CS35L63 for production silicon
Date: Wed, 20 Aug 2025 13:50:34 +0100
Message-ID: <20250820125045.117740-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820125045.117740-1-sbinding@opensource.cirrus.com>
References: <20250820125045.117740-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|PH7PR19MB8236:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ba3ad119-4ed9-4d2d-4f0e-08dddfe83720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DX3W194dchjKjen2rIrzNp1NfKSH2eCI4oUSKfsm2/So+K+TvgnSgStptG9N?=
 =?us-ascii?Q?zws3/mUEKqnKJ/ZT8kkECtGYXx11pJ4FMd6USIOBiIKn5910CN6Ubg0bcdYY?=
 =?us-ascii?Q?umCqgX4jhbWUVZr84MqMMosl1jitCo7QNRKZK7XN1kT6cq1srtID/dlnx+dI?=
 =?us-ascii?Q?tTRE49JUBMAWnRYHsN8AN4g4Wn5nuFUDQ4t3DdLcdjy8JlaQTgJEhvgC3BQS?=
 =?us-ascii?Q?Dv6Q3QIaoUsCBAM3zGtRYGBERlRiQGi+VVGKOZSL+Saa/a3I5stwNOIhpAha?=
 =?us-ascii?Q?iz6K9BQU5UJ0xd2KaQlNcIpBYXEFlkrbH0UnuOqbz1+Zv3DRWIumzDn3xs2n?=
 =?us-ascii?Q?J3csiA22AdvLN6fH6CGgqco8f3e//TD0aJS12tR3tCqqVsRhjxxgbd2/4VgZ?=
 =?us-ascii?Q?6H5YKJ0yy5HD40fDQ+GJWEKxsWQ8frEZnbzyoeR85BynNHGM7+4asuL0cDi6?=
 =?us-ascii?Q?vVkvAyv8MPXLRePQvcJDp/WXHhCDIGdkA4wh7V3Q/2bkB0Tgeu5JPQPsqYiD?=
 =?us-ascii?Q?KXe80/KBBOUxynp3Yj74xCgMuYFqjedyzE7Mlpn5eO1Ty4BOFImTVOwyddQL?=
 =?us-ascii?Q?9I5Ec+zg1zEcLr40TCHOPg/vovMFFjjKkIbT//wqI4UCC5bxIuK1fcvaXKau?=
 =?us-ascii?Q?2DvDSJCVizEGsqrOlypbBaJt0sZthS73i9WixrNmoEASloIMdvF3tB0uYjqS?=
 =?us-ascii?Q?onbNG7pjusDvWouX02NXeTnJVA+7skkwXroQfYtFoxiLdkGjthSXZtBV1yty?=
 =?us-ascii?Q?G8sPfY07H16fJZQrI9fRNOgcQW2OTTovkZ+sgW0vZJvCk29Dt2VDWukl/oC3?=
 =?us-ascii?Q?NPEuYRXgpOjKgwu7bYttO9lovijPZvtlFQBIj1gPDhBPqXQkpHp2E6ki28/I?=
 =?us-ascii?Q?n1W72mkmJ5/Ucm/gmbIinP9BUtp9I34pVMRZqQEDgIdjdkr8ABbHWKSRVIi1?=
 =?us-ascii?Q?8yV/Dfb6qRGLV0k5o5qPpKHGh28eA7Y+g/MH0WC/d4fFirMIplpGtZX2Nnze?=
 =?us-ascii?Q?VRQiRT9Z4//McpmDTVZzCpdoJJe068f3H0esjael7DMx9NeTGlOGH/1FD5RY?=
 =?us-ascii?Q?qXHfv3GFgqPW0AHa8MFkSEAk5ptQyWiRAyf5xsjH714n1bfN4ejCK43EdhDG?=
 =?us-ascii?Q?tR49zmX1M5QcX9EaWOlVAbcKP7Qb+hQybXUtKvrLYzO1BZDN2iDu5VYNSXRn?=
 =?us-ascii?Q?wpRXcg3VZnlsbwDfzEMRZytp7uhVlo7h/uSOeYZFbmUq/16BqpzukegGaxdB?=
 =?us-ascii?Q?x/M/zsPdEFORtF0c/hjO6E2i17a4k8kOmvmOcyHbnKhncK68zNXOCihh1Q0t?=
 =?us-ascii?Q?DeXfs1j3XoEQJ8f07HGrog414ln95FHochfJflDJcWw5vK7hyqWiLstFTBFD?=
 =?us-ascii?Q?qDaQujhDguQ5cz7/rcsRbLs6F+M1KmtEt4/ECHuf4RJD6ye2RBxqhrEzj6Kx?=
 =?us-ascii?Q?1kwIEbo7PZugHSl27PHz6zkvgfwom/j1rz67LxAlRPfQvzZS8GViaplX8Sw2?=
 =?us-ascii?Q?7wGHb+TGE+Q+HwESvy9UUFPyoroH3+K7DU7N?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:51:00.4660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3ad119-4ed9-4d2d-4f0e-08dddfe83720
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB8236
X-Proofpoint-ORIG-GUID: cu-952eQmczE71hkipot_wqNupNo5lw4
X-Proofpoint-GUID: cu-952eQmczE71hkipot_wqNupNo5lw4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDExMyBTYWx0ZWRfX3H62Ma4Zc0aS
 qlaC6oKJzA/8vnJ+BgDlYSZaazK2//bsW7QwMqQDuaz5JJEjcjQx6HM39TZDke3uGRbyEuyWyEL
 G+pkTvSfxS1pvUB3FCrxx4rxlmYJde82jk8ZTM6utPA2meEAlaPtzW5LBRglE1tB8J8poifiZFH
 BsYoMGDfxR7qul+dMev2VQgS9p1zjgZ/CksL2JVEJLkRmGBvXoGgaSTYKHtUULhoj1R/k1pJE98
 R9lBgs0tRFofuzX/gu/zPhlul30/gIv/UIaOEM+hsOIvh+ymaswTPeVaQQx4UQbpY22dhNXRTTK
 PAIDzBjCqAVXLYM3hvHieVtgd1XC2k1PLMZsCLmCD773TpiY27hhWm3UpML+HzsB/uMzC+OgXSO
 ta5g6YtHVVos/+W9TBJulXuKzdSp5Q==
X-Authority-Analysis: v=2.4 cv=WIwmnnsR c=1 sm=1 tr=0 ts=68a5c4b8 cx=c_pps
 a=GIPfV4OF57JdyPKrRApGaw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=2OwXVqhp2XgA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=x4YA3FrS6Vl5HCi3FGUA:9
X-Proofpoint-Spam-Reason: safe

Production silicon for CS36L63 has some small differences compared to
pre-production silicon. Update firmware addresses, which are different.

No product was ever released with pre-production silicon so there is no
need for the driver to include support for it.

Fixes: d3197a09a117 ("ASoC: cs35l56: Add initial support for CS35L63 for I2C and SoundWire")

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 include/sound/cs35l56.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index e17c4cadd04d..f44aabde805e 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -107,8 +107,8 @@
 #define CS35L56_DSP1_PMEM_5114				0x3804FE8
 
 #define CS35L63_DSP1_FW_VER				CS35L56_DSP1_FW_VER
-#define CS35L63_DSP1_HALO_STATE				0x280396C
-#define CS35L63_DSP1_PM_CUR_STATE			0x28042C8
+#define CS35L63_DSP1_HALO_STATE				0x2803C04
+#define CS35L63_DSP1_PM_CUR_STATE			0x2804518
 #define CS35L63_PROTECTION_STATUS			0x340009C
 #define CS35L63_TRANSDUCER_ACTUAL_PS			0x34000F4
 #define CS35L63_MAIN_RENDER_USER_MUTE			0x3400020
-- 
2.43.0


