Return-Path: <linux-kernel+bounces-850980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7265BBD4DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A011A18A11B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A34C3101B6;
	Mon, 13 Oct 2025 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VjWOEHHS"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C30305043;
	Mon, 13 Oct 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370993; cv=fail; b=B7ZubLRukj5pOMvXwFGptuUiwIcc/RH2rzWRQtUj9zV9v403xIjE1K/lJPo7o+dAHxqz+WIfIOhUftrAK91U5hDfFil0+ygcRenFoaVNhhOzh5AB7uv7rLq2z8DaCo4cbMPL9QPp0AmFD23aM+GpqI7Nx0bFlzrlwjjg6iRhTCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370993; c=relaxed/simple;
	bh=287gRLlLLxoq5HKytJNtlYQQuZZOdeMwWylmZ4VDVCc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NR2AUiJw9+XEeaSYbo/nqXT2esNSAZWCZtW+k2gV3WQDDqYxGx8fLfoPKY+009U8zzwi0Q/pjEIR3uGFiP0DJQriFtXBou3PJMkfTvwHUwlsCQ4KSMXk7Y5Xt6sPXfRwXEel3UHrml5Eus11fx0yrmiNTPUxfmeMSOfthG7DKUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VjWOEHHS; arc=fail smtp.client-ip=52.101.46.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIxtVGmDk0/vyItTTaxCsHWgwO7wlJ50wgoCMJfb0Ze7CAsZwQZopl0CU9+p9LBV5DcLBSx5adsuxJS4b6iry73Luan8cnwkvmQfAFeSZthgdQocXU6WfDgq7A4TNzpa8vPQWlNo2JF18pKPR73wBEnVxvPY5nlkX0/pigljeU2+1moJ57FW1gzAsM1I2opLIH7d4m0sF5fk5EMLtPDSkxMR/K/6ftaV4IMUFOnd73bhy+sMenKEwbSZtHWVudN9DGliZT5a1XrJ7PIpYhCXqgLLzE9gwZaUiv/ZWGlIN4LO43kHPV7v+t4GPOVm3Zd8HyzINTHBkiqNP2SrzGFagA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n698uOu8F4fZOlp0xPOas48X4hpJcpVm1dGwN5XqoxU=;
 b=Drxndtet29puxf0XrXytHiOu6/A9sgw0YrquDLIuvv4vAqcDE3bjjj2IoXQ0bRVcZzh5SsGPHDzjmT0yyeXkpNwQthG6Sz/9/IbhhaSeDm/eGMfYlIRBqU0kW/3LWp231XyieIMsMdWw365EgcX61IyPG2lnCV5kHNmE4JegYhU+WbylOyQd4Zxu862LT0qk9+QhWE8ul+foQ9p5ZtNI5TqQfcbjapG9xrB25i0GMMk0X8Lst3PH+z8xgsGOCNcPcLO7+FN1LO3T2wzoaLP/MBjoWNdbKyUDNMRMGxXQ82TAyNOeGBrAvBfhe+Bme8qSDr6yTEVJYVz1JjG69IKXtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n698uOu8F4fZOlp0xPOas48X4hpJcpVm1dGwN5XqoxU=;
 b=VjWOEHHSud0dW2MW6Zsxiae6pn/OZE8gNtI0u6MqmgGKRbR0eL+B7LRwTTTlzZt6C7M3X/mfOUT2JKzgOErZKgdQSmNmu/bJxcTD5hTYTeBMNTuQW/1sojlGgY0co7+FIxKoNd5h6Sm4B7Zo7UZ41Q0TZHKFoJs0MyAdrFFvCpysAuIvWaE349cpMfihmiWQLZM7ibA7kN1oX7sB2gDDrgN7sKN6+TrVSi54bZFkpDa8gaIvJGF5cJqUaRTiq1TKXEnsrX+cweG+k++HYUZkJTgMWqkWj8kNo+Z5tJo3P43R2Yvkmb4aiFL2G4yyEjoJo9wneD4vHHHsDLhQhcbfRA==
Received: from PH7PR13CA0002.namprd13.prod.outlook.com (2603:10b6:510:174::6)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 15:56:27 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::75) by PH7PR13CA0002.outlook.office365.com
 (2603:10b6:510:174::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Mon,
 13 Oct 2025 15:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 15:56:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 13 Oct
 2025 08:56:10 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Oct
 2025 08:56:09 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 13
 Oct 2025 08:56:09 -0700
From: David Thompson <davthompson@nvidia.com>
To: <hansg@kernel.org>, <ilpo.jarvinen@linux.intel.com>, <vadimp@nvidia.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<davthompson@nvidia.com>, Shravan Kumar Ramani <shravankr@nvidia.com>
Subject: [PATCH v2] platform/mellanox: mlxbf-pmc: add sysfs_attr_init() to count_clock init
Date: Mon, 13 Oct 2025 15:56:05 +0000
Message-ID: <20251013155605.3589770-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2aebc8-5e9d-4b82-19d5-08de0a71110e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wwykGEbmFkKDK2KFl07H+ZUYoQT/X2JOVuxTEjBShHN2sbc8LN4rJAmqE/Kv?=
 =?us-ascii?Q?WTMZ6dbXlyOkELaScNebgC8FzlgDMw7nbwKms2Fq4trICAyHU4nwg9aPmqba?=
 =?us-ascii?Q?KEBX2C/wDIY8pXHB5SLAmHHozmfpWStR5ToU6LdkB7SLs0BmMMKNr5omYFTa?=
 =?us-ascii?Q?5V6Gr/8yUWqo0o73JpYvS59NxKIxqKyhPBvkV9Tk2ocpyQXITXDZ2pOGKDzi?=
 =?us-ascii?Q?OgDYcbaLvb1tu6esvsHJ/3DpW67++4dxY5PqyK7YsJHLTuAI63KZ3qCrVyE3?=
 =?us-ascii?Q?5lAu7RSznbo/ZtNxfdxqVNyR60PyipXFanLfFEUy9GAJ4z8WV36qpbqC0N1C?=
 =?us-ascii?Q?Fr+E9nTFTOdPQXeyNp0fJWpWMehBc9SLldjZvMQ3L3VVdb1QZnRTsO8faOIr?=
 =?us-ascii?Q?4YR5BrlaF6hMcwEo6ZHB5F1FVSQzM3Q1mENPY51vifYUtGlXxFJIJphRJRni?=
 =?us-ascii?Q?EIE+4TFoKEM0jde5JvRoaZhDBIyZvCuk3wmjyt7oZQCEOo15mrO8AhoPXRNR?=
 =?us-ascii?Q?OCnKUch7iVCtrsfknE+3fg2y15NZcr9KTnpqu5UhXPJFMyQXDxj5Tylzr5zq?=
 =?us-ascii?Q?2z1ssk6+2n2GQkFGviD3bXLGnS01ETrBAcxF4VYHQNmE6zjzY1MeWjr0uQs+?=
 =?us-ascii?Q?aIOyNwHIrqW8LQ0hXR2CaAzGkwOv9W6HPnLbLtQhROnrsNdHHdlsvevZBfJw?=
 =?us-ascii?Q?l27Z4b/+uKknuW5s5URVdnE59zElTGp3SiOWd1Uo6hsAX5/myWu+mJifXTHu?=
 =?us-ascii?Q?OTPqzUn3LOzmNNbV/jew1RtULbBOhk/YxWlEveqCfPQ4fizyDVb9D9TwFLWU?=
 =?us-ascii?Q?y6PO/bmIGT7ht4GEiod2qVkBk1EUc7Th9aZk1RLAelBmNkWhljKJ006CU5Gi?=
 =?us-ascii?Q?7OgY0oInQXqjlvpxaRwBOcO6+swW+k2eBBvqlOIzvqHem3S5LhsOKm5DRFB5?=
 =?us-ascii?Q?oEF9XbVR7InJWXI/8xUHsSohxbpV4/BnpUcI/GScG8GbOr3VM3FH+vJwMOPU?=
 =?us-ascii?Q?crRURGrPUR6hUNfxidvyk0UthtqYodVsvqU6OqYdO9uShpLBUTiP2aXWrKxS?=
 =?us-ascii?Q?MVVpHmjTE/pRSnRAtEhaks70tYdFIDnFoHJcBmDx+j/1RiZEFnd4DrSB28q8?=
 =?us-ascii?Q?cHgK57i1eMAMxZ+owJPJlmP+DbI/vy/WgStZwFLa2VzM5dZ9RK6VXs+OrxCA?=
 =?us-ascii?Q?qdGe5Mg+Sjq79a5V8puHAQYimigQvTjHUnfntCkdPVKdDTbL9RQalSGfAks5?=
 =?us-ascii?Q?Gp22hKv/t/IZBW0R44maGcM45nlM14XcNAgDPOFqX2zQ+GzhHjwjMaQxdqDG?=
 =?us-ascii?Q?6TJzVutzPTv3LFqiEbQNkDQ209EUhX96APnlxq2GiD1412btuFn70Ly3qOY8?=
 =?us-ascii?Q?WN8MZVwaCupe3PakhvsJL8JYr5JRnB3+I0L3N58QUeEnwYw+bjtnvyovn2Bw?=
 =?us-ascii?Q?ju13mpHz7C7o5CiCAIQP83sRCQ6jIv/cgfGyI/K8LQRPw9BPMByt1lX7pIyF?=
 =?us-ascii?Q?WqqA1hU52/n+BtVMaVFxGgyjLHJDiDPu1NBx+HBwpiCmCKEIqK1z8H1neRmI?=
 =?us-ascii?Q?GznrKXWkSlRtz2SQ4pQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 15:56:26.5489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2aebc8-5e9d-4b82-19d5-08de0a71110e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790

The lock-related debug logic (CONFIG_LOCK_STAT) in the kernel is noting
the following warning when the BlueField-3 SOC is booted:

[   10.231318] BUG: key ffff00008a3402a8 has not been registered!
[   10.237249] ------------[ cut here ]------------
[   10.241914] DEBUG_LOCKS_WARN_ON(1)
[   10.241927] WARNING: CPU: 4 PID: 592 at kernel/locking/lockdep.c:4801 lockdep_init_map_type+0x1d4/0x2a0
<snip>
[   10.385415] Call trace:
[   10.385417]  lockdep_init_map_type+0x1d4/0x2a0
[   10.385423]  __kernfs_create_file+0x84/0x140
[   10.385428]  sysfs_add_file_mode_ns+0xcc/0x1cc
[   10.385431]  internal_create_group+0x110/0x3d4
[   10.385434]  internal_create_groups.part.0+0x54/0xcc
[   10.385436]  sysfs_create_groups+0x24/0x40
[   10.385438]  device_add+0x6e8/0x93c
[   10.444559]  device_register+0x28/0x40
[   10.448299]  __hwmon_device_register+0x4b0/0x8a0
[   10.452907]  devm_hwmon_device_register_with_groups+0x7c/0xe0
[   10.458641]  mlxbf_pmc_probe+0x1e8/0x3e0 [mlxbf_pmc]
[   10.463598]  platform_probe+0x70/0x110

The mlxbf_pmc driver must call sysfs_attr_init() during the
initialization of the "count_clock" data structure to avoid
this warning.

Fixes: 5efc800975d9 ("platform/mellanox: mlxbf-pmc: Add support for monitoring cycle count")
Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
Signed-off-by: David Thompson <davthompson@nvidia.com>
---
v2: trimmed excess info from splat, fixed Tags section
---
 drivers/platform/mellanox/mlxbf-pmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 4776013e0764..16a2fd9fdd9b 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -2015,6 +2015,7 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_
 	if (pmc->block[blk_num].type == MLXBF_PMC_TYPE_CRSPACE) {
 		/* Program crspace counters to count clock cycles using "count_clock" sysfs */
 		attr = &pmc->block[blk_num].attr_count_clock;
+		sysfs_attr_init(&attr->dev_attr.attr);
 		attr->dev_attr.attr.mode = 0644;
 		attr->dev_attr.show = mlxbf_pmc_count_clock_show;
 		attr->dev_attr.store = mlxbf_pmc_count_clock_store;
-- 
2.43.0


