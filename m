Return-Path: <linux-kernel+bounces-897652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B82C5347F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A23D034FF31
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B34A33A026;
	Wed, 12 Nov 2025 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e3RxeN5G"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010016.outbound.protection.outlook.com [40.93.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B08B35CBBD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962835; cv=fail; b=qbxNZGX15s0wVxq1eFOwoOsD3qLzUOJD6BDk3iVqP9W5gdJk7qWOs3REdySrgalC9+lzTVYqYMPhZooPc4BjUx3CGFaJfAzdFh0FkxByA7yBF7OaeMFvwCBpzL7cyprOjHp0I0anLjlTdJN3Bw0k/q5wWh6tD8tednLpGEqX4YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962835; c=relaxed/simple;
	bh=FkCMavdXPYRhH0AgB/7h2VXP0OX5ei6kzWsZPFrLSBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Few/Gf+U+s9jccG232AhRbIaFeFZ3Y/Pvhc6+KJ0C6erB8w/j1v+tmoGHiCIliEYybzpEBZdzADin4uUcDkxu2uiwh70k1wfsWyyG0zGn8zMtyEopmaI7Ou3tQu11ptF+/OOW+MsFIu8G6l3o7lU3SgNtc2yN/KiTQov3frcis8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e3RxeN5G; arc=fail smtp.client-ip=40.93.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bflZWXhTDetwozmRB/xLDPu/BOfObVfKF8Sz7tC8HlZHu97YAqIrTIq/2CLooOHhxWQMT3woIi+w0MhsKjzB5I25zUvqnHLsu4f41KCBwXy8LZBg50JhzOeqKtjhfro0QuEURkFwYchyHdju3vh03bifR3FdGF7twY3XE5V/wT3RrX/CkcdkjBE6hfZdyxxupN/QwWDCDP1qnXlU6ktCfSN6MkobZjDIwcvC41BKodz3+V+X23Db4Zo/KXT6Vq9fdKbiBuv3Ngwq+nRWe0PDPuffLgm29cu0Yd7j127McKNzdhA2VyeywJb2dYEuWgSgBllkPAnd+2kZ0zrxr+MTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ca3hRu4LaVwRgVw0AHdna1G0KgIaAq41re81qxHvPs4=;
 b=KUwKCvq3aHx8RxxHbvXQzugAPR7g61CIIqC8Bzc4EUAgNN4w9eU3K2mXCl21VLWCjEi7Zfh77o/xLVz0RZxZzUyK7J9i/PXVZr93k2yRELUVYu0g85nYkLeTnmtSXb5N+UkNjx5GyPKMURKvzwWxmIR2PHPWBAUgLPiRLlWxVKqdPmUcFqdLwCZbXU4Uuk31vXbMLmzZ5Q7/9EwkktbFAQt+Hb2pP4H3va2WnC6320OOljMQj/E+QisLq7FdW2zm0PrZ8+ZPEUChclGftFMo61/RMHz4MixLfQelkAAseIDkxJ0uPYCqNLUl4YDDU+TvHrdZAILR3hyLi4xt+gwvow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ca3hRu4LaVwRgVw0AHdna1G0KgIaAq41re81qxHvPs4=;
 b=e3RxeN5GFJAB4yhiHacXbRXqJNGFSYMdrYf7/9eJhTFsnTxATOzroOu68SM3jCgoi+ERYQxjlfJJxYPyrBv2V55bz4E62GE0naFOYrECuHoUu+/GICmcybGYNuyoULyv5aIMjjb2Docsj1Iwlw46JVmNnImrNdzBqJXmKB7VHF/6K+fnuMtZ/CFc3ktMTjXQQvfxdVNWYcU1xLJtPwvrbEtYdE+EpLHoPB/7jGG2SNVbxU85H0hIq1wPQROd7GlVeqYP3MmIXQz8K+ftgPaPQwVEwFlqgwzswQdLZDr4/eZIwA3olyG8KiWw8UgkBbp7C20MDfv4BrCMMiWjbhK0+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB9315.namprd12.prod.outlook.com (2603:10b6:610:1cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 15:53:47 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 15:53:46 +0000
From: Zi Yan <ziy@nvidia.com>
To: Huang Ying <ying.huang@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <baohua@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, Dev Jain <dev.jain@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Yin Fengwei <fengwei_yin@linux.alibaba.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH -v5 2/2] arm64, tlbflush: don't TLBI broadcast if page
 reused in write fault
Date: Wed, 12 Nov 2025 10:53:44 -0500
X-Mailer: MailMate (2.0r6283)
Message-ID: <6B091BFD-FAF1-4A41-91B9-7C55CD2FDFD6@nvidia.com>
In-Reply-To: <20251112013822.54334-3-ying.huang@linux.alibaba.com>
References: <20251112013822.54334-1-ying.huang@linux.alibaba.com>
 <20251112013822.54334-3-ying.huang@linux.alibaba.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:208:2be::16) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: edec41f6-1d18-4b1b-3af8-08de2203aa04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vvTX598hnY6JV4qP9iVYfccq55+R1JUhP2zbKRLq8h5VycK3MOZBnIjEvujw?=
 =?us-ascii?Q?IT3xK6h8GkjN7CxzmL4tq9lsm7Quk+51UI9WAYHENDAYJh/0Evivjj/l4PT0?=
 =?us-ascii?Q?ApoCZPB6Xcg/aI+Z8a89Y8Cr+ElT6QdaIg/rMMXB8ldO987z40kZficUGF+K?=
 =?us-ascii?Q?1WC/PlCxXwaSaQWAZ+UsyNmguOR0Mkzx3CjshyjDjORF59xADZSOdJOLGcIO?=
 =?us-ascii?Q?jmLKH/CGgIZk1MO9+kBZgI5E2jKGOdtfmtuAuvjOGCpRNnLCuL0gB3hE4OHQ?=
 =?us-ascii?Q?6vHrafglCgLuSf3mEWBgJEs6JK4GHor2PqI2tZ0Us1nU3fyqdVyIZlYfn8A4?=
 =?us-ascii?Q?waLsumAz5DRsq8dY67O4YBGN05vKrHI4+uVMAwFg7UhYEwMpjrycxmLtPpLu?=
 =?us-ascii?Q?iT+L0DVY6Y/nfe4UPXM2TQCF7sLVM49P2y7fn/0+UPm98PzgthnCiVVJCDE0?=
 =?us-ascii?Q?q21wByrgjit6klRcYk99nyFkueA2UwUucLoVXHOFSY+s0dP1eSNuj3WRqFlv?=
 =?us-ascii?Q?FpLAkrmFtOGFNDbOqkAMWwDJMn5sTCR4Vain2DuCuhWHidI2gW3EQ2AuigLa?=
 =?us-ascii?Q?6Z3hidaezboOd2Wx9OgUvo6dXNurpAIYk4wodPf3QIDREwd1UWgNa1CS7VhU?=
 =?us-ascii?Q?5c/pnkgmecEKIKSoff+OM26W2P5dbuVg1DaRv5/qd/IhPwgjPB3qQW1e/UjO?=
 =?us-ascii?Q?5709qAvRUR4fe4C+1ctccl3Oh7zb3xmOJsYZaGrKnNIbFpkukqYpaXR+WZIF?=
 =?us-ascii?Q?CQ+a/OL6KApSojlNmuYjmnoOTFp7zDzqbAVvxhQVrqkFw527swb08q/Aaisy?=
 =?us-ascii?Q?COB/Qlnc565OOJKTyht3tXV8EiUg5FfxC06/+y3Quk4SH6eLDjYC32Ce+flA?=
 =?us-ascii?Q?v7u6kG0T36PzmAvdgVqWrVKhlHUfH5MY+aJkrEJYFYaYScD3fzYK21jzOfrg?=
 =?us-ascii?Q?YCGLVuUR0PkZNln96kjuk0iRWqQdw2zPy08ueq7SJIhIJl1zLf6O70S13AQz?=
 =?us-ascii?Q?IgqEhrZd0PJ393uboROk5CU0pc/I9Yg4AA7y+tkFOL2DhT+/h38s9cPqK9K/?=
 =?us-ascii?Q?DmZM9lXmqmnY53tjXPEIVt7KYFzaGj9g0UcOpxdrtuxKsr19LhbLApwOdk1g?=
 =?us-ascii?Q?j89ZW9QW0HHHmDQ2GZ3axPmRrkFbhm9l3KhxqJXt5FAJaRvw5lgUY+GSSnq9?=
 =?us-ascii?Q?4xo+R7d4dxmmBIRR/i99WaVICKNqbo0N2XpIjhPEVGOt4V72RFS1uqPTYqbp?=
 =?us-ascii?Q?413QMKXZhYP/x9sx34n8pOCeDGnE+rdPIkiu4rEbwIfSVzfwQngNEdvTh68n?=
 =?us-ascii?Q?a8PFXJmkqnEpsdPRt60sjBPmYwWUn/AVvA77HVWkAZ9rohLP2cWcRSZB9FPz?=
 =?us-ascii?Q?rEhNlOlYjT9Wn0sRtfb5yVYe//9Wzoqfg4RFFKlO+w7KcBD9epi7E4vwupTD?=
 =?us-ascii?Q?rLvVHZQNeYTfidw0La+OB2UR3V3QoURsgn7RRKYOuItH0bqw7+UyUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mxCTvU74FA+qVlQCwyVWDJag12EUFxYjZIHlO5BKnbgoDfpp5ke5v6xda3Sy?=
 =?us-ascii?Q?B1oa24uY7UTd8KaAfyaVod1GesZ7fHXk+SRJdNHYd5yONiRU9z4NHP6e1HjF?=
 =?us-ascii?Q?YsWv4DNzVqXJNT7PE3gxhp3jSDbCfOaHvZsJ56mCW0SLilDguiETn+6S7tfM?=
 =?us-ascii?Q?/E1rfBXc/3QS3/08T0e3VWd0/SqGo16qCzaF1FlGaYB+TglELKbbb7I31xaY?=
 =?us-ascii?Q?YINkmecqCo8wHdBxv2raNTQSKbFWdN6OVLkQcLXl8Z1MoIWv2YVo+Xs+nIZk?=
 =?us-ascii?Q?S919mETN79X2EpuOyTnCNzsr5La2Hz0tlDgrh8wICZSpX7t5LMqijPxfryGB?=
 =?us-ascii?Q?gZpPM9+QFotf8czaHlbobj1dmQultQDbcD3kZuzQFm58HMg+BN4cj4zLfw7r?=
 =?us-ascii?Q?PRjU0m9ibHJ0UxW/fKxhzR/fWBrPbHWdjRvqGSxdHBlalYk4puXF4ZqbLHx7?=
 =?us-ascii?Q?FdrH8W+CoWbX8jJMhbnbYSMHanAGV76JhAtUxhmUJx7o4wuFmU4jqlUInIVD?=
 =?us-ascii?Q?SN+whb+gKvCxwp+ZkbAB6a3nzMiQP/FTDAoJ0C7SL20cbJY861L1z3ZekHxo?=
 =?us-ascii?Q?BZ/eDeBFBPf4eMQ5M3vtQks/AgC5P5K8JK/s55aLq+0Djvi3jswoIZmtEAAp?=
 =?us-ascii?Q?SN+HCmc/465kD822dfxFFJ7XORbk+09kLh2DiAn8AzeSuvRPaGqhEg3H2SGi?=
 =?us-ascii?Q?ltHeKueM4M2PooCI8F4OXxt2re1lByMYGHNZyqyRZYUICAq1RZtthBz3/FXD?=
 =?us-ascii?Q?FReVliJsmu384OMBGqPIZ98r505UvYd8e8GzkJdn7WBFdr2xIsRokmC5lq1I?=
 =?us-ascii?Q?qJ+ZrI0KyOLOafhu0y+kZ5kKeOkbC9ZERqM1zfahgzKLYXAjaKkyv8ITa5Wh?=
 =?us-ascii?Q?elkOqpv4S20vP6EOaMlnckw2BmptDrCQgaecHS85ZBWsQnGapIzk8W/bE5az?=
 =?us-ascii?Q?cvXfHg7iQAFhOGaBOpsViZKQMrKtf+bu+mtktx+WnMFQxPLvQkOlp4zWUBiM?=
 =?us-ascii?Q?S5l9SphRgblpyk4kK7v7ov7I5nBT67ZI6XkQUZTIWzgCi4g1OXRov980Qt+v?=
 =?us-ascii?Q?uC7yMDzV6KI4+GPYSYYZdDRoWvSKza4EHSRVRpDSBNWK34rwecNP/GNmGFC/?=
 =?us-ascii?Q?r+Y2iRWn90dQ7oOdIO53VmRwSktCvNV7Eb635gW4OvBrVbIgepRlo4xL5w+z?=
 =?us-ascii?Q?ijiSFfekz9EF49XL3I2PEWtBU2lzk8kvRjK24F55y/1+vWLwAhBxVeI9YABQ?=
 =?us-ascii?Q?yvJG9zAncNlEPmly3YrIMz/KOIe/k8OZpgUzIDbVtByO8X5FHsulByUN+zJX?=
 =?us-ascii?Q?jeEeW4dwA0hIuW85NSEnuj8WGvnbX1Zr280ePJ1ly3UFJjBJ1zzFjvpZjG/N?=
 =?us-ascii?Q?6HIR1/GEGxlpSPOP5FmNK+Nql4534qUJpzZYhZH7cdFKyAGdInQ6nrnJ99Hr?=
 =?us-ascii?Q?xo+JvpVH2v58UN/JFL5LfWwNEyGUT6WCO4+D7z35+OgUvp0QuNUASP19HTRF?=
 =?us-ascii?Q?1NbDOnqjitV0TvTFz/T0VwpbgPcC4Tku57MVPEMcfHY4auEpufapaqYK4lSw?=
 =?us-ascii?Q?ztzOXp9pgFkO9QkJ+LYy0gOAVBb8AIL25icSXq5E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edec41f6-1d18-4b1b-3af8-08de2203aa04
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:53:46.8557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpuaghQPpGNVkPKFCz9vNZFjDlcUEW7uyTaHSYEBWUjVucKvNXbi3+if7MM6a1RW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9315

On 11 Nov 2025, at 20:38, Huang Ying wrote:

> A multi-thread customer workload with large memory footprint uses
> fork()/exec() to run some external programs every tens seconds.  When
> running the workload on an arm64 server machine, it's observed that
> quite some CPU cycles are spent in the TLB flushing functions.  While
> running the workload on the x86_64 server machine, it's not.  This
> causes the performance on arm64 to be much worse than that on x86_64.
>
> During the workload running, after fork()/exec() write-protects all
> pages in the parent process, memory writing in the parent process
> will cause a write protection fault.  Then the page fault handler
> will make the PTE/PDE writable if the page can be reused, which is
> almost always true in the workload.  On arm64, to avoid the write
> protection fault on other CPUs, the page fault handler flushes the TLB
> globally with TLBI broadcast after changing the PTE/PDE.  However, this=

> isn't always necessary.  Firstly, it's safe to leave some stale
> read-only TLB entries as long as they will be flushed finally.
> Secondly, it's quite possible that the original read-only PTE/PDEs
> aren't cached in remote TLB at all if the memory footprint is large.
> In fact, on x86_64, the page fault handler doesn't flush the remote
> TLB in this situation, which benefits the performance a lot.
>
> To improve the performance on arm64, make the write protection fault
> handler flush the TLB locally instead of globally via TLBI broadcast
> after making the PTE/PDE writable.  If there are stale read-only TLB
> entries in the remote CPUs, the page fault handler on these CPUs will
> regard the page fault as spurious and flush the stale TLB entries.
>
> To test the patchset, make the usemem.c from
> vm-scalability (https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-=
scalability.git).
> support calling fork()/exec() periodically.  To mimic the behavior of
> the customer workload, run usemem with 4 threads, access 100GB memory,
> and call fork()/exec() every 40 seconds.  Test results show that with
> the patchset the score of usemem improves ~40.6%.  The cycles% of TLB
> flush functions reduces from ~50.5% to ~0.3% in perf profile.
>
> Signed-off-by: Huang Ying <ying.huang@linux.alibaba.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Barry Song <baohua@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Yin Fengwei <fengwei_yin@linux.alibaba.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  arch/arm64/include/asm/pgtable.h  | 14 +++++---
>  arch/arm64/include/asm/tlbflush.h | 56 +++++++++++++++++++++++++++++++=

>  arch/arm64/mm/contpte.c           |  3 +-
>  arch/arm64/mm/fault.c             |  8 +++--
>  4 files changed, 72 insertions(+), 9 deletions(-)
>

LGTM. Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

