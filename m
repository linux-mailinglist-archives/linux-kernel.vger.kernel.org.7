Return-Path: <linux-kernel+bounces-770015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48898B275F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B1972352E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EAF2BF00D;
	Fri, 15 Aug 2025 02:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vqOyXPPf"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C605729ACCC;
	Fri, 15 Aug 2025 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224966; cv=fail; b=YCGKL9hHzMdVHrpeWOFe50GLyk64twSZR7i6pEg3YawzRMk8Ooo8gJxe9hddB/Mol3QX9h0U2CFr5wL7GvAx7D6m29c4x+7alOnduCPLA5XM9MVDuKHpzZFVwKryJBNJmpa+Vn37FH+PnAmU714G1Ld2eky0cFP6COBDW9RXJQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224966; c=relaxed/simple;
	bh=ZLT0u+6DSSCnTJs1nnIwAShSzWFl0p90FO70PLgmjW0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SV91Kf2UAZnlgLLPm95DTiabH34qhUwcWj/0Dlt8JV4KMhArEQiTpwi9f0zfX5aUdqpq4gWBzzFRpD0nXnVqx2OOo6FN7VX2Apv+eOcfp7tigtixukkDi1yL4rpYraDSoEWySqz4HLLbpGzMtk67X02SLAoWcN0RV7OZCEdL9bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vqOyXPPf; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R02w2mu7u1H0qGS8fKOKuqRyN2rZN0GQAL8xMGI3DQkBuKJlkVndPkdtMpxk1T8hvX1HqRPiw/TXZHry1vM6it47Bh/LJcIztp5xWdB8ka0FDGDENYMoVawaH0WDJHWp+0k1NR5CoESYrx738Oidmg3IqWoydsAzq7TElEiAc5SBt9Y6Yd0Di7RJEKjPDv1FhQC+PPzzdC7hOvt8Ax+TGHmBoMmhxZpZbxWpBdX2GCTxzoqUuf+kMhWJKB0X2ZWYcz7j6+mmoZS54tU1DXuR46DQd006rZL+HHio/giXQUzXpXYhn+mRBI2uYlCDMfe+mRc7uj1/Y6IQfmgqrIXYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqK4HiZu/DfGpLRXyR8CTwd2qLVMPcCb68g4/wHw9V4=;
 b=EZwuQaNKRExAAGu30/NzGkoIUvS9I81a76iI/3MQ0YpXmJ1oPuwmi1vxEeCGF6+KO6dB+1AeVOpjNarqIDDrOqzunEbseYwdQCyXcetdvRutUeEt7u4Ns7RWXSQq7UF8MQHFF7Y5TL3gShW6w34tSiMBYhHpgMC5ue/2RUHijKafGSks1C8YZnUzmBhHur1pNtm6S2ZfAy9FPq3Qq7H2NKUhR5hNFBUtTDPbRiGgcY/nc9C9L9fnJINuxhnadEsDZbk0BQ3/xxARQvD7H6RC6YuOsQRoAvgatjpg6zdOKHGHGvFmVF4Q14e1/5G7fT15E1Q+c12vJ31F+cKbA9Ggvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqK4HiZu/DfGpLRXyR8CTwd2qLVMPcCb68g4/wHw9V4=;
 b=vqOyXPPfC6yrdNEKWuuUC/xyp53mU+ZskjfRzrikZeEdF5RgAYMIV6tQTkpjkLE9273gCE2fRls3wc/EEP98s1J+EdFDf6ynQrPKi/qe/8GmSXvoAT3lkIX28gJry8IEIbPoEbDVY88PsceZ0xvsBVvh2M2xIBpmQG86o4xhFQc=
Received: from SJ0PR13CA0079.namprd13.prod.outlook.com (2603:10b6:a03:2c4::24)
 by PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 02:29:19 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::63) by SJ0PR13CA0079.outlook.office365.com
 (2603:10b6:a03:2c4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.7 via Frontend Transport; Fri,
 15 Aug 2025 02:29:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:29:18 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:29:15 -0500
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
Subject: [PATCH v17 24/33] fs/resctrl: Add event configuration directory under info/L3_MON/
Date: Thu, 14 Aug 2025 21:25:28 -0500
Message-ID: <b09cc34a98f31ffbb913b26a64d9742ffa617dcf.1755224735.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|PH8PR12MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d098768-d082-487c-d520-08dddba3898b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7xrKG6+Qx6Z9XDSFFFxzN8SieRffPPaTKdP7uNNIVNBOyeNxDRdpO/kOZUdF?=
 =?us-ascii?Q?1jzGEtqeQgTEtborHIpVtKfFadb9HTSaJrucQNiQI9RNqXpSNztwLdacnHt6?=
 =?us-ascii?Q?zcX5wsFRLjzEwRs+kNdQsqXy96nNBfPetnrZbY9BNT/nwppBea0JtaTM5ruL?=
 =?us-ascii?Q?4hx6bjGarcdVBsyDEULkB6yRjTTAg1ty0Sd5EdRClwg9vexq3Kjx+DWInxoJ?=
 =?us-ascii?Q?qRPyyfaNx7b24EHsoLKsibBsapRSDEC8aqrM4GxE3aY2cTPvHkI73UMJxQpu?=
 =?us-ascii?Q?4CLz6oh/xBemmqakIxp8Lu4GyQDzXUIJ7s1DqHz4rka23C8Kuelcb8nl2Ov5?=
 =?us-ascii?Q?pa/n/981suAfiqly06eR6sc26Jd3GOmCiDMvXRodIvUPAtUl+KULC4kGiHgh?=
 =?us-ascii?Q?g17MZqTYTn9RRRijSopo9cb4f+a7Ij2dZVMS7g/8QPqM79mPlYBZMYq/bt6I?=
 =?us-ascii?Q?BVOrx1qgUTlu8IqXUWELiYq8rcFWOVSxxKepH42/+u2X2knLKzhd2IGVn30m?=
 =?us-ascii?Q?z+3Oab+/Q7qPoAM3nZZauCTqKcb2DBNfHL73c8BCvYJkis+KWgW7eIDZ4Qe5?=
 =?us-ascii?Q?QZzHqHxc9M7LJQ1gRA9v7r3kspmaNHNPa8wcCGOeIy+zP7B+b3FHG0NvjARI?=
 =?us-ascii?Q?QaEYrWUixlPX7VA2w2cwz0GbgFE9bYdU+QBDKGpb0f7tpm6UqLPkM/wklNt1?=
 =?us-ascii?Q?bdQ3x57Zfsq9HdQxe7T3grYo53DPDR/7Y/TNbn62ENswXREIljlK/Jac0TBs?=
 =?us-ascii?Q?lJZ0CA2V2O6geFKnkPVbzIzwi8XxdSM3xqFod13qLwnrNwtsMnyWBjdakUav?=
 =?us-ascii?Q?wokcuL0Iu6KDR6XkgAnUlnISFB0URZohfghSeYMOGjMAN/YKbVwCwIgbe96o?=
 =?us-ascii?Q?qSDMbLiDpEd+3byRLMNmyCnZwUUu0Y0I+GCj1q2oIBuiw+U4rHyt5JIrusit?=
 =?us-ascii?Q?dm8qgN1fsSsX3SFPkqO/Dkr6xMn41qQFlNqNemwN2eCQu45Bhal/e1VbLTWg?=
 =?us-ascii?Q?ro5UFY7AtyZTnHs8LJl9v2KgX1WvRU0PAqwO3vc/T+NRmmIGwQHa2Wiy1bGn?=
 =?us-ascii?Q?PldNg3QC9NZR9aFwoMBIYZy0XkD/DqInKqjawMSZZdNljF+w1vz3AIt5LiVH?=
 =?us-ascii?Q?TaLB4AgGWnytxMQz1ErKC3Qt/N7FnQFycEvcL9alt008UtpYrrBvcRE1WHZ2?=
 =?us-ascii?Q?LIb3Tc5hufRwOiMpK4igdVj/mndziYAq8ROx1m/BpfrD/7wsW5vBiHTtpjNd?=
 =?us-ascii?Q?ZPafDnU58HHH9Sqia0fq2SXb8bnWJp9PTBIKLWRlodzyMx2jmmEItadC1QNb?=
 =?us-ascii?Q?yhooQodnLDggxZiaFAKTMMkihl3XAae1rxIClGEa6OiSrxSVSuM/F91zM03h?=
 =?us-ascii?Q?65cB1GIPuMoVSvR8m68FM4u7UHwmn2UTR63+4noZ83ptshL2Jo9sM0D/uZ2j?=
 =?us-ascii?Q?IWzcP1PyFsqLKkjYH2bQbrx7qsCCcN6gFZ9PbftUppbVs4UF6W5ceRVnFVEE?=
 =?us-ascii?Q?x8FgQOyo6F2vLEh0iYJlssDFUqyYi+SWev0p?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:29:18.8941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d098768-d082-487c-d520-08dddba3898b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745

The "mbm_event" counter assignment mode allows the user to assign a
hardware counter to an RMID, event pair and monitor the bandwidth as long
as it is assigned. The user can specify the memory transaction(s) for the
counter to track.

When this mode is supported, the /sys/fs/resctrl/info/L3_MON/event_configs
directory contains a sub-directory for each MBM event that can be assigned
to a counter.  The MBM event sub-directory contains a file named
"event_filter" that is used to view and modify which memory transactions
the MBM event is configured with.

Create /sys/fs/resctrl/info/L3_MON/event_configs directory on resctrl mount
and pre-populate it with directories for the two existing MBM events:
mbm_total_bytes and mbm_local_bytes. Create the "event_filter" file within
each MBM event directory with the needed *show() that displays the memory
transactions with which the MBM event is configured.

Example:
$ mount -t resctrl resctrl /sys/fs/resctrl
$ cd /sys/fs/resctrl/
$ cat info/L3_MON/event_configs/mbm_total_bytes/event_filter
  local_reads,remote_reads,local_non_temporal_writes,
  remote_non_temporal_writes,local_reads_slow_memory,
  remote_reads_slow_memory,dirty_victim_writes_all

$ cat info/L3_MON/event_configs/mbm_local_bytes/event_filter
  local_reads,local_non_temporal_writes,local_reads_slow_memory

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v17: Squashed patch #24 abd #25 into one. Both are dependent on each other.
     Minor change in resctrl.rst.
     Remove check for kernfs_activate() in rdtgroup_mkdir_info_resdir().
     Added resctrl_arch_mbm_cntr_assign_enabled() in event_filter_show().
     Moved struct mbm_transaction declaration to monitor.c and made it static.

v16: Moved event_filter_show() to fs/resctrl/monitor.c
     Changed the goto label out_config to out.
     Added rdtgroup_mutex in event_filter_show().
     Removed extern for mbm_transactions. Not required.
     0025-fs-resctrl-Add-event-configuration-directory-under
     0025-fs-resctrl-Add-event-configuration-directory-under
     0025-fs-resctrl-Add-event-configuration-directory-under
     Added prototype rdt_kn_parent_priv() in so it can be called from monitor.c

v15: Fixed the event_filter display with proper spacing.
     Updated the changelog.
     Changed the function name resctrl_mkdir_counter_configs() to
     resctrl_mkdir_event_configs().
     Called resctrl_mkdir_event_configs from rdtgroup_mkdir_info_resdir().
     It avoids the call kernfs_find_and_get() to get the node for info directory.
     Used for_each_mon_event() where applicable.

v14: Updated the changelog with context. Thanks to Reinette.
     Changed the name of directory to event_configs from counter_config.
     Updated user doc about the memory transactions supported by assignment.
     Removed mbm_mode from struct mon_evt. Not required anymore.

v13: Updated user doc (resctrl.rst).
     Changed the name of the function resctrl_mkdir_info_configs to
     resctrl_mkdir_counter_configs().
     Replaced seq_puts() with seq_putc() where applicable.
     Removed RFTYPE_MON_CONFIG definition. Not required.
     Changed the name of the flag RFTYPE_CONFIG to RFTYPE_ASSIGN_CONFIG.
     Reinette suggested RFTYPE_MBM_EVENT_CONFIG but RFTYPE_ASSIGN_CONFIG
     seemed shorter and pricise.
     The configuration is created using evt_list.
     Resolved conflicts caused by the recent FS/ARCH code restructure.
     The monitor.c/rdtgroup.c files have been split between the FS and ARCH directories.

v12: New patch to hold the MBM event configurations for mbm_cntr_assign mode.
---
 Documentation/filesystems/resctrl.rst | 33 +++++++++++++++
 fs/resctrl/internal.h                 |  4 ++
 fs/resctrl/monitor.c                  | 56 +++++++++++++++++++++++++
 fs/resctrl/rdtgroup.c                 | 59 ++++++++++++++++++++++++++-
 include/linux/resctrl_types.h         |  3 ++
 5 files changed, 153 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 4c24c5f3f4c1..ddd95f1472e6 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -310,6 +310,39 @@ with the following files:
 	  # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
 	  0=30;1=30
 
+"event_configs":
+	Directory that exists when "mbm_event" counter assignment mode is supported.
+	Contains a sub-directory for each MBM event that can be assigned to a counter.
+
+	Two MBM events are supported by default: mbm_local_bytes and mbm_total_bytes.
+	Each MBM event's sub-directory contains a file named "event_filter" that is
+	used to view and modify which memory transactions the MBM event is configured
+	with. The file is accessible only when "mbm_event" counter assignment mode is
+	enabled.
+
+	List of memory transaction types supported:
+
+	==========================  ========================================================
+	Name			    Description
+	==========================  ========================================================
+	dirty_victim_writes_all     Dirty Victims from the QOS domain to all types of memory
+	remote_reads_slow_memory    Reads to slow memory in the non-local NUMA domain
+	local_reads_slow_memory     Reads to slow memory in the local NUMA domain
+	remote_non_temporal_writes  Non-temporal writes to non-local NUMA domain
+	local_non_temporal_writes   Non-temporal writes to local NUMA domain
+	remote_reads                Reads to memory in the non-local NUMA domain
+	local_reads                 Reads to memory in the local NUMA domain
+	==========================  ========================================================
+
+	For example::
+
+	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
+	  local_reads,remote_reads,local_non_temporal_writes,remote_non_temporal_writes,
+	  local_reads_slow_memory,remote_reads_slow_memory,dirty_victim_writes_all
+
+	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
+	  local_reads,local_non_temporal_writes,local_reads_slow_memory
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 88e1a800417d..7b1206fff116 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -241,6 +241,8 @@ struct rdtgroup {
 
 #define RFTYPE_DEBUG			BIT(10)
 
+#define RFTYPE_ASSIGN_CONFIG		BIT(11)
+
 #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
 
 #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
@@ -403,6 +405,8 @@ void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp);
 
 void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp);
 
+int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 0a9d257e27a2..25fec9bf2d61 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -974,6 +974,61 @@ u32 resctrl_get_mon_evt_cfg(enum resctrl_event_id evtid)
 	return mon_event_all[evtid].evt_cfg;
 }
 
+/**
+ * struct mbm_transaction - Memory transaction an MBM event can be configured with.
+ * @name:	Name of memory transaction (read, write ...).
+ * @val:	The bit (eg. READS_TO_LOCAL_MEM or READS_TO_REMOTE_MEM) used to
+ *		represent the memory transaction within an event's configuration.
+ */
+struct mbm_transaction {
+	char	name[32];
+	u32	val;
+};
+
+/* Decoded values for each type of memory transaction. */
+static struct mbm_transaction mbm_transactions[NUM_MBM_TRANSACTIONS] = {
+	{"local_reads", READS_TO_LOCAL_MEM},
+	{"remote_reads", READS_TO_REMOTE_MEM},
+	{"local_non_temporal_writes", NON_TEMP_WRITE_TO_LOCAL_MEM},
+	{"remote_non_temporal_writes", NON_TEMP_WRITE_TO_REMOTE_MEM},
+	{"local_reads_slow_memory", READS_TO_LOCAL_S_MEM},
+	{"remote_reads_slow_memory", READS_TO_REMOTE_S_MEM},
+	{"dirty_victim_writes_all", DIRTY_VICTIMS_TO_ALL_MEM},
+};
+
+int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
+{
+	struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r;
+	bool sep = false;
+	int ret = 0, i;
+
+	mutex_lock(&rdtgroup_mutex);
+	rdt_last_cmd_clear();
+
+	r = resctrl_arch_get_resource(mevt->rid);
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	for (i = 0; i < NUM_MBM_TRANSACTIONS; i++) {
+		if (mevt->evt_cfg & mbm_transactions[i].val) {
+			if (sep)
+				seq_putc(seq, ',');
+			seq_printf(seq, "%s", mbm_transactions[i].name);
+			sep = true;
+		}
+	}
+	seq_putc(seq, '\n');
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+
+	return ret;
+}
+
 /*
  * rdtgroup_assign_cntr() - Assign/unassign the counter ID for the event, RMID
  * pair in the domain.
@@ -1289,6 +1344,7 @@ int resctrl_mon_resource_init(void)
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		resctrl_file_fflags_init("available_mbm_cntrs",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
+		resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
 	}
 
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 8eaad45b28ea..25a653847f49 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1923,6 +1923,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= mbm_local_bytes_config_show,
 		.write		= mbm_local_bytes_config_write,
 	},
+	{
+		.name		= "event_filter",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= event_filter_show,
+	},
 	{
 		.name		= "mbm_assign_mode",
 		.mode		= 0444,
@@ -2183,10 +2189,48 @@ int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
 	return ret;
 }
 
+static int resctrl_mkdir_event_configs(struct rdt_resource *r, struct kernfs_node *l3_mon_kn)
+{
+	struct kernfs_node *kn_subdir, *kn_subdir2;
+	struct mon_evt *mevt;
+	int ret;
+
+	kn_subdir = kernfs_create_dir(l3_mon_kn, "event_configs", l3_mon_kn->mode, NULL);
+	if (IS_ERR(kn_subdir))
+		return PTR_ERR(kn_subdir);
+
+	ret = rdtgroup_kn_set_ugid(kn_subdir);
+	if (ret)
+		return ret;
+
+	for_each_mon_event(mevt) {
+		if (mevt->rid != r->rid || !mevt->enabled || !resctrl_is_mbm_event(mevt->evtid))
+			continue;
+
+		kn_subdir2 = kernfs_create_dir(kn_subdir, mevt->name, kn_subdir->mode, mevt);
+		if (IS_ERR(kn_subdir2)) {
+			ret = PTR_ERR(kn_subdir2);
+			goto out;
+		}
+
+		ret = rdtgroup_kn_set_ugid(kn_subdir2);
+		if (ret)
+			goto out;
+
+		ret = rdtgroup_add_files(kn_subdir2, RFTYPE_ASSIGN_CONFIG);
+		if (ret)
+			break;
+	}
+
+out:
+	return ret;
+}
+
 static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
 				      unsigned long fflags)
 {
 	struct kernfs_node *kn_subdir;
+	struct rdt_resource *r;
 	int ret;
 
 	kn_subdir = kernfs_create_dir(kn_info, name,
@@ -2199,8 +2243,19 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
 		return ret;
 
 	ret = rdtgroup_add_files(kn_subdir, fflags);
-	if (!ret)
-		kernfs_activate(kn_subdir);
+	if (ret)
+		return ret;
+
+	if ((fflags & RFTYPE_MON_INFO) == RFTYPE_MON_INFO) {
+		r = priv;
+		if (r->mon.mbm_cntr_assignable) {
+			ret = resctrl_mkdir_event_configs(r, kn_subdir);
+			if (ret)
+				return ret;
+		}
+	}
+
+	kernfs_activate(kn_subdir);
 
 	return ret;
 }
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index d98351663c2c..acfe07860b34 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -34,6 +34,9 @@
 /* Max event bits supported */
 #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
 
+/* Number of memory transactions that an MBM event can be configured with */
+#define NUM_MBM_TRANSACTIONS		7
+
 /* Event IDs */
 enum resctrl_event_id {
 	/* Must match value of first event below */
-- 
2.34.1


