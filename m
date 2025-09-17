Return-Path: <linux-kernel+bounces-820655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 142FAB7D597
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EAB81897EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BDA21CA00;
	Wed, 17 Sep 2025 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MNh3mCPm"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8CE337EBB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111724; cv=fail; b=LfvGfan1Mt9TELf/R8xyCewLBbomYkXyRR6XEVU1tFWnm6BRiQZGcQgDIYdwACThQzStHdV1ntzUIoxVAhzqItxriobR8N1T7bKaKYD7AkyqRi7nzicTtumdobLNQ4Y2SmB5bkUiaclkneo1zkh5VA3+YL7uSbmIJ7iXNvizzbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111724; c=relaxed/simple;
	bh=NTg8/owQcmb7slDf8rMTXINYvY806nUR29yRN1dtN+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z439LolahaCloRUR3/ytngJo2QZ/8PocYOpeHq++Y8yA2LkAvTUnQcLTPD/brnvx3tyUX6gUtJN3fUADlaZlOzbXiO9Yq61CaQeRFh7BhRy+Gl/b3d1+Fm+Jm2SoEMWFXOA1X9aqU7UD6ocYs/ALcqHi4qD4cx0cTalRfzK2esE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MNh3mCPm; arc=fail smtp.client-ip=40.107.209.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uw7YUwjqmhY+O0eHsZWHBrRiWXWTN9Bzn1u/TYsCvIQd2JulfMjzV8DH9UByqdEKFeZgLlP9IAXBdCzSCgfFEOFEpIBmBS+PrW+PBxK7sxpfSD6lf7QuPo0SPymxwj5lMviHcENuvbuzDKNfCtcvUqFqgJiOBmy3NULmw9AxsFE42lIcBJ/RBGikHJCS9+Nh4+pflqeFFRtMkypIVlGH0k3V39KK+WKqzVleh8oE9wzjfBMWqMVc6ooNSaUzfiUnChnbUva8OG/pH43ZNrFT0C3XPbU66nRWWtAyf3JdlsPoBr3MNeRZl1xcMmcMm5pj+0+A8s6Yn48+IoOO0BdGxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+8gQLIdLt/aH9rVtxf72G7JSm0BzInQ1KAeU9N4iSY=;
 b=AJgur9gvv5FHJB2Y9Zby9Tedj+lZ5FzfjjTR1I4rAObL9NhzR9U7jEZXOp8+Ol3qC1u2a1hhS2k0xm8MRP+dWJB7G78fJdTodCfP1kfR4DUO9vEYVw3GbJLm8/JcZ8j3qa75N+Pf95Fp+5EGRbpnWVkVoDX3Yk1PTAtdCvl4Y5JiD6BBe+d93BwwId6EFPZ4EFakj3w5NGl3NZ/MmPfdisEBT3DIyHsdpEzJDgHAzRMlRSgxGZZQMZOo9eFgw7kzcpt3/7mP0gp+WBQLKMsp+0g2hoY1YDaFXThQzZ89S7fsqRVuSmYpb2B1+BC4UZ8YovCDd/H2hz1idh9M9zXZUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+8gQLIdLt/aH9rVtxf72G7JSm0BzInQ1KAeU9N4iSY=;
 b=MNh3mCPm9p115fUP1TYRlayFxLNkos902NcG+JqGpscGdAVjfEJhpxdnK3zr6cnohbFrhsgbbTuWr49F/02x/WJts8qF8HfpjicZNreBwgFkjcNtUjw3LfID6S180HUF0cS9zaYdYN84Kcnj1Pk+6II/Q4ZZgmgwwv+W/jmWsJVoio4/bzUu4FCaIHWCw3coFflNbHZ5pdHC1m6owXRxQko/WdabKh+/tXuk+kz+XBoP0sYQp6Sj2v0uJXf7xb+CnDmx8oTCg34AaxleSG+TGZ4q7UI6+6QQJSUBK/dfwdfMrMNV9JqApw3XPs3ujBBCKn5fvPHih3S5sb7Hu0PFaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SJ2PR12MB8112.namprd12.prod.outlook.com (2603:10b6:a03:4f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 12:22:00 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 12:21:59 +0000
Date: Wed, 17 Sep 2025 09:21:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Miu <jasonmiu@google.com>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Joel Granados <joel.granados@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Petr Mladek <pmladek@suse.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC v1 1/4] kho: Introduce KHO page table data structures
Message-ID: <20250917122158.GC1086830@nvidia.com>
References: <20250917025019.1585041-1-jasonmiu@google.com>
 <20250917025019.1585041-2-jasonmiu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917025019.1585041-2-jasonmiu@google.com>
X-ClientProxiedBy: SA9PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:806:28::16) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SJ2PR12MB8112:EE_
X-MS-Office365-Filtering-Correlation-Id: c3f7a667-5391-4fc0-0384-08ddf5e4ccf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cw1CXY1RGZ5xCjnrNRvp7ssEdYehd+OgZg54tZVSJtbSU6r49I5YojeNMOAg?=
 =?us-ascii?Q?PFEUjwLehnGQaj7vPhlaRdTX1RDFz9UQF43R/ux9xH+HbFfvmOeaK90vPgAI?=
 =?us-ascii?Q?SY5DXLLMyIhUu0ptdbnIr0mo+6VZ9Z9+ienq0iYgfH+IcxScx7sYvWxzElqk?=
 =?us-ascii?Q?9iMuajexLHQyCe0ayb93jUd1th8uK/kYyN6ZgZC4V/eD58p+eANmzoST1NFV?=
 =?us-ascii?Q?XzLzcldMR4BP2St7OnfIOVwUE8liQGGuCc0Va/lUuNAgP2c08rovGKDJ8Isf?=
 =?us-ascii?Q?KUGdCO7C3Ju33pCHO3mcipOZS1ZAMeqI36ND7ZwZvTyx3C3QQerxaJoPnEuQ?=
 =?us-ascii?Q?EOVZSQntTeJbyZ467oY6MgWUv0xGAPBR0+Sk57MieMQWYj3pHwz4pIeAl6Sl?=
 =?us-ascii?Q?imNCuzHQjgm1W5esJZLx2A4uZhEB6lNaX6YaNAAFLsNVUy1PlbdXTgbsiizY?=
 =?us-ascii?Q?BjVdsnfjOqcFBZqVGXBM15ZCmR3OIWlOFLlPAEDsUNGhPGsiGtsd4bW81s1M?=
 =?us-ascii?Q?bG3nsnWjPiuKyi9Fs+KU+KmIKQidZchI3ujH6V/Htqmj8ILjqZTJxpf+7pas?=
 =?us-ascii?Q?qh51TlIEOSVkLvnffdNf0GUkhjsHk9QXQ4FmGiTQ1fF19FkF0HnEJGdxRcty?=
 =?us-ascii?Q?2xv31WLMQriLbC/DzlKK9Y4aXtNYvGhCqyOYepiz25DjNB9gvRnlt/gvgm1v?=
 =?us-ascii?Q?VjOUWSHHtJUuOslqkHnBImyBRylu3n2v2u6bEX2dTJg97uVBm4xuHRP3oier?=
 =?us-ascii?Q?wEBnBZeLnq3nN7BJw+9GpUIOdZSXQOCBkp6ZOYCI6u6KOlvOxOZhxd0KlC0J?=
 =?us-ascii?Q?DLNQPZKCSJrUAFbL04AI+8wVozdblAkG0F+AhFJHErXmtGMBY4hx5F018cWS?=
 =?us-ascii?Q?PiE1y5IowMxzmLwyJJ5kplhOsJVCgG/F9dBwKgNUZqrEoE/XwwhMO05Pbfpd?=
 =?us-ascii?Q?dI+ZMi/9bQNcQFA0V3/O/xOBHuydW8J3wAZFmwzB7Xjop5svccCLtyaC4qpv?=
 =?us-ascii?Q?LXZQDsTrk2NKWfU3MX1alZYZ+M64HMS9EvjnLUad0DVb8ZVMXYaUmb6hm0Jd?=
 =?us-ascii?Q?jdloaHHDLcdHJTyMR7Ygb6Imj60rvCaxOb3wTcAUhlnrG/euN6yjcj3ExvOC?=
 =?us-ascii?Q?4PUOCDBfGcEk32FcV9cZrH1khIjESWx+TvQcS464jUEZCocPuNZr7iay3tIQ?=
 =?us-ascii?Q?ZzNwIg3kuhvIXPt4q78ZlOd2FurQRNGllnXy9+SBdqAJ0wDT8SMVjAmgt6zC?=
 =?us-ascii?Q?Y0UDz1zTsacDGIHbs7PUFFP60vkcPCHB58r6oVx0KPFPs1sHSC2DDOSd/d+L?=
 =?us-ascii?Q?+mB25YG7pCde7+Y5IyAzCF50C3qN2rVRtXHl77tz6yDCINzg4Xb6BQXrQ/vR?=
 =?us-ascii?Q?Fb0kWMgxfvda3PbJO0Yxyg+LnCtkfVyWPdVuPKP4+bVOhK4m8PBad2lZiuD/?=
 =?us-ascii?Q?AQs9Pcl9jcQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p6FIib31jcR4puSKeD0fdXwKiDMuF1XY0CR9gYneC9N0j3IUnv2UllXkVDdj?=
 =?us-ascii?Q?63/gziZK5RFs9uWYbY9BP9dPwqV1UZ/af0RsQAoRFIquJyrCJEU5XUnAX5FS?=
 =?us-ascii?Q?7clw+TzoWjyQ28V3HzRzPKqLhEOQGPNHa+unwfXvSKj3rhLNP09REhpKlCVy?=
 =?us-ascii?Q?5WI7dGFhu7qbd95/qqIFvPwwR44WILf06UtaysMNhT3WOIo1zaY4LDyop3MF?=
 =?us-ascii?Q?XwgTOnbD/1wjp2sLTMa7Q/7sBbukjcPNTdsYYEH/E+DMNTdrljHm6diAOBhL?=
 =?us-ascii?Q?O59rEUJK3v6EBHY4Boh1urUWESeTeHI30//pV62YszR08Z7Zp7YvWl5A57o0?=
 =?us-ascii?Q?ynGdsbtcmZUQuNieQQhN1BbbYqJRoeTlbYliyc8sO0xR4Umk9AJb+PMZSvMF?=
 =?us-ascii?Q?ATmxNuV16L3SQOVUCaJ0ErNeoTNOXccGzjTEHt84VumNBWG95tHTST6L84Bc?=
 =?us-ascii?Q?iAvwVzb/D44Xey5iVC2OhLyPBrZ90/PRaHmLTewJBbcjTiauwdXQOE1PqELb?=
 =?us-ascii?Q?Dp0u7LoNAOOVo35PDx83//7mcspyEDuFI0erm4wdjlTIPCNL7s2AAETKtuaw?=
 =?us-ascii?Q?zvMcAagn5rdF08t2F8Kf3Vs7DlxXk16ssT4YQrVa9LLgZOOId7SPFcjDu+mH?=
 =?us-ascii?Q?kStJhoK0K2N1pMlkP67fwTtF47hSVi+AGskpFP3Is/cZdIj6GuZuXK5ylZc9?=
 =?us-ascii?Q?kazXRZUDIPsomCu+4lJoSoiUR3WJUsVAIKBtjVZs/IqaIY5GPitfkEbk1xks?=
 =?us-ascii?Q?NLWRcfoIRdX/aKRIjJnkaWgFBcreDe5IbW65qCxrQciQt3J4e9nvfiAD6XYD?=
 =?us-ascii?Q?GZQJ4S+gSbJQW0uOT/nZDFaWie3jvuto0loO22ECiiC4yraM3AsGTjnhE7ph?=
 =?us-ascii?Q?jjamoZ3f6jgoNrzULLu0SJuvAAr8mus3XMYM6WGIn3adX2lUacgke2lmTP2o?=
 =?us-ascii?Q?YwQLbJRKCBQYMZw50WETWKft7SoiHbdi/5HlHJNDuKuX5iva1wYu1Ts1SsE9?=
 =?us-ascii?Q?NAXx01n4s0RdJEXJSka9JphAx+t4oMqorVl6XUJbosSEC0MEsdwl4Mi+NZSW?=
 =?us-ascii?Q?ljGoEx5DG69Nfq5Y4DUg0gwovkf0fPxGwa0nj1dHHj5X8P6xQNGZh/fivTRJ?=
 =?us-ascii?Q?CbYntECu5KHTlKGK3NpGyiZqFwCVAu6axQpx7Ms8XeBM98ixJS3f1UidikPr?=
 =?us-ascii?Q?6SHajriFlF/W4/IyZPwhBniRF0vtG8a2xoNHxr53I94QBENf1UWjR485IKP3?=
 =?us-ascii?Q?vsMCL2EFd/KevDga75jsh3xN51EnEYOhhsRxiOVFOn4J5pH33n2XDNQWyk9I?=
 =?us-ascii?Q?JOK+wiw+31v12Con7M+0+CMgeOqvMsY5jufkqMsUm6tB58zJ0IoBIQhI/dLZ?=
 =?us-ascii?Q?z3lbgVK7lvpgyUawK7zcWKQdSPd4M0Zfqq7TRS+zIHxIYTVLA0MvZfFuN0dO?=
 =?us-ascii?Q?eSs+BmZaTxhY7Zaszqhf96zySOOKeHFu5WGnUhvgWTIf9V5Sj7OAca6aG22Q?=
 =?us-ascii?Q?grbzWhepxsjUa1EqGUTd+GTft0/vWc9xFAADKyCNIL0a3YTUcdRrHPvIMsbA?=
 =?us-ascii?Q?sEkcfjgBEjMBpynSyWdG1MbgkNAoGvgU+N0LFN0b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f7a667-5391-4fc0-0384-08ddf5e4ccf6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 12:21:59.8263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rql0rGKr5bRjF+7lXyofBBeYKXpCBAOPhErDUBuXCYYIaFw4albekL4BIW67qu9W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8112

On Tue, Sep 16, 2025 at 07:50:16PM -0700, Jason Miu wrote:
> + * kho_order_table
> + * +-------------------------------+--------------------+
> + * | 0 order| 1 order| 2 order ... | HUGETLB_PAGE_ORDER |
> + * ++------------------------------+--------------------+
> + *  |
> + *  |
> + *  v
> + * ++------+
> + * |  Lv6  | kho_page_table
> + * ++------+

I seem to remember suggesting this could be simplified without the
special case 7h level table table for order.

Encode the phys address as:

(order << 51) | (phys >> (PAGE_SHIFT + order))

Then you don't need another table for order, the 64 bits encode
everything consistently. Order can't be > 52 so it is
only 6 bits, meaning the result fits into at most 57 bits.

> + *      63      62:54    53:45    44:36    35:27        26:0
> + * +--------+--------+--------+--------+--------+-----------------+
> + * |  Lv 6  |  Lv 5  |  Lv 4  |  Lv 3  |  Lv 2  |  Lv 1 (bitmap)  |
> + * +--------+--------+--------+--------+--------+-----------------+

This isn't quite right, the 11:0 bits are must be zero and not used to
index anything.

Adjusting to reflect the above math, it would be like this:

 63:60   59:51    50:42    41:33    32:34    23:15       14:0
+-----+--------+--------+--------+--------+--------+-----------------+
| 0   |  Lv 6  |  Lv 5  |  Lv 4  |  Lv 3  |  Lv 2  |  Lv 1 (bitmap)  |
+-----+--------+--------+--------+--------+--------+-----------------+

The order level is just folded into lv 6

> + * For higher order pages, the bit fields for each level shift to the left by
> + * the page order.

This is probably an unncessary complexity. The table levels cost only
64 bytes, it isn't so valuable to eliminate them. So with the above
math it shifts right not left. Level 1 is always the bitmap and it
doesn't move around. I'd label this 0 in the code.

If you also fix the sizes to be 64 bytes and 4096 bytes regardless of
PAGE_SIZE then everything is easy and fixed, while still efficient on
higher PAGE_SIZE architectures.

Fruther, changing the formula to this:

(1 << (63 - PAGE_SHIFT - order)) | (phys >> (PAGE_SHIFT + order))

Will shift the overhead levels to the top of the radix tree and share
them across all orders, higher PAGE_SIZE arches will just get a single
lvl 5 and an unecessary lvl 6 - cost 64 extra bytes who cares.

> +#define BITMAP_TABLE_SHIFT(_order) (PAGE_SHIFT + PAGE_SHIFT + 3 + (_order))
> +#define BITMAP_TABLE_MASK(_order) ((1ULL << BITMAP_TABLE_SHIFT(_order)) - 1)
> +#define PRESERVED_PAGE_OFFSET_SHIFT(_order) (PAGE_SHIFT + (_order))
> +#define PAGE_TABLE_SHIFT_PER_LEVEL (ilog2(PAGE_SIZE / sizeof(unsigned long)))
> +#define PAGE_TABLE_LEVEL_MASK ((1ULL << PAGE_TABLE_SHIFT_PER_LEVEL) - 1)
> +#define PTR_PER_LEVEL (PAGE_SIZE / sizeof(unsigned long))

please use inlines and enums :(

It looks like if you make the above algorithm changes most of the this
code is deleted.

Jason

