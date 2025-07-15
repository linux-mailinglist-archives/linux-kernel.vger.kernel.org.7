Return-Path: <linux-kernel+bounces-731486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5151BB05513
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7724B17FB5F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBFE273808;
	Tue, 15 Jul 2025 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="boE4U36h"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994011D5ABA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568675; cv=fail; b=OVpDwXdXjRY0aOLA9Bmtk+s2qFa7a+Yx6QY98ye3zsTDefNr17mYcVc3fa0aEbV2Ui64sdM8AiekcrsELbl0OAvbjXGbC8NDFx2Xm5O4RBCpswdqiTlHvAjdXXQOObhZ72OsT2tiTCvIAmwu29h69rr4KPzPEGSFKh/K6i1AcGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568675; c=relaxed/simple;
	bh=l/1pUwsq0id0aQlY+M5UMNn6AA9jbnztKd8CnXUeYeY=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hB3Rnp5Djjtx6SPubc7H1uENibGMN8HzD02L0g9Vd+fmvs7Y8PhfIQbGiJDPZD2epVJx097JpPjPgJ5VnIceyD9UsrcfiImgZW3PcKBpyQxvAxzLZSGPIy8lKKlBeD2dm4GoNThUWLaDC3JKywlLJcidc2bRcxWqYqtw2X1ta+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=boE4U36h; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxQ9yZGqNZl5ccg2HyDsU/bb7FAuwCaqgaMUkCrYZmkOEYrPcZE5anAwb2HrdAd93b0XGeG7oFL9COpDi9zbeX8+8E3IDYz2FrcxMd0HM5q1vUVsR6opvXM8Jsjpvy6NqdNz1GlhbxqE89LvbFXap3oMW7QVsejzMgpZIEBehD0xRhl/UHdLW5aDyrPIENoJ98OBH+bZLLL8yo4MBycvo/VWdqBK0MvdWpL6DRJwjxU4TKJa5p9iE0CLm2X4+0IbWzNmTTPvPggf/AXVVv0E8zkewZzbXq3922C8Mqri15HdnFmRzFGLvSJM+dOOTr6n0jNIQ5N029OKF0B6f7wT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kzEVSnb2IQbk2xNfjqnccLS3I5ZdntZkU8Qz+21IKg=;
 b=qUmt+h2WX7LrQUQf4qZtvW0UTVpnpNN4fzGK+Wji8FsLaA1khzcbAY47zgnsYf1E6LZX4sTo1gcaXW/BzUhn5nS5F0fmKRR94sdQVdPFYYFrAdLBkr3ohdVXgQOaItpcXFHRIWxYR+FA40aekWoKK6ShPtToRFsinCcFzodCIMSpVDiEyon7vmRrxFjHMxNEoM3IAMgnWytTIUzZK5DzV44fnIEDs4K1425jtyn3/CLsz1lcYUHCMGPts2jlIQlClZoVLBMVSHXop1twDnjnT2U+K2cgUftOTpgKFj0c/gGYjOkAc2oLAdqKgirMIGsXf8hrtcq0rlT5mpCB4z5kgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kzEVSnb2IQbk2xNfjqnccLS3I5ZdntZkU8Qz+21IKg=;
 b=boE4U36hHY15r0h7gRVye2iLWUvRf67FV4xdZDtJomsSSbTBAHMiKhMysA8al4J1Csv6Nx6FTgmna60LYxr+DJ0C7lG6gxBelXZOxmxdXCAgwQ2d72yEB5ByxOmpTtB+20iR+RkKVfYwkrMDeJEf02uwtcL5uaZh8vc7fQR4yLM=
Received: from BL1PR13CA0228.namprd13.prod.outlook.com (2603:10b6:208:2bf::23)
 by PH7PR12MB7869.namprd12.prod.outlook.com (2603:10b6:510:27e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 15 Jul
 2025 08:37:49 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::7c) by BL1PR13CA0228.outlook.office365.com
 (2603:10b6:208:2bf::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 08:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 08:37:48 +0000
Received: from BLR-L1-NDADHANI (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 03:37:45 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>
CC: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <santosh.shukla@amd.com>
Subject: Re: [PATCH] x86/sev: Improve handling of writes to intercepted
 GUEST_TSC_FREQ
In-Reply-To: <aHUx9ILdUZJHefjZ@google.com>
References: <20250711041200.87892-1-nikunj@amd.com>
 <20250714104424.GGaHTfiFxI_pf-vhRn@fat_crate.local>
 <aHUTMiEJ-nd76lxM@google.com>
 <76e0988d-279f-be58-51d9-621806dbb453@amd.com>
 <aHUfecs9UJPx0v_C@google.com>
 <20250714161639.GLaHUtZwleS3COfxxX@fat_crate.local>
 <aHUx9ILdUZJHefjZ@google.com>
Date: Tue, 15 Jul 2025 08:37:38 +0000
Message-ID: <85jz49x31p.fsf@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|PH7PR12MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee701ee-216b-494c-582f-08ddc37ae14e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GYXVa66jn9u0+vA9M3qsPOBhSvGJ96L5+pVqWJrQxf/LGnNVi5RGwRFeAaIP?=
 =?us-ascii?Q?6j16MeI61QLdT2zGUlUs7xceycbFj74DQ/PMKIDq/QmyS+YNWC93DUxLGFIn?=
 =?us-ascii?Q?OKDo8Hm2BNw2xcS0GhoGfa0iVDjr5UFhYONnLtnklqvlqtX99xJR6mS3YxCr?=
 =?us-ascii?Q?StHK72cIO6plezIBk6PHdKs3FKYaf127wdGFWrUxkQHoN+qx5KUUcTdVTSCH?=
 =?us-ascii?Q?WDFU1PIc6pk3NU56eZpNxbCnd7qsEfOn3HeFvUp44CTiMvlLgnYqoyQgre6s?=
 =?us-ascii?Q?yOqDPmbLV9ucYZf0kzu3m91E2356+THb81Iu3GnXMLVkiXwomu9e23lX0D/T?=
 =?us-ascii?Q?+ue13JM93I4scaVeu0cdNMCYu9ErP16Jt15tGihgkmP/EEwGcQBRSS2nREBP?=
 =?us-ascii?Q?R56ZZnXeNhKXjDQ+RwEneMIbRxOqUFRkgK/aJZekKSuydE0Tu69glOTZ6bzt?=
 =?us-ascii?Q?N68BmED5RUgx5RL1iXNCukbWnCn/yf5LQGeY1BphQHVQ9F7RP4DeCqwB9qTr?=
 =?us-ascii?Q?YSi9kEyXXVY/HJo/VJaDW0XTG0NZIb2YOKvzCL6JTFQE4T+knTs7amJyR1IB?=
 =?us-ascii?Q?kbIFdg35e5cnOGopBVPLdIRMTa79HxRHamSqjbXL32s0goYpWKbVs6kQIe72?=
 =?us-ascii?Q?skQE6E9DCo90f1Xy1cEu+NbiEXAzFz8ixBmjRnfGVxrhJXP0qRhWy/w7gfcD?=
 =?us-ascii?Q?bPH3VVRMCl0X4L3dk+X7lJvauagxT+B2z1eAUWdsT/KddOY24pgOnWzdnwKh?=
 =?us-ascii?Q?UKQmCWqE49C3C4z6r5Nw1ckmiWbO46V8QbXsDnfMkeo4gemqzVdn4MZ8s9R+?=
 =?us-ascii?Q?K/ysVCLDahvtNqGf1zYiCnvTiVvnHby8lohH0nzJ8AMQMNt/k7EK4vJoAmKc?=
 =?us-ascii?Q?uAAQwALiwaQae0jCIciZ1kXjBUXioz/c/LJ86O+e9r36t4Gjh8ELR8xIKw+b?=
 =?us-ascii?Q?5IeXDQGaizsDHzJkNdepMBhvJhG6p81wS3lmrxnMwFYxcFG9tzQ3DL6bwqv2?=
 =?us-ascii?Q?pMJ5XeR8cuWoRbu4zv+4u39NwVHitinpCIa16Q8UmTbOzmfYtkBcSjVfxVYo?=
 =?us-ascii?Q?f7olVvl2yQ3JjTiiF5pKHo/8xc7hLYRuD1peX8OxamNvWCm1kPHZfZ/cGSlk?=
 =?us-ascii?Q?JFJRTlCxczwI28yknNDLCHaYFIugRiz1zS9wds0Okc0EJtv+9yCLUu8D4P2H?=
 =?us-ascii?Q?aTsO0a6868g8okLx9Wz/ba84hQJB8eiAS7ISbim10JXE+GUa1G9gqrlATqvE?=
 =?us-ascii?Q?hGHCLK0FcZMSJr1TmRKsUzSN8Zh+nSKuS2zyFkQoRrLLLQAmAfBjOp3rIGEZ?=
 =?us-ascii?Q?6m1RIXG8UDtJeiUJjVkGnluPtCLTy4D/oxJGwI8gl0g7bQCkJX87ebSBAOZV?=
 =?us-ascii?Q?31KY4ziISkRixWYOOp6Lh6SsVp/jlwGf1RutjL6nCjcn1oPViDMe9W4q6DUR?=
 =?us-ascii?Q?S/J5oNxqqCmK+yLeQdzFL4Kv3/yboJ68PmKVcleSbUlpM7hL2vC8Q6puB49u?=
 =?us-ascii?Q?C9HaYVAMN83AOi79kdD7FxJDppZ06VYWqrNh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 08:37:48.9461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee701ee-216b-494c-582f-08ddc37ae14e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7869

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Jul 14, 2025, Borislav Petkov wrote:
>> On Mon, Jul 14, 2025 at 08:17:13AM -0700, Sean Christopherson wrote:
>> 
>> The original text in the patch:
>> 
>> "Only terminate the guest when reading from intercepted GUEST_TSC_FREQ MSR
>> with Secure TSC enabled, as this indicates an unexpected hypervisor
>> configuration."
>> 
>> doesn't make too much sense to me.
>> 
>> Maybe you need to explain things in detail as virt and I don't understand each
>> other too much yet.

How about the below changelog:

  Currently, when a Secure TSC enabled SNP guest attempts to write to
  the intercepted GUEST_TSC_FREQ MSR (a read-only MSR), the guest kernel
  #VC handler terminates the SNP guest by returning ES_VMM_ERROR. This
  response incorrectly implies a VMM configuration error, when in fact
  it's a valid VMM configuration to intercept writes to read-only MSRs,
  unless explicitly documented.

  Modify the intercepted GUEST_TSC_FREQ MSR #VC handler to ignore writes
  instead of terminating the guest. Since GUEST_TSC_FREQ is a guest-only
  MSR, ignoring writes directly (rather than forwarding to the VMM and
  handling the resulting #GP) eliminates a round trip to the VMM. Add a
  WARN_ONCE to log the incident, as well-behaved guest kernels should
  never attempt to write to this read-only MSR.

  However, continue to terminate the guest(via ES_VMM_ERROR) when
  reading from intercepted GUEST_TSC_FREQ MSR with Secure TSC enabled,
  as intercepted reads indicate an improper VMM configuration for Secure
  TSC enabled SNP guests.

Regards,
Nikunj

