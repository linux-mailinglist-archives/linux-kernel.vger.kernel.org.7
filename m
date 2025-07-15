Return-Path: <linux-kernel+bounces-731523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DF7B055A9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1C43A45D5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AB52D29BF;
	Tue, 15 Jul 2025 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1b2lVzr6"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AE52741D4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569945; cv=fail; b=pfTqKW8saAQEC5K6u5cE16I/NFy4lhaFlLGqM6fPjdB7nlwQ5XwvwG5Jbwjih/MwA3NjwgBiIxxDtTOU24c1y8weJfytMu+Dm6WomJUt9vuKFyD3oLdMZY+NmryshiJvNg3v1BiQ1KPSZXqMRKaG9rrlDaXCLgjHELbWzzVpSX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569945; c=relaxed/simple;
	bh=pyS3pMKVTsDJH3Ri1r9LoGP0aLi6YBOp6tMCbitukYM=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ewpzBlMJklJ7TK0VU61gudAQwwdIFf+nfVCSVMhw/xqi+/KrXUSWoQYW74SbpLRPV/seStKFv1TVGxY7avwcYirBSJWCrNQ8g4FZfPY5F2mfaqumItqSyMKzqRkar+UKFkxdXtkxfecHwBSuNA2z723Jb1FW26CuN4dS0fTgfZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1b2lVzr6; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q01RBVkwDBsimmrTvXP23p/35bilL2iRS64xKpcFij2NXOduKvTMkTBgiX4d3egj5kwfft+H1kkgVQmKGbpRbNAxlYJaTP8wKrg2TCJ2PjCA/glR6dyCZ4lVRK+0ADnDwzb7twYXezguVgzS2T64t5QPy9dMuy4x7ilyY0pJc3mAVZjivIkw4tSUS4bhgx0Bk6Fw4pmJFlVH2jvZv/RnyhC911whRq5wu3O8llINmFadbD0LSYqdJ5piW5bfsPyFcPg2nvtMtYSpHJ/tdr5s85kqS0uhUAJm8/MVpn3zzFhClf1zYwvUdUNwMwCDjSAHToriKrci/NsvJEMyVgyZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMIRJvbo3y5HzVWU8r+FHzCFIwKGtHoI1n+tM+tH9jc=;
 b=oriK2NUtmDset6He0IVOJ8vDZ6j0FS1+ZKxZt/GJUn/gBqKcibvEtHve00rW3psyTL1IkaVhGVemQ3pejLL+M6139YziDJ1bcy+v+Cz7coLYkM67D6NP1kP6U81+p3yu81B69I2XaZac/GuEiASjdzEP+e5+Ip0WNg6brCBlMdvphr1W8TYqxpxo6KGkUPREU66ca6usC2RapGCcezi/nL35CVMpMUZvwZY03B7TFifpVfEl+8wqru9XojvDbcFGvSHDJZ9ETDE5Nwn+mPpcnhhVKYH5/emIs4etmyPl7I97gziA4WXGbF5o95CWy5SAcIs193C/YACDYL67EQewMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMIRJvbo3y5HzVWU8r+FHzCFIwKGtHoI1n+tM+tH9jc=;
 b=1b2lVzr6bf9qOe8BYPxeI7NtxI3LBImgd3u0eJxBu8d3lf9Swm9Y3sfnG7K27H16HWdIMimfj8C9G5GRiCiON4uwaAMF+DnRIkYHLy1H8dBmPPYChxFrzO0Jr+l2IQKuShPBsSRii68jB0moTzuZuGdcr2X3QLcj2B3bO34Q3XA=
Received: from CH0PR04CA0002.namprd04.prod.outlook.com (2603:10b6:610:76::7)
 by SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 08:59:00 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::be) by CH0PR04CA0002.outlook.office365.com
 (2603:10b6:610:76::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 08:59:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 08:59:00 +0000
Received: from BLR-L1-NDADHANI (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 03:58:57 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Sean Christopherson <seanjc@google.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<santosh.shukla@amd.com>
Subject: Re: [PATCH] x86/sev: Improve handling of writes to intercepted
 GUEST_TSC_FREQ
In-Reply-To: <20250715084357.GCaHYUzeqvBxJyGVsg@fat_crate.local>
References: <20250711041200.87892-1-nikunj@amd.com>
 <20250714104424.GGaHTfiFxI_pf-vhRn@fat_crate.local>
 <aHUTMiEJ-nd76lxM@google.com>
 <76e0988d-279f-be58-51d9-621806dbb453@amd.com>
 <aHUfecs9UJPx0v_C@google.com>
 <20250714161639.GLaHUtZwleS3COfxxX@fat_crate.local>
 <aHUx9ILdUZJHefjZ@google.com> <85jz49x31p.fsf@amd.com>
 <20250715084357.GCaHYUzeqvBxJyGVsg@fat_crate.local>
Date: Tue, 15 Jul 2025 08:58:49 +0000
Message-ID: <85h5zdx22e.fsf@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 385202b7-8a39-4d14-a84d-08ddc37dd737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b5oNPjlQDfBbjriohWkGeAkDh8le6JoU71b6KN/cIfXcslnzGMk5eNvt+eCI?=
 =?us-ascii?Q?ZBvSFoBnqorfQpd4iKLoKS8NJNpl1ZsbUH5kcpaiAl0SU4sCt385IN7yQ0u/?=
 =?us-ascii?Q?QBPkBXXEqfqSae8/C19NNXyrWf8PGrzyVTBH14N9Bks1H4bMRm7aRIt1OBsF?=
 =?us-ascii?Q?CPT/EBbFMU51V4bdUd5TMew3BGjxHlgGrp1a14gDRJ5VSZM2TMdA2U21x0gq?=
 =?us-ascii?Q?RBNvTmLodXoQHVfInUs6HNEV+e339vj8hX2hgQ8UvyV7glDETf0O3Hndov7S?=
 =?us-ascii?Q?lCTioCVvK1dlut7xRzluDX+vEvof5mKWv1cXRcRK9egt4jI6AjITJSwnkQHG?=
 =?us-ascii?Q?CV0athMwWXu7AuPfcdwFgMeZDcC3GhvtV9/6Hd0ZIXWtspPmPTedfJfws0Kr?=
 =?us-ascii?Q?Q4Bnb1lgMkEQ5k6HAjMzQ2e/I6g2GpZsBi90ku3ltIcy0KIAys5ngzOi1Ao2?=
 =?us-ascii?Q?qpYE6Qt80YMLb+vtUjIjsG74cWpiL6t15Rw1iUYtTGd3DPNMzYxQW5nywGmd?=
 =?us-ascii?Q?Q94cA5OF90VeantM/OjUjEmu11gtu6LBDB/+Jo6VGYIx26og0qgKkMbAuXDI?=
 =?us-ascii?Q?rS9CHKdHRWZNjHxTPEf6Y1+KNylD6mz8eyWtFebxfPmpxLkS9J34RjRdUKLw?=
 =?us-ascii?Q?PhJcaL47iRNoBlgLa5PifMP1Pq0BccOuQyWu6orl0C+7t/ug0GnCtfgXsXGr?=
 =?us-ascii?Q?VpEaZESlO4pI7NPoZk4PfadQksK5KQcJQgtiaVzIUNCq4kW1/TTAUHOHbjtJ?=
 =?us-ascii?Q?wnndoeiSBhpOLQ5bah5n45peHXd9nCJBA8u8dqeXpwZfAkX1/FmOqZiW9gEl?=
 =?us-ascii?Q?2Z+32pInUY/ooAN2TXqZ7nbkevzK5zrMVOiACUmIy1l62K8g3thwWVvlg3VD?=
 =?us-ascii?Q?N64oSSWeaziYSHB8GtAdpJafWLEoDJM/t4YGOROXXJtnCpwoGOjGrTzXjrJY?=
 =?us-ascii?Q?519XmoI7k/hCU0T+C56+zhGZv+76kjJqRu2hc/gXzs7nuRPaWM80wqbaiazi?=
 =?us-ascii?Q?NrXn3KkKjzfddrBBYjyrsWSX8xIPbUWqAcMKQN2nLgxODTEggFR/QSlvtu/P?=
 =?us-ascii?Q?h7T+Gtmp9cY6ModwO0ZXSJUTxOjmkmBpvyDFGehrRp8xXgjwKJt0VPZWfUEO?=
 =?us-ascii?Q?qEfik2Hwbx9+DLyfQ2rg4t6mj+/p2ez2GCDbomTtKiXepDEpZ2lXFDmEH8NT?=
 =?us-ascii?Q?5wp3W1wc4sR02GcQALUl9w+qOtWH1wubYgKzPfeKICrkOAiGRHvXLwHe70hA?=
 =?us-ascii?Q?PPkVS8ab7qH5kSFj0t1YSCf25NT616DejDgyE7TXwV6IY0MYie1B6CeI0eLb?=
 =?us-ascii?Q?nuRPKZXlvzowhWjUrG61pVVboPx/5fWLp7o5M7X7mycUVKbJxRljDHyUEUMi?=
 =?us-ascii?Q?bV8Si8ZOox3b86ZJuY+s7pOJqQO4dOdLvGnNAYZLtrYuSKM7aRZ7Ful9IZ28?=
 =?us-ascii?Q?VrQhi51zLa7zBvwTornRIftd0+J1uFm0c8TiUwJjjw2zvaLRkdMfBXkxAPZI?=
 =?us-ascii?Q?Ic/cAIOxcJKbWxBqru7itY0dbuSGfaWNkaeJ3oeIg9bzEM7s4k+s+b50aA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 08:59:00.4895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 385202b7-8a39-4d14-a84d-08ddc37dd737
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670

Borislav Petkov <bp@alien8.de> writes:

> On Tue, Jul 15, 2025 at 08:37:38AM +0000, Nikunj A Dadhania wrote:
>>   Currently, when a Secure TSC enabled SNP guest attempts to write to
>>   the intercepted GUEST_TSC_FREQ MSR (a read-only MSR), the guest kernel
>>   #VC handler terminates the SNP guest by returning ES_VMM_ERROR. This
>>   response incorrectly implies a VMM configuration error, when in fact
>>   it's a valid VMM configuration to intercept writes to read-only MSRs,
>
> Not only valid - it is the usual thing the HV does with MSRs IMHO.

Right, will update

>
>>   unless explicitly documented.
>> 
>>   Modify the intercepted GUEST_TSC_FREQ MSR #VC handler to ignore writes
>>   instead of terminating the guest. Since GUEST_TSC_FREQ is a guest-only
>>   MSR, ignoring writes directly (rather than forwarding to the VMM and
>>   handling the resulting #GP) eliminates a round trip to the VMM.
>
> Probably.
>
> But I think the main point here is that this is the default action the HV
> does.

Correct, to adhere to that behaviour, I had sent the following patch
earlier [1]. If GUEST_TSC_FREQ is intercepted by VMM:

MSR read will terminate the guest, same behavior as earlier.

MSR write will be passed to the VMM and VMM will inject the GP# back.

>
>> Add a
>>   WARN_ONCE to log the incident, as well-behaved guest kernels should
>>   never attempt to write to this read-only MSR.
>> 
>>   However, continue to terminate the guest(via ES_VMM_ERROR) when
>
> ES_EXCEPTION

Are you suggesting to change the intercepted GUEST_TSC_FREQ MSR read
behaviour from panic to ES_EXCEPTION?

>
>>   reading from intercepted GUEST_TSC_FREQ MSR with Secure TSC enabled,
>>   as intercepted reads indicate an improper VMM configuration for Secure
>>   TSC enabled SNP guests.
>
> It is getting close to the gist of what we talked yesterday tho.

Ack

Regards,
Nikunj

1. https://lore.kernel.org/kvm/85h5zkuxa2.fsf@amd.com/

