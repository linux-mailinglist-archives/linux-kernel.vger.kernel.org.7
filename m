Return-Path: <linux-kernel+bounces-757070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C06AB1BD58
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8CD180057
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DE2242D6E;
	Tue,  5 Aug 2025 23:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OIep9MJC"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754E71F872D;
	Tue,  5 Aug 2025 23:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436698; cv=fail; b=ao3s62P7bVUhlRX3Q+MSfyE8zCB2QiPqApsVqHL9fIWb4sp431pm73rq3ezY1Speeg6ldp0CUxuN7hfNNRbEz43T4YxMZSiDhjo0eFUipzZDCZ1Hj31faXPz60jYKZBx9stAeoKjD37LYFuWSVNzPK51PKwNlvEFghxqlBhIoEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436698; c=relaxed/simple;
	bh=tZv4uzUek2atZtsnOSueOFdeaBl3x5HRDFF3d+kXzJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTajOYL3eb9H8f9PouuWOuUPM5RIDPsFl7n6bGmG9Hfdo6o42V9LrI6NlU3009EBw/8GW73HlWj3fZahleZkWSFwvFwHz1xX4Su9z4jXH6IRoiNm0FYdYGPx7gQ127L3T80TmSWzRIGCijqCC9ZBhA1+BYvJsOraghN/XDShOAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OIep9MJC; arc=fail smtp.client-ip=40.107.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSSvqulGRNAhOyi0RsuwNZLSY6Fr62hxcuwi6pN8c5j+UoXbqaRMKXEPt1+5hiV62iGyAoilpGZZO+rcQ0tx8RYzh94ryIgFh1IF8bwCHUhDQb/YiZ1vyTa3NydIGGUZLxzd9tns+dL67Ke/LB0xmDBlQQ8ir6IzmIxdYbMmZVsMpRrhq4Jey8w9+7n5rpQXzeHeeuEAT/XOUNfMxsTGHkG43aU+wgZLmWsRVM7+fKBt2hc2hTZ4Z5oJ1kUYP9HFzViEri2+68MAVIzOZpCaQ/x7kfuhDUY3zVMQzRcdO3uooLS5srm4qkyckn5Fjlw0Ok0hVO3UmLpHaxx2Qke/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6d+tbuyi+z1HLCo6vM3xwlBGkQNOsyu3//1XQoOzon0=;
 b=ujByYdHo88Os0RIz/b3gTlKWXNTJw5Q1xhIYIPv68FAIVv3LYuCr2z8xWGXZQvJWLM8k8qIQ0kNCjMwf2ESlflfSSyfoyxiP9nZ+K59Pf6GcZF/6Xy+yMcsZSF++zgUSEWeg2KpyK7Fg6n1rCpUsZZWGa51S4G+dnmwd2pKUkPy/1Wauz5XVW2YLaZJbwx5Ici9u5C5cmINQ8YQX2vG9xInyjWg7hPttK5iw0XnErLJH4dKRbl6YB039WLJmp16vLTq/a0ZHYv5m0O28rFixSelSlnzx5OGCA+S5G+ZnOpbTUzrjlN2n7ONHUcvAmTyPAbqB4CnJKjv5cKFerdT3tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6d+tbuyi+z1HLCo6vM3xwlBGkQNOsyu3//1XQoOzon0=;
 b=OIep9MJCiutJwrr7kqPg+Lm8vNbCJHseHBDEGYv6Xj5kPfDKo6v5Gccwrql9zgvrWtWfHESBiKlonzEi6PR4F0x6dAYRZx9WP07F1y73HF6bOqmYAHxDuRAYbv9Y0FghPt9RzTkJI0dxgbD756i2B6BnV+vCOTvY3AHSLo80yuA=
Received: from SN7P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::27)
 by MW4PR12MB7263.namprd12.prod.outlook.com (2603:10b6:303:226::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 5 Aug
 2025 23:31:32 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::f7) by SN7P222CA0018.outlook.office365.com
 (2603:10b6:806:124::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Tue,
 5 Aug 2025 23:31:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 23:31:31 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 18:31:29 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<babu.moger@amd.com>, <yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>,
	<xin@zytor.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <me@mixaill.net>, <mario.limonciello@amd.com>,
	<xin3.li@intel.com>, <ebiggers@google.com>, <ak@linux.intel.com>,
	<chang.seok.bae@intel.com>, <andrew.cooper3@citrix.com>,
	<perry.yuan@amd.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <manali.shukla@amd.com>,
	<gautham.shenoy@amd.com>
Subject: [PATCH v8 04/10] x86,fs/resctrl: Implement "io_alloc" enable/disable handlers
Date: Tue, 5 Aug 2025 18:30:24 -0500
Message-ID: <40ffabb62f9f36aae6a8dc26e5f2e376a3dee23a.1754436586.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1754436586.git.babu.moger@amd.com>
References: <cover.1754436586.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|MW4PR12MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: cdecda39-9c37-45d2-dc28-08ddd4783586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FHXiOuaBy5jSLPIEw1eaQUyTgYPym9x6e9mKkB7fjvdbW/sboFWWB/omsRQ6?=
 =?us-ascii?Q?UoO7d9iClHXHk+DowzYjOl8nVfpdUQqQVb4v8tcq/giTi1VJJODE0ydzsYAc?=
 =?us-ascii?Q?vs8ozAxzrFx5h/eVZOyaO0ebxnUyYIKHG/+A8nPA1Wwut3rrH2ZDINssXIi0?=
 =?us-ascii?Q?9B1WtH4bo6f513qIrxlmPg1t/2M9l9pGtFcoVOYYYdjttjsveeVkU/tvdJ9p?=
 =?us-ascii?Q?h18OMtNfXm0aEWx96wUBqr7CJ9ALHORAeSjddg8dX+oWRA66yuQ0AGWsRwdg?=
 =?us-ascii?Q?92tVlSlrjPSMZaq0jC3vnjAsF96T1gSzDXzQ6WGAnernEyU6+zr0AVcfh5Aq?=
 =?us-ascii?Q?WRRFuvW2ktujbDbRG5ymf5RQnXEWzN4FsTBGoPZB1ci8hK9tLYYVwSpbaGIY?=
 =?us-ascii?Q?qaqfPkcUS++RI2Ee3zu8hhovcD4FsPiD7xRDdtk52pgt6gSJVYaOSgmRXX60?=
 =?us-ascii?Q?9nPDQKGAbmvUGtBg+A0/mr4VqMr9dFLFjZ+ZKu9KUFY5ChbSyZz9xpCJyzFx?=
 =?us-ascii?Q?R9lL4rO9YPV8Br4FZYLy3pnI1hWs/29jYxqARRncqbIkcX/59CDIvXht0gSg?=
 =?us-ascii?Q?f3bDLuux/zvnYxmaS6SQ66M+3EaIPrYfb9EcqIUfIpkXF4R5r3PdQG+EQWc1?=
 =?us-ascii?Q?sXWSFyQtGtSOGWfpay+w+JOnEY1zhQiitPJTtOHx+zYCFetkguuWqSFVpw71?=
 =?us-ascii?Q?Ain9/+E46bmgbVwU3wcJMjkeCgG9y93iVAr8cAbwv5GA4RXUxeeD0B7NEBvy?=
 =?us-ascii?Q?QmC7xumCrxYCbyXd3K+zWKU/mtnSLcUc6tBoEoSylLBr/lEygMpA5++whglq?=
 =?us-ascii?Q?y+nx6qRyxraTNDDBOeR0i+UNzRGEL6mWE6MaqMAYruMtq1W8maQBfs3a4yCF?=
 =?us-ascii?Q?UFM8Mcs83WVGtTq+rv7/3TnOSzrO7FxahIDczsHBWdckInxUv7+LdDjxMucS?=
 =?us-ascii?Q?5gq2Gjz1XWZeCkJkPNNK5XuzvwgOpTbPSpVLULJk3zkvO/nANh+ULoEbmhXZ?=
 =?us-ascii?Q?BYVia7nqPk3JIi7mbUl8eDZ5v26yY51Xb97S73081xxnlLyQd06LdgXdwWem?=
 =?us-ascii?Q?oaJbuq3atrMcWudC0FUxLFt/CWAl/Aom7H4DGmZ3moV/NQ3C3NWLj4mDkJwT?=
 =?us-ascii?Q?ysSe6UgbqLjVNwgeXVUk7sgx1p1DVJgdR9v3AFBwvOvbkW1ws4pcaYQ2aXca?=
 =?us-ascii?Q?0rneM22ldfW8S3vSYLeS3BpfC4MLIuRW1oaE1ugjRGM/dIK6m9xO5h5/AikF?=
 =?us-ascii?Q?Vdb5s47JWxGomFoDpH2RBZuB/4xKjNbR58l4F9r57jImLdU7+jneYzwLGK/w?=
 =?us-ascii?Q?nzycE36uFDjWmG+JxktAO/wQViV4GPO/sjQlpuBlzU4ApINVRituwAeEVfCy?=
 =?us-ascii?Q?/qz/BbQkYaIaHoHwKw/Gdr6hW5jacA+an+OTLPQlacqjFwIcAbkZRN6TLuKE?=
 =?us-ascii?Q?P76VbiKEDUwwBzfYoq7w0ZS+iDqdSRt6fjcsTPsJXeKiRjeI3nYWTbSSY2ci?=
 =?us-ascii?Q?zH2D1Oo4i3rmZo5DvrbsBsh+uPLsFcykRMGv7+VE+boFHhZj4YUvzbrLdw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 23:31:31.5027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdecda39-9c37-45d2-dc28-08ddd4783586
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263

"io_alloc" enables direct insertion of data from I/O devices into the
cache.

On AMD systems, "io_alloc" feature is backed by L3 Smart Data Cache
Injection Allocation Enforcement (SDCIAE). Change SDCIAE state by setting
(to enable) or clearing (to disable) bit 1 of MSR L3_QOS_EXT_CFG on all
logical processors within the cache domain.

Introduce architecture-specific call to enable and disable the feature.

The SDCIAE feature details are available in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
Injection Allocation Enforcement (SDCIAE)

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
 arch/x86/include/asm/msr-index.h          |  1 +
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 40 +++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h    |  5 +++
 include/linux/resctrl.h                   | 21 ++++++++++++
 4 files changed, 67 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 7490bb5c0776..c998cf0e1375 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1222,6 +1222,7 @@
 /* - AMD: */
 #define MSR_IA32_MBA_BW_BASE		0xc0000200
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
+#define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
 
 /* AMD-V MSRs */
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 1189c0df4ad7..85b6bd6bfb81 100644
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
+	/* Update L3_QOS_EXT_CFG MSR on all the CPUs in all domains */
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
index 5e3c41b36437..70f5317f1ce4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -37,6 +37,9 @@ struct arch_mbm_state {
 	u64	prev_msr;
 };
 
+/* Setting bit 1 in L3_QOS_EXT_CFG enables the SDCIAE feature. */
+#define SDCIAE_ENABLE_BIT		1
+
 /**
  * struct rdt_hw_ctrl_domain - Arch private attributes of a set of CPUs that share
  *			       a resource for a control function
@@ -102,6 +105,7 @@ struct msr_param {
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
  * @mbm_width:		Monitor width, to detect and correct for overflow.
  * @cdp_enabled:	CDP state of this resource
+ * @sdciae_enabled:	SDCIAE feature (backing "io_alloc") is enabled.
  *
  * Members of this structure are either private to the architecture
  * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
@@ -115,6 +119,7 @@ struct rdt_hw_resource {
 	unsigned int		mon_scale;
 	unsigned int		mbm_width;
 	bool			cdp_enabled;
+	bool			sdciae_enabled;
 };
 
 static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 010f238843b2..d98933ce77af 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -531,6 +531,27 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *
  */
 void resctrl_arch_reset_all_ctrls(struct rdt_resource *r);
 
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


