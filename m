Return-Path: <linux-kernel+bounces-850731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B34BD3A53
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544513E2953
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A124F30C35F;
	Mon, 13 Oct 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S7UTVwYX"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A8274B27
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366154; cv=fail; b=smm23ZFdtMxGoef7N6DYzXIibeUph5sd5a2AHgTAEYdrG3ZMzgjbymjuwhuE06KmLb7EaqOQPwFzqgebqPP2KHmltV21cL8qCO8k9vABrH18ead1FqGpMi7oni4biNsUCOViMqgEVD9V6o8yaH/vAIsSrnuvWu9ssr6gHEWTcIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366154; c=relaxed/simple;
	bh=xMHEE24+jg+aEgu+enqGa1SPgtSklOIHwaxOqnZ0+U0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y3SAZWojsXYVyDkZH7IofKRkWYvqbpFcjL/4ppiGDd7vwcVMwr6knU7+VkOLKNm0w/AS1uaOlAjPCWxojasYwHbUgGO1CDgqVfKZs+Yk/ZIanjkvb6KS8ABSjqVD4cT92gyGfWtdlwokJwuA/aGyfExIEMZSCPdUR7l12fKSXps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S7UTVwYX; arc=fail smtp.client-ip=52.101.61.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3MO/Ttgql0BlQZfgY/MJaeIuBdUM62Q6uFAWklzlFUTpOzU66yNwzw/eqBfjY6sTePIyDkW073glkKimzseON6zgv1gzXW+Dpmsqkj7rvr0TXXmd0S3Iazlx4zg4XuoZHWgfgCl2cqLauduM1KME31U/ylxjy0B2rss51ufOx0hFwSlbkzyeId0BfazfvL3MoVo+z4c2EhofZ7ckRncqTMcrj1md8388szJgs5c0RQvUuyWaqy21+5YMJgvXW+lPBgTuKgIa1+MuDAGoac/a1a5sNHQJOYDj+igDNYZgUPKc3mzq/sOySlqwfwuhTj84sA+SIYWsULzDVKLg8zCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exXgxy3IV6RFtQAj2hyBChbN5KJmz01K98kkBpOc0Ms=;
 b=So2V1/bqkzRKo0pFmHJcEitUIfwJa2U9nVeN6mUDSCOAHEHD8OPEz6PRpzsiAV26lZY9Jn3HHIUxNDDVe5hv67GiAf12po1d00GTxGwsChvs3qHlPdCS1hFJS2uDfXhlM6A1NQanRdVaObTo//iVOf2PJm8NZUAMr4cNoHqqvGPpexaFDo3G+UhJimU8nd/MNjoxtzCAtjXmUDJCbrErbaKCK9Xzh0nQ2+zu4Uu29kYLieYezqi5CE7dbuyhFwHF3uw216DNf9jHTBsGRcrrYX/tfGCgvyvGamBUYBw35+h6Xqs2nBIqhRjVdZUA2KNKNiuWCjMkHmQYLvRY28ntlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exXgxy3IV6RFtQAj2hyBChbN5KJmz01K98kkBpOc0Ms=;
 b=S7UTVwYXeUCLcvHGPghVL289zcqVta4dzRNH5gO6PuhQSW39Nk/3Zrlr5P1i0JgxVhNf62mYDuS+RbVv+eEPBRsXckn/0bR/q4nCBxaDGCSQYoVFJf/6QssVZx9+VjIh1/4IWVXQxJSzYCiexGs94YnuueUCpUcnfaIteXAASJE=
Received: from BY3PR10CA0002.namprd10.prod.outlook.com (2603:10b6:a03:255::7)
 by CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:50 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::53) by BY3PR10CA0002.outlook.office365.com
 (2603:10b6:a03:255::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 13 Oct 2025 14:35:50 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:35 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 25/56] x86/vmlinux.lds: Define __init_alt_end
Date: Mon, 13 Oct 2025 09:34:13 -0500
Message-ID: <20251013143444.3999-26-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: 205faee8-a375-424c-f096-08de0a65ce87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ROv1BlBdZODDYXl1DwhDVErVMk3DiPf+z4iiCusJykBoF/3d/hfLTusX87Q8?=
 =?us-ascii?Q?8mtBVUxFdD2vXcAufKioGV/d2O7gAJQKWSg8PwuxxlnsHWUMyGr/ElFMCUmj?=
 =?us-ascii?Q?1QxHL1BxmUc0a+Wz8zUAB4OQCt8oOI7CqRcrZlTsAIOzibQFZZI1Y7bi/wly?=
 =?us-ascii?Q?WPr7Ah/InzCFuZ4O3g1j3k/9fm+Y/bR5AyjgWSstKgC21CNuFPts5n2OJeoN?=
 =?us-ascii?Q?mD/xXVzmNZnG5o0KHNkap0JkCkxJgWxhx1LslWgWIs8QY9tp6D7u+bv/8l++?=
 =?us-ascii?Q?g+1UUL8T9/gevtJbuJ6UtMFufq+wzAxAywbOJbc2ZLjsd2fcx/jPsrrMTXNM?=
 =?us-ascii?Q?hGTT2x2uh6uAKsFvEWpk3z0RS9CQ3o1KSvn5iaewrIeCXtCiotVYfXTS1D34?=
 =?us-ascii?Q?E8xkawei9tBOB40DgenSujUG8vc0u1QaWPW53p6XftNfRk8Bn83cia/uGJPJ?=
 =?us-ascii?Q?SrwhaDDjqCt3ocDjs3s407iErvuIIlvbjvlK4zOKqCPUmA1KBXOtkeBxgVmZ?=
 =?us-ascii?Q?r36C0FhJv4SVitDZpzxzJnBozrzO1I7K2Jt4hR8cdnVs5cGmoqxqauc8V4qG?=
 =?us-ascii?Q?nM7tt4acebZLnsVRo8D7vBmA6gqYWV27KbCGrSfkvGTOl2if3+TZXKo+rA1l?=
 =?us-ascii?Q?Hs5lcSk3UdwaVTS41czsX/oApFhRfZYvS3xd8LZiftT38zlwQBY6q7iugNE+?=
 =?us-ascii?Q?s5b4gVEqYm2AD5lv3D6VY9XmAi1e6TJkkMulYOz1ALF7HP0RpQulONG8mtuC?=
 =?us-ascii?Q?FU+yAkQMxKDPd/P4NZ26DHOIVdeGsCdmCvoEdybwtoDgrRQMH93K0pK8XJ+f?=
 =?us-ascii?Q?HdjK6gRcFeGAyC7YM1eUxj7jBunMKm+/0StP9mPZvRNdywin4a2g6Gjewq7k?=
 =?us-ascii?Q?0MolIURZ1gtQYab48XKytiYM7FmLfnEq6hFlJP9jqcXLBqEcZRLwaWbLsM0b?=
 =?us-ascii?Q?8GhJEW9c1odhkhRzv2sy3dZoCrHJFlmokMdSoA4UqUaK9sIJHETHQUBZ3Vap?=
 =?us-ascii?Q?4C78b9uoRHt/Fpc6xEobZNMHeMh1ejYQK5YyJXIoluvB+QsqXsRFyLI+jxMp?=
 =?us-ascii?Q?sZFC6aY00U3LQyf936FT0VMwWWXc/GJq5pTKIfcX4Tc7EoVmviHVlETSOIvf?=
 =?us-ascii?Q?eiWKU7J7AwXaRFgboebw1gcb/pkUD9txcAesYTPTEw4SBV5ZKWuDPv93ZTDz?=
 =?us-ascii?Q?wlzwqXkVsP7uqM+jYWRyBxYZ+V5PR5/XIjbO6YHh/9krNLYl8PjZ8fBt+G1j?=
 =?us-ascii?Q?2UNaOvB4GEjrKAgxSF3IPCMlUxP3W/l0dPck8U/jKJK+DdpLYtK9Du/vqZ0X?=
 =?us-ascii?Q?AgMn9zH+BCVSNsSUf6UfLFBPH8RMNtJ+098KtNTtrp58cZDzG3JW/0ZTC9OF?=
 =?us-ascii?Q?EH3wIMjpds2+GorMI8feNJZVhC+K7+knQOVB79BG5Kti39q8NGgw24uskgQr?=
 =?us-ascii?Q?j6LRXVEl3iNwLbhk3B3T8KsTpmWyVZSSx7MU81iAVgWNW1wTNBW1szsM3ZLV?=
 =?us-ascii?Q?mD0DOH1NODLFMbjMyFSZ/Nf2386VR0wRXrmASLMcVIhokkCVCzUDBqVn72B/?=
 =?us-ascii?Q?Wov1hjmxjQe4oErc7eI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:50.4781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 205faee8-a375-424c-f096-08de0a65ce87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078

With the alternative related information at the beginning of the .init
section, __init_alt_end defines the end of the alternative sections.  The
memory from __init_begin to __init_alt_end must stick around to support
re-patching.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/vmlinux.lds.S | 5 +++++
 arch/x86/tools/relocs.c       | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index c4a0bb13d095..e02044da9971 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -262,6 +262,11 @@ SECTIONS
 		*(.altinstr_replacement)
 	}
 
+	/* Everything from here until __init_end is always freed */
+	. = ALIGN(PAGE_SIZE);
+	.init.alt.end : AT(ADDR(.init.alt.end) - LOAD_OFFSET) {
+		__init_alt_end = .;
+	}
 
 	INIT_TEXT_SECTION(PAGE_SIZE)
 
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index e5a2b9a912d1..2054ffbf5fd4 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -71,6 +71,7 @@ static const char * const	sym_regex_kernel[S_NSYMTYPES] = {
  */
 	[S_REL] =
 	"^(__init_(begin|end)|"
+	"__init_alt_end|"
 	"__x86_cpu_dev_(start|end)|"
 	"__alt_instructions(_end)?|"
 	"(__iommu_table|__apicdrivers|__smp_locks)(_end)?|"
-- 
2.34.1


