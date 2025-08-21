Return-Path: <linux-kernel+bounces-778987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C35B2ED88
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F0956186E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFB628C011;
	Thu, 21 Aug 2025 05:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Npos7E42"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BA6270572
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755753585; cv=fail; b=QZcewUrNZardkPnNg8/uYd332aw1MD9TQawmtMlOn7Em/OAQZB1sj5KO0sYZu8t6DWJ0Xy4r8hVfp+umepvdqQZq4SoZX6PVPFjBrz2XFIB4FzbfRhC/Ask7FjSGrhX171Q2hbn0PeihNVX5kknWSPfhM2bIVOxOPS52QpvH3kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755753585; c=relaxed/simple;
	bh=8etChiNlfX/6tbO4gZJ8ncnKIk4n2+Qg8xgixwhjW1U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bl/l3IXRlaMOKazQqnWms4Apab0weiVON/HS+WZXxEs4DrTtvrkzN+bJGCMRd3oXf8ZinMpudB9cmrB39XO3tKjo9Yl7qMRVw6OvxAM1Er5MBo6CWYYHCFm4w5qcmyJDn5dJHUpyRXAsE66ftSyAfdgcYH1mFUIfY88TJIXrKRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Npos7E42; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fB2M5/P0V4nvUXA9AaOO7ZnEebPSl1Qqo306EYX8BEx/nKA7JDxrEMn0VX69LaO9FURTfSav5QFWDYkfbRfmcfzq7zyxlXEQQHiNE0UDOmNXTepncJTCbBFW7Y/xp/bK/YrwZqDVOT5Ya1eYuw22mDhV1VJoqr46FWmtbMDG4QyCzH5WaFSxLrnv1fkL8sN2WgFG5GkBBcLUnq988UQSHX7Qe686AB+96RZ4NTv6riUSSonD2SNxZ/nK/blpQ7TYoiMc6P/jiaKsPwvCi8VPqGnU6YRn93+7d3SO/BXrIKxSQ37CJrLHLYE+hn5rLZnKtCVEBpZ6fP1eZPtcJdDTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrQYpdFEm4fBYfqFFeKCqy3OS4//PUjYgnK7Eeo8ffk=;
 b=G1s/GY21O32mSQyMRram6yoY+kPwCHD9MsXiI18xNxHincn71BHopfo1VrIjBi8rpSDNd1fGYEnMn3MR9ydYgbhs9rU9p/seASxtqgSZjGoftX24DIA0L96PRks3nL/Sw62TOAir07ME90IzpJepV0STM6pImqQtYDZsIxeqyHfZrgyxCPpuUDavO8PSfr6eIa9THdjiBLX6hUaDD5v5Mf3CjRGQbPHs6co3QMqrV1h6v+mJqJf7+5XdjCRy4srP20xC9r+UnVnHBkoDjhfAuxXGoaUJmHDBnW4ugrbnk0gInV/Srm5QD4VaGrYf+n4WhH23Hwo7lLEeAI2eJT3p/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrQYpdFEm4fBYfqFFeKCqy3OS4//PUjYgnK7Eeo8ffk=;
 b=Npos7E42WdlTfjxVzRA4wfAtvsJcFz2lM83NmX7EVzrWOsfrX/CsLv+F+ZgNhywbxWxCINengNbn4UUrFlYv78oKXldajlW0MERpzIyUCF5P/UHJkZ/MbWoaOyjhdqD5tgwDtdBAXAQE2TgoepGRtUR0qgKoDbXYSiwGaHNuArc=
Received: from SJ0PR05CA0150.namprd05.prod.outlook.com (2603:10b6:a03:33d::35)
 by DS0PR12MB8020.namprd12.prod.outlook.com (2603:10b6:8:14f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Thu, 21 Aug
 2025 05:19:39 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:a03:33d:cafe::75) by SJ0PR05CA0150.outlook.office365.com
 (2603:10b6:a03:33d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.5 via Frontend Transport; Thu,
 21 Aug 2025 05:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Thu, 21 Aug 2025 05:19:39 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 00:19:36 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, "Ahmed S. Darwish"
	<darwi@linutronix.de>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH 0/2] x86/cpu/cacheinfo: Simplify llc_id calculation on AMD platforms
Date: Thu, 21 Aug 2025 05:19:08 +0000
Message-ID: <20250821051910.7351-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|DS0PR12MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: fd67a0db-e8e3-4d72-e4e8-08dde07253e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?szkxS067YPVtVOJRlElI8AMBKBVl++S0hM2w9Mm3bk8y8nUl+KF4Yrll9mHN?=
 =?us-ascii?Q?zPiwW7OhsSleHBR/H9UiPTFF+YzI9AYDxnMRhCPZjWQyw/SNCToE9+wc2EXG?=
 =?us-ascii?Q?d9TIfixxJlR4bZFmElavuLZMzx2fbhWh/LJIHIOdmnBj7efxUPdTT32emo2m?=
 =?us-ascii?Q?cSErQNlVVQsHxlrNVSB/FJAKSk/vv70Z5b7cUWguDHXD7wr/LAhWOb/1jauA?=
 =?us-ascii?Q?DZTQLEjAuTc7T/i7DvcONW477cqxBlTKkt1OAFL1NfTcJ2Kn44X8goUI4BEZ?=
 =?us-ascii?Q?XBRX5p0B56BA8OZugJwUJxys1g042F4AnErwinZ3Tx2CiUrhzkJIlok8ZhrB?=
 =?us-ascii?Q?36aQnLvAUgCwSZhRE8BGxrYlop1mjlzhaVEQaJcCJ0QlzSz7wv49FlRjVc8U?=
 =?us-ascii?Q?oEKHHM54PyQ0CGaTRnxSnfgLshb0J4Rgna9DFRtdaBCnEvXxwYiISiGh/CDV?=
 =?us-ascii?Q?OnZA+hWnAeLmd094TN3Y6RhcQ5rUb0xwGRUS0wGgQXcA8bfMiX0kB8iSOJZQ?=
 =?us-ascii?Q?udaKrTuktdRBcUX6qcIO5LNDiaVlf9M2expuKYw9O7lcpYdImPoZmG1WZaJw?=
 =?us-ascii?Q?Ylpo9Z2eyXdw3gaWqv5DpLnfviRgWiCysZPEqGlIMc4iy2oM60oMdCZn3orp?=
 =?us-ascii?Q?s2O4YiwuPdKlvY5F9+9X37RKmeLhaiLOkXDU73YWspTnh82j9S88mrwzMo+g?=
 =?us-ascii?Q?Ufb459kdmRWi53JZFu9AhJwpflIrtleLgDYbSdZONCJ1VTeEkSnyr6hsQHYz?=
 =?us-ascii?Q?cpCB3J4MhD0hviFxoqVerQ5X7Rzb9b9NN99GVCwcmw2rdQXq4NVK65kMNl+2?=
 =?us-ascii?Q?twS/vYrvCtUPLB3xE2FqFS0hPrtkGsg1tnhcaFqmNq1B3Ew32GbOPzlSqsUb?=
 =?us-ascii?Q?2do5L+e4fZmslcaJQe6uR7noNM2zx5xo6jYs91JiG8DABZSKiyi/+PXqTrZU?=
 =?us-ascii?Q?YY7+ql5tDf2es0eguTEcG5/Ht30WnB8dOhP+wyD8OcM04u+LBoczU//nubWh?=
 =?us-ascii?Q?sNOc8xGjH/yncWRn5E9M15pmoU+xDqEkx1vNSfNcaQgbymBKmyGOBotgGXXW?=
 =?us-ascii?Q?asFcAp0khC0Rf2NRakMMx5IhZj8n4B6EjcEMiUtFj2PurL/xffUySI/FRUsJ?=
 =?us-ascii?Q?QSZAaGTntwbAz9lbPhTFYNH/ZO+jLqajzwRH8W7JSgRIC3p661iffP22uVhN?=
 =?us-ascii?Q?31QIQIEIxmrV9iPiaAcvqT6L/eZlui24thKDAXpSRyxnKb3wRlD1bOjWRjOT?=
 =?us-ascii?Q?HXY323f1d+fecJz+0vKxMELPm8WaFQqKJWPbPdYqEL7wOC27OKc58D9WL7a5?=
 =?us-ascii?Q?7xE7bVih+qidyOygXDLFDscbjPGu+w7mkZ+5y1QXrJFie6b+LUFU1DMvs1ZA?=
 =?us-ascii?Q?RFEquAMslZR5EPK7VC9MEQZMXz8t0ZyLDTcGPvYOujEHXBhSFbuaQLG6OPvT?=
 =?us-ascii?Q?nh+RiEme8+7um1OIfb7NEpAy9xLVrY3tZFO0KwO/PsWrRoZ+hB9lSCPqF1MZ?=
 =?us-ascii?Q?dpk17lP3JE7NTiJ2jR6k/cMFSKp1wL+K950T?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 05:19:39.3872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd67a0db-e8e3-4d72-e4e8-08dde07253e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8020

Reuse the available cacheinfo helpers instead of open-coding masks and
shifts in cacheinfo_amd_init_llc_id().

This series has been tested on top of tip:x86/cpu at commit 6a42c31ef324
("x86/cpu: Rename and move CPU model entry for Diamond Rapids") with no
changes being observed in "/sys/kernel/debug/x86/topo/" on a 3rd
Generation EPYC platform.

---
K Prateek Nayak (2):
  x86/cpu/cacheinfo: Convert get_cache_id() to use APIC ID and return
    Cache ID
  x86/cpu/cacheinfo: Simplify cacheinfo_amd_init_llc_id() using
    _cpuid4_info

 arch/x86/kernel/cpu/cacheinfo.c | 47 ++++++++++++++-------------------
 1 file changed, 20 insertions(+), 27 deletions(-)


base-commit: 6a42c31ef324476fb304e137fe71870fcc538c88
-- 
2.34.1


