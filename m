Return-Path: <linux-kernel+bounces-809320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303DDB50C02
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96303AEF38
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00789246782;
	Wed, 10 Sep 2025 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJLDznJy"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCF118E1F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473019; cv=none; b=XC0VndM2GlBSwkEAFFS7hp7O5v0KUSM+f0tsjJhGLwmrrLK3scpQ4T7h0NZ4InnSQLErOcznFjr8UtRu27uzJ7eFfrgLqBSpAIvKwE6v9tsy49dfTfVpZljl+TiSmEMgyIdT3GbdVsgGiONrcArZstOxiSPjYyurs0cEzevcOIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473019; c=relaxed/simple;
	bh=mhBgrWbimp09v8rzy1C5idBKoQLxYPQkL34kga7HDsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkKjZxCoeNakpeGmAdXq5ii43YmhoZMcnJ3t446nWymID9OTCRkAgssjTpDe8P776EQwLHf5gCfX4kIR9c3+7YbP3M1G5bbDkdooMldUmPQH5HiM2eX1FcZN+LUtrK2tzv1ubSe/+m7M2DECyNFv2dXIDajcPbEyAbvuDiRNyiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJLDznJy; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6228de280ccso8305165a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 19:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757473015; x=1758077815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrGyG66Zz7xTWILpFo3YOH6zYqrmFzQUSQypRWnmJ2Y=;
        b=nJLDznJyaY77zpJ1mfiJ0r7ijk+fOs/F1vV0L/mkQd1HoWnV1dBT7DlP3MGnj/ONxj
         zBY5d2cTVuT7ab3bAcOX5jqGiQpAPSgaV90EJUIZzoYbkz0OfiCBOqnsvJYX1aaf5MsY
         x0LFcsiLFBhGYffWEqRkydhXpbLxcGGphScEYLE6MllRqiM9F5ru8n2TGfY0gVJSRuWw
         lcsMa/IDf+XUKgibTS/QGeQWLCdN/xpDEw5kek8ytOeBaRvjH9GJixKD7g4KJq/lUDQ8
         SyV6lCCtiDncbTB9SMyCIXnGuiNheUc0yRv6ued5CHFuNGlRVC64IWUW1Rw03QFsjGcI
         4m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757473015; x=1758077815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrGyG66Zz7xTWILpFo3YOH6zYqrmFzQUSQypRWnmJ2Y=;
        b=qY7Ly+Ctcuz5WuqFAOzAt4VXnbuN2NIw3n9iLMXYr+GGoc2yWmcq+hdz90aoYO0pWF
         8HCTrTfvNWduvBL2QPjrhzGEsYzI4h0dcdWEfC3IOVbqV5q4PHBaDdoZuGSiNkp1A2/0
         m2a+a5MGtUeSS3qtfbJVkl6AIcPKJKkFqCNhDAeVxc+M6lZc5JCykeTEiceB2qgyM04g
         loEwmRi1e0FMSUtTZQpm2iNq1y4kNbxA59xsgp0o2oVUjxnVrK04w1kj6mDRHFSz/ehE
         vZEfmfGWfF/avfulONK98vPCTPFV1tqdcBKyF/6rE5sVK5NTPfgug68mDbL3CeQHjiKX
         uZpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfzKPxetOBfjVc9OqDUqYM7PGD5CMm79sZQqNmAbi0v7nHyMiNuzf7tZ1xPqNk8Cz8io3f9JWtJzSpXtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKjoK99twk/lRc6ClhCUygFlbQ4IUP5vmIbn56FwmpIbBMD2Mv
	04L123H+fT77t1fz6INjg2ELX4VRnWTB4Cb4940OVuRmAfrygxpvJbkS6tE84G3sLwbtQrw5DJs
	7Z1tJkGhIbAyRvPpSAF/GysvkWBf8EeY=
X-Gm-Gg: ASbGncv231fH1Gn1B+NEupJdgbXBIW79+KOyNpQGNfdB3v030JUhZ/I4N9W2gbqX9Ay
	3yB95Ew7ks7hU6JKPHzWezwCgoDlE112RrHVUwi3FJ2BRQnMTj7WNDngNI1c0MJBI3fD9Iw8KLn
	hGdbBh3lYhg+sg4vwzIarSVlHF0PrOyFK65KvoAIs6uCuQRG61N1s+1vLkSgiQd8P5ZCckCwZX0
	BTXu1w84+/690ZLqe3lZA==
X-Google-Smtp-Source: AGHT+IHjkD97AbYwgHxhY6BZHaDg/uLduF7f3nRFFMpbDeYSOHPOV6nGvSYKzsNcrHoOkWugUDXE2os2N/uaM92+m78=
X-Received: by 2002:a05:6402:3589:b0:62c:62e1:8ff4 with SMTP id
 4fb4d7f45d1cf-62c62e1986amr3286599a12.23.1757473015266; Tue, 09 Sep 2025
 19:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-12-ryncsn@gmail.com> <20250910025315.109884-1-sj@kernel.org>
In-Reply-To: <20250910025315.109884-1-sj@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 10 Sep 2025 10:56:18 +0800
X-Gm-Features: AS18NWC--jKgTPO8qykBZ10aNTJ4ysuxn4mpZh-qs_f-Wo4HnvYwrqhg0W-D4vU
Message-ID: <CAMgjq7A4j6xCjSw3o=9UDYMUgvqhKscCuPMqcAD_3zKAcQP6ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] mm, swap: use the swap table for the swap cache
 and switch API
To: SeongJae Park <sj@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 10:53=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>
> Hi Kairui,

Hi SeongJea,

>
> On Sat,  6 Sep 2025 03:13:53 +0800 Kairui Song <ryncsn@gmail.com> wrote:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > Introduce basic swap table infrastructures, which are now just a
> > fixed-sized flat array inside each swap cluster, with access wrappers.
> >
> > Each cluster contains a swap table of 512 entries. Each table entry is
> > an opaque atomic long. It could be in 3 types: a shadow type (XA_VALUE)=
,
> > a folio type (pointer), or NULL.
> >
> > In this first step, it only supports storing a folio or shadow, and it
> > is a drop-in replacement for the current swap cache. Convert all swap
> > cache users to use the new sets of APIs. Chris Li has been suggesting
> > using a new infrastructure for swap cache for better performance, and
> > that idea combined well with the swap table as the new backing
> > structure. Now the lock contention range is reduced to 2M clusters,
> > which is much smaller than the 64M address_space. And we can also drop
> > the multiple address_space design.
> >
> > All the internal works are done with swap_cache_get_* helpers. Swap
> > cache lookup is still lock-less like before, and the helper's contexts
> > are same with original swap cache helpers. They still require a pin
> > on the swap device to prevent the backing data from being freed.
> >
> > Swap cache updates are now protected by the swap cluster lock
> > instead of the Xarray lock. This is mostly handled internally, but new
> > __swap_cache_* helpers require the caller to lock the cluster. So, a
> > few new cluster access and locking helpers are also introduced.
> >
> > A fully cluster-based unified swap table can be implemented on top
> > of this to take care of all count tracking and synchronization work,
> > with dynamic allocation. It should reduce the memory usage while
> > making the performance even better.
>
> Thank you for continuing this nice work.  I was unfortunately unable to g=
et
> time to review this thoroughly, but found below.
>
> >
> > Co-developed-by: Chris Li <chrisl@kernel.org>
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> [...]
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> [...]
> > @@ -367,7 +452,7 @@ static inline int non_swapcache_batch(swp_entry_t e=
ntry, int max_nr)
> >  static inline pgoff_t folio_index(struct folio *folio)
> >  {
> >       if (unlikely(folio_test_swapcache(folio)))
> > -             return swap_cache_index(folio->swap);
> > +             return swp_offset(folio->swap);
> >       return folio->index;
> >  }
>
> This makes i386 build on my setup fails, like below:
>
>     In file included from /mm/shmem.c:44:
>     /mm/swap.h: In function =E2=80=98folio_index=E2=80=99:
>     /mm/swap.h:462:24: error: implicit declaration of function =E2=80=98s=
wp_offset=E2=80=99; did you mean =E2=80=98pmd_offset=E2=80=99? [-Werror=3Di=
mplicit-function-declaration]
>       462 |                 return swp_offset(folio->swap);
>           |                        ^~~~~~~~~~
>           |                        pmd_offset
>     In file included from /mm/shmem.c:69:
>     /include/linux/swapops.h: At top level:
>     /include/linux/swapops.h:107:23: error: conflicting types for =E2=80=
=98swp_offset=E2=80=99; have =E2=80=98long unsigned int(swp_entry_t)=E2=80=
=99
>       107 | static inline pgoff_t swp_offset(swp_entry_t entry)
>           |                       ^~~~~~~~~~
>     /mm/swap.h:462:24: note: previous implicit declaration of =E2=80=98sw=
p_offset=E2=80=99 with type =E2=80=98int()=E2=80=99
>       462 |                 return swp_offset(folio->swap);
>           |                        ^~~~~~~~~~
>     cc1: some warnings being treated as errors
>
> You may be able to reproduce this using my script [1].
>
> I also found including swapops.h as below fix this on my setup.  I didn't=
 read
> this code thoroughly, so not really sure if it is the right approach, tho=
ugh.
>
>     --- a/mm/swap.h
>     +++ b/mm/swap.h
>     @@ -3,6 +3,7 @@
>      #define _MM_SWAP_H
>
>      #include <linux/atomic.h> /* for atomic_long_t */
>     +#include <linux/swapops.h>
>      struct mempolicy;
>      struct swap_iocb;
>
> [1] https://github.com/damonitor/damon-tests/blob/master/corr/tests/build=
_i386.sh

Yes, I also saw a report from the build bot. I tested !SWAP build but
didn't test !SWAP !SHMEM build.

Adjust the include header then the problem is gone, I'll send a V3 soon to
include this fix.

Thanks!

