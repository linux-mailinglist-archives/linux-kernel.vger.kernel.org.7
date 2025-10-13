Return-Path: <linux-kernel+bounces-850749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90044BD3B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E376F3C7DDF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AD230EF62;
	Mon, 13 Oct 2025 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sRG9/sat"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3670F309EE8
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366181; cv=fail; b=SuE4V2piuBH/nHXfXnJCTvN+tYFl48PoIVEJRk485jD6nNeLgAwpRWTAhiVnPBqZuFisKzBtqc9jMPdfN3oYcRxMv0yF7FEBvaNcrX5ax5pqOvNCSNH/EpInhu9Fn2RxOxuUBhxm/Q63saNM8tWW6aI5Gxf8uLq1i0gZqaycWPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366181; c=relaxed/simple;
	bh=eb/AkQOOVU7N9BBw2hoNmNgm6b1bj8UzkhTTC2O4sV0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6wyXYTm2kycHGF4PmCWZvfNzFnJ/rGfjr0+erjtIzhf5iwJLfEBf8PEpxt5+DeVZRYTjYwu1MEPETGw+knxUcfB9iYLmQTJ/ykzZAfPIK3CaVkwDiKBZiPn4+KXMwqk49HwcIJh98rKWsikh9kzOIxlmjlWCYDrNMgXfAGuFfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sRG9/sat; arc=fail smtp.client-ip=40.93.194.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vz0OlnSDUd4qXyzV2m7isbb450d5TPuAC8dQ/AxFqigO4ZptuV8p4UoPDFooud/vcBVVs2YdMJtJ6mt1OVUElczYMw5z3tofBkLfxunQI3baH4jLlZwpJ380yC/vkuEGgWQVM+ZmonJ54LnLsvayeglsM6iluqeugmfJ5L/owstNCQEpOBxlU4DF8e3cttHNhqibBNTJOyZM3aN9TyTuqNFL4mW15jeQBC80XL8TGF2uYmBQG/MKZU1FWCvqQGn8JSrOT9XzyAeRGUIb165xzulhiVI10FNlChyQEoMWAwYsPwvWHgErKmhDU6oGpNJL3asFktDVi/nH5KXLwBGjdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPy8hxQB9cDhLAr5qmwiob7XhkPkJue/DpywtPPJGos=;
 b=iiJN1a+KRL4iLxIBUZvsKtpwi0yT7Ys3TVCjIT1MeCyhnXUgiOlwpMOHg9D9ngqg7TjfBlN2LguTDCQt7kyuJ0G29nx5tx/Sbasg4TB16XdEL3HUdXurpGphp1qQ5P8bco2nKnD1ff+fyYSfK1pL+Lg84wPUi/v81nixc7rpQDpQx6JTtY1Hk1+V4XKa2Kc4i7mfsSN9/GbtUbdJj7EK7+eRBIwiEdBwYdzHLxdRlWf0hphOq7jRlidB4t5BRi0b/B+hhKB0+DTSI10+appUN1or5iy4SftsZgO5+nuOdYE/isInENOet3LyNH27zkAVzNIBROr3S5+wFcgczS3HkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPy8hxQB9cDhLAr5qmwiob7XhkPkJue/DpywtPPJGos=;
 b=sRG9/sat8JIM0FlxYpJtl9gtBBBRMFSW4Ux96bcs4aAJsYqQaS/tsQk3UEOC080MItkxFM4AWpjmVa46Jb3CS69zdGlv5suAhtrySnpjlnhbQ49du04LV/Lm/Ir1oHNwFf/Ax32f6l8hH8SMW4qRHwUASuKGDoCSoHGpmz8pF/Y=
Received: from BYAPR07CA0045.namprd07.prod.outlook.com (2603:10b6:a03:60::22)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 14:36:15 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:60:cafe::81) by BYAPR07CA0045.outlook.office365.com
 (2603:10b6:a03:60::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 14:36:15 +0000
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
 2025 07:35:47 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 39/56] x86/sync_core: Add sync_core_nmi_safe()
Date: Mon, 13 Oct 2025 09:34:27 -0500
Message-ID: <20251013143444.3999-40-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 64865510-9262-4dff-7f1e-08de0a65dd27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YSqI+/RZrmm9+az+Kv9CkApr2A87u9bbu/Oeu7Q5xUo2zD0jFhKprPpH+1uM?=
 =?us-ascii?Q?lbQJVNLFRcemlgZgvI2POsqDnGtcF4SRDX4emyJABtfBxJlmaR1w6k5CCsLm?=
 =?us-ascii?Q?AUSCTB48pGnuOn+uCcJv7GwDZ6RCcCuPhQHCahN8iOmDKqVcAh2BZi6rFk0L?=
 =?us-ascii?Q?n2Ssw+aIkkh9FQticvJCAYUTk7ho9swkhvDrCBSm/D6IDRLEYIE0LVUmnylf?=
 =?us-ascii?Q?66jdPXgzki6JxgewkAprCfnYsBK+GrWFGvzu8HtxUXKPEuVuMya1h7gG23NQ?=
 =?us-ascii?Q?MnonyNqKDC2VWqSKB2a0WuqTLa1dbLwsF3lcn6s7ZX2+eCDSm1VCE1FvfqzT?=
 =?us-ascii?Q?9tE7AZmYwYybKNadpjqivGieAxjwRqWOwOULfzkO0R7Zo/8rBLHNHYxZx/8P?=
 =?us-ascii?Q?I5B9yJGiEs9mAi8UGZsf3N1oN3uZtCjhAWq/RPNx9E3+KXheDTS030341KUw?=
 =?us-ascii?Q?469MCefW5hDIbs8vmhT2JOlhubLMzkow9zZMeuN5n/peaOOzvkbXsa4feOhA?=
 =?us-ascii?Q?zU4u8ddtT/m7NUD1L57Mq9SAOzco1c5QkcFYnkEO/GnYzvvdNFLTJMbP+X8K?=
 =?us-ascii?Q?EPPQC0VFffhrhYXtMeHVo3e3inDVaGZlvL6NmLxAUmx8eHsI2LsSuGDbmqWx?=
 =?us-ascii?Q?oPYBp/WEEAa/iCtHxRAxgnNYTl2f01klIuzny4Etnr2iJqV79U7svhQmQxvd?=
 =?us-ascii?Q?j7NqzbHnBkSuxycz3fS4pKuM5jLdolfnkZbjBponytjmprnUevEryZEtG4Yk?=
 =?us-ascii?Q?hqcjzLgxxX1FKLfJWwduXi15z0+gkusuqdJjzHV7jl+e8frDLn700RbCBMQq?=
 =?us-ascii?Q?O4Svc2/e6eBUdmXaVFNGFycRnvCbmJ5VyVQp6ptJRzrubiS5MeIfiqYBWTXL?=
 =?us-ascii?Q?fvKyS1LM8MnKx3joBxT86Ub7halQwXCsUysj3Jnub0rnOwWnSCQtqoKqugkE?=
 =?us-ascii?Q?ktkBn0H76sJc5PDdCYofjSwGK0n/ANlaqv7vvwCSoxhzi6TZYQuRA3AVZMQx?=
 =?us-ascii?Q?QLNDQ7Uvm19xXstuXm2CIJxwrZ5IYcV4FR8TjpHWIrMUZbGJHopgZz/E7gq+?=
 =?us-ascii?Q?BxcErOlxvd7kigCkjFSzsJgRGJUIKg70ekmEqoJzr7lc4dyWVbKXOTKuWSeo?=
 =?us-ascii?Q?wvDuDSEHnDRimndl7KTGOa1QK0zV7fzD5e6Zdrlf8Idt49kLroSFjl6DS8Ij?=
 =?us-ascii?Q?tXt1Y9G3vzS65N9LhIRwgffRBVMNPe+IDQEo9ZxcUfmUWyQpbHVl8JbjziHd?=
 =?us-ascii?Q?ojddILLJAeKDVYgsbWJA1nPzdk7IDdvk2/3y6ZUikU2U1EhzOEhF50tImUhw?=
 =?us-ascii?Q?NmhxlH2CsTumZJJOSG61iweD4po4jfUgyyfYwXTOp+LVkCUBEHdQ3vYr6bo2?=
 =?us-ascii?Q?JEcpgnzGulKbpD7GijwTRupcjxlY7YsCcBdF0t1we+IjETeuHTqJ2aBJMBpS?=
 =?us-ascii?Q?NcbHbsn9N6qoOV7JvY2vWIH5H924BQYsnyuX6DZ7fomR/iHS1su/pHBrLYY8?=
 =?us-ascii?Q?qY4cIR7ti9zvrd3ESn7jbPeNofi5aNSZfqUjDtsNOmfsLB2mnvZs5ygq/ANW?=
 =?us-ascii?Q?C9XHaCywAGEj7nxFqDU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:15.0119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64865510-9262-4dff-7f1e-08de0a65dd27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643

As noted in the existing comment, sync_core() is not NMI-safe due to the
use of IRET.  sync_core_nmi_safe() uses MOV-CR2 which can be safely used in
NMI context.  This is needed when modifying kernel code within an NMI
handler.

IRET was initially chosen because it works even under environments like Xen
PV.  But Xen PV will not support CONFIG_DYNAMIC_MITIGATIONS and the need
for NMI-based kernel patching.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/include/asm/sync_core.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index 96bda43538ee..f4e2f868d71a 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -88,6 +88,20 @@ static __always_inline void sync_core(void)
 	iret_to_self();
 }
 
+/*
+ * NMI safe version of sync_core()
+ *
+ * sync_core() may do iret_to_self() which will unmask NMI.
+ * sync_core_nmi_safe() uses MOV-to-CR2 and is safe to use in NMI context.
+ *
+ * As noted in the comments above, this sequence may fault at CPL3 (i.e. Xen
+ * PV).  Therefore it should only be used if outside of those environments.
+ */
+static inline void sync_core_nmi_safe(void)
+{
+	 native_read_cr2();
+}
+
 /*
  * Ensure that a core serializing instruction is issued before returning
  * to user-mode. x86 implements return to user-space through sysexit,
-- 
2.34.1


