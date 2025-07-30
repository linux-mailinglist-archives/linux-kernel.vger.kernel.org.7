Return-Path: <linux-kernel+bounces-750917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E22B162C6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A301AA3040
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5972D2D9EE5;
	Wed, 30 Jul 2025 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PG57ZssR"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F802D97B6
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885704; cv=none; b=hR96LQVyDtuxWiAC7thIFzrmzan4Tnd19u8qgbBGAl5kvUkprczeiGLXSP9vWEVncpwUG6Y49/NxKSs+5yZ87pDiYia17yxZi73IRguuEiQ0Jk+1wTC66QLpg241T3GPQNGwfgQ1Y0Y+0DKJqMDEkgJuP+ZAaApCZiSPqgTqFtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885704; c=relaxed/simple;
	bh=TDW5x6DvBZ7lvIDcVVcAKcADPgkzeitjKa0U8rd1OM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9G8FylD5Bi9JgHKT87/PJbYELDnkxrUSE/mOsI7YzQcXfWqX6N99Klzieop89y4FnpphjdRNcDnl6VdEYYAsWOwBS+tGQ3WwBlzpo94sc7G9YxkpJHsDu+onK391d7OgsGQNU5hOxayjY7E2WZwjCpPbZw06dCKgespwTf1FWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PG57ZssR; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ab63f8fb91so50492111cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753885701; x=1754490501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yXicpotvi3lyQ9AOXQWfwG3KeaAtrSGGP0WC4PeRJ0I=;
        b=PG57ZssR8cQUccAuRytaUgKSAEssylQd59XzzV+sbjSosfPEHBBIphfgg4DDmUSzwE
         cDmBxMCwHXpxtbQv0v1Bb8VZkWFtNsJ6JGZLN1ICU6sGIB7QT9LJ9w36BzEYIdf9pwkT
         o6yRnqFRNEHszBOT+xrqmrhp9nGd9MhLgfwHruD011EZ1ET4yCG96SUfdO9+sv22+vep
         j1UksT9oW+qK1zTtYXgmqybKRAtncfx5QyGwdi63fFGXSCV/QO2aY8e99M32XUDlQjxE
         PwD3cXkAnkkE79Re9LXHLn0dkXZ50LxSZRjpXriQMSKCIGbgN205FfGtcihMg02Osw4J
         19og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753885701; x=1754490501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXicpotvi3lyQ9AOXQWfwG3KeaAtrSGGP0WC4PeRJ0I=;
        b=nH1rsttaBqY6VbU9ulf8wQ9/BhmKbkXsLqozvIfH4trXmVNvwBQsToWoHrrhRleTvf
         1tIUFAmNqyuvlemUxKxQ+HNquPWla+pAl5DTJAd0b3VuJLQEmjxWTwldAP7IEw2Nmlar
         v8D818tmb1LOMN31yIRorG1hyRSrbiioFRlBnSyOsffEdap08+xShVnQbjhPSyfcsvV7
         Fat4FbDaL68QVkQlJmySt91hsG2xweIO89GZzGV6eDhUZ3uGSVENfei8vbU4LsT7J7vO
         I1Hjo5Me5XvdgWR9EaIKuwBdf9tb+0Zs1QVZSRnMo2mSaQYAHJehwKnDz4IB6k1tADBy
         Ftlw==
X-Forwarded-Encrypted: i=1; AJvYcCXGhypDUxWcnloqrSiJHq36tXSKefqz+9Ij3bjJ04xXJKX2VlZTs5dvqr9o+LqLWVcMtMKl1wvmWCiRnlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTf1cQjbHi+WiIYgQi5QUb5bBAFgwl4exZJjs+kOzHEXm0FKss
	Ga/JGkFjjL0nvxoD3c1QofV/pczuCuycM7r+hUgoIveuhCvEJ7fWNt2RNCSDpIi4QEE=
X-Gm-Gg: ASbGncsiCMAxWlpZPwzKBEZwgfETx0C/f2kmgWrwb7CjQqn0RlIt8M/+JCV92l5H3SZ
	EqO43rPolyNw5/SB/yDlMOLEhtYwwt0O/2NUPDM/igA9ZPNIXuESlOWKdHIM18XJFlOxKztVn+U
	DCvExqhgrl+OyWX5HNNIkWKKDOoLQyIrPPqZQG5CBqrrMTJS6d/Plr5ckxDwMr0jUl8YV9XvMfZ
	NoWd6H5DdaDEGkATbWdTRhHK9K1Ew4Kw1oQfHMOQ5dri9ZFwG/32L6bXr7rEa8jXCjCMIHCHlBs
	WUcyDVbdE+B7dBd3tYoFQvNDeaXJtEGgx5TDJ7YGVty0o99o8xL1ZtIQIwJq1g9/fmiJUYlv9pt
	yBgui2UpODI9NHxcwY7XW6bBpTKuMGuO6l4b6+DNPyORLha5kwKd29JSuIkhBcuQspprW
X-Google-Smtp-Source: AGHT+IHCzPfwaMM+aIDs6tu6c39/KdwhCla3PbAO01xs1vOnpsn8EpRRsdfpw4N6uvD5MCuSC49wxQ==
X-Received: by 2002:a05:622a:48:b0:4a9:cff3:68a2 with SMTP id d75a77b69052e-4aedbc3c0dbmr55369321cf.37.1753885700213;
        Wed, 30 Jul 2025 07:28:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae9963b6f9sm67178931cf.35.2025.07.30.07.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 07:28:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uh7n0-00000000RbZ-432A;
	Wed, 30 Jul 2025 11:28:18 -0300
Date: Wed, 30 Jul 2025 11:28:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, iommu@lists.linux.dev,
	virtualization@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/8] dma-mapping: migrate to physical address-based API
Message-ID: <20250730142818.GL26511@ziepe.ca>
References: <CGME20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf@eucas1p2.samsung.com>
 <cover.1750854543.git.leon@kernel.org>
 <35df6f2a-0010-41fe-b490-f52693fe4778@samsung.com>
 <20250627170213.GL17401@unreal>
 <20250630133839.GA26981@lst.de>
 <69b177dc-c149-40d3-bbde-3f6bad0efd0e@samsung.com>
 <f912c446-1ae9-4390-9c11-00dce7bf0fd3@arm.com>
 <20250730134026.GQ402218@unreal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730134026.GQ402218@unreal>

On Wed, Jul 30, 2025 at 04:40:26PM +0300, Leon Romanovsky wrote:

> > The natural working unit for whatever replaces dma_map_page() will be
> > whatever the replacement for alloc_pages() returns, and the replacement for
> > kmap_atomic() operates on. Until that exists (and I simply cannot believe it
> > would be an unadorned physical address) there cannot be any
> > *meaningful*

alloc_pages becomes legacy.

There will be some new API 'memdesc alloc'. If I understand Matthew's
plan properly - here is a sketch of changing iommu-pages:

--- a/drivers/iommu/iommu-pages.c
+++ b/drivers/iommu/iommu-pages.c
@@ -36,9 +36,10 @@ static_assert(sizeof(struct ioptdesc) <= sizeof(struct page));
  */
 void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size)
 {
+       struct ioptdesc *desc;
        unsigned long pgcnt;
-       struct folio *folio;
        unsigned int order;
+       void *addr;
 
        /* This uses page_address() on the memory. */
        if (WARN_ON(gfp & __GFP_HIGHMEM))
@@ -56,8 +57,8 @@ void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size)
        if (nid == NUMA_NO_NODE)
                nid = numa_mem_id();
 
-       folio = __folio_alloc_node(gfp | __GFP_ZERO, order, nid);
-       if (unlikely(!folio))
+       addr = memdesc_alloc_pages(&desc, gfp | __GFP_ZERO, order, nid);
+       if (unlikely(!addr))
                return NULL;
 
        /*
@@ -73,7 +74,7 @@ void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size)
        mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, pgcnt);
        lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, pgcnt);
 
-       return folio_address(folio);
+       return addr;
 }

Where the memdesc_alloc_pages() will kmalloc a 'struct ioptdesc' and
some other change so that virt_to_ioptdesc() indirects through a new
memdesc. See here:

https://kernelnewbies.org/MatthewWilcox/Memdescs

We don't end up with some kind of catch-all struct to mean 'cachable
CPU memory' anymore because every user gets their own unique "struct
XXXdesc". So the thinking has been that the phys_addr_t is the best
option. I guess the alternative would be the memdesc as a handle, but
I'm not sure that is such a good idea. 

People still express a desire to be able to do IO to cachable memory
that has a KVA through phys_to_virt but no memdesc/page allocation. I
don't know if this will happen but it doesn't seem like a good idea to
make it impossible by forcing memdesc types into low level APIs that
don't use them.

Also, the bio/scatterlist code between pin_user_pages() and DMA
mapping is consolidating physical contiguity. This runs faster if you
don't have to to page_to_phys() because everything is already
phys_addr_t.

> > progress made towards removing the struct page dependency from the DMA API.
> > If there is also a goal to kill off highmem before then, then logically we
> > should just wait for that to land, then revert back to dma_map_single()
> > being the first-class interface, and dma_map_page() can turn into a trivial
> > page_to_virt() wrapper for the long tail of caller conversions.

As I said there are many many projects related here and we can
meaningfully make progress in parts. It is not functionally harmful to
do the phys to page conversion before calling the legacy
dma_ops/SWIOTLB etc. This avoids creating patch dependencies with
highmem removal and other projects.

So long as the legacy things (highmem, dma_ops, etc) continue to work
I think it is OK to accept some obfuscation to allow the modern things
to work better. The majority flow - no highmem, no dma ops, no
swiotlb, does not require struct page. Having to do

  PTE -> phys -> page -> phys -> DMA

Does have a cost.

> The most reasonable way to prevent DMA_ATTR_SKIP_CPU_SYNC leakage is to
> introduce new DMA attribute (let's call it DMA_ATTR_MMIO for now) and
> pass it to both dma_map_phys() and dma_iova_link(). This flag will
> indicate that p2p type is PCI_P2PDMA_MAP_THRU_HOST_BRIDGE and call to
> right callbacks which will set IOMMU_MMIO flag and skip CPU sync,

So the idea is if the memory is non-cachable, no-KVA you'd call
dma_iova_link(phys_addr, DMA_ATTR_MMIO) and dma_map_phys(phys_addr,
DMA_ATTR_MMIO) ?

And then internally the dma_ops and dma_iommu would use the existing
map_page/map_resource variations based on the flag, thus ensuring that
MMIO is never kmap'd or cache flushed?

dma_map_resource is really then just
dma_map_phys(phys_addr, DMA_ATTR_MMIO)?

I like this, I think it well addresses the concerns.

Jason

