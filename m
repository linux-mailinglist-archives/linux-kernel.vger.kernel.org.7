Return-Path: <linux-kernel+bounces-898397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8FDC55333
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71C964E7806
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB1A1DF738;
	Thu, 13 Nov 2025 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ax6ejbga"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE362158545;
	Thu, 13 Nov 2025 00:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762995509; cv=fail; b=ZNNxHcB3oi0k0x8I24tpnFTJpWuwgrctSGuMFftwOYHr4HeEqTshW0W+lGPLSqNDQoHEDeddNmLAGvZtu/lOpEoSTBBg2DIWJ/eEY9QkaNy9bJw6V5hQn8mwKxjtKcHfVSSRURTjGzQu9Qabelh7w9jlw7LJ0uZextSVacadPVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762995509; c=relaxed/simple;
	bh=ltlq6VnBDI8nLeG70DeSARD+bsYPqkHYnYe+e8YiaDs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhtWvo4XO4Gw/MnsKAWiRTYLTuL35gKMGM2JoaM+pP/lTSZZ3r7ReQp0U6ScqVS3ey0dgTvhONM9b0JoYWLnBmnREc0+dE5e1H4H9DTNKwTlK7OY5rkZbXKUyWCqswUqrZHNoLY9G5IZnq+pbpBjQx0xc0TBATMQ7fujGnZpNPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ax6ejbga; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqqTPPTe5GUPpLxYZj3toxjej6lrva4On/uqutwxQrFIGndVHviXEi2hQYHA/R7AtXlGL4T5qnh379iz215zA5ygtLp9Imv07IEr9HojGdIgBmkKhLZnqOcN3U8HcJOrltOqTvU7WuGUUuPy6zb2UXm05CXwAfkaq+HbjPGS8OgnWEdzFp3D8JaLpPX5qBMwGRIY8flF5tD3w2BiGYGIHHHnafwmiBV4icEykeiSOPbjlyFRFNE7z5tgJiwsrlX5RBIHt45+atrrBZ66NvXjc+dR0tRShL0s58ZD29EGdsh0BowxK/zj2wrjgxLNeigZHwXZE97CR3jiwtjmzRahdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjB0IIaLuiyiXf/VBg13EympEuPXi6KaVPXVBlLwWjI=;
 b=jE3juIEtB52w4DI5fFXa0WM9Id/FGrYjzGxgeC+B6TK+ZQ6jLNIWsXCPTeSgK+dEfVfTL4+G/pLHGmn3em67ZXjnUpOK9BLk8GqgnIM+uzvjVKi16RY18nHKindlnlAtI5zExTBKqYf04nV7VFDJOvwA2BMs8t6KBxvhGEOUt/t+GIaSqJ400m+UdjWEObOkpyzVkMoCiW4hvig39ki42JEXFyRAD6ZrIif+nRAidaXg2uR7ni7LmbRxfV6a9u0AEIqm59Pj2UMXTvBTRyxUPgDR91HGKJM1Fwg2GxyG8t61cETFs3fbk/iAigtGDFau7ZH/aFCwx5KP6apb+CuanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjB0IIaLuiyiXf/VBg13EympEuPXi6KaVPXVBlLwWjI=;
 b=Ax6ejbga6jm8x1yjyVSY66MHTrnKK+0jNU5V26Sxd/QF1WSi0iv3a9fUIG+/kTxpjHDe6vRvVZcHfe2WzP6dxql/84wSKOnMYJ93f5g+MOMcOOoCZ5BidDEySIXlKVLOYj3StiBmt9n1gQxtbBxNUMeSW8CcDZjQeNVknCmDtZg=
Received: from CH0PR03CA0441.namprd03.prod.outlook.com (2603:10b6:610:10e::34)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 00:58:21 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::53) by CH0PR03CA0441.outlook.office365.com
 (2603:10b6:610:10e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Thu,
 13 Nov 2025 00:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 00:58:21 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 16:58:18 -0800
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
Subject: [PATCH v12 04/10] x86,fs/resctrl: Implement "io_alloc" enable/disable handlers
Date: Wed, 12 Nov 2025 18:57:30 -0600
Message-ID: <9e9070100c320eab5368e088a3642443dee95ed7.1762995456.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1762995456.git.babu.moger@amd.com>
References: <cover.1762995456.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|IA1PR12MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 96837e28-bea5-447a-c367-08de224fbd86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YGjNgB3uW4YL/2VW3SbpIZ7GmqPf7afY1vkVrhptTWbyFAMbtsPrfHE75fBI?=
 =?us-ascii?Q?MsY3cbQHLy70ShYEMSgTBhnoJHbDULX8+Qs1eAy6qk5ZKOCOr3EWgDoxc0z5?=
 =?us-ascii?Q?phfxCd/SW2ye1MRbYv+pGPTGcvrkI+9zFBZE3LD3+MPxAI0IxuKrcKR9UQkZ?=
 =?us-ascii?Q?tGHFGU40BWOpoiFhihYY2M2xKjtG4cbNyROnZUghl1cpTHqSBS3DZ0SpHTZ6?=
 =?us-ascii?Q?RTQgjdCif09dPt69NpT/41HPgdq7Qvp64IQnymTnlbHO6ofToglW7e98gzcu?=
 =?us-ascii?Q?9Sy7fFeQiK9GhZwnz4DFVZtrV1qmdpPoAUdA+qtQ7GJ4M1Pxqy/jkacGC+nW?=
 =?us-ascii?Q?OI7claWyH/lTcFFLZtV8pbcvllDF12FlOwjI8dUT/Mba5S7BkU9VKC0KqW7s?=
 =?us-ascii?Q?Oz/4zxgOdSqeH+YKCp2yYKyJzPsoQYpgKHwOQmM4uazJNJjo5vodePrRed2n?=
 =?us-ascii?Q?XHFr4K9d1gTUfgxiCXg6oKj8iTWX7uUU31vHB8n6dkjw+jsd4ziR4Labl5mg?=
 =?us-ascii?Q?n7HSp2EZyZnAcLOXPit+VmaRKanY/EyeSlK52QrTr0fJSyiaTe/yVFaDhbjY?=
 =?us-ascii?Q?t7GUQPmExxEhcjIclsQHkJHn7TZj0VvaIa4b39XPobxXbVIbzJkeXybP3xhE?=
 =?us-ascii?Q?kfF+hCRBtDoNbNfXiPmV0rRXliSxFoHrJTcQ1TIW/28Nsjbami1GreXrjXDv?=
 =?us-ascii?Q?Zuk0FasOkZnATausdV5pTvcmX5vstSbXU5A79fD2IqCccULAvDl44pKvf/Dj?=
 =?us-ascii?Q?UOtfBxZDhHCE2zGeP5ih7senymUiKxzU2fu8FtKy7uVaM2cG8S9WbtHVTGSb?=
 =?us-ascii?Q?cC2kYd+XBzVVgO4heAgrEIIqbAgfC7/dTvhueIQmpkR/6bhX07ht4mZ/kOCu?=
 =?us-ascii?Q?Ms7GMLbP0ynh4RBr9q1YUeJvdb3QiTJ4RnF2lasOg5fyUeORsHtcInw8zA6N?=
 =?us-ascii?Q?1gzGazDQPldl7VOsBfUiQXuAU0ajJLF7EHbY0sMa9mVbYCK9qJXzpTWN3CJF?=
 =?us-ascii?Q?XWK55JUfBqiFFzp4awYyb10hlM9R0Aa76B5XWUZ3FYx/jDJJRuJmlDd7sbJQ?=
 =?us-ascii?Q?dCQfr7D8YpK6n39Yc2iFDEDHvBSN05girjdmdYlAe/kvBLH7St0G5dpimul+?=
 =?us-ascii?Q?A63vIflEpaoL+3hVjMDR6se6BE/oSROvUij1fs8MII5L/0ki581A0NoJJZSi?=
 =?us-ascii?Q?YTuNI9KGQifzNyjr5gzpHSsANDPleL4IKfvAo5wdfYey6oaF78K1Ot+zFLDh?=
 =?us-ascii?Q?heOTYplEDQapH09PlOibYc2U9IXyt3u1kfQEO0DKWDuP9NazXJZgPao0/9ZW?=
 =?us-ascii?Q?Kl/BYGNu55B5T+hxQpJEMo4ReJ9YCa6acAWvivnpzuAVIqR3D2CtPqo1SUS+?=
 =?us-ascii?Q?0TpQ6VSwb6MA/aRw+3cM5eEq5PewloFRjz3M4JrmLIg5T+MO4P9nbiQ1ynmj?=
 =?us-ascii?Q?+O2c/VNDf7sNNvNUW3yVfXMn80z30GhnogYTKwdRPZrXqA3fsnU9I0hStV0Q?=
 =?us-ascii?Q?YIamsevXCoWbU5Z2sb2Cs5x4DO3BJOnQlkz9piSXSXV+TN9cDUbgQkB2Qq8+?=
 =?us-ascii?Q?M17BvRG5mdocfcPtjdc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 00:58:21.0125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96837e28-bea5-447a-c367-08de224fbd86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281

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
v12: No changes.

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


