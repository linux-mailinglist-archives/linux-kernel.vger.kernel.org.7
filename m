Return-Path: <linux-kernel+bounces-788688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5598CB388B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55BD01BA3A51
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4E321FF55;
	Wed, 27 Aug 2025 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXjhO09+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DEC273D68
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756316030; cv=none; b=TfuWuvHLhbvZ4zlS4sMrpXWndjc69IQUwlEHOjHNwaVEoJAQ80qtL9Oo362pDS+z3qUuid1nZDTs8phieJuLSGmfzI4esBeZcVM91rP6rK8iVv3gKYKoKoP/vRRXm82w61wkipFBzjz0h7XqrckH/o7pFCsAHp+SzYpIIeLuNTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756316030; c=relaxed/simple;
	bh=EVBPU9apl1BkDL8t4uJju0JPSLpd9maS1snUonhAoBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HI1s2w95FQvhP6lTXbLzSLf0Ae2tYO0NdWtgc11z+3VPTpAf9W8gPXs08QkQZGRL4hxtH3WdEVzXCkcfm706NQ3T2ITglw+i3CiOtcvd/VHzqj3iERKl8lbe7H51aq91SJavgQQ9UebOaBbHkhOUQswT+474YCQpKaWjIuICqVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXjhO09+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26518C4CEF9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756316030;
	bh=EVBPU9apl1BkDL8t4uJju0JPSLpd9maS1snUonhAoBA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GXjhO09+3U4qHQKiWiUi3kPdPrZRyf5B56r80sk4HgOYq0DjR9QQGl4GXswoTOsbf
	 t0UY6EXIJY5zwK6dhS01iJcDmaCbQpO88X5c7sQ7Vt0oYInSm69rX3FotO1vfX4v/+
	 HW7SCWJgQCp6cEn4VGtYTJvVl73uFJVP/T+HTF8EONRwdlfpnerabHK+jBWjYTsR5l
	 92m6NrkNZ5G9ENObEVxrXUTg8CWxyLnTdvqQlxyVFuk24fku5sSqKYDkzRmPafG1Tz
	 Swem1fZyfT6Qz3jfWAqXXpksQhuLPh3l4dBOfPwFEXmEu73O6FwqNi+RwQGpCJVYzy
	 6yfaZq0mlbOvA==
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-5fb298c0646so107436d50.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:33:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWG533hra8EVcb46fikSHwaiJ9Q02eZuqU2YrzHg7FRa4vFtHgFKQbMI6S31QDNhW+bCCTNdOsPzvHlUI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb6AAXyMkxH6KTah9hH/YNaJGbTRwZjb9QoYd5/7QxJQD6vm4o
	McGY/celqCl2aQfs8MNxgI1JV08UPOI+QpjODRDS/zyp4m05w2nkRQhSv17SbW89UYWcglceEAM
	K0mIZTT6JRxDHWLPHQOIfQfzQEHMeacbmK3vVB6w2aA==
X-Google-Smtp-Source: AGHT+IEMiPV3V9hhvwkvwDuGryQSRjIhpl1wdI7+Gyc3ir83ARdybW32+3r+pDGWHWP3n2/VNhX94ckjaU3rCXB5cJY=
X-Received: by 2002:a05:690c:680e:b0:721:7e7:4e3 with SMTP id
 00721157ae682-72107e73cb3mr137432627b3.50.1756316029331; Wed, 27 Aug 2025
 10:33:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACePvbWGPApYr7G29FzbmWzRw-BJE39WH7kUHSaHs+Lnw8=-qQ@mail.gmail.com>
 <20250827161832.164192-1-sj@kernel.org>
In-Reply-To: <20250827161832.164192-1-sj@kernel.org>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 27 Aug 2025 10:33:38 -0700
X-Gmail-Original-Message-ID: <CACePvbWzyqJJxP8BFXS_NDLcXCz-YXkt8eYBxv3CER9RpnJVXA@mail.gmail.com>
X-Gm-Features: Ac12FXwyaX4frQWFj-XWAIP-VjJ5PLRRBvaeh8PNE9LXCBkL6stycWxrLF0c_gs
Message-ID: <CACePvbWzyqJJxP8BFXS_NDLcXCz-YXkt8eYBxv3CER9RpnJVXA@mail.gmail.com>
Subject: Re: [PATCH v5] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Takero Funaki <flintglass@gmail.com>, David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 9:18=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Tue, 26 Aug 2025 08:52:35 -0700 Chris Li <chrisl@kernel.org> wrote:
>
> > Hi SeongJae,
> >
> > I did another pass review on it. This time with the editor so I saw
> > more source code context and had more feedback.
> > Mostly just nitpicks. See the detailed comments below.
>
> Thank you for your review!

Thank you for the good work.

>
> >
> > On Fri, Aug 22, 2025 at 12:08=E2=80=AFPM SeongJae Park <sj@kernel.org> =
wrote:
> > > @@ -971,8 +975,26 @@ static bool zswap_compress(struct page *page, st=
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
> > > +       if (comp_ret || !dlen)
> > > +               dlen =3D PAGE_SIZE;
> > > +       if (dlen >=3D PAGE_SIZE) {
> >
> > I think these two if can be simplify as:
> >
> > if (comp_ret || !dlen || dlen >=3D PAGE_SIZE) {
> >               dlen =3D PAGE_SIZE;
> >
> > then you do the following check.
> > That way when goto unlock happens, you have dlen =3D PAGE_SIZE related
> > to my other feedback in kunmap_local()
> >
> > > +               if (!mem_cgroup_zswap_writeback_enabled(
> > > +                                       folio_memcg(page_folio(page))=
)) {
> > > +                       comp_ret =3D comp_ret ? comp_ret : -EINVAL;
> > > +                       goto unlock;
> > > +               }
> > > +               comp_ret =3D 0;
> > > +               dlen =3D PAGE_SIZE;
> >
> > Delete this line if you use the above suggestion on: dlen =3D PAGE_SIZE=
;
>
> Thank you for nice suggestion!
>
> >
> > > +               dst =3D kmap_local_page(page);
> > > +       }
> > >
> > >         zpool =3D pool->zpool;
> > >         gfp =3D GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MO=
VABLE;
> > > @@ -985,6 +1007,8 @@ static bool zswap_compress(struct page *page, st=
ruct zswap_entry *entry,
> > >         entry->length =3D dlen;
> > >
> > >  unlock:
> > > +       if (dst !=3D acomp_ctx->buffer)
> > > +               kunmap_local(dst);
> >
> > I think this has a hidden assumption that kmap_local_page() will
> > return a different value than acomp_ctx->buffer. That might be true. I
> > haven't checked the internals. Otherwise you are missing a
> > kunmap_local(). It also looks a bit strange in the sense that
> > kumap_local() should be paired with kmap_local_page() in the same
> > condition. The same condition is not obvious here.
>
> Good point, I agree.
>
> > How about this to
> > make it more obvious and get rid of that assumption above:
> >
> > if (dlen =3D PAGE_SIZE)
> >                kunmap_local(dst);
>
> However, if the execution reached here because compression failed and wri=
teback
> was disabled, kmap_local_page() wouldn't be called, so we could try to un=
map
> unmapped memory.

Ah, thanks for catching that. That is why having more reviewers the
bug can be obvious.

>
> What do you think about adding another bool vairable for recording if
> kunmap_local() need to be executed?  For example,

Sound good.

>
> """
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -952,6 +952,7 @@ static bool zswap_compress(struct page *page, struct =
zswap_entry *entry,
>         struct zpool *zpool;
>         gfp_t gfp;
>         u8 *dst;
> +       bool dst_need_unmap =3D false;

A bit nitpicky. That variable name is too long as a C local variable.
We want local auto variables to be short and sweet. That is why you
have "dst" rather than  "u8 *destination_compressed_buffer;"
The local variable name is too long and it can hurt the reading as well.
Can we have something shorter? e.g. "mapped" or "has_map"

>
>         acomp_ctx =3D acomp_ctx_get_cpu_lock(pool);
>         dst =3D acomp_ctx->buffer;
> @@ -994,6 +995,7 @@ static bool zswap_compress(struct page *page, struct =
zswap_entry *entry,
>                 comp_ret =3D 0;
>                 dlen =3D PAGE_SIZE;
>                 dst =3D kmap_local_page(page);
> +               dst_need_unmap =3D true;
>         }
>
>         zpool =3D pool->zpool;
> @@ -1007,7 +1009,7 @@ static bool zswap_compress(struct page *page, struc=
t zswap_entry *entry,
>         entry->length =3D dlen;
>
>  unlock:
> -       if (dst !=3D acomp_ctx->buffer)
> +       if (dst_need_unmap)
>                 kunmap_local(dst);

Yes, that is good. Make the kmap and kumap very obvious as a pair.

>         if (comp_ret =3D=3D -ENOSPC || alloc_ret =3D=3D -ENOSPC)
>                 zswap_reject_compress_poor++;
> """
>
> >
> > That assumes you also take my suggestion above to assign dlen PAGE_SIZE=
 earlier.
> >
> >
> > >         if (comp_ret =3D -ENOSPC || alloc_ret =3D -ENOSPC)
> > >                 zswap_reject_compress_poor++;
> > >         else if (comp_ret)
> > > @@ -1007,6 +1031,14 @@ static bool zswap_decompress(struct zswap_entr=
y *entry, struct folio *folio)
> > >         acomp_ctx =3D acomp_ctx_get_cpu_lock(entry->pool);
> > >         obj =3D zpool_obj_read_begin(zpool, entry->handle, acomp_ctx-=
>buffer);
> > >
> > > +       /* zswap entries of length PAGE_SIZE are not compressed. */
> > > +       if (entry->length =3D PAGE_SIZE) {
> > > +               memcpy_to_folio(folio, 0, obj, entry->length);
> >
> > The following read_end() followed by acomp unlock() duplicates the
> > normal decompress ending sequence. It will create complications when
> > we modify the normal ending sequence in the future, we need to match
> > it here.How about just goto the ending sequence and share the same
> > return path as normal:
> >
> >  +                  goto read_done;
> >
> > Then insert the read_done label at ending sequence:
> >
> >         dlen =3D acomp_ctx->req->dlen;
> >
> > + read_done:
> >         zpool_obj_read_end(zpool, entry->handle, obj);
> >         acomp_ctx_put_unlock(acomp_ctx);
>
> I agree your concern and this looks good to me :)
>
> >
> > If you adopt that, you also will need to init the comp_ret to "0"
> > instead of no init value in the beginning of the function:
> >
> >         struct crypto_acomp_ctx *acomp_ctx;
> > -        int decomp_ret, dlen;
> > +       int decomp_ret =3D 0, dlen;
> >         u8 *src, *obj;
>
> We may also need to initialize 'dlen' as PAGE_SIZE ?

If there is a code path can lead to dlen use not initialized value? If
not then we don't have to assign it.

> >
> >
> > > +               zpool_obj_read_end(zpool, entry->handle, obj);
> > > +               acomp_ctx_put_unlock(acomp_ctx);
> > > +               return true;
> >
> > Delete the above 3 lines inside uncompress if case.
> >
> > Looks good otherwise.
> >
> > Thanks for the good work.
>
> Thank you for your kind review and nice suggestions!  Since the change is
> simple, I will post a fixup patch as reply to this, for adopting your
> suggestions with my additional changes (adding dst_need_unmap bool variab=
le on
> zswap_compress(), and initializing dlen on zswap_decompress()) if you hav=
e no
> objection or different suggestions for the my addition of the changes.  P=
lease
> let me know if you have any concern or other suggestions for my suggested
> additional changes.

I am fine with a fix up patch or a new version. Does not matter to me
in the slightest. I care more about the final landing code itself more
than which vehicle to carry the code.  Assume you do all those fix up
you mention above, you can have my Ack in your fix up:

Acked-by: Chris Li <chrisl@kernel.org>

Chris

