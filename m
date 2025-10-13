Return-Path: <linux-kernel+bounces-850730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB0CBD3A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58263E2886
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFA13093AD;
	Mon, 13 Oct 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4v48BZPX"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012046.outbound.protection.outlook.com [40.107.200.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60F93090DF
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366154; cv=fail; b=an6c0dzIlNaoQENPWCRY5AmN45K1ZQYpR7WtZqyhxRPG37Q/OnXmzdDtOcD5sm48kjbIBGzzQgz0hnmdiy8oDF1ibw35iwUjtfkDHQn/+BvMMi0Fe4W7IZ8Hc3A5PS/cmCMbMwK3GUBwNerfZAC0MRVAdK3d/31c+f6Fo6ap/Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366154; c=relaxed/simple;
	bh=aGwOHTRIJ5UKkc3fmrWliqguFIj2moiJPLQ88+Y0/oU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQXAqs41cjO7dRYPhwnmzpdSYa237CYG9+f6RpXEF8fYwPC//zDgGoQghMlGsVa/28+Oz/FDZyGZJ5w/N1+kkAnPNU2CgFgiraHsMmWP9h95Jj4zUiQGImHUJTWRPhHvx5kjwMmzVPjUuxiMbUQ7ThD37W6L2IHCixzXxJv4q5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4v48BZPX; arc=fail smtp.client-ip=40.107.200.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UahdrpzTrShDgCwnWLZehbrRTgQHUJZLoTaqoaAphNW4Y47+N6jwQ8k78QYz2JKrPdvm+vZcihcUiimeAccqUemJh7eKX+UGoU3TI9icawFku/8n1z/Wb2q3sM5w3Mc0/uOz/2DtA3VCA0OK6Fx0eMNJXrqvx1kyHOGYtwZfK3pOtikOJs5zxDBrfYnr1sq5BjqXKnnDNoDTtDOcojGx9GFfD3XBvuMFytYQX1k80XOgOS/Scp/x6gMiOfysc/25MsVi5w/0enBXuubbLu1sn/PD4ZC9RDio8ELsJ0lLrTVY/X+eoptmtL/BykDRhQPQbgl0mniTk3rA58RYEdzgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=989Z4arZKJGtxwebxOsFpXeKRyFQGdruxsm1oNCVcMs=;
 b=laSXmSwGEhlIrhWHLXJ5VWoEi68jC8sTJTG1362ks7JtUVmxWUsX0Dt2wO6r4O2vBDr1vMovVmv9sWnYZpPnVIIv9rgXmb83VEUxct7UBggRxJHcpB7trA6TCukVURzJ5LrDsPUcHLz40nJTXPXqH7k2teHk2PCRKnXJohp01hN/4wb8Jce1M0PyUEvGO0m2BxD7LC6/da9VwrhroQ0UzpF9lK7nJfNCeRIaclmKjEk0ofFnnurW6yTLu9xht1cBVBfwvpprRc/Dkc0VpT9xTM20zDqlXdpxowqjqM4a952y4qHzXqeBdUBAB5g3sf45FtxFo+xyZw77CHrAk5YQwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=989Z4arZKJGtxwebxOsFpXeKRyFQGdruxsm1oNCVcMs=;
 b=4v48BZPXTLKZIcyd2DiPGP7VKD8qjsiiNXU64bq2yVwuhjtDpBh9kivNK0/DPoVj6VFYZDQ+yUsq9D6dJicw6UmwUDnytxX2RgtlCX0OwVR+7RJTZC/DDcYUXV10yhArvYT/Y74tVGb6SoUW6uikGOR06P0iLCBt/JAA2OmHOxs=
Received: from BY3PR10CA0027.namprd10.prod.outlook.com (2603:10b6:a03:255::32)
 by LV3PR12MB9439.namprd12.prod.outlook.com (2603:10b6:408:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:48 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::e3) by BY3PR10CA0027.outlook.office365.com
 (2603:10b6:a03:255::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 13 Oct 2025 14:35:47 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:32 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 21/56] x86/callthunks: Move logic out of .init
Date: Mon, 13 Oct 2025 09:34:09 -0500
Message-ID: <20251013143444.3999-22-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|LV3PR12MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: a923956c-6962-4772-680b-08de0a65cce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5ilptM+Avzj7g8OYOmk8T47zkaJ9gzIZZ6sPMwlTho0J2ABnZX3vrFjvDcCm?=
 =?us-ascii?Q?fcJEthZVC0NG5jFHRFN0WEwgUIOtp/uVyIQDCwSz4UTmFQHqkqjWGyclcNTx?=
 =?us-ascii?Q?ek01RhMJQEjhWv4qu4ZdlJlJ893Z9gJBRVQgmb0Crw6yVgwXfJlUDsxneHCh?=
 =?us-ascii?Q?2nfWEkuhJ+qPF5ljy6BY8QXKaq9pOabKT0+JPhBsdcEAk+TA95cb31z0s3eY?=
 =?us-ascii?Q?We3vtVT+MmxA64JciDLuyRE5ETGmeclQosGl5xEQQKQBKHADtQVDmgEiwW5H?=
 =?us-ascii?Q?kMsTvU8HOtA8G3ItF5Li8iozhZUeXdqKGIr42amvLS8qf9LUZ4V5rzw6Aj3o?=
 =?us-ascii?Q?aLo1buMzkYad/n+2teG9BRG3ELBIBAbZEqXPPvKV4/4puJDn+EBsz1D2oyBl?=
 =?us-ascii?Q?m2zKHkl9YDaScZeJnu53XitQIMV2fiarRjLmUBLl0Hd+TSKZxe2n+C8zL8vx?=
 =?us-ascii?Q?HGh1+B9BtCxitR+bTJX3pwKH2XxsXbrgBTm0EZCx5njPzCRysEPe0RU0xBcj?=
 =?us-ascii?Q?5dqhqn39YivgCZ4e8o2q95xbxyqfHfha4iQJLHNvJxueq5Wb0TRo62AhaNpA?=
 =?us-ascii?Q?M0R0ZrmzJn8VihI2fjIlyrqsaNMQucHTJQdZm9YbiUENs00lyi2dTkBBRi3u?=
 =?us-ascii?Q?TDMKBXZw/ZmVaVmNZqy1n44w0eQHcEi2hjU7LTSxsT/HC3UQ7GiMYIO32/77?=
 =?us-ascii?Q?PZuKsc7YZxLNQsPaVbU+G0Q9oGzM8FC9bq6msLvNTe3hw7SDxe0mKesOmn5e?=
 =?us-ascii?Q?Nrq5JZdCl+VF0oDdlK1qpQBzCf6wSm22zZ1e3yk4DgWPDRU8eyqcUmVRAN8R?=
 =?us-ascii?Q?PGqjH1dJeUcl4NpFIvmFuIZxf+yt+kHJyDkJFL2GkcYHREy2l5SsC8UJC4Ay?=
 =?us-ascii?Q?vyer+noo0VmWvkoyk5H60fSfQNEcfg00uBlfosToZQuVH4kxOs7yZTUPVPo7?=
 =?us-ascii?Q?Emyzi85nM9iw1rFbMUxmbcDToUNQiLOI9G0o7fDfIRcL0sY6t4Et/IpOCCMt?=
 =?us-ascii?Q?nQMY6fhseqB9c8+Weud+39B/GlwOpSfXcccYlF5VTXnho8hPYl2eNZVBS+eR?=
 =?us-ascii?Q?4VqRy/wZawBj4xqft3gwxpK81nEtPz7q9d6OdoZJOkgqplWIp8kX/ZAGR5P/?=
 =?us-ascii?Q?vPZ2qfjhxWFX2D9NHF9nEFs+WWkvK9mgHV9nRtsLWRHGKc8gdZdzDph66LRV?=
 =?us-ascii?Q?EjMGAyWiYz9rs/8zebrr++nTicnBcwD5RxW/hUdIg/rzLFmsBrN6zxLX9BeX?=
 =?us-ascii?Q?AUDH5Pb0EvZa4MA64PwXvSgm6fcdP04hkw/hx7ZChp7pH4bHFyYO1/oqllNm?=
 =?us-ascii?Q?mzKphZcWB/XP8li0ZtkK6nGFl06e/c/AyeyxvcKieNcbI99oBGoXUoZ731TE?=
 =?us-ascii?Q?Ac9KQhsgbcNSEUwvBj29yUB4ktcJLTt4zbUzchrezc9pdYHoj5qZ1vMxjGHd?=
 =?us-ascii?Q?cmDfiySy+Kc0R9unMj/6yzlSW8agbmsxee8i2ZwO6xgkEKgj79uEd/Z1Wbxn?=
 =?us-ascii?Q?oH5Ldpzo3ZJaMRr0ZbfAnG3HCx2I2JWwCZVKjCmf0wN0ymwTGzIrMqW4BluX?=
 =?us-ascii?Q?yaKJ8m7Zqem8TIYN+rg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:47.7290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a923956c-6962-4772-680b-08de0a65cce4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9439

With dynamic re-patching, these functions may be called at runtime so
move them out of the .init section.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/callthunks.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index a951333c5995..758e655f36a8 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -56,7 +56,7 @@ struct core_text {
 	const char	*name;
 };
 
-static bool thunks_initialized __ro_after_init;
+static bool thunks_initialized;
 
 static const struct core_text builtin_coretext = {
 	.base = (unsigned long)_text,
@@ -151,7 +151,7 @@ static bool skip_addr(void *dest)
 	return false;
 }
 
-static __init_or_module void *call_get_dest(void *addr)
+static void *call_get_dest(void *addr)
 {
 	struct insn insn;
 	void *dest;
@@ -204,7 +204,7 @@ static void *patch_dest(void *dest, bool direct)
 	return pad;
 }
 
-static __init_or_module void patch_call(void *addr, const struct core_text *ct)
+static void patch_call(void *addr, const struct core_text *ct)
 {
 	void *pad, *dest;
 	u8 bytes[8];
@@ -229,7 +229,7 @@ static __init_or_module void patch_call(void *addr, const struct core_text *ct)
 	text_poke_early(addr, bytes, CALL_INSN_SIZE);
 }
 
-static __init_or_module void
+static void
 patch_call_sites(s32 *start, s32 *end, const struct core_text *ct)
 {
 	s32 *s;
@@ -238,7 +238,7 @@ patch_call_sites(s32 *start, s32 *end, const struct core_text *ct)
 		patch_call((void *)s + *s, ct);
 }
 
-static __init_or_module void
+static void
 callthunks_setup(struct callthunk_sites *cs, const struct core_text *ct)
 {
 	prdbg("Patching call sites %s\n", ct->name);
@@ -246,7 +246,7 @@ callthunks_setup(struct callthunk_sites *cs, const struct core_text *ct)
 	prdbg("Patching call sites done%s\n", ct->name);
 }
 
-void __init callthunks_patch_builtin_calls(void)
+void callthunks_patch_builtin_calls(void)
 {
 	struct callthunk_sites cs = {
 		.call_start	= __call_sites,
-- 
2.34.1


