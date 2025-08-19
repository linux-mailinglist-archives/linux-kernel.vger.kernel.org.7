Return-Path: <linux-kernel+bounces-776401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FABB2CCEA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479871C20273
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1264326D66;
	Tue, 19 Aug 2025 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="goEUp9tA"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E085322DD4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631341; cv=fail; b=Owry7PdSVSrSIUaQcxgco14TYpiLHd5bPuoWqAjI6uYBC2+9VHg8aA7SJKAPM9EuG4JuYofOJsZuh8t4Ki9Ihm0iZSSIIhnOcpmG3uBxx0p5dGJcP0qcMK3Trc5dslbKgJEephycs0NmPORgKoAxPplrT7HqSSsJbMAm+VkXGgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631341; c=relaxed/simple;
	bh=Fvs1p9YDGsVlqK/GHHdChRfhuRI4EeT1MhsYQfhVgQM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nnsgatB3zQMrQHaJc5Je5MlECDKsc1SUSkMcIB2Zj8OB6Q7xSDFU3/WmRbanaZ701zLH0zx/kKSW/svrjmUbheRHLz/OHVQ0XCLYcbzONxCAVN7fqB26yI0OPQltLQDuDii3FPrNxCsRrZmeHjsXP9q/vHe+O+5aJSsoYvbQ2FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=goEUp9tA; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBIxUmfapF/t0TyvanGYb66f5U9kpc09ZKJ4JCXV37CKULmMGs6ouC60Phh9mS6I+N0Sa0FpeqKkSD1ahr8K8c+NguyggzmnSf8K1Kho9LNGflycISPgdL2xyjxO2pkhEg3ts2mA+AlhVdiOIvxxmAz30or+P/pDHm1jsMUNRuJ6mn0A8d073T9lXF2qDglWkqCFR36cTJbgqvrk9mtZvyfCRSrn0+ynM17pH7QDV54xU1E6MFuxtJES5lggKRbIZkeWDeIPAZv1Dbev7fSy298U47GqKj51F/kcgPHKj9VYxjW2RcYVhD82MMcxVwoMAv0GChIy+D1O7unBIcSHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVkMHt6WsNkOIFfDrjzVdy/G1eCMNq5207lxuIasUy4=;
 b=uwBrn7wAbIMpBIoXkD3+Yob12wh/VQhg1QK/kjFVLhKRQHHFU97r3lCp4FLpPKyHWLgonxUbFYNpjJ8+IFJGqCmYnIK6V6mVM8sP1wyiVeMhkCdGzZNCkPG31wTgaLPdDfAXKwCPldt1riS+f0ywFe2fvVh+tE+xoL5Zqwn9nrNFei4vZrYk7ncNG9cZAGI90MeI98YJvEb79pQOmRRMJ2iLLLpD6JHbDytIX0TLvJNBrFEUImVILq0N3dQwsWW2VRlKvxeRHceuxMmCfYue0hXgVlkiIxcR3DgOwQDTWxpyNVz/povN5ejHvzFZMcbl/XnWAakndtCJIXbEoG8xxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVkMHt6WsNkOIFfDrjzVdy/G1eCMNq5207lxuIasUy4=;
 b=goEUp9tA8Pi/2EIlM1iZnZX+4zfMmar9WAxni225CHSc0VckvOeoidkKbdIS0BV7g4hafql8sUXW/JxXyq0M+XkpV8uD3baTiG5BA7hmGf2ChqxNJ27YDnye5qRSJCDcuV79aO1Qo+AwkKDoNfp97oJv6Ipy3OK0INBE+LOPwUE=
Received: from MW4PR04CA0267.namprd04.prod.outlook.com (2603:10b6:303:88::32)
 by DS0PR12MB8478.namprd12.prod.outlook.com (2603:10b6:8:15a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 19:22:16 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:88:cafe::44) by MW4PR04CA0267.outlook.office365.com
 (2603:10b6:303:88::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.21 via Frontend Transport; Tue,
 19 Aug 2025 19:22:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 19:22:16 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 14:22:14 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/5] Bugs clean-up
Date: Tue, 19 Aug 2025 14:21:55 -0500
Message-ID: <20250819192200.2003074-1-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DS0PR12MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: b812c1e9-bcb5-4763-dcec-08dddf55b52d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KxgD0OuyWBjnq+9eU/MH4sfVIDUKLws9pxQBgeVssFqlb5WbgOfqvjMYdobK?=
 =?us-ascii?Q?JTq64QH/6XdnUO06tvKHzsqXo/rOblVlLkFQxLrZCC/QO9ntbLW/WgUmMLOI?=
 =?us-ascii?Q?B+7pdYTkv7P2OWikupj4iIcclymWBiOPV8D0AUyGExRjqDL8vHc3BQ5SaBXt?=
 =?us-ascii?Q?cfDADP52hz8Q9uPBGxg4O+Cq1MQNLe0qAByR4msbS93w3r4ME+Zv4U1RX4wm?=
 =?us-ascii?Q?AvpdYSgtxmKPnbqvSV/ZNNFvzp+ax6mN4Wp/wVphiXgVm78/70gi+9cdJSsA?=
 =?us-ascii?Q?EzUiXHKZg7ypsoS5PCTaFXjzQrtCqspZK6DQh8Q9/gBw8/759QQGC5KZafIP?=
 =?us-ascii?Q?G2oZTBJNStK+vbuDPJlgce9Q4KxDXull0yiIk9YIUMjNaGUzbsQRV3Iu3sNp?=
 =?us-ascii?Q?4D6VG+a1+nw7a4cnSO2zNqmQO0CYrukoJ37y7b7pE2Wpy1kn3sp77A77ueyQ?=
 =?us-ascii?Q?JVRKMWjfItlRo96xVhoor9hXZWkyTU7H7IY8ORfeLjpWBHV/+OQ9OeV9w+kc?=
 =?us-ascii?Q?+Bvd0PaN3mKAzcanQYZF55Ls35J8/NhVD4BQ/JaTVe42tE29vwShsyYXTmu6?=
 =?us-ascii?Q?cG5zmx4vxXLdO40rYfDzId1ezMS8N0MsPBGwgnjso6P2ljtoYGrycHQ3a9q1?=
 =?us-ascii?Q?ByYnLwERwj/uX7V9IOqNKIpunRnBwOm8bGdkVKyuhdIC8J2Lpaf2Z2Fk242d?=
 =?us-ascii?Q?6XTR888lLaqQ4AJRx+d5pNhad1SllN2Dj6UYUOyaQdi2dHPiB06nImbhyzjU?=
 =?us-ascii?Q?GR8E56tVZQhoMKSFUEqTSE08g44YGAjO+POgCVXG7oIXGuOHzpbcaQpQZ5Tp?=
 =?us-ascii?Q?W2FNNd99TCcK1zK67++sC0gMosvdZBBATtcRgrpfltsTxId9bMx8fNVNa+yN?=
 =?us-ascii?Q?b2CAxyeoXTA9KIib75RR+fTb99mmjHFFcKgIPiMYvPC6n/+NPWlZAmq8r5A4?=
 =?us-ascii?Q?GEsLZA7d/RaAx+2ozFAaP0ykhtDKyd6pV2c9xFTKHBObLk7rfeRR+ZfMwVQu?=
 =?us-ascii?Q?A4wtD2BnbaMgpG5Q8EsDYEaU2W9bNgtiXgvIST++M7CpIU4i/ZTyxrY4eFBm?=
 =?us-ascii?Q?nD6yAwXQbbKaZh/RWMoIkNXjuXN57DuPFb0EO69aZIWcw/vi3LcShjtx6Sx8?=
 =?us-ascii?Q?qFwuNl5kDB3gKOkpFn1VZIT3eaE+6FTXNnuqsTJ/ODca4YO92hxHLIdXGjMp?=
 =?us-ascii?Q?Ad0OKdMpGARE16WpegtME1zhwqnghLhRHqb+r68LpUG6w/ZOSwZgYxptSL5z?=
 =?us-ascii?Q?AtPdmpblCF70C0vI7HLXOTqcZHYJ/uZ7Xd6rZggUYZwDrRUYVJ3vOcqRd6lY?=
 =?us-ascii?Q?QtzI4QXLbe4bQh6HN17pm3AqmQxP5wgoCGdY1DyhtjgVFUcWHIl8+UOprSZm?=
 =?us-ascii?Q?/DVnMwPipQDjr6BqAe5FoAEYfrrS67khFHIOva1Z9E+mBqT5qZohKCIf+MNH?=
 =?us-ascii?Q?kO/G/zWv3I/InWOu/HJlu4nmkMHjQowYZlMyQ85eskhqRwgOQ5f9P/eJW5I7?=
 =?us-ascii?Q?C1ABGnatT890Dg8nDlk/4baqgpaLZRXdwEbM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 19:22:16.0029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b812c1e9-bcb5-4763-dcec-08dddf55b52d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8478

Patches 1-3 focus on cleaning up parameter parsing.  Most mitigations use
early_param but a few older ones do not and look at boot_command_line
directly.  Modify those to be consistent with the newer ones.

Patch 4 adds missing attack vector controls for spec store bypass.

Patch 5 cleans up straggling unnecessary calls to cpu_mitigations_off().

Changes from v1
   - Removed spec_*_print_cond() functions
   - Fixed bugs pointed out by Pawan
   - Added last 2 patches

David Kaplan (5):
  x86/bugs: Use early_param for spectre_v2_user
  x86/bugs: Use early_param for spectre_v2
  x86/bugs: Simplify SSB cmdline parsing
  x86/bugs: Add attack vector controls for SSB
  x86/bugs: Remove uses of cpu_mitigations_off()

 .../hw-vuln/attack_vector_controls.rst        |   5 +-
 arch/x86/include/asm/nospec-branch.h          |   1 +
 arch/x86/kernel/cpu/bugs.c                    | 387 ++++++++----------
 3 files changed, 169 insertions(+), 224 deletions(-)


base-commit: 2fd6a6194558303fffd2d7a7fa73fc318d680f38
-- 
2.34.1


