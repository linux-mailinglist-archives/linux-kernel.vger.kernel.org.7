Return-Path: <linux-kernel+bounces-726223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E01B009BA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4EF1BC8316
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75E42EF9C0;
	Thu, 10 Jul 2025 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u6rLxkBx"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD3C283FE8;
	Thu, 10 Jul 2025 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167854; cv=fail; b=MgevljN0/v1hSunm68dRFKP6KMkcD6Dl5kR5vzkxHWJHAjOouRJAu8LEfSbV5sZ26unNtUn9cBpY18gpefYBLRhhbEzBhs/vmuBgyx0AH7f/S/WjhCKw8aAM9uNObUzJbbtva1cpcoUy8Cs0cGtAGF7f9AEBPz2EE8iCf7yI+A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167854; c=relaxed/simple;
	bh=V8+4wGdzlpg6dxsnR69OAOqG3AcD/mTTn/CQ3PR3ueA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NL8fEXmQKSNvdKj9ts34LH6FWDUMe4GWo92ZYUZgrAwG14HcpHtco4tMMYeX9kM/rphcM5PFlvk+1qjXQdUzPwBLx5dOufYNpfs2dcx5PrkwqTWcRCAd1Vls6CdJF4MoG0jA6At7SyBU40RWhbFVGEHricZiaFxKQsXa5Dfn0mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u6rLxkBx; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRki59XuqTlFKPN8e35f2r6YZk6Ri8t1K74b5hqZUleiQFyMfGqgc72fs2vg+GorLsGRT8nOrRqd9jsOPbr1PPggjwyvJ6EcPCQNdZdEnmaLDru7x4puuYqD67YcjwwM/72ZQC6rF24uqv1Q8WUac0qsgdhI5yUiwjZsCY3NYKtJbahpyaHmMmv9QrVk6+uN5P0AS2xaP7Mmp3V9Tr700qotfQFsQpfmP3sXFKTXBz5yjVTeoInViwE3hO2CqLfNnkjhUS9o8VIqMCP33XqBoKkLh4y8A5mbniQf3trV4UCakUDX/IGUO8+FvU3CYxILjvkOxNbK/2dF1PhEjceWUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBxWTFuCGMLtlLH17fPKlxPmwu0YsnWGlBQB9upxxWc=;
 b=SvhRMCjEsD/hhr6Ztl12Ard3FSXktvrI/PAwsFqJvsJzkob6S9mMERjyd52/R3tChjvcQ7zlcX5qBOhWl0Bl5rvEFEWdvvTbr0XMuNU5odOek6FoO2m8xRdxrD0JjjfdtqdLmIjvqP7ITQKLavrKvK3LTP7gCnLBaZnAfRaXZ7cZpu6nvpzokYvsE25HoyYmVPWI1xc9p7ePnLe3w4ati1baWNeXHJBE42sst3sRf35d8pluT7ixp06a6P0UzQB8+dRPSXqX0CgS2D6zcjI9F/z+OqD2TvEzET8L6oDtKlbtt9W5U/DRZ6rNpL9Ql51UWdkeaxjjBOjLGEbz7tukSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBxWTFuCGMLtlLH17fPKlxPmwu0YsnWGlBQB9upxxWc=;
 b=u6rLxkBxNQRYxyW8wKUMiTQH83uFWVtO4nLEgdRvWmSc98qLuLnmOwTVxrt8pP2Luh7dJW9U27ETQKpEOzCdVvInO2jJyMX5K+LJW1/mT9YuPZG38WJuT3rQtOH8/bE8eYosI4aWFQfQveLhLVUgbFki/OGBgm0/YHRZOHOPr2s=
Received: from MW4PR03CA0152.namprd03.prod.outlook.com (2603:10b6:303:8d::7)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 17:17:26 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::e4) by MW4PR03CA0152.outlook.office365.com
 (2603:10b6:303:8d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Thu,
 10 Jul 2025 17:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 17:17:26 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 12:17:22 -0500
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
Subject: [PATCH v7 06/10] fs/resctrl: Introduce interface to display "io_alloc" support
Date: Thu, 10 Jul 2025 12:16:20 -0500
Message-ID: <4e275fadf59e36e38ac60406a19cdf67d640f7d2.1752167718.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a69a2af-b84c-4ef3-95dd-08ddbfd5a44b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VoqG3SLsgPtj1q1bwOUEsNTBJ1mkxkIrQiUVKSJ0DIJEqwRFcyOuX2XkSZ+H?=
 =?us-ascii?Q?sD/H7No6Zf6o6JhL9nDBrOY2mNJkw/NTMEyQ2KXhuiDuiHrbvtlyVs+GI8nE?=
 =?us-ascii?Q?O8OiM2WxJxEnVceeHBWHzW5jEw2xQ65tqSUzBKNsnTAqLSZS51CzqZft9+Zb?=
 =?us-ascii?Q?ByqpY8pVZwkVhaj0BvYXXpSd44641Vk44MJKnp1kgwpbD3cAYQKs2o6w7vtW?=
 =?us-ascii?Q?sVSmTR5JPUitf6HncQuuPepRWyoETbXCaYMzV0jV5p8RjaC2qlTHFBJmOdPB?=
 =?us-ascii?Q?CM+dNZTYcwYbwMWsH7+2YQ2luA5/3G5Rfok1cpTUpg4ycduwxdsW1C4NgTjY?=
 =?us-ascii?Q?wkBIOeM/uNZYV8sLzl38k3pfHtK+D9tyoJ6Mx+z3qSCIzgYUAsihACLue04p?=
 =?us-ascii?Q?poA+XWG5gK+JoUir7jj701bciqwMtbrzvtitjv2Ur/MwwDHTRFeLzwuI3OBx?=
 =?us-ascii?Q?cpwHpfk12VdmgrN8dEq5dw7omCtxVYqD5txl3X+ldQLJyrRt9yMu5CCdbDEi?=
 =?us-ascii?Q?tBeeYQS0LolOFjOQW5EpRffeoNWWgcXtcWL+VjU7qyPLtvg8VrjNvY12p/P0?=
 =?us-ascii?Q?B7WuLL3K551jmIuo4r2R4JUwBF9DL76l59ho5UU7T+cmQJxZghxeHBWx+Cp7?=
 =?us-ascii?Q?P0jmsDvHQPzt7E+1vU4PTgzRcz5AKkuGXFD74s0S+NGQBSgFllBamNWm/DUS?=
 =?us-ascii?Q?NVvGtYpIy1VkBM47SJURvxqQcgYz4nyI/mrgKoY+vxYh1Mk0njG57JHysvb2?=
 =?us-ascii?Q?CrIU1LmmkofAiHWotc4TqQaollRUqkptxaQbm0jFnPYl24oa5om3OwLIYz1X?=
 =?us-ascii?Q?d60qsYLZ4bCumfzEZGHXdv5sn0ba7vSn6nFB3oA/omLFEKLF24UeRR7JGLRt?=
 =?us-ascii?Q?I4DvxlddyaCgIPMxtgRhn+3MlJx9fVLXNzhv3aEvv4NgnPdv7V6T4Xd/plGz?=
 =?us-ascii?Q?hPuR0zp3FfAJ73whpxWin1e7q+//ioFok5poV39WAtjUQJfMzatDAwkRBq9V?=
 =?us-ascii?Q?bYpjhXYPP4Lb++vYwdD2A060UMN+pn1xhbM4YIN5Jo0G6t3AEycp+kk4k4sM?=
 =?us-ascii?Q?z7TsjB+dzyiub4Ni3nVO4dAxEt8nfiJcdexOD3gNwAId8qNmYMYPgm6k/OxZ?=
 =?us-ascii?Q?nojPvm+3ddydeRlN8XI+EF2bD3wlVlGYCkqkiyKGWc9aAb1uGl/+kxI4IWgs?=
 =?us-ascii?Q?Eh3rmUar4PZ4/kAC8cyNwJ/oQZdspgNrsX6waieEJ09rzN9MzGiYppojzFNO?=
 =?us-ascii?Q?vUZY1Tg6MpxOO+nPpikIobD6erjngpHV3B5G9Xf3o3saGnU8kA3M5N6vOtdK?=
 =?us-ascii?Q?xs97npDX+LIrqN/hyfKo+Mt80GvgSFFIaA2CqZAz7z9XldpxD4J7SuJCGGOm?=
 =?us-ascii?Q?q7J/0ItJ2rN6wq/h32KqYZl9AcTVqm12Qv5JS56Zcq6F4+/VFWbu0lmXM3/k?=
 =?us-ascii?Q?SCMVO3/2BrlEyD7Z9ZdXhH58KQhVVXou6kBonHWXzXg1RNmpcHOlcMpkDrrk?=
 =?us-ascii?Q?VX7clpBxwUHd+5Gw7+dUTO+6R2fjXOf3ELjK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 17:17:26.0539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a69a2af-b84c-4ef3-95dd-08ddbfd5a44b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223

"io_alloc" feature in resctrl allows direct insertion of data from I/O
devices into the cache.

Introduce the 'io_alloc' resctrl file to indicate the support for the
feature.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: Updated the changelog.
    Updated user doc for io_alloc in resctrl.rst.
    Added mutex rdtgroup_mutex in resctrl_io_alloc_show();

v6: Added "io_alloc_cbm" details in user doc resctrl.rst.
    Resource name is not printed in CBM now. Corrected the texts about it
    in resctrl.rst.

v5: Resolved conflicts due to recent resctrl FS/ARCH code restructure.
    Updated show_doms() to print the resource if only it is valid. Pass NULL while
    printing io_alloc CBM.
    Changed the code to access the CBMs via either L3CODE or L3DATA resources.

v4: Updated the change log.
    Added rdtgroup_mutex before rdt_last_cmd_puts().
    Returned -ENODEV when resource type is CDP_DATA.
    Kept the resource name while printing the CBM (L3:0=fff) that way
    I dont have to change show_doms() just for this feature and it is
    consistant across all the schemata display.

v3: Minor changes due to changes in resctrl_arch_get_io_alloc_enabled()
    and resctrl_io_alloc_closid_get().
    Added the check to verify CDP resource type.
    Updated the commit log.

v2: Fixed to display only on L3 resources.
    Added the locks while processing.
    Rename the displat to io_alloc_cbm (from sdciae_cmd).
---
 Documentation/filesystems/resctrl.rst | 25 +++++++++++++++++
 fs/resctrl/rdtgroup.c                 | 39 +++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index c3c412733632..354e6a00fa45 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -143,6 +143,31 @@ related to allocation:
 			"1":
 			      Non-contiguous 1s value in CBM is supported.
 
+"io_alloc":
+		"io_alloc" enables system software to configure the portion of
+		the cache allocated for I/O traffic. File may only exist if the
+		system supports this feature on some of its cache resources.
+
+			"disabled":
+			      Portions of cache used for allocation of I/O traffic
+			      cannot be configured.
+			"enabled":
+			      Portions of cache used for allocation of I/O traffic
+			      can be configured using "io_alloc_cbm".
+			"not supported":
+			      Support not available on the system.
+
+		The underlying implementation may reduce resources available to
+		general (CPU) cache allocation. See architecture specific notes
+		below. Depending on usage requirements the feature can be enabled
+		or disabled:
+
+		On AMD systems, the io_alloc feature is supported by the L3 Smart
+		Data Cache Injection Allocation Enforcement (SDCIAE). The CLOSID for
+		io_alloc is determined by the highest CLOSID supported by the resource.
+		When CDP is enabled, io_alloc routes I/O traffic using the highest
+		CLOSID allocated for the instruction cache (L3CODE).
+
 Memory bandwidth(MB) subdirectory contains the following files
 with respect to allocation:
 
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index a2eea85aecc8..d7c4417b4516 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1836,6 +1836,28 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+static int resctrl_io_alloc_show(struct kernfs_open_file *of,
+				 struct seq_file *seq, void *v)
+{
+	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r = s->res;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	if (r->cache.io_alloc_capable) {
+		if (resctrl_arch_get_io_alloc_enabled(r))
+			seq_puts(seq, "enabled\n");
+		else
+			seq_puts(seq, "disabled\n");
+	} else {
+		seq_puts(seq, "not supported\n");
+	}
+
+	mutex_unlock(&rdtgroup_mutex);
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -1926,6 +1948,12 @@ static struct rftype res_common_files[] = {
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdt_thread_throttle_mode_show,
 	},
+	{
+		.name		= "io_alloc",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= resctrl_io_alloc_show,
+	},
 	{
 		.name		= "max_threshold_occupancy",
 		.mode		= 0644,
@@ -2095,6 +2123,15 @@ static void thread_throttle_mode_init(void)
 				 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
 }
 
+static void io_alloc_init(void)
+{
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
+
+	if (r->cache.io_alloc_capable)
+		resctrl_file_fflags_init("io_alloc", RFTYPE_CTRL_INFO |
+					 RFTYPE_RES_CACHE);
+}
+
 void resctrl_file_fflags_init(const char *config, unsigned long fflags)
 {
 	struct rftype *rft;
@@ -4282,6 +4319,8 @@ int resctrl_init(void)
 
 	thread_throttle_mode_init();
 
+	io_alloc_init();
+
 	ret = resctrl_mon_resource_init();
 	if (ret)
 		return ret;
-- 
2.34.1


