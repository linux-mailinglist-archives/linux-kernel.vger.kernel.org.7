Return-Path: <linux-kernel+bounces-759596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 675A3B1DFDE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4F218868BE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEE326AA88;
	Thu,  7 Aug 2025 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sv2aohvv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906A72EAE5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 23:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754610871; cv=none; b=osHnKsVrHTlGna/w8hA0jMNN9U8T2iyhRvF33CqTJwvaSh2DQDbR09+zUmPnL2wJzwai3qBWD82/e/hQK80GC77JdCGzHEZUxaS7E5lTM6mddp4B0jBNMIUDRqxs62SikgH4phG8G+geqsAAI+74Ga4CP8lDm3FYswFr4Xp35Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754610871; c=relaxed/simple;
	bh=vEYB2B88OUYFZ5LJS94X33b1uoKVdexcX7humGXPCHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5aJ2BKdr6mdRLf3elq5mIiDHaXJXa0d2t10fKOXKYPxzvoizGJ1p5bxviQpmkXUXI175o3z6409xKUw5jtbdzAvcQ8XgOrRXwKSzrUU4Ne8hiogaz08AVaiYYw9mC9ZQh4W1ae0M/je/nkoKsPtBLScaaBJ3498ZkPHSkCNVSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sv2aohvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28D8C4CEEB;
	Thu,  7 Aug 2025 23:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754610871;
	bh=vEYB2B88OUYFZ5LJS94X33b1uoKVdexcX7humGXPCHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sv2aohvvZW0xLewCgqt06zb9IoeAT+DQJcnmMDk786BqmJTklbJgsXvZ+/cqpsNkd
	 XpCelYCWtt0JX1PPLRRmTs10zZ0ouua/199VULrZHsOrGItZNNpDthibBzCIzxHgsu
	 e4NqEzn6t3aO9fYnJe+QH4bjNIA67rI785ZMPFHGEVEiArWlNLdiM9ytZ6aWMAZC0e
	 mAm+uWxpOD0OdwOMJtKki2q+AIOMc8lSroIu8MpS+E51GFZqRnsNgnVx0w6Plu2wbG
	 93PiAmEZGPGJADVeosEwk6PZ0ZR0+I/JfiZOFT/shobVXEX21H2JmJtnbhL7IAOdna
	 Fnz4gS835X+Zw==
From: SeongJae Park <sj@kernel.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>
Subject: Re: [PATCH] mm/zswap: store <PAGE_SIZE compression failed page as-is
Date: Thu,  7 Aug 2025 16:54:27 -0700
Message-Id: <20250807235427.4743-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAKEwX=Nm08xZVR0Zk2fOvXBmeWe5wggvTXN6+hD84S7T9L=eBQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 7 Aug 2025 16:03:54 -0700 Nhat Pham <nphamcs@gmail.com> wrote:

> On Thu, Aug 7, 2025 at 11:16 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > When zswap writeback is enabled and it fails compressing a given page,
> > the page is swapped out to the backing swap device.  This behavior
> > breaks the zswap's writeback LRU order, and hence users can experience
> > unexpected latency spikes.  If the page is compressed without failure,
> > but results in a size of PAGE_SIZE, the LRU order is kept, but the
> > decompression overhead for loading the page back on the later access is
> > unnecessary.
> 
> Maybe add the writeback disabled story - we added to get around this
> latency issue, but that solution was not satisfactory either: wasting
> cpu cycles retrying incompressible pages, especially when we're under
> reclaim/memory pressure, and we've reclaimed most if not all other
> sources.
> 
> This problem was pointed out by Yosry:
> 
> https://lore.kernel.org/all/CAJD7tkZXS-UJVAFfvxJ0nNgTzWBiqepPYA4hEozi01_qktkitg@mail.gmail.com/

Thank you for sharing the detailed context, I will add this history with the
link to the last paragraph of this section, or the 'Related Works' section.

> 
> >
> > Keep the LRU order and optimize unnecessary decompression overheads in
> > those cases, by storing the original content as-is in zpool.  The length
> > field of zswap_entry will be set appropriately, as PAGE_SIZE,  Hence
> > whether it is saved as-is or not (whether decompression is unnecessary)
> > is identified by 'zswap_entry->length = PAGE_SIZE'.
> >
> > Because the uncompressed data is saved in zpool, same to the compressed
> > ones, this introduces no change in terms of memory management including
> > movability and migratability of involved pages.
> >
> > This change is also not increasing per zswap entry metadata overhead.
> > But as the number of incompressible pages increases, total zswap
> > metadata overhead is proportionally increased.  The overhead should not
> > be problematic in usual cases, since the zswap metadata for single zswap
> > entry is much smaller than PAGE_SIZE, and in common zswap use cases
> > there should be a sufficient amount of compressible pages.  Also it can
> > be mitigated by the zswap writeback.
> >
> > When the writeback is disabled, the additional overhead could be
> > problematic.  For the case, keep the current behavior that just returns
> > the failure and let swap_writeout() put the page back to the active LRU
> > list in the case.  It is known to be suboptimal when the incompressible
> > pages are cold, since the incompressible pages will continuously be
> > tried to be zswapped out, and burn CPU cycles for compression attempts
> > that will anyway fails.  One imaginable solution for the problem is
> > reusing the swapped-out page and its struct page to store in the zswap
> > pool.  But that's out of the scope of this patch.
> >
> > Tests
> > -----
[...]
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -976,8 +976,25 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
> >          */
> >         comp_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
> >         dlen = acomp_ctx->req->dlen;
> > -       if (comp_ret)
> > -               goto unlock;
> > +
> > +       /*
> > +        * If a page cannot be compressed into a size smaller than PAGE_SIZE,
> > +        * save the content as is without a compression, to keep the LRU order
> > +        * of writebacks.  If writeback is disabled, reject the page since it
> > +        * only adds metadata overhead.  swap_writeout() will put the page back
> > +        * to the active LRU list in the case.
> > +        */
> > +       if (comp_ret || dlen >= PAGE_SIZE) {
> > +               if (mem_cgroup_zswap_writeback_enabled(
> > +                                       folio_memcg(page_folio(page)))) {
> > +                       comp_ret = 0;
> > +                       dlen = PAGE_SIZE;
> > +                       memcpy_from_page(dst, page, 0, dlen);
> 
> I wonder if we can save one memcpy here. Would it be safe to map the page:
> 
> dst = kmap_local_page(page);

Sounds good, I will do so in the next version.

> 
> then, after we're done with storing (i.e after zpool_obj_write()), do:
> 
> if (dlen = PAGE_SIZE)
>     kunmap(dst);
> 
> (don't forget to unmap the page in the failure paths too!)

Sure, I think the 'unlock' label would be appropriate part to add the unmap
code.  I also got your correction of s/kunmap/kunmap_local() in the reply.  I
will not miss that on the next version.

> 
> > +               } else {
> > +                       comp_ret = comp_ret ? : -EINVAL;
> 
> Does this keep the value of comp_ret if comp_ret != 0 lol.

Yes.

> Syntax
> looks weird to me.

I agree it could look weird.  I prefer keeping the code in a way more familiar
to ones who will keep maintain the file.  So I will modify this as below, in
the next version.

    comp_ret ? comp_ret : -EINVAL

> 
> > +                       goto unlock;
> > +               }
> > +       }
> 
> Also, can we fix the counter value?
> 
> I assume we want:
> 
> else if (comp_ret || dlen = PAGE_SIZE)
>      zswap_reject_compress_fail++;
> 
> or something like that.

I'm not very clearly getting your point.

I was thinking we should increase the counter if we "reject" the page (does not
save the content in the zpool) due to failing at compressing the page's content
into a size smaller than PAGE_SIZE.  This patch implements the behavior.

Am I missing a mis-implementation of the behavior in this patch, or the
behavior is not what you think it should be?  More elaboration of your point
would be helpful for me.

> 
> And what happened to the incompressible page stored counter? :)

I don't get what counter you are asking about.  Could you please elaborate?

> 
> 
> >
> >         zpool = pool->zpool;
> >         gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE;
> > @@ -1012,6 +1029,14 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
> >         acomp_ctx = acomp_ctx_get_cpu_lock(entry->pool);
> >         obj = zpool_obj_read_begin(zpool, entry->handle, acomp_ctx->buffer);
> >
> > +       /* zswap entries of PAGE_SIZE are not compressed. */
> of length?

Thank you for this nice suggestion, I will change the comment so, in the next
version.

> 
> 
> > +       if (entry->length = PAGE_SIZE) {
> > +               memcpy_to_folio(folio, 0, obj, entry->length);
> > +               zpool_obj_read_end(zpool, entry->handle, obj);
> > +               acomp_ctx_put_unlock(acomp_ctx);
> > +               return true;
> > +       }
> > +
> >         /*
> >          * zpool_obj_read_begin() might return a kmap address of highmem when
> >          * acomp_ctx->buffer is not used.  However, sg_init_one() does not
> >
> > base-commit: 2ec534125ae474292175ae198483c545eac2161d
> > --
> > 2.39.5
> 

Thank you for your nice review and comments :)


Thanks,
SJ

