Return-Path: <linux-kernel+bounces-829441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1991BB971C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BEDB4E2FF0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317EF296BCB;
	Tue, 23 Sep 2025 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lbpy0kcV"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E82285045
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649763; cv=fail; b=SKADiFMXffKd2s2K04kjwDZZHMdbLtVb9zOVDftWKb4KdwKsiVbZ/nQQ3AHQco+xquFL2SBK5SSh4fOS5aoNXeUw0u1Tqr9x/c29wSVkG5FZYB2FFGWhiqYpny2MCJ6Bv1eUIR/OGRR0oI4ntW/+SNKof7mTo53VDSZt/1M6Sjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649763; c=relaxed/simple;
	bh=2aXHevH31sgse920q2SqycuRycRgfLLUoyaqa3Utfpo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OO2FVw7sH50pZLjAXUbkZPtvqTnWRACA2dcQqxlb5zkcQspobe5js7FXBvWu3/jJYapxfjr+spSQYNA63Ao5W6lqb7eIU2O6HYD5ObO5FtaYTS/XOvJ0MZefNLDOgar+CAYPyLkKrk+ixhs3374BBk1m43QgV6uFmoE+uKisoSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lbpy0kcV; arc=fail smtp.client-ip=40.107.208.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keRn8YfKTPOhPWrX6ILImKgAEIl2xiL9V0QBEEz9x0lHbPcJxsNmTy3ywzZItyaRgqe8tUYRQ2+YWPD/KcG/8bRUj0hKoeKRz+7go2YIGfaEzww6/6mQWf6UmWfAb+3mQq3l7PH3JWlNvUf7vgNFxwHkt+wRnOGrjaW+F8JdQB5HVk5o40r3H1fqQrNYC/pZOimzxb0/Y2JWYjdgyh2xOluPXg/1FQFAYFLMxAiOkB0iZWjztvA1D1Knu0cSNU2a4tueT3ErDm/qWY8SWt9CZ+rrcOjYd5AUbUU73eqpCjUpxHXF4B93hGRA3vGdlqw7A+eLFBVN2AbqmdIV6trBHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRU306ef9zUm+sdej3oeM9RD3nGLOvTgHl+98pndOfo=;
 b=Cg9sy3ClYXxXo/O6CnTfVWKgaSlABqGUyL4BYfcS3LbRlAMRdyUVpUP2A1POt+ZprALTP+KbqEjUHrEyhSDPW2XbzJYpyjpP07f6snWAkmLRxZYXpilQCAr3ZgErVhadOlfBUfTeKyz8+Mmf2ockQVdyO8JBdkbVLStnx/PGvcK13dXidzoOuVJvirudEnBa2bi1XTPA9VcPzhmJEjZnO7+J7NwxYfjYZm5Y3Kqx3BxoyN81jdq97ub4h62vjlu/XSEEDGLNXxESq/eYY+0CbZoR0N5CVFVR9laLyw6hvv5oIzltH35IybjKEHYu5iSOFIkNtb4qkgSWm0MsLT2KNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRU306ef9zUm+sdej3oeM9RD3nGLOvTgHl+98pndOfo=;
 b=lbpy0kcV1fIAxzsj4G4sEOV1OBwdyX+vyziqDzfDGnAq786VOXGrRV0K10CGlNEfEE8CgCBr+8NydebiX6aZFK/dgkSeVuR7Ajy/vKIvt6qxihq27dNI5GB6vhZ62spWSwOBHAofHgxBleRi8SyOYKWT2ctoaDmAx/zkCF2MwaQ=
Received: from BL1P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::31)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 17:49:14 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::fb) by BL1P222CA0026.outlook.office365.com
 (2603:10b6:208:2c7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 17:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 17:49:13 +0000
Received: from kaveri.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 10:49:05 -0700
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>
CC: <ziy@nvidia.com>, <willy@infradead.org>, <matthew.brost@intel.com>,
	<joshua.hahnjy@gmail.com>, <rakie.kim@sk.com>, <byungchul@sk.com>,
	<gourry@gourry.net>, <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<vkoul@kernel.org>, <lucas.demarchi@intel.com>, <rdunlap@infradead.org>,
	<jgg@ziepe.ca>, <kuba@kernel.org>, <justonli@chromium.org>,
	<ivecera@redhat.com>, <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dan.j.williams@intel.com>, <rientjes@google.com>,
	<Raghavendra.KodsaraThimmappa@amd.com>, <bharata@amd.com>,
	<shivankg@amd.com>, <alirad.malek@zptcorp.com>, <yiannis@zptcorp.com>,
	<weixugc@google.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [RFC V3 5/9] mm: add support for copy offload for folio Migration
Date: Tue, 23 Sep 2025 17:47:40 +0000
Message-ID: <20250923174752.35701-6-shivankg@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923174752.35701-1-shivankg@amd.com>
References: <20250923174752.35701-1-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3d85d2-5d39-49cd-86ec-08ddfac9824d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YcugHtTCi8P90NIBiPelIWFUAP3kOIzF15HP0+GDaH1BWP8bkG/gwzn41bNV?=
 =?us-ascii?Q?YHcrz9GyehL3ptbnWecLOUOAfgzFTxC5Wgcgj0e3ln+/Z5glAvreTR5bD8VU?=
 =?us-ascii?Q?IFNve/3/pdeSkooaYf3ZO5VOffbVgLCT12DYmy4FfBXo1srbTTjBx/N9b3BN?=
 =?us-ascii?Q?mngKS4jUbEMJSpwXksKYGF/FbmdH6hSQlrSNneKguNPEng4ihFWuDjtouQM2?=
 =?us-ascii?Q?BJIieTtTREc4U45LqyT2Sw8pyQZDEVo1QwY/h7r/FYrFmG4+HuGeOL7kK6EI?=
 =?us-ascii?Q?ypMZ7LJ2gc2RBvgIR3DnCaxf/iAs5OTGLl/O7lhaYSnMpeymdvFv3s9Km4vv?=
 =?us-ascii?Q?FwPpy1oddwMke1tI3nQN7p1tElo23y8ViGgh9XQv3xdwIIZY0WrkOMeFjQsW?=
 =?us-ascii?Q?hstPgHZ38+vGIBOEAVmcYFxxws3FV2hV2RBO0Rju2ldC1uIWlN/LcW8pCs60?=
 =?us-ascii?Q?lgbl6Sq3QROCayfILWuBoZVemY2xFCW1TyIKKnktUGKtaZpRkqpc2tYkxiP1?=
 =?us-ascii?Q?xqdor1pYRSOj88FcSFb0uyKzpd7n9v5dOtMgFx7A6GpnK0HAvLDloHojv5zN?=
 =?us-ascii?Q?VKa63Mt3RYhj7SIxQQxeTp7C+kv+Q2h4PM9s/ctSisjYq6JQF+QbCDaJMhpb?=
 =?us-ascii?Q?sw+wBo8vcURlMKWr4A4KT3MHnmXyMzEZYirm3SjCVJd7Dq+2uVCW9Pyiesbt?=
 =?us-ascii?Q?ArT1bK9DTMtoctaYMLAeZv4Y2AWwIyrXAdhFipRVtQp0F9/kQa3R/WBzt+vP?=
 =?us-ascii?Q?P2gO0MUKwKEq6sGnPdBYALSJuaCvd8To2QqL2n5MqcHwjMkVOiwHwutcP21X?=
 =?us-ascii?Q?hkDe4XyB9znX3HausYs0CV1DwmLA6DI4Xdj+aTm0OO9iFDlHSFLrgUXuPTHj?=
 =?us-ascii?Q?5s0EAbf7TscEUXqJtmix2f2eO07pdEHmDVy5Yt6+aSqopv059yLgvxB1sErk?=
 =?us-ascii?Q?+KbOdvd53TAzslsSG9yDh7dljK07qvWNswzhtVNnDHvMazixDKEnyruE3CCV?=
 =?us-ascii?Q?A+SQ+wxgF7RPOJ8CUBUgmjoyVNGk1R8aDSBcd7+osVVSW30mAFhXB7vGhMqA?=
 =?us-ascii?Q?B3QBPf9ovlVxiKdKfOPGuFk6KMO4N3x6Z95BzNWG5S5iybsgWh4AL5zpEa3S?=
 =?us-ascii?Q?rdwvkvQQm5fil+pYkRmooJ+jV27UVu3vK/ixhXaEpQcTJr5xO5UsuOh303Hh?=
 =?us-ascii?Q?eib+Mvps/FeLo76KaRD7gdisimo6VHfiJS6sBljcYW879aaSTr+Gq3GBG/Ls?=
 =?us-ascii?Q?KUTCp3G8RcG1tD5jvWSD5RyjnTN6hbdkUtz+9v8l4EimRhG+mG4alIJQHAeU?=
 =?us-ascii?Q?Mgmh206y8P9DNVBIn9PZCa/htiiynkvNd0Lemn1Fr56puhVm37hnDxqfke3o?=
 =?us-ascii?Q?UHYIRyYrI60WBOxnZ2jKoEumqo/MQzEXGtqi/6fhtOL5WO8aaboEYf4O4qau?=
 =?us-ascii?Q?T8BS2BP9X4ETIObxG110fiOHKc+9d7WLFefbn7dsF9izytEmHSS0NLJx7NQi?=
 =?us-ascii?Q?vueTKKEkAC4kXnvMvlgnVOBJVhGSJiVg0Cyt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 17:49:13.7536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3d85d2-5d39-49cd-86ec-08ddfac9824d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187

From: Mike Day <michael.day@amd.com>

Offload-Copy drivers should implement following functions to enable folio
migration offloading:
migrate_offc() - This function takes src and dst folios list undergoing
migration. It is responsible for transfer of page content between the
src and dst folios.
can_migrate_offc() - It performs necessary checks if offload copying
migration is supported for the give src and dst folios.

Offload-Copy driver should include a mechanism to call start_offloading and
stop_offloading for enabling and disabling migration offload respectively.

Signed-off-by: Mike Day <michael.day@amd.com>
Co-developed-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 include/linux/migrate_offc.h | 34 +++++++++++++++++++++
 mm/Kconfig                   |  8 +++++
 mm/Makefile                  |  1 +
 mm/migrate.c                 | 49 +++++++++++++++++++++++++++++-
 mm/migrate_offc.c            | 58 ++++++++++++++++++++++++++++++++++++
 5 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/migrate_offc.h
 create mode 100644 mm/migrate_offc.c

diff --git a/include/linux/migrate_offc.h b/include/linux/migrate_offc.h
new file mode 100644
index 000000000000..e9e8a30f40f0
--- /dev/null
+++ b/include/linux/migrate_offc.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _MIGRATE_OFFC_H
+#define _MIGRATE_OFFC_H
+#include <linux/migrate_mode.h>
+
+#define MIGRATOR_NAME_LEN 32
+struct migrator {
+	char name[MIGRATOR_NAME_LEN];
+	int (*migrate_offc)(struct list_head *dst_list, struct list_head *src_list,
+			    unsigned int folio_cnt);
+	struct rcu_head srcu_head;
+	struct module *owner;
+};
+
+extern struct migrator migrator;
+extern struct mutex migrator_mut;
+extern struct srcu_struct mig_srcu;
+
+#ifdef CONFIG_OFFC_MIGRATION
+void srcu_mig_cb(struct rcu_head *head);
+int offc_update_migrator(struct migrator *mig);
+unsigned char *get_active_migrator_name(void);
+int start_offloading(struct migrator *migrator);
+int stop_offloading(void);
+#else
+static inline void srcu_mig_cb(struct rcu_head *head) { };
+static inline int offc_update_migrator(struct migrator *mig) { return 0; };
+static inline unsigned char *get_active_migrator_name(void) { return NULL; };
+static inline void start_offloading(struct migrator *migrator) { return 0; };
+static inline void stop_offloading(void) { return 0; };
+#endif /* CONFIG_OFFC_MIGRATION */
+
+#endif /* _MIGRATE_OFFC_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index e443fe8cd6cf..a9cbb8d1f1f6 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -689,6 +689,14 @@ config MIGRATION
 config DEVICE_MIGRATION
 	def_bool MIGRATION && ZONE_DEVICE
 
+config OFFC_MIGRATION
+	bool "Migrate Pages offloading copy"
+	def_bool n
+	depends on MIGRATION
+	help
+	 An interface allowing external modules or driver to offload
+	 page copying in page migration.
+
 config ARCH_ENABLE_HUGEPAGE_MIGRATION
 	bool
 
diff --git a/mm/Makefile b/mm/Makefile
index ef54aa615d9d..f609d3899992 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_FAILSLAB) += failslab.o
 obj-$(CONFIG_FAIL_PAGE_ALLOC) += fail_page_alloc.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
 obj-$(CONFIG_MIGRATION) += migrate.o
+obj-$(CONFIG_OFFC_MIGRATION) += migrate_offc.o
 obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
diff --git a/mm/migrate.c b/mm/migrate.c
index ce94e73a930d..41bea48d823c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -43,6 +43,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/memory-tiers.h>
 #include <linux/pagewalk.h>
+#include <linux/migrate_offc.h>
 
 #include <asm/tlbflush.h>
 
@@ -834,6 +835,52 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 }
 EXPORT_SYMBOL(folio_migrate_flags);
 
+#ifdef CONFIG_HAVE_STATIC_CALL
+DEFINE_STATIC_CALL(_folios_copy, folios_mc_copy);
+
+#ifdef CONFIG_OFFC_MIGRATION
+void srcu_mig_cb(struct rcu_head *head)
+{
+	static_call_query(_folios_copy);
+}
+
+int offc_update_migrator(struct migrator *mig)
+{
+	struct module *old_owner, *new_owner;
+	int index;
+	int ret = 0;
+
+	mutex_lock(&migrator_mut);
+	index = srcu_read_lock(&mig_srcu);
+	old_owner = READ_ONCE(migrator.owner);
+	new_owner = mig ? mig->owner : NULL;
+
+	if (new_owner && !try_module_get(new_owner)) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	strscpy(migrator.name, mig ? mig->name : "kernel", MIGRATOR_NAME_LEN);
+	static_call_update(_folios_copy, mig ? mig->migrate_offc : folios_mc_copy);
+	xchg(&migrator.owner, mig ? mig->owner : NULL);
+	if (old_owner)
+		module_put(old_owner);
+
+out_unlock:
+	WARN_ON(ret < 0);
+	srcu_read_unlock(&mig_srcu, index);
+	mutex_unlock(&migrator_mut);
+
+	if (ret == 0) {
+		call_srcu(&mig_srcu, &migrator.srcu_head, srcu_mig_cb);
+		srcu_barrier(&mig_srcu);
+	}
+	return ret;
+}
+
+#endif /* CONFIG_OFFC_MIGRATION */
+#endif /* CONFIG_HAVE_STATIC_CALL */
+
 /************************************************************
  *                    Migration functions
  ***********************************************************/
@@ -1870,7 +1917,7 @@ static void migrate_folios_batch_move(struct list_head *src_folios,
 		goto out;
 
 	/* Batch copy the folios */
-	rc = folios_mc_copy(dst_folios, src_folios, nr_batched_folios);
+	rc = static_call(_folios_copy)(dst_folios, src_folios, nr_batched_folios);
 
 	/* TODO:  Is there a better way of handling the poison
 	 * recover for batch copy, instead of falling back to serial copy?
diff --git a/mm/migrate_offc.c b/mm/migrate_offc.c
new file mode 100644
index 000000000000..a6530658a3f7
--- /dev/null
+++ b/mm/migrate_offc.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/migrate.h>
+#include <linux/migrate_offc.h>
+#include <linux/rculist.h>
+#include <linux/static_call.h>
+
+atomic_t dispatch_to_offc = ATOMIC_INIT(0);
+EXPORT_SYMBOL_GPL(dispatch_to_offc);
+
+DEFINE_MUTEX(migrator_mut);
+DEFINE_SRCU(mig_srcu);
+
+struct migrator migrator = {
+	.name = "kernel",
+	.migrate_offc = folios_mc_copy,
+	.srcu_head.func = srcu_mig_cb,
+	.owner = NULL,
+};
+
+int start_offloading(struct migrator *m)
+{
+	int offloading = 0;
+	int ret;
+
+	pr_info("starting migration offload by %s\n", m->name);
+	ret = offc_update_migrator(m);
+	if (ret < 0) {
+		pr_err("failed to start migration offload by %s, err=%d\n",
+		       m->name, ret);
+		return ret;
+	}
+	atomic_try_cmpxchg(&dispatch_to_offc, &offloading, 1);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(start_offloading);
+
+int stop_offloading(void)
+{
+	int offloading = 1;
+	int ret;
+
+	pr_info("stopping migration offload by %s\n", migrator.name);
+	ret = offc_update_migrator(NULL);
+	if (ret < 0) {
+		pr_err("failed to stop migration offload by %s, err=%d\n",
+		       migrator.name, ret);
+		return ret;
+	}
+	atomic_try_cmpxchg(&dispatch_to_offc, &offloading, 0);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(stop_offloading);
+
+unsigned char *get_active_migrator_name(void)
+{
+	return migrator.name;
+}
+EXPORT_SYMBOL_GPL(get_active_migrator_name);
-- 
2.43.0


