Return-Path: <linux-kernel+bounces-854496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 614D1BDE83C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACEF3A91FE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0D41B6CE9;
	Wed, 15 Oct 2025 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Xgyx87vo"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444BA450FE
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760532069; cv=none; b=nPxCmAA0tB1wit6NJ56v/5lMF0cIO5sajMtUqhgDp2o9TR25DHzz65qRlSqLn8Wcte5X/XsjhrMbnJ333pul46HGCgmUOGPfFYK1vNvcXmQXk+BomTrTzAIWVAKKTw9+jVLBbmXo/di8UJfx56TPe3jc7ODUSmS9zPWv/qZJtlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760532069; c=relaxed/simple;
	bh=O958bplKIj1Qv5zJmVCb3BaHyS4xTxY0CNjHHPEHJZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKnP2fK/MN4Wkds7QGU94Y5blftO+KZVsg3O1r0cW133rTrPM2WHhvjBk0bXgJBFjoak/PQ2E/uX9mgt917vixYT3BtmdJ1P6H2dl5iGzVHFLD97dX4ygxluvlxN/jDy9PKRK9IvcuvDgS/M3P/EKJq29kEEX9s8GWy0rad1hlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Xgyx87vo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63bdc7d939fso2997711a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760532063; x=1761136863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FipoM8XHkQDqrmj0YxqfPPlg2b8IjYcJe+/Om+8rUJs=;
        b=Xgyx87vo1FqoO8pps9cKDjiBrIadIwV8ZiKEwSsNnhADcAYzgk8i2Oi8e9ev/9ZF3C
         0ynurHt0ToHWqFMWiHYVvUyHLSpfutb73MsyNDEjfwllmasQ63bY+pKMN7OVGyxtIu0j
         9/EupDrePSjD3SLGbWGWPmsUxLcPvRZrS2RemWwjVMqLUuPKC6QPEySqyEry8R49AVUd
         GfbtQeKk7hLTrzb7L4BxhGAVDSVcn8/7RxecQnN/8qVJXTc8t/5ffo9cbtoGuWzKuhD1
         zSwbRBkFRS3Ht4WsbIBFXttdzBC27ovLLW1ekFXU5xdXq8p2MvLJgc90wA2DEnKHZtNh
         J16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760532063; x=1761136863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FipoM8XHkQDqrmj0YxqfPPlg2b8IjYcJe+/Om+8rUJs=;
        b=wLC+H5+vFVrwpwwbXqWdur0GqNme18HrTBozn2Zg1jedcXdq8eih79KKLPMpX3HyIB
         txSl+KbdgrUgOiErckJ+uHuyx93CXrRTSbBsAPgptysygXWxqfA+x22+ePP3dtiGjaFV
         Y15jQaiAOChQGyO1H3/5jRpqi3uz5USI/x9D0GVE9a4C5im43eKd1YHHCmRRhaXFN9SF
         Lsm9Fn/GSjqnwluuK4l8mdVHbB38GvxVaqU9v4RUDa6mqYwTtN23cn14mQGNmoNZtqn7
         7MJ+EipWjxvJ6ztRg/OPLI09/HN7DXfAMPm3vuCyd9Hy+6Gz8Ux0YarlSGQK6t6gO6FR
         kUww==
X-Forwarded-Encrypted: i=1; AJvYcCVbT0pg1uGPmXcJRIBg5N2pcgF1XiAjSy7LWw/xl29H0jkh+WYLXFE6XU1x6JRK5uVhMO1D/ecGUkyHJ+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ6GYNc8LpU/0NEBCTLFCj/cu0eRbCVVWrfqwZiZvWnr2xx5eB
	oOq1N1MoOacwiNkd7IzK75T8veSKtj8TG62Rg4JpdM4izKJtRF+7jkZgfdYhMSTEamm5XfFiQLX
	qki2y6Kye/gKrBkdVnnfJ0yEqaTrY89eKF+d443mfyA==
X-Gm-Gg: ASbGnctloHvOBzfi566Tlcsvt4N76H+9PjDPDDxBHe63kV89DO5rNClA3CyHzEXQ7ct
	byoxYRXgA7Kat77W5v8o5IL284qjUimdsQvVaGNuhXvpiAcDO7laEJzGmonjQZOsxrB8mfNNfyS
	SenZSY+iXG9nOc0kHIMBxyWLPUgxIcRT+R2UaV16SjI+EqFy5U3QOAPngBMLK+NBlehQbUZfsbK
	9sbOVdx4DHWP7CVof4ZRsxvvnHooJhpcg==
X-Google-Smtp-Source: AGHT+IHVW/aOfxAnOknHtkPVdgNnM4tNmxh+uGWj/wtje/WHNOH4EeyB3zfHx5JMTKCACj6PKn5d59raSVcEvzYo1NE=
X-Received: by 2002:a05:6402:3487:b0:639:f548:6894 with SMTP id
 4fb4d7f45d1cf-639f548ba3fmr23286278a12.3.1760532063349; Wed, 15 Oct 2025
 05:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-2-pasha.tatashin@soleen.com> <mafs0zf9sjrgc.fsf@kernel.org>
In-Reply-To: <mafs0zf9sjrgc.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 15 Oct 2025 08:40:26 -0400
X-Gm-Features: AS18NWBP9oBjba4zuXY2WUb88hXZWd7h5EjNqKrj5u46Vy6IINb-vIhf0-yb0QU
Message-ID: <CA+CK2bD4z_j_jMhMtrvvQ5nOMEFT6yrRHk9rk7BEiQPSPCHiqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
To: Pratyush Yadav <pratyush@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 8:10=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Wed, Oct 15 2025, Pasha Tatashin wrote:
>
> > It is invalid for KHO metadata or preserved memory regions to be locate=
d
> > within the KHO scratch area, as this area is overwritten when the next
> > kernel is loaded, and used early in boot by the next kernel. This can
> > lead to memory corruption.
> >
> > Adds checks to kho_preserve_* and KHO's internal metadata allocators
> > (xa_load_or_alloc, new_chunk) to verify that the physical address of th=
e
> > memory does not overlap with any defined scratch region. If an overlap
> > is detected, the operation will fail and a WARN_ON is triggered. To
> > avoid performance overhead in production kernels, these checks are
> > enabled only when CONFIG_KEXEC_HANDOVER_DEBUG is selected.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/liveupdate/Kconfig                   | 15 ++++++++++
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
> >         Also, enables inspecting the KHO fdt trees with the debugfs bin=
ary
> >         blobs.
> >
> > +config KEXEC_HANDOVER_DEBUG
> > +     bool "Enable Kexec Handover debug checks"
> > +     depends on KEXEC_HANDOVER_DEBUGFS
>
> Why the dependency on debugfs? Why can't the debug checks be enabled
> independently?

Because there is one kexec_handover_debug.c file, that I thought would
make sense to use for both, but now thinking about this, perhaps we
should split the code: KEXEC_HANDOVER_DEBUGFS and
KEXEC_HANDOVER_DEBUG, and add two files:
kexec_handover_debugfs.c and kexec_handover_debug.c, this would avoid
ifdefs in .c.

>
> > +     help
> > +       This option enables extra sanity checks for the Kexec Handover
> > +       subsystem.
> > +
> > +       These checks verify that neither preserved memory regions nor K=
HO's
> > +       internal metadata are allocated from within a KHO scratch area.
> > +       An overlap can lead to memory corruption during a subsequent ke=
xec
> > +       operation.
>
> I don't think the checks that are done should be listed here since as
> soon as another check is added this list will become out of date.

I thought it could be expanded when new features are added, but I can
remove this description.

>
> > +
> > +       If an overlap is detected, the kernel will print a warning and =
the
> > +       offending operation will fail. This should only be enabled for
>
> This also describes the behaviour of the checks, which might change
> later. Maybe for some checks the operation won't fail? I suppose just
> leave it at "the kernel will print a warning"?

If it changes, and Kconfig should be updated as well.

>
> > +       debugging purposes due to runtime overhead.
> >  endmenu
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kex=
ec_handover.c
> > index 5da21f1510cc..ef1e6f7a234b 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -141,6 +141,11 @@ static void *xa_load_or_alloc(struct xarray *xa, u=
nsigned long index, size_t sz)
> >       if (!elm)
> >               return ERR_PTR(-ENOMEM);
> >
> > +     if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz))) {
> > +             kfree(elm);
> > +             return ERR_PTR(-EINVAL);
> > +     }
> > +
> >       res =3D xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
> >       if (xa_is_err(res))
> >               res =3D ERR_PTR(xa_err(res));
> > @@ -354,7 +359,13 @@ static struct khoser_mem_chunk *new_chunk(struct k=
hoser_mem_chunk *cur_chunk,
> >
> >       chunk =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
> >       if (!chunk)
> > -             return NULL;
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     if (WARN_ON(kho_scratch_overlap(virt_to_phys(chunk), PAGE_SIZE)))=
 {
> > +             kfree(chunk);
> > +             return ERR_PTR(-EINVAL);
> > +     }
> > +
> >       chunk->hdr.order =3D order;
> >       if (cur_chunk)
> >               KHOSER_STORE_PTR(cur_chunk->hdr.next, chunk);
> > @@ -379,14 +390,17 @@ static int kho_mem_serialize(struct kho_out *kho_=
out)
> >       struct khoser_mem_chunk *chunk =3D NULL;
> >       struct kho_mem_phys *physxa;
> >       unsigned long order;
> > +     int ret =3D -ENOMEM;
> >
> >       xa_for_each(&kho_out->track.orders, order, physxa) {
> >               struct kho_mem_phys_bits *bits;
> >               unsigned long phys;
> >
> >               chunk =3D new_chunk(chunk, order);
> > -             if (!chunk)
> > +             if (IS_ERR(chunk)) {
> > +                     ret =3D PTR_ERR(chunk);
> >                       goto err_free;
> > +             }
> >
> >               if (!first_chunk)
> >                       first_chunk =3D chunk;
> > @@ -396,8 +410,10 @@ static int kho_mem_serialize(struct kho_out *kho_o=
ut)
> >
> >                       if (chunk->hdr.num_elms =3D=3D ARRAY_SIZE(chunk->=
bitmaps)) {
> >                               chunk =3D new_chunk(chunk, order);
> > -                             if (!chunk)
> > +                             if (IS_ERR(chunk)) {
> > +                                     ret =3D PTR_ERR(chunk);
> >                                       goto err_free;
> > +                             }
> >                       }
> >
> >                       elm =3D &chunk->bitmaps[chunk->hdr.num_elms];
> > @@ -414,7 +430,7 @@ static int kho_mem_serialize(struct kho_out *kho_ou=
t)
> >
> >  err_free:
> >       kho_mem_ser_free(first_chunk);
> > -     return -ENOMEM;
> > +     return ret;
> >  }
> >
> >  static void __init deserialize_bitmap(unsigned int order,
> > @@ -737,6 +753,9 @@ int kho_preserve_folio(struct folio *folio)
> >       const unsigned int order =3D folio_order(folio);
> >       struct kho_mem_track *track =3D &kho_out.track;
> >
> > +     if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << o=
rder)))
> > +             return -EINVAL;
> > +
> >       return __kho_preserve_order(track, pfn, order);
> >  }
> >  EXPORT_SYMBOL_GPL(kho_preserve_folio);
> > @@ -784,6 +803,11 @@ int kho_preserve_pages(struct page *page, unsigned=
 int nr_pages)
> >       unsigned long failed_pfn =3D 0;
> >       int err =3D 0;
> >
> > +     if (WARN_ON(kho_scratch_overlap(start_pfn << PAGE_SHIFT,
> > +                                     nr_pages << PAGE_SHIFT))) {
> > +             return -EINVAL;
> > +     }
> > +
> >       while (pfn < end_pfn) {
> >               const unsigned int order =3D
> >                       min(count_trailing_zeros(pfn), ilog2(end_pfn - pf=
n));
> > diff --git a/kernel/liveupdate/kexec_handover_debug.c b/kernel/liveupda=
te/kexec_handover_debug.c
> > index eb47f000887d..294d1d290142 100644
> > --- a/kernel/liveupdate/kexec_handover_debug.c
> > +++ b/kernel/liveupdate/kexec_handover_debug.c
> > @@ -214,3 +214,21 @@ __init int kho_debugfs_init(void)
> >               return -ENOENT;
> >       return 0;
> >  }
> > +
> > +#ifdef CONFIG_KEXEC_HANDOVER_DEBUG
> > +bool kho_scratch_overlap(phys_addr_t phys, size_t size)
> > +{
> > +     phys_addr_t scratch_start, scratch_end;
> > +     unsigned int i;
> > +
> > +     for (i =3D 0; i < kho_scratch_cnt; i++) {
> > +             scratch_start =3D kho_scratch[i].addr;
> > +             scratch_end =3D kho_scratch[i].addr + kho_scratch[i].size=
 - 1;
>
> Nit: wouldn't it be a tad bit simpler to do
>
>                 scratch_end =3D kho_scratch[i].addr + kho_scratch[i].size=
;
>
> > +
> > +             if (phys <=3D scratch_end && (phys + size) > scratch_star=
t)
>
> and here
>
>                 if (phys < scratch_end && (phys + size) > scratch_start)
>
> At least I find it slightly easier to understand, though I don't think
> it makes too much of a difference so either way is fine.
>
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +#endif /* CONFIG_KEXEC_HANDOVER_DEBUG */
> > diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveu=
pdate/kexec_handover_internal.h
> > index b3fc1957affa..92798346fa5a 100644
> > --- a/kernel/liveupdate/kexec_handover_internal.h
> > +++ b/kernel/liveupdate/kexec_handover_internal.h
> > @@ -44,4 +44,13 @@ static inline void kho_debugfs_fdt_remove(struct kho=
_debugfs *dbg,
> >                                         void *fdt) { }
> >  #endif /* CONFIG_KEXEC_HANDOVER_DEBUGFS */
> >
> > +#ifdef CONFIG_KEXEC_HANDOVER_DEBUG
> > +bool kho_scratch_overlap(phys_addr_t phys, size_t size);
> > +#else
> > +static inline bool kho_scratch_overlap(phys_addr_t phys, size_t size)
> > +{
> > +     return false;
> > +}
> > +#endif /* CONFIG_KEXEC_HANDOVER_DEBUG */
> > +
> >  #endif /* LINUX_KEXEC_HANDOVER_INTERNAL_H */
>
> --
> Regards,
> Pratyush Yadav

