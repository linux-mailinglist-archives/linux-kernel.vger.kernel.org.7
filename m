Return-Path: <linux-kernel+bounces-722448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C0EAFDADE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D564E3FE3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DB2264A86;
	Tue,  8 Jul 2025 22:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3w0v0F/4"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CEC2627F9;
	Tue,  8 Jul 2025 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013170; cv=fail; b=HWNPuv0kwkZKaFH9YEq/C8/clxQb3lbNAU2LkN3mp3GPICiWbbFQqrjBzJXQ50z22PwK6TdB3u81+0XQ1HJUTbIFqi5K/raEq+omCdNEN2OYo3pAgPjBF7Xq1ymoLb/4cqbXCX+Sqw7bHhaX+CABKEOOj3nD8tNWzliB5Hct7NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013170; c=relaxed/simple;
	bh=2SVpdfoLXSgvGHUU47DgjuWCmhw4iBeNKc3/bqxVomQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kg0e8Ik7mec1qrlIF+EJbrE5pdo/gFQ/NJUXvTHLNVAZfx+Ewwa7tZP2v0pW52XHb5OqBZPJIJTgJIQlXxbzLOncM5Ih5lTF5PQZIIrqZDZrgf+7vOL+RzWgPSarNfyufVUsKMQq/A3LdIO3rvuWtONDmRtde0UuQD6PDMA8+n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3w0v0F/4; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uifV5afdpalS2aUybVY9Hy4sglVBfDUkNbuZBcSYqHZQSxMQRlNL/++OHBunnYjBq0ni8xqCIZRl9ADahaaPbu1ZlUf45fKXhhIzv/w05rcvNrzfGpNdoXrtCXN+R61WRYfZTYpjyqnGrBNqNuiyH2JFt2KanhBMqdTR1wiAas/iovS7Pd1pZbFIpz8KrVBNGpst53zysnpXToXjXv7TlkHITeu1lW0ycSufMuqzTJNS/OMOpOnW/LWbQTHKtro6PaCVEVO600k5SC9omzGN+MJ/OTGC908aJPCfXyAd87yrwAIk3602uNyuOMRlpV4iOJUArBEhoBJ6YqWUzGffQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JOXURetD78pImwgq54DmEjH/3XHWCcegWlIRCaNTqs=;
 b=BmcT6jA7vz5FWiOogpg6VcBMLJ5Xt9AQNVYoR9if+wjSgCeGa4bxAbtpHWT+uFLveola/DPsH1YUywpHnHqD4VfEhktawaxnvnpv6ghHR+GxNdVj+1xe/hLj1QMyRPBOaWY1xEzetT90HTJGS+dfur6hYTtjX25W+sXmxBnnnLzD/lzcmmCbYwZeJfBhI+x1lEX+bZmeqKokaTHevp3s8BZRbwbA5DNUroPiGZWiB6C77vHZ44pgWl08YixC9tCVTEkagR1J05GR1kqTZ5Jb1HJXSdjfdsV3m6C6HwXOLvcb2KJh1IEJIp7FsqzSo+A9WP5oPGwhHOanpfXikSG5Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JOXURetD78pImwgq54DmEjH/3XHWCcegWlIRCaNTqs=;
 b=3w0v0F/4dhdUt6KucVG+4uV7IuMpaAU3RfChFaJ9nomCZqn0E2e4zP6JRB2z/i4tlfpMUL0nn6/g04K8mqPgf4Wz4cspikXlCsO0VVUylZ4nl26De/KX1vBlml5WVAN8G8gedOnPIW3BHPSTZId6fzqq8KFPtOJQAAATh+nZ8E4=
Received: from BYAPR07CA0062.namprd07.prod.outlook.com (2603:10b6:a03:60::39)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 8 Jul
 2025 22:19:20 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::55) by BYAPR07CA0062.outlook.office365.com
 (2603:10b6:a03:60::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 22:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:19:20 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:19:07 -0500
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
Subject: [PATCH v15 08/34] x86,fs/resctrl: Detect Assignable Bandwidth Monitoring feature details
Date: Tue, 8 Jul 2025 17:17:17 -0500
Message-ID: <e48edcbf4fe2c258ab8d38d9ff78fdb8849c353b.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: 160d919a-58a2-470a-b549-08ddbe6d7c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I3BzXvMLbnpM8A/9nstLOR7MdXSIZUqYm8g7qMxPBBwh9MTf/F+q3b7TdWt6?=
 =?us-ascii?Q?jsq771nQVmWHK+O77DlTzgu/u8GMcbaa7HWLXwvMUrr824KkSRNnGF9Clhd8?=
 =?us-ascii?Q?nHgvoGaCXhRzFeIgpGBUXbBDENG9y7970+pLahfWFEFVIT8PJvfRPs8SComY?=
 =?us-ascii?Q?3EGmEiCOID0yV+EFqHyOY1pZ2OrY136aot1eONiwjbapGoGSgpwxHXrGuZFj?=
 =?us-ascii?Q?CMcdeBrDnAnNXN/nK9r6ioSeZInGNeEgFprvYh/KNFPSxSZgzFlqLFCGIcXG?=
 =?us-ascii?Q?x9nDfr4WAVZO6bG2F+X/C/QyDhaAijQGMXVORDlUkWwLkwh4F9rT+4Zduynu?=
 =?us-ascii?Q?6opXyF8t34Wh1TKNCVyap9Jo5KlggsRfA4SPCTD1nIuVBpgU+/neQ0WcaHDG?=
 =?us-ascii?Q?RvFOjGUKVMcfHL98wnr0kJgoNZkyuYg8WBl7LL9zABE1RJ2UAs6RoGNFi023?=
 =?us-ascii?Q?ct8BEliw4AddV4PwB0iWl6ksD3dbwMZFJm01/1ptyhdVv5hzl/MQsJLdzLPB?=
 =?us-ascii?Q?HU1M6s7kNTDUeE64jntqBabGY1YTK5GxAiyBJPaDAIgwQxfUC01FjeP3T4Kz?=
 =?us-ascii?Q?Zxup0JT898USmYTYS4YCiPhidKdzMGrH8LpVDhTz7RyemQsC0soigHNJCN8a?=
 =?us-ascii?Q?BYwp11JIezcFF0vSLJ1KrxclTRznnQH8IMkcKccRsCFesWjZHxNofsunbeMd?=
 =?us-ascii?Q?xTD1wW+/SxysmYUUdExRBZKXHsMxRijBxpzrNKf0peXDOu2YBvPSZYye8npv?=
 =?us-ascii?Q?kg4rGwoPZrswZ/POEEMLluXoFwQpzbLl6cJfZtedeEeuhLIKd+5fLN/hZtAo?=
 =?us-ascii?Q?cCL51AJI0P8asX5HH1EfUQGN3Zx6JObljY+KDPvV6KKtKsSJnHa9Xw6Y++1h?=
 =?us-ascii?Q?sizftgSxHETzxA0/KkNrZmVaoWNk0UvJOW9hQCA05jU5O/oyKe+A5oKMmwTw?=
 =?us-ascii?Q?E9RTzTylVeEJ1MWaNQIlJE0MSlTWP8g7X0h+8e54oaLRcaPNv7tFaDlLqK0X?=
 =?us-ascii?Q?IOQdnjhGfOLuIoi7CivZex4422sucNkyU0vU0q7IBDN0iteXMauRBAeppNRs?=
 =?us-ascii?Q?TSULyWvTV3O3mjR4+jhWDI41ULerQq+mndCKOQHFQg/5ghZx1mjJApxCy0+P?=
 =?us-ascii?Q?LlYrmMzszYB9kOwQzmyGhQW8jxpQ2jKsJrQwmqQl403pEN8ebO9E/yOPFA62?=
 =?us-ascii?Q?hnwpM6/URycVSL0jJm+kAkgRvQ6kUb3ktZCo4ANPGnXlTtRqZF1IC1NT9EiD?=
 =?us-ascii?Q?DviWfRmuFmGCEOaC+vnmaghwDphwCg+Hvmyn5hWwI5pEV/TG6ZpbUmiHYmbr?=
 =?us-ascii?Q?f9P0JBxph8QMHBD60sgWUSo3v6pW8z2FmCEuSwzReNhOwSJlOYQox9No2jZs?=
 =?us-ascii?Q?ojRjyTw0XJAc1bVdNaYwNGTJC4yr1FIo7+0Q2vvwlrKOyBwbBW0GSKt7SFjQ?=
 =?us-ascii?Q?Tn0QgoeifRmigjG56CkuKJ39Ti6YaADYOBNGqNudd2XI4pDd4IGQJJXspn1U?=
 =?us-ascii?Q?8QCxF+pbbQoEUleDvno9H+e3Ujj5q+Oik5e7nJv3F7aa+k88DyoHitIPWg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:19:20.0055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 160d919a-58a2-470a-b549-08ddbe6d7c3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972

ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
Bits Description
15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
     Monitoring Counter ID + 1

The feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Detect the feature and number of assignable counters supported. Also,
enable QOS_L3_MBM_TOTAL_EVENT_ID and QOS_L3_MBM_LOCAL_EVENT_ID upon
detecting the ABMC feature. The current expectation is to support
these two events by default when ABMC is enabled.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v15: Minor update to changelog.
     Added check in resctrl_cpu_detect().
     Moved the resctrl_enable_mon_event() to resctrl_mon_resource_init().

v14: Updated enumeration to support ABMC regardless of MBM total and local support.
     Updated the changelog accordingly.

v13: No changes.

v12: Resolved conflicts because of latest merge.
     Removed Reviewed-by as the patch has changed.

v11: No changes.

v10: No changes.

v9: Added Reviewed-by tag. No code changes

v8: Used GENMASK for the mask.

v7: Removed WARN_ON for num_mbm_cntrs. Decided to dynamically allocate the
    bitmap. WARN_ON is not required anymore.
    Removed redundant comments.

v6: Commit message update.
    Renamed abmc_capable to mbm_cntr_assignable.

v5: Name change num_cntrs to num_mbm_cntrs.
    Moved abmc_capable to resctrl_mon.

v4: Removed resctrl_arch_has_abmc(). Added all the code inline. We dont
    need to separate this as arch code.

v3: Removed changes related to mon_features.
    Moved rdt_cpu_has to core.c and added new function resctrl_arch_has_abmc.
    Also moved the fields mbm_assign_capable and mbm_assign_cntrs to
    rdt_resource. (James)

v2: Changed the field name to mbm_assign_capable from abmc_capable.
---
 arch/x86/kernel/cpu/resctrl/core.c    |  3 ++-
 arch/x86/kernel/cpu/resctrl/monitor.c | 11 ++++++++---
 fs/resctrl/monitor.c                  |  5 +++++
 include/linux/resctrl.h               |  4 ++++
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 267e9206a999..b48cc67cbbe3 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -990,7 +990,8 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
 
 	if (cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC) ||
 	    cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL) ||
-	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)) {
+	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL) ||
+	    cpu_has(c, X86_FEATURE_ABMC)) {
 		u32 eax, ebx, ecx, edx;
 
 		/* QoS sub-leaf, EAX=0Fh, ECX=1 */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 2558b1bdef8b..0a695ce68f46 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -339,6 +339,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	unsigned int threshold;
+	u32 eax, ebx, ecx, edx;
 
 	snc_nodes_per_l3_cache = snc_get_config();
 
@@ -368,14 +369,18 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	 */
 	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(threshold);
 
-	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
-		u32 eax, ebx, ecx, edx;
-
+	if (rdt_cpu_has(X86_FEATURE_BMEC) || rdt_cpu_has(X86_FEATURE_ABMC)) {
 		/* Detect list of bandwidth sources that can be tracked */
 		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
 		r->mon.mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
 	}
 
+	if (rdt_cpu_has(X86_FEATURE_ABMC)) {
+		r->mon.mbm_cntr_assignable = true;
+		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
+		r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
+	}
+
 	r->mon_capable = true;
 
 	return 0;
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index dcc6c00eb362..7e816341da6a 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -924,6 +924,11 @@ int resctrl_mon_resource_init(void)
 	else if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
 		mba_mbps_default_event = QOS_L3_MBM_TOTAL_EVENT_ID;
 
+	if (r->mon.mbm_cntr_assignable) {
+		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
+		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index fe2af6cb96d4..eb80cc233be4 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -260,10 +260,14 @@ enum resctrl_schema_fmt {
  * @num_rmid:		Number of RMIDs available.
  * @mbm_cfg_mask:	Memory transactions that can be tracked when bandwidth
  *			monitoring events can be configured.
+ * @num_mbm_cntrs:	Number of assignable counters.
+ * @mbm_cntr_assignable:Is system capable of supporting counter assignment?
  */
 struct resctrl_mon {
 	int			num_rmid;
 	unsigned int		mbm_cfg_mask;
+	int			num_mbm_cntrs;
+	bool			mbm_cntr_assignable;
 };
 
 /**
-- 
2.34.1


