Return-Path: <linux-kernel+bounces-769192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A961B26B28
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2BC74E5FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE841A5B8D;
	Thu, 14 Aug 2025 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pk3n6CEr"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306121B4248
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185751; cv=fail; b=bOgclgOqvtIiIPEBy031a+OJDFVRBa9LgNdHXg/KBM4ZUGuV/2BZPgGRTuziuHOgocYrzWOxug54rndWIAwutNAy1WwQvVKpjjb2x6Fvs/xKincKkODbIF7CtNJilbFGgTCGVyWh3Ba4Y4QdYMcTJfZpXBhVr2QYKkhKSAooXlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185751; c=relaxed/simple;
	bh=C7d7hJ57HNZRrRBCAGn9KzPkOtc8thPSB48IloYKBy4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwgkUNcRFfzMYA2vBBd1VZxMcXXOb/DmbbDxCOuIfE5v0BRfmdYD98xyw1LTNFbxLVmCK6F1e897vtSEAwD3kMuifRMjR5ozijdvrRS1oZa/BU7De1Ta5Ri5wuOZc/+Q4tlBMwFhHjMDVrkbLcNMXtel69fNHn5Up2UtRb1Sztg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pk3n6CEr; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrkZCU0dvGnL6qIuk0DUxxzktuN0bNe+Aq5VZlRR1YmMlX+T65cvfFYI0m8ODar9Wh4mz6nGPtNBhQhVohNJCzzPJCEs/yEWQzcwpPljKU4yG2Th8zXnVV1dMRUlyFw8OysfEITO5TT3GlJ6ArS9mxnbfd9IROpwE9fNlY19D0ku4rAveXf35nimXtMG2uLwRys/10NbbY65IuUldviVrG5PsKZ4EydLamzPSAVAb+jezOygvkGtKUIAQSi/fSdcO1i8pH4uAjB8YhT0jkmP6mbS7RFjY630gd5MR+4I9lgXZNQ15fkQ1J4gN5PnHtYdB0t7w9sch7ucQLNWHTPvhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPvvE3+n2lSKn62J/m3/DT43sgyaoQup32DsQYT/oXE=;
 b=XvlCnk4vHVVWFRzX4QpA9Ebvj5rPH1D3q+gheT2umazdTFp1ZQKxY3bP3ZHrI99cC9038NL1cPmAzY+MmLlOw06V4Yva1IuZCVPoVj8Xe77CxwDfpGLRoRTvt7iL3o8a+5dO5M5hXCojVc4/5tNbIe6I5pE2UqoPwJDC6d1IgtZzjMrjqfQfYpJknpP6MAuXNbb6ApPwn5DRWGTG3qVuL9FISneb3FKGJJMSklNDT1Iku5B3sPizXutely58KgcgC1d+DhqXxDC0sa+ARCyOFOEeD29EyVwLIz4upFp0uvBAJo5xXymQdfZcZGTDkZkuxdDDBcigVNEdl2DsJqSZBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPvvE3+n2lSKn62J/m3/DT43sgyaoQup32DsQYT/oXE=;
 b=pk3n6CErenQsOMAioHNtTcCJYuzK+vjvU0ZJ8AfTiVo0+nxJfY1fCQtpyKb7XIJlPT0/IFHwPzzUu8spOsBL33xmzHgCkPoHI5/N+pJpc6rSl4GgfHXxHitwz3N34l+LA4/G7WhlDqJreFDIJadzDxajbZsJvXD+Z+cP4+HN9AA=
Received: from DM5PR07CA0064.namprd07.prod.outlook.com (2603:10b6:4:ad::29) by
 CH3PR12MB8076.namprd12.prod.outlook.com (2603:10b6:610:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 15:35:43 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:4:ad:cafe::c4) by DM5PR07CA0064.outlook.office365.com
 (2603:10b6:4:ad::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Thu,
 14 Aug 2025 15:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 15:35:43 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 10:35:28 -0500
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
Subject: [RFC PATCH V3 12/17] sysfs: Add sysfs support to tune scanning
Date: Thu, 14 Aug 2025 15:33:02 +0000
Message-ID: <20250814153307.1553061-13-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8e64ff-ff82-4a95-0f12-08dddb483b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fqXDWItc6tuJHbNP/b9NTlYyhtgPiCdjveOcq+z/fPlE5btmWKFPVAChdAdt?=
 =?us-ascii?Q?PtJgB+PiY6zoiQKko2Moz75ED1jkb2jp5e+1ulF/NWpEKMzJgAtNrw0Zm57x?=
 =?us-ascii?Q?TqImSGpdM3gw+z5mOABF7k6vnI1DHy74sSIYxxBZRSrsZOafvraz41VdYKTH?=
 =?us-ascii?Q?rniSsA5lreE+cLhCqjbwFJAmqsbkrhKVe4yTFEZakehsusXa5/8K+mIbuf4C?=
 =?us-ascii?Q?7U7u1mU5ElP37SFDuBWNIrGlB4aMv3wDXbfpP0FVoil5SGnxSPKkQUeUgWLf?=
 =?us-ascii?Q?WlREH9Uh5QpG0gJm/YkOcYqFPtVcSk09u8K6erD7vPliCw7Nqb2nonjy5sc1?=
 =?us-ascii?Q?DKFhRY6Z/WfaMX4GPc87n/DpnFL6mKdVNASZWGR5MdjzuLARs8+5r+qmLxGl?=
 =?us-ascii?Q?bYLKzabtfZO1CDDyLx7vqnwyDNhical5r0RG8QlnrAyYEE6KGM1HM2WvPKZ4?=
 =?us-ascii?Q?kzA5y0d+dsBt+GN9SuCNIwRJ9sR2qD1lkMJ32MAthH8IRt1LNUdRQSQghqyl?=
 =?us-ascii?Q?i8hqgGIH81+6/qO/7wOT8M/h6NGQgnvEYoVxElv039dCBoj45gtya9cInNnv?=
 =?us-ascii?Q?w5xa0NphpduJ3Gd1bhLlM6rNOuhejDLOik8qqkvgjKpAEYnlbCs3PIWE5MHZ?=
 =?us-ascii?Q?78KLFk1VvnfrGobJNo/kGzXeTbGPi2ecoUZvS/aVSkdARClzCjFGWHBWi97M?=
 =?us-ascii?Q?y0SUtlgPzVYZ+hTkZPH07zycqAEw3fbd/T/Zcm5n5aPMgF8qOEi8CCclcruy?=
 =?us-ascii?Q?Z1nw6NYFFKqmwLjZMyDDtL/uGwmuISw0rIbZoOtYFpL5kv8fID79kTCngwhC?=
 =?us-ascii?Q?DvpOtjYaJ9lnCJcD/tBfG0yNfvjPp55FTCLtVSSC6Cu7SUCDJyBNIPsiFloK?=
 =?us-ascii?Q?OgjpeZXohNIEJ/FCPvxGBhX1NzHSuB/CIgQnNrFi1RjVEom4Zvly5OhfrOid?=
 =?us-ascii?Q?BvWB9jxN0w9KaQPCcF2R+rcJ4Db2ZSmPBJut5Bkt0m63oXmfCzkTW0Lq+VBH?=
 =?us-ascii?Q?BKh3IdVjNMp4rMN1XZUQFqMyakasmZDwKLBLGq4/yuGmGXi4/GP6V+AmisZH?=
 =?us-ascii?Q?ocD6Bi1c7rfoFQsGz7p+iD4Ex3l1jw/vfhSAb2DmT5aJFzVA3qc/dgIDAxAp?=
 =?us-ascii?Q?wdzO4Si2uAxa5OCniZ80neDkvMvpLFn8lpBDop4Zp/jiA8KHfEpWVzhXafyP?=
 =?us-ascii?Q?Bt4DEqGijr+Ev9skO0qi1JuX7hkYj4YOUDEBQrS/dP36komeDqV2ZF3Hyaom?=
 =?us-ascii?Q?Ojayla4jsfpFuyBcN1PP5uHQ+ouUBgKMA5jMaBZ33FAq8gZH8cXVdquN81ER?=
 =?us-ascii?Q?IXpgmnoN+WJXBa3MchauBj7RGi1Hj5eP2YKltLIjNYA5tpkPuRnp5KK0MJYH?=
 =?us-ascii?Q?0UJIbpBy+szHvyDJuCEkRDok5mNyAzxuShjZ7EdFxmLfIGYJFbVyJReaTcyj?=
 =?us-ascii?Q?RzqzBjdBAB2WeqVAVzdKv8Yso19vggwRibJKtTac/wpA/PMO6slgKPfVpFJ3?=
 =?us-ascii?Q?0Dc0mdY5QxvG4izEMdq8K1wXRqVk+9pSlbcv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:35:43.6135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8e64ff-ff82-4a95-0f12-08dddb483b63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076

Support below tunables:
scan_enable: turn on or turn off mm_struct scanning
scan_period: initial scan_period (default: 2sec)
scan_sleep_ms: sleep time between two successive round of scanning and
migration.
mms_to_scan: total mm_struct to scan before taking a pause.
target_node: default regular node to which migration of accessed pages
is done (this is only fall back mechnism, otherwise target_node
heuristic is used).

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/kscand.c | 205 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 205 insertions(+)

diff --git a/mm/kscand.c b/mm/kscand.c
index 41321d373be7..a73606f7ca3c 100644
--- a/mm/kscand.c
+++ b/mm/kscand.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/cleanup.h>
 #include <linux/minmax.h>
+#include <trace/events/kmem.h>
 
 #include <asm/pgalloc.h>
 #include "internal.h"
@@ -173,6 +174,171 @@ static bool kscand_eligible_srcnid(int nid)
 	return  !node_is_toptier(nid);
 }
 
+#ifdef CONFIG_SYSFS
+static ssize_t scan_sleep_ms_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%u\n", kscand_scan_sleep_ms);
+}
+
+static ssize_t scan_sleep_ms_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	unsigned int msecs;
+	int err;
+
+	err = kstrtouint(buf, 10, &msecs);
+	if (err)
+		return -EINVAL;
+
+	kscand_scan_sleep_ms = msecs;
+	kscand_sleep_expire = 0;
+	wake_up_interruptible(&kscand_wait);
+
+	return count;
+}
+
+static struct kobj_attribute scan_sleep_ms_attr =
+	__ATTR_RW(scan_sleep_ms);
+
+static ssize_t mm_scan_period_ms_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%u\n", kscand_mm_scan_period_ms);
+}
+
+/* If a value less than MIN or greater than MAX asked for store value is clamped */
+static ssize_t mm_scan_period_ms_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	unsigned int msecs, stored_msecs;
+	int err;
+
+	err = kstrtouint(buf, 10, &msecs);
+	if (err)
+		return -EINVAL;
+
+	stored_msecs = clamp(msecs, KSCAND_SCAN_PERIOD_MIN, KSCAND_SCAN_PERIOD_MAX);
+
+	kscand_mm_scan_period_ms = stored_msecs;
+	kscand_sleep_expire = 0;
+	wake_up_interruptible(&kscand_wait);
+
+	return count;
+}
+
+static struct kobj_attribute mm_scan_period_ms_attr =
+	__ATTR_RW(mm_scan_period_ms);
+
+static ssize_t mms_to_scan_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%lu\n", kscand_mms_to_scan);
+}
+
+static ssize_t mms_to_scan_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return -EINVAL;
+
+	kscand_mms_to_scan = val;
+	kscand_sleep_expire = 0;
+	wake_up_interruptible(&kscand_wait);
+
+	return count;
+}
+
+static struct kobj_attribute mms_to_scan_attr =
+	__ATTR_RW(mms_to_scan);
+
+static ssize_t scan_enabled_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%u\n", kscand_scan_enabled ? 1 : 0);
+}
+
+static ssize_t scan_enabled_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	unsigned int val;
+	int err;
+
+	err = kstrtouint(buf, 10, &val);
+	if (err || val > 1)
+		return -EINVAL;
+
+	if (val) {
+		kscand_scan_enabled = true;
+		need_wakeup = true;
+	} else
+		kscand_scan_enabled = false;
+
+	kscand_sleep_expire = 0;
+	wake_up_interruptible(&kscand_wait);
+
+	return count;
+}
+
+static struct kobj_attribute scan_enabled_attr =
+	__ATTR_RW(scan_enabled);
+
+static ssize_t target_node_show(struct kobject *kobj,
+					 struct kobj_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%u\n", kscand_target_node);
+}
+
+static ssize_t target_node_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	int err, node;
+
+	err = kstrtoint(buf, 10, &node);
+	if (err)
+		return -EINVAL;
+
+	kscand_sleep_expire = 0;
+	if (!node_is_toptier(node))
+		return -EINVAL;
+
+	kscand_target_node = node;
+	wake_up_interruptible(&kscand_wait);
+
+	return count;
+}
+static struct kobj_attribute target_node_attr =
+	__ATTR_RW(target_node);
+
+static struct attribute *kscand_attr[] = {
+	&scan_sleep_ms_attr.attr,
+	&mm_scan_period_ms_attr.attr,
+	&mms_to_scan_attr.attr,
+	&scan_enabled_attr.attr,
+	&target_node_attr.attr,
+	NULL,
+};
+
+struct attribute_group kscand_attr_group = {
+	.attrs = kscand_attr,
+	.name = "kscand",
+};
+#endif
+
 static inline int kscand_has_work(void)
 {
 	return !list_empty(&kscand_scan.mm_head);
@@ -1231,11 +1397,45 @@ static int kscand(void *none)
 	return 0;
 }
 
+#ifdef CONFIG_SYSFS
+extern struct kobject *mm_kobj;
+static int __init kscand_init_sysfs(struct kobject **kobj)
+{
+	int err;
+
+	err = sysfs_create_group(*kobj, &kscand_attr_group);
+	if (err) {
+		pr_err("failed to register kscand group\n");
+		goto err_kscand_attr;
+	}
+
+	return 0;
+
+err_kscand_attr:
+	sysfs_remove_group(*kobj, &kscand_attr_group);
+	return err;
+}
+
+static void __init kscand_exit_sysfs(struct kobject *kobj)
+{
+		sysfs_remove_group(kobj, &kscand_attr_group);
+}
+#else
+static inline int __init kscand_init_sysfs(struct kobject **kobj)
+{
+	return 0;
+}
+static inline void __init kscand_exit_sysfs(struct kobject *kobj)
+{
+}
+#endif
+
 static inline void kscand_destroy(void)
 {
 	kmem_cache_destroy(kscand_slot_cache);
 	/* XXX: move below to kmigrated thread */
 	kmem_cache_destroy(kmigrated_slot_cache);
+	kscand_exit_sysfs(mm_kobj);
 }
 
 void __kscand_enter(struct mm_struct *mm)
@@ -1421,6 +1621,10 @@ static int __init kscand_init(void)
 		return -ENOMEM;
 	}
 
+	err = kscand_init_sysfs(&mm_kobj);
+	if (err)
+		goto err_init_sysfs;
+
 	init_list();
 	err = start_kscand();
 	if (err)
@@ -1437,6 +1641,7 @@ static int __init kscand_init(void)
 
 err_kscand:
 	stop_kscand();
+err_init_sysfs:
 	kscand_destroy();
 
 	return err;
-- 
2.34.1


