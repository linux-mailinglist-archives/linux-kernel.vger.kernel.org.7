Return-Path: <linux-kernel+bounces-722450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E91EAFDAE1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284BD1899E30
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED2E268C55;
	Tue,  8 Jul 2025 22:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R1VhKkar"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292DC265282;
	Tue,  8 Jul 2025 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013173; cv=fail; b=DZlJFRZ+d+iWOB1dR4Nc3/KkpKWvv2DaiOuXOK1hBNHPUMvfi1fUdAiIpTrInT/AoCmOShHXjfr7ig3pA/C6GXsAzihhXoPlQpOMBmZ4pDKpbwA6fDz6rTEgTCtrgw4ghyHeZ3T3LLubddAGAV/uPy2rbk74WI3AUZmJEb36MAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013173; c=relaxed/simple;
	bh=bRIOPl6JSGUYT8I+UKLAiPKFid0DqFZNamlvPJPLaIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxDorpoXvU2/1bu73YHM+Cv0K9wsrl72RA61Vriq/OPFyAD/K49kiu+VP47T/0dWJ36Q5ZGhCy+g9MW4MnWUiApWNIMwpZDWCovV6tzZ1t4GEyK1pohxY6csSW6osaHOIiBP869CsCAYdI67soBDl+hiE3ajkPbZ5GCkL+1HWzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R1VhKkar; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4KrJ1Qs4uMRPVW0IwTOGplqS4T9Jr0/CRkkTF1qCG42ozT3RuS0Ejnldb2GgMXPLNxLfC1qlP0Vu400po1njC1qTaVu5foiQIMNWitnqIGOpJIei3ShY5RN796Tk48MASQU/H22F9fc+YBuu905ROk3KBNusZo2jn3mdogV/mzfjktUpFqqab51AJ+FouReQqbVGxRbdM8mY3ahcyNR1MFUZ500xaYDulN1w7vSXYuskDMqCHfQRsqZ/12CQejeMUvIq+vZuS4/yGeFZRiRoc55DnF3FvHmXfO0zxMYzMy9XQH7VXNgghlcOU4FTPxAaGjVMyaGHGmSU1hIvYLeIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kx9XuTFI1CdYTzztYGC7zNYfz8pXBNVa99xHwLrJI+w=;
 b=EIWdkoEba/YOqzcpy1A7Ei13B8/AoQMURU3+WKuk1R4o3OcD9UfsZN5qwLVuhs/0g3sJt/FXWT18wWEGMiNmH0SQq0QVeBi+EPYD0g3F1XCLFANQHgHRYyshZ7/sApivZfhNGCtaRX6bDM21BkCoZ+AlSK7aT5BZdTjCXPom7acxAdtJize7osXLDtG5/gexRAYzx1jqu32FeEeWbFfvM3Mn+y59RJCY7JgfgFqQikvCX7OBuI/Cums1hw48otFtduWFdoleQjuON5mZ+XRIankb0cvBCphqHZMJhctn6N7ayQCMv1gLg7QMndyfs8jijukVc4h8TwIs09igZzu+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kx9XuTFI1CdYTzztYGC7zNYfz8pXBNVa99xHwLrJI+w=;
 b=R1VhKkarlgcff02NwdoPCvE7Y+FPKs56umBc5m1QN8Q57AVJr4261ktao5ckUS0dDzltMxiFMYOLVEtfKNwCCS9xeXUVyWSHEpMD0WRAIX3EySgS4fQW1rUXIDgmTZhjlpVLg+qPqIRVhfjHCdT4DxN0aIjn7uf0sMR0+Teu0Rg=
Received: from MW4PR04CA0193.namprd04.prod.outlook.com (2603:10b6:303:86::18)
 by DS5PPF7671D5CC0.namprd12.prod.outlook.com (2603:10b6:f:fc00::653) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 22:19:28 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::e5) by MW4PR04CA0193.outlook.office365.com
 (2603:10b6:303:86::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 22:19:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Tue, 8 Jul 2025 22:19:27 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:19:25 -0500
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
Subject: [PATCH v15 10/34] fs/resctrl: Introduce the interface to display monitoring modes
Date: Tue, 8 Jul 2025 17:17:19 -0500
Message-ID: <5a819dc9d57feda5cced21f67b4b1d68e5a80500.1752013061.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1752013061.git.babu.moger@amd.com>
References: <cover.1752013061.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DS5PPF7671D5CC0:EE_
X-MS-Office365-Filtering-Correlation-Id: ce55fbd3-c2b1-4cda-9618-08ddbe6d80dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CK1WMPqPElChN1OgrhT6Tw/IwDilSTlQPMZHI5qoUpewzozxJjm3wvi+Dsqx?=
 =?us-ascii?Q?uMkEvjQYHnvvkuzqO69/wR/FxDgNLWwslkTPUdZTsy/EFJOeDAlVV7913l+1?=
 =?us-ascii?Q?hm07zG8aC1Hvq4Z856qxdnmh/xVjrR1YAAD5LjfR99ZhiwUY+oN0+wMMiugJ?=
 =?us-ascii?Q?zB+lk5cscN8c9ftyYZYHXGS/su4pvClSXM1bySUlMQwONKb25qsLotnZbTYv?=
 =?us-ascii?Q?Kwg0zZSNQjByGNv+huEQZIcSoqSew0tAEuMXxxOj/IV4O5rrNj5SzTGRlVuW?=
 =?us-ascii?Q?W+MwgL3gzZ19+MLAh3os2gW1m7M82n+0k50r/x/aaJ2NgguEjpT7MunW4MYi?=
 =?us-ascii?Q?M9PGFrpW6tKcvtJbY4Wi2TcYjr4C8toKmmwD0tLtA0B6Krosr0SwJ+U4w0jV?=
 =?us-ascii?Q?H2yrKtc+P+K4OLw+WY/xTqralkiL634rMbEAFDHakt4xWf8gme0zGz9oYoJ/?=
 =?us-ascii?Q?vM3dOM8OPByIJPkUwXFyLeWDxTD6+BqtlB+GzvA8kLo5EZ55BUkvqp7VpmPD?=
 =?us-ascii?Q?GUAoHgBcqDdN6zhwPbFuLVXdqnE10W8903lTWuZqaIJXI9ZvEczD8UPgSgKK?=
 =?us-ascii?Q?OK7iD9Yr4huvHZyz/9dp4eN5ZBjugbANIhLVcOQ/Hb90HfpCX98FahwLnVGA?=
 =?us-ascii?Q?UkG96CSZcUukk/ZZ4P68za5m9eUneTR/gbrNpbjj0UTRMePv7hna1tINWoIj?=
 =?us-ascii?Q?WVNWbga5sq0YIAtWRo6YNHcvExCmyBMZGhyVPf8M2rAL1r0CFevpAW8DPExq?=
 =?us-ascii?Q?+f8U0oyHH2Km9pZGX4JygSkXnWdkfa7Dkyid6JjFBl7NqlB79k8nwZHu5+nS?=
 =?us-ascii?Q?IE2fG6u9GFoLVMpkYuazWeOZvtVFjMW9h3Gj3vtgwutf6WCfDFWOOjDmrVXL?=
 =?us-ascii?Q?Joytcpfu69Cf3p/Zfc/fcAXO/pegpyt/Mq3AcTGvLlCVr7QDSOHA3E2yoqzT?=
 =?us-ascii?Q?Sv+06KoIKYVO4KSkR9xXSO2omLI5YipT9mhzT/coK/6GAwfqSkeddl6s4hZ7?=
 =?us-ascii?Q?q42kfZyHbY3RUnZ2YH1qJ4hwTlw1dr8fZH0DAiHQj+WlKbidH57nFKQqOmSa?=
 =?us-ascii?Q?JE4KG8/1W7PYRyW8BknIAWC1WVY+exHPulgOs7TP7Qw9l95geoM9V3gNnFKy?=
 =?us-ascii?Q?JpPYArS1Erz9TGa0Ofk/UZAPe0Css2EB/3GZ0oH4o1w3bgkBAuI8XVYCcu7Z?=
 =?us-ascii?Q?SUpb6Wovcz1QUJLpcrGL8oYC+QhH+qPfexlb5a0yFqvVcum08K//1UKq2X/i?=
 =?us-ascii?Q?ev3Aooj64t9dU6dr9T3JsXuY46IgiNCesJEH2QbB0wjBxyKq9GwtmXhW47Cf?=
 =?us-ascii?Q?pO1cA9dyHJXtDu637pyNZ6ZutmFF7x+0oS62wciaqI+gzwJurX4FY41FESV/?=
 =?us-ascii?Q?mAyGrZF4cGc9fjqDE8ODa3sZSSj6u7QTMUZD/vT+DOMTjN7Y8VhyIkdgUT6i?=
 =?us-ascii?Q?q4MGQuhhhnI6eLKo/xx+BXBiBZUNdlD0MTZFFxNMHeSlu9YGA7qrKNnSlXVs?=
 =?us-ascii?Q?qToNiEFJd8BIDqTNP/7Xy+QkORQ355lmcijw7tBzJEyY8ndOkROwP9Iffw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:19:27.7855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce55fbd3-c2b1-4cda-9618-08ddbe6d80dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7671D5CC0

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


