Return-Path: <linux-kernel+bounces-850739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 670E4BD39FF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B38E1883E9B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F47430DD06;
	Mon, 13 Oct 2025 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bcBGY+1R"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BFE30C638
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366161; cv=fail; b=ISTgjehfSuLi8rZkkXUkOeRjdBXjFCuMJsMMCzFTNUn0TaK+sMSKPL1tnAkm5IB9xk3sAYLr6idcTs3F85rn12OFuoUF3rimXyhjk+TcJa9cA5MrKLRT/umAcBGq1LnvohGLxilyHNXuOmkfgy6TmiNAAfpi7JcHP55uYNujkvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366161; c=relaxed/simple;
	bh=66fdHl0Dh6YewbAvrHdbbIMbz+72JJNo8W6g7R9hOpo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTo2Yst498hgkuji6TQl+ATRzjwqtx/yFRn2YrLzgflEwlHhYxEhdm0o8gplQaCTRBw0CvDepsnKVV8zcCfWImEHPkpUVohC3ZZ4D1gGlUOTl9ae301ZmHBfjyYem5TGVY85S06SKrxWmc6cueqcqOMgj1UOzEvo9c6FR2VyBKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bcBGY+1R; arc=fail smtp.client-ip=52.101.46.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArMs49iucQ+qiur5Jd9hfjA8S6oWsQLqdNhhpFtNQb3wl5zPCEUYaOoKG6CXr9haRiIoy7+dSzS832/t0MuZ5hmvFtc/I9WL3EQehk9u1hEGFMBD+xzGaEDx7jwhBEdHQQGF6OMM36h5f3+QZzbcUOwRrQhJTGLUytRALvr7xdITHd3+B7A+MPK3N+KouZGobyxP3HD3ktPsqPgvRhHfSC+4BYfovknkm0G7eL50I60jol4Tc1i/eawY1FooIBayrIznrhWA9jszRyChTtvK46Zm+JTbnlT+Xn6b5wolQGP/ZVQsXMkTlF6Ko1IIdYK4YCSWR6Nm6ZfF4EDOfNEY+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bea/FwTifHO8WNgy5AGped0VAkhBt0KaveXw9Y9AV3U=;
 b=F1YuKtVGQjcdmYx+fyNlDAH6LxXrm1GAlZIgd5Ds0HxXZbc+fW6tKqhc5zIL/ksunuCSQwGpcS4COyP4KVbCs6heIE6qKu1GmyDxp5SfYcoZzOX5Fu6cglwi5M4Wvksm2af6TMxVPYPCevbCPKJDSfWOgOqRgQJZDhuKlhvHrH8Q1IdQvr1KKSTL7pRVkodt17LiDdljJMk/Y/R0m4JfUOUT7vRrtwaHhbcJ+f4klfwAh6Hm33OBbYSTnstajkmkYnyiUsPm0UE9qcdI2cv3WMfvfnPDy5tiQpNIWDYHqSk/qf8tgPLd5PIUxSjjN8LuM3/Pa+bW7su8eOA35ARBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bea/FwTifHO8WNgy5AGped0VAkhBt0KaveXw9Y9AV3U=;
 b=bcBGY+1RHlpIDtSCV/wnP8MGnLN0BohNhIpb2vfD1oGHbDFiinCeJM3bnRLYTbBU1TlV8Y8/Qx9LOzPr7NmO2FrP6wjdIBRlxJ4iWycATB4yqcTp4dIU8/Kq8AXj8vXcWJFYeAioZVLPOOTeOVUDf1pH2XfHTOVwIb+iyLU80Mk=
Received: from MW4PR04CA0104.namprd04.prod.outlook.com (2603:10b6:303:83::19)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:55 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::bf) by MW4PR04CA0104.outlook.office365.com
 (2603:10b6:303:83::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Mon,
 13 Oct 2025 14:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:54 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:39 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 30/56] x86/nmi: Add support for stop_machine_nmi()
Date: Mon, 13 Oct 2025 09:34:18 -0500
Message-ID: <20251013143444.3999-31-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5ca482-b0dd-45d7-0e9a-08de0a65d134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Vbu4Cs76kWRkyl2agfeGqrDWmQm5S1GYN3oxvIkQzMJ1iXW+mS99sa4oVYF?=
 =?us-ascii?Q?Qj6p4HOpfjCYOap9C7zKZCrypPS6f+RPygOQth3K5mSomTsboHhAML4+ntpv?=
 =?us-ascii?Q?MyhrKYZ+UURP5br86hTE2208P9okISCooVCTY6bTIs8P9+tz5ffDK7C4cpEE?=
 =?us-ascii?Q?s/yehEVP5bnJd7AQvwC+CqMCaKocsaL2Rh4DSfOLZUnQzGUpSMqPsb9lrM5n?=
 =?us-ascii?Q?j56JN5bIur1tS+tWwEeuV7U7uKmgVqW27uVjt0fUai10flYb2ByVITfRvRF7?=
 =?us-ascii?Q?o7alySW9d52SohPDx2lAIQiX2wzEyXafL+y1f88rXfpheTABvTo/trOpQuKn?=
 =?us-ascii?Q?10GZqVQ7qPNstAL9EU8HphVkj0twK0ghq9F3we00UC0UFfFC7Gux5Y02Lw+k?=
 =?us-ascii?Q?OZguuS3WAVkvsa56W4a0a5/gXuEOwDAdDRjCR0w6MFyBGIs6n5uVZmu4EnBw?=
 =?us-ascii?Q?ldosztamNmImzLxdV4X83ZUQDVJBdyInCfF21CjgT9SXjXum5YjSc7sb5+CF?=
 =?us-ascii?Q?s0BqjuczvjeNU9IzD5tBWKRKNs0cGRvK/UMQjAodeHA4r0SDDF5DqyMHCm56?=
 =?us-ascii?Q?wUuJFHef+0XlimlmCIzVLdfws7V7Ky4uhJlcfn9xaw2Q0Va1rTrgxgZSHaXd?=
 =?us-ascii?Q?jfcyRsNNOYZXRTwZnGDhiyi7lNLtKTq6FX4HeD8NPay1Nk9fH9KyFeaDo1Pp?=
 =?us-ascii?Q?1wXAoWBt1ffLc1+ODZzTKgQyg0z5kcGyhXJOedEHFM4rporEUZL8XD/cGGoi?=
 =?us-ascii?Q?6IDFWhR3jI/Fo1ZMjNNXp39hg7kfZvxhpAd1WcsSWbMfyjhrF3AQfwBi115O?=
 =?us-ascii?Q?xQ/zFix41WFY8SMsE0iZ8ikwkjhMcAxsT3JqiFQ5tOCjMB15G4jy+6qU4srq?=
 =?us-ascii?Q?48xntDRF+JCOtbKABfKCFjY/+EpSHjIU7hxZlZKh2XjJ8XNR7Stm9d8dQug2?=
 =?us-ascii?Q?+WAHgmPPcWSwaqgeRXc8rS7zRkoe8Pi5tGWFfgeKQzqYlPxXag9xHlobH7ho?=
 =?us-ascii?Q?JupEyXiH77x0mkbSykIQZtYpPgfwRAsAsuYAF1sUzHVoeQfx4Eh6X989RfEk?=
 =?us-ascii?Q?PNVOWJ+ZZuMqK3Kgx/XfZhwWwoW4dtsJZju2HWBdHJdIzC7NCVLQT/iBerBs?=
 =?us-ascii?Q?0ioOAurV9DoGT+SyRLWZQt4bVFLwA+azUrhqlKEPTIYUBNzY45RFivDs6Nmf?=
 =?us-ascii?Q?DFZ+24bhNA88W31ub5pBr+WMtOZB6DM73hVG1f69IK4xIYSxQJtO2grACfdL?=
 =?us-ascii?Q?7EQ654oOKICGcIpNASIWlFq8bgTBrNC2OTHAuuSHFS+CQpFjeXKAdQZvGLOG?=
 =?us-ascii?Q?q6CL/S/1/FCcG+3uwQbT6OEszovPZIqzD1H+nuI1ABPKa99VBGAGv4ybwPSE?=
 =?us-ascii?Q?lUQNafC8lfoYmRW90f/Dn1MOrQ39vQVf4Z/upiWCuu0dCD4J9NUrx4vjrRuc?=
 =?us-ascii?Q?gLuqCVrEyL4dfriecRjFcjHqg8TnpPgyoe1e3ugPgj/uzojLx+fr/ysNigpM?=
 =?us-ascii?Q?u4MVVl7iYMWK/2YXqx7eqCumDgw2/704eUiCuocc5n/BiNQ9c6c0EqBpGol4?=
 =?us-ascii?Q?b4IawY2Bp4Kx7WcDDr0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:54.9617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5ca482-b0dd-45d7-0e9a-08de0a65d134
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352

Call the stop_machine_nmi_handler() if the appropriate static branch is
enabled in order to support stop_machine_nmi().

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/nmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index be93ec7255bf..c0d8e80029a0 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -24,6 +24,7 @@
 #include <linux/export.h>
 #include <linux/atomic.h>
 #include <linux/sched/clock.h>
+#include <linux/stop_machine.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/traps.h>
@@ -381,6 +382,9 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
 
 	instrumentation_begin();
 
+	if (stop_machine_nmi_handler_enabled() && stop_machine_nmi_handler())
+		goto out;
+
 	if (microcode_nmi_handler_enabled() && microcode_nmi_handler())
 		goto out;
 
-- 
2.34.1


