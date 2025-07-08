Return-Path: <linux-kernel+bounces-722443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A24FAFDAD2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E78188B026
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF7725D535;
	Tue,  8 Jul 2025 22:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0vU3Va+j"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA8A25B1D5;
	Tue,  8 Jul 2025 22:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013122; cv=fail; b=PLSDEtOkOxLIO+nLly+Yu6UTOamcjqaKjT9tC1kQ8KzaohR7qdsEpKDJqGbuNZuMfBNmEXko55s1NFbqUMXfqvFh6YTOWxIUMU1zCUXypu04gvmUix+JDkWWMz2Y1k3yqL82P19Lz6UY8pKY7e8ogY4TtVuHscdQmUN8dlJV9C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013122; c=relaxed/simple;
	bh=z4WNF74PddrCjDZVflm8gNBR3ODPGmBjBRInrSSv1/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBA1YVWccDAauqwUclGS1mrkNNL8nwohq1KjOfvFp8yEfIaSZVjms/vnJjn/IsdX4yLqeifoEMLWKnd5LspIUiUMNEvRj+gfuezK+GXPMmtJRSXVtKs1PMNSogS6S05Zw9zFx2lxFam1sJ68rOg1/yYkEMRYLUGkrXnhrsJ5jXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0vU3Va+j; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmBcNKH457ypIx8OUIPGgH0AI3dURJQLyDrnNGarKwkUOcPyyW4XFAM5lgvpIoBwLANwPu9U89RqNvm1A0Yxyl08X5M3XrRQ+HuJgKn9TO5yg/P6WceJglK4yHhDDiyGDdIeqv+zbSVeWcltoPaamrZcw5bH/nOUVTVbp8F3nZsxvSEKWa6cTr9Ri9Faz67Wj4vE1zYM2EJbivQ6RjznG4+hhp4VzxdAAcQjHz6DNSQ3rFVSWwEzfQBzVcs0a/pRFJZ244CEyBmiqoCXJR2HHKsOgj5ldwwNmXY/jzSIrygH/llk1o8+BrVOeNd1IANutwQqpZAuSJLHc87UWlafdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zw1BIYuvKvMZFAd8zKRhJ9bYZ4i3XZMOv8mq3IhzrVA=;
 b=QcQyQUnhzI9V4zXKdUnkVSc2wlVKIHvcwMdEhzqd+FFvTXZI4UrlZTaoGXyN1dHRjGeyNoDMD/U6NXVzaBSS+PkyOcs1N8OYSo+OZeiExYgVJ89Qxh7rnyci+7s4QBpP2z0nkZ24e7CxWtrqx/sSRBkuAhFdKIsJWye0vEO2QtS+H6vPDxAnEY1FGdOHRErrbWXnYKRng3hax8JqiLWbi1skQfJYUjEn5lDFmjyrWRr08aPjDNA+xrozEmW1m3LBmG6w8TYCKJFCGMabVb2bOtqqwMVyUkW9CD5p9ksAgNL+pTGtIePVWw+S6uueE6z21HYkbPBuUQg543DoPq46Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zw1BIYuvKvMZFAd8zKRhJ9bYZ4i3XZMOv8mq3IhzrVA=;
 b=0vU3Va+jiUe82/T1cbw8bxkJHmWfC5fUexafZsv0TnJ2RjLkdcDjzhK83ih3DmpSqh6tLGhbpjglH7DLna3RASTGdK64SH+XgC3U5gZrDvu00okiRkz5a6vNQNyeQn1DbwePuQyoyUf22WLLURwpkcgFF5cMjELJoGxo4kRqH/Y=
Received: from SJ0PR03CA0237.namprd03.prod.outlook.com (2603:10b6:a03:39f::32)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 22:18:36 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::b1) by SJ0PR03CA0237.outlook.office365.com
 (2603:10b6:a03:39f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.20 via Frontend Transport; Tue,
 8 Jul 2025 22:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:18:35 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:18:32 -0500
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
Subject: [PATCH v15 04/34] x86,fs/resctrl: Prepare for more monitor events
Date: Tue, 8 Jul 2025 17:17:13 -0500
Message-ID: <f1ad773f1448f716444947b90f14899eda8c0a69.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|MN2PR12MB4048:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9e8fca-2ea7-4fb5-6f21-08ddbe6d61af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?veGrhpUIWcNGZ6HB59LfPOTC3q/OJ3K1SwsSLcUMY3au7IMYUg9BtAWIdjkp?=
 =?us-ascii?Q?u55cigo57t1waoqTQFD443Dza0vcF/ZcCMOEV3rjnQcCbT80upJnWDsskjZ0?=
 =?us-ascii?Q?UjeG5ptTJjDvoSjWbnos1e3hAN71gRZ3sWyMW+d8IiQqsj/fWwUs9Jjivrsb?=
 =?us-ascii?Q?b+0OfCGbocZ1juj3y6rh1kWVtzb2L6nuovj2+nrH/w/S5UoKcjj3YOIk7ve1?=
 =?us-ascii?Q?YAxcOiT/PyL+lRoEeZii9hvH46YUUwI18D5Og1jy3L5+jyly49NbLAA9kcDD?=
 =?us-ascii?Q?6ejyZt6rs25+WGKavSL2lctH1vMtVZbyJfm/IJlVD4MhkHw9Pd70mG0BM2KM?=
 =?us-ascii?Q?W4iuMuF15g+MgD8etKxAZED2svMVh/FlmtspZEekVOlaPPNk5JkBStIKl5k2?=
 =?us-ascii?Q?+lLw1KcGZ9xB7aYBoEQ4BTVZncNhKkZbUUNKfpfdRSyx34LddafQGl4GC6Jh?=
 =?us-ascii?Q?MICGVu+/zmoNbY8fUuRMlWzP6cxNIRqHL+cEKDkJ2bBjGkaG/xYzFL4ztIYJ?=
 =?us-ascii?Q?PV8oC9bP10Gwgys0u3ruL1+/ViPADOYBhGadZp3cyQHKy7spdx7T4amTJuxm?=
 =?us-ascii?Q?O9Ls0UUuXdC9ubVqka9UtuloQwOd1ragwAYpcNuGQ2BI2ILoIqh2gxmPpiQ8?=
 =?us-ascii?Q?OC23aHbS+TmsVYP0IGS6QOGGbY8t1PJyvoJjC+SUPd/uP41PYQG+aTs3zUC2?=
 =?us-ascii?Q?dbpFdKjLZpJPXHll5TylAkppEumjecV9dyR/oF6gHAMbDQDL5c+VIOr3H0lW?=
 =?us-ascii?Q?1ae8U+Lxe3ZMTDaNj4KyM27XH3acMfffg6/5QQeQmHIYufNB+FQLkZRqoQVL?=
 =?us-ascii?Q?1epXqqBlfjrAsCyF5+zxEDSnffFFSiI4Cco17lLSWtBZGdeJuMKB7KqtINQG?=
 =?us-ascii?Q?WLssVIgaeZVGoqU9StnTKbH1RJtedlhyBpxwLMlF7Hw9VTlL2x9rSQnuq1MH?=
 =?us-ascii?Q?PkhS5rJ60uo7MYnOJNMZphnFLdep5FsurkFiVuAa9mwQfc74ya7e1v1vORgD?=
 =?us-ascii?Q?esllKtw4qT66isJvXH3Qrtx3Dg13eFeG5lQDzNgTNNvlthDMYGoQ7xEM2GXK?=
 =?us-ascii?Q?tdMzXQnUbNn0crbQA/ZAWTTsGCxZFmfjGnmEL2m0NK8o9BlCX51Vw09VkR9f?=
 =?us-ascii?Q?EU5vhV0OZTvclu1ao48G7cARqrWtnEAoOsoBdIhrHhWtaHTGh7L7c6MwSWwi?=
 =?us-ascii?Q?aJtyu8g/fOhiNR4vhFnK3ZSONiQ/voU7Vikz0mWmsXuILNV8ZyJ3VArKlt57?=
 =?us-ascii?Q?imwBYFSR161jEzcqNM8ZmMPOXWgmSEh9QJU6kttHOHHc0ty0VkdSElgNwTor?=
 =?us-ascii?Q?I6rDWiwh9QwNaNvsFd9X+Y3QEgOxo1YKY9SA7wduoLIZEtdpqrr6fpfU134d?=
 =?us-ascii?Q?MIzRPHl5D1jlIkQaf0Ob1JepBn+D4NH4jrebe37QDfroscDpefp1YmwMHhpa?=
 =?us-ascii?Q?2ylCI2uqxtlrf5dyYoqr5v3FIDBvX0ykSa3Xtwm2cr/fQ2mAtexrW2xNHwyG?=
 =?us-ascii?Q?75iu+o7hjFxntyKBbSEeoHUwYytQ2JPTkJzzfzpNnlLIP+zOQpqkmhPaHg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:18:35.4724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9e8fca-2ea7-4fb5-6f21-08ddbe6d61af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048

From: Tony Luck <tony.luck@intel.com>

There's a rule in computer programming that objects appear zero,
once, or many times. So code accordingly.

There are two MBM events and resctrl is coded with a lot of

        if (local)
                do one thing
        if (total)
                do a different thing

Change the rdt_mon_domain and rdt_hw_mon_domain structures to hold arrays
of pointers to per event data instead of explicit fields for total and
local bandwidth.

Simplify by coding for many events using loops on which are enabled.

Move resctrl_is_mbm_event() to <linux/resctrl.h> so it can be used more
widely. Also provide a for_each_mbm_event_id() helper macro.

Cleanup variable names in functions touched to consistently use
"eventid" for those with type enum resctrl_event_id.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
v15: Picked up Tony's tree.
     rdt-aet-v5.5 branch of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git
     After Reinette's comment on previous version.
     https://lore.kernel.org/lkml/e9eb906f-d463-4c1e-9e15-5ed795fe5366@intel.com/
     https://lore.kernel.org/lkml/b761e6ec-a874-4d06-8437-a3a717a91abb@intel.com/

v14: This is Tony's work. This is part of Tony's telemetry series.
     https://lore.kernel.org/lkml/20250521225049.132551-1-tony.luck@intel.com/

     Tony made special update for me to include in this series.
     https://lore.kernel.org/lkml/20250609162139.91651-1-tony.luck@intel.com/.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 40 +++++++++++----------
 arch/x86/kernel/cpu/resctrl/internal.h |  8 ++---
 arch/x86/kernel/cpu/resctrl/monitor.c  | 36 +++++++++----------
 fs/resctrl/monitor.c                   | 13 ++++---
 fs/resctrl/rdtgroup.c                  | 50 +++++++++++++-------------
 include/linux/resctrl.h                | 23 +++++++++---
 include/linux/resctrl_types.h          |  3 ++
 7 files changed, 96 insertions(+), 77 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 5d14f9a14eda..fbf019c1ff11 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -365,8 +365,10 @@ static void ctrl_domain_free(struct rdt_hw_ctrl_domain *hw_dom)
 
 static void mon_domain_free(struct rdt_hw_mon_domain *hw_dom)
 {
-	kfree(hw_dom->arch_mbm_total);
-	kfree(hw_dom->arch_mbm_local);
+	int idx;
+
+	for_each_mbm_idx(idx)
+		kfree(hw_dom->arch_mbm_states[idx]);
 	kfree(hw_dom);
 }
 
@@ -400,25 +402,27 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_ctrl_domain *
  */
 static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_mon_domain *hw_dom)
 {
-	size_t tsize;
-
-	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID)) {
-		tsize = sizeof(*hw_dom->arch_mbm_total);
-		hw_dom->arch_mbm_total = kcalloc(num_rmid, tsize, GFP_KERNEL);
-		if (!hw_dom->arch_mbm_total)
-			return -ENOMEM;
-	}
-	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID)) {
-		tsize = sizeof(*hw_dom->arch_mbm_local);
-		hw_dom->arch_mbm_local = kcalloc(num_rmid, tsize, GFP_KERNEL);
-		if (!hw_dom->arch_mbm_local) {
-			kfree(hw_dom->arch_mbm_total);
-			hw_dom->arch_mbm_total = NULL;
-			return -ENOMEM;
-		}
+	size_t tsize = sizeof(*hw_dom->arch_mbm_states[0]);
+	enum resctrl_event_id eventid;
+	int idx;
+
+	for_each_mbm_event_id(eventid) {
+		if (!resctrl_is_mon_event_enabled(eventid))
+			continue;
+		idx = MBM_STATE_IDX(eventid);
+		hw_dom->arch_mbm_states[idx] = kcalloc(num_rmid, tsize, GFP_KERNEL);
+		if (!hw_dom->arch_mbm_states[idx])
+			goto cleanup;
 	}
 
 	return 0;
+cleanup:
+	for_each_mbm_idx(idx) {
+		kfree(hw_dom->arch_mbm_states[idx]);
+		hw_dom->arch_mbm_states[idx] = NULL;
+	}
+
+	return -ENOMEM;
 }
 
 static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 5e3c41b36437..58dca892a5df 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -54,15 +54,15 @@ struct rdt_hw_ctrl_domain {
  * struct rdt_hw_mon_domain - Arch private attributes of a set of CPUs that share
  *			      a resource for a monitor function
  * @d_resctrl:	Properties exposed to the resctrl file system
- * @arch_mbm_total:	arch private state for MBM total bandwidth
- * @arch_mbm_local:	arch private state for MBM local bandwidth
+ * @arch_mbm_states:	Per-event pointer to the MBM event's saved state.
+ *			An MBM event's state is an array of struct arch_mbm_state
+ *			indexed by RMID on x86.
  *
  * Members of this structure are accessed via helpers that provide abstraction.
  */
 struct rdt_hw_mon_domain {
 	struct rdt_mon_domain		d_resctrl;
-	struct arch_mbm_state		*arch_mbm_total;
-	struct arch_mbm_state		*arch_mbm_local;
+	struct arch_mbm_state		*arch_mbm_states[QOS_NUM_L3_MBM_EVENTS];
 };
 
 static inline struct rdt_hw_ctrl_domain *resctrl_to_arch_ctrl_dom(struct rdt_ctrl_domain *r)
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 07f8ab097cbe..f01db2034d08 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -161,18 +161,14 @@ static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_mon_domain *hw_do
 						 u32 rmid,
 						 enum resctrl_event_id eventid)
 {
-	switch (eventid) {
-	case QOS_L3_OCCUP_EVENT_ID:
-		return NULL;
-	case QOS_L3_MBM_TOTAL_EVENT_ID:
-		return &hw_dom->arch_mbm_total[rmid];
-	case QOS_L3_MBM_LOCAL_EVENT_ID:
-		return &hw_dom->arch_mbm_local[rmid];
-	default:
-		/* Never expect to get here */
-		WARN_ON_ONCE(1);
+	struct arch_mbm_state *state;
+
+	if (!resctrl_is_mbm_event(eventid))
 		return NULL;
-	}
+
+	state = hw_dom->arch_mbm_states[MBM_STATE_IDX(eventid)];
+
+	return state ? &state[rmid] : NULL;
 }
 
 void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
@@ -201,14 +197,16 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
 void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d)
 {
 	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
-
-	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
-		memset(hw_dom->arch_mbm_total, 0,
-		       sizeof(*hw_dom->arch_mbm_total) * r->num_rmid);
-
-	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
-		memset(hw_dom->arch_mbm_local, 0,
-		       sizeof(*hw_dom->arch_mbm_local) * r->num_rmid);
+	enum resctrl_event_id eventid;
+	int idx;
+
+	for_each_mbm_event_id(eventid) {
+		if (!resctrl_is_mon_event_enabled(eventid))
+			continue;
+		idx = MBM_STATE_IDX(eventid);
+		memset(hw_dom->arch_mbm_states[idx], 0,
+		       sizeof(*hw_dom->arch_mbm_states[0]) * r->num_rmid);
+	}
 }
 
 static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 9e988b2c1a22..dcc6c00eb362 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -346,15 +346,14 @@ static struct mbm_state *get_mbm_state(struct rdt_mon_domain *d, u32 closid,
 				       u32 rmid, enum resctrl_event_id evtid)
 {
 	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
+	struct mbm_state *state;
 
-	switch (evtid) {
-	case QOS_L3_MBM_TOTAL_EVENT_ID:
-		return &d->mbm_total[idx];
-	case QOS_L3_MBM_LOCAL_EVENT_ID:
-		return &d->mbm_local[idx];
-	default:
+	if (!resctrl_is_mbm_event(evtid))
 		return NULL;
-	}
+
+	state = d->mbm_states[MBM_STATE_IDX(evtid)];
+
+	return state ? &state[idx] : NULL;
 }
 
 static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index a7eeb33501da..77336d5e4915 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -127,12 +127,6 @@ static bool resctrl_is_mbm_enabled(void)
 		resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID));
 }
 
-static bool resctrl_is_mbm_event(int e)
-{
-	return (e >= QOS_L3_MBM_TOTAL_EVENT_ID &&
-		e <= QOS_L3_MBM_LOCAL_EVENT_ID);
-}
-
 /*
  * Trivial allocator for CLOSIDs. Use BITMAP APIs to manipulate a bitmap
  * of free CLOSIDs.
@@ -4023,9 +4017,13 @@ static void rdtgroup_setup_default(void)
 
 static void domain_destroy_mon_state(struct rdt_mon_domain *d)
 {
+	int idx;
+
 	bitmap_free(d->rmid_busy_llc);
-	kfree(d->mbm_total);
-	kfree(d->mbm_local);
+	for_each_mbm_idx(idx) {
+		kfree(d->mbm_states[idx]);
+		d->mbm_states[idx] = NULL;
+	}
 }
 
 void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_domain *d)
@@ -4085,32 +4083,34 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d
 static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_domain *d)
 {
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
-	size_t tsize;
+	size_t tsize = sizeof(*d->mbm_states[0]);
+	enum resctrl_event_id eventid;
+	int idx;
 
 	if (resctrl_is_mon_event_enabled(QOS_L3_OCCUP_EVENT_ID)) {
 		d->rmid_busy_llc = bitmap_zalloc(idx_limit, GFP_KERNEL);
 		if (!d->rmid_busy_llc)
 			return -ENOMEM;
 	}
-	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID)) {
-		tsize = sizeof(*d->mbm_total);
-		d->mbm_total = kcalloc(idx_limit, tsize, GFP_KERNEL);
-		if (!d->mbm_total) {
-			bitmap_free(d->rmid_busy_llc);
-			return -ENOMEM;
-		}
-	}
-	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID)) {
-		tsize = sizeof(*d->mbm_local);
-		d->mbm_local = kcalloc(idx_limit, tsize, GFP_KERNEL);
-		if (!d->mbm_local) {
-			bitmap_free(d->rmid_busy_llc);
-			kfree(d->mbm_total);
-			return -ENOMEM;
-		}
+
+	for_each_mbm_event_id(eventid) {
+		if (!resctrl_is_mon_event_enabled(eventid))
+			continue;
+		idx = MBM_STATE_IDX(eventid);
+		d->mbm_states[idx] = kcalloc(idx_limit, tsize, GFP_KERNEL);
+		if (!d->mbm_states[idx])
+			goto cleanup;
 	}
 
 	return 0;
+cleanup:
+	bitmap_free(d->rmid_busy_llc);
+	for_each_mbm_idx(idx) {
+		kfree(d->mbm_states[idx]);
+		d->mbm_states[idx] = NULL;
+	}
+
+	return -ENOMEM;
 }
 
 int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_domain *d)
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 40aba6b5d4f0..478d7a935ca3 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -161,8 +161,9 @@ struct rdt_ctrl_domain {
  * @hdr:		common header for different domain types
  * @ci_id:		cache info id for this domain
  * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
- * @mbm_total:		saved state for MBM total bandwidth
- * @mbm_local:		saved state for MBM local bandwidth
+ * @mbm_states:		Per-event pointer to the MBM event's saved state.
+ *			An MBM event's state is an array of struct mbm_state
+ *			indexed by RMID on x86 or combined CLOSID, RMID on Arm.
  * @mbm_over:		worker to periodically read MBM h/w counters
  * @cqm_limbo:		worker to periodically read CQM h/w counters
  * @mbm_work_cpu:	worker CPU for MBM h/w counters
@@ -172,8 +173,7 @@ struct rdt_mon_domain {
 	struct rdt_domain_hdr		hdr;
 	unsigned int			ci_id;
 	unsigned long			*rmid_busy_llc;
-	struct mbm_state		*mbm_total;
-	struct mbm_state		*mbm_local;
+	struct mbm_state		*mbm_states[QOS_NUM_L3_MBM_EVENTS];
 	struct delayed_work		mbm_over;
 	struct delayed_work		cqm_limbo;
 	int				mbm_work_cpu;
@@ -376,6 +376,21 @@ bool resctrl_is_mon_event_enabled(enum resctrl_event_id eventid);
 
 bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
 
+static inline bool resctrl_is_mbm_event(enum resctrl_event_id eventid)
+{
+	return (eventid >= QOS_L3_MBM_TOTAL_EVENT_ID &&
+		eventid <= QOS_L3_MBM_LOCAL_EVENT_ID);
+}
+
+/* Iterate over all memory bandwidth events */
+#define for_each_mbm_event_id(eventid)				\
+	for (eventid = QOS_L3_MBM_TOTAL_EVENT_ID;		\
+	     eventid <= QOS_L3_MBM_LOCAL_EVENT_ID; eventid++)
+
+/* Iterate over memory bandwidth arrays in domain structures */
+#define for_each_mbm_idx(idx)					\
+	for (idx = 0; idx < QOS_NUM_L3_MBM_EVENTS; idx++)
+
 /**
  * resctrl_arch_mon_event_config_write() - Write the config for an event.
  * @config_info: struct resctrl_mon_config_info describing the resource, domain
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index 2dadbc54e4b3..d98351663c2c 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -51,4 +51,7 @@ enum resctrl_event_id {
 	QOS_NUM_EVENTS,
 };
 
+#define QOS_NUM_L3_MBM_EVENTS	(QOS_L3_MBM_LOCAL_EVENT_ID - QOS_L3_MBM_TOTAL_EVENT_ID + 1)
+#define MBM_STATE_IDX(evt)	((evt) - QOS_L3_MBM_TOTAL_EVENT_ID)
+
 #endif /* __LINUX_RESCTRL_TYPES_H */
-- 
2.34.1


