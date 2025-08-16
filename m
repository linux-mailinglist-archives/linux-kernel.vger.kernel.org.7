Return-Path: <linux-kernel+bounces-771580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E47A9B28912
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 02:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DBAE1C84130
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DACC79EA;
	Sat, 16 Aug 2025 00:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMf+dC18"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA18B524F
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302824; cv=none; b=lKVCa2wmGKxQNcvE8slFXQlfCix4ZNZmS7Xn7EKC0ahtv1A4NXQlSPvYwQxhvkmFMJ03oNHKaXIOBYwtxON78NzyfzQRC8y9wymKP9qvR7baACKLnISfy0Osy2qHD+qtl2tAAWU27A0FVUQVAzvFX5Ww052sQENZEdCHH1YIZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302824; c=relaxed/simple;
	bh=+7InZKab1A6cmyKNxFZYNSs5pQCLVO7y8nEBO2jsTxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncvoB5l6Tj1bcYvvijboyrjLfToKPyC0FiGZbQrTcWhihhQRkRCutQ++hDSxphVxY1mMtcJj4xNEbbKbEl6yPgKw0EUlRNLlpHH3+gkfSwmfFir18iBxLRCxPLUzrU67nn5ov1P/XD45HunRrPcCUiyV+6ajc77MRgE9rT9sEEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMf+dC18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7CAC4CEEB;
	Sat, 16 Aug 2025 00:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302824;
	bh=+7InZKab1A6cmyKNxFZYNSs5pQCLVO7y8nEBO2jsTxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EMf+dC18/RoSmZ8NitdCIj8RPm5ygXauWGNGpZi5SE1DL9kU+eogqSTOH/RaSl/HE
	 INzj9L5q8hAWhI5DRKRnu7z4GXo0wwoLfzr3ZH/304b3MgWUUV0SVRiZzx7GC+Rawv
	 Mj6MBhKv63kJ6X0HKIYY5hmalEsqCbVZm4bK4TCutj5tBzKsJfkRsCGgeaFrtt13Q4
	 W9/+Acg2stkd4uRKIBOSMCIm18aC9EFiuY+24JOVdR0io9NXL2c5qHijZafQqjIXqM
	 HHa+ksKjDpeoTdWU8Gn8qTiD6RAz0+B/tN16rvu1ZmYtwOXgc645P4vb6kZVYObBe2
	 OQ3cVddhEQYng==
From: SeongJae Park <sj@kernel.org>
To: Chris Li <chrisl@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>,
	Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
Date: Fri, 15 Aug 2025 17:07:01 -0700
Message-Id: <20250816000701.90784-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAF8kJuONDFj4NAksaR4j_WyDbNwNGYLmTe-o76rqU17La=nkOw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 15 Aug 2025 15:28:59 -0700 Chris Li <chrisl@kernel.org> wrote:

> On Wed, Aug 13, 2025 at 11:20 AM SeongJae Park <sj@kernel.org> wrote:
[...]
> We might still wait to evaluate the lost/gain vs store the
> incompressible in swap cache. Google actually has an internal patch to
> store the incompressible pages in swap cache and move them out of the
> LRU to another already existing list. I can clean it up a bit and send
> it to the list for comparison.

This would be really nice!

[...]
> > So, if we agree on my justification about the metadata overhead, I think this
> > could be done as a followup work of this patch?
> 
> Sure. I am most interested in getting the best overall solution. No
> objects to get it now vs later.

Thank you for being flexible, Chris.  I'm also looking forward to keep
collaborating with you on the followup works!

[...]
> > > Is there any reason you want to store the page in zpool when the
> > > compression engine (not the ratio) fails?
> >
> > The main problem this patch tries to solve is the LRU order corruption.  In any
> > case, I want to keep the order if possible.
> 
> In that case, does it mean that in order to keep the LRU, you never
> want to write from zswap to a real back end device?

Not always, but until we have to write back zswapped pages to real back end
deevice, and all zswapped pages of lower LRU-order are already wrote back.

[...]
> > >      if (dlen >= PAGE_SIZE) {
> > >         zswap_compress_fail++;
> >
> > I define compress failure here as a failure of attempt to compress the given
> > page's content into a size smaller than PAGE_SIZE.  It is a superset including
> > both "ratio" failure and "engine" failure.  Hence I think zswap_compress_fail
> > should be increased even in the upper case.
> 
> I slept over it a bit. Now I think we should make this a counter of
> how many uncompressed pages count stored in zswap. Preperbelly as per
> memcg counter.

I agree that could be useful.  I will add the counter in the next version (v4).
But making it for each memcg may be out of the scope of this patch, in my
opinion.  Would you mind doing per-memcg counter implementation as a followup?

> I saw that you implement it as a counter in your V1.

Yes, though it was only for internal usage and therefore not exposed to the
user space.  I will make it again and expose to the user space via debugfs.
Say, stored_uncompressed_pages?

> Does the zsmalloc
> already track this information in the zspool class?

zsmalloc provides such information when CONFIG_ZSMALLOC_STAT is enabled, to my
understanding.

[...]
> I am actually less interested in the absolute failure number which
> keeps increasing, more on how much incompressible zswap is stored.
> That counter + number of engine errors should be perfect.

Sounds good.  So the next version (v4) of this patch will provide two new
debugfs counters, namely compress_engine_fail, and stored_uncompressed_pages.

[...]
> > I agree this code is nice to read.  Nonetheless I have to say the behavior is
> > somewhat different from what I want.
> 
> Even if you keep the current behavior, you can move the invert the
> test condition and then remove the "else + goto" similar to the above.
> That will make your code less and flatter. I will need to think about
> whether we can assign the return value less.

Nice idea.  What about below?

        if (comp_ret) {
                zswap_compress_engine_fail++;
                dlen = PAGE_SIZE;
        }
        if (dlen >= PAGE_SIZE) {
                zswap_compress_fail++;
                if (!mem_cgroup_zswap_writeback_enabled(
                                        folio_memcg(page_folio(page)))) {
                        comp_ret = -EINVAL;
                        goto unlock;
                }
                comp_ret = 0;
                dlen = PAGE_SIZE;
                dst = kmap_local_page(page);
        }

> 
> Another point I would like to make is that you currently make the cut
> off threshold as page size. The ideal threshold might be something
> slightly smaller than page size. The reason is that the zsmalloc has a
> fixed size chuck to store it. If your page is close to full, it will
> store the data in the same class as the full page. You are not gaining
> anything from zsmalloc if the store page compression ratio is 95%.
> That 5% will be in the waste in the zsmalloc class fragment anyway. So
> the trade off is, decompress 95% of a page vs memcpy 100% of a page.
> It is likely memcpy 100% is faster. I don't know the exact ideal cut
> off of threshold. If I had to guess, I would guess below 90%.

Agreed, this could be another nice followup work to do.

> 
> >
> > > I can
> > > be biased towards my own code :-).
> > > I think we should treat the compression engine failure separately from
> > > the compression rate failure. The engine failure is rare and we should
> > > know about it as a real error. The compression rate failure is normal.
> >
> > Again, I agree having the observability would be nice.  I can add a new counter
> > for that, like below attached patch, for example.
> 
> I would love that. Make that per memcg if possible :-)

As mentioned above, I would like to make only a global counter on debugfs for
now, if you don't mind.  Let me know if you mind.


Thanks,
SJ

[...]

