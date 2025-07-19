Return-Path: <linux-kernel+bounces-737975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C00B0B2C3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 01:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E18E189B8B5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 23:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E03528ECE3;
	Sat, 19 Jul 2025 23:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="poNM6QFg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB947AD5E
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752967772; cv=none; b=L1kBIrVWiXpkt97QU5xUg84mnGhAwt/OPSreSPcRSGq4UEszeotWYP129yi5a3bgI3M1KjXhjH7QRQzj/4iDe4wZdvpSfQubCLTgzx2ZEIEBKJ8ms92pT8ufeAnbcMrqTWbbT6NJBvKBkUuM5KZ3uDO7lrtYD9ytQeO/IzbK9zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752967772; c=relaxed/simple;
	bh=hO/LlCoAUKXD6PorVjL5Z6Ylzx67dEoCrcnsSsTRAKg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ffZyvAfptpFni7TKfuzMm99p/y+bSGBpi1t+Ic4JEdDihxxmDUtuv4VgWMtHYW6g+rrC0pGRmaFvx01Tcc9te689I6RHgItTGk7mzoNB4FLwSF9mCwdhyEtlkBUQy0+f5ZdDxww/VZaRq76sNvN8pwHQWovmlHZhAsHnh0RdwcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=poNM6QFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F61C4CEE3;
	Sat, 19 Jul 2025 23:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752967771;
	bh=hO/LlCoAUKXD6PorVjL5Z6Ylzx67dEoCrcnsSsTRAKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=poNM6QFgW90cchwicbL3fDoe398n62/HCqHbiQfu1o2t8cd5MinUsZMkvl3FpE3jn
	 JEi5V0f0dHukg0x6m79HGSpPcuJm4PLYW2+57Jt/58Sg/5EAUl79q1TaBeW562xAzL
	 nen2+WsRLRR5S4ZjiDrfSeb9NOYsZW67heU+7TI8=
Date: Sat, 19 Jul 2025 16:29:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dev Jain <dev.jain@arm.com>
Cc: david@redhat.com, catalin.marinas@arm.com, will@kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, suzuki.poulose@arm.com, steven.price@arm.com,
 gshan@redhat.com, linux-arm-kernel@lists.infradead.org,
 yang@os.amperecomputing.com, ryan.roberts@arm.com,
 anshuman.khandual@arm.com
Subject: Re: [PATCH v4] arm64: Enable permission change on arm64 kernel
 block mappings
Message-Id: <20250719162930.f5ad0d97c880e9e1f569f9e7@linux-foundation.org>
In-Reply-To: <6e51f756-786f-4f15-a50a-73a482cc73a2@arm.com>
References: <20250703151441.60325-1-dev.jain@arm.com>
	<6e51f756-786f-4f15-a50a-73a482cc73a2@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Jul 2025 19:22:20 +0530 Dev Jain <dev.jain@arm.com> wrote:

> Gentle ping
> 
> On 03/07/25 8:44 pm, Dev Jain wrote:
> > This patch paves the path to enable huge mappings in vmalloc space and
> > linear map space by default on arm64. For this we must ensure that we can
> > handle any permission games on the kernel (init_mm) pagetable. Currently,
> > __change_memory_common() uses apply_to_page_range() which does not support
> > changing permissions for block mappings. We attempt to move away from this
> > by using the pagewalk API, similar to what riscv does right now; however,
> > it is the responsibility of the caller to ensure that we do not pass a
> > range overlapping a partial block mapping or cont mapping; in such a case,
> > the system must be able to support range splitting.
> >
>
> ...
>
> >   arch/arm64/mm/pageattr.c | 155 +++++++++++++++++++++++++++++++--------
> >   include/linux/pagewalk.h |   3 +
> >   mm/pagewalk.c            |  24 ++++++
> >   3 files changed, 150 insertions(+), 32 deletions(-)

I'm assuming this is an arm patch - the pagewalk.c bits are simple.

However, I have nits!

> > --- a/mm/pagewalk.c
> > +++ b/mm/pagewalk.c
> > @@ -633,6 +633,30 @@ int walk_kernel_page_table_range(unsigned long start, unsigned long end,
> >   	return walk_pgd_range(start, end, &walk);
> >   }
> >   
> > +/*
> > + * Use this function to walk the kernel page tables locklessly. It should be
> > + * guaranteed that the caller has exclusive access over the range they are
> > + * operating on - that there should be no concurrent access, for example,
> > + * changing permissions for vmalloc objects.
> > + */

All the other function documenation in there is in kerneldoc form.

> > +int walk_kernel_page_table_range_lockless(unsigned long start, unsigned long end,
> > +		const struct mm_walk_ops *ops, void *private)
> > +{
> > +	struct mm_walk walk = {
> > +		.ops		= ops,
> > +		.mm		= &init_mm,
> > +		.private	= private,
> > +		.no_vma		= true
> > +	};
> > +
> > +	if (start >= end)
> > +		return -EINVAL;
> > +	if (!check_ops_valid(ops))
> > +		return -EINVAL;
> > +
> > +	return walk_pgd_range(start, end, &walk);
> > +}
> > +

If we were being stingy with the bytes we could wrap this in some
`#ifdef CONFIG_ARM' thing,

This is awfully similar to walk_page_range_novma().  We could combine
them in some fashion but the results would be a bit messy.

