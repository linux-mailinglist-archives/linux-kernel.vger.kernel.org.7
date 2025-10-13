Return-Path: <linux-kernel+bounces-850762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B471BD3B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EBB0402365
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFA630FC23;
	Mon, 13 Oct 2025 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k3qIVHWc"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D22230F814
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366190; cv=fail; b=j8J3bxL1ZWCmT4u8h56R81yEG5ovTUQlIgOUQB90NPlScY7VX7GdsSzqhPbmlSB56HV1GY1gYAFo4zbLCnPhu01gNzek7r8oWS5n3ZYlt/B0BeCEVXiGo+kqYcyQndQtlj2qUQkTm72qkPK3f0Bv5viAOogn4AxYb/hmYlwe/t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366190; c=relaxed/simple;
	bh=RHcBmdsABVJE53SAWwu/4MfIqKbpZLNXER7TChbpDG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clFZRKO7ERcO6ypb+QOI5iQ72gdydXH9fk4VVYclhNNMHAg1JMbJLTj45Jg6mW14B7WjgU8pGlSsJaP7Jb6bnsyHwrco/gRaq0zkB599XddBODDY6CoWYfCUBJMMPwtgrc6jzjg25YOHl89+4UTa6ojyoFm1jFD1FVOQ99/m5Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k3qIVHWc; arc=fail smtp.client-ip=52.101.48.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lzf8+PhRaMr9F/aUndsv3rNMyfE6yvXC+GpdakuBhrjxq9XWkfUmu4S0eC0CfQ4bZlJSadrqdg+2v9V4zF9yfGz0WzAkCHGmsDN6ov1K5T7YFIhE4rYVdQjb2WHrgwDeMbqchde4GvwJ6GhTPXtANz+BT+gouSWfCnHVEH2ZkLxcrzlJ0ucPLT+LhlKTv40zaGjGudEA3PQXsmrn9KwmgMCNrwwunU7G+rHp6q1scxfemEHNZsqn6LoOD698WpBlMth0lYIH7sopbUbIaOc83YRcjdK73P1gQPpZ3YJMEFNhaqUs0S3uXngLbsuhDGGTo5T4U8MapTsv0/3dE61hVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkkDpjoqg8u3YC3zDlW397pJcnl49MVaAJ0my+llZ6o=;
 b=a6RUsSJ7DmYygmWhRxFU9l90hVfGzoCTMl81Mz5EdzTq+y93ni+yt7aygL9Ttv5DTOocgKw77EkmfPLsf9LLHxJN5Dg88JIMhs05OM4CrzyIkuB5Jvhy7Y7kKV9UUpvjcxgndOalG042yGOUc7EEXPMYK5XIN1oErFwRu4HMjI98h8X/j+ET8WF7pQQ0y8bgsKNh2t4DLaGm78siyWTTT0CnVnlaqjslocjElX4B7QTy0qfouZRV9poMw06JBPcO1DPyi/qdKxLjo8RBl+poLhzgopYwwljwSccIwFdCcJ7tOSiov+jLEENvNyezhqMi60BddqylYge1LbB+odykjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkkDpjoqg8u3YC3zDlW397pJcnl49MVaAJ0my+llZ6o=;
 b=k3qIVHWcKI96Ap4LBTWUmK41T1MgUOTDuqp8Uyh9jaxvtA1+T5r33/NYCJLT11CWutMjZCAuL7qjZRahYVJSM5xqTHvzry54Pz2Yc8q/1/D8pXTbbwfAygjslfNhFh0wMzPUMnrdf/OXDWZA5BC6DCmuFBThD6TStcpRNgnKodQ=
Received: from PH5P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::17)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 14:36:26 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:510:34a:cafe::4) by PH5P220CA0002.outlook.office365.com
 (2603:10b6:510:34a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:36:25 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:36:00 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 56/56] x86/debug: Show static branch config in debugfs
Date: Mon, 13 Oct 2025 09:34:44 -0500
Message-ID: <20251013143444.3999-57-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ed405a-b8b8-46c7-820f-08de0a65e354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WY9Jm+bK0ov8bB8hYcBUfxCm04z2Pr/I8Hez/1nSu06DMY5CpTih7gaqalq7?=
 =?us-ascii?Q?snQedutMqyp69xXm35vEOjGvNc3tva5A+y4PQQavlgnMSKfLeYkiAryDJKem?=
 =?us-ascii?Q?rIsgxuZFv+ByVoQg4TLMRgJ5rUvN0MA04iPQpb2Rtnl4vyFn80VIYkmVSlYt?=
 =?us-ascii?Q?Mv1x249gR6QmveYMBisLJ6g9NSAEPU0T2kFrjwilVnN1TGp7ugb3ErlE8OWJ?=
 =?us-ascii?Q?ZQoe3gQvZgtE8hVyL+VjEmJ3yoCYVYtart1YHbvgCRVMe0O9NcWdrpxU+r3L?=
 =?us-ascii?Q?tVNrD0buHJhyDw5vEGZGLojltR9Z9mga9/+Fj4fgWRdqhI6gtY/M8mPNFRLf?=
 =?us-ascii?Q?pdjiOyDTr2bGlZ7oA0FMlq6mGi3zjz0zXrbdew8hcSjtnhL3nMTxXGYG+6o5?=
 =?us-ascii?Q?JL864Q3zyDAn4okPEtEd9qZYofu5EDoSsWTorcxWa/sFKi0MwDZh0MFr5zdq?=
 =?us-ascii?Q?SqQqRQTlnmtNdf0xbHIQ9yQia+8yHrglgw/CZWL+faX865yDbnaBIhOcEF4L?=
 =?us-ascii?Q?PdLYIAFW8AWLPeeRciIh7AZzsovBziGi1NMTrmknockrRm7rYHS1HwFDt1AZ?=
 =?us-ascii?Q?zG9zSYbokcu6JNvI+TH9d327n2B9+WxW6Nr43zI1nBBrT/2+/juz/qH3IOKT?=
 =?us-ascii?Q?TJWZrvCy31xOgPZer1XP5PpijzDjni3iu/u8bKkGnQ4ztz88IKESUM1RpTNj?=
 =?us-ascii?Q?1qX1ZKQVuomL1EQXcA5qsGli6/7iUQ+9juD76Pfp7VPFDERNcHqdUt9LaiRY?=
 =?us-ascii?Q?JdLg1QwGdUrjyzb3Q+PCdhiXaeQUVEkcx1Ia6tdlVL3nzBqO5+hb3NMQXixx?=
 =?us-ascii?Q?4WjrwmBm9ohA2MacYP3NtkbHW67GZqow0mLFQ8yGOIF+cMNcaMXTyhKc1DEq?=
 =?us-ascii?Q?71i7BvcnqRa7C+1btxMcnrbcOlFNR5DZtgrQm2BsDLQ/hrIINCHDkUgRbmL/?=
 =?us-ascii?Q?GoLa9FGffT4d0u32Uw0HtzBECo+6EjL80wsqEwknWTNJ65biWVpPDPov5kh5?=
 =?us-ascii?Q?U/A689ieHx5+gCIIoW9E//yGKVL80i9uiYUNb/uWvp/GyfKzBjS4gJ/g3/52?=
 =?us-ascii?Q?A8cBLPXj9N15Hun+wOxCUfft2Ck3p37te4L+WdSiwlhFQxMEvQ/xYziucdRP?=
 =?us-ascii?Q?+n4Jy9jr8TbIPVap6T9HwRj3pruxFXAeiZkWohZACU5P3LYObcLwDMZFKHYL?=
 =?us-ascii?Q?IRi5jYn0sCXlBv8epxY1Iu4KQzbSTPepHsIoTDXU3op4ttMUHMCUyZZD0Y5O?=
 =?us-ascii?Q?kQGMAKxgnTQzlEEEYoavYY4mDGkBFVzLnYy3xAIG3ZnB89Xa+N9f+lNbIBxE?=
 =?us-ascii?Q?RG1asWG5coXzV5ghgnyYiIUaX68GSR/W2DmEZbWZtLd95Bx49GyKrWMhKaeP?=
 =?us-ascii?Q?mFsgxxh7EkPufnkD7TeyKp3BXVh1Re+mQ9hwqx9F3a4lC27o9/EhgeiXdaEb?=
 =?us-ascii?Q?516kidDu4cATMwlMmYRjBtX4mvCOOeY4bo7hKG1DOB6CXgc/PH+XJXZjvhB1?=
 =?us-ascii?Q?ANQ9mXvdnRHI7ABG9dB+DOgPdQamxi/N9g3xDgYgnGKadj3NF+PBL/gWCl+4?=
 =?us-ascii?Q?nLPaKXvG0yaBTqQwCT4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:25.3738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ed405a-b8b8-46c7-820f-08de0a65e354
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188

Create a debugfs interface showing the current enablement status of the
static branches related to mitigations.  This will be used by user-space
testing tools to verify mitigation configuration.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 8365448b3aef..eeb7d50332cf 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -4099,12 +4099,44 @@ static const struct file_operations dfs_thunk_ops = {
 	.release	= single_release,
 };
 
+static int static_branch_debug_show(struct seq_file *m, void *p)
+{
+	if (static_key_enabled((struct static_key *)m->private))
+		seq_puts(m, "enabled\n");
+	else
+		seq_puts(m, "disabled\n");
+
+	return 0;
+}
+
+static int static_branch_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, static_branch_debug_show, inode->i_private);
+}
+
+static const struct file_operations dfs_static_branch_ops = {
+	.open		= static_branch_debug_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int __init mitigations_debugfs_init(void)
 {
 	struct dentry *dir;
 
 	dir = debugfs_create_dir("mitigations", arch_debugfs_dir);
 	debugfs_create_file("x86_return_thunk", 0400, dir, NULL, &dfs_thunk_ops);
+	debugfs_create_file("switch_mm_cond_ibpb", 0400, dir,
+			&switch_mm_cond_ibpb, &dfs_static_branch_ops);
+	debugfs_create_file("switch_mm_always_ibpb", 0400, dir,
+			&switch_mm_always_ibpb, &dfs_static_branch_ops);
+	debugfs_create_file("switch_vcpu_ibpb", 0400, dir,
+			&switch_vcpu_ibpb, &dfs_static_branch_ops);
+	debugfs_create_file("cpu_buf_idle_clear", 0400, dir,
+			&cpu_buf_idle_clear, &dfs_static_branch_ops);
+	debugfs_create_file("cpu_buf_vm_clear", 0400, dir,
+			&cpu_buf_vm_clear, &dfs_static_branch_ops);
 
 	return 0;
 }
-- 
2.34.1


