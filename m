Return-Path: <linux-kernel+bounces-770027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77530B275F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FCAF16EE26
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E43F2D23BF;
	Fri, 15 Aug 2025 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LZ0H9XYN"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C539E29B8E4;
	Fri, 15 Aug 2025 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225031; cv=fail; b=oBcDoVYubmzHQlokoi/+jn6JpNLYTm1qHkcoSKDZzKBdcWl3CI2AMTaBjcENrnhhtrVcQsIxjaZZUrDGFfx8zYQ09gvkoNK7LbFMGAIEg6n46Y/7vL2Bj+JjAHGkiehQwkkYUnm+M/YhRJ8G2z46CutZ6VJOyXSQuIAUMzKgpoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225031; c=relaxed/simple;
	bh=LTXvd6kse2+6nD2HviKrzRXEl7dVrirO9e2PHwdcKb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3LKreoo59FCDA1HKzlJEU4Ge0U1AboG3jMURk5jMDQauMPyNmsXiNO36jieFJGDm06E5vfAbwnLc+koBw4CgXd7IqJpgfQzfBh1o7Sgvo1eNfI0yLrM8JPmoTPPkPvjEKLtvmoS414VF05zGvhNI0GyghtsmnG03ZbkPvDcFnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LZ0H9XYN; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUyAvVWN9nEx2fmQcLAwKw8GbXxVszYPUhRRbARBjlkho2g6EFKN58UONqtzBrIdZxIx5TMgoRFRRvWfMa7mLgwAd3FSIDQW3wlLqWa0P0gIcmvy0xBBIIhYHVY8lwRT2RfYU5Ck2I6tvMTb6ud9NqeP5rrEW5Q5X96nGnwhMrU0oADTHqy6zoslchL0Bbq1Ck0LLy10ksaJXuRLR3ISSSCQp6Cj4OUi8IX68LnZle8N4XNHR+4PCHFl3xtB1/M67vVrBLuicJUzzekRRfimt3mWOfvKRdjtIPs74JX7yO41ytYktQYJDO9upwabVKeSYCxtP/OaIFbHrJQv4Y/MAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7y25FJxGbYrn+Kvwhr2z4reIzZtPWRlXoC7uz67s3E=;
 b=tnfY+pLTIggcB86/KTP5HbBzkvYNR80cXIzk99SugW/9Fg8Ob4+TgY7/hPhwWAWUio87/7ee3ZCcsD5nMDZAkN9R1ueGhqC1/tHyYcZCVXDw0kUK57SHu//vEy6Idl9pkMo6HsDoa0b0019R8Zou6b2V4nUjNWk9TRhLjo9kVuumUfmFSROa7SWawPIASf9Fq5cyPDr8vn6Eef/GPlNjHKvXR67948iXRiTpzXlkdeenEXOA83kdqzx/Dmq6qT3LZUa8XOs1lqhmVNxP3XXqBncKPZhimWQm//1gsdneHhFIMhZR7Fwjp+LcKQmJ1BWQAEBU+NBkdzEoWd4FJ0dhQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7y25FJxGbYrn+Kvwhr2z4reIzZtPWRlXoC7uz67s3E=;
 b=LZ0H9XYNMqsVh9s/ck3Mr1FN43CHySiHFSkXIy89wedScioCy4OsCxv8F9RoCTMdykZ+K2zY0dI0BJb61LaJ20TFsoQFUkVPw4bszyHEU7pF8Igj8QHBwQ7ojUNMEyAl8YY9DfpQUq5GsHzV6BuQe3dJqWmbGHJZhfohYMPx2Rw=
Received: from SJ0PR03CA0202.namprd03.prod.outlook.com (2603:10b6:a03:2ef::27)
 by CY1PR12MB9604.namprd12.prod.outlook.com (2603:10b6:930:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Fri, 15 Aug
 2025 02:30:24 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::75) by SJ0PR03CA0202.outlook.office365.com
 (2603:10b6:a03:2ef::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 02:30:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:30:24 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:30:16 -0500
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
Subject: [PATCH v17 31/33] fs/resctrl: Introduce the interface to switch between monitor modes
Date: Thu, 14 Aug 2025 21:25:35 -0500
Message-ID: <68e9c17c6439f46fb4535cb2b89b380420645db1.1755224735.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|CY1PR12MB9604:EE_
X-MS-Office365-Filtering-Correlation-Id: 198fce44-34c3-4e01-0fd9-08dddba3b077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ctGk6jdzbiVdO5sTRDYuIq/yvvVzG9AVk+6ZMBBubPow5E+Lc0vSaxFkzs9V?=
 =?us-ascii?Q?uXwEerxP5i9rBDK2GQXJRFdEw6vfTd4SsQG0WDRM7e+hDs6jJmjtfKoJGAP1?=
 =?us-ascii?Q?NTqRy8KiJBGaUjuL2mmnD73Ju2f3xCgWyEYmsBTi50wSyd/Amhwrmvp+RV0/?=
 =?us-ascii?Q?9D0x1G8jlO5jphdB132tiO3O8oJzDj/4xe8oPbhehE8NHzPEYTMXZtAKyFoi?=
 =?us-ascii?Q?pTf10YnC+EkFnw9mnUw2G5rmcOdiv0TZ2sxB+5tfsoCyruebzzDMqZDh+2ZZ?=
 =?us-ascii?Q?xTd2Ipvj/h8149JQx0+tY19rh8LwLXLFNTTBJ7eBYhlK/DgbYxkbMRQScRjD?=
 =?us-ascii?Q?9JKd78MC5pXW5zmr59ejiVuYyh0mkLVXrXd5OYYKCut+72MjOQ59QLxApwLq?=
 =?us-ascii?Q?PZotakSims0N8cQesSAWyPMdw3oi7Gq+qxPaE169wXJf3WVlgBMIj9zj6H5R?=
 =?us-ascii?Q?S4qPEJFAiJtX4UNaLlpRuF8vYG9dGhZF9+PMnm6yTCoARuZmDB43Zu23knze?=
 =?us-ascii?Q?uaiRQapA49DpEtTQSnGoM6T/biJDA/sj5W0eJlAuhtT/ExeyVyVn2wMFzrkk?=
 =?us-ascii?Q?XVehQH8Ivv7q7tvtCVZ8+j9Yu2Su5114XYTwS7Jqu8C8j8rYZL5sbvYZ24bK?=
 =?us-ascii?Q?wpE6du6ZobEI60JTj300Q9ZmXueNuL8thMZtBQyMKSoqSPsqktolPKP7+x94?=
 =?us-ascii?Q?39im0DymL+E1PgA1b0EIN2hg4ZFcWakH03BmSjgn/TeFW9qQW1Dg3EcgHAwO?=
 =?us-ascii?Q?v53kyaMgvg9WKlKhVMRXC62DHXViqhkXmZ38bzQGZ/mOIqIeCjzDUiHnj3bg?=
 =?us-ascii?Q?5zna4p5i1+2ATHZhe8sE7Mx9JrFxGGKLR+lMuiB1QT1LBRrHAzkJoJDY92b/?=
 =?us-ascii?Q?wdARj7qP+Qb338/5qV53jHlkymyKPHU55N46P3T19AdmagQ/y3kQSpc5jvUN?=
 =?us-ascii?Q?SYeFpY+y56BTo4ixjJeU+hHLdnh/MadeKuqwn3TicGtgAo19o2Rd+FTRsSq/?=
 =?us-ascii?Q?7rr2xU+swSPfvjX4U8QSuoRyXx9CgEfjJgrOfZkVddRUG4Y4lr3OCGnLX7mW?=
 =?us-ascii?Q?C49c1/+POqMpFpGhGOnQI+in/u1Np2HyVyaQcFG3vWXaUS1leCCtHhW6alf/?=
 =?us-ascii?Q?nrMLd4JBV/FJYTZJXVr21VdcqlsGmtIVMHWsSVaLgQGFGCjWqgcEp5wYGxEb?=
 =?us-ascii?Q?GKpyOym45iqHbOEGKiYiLGdnsvet6nJ/EEZP9aqZ6iSTkNDZVy8rVyDdFqLV?=
 =?us-ascii?Q?nSnRzGAEoHDRht+xvhz5terzarmkowkvPuTXw/hvak3DGi2VvzZPJEnJvWrz?=
 =?us-ascii?Q?rO5SY98HcbG/SVBZnsf8vET6GOR4usO/JNLGsbRpOqxbQ1cKsVsLTpCKtCqe?=
 =?us-ascii?Q?Z/48T/mQIQI5PxLcxIWUdvDp2F7Nee7qGllyLgUIK/G3MM7Epg1Bl/BmPMtm?=
 =?us-ascii?Q?Lr++lKDp03a7UXqgo8A/cI1MZjrzSMsOB5Y161tSDE2fpuhGMer9IBpOMucD?=
 =?us-ascii?Q?+aDMsJypaqSSccRD62bfcRVewKMxt/v763Z7Y8gnQTlL7oqDzNSt9vF5KA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:30:24.1883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 198fce44-34c3-4e01-0fd9-08dddba3b077
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9604

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
overflow conditions during the next event read. Clear assignable counter
configuration on all the domains. Also, enable auto assignment when
switching to "mbm_event" mode.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v17: Moved resctrl_mbm_assign_mode_write() to fs/resctrl/monitor.c
     Fixed the event configuration initialization while considering hw support.
     Enable auto assignment when switching to "mbm_event" mode.

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
 Documentation/filesystems/resctrl.rst |  22 +++++-
 fs/resctrl/internal.h                 |   6 ++
 fs/resctrl/monitor.c                  | 100 ++++++++++++++++++++++++++
 fs/resctrl/rdtgroup.c                 |   7 +-
 4 files changed, 131 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 3e549822a439..9a275a3a643a 100644
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
index 264f04c7dfba..6938734b14a4 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -396,6 +396,12 @@ void *rdt_kn_parent_priv(struct kernfs_node *kn);
 
 int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of, struct seq_file *s, void *v);
 
+ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of, char *buf,
+				      size_t nbytes, loff_t off);
+
+void resctrl_bmec_files_show(struct rdt_resource *r, struct kernfs_node *l3_mon_kn,
+			     bool show);
+
 int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_file *s, void *v);
 
 int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_file *s,
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 41dd2a117376..45cededbb042 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1199,6 +1199,33 @@ ssize_t resctrl_mbm_assign_on_mkdir_write(struct kernfs_open_file *of, char *buf
 	return ret ?: nbytes;
 }
 
+/*
+ * mbm_cntr_free_all() - Clear all the counter ID configuration details in the
+ *			 domain @d. Called when mbm_assign_mode is changed.
+ */
+static void mbm_cntr_free_all(struct rdt_resource *r, struct rdt_mon_domain *d)
+{
+	memset(d->cntr_cfg, 0, sizeof(*d->cntr_cfg) * r->mon.num_mbm_cntrs);
+}
+
+/*
+ * resctrl_reset_rmid_all() - Reset all non-architecture states for all the
+ *			      supported RMIDs.
+ */
+static void resctrl_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d)
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
@@ -1395,6 +1422,79 @@ int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of, char *buf,
+				      size_t nbytes, loff_t off)
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
+			mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg = r->mon.mbm_cfg_mask;
+		if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
+			mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg = r->mon.mbm_cfg_mask &
+									   (READS_TO_LOCAL_MEM |
+									    READS_TO_LOCAL_S_MEM |
+									    NON_TEMP_WRITE_TO_LOCAL_MEM);
+		/* Enable auto assignment when switching to "mbm_event" mode */
+		if (enable)
+			r->mon.mbm_assign_on_mkdir = true;
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
 int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of,
 			       struct seq_file *s, void *v)
 {
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 72a19e0e4fc2..ce4e716e6404 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1807,8 +1807,8 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
  * Don't treat kernfs_find_and_get failure as an error, since this function may
  * be called regardless of whether BMEC is supported or the event is enabled.
  */
-static void resctrl_bmec_files_show(struct rdt_resource *r, struct kernfs_node *l3_mon_kn,
-				    bool show)
+void resctrl_bmec_files_show(struct rdt_resource *r, struct kernfs_node *l3_mon_kn,
+			     bool show)
 {
 	struct kernfs_node *kn_config, *mon_kn = NULL;
 	char name[32];
@@ -1985,9 +1985,10 @@ static struct rftype res_common_files[] = {
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


