Return-Path: <linux-kernel+bounces-739745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2443CB0CA58
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675703BCA3C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C312E1C5C;
	Mon, 21 Jul 2025 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DWSo/bth"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7482D9EDD
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753121547; cv=fail; b=UumUKG91ntj2NMOmoJ3YPwq08OtTVkF/NOvn9qeE8nDCfi8+bInfMv3njLTLkjvn0xouySuCIqiUz+Z/x0IR/nfuFXwLcF4LoMdD2YbqGhzC38ad3w4jQHgaKfSIuYA3HaT8EG+D31tcTy8oT8+dcjA/8mYqEGeOsueCpghlAV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753121547; c=relaxed/simple;
	bh=FgN1ctujMyf+2/dnm6ik7fWS1Ttl6vkQUyijCTg3u/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ApyDEmeHCDUjlLCSx8a3WaMlnKNQcBy5o2ss6e5i/z64iiBRWCbs597M7vWNfjqCmWQS5xEs6wVzQ+jWdzUZh5Z4woEhtZtexX0NmFWT65g9pR82q1neWWERwVza3YyQzryEJ9UdRWWFHaTykXIzZ0W+qrgL5iTpUoJE+AnI74c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DWSo/bth; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxMkB9YQEVNGb9/x+394HIvPzETaFe9hwwP4sNUdLTN6cE3nw6nGgr5Sv2bO+vaq86Qz/S2cOkkX9cz2pqbJtiJP5uDiF7bVXMX2AnfIysh2sFxHU4s8XIg7p1wEpPgff4qyVh0pK9K36tNuMXZtWChW7z3bl8joxNZwAWEtsyjsPIZMYW5i1Qy/lp3UhKjVn2zeeecgOJ3aU52F7k99MCEqgsR9/c1oebGv2qKy6oQa7RHgqzlxuWvUahwJXNsFnMOLeZ4+Ecrv+sTMAYvcZkPK4GvTIYfQDPJKwv2cztFrzPPMyToNRDpBWUAhuR9Ha8e5/CJtnajaiWd3ckvgow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFU0+SG9l/fRGXvdZRhNkztrvEor5EOzLrsjdj87Qpk=;
 b=kgM+epBCxTj4FKZFsi0laZXVvGkvSLenlvvm3TLI2/hKrSDmEUVAsx4sBYMnXvY7N4LjEs3u3JvXGr/RH3ipfTBp5QF4NSDgoCT4OnRRT1GetD+ZFG2TQahLgAUo1McxSk0WPOJj8UxNs29iNpuA3O1al5Fneh/GGwmY4oXbe2hhXZsjGkiYcZh1VU8lcqBFLUlRfBvZ/ToHrvbDiheCTNUxZzj02x4xnu9nO4nDrYhUwDBGdchPQXD8tYfUaMovwbfOJI3AlT00Y7+dyzObY9hk1gPNRSJ/KzarK424sLNjaVrPw6DFq/E+unrRtOtfJqX6RwTMhR/eLSmMGPOS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFU0+SG9l/fRGXvdZRhNkztrvEor5EOzLrsjdj87Qpk=;
 b=DWSo/bthrWG2N36gslaWnvEFP004yWi2L2Wb60wMXiljAOUwZqsOSW97S2USYKwRTOvlsx/sXM+EZerda959eLXR2AoSCX/Eb72gTdapIMi7pCgcWJB9K+qhDqNIgzZbiyV4YlZync9YEW5UuCrjTd+MGZ669+pqnniTc3xYi7o=
Received: from BN9PR03CA0063.namprd03.prod.outlook.com (2603:10b6:408:fc::8)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 18:12:23 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::de) by BN9PR03CA0063.outlook.office365.com
 (2603:10b6:408:fc::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 18:12:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 18:12:22 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 13:12:21 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <x86@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Libing He <libhe@redhat.com>, David Arcari <darcari@redhat.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH] x86/CPU/AMD: Ignore invalid reset reason value
Date: Mon, 21 Jul 2025 18:11:55 +0000
Message-ID: <20250721181155.3536023-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721181155.3536023-1-yazen.ghannam@amd.com>
References: <20250721181155.3536023-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 565906a8-f270-49c8-62fd-08ddc88223bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QJ+UWiN5gte46EHvX0npX+szXq37321mwDgwr14QLfbs58VZ9FroDhTDIvGY?=
 =?us-ascii?Q?LcaqJkoDYJ2UjdZf3qCG+4NLBbjBCJ1tk+h8WSMByquoqBpvSX7W0YsBuzDz?=
 =?us-ascii?Q?Q/K8Ouvm4nxxfQxbKkM5ozhV1lZXKg2wS5Ue7yPerZn5FVBe4IfXfkdp+HAd?=
 =?us-ascii?Q?Kq7Fd4iemmn+zWQB6pI2ArZd6zbqxlQCAqfiyU6pYPu1we+jDLbqbwteiXNF?=
 =?us-ascii?Q?1QxfXV5sdoyYkGMM+mcGZ0anFbrRi86RkgAe3qkOribmMMoq3ZtgrD9SlLoB?=
 =?us-ascii?Q?TAL95nU36OsX+jg5C4LmpDSlWIg4mZuJN2ZjZvAhCUsp9u177CDXM1fPhWWb?=
 =?us-ascii?Q?CLIcPLi2Isu33N7lR7hm/127p2/an87KhkwLZ0EcAnUNeVWQC3diEmVVDQ0I?=
 =?us-ascii?Q?niBhkb3Z2bt25vR0ebCYu4Wp9nrDTCp/ppA5aHtm+XaG2lX+zaunUK6AulQR?=
 =?us-ascii?Q?vf6uGDLMqttuX9xMWNX9COdN50tAmDZSycj1PgRl2iO79bn5tyQ51ct7Iwz0?=
 =?us-ascii?Q?wMGs7XJv02Td0Apmes9uBVum83jM2YC0H9Wwl7maVjj1luWft7jA+0RffTJO?=
 =?us-ascii?Q?3eFpiiemJJd0Wardy+D2Z/OvBHMVwli8EluhpfGP3ADFb8u0m7VC49esZiVX?=
 =?us-ascii?Q?iQT+wN/OLy3rw5ItQst+AjF6X27EOoswseAZ26PFHR2pbpgj+0HgnbVyFBDZ?=
 =?us-ascii?Q?Kw8OMPTKnJLrC5koHoMj79Ls9C4ZoMlevLrWzp+gxvDzEXMEWh6pgb9y3xwp?=
 =?us-ascii?Q?BxjOdIU7Q6WL4395g889i4ZSO6LmqtgpCNGFJyaCdEUvsF0kUa1R2BK/1rZy?=
 =?us-ascii?Q?xle/j1GWutOg25lilD/7kzzJzFUvYN9pxLUsvNK7q4E3EP7rp1FGi7GeZfPE?=
 =?us-ascii?Q?FPESeCrgY6NPnk7oaVnAVpQn9slahbuf4GBriSO9micYZX6WxZtMkX5AgM3n?=
 =?us-ascii?Q?vFeeeuOSHW/UhZheDtI/CxlfkiwklyqILQ9w4IXsHknXbpkzkqfZSlwBpWIv?=
 =?us-ascii?Q?9Ro/rwIlHDVJHKCxEFdwTUsGt3gSFvxH4CJcXIBLjaf769zf9O2ITytOSczL?=
 =?us-ascii?Q?txfYzWnNxxxqEQ3FLa6U3MlKQhfMkrgkO+1zhjod/DNj9TVls5BcRgppSMoZ?=
 =?us-ascii?Q?JJZPeOMpMhvduYhaGRgmU+AiKylxIEcVAC63heZPJmFbf5pkMzntm7Rg9Az1?=
 =?us-ascii?Q?MylRCPzJsZxrzolJjkXkHLIrobcTS/IxhftJ9/obq6qsw/+0jDX8UiaQT50V?=
 =?us-ascii?Q?yR5Xjhg+1TcpS9qPfokyS1yWqQgpeQVpbQJgYwWo3Haj/QGvXmZapvEHipxM?=
 =?us-ascii?Q?7H8BGDptjUqg+VwT81RHZxnNBS73qhT/wJjNK/AGBN0vbAoMSbrHGvR31AdT?=
 =?us-ascii?Q?dUCcuiBC/vuaZi4kOoOogRgEfS3atL0kGnhYS5TQaOprqs0mR9fhHzWV41/X?=
 =?us-ascii?Q?Y7+Ucc1dUWY1L1SgSmGffsQYXQEHQ27VWaPleQoPTJ4UEm2Ig/MNTByXMyiJ?=
 =?us-ascii?Q?DtW5ZV26u0eaEJSqd5lNRgW5oi+Zmj0Ohg4k?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 18:12:22.7094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 565906a8-f270-49c8-62fd-08ddc88223bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483

The reset reason value may be "all bits set", e.g. 0xFFFFFFFF. This is a
commonly used error response from hardware. This may occur due to a real
hardware issue or when running in a VM.

The user will see all reset reasons reported in this case.

Check for an error response value and return early to avoid decoding
invalid data.

Also, adjust the data variable type to match the hardware register size.

Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
Reported-by: Libing He <libhe@redhat.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: David Arcari <darcari@redhat.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/cpu/amd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 50f88fe51816..db0f9e0d181a 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1274,8 +1274,8 @@ static const char * const s5_reset_reason_txt[] = {
 
 static __init int print_s5_reset_status_mmio(void)
 {
-	unsigned long value;
 	void __iomem *addr;
+	u32 value;
 	int i;
 
 	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
@@ -1288,12 +1288,16 @@ static __init int print_s5_reset_status_mmio(void)
 	value = ioread32(addr);
 	iounmap(addr);
 
+	/* Value with "all bits set" is an error response and should be ignored. */
+	if (value == U32_MAX)
+		return 0;
+
 	for (i = 0; i < ARRAY_SIZE(s5_reset_reason_txt); i++) {
 		if (!(value & BIT(i)))
 			continue;
 
 		if (s5_reset_reason_txt[i]) {
-			pr_info("x86/amd: Previous system reset reason [0x%08lx]: %s\n",
+			pr_info("x86/amd: Previous system reset reason [0x%08x]: %s\n",
 				value, s5_reset_reason_txt[i]);
 		}
 	}

base-commit: 65f55a30176662ee37fe18b47430ee30b57bfc98
-- 
2.50.1


