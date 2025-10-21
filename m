Return-Path: <linux-kernel+bounces-862669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F84BF5E22
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510691980A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB80321422;
	Tue, 21 Oct 2025 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="lxBSlc49";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="cKnzaR30"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C6AD24;
	Tue, 21 Oct 2025 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043833; cv=fail; b=WLn2ENZW+jQUSQWoHruATvQ00adcOrA+/szBMBb3t2eyqnuorOJrWAnxMGffFykRLDGCXdmjaKegbPHvOWn+BB8hA11b6kakRDbXvlL2lUchDVx5G8mQuvYQmwdvSyjmqEOmNSNcegKoNP/2dA09FkvH56BeLx2e9hogCvHCi2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043833; c=relaxed/simple;
	bh=oSH+AE8M8qDiCQNcHJpquNrMMyQNmsQjbqoh3gFFiSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fiby4RBOXnVrdhdmTng4eoiYQw19p2Q+/PSFm3axc1h5rZRgVXmTbbNGpI23AEuKzRlfbc2sXMU4LaO/aqQps9U4ftjx1c/jRpf73LL2YgDz4Kf8Su+Ji4tvJHUu310b0LYnGTxrWV5o+oSdR/GuoSH6/4AM4Iaq1rf1gtT5BX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=lxBSlc49; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=cKnzaR30; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59LASk2C2958765;
	Tue, 21 Oct 2025 05:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=5RigImkVGSp8P9RT
	Qv+voEdm/aHgM1qD29VCF0Jdfig=; b=lxBSlc49jfqXWBn76UK0c4THAweZtiMu
	1fyX5xiZltFLURDuTgVwhc1YCCgUImU/4CGdH7ELrz+ahtP8fWbDlJdAOd2YG4pA
	mf7CWCddKDtjN5TkWkzjq8BS4AN1zZ2K4d6DilWcqnNCgRgflZwu9+3ak49QTox/
	wYLJjLfk7NIueE9Hq4AzowtTDy51osqLQAITF88eAG5+JdT1n0e2nUMRmC0nx44I
	IHiQcHq4WDP42ZC3tnnUlMWvHbbtC0aJ/aRLwdheLUIR9cLvYip/3Fhg+8ekuC+B
	FDkNW/4DhHIrQhha/cQXmadOg72ihavkcc1UqXZbUODJz0yI37hzZw==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020126.outbound.protection.outlook.com [52.101.56.126])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49v7aj3efw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 05:50:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXfVG1wtRnjFpdpYKL+Vq9NAawTUNMHvwAjp/I3e9KjLxunIm6oaL++e0iFzd/c4ViVwUGZHokvAWpakE9gTuDsjGkAAPlWP3Ydb5DUAs1HXckb4/4XFkCGLZi0BrxzNvbuBmckGrqsSeFtd/tJH6aZTpRVXepvRdQTaWNeSK1Z5I0nG9ppnyVqODcGFDYiOb//EuG2g3IAUcbljEXIfP9nEh1zCSlampdz7LUGy9xIpllBtdsI447lZ+iKdZwnYnq+rY7MGFUPxrAwc5JkRs9Ktj7B84LdjnjqxUT29cr9juncxBHGR9Ld9IpbbSskE1tCKUF+LUnNboTYy/TXoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RigImkVGSp8P9RTQv+voEdm/aHgM1qD29VCF0Jdfig=;
 b=rJolCdiUEzDjm/241U0GYg//kd23Raz+5UEui5XFxi1pIBpVvaI3O23MyQStXGNWZpgJsgerD77Tp+FipZBjHIDDHGYdVYcntORaRNRraf5It1pgi6gmbkgt9luL74qYfGc2BzH+mAvs7ONW/XVYIE8WAv88enqaonua7pyzzbJH6qClkGzOZnwSxPqLquZBKvoieo9zoxP1inCbj6z9gSX4c5XNNu8OnDwaJN3eRhDy7/zag6wrBWsrKpnIYOUjryclUk37vwN/krZrZGv1bEQFyqBqlAZ9cnV5OxHm14XaKvBWx+bJzstEp7HOuD281/ZMo+PCDRmWG550ULsBbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RigImkVGSp8P9RTQv+voEdm/aHgM1qD29VCF0Jdfig=;
 b=cKnzaR30ek9x00utepg97/Q8j6/iUF00UgnoFbpKVQrSOmDiMiGGIifwN+68SX+9FViFqEc2mqm0H7MGvriXp8zFBp2uZap0KuO5xuOuI1me6aBSMRyW4THrdlVD78YIDtf+aEZR1+9BiajCQtYMR1x+g7NdIEVZPcDPcWWKh6w=
Received: from MW4PR04CA0293.namprd04.prod.outlook.com (2603:10b6:303:89::28)
 by SA6PR19MB8803.namprd19.prod.outlook.com (2603:10b6:806:41c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 10:50:25 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::aa) by MW4PR04CA0293.outlook.office365.com
 (2603:10b6:303:89::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.15 via Frontend Transport; Tue,
 21 Oct 2025 10:50:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Tue, 21 Oct 2025 10:50:24 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 9CD82406547;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 67BBC820244;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH v2 00/11] ALSA: cs35l56: Add support for factory calibration
Date: Tue, 21 Oct 2025 11:50:11 +0100
Message-ID: <20251021105022.1013685-1-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|SA6PR19MB8803:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cfe09ba9-9545-4b1e-e9d2-08de108fa3b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9PTvx3m8FDSXA9BQA/2WccU7+ZKpxlE9PQjT3I049RdQKECdGlbwtxgWGXja?=
 =?us-ascii?Q?yM7kA5QV+PqhoZyd9i/4gO6NRb6rUkOmKGrbokxQ0WDFARyVBe7XgJzJtxAO?=
 =?us-ascii?Q?Sagn7fVTA2pUFcn48F6BjB7hIuQEk0TtzTGPlA6q1e+mV8aJlOgZ4TO98JS4?=
 =?us-ascii?Q?7YAHjNmFIGjW32k1qV925p5gCa5WkSofYTl32BWj9FNUlxdXeoar3qXgL+le?=
 =?us-ascii?Q?DFl7xL4blp6J7NffqmGS9kofTV3zDRg523G0DJCxw6TuuUoFmwqNk1DVWUEX?=
 =?us-ascii?Q?e75sTqWBBXnuJ5njsjED/iB7kyDjaPLvCRr5MjsxROJjBWmlLK41Hfh5PKG6?=
 =?us-ascii?Q?dMckBMvSuTRMEzqNqUlk+H2YJObnMWOuN6cDuyAOFSwmOvQWNELoGFJRF2dL?=
 =?us-ascii?Q?XS5KTtcwO3LPBExzEuwbq2bALgTdMHOuNSdRVoPJDvIA68jL9oM+e7vydASd?=
 =?us-ascii?Q?2tecKKfKROsbyW+CP6wqa4c0Su2OK7AnN4g/CHjfGdzUoKKX1eWQtlBVzxdn?=
 =?us-ascii?Q?yOPXavmECDJ/90to2Z7jyQIgfY4DW6uUHorsTuMxRN8il+Zp99lmCfF27sKA?=
 =?us-ascii?Q?DZ5n0zypuRam+5/VAxX7XpMdHbCH88iS38f6K14i649xzcUI+sAkMJJKIunn?=
 =?us-ascii?Q?/w0dccZasGKHDpNRIiKHM2Dr930Pi8M72GF02NDkeOZz51U1Ryndy5nozul+?=
 =?us-ascii?Q?7YqpBaPBo7lpVo/ZB2v38S1x7KXwFOZ0tmuoHBVdSTG4WWtFVFndUxoBKEjm?=
 =?us-ascii?Q?5Sou0F85TQ+G5xqetir9+KvDCxvgMpVkbrBkL8KE/DNPl2xEHXQVydgPi4rE?=
 =?us-ascii?Q?9YuihlL6KKRoz+njGNxN10aw/YE8fx1GNmEEDDSU01/gEpcZ/1o0pxxHAJ6v?=
 =?us-ascii?Q?iBPNMYKOou5nwRfNwWVjhe7j1XND8SX+nXpsr3G43dlMlZP+jIgR+6yADQvW?=
 =?us-ascii?Q?5Y3ilmEts/yCVBvWtSyVFVoETYPS1Zc6nrDYMICvIr/0/iBsfh+QOnkzrVn+?=
 =?us-ascii?Q?FP6dN123RmmcJXtpLO5avWuQM6zdViKvOjzRkFFyvrjkPLsVpyg+jvBG7Hvs?=
 =?us-ascii?Q?hplZhtTL/4a3RwThFFPWE3zCdiRGbEHmcikM35S5ytt/GrGtvS4kzxDuQrhs?=
 =?us-ascii?Q?xac9nvCI1enBFw2w38Dl1tGxCGDryUVHDm8DiDI3NeiimHDisEsxfhguSeG4?=
 =?us-ascii?Q?pGV6n9PvDa9hfPgtFQQ14VTy8hioD4jUSV7V+pf8XNpJmEMG4C17Vo9jWIzA?=
 =?us-ascii?Q?RidiMXrdzpU1cwenUhGp5vXAo+5IlaTGeIqvj07bOAOY4eVpz7xzXnBxac+o?=
 =?us-ascii?Q?wP5le82pCrh6hxQ9/fP/kllboQtwWpj7O7S6xogCdJswgLGcTMxxxmIKXxpH?=
 =?us-ascii?Q?YpAtUj+m84LJ7UfI4m3/kdfw+DHMZv73uFVDGC4i78U6EF08PIGbPHTWuESy?=
 =?us-ascii?Q?unAJCP3qqCb5q/DS3H7yoWwzUcUZZ4ndiya+qdJ3JqDef72sVoWZIoiZSVO7?=
 =?us-ascii?Q?Q4Xm1WADfUYPEwnAhUrjtDXo3TdntfsJXn3OD5vF+6257WJaRKX+L8AU+FQI?=
 =?us-ascii?Q?A/c5ZRUflIvqBw1EhSI=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 10:50:24.2966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe09ba9-9545-4b1e-e9d2-08de108fa3b6
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR19MB8803
X-Proofpoint-ORIG-GUID: pERh8IDQGfIODOY0xV8x3_nGztDgGz0e
X-Proofpoint-GUID: pERh8IDQGfIODOY0xV8x3_nGztDgGz0e
X-Authority-Analysis: v=2.4 cv=bdNmkePB c=1 sm=1 tr=0 ts=68f76573 cx=c_pps
 a=y6InnzShCRkIpTYudTQ+bA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=cuoXiRUO9JCGmbFYyagA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDA4NSBTYWx0ZWRfXyBkstmmOmjy+
 xC4dzjpKeLou6fQxa6vgvjMYL4ggTjaIdWpkTCL1LyzOf7U4pq4LQ3O25PZjksBLZOdL+YeQThM
 qGXLfz2xznpG8387jcWIxSgy1QcageEbk2QgGB5UaT3bUFEqZom9YWYeImCA0JBDd2AKMJ/RuSA
 xqYfWsZiZFDr8rZy2kqyQBBEZYwOplcnj5DNeD+M9y2DpTGP4VmE7uHVO3TjWyy9h9aNsWrS39B
 /5wZlkVjak9/mqXvU7TvYwV7CWL3jop7IsCPRKR8km/1tr3sgRmyDu7sHVsLj3fG3+l9kxhm/kY
 XozdWS22z1LfllepGWZD9uciyArbjdvchmfA2UHzO/n55Yi3WABPSGi8LB+ENdnIX98exm9Kddk
 V6Wd7kInQMKe2nTK1aGL901hutW/cw==
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

Changes since V1:
- Changed the file handlers to be debugfs files instead of sysfs files.

Richard Fitzgerald (11):
  ASoC: cs35l56: Read silicon ID during initialization and save it
  ASoC: cs-amp-lib: Add helpers for factory calibration
  ASoC: cs35l56: Add common code for factory calibration
  ASoC: cs35l56: Create debugfs files for factory calibration
  ALSA: hda/cs35l56: Create debugfs files for factory calibration
  ASoC: cs-amp-lib-test: Add cases for factory calibration helpers
  ASoC: cs-amp-lib: Return attributes from cs_amp_get_efi_variable()
  ASoC: cs-amp-lib: Add function to write calibration to UEFI
  ASoC: cs35l56: Add calibration command to store into UEFI
  ALSA: hda/cs35l56: Set cal_index to the amp index
  ASoC: cs-amp-lib-test: Add test cases for
    cs_amp_set_efi_calibration_data()

 include/sound/cs-amp-lib.h                 |   25 +-
 include/sound/cs35l56.h                    |   35 +
 sound/hda/codecs/side-codecs/Kconfig       |   15 +
 sound/hda/codecs/side-codecs/cs35l56_hda.c |  116 +-
 sound/hda/codecs/side-codecs/cs35l56_hda.h |    6 +
 sound/soc/codecs/Kconfig                   |   18 +
 sound/soc/codecs/cs-amp-lib-test.c         | 1491 +++++++++++++++++++-
 sound/soc/codecs/cs-amp-lib.c              |  345 ++++-
 sound/soc/codecs/cs35l56-shared.c          |  368 ++++-
 sound/soc/codecs/cs35l56.c                 |  159 +++
 sound/soc/codecs/cs35l56.h                 |    6 +
 11 files changed, 2530 insertions(+), 54 deletions(-)

-- 
2.47.3


