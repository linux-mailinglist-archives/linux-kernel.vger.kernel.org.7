Return-Path: <linux-kernel+bounces-862679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37666BF5E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2458B500D4C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA9732E758;
	Tue, 21 Oct 2025 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Uunsf32+";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="RaidNR5A"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77E732D0F4;
	Tue, 21 Oct 2025 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043840; cv=fail; b=o7O/oOPH8qMcmfFj0QGvVXuc2a3tPxoWPkOr3CoCHSddU9Xvv2ibzmXPhQdKUUOUNzNAg7tT342rg72r/2Pqm1LRYHWyzaxoUqLv2Ni2OhWxthdskRvEHQVAMcMU9oxdYFdbm2LCFsWbpXdGyNrncqVkpnFPg1ta9wWgnYtKMm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043840; c=relaxed/simple;
	bh=vNdeo2kDj7Ryh/Aa0ZUJG0wVlbRggsECjYI2qF6N9dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQlbXaX7zeMjyqj4geijNtN3SAbH8/oVLJmRWBt7YSJk8ej02FO+UWkxKxiz1zwrFjK4r18EsoSiQJihZLPiqIJmipjvPoEFbqUmUe4xrhgeUMt70sOQt1KvnHKTHYR2IZMsq5REP9MmYUbWBMWxmeK0g8e8Mk3+mYaafPbYiak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Uunsf32+; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=RaidNR5A; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59L9021s941361;
	Tue, 21 Oct 2025 05:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Lc+fzHc8l7r44ynlSUgV2HN8zOPPVS3Lgef4w7M0o78=; b=
	Uunsf32+oJ5ALwaGXgMhiWSz3R0aqHYQ8MJr9yf5ZyNUtsy89leBwiZobLnA8t89
	JHr0BbgxrFetAiEnAa0kioKd/WAZ0iZZzrpLn9FlEd1N/3eqwkZG0zLplAL8uLvW
	D0uTCQgZ2XzJsoyUG6b6DcZ6B5UM0RWvgY3pJT+jB4TP4GwgdixRlZhPSDLfXbC/
	LSI3R17qqBpRhMCzc27I85g1+ABPfxqTZW2ig0a8n2JGl9YaYvz4OOamn9s/VCK4
	vCizFUzHjFN6bh9y3MDiFXFjnnR93AY6LKIkcjoO8csXHXvI+QWHHzbB99EnMVWb
	oEsjZcinaI9hD/PJ93Mr4A==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022081.outbound.protection.outlook.com [52.101.48.81])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49v7aj3eg7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 05:50:34 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFCLnc39S+aIv347AeeAt1NhvupGDzumsNNJZqsnRaFto1isaslw8K5AgLg98Kb8E5k5VeJ3dUdHXNcZdrOlcE+nM+Ybz9WQMdCFOGF7oaZTLBtSxvdAUld26y66A/6OerXqXhlgfTHegwW8/3W3ckygF1U0C5a2xH1U8YDY1H1Y0Acyw1xIG33GDigr+yhyIaCtQxzTWvxzTZ7tcfSF+VjFtt21DoSYtlDIRuU10feDcHo7ZD6RJqznqyQdFNr4x69Iq78EqjuGgWSa4hSe8MQgGri3Y/QW8xg9fxZ5SFHXMP8pL0srY/7jmxkaf/9X/8RK+dSMnYBKmDHqAcCOgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lc+fzHc8l7r44ynlSUgV2HN8zOPPVS3Lgef4w7M0o78=;
 b=kHu3pAZ09cjZ+8079UJufA/RI+jZJ5UYkEqRlne2tXdiQuc1MWzYfA630dUIMFrqnTCT63/xxXck3SM7S9BplXPv5FR9zI+P/50bIkDf+LGI92XcypOhdXpJjtepfhksVtetuPBPCOC9FrWongHbMF2Lmctj00pxC1lGZaIeO5a1BVpF9uOZfRtlT3gCsrAtrQ3yoTDqCGo8jvfsNvL2WxuYlxxwpOYkvOrd0V1DpqzPG8Yu7dIenaJVvHYY1CT584QDEbz2BFUKRkle88+80wOPnW71aeQz0iXN/2AcVLc5QKZ5fE/qHAcs3aKxetNxPTtGvDSfB+aa9ABgwXqkIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc+fzHc8l7r44ynlSUgV2HN8zOPPVS3Lgef4w7M0o78=;
 b=RaidNR5Ai/nBS4w9YsybPkmUDDGZnCbR+BWDHg70OLmutNhabNPvl0F0FCN4v91H0BZoO49jsU+t3Y/HeWM329sRAhroNvxB0aYZJ6iIX/K7bD5EmcM1C+q7EBGTuHudqnridFdRK4OQb16ggKeb8TIeqVaQZoq5AIdVYTeHRY4=
Received: from SA9PR03CA0016.namprd03.prod.outlook.com (2603:10b6:806:20::21)
 by PH7PR19MB7147.namprd19.prod.outlook.com (2603:10b6:510:20e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 10:50:27 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:20:cafe::1a) by SA9PR03CA0016.outlook.office365.com
 (2603:10b6:806:20::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 10:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Tue, 21 Oct 2025 10:50:26 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id B1CA8406556;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 7902F822544;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH v2 05/11] ALSA: hda/cs35l56: Create debugfs files for factory calibration
Date: Tue, 21 Oct 2025 11:50:16 +0100
Message-ID: <20251021105022.1013685-6-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|PH7PR19MB7147:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fbd5fbc7-058b-4f44-8d64-08de108fa4ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tDuxwM4TA8yklPLKv/m5XjeORbd9K7yYI02sosOrjrpdULg27EWkSdVcUjEH?=
 =?us-ascii?Q?E+b5HoFtAaBK8u6rQyaLanTIioFuJ0TluHfrwt2qLZuCHhIS9lOfUEog5Lm2?=
 =?us-ascii?Q?kWniVfmJ7zGA86mceQln4OpjVo6O7LuZmuYH6QkW64FdfAQ0aN8QdiOSYcD6?=
 =?us-ascii?Q?4vrIvxE2FT/+yJi1+C4k1NfXrDbx0GJNLyC3S0zO1CbnWmmWmJNshg9V0QDH?=
 =?us-ascii?Q?vtxKguntlLDatEHGt8sirhBhVfjPyXRehw0Ono0NzUCwFlFoA9FzXqeWUA16?=
 =?us-ascii?Q?xDaVIDyfC+igkqfQWauK8wOiz3EeqVix/Lx1l61pCL86ALCAt3dlKjFBg7PU?=
 =?us-ascii?Q?HVoZ+sXgD1Xv0DQpv2z+qmzODSy/mkKCz1F5ds4ly9iAvSAnv5eWS7GuZSma?=
 =?us-ascii?Q?g3V3LnF0aUjHyTEA4/23/NnvAYR/kQRSI/C0WMGzRJCWAFLlilrGPK33G6S4?=
 =?us-ascii?Q?Odo7bn+VEJEFfh7k1DBz/6nIuqgyeAnRXvB+LmmEKaMqNyMFA0mNN5nPEfRV?=
 =?us-ascii?Q?zyPMOgoGt6QsDZKyfzuP+L7RGf9zZxOBw3RnKPJXK+gYf3ecAa2Sub6maFoX?=
 =?us-ascii?Q?HbT1xHlQc2j9pV5cz7Ry8i4kZj5cw7+h2D9dT8JAypCWO109bmIgFW5rdWDA?=
 =?us-ascii?Q?NWthJpyOP20y0zGw4YFSSXyFb2ccEFng6WS/vqizAXC1uc8GCi/Ufbhspzy5?=
 =?us-ascii?Q?5OfWbqL3gYGajPOiRAJpkDKffzqU0R1zdOetYh7+dpwYXW5FjDoTxAw197LS?=
 =?us-ascii?Q?Eom336z7Lx8FQ1Go7+njdwDiLxQkut6/TjayvdlHqYuGNqKCNu1c6myQEpNy?=
 =?us-ascii?Q?bNViIRG6RiPBgsbeOjAl5nwI9uGPjHtzqrvne/YYziy/MG6PQLGfs3eDyEUq?=
 =?us-ascii?Q?ND6LlBYwjGO941zSRgC6dvTYncg3TZenH46IGk8/vl9QWG8Q08qd/cAexpl3?=
 =?us-ascii?Q?o8Z+FB3+axSs1j1tn0xi7EyTjLMykGuBjfngpHFdsFe6J9/LUqrJwVyDooXP?=
 =?us-ascii?Q?D9Xk7pkTFzwtHTXilvCmh+Qy59HMiEkndxEVf1jKPhUEjEYN+mtuGmPvFnau?=
 =?us-ascii?Q?Hqq5I14UXkU51GfubZWNd1G00hh0x8XfhjuOOeQ1zAl5YtL4iyd2qUoxFLWf?=
 =?us-ascii?Q?7PZ3+DyWtoyg33z+KuOe5Ot4mEZaNwt7hKbX99vVAQ5ncwRDyzZSEWOQ+kjn?=
 =?us-ascii?Q?WSHhW/Ac2wHdqKg20wmkcGn9f9s0ouKnBN5hMF0CqVQ2CI+U76w7+Cv3jBwD?=
 =?us-ascii?Q?214rCo88LWNG/5BZpepIQUc24+7dIkJzlNAnGb1UCrfvARGCNSaVr5LMtljc?=
 =?us-ascii?Q?Oh4XNkubXkduHsXSLSRRPpkLvqbGkdXS7LWdIs1Dl+eYqYMmSONqN3F208xG?=
 =?us-ascii?Q?LsYnaGC7g6qmJIS9ZNJaWB1ml/QiofWsNAMfShsE7IKU+ifpctmmwmphwscr?=
 =?us-ascii?Q?X71oe09ri3d/r/arZ5u6Pcbfbca1x92aim2ZOKKSr+ZiWcrXMtW3/U4AmbDE?=
 =?us-ascii?Q?Hr044DO/zjN3aQpNE5+shL/z7uOG4Ccs70t6CQMHwPPG2XwFLtczxID7bmGE?=
 =?us-ascii?Q?8Geec7b0xI5rC0UqguY=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 10:50:26.3642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd5fbc7-058b-4f44-8d64-08de108fa4ea
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7147
X-Proofpoint-ORIG-GUID: IQOstCMNpTJwLVIS8XNHYG_GoepQ6-hb
X-Proofpoint-GUID: IQOstCMNpTJwLVIS8XNHYG_GoepQ6-hb
X-Authority-Analysis: v=2.4 cv=bdNmkePB c=1 sm=1 tr=0 ts=68f7657a cx=c_pps
 a=OvjpmfG2phmKxcO1Hl3QmQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=cVLFTHSKG9q2iFVCogsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDA4NSBTYWx0ZWRfXzLIURoU0Hlz8
 MG+PZnzlFmx/EwiiSJK9y+98mVXFyoKkr4mS4db2ty+Dj8TZdszwy4SSZJTDvrR5gCv0H8mj3IC
 aybBW7pWDA8i3R5JNZ5tD9kFQ57X7nYXBjHv9JcnS47szsTJUvV9+er542dhDH2WGWu1FXrsAmk
 S/YvR42DlXovZ++6gGlFKLLY9sxCdDOn2VNXicu3kl+25LpzwJ+VqPTsoSUT052ScvJ4P9Gszrz
 to7Ee5mm4eI5+u6CScNeugdOA+tJCirgCQxl0FDD1UcljvIcOsvYSdTXeyMfZKdie0ufioMw6dj
 Ln6uukTUIG9NpxcfiIHpi+9Hsofts3AW/Z3JN7YnqO1SZe1PsnZ7jHJf3y4KNHHQq1EDfpkA2cE
 rMOjgTADsX48eUgB6sUx5hTOEBVVqw==
X-Proofpoint-Spam-Reason: safe

Create debugfs files that can be used to perform factory calibration.

During manufacture, the production line must perform a factory calibration
of the amps. This commit adds this functionality via debugfs files.

As this is only needed during manufacture, there is no need for this to be
available in a normal system so a Kconfig item has been added to enable
this. The new Kconfig option is inside a sub-menu because items do not
group and indent if the parent is invisible or there are multiple parent
dependencies. Anyway the sub-menu reduces the clutter.

cs35l56_hda_apply_calibration() has been changed to return an error code
that can be reported back through the debugfs write. The original call to
this function doesn't check the return code because in normal use it
doesn't matter whether this fails - the firmware will default to a safe
calibration for the platform. But tooling using the debugfs files might
want to know if there was an error.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
Changes in V2:
- File callbacks rewritten to be debugfs callbacks instead of
  sysfs callbacks.
- Replace the sysfs file definition and creation with debugfs creation.

 sound/hda/codecs/side-codecs/Kconfig       |  15 +++
 sound/hda/codecs/side-codecs/cs35l56_hda.c | 114 ++++++++++++++++++++-
 sound/hda/codecs/side-codecs/cs35l56_hda.h |   6 ++
 3 files changed, 130 insertions(+), 5 deletions(-)

diff --git a/sound/hda/codecs/side-codecs/Kconfig b/sound/hda/codecs/side-codecs/Kconfig
index cbf1847896bc..f674e9a9c7d7 100644
--- a/sound/hda/codecs/side-codecs/Kconfig
+++ b/sound/hda/codecs/side-codecs/Kconfig
@@ -88,6 +88,21 @@ config SND_HDA_SCODEC_CS35L56_SPI
 	  Say Y or M here to include CS35L56 amplifier support with
 	  SPI control.
 
+menu "CS35L56 driver options"
+	depends on SND_HDA_SCODEC_CS35L56
+
+config SND_HDA_SCODEC_CS35L56_CAL_DEBUGFS
+	bool "CS35L56 create debugfs for factory calibration"
+	default N
+	depends on DEBUG_FS
+	select SND_SOC_CS35L56_CAL_DEBUGFS_COMMON
+	help
+	  Create debugfs entries used during factory-line manufacture
+	  for factory calibration.
+
+	  If unsure select "N".
+endmenu
+
 config SND_HDA_SCODEC_TAS2781
 	tristate
 	select SND_HDA_GENERIC
diff --git a/sound/hda/codecs/side-codecs/cs35l56_hda.c b/sound/hda/codecs/side-codecs/cs35l56_hda.c
index 5bb1c4ebeaf3..03f565312459 100644
--- a/sound/hda/codecs/side-codecs/cs35l56_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l56_hda.c
@@ -548,20 +548,24 @@ static void cs35l56_hda_release_firmware_files(const struct firmware *wmfw_firmw
 	kfree(coeff_filename);
 }
 
-static void cs35l56_hda_apply_calibration(struct cs35l56_hda *cs35l56)
+static int cs35l56_hda_apply_calibration(struct cs35l56_hda *cs35l56)
 {
 	int ret;
 
 	if (!cs35l56->base.cal_data_valid || cs35l56->base.secured)
-		return;
+		return -EACCES;
 
 	ret = cs_amp_write_cal_coeffs(&cs35l56->cs_dsp,
 				      &cs35l56_calibration_controls,
 				      &cs35l56->base.cal_data);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_warn(cs35l56->base.dev, "Failed to write calibration: %d\n", ret);
-	else
-		dev_info(cs35l56->base.dev, "Calibration applied\n");
+		return ret;
+	}
+
+	dev_info(cs35l56->base.dev, "Calibration applied\n");
+
+	return 0;
 }
 
 static void cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
@@ -669,7 +673,9 @@ static void cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	if (ret)
 		dev_dbg(cs35l56->base.dev, "%s: cs_dsp_run ret %d\n", __func__, ret);
 
+	/* Don't need to check return code, it's not fatal if this fails */
 	cs35l56_hda_apply_calibration(cs35l56);
+
 	ret = cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_REINIT);
 	if (ret)
 		cs_dsp_stop(&cs35l56->cs_dsp);
@@ -695,6 +701,100 @@ static void cs35l56_hda_dsp_work(struct work_struct *work)
 	cs35l56_hda_fw_load(cs35l56);
 }
 
+static ssize_t cs35l56_hda_debugfs_calibrate_write(struct file *file,
+						   const char __user *from,
+						   size_t count, loff_t *ppos)
+{
+	struct cs35l56_base *cs35l56_base = file->private_data;
+	ssize_t ret;
+
+	ret = pm_runtime_resume_and_get(cs35l56_base->dev);
+	if (ret)
+		return ret;
+
+	ret = cs35l56_calibrate_debugfs_write(cs35l56_base, from, count, ppos);
+	pm_runtime_autosuspend(cs35l56_base->dev);
+
+	return ret;
+}
+
+static ssize_t cs35l56_hda_debugfs_cal_temperature_write(struct file *file,
+							 const char __user *from,
+							 size_t count, loff_t *ppos)
+{
+	struct cs35l56_base *cs35l56_base = file->private_data;
+	ssize_t ret;
+
+	ret = pm_runtime_resume_and_get(cs35l56_base->dev);
+	if (ret)
+		return ret;
+
+	ret = cs35l56_cal_ambient_debugfs_write(cs35l56_base, from, count, ppos);
+	pm_runtime_autosuspend(cs35l56_base->dev);
+
+	return ret;
+}
+
+static ssize_t cs35l56_hda_debugfs_cal_data_read(struct file *file,
+						 char __user *to,
+						 size_t count, loff_t *ppos)
+{
+	struct cs35l56_base *cs35l56_base = file->private_data;
+	ssize_t ret;
+
+	ret = pm_runtime_resume_and_get(cs35l56_base->dev);
+	if (ret)
+		return ret;
+
+	ret = cs35l56_cal_data_debugfs_read(cs35l56_base, to, count, ppos);
+	pm_runtime_autosuspend(cs35l56_base->dev);
+
+	return ret;
+}
+
+static ssize_t cs35l56_hda_debugfs_cal_data_write(struct file *file,
+						  const char __user *from,
+						  size_t count, loff_t *ppos)
+{
+	struct cs35l56_base *cs35l56_base = file->private_data;
+	struct cs35l56_hda *cs35l56 = cs35l56_hda_from_base(cs35l56_base);
+	ssize_t ret;
+
+	ret = cs35l56_cal_data_debugfs_write(cs35l56_base, from, count, ppos);
+	if (ret == -ENODATA)
+		return count;	/* Ignore writes of empty cal blobs */
+
+	if (ret < 0)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(cs35l56_base->dev);
+	if (ret)
+		return ret;
+
+	ret = cs35l56_hda_apply_calibration(cs35l56);
+	if (ret == 0)
+		cs35l56_mbox_send(cs35l56_base, CS35L56_MBOX_CMD_AUDIO_REINIT);
+	else
+		count = -EIO;
+
+	pm_runtime_autosuspend(cs35l56_base->dev);
+
+	return count;
+}
+
+static const struct cs35l56_cal_debugfs_fops cs35l56_hda_cal_debugfs_fops = {
+	.calibrate = {
+		.write = cs35l56_hda_debugfs_calibrate_write,
+	},
+	.cal_temperature = {
+		.write = cs35l56_hda_debugfs_cal_temperature_write,
+	},
+	.cal_data = {
+		.read = cs35l56_hda_debugfs_cal_data_read,
+		.write = cs35l56_hda_debugfs_cal_data_write,
+	},
+};
+
 static int cs35l56_hda_bind(struct device *dev, struct device *master, void *master_data)
 {
 	struct cs35l56_hda *cs35l56 = dev_get_drvdata(dev);
@@ -722,6 +822,9 @@ static int cs35l56_hda_bind(struct device *dev, struct device *master, void *mas
 	cs_dsp_init_debugfs(&cs35l56->cs_dsp, cs35l56->debugfs_root);
 #endif
 
+	if (IS_ENABLED(CONFIG_SND_HDA_SCODEC_CS35L56_CAL_DEBUGFS))
+		cs35l56_create_cal_debugfs(&cs35l56->base, &cs35l56_hda_cal_debugfs_fops);
+
 	dev_dbg(cs35l56->base.dev, "Bound\n");
 
 	return 0;
@@ -735,6 +838,7 @@ static void cs35l56_hda_unbind(struct device *dev, struct device *master, void *
 
 	cancel_work_sync(&cs35l56->dsp_work);
 
+	cs35l56_remove_cal_debugfs(&cs35l56->base);
 	cs35l56_hda_remove_controls(cs35l56);
 
 #if IS_ENABLED(CONFIG_SND_DEBUG)
diff --git a/sound/hda/codecs/side-codecs/cs35l56_hda.h b/sound/hda/codecs/side-codecs/cs35l56_hda.h
index 38d94fb213a5..cb4b5e7356a3 100644
--- a/sound/hda/codecs/side-codecs/cs35l56_hda.h
+++ b/sound/hda/codecs/side-codecs/cs35l56_hda.h
@@ -9,6 +9,7 @@
 #ifndef __CS35L56_HDA_H__
 #define __CS35L56_HDA_H__
 
+#include <linux/container_of.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/firmware/cirrus/cs_dsp.h>
@@ -42,6 +43,11 @@ struct cs35l56_hda {
 #endif
 };
 
+static inline struct cs35l56_hda *cs35l56_hda_from_base(struct cs35l56_base *cs35l56_base)
+{
+	return container_of(cs35l56_base, struct cs35l56_hda, base);
+}
+
 extern const struct dev_pm_ops cs35l56_hda_pm_ops;
 
 int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id);
-- 
2.47.3


