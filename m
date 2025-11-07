Return-Path: <linux-kernel+bounces-890230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E0439C3F8ED
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 64BCC34E4A5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FC331771E;
	Fri,  7 Nov 2025 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PI8EVdxW";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="RIMQpz3q"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D282307486
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762512381; cv=fail; b=OUWB11IExv9mNGntHvTkO+dswFlq1gYW/hIjPzLqHIgsrsApaqCsL5Hcy0mz4iOEXlx32iUNcKsWpA/E53J4a84S6SNLflnYWnlU3f/9cem/R5PktNtnvUMzD5vM30yVOqxIgJHsAdXGXb8r5InMT3amvs5fLF8OFiIcU3yUWOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762512381; c=relaxed/simple;
	bh=IdYipJksha75OWbeMq5flq20E8BQQuRT37YTQxq5qGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i8NTWMLW/+2Z5AYxrQahTqWbMxdE9D96EBMtHgRnz1nHIPG4pxNsg8GIRPNW79dMk7pXbHpRDJH9390EeQ2uUjaNxXlAyc5KP1keZeHIUz0hw/hQGluJP47nRRlO0KxsYSa+4vN3EE9wm7GOiTob3FMnSuT2d6gsCovcf4iHbj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PI8EVdxW; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=RIMQpz3q; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A75Z5U73768204;
	Fri, 7 Nov 2025 04:46:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=Uk+rOO85mWGBZCUj
	f9cCHdO83PNu4iJRKMoFbQRiQwY=; b=PI8EVdxWX4nirNe/P35cpHm8X/4EKiSH
	MysFRGfRlxW0H38n07Q5uKj8lj31Q3yctNJ5jjp2Uw1tIAN5/6vwRGcF14l8kawU
	g+e/DLoj6XZ8KMytYs67/RGc8scssrjc8N13P0SfPjp9StC2IWAZ9oMD+1lEOiZW
	jMsx11L4hny7MsQE6csvam4lJMqNI00RBE6MAPagDxQBZU1qXXC5qobbkifpGCyx
	/SfGkUub6j/0TMN+2xx2Oh41pvljZXkt1MUhaoLipkS8Q0yfXB4vwEg8VY5jSH9t
	tRDEkAUrA8Y6c94+4jHtdp4I29ZZxPnVs2ERpLeMcEppU1d/PEDaXA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022121.outbound.protection.outlook.com [52.101.53.121])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4a9argr860-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 04:46:02 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFdeReX9DLwrkQnGVSS6OuVUP2T5vgb7Nv4XbLJtmcJOM/sfLgONagA7QKSCfndtpxpJaCQzCmmQ1wxKK9oB0SWoMqK+fDgR5VzORnfPbR+xxJEGm6upE0+nm5qK1GQ1xiCKn60sG5ZPT/yBNUJD5yu0ZR7cyCvQvrsUxVooq2asDtjWDp1dbR1UOY1qd0FKrjsgiaV0NKpFuF+BIPabhssTfMCak0aNwwlq+XLXOG+rjhlx5uU6wLirRCBFbECnlUqatOnSQqERVzgxOdr0UEP7VHWSPZ3OhgPYx9P/4k7y38FG5bIlsVQ1Gb4n0UK9aY2DCYRIPOwmsvpyTeyF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uk+rOO85mWGBZCUjf9cCHdO83PNu4iJRKMoFbQRiQwY=;
 b=Rqo9awLSXw16y7zSHANyjkD4T8a0jyqubTgxm4Lt/rhodksl33G07RneGwzIGz/jOLcmY+kUaCNQTtsOQGTMmsnG///OYXTfvuSOJrfu6URJW2QCKL1XsogD09N3CH+/kvw2bD2SerccOaVccO2RKI7LUamoMsuaujfdMG6pMXLWorLPIJu4IhE6FCCzW3ri8121ozczmKx+AKuVBrpX8g8tWy6E7lyiWzR4X9T7ziZLac1rrmnNe5FdbResqQLgQDKRlZya+oZYdUb051UPjyWsSEcoOjCps5DFhldUqBdLbYksXhl3kP2utGxlbvZdSAUOPOae7Kke207CQzc0qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uk+rOO85mWGBZCUjf9cCHdO83PNu4iJRKMoFbQRiQwY=;
 b=RIMQpz3qXaSDI5Y1X/6lVYpsV+4Jf79/YgtGdAxyp4AEDE87q/0JpGfJO+KzjIVIHKCpEDwD4ZmmzgAOncj0Bh8fCMME1IaMRg0ks6/IGqzN3OwzrPocQ7obPRe07Qyn1xdjfD9paF7XuTPP2/LjcEqX1RYeNphrRv146RhIxQ4=
Received: from BL0PR02CA0081.namprd02.prod.outlook.com (2603:10b6:208:51::22)
 by DM6PR19MB3993.namprd19.prod.outlook.com (2603:10b6:5:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.13; Fri, 7 Nov 2025 10:45:57 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:51:cafe::37) by BL0PR02CA0081.outlook.office365.com
 (2603:10b6:208:51::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Fri,
 7 Nov 2025 10:45:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.6
 via Frontend Transport; Fri, 7 Nov 2025 10:45:56 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 968FE406540;
	Fri,  7 Nov 2025 10:45:55 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 74826820257;
	Fri,  7 Nov 2025 10:45:55 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH v2] regmap: sdw-mbq: Reorder regmap_mbq_context struct for better packing
Date: Fri,  7 Nov 2025 10:45:51 +0000
Message-ID: <20251107104551.1553526-1-ckeepax@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DM6PR19MB3993:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a3ba11dd-f9d1-448e-b315-08de1dead4fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KtI0CIAF8ncaz7QZQp3PoqX/iTx5UX4hYWfa3Wx1T5GeTxZoR+jmkwCrcF0v?=
 =?us-ascii?Q?qOP42TEunqqT5uK1VFRA7vPzRUOGomJ9dMB7mvCcN5p/8L7OClczxM5tfyeV?=
 =?us-ascii?Q?8E2Z2zCTCHHzMUoYaUS6R3EqX71PgFr8TJXxujc9eVQu2MhyzkajB5ts+mbR?=
 =?us-ascii?Q?YQUuty5325/fXNTSc25QoU6Ka1bFfVEeB74Few04NQfL9vfVB0Ax30KNIXVR?=
 =?us-ascii?Q?NjkyPtA3KVcbssOBkcXu0uNF7Bsar3Xla1ouzBzuIZnAOv77tjALLpsacE6s?=
 =?us-ascii?Q?vb33tj53hhsPQ0sR+wj0AzKBN1y4dzeYZq4p85dPGx5refr4/75CthTOeKgA?=
 =?us-ascii?Q?uSoXj0wxUpMV9ejpsBELGuZTRJty1i5V0yRat7cIKQnQTd4x7YSsq2b6y2T3?=
 =?us-ascii?Q?57oZHmoyyZstcemv/+lDnTi6unf5cSCYyyH+GT/YYah3YQZ+fbESLpQx+S1i?=
 =?us-ascii?Q?JHqlsC+/8WA9oDcUDVIfD5/LLllzo1ioM1VXcAR2IhnT/iMTSP4ytxSUsHa4?=
 =?us-ascii?Q?5yMEEjA4MwTi4KIy0svX1SKsW1SHgGmiJJBcaziJ1yzVqKpyn4GxKwDlZPVZ?=
 =?us-ascii?Q?bNCyzF1mBnngySaM79zwvwoK7Gj6yn4z/tS+D4b/BDdU+ZqaKYMVHDIoThCt?=
 =?us-ascii?Q?sOKZ15LS5ZGbl0nydZUWcitt+GSBBqfBD6emNZRpXSzWXFZbA9l++mShYPMV?=
 =?us-ascii?Q?XoONhdXmMYI9B9gP/5/lQ+uJRDlRySHz6hh87zDN2WV0ruV5Of1Ku5KujUYR?=
 =?us-ascii?Q?L6BZlFotE5L0zG30Goh963gVUfOY+ZHhGrqsO4ux4V6ypthMUXqEbLkwa0M+?=
 =?us-ascii?Q?MTB8N9ZCZiBCnp8/sBFbEIkvwVu1XhkKNTbATygvXqJmAhad7bcRm43CF8mU?=
 =?us-ascii?Q?07OesVvnICxVl86/53WQDtBPWsKWiUOaobSXJbebm5/ctkNsVtaiQinDUG2M?=
 =?us-ascii?Q?Qavk7oA7nYaWFkELzRSbuw5d9WlR2GRw+2E45wTqUwKn40vGindh1Hz3Kcp4?=
 =?us-ascii?Q?BSI5P5Hc8TUD3SxBlx0YCRIyh9nSMEN5dlm5U+bbayGPQWczQDmcRERV4up5?=
 =?us-ascii?Q?8N+y9DL4lRSdFxuWdusk8gOIESa5Rhdx9HCVRQK92z6JCuY7AH50VUzc7zTe?=
 =?us-ascii?Q?Xv5OEsMPYtRmk1bVy6Nbnu1jnIbG7fz1EV46B8X9hRsAlN70Jl+g+1ptGrrH?=
 =?us-ascii?Q?UGrO9xS4jWWndpcHZ4hrMwJqzoABTaxAoLCCUWH/yV9I3epXlPkwHV43M1qQ?=
 =?us-ascii?Q?coFHkaL9JLzTp+KlW37vSmMijadNKhNUFnB9LCTSn1oex1aFyce6JpEJ4B9h?=
 =?us-ascii?Q?DB1orKc0GaGyinWO+/BWygwUVVnxiLRPLax6yOacZ8EckSjusBCJTkY1MAAv?=
 =?us-ascii?Q?GhSFUUjmb7aL9dTATxOYrU/2b0V4ryWn7XGHYIeDSUBGXRo1zVpqgHLUxvUI?=
 =?us-ascii?Q?NP4kNog1HsdefhwnUinf4u5saTwjgFIrVzkKtdzOft6KUNrgfKnjVnv+wP9+?=
 =?us-ascii?Q?DYIVciutKfvMSbDaHOcLlWPjJbUs8F3Tqp8cIr83EubqzknO/DqxmhHH9VxT?=
 =?us-ascii?Q?LEQ3BKDDwwREHQEq6ik=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:45:56.4089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ba11dd-f9d1-448e-b315-08de1dead4fe
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3993
X-Proofpoint-ORIG-GUID: ngYcyJvFplXVUazkQAH6snw6GpZdG41t
X-Proofpoint-GUID: ngYcyJvFplXVUazkQAH6snw6GpZdG41t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4NiBTYWx0ZWRfX0xqQSiENCgjD
 VK5Tk3f2IsV0/C2yPCnsiBYAex1JGtqVehTXpLX/lrDfzLqyuFzEcP/F/GTedcKQUtobiNu394w
 GbuqaSSfVfGlGZ/x8u7J+f94E4nLYlx9PbbHZ9xuaPI+eTmmk6Dtd0sftSO/D8K0p7NrVKavgJ8
 75Ql18A63t3LfRcPMxt9QTQckIkU4N5nwX9HtWbUVkcKEHo9YG6TpqiHRN+J/yJ+K9BIsOH1PHY
 F4Knx7W8u1tP651fk/XUpvjx10c61eJEaYxmT70EM/4ojHbtWEKCMDm7tjp5y+CoxGZRjkn7Oz0
 RSlSTxevOs9Qa1BLc4dpnIPehrO3xAITdp9tf1KFvHPW7OLqJHNrtqKMEF4ptCo6mmJ65JKFW6r
 0X4LNeBWy0UKs8FErIJo6cuPrgK4MA==
X-Authority-Analysis: v=2.4 cv=BpWQAIX5 c=1 sm=1 tr=0 ts=690dcdea cx=c_pps
 a=oNnptLBqb5AYfyJu2OfE3A==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=cxwmEv8gGgT2cgvZoVoA:9
X-Proofpoint-Spam-Reason: safe

Avoid a hole in struct regmap_mbq_context by shuffling the members
slightly. Pahole before:

struct regmap_mbq_context {
        struct device *            dev;                  /*     0     8 */
        struct sdw_slave *         sdw;                  /*     8     8 */
        struct regmap_sdw_mbq_cfg  cfg;                  /*    16    32 */
        int                        val_size;             /*    48     4 */

        /* XXX 4 bytes hole, try to pack */

        bool                       (*readable_reg)(struct device *, unsigned int); /*    56     8 */

        /* size: 64, cachelines: 1, members: 5 */
        /* sum members: 60, holes: 1, sum holes: 4 */
};

Pahole after:

struct regmap_mbq_context {
        struct device *            dev;                  /*     0     8 */
        struct sdw_slave *         sdw;                  /*     8     8 */
        bool                       (*readable_reg)(struct device *, unsigned int); /*    16     8 */
        struct regmap_sdw_mbq_cfg  cfg;                  /*    24    32 */
        int                        val_size;             /*    56     4 */

        /* size: 64, cachelines: 1, members: 5 */
        /* padding: 4 */
};

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Update commit description to include pahole outputs before and after

 drivers/base/regmap/regmap-sdw-mbq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-sdw-mbq.c b/drivers/base/regmap/regmap-sdw-mbq.c
index 86644bbd07100..225c158d7f9d7 100644
--- a/drivers/base/regmap/regmap-sdw-mbq.c
+++ b/drivers/base/regmap/regmap-sdw-mbq.c
@@ -16,10 +16,11 @@
 struct regmap_mbq_context {
 	struct device *dev;
 
+	bool (*readable_reg)(struct device *dev, unsigned int reg);
+
 	struct regmap_sdw_mbq_cfg cfg;
 
 	int val_size;
-	bool (*readable_reg)(struct device *dev, unsigned int reg);
 };
 
 static int regmap_sdw_mbq_size(struct regmap_mbq_context *ctx, unsigned int reg)
-- 
2.47.3


