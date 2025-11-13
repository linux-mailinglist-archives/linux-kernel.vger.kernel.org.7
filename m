Return-Path: <linux-kernel+bounces-898396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BD5C55331
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF9E34EEFE2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA1223D7D0;
	Thu, 13 Nov 2025 00:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v8YFtX3l"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012039.outbound.protection.outlook.com [40.107.200.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150C23C8CD;
	Thu, 13 Nov 2025 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762995494; cv=fail; b=rsrUVXu/dB0la5V6S/9/2V0VkGrNeQByaO7oe4xiIkPYDHWTOUhUKVAHST14iK3Srcsnstqmh0/9Xz1W68v+M4e8knWLnr5V29qf+X3nwuG+MkaKQ49gosTFMvBWdjeyIXLaP+WjzOhXJQDBEAUrMs2Jsql5lB/D86MUdTahuUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762995494; c=relaxed/simple;
	bh=Ro9rAvY3SrZ8lYLhsX1MgUQkZKe7+lFKQRG7cYfPuYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYRLIRLyHs+qLs2CrAwZAfdjN9rpho+hragt3hU+Y1S/9mLXtrl7oo4n8xcYDw2P5Yre1WbIw8jV3mTIazGBZtQ+EH8GwNIxwdvn8lrNs5WZ5FdVzjswAh6GZMvpZkfva1wJP3WmkNVOutRuSmX4vY8lUN2b9zE/G02tB/Vk5KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v8YFtX3l; arc=fail smtp.client-ip=40.107.200.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEQEdDi6vOt93A+o13HigAePeuyTEC3OOPcOoAnTSKpCn8drW45dJg5AvWrmusfWhhRIuQ/iuefJrkGafxSV1sFNhx5d7vcvkOH3R8/xUQRZ/fO/rZlau9srTMwZYd2Hz+q8vVLv78Jszpojs0fia5YCtTHB0H2LxS4QihUgaov2VOLH6Zfz7uW3CVPAN1bdYMMDcUgSb13K4G+yIau5t2+lVwh+6e0B8bHluNSfbt14RbO+HoiOi1HZJfH6rKPnHcqZy6OnnRSyi2m3xFPt2PJa8q1ChjDnOUDKHxVJkf8vEd/eyngRsXva9A6VNGC59OdIHftJYKqF6uHWe8XbaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1To5LVFWFMuZCjVVFa5drlOH+CnzqMe3+OEC71KB00=;
 b=JqTWBq/WRTVTSOj+p9XBWd6NfZiK5DZt75KL3VGmaZdR96G9DZmC+/EPKj0Jk+oz7xr1PBrgp45ThIPcenqwlRGK9wfztWyLNuZ13xlwn6OPD+4HBTwfoF1RWN1K1cg9Hubp4Y2qb0IxCqKcBknB+zf3DznJIW9fI+6mjEmRqCxxL5MNqVU5mUCSBaUlKubWB7NHphanGCpDA0Wqj5dzXql6CduX7Defw3lZP1J5YtDa21XHndEi6Uu0jCHd9wqO482UNtevhqBpv+qMqG5r02eRHiMO6+lcE0Wj5y7bqmux5DvIjU1K9E9diyLYvIH7HDf4fL5Os/w7sM1LiNbYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1To5LVFWFMuZCjVVFa5drlOH+CnzqMe3+OEC71KB00=;
 b=v8YFtX3l2FCLFHIMDmzwIbHENkKrTFMk118rrCFDmovOgThuNYIllGBlMf8h3119VEzzBUa+4cLRs1E+JT56E8cvgeGyvEgaONJ6XxA3n/KlfLVmausHBIR8dlkSZgCOfKiKeTo6IlgYoQW6Qgm4VgzInUXKjJvUoY2uvg7Hwhg=
Received: from CH2PR15CA0026.namprd15.prod.outlook.com (2603:10b6:610:51::36)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 00:58:07 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::11) by CH2PR15CA0026.outlook.office365.com
 (2603:10b6:610:51::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Thu,
 13 Nov 2025 00:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 00:58:06 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 16:58:05 -0800
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
Subject: [PATCH v12 03/10] x86,fs/resctrl: Detect io_alloc feature
Date: Wed, 12 Nov 2025 18:57:29 -0600
Message-ID: <df85a9a6081674fd3ef6b4170920485512ce2ded.1762995456.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: c89ce5a1-a07d-49c8-24b5-08de224fb52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E1yKmHc/H3eW310Yr+kk09cECRQy1Ot88T6K8aJCEwh8CcmTync0g05FMRwy?=
 =?us-ascii?Q?EPdn6NpVqRqsZcXmQSwDSs6BK9osIXpeWzxBmReeQRp1f5KSyCqxoSpzg2qR?=
 =?us-ascii?Q?Z2+HHaNLoHYTAftsQAO9L/Ob+nq5/ocriWnQZVcIkdcl5OzNbp3DciOVSWwQ?=
 =?us-ascii?Q?jb0Z86tiJW3Q4EKcx+iBNUYDI8glghZa9iaHtkAdmyP0DCKEtbe7j/p8KpUI?=
 =?us-ascii?Q?VfAHOQeYaeb3tPXdoFgBmrs21JI7ohZTrG6U0yUUdDsCfuXuXyl1Wz9f15MI?=
 =?us-ascii?Q?7GHLOXsDMHQfeilQ7zMZtL9Q6XITkwo/4jEURvA6Qoj2oo3xUpZuaWLD+ur9?=
 =?us-ascii?Q?ZR55d3Q5rLv1nMwTgaWKuqne0ixq8ZHgRzCc40AMN3XTZhkS1zNhk1rcZO3K?=
 =?us-ascii?Q?oiYHMHB2FkC1AGvmtsGD/3dPcO+Ycw42PQ02acCEPeVxZ22pq6f9NQ0Svx3A?=
 =?us-ascii?Q?bJ4pbvZVObuJlDEerSJ4gfZN2J+9DSP2Vivp0laRFZ45f3c2bjJ/Jfh6cuNG?=
 =?us-ascii?Q?bw6k+tPWhvmqxlJmUlorkutU2h6lveuCUG72Bg9+TYpwLvpTu2trBbIq0OrA?=
 =?us-ascii?Q?H4b/LsdSnDb2shWtf5JtPmxrVW2/9VWZrUCE9bmgmLkMK8kUlJ1/dnRJ9Wx4?=
 =?us-ascii?Q?DmW8Z26D4QwnAyFqcRJIj3YkN2fnmkjAbKhubKhx7Gg+lTmuWUiEvStLJoA+?=
 =?us-ascii?Q?f8cCXur1ovxwOkhyMxvikYejyyNuT25X5Gr8vIIXH1LJxHFB8ovzmPGBk39g?=
 =?us-ascii?Q?bsm1YcxS9c56gfhKjPBLrHEDNZaMA8qffUrk0l2z/RceTsqXeMg9agi+t1DO?=
 =?us-ascii?Q?D0X7kt4YL9GKQZBCiPLjZVIWEt7UD2QBgAgU/Xik2fhNaHixTC9b9wajP1i/?=
 =?us-ascii?Q?AbeHc6pfJpkYCPDNU3N9BVRGCU72Y8EAsHq0u0zU4E0ke13lH5LDjQmrMgZr?=
 =?us-ascii?Q?cwdjxjd7VnhKkKCr9g13CpoN/zrKA+0l7z85sthTHydk65k/B4qOrDGqdHUZ?=
 =?us-ascii?Q?6BlaYk/COj1X6b8V+HuEt3ud6yDcqWGqtmXjmZBVOBl8yjeVaQO4wm5l+IE0?=
 =?us-ascii?Q?z9rZVl8aSV+SvLk3KbDhslSU6SrS/G4yvXIFlq+R+AZvymNbeI+ZJELwjcYn?=
 =?us-ascii?Q?A8rFclJRk4Pos26AUjcpZbiTP7VII8QURhU7e1KOvqUD5ZkoYOq6taIa25m9?=
 =?us-ascii?Q?dpQsnfNaGtUWjeIsMJFMTbIlaDRrBYUrLlRyrGGLutAHigyEl2iY1Xx3DtsG?=
 =?us-ascii?Q?mcV0ohiwPa90v4cwGAmVKCp3y4t9KqYxo0ykyOdKLKTjLRMNOLxHQRoBxx/F?=
 =?us-ascii?Q?gnVB7F198HuXGh1SMR79iye7Sb7pdvgWmk5vDwyLElukGykNavEExec7QBMj?=
 =?us-ascii?Q?/JwTSAcF2rIZtfcwoo/t8zELwxORUEl9DVEVbp497H4SKWa25menEzPRhbTa?=
 =?us-ascii?Q?QzLmuRdqpOXQrrb+iZC7YHkPlolaTgvPoh0ZGT5nzLy5Nh65bW4uMBwaA92w?=
 =?us-ascii?Q?awGI0K53ODJ7qQTlwKep5voyB68+rBs+y8uvc1YoQRn+5+RRkJ9tpkhh5sIp?=
 =?us-ascii?Q?PD0XPEKj6VRNmkxw+Pk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 00:58:06.9840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c89ce5a1-a07d-49c8-24b5-08de224fb52a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297

AMD's SDCIAE (SDCI Allocation Enforcement) PQE feature enables system software
to control the portions of L3 cache used for direct insertion of data from I/O
devices into the L3 cache.

Introduce a generic resctrl cache resource property "io_alloc_capable" as the
first part of the new "io_alloc" resctrl feature that will support AMD's
SDCIAE. Any architecture can set a cache resource as "io_alloc_capable" if a
portion of the cache can be allocated for I/O traffic.

Set the "io_alloc_capable" property for the L3 cache resource on x86 (AMD)
systems that support SDCIAE.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v12: No changes.

v11: No changes.

v10: Updated the changelog.

v9: No changes.

v8: Added Reviewed-by tag.

v7: Few text updates in changelog and resctrl.h.

v6: No changes.

v5: No changes.

v4: Updated the commit message and code comment based on feedback.

v3: Rewrote commit log. Changed the text to bit generic than the AMD specific.
    Renamed the rdt_get_sdciae_alloc_cfg() to rdt_set_io_alloc_capable().
    Removed leftover comment from v2.

v2: Changed sdciae_capable to io_alloc_capable to make it generic feature.
    Also moved the io_alloc_capable in struct resctrl_cache.
---
 arch/x86/kernel/cpu/resctrl/core.c | 7 +++++++
 include/linux/resctrl.h            | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 2b2935b3df8d..3792ab4819dc 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -274,6 +274,11 @@ static void rdt_get_cdp_config(int level)
 	rdt_resources_all[level].r_resctrl.cdp_capable = true;
 }
 
+static void rdt_set_io_alloc_capable(struct rdt_resource *r)
+{
+	r->cache.io_alloc_capable = true;
+}
+
 static void rdt_get_cdp_l3_config(void)
 {
 	rdt_get_cdp_config(RDT_RESOURCE_L3);
@@ -855,6 +860,8 @@ static __init bool get_rdt_alloc_resources(void)
 		rdt_get_cache_alloc_cfg(1, r);
 		if (rdt_cpu_has(X86_FEATURE_CDP_L3))
 			rdt_get_cdp_l3_config();
+		if (rdt_cpu_has(X86_FEATURE_SDCIAE))
+			rdt_set_io_alloc_capable(r);
 		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CAT_L2)) {
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index a7d92718b653..533f240dbe21 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -206,6 +206,8 @@ struct rdt_mon_domain {
  * @arch_has_sparse_bitmasks:	True if a bitmask like f00f is valid.
  * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache
  *				level has CPU scope.
+ * @io_alloc_capable:	True if portion of the cache can be configured
+ *			for I/O traffic.
  */
 struct resctrl_cache {
 	unsigned int	cbm_len;
@@ -213,6 +215,7 @@ struct resctrl_cache {
 	unsigned int	shareable_bits;
 	bool		arch_has_sparse_bitmasks;
 	bool		arch_has_per_cpu_cfg;
+	bool		io_alloc_capable;
 };
 
 /**
-- 
2.34.1


