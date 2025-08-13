Return-Path: <linux-kernel+bounces-766982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D19B24D6A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077E4622B47
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA80E238C3A;
	Wed, 13 Aug 2025 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zA9sn6Gh"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B477238C1F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098840; cv=fail; b=RIqjrNB0nygm7JdVjv+Ztx9LQ8rz5xyEwaPwcl+2Hi8TA5xDrWuqtdNyMYodE6ZCmFYiTZVjhbhjj9o2snfmQ0M2y1SKJ9aYi7k8T50+B7wQNwir4ScAzVSh+QnBOU/Po/G+ioW6Gg+97jkLeV3rBXjin6dCHqVaaAtcIV7FCLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098840; c=relaxed/simple;
	bh=NzWp4EDKV8VQpHOvxG06AhvXkEV3mjZCEhbP4Qg3+C4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sCNIWklj9uLnzjt2hZspm59jDOvDE66hrUX3wrdiDJoomzbqz8CL7ctIOUlGREIMNbKX35JSgnycz1UWUFkFqv24zPBOSGhrK6Ency8LvvY+jVfK64ALmFUhk7EPl7AYkA6amo5SuZ0EZD6AanTPi+enUVXyYaz5v+ROjI6KF/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zA9sn6Gh; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDni6xnhP2OEIQ/Q2xHOxAsGCPuWci8HhaFdAGbOKYU57UxTqzqCxrIL0fiZOi77wtos/yJtBUnwI5aQ/bw/YMdtEqh/ix1Z60a9aVXKbVMuhtzsWPCheXXymXPALdKkgavX4c4orYFIYp4Ojh46JdExQgg+XIEEXlkCDqXub4lAf0cT+b7WNqYPEm9D7sWzNJofBWXNEH1BEfkG4DzgDa9Yvycu5IfYJ5dml8Gr/JvpZ9yBslPHRoj1O6fM94E9Y6U+M03bWNvRXbMQMOaCTvznOWAoFIX2X6Mpyo30GU9Dd6IjFsbMdJWAq7P8+KzkLxvHignkKbAbCHoia8uvWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yc8HNjZYZmPY+VtvK4tBlPXXm2usRSpEkKVZpj39whM=;
 b=Q/CpY8mE0AYmXuOMEeJkDySGH0cPxBwVihyWM83t4TR3p6+pDMOiUP0IdlZ/dlghRFEMVv2TC/wY4gi00o4YPS4YOcScbuwpuFQnIEvCoXKeoxSDftZ0CyfY1guSup2ox/2WeJTv8CZmYgyUBJd2JZ/FVHFgC9ErVi23Y3nGViGACfKflOX6NUMlqcg3Y6BHHdk9FYmT87JyPzgh3k8umD4pUrrUt6wtvXCg3OMknEJ7sEB9jL94W3I0HmqdCin2+zWt6xS041aTNSsJ0416rRPMClqd9mdsyttRqNDd+XDhos26C09fMuavmhxyifYzbxdPv4ENbxndynDtM0n6AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc8HNjZYZmPY+VtvK4tBlPXXm2usRSpEkKVZpj39whM=;
 b=zA9sn6GhSdB93sQy424gkDwaS95VUhHe/cTeo3Tfem/0WwNibXiZir4agNPQqSOTfIHmAqkrK7ygu9CNMxMRVyOPItpAzgSKLlQoMETez8/jwSdOR/zL15HlXdC2gtOwlnDZXTfZfgMBE/eN4KN7yFBdaTzNoNSK2TmFSAgJpQQ=
Received: from MN2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:208:1a0::31)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 15:27:13 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:208:1a0:cafe::93) by MN2PR07CA0021.outlook.office365.com
 (2603:10b6:208:1a0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 15:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 15:27:11 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 10:27:10 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Joerg Roedel <Joerg.Roedel@amd.com>
Subject: [PATCH] x86/sev: Ensure SVSM reserved fields are initialized to zero
Date: Wed, 13 Aug 2025 10:26:59 -0500
Message-ID: <7cde412f8b057ea13a646fb166b1ca023f6a5031.1755098819.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: da17006f-09e6-463f-52ef-08ddda7ddfad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/7nJFwHn3d7oLH6m2I+doMC3eJQGmlPsem1H1kPGo1xDNx3uBwZHHFy6QRjP?=
 =?us-ascii?Q?HR70Zhs0xSmTion5xJVBkULHxgDaKeRiE89uRRTWV2QV9pZIVExn9hx8ttLr?=
 =?us-ascii?Q?714yP/NwEyK7GwnQSt39hQ5Q8qj5GZnJKynKX+fdPeqAG2vchgOnjqBm6rCk?=
 =?us-ascii?Q?wEygh8Sspgy6Y5sWZc8ZGdAF74oZCx89+f0IH5Y+nWgerVgxAdot81xHsLRN?=
 =?us-ascii?Q?gvToZRFbtGwBvbyjX2Ek3PKrNatxaHRDK4uxQhpQrS8HJMONghXPPg/nlCH4?=
 =?us-ascii?Q?LRptKJTz9XqY9JavioDiygaU13wmVzu1AKwg4yuEtGsZ7olX2YwIptEP2c0h?=
 =?us-ascii?Q?WCPgwWBJJltlPa1TSsjpEJvRLglRLY4GweSkplYm9F89hdj/XY0NJZ6J4PTY?=
 =?us-ascii?Q?pMhjl0v72hNM4SylLG0tbTT9wwLHCCzJ90q94qIzyaaJ4qHVDJ/9P2l4kquk?=
 =?us-ascii?Q?4IpW8bmwL3JH4p8rFINS7V9F/MbCagEt7WjB325A9mO0wrXPsZ+sj9t2cWcl?=
 =?us-ascii?Q?Bq7AducYUCzPuc4gPMTHXvrvtokrYLS0axTY6BtICcAV72tdAvuxYbD3rW+D?=
 =?us-ascii?Q?isGIXFzVUFqd6hSIFfsZYZgxGDaCuP33ytN+0KDncvx/vCFRcucDbKqM5lD0?=
 =?us-ascii?Q?ya2Kr3NQf2I7CBFLY/pzXVdqEG0O2UlWGnpQcc8EJUvGmxTPcDNYSZbEaX8k?=
 =?us-ascii?Q?b7WpPk9zkNdJRKml653lc4XG+vlyGyetBWzDkfqqz0NaZsaQg5lWBbvZxR6g?=
 =?us-ascii?Q?AFskvSTPJQrD2R4HYANPzwjYoMlnW2vMAMwDQ4zGt8oJ5E/zwMW87+njOUys?=
 =?us-ascii?Q?oqh/+4wcqJ+QDHaJpT1bb9dvjNmk848xIAZXl7AaOB0jPp5Bv0/NcqezNQcj?=
 =?us-ascii?Q?iMtkg6ZR5+ptqqknoQgQQoWH1HnnkZlk4+CAfRmYlJ7tePNTvmwQ9xrnuPWv?=
 =?us-ascii?Q?OM41TIsygfwXFQdRJ3Mmu5/jiPH//HB6I3/pZmZhcBQshR35KRT5qtQsJU+x?=
 =?us-ascii?Q?u2o2ax1edvYgQxBwGbONG+mbI6mtY4NDux+/0uzWG+zOtXUDNbmfaB9/WVqJ?=
 =?us-ascii?Q?AkJ/CY5SvDbbcEL9Z28bKK1u0obZkj2evb4i6jkHu8M4WIFQ7UMBVehROVeQ?=
 =?us-ascii?Q?nsFt+Y+EYcS68Pc/oZXD0hvUw9PQtOIwNEAv2kl6IppZR8Hxehj8NkaFdXHH?=
 =?us-ascii?Q?RZacAJrkQjeEq/CAYHV3r7nRHFyhok7ESXhWXO8cWHMxLEFTl/RWpqF6Ydg1?=
 =?us-ascii?Q?7rZI6FCERqUjbBrPdUokQ/p1eRyKjzVe+xQkB+6+1L/oqL0qP/kuQIGfDIvZ?=
 =?us-ascii?Q?v64Zjvblf8EineJZ7CcBoakzWfUg0wKDUtCAEiqBJ7HyJ1nwlzE8z/m65qxC?=
 =?us-ascii?Q?4/SodFmq+xyZHtvvU1O6FiqLPRon1qKFaT1IE709pyLSDXJZplIxyqx2HYZW?=
 =?us-ascii?Q?7jqMofmOgvrac5GLRohhtwmz+G/CQZ33qvN+eAUV5DvvbkQZEKqCd9/MFrUD?=
 =?us-ascii?Q?jONp8M6miRzbnlJPkKp1RRoEgPt4n+qQHZx9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 15:27:11.4502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da17006f-09e6-463f-52ef-08ddda7ddfad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190

In order to support future versions of the SVSM_CORE_PVALIDATE call,
all reserved fields within a PVALIDATE entry must be set to zero as an
SVSM should be ensuring all reserved fields are zero in order to support
future usage of reserved areas based on the protocol version.

Fixes: fcd042e86422 ("x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/startup/sev-shared.c | 1 +
 arch/x86/coco/sev/core.c           | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index ac7dfd21ddd4..a34cd19796f9 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -785,6 +785,7 @@ static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 	pc->entry[0].page_size = RMP_PG_SIZE_4K;
 	pc->entry[0].action    = validate;
 	pc->entry[0].ignore_cf = 0;
+	pc->entry[0].rsvd      = 0;
 	pc->entry[0].pfn       = paddr >> PAGE_SHIFT;
 
 	/* Protocol 0, Call ID 1 */
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 400a6ab75d45..14ef5908fb27 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -227,6 +227,7 @@ static u64 svsm_build_ca_from_pfn_range(u64 pfn, u64 pfn_end, bool action,
 		pe->page_size = RMP_PG_SIZE_4K;
 		pe->action    = action;
 		pe->ignore_cf = 0;
+		pe->rsvd      = 0;
 		pe->pfn       = pfn;
 
 		pe++;
@@ -257,6 +258,7 @@ static int svsm_build_ca_from_psc_desc(struct snp_psc_desc *desc, unsigned int d
 		pe->page_size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
 		pe->action    = e->operation == SNP_PAGE_STATE_PRIVATE;
 		pe->ignore_cf = 0;
+		pe->rsvd      = 0;
 		pe->pfn       = e->gfn;
 
 		pe++;

base-commit: 4c699535a3d483562354432a945a035f15dfceeb
-- 
2.46.2


