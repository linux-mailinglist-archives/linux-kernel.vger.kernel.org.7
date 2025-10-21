Return-Path: <linux-kernel+bounces-863885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CC1BF966D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1638D19C3796
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B986A2E62A8;
	Tue, 21 Oct 2025 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IgwREipW"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010003.outbound.protection.outlook.com [52.101.193.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FF02E2EEF;
	Tue, 21 Oct 2025 23:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090961; cv=fail; b=A+bKG5jGzkbmJcsJMEuzAR5hvIp3dHiy0qMJS75rnEhhbXenR7DrRU5UbqBDJV2Oa+62+xMp7s7Fx8SrV+dyc3uXkkJq7zO1liIHvgJ1m9rZCopnOZInCNkzoBE8LII2m47+3s3eXUwQrAGEyEHdKvyota+BREvhHDBnRCSTeq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090961; c=relaxed/simple;
	bh=5jkWctVvHH8Eu2xQi+4pkZ09VgGK3lpluS+UHYZYnnE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWMJdKEyhIC6/cTDY3LaUKhzXe1jvxT/s5TjgSHxeSxTzRU9ztoV8Y9qGTETVmbyP9B6Tf3Oq+avydiidDuJk7kTFH4tkD+yaJeJ6Q5EvL1M003SUU+uwGf9/7ywJco6d8fIyhUtce5vawCqRYShrn5gmV5/J/rHeipcFNm/Qn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IgwREipW; arc=fail smtp.client-ip=52.101.193.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1Ilb84qKU4ux1ZgymlnsYfpAtb5IqwGqjgnrnHLQ7KAYVwzB24SKJL8U7WR+yB4Ozi4UbFQEr6ke0BJVk1tbjNwUNy1j3gVuU5cU6tHhQkjF/iLf03IVe+OPD9sCm3ql1seuU9n4IAIK11qPcrNmMdp31j43EBUFF4cpY8YjM6Lw2N+FtITo2ZR3PISzlmPLcjJisoMlCvL1BL0NE8GAYDYFr3EqaTQHTimUu605/mC1LhmXFQ4ApxCKfoXyS0G7dD9nexVj0HisFxyVYCvieu78C5GIfO5+uPWNrwTGYDYTLOyzQPLKxw9OuWFePBvgjdu/A2Mo9VPrsQL+SU/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCj9FlSztbYCinaSzo+KG9cnj+y6znEDtpoDINefFC4=;
 b=b7PoPgrVC4O+RLyc3rHyfyyUCrmclOHPCan4A0s2ZwwMMOQFVlwiLST2ZgSi70foTMwsEik1ieUQL/UgysUyxtWsp9egla3POvupFwC+d+TkJA+9UFlQGXtR980YgHbhUSZuoAVA7dX86uNKYookp03SAZ/E7mrsef+jOkGKGLVQReU61dyQzGafIiD92TxpXWzDRnHoE32C5EmbHJaQJEmz7FOYXEciKb2JNthjyBjuqPj9kTtRJd/kuBYPRGfYzkN38RZDbg91HidQHrgB6JnImJWS6zG0q+SfVokHp1UA1pgPaBVhPNMO2svd4KHs5LAjtyF55v+bDLIzUuBN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCj9FlSztbYCinaSzo+KG9cnj+y6znEDtpoDINefFC4=;
 b=IgwREipWJXHkNB/2qdFt5aS65b9b+zq3xtlgeJ91fARe20W6lU76lpgWG3IAGamuyLp1kIjzuidddlvn15o15UyUGij6A9+/8JsqqQnAgKN2H7TjWifwR/rzjDVJpB046n5Qi2mM5PAJuaAj3upKsV30TZCn1XbmwtEsJKZORR0=
Received: from BL1PR13CA0325.namprd13.prod.outlook.com (2603:10b6:208:2c1::30)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Tue, 21 Oct
 2025 23:55:53 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:2c1:cafe::91) by BL1PR13CA0325.outlook.office365.com
 (2603:10b6:208:2c1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Tue,
 21 Oct 2025 23:55:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Tue, 21 Oct 2025 23:55:53 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Oct
 2025 16:55:51 -0700
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
	<peternewman@google.com>
Subject: [PATCH v10 04/10] x86,fs/resctrl: Implement "io_alloc" enable/disable handlers
Date: Tue, 21 Oct 2025 18:54:47 -0500
Message-ID: <8356c090156a90b080dfa2332a70f8aa71f34621.1761090860.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1761090859.git.babu.moger@amd.com>
References: <cover.1761090859.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: dca9619c-9801-4eab-6392-08de10fd5ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1GXgoEWmSpIqoq4/zqH78ToFIOM7+am2LNvkZqt8wSWEiMrht6QjLIL9B4Yb?=
 =?us-ascii?Q?D+2HdXmhkACXEToiNTfT3Hekh+qSCdVgBc7o3uLbN/td8VmNxT141DNxfwqN?=
 =?us-ascii?Q?s35RAcu5ySSimN9xSdu1iM3SGNFUv/4+lTrUOauPO4eLkkNC5AYYe9FgM5iL?=
 =?us-ascii?Q?6Z2NhMioDmD49WYwFRZn97jZkRfy7Xc4evH393ZWPMlYqhkBg10ZERJqn1TG?=
 =?us-ascii?Q?SmzU2E4PXnPXQzO10XEhmL3VQm7RmsYhp06aic2uconXBTCpKYF4mjW8x1QM?=
 =?us-ascii?Q?1f6JthtsgSDFW9xAvO6SgUZTs7dJUpFzHhijGHnYScoCcA8Xjf0S9ImQm8hA?=
 =?us-ascii?Q?I5HF2LnqJ+FK3i2jx4GS7lYUN9FJ8CLfzqGv1sufdEfVmstyiRAAx0HyqwCt?=
 =?us-ascii?Q?BtVac+VwOHwM/aP/oOKu6BKPPxflJ7q5rN6uq3IbWKK5zIz/cO2PeR4GyCzU?=
 =?us-ascii?Q?gK05A7ERPQojPQkSY0GEmszs+p1xashPX68+vrsPRldOok9s7Q9wGupoZE5C?=
 =?us-ascii?Q?jCW5PMO94uTRENMgh2MJt6rvxoxwFLx8ao90aatdwyLju18i8NAVBb0KcjLA?=
 =?us-ascii?Q?PodHTDsIy63JdbC7WQxlInF3anl3jVUAesZRtfD+Dtd12KNhaL0UPUJuzfb6?=
 =?us-ascii?Q?WfPWP2Zevms92w/BaNKOsLRH4Xb99BCldqeno/ktwFtatrw64hW76w8jEpck?=
 =?us-ascii?Q?2ms4qinD9rG2+mgdCzVECDeC3vHSv2ZSuAxhzJAOxY4AhbmRtWlALurER1bZ?=
 =?us-ascii?Q?79fsgaAIHGi8xEJn0IgAgkztqxjuu4YcfS4l7iYKQAxdM3VoQlP6PLAG0Gdu?=
 =?us-ascii?Q?ef2g5pqdgDfnc8CAyCrxiRTs6YJ3j8lrsy0qFIDm3nRSho+hxhHrViLbeX+R?=
 =?us-ascii?Q?REzfk8I2qTAi7VZFlloTKINUrWFY4BqIL3mNxTZaOErEueJsS4KeUuLwY3oL?=
 =?us-ascii?Q?kPfAK6fX+T5aodkms6BqokAA8S6NzE9TJT1obBb2nQVBDxfSpht/Im55o0iP?=
 =?us-ascii?Q?7+mj/nqsJuK2FJg3aCuZtXsxHZqRdrZX8B+a+y32cboBBHfHwerv4VjL5k3v?=
 =?us-ascii?Q?/Unmj95V8XP5s2/gjeKdg7FDYybSa8zous4ZfIsmG0gqwNTaQZ9W5JOwjwQ4?=
 =?us-ascii?Q?oCRP9olBK5sVukqEyFXkNd9flFmwAGS5xEbz7MDmguyZPHmkX81QirekIH14?=
 =?us-ascii?Q?kECvrrfDT8WRGP5zi3/LH7WdYAa2XLlSNIw/pnUTIEdVVsfpk/XT8bw1Qs2j?=
 =?us-ascii?Q?zIuvunfJBlUwaoXTborUUgsksXx7yYKMxHW45r8baQBDXnMkR7IJn5xaPzss?=
 =?us-ascii?Q?XikYRUfEl166Y9e33YZqz0PqUA/IjoPsLiP/aB0HpZQp23USIroEBs8OaTGy?=
 =?us-ascii?Q?I7uf6iZISw8vCHKRt/q8CafWqTNA7JrTnz/GAnLFWkBqlBF91G5DqwBph8FT?=
 =?us-ascii?Q?UqRVWoXSlwAzXLXC8Ng7fPctiS3GKODmWTrkAYweGqLtm5HuyR4qsggpl391?=
 =?us-ascii?Q?ArEbqz4QMemTZlyz8i0Pz+HJ+FRkY4YzRAwhN53OUAQ7vw4FCmxdCwZ7Knph?=
 =?us-ascii?Q?m+lrs6NJ5BcT8x0K2aw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 23:55:53.3699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dca9619c-9801-4eab-6392-08de10fd5ea9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239

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
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
---
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


