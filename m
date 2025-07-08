Return-Path: <linux-kernel+bounces-722473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611C4AFDB11
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5F4566EED
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED8C2641EA;
	Tue,  8 Jul 2025 22:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dG6wTMYA"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C2C262FD3;
	Tue,  8 Jul 2025 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013381; cv=fail; b=NLdvZgO3yTGTGULpTi0u2XUOcBWMZwQJuZ5+Qo8n8R/Z4pRtuqGXaCVxRCYpUouTz8S66a4ExoUfGPa9JD0EBcyOXQQe31MySYgSzAxpw+jSnp0q2X+hJFkWInNx176EAnwc6N8VYCbRXIsPenVyQUV2y3BqaY0KXEKkrg3bDWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013381; c=relaxed/simple;
	bh=ianiL8diYdhEDTU3lBSKmy2lQCH/XdO/s5LPUjFBU2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFuZkrPZI/dVodlA77cCPf9z1OqYirIHPtWnlswsRYvmGY22ZCI+MvC6t9rWpZ5QWRxWWiyeG3U7EtkQtRjle0pT3cVfMjOq1vuIKn1nRdeJb6v3LhnsM8SqBLAdlU+z8GTPtjbh8XR5fN7tAu9dl6c7uCGX2cfPmjJw8/Mh8Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dG6wTMYA; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txSZBxE0NBmJYB8P5wlopUTW6LseuvjEOcPlMCL1lQ/TXjr4so+Mm/pfV8waO7TufjcVJ5RAPzvblwi+yt0zGpOhHs2F9fhUrdlkCnI+gd362WhE0qHWqnyRBIZqQlaZrSHLStettTxxHsHpv1s1X8EF0q4ZurWW5H7+1F8Ffjc7cXNPGwCkCd0+Rw8ftQSux5fxf2kS44rF/ki6xeLh4SbI/Hmqy1weH8vCjVvekX+x7jp1yPE23gUdB3VuqU2N5R3oNO/wxPZm4a5l159ghlnspqjYCUImlong54rYk/P+dxsfRRVuqQmphylWfpcf84eg+ASthOjvLWQXhNzlFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYRH0jdIhCQDvwxNR6GR2n7FU5GL19EK/iXD6xLvb1k=;
 b=dSL0XeFbM0Wcmni36yNZ8XHpk2XliqAGKu6tARB08wJJEvvHFKvlL4WmOB6vrBnfZ3W+kZujph5Wr8wiIMb5n2Q/a/BjsGILaYAFndmYSRjUuAl97KRCSL3SZRq6Ik69aHnqW96/TegWwQNDJwpoDXyRvSnkKmLT+CwO4N/PD6mwEKiHjdH1cdcLE8nAU9jKY+2VtT58qkFQdY3vmRgwn4hgxHPgauPfkdEaWKaQUFir63Gn2oCO9flPUE1kj7WduaZjeR9RJsEJAq3U3ixEDu0JoGPynVk07d8pD9pqth7hpS2UGpPhMAMFLxft32shPWOHBO8URWBzGmIgGLCUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYRH0jdIhCQDvwxNR6GR2n7FU5GL19EK/iXD6xLvb1k=;
 b=dG6wTMYA0n/GEmO+dvCBBUqAeSyjB4ISmHIek0k3yNQkvX3goVnYgxu7Stf3OjFsVUW22p8ywHbpCgELOhhMDPTDoTVvaMs68qu2kKoKuCTAbYGFVP2CUMEj0WSckV4SIgrYc70+qCPR31JUXLb3gCovazbLbZDJlcC+dZRrTvs=
Received: from BN8PR04CA0041.namprd04.prod.outlook.com (2603:10b6:408:d4::15)
 by SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Tue, 8 Jul
 2025 22:22:52 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::cc) by BN8PR04CA0041.outlook.office365.com
 (2603:10b6:408:d4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 22:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:22:51 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:22:45 -0500
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
Subject: [PATCH v15 33/34] fs/resctrl: Introduce the interface to switch between monitor modes
Date: Tue, 8 Jul 2025 17:17:42 -0500
Message-ID: <7869219493bb4cc5626da704c4f8f107fe7c8f69.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|SJ2PR12MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f71eb7-8d74-4a53-d859-08ddbe6dfa5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BY/mO6egkNBjw7Ufocnt+I60vRYCs7BX4WntknopmYqIIGEtPocQ3Zo+fb8f?=
 =?us-ascii?Q?EZBLEBxw0kqCgw0KdAwl9iUQfVxoNDAWpdW0DjSuTJWt9UDExwuxI85zpmyz?=
 =?us-ascii?Q?wq6AXt0wZslmcj0n4py/wmy6M4qWrMhUy3hf6TZYMq4cSUmvOcAR4JCWcPIa?=
 =?us-ascii?Q?jbh+u+2+pFnaRPRyqKb0VUQlyO2nmzOdnWYlcDJeaxiXOIJztTtZNJjyLZPJ?=
 =?us-ascii?Q?KhO0suJVF+nRm8w2nyrlBRtuTe0N10OFj7gwX8suIsuuhh5f2B2zhro9NUdv?=
 =?us-ascii?Q?JZCfeHl46rw21tQaqZ6wWI+1Oz8Y0JQvnBnvH+gBTSyNPT5mcacR1VNPD9ov?=
 =?us-ascii?Q?PAHtrZsjuHZyb6NI0lsGKe1rAcw7bYtvDesMcVQqIVWLuF0tjfcGHKjx+hZn?=
 =?us-ascii?Q?NNqjPVPuGoqpngYaozhP7kzuq0MUWIBmYzCmCTqe4fgF/huR4uJPDfviIYVM?=
 =?us-ascii?Q?dP1ChgF2pHe9eF/iGPYhu0JDvuPe7hApcBNxnBZYW//RpIovfwpSxQ2SQus2?=
 =?us-ascii?Q?TSS1CZs9MGEgAUms9FiVb/BRcBnTG3tboaFdsPofn9Ye6j19vBojV3RJwubd?=
 =?us-ascii?Q?K3yc3rIUahRGSmAU+B4U6OTAFbm02tjiPwhIkjA7Kl9v2srn/NS7MQ8Bs+Dw?=
 =?us-ascii?Q?BqJfKQ9SKRqldFeOfTPVEI17bCQ1B93Qt3AIl05DvfDIF6I1kyn45k4zalzr?=
 =?us-ascii?Q?xIaCeQts+zK5umSxT/2C9IQaFl5VlR5N6zJKp3b+UwS4heTP5Fv8MvgSLbWa?=
 =?us-ascii?Q?VMXLtSM89nCe+GdnxO52SlM4ktVOgwvvnEC4vtDyUnvObzQ+1lj3O8+FgQaZ?=
 =?us-ascii?Q?xwG3+Y/O5y9CI+AchpPbAS0ja2YQwo+/WflQrm2a/SQz7MciO1de1qG0bQvk?=
 =?us-ascii?Q?mII28LQkj90EUNGC/pOcrS+2A+i/9ITbj6dmdEWQUhHQRU/YkXIyNARDFygq?=
 =?us-ascii?Q?1Z7ZMiVuLv3+B9pnqs9B9+KmgtmTAXnYL+JChuyt/jilbZlIN7tzfp5OIkLp?=
 =?us-ascii?Q?A7iFkKHzftVkatx7zRzXExcoWYDBYFDYmFPYICCVbzSxePABFoZzRnj4lqGS?=
 =?us-ascii?Q?FdF8+jTvr/ey05zw0MfnRWFtfhtabiZail7KsicsICimLWrALypaAyMF5pRy?=
 =?us-ascii?Q?pfPMRnky+CwcdUo65++Q3KeO2onI/WhwA5DHQ4dSwS0J1YtCn1qYQE9BhNHR?=
 =?us-ascii?Q?AYrueCEh97R1QuIYhqfJaj2BOCUdOaDBnY1AUVDdMlsvp75K9qGjM6bAJO/t?=
 =?us-ascii?Q?NqN1cUguLJphPLHx0DBB4wwBs6E8AXbk/v1ebDZAQvS0N+/5ly3Es0j9NFBJ?=
 =?us-ascii?Q?MT6AJu7nbdVnlhay6EZ6mzdjOz5eF15o9lXnjBFYfXDEKATU5AztsnE11Nt/?=
 =?us-ascii?Q?wQtYmxIrLC8jtMI8I2wiEhkdleziottOF+FIbx03TK8f3f9QTCfi7sz17Wjf?=
 =?us-ascii?Q?Ki1D849SNxTGnCAVi4+xUftvUZuxLaam3BrdsXhfnnSCxrlzX/ZEX9gB4x1x?=
 =?us-ascii?Q?CFBQXB+43wpryTJyri27jE5rWJR6INc3IXyfdl+9z8XihKQqvnNrlPoThw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:22:51.7274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f71eb7-8d74-4a53-d859-08ddbe6dfa5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242

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

To enable the "mbm_event" monitoring mode:
$ echo "mbm_event" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode

To enable the "default" monitoring mode:
$ echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode

MBM event counters are automatically reset as part of changing the mode.
Clear both architectural and non-architectural event states to prevent
overflow conditions during the next event read. Also clear assignable
counter configuration on all the domains.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
index 2b2acb55d8b1..b8a4dbe061ea 100644
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
 
+	* To enable "mbm_event" monitoring mode:
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
index 9881674909f2..6eb8cce03a65 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -412,6 +412,8 @@ void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdt
 int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
 		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
 void resctrl_update_cntr_allrdtgrp(struct mon_evt *mevt);
+void resctrl_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d);
+void mbm_cntr_free_all(struct rdt_resource *r, struct rdt_mon_domain *d);
 
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 61419849b257..f3d9b2ba8360 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1076,6 +1076,33 @@ static void mbm_cntr_free(struct rdt_mon_domain *d, int cntr_id)
 	memset(&d->cntr_cfg[cntr_id], 0, sizeof(*d->cntr_cfg));
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
  * rdtgroup_alloc_config_cntr() - Allocate a counter ID and configure it for the
  * event pointed to by @mevt and the resctrl group @rdtgrp within the domain @d.
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index d73057b96d1d..8a7fa1078d02 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1862,6 +1862,75 @@ static int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
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
+		resctrl_bmec_files_show(r, !enable);
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
@@ -2369,9 +2438,10 @@ static struct rftype res_common_files[] = {
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


