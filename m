Return-Path: <linux-kernel+bounces-874777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79426C170BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084B23B71BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102F72DD61E;
	Tue, 28 Oct 2025 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nqn2ANUw"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013043.outbound.protection.outlook.com [40.93.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1342D2DCBE0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687364; cv=fail; b=tQqYXYrqzPccYeXIZtqyxf4Smchp/KsNjERfJO5lJc6KTIogEq7UwgWTLWIBYdaYdAPDNjT5cVEWUXRxp+xuFRY08DL//LeZRFoTlLJ2FkmnfPDbQCpU5MNeKdnVTHP3AEiCzg9RnJ+vJYoFwQ31h8uR10oqI3/9wKXXVufF9Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687364; c=relaxed/simple;
	bh=/Vcq/U6wKsmdVbTAkVeZugx0I8uSFln9V1Fl+Y4llhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=O/3Ft2OvVCKmF/gMbtOyj4E0XW6L5ilZLL3szR+LbLucH477TWEuZhEgZk8kERU5ovWVDp7JCe51qx4IxAzacJw6qkEIo5MlxTCtkxktz5MVRRt5A6EsbhwsE6FYqkwRrZ+xpxL/N4VpNtQ6hhK4pNOag4cnWv2KItPyNW2+3fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nqn2ANUw; arc=fail smtp.client-ip=40.93.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLVkmS+R43svEReRC1JZKjhtZzV3IxblYdfP54agoNonWs3DpDkRhJKzJJyL8RL8Vqd2RPQLtv8CTFLMgopyDh7Uhx3/s8WWAkNsZ+J9lCMM+qQtFXPEQU9Nc1ZIRwe8iss5Kl+mznoGGb2Fcx8rPFjN6nWW3qx8ZPRyjSPa6/iqQ+BA0mvlTjmwy+mUVP2J4TEV2xB7kWgTAY5MD2CNQ11Dz/ijvmVNwXXYDS3E2oeDn72+zS4WtM6N92xOfH427nFiCsQg29NQ0vc4gyAbICAKz+oYxkIwNoISYSaDOPY/NWaLk0QgWgu2n36dqTkO1pKkxAYGtMPh0eCPYRfJHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOhzF4FEm+hkowG6ezbB94ZFKxTZLYim7sXenAV23e8=;
 b=jkhfims0+rfywMRIp4RlMbcdBNfHxo720ShqnVB7XjPswPN8KHqS2QTvVnLLmioZO8B3wsYjty/Sj0MzHI7pgCIGROxH5dQlTewd3ApC75hTSHIjLIGg15865r1wwP6BcBQ8PfpJnMVPBApnylLtaG01gVz+AWw38KwfIZRxoZ1X1avmHf7fJdLORhPVi+UfDH0D/7mDiESj0XwXpzbbRsL4ko6sghtPd7+VNl+L5fzxDD/Ba98cQD1t216xbyNtJyxa84JlnnjA9gP+q9m6QtzaF3hXLkmX49uWLwciOPHZGQUzT2fH5XtepY+q3SeLRmEtk13dc+0go8rue/st3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOhzF4FEm+hkowG6ezbB94ZFKxTZLYim7sXenAV23e8=;
 b=nqn2ANUwqxgQu699f3820NoauJxMGag+6laoX/iD1Y9sNv2ZoCfdT0C+FV4lkQ/i0gHFLEXyOsNI8+J3PL3f+0vtXbQInMjvjogM4siN0pkkuhDownSzT6iGEH7I7ta5c/pm8l6hnEJWJ0o6pVEGZkgekkd+dgpgE4m4MsI8vIE=
Received: from DS2PEPF00004555.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::50a) by SA1PR12MB7410.namprd12.prod.outlook.com
 (2603:10b6:806:2b4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 21:35:57 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:61f:fc00::379) by DS2PEPF00004555.outlook.office365.com
 (2603:10b6:f:fc00::50a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Tue,
 28 Oct 2025 21:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Tue, 28 Oct 2025 21:35:57 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 14:35:56 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 28 Oct 2025 21:35:42 +0000
Subject: [PATCH v2] x86/amd_node: Fix AMD root device caching
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251028-fix-amd-root-v2-1-843e38f8be2c@amd.com>
X-B4-Tracking: v=1; b=H4sIAC03AWkC/3WNwQ6CMBBEf4Xs2ZV2EQRP/ofhUMoie4CSFgmG8
 O8W7h5fZt7MBoG9cIBHsoHnRYK4MQJdErC9Gd+M0kYGUpSrKlPYyYpmaNE7NyOZIqeKS12Qgah
 MnmN+zr3qyI0JjI03o+2PkVmmdC2L1E6fo91LmJ3/nt+LPpw/N4tGhZapvGfaZreqe8boat0A9
 b7vPw3EzInEAAAA
X-Change-ID: 20250930-fix-amd-root-2a6529e8162a
To: <x86@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Filip Barczyk <filip.barczyk@pico.net>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|SA1PR12MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 976c28e2-8bf3-4a9f-4aea-08de1669fb19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azQ4eEdoRUh6UW1TK3NYRHVzeUQ0MHhlbW9ITFFYWEdjbGRZbzRFY1JKSEo0?=
 =?utf-8?B?ZTRTNzZqTVdMSmRWQjkyczNiVDh3citWdkNKRXN6UFpBR1lKcE13cnZ0RUhm?=
 =?utf-8?B?VUxadDB4MmZFVWo1a201R3RyWkJsZkNwZGlMOFRHTFRyek9heVg5VGJnZlE4?=
 =?utf-8?B?WXdETjUvRVlneGdlK1pxQ1pONFQzc0NNUlBGd2pDWk5oNlA5cjRMWFVCZUdC?=
 =?utf-8?B?cGYxbFlsa2hUcmQyRzBSaXNFamZlRWY5MFVxQU5USGQ1QUVSeENJeTdFN3Vh?=
 =?utf-8?B?ZWpWZFNFdUZFZXliSTlnVzA5enJWVys0Z3A1Q1pLTTh3WnJGS0wwN0ZyaTFr?=
 =?utf-8?B?aEx5ZG1iY1ZMdjNxSzlLNzlDTWZXZXkzbHA2SWRNY1V0SU5wVXMxUDR3TkxU?=
 =?utf-8?B?bE1WWmU4b3oxYzNqcjdWdllTNDBaTlQ5dmNyMVp5eDZ4bjM3V2dVRUtrbm4w?=
 =?utf-8?B?Ri93cnV2dW9USE5RM0M2VkUzY3g2R2thNVBWL1o3RDQzeUZSZEUvTThtOVhy?=
 =?utf-8?B?U09TdTFpV3h4b24yVVlMRVRlQjBrYXo0VHp5bWlGajNMQXo3VXNvc0w4WUFK?=
 =?utf-8?B?cERPRGZmZlFMcTRiT2VKN1BNVHRsYlZSZHRIY0RJMnMxdHZmNzc2NXZwVmhQ?=
 =?utf-8?B?V2dqRlJCanRaZ0d1TnNJN09aWlJHSHpDT2JlRExVdXhqL2ZzQTB6SGpwTmlv?=
 =?utf-8?B?TmtrZGp0RFliRjZDTThObUNRQ1hWTVBQZ0oyb2JpV0tUbUMrM2UzVnBGS1Jh?=
 =?utf-8?B?S3F5djAvTnQra3VnT0pMUnJTZ1dsREloWmxjL0tuL2kxTWhXSTlJS0E0MlVV?=
 =?utf-8?B?eFhmd0RKeS9CeldTZG9DYWh5UHZYNnNjQUFoN1JXUFhtQWJXNjRvSmM4MjU0?=
 =?utf-8?B?OHpmSysyQXYzS0xkMThNTVM1aSs4UEExMXBUVkZ1cUFUYVVFdklMUFRIczhL?=
 =?utf-8?B?QVVpbSt2Mlk5TVlNWkhOL1lhMFBkY2hxMm9xV2tnWEhGSE1maktHQzZwRTRM?=
 =?utf-8?B?WmJQNThDS2k1cEI4aGs2aHZQUFMvWjJrR1VTMi9GSVljTTJVN3hUVi91ZG1k?=
 =?utf-8?B?bGFRMGxWdHBsQm1POWhwM1hrR1BnTTFiZVR6OE03cHZoRCtqaU84Mi96b2M3?=
 =?utf-8?B?enNFelpqYzVnb1g4dUpIeUViRGR5WGtXMiszOW1sRUgySmQyVU4xdy9vK1RB?=
 =?utf-8?B?NG9RSEdadE1FakQzZlpiM0J1VVp5OTZJaWdtNmUxR2oxRlV4dHN3VTErWFRY?=
 =?utf-8?B?QzdHVi83UXhEdEQxNW1GQ3Q5TWppMnBtYUhzRXJ5NDRxdDF1RmFtYzFXU25p?=
 =?utf-8?B?N1U3ZVhEY3NPZGhsRmt0cHk4eHVUbFJPS1NNcFpPOG9xN1BzRExDWlpjMEJw?=
 =?utf-8?B?VzRzNWFGWHB5NTJZUVE4NDFkNmdnQWZnMHpOeEpkREpSNzdWVndpUWl0dnov?=
 =?utf-8?B?YjVoaDB4TjlNcXZTZXkzblpYelo1M0pFb3lheFpDTlZyM2lKeVdjaXkwTGp1?=
 =?utf-8?B?QXRaKzNWR2ZiMVpQUFg4Njl4SWJwcFg4bkhtWW5UcHZsenJLa2h0cjBQaHNQ?=
 =?utf-8?B?MFNLME9PeE52RDVtZW5veG0yMWZYM3Bkb0JpN1E0bVZZL3Bsczlha1Yrai9I?=
 =?utf-8?B?Z0wyVE50dlZPSXB1aUY4QmtwdmdnM2Rnd2tFSTEwSVF0b2daYXpzSHd2b3pU?=
 =?utf-8?B?eklYZDlHTmYrQS9pckJVM09uMkhiTnNjdkd5NlNlcytZak0zOWlxa1JKbzVa?=
 =?utf-8?B?MExCZXYyVDNEelpTVkUvdGIvditybmtBVUEvTXNmNGFmdCtFWXFiaVZhaUxR?=
 =?utf-8?B?cTlTVDJMYytTZVd4TEsxMWI4Tm1lMmdGWlNjU3lrWS93MEFQRWVmeVZYV0tF?=
 =?utf-8?B?QzRUZTJXaTg5dTh3QlJWY01RaGF0a3NUelZGZGl4TngyaE53VGI5Zk56WFY5?=
 =?utf-8?B?VU9xSGVmL3JYNXZoWlhjUHE1d3hYdDRxNUw0Wllhb0RJMzVqR0VEQU94RzNo?=
 =?utf-8?B?cER3TEU3ZGJHOUt0UHF4azB2OFY3d0tycVNkYjlCNWJvRXovcldmeGF6NGpL?=
 =?utf-8?B?YWtxMmgyMDA1bUw1Q3BXMFQ3VmxTNWEvdkcrSW5JZnFiUkRsN2FNcTQ5eEFV?=
 =?utf-8?Q?7MHc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 21:35:57.2757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 976c28e2-8bf3-4a9f-4aea-08de1669fb19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7410

Recent AMD node rework removed the "search and count" method of caching
AMD root devices. This depended on the value from a Data Fabric register
that was expected to hold the PCI bus of one of the root devices
attached to that fabric.

However, this expectation is incorrect. The register, when read from PCI
config space, returns the bitwise-OR of the buses of all attached root
devices.

This behavior is benign on AMD reference design boards, since the bus
numbers are aligned. This results in a bitwise-OR value matching one of
the buses. For example, 0x00 | 0x40 | 0xA0 | 0xE0 = 0xE0.

This behavior breaks on boards where the bus numbers are not exactly
aligned. For example, 0x00 | 0x07 | 0xE0 | 0x15 = 0x1F.

The examples above are for AMD node 0. The first root device on other
nodes will not be 0x00. The first root device for other nodes will
depend on the total number of root devices, the system topology, and the
specific PCI bus number assignment.

For example, a system with 2 AMD nodes could have this:
Node 0 : 0x00 0x07 0x0e 0x15
Node 1 : 0x1c 0x23 0x2a 0x31

The bus numbering style in the reference boards is not a requirement.
The numbering found in other boards is not incorrect. Therefore, the
root device caching method needs to be adjusted.

Go back to the "search and count" method used before the recent rework.
Search for root devices using PCI class code rather than fixed PCI IDs.

This keeps the goal of the rework (remove dependency on PCI IDs) while
being able to support various board designs.

Merge helper functions to reduce code duplication.

Fixes: 40a5f6ffdfc8 ("x86/amd_nb: Simplify root device search")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---
Hi all,

Recently, there have been a couple of reports of the AMD64 EDAC module
failing to load on v6.14+.

This has been root caused to the recent AMD node rework. Specifically,
the root device caching method breaks on non-reference boards.

I've squashed together the two patches in the last set. I reduced the
loops from 3 to 2. I didn't see a way to go to 1 loop without needing to
allocate extra temporary memory. And I figure that wouldn't be worth it
just for a single loop done at init time.

Thanks,
Yazen
---
Changes in v2:
- Rebase on tip/x86/cpu.
- Squash patches together.
- Combine "config space" loop with "counting" loop.
- Reorder memory allocation so it happens only after other failure
  checks pass.
- Swap "num < num_nodes" and "root == NULL" loop checks to short-circuit
  loop exit.
- Update commit message with another example.
- Link to v1: https://lore.kernel.org/r/20250930-fix-amd-root-v1-0-ce28731c349f@amd.com
---
 arch/x86/include/asm/amd/node.h |   1 -
 arch/x86/kernel/amd_node.c      | 150 ++++++++++++++--------------------------
 2 files changed, 51 insertions(+), 100 deletions(-)

diff --git a/arch/x86/include/asm/amd/node.h b/arch/x86/include/asm/amd/node.h
index 23fe617898a8..a672b8765fa8 100644
--- a/arch/x86/include/asm/amd/node.h
+++ b/arch/x86/include/asm/amd/node.h
@@ -23,7 +23,6 @@
 #define AMD_NODE0_PCI_SLOT	0x18
 
 struct pci_dev *amd_node_get_func(u16 node, u8 func);
-struct pci_dev *amd_node_get_root(u16 node);
 
 static inline u16 amd_num_nodes(void)
 {
diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index a40176b62eb5..d0a9efddf7d6 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -34,62 +34,6 @@ struct pci_dev *amd_node_get_func(u16 node, u8 func)
 	return pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(AMD_NODE0_PCI_SLOT + node, func));
 }
 
-#define DF_BLK_INST_CNT		0x040
-#define	DF_CFG_ADDR_CNTL_LEGACY	0x084
-#define	DF_CFG_ADDR_CNTL_DF4	0xC04
-
-#define DF_MAJOR_REVISION	GENMASK(27, 24)
-
-static u16 get_cfg_addr_cntl_offset(struct pci_dev *df_f0)
-{
-	u32 reg;
-
-	/*
-	 * Revision fields added for DF4 and later.
-	 *
-	 * Major revision of '0' is found pre-DF4. Field is Read-as-Zero.
-	 */
-	if (pci_read_config_dword(df_f0, DF_BLK_INST_CNT, &reg))
-		return 0;
-
-	if (reg & DF_MAJOR_REVISION)
-		return DF_CFG_ADDR_CNTL_DF4;
-
-	return DF_CFG_ADDR_CNTL_LEGACY;
-}
-
-struct pci_dev *amd_node_get_root(u16 node)
-{
-	struct pci_dev *root;
-	u16 cntl_off;
-	u8 bus;
-
-	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
-		return NULL;
-
-	/*
-	 * D18F0xXXX [Config Address Control] (DF::CfgAddressCntl)
-	 * Bits [7:0] (SecBusNum) holds the bus number of the root device for
-	 * this Data Fabric instance. The segment, device, and function will be 0.
-	 */
-	struct pci_dev *df_f0 __free(pci_dev_put) = amd_node_get_func(node, 0);
-	if (!df_f0)
-		return NULL;
-
-	cntl_off = get_cfg_addr_cntl_offset(df_f0);
-	if (!cntl_off)
-		return NULL;
-
-	if (pci_read_config_byte(df_f0, cntl_off, &bus))
-		return NULL;
-
-	/* Grab the pointer for the actual root device instance. */
-	root = pci_get_domain_bus_and_slot(0, bus, 0);
-
-	pci_dbg(root, "is root for AMD node %u\n", node);
-	return root;
-}
-
 static struct pci_dev **amd_roots;
 
 /* Protect the PCI config register pairs used for SMN. */
@@ -274,51 +218,21 @@ DEFINE_SHOW_STORE_ATTRIBUTE(smn_node);
 DEFINE_SHOW_STORE_ATTRIBUTE(smn_address);
 DEFINE_SHOW_STORE_ATTRIBUTE(smn_value);
 
-static int amd_cache_roots(void)
-{
-	u16 node, num_nodes = amd_num_nodes();
-
-	amd_roots = kcalloc(num_nodes, sizeof(*amd_roots), GFP_KERNEL);
-	if (!amd_roots)
-		return -ENOMEM;
-
-	for (node = 0; node < num_nodes; node++)
-		amd_roots[node] = amd_node_get_root(node);
-
-	return 0;
-}
-
-static int reserve_root_config_spaces(void)
+static struct pci_dev *get_next_root(struct pci_dev *root)
 {
-	struct pci_dev *root = NULL;
-	struct pci_bus *bus = NULL;
-
-	while ((bus = pci_find_next_bus(bus))) {
-		/* Root device is Device 0 Function 0 on each Primary Bus. */
-		root = pci_get_slot(bus, 0);
-		if (!root)
+	while ((root = pci_get_class(PCI_CLASS_BRIDGE_HOST << 8, root))) {
+		/* Root device is Device 0 Function 0. */
+		if (root->devfn)
 			continue;
 
 		if (root->vendor != PCI_VENDOR_ID_AMD &&
 		    root->vendor != PCI_VENDOR_ID_HYGON)
 			continue;
 
-		pci_dbg(root, "Reserving PCI config space\n");
-
-		/*
-		 * There are a few SMN index/data pairs and other registers
-		 * that shouldn't be accessed by user space.
-		 * So reserve the entire PCI config space for simplicity rather
-		 * than covering specific registers piecemeal.
-		 */
-		if (!pci_request_config_region_exclusive(root, 0, PCI_CFG_SPACE_SIZE, NULL)) {
-			pci_err(root, "Failed to reserve config space\n");
-			return -EEXIST;
-		}
+		break;
 	}
 
-	smn_exclusive = true;
-	return 0;
+	return root;
 }
 
 static bool enable_dfs;
@@ -332,7 +246,8 @@ __setup("amd_smn_debugfs_enable", amd_smn_enable_dfs);
 
 static int __init amd_smn_init(void)
 {
-	int err;
+	u16 count, num_roots, roots_per_node, node, num_nodes;
+	struct pci_dev *root;
 
 	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
 		return 0;
@@ -342,13 +257,48 @@ static int __init amd_smn_init(void)
 	if (amd_roots)
 		return 0;
 
-	err = amd_cache_roots();
-	if (err)
-		return err;
+	num_roots = 0;
+	root = NULL;
+	while ((root = get_next_root(root))) {
+		pci_dbg(root, "Reserving PCI config space\n");
 
-	err = reserve_root_config_spaces();
-	if (err)
-		return err;
+		/*
+		 * There are a few SMN index/data pairs and other registers
+		 * that shouldn't be accessed by user space.
+		 * So reserve the entire PCI config space for simplicity rather
+		 * than covering specific registers piecemeal.
+		 */
+		if (!pci_request_config_region_exclusive(root, 0, PCI_CFG_SPACE_SIZE, NULL)) {
+			pci_err(root, "Failed to reserve config space\n");
+			return -EEXIST;
+		}
+
+		num_roots++;
+	}
+
+	pr_debug("Found %d AMD root devices\n", num_roots);
+
+	if (!num_roots)
+		return -ENODEV;
+
+	num_nodes = amd_num_nodes();
+	amd_roots = kcalloc(num_nodes, sizeof(*amd_roots), GFP_KERNEL);
+	if (!amd_roots)
+		return -ENOMEM;
+
+	roots_per_node = num_roots / num_nodes;
+
+	count = 0;
+	node = 0;
+	root = NULL;
+	while (node < num_nodes && (root = get_next_root(root))) {
+		/* Use one root for each node and skip the rest. */
+		if (count++ % roots_per_node)
+			continue;
+
+		pci_dbg(root, "is root for AMD node %u\n", node);
+		amd_roots[node++] = root;
+	}
 
 	if (enable_dfs) {
 		debugfs_dir = debugfs_create_dir("amd_smn", arch_debugfs_dir);
@@ -358,6 +308,8 @@ static int __init amd_smn_init(void)
 		debugfs_create_file("value",	0600, debugfs_dir, NULL, &smn_value_fops);
 	}
 
+	smn_exclusive = true;
+
 	return 0;
 }
 

---
base-commit: ddde4abaa0ecc8395e0fcfa3e92f65d481890cc8
change-id: 20250930-fix-amd-root-2a6529e8162a


