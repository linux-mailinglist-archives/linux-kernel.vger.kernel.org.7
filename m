Return-Path: <linux-kernel+bounces-823849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02060B8791A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19E11CC1C93
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C3F1DF24F;
	Fri, 19 Sep 2025 01:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K4PKUmhO"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7905CDF1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758244002; cv=none; b=MLOMuvnifA3tlT1Z9vz29HuUAB7ogslq8QeeNB3ciG+DF6ETBeUba0A4Q1TRQ7pgv4Smc3rPzkPLm4gEIfu/VbOVxiFcYRs72209+WsilpV9KwUinbZA1hX3eLKeL15qKlPBjPOalwoMf6ODFh5J4dUH0yrVDfWjeTSqBbgmwoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758244002; c=relaxed/simple;
	bh=JUgbWzNIoLmVUsk5ZbbA2sf6t2tLo6ofi8lh17uHRFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsA+lG31z6CRDWM+DA+5SV06OUtAbduMMkgldF/j14E3eFt3Gu8EFktnzm1wdi4w01E787U6woO32dvErk2Q/dJv/pL2fO4LBPtVWS4b64T7Wa7QW2gDbywqXzBaBobqyaClkKVnYrOke+eJc2GDqmbF1RqsHbuW0OxorbdiHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K4PKUmhO; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 18 Sep 2025 18:06:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758243995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSiTM76aEl/ZMy88fSj8fEpGw2fldtJUcgJzMMiasas=;
	b=K4PKUmhOJz3QkN43tWm8G1oLXgOMrz1mm8x1L4DAY1mO9FqzASio6LRsuSsxzz2EdCdJir
	f4ppZEuogwRwqYPF4xqu8z96HPQXzTSeCMtLgXPLA3D6N48aXuM2ZaNLy3xPCK/4eQxWKK
	zYVRvSPu3bhpkVK40cK8926QwQfCYlM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, zhengqi.arch@bytedance.com, 
	lorenzo.stoakes@oracle.com, hughd@google.com, willy@infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
Message-ID: <tombfifwrhx2n4jnj2pgcdcpj42mdv7yizkpxrppnqrtsxd5fw@epnrjqgmmy6z>
References: <cover.1758166683.git.baolin.wang@linux.alibaba.com>
 <9ef0e560dc83650bc538eb5dcd1594e112c1369f.1758166683.git.baolin.wang@linux.alibaba.com>
 <17d1b293-e393-4989-a357-7eea74b3c805@redhat.com>
 <4e938fa1-c6ea-43fb-abbd-de514842a005@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e938fa1-c6ea-43fb-abbd-de514842a005@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 18, 2025 at 05:36:17PM +0800, Baolin Wang wrote:
> 
> 
> On 2025/9/18 14:00, David Hildenbrand wrote:
> > On 18.09.25 05:46, Baolin Wang wrote:
> > > The folio_test_private() check in pageout() was introduced by commit
> > > ce91b575332b ("orphaned pagecache memleak fix") in 2005 (checked from
> > > a history tree[1]). As the commit message mentioned, it was to address
> > > the issue where reiserfs pagecache may be truncated while still pinned.
> > > To further explain, the truncation removes the page->mapping, but the
> > > page is still listed in the VM queues because it still has buffers.
> > > 
> > > In 2008, commit a2b345642f530 ("Fix dirty page accounting leak with ext3
> > > data=journal") seems to be dealing with a similar issue, where the page
> > > becomes dirty after truncation, and it provides a very useful call stack:
> > > truncate_complete_page()
> > >        cancel_dirty_page() // PG_dirty cleared, decr. dirty pages
> > >        do_invalidatepage()
> > >          ext3_invalidatepage()
> > >            journal_invalidatepage()
> > >              journal_unmap_buffer()
> > >                __dispose_buffer()
> > >                  __journal_unfile_buffer()
> > >                    __journal_temp_unlink_buffer()
> > >                      mark_buffer_dirty(); // PG_dirty set, incr.
> > > dirty pages
> > > 
> > > In this commit a2b345642f530, we forcefully clear the page's dirty flag
> > > during truncation (in truncate_complete_page()).
> > > 
> > > Now it seems this was just a peculiar usage specific to reiserfs. Maybe
> > > reiserfs had some extra refcount on these pages, which caused them
> > > to pass
> > > the is_page_cache_freeable() check. With the fix provided by commit
> > > a2b345642f530
> > > and reiserfs being removed in 2024 by commit fb6f20ecb121 ("reiserfs: The
> > > last commit"), such a case is unlikely to occur again. So let's
> > > remove the
> > > redundant folio_test_private() checks and related buffer_head
> > > release logic,
> > > and just leave a warning here to catch such a bug.
> > > 
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> > > Acked-by: David Hildenbrand <david@redhat.com>
> > > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > > ---
> > >   mm/vmscan.c | 12 +++---------
> > >   1 file changed, 3 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index f1fc36729ddd..930add6d90ab 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -701,16 +701,10 @@ static pageout_t pageout(struct folio *folio,
> > > struct address_space *mapping,
> > >           return PAGE_KEEP;
> > >       if (!mapping) {
> > >           /*
> > > -         * Some data journaling orphaned folios can have
> > > -         * folio->mapping == NULL while being dirty with clean buffers.
> > > +         * Is it still possible to have a dirty folio with
> > > +         * a NULL mapping? I think not.
> > >            */
> > 
> > I would rephrase slightly (removing the "I think not"):
> > 
> > /*
> >   * We should no longer have dirty folios with clean buffers and a NULL
> >   * mapping. However, let's be careful for now.
> >   */
> 
> LGTM.
> 
> Andrew, could you help squash these comments into this patch? Thanks.
> 
> > > -        if (folio_test_private(folio)) {
> > > -            if (try_to_free_buffers(folio)) {
> > > -                folio_clear_dirty(folio);
> > > -                pr_info("%s: orphaned folio\n", __func__);
> > > -                return PAGE_CLEAN;
> > > -            }
> > > -        }
> > > +        VM_WARN_ON_FOLIO(true, folio);

Unexpected but better to use VM_WARN_ON_ONCE_FOLIO here.

