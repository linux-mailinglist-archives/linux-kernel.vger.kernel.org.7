Return-Path: <linux-kernel+bounces-804072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84642B4697C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 08:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E867B8BB4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B638324C68B;
	Sat,  6 Sep 2025 06:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9crIOPE"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498C617E4
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 06:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757140370; cv=none; b=NyNcYZxk7tEfGrGoVy3hZkshNqMBNeXV5iN/MUPiVngn901UAitHJT2Sjp9KJOvEzIx1Ph67utn0QUorTnb0/X4ULtjN2zyLsXE0aWPCCXpUKUtF2WP+pvh4Rw5prRBGKcUiROU6YlplrU+JgqdRRwJHceNB5k1Mknd7/wbUIKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757140370; c=relaxed/simple;
	bh=mWQA6GP7HKSLLLXih1LYi90XBC5UCgUKXznyzxB0/k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJxsGtdNqWU9My+5aYRZMp2MzoJWR7KPtiuZYyZrk73lP5IZu9cOLdJNOR0ka9BpbYkU3oPDHxspZpc70qUY4NQNtyGxJxo81BfNOqL/ehvh69AIzw+2MaU8r4/i5vmbeUe+5M6zquTD2YeXVyYD1OXGmGqeZ/Kc6MLoNPCUwcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9crIOPE; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so3300313a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 23:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757140366; x=1757745166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kK5t+pdYQgl9moKxVuT5DIsEPulHjxs1HUx0Nbs+gs=;
        b=V9crIOPEXDiiMF1YPC0KAokkeBhuMI17e9SXfnIOwIB3kSFvu3c7RcuIZVxRejdUK/
         5b88h2ARSTEvRez0bFqnORRCVickTUjVAc3hITV5Wq5ilS3+lbb1r93iixoUsgyTM6F2
         5dwnKOGLDwvTDl33NgMv4Ny6GpMQ74V/bvs5kBhH52C06Qo5ADXM4fhXPKOcAZMaEDTp
         fKDYBspfhXrYJQttSJ1NED2VpqY6RQsSi5rBm1dbzMYBf0DHeTPA6sPTO/9ogXzzxTEp
         62O6nhuvVErLvbPMFkVhhoub0yOOicrOlqFzOgxhXJdg48jnILVgyhgxKkzwmulVvwHL
         dgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757140366; x=1757745166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kK5t+pdYQgl9moKxVuT5DIsEPulHjxs1HUx0Nbs+gs=;
        b=LS1UbtTLHI62bs5pWGblh9kVWJmt471PqOYx3zqnV+hTSnxJo8XreKHwJE5ywpEc1K
         QWKRFN2lqvfOae/sSbb0ilUNKC1sp2dtGkaaVIF9hfTAKOgA5+0bKzAh1xD90Bjf8FDC
         +JZF1HSOkra1ZtZyvXv76XgT26VjZh5GJdf5BiUP3xW8fmXBFWN40Cqu5C0jtPkczkLR
         bvGaavyhIm0w7/6/bo5/7i5+8cL2EdGL8i9PE5BQQAKWItm+pOspLRqN+AZ3daHd/8XU
         qrB18Gyp8Nw1L/f157/YV3/aet/ubcoX1SVIvNJPxduT9KFTcsfT7WzWVo1TKYEleU6Q
         Nzvg==
X-Forwarded-Encrypted: i=1; AJvYcCWuDY5sGsO2aQPQDDOvQxZWga7/gtmnaoG1vAVgBe0wC3S/Vg6Qe2QLiRfijZFEr49qovHZ9PHfVxzw63Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN8qSebWGtGrVwhVpoDAk1rPViZAqTKXPXNETrHM08teSciULS
	mjggc84PIfvucjo1XyZtql+f5R7SM/7JCFT+j7k68GSATWMEYvcM0S6WoYm84xlqgHeZXvqaffd
	8GJR0CZ3xUb0ZRbd0L7BlZ1ckftv1LWA=
X-Gm-Gg: ASbGncuutxylctA5ZbEibwwHMgBtHgQNO3OQC6nHDGF/jZK+ROHAHe9rP/W7lw3k+eb
	VNbjxGh4F9T/9KBrpPDXgaBBA9ESqhCs6VhUUSo6vOa6ou3nq+8a7SrvtA+Io1olOGyztzF3Xb3
	1/cApVHsthhDhTsCX7QOy1Z8vyNWKzoyI3xQlPF7Dt8aAQfz+Z6QwRWuMyHIe8e3NnQIJcRkAJ7
	u3rFtNWU9sqgaBtrxBUKg==
X-Google-Smtp-Source: AGHT+IGZNDdkma+UR16y6zplIu4ueK4Pamyx6VF+j01x7vICoEVtRmcp7DWVNtzU2Xbnd8nWKOnwDIdltdp9Fb9DRhs=
X-Received: by 2002:a05:6402:4308:b0:61d:6bf:12d with SMTP id
 4fb4d7f45d1cf-623783645bcmr1473765a12.26.1757140366516; Fri, 05 Sep 2025
 23:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-6-ryncsn@gmail.com>
 <CAF8kJuM1Qjq2QjX-=XiUZ3EATPcX8wY0_COdce+Zf8nb=1v8Aw@mail.gmail.com>
In-Reply-To: <CAF8kJuM1Qjq2QjX-=XiUZ3EATPcX8wY0_COdce+Zf8nb=1v8Aw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 6 Sep 2025 14:32:10 +0800
X-Gm-Features: Ac12FXxno4Q-NpwwKgRz1yo_NwUomWZKwH5I0eRlSUqSUkTlzqqlpVCECnitMLs
Message-ID: <CAMgjq7CD73QJFSna4gNuDBGiFnVVjiOJv0O1Yh=8q94SXaAMHg@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] mm, swap: always lock and check the swap cache
 folio before use
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 11:51=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> Looks correct to me.
>
> Acked-by: Chris Li <chrisl@kernel.org>

Thanks.

>
> With some nitpick follows,
>
> On Fri, Sep 5, 2025 at 12:14=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Swap cache lookup only increases the reference count of the returned
> > folio. That's not enough to ensure a folio is stable in the swap
> > cache, so the folio could be removed from the swap cache at any
> > time. The caller should always lock and check the folio before using it=
.
> >
> > We have just documented this in kerneldoc, now introduce a helper for s=
wap
> > cache folio verification with proper sanity checks.
> >
> > Also, sanitize a few current users to use this convention and the new
> > helper for easier debugging. They were not having observable problems
> > yet, only trivial issues like wasted CPU cycles on swapoff or
> > reclaiming. They would fail in some other way, but it is still better t=
o
> > always follow this convention to make things robust and make later
> > commits easier to do.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/memory.c     |  3 +--
> >  mm/swap.h       | 24 ++++++++++++++++++++++++
> >  mm/swap_state.c |  7 +++++--
> >  mm/swapfile.c   | 10 +++++++---
> >  4 files changed, 37 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 94a5928e8ace..5808c4ef21b3 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4748,8 +4748,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                  * swapcache, we need to check that the page's swap has=
 not
> >                  * changed.
> >                  */
> > -               if (unlikely(!folio_test_swapcache(folio) ||
> > -                            page_swap_entry(page).val !=3D entry.val))
> > +               if (unlikely(!folio_matches_swap_entry(folio, entry)))
> >                         goto out_page;
> >
> >                 if (unlikely(PageHWPoison(page))) {
> > diff --git a/mm/swap.h b/mm/swap.h
> > index efb6d7ff9f30..a69e18b12b45 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -52,6 +52,25 @@ static inline pgoff_t swap_cache_index(swp_entry_t e=
ntry)
> >         return swp_offset(entry) & SWAP_ADDRESS_SPACE_MASK;
> >  }
> >
> > +/**
> > + * folio_matches_swap_entry - Check if a folio matches a given swap en=
try.
> > + * @folio: The folio.
> > + * @entry: The swap entry to check against.
> > + *
> > + * Context: The caller should have the folio locked to ensure it's sta=
ble
> > + * and nothing will move it in or out of the swap cache.
> > + * Return: true or false.
> > + */
> > +static inline bool folio_matches_swap_entry(const struct folio *folio,
> > +                                           swp_entry_t entry)
> > +{
> > +       VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> > +       if (!folio_test_swapcache(folio))
> > +               return false;
> > +       VM_WARN_ON_ONCE_FOLIO(!IS_ALIGNED(folio->swap.val, folio_nr_pag=
es(folio)), folio);
>
> You should cache the folio->swap.val into a local register value.
> Because WARN_ON_ONCE I think the compiler has no choice but to load it
> twice? Haven't verified it myself.
>
> There is no downside in compiler point of view using more local
> variables, the compiler generates an internal version of the local
> variable equivalent anyway.
>
> > +       return folio->swap.val =3D=3D round_down(entry.val, folio_nr_pa=
ges(folio));
>
> Same for folio_nr_pages(folio), you should cache it. The function will
> look less busy.

That's a very good idea, that should also reduce line length so it is
easier to read.

