Return-Path: <linux-kernel+bounces-772954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4530DB299C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C16F24E14CE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28684275869;
	Mon, 18 Aug 2025 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2zH+oSYE"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E978E273D84
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755498797; cv=fail; b=NUNPFV5QHWDm2CodxU1P3ac3oCi7ghgatYGRO801Vu9Iu1GzJb355FpJtst5/QI+JRk6HwoAm2/mtglcBj0nSv2Fe+sIQIGzT47plhCxXwvUSLy4uOUtd/uk3pEA31AyGyCeq5e2I7UftL82e78sPUfi+80626rEYVkMk9h7MEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755498797; c=relaxed/simple;
	bh=7Pg2UrnKMkJJeynysk9dKqKMTP1S7w7ixoER9YF4s9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iS8DDFiHQWmZ3p9Zblh5GHQjJiEwMyxby0EHSYl0+TxGkjuyxvbaczxUwy1WEEuNVBUswqBU+IB66Gilg2Gu5U4SFB658aAYgMvLV8cBmH3CE0NVHitS2V02+P2BX5pdsUKnyGmT4X7KruTywe2eGj6TVpNjnj9tiOBaSlmpD9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2zH+oSYE; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Un/0U/HoQoRHIys0buoFfMzFRdWeUkfiNJt29L+FdJ0KPP6ET5naAcnYlK3utH/qWC5DsB8lx3ccXI4ptksEMA6ZUeo29xBmtJoKVSZHhKk9Fue/u+f8RvdHNMiRkZOCMm2zcCdtGpCbvl4Owq/fdZ3/R+CDOvK+8aXjgYF5lX7ddQhk9khpbNFWBqxcgkGzhBUTlEiJSPKH3H/AgvmBAItyL+OzbojyacaXbYTLTrHwjLjPV8VDYqDKifE6PgwpKq0lYTGpVf+SiAvCl6Qi8RauAArqaJqHJrMbqVWzpRosqZtUAKNDzHCCYCCvHrOk5jcHFlwjoQxW85lNaPEvlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJcLsiGdUghDt9b2X8u1jAQMtu92la/qGx061U8uDtE=;
 b=HjIRjfWOcjhOrqdH9HWCU4co+DGxwLuDX/LQKRFpVKohJIxSQLVjj4m0uwBNfbahfTy1N5Thl4KkizZLAybMGlRjXfW9JQmNgImLDfZaBY/6iD+k4S16pEKmcZXGtZzVeUeuDbefhQjv1e/gXZACwqNUDOCBuvIWY9IF4QyAohtSOZwbBhyX0ZAHrJu2qoHgxIs6i8BwUi89LCWuy57HEpfxjUCJNStM9hQZCSCqgV02Za1YjE4wn2Cypm18ASoACtCtTEMXdbrhIoKPQUdCJiWd5SWyLW65qcb4vQa6AKMwerUVQLwZUseHyHxguFGfbWoA802sj6SIF6I9ID1hVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJcLsiGdUghDt9b2X8u1jAQMtu92la/qGx061U8uDtE=;
 b=2zH+oSYE+tqIwa47aE+FhTf4vlCV4pC3MAMdFHImWJRmO3FJ/MeD+pgWrkKm3L+L1x55ZIbTwJ6cniWOavQkaEonboOO8TEOvxRT0Wm+PHKpZgCwUmN5r6vpSh1Rzy1Z+Xv21r6UCsHYYTQI0LsSMwZuw9VHd/nCJjPzVo3EXvQ=
Received: from MW4PR03CA0064.namprd03.prod.outlook.com (2603:10b6:303:b6::9)
 by CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 06:33:11 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:303:b6:cafe::37) by MW4PR03CA0064.outlook.office365.com
 (2603:10b6:303:b6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.19 via Frontend Transport; Mon,
 18 Aug 2025 06:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 06:33:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 01:33:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 01:33:06 -0500
Received: from xhdnipung41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Aug 2025 01:33:02 -0500
From: Nipun Gupta <nipun.gupta@amd.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <nikhil.agarwal@amd.com>
CC: <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, <robin.murphy@arm.com>, <krzk@kernel.org>,
	<tglx@linutronix.de>, <maz@kernel.org>, <linux@weissschuh.net>,
	<chenqiuji666@gmail.com>, <peterz@infradead.org>, <robh@kernel.org>,
	<abhijit.gangurde@amd.com>, <nathan@kernel.org>, Nipun Gupta
	<nipun.gupta@amd.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] vfio/cdx: update driver to build without CONFIG_GENERIC_MSI_IRQ
Date: Mon, 18 Aug 2025 12:02:44 +0530
Message-ID: <20250818063244.1242634-2-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818063244.1242634-1-nipun.gupta@amd.com>
References: <20250818063244.1242634-1-nipun.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3c3b76-6c7e-4158-c0ca-08ddde2119ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lh6THWuzwJyjGE6Fkn+8Vs9BFarePlZFVsSjcwITIMD62qfFhd/WtJvH3wGA?=
 =?us-ascii?Q?C7lL1Z8DiC9PKpdhhe+mNC9aBchh+PVTcYrsvfloKYDGDdcPU2rdHHdFyaiU?=
 =?us-ascii?Q?ZvSKI45Soq5GQ05zqD+QKPzHnauMPJA2+OHuar47ealli1OLSPTAar1QhdfZ?=
 =?us-ascii?Q?Ycp7+IymD4hRgqF3O+E9jYQibRzrnIs1oKucJdgADXG6CBqKN8V4v/Fijq9Y?=
 =?us-ascii?Q?xcANeUHe3p6XpKNtY9Ho/CqWj6Eby1sfet/JE2FeF8kEapXR3kK3ychsLHFX?=
 =?us-ascii?Q?e4eMXdeXRZw2BBUh+7D5buAxVwwxgNGUg5O4EXSzlp11yIMpG+oJt0mgfCC1?=
 =?us-ascii?Q?kZCqpSVlVllw9LhdfWTXA+dAdZpY1BSOp7PgxpM7TxB+gPNcQg1ZAeZeUJR6?=
 =?us-ascii?Q?Vw77tgrFguRuRfzbGzXAO1SlWgIofkiV3sZaTXLlCCTnregkuZFzclc/iGEu?=
 =?us-ascii?Q?O+Y/pdZM2utWQ53mGtyYmn4rqv1BryE5FB9VRj8sEakuW88xavtnwlXqA8Uk?=
 =?us-ascii?Q?q5vg9QEleEWvlgKjEYf62gdQNInnpYfOF+WpH1yrBye4OiHiSBqCmUUzT5UY?=
 =?us-ascii?Q?EwXoWxxs5fVWzSdkA2zpNnVid4iI3tmYxrYOFyvrmGKWccPd3VHRHh4O0ITp?=
 =?us-ascii?Q?lhAGhOVI0cgOLQioMJQsxKy9fU0S8sB925JLmGB8qla1FxL8BFANLwp0D6+U?=
 =?us-ascii?Q?nfsl22X8tNuIevMpylxlehv9y1iA9IJSk0s58E/nofcPEkuaQN5mXrLllC3u?=
 =?us-ascii?Q?KAef8d4tZUe4CHQk+0vuaDtABuksPp7ukNVM85WUZfXTdsD2347rCiBmYFsS?=
 =?us-ascii?Q?9zCv+IrqmNAxZQrigCZ3ZP6jKYJHgbBv2w4joVJi2XccHzEvwAZtoBmFh0+u?=
 =?us-ascii?Q?FwS5e+kWBLiMju2uL0XKjZ78ZKxMpABN68NII3gx2wBRCCZZgjsRQYdzxCl1?=
 =?us-ascii?Q?+OWPfjPSxXuegtP5wVcP9gLwRec+hfeeNuBqxGJh7Zj9ysv5fIz3i6uZ+Ns9?=
 =?us-ascii?Q?UMxIvz/aFPDt8JRdQIjTMeYtbDlDjJX6KIeqraRyAAopfXjtwCqe9DrJL28t?=
 =?us-ascii?Q?vsMmv/XbqoN5Ct5r3NJ10m9QXGNMifHlMlAm8OROrDhp1+UxLYClsuCKK9En?=
 =?us-ascii?Q?zr7mN9pokgWmWxzucRzflPsREADADYv2hKvAl7UOszfaE0HGku2DpIU8udau?=
 =?us-ascii?Q?xJXpnLj3uy1Un5XFvUpoZwEpKU7ffnV8PL6NlI2EDQkKCghDJ+s1guRA3V8V?=
 =?us-ascii?Q?Dg9ajzPNtT2OqslNdlG8Sl9Q7mI9ogI2VFLEcM5QpNI+M4EBeRGS8CTG2IPd?=
 =?us-ascii?Q?IZ6BnGpps89uP9Uh/pmBwGRroLYiDy1X5yc2oll5ZIiwqgwmoorVrLGlga6g?=
 =?us-ascii?Q?KbSgvbuR3JpFqpDKeUhiOzdUsSJyUwP7WSO+5e9MG4kbDwOfImwxdnuqRLiR?=
 =?us-ascii?Q?sEnb9901VsvJn2OS54NJ3fmCxvOWCrcpl6nzKBCPrgbS/8LcSnB2OxteCjhm?=
 =?us-ascii?Q?/rdD3j9HzgcX/J1xfzCodjYk91hqr7cG8x4CiVu0VHdPoeqWc82LFE3hnQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:33:10.5434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3c3b76-6c7e-4158-c0ca-08ddde2119ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491

Define dummy MSI related APIs in VFIO CDX driver to build the
driver without enabling CONFIG_GENERIC_MSI_IRQ flag.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508070308.opy5dIFX-lkp@intel.com/
Reviewed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
---
 drivers/vfio/cdx/Makefile  |  6 +++++-
 drivers/vfio/cdx/private.h | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/cdx/Makefile b/drivers/vfio/cdx/Makefile
index df92b320122a..7dc7bdcdcaa9 100644
--- a/drivers/vfio/cdx/Makefile
+++ b/drivers/vfio/cdx/Makefile
@@ -5,4 +5,8 @@
 
 obj-$(CONFIG_VFIO_CDX) += vfio-cdx.o
 
-vfio-cdx-objs := main.o intr.o
+vfio-cdx-objs := main.o
+
+ifdef CONFIG_GENERIC_MSI_IRQ
+obj-$(CONFIG_VFIO_CDX) += intr.o
+endif
diff --git a/drivers/vfio/cdx/private.h b/drivers/vfio/cdx/private.h
index dc56729b3114..0482a1516439 100644
--- a/drivers/vfio/cdx/private.h
+++ b/drivers/vfio/cdx/private.h
@@ -38,11 +38,25 @@ struct vfio_cdx_device {
 	u8			config_msi;
 };
 
+#ifdef CONFIG_GENERIC_MSI_IRQ
 int vfio_cdx_set_irqs_ioctl(struct vfio_cdx_device *vdev,
 			    u32 flags, unsigned int index,
 			    unsigned int start, unsigned int count,
 			    void *data);
 
 void vfio_cdx_irqs_cleanup(struct vfio_cdx_device *vdev);
+#else
+static int vfio_cdx_set_irqs_ioctl(struct vfio_cdx_device *vdev,
+				   u32 flags, unsigned int index,
+				   unsigned int start, unsigned int count,
+				   void *data)
+{
+	return 0;
+}
+
+static void vfio_cdx_irqs_cleanup(struct vfio_cdx_device *vdev)
+{
+}
+#endif
 
 #endif /* VFIO_CDX_PRIVATE_H */
-- 
2.34.1


