Return-Path: <linux-kernel+bounces-828954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDD9B95ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6D119C23E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD2D324B32;
	Tue, 23 Sep 2025 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="b5qflsnI";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="TwcwQPsL"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FAD323F7D;
	Tue, 23 Sep 2025 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632634; cv=fail; b=TofdrD3aR+pqsKPtpQbc+eFv9sRbFsSXVGgZHEnTTUNNcBvhdGlZwoi9OLnUJvblJ7j6YE0muW/O3Cz0xfRoro4FnxZ99lMZ7lOunRehPNScS9TbR4t7Q4k1xnuASU2bI0WKNHeju8aZB3T9YruVsZ5tvBNB8bIaIanWZG1wcF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632634; c=relaxed/simple;
	bh=MQ9hAkuRHDIPwBZmQkWGf/lJGShDHdic0mmwIL0tZ/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/ZUCv/ozdWXh8giP571jyB86c0V+s8Si0dUWQTlSplsVIecm4SgUCa1zvxI5AfdfHZ22th+zRHM4eaEd4E0eiefP2P3GeKeEvUrQydUctRAmiknADSVinkGfsQSne+IDfuENlBLAPTk78uN7gOd7rFoKnmodMMku/WGqZdXC1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=b5qflsnI; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=TwcwQPsL; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58MK9727088261;
	Tue, 23 Sep 2025 08:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=gN7ecGhPsQmae/70si0gMcYCAt72x2YfPLZhSA08iq4=; b=
	b5qflsnIl/gjXxcC6yR+iR33TYzZrTf7t/KwcVQrxsmGatg3i1Jd2xHsVvAEC1I7
	6NM6gmQtEMKKkGUCaKB+JQ9T7ev3SZW0//Q80ZDG8ors1sNita8W1hDxEDR9/EHc
	4WdvAcdQyb4nw4NNNxeUSAW32qOvyXUnhp2lrCU/gzED4/BLu0eeHGeF8rRuXf39
	wXVQpCYNyDwygctiLpLhpphUPBiRdk7erxFIgGrMd2T7oz7AyH/qcDP2mtoBo8aq
	O0+FGL7qF0l4rKjonK7i+26QAHGHYnog93oTMSTX18wGRbFRb6dGZpnO0fVpyFZ0
	H5ww8TzykYrsO3mV3CjIjQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020093.outbound.protection.outlook.com [52.101.201.93])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 499rpjc9uk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 08:03:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1cZQpplkdHdjZjtOLohSApz09CrYlHe3pPIGqN8mksNsFi0Jp1D5bJImssbHEWA9jSaQTxzvGagQNqHmHL+wx3FVZ8JfhlMMaITlGur3UhcTRGxpStCIzctXJH8/MKug8PVy8FvMKHkwPy2kh14tit/FnwQLC01s4cDbYnI3uXX8aydOR7S8roe4c7DfWDpWv/1e+hSHW3hXnRuwdPil1IYwQ1hFgb2uhsa+tzIrIUEL+57jKdhpJynbOYb7583BIl+Svs/QXhpEUOQcsOjW2W3Kv56vsqHuj3ZdqE4wggQ3OSIoikrB8JjcpeviFxsZyjcqoRC8q4sDqvlvzxb/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gN7ecGhPsQmae/70si0gMcYCAt72x2YfPLZhSA08iq4=;
 b=V0fnsS1N1I3rHPnk5gzyjSkMPtucC/7y1olmVNiyFWyuYQIFdWi6a2FayLkS5hyUktDy68+NUB+xwKIwTgdtWe8o6WyROIM6u4nFiAxLs+Hg61lZmXc2mO1CPIx8DdMTFZ16pW096UV/AWdehlErsaYDXOvi5Z/ExbQqAYJ4anP8qwNjQ9+bfIas38zJZlJWw+8u47FmyFZ5yzgNErvMjzvaE3CEigQN4tXnOBnXHYe+8OFEKjlpob3L+MSKKPGwiYVK4+52rdB0RT7+RKkzHLZNuLiZZ1JONVUEzwwfN6ZXLSvvUF0I3qWGVBdLsMjeTYTUkt0QCMU/q4QMd7t4eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gN7ecGhPsQmae/70si0gMcYCAt72x2YfPLZhSA08iq4=;
 b=TwcwQPsLVRCih6W91O1UP9WbbROvEnkC7xgH/twd83FF6wkjdiDdzSx27tIT1hm0x3D/MnMopD6NmqHZkxoaPfDwqm8mcZpIqUuN8Pjwcw1S/tVcKi4R/Yzr57mV7RMEHDfqv9Cl9HGYHRK8seE7HgJks87ErDJzUbIizRVn8/Q=
Received: from MN0PR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:52c::6)
 by CH8PR19MB9166.namprd19.prod.outlook.com (2603:10b6:610:271::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 13:03:29 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::8b) by MN0PR05CA0001.outlook.office365.com
 (2603:10b6:208:52c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9 via Frontend Transport; Tue,
 23 Sep 2025 13:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Tue, 23 Sep 2025 13:03:29 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 4FAC840654B;
	Tue, 23 Sep 2025 13:03:27 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 2C66382025A;
	Tue, 23 Sep 2025 13:03:27 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 1/2] ASoC: cs35l56: Set fw_regs table after getting REVID
Date: Tue, 23 Sep 2025 14:03:25 +0100
Message-Id: <20250923130326.510570-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923130326.510570-1-rf@opensource.cirrus.com>
References: <20250923130326.510570-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|CH8PR19MB9166:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5aa534a6-95ad-4813-52bf-08ddfaa1975f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qzDeiiJWYuqDfUKdBGnAlWVfzIehalRBPBJp92AjTF+7IlZFKnIR8euu9ctn?=
 =?us-ascii?Q?gxraBvhq9Li9aChJlRzy9r0VkcfVx54CYaM4DkydMLZO5wD8ekVvmBY6ddIT?=
 =?us-ascii?Q?p8bdL0g3Nn5rYnrBAMd5AdSYqyVK0susApocp+l+/OFCl/x+L+6AGnRQtwtQ?=
 =?us-ascii?Q?Ap4zcjcyWnj6eZbbmSGYwTFbCiKi3prbVv5x9osu0bFzOb2IKfgABpFJoaeD?=
 =?us-ascii?Q?/p4fxdpcskq7+Dm28VjrzQCfQic0xLLWrmVR9eaaH4WanMstq1ixK80wjnq7?=
 =?us-ascii?Q?PNvzvBPSOGnbzXFpn4k8mnxqStlFRO1IuNklBZGkhMkTtp1omiZ6h0/vJa50?=
 =?us-ascii?Q?y3jtPCmCGcs7DRcPqIrTCLzbXXPlIYqcqdoUKme94MtPTWBPBRs21hOBZ1JS?=
 =?us-ascii?Q?LgAf2SnFLku3NQGwfMCBMntiLYaQrZbr1P2f++Nd7LyFJFBV0JZXtQarv/RZ?=
 =?us-ascii?Q?CJAiHOe2nORklZT29RTvuUUYctTeKW+AzohE60P8VELSgfTofbZ4uonZ9NLv?=
 =?us-ascii?Q?j9fuYZ12Fol1wF4HSnYdS+GfrI0grNq5LfFf9wUcAKq4ayftMU6fLLbI70wu?=
 =?us-ascii?Q?2Zk27m/se2KOClWONnWjObZ8Sq82m2JLC26BQ26iaFVZn4G143Tm4jdTOWph?=
 =?us-ascii?Q?eAeEPikOQBJEcG3Oib51pR8GXs9nqwZWWL8YwFm6ZsL3gSKO6sia1uvdYrWD?=
 =?us-ascii?Q?TPb+zcHjBh3rfNzdx4FSS5UYJScXYENZ+9Mmn8/WlGA2imOc3s2/tkF+d0yq?=
 =?us-ascii?Q?3+Mvi9LAtrLBSJkeqAUsFXt50YFcktZ/I/prUeS/j15GeJuSEyjQz3DbVTHH?=
 =?us-ascii?Q?eUkn5Jzcw7NIJA5m5vNjT3s58xA349WY/AyGt6gSIq87SO0EjqDnJfeRq/Fw?=
 =?us-ascii?Q?5BBJ9P7GL8/IMrECzoDuujEDWfY+9X34G9ZefHS/DMe069vb0uVVPqzwCWkm?=
 =?us-ascii?Q?lRaGhZkkdDheTNAfhPDEhEE2YArh7deEqS/upANrqRY+h3rl/3JPcH/ARgWm?=
 =?us-ascii?Q?DKyHI/NsXPDRtjvqdumI35AQS5FYEcszZsWWr7zgkPv1P5FQjiQKm96FitV2?=
 =?us-ascii?Q?50hvxVpadeA+xc7Z2BtFyY4yMeZIVFDo4jemljM9zc54cwGxGrQHCLbU+DeT?=
 =?us-ascii?Q?SDw62W3qt2MSHiFoSlaYayUJZ4a4+byjyMbfM/o+wEYgZg8sDPwQFaRBJUzG?=
 =?us-ascii?Q?NSvFwa6VrawJnnijCRhcVKpZ8wak2hUhtKWmyw0ScaYMsm5Fs3VDfaQFSPHD?=
 =?us-ascii?Q?yne8n9hzv072AhWxLvB5wVG29kmgUdI4Qt2re2q2xm8SyT077qz/F88sMVFl?=
 =?us-ascii?Q?MaOXO7i4QoXvR5DMLf015teA8IykPK09oFbOzMQ4CIXCbfu7AZmACd4ECn0V?=
 =?us-ascii?Q?iP7LN5J3OTxdTsp4gW7cKkM5Bq7jGiOicr4d1HM+MbIAuC/eHq+mlkMvr/zz?=
 =?us-ascii?Q?JFSG0w+YfRcbUlkPYiarR03g7OqYv2f9/KY/+kbqLywzo8RlJ6VYBj7bV4iJ?=
 =?us-ascii?Q?mXhl1fSc0QqkKhjc4J3Hj4xYvJcYznhYfhZY?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:03:29.0613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa534a6-95ad-4813-52bf-08ddfaa1975f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR19MB9166
X-Proofpoint-GUID: TY3Cq6gs-c-mkFx9sFtj8mhBlxCIMtmk
X-Proofpoint-ORIG-GUID: TY3Cq6gs-c-mkFx9sFtj8mhBlxCIMtmk
X-Authority-Analysis: v=2.4 cv=V8Z90fni c=1 sm=1 tr=0 ts=68d29aa8 cx=c_pps
 a=bYRzraljH1LAKK9Y2O2T7Q==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=GTlLb6rYokJ3iJu21FcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyMSBTYWx0ZWRfX6NXPwU/4oAGJ
 KMEiY542OWrD85Ck28/TxbgetgxLzxPDp1nv96yelc1S93wNKv5wz4w0ZaA3kYhwZEhauzNsePe
 4OxY+c1LpvtJLsyJsc+RRPGh5n8AnITWf7mV/cOb6FikkA4aon72/P58uOU7J0DvA6goxfkQ3s2
 EsNt7Qmkx6Hs9VVi5+LigM6xmYCtHuFCJ9vHzjtVAUv4smj3XULcHapl1/tKbS/r0CnY8iZEs9z
 z6ICHn4hzPYl3OCC3Oo7AEPlqmN0pKmXUZaBj1vFnDOOLLgbfUP8cYWQE/5YiiWzPIcrhQbQA5k
 pqVILG1kZ6Nk1aLB/ogDlccQkxQfdJmJjcnFuDWMo5E9HSJkZ/ynWzmoiU3lzw=
X-Proofpoint-Spam-Reason: safe

Defer setting the cs35l56_base.fw_regs pointer until after the REVID has
been read in cs35l56_hw_init(). Also make the corresponding change to the
cs35l56_hda drivers to prevent a build break.

This is preparing for firmware registers that change address between
revisions of the same device.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h                       |  3 -
 sound/hda/codecs/side-codecs/cs35l56_hda.c    |  1 +
 .../hda/codecs/side-codecs/cs35l56_hda_i2c.c  |  2 -
 .../hda/codecs/side-codecs/cs35l56_hda_spi.c  |  2 -
 sound/soc/codecs/cs35l56-i2c.c                |  4 +-
 sound/soc/codecs/cs35l56-sdw.c                |  4 +-
 sound/soc/codecs/cs35l56-shared.c             | 59 +++++++++++--------
 sound/soc/codecs/cs35l56-spi.c                |  2 +-
 8 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 7c8bbe8ad1e2..20dc3ee6378d 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -337,9 +337,6 @@ extern const struct regmap_config cs35l56_regmap_sdw;
 extern const struct regmap_config cs35l63_regmap_i2c;
 extern const struct regmap_config cs35l63_regmap_sdw;
 
-extern const struct cs35l56_fw_reg cs35l56_fw_reg;
-extern const struct cs35l56_fw_reg cs35l63_fw_reg;
-
 extern const struct cirrus_amp_cal_controls cs35l56_calibration_controls;
 
 extern const char * const cs35l56_tx_input_texts[CS35L56_NUM_INPUT_SRC];
diff --git a/sound/hda/codecs/side-codecs/cs35l56_hda.c b/sound/hda/codecs/side-codecs/cs35l56_hda.c
index 36fa62a41984..5bb1c4ebeaf3 100644
--- a/sound/hda/codecs/side-codecs/cs35l56_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l56_hda.c
@@ -1049,6 +1049,7 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
 		goto err;
 	}
 
+	cs35l56->base.type = hid & 0xff;
 	cs35l56->base.cal_index = -1;
 
 	cs35l56_init_cs_dsp(&cs35l56->base, &cs35l56->cs_dsp);
diff --git a/sound/hda/codecs/side-codecs/cs35l56_hda_i2c.c b/sound/hda/codecs/side-codecs/cs35l56_hda_i2c.c
index d10209e4eddd..1072f17385ac 100644
--- a/sound/hda/codecs/side-codecs/cs35l56_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/cs35l56_hda_i2c.c
@@ -27,8 +27,6 @@ static int cs35l56_hda_i2c_probe(struct i2c_client *clt)
 	cs35l56->base.can_hibernate = true;
 #endif
 
-	cs35l56->base.fw_reg = &cs35l56_fw_reg;
-
 	cs35l56->base.regmap = devm_regmap_init_i2c(clt, &cs35l56_regmap_i2c);
 	if (IS_ERR(cs35l56->base.regmap)) {
 		ret = PTR_ERR(cs35l56->base.regmap);
diff --git a/sound/hda/codecs/side-codecs/cs35l56_hda_spi.c b/sound/hda/codecs/side-codecs/cs35l56_hda_spi.c
index f57533d3d728..f802c83c57b4 100644
--- a/sound/hda/codecs/side-codecs/cs35l56_hda_spi.c
+++ b/sound/hda/codecs/side-codecs/cs35l56_hda_spi.c
@@ -30,8 +30,6 @@ static int cs35l56_hda_spi_probe(struct spi_device *spi)
 	cs35l56->base.can_hibernate = true;
 #endif
 
-	cs35l56->base.fw_reg = &cs35l56_fw_reg;
-
 	cs35l56->base.regmap = devm_regmap_init_spi(spi, &cs35l56_regmap_spi);
 	if (IS_ERR(cs35l56->base.regmap)) {
 		ret = PTR_ERR(cs35l56->base.regmap);
diff --git a/sound/soc/codecs/cs35l56-i2c.c b/sound/soc/codecs/cs35l56-i2c.c
index 073f1796ae29..0492ddc4102d 100644
--- a/sound/soc/codecs/cs35l56-i2c.c
+++ b/sound/soc/codecs/cs35l56-i2c.c
@@ -35,11 +35,11 @@ static int cs35l56_i2c_probe(struct i2c_client *client)
 	switch (id) {
 	case 0x3556:
 		regmap_config = &cs35l56_regmap_i2c;
-		cs35l56->base.fw_reg = &cs35l56_fw_reg;
+		cs35l56->base.type = 0x56;
 		break;
 	case 0x3563:
 		regmap_config = &cs35l63_regmap_i2c;
-		cs35l56->base.fw_reg = &cs35l63_fw_reg;
+		cs35l56->base.type = 0x63;
 		break;
 	default:
 		return -ENODEV;
diff --git a/sound/soc/codecs/cs35l56-sdw.c b/sound/soc/codecs/cs35l56-sdw.c
index 3905c9cb188a..42d24ac2977f 100644
--- a/sound/soc/codecs/cs35l56-sdw.c
+++ b/sound/soc/codecs/cs35l56-sdw.c
@@ -527,16 +527,16 @@ static int cs35l56_sdw_probe(struct sdw_slave *peripheral, const struct sdw_devi
 	case 0x3556:
 	case 0x3557:
 		regmap_config = &cs35l56_regmap_sdw;
-		cs35l56->base.fw_reg = &cs35l56_fw_reg;
 		break;
 	case 0x3563:
 		regmap_config = &cs35l63_regmap_sdw;
-		cs35l56->base.fw_reg = &cs35l63_fw_reg;
 		break;
 	default:
 		return -ENODEV;
 	}
 
+	cs35l56->base.type = ((unsigned int)id->driver_data) & 0xff;
+
 	cs35l56->base.regmap = devm_regmap_init(dev, &cs35l56_regmap_bus_sdw,
 					   peripheral, regmap_config);
 	if (IS_ERR(cs35l56->base.regmap)) {
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 95d018ecb953..03ea66f08787 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -309,6 +309,40 @@ static bool cs35l63_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static const struct cs35l56_fw_reg cs35l56_fw_reg = {
+	.fw_ver = CS35L56_DSP1_FW_VER,
+	.halo_state = CS35L56_DSP1_HALO_STATE,
+	.pm_cur_stat = CS35L56_DSP1_PM_CUR_STATE,
+	.prot_sts = CS35L56_PROTECTION_STATUS,
+	.transducer_actual_ps = CS35L56_TRANSDUCER_ACTUAL_PS,
+	.user_mute = CS35L56_MAIN_RENDER_USER_MUTE,
+	.user_volume = CS35L56_MAIN_RENDER_USER_VOLUME,
+	.posture_number = CS35L56_MAIN_POSTURE_NUMBER,
+};
+
+static const struct cs35l56_fw_reg cs35l63_fw_reg = {
+	.fw_ver = CS35L63_DSP1_FW_VER,
+	.halo_state = CS35L63_DSP1_HALO_STATE,
+	.pm_cur_stat = CS35L63_DSP1_PM_CUR_STATE,
+	.prot_sts = CS35L63_PROTECTION_STATUS,
+	.transducer_actual_ps = CS35L63_TRANSDUCER_ACTUAL_PS,
+	.user_mute = CS35L63_MAIN_RENDER_USER_MUTE,
+	.user_volume = CS35L63_MAIN_RENDER_USER_VOLUME,
+	.posture_number = CS35L63_MAIN_POSTURE_NUMBER,
+};
+
+static void cs35l56_set_fw_reg_table(struct cs35l56_base *cs35l56_base)
+{
+	switch (cs35l56_base->type) {
+	default:
+		cs35l56_base->fw_reg = &cs35l56_fw_reg;
+		break;
+	case 0x63:
+		cs35l56_base->fw_reg = &cs35l63_fw_reg;
+		break;
+	}
+}
+
 int cs35l56_mbox_send(struct cs35l56_base *cs35l56_base, unsigned int command)
 {
 	unsigned int val;
@@ -979,6 +1013,7 @@ int cs35l56_hw_init(struct cs35l56_base *cs35l56_base)
 		return ret;
 	}
 	cs35l56_base->rev = revid & (CS35L56_AREVID_MASK | CS35L56_MTLREVID_MASK);
+	cs35l56_set_fw_reg_table(cs35l56_base);
 
 	ret = cs35l56_wait_for_firmware_boot(cs35l56_base);
 	if (ret)
@@ -1280,30 +1315,6 @@ const struct regmap_config cs35l63_regmap_sdw = {
 };
 EXPORT_SYMBOL_NS_GPL(cs35l63_regmap_sdw, "SND_SOC_CS35L56_SHARED");
 
-const struct cs35l56_fw_reg cs35l56_fw_reg = {
-	.fw_ver = CS35L56_DSP1_FW_VER,
-	.halo_state = CS35L56_DSP1_HALO_STATE,
-	.pm_cur_stat = CS35L56_DSP1_PM_CUR_STATE,
-	.prot_sts = CS35L56_PROTECTION_STATUS,
-	.transducer_actual_ps = CS35L56_TRANSDUCER_ACTUAL_PS,
-	.user_mute = CS35L56_MAIN_RENDER_USER_MUTE,
-	.user_volume = CS35L56_MAIN_RENDER_USER_VOLUME,
-	.posture_number = CS35L56_MAIN_POSTURE_NUMBER,
-};
-EXPORT_SYMBOL_NS_GPL(cs35l56_fw_reg, "SND_SOC_CS35L56_SHARED");
-
-const struct cs35l56_fw_reg cs35l63_fw_reg = {
-	.fw_ver = CS35L63_DSP1_FW_VER,
-	.halo_state = CS35L63_DSP1_HALO_STATE,
-	.pm_cur_stat = CS35L63_DSP1_PM_CUR_STATE,
-	.prot_sts = CS35L63_PROTECTION_STATUS,
-	.transducer_actual_ps = CS35L63_TRANSDUCER_ACTUAL_PS,
-	.user_mute = CS35L63_MAIN_RENDER_USER_MUTE,
-	.user_volume = CS35L63_MAIN_RENDER_USER_VOLUME,
-	.posture_number = CS35L63_MAIN_POSTURE_NUMBER,
-};
-EXPORT_SYMBOL_NS_GPL(cs35l63_fw_reg, "SND_SOC_CS35L56_SHARED");
-
 MODULE_DESCRIPTION("ASoC CS35L56 Shared");
 MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
 MODULE_AUTHOR("Simon Trimmer <simont@opensource.cirrus.com>");
diff --git a/sound/soc/codecs/cs35l56-spi.c b/sound/soc/codecs/cs35l56-spi.c
index c2ddee22cd23..9bc9b7c98390 100644
--- a/sound/soc/codecs/cs35l56-spi.c
+++ b/sound/soc/codecs/cs35l56-spi.c
@@ -26,7 +26,7 @@ static int cs35l56_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, cs35l56);
 
-	cs35l56->base.fw_reg = &cs35l56_fw_reg;
+	cs35l56->base.type = 0x56;
 
 	cs35l56->base.regmap = devm_regmap_init_spi(spi, regmap_config);
 	if (IS_ERR(cs35l56->base.regmap)) {
-- 
2.39.5


