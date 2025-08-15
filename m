Return-Path: <linux-kernel+bounces-770007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72203B275DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1EC1CE5F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75892BE03F;
	Fri, 15 Aug 2025 02:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I4gjVi0Y"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47702BE027;
	Fri, 15 Aug 2025 02:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224908; cv=fail; b=ef4Y7DGtmUD1d7A6+yIkvqoJnOsylrnAjr0If+G8eTE2RiNi8Idrs+/htPLiwl+4CxTnfx5I0TnLcxkVPTVqLcbamX7Y+BvfLTklFd2vWK9g1zStk2MAa3TYLBXvfEH6kId7/ZMosccgkTDODoNl0fPEurV0nwaX+PZwTC3Qod4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224908; c=relaxed/simple;
	bh=tdRAjbStyrZ44fB/++MzdlU4HuFLlpDNzWbAWpcDcAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pe67yfJBLJzi33Fy2S2Ge61+6TxZfq02HmTtw5Mqyrykdi+hWY1lFZUPKMChlmsV/DhpNujplxF2o1ZTsv+RU131P0bR+y8Uz024e+oXJPREpLLtaQ9dcFg0MAritk944xGwY4oGFA+W3yyTQd36TxEb5lr3YPYKglysfPvnbmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I4gjVi0Y; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKCxWftgmdm3sS7XLcVspAsH5hBNf+YwJr5hEx9OOE0nP6Z7vFrtu3IOpV9DJGxqy3Mia6bIP/oWGGX4yvkxGiusxjXj+1q3nQScvlemBUNIOJ5NZ+cAZM39ooPeF4Znis27blEEIinsj17887Xf6LlORTF5PPcgQxyWcmeujFqxHEeOTTb29bMiYTHMzEfDivRWPLuRUrBt0BNaAsGHV6ztWnGQZAHyHbx0FfUJWs1WHenlbrtvZlbtpB87WN6xKtsD67JsEVrSMk0pXCqJPYSJboh4U9dL8Sj2LWLYE2WMLQsfA88fsoYIS++O6qBoYdZKHAmaUSi3n17OK+u4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5a2XdE2hb/hO0Ks9j7nzdzNnHcRWTddzlCm2RvlWfw=;
 b=qA5UWcF+t4DTFPT7fJMOBXq+dpq/6FtK2o7NOM9g6jC55kkvyz1tu60v6kw121CTN144nXHmNd5mE4z0EstdEYxH9qkMHORGFr5SM2Wuv/e4LJ5VikZHLI7396Q80SFm2gfJTxwPiDCwDA7/LSkJihSQLMFlIV5vSOOS/gdwFmtu+9ByxqgxsVnYX5f4tY+VqbVl69UxFgqmLDd31pwkQcAgVgyvb6wUILwtrKAeD0WSbN8dz8Vp8HipL2cmGKe2EDxPox/qLfK9AixEFmVDfZQL3LOEekugV5bPOSAi2gyQ1485NLiBb1yejLaoDV9hfgNU10W6hQYDfEuG1PjOFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5a2XdE2hb/hO0Ks9j7nzdzNnHcRWTddzlCm2RvlWfw=;
 b=I4gjVi0YrCZ1SMhhpbdVBWmvqYsTlXv93aUJXipoGH88OoSqLigNajUvL4LvSfR0LxtgJ28GVkp9r0KPwJ1It973vmCRLYbIqz91QR5m0c3Sjry5McXVqu9kdpRwHs+YqJZI8PPSeFfgKLN7OTxEP2GRe7d724pz3IegsJMm93g=
Received: from SJ0PR05CA0175.namprd05.prod.outlook.com (2603:10b6:a03:339::30)
 by DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.14; Fri, 15 Aug 2025 02:28:18 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::41) by SJ0PR05CA0175.outlook.office365.com
 (2603:10b6:a03:339::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 02:28:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:28:18 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:28:15 -0500
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
Subject: [PATCH v17 17/33] fs/resctrl: Add the functionality to assign MBM events
Date: Thu, 14 Aug 2025 21:25:21 -0500
Message-ID: <3ca72cb03376d3433167f0a35d49f2e894c41db0.1755224735.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS7PR12MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2bdc06-151c-43b2-7041-08dddba36544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OlqCKmrp7U7i/XcI38Nif5zURWGc3+YWNKeFbAkkr0St8h75+Nudlh9Pf+bt?=
 =?us-ascii?Q?2jLmu2LkCS+dpp2/zDM9svMGTnPzbs47v1npHIKECXHkwRb71DK5NAEoFN/d?=
 =?us-ascii?Q?NqBNnaTihQBC7y96wRWn8Gq0AAq82tzOSe2dPHygh+JgHE6RXeU8uQRgEQGf?=
 =?us-ascii?Q?nspooEKns+dOsSXDkDjVO6Zfh1Wn5+XG7sFOEDkfHAEL2bBvUOQ5lPqRz1wA?=
 =?us-ascii?Q?dqAQHy7me6sJHKXUHx0OWthvOw5PffgxHmGFTWMnkA3tA1z+QUSPF1pYuVyH?=
 =?us-ascii?Q?hjCNl/2FRVBd6rBdMteJUHPGdcznQISqDzzbc1zKyzmuVk53vnsLCnGvYohA?=
 =?us-ascii?Q?HiO+6QJy9AJZuQs8xwguTHZRwn7dBDIHpJLGAjii47iEDTJO2X5wKVFLlUcz?=
 =?us-ascii?Q?NGWMabvA0BX3PdW56C7bPl6JBuNkwxJWbLGunvA/qWYeuHTBZKjNrNiHvgWw?=
 =?us-ascii?Q?KOYDE+up4HrenMG2ORvKYnlLmtAxn/NjvXDdtz0VsFwQ/sMSgywFRWIP9wHc?=
 =?us-ascii?Q?G6nUG2kBpvjW36WO0iZR+Wvn3rNZXzF11+RGGvPc4KVx+e1FcV8aku+pQBd7?=
 =?us-ascii?Q?ZjmoS4+AJYxsUTOxNGVkwZ7ZS/BgliVcoCWxKGIDtLZ5q2m5t32TNSNG69+5?=
 =?us-ascii?Q?VzmGuAaMeqnYz5UU/LfGMQRvvl/b/xZGj6Boy/Atz/pihnR7Y7H8coKriC9s?=
 =?us-ascii?Q?Cdcnoik0JdMhhf4X+Rk/SF9X/aHTkmMM8trYNW4XvG8oiWWalNwSV2K24pug?=
 =?us-ascii?Q?QpVUsFzYCcBDSUsOhgyX1G6GCxNGIkeNNeAbxRDs+5MyJ8aElxba6/Z7EeYC?=
 =?us-ascii?Q?XNBcPMX+orKRCzGydTg/+3SL9ZjQth5ohMXT/eOVzVzgoUVrJp2ztrLO+S/Z?=
 =?us-ascii?Q?g0rXKa7zRH7r6+OgbmwC7TsLra08tOixfWYCtcsJo+y618NC/8Kn/YtDFd4E?=
 =?us-ascii?Q?dZqzuTpvI3lcN56WeGBbGQKIl+gpnqY1mNTNPjgLvmkX8S0qAmWRioudjt+A?=
 =?us-ascii?Q?IZgN43LZ70ZM4eUDbIYoJM6Sr9yh2/m00Pje6VTEp4Iwe4tzbUyj/njRWNZS?=
 =?us-ascii?Q?2sen34/u5RfhdWxV37Y4YdKBEqOJg3OyxA3k0Gm9eoF9i6lbr7oyAbwX5OHL?=
 =?us-ascii?Q?haI/T82AQgZCMATJ2oMeejeCk5xLOCyWMHd85UNu0KmfL1d8SH4Aqz3tFRSX?=
 =?us-ascii?Q?AOV9ajjuqTF0nGri+JKt0T0U2AkQ/GUtR3v9OdRmWieh+UXdV5e0ys9syKpE?=
 =?us-ascii?Q?FeS0eeviBWZolUOw6kwD7sHj1Af1+hwH2trLYTOfPA9VgNxILqofrnIUFgDG?=
 =?us-ascii?Q?wWUUn5PsEI1EwYt3mkXSHZkXMwmsz2nneISors6f336XmO6RSNTnv46BzU4l?=
 =?us-ascii?Q?phqeIpWCwtzo9GgiarlIqyekuewjtBliBVBFagLoiMRLipCLhbhiRKoKhCQ1?=
 =?us-ascii?Q?wLek7Iea75mgt+Te1lQAxBX6FVVPQzQXfFGByCIueWD90IJsGKvPh0+reffK?=
 =?us-ascii?Q?hm6ihcNSdE7xK0G8rQzpYE53ndUurwdEGlDzOnWBLhL7GiFI1yF97iveTg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:28:18.0274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2bdc06-151c-43b2-7041-08dddba36544
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120

When supported, "mbm_event" counter assignment mode offers "num_mbm_cntrs"
number of counters that can be assigned to RMID, event pairs and monitor
bandwidth usage as long as it is assigned.

Add the functionality to allocate and assign a counter to an RMID, event
pair in the domain. Also, add the helper rdtgroup_assign_cntrs() to assign
counters in the group.

Log the error message "Failed to allocate counter for <event> in domain
<id>" in /sys/fs/resctrl/info/last_cmd_status if all the counters are in
use. Exit on the first failure when assigning counters across all the
domains.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v17: Minor changelog update.
     Moved all the functions from fs/resctrl/rdtgroup.c to fs/resctrl/monitor.c.
     Brought rdtgroup_assign_cntrs() in this patch from patch 28 to make compiler happy.

v16: Function renames:
     resctrl_config_cntr() -> rdtgroup_assign_cntr()
     rdtgroup_alloc_config_cntr() -> rdtgroup_alloc_assign_cntr()
     Passed struct mevt to rdtgroup_alloc_assign_cntr so it can print event name on failure.
     Minor code comment update.

v15: Updated the changelog.
     Added the check !r->mon.mbm_cntr_assignable in mbm_cntr_get() to return error.
     Removed the check to verify evt_cfg in the domain as it is not required anymore.
     https://lore.kernel.org/lkml/887bad33-7f4a-4b6d-95a7-fdfe0451f42b@intel.com/
     Return success if the counter is already assigned.
     Rename resctrl_assign_cntr_event() -> rdtgroup_assign_cntr_event().
     Removed the parameter struct rdt_resource. It can be obtained from mevt->rid.

v14: Updated the changelog little bit.
     Updated the code documentation for mbm_cntr_alloc() and  mbm_cntr_get().
     Passed struct mon_evt to resctrl_assign_cntr_event() that way to avoid
     back and forth calls to get event details.
     Updated the code documentation about the failure when counters are exhasted.
     Changed subject line to fs/resctrl.

v13: Updated changelog.
     Changed resctrl_arch_config_cntr() to return void instead of int.
     Just passing evtid is to resctrl_alloc_config_cntr() and
     resctrl_assign_cntr_event(). Event configuration value can be easily
     obtained from mon_evt list.
     Introduced new function mbm_get_mon_event() to get event configuration value.
     Added prototype descriptions to mbm_cntr_get() and mbm_cntr_alloc().
     Resolved conflicts caused by the recent FS/ARCH code restructure.
     The files monitor.c/rdtgroup.c have been split between FS and ARCH directories.

v12: Fixed typo in the subjest line.
     Replaced several counters with "num_mbm_cntrs" counters.
     Changed the check in resctrl_alloc_config_cntr() to reduce the indentation.
     Fixed the handling error on first failure.
     Added domain id and event id on failure.
     Fixed the return error override.
     Added new parameter event configuration (evt_cfg) to get the event configuration
     from user space.

v11: Patch changed again quite a bit.
     Moved the functions to monitor.c.
     Renamed rdtgroup_assign_cntr_event() to resctrl_assign_cntr_event().
     Refactored the resctrl_assign_cntr_event().
     Added functionality to exit on the first error during assignment.
     Simplified mbm_cntr_free().
     Removed the function mbm_cntr_assigned(). Will be using mbm_cntr_get() to
     figure out if the counter is assigned or not.
     Updated commit message and code comments.

v10: Patch changed completely.
     Counters are managed at the domain based on the discussion.
     https://lore.kernel.org/lkml/CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com/
     Reset non-architectural MBM state.
     Commit message update.

v9: Introduced new function resctrl_config_cntr to assign the counter, update
    the bitmap and reset the architectural state.
    Taken care of error handling(freeing the counter) when assignment fails.
    Moved mbm_cntr_assigned_to_domain here as it used in this patch.
    Minor text changes.

v8: Renamed rdtgroup_assign_cntr() to rdtgroup_assign_cntr_event().
    Added the code to return the error if rdtgroup_assign_cntr_event fails.
    Moved definition of MBM_EVENT_ARRAY_INDEX to resctrl/internal.h.
    Updated typo in the comments.

v7: New patch. Moved all the FS code here.
    Merged rdtgroup_assign_cntr and rdtgroup_alloc_cntr.
    Adde new #define MBM_EVENT_ARRAY_INDEX.
---
 fs/resctrl/internal.h |   2 +
 fs/resctrl/monitor.c  | 156 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 158 insertions(+)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 874b59f52d13..73cad7c17a1f 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -396,6 +396,8 @@ int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_file *s,
 int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_file *s,
 				     void *v);
 
+void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 8c6e44e0e57c..3eb5a30f44fb 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -356,6 +356,55 @@ static struct mbm_state *get_mbm_state(struct rdt_mon_domain *d, u32 closid,
 	return state ? &state[idx] : NULL;
 }
 
+/*
+ * mbm_cntr_get() - Return the counter ID for the matching @evtid and @rdtgrp.
+ *
+ * Return:
+ * Valid counter ID on success, or -ENOENT on failure.
+ */
+static int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
+			struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
+{
+	int cntr_id;
+
+	if (!r->mon.mbm_cntr_assignable)
+		return -ENOENT;
+
+	if (!resctrl_is_mbm_event(evtid))
+		return -ENOENT;
+
+	for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
+		if (d->cntr_cfg[cntr_id].rdtgrp == rdtgrp &&
+		    d->cntr_cfg[cntr_id].evtid == evtid)
+			return cntr_id;
+	}
+
+	return -ENOENT;
+}
+
+/*
+ * mbm_cntr_alloc() - Initialize and return a new counter ID in the domain @d.
+ * Caller must ensure that the specified event is not assigned already.
+ *
+ * Return:
+ * Valid counter ID on success, or -ENOSPC on failure.
+ */
+static int mbm_cntr_alloc(struct rdt_resource *r, struct rdt_mon_domain *d,
+			  struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
+{
+	int cntr_id;
+
+	for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
+		if (!d->cntr_cfg[cntr_id].rdtgrp) {
+			d->cntr_cfg[cntr_id].rdtgrp = rdtgrp;
+			d->cntr_cfg[cntr_id].evtid = evtid;
+			return cntr_id;
+		}
+	}
+
+	return -ENOSPC;
+}
+
 static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 {
 	int cpu = smp_processor_id();
@@ -889,6 +938,113 @@ u32 resctrl_get_mon_evt_cfg(enum resctrl_event_id evtid)
 	return mon_event_all[evtid].evt_cfg;
 }
 
+/*
+ * rdtgroup_assign_cntr() - Assign/unassign the counter ID for the event, RMID
+ * pair in the domain.
+ *
+ * Assign the counter if @assign is true else unassign the counter. Reset the
+ * associated non-architectural state.
+ */
+static void rdtgroup_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+				 enum resctrl_event_id evtid, u32 rmid, u32 closid,
+				 u32 cntr_id, bool assign)
+{
+	struct mbm_state *m;
+
+	resctrl_arch_config_cntr(r, d, evtid, rmid, closid, cntr_id, assign);
+
+	m = get_mbm_state(d, closid, rmid, evtid);
+	if (m)
+		memset(m, 0, sizeof(*m));
+}
+
+/*
+ * rdtgroup_alloc_assign_cntr() - Allocate a counter ID and assign it to the event
+ * pointed to by @mevt and the resctrl group @rdtgrp within the domain @d.
+ *
+ * Return:
+ * 0 on success, < 0 on failure.
+ */
+static int rdtgroup_alloc_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+				      struct rdtgroup *rdtgrp, struct mon_evt *mevt)
+{
+	int cntr_id;
+
+	/* No action required if the counter is assigned already. */
+	cntr_id = mbm_cntr_get(r, d, rdtgrp, mevt->evtid);
+	if (cntr_id >= 0)
+		return 0;
+
+	cntr_id = mbm_cntr_alloc(r, d, rdtgrp, mevt->evtid);
+	if (cntr_id < 0) {
+		rdt_last_cmd_printf("Failed to allocate counter for %s in domain %d\n",
+				    mevt->name, d->hdr.id);
+		return cntr_id;
+	}
+
+	rdtgroup_assign_cntr(r, d, mevt->evtid, rdtgrp->mon.rmid, rdtgrp->closid, cntr_id, true);
+
+	return 0;
+}
+
+/*
+ * rdtgroup_assign_cntr_event() - Assign a hardware counter for the event in
+ * @mevt to the resctrl group @rdtgrp. Assign counters to all domains if @d is
+ * NULL; otherwise, assign the counter to the specified domain @d.
+ *
+ * If all counters in a domain are already in use, rdtgroup_alloc_assign_cntr()
+ * will fail. The assignment process will abort at the first failure encountered
+ * during domain traversal, which may result in the event being only partially
+ * assigned.
+ *
+ * Return:
+ * 0 on success, < 0 on failure.
+ */
+static int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
+				      struct mon_evt *mevt)
+{
+	struct rdt_resource *r = resctrl_arch_get_resource(mevt->rid);
+	int ret = 0;
+
+	if (!d) {
+		list_for_each_entry(d, &r->mon_domains, hdr.list) {
+			ret = rdtgroup_alloc_assign_cntr(r, d, rdtgrp, mevt);
+			if (ret)
+				return ret;
+		}
+	} else {
+		ret = rdtgroup_alloc_assign_cntr(r, d, rdtgrp, mevt);
+	}
+
+	return ret;
+}
+
+/*
+ * rdtgroup_assign_cntrs() - Assign counters to MBM events. Called when
+ *			     a new group is created.
+ *
+ * Each group can accommodate two counters per domain: one for the total
+ * event and one for the local event. Assignments may fail due to the limited
+ * number of counters. However, it is not necessary to fail the group creation
+ * and thus no failure is returned. Users have the option to modify the
+ * counter assignments after the group has been created.
+ */
+void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
+{
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
+
+	if (!r->mon_capable || !resctrl_arch_mbm_cntr_assign_enabled(r))
+		return;
+
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
+		rdtgroup_assign_cntr_event(NULL, rdtgrp,
+					   &mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID]);
+
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
+		rdtgroup_assign_cntr_event(NULL, rdtgrp,
+					   &mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID]);
+}
+
 int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
 				 struct seq_file *s, void *v)
 {
-- 
2.34.1


