Return-Path: <linux-kernel+bounces-828952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE9BB95ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89444177166
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFD3324B0C;
	Tue, 23 Sep 2025 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PligDhGZ";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="lKdxHgpW"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B010C322C9B;
	Tue, 23 Sep 2025 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632633; cv=fail; b=Sbl2tBdQjsNAYbHGBXmYmxZDSqpNQq52PvS6uPZiPdeHlKbBlSrtd+qKE3gH05ZUAQP7b1EZdTCSBVXSNDtVijUIu4bXhnuQqaNXG0KNRSEw3UBmKTr3hIcwJ10B1lDqAcAB3UHn/Xxcd5iIE3R3+n5aOOUJW9RgUE8C3D0r4Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632633; c=relaxed/simple;
	bh=+t4eHOoUWMkokjip+kLs9xup68VvZ2LSeUyKdXh8RVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hPScnS9xPQ57iitWmxy/Jq+DWrvQtMBhWSrK4f1jOq48MWA68aI8m3wusjTwwQV/OCHK8qoW9cVgqozrAeHG7C137GLgobB53umVlhVtSJ6GS0FG8XYRbaH8lNiPAxfriJ6t2kcU/B8ds91sskGF/E8nh2TVMek2Ft8Rv+QHk8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PligDhGZ; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=lKdxHgpW; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58MK8M6c992408;
	Tue, 23 Sep 2025 08:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=td7r50LGQCUoRFdh
	DnoyGqNOE2ZWJD/sVwI9qdcyobY=; b=PligDhGZb16Vvd+jpy0f0+zchSfKjLEJ
	jtDoz5uT6u105XLgENDnaTNON6gfh9o9uoMdriu0un28B6lJfW+pU4CtZUkazH3Y
	WUHApxFfJ9J0ALnymc48OFjA5Zz6J096B+TtdRpOIr4OnNCaGdrdIasWZxocWl2p
	Go5ue8jiAvvitcnyTeZ1eIg17aaPWrIQtU2wJV+FvctL+mMNAYIP+4t62rTrSZNl
	2/Y7DugRmkvFjHUvsdFzrTpsW3E6KAkZNZHH3HFzVUfkUz97ypd/XByzE7WVQN1o
	i6+1hC+6wlcuAE+DzBzUC2zJv2Yy0Sl+sAT4prix33mj8gtTQ+xtPA==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022086.outbound.protection.outlook.com [40.107.200.86])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49b90y185b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 08:03:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZRAllFNG20XSSGHKFe3GTQwC04OTIoJTVgsE8IIjTWkpprleuuqOv4pcp/ZZaIl90SaQBYYd4Ai7qZJRPIieivu9fmCr8dHgqvU2npYOmYZRTjk1GNitHEnY9K8Z74f8qeyl2i2PKktuvMLJMoPyUHpHN6RG9jOl46Z3PAzWoGLhBTeujqj7nL+BxsoilE4g2m7Gr/UbEWnlcQVMMlGB7FP/0ZhsIh1O2dPwwJgofVZzy3A0vVMz16TGIL0SYLapTDGWyB5zhPt3FSwLUGxNF+klHKDS3iffy7a63EfOoiMpEf2Fyd5uFDUPk8Glgt+31lL67zh5goNa7EsY7w7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=td7r50LGQCUoRFdhDnoyGqNOE2ZWJD/sVwI9qdcyobY=;
 b=kGHHBfUjNbg43dDLYdC1WCc3dP2oYQzXmVFzvOPcd/tnDbfvPfQFU+VsmfK4e5jiI+WGIjy2ZG5tzX6jtrEMTr++8UVUXt3HAY/a/6RllB8k12CF5MPqmUftmKBf6L2Bd8GIo82rDGM6ZfniPMdluOCn2cQK5ffY0JWyg0yzlDJz2Q2rkF1rQvZeryhLoUUn+Uuo07Te85bBcT+cTkoCjSsvwAKKbXc27CWp5UlrwpraAafo2tXeosOzE++BCmbeyMCJTpWYx3wfRIVu8jWyjafjxqPAHxUQQ9x1CfW+JVE6yWqNJS7IQi0SPVdinI09IAT+iJLJMtnJHSwJwkQ2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=td7r50LGQCUoRFdhDnoyGqNOE2ZWJD/sVwI9qdcyobY=;
 b=lKdxHgpWhPICXiFk1KyUugmwHnWKtYbBSnoqqEpA1E3vWY/BguECqk6SsVn3AgVEmW9FOi+7Vc+MaASHlfDMvM/Z+dGOro+ihy/ChEhTucc6Wuhft0NhfNqK6Z+xIgZLWnRRKHyT7b1Vht04r1hoZPhlsS7kC9RhzP3rTR8JvOk=
Received: from BL1PR13CA0225.namprd13.prod.outlook.com (2603:10b6:208:2bf::20)
 by LV8PR19MB8598.namprd19.prod.outlook.com (2603:10b6:408:264::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:03:29 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::d1) by BL1PR13CA0225.outlook.office365.com
 (2603:10b6:208:2bf::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 13:03:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Tue, 23 Sep 2025 13:03:28 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 45881406547;
	Tue, 23 Sep 2025 13:03:27 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 1D428820247;
	Tue, 23 Sep 2025 13:03:27 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 0/2] ALSA ASoC/HDA: cs35l56: Add support for B2 silicon
Date: Tue, 23 Sep 2025 14:03:24 +0100
Message-Id: <20250923130326.510570-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|LV8PR19MB8598:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6f4e4e4d-ed4a-414f-7e96-08ddfaa196f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NEWwZIQHx34PlnLP0DeVxCmhnKdWBMRzLP81fIa9nrBxousJcfF7nuP79cF9?=
 =?us-ascii?Q?9Ve7O2LSVpTjJSDGkYIdI1FOVNoftq/QMA2rEALz59E+JuhtO0mhPqijmH3h?=
 =?us-ascii?Q?AzkRG0o6+SYSASEHIOk6D0fsmkiwRoxN/kTie7rSqlNrlCYCqqpGmHnJQK5y?=
 =?us-ascii?Q?67aXmcrrvKUhUs3lgd3ZsR8or0wm/uTw6H4mFULAnb8Jm5fOeigVwqz53MD1?=
 =?us-ascii?Q?VkDFVhI58dwCoTI5Hn6SNBaJBMvQ0nfV8NRPRB9d4xRo3ypdUU9qTwG1UPUL?=
 =?us-ascii?Q?3NPMDi8wDLeZ++x7rtnBWYDlcHws5B5I4WIYCdF6uO2w4RoLm3qI8ld543Ej?=
 =?us-ascii?Q?JfQpPZNMd8A4YUQ577U0U+khrGTvQR03yVLTzmbDZjykzS2Pk/YNe0592U9q?=
 =?us-ascii?Q?DhdhsS0FLre0cAP6+Nek1SwQE51BczC6FmAs//zXCViFeOouAw933iNjpoLL?=
 =?us-ascii?Q?LNsep4IyKnVjLWQAnrZnxru/HfOsK/TIQW+LP1Pt0lgCQEhHLlUGXqzsIzWq?=
 =?us-ascii?Q?LzgVVyUBHkQ11wF2pf+Inwl+Lp8DFbaSJxximy5tISOcJbrKs1a88NTAtemU?=
 =?us-ascii?Q?ABJ7DqLTUzRiHUcdNi9OUqYVSxYAY07HyiDt9BqE7MhBg2AnzoOZ8SGwoe1F?=
 =?us-ascii?Q?IgOnIgXoEq6pcvYWUB7a0HtqlYZ4HKj9JjCTFn8gpO0sgRz02Svajmvp+Z1n?=
 =?us-ascii?Q?luAHGH21bSZL5DbiaYgB//wJcKe3j8Gl4JFB4+ruZD4btervamBAA+P3Pk86?=
 =?us-ascii?Q?NL/1FbDs05ZJjQAO/895ystNHV5hV8KPJR7VGr6RzjMw7iuaevx9bNx5DzgZ?=
 =?us-ascii?Q?g5ZC8Wi0dkHGLDKFGrEftC9CjbBgoy56bhqQfqHP8QSeg5P7pWScH2LjP+n8?=
 =?us-ascii?Q?NqVMWwC7LYotHoS/zIxNEz5Cufh8BfyugJArg+13Ds8Wp3bL0BxAw8nYifXI?=
 =?us-ascii?Q?lqlq5F2UK9tW5mps53w1zB1fpBcS3A4R1inSPmyOzO0L0Uoa6CPujvL678od?=
 =?us-ascii?Q?Vq+mmdyos6viW2rsG5SZ5/4EfQHX3CvEwC0w5nCOpWkXjt4L/U1xgQ0KAzAW?=
 =?us-ascii?Q?lRfQ0fYPsFaN6cdpzKe69AE+tDZ0gbi7S0ThjZbkVU66lrSb0aAvmrm+yBRL?=
 =?us-ascii?Q?WDLFsaBX5Xd9bBLTT3YcRr+LMatiNNWGTUVjqbjcG9HKzqs5X2ISgbaKS7KH?=
 =?us-ascii?Q?pvGAYF8cDDBADgxHazq7Rm+EuHOs7AD6wNz+7WwWDCsASUbLvn83X6kvt+mt?=
 =?us-ascii?Q?FP1j+kRUB3g4XQFAjU2zxNR273TLPJp5ZuZihHR+KpTRkhQ7Ic4Bie6AaHgA?=
 =?us-ascii?Q?1PxWzom+WFbxkA8Asmt44aqCEPwwb3hL5lAgyOwh8VS20g6GIhFH6SbMLXK1?=
 =?us-ascii?Q?21lOVTRjDjXcEpg+13NchryXR3740RdMINDX8KkBzOnZRSHC1Y3+brJk52tc?=
 =?us-ascii?Q?juDGLJ+hyCFdvq9PPZMbs8k1iNPYSWo/H7jvn1QalpJhM0p07+O6z5Ql919q?=
 =?us-ascii?Q?4fEIhoLy88FplmqaXiyNXfVy+YbUPNtdg60E?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(61400799027)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:03:28.3483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4e4e4d-ed4a-414f-7e96-08ddfaa196f2
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8598
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyMSBTYWx0ZWRfXxDGTTg153/es
 uvYKDx/wE7k3FnoV/Sfh3k8h9TzGm30bKPLIlr1J8j0HfsK3wMmK05igX/QMWyf/ItGWgjpLMIx
 zoadJ2Cg738Xli7ui45mzRnWgUkzB+ZAcnq98IoTgQaM4k6tI0jzbfL8epK8fBL13Y5UiTeoeBq
 W9hymDlq2uUk8WdE0HJ6QgOF16mGc5uI8gmre5DanKPMRzYwQVO9aVBq4GmH1w2aOcQ6pGdoXvO
 ADcreKSJYryu8Tl89EstutWLqZugkBCwmXA/HLs1XIW/xr7RfAPLSFtjYQDXqrvotpTD9pIZASj
 vpjZlyzDIDNAcTr/QPngQUTlTcYOoGzK51j33zVhZYjQ0g79u/efQmsWgyeJt4=
X-Proofpoint-ORIG-GUID: yxYgILtAvFnG6SGabaKDir62ytEX9pK8
X-Authority-Analysis: v=2.4 cv=A6BsP7WG c=1 sm=1 tr=0 ts=68d29aa4 cx=c_pps
 a=9PhP5jdPzEAvW1dfnTQ6sQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=TpfTCE6YQVS-8pJuR4MA:9
X-Proofpoint-GUID: yxYgILtAvFnG6SGabaKDir62ytEX9pK8
X-Proofpoint-Spam-Reason: safe

This series adds support for the latest (B2) revision of cs35l56.

Most of the code is in ASoC, but there are some trivial changes
needed to the HDA drivers. They are to prevent build breaks so
they have been included in the ASoC patch.

Richard Fitzgerald (2):
  ASoC: cs35l56: Set fw_regs table after getting REVID
  ASoC: cs35l56: Add support for CS35L56 B2 silicon

 include/sound/cs35l56.h                       |  5 +-
 sound/hda/codecs/side-codecs/cs35l56_hda.c    |  1 +
 .../hda/codecs/side-codecs/cs35l56_hda_i2c.c  |  2 -
 .../hda/codecs/side-codecs/cs35l56_hda_spi.c  |  2 -
 sound/soc/codecs/cs35l56-i2c.c                |  4 +-
 sound/soc/codecs/cs35l56-sdw.c                |  4 +-
 sound/soc/codecs/cs35l56-shared.c             | 97 +++++++++++++------
 sound/soc/codecs/cs35l56-spi.c                |  2 +-
 8 files changed, 78 insertions(+), 39 deletions(-)

-- 
2.39.5


