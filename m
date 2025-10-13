Return-Path: <linux-kernel+bounces-850738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68449BD3A77
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4FD3E36AF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADCC30CD9E;
	Mon, 13 Oct 2025 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pEA4ddv8"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E6C30C60B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366159; cv=fail; b=ElhakQzGtCnWLyKWQTgFaGubKiUwyGM4Cd0ZOEA1fcUbI4cK9BZspq8457kUIhGXEDgAEA/evQK3l5WlWHfL94p48uBxg4KhS7UQbtvQVPuhUrCIJRpumZE63ciMGr8rI0+QIeWUBzCyXEI8ePSBLHO9nT5qD4rDmVXwkioN3pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366159; c=relaxed/simple;
	bh=wydbAxhO6YYK5usnmsZbTxNjoDgE02eyWLAkrN1oI14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aoqhg0W7N8CqzaX8qjybSV3Yk1Dvwip/lgAyeRTjFCSpu9YLj+LfruQTY8uvaHMVPtYXt9P5jXJB6qs7NhkUkMndk6vEglcCqLM9hHf41SfLvYVPDtGUEk4j0xu/S2txgR1Uly6cd7lsBRTIsaGp2hX1GT382oHZ50PcF0kuqak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pEA4ddv8; arc=fail smtp.client-ip=40.107.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VahyrFpJMMGH/vhG+4Kbgo9FhU7MYUT0KyG4dL7TZ2azJqqEbDXw35JEVbI0RSrf5lTi+0ziOINIarLpjZQl7O030MGsrMBVPpSBflVKcuYKQ0zQW5K1TrbVqGwOFQiMuKRc7bWHG7keLUQ46ZSsw5x7cFxSmk+seeqdIr2sFzHzIo+LYA7nz0h0xle6joMvktDxUYBIb9tR4W+pX9N7gMnH9ukg66WhFg7X0mq19JhoRmugx7EL86DNIuiBz/xPvJ9K2C7MrHPl9Ir/QOcs+t36EkmfyZi+Ay87rKG+npbfxSrtrWLKFAP4rQ/DQC4Oo2xsza/7wz8zUEGLM4hUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSl1A1Ooo2LhYmsFr9OR4ppC2CfO0Er4iKvwUAHm09o=;
 b=GHcIJZ+zAp+EeC2jjKTLP5jsHCT1inwUZuxxAqREnC1BvUQcUcOzxoCq2INq8gTlZ11SqkXMGlwQI1rbqj0KWQ1OkxAnsizdKMXMQVf+mUcJ3NwEUDMXdBySoOnhCta75doFCM6/5vFMdpE6oGlIpFrDekzY9udGy8ZTHUIuq4zLIpaw4F6D/vIAtm24DOJKGlHVCSfVriiG4x+kYJPo7MBb4mYW1l1DHHqXXip7qtnLth05INth8Royh9l6ojb5FjLtO1CJts5s3sRGJlfmm2XReTcefdPp5ges7Yf7b06rKs9sUOQ83RWX+AV+6itULiNfcMIPRiCoGIYbZ1jPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSl1A1Ooo2LhYmsFr9OR4ppC2CfO0Er4iKvwUAHm09o=;
 b=pEA4ddv85n1wOrKySUXZfnVZalcnphxHZSPX348+uCqCj2TvMOdyfp4H2LGcidQMUKlb5wG++7Z4SPdd8gJrq7YkUu8bE0i8izLDRlYeowcno8STdDMn3X486BWIOw5QMTSBFEGDYggs0mV7enjIMXEQnbE+OUqarNeGpS3HHSo=
Received: from MW4PR04CA0108.namprd04.prod.outlook.com (2603:10b6:303:83::23)
 by LV8PR12MB9335.namprd12.prod.outlook.com (2603:10b6:408:1fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:54 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::32) by MW4PR04CA0108.outlook.office365.com
 (2603:10b6:303:83::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:53 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:38 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 29/56] x86/apic: Add self-NMI support
Date: Mon, 13 Oct 2025 09:34:17 -0500
Message-ID: <20251013143444.3999-30-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|LV8PR12MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: 785c7d43-3dc4-4889-91b3-08de0a65d07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S+DzPApEXeDRtVqgWniCMhJZ1vjLT7ev2c3JoFm5Mm1u+F35gV1aapfMywXz?=
 =?us-ascii?Q?IlX33scHYAJqCDKXDrgg1ZqdlLRnRs5q5Ropnrbt8tVu5+gROF78YUYJ+KIr?=
 =?us-ascii?Q?p6bCQfAnGdIk4VffEyzcZ8Y4Y+DwplrK3EOvB2S2t4dRAMPKodVBPfXI3Rxv?=
 =?us-ascii?Q?HasWYROw+yFnCoEcDml6v7TyWpzjIq8AyHVuz6/4nclVO0pxcWrdrvZvrI1n?=
 =?us-ascii?Q?780o5mxgQmyx4Fh2LUWTDwCABI+GQcRFtejdkl8fd/GEA7fTkA+VVKqHJT6o?=
 =?us-ascii?Q?d1en8xgJJxT7y8TysEiqYJOPCB30wFHmJ3QKs+Hoo6p8+axTtPM3pyvpUgaL?=
 =?us-ascii?Q?T/dwF2MH9INBK9or7B5B2k1Q9RCgSVjOeYT7M4duZ0rJAmD2qTAKrQA0jGab?=
 =?us-ascii?Q?G3pdaD06TU7uGZlvya3yHJEMZbzfN+00/2jolIJ2urr/7F7MqJUyEyXku4f0?=
 =?us-ascii?Q?6C2GaaGaT8e8AjEZ4YFBBTe/r7l/l3i7x/E9On4KlxSVez5HdJa5/IpHhHns?=
 =?us-ascii?Q?BDBqxpQMic2bRJieUSAnsrhn6h6o7NvSUJSqr73MzJo3QO+O7mh43GnhzqWy?=
 =?us-ascii?Q?j9kFaiqsQExdyu8268nweU3dAWnIOuF83JncxHUUAx/Pqfa6jbchTBRsDU+F?=
 =?us-ascii?Q?fOCDj8cVfG2a+yMIsJv6m6SV3fZcArX2/SXjWCIZ5mmU2kyOCOjJ192wtwIv?=
 =?us-ascii?Q?92hyxVpnh0VwfB7P5Ngg1MsnbAb4FIcYaeVri+cmWQkhd11E9N1fGG6AQnnj?=
 =?us-ascii?Q?zbtABIVU8TgJ2HKanyqFUYOZWbVEOKvbcuV/LzAS6n3hQwkkuzVFxqD5It9T?=
 =?us-ascii?Q?yvZucFvnrrx97DxU24vhb3Nxa/tCyFYAEVP61QconP0ThOfHdTq9s+P1i0sJ?=
 =?us-ascii?Q?T1SnFBl8B/iGU2iv8RTiyxBZr3T608Am+3TRvKp2NjpFBkEAdptSzz5bf915?=
 =?us-ascii?Q?f3lthwEnk98vd0UdJdonF3GzgY+iHaTB53bgvM/TFV128SFxaXCa89cYOkFl?=
 =?us-ascii?Q?Xfdnxx4a0J5dGohi9eqZ6hlT0kLaPbenH96umx+hLWXfLgpXx+Q9X3seunMo?=
 =?us-ascii?Q?ub13H9QraCURTgytvQiKwFWUJulXGlVoHV4RXno45iYIB7aWselKWaIT9SPO?=
 =?us-ascii?Q?HzOvyV6A/o4cogQMwGM8SXvibt6v7xUDw1/0/9B+j0/tUlm/cbljq+9RIVBU?=
 =?us-ascii?Q?g8JyW/55Zo2lka52NXf0gLyhv14Somf+f1uFQHPl24ZotPASVgftUzhMMjIs?=
 =?us-ascii?Q?cgh+Ho8Py96MDNukO5wn89YNA2Vw9ATbcb2txw6ZPMz2MPRta4wHOnZz/LEw?=
 =?us-ascii?Q?nTPKitIKYmvgbcKbngsfhuBomYLTJxISALYbrE/R/WdIJ83p8z6ON3Cfd17Z?=
 =?us-ascii?Q?jCYM5f9lzTLCQ2UkwzmQU4iqc9MpcJwlVddehh1/0FM8Fu80jhj1M1PpjUud?=
 =?us-ascii?Q?85HkiQdkBORV3dm3jycRYnpBKf+82DcnX4jAb04XBUCgQ7C3e9VVpZVlWanD?=
 =?us-ascii?Q?SPzJePQ9IAhRZey/0jl39nnjC93SIHKDPRlBcMgWnkzE+6R0dxpsRvnJvVjb?=
 =?us-ascii?Q?eAJm6uQn6J+nFqyBRRU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:53.7456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 785c7d43-3dc4-4889-91b3-08de0a65d07a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9335

Add function to send an NMI-to-self which is needed for stop_machine_nmi().
Note that send_IPI_self() cannot be used to send an NMI so send_IPI() is
used.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/apic/ipi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 98a57cb4aa86..6d4e5aa27529 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -4,6 +4,7 @@
 #include <linux/delay.h>
 #include <linux/smp.h>
 #include <linux/string_choices.h>
+#include <linux/stop_machine.h>
 
 #include <asm/io_apic.h>
 
@@ -248,6 +249,12 @@ void default_send_IPI_self(int vector)
 	__default_send_IPI_shortcut(APIC_DEST_SELF, vector);
 }
 
+/* Self-NMI is used in stop_machine_nmi() */
+void arch_send_self_nmi(void)
+{
+	apic->send_IPI(smp_processor_id(), NMI_VECTOR);
+}
+
 #ifdef CONFIG_X86_32
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int vector)
 {
-- 
2.34.1


