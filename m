Return-Path: <linux-kernel+bounces-722441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19202AFDAD0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A552C7AEF7A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD2D2459F1;
	Tue,  8 Jul 2025 22:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N7reW8Kx"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11E725E469;
	Tue,  8 Jul 2025 22:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013104; cv=fail; b=owLgDt60KxHBBgIfA+erzoWwg/PNpH441Wv7yL7ec1rsf7mmuDYhhNMSAOEGkxmZ5W5+hp//PQjJkxkvk/NvpmXmKAUZRPExzH70fo5CEEjyLDW/oE7YB5hSk37PniT5DrvEGNp1G8UmlQUs6mtH3Xpw9mIstbtoLUCDeBV5GlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013104; c=relaxed/simple;
	bh=KeO6caJlBDHEBUnZlAKUj14CPVvgCBCpFe5eFp1NSzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LhSuJaLONyfFPmAVUu5KVM7DGqmUTZkA+j7rEu3sd5edCQaeU/wbW/XrNgU3JXXmYIZ7OfFcnzZhFhzqQYBcN58AABy77HkdiYJGBrumdKFzeXffceRIbVFQxhhyHluP08o1JVLdmRD+3pqKLYOcLxdKY7p8308KvulGgMgdE24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N7reW8Kx; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXqEcMqYwAkP+ZYbKCy8INTSSyct6h3yhhfYC9dUcevr15V3pSTbAgxFxPm94zNZMEpOUuVsAs3i/oDPckLBuxg5bcnSrzmTiI3Wzmwv7eazLAr9Ea+Sfvi0werCm053Dq/CSxqu2Va9n3L5FhNxTmXX09xbpqTZLt9w/CYP7ailisy98HAjtRFFYSga7h19MUW3xBIcdtxRCsFfxS1tcoFIuw1WLSlwthYqb/xlJMCriqEKw9uvzw0oBXNIPLsJNKvJwqrGVmRlS3SmifjhYBR1ggJFikgTNWUoiTVGj8Hlb/UBdCUuH5NuGYoiSH+D5fWFWunoCCqPfzDxjq46cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pF5kYPo4rD8ZTkwJg+OJ3LkW4b6hRsqurweXUDOaN6s=;
 b=bpRl43hMy6L8vd6kQWxCkFkY7SdI95m2Tc4SDOra5T0sNIJjnTzsiFk2YKTdvPyQJVmB1qgMq8mV8rlh1aI6L3k5dzYspDjwzesTxHvEYEg73+3jQvhODyEF4mTUZgUHzb27HlJRf9CavsNHut7hl1CY99vECamWWeCAmWdA3MlSF/09QiRh062/qPUgOUB82ADtLLF6T1XXJ7Q+G4Y9rnItau4J634oICQb8ZnW5ixhabJlSq+XSfto6qSOcKtq/43+IEbKwcD9lPohwmD862rI7wiBD7Abq9ozYBtpACGubQx/ItnGR47uwMYyzFSFNrUH6sMPqJUBiTW3EupHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pF5kYPo4rD8ZTkwJg+OJ3LkW4b6hRsqurweXUDOaN6s=;
 b=N7reW8Kxs+qCrokGRqE0tvpFEm042Z7l7fAkoU2WWSYnJmxsNfbx0ygBAMrpu8ZRFkZLr8Q5eBPwOKHfvhHlqDoDE2X1Di4ElRXT4uh2VBbCEzAqkptfiJ6zk4RILkJpEkjFNjH3f7bjAkdII3VKQjBdR4JjRZfoQLOsmBpcqW4=
Received: from BYAPR07CA0049.namprd07.prod.outlook.com (2603:10b6:a03:60::26)
 by DS0PR12MB7947.namprd12.prod.outlook.com (2603:10b6:8:150::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Tue, 8 Jul
 2025 22:18:20 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::9e) by BYAPR07CA0049.outlook.office365.com
 (2603:10b6:a03:60::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 22:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:18:18 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:18:15 -0500
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
Subject: [PATCH v15 02/34] x86,fs/resctrl: Replace architecture event enabled checks
Date: Tue, 8 Jul 2025 17:17:11 -0500
Message-ID: <230e150029800d4036b169bf112a6ab623c2f36a.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|DS0PR12MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc10d46-308a-4022-70cf-08ddbe6d5754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A74rShIpP4xQzpATWENGYs/30SJJ8lJGJtwIAiek/bKiCGpJEHfC+CEkurlY?=
 =?us-ascii?Q?f2vMsjz7/bfFY1FVZ2owbh+k//clXtpZnF/b1buUgWi+GGNxNyFbcOPjbdr2?=
 =?us-ascii?Q?hlr5rJ7ripSlTFxYhi28WY/1HtFuY81umNEVQGQSj4Ujk0cnn5pVa1r2HP9P?=
 =?us-ascii?Q?38YGFkREYVUsETHru0mXM7CFg1HyvfPZpMZqdhsODC+kpL2E4g2M/zc2Nq1Q?=
 =?us-ascii?Q?YbymcDObTaK1mWcxMoHwsB0nAlQukaEzHUZBzzqUvK+9lFeVmVjjJKWgSeNi?=
 =?us-ascii?Q?0gOBpFDHjUCOQs/KGMHt1I7xvF2iHMBmagO+zkL/Cc+bNKu2JCPFjaOtxN+S?=
 =?us-ascii?Q?y8mEHzuwOQzX8GgP2ZDZ0vZOseSwImUog4cVS9ZEVa9z0VXCuonTGN5wgzqI?=
 =?us-ascii?Q?Aq/vGp7GlEjpgn3UWL1VkX/GM0x/xve3BqtaxwPbmSNJlumIt9MXtOffVKQE?=
 =?us-ascii?Q?EV9b7jlxebcaHJogjKO+AvsfCj5z+sfvBx2EXjauq+uZG8TAopfFFXkIp/ci?=
 =?us-ascii?Q?bzkDYzmJ61nzdGefcQUIDbAIdxlCl4xDMTiDsGQxJrXOjLieM3SgR7Xh7IvR?=
 =?us-ascii?Q?4lf/kl8/tbnazkLSU75y2QE3kg+FX49L9lAkdgv2RihgPeztCe2ReywvOOfB?=
 =?us-ascii?Q?9tUEVTtNVhl+kOXbRta1p80xDSWi8DDGZS+cnm2RhKW9u5TohIOBhFkQ2OLf?=
 =?us-ascii?Q?sCTmVynYcCJ5VUC1Bk92PzW00wyzo3CQmOLF25R7eDjh2e9Jj66rPr5Y1Wpd?=
 =?us-ascii?Q?y1UIqvYJWeB8eZg+JiUkdW5k1K1yvvB/orDs/bAfkN7jgmdHy+Y5OKg62J+X?=
 =?us-ascii?Q?1pdNQQ+x2HFZ1PjtKLXmh998lKYB2KAGP7YXFdYVutOSFvk7u1JDO+7c7Prn?=
 =?us-ascii?Q?A9MGTq7g/7QfL277pGpR+C/Gl3FJ0tTH8Vg1msSxduftWuusn7x1vfpyjEDp?=
 =?us-ascii?Q?IB9UBLrREWQHtzJ7H0VkWvnqhpOKlj7Qzpl+buEyZQ7lj0CpP16JX5ENdgSb?=
 =?us-ascii?Q?98lxiE2pwU1hHJHx5cfXR0hI2F8QOvmpTQoNtMAM3oF3y5huhYuYNMZ+sf8O?=
 =?us-ascii?Q?pj1SSV0QG4GDf0oaXk01L5HYWmApk522iEUBYT8q4VYjZaVB/0syULTWclAf?=
 =?us-ascii?Q?mpvuCId55JvSyaVK9Naoo+e10QGnJnwWdFtM/mr7BswhfB84cBAjbeN7jz/m?=
 =?us-ascii?Q?en0Z3Bf9eFoqdHBDO86BkhHL/p8wGeiYumpM0J4bh8aseE+4fHSNRUkHATtj?=
 =?us-ascii?Q?/3qIkA9ZJT8RWB398zwgNbdSwzJFKk4J78+pngT0/6adBtQ0c/SiRUb2868b?=
 =?us-ascii?Q?dyltChV4T29QSFJMQH3Tr2E5gZsM20ZtQMvgfySGorhLghnpVJEFsPFYjaD4?=
 =?us-ascii?Q?0//OMuxhEHDlo8pb5bMdzXVtTectgalxCaHfCty5/IVjmCZsJkp0OjaN/8Xk?=
 =?us-ascii?Q?3O1SZEWJNpsvjVtoZqeKsjaPkD+uSVIdxfyXZbsI5f01xkfrzdObdfGDL3PH?=
 =?us-ascii?Q?RAoPOYy8R4rilKi2hZnXlib5/3r8Gib23kHPCV4QwyUUfsj9P3E1RdJqwQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:18:18.0997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc10d46-308a-4022-70cf-08ddbe6d5754
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7947

From: Tony Luck <tony.luck@intel.com>

The resctrl file system now has complete knowledge of the status
of every event. So there is no need for per-event function calls
to check.

Replace each of the resctrl_arch_is_{event}enabled() calls with
resctrl_is_mon_event_enabled(QOS_{EVENT}).

No functional change.

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
 arch/x86/include/asm/resctrl.h        | 15 ---------------
 arch/x86/kernel/cpu/resctrl/core.c    |  4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c |  4 ++--
 fs/resctrl/ctrlmondata.c              |  4 ++--
 fs/resctrl/monitor.c                  | 16 +++++++++++-----
 fs/resctrl/rdtgroup.c                 | 18 +++++++++---------
 include/linux/resctrl.h               |  2 ++
 7 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index feb93b50e990..b1dd5d6b87db 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -84,21 +84,6 @@ static inline void resctrl_arch_disable_mon(void)
 	static_branch_dec_cpuslocked(&rdt_enable_key);
 }
 
-static inline bool resctrl_arch_is_llc_occupancy_enabled(void)
-{
-	return (rdt_mon_features & (1 << QOS_L3_OCCUP_EVENT_ID));
-}
-
-static inline bool resctrl_arch_is_mbm_total_enabled(void)
-{
-	return (rdt_mon_features & (1 << QOS_L3_MBM_TOTAL_EVENT_ID));
-}
-
-static inline bool resctrl_arch_is_mbm_local_enabled(void)
-{
-	return (rdt_mon_features & (1 << QOS_L3_MBM_LOCAL_EVENT_ID));
-}
-
 /*
  * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
  *
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 7fcae25874fe..1a319ce9328c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -402,13 +402,13 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_mon_domain *hw_dom)
 {
 	size_t tsize;
 
-	if (resctrl_arch_is_mbm_total_enabled()) {
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID)) {
 		tsize = sizeof(*hw_dom->arch_mbm_total);
 		hw_dom->arch_mbm_total = kcalloc(num_rmid, tsize, GFP_KERNEL);
 		if (!hw_dom->arch_mbm_total)
 			return -ENOMEM;
 	}
-	if (resctrl_arch_is_mbm_local_enabled()) {
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID)) {
 		tsize = sizeof(*hw_dom->arch_mbm_local);
 		hw_dom->arch_mbm_local = kcalloc(num_rmid, tsize, GFP_KERNEL);
 		if (!hw_dom->arch_mbm_local) {
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c261558276cd..61d38517e2bf 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -207,11 +207,11 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *
 {
 	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
 
-	if (resctrl_arch_is_mbm_total_enabled())
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
 		memset(hw_dom->arch_mbm_total, 0,
 		       sizeof(*hw_dom->arch_mbm_total) * r->num_rmid);
 
-	if (resctrl_arch_is_mbm_local_enabled())
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
 		memset(hw_dom->arch_mbm_local, 0,
 		       sizeof(*hw_dom->arch_mbm_local) * r->num_rmid);
 }
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index d98e0d2de09f..ad7ffc6acf13 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -473,12 +473,12 @@ ssize_t rdtgroup_mba_mbps_event_write(struct kernfs_open_file *of,
 	rdt_last_cmd_clear();
 
 	if (!strcmp(buf, "mbm_local_bytes")) {
-		if (resctrl_arch_is_mbm_local_enabled())
+		if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
 			rdtgrp->mba_mbps_event = QOS_L3_MBM_LOCAL_EVENT_ID;
 		else
 			ret = -EINVAL;
 	} else if (!strcmp(buf, "mbm_total_bytes")) {
-		if (resctrl_arch_is_mbm_total_enabled())
+		if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
 			rdtgrp->mba_mbps_event = QOS_L3_MBM_TOTAL_EVENT_ID;
 		else
 			ret = -EINVAL;
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 2313e48de55f..9e988b2c1a22 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -336,7 +336,7 @@ void free_rmid(u32 closid, u32 rmid)
 
 	entry = __rmid_entry(idx);
 
-	if (resctrl_arch_is_llc_occupancy_enabled())
+	if (resctrl_is_mon_event_enabled(QOS_L3_OCCUP_EVENT_ID))
 		add_rmid_to_limbo(entry);
 	else
 		list_add_tail(&entry->list, &rmid_free_lru);
@@ -637,10 +637,10 @@ static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d,
 	 * This is protected from concurrent reads from user as both
 	 * the user and overflow handler hold the global mutex.
 	 */
-	if (resctrl_arch_is_mbm_total_enabled())
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
 		mbm_update_one_event(r, d, closid, rmid, QOS_L3_MBM_TOTAL_EVENT_ID);
 
-	if (resctrl_arch_is_mbm_local_enabled())
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
 		mbm_update_one_event(r, d, closid, rmid, QOS_L3_MBM_LOCAL_EVENT_ID);
 }
 
@@ -879,6 +879,12 @@ void resctrl_enable_mon_event(enum resctrl_event_id eventid)
 	mon_event_all[eventid].enabled = true;
 }
 
+bool resctrl_is_mon_event_enabled(enum resctrl_event_id eventid)
+{
+	return eventid >= QOS_FIRST_EVENT && eventid < QOS_NUM_EVENTS &&
+	       mon_event_all[eventid].enabled;
+}
+
 /**
  * resctrl_mon_resource_init() - Initialise global monitoring structures.
  *
@@ -914,9 +920,9 @@ int resctrl_mon_resource_init(void)
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 	}
 
-	if (resctrl_arch_is_mbm_local_enabled())
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
 		mba_mbps_default_event = QOS_L3_MBM_LOCAL_EVENT_ID;
-	else if (resctrl_arch_is_mbm_total_enabled())
+	else if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
 		mba_mbps_default_event = QOS_L3_MBM_TOTAL_EVENT_ID;
 
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index b95501d4b5de..a7eeb33501da 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -123,8 +123,8 @@ void rdt_staged_configs_clear(void)
 
 static bool resctrl_is_mbm_enabled(void)
 {
-	return (resctrl_arch_is_mbm_total_enabled() ||
-		resctrl_arch_is_mbm_local_enabled());
+	return (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID) ||
+		resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID));
 }
 
 static bool resctrl_is_mbm_event(int e)
@@ -196,7 +196,7 @@ static int closid_alloc(void)
 	lockdep_assert_held(&rdtgroup_mutex);
 
 	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) &&
-	    resctrl_arch_is_llc_occupancy_enabled()) {
+	    resctrl_is_mon_event_enabled(QOS_L3_OCCUP_EVENT_ID)) {
 		cleanest_closid = resctrl_find_cleanest_closid();
 		if (cleanest_closid < 0)
 			return cleanest_closid;
@@ -4051,7 +4051,7 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d
 
 	if (resctrl_is_mbm_enabled())
 		cancel_delayed_work(&d->mbm_over);
-	if (resctrl_arch_is_llc_occupancy_enabled() && has_busy_rmid(d)) {
+	if (resctrl_is_mon_event_enabled(QOS_L3_OCCUP_EVENT_ID) && has_busy_rmid(d)) {
 		/*
 		 * When a package is going down, forcefully
 		 * decrement rmid->ebusy. There is no way to know
@@ -4087,12 +4087,12 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_domain
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	size_t tsize;
 
-	if (resctrl_arch_is_llc_occupancy_enabled()) {
+	if (resctrl_is_mon_event_enabled(QOS_L3_OCCUP_EVENT_ID)) {
 		d->rmid_busy_llc = bitmap_zalloc(idx_limit, GFP_KERNEL);
 		if (!d->rmid_busy_llc)
 			return -ENOMEM;
 	}
-	if (resctrl_arch_is_mbm_total_enabled()) {
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID)) {
 		tsize = sizeof(*d->mbm_total);
 		d->mbm_total = kcalloc(idx_limit, tsize, GFP_KERNEL);
 		if (!d->mbm_total) {
@@ -4100,7 +4100,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_domain
 			return -ENOMEM;
 		}
 	}
-	if (resctrl_arch_is_mbm_local_enabled()) {
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID)) {
 		tsize = sizeof(*d->mbm_local);
 		d->mbm_local = kcalloc(idx_limit, tsize, GFP_KERNEL);
 		if (!d->mbm_local) {
@@ -4145,7 +4145,7 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
 					   RESCTRL_PICK_ANY_CPU);
 	}
 
-	if (resctrl_arch_is_llc_occupancy_enabled())
+	if (resctrl_is_mon_event_enabled(QOS_L3_OCCUP_EVENT_ID))
 		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
 
 	/*
@@ -4220,7 +4220,7 @@ void resctrl_offline_cpu(unsigned int cpu)
 			cancel_delayed_work(&d->mbm_over);
 			mbm_setup_overflow_handler(d, 0, cpu);
 		}
-		if (resctrl_arch_is_llc_occupancy_enabled() &&
+		if (resctrl_is_mon_event_enabled(QOS_L3_OCCUP_EVENT_ID) &&
 		    cpu == d->cqm_work_cpu && has_busy_rmid(d)) {
 			cancel_delayed_work(&d->cqm_limbo);
 			cqm_setup_limbo_handler(d, 0, cpu);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 2944042bd84c..40aba6b5d4f0 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -372,6 +372,8 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
 void resctrl_enable_mon_event(enum resctrl_event_id eventid);
 
+bool resctrl_is_mon_event_enabled(enum resctrl_event_id eventid);
+
 bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
 
 /**
-- 
2.34.1


