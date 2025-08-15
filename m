Return-Path: <linux-kernel+bounces-770017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640FDB275F8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC08BAA2E35
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36101299AAC;
	Fri, 15 Aug 2025 02:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l2+nAMkv"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81E729B776;
	Fri, 15 Aug 2025 02:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224982; cv=fail; b=U9BQcA31uU//nbnSRSsHBNlj3yTjY98lzkQ7l13u/jIVSTDxje8fZBpruFzCF7Y21DEu5j3IZ3Hb2uLGl6vnHS0EkcrRnbZ8eY07vywHw9tORXgG3xvAiYApHGW1GqRg2a6QxASoq4zGqbbW/YBFSwBKC+ZJLE3goX2jd89t0Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224982; c=relaxed/simple;
	bh=l+JUPiNue/ArvAu1qss6G+LM1aiU93uW3xVOVnhm5bM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTUWhJWedRhqyoOgBf5mlSmIH5onMwPbFl11g8q5A05borJYWGVtwiaQdOhm/wsjS/Muk9M2qnmLFjKqzFbs0bB3HW11nemlLzBX/XlAaOsuNMByfoOByKVkldx7xU72rN3OgDfkvq/OOhP7Z7XmId6Td7WT576a2LMQVkqiX4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l2+nAMkv; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTdxjBQuB6rk+kODvGIVb5XdiZHN6djeb0FU5ztPOun9X+s1mK1fFyKzQ2nMvFQItTVUdfMxr8vBITMkDCp7XX5LwIexaghyDufqwaqzCfjWKupINCiY2Ufstm7+/jIFOWwKYm+hBHSlO8nUmb/9F8I0uwGqruSzt/cA60laZnXiTcXxrlrsWMAnDrxmGSuENKSyI30V7v7ZJhut8MMlj9ePUJFOCLRSpEg+4C8cYwnv/5k2jNiHp7TyGOTu0LxXYQD6BCy0zn/urX6VwXnFROMb0soi8T6Nw05YtGzJ9WV2iwRmQOGnhKyeHGTMJc/6d2m3qPgUTndz0kTDvHUPpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egFwTCNH/JTx6HzK7f/TRXG9eibzrSELD+vnxZMGuoY=;
 b=FKhkzJG0vbclLMEPMgYa5r+CrSy2m8QdXwxekS5qedVSZCcges5VRVmpBolpPQ/VGrOLso15gnWj1YqrAruErq1vpnsb5WLseTfwbhehBj3MAlVw5jp5tomrfWhktyPi2fDiPVzbTe0OhLXUQ+++QKOS4eqedGUhz4NSP/Q50lo+qkDX+Yvnfp69/g3ByMVIDO5nTPLh9J053U3JTXv/yXQuM4ZoUYissQzfAhMUAzNNr9DWvHAoc0vTy+EcplHXT500G4Jwujya0ZAjq8uEn6PuoEoUO/cQyPw4xyRwwmYxrFTnl0QwoLviA70Ur3ei1jAE5d/D9MJxyxGSalBsIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egFwTCNH/JTx6HzK7f/TRXG9eibzrSELD+vnxZMGuoY=;
 b=l2+nAMkvJHSYcZao4XrDIEEmrc7nZfWYUNhDikVj4ghY6x4/H0gxoE6o6XWfBYgPSC0PwyiRROXBpv3joLAgBeA/l8sItQiXhuJ79krgbQtdtXeQFXjhLSuXgyXGhHz4vg/7vvRHhKPPv2W4+emJxafE53C2KuCiVGi5d4u6COo=
Received: from MW4P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::6) by
 LV8PR12MB9618.namprd12.prod.outlook.com (2603:10b6:408:2a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Fri, 15 Aug
 2025 02:29:35 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::c2) by MW4P221CA0001.outlook.office365.com
 (2603:10b6:303:8b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 02:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:29:35 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:29:32 -0500
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
Subject: [PATCH v17 26/33] fs/resctrl: Introduce mbm_assign_on_mkdir to enable assignments on mkdir
Date: Thu, 14 Aug 2025 21:25:30 -0500
Message-ID: <1966b499476d38cfbed6896dfbc50cddad35a126.1755224735.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|LV8PR12MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: 351aca8d-6bab-4d14-6464-08dddba3932f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m5TBSt/SgMiTp3DUaPaF7tcYBy0l6UQ4r20gQUp67FyULwgmNgkoFyiSxG+m?=
 =?us-ascii?Q?kCDj5zbw8fCtxnTNWoh0Ne+f3zc6kon2nyj+xDsmTPBOmTHnFcUi3neyRtzK?=
 =?us-ascii?Q?Zsq73oYjl9RJW1zOSOVJjdNNup1xpWm6nrV0ofha2KDCVEeywunGFS1Vjv70?=
 =?us-ascii?Q?hZnMtFKyUwlCmvqYlNoCIOEpi08Qgo0xq/3uf+PStJZpvSOxW9BZ0UA9rZXZ?=
 =?us-ascii?Q?XlYKygiPb/FsQ9zBDgfHjySwe6fSbDo2TvuWxlqYJveSEcM02cqWduD8O25v?=
 =?us-ascii?Q?+h2ENEmrIUrNMr7by8lE/gjuCTvQbahUaqve2Bk9ZZgk/VPMxfBenKpD96gW?=
 =?us-ascii?Q?HYUwDZ75kLhZAXKfUl9CRqoSbulIjESkjphxgNUUswMIrJZMFe77UoVJq1Q+?=
 =?us-ascii?Q?h+9jp7pLzT83lyf9psNAGA7zhmJ2wx0v0ax8sc2Abx8pF6Xh/VbTbikl6Vqv?=
 =?us-ascii?Q?L9xLfEgNk0ufY24WIVGoKzkBlZAfvlTCiZKBeon7MDSok60jJ535WtAaF/ZB?=
 =?us-ascii?Q?9+unzHAyVRZThYLG1DvbcWnp0lwNmOcSnIHPxJrdtgxUEggweSTaRo3n5rlU?=
 =?us-ascii?Q?K5F6etlCiwhdsqypRx807jTplOMD4oIkjaJhWW9LU95KRAQtZmjewSZEXgdg?=
 =?us-ascii?Q?iu91ezedvqqxr/1YCevLKm2wd5YODaRByTwFMst64rdpRosrpLsDUHqZ3AU1?=
 =?us-ascii?Q?I5TVi0HZ4mRWhOPRPNhGdjFwkjHPQgADu59iM9tvnXrXjp/hFKOWNKXqDjLM?=
 =?us-ascii?Q?jz7Pp9zmGsj1iS/eX9n9eRClSCkqlsssM/jhCikJ7w/oZFHfmAvAF1aVqIkz?=
 =?us-ascii?Q?EFMIHB8nup7kuj9IcxeAm8Uu/VFZV4hG9g+G0fKy+Cswy10axHMf/O0HkNM0?=
 =?us-ascii?Q?IoGRGLHN0wja0VuBbNRclrBNA7XaBFXvzTDd7Wom/cMqCiWjVPqzhPHHeaj4?=
 =?us-ascii?Q?8bQrNNUiy6Q6De6eBwkKcnzNdiNi2QN3iWuH1lhMn+lFCYNxaO7eK7bm5rz6?=
 =?us-ascii?Q?fwzsSncoPqWWxrwJn1ZmzJo2wk9Y3tn9PkXOOGpf+qWA10YgLeG+pIPwQkRV?=
 =?us-ascii?Q?SHvwvN4emPqBISGFtSAuZPp5Y1Gx0qXMM4CJyvhFToY8Rss56BZDvexya0vS?=
 =?us-ascii?Q?YfaPSIpEZQiKf5MOHBDuZRUwD/8ZhSA6gz9z50nR6RAgu0nAfLvfbRww+kGX?=
 =?us-ascii?Q?5o0u7qcpV0s3Q05jp9QwmnhAKbopoFLm3LBG0Y0BR1ZBEDq4wbW/VBHscfxw?=
 =?us-ascii?Q?GnZQUID508uhCP1/Oyh+S1KVPVX9dQlbZCKWZ7gZcOjAPRohTtVRO90S/TsS?=
 =?us-ascii?Q?jCo9dY8497OlEZT9CR1vWNJBIXSHnj/QLk+9EN4axDCuo4iEE74IlJeuuNpD?=
 =?us-ascii?Q?sS+2RIJkY+GCa/T8UCXokbPGHYy5eys3SGJnvXyCiEbPdYZvI3NXg1qwiEkP?=
 =?us-ascii?Q?WayuVszqu8cPSqIHl6uCMNBYGAZj1xGiz8DpoCJP2wcvz3EMzaAO488LpJ0C?=
 =?us-ascii?Q?44Lr2xnjsYyoWNnLUKse21qa/p7KH+WSlFzNKneifR0lSsAPW/Zg0niOwQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:29:35.0651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 351aca8d-6bab-4d14-6464-08dddba3932f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9618

The "mbm_event" counter assignment mode allows users to assign a hardware
counter to an RMID, event pair and monitor the bandwidth as long as it is
assigned.

Introduce a user-configurable option that determines if a counter will
automatically be assigned to an RMID, event pair when its associated
monitor group is created via mkdir. Accessible when mbm_event" counter
assignment mode is enabled.

Suggested-by: Peter Newman <peternewman@google.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v17: Added the check resctrl_arch_mbm_cntr_assign_enabled() in
     resctrl_mbm_assign_on_mkdir_show() and resctrl_mbm_assign_on_mkdir_write()
     to make it accessible when mbm_event mode is enabled.
     Added texts in resctrl.rst about the accessability.

v16: Fixed the return in resctrl_mbm_assign_on_mkdir_write().

v15: Fixed the static checker warning in resctrl_mbm_assign_on_mkdir_write() reported in
     https://lore.kernel.org/lkml/dd4a1021-b996-438e-941c-69dfcea5f22a@intel.com/

v14: Added rdtgroup_mutex in resctrl_mbm_assign_on_mkdir_show().
     Updated resctrl.rst for clarity.
     Fixed squashing of few previous changes.
     Added more code documentation.

v13: Added Suggested-by tag.
     Resolved conflicts caused by the recent FS/ARCH code restructure.
     The rdtgroup.c/monitor.c file has now been split between the FS and ARCH directories.

v12: New patch. Added after the discussion on the list.
     https://lore.kernel.org/lkml/CALPaoCh8siZKjL_3yvOYGL4cF_n_38KpUFgHVGbQ86nD+Q2_SA@mail.gmail.com/
---
 Documentation/filesystems/resctrl.rst | 20 ++++++++++
 fs/resctrl/internal.h                 |  6 +++
 fs/resctrl/monitor.c                  | 53 +++++++++++++++++++++++++++
 fs/resctrl/rdtgroup.c                 |  7 ++++
 include/linux/resctrl.h               |  3 ++
 5 files changed, 89 insertions(+)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 2e840ef26f68..1de815b3a07b 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -355,6 +355,26 @@ with the following files:
 	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
 	   local_reads,local_non_temporal_writes
 
+"mbm_assign_on_mkdir":
+	Exists when "mbm_event" counter assignment mode is supported. Accessible
+	only when "mbm_event" counter assignment mode is enabled.
+
+	Determines if a counter will automatically be assigned to an RMID, MBM event
+	pair when its associated monitor group is created via mkdir. Enabled by default
+	on boot, also when switched from "default" mode to "mbm_event" counter assignment
+	mode. Users can disable this capability by writing to the interface.
+
+	"0":
+		Auto assignment is disabled.
+	"1":
+		Auto assignment is enabled.
+
+	Example::
+
+	  # echo 0 > /sys/fs/resctrl/info/L3_MON/mbm_assign_on_mkdir
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_on_mkdir
+	  0
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 5956570d49fc..9be1e53a73d3 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -410,6 +410,12 @@ int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v
 ssize_t event_filter_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
 			   loff_t off);
 
+int resctrl_mbm_assign_on_mkdir_show(struct kernfs_open_file *of,
+				     struct seq_file *s, void *v);
+
+ssize_t resctrl_mbm_assign_on_mkdir_write(struct kernfs_open_file *of, char *buf,
+					  size_t nbytes, loff_t off);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 9201fedd2796..b3b4d3f44295 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1148,6 +1148,57 @@ ssize_t event_filter_write(struct kernfs_open_file *of, char *buf, size_t nbytes
 	return ret ?: nbytes;
 }
 
+int resctrl_mbm_assign_on_mkdir_show(struct kernfs_open_file *of, struct seq_file *s,
+				     void *v)
+{
+	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
+	int ret = 0;
+
+	mutex_lock(&rdtgroup_mutex);
+	rdt_last_cmd_clear();
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	seq_printf(s, "%u\n", r->mon.mbm_assign_on_mkdir);
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+
+	return ret;
+}
+
+ssize_t resctrl_mbm_assign_on_mkdir_write(struct kernfs_open_file *of, char *buf,
+					  size_t nbytes, loff_t off)
+{
+	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
+	bool value;
+	int ret;
+
+	ret = kstrtobool(buf, &value);
+	if (ret)
+		return ret;
+
+	mutex_lock(&rdtgroup_mutex);
+	rdt_last_cmd_clear();
+
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	r->mon.mbm_assign_on_mkdir = value;
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+
+	return ret ?: nbytes;
+}
+
 /*
  * rdtgroup_assign_cntr() - Assign/unassign the counter ID for the event, RMID
  * pair in the domain.
@@ -1464,6 +1515,8 @@ int resctrl_mon_resource_init(void)
 		resctrl_file_fflags_init("available_mbm_cntrs",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
+		resctrl_file_fflags_init("mbm_assign_on_mkdir", RFTYPE_MON_INFO |
+					 RFTYPE_RES_CACHE);
 	}
 
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 8187df7b85d2..ced46eb4a959 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1808,6 +1808,13 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdt_last_cmd_status_show,
 		.fflags		= RFTYPE_TOP_INFO,
 	},
+	{
+		.name		= "mbm_assign_on_mkdir",
+		.mode		= 0644,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= resctrl_mbm_assign_on_mkdir_show,
+		.write		= resctrl_mbm_assign_on_mkdir_write,
+	},
 	{
 		.name		= "num_closids",
 		.mode		= 0444,
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 04152654827d..a7d92718b653 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -277,12 +277,15 @@ enum resctrl_schema_fmt {
  *			monitoring events can be configured.
  * @num_mbm_cntrs:	Number of assignable counters.
  * @mbm_cntr_assignable:Is system capable of supporting counter assignment?
+ * @mbm_assign_on_mkdir:True if counters should automatically be assigned to MBM
+ *			events of monitor groups created via mkdir.
  */
 struct resctrl_mon {
 	int			num_rmid;
 	unsigned int		mbm_cfg_mask;
 	int			num_mbm_cntrs;
 	bool			mbm_cntr_assignable;
+	bool			mbm_assign_on_mkdir;
 };
 
 /**
-- 
2.34.1


