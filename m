Return-Path: <linux-kernel+bounces-850750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD31CBD3A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE8F84F6F60
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7A130EF6A;
	Mon, 13 Oct 2025 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UcA4djS7"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF8230E82C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366182; cv=fail; b=VktH4a8tKbUMIuxWT2qxxW4aqiJPBTL/u7SzRh8+2r+RFaHM8Cg7W15LEULxQAHTLO55D/TY+vvQqLBGUFp6z09qzYaurbSx17DfqtHJ+dSw/iLtQtmjTFEpcBRnPheaXqUTnbvqxhlPkVcWMG/9WXTj9Wd5hToUoWJTtW2Bb08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366182; c=relaxed/simple;
	bh=5G7l9JUYmntHx+7Yabm1OSNenCNXRqYfUzavIPa0UmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETInCtAW2kW5sx/d7njsWh16Sqj4/fZSoXMxZLSkUc4gfD3de2N/pYTxLTNvs9QKqJn4GHoDbk9z3UbyHPAb3/OWYqEhoJjVtrrc7F9AugDJdnmSsmi8FtPJtyiVcFXlTzHlxDtKaXCXYFr/0i1rSblH+FyWIKX8W10Fi7dggbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UcA4djS7; arc=fail smtp.client-ip=40.93.195.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GE4ILI3hjm4Je40DyAkFvACdEXNtSwqlRVtXtc5+QIIlBqHGOiJ/7Vl/PwxTGJDnVxZ++/j02sq4HTAYbr+WE5lXSPMMjl8Q+9lJuqIC9yOpa68deFt/a9oTr366Yn8QSD/tCQPWDNMfjQOikd7wrwet9CaB2yYaj4U4UtcCj4tFV9S3U43efnbTqyhDL21K/Di+iB/larXWo+573KxvPKRfE2SLRXYNfijVPzG+YwW7RGiHP/or8zbmAVaxZu+3CxqoZPVV1gIIE6A4wUmIm1JQHaBGrIltqzZWmcXa3ZxfE1pcJBJuIaOxRZzpjiOI5eURaULmKfwgjRlWhjj1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyfdNk6a3GZiEgtlb/LC4s5swYUssHt69u3w5wX+61c=;
 b=YEadReDiw7272hFvlN9fJo8d724FxvVcfLwDWuQqJ5pBW55Swaa7wJqLKllrqqnCYILwVrKitltzgV6bltoYKzodyM6Dc9h+xFUGXtTWWGSVFg0EYrl+i4wI2xEmOdp2EOvxvABBRlY/JUbsG1LEyzA6Zxx89Vnm+ekKtIp3i/Bm3FIMa3EKnlw34rat+SKzKSFnKDHrMQp+SxvCxWcgh6od4dbs1khwWlFAGZWmTbv1HbrlHSTNaiBqG0r9YMYm1jMx/itFiVxiOCDji1rn6DRFlt5xDd7O8HM/UCg2NokMLo6X4M4S51WHMSg9OCBij98iSRmQikNkgRMwCtGbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyfdNk6a3GZiEgtlb/LC4s5swYUssHt69u3w5wX+61c=;
 b=UcA4djS7Wej+3XyoCTIEPoS85UBKJlUvpoSmrlzMaThmleq4W6kViMPLw9eEtRWoT3TauqKGfO858n0D+SIfHnMnbkv34WadZjmTGrtFc28q2KhPX8dJez86bBtZd/FM0jW1FHHvr4jk3IU++eL464ZZ8grXyyhUCLLeQqHnmfg=
Received: from MW4PR04CA0065.namprd04.prod.outlook.com (2603:10b6:303:6b::10)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:36:17 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::e7) by MW4PR04CA0065.outlook.office365.com
 (2603:10b6:303:6b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 14:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:36:16 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:49 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 42/56] module: Make memory writeable for re-patching
Date: Mon, 13 Oct 2025 09:34:30 -0500
Message-ID: <20251013143444.3999-43-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: fce2c61c-0482-4f95-f5a8-08de0a65de4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sV+hBKsn7TUUQ7YGGMPibyXGQzZykAXXX8/loCpbxUBnQz4HcU5nPW45pp7l?=
 =?us-ascii?Q?vfiPRH1RIgMp+UBpzzCKHxrB3uvFBnlXOvkW4F+UUhVAzrfJPsajUOGBKLsp?=
 =?us-ascii?Q?HjBOcdzgO9dD/kPWH3RK2b9dhGGpG2DngbeNnGMiZJg5KD2fpK9qhL8V7R4r?=
 =?us-ascii?Q?cYsE2dG63qgAvq/vUqqBJeAKbfxqQAliU29opOh1eIyNKqi4LLKGPfJ6kbJh?=
 =?us-ascii?Q?DL9fm9F6wfCrmoL3VIQSXug8T6JWlNug3t1REFc8MFbO/xA/MYnQiF5XSGoZ?=
 =?us-ascii?Q?DWC/Jz2gihSMD6I6ZfbIyhEH5HerBHpiEFfkFvduqZGhJ4CpriXRaDombUF/?=
 =?us-ascii?Q?87aBB/NWcXTX37c1hhuZd1VrQ7x9aserhs77P46qdlmC7fMNk02+3ze7aqeP?=
 =?us-ascii?Q?lKJ4w25YzLp074A3JIL3igP22s0+4QzfltuX3FYuXI8wbHVp1zoovEuxEcZ4?=
 =?us-ascii?Q?H+/KblJ0unnQReZ5f1nwsHfAEY4fH0mpL2my9tpOnBiPhw9JM3fyByXtfFQw?=
 =?us-ascii?Q?XI6tqWmQroGYQI88oRBVUkNGS9KKObkgnM9c4yEnz7sCL4ofiAuRqgTP6oPi?=
 =?us-ascii?Q?wT72uCvbOLEipnjIGCHX5XDTa1Fa9ZFnAjFzaEh0wdnXS7fvFMHfZVi7Z0bs?=
 =?us-ascii?Q?mVIRNQ100T0qAjNtlqq0dna5ji1go6AiZsc3nICqNpZZagjltQqUX6euCZLz?=
 =?us-ascii?Q?SJj03TYr4vqeG3L6RYJeGcR05B+U18tsCymJXA8luX3TiY35q5Ak/UimF7Mj?=
 =?us-ascii?Q?9lOSH5JuVOXrvz20bRI5RAps84UdIJeC4ncdVL4x0d/m9Kb3+pmrxZcYmYMS?=
 =?us-ascii?Q?vTOAqvlzignI/UvjT6wXhTZpQXgH6qRB/l4L/7OOanfkDYeDb3v2uz3XQoZV?=
 =?us-ascii?Q?qZlzZdxLQ7uatD2CjTG+V97FGNYt7JgILrw0bH7qV2z0GQEYVpQhJH7cEjjz?=
 =?us-ascii?Q?HuWUm+s8Ev9kiginHjZtU/bjwbtZTv6kAL1M2p/bT6By+0dBVjfxuqrbOWJY?=
 =?us-ascii?Q?pH3NsHMnGGTg4zTbR6JHHxz9EDWOt700K1HPKFJ9cAvkfsbIUXCebBUc5nLh?=
 =?us-ascii?Q?jCt4UTZBwpFDNKPcw4xBFVp9RKaJfCPKm9XTsIGG54zfY1RhfjIahK27edyW?=
 =?us-ascii?Q?QljEoi9xZIjJN6hDwmx394juaWtoyAfBT4G3G09pagRDJYkl9KDYKC0L4cj1?=
 =?us-ascii?Q?OEdu7frqJygK48xmfRya2HCsvV4iiViVS+/Vts8h/GQ76/4ze6CbgjNIi2U+?=
 =?us-ascii?Q?KpyZWgCLILBGGijKKUGZ3YHNZVqv1EzLekMa0DhBTVf4IQJvk9Rt9c289vPv?=
 =?us-ascii?Q?7mYqmGMgEJZzcgKiDPfRlpq1mQR2hQ+60rYJowZMaLxyFDLxRQb964we6AqV?=
 =?us-ascii?Q?xJv4TcjcRT7KvEStOjyEGtjuKmE2i9PsxwiexId5GhjKV5Robj5Xvvs4bLH8?=
 =?us-ascii?Q?WNg12I6CrE1e9YF9NM3NL4qFKl99iqqyowb4ROHKMxWeWx6SQxApYDKG6485?=
 =?us-ascii?Q?qEKtTSrZA50djnX0yHZpNWUjrr6n4wZBTMmIoyAYPA2n0cjmCmDiDD026XQ8?=
 =?us-ascii?Q?DjTjVwt6N1kyF/IvsVs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:16.9338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce2c61c-0482-4f95-f5a8-08de0a65de4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

The text code for a module must be made writeable to support
re-patching, and can then be marked read-only again after patching is
complete.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 include/linux/module.h |  5 +++++
 kernel/module/main.c   | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index e135cc79acee..2d8c34cb961f 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -1020,4 +1020,9 @@ static inline unsigned long find_kallsyms_symbol_value(struct module *mod,
 /* Define __free(module_put) macro for struct module *. */
 DEFINE_FREE(module_put, struct module *, if (_T) module_put(_T))
 
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+void modules_prepare_repatch(void);
+void modules_post_repatch(void);
+#endif
+
 #endif /* _LINUX_MODULE_H */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 088f9399af11..0525b1c6d5b9 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3910,3 +3910,37 @@ static int module_debugfs_init(void)
 }
 module_init(module_debugfs_init);
 #endif
+
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+static void change_mod_mem_perm(struct module *mod, enum mod_mem_type type,
+		bool writeable)
+{
+	unsigned long base, size;
+
+	base = (unsigned long) mod->mem[type].base;
+	size = mod->mem[type].size;
+
+	if (writeable)
+		set_memory_rw(base, PFN_UP(size));
+	else
+		set_memory_ro(base, PFN_UP(size));
+}
+
+void modules_prepare_repatch(void)
+{
+	struct module *mod;
+
+	list_for_each_entry(mod, &modules, list) {
+		change_mod_mem_perm(mod, MOD_TEXT, true);
+	}
+}
+
+void modules_post_repatch(void)
+{
+	struct module *mod;
+
+	list_for_each_entry(mod, &modules, list) {
+		change_mod_mem_perm(mod, MOD_TEXT, false);
+	}
+}
+#endif
-- 
2.34.1


