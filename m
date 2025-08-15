Return-Path: <linux-kernel+bounces-771547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6802CB288A1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 01:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FE86B64349
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9362D0624;
	Fri, 15 Aug 2025 23:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeayrpTy"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C37B79F2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755299346; cv=none; b=ghjJkx3IS2luqEgySqW96wK3ohbeGRF2meHfcjWRZlvU1Pj4XyYZbuH6X+SJtuQk/9Wa5M6xGIMrdFG0xh/07ejrE8Yiqb2Y0jlCoJ6VJ/r5zD4BmXO5zQSfOCzHPzN6cp9I7XOCzzOiX3JnQlz7irlQppUJ9b/G/Lfpr2BoD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755299346; c=relaxed/simple;
	bh=lOGcD1WBM/Gccg++XF0B5o1g+WLTkubXwku4ndW9SlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUo5he0Cv2q3qb53CT8ngcqEmCN11slUyk88ITRCaX9DbTl85g5rhDhh/vj3esrApUexDWwv/+oPmM/MhzwIwXw+Ax8r4gJTipVvYR8zacFuIuQ9W1yRN5Qzob/dBhe3/bQdylul8ifhpOrhKrkxRcu2+RLvpXXOgfnqIFt50P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeayrpTy; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3e56fe580b4so10841965ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755299343; x=1755904143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42MdIw/zn0IyOrePf8q8Yhtrpa4xzlqA2mTCVTQGHKI=;
        b=CeayrpTyvkeR7ROh8rl1RKpOenTvlISPAF8LO3z/dFVwA8uQOPi8fB3e0A7JZGWrlh
         KtpKTxcWls/RqPJ2tCev7TZ814ONhhhJaQtla5xoqS1ZnUMblE+mNe8Y4CMIn13GI3g3
         jlGi4Dr0WA20bTGvSMiqNyiaq+DY4rUfsUHFln1IZsMK5NsAOZNeflEW04Yujvf+XKah
         3bD2jNaiTHf+c51v6zbMBRG3h5vDCcEwTF7NRqAPWIFePLqvJqW9BWP4AGPJ+8KjorBR
         pHtEan77eMmDVzjbZ1DTnVNpHkQAfRczmUHfP+G6SMkvY2qMGGVUO9bPKjAr5KnhLpXz
         +WhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755299343; x=1755904143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42MdIw/zn0IyOrePf8q8Yhtrpa4xzlqA2mTCVTQGHKI=;
        b=iNOb7C/Kr1OfZtvM+x4WhrqyPwF0gWtRYHS2kAbugd50fBWwmOo536Ah/J4ilNwNs0
         xs2BzEoZuI4hr8tvGmGBrBgSHX5JNtImLwNJmmc1cNcGv4doSI9gMmgjsn5Mt48OclOm
         KfxqNUw9n3D3VLqES7K5hE08sFLvoVRsq0pvP4jAydYuFRBaMF+vMoSK4+D+wIyXxrGh
         NGgu7OUU7H+rVp9QU4BKQS6OZ5OUryYqa4SSlV+NnhFyxqSYb800oKfaf2FgPa8fAl5a
         i0pxjn5P1dpEhY7ccSbpBvWMamW5PaqQ6WrurJrcqZ7gzbDcq+BgEwy3xCklfqbe0wnZ
         HlIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC9pGPDSYiPvDYSeME6N/zIEZdutYosBLLJ5avCb7XKtLSrGW7UhUEcDc8xualS/K4wHd7MwOjD1Jdgo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcwAxyoHHNrFpDg6pciBaJQqRVBHAM0kF/VcfNeaeMhoI7hbZm
	3QSpqsFsUckpYF8A6k1Pk4oAqMSlVnlGsKp9cDl9w4jdKtdlW+yyA4JhIUx4dzStAbgpOu9Ozfq
	7R7f+PbdmEKJG9Pke+/ZD9WVc01ZY44Q=
X-Gm-Gg: ASbGncvoOxcNZ5xkzpX1/+BJrMG9oyGAS8P1oC8xWDYLPBKadV8txT4ujrDN8G8uewU
	Iq4kS12E99sZ88RX+9tAY/KRRVzHmsdF/wQaZTNp1dJ5N8zwD9Ig2RBfmcFTkzkLokrp8LKGeQZ
	Uphmk7REI5Ebto1XSC59d7GqUWAgEUVnx73G64mgAWLfR+qXtI2Yk87dLYZgCUAG9Lz4u2fHmgQ
	pnAOww=
X-Google-Smtp-Source: AGHT+IFthbpENU4cR1d+wIfUd2fLqa+M/nb9eoAPF87b/fD4gwDKKoQlmFeYW/ZUpK51HaqrMW1FTYZD29CTtYda3is=
X-Received: by 2002:a05:6e02:1b05:b0:3e5:6bc6:4dcf with SMTP id
 e9e14a558f8ab-3e57e8670damr67303825ab.7.1755299343025; Fri, 15 Aug 2025
 16:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF8kJuN1BH0rqC6czj9govNOugd_5K9ijYcxbWYpEpUdQKn0-A@mail.gmail.com>
 <20250813182024.7250-1-sj@kernel.org> <CAF8kJuONDFj4NAksaR4j_WyDbNwNGYLmTe-o76rqU17La=nkOw@mail.gmail.com>
In-Reply-To: <CAF8kJuONDFj4NAksaR4j_WyDbNwNGYLmTe-o76rqU17La=nkOw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 15 Aug 2025 16:08:50 -0700
X-Gm-Features: Ac12FXyPKTgQ73WeJtuawZdGdFJidghULGlU1JeYubHbQaLPPy9GQfXReZwelH4
Message-ID: <CAKEwX=Mtu3KyNUv_oWFo9vNiWKkmbzMXmG3t=XgpVtG9C_v2mA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: Chris Li <chrisl@kernel.org>
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 3:29=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Wed, Aug 13, 2025 at 11:20=E2=80=AFAM SeongJae Park <sj@kernel.org> wr=
ote:
> >
> > My RFC v1[1] was using a kind of such approach.  I changed it to use zp=
ool
> > starting from RFC v2, following the suggestions from Nhat, Johannes and=
 Joshua.
> > It was suggested to use zpool to reuse its support of migration, highme=
m
> > handling, and stats.  And I agree their suggestions.  David also raised=
 a
> > question on RFC v2, about the movability behavior changes[2].
>
> Thanks for the pointer, that is an interesting read.
>
> > I agree we will get more metadata overhead.  Nonetheless, I argue it is=
 not a
>
> Keep in mind that is more than just metadata. There is another hidden
> overhead of using zpool to store your full page compared to directly
> using the page.  When the page is read, because most likely the zpool
> back end is not at a position aligned to the page. That zpool page
> will not be able to free immediately, those fragmented zpool will need
> to wait for compaction to free. it.

It's been awhile since I last worked on zsmalloc, but IIRC zsmalloc
handles these pages PAGE_SIZE sized object by just handing out a full
page. I skimmed through zsmalloc code, and it seems like for this
size_class, each zspage just contain one base page?

(check out the logic around ZsHugePage and
calculate_zspage_chain_size() in mm/zsmalloc.c. Confusing name, I
know).

So we won't need compaction to get rid of these buffers for
incompressible pages, at free time. There might still be some extra
overhead (metadata), but at least I assume we can free these pages
easily?

>
> > big problem and can be mitigated in writeback-enabled environments.  He=
nce this
> > feature is disabled on writeback-disabled case.  Next paragraph on the =
original
> > cover letter explains my points about this.
> >
> > >
> > > The pros is that, on the page fault, there is no need to allocate a
> > > new page. You can just move the uncompressed_page into the swap_cache=
.
> > > You save one memcpy on the page fault as well. That will make the
> > > incompressible page fault behave very similar to the minor page fault=
.
> >
> > I agree this can save one memcpy, and that's cool idea!  Nonetheless, t=
his
> > patch is not making the [z]swap-in overhead worse.  Rather, this patch =
also
>
> We might still wait to evaluate the lost/gain vs store the
> incompressible in swap cache. Google actually has an internal patch to
> store the incompressible pages in swap cache and move them out of the
> LRU to another already existing list. I can clean it up a bit and send
> it to the list for comparison. This approach will not mess with the
> zswap LRU because the incompressible data is not moving into zswap.
> There is no page fault to handle the incompressible pages.

We can always iterate to get the best of all worlds :) One objective at a t=
ime.

BTW, May I ask - how/when do we move the incompressible pages out of
the "incompressible LRU"? I believe there needs to be some sort of
scanning mechanism to detect dirtying right?

>
> > slightly improve it for incompressible pages case by skipping the
> > decompression.  Also, if we take this way, I think we should also need =
to make
> > a good answer to the zswapped-page migrations etc.
>
> Yes, if we keep the store page in the zswap approach, we might have to
> optimize inside zsmalloc to handle full page storing better.

I believe it already does - check my response above. But I can be wrong.

>
> > So, if we agree on my justification about the metadata overhead, I thin=
k this
> > could be done as a followup work of this patch?
>
> Sure. I am most interested in getting the best overall solution. No
> objects to get it now vs later.

Agree. We can always iterate on solutions. No big deal.

>
> >
> > >
> > > The cons is that, now zpool does not account for uncompressed pages,
> > > on the second thought, that can be a con as well, the page is not
> > > compressed, why should it account as compressed pages?
> >
> > I agree it might look weird.  But, in my humble opinion, in a perspecti=
ve of
> > thinking it as zswap backend storage, and by thinking the definition of
> > compression in a flexible way, this may be understandable and not cause=
 real
> > user problems?
>
> I think the real problem is hiding the real error with non errors like
> data not compressible. If you want to store uncompressed data in the
> zswap layer by design, that is fine. Just need to reason the trade off
> vs other options like store in swap cache etc.
>
> > [...]
> > > >  mm/zswap.c | 36 ++++++++++++++++++++++++++++++++++--
> > > >  1 file changed, 34 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > index 3c0fd8a13718..0fb940d03268 100644
> > > > --- a/mm/zswap.c
> > > > +++ b/mm/zswap.c
> > > > @@ -60,6 +60,8 @@ static u64 zswap_written_back_pages;
> > > >  static u64 zswap_reject_reclaim_fail;
> > > >  /* Store failed due to compression algorithm failure */
> > > >  static u64 zswap_reject_compress_fail;
> > > > +/* Compression into a size of <PAGE_SIZE failed */
> > > > +static u64 zswap_compress_fail;
> > > >  /* Compressed page was too big for the allocator to (optimally) st=
ore */
> > > >  static u64 zswap_reject_compress_poor;
> > > >  /* Load or writeback failed due to decompression failure */
> > > > @@ -976,8 +978,26 @@ static bool zswap_compress(struct page *page, =
struct zswap_entry *entry,
> > > >          */
> > > >         comp_ret =3D crypto_wait_req(crypto_acomp_compress(acomp_ct=
x->req), &acomp_ctx->wait);
> > > >         dlen =3D acomp_ctx->req->dlen;
> > > > -       if (comp_ret)
> > > > -               goto unlock;
> > > > +
> > > > +       /*
> > > > +        * If a page cannot be compressed into a size smaller than =
PAGE_SIZE,
> > > > +        * save the content as is without a compression, to keep th=
e LRU order
> > > > +        * of writebacks.  If writeback is disabled, reject the pag=
e since it
> > > > +        * only adds metadata overhead.  swap_writeout() will put t=
he page back
> > > > +        * to the active LRU list in the case.
> > > > +        */
> > > > +       if (comp_ret || dlen >=3D PAGE_SIZE) {
> > > > +               zswap_compress_fail++;
> > >
> > > I feel that mixing comp_ret and dlen size if tested here complicates
> > > the nested if statement and the behavior as well.
> > > One behavior change is that, if the comp_ret !=3D 0, it means the
> > > compression crypt engine has some error. e.g. have some bad chip
> > > always fail the compression. That is a different error case than the
> > > compression was successful and the compression rate is not good. In
> > > this case the patch makes the page store in zpool for cryto engine
> > > failure, which does not help.
> >
> > I agree the code has rooms to improve, in terms of the readability, and=
 keeping
> > fine grained observailibty.
> >
> > >
> > > Is there any reason you want to store the page in zpool when the
> > > compression engine (not the ratio) fails?
> >
> > The main problem this patch tries to solve is the LRU order corruption.=
  In any
> > case, I want to keep the order if possible.
>
> In that case, does it mean that in order to keep the LRU, you never
> want to write from zswap to a real back end device? That will make
> zswap behave more like a standalone tier.
>
> >
> > >
> > > What do you say about the following alternative, this keeps the
> > > original behavior if compression engines fail.
> > >
> > >      if (comp_ret) {
> > >           zswap_compress_egine_fail++;
> >
> > I agree this counter can be useful.
>
> Ack.
>
> >
> > >           goto unlock;
> >
> > This will make the page go directly to underlying slower swap device, a=
nd hence
> > cause LRU order inversion.  So unfortuately I have to say this is not t=
he
> > behavior I want.
>
> Ack, that is a design choice. I understand now.
>
> >
> > I agree engine failure is not frequent, so this behavior might not real=
ly make
> > problem to me.  But, still I don't see a reason to let the page go dire=
ctly to
> > swap and make LRU order unexpected.
> >
> > >      }
> > >
> > >      if (dlen >=3D PAGE_SIZE) {
> > >         zswap_compress_fail++;
> >
> > I define compress failure here as a failure of attempt to compress the =
given
> > page's content into a size smaller than PAGE_SIZE.  It is a superset in=
cludin.
> > both "ratio" failure and "engine" failure.  Hence I think zswap_compres=
s_fail
> > should be increased even in the upper case.
>
> I slept over it a bit. Now I think we should make this a counter of
> how many uncompressed pages count stored in zswap. Preperbelly as per
> memcg counter.

Actually, yeah I asked about this counter in a review in an earlier
version as well, then I completely forgot about it :)


> I saw that you implement it as a counter in your V1. Does the zsmalloc
> already track this information in the zspool class? Having this per

Kinda sorta. If we build the kernel with CONFIG_ZSMALLOC_STAT, we can
get the number of objects in each size_class.

Each time we read, I believe we have to read every size class though.
So it's kinda annoying. Whereas here, we can just read an atomic
counter? :)

> cgroup information we can evaluate how  much zswap is saving. Some
> jobs like databases might store a lot of hash value and encrypted data
> which is not compressible. In that case, we might just pass the whole

Hmmm actually, this might be a good point. Lemme think about it a bit more.

(but again, worst case scenario, we can send a follow up patch to add
these counters).

> zswap tier as a whole. The overall compression ratio will reflect that
> as well. Having the separate per memcg counter is kind of useful as
> well.
>
> >
> > We can discuss about re-defining and re-naming what each stat means, of=
 course,
> > if you want.  But I think even if we keep the current definitions and n=
ames, we
> > can still get the ratio failures if we add your nicely suggested
> > zswap_compress_engine_fail, as
> > 'zswap_compress_fail - zswap_compress_engine_fail', so we might not rea=
lly need
> > re-definition and re-naming?
>
> I am actually less interested in the absolute failure number which
> keeps increasing, more on how much incompressible zswap is stored.
> That counter + number of engine errors should be perfect.
>
> >
> > >         if (!mem_cgroup_zswap_writeback_enabled(
> > >                                       folio_memcg(page_folio(page))))=
 {
> > >               comp_ret =3D -EINVAL;
> > >               goto unlock;
> > >         }
> > >        dlen =3D PAGE_SIZE;
> > >        dst =3D kmap_local_page(page);
> > >     }
> > >
> > > Overall I feel this alternative is simpler and easier to read.
> >
> > I agree this code is nice to read.  Nonetheless I have to say the behav=
ior is
> > somewhat different from what I want.
>
> Even if you keep the current behavior, you can move the invert the
> test condition and then remove the "else + goto" similar to the above.
> That will make your code less and flatter. I will need to think about
> whether we can assign the return value less.
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
>
> >
> > > I can
> > > be biased towards my own code :-).
> > > I think we should treat the compression engine failure separately fro=
m
> > > the compression rate failure. The engine failure is rare and we shoul=
d
> > > know about it as a real error. The compression rate failure is normal=
.
> >
> > Again, I agree having the observability would be nice.  I can add a new=
 counter
> > for that, like below attached patch, for example.
>
> I would love that. Make that per memcg if possible :-)
>
> >
> > [1] https://lore.kernel.org/20250730234059.4603-1-sj@kernel.org
> > [2] https://lore.kernel.org/761a2899-6fd9-4bfe-aeaf-23bce0baa0f1@redhat=
.com
>
> Thanks for the pointer, good read.
>
> Chris

