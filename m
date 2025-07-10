Return-Path: <linux-kernel+bounces-726221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE56DB009B6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57981BC815B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6947BEAF6;
	Thu, 10 Jul 2025 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pFuayQji"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF512F0031;
	Thu, 10 Jul 2025 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167838; cv=fail; b=QB/+eBk3S8hfHL/AnyVq5vEifRjus74iRKrgj2kvJ3ZwDk6LghuJ+N035+9mtc6WmEONcWM8eYDvrKeNzuvmDo00fyGz8/r1BjoRda3DYUTmYfTS9c46jxVoW3fqDYWryvnJtfmh0PqxeoyLghJHcjKE2+9kS9Zi0rMJuby5OUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167838; c=relaxed/simple;
	bh=CtFPG53SruBnOFqOPjRqaGnkxXgOM2t3WkxIUYnd80M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwgYQXUM9txJu6L4EffEG+aXij5E0ktUXS+flX3MVCs3t0l6yrtyn9neXgrgn93JeNki07aicUMOJm7oWDSvSaBYHxEKdsMMQklAiAUG9IQLJ0vQBFLo+m3aexjtftROSJm5HI/OilPYYWAk6CUiJapTblYC/2M27h/B6anu/Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pFuayQji; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIvNcNIZAOvh2KoGMg4D1k9XNIW5s2JxGX5LALWOTGHFO7uU9Thp45KG24oeoZeK8/Yu/FTsE07Qx7t4yD7i40V9/eIArMpTLHcdTdit6Io9Mo2MLhCWqmdulfxHPoQ6UWft0qVYNox4O4uURGGLjzMOdc9IfKSWAKlx8/GJ2RMp3zRuJhnie9jYV2Bzm5tDIv6Zx+TQt8khg2C0you/Lq0W0yb8URp2Yc7asMd4FlIQiBKIb4BEk8Gg+rEEviCfNYPGbEsQKxhbpjySUPB+rB+g2iPnXPfCrMISz/HFhBJ9Vmt+mLczD9PCDfRBdnUOJ3ejHyAH68EYX+jlstEIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YdhvRVw0woybG2Qywt5dBp2TBJkMg75wyBIffsggIg=;
 b=DX/Rf1OWXH4LCbfsurFi6VW3KKo0HN19j1kyFuz9Lhp+h/ab+y7KZ1gIPBbd29wiz/g0T8CdYCEMdzzZe6kcEN91hISMI2hNPXuiqJJTtz5xY+zASqnQxpssVNNM64m7r0gYLqM/+JRp82FAgPVN4M6Wn/dIY1C/7r7ON8+YUw61eCZmpuyD9A1+wWPAbqNEaMDvEe7jmjmWu3TiL5oJtdqC8nH3bqYWYEfkfDXWE2Hng1xvr8HuqSyfLqkBMDHaJYtaYV3DhbhNMrmN8V6Od7Iom/3OdHkRFJxmwqsuz2PTkoztmx6V5phw6VSRr91zVzFChPYJd7bicnwJKvG7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YdhvRVw0woybG2Qywt5dBp2TBJkMg75wyBIffsggIg=;
 b=pFuayQjiTk/gNM59Hdrru/jnAOV2GyenSwXYcQGv1q0bodeDvll+40zij3py90V2p3Q9FquopZ+qotQMY3dDCMaTO2mi0TwbdbJFR59kYMNPlVmY76T3ykyBbeef38QmzvCF+I8N1pd+TLwPN+o7xfLiyUfO56pKibnJ0skXdF0=
Received: from BY3PR05CA0027.namprd05.prod.outlook.com (2603:10b6:a03:254::32)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.26; Thu, 10 Jul 2025 17:17:11 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::5) by BY3PR05CA0027.outlook.office365.com
 (2603:10b6:a03:254::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.20 via Frontend Transport; Thu,
 10 Jul 2025 17:17:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 17:17:11 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 12:17:05 -0500
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
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 04/10] x86,fs/resctrl: Implement "io_alloc" enable/disable handlers
Date: Thu, 10 Jul 2025 12:16:18 -0500
Message-ID: <b7c61425e9da008add366958a26f7d8e75eef4a4.1752167718.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1752167718.git.babu.moger@amd.com>
References: <cover.1752167718.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d180d7-779d-40ff-39c2-08ddbfd59b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yImplYSrsnVP3iYmFp2z7XgfTiVgdbRKarVMD/prSf0BHNRsoFhatTYpo+8K?=
 =?us-ascii?Q?DsBQpZSegLgZKOLdzlUa4SPFH0iAgwaUHLs9dEmWVfAWGIsuYi4+FncTtUxh?=
 =?us-ascii?Q?VKYqEE0Jb9BHyVzZPDonRWJ1dbBjFddasggfOVuX2LNndl0UpnMQy/3E8WY2?=
 =?us-ascii?Q?qYRt91GsKENazkhu+eGqM6eiQ66x3hDLCd3UGMzp0OMi2dVoWgNC444J+6yE?=
 =?us-ascii?Q?3EYuf12XjfnpITlEezo28H1tgRqJIpnAcMaohXgBu771zYGv79CdkOaaDp9d?=
 =?us-ascii?Q?JWR6SCix1sxbS6iAF9idYjI7t72vKyycqvVfJJgmBquxfNEwXdqXTw8GTWTx?=
 =?us-ascii?Q?yQ9fsUfky5Lbrp5Q6RAX05GRI9sLBTFchD2gHmaRSgkyRXELVWtJ96FqfiGX?=
 =?us-ascii?Q?/i35SgsgZ0I7AMQFYgG/HhbjKgozsIyPoI5TY5xN2BjNN1rlF0gs+O6IOvf0?=
 =?us-ascii?Q?LuE9dlrt4Xv8uiB+5DA62fJhmTLULoyn5CSzOK1Yb1V6kEJd1QCkvXlXzJUw?=
 =?us-ascii?Q?fMNcSbkWxlWno0lgonJdBGGV5IW7nfzhmht+Z00K7+yH1lOUunlEkaCPsN2N?=
 =?us-ascii?Q?yBNGJ3abPE/auZu1Xi1DL8YUdDhyAPE1XX8wshjweocR4YH8RqUzuWafl7NG?=
 =?us-ascii?Q?viPDAS5GL3D9yUq1pYYmQnXa/3kX7ixuaifP3f08HTje4YI0XiHM2SlPNHnA?=
 =?us-ascii?Q?ljtgCwuLKqFXc+jWz+KE6OV/dhUr40G+zV3NKdt9J8YBzMQPqvrX5RvWM/nc?=
 =?us-ascii?Q?b/1RtqX/v3l+L1EXiJTQM8/2H31Nr9/SKXdinWZnzk20QPjDKHOH/MKnHKbI?=
 =?us-ascii?Q?iH/e9gsS670c2xwuTlHnHJqtIkpC7M5Pau52J4oyIs15z17x/QdgFYzLVtDk?=
 =?us-ascii?Q?bceBO5ibT7R18cmZl1slCRDxAzt8uv3JT+n6Q2e+5Q6K1FnRYoGB8UVmyLXE?=
 =?us-ascii?Q?zMFFP2suRcmj2WXdS+050zOawwi65oIPMBMPvEpsLg6AwgDFYMgARXsW+Qe0?=
 =?us-ascii?Q?Sg/BBHWIb4z22MLKJ5N4V7tS3WSrAacgDqe4J58jPrURduqal8fGkMrtMvTK?=
 =?us-ascii?Q?ovnSOeFouiBqyKLO1UQckPcSLkjdRPDFJ4qI8gIl29snlZQL2XeSVbMuvhc0?=
 =?us-ascii?Q?0PFDIiMiTQ2kdmkIhD1UgtMVhn6Hp/66i2PiaPlCfnRygRW+0+ZE27o35lNg?=
 =?us-ascii?Q?tNanxRz8fVLRFvsplaOd/TmZPnfkrk38a7r31yin8cQ3OQC5t9bbKA31UmsG?=
 =?us-ascii?Q?HbMPC84q7LWCLEBElfhbT/4KEsJfdwXQ33YHahl5Nq+EY0j9zQAAZVshCEb9?=
 =?us-ascii?Q?WUlxYuAB7x3+F9ud8ScgzQ5LmhW79zYwns5Ov4bxyH7IoXnEeyBK3Qj7oybQ?=
 =?us-ascii?Q?BypEHQlKbS6QnYG4TIiw5hJxQxcUFHJJ3DlaqZSQBU41RIY1snnj5LJYC6F6?=
 =?us-ascii?Q?5lgucxd0tPBOll/TnWuU71zPmqxJHKlaVKVQLkat8ttrIHUOGx0vftuxrzxd?=
 =?us-ascii?Q?yXb9twvnSTwVG7qH5dUNanCRoSIZccoUFN3WefMwGiZg3IkpjvN9pdnATA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 17:17:11.2006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d180d7-779d-40ff-39c2-08ddbfd59b71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964

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
 arch/x86/include/asm/msr-index.h       |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h |  5 ++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 40 ++++++++++++++++++++++++++
 include/linux/resctrl.h                | 21 ++++++++++++++
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
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 885026468440..c165ac333336 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -229,6 +229,46 @@ bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
 	return rdt_resources_all[l].cdp_enabled;
 }
 
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
+
 void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
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


