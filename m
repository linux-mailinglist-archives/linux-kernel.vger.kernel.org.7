Return-Path: <linux-kernel+bounces-850766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0C6BD3A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66856188F99B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542953101DC;
	Mon, 13 Oct 2025 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z1oX+TC4"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E055F3101BD
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366200; cv=fail; b=WXWG6TerTGvE5YUYhT5BPFsRbyinAxE3sVE0vadFnmkYsJqZP9VhwMi4qTAi+ldswhrG63bWlLXws058b3jiQH1wHv2l/AeOVJY9ad5/l+LX06t97u/TYD9roqMse2s/BT46K7mSeAPgZuEd+HNaOk4BTqUXqKVE6DarSYHrl90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366200; c=relaxed/simple;
	bh=74zPTSod4CoKFGBLkqyJOez2ahI3Uo67EsUEDW+ZaZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PyIhYKqINbwyGZn2m1vUGCiq3J5p1e4uwrBWUZnwOBxMoyxou2BBECz/yrFZ7hrikx6Vfil9A3vEXAksPxrAuSAaoQiF28XUpI198aOPOW/TX4bxz5QiPRVoQR1afnDjy4et8kCwoUEgTSWhwXl+FDhrolNgDd6tHrlXasR7Nio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z1oX+TC4; arc=fail smtp.client-ip=40.107.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gvu1UhCh35l85TebvNKaUhYhxAoHam8UHrfuasdjiueMd1JSDRV0trD/htbM+CVLmLsKqKyavRzQzRsMa6ApAfU06qyrFaaj2CE88/IiGRbS0mvm/qTWNhC15+1HL0bn6pUAG9cKJYuk+t17HTqlRsR++h6GawRkXSMTxI+/6VLmd+ZV6WWT1hpUy5A7SaVojNfq4BjFBQIuubO2intQmw8hbNbH9Sz3RsWpj1l4PIn6MKNHta/K/4zlkUgoipmHXpUrNhcU9P3Gb54m+yOClb+Am/IyDyg3Ke9vuI8BLWCnkm/sR/mUCW5DP8aw0gVtDcU4Mg+XlB/u2gjzp2SoSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3Dw/L+pTKeH8TPtVLB6LVM6wNQcPote4OWrYX7A4I4=;
 b=pZp83ciTGvUrTBz6+9F3IgawHoZvDt7iRuR5Txtd1P5Jj8cnqGNRdSD9NRxOJRx0sUMVUvkIRRoTsD7K2OtPkr/ZSMuWMn28VwvmwDCewQ7EVJeSamy92Pvcdl5vzsAcB7VDmyDQTATGQFOB8TZXxZHXtioYViOwdnLeWQmHNzhJk1TY+doAoYmnRBaYt5I4AXA3Ctx+eJqh0D7oXQMFKtw10necYadliaRxkizXqDcFuADl11x23AL8k26aDhq9v5MO2M+4nFDFajqlejkkK1I50Xrl5OwaenKHwiaibyiIWDg2f9tpD1y4xbXh7W2JW4uQpQBn9mO7+cAPBdjGzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3Dw/L+pTKeH8TPtVLB6LVM6wNQcPote4OWrYX7A4I4=;
 b=Z1oX+TC4U77YrchosRubdr2zVec8baFgp80eYvq18uEKlkXL5pZ28IDXMOX4U2m191CEay0UZEM4PACpHKgOrVw2wFVA1t2zNjQDpMKZTg2FqFL1ZUZ93AhU3epUTadctLH7B3VzcY8tD5RwDEHXx10KtPLb3cc6TX/nC2D5k8Q=
Received: from MW4PR04CA0067.namprd04.prod.outlook.com (2603:10b6:303:6b::12)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:36:24 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::88) by MW4PR04CA0067.outlook.office365.com
 (2603:10b6:303:6b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 14:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:36:24 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:58 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 54/56] x86/debug: Create debugfs interface to x86_capabilities
Date: Mon, 13 Oct 2025 09:34:42 -0500
Message-ID: <20251013143444.3999-55-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013143444.3999-1-david.kaplan@amd.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: 97858797-c473-4de8-803c-08de0a65e286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aJkU9VR+opTSoGP87TXtrZMaOIUl7oIT2hYAsAuRROJJPtorTy/VNw4Ly+1+?=
 =?us-ascii?Q?b+Y3ITShMtJRSno931DPLFVQwbZ7yGBax0eBVRG+CNlqulgrFQeYpsDXWOde?=
 =?us-ascii?Q?w5a7UOjBXdmeNjmUs4+tMGQghhJhw5YipqSsJ3ubaaGBVTAT2SvfToCAz4SO?=
 =?us-ascii?Q?GgdPdOBTWgN6JMQ1ObXD7MVNXfslE6rIlM4Cpai9aRvCfOaJclFuJvZd32bv?=
 =?us-ascii?Q?hzGtT6ujtTpc9zngkD59F0xA2WGEM7yRqmyR1nfKj+tdPFb1h6Bnw4lwfdxx?=
 =?us-ascii?Q?NZMSeEkqaw6JogIPdOD9kO/1iH4W1OLCXlUq+Twiec+af+epDxXCEmfMcggD?=
 =?us-ascii?Q?unoYIPOUBaqtqzegMGGhLcU5mTefiPOYnmqL8EWNkiUQ4+S9vX8Gc/HnQaW9?=
 =?us-ascii?Q?+/ezKr9SxWcNdLMXdqNunsCY2hseq7+GOndOLQkbla2kXtxNn+pDxxwKqmYo?=
 =?us-ascii?Q?o2m9RPnaHP5OHM1p9jPEklysrb5I1r7r7YoJw02QH7x3CV4oul7kqvT4SoCT?=
 =?us-ascii?Q?VrsSSZJjtpFHPn4YpSrS1kc770kYa/NTHxStcIqm8jfhVJYQMUJlRyRLRxJE?=
 =?us-ascii?Q?+2iYbyLX4xSeGPZjDkTWTb+ZykavySKI8XdjhWQO3u0BgnF9CXxo4dL+zBZQ?=
 =?us-ascii?Q?xBAGi1NMygtgVu/wQL966OuDNVuD/Ez/geEI8lV20wikmhaHRurXKWH/n1fW?=
 =?us-ascii?Q?X64V8WMkV7ilhoPp32QbvsEWX8G6EeVAzwPFbOPAZY0IjfqLG84u61sPagXq?=
 =?us-ascii?Q?K2JZM3r5LacWvX3Koh7iza5CE8BPIrAOEs349xMPAED9SpMHWixcEez+fALn?=
 =?us-ascii?Q?BKmn1lyuT6ptOd9S05SBp9x/yAKX3C/NfX1vshjhpxGsiAIjg0nhTKqWZ2Si?=
 =?us-ascii?Q?6w5A4w5wc7P/Y85hs/lQqHNKm74FwGnMLQGQ407L7k+Oozq0J6rmtkLcawr3?=
 =?us-ascii?Q?dJNa50HjgIIylNjmHOYjfLRtMPITrrIDCoG6UzEEwEuAmpPEvPHfx3uV5E6F?=
 =?us-ascii?Q?mycQzlM2FjSzb1gNeYPRk/B2kKulqoqGqHreSdau/1p7kUgwdpG+QeYzj1WJ?=
 =?us-ascii?Q?ApwE5xIcLUNnDXklCyTBYk6buBzj4OSxKar+p9ty+nFwQ4xqv+2pKiuJjTDd?=
 =?us-ascii?Q?FTbqWSFCROUEb1SNn/qmx8wSPophsjoEl1uHQt1EOq1mTwvmvJfpkUKbU7Z7?=
 =?us-ascii?Q?DkwkUtZnpkCVpRyhJVctRCzAamD8mxkxJTymzLxJ4SzEQozArOkLjYoDabms?=
 =?us-ascii?Q?MNa8UT+dhg1z3zvvW2DkaoHIk6pKb9qpy1wcVc6lAXuahCfcLTFli8od8rGf?=
 =?us-ascii?Q?j0tFdh3UoK6jVI6atz/ArOUbNLi3840xEOmmKfmC3LuAKlXc9Ld98qypEHSh?=
 =?us-ascii?Q?avuVjojjxTZtjhY2b34UUQiPuuPaOuAFY3cLByPBKw6KsOrr1EtYkPBzWpl4?=
 =?us-ascii?Q?oYYNu5pERH0Gyd1YMUd+BhwAqSVeMv5beqVQNVTyOcQ9VDJ8Yc+UPba5N5KV?=
 =?us-ascii?Q?uSJ+xFp1VRpIJP49hOVVJwY1W+4l9Z3TOwIllCvYAtSW9eZMgo6gN+WmeRiX?=
 =?us-ascii?Q?znXJhFp6VRpIx17lbP8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:24.0225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97858797-c473-4de8-803c-08de0a65e286
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475

Create two debugfs files under x86/x86_cabilities that enable access to the
X86_FEATURE_* and X86_BUG_* bits.  The X86_FEATURE_* bits are read-only
while the X86_BUG_* bits are read-write.  This interface will allow for
user-space test programs to verify mitigation settings are selecting the
correct feature bits.  It will also allow for testing mitigations even on
hardware that may not have a particular bug.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/common.c | 59 ++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c37ff92aaec2..1755f91a5643 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -27,6 +27,7 @@
 #include <linux/stackprotector.h>
 #include <linux/utsname.h>
 #include <linux/efi.h>
+#include <linux/debugfs.h>
 
 #include <asm/alternative.h>
 #include <asm/cmdline.h>
@@ -2608,3 +2609,61 @@ void __init arch_cpu_finalize_init(void)
 	 */
 	mem_encrypt_init();
 }
+
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+/*
+ * The boot_cpu_data.x86_capability[] array has NCAPINTS of u32 for X86_FEATURE
+ * bits followed by NBUGINTS of u32 for X86_BUG bits.
+ *
+ * The debugfs interface allows reading the X86_FEATURE_* bits and read/writing
+ * the X86_BUG_* bits.  Note that updates to the X86_BUG_* bits may not be
+ * visible to the entire kernel until alternatives have been re-patched through
+ * the dynamic mitigation interface.
+ */
+static ssize_t bug_read(struct file *file, char __user *user_buf,
+			size_t count, loff_t *ppos)
+{
+	return simple_read_from_buffer(user_buf, count, ppos,
+				       &boot_cpu_data.x86_capability[NCAPINTS],
+				       NBUGINTS * sizeof(u32));
+}
+
+static ssize_t bug_write(struct file *file, const char __user *user_buf,
+			 size_t count, loff_t *ppos)
+{
+	return simple_write_to_buffer(&boot_cpu_data.x86_capability[NCAPINTS],
+				      NBUGINTS * sizeof(u32), ppos, user_buf,
+				      count);
+}
+
+static ssize_t feature_read(struct file *file, char __user *user_buf,
+			size_t count, loff_t *ppos)
+{
+	return simple_read_from_buffer(user_buf, count, ppos,
+				       boot_cpu_data.x86_capability,
+				       NCAPINTS * sizeof(u32));
+}
+
+static const struct file_operations dfs_bug_ops = {
+	.read		= bug_read,
+	.write		= bug_write,
+	.llseek		= default_llseek,
+};
+
+static const struct file_operations dfs_feature_ops = {
+	.read		= feature_read,
+	.llseek		= default_llseek,
+};
+
+static int __init x86_caps_debugfs_init(void)
+{
+	struct dentry *dir;
+
+	dir = debugfs_create_dir("x86_capabilities", arch_debugfs_dir);
+	debugfs_create_file("bugs", 0600, dir, NULL, &dfs_bug_ops);
+	debugfs_create_file("features", 0400, dir, NULL, &dfs_feature_ops);
+
+	return 0;
+}
+late_initcall(x86_caps_debugfs_init);
+#endif
-- 
2.34.1


