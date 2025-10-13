Return-Path: <linux-kernel+bounces-850751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAA6BD3A32
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83A0434D3C9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE44309DC5;
	Mon, 13 Oct 2025 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ATzJl9zx"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFE330E830
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366182; cv=fail; b=YDVDgEZmfGdB5I+jFwPJpBy5lK2eoOIAj3riuNmTKQVY0ByCs6blzHLmp/+WLi/wMes19a+WPqlefd+Rjcf0IDsO5MkZ8/iPedY/1mX78mZCUPwh9myIAZsvce9yYqMawAYJb05zqtlxV+l9OzjdVKnB/U3+NbZaF3bfrRqInow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366182; c=relaxed/simple;
	bh=cAs3UCgxhro9vPieVCPdrmM+9r8OOj2a+Kk6yb7PM8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LThMw4XIJUGLSDpAHq5vdby/2YLKu2Gqijy3i4zdDEoUqDqWrh+iTbwsvJdilgbkWqaiMEIbJ5M6LvtBVR1+m3z6DtplNcqjVGi020Q0a563Vl8389yPMU/7L6hn5pDzDmkQP1WVOYdUXzvXgApaalwnvwnSlvKyQwoF8PxRRgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ATzJl9zx; arc=fail smtp.client-ip=52.101.61.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIS5CAxN2y6U2PGbEp1jJdQBiriFLKkBuGszSHIJPTOPa6b7fLmwgxdE7VmMvuThiXQfNUWqIBbHULkCxzIsnssaWNqv6PMsanp7mEJg3aHMzqusd9Obg057mEQdR04F5x0IVNxcl1MuyBIgxrSOv8tFeOY/gt4a19E4xlH2THs7TqZGGSt7gNp7s6B3etrUY8M3H84Uw2TGboEJrcO/6WGXdTUZ8F4vZJtDC8+ckxRYX5q/WbN7O+LUyiQUOLc70RpuUq09KOCsRkmLc9eQ5SV6lmSAgU3SX+RBkB8tnW0hfITtXCTjMRLt/sCJOGLh8nh1qUpBDqrQ5/toC60kWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIRZbh4cGi1E1o+0gRfF+1V0MlqCIuN1JST5gGKr9A0=;
 b=goPeETr72L0IVYcqkpZ8lZBBP8YMELtQTJ/HcrmQm5juSLhA5EAR6b0CbsRwFM/k5PqXr5I9za2h2JeCLrH8ocsj4HBC1JjtRAv3EtMVhMvic8jp/rlUCvC+AiDrent99oCk8Y8Zl2zPIusPHzV65+o6e4vr8vBRGYeb0rNkLQZ+XB3gYflgvSmevPbnzMJkqvutqf2Pvg4j/i1PpSaYsaNcp2Qw9Kgm4K1VBvSdpprPPPjrK6HGFs8waVocsS2RARQ7lDUfLvyoXQVZsb5zj7KQec+TZK4hGrt0bYLySDACCuKerPIZiaOsW64/MlklLvglLBzeqO5Z333i2nhi1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIRZbh4cGi1E1o+0gRfF+1V0MlqCIuN1JST5gGKr9A0=;
 b=ATzJl9zxh/zau583kcv7YGfFkS1J2efnUoJav3Vp+3ZbXCkrX7CqRoMtY9CfEI2oOw/czOkLpHtAGBJjv9RRmgtavE0gPOJE2gvesbpvIERTzCtKVBsXNAS2rktk5YzvZ6X8IBloJiP6jJsgqmJbu/Pa28UkzJvhTBroxJ3I35c=
Received: from BYAPR07CA0047.namprd07.prod.outlook.com (2603:10b6:a03:60::24)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:36:16 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:60:cafe::e8) by BYAPR07CA0047.outlook.office365.com
 (2603:10b6:a03:60::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:36:15 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:48 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 41/56] static_call: Add update_all_static_calls()
Date: Mon, 13 Oct 2025 09:34:29 -0500
Message-ID: <20251013143444.3999-42-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: d87d20b8-addb-48f2-cfe6-08de0a65dda6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?edWbtI7CsN79aB21I4SGzzYPBwPP+oKW8ffvE9KolSNdTf1GpUwgbGQ2SALB?=
 =?us-ascii?Q?Pkc0a+Z+hpooE2EmnGlZpYkK20cfSg9ZMH2xtNMn4XPYfUDansRKewLztigk?=
 =?us-ascii?Q?EuF0vFXxn2R8MPqCcnvclpB9k9cJJB8DD3AEZds9pUdoyXN9sUsLSbORt9hv?=
 =?us-ascii?Q?gtkXXCjocbDBHn/ijDFoRF5I7IUnrQZKlAXdYdXgYEuaNMQA8bGlCoaL4bxU?=
 =?us-ascii?Q?yEnZv7f2zrfBbzts3HBhmz0XcIWluk/l+7rVVJcoqED8yuq3DI5Z549V9Twv?=
 =?us-ascii?Q?nWKX+VBZ0pf5BtmnxQ670BtOsa0CggBlUSyfnUziYADGONiAP9DxOuv+Uw1V?=
 =?us-ascii?Q?2XWguKzOfFgD15J2uH6MN480fI6nggRKx9z/iUiw+N+NyvMzWedtq3FZFQdV?=
 =?us-ascii?Q?Z5grUSZnDbwwdn/BDKGYJxp+9NCt2ddqk+wZsKZ2sTul/bSpKLU/dU/Sy5Hv?=
 =?us-ascii?Q?RZxB8sv7xh2GpGD9d1SUxemQ+kNMsXrenxzI9VPmldBxbPey3GiPwJVVTz10?=
 =?us-ascii?Q?BJHa+9Q3Sr1KM0Q6jSRYt45DMy9gWBUWrkk+FB/iHO664rBr7Zm5KFg48Qhl?=
 =?us-ascii?Q?XiTFnLTlFvoFLXNxa/i4QJKTpuEK+1gwVs0T+u1zkj+4nrQD2uYp8Ya5zlNA?=
 =?us-ascii?Q?0TA++uWl7wM03ZvWx7z77DgTf5SLg6yNaqzMIoek1cyPBg6fDleszg1Tooxi?=
 =?us-ascii?Q?B6mdzab1UYktskd1rDdw5PrTcv+hUG67QrL3eeqwq7XrxTd1Jem46ZJ5CinY?=
 =?us-ascii?Q?GO7ET1x12WL1nu3fs65t1QTWNGVtGuaY96wqVfmUVe/dYoSmTlEodJvbmaqf?=
 =?us-ascii?Q?euWPrb92W4PQwZN5r6DLzHe7mGeFGlj0KJzzA09dWY/T90pCVZLKP9xdMfMD?=
 =?us-ascii?Q?2P0hTKd2nz66z9H5GxNmigY6x2kfwk0biwkMRDGo/ba0NZ1nv2Qf1u+gwtUZ?=
 =?us-ascii?Q?PDjaMxNTrPWParodsxDHuBiur8SsoACRH748Yh0o6rGejfkSiwEjKl7B5L73?=
 =?us-ascii?Q?C7KbrasHjlvlEipE1ej26fubv1sH1NqMJGpt749oDwjdGDgGVTt5gYNh0ne0?=
 =?us-ascii?Q?LATS3FZb58BDJdXbaVCL0p38LDJm58hJXWA4tBiBKg6GFOoEhzm+BestY/A1?=
 =?us-ascii?Q?IbE0sOo5DXg1ibIeDx7LNlpMMKMZV40gq/uTjAYiu2j2H8eSQyEIozx5sleJ?=
 =?us-ascii?Q?2gUmlt1EH8wQuAUe7luMJkix3t9965GLHoDBFEo8YUsPcJfBDJup0m1b+d39?=
 =?us-ascii?Q?0HSOvgwn5NwRWk5WHESkCMqibDPxs9kvy7XsRLRmI4FLntUqSeLGQlBK1lHZ?=
 =?us-ascii?Q?WvRHMnhJMOtB7bd3BLq1/4oQ1B3nnhFg+6SsWXGSOl/DJkJEg4byeiuSV6Fw?=
 =?us-ascii?Q?fsl9c9M13EH4l/qMJl/xMnATrAcBCNx8zvtBDUfLcpf+3HnbNIP+MnmX58Mb?=
 =?us-ascii?Q?QyppyctR5Wr8uCHq1/02ST4lcq6mNlyL3agF7mj44WIic3nkGouywubmbHU3?=
 =?us-ascii?Q?0GmXGJHa06wxqcvBGNzZ697EdDH1xqqiPE12Ztm+yIQBGoUZ1/1n8OMGFxbk?=
 =?us-ascii?Q?rtO/BOcD1d5Zo3C00nk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:15.8442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d87d20b8-addb-48f2-cfe6-08de0a65dda6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376

The update_all_static_calls() function re-scans all static call sites and
re-patches them.  This is used during re-patching.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/static_call.c |  3 ++-
 include/linux/static_call.h   |  2 ++
 kernel/static_call_inline.c   | 22 ++++++++++++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 378c388d1b31..2d16d69b17d0 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -105,7 +105,8 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
 	if (memcmp(insn, code, size) == 0)
 		return;
 
-	if (system_state == SYSTEM_BOOTING || modinit)
+	/* alternatives_patched is false if we are doing dynamic re-patching. */
+	if (system_state == SYSTEM_BOOTING || modinit || !alternatives_patched)
 		return text_poke_early(insn, code, size);
 
 	smp_text_poke_single(insn, code, size, emulate);
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 78a77a4ae0ea..cc5f28a04539 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -181,6 +181,8 @@ struct static_call_tramp_key {
 extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
 extern int static_call_mod_init(struct module *mod);
 extern int static_call_text_reserved(void *start, void *end);
+extern void update_all_static_calls(struct static_call_site *start,
+		struct static_call_site *stop, struct module *mod);
 
 extern long __static_call_return0(void);
 
diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
index 269683d41aa9..504b69496711 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -9,6 +9,7 @@
 #include <linux/cpu.h>
 #include <linux/processor.h>
 #include <asm/sections.h>
+#include <linux/kallsyms.h>
 
 extern struct static_call_site __start_static_call_sites[],
 			       __stop_static_call_sites[];
@@ -492,6 +493,27 @@ int static_call_text_reserved(void *start, void *end)
 	return __static_call_mod_text_reserved(start, end);
 }
 
+void update_all_static_calls(struct static_call_site *start,
+			     struct static_call_site *stop,
+			     struct module *mod)
+{
+	struct static_call_site *site;
+	struct static_call_key *key;
+
+	for (site = start; site < stop; site++) {
+		void *site_addr = static_call_addr(site);
+
+		/* All init code is gone when this function is called. */
+		if (is_kernel_text((u64) site_addr) ||
+		    (mod &&
+		     within_module_mem_type((u64) site_addr, mod, MOD_TEXT))) {
+			key = static_call_key(site);
+			arch_static_call_transform(site_addr, NULL, key->func,
+					static_call_is_tail(site));
+		}
+	}
+}
+
 int __init static_call_init(void)
 {
 	int ret;
-- 
2.34.1


