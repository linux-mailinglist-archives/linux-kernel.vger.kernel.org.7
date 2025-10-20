Return-Path: <linux-kernel+bounces-861845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 279CFBF3CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D13B44E4378
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3081B2EFD9C;
	Mon, 20 Oct 2025 21:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TBt5uTMD"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9682E3387
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760997435; cv=none; b=Bq+A8boJl1G8cUMaqd9lB7xdOaqVr3SnZYLuuuQnjJZugYm+V1kOLcXqMYCLq/0pd5LxWI10+OUVaQ85jvAtjozEZ6IOTJrVIZFo1yf1vZk96AzP8zoqsUpgPaCGkaoSxu06HSrehhofs8rrK+3hVehtt1jPzCap8y4CPAIPFPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760997435; c=relaxed/simple;
	bh=V768A8yxayt7P4IfA0lT/xT5Fhuc4WSMi3Z0ranezsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASdsp6PXC0sZWOnpnsidhH4z4hGqV/ZDGNaNIaeyIOQPOVFQ5ntnlPcUjdlqc7CFqSeO9sdNc7ErZumkkZJ677RxsXuYnmsuFUhLANbSu5oiTKK9ZPpvchgl5DYtbTi3R9z+j6rY06R1zgIIyX3sNgOPeloMXtqwEe/vzVJOsLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=TBt5uTMD; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63d6ee383bdso804149a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760997432; x=1761602232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yknPt/PYO8q5rRsHwsdUNqs0P5wiVU3fHyZ3dxpXBPg=;
        b=TBt5uTMDCPlJKdFEd4YNcVZ6UPjAh3XCPoohpq6P2BglQYr60tiv1p3iCxYpliLASx
         of5Bz68276tsl+RDxY/YkgKeNAbyjcVHnYjHVNdXvz+xW89u3eQlj0xF6Gluqf8ZxUyK
         UUhkXbxS33dfMoKDjpuVnw80GVaG3JWEEuI0PNSD0zlHZ2sDHz+8AK3wRwtPN4rqLxAr
         Tcz+ZiHX8tAUHcXUDdFkxPY2BWuVR8jM25YjA/zr61DyJal1+3bXyhbhdJ5UKY3hyYIW
         tVgpA27m81WH6bxLaf5BXAOEqacT465eoJNUfof2yrn//xvgf7pALW0DtUHfd7pGGIO6
         LBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760997432; x=1761602232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yknPt/PYO8q5rRsHwsdUNqs0P5wiVU3fHyZ3dxpXBPg=;
        b=fpdPNFKVFOGdeK86aBhkOaDfL+gG5On4cm8Gd1ZBWdqBh1svAkkAWm1aE1oZiDqiyt
         i1dB5luVfAGOty/dbaZTLi37tUILegKESpofY6irdzAr7ySpflKhBz55D/3CKosnK1zH
         XcPnHu2w4ETDi4pR48HQ6DLEDSA/8ch8A9TkVKxEdZ/M7DAtGSDPA1CFP64Ky6iRBbcr
         0Vmz9HGuPUX5gWFBG7EkWXvio6azEZ3paYhPHfdWUnTEl35d3vgT0MGE9NVxX5nxn645
         fAOjWHR4oObMSreW3AA3tGYf3ewMVCDEz0qJkKmNLDrmmw6AVb38dl8dSN5uLy3ndcVD
         5LTw==
X-Forwarded-Encrypted: i=1; AJvYcCU8OPkFior/pyvbOOVi8ICCPmNUK7hnn/hPAW08NnuZOD8tu6qwloKjFIKx4Pzu87VFRLj7KrvXP7ABJl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvgHqeK1OrBDrduvDDA03J5/DppiRKqdl3JGXGMtGIxHi6ZKR5
	39WCs574qP6fZaoin50u1EpQef6dJN46XD2y3sifZ4nMfbGFfOhZJJxaI4iEFot4lRzEOY6761G
	Ce+hDyfOYGKapVWPev+avOH7TZjib6StrVfyaZ2iiKQ==
X-Gm-Gg: ASbGncsE5ZcOrHaTiedLEGCDDUklAxk3EipOpWsDae9aB3pUnak7Itv9JGSon2yfr3o
	FAPCZzo8YCLh4iLlOb9EFoHfq23ySjVnVxAo7H8NdvSOw080bDuw/DbxO+Mu10WbD8mwD0bIzMy
	bBpai8cQ4NAG1ZzLIorHXsZZrK1rgBY/Nnl6K2DJ/OKQ3MDtIX5ducK3c4C4K05oY13CXnpZPvj
	qGYWagY19En8NJ8mDrPaeVIaGAsTNY8PMhci2I7952+nM8rDj9ObuiNY97Q4yFxn89Q
X-Google-Smtp-Source: AGHT+IHQae2JTSc9wDUKvH2Zkgs7s+B9woSGFjjo4cTKOt1mF9fuNToFGqWKvdpPe0XvAAEv7aHWf3quANxxuxkPcIo=
X-Received: by 2002:a17:907:3d91:b0:b30:2f6b:448f with SMTP id
 a640c23a62f3a-b6473245877mr1851254166b.25.1760997431856; Mon, 20 Oct 2025
 14:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
 <20251018171756.1724191-9-pasha.tatashin@soleen.com> <aPXrLy8BmblbLpCG@kernel.org>
In-Reply-To: <aPXrLy8BmblbLpCG@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 20 Oct 2025 17:56:34 -0400
X-Gm-Features: AS18NWAztFjNYjBIm4rRiGeQCx-E5VPlPZGMKjs9EYAdnOCA2q6eV6QJOgzo-JU
Message-ID: <CA+CK2bDMYwd59_+OkRN-qcy70V=06Ui1AhCiMb9YJRPdn3-SYQ@mail.gmail.com>
Subject: Re: [PATCH v6 08/10] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

> > +config KEXEC_HANDOVER_DEBUG
> > +     bool "Enable Kexec Handover debug checks"
> > +     depends on KEXEC_HANDOVER_DEBUGFS
> > +     help
> > +       This option enables extra sanity checks for the Kexec Handover
> > +       subsystem. Since, KHO performance is crucial in live update
> > +       scenarios and the extra code might be adding overhead it is
> > +       only optionally enabled.
>
> And empty line here would be nice.

Done.

>
> >  endmenu
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > index c87d00c40c82..ebfc31814d16 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -8,6 +8,7 @@
> >
> >  #define pr_fmt(fmt) "KHO: " fmt
> >
> > +#include <linux/cleanup.h>
> >  #include <linux/cma.h>
> >  #include <linux/count_zeros.h>
> >  #include <linux/kexec.h>
> > @@ -131,26 +132,26 @@ static struct kho_out kho_out = {
> >
> >  static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
> >  {
> > -     void *elm, *res;
> > +     void *res = xa_load(xa, index);
> >
> > -     elm = xa_load(xa, index);
> > -     if (elm)
> > -             return elm;
> > +     if (res)
> > +             return res;
> > +
> > +     void *elm __free(kfree) = kzalloc(sz, GFP_KERNEL);
> >
> > -     elm = kzalloc(sz, GFP_KERNEL);
> >       if (!elm)
> >               return ERR_PTR(-ENOMEM);
> >
> > +     if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz)))
>
> I'd move the WARN_ON into kho_scratch_overlap().

I do not like O(N^2), let's keep it outside, even though it is a debug
kernel, there is no need to make it unnecessary slow, when we are
saving just two lines of code.

>
> > +             return ERR_PTR(-EINVAL);
> > +
> >       res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
> >       if (xa_is_err(res))
> > -             res = ERR_PTR(xa_err(res));
> > -
> > -     if (res) {
> > -             kfree(elm);
> > +             return ERR_PTR(xa_err(res));
> > +     else if (res)
> >               return res;
> > -     }
> >
> > -     return elm;
> > +     return no_free_ptr(elm);
> >  }
>
> ...
>
> > @@ -379,14 +384,17 @@ static int kho_mem_serialize(struct kho_out *kho_out)
> >       struct khoser_mem_chunk *chunk = NULL;
> >       struct kho_mem_phys *physxa;
> >       unsigned long order;
> > +     int ret = -ENOMEM;
>
> Nit: s/ret/err/

Done.

>
> >
> >       xa_for_each(&kho_out->track.orders, order, physxa) {
> >               struct kho_mem_phys_bits *bits;
> >               unsigned long phys;
> >
> > diff --git a/kernel/liveupdate/kexec_handover_debug.c b/kernel/liveupdate/kexec_handover_debug.c
> > new file mode 100644
> > index 000000000000..7986dcc63047
> > --- /dev/null
> > +++ b/kernel/liveupdate/kexec_handover_debug.c
> > @@ -0,0 +1,25 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * kexec_handover_debug.c - kexec handover optional debug functionality
> > + * Copyright (C) 2025 Google LLC, Pasha Tatashin <pasha.tatashin@soleen.com>
> > + */
> > +
> > +#define pr_fmt(fmt) "KHO: " fmt
> > +
> > +#include "kexec_handover_internal.h"
> > +
> > +bool kho_scratch_overlap(phys_addr_t phys, size_t size)
> > +{
> > +     phys_addr_t scratch_start, scratch_end;
> > +     unsigned int i;
> > +
> > +     for (i = 0; i < kho_scratch_cnt; i++) {
> > +             scratch_start = kho_scratch[i].addr;
> > +             scratch_end = kho_scratch[i].addr + kho_scratch[i].size - 1;
>
> I agree with Pratyush that
>
>                 scratch_end = kho_scratch[i].addr + kho_scratch[i].size;
>
>                 if (phys < scratch_end ...
>
> is clearer.

Done.

Thanks,
Pasha

