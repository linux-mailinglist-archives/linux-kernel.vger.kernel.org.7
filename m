Return-Path: <linux-kernel+bounces-722474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2F4AFDB0F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69C91887EBE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030EF26B97E;
	Tue,  8 Jul 2025 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f8ZN5LAw"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B38264612;
	Tue,  8 Jul 2025 22:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013383; cv=fail; b=dTWLJpdqAe4vh8Z3+uc7/nf/iIWcm9ncdNfhDwIJWWbIgN2+z+MRiGBXPAN9DT2WhZ8qAKmi2TKqOGkd961SofMeV2VDkiJXaQZRdPIzi9wX1TXoS0Id87dUAbD6BPdoqK2427X2ifFqcpihKjVXv163cysrS1DoycPu0hbT/qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013383; c=relaxed/simple;
	bh=33QW8ohVYowx0i+iDE1xIklk4UhV4sZbeJzY3B1RX3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sw0cQQ6r2z5isR1NfLHrPzCshcNdTxP+RsE35o+32szX+xc8FhlNReZxfWSPq+XZbTkioQwcYiqhrx4amT/xv2v/MIJC4GiAfjUAK7QGMUjguj1pHvnSeuszbm7cXJHd6YrGToQEWlgRQGD16Km8R5NwcUIvCp7wut9Je410fsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f8ZN5LAw; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6K1M1a/tqoLmnsyuKD2T5XzZ84qRv4yhjiG+0/8AesbAKhh1PUwv46ypKGA/ImdjN458EmH4+9s3Rv2X9CLJfU4FV5bDP6T2W/RNlqLQeezyO5evYZTaMOdpnD4ltZOSHQFncrRDImMQqNl8I1F/yyVVj5sRS4bw9/BaOoXjWcfk+Q6VjIM9klepKSIYeAZW6FIOuN26g3OeezGflfk+CxNu76oLdDStxi1sqsckHTPJZbN1wwfR/5Yl8rHH70VMyaM1inrDZmeloXNW22th8D0Gis5PsnfcjkR9PrmXlvVx7voASnVvF1rVuGAQiyNmCRy9v9bHFhGSZnMOKbW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKyYYaLBFLzfIHTa9HwgTuHL8gAVC8DfWVJj3J7uLrs=;
 b=YcTSfpCRoJ4STfJJutVkZu8/LLTwyU4ePZus5pyEhoLPLzJJZ4uFaAcFP+DWVDbOGv7bWopjNmb9w7Fu769tNbW2iOOBKy7QZ66IswgvY28wg750AcuNiy0RbBFsIkqcjjY2VFKMdUmyCp7/CVf3vmSgFk6j75J8lyV1Wksc2m2vJvSk7C7PRHEfhIGxYj5YrmxD0ttLCudZ9nUy7TFpYifG/7k5FEOLxO+DpuV2jE+lJzR6UIRNpsuKWXuGPsUxIiKgBkyiIn+8RdfrkN6esxYHiHxYv8nQ/xJGXqkxzPDfvg4EBxGltiiVVOXgeC2nVTndk53Z6ky/B1yuWOm8wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKyYYaLBFLzfIHTa9HwgTuHL8gAVC8DfWVJj3J7uLrs=;
 b=f8ZN5LAw4Xl5P1SJSUy7LRYXL4OjDA7Dcc6lMp7PU+UUzRL32RMrpN3YG07ZYJm2qvjgNds2unk8krplp/UegIZXUS8JgLzpb2RDatudS7TZc4+JIhm/3cBujI0ggN1dS1FccW0Wi7q1/hMOouOvGjAXvyAK2SMm/LUM+gY6zTs=
Received: from BL1P223CA0035.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::19)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 22:22:58 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:5b6:cafe::4b) by BL1P223CA0035.outlook.office365.com
 (2603:10b6:208:5b6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 22:22:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:22:57 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:22:54 -0500
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
Subject: [PATCH v15 34/34] x86/resctrl: Configure mbm_event mode if supported
Date: Tue, 8 Jul 2025 17:17:43 -0500
Message-ID: <cabda4b05f54a2d699b99bc9681d55b0486da5bb.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: 393c0422-51bd-4976-3fbe-08ddbe6dfdfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JTAn7i76pdQt8wMIIMSn/aabZ/ayXhQgOlv5mbGP8tsEuQPCwiKpzagdH/4C?=
 =?us-ascii?Q?mF+q37UFlz5dlzxfRpZ/Hvo7GBow5t4HbBmDPcAt+T5tZlh+ITbTUKXFfwbg?=
 =?us-ascii?Q?ZE02AqTUXE1JrBr2HHUOn8DVc6olW56xrL29An2taAXzYcNm6Twa37/PXiXx?=
 =?us-ascii?Q?xo+9ituR1eE2+s91uCPCDC+whcUzDVJR1/gxPWx42b1K0DBq/PatZJNskujb?=
 =?us-ascii?Q?oVFvDtVRHePBkfmbXmbigpuSx2zwXKsUnJHevywlMJFDH9TvpWXKCzkuwLi5?=
 =?us-ascii?Q?kMG8rv6aFVtotZWwQWg0E2Ez4iDcJq1zKBhwjwI7MOII8k5tBYZvbYN9P3B3?=
 =?us-ascii?Q?qtuWqCWCuTB5goXI/bE/PHFq6eYyzWJidrVFKGSukUMJTUgSwkbZbrr/B1Dm?=
 =?us-ascii?Q?9YqfPFCLkyv4cn8mjCqpUFrutWtmlVUL744R9VZf/EHWOSAEaR2a1hpc1YIr?=
 =?us-ascii?Q?P6lk7Y8W5Q9spi6OquSyK4HNzQvxyDyD37q+g1+3P2kOcGi+PgkBcJK9LcGZ?=
 =?us-ascii?Q?S4oNtfUOCJbDict9W4TMinn5jJ5kHyv4FxsBJ/rkItCk4iY8JQZlZ1/32FGl?=
 =?us-ascii?Q?ypWP/IWtPDK5hzNuoW/kSMzDqObOe2USfalBCvJ3SUQ/yhG1g3qCtXxBDTy+?=
 =?us-ascii?Q?ROAlCULYsO+0zkc/VxdKpnzmHXZWmP99fcmgWqhhzY6PyeHm4bK4Sznt8hmr?=
 =?us-ascii?Q?Ptsw0tVQ6YniOy9ZlrPtpkJqkg0628HLqBdxb2vvjuviAo8KOtGcBhyQfO8S?=
 =?us-ascii?Q?DbMZf/WWkgBPj+oOYghkwboHmQXHR4mlFuJQZImkwSWmAn9rZYPPdgLxqldY?=
 =?us-ascii?Q?b5EEOZrhT8D1Ciit19p18IX2PnPMqMfmH76/imzz8m100k+C20fQNxE6Kodt?=
 =?us-ascii?Q?RUFd3ayvw07C0OuBxXCMf40G08wo3syrmcF3CWRtZuN+FERJw47Vyzonsbbe?=
 =?us-ascii?Q?i3FpkYGi8z8UCLonHudCqlYm6azHDmNfnSwmsPhV0hkVwflqH95r+eBODOVs?=
 =?us-ascii?Q?+V52o4NiNiiwJ60rDI6tCPCUn0WVg2pj0FKj17kNVodH/947TwWOn2YzFDLr?=
 =?us-ascii?Q?8Xnvg5m+Wm4MAR8GetVCAEA9uJ7IGe2GWs/r7PbxeUzyKdTtJ3n3PnpFfchu?=
 =?us-ascii?Q?Febx6SHYWBgAbPg/ZcmuwiVDnMqEpA29PefiF7jEAFtm2H9MSj4KnIUq/+ti?=
 =?us-ascii?Q?KpEcfAejdtEyVmYE104ZlAP/5PTJBk+c2whXSwo/CLEzGJpJOlmVrbMZb4hR?=
 =?us-ascii?Q?pTKD/Ki27Zptmcj+KSjwtfoZEViy0C9nbrGMp8PEVHeOsCHdUZ7BtQH2YXjy?=
 =?us-ascii?Q?rExuL0MYtMMvzxxEL+wTeyoNJdKhOJvNBareu43R3TS0D9rW0734hnOxfSmN?=
 =?us-ascii?Q?QjB+gMHJQ06glRKlazQxUnFaCnkYpGXI2BPrJsuYxW0bILNB8rxz6Uy7o9bE?=
 =?us-ascii?Q?yrZmpj0gI6SImkaD4DygyLU/dQed5EurrLPsRdVl8EuCzgAWjhES7zZSIphb?=
 =?us-ascii?Q?kW3QwFjZSVUrkZZ+QotrnECO7vrG0NkuamkU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:22:57.8062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 393c0422-51bd-4976-3fbe-08ddbe6dfdfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364

Configure mbm_event mode on AMD platforms. On AMD platforms, it is
recommended to use the mbm_event mode, if supported, to prevent the
hardware from resetting counters between reads. This can result in
misleading values or display "Unavailable" if no counter is assigned
to the event.

The mbm_event mode, referred to as ABMC (Assignable Bandwidth Monitoring
Counters) on AMD, is enabled by default when supported by the system.

Update ABMC across all logical processors within the resctrl domain to
ensure proper functionality.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v15: Minor comment update.

v14: Updated the changelog to reflect the change in name of the monitor mode
     to mbm_event.

v13 : Added the call resctrl_init_evt_configuration() to setup the event
      configuration during init.
      Resolved conflicts caused by the recent FS/ARCH code restructure.

v12: Moved the resctrl_arch_mbm_cntr_assign_set_one to domain_add_cpu_mon().
     Updated the commit log.

v11: Commit text in imperative tone. Added few more details.
     Moved resctrl_arch_mbm_cntr_assign_set_one() to monitor.c.

v10: Commit text in imperative tone.

v9: Minor code change due to merge. Actual code did not change.

v8: Renamed resctrl_arch_mbm_cntr_assign_configure to
        resctrl_arch_mbm_cntr_assign_set_one.
    Adde r->mon_capable check.
    Commit message update.

v7: Introduced resctrl_arch_mbm_cntr_assign_configure() to configure.
    Moved the default settings to rdt_get_mon_l3_config(). It should be
    done before the hotplug handler is called. It cannot be done at
    rdtgroup_init().

v6: Keeping the default enablement in arch init code for now.
     This may need some discussion.
     Renamed resctrl_arch_configure_abmc to resctrl_arch_mbm_cntr_assign_configure.

v5: New patch to enable ABMC by default.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 7 +++++++
 arch/x86/kernel/cpu/resctrl/internal.h | 1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b48cc67cbbe3..9826587c3c99 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -520,6 +520,9 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 		d = container_of(hdr, struct rdt_mon_domain, hdr);
 
 		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
+		/* Update the mbm_assign_mode state for the CPU if supported */
+		if (r->mon.mbm_cntr_assignable)
+			resctrl_arch_mbm_cntr_assign_set_one(r);
 		return;
 	}
 
@@ -539,6 +542,10 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	d->ci_id = ci->id;
 	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
 
+	/* Update the mbm_assign_mode state for the CPU if supported */
+	if (r->mon.mbm_cntr_assignable)
+		resctrl_arch_mbm_cntr_assign_set_one(r);
+
 	arch_mon_domain_online(r, d);
 
 	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index ae4003d44df4..ee81c2d3f058 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -215,5 +215,6 @@ bool rdt_cpu_has(int flag);
 void __init intel_rdt_mbm_apply_quirk(void);
 
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
+void resctrl_arch_mbm_cntr_assign_set_one(struct rdt_resource *r);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index e0706083fe0e..6a6c058ab00a 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -458,6 +458,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
 		r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
 		r->mon.mbm_assign_on_mkdir = true;
+		hw_res->mbm_cntr_assign_enabled = true;
 	}
 
 	r->mon_capable = true;
@@ -561,3 +562,10 @@ void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
 			memset(am, 0, sizeof(*am));
 	}
 }
+
+void resctrl_arch_mbm_cntr_assign_set_one(struct rdt_resource *r)
+{
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+
+	resctrl_abmc_set_one_amd(&hw_res->mbm_cntr_assign_enabled);
+}
-- 
2.34.1


