Return-Path: <linux-kernel+bounces-746173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBCCB123E8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A0277BDF21
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4E2252917;
	Fri, 25 Jul 2025 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tfuXClpH"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073EE24A07C;
	Fri, 25 Jul 2025 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468325; cv=fail; b=DgPrBxlQthbyWQBLFCPNcKmC7Lx4eQt/fMGrRLL3//N0DCiUhdkp+90Jt1xy0OXrSFX39vcYMSTgW1KCTjsRwjMZ2pqhzV9vaTsEioKX9o3qjAL/lMhqRTZI+lLoOjY3emS28lqHviRD51t6/5r/JaVP0B0+5Wz3pTXWRVjeOB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468325; c=relaxed/simple;
	bh=9YHSUEduIwImw+qDWC83mHKXtrpEE3Wez9P6AvR7ZCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6lZ3SWUPXzK5yncR5HoR5kkXOJOCCpq3+WkDuRQe6klP4TMiGx7fCGs6+OnOvTJaABsU9Tw4INz/htDQTJMHneDUaW4tI9tq2KX1biYwMpjhnrJB+5DrdeyH0ydgXtCFfxLIhqSc6VNbAm1k9MX8xwxK1AG+TQhlXIXexub0Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tfuXClpH; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlmIjAzVbK+ZDz0nC7qG6MvK60HpzwL+OYSjlUSeYW/E1ZXfURSu2APfNfnq3/onQbIjby108j1LSkyWwWi0f9czGwWGOj8lgxoivHvVnxYmb7qt1t9g6DBpUp6mBrVo5mwaFfdu9J4RSWLpYSuG295aq7hfj0lxW571sDOihRv5rIic8QWfCiStXMRlaqy4k+dLqBtsnCWXQKA4MXzr65r26yZVRGedSJTrf70REwEZcngMG/n0p12wk4Ua/7CffI/izjIbSMyML39Dpn8LnLceNkEF5nZ127KlH5drSjFTvANxqRdCqXvcIQzwcKw9mlMhgE7THH4iiiLLU9uPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSU4nIE6NyXnbk0oJSyiiisBN6Onx4mPsvHle4eYynU=;
 b=ZSIzGk/5rbyZML9C/VmSZU4KG3UnGPnQSPkefcKgf++qmTF51q+gbVVPVOzHIS3BTB6J1iJVmvuLBbfH55HEyGaLhgzXwlYMqkxPohSyelN/j+ZYMZG8s6g/GJQZi/T0+vwJP++zPFzh+zzsql891usWKiBeV33m8cosA8DpavsYs1eG/X0+LFamfEda5C+wVe4ngvG1fdOxx2/P26QT8uxb2Xmr01XW/jvrC6Uitj+laGSDtdl1cAIkyLFwZy5+fXAUDumUG/PjHezISOx/97bOwZ7G/TbvWTgPeA3okFJqpq6cuQnFkhkIQJbQC193E2vix933MmmokxI24nO1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSU4nIE6NyXnbk0oJSyiiisBN6Onx4mPsvHle4eYynU=;
 b=tfuXClpHhF7wQC0B1ji0DErcj3tJUKVRHfwLiVfEtHEl+erBeOthW3FIhh1hYTczMDCeT48bYs1+Gu6pT+3N/H00u+FQzORA1EbFRaSTXEPRh8MWwVJGAD2KAViCtNsjUuOL6tJg7C8uhqHQ3gDVjO6UTi4y63aAUyaipCCQOTU=
Received: from SA1P222CA0168.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::14)
 by IA0PR12MB8715.namprd12.prod.outlook.com (2603:10b6:208:487::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 18:32:00 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::50) by SA1P222CA0168.outlook.office365.com
 (2603:10b6:806:3c3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.24 via Frontend Transport; Fri,
 25 Jul 2025 18:32:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:32:00 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:31:55 -0500
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
Subject: [PATCH v16 10/34] fs/resctrl: Introduce the interface to display monitoring modes
Date: Fri, 25 Jul 2025 13:29:29 -0500
Message-ID: <d336be7c2776ef08534031b4c1ef1f3c6850ba2a.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|IA0PR12MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: ac155b99-9dae-4989-6fdf-08ddcba98b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TwEpSECy+m90W3QbG5i84DC5VSwS/BZQ3M1rkg0iA0yHR5Yq4lolIEs/4jey?=
 =?us-ascii?Q?Y3HBK1YjgH5a+o04JhwmE2mqoIYARW4Z//yI5FYPj4mXGEjRlJ4b+9iyT2sR?=
 =?us-ascii?Q?I/DtLEFD1NUFzu+97RDr1m8cwkxzxQhvoQb+oLWTkY6fOqxDXkDfTOKOoM4x?=
 =?us-ascii?Q?zyRoJJXNU0iZVPNSnFnVMe+r6A+qn3YWCks3r9LsdpX9AjKG0kTGtf+VFutJ?=
 =?us-ascii?Q?8XyDLJO8b6iKsW9QOaUBDhOw3+WMI3hNy2CW/ggmqyGSqbbo+XOXPjXSFHpq?=
 =?us-ascii?Q?D3HeSITIYIy709Ah0xboWn87dG6zVe7cpVwBZEKZQ///BUhPRQLdFjZ6nfe7?=
 =?us-ascii?Q?IO9t2J6gsd+cpHeq+5wxVJKuyQbhL/xQLdpegWLqKKQq1xbqXp532PrzNbVF?=
 =?us-ascii?Q?IlSiyUEJm1NCSIVhXJGP4Ffvtt3Mrj66Q5cF7EluFcwGzzB5Voxv7PqyAYXb?=
 =?us-ascii?Q?DFxz72DwioELzVLe+ZydAnquHo6hkD8NVNbxcUHhgL7NblG82p8cP8qZF6ns?=
 =?us-ascii?Q?yH14+FQeywzRT8nhXIGRuEyKyyOqUU36wS1YFByrKletjJlyQM4HR4iNkqHv?=
 =?us-ascii?Q?1tG+2eux0ETq/Ik5eU4at0QNwgJ6+OwVkLaWa1+dAweP3Y71o0twMU2y7ZIu?=
 =?us-ascii?Q?kbeEa+Urabos8hGmcaSivJKE2J1tnmCDr9e02LW1Rb7UTf5Rpd7/nHM3CShS?=
 =?us-ascii?Q?jB25zu3cGOH4LQFV4LFGNcjR7lZKnrERopymOrMcvkmWt1sXdKX9jpv6+ZKd?=
 =?us-ascii?Q?054TZE/dY5e+bicItzhbKvZwN6NgeJACHP78NqLAreyp0UgxHCyigJHJVGoc?=
 =?us-ascii?Q?iLrXGhWIu2cwvG7GVV82JSDcUeKiVG0ECSiOvSV2CKGLNKwpT7C1hx9fWHCv?=
 =?us-ascii?Q?U+ytJDngpDrnY3uHLf1Qu2+FjnqN0NEDkHAQIjUOcH/Mc59Jz+Kg9/3rGPi6?=
 =?us-ascii?Q?w3bv1wAEntQwzrULqXkE+J3KcvONwevaT1ODsJG4BKL3Bd1i09x5pEFZfrjM?=
 =?us-ascii?Q?7/fEHnRCJFp3uKSbDGBikDZ0MF8PQmzJgHSzjRYgrgoY4lgf8r2Al8dZXflI?=
 =?us-ascii?Q?0kN81LtG7tqptUTgerscG4PYtiTuIoeXubjAy8rrXak2/2BRCegnV8eBkp23?=
 =?us-ascii?Q?Bb+B+8REC/dtTxMABPWpMmfAm/oxP2Y3bStFrHySYZj65SgLGm1H3n1grMqe?=
 =?us-ascii?Q?i03Z42P4GrAkHvkuhVvwc86G/LoVt1gO7V6GYEA6DZ8DVZgtaayiEvWJ/yAH?=
 =?us-ascii?Q?CBBcJ1NeamYosLz3Mahw5suFeiVb6PXL+8/9l+h+7K+qH0WEQNBIeh+rEI4Q?=
 =?us-ascii?Q?EKG42R7s76LVAN9AIP9puVp0GcifzcSiI/Gv221jUiWHM3Fl9JYy8JwR6oyC?=
 =?us-ascii?Q?txlJOAoX2kxLuXPQDHrdk+TXfYcQ+Edq3ynlhoBWyxm0uvX09Q59JISPboeJ?=
 =?us-ascii?Q?GZYOZ+t0LjMoA0/kMFPc3LsXj1xGLh4nq4R2pNDwAtgm0dMr98xsmRUbGRuH?=
 =?us-ascii?Q?zjEMQlqklvTDVyhIxb+0N7WkoC0rBxSOFEczgl1w3z3ZTEi7SgtGWXOC7w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:32:00.5137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac155b99-9dae-4989-6fdf-08ddcba98b70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8715

Introduce the resctrl file "mbm_assign_mode" to list the supported counter
assignment modes.

The "mbm_event" counter assignment mode allows users to assign a hardware
counter to an RMID, event pair and monitor bandwidth usage as long as it is
assigned. The hardware continues to track the assigned counter until it is
explicitly unassigned by the user. Each event within a resctrl group can be
assigned independently in this mode.

On AMD systems "mbm_event" mode is backed by the ABMC (Assignable
Bandwidth Monitoring Counters) hardware feature and is enabled by default.

The "default" mode is the existing mode that works without the explicit
counter assignment, instead relying on dynamic counter assignment by
hardware that may result in hardware not dedicating a counter resulting
in monitoring data reads returning "Unavailable".

Provide an interface to display the monitor modes on the system.

$ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
[mbm_event]
default

Add IS_ENABLED(CONFIG_RESCTRL_ASSIGN_FIXED) check to support Arm64.

On x86, CONFIG_RESCTRL_ASSIGN_FIXED is not defined. On Arm64, it will be
defined when the "mbm_event" mode is supported.

Add IS_ENABLED(CONFIG_RESCTRL_ASSIGN_FIXED) check early to ensure the user
interface remains compatible with upcoming Arm64 support. IS_ENABLED()
safely evaluates to 0 when the configuration is not defined.

As a result, for MPAM, the display would be either:
[default]
or
[mbm_event]

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v16: Update with Reviewed-by tag.

v15: Minor text changes in changelog and resctrl.rst.

v14: Changed the name of the monitor mode to mbm_cntr_evt_assign based on the discussion.
     https://lore.kernel.org/lkml/7628cec8-5914-4895-8289-027e7821777e@amd.com/
     Changed the name of the mbm_assign_mode's.
     Updated resctrl.rst for mbm_event mode.
     Changed subject line to fs/resctrl.

v13: Updated the commit log with motivation for adding CONFIG_RESCTRL_ASSIGN_FIXED.
     Added fflag RFTYPE_RES_CACHE for mbm_assign_mode file.
     Updated user doc. Removed the references to "mbm_assign_control".
     Resolved the conflicts with latest FS/ARCH code restructure.

v12: Minor text update in change log and user documentation.
     Added the check CONFIG_RESCTRL_ASSIGN_FIXED to take care of arm platforms.
     This will be defined only in arm and not in x86.

v11: Renamed rdtgroup_mbm_assign_mode_show() to resctrl_mbm_assign_mode_show().
     Removed few texts in resctrl.rst about AMD specific information.
     Updated few texts.

v10: Added few more text to user documentation clarify on the default mode.

v9: Updated user documentation based on comments.

v8: Commit message update.

v7: Updated the descriptions/commit log in resctrl.rst to generic text.
    Thanks to James and Reinette.
    Rename mbm_mode to mbm_assign_mode.
    Introduced mutex lock in rdtgroup_mbm_mode_show().

v6: Added documentation for mbm_cntr_assign and legacy mode.
    Moved mbm_mode fflags initialization to static initialization.

v5: Changed interface name to mbm_mode.
    It will be always available even if ABMC feature is not supported.
    Added description in resctrl.rst about ABMC mode.
    Fixed display abmc and legacy consistantly.

v4: Fixed the checks for legacy and abmc mode. Default it ABMC.

v3: New patch to display ABMC capability.
---
 Documentation/filesystems/resctrl.rst | 31 ++++++++++++++++++++++
 fs/resctrl/rdtgroup.c                 | 37 +++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index c97fd77a107d..b692829fec5f 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -257,6 +257,37 @@ with the following files:
 	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
 	    0=0x30;1=0x30;3=0x15;4=0x15
 
+"mbm_assign_mode":
+	The supported counter assignment modes. The enclosed brackets indicate which mode
+	is enabled.
+	::
+
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+	  [mbm_event]
+	  default
+
+	"mbm_event":
+
+	mbm_event mode allows users to assign a hardware counter to an RMID, event
+	pair and monitor the bandwidth usage as long as it is assigned. The hardware
+	continues to track the assigned counter until it is explicitly unassigned by
+	the user. Each event within a resctrl group can be assigned independently.
+
+	In this mode, a monitoring event can only accumulate data while it is backed
+	by a hardware counter. Use "mbm_L3_assignments" found in each CTRL_MON and MON
+	group to specify which of the events should have a counter assigned. The number
+	of counters available is described in the "num_mbm_cntrs" file. Changing the
+	mode may cause all counters on the resource to reset.
+
+	"default":
+
+	In default mode, resctrl assumes there is a hardware counter for each
+	event within every CTRL_MON and MON group. On AMD platforms, it is
+	recommended to use the mbm_event mode, if supported, to prevent reset of MBM
+	events between reads resulting from hardware re-allocating counters. This can
+	result in misleading values or display "Unavailable" if no counter is assigned
+	to the event.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index ca0475b75390..c7ca9113a12a 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1799,6 +1799,36 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+static int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
+					struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
+	bool enabled;
+
+	mutex_lock(&rdtgroup_mutex);
+	enabled = resctrl_arch_mbm_cntr_assign_enabled(r);
+
+	if (r->mon.mbm_cntr_assignable) {
+		if (enabled)
+			seq_puts(s, "[mbm_event]\n");
+		else
+			seq_puts(s, "[default]\n");
+
+		if (!IS_ENABLED(CONFIG_RESCTRL_ASSIGN_FIXED)) {
+			if (enabled)
+				seq_puts(s, "default\n");
+			else
+				seq_puts(s, "mbm_event\n");
+		}
+	} else {
+		seq_puts(s, "[default]\n");
+	}
+
+	mutex_unlock(&rdtgroup_mutex);
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -1911,6 +1941,13 @@ static struct rftype res_common_files[] = {
 		.seq_show	= mbm_local_bytes_config_show,
 		.write		= mbm_local_bytes_config_write,
 	},
+	{
+		.name		= "mbm_assign_mode",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= resctrl_mbm_assign_mode_show,
+		.fflags		= RFTYPE_MON_INFO | RFTYPE_RES_CACHE,
+	},
 	{
 		.name		= "cpus",
 		.mode		= 0644,
-- 
2.34.1


