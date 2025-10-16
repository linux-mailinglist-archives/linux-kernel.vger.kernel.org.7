Return-Path: <linux-kernel+bounces-856024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ECFBE2F13
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70A419C6A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C664323403;
	Thu, 16 Oct 2025 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Wk2LkDgl";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="kNAgVz91"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FF4321426;
	Thu, 16 Oct 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611385; cv=fail; b=p1kMk0BXgz7LRs7MkaxDmODfV28elMOPDOKKzJJgKnHOX1spOZ6gUyofpBgm2cM7K5XYI6+IOFHSANlewSGzso5MDEqHBv9i8Ppt+C88i2C52dsgGCGg3+rwbWfZZCkT/UU4H/R3W1EacWGeXowy5SfMh4XRmuRIeLAn5vxVgfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611385; c=relaxed/simple;
	bh=p360r/sSyftRt6b3oN1JLDoz3fAe2qeIyVdx+3DvDZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eRHCETgM0Ounv75TxW10B2ncf14NMHdbaSzG2xEkMth05v9GJVZNqs2e3kAmQKr+gO+EvtwFeedRL2fDEC7YU6VtUkVdzKeeIsz8b3VnS0pITY+HGNz9KwmujuwKNEIavJOYeJs+/70jVNPEmrRNRPe2+Ir/e7VX+3zKHlGYgLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Wk2LkDgl; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=kNAgVz91; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59G9oCCT648147;
	Thu, 16 Oct 2025 05:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=r8agvnVcWrQSGLDV
	47kQji5sx0FeiZMH2xLZzOA6KqE=; b=Wk2LkDglJcsbdIgf4VkgNQmvTCwNXLtN
	PDnVXKK723BbQAb1iS4DIOndMjbFoZdeGfio07Hkb56LYt5xp2EHkZ6s6is2ukJz
	HiAeYQ2joVE4VwYV1euXXHbeh3qu7Ef5nqUpI3FFDY05HIN4GrfBK6OHCSIOIm4f
	F1gutbRQcj0dndvja4EkDoCJbN7YPh0FnDjo3WlhjwPJ/C5spXmR0+ZpbjtPpi8F
	75U+CmtIOUC7/3DwA1Si68ozdbl/H2a4BNMIM2Klg7wEEr4f8hIFhHbUcP0o5QRw
	9+XZlLiJZNumfhjbXUi6JU8eK5j5Sl+xel8UAAL8x7i0wK0mFG+BUg==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020078.outbound.protection.outlook.com [52.101.61.78])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49sdb448a1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 05:42:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSwRkrAuGcakj/sYtc0paz0LiIu6M7HDacrGAZRDSdX/NZ4os4PD//GfvbGe4xtCFBsjzURFIal/q2Vzt7EzZAQ6CXhwFCbUSUkd7bNiWLEBRzRVVzoLaBUrsQ7gbWjFGf64IcyqxpfvN/g3I0gu0fmp1UPdiDKL3JknZBswkUiJcn1bPwfRWEy4l9AfvT06mnJDAIDfNqR0XechmFBzAWnew2dflx34GgaupGoEBOxS6Z5ifMtw0hR7iXBxIsRVewt2m9wvwdVrIN9240DA1C7N0wP3wRdd+0SuGDKu/ixH5kc9YQp0gkoUUF2cXNyK+G2E/93Lj/Y5ouGz7eJQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8agvnVcWrQSGLDV47kQji5sx0FeiZMH2xLZzOA6KqE=;
 b=HjZeHriKui6Qhfrw8eDk9BxaUyip5RB95bnHD70oJN/myXX9mbtXYgJj/3EQvNlaPq+vwExcIfsh5duLsQ32M3ZBvNyJ0DKBReMc3PsIk/ipg7BZX2EF88TTvJgpSun3wimz1P9hjLloXEFkGDeGwh42gcdZzXLDAInLqsy4SzI2BLTK9s+n+Xo349lvBxPAN3K9W+3ZRj/E4PQm/XB7jnykm3a3CNmfHdw+NZvcfL/5L2wX+knCg1uicWk37I00RbXAz8wMY6apla2R0tv/grJjSXPNnr5fzM1qbqZK/TIpshKatzS0GktofbCG1COlNED0lrP6wJ5AFEYCSHgOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8agvnVcWrQSGLDV47kQji5sx0FeiZMH2xLZzOA6KqE=;
 b=kNAgVz914hOp2wXUYefnur++gGO9pDeey78wKvMJvcI2A5s8OUyObCIQud3e9o0QsGIohVoQY4PIcIS1L4AHXwD6ia1jWzG1QZ4u/Lf5MlEksbINOLiQp8zPt3ZqtOTn8hXF6s2plNKD4iiylpkN/Icf/FT2l+uk2Lk8/jaA4Ig=
Received: from MN2PR03CA0006.namprd03.prod.outlook.com (2603:10b6:208:23a::11)
 by SN7PR19MB4766.namprd19.prod.outlook.com (2603:10b6:806:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 16 Oct
 2025 10:42:45 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::3d) by MN2PR03CA0006.outlook.office365.com
 (2603:10b6:208:23a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 10:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 10:42:43 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id AD4A6406547;
	Thu, 16 Oct 2025 10:42:42 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 905BF820249;
	Thu, 16 Oct 2025 10:42:42 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 00/11] ALSA: cs35l56: Add support for factory calibration
Date: Thu, 16 Oct 2025 11:42:31 +0100
Message-ID: <20251016104242.157325-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|SN7PR19MB4766:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9328a007-b04c-41f0-e27d-08de0ca0bce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WLUG/BJjs81JhzO7vFZQaMULDJQcdiWSIuHzDkMgs4cBjeamJqQigQnHcvHs?=
 =?us-ascii?Q?uOK6SQjDz892Tku/Oa/JOA2fzYwk5Wjvt6lWhmascKqeo6s3EixRCBMyb819?=
 =?us-ascii?Q?WCe5WclTFkPreSnaxqo3UNaRuk+ZiGL/cQzd35vMP7tcM04zpwGcD9BzuubW?=
 =?us-ascii?Q?DG6JhyUGlphyPozTYd1nGU6YMxSRJeaTd/viPARJ5Nx3asnUMq6kPI8b12eN?=
 =?us-ascii?Q?fYyMNRvJ610P1YijoA1zwirtkCQZm29+LdXJZQxMnGZiLs74p0/T18nr6wPl?=
 =?us-ascii?Q?/J7Fjanhq6jbBNDRdB6gV+pqs6JCB2TRLirSZc6414ZpDKy5hRp1l4z1d+T5?=
 =?us-ascii?Q?GvFgR3biKf393J5WO1U0V3cnTFBrPsreaN03VQ96MVTce8DWbiDzaYkNebjW?=
 =?us-ascii?Q?OmCq1Iuz5RxrNmm7xGWjRwYfwKiAMoPRyzHkzCAhYt/2bgrqyn0sN6384G1c?=
 =?us-ascii?Q?iT0pKgf4V9tEAxQSrZsVgyn4nsiyj3Db7rz3WnIdD/aTXBatj1U5sEyGMxOv?=
 =?us-ascii?Q?HVYWvSNtRgXgHpwAnC1HIn9068WyrDyp5sVkkZgRVbe1uaeme7h4oqZW8+NH?=
 =?us-ascii?Q?5QWKAtzmUMrHIVT6eRHmxsFqKyAiIgyaNFzxj2Ia4Ou7fwHElEm2q0gyw8xH?=
 =?us-ascii?Q?HbeVQUrC2y2wO1AnIyLipNEXWnIYv5Fd2CbsKkEyCb2r5rWAnSt8hbJzdwQy?=
 =?us-ascii?Q?sydPuGVV7c7LqNM9XqgMQbDiNCuFXxHSdlxCgCNzWRA81Gtmscj0pP3JuptL?=
 =?us-ascii?Q?XfnmPtaYxR+Nlp5Hj/IH8QRModLLvsFmi4//ig/Wj9JMLyA8X4BeaP5h9xXv?=
 =?us-ascii?Q?WckqsqcJzawlkN6iaWm0KCs1TUki6EVS2DCvFgThpDN2RSnXrTNaEHkEpeq6?=
 =?us-ascii?Q?WAfv8msqstu7PNb7lJ6Y5ZsLrFFmP76M39SiLj6aQ2XUu3wpTSJ7/lWdI/O5?=
 =?us-ascii?Q?l7d5jcjkC7h3YsCfk6P+18HQtMt6O0h5Ua2cB7bR30aAjhv6uw51shXpsAVE?=
 =?us-ascii?Q?k6BDCUrQ7gSzblrZgsPU8fTi6OaEzNp7f6qIHUJpw6bhwFSIDsnBJVzocs1n?=
 =?us-ascii?Q?UHRY09t7f7DkAypglN94ePiUqhVogHKN/kqEoSFYzbbM62zRxxqpDXYGiCFd?=
 =?us-ascii?Q?sODj4B3vCqIgaJxdTmPWONvlLuhDc03T9kidGUGByRYX210XaTW40+AZeTOy?=
 =?us-ascii?Q?NA/rwc16M0uOp6mMSbCyhAWpVaDLVtepwaZ04w3N7GMBirklkXI6Nb5xeee2?=
 =?us-ascii?Q?IevIzhdROCAt4HbxoBPrPf87cUbJE3JUqB8vp0jG2jQCqgZvYYVsIjsVjLLw?=
 =?us-ascii?Q?zP/3SjafKnhJHu7xcsd904NXy91O0SfMkcEyhuH8Hli2RXcZhd+kdtPQXVw9?=
 =?us-ascii?Q?dYo9fz6I9WHHedYII9jhn7oyeRhtEwfq8fc0FsS31lNWF7kfg3wgPe8MEiVI?=
 =?us-ascii?Q?UOkJOB6J15u4/xURrpIIGzwuOuNjKRiEkqSapxE++qy9G9EcQnr39KdhxjRe?=
 =?us-ascii?Q?6djIxC0Vao1Sqyq2tO7fM0/wfz+5P7oHupXamzOIK/QwNcwc4ZI9ucTwidK2?=
 =?us-ascii?Q?6epgRiHa1Tc4Tiw2Els=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:42:43.4597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9328a007-b04c-41f0-e27d-08de0ca0bce5
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB4766
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA4MCBTYWx0ZWRfX0jVq3ZbWye0H
 duKvtNl5Vt5/KNm0YzCguCDLxatOqp3UUlPZ+WCZwN+NohSXQfGXPCCN95ttB1GJHm/8vJC+TyO
 mM2bcA1/RFZzW+MBhq53TMZlmf2jDGaUPGXo6y0UoWdfHcOLpIWicl36cvjJrArv7TR5zj4VRoF
 TKq80HpSKzaEJ8Y4VZREo2phxFY9uIYBocQY7YHnYPbtMvUTw342SeyQMmoOSFOFN5qmkPOGLnX
 SBl7azConjJJCIjNdSZVLUbAaHezIh3WdoBIE04pb8bRlDtvo5YRowHUOCyTuGIRiGg6ue0qDW7
 /oW/GKQqpddXkKsdBhGMdgx8Yxpk+bsR3mrMG7ft3lqlLA2Sec/Yl28ITQOrTQeiUM2QU1rUO0D
 qXmsl5Yokmb6PjkVX3ssMH3Jrn0ENw==
X-Proofpoint-GUID: MihfIdk-9Lnr_l9Jj1fbGYPvka0QA-Lv
X-Authority-Analysis: v=2.4 cv=PPICOPqC c=1 sm=1 tr=0 ts=68f0cc27 cx=c_pps
 a=qgEGzIGkZH4qQFF7vfwnSQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=CrLkspkC5V6LS_hoHUkA:9
X-Proofpoint-ORIG-GUID: MihfIdk-9Lnr_l9Jj1fbGYPvka0QA-Lv
X-Proofpoint-Spam-Reason: safe

Until now, all products with an amplifier supported by the cs35l56 driver
have shipped with Microsoft Windows pre-installed. The factory calibration
of speaker protection has therefore been done using the Windows driver.

However, products that ship with a Linux-based distro must be able to
perform the factory calibration procedure from within the Linux-based
environment. This patch series adds that support.

NOTE: unfortunately this is yet another series that is mainly ASoC but
also needs some changes to the HDA driver, and they have build dependencies
on the ASoC code. I suggest taking this all through Mark's tree and we'll
avoid sending any other commits to the HDA driver until it has all landed
in Takashi's tree.

Richard Fitzgerald (11):
  ASoC: cs35l56: Read silicon ID during initialization and save it
  ASoC: cs-amp-lib: Add helpers for factory calibration
  ASoC: cs35l56: Add common code for factory calibration
  ASoC: cs35l56: Create sysfs files for factory calibration
  ALSA: hda/cs35l56: Create sysfs files for factory calibration
  ASoC: cs-amp-lib-test: Add cases for factory calibration helpers
  ASoC: cs-amp-lib: Return attributes from cs_amp_get_efi_variable()
  ASoC: cs-amp-lib: Add function to write calibration to EFI
  ASoC: cs35l56: Add calibration command to store into UEFI
  ALSA: hda/cs35l56: Set cal_index to the amp index
  ASoC: cs-amp-lib-test: Add test cases for
    cs_amp_set_efi_calibration_data()

 include/sound/cs-amp-lib.h                 |   24 +-
 include/sound/cs35l56.h                    |   20 +
 sound/hda/codecs/side-codecs/Kconfig       |   15 +
 sound/hda/codecs/side-codecs/cs35l56_hda.c |  141 +-
 sound/soc/codecs/Kconfig                   |   18 +
 sound/soc/codecs/cs-amp-lib-test.c         | 1491 +++++++++++++++++++-
 sound/soc/codecs/cs-amp-lib.c              |  319 ++++-
 sound/soc/codecs/cs35l56-shared.c          |  321 ++++-
 sound/soc/codecs/cs35l56.c                 |  182 +++
 9 files changed, 2477 insertions(+), 54 deletions(-)

-- 
2.47.3


