Return-Path: <linux-kernel+bounces-771520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DE3B2885B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159491C884B5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8AC25EFBB;
	Fri, 15 Aug 2025 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYEAtBhj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1C01A317D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755296953; cv=none; b=n8L/c+37P8pC3lsZVHn2KHWx0MiZl883vprFw7LemGRWwSSmRdfgXP6yizMSBwlro4Gkp4MiQzQyk966ZC2UcIp31+jXeFCHU/e8b3C3bsUgSTACubxXESch3whnkNTrHEGPT0nw8uqe45yqc2qVKlEC6TgeR1B96DlQVppkPgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755296953; c=relaxed/simple;
	bh=SkSSzJAM8bFWv5HIg7HMVO9rDl6vlwH/R/0BsCYhR28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/A4PH4pC/aA12ra7/u/GF6d4Zrj3dkcqFD+ir1hv+WYSxzSUqS/5BivC0AjtcR20fcz2yXQE/dUr1g2Ol05jZTeDKDYThWuhnIm5uqdBfI1HrtFYSl1ukogCBzHi6qYjYTxLHD/fwRRJfY1xCJLMWn2NpPZS/bmGg+1Qmw86NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYEAtBhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051FDC4CEFD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755296953;
	bh=SkSSzJAM8bFWv5HIg7HMVO9rDl6vlwH/R/0BsCYhR28=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YYEAtBhjFJQAAEKHbbAGtBaT1XGNuShPcxO2ZjFq1hqyX5vHNcWZJ6+PDVFzP9bgS
	 ZKc012z8JbzxF6SjV/j8ygiSEWNNwscoWy6W3mkRsbwVUL5dO/ddlb3DFpmvoIj2oU
	 SLLnoqM5L5QSLBKiHUglNZCqCQInMcFdO8fw9MqqEAZasuSFeIncdS8wEeqB2AXz4q
	 WV0Kunk9Mg0lU2D0uNkXY2knKIgBEWgWz3cC0ki1LP47c5PU0/EbamNEteyoR8WMal
	 US3Wjil8DJ6omIKmqjtenDto+RgEi0/YS+qlFDBquOEphejogI90Yu6/fAyS8TkxF+
	 EvXWyYSImEE6Q==
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-459fc779bc3so11585e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:29:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9hmfM66hXwHB2HQ6m1DK24y0gAaauLmCtEqpohcoR8zTG03sMELgRjAjhQydIpcasfobkRkDNHn5rKkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaP2sQHGhIhp18EYeayFuquLztJNcw5eNgldW/VdV3+hbWb2Nd
	I/WSq2f1FzSSZ1f1Z73IX3eZjHeFkfqN3CwXRyPZJSBNOkdoLGEkqd78o6fWs8GPyCojz+R0Xj/
	iAh4upFZKcu3j50yuVk08mtoF5xxso4R8BNM2FgMy
X-Google-Smtp-Source: AGHT+IFtXGxOKaXfV3V/0PwaSWregyyyWEICyoq7KFkXlGWWv/3MaExEaNsK23mgDRd3ELCKRc4piJ5Lorc4clzVWDY=
X-Received: by 2002:a05:600c:a313:b0:459:efb0:6687 with SMTP id
 5b1f17b1804b1-45a268072dbmr467685e9.6.1755296951417; Fri, 15 Aug 2025
 15:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF8kJuN1BH0rqC6czj9govNOugd_5K9ijYcxbWYpEpUdQKn0-A@mail.gmail.com>
 <20250813182024.7250-1-sj@kernel.org>
In-Reply-To: <20250813182024.7250-1-sj@kernel.org>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 15 Aug 2025 15:28:59 -0700
X-Gmail-Original-Message-ID: <CAF8kJuONDFj4NAksaR4j_WyDbNwNGYLmTe-o76rqU17La=nkOw@mail.gmail.com>
X-Gm-Features: Ac12FXz8yjLYsEoXQfqu31-3QPm4TFk75XZI1gNgHa_14cPOVUvs-tAbq5xidtI
Message-ID: <CAF8kJuONDFj4NAksaR4j_WyDbNwNGYLmTe-o76rqU17La=nkOw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Takero Funaki <flintglass@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 11:20=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>
> My RFC v1[1] was using a kind of such approach.  I changed it to use zpoo=
l
> starting from RFC v2, following the suggestions from Nhat, Johannes and J=
oshua.
> It was suggested to use zpool to reuse its support of migration, highmem
> handling, and stats.  And I agree their suggestions.  David also raised a
> question on RFC v2, about the movability behavior changes[2].

Thanks for the pointer, that is an interesting read.

> I agree we will get more metadata overhead.  Nonetheless, I argue it is n=
ot a

Keep in mind that is more than just metadata. There is another hidden
overhead of using zpool to store your full page compared to directly
using the page.  When the page is read, because most likely the zpool
back end is not at a position aligned to the page. That zpool page
will not be able to free immediately, those fragmented zpool will need
to wait for compaction to free. it.

> big problem and can be mitigated in writeback-enabled environments.  Henc=
e this
> feature is disabled on writeback-disabled case.  Next paragraph on the or=
iginal
> cover letter explains my points about this.
>
> >
> > The pros is that, on the page fault, there is no need to allocate a
> > new page. You can just move the uncompressed_page into the swap_cache.
> > You save one memcpy on the page fault as well. That will make the
> > incompressible page fault behave very similar to the minor page fault.
>
> I agree this can save one memcpy, and that's cool idea!  Nonetheless, thi=
s
> patch is not making the [z]swap-in overhead worse.  Rather, this patch al=
so

We might still wait to evaluate the lost/gain vs store the
incompressible in swap cache. Google actually has an internal patch to
store the incompressible pages in swap cache and move them out of the
LRU to another already existing list. I can clean it up a bit and send
it to the list for comparison. This approach will not mess with the
zswap LRU because the incompressible data is not moving into zswap.
There is no page fault to handle the incompressible pages.

> slightly improve it for incompressible pages case by skipping the
> decompression.  Also, if we take this way, I think we should also need to=
 make
> a good answer to the zswapped-page migrations etc.

Yes, if we keep the store page in the zswap approach, we might have to
optimize inside zsmalloc to handle full page storing better.

> So, if we agree on my justification about the metadata overhead, I think =
this
> could be done as a followup work of this patch?

Sure. I am most interested in getting the best overall solution. No
objects to get it now vs later.

>
> >
> > The cons is that, now zpool does not account for uncompressed pages,
> > on the second thought, that can be a con as well, the page is not
> > compressed, why should it account as compressed pages?
>
> I agree it might look weird.  But, in my humble opinion, in a perspective=
 of
> thinking it as zswap backend storage, and by thinking the definition of
> compression in a flexible way, this may be understandable and not cause r=
eal
> user problems?

I think the real problem is hiding the real error with non errors like
data not compressible. If you want to store uncompressed data in the
zswap layer by design, that is fine. Just need to reason the trade off
vs other options like store in swap cache etc.

> [...]
> > >  mm/zswap.c | 36 ++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 34 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index 3c0fd8a13718..0fb940d03268 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -60,6 +60,8 @@ static u64 zswap_written_back_pages;
> > >  static u64 zswap_reject_reclaim_fail;
> > >  /* Store failed due to compression algorithm failure */
> > >  static u64 zswap_reject_compress_fail;
> > > +/* Compression into a size of <PAGE_SIZE failed */
> > > +static u64 zswap_compress_fail;
> > >  /* Compressed page was too big for the allocator to (optimally) stor=
e */
> > >  static u64 zswap_reject_compress_poor;
> > >  /* Load or writeback failed due to decompression failure */
> > > @@ -976,8 +978,26 @@ static bool zswap_compress(struct page *page, st=
ruct zswap_entry *entry,
> > >          */
> > >         comp_ret =3D crypto_wait_req(crypto_acomp_compress(acomp_ctx-=
>req), &acomp_ctx->wait);
> > >         dlen =3D acomp_ctx->req->dlen;
> > > -       if (comp_ret)
> > > -               goto unlock;
> > > +
> > > +       /*
> > > +        * If a page cannot be compressed into a size smaller than PA=
GE_SIZE,
> > > +        * save the content as is without a compression, to keep the =
LRU order
> > > +        * of writebacks.  If writeback is disabled, reject the page =
since it
> > > +        * only adds metadata overhead.  swap_writeout() will put the=
 page back
> > > +        * to the active LRU list in the case.
> > > +        */
> > > +       if (comp_ret || dlen >=3D PAGE_SIZE) {
> > > +               zswap_compress_fail++;
> >
> > I feel that mixing comp_ret and dlen size if tested here complicates
> > the nested if statement and the behavior as well.
> > One behavior change is that, if the comp_ret !=3D 0, it means the
> > compression crypt engine has some error. e.g. have some bad chip
> > always fail the compression. That is a different error case than the
> > compression was successful and the compression rate is not good. In
> > this case the patch makes the page store in zpool for cryto engine
> > failure, which does not help.
>
> I agree the code has rooms to improve, in terms of the readability, and k=
eeping
> fine grained observailibty.
>
> >
> > Is there any reason you want to store the page in zpool when the
> > compression engine (not the ratio) fails?
>
> The main problem this patch tries to solve is the LRU order corruption.  =
In any
> case, I want to keep the order if possible.

In that case, does it mean that in order to keep the LRU, you never
want to write from zswap to a real back end device? That will make
zswap behave more like a standalone tier.

>
> >
> > What do you say about the following alternative, this keeps the
> > original behavior if compression engines fail.
> >
> >      if (comp_ret) {
> >           zswap_compress_egine_fail++;
>
> I agree this counter can be useful.

Ack.

>
> >           goto unlock;
>
> This will make the page go directly to underlying slower swap device, and=
 hence
> cause LRU order inversion.  So unfortuately I have to say this is not the
> behavior I want.

Ack, that is a design choice. I understand now.

>
> I agree engine failure is not frequent, so this behavior might not really=
 make
> problem to me.  But, still I don't see a reason to let the page go direct=
ly to
> swap and make LRU order unexpected.
>
> >      }
> >
> >      if (dlen >=3D PAGE_SIZE) {
> >         zswap_compress_fail++;
>
> I define compress failure here as a failure of attempt to compress the gi=
ven
> page's content into a size smaller than PAGE_SIZE.  It is a superset incl=
uding
> both "ratio" failure and "engine" failure.  Hence I think zswap_compress_=
fail
> should be increased even in the upper case.

I slept over it a bit. Now I think we should make this a counter of
how many uncompressed pages count stored in zswap. Preperbelly as per
memcg counter.
I saw that you implement it as a counter in your V1. Does the zsmalloc
already track this information in the zspool class? Having this per
cgroup information we can evaluate how  much zswap is saving. Some
jobs like databases might store a lot of hash value and encrypted data
which is not compressible. In that case, we might just pass the whole
zswap tier as a whole. The overall compression ratio will reflect that
as well. Having the separate per memcg counter is kind of useful as
well.

>
> We can discuss about re-defining and re-naming what each stat means, of c=
ourse,
> if you want.  But I think even if we keep the current definitions and nam=
es, we
> can still get the ratio failures if we add your nicely suggested
> zswap_compress_engine_fail, as
> 'zswap_compress_fail - zswap_compress_engine_fail', so we might not reall=
y need
> re-definition and re-naming?

I am actually less interested in the absolute failure number which
keeps increasing, more on how much incompressible zswap is stored.
That counter + number of engine errors should be perfect.

>
> >         if (!mem_cgroup_zswap_writeback_enabled(
> >                                       folio_memcg(page_folio(page)))) {
> >               comp_ret =3D -EINVAL;
> >               goto unlock;
> >         }
> >        dlen =3D PAGE_SIZE;
> >        dst =3D kmap_local_page(page);
> >     }
> >
> > Overall I feel this alternative is simpler and easier to read.
>
> I agree this code is nice to read.  Nonetheless I have to say the behavio=
r is
> somewhat different from what I want.

Even if you keep the current behavior, you can move the invert the
test condition and then remove the "else + goto" similar to the above.
That will make your code less and flatter. I will need to think about
whether we can assign the return value less.

Another point I would like to make is that you currently make the cut
off threshold as page size. The ideal threshold might be something
slightly smaller than page size. The reason is that the zsmalloc has a
fixed size chuck to store it. If your page is close to full, it will
store the data in the same class as the full page. You are not gaining
anything from zsmalloc if the store page compression ratio is 95%.
That 5% will be in the waste in the zsmalloc class fragment anyway. So
the trade off is, decompress 95% of a page vs memcpy 100% of a page.
It is likely memcpy 100% is faster. I don't know the exact ideal cut
off of threshold. If I had to guess, I would guess below 90%.

>
> > I can
> > be biased towards my own code :-).
> > I think we should treat the compression engine failure separately from
> > the compression rate failure. The engine failure is rare and we should
> > know about it as a real error. The compression rate failure is normal.
>
> Again, I agree having the observability would be nice.  I can add a new c=
ounter
> for that, like below attached patch, for example.

I would love that. Make that per memcg if possible :-)

>
> [1] https://lore.kernel.org/20250730234059.4603-1-sj@kernel.org
> [2] https://lore.kernel.org/761a2899-6fd9-4bfe-aeaf-23bce0baa0f1@redhat.c=
om

Thanks for the pointer, good read.

Chris

