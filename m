Return-Path: <linux-kernel+bounces-726224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1C1B009BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C111798D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDE82F0C6D;
	Thu, 10 Jul 2025 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ye3Nd1F7"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB121283FE8;
	Thu, 10 Jul 2025 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167860; cv=fail; b=dKYhjyXaW5ihxUL6RK7QHK3qAxJjXz2O9oG6EckqS9TBNGrWwvwj57R9bKQIsQkEzsvQ1yWg3M2jXZmMAcBnPDHcr/bDhkcX8o24yH+ibXSdwbz4i3x8TsmRk0B9j+XSfD0PUSGO8TiHODexURZ2CP7X84tVKX0p1+YfbdgXx7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167860; c=relaxed/simple;
	bh=tAgU/IpAMLZ0uOWuYxuamRRCPpOUyNkzCATYforqGM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJHXJvztm7M2Xpm99M6JsLk8nOzYfUMMswdF4euW1qzSPyGfXmvqcT2jcE+5ibcPVEMKVhV4P4fOnp22EXohkPP4sQacRsWOnFyVYbA2HTNNhS0ykl/so3ZXtALzveBMGsVPNtTYPdnpb4/mFL6a5wjEL0dz2Zyy2fw5qkpPn78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ye3Nd1F7; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQto2cTQJUpc9OPY/KVHFpgvOkR8zo2fAHuO5lHX/MR76AHTz0X/TFHub2TLVklPBR7rBuCNWNzaoeqFOhBYcDeHmuLFj7D4lAnTtI4so3QlJCVxyymoqa/uXm1TaNBPYAnzXHaGZgy2TdXjBTN3TcYqHmZIOxBEi5iKJeNHjefiC4LxNXDCZT9oqPz5rzOWMZ0QgdHAORt5RftEwb/VzgsxYWmrGIaH35a9xF2wJuBcXE76ukvzRYBhULbBLA6n1bVrznnMmewNlgVU6bBeBvVpYTtN3OznDvLHAREm8cpFBrv7aIYwRj51lwW95gOFHZ7yzSlKVctMQnbp4thr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ljb36zA6ZY2UCJn8p7Z3w3nKL2ggr4DXoVcKYeZp5Jg=;
 b=cKBJYWKTr4xW0q2RJ7mvr8Nr2T1jqoKLh5+udmJQPeH7y4SCjXYjpfz2zJW0rg93CIheRoAFLucW8PtPluC2AAzDotgJ9aKGxAtMRiXlR1JPxM/TD9bbf6LEzXE4sMZnXIBN4hnrZgChqK8ZkvvCTTokAOfoQvbaZgkEYqrl4kQ5dir45ifZ+keepHNZCS6gofMRmJ+0k7djkKiKuSWLqiEggJkILwnX+XlsbV1gmo8xbEQbTVAfa+vWSmYDiHHSDit9Qbtjs/zTaNe7veey2b+1P6ByaHEGbrJsr1H3SCcSeuKqcK6UkyWN/vHgzgaWmcNKe7G2z9SI2hqnh+YLcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ljb36zA6ZY2UCJn8p7Z3w3nKL2ggr4DXoVcKYeZp5Jg=;
 b=Ye3Nd1F7k2ZraBPuiv0BQU2npnR3c5bUFom+T4cyOswiJWr55qp5j4tw0iZYvTjqfM7WqMXXZMcPWRaTe05rfbx7p6AgPx9LlfGJmsn+p0HP5z1srO8+NVeJzguvnpiq6t93pu4Iw0mHDFuwh22vAzrZw/2LT4i9VrzSsguVCzs=
Received: from MW4PR03CA0158.namprd03.prod.outlook.com (2603:10b6:303:8d::13)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 17:17:34 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::33) by MW4PR03CA0158.outlook.office365.com
 (2603:10b6:303:8d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Thu,
 10 Jul 2025 17:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 17:17:33 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 12:17:31 -0500
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
Subject: [PATCH v7 07/10] fs/resctrl: Add user interface to enable/disable io_alloc feature
Date: Thu, 10 Jul 2025 12:16:21 -0500
Message-ID: <e311fd8f4ddfd33c29febdc71d5d41f8a06680cc.1752167718.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 82612caf-9ba5-4e08-ee82-08ddbfd5a8e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Wmeyk9l4zgsjG61Dv8KK8PwbViDYA2FqVZhtf3jZNFQnCXzQ+wvDGGd3CPV?=
 =?us-ascii?Q?FmwYCx9VRTLn8zQNexvkLtInebm+ht6NWZ3Yv9Rylbws/WnOqQu6l214B1tJ?=
 =?us-ascii?Q?VIcijiHTR/pmTTC8sw9+YU8x5LaCeZq0pdbx8X5shJgb5YSspExx0cR1/ly0?=
 =?us-ascii?Q?vMjJpEr/vMXq0GGoXzrs/9Dv9w9G3Pf3BiJnh23msUMwVXeBG6WelM16DyHu?=
 =?us-ascii?Q?wCb5IjwHRMWxPy161DZAytxiZGMCN7KkxfhCU63v/03Am/65cti61Lauw6wx?=
 =?us-ascii?Q?1ds/oKjCv7mY1XUvIZwKqaUkiGnJkhuIx+cNe8a3Bv/xAOBlAr7DUcMyUoAg?=
 =?us-ascii?Q?8NwqmH4KXHRHflJcr+P+6VvOah3b+0KIPEiYkuz+2YcRJvG9bA05Fx55aAnT?=
 =?us-ascii?Q?QKcGA7zCXy37SAcmWxuE9q//aNQzO2ZUjk8OkVt05yjGj7aW90S+2uPt602b?=
 =?us-ascii?Q?UXhD+LkuPhDE9UxTYfJBxbQaNgQ68ZPaW3EsJVkh1nUTyreyaepzoF0PWMTU?=
 =?us-ascii?Q?KDh3EfDAiDLNjgc2ANsW5jmm7OLnZvgr7dhWzcB3Sv856++35Hp6UpuOOTV8?=
 =?us-ascii?Q?BiLBFQh4em8QoT/MOvOSBBmjVJ7vxvcIzi4fBHNeZDwVmeZw/SDhn+A43Ttm?=
 =?us-ascii?Q?hnX6L8VqUWNlvYICqJzXAkpHpNuVCOPAP/Nj1Qm+ETDM4f44fAfrn92R3POi?=
 =?us-ascii?Q?nLx3/zx7aJXMrrIrq5p3fdBwHuCnIa8MANZUF3vkZgb82Bet99Mll3d3teuE?=
 =?us-ascii?Q?LFFIJjNAdNekWaXDsAsMP5lZWYwswXtgD8IOchJQjcc09hsq8yv5RiCsYcEt?=
 =?us-ascii?Q?PJW2iQUfw42gZ+CxO5EIFdfoJVh+8dsEz7zS5ntSYP+9uBMU+MsZUDqWxnfS?=
 =?us-ascii?Q?mb6nom/4Gm+aQCoMhnFjbw1PaBlPUN3B0ZEIKGDl7CNt6LrGODso3mQtQ0kP?=
 =?us-ascii?Q?QNYVMmVVfJs3JvK936Ack2ln1jmFk0Ssmwmd2BXMNJItvT6cgHod0mJn1q23?=
 =?us-ascii?Q?Nryqt20ES1rDA6odn2qT4GWjCluBrFpqlWX1ab3q1Z3xN/rUtWeaVt4CDdVK?=
 =?us-ascii?Q?gN5QsVxujJ1X0mxoCKz4Xsv6xTBkTnX1kgXZTX3ePJiEqDucP0wPyt+T+xYj?=
 =?us-ascii?Q?bmoojTZNJ/15J6cEYBDiSHXxCc3IrB/3meU8mTQKqs4oryCU18Y1P6M+eel6?=
 =?us-ascii?Q?p4fIfLqVmo0Eksr34bC3Ba17AGWefVRKL5TUs3aCATZ5ZkJJdn0CipbfUL3R?=
 =?us-ascii?Q?ef+wL+PVIJIdVqsflDE5NCBukl8lZQu4oOT0/Y8OdFsFPq/NYSsYfjPmcgQ/?=
 =?us-ascii?Q?qPH2/GQ7EIoSnWb71H5EZtrc6nYKcul7vFHuL7hxXT5frn5L3o5CicP7/LFx?=
 =?us-ascii?Q?npEG3jns+9jotsmIktqyfVTUMYbVHfwY1bFtV5phaQfFbCiZ0U7HHHhKSsy/?=
 =?us-ascii?Q?jmTiPlZBbWgkhx2I3RFu1frP5lG10TdJJBvwADhdu4KDEHADX/2skRFge6pw?=
 =?us-ascii?Q?CBLsYbB2S+K6a48a7zj/Gm8p2BKuraPz1Wi+jvDuYSQU2biB5liJUqY9Dw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 17:17:33.7417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82612caf-9ba5-4e08-ee82-08ddbfd5a8e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598

"io_alloc" feature in resctrl enables direct insertion of data from I/O
devices into the cache.

Introduce user interface to enable/disable io_alloc feature.

On AMD systems, io_alloc feature is backed by SDCIAE (L3 Smart Data Cache
Injection Allocation Enforcement). When enabled, SDCIAE directs all SDCI
lines to be placed into the L3 cache partitions specified by the register
corresponding to the highest CLOSID supported by the resource. With CDP
enabled, io_alloc routes I/O traffic using the highest CLOSID assigned to
the instruction cache (L3CODE).

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: Separated resctrl_io_alloc_show and bit_usage changes in two separate
    patches.
    Added resctrl_io_alloc_closid_supported() to verify io_alloc CLOSID.
    Initialized the schema for both CDP_DATA and CDP_CODE when CDP is enabled.

v6: Changed the subject to fs/resctrl:

v5: Resolved conflicts due to recent resctrl FS/ARCH code restructure.
    Used rdt_kn_name to get the rdtgroup name instead of accesssing it directly
    while printing group name used by the io_alloc_closid.

    Updated bit_usage to reflect the io_alloc CBM as discussed in the thread:
    https://lore.kernel.org/lkml/3ca0a5dc-ad9c-4767-9011-b79d986e1e8d@intel.com/
    Modified rdt_bit_usage_show() to read io_alloc_cbm in hw_shareable, ensuring
    that bit_usage accurately represents the CBMs.

    Updated the code to modify io_alloc either with L3CODE or L3DATA.
    https://lore.kernel.org/lkml/c00c00ea-a9ac-4c56-961c-dc5bf633476b@intel.com/

v4: Updated the change log.
    Updated the user doc.
    The "io_alloc" interface will report "enabled/disabled/not supported".
    Updated resctrl_io_alloc_closid_get() to verify the max closid availability.
    Updated the documentation for "shareable_bits" and "bit_usage".
    Introduced io_alloc_init() to initialize fflags.
    Printed the group name when io_alloc enablement fails.

    NOTE: io_alloc is about specific CLOS. rdt_bit_usage_show() is not designed
    handle bit_usage for specific CLOS. Its about overall system. So, we cannot
    really tell the user which CLOS is shared across both hardware and software.
    We need to discuss this.

v3: Rewrote the change to make it generic.
    Rewrote the documentation in resctrl.rst to be generic and added
    AMD feature details in the end.
    Added the check to verify if MAX CLOSID availability on the system.
    Added CDP check to make sure io_alloc is configured in CDP_CODE.
    Added resctrl_io_alloc_closid_free() to free the io_alloc CLOSID.
    Added errors in few cases when CLOSID allocation fails.
    Fixes splat reported when info/L3/bit_usage is accesed when io_alloc
    is enabled.
    https://lore.kernel.org/lkml/SJ1PR11MB60837B532254E7B23BC27E84FC052@SJ1PR11MB6083.namprd11.prod.outlook.com/

v2: Renamed the feature to "io_alloc".
    Added generic texts for the feature in commit log and resctrl.rst doc.
    Added resctrl_io_alloc_init_cat() to initialize io_alloc to default
    values when enabled.
    Fixed io_alloc show functinality to display only on L3 resource.
---
 Documentation/filesystems/resctrl.rst |   8 ++
 fs/resctrl/rdtgroup.c                 | 149 +++++++++++++++++++++++++-
 2 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 354e6a00fa45..189c1ccb92d6 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -157,6 +157,14 @@ related to allocation:
 			"not supported":
 			      Support not available on the system.
 
+		The feature can be modified by writing to the interface, for example:
+
+		To enable:
+			# echo 1 > /sys/fs/resctrl/info/L3/io_alloc
+
+		To disable:
+			# echo 0 > /sys/fs/resctrl/info/L3/io_alloc
+
 		The underlying implementation may reduce resources available to
 		general (CPU) cache allocation. See architecture specific notes
 		below. Depending on usage requirements the feature can be enabled
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index d7c4417b4516..06c854caa55c 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -70,6 +70,7 @@ static struct seq_buf last_cmd_status;
 static char last_cmd_status_buf[512];
 
 static int rdtgroup_setup_root(struct rdt_fs_context *ctx);
+static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid);
 
 static void rdtgroup_destroy_root(void);
 
@@ -232,6 +233,16 @@ bool closid_allocated(unsigned int closid)
 	return !test_bit(closid, closid_free_map);
 }
 
+static bool resctrl_io_alloc_closid_alloc(u32 io_alloc_closid)
+{
+	return __test_and_clear_bit(io_alloc_closid, closid_free_map);
+}
+
+static void resctrl_io_alloc_closid_free(u32 io_alloc_closid)
+{
+	closid_free(io_alloc_closid);
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
@@ -1030,6 +1041,16 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+/*
+ * resctrl_io_alloc_closid_supported() - io_alloc feature utilizes the
+ * highest CLOSID value to direct I/O traffic. Ensure that io_alloc_closid
+ * is in the supported range.
+ */
+static bool resctrl_io_alloc_closid_supported(u32 io_alloc_closid)
+{
+	return io_alloc_closid < closids_supported();
+}
+
 /*
  * resctrl_io_alloc_closid() - io_alloc feature routes I/O traffic using
  * the highest available CLOSID. Retrieve the maximum CLOSID supported by the
@@ -1858,6 +1879,131 @@ static int resctrl_io_alloc_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+/*
+ * Initialize io_alloc CLOSID cache resource CBM with all usable (shared
+ * and unused) cache portions.
+ */
+static int resctrl_io_alloc_init_cat(struct rdt_resource *r,
+				     struct resctrl_schema *s, u32 closid)
+{
+	int ret;
+
+	rdt_staged_configs_clear();
+
+	ret = rdtgroup_init_cat(s, closid);
+	if (ret < 0)
+		goto out;
+
+	ret = resctrl_arch_update_domains(r, closid);
+
+out:
+	rdt_staged_configs_clear();
+	return ret;
+}
+
+static const char *rdtgroup_name_by_closid(int closid)
+{
+	struct rdtgroup *rdtgrp;
+
+	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
+		if (rdtgrp->closid == closid)
+			return rdt_kn_name(rdtgrp->kn);
+	}
+
+	return NULL;
+}
+
+static struct resctrl_schema *resctrl_get_schema(enum resctrl_conf_type type)
+{
+	struct resctrl_schema *schema;
+
+	list_for_each_entry(schema, &resctrl_schema_all, list) {
+		if (schema->conf_type == type)
+			return schema;
+	}
+
+	return NULL;
+}
+
+static ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
+				      size_t nbytes, loff_t off)
+{
+	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
+	enum resctrl_conf_type peer_type;
+	struct rdt_resource *r = s->res;
+	struct resctrl_schema *peer_s;
+	char const *grp_name;
+	u32 io_alloc_closid;
+	bool enable;
+	int ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret)
+		return ret;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	if (!r->cache.io_alloc_capable) {
+		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	io_alloc_closid = resctrl_io_alloc_closid(r);
+	if (!resctrl_io_alloc_closid_supported(io_alloc_closid)) {
+		rdt_last_cmd_printf("io_alloc CLOSID (ctrl_hw_id) %d is not available\n",
+				    io_alloc_closid);
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	/* If the feature is already up to date, no action is needed. */
+	if (resctrl_arch_get_io_alloc_enabled(r) == enable)
+		goto out_unlock;
+
+	if (enable) {
+		if (!resctrl_io_alloc_closid_alloc(io_alloc_closid)) {
+			grp_name = rdtgroup_name_by_closid(io_alloc_closid);
+			WARN_ON_ONCE(!grp_name);
+			rdt_last_cmd_printf("CLOSID (ctrl_hw_id) %d for io_alloc is used by %s group\n",
+					    io_alloc_closid, grp_name ? grp_name : "another");
+			ret = -ENOSPC;
+			goto out_unlock;
+		}
+
+		/* Initialize schema for both CDP_DATA and CDP_CODE when CDP is enabled */
+		if (resctrl_arch_get_cdp_enabled(r->rid)) {
+			peer_type = resctrl_peer_type(s->conf_type);
+			peer_s = resctrl_get_schema(peer_type);
+			if (peer_s)
+				ret = resctrl_io_alloc_init_cat(r, peer_s, io_alloc_closid);
+		}
+
+		if (!ret)
+			ret = resctrl_io_alloc_init_cat(r, s, io_alloc_closid);
+
+		if (ret) {
+			rdt_last_cmd_puts("Failed to initialize io_alloc allocations\n");
+			resctrl_io_alloc_closid_free(io_alloc_closid);
+			goto out_unlock;
+		}
+
+	} else {
+		resctrl_io_alloc_closid_free(io_alloc_closid);
+	}
+
+	ret = resctrl_arch_io_alloc_enable(r, enable);
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -1950,9 +2096,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "io_alloc",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= resctrl_io_alloc_show,
+		.write          = resctrl_io_alloc_write,
 	},
 	{
 		.name		= "max_threshold_occupancy",
-- 
2.34.1


