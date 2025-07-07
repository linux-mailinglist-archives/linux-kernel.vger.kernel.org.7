Return-Path: <linux-kernel+bounces-720365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DABAFBABC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4704A13E4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D5426981F;
	Mon,  7 Jul 2025 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BJqbPDaP"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79131266F00
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913224; cv=fail; b=lv4ns2GgOORzYHDan0fceJas1YT0zdVGsniAzlbIWxSBwhkUeHttqTKI+MKQIPHCkVoCHq4Um1h1ddJBbFJNFj7ZWbClFFU90ca8Zzz11YywYoEIEJb9eyALoq7e0GlqQpXipj0JvnLLMlQwWovNlEELRKyDXyBwyf7fYzgcw14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913224; c=relaxed/simple;
	bh=1qRTFegq6jbR35j+HO3dWt9MTr5BPSw61QhchgDSB5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGWhA3F+3JFpBf/ylk8PhKusE2fbg7UB2LQ/iQtKVn5/SWyTkeIeE2VQLiBbvuEGn9D1WN7/ria2+Tvh3v5lSl2GWnPump5NW0TSU3gsU4jZ+OjAl9uHNa5KEMsMvIguck+RU2MAXqmJpj0dFaJMBpIOxsbEVOIVPrx+ykHbXyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BJqbPDaP; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jq+gyc0UUlDv71PnT+0e42k0CKsFi7N6GhjfPINuP9bxacXSk1BtxNE94WlzBuFTphh73g2/d+5iQ73Xmu+40Ms2LSEY+GtupXjCWh+MUqJvzJoOWhDrUJdOVXbrh3zCtEWyCyF/NC+cOro/UjdDzAUuG6MSYVc/xaMJ+gV4hbatU/QR8vm5DO/2GEUFK2GBit017dgkYRfkon1b8b9Ag/mylPsUd44EHTM64/f2jPvTn76FCLT80V+y1VMHIBsbcFG3EjqILVxK0Fav/4mlZcmGLWQnqV1n1NlmzZMijZWh9wQlT7A8U+DGhHQDI3zsChfsT0+b1lpnjeEIF+mFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNu0CsLHTiWN3YqjotAZi5qpWZvCZqbxwKeCGzQ2bRE=;
 b=OnPgR7H4F63nXaqrBA1LafJh9tf90LIQzPK89MycjWoD7/v8aYJgAqrbL53OWDMQws4s319gi5mhlE5OJpTRtp3tjRvzu9PQWyNYDLy+xQTy7zFdbwaihKo/YTo+K49ZyRRBgGpMyCQp2Hw5zFfYOXdST5xXgUAwCOUu2/3KdBSpNebhSCSSDIsVfmGPxQhgOplFK7Qx/ezasXKeCtYT8umFLXTsq4kLuSm/oXibTTcs3LlOtsNjjZswxByd2MM6xzaKgstN0XIJfY6O8s8NFjpVOyMUboY4X4KE1mxzHAilmn6hRxSZHAJJKJ+dzq6/GoplBTNhl3RV8S1kCnfBuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNu0CsLHTiWN3YqjotAZi5qpWZvCZqbxwKeCGzQ2bRE=;
 b=BJqbPDaPEoJ/u2IrYu5qO4acf08yA/JuoL++AKGkr3IWUWInh+DbVjTKni76eZ7mEduxvDHai0Poi03oHyriQ7G3cNwwVQhcAvNSmVrE+Yt6C47qFUCtVbBL0OGmGjoC7/dPtd++MoVqSITURsC3+zUEamfMPuntxS/88i7h/aw=
Received: from MW4PR04CA0263.namprd04.prod.outlook.com (2603:10b6:303:88::28)
 by DS0PR12MB9398.namprd12.prod.outlook.com (2603:10b6:8:1b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 18:33:40 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::d1) by MW4PR04CA0263.outlook.office365.com
 (2603:10b6:303:88::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Mon,
 7 Jul 2025 18:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 18:33:39 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:34 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 10/21] x86/bugs: Add attack vector controls for GDS
Date: Mon, 7 Jul 2025 13:33:05 -0500
Message-ID: <20250707183316.1349127-11-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DS0PR12MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: e486af17-ba94-4d29-62a2-08ddbd84cb00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?orSrSoNxBA+E+hkgCrOT5gWhBzV1j88HFPA3t8Ag5K3r35Hnlvin7l7hgMJ1?=
 =?us-ascii?Q?7ITXYUsphVfuNPKOrLYPgzMer2QhTA6eQ6cP9wUkK3a8ZB2cN7fnn7H8di+f?=
 =?us-ascii?Q?5porpD4amCd2P7qbOG70H5qYXsUkEiOA3izIkvxJ330p92lrCOYuZq5AjASs?=
 =?us-ascii?Q?0p1+fGHWLvmICUCK1igFh3h9Yk0i+er38hAjQPaOgxicmqZdFosEcGWuVrNN?=
 =?us-ascii?Q?vszjyZ8BO/NGBZRFwblFyIK6zLMUTRFmEPMmCJfRr8l7+4zNi194iIXrUCzP?=
 =?us-ascii?Q?cjxerp46ZRKRdPv2mqxKe0bTW2frDXiZteVtCwc2gg1gCCVnj73gK0BeMzom?=
 =?us-ascii?Q?SfaQaldaiS2Vi04SLYE4vxjYhG38ieXbptiVPelQ1HFISyc6Ru43AskK8D6G?=
 =?us-ascii?Q?or4xMarwQhT26CsN4sARQewdwafS3zOMyD4VyPWajWHDmh/oqBgpk2uhcEhv?=
 =?us-ascii?Q?6ON7mgm+l0BtxkqacQ4j1uzZ/bdd8q15fy5+tTXLZucbUr5OjbV9Q/JkqZhZ?=
 =?us-ascii?Q?hWUxPBbXJyjRUoFfg8QJawyxngZ0mkzKsio+UkZHzAqehw8Zhh+aRUCpQzJd?=
 =?us-ascii?Q?b4Vd7Q6zJ65Eb2T2zyXPHLnKc4vab4QyhvTaGuvX7ckPCPzgMBFiraDE8SBb?=
 =?us-ascii?Q?E/zcNaMX0k28K4UUprOq8vX8uVuqTKWSQcDd1anAOHfBlcwpxiT1Dx5qu4x1?=
 =?us-ascii?Q?qpU59BcFx9BAvITTqdsdm1mH/+SFlAzENU8IWwMSZtdl05f1F4Hpbth+ySzY?=
 =?us-ascii?Q?7A/7O1u0wfJZX0MtA9r+s2YXtraSKcKzgHkwJjyXoEbgCPgVGec3MwLV/ijO?=
 =?us-ascii?Q?FhkCR8PLUlg/4a1rLLEXnwpuqiP1sJOkyujxGiDxlwxEfH8++kTkt9axvyLS?=
 =?us-ascii?Q?CnBJdoJ3EDh+Ess77HEcOVNi2YEWJ3O2NY+AyrKhn36ppb7ZEwhzRbZBunhB?=
 =?us-ascii?Q?PoZetYLk0W99ubvgS7iaEPT0PMDiwzzVgamzde6noRG58JCsXPKMeA5yC1kG?=
 =?us-ascii?Q?GNmjuHHMqJu9orlRPS0RQB0DAwZUf1lw+cFKztdI54uxQpFQwdpC4UjUK0/t?=
 =?us-ascii?Q?CpmeZccve4QnFTtteR6VYnNXVweB4WpkCG76IKhzv71LifXU4aBhSEbkRu7z?=
 =?us-ascii?Q?qAFlkVI4XaBJ1CBDYMkR6g7LRYIxKNsYUr31KvTqOeL7TyZQa2gKp5YJjRG+?=
 =?us-ascii?Q?G0EcYsIRV7zyGDi+LCJ4SJRa3hNDgGP0Dfg6sUVC78ugLBDGAWqdaexUP3IE?=
 =?us-ascii?Q?vsLq+bLYdq0AI8kZaND0J9itRLs3FTQZCPNJHIhpAeUsY6swOzLDYjX0T/7p?=
 =?us-ascii?Q?JWsoHwBfuSBBepq/5twhBeAvFH4Sy7nuAjBTrxgUBt2UETuaAxsBJY0yxjyi?=
 =?us-ascii?Q?wyatVMdergwyhP5rW8uo1NxhTu/SlDCyrBHk4UJ945h3KMlNflZPviw282B0?=
 =?us-ascii?Q?+wsf8ZivTjxrqunC71XQtsTyLt/tv3YXdsecwnSKvJX21rr48ypeNmInJYbB?=
 =?us-ascii?Q?zsZqayvCGqsW0tYeb5xUaJJgWoUQIruh/g2I?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:39.4272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e486af17-ba94-4d29-62a2-08ddbd84cb00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9398

Use attack vector controls to determine if GDS mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e01fb83daa07..dc3f9a2e6984 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1026,12 +1026,15 @@ static void __init gds_select_mitigation(void)
 		return;
 	}
 
-	if (cpu_mitigations_off())
-		gds_mitigation = GDS_MITIGATION_OFF;
 	/* Will verify below that mitigation _can_ be disabled */
-
-	if (gds_mitigation == GDS_MITIGATION_AUTO)
-		gds_mitigation = GDS_MITIGATION_FULL;
+	if (gds_mitigation == GDS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_GDS))
+			gds_mitigation = GDS_MITIGATION_FULL;
+		else {
+			gds_mitigation = GDS_MITIGATION_OFF;
+			return;
+		}
+	}
 
 	/* No microcode */
 	if (!(x86_arch_cap_msr & ARCH_CAP_GDS_CTRL)) {
-- 
2.34.1


