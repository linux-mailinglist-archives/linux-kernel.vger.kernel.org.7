Return-Path: <linux-kernel+bounces-769183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863E8B26B37
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D58563CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D26722D7B6;
	Thu, 14 Aug 2025 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YgA16R4/"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5217617AE1D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185672; cv=fail; b=Jv/Q4iila+lf1VkSo1LWITEBTlUNFy4H15m6pwlQaOOMXrug/COC6lC2Wp8swelxd+hDbdNOv7yfVUgnJxDaPlRrh3tMixc7AY3r4m92awSNrQEOmZmXpVP+FynnzxpsNIjTBChtMi2E9FTz5lj2y6nnI27mtCW5rptNsGbz0HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185672; c=relaxed/simple;
	bh=tNB6puLZUATBUCN/EA1kKkFaLOe95pDtLDXQK2yw2TY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xuavqf3cClxx+telmp19UhHYIVAj6gSMBd1UoMXU2kQgBQOmx3CPT8XfiB4I76gmBpZ82fXvcbWTq/Ddb1NJNECNmiP8IJrDDAeV0w0DoEHshOeR5XUi7dU7KjK3TWO/dU/yAOUah2CC7JtV00tJDiV6y+mr9QELWzKC8TC3oaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YgA16R4/; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9Ey9ore+VT8m/tiRLdr9s9RjnR+NuNvTofr4/ti2lm2Q8op4LtHg6pt47S0wbirTdJfU8XogSmOyquZm8RLoadrffkMA7BSEdc6uLEod07s7k4cIxHi5qJE3krLUI4arpM9sJY6VLtrtPvpNBn+H+lQES8hshpcb8WNIyTdTXXmaJCwadxY4tdzpIXCgyetgW6wgPWmc3AAA9YrUQ/bhH3KLVvklEmBTZjH6RR/P9WDvxidzX2YNCqMUDk1hJfOzOxSl6h2ePcqubm8+dpDcEJ2xi5jPmmIo61RUlZeIuQAK7MKoQQjA7UftTdVhz4DdGIUTjsKpq3MkzoXmhKZbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6yUiVOmVxuU72JxpsJZhSRgH6o0kl8/xMLa+WIVrPk=;
 b=nBCUIfIrymmXSYygrDNuwMAKp12HR5QuDjCKUnUxDT5X9tTFA7cjRBhPMtltkdpR3cwrz/mtgT+o5U0HbPFdIe3cyGZ/2LBNJ5XYpM1N5vSjir8yYxVPTar6T0hhkm9/pURWxWzw2bYhVhocmOxSHbWjDayel3vkvLHyHijTyQmZKd5Q15eG9ndrHUMnyYJjJtIvGg4ZkWCJ0VOBv8K8pV1KdRjTRg42CSSEBP2u3+dC+ZYR3hB773+WgPgpMYPVt9HRe0juOpFfXMX/D3Svy6ywlB7ligyuwPBJJLLcepLO1isFrnp1+Bzj0HHa0MKajsvVoPm8q2aMjzCtG3ATZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6yUiVOmVxuU72JxpsJZhSRgH6o0kl8/xMLa+WIVrPk=;
 b=YgA16R4/mFSD+z0Vn0U3EaQ0aJmWod5efqhDPWiK8Jjmi5Yfa48AycQX9wtV68Nga6Ji9g1MAAtlNVFVC+VnOmZUdkRjrLpFm8RgbsKMxnVY+p49cLyLDlznKgMlrhoQ28kwkqvJ1ojbOIV0BT2Sx7r8gq3Mw0qNh0Jj1JQd1xo=
Received: from BN9PR03CA0475.namprd03.prod.outlook.com (2603:10b6:408:139::30)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 15:34:27 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::84) by BN9PR03CA0475.outlook.office365.com
 (2603:10b6:408:139::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Thu,
 14 Aug 2025 15:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 15:34:26 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 10:34:14 -0500
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <raghavendra.kt@amd.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Michael.Day@amd.com>,
	<akpm@linux-foundation.org>, <bharata@amd.com>, <dave.hansen@intel.com>,
	<david@redhat.com>, <dongjoo.linux.dev@gmail.com>, <feng.tang@intel.com>,
	<gourry@gourry.net>, <hannes@cmpxchg.org>, <honggyu.kim@sk.com>,
	<hughd@google.com>, <jhubbard@nvidia.com>, <jon.grimm@amd.com>,
	<k.shutemov@gmail.com>, <kbusch@meta.com>, <kmanaouil.dev@gmail.com>,
	<leesuyeon0506@gmail.com>, <leillc@google.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<mgorman@techsingularity.net>, <mingo@redhat.com>, <nadav.amit@gmail.com>,
	<nphamcs@gmail.com>, <peterz@infradead.org>, <riel@surriel.com>,
	<rientjes@google.com>, <rppt@kernel.org>, <santosh.shukla@amd.com>,
	<shivankg@amd.com>, <shy828301@gmail.com>, <sj@kernel.org>, <vbabka@suse.cz>,
	<weixugc@google.com>, <willy@infradead.org>, <ying.huang@linux.alibaba.com>,
	<ziy@nvidia.com>, <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
	<yuanchu@google.com>, <kinseyho@google.com>, <hdanton@sina.com>,
	<harry.yoo@oracle.com>
Subject: [RFC PATCH V3 05/17] mm: Create a separate kthread for migration
Date: Thu, 14 Aug 2025 15:32:55 +0000
Message-ID: <20250814153307.1553061-6-raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814153307.1553061-1-raghavendra.kt@amd.com>
References: <20250814153307.1553061-1-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ecad30c-670c-40ac-5238-08dddb480db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Py1TkQi0/UjwyEVgoUhf3vHIx0vjwvzOW5sVwZAmRiVxQyrawxkHrAytR5d5?=
 =?us-ascii?Q?KfGLd2kPDyXQKZR5DFJ2cHXmfrwaC4RrFe9EGYV82enaY6SFTpvGjko1G4nl?=
 =?us-ascii?Q?o/X+2rhw/9Xhgm0dibSEL5FXN/BjVR17LdGy7Huc1RJVpFviFkRlOWnHJvlA?=
 =?us-ascii?Q?KZ0yEiwbHJGkdO83NR1LIj9AKGQnBR6LGvJ8g7tEZ6sqoCMB/qAjqpkJv7lV?=
 =?us-ascii?Q?XDvGLeqBJXjbbvMwdUTT3XqALW7Egy8zyUG8TvDs9wMKYMDQ7cx3TXQ3G2Gg?=
 =?us-ascii?Q?6gKd4sUabzB54q59VAZ7MiQY2ecLIRvz+IKpg3fmHz1CYToLfBu48O8qIdVE?=
 =?us-ascii?Q?cgI+VTwhgRqG3xojfI8/M5xB/Q+d1fMo747sjTn4jsB6KBMsJ50Lc/nAza5S?=
 =?us-ascii?Q?WCXOrv0n0cCkwg0Nzz7ZDi8jfiWGoZke18UOiMtuZR0vZLA1/hFKztA4TNq8?=
 =?us-ascii?Q?1MGHRVppG0zCqWLPjGhken5ke75AZmysJasyRL/thLEMwx3lWgg1zKHHJZro?=
 =?us-ascii?Q?ep3EzpmFeOVr0P3w5iwCxdP+n7K7Nv89uihw6QoCl16jPxSqA63yJ7se7+CK?=
 =?us-ascii?Q?wjE1spFHZPcmXWjUMA2//zUhPTiOlkiE+r7DXg+xmIniy9AflkqKNfLYvbHH?=
 =?us-ascii?Q?vPTFn2DQlJtA+Av7dFny9fkt0uC7xC/023M5eOawJ53JkD/VTrXiiwQzTQ4W?=
 =?us-ascii?Q?v4pe9PLb6DhFPV29H+V1n+oDqp1/yN16Rk5cGC/F1hYu4txNKGSOoKzLTVc6?=
 =?us-ascii?Q?WbeQxMP+Y6CFd9rBH13vNHxtlCu8657ipn/D1ssbUIo0N81oIpPGf5BSsHPo?=
 =?us-ascii?Q?D3oQGzdBmXGBAzHWY9YX6KC5HA1ZcuUIWxsULM56Y+kUkFmaLjcsHlR3F0L4?=
 =?us-ascii?Q?vuJzNNbVW9sRwyVIyxPm6ROEVbpd6bv7rnxSFRebXejyCsPnVeebE5j1uQhl?=
 =?us-ascii?Q?ABLr+2NNcDdOlIub5jtOjgUOwlS5MEUin1QtTmFo54PlZxk8QY7LMqBR/6Cj?=
 =?us-ascii?Q?uStOqulQc+UgexNIfZK65DXeZyNt9DjkGKRwBgsCMWyELeDgnrEo6lZ/xLq4?=
 =?us-ascii?Q?8Rd02PCFEeGlK0ei2NYxKZbQTQK7PzhXuqUorka6/qkdCxn/kwYtL74cLE1E?=
 =?us-ascii?Q?hk3GOsr/LauwrugO8DQE4VntyaNph7OdBVHI622u8qXicfOcIDEh0FM41nl7?=
 =?us-ascii?Q?YSzbw0+EtgCBDNv1yhJOjh0Cgzr851DXR5QlwqMNkJctZ/3S1Sk9BAK2YnK2?=
 =?us-ascii?Q?g89nlWhHMBZfsgVkSvYWrlDQk437zsMqS8DfHgM5DL0fiMSGa9w+AS0L35Ny?=
 =?us-ascii?Q?nreHpTkiHx04xgeSQ9eU1whnC0vSf0ky5YDp6Qgqtx44RwyHNsBk1mmBx+BN?=
 =?us-ascii?Q?UcZrdq34JXBC4FHuvf7M8FkoMiGuHaiTZ3ColrF3np3QiuP3Rz/vopOzoRAI?=
 =?us-ascii?Q?1qeXGvaqFJ5RsUEUW6NNmsj5Sossa/nO1iEol2Y5bz8NoU0/uKdR3lyVZ/T6?=
 =?us-ascii?Q?e70ZensNJYXuO7gj5kTR9v1wJKxd+njdPqXb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:34:26.9960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecad30c-670c-40ac-5238-08dddb480db2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748

Having independent thread helps in:
 - Alleviating the need for multiple scanning threads
 - Aids to control batch migration (TBD)
 - Migration throttling (TBD)

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/kscand.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/mm/kscand.c b/mm/kscand.c
index 7552ce32beea..55efd0a6e5ba 100644
--- a/mm/kscand.c
+++ b/mm/kscand.c
@@ -4,6 +4,7 @@
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/mmu_notifier.h>
+#include <linux/migrate.h>
 #include <linux/rmap.h>
 #include <linux/pagewalk.h>
 #include <linux/page_ext.h>
@@ -41,6 +42,15 @@ static unsigned long kscand_mms_to_scan __read_mostly = KSCAND_MMS_TO_SCAN;
 
 bool kscand_scan_enabled = true;
 static bool need_wakeup;
+static bool migrated_need_wakeup;
+
+/* How long to pause between two migration cycles */
+static unsigned int kmigrate_sleep_ms __read_mostly = 20;
+
+static struct task_struct *kmigrated_thread __read_mostly;
+static DEFINE_MUTEX(kmigrated_mutex);
+static DECLARE_WAIT_QUEUE_HEAD(kmigrated_wait);
+static unsigned long kmigrated_sleep_expire;
 
 static unsigned long kscand_sleep_expire;
 
@@ -79,6 +89,7 @@ struct kscand_scanctrl {
 };
 
 struct kscand_scanctrl kscand_scanctrl;
+
 /* Per folio information used for migration */
 struct kscand_migrate_info {
 	struct list_head migrate_node;
@@ -134,6 +145,19 @@ static inline bool is_valid_folio(struct folio *folio)
 	return true;
 }
 
+static inline void kmigrated_wait_work(void)
+{
+	const unsigned long migrate_sleep_jiffies =
+		msecs_to_jiffies(kmigrate_sleep_ms);
+
+	if (!migrate_sleep_jiffies)
+		return;
+
+	kmigrated_sleep_expire = jiffies + migrate_sleep_jiffies;
+	wait_event_timeout(kmigrated_wait,
+			true,
+			migrate_sleep_jiffies);
+}
 
 static bool folio_idle_clear_pte_refs_one(struct folio *folio,
 					 struct vm_area_struct *vma,
@@ -537,6 +561,49 @@ static int stop_kscand(void)
 	return 0;
 }
 
+static int kmigrated(void *arg)
+{
+	while (true) {
+		WRITE_ONCE(migrated_need_wakeup, false);
+		if (unlikely(kthread_should_stop()))
+			break;
+		msleep(20);
+		kmigrated_wait_work();
+	}
+	return 0;
+}
+
+static int start_kmigrated(void)
+{
+	struct task_struct *kthread;
+
+	guard(mutex)(&kmigrated_mutex);
+
+	/* Someone already succeeded in starting daemon */
+	if (kmigrated_thread)
+		return 0;
+
+	kthread = kthread_run(kmigrated, NULL, "kmigrated");
+	if (IS_ERR(kmigrated_thread)) {
+		pr_err("kmigrated: kthread_run(kmigrated)  failed\n");
+		return PTR_ERR(kthread);
+	}
+
+	kmigrated_thread = kthread;
+	pr_info("kmigrated: Successfully started kmigrated");
+
+	wake_up_interruptible(&kmigrated_wait);
+
+	return 0;
+}
+
+static int stop_kmigrated(void)
+{
+	guard(mutex)(&kmigrated_mutex);
+	kthread_stop(kmigrated_thread);
+	return 0;
+}
+
 static inline void init_list(void)
 {
 	INIT_LIST_HEAD(&kscand_scanctrl.scan_list);
@@ -559,8 +626,15 @@ static int __init kscand_init(void)
 	if (err)
 		goto err_kscand;
 
+	err = start_kmigrated();
+	if (err)
+		goto err_kmigrated;
+
 	return 0;
 
+err_kmigrated:
+	stop_kmigrated();
+
 err_kscand:
 	stop_kscand();
 	kscand_destroy();
-- 
2.34.1


