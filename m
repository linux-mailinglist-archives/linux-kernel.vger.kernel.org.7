Return-Path: <linux-kernel+bounces-769999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67B8B275C6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4136BAA7E63
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C606A2BCF77;
	Fri, 15 Aug 2025 02:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zPu5godH"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3D129E10B;
	Fri, 15 Aug 2025 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224851; cv=fail; b=n7+/zUW8oduB9ZmpwZ3b6+V9x2+vUegCHDu/dpOOOdmqv1pkILhll6ED0KLJueL7aiVWXwMP0ASyc6Sna7ylT8HCmnp5sXdiN6AeYtGTX+M4Kbsvd8yqAyeFE+n9jBsa+FAtnTbfGie+z1sqb4erJ/tYEuvFMs6B100F7Y/L7bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224851; c=relaxed/simple;
	bh=+OxNmiXajnplqEz6pSU6D0FeTC/RXm6KAJFpScv2Qk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S06VMYaM9Osry/mVJc2b5idYsaAZYX1f/hKB5rKJxzSi/ugMr4tgU8HeAawzOR9bJYupNlUHBuR7BysowugNA2IzZIKQS0uDf+4jgbEP4N7pZkaE7gVOVaRHL43M3y7UYrvENo68cB+19oromRdsjBlI6vo7QF04tQz1eqm6JYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zPu5godH; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3IkAeW6QiIftyjgM8VJ+adTpJ4oxBNfwnzRb7Bu073/DnGrBUqBPRerJl8NDdjdLSYT+MhOhVwKtIxEqg3fDxtvMgSBjSSAtS5q3oivaV5Mqk1Lob36XgYUcRlPIj89vkwPXd05w/x8gROU0DAoXExMI8REGfpPBa5ZIs90vr7+5NCJIDBe1Y0yu60Wr13XsJTVBy459dY8MV7qxZSadjMUQjvJCeaqoHk/LKBKn3cb+9auVT9fOrVe9NQvlgVlQt7IY8DLKvBNDlWflAm6xaRuF1idinjoQs4Y1iFiC8UlTdmBsHVtA6FZ/Dg9VDlBopnfNZBZO4GKax486NvyiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDImcv22iPr1W62hyz7/EIHdNieGNcK3USQzOCq0j0A=;
 b=DqgRuT3OUjTTfUeDWo2/N4Q6Kmv14QGMlmcOYrCEuI5jge50o5s02D4qx/PpJySA7XfJwi2txG73IVFeDlsblwdydsXc02dhG2bnc3bD69iPRfw4DBXNdGd7zDWRlYpTN2KhbRKM7RRMONub6MumSmwuiYWcNgJsc+XrXi6IZzNAIlz/B8+LTtUQHHrYOG9xx4GTocVgDfaCIhKcvK99QQMgUUx8HKKMZ9Tn7Qo5GZyDC01KXXV/zSwkXJ7jFbvTDm4tHyHCh/OSuQB+LbKOFprzw8HHQ5G8OclNWNKHI4201C0GSuXyFdZXjsf4UjF+TQuSjx1xbzuQ9oASBMn80g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDImcv22iPr1W62hyz7/EIHdNieGNcK3USQzOCq0j0A=;
 b=zPu5godHPAmkq5R1a6GYItTPbsDMUZ/5ZM1Gmdt1jxVGoKIixMtIGnRX8/QxR4McobxjF99/tBm1dWOrgeHJZgsjiWMmb8LWmQS0WwQV/ltWqfxHjidzSWUDzZ5g4iMisPtF9NXz0u4KykC3qcN88zYI/vfCV0gZFq5fCEWqvJw=
Received: from SJ0PR05CA0152.namprd05.prod.outlook.com (2603:10b6:a03:339::7)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 02:27:22 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::cc) by SJ0PR05CA0152.outlook.office365.com
 (2603:10b6:a03:339::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.7 via Frontend Transport; Fri,
 15 Aug 2025 02:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:27:21 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:27:15 -0500
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
Subject: [PATCH v17 10/33] fs/resctrl: Introduce the interface to display monitoring modes
Date: Thu, 14 Aug 2025 21:25:14 -0500
Message-ID: <ccf66cf78123879e0797992249fc7a4988de2de2.1755224735.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|BY5PR12MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: 325d5783-feab-4fa5-b4f7-08dddba343c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6PNLBzY7vEOKs3pmGIxzXbF+PWMqtfcsQ02XxWym6FDVcJ3wFTqjfHw/EfV+?=
 =?us-ascii?Q?U05MlItl2aYNv7zGdIKUd9wLkmd8TfgkMfvwZuOFuuotL+p81s39jbGrRGcg?=
 =?us-ascii?Q?xbCeMLe5WiWWVxpxYClj6SVS9LPuACotCzvrf9YcgLf9LgytaOY+ezAzrdVt?=
 =?us-ascii?Q?jVPUtq2d+4maVHz91288PZIWrV6H9chGCyMNReMpwUMNDuZ/VaGRd/XAUGkV?=
 =?us-ascii?Q?L4eAiaxqJQAX5+CZzYl8B9nos+MWfQQLJgGE4GDMSGpopAbIkFKZLHi5VhDT?=
 =?us-ascii?Q?6K40GxghgU3WjiwK6tPZ6wfNYxZfAXhi5NIMCToc6LyLPxCD1/VDwYYnY5pv?=
 =?us-ascii?Q?frh48RJERINUJQaTFuf3r+3s5kDzuzJ/htd89TtaXJlpsgVHoywSezA8B5Ws?=
 =?us-ascii?Q?PGvPeIPUYEtEdEdcoeUu2PVi1UqdFjQ158TA61VpUs9Kd67+qlQi6w6HGk7C?=
 =?us-ascii?Q?1O7nPZ9dOTD++0C2boLNh0klfrtYInzr2RFwFbTE10zwDch2z3H9+lkgONCq?=
 =?us-ascii?Q?bulQ+ZSeJOMvAmGHW4AiDEzqSx6eqtNo/XujEgOPEXSFVOqbhutsCpQUUjkH?=
 =?us-ascii?Q?5owHHm+oO5Aog4BKV77UTqrAIpkpewxSZ0D9cCVL1jVeeihlpYi2NTs+g8q7?=
 =?us-ascii?Q?9/dTmT5x7ztXpdycbIzkG2GPETNaATfP0uektWjjoqTs/knKFWdQiDLaElVb?=
 =?us-ascii?Q?6IkAfY9MfPQ9AsVqZRneTh+aKl9wiknlu/oQoZR0O2tmhphyyFwDENlnpkY7?=
 =?us-ascii?Q?v2UqjV8k1PSe7wwdcdFkDV6nPJRaiVQ7jV5QYt8penVDDXk36xTsv3FUHaej?=
 =?us-ascii?Q?Dyath/7a5Wz+6XyxdJZF1XcY+nZVH/+R+LO85ilMrMLK6n2wrk6Qr6SptOWq?=
 =?us-ascii?Q?QAxTqtliGVPRT7uNjrHSthO31PhgOgujR4P838T0joqJSeU6efSZy88Dxvlq?=
 =?us-ascii?Q?KLuhV+4MdR3AkBvxsD29eMwhL4cWlCi0cOsMLeyh2tOxbg6pqcHdNf47XBe/?=
 =?us-ascii?Q?m32J6BkOUuN9DjkRC+1RMsFVaiYNGGQcBNHHzX2tnEei8Z1X5xs829hiW3ib?=
 =?us-ascii?Q?NpV+GyIJwdgg4KsK3aQn7RLqMSOl5FjWdfxDJxUJuwsO+SLeTE7G4yAZA6v0?=
 =?us-ascii?Q?7Kjq67ous/hHXDNu6qvjtJLRtfoahidSEvU6MiNJLlPAVcRRDdipY9dmindR?=
 =?us-ascii?Q?0dSz5cYpSc0pIkJW+RHTphzPUcANywq/YPNb/hUS7tLb/K493EmJ2yYMLiqP?=
 =?us-ascii?Q?mJMi2RAODdBJuy/QNuZt5Dy9EQ2fXhiHQ23mFGgyfRQUNZOQiTOVCGIVbBPY?=
 =?us-ascii?Q?s+VGNZLEXpEjDnw9z4PbHWuh2USTxiasR6aK8iQ7buimoGIqfFW4gFVQjIt9?=
 =?us-ascii?Q?0tXo5UkYHIFhd/FkxT3GAUKoIJ2Mg7hcTngFKrgWUfKySTj8u9sLYVdpBwVy?=
 =?us-ascii?Q?le3mr27ruKQi/Mk5dWJCQBYabqiQXXhsUiRgvHhP6qae2L2loQCzwFyaK8i5?=
 =?us-ascii?Q?pYrZTmKs9gsVEJu5bmI6mgGCJRZ1OHxrcWODEUaP6R7WCj6Bk+x0tyVkfw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:27:21.8061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 325d5783-feab-4fa5-b4f7-08dddba343c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052

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
---
v17: Moved resctrl_mbm_assign_mode_show() to fs/resctrl/monitor.c.
     Removed Reviewed-by tag as patch has changed.

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
 Documentation/filesystems/resctrl.rst | 31 +++++++++++++++++++++++++++
 fs/resctrl/internal.h                 |  4 ++++
 fs/resctrl/monitor.c                  | 30 ++++++++++++++++++++++++++
 fs/resctrl/rdtgroup.c                 |  9 +++++++-
 4 files changed, 73 insertions(+), 1 deletion(-)

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
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 4f315b7e9ec0..4fbc809b11a6 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -382,6 +382,10 @@ bool closid_allocated(unsigned int closid);
 
 int resctrl_find_cleanest_closid(void);
 
+void *rdt_kn_parent_priv(struct kernfs_node *kn);
+
+int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of, struct seq_file *s, void *v);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 66c8c635f4b3..379166134f5a 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -884,6 +884,36 @@ bool resctrl_is_mon_event_enabled(enum resctrl_event_id eventid)
 	       mon_event_all[eventid].enabled;
 }
 
+int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
+				 struct seq_file *s, void *v)
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
 /**
  * resctrl_mon_resource_init() - Initialise global monitoring structures.
  *
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index ca0475b75390..90bf57910aae 100644
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
@@ -1911,6 +1911,13 @@ static struct rftype res_common_files[] = {
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


