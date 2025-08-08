Return-Path: <linux-kernel+bounces-760874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 636DAB1F154
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 01:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ADBA5A1FFB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 23:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E6028EA70;
	Fri,  8 Aug 2025 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpyNAGmk"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E44D28DB7E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 23:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754696249; cv=none; b=i4Pv2f+yZwFTkqD+PETNG1zM1F5jvrEI5u406nurg2mTy7B9bgv6KfBxsZNzusKcuhMAnYXusLL8fjLb76255O1XOurs/Yvr/DE4e9B55p/PqHaJlGECtebmr1Z+mNwIMKVloUIPvsyaIEpLkilhWayp9Qz6G7pFSSq7BjUfAoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754696249; c=relaxed/simple;
	bh=o+hc6tCTJSvzRZd7GGvGeM4KHAQF62TjUekLznCeuns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ky6z7qJPzLNKXNicuxHUf2n37iIA8+jdC1y8xZb/CxGo2jtZo6FpqLuMOy1ZbX30fw7olA34kWl3VJCJ9IFrOncmUl8IE/c7WcvwFovCnfgIZQEY4JJ+hzWhA7q9Ku/AOwmXBG2LstV78xFY5r2Ud1mrJVl+n8EccVrKbgPqAjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpyNAGmk; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-875dd57d63bso71612639f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 16:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754696246; x=1755301046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwyZ0i04JHUSsV1rR+O18SvC1OtKGn9TQc4x0d/NlkM=;
        b=QpyNAGmkRZ06CfFqTaTyFToBpWBqISvFT8yGdiGYAIQfhEIQWpd7F9uVAl5kDryXnP
         eQJp3NYUCdGKzlv85SxEpUGsk7d2L2W0qzbb1agLIK0m7gUSNv06UWYzOHk2dIzZwhga
         zMVlVVSv2zXw4ZRTe1/yTurXU0YdrZb7V7RLvh2m1HbebBabA0vBn23p6PUYrLw9H05A
         oqoPVOI7MlpGX4612ekeijZQ+6EJFxcBHwiA9Ch64t+BrMX4QtTsedRjRMft3on/h7sG
         u+8lMak3UVBifzlWAWWx91CS7VDv5mQk7YIq9BHuzW0Z8xeGlhWukKHJ4oc00Mg/jeVF
         MzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754696246; x=1755301046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwyZ0i04JHUSsV1rR+O18SvC1OtKGn9TQc4x0d/NlkM=;
        b=q7Y6JKmO4UEsPh8vJ/7KIYHoh3icLo6JtiMBQ0MY80lFBhRyKmOPDPCm417yn8vB6X
         jfvQNC/ubjvgs+HWYJZeUSUlZfjuosyztiq/b4PpcMZb5T7LM3vLr2DyWhV8J9ptuMZ2
         qG2UpmjbR7Wt78e8J9eLqf8NU3vIuAA+IYOInVDmZuB/PcAoZ39IjWAUVbldoE1EFSdY
         rEZBkpEea+xAJB06kL9BeZyY1JOz+xv4xTZBsGLNTeLOHciKL5nNK6T9bKUtdkvj1FBi
         nhKwwcZmTUtunZSgYtucSgYcYFG/uxEnqDwguZpPOjZhYi13xCLUm2+z+r/tvvI88Bex
         Pnng==
X-Forwarded-Encrypted: i=1; AJvYcCUDVRiATNW6FcQVbL6bHyz5KKrddPfzN4yLr6F926HxZ2CCSdeuRxMJY802y/szGKs0W//oumOldGVVcFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziaKDXzspa1AwjX05PDLrJXV2v2FRJYhbHJYqN+Ik8VmjUBAz3
	eft63hxfcYiDb2uXTlWb3TzbWT4G4n9CRkOSJq6irr412TPoNugm2ItP813SQZlwTLaVHa+zpt2
	29Rpa+qY9rec/8kaCfT9TGuXybWdClZg=
X-Gm-Gg: ASbGncso+tZiCjA1sXNzC+6FmVDrHaHXz4Ha8pwY3fGdNELmCO9725zsTRat3ghRLnA
	m9qu83w7gvUMVRp4WtieALlNoqqVGeERl6CkPMGWmITO+/qBMm1DFaiGluMbjToaXntqgeH2rCt
	tfmk8PbYJtAjPHUVe/FVUSOn7k5rNCuXz3Vd4d/hGl/rURtYQWHlca1hLTlcW6m5ThWvxvdfoiP
	adHHnE=
X-Google-Smtp-Source: AGHT+IHLaEoTMjMD8pdwPzFLh1E6zMxTpQjSGEy4GPemYztcQ4b1SGs4adIr7g5CA0pDGINZG+M/dm9yG96sxIMnffI=
X-Received: by 2002:a05:6602:2cd6:b0:881:8957:d55e with SMTP id
 ca18e2360f4ac-883e4b1921amr1453030539f.3.1754696246284; Fri, 08 Aug 2025
 16:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKEwX=Nm08xZVR0Zk2fOvXBmeWe5wggvTXN6+hD84S7T9L=eBQ@mail.gmail.com>
 <20250807235427.4743-1-sj@kernel.org>
In-Reply-To: <20250807235427.4743-1-sj@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 8 Aug 2025 16:37:15 -0700
X-Gm-Features: Ac12FXwa-g5rKO_VKfSLJneuBpYcraR2f6GUwJhc5UzCuPKjdW3Oppb4-OVWFbg
Message-ID: <CAKEwX=NF-HBs_sMMm5v82SHFnv5SUrNjOR-=6KJcxQsNt=26Rw@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 4:54=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> On Thu, 7 Aug 2025 16:03:54 -0700 Nhat Pham <nphamcs@gmail.com> wrote:
>
> > On Thu, Aug 7, 2025 at 11:16=E2=80=AFAM SeongJae Park <sj@kernel.org> w=
rote:
> > >
> > > When zswap writeback is enabled and it fails compressing a given page=
,
> > > the page is swapped out to the backing swap device.  This behavior
> > > breaks the zswap's writeback LRU order, and hence users can experienc=
e
> > > unexpected latency spikes.  If the page is compressed without failure=
,
> > > but results in a size of PAGE_SIZE, the LRU order is kept, but the
> > > decompression overhead for loading the page back on the later access =
is
> > > unnecessary.
> >
> > Maybe add the writeback disabled story - we added to get around this
> > latency issue, but that solution was not satisfactory either: wasting
> > cpu cycles retrying incompressible pages, especially when we're under
> > reclaim/memory pressure, and we've reclaimed most if not all other
> > sources.
> >
> > This problem was pointed out by Yosry:
> >
> > https://lore.kernel.org/all/CAJD7tkZXS-UJVAFfvxJ0nNgTzWBiqepPYA4hEozi01=
_qktkitg@mail.gmail.com/
>
> Thank you for sharing the detailed context, I will add this history with =
the
> link to the last paragraph of this section, or the 'Related Works' sectio=
n.
>
> >
> > >
> > > Keep the LRU order and optimize unnecessary decompression overheads i=
n
> > > those cases, by storing the original content as-is in zpool.  The len=
gth
> > > field of zswap_entry will be set appropriately, as PAGE_SIZE,  Hence
> > > whether it is saved as-is or not (whether decompression is unnecessar=
y)
> > > is identified by 'zswap_entry->length =3D PAGE_SIZE'.
> > >
> > > Because the uncompressed data is saved in zpool, same to the compress=
ed
> > > ones, this introduces no change in terms of memory management includi=
ng
> > > movability and migratability of involved pages.
> > >
> > > This change is also not increasing per zswap entry metadata overhead.
> > > But as the number of incompressible pages increases, total zswap
> > > metadata overhead is proportionally increased.  The overhead should n=
ot
> > > be problematic in usual cases, since the zswap metadata for single zs=
wap
> > > entry is much smaller than PAGE_SIZE, and in common zswap use cases
> > > there should be a sufficient amount of compressible pages.  Also it c=
an
> > > be mitigated by the zswap writeback.
> > >
> > > When the writeback is disabled, the additional overhead could be
> > > problematic.  For the case, keep the current behavior that just retur=
ns
> > > the failure and let swap_writeout() put the page back to the active L=
RU
> > > list in the case.  It is known to be suboptimal when the incompressib=
le
> > > pages are cold, since the incompressible pages will continuously be
> > > tried to be zswapped out, and burn CPU cycles for compression attempt=
s
> > > that will anyway fails.  One imaginable solution for the problem is
> > > reusing the swapped-out page and its struct page to store in the zswa=
p
> > > pool.  But that's out of the scope of this patch.
> > >
> > > Tests
> > > -----
> [...]
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -976,8 +976,25 @@ static bool zswap_compress(struct page *page, st=
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
> > > +               if (mem_cgroup_zswap_writeback_enabled(
> > > +                                       folio_memcg(page_folio(page))=
)) {
> > > +                       comp_ret =3D 0;
> > > +                       dlen =3D PAGE_SIZE;
> > > +                       memcpy_from_page(dst, page, 0, dlen);
> >
> > I wonder if we can save one memcpy here. Would it be safe to map the pa=
ge:
> >
> > dst =3D kmap_local_page(page);
>
> Sounds good, I will do so in the next version.
>
> >
> > then, after we're done with storing (i.e after zpool_obj_write()), do:
> >
> > if (dlen =3D PAGE_SIZE)
> >     kunmap(dst);
> >
> > (don't forget to unmap the page in the failure paths too!)
>
> Sure, I think the 'unlock' label would be appropriate part to add the unm=
ap
> code.  I also got your correction of s/kunmap/kunmap_local() in the reply=
.  I
> will not miss that on the next version.
>
> >
> > > +               } else {
> > > +                       comp_ret =3D comp_ret ? : -EINVAL;
> >
> > Does this keep the value of comp_ret if comp_ret !=3D 0 lol.
>
> Yes.
>
> > Syntax
> > looks weird to me.
>
> I agree it could look weird.  I prefer keeping the code in a way more fam=
iliar
> to ones who will keep maintain the file.  So I will modify this as below,=
 in
> the next version.
>
>     comp_ret ? comp_ret : -EINVAL
>
> >
> > > +                       goto unlock;
> > > +               }
> > > +       }
> >
> > Also, can we fix the counter value?
> >
> > I assume we want:
> >
> > else if (comp_ret || dlen =3D PAGE_SIZE)
> >      zswap_reject_compress_fail++;
> >
> > or something like that.
>
> I'm not very clearly getting your point.
>
> I was thinking we should increase the counter if we "reject" the page (do=
es not
> save the content in the zpool) due to failing at compressing the page's c=
ontent
> into a size smaller than PAGE_SIZE.  This patch implements the behavior.
>
> Am I missing a mis-implementation of the behavior in this patch, or the
> behavior is not what you think it should be?  More elaboration of your po=
int
> would be helpful for me.

Ah yeah, maybe "reject compress fail" is not a good name here. But
sometimes I like to know how many times we fail to compress, even if
we do save them.

We can rename it to just "zswap_compress_fail", but that's breaking
API, so it's kind of annoying. Maybe "zswap_stored_uncompressed_pages"
suffices (see comment below).

Johannes, any suggestions on what to do here?

>
> >
> > And what happened to the incompressible page stored counter? :)
>
> I don't get what counter you are asking about.  Could you please elaborat=
e?

I meant "zswap_stored_uncompressed_pages" in your RFC v1.

That could give us a nice breakdown of how much memory in zswap is
actually compressed memory, and how much is uncompressed.

>
> >
> >
> > >
> > >         zpool =3D pool->zpool;
> > >         gfp =3D GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MO=
VABLE;
> > > @@ -1012,6 +1029,14 @@ static bool zswap_decompress(struct zswap_entr=
y *entry, struct folio *folio)
> > >         acomp_ctx =3D acomp_ctx_get_cpu_lock(entry->pool);
> > >         obj =3D zpool_obj_read_begin(zpool, entry->handle, acomp_ctx-=
>buffer);
> > >
> > > +       /* zswap entries of PAGE_SIZE are not compressed. */
> > of length?
>
> Thank you for this nice suggestion, I will change the comment so, in the =
next
> version.
>
> >
> >
> > > +       if (entry->length =3D PAGE_SIZE) {
> > > +               memcpy_to_folio(folio, 0, obj, entry->length);
> > > +               zpool_obj_read_end(zpool, entry->handle, obj);
> > > +               acomp_ctx_put_unlock(acomp_ctx);
> > > +               return true;
> > > +       }
> > > +
> > >         /*
> > >          * zpool_obj_read_begin() might return a kmap address of high=
mem when
> > >          * acomp_ctx->buffer is not used.  However, sg_init_one() doe=
s not
> > >
> > > base-commit: 2ec534125ae474292175ae198483c545eac2161d
> > > --
> > > 2.39.5
> >
>
> Thank you for your nice review and comments :)
>
>
> Thanks,
> SJ

