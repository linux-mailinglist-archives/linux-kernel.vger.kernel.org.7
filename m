Return-Path: <linux-kernel+bounces-808005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F82B4AC0A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06159165F48
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08E7322748;
	Tue,  9 Sep 2025 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qnnbjDWo";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="F2mOmpTO"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E17131B833;
	Tue,  9 Sep 2025 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417452; cv=fail; b=ul6PYdlO7ona7Jq/UouKRipwpKLPbKzn+OSDTO4igtsklMCyAqwQuE/RbA1Z1sHbO8/2Q6gs3plY+w0X0Xt1N20Joxu1RuLgsmzgyqxsVwUWygOOWL+8dD2fJZM/hhSILnjOMQvRm5PjxMuCeODIbk+/GEmSxzi6lSddiYifKJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417452; c=relaxed/simple;
	bh=dgqUvgurBWL6vstHKCZHHz6jiQsOHyYp9ZPneVqWgog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRkS3d28v/L7BQs6IUmoxvQ1RAIYZeVKqnWWcQv32p8MipM/t03zvaGO374SJBGBk494kGXcjI6pBoH0Pmr0Zx94dkhl1OFVAJ5uzdnMOzOojfMLYlCde3G3HsBAalZdA4Z+jpJW/W1LfKNhExaN5qiTgw4myi620e3dY5IMz6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=qnnbjDWo; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=F2mOmpTO; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 588KSv911252531;
	Tue, 9 Sep 2025 06:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=x9gRks5JjcsSpCMHUpNR/NWaGqDlrevQD7rqImIrMdQ=; b=
	qnnbjDWokW64Q7FvKBcpIWhmPiaSd/3ViSvjlMqYyj6qL/9iefD1rrumoVEjd5qZ
	nuCesqliyoczrsdY/068TeyPYcxMRSVEl+sbp2wmec6uJ3BLTjqsOz/s8LkgrwoH
	VrN69o3qFSTCXuLQBEYkGaWZjIVKB3wmIWSS95jgAlq35RK6ClBY5sfTC319IWQe
	ScVtEj3AaD+Hjn+RMKaILjfVuY583gahx7vspB8035RF4hkTQkLKItqpx80m2+Kf
	u7rl+/fYBRejkc0EdocqWCEx7ctpbV3tZEbm7xi50jyicNtLmqKdQNJ6kROUkG3Z
	27kNesBG0JDmzL82ai281w==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2097.outbound.protection.outlook.com [40.107.92.97])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49227r91ws-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:30:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzW3gHjjOiPmDqPRSa6OI9ATxuGn5uOx/efvPB3VubyzjQHMUFEXrDd0TA9DXelZ2rFDJMV+X2YY9RoMTSgHvy38ZYOpApKsLCRA4u7tELd9wDEUMtMeSKfCrHVd3RXF7PsxvmNjy2G/AnzV4OZSwJVvEmM4tXpnAtQZYZvrZpOdFydHGT356y4AkuF3zDu5eXHht+14jkMJip8pdNzw/ckDLrtXMBw/2KRkQD0MxK0stXayTxU8TcfIUqahsvfyreBrp3yKSTDcxbNp/Rws+O4668kQHCEDBrxofcd86klv28GjHex1bEdAGlUzJLifz+wV9TfOhux1fiFDLQe2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9gRks5JjcsSpCMHUpNR/NWaGqDlrevQD7rqImIrMdQ=;
 b=QPoDeo9QdjRYaLRJS9URbZfDmvY4TvGdBOrD+F/IKM75yNq/CZkD9r4gMDM76Xz/gXjXdlV/ij/NBtjbNZrUkOriKNCJFhby9OGcQ1EqcAcgEsplp1D4koIRthQWm8zLwzHDVZNlSCsuBGwpslo+DTxznMelNdZC6PGcxtFCTEDwk9l2eSGM27iOtUZWpUP8RLGRoKPXX+4olKHzAIRTn4sawms8tRKHpkNTX/HbuMxhtgWuFwydhbaRDilaSyng8M5s4fR32WpFrOmuN6VxDZ0BYan0mYapGqYoDhjFSCWgWA4O1nphxddrwMlRaTQi7PZwWfQCC26j+pUozZ8xDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9gRks5JjcsSpCMHUpNR/NWaGqDlrevQD7rqImIrMdQ=;
 b=F2mOmpTOcNa/frQpSM+gavTVOmMVzP614csL5DzBdilOzjKlbQTNcd7ZwKB+JPpuzIp/pR1UUBxQ2HU5rey0oshyiOk5M/q4PTrNGI0GZYgutCcO+p1ujpZMKZplcWn4BpTUNwPyv61cBGclNEfLJyxHvy0JpmbAl4FA4OFjccs=
Received: from BYAPR07CA0075.namprd07.prod.outlook.com (2603:10b6:a03:12b::16)
 by PH0PR19MB4988.namprd19.prod.outlook.com (2603:10b6:510:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:30:44 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::16) by BYAPR07CA0075.outlook.office365.com
 (2603:10b6:a03:12b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 11:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Tue, 9 Sep 2025 11:30:41 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 363B0406542;
	Tue,  9 Sep 2025 11:30:40 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 2FA8A820247;
	Tue,  9 Sep 2025 11:30:40 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH v2 3/6] ASoC: cs35l56: Check for vendor-specific speaker ID value
Date: Tue,  9 Sep 2025 12:30:36 +0100
Message-Id: <20250909113039.922065-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250909113039.922065-1-rf@opensource.cirrus.com>
References: <20250909113039.922065-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|PH0PR19MB4988:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d9694952-c6cd-4a7b-4a62-08ddef944f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1mDDbyAHsCdsBUFSc7e8mjas9Nb3RuC1MydSOhvhPXaXAzKnWBYftXKxw0h1?=
 =?us-ascii?Q?p0hZ1/BAN5QPgK/iM5GWGkTrdvCNq+c1p72pUxhImvG9f6kEMJFPNSlRlCa3?=
 =?us-ascii?Q?r4otyf89zY7mbs05hEINM16/l9Uog/Xcwb3K6rgq7QVoWEb00tz7jwbVEYF/?=
 =?us-ascii?Q?ct0iys1rbonAlPBDnIieiQqXrLVTuIgwjxLpQwogwvOqKtqilleSTZGTncnd?=
 =?us-ascii?Q?/yzyR/5OaTBB4TchJ+NScORm7sMblJGUbdZVHSmcLkYWJbuRAX3pa5kNX/3C?=
 =?us-ascii?Q?SpY/0v5Fh9dLxy1h8DW/4CXRJgJOZNmYN7LApnJzuQF+ZJ9VLmk7Rmfcd2OA?=
 =?us-ascii?Q?BI7J8NXAf59H0g1AN6FyparrOTYlb4dK19NvPzBTgdq9ZKb8MRzMDQX5OFYs?=
 =?us-ascii?Q?9n9W77piTsJ1MHhHHBMVXYf9eD0VKNWjIguVMYG7pth1IswnGhd1bP3cqJbf?=
 =?us-ascii?Q?7VpLN+5pnhj4jFs1KmAdKf/ypKaJ0s5kXVf8NZhUjdFEdtPQVqm//9bDcUAq?=
 =?us-ascii?Q?MKIz2oyO7xESqdARNtum0STV9bMJq+KqT/h6zY51unBSCOj2kUmxXbACqT3U?=
 =?us-ascii?Q?R4kzUKnpZy+/0HnwpNYEblLHsNZ/6Slyl2b4d4G/3ChHDKS945idMmTB/gxx?=
 =?us-ascii?Q?weC0p44DPaCP12r3ZSgaBk3HN2S+H9n2sS8hErLRodXepQ9GbvXpdMl2gFlU?=
 =?us-ascii?Q?h9P4YJst/70E28aTwMGVVbepmT2UAv7cbSJcW/nJYnMPDThcUG2TG+Dhdn4l?=
 =?us-ascii?Q?GHyIMUQjrhsinDKiuUVpz6bZfTqu6chVmzwHMxdNkVW4TPlbGiLSDfpw7I8i?=
 =?us-ascii?Q?sVWT5qR0e6sJVYt/clzWdSUuEo9lkcJ5kIPo9m1OOOcjlfQViudzNQ8TKYQY?=
 =?us-ascii?Q?An2d/L14DzIGAkyb1+aAc1IyHYM+KaPWIF3/jSck+y2gEQO7JigPZLFLXsAg?=
 =?us-ascii?Q?zlkdqPayDcyj4mZKrhNOCeSDE4xMIArUxENUnuGpiMRRVuK/EmbRWMmhMPM/?=
 =?us-ascii?Q?X9ebzvxM7xKEov5OCSkfWw6NALtxLD7DRMekZ5FoLH1szEiWikZ+BhIOq2a0?=
 =?us-ascii?Q?mm4slknUIC5oO/EL/HD0T1iTwVEjB/bluPG/tHoz2eZzK8DVhIiw3g4t3gpX?=
 =?us-ascii?Q?sVYyQIZUnyP5dN0djZQQk0SqTWn6qPvbCPlKF91lZYujs0k8484FEM/5XxFN?=
 =?us-ascii?Q?CE0TasC8pc5iA90oBsZvvMoiIhlGRMe9dSb72NorXfl45fzTmbbDNJr6Voav?=
 =?us-ascii?Q?vxqRL3zck01Cf6hMhJFj3UYKGIVA7CxmA05Rcj9hyKG8CT/UXTjBUfW9rIVD?=
 =?us-ascii?Q?XrEDkUp779VQqmv0m9LDhzpLG+Fhq/sKy4p6OeTaXG/QEYyVNso61ggGcEjW?=
 =?us-ascii?Q?jhz62wA38qt+g1NdYP4PBSJotSfgXILgyz4xvZKCjUuFBVhwr+/8h/gD3XP0?=
 =?us-ascii?Q?vEsva70A7SbCvm0iR1ifnFbNp+H9nIsKYH9xJ6lMsw/TaiHAr0PBZk1BxXGN?=
 =?us-ascii?Q?xF0Nel34wE/yFX0oXzo8sE+MC/h7ibLBCyHl?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:30:41.9358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9694952-c6cd-4a7b-4a62-08ddef944f62
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4988
X-Authority-Analysis: v=2.4 cv=f+FIBPyM c=1 sm=1 tr=0 ts=68c00fe8 cx=c_pps
 a=AtfF7QnjuUZK6qv3K7ssFw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=9YM_IZES8PAWDyRG2q4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA5MDExNCBTYWx0ZWRfX5KLZFGXhUgjD
 PIeIwwycfVnb33FPj6vgsEIsrI4+Hr+FZdDXyhAIiQczA6Gr1oCSMO2Ye5lUiYMrr+8g6l3WaG1
 UqfNwkIfNpLpkV0kn+mgdCNOeG2dsjfLwOxyKpGhxfmdl0Ak6x57lf9asLdhACbXJ571E59V1SW
 Dq0SL88cncYKtY5N79LoPgQRPAM/SEhbykLWhSeCxAB3lvFJc4OnDZ/UfCQe2/AfW41MMzniFlm
 naFoYVW14tyNP6sdbyBZd29nUWIQw6bh8g2R5uHjr9qVhiU8oyZq3z7mqb3bY0iThr6NioKbwq6
 Z1dkkv3nuIO6+09q0vQdSfhJeb51lsBZFfgopnHkplN8dlT/NPtabA/ZGMcpBU=
X-Proofpoint-GUID: lSUy3tZJ8VxbISRQkBlhuZEiPaCCDbND
X-Proofpoint-ORIG-GUID: lSUy3tZJ8VxbISRQkBlhuZEiPaCCDbND
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


