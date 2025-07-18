Return-Path: <linux-kernel+bounces-736224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11718B09A3C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6019D1C2819F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47731C861A;
	Fri, 18 Jul 2025 03:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hG1aLYCA"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961C74A33
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752810160; cv=fail; b=QBYJ8U/4XESf7Gx+STqoQcPSBt3GuY10DeTJHyYFubZfrghFgpHstvIUI4qnRLjFr5j+sEkvNPV672HZGINKQt1qrEmlk9jd9lVHMxgB4H9QmSTcQZQTZU9ylE30At1a0GAvoRWYHORY2SonbQX7ZyxlK32WWPLLeJAZ4HKEbjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752810160; c=relaxed/simple;
	bh=dkWfqxWK+Vx5dfxmVa+nv8zNLE7hs6kcEF+3JgLvXoY=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DopsQLd6zLWXXhFykX3ywFCwEFl/K/+Uh0PkQ0nrSK5TZwLFMA/lGjEaar5ADqwJt4bVMLdONAqhReMFc+nnJEPKs1OMkNaNut/eiK2CJWaaI3cKBi4sairn26noTWmJLg05QKQudWX8jkTeHSlmp+WJfVWjzRFNr9XqFDqfEfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hG1aLYCA; arc=fail smtp.client-ip=40.107.100.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7Sb+NdX7+L0Dkl2eu3YkGCifl32JKQ3g4dRlFIMbfLb+emyFoX6l1x4/QA1+HVq+LcD5MqFgrXU/pocx6Ch77cKjErweWbdctU3IS4fQCz8x9oGnqg2eKeQ5hjWUI3QkELOEH/m9fmr3cVLni1Tt0yNIqX8ubv62/bMavfWp41PseC6hHEKOBim4wkmHlvlQRm4Kjy32FaUI/qzQdFoTyUT8irF4Ksd1hwYLln7wBiycNY+uMy3wphjEX4W0zQbDmDn58wwMm9UPf9ZTCL5IvlSKd5AqA0SHnPJBj1KED1jPmQFc1xb2EBdGoSyfN5Nbd5V3aPrAs5vdQhm22WqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRLlG6qOPrkkcndatstf22uwSgfGSVYdW8rlMN9Q3fQ=;
 b=o7ldljejyYE+Ujxtrgrup6fBxizfuIwjoKEzY1twLZlCG6AZflsFspHvZT50xaktQqAR/6qpXZpoZWeVKHFT5PBDc2qmFWuKtby1lSk6SqIMZgR0qKi2YY72piOSeU8Sabws1Jlemo/01djJYshTj3XU+5vAcv1o3VKCqVHSioClIdtiP5wcPdGtlJFNVgQN1wjv2xuZFEXn7oELbr/WCvdZ6kMih2SqJ2MnTsK95LlI3GkkTfALtfqY6T4QrGM+GT2mnaTqIks5VvPlkmZeRLIRcry1M3S4Sdl9rVuACDwTolpRrYWwkIrQpWU8Nl7MNt4rTsOb6ISc9jQCA4dkeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRLlG6qOPrkkcndatstf22uwSgfGSVYdW8rlMN9Q3fQ=;
 b=hG1aLYCAMivc3i6eSgOG7KZ2e4Jv5i1TwISgvAsvmnrkZdsuNRqaEJA7PMBiKONETnz0fsa07EvyhMvyCd7+rk88DnLPZZL989yzIngsMe9st36Fk3g63wzLXDOQ91c9Ez03kP88SXWxwhs8enZ0wLe6dqx53NuiVywkq6+VRLM=
Received: from SJ0PR03CA0152.namprd03.prod.outlook.com (2603:10b6:a03:338::7)
 by DM4PR12MB6589.namprd12.prod.outlook.com (2603:10b6:8:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 18 Jul
 2025 03:42:31 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::78) by SJ0PR03CA0152.outlook.office365.com
 (2603:10b6:a03:338::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Fri,
 18 Jul 2025 03:42:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 03:42:31 +0000
Received: from BLR-L1-NDADHANI (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Jul
 2025 22:42:28 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: Sean Christopherson <seanjc@google.com>, Tom Lendacky
	<thomas.lendacky@amd.com>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <x86@kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<santosh.shukla@amd.com>
Subject: Re: [PATCH v2] x86/sev: Improve handling of writes to intercepted
 TSC MSRs
In-Reply-To: <aHeyNvzvbgrWAob5@google.com>
References: <20250716055315.2229037-1-nikunj@amd.com>
 <229325e8-a461-6e5c-0d32-1c36086b62f7@amd.com>
 <aHeyNvzvbgrWAob5@google.com>
Date: Fri, 18 Jul 2025 03:42:36 +0000
Message-ID: <85zfd2upub.fsf@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DM4PR12MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: 714998e8-99ed-4aa8-c11f-08ddc5ad1ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b+fVOAGTb81x8T0H+28oGOOoYQrX4ylib08UouEqujrHscF2Cvi2TlIQLImq?=
 =?us-ascii?Q?Oyp16bn3FSaue9zWqVWvO8TcB0kgDFJVTni0GSC1X6iS8bhDocEGVcSbnHJB?=
 =?us-ascii?Q?OZp9rEB+BBYjIU/uAW8u1/jOj3VMf4J6SEw2WOSQ6FxJ0BG4dbFqqwQ9jZqh?=
 =?us-ascii?Q?RbJVeLJuerzaZ3+4QiPO/cSXCS1c4PuAW31mcetMBQXwkvJd0O13FyfmrhvC?=
 =?us-ascii?Q?b8VsGvEiq0UWP2DbDsezxFSBvMhLvZ9sov2ekYOajpxchW2r5/Rn3+tz+t/n?=
 =?us-ascii?Q?C+uWFMh9Ow4iIP+yEnElXHFonvs228zNXIMD5Tub45Fwbd1GihQS16mCkz1m?=
 =?us-ascii?Q?OyH8oOgD924kZcdBnZwCV4b5tDcv1h53QuYWZn0VKI+1IJNjZQGC55BqwgvN?=
 =?us-ascii?Q?LhuZQ2Rr6QX+7FCvq4sudmgqeUpYvdbBKwYnCpufuqWnAwVxQU4qjsJQoNH3?=
 =?us-ascii?Q?ILyq2E64YcYioguYJGgTXhcAhpE9FcYZfaA39Dr+Ed+BkfuRstU8PVss4k4u?=
 =?us-ascii?Q?bciJt9H+WKGLrBVsJrwBe8gibHAFYONWn8mOlKWSot5YoSVQDg3MA/DSPNtM?=
 =?us-ascii?Q?FIl//yfnREyyVxzW2J54x4+PSRbsIijdBRDQDypmY35GEkbhu0UXXwGiukES?=
 =?us-ascii?Q?PVQnUyru7nlX9LigHGF6xqj6WQaojIinhGXTzfCZQKO91RKKYJa1K49CquSl?=
 =?us-ascii?Q?SoLrznuDaCb9I1dvGph8Y8swfrIGBBJw4eC4fh5GMB07CQLEUv2btvU6Dz8s?=
 =?us-ascii?Q?ogC0N9Eha4H0+hnpj+30sC9h9dJCzJc9WUcWcL+bq2wCnSxARGTr06oOZMBN?=
 =?us-ascii?Q?mmVz7eqd458aVBVsAYBkyZO3WrywgiBviJfFV65HS1dT+w49IGffayPycvkc?=
 =?us-ascii?Q?Jut8po75I+ohRLHl7hYcgk5wffDqf4brEQqEwo3BO89od4unJ0muCDkDpN7u?=
 =?us-ascii?Q?z4+aRhaig8dQUrkBelZU6X98KELVcdo/BgPqBhoayEhblB/PhhO1ejL54Mmv?=
 =?us-ascii?Q?8P5uAz3M/c+nTq8T6QIZM7yPA5gs0ffPNkMi46kmyC+6ff1J7pAHYFyAfjPX?=
 =?us-ascii?Q?pIRfZBQf9WI+NCKnSNe3uh/FTyH56dVOmvksd8nyxwYSU3cgPOOfgTkU7mhK?=
 =?us-ascii?Q?0FJODnFE0rWTIbXxbTm9wfpld1DzC0BO8k68ozf7QLTq9xZ/Y2m43G9PkUhS?=
 =?us-ascii?Q?ZMkd+gpJ0E6aP1DLDvY+TiYixnkckVKuC/JZ3RgSQ+73Ovcpb74LjA+zui9V?=
 =?us-ascii?Q?3cx+lNlI2NOdq112TeygPbcKg8MYZaHCILMpEakSeGeMrcXTU88AQpVBImGh?=
 =?us-ascii?Q?JVfAtrbPCAkPWNXTiYgj0MU449HXzUL+ie+bU6sMYw45wkzTMyMQMrXl9Xt1?=
 =?us-ascii?Q?jF2Qb7wH09eMQANxRlbjvWV+bYGANtumk83aev53Q7JWgHG9E3t6cejWKJ6t?=
 =?us-ascii?Q?W3huPM2/LCaX1kT6AvMrUHM9mgaaSqHpFIF+SOwJDtJBxMhhtmYMATu3FU0p?=
 =?us-ascii?Q?tliRuN5BwZG4118x83ik5qJ5gv0+O8XGvXWu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 03:42:31.1934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 714998e8-99ed-4aa8-c11f-08ddc5ad1ffe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6589

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Jul 16, 2025, Tom Lendacky wrote:
>> On 7/16/25 00:53, Nikunj A Dadhania wrote:
>> > From: Sean Christopherson <seanjc@google.com>
>> > 
>> > Currently, when a Secure TSC enabled SNP guest attempts to write to the
>> > intercepted GUEST_TSC_FREQ MSR (a read-only MSR), the guest kernel response
>> > incorrectly implies a VMM configuration error, when in fact it is the usual
>> > VMM configuration to intercept writes to read-only MSRs, unless explicitly
>> > documented.
>> > 
>> > Modify the intercepted TSC MSR #VC handling:
>> > * Write to GUEST_TSC_FREQ will generate a #GP instead of terminating the
>> >   guest
>> > * Write to MSR_IA32_TSC will generate a #GP instead of silently ignoring it
>> > 
>> > Add a WARN_ONCE to log the incident, as well-behaved SNP guest kernels
>> > should never attempt to write to these MSRs.
>> > 
>> > However, continue to terminate the guest when reading from intercepted
>> > GUEST_TSC_FREQ MSR with Secure TSC enabled, as intercepted reads indicate
>> > an improper VMM configuration for Secure TSC enabled SNP guests.
>> > 
>> > Signed-off-by: Sean Christopherson <seanjc@google.com>
>
> Feel free to drop me as author and just give me a Reported-by or Suggested-by.
> At this point, I ain't doing a whole lot of anything for this patch :-)

Sure

>
>> > +	if (WARN_ON_ONCE(write)) {
>> 
>> Do we want to capture individual WARNs for each MSR? I guess I'm ok with
>> a single WARN for either MSR, but just asking the question.
>
> Or don't WARN at all.  If the caller is doing a bare wrmsrq(), then the kernel
> will WARN in ex_handler_msr().  If the caller is doing wrmsrq_safe(), do we care
> that they're being deliberately weird?

Agree, we can drop the WARN.

Regards,
Nikunj

