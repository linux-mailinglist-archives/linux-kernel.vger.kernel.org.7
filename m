Return-Path: <linux-kernel+bounces-752404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5138B17528
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6393BBF04
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD1D24BC09;
	Thu, 31 Jul 2025 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R29G5Yt0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2421E241662
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980207; cv=none; b=jJgdDTePBpPDr1dB8b2yVHXmpZCp+UfUmPqoyTTzUvoT9H6CXYsvvS0pnmRUPo3O3NIiJpXzRZxfzmrlGq1W6xP6gP3i3DZB/V/NjAgZ+RJvBgfrTSduX+vfpe3gYh+7R/dhQgT+8iXWZWjmwgI2weclM9IABJGFZ+m5kRiOsUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980207; c=relaxed/simple;
	bh=8Jzo9B7rarBf0z4ymivEctvIbRt086rr/yY3XaKFfV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PqcW1np/6qlaRS38wS6rkxKJw1AmMQsL+wrbLd82lGUR1B67fL02UX5p5ZVVXE9rH9yzsHYhJZ+dYXmp0nNeM/tkTINHL0guNgPbOT5hsLWOebgpuhlMNvrkTESRLml4pf3rhAnqD1+kB1BENEACCXo5SKEnMz78b/gV9MTkJSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R29G5Yt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7794EC4CEF6;
	Thu, 31 Jul 2025 16:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753980206;
	bh=8Jzo9B7rarBf0z4ymivEctvIbRt086rr/yY3XaKFfV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R29G5Yt0xrgV3h51gy0LEn9281Zm5Xaof/tAnhNBQGOuTZHrx+uTA//yPXXoEqxFA
	 DvwHSDT1eBMR//v7vip89SLwkCPGpCpA5cH90eLJFym28+V6+CsDtCKgtIjLY4HSm3
	 yakI0O8YhU4nLnuI+FHkOJnnToHxx097YfUWDRo1YXuCI0lfezkr0VmoY1/mc3D6Ka
	 Ymes0jW0XmwYoJf4a+IV1fRRniB5R1P+moxHdZiHVczksBS2RhM+e6BWoGloHfwj7j
	 Q6DZDgAj0SIoKfYvG4ySnNRBMaHXZWx4gl3Dlad3XbfSdil/RhXN0B6KIzO5SR8ux6
	 /p4v18n1q4+Gw==
From: SeongJae Park <sj@kernel.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Takero Funaki <flintglass@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/zswap: store compression failed page as-is
Date: Thu, 31 Jul 2025 09:43:23 -0700
Message-Id: <20250731164323.15107-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAKEwX=NC65XCkmX1YzivEJtPc+sEJ3pLHUsYhF60QJnk_OtpVw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Nhat,

On Wed, 30 Jul 2025 17:21:44 -0700 Nhat Pham <nphamcs@gmail.com> wrote:

> On Wed, Jul 30, 2025 at 4:41 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > When zswap writeback is enabled and it fails compressing a given page,
> > zswap lets the page be swapped out to the backing swap device.  This
> > behavior breaks the zswap's writeback LRU order, and hence users can
> > experience unexpected latency spikes.
> >
> > Keep the LRU order by storing the original content in zswap as-is.  The
> > original content is saved in a dynamically allocated page size buffer,
> > and the pointer to the buffer is kept in zswap_entry, on the space for
> > zswap_entry->pool.  Whether the space is used for the original content
> > or zpool is identified by 'zswap_entry->length == PAGE_SIZE'.
[...]
> > ---
> >  mm/zswap.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 65 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 7e02c760955f..e021865696c6 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
[...]
> > +/*
> > + * If the compression is failed, try saving the content as is without
> > + * compression, to keep the LRU order.  This can increase memory overhead from
> > + * metadata, but in common zswap use cases where there are sufficient amount of
> > + * compressible pages, the overhead should be not ciritical, and can be
> > + * mitigated by the writeback.  Also, the decompression overhead is optimized.
> > + *
> > + * When the writeback is disabled, however, the additional overhead could be
> > + * problematic.  For the case, just return the failure.  swap_writeout() will
> > + * put the page back to the active LRU list in the case.
> > + */
> > +static int zswap_handle_compression_failure(int comp_ret, struct page *page,
> > +               struct zswap_entry *entry)
> > +{
> > +       if (!zswap_save_incompressible_pages)
> > +               return comp_ret;
> > +       if (!mem_cgroup_zswap_writeback_enabled(
> > +                               folio_memcg(page_folio(page))))
> > +               return comp_ret;
> > +
> > +       entry->orig_data = kmalloc_node(PAGE_SIZE, GFP_NOWAIT | __GFP_NORETRY |
> > +                       __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
> 
> Hmm, seems like this new buffer is not migratable (for compaction etc.?)
> 
> My understanding is that zsmalloc's allocated memory can be migrated
> (which is why zswap only works with a handle - it's a layer of
> indirection that gives zsmalloc the ability to move memory around).
> 
> Besides, why should we re-invent the wheel when zsmalloc already
> handles page-sized objects? :)

Makes sense, I will use zpool in the next version.

I actually saw both you and Takero did so in your versions, but I didn't
realize the migration benefit of the approach.  Thank you for enlightening me,
now I think this migration benefit is important, and I will make the next
version to provide the migratability reusing zpool.

> 
> > +       if (!entry->orig_data)
> > +               return -ENOMEM;
> > +       memcpy_from_page(entry->orig_data, page, 0, PAGE_SIZE);
> > +       entry->length = PAGE_SIZE;
> > +       atomic_long_inc(&zswap_stored_uncompressed_pages);
> > +       return 0;
> > +}
> > +
> >  static bool zswap_compress(struct page *page, struct zswap_entry *entry,
> >                            struct zswap_pool *pool)
> >  {
> > @@ -976,8 +1023,11 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
> >          */
> >         comp_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
> >         dlen = acomp_ctx->req->dlen;
> > -       if (comp_ret)
> > +       if (comp_ret) {
> > +               comp_ret = zswap_handle_compression_failure(comp_ret, page,
> > +                               entry);
> >                 goto unlock;
> > +       }
> >
> >         zpool = pool->zpool;
> >         gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE;
> > @@ -1009,6 +1059,11 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
> >         int decomp_ret, dlen;
> >         u8 *src, *obj;
> >
> > +       if (entry->length == PAGE_SIZE) {
> > +               memcpy_to_folio(folio, 0, entry->orig_data, entry->length);
> > +               return true;
> > +       }
> 
> This might not be safe.
> 
> It's conceivable that in zswap_compress(), some compression algorithm
> "successfully" compresses a page to the same size (comp_ret == 0). We
> hand that to zsmalloc, which happily stores the page.
> 
> When we "decompress" the page again, we will attempt to
> memcpy_to_folio from a bogus address (the handle from zsmalloc).

Makes sense, thank you for catching this.

> 
> So, in zswap_compress, you have to treat both comp_ret == 0 and dlen
> == PAGE_SIZE as "compression failure".

I saw your reply saying you were meaning both comp_ret != 0 and dlen ==
PAGE_SIZE, and yes, this makes sense.  I will do so in the next version.


Thanks,
SJ

[...]

