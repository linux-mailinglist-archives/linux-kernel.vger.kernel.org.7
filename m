Return-Path: <linux-kernel+bounces-850760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A467BD3A44
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D185189F482
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BA630FC10;
	Mon, 13 Oct 2025 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KEvc2bPd"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAFB30F80B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366190; cv=fail; b=fGtM2ImJrbCZE72JgOE71AzJ/Sz6M0AdloMm5dhMvkKu9hilXOl6edKLBIMRbJYUNlHUgr+HQOTja668kECVXzMaI6dLoCCvcTHsw6ppbxVjWdtCftDPtAycBJzsxrhbY4JW933qbnKdEW1WGa/CyZR/U0b+q85g5J0AwWSpXPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366190; c=relaxed/simple;
	bh=HReV30UOFbiLK7t+8yOh9IHXWvZXl1+eVoRoFY1xXw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aeDFYg0K+lNyhfYt+77wSYuGdZ/rXEQMp+wmxsgGn7DClto4M6UrkcOJjt7I95lHuGpYKeyBqlF3ICFuTbdYkcyMyhMQbpx5g98l9pK6mCmMgYtUYoyc05gdgtGsYpTzlwE6fcaMGCMNNi/NkSvyXILEpqFl8e88HiBcvhRdfO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KEvc2bPd; arc=fail smtp.client-ip=52.101.48.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIoEdPVkLo51B9K0Oo3R8rySuaJIeKRbcUcVbkKir/lJdqDCgy0sCfEcowm2lkyGI3yg/SkF4gnwZOSnFEblnhh79Z8IN1BM/ZTVHTS9xHKkkaF/eiJKOsuCv8w84ik3K/4zftRv89zzdFd58W0RaeGumymBRGfZpk/BarZN8fhWgZCC8u7l/7rMOg8HdgIwkI/RwR46JDNBTs0w/bGVNBI2sjgrdo59zb0SSL2FYhPXzXFlD6QJfH1NRO9atrGyCr31w1ych1VAkn/dgqbTdb7EkVppnId9Q++5tVjU0iUNGSkiA9nzQal3r1wvjAwQIEf1KTH7BTzv7v1G/gel1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eALRM1KECLYnou3vIiCCjZ4royw8SXH4Gx22QGRG5jU=;
 b=J1h2xaetxklkPBhlq9aFLOj3BVKrROpN86aiKDvB30+JuZxlFaNlJuWgQIttsFBSsEgXH7DXtF6xMUTVT2ybsv16ByytwXizzYD4gLdmp20DIafsbQ36Bm7l7i8B8gkpmiBCORikrR70kLPbRd3DRvOv2V1e6WhIm+c127KvgS4OeLjaTspV8RZDfc6v7aKnnT1Wsp4KGMn4wd/HBjFiYZP6n3imohaNbPMpYFO2w8iThuP2te4sI2WrrYUf2WXfDQaOd7lBtLjPfTh+9T28nBNzO5DPQrWfoe7QaYvXGm1TBtpHH4UiUIbyRukmp64Eh9crVLQ8p8yP1uwwgHWA2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eALRM1KECLYnou3vIiCCjZ4royw8SXH4Gx22QGRG5jU=;
 b=KEvc2bPdEcF1fkegGS3L7t1MLecfmZX1RrQ8kJz0eDsJvfukW5bKZI/EPUlgKcVmLWFDX1x+rsBk9CjdYNLp9imAvvNsdcREQq0TQRiX81OTlZhPlkxf7AnnlullBawsVPCCdCFIPd2V2DGMMqa+/NkTUdgEVfNd9cVcaH4FuU0=
Received: from BYAPR07CA0067.namprd07.prod.outlook.com (2603:10b6:a03:60::44)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:36:25 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:60:cafe::75) by BYAPR07CA0067.outlook.office365.com
 (2603:10b6:a03:60::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:36:24 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:59 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 55/56] x86/debug: Show return thunk in debugfs
Date: Mon, 13 Oct 2025 09:34:43 -0500
Message-ID: <20251013143444.3999-56-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 3208866a-09d6-411a-31ba-08de0a65e2f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WornSYJDTmuyGVWqak8+eTKUBgfAs0YIP9FyMPyaS3uHvUBQYrIjr/S1Q0wB?=
 =?us-ascii?Q?6lRAmxjyb2qk3CcwA+DhqPu0M/sJ2AZ9esclxIBNzrf1x33o12MMKNeilE2S?=
 =?us-ascii?Q?+SeKtlYhovCYmGJJQd1C8OoqLuNlNIyIj4RjX4xHJDupcBuE4Oi04uCYmUeA?=
 =?us-ascii?Q?py/K1BuHzIlAFHv2OABuneBJmYOsG3AzUrBmYMh5TQ67CmrDpLJDMYMNrGQA?=
 =?us-ascii?Q?dOtbyXhwY/xzGvQ8KN9GU4UlLz76Xv54ScfmV6aAtPK1qym3hqmk+K1gNMny?=
 =?us-ascii?Q?cgLQxpZ/xrAiTcHOccH3M87o6Ot+wLHgnCsMNGtSgWqpFNDy1rwM6y11vp5y?=
 =?us-ascii?Q?wmNlujqnSVcWfJYapPN9FH0/TmpHcolNIqWdma7PPW/2ShK0YfHH9SR5a40b?=
 =?us-ascii?Q?xBUMS7Fy2t0B5Dus3kczpPIIGjlQOK3TjalHxxlY9LIe55nrKFSxFzubJuFT?=
 =?us-ascii?Q?pBbHGJBuWJYQ9hGkic6oU2hyp36a7Idf1KdBl6RgaEnlIh+lf0LqVLkMXuu0?=
 =?us-ascii?Q?ACYxfCPLTeBBn5vmh9im6jBy6fOxzNN03jlDEeDs7mSR+ksU6qaPGME1spKB?=
 =?us-ascii?Q?EapZvV+IyFPkbAsYg/ImiUTJ57alocsvHqoxiKdXogfTZsh3CainBeIIiz8i?=
 =?us-ascii?Q?KR7FDdAb+NENo0s203C4ZA0DjG5yhwQ/UcszB0x2myJzJZ2TMAM3VAIeI3W0?=
 =?us-ascii?Q?oxbrEyMj4c0Wymobo+htcnKB6WmGKZjQJ+UmFs5rDeGmg3N2vT/FFrfE1ppY?=
 =?us-ascii?Q?3UNtATS8nK6YiLm6fmCEgAHxTXY5HwgzuLWYqVl/XIXubO7IuzLz0guL7OQQ?=
 =?us-ascii?Q?6Dl2b9/qcUxwmkfP8IKu9fAxWicPSfs2UvVmI79K+9h3imjLsbAqeWplz5YU?=
 =?us-ascii?Q?NtaRbzPoWdkeq0ZT33F2UDlKjsz8AnOQxEvWvCyPOzjzbYw+6ID0RLRC1n4p?=
 =?us-ascii?Q?yyngRR7mDIs9ugVW4ugR8SUa727ZCcytcJNLQPmWEYCwGL7cFmwnVOzzf7OU?=
 =?us-ascii?Q?ZnyCWUG12GYL1xBHXPyEQhrtRXbXzEfJ6/obt2iqKuFfir9BhsRi+Glkh/qN?=
 =?us-ascii?Q?f1K5SWK5bfg4if9YcvBbFC2cHP3rhVxTNsO7YC5d/ualCRZfufszUs5Vmo9A?=
 =?us-ascii?Q?Xjehbhw0kvAIXlM6B6hMxwQr/W7XVqxlLAwD1QhEEJfXWrPOUmD6Mb29s/Ry?=
 =?us-ascii?Q?moXgZeYsjNvBKobWiV/x0S54OcDeeVIc3Ls5RCn55WGcLw8kiER8D/TcCyab?=
 =?us-ascii?Q?MiKBzujvpgpMHNFgGhmtLDNnyfp9dnEeTmUN31Wq46kJmkRQZdtruQwcAtoJ?=
 =?us-ascii?Q?aHbH3OETYyIiYxhuB/q5elyFJj1jg26c5AkMdu4Hh1Thw1iHvLy9ZBplIFvO?=
 =?us-ascii?Q?2eulCKtKm/h0AsoZ709ykujVWcnzi8pB6t6XuOepHG7OKw/3UMYRthVxZzSF?=
 =?us-ascii?Q?LlnebNgCY8WGoKbS4hIE0d1Ek2GX2l7HB2k5Xwo4MKgSgqD7nLlDOtV/CTiF?=
 =?us-ascii?Q?XrEJSGCO0ASUMF9J3nSXKLS1ckCtvCtLU/QOYnHKYss3FMau0c1eOerTeu1z?=
 =?us-ascii?Q?iFk4sUwUXtyFJ0fti0k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:24.7744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3208866a-09d6-411a-31ba-08de0a65e2f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896

Make the value of x86_return_thunk visible in debugfs to support user-space
testing.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 26ceb42e0cfb..8365448b3aef 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -16,6 +16,7 @@
 #include <linux/sched/smt.h>
 #include <linux/pgtable.h>
 #include <linux/bpf.h>
+#include <linux/debugfs.h>
 
 #include <asm/spec-ctrl.h>
 #include <asm/cmdline.h>
@@ -4065,6 +4066,49 @@ void arch_cpu_reset_mitigations(void)
 	tsa_reset_mitigation();
 	vmscape_reset_mitigation();
 }
+
+static int rethunk_debug_show(struct seq_file *m, void *p)
+{
+	if (x86_return_thunk == __x86_return_thunk)
+		seq_puts(m, "__x86_return_thunk\n");
+	else if (x86_return_thunk == retbleed_return_thunk)
+		seq_puts(m, "retbleed_return_thunk\n");
+	else if (x86_return_thunk == call_depth_return_thunk)
+		seq_puts(m, "call_depth_return_thunk\n");
+	else if (x86_return_thunk == its_return_thunk)
+		seq_puts(m, "its_return_thunk\n");
+	else if (x86_return_thunk == srso_alias_return_thunk)
+		seq_puts(m, "srso_alias_return_thunk\n");
+	else if (x86_return_thunk == srso_return_thunk)
+		seq_puts(m, "srso_return_thunk\n");
+	else
+		seq_puts(m, "unknown\n");
+
+	return 0;
+}
+
+static int rethunk_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rethunk_debug_show, inode->i_private);
+}
+
+static const struct file_operations dfs_thunk_ops = {
+	.open		= rethunk_debug_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init mitigations_debugfs_init(void)
+{
+	struct dentry *dir;
+
+	dir = debugfs_create_dir("mitigations", arch_debugfs_dir);
+	debugfs_create_file("x86_return_thunk", 0400, dir, NULL, &dfs_thunk_ops);
+
+	return 0;
+}
+late_initcall(mitigations_debugfs_init);
 #endif
 
 void cpu_bugs_update_speculation_msrs(void)
-- 
2.34.1


