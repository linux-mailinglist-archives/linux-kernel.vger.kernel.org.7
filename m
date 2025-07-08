Return-Path: <linux-kernel+bounces-722453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 107BFAFDAE7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83DC27AE68E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785C01F3FED;
	Tue,  8 Jul 2025 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iNSwGe5P"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2F61DE4CE;
	Tue,  8 Jul 2025 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013203; cv=fail; b=UtD0VKUHIvMUepn48kd0BnTvyimhdKdJSzNx6K6w0Dj3CWB3x4LlrLgr5kD2YCbHgxveyt2q99ewYtbv3kKayWlaFCTIRhVJwzlNatKeSWZHgtqwiorDq7P+yHSq9daSGttnIgjGxIPry4bnBwn5OElZdw+RcJmn1ukq3jo1VNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013203; c=relaxed/simple;
	bh=UxMAdL95iBXGqMRaKUncabTXDrSTrSYl52FtwmHomMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+rLPV66TvmmFSjL77wC7tI8XQ6LpfS/0N6zMWEyGim4DpYQfsXnl1F9OlvaLJ3EQwxBznFaRbmpF6cOTm2HJjIGdOGVtwACASFU80wT1hWTq6JVQ4yYjwNpJw8e8WnUg40RF7nTFeynIMr/T53nJ5Uo6/88/QtqNk/WcDmtdSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iNSwGe5P; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zozh2/kgHa1pjCU9Ll5bwxhXG+pznkEQaRXaJ0YzAv0naEY5joyaz7Ce9p5kCezkKMCotwExRhXtiSn9SqKJfyFMOl08bSZ1/ajRkCv8j7SxbbLQI/cxiL2of2dCbHwzoFcFUe0/b1FIMsBMzI/tmuR1Yzr/Shg+g9oXink5LC4aAqPtdOs6wHzOIkquHTgd8MZkVDlnkUVZEOuBtu9ECaXbqN2VYa9lZhqPtOkvOzYYE99Up0CJWtM4SxDorcbIdj88kHnb2BDcyqzsx0Z/NU0QBQjU0y4e2etQwHkxiEisyoM2al7vL6/QI6ELsMg/ept7HTjAyPDGkGrD2pe2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQhvj3+EW9IFn+ELI9181pnNqJTCEySmEcIR5RMZRnI=;
 b=QCiw7nyxi+i1etTgCQHLq8kVnF8EX8hBJDaOMRf6WxisjR5SVrqcsOIpShTn4LmNL99jnmcGGJ8Dw4XquDgfBf20ps5GreLM4DES3HOPWR90uY2x5eVdeamX0A3f4e7l6jNKfGg32cowvMrtH4PSSFO6Xk9AVNMMU8x5f/R9DRaUqWUvFPQM9idLDa0v0IpApitw6CsRjb6q2ul8z0NDSLJBcWc/fBURnziwnGyLCifdh29JBATaJgU55ZwJ18kCWbvcFSixV+eDGKOknf38C5NTvsX/9TTA2d/iGeyF6hllpiqN/8cPk5Kecfi4nPcZJ6jgtPcO+xExbX1o/obnrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQhvj3+EW9IFn+ELI9181pnNqJTCEySmEcIR5RMZRnI=;
 b=iNSwGe5PuU5arXHKd0bQFItlai77yCUCa2t6thMTy0wJsU4591Hqd5Lt7P80eGFBnCanWVluvuPdMVIwirZUSwOPpDkl9tTfezjdZqBcZkpbbu/ili0pKVeqyGU3H9iq36QQuyoztMzL53p3q4LdGsZL3KIpSX5diXLVkRdrElw=
Received: from SJ0PR13CA0057.namprd13.prod.outlook.com (2603:10b6:a03:2c2::32)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Tue, 8 Jul
 2025 22:19:58 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::11) by SJ0PR13CA0057.outlook.office365.com
 (2603:10b6:a03:2c2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.19 via Frontend Transport; Tue,
 8 Jul 2025 22:19:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:19:58 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:19:51 -0500
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
Subject: [PATCH v15 13/34] fs/resctrl: Introduce interface to display number of free MBM counters
Date: Tue, 8 Jul 2025 17:17:22 -0500
Message-ID: <56a73d1ecc3f6e2e7e0c8d096a0df5657f823022.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: a3fbc880-6155-4fbc-382e-08ddbe6d92e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B88LUBrtgPQpjDPBLJbbIXh4Xtfb6NHBc2Aw6OsyGhC2Zmif6JbIC8YlbOpk?=
 =?us-ascii?Q?RTyZZ8C60AQ7jTzRYsQxHNt14smZZI24UPbLRxQBwS6qx6Z4KfU83hqToLkW?=
 =?us-ascii?Q?upYJU+TEqzORYpUxIYyvB81Gr1k9GO3CYc2R2y60+5Z9ss3A/RNiRSx7ZHr9?=
 =?us-ascii?Q?4WOvO+0yxdPDwKMSQ2u5CSxSrzARBaNSQbuQAHQYGYcmjcjFymBFhT9kp1Nb?=
 =?us-ascii?Q?gBHwjQsNaU4zdZ0DDXmUbtm1r0+p0gb3jJ6LlJec2fOEl5bIzmLFSiNA8Ac5?=
 =?us-ascii?Q?9hBu7/r3Uk3aKdqlWlLX+zO7coxacW/ueLHhNh0xobJRsySyhs1kWCZm6Ape?=
 =?us-ascii?Q?ZXP7/EpJ0X4ezc1ojgsaZWVL2hTpo/SgiTeLaL2nKQ9GayijNQyEpY6nHoE6?=
 =?us-ascii?Q?L2yJzv79EoMBN4RwT7rPVfg9O+rCY7U+zGLoXhop0WZ8HHhrL2+xim1wOJN4?=
 =?us-ascii?Q?hiriKf2hwR/LYlq4gLCLR5Gu1NRfzqVPC1BL6SzPZLuONv8wSe4fv3njSld7?=
 =?us-ascii?Q?6+1DOPR/7GedYoEw66rSbqIG4VO7SucQryybMPnEgUBuhnBtVw2UZTf3TKS2?=
 =?us-ascii?Q?cIfI/slDKBYbCDVw/rCq1x4F3Wprti15oqcBTLm7sKh1yDVhLLiuTMlNK/Q0?=
 =?us-ascii?Q?lStkbFpa3tu7f1//rZLf5O42u9owZqWXBhUudX/QXzfncumwhxg+12/fSvN+?=
 =?us-ascii?Q?s7Plx/tYkLZWhcahhxnD8MZU8lsBcPS2scDminedFzMfv3EA9+ZgXYH/z6G7?=
 =?us-ascii?Q?hiijRKeWuqdEWXvk+WHiFXF68HdaR/K661pyQIscxlRsRuU2f9F6DERzRW8h?=
 =?us-ascii?Q?FQ6/7ykiUB6aMIl6lCesMZWY2OhsKuog7clomfXAJv7wFh9KMG3ed44+dmtQ?=
 =?us-ascii?Q?MS7z4L1WGGzxTWuMXoXPjj3tOlgy1Zt4z9d3X8RG+1pLV5omCvoX3K27GBVZ?=
 =?us-ascii?Q?bcErURLPBGnKj4ZWkMVFD1EzvBGO/cN2gB6DSc/oa3l4r6hULpl1d4NpTJ0k?=
 =?us-ascii?Q?/KAZGmgM6zmVuTtVcZmUkVKpOz4fZlZ1IGyELAXNega1o4ivCKMC5HVp8A6Z?=
 =?us-ascii?Q?yh2NbLpxpd+fYlkGqTYv2/X2XvKKEKP+dti6ZDgZ5SYRkQFruBt9ldrHa+kJ?=
 =?us-ascii?Q?MlXvvGoeJcMTvbEW6oMx0DSmtvoEPIYL/YVP1darGjAZofuOVJa/DN8sZyOE?=
 =?us-ascii?Q?124r5CKdyFajGm9YSUY1BRkCKLEH0Ig3My41h26RRFVXfGHVpU94JOwQX01l?=
 =?us-ascii?Q?JAzBMYkTddzN0ezIGbn0soA/grO9qMcTNpHze4chvK1Zqszn6zPwAAiFNvcE?=
 =?us-ascii?Q?zOYaHVURv/5M7HaRwV7YOnY/Oxn1LiDXepNqUFcCQRNsukHCPmX2Sqy1XI4a?=
 =?us-ascii?Q?62UtkXJkW+2qZ8Zh9pROsflNSXlM5mGgb8uqK/Omcw5HPNpPlqXjVftHmSUh?=
 =?us-ascii?Q?01ZBszxj50qU+gHgrpC+aS4IdkZ2HIInENaYTKuu+/Sm0UW0rvH6Booo1AWs?=
 =?us-ascii?Q?+uKOvw9H0Qft3mF/+/EielrMl5XzVbAZgNxuCHoa0Ff0K7C3uol0MO4jaA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:19:58.0523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fbc880-6155-4fbc-382e-08ddbe6d92e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693

Introduce the "available_mbm_cntrs" resctrl file to display the number of
counters available for assignment in each domain when "mbm_event" mode is
enabled.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v15: Minor changelog text update.
     Minor resctrl.rst text update and corrected the error text in
     resctrl_available_mbm_cntrs_show().
     Changed the goto label to out_unlock for consistency.

v14: Minor changelog update.
     Changed subject line to fs/resctrl.

v13: Resolved conflicts caused by the recent FS/ARCH code restructure.
     The files monitor.c and rdtgroup.c file has now been split between
     the FS and ARCH directories.

v12: Minor change to change log.
     Updated the documentation text with an example.
     Replaced seq_puts(s, ";") with seq_putc(s, ';');
     Added missing rdt_last_cmd_clear() in resctrl_available_mbm_cntrs_show().

v11: Rename rdtgroup_available_mbm_cntrs_show() to resctrl_available_mbm_cntrs_show().
     Few minor text changes.

v10: Patch changed to handle the counters at domain level.
     https://lore.kernel.org/lkml/CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com/
     So, display logic also changed now.

v9: New patch
---
 Documentation/filesystems/resctrl.rst | 11 ++++++
 fs/resctrl/monitor.c                  |  2 ++
 fs/resctrl/rdtgroup.c                 | 48 +++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 4eb27530be6f..446736dbd97f 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -299,6 +299,17 @@ with the following files:
 	  # cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
 	  0=32;1=32
 
+"available_mbm_cntrs":
+	The number of counters available for assignment in each domain when mbm_event
+	mode is enabled on the system.
+
+	For example, on a system with 30 available [hardware] assignable counters
+	in each of its L3 domains:
+	::
+
+	  # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
+	  0=30;1=30
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 54e9a1d0c28a..9fd1fb76f82f 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -929,6 +929,8 @@ int resctrl_mon_resource_init(void)
 		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
 		resctrl_file_fflags_init("num_mbm_cntrs",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
+		resctrl_file_fflags_init("available_mbm_cntrs",
+					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 	}
 
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index a09566720d4f..15d10c346307 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1853,6 +1853,48 @@ static int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of,
+					    struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
+	struct rdt_mon_domain *dom;
+	bool sep = false;
+	u32 cntrs, i;
+	int ret = 0;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_event mode is not enabled\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
+		if (sep)
+			seq_putc(s, ';');
+
+		cntrs = 0;
+		for (i = 0; i < r->mon.num_mbm_cntrs; i++) {
+			if (!dom->cntr_cfg[i].rdtgrp)
+				cntrs++;
+		}
+
+		seq_printf(s, "%d=%u", dom->hdr.id, cntrs);
+		sep = true;
+	}
+	seq_putc(s, '\n');
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -1876,6 +1918,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdt_mon_features_show,
 		.fflags		= RFTYPE_MON_INFO,
 	},
+	{
+		.name		= "available_mbm_cntrs",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= resctrl_available_mbm_cntrs_show,
+	},
 	{
 		.name		= "num_rmids",
 		.mode		= 0444,
-- 
2.34.1


