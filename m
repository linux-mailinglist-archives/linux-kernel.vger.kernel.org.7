Return-Path: <linux-kernel+bounces-854485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 076BCBDE7F2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFE7A4E5CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81D91A38F9;
	Wed, 15 Oct 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="SwIkVUCO"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00E717C220
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531825; cv=none; b=EZjzm+z07cpxJd7r56P0zPkxsdcAcuOdJISK2yUwcJ/6MaYypIIIWYdRwMwslr/nGXXRdW4MfLW8pc/SJWj1gSZzusMdV97o0+Dvr/gbjhU3MAPe9zkvNDKsFDOUXSMdCDQMow3CpIA1atTikl4XiXEZ1Kjps6wrVu6+ntg4Wi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531825; c=relaxed/simple;
	bh=cZWQFWkqXSzxQIAOS5/0Tl7zL5qo9QseMzuk922DgLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z96Cb3x6pfLT6Vi0HTLlPJBTRS1aSaL4NKENCs4bqHBZ9KItR1+YAogAJGPAc+97Howo0Xu4+OB9MDHrAwNXkCuSQ0grHiJk47Apf/3Wm7NFSdPNriHIaRwrLzTcU6pFAcpZ0lvs2Vd9w4X5l9JO1Rft0DgBZcueWh0N0Sx3qck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=SwIkVUCO; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b4539dddd99so419974666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760531822; x=1761136622; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b8E+MJevdLFCHBwF7mS7GoEuKQlVbSLU5v6n96OsPT4=;
        b=SwIkVUCOhKFEqwQn2FTeNcmu7S/vPdvLcIu4QzVAvGULFgCainQ5FX4nPWyfLikVt0
         7v/SXoIiV9OR9Gde8DfhUx08SGyPkDK+4UtPkFM4b2dyYNIIHkAEg1lv56yoN23GPjQz
         Ocic5d71Wy1RUx4QvPNBHNnwVMiDOxuDeWwhASO0IRTtyuTdEHkDDDcVCi2wvWWWE1ss
         Q/TzPkpg+Lt5BodpDA87pbtr+vPkLLeO2YOlCdLYkaKNst9LEog4N2n55deQeK1q/+69
         dvROo3H0yKoIUN1q+PZkT55LT1J2jDty1mNlRXdBDA+j1GDX6P5WTLiWqiP482Xd/0j6
         4ijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760531822; x=1761136622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8E+MJevdLFCHBwF7mS7GoEuKQlVbSLU5v6n96OsPT4=;
        b=iXQ5uDyvrvC9KNQW7CCfe6DLQRCMJGov0mE3X3sSGbswGzM8AK4iL7GG4wBZsr8d8m
         iu9Cmo3EcJkc24WRWJHeKMjc5wIsnSae3lFz2TVZrybfT5ZiSbI/fQbGrxyhpUkI+f4a
         IDYFUcLECmo0o6IEij1fOl2b5FNCydl+xfW7Bhwc0lDcJLw4Cs8y6bxpU4NoK8hKfArO
         n5ejj+NeWu3hP9sRDhbgPKP4ysVMz+0HdhbB4iDMdpgwiOinYScBzyZk7g3LVoPjjcvA
         KjOQBzfhhfzYVbcoJBRyD7nUCYjrP1vOO6YK04Uhe7sWYobMrBFR9FK8G3vyt4ABQAdT
         CtvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2qcXFEV6nr8Pc7K9XggYAY+U4CC0QwFjlMgqYlFqI6as1ocm6dS3xuoKySyyGxO6b1E6B+vvIkvwsieY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQUZJh0m1Bs4WBCzFnR+0YEPNC3Ak1IHm3xO/GDE33FELH22bF
	VG5C0TIJWwR5t8WBINRjvpUCy6kQwGV6Gpg1WbdWY9tT1JzEbIg+Rlzmix/DKPHKQ8AmHhTkp1k
	wJrnfpv+7STciWD9XkZDDzsCkiOfNLTYX+4J01beAtg==
X-Gm-Gg: ASbGncszxWfvIgtM/YiKsqHREc2i5t5wf7zEATQhscQ6UheXqZfFMD90yAAs0ny800i
	1mBfh/E/kozuZi8ZPU/hLvyzRfdOKE5Rykxcc1FbIh169L/ywGuVjLDy+b/2uRFNzfUsXE4tsz5
	P/6F5Wr2+bwb5ajMpXNc/MzP3mE6gNaKTX67PB4QEdwMrrLPuHovu22dk5BCCf0vE2gd7D8ZSTq
	7a0XG74SYVQdsEfMDtZ4H8=
X-Google-Smtp-Source: AGHT+IEDF7iyIXNjv4yFMv0Mll29DePR8hod/9dF7gMGC5HJnD9K/nVXAKiAd5Z8GOd414WiFCTkFSP/++NSmqR2Z5Y=
X-Received: by 2002:a17:907:7e88:b0:b3f:9e3d:daa4 with SMTP id
 a640c23a62f3a-b50ac9f3424mr2775434166b.65.1760531822098; Wed, 15 Oct 2025
 05:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-2-pasha.tatashin@soleen.com> <aO9ZiERHff7vQiBL@kernel.org>
In-Reply-To: <aO9ZiERHff7vQiBL@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 15 Oct 2025 08:36:25 -0400
X-Gm-Features: AS18NWCPb-lo4AJ85wFH4W7tNY7wonucvX9sAJrCA5Y6CElFA6kZge8K_GeLICU
Message-ID: <CA+CK2bA5Eyz6TUMTy3pa5HBvZ7KkiHX3EHn17T=d6LX_X5i3bg@mail.gmail.com>
Subject: Re: [PATCH 1/2] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/liveupdate/Kconfig                   | 15 ++++++++++
>
> Feels like kernel/liveupdate/Makefile change is missing

It's not, we already have KEXEC_HANDOVER_DEBUGFS that pulls in
kexec_handover_debug.c

That debug file contains KHO debugfs and debug code. The debug code
adds KEXEC_HANDOVER_DEBUGFS as a dependency, which I think is
appropriate for a debug build.

However, I do not like ugly ifdefs in .c, so perhaps, we should have two files:
kexec_handover_debugfs.c for debugfs and kexec_handover_debug.c ? What
do you think?

> >  kernel/liveupdate/kexec_handover.c          | 32 ++++++++++++++++++---
> >  kernel/liveupdate/kexec_handover_debug.c    | 18 ++++++++++++
> >  kernel/liveupdate/kexec_handover_internal.h |  9 ++++++
> >  4 files changed, 70 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> > index 522b9f74d605..d119f4f3f4b1 100644
> > --- a/kernel/liveupdate/Kconfig
> > +++ b/kernel/liveupdate/Kconfig
> > @@ -27,4 +27,19 @@ config KEXEC_HANDOVER_DEBUGFS
> >         Also, enables inspecting the KHO fdt trees with the debugfs binary
> >         blobs.
> >
> > +config KEXEC_HANDOVER_DEBUG
> > +     bool "Enable Kexec Handover debug checks"
> > +     depends on KEXEC_HANDOVER_DEBUGFS
> > +     help
> > +       This option enables extra sanity checks for the Kexec Handover
> > +       subsystem.
> > +
> > +       These checks verify that neither preserved memory regions nor KHO's
> > +       internal metadata are allocated from within a KHO scratch area.
> > +       An overlap can lead to memory corruption during a subsequent kexec
> > +       operation.
> > +
> > +       If an overlap is detected, the kernel will print a warning and the
> > +       offending operation will fail. This should only be enabled for
> > +       debugging purposes due to runtime overhead.
> >  endmenu
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > index 5da21f1510cc..ef1e6f7a234b 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -141,6 +141,11 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
> >       if (!elm)
> >               return ERR_PTR(-ENOMEM);
> >
> > +     if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz))) {
> > +             kfree(elm);
>
> I think __free() cleanup would be better than this.

Sorry, not sure what do you mean. kfree() is already is in this
function in case of failure.

>
> > +             return ERR_PTR(-EINVAL);
> > +     }
> > +
> >       res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
> >       if (xa_is_err(res))
> >               res = ERR_PTR(xa_err(res));
> > @@ -354,7 +359,13 @@ static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
> >
> >       chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
> >       if (!chunk)
> > -             return NULL;
> > +             return ERR_PTR(-ENOMEM);
>
> I don't think it's important to return -errno here, it's not that it's
> called from a syscall and we need to set errno for the userspace.
> BTW, the same applies to xa_load_or_alloc() IMO.

HM, but they are very different errors: ENOMEM, the KHO user can try
again after more memory is available, but the new -EINVAL return from
this function tells the caller that there is something broken in the
system, and using KHO is futile until this bug is fixed.

> > +
> > +     if (WARN_ON(kho_scratch_overlap(virt_to_phys(chunk), PAGE_SIZE))) {
> > +             kfree(chunk);
> > +             return ERR_PTR(-EINVAL);
> > +     }
> > +
> >       chunk->hdr.order = order;
> >       if (cur_chunk)
> >               KHOSER_STORE_PTR(cur_chunk->hdr.next, chunk);
> > @@ -379,14 +390,17 @@ static int kho_mem_serialize(struct kho_out *kho_out)
> >       struct khoser_mem_chunk *chunk = NULL;
> >       struct kho_mem_phys *physxa;
> >       unsigned long order;
> > +     int ret = -ENOMEM;
> >
> >       xa_for_each(&kho_out->track.orders, order, physxa) {
> >               struct kho_mem_phys_bits *bits;
> >               unsigned long phys;
> >
> >               chunk = new_chunk(chunk, order);
> > -             if (!chunk)
> > +             if (IS_ERR(chunk)) {
> > +                     ret = PTR_ERR(chunk);
>
> ... and indeed, -errno from new_chunk() juts makes things more complex :(
>
> >                       goto err_free;
> > +             }
> >
> >               if (!first_chunk)
> >                       first_chunk = chunk;
> > @@ -396,8 +410,10 @@ static int kho_mem_serialize(struct kho_out *kho_out)
> >
> >                       if (chunk->hdr.num_elms == ARRAY_SIZE(chunk->bitmaps)) {
> >                               chunk = new_chunk(chunk, order);
> > -                             if (!chunk)
> > +                             if (IS_ERR(chunk)) {
> > +                                     ret = PTR_ERR(chunk);
> >                                       goto err_free;
> > +                             }
> >                       }
> >
> >                       elm = &chunk->bitmaps[chunk->hdr.num_elms];
> > @@ -414,7 +430,7 @@ static int kho_mem_serialize(struct kho_out *kho_out)
> >
> >  err_free:
> >       kho_mem_ser_free(first_chunk);
> > -     return -ENOMEM;
> > +     return ret;
> >  }
> >
> >  static void __init deserialize_bitmap(unsigned int order,
> > @@ -737,6 +753,9 @@ int kho_preserve_folio(struct folio *folio)
> >       const unsigned int order = folio_order(folio);
> >       struct kho_mem_track *track = &kho_out.track;
> >
> > +     if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << order)))
> > +             return -EINVAL;
> > +
> >       return __kho_preserve_order(track, pfn, order);
> >  }
> >  EXPORT_SYMBOL_GPL(kho_preserve_folio);
> > @@ -784,6 +803,11 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
> >       unsigned long failed_pfn = 0;
> >       int err = 0;
> >
> > +     if (WARN_ON(kho_scratch_overlap(start_pfn << PAGE_SHIFT,
> > +                                     nr_pages << PAGE_SHIFT))) {
> > +             return -EINVAL;
> > +     }
>
> Can't we check this in __kho_preseve_order() and not duplicate the code?

Yes, that is possible, I will move it in the next version.

> > +
> >       while (pfn < end_pfn) {
> >               const unsigned int order =
> >                       min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
>
> --
> Sincerely yours,
> Mike.

