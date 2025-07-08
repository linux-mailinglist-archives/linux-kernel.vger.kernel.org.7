Return-Path: <linux-kernel+bounces-722467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3927CAFDB05
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0C7587D0C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475BC26980F;
	Tue,  8 Jul 2025 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MZrWzuEN"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D05F26B951;
	Tue,  8 Jul 2025 22:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013338; cv=fail; b=OnS5cLHt9Qh6r0T0m2vyAIUFMv48tsT0z2T554nEqf7qDe1dkWwrZWiHXgfp29JSWtnjhsqCdXPVJukBvnofD9QmXizy/okJewN1mEOZ6nUQmskl9gm94FFJsfTa6T78+McoTfuL8mRfzVGHXpFwEDNYEttAcmZrTOWT+RtKvX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013338; c=relaxed/simple;
	bh=S2Z0ncVLKHW77gqCIkvdUpvaSmp349uNz6eB19MpR3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ia8Dg8WmxjN/JglLwNwNAgZEHsMIsnNhFnZqdSBOVydLI7m03i3/Q3XVuBAGNPLe1NkcXhl01uwmOz0cBdQvV+7MVpK8Gvdv4DaI7zJmgRr4q0bVMo+mbSWMtWoO+aiBata4mjIgZtiSGKhGkKvpUXdYDLAMmSLAgpovb0YfXQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MZrWzuEN; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ergt9Pn4mviCBfzTIl3DYhwb1qilOfFrXcH+rQkrs3RGR1DOFgClqJ3zZU0DsWflLzVmhgomnA2i+7Nqb0luBdgbhhCD2vM3jd0BsTobGBbW2A7EKK0GAF9xys0RhjHthBwH/+B8ak5Q8KTOCC7QiAc0scwlWlpTigdQ5F9UtYIGjGlNa8WE9UfT3k6+rl4byEcwFvZIgFJpbWzkggh9B97UzqJ3ORrD26Z9VxMokATgwbUe0WXpmrTj26o0/0DpzFUN9qtfDfPWFTVDTFi0eN/4XRsq/HqudZotKGMhhZ5HCZ23Vmz7ONdI2v9g69PRCarfchYmoUU4BkpQ1P+Ntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=impXuusJNxOMx1qvn3wz6MoeQaVQ2Zw3eCylXc+xMSY=;
 b=SCcmNwtCmmEy74Oe9JCQeFFIpTy00rdO+DiOW3KZc77LIcwiYoaSC1np2933p+VvvhVfa1ADXjr0U0nhk04Vr1OcSFVsGNcLrFgcgQSWRJamW6Djsvgtj9/bR10sPIBmPJ50a4w6b+N0ehSDN+3f8hiIk2lmKAuuodXLK2KNDGvODE/A5Id8wh5tU8MzC/DkOMMFkjGNxzGjjhp4Cak0lbqh0nZhKh7E7ihnzqtwHBxh5SU6ETSgS86S9pop2g03KUYHnkdf+CBPH/V/wGeSMHb6RkDSDX8J04NxIvO8xwSUP23XsoTHYD/6ZksylZuZ0McDcsxHweEDx11Zazs5hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=impXuusJNxOMx1qvn3wz6MoeQaVQ2Zw3eCylXc+xMSY=;
 b=MZrWzuENPBdAtJJy5lAw6k0ydASiIByN+PVaXp/kW/ID5gMiyeotOQFRl4lzrV8rUJzm04c2zWbSUgVxw9GPa23OlFfVeDV8Fo0J7XmxTB7L+sXqMPspRdzjandHEMOs/0FBeq5KVieFylxTuz6EDqTRFMBokz5Vxtt6S5qcKLY=
Received: from BN9PR03CA0867.namprd03.prod.outlook.com (2603:10b6:408:13d::32)
 by CY5PR12MB6225.namprd12.prod.outlook.com (2603:10b6:930:23::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Tue, 8 Jul
 2025 22:21:47 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:13d:cafe::b0) by BN9PR03CA0867.outlook.office365.com
 (2603:10b6:408:13d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.32 via Frontend Transport; Tue,
 8 Jul 2025 22:21:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Tue, 8 Jul 2025 22:21:46 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:21:44 -0500
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
Subject: [PATCH v15 26/34] fs/resctrl: Add event configuration directory under info/L3_MON/
Date: Tue, 8 Jul 2025 17:17:35 -0500
Message-ID: <0fda2f958001dec07827f803f0e31158a2b77a8f.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|CY5PR12MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: cb95c618-7180-47df-c32e-08ddbe6dd39b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6bFlZa8T1XY3jevBzHDbkaabqxWskqG8xNIu/nuSpM8GDtaYoDrLIXltPnzP?=
 =?us-ascii?Q?vqnVYPuVaN6AaZPz3wB1UyZ3OLD5FRhLuqEKBqfC9ZJ656agSG2Q5EzNHAob?=
 =?us-ascii?Q?SZbxHX5j/6XpKZWurByYeBmRxwutI8/Zkn1YjWQUd5gH9zRFRMvIygoKd9Ty?=
 =?us-ascii?Q?8GdFdXs4TyR5OJ8OoMINnKS1GySwjQoCYgq2QMDW6vBfR+Th78X8cCz+/xbY?=
 =?us-ascii?Q?SF5UPhOta//Ccw13O7ImCWSXmBSkWwqTlk8lzhXkKCxOY/L5KIvUSiyBVus8?=
 =?us-ascii?Q?5rstm6K9scK+GZHDWj857nyc4cV0txKWUMlltCoygzF5pMtFaeiLirXBx2A7?=
 =?us-ascii?Q?4WrXUVrAGYWQkizZ6ZdLKwdzwxV0oLToFLw4FzMOFRB98MjJimFgx4EzDdRf?=
 =?us-ascii?Q?aFyygputlDZOLwAoOsmTy+Dq70wozLPpcwQ+aRDTxRPrDl0ZOleYM3tjaT+q?=
 =?us-ascii?Q?DGrcWJL6WC7mb/EpYAzNKsalh8N6o6lnma/3/MwNvGRZ4ypQSX4i7SdaO40t?=
 =?us-ascii?Q?ikGwqgU/KRq1BwjRazc2h2awUFeygejHYkpPckvuS1fSu1kf3mMq8xTwrmPE?=
 =?us-ascii?Q?qSrWoPWr7edv5tCYAlkyXaJnol/c/7rZeGecUOToi9XobPgI4TFOGvg/durZ?=
 =?us-ascii?Q?H9pv/KivW5wJ3P/mz7bl+pQZRY6ZWMFnUaBJsaiGEMAGura6MpGNbZe1uO2S?=
 =?us-ascii?Q?oEy9l3OiwRKEqPbJYPdidIc1L3QDDybKDJQhfppBlGqVISU+jjtGDFM/w9a2?=
 =?us-ascii?Q?zVMg3BuzY3AjNgQwMnAjb2rLfA8aXZ55RzybbsqNktUBwka6LTT2foX1itQj?=
 =?us-ascii?Q?T4pH64GdQ2TGxcMAINX5+pVuWdq0s40c5n0L8h4OSg7UIJv50onTc89PXzFq?=
 =?us-ascii?Q?JIqMnvJmyGkN1YK1Bqr8YmTyOj0hhWxncVXqAQWXfNA+XnoTTUWDrOVZrq8x?=
 =?us-ascii?Q?frUW8ChWG8of8IownVE7xaoOfA9BPPwWLsxdglekMsH2gcCbVylizxbzx+sZ?=
 =?us-ascii?Q?kshpK4lVNsZSOa444uIvnhYV/arUeVhJQ4thuL06gs0LWh7Vn4QKHvCwUfFU?=
 =?us-ascii?Q?OWyDGnj0gcc1w4PqNiNcVckKBecI7Wwzj6MrC3HwuOjVvK+QjGOoQI6QVvUt?=
 =?us-ascii?Q?P4z75XtdW7AdceYndZ21klHM125XeHaMeVm/NpxlsqDtZ0px9sdW6QStcPJt?=
 =?us-ascii?Q?Ss73Hk7DBRCh9CkgbKZDuBgh+G759vnQkH6zawylalMZ6kR3B2fY0/rgx0Im?=
 =?us-ascii?Q?D/bjaACQaRsaDGOf+VI4X6EtG8beyHVgU62fcP0OMPT5AEomJMj2ySMpeHaH?=
 =?us-ascii?Q?qj1yJ5h7wubfoevRjUSnvHpEe0xwnmZRURsW9PyqvnnhXDyExXxKFp4aSqLd?=
 =?us-ascii?Q?TWaqWxf2Aq1FPGVbA2f9YtdQH5YRSsSxvlWO+DG7lNdzIT/N/YUGY4bY5mjp?=
 =?us-ascii?Q?OfcYWZ6aaDV7GrUSkMw5OzOPUbCr8M5cPJ5W4PB3PjxUkTmN4HNGIzXcEb/F?=
 =?us-ascii?Q?2afRXx872EDoBgDJ2wrWO9sGd/n9jYXkii9v?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:21:46.6967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb95c618-7180-47df-c32e-08ddbe6dd39b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6225

When "mbm_event" counter assignment mode is supported the
/sys/fs/resctrl/info/L3_MON/event_configs directory contains a
sub-directory for each MBM event that can be assigned to a counter.
The MBM event sub-directory contains a file named "event_filter" that
is used to view and modify which memory transactions the MBM event is
configured with.

Create /sys/fs/resctrl/info/L3_MON/event_configs directory on resctrl
mount and pre-populate it with directories for the two existing MBM events:
mbm_total_bytes and mbm_local_bytes. Create the "event_filter" file within
each MBM event directory with the needed *show() that displays the memory
transactions with which the MBM event is configured.

Example:
$ mount -t resctrl resctrl /sys/fs/resctrl
$ cd /sys/fs/resctrl/
$ cat info/L3_MON/event_configs/mbm_total_bytes/event_filter
  local_reads,remote_reads,local_non_temporal_writes,
  remote_non_temporal_writes,local_reads_slow_memory,
  remote_reads_slow_memory,dirty_victim_writes_all

$ cat info/L3_MON/event_configs/mbm_local_bytes/event_filter
  local_reads,local_non_temporal_writes,local_reads_slow_memory

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v15: Fixed the event_filter display with proper spacing.
     Updated the changelog.
     Changed the function name resctrl_mkdir_counter_configs() to
     resctrl_mkdir_event_configs().
     Called resctrl_mkdir_event_configs from rdtgroup_mkdir_info_resdir().
     It avoids the call kernfs_find_and_get() to get the node for info directory.
     Used for_each_mon_event() where applicable.


v14: Updated the changelog with context. Thanks to Reinette.
     Changed the name of directory to event_configs from counter_config.
     Updated user doc about the memory transactions supported by assignment.
     Removed mbm_mode from struct mon_evt. Not required anymore.

v13: Updated user doc (resctrl.rst).
     Changed the name of the function resctrl_mkdir_info_configs to
     resctrl_mkdir_counter_configs().
     Replaced seq_puts() with seq_putc() where applicable.
     Removed RFTYPE_MON_CONFIG definition. Not required.
     Changed the name of the flag RFTYPE_CONFIG to RFTYPE_ASSIGN_CONFIG.
     Reinette suggested RFTYPE_MBM_EVENT_CONFIG but RFTYPE_ASSIGN_CONFIG
     seemed shorter and pricise.
     The configuration is created using evt_list.
     Resolved conflicts caused by the recent FS/ARCH code restructure.
     The monitor.c/rdtgroup.c files have been split between the FS and ARCH directories.

v12: New patch to hold the MBM event configurations for mbm_cntr_assign mode.
---
 Documentation/filesystems/resctrl.rst | 32 +++++++++++
 fs/resctrl/internal.h                 |  2 +
 fs/resctrl/monitor.c                  |  1 +
 fs/resctrl/rdtgroup.c                 | 77 +++++++++++++++++++++++++++
 4 files changed, 112 insertions(+)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 4f5eb5bbd4b5..57fd12f0aeca 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -310,6 +310,38 @@ with the following files:
 	  # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
 	  0=30;1=30
 
+"event_configs":
+	Directory that exists when "mbm_event" counter assignment mode is supported.
+	Contains sub-directory for each MBM event that can be assigned to a counter.
+
+	Two MBM events are supported by default: mbm_local_bytes and mbm_total_bytes.
+	Each MBM event's sub-directory contains a file named "event_filter" that is
+	used to view and modify which memory transactions the MBM event is configured
+	with.
+
+	List of memory transaction types supported:
+
+	==========================  ========================================================
+	Name			    Description
+	==========================  ========================================================
+	dirty_victim_writes_all     Dirty Victims from the QOS domain to all types of memory
+	remote_reads_slow_memory    Reads to slow memory in the non-local NUMA domain
+	local_reads_slow_memory     Reads to slow memory in the local NUMA domain
+	remote_non_temporal_writes  Non-temporal writes to non-local NUMA domain
+	local_non_temporal_writes   Non-temporal writes to local NUMA domain
+	remote_reads                Reads to memory in the non-local NUMA domain
+	local_reads                 Reads to memory in the local NUMA domain
+	==========================  ========================================================
+
+	For example::
+
+	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
+	  local_reads,remote_reads,local_non_temporal_writes,remote_non_temporal_writes,
+	  local_reads_slow_memory,remote_reads_slow_memory,dirty_victim_writes_all
+
+	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
+	  local_reads,local_non_temporal_writes,local_reads_slow_memory
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 63526400e632..b107874407b2 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -252,6 +252,8 @@ struct mbm_transaction {
 
 #define RFTYPE_DEBUG			BIT(10)
 
+#define RFTYPE_ASSIGN_CONFIG		BIT(11)
+
 #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
 
 #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 1670163649e7..787dce934903 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -983,6 +983,7 @@ int resctrl_mon_resource_init(void)
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		resctrl_file_fflags_init("available_mbm_cntrs",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
+		resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
 	}
 
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 15d10c346307..bb28ef7e4600 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -86,6 +86,8 @@ enum resctrl_event_id mba_mbps_default_event;
 
 static bool resctrl_debug;
 
+extern struct mbm_transaction mbm_transactions[NUM_MBM_TRANSACTIONS];
+
 void rdt_last_cmd_clear(void)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
@@ -1895,6 +1897,25 @@ static int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+static int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
+{
+	struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
+	bool sep = false;
+	int i;
+
+	for (i = 0; i < NUM_MBM_TRANSACTIONS; i++) {
+		if (mevt->evt_cfg & mbm_transactions[i].val) {
+			if (sep)
+				seq_putc(seq, ',');
+			seq_printf(seq, "%s", mbm_transactions[i].name);
+			sep = true;
+		}
+	}
+	seq_putc(seq, '\n');
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -2019,6 +2040,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= mbm_local_bytes_config_show,
 		.write		= mbm_local_bytes_config_write,
 	},
+	{
+		.name		= "event_filter",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= event_filter_show,
+	},
 	{
 		.name		= "mbm_assign_mode",
 		.mode		= 0444,
@@ -2279,10 +2306,48 @@ int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
 	return ret;
 }
 
+static int resctrl_mkdir_event_configs(struct rdt_resource *r, struct kernfs_node *l3_mon_kn)
+{
+	struct kernfs_node *kn_subdir, *kn_subdir2;
+	struct mon_evt *mevt;
+	int ret;
+
+	kn_subdir = kernfs_create_dir(l3_mon_kn, "event_configs", l3_mon_kn->mode, NULL);
+	if (IS_ERR(kn_subdir))
+		return PTR_ERR(kn_subdir);
+
+	ret = rdtgroup_kn_set_ugid(kn_subdir);
+	if (ret)
+		return ret;
+
+	for_each_mon_event(mevt) {
+		if (mevt->rid != r->rid || !mevt->enabled || !resctrl_is_mbm_event(mevt->evtid))
+			continue;
+
+		kn_subdir2 = kernfs_create_dir(kn_subdir, mevt->name, kn_subdir->mode, mevt);
+		if (IS_ERR(kn_subdir2)) {
+			ret = PTR_ERR(kn_subdir2);
+			goto out_config;
+		}
+
+		ret = rdtgroup_kn_set_ugid(kn_subdir2);
+		if (ret)
+			goto out_config;
+
+		ret = rdtgroup_add_files(kn_subdir2, RFTYPE_ASSIGN_CONFIG);
+		if (ret)
+			break;
+	}
+
+out_config:
+	return ret;
+}
+
 static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
 				      unsigned long fflags)
 {
 	struct kernfs_node *kn_subdir;
+	struct rdt_resource *r;
 	int ret;
 
 	kn_subdir = kernfs_create_dir(kn_info, name,
@@ -2295,6 +2360,18 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
 		return ret;
 
 	ret = rdtgroup_add_files(kn_subdir, fflags);
+	if (ret)
+		return ret;
+
+	if ((fflags & RFTYPE_MON_INFO) == RFTYPE_MON_INFO) {
+		r = priv;
+		if (r->mon.mbm_cntr_assignable) {
+			ret = resctrl_mkdir_event_configs(r, kn_subdir);
+			if (ret)
+				return ret;
+		}
+	}
+
 	if (!ret)
 		kernfs_activate(kn_subdir);
 
-- 
2.34.1


