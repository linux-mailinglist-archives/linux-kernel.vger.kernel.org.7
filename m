Return-Path: <linux-kernel+bounces-746191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E463DB12411
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537231CC593B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4C625A65A;
	Fri, 25 Jul 2025 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WJR0vq56"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B81B25179A;
	Fri, 25 Jul 2025 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468499; cv=fail; b=X2MDcYa2v5wZ3eOU8S5GlsUzfDXz0U+GKM3PysgdlU1fBgvJWFcfOqLBGOLXQP7B3+7dfWEo+mVevPndZQ0pvK3kIR7G8AgKKJkznkpancBdu3xmQT2tQLAHA4G1NBMj0MKrZxSyQTriO7Kq4kWDGJh555tuOfB+f3LfFAK3PQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468499; c=relaxed/simple;
	bh=lQAV6E6a0QXwHOP10eGcUnkjT6wZ+Tcw8KN8WMwG5Is=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULeHZbt8c/XI637XBvgcrT0y8QCSQOGBKj5befC83vSTDD3khsZkMaxs9psJkix1X7b99YUaOI0OdDUs4ZHXCw1xR428Tlcx+U8c4ZeBj5FsVbh+oX9sBBUrS3n2U44lcHXtN1vU7LZf2J06ZpEv0asZmWwLt33nO+HnfikDZP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WJR0vq56; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cz1DXMmEDqxgfm5kUjAEtieTWJeIObNpmOOxEEzdBeWDdM1AJo0CFTsnSzDkCWxwdxJTvHWHssUtAorZKP+GYmzJAU1o8sQXFK1/LKymMeXnE4JLEWI0w5B4d7X5/cwcxyzOKHJ+F8xO0ULaUpAZ431R6adynLv6LZYvRPO26ALAfgTA+1rgTqsEypgyeMm3wo81Wpp5HUEsHoAv88QTAgsSANoNzwz5rQL7HCZeMGrZhkJZybOm2uJTtpZZH8h9SOdkMLqRxz2wrJzqDqElNvdxq4iKXnyVB2585CCao5VBn6V8pnZrdbZhgsxMKSQqXOoTUMDIFx1+2YmZIOeigA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kdx9KfBEOc8eyORCXiD9/gaay6nKqUevzU17YxS3FrI=;
 b=zPyAmEqcGMWJHNVMEVNxqfc2G8iuVELyKJotgPCLeVrmTCticYN+Zs6TSgUlS/dRgl73v6eTl/Yyf0DXzM4jYoHcwHger1AiHJxTVmINLwRwC/j4k7hLhpXXXkOMUMt4+zhuWAHevGEBa+HZUjAVbjctPoiLNb8jDDFR1qcxU/UWa9XojYZpcixuvYvMwLUWEfVa97uKu9pWPcBCUKBMolO3t0vyV+BZaPUWJuax3HoxRM4Z9stGjAtRdsPlNqSYcCUx0cX0deny1rgiyndxy2DnTIqqK0t5CfV78eoliD/Ky9HDm+7JDxCl9NsKkhYuMjyxvjBmqMZoVbg0itj7GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kdx9KfBEOc8eyORCXiD9/gaay6nKqUevzU17YxS3FrI=;
 b=WJR0vq56OF48vPpOl/oN6QR4FPNrHcKo2Xt148UUQ9vUbLMKEDirpqzpMrBmUebcj0XuRrKMOLMR5FwP7RRrJzOAfjg5N6xggkglD3ZMFxRX/IvLmYhkuICf5fX+tqf+ChN3R0cBwur6aYmWEKSDLKaeX4F+EW6/haBwkzEMmEo=
Received: from DM6PR08CA0028.namprd08.prod.outlook.com (2603:10b6:5:80::41) by
 DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.35; Fri, 25 Jul 2025 18:34:53 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::6c) by DM6PR08CA0028.outlook.office365.com
 (2603:10b6:5:80::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 18:34:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:34:52 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:34:50 -0500
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
Subject: [PATCH v16 27/34] fs/resctrl: Introduce mbm_assign_on_mkdir to enable assignments on mkdir
Date: Fri, 25 Jul 2025 13:29:46 -0500
Message-ID: <dd92bf598bf7c922b212100ea668f3241f6417c0.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DM4PR12MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f12175-c080-4852-15e2-08ddcba9f1f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lWrJK5kFpR7Lw+Fheeh0go9Vb1TaXiDhl0W1oJr9ILCwWuK1XIn9m2dOt6NB?=
 =?us-ascii?Q?68VavJS3Vwcbv3KAJu2XjScz0P3B9TaSZhApkSgHkm2xgBYX7cesRHFJgk5j?=
 =?us-ascii?Q?ZNCEDytP1LLBd1iZqJEa+AMOeY4WSY3BPdgQnJZF5musD72RzTinx12UKxgb?=
 =?us-ascii?Q?pJYhTaKn6MVg1UW6XRgwI/3RWgIpf1g+Cqt/NI3Gp5uWwfJ6D+fRFu+q5ogH?=
 =?us-ascii?Q?c53FmJLsbmyQ1flBN0BUF5sCENEkjlV0j++SlQEQByCLPpNfAQStuIcssaTd?=
 =?us-ascii?Q?YmcAbIBwxHJlSNUsiu80fWWy1q8C4G3ahAlAw61CPIRFUbrt9Y1ZVBQcbhZ7?=
 =?us-ascii?Q?3ZKGHWnrV+WtQ5JUYTGODF9DnczZiPoPqr9CMru4gHNxM8nY5PSfubM8LW9X?=
 =?us-ascii?Q?eJWUhHpO+kUR4uZKzfidCfN1tRuRWDx1fsXkltULAkzyoAouX0bsEm9Q/jBo?=
 =?us-ascii?Q?0AlXNvgEfFHHBuAnVO0d8dTrKkZoh7Cu7Y+AkzTYUXdMveplOQbmMlITa3jj?=
 =?us-ascii?Q?j5TuZJtAC1UWh7XK7aa4j9i8qAd4tEe1kEIjGoiDn98bYIh+FC+j2cDZWK/+?=
 =?us-ascii?Q?nwOSsQ/SFlaYoO4b/hmFb8s6DwerCUsxP75A2AVcan8Rx+d87sW9fFUkxVIM?=
 =?us-ascii?Q?edwROm+kNItVWzENJwJ7s583JZJs3Bc7qbB+Jhs+ihXbFFgDP2hsC/zx6y7p?=
 =?us-ascii?Q?k+zHv6a0oElKeki9Voiudxb3Yajd2YW9UGL9X2OCF7fiKDRIeZWHG5pmw8fO?=
 =?us-ascii?Q?7P2xh9O2r2XkffkgYq0/Eu4gSvRtvmhxgGZFrx5bymYYco9wYF+x5NsH99A+?=
 =?us-ascii?Q?C7gJEC2DxoBycTYC8t+8YwaM68ZX8H9rmmoyv6ybbiOXhByiAHlYTYEBErc7?=
 =?us-ascii?Q?ymhvkEh03jjVn8pRMlUAOwstEhF9Me/AhM0HJN3VRLZYbcnviEjKbXg8rN3Q?=
 =?us-ascii?Q?kFpAgADaekb3YhXXfVIcH74wo7eX1rOHJgfYgzMO2T3i2rxWqNhwaAUr4LPs?=
 =?us-ascii?Q?Ep/51p8M1hhuLahYIkV/0lKZ4Mw+OYzOqO393TF6ZNBTwfymp+xN7zJK37F9?=
 =?us-ascii?Q?n4v0TLZRJV3j8DrJpRDPygn5xf6EAoAuqJBVEP/k6ynXcB4cJDInV3a6sMTP?=
 =?us-ascii?Q?O5Y5BQ0iZZq1PY9RRrfO2KKmzgff5VDhVEktVdXtZRqeXurlHWRSf3/yYwYw?=
 =?us-ascii?Q?pGlVODi1sTiLBUFq54hTeMJ1Xs4ChQMd+tJ8lwXI3gXArf4pEBP+uOATEkVA?=
 =?us-ascii?Q?2jCeQ6oB8uBwZOLzFc69pJMG3HYNpwlGcGA8sYRiI1EHdH3oVC82k+4HafQn?=
 =?us-ascii?Q?mUvJHIWvI11njAREb9rR9vidmRUI73u3bMDl8dAtNS2QOyDdZORezs+KgJsM?=
 =?us-ascii?Q?HyzS0yRvSIH53100T5VB6LeTEg/iMCtnFymmt0JDcijS7CWW1hW3XUt46YDn?=
 =?us-ascii?Q?EcGz3k35ieHm9WWcxeMn+aU2yjYI/TalXR616iJNULVUdCLlMuLGmUBXjSF5?=
 =?us-ascii?Q?hOG/Kv3kXufyq5wwoIuCLMidlEMOZ2VsNTDC2cilVULc0SlLUtutjlh24g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:34:52.4550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f12175-c080-4852-15e2-08ddcba9f1f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135

The "mbm_event" counter assignment mode allows users to assign a hardware
counter to an RMID, event pair and monitor the bandwidth as long as it is
assigned.

Introduce a user-configurable option that determines if a counter will
automatically be assigned to an RMID, event pair when its associated
monitor group is created via mkdir.

Suggested-by: Peter Newman <peternewman@google.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
 Documentation/filesystems/resctrl.rst | 16 ++++++++++
 fs/resctrl/monitor.c                  |  2 ++
 fs/resctrl/rdtgroup.c                 | 43 +++++++++++++++++++++++++++
 include/linux/resctrl.h               |  3 ++
 4 files changed, 64 insertions(+)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 37dbad4d50f7..165e0d315af7 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -354,6 +354,22 @@ with the following files:
 	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
 	   local_reads,local_non_temporal_writes
 
+"mbm_assign_on_mkdir":
+	Determines if a counter will automatically be assigned to an RMID, event pair
+	when its associated monitor group is created via mkdir. It is enabled by default
+	on boot and users can disable by writing to the interface.
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
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 8efbeb910f77..6205bbfe08fb 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1077,6 +1077,8 @@ int resctrl_mon_resource_init(void)
 		resctrl_file_fflags_init("available_mbm_cntrs",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
+		resctrl_file_fflags_init("mbm_assign_on_mkdir", RFTYPE_MON_INFO |
+					 RFTYPE_RES_CACHE);
 	}
 
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index c3d6540c3280..bf04235d2603 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1895,6 +1895,42 @@ static int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+static int resctrl_mbm_assign_on_mkdir_show(struct kernfs_open_file *of,
+					    struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
+
+	mutex_lock(&rdtgroup_mutex);
+	rdt_last_cmd_clear();
+
+	seq_printf(s, "%u\n", r->mon.mbm_assign_on_mkdir);
+
+	mutex_unlock(&rdtgroup_mutex);
+
+	return 0;
+}
+
+static ssize_t resctrl_mbm_assign_on_mkdir_write(struct kernfs_open_file *of,
+						 char *buf, size_t nbytes, loff_t off)
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
+	r->mon.mbm_assign_on_mkdir = value;
+
+	mutex_unlock(&rdtgroup_mutex);
+
+	return nbytes;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -1904,6 +1940,13 @@ static struct rftype res_common_files[] = {
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
index 4d37827121a6..632b9ee5466a 100644
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


