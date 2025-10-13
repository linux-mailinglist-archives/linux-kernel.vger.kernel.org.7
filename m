Return-Path: <linux-kernel+bounces-850604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE06BD3456
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4160C4F2713
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352113081D5;
	Mon, 13 Oct 2025 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qkS6R6r2"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922D63081C3;
	Mon, 13 Oct 2025 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363050; cv=fail; b=TN6gV/cUPazwoRSvxt64TPwrTB66VSjCfavReC2tuLFnSy3Hzmnqw6XcrqWn9CSg4P1h6CoCOf+SByBxFJhgRhE3lcpJnjHdldIdOfzuJpAa8Be/jeC9qQQ/SPz3ZgKihI8Y57Mm7r+eWyhV+FWSCDwGG3GPbuk87f4a+cF1WjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363050; c=relaxed/simple;
	bh=kHV+S8iNVbVNqw5BsUkByllEVya1N909qOiaMBzfPqo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HAtLFKl2RYA6LMDavG/XfwPtx4SDaeUonp8A+8NYvmnK2L2yiXZ4FMbbwUYOvZ8XLGP7wyT2SvWBDfy6vEHe4IDIYnNt1MqSbNfzHHuDVZOZiRYAoL/wL3ipVRQZCzPa/VVnjfKWsutk0bupU8W8CHCpP/hQvc4ODAg2V0MktlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qkS6R6r2; arc=fail smtp.client-ip=52.101.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMDhAP8H+0OE8oVwyo4Gn6T8B9NB0gH3eSA9vHTd/8ieMeqkW/o8x/Fdm1XDj9WyBw0kB+pF4VBZk+KXrNhl/0vkWWYoBwHW3/qy8QC/GCCXvJAEE2FDAtRjEf4BOUe3KEBJuFhiAmN9epsRa7h+Wv96sU4wXBIRqSqGUduRCmPjDOYIezQQ9ob83lc1C+L+l5vOPNZOJUmsR/E2uxoa5glO6rfSoxCJVIRDtwzuW2N6J+fWIQ2tXDnEbb0kwyDOWy2jaHKJPkSfns6wv0UnYLGQWBtIK9+OaQ4njBaKTfKW40bRGFFxnrDvElpD0Wl5PE4GI/WcBRNALzcaT4GYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81H+J1Lo9vJsET54LkuJGkZgwqoM0yO2mKtCBGVJJGY=;
 b=YEvtTJc6YnO8S1mRWWek6XfeFORWY8qxQu5SQ+PqR+2rTuWI+EXityMA9QMo8YrXgGUdcP5i5NkyNZ5kSzhpMaZnWmiTytY7c2W6NvHLTVifWhyOG9NwYYsJehORneQO/j6UW1Iyj4sOuZj308Z3ThGZK+g1TH5rM3VDrwWbR8EPVUjyVMF1qkqKi3K4IIuyk3nIdgwvzukUlKqKMbvXrgLim7+sa0X0kZwrcbHzLobc/dC0o6/nbQNI6fCx0v6IrN0lwHkJ4Mo6LpOwfguzr9HC/SuJDP7bibcnGPjdHeX6tGMGLmwHiQsK1fUTA6D4HLNiWUTpLbDs/4b6oAqG1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81H+J1Lo9vJsET54LkuJGkZgwqoM0yO2mKtCBGVJJGY=;
 b=qkS6R6r26K7uDbHJReUMYmZsf8eWLNH382KIhn8/M6zNOmz1gh8yeBJD+q0pM+BM6s+YF3Q+YstwAUzXXpW/zWQqQFvFJTRPZV4NBLhLkHiAJAzDaSLmREWavqj/wjPb/9lxAFFn1paLeb4LWGgtrGZom3AAo5S4cgXIJJxNHGWOLhEiHLGWwf+jd8D2laXJMHwjR59ognKga0Yqk3o+OBoO1XSaVN2d0c0YGb5IBg7AnMnAYK0jgcnf3BhE4QGoGo9MGcs6Xdj+zasbe9MfjQF1ycXVdyz+K8Cp5647yAShGM7Hh1LSpSyhuDF5u5hO/IOjjOVH7CKIkaN+TFmnxQ==
Received: from BN0PR08CA0026.namprd08.prod.outlook.com (2603:10b6:408:142::28)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 13:44:04 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:142:cafe::a4) by BN0PR08CA0026.outlook.office365.com
 (2603:10b6:408:142::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 13:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Mon, 13 Oct 2025 13:44:04 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 13 Oct
 2025 06:43:47 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Oct
 2025 06:43:46 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 13
 Oct 2025 06:43:45 -0700
From: David Thompson <davthompson@nvidia.com>
To: <hansg@kernel.org>, <ilpo.jarvinen@linux.intel.com>, <vadimp@nvidia.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<davthompson@nvidia.com>, Shravan Kumar Ramani <shravankr@nvidia.com>
Subject: [PATCH] platform/mellanox: mlxbf-pmc: add sysfs_attr_init() to count_clock init
Date: Mon, 13 Oct 2025 09:43:35 -0400
Message-ID: <20251013134335.26191-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 247fe9bb-c429-49dc-49d5-08de0a5e931c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?im+PNC+qv5Em55vwxqv4cOMoUNpvWP6vmWQAMpEVBA+LVhPFD17xuCCAaqtz?=
 =?us-ascii?Q?njKQ2x8RPkgJEfWnZCyedmGJ+coBJWF7UHRPme2jFgYjv+wwEt8i+7G8d2y5?=
 =?us-ascii?Q?iC+NL/wZyYlE6nV6zdyxzm13pPtXUYrc2xbmVQPAR48FpD04KMHJc0eASj4I?=
 =?us-ascii?Q?XirG22Gfb5tazHisKjhpBqog6njCV+sOrKZzeQEpMsKqTRFJMIZ7URFrUMS9?=
 =?us-ascii?Q?kZz7TSV4vOEmNxYrtNYyt0pHTdVLR7Yyp/2TOaI5k2kfDPWxFPkUsgxT2lLZ?=
 =?us-ascii?Q?Hn3IhWGVOr0R9cdxp4MZy8JQt5P9SolkGiadVqhQOe7js1mYnLNIbk1+wTNs?=
 =?us-ascii?Q?Wielinp/v1+RX/YncIcefdg6vMyQVRMT1/jcprJJUFvs3D9463AxwOb0oWRl?=
 =?us-ascii?Q?SpvLFhYMkfXz+KPu7/Zmu3IFD1CbshFi2HZ7j+q5hHfnjSkqL4OmgFmy9m2s?=
 =?us-ascii?Q?4OQG6frTWptgKfLfmMl5NlNsNC0dvwZ9ZVNYCvdrg3uH64sof0fAYsnD2Z/c?=
 =?us-ascii?Q?t4iOERbbfX73QVvaGjwIi4OLpZt9SjSygdJnX2alvtsw6w2l+Q7jxa8JEV4I?=
 =?us-ascii?Q?3GH997c1PdV973djLUKFbsCK4JTBK0s7xClYLXzNsUNSnjrcs8poE9iRrYdO?=
 =?us-ascii?Q?s2Pzus9qAXxs1GFzwX5srdKq0tSpucSpP0xXjNFfdu7KG5xeLLfEt2Ub46nN?=
 =?us-ascii?Q?x07DzNVsl0U9w1WeAWzfmtmAQNu3Q9PFjcoeOyZuFzS5s3btnjsmVmtYnviG?=
 =?us-ascii?Q?w+DrQF5Y6Gra4S0vYYhKnM1yds0Y8vZ3oWOh8pCvEM8MnD1G2v3//T5JB3XI?=
 =?us-ascii?Q?wEhvVegsI8SYgR4HxNwbdFi+qIHXktb3IgKaWGh6dEEjLwzVTYv8/pyW4ysd?=
 =?us-ascii?Q?SCdALN7ksmZcP6d6HR7h7B89yJ+aZlmbK1Mtt639lVC3Ss79k+Wz4SdD5rEo?=
 =?us-ascii?Q?w5S/u/fY7kMVajrhBLHtsyfRbcZ7LJbbkZH7GIofpbbpt5kb/2OlKADLa2zp?=
 =?us-ascii?Q?jyow14sCam7tYxsKfMlpzXOV4ViUfWel3jTagziQqEXzbYQ6BD8uyc44Ku2J?=
 =?us-ascii?Q?a+4aJ6PaE/jZF9cBhbl04wNuty6GKa6Slg8WaLNoncTOolLDLdhLDQnN7Dnn?=
 =?us-ascii?Q?9s+aijjhkPb/T7tnes1Id1gDeN4vOBsWmcpVeoZqJt5UCH0jbphfp/UH1JrQ?=
 =?us-ascii?Q?7+fMz3pGhz6E5rdjiMGBgxhOZ8H3wiZbw9/rE+vDwrhSw83p/zjZYNJDPbNg?=
 =?us-ascii?Q?7SWs3ImihfHvQdwfIUjcclPofwoVy2stCpdvCxquSQ5abnJJZ9Qz0xCtwy6h?=
 =?us-ascii?Q?psOtWCdzWawxS5wusbKxarjepvtFiGbs95lzNiiQm9Rw2S7I1SF5+bg94Tic?=
 =?us-ascii?Q?QfVElGDT3n5g8wfB6rcv/AHNVSXTstZ0erd2pZC3MW3V5Ye8QCZLPXLnSzQx?=
 =?us-ascii?Q?CSovl1d/TKwZCxGCxQyvfmU8eczlEL1RP4fuFFZaeiXKYUIO6U9JrRDi9Ard?=
 =?us-ascii?Q?3+zcOip3VsI4d7w57V7zakbsvbeZ119WQWHT2EhaIVEA/pafrVsBwbgnNuDG?=
 =?us-ascii?Q?P33pCCpw6CCjxh3prTA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 13:44:04.2513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 247fe9bb-c429-49dc-49d5-08de0a5e931c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237

The lock-related debug logic (CONFIG_LOCK_STAT) in the kernel is noting
the following warning when the BlueField-3 SOC is booted:

[   10.231318] BUG: key ffff00008a3402a8 has not been registered!
[   10.237249] ------------[ cut here ]------------
[   10.241914] DEBUG_LOCKS_WARN_ON(1)
[   10.241927] WARNING: CPU: 4 PID: 592 at kernel/locking/lockdep.c:4801 lockdep_init_map_type+0x1d4/0x2a0
[   10.254700] Modules linked in: mlxbf_pmc(+) mlxbf_pka mlxbf_bootctl cppc_cpufreq(+) sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua drm ip_tables x_tables virtio_net crct10dif_ce ghash_ce sha2_ce net_failover sha256_arm64 failover sha1_ce nvme nvme_core vitesse gpio_mlxbf3 sdhci_of_dwcmshc sdhci_pltfm sdhci mlxbf_gige i2c_mlxbf pinctrl_mlxbf3 mlxbf_tmfifo pwr_mlxbf autofs4 aes_ce_blk crypto_simd cryptd aes_ce_cipher
[   10.282360] mlxbf_gige MLNXBF17:00 oob_net0: renamed from eth0
[   10.292917] CPU: 4 PID: 592 Comm: systemd-udevd Not tainted 5.15.189+ #2
[   10.292922] Hardware name: https://www.mellandx.com BlueField-3 DPU/BlueField-3 DPU, BIOS 4.13.0.13780 Sep 30 2025
[   10.292922] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   10.292925] pc : lockdep_init_map_type+0x1d4/0x2a0
[   10.292931] lr : lockdep_init_map_type+0x1d4/0x2a0
[   10.292932] sp : ffff8000096a3350
[   10.292933] x29: ffff8000096a3350 x28: 00000000000001a4 x27: 00000000ffffee4b
[   10.292937] x26: ffff00008a3402e0 x25: 0000000000000000 x24: 0000000000000000
[   10.292939] x23: ffff00008a3402a8 x22: 0000000000000000 x21: ffffd1acf2833000
[   10.292941] x20: ffff00008a3402a8 x19: ffff00008c10d378 x18: ffffd1acf1d3d000
[   10.292944] x17: 000000007bba6d3c x16: ffffd1acef416114 x15: ffff0003dd914d88
[   10.292946] x14: 0000000000000000 x13: 284e4f5f4e524157 x12: 5f534b434f4c5f47
[   10.292949] x11: 656820747563205b x10: 0000000000000029 x9 : ffffd1acef49deb4
[   10.292951] x8 : ffffd1acf0e93008 x7 : 0000000000000001 x6 : 0000000000000001
[   10.385410] x5 : ffff8000096a31a0 x4 : ffff2e56eca7f000 x3 : ffff0003d20a5e80
[   10.385412] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0003d20a5e80
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

Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>

Fixes: 5efc800975d9 ("platform/mellanox: mlxbf-pmc: Add support for monitoring cycle count")
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
2.43.2


