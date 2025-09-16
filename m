Return-Path: <linux-kernel+bounces-819356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B94B59F36
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8197463A81
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA24F261B65;
	Tue, 16 Sep 2025 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MVMX5ZIc"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DA126FA4E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758043566; cv=fail; b=O/fntdXzBDrWqtJJFho6oCsPedtl1P02VkkGAycEj9djas/h/5qk1Fddaf2uh/6sk5hmlOwZ0ipFRp6aaFt2eLww6DmVc0NQ6wt226x/XOLjfARZFtWSO4oZjRYNCIZlZ7gE/H7v3CiIoCViVc/Wx8bBOdYhkWg7qw8wcsfD8Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758043566; c=relaxed/simple;
	bh=DoEUUH7dciznLEMtie3u0IvbbAFtCAa8KICmd8su40g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kW2ePAEZyc5hjNZjBD65CrzxEDB73uqV7PvyZWZooIxcdwJbWVhXMM4QuDaZOe0QXhQa28k/iGZ3Xd22Dthpa21oRPli0nWqTrMPZsiWYVhAWqynSHTNrl/ODmQej4dqdrDE37U50c8qBJ/VVzIpqEv9A1BsZDHF6No50wxWOmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MVMX5ZIc; arc=fail smtp.client-ip=40.93.194.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pj9lAxHoOjYkVtI+1HngqJX7f1o454BcKOuPUrKRnfdHpvQAyAbqEBSasKqufZ/hKjqkBhUP/Ezw+j/OdUkr+2PKWpg0vvf0L3WLJ4pBYVJoE9o6UqhnLTpP7qUMptAK/8nIH2FopShETe7R/+Lu1MJur9WCR8Tk5qmnOI3k10bGGkIZATRbE0rcG1zEXCB7ORzlK1j4BgD4I/ldaqr03KUDuWYgIHTr2Oq36Z3xHatrLfaDQIS6jR5sBhzZ5sWagduKEThlelbd3rcuDXWlcwTXAACH9p6J3VaT3Y8K1hxrtFMTrAMkQrkdh/JFSvHT0dP1xIrjtUMj5WlcIPjffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4JbvzTvjdWRScFqzBihzW97IwrkUYdHD0Qu/N/2kxQ=;
 b=Bju44PRuNlBO5Bt6H3/arEjy2dsOBktUrZiApnQtUI+cCdXkQd64GKPcpMS+VHKIlr0n6o9+6+/BThIOHebzZ5Mv+N9BcDiFLDZnZnkxBedj96inzjPtzwWNuZ7k1C3Z7w/1Oik0sqYTyl/QjmHAo+pnms07ufOL0LNY8gLk0LgOZDze3ZIzCcLQYGQMPHCWwFlqVe0HM6Z+RGcK0byTv6B/ghVY4Y4uQs4YNXVw66rCfflHbvJLNWQPZLJ7DMJ1MJFHxFbP62XSNBBcauEhKnGJ/UHGyh2PufFVImPy/am7MM0BMeTksG+jKqIjlczc15plIHHPnKci5BjYZsdKiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4JbvzTvjdWRScFqzBihzW97IwrkUYdHD0Qu/N/2kxQ=;
 b=MVMX5ZIcIDa1MBPUcOxiP6bbbUBy3ieT8yNNgTIkzJr1cRzdSkihy3KEaXuIm5AserPYAPlfV27dHRZ/cnXMzQmiLxJ5Qj0xSmYU5rVwbK8l+k8pXQ2+29ql6x5UWAbhCTD8dj0L0IGumBf5NvIoJluI8AUxLUuL5KUW4Fw5yYQ=
Received: from BL1PR13CA0424.namprd13.prod.outlook.com (2603:10b6:208:2c3::9)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 17:25:58 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::57) by BL1PR13CA0424.outlook.office365.com
 (2603:10b6:208:2c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.11 via Frontend Transport; Tue,
 16 Sep 2025 17:25:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 17:25:56 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 10:25:55 -0700
From: Babu Moger <babu.moger@amd.com>
To: <babu.moger@amd.com>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <bp@alien8.de>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/resctrl: Fix counter auto-assignment on mkdir with mbm_event enabled
Date: Tue, 16 Sep 2025 12:25:49 -0500
Message-ID: <9788ef37c17a9559a08019b694d2a47b507aa4ac.1758043391.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a192ae4-3b82-43e9-f36c-08ddf54618b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1/SbcY60hQb/H40mq/fppWUkHxrk4WWCKPSrv2rp4VTZ3ICVL7XYpvhUANR1?=
 =?us-ascii?Q?+AqAdhu41gAmkl8OPcgmguRcCnVeNWfR/FexN7R+/RtE1k53xk98QIG/Fxbv?=
 =?us-ascii?Q?Yr71ijW5B0zUs4U/mAeGn9Shz1KhybmBb8kfe2smjRnqmCQ234mlzXcliGKg?=
 =?us-ascii?Q?/abp/a1tFfak/uUk40sNoTbpSEM2BLlkbJq9W5lfROhKhBg7krSJkp/c0cLN?=
 =?us-ascii?Q?VJn+0imPEwXPWIC+ChE6WWl3/NcCD2ceevH09lDAbf8Az3KELi6ueFGPN+Eh?=
 =?us-ascii?Q?gX49KsuUqblbSrj/8y9METE0TflR8z13EqzPnR3bH9EkTHHfKX0ZyxbvZP79?=
 =?us-ascii?Q?2S2S16nnwFRNX+NqqXhmHNBzLUtzdqlYobzk1xYyJ7k1kTgc7B319vDtLVKo?=
 =?us-ascii?Q?mqQC8yumFDuyJaBB6Ab9r1DlSkhJj4xOQ/VTkuumXJtE7e6+q6Hl4Pr4I6qf?=
 =?us-ascii?Q?oVpt2mdk8pGW1nbwb3rxPdynBLrVo3iUNcnuslB3knqkWUbMPBFz9zXfkQ67?=
 =?us-ascii?Q?5NR2nVMlgkydGbOpsxBYA7wS3Zj1Xxjot1H2/KRW9P3smfGPbpfcUnODdK6G?=
 =?us-ascii?Q?JKmYn0LbfYpe2z88QA/1hpJg3LmrL4lMaXBtFUJi7TYGqquxays/nV9rY1h1?=
 =?us-ascii?Q?EzwZq7ghfZ3v58DogjHDPoAYjcAc2OJbZyujMs1IbbPqsq9BG0ftYA4dGgl0?=
 =?us-ascii?Q?6B9Eh1IiOv6oNnP4PITAzgHCqwUbL1gfl2ZWLfZ6tJKB9kkzPvTTu5aMGrvA?=
 =?us-ascii?Q?URTGQUdP/WskkrmakZit6uSaUgioBc5X1p5L/vWXzvO6WJJ6QxmsfVyrOkNk?=
 =?us-ascii?Q?l9jOyNqLjWMV42HpvChF98qa/f2lTLiXiYm5wDEQtA9QNqf4KPZQpQ6Ry7K4?=
 =?us-ascii?Q?v9zL+o28TY9mxSxRU1h/hwxJaP+xyFw0mhWeRv96PCjr9rEGh7crpTPZ0IY6?=
 =?us-ascii?Q?0PoWpA6jctm2FaAAbXP9ybMqVRObbmjyvMnuGheSLDdMwXU3w8DxOW/Ni5Bt?=
 =?us-ascii?Q?0s7ZqSFDhzFDmNtpSAer60slCeswrdRn3dAmEZAMhf2y6pbLI78aHfGOMOpK?=
 =?us-ascii?Q?pGlWuBK153lYYk36Zu1V03VzzVUnenbICu0Pa3RtuznrSgknvnVnBTUCRS7p?=
 =?us-ascii?Q?fJQxPR8/i00bhQb4hXuCO2sihdWCJ0ntPoyxsgtP6cmQSU2ZkT6IYvOPQtDi?=
 =?us-ascii?Q?BmP0EcyaxWy2M6+fCJr7G7opabvetOrMIFxK8LMNLPKytj1/fC1XMrQYzx92?=
 =?us-ascii?Q?wV0CQQfg38ddzkZ8d3MJPO/rqfQxfTGOZg7uG1Ai03WvfNcQrf/4loTkokHn?=
 =?us-ascii?Q?cqlOsQTAsSMeRjvsH2JDtRH80vScDHTxuU8lhAOM5v5S6ko3+KrPFRsvv2Sv?=
 =?us-ascii?Q?w52yJhqgTpyFLUHKnimbCl290yimNbuvn64xYsIkj2eRakKKOItqhFVTjYvW?=
 =?us-ascii?Q?nu0WbF0+yVi4v1T2Vc/KUGrcAFo1c5HH8Toiif46T0l3Eup8x2uN9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 17:25:56.7216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a192ae4-3b82-43e9-f36c-08ddf54618b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228

Found that the automatic counter assignment is not working as expected when
"mbm_event" is enabled. Counters are being assigned regardless of whether
mbm_assign_on_mkdir is enabled or not.

The logic was mistakenly placed in rdtgroup_unassign_cntrs() instead of
rdtgroup_assign_cntrs().

Fix it by moving the code snippet to rdtgroup_assign_cntrs().

Fixes: ef712fe97ec57 ("fs/resctrl: Auto assign counters on mkdir and clean up on group removal")
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
This issue was introduced during the rebase from v17 [1] to v18 [2].
https://lore.kernel.org/lkml/1ee0f8674f0ab48bdbc3e05c11b7df30d6fa53fe.1755224735.git.babu.moger@amd.com/ # [1]
https://lore.kernel.org/lkml/db4240e3d815c3f193402b36723995427ec358b0.1757108044.git.babu.moger@amd.com/ # [2]
---
 fs/resctrl/monitor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 50c24460d992..4076336fbba6 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1200,7 +1200,8 @@ void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 
-	if (!r->mon_capable || !resctrl_arch_mbm_cntr_assign_enabled(r))
+	if (!r->mon_capable || !resctrl_arch_mbm_cntr_assign_enabled(r) ||
+	    !r->mon.mbm_assign_on_mkdir)
 		return;
 
 	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
@@ -1258,8 +1259,7 @@ void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 
-	if (!r->mon_capable || !resctrl_arch_mbm_cntr_assign_enabled(r) ||
-	    !r->mon.mbm_assign_on_mkdir)
+	if (!r->mon_capable || !resctrl_arch_mbm_cntr_assign_enabled(r))
 		return;
 
 	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
-- 
2.34.1


