Return-Path: <linux-kernel+bounces-878773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9693AC216CF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0316834F8C5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6873683AE;
	Thu, 30 Oct 2025 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PykZiGP8"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013032.outbound.protection.outlook.com [40.93.196.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5D93683AD;
	Thu, 30 Oct 2025 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844587; cv=fail; b=g43rret4PeOckFSsxyvC9ytklpqjYKclwr6tyzFujkZhqK4DBd9/H6s9ClTYMCsKFIkhk+V8HGt3u+7NU41xZxovGgSnnfsBCnE7zbxjLTJvwkSCXIVArJRFbYi5XYrcvzkeo+HCegqw52hsCJYZygSPcXpEuk6JuJT3RuM/4eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844587; c=relaxed/simple;
	bh=nb0PO5PxOqGrNxsx1a3fR2hJT/msyYia1PHLv2J3YPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuQgkY/3afVKGlRbiXxBQTYniY6sUKE5SUcHIEOwqbkysCFR0xEI28erZ1RhjKoxfma64BEod0+BPagDJ6nPG7RM9ZZesdM7hDKiq6qaqBvt2+V2d9/9T6Bp9jOEILahjfnveob4gHYJWQvvysjG1QGTNkMWbOy8z9T05ltS/EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PykZiGP8; arc=fail smtp.client-ip=40.93.196.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5C/NWZfBzcey6IpGvY/RebbAZ67gYVIr49gpGFnvyHetB6PuJbLfqjgEXWIqvUs5dlqI329ug4qEtHWWt2+7+CcX2JwCmf0tihDqiMdUjjg0eYmwthlVqLuXAQa1j6FJE2U7/ccN+50uaj93x70gB7Ek9JdYq3Fo3J/3qrybIR0aV7VnStKXvAa/zRJ81ElGd8BlpUO98CUMeyL3FCfJuv+1KzkTGGPUFobWtEuvzOIIB++npmSlZbAZ30hdOWSVleCm/ny+njJTBP00oqPd/PEzefEFr4R30u6tfmxLw+WEOMqRvA2YA8zLXd1I5L6syDPKuNAbZpO/XnsN2unkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOdLgHYv5nXAnbPXFN6Spga7Wp6am7VIpzwBkssizso=;
 b=ntEIrERZHLfPJ0X2MJYqgDLD8Z8JdYplZDzZTjvieaYghrJ2ZE+Fk0tfSu681IEKcxlmJNW1RMxto1LSAnBBH1fAfN4VhSaAzDJfMFnSqOOD0wnov2AKBXQOVjPb8qVUJ2icWvF95lvlC0vP0PvSD8YBck4fys/aU4U5lEicvc3ARbRRc0smG2acqCs5ootNi5f4GmWXmSK21hEuXerKvQi8b/zSkyAD1NzTaH4+/mswXOFQvb1BIblimauMuzDxi1sBAhYrveu8MEOPqZ+E36wNbsL/yb0JUz806JepEYnHAt09h+pimeSJJEhWXLXprz9qocvECZwLgDDuauv6xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOdLgHYv5nXAnbPXFN6Spga7Wp6am7VIpzwBkssizso=;
 b=PykZiGP8qNpUHGxtf1KQ+MVmFtv51IFDb6SSHTDtaWf2izoV51y0RVcIXy7Mp9tHqGPZbaLcQSRydCFe6411fK7iOxEM6woFIVCBErfwdJ67qo7rA97/lCZzDhcM6ccytaNA6eDY58iqZJ8XcGlPv+mXf0uwVHIeMY0TAXCkt4M=
Received: from MN2PR02CA0003.namprd02.prod.outlook.com (2603:10b6:208:fc::16)
 by DS7PR12MB9527.namprd12.prod.outlook.com (2603:10b6:8:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 17:16:23 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:fc:cafe::7f) by MN2PR02CA0003.outlook.office365.com
 (2603:10b6:208:fc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 17:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 17:16:22 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 10:16:21 -0700
From: Babu Moger <babu.moger@amd.com>
To: <tony.luck@intel.com>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <corbet@lwn.net>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<babu.moger@amd.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rdunlap@infradead.org>,
	<pmladek@suse.com>, <kees@kernel.org>, <arnd@arndb.de>, <fvdl@google.com>,
	<seanjc@google.com>, <pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<thomas.lendacky@amd.com>, <sohil.mehta@intel.com>, <jarkko@kernel.org>,
	<chang.seok.bae@intel.com>, <ebiggers@google.com>,
	<elena.reshetova@intel.com>, <ak@linux.intel.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <feng.tang@linux.alibaba.com>
Subject: [PATCH v11 04/10] x86,fs/resctrl: Implement "io_alloc" enable/disable handlers
Date: Thu, 30 Oct 2025 12:15:33 -0500
Message-ID: <6f5398ca2bf6d0387e0b630d120e7555299180b2.1761844489.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1761844489.git.babu.moger@amd.com>
References: <cover.1761844489.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DS7PR12MB9527:EE_
X-MS-Office365-Filtering-Correlation-Id: 029beb63-13fa-43ef-3dd4-08de17d80cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rwiry/j/XJEtJLUwJoxM5vTDpjkvnl7yhMIZIp0xA5FhNoswWn2EW6Y2XMcj?=
 =?us-ascii?Q?nkipnJyrBwFybgCCnPQppozZfknSDVgYWRVHbNbpbOp7TNdObo2zxtZgwRay?=
 =?us-ascii?Q?zzu9rLE/K7GrWhfNY/6ywbn0aL3k3n4L8lYM3m/XqIH/7mlDZm4Hhx1ZljQo?=
 =?us-ascii?Q?OVH+aSH+fPkEPhelsGrtX9WAKkQZ/yPxUGGW1/WqqSheFV/+f/Gp+3HgSBde?=
 =?us-ascii?Q?61qmGTGO0OEQtKjkAOrummrqzYYMkUwDwgoeqDyW9BBHTQvBqLb4MFYYMCgB?=
 =?us-ascii?Q?NpmHVh+/NtqZC8KOLDY6afLCH+vcWl2oBGS10UpzobHD13s+xxw5j5TrnYiM?=
 =?us-ascii?Q?zyEf+Cdu1hTXHJxjP7x+DJiTsn8+ctI6TBAmmpg2x2OiozUfzUJrDpU/EnJo?=
 =?us-ascii?Q?rbYbGtTpkif8YtoENKaJ5AYP0KLQMiDIPRQ977UGRGqk2aiTiDLMw2I9R/je?=
 =?us-ascii?Q?sQq5isTTE8xhcHgTUCry0N77VuhCdiBWX35rEVwlfyEbvnNcOFK3RMK2qMul?=
 =?us-ascii?Q?p4mDvS7Lq/OaaG0NahwBQ8GH3zj87+1swGQmoVfqYQJ8ZJqOxbdD2x0XTiOm?=
 =?us-ascii?Q?J8dA1KoWStyJmZUrvcBoOXIYpzymLFjyynubOYt9/0ivjVgdoWNxgbVKG5wR?=
 =?us-ascii?Q?JpPro9tPw1tSvHyn69j9gsYGFbfHUCx/vddm0BQNmh5ITdy4m+m0fjE0DVKb?=
 =?us-ascii?Q?0udyEy62/dmsyRc3+aQMU8njsImnsvweRhN/KZ+N/SETnvBJoRewyn2Zf5pP?=
 =?us-ascii?Q?rPl1wvrnJKY68qZWELQ1ac29aJuiJ9pdowFUXzJ8mfyKGEzCTWAxAim7TFC3?=
 =?us-ascii?Q?vin4jZlECOGeSx5enWer95R9Ba4xsw8/6GiKEim9UgJdCpmBlNKaL5CAkert?=
 =?us-ascii?Q?ohzMVPvgexPekhHR9eCfFtWapJUY6mRY0VYb1EVSPYpUYtmk/U3ebT9Ia04L?=
 =?us-ascii?Q?FUfFa7ZYtcPHlKSzpFt6CLj+tp/Bc5wQDbcmkSmG0QWKfTWGc8lv3OnqIZOA?=
 =?us-ascii?Q?/Pv6ST5WUCDjXExT2w2frtl1zfN0VvnfUpRzS0uEllrJjhcKUiqHKpZTLI8C?=
 =?us-ascii?Q?7T6OLL32ycjql0ik+6NA4TcliJ8/tohcijRqpFICJzxtxjsfDBIK01wz+5uv?=
 =?us-ascii?Q?kH67QSTs26pcdbMUrlV4hcpr/nFjAOOfbUWfOsXcEO7eZcOCfZ1PDO2DQNMK?=
 =?us-ascii?Q?DdkCpvMfft4uPzY6MOad0KzkWzsiqSDMt1SzoJzxfyes8plhxSm8pomAHrkq?=
 =?us-ascii?Q?sNIikNZ5bdmQgHRGfriG4W3wwEZPohMjWGwivx4DlOtmvG1WRdufE4j2rtRM?=
 =?us-ascii?Q?jA2ku58rWHm5kuO80tNqAMz0z/uZoACEdEaDi3RS677AgfxK9zjSEhzPT9VI?=
 =?us-ascii?Q?aqEKrESrZ1IGcQS0zkd8iDETDsdq25K8LpwvZ4sEa0/bRq6kE43OKysnLtmq?=
 =?us-ascii?Q?rQGWQoiWjfNzwEkse9DGD/134qzmf69Q2S/K+7/u9iUi8wB8AVcwhy689g01?=
 =?us-ascii?Q?ILLYutbI9f7YW5mDUCYnRf6U3IvclTe9ZRUefhuIy+LWiJkHiFR2ScRsErmF?=
 =?us-ascii?Q?iSNl16gn9y3eE6ZgQcs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:16:22.8690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 029beb63-13fa-43ef-3dd4-08de17d80cd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9527

"io_alloc" is the generic name of the new resctrl feature that enables
system software to configure the portion of cache allocated for I/O
traffic. On AMD systems, "io_alloc" resctrl feature is backed by AMD's
L3 Smart Data Cache Injection Allocation Enforcement (SDCIAE).

Introduce the architecture-specific functions that resctrl fs should call
to enable, disable, or check status of the "io_alloc" feature. Change
SDCIAE state by setting (to enable) or clearing (to disable) bit 1 of
MSR_IA32_L3_QOS_EXT_CFG on all logical processors within the cache domain.

The SDCIAE feature details are documented in APM [1] available from [2].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
    Injection Allocation Enforcement (SDCIAE).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
---
v11: Added Reviewed-by: tag.

v10: Changelog update.
     Code comment update to match MSR names.
     Removed the Reviewed-by tag as there are more than one change.

v9: Minor changelog update.
    Added Reviewed-by: tag.

v8: Moved resctrl_arch_io_alloc_enable() and its dependancies to
    arch/x86/kernel/cpu/resctrl/ctrlmondata.c file.

v7: Removed the inline for resctrl_arch_get_io_alloc_enabled().
    Update code comment in resctrl.h.
    Changed the subject to x86,fs/resctrl.

v6: Added lockdep_assert_cpus_held() in _resctrl_sdciae_enable() to protect
    r->ctrl_domains.
    Added more comments in include/linux/resctrl.h.

v5: Resolved conflicts due to recent resctrl FS/ARCH code restructure.
    The files monitor.c/rdtgroup.c have been split between FS and ARCH directories.
    Moved prototypes of resctrl_arch_io_alloc_enable() and
    resctrl_arch_get_io_alloc_enabled() to include/linux/resctrl.h.

v4: Updated the commit log to address the feedback.

v3: Passed the struct rdt_resource to resctrl_arch_get_io_alloc_enabled() instead of resource id.
    Renamed the _resctrl_io_alloc_enable() to _resctrl_sdciae_enable() as it is arch specific.
    Changed the return to void in _resctrl_sdciae_enable() instead of int.
    Added more context in commit log and fixed few typos.

v2: Renamed the functions to simplify the code.
    Renamed sdciae_capable to io_alloc_capable.

    Changed the name of few arch functions similar to ABMC series.
    resctrl_arch_get_io_alloc_enabled()
    resctrl_arch_io_alloc_enable()
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 40 +++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h    |  5 +++
 include/linux/resctrl.h                   | 21 ++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 1189c0df4ad7..b20e705606b8 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -91,3 +91,43 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 
 	return hw_dom->ctrl_val[idx];
 }
+
+bool resctrl_arch_get_io_alloc_enabled(struct rdt_resource *r)
+{
+	return resctrl_to_arch_res(r)->sdciae_enabled;
+}
+
+static void resctrl_sdciae_set_one_amd(void *arg)
+{
+	bool *enable = arg;
+
+	if (*enable)
+		msr_set_bit(MSR_IA32_L3_QOS_EXT_CFG, SDCIAE_ENABLE_BIT);
+	else
+		msr_clear_bit(MSR_IA32_L3_QOS_EXT_CFG, SDCIAE_ENABLE_BIT);
+}
+
+static void _resctrl_sdciae_enable(struct rdt_resource *r, bool enable)
+{
+	struct rdt_ctrl_domain *d;
+
+	/* Walking r->ctrl_domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
+	/* Update MSR_IA32_L3_QOS_EXT_CFG MSR on all the CPUs in all domains */
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list)
+		on_each_cpu_mask(&d->hdr.cpu_mask, resctrl_sdciae_set_one_amd, &enable, 1);
+}
+
+int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable)
+{
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+
+	if (hw_res->r_resctrl.cache.io_alloc_capable &&
+	    hw_res->sdciae_enabled != enable) {
+		_resctrl_sdciae_enable(r, enable);
+		hw_res->sdciae_enabled = enable;
+	}
+
+	return 0;
+}
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 9f4c2f0aaf5c..4a916c84a322 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -46,6 +46,9 @@ struct arch_mbm_state {
 #define ABMC_EXTENDED_EVT_ID		BIT(31)
 #define ABMC_EVT_ID			BIT(0)
 
+/* Setting bit 1 in MSR_IA32_L3_QOS_EXT_CFG enables the SDCIAE feature. */
+#define SDCIAE_ENABLE_BIT		1
+
 /**
  * struct rdt_hw_ctrl_domain - Arch private attributes of a set of CPUs that share
  *			       a resource for a control function
@@ -112,6 +115,7 @@ struct msr_param {
  * @mbm_width:		Monitor width, to detect and correct for overflow.
  * @cdp_enabled:	CDP state of this resource
  * @mbm_cntr_assign_enabled:	ABMC feature is enabled
+ * @sdciae_enabled:	SDCIAE feature (backing "io_alloc") is enabled.
  *
  * Members of this structure are either private to the architecture
  * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
@@ -126,6 +130,7 @@ struct rdt_hw_resource {
 	unsigned int		mbm_width;
 	bool			cdp_enabled;
 	bool			mbm_cntr_assign_enabled;
+	bool			sdciae_enabled;
 };
 
 static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 533f240dbe21..54701668b3df 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -657,6 +657,27 @@ void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
 			     u32 closid, u32 rmid, int cntr_id,
 			     enum resctrl_event_id eventid);
 
+/**
+ * resctrl_arch_io_alloc_enable() - Enable/disable io_alloc feature.
+ * @r:		The resctrl resource.
+ * @enable:	Enable (true) or disable (false) io_alloc on resource @r.
+ *
+ * This can be called from any CPU.
+ *
+ * Return:
+ * 0 on success, <0 on error.
+ */
+int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable);
+
+/**
+ * resctrl_arch_get_io_alloc_enabled() - Get io_alloc feature state.
+ * @r:		The resctrl resource.
+ *
+ * Return:
+ * true if io_alloc is enabled or false if disabled.
+ */
+bool resctrl_arch_get_io_alloc_enabled(struct rdt_resource *r);
+
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
-- 
2.34.1


