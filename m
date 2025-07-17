Return-Path: <linux-kernel+bounces-734797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6B3B08677
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1461A6038A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2EC221297;
	Thu, 17 Jul 2025 07:22:20 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023106.outbound.protection.outlook.com [52.101.127.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50DA21C167;
	Thu, 17 Jul 2025 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752736940; cv=fail; b=TooOzyHy0HiAWywiypbSRWQvxPJMIKRN1umzEXOH2CN7mSpHWP7hRCdAuwWT/mkwqmq+KASx66YKERk0ZpnutYQhY1fd2cUStBudAwGe218/RGRgeifT05mb5hDauu/nHK8tqzdXON6fDFcUpPghAIzV7wsqmPAHN6EtoDq4fDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752736940; c=relaxed/simple;
	bh=tMmOSqfNgOrSQtRP0F2jvK4f1idy+21oUbh12OoY8bs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNpkQIM5U7bhKr5zLA5Bi7CjWJCHHoTPGqK7uS3v60oJLHtX+D4ckyjZBHX2L9pGKnzV9zSx/JBIF8EUEky/dD4YDEHNTuDOJocK3s0T36Fe3rkNIH4sTigvS8Gxu1M/snchvJm5NBssRCs35wI1JBmvcKzPyreKqMZ8xaKeg9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WC2Wlas6ofxIiNOZ5syNirrpRdPqnlQFFNcO6vHetNyXU1rE2/gVTApGGV+Yowjdf7oNeiqjsNvXI6UoL1bBZunQFYxnJ5dDBhIdmiUZWwNB1KFP9KSV0FZcJQKKwzQMu3dGOI/SlS6FzUNnQF+wjcWpyWUeEQD5auyanlxWF1bjpQzdkDMGdpAo6WKsZQ3CN8w+e0F89hFbQgowHLLsspA4dq7SxeIhANy7/ci33eGxx0dci2DYHafAxOC8bQUAzkj0GAVbBvOw5/4apQiyu33SpDPKDgxIWQM7bAFJquoL3x6AEV7CBxZNleMQCsOdv/TDH8Rn85EZ43rXnTUu4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCs9a5p5Td23Mt561yilMwolyjDmNJQXYXB86a3+F0g=;
 b=fZ6xea3969gv7PFEY1YZNmMWehrH0IwgAQhBNaZb7k28mO+xwsBQ9io46q5PWUkFr582gRu+S3ndT5xKm4nVwZmJ4khP3sc+R2I5pGqEeYN0CkB/zW0oJ0okXQC+rdvVra6DRIJpxxYwj/g4eyg13/actBqL+YZENbN9DupwUsENfIFQPq8bwZjT7SHq/JNpMqdjjWyxKdm03uJNHkZd8XuJjY8fVBAXmDPCsZLvVjhj14wnkKl3fLcZvg4eLKHns1ab8LPzXZpoYQ3eYx6oRfy4MBo9qu8GhVxuGHmd6O/aFHFngV9Fv7C+SgrwND/50igxoNWU9GfjIvK4ZxdEmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0136.apcprd02.prod.outlook.com (2603:1096:4:188::16)
 by PS1PPF56C578557.apcprd06.prod.outlook.com (2603:1096:308::24f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Thu, 17 Jul
 2025 07:22:13 +0000
Received: from SG1PEPF000082E2.apcprd02.prod.outlook.com
 (2603:1096:4:188:cafe::fb) by SG2PR02CA0136.outlook.office365.com
 (2603:1096:4:188::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Thu,
 17 Jul 2025 07:22:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E2.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 07:22:13 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 301EE4160508;
	Thu, 17 Jul 2025 15:22:10 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	jassisinghbrar@gmail.com
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	maz@kernel.org,
	sudeep.holla@arm.com,
	kajetan.puchalski@arm.com,
	eballetb@redhat.com,
	Peter Chen <peter.chen@cixtech.com>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH v10 9/9] MAINTAINERS: Add CIX SoC maintainer entry
Date: Thu, 17 Jul 2025 15:22:09 +0800
Message-Id: <20250717072209.176807-10-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250717072209.176807-1-peter.chen@cixtech.com>
References: <20250717072209.176807-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E2:EE_|PS1PPF56C578557:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fa997800-a4de-4688-62d9-08ddc502a696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JWaSrvEapbjFrPzqjCRQl1a0WGRhudoJ3NiTsY5VuBEUoKJVPmPNcpOvkD23?=
 =?us-ascii?Q?eiesT8l2ZtxcmuPd7YZZzELmdJ69aEnpSgMddWKSEeX/xXW80fIHBc1x5pew?=
 =?us-ascii?Q?6nPcdJdfYMN5a3mseJewMpCdww3pWN8mWeRZjhSAJaNRsD6rKXWKF6ttJblc?=
 =?us-ascii?Q?AlcE6MpF7/HpO/B/bGYKsSPVP6sI1ySEsvyXin29Em7dvdYErYJCOZbl1YXE?=
 =?us-ascii?Q?qzlxhCkYpMz8QTXzwJIM1p4HrnJvO8eaHr8UKf5STbqq+knrDl7JRQ+FCAGv?=
 =?us-ascii?Q?05bj+YpqL1MvNr/wdIDXJJnWf1o0W9E9hiGtpkW5j1L6Z4QFgs8qwkztkIAx?=
 =?us-ascii?Q?+2D89bKMJE+OGeAKd2apoktFpN9GfwgdVME/j3rZ/qAVX9sJ8xlL6MguVm8R?=
 =?us-ascii?Q?vitx5xd5mngA7SNHlZxQ7gyMHMsx5uucIMilTg3doLf58OJMfGKzEEyngwTy?=
 =?us-ascii?Q?V/zxe4b4AuTMuhEOLF09GcvHHCC+uD1rCKf82mMJ0hpUehpocGKufgvfc5tA?=
 =?us-ascii?Q?6zoNTg8ja4mMPHwqaz/NBRNPDYPlRlRqVaeBEWMuUQ86qCvZ92WoyJVaFbFP?=
 =?us-ascii?Q?Z6Hq1ISBPvmHjukd+LdFh1d8GXDGp07wFR6Gv2SCFcXMm7s3aMx5/LEH4FHz?=
 =?us-ascii?Q?vlm429XwYQ8uXmiw3O9jJI2ZJw+l1yjzneQ6O8NKUeb9IwaE9/wSX1tUqp5b?=
 =?us-ascii?Q?35pSIhL3JVd9vqlCiYcrPSQ+WD2UK0Wci5XWaw3PFlA2PDNQ0SpMn9R4wvXb?=
 =?us-ascii?Q?39MfjEwWIDn1FF5atBiA3iQJOvwWSPDOD98CE8w4yY0fG6J4Gm95QGCH/j3D?=
 =?us-ascii?Q?X5GNeDZ7CiI0qkbUF9UjOWBX+/C1QSIveR5thukR9GV1OYFun/PZIUUAJCGe?=
 =?us-ascii?Q?siIayOKNJsrRhV2sEywL3AuUXgFS/s0BQhaB5VU4lyT/3PxF2s3MG8BsRlnh?=
 =?us-ascii?Q?oQxEg93pGIHNq7iEe32G1DwXO93h8jvl8SZMyX/+hjerfDgqSTDOCYyzoG4F?=
 =?us-ascii?Q?2N7MylKG8a3ek3UcI5cLATyDaTCaUmCkP2jrbQHi0myu+/pKLcKcRK+N0Fug?=
 =?us-ascii?Q?NPnb8MEPn4KCEc6QRgfyvyAkrSwjw4wsGJQg9FWr4eaP4zmEk4izDNTKVe0Q?=
 =?us-ascii?Q?pa0vPJ4SpzkJUKuOldCIBPs7VWBCLg7sPNiDrNtT8dVW5n4b6A9rTjjDJbIT?=
 =?us-ascii?Q?YJUNrWnjCQ3Ku1I+blSd9jxte+U00rTjVvPgvKqI1YD1XLoPvg382AHWop7v?=
 =?us-ascii?Q?VxqY5iyoLEN5/vl+0yypjsOawc6y7SqBUZItviXECYImy6pWljt2qzpFgfb0?=
 =?us-ascii?Q?ORbnR7vGQGI5MHZ9PNYmqQ0S5/5LwZN6Iykoa3CwzcjzcN5OpHKugiLVx2/e?=
 =?us-ascii?Q?U2zaRvZ2LcFQKfs1K3Xv7Kd8tam+NLPTtLmYR6LQcnvb2twep37X40gg67Vu?=
 =?us-ascii?Q?XjEqGdgF2awig9gUuq7m1a6Svx+Lh0oZHPT/OIpkyC4tUDa8z8zXall+4VCy?=
 =?us-ascii?Q?FC6e/RAS20QvXov+RlQMtyNENIL8wH6b2J5n?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 07:22:13.0011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa997800-a4de-4688-62d9-08ddc502a696
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF56C578557

Using this entry as the maintainers information for CIX SoCs.

Acked-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
Changes for v9:
- Add mailbox driver information

 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..7f8bee29bb8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2473,6 +2473,19 @@ F:	arch/arm/boot/compressed/misc-ep93xx.h
 F:	arch/arm/mach-ep93xx/
 F:	drivers/iio/adc/ep93xx_adc.c
 
+ARM/CIX SOC SUPPORT
+M:	Peter Chen <peter.chen@cixtech.com>
+M:	Fugang Duan <fugang.duan@cixtech.com>
+R:	CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/cix.git
+F:	Documentation/devicetree/bindings/arm/cix.yaml
+F:	Documentation/devicetree/bindings/mailbox/cix,sky1-mbox.yaml
+F:	arch/arm64/boot/dts/cix/
+F:	drivers/mailbox/cix-mailbox.c
+K:	\bcix\b
+
 ARM/CLKDEV SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.25.1


