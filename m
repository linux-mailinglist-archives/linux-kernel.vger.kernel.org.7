Return-Path: <linux-kernel+bounces-768811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9A4B265BD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CF61CC64F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E7D2FCC1E;
	Thu, 14 Aug 2025 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WljPxQy8"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9762FF166;
	Thu, 14 Aug 2025 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175496; cv=fail; b=kkPVskUj10g4zC4DpgzMpTYPFHde4ulwKmTuTZ7pgdPt1F3oBDIOmsz6tXNm90PPfCbVagcG3KkslJ/a3KpWjNNpT73WmL0PqSjp8rjzblk06T4l+rnqNj7lYSFzOOfaaoHGni/7qMe7wmy7JTE0Y2rmq0uQfkgKhpIwdpkjc2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175496; c=relaxed/simple;
	bh=Qj1Uyi0tGkYaCnmNlDg+ntt1vAkS5s+TDGNEOzLJGEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rSKLyfpaaqbFx/0LwqQpHnwftAzcTaYn0b5g8DW/WOYRfqAMtftop+bNJ3DRBdLLLNPZrHfU67LPbeDze8Wxt+iq458EYk6dcj22dLF2zTAO+azWXW709YCjwt/CTSS9hcBfJ6vSnzAGnC1y8oAFaSqrDVV+SJ5DW4xnq3gxu8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WljPxQy8; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcOS2/zres2nxM41T2hQWbwsLQ9dm/HITdiQxu/r2Ps7HMsHtXJjGiWQMdVQ3Ob9COGgRnuPQu/pMFJCbBo42Fto1nN4EgDvuHTIUavtT9NRbOTNkjhTSSMkaTT0efl/dEa/8ZSvIBsDUNgO6tRl00jM8JEHL7s1dfPVyS5R0JepOQ0Qax77Iu0tJHlLCbTGf3bpPHVWKQeIsNis+XuBpNRFySsoZqDHv6vg/E2s3rEs8cH+5LIErVkPa9AhfbZkWL/cFGPHusiOdnVdlA/f1hADdKEwXmT67WCV+U2uqXPPc0+sk7eqkzz7Vt4NogjJ5xmCg1nuQurdy7vrx3ooNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DT90r3xu+SF+TlQsyr1v1Z9fZmqXQG2CNUIvfqDHvxc=;
 b=ygvBDg/2D2SKo/rj7yySEhzu4g1IA5IhpUz41RVUfDmy+/I/N76eodOvDPVc95AkZ0zA0Nz+VbKpo0mSUCA6GJ4g38U0U+419Ls9wbcCVDMwcnI2zCHbFiX+7gdoNFFKwcyqMJaWkZNUEoX96wnOCUzjJjLS/RmNF6OmUbCluzD23U9wKm9QUA6HzbuyQQPQj8unbW9V8by5ypUitp9OzNjttN6Zcwr8+96nAxDwM29f9Or+kF6ZeskautfJnxWsomDl4u3OH+HHemAJ3S6terA5//8gf0KJgZAgwCE6VZUVFhQbpP9qr032bWvIVWGdHmce4K6xHw0E7JBKVLl+Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DT90r3xu+SF+TlQsyr1v1Z9fZmqXQG2CNUIvfqDHvxc=;
 b=WljPxQy8sBV8urlkA/2CYpJddbQiQ+EKhrYuIw03tsm55ndepj9+A9a1gDDUyxlJQtIFBaibWubI77/+go1K0Q1tbTitsoB/hp5Oh+xIGYizkYipRxwsf57So1++1rwyU+Gg0CEIVxdag0A25TO9DU5AC2EfVYd57377zy/mUQNB6Ue4rM2rYZ2m/7DgpFqokbwocEwaKnDiv1fqC+R2nhIpdZYu0VQtytRsgeO8ayUZ7ZW9OEAjkVi7pWx02KM9CsdHl714Oq/6vGVYszbAKNoVRY1JTYI2Bd30JeB1jXF6wTVTl0xAzinYB7mw/EzMxRKx17nJnXeVowkQPeki2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8332.namprd12.prod.outlook.com (2603:10b6:610:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 12:44:49 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.012; Thu, 14 Aug 2025
 12:44:49 +0000
Date: Thu, 14 Aug 2025 09:44:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 08/16] kmsan: convert kmsan_handle_dma to use physical
 addresses
Message-ID: <20250814124448.GE699432@nvidia.com>
References: <cover.1754292567.git.leon@kernel.org>
 <5b40377b621e49ff4107fa10646c828ccc94e53e.1754292567.git.leon@kernel.org>
 <20250807122115.GH184255@nvidia.com>
 <20250813150718.GB310013@unreal>
 <20250814121316.GC699432@nvidia.com>
 <20250814123506.GD310013@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814123506.GD310013@unreal>
X-ClientProxiedBy: YT4PR01CA0310.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: 335a77dd-a3d5-4004-0862-08dddb305b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IhONcx4t+6LzQCpNs17HUOldF3J6/z41LYdUhZDvfe7L7AAWMvN+Af+BT3Qm?=
 =?us-ascii?Q?agcu2dRQIYhpqv7vURMTj7spx0W8fejuD76ImSxZdromRURIVkIJeGvY7nn/?=
 =?us-ascii?Q?B75ZN183RjQ5qMDevDZAQ0JqT3caBw26BBhVZZNuc++iiMHNu0jRADderWZs?=
 =?us-ascii?Q?r03RPaQ+1DrT2t3U6XiYe8uJDI4DuZWL89wHFtSuVKCPSF5/oYWiGm3MHzAq?=
 =?us-ascii?Q?DkfdyaR7yz4Ao2/DFuhTwKzqbFnhEeBtNlgh/0BfAgi1+OrkX90MZOSzWf8p?=
 =?us-ascii?Q?HKNylEhtkxGBy38H8w+P0akz/iamIeypOgN4lU0dv82bHqV1z4Azpj3HOsE1?=
 =?us-ascii?Q?loGWSWWDUkm6pbu/VwVO3rBuSKWSZjz6ATp3WoBrJofFfUH/V+QFlwbtAOsF?=
 =?us-ascii?Q?3BvL2rNkzCksD9B23dH2ewiUQPZpz5DIuWRK6YoXxam5sALzA3qWrCj4HLP4?=
 =?us-ascii?Q?+9K2/qPffpm72eqiScg/MjavF2Pexh2d2yAmc48CAZFJyN2UhTKiGgvRHK7b?=
 =?us-ascii?Q?dhxuncm7pt3gVvza6ABXVQuvap2+P0UTgpSKSw6tBv9y46aIEAE/cs3BjNCU?=
 =?us-ascii?Q?JFxGSC+Bs2ccFT/jqgKWXTYt76n1UiUlYXg77vF0tOJO/tOgnmAt/zpfKlYn?=
 =?us-ascii?Q?i80Eij0ObzYEJY/jZ0sjTN3RSoAs5zuWNpWrccSWG2Ac4K+fbcuTmKeiB4yV?=
 =?us-ascii?Q?911AE/bkkI7B7NI+t+8qesNO8Mu6vr0deOjFS69kKOaTm1FVDNd9QTbrAGpT?=
 =?us-ascii?Q?DmZbHZdthP0xMJxPVjfx9f1zMjugQN0LfVHmmg8tgnGr9BH2Mg+SvM0MHIYt?=
 =?us-ascii?Q?CdetfLOBnaKnvLJ1+PHDw5cs7+4iGrTaTHsrXlAsXZw817cpZ/4cdUJLttTd?=
 =?us-ascii?Q?HIh12u0jy1JA9S9rHdgcvnrgXAQKSF8qaJXGBNky/Njdk3uZBWaU88xUQjf+?=
 =?us-ascii?Q?+fr7oMmd7SUod+bZ6A4QMlt1C2W7YocBv0g4DuE1AR7yvQCPR8V5xdw4TJXl?=
 =?us-ascii?Q?inPRqX5fh1WRsTGkBvKu6T+RloSJy6vcPzDHgditWSIX5twfvAtz73kzrASg?=
 =?us-ascii?Q?rmcx9/4psrMtQl4ooKEvCyZIwaZ2U1Vf/KfGMM6KQctnCLoBRWTAaFAdyYVV?=
 =?us-ascii?Q?nH46UG9YC6cRD5ZUvKpCf6H2SVDNQlpvkidfpBWcC6pQ+if8USY1ZDE8Zi0M?=
 =?us-ascii?Q?OzwmsydBnufvyFDtIVw5flHeTlYxJAqABARAaa3BVdqFWcp0Cc4xEGEj6Uz1?=
 =?us-ascii?Q?2bDWhv9TegAc+eOk6BXaDX4ckQVQkfpAbfV/tbT/iBpPsEfNr7S4VP3O+GwA?=
 =?us-ascii?Q?8pvctwaJN18AQ1pKEwRnQf/V5N+SFFnM/C01Fg+QrYLD1NyJGnsbYqirVz9U?=
 =?us-ascii?Q?a8OZaM6mS+lDnjtH/WKJ3NgALePJ95rdwfe1AHLYbrpc+iHyj4bdHFcmygos?=
 =?us-ascii?Q?WJDxl6u7UvU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CgybZ76urSHfPkuNEm53VQv/l7tijjsayqvTIE+fUu1Xkf4jRMun4Debqpct?=
 =?us-ascii?Q?LLmfOWCWaK5suutZRHp/pT8m/zAsRCNkHy/iPksOMGdCHNFsJCSuuTr5ubJK?=
 =?us-ascii?Q?XXnXhpF9pHYNaJ97WOD9S3lsklEOB7K9RkragJ5VOCTHfm1O87DI/CHWyamn?=
 =?us-ascii?Q?2rVlJ16x9NoWkgdD96XN9rbwi7/xKv+g5QF9thgUJ86QhK0RlYoz0Dl+F11e?=
 =?us-ascii?Q?Ri9GsemQ/QaQuS1v9q1NGDHy8VS483bN0/SwNuTqnraI0vZsTFov7qUNYHMR?=
 =?us-ascii?Q?0UnNLDxASqkVxcRollviXPjlyPn/lhWhSzQrTG5U3lzCfaJml2mGUaTmDutz?=
 =?us-ascii?Q?fU5xvmEL8E5CCgo6ZJMr4i99e4gHD793fLYVwb0CgTu84SUL8rEwCwLeB3tC?=
 =?us-ascii?Q?8QtV3pON/3Lk+otW+JRZ4VhCIpOfF9jLBb7Flaijnrw2lV86xXEj4evJ6P1p?=
 =?us-ascii?Q?qbStwlUiCPcEM4qSbhBcejFy/nHImHBbF9rKL5mQAMA181DTK/gVLLQcKbhN?=
 =?us-ascii?Q?8kG4T0SkRV9HnXECIwhxzxk5bJisYkzHu2qMhGCHA2SRsrmV8pJ0kHroHXAa?=
 =?us-ascii?Q?xFeRrq3gAf5lOXXK6LV88ZIx6ICmxF7bOa7QI+6785lS99ynke86nFkmwszn?=
 =?us-ascii?Q?KgzvSl0u6JT+TW8/bghptYwcsgL0ecydf3+r7fCqVmidmPxwkpRhCDtwh4KV?=
 =?us-ascii?Q?p1IEoYeXrpQRKMVzF27BB7OMDtVZd65Fx/fLf+A+YJSx2kYAX3+velAeZJBh?=
 =?us-ascii?Q?GJdNfrMByLaKcfE08eNvDWjHnPsyhf/ziyUytQEhhS4qj6FS3+jJBpp5fvEX?=
 =?us-ascii?Q?SKW2lNxbzWTdUJ9v9XB9GEHCssJR6PaT6Nbfv3H3OFBPFKex5LZW4smQCTvN?=
 =?us-ascii?Q?pZqmS1BSP3rj5JtYRWFpwJLk7y8hL27Tsm7dSv+G8urYbspQNNJzf3S8k9wL?=
 =?us-ascii?Q?XwlQxPfEoUA1wLUDwX5TlP+/i8eQGHvI46kY0qTY/YWM9To4HH1lRymFunyx?=
 =?us-ascii?Q?KslNOgmZdZIWXOGi6P9EMKRah5e9ZHbagPqkuKgRs0z/nb8Nv7t39pzcNQSS?=
 =?us-ascii?Q?DNG4D5X7SQOY/XFNuWqEKIqbUiJhwTrjR/w9dc/8zNeMMJ/QVGk1MdTPOLUV?=
 =?us-ascii?Q?fkBTwurAOCF4eh2ejourrH89nOAaNU+sAizBuD+o9CccXwEbp9YGfxmubQpD?=
 =?us-ascii?Q?3ImYPqlh6QTcSo4VnlAvqDgBg+9s0n6mUQlp2QGwpi/IfS2Xd57bNvkffy7Y?=
 =?us-ascii?Q?oljThomEhgCiBOGdG89WWo4lMmpB9fPKpjO13U1NoSHsHz/BxDcKGnJw85ll?=
 =?us-ascii?Q?Fwi3BTDmfXK9XqqDlNYA/mKvw8DZAQbQ6Y9D+kQDd53R8vE19xrYUkfWnsHB?=
 =?us-ascii?Q?hJ+H3VbWeRJWQ2azBU23pEdicndshS+r60kwKBfoo2oGsDRlKvaPEvZPOpez?=
 =?us-ascii?Q?+bbj1BhfhKAeoY5wdb+LhD8R5kxA8DTMxMybEhM6zkKSmhBTUeY7rAsdMh7u?=
 =?us-ascii?Q?O+cWsaCRN1aL41I3LcIKST7HdfIHWxgBC0eqpWnMOll53n+Z3gmVrYeVj23v?=
 =?us-ascii?Q?LPPTFf97Prpj7lcopjE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335a77dd-a3d5-4004-0862-08dddb305b7e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 12:44:49.7801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xm66W7cAWmPEyimxT0zQRYAvPOIAYlJTwok9sFU6HfDYZ+5LrObHHojxvLOWdeJO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8332

On Thu, Aug 14, 2025 at 03:35:06PM +0300, Leon Romanovsky wrote:
> > Then check attrs here, not pfn_valid.
> 
> attrs are not available in kmsan_handle_dma(). I can add it if you prefer.

That makes more sense to the overall design. The comments I gave
before were driving at a promise to never try to touch a struct page
for ATTR_MMIO and think this should be comphrensive to never touching
a struct page even if pfnvalid.

> > > So let's keep this patch as is.
> > 
> > Still need to fix the remarks you clipped, do not check PageHighMem
> > just call kmap_local_pfn(). All thie PageHighMem stuff is new to this
> > patch and should not be here, it is the wrong way to use highmem.
> 
> Sure, thanks

I am wondering if there is some reason it was written like this in the
first place. Maybe we can't even do kmap here.. So perhaps if there is
not a strong reason to change it just continue to check pagehighmem
and fail.

if (!(attrs & ATTR_MMIO) && PageHighMem(phys_to_page(phys)))
   return;

Jason

