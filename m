Return-Path: <linux-kernel+bounces-770003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92510B275CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA0D6036A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0587B29C330;
	Fri, 15 Aug 2025 02:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O2C0yr7U"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543F929C327;
	Fri, 15 Aug 2025 02:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224870; cv=fail; b=pqYDq5lS22CEgb3vmALzbGZzPdftCQvNJkOUdYo9Kg0/OHKN9QKNKJb1nx70RJJdkbDBKjgn9fvGF8gmx3iK5sNnasUfjBHuP7NIrbfLFrsq2z4Va4jvt9Op2+7VMpk6l/g6duuc7XB0W1PHPy/Uhi3SY5V4HsnfRXqzZk+KwHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224870; c=relaxed/simple;
	bh=FrMVpbCUyVYXxltNyMrTvrOZD1Gc86Fz/D4yAbshN7E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPgyohMO1pdgzcWFRrnKRCK30THcx2Of3fU3rRYqGreIAdOgyuMYO2MIn9X++GrccUDdvqT4lc8fIO83ycFD7KQ6ob4NkLTCQAH1xCMKyWb/f9L79d+Nfd55ly1KFbLK9MBEmv4Myb2a5qEeCyVOjIlA24EKT/vc3n/RTXuWegE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O2C0yr7U; arc=fail smtp.client-ip=40.107.102.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPlECgd+rAuRsge/Io+rjPq4pfONJbCUvXwbSUXsNmnYWS9DYLwJ1+cxfZX8vz1vLds7RjJI+Rp3xjbMhsmFegMdQIR7n1BETbbXyLLYCaFVfMk7QE5r4Bc0bEC2EzTwtldBCMWxG0i0Yqaoi3AY1yYGdDh3ToDd6poRCQLSjbsQupM7yAlxwbpgqrWni2ala+AsagBrnGBPRWPc86x1mNopaOJCTASMuVUUTzNdjAZYpYWZX6AQwrSjWscVum3LKq6NQpQYJuW1CDaBDKpy1Ij1UgoRp0kQCocoZSkZnrMJwJp8gn6utfML5Ftnm/XV7i/hJsEeTk010j91aESLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl0gstxzlq9/dmUg7xaimXzE19hrZ3uZsXawJVIqZME=;
 b=sFg8BOfLeVRgSOcLcwJ5gn6gYNF9+7ytsRKZtydgzS0v6r8Cj6vwI9y/ExmPaa6C/lG/JpfSO/hXEE7wRRXlsHiBDjqi5YSq/7bVG7lz/NHMBYM/tyaEdUuRxvDXkHET/eCv+H+4dpiX4DW0+Tm9sSrK4689ABUVoe9W7mVIg+HeiugvUt5Xg+vWIIGgCVklQpg9dsokpaQxPJjnVlW7N0UL5XlRE11HfwJSff/ZZ+R6ZW+8+6OjuEazIkBpITUrv1gkmVxdVnn75TmQpyXfc4MEMFg8Po2kBmTyrg5oKb2UGnBttSzAsjDSCrCVWpcQIalAmNY4gHB6l2/jes60vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl0gstxzlq9/dmUg7xaimXzE19hrZ3uZsXawJVIqZME=;
 b=O2C0yr7UU/MXu9293I3URJ0FgkxVNhdtOq78fJldlc8sVX5uTcVeRM6yx0Bfx/kh9rBv5oTDSAOVi1N/R86wpj6T3PNJoWjlltcYxhQTM1kzOPA8AiAWLZQ/6jGjxD2PqiLkqqqJ0ZvQMhD4QCA3KS0HL5+lT1ZLLl42WbwYyd4=
Received: from SJ0PR13CA0194.namprd13.prod.outlook.com (2603:10b6:a03:2c3::19)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 02:27:45 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::70) by SJ0PR13CA0194.outlook.office365.com
 (2603:10b6:a03:2c3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.7 via Frontend Transport; Fri,
 15 Aug 2025 02:27:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:27:45 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:27:41 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <babu.moger@amd.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<rostedt@goodmis.org>, <paulmck@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <thomas.lendacky@amd.com>,
	<yosry.ahmed@linux.dev>, <xin@zytor.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<mario.limonciello@amd.com>, <xin3.li@intel.com>, <perry.yuan@amd.com>,
	<chang.seok.bae@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<eranian@google.com>, <gautham.shenoy@amd.com>
Subject: [PATCH v17 13/33] fs/resctrl: Introduce interface to display number of free MBM counters
Date: Thu, 14 Aug 2025 21:25:17 -0500
Message-ID: <1faeb40f2ad9170120ea9e676109c84f979a27ba.1755224735.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755224735.git.babu.moger@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f15652f-fda8-4e62-aec3-08dddba351a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UzSCRQAJdHrbM8Ihur6ckNEzbNWtw8QeEDApr150wC+/r2tht8CZknpVEzIw?=
 =?us-ascii?Q?H3KBNcwEc/4qYFtY0AowUngiLDjR2D6MmtVxPC77XQ55aF+5Ho4xvt4Q6GYc?=
 =?us-ascii?Q?h/dqSk+36ik5TDTMyHrSZQxLFFFcMew0YbEx9yWUVNm2AglJS26fduxfLxpT?=
 =?us-ascii?Q?ytc5gMRQBhZJoOx0+zeFwDfliuHbRxQLwviwCW9vYyhabGN6pnar9UBt1xR4?=
 =?us-ascii?Q?6wqJM6dhHh9tBJKZ1fbLVZXOE+xS4FZPo5C+eO2eciMyCockFScWA81piFJz?=
 =?us-ascii?Q?JPzpzI7eVgMZgG8rugxyST61us+FFz/72GbUjXfjo5LqeIKKGtVeL9ESBGA5?=
 =?us-ascii?Q?m2EbF/OXP1SbnSqTex1th7VV2GxQsh7UDKvnQXxD4/iDtebPL2yY6zig12fH?=
 =?us-ascii?Q?GZ1CLifgvnbj4J8kU+NQy8uisSSsHdGoVs5FJzsqlpuy65jIdk7oJLBExIYd?=
 =?us-ascii?Q?K5OS7LZw/1cnLXjBVh6EJ6/hrcQAAlZwkOGG09PtQSOpdiX8SZqluoLCBA+6?=
 =?us-ascii?Q?h0Do0JjnisjNCIpDxafciSyySeyNPn2mB198tHDQXbsTzNZnNmqwf/E8eqoP?=
 =?us-ascii?Q?cIO5ydu7ZtaxogZEm4MRj1JbqcAYMhyNr80Ifnyb1EztgpLWya4eOvZGN59z?=
 =?us-ascii?Q?YilrEF7Llnk+5nvty8pQAVy4rFmAm065CfeKzjSWLi4VRJ1jhLivkEDBfNrV?=
 =?us-ascii?Q?CZgeiO7JLUfkknwjnRsYS1aYsVtvDWhDJ2s/oKvkUxEC/YeQQlCEz0+jGWpG?=
 =?us-ascii?Q?N9IuZLIK1DnHQL9SUll7BL10b0MxlPFFhBc9mBq5wzVOudpLliQadG6ktMVq?=
 =?us-ascii?Q?+z4cZUqfoQqwnglzPLngpBZUMHDr+tZeJiEC+DdZqTJnV3WW/tT5mnfWqzDu?=
 =?us-ascii?Q?+dL8hveX4VffAWHR0LYajdZnQ2oQYy0E+VS0+kyhkP+dsjAWAvGHWVrGMEhW?=
 =?us-ascii?Q?7xGRuD3HYFZQOjX3lrONPdN4BzMcVp/ve1GMipgn6MJbQnxdXZTmW8INzZAB?=
 =?us-ascii?Q?LpQdjhv9tOB5PLzVR9MdRAjvFIywiC51pacfo3bZL2WSUHrAZjStzmQNC/0G?=
 =?us-ascii?Q?faePDb+3+ZZ0OJP5fHqKu45IMisATXJCGqEUdGqGhe0Y74Sk4ZXb/RIZZfTd?=
 =?us-ascii?Q?perClMxM6CyfYNNlqpHwwItaGEl0f2hEb46ms3bXg866QAyfSYRH+8KFXOKF?=
 =?us-ascii?Q?Meum4fVbr7E5ZdKui/LxpGRJKjQM3QyxF3xQuz/BKoE+Pw2FYqjeUIMYsFfK?=
 =?us-ascii?Q?gS/sdBpJQ3VtcVsbEUnYFDM6lAKo7U428mRUaZZLDbFQ7PyEtljKLFbZNGWn?=
 =?us-ascii?Q?xtFZLhA18Z+PFPPibkqX9F4dFsYLu8peoWCtTE7TV5aGekAZfoLGU8HbNdXM?=
 =?us-ascii?Q?Vdg/0KcVS3xO7HaiAG2/Hq2XJZy5iyGSLGbgFoxq9ezWIigL/m6uoIziHRCs?=
 =?us-ascii?Q?SWyySPwhJvmT6QT4aTDB+rzJouoE5uVWlHQcLU51k+qVBEkvZkBjTM9CzGUh?=
 =?us-ascii?Q?NMI+2XyR61suq1s/BE7bKpAfB1dQiM0vQEGLZIDOyr3So/jh4ThmIInk0Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:27:45.0970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f15652f-fda8-4e62-aec3-08dddba351a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086

Introduce the "available_mbm_cntrs" resctrl file to display the number of
counters available for assignment in each domain when "mbm_event" mode is
enabled.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v17: Moved resctrl_available_mbm_cntrs_show() to fs/resctrl/monitor.c.
     Removed the Reviewed-by tag.

v16: Added Reviewed-by tag.

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
 Documentation/filesystems/resctrl.rst | 11 +++++++
 fs/resctrl/internal.h                 |  3 ++
 fs/resctrl/monitor.c                  | 44 +++++++++++++++++++++++++++
 fs/resctrl/rdtgroup.c                 |  6 ++++
 4 files changed, 64 insertions(+)

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
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index e4d7aa1a8fd1..35a8bad8ca75 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -388,6 +388,9 @@ int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of, struct seq_file *s
 
 int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_file *s, void *v);
 
+int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of, struct seq_file *s,
+				     void *v);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 667770ecfd78..4185f2a4ba89 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -938,6 +938,48 @@ int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of,
+				     struct seq_file *s, void *v)
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
+		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
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
 /**
  * resctrl_mon_resource_init() - Initialise global monitoring structures.
  *
@@ -985,6 +1027,8 @@ int resctrl_mon_resource_init(void)
 			resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
 		resctrl_file_fflags_init("num_mbm_cntrs",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
+		resctrl_file_fflags_init("available_mbm_cntrs",
+					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 	}
 
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index ce1c894dab18..8eaad45b28ea 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1822,6 +1822,12 @@ static struct rftype res_common_files[] = {
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


