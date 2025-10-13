Return-Path: <linux-kernel+bounces-850764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EB5BD3ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58F6E4F3713
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664AB3101B6;
	Mon, 13 Oct 2025 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fVjDbP95"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13F30FF26
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366195; cv=fail; b=pdxHyBbSiFjgXZ74NZRJwVaFYl+AqF0QS3g0Ywgk1uU5SRFQNl8rn+UdO5cqU+mvqjKa6o9Z+a+GSrSbJ5oWl9OHWYjsKMhO62ALnHmyhZUgoS75PoW/Q+ZO7UkAsN2O+87+M6WVJ8jmsYqH3T23Qi56y3sT5sTu0onVXig1Swk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366195; c=relaxed/simple;
	bh=bp1jWWzqekeFOvLFqOMlW7VC4XuPQ5Xw/ZolnUe8voQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRhCNfSzRMkpzbSqS/2Jb2T7jyxm03RiAt+AnkJzp26h5gtlpNcxsMuJzoHyCV4fmqpI0LYMJQ+VTO1Eqi+dwUyw/RkpV4RU1dVFI+obC04BkUUga5oKO05rLCTuPvaM4f/wbJqiIFoUZ0m/wvwQb/8KjSDaM6nc+bVyKG8jIAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fVjDbP95; arc=fail smtp.client-ip=52.101.62.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8F88LXX3Ss1Wfe/sp9KmsevPO+fYgLffgnCxFoWSrrQZd4vLEffPJU2VrvvSKZ71Pr/c2/0QQaV9tsdwOCh63uQ9Gf1nAEjL590coBsV5K23Wo+MTRAdJnS8c7ozBJ1sQoWCGRe0IhJRc/X5AJo0hiC50pIFrnPJN4txfHNEO6T7b8uFUctTM0UkS1pOtva/FaguMzsP5wKOFuHNVudlff+S/qGZSD9GxPz2lVT/VI4JqsYo59mJJznC2F2MK4zIyZMneWFKpNFmXmrlZof4Lasl5QyTUSuDkG6Ehf3vNXRnS0uXYWl+FtOZPVzlIAznI5zQvPOGXz78yVpU8qcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y59zmtEElqgtRWgbhg08llZm41Yf4sLC+h5XKoxy+TU=;
 b=hoxT7uch6qqnHFV+Op/1OTDV4rYi2bk5VqNscJEMe6K9zY2jK/OhdEr4ApTAbcb+uHYkxY/J6QS5g49FB/+qDgJWh0lnvJ+rdyzMuwRZCSvrStk7FfkCLzM7g7xiSETxLfdWOYPFVrkh127z3CEqH5JeFmNQvxT1bFhViZwaWpZsx8sbQrT8mdodja5M2apGcPdT32KObLHd13r2lZD+T/pqMNSRRgBVpVorY/dVK/GsXCNqGNignR/qIQM77TfMuSPAGyCu/qRa9dhOFerGxnX7VVQqgvJdKA5lWkn9tAMprhtmtoPACIuJbuPVR3YR9ugFeWXBwhx4kNVR5mKvdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y59zmtEElqgtRWgbhg08llZm41Yf4sLC+h5XKoxy+TU=;
 b=fVjDbP95h7zOlXuS0PDubut/PuNp85kIH8UqtQs4Ktwzeuncf1JVN/SKhY1Bs3l71dewZqY45W/EWMJBIUCYOmCstzQ9QHwWWbCqNkU+yOfBwbP5kBbr0Ce6t8NWZelEdWQet5In9XJO49R5rQusP0SOl7r3RxUsa1XNGNlaxFE=
Received: from BYAPR07CA0070.namprd07.prod.outlook.com (2603:10b6:a03:60::47)
 by LV8PR12MB9156.namprd12.prod.outlook.com (2603:10b6:408:181::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 14:36:24 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:60:cafe::20) by BYAPR07CA0070.outlook.office365.com
 (2603:10b6:a03:60::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:36:22 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:57 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 52/56] x86/bugs: Support parsing mitigation options
Date: Mon, 13 Oct 2025 09:34:40 -0500
Message-ID: <20251013143444.3999-53-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|LV8PR12MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: 248ec9a1-0f65-4ef7-eee4-08de0a65e1b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i7MNJe50c0nOMY4fvakGCGXuyqc6JTF4RnYvHQS54dUECIod0i62M9FK6ewN?=
 =?us-ascii?Q?aO3E/I9hGq4/rMrU+7YcLHwM7DueZVcwP/LwGk0Ezewf/GUREjRDB06eTE2J?=
 =?us-ascii?Q?oOokxyMbaWiopWlQKFhHuiSG7/z+KrKKnwgZA/phV/KoWP7Q2rXgIX8YAs6P?=
 =?us-ascii?Q?Sp0sgSlT/iOu8lR39nAntLX69WfhBB09kNqpdmhwmT4/s0fX2acdbN1F790V?=
 =?us-ascii?Q?Qrz80DBYdHnNBQcOIn9Chhro055UK9iZX2TNGHIqR6ieGBXnIy8N8QX9+6MN?=
 =?us-ascii?Q?QEA4w/ydlyXaVGhTZPbHMkUOqHl4cNZkcyfRxdvca1CN7dPBcIQvxizkZRgu?=
 =?us-ascii?Q?tINWlyUAXo+pZfp6pm4DNEfUBevBKqpNoPIaMeWK+6b3MVcW16pBJzC7gpTa?=
 =?us-ascii?Q?JWpOZin/C1dt9beTteUqwWayeArEPOW5V7myJ5IxT7qs1sVvsDhJ4iDibFKO?=
 =?us-ascii?Q?BhuEgamPO7yVFw8IMV90MKtLFxXe4VVKxU7e9VT5mfyAgSKaTgtJcdw26itT?=
 =?us-ascii?Q?uPYLpKdwVolhXZQnZ6XBpEyZzo1U07RfSIz2R8Xejk0h46ktQTIEiDTjW1ZQ?=
 =?us-ascii?Q?bOtXiDzwCSfuGgTBRVwK018/og7GpGkWaZRl/b8bBMXf8FX/CvYMNBzsWccb?=
 =?us-ascii?Q?szaYppXnEU3lBCRh5aposfidaxI2iky45dL3naMfmNzBVGgVBAKgiFNRo/iV?=
 =?us-ascii?Q?HFoUqlt5zAeGtIZWCOQ4mVg1NkJEkUWrfA8MrA9sn+ATDMAZZ1CoCJ6WAVGQ?=
 =?us-ascii?Q?NfJLD79wUFwAIW9vgU25jjQX4dSMOXYW0VPL68G1wEXQumN4/f7JkdKYsSSf?=
 =?us-ascii?Q?q4h9n8RID87ZqEjhBcQHiYuGsgk9RyW1FaRj+G9l3R4HMnnWTo5S7PJyyBK2?=
 =?us-ascii?Q?tYWUAigpe+6dhAUTLjSBSD7TfoArZQvmOwiO37BUYRfA39h38nCjbJ7fGlZG?=
 =?us-ascii?Q?hc2KMN+kzQfkskyDO0H4GoYv3kGeoA6WBfkaoTr6OFXQdTAWmKk14ywKUKZv?=
 =?us-ascii?Q?jDsk/YBsupwODMstxUARLaR7wOtvkwN9AQYGjIE1g7k3FIFcKaagCspphCMe?=
 =?us-ascii?Q?gN4jJj8pvM7YLbpQDkhZFRjfuCFsWiIzfdjvTRGFcz6cHlOak1DRpPtKrYoR?=
 =?us-ascii?Q?xNitmAZDCzQ4DPLNsaVW8iND7Ul1h+wTf52BqsHA1+BkaRpLHodi6rs1bsyk?=
 =?us-ascii?Q?mNCyszuJiUZ9NcT1+UDH2tika6qUYvt8HBUgJVoOCbIuJ/dAdOrW0/VTlJgh?=
 =?us-ascii?Q?ftpogHmSiHJxRyCRC+Z++iXrH+TSLk57mh3j3Z/l6TWNma26Rj9IJLrvSFSS?=
 =?us-ascii?Q?r/J/oerTD/hUxKf6wv8borwrHyxmCbVk7uC4YPJ/OJK0PQxcv39DUGl30z9Y?=
 =?us-ascii?Q?Q54B6lR8lwQLcIt4NP1zQUBFcD/ttsTwVPbvUnC87aiZOfdnvrumsAgRdtCA?=
 =?us-ascii?Q?1UB1t/exoK9cQpfHRqBiUU+wpx9omUMrCZpjr8eb7HiI0T23K0BK+L2Z3Pxt?=
 =?us-ascii?Q?gW0WQmBlOyJnLZ979LdYC4VgBJEdQOQEdmFPJ5neffuHXmMBrJYy7fLVeJXK?=
 =?us-ascii?Q?e81N6x9lyNWtkdLxEnM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:22.6622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 248ec9a1-0f65-4ef7-eee4-08de0a65e1b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9156

Add arch-specific function for determining if an option is related to a
mitigation and parsing it.  These will be used for parsing a string of
options for re-evaluating cpu mitigations.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/include/asm/bugs.h |  2 ++
 arch/x86/kernel/cpu/bugs.c  | 56 +++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/arch/x86/include/asm/bugs.h b/arch/x86/include/asm/bugs.h
index 2e1a7d282e51..1e142a676335 100644
--- a/arch/x86/include/asm/bugs.h
+++ b/arch/x86/include/asm/bugs.h
@@ -13,5 +13,7 @@ static inline int ppro_with_ram_bug(void) { return 0; }
 extern void cpu_bugs_smt_update(void);
 void arch_cpu_reset_mitigations(void);
 void cpu_bugs_update_speculation_msrs(void);
+bool arch_is_mitigation_opt(char *param);
+int arch_parse_mitigation_opt(char *param, char *val);
 
 #endif /* _ASM_X86_BUGS_H */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2f82261d033d..26ceb42e0cfb 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -3991,6 +3991,62 @@ void __warn_thunk(void)
 }
 
 #ifdef CONFIG_DYNAMIC_MITIGATIONS
+struct mitigation_info {
+	char *param;
+	int (*parse)(char *str);
+};
+
+static struct mitigation_info mitigation_parsers[] = {
+	{"mds", mds_cmdline},
+	{"tsx_async_abort", tsx_async_abort_parse_cmdline},
+	{"mmio_stale_data", mmio_stale_data_parse_cmdline},
+	{"reg_file_data_sampling", rfds_parse_cmdline},
+	{"srbds", srbds_parse_cmdline},
+	{"gather_data_sampling", gds_parse_cmdline},
+	{"nospectre_v1", nospectre_v1_cmdline},
+	{"retbleed", retbleed_parse_cmdline},
+	{"indirect_target_selection", its_parse_cmdline},
+	{"spectre_v2_user", spectre_v2_user_parse_cmdline},
+	{"nospectre_v2", nospectre_v2_parse_cmdline},
+	{"spectre_v2", spectre_v2_parse_cmdline},
+	{"spectre_bhi", spectre_bhi_parse_cmdline},
+	{"nospec_store_bypass_disable", nossb_parse_cmdline},
+	{"spec_store_bypass_disable", ssb_parse_cmdline},
+	{"l1tf", l1tf_cmdline},
+	{"spec_rstack_overflow", srso_parse_cmdline},
+	{"tsa", tsa_parse_cmdline},
+	{"vmscape", vmscape_parse_cmdline}
+};
+
+static struct mitigation_info *get_mitigation_info(char *param)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mitigation_parsers); i++) {
+		if (parameq(param, mitigation_parsers[i].param))
+			return &mitigation_parsers[i];
+	}
+
+	return NULL;
+}
+
+bool arch_is_mitigation_opt(char *param)
+{
+	return get_mitigation_info(param);
+}
+
+int arch_parse_mitigation_opt(char *param, char *val)
+{
+	struct mitigation_info *info = get_mitigation_info(param);
+
+	if (!info) {
+		pr_warn("Ignoring non-mitigation option %s\n", param);
+		return 0;
+	}
+
+	return info->parse(val);
+}
+
 void arch_cpu_reset_mitigations(void)
 {
 	spectre_v1_reset_mitigation();
-- 
2.34.1


