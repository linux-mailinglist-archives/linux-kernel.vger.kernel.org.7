Return-Path: <linux-kernel+bounces-733658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91FBB07780
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F467A6F98
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968B51EE7D5;
	Wed, 16 Jul 2025 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yn96X/R8"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BE919AD70
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674386; cv=fail; b=u/hEOS6lsj/HqiSduxCf2GVTxpzuPLpR4frqCDLyUQxHnAs5N+KpiZYwo86EtlLv1t5Ttsi1Uynk5+lCnhyHkD13GOWVg46nEVLAYIjeCE8M6JwCHAdoPw/nXQC1RoiRL6rqFQ/x6vPgEsXM4BLryepUDeXmztq1zx0dLZsKoC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674386; c=relaxed/simple;
	bh=OfiVR06ASDFANm9h2KvhGCXoHYJYJqwvKtgbiFvqp+E=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mU3tMSRBhk5SqrwFs4QxtPiymCwWYL/ZqNDNLSBpMflADB2oEB1XD1fGPp51zLdX9XLnsEzifUd0IEYB2ysAzDRU6kDm6gkYfnY58InwkNy8EsQTMYmDp/nOR2p9iXvnlkHEfm94cyC13jY1nRg4Sy/d71+fG6ZB+JVP5RYVrNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yn96X/R8; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9a0siuju7loTnDzjl9L1aN8V0Yb4kPo0s/E1YAJsFsmWDbWHJDm+oH3yMV83CsiNeNpvskVeGaeNgZ0wseTWGVYjNSPQT3Ds7PP22XKDTyPyYvGbC9dq9gdFk7cFl1BvGstWJricDKiFZ688XbZdZRE3X51J7U//j/6RTXUvwtTzl5ghp6Y1wQm9rJzBCj57Q4ZI4ROIsemrIJPoPb/zdsAy/w4GIkogXUIXuICZ91YPY76M3dcVhDqzK477SzAkgtt/5s3ZEs1pnLo9M+QQk1qJ/mbbZavfxPKF8gMlBZQ1S9z+sjph79PPdPIPzNnXRQ5oQtXZHU0MBlxgsW1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8NRybgpEu0OryXVo25y3GGOF3eE7HZ0jDnLRw2H9g0=;
 b=Mt5L5ztURJ2OFGHAMEayfZWPAd2QQB5Bsk5WJTnCZZM2IdEGrUg1YCForT/zCMyol06TDujaVuyn+wzKLOEgMgEo2rhczvl0Kp3QfcVVLgHepwUnQcpLp8nWxN7byna68AkZef02l/plSredbkY5hX0BkQ3jJ5XQzWQXFgmcCB5/dsAVDese3TAdhFwj2Xl15sEsjd2siYwIvo1B5zhjCud4/L3eq5f5pmvy4HV1ZiV/VHioNhBAt1/chNj2tFKRoQNhvDJ24GA/tBBKj6cIC96yTmI98F7Xbp75HYMjNRkSTYUQTfJ5OfHUbk0uhvFM3iXyk1ElEtHVYzGJhQ4Zjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8NRybgpEu0OryXVo25y3GGOF3eE7HZ0jDnLRw2H9g0=;
 b=yn96X/R8R7kGH8CKiGBLGSPzg7bhMZLbNK2vC1Szx8pwQsFOhcJ41pl9HwM5fvPBYKiIq5jXg8P6l2N0twMUYSKyGjc/EHdHBR5oSsWCq3TXk7rrj/9FzjS/Lk80ZhCBCJjDFZ3y9b1jGr2+fX44t8RmH3huS9IubSMokxczrbo=
Received: from MN2PR15CA0044.namprd15.prod.outlook.com (2603:10b6:208:237::13)
 by CY5PR12MB9054.namprd12.prod.outlook.com (2603:10b6:930:36::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 13:59:41 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::13) by MN2PR15CA0044.outlook.office365.com
 (2603:10b6:208:237::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 13:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 13:59:40 +0000
Received: from BLR-L1-NDADHANI (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 08:59:36 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	<bp@alien8.de>, <x86@kernel.org>
CC: <seanjc@google.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <santosh.shukla@amd.com>
Subject: Re: [PATCH v2] x86/sev: Improve handling of writes to intercepted
 TSC MSRs
In-Reply-To: <229325e8-a461-6e5c-0d32-1c36086b62f7@amd.com>
References: <20250716055315.2229037-1-nikunj@amd.com>
 <229325e8-a461-6e5c-0d32-1c36086b62f7@amd.com>
Date: Wed, 16 Jul 2025 13:59:34 +0000
Message-ID: <854ivcw81l.fsf@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|CY5PR12MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: cf6ffb0e-64d9-46cd-d11a-08ddc4710221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Q9zzucdP1j57MbkaCNnoHUik92lzo/dNFM1Xxy0IXMF3lZ056F+Pejc6KNb?=
 =?us-ascii?Q?Vcm4aRhK64h/k16q9q94qyWvQWRwbN0+j82VF4fCX2eE0yf7GKtA9XIzXPM1?=
 =?us-ascii?Q?YIoF100bgwPM/SyVU/yfVA0n8ZC8Z0rJTqdL2u1zb+oSvk+55mwUSFCxyLfE?=
 =?us-ascii?Q?HraMfw/vkmnzI4glG7SDWCY8rah95zQwkKqPV/CTyHTDr0Ju39XcUWUvEOej?=
 =?us-ascii?Q?njuLnQvLdaLuT6ZI3fAiS+zZvEu9oimSBt/TAYglszQvuHg96QbHtyI+hpgC?=
 =?us-ascii?Q?OcqiAlETwAe4x9Igq4TGVqpjG0MM+PBcK/YPKCamSR8MhO4ktPodCY28Bx97?=
 =?us-ascii?Q?W3OAcZpNy4U+jxBnrpweNG9uW+nyYneMANd3fEso8pW4Ux5HRwlFd+5HKHTh?=
 =?us-ascii?Q?/k80Yz3eaou7fo96bAiPZTp3YPdDEQkCivbWU//CdLTwAPTUH2Tn5AD5Hgib?=
 =?us-ascii?Q?wQIcoCCFNjqasDP1va+fOUfdsZKmkkIqrhewQ3dfyugYIcODNc+U4ol/cGpf?=
 =?us-ascii?Q?bMlq1qPcREHlUvQ+l005ip15N6vgQI0r+U0MhscABflu0i+usvibJYe2AWmN?=
 =?us-ascii?Q?CAUUpb9O7iE1zLOrSmj0PHy3f32cT9rJvp1uNEtugzTV5gHgXJSBv0QVxP1Y?=
 =?us-ascii?Q?ojkVUYGe2K3knStLnjNNkO/gHifuL0K7IDBUwQYYwqs8fEYPpUShO15594Xi?=
 =?us-ascii?Q?KM3NyPkuH2cWFihmyxEMcomLdWiVE1LPsdwRAH93u6vUjvGOTLpzWOW/pgIP?=
 =?us-ascii?Q?SK1smQOylEz2V8hEUlH1hnAPxjNWhiFlJ35vc9qOEidBloLDlp4pANQqzZey?=
 =?us-ascii?Q?DiTMEhCqHAGoUmdYcht7yUIN/X2qmYhtcqqCIh5Fbqb1l7HZ5SCxgSwW3dTU?=
 =?us-ascii?Q?BIqNNJNOwp0V/lzoumTZXgE1fzwkNlMixwQkVTmJR7PPLuIUXUMq29QPdyG4?=
 =?us-ascii?Q?1H0rlaqkpbdpUZmWB2WHbe2wX3Kd+Pcw4oWnVMey9QP37J82wFUqGdAaZTuv?=
 =?us-ascii?Q?DrLlEFx0cfqpu+7Us8eQwg87shYbTsjGHXrU8mwDh+PVNEWjptpNW/a6HIvV?=
 =?us-ascii?Q?jf7BPgFX0BktHtaSIMRUQ/Pjxo1M33iMnuq1EJY8zsAFxRstfH5i9tq4hI+U?=
 =?us-ascii?Q?HEY/NfNToFedI1vDtyrsizu5a1KhY4i8aDIzisGqExkpmZuKxbAWnmpC5Pdz?=
 =?us-ascii?Q?dhdSZWk/1s2qk3b6Nw5oPUnDuP7/l9czkUdfXSGg0N61pkGzDe7w7QupYtcb?=
 =?us-ascii?Q?y+A67ha77L4H5vtkLbdkbr39RzVlo8nECf7dENVBs16VkeYc0AbpH9TKB9DK?=
 =?us-ascii?Q?axH99t9eHOrIJHZZgD8D7/KRq3ujjwn2WKWTXRumufXZvMxbhSCsh8qHpPik?=
 =?us-ascii?Q?QBzv/PTiCUnK3m7ELXWEo6Sx14v+b6GAZOLTJ0EPCmAUc63xfAE8M3bvfpOE?=
 =?us-ascii?Q?wFO0/+c4Sy5+rLaLO7IOse1WeELNG70v8hV6gfczTTgZp5JdkoVpC/Kff061?=
 =?us-ascii?Q?0YgGgk8ma68jFGxcyK+qsjjgucA2CI0oH9+a?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 13:59:40.2155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6ffb0e-64d9-46cd-d11a-08ddc4710221
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9054

Tom Lendacky <thomas.lendacky@amd.com> writes:

> On 7/16/25 00:53, Nikunj A Dadhania wrote:
>> From: Sean Christopherson <seanjc@google.com>
>> 
>> Currently, when a Secure TSC enabled SNP guest attempts to write to the
>> intercepted GUEST_TSC_FREQ MSR (a read-only MSR), the guest kernel response
>> incorrectly implies a VMM configuration error, when in fact it is the usual
>> VMM configuration to intercept writes to read-only MSRs, unless explicitly
>> documented.
>> 
>> Modify the intercepted TSC MSR #VC handling:
>> * Write to GUEST_TSC_FREQ will generate a #GP instead of terminating the
>>   guest
>> * Write to MSR_IA32_TSC will generate a #GP instead of silently ignoring it
>> 
>> Add a WARN_ONCE to log the incident, as well-behaved SNP guest kernels
>> should never attempt to write to these MSRs.
>> 
>> However, continue to terminate the guest when reading from intercepted
>> GUEST_TSC_FREQ MSR with Secure TSC enabled, as intercepted reads indicate
>> an improper VMM configuration for Secure TSC enabled SNP guests.
>> 
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> Co-developed-by: Nikunj A Dadhania <nikunj@amd.com>
>> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
>> ---
>>  arch/x86/coco/sev/vc-handle.c | 31 ++++++++++++++++---------------
>>  1 file changed, 16 insertions(+), 15 deletions(-)
>> 
>> diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
>> index faf1fce89ed4..18be9f8bd015 100644
>> --- a/arch/x86/coco/sev/vc-handle.c
>> +++ b/arch/x86/coco/sev/vc-handle.c
>> @@ -371,29 +371,30 @@ static enum es_result __vc_handle_msr_caa(struct pt_regs *regs, bool write)
>>   * executing with Secure TSC enabled, so special handling is required for
>>   * accesses of MSR_IA32_TSC and MSR_AMD64_GUEST_TSC_FREQ.
>>   */
>> -static enum es_result __vc_handle_secure_tsc_msrs(struct pt_regs *regs, bool write)
>> +static enum es_result __vc_handle_secure_tsc_msrs(struct pt_regs *regs, bool write,
>> +						  struct es_em_ctxt  *ctxt)
>
> The pt_regs pointer is part of the es_em_ctxt struct, so probably just
> change this to:
>
> static enum es_result __vc_handle_secure_tsc_msrs(struct es_em_ctxt *ctxt, bool write)
>
> and then get the regs pointer from ctxt:
>
> struct pt_regs *regs = ctxt->regs;

Ack

>
>>  {
>>  	u64 tsc;
>>  
>>  	/*
>> -	 * GUEST_TSC_FREQ should not be intercepted when Secure TSC is enabled.
>> -	 * Terminate the SNP guest when the interception is enabled.
>> +	 * Writing to MSR_IA32_TSC can cause subsequent reads of the TSC to
>> +	 * return undefined values, and GUEST_TSC_FREQ is read-only. Generate
>> +	 * a #GP on all writes, but WARN to log a kernel bug.
>>  	 */
>> -	if (regs->cx == MSR_AMD64_GUEST_TSC_FREQ)
>> -		return ES_VMM_ERROR;
>> +	if (WARN_ON_ONCE(write)) {
>
> Do we want to capture individual WARNs for each MSR? I guess I'm ok with
> a single WARN for either MSR, but just asking the question.

Right, I had thought about this and concluded that a single WARN should
be fine. The chance of both the MSR being intercepted and written are
pretty low, and anyways a GP# will be generate for all the writes.

Regards,
Nikunj

