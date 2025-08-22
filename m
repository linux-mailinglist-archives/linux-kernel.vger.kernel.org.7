Return-Path: <linux-kernel+bounces-781126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07881B30DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D9B6029B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AC127B51C;
	Fri, 22 Aug 2025 04:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W6/JVrUp"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175DC271447
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755838668; cv=fail; b=CkCQCEYFjUJHKkRkhHa6DpKnGlTjjKgIwDbHbnIvFY04tnsPvPrHI/TiYCkCCbah0DhJo7DjPJlRkh9H/qDgq66JSAlQdanYWd9x1JIZXriqAwT5h9VkuQFZ5ooJ43Q/uX7BhzpXP982nGDZoGm3h6WtpFvN0VrmwldaKRhOEhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755838668; c=relaxed/simple;
	bh=Jbu+pUiqQ/ebWWx+QABNvNAGzxRZoWX2Jv+RueYSPnk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pl3TNg+f4oQva/JoyqRq2AN4t6DiIUnNGsWbN2B6IJ3ILdtTiYKqkyd7wm871Z7m016OLc1wAs0AKTnoW53CU8PYNVCoorY+unk32WT9REh4mljRRXHmcyWMlLN/UtkLXvEN4EohrY27K8g+ems1b+nfDAGOLi8lVZlzpCTQeZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W6/JVrUp; arc=fail smtp.client-ip=40.107.95.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgboJkImWtKDyDc4gdORfeLcjA4jiaN+43DVqZTcK3I4xXiOTyRdhMf4G1xVLYngEavrqp9mPIXB5qUwabpbKmeqA5v/4pzFbUTmgEXd6j8ZiDqEFnAEfS52bs0IEQeAcyvETH5hdEYKu78U67wJy1iq9vScVEfZuLC91WdEBTjRL56Te28rRmpOOFARPTwLAvarNsET9P4R47jkKcgoNXNVj4aDk02jlGiPhuchclF40KyvRB2qQmxCrn/fTa8Mi2pDxO3xTTXtQNCib15lTP8aZn3xILhVIhcu8PIg3eMKf7Cgr5yYZMjmvEyQnUZKG1dtTf7EZpM0HY1eQlkwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2OX6qUgR1h89VADHjRqRJlLslPfGf6J5uC23jUY6W4=;
 b=wqTAbREKEYUBg0NkDT6a/CzK3M+l6o7jYSeUE31l+SEjS13sj2SiuLIR+TkptqxUL40P68LTAMWoIbOchKuHlmNNA9rnM0fz8/Bp4kJiLqx3NZa+PJ336Ig6CaCzlVT5YY9xkQpVCXfeXX+vRs/Kul5ao5SK7X/YBrMyBqgXZovSb4csWhX3Mw+zRTwIgvZGfqfH/Db3JM03EzN6Jnq8+8TbV4Odce9yKn73DFaQaSFgRgPjMZCIm4ALS99gBlme8m0IwjqD9OXuUBUzwv2jT/9GQNTCKZN7KzkaxuNDxwezydQbpKSLNeV0bFzsaixMMzPOB1LyAdFxEba0vseWcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2OX6qUgR1h89VADHjRqRJlLslPfGf6J5uC23jUY6W4=;
 b=W6/JVrUpgM9H3JP0wuElI8sFuxikaLwjl0t1CYJjMhL82OadgC1+pbe3bdRW+GrgnXEjDhy1PsPumjETgeK+xyZArjh6bxGTkDQD+XHfiEWGa6/EuF9YQgM8tOtoegTvNp5LPSzo/zY8QC4Hvz2SOTJu02puuWSZsWoFaHriFmY=
Received: from BY3PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:39a::27)
 by IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 04:57:42 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::c9) by BY3PR03CA0022.outlook.office365.com
 (2603:10b6:a03:39a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Fri,
 22 Aug 2025 04:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 04:57:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 23:57:37 -0500
Received: from xhdharinit40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 21 Aug 2025 23:57:36 -0500
From: Harini T <harini.t@amd.com>
To: <jassisinghbrar@gmail.com>, <michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, Harini T <harini.t@amd.com>
Subject: [PATCH 0/3] mailbox: zynqmp-ipi: Improve resource cleanup on driver unbind
Date: Fri, 22 Aug 2025 10:27:29 +0530
Message-ID: <20250822045732.1068103-1-harini.t@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: harini.t@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 294dc233-44f4-4204-c25c-08dde1386cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8rkK4Nb3W15qjHf/wnr5VTrI8YYt5uu0SrEKSD/UcSpXqk1DAp1lBZE9+DWL?=
 =?us-ascii?Q?c+ViHOSZlmqq1sDP8L90Oco/OXkQtwMr0Z5rxryVReldtdcLAJI7igytjqdi?=
 =?us-ascii?Q?neb2CblGbu4YjfEVk5snE/Ep+l1GyOUTz22ATimzEFCIKoEhRpQI02Eaw0Q1?=
 =?us-ascii?Q?ivJc+emtUXAZEtg84Qd2KTNuOIAwAFniRsPlwe2HJNkH+o/yhqUlFI8A52in?=
 =?us-ascii?Q?R41BnqDjKrXPsyHr0yV+2DjwYOTaK/ZoUTqkoqzObjmXsKKErj2U5p0wvVt+?=
 =?us-ascii?Q?/TYEB89hkOGIkzUPz1b6J6dzhP2TsCbi0TIQhiFQF177KWn+89EalHULVZDU?=
 =?us-ascii?Q?94y/fawrHn15zEoBmo9FcyDB1pRZ7oJvI2sw8NjJ2DTEJPevR1bgtZZ/uw+L?=
 =?us-ascii?Q?DMYi9VcMDlyY/JgL/eHPbn/YsGe8zDeK2tr3fP0NsCR6NLySATNzLIC6DbgZ?=
 =?us-ascii?Q?DjI2Y8relJIY+zsu5lJ7neMLwa4Qp5l12+XCRVZ+rc17SjayxGeXCEmtY7WW?=
 =?us-ascii?Q?GBerv32zm4sienwgIBVEAe8HIggngaL9mE0SPp308+qFGjbOMLPBF++VNzKD?=
 =?us-ascii?Q?XPh8gujuNM0Ua7NwFvF1X8ybER/p2tObJL/rf+sTKg2Nu14ViF4fKdbfUGqO?=
 =?us-ascii?Q?6PY06bbEM1zrxKkjIfZkcBMfR2DLX03fxyOZgJjLFP0zkx6xnDoHLcc7DokY?=
 =?us-ascii?Q?6v7zTg4Z7kIEBTQ/HQS/p2ujRNDXtElg23ElcQjexwKUxmzYHMWISrBlu+dk?=
 =?us-ascii?Q?ABRoGiXXMsBVx7XRpVzcISQowOjOlOlDu0LpQlAe7HKBY74T2j8QXnyCrTjD?=
 =?us-ascii?Q?icuqXykDGPSVS/GyugxMqflCC5Z8G+z6ljHM+aAssdEbwL82My+O1wQmmPpo?=
 =?us-ascii?Q?wBBATc/vX2TE9E+oLirGLvZNk0rbWqEftPLrqyVdRIydMUY2rWE+3OJDNMxS?=
 =?us-ascii?Q?QJ6pcCHlYpwfy63+mxkoRylpon+1uR5k0+vVssr8ZYyTILELA1F7q4+WjMvZ?=
 =?us-ascii?Q?5EATTJe9+/pIHdEaHul/nJVgEVP84EysG4cRSuOhl7i5d4+s3Lwhq/r4dZhK?=
 =?us-ascii?Q?f13mD1orYVksL3cmslu0/UXzGYTd8cyRwlzEzqf8nMon+LfDRc6GJg7GVKXB?=
 =?us-ascii?Q?TxVuCiGrSp+zz34DRRSplXOQgXv6VOcbyYLOllN0VTYRuputwe1NwjiKQrSP?=
 =?us-ascii?Q?Q0jIVQDq9ip5AvUOanD83KOI9l9IUNURINPonmXUwQibvZRLCfLcYER/opWB?=
 =?us-ascii?Q?GGX4ZfSeAu+YFw8A8JGzuN+tYOikIBNUcvFUrXoJyjcvSb4C77QwZU0VFToT?=
 =?us-ascii?Q?Opb1ONJwUuw3LDGwuFNHaQyBmLAn0jLv4kfNPITWOKUw5ClLgWarxnMgmeFV?=
 =?us-ascii?Q?eCv+BoeAPip2kKnSqNudqNMkguc5B+nqiCzMrnLx8XW+bTQLc1n4ms68wUvI?=
 =?us-ascii?Q?dYhzeqpEEEabb/Ec6wMUohhFh3moKwHuiHm1wyawiuTpgbLksd4X9ibv10XW?=
 =?us-ascii?Q?WUQN6AEeCyOviyQGsqQtUwP19obgDhl3Dz+7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 04:57:41.3523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 294dc233-44f4-4204-c25c-08dde1386cb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301

1. Remove redundant mbox_controller_unregister() call, as
device_unregister() already handles controller cleanup.
2. Fix the mailbox cleanup loop to prevent out-of-bounds array access by
starting at num_mboxes-1.
3. Fix SGI resource cleanup by using an explicit irq_type field for
reliable SGI detection, replacing the unreliable IRQ number check.


Harini T (3):
  mailbox: zynqmp-ipi: Remove redundant mbox_controller_unregister()
    call
  mailbox: zynqmp-ipi: Fix out-of-bounds access in mailbox cleanup loop
  mailbox: zynqmp-ipi: Fix SGI cleanup on unbind

 drivers/mailbox/zynqmp-ipi-mailbox.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

-- 
2.43.0


