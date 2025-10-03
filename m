Return-Path: <linux-kernel+bounces-841573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25394BB7B24
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBDD4A36FB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A4E2DA76B;
	Fri,  3 Oct 2025 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YURel2Mk"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BE32D9EE8
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511998; cv=fail; b=IIkP2SPTVupECOPvSTLbfTlS83PoC879JrM7GobvjV7ORYltqBBMxQtems8UWHdLyq8ZzoGnXfT0pl9g1ejz7di03V4bdxV6aXMPjTDf1f9bSyOE3y7HDBuN+mKD16MI01/184Zrn0ovXTFSEfwPg38vck/wsr4cUwAnp8ZQVSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511998; c=relaxed/simple;
	bh=lIvyFujR6jitAHseLzne27ChmRpRYB0M0YdoYYYfN2g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UqSMH4GL7oNe8Af4S7eMHSw4wPAkougCyXMrVVx1rnpsfXVZTdOia9YTvBJ+uSul6a9fkt3xD0l1fS9dk3emPOj9Y2SHt2GfjYBu3qH9Yt7QhipiqfTKOlsIPyPhEMaralRb3WOLTIhKdHfYeYEksPoH81N3t7iK7s6a81QSfhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YURel2Mk; arc=fail smtp.client-ip=40.107.208.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbvZW9Zw2Mhi+QuwzPWN0GpWHkIxSw1+GfOCzcAdDmQMsUSb4eSj/hF9/b7t7nGn4n7sgigFxtBoG0RWEpYbltudsQgX+yiW+mBt8Oyj22Jg9cbOwV6jxj4YLycBVVrdFO+09vrhpae0k6I3Eq+Bn2FO2p9i/ftbGO1Ek2zuNzQ4PBigZi71hkzHW50QWyXUwZIXHKlllSKma5w1asQ0gId2YmiirenAax+LEnW+fcP19+C//i6w1Kr5s5scQ4q4851wEPm2Bi1vjW76QskC3qSSJFFRiZR7/HIhOO0Tgzgh+eDG3+mI92vixy3Ieza5f3dnYfWOeuQp2KthgmoHPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAUTPXLA+Fdki3MEZz6e5WyTLneiHKM3iry7F8LIL5Q=;
 b=SLvI5cYB4mu/Y79IMB/jchEjMr1/8XL1Cg0aaEoZSgdWHy3gKE7v7wJrQNtUiUF2oFQ1gZDSMFXVbQk8vqDmd4h4rIcrzYe0H3h5BwJ3FkzKW92dJCTJ14INXgEOpTa9J9pxBFQRcCe5OjO1bsqQU5IhCyeemOp5RZX/Mr6x1o6v36uc4rGcBTiMf3TwzdRpmL/9nqeMjXMfTa+d3Kjbl/3KmcCseBj97EzgTnvW/ZVbxPtwMGJMJtDl4aQxNc3hsxLEOo8o0/qpe/DVhcjxZMPVlr4Rs08ryyQP88qZZVLPcAaRneUJ4ivSyfak/aB1vgYKvLqZIL3P544aY+iLJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAUTPXLA+Fdki3MEZz6e5WyTLneiHKM3iry7F8LIL5Q=;
 b=YURel2Mkh4//nroLMFTtVlJQ9QBp/eJbjn8WmqpdjZb1UMAXexg8sfT9gQfQx2/gPx3lrj7TDW/wINIOiOjlbTOq4i8tjaoh3QQWjmYMWZ+rSaG8OH/ddq1Dnu9xhT+1cm+lxY+GydHbglDAHCZ7MkCd2R06JG0QUp8JFOET9zQ=
Received: from BYAPR08CA0061.namprd08.prod.outlook.com (2603:10b6:a03:117::38)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 17:19:47 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::65) by BYAPR08CA0061.outlook.office365.com
 (2603:10b6:a03:117::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.17 via Frontend Transport; Fri,
 3 Oct 2025 17:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 17:19:46 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Oct
 2025 10:19:45 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Klaus Kusche
	<klaus.kusche@computerix.info>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Date: Fri, 3 Oct 2025 12:19:36 -0500
Message-ID: <20251003171936.155391-1-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|CH3PR12MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0fa85f-cbc2-48a0-1c5e-08de02a10d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F93JtxQqzKvCj3Z/EKGLEWaA0N7CR3fsHQwqyw/G53yKC4NfPEa+sBxjPeb5?=
 =?us-ascii?Q?xQD02rHzPVQCs0x3PORuS2j/zbusw5uJY3W+BRfg8ywJjsBHN28uznsJUnoq?=
 =?us-ascii?Q?19cJRQfYiSj/+MTMBi3yTcHx72hnCXLbfjRypNQOMtrnC6TZ4eUIVlD/GyRA?=
 =?us-ascii?Q?P7v5OIBS/A7055GD7uTRdkffMr62VNINvuYw0fx1FOlk1qhJUHySkRoOrAug?=
 =?us-ascii?Q?jJyk94yCQsmLnoAb+C5g3HmtRAcA796T52skGmuYEsg9F7r9bb3QnrFrITrj?=
 =?us-ascii?Q?b2Xo8J8bDSE7Q2xchpWhlENQ8QabDaIpKJlJTC+dvDx7zTZA3gu3k+kbb8CH?=
 =?us-ascii?Q?79zl0yPY99wDSKq4UfWcewvrQbCpbD4wXzQ99FNBTl+yI144qIYLt2JCBPKf?=
 =?us-ascii?Q?t6oJGiT6aH5xSPL7UNT+3klf68VOYxwBJqXZmC1RNfwJBJbq9c7QGbB1TvQh?=
 =?us-ascii?Q?UIpSa00fPa5DexmWOOKiaO0kuhfeYxfNF61CkrUQiGzq3aW1cRjhVURu6sW+?=
 =?us-ascii?Q?OsLQh7+zMQi7TnjaMQC1kSUC3UhP0QI9CjagVSHsv0gWgmyGF4v8xdCFoTXq?=
 =?us-ascii?Q?foONDuQL9xR+MD+vQ+qPAeVhMUfLHYwWHe3TZNkWiUnRHRzKa93ExBS3cP6c?=
 =?us-ascii?Q?PFQw1f9ehTyOBsFqLUYdXyYsgwcronDLJUjwu1NiJrGCNMgUG4h07TeBtmN1?=
 =?us-ascii?Q?Ul6vqTQX6wvEgroENvyemcJA47eTD3JdGMEdEhPRAWYcL0/9jq+We4qbRCQn?=
 =?us-ascii?Q?RUKJ8xDdffRdryqLmZyLUPuYeB0GrfBuu3VhGxjkfppiMoA4Gd7vyfUiXUJd?=
 =?us-ascii?Q?6Snsdew/6XsnMxx5qJi1d7XJ4P2PPQieW97PgJ6RDi7WylGwA5RsSLsaPgXF?=
 =?us-ascii?Q?qaL3J6VTNY4bfHtZPiSHxdAVjAHTn0HcsUXgDB5sp5Oc5Hdy/4uDyi/9ul57?=
 =?us-ascii?Q?oZZp0PtuPGdpMdOASmshE5hh46kiy2s3ESIEmARVZrMNx/qT51zbLc0pdaxZ?=
 =?us-ascii?Q?A8NKZWwfJXiqsSaL5h6bzAbEm5ZWfLNiI/bBxdEc8E5EozmDUJK9b9FMjs33?=
 =?us-ascii?Q?jrULIcbrCkRrHZHyHx2M0iTx7VXKhdM2f0wd+9ijSMm/Xod3WKmODr2CUt38?=
 =?us-ascii?Q?K7dLDN7ZxXJ9PB6fx40zLnHS8q+dNq/9Zh92QVzvqKEcNfDai/mM3qRp7oKS?=
 =?us-ascii?Q?87QzQbgHIrpJ2SrrZtCVbg0nrXhR5PC44DjyFv17fqBgQNAPHun3a4ppIi9o?=
 =?us-ascii?Q?GHV93yROB+2EeQSMHcYcDbXZbN56HpzZaQDX2ntZHopol3PZZecUMEzKDiFR?=
 =?us-ascii?Q?EuyBXNKLDTS6LmtGDGWhiseARy9hteER3xYKp+zteFmEmmCtLRK0ukkUTMWP?=
 =?us-ascii?Q?m7qRoPzIz73WY1pVBuUNsKhkFEg1eMB1QkjqvIC7cF9Cqe9CzzmxfpStcdx1?=
 =?us-ascii?Q?W+dDPRN3A2Oq3uwcE+U0FwmKz0DNhSPFnkoB9Hvt7Lk/fvhWXwa7Of+6Yh5/?=
 =?us-ascii?Q?b2RXTJ6CBhSVNtlsC6D/cA8bujpro/8hWlBuzzRbkmnoOFSGvyfdt/x2Cw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 17:19:46.5823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0fa85f-cbc2-48a0-1c5e-08de02a10d2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658

When retbleed mitigation is disabled, the kernel already prints an info
message that the system is vulnerable.  Recent code restructuring also
inadvertently led to RETBLEED_INTEL_MSG being printed as an error, which is
unnecessary as retbleed mitigation was already explicitly disabled (by
config option, cmdline, etc.).

Qualify this print statement so the warning is not printed unless an actual
retbleed mitigation was selected and is being disabled due to
incompatibility with spectre_v2.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220624
Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6a526ae1fe99..e08de5b0d20b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1463,7 +1463,9 @@ static void __init retbleed_update_mitigation(void)
 			break;
 		default:
 			if (retbleed_mitigation != RETBLEED_MITIGATION_STUFF) {
-				pr_err(RETBLEED_INTEL_MSG);
+				if (retbleed_mitigation != RETBLEED_MITIGATION_NONE)
+					pr_err(RETBLEED_INTEL_MSG);
+
 				retbleed_mitigation = RETBLEED_MITIGATION_NONE;
 			}
 		}

base-commit: d501f68c45ee1505c4a94c68051387ffa32c9a21
-- 
2.34.1


