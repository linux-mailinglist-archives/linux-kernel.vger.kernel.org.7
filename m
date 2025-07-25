Return-Path: <linux-kernel+bounces-746186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 915AFB123FF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA819173F80
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0547C250BF2;
	Fri, 25 Jul 2025 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iwl8TMe9"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476E724A079;
	Fri, 25 Jul 2025 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468453; cv=fail; b=EMlOIPHOzB52J/YHZJrUK8VIp09tQ5rF8Eo35ZSOQDxxoaXbpLSz7pFCsszy177eHWVWXTnAjZZAxr4BzRTWuOoIZ7hbF2MGkViFVvTdNyeFMJWvGRLOUhEt1xUtf9P0VNIS+k4xDqNGFH7SfBVjye+zEvCZh2wz1khlQzWNuG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468453; c=relaxed/simple;
	bh=sU1vvfzhAmGSsqlKumwHjntKx040a1oxdDh7YKJYbE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADpy23k4Lkll3qK7bODhbPxqfErQFUf2Ra4KZTr3mWHzpOUaBNbsfyxolJI8o+GG03SrtmvK1vwSJ0ZbmmQBpI7kX8SDUSi3zX5TGafb6+yIEdvDXvxQUorUKslzE6JcdwNlpAlWRO0nD6DM40AyH9XK6JOAJAMMpaqnI0mK1Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iwl8TMe9; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZ6B5FUe8AYpxOhZMXbqCzcvX/6rG9BFiqJ0KPA9+2WeZQWFU18AdEq/o251x+HGuQKtTe5fD3M5jX0KN+vFJPth261bmVhQrGPaGzHY4/U43CsoCVBwcjJ8UlDQxYYzyUtTt+sPqQr1HsdnQvoh/8J137I0uOjcc3uJ7qnivBhKqFM/32l/00weYIFhvd1xZMOI/EQlwlHLh3vd8O/73rIY8LO7wyCbT4tk3/j8xDfq8Te9oEoU762np7TZdEqawtNKpv4yrhR3uQNv+WzzwwzDVEbSyOYfuIYwBUZGPnyWuJG7u3mwV25oNgFiaeAp0XeQjfOpTDpXZyXe04WtnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5t7GOKxTBKUiVLnIhSfR+k0MYlS4m7Y+jKTBXsaUAi4=;
 b=sqfqLPFEVOJ1T0XsnXyYntyTKRPx3wFGGr6Xy0h+NerS3UfLMMDlex1d6MU+wojn8dFVLoD5Jvva+MT+WTBPLUwknlgpRGVnbf0+Mbaphb/7XkTugqJ51+WLz71KJMqAB/f8/P1na5NsKY4LTTIjvKes7q5a1uiqCGwXeKXWvzFTWK9bIS4fPQjOAGegnDZkURM7LltdhQU6BAMUNdg28fYoK+gOeatuUHsvapk1letVD8i4v8WFjZq5lJIp8ILeQARFi3ptx1Hm8/l5v3PEtAQ0o/JHBYH5DXvZPJNglC+KYE1zir8gSxZ8AhkK0r1UXJdAE8JxWM69RKXndwyu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5t7GOKxTBKUiVLnIhSfR+k0MYlS4m7Y+jKTBXsaUAi4=;
 b=iwl8TMe9HaAXyeHjqZ8RWVcNG0XoQoLBdQYPowRUVGQzf8ymxiQqcNREGgU9eeX9tSDtCQuKSq/19JR4ku+8Ccb60yh5iOT3k5F2Vk7bcaFzW35FikEBw+ox2lWeXiuT5e/+UwaH7MBh3ua74+qqwd8UBCfMyKqEaf2r14Tc5G8=
Received: from BYAPR11CA0095.namprd11.prod.outlook.com (2603:10b6:a03:f4::36)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 18:34:08 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::32) by BYAPR11CA0095.outlook.office365.com
 (2603:10b6:a03:f4::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Fri,
 25 Jul 2025 18:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:34:07 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:34:04 -0500
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
Subject: [PATCH v16 23/34] fs/resctrl: Support counter read/reset with mbm_event assignment mode
Date: Fri, 25 Jul 2025 13:29:42 -0500
Message-ID: <dea9cd70b311b6a7e1eb85b1e6087c701bcb488e.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc21c01-c28e-4202-34d6-08ddcba9d71e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JVvC6vLYka9bpM5ws/zPwuwaCxwKXFnz/LLIe2uTmPFbFY/JCfLN05nuhRM3?=
 =?us-ascii?Q?9ZUYtk7RO2386FSEFlzcu0RGOHeprEP8vNvRwWPJM6i5FB+tEIJCjOB2YUPl?=
 =?us-ascii?Q?qX7B6y01DNrM91yZYAQ3YDh/RhLalH9Wm4KntNfnL3Tt8YQCGLpJkcQpyMIb?=
 =?us-ascii?Q?nxfo1E71QpzuuraywN888IXbI6lnKCn1dMu3wmv9sphnGFiKFNfvqX+6HW5u?=
 =?us-ascii?Q?/hn5kOLpLcHJ28hE0Mj22Kk76Cb4Y6IQYBukb7vT/QtC4rVgDzTUU3w6MJiO?=
 =?us-ascii?Q?jIeJIGxw9Mqx+8qLBSj+G0YPs6XZdkBAqNFZPCByrp+bOnHchcaKx5eyGQCh?=
 =?us-ascii?Q?4Cfq1Q+zupDZIUbcZFu1RqvjVQeePm57IOyus3qtWuzpAB84cQI45xfnfa1f?=
 =?us-ascii?Q?dd5f45athsQlZBsuNnTNY1mdK/t3yxcfjH0ug4bdX88/qX9n6iJqXdp1HplY?=
 =?us-ascii?Q?NcAYrJSjF0pJLMFHwIYr+1rujHRd3FzJUJsmXPVLkFnkePtF8jqV9EvHM57k?=
 =?us-ascii?Q?0JlbkNcp8+TVOwfh2jPnzth8Ki3qprkmfSfbyF07lHl2dt8nSDRUsN97fHhU?=
 =?us-ascii?Q?EMpByX6GOT28l1XiAJwfEUOaIZiKRc90MfQNGNYCop2wkzYZMuuamKgOEjI1?=
 =?us-ascii?Q?eZKbmlqfY4QrAQAt+G3nMP2zicnaFf+ny1zs7pObWsZmn07UIvrpiG5oacV4?=
 =?us-ascii?Q?A7q9JeQV0RIQdzqLaEoOJSmw/9bHh7QWktzw/ds7+fOrAbsqqtU9IqGS36Ni?=
 =?us-ascii?Q?0BXrWnMezcpNzgBw/sybP6NcDbtP1Ub0Lc/Q1fMp3RHCYMD297aEVO2thIX4?=
 =?us-ascii?Q?u/gM0x32mu7Vgh6zXcU1HBpyXiGIXc4WeaiW3kZmR7lyQ505HT0RTB7SV8M6?=
 =?us-ascii?Q?Ki1pxADvDBh/YWOwnzbOhCEcRJuy0h5y+YsXKCk0SUzeOBJ2v+OGy3q82zhD?=
 =?us-ascii?Q?sBcqdR0i2OoXkONXNCQ+yb+jNWzjTF4LXAk/n0ySFDdNODn68m0hRBh/XDQ2?=
 =?us-ascii?Q?Y3nE9Eyfm7604E7bos5MJym1Bm8BvFTn7ufGWMAMfHmEbP/8SQZeq2ISPMAQ?=
 =?us-ascii?Q?f8EbPlpXJlAhVf8jAR9IHwkCSuBjQ1trgWVOVmQmxH+jMeJpvVEvvSbZAISn?=
 =?us-ascii?Q?jOhI4EunIvDYAwPYCsjDmTTUNSX9F1VOHXx3ycDId8dS+vHHjCp59cpWLdqB?=
 =?us-ascii?Q?q3OhCbT3yaF3W8dnGTtPepS51wgqnpMxzX8v9kTw1UrKv2LPNMgTJTws93vw?=
 =?us-ascii?Q?HNpKgqXVTl1pe+yzbSxCBj2XLAMyAfP0bNT3i+TIXKO14kacoc7F3hq83U01?=
 =?us-ascii?Q?MYJHBC+oR27wgjVA4DPNhQEOIgri0WMzdZHI/l94nO4UnjurlFlN+pYmxvdh?=
 =?us-ascii?Q?6SSOe81mGnq9r8euTHoWSo4pv1xKy84E3SaogD9Thtbqi20VuXxsAtrC+lXj?=
 =?us-ascii?Q?E3Mkq8r60c6QfCzKpvbQmnfQmbFi4AHtlIyUISE4Xzoc/GSkdCUFBv1D/ANR?=
 =?us-ascii?Q?bQ7gDA9cr54dOU4ckXAOcngh/IE0Umq8ukaUeMklTLBaCSvx43fbVVOPBA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:34:07.4574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc21c01-c28e-4202-34d6-08ddcba9d71e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333

When "mbm_event" counter assignment mode is enabled, the architecture
requires a counter ID to read the event data.

Introduce an is_mbm_cntr field in struct rmid_read to indicate whether
counter assignment mode is in use.

Update the logic to call resctrl_arch_cntr_read() and
resctrl_arch_reset_cntr() when the assignment mode is active. Report
'Unassigned' in case the user attempts to read the event without assigning
a hardware counter.

Declare mbm_cntr_get() in fs/resctrl/internal.h to make it accessible to
other functions within fs/resctrl.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v16: Squashed two patches here.
     https://lore.kernel.org/lkml/df215f02db88cad714755cd5275f20cf0ee4ae26.1752013061.git.babu.moger@amd.com/
     https://lore.kernel.org/lkml/296c435e9bf63fc5031114cced00fbb4837ad327.1752013061.git.babu.moger@amd.com/
     Changed is_cntr field in struct rmid_read to is_mbm_cntr.
     Fixed the memory leak with arch_mon_ctx.
     Updated the resctrl.rst user doc.
     Updated the changelog.
     Report Unassigned only if none of the events in CTRL_MON and MON are assigned.

v15: New patch to add is_cntr in rmid_read as discussed in
     https://lore.kernel.org/lkml/b4b14670-9cb0-4f65-abd5-39db996e8da9@intel.com/
---
 Documentation/filesystems/resctrl.rst |  6 ++++
 fs/resctrl/ctrlmondata.c              | 22 +++++++++---
 fs/resctrl/internal.h                 |  5 +++
 fs/resctrl/monitor.c                  | 52 ++++++++++++++++++++-------
 4 files changed, 67 insertions(+), 18 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 446736dbd97f..4c24c5f3f4c1 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -434,6 +434,12 @@ When monitoring is enabled all MON groups will also contain:
 	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
 	where "YY" is the node number.
 
+	When the 'mbm_event' counter assignment mode is enabled, reading
+	an MBM event of a MON group returns 'Unassigned' if no hardware
+	counter is assigned to it. For CTRL_MON groups, 'Unassigned' is
+	returned if the MBM event does not have an assigned counter in the
+	CTRL_MON group nor in any of its associated MON groups.
+
 "mon_hw_id":
 	Available only with debug option. The identifier used by hardware
 	for the monitor group. On x86 this is the RMID.
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index ad7ffc6acf13..31787ce6ec91 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -563,10 +563,15 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	rr->r = r;
 	rr->d = d;
 	rr->first = first;
-	rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, evtid);
-	if (IS_ERR(rr->arch_mon_ctx)) {
-		rr->err = -EINVAL;
-		return;
+	if (resctrl_arch_mbm_cntr_assign_enabled(r) &&
+	    resctrl_is_mbm_event(evtid)) {
+		rr->is_mbm_cntr = true;
+	} else {
+		rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, evtid);
+		if (IS_ERR(rr->arch_mon_ctx)) {
+			rr->err = -EINVAL;
+			return;
+		}
 	}
 
 	cpu = cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
@@ -582,7 +587,8 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	else
 		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
 
-	resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
+	if (rr->arch_mon_ctx)
+		resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
 }
 
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
@@ -653,10 +659,16 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 
 checkresult:
 
+	/*
+	 * -ENOENT is a special case, set only when "mbm_event" counter assignment
+	 * mode is enabled and no counter has been assigned.
+	 */
 	if (rr.err == -EIO)
 		seq_puts(m, "Error\n");
 	else if (rr.err == -EINVAL)
 		seq_puts(m, "Unavailable\n");
+	else if (rr.err == -ENOENT)
+		seq_puts(m, "Unassigned\n");
 	else
 		seq_printf(m, "%llu\n", rr.val);
 
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 216588842444..eeee83a5067a 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -110,6 +110,8 @@ struct mon_data {
  *	   domains in @r sharing L3 @ci.id
  * @evtid: Which monitor event to read.
  * @first: Initialize MBM counter when true.
+ * @is_mbm_cntr: Is the counter valid? true if "mbm_event" counter assignment mode is
+ *	   enabled and it is an MBM event.
  * @ci_id: Cacheinfo id for L3. Only set when @d is NULL. Used when summing domains.
  * @err:   Error encountered when reading counter.
  * @val:   Returned value of event counter. If @rgrp is a parent resource group,
@@ -124,6 +126,7 @@ struct rmid_read {
 	struct rdt_mon_domain	*d;
 	enum resctrl_event_id	evtid;
 	bool			first;
+	bool			is_mbm_cntr;
 	unsigned int		ci_id;
 	int			err;
 	u64			val;
@@ -391,6 +394,8 @@ int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp
 			       struct mon_evt *mevt);
 void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 				  struct mon_evt *mevt);
+int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
+		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
 
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 070965d45770..a8b53b0ad0b7 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -362,13 +362,25 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 	u32 closid = rdtgrp->closid;
 	u32 rmid = rdtgrp->mon.rmid;
 	struct rdt_mon_domain *d;
+	int cntr_id = -ENOENT;
 	struct cacheinfo *ci;
 	struct mbm_state *m;
 	int err, ret;
 	u64 tval = 0;
 
+	if (rr->is_mbm_cntr) {
+		cntr_id = mbm_cntr_get(rr->r, rr->d, rdtgrp, rr->evtid);
+		if (cntr_id < 0) {
+			rr->err = -ENOENT;
+			return -EINVAL;
+		}
+	}
+
 	if (rr->first) {
-		resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
+		if (rr->is_mbm_cntr)
+			resctrl_arch_reset_cntr(rr->r, rr->d, closid, rmid, cntr_id, rr->evtid);
+		else
+			resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
 		m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
 		if (m)
 			memset(m, 0, sizeof(struct mbm_state));
@@ -379,8 +391,12 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 		/* Reading a single domain, must be on a CPU in that domain. */
 		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask))
 			return -EINVAL;
-		rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
-						 rr->evtid, &tval, rr->arch_mon_ctx);
+		if (rr->is_mbm_cntr)
+			rr->err = resctrl_arch_cntr_read(rr->r, rr->d, closid, rmid, cntr_id,
+							 rr->evtid, &tval);
+		else
+			rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
+							 rr->evtid, &tval, rr->arch_mon_ctx);
 		if (rr->err)
 			return rr->err;
 
@@ -405,8 +421,12 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 	list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
 		if (d->ci_id != rr->ci_id)
 			continue;
-		err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
-					     rr->evtid, &tval, rr->arch_mon_ctx);
+		if (rr->is_mbm_cntr)
+			err = resctrl_arch_cntr_read(rr->r, d, closid, rmid, cntr_id,
+						     rr->evtid, &tval);
+		else
+			err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
+						     rr->evtid, &tval, rr->arch_mon_ctx);
 		if (!err) {
 			rr->val += tval;
 			ret = 0;
@@ -613,11 +633,16 @@ static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_domain *
 	rr.r = r;
 	rr.d = d;
 	rr.evtid = evtid;
-	rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
-	if (IS_ERR(rr.arch_mon_ctx)) {
-		pr_warn_ratelimited("Failed to allocate monitor context: %ld",
-				    PTR_ERR(rr.arch_mon_ctx));
-		return;
+	if (resctrl_arch_mbm_cntr_assign_enabled(r) &&
+	    resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rr.is_mbm_cntr = true;
+	} else {
+		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
+		if (IS_ERR(rr.arch_mon_ctx)) {
+			pr_warn_ratelimited("Failed to allocate monitor context: %ld",
+					    PTR_ERR(rr.arch_mon_ctx));
+			return;
+		}
 	}
 
 	__mon_event_count(rdtgrp, &rr);
@@ -629,7 +654,8 @@ static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_domain *
 	if (is_mba_sc(NULL))
 		mbm_bw_count(rdtgrp, &rr);
 
-	resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
+	if (rr.arch_mon_ctx)
+		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
 }
 
 static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d,
@@ -983,8 +1009,8 @@ static void rdtgroup_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *
  * Return:
  * Valid counter ID on success, or -ENOENT on failure.
  */
-static int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
-			struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
+int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
+		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
 {
 	int cntr_id;
 
-- 
2.34.1


