Return-Path: <linux-kernel+bounces-732917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FA6B06DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6DA1AA5B96
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B914280328;
	Wed, 16 Jul 2025 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hEJDtwBD"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305488634A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752646219; cv=fail; b=A4zx4xE683obPF0vlZglIk+gyVcrTOml09ilrEh0MjBBG62DhO1qzQTUm8x9bRUajKZibQj8R+XzRNBcr5l5JudbeSDJ0Q3OTf7BLFUn7RCJiEBNekzgfvs6MxtHQQ3UmqoWRE9/EATpkGdUa8IHbwgBt76rZVzdkgtHGFQX3qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752646219; c=relaxed/simple;
	bh=tA92OtVsljF97YUkkIrSa+TWexDUIxRXxcNJF4Xa3iY=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sVXHlnEE7IB8UjGPUSUpx3WjxHlApccLYmnOPrEpPOEKQ7jRWMCkr76MtX78w5N2mSWpDVOEWh3VSLJ3Z/hvkYoTmyYtM7zjZNfrCYXHvTlq8gmzGIZabvaag+cXtA+bBh35GRKyRRa7JOpzzDm6leL1KNCqCFFTBRQiSg/dQ8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hEJDtwBD; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIadFncVBcAufXR2oyUl5lrgXVIawr/G0YaBB6aPvJoMooGNayvhOIm8jKBq89/sKEp+T24jI6gr5tQBtWKy11+o1+ZCmS3PsDBbrz/519NYr/SwxUYVSDK8tz2hUk6tJ0+98H8qwB2RC7Hwx5Cu7XI2qbakViWTuQfUg5wgtQSuNcZYlooHSu7OOrik28iDsZ4+R1mA+xBhgY0notBYwWSXIFbFVgJWR0B/N/BG1dg2wCsSLV/eojqAV+X1iDF2GdeJ4w5HJDCA2uZAzbNMRwMln6SHZpBL3sUQwj+/mvcEYMW19Q3SjCmToYtBbAKeAgBQwG2hB5so3JPWPHfFZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCiGM1/hED4DPfgeqso+2LApZEmzYXJstxPggWjq/Xc=;
 b=k1UbD7EXvev41w0wLDgAYb/fbQH8Wfa3Cqntlg34CahRoqCc4+Lcgw9p4UIL9QOSW1USdqXz6KKpsGrwUd1YB4z6PX4ysXO0OpbRMkzT8KZPdxftrYfXc3a5g6sk7VOn7ADjFmj/0ZTmW3LGehNnLPSMHM02MQYf0ZBTl5qfX/DuZKNZUMDD7DsV7Gaz3RmLAXQ2zYVWDwax6bY2qOgmGbdojWrOlBPB4CLFxZkgMfrvLFf6HTc9ATRGQxlMsqRzdY2slt1bFZgycwIfE/uqVqmpssRXrV+faQ1S2B+NEt7RW2wvcVNhE3zhcYZL5Qtft1aj01J8EKGAebATPTDnhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCiGM1/hED4DPfgeqso+2LApZEmzYXJstxPggWjq/Xc=;
 b=hEJDtwBDQy9qUzWrZ7qXkuMfT4L1NNzfPnKEXi6iN/IHC26G1B2XkvbGt1XY+s+XJhUKG/RGQCQEHEgvpHgTyTp4YJ6UT76U/T+cDfKCBtahUyblwvvWz1rjiASrdwmsPN+aQtNBZhecDd4/yB5qiNCxqUjLZt8Vkl0vlKqftsE=
Received: from SJ0PR03CA0206.namprd03.prod.outlook.com (2603:10b6:a03:2ef::31)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 06:10:14 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::1f) by SJ0PR03CA0206.outlook.office365.com
 (2603:10b6:a03:2ef::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 06:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 06:10:13 +0000
Received: from BLR-L1-NDADHANI (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 01:10:04 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>,
	Sean Christopherson <seanjc@google.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <santosh.shukla@amd.com>
Subject: Re: [PATCH] x86/sev: Improve handling of writes to intercepted
 GUEST_TSC_FREQ
In-Reply-To: <e61ab0eb-816d-dc5d-dde5-e305a27705b2@amd.com>
References: <20250711041200.87892-1-nikunj@amd.com>
 <20250714104424.GGaHTfiFxI_pf-vhRn@fat_crate.local>
 <aHUTMiEJ-nd76lxM@google.com>
 <76e0988d-279f-be58-51d9-621806dbb453@amd.com>
 <aHUfecs9UJPx0v_C@google.com>
 <20250714161639.GLaHUtZwleS3COfxxX@fat_crate.local>
 <aHUx9ILdUZJHefjZ@google.com>
 <20250715083827.GBaHYTg9eU55LcHKR1@fat_crate.local>
 <85ecuhx1eh.fsf@amd.com> <e61ab0eb-816d-dc5d-dde5-e305a27705b2@amd.com>
Date: Wed, 16 Jul 2025 06:09:56 +0000
Message-ID: <85bjpkwtsb.fsf@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd7587e-3ff4-4e25-e729-08ddc42f6dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PyefcerW4jQqjZVXVwgZpmrjAP6Hod0Erzuj6JLMCHjRBjYpHwvCaZJtvtQX?=
 =?us-ascii?Q?fd+As79lb9lp6VrB/S6Z6fu3/2X2QO0jKouW+dRKPIFfiKypji+8I/Cp9inb?=
 =?us-ascii?Q?B2F2U0o2ya8EsiGZlJC0K1JFEN6FGw8x//BgkOLZ4flfdA1ZTAm1I9IPgmMv?=
 =?us-ascii?Q?Wqb+9V3zmb9OHUhM0bAfmO87b1nZ8i0cDZ2HpGHAjvy8/2tfaovJJi0qzdhQ?=
 =?us-ascii?Q?OeVjtGP3S1v8Z+1AFi74nYkvo+EvdrbrD3fi6hO/w0Z50+cFENlMfSaipxPz?=
 =?us-ascii?Q?kdRpkdjPPhCAVO3VrIdm9vf7rvswG3QVYDSKD6nEZ8ES6R2YuEkjgPDr0oNb?=
 =?us-ascii?Q?Ypfx7rPDqx9ZqtTtP9BGWwPN9xcQwD/RHbwnMmSzD5ZedzvKoi8RpZYl3QS8?=
 =?us-ascii?Q?ugAAkWy3Z7Du+9oAswwe0p1cmSH6cKWM7jOlQ/VoeYAGdrwhU19uScXx57A4?=
 =?us-ascii?Q?fhiPemvg0aneIs72gguhfxqjcQT52UHu/Ri7Dj94dz9aO4iaM4IQxO3v5fmI?=
 =?us-ascii?Q?0UiWsrgrDvEWT1HkvigUzF2UZ8SYpceJb9XfV7eyLgUnJb1LKXQOFiMKf4Fr?=
 =?us-ascii?Q?mPYwOWQ/CZPgPteAE3mkrIdacbZiUGEn8zlhdFDvM5feHwq0RiA+kgr5Rb4Q?=
 =?us-ascii?Q?zW62EldeiTDZ8qlsCUMX5l2HHb3KSNt9GBXZGoKrPFctK2dF5JPEEXfSMnkU?=
 =?us-ascii?Q?HUqlVca6HaM0njFDe+LagEUvVq82AxjeNA7hQ8TvnaEV91eCtG3DW4CzDMHh?=
 =?us-ascii?Q?juaEmj9d3Jxe5gC4d3zVsx47rHeMX3h1JPR9cCoG2Rm3EAL5GgR9K0T2sHLo?=
 =?us-ascii?Q?gQJfNFThlq6l7TkhrUUUoCuoKGSNDgWaeWI+woERnCqAvglHk4CnSg3jxwib?=
 =?us-ascii?Q?oO0BEzPXNVroqfd1zOUqdkem2pSoJZhWsIfiEZaN0IbWWmKWJiNwOcVBrmC0?=
 =?us-ascii?Q?elZ84hjS1wtVLRjxJbNy6TuxL3u199RDS5bAM3bOZlxcnOM6YuyVn3yg7mJG?=
 =?us-ascii?Q?FLpBGb5hJU/HD5t0wpwSS36YShqlEPH3c8XKf8h0IjCRPwMY4iLbdcHDmmUe?=
 =?us-ascii?Q?e+/lUKoIVpHE3dSKZG0JacguJFqatctjQNr6CE2CdkDTFJQwSdfy6VHoMtTx?=
 =?us-ascii?Q?7SUW6TNqGSzAX7YColh34bFO9YndL2i6I6ZsbGt3NINWZs3bmovG0HshJxV5?=
 =?us-ascii?Q?FpCxSQDF1gQqpj1BzOZk0GMDdXNKflZtId2AlDOSWnQOdrQm4nfcmUck77VX?=
 =?us-ascii?Q?px32QP3BVkwkXfVC+8SHVjPOfyFxM56neXZoIM0+EFcWKtrP2rua7xsS3kHH?=
 =?us-ascii?Q?cppWa6zBSg+nL48hHdlPpkrBpXIbL96Bcu4qBDqgAH6249PD+5iCGc3HxA5o?=
 =?us-ascii?Q?W6Ne/IiX0IkfEMW7KH5wGKq8/PWiBi0TxQSWZcicfgfl1K/zOG+Q+0hlAvBP?=
 =?us-ascii?Q?yQWGZ7qdKM48Gc3AyFu/mHMnHH0D9KlCuUiZt0C8ysyGExIzmfu4vJXJnVll?=
 =?us-ascii?Q?yefk7Vsf/Ptw3pz++WJCOHJmj/at/cW/zvEi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 06:10:13.9437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd7587e-3ff4-4e25-e729-08ddc42f6dbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798

Tom Lendacky <thomas.lendacky@amd.com> writes:

> On 7/15/25 04:13, Nikunj A Dadhania wrote:
>> Borislav Petkov <bp@alien8.de> writes:
>> 
>>> On Mon, Jul 14, 2025 at 09:36:04AM -0700, Sean Christopherson wrote:
>>>> Or as Tom suggested, return ES_EXCEPTION and let the kernel's normal machinery
>>>> WARN on the bad WRMSR.
>>>
>>> Ack.
>> 
>> That will panic the SNP guest instead of #GP:
>> 
>> root@ubuntu:~# wrmsr 0xc0010134 0
>> [   20.804335] ------------[ cut here ]------------
>> [   20.804336] WARNING: arch/x86/coco/sev/vc-handle.c:383 at vc_handle_exitcode.part.0+0xc1b/0x1090, CPU#0: wrmsr/607
>> ...
>> [   20.804507] SEV: Unsupported exception in #VC instruction emulation - can't continue
>> [   20.804508] ------------[ cut here ]------------
>> [   20.804508] kernel BUG at arch/x86/coco/sev/vc-handle.c:123!
>> [   20.804514] Oops: invalid opcode: 0000 [#1] SMP NOPTI
>
> Did you fill in the context with the #GP, i.e., ctxt->fi.vector and
> ctxt->fi.error_code?

Ah OK, I didn't know that; after populating the X86_TRAP_GP, SNP guest
does not panic anymore.

+       if (WARN_ON_ONCE(write)) {
+               ctxt->fi.vector = X86_TRAP_GP;
+               ctxt->fi.error_code = 0;
+               return ES_EXCEPTION;
+       }



$ wrmsr 0xc0010134 100
wrmsr: CPU 0 cannot set MSR 0x00000001 to 0x0000000000000064

$ wrmsr 0x10 100
wrmsr: CPU 0 cannot set MSR 0x00000010 to 0x0000000000000064

I have sent an updated patch.

Regards,
Nikunj

