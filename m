Return-Path: <linux-kernel+bounces-746187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F632B12403
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6231C215E4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81384248F4F;
	Fri, 25 Jul 2025 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vQ0mgVQD"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057262475C3;
	Fri, 25 Jul 2025 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468466; cv=fail; b=CDxgf9NwKa5uh1BQZxmT+Wr32d1sQrGAH9Z73Q3TPHcVEDsQTrV3xIUz/qzVu4i1HgldkoPkDUujRBRWO/9ctHTmEFnPKjbByNaSXEYI4XXTZaIiFgh6t3fo8k0x//Z7lbNq63cnln7dwbm7Vlw5pQiHXeBSS1rbRHBHm6aY/TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468466; c=relaxed/simple;
	bh=4daUxC5prdWDTO85pRWeUgmcbkA3pj4kWFSrQtgbZQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4pgbreCRiJ5tyQi77EM8oPN+TNevvOuDp5l12IkisWZXR3h954OUUrHsL1oq+6i4EFZNZ1N5QIpGbDOeTGSuyQyq/9Yit/B1i87CZmTJ2G/TewJ7OlgXgOAikhgjrL5PVZZ+j/mWx8qFRTO3jw5BxM6VT/CDS6t1bSSOzO1seQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vQ0mgVQD; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPQHpn1hMrgPvoNwTgxnt73beh5VTc3GXdPj0TtI9RpjyKoPrHkt7EhhkacsaO2g22T6Jjsw62OsqGIb7Nxp4xoBOojPx0cN/7iyqeA0RWWJv4c0h2cjj1592C+tHTdtRrs15MZwh2W03GpqUJ5cAwd4FMMSlvK8eUs3QjO074T3VbmKdXnfP/Tbsxy9hTFbh/W0xaiGyRZPPONCo+HZSQTAawWARwoTNG98B/pDivEQZ4FFDkf7vLCvtVlz/Tkx5789/Y5C5sv7rtoAy6zPXzhL5OOm1OwmobDNa8LsNw7FSKOYpZnIqz203GlhKBFR2kXxzS8SVOx+KVisMC/Qgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kLIJ3Dw4ZZIuO/62Z5YgZbbkFQ35KQhTrRj2Q6Bu04=;
 b=nqFyBM9QbgMCihoHAU1faXIFSjUH3LETKSu5UWIUXPIaafZnpEQuRuhJz9lCn7KiH08E39llprTuj6LDQnEUEBEbcwrVA0p2QqaGhLZe6k5a0IU5fMFw2VOJfg3OUu7HV7bx8++vMPYMp167TqwVKDuuqBcnP6vrj3C5aUUKDQcSHL2piKrEzaWlBKgdNr6DERrj3p7KheqdFMQQLyyglf7GdJE/q+YysDz51c/Tet8dY8pHHElMH9S/xEVvz/LCVK9Qlw3OaqpC1/jkBh/z9Jf7g7gtO29AJbE7aBgFYzqjyTyTfv8ok12b7TnYosAzTZmZCPu2s/AfTlZv5couaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kLIJ3Dw4ZZIuO/62Z5YgZbbkFQ35KQhTrRj2Q6Bu04=;
 b=vQ0mgVQDaIQhz0+CKKlCXUoAdSyKot8DrOIZIH5JHfuAbU5Ns89UIlWUFdWIygxNadGscV1603eYNtgmcZE9rrQxrhYqteQ8v2wFHbbpTNDTDOX7HDDv4IizWNnUlcwdwSJFZRgtgwUj0F7HXIM7XyPqvKzb0fy+RreEu2/D9tQ=
Received: from BYAPR11CA0098.namprd11.prod.outlook.com (2603:10b6:a03:f4::39)
 by BL3PR12MB6404.namprd12.prod.outlook.com (2603:10b6:208:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 18:34:21 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::47) by BYAPR11CA0098.outlook.office365.com
 (2603:10b6:a03:f4::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 18:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:34:21 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:34:18 -0500
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
Subject: [PATCH v16 24/34] fs/resctrl: Add definitions for MBM event configuration
Date: Fri, 25 Jul 2025 13:29:43 -0500
Message-ID: <b32329e151c841f2b93987edf72ef39d2cde9191.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|BL3PR12MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: faea36c7-d5b7-4710-b837-08ddcba9df6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M2U/4Uu35MnUmjGgKIcPBK82mRSMzAydKN6GyGYOmjbHX1YAYKwAgtRn0u2k?=
 =?us-ascii?Q?cWKpuVpLz4hkcWf6NLB0AbK7+gJyCd/sSgpV9ryzK88uhsC5ewKrgvXpW4vy?=
 =?us-ascii?Q?zTmkA4Hc9fLnCAVTQQ1zdKSQzHtBpKS30a8rwpG50NC+5gArSqwOmojqtYEx?=
 =?us-ascii?Q?Fzhy8vFrqWjWiWKqhNVsX7zr56TPOuGdy0G02dZeERuBird3+CtZJFknnXiq?=
 =?us-ascii?Q?NN7xrmGONGvPwWAjsUbZv707PVdl4/K5ndIohhtqzNEfQLeP6wkboc0WagRg?=
 =?us-ascii?Q?fqda7AfDlz0S92oZjN4k13ofWSO5UaxH8ySTNT5ESXJK3B9vzk3qkOku0M2N?=
 =?us-ascii?Q?GJ0x7hyoo3BMG7pXd81amBWbQZuFcOgczaeITPCqjtdo+DfHjb23kG3gVFnI?=
 =?us-ascii?Q?Asvr9GG6RusR/w5JhzXadW3tItgBaUwi3wOQYcGaogNsPMdyJd3mQ8c66InN?=
 =?us-ascii?Q?FUblFP89AD2VR0jPpq89ZGAUEySte/PRO8rKf2VlEDyPxgiggx3Bv6DvCMZy?=
 =?us-ascii?Q?Kfo2AZzcOLizkmFVCbNCppbLRqPipbNPUi/krb3sUZWw6LutYB1b5dWMkKDQ?=
 =?us-ascii?Q?WpwvoL58bndJycfHWnT0r5oeeIchZSazQslvZBBWcPGWNKHEx5lTNRpWWnpd?=
 =?us-ascii?Q?Va76f1oaOjEi/fasftEIKWSLhdqpxRf1C/ZJWk7ntUfx3RFDSUisikxkWY1Z?=
 =?us-ascii?Q?WHNNhLjnCZP8R+rsfupGjKtbKDHud38q3s/KpaKHI4xzk7G0Kt6prlAbRkW0?=
 =?us-ascii?Q?Gq5+SuRWwYc1LPO87L3jAIbVEXuFaXkMz7oAUZAX3lWJ86CvnYFVUP14MEmm?=
 =?us-ascii?Q?Dccui0d1+iKu6lis1md8Kx0HsSYej2GJsZumQyo4neFvhYKZ0sAT7up8tKAh?=
 =?us-ascii?Q?ags7tZCuxsbG2LrwFrTotFIfL5KuxcHi8fIczwq5BWct9EBvjgQwwsrRLEMM?=
 =?us-ascii?Q?cozyf0Wd+DvBSmxekxpJxJkvMTKEtqfzOmTumo2+ZVKCl/wvIcqEhfq+cZES?=
 =?us-ascii?Q?ee6ssP5lm00nogZLZN47kVa25gAm1wkg9v/Dww5xLjVKAouz9jlVmBhNMqXQ?=
 =?us-ascii?Q?BnhWQcw7uxbIRQUBtPtw/Lu/nqP/mxkadpPS0MJxNfGa2EOxJDq3b2fOnoQj?=
 =?us-ascii?Q?ZkNKGH+NQbhwwas5dbuIq4Eq8R2UlQMOGmO0geq9HTLF++o+EdYqrxJWFOH2?=
 =?us-ascii?Q?f/ESjFv/rzIbe90XOZbZu+YMcSjZWJb9oeinSLrMBe7KTRULZMBVW1F/A37U?=
 =?us-ascii?Q?TnIGplYBukpH1P+JtzXXQy+n+yOstAJi/1psm1XphGREQgib0roooqPxQ5c8?=
 =?us-ascii?Q?0IK4LbRnHHdCeDr3C5oezF9R56oqHZyJ4977feqtmgX9uTuSK8Po8ntRJGcS?=
 =?us-ascii?Q?fwqES5MHDvPR3F/tsR+Q6c+GXzT6gcJwQAbrATHejcVdqMTdrowv7JSwm3GZ?=
 =?us-ascii?Q?wgNrgnHXZG4tBSB1EE2gm233EEEUECe6Sim+uGvOVDKlgQbH5H7P3LGM7eL2?=
 =?us-ascii?Q?nITAq/ygRH82iX67SarFa9Fq1vwO8EkG2pes?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:34:21.3887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faea36c7-d5b7-4710-b837-08ddcba9df6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6404

The "mbm_event" counter assignment mode allows the user to assign a
hardware counter to an RMID, event pair and monitor the bandwidth as long
as it is assigned. The user can specify the memory transaction(s) for the
counter to track.

Add the definitions for supported memory transactions (e.g., read, write,
etc.) the counter can be configured with.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v16: Minor code comment update.

v15: Updated the changelog.
     Moved NUM_MBM_TRANSACTIONS to include/linux/resctrl_types.h
     Changed struct mbm_config_value to  struct mbm_transaction.

v14: Changed the term memory events to memory transactions to be consistant.
     Changed the name of the structure to mbm_config_value(from mbm_evt_value).
     Changed name to memory trasactions where applicable.
     Changes subject line to fs/resctrl.

v13: Updated the changelog.
     Removed the definitions from resctrl_types.h and moved to internal.h.
     Removed mbm_assign_config definition. Configurations will be part of
     mon_evt list.
     Resolved conflicts caused by the recent FS/ARCH code restructure.
     The rdtgroup.c file has now been split between the FS and ARCH directories.

v12: New patch to support event configurations via new counter_configs
     method.
---
 fs/resctrl/internal.h         | 11 +++++++++++
 fs/resctrl/monitor.c          | 11 +++++++++++
 include/linux/resctrl_types.h |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index eeee83a5067a..693268bcbad2 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -216,6 +216,17 @@ struct rdtgroup {
 	struct pseudo_lock_region	*plr;
 };
 
+/**
+ * struct mbm_transaction - Memory transaction an MBM event can be configured with.
+ * @name:	Name of memory transaction (read, write ...).
+ * @val:	The bit (eg. READS_TO_LOCAL_MEM or READS_TO_REMOTE_MEM) used to
+ *		represent the memory transaction within an event's configuration.
+ */
+struct mbm_transaction {
+	char	name[32];
+	u32	val;
+};
+
 /* rdtgroup.flags */
 #define	RDT_DELETED		1
 
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index a8b53b0ad0b7..16bcfeeb89e6 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -918,6 +918,17 @@ u32 resctrl_get_mon_evt_cfg(enum resctrl_event_id evtid)
 	return mon_event_all[evtid].evt_cfg;
 }
 
+/* Decoded values for each type of memory transaction. */
+struct mbm_transaction mbm_transactions[NUM_MBM_TRANSACTIONS] = {
+	{"local_reads", READS_TO_LOCAL_MEM},
+	{"remote_reads", READS_TO_REMOTE_MEM},
+	{"local_non_temporal_writes", NON_TEMP_WRITE_TO_LOCAL_MEM},
+	{"remote_non_temporal_writes", NON_TEMP_WRITE_TO_REMOTE_MEM},
+	{"local_reads_slow_memory", READS_TO_LOCAL_S_MEM},
+	{"remote_reads_slow_memory", READS_TO_REMOTE_S_MEM},
+	{"dirty_victim_writes_all", DIRTY_VICTIMS_TO_ALL_MEM},
+};
+
 /**
  * resctrl_mon_resource_init() - Initialise global monitoring structures.
  *
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index d98351663c2c..acfe07860b34 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -34,6 +34,9 @@
 /* Max event bits supported */
 #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
 
+/* Number of memory transactions that an MBM event can be configured with */
+#define NUM_MBM_TRANSACTIONS		7
+
 /* Event IDs */
 enum resctrl_event_id {
 	/* Must match value of first event below */
-- 
2.34.1


