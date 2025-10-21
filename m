Return-Path: <linux-kernel+bounces-862673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78822BF5E31
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB34C18A5329
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C359132D44E;
	Tue, 21 Oct 2025 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="W2Wb9nbp";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="JiKBMDH2"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CA332ABEF;
	Tue, 21 Oct 2025 10:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043837; cv=fail; b=k1EH6jYIfKxu0sG6bg1aQjn5hpJcNf9mC4hztdxS10AgAju8WPuO8NdE3FO5MSmQ3ngvSQmduM2osf/carZvoSblz2Gfxio25RtSro5ocBi3jn7oHu71m9bXZe1h8RgpShGzd+3IVlcrcZ02uQKfzs5WEZax6jRr7t6yLb98Ekk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043837; c=relaxed/simple;
	bh=4cURmH1QLqQ+5LQ2UeEJVKlvm1mL/aVSIfAqN+RVz+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEompFLHPHWebOti39CO89g3pr6+aJ1KDK+SUwJNkkidX2dmqX0NzW3oUa0hbrZPlWfSWOZ7FqvzvIfmo7LZVz8/bAmAzOwGp4Jlq/LJCEiOlPVhKGmLVHU7ArcrC6yJ1w8+UlIuWlYyyBh7ALQXa7r4KemFmNNl/rlKnokBook=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=W2Wb9nbp; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=JiKBMDH2; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59L4xtJo2412958;
	Tue, 21 Oct 2025 05:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=JUZrG0RyyF/geI7EqBBDH34ZZ6JaT5yRhMW66pAdCyo=; b=
	W2Wb9nbpUdqAVyzQIpgJ+obEr1Bm9kA7ujzVXqXcwAj+Ulu7M8IAmKEzzFIhxsY7
	LU8XR9KUot75qB8pvi/FNSR0IDCKtEg//gt9ZYqZUiymF1PlO04X9UKeVNbYuF97
	wHtB9a4No/I1Mwt55lWouuSOFIuRZEZ5yPCesVxowV1NtyD7jU7nYfsTGFIQg61y
	nIGNlMQ6dyKNW+LPCb7SL881aq2l7UMVI9yDoGI9/kV2Ypj7+L7zesXQkNSszDlJ
	W+T8Fi7BW7U/Qvg04hAQtHCFsJ4HHfBnGzChyJQ6D/t+4yqeWSDJ0DLxVozHaWvA
	DAOw+6f+43B+e9t9u2Hh3w==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020101.outbound.protection.outlook.com [52.101.193.101])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49v7aj3eg6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 05:50:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBOTqRgfkn4FqE57BNvYbi6jAzW/6CzvtOR/mUyVUFvWrxAhuW9tZA/Li1hHNSvJEMq9qR63Zg0e1TOCMFXZ2ICvqTU07QCN6zWPCq2QbZYsI2hrV/Bg1Xa0ys2AFeY9kEPvGJsQ3NF7EM0PKO4a8Hp1opLWApwArnCD7iOrdvOQffWwn03iSnQ1rRVpuxJH8/G4yuLtoQq8tzG18oQwf1vlan07ExjQ/l0qCTBO/cVaQO99YRPiXnDUaZPBw+czBPVcRHMRsmrBTHgpyLAxxp4wkwc1Deit8KErlyWS9uDBpnTSfXgLtvOtm2WlAIFkBVA42/D0xReV6W3KQP4V8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUZrG0RyyF/geI7EqBBDH34ZZ6JaT5yRhMW66pAdCyo=;
 b=eLxm9gRvyjCOS/1wZgOBGck1Gc/43xkoUMHCGvm7ww7FXFj2vUwxNw2vrfjo8nr4igTcMsBKakMPa3njWxq0WWvNM/MHAzxrbnWbxM4XEe5qJBiddZjQC8iFxoFSm8ok4Mxyxxr/c1PhWP1ZStVHQGyRhE09kERwdXJg6M4MY1qJ3pGXJDWHdg7SK+jWZHPWzfGqp2DMQN28Q9rAPXGkpU3zmnJp/HWRU04dz/3V76R0QYImD08VX9mvIBPifL22TvICQXBaP1cOgj579y5ceblXQKshjn6gvv/M2Zf4MSSHXKl8mWtiagaIYUbqRIX/UbZ60yLfYVxfTWgid0lNew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUZrG0RyyF/geI7EqBBDH34ZZ6JaT5yRhMW66pAdCyo=;
 b=JiKBMDH2g8FqUtQXR01HP8TpkB17cUxwpxjSUR4T7pzxEclJ7738Mvc5QDCOCOz2lXfTavzHkNhvsHzYadSHHQdEVvjpMKTV+q6rW4g6kzvxx+25NA0Uj7jREZpcUsoDf0cDeQLbkAle4+bLeb9Fge492MU9rwgv06fkfiN0JUY=
Received: from BYAPR06CA0014.namprd06.prod.outlook.com (2603:10b6:a03:d4::27)
 by CH4PR19MB8682.namprd19.prod.outlook.com (2603:10b6:610:232::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 10:50:25 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:d4:cafe::cc) by BYAPR06CA0014.outlook.office365.com
 (2603:10b6:a03:d4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Tue,
 21 Oct 2025 10:50:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Tue, 21 Oct 2025 10:50:24 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id A79C640654B;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 6AE5F822540;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH v2 01/11] ASoC: cs35l56: Read silicon ID during initialization and save it
Date: Tue, 21 Oct 2025 11:50:12 +0100
Message-ID: <20251021105022.1013685-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021105022.1013685-1-rf@opensource.cirrus.com>
References: <20251021105022.1013685-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|CH4PR19MB8682:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 27143e38-0bab-4941-7568-08de108fa38f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6SoGtK7aHL6CXEZYE1fkEWo/OoDzyFB6yredTrIRwhH6nd9fQbZWR0c+rZC6?=
 =?us-ascii?Q?qSnKEtW5+MvXbyXxA+TdBIg+MvbHU9P8YfYfnfmTdNiy8naLGsDDnUYl72VL?=
 =?us-ascii?Q?3CssxOFaGl0HkgA689STS3io8QfJXT7m2JCP0W4ghuYNr3aEWWtWUXTDttGF?=
 =?us-ascii?Q?NtVO3H9roYojNyx0nnryRj9gOufPaDrI/JHzQ80TkI1vWLiPo3ZY+ndcI3hW?=
 =?us-ascii?Q?QWT9VRURF5FUUorGAXL6Ba1ZvVapqaVHtnInbGWU7+JpFACEJKKWl/KTrp9t?=
 =?us-ascii?Q?4kmkwTPnksDHXRMKMqic0JSGogeViT1aBrNZm47IY3ywyaQUWIc1qZ1MfVZ4?=
 =?us-ascii?Q?3kT4ujk7H5AEtzp6bb0fzjNhWArUQt2M86gqFUPhS+k481IpupDcMt12qFJf?=
 =?us-ascii?Q?/yI9dzAgZoB2dA/LLgayHt1OqxNFCL6XenhMJikbTMR6sS0DXVjxMomg4iRp?=
 =?us-ascii?Q?pghCBGzkZFztlg29HeKBHE8ufsg8BMRoxlJmct4po+Q4G8Q3yNCO1iLqbjpS?=
 =?us-ascii?Q?eKzIp1je64V36Kw5KQIN6s0Mga9RKYRq8PReeLtoQtnjsc7WsoR3ouaCwEfO?=
 =?us-ascii?Q?c5C57UdhJR7ayP5G3RnLTrVgWGr6boGhLbWJuvm14TgUJA2/8xWJPTfeO4IR?=
 =?us-ascii?Q?U+QSOXDpcSulFx9qXjAh8S5Mu9bUbNE6j9l3bofwOQ8ODdYJaRTNUmm8ulT3?=
 =?us-ascii?Q?Fr19YyEaPp79X8uiDLLjGJTb9t+06lLG9ChsgwRp8XR96jACsFfU/DX3r0Lb?=
 =?us-ascii?Q?6tTqY2iNjVZTScPp8q1zn6/VV1+c3IZwKweJ0qJSnLruo0CECMwoEiBE2Rks?=
 =?us-ascii?Q?FIVngg4lX8BRgMaNDv1meyCvJBjvcxvKXPVhgtDernw13E7GQ3T0XqkINC3c?=
 =?us-ascii?Q?AaeyluTlwSnV16+AeAiNYv3Bg2YQuRC/hMta/Pq4lM6eddCa0dvEULiSXyBV?=
 =?us-ascii?Q?X3XX1vm61rQmd4wubRCj2yk4XP2kEBQbTTuko8nXCi+ixt4aK+MPTDSbTPYO?=
 =?us-ascii?Q?FfbSiDp7/qOfIQ9PQXan3ILRNyLC7a0s0Dyu5JtVehxJMCV6yx2e8fSD/Y17?=
 =?us-ascii?Q?aCztwKTwS+oH+3t3ATZcGFjurCewcDlGsf5ynJHNPowDVzQvirq5x4J3ihwb?=
 =?us-ascii?Q?C0yOtMKovUkPfUf4b8PkJfMNcLQdjXo2PjK2AesHG6uvKktDU8lhzWcscd6G?=
 =?us-ascii?Q?sIgkyRLS0x5AdsNz4sVDrYD3sFoThGeqbSl5jFT71XKD6pajA3R7iiN9+HdM?=
 =?us-ascii?Q?M9QQBJySZpFZ+5n2/XTwIkDODK44CEzMIWKBT7ms4jXDI4Q1SKN9Jx5wIEIp?=
 =?us-ascii?Q?2qEhwHrv1nGCx4H8LPAQ7HvGgJJJ6TOSCTZLxtLhspoahfvo/doXWAQ7GHH7?=
 =?us-ascii?Q?MLEMpyEbYX10T3j/AcgtN/vOjn+lWBrrb75NH4hsw2K5jGhB38AAq/7BUopM?=
 =?us-ascii?Q?Qj30b+pmmsHuC0X2KJWrJayprh+xoW4PiledawlZTX/QyYt5yCjWxXhHSaAZ?=
 =?us-ascii?Q?bePRV+9ziFbM/w9+1WvsMhkVwIrQDLp/k1KjgfhOL+4IvkhmHh9tbK4+N+oT?=
 =?us-ascii?Q?acnWBYcHNPKcdBZbH0E=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(61400799027)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 10:50:24.0296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27143e38-0bab-4941-7568-08de108fa38f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR19MB8682
X-Proofpoint-ORIG-GUID: FfYXc0979ZW0pfmkLW7MWYVoPkQaDI4t
X-Proofpoint-GUID: FfYXc0979ZW0pfmkLW7MWYVoPkQaDI4t
X-Authority-Analysis: v=2.4 cv=bdNmkePB c=1 sm=1 tr=0 ts=68f76577 cx=c_pps
 a=IAlGFxvWO5AZskdmYTP3vQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=nj95HRKCm9CT-uqgyqgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDA4NSBTYWx0ZWRfX8tX0THmo2W0X
 1BrICiHVqA4kuS5/JcK0e8ymoO5o3xKY1W5IYjiATYYoqNHEfW0cLUzvuG+g0y+h7zctDUQUgxZ
 1wFR7Dtj0DvV6w/wfc+A71QkNg/rhDwvBhz+sOsUipNLua7eV0e6/gUFogYIJ8lbuTdpLgF+s73
 5/J6nvXhAuAavyOA8K74n9Ln+I4lbNJ5zckoTAuZZfSQn+l1WVvVfuYLEUvLowoDWFTMwK9ZyzD
 O8HPRGo1HRU1CF/ai6FUrMAOw+pXz9louzqoNDHxTyrtfKO8c6aXmcn29TR/v/P70AbTN7FXGSQ
 uK8xhUpPT3BgAaZb0phze2EmjoW9E3Yy5xPR/d6ZID2V4r4yD71TBi6IRUFsRc9sU7sPDxhEkih
 IUJ6gOGX8SNEExwBzFUk7Lw52+mu1g==
X-Proofpoint-Spam-Reason: safe

Read the silicon ID from the amp during one-time cs35l56_hw_init()
and store it in struct cs35l56_base, instead of reading it from
registers every time it is needed.

Note that marking it non-volatile without a default in regmap isn't
a suitable alternative because this causes regcache_sync() to always
write the cached value out to the registers. This could trigger a bus
fault interrupt inside the amp, which we want to avoid.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
No changes since V1.

 include/sound/cs35l56.h           |  1 +
 sound/soc/codecs/cs35l56-shared.c | 53 +++++++++++++++----------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index ab044ce2aa8b..ec9b1072d6be 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -309,6 +309,7 @@ struct cs35l56_base {
 	struct cs35l56_spi_payload *spi_payload_buf;
 	const struct cs35l56_fw_reg *fw_reg;
 	const struct cirrus_amp_cal_controls *calibration_controls;
+	u64 silicon_uid;
 };
 
 static inline bool cs35l56_is_otp_register(unsigned int reg)
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 9e6b9ca2f354..1ecfc38d8eb4 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -853,7 +853,7 @@ struct cs35l56_pte {
 } __packed;
 static_assert((sizeof(struct cs35l56_pte) % sizeof(u32)) == 0);
 
-static int cs35l56_read_silicon_uid(struct cs35l56_base *cs35l56_base, u64 *uid)
+static int cs35l56_read_silicon_uid(struct cs35l56_base *cs35l56_base)
 {
 	struct cs35l56_pte pte;
 	u64 unique_id;
@@ -870,14 +870,15 @@ static int cs35l56_read_silicon_uid(struct cs35l56_base *cs35l56_base, u64 *uid)
 	unique_id |= (u32)pte.x | ((u32)pte.y << 8) | ((u32)pte.wafer_id << 16) |
 		     ((u32)pte.dvs << 24);
 
-	*uid = unique_id;
+	cs35l56_base->silicon_uid = unique_id;
 
 	return 0;
 }
 
-static int cs35l63_read_silicon_uid(struct cs35l56_base *cs35l56_base, u64 *uid)
+static int cs35l63_read_silicon_uid(struct cs35l56_base *cs35l56_base)
 {
 	u32 tmp[2];
+	u64 unique_id;
 	int ret;
 
 	ret = regmap_bulk_read(cs35l56_base->regmap, CS35L56_DIE_STS1, tmp, ARRAY_SIZE(tmp));
@@ -886,9 +887,11 @@ static int cs35l63_read_silicon_uid(struct cs35l56_base *cs35l56_base, u64 *uid)
 		return ret;
 	}
 
-	*uid = tmp[1];
-	*uid <<= 32;
-	*uid |= tmp[0];
+	unique_id = tmp[1];
+	unique_id <<= 32;
+	unique_id |= tmp[0];
+
+	cs35l56_base->silicon_uid = unique_id;
 
 	return 0;
 }
@@ -915,33 +918,14 @@ static const struct cirrus_amp_cal_controls cs35l63_calibration_controls = {
 
 int cs35l56_get_calibration(struct cs35l56_base *cs35l56_base)
 {
-	u64 silicon_uid = 0;
 	int ret;
 
 	/* Driver can't apply calibration to a secured part, so skip */
 	if (cs35l56_base->secured)
 		return 0;
 
-	switch (cs35l56_base->type) {
-	case 0x54:
-	case 0x56:
-	case 0x57:
-		ret = cs35l56_read_silicon_uid(cs35l56_base, &silicon_uid);
-		break;
-	case 0x63:
-		ret = cs35l63_read_silicon_uid(cs35l56_base, &silicon_uid);
-		break;
-	default:
-		ret = -ENODEV;
-		break;
-	}
-
-	if (ret < 0)
-		return ret;
-
-	dev_dbg(cs35l56_base->dev, "UniqueID = %#llx\n", silicon_uid);
-
-	ret = cs_amp_get_efi_calibration_data(cs35l56_base->dev, silicon_uid,
+	ret = cs_amp_get_efi_calibration_data(cs35l56_base->dev,
+					      cs35l56_base->silicon_uid,
 					      cs35l56_base->cal_index,
 					      &cs35l56_base->cal_data);
 
@@ -1111,6 +1095,21 @@ int cs35l56_hw_init(struct cs35l56_base *cs35l56_base)
 			   CS35L56_TEMP_ERR_EINT1_MASK,
 			   0);
 
+	switch (cs35l56_base->type) {
+	case 0x54:
+	case 0x56:
+	case 0x57:
+		ret = cs35l56_read_silicon_uid(cs35l56_base);
+		break;
+	default:
+		ret = cs35l63_read_silicon_uid(cs35l56_base);
+		break;
+	}
+	if (ret)
+		return ret;
+
+	dev_dbg(cs35l56_base->dev, "SiliconID = %#llx\n", cs35l56_base->silicon_uid);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_hw_init, "SND_SOC_CS35L56_SHARED");
-- 
2.47.3


