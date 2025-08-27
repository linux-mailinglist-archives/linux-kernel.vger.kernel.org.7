Return-Path: <linux-kernel+bounces-788634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7721B387A2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624103AC67D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB79421579F;
	Wed, 27 Aug 2025 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmDWPNTe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7F214AD0D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756311515; cv=none; b=c0++C11baZZZDFhiAEGG2z4XKmcvu2dCiY2qavAGPTvGBunf+tA2FukSOZKjcwkWSg/Q63QwqPTm8eBVfRzOFxgkGSfBq2LaMgtdP9gbmF6CxWfR6rasJo+8rJNCRnyM9oZOfemOZXPIBJ1QRvraXhx5A469fKkyzijKI4lbi7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756311515; c=relaxed/simple;
	bh=28j+S/AtE11EZh6wqHFI1d6l2NcH4n7hMOYZwMPL8LY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RF2Yum+8DJGYHaD6lRP/ypDlIjAuZoI5ypfrTUYMlaXXfhgm6uHg18PS3iDhDIkoX8fKjkl0QvMnQiZDEi3l2u6cEpQA+QO//xoS39bpVajv1IV5nDtpDbRHkltlGwhVpX+fhfULIRaqAtl8jvSOK/v9T8sGwlVrPz/bMVNS/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmDWPNTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFF3C4CEEB;
	Wed, 27 Aug 2025 16:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756311514;
	bh=28j+S/AtE11EZh6wqHFI1d6l2NcH4n7hMOYZwMPL8LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nmDWPNTelfD/NRgVrsRxG+nJkWkrNTMjTXii7PepcV7C18daPPt/ALdgDI2p7+XUw
	 ieYdCH9jmTvedk7vUbDgqllmQnTRK4FttkqI54pIqjkKtfhRp8OQnkmgv4BgcbgjmE
	 xP5oUmn//0iXEWd9BxE37u4+sB6ED0viyMOtvnUKVxiTb9ox3uFGAHegnUX0nyIZW+
	 FmSfEfmNfgYMnA9wcsH0bSRPnn0T5XIAofLHahCQSY2iAA1nf98EIPk2xP7KDsznnq
	 ybV/gyWx8zwZ+OM0lFkCS+mAG6s+cmJ6RIrdHSHak+ljOyu8JlXgUSja+36wMfMCgq
	 eJCp8MN4yd9QQ==
From: SeongJae Park <sj@kernel.org>
To: Chris Li <chrisl@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v5] mm/zswap: store <PAGE_SIZE compression failed page as-is
Date: Wed, 27 Aug 2025 09:18:32 -0700
Message-Id: <20250827161832.164192-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CACePvbWGPApYr7G29FzbmWzRw-BJE39WH7kUHSaHs+Lnw8=-qQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 26 Aug 2025 08:52:35 -0700 Chris Li <chrisl@kernel.org> wrote:

> Hi SeongJae,
> 
> I did another pass review on it. This time with the editor so I saw
> more source code context and had more feedback.
> Mostly just nitpicks. See the detailed comments below.

Thank you for your review!

> 
> On Fri, Aug 22, 2025 at 12:08 PM SeongJae Park <sj@kernel.org> wrote:
> > @@ -971,8 +975,26 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
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
> > +       if (comp_ret || !dlen)
> > +               dlen = PAGE_SIZE;
> > +       if (dlen >= PAGE_SIZE) {
> 
> I think these two if can be simplify as:
> 
> if (comp_ret || !dlen || dlen >= PAGE_SIZE) {
>               dlen = PAGE_SIZE;
> 
> then you do the following check.
> That way when goto unlock happens, you have dlen = PAGE_SIZE related
> to my other feedback in kunmap_local()
> 
> > +               if (!mem_cgroup_zswap_writeback_enabled(
> > +                                       folio_memcg(page_folio(page)))) {
> > +                       comp_ret = comp_ret ? comp_ret : -EINVAL;
> > +                       goto unlock;
> > +               }
> > +               comp_ret = 0;
> > +               dlen = PAGE_SIZE;
> 
> Delete this line if you use the above suggestion on: dlen = PAGE_SIZE;

Thank you for nice suggestion!

> 
> > +               dst = kmap_local_page(page);
> > +       }
> >
> >         zpool = pool->zpool;
> >         gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE;
> > @@ -985,6 +1007,8 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
> >         entry->length = dlen;
> >
> >  unlock:
> > +       if (dst != acomp_ctx->buffer)
> > +               kunmap_local(dst);
> 
> I think this has a hidden assumption that kmap_local_page() will
> return a different value than acomp_ctx->buffer. That might be true. I
> haven't checked the internals. Otherwise you are missing a
> kunmap_local(). It also looks a bit strange in the sense that
> kumap_local() should be paired with kmap_local_page() in the same
> condition. The same condition is not obvious here.

Good point, I agree.

> How about this to
> make it more obvious and get rid of that assumption above:
> 
> if (dlen = PAGE_SIZE)
>                kunmap_local(dst);

However, if the execution reached here because compression failed and writeback
was disabled, kmap_local_page() wouldn't be called, so we could try to unmap
unmapped memory.

What do you think about adding another bool vairable for recording if
kunmap_local() need to be executed?  For example,

"""
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -952,6 +952,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
        struct zpool *zpool;
        gfp_t gfp;
        u8 *dst;
+       bool dst_need_unmap = false;

        acomp_ctx = acomp_ctx_get_cpu_lock(pool);
        dst = acomp_ctx->buffer;
@@ -994,6 +995,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
                comp_ret = 0;
                dlen = PAGE_SIZE;
                dst = kmap_local_page(page);
+               dst_need_unmap = true;
        }

        zpool = pool->zpool;
@@ -1007,7 +1009,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
        entry->length = dlen;

 unlock:
-       if (dst != acomp_ctx->buffer)
+       if (dst_need_unmap)
                kunmap_local(dst);
        if (comp_ret == -ENOSPC || alloc_ret == -ENOSPC)
                zswap_reject_compress_poor++;
"""

> 
> That assumes you also take my suggestion above to assign dlen PAGE_SIZE earlier.
> 
> 
> >         if (comp_ret = -ENOSPC || alloc_ret = -ENOSPC)
> >                 zswap_reject_compress_poor++;
> >         else if (comp_ret)
> > @@ -1007,6 +1031,14 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
> >         acomp_ctx = acomp_ctx_get_cpu_lock(entry->pool);
> >         obj = zpool_obj_read_begin(zpool, entry->handle, acomp_ctx->buffer);
> >
> > +       /* zswap entries of length PAGE_SIZE are not compressed. */
> > +       if (entry->length = PAGE_SIZE) {
> > +               memcpy_to_folio(folio, 0, obj, entry->length);
> 
> The following read_end() followed by acomp unlock() duplicates the
> normal decompress ending sequence. It will create complications when
> we modify the normal ending sequence in the future, we need to match
> it here.How about just goto the ending sequence and share the same
> return path as normal:
> 
>  +                  goto read_done;
> 
> Then insert the read_done label at ending sequence:
> 
>         dlen = acomp_ctx->req->dlen;
> 
> + read_done:
>         zpool_obj_read_end(zpool, entry->handle, obj);
>         acomp_ctx_put_unlock(acomp_ctx);

I agree your concern and this looks good to me :)

> 
> If you adopt that, you also will need to init the comp_ret to "0"
> instead of no init value in the beginning of the function:
> 
>         struct crypto_acomp_ctx *acomp_ctx;
> -        int decomp_ret, dlen;
> +       int decomp_ret = 0, dlen;
>         u8 *src, *obj;

We may also need to initialize 'dlen' as PAGE_SIZE ?
> 
> 
> > +               zpool_obj_read_end(zpool, entry->handle, obj);
> > +               acomp_ctx_put_unlock(acomp_ctx);
> > +               return true;
> 
> Delete the above 3 lines inside uncompress if case.
> 
> Looks good otherwise.
> 
> Thanks for the good work.

Thank you for your kind review and nice suggestions!  Since the change is
simple, I will post a fixup patch as reply to this, for adopting your
suggestions with my additional changes (adding dst_need_unmap bool variable on
zswap_compress(), and initializing dlen on zswap_decompress()) if you have no
objection or different suggestions for the my addition of the changes.  Please
let me know if you have any concern or other suggestions for my suggested
additional changes.


Thanks,
SJ

> 
> Chris
> 

