Return-Path: <linux-kernel+bounces-770008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C18B275D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8122C17B31A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E1E2BE05E;
	Fri, 15 Aug 2025 02:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kHR+NXUM"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DC9299920;
	Fri, 15 Aug 2025 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224913; cv=fail; b=u8E9QUc3u6gPidWWqBiK+9QbGCyv1fURAl4kr4aoxO2WxHPTWOBwjqcUdXtFKCyxnoVU8SDvahWmcEzDaHz7vmdcv90u2v0ok+q8RnVTyFujiXb1PrIL7vB4EuGa54TB/FwevWgbCgcwkL+a1HxQpCl1vslh+3FGZlbndc1QaKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224913; c=relaxed/simple;
	bh=XAn6J/QSY655wUmKYVT/BlIVQ7vqIssfcxZxiEiIBBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pa0otj8rKtTZC5/KIRUCKfJ5HJXRZe8Jv/8ietcNVQfdLM23DQVPevphlbF77PA3vBsINUBuwEBwF+OAt9vg7mzSFN6QBT31MScTtHGl6FPZtWq7zijX4SKHVt4LBV17UHpy7z3G2F9V33AK5duXAPDkjX+MLBCuYt/6ufpf/lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kHR+NXUM; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtptZym9inA2EIzOgRAiji2yxSo/mPerqeIfGvhwhHKnEOdLZxuvpRgEXaAbenc8G6tTVY4QZXPDQKfPopEjeJee+IlEhY22XPtPS04c+ZAZEB+EITTtrPSypS+shDvGxv6ndDaizJLndrWVZSA2DWT7JgXRhiOWatlJ6we7bhaNu+Wq5COkm6buShcZPaGlb5NhCxOTijGzeUCSEfCxJrNBB1deFuetYoLTNC8Vfhiw2WYU5iacShhJyYnQpMMzQguOQU9vQKU11pXKYnjV1cyFnUGILV98PLOlBuLBjt8mzhsDg9kDIgY0DGEn7wyFim8qjQkkaBKQTsof+W4uEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDRk1bhSUm2wFfKUzKU31hq7KYQv3VESZuUcwJkFM/U=;
 b=JMR2fSk1uBozcPbGbJ5QvUDkGlip6xOuw0weiFJ/XDaj2XcJ7GhmqseevAy6bi4JOxQyHzn1l4TFERUTwBAJjJgXdvkougQflAOfqaJbLR7bH+auWjoBnM0eA37E+8jOdgXvi2qqbzVh1L3MqJB16mhzvyUZ6+R/VL32L2fxssNwsczoy0QEhmjlilQp7cOm9T5ugwEAdsJ74vpEsZtGwzq02dTTEG41S5zBFjwvn+YLI2suqyrMok3d4O3xjaYekx5JI9armn1khuCxcScqlW8VIV4RYgn9C/ThVcTKXuk/0bkfVMvzb8NsuHE6Sc6GUxkTO3n4xwLQWP4UJs+x5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDRk1bhSUm2wFfKUzKU31hq7KYQv3VESZuUcwJkFM/U=;
 b=kHR+NXUMjdpXPm9XFytYa0iZx5Snw5lG82QLxGOhPT7wr3yKXCxkme4DUGxjmJo7U4wfNYRiAyLDk+QNAXRX7sCrnKaXUs/9amU3fCyVmlsn+ep4GUKXIeMMXRf01gAV/pMR9jaZQpWqTyC5EG0UyEZhUA48UmcfQJ0xge4Acoc=
Received: from SJ0PR13CA0089.namprd13.prod.outlook.com (2603:10b6:a03:2c4::34)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 02:28:28 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::c9) by SJ0PR13CA0089.outlook.office365.com
 (2603:10b6:a03:2c4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.7 via Frontend Transport; Fri,
 15 Aug 2025 02:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:28:26 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:28:24 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <babu.moger@amd.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<rostedt@goodmis.org>, <paulmck@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <thomas.lendacky@amd.com>,
	<yosry.ahmed@linux.dev>, <xin@zytor.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<mario.limonciello@amd.com>, <xin3.li@intel.com>, <perry.yuan@amd.com>,
	<chang.seok.bae@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<eranian@google.com>, <gautham.shenoy@amd.com>
Subject: [PATCH v17 18/33] fs/resctrl: Add the functionality to unassign MBM events
Date: Thu, 14 Aug 2025 21:25:22 -0500
Message-ID: <4070eeb0525dc990fe56058714b107462c740b76.1755224735.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755224735.git.babu.moger@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abbe4d5-6336-4ac9-eccc-08dddba36a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0CuVTOerBiCqQ4Ps3AuNKG374LqgE3HcS7hZ4KkPYf8g2djlKoiuaqLpQEUW?=
 =?us-ascii?Q?+kvV52NIbn9Srns6iMPZSFRUY8NledSSLq1yBS8TgSp39cDMEqh1awxi+mTO?=
 =?us-ascii?Q?0Zr4/0Rv5yHEKOvYeHQHXRPt91MQZ6mduyKBs1DFYfdxMfZwyBIdbxMiV54d?=
 =?us-ascii?Q?wI4JX1vLWU0FTDYBOiuo7aShjvRKA63gsqY8J8JD2TC6QvNCSS5Qe5HW8Lug?=
 =?us-ascii?Q?QMvWp5iwLpOcc8UHUCoQlQm2yRGcsp+xY9TG5reWTXAXDU6uBqaUrvkxXQPv?=
 =?us-ascii?Q?H3jXYvtwyESTk5K1CnWpUIB2TUrfaAAIztT5mKA6qkF5X9ZMR6b5Z8u7NbJ+?=
 =?us-ascii?Q?a8xmUbPX3WZ5IOIX4XxHYFsWOfYJjbxqoQO+NyhFY7M85SRoO5NiZiToViwD?=
 =?us-ascii?Q?9N4od8AiYPO+UN7BfCP1gH/yVlEDD3egfGxDCtOh+okbZzC4tGj8TLAlM+d2?=
 =?us-ascii?Q?kHQT8ek5EzGFZ1uGBib3FqkelQjtigq5m1ctd9/XSv83o7aiHneYbFD4XtpX?=
 =?us-ascii?Q?SiEx/FmbQCo1CTlNvx9LaKUOSkPwewrMZ1JHUNyPphp4T+kVthaVMOYcwTtA?=
 =?us-ascii?Q?oL7UBzgx6hz1maeYLsnofiIT+zaLL+Yq782xkQ7iUcjts8jlLLD9UwpaKM63?=
 =?us-ascii?Q?Y1yD1ZB/51oBiY93csW5TakKaW9ZU6XqTuZn9b0CPJVzUdUUYLlFJ6GHNhcA?=
 =?us-ascii?Q?5WS1Ms5XtmW9wMaf+Hyz5YRLqg0fv1mr8ND5l3pCON4/aNVkfE988HHjVgYh?=
 =?us-ascii?Q?jvNCHJdvF/JvL8AX6TYldr3fNm/Xe8eUsyE9Q/Hc1Kw9KMphuSgjsQp9LZCU?=
 =?us-ascii?Q?hWfC5GU9SsmSqUxZ0cX9+c0CXlnZKZcZCJ23oN8tpS7/U9G9aH3YO+5jwsO9?=
 =?us-ascii?Q?oRvOpGN1k2Z0BoOYhfOqic3TNcnsKNWFJLm2Cf04L1yYA4e6AFYdsMBiV1vV?=
 =?us-ascii?Q?4Zop2fZ3zs9D0lxBEHuhQBDWH6daRjoLVVJb4zzdnvhEiQ2rIJDdf7CwE7R6?=
 =?us-ascii?Q?pPzmrf1IIY7p+xja3yUCWT7eR+Sq+Jq1WK2ijU8hgweqG226q3+CZ72x0XAB?=
 =?us-ascii?Q?5/pZShNcTsFgMCP9wdLv0f9hEJSqd47ubJDjUoZ7OhqiBPZC8/qKsa1qEzs/?=
 =?us-ascii?Q?oQkNKMMPJif+Lbq6IFoXjXkVW434WFXDOz4Tt89DIXKkSG08S7Efv/KWYXFj?=
 =?us-ascii?Q?SMy+S7f3tJQOCaaUeO53U+C+xFQrofQYhZMPSn4CMteo/xhkeGzULNZb0nGF?=
 =?us-ascii?Q?/TMTlLD6rtyuOEkcg28g4F+Syqf8lwq/wFIwKf5Y/70Dn/Mm7ECsb9fyO5cy?=
 =?us-ascii?Q?g8GHPd9+syF/vMbSgbkVb7ZCtrYsrJ6uKO3wmpFv4HmaRnz3ywze6lknnHUw?=
 =?us-ascii?Q?Erado5AjDyOY+qCIHz1LhyP8aMmojySmpEldVWuG0/X0b9Y5k8ejBbiRnjej?=
 =?us-ascii?Q?ppLhwwZCt5PoI75dBX3gpNq692PBju7By0mF/Go2T8VYmNFj2yxsBmgKRRG3?=
 =?us-ascii?Q?1RSRDthVDzgYh9CLGgaNccoiZEQFS2sD2ECvmCaq5t+XXaSEqFcCeiRrmQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:28:26.6219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abbe4d5-6336-4ac9-eccc-08dddba36a63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075

The "mbm_event" counter assignment mode offers "num_mbm_cntrs" number of
counters that can be assigned to RMID, event pairs and monitor bandwidth
usage as long as it is assigned. If all the counters are in use, the kernel
logs the error message "Failed to allocate counter for <event> in domain
<id>" in /sys/fs/resctrl/info/last_cmd_status when a new assignment is
requested.

To make space for a new assignment, users must unassign an already
assigned counter and retry the assignment again.

Add the functionality to unassign and free the counters in the domain.
Also, add the helper rdtgroup_unassign_cntrs() to unassign counters in the
group.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v17: Updated changelog.
     Moved all the functions to monitor.c.
     Brought rdtgroup_unassign_cntrs() from patch 28 to monitor.c to make compiler happy.

v16: Function rename rdtgroup_free_config_cntr() -> rdtgroup_free_unassign_cntr().
     Updated rdtgroup_free_unassign_cntr() to pass struct mon_evt to match
     rdtgroup_alloc_assign_cntr() prototype.

v15: Updated the changelog.
     Changed code in mbm_cntr_free to use the sizeof(*d->cntr_cfg)).
     Removed unnecessary return in resctrl_free_config_cntr().
     Rename resctrl_unassign_cntr_event() -> rdtgroup_unassign_cntr_event().
     Removed the parameter struct rdt_resource. It can be obtained from mevt->rid.

v14: Passing the struct mon_evt to resctrl_free_config_cntr() and removed
     the need for mbm_get_mon_event() call.
     Corrected the code documentation for mbm_cntr_free().
     Changed resctrl_free_config_cntr() and resctrl_unassign_cntr_event()
     to return void.
     Changed subject line to fs/resctrl.
     Updated the changelog.

v13: Moved mbm_cntr_free() to this patch as it is used in here first.
     Not required to pass evt_cfg to resctrl_unassign_cntr_event(). It is
     available via mbm_get_mon_event().
     Resolved conflicts caused by the recent FS/ARCH code restructure.
     The monitor.c file has now been split between the FS and ARCH directories.

v12: Updated the commit text to make bit more clear.
     Replaced several counters with "num_mbm_cntrs" counters.
     Fixed typo in the subjest line.
     Fixed the handling error on first failure.
     Added domain id and event id on failure.
     Added new parameter event configuration (evt_cfg) to provide the event from
     user space.

v11: Moved the functions to monitor.c.
     Renamed rdtgroup_unassign_cntr_event() to resctrl_unassign_cntr_event().
     Refactored the resctrl_unassign_cntr_event().
     Updated commit message and code comments.


v10: Patch changed again.
     Counters are managed at the domain based on the discussion.
     https://lore.kernel.org/lkml/CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com/
     commit message update.

v9: Changes related to addition of new function resctrl_config_cntr().
    The removed rdtgroup_mbm_cntr_is_assigned() as it was introduced
    already.
    Text changes to take care comments.

v8: Renamed rdtgroup_mbm_cntr_is_assigned to mbm_cntr_assigned_to_domain
    Added return error handling in resctrl_arch_config_cntr().

v7: Merged rdtgroup_unassign_cntr and rdtgroup_free_cntr functions.
    Renamed rdtgroup_mbm_cntr_test() to rdtgroup_mbm_cntr_is_assigned().
    Reworded the commit log little bit.

v6: Removed mbm_cntr_free from this patch.
    Added counter test in all the domains and free if it is not assigned to
    any domains.

v5: Few name changes to match cntr_id.
    Changed the function names to rdtgroup_unassign_cntr
    More comments on commit log.

v4: Added domain specific unassign feature.
    Few name changes.

v3: Removed the static from the prototype of rdtgroup_unassign_abmc.
    The function is not called directly from user anymore. These
    changes are related to global assignment interface.

v2: No changes.
---
 fs/resctrl/internal.h |  2 ++
 fs/resctrl/monitor.c  | 66 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 73cad7c17a1f..c11f2751acf5 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -398,6 +398,8 @@ int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_fil
 
 void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp);
 
+void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 3eb5a30f44fb..c03266e36cba 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -405,6 +405,14 @@ static int mbm_cntr_alloc(struct rdt_resource *r, struct rdt_mon_domain *d,
 	return -ENOSPC;
 }
 
+/*
+ * mbm_cntr_free() - Clear the counter ID configuration details in the domain @d.
+ */
+static void mbm_cntr_free(struct rdt_mon_domain *d, int cntr_id)
+{
+	memset(&d->cntr_cfg[cntr_id], 0, sizeof(*d->cntr_cfg));
+}
+
 static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 {
 	int cpu = smp_processor_id();
@@ -1045,6 +1053,64 @@ void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
 					   &mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID]);
 }
 
+/*
+ * rdtgroup_free_unassign_cntr() - Unassign and reset the counter ID configuration
+ * for the event pointed to by @mevt within the domain @d and resctrl group @rdtgrp.
+ */
+static void rdtgroup_free_unassign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+					struct rdtgroup *rdtgrp, struct mon_evt *mevt)
+{
+	int cntr_id;
+
+	cntr_id = mbm_cntr_get(r, d, rdtgrp, mevt->evtid);
+
+	/* If there is no cntr_id assigned, nothing to do */
+	if (cntr_id < 0)
+		return;
+
+	rdtgroup_assign_cntr(r, d, mevt->evtid, rdtgrp->mon.rmid, rdtgrp->closid, cntr_id, false);
+
+	mbm_cntr_free(d, cntr_id);
+}
+
+/*
+ * rdtgroup_unassign_cntr_event() - Unassign a hardware counter associated with
+ * the event structure @mevt from the domain @d and the group @rdtgrp. Unassign
+ * the counters from all the domains if @d is NULL else unassign from @d.
+ */
+static void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
+					 struct mon_evt *mevt)
+{
+	struct rdt_resource *r = resctrl_arch_get_resource(mevt->rid);
+
+	if (!d) {
+		list_for_each_entry(d, &r->mon_domains, hdr.list)
+			rdtgroup_free_unassign_cntr(r, d, rdtgrp, mevt);
+	} else {
+		rdtgroup_free_unassign_cntr(r, d, rdtgrp, mevt);
+	}
+}
+
+/*
+ * rdtgroup_unassign_cntrs() - Unassign the counters associated with MBM events.
+ *			       Called when a group is deleted.
+ */
+void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
+{
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
+
+	if (!r->mon_capable || !resctrl_arch_mbm_cntr_assign_enabled(r))
+		return;
+
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
+		rdtgroup_unassign_cntr_event(NULL, rdtgrp,
+					     &mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID]);
+
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
+		rdtgroup_unassign_cntr_event(NULL, rdtgrp,
+					     &mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID]);
+}
+
 int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
 				 struct seq_file *s, void *v)
 {
-- 
2.34.1


