Return-Path: <linux-kernel+bounces-771648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A11BB28A0A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 04:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7511B61721
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 02:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC3317A31C;
	Sat, 16 Aug 2025 02:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlpH8rwG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C3E1537A7
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755310848; cv=none; b=JCDkzD6gcEyGLrnbLteWCwidgUW/UIJwrg+JnvRCKk6dH9I4UB9J3467GRqe9jt2OtEv846pehFnnDlBvXS8DAdltnSFBldtgqbZQ6fed6d1mFEFb+lNS5z6erDJR+GWiWZhg4NuyIgcWLKv1ICdni47t7ToojYkHkh/BhAes8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755310848; c=relaxed/simple;
	bh=SGP/fnSCgeDrRBCJO4AxUNkfcTT5VHchj3PQZX6+SoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SeKvHbPLbrA3qEQoqufMIPbAjOnJbugU+bH/hT9vNK3GDL/CNecIeSUgsvB7lDXTNywaVFd7bpjL3G8jGGgb4FhkP0JoyWq8YcOa1EeIjunKn6OloPsiWsRuMqTKFXQ/zhpQJiBv+Fdnm84zpJgHHvaSeNnEHB3W30VubnTM/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlpH8rwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69484C4CEF8
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 02:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755310848;
	bh=SGP/fnSCgeDrRBCJO4AxUNkfcTT5VHchj3PQZX6+SoI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SlpH8rwGfZmq1rsYwCEDX/y3S6Bg++0fAFyL5W6AMgQzCJADdw3+JgB6z5XmicJu3
	 OKTwjirei0mYZHauKG0+bsusQimCo9/GrMjVqMZ3+da7ETfsqIOVo7d0tUexPKzudX
	 reRIg2Qd73Hm70BWHCgYsTjE5OAiuJg9+anx5T6edIt7dFUj5CxQOT0tiTSVH1xOYo
	 6SlT4QO9543KVw4SZnHPb83Bz37a1vY43kL9oA8qWJDpCn0K8HO3BLMBfOl+0INb2q
	 6hOL1zF3uAiekY/b8l+AEEc4ev3O8f6gr4oCvvdDZcw42TE7qcFOI++9g1S724wK3J
	 6oFRg2R+B3Miw==
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-459fc779bc3so19985e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:20:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+AHI0AHmNPbAqS7rvh+xB60ck2Grcra+8zaxGOv41S2qcRc/r4QSkF8en4FjCKxCmQjV5Kjxs4rQjAZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+jcHBPuOjD/BGpaR89D/mfipjutr7vYD5WCDX8jQN28wa7wO
	yaq2/xo0JxUIzTyb8BFrermT4ZPpVp34txOdqcfexGf9Dco7I4x/BPGD0qMHoq+56xqS8fwvLU4
	G3o5XhoqgyuCAdUuGBRsnbxEntwJPcduyd28MCTg8
X-Google-Smtp-Source: AGHT+IH5zqxe1aaCsBoZQqi76wgzYFtwhUIpz+xeDSd+aOqoxBLhFMgIfQ154Frn0hicQZC9eQkV1VxpiUnKJwpwCJI=
X-Received: by 2002:a05:600c:a20e:b0:455:fd3e:4e12 with SMTP id
 5b1f17b1804b1-45a26807ba9mr488595e9.4.1755310847084; Fri, 15 Aug 2025
 19:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF8kJuONDFj4NAksaR4j_WyDbNwNGYLmTe-o76rqU17La=nkOw@mail.gmail.com>
 <20250816000701.90784-1-sj@kernel.org>
In-Reply-To: <20250816000701.90784-1-sj@kernel.org>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 15 Aug 2025 19:20:35 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPCpnGAoz=1CBwe46ytpcR0ZUMAEWLFQce7eUWkb+0ERA@mail.gmail.com>
X-Gm-Features: Ac12FXybK7JLuVGm3itlsErVBVgF4jw7_rgwetALj8CISghHRKHNQTYxpGNpQPA
Message-ID: <CAF8kJuPCpnGAoz=1CBwe46ytpcR0ZUMAEWLFQce7eUWkb+0ERA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Takero Funaki <flintglass@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 5:07=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Fri, 15 Aug 2025 15:28:59 -0700 Chris Li <chrisl@kernel.org> wrote:
> > Sure. I am most interested in getting the best overall solution. No
> > objects to get it now vs later.
>
> Thank you for being flexible, Chris.  I'm also looking forward to keep
> collaborating with you on the followup works!

Likewise.

>
> [...]
> > > > Is there any reason you want to store the page in zpool when the
> > > > compression engine (not the ratio) fails?
> > >
> > > The main problem this patch tries to solve is the LRU order corruptio=
n.  In any
> > > case, I want to keep the order if possible.
> >
> > In that case, does it mean that in order to keep the LRU, you never
> > want to write from zswap to a real back end device?
>
> Not always, but until we have to write back zswapped pages to real back e=
nd
> deevice, and all zswapped pages of lower LRU-order are already wrote back=
.

I see, that makes sense. Only writers to the lower tier while
maintaining LRU order.
Thanks for the explanation. I can see the bigger picture now.

> > I slept over it a bit. Now I think we should make this a counter of
> > how many uncompressed pages count stored in zswap. Preperbelly as per
> > memcg counter.
>
> I agree that could be useful.  I will add the counter in the next version=
 (v4).
> But making it for each memcg may be out of the scope of this patch, in my
> opinion.  Would you mind doing per-memcg counter implementation as a foll=
owup?

No objections. If the incompressible page count is very bad, it will
drag down the overall compression ratio as well. So we do have some
per memcg signal to pick it up. The trade off is how complex we want
to go for those marginal finer grain measurements.

> > I saw that you implement it as a counter in your V1.
>
> Yes, though it was only for internal usage and therefore not exposed to t=
he
> user space.  I will make it again and expose to the user space via debugf=
s.
> Say, stored_uncompressed_pages?

I am not very good at naming either. Maybe
"stored_incompressible_pages"? Uncompressed pages are the resulting
state, it sounds like we choose to store them uncompressed. The root
cause is that those pages are incompressible. That is the nature of
the page,  we don't have a choice to compress them.

>
> > Does the zsmalloc
> > already track this information in the zspool class?
>
> zsmalloc provides such information when CONFIG_ZSMALLOC_STAT is enabled, =
to my
> understanding.

Thanks. I think that is likely global not per memcg.

>
> [...]
> > I am actually less interested in the absolute failure number which
> > keeps increasing, more on how much incompressible zswap is stored.
> > That counter + number of engine errors should be perfect.
>
> Sounds good.  So the next version (v4) of this patch will provide two new
> debugfs counters, namely compress_engine_fail, and stored_uncompressed_pa=
ges.

Sounds good. Maybe "crypto_compress_fail", the engine is the common
name as I call it. Here the engine refers to the crypto library so
"crypto_compress_fail" matches the code better.

>
> [...]
> > > I agree this code is nice to read.  Nonetheless I have to say the beh=
avior is
> > > somewhat different from what I want.
> >
> > Even if you keep the current behavior, you can move the invert the
> > test condition and then remove the "else + goto" similar to the above.
> > That will make your code less and flatter. I will need to think about
> > whether we can assign the return value less.
>
> Nice idea.  What about below?
>
>         if (comp_ret) {

You can consider adding (comp_ret || !dlen) , because if dlen =3D=3D 0,
something is seriously wrong with the compression, that is a real
error.

>                 zswap_compress_engine_fail++;
>                 dlen =3D PAGE_SIZE;
>         }
>         if (dlen >=3D PAGE_SIZE) {
>                 zswap_compress_fail++;
>                 if (!mem_cgroup_zswap_writeback_enabled(
>                                         folio_memcg(page_folio(page)))) {
>                         comp_ret =3D -EINVAL;
>                         goto unlock;
>                 }
>                 comp_ret =3D 0;
>                 dlen =3D PAGE_SIZE;
>                 dst =3D kmap_local_page(page);
>         }

Looks very good to me. Much cleaner than the V2. Thanks for adopting that.

> > Another point I would like to make is that you currently make the cut
> > off threshold as page size. The ideal threshold might be something
> > slightly smaller than page size. The reason is that the zsmalloc has a
> > fixed size chuck to store it. If your page is close to full, it will
> > store the data in the same class as the full page. You are not gaining
> > anything from zsmalloc if the store page compression ratio is 95%.
> > That 5% will be in the waste in the zsmalloc class fragment anyway. So
> > the trade off is, decompress 95% of a page vs memcpy 100% of a page.
> > It is likely memcpy 100% is faster. I don't know the exact ideal cut
> > off of threshold. If I had to guess, I would guess below 90%.
>
> Agreed, this could be another nice followup work to do.

Ack.

>
> >
> > >
> > > > I can
> > > > be biased towards my own code :-).
> > > > I think we should treat the compression engine failure separately f=
rom
> > > > the compression rate failure. The engine failure is rare and we sho=
uld
> > > > know about it as a real error. The compression rate failure is norm=
al.
> > >
> > > Again, I agree having the observability would be nice.  I can add a n=
ew counter
> > > for that, like below attached patch, for example.
> >
> > I would love that. Make that per memcg if possible :-)
>
> As mentioned above, I would like to make only a global counter on debugfs=
 for
> now, if you don't mind.  Let me know if you mind.

I don't mind. We can take the incremental approach.

Chris

