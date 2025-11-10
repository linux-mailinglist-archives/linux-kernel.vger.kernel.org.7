Return-Path: <linux-kernel+bounces-893038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EED5C46678
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8288B3BD225
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609A930AACE;
	Mon, 10 Nov 2025 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gJEoPjzC";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="GwidHax3"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BACA24BC07;
	Mon, 10 Nov 2025 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775758; cv=fail; b=ghnftrGroIVdvDN/7QE4AA4gyf0eGGv+ww23NnKM03YWZquBMl2k1IcPMqFJsa6pxggs7Mrlxvh07wpBgKH8eoB7pllcXhXzXesK3pjdBqdhNMG/2OH72fehQrLNn2VGynFu7MJzZMIbfStHn/mfZU1UvAv3ISqHey3vaHNq50U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775758; c=relaxed/simple;
	bh=SjGZ8b2VlKIzR2Tk0JhuBFusbBhmgypnInVUDh8gqkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ekwCYQl3tZzMG9f8+VrCZImvPgA1qVQpnGFFe4NFcgjGAutSxF2oiqA//ViuRIgYI+fMbB48ucwbboS/TPFcjXWq6Cm5uqn9SKCwLPH/EtVDD9RL8PKymPnw7cPpBTcdmLIiIfqcIymH63wWqj6XkH5c7Zd+wehTGZEmG252hgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=gJEoPjzC; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=GwidHax3; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA4iD7r1136337;
	Mon, 10 Nov 2025 05:55:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=ORWH+jnoSSiYqcLJ
	8U9pFuUqk2LvQYOHPm6g5ANwQ+Y=; b=gJEoPjzCATtXh5kS4glK+PEOF1Hx0vHh
	Dr59icl+GUIVuCRw3qZDpmYBcyfY8m18woOc0JuAmjdHBh9EA2odjTFyfANR0Y6r
	tALOof0USk08U3jh/1uTBa74FaBMN9Ev6QfytJrAD9rCBg+i2O7gvvpkcusBem4i
	n6TDuHuvXdK1TPcAkk50JCqUN0urISXianO6ZS0PC/L8snOGuIAWtFMJm9N3s5ch
	RFchIfr4Gs15ySnaKav6dBrbtq00QbE7+yFUPWGUHUEDfhHManFZCf6UHlaIEhNe
	7FSRxk9X1lH67gcfRRHm2R6z2+h4qOLy3E2bGMDHJMpt1E9mAiBBaQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022119.outbound.protection.outlook.com [52.101.53.119])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4ab5fpgjh6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 05:55:39 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQn23aQPyUPaWDJ53oJGFOjBSZEEGFc0VmI9pBBt25x5AoUxBZLd7Gd6VX+r7ovtYy3ogtq/3AnyQ8JCQTXdIgjorRyOjJbnYaxd/EXkUuc82TpoOh5fnOoQLUjGBUeMt6KrGE9IJFofCLQeyIsDHXgMJSnV/zu2oBQeL0xd5THf7havy63hkxh347yV+yOaFdYZAi9vTzhVrBdcnonQ0K4/6hn1V6qJgZxDi3lnh/yT2IulFUaHyIa/GGjp/bNC28cfHgcZPlbEP0kSBwoQ2m6iZqS6XevQQT3NIr4Jv4eE3udPnhEI6KvNOHGry+97DCNn5YlulFBwvaYaZlZjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORWH+jnoSSiYqcLJ8U9pFuUqk2LvQYOHPm6g5ANwQ+Y=;
 b=l+I5uSvsPg5O9+VHR8SH9WGEzfcsrjTvVZmU7vx4zIfTUmEyIaSwEKqaCcjMbVD14c2rKALcAlkIsvSqi7A4GcnF2Cy+S0A1XtdReI3cL+JGQO07sAuy0kL0FFKBYPj0UFP949iMkJcWzmUuPNa/1BZphsCQwHxy8prh5aYuWPSWtL1WXqu+Dr/UeeYZEDB0yoLVX7jzcPUHAC8Z9Dxg93pJKqqvC+xszUvi+OPBujYy9pFD/29+ZTPCc/gyS7or3SbLAp3LpGHdrbXTGWmwBSv1CwX2KIV86yZtRcLU4CmKkh94RabLT10gACZqDgdD40R/YvzqJ6YJCfrAZ7aVzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORWH+jnoSSiYqcLJ8U9pFuUqk2LvQYOHPm6g5ANwQ+Y=;
 b=GwidHax3RA2Tez5IL9UuxJjl3n5WdSDBAWYFpfWOHxOjr9pwxfs5N3DN0YNamWZYY1LXYUYp2JYvZHujhyiDH4JYiTfx1Hwgo2/EQPudfxvK1OL/+5IuPJyoNC5wudEaRYICyqN1m2DIr3/tnthR8X+d7UZM9u3qHbRNmdM92PA=
Received: from SA1P222CA0042.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::16)
 by IA1PR19MB6545.namprd19.prod.outlook.com (2603:10b6:208:3aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:43:30 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:2d0:cafe::ca) by SA1P222CA0042.outlook.office365.com
 (2603:10b6:806:2d0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 11:43:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.13
 via Frontend Transport; Mon, 10 Nov 2025 11:43:29 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 4CEC2406540;
	Mon, 10 Nov 2025 11:43:28 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 2A285820257;
	Mon, 10 Nov 2025 11:43:28 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH] ASoC: cs35l56: Alter error codes for calibration routine
Date: Mon, 10 Nov 2025 11:43:27 +0000
Message-ID: <20251110114327.84370-1-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|IA1PR19MB6545:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 98d40093-b19a-4df5-d625-08de204e5e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kjkSlGjEuVCZHKW5qzCnbQFrSuLJGXNDjhKtY88eIuDIkKwRqtPRi/yERKtF?=
 =?us-ascii?Q?iBiWhuV1vw852KKyVvRNvRtCVLovaw7xYo657PcYo3tJYCfrdk8vUgtY/kRf?=
 =?us-ascii?Q?9A8Jmy+JJ+WfOJPY/XzchpYbAt8MGoXnLDpGA9EermY9eIdpKnmjLKfdrwpn?=
 =?us-ascii?Q?/EGhmxc5ERW7RxLGozr9PbAFA2dqCSYeCbDGybNkRmJrpEenEziBIkqc1Nah?=
 =?us-ascii?Q?Sk1TsAnRWxIDsLw3Q3ZJC7vGFWiWNTt9ZAZlU8Fin1rGxgtybF/VNxbasCja?=
 =?us-ascii?Q?2n1rwCyjTufTfY4EauzLyI1tRgewY1V+JJch3j2lsuhSJlSTznP9QEe7xGrh?=
 =?us-ascii?Q?27yFRUYZ0bBtZQR4ZwJAxzSPPFWocWW3jpkUjy6zNbBiz6eqgO3Jxwe1JRn2?=
 =?us-ascii?Q?AwnMtDH/c1eZeb96asjPN2KI00gjKHnXlfDfSGlUejYShbiEP5wVDQUwHV3B?=
 =?us-ascii?Q?P+oHyzDOpWVJzVW5Xlwv2HdBZ8oRNHuvaNFO2AX8zKfTuZg+hQtA30B1U/PQ?=
 =?us-ascii?Q?3kL1/SqzwbxBkgEpk7mQL4Agig3UJLkN7M8Sn7kWzgjMhdqIMR99fMFis98L?=
 =?us-ascii?Q?/4ThcMrZN5OWqXhu0RmmQqZuKpkLwwAlYabo3BjOaLxWk6/Se5+GealQEc0j?=
 =?us-ascii?Q?p/onX7M1lwFxqmXkVKIoO6HvIcg7tA+9NwcI29b4/1NYWOuchp34HgZIQmQp?=
 =?us-ascii?Q?9qF0gsGBJ3SQvswrh3MxRL15VSLn0ZWRFI06Q3j0g3vUhRhOknDa2YVHP0r0?=
 =?us-ascii?Q?K9x38ZHHkqibfmMryWWhP7pK+5GW3evxvwqWqeODhmqaUtjH8dUFhFU8Y2JZ?=
 =?us-ascii?Q?64wKUd0MSS4hbr6loXi3qi9QHSPFWrYXwtfvgWrDrqSpe9pcavpbLx1k4igB?=
 =?us-ascii?Q?hxnQ5TT22X+U6ssJ8vQ2XR515fMnCjEzWwLbVc39azkCDzsKMgKPkdQ3nQN0?=
 =?us-ascii?Q?6ow+ajCoveD2XwimaXEzxMJ9MuIqPc6Ra1letsrvrdn4812/HVl/W59HqgnO?=
 =?us-ascii?Q?GND5DAG4WYWvIyU8LTKqQ4mTolvpQqZIT7mE5+DHRAuGdYsKw5LO4ZWSipsI?=
 =?us-ascii?Q?RUC0zYtP1D53Wya8qUqsuxim4HfyKAIyLrSzplhnYKVBz9qo+0l3XmOKx5kt?=
 =?us-ascii?Q?oH0Kkf5vgUeUXBRizx56UtEq2SzQ13dH/LvDgDkA9jLzPe6InYc5I/abPdO4?=
 =?us-ascii?Q?wH13Etm67FcsPMVWtT5D571o+aBtYQE+ocqiTGRuWDetYsnflXa4UC0Vkefv?=
 =?us-ascii?Q?Jclp4IlW6sLLlz3pT06JYq8jpaF8bwUMSdPkLzsP+smLu6RZ8+/L9XSjEcjf?=
 =?us-ascii?Q?tLgg9otCf9NYdoMgaP2Mc89gn/8xziiEvX6IAyyw0OsvaeF4zKHP1c5N2m/K?=
 =?us-ascii?Q?bKo12F6CyDL5FIbKBAe093ZYmr7TCb3hy8StCHzAL/wXx4fnrmXg/LP+UUU5?=
 =?us-ascii?Q?Brj/0t8LUs0wZP5F0dqwc2dZ1XujRYZMHR37LxEoYwnu2X1GeglGPunSwCpw?=
 =?us-ascii?Q?6Dkqnsa+5qw7cumDTNWKSCQW3GV79+SaexeKxPn9iO+UVcsHQHaN4VFCzW1+?=
 =?us-ascii?Q?NdS6yqh5XldFR+4Q3eg=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(61400799027)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 11:43:29.4925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d40093-b19a-4df5-d625-08de204e5e7a
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6545
X-Proofpoint-GUID: AW3dOSh_A45FYxqws460xUbCT7MBQCr_
X-Proofpoint-ORIG-GUID: AW3dOSh_A45FYxqws460xUbCT7MBQCr_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEwNCBTYWx0ZWRfX1H57AXoMyU7x
 TqSJ1XAkrvbrnexZCZqhLugJIksM6rGR35sJWb81R3hLTcppnAAQ80UbRD4RIQTqk/9kLlR0iqt
 6zTcdKqR5Mzl1Hwz7yA8mbHhBC4tgxSj6IWV5OGdqDl4ilkGUl6uz+C7Ge0dK1mXsLeseYQ10e4
 +Bufyya/CCwMroJAqzyUyM294FnqPy50rcvq8ljm7wpcq/Y0EbcuSlZRPncBccQc0mLrcEsl3WR
 hM+QtrRwsRFTOi2LRItgRTpnt/ihP5adEYPtcxRIpxIm2bYpeT16itrtdvxaWdFAZF9yamP6OLU
 UfS6Tyrt34xrBgFhvHPrz4vhVoMdQP91GZ72ZE8OlvndAEsU9K31/rRvRbvan8FxbLQQbo2zwaP
 y7uZPgueEgJM5yeocHKDo6djHXrgKg==
X-Authority-Analysis: v=2.4 cv=HLvO14tv c=1 sm=1 tr=0 ts=6911d2bb cx=c_pps
 a=3pEbTsiE5+CWpS/p3ZrWzA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=Z8mtd9esTeK4yBFHWVYA:9
X-Proofpoint-Spam-Reason: safe

Adjust the error codes returned by the calibration debugfs files
to provide a wider range of errors and make them more consistent.

There is a limited number of standard errors and it's not always
easy to find an error code that accurately describes what happened.
Additionally, user code often uses strerror() or something similar
to report a generic error description. The original calibration
code used a limited set of errors to attempt to avoid user error
strings that would be confusing or unclear on a file read/write.
However, this restricts the ability to provide informative errors.

This limited error range didn't help very much with debugging so
it has been expanded, rather than worrying about what strerror()
would return.

The errors are now more consistent:

ENXIO       Calibration is not supported by the driver.
EOPNOTSUPP  The given calibration command is not supported.
EBUSY       Cannot calibrate because the amp is playing audio.
ERANGE      Calibration result was out-of-range.
ETIMEDOUT   Calibration did not complete.
EMSGSIZE    Blob written to cal_data is the wrong size.
ENODATA     No calibration data available to read from cal_data,
            or
            Blob written to cal_data does not contain calibration,
            or
            No calibration data available to save to UEFI.
EIO         General failure to communicate with the firmware, mainly
            indicating that firmware controls are missing.
EINVAL      Has its normal meaning that an invalid argument was passed.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h           |  3 +++
 sound/soc/codecs/cs35l56-shared.c | 29 ++++++++++++++++++++++-------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 82559be0f249..0a740a99ad31 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -265,6 +265,9 @@
 #define CS35L56_PS3_POLL_US				500
 #define CS35L56_PS3_TIMEOUT_US				300000
 
+#define CS35L56_CAL_STATUS_SUCCESS			1
+#define CS35L56_CAL_STATUS_OUT_OF_RANGE			3
+
 #define CS35L56_CONTROL_PORT_READY_US			2200
 #define CS35L56_HALO_STATE_POLL_US			1000
 #define CS35L56_HALO_STATE_TIMEOUT_US			250000
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index bbacac6bda81..fe0693c3f7de 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -1022,8 +1022,10 @@ static int cs35l56_perform_calibration(struct cs35l56_base *cs35l56_base)
 		return ret;
 
 	ret = cs35l56_wait_for_ps3(cs35l56_base);
-	if (ret)
+	if (ret) {
+		ret = -EBUSY;
 		goto err_pm_put;
+	}
 
 	regmap_update_bits_check(cs35l56_base->regmap, CS35L56_MIXER_NGATE_CH1_CFG,
 				 CS35L56_AUX_NGATE_CHn_EN, 0, &ngate_ch1_was_enabled);
@@ -1038,7 +1040,7 @@ static int cs35l56_perform_calibration(struct cs35l56_base *cs35l56_base)
 		if (!ctl) {
 			dev_err(cs35l56_base->dev, "Could not get %s control\n",
 				calibration_controls->status);
-			ret = -ENXIO;
+			ret = -EIO;
 			goto err;
 		}
 
@@ -1050,12 +1052,15 @@ static int cs35l56_perform_calibration(struct cs35l56_base *cs35l56_base)
 					      0, &val, sizeof(val));
 		if (ret < 0) {
 			dev_err(cs35l56_base->dev, "Could not write %s: %d\n", "CALI_NORM_EN", ret);
+			ret = -EIO;
 			goto err;
 		}
 
 		ret = cs35l56_mbox_send(cs35l56_base, CS35L56_MBOX_CMD_AUDIO_CALIBRATION);
-		if (ret)
+		if (ret) {
+			ret = -EIO;
 			goto err;
+		}
 
 		if (read_poll_timeout(cs_dsp_coeff_read_ctrl, ret,
 				      (val == cpu_to_be32(1)),
@@ -1065,16 +1070,24 @@ static int cs35l56_perform_calibration(struct cs35l56_base *cs35l56_base)
 				      ctl, 0, &val, sizeof(val))) {
 			dev_err(cs35l56_base->dev, "Calibration timed out (CAL_STATUS: %u)\n",
 				be32_to_cpu(val));
-			ret = -ETIMEDOUT;
-			goto err;
+			switch (be32_to_cpu(val)) {
+			case CS35L56_CAL_STATUS_OUT_OF_RANGE:
+				ret = -ERANGE;
+				goto err;
+			default:
+				ret = -ETIMEDOUT;
+				goto err;
+			}
 		}
 	}
 
 	cs35l56_base->cal_data_valid = false;
 	memset(&cal_data, 0, sizeof(cal_data));
 	ret = cs_amp_read_cal_coeffs(dsp, calibration_controls, &cal_data);
-	if (ret)
+	if (ret) {
+		ret = -EIO;
 		goto err;
+	}
 
 	dev_info(cs35l56_base->dev, "Cal status:%d calR:%d ambient:%d\n",
 		 cal_data.calStatus, cal_data.calR, cal_data.calAmbient);
@@ -1141,7 +1154,7 @@ ssize_t cs35l56_calibrate_debugfs_write(struct cs35l56_base *cs35l56_base,
 			return ret;
 		break;
 	default:
-		return -ENXIO;
+		return -EOPNOTSUPP;
 	}
 
 	return count;
@@ -1170,6 +1183,8 @@ ssize_t cs35l56_cal_ambient_debugfs_write(struct cs35l56_base *cs35l56_base,
 		goto out;
 
 	ret = cs_amp_write_ambient_temp(cs35l56_base->dsp, cs35l56_base->calibration_controls, val);
+	if (ret)
+		ret = -EIO;
 out:
 	pm_runtime_put(cs35l56_base->dev);
 
-- 
2.47.3


