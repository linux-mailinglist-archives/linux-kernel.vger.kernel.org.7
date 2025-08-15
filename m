Return-Path: <linux-kernel+bounces-770005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDF1B275D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E592AA82CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68AC29CB4B;
	Fri, 15 Aug 2025 02:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iRbCS+cg"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168FE2BDC39;
	Fri, 15 Aug 2025 02:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224887; cv=fail; b=kl28p75TvPFrNPDweKMWbsFpZX9oHb4hedg/8Y+fmJQ856EotRdv68vul+PcfyMO8uig4dIscs8/Ix3oK0GvQLHkexK+FsvqJCG6V8TC/0gSFI6x2TV3SMCXcbHVeSo/9QwJgR3bZTky4nhkPePM0Jswes+7uZmQTx69BHMWTkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224887; c=relaxed/simple;
	bh=V6ZZNq2VJKDj5oiSEY5Ssb2IRFEOP5s6eRZnXlfi80A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIIqlP/AG4741WQNHRs/p8OR4w2/UWy8VeBbhylG3sSPs9xQr9RSjQvlR1qk9YhX3zn9+wwdQkEvEh7qlI9PVlGSQPk+aETP8DRiNrllDmLskkpMyFMuo5CRCF8l4A7r0VF7OhhduiAVtg1CE/GW5TnappflILYfGpgzEWKthLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iRbCS+cg; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFnHIdFujUlEdaYaESfrWf8zFwyZGSPOt/8KPUuKQuD+iMgbc5UlPSi+eIidI/hwycfzv4JI2iozWVGF30XSP75MyQyH91MsYgrE5I0DPIJ0VBe1lAQSVaDpsi95spe5HgUZNthnklkse30Ko5njFGtMeBbci7fIlObmwVkvh7aE2rslQqd3tmNVarqzQiAkU70VmodFJkda/iEUIq9hila8MJ7AM2jS+Wxu4ctfLdZX7r4My3kTEgt9nBewNx+iKBIzNU6BeBcWGjlpTbjER6VKJ+j83gwCgsXidOs5+d3DF0yodtpT2P2M7rOBKprt57r/um5/CfDdZMkVGPBvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kpPZvyxWPxTu9WJxfmuJ9reR5hUIDkLt+C7okUHllo=;
 b=KSiGeazj665WnFOxVJ6Fdgp9dqFp52orXLkoSZJnEd31U9NXVlW78MaI3gvDUOZC9cZjYU48XPYXaVsb+KXZsQZibIWknSQRodE2GGtp5FAXJ2LdbWs7nc44ma/KAYq/DgV/NHd1shrXI578AMKLYat/+/r2yv6yHK64IW1SOgIN4Xc6lGx8ZGYb+gtAcxg6FdZG6hP4+rd6I2nfth2owQ+iXLSPm7ToX+2B+PWTUXems0qGqZP9I1uPBW8Fm4lUe47WB0S6/hy+munHlekinH0aguMr+GaYJmbk+wZhscvpIB5zqQFjLXCw8awmgoWFQwQlYPXYMj5IYq7oYeGr3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kpPZvyxWPxTu9WJxfmuJ9reR5hUIDkLt+C7okUHllo=;
 b=iRbCS+cgpukEoDteuqV0vrfJhHsbWiJOahrdl9NmRWOfy4h8/1b3VS3tsKryGDZCOPnw7NJHyFrpeAfYVhKZWqu+2kQ9jR3hPvK+ma/nYxI3XFl57899uOdP+nkpGOx3So1ioH4iytM615q52+mPC4tXa+sdlh7dhBZn0CEc4XQ=
Received: from SJ0PR05CA0161.namprd05.prod.outlook.com (2603:10b6:a03:339::16)
 by IA4PR12MB9786.namprd12.prod.outlook.com (2603:10b6:208:5d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Fri, 15 Aug
 2025 02:28:01 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::fd) by SJ0PR05CA0161.outlook.office365.com
 (2603:10b6:a03:339::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.6 via Frontend Transport; Fri,
 15 Aug 2025 02:28:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:28:00 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:27:58 -0500
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
Subject: [PATCH v17 15/33] fs/resctrl: Introduce event configuration field in struct mon_evt
Date: Thu, 14 Aug 2025 21:25:19 -0500
Message-ID: <a55d37628c51e7f507f73abe6db6ea0539e4fad1.1755224735.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|IA4PR12MB9786:EE_
X-MS-Office365-Filtering-Correlation-Id: 688c9993-0241-4145-9045-08dddba35b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pg4GOknYfr5aJz4VhtdyVmy6o8tOmtMFGbn88Dv1rOnoeI3J8uFHT9iSpEyp?=
 =?us-ascii?Q?uIoWksYL0l7Sf9M7jg+k0l7iEqmKQMQGHHT8h/wzFWdSb84rb7pempEtFv6p?=
 =?us-ascii?Q?lahh9+zPS742lYjYNMsFZ5vZTSyEkBBK/NeuUvVKKrtw9psNeMCRaXJppS0w?=
 =?us-ascii?Q?CPQcI2MCCVhzSW60qcSTy2wIfBvGhMF3Lnk01Xm6Ausy39+YqcGpRoNRaeD4?=
 =?us-ascii?Q?P4Bxk+CEbcNOrqx59jlGpuKmfnSC4FCZ2u/Mt/3otTd3MTf3lNZfypHkRYI8?=
 =?us-ascii?Q?iOVJLvtMlP6wXcFY2rTx7rAkwO8HNf0E3hhcT5yHPE+48gdKdJiX73x5T9iS?=
 =?us-ascii?Q?DD1Lb/gza4mZ01VGwptFtTEZofVQJdRGEX+auacVbI4PBKLXzgWmFp/FpQLk?=
 =?us-ascii?Q?noJBdlMduX8ItAdA4DePAowTMS32nl198XMIAz+s+K+elAHOKjvsTIXgbOyq?=
 =?us-ascii?Q?KZsxFz3+EqFsn7yjv2uSnYwi+lpzhfb8ZybvOP704oubDdaDPAsP4tB0JGPd?=
 =?us-ascii?Q?rIrGG5Tvp+Q8utB4Bqsv0visDeGvvE7HrcJ8xHEKtstR8h4qvfvAjVBLwTHV?=
 =?us-ascii?Q?KFYvg2cvpB3f/GQnoKLkCvy+k5rZ47HYZDmQV2iB843vP796iYsFXqHd5gkz?=
 =?us-ascii?Q?cX9UIPVh3K+3AAKzBVM3ym9VkOpg7l395v5+6jkhWx+mBQkRgZv394RdGWTe?=
 =?us-ascii?Q?oDshaSZ+ch8W/LqIcgA69sAVHWWJ1fgZGwSqYNDDXDJ8HmDWCb6HXrtoV32f?=
 =?us-ascii?Q?6ajzswS4kdyoM7jkB8Wl7Ksgj6t8rJV+GMta1DvL+cjiE+x3ZmdoUNE/gq2h?=
 =?us-ascii?Q?en8qY3atYMwBBWPcMo5zKReSl+mK4dH/8nwY+QOYDMpHWh87B6/3oRp8OGM3?=
 =?us-ascii?Q?Ab08exh2t7DsgpfRas42KKkbpSUWBWJ0QKau/69jCGmEy+UKSg89YsFNrEmu?=
 =?us-ascii?Q?1M0ImWKoX71obU/EBEiw1jg0x4U4EUc0+jMwPW0rzWArwh4uuMhvh+WXv8GX?=
 =?us-ascii?Q?DfMOaOqf96peUvNGKQK17pi/0XHz2cj/C9qBOKCctWfVIu/+eWt+guKVKskd?=
 =?us-ascii?Q?E4RzFxrbWGCwQMU+SZOva9Y6SqVyOyFYq9WuGUHuNUZyblQD4DvOB0Y4evX5?=
 =?us-ascii?Q?L2f9fElDnGdjcZ8dkV8mI0f5uIPa7lX/5QFy/wjqpxILwozE78D6x/5m7ubP?=
 =?us-ascii?Q?I26bRyZaNjFTgPkA2ut3RfrRQJ12BpkiLULTxW9vVOlxQKBlS4ICHNrNY9dD?=
 =?us-ascii?Q?VxzNVFeF3d6+LI1sHlZguhFn/LOuH9/8Xuk65P4Gkgt4cryRW9w/1AFFQjxG?=
 =?us-ascii?Q?KEw15GsJ8hyyrurcW1urDbjk1cJr/uVUZsgBS/bu6JGQt8kQBwgclkXi/xZs?=
 =?us-ascii?Q?JdmPoJuy/XaNV+3tb64vOKXlPkqfbqayjUjRaa9YvZ6bakk62eXp6CZPl2s/?=
 =?us-ascii?Q?0Auu4IxPCo4tx7unt8q8Jq9C5e4LIcy+GZi67gsATOFdElYx0NOTdguBaU45?=
 =?us-ascii?Q?9I2OWdp0NPlLY7MUctfFXYWwedO+/yFb7C9ABHsGG9Fd16vDnHC4BdS6Sg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:28:00.8834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 688c9993-0241-4145-9045-08dddba35b0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9786

When supported, mbm_event counter assignment mode allows the user to
configure events to track specific types of memory transactions.

Introduce the evt_cfg field in struct mon_evt to define the type of memory
transactions tracked by a monitoring event. Also add a helper function to
get the evt_cfg value.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v17: Updated evt_cfg to use r->mon.mbm_cfg_mask.
     Removed Reviewed-by tag since the patch was modified slightly.

v16: Added Reviewed-by tag.

v15: Updated the changelog.
     Removed resctrl_set_mon_evt_cfg().
     Moved the event initialization to resctrl_mon_resource_init().

v14: This is updated patch from previous patch.
     https://lore.kernel.org/lkml/95b7f4e9d72773e8fda327fc80b429646efc3a8a.1747349530.git.babu.moger@amd.com/
     Removed mbm_mode as it is not required anymore.
     Added resctrl_get_mon_evt_cfg() and resctrl_set_mon_evt_cfg().

v13: New patch to handle different event configuration types with
     mbm_cntr_assign mode.
---
 fs/resctrl/internal.h   |  5 +++++
 fs/resctrl/monitor.c    | 10 ++++++++++
 include/linux/resctrl.h |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 35a8bad8ca75..874b59f52d13 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -56,6 +56,10 @@ static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
  * @evtid:		event id
  * @rid:		resource id for this event
  * @name:		name of the event
+ * @evt_cfg:		Event configuration value that represents the
+ *			memory transactions (e.g., READS_TO_LOCAL_MEM,
+ *			READS_TO_REMOTE_MEM) being tracked by @evtid.
+ *			Only valid if @evtid is an MBM event.
  * @configurable:	true if the event is configurable
  * @enabled:		true if the event is enabled
  */
@@ -63,6 +67,7 @@ struct mon_evt {
 	enum resctrl_event_id	evtid;
 	enum resctrl_res_level	rid;
 	char			*name;
+	u32			evt_cfg;
 	bool			configurable;
 	bool			enabled;
 };
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 4185f2a4ba89..8c6e44e0e57c 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -884,6 +884,11 @@ bool resctrl_is_mon_event_enabled(enum resctrl_event_id eventid)
 	       mon_event_all[eventid].enabled;
 }
 
+u32 resctrl_get_mon_evt_cfg(enum resctrl_event_id evtid)
+{
+	return mon_event_all[evtid].evt_cfg;
+}
+
 int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
 				 struct seq_file *s, void *v)
 {
@@ -1025,6 +1030,11 @@ int resctrl_mon_resource_init(void)
 			resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
 		if (!resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
 			resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
+		mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg = r->mon.mbm_cfg_mask;
+		mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg = r->mon.mbm_cfg_mask &
+								   (READS_TO_LOCAL_MEM |
+								    READS_TO_LOCAL_S_MEM |
+								    NON_TEMP_WRITE_TO_LOCAL_MEM);
 		resctrl_file_fflags_init("num_mbm_cntrs",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		resctrl_file_fflags_init("available_mbm_cntrs",
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index e013caba6641..87daa4ca312d 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -409,6 +409,8 @@ static inline bool resctrl_is_mbm_event(enum resctrl_event_id eventid)
 		eventid <= QOS_L3_MBM_LOCAL_EVENT_ID);
 }
 
+u32 resctrl_get_mon_evt_cfg(enum resctrl_event_id eventid);
+
 /* Iterate over all memory bandwidth events */
 #define for_each_mbm_event_id(eventid)				\
 	for (eventid = QOS_L3_MBM_TOTAL_EVENT_ID;		\
-- 
2.34.1


