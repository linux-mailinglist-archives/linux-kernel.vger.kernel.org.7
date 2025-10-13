Return-Path: <linux-kernel+bounces-850732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AED4BD39ED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7A01883381
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5188E30C372;
	Mon, 13 Oct 2025 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="trPpixEr"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012062.outbound.protection.outlook.com [40.107.200.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22BE279DB3
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366155; cv=fail; b=CQ9pp513J3+haKc/YpbCAQ2xyZ7G+G61/4QFHezBHQSU4NEWNhNIb7CUiMXh/WQusCR9LShClfrvy5/Z3I1eWzao7kYpu7i6h51FD3RX/alNLwyDOo9QJwsLCMAXJbIcAVqjrP9NCyWLLKjd0lWyak6175bDC5vgPzyAWe0g2B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366155; c=relaxed/simple;
	bh=vtwm0/vFFqxTkTkjp8qwLi9BqVRfO0fiOSe24b4hfDY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWhPIEJ4sy9Nd6ztUyBfuxwtmGTJrh8ayLWLbcgiZDfBe8homiSc4CkeODMTRdA9/eZq9ZJ7l8+2XI280rYrJ5oNkl+8DtqDk3JdyOgZTvpVgAujcvgb85O3Od26AUHyPjJV9OgXn0O1qeLVPLOfHFkUS0rJ8Sjb3pp2nhYsrkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=trPpixEr; arc=fail smtp.client-ip=40.107.200.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUx3CRgCVvpzD38y1WivoPXFJs8uQwF6PICJuFejqfzYMfl3kqx7wKSPeWikkLsUFZ7YiL3l9DLdDKyLfkLl+HpIb7Bk6nJcd13MoAGp73/bYcXNOVBISkKf4sbG2h/inxuWZK3y3xz390s/w0fy+Ixcm4/QVGrCVNUvSbtMs8zCEyaRgHHtsKlH2IFxTWuFqiTysL3P2CAPCTjl8ijllPukDnwLQzqFacIZk7oBpMm21gwNzTGt/GSWxDXd70AnCTE9CaHbjsJwnVJN9HOl9gvY49zV5nRNCQOJV2KgsB1NJuVqkOkKzOxOjvrMqElDE64qJ6gGKgZPsqu3gzSOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPyqc9HzOy57ns/cjqb6p2zU3iK5TiOPyOx2S2bYALI=;
 b=pDOaF6QpOoTAZNGyi59JamsU9AouIYjL1FwZELP8zXFsosvZQzEYW4lO63Wa9azEaoO7v6sa+KWK5wImGNYH7vckjKfzbWdo4A7oO1v/1BmnxBNKVlvQdQne6m7/77f5tgTFVR1PRfJ/OPPHam+u3E+hocgdG0VEUVX7TsjMK9G529Op9CTb6zRR1X+zW51Mk8J/4LEhcJZBtR31Z4VjattYzOI3oWTjF47iB6nlTaWRoNgNLJEpdmYuJgxR+Vlgi5RbCoXkhMORj8BIW0i33PyfanIqIt22CdVR5OrYvAK+PUrpAhVVvfIudcFhB22r43gIZEVjgB0iEIy7RPs9lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPyqc9HzOy57ns/cjqb6p2zU3iK5TiOPyOx2S2bYALI=;
 b=trPpixErXyf9TUSwti7pna1WpAazgRS2SNplig7wN+aNVhybJrpXEKtydDYYuPDrwo8xhERTKEqMaUQNqn4fM1BaOjdhQGfVJGVb7c68uvLjydTPJvkHJRrcRYJJVdgf8++YIjCvyHTuhMbGHJbsIXoB9p3J7iH1RyNmU6eUuTw=
Received: from MW4PR04CA0115.namprd04.prod.outlook.com (2603:10b6:303:83::30)
 by DS2PR12MB9662.namprd12.prod.outlook.com (2603:10b6:8:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Mon, 13 Oct
 2025 14:35:50 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::56) by MW4PR04CA0115.outlook.office365.com
 (2603:10b6:303:83::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 14:35:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:49 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:34 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 24/56] x86/vmlinux.lds: Move altinstr_aux conditionally
Date: Mon, 13 Oct 2025 09:34:12 -0500
Message-ID: <20251013143444.3999-25-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DS2PR12MB9662:EE_
X-MS-Office365-Filtering-Correlation-Id: 26cdb2ea-c964-438a-9dc7-08de0a65ce39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eokk1yoLTSBskAH/Sp/x7nRP9gHGGD+QbYPY38S0Bh6uAypGbXN44sTp3kSz?=
 =?us-ascii?Q?425u8i0W3Xm5DItWP8dFf+zAuDWMqpRKHrEMu6fhlnk0fym2UUe2Iu4TOnHD?=
 =?us-ascii?Q?nn3tZ2kNLWqmPLQkwkIAMGg3W7aNMnQ29K4xf+tP0T6qL8RzDZFKJcAMrlmI?=
 =?us-ascii?Q?IY62q6PiGlMjyQKV8IKHtQU+grUC3C7gPclf7YnWe+55mY9KNfFW9z9yKGKr?=
 =?us-ascii?Q?qiL+UNnRSoStf+HgPmASu3AD5xkER6aD2u/lQbR4uZzZqkQW6gDlb6T4zqWC?=
 =?us-ascii?Q?zFKUzdvnJOnn97U+zn7vovCSxLGngvWy8V5F8lhZy7PsQJo22WdBbXBOhUxS?=
 =?us-ascii?Q?IIipuNyrbkW5jbSNGsmkZCzeEe9HAQ1i0jljFCyNZ20csy8nZpMFVJWPox9J?=
 =?us-ascii?Q?puDhsS+oxUPOr4RsZ/mOd445fm4qGd0CRYBV+gMDeqEByBa6BgCz87FpV3nS?=
 =?us-ascii?Q?lE+Ztg1SA+/NUYLCMe8bCtlTv8dNrrSDPl2zT790P0bgsEtwHnDSRJh66r/H?=
 =?us-ascii?Q?zcERWDSYuLMdjVlNGC6VSrYHJKo4ht8dxQoPuTEGwAQW9zNA2GnQfYq5ebHE?=
 =?us-ascii?Q?nyCkbPAKZju8bM415Dz1+wIap4KzLYQz3+FSBaud2YfB6Aoor4ZFxEVWFm77?=
 =?us-ascii?Q?UT1rXAi/VhdvLaNI6CUOXTRbiNpmtbF9/tzFMzh9SkJHPhBD/KiLppksl6Yk?=
 =?us-ascii?Q?tPtlL2dBI1XpVUm3MthmIFtc3HkU7W7Z05OWrRK+dwXPUDZZuYciv0lVlDRj?=
 =?us-ascii?Q?qjv/zhHwDO9gihLPr2K+PKswU/RNN/EnH6WPiwxbQ2ANzS6GTQxSsOVRUAFv?=
 =?us-ascii?Q?2RLrLqXRgwjbE9rZ1XqrF0aIIEP3aYnMBQkTKkXlLHffy/qtKQlfZj3ztMrZ?=
 =?us-ascii?Q?6tr2GHZWrhoICK9tEUIzJvVrr4slUaxTqYr/L106+un+ef+GR6CwebcEqXkU?=
 =?us-ascii?Q?Oh/Drc2FBqDLuhiS3pk1+JWG5LZKidzZEM0BsDMora6c1QD7vrNaus/DegD4?=
 =?us-ascii?Q?XJ7bMVJQDOa2n27Gy5z0cD4BgimF5xRbWfRrqy+0ZP4aKoWDahnqXKSgjHoe?=
 =?us-ascii?Q?b6+BjINznOyiip7vxBSP+BGPx6czYHcv2uMkIpqO1Q6rm2bZq/pqf0+3NZ74?=
 =?us-ascii?Q?4nSS721pJghADXS/DbkvHX3T7W9DXilE9boh1FE7mk3Gbv0sPP/f6ZlJK4L4?=
 =?us-ascii?Q?W3ktoSOQdVnI0afEdzKURjuxvwAHRh8+FoBI/jT4wprTyT0yQLgCWrMTmHGg?=
 =?us-ascii?Q?p6iTyrf4UBk2ADtF6XqMNnwIOFuffMHFN2sWKS0rCRJ4DLATNCakZ0t8piW2?=
 =?us-ascii?Q?nzswRujzXKjFo12xdmJ6lfNMEN0Mxqb1ujlR5FCIpjLdkvLYsHHz4Mmbsj1B?=
 =?us-ascii?Q?/KfV1rbfc4H18aIO2TtzuZ9ApMltoiiKvQR/puAtHqO02FcKoAGgsCdpJZ9x?=
 =?us-ascii?Q?fcVaGEXrDQ5T1P1XKSb9B5dg50lLhcxT7XaBI4DPohbcNV/Y6C6aEXo4Izuw?=
 =?us-ascii?Q?ytozX5tnB41oVISFLg/uIzMSJIQTmZxUAUWku4kDQjcvvQTQo4rWHd9OdIzV?=
 =?us-ascii?Q?EWX7rqHezAG1QB504KQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:49.9641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cdb2ea-c964-438a-9dc7-08de0a65ce39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9662

The altinstr_aux section contains code that must remain when dynamic
mitigations are supported.  Move it into the normal .text section so it is
not free'd when init memory is free'd.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/vmlinux.lds.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index e0db3f4c97df..c4a0bb13d095 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -143,6 +143,9 @@ SECTIONS
 		 */
 		. = srso_alias_untrain_ret | (1 << 2) | (1 << 8) | (1 << 14) | (1 << 20);
 		*(.text..__x86.rethunk_safe)
+#endif
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+		*(.altinstr_aux)
 #endif
 		ALIGN_ENTRY_TEXT_END
 
@@ -262,6 +265,7 @@ SECTIONS
 
 	INIT_TEXT_SECTION(PAGE_SIZE)
 
+#ifndef CONFIG_DYNAMIC_MITIGATIONS
 	/*
 	 * Section for code used exclusively before alternatives are run. All
 	 * references to such code must be patched out by alternatives, normally
@@ -272,8 +276,9 @@ SECTIONS
 	.altinstr_aux : AT(ADDR(.altinstr_aux) - LOAD_OFFSET) {
 		*(.altinstr_aux)
 		. = ALIGN(PAGE_SIZE);
-		__inittext_end = .;
 	}
+#endif
+	__inittext_end = .;
 
 	INIT_DATA_SECTION(16)
 
-- 
2.34.1


