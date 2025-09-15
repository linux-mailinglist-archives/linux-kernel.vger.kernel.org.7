Return-Path: <linux-kernel+bounces-817089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0E1B57DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73CE63A59BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FAB2FE597;
	Mon, 15 Sep 2025 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fQuzh6Bf"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6163B1F239B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944048; cv=fail; b=hQtz9U/hSfZcVKVl8ewdb5aeEOm0e18/T5iO9Ppkj+X6pYaYBCe0674cmf/EzWDbtdZ1v2pb92FLYWv+rvGtwX2BeKMJRJTnSFWiUWAyim3B4N6xS8qGc3CnWAaHoPE4NwfQl1RoqIy2Gbdg6ut2F1fSjcu21MK9b1aICxllc8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944048; c=relaxed/simple;
	bh=xwyHWlzQqZb6xlsrVMTkVwlS6jmM3TB5DlLK4IegOsg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t6jy3kuYBJg02dlUVGMu/HD0WqZBa2lMmlcJpDAYrz0wSrCK6Xoe0FoS9Q/WWBvAE/cl3XNPbmrXe7CxMOCULh7vtOmhoWf64/hYQjoBE+f9/fvkInNPRWAoG0CyIpSFKsa7YILn8T7Cm89GnryFZG5jpM5cqo0ogbGDNJOH7lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fQuzh6Bf; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSQL2xPXvwESsAGkHb3BrvbthBm4QAk3C93P+gxQyTxZQsE5zsbirVjQfEGB32Q1VqLYVltglvSSutyHQNewl03pNn5xPQtkBpXnFXmfYbBWmhE3/JNHFFQjBfQtHqU7TXVFblNTiF1WpwtQyAzXhBovBCNChzmbsT8lZoS4Zz6wc92k9nA18sn/Yc1TmB+g5mOhqhjYMxl3IFmNQuVNyUEZYaHklmZwrOBAutZt8DjOk1ZrIq1yPuBCwNP3cqpXcpC4SAtICJ4XCrtun459MiRLCr39U7qQHeWZRQVTL+ZvVoEkguBcOuwWT+KwiY6i5RHdgFjK8CYtskySv76VaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oA4c1D7ulKlrzicPtrKw6y2L8e/34Q5kc/W78tnbuus=;
 b=oC3BK7Sat0FkPd/w5tivuOD4tXA8jK4xH9Y9LXouMHlJ2sC1qBOgFIWPNZYvnb1od8tdAdxw6CQmk7l6jyYsmzVaTrI6wz47lCo4H7gVvDYlToyPMts4JsF22X3rWHIF0v2ks7igG0/KLsxSzs7YQGtwLxvky65PkKFviha3/hISzeCmmGmn2ecyTtYms+LWaCVCKYQmUG3NhZCK1xGm7g8WmOa2tpAOIHkYU83W/XKrMkKeBuUdU4JBwVhJ/WllN9vYJI5xHnZyVvTJ5zvqhN7bpJKwgfOablRrG1Kz74a+bW976iIQ+wgf6/eExOpf+Zf9yYtHH13EVGiBFS/YAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oA4c1D7ulKlrzicPtrKw6y2L8e/34Q5kc/W78tnbuus=;
 b=fQuzh6Bf9usrdw36BRMrQKJr1CW/nNK6HGMY6xDToZE2KZ38C0/HEvGjC7QDoBSqYpEXRbZf+6CcU/Afxc8V9v13ePtfjf8cBwgJCWWRvS4WjWnHEe0kYQR4sjZsFiNT3NEPFglMSfCJN6mslpX0ewY3dRyfjloIAXgpY1AlNp0=
Received: from SJ0PR03CA0104.namprd03.prod.outlook.com (2603:10b6:a03:333::19)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 13:47:22 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::11) by SJ0PR03CA0104.outlook.office365.com
 (2603:10b6:a03:333::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 13:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 13:47:21 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 06:47:20 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/7] Bugs clean-up
Date: Mon, 15 Sep 2025 08:46:59 -0500
Message-ID: <20250915134706.3201818-1-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: 1468b3b2-d318-487a-d933-08ddf45e6543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j//Xs9vXeoCTGDjHDAkdUEQ99eBoZQ03cGLqvEhglOl7RYd0e0ePotcYAAQc?=
 =?us-ascii?Q?Nl6GZTEeDu2eumrY1ykRAeDJ4VuHxWnqycGiFxRnUMeIzteu8xhGnra1i2ce?=
 =?us-ascii?Q?NQYqg0By1ADTSwPdGFOg3xZ3sUhZzbOGsacYh0nfxFG0YlMISd3RgVnaNWME?=
 =?us-ascii?Q?yLaGnECHbhnfOR3HsbB315/HBxK4SIMr+LNCKYtV442bplaci/LWx3b1e1Iz?=
 =?us-ascii?Q?RS3hG8NUjFPX72D4ojDEFQ3+7bpKLYsUNGy0caWe7JovMuWJ3WO4xahjbNnA?=
 =?us-ascii?Q?cLx5n+tujuuVNWeTDveX//quozVzKXCn2nwQb0VjQhNDVs9K6THXHxJ0RyAR?=
 =?us-ascii?Q?yWmPXLPjW8RUP4uy/bK7Ze7DvzPZgkQYfGv0LtxzwyHhj+soNhWegee9nw9Q?=
 =?us-ascii?Q?xJkWe3N+Nwot3mWclblw+63ZOQHnT7rHYNaKT96uTdeMDlh74RVfgUMIHtj9?=
 =?us-ascii?Q?bDoXTvd64Qpv/q8FgwLMZtP8+4Gch4kRCkssSwpjtVzKuTq4aKXj0UCo5j0R?=
 =?us-ascii?Q?Tk+89vQyG4WN8mLVZbR5RcX7sUi0pZkwBp8mC6zBggK4t8NBBsDxQ7lVGx9L?=
 =?us-ascii?Q?LCCKM8kquVfzFViyCQNmo5DE4p18DKWhmZWrR2QktwUcOcwLYaI+o4N8r3Vj?=
 =?us-ascii?Q?7RdPNcwfGjuWT4BM2Jm9o6uOeekOgru3L7CKSdEvrkfV2fE5Vb5Arpk9LCTZ?=
 =?us-ascii?Q?dYQITlvHvPO+BdMfJlpCd+MwzEDWdvU9ZFLm2SSS3dZidybldtBhw9k2NMNO?=
 =?us-ascii?Q?PE9XddDSOVFj+Pi+BvWbXywBFzC7tMML2YqwcgUn+4RIERm4LhmDQXOZ3kOe?=
 =?us-ascii?Q?Y7cEStA00z3srderf4MVJVoFaGcgWQAjz1p/9+rpIJhPf2WE7J2+ofeUmITd?=
 =?us-ascii?Q?Y1MwgjwmzVxTZ7KZSfw1p1WobTKZ/duhiDyvsQhcHR6hKt0tRoxGpMZ8c14M?=
 =?us-ascii?Q?shJ61WoTZzJf+j+hNMcJOc6+ZS5R2vuckdWVYmbyngGzuQOknhqXhZXJQyVp?=
 =?us-ascii?Q?+kJ9muTHLoAo4cx0S7v7MldHZtPglLmB8pNHkN25mt8uuKuKllVs2N87v/PF?=
 =?us-ascii?Q?7xxKOgFbZkTu6RxqkS/1YaLyvTkz9GJjvboJZQyAd+AqEx8L+QvaspEiWraO?=
 =?us-ascii?Q?Av0DJmAgCFqte2BlDBfLwweaUtUmtoWDKA752IcpWhqX/XCMClowr/WpBjuI?=
 =?us-ascii?Q?XxHcQxASGpKiOrRuqqKtKw/TmYxJRfO8aHaS0bIOrRa5opq1ryNJ/oh4iwN+?=
 =?us-ascii?Q?8JpjQ5nhSJOCo+JIa+91ENpxTiCIGnaCx3HhVhkvsWEEOlPnHBsNVkU+fukd?=
 =?us-ascii?Q?KEU2dqYuQTAjZK1f7jfxro+wkoG4tpnwRDgC/ne/UjBwLuuPKugi7+0cRvG0?=
 =?us-ascii?Q?C8g48XR5hAwafQzxVEKxW2l5FKncJoLdmay9aV97qWYoh2GpS45vaCldciMU?=
 =?us-ascii?Q?g/DXRRNbrDamubo/i2gN41cazxADA9XapKkcsA7/aceJ47D0IXVk1CEaucBp?=
 =?us-ascii?Q?QV3XlQvMcezutuqt66KnCkHvHXP239/5sDaE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:47:21.8117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1468b3b2-d318-487a-d933-08ddf45e6543
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520

Various minor clean-ups and bug fixes related to mitigations.

Patches 1-3 focus on cleaning up parameter parsing.  Most mitigations use
early_param but a few older ones do not and look at boot_command_line
directly.  Modify these to be consistent with the newer ones.

Patch 4 cleans up some straggling unecessary calls to
cpu_mitigations_off().

Patches 5-7 (new in this version of the series) fix some minor bugs related
to the behavior of and reporting of certain command line options.

Note that v2 of this series included a patch for SSB attack vector controls
but this has already been merged.

Changes from v2
   - Fixed bugs pointed out by Josh on Kconfig settings
   - Added patches 5-7

Changes from v1
   - Removed spec_*_print_cond() functions
   - Fixed bugs pointed out by Pawan
   - Added last 2 patches

David Kaplan (7):
  x86/bugs: Use early_param for spectre_v2_user
  x86/bugs: Use early_param for spectre_v2
  x86/bugs: Simplify SSB cmdline parsing
  x86/bugs: Remove uses of cpu_mitigations_off()
  x86/bugs: Fix spectre_v2 forcing
  x86/bugs: Fix reporting of LFENCE retpoline
  x86/bugs: Report correct retbleed mitigation status

 arch/x86/include/asm/nospec-branch.h |   1 +
 arch/x86/kernel/cpu/bugs.c           | 403 +++++++++++----------------
 2 files changed, 168 insertions(+), 236 deletions(-)


base-commit: 584a19f9b54926dd1d3fec0a1e9b1fde801d9f23
-- 
2.34.1


