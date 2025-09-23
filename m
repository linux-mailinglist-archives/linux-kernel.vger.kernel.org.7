Return-Path: <linux-kernel+bounces-828407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD771B948F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76AE33A2FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578DD30F936;
	Tue, 23 Sep 2025 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TRKO5+/+"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013039.outbound.protection.outlook.com [40.93.196.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB843242D91
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758609010; cv=fail; b=IVcGv/jBCNKhfXcIxx2isaVrHPBkCuvhnhn1fTkzfxwSeYbB7CGMGEqBSfn8iONwxb+avMQIewaZl6j9Wxx3/pZPfVn+B3lkbxhblY9N5iiwidKK2sXEYPcihWeAbUWLobz/9Uz0jTU5B2wyYosWvyrqwoB9MyCW1ktMNue5QAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758609010; c=relaxed/simple;
	bh=t2AFDdhY6dm91XxKS9LSVd94S/p5lzDrzvsajaxELE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2CPuNV5jzochq1xIWrw1AnO2Kiq3gJSsbhe8bwuDwTu25FBexvThJspFT8UJgi5JzUtIqoRDBVo0wNq6U/1CZU7ecWQJ8yrY3MldMi1vD7ZdcroeNFji4J6OFRZVRc9s3665XRCBsnTTThhUI8dqsvs4l3I8vWBOvznvKGRmj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TRKO5+/+; arc=fail smtp.client-ip=40.93.196.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJTnB7KfTrmXH54dc0wspoqq5g5QG/eNZixXqgZj3Vpr106LP0VHs3htAi2rhsFZOmVAa+iG5h8oDAuqIXGgs8+nF7K+xBhxhT7VguGil3rdkGpxhYSI7CbhKMRqeoXu3OTcMJ4R9WQjGEbgKHDBd6apuHtVATIW0sDIC0CUz+2sphGXNvf/1FY5sfeRlK4xfVi+BwXG2CP9EjxZuT+XE+VSTQtc4rEFu38mT0sEWd0y4etLecCkD7RRrm13m6OqMvSkDgR+JDXiKXqYmtAu1v+3FodewEayzyKBhkZHNIKM12hcbflCkOzb7wGkHwrL/Ko/G1kABhcCMOcz0rHdMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQyY64GotFaz8Qs8Iv4UM22tDEmFHv7OmAO1tAvIo3A=;
 b=jomh/EhbH1B/Sj1+4UJkfixkbVXwKFF5E+MpB3PPrePePtj1+GzSZifEozSr/9+R2Ef+qfocuu3SFC/X2Y8bvHhSwVBvHGko96IodOLFpGqjJoax8oRqHNLmhv29syaMNqkMb5b2/Ea/ViNORk2AFStVNaG8610+vzq5o3oaRcJY0YXkBacVZKl1SrTqdjftwf7AwP2gUOMEoh10/ClVRIYAHL6Yi5CfLsX3a8mQ3rgEh5Ulq1OvYvEmz0vk9HLbtuJDrf8sr9p4JE9Dej+y6rdZIVuRYU5JsxsaAx/2cnjxySvnpbPnmiR1bIIq64GKUtSaRNnEKx/uF77Mtw5nvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQyY64GotFaz8Qs8Iv4UM22tDEmFHv7OmAO1tAvIo3A=;
 b=TRKO5+/+1kiU7BZKDhwqwaxuhmro0cuAH9C15P5ByhuFCiRBv+8G5jlSB+gJ3lQEEqN0hI3jHaHIo2G0YHF3wdIjGrvySf7DP8FVScYzdIFZJhlSwbHhXa78juknB39SscPbLZbA+aeyka6VrO4DoPBdIyTGfkfCwGNAUD36aGU=
Received: from DM6PR04CA0017.namprd04.prod.outlook.com (2603:10b6:5:334::22)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 06:30:03 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::e9) by DM6PR04CA0017.outlook.office365.com
 (2603:10b6:5:334::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 06:30:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 06:30:02 +0000
Received: from tunga.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Sep
 2025 23:29:55 -0700
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <ankur.a.arora@oracle.com>
CC: <acme@kernel.org>, <akpm@linux-foundation.org>,
	<boris.ostrovsky@oracle.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<david@redhat.com>, <hpa@zytor.com>, <konrad.wilk@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <luto@kernel.org>,
	<mingo@redhat.com>, <mjguzik@gmail.com>, <namhyung@kernel.org>,
	<peterz@infradead.org>, <raghavendra.kt@amd.com>, <tglx@linutronix.de>,
	<willy@infradead.org>, <x86@kernel.org>
Subject: Re: [PATCH v7 00/16] mm: folio_zero_user: clear contiguous pages
Date: Tue, 23 Sep 2025 06:29:35 +0000
Message-ID: <20250923062935.2416128-1-raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|BY5PR12MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: 57cbeb73-3646-47ca-f17c-08ddfa6aa0d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g+rVpi8iT0CDmGVbv+mLhlIASJnEuX54O32DAf3MfJPq6NDFVRHJFL+E9Jk1?=
 =?us-ascii?Q?qyW9ahXCX2lTTXCQmAiMQwD6vHKy7mlR7PTs2VNicUicF42H9vS44tYh2jSk?=
 =?us-ascii?Q?zXIm6EbUqjwBr3sR/hz+As0/4vsBApaes8+03WezY+GK9bqhli/7DsSLwyxu?=
 =?us-ascii?Q?d4is8J1Z81k9y3dPeMQKd1OYu3GYHPGP71jZLyOueMJFhC7AcpedHeB6nsPp?=
 =?us-ascii?Q?TnvEAeHnOKfwoXVn5N6SHWiNOikN1ZKPOQiFs4WXqaVtne0urshsA+NZAHLm?=
 =?us-ascii?Q?uf+X4+ykxnLikfcnlZEoiKP4P1/ik4qWtGWb1laZ7zpAq9BXXhdof1jeggRk?=
 =?us-ascii?Q?Qr1pTvGRWjCFSzhPSsewynaOX+ZuJbWEudFfXrQQ6wG5tk9PRQDI6Cox5e5E?=
 =?us-ascii?Q?c7JRZ+pbwL82IeIJpl9kvGBA2A5fYTOTZoZ8V986RMw/TWeQN5AuYpPtSQ3Q?=
 =?us-ascii?Q?ZCFpCDHJ1pwy/88jqnUy1K15dKPbudIyUtegapH5/vDMAhLz1kcEG/SwxvtU?=
 =?us-ascii?Q?6UDXqLtzsW2XSDN0ZKy2VXDrPXRu0dLRiPxjGRgV+xlaxa/saAr2SNkAMVFw?=
 =?us-ascii?Q?JshqGAQifovO/t1HjjXhn/AzireAOY+ElGlQMgQiCiaugD3DRnf8qUb+Dpz3?=
 =?us-ascii?Q?VHjfcjG+xB7w6XzShj/xJlo7KZBnm2sQPFZ6C91/Gf+PH23xOCkaxAlm7NuO?=
 =?us-ascii?Q?6a2RLXe1yvVv6oG+Zgbgzuu8gKX5BFCkkqe32mnn6AhuVg0e2KU6aoCqfqQx?=
 =?us-ascii?Q?3MJOMH1bIBQvhBZ3N2+CuLx689YSGJ0i6lNhlc4XTJYPh4kSaawtfAEw9i1G?=
 =?us-ascii?Q?Xb4vw9s8s3Wb9N7RI5+Gnjxe6TWQzqXYH/eHGY2Xh2rHPMpUx2WNWfK5a5Ol?=
 =?us-ascii?Q?peqAiW7nuEFlQIPNa3JuYRq3HgkO30D/VRKLUn9K05rX/NZnahpIVp8T88op?=
 =?us-ascii?Q?UOFcQ55QjUQBb12HLY+FKcg9iPr+fnHp2Tl1yDuTRPSm9o9zg52jiR9svc1v?=
 =?us-ascii?Q?wmTVzFhWWui8NWU7i/9D8F4JvXscxNdirWuxvh0928vHDL0uUFsl7Tt6ptYa?=
 =?us-ascii?Q?4n8kQlOZXkyNeF7Ev3hLEDpQsMbFSN2euReHeQ+cMUddcVgKrHFGHyYHpfQn?=
 =?us-ascii?Q?K0U8vkjnWd2e7Eqqwz8XluhU+LvuN7+pnrPcuCjGVCwThwFpq/PBVE0jPnfG?=
 =?us-ascii?Q?PwMM+nsxue27n/amiF+TG8tvvpH+9haJSH9wlMqXNWskZfkWIt16dRa3nkRG?=
 =?us-ascii?Q?7ERnpnsUQ+cLrkQapAu2n1pa4k+EPoS/S2qJHqrEZ6G9euRHfu94YI+BrboU?=
 =?us-ascii?Q?jcpko2Cschhqc/4/g6hn3Ds7gfI8odkU+VY6gr1tTQ3+Iy8jD9l90yNny75e?=
 =?us-ascii?Q?pGq5No4rCEq8bEXbBjg0hchI8M//GTDrC/jos5DrjrnSz8f7MhUg37iX15WN?=
 =?us-ascii?Q?rUyTa93FxTkP1uPeWxcNeE47rrxCcxQaQ0kvzl9hA5mOvwYYWzqTzFmlSarB?=
 =?us-ascii?Q?hoMM7uchOlFi8cjqsLi0F9FWPUZEBFGMUX7N?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 06:30:02.7474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cbeb73-3646-47ca-f17c-08ddfa6aa0d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321

On 9/17/2025 8:54 PM, Ankur Arora wrote:
> This series adds clearing of contiguous page ranges for hugepages,
> improving on the current page-at-a-time approach in two ways:
> 
>   - amortizes the per-page setup cost over a larger extent
> 
>   - when using string instructions, exposes the real region size
>     to the processor.
> 
> A processor could use a knowledge of the extent to optimize the
> clearing. AMD Zen uarchs, as an example, elide allocation of
> cachelines for regions larger than L3-size.
[...]

Hello,

Feel free to add

Tested-by: Raghavendra K T <raghavendra.kt@amd.com>
 
for whole series.

[ I do understand that there may be minor tweeks to clear page patches
to convert nth_page once David's changes are in]

SUT: AMD Zen5

I also did a quick hack to unconditionally use CLZERO/MOVNT on top of
Ankur's series to test how much additional benefits can architectural
enhancements bring in. [ Inline with second part of Ankur's old series before
preempt lazy changes ]. Please note that it is only for testing ideally
for lower sizes we would want rep stosb only. and threshold at which
we need to do non-temporal copy should be a function of L3 and / OR L2 size
perhaps.

Results:
base      : 6.17-rc6 + perf bench patches
clearpage : 6.17-rc6 + whole series from Ankur 
clzero    : 6.17-rc6 + Ankur's series +  clzero (below patch)
movnt     : 6.17-rc6 + Ankur's series +  movnt (below patch)

Command run: ./perf bench mem mmap -p 2MB -f demand -s 64GB -l 10

Higher = better

                   preempt = lazy (GB/sec)  preempt = voluntary (GB/sec)

base               20.655559                19.712500

clearpage          35.060572                34.533414      

clzero             66.948422                66.067265

movnt              51.593506                51.403765


CLZERO/MOVNT experimental patch. Hope I have not missed anything here :)

-- >8 --
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 52c8910ba2ef..26cef2b187b9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -3170,6 +3170,8 @@ config HAVE_ATOMIC_IOMAP
 	def_bool y
 	depends on X86_32
 
+source "arch/x86/Kconfig.cpy"
+
 source "arch/x86/kvm/Kconfig"
 
 source "arch/x86/Kconfig.cpufeatures"
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 2361066d175e..aa2e62bbfa62 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -84,11 +84,23 @@ static inline void clear_pages(void *addr, unsigned int npages)
 	 */
 	kmsan_unpoison_memory(addr, len);
 	asm volatile(ALTERNATIVE_2("call memzero_page_aligned_unrolled",
-				   "shrq $3, %%rcx; rep stosq", X86_FEATURE_REP_GOOD,
-				   "rep stosb", X86_FEATURE_ERMS)
-			: "+c" (len), "+D" (addr), ASM_CALL_CONSTRAINT
-			: "a" (0)
-			: "cc", "memory");
+				"shrq $3, %%rcx; rep stosq", X86_FEATURE_REP_GOOD,
+#if defined(CONFIG_CLEARPAGE_CLZERO)
+		"call clear_pages_clzero", X86_FEATURE_CLZERO)
+		: "+c" (len), "+D" (addr), ASM_CALL_CONSTRAINT
+		: "a" (0)
+		: "cc", "memory");
+#elif defined(CONFIG_CLEARPAGE_MOVNT)
+		"call clear_pages_movnt", X86_FEATURE_XMM2)
+		: "+c" (len), "+D" (addr), ASM_CALL_CONSTRAINT
+		: "a" (0)
+		: "cc", "memory");
+#else
+		"rep stosb", X86_FEATURE_ERMS)
+		: "+c" (len), "+D" (addr), ASM_CALL_CONSTRAINT
+		: "a" (0)
+		: "cc", "memory");
+#endif
 }
 #define clear_pages clear_pages
 
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index 27debe0c018c..0848287446dd 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -4,6 +4,7 @@
 #include <linux/cfi_types.h>
 #include <linux/objtool.h>
 #include <asm/asm.h>
+#include <asm/page_types.h>
 
 /*
  * Zero page aligned region.
@@ -119,3 +120,40 @@ SYM_FUNC_START(rep_stos_alternative)
 	_ASM_EXTABLE_UA(17b, .Lclear_user_tail)
 SYM_FUNC_END(rep_stos_alternative)
 EXPORT_SYMBOL(rep_stos_alternative)
+
+SYM_FUNC_START(clear_pages_movnt)
+	.p2align 4
+.Lstart:
+	movnti  %rax, 0x00(%rdi)
+	movnti  %rax, 0x08(%rdi)
+	movnti  %rax, 0x10(%rdi)
+	movnti  %rax, 0x18(%rdi)
+	movnti  %rax, 0x20(%rdi)
+	movnti  %rax, 0x28(%rdi)
+	movnti  %rax, 0x30(%rdi)
+	movnti  %rax, 0x38(%rdi)
+	addq    $0x40, %rdi
+	subl    $0x40, %ecx
+	ja      .Lstart
+	RET
+SYM_FUNC_END(clear_pages_movnt)
+EXPORT_SYMBOL_GPL(clear_pages_movnt)
+
+/*
+ * Zero a page using clzero (On AMD, with CPU_FEATURE_CLZERO.)
+ *
+ * Caller needs to issue a sfence at the end.
+ */
+
+SYM_FUNC_START(clear_pages_clzero)
+	movq	%rdi,%rax
+	.p2align 4
+.Liter:
+	clzero
+	addq    $0x40, %rax
+	subl    $0x40, %ecx
+	ja      .Liter
+	sfence
+	RET
+SYM_FUNC_END(clear_pages_clzero)
+EXPORT_SYMBOL_GPL(clear_pages_clzero)
-- 
2.43.0


