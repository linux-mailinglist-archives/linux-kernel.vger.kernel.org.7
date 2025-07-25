Return-Path: <linux-kernel+bounces-746176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66761B123E5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA251CE5F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6432528F3;
	Fri, 25 Jul 2025 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vu4Xitkh"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7778155C97;
	Fri, 25 Jul 2025 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468356; cv=fail; b=Etg/00rJX7jOioYTytALYDFlpXxUbd4P+yx2AVHIB1KvAeCb8c9UNys1uMxfTHhxpuTpNABmyFOudeHkxpoVfnl8DJQqjUFBHjYXb3HLoSRsK274zzlNHrwCudeQAhKcLbgmvSqzZL1r/vC+TkeJHcomEsUF9Bbzozkdiw+j+4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468356; c=relaxed/simple;
	bh=d/ztbK69fmZQB4q/0TMJVwAH27XE+LebtZc2ftEG7LY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/k0IrOjx3YVxKgfau6MMFavfF9GjrsEei7NkN2Iqzpcv27zbubk3exqDLHfW9hjuk7yEKwQOZumxaCl6ucH6PJ0zmcZsh2wNBR2XYA3BU/u9KfkIxJ3MrZh6SN9N/J76834JRHYwvzn/dZeO2oxniVFjlcGIamqCkUO2DfEC0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vu4Xitkh; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P11u+Cia1xx2669jSTsziirkKofOWo0vSj7tjpiJG68SKai2eVA9jVxLCfUOTVjl2hxKSDzlYeltI7FBK6Opj3PzmbvqN8yUgEfLcJKHZMDTSzkeZdOUApiQotGeAvhy1L6fQY5PHjefkBOm4Fj13Qtezl92huNmv1oG7PUy9Ogx+d4DCl/G32saqof/ajxN4CEzKbDJ3WePnAaMYqhcqY766Op1hZlu6e/oVXuwgoJBDMrz9wB+10apFkNVBB0SXnmCNlC+y3EU+8IDfuigvgBqj6anFGW7yBetm6+zjvg/2TOhbAkwNGz4fBrMXrXAlPwUlJPmI6qcsdSZD5XdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VXV9csTEwvTnJ3ZEbLwzaUTRbd3LartIn08Z8aP5ZE=;
 b=GbuZJuyVjRelm2yorTlAcBRkJYViJr2Y+iIkApfNuOF0CwddO+1/dF2YkYBCdmCPae0B+uRARPphFHZxogorTd/KK4+lbvIpnmzLNLw/8ovKpHleNUh72cnslr7hrjDM4MPgASQhwNli1Dgyhj/sebiDbfwDO8BdMWtkv1mkXLEBUrrq7PsGNNBI8oGgncnhi+mtfoJDWDABtH8Gpwt8/02i5uXrMH3r292sLkTK+obcBYF3ztp8IVNnuNS19Dmr1rri6EpkmNoocxqStW5scZSE0dpuG1z31rPHOJyvIzJNqLU5HcIHGqJiygeAt9fqFxEQvOb18WsTXWLa8sSpZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VXV9csTEwvTnJ3ZEbLwzaUTRbd3LartIn08Z8aP5ZE=;
 b=Vu4XitkhBGuOzq2HBDVV+c7B4x5tTRapyEu6EuD/NiJ/7mvpzMngkcI9sm0N03nzx08GfJbTL1TEodT5JAm5WJ+ypJS7f6M9Zr31MDZSEMh5iKB1WA0kcD3RuKwdA/brWHwhNG//3x34lObqX5520cB+W4HuH/S3z/otDdyAaeU=
Received: from DS7PR03CA0311.namprd03.prod.outlook.com (2603:10b6:8:2b::23) by
 DS7PR12MB9044.namprd12.prod.outlook.com (2603:10b6:8:e3::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Fri, 25 Jul 2025 18:32:30 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::79) by DS7PR03CA0311.outlook.office365.com
 (2603:10b6:8:2b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Fri,
 25 Jul 2025 18:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:32:29 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:32:27 -0500
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
Subject: [PATCH v16 13/34] fs/resctrl: Introduce interface to display number of free MBM counters
Date: Fri, 25 Jul 2025 13:29:32 -0500
Message-ID: <9e805169d3fbc889a89b283d074a5dff23cb0e94.1753467772.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1753467772.git.babu.moger@amd.com>
References: <cover.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DS7PR12MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: f93fa4b3-4b60-4a6a-7bb7-08ddcba99cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GJJEyaMcyL8xxi9fLOvP8H5/aE+ACufUtJ6FNqdHVOf3Jq+duRb5ZtoXIM4C?=
 =?us-ascii?Q?7GpESsFZeRo5LlkPW+zWkStep2SwwrLFjbvCHWFAkQYNXDZzE4ZCvKUpiXFk?=
 =?us-ascii?Q?jjUTILMym2gE6olUIZ0gcB0hsyY5gJQTTX6Uk3jJNdgsjh+J/4Eib5v79lKx?=
 =?us-ascii?Q?fqsIIAcvtzsM9Jvc1RM90SZDEUSOmKElum83WpI8dyT+WJ+wzLQWk00TaFJ1?=
 =?us-ascii?Q?6Cg5VKUpBvmdiYtywJedkXDcU28hc0xXATimrpMmmouYCgBS4W39m8ty3le/?=
 =?us-ascii?Q?iARHc+InnBlm/KzEb64VQJIPLSZErUq/sG/cbMWdKFo68zRfmotjUdNYtBVp?=
 =?us-ascii?Q?m0jptbezifI5Ua8nGj1diAxaGs3PdQxmVLXVjj0cWbtZoTqJ8LGjW5k8QnX8?=
 =?us-ascii?Q?gPLXYeiLuVCAvN5ssUGlRFEUrxX5nXYsun86QmUZtgQC73BqrysB2rwtxfJ2?=
 =?us-ascii?Q?ZumSR6uSErbdrkFN4XP+HgalbhsldexVKmKlBtDXEqaMqZvTPxtkB3Jm2eIL?=
 =?us-ascii?Q?c2yY9qNZ2CSLKoqkckTZVQc1SA/S1RVlflyhb/76OI53FdJ+xqSfsANJ/c00?=
 =?us-ascii?Q?Yz/iaTX5LVPD8oBPsRsYb6oUr7hbMhGxW5+PWulxH0oWxjTFe6waUd82CIfY?=
 =?us-ascii?Q?P1kezKeLodzvT1Fv9MC8vHVvUS+GlMKrgg/FuWlokikIPMm0GGqGAhqQ+TuC?=
 =?us-ascii?Q?SD2tAm7+5B2d2qaPWS0Pm8yiNneApxWEXfxH9/m+dR0vAmh3pgMmCMHKEIQc?=
 =?us-ascii?Q?RGd1Z0KuwWqA+PWBao/l5D7xeK6Xr++2ffQm+DbGVlrECwHNcaMKQxNZHu0d?=
 =?us-ascii?Q?fVgwlaFcGCmG7VaNUnMLj1q/SypCwDJ1Co2uAE19XEbVrfp/cOe0i4etyYjG?=
 =?us-ascii?Q?QWO7u3vf5ORIPoScqJkFAWVEHnnf+kbsjgagpIF7ysTWTrooAksPUWM64vrd?=
 =?us-ascii?Q?yt0AX9lyFN1vi2wQzBr3H/jycDDJT7MqJSXNQm5NkFwbYV45CYupz50ZHZat?=
 =?us-ascii?Q?WyVLJ56xvowLlTXQBLJeEuEYrN+jTxroHeZaN6XJLgaKhBylWsld1TY/tUVN?=
 =?us-ascii?Q?bFXr360HmF/Vv6gDIh7jo0PtLQcPUzfXoN5Z1kbfXvXXPLfCHEK9p3XMK1TG?=
 =?us-ascii?Q?XV93qkzlQ1U0Bt7aVE8FYpGHzCazNuYIOcaIzMeAekZ/2ll9Nr23q0qYNuUj?=
 =?us-ascii?Q?53cNwMAyYK640omhYdkaOjUe2uxUol1TcxMV83WJi5+8PTkKJJrtxV/uaitS?=
 =?us-ascii?Q?1g/tVp5n2NwE6fZ5XN7vQtxDN9k2gKD2UuSWMqjg8yQ2wogpVpckxW10VDbE?=
 =?us-ascii?Q?D7PlEEmroxl5rzR5g0bCO/EaXUACnkrB8cZRZrkeRWZ0UcwitsC8Rz3dRkyj?=
 =?us-ascii?Q?IB+lAO7Re3HtFZkNCLm0kp6a9iTtntd6FnNKSC+pcjWRghDb/KmdJ3JmCLj3?=
 =?us-ascii?Q?PQTdNxKnv5cPywyPITeoSJUX5u9sr8npduAuFGDusjzhyOl7hJq+5LJVjIxL?=
 =?us-ascii?Q?D7hESkwDdQVKcxvhLp0PUIGUtDvGIb99Ro1k1WKTPOfo1nXwYnVXaGs39w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:32:29.7375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f93fa4b3-4b60-4a6a-7bb7-08ddcba99cdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9044

Introduce the "available_mbm_cntrs" resctrl file to display the number of
counters available for assignment in each domain when "mbm_event" mode is
enabled.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
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
index 4539b08db7b9..a0b0ea45c7b4 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -931,6 +931,8 @@ int resctrl_mon_resource_init(void)
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


