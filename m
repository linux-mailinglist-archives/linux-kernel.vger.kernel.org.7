Return-Path: <linux-kernel+bounces-829455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAA3B971F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F9D19C7DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E592DC342;
	Tue, 23 Sep 2025 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bbDl/JX5"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7802DA76B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649801; cv=fail; b=dtcKDXzpF7Scy8vR6CqlU+RWbgFOtQ8Af5Trhj5AJUNdfG3aSwQsmv4cQwvP3TdXNZu8f6v4+Iq8iog6euuqUdQKYsZYJjk/+SroHdAwRVkxOHYnmZ39sVWj6i3wnydNy/aqBelwbi7bKIqWoFrLR9rWTfS0hNScKJQmPlrf6kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649801; c=relaxed/simple;
	bh=CfPJWIDGiTuhqlEwmHvATi7RM3HG4WEVkZPum38p3dw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vgg0czQ6sD2lp4cetSuElLqmIKm9dvfRfqyGFaNXeyYejo8waIPgc1Py+jvvIrf6lgLv06NKBC2ChMnHyDBKu2oG6GvFWNvGP7UpWsXKoJMkTLHSM0Wu0wjmbr8a/hutlfEgvBjllaYHnzV5IfrJBoxfs5sVhXzUsOvVkrKf3Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bbDl/JX5; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wu/nCjwbvsTuse4P1mDFFQ9Wue/aWVK26bI4ikH3bq7kjLHM7y0yFyJ+pxQksu9Z2isz3CAejMsMcZwa6UAdRcAXMDJFHJ9pVJoS63DeCH0ws/fODRO4qYT4nhU9Tk+LZuL8qf0fBgeIdj5d+KY+4tQYd8jdX53qDohqneOAVs/HDXsVlajk7xy7JVYLZFCLFNK9Nljxc5J79TUtv1byzeGAPHkfxqXIq5CTO4y9keXZGttq9M7irkbtGfMQqDNWqC/N+lyqEJPLJogELzbykS8qNeSFB6xRAnv4Ayx+S6wPUsxXCeE+/SzICf53U0Yj5kj8AvZgJEOwG8um1WnRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tn8s3EdMLzlUqkrxpuPjkMHYijrpzU78gf7sS2AGTd8=;
 b=ft40fE2CJaIXsXjXydI0DeDnO8cx77ZyV1igFTpQWPZWu4NcmsG2NIXqG7R+WIg0TPcUN5ciUgpHBKp6vbzjpGyi245h8nWXiDksAN/Q61oUAffsBvm+ZNC3a7n8+rYKuYFLJhOJqr0gt61XohKW9/AvBXw5Rlkdp78pZ2PSs/ri6Rcb4Ub4T7fo8icyKyeL0xK0mj487R9dqgb17o6YYrnWU/kUfL5Iv61bnEsaSYFJniahRp62+xMC5GJNf/A+iOZfYnWXcVi1n2gdweEfzkuXLh8Gh10AUCiTmxdL3r8KoJNn9cL75gBivCFBYHJBGGKiYEmeEIcHZVCybOqZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tn8s3EdMLzlUqkrxpuPjkMHYijrpzU78gf7sS2AGTd8=;
 b=bbDl/JX5+5cAg8wPeuM8OvXXbEpGXMIgcgS6EPhGK8ZcchoU2oWnbIvT6eKBbrI82sCORzleE88pQfg/ZwADz7ixf2zs/p2s2gxLedg2aGQCfjHN6M3BLNTxQnyUrV13CHdboV+e8vF4snXJEPd3brObET5ooYFD36bnTOTUO7g=
Received: from BL1PR13CA0265.namprd13.prod.outlook.com (2603:10b6:208:2ba::30)
 by DS7PR12MB8291.namprd12.prod.outlook.com (2603:10b6:8:e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 17:49:49 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::6e) by BL1PR13CA0265.outlook.office365.com
 (2603:10b6:208:2ba::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9 via Frontend Transport; Tue,
 23 Sep 2025 17:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 17:49:49 +0000
Received: from kaveri.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 10:49:40 -0700
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
Subject: [RFC V3 9/9] mtcopy: spread threads across die for testing
Date: Tue, 23 Sep 2025 17:47:44 +0000
Message-ID: <20250923174752.35701-10-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DS7PR12MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: a0223cec-a673-4acc-b9b4-08ddfac99769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eRuhbrYZNX9LnUM2tzyCiKOnann/bFO9RT42qi2duvDeCCA07O9tmZfvA1OT?=
 =?us-ascii?Q?cswGYEYXsJYvLxfKUdSiKAy6F41l3wLJF4MP8nCGT3Rt6fQEsQAhJF09QJ6n?=
 =?us-ascii?Q?VWRg9gfUyoF2vGuEP8G0zx0DZ+/aV6tazyHqUJyZ3x1h20h8tRP33GeNRjeT?=
 =?us-ascii?Q?R6kKMcDhfB5DUuZwFhxBMH4MFroYjQxAiqX+Uov1prTQE6fxP7K1Bv0Z7hcR?=
 =?us-ascii?Q?ntp4EmRdNTO9eOl765ij4Lmhd0wsyxsv+zznIvH+O+Azr5Ht9IN7RuzlsKEi?=
 =?us-ascii?Q?iCelbRdd3nfBJrsp/JHC/B4+cDWSPxvbo1V76c2TZaF5ZcdG0N7RHDEgI9e1?=
 =?us-ascii?Q?eTrP1XgKcYtKwXWJo6WqXJ7QZM/jeAr/yNxsT1HlyqEOzjejXRUp87iGxJ9E?=
 =?us-ascii?Q?D7FsT6R4kTSzYj5hcJS1QhbgJ0N5yHkYSQ0MG8/rYp4qR5tDlnrVl2uc2Sp6?=
 =?us-ascii?Q?wSEkoGI2jQ60DqmIT5CnqizmD/BKHAF6SIUgn0+eKzGz1b9E4Dr1hFJYGRgs?=
 =?us-ascii?Q?EehTq4O9g4m+VTNMyD8e8r1hO6GRIHPNW1eM9CJT9RkqH0E/lqBzvkUG2dlw?=
 =?us-ascii?Q?Nge4A4n+h/8N7nIhpUjr7A1+f4ifKbpRvy1IYEusQgod+MtJ6Y1n/3BIA1Y0?=
 =?us-ascii?Q?6RFuR0e8OpnM/UcsffeTyJd27fWtDupLx6h85QDfdpaI5K3J4Ij7OplQjbfX?=
 =?us-ascii?Q?bSTVSFn1yjZGGb6oixpbwYTPFQyFFvi42KuMcxt9UMAFM0dhVEvcI19PRazR?=
 =?us-ascii?Q?cJGQbH9QK8zuzyWM4okfTg5zO6SBkEci4CFIlO3tB7T/qg2r767bKmAQ05oa?=
 =?us-ascii?Q?44M6RjZxgyX2aqpon2I03rZD6qTvdZIXid3UXqpQwwMWTiZrirk5M1l77b43?=
 =?us-ascii?Q?F9eGw1/80/bkijwCL5QHFkvxG4aVmaH3V9ZhC/C0pc28DAVmJivcS2BLZkcn?=
 =?us-ascii?Q?ev9ajaUDaXva4V1DZ+cdbiHTAl1FHNEQwXh4HweSE9RslTRAttuFGFdodsrT?=
 =?us-ascii?Q?ZCtnu6tWvrEY1ECuOb9cn+8o7Hakmnw7ZI/RMV/472OZn5QsPXhSPlZdO10K?=
 =?us-ascii?Q?VbUZapv/nbisvZCzarOfejj/1qDSKxaQ4nVoO/Of0QfMY2yIsSuePXtPZ7Mc?=
 =?us-ascii?Q?Ib8LHNX7hHiJrEsjJqVbgJk3Yav8QygteXV3U64zJAI0XeIgZp0Ia3jFvTe4?=
 =?us-ascii?Q?9Ey/tZYI/jkHyNijMzdBq/AbSgVossnqKDFwmUFBM0Vj7/L8f1lZROQJnv/I?=
 =?us-ascii?Q?uqrbqjt52qzoQ0+5bjGPaGrG/WYQ9qWpCpwwLpUVWSJXj1PjM8oqXk1D+z7X?=
 =?us-ascii?Q?L4x4YGEyTlKVRN+J7tX/6Kzcvgs6JExzHsto6l3SBAcmWrOjuA6Lj86zdbrc?=
 =?us-ascii?Q?bTkkireVQOyCx04cJhhsxw6khbOlNJ13D2+/GZGnIIs+iJd8K7kfJQbAUBcF?=
 =?us-ascii?Q?6UymzMGgyGdeMjKyBzNA2d8cTcF2YfTM9/lfB4m7OZS5CtOq22MBfv3J7d3Y?=
 =?us-ascii?Q?ihUvByRIsuvTSeC2qKsL45Oq9Iie7rsLn0Ij?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 17:49:49.1705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0223cec-a673-4acc-b9b4-08ddfac99769
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8291

Select CPUs using sysfs
For testing purpose only.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 drivers/migoffcopy/mtcopy/copy_pages.c | 76 +++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/drivers/migoffcopy/mtcopy/copy_pages.c b/drivers/migoffcopy/mtcopy/copy_pages.c
index 68e50de602d6..e605acca39d0 100644
--- a/drivers/migoffcopy/mtcopy/copy_pages.c
+++ b/drivers/migoffcopy/mtcopy/copy_pages.c
@@ -15,11 +15,37 @@
 #include <linux/migrate.h>
 #include <linux/migrate_offc.h>
 
-#define MAX_NUM_COPY_THREADS 64
+#define MAX_NUM_COPY_THREADS 32
 
 unsigned int limit_mt_num = 4;
 static int is_dispatching;
 
+static int cpuselect;
+
+// spread across die
+static const int cpu_id_list_0[] = {
+	0, 8, 16, 24,
+	32, 40, 48, 56,
+	64, 72, 80, 88,
+	96, 104, 112, 120,
+	128, 136, 144, 152,
+	160, 168, 176, 184,
+	192, 200, 208, 216,
+	224, 232, 240, 248};
+
+// don't spread, fill the die
+static const int cpu_id_list_1[] = {
+	0, 1, 2, 3,
+	4, 5, 6, 7,
+	8, 9, 10, 11,
+	12, 13, 14, 15,
+	16, 17, 18, 19,
+	20, 21, 22, 23,
+	24, 25, 26, 27,
+	28, 29, 30, 31};
+
+int cpu_id_list[32] = {0};
+
 static int copy_page_lists_mt(struct list_head *dst_folios,
 		struct list_head *src_folios, unsigned int nr_items);
 
@@ -141,6 +167,39 @@ static ssize_t mt_threads_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%u\n", limit_mt_num);
 }
 
+static ssize_t mt_cpuselect_set(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	int ccode;
+	unsigned int cpuconfig;
+
+	ccode = kstrtouint(buf, 0, &cpuconfig);
+	if (ccode) {
+		pr_debug("(%s:) error parsing input %s\n", __func__, buf);
+		return ccode;
+	}
+	mutex_lock(&migratecfg_mutex);
+	cpuselect = cpuconfig;
+	switch (cpuselect) {
+	case 1:
+		memcpy(cpu_id_list, cpu_id_list_1, MAX_NUM_COPY_THREADS*sizeof(int));
+		break;
+	default:
+		memcpy(cpu_id_list, cpu_id_list_0, MAX_NUM_COPY_THREADS*sizeof(int));
+		break;
+	}
+
+	mutex_unlock(&migratecfg_mutex);
+
+	return count;
+}
+
+static ssize_t mt_cpuselect_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", cpuselect);
+}
+
 int copy_page_lists_mt(struct list_head *dst_folios,
 		struct list_head *src_folios, unsigned int nr_items)
 {
@@ -208,7 +267,7 @@ int copy_page_lists_mt(struct list_head *dst_folios,
 		}
 
 		for (cpu = 0; cpu < total_mt_num; ++cpu)
-			queue_work(system_unbound_wq,
+			queue_work_on(cpu_id_list[cpu], system_unbound_wq,
 				   (struct work_struct *)work_items[cpu]);
 	} else {
 		int num_xfer_per_thread = nr_items / total_mt_num;
@@ -245,7 +304,7 @@ int copy_page_lists_mt(struct list_head *dst_folios,
 			dst2 = list_next_entry(dst, lru);
 
 			if (per_cpu_item_idx == work_items[cpu]->num_items) {
-				queue_work(system_unbound_wq,
+				queue_work_on(cpu_id_list[cpu], system_unbound_wq,
 					(struct work_struct *)work_items[cpu]);
 				per_cpu_item_idx = 0;
 				cpu++;
@@ -276,6 +335,8 @@ static struct kobj_attribute mt_offloading_attribute = __ATTR(offloading, 0664,
 		mt_offloading_show, mt_offloading_set);
 static struct kobj_attribute mt_threads_attribute = __ATTR(threads, 0664,
 		mt_threads_show, mt_threads_set);
+static struct kobj_attribute mt_cpuselect_attribute = __ATTR(cpuselect, 0664,
+		mt_cpuselect_show, mt_cpuselect_set);
 
 static int __init cpu_mt_module_init(void)
 {
@@ -293,10 +354,18 @@ static int __init cpu_mt_module_init(void)
 	if (ret)
 		goto out_threads;
 
+	ret = sysfs_create_file(mt_kobj_ref, &mt_cpuselect_attribute.attr);
+	if (ret)
+		goto out_cpuselect;
+
+	memcpy(cpu_id_list, cpu_id_list_0, MAX_NUM_COPY_THREADS*sizeof(int));
+
 	is_dispatching = 0;
 
 	return 0;
 
+out_cpuselect:
+	sysfs_remove_file(mt_kobj_ref, &mt_threads_attribute.attr);
 out_threads:
 	sysfs_remove_file(mt_kobj_ref, &mt_offloading_attribute.attr);
 out_offloading:
@@ -314,6 +383,7 @@ static void __exit cpu_mt_module_exit(void)
 	}
 	mutex_unlock(&migratecfg_mutex);
 
+	sysfs_remove_file(mt_kobj_ref, &mt_cpuselect_attribute.attr);
 	sysfs_remove_file(mt_kobj_ref, &mt_threads_attribute.attr);
 	sysfs_remove_file(mt_kobj_ref, &mt_offloading_attribute.attr);
 	kobject_put(mt_kobj_ref);
-- 
2.43.0


