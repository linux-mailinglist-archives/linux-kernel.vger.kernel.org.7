Return-Path: <linux-kernel+bounces-767328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E50FB252EA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDB0627FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54065295531;
	Wed, 13 Aug 2025 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwTLAG2S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE85303C80
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755109229; cv=none; b=TfIjPKjSjy11EuxHL/c7G77HdTogLS8HX24jM3eL2KsiMwv40/lyeFdKvDeF18G4IiZ3PDzBLEarpRK5WRP2N49hNacfUmPuq3pc9FTJX/D1S7k+u2Gi53L14miaDVJsuBnGxpjO5OvfmKu482DTDF74D8H56qYOBZJnv49y8Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755109229; c=relaxed/simple;
	bh=jAZuPkluBbsvtCyN+PQZmxpu2+/htnF0npHMspg4Buc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imEcxOiVyMkBc4N8/CaIFkPvgpY2LQlDF4nPVAD2yEBB8oBRfI8tukLPROg2rizxDtCbAHvl3iilp0exW/mA14ae6Kgp8g1BJzDUJVVBKrG30gsu667xDBJg4SobqOaFgNAtPU5etwPErUjMPQvD2ZbtYWu/3KQXkUFRvSvmJtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwTLAG2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0F0C4CEEB;
	Wed, 13 Aug 2025 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755109229;
	bh=jAZuPkluBbsvtCyN+PQZmxpu2+/htnF0npHMspg4Buc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dwTLAG2SIuLDl2e+cBFdym5QlBAFqshTHHN/BO5aLd3/q/7g1FI78wLI2XnRn0z8L
	 7+jdriKWXmlfGJj/lSFSkMFPZBSwzlaH4dfGyJqVgB01aqNY4MbgA0iSqShovq8pTg
	 Zu5MtoMZLYgLQ1r+cXR7u18s3hYkk1a8BereVz2rjAfdItwc7XGftpj/CL5wOrhaXb
	 Fp3W8424k6o+2wC1auYRE32LXhzZXHtRSMbYyPOTJIgnauAMNPTRYSFDl1UVF9x5qA
	 Cn6F2S/cTrE57yxs/Ev3PAHc9SG1x6wJNylUIul6ufsrVS82b0otfbh0pAZE4IXFFs
	 2d2oGPc3lOfzw==
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
Date: Wed, 13 Aug 2025 11:20:24 -0700
Message-Id: <20250813182024.7250-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAF8kJuN1BH0rqC6czj9govNOugd_5K9ijYcxbWYpEpUdQKn0-A@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Chris,

On Wed, 13 Aug 2025 10:07:18 -0700 Chris Li <chrisl@kernel.org> wrote:

> Hi SeongJae,
> 
> Thanks for doing that. I am working on something related to this as
> well. Please consider CC me on your next version.

Thank you for chiming in, I will do so.

> 
> On Tue, Aug 12, 2025 at 10:00 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > When zswap writeback is enabled and it fails compressing a given page,
> > the page is swapped out to the backing swap device.  This behavior
> > breaks the zswap's writeback LRU order, and hence users can experience
> > unexpected latency spikes.  If the page is compressed without failure,
> > but results in a size of PAGE_SIZE, the LRU order is kept, but the
> > decompression overhead for loading the page back on the later access is
> > unnecessary.
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
> 
> If you store uncompressed data in the zpool, zpool has metadata
> overhead, e.g. allocating the entry->handle for uncompressed pages.
> If the page is not compressed, another idea is just skip the zpool,
> store it as a page in the zswap entry as page. We can make a union of
> entry->handle and entry->incompressble_page. If entry->length =
> PAGE_SIZE, use entry->incompressable_page as a page.

My RFC v1[1] was using a kind of such approach.  I changed it to use zpool
starting from RFC v2, following the suggestions from Nhat, Johannes and Joshua.
It was suggested to use zpool to reuse its support of migration, highmem
handling, and stats.  And I agree their suggestions.  David also raised a
question on RFC v2, about the movability behavior changes[2].

I agree we will get more metadata overhead.  Nonetheless, I argue it is not a
big problem and can be mitigated in writeback-enabled environments.  Hence this
feature is disabled on writeback-disabled case.  Next paragraph on the original
cover letter explains my points about this.

> 
> The pros is that, on the page fault, there is no need to allocate a
> new page. You can just move the uncompressed_page into the swap_cache.
> You save one memcpy on the page fault as well. That will make the
> incompressible page fault behave very similar to the minor page fault.

I agree this can save one memcpy, and that's cool idea!  Nonetheless, this
patch is not making the [z]swap-in overhead worse.  Rather, this patch also
slightly improve it for incompressible pages case by skipping the
decompression.  Also, if we take this way, I think we should also need to make
a good answer to the zswapped-page migrations etc.

So, if we agree on my justification about the metadata overhead, I think this
could be done as a followup work of this patch?

> 
> The cons is that, now zpool does not account for uncompressed pages,
> on the second thought, that can be a con as well, the page is not
> compressed, why should it account as compressed pages?

I agree it might look weird.  But, in my humble opinion, in a perspective of
thinking it as zswap backend storage, and by thinking the definition of
compression in a flexible way, this may be understandable and not cause real
user problems?

> 
> I know Hugh has some idea to store incompressible pages in the swap
> cache as well. Hugh?
> 
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
> > list in the case.
> >
> > Knowing how many compression failures happened will be useful for future
> > investigations.  investigations.  Add a new debugfs file, compress_fail,
> > for the purpose.
> 
> Again, I think we should distinguish the crypto engine fail vs ration failure.

I see you left more detailed good opinions about this below.  I will reply
there.

[...]
> >  mm/zswap.c | 36 ++++++++++++++++++++++++++++++++++--
> >  1 file changed, 34 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 3c0fd8a13718..0fb940d03268 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -60,6 +60,8 @@ static u64 zswap_written_back_pages;
> >  static u64 zswap_reject_reclaim_fail;
> >  /* Store failed due to compression algorithm failure */
> >  static u64 zswap_reject_compress_fail;
> > +/* Compression into a size of <PAGE_SIZE failed */
> > +static u64 zswap_compress_fail;
> >  /* Compressed page was too big for the allocator to (optimally) store */
> >  static u64 zswap_reject_compress_poor;
> >  /* Load or writeback failed due to decompression failure */
> > @@ -976,8 +978,26 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
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
> > +               zswap_compress_fail++;
> 
> I feel that mixing comp_ret and dlen size if tested here complicates
> the nested if statement and the behavior as well.
> One behavior change is that, if the comp_ret != 0, it means the
> compression crypt engine has some error. e.g. have some bad chip
> always fail the compression. That is a different error case than the
> compression was successful and the compression rate is not good. In
> this case the patch makes the page store in zpool for cryto engine
> failure, which does not help.

I agree the code has rooms to improve, in terms of the readability, and keeping
fine grained observailibty.

> 
> Is there any reason you want to store the page in zpool when the
> compression engine (not the ratio) fails?

The main problem this patch tries to solve is the LRU order corruption.  In any
case, I want to keep the order if possible.

> 
> What do you say about the following alternative, this keeps the
> original behavior if compression engines fail.
> 
>      if (comp_ret) {
>           zswap_compress_egine_fail++;

I agree this counter can be useful.

>           goto unlock;

This will make the page go directly to underlying slower swap device, and hence
cause LRU order inversion.  So unfortuately I have to say this is not the
behavior I want.

I agree engine failure is not frequent, so this behavior might not really make
problem to me.  But, still I don't see a reason to let the page go directly to
swap and make LRU order unexpected.

>      }
> 
>      if (dlen >= PAGE_SIZE) {
>         zswap_compress_fail++;

I define compress failure here as a failure of attempt to compress the given
page's content into a size smaller than PAGE_SIZE.  It is a superset including
both "ratio" failure and "engine" failure.  Hence I think zswap_compress_fail
should be increased even in the upper case.

We can discuss about re-defining and re-naming what each stat means, of course,
if you want.  But I think even if we keep the current definitions and names, we
can still get the ratio failures if we add your nicely suggested
zswap_compress_engine_fail, as
'zswap_compress_fail - zswap_compress_engine_fail', so we might not really need
re-definition and re-naming?

>         if (!mem_cgroup_zswap_writeback_enabled(
>                                       folio_memcg(page_folio(page)))) {
>               comp_ret = -EINVAL;
>               goto unlock;
>         }
>        dlen = PAGE_SIZE;
>        dst = kmap_local_page(page);
>     }
> 
> Overall I feel this alternative is simpler and easier to read.

I agree this code is nice to read.  Nonetheless I have to say the behavior is
somewhat different from what I want.

> I can
> be biased towards my own code :-).
> I think we should treat the compression engine failure separately from
> the compression rate failure. The engine failure is rare and we should
> know about it as a real error. The compression rate failure is normal.

Again, I agree having the observability would be nice.  I can add a new counter
for that, like below attached patch, for example.

[1] https://lore.kernel.org/20250730234059.4603-1-sj@kernel.org
[2] https://lore.kernel.org/761a2899-6fd9-4bfe-aeaf-23bce0baa0f1@redhat.com


Thanks,
SJ

[...]

==== >8 ====
From 839459619cf2c1a66d0a82361808bab499feefda Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Wed, 13 Aug 2025 11:13:24 -0700
Subject: [PATCH] mm/zswap: add crypto engine failures debugfs counter

compress_fail counts failures of general attempts to compress a given
apge into a size smaller than PAGE_SIZE.  It could be happened because
the content of the page is not easy to be compressed, or the crypto
engine error-ed for any reason.  Adda new debugfs file, namely
compress_engine_fail, for coutning the latter case.  Keep the
comress_fail count, since the failures due to the compression ratio
failure can be calculated by subtracting the new counter
(compress_engine_fail) value from that of the existing one
(compress_fail).

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/zswap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index 0fb940d03268..6b2144126fba 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -62,6 +62,8 @@ static u64 zswap_reject_reclaim_fail;
 static u64 zswap_reject_compress_fail;
 /* Compression into a size of <PAGE_SIZE failed */
 static u64 zswap_compress_fail;
+/* Compression failed by the crypto engine */
+static u64 zswap_compress_engine_fail;
 /* Compressed page was too big for the allocator to (optimally) store */
 static u64 zswap_reject_compress_poor;
 /* Load or writeback failed due to decompression failure */
@@ -988,6 +990,8 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	 */
 	if (comp_ret || dlen >= PAGE_SIZE) {
 		zswap_compress_fail++;
+		if (comp_ret)
+			zswap_compress_engine_fail++;
 		if (mem_cgroup_zswap_writeback_enabled(
 					folio_memcg(page_folio(page)))) {
 			comp_ret = 0;
@@ -1841,6 +1845,8 @@ static int zswap_debugfs_init(void)
 			   zswap_debugfs_root, &zswap_reject_compress_fail);
 	debugfs_create_u64("compress_fail", 0444,
 			   zswap_debugfs_root, &zswap_compress_fail);
+	debugfs_create_u64("compress_engine_fail", 0444,
+			   zswap_debugfs_root, &zswap_compress_engine_fail);
 	debugfs_create_u64("reject_compress_poor", 0444,
 			   zswap_debugfs_root, &zswap_reject_compress_poor);
 	debugfs_create_u64("decompress_fail", 0444,
-- 
2.39.5

