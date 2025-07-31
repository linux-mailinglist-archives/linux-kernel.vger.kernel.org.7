Return-Path: <linux-kernel+bounces-752428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC692B17575
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8560189290B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911D423E33D;
	Thu, 31 Jul 2025 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrYhVc0x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1111DE8A8
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753981767; cv=none; b=phDemJ0XjJyiH13AhRXIgoXbCnKdsLU3GIHEwwC0ZwBvjnbl5MCm6X6a1Nd/Z3v1E/Wc5wIBzCYXuVhNcj2W48e4CAnmxbrNiaDz0MOm0wWrE/DsBldB8kM/3H3oAz187T3GXOOd68vEEJHWRkawlvkQQXYvu0y8R00CgTG5czM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753981767; c=relaxed/simple;
	bh=6bPNipU0whTXeXOhptgV+3Q6u/o8UbEZkKzhgED/zPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jG1OZYm0ONzcB1XIMkKR9HqezFBuldjUbEiuawJEv6O9qUDXnZQhYsg3wOYQDXrj5nLMkk/okGWfBmhPyv9/NVWXAjSo24TQ21cMrpd/Hau+WftunaA7t1awgLjC5PzKn40gfQ9r9ZQULN9haFzTAqyVOCb0b9DetShEfl+/ry8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrYhVc0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578C8C4CEEF;
	Thu, 31 Jul 2025 17:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753981766;
	bh=6bPNipU0whTXeXOhptgV+3Q6u/o8UbEZkKzhgED/zPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JrYhVc0xd4AcMXOGqQ0Y8GmkjSdg4OTi0uigcLGh+9hlV3+eXpAjERV3Hsn8+YCNO
	 yMswq5UkElC8KNPSPq9U0jOFCe/y8L1d/vQaMuaCsg37rKV1gM6cI7VyVoj7HLOWYS
	 puzRJgmPQG59HL3sa5iOt6oMiixqKGRuX1OTZDA/CoLyJONtreMK+SNqXpp2DLrYZn
	 ekwVF4HXof5kTPFidO2CcwRshg11Hv0Lj1/iaCBHQsPktfSVN5f9kwEniUVutlGT3u
	 XwcRFccN2PnUXNqED+fIbFbzahSuZiX0Yti0nBNLs5J6XcLU4ZqF/XkLIDt3JRi3w1
	 1LKe03BYd1KIw==
From: SeongJae Park <sj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Takero Funaki <flintglass@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/zswap: store compression failed page as-is
Date: Thu, 31 Jul 2025 10:09:22 -0700
Message-Id: <20250731170922.15509-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731152701.GA1055539@cmpxchg.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 31 Jul 2025 11:27:01 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> Hi SJ,
> 
> On Wed, Jul 30, 2025 at 04:40:59PM -0700, SeongJae Park wrote:
> > When zswap writeback is enabled and it fails compressing a given page,
> > zswap lets the page be swapped out to the backing swap device.  This
> > behavior breaks the zswap's writeback LRU order, and hence users can
> > experience unexpected latency spikes.
> 
> +1 Thanks for working on this!

My pleasure :)

[...]
> >     config            0       1-1     1-2      1-3      2-1     2-2      2-3
> >     perf_normalized   1.0000  0.0060  0.0230   0.0310   0.0030  0.0116   0.0003
> >     perf_stdev_ratio  0.06    0.04    0.11     0.14     0.03    0.05     0.26
> >     zswpin            0       0       1701702  6982188  0       2479848  815742
> >     zswpout           0       0       1725260  7048517  0       2535744  931420
> >     zswpwb            0       0       0        0        0       0        0
> >     pswpin            0       468612  481270   0        476434  535772   0
> >     pswpout           0       574634  689625   0        612683  591881   0
> 
> zswpwb being zero across the board suggests the zswap shrinker was not
> enabled. Can you double check that?

You're correct, I didn't.

> 
> We should only take on incompressible pages to maintain LRU order on
> their way to disk. If we don't try to move them out, then it's better
> to reject them and avoid the metadata overhead.

I agree.  I will update the test to explore the writeback effect, and share the
results, by the posting of the next version of this patch.

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
> > +		struct zswap_entry *entry)
> > +{
> > +	if (!zswap_save_incompressible_pages)
> > +		return comp_ret;
> > +	if (!mem_cgroup_zswap_writeback_enabled(
> > +				folio_memcg(page_folio(page))))
> > +		return comp_ret;
> > +
> > +	entry->orig_data = kmalloc_node(PAGE_SIZE, GFP_NOWAIT | __GFP_NORETRY |
> > +			__GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
> > +	if (!entry->orig_data)
> > +		return -ENOMEM;
> > +	memcpy_from_page(entry->orig_data, page, 0, PAGE_SIZE);
> > +	entry->length = PAGE_SIZE;
> > +	atomic_long_inc(&zswap_stored_uncompressed_pages);
> > +	return 0;
> > +}
> 
> Better to still use the backend (zsmalloc) for storage. It'll give you
> migratability, highmem handling, stats etc.

Nhat also pointed out the migratability.  Thank you for further letting me know
even more benefits from zsmalloc reuse.  As I also replied to Nhat, I agree
those are important benefits, and I will rework on the next version to use the
backend.

> 
> So if compression fails, still do zpool_malloc(), but for PAGE_SIZE
> and copy over the uncompressed page contents.
> 
> struct zswap_entry has a hole after bool referenced, so you can add a
> flag to mark those uncompressed entries at no extra cost.
> 
> Then you can detect this case in zswap_decompress() and handle the
> uncompressed copy into @folio accordingly.

I think we could still use 'zswap_entry->length == PAGE_SIZE' as the indicator,
As long as we ensure that always means the content is incompressed, following
Nhat's suggestion[1].

Please let me know if I'm missing something.

[1] https://lore.kernel.org/CAKEwX=Py+yvxtR5zt-1DtskhGWWHkRP_h8kneEHSrcQ947=m9Q@mail.gmail.com


Thanks,
SJ

