Return-Path: <linux-kernel+bounces-746189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3F1B12407
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A31AD7BF185
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5F1254B1B;
	Fri, 25 Jul 2025 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vgCJi9WQ"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FD624EF76;
	Fri, 25 Jul 2025 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468482; cv=fail; b=QIRWCwrdFVmzL/eO6wKh4l2XwOMBHgi1WXJRbTdG+TfzobHSiW7zZIwndi67pqHRuRvalWM1earwx19j4bTussP5GP/mO8u1ovx6oadWMUFFYUtH2DrYiJYji3IwXTSMQCEiomQYuzN7NCd1iOIPMv2oRk6U2UJ0ZxXT9Aurza4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468482; c=relaxed/simple;
	bh=bJOj5WGAlOG+V/XGTBpQeDNvn3+HUiM/coBwJNHHk/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZ5rTRXp3TenoJ6PgwMwZdo/dhE/HKMdNtqYBQ46QSVDPvTXuV/NrBX08rfiMNRtLyxkIyC9t7eScSKsf0Ej11Lb6ghHUaf1kUSd0y+8vTw3V17d+XbnPOgShxwfov3tKZs4SCCltxiNW2EahHlZwNNZgoqQXavVJxQyuRoosd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vgCJi9WQ; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITkEHFA08LV1+W4zefuBjunKN3zXmJHEzCiEzPi4fXGE0ECa01VU1dbxzMgI4DQ9EL1gvfsW002WoGZfhwlRpM9C1v+jydhETrnY0ChgmEM78PD7CMrf5aEyrCi4kBogZb9loMMfthuoinKjw80dhvMHkkgN0bAwo+D9vhz0ClCRQ4jkDp/5kCwwyxY66c1TqZty1T8pYG4WvGT0jjslOc8abhYdp3eXOeVCZpAIPbc13DuPH6NNo4nHUntBGjEm7Wu7AlkYdIgZRkhG9c+s3GtOweMeCh8Sy6wXoFXwkLHMhAu+OgzjTrdvNxyBnNWXnLkdA3itGZVfLSo9lOv4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PZcWdVXtD2GxMkJG/D7s5s1pcx7fGxjFqz1goO/cNE=;
 b=B3Cjy2gttffSHqHwv0lxBxV8NK761jQ1K3zSwOO42LL4UDnqrCCRoHulZ0orqDT8l61fn0te9nWMgTzyQnVHFovvK3Hh4yBrgcpCf8ST6/MQZvhLXg0za0L5RPVs8o8X1slsCifhAvrsH1aSjaRdveavW1V/n45vBA513xvzKSzON6Wo8Z3dPL3lbRpDi2rhB9C/gpuwl7Ik42YfUrshwwNxH3CNQ3yQaWdQEtNXwXwT7U51vDKkhYsOVegPanFZctFTVRFQqAw85NlBWzjEGAWRmG1vTsGDca6KHX8SfqCOqDOxXiY6juK09Zoob+WwvZflQrgvuiaF2USh4j1siw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PZcWdVXtD2GxMkJG/D7s5s1pcx7fGxjFqz1goO/cNE=;
 b=vgCJi9WQ+eAT/4mST5Cipi2bPXqsgLCMN/Pegw95atuyshqHvtA35O+Qi7i3swghcv2+27x+DCy96a3qeIoD4ZMscHxNqsoq3jsVlmEUHyJ1x+LGkIgaH3gDmv8rflKFjG+hKy9yV7tF38DugX4PXMwakVlLmeFrecaxBIclprg=
Received: from SJ0PR03CA0066.namprd03.prod.outlook.com (2603:10b6:a03:331::11)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 18:34:35 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::c6) by SJ0PR03CA0066.outlook.office365.com
 (2603:10b6:a03:331::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Fri,
 25 Jul 2025 18:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:34:35 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:34:32 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <babu.moger@amd.com>, <tao1.su@linux.intel.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
Subject: [PATCH v16 25/34] fs/resctrl: Add event configuration directory under info/L3_MON/
Date: Fri, 25 Jul 2025 13:29:44 -0500
Message-ID: <13467b9a56bccf960974741741b4960a8f02e333.1753467772.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1753467772.git.babu.moger@amd.com>
References: <cover.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: a86835be-6658-47e8-3d4a-08ddcba9e792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fTHQ010B6CauGwEyB7aqfIP18Ym9yjlaep+/250eh4DnAm7+tRBeQql1GoTd?=
 =?us-ascii?Q?jNSsdggPwd/dZLS5/YzrCJ7EgqqUv1XsEIwf/LrRkBkjyfpl3FnidsLd3jS0?=
 =?us-ascii?Q?nuiWJG1PEOrp2dCZdWqXj9Xp3ZKfrPdFLq0dyqCBk91Eaj9z3I/AtkHuYUve?=
 =?us-ascii?Q?UDEBOZSjMgwsGd4FmgnPj6x+ATQ8T9nSfaWIAdSzFIeE1oE5onxSSl/5ZjbD?=
 =?us-ascii?Q?5Ueh97d1RCQSHDyfY0m+FGe6AvDZ3PC8x4OSV0iF58j0LQXmjSXm2n+bif5L?=
 =?us-ascii?Q?p1SgRu3MC/tV0UU70u3Pc0DS8BqNgMB0FjD1WK4WQ+H+PtGq9oux1fgrOCTs?=
 =?us-ascii?Q?ZuUyJOTBAaLNo57kmd/Ahh4xBChbn6o1Px7++hYP7KAN5jxH0RRvXIOva64x?=
 =?us-ascii?Q?8XRMlW943AlYtv4l0aqoYoVn17EGSCCwvXL4bhgy1Aj7QT1Z27SGxDz7TN8F?=
 =?us-ascii?Q?OzJzBUns2JgGnIQZy1ErLKDw7dOM8SZD6hZCi613rQj2/ieIYs8SDMmRy7Ud?=
 =?us-ascii?Q?3aJ9C4IZI01s4PLCpxI9hxjhGq6XL9bFwqzE9OiSIqfju2u3rp0yDj+LMSqm?=
 =?us-ascii?Q?Q/nCfy4Qm9Nl3SB6+ENk3taTjz4kPLxcd9SLZ9QJm2zfSZgnVuK1ckdaG6Yn?=
 =?us-ascii?Q?uFcRs6V7EHRs8qvCXoWXDrkBf/EQV7DpxxvH25P4mCHbcI8fpNqJSQjx87bn?=
 =?us-ascii?Q?FNbs6eyLYnOTwFKLdM820/yWG375VJNMFemOftko9LqUxPhZPWg7cVCbg+mG?=
 =?us-ascii?Q?g4Nd3lL7/6FGuXokUjWAFAfoEy2szlwSBnCh88lZdRVO/xpsWV7CR/LjzpK7?=
 =?us-ascii?Q?hfBsCxriVBQrvH+1exe89x6YdwihwpEzshZrDn2RsxJz7Tih2i3WzpqK4l9E?=
 =?us-ascii?Q?XTl3Jesla8G2dOaTW9pVdk+uER29oX77Tj8N1srCuvhEvxm3+fj4et71Kxgo?=
 =?us-ascii?Q?tU3/u6urtLHp0fsPHf3n+T42p1/E0Ap+pSkAltXkur5Q5wemCNRCMrXDsAGS?=
 =?us-ascii?Q?3pG1NBbjZdoRia6Ggobof+75ltbROHx1H1mnpFgfH/eIhVq2nCxIdby41aRN?=
 =?us-ascii?Q?32NPJJFDyTJNMMZclpHamSu7UindG69d9wcYKdjGYUGKzbpt+cdHY8VJQNGA?=
 =?us-ascii?Q?juQnxGyCK+RSra9sBOKpic6TFCPwKxIPzDBcmTIxoRP14DL8IjttH7+3k/5o?=
 =?us-ascii?Q?OL7ifqNuKG+K9qk4XluKK/oXnobfObIAIFOMW+V4Xy07WGgld+8EShZp3tiy?=
 =?us-ascii?Q?IHJXo85N6Qm/1iAUATBp8ZId6RbZy/yOAtS8cUOGPfnaJ1cFEIaI0lZrUDgA?=
 =?us-ascii?Q?FI2FFTzBDCoYPaPA1GalAVn3op1H6vVTW3VI9dsvk5e1KEjBEBtclfuA93sN?=
 =?us-ascii?Q?Vt66XN8kP8X8ohqngerpj26rpEOYHItqyEL4Gftiwk8efCnodreer/qLU0wc?=
 =?us-ascii?Q?ENJiiS1uVpy+cvzPfV+WDmaVQt8C9uOPwzLvw0VoO8J71+ynn/EpCWwbgrLN?=
 =?us-ascii?Q?fTuRrXuXVw5XjqIEUOirvC4U2OMXZiqaCtCx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:34:35.0636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a86835be-6658-47e8-3d4a-08ddcba9e792
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196

When "mbm_event" counter assignment mode is supported the
/sys/fs/resctrl/info/L3_MON/event_configs directory contains a
sub-directory for each MBM event that can be assigned to a counter.
The MBM event sub-directory contains a file named "event_filter" that
is used to view and modify which memory transactions the MBM event is
configured with.

Create /sys/fs/resctrl/info/L3_MON/event_configs directory on resctrl
mount and pre-populate it with directories for the two existing MBM events:
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
 Documentation/filesystems/resctrl.rst | 32 +++++++++++++++
 fs/resctrl/internal.h                 |  6 +++
 fs/resctrl/monitor.c                  | 24 +++++++++++
 fs/resctrl/rdtgroup.c                 | 58 ++++++++++++++++++++++++++-
 4 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 4c24c5f3f4c1..3dfc177f9792 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -310,6 +310,38 @@ with the following files:
 	  # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
 	  0=30;1=30
 
+"event_configs":
+	Directory that exists when "mbm_event" counter assignment mode is supported.
+	Contains sub-directory for each MBM event that can be assigned to a counter.
+
+	Two MBM events are supported by default: mbm_local_bytes and mbm_total_bytes.
+	Each MBM event's sub-directory contains a file named "event_filter" that is
+	used to view and modify which memory transactions the MBM event is configured
+	with.
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
index 693268bcbad2..e082d8718199 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -252,6 +252,8 @@ struct mbm_transaction {
 
 #define RFTYPE_DEBUG			BIT(10)
 
+#define RFTYPE_ASSIGN_CONFIG		BIT(11)
+
 #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
 
 #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
@@ -408,6 +410,10 @@ void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdt
 int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
 		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
 
+void *rdt_kn_parent_priv(struct kernfs_node *kn);
+
+int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 16bcfeeb89e6..fa5f63126682 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -929,6 +929,29 @@ struct mbm_transaction mbm_transactions[NUM_MBM_TRANSACTIONS] = {
 	{"dirty_victim_writes_all", DIRTY_VICTIMS_TO_ALL_MEM},
 };
 
+int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
+{
+	struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
+	bool sep = false;
+	int i;
+
+	mutex_lock(&rdtgroup_mutex);
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
+	mutex_unlock(&rdtgroup_mutex);
+
+	return 0;
+}
+
 /**
  * resctrl_mon_resource_init() - Initialise global monitoring structures.
  *
@@ -982,6 +1005,7 @@ int resctrl_mon_resource_init(void)
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		resctrl_file_fflags_init("available_mbm_cntrs",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
+		resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
 	}
 
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 15d10c346307..11fc8e362ead 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -975,7 +975,7 @@ static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
 	return 0;
 }
 
-static void *rdt_kn_parent_priv(struct kernfs_node *kn)
+void *rdt_kn_parent_priv(struct kernfs_node *kn)
 {
 	/*
 	 * The parent pointer is only valid within RCU section since it can be
@@ -2019,6 +2019,12 @@ static struct rftype res_common_files[] = {
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
@@ -2279,10 +2285,48 @@ int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
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
@@ -2295,6 +2339,18 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
 		return ret;
 
 	ret = rdtgroup_add_files(kn_subdir, fflags);
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
 	if (!ret)
 		kernfs_activate(kn_subdir);
 
-- 
2.34.1


