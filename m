Return-Path: <linux-kernel+bounces-758042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796F4B1CA2A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5B95656AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF20329AB1A;
	Wed,  6 Aug 2025 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyO1w+tX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309F85CDF1;
	Wed,  6 Aug 2025 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754499418; cv=none; b=WcysV7Oc/cVbmHuif5jsWMz1ZNl0f7Ux1dGR/N3hOj3odAy0r4CfzLEGhsG91fezw0lp+tO24uONkFRyY/lXdkfwDZmXK5T5bbzQaAlBS9L1XE2uXPLkQDMOj+DG8j8qsZhhePFKPBQ66DtEMSMc0cXODZQv5z4mEBsjYjWES1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754499418; c=relaxed/simple;
	bh=6VJOV51UUM14Q8/toC0ZbrbyRUsviN5blQFEgzQCA58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sl5w2yZUfXbH0mg/vp7V6tP/7Ym1yEW7mWnjezCDENrGDof7nO8pn2n+EBuUBkRmq4CfP9XJBeBeN/kJY+IsdHUnhv4AdjA0XCvNJwX0ry5k4xsVRgUk+rO3BEZd4aRhCmBrC2tbkfdFkcMVAca6NxXI4DWYQoBL5IidfB1hRRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyO1w+tX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC30C4CEE7;
	Wed,  6 Aug 2025 16:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754499418;
	bh=6VJOV51UUM14Q8/toC0ZbrbyRUsviN5blQFEgzQCA58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oyO1w+tXRvmiUp12Id1M7+/SjgE51p/1pDK/nVK9GoltG68CmJ07Wwx69+qZjNFLQ
	 9r+MVfZa65D3mUjDTiZsCuOaoFvddZASOU1KAYIm/cE3XylteMIwMneX+qyLcp+KXV
	 TD/KLyJXdj79naEXJhxdEt0St7f68Xsr74sLRsiMJ7YuqbQQdNxmzLChlNX3o1uaa9
	 3YWyGxzF/PjDOWCcNwjGpEPwu1SXwyOIP7DxPKhsFxEW9XaPlq5wHWFi7G1EkSvjG5
	 /USMn3F+LgtRTRZiyZdZiNhsdImC823BHD6hFdIi906eXddeZyJRmO2rn5o1KtePia
	 K6UxH9+YFFhew==
From: SeongJae Park <sj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>
Subject: Re: [RFC PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
Date: Wed,  6 Aug 2025 09:56:54 -0700
Message-Id: <20250806165654.82673-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250806163221.GA1795303@cmpxchg.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 6 Aug 2025 12:32:21 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> Hi SJ,
> 
> Overall this looks good to me. On top of the feedback provided by
> others, I have a few comments below.
> 
> On Mon, Aug 04, 2025 at 05:29:54PM -0700, SeongJae Park wrote:
> > @@ -142,6 +142,15 @@ User can enable it as follows::
> >  This can be enabled at the boot time if ``CONFIG_ZSWAP_SHRINKER_DEFAULT_ON`` is
> >  selected.
> >  
> > +If a page cannot be compressed into a size smaller than PAGE_SIZE, it can be
> > +beneficial to save the content as is without compression, to keep the LRU
> > +order.  Users can enable this behavior, as follows::
> > +
> > +  echo Y > /sys/module/zswap/parameters/save_incompressible_pages
> > +
> > +This is disabled by default, and doesn't change behavior of zswap writeback
> > +disabled case.
> > +
> >  A debugfs interface is provided for various statistic about pool size, number
> >  of pages stored, same-value filled pages and various counters for the reasons
> >  pages are rejected.
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 7e02c760955f..6e196c9a4dba 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -129,6 +129,11 @@ static bool zswap_shrinker_enabled = IS_ENABLED(
> >  		CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
> >  module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
> >  
> > +/* Enable/disable incompressible pages storing */
> > +static bool zswap_save_incompressible_pages;
> > +module_param_named(save_incompressible_pages, zswap_save_incompressible_pages,
> > +		bool, 0644);
> 
> Please remove the knob and just make it the default behavior.
> 
> With writeback enabled, the current behavior is quite weird:
> compressible pages to into zswap, then get written to swap in LRU
> order. Incompressible pages get sent to swap directly. This is an
> obvious age inversion, and the performance problems this has caused
> was a motivating factor for the ability to disable writeback.
> 
> I don't think there is much point in keeping that as an officially
> supported mode.

Makes sense, I agree!  I will do so in the next version.

> 
> > @@ -937,6 +942,29 @@ static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *acomp_ctx)
> >  	mutex_unlock(&acomp_ctx->mutex);
> >  }
> >  
> > +/*
> > + * Determine whether to save given page as-is.
> > + *
> > + * If a page cannot be compressed into a size smaller than PAGE_SIZE, it can be
> > + * beneficial to saving the content as is without compression, to keep the LRU
> > + * order.  This can increase memory overhead from metadata, but in common zswap
> > + * use cases where there are sufficient amount of compressible pages, the
> > + * overhead should be not critical, and can be mitigated by the writeback.
> > + * Also, the decompression overhead is optimized.
> > + *
> > + * When the writeback is disabled, however, the additional overhead could be
> > + * problematic.  For the case, just return the failure.  swap_writeout() will
> > + * put the page back to the active LRU list in the case.
> > + */
> > +static bool zswap_save_as_is(int comp_ret, unsigned int dlen,
> > +		struct page *page)
> > +{
> > +	return zswap_save_incompressible_pages &&
> > +			(comp_ret || dlen == PAGE_SIZE) &&
> > +			mem_cgroup_zswap_writeback_enabled(
> > +					folio_memcg(page_folio(page)));
> > +}
> > +
> >  static bool zswap_compress(struct page *page, struct zswap_entry *entry,
> >  			   struct zswap_pool *pool)
> >  {
> 
> > @@ -1001,6 +1034,17 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
> >  	return comp_ret == 0 && alloc_ret == 0;
> >  }
> >  
> > +/*
> > + * If save_incompressible_pages is set and writeback is enabled, incompressible
> > + * pages are saved as is without compression.  For more details, refer to the
> > + * comments of zswap_save_as_is().
> > + */
> > +static bool zswap_saved_as_is(struct zswap_entry *entry, struct folio *folio)
> > +{
> > +	return entry->length == PAGE_SIZE && zswap_save_incompressible_pages &&
> > +		mem_cgroup_zswap_writeback_enabled(folio_memcg(folio));
> > +}
> 
> I don't think there will be much left of these helpers once you
> incorporate Nhat's feedback, but please open-code these in either
> case. They're single user, hide what's going on, and the similar names
> doesn't do them any favors.

Agreed, I will do open-code these in the next version.


Thanks,
SJ

