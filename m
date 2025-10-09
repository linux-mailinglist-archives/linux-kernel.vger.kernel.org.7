Return-Path: <linux-kernel+bounces-847281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 911B5BCA6ED
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C8E3C7DE4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D6724678D;
	Thu,  9 Oct 2025 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XTj5nu6Y"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D43B1E2614
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032339; cv=fail; b=r4QaUVZQzsWWB3aDF2oycRLksDYOPrWNKPgss5NAQLdYJ/uMXRQRkUFZp95mh+vB0gYeLq3u4/gSFkOnRhBr0lBEb7dafe/mfYkuaqw8PEVHCcE/hvVSizSCmSI2lPQXj6I/jrbnp0eRT9AcmEWwTrTbGmnwi+5FTeXKDPNsOBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032339; c=relaxed/simple;
	bh=zCTH/6q1D4f1kJQE3W4TsgH6/1uikBv8mMwqcdK/b0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=au2GShSC4eqcqmAWNHUBityVZH+iA6Go8nsBDcREpQUMqGwT8p0VGO2/UT1n3HRk5SgLfqX803XkHih1XFmdwyztjszaYkQz5c/PLXu4MEqXClCBKkXN4G2JQ75X6zyaS2Ah9qyI2s7RVwnpuIdSuPZZbgizdQuVXijgI1j6yWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XTj5nu6Y; arc=fail smtp.client-ip=52.101.53.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RA1q8gh+gLee7SU1yErhxdmbRjKmPCcalpBNI1Muce6yqW+SLymGcbCxQtk2mK/Smy6LI8IFmgy9fCtBNjbzSF3JRtLpkpeTkl9P0wW/eu5ugCM79cd9ULXDH3OP4q77PgI5to63PxrIsiaVy2CdbKcXHzM8tg2EEZ+vBs954vnG1g8l2TEOHn5wUArSPHg/89SQHL5LWhQ68ASw2JZ2u3ylJ5dJYJ09BG5Z6udcaEGVAIoGl28BM7CQqmZxcDUDkKM2zhypcldTosWAgrsAbMGcPzDN9m/kdl3faUSSD4JF20ISUbhD5GzymFimzWvJ04ETQYj7FULI3x/qxCJAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKezOozn2ni66j80d21CIq7j4HubCbIJLKPI+10N5aw=;
 b=UQGHa5H5b2/N/tFCzBYW3a7hn+5EKQAo63faBKyZSOSVIR4GQkNA1SoKiF+Koqa54JS4+Kmsa4B8g90DEtFF14vxI6rxTSAOOmnjWs6nHdpzKaDaC8/0DZrKPiZg0rQiou/UOCGVwhvyVpzMiTgfMfwrDhHixUNsUWHeb16zTLAlS9UX/vQopyy/TyKXJ7MexJ5sHNPfPIwni1252XWdjFwRGTWhKjAbzAuvMJ9QJGTa7kTlRQNcI8GfrM3XEGh9+W2uY3qi5x5KblR4X199i48u3qffb1U6jRIK8Hlyql+BRfL/o8NhYqiUzbK1yhixmCgLVWmbEciODewYJNRbLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKezOozn2ni66j80d21CIq7j4HubCbIJLKPI+10N5aw=;
 b=XTj5nu6YgI3zF11VwatAv02IK0vKm/VQJdTbeIQO2r+pQeueUNBLPjh5ZBRrRPmtE6704fzPuTBPIxUsclLFmsYxA+LFfuON5wFZrZRtCC1/k6HTImsXmzxNmEFmqTWTG2mXEVzcA9qv32tQ8ZxufGEIjleSUxye76BssO2LME/pCRRjDyrcc0YUKfLCk3lz5xRlhwn+80eRb/RvQclA/hphXejL2woQchW7A26ZPCIn9eZdVFXEsILCfxJcXFTOMk+RASqdHmj8MyqJadaWps8liQZK3ZxzeIVnB+Hq7qKY1dL0ZeH9YtG9L7gkm1f4lCsq/vkw49wMyZHui4lUeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 17:52:13 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 17:52:06 +0000
Date: Thu, 9 Oct 2025 14:52:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Miu <jasonmiu@google.com>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/3] kho: Adopt KHO radix tree data structures
Message-ID: <20251009175205.GB3899236@nvidia.com>
References: <20251001011941.1513050-1-jasonmiu@google.com>
 <20251001011941.1513050-2-jasonmiu@google.com>
 <20251006141444.GN3360665@nvidia.com>
 <CAHN2nPKjg6=0QTcSoptxvQW9MpP0YwGUTx_gQDBxgCtSzxY5Pg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHN2nPKjg6=0QTcSoptxvQW9MpP0YwGUTx_gQDBxgCtSzxY5Pg@mail.gmail.com>
X-ClientProxiedBy: DM5PR07CA0085.namprd07.prod.outlook.com
 (2603:10b6:4:ae::14) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: b15fd660-584d-413e-36a2-08de075c8fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OOsjLgoavB7E9Bo4Z6hlT4ooxy90x8cT3YJtM4Op6eih2r7ACKR/zmGFnO2D?=
 =?us-ascii?Q?xedb9GoML1LNGzbwbPewhmJGOPNAEr2xbW3nnPtjcfIHtJYkuaymmGEm1ZXh?=
 =?us-ascii?Q?mVhBFSfegi8weDvaurQi+0C+8B60s0C92dw+gb7e4bP2vIZPMUGtFtMf312C?=
 =?us-ascii?Q?girl7uVqExVxXerYltjKk7VTKaVBIkUaILj1ddu9FhOtHRpP3UkQ6MKXvadz?=
 =?us-ascii?Q?5H2IFLM1wxt1EWIKYgC1Ho69VN/cuFFld7L23lMw9c8f91hm1Hl9N+BZXkiv?=
 =?us-ascii?Q?mnaOkA3mlDg50CIXX+XCQGltNYlOeoV+2ErPKnLGzkiRG3PnhqWT2Bvg98Dw?=
 =?us-ascii?Q?zib2zeeRrxSzsEDQ/2Y8vNlJwEi4qDcboRLw6neJHhtltPcu4q2EoYFVMsC1?=
 =?us-ascii?Q?A4xc48lIgYy9VOLmxOlhMLgtkl1Jr/sQmUo64wDqRKn16PxKuF+L7cdPxX9B?=
 =?us-ascii?Q?IMF6ING+MovXirh2ZtqXVWOQG06jw/PNfbkBKrj+eilM8oJzX/JMGUaVS7QF?=
 =?us-ascii?Q?jqEq5G/eLnnR37ygNtE4yN3CmAeZt7i2UqDHrt1oaj7AAA8iwtSf4Y7VSJK/?=
 =?us-ascii?Q?GOirXc8n3jiymVXSkCH5LRji9VZzhzROEB3E8gOWfaG/p2EL0XjqHS9XCnC2?=
 =?us-ascii?Q?kj4r3w3/+4zV2oVgRcyADJQymv+o/Ni14nbZXzPN1J0iDCbxbk4mFoT9/PYm?=
 =?us-ascii?Q?qiZCHZX7XOrn/1Qt8qLanYY2ZFIq2+aAd2GrXMB/zs88g/7shrJgGGXkLEX+?=
 =?us-ascii?Q?W/Zr749cpJpBBHYjK06s7JgGU/zULvbFp+UiXAA02sNdtIuS90UBa+vlWkjL?=
 =?us-ascii?Q?Z2ymA59OPdoKiYfPrDrN6Dww9iPh/g6sW/1YPCW1MIeSdEXwl+3mdo3wdlv0?=
 =?us-ascii?Q?GXbQ73f3fj8l2K2H1bxEAUSkqJC/7MBm+O9o4YXaUJGIeikyvfofujMPgCQj?=
 =?us-ascii?Q?a2biF0Bxqp9sO4q6f3Y5AkROxJjYJmKdkT1N3A0p8407/7GpxQKGo/vdgEUe?=
 =?us-ascii?Q?57omQyfOtlMJDfJ8eE0JnzV+N9zz2uLgcbT2k/eTWVovnBekN/Fa8y7yM+81?=
 =?us-ascii?Q?REufzccnJhFBT4Yui/XM+bUJ5MDHGBDkvFoyvFJsvDfgRyQifkFi/XE409B4?=
 =?us-ascii?Q?2kZ5ctusGQj/d+nuEenlZ2i+OjKUfzaQVZWl8nassATD0gsmqzOVxtZ5k9bj?=
 =?us-ascii?Q?tzda2bENzeJzbGQdpT4K4Zl26b00L2teFhhzy1O44NkzXRCvNoA6F518XK7b?=
 =?us-ascii?Q?btnLYD2WpbLxIc0WRFyIHCXRvdRd98GGBWJQ87AEBm537ikljtqmrSJ7sCLP?=
 =?us-ascii?Q?rJHM9Fh+/5bP32PHK52wO2ZOB2kDbb0ooiW8N1xZtWFrhDGNlVlF1GY61v9z?=
 =?us-ascii?Q?CVBQdbA1Mxgd+xKN0a+gotKvvjuGcE+BMwuzkwhCboPo2UFXkoMc/aLx0RAy?=
 =?us-ascii?Q?wFlCMhjIXeAiIlpvfS6wh4L6ssuXuITq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rm7Q1RSxw8nlg7eJ2XqyRE+OLzZdZlW7npzMReOeeLjUollK1WwGYuz142Yc?=
 =?us-ascii?Q?23S0ljjAavQWfmpvEnLXogazALeHFhnSeQ2V9piqsgPa3Gl3ZptY51lCL1FX?=
 =?us-ascii?Q?sv3mhGr3xEBRuMpBwxk+F//17FpXTq/yE4M3S4XX4lY2Z3ttgFW7lHdKpE2g?=
 =?us-ascii?Q?HXQ99IAH4iTxvonchMncYWh+GDcH2smKRaxBFjUaSquUMBpGb8lCjB+MC/8P?=
 =?us-ascii?Q?2pb52kdsLvRKRWMA6jx79iK85ujXgeXrPdHAfFRRvuPQziIymrYkLT9gxQJs?=
 =?us-ascii?Q?BN5NISFQz9fco3VMxukw55jyoIRYIuq9J0l1+UdOurqb+G4MM6+qrj8a8hMO?=
 =?us-ascii?Q?AdKRnOIkymM3kBtDNyrhLeYIqSgWF49E4wEv05ILGewmVaOMIKPDww81ZF1X?=
 =?us-ascii?Q?BAl6vr+E9emiHfJQ89YCWyACRZBvdvYSBQ4j8XeMrUq0gosTlywM82GR2LXp?=
 =?us-ascii?Q?KkBx4dTGKA/pfzWseIPSsornhCeWXvCVZ8mHu7d+Ez05SPXfOMuIitZkzCi9?=
 =?us-ascii?Q?DEhn8sg8NP2FgLQwwc8yOhetcxtUKQEcVqI3pKyP5Mp/YUjPoeSkut6gVVIn?=
 =?us-ascii?Q?STOwapRTyq84kFQamh5cjKl9+9trFdIysHV4kYx/52I1n3kIu5g74NNAaW9q?=
 =?us-ascii?Q?4nccjy+k8neoZM3Z+RoZmQw7RfN2X2eTy4Egfvjg4zSdRjJTGVXz4s3JJpc/?=
 =?us-ascii?Q?jSTXaKsP9ST/+BaEddjqWTLLsn8Amzwv7VTVlvwWlkFuNSDhaNXgP2QXaMJn?=
 =?us-ascii?Q?drzDkthJoXtW8oL7VCqbQ+bhRELOAnmkG/m6+NpfLVMiHJTLvk1JGuzbNlzS?=
 =?us-ascii?Q?naJ/VWiundYaOwzgnYeapdQFQfUqjwX9JuSjz4rvxwyAMGTo0zw2ePM5aOM4?=
 =?us-ascii?Q?z+s1CLDXX7EuLvZdWUvDpGh6zFcotv8XVc4cHYVlV64rJFrS88VUJRFkdBLx?=
 =?us-ascii?Q?4tI8fNWMwA8FRk4QSP1j0J74Ep4B8rNR/uxPVitKeeQCNJeaxKLD8hfzE5hF?=
 =?us-ascii?Q?x+m3r7qXU5EuUUZn8+2ohrjQxaQYGMoU7Xj8ILtFSFFH5SVan9688v/CxobE?=
 =?us-ascii?Q?LpD+2B4RT7/zkOH86PG33+771F81QKp/aW3C9J3Wk1aq1cnn36APjfzZJJv+?=
 =?us-ascii?Q?IlXef7i2vizswUn/zgbOVLqcDyFCZu6afVgIDa7ck/xSs0xKvG6OEDgt1yNP?=
 =?us-ascii?Q?3gukIu3psalJ7BcXH/xFOil+Q12Gqzu84OuQlcNplzzPjssZY37v4Q9PLHSP?=
 =?us-ascii?Q?f8cXI8bym1/p4Wh2ETU1DR+XhhjfSUiUEC8ns9EhyxncmqXIZ6h81mKwKSr9?=
 =?us-ascii?Q?ALhz1+0ZL/H/x+co463eoshMdn7XiP59L+rYT2rcSuK2hiLyn0XORD2YsQEu?=
 =?us-ascii?Q?GL8K6NyawDNYheEFE06DdCruk8pGaA6QjF39YmjiYLxYjyHVgibS952DuFVc?=
 =?us-ascii?Q?+NEFTP0fTIj6z2+GesBdnzOeBQTZIaDixArSoNo+075bbHq5f5qhzOqd8qou?=
 =?us-ascii?Q?h090/cvVJroS9A2/bAcQk2UJFRk8uia/QNZlvsB+5qh2lAJebbNGC+xSMFLE?=
 =?us-ascii?Q?GecpE5ONrPLqqMroRhpY+pIi5I09aE6Rfu0rwdyz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15fd660-584d-413e-36a2-08de075c8fec
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 17:52:06.8622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tu0OUcypGmT1yT20eNJibcBArwIspJHQC8Q5r/rJ1hGIsk9TUOTAZHNLtC08m2Fd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013

> > > -#define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
> > > +#define PROP_PRESERVED_PAGE_RADIX_TREE "preserved-page-radix-tree"
> > >  #define PROP_SUB_FDT "fdt"
> >
> > I'de really like to see all of these sorts of definitions in some
> > structured ABI header not open coded all over the place..
> 
> Do you think `include/linux/kexec_handover.h` is the appropriate
> place, or would you prefer a new, dedicated ABI header (e.g., in
> `include/uapi/linux/`) for all KHO-related FDT constants?

I would avoid uapi, but maybe Pasha has some
idea.

 include/linux/live_update/abi/ ?

> Agreed. Will change `u64` according to Pasha's comment. And we use
> explicit casts like `(u64)virt_to_phys(new_tree)` and `(struct
> kho_radix_tree *)phys_to_virt(table_entry)` in the current series. I
> believe this, along with the `u64` type, makes it clear that the table
> stores physical addresses.

Well, the macros were intended to automate this and avoid mistakes
from opencoding.. Just keep using them?

> > > + */
> > > +static unsigned long kho_radix_encode(unsigned long pa, unsigned int order)
> >
> > pa is phys_addr_t in the kernel, never unsigned long.
> >
> > If you want to make it all dynamic then this should be phys_addr_t
> 
> Should this also be `u64`, or we stay with `phys_addr_t` for all page
> addresses?

you should use phys_addr_t for everything that originates from a
phys_addr_t, and u64 for all the ABI

> > > +{
> > > +     unsigned long h = 1UL << (BITS_PER_LONG - PAGE_SHIFT - order);
> >
> > And this BITS_PER_LONG is confused, it is BITS_PER_PHYS_ADDR_T which
> > may not exist.
> >
> > Use an enum ORDER_0_LG2 maybe
> 
> I prefer `KHO_RADIX_ORDER_0_BIT_POS` (defined as `BITS_PER_LONG -
> PAGE_SHIFT`) over `ORDER_0_LG2`, as I think the latter is a bit hard
> to understand, what do you think? This constant, along with others,
> will be placed in the enum.

Sure, though I prefer LG2 to BIT_POS

BIT_POS to me implies it is being used as  bit wise operation, while
log2 is a mathematical concept

  X_lg2 = ilog2(X)  &&  X == 1 << X_lg2

> > > +                             kho_radix_tree_walk_callback_t cb)
> > > +{
> > > +     int level_shift = ilog2(PAGE_SIZE / sizeof(unsigned long));
> > > +     struct kho_radix_tree *next_tree;
> > > +     unsigned long encoded, i;
> > > +     int err = 0;
> > >
> > > +     if (level == 1) {
> > > +             encoded = offset;
> > > +             return kho_radix_walk_bitmaps((struct kho_bitmap_table *)root,
> > > +                                           encoded, cb);
> >
> > Better to do this in the caller  a few lines below
> 
> But the caller is in a different tree level? Should we only walk the
> bitmaps at the lowest level?

I mean just have the caller do

if (level-1 ==0)
   kho_radix_walk_bitmaps()
else
   ..

Avoids a function call

> > > +     for (i = 0; i < PAGE_SIZE / sizeof(unsigned long); i++) {
> > > +             if (root->table[i]) {
> > > +                     encoded = offset << level_shift | i;
> >
> > This doesn't seem right..
> >
> > The argument to the walker should be the starting encoded of the table
> > it is about to walk.
> >
> > Since everything always starts at 0 it should always be
> >   start | (i << level_shift)
> >
> > ?
> 
> You're right that this line might not be immediately intuitive. The
> var `level_shift` (which is constant value 9 here) is applied to the
> *accumulated* `offset` from the parent level. Let's consider an
> example of a preserved page at physical address `0x1000`, which
> encodes to `0x10000000000001` (bit 52 is set for order 0, bit 0 is set
> for page 1).

Oh, weird, too weird maybe. I'd just keep all the values as fully
shifted, level_shift should be adjusted to have the full shift for
this level. Easier to understand.

Also, I think the order bits might have become a bit confused, I think
I explained it wrong.

My idea was to try to share the radix levels to save space eg if we
have like this patch does:

  Order phys
  00001 abcd
  00010 0bcd
  00100 00cd
  01000 000d

Then we don't get too much page level sharing, the middle ends up with
0 indexes in tables that cannot be shared.

What I was going for was to push all the shared pages to the left

  00001 abcd
  00000 1bcd
  00000 01cd
  00000 001d

Here the first radix level has index 0 or 1 and is fully shared. So eg
Order 4 and 5 will have all the same 0 index table levels. This also
reduces the max height of the tree because only +1 bit is needed to
store order.

Jason

