Return-Path: <linux-kernel+bounces-746196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39879B12422
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF1A77A5C12
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7092580E2;
	Fri, 25 Jul 2025 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="geMK4ZGU"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0F25B695;
	Fri, 25 Jul 2025 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468551; cv=fail; b=gtb/FM1whU4Q+VyZkSGtx32k0LU2bPSDQ3nYWOtnv4hqjO0rkYfOERQN/C/wef/vZPax3AvKkzxqqqECofQPd8RdnnhAwl1oAbTibiW4eKIEO+grxwkpV92+G1cmelYAQlqeqBF7kKBDmWqMBqUTz+TxOmEXzstxrAxf7Il8jPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468551; c=relaxed/simple;
	bh=nCXxbpAM9Fwy2PNK6LHBsh9tWHAueQQkb62qLnroLJM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpPjIVav2FBz96/UnL1qY+AkAro7tshR65QzY89/p3615s8qOMubCMmFfm4MjGMlm1gU1++Xbu4GeS89k/6Gl1fgfnK76yy/R6+rJDjULIb4fbN/iXpWDYdRcHIZb6duSKoQ6XenaQBmCUF8ngR08fcYiYju86mkm/6mdwTB+hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=geMK4ZGU; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXQ/EFKuS37YxXGI8QLRzaY1C4IA9E1Ob6KM2dG9YZmODkyVPUb8SpQRomAwbuAEeSXK+ZcH8+YVnobrQCEzGgKnUX6uQ5FRjpivAi0XVtYzAMdK3bjJjvRWYZeTIIvU+eEe2DuvZh4TqCldwT6d6BXrkLScI9URHlc341WdfBib0ksHxHKPpbGhIPAeTmhHJVVwM8AsTD3/PhaHHk8tiz00+o5UuEhfOgvp/EBKmChN44w/n+hO1bgZHt+2Tfn+WRCjGwrWd4Kk8fOkhausSMECXBHYL2SXra8BjGnWUBWGYgrFKBzmasJSgEfFbD6kCX7+QM763gbfo76Z0WUC+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r/bfU+ekV9CeAEoZDJbmQPsYA6u+iMLuubTfAH9u/A=;
 b=gJ954vhyE63vvyNdgEySUD34lqoYRfF8SJNxo8fGydszbUwXfUn7LqVhRp12GrXe/GPUEWYnqBDVpL6nFiDL2vfqHVvJf/XpIlNZ083u3MTO/2l1yaQiMDIAvKMU+JBkOQkbolmNCdAAVuTJMog+BKs5Vq9Ms5LECd/ETVu2RpAWQO3OcSprYGj2Anu34r+ru+WYpDUFRgIXmC6oXnwwMDM/Z5Sx8ZrPAkacSJrYDXX71q8AC8ZFE4ieLhHsZZ2BKxnvBbdYs6/xR64v8MypHLtts59ubKj92lUqKt4mnMMFUh/sL7cYuiSR/x1LEHSRuzmm8zbq9wAmvkC7cAyKGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r/bfU+ekV9CeAEoZDJbmQPsYA6u+iMLuubTfAH9u/A=;
 b=geMK4ZGUVFwPyUNXhsIieFWhXTgMGPQfr0q1esg3GamTpW1WUbeFACg2ikHhNV1fSk5HuPOfm9SPsP0g9tMOYNplcDvc2SBbJ4vPX8QML7IhRlxf/MIweFjStsTV9ROAIX6rC7Lrto8I0uza7OWnyFxoRHJ6FhNlxMs8buZDq48=
Received: from CY5PR19CA0028.namprd19.prod.outlook.com (2603:10b6:930:15::24)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 18:35:46 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::bc) by CY5PR19CA0028.outlook.office365.com
 (2603:10b6:930:15::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 18:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:35:46 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:35:43 -0500
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
Subject: [PATCH v16 32/34] fs/resctrl: Introduce the interface to switch between monitor modes
Date: Fri, 25 Jul 2025 13:29:51 -0500
Message-ID: <9f7816ff6cefbffa2a9a701d2fd3bffbd9777736.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: f12db577-8488-4497-ec85-08ddcbaa121f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?usTCTFL+i5r/A//fPfODrBKwMbMfPl4TuG3qBAnXSgJYvJLAcANkgpTznyuj?=
 =?us-ascii?Q?gOSlhLeyUlma1PSsO6mPQ+KC89AfqxsN0MNwtbNAuyNrKebyfR4bEaSZh2lO?=
 =?us-ascii?Q?OpoquRQH7jdBkioONS12JX1mtsq8Q2Cs+GL5G0pRjZx8HFz+fbJOmzqvYeZm?=
 =?us-ascii?Q?TuOsy2F2P/YYjj7KZB9n5bXlDBezX7vQQQ1VEiSqS6wrnudElzei1RTUqtU0?=
 =?us-ascii?Q?+FB22wYjSTsdrvN7Km8qC7Kw8E07L6/R3kGINpnKm8pao0TIcDIow+NI/SBI?=
 =?us-ascii?Q?Neh7BGjWzFwFehrZC0a8cb8gTB0DSBoNZ4tmEPxC5ToDUNVHzaSyypUv1eDK?=
 =?us-ascii?Q?fiFfVkbBOO6O3H41lY6UHkRhJo9zu7a2mfURMBvyxbYLICigTxWAI9l8fjJZ?=
 =?us-ascii?Q?ac8RK1LnND6nGtlkb7KpiKgfDE2l2GgbhxxTi6wO6DwZ4ba02D/PIFj6kH8w?=
 =?us-ascii?Q?+yMsLwq3nB4urgNdws09fw080JXp/VmM2rpVb9FuxqBMCLuoqKqiwVZppePI?=
 =?us-ascii?Q?tMWrmPwQgntVlu8nGJaAN2yRex3jXo/njneZNiyLKyetyRxy/geiye+SwHH0?=
 =?us-ascii?Q?jrpfZcf0bJIsZ8pgOECBN83oqUTF9DwtLnt4X3GTQi2bZzCX0JNmgfspm/1o?=
 =?us-ascii?Q?K6zT87kPyuFhdUUM1KgF6Ohahi48hjzOrX7Z01VUgWbGLboh15APWB4HrXeL?=
 =?us-ascii?Q?c1DYsLrRdIw9yyUVdgFrflCYIbbBvD/BIJnJRJIUJP0Ka0OqyXicgSKBTmXz?=
 =?us-ascii?Q?ScMch8HVi+fizJ5kTpyX3XHdRSn+j1wepgiqRRoAQsCuzSnsrCVGaLoOGdIn?=
 =?us-ascii?Q?RNPnZzKt96MaL4c/aKeBncRumqWr0GhrXycDk/WxceZf4f63+ZPjUmbH0qQg?=
 =?us-ascii?Q?sAv2IhHFPCZMh8y32PAuvblzQH41I28wktNlt0WVESf9SkXt0ogp2O2M2uys?=
 =?us-ascii?Q?PgUgQ3SOvn12fLtBlN4ii+OoyEDRJkaKN7d4NrojxhICMi77IuOoq0kJXatK?=
 =?us-ascii?Q?enr2PcbrWsGyGcNQyGrpOsCdckL/+4O3e+n42hzzVi7X6qd7b53iV7BHM2R6?=
 =?us-ascii?Q?IDDdlIJz+oQ/B21qQl3CvdhQeoSzMVg5pmtrt4UF0oXbKcoPeFmor/jN8Yq9?=
 =?us-ascii?Q?CftrauxdT4LpdRD+r1E6MwlD/Vs8f6iiCehc3PeQURHCI16iRhb3mcB/TlLZ?=
 =?us-ascii?Q?4w6cPwwD/Yg+/RS5/xvX0R99aHkqcwVEBxdYwAh/1D7vLIX3vsQlnrQxvpAD?=
 =?us-ascii?Q?UX3O7Jr6dDKgu7LGeV4KGiskBvjqoR4+iPhKkd3nRV6p7hVvVjxE4fnWo/RF?=
 =?us-ascii?Q?m/bL7hqyIQM2U006PMWOKHyXJ7hva08ap6xIdHv/cbv0zqgJf9h9QHFOMfnQ?=
 =?us-ascii?Q?ei4kc/rIA0mbeaObPpsAdBJ65QqZIcfAzNqklLQ8KM3K6Aytl8tAZ6PwQiY+?=
 =?us-ascii?Q?iUR0b+bEvNHv8Dbw7INWRV+tp7gXK13kWCgIrnnbin/2KVCCTWswRMgKC8+1?=
 =?us-ascii?Q?CvPH6E4H5k7u2lfFeO3oy1hRTREEV4lQeeiwca4rAAZTTsyRWSiU7W+ahQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:35:46.4564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f12db577-8488-4497-ec85-08ddcbaa121f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160

Resctrl subsystem can support two monitoring modes, "mbm_event" or
"default". In mbm_event mode, monitoring event can only accumulate data
while it is backed by a hardware counter. In "default" mode, resctrl
assumes there is a hardware counter for each event within every CTRL_MON
and MON group.

Introduce mbm_assign_mode resctrl file to switch between mbm_event and
default modes.

Example:
To list the MBM monitor modes supported:
$ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
[mbm_event]
default

To enable the "mbm_event" counter assignment mode:
$ echo "mbm_event" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode

To enable the "default" monitoring mode:
$ echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode

MBM event counters are automatically reset as part of changing the mode.
Clear both architectural and non-architectural event states to prevent
overflow conditions during the next event read. Also clear assignable
counter configuration on all the domains.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v16: Minor changelog update.
     Minor update in resctrl.rst.
     Updated resctrl_bmec_files_show() to pass NULL for kn_fs_node.

v15: Minor changelog update.
     Minir user do resctrl.rst update.
     Fixed stray hunks.

v14: Updated the changelog to reflect the change in monitor mode naming.
     Added the call resctrl_bmec_files_show() to enable/disable files
     related to BMEC.
     Added resctrl_set_mon_evt_cfg() to reset event configuration values
     when mode is changes.

v13: Resolved the conflicts due to FS/ARCH restructure.
     Introduced the new resctrl_init_evt_configuration() to initialize
     the event modes and configuration values.
     Added the call to resctrl_bmec_files_show() hide/show BMEC related
     files.

v12: Fixed the documentation for a consistency.
     Introduced mbm_cntr_free_all() and resctrl_reset_rmid_all() to clear
     counters and non-architectural states when monitor mode is changed.
     https://lore.kernel.org/lkml/b60b4f72-6245-46db-a126-428fb13b6310@intel.com/

v11: Changed the name of the function rdtgroup_mbm_assign_mode_write() to
     resctrl_mbm_assign_mode_write().
     Rewrote the commit message with context.
     Added few more details in resctrl.rst about mbm_cntr_assign mode.
     Re-arranged the text in resctrl.rst file.

v10: The call mbm_cntr_reset() has been moved to earlier patch.
     Minor documentation update.

v9: Fixed extra spaces in user documentation.
    Fixed problem changing the mode to mbm_cntr_assign mode when it is
    not supported. Added extra checks to detect if systems supports it.
    Used the rdtgroup_cntr_id_init to initialize cntr_id.

v8: Reset the internal counters after mbm_cntr_assign mode is changed.
    Renamed rdtgroup_mbm_cntr_reset() to mbm_cntr_reset()
    Updated the documentation to make text generic.

v7: Changed the interface name to mbm_assign_mode.
    Removed the references of ABMC.
    Added the changes to reset global and domain bitmaps.
    Added the changes to reset rmid.

v6: Changed the mode name to mbm_cntr_assign.
    Moved all the FS related code here.
    Added changes to reset mbm_cntr_map and resctrl group counters.

v5: Change log and mode description text correction.

v4: Minor commit text changes. Keep the default to ABMC when supported.
    Fixed comments to reflect changed interface "mbm_mode".

v3: New patch to address the review comments from upstream.
---
 Documentation/filesystems/resctrl.rst | 22 +++++++-
 fs/resctrl/internal.h                 |  2 +
 fs/resctrl/monitor.c                  | 27 ++++++++++
 fs/resctrl/rdtgroup.c                 | 72 ++++++++++++++++++++++++++-
 4 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 0c8701103214..35bd58af5c61 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -259,7 +259,8 @@ with the following files:
 
 "mbm_assign_mode":
 	The supported counter assignment modes. The enclosed brackets indicate which mode
-	is enabled.
+	is enabled. The MBM events associated with counters may reset when "mbm_assign_mode"
+	is changed.
 	::
 
 	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
@@ -279,6 +280,15 @@ with the following files:
 	of counters available is described in the "num_mbm_cntrs" file. Changing the
 	mode may cause all counters on the resource to reset.
 
+	Moving to mbm_event counter assignment mode requires users to assign the counters
+	to the events. Otherwise, the MBM event counters will return 'Unassigned' when read.
+
+	The mode is beneficial for AMD platforms that support more CTRL_MON
+	and MON groups than available hardware counters. By default, this
+	feature is enabled on AMD platforms with the ABMC (Assignable Bandwidth
+	Monitoring Counters) capability, ensuring counters remain assigned even
+	when the corresponding RMID is not actively used by any processor.
+
 	"default":
 
 	In default mode, resctrl assumes there is a hardware counter for each
@@ -288,6 +298,16 @@ with the following files:
 	result in misleading values or display "Unavailable" if no counter is assigned
 	to the event.
 
+	* To enable "mbm_event" counter assignment mode:
+	  ::
+
+	    # echo "mbm_event" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+
+	* To enable "default" monitoring mode:
+	  ::
+
+	    # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+
 "num_mbm_cntrs":
 	The maximum number of counters (total of available and assigned counters) in
 	each domain when the system supports mbm_event mode.
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 1350fc273258..c666aaf7858f 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -410,6 +410,8 @@ void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdt
 int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
 		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
 void resctrl_update_cntr_allrdtgrp(struct mon_evt *mevt);
+void resctrl_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d);
+void mbm_cntr_free_all(struct rdt_resource *r, struct rdt_mon_domain *d);
 
 void *rdt_kn_parent_priv(struct kernfs_node *kn);
 
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 1e4f8e3bedc6..a4411a128431 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1093,6 +1093,33 @@ void resctrl_mon_resource_exit(void)
 	dom_data_exit(r);
 }
 
+/*
+ * mbm_cntr_free_all() - Clear all the counter ID configuration details in the
+ *			 domain @d. Called when mbm_assign_mode is changed.
+ */
+void mbm_cntr_free_all(struct rdt_resource *r, struct rdt_mon_domain *d)
+{
+	memset(d->cntr_cfg, 0, sizeof(*d->cntr_cfg) * r->mon.num_mbm_cntrs);
+}
+
+/*
+ * resctrl_reset_rmid_all() - Reset all non-architecture states for all the
+ *			      supported RMIDs.
+ */
+void resctrl_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d)
+{
+	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
+	enum resctrl_event_id evt;
+	int idx;
+
+	for_each_mbm_event_id(evt) {
+		if (!resctrl_is_mon_event_enabled(evt))
+			continue;
+		idx = MBM_STATE_IDX(evt);
+		memset(d->mbm_states[idx], 0, sizeof(*d->mbm_states[0]) * idx_limit);
+	}
+}
+
 /*
  * rdtgroup_assign_cntr() - Assign/unassign the counter ID for the event, RMID
  * pair in the domain.
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 1aeac350774d..68ba08e95a54 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1865,6 +1865,75 @@ static int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of,
+					     char *buf, size_t nbytes, loff_t off)
+{
+	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
+	struct rdt_mon_domain *d;
+	int ret = 0;
+	bool enable;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+
+	buf[nbytes - 1] = '\0';
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	if (!strcmp(buf, "default")) {
+		enable = 0;
+	} else if (!strcmp(buf, "mbm_event")) {
+		if (r->mon.mbm_cntr_assignable) {
+			enable = 1;
+		} else {
+			ret = -EINVAL;
+			rdt_last_cmd_puts("mbm_event mode is not supported\n");
+			goto out_unlock;
+		}
+	} else {
+		ret = -EINVAL;
+		rdt_last_cmd_puts("Unsupported assign mode\n");
+		goto out_unlock;
+	}
+
+	if (enable != resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		ret = resctrl_arch_mbm_cntr_assign_set(r, enable);
+		if (ret)
+			goto out_unlock;
+
+		/* Update the visibility of BMEC related files */
+		resctrl_bmec_files_show(r, NULL, !enable);
+
+		/*
+		 * Initialize the default memory transaction values for
+		 * total and local events.
+		 */
+		if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
+			mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg = MAX_EVT_CONFIG_BITS;
+		if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
+			mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg = READS_TO_LOCAL_MEM |
+									   READS_TO_LOCAL_S_MEM |
+									   NON_TEMP_WRITE_TO_LOCAL_MEM;
+		/*
+		 * Reset all the non-achitectural RMID state and assignable counters.
+		 */
+		list_for_each_entry(d, &r->mon_domains, hdr.list) {
+			mbm_cntr_free_all(r, d);
+			resctrl_reset_rmid_all(r, d);
+		}
+	}
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
 static int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of,
 				      struct seq_file *s, void *v)
 {
@@ -2207,9 +2276,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "mbm_assign_mode",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= resctrl_mbm_assign_mode_show,
+		.write		= resctrl_mbm_assign_mode_write,
 		.fflags		= RFTYPE_MON_INFO | RFTYPE_RES_CACHE,
 	},
 	{
-- 
2.34.1


