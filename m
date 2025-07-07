Return-Path: <linux-kernel+bounces-720363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB531AFBABA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00A74261D2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6975267F57;
	Mon,  7 Jul 2025 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cy6+LaYz"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C2526656F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913222; cv=fail; b=ERdarLJLrDKbZDKijrgynwd3x0BCLv7g504rZQeMCCtoy4pPETGPRV63EYwL1TetPcRoobA1vsdeZ+kSuzCZGFbiZDqH26iDFt5sJ46q7GcZmbmft23A0NFzIVgK9/baJ+1x7uudA1sm3ok8iGvyRYttgdS/48rsvH6bKc9jkyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913222; c=relaxed/simple;
	bh=JgcakbMEy0RO9i/kdU6InVokJ3KO1cfoDGS3t0E34ko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSkVCjKIW+REhX2zPfXx8QLwpdf8LqlCCp9PHj+zcRZ+nuHvgLGfIJtp/0twmsPuMwNZouHD1Phtopw4svdaQd3nkKWJKyIVZnNn1In3h4XLkNsSyINthHT2JkkYju522oxLAuMInM6q1Sdz4952KZDxf326EZuUg3eocgKIOuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cy6+LaYz; arc=fail smtp.client-ip=40.107.212.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKcOTTnVPqEZ0VomRRo7BjRh8Cb31FvpRILZh0P1/JbfvDKOgbk5DGRUQGlgWcjBJzftX24uTGL3DFXduxGd25QI3yhGdaHqtHaLzbbwXjzVg20mFb0EOpp+htvZ8fl7G1HyqrKulyW3H7FfGvAHxJUw40PdnqWEmb0RI/joKxW4qgpQ41nNYKgQLqO+B6f0xo78z1thjmJGUwj7Ua+SAbybV8YefDWlym5YDMcpmju5ccEluyukqMPs07R88X7BBajeIpiMdhMd0+mEsNHvluJ4ZFEBOEAQIGSz8DiqkQnPuSgNsPFM9BCnBc2NAasgD2EM3RViTWHg2rzL5Iq/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAH5hpGnpnkEemJhi/fu5NUVdq7tPuJ/XXCmm/i0QOA=;
 b=guWrYaSPp4xJlU0XdyYH4IZmOWoBAqE5YaZgM64TcNDqodw/na9gpAy9JaRFS1Eb4QY/+GheoRubSuKdaXybBmC9cFIV/X3OZN85JedxlZs9sfIBCNXTFLyoGOLGRlBGjFtKRMk9BaVym4S0fmZkDCkhxcNQIjHajZgrWglxGyZfZ/0z+p+Neu8eDcHzKC0k7nepf1Aa37i92+ir8ItuQsLaitVPGBp/D81E1lcvC9bmD4xLao5N0XFVoD/bKMtRhLUHfDL8iXUeFYTwga8cWsho7szu+9sDbr+VOKToIB3qHkxH9/qoNbsf18GFN3nYaaywqCtEnDGU++xR1NYmDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAH5hpGnpnkEemJhi/fu5NUVdq7tPuJ/XXCmm/i0QOA=;
 b=Cy6+LaYzIFhww6cMjxqObdt9ES8sdkv1s6v8vMhpsTk1vytYSOlVNsNEuhW/rxILs9Sqz+K65rS+i73lSSlFOYhSQPsroeq8RG6C8QbDhk+mnwB2y91/ivCla7mnlsjrUAqRP6W7sQqECnb5lDiiKXlqWm8PgjJUxltQBx4OJcA=
Received: from MW4PR04CA0259.namprd04.prod.outlook.com (2603:10b6:303:88::24)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Mon, 7 Jul
 2025 18:33:34 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::6e) by MW4PR04CA0259.outlook.office365.com
 (2603:10b6:303:88::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Mon,
 7 Jul 2025 18:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 18:33:34 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:29 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 03/21] x86/Kconfig: Add arch attack vector support
Date: Mon, 7 Jul 2025 13:32:58 -0500
Message-ID: <20250707183316.1349127-4-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707183316.1349127-1-david.kaplan@amd.com>
References: <20250707183316.1349127-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: afa89713-3f63-4f6f-9fc0-08ddbd84c7d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E07/Y3JpnnbT+UoEIZ5p8U2Pw+yT5tnXy2Wxjqs/Gb9cnuz29mvPEDUkHcmb?=
 =?us-ascii?Q?78MiceV1HeWkL0PSlzUcpEdvJ/cr42IpNNfCpa4n6lmT+P/LogrD5CmqD9uG?=
 =?us-ascii?Q?xf6DFVp/gZZmpwVJLqQy/uYMx/57vH4/zevcaj7V4RRW9aN2iOefz4zdsJQd?=
 =?us-ascii?Q?t4JoMmJYsdxLOYIxC+jxx4OGW+IfoLEAM9X6mI7A3h1B9O5SlPyS8VC4fB/X?=
 =?us-ascii?Q?N2ppehh6jj4+ow01joAZdN6vm0ixmhFSpWNK8aAKm4JbW8PZLtWWZARRRpns?=
 =?us-ascii?Q?tB9fZbCbPQa0ZS04TgjfGocKZTPmcB5ctVgTdoVfHCdnibCsgHbW+1l6659f?=
 =?us-ascii?Q?n0xIKtoT0P+hKmwJN32UXgi8UmYsJBPZomlw7rBD6/sL+NdIZK3EiRNJfjFp?=
 =?us-ascii?Q?SpN7ZSPii4nc7CC9WPmp071EeMFZfyLz1dkmBWrYBxChdUlq8TbcGKttytml?=
 =?us-ascii?Q?a7Sr93GZMusXnA7wk2vjH9bvZoKZWz1jEdTuBS1zcMRQrR7e++f4+N9b8SHI?=
 =?us-ascii?Q?zH9mH9mVuxvRAG9z4/fftRl8GBA9AtRbn9SkqohRGFsxuS8/EQsCD2w6qPP/?=
 =?us-ascii?Q?OZzpSp8+uyiu628a0EXb7lsPXkmbc1C7+0ZOtA1nh5CR2nFRONzvVeCXht3/?=
 =?us-ascii?Q?MctmTVbw7MgHEd38KGpH9cOvmTyPV4/EbYF+nHXMMcLXDSUGCL/1L4CknJbY?=
 =?us-ascii?Q?TTbFpanGI63/7qg9rZIt9w//BhAS2fIh2ndDNtEwYK+XWgvk+8kk+/xDQiP+?=
 =?us-ascii?Q?QWstyZ4b/JnYltKJFJv8O7Egz4Xc9ORu81cGLoWdN8LAwfQXmWsH33vMhV5N?=
 =?us-ascii?Q?mapZpeMkSY8embogidTuZ5Njxice3OCUqFelAcs9kO0xFiRz1TEgQZ/VElvF?=
 =?us-ascii?Q?K3WWMkJ2E9zN6EUmOPS5DgkWV4kwNf66ct3KDf2GI5Xz4QtNs9dGD1jfzKe4?=
 =?us-ascii?Q?78Ddj84RPLPiwl30Ghv3tXCQdwXVnNicQiZS7N6eDGvduFzGElfCrrc8SHeC?=
 =?us-ascii?Q?iIurl+csgVfZYZlUbdpJcNjatMN+dA7izBJwO+0sXs6OvSDEQZc4CY9FS4zZ?=
 =?us-ascii?Q?RaJgPp726T/oveO08itGQdQV7pXHku4R8/5CnG9sPRDBbkJWQt0+ZHzyik2a?=
 =?us-ascii?Q?A+OrGxy/lnhOFvPif141ZwHRHQZAGMBDoJ8H0fzsTyv+kpIaXC8aUmkw3m3z?=
 =?us-ascii?Q?Oyavb0Eier9kVxjI7I6fPqfWs1bWxlsc0wDiOkWwIQcJDSFoGHvRfTAJpph6?=
 =?us-ascii?Q?xsiLxZbIrbX43naMR652RSCr0RaU8JJ1g7/yshvlcTvIrL1f+6Lhp6hatVuZ?=
 =?us-ascii?Q?EB86h5Pffwu8lGIjpM/bnkM/LzDPSB4KsraG0Bvqw7/RaqiVW6/BjbICQgY8?=
 =?us-ascii?Q?lrrXDg1QytFpdpS2QZTCw+Z4foclrbzqnj7+iL55dHz2+cbsE3HnUkmEGNWq?=
 =?us-ascii?Q?BU69CEAH8lTL4F0goBCjU5UKtQnJGe4bXol3iWkhm+RqCIRSILR6gZHouTco?=
 =?us-ascii?Q?WUwiUwlF1H7ePpGtnX7Qg1gei7zc9jzohZBZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:34.0991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afa89713-3f63-4f6f-9fc0-08ddbd84c7d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007

ARCH_HAS_CPU_ATTACK_VECTORS should be set for architectures which implement
the new attack-vector based controls for CPU mitigations.  If an arch does
not support attack-vector based controls then an attempt to use them
results in a warning.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/Kconfig     | 3 +++
 arch/x86/Kconfig | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9233fbfd8dd3..79668e95c199 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1772,4 +1772,7 @@ config ARCH_WANTS_PRE_LINK_VMLINUX
 	  An architecture can select this if it provides arch/<arch>/tools/Makefile
 	  with .arch.vmlinux.o target to be linked into vmlinux.
 
+config ARCH_HAS_CPU_ATTACK_VECTORS
+	bool
+
 endmenu
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 71019b3b54ea..49e30254d426 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -75,6 +75,7 @@ config X86
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if (PGTABLE_LEVELS > 2) && (X86_64 || X86_PAE)
 	select ARCH_ENABLE_THP_MIGRATION if X86_64 && TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
+	select ARCH_HAS_CPU_ATTACK_VECTORS	if CPU_MITIGATIONS
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
 	select ARCH_HAS_CPU_FINALIZE_INIT
-- 
2.34.1


