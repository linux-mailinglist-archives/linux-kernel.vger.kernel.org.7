Return-Path: <linux-kernel+bounces-879570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A45CC237D1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 967AC4E7AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8E030F951;
	Fri, 31 Oct 2025 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkuCyVFk"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2CB2D6619
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761894165; cv=none; b=HXTMw256lNdYpzV8HnnvCK69rykezy6AzprV9ndDSyGwuQOXPhXJN7odFw5jGTMmK8enTtRm6nctwB6XDozjMIDJ4oHNnPQgB93RZyrKCn4LS+GpeB0J5T1KKMG9rSKXzxyLGo/WgvFyFqXloEwrseY+SvezL/uH+F2C19q/Km0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761894165; c=relaxed/simple;
	bh=En5rIQ21anIy/mSulOiTAMLDn3w2TLh50sdA6UJyo1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+GPCOTzfxtS2M4A69cwzp1MluenEd1OM6t43yfpFqgtUD2HnQD7oYp4lzCmnHNj1qfs8YlcYYFfehyykXzs1ttHCiyXeqYoLDnULfLmrTTatdGO1gLfLdKmzbSGQecpfLKeKqAxeAMJNPsTtriGrDcAeWCeq6sjpKurGIYXU54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkuCyVFk; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b6d5c59f2b6so486931466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761894162; x=1762498962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhAeKXrpaYinKlRLqV0x2Ic6a8e7XLvoSE3cJgvPELQ=;
        b=YkuCyVFkQAjFNmWze8xcD5NPs492WmWT4UgvwQU8DEkEp89A6yjUdkbO43ebtpy7uS
         amqktgIe6jQhudUJbT2b0cwiedtRFG0AdjrVd43DWZtFAxO0mhVxWmYlNVdURv9kFfSx
         IOuGciEN+6eyb2lpsPzkjeq3wl/WYBqtvr6iLG9QRnKNk+F3pu6NqkniNIJ12DFE1Kbn
         b9H/qJvLqhR36TJ9V3g4G72EwXWTJXJJle75V7lMXeDf4CuO6c4ANLntRcdSn8AIQYnx
         1fHF97pGir77RzcrECAi/+UDkihEpkc/WC8jRXOB3ldjAU/7wyFnpXblwQAP0G9kjEsI
         iwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761894162; x=1762498962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhAeKXrpaYinKlRLqV0x2Ic6a8e7XLvoSE3cJgvPELQ=;
        b=oI5+GgvvSDOlRPvOTJmh+e6vgY8NzCu1loyukezyPIdPmp5VP5aTJsqaUQg+eZZn8V
         J4GcM8RPfCTanOxzSBGEVDO6v02UPcJbJGArgm1xl7hWPXfo5KR6tNbwNuxVhFQxFX86
         7509aDj0JKq3CU4yKPyzwqsjqv7pKO82dMOlqJmeNb8q9LjwzQG+VgMNAV8nR7/sp5AD
         4NL/HwYhqotXJE8UpsOtqEg0pYiF/m/bZh+Uwf6GXTbN4Rk+S/a1Sv3eSWOQYEUodMaD
         WcMv2Rwu31EIpu4vH4g+hxhvmDpFWu8m5s8eHctnsTrP30XEE1dZDmeOFKwH+6slcm9i
         4ySQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhitG/HWMdgJAJZnO2Iv6c19tboAlSSPXLGM9ubSjQY5bL9BoxVOgt7BhMFL8D2c60cOlbfrLqsIeHE5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy48CVloE7pH2u5hfGiFX1NBJNzHb+042JAPj75ldxn1M4sS500
	Urlrw9uSoMYKK17HJNzZFpUKGwRWP6x0HtjyTxWJK4McGpFEEOQA6H3VW8a2NSLVSdPYydMESfB
	fJGz6vZeEzLL479yyhYEiBy+SG9/3XKg=
X-Gm-Gg: ASbGnctYPaSvgYR/jdWHWerF34UqUI88YPewxSip/wQ5SfOYkI17RepKFwnmHEJnIWt
	cnG2tJ2DOuFMEHScTi3aCIQyMCpt0BSjSaNRRTwM8MtCTNJdzcDWYA37+ZOSdcOQPG+kAV8uq5f
	rfnEXrsQB36yVSbmClcrNzcG3oGZyCz5za+d7cuw4rdS8Rhao4jWaf6gbL6Zo+A5P700wiDZ7tm
	uTqdTaM9KQHMHoyfjQjyDjCM9Jz42qFdPK2R3rSc5eBafyd+XH6wSsm3qIE
X-Google-Smtp-Source: AGHT+IFZjqoXBFAlCskVhv74Qiczd37Jbq68RIzzKDrsnIw2gYEJV4GzWhwphPsEr9Q6jQ41UmUSm4dBiWwOuSzsAr4=
X-Received: by 2002:a17:907:60cd:b0:b3f:1028:a86a with SMTP id
 a640c23a62f3a-b70700d39cbmr242298666b.3.1761894161735; Fri, 31 Oct 2025
 00:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
 <20251029-swap-table-p2-v1-15-3d43f3b6ec32@tencent.com> <aQRPfIqCcMLyf6oX@yjaykim-PowerEdge-T330>
In-Reply-To: <aQRPfIqCcMLyf6oX@yjaykim-PowerEdge-T330>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 31 Oct 2025 15:02:04 +0800
X-Gm-Features: AWmQ_bnqHJRBw5VgM4IaGt3qE5NKaN--3DSsoGj--BQ80I3X1ms69ibY_wiId_Y
Message-ID: <CAMgjq7A405kAAY80xzLxFHuKOcGt7iSYeYYv9G0iZaMHcwrWyA@mail.gmail.com>
Subject: Re: [PATCH 15/19] mm, swap: add folio to swap cache directly on allocation
To: YoungJun Park <youngjun.park@lge.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 1:56=E2=80=AFPM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> On Wed, Oct 29, 2025 at 11:58:41PM +0800, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
>
> Hello Kairui
>
> > The allocator uses SWAP_HAS_CACHE to pin a swap slot upon allocation.
> > SWAP_HAS_CACHE is being deprecated as it caused a lot of confusion.
> > This pinning usage here can be dropped by adding the folio to swap
> > cache directly on allocation.
> >
> > All swap allocations are folio-based now (except for hibernation), so
> > the swap allocator can always take the folio as the parameter. And now
> > both swap cache (swap table) and swap map are protected by the cluster
> > lock, scanning the map and inserting the folio can be done in the same
> > critical section. This eliminates the time window that a slot is pinned
> > by SWAP_HAS_CACHE, but it has no cache, and avoids touching the lock
> > multiple times.
> >
> > This is both a cleanup and an optimization.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  include/linux/swap.h |   5 --
> >  mm/swap.h            |   8 +--
> >  mm/swap_state.c      |  56 +++++++++++-------
> >  mm/swapfile.c        | 161 +++++++++++++++++++++----------------------=
--------
> >  4 files changed, 105 insertions(+), 125 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index ac3caa4c6999..4b4b81fbc6a3 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -452,7 +452,6 @@ static inline long get_nr_swap_pages(void)
> >  }
> >
> >  extern void si_swapinfo(struct sysinfo *);
> > -void put_swap_folio(struct folio *folio, swp_entry_t entry);
> >  extern int add_swap_count_continuation(swp_entry_t, gfp_t);
> >  int swap_type_of(dev_t device, sector_t offset);
> >  int find_first_swap(dev_t *device);
> > @@ -534,10 +533,6 @@ static inline void swap_put_entries_direct(swp_ent=
ry_t ent, int nr)
> >  {
> >  }
> >
> > -static inline void put_swap_folio(struct folio *folio, swp_entry_t swp=
)
> > -{
> > -}
> > -
> >  static inline int __swap_count(swp_entry_t entry)
> >  {
> >       return 0;
> > diff --git a/mm/swap.h b/mm/swap.h
> > index 74c61129d7b7..03694ffa662f 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -277,13 +277,13 @@ void __swapcache_clear_cached(struct swap_info_st=
ruct *si,
> >   */
> >  struct folio *swap_cache_get_folio(swp_entry_t entry);
> >  void *swap_cache_get_shadow(swp_entry_t entry);
> > -int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
> > -                      void **shadow, bool alloc);
> >  void swap_cache_del_folio(struct folio *folio);
> >  struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_flag=
s,
> >                                    struct mempolicy *mpol, pgoff_t ilx,
> >                                    bool *alloced);
> >  /* Below helpers require the caller to lock and pass in the swap clust=
er. */
> > +void __swap_cache_add_folio(struct swap_cluster_info *ci,
> > +                         struct folio *folio, swp_entry_t entry);
> >  void __swap_cache_del_folio(struct swap_cluster_info *ci,
> >                           struct folio *folio, swp_entry_t entry, void =
*shadow);
> >  void __swap_cache_replace_folio(struct swap_cluster_info *ci,
> > @@ -459,8 +459,8 @@ static inline void *swap_cache_get_shadow(swp_entry=
_t entry)
> >       return NULL;
> >  }
> >
> > -static inline int swap_cache_add_folio(struct folio *folio, swp_entry_=
t entry,
> > -                                    void **shadow, bool alloc)
> > +static inline void *__swap_cache_add_folio(struct swap_cluster_info *c=
i,
> > +             struct folio *folio, swp_entry_t entry)
> >  {
> >  }
>
> Just a nit,
> void* return nothing.
>
> changed to void (original function prototype is return void)
> or how about just remove If this is not used on !CONFIG_SWAP

Thanks! Yeah it can be just removed, no one is using it when
!CONFIG_SWAP after this commit. Will clean it up.

>
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index d2bcca92b6e0..85d9f99c384f 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -122,6 +122,34 @@ void *swap_cache_get_shadow(swp_entry_t entry)
> >       return NULL;
> >  }
> >
> > +void __swap_cache_add_folio(struct swap_cluster_info *ci,
> > +                         struct folio *folio, swp_entry_t entry)
> > +{
> > +     unsigned long new_tb;
> > +     unsigned int ci_start, ci_off, ci_end;
> > +     unsigned long nr_pages =3D folio_nr_pages(folio);
> > +
> > +     VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> > +     VM_WARN_ON_ONCE_FOLIO(folio_test_swapcache(folio), folio);
> > +     VM_WARN_ON_ONCE_FOLIO(!folio_test_swapbacked(folio), folio);
> > +
> > +     new_tb =3D folio_to_swp_tb(folio);
> > +     ci_start =3D swp_cluster_offset(entry);
> > +     ci_off =3D ci_start;
> > +     ci_end =3D ci_start + nr_pages;
> > +     do {
> > +             VM_WARN_ON_ONCE(swp_tb_is_folio(__swap_table_get(ci, ci_o=
ff)));
> > +             __swap_table_set(ci, ci_off, new_tb);
> > +     } while (++ci_off < ci_end);
> > +
> > +     folio_ref_add(folio, nr_pages);
> > +     folio_set_swapcache(folio);
> > +     folio->swap =3D entry;
> > +
> > +     node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
> > +     lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
> > +}
> > +
> >  /**
> >   * swap_cache_add_folio - Add a folio into the swap cache.
> >   * @folio: The folio to be added.
> > @@ -136,23 +164,18 @@ void *swap_cache_get_shadow(swp_entry_t entry)
> >   * The caller also needs to update the corresponding swap_map slots wi=
th
> >   * SWAP_HAS_CACHE bit to avoid race or conflict.
> >   */
> > -int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
> > -                      void **shadowp, bool alloc)
> > +static int swap_cache_add_folio(struct folio *folio, swp_entry_t entry=
,
> > +                             void **shadowp)
>
> It is also a small thing.
> "alloc" parameter removed then the comment might be updated.

Nice suggestion, will cleanup the comment too.

>
> Thanks,
> Youngjun Park
>

