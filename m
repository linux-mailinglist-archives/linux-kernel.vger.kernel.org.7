Return-Path: <linux-kernel+bounces-865113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFB3BFC411
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38B6D568860
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E13348882;
	Wed, 22 Oct 2025 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="QTXjx0we";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="FalwnkRL"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C5347BBA;
	Wed, 22 Oct 2025 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140398; cv=fail; b=JaCAyAg1YyCTYLw98qpLbzNNkLBJ05hri5t/LUxTYjFhiRhf6Ktp94h5tzKgno85TKsW2vzZRjmK+ixIVFIGgTV1Oszm/N70iib1oaoWkphzryeVkneYI6nOj3SOYBVaAVZL2k/J/QLmJPfFVjj0wkEAYNgUm2e6KEPhdOX3u+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140398; c=relaxed/simple;
	bh=FtSScyf5EgRqOIRZI2mS9zLUdoOtK7gx5EQh8QgWEq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihG2J/ofCcWzamKczIZe1xPZd/9ml3voCKfisjMaafahhkTp2eKxuhkxp/y9Vj9QXfXzsK8R43p7SUqqkNrOEGUA6fewz5Qbvd6E+sIlTfj7ARBg5P6gP6Mi8F0iKT9BiQOPQUNrZqlSEyf9sDJ48KdH3lWkzen6AeTKrOcOV8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=QTXjx0we; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=FalwnkRL; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59M3iZac3659668;
	Wed, 22 Oct 2025 08:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=9v899Q3ovyP7EllcrgOk31MF/ab8qDRP7T5pmF6KYj4=; b=
	QTXjx0weuT14tXg6lyZ4errKtYTyxu/FzmTGkex+KHukZVL/3m/ECLPmSQ2pYXGn
	Fyi28O5VAJEQFSx7z+DgBmm+PegQOCKOsFMY8HKViIV74o8feEzfGZObQgRRzLRZ
	T4dLH0j+c7TxQbHjMW/7zFEwAHB12eu4ozE5n/h7lbyKSgN47dzVFt/Q4Lv5VbmT
	PAPvfCmyAh1NzbNRjQWedNw4eAXI8iti+VXtWRZ6LKXDqr130SNol/8r5ULTYVte
	x7RJkYxvQK3utehZ2EygKobG8PKd9krYUj3BDGxO4+5y5WRQyz5mQAx6j8u6rRec
	P8UyMNnJTh6Hv3q6gjiBPQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020133.outbound.protection.outlook.com [40.93.198.133])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49xqmqrjq2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 08:39:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeyllPNT9v6AX/4spd31glyFQRvPTSKVb3MLY54tPHxfostAZrPJaf+2DUFt/agEpt8f6p5uQPtgbWVvgOhKA8eDC9sD33exMre4acj2Zf472BQbteIyBMLDQfTuR/PSBi5wuHAhsi+1cd17Yc3m0WyrV3uFPSEs4CwVVLqqKPlUnOnTuO5vBKvAlFts7qwD8hT+2hA9GrUNVaBEqOC7azRIOmXKvXnU/mWAR6Yf6rloEUGe17vX/nFg2ItWwV0WmVv0BkHl1N4FyOlxr3BRDOIkQBN37/S2/Pb8gWCuan10SZpe1NLRiJhI9dUWOiZ1KfEOdxp4/wmOSzKzjt1GUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9v899Q3ovyP7EllcrgOk31MF/ab8qDRP7T5pmF6KYj4=;
 b=k2x74HcrUFVvHEtTINPZgiR49828ZAHBhjeE7E3BmJfjhPq/MPNCYCnnvUsVOkbsV5iEvW8stjWAp1OOkn+lg2Pmlny/1lrP410sA/Or17Slk/L4FAzXLd2LqKUqQRp/5CGbw0HzayO3gR0ZMN/1AJA6EXaut0hB3FbV+LDpoiOLn7/1PepR0V8jbOHvqc+gwn2VXdzIRYCCRqAVbDxWvw6TghRoXN/E8drJy01tqEiV2vgi8/EHlEhaJK5Bt/j4e9wxMKWaIg9WJuBIL4wTaDuUtHXvcjIj+UjaEMt68pToWafbUGEDAvlHKFB2n3UKAWo0Pm/Lc+Nhvg0Sxx8KaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9v899Q3ovyP7EllcrgOk31MF/ab8qDRP7T5pmF6KYj4=;
 b=FalwnkRLOHOE2L/EPIQzW42DWOoP1PDCbltCzXd+I+HFJdURTc3znX/03LDK6TJh6jvAb8bj9VToi5vfryhQzjLybpKwd78xXmAjM+y/c/SffgrRumNmdKQQ854DDGhhB0kIrNi+rpW2e3pGYed5F3noOTI0ZfNjnDxfkvoFAao=
Received: from SA0PR11CA0190.namprd11.prod.outlook.com (2603:10b6:806:1bc::15)
 by BLAPR19MB4212.namprd19.prod.outlook.com (2603:10b6:208:275::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:39:38 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::f2) by SA0PR11CA0190.outlook.office365.com
 (2603:10b6:806:1bc::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 13:39:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Wed, 22 Oct 2025 13:39:36 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id E56BB40655D;
	Wed, 22 Oct 2025 13:39:34 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 7F77C822540;
	Wed, 22 Oct 2025 13:39:34 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v5 08/12] ASoC: cs530x: Check the DEVID matches the devtype
Date: Wed, 22 Oct 2025 14:38:49 +0100
Message-ID: <20251022133914.160905-9-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022133914.160905-1-vitalyr@opensource.cirrus.com>
References: <20251022133914.160905-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|BLAPR19MB4212:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a4d73de9-3a7c-4be8-19b1-08de1170714e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NHKszLJggzekymmw8aR+WZ7/LBWRI6tOoXp8SCXcyt6TMSnM0PaH+Cdxmxf9?=
 =?us-ascii?Q?8tf+F+4K0AgvIZk/OMNeQDdBYr9Wa/m+OgbZDVS+UpyiIgedCcFxd+gFxA2E?=
 =?us-ascii?Q?prgT80RBknnhvY8BNTk9ON/rbWPx/xowqcv3XB4a82CCZcFHhGdDHj5ovv/S?=
 =?us-ascii?Q?BlfyfsWOsUXsuyNyWNVjJpB8j0d+6EznUwu+3zRXMuD0F1ERG97Z2laooRw2?=
 =?us-ascii?Q?39KJPDV3b38NfxgKNyw/Glv5TTFO+JRxL2aCNMIOFWntnGjYp4mR5RY4nlhV?=
 =?us-ascii?Q?LJt8KpvurQPGawKd8+2ikvEZLUdlHnxtNyCdXQ4IqiNQcgug6viNyB6B5VDi?=
 =?us-ascii?Q?r5fnmn34waPQogp0b9ohtPKgLRTo2q+DuqaQKJ2A0atnt6DiDSmj3UKS4Td3?=
 =?us-ascii?Q?BzuLrsZZ9bui/l3ArgloPa5rIeuwepghqOFEIqroslZXHQ07Ga79JR11gI5Z?=
 =?us-ascii?Q?QoN6hGVujqjLIGCCNJ2L1SxH58/bPaKF4j1kdiv54k2XW/DTUIT1rAZG1SyM?=
 =?us-ascii?Q?hqyxLAmSWNVdNXg0p8SjCmDn16HTW3/xG1hIaWQrvs7DZIRXquWSEs+8D3hP?=
 =?us-ascii?Q?jVoKC/7CMOKDQQG7HGF7gEJ3nlem09v11BNpBOm26duJ9JZxwCM0zasByM5v?=
 =?us-ascii?Q?3ZNPpggcNMeNltpepdaPsNO9CmWT9FapyCEFWrfEo3durlelABa+Fb+FcrOz?=
 =?us-ascii?Q?Xl5qiIErGfoF2lJfvBqWETRI06eEDkhKexMiCwwtW7iWmeR0dZWnZqHzMjCS?=
 =?us-ascii?Q?zDlrZfIZQSOQIZ17UhN79UTtXblWlD/hzRNDUgzfKPen7Pr04ggBjXubB49O?=
 =?us-ascii?Q?CHNQBSQ19kG1h4/LxrjGPd8leg1RV41Ag7X3wkKzU15orWXV9bncpPKZxuup?=
 =?us-ascii?Q?QzqCNzMCzMTM+2Po/Qb27K4yCzspvwqueInzaJipjxY5b7SQBuP1324/08ar?=
 =?us-ascii?Q?SMDKH+tddN8hN/PzQsh6cd07dl9e2gKKEV/+g8q/rmdYcxCfULhpwA8vsLoM?=
 =?us-ascii?Q?mF/dsCr5b5XLcCwVSrtAjcJfFMLDYTilqA5JaAL/yKysqDXHGBTgDO6yOZPZ?=
 =?us-ascii?Q?eXite7Jh2EE4L6mUGHKgin3l83uasODnOtBTGVkFMQ7KBa5UWDqzljUdbow3?=
 =?us-ascii?Q?3ZyqyJmnV+jCAYeRUB9lxnfXFQLIQcoqyPpvHpSxj2AwL4qT8Q+DN8lOEnK8?=
 =?us-ascii?Q?ndMecaH2quw58mcSerdOGw7O4s5xV1CAfA6ouqSx5yQytD9g0q/U+nlGyLor?=
 =?us-ascii?Q?huV5OLadWk9lXGwww5jGsSIObyc2kOA3iKeDhkpNpDL7cyoZiLky3lO4BYaR?=
 =?us-ascii?Q?Bw4hkQZvrRJeo9uXJo7+nGXFP3iFtIWKWh0rpoZTba3YCMxd7X4BOzxqL0Nj?=
 =?us-ascii?Q?SYTibG3TLgvMgvxflzmcjPbKpkM468TZRCwQp2BpQBKFBPBKL1yKWHRBoYTk?=
 =?us-ascii?Q?Iyz0VgOIBTGitlszIxDISFl9gxD4WB8QZjldWyX1lCUnj+LlAJNro+Jt33Ej?=
 =?us-ascii?Q?qFhgf4JuChG7c4DU7T10dvRBbH8RF67lkikTRfi6xnR74hNCkUkeZxoVszwC?=
 =?us-ascii?Q?73IxRfmBy5YfXVmepJE=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:39:36.5423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d73de9-3a7c-4be8-19b1-08de1170714e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4212
X-Authority-Analysis: v=2.4 cv=G6gR0tk5 c=1 sm=1 tr=0 ts=68f8de9c cx=c_pps
 a=QtilNflqjlihrLF22repcA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=w1d2syhTAAAA:8 a=Ueq04TJKjEWbJfMvJoAA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: YdTVfVBRWn_SBIKSDv12IuIRlGT6gUs_
X-Proofpoint-GUID: YdTVfVBRWn_SBIKSDv12IuIRlGT6gUs_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDExMiBTYWx0ZWRfX6Bnr27jmgdky
 fqlOUsyNNapAC5z0FbvyfUFtd+20SkxW5UG9p76M0ktMQYQRy5cPQIQFwxbdbwBDNeh4vg1ocEA
 Ny+nM7EuGYpwSESncOBw4bdrFvGyy2PElYdN922AY7rsyTi/LbFS+sp2n36nFArkSHyW+ZZDqBH
 3UwZNOp9zrrG+jvCmMYHauLPJJBPnRqYqRkUiQm4ADOFj7qeyLfV1EsM1u38izqzBDCFTFQQJ4v
 e0HWjYV2nKwW4yhx664QqfoavUVgbvmzyGyZd5gKfipk9uLY0dejwhea4AqfDD/OL/SgsfI44nw
 cnH7wc+MIWaHZ+B/M/mNeF4jWc8T0dbHrdfyi23uTj6vlOIL6T348HDABsv4YYYckz3BwVL5wmX
 ip5apK83/Bqdeax9zJ7o4v4rieMILQ==
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

If the read device ID is not the expected devtype derived from the
compatible device match then fail the probe as other configuration
details may be incorrect.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c |  6 ++++++
 sound/soc/codecs/cs530x.h | 14 +++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 193d7af5cfd5..7dd9e5d19336 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -1181,6 +1181,12 @@ static int cs530x_check_device_id(struct cs530x_priv *cs530x)
 				     dev_id);
 	}
 
+	if (cs530x->devtype != dev_id) {
+		dev_err(dev, "Read device ID 0x%x is not the expected devtype 0x%x\n",
+			dev_id, cs530x->devtype);
+		return -EINVAL;
+	}
+
 	dev_dbg(dev, "Device ID 0x%x Rev ID 0x%x (%d in %d out)\n", dev_id, rev,
 		cs530x->num_adcs, cs530x->num_dacs);
 
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index 52fb148df36a..d11711715ba8 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -211,13 +211,13 @@
 #define CS530X_NUM_SUPPLIES		2
 
 enum cs530x_type {
-	CS4282,
-	CS4302,
-	CS4304,
-	CS4308,
-	CS5302,
-	CS5304,
-	CS5308,
+	CS4282 = CS530X_2CH_CODEC_DEV_ID,
+	CS4302 = CS530X_2CH_DAC_DEV_ID,
+	CS4304 = CS530X_4CH_DAC_DEV_ID,
+	CS4308 = CS530X_8CH_DAC_DEV_ID,
+	CS5302 = CS530X_2CH_ADC_DEV_ID,
+	CS5304 = CS530X_4CH_ADC_DEV_ID,
+	CS5308 = CS530X_8CH_ADC_DEV_ID,
 };
 
 /* codec private data */
-- 
2.43.0


