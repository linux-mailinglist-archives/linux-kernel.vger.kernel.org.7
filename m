Return-Path: <linux-kernel+bounces-806093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC3CB491CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE8AB7B71BB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E72B30CD8A;
	Mon,  8 Sep 2025 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bs4Qz4A/"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEA030C627
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342084; cv=none; b=SKcJo8T2nDpQSGqZs0p6+YHqNSG8L5rBr2kUN9wR2SC8oOQb15c901e7+MNzetjwuDwLhi1ntGayHKK/5k2N0tdD9xeBCz49aJoZFiaL6HIMa5fINBoKxB8CeCutW22yiYGktDqnXqepcNJg0XLUo7CfT979KMXbun++ktk5vlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342084; c=relaxed/simple;
	bh=caaN/ILWXlzTT7xkq4F60G0bMtS9b0cJOa58AQcy5/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZA6KV3K/cFuGfH6xREs8oTYnLVQP8cvx7OU3OoZFJJVbSyozn1ubMRzV5I6BZU/VokGx4RkbwwpPk/ZgE4kanpEc5EzlA9319ERtxFoQC1iZjl08X5d/SJXUcN7rymw24uL9dYrcHqOciAjgYBWVMxSxLiOVJbqAmlVyXRDfFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bs4Qz4A/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62598fcf41aso2810220a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757342081; x=1757946881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbtUk7FrbyMvuG+t0mCuOx9heZkWciOxr2cORrysFDA=;
        b=Bs4Qz4A/aacBevDvL245yBtKGLFZLBcrRZIQy6ZsJld/6FMnN1hmQKEsOuKg+OIzYP
         OZUNupPFCX7kYYSpOCA7exCtEzcS8JwB5GR5KQgZ92Gb2dd5nRj0fE8oEaQKfbySztX+
         o0sqxnHBXE7uBVBUKjiljTtENlZjButsfkrNDJzcXVJB5JOlfIrWpLyI6f7sYDNUM5nn
         PkWqL/CHbbnfykfOKNId8OT7tGqOi42H0YGPOl0Gg+JcalryQa7hetDrlrix4zaSuCmS
         ARs65K3ZutQGbxy4KeJrUtjTsaBiUJJTTQGvs2QQoZwfNVa5irSlpnpppOj20sL4ivhi
         dfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757342081; x=1757946881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbtUk7FrbyMvuG+t0mCuOx9heZkWciOxr2cORrysFDA=;
        b=mgmSdK8CB6bqo36itJTNNUDhR9YDDSq6wDdH91dxB9BeLYpmG+7rJwSlrS/bTOfRGz
         cM/Lb0dwTN7WF8h7fHdL6v1Mz8q9JE0WSbUbXiWJlFsc33Pr1sUpcGuXqeDtmHZtCZTM
         ezFC2ACrqyJx6qIyYuSPJobKUYHaZQIWU1zWnw9DoQfoNvchheqSQ5e3KJTLCxxFYk50
         wMqs8VZxoqHskbvQpdLbJv4zHhbM5eH5DaHnXCunQBGMA3bVyFjiHuG6vyxrrSkcXAv0
         ihNB7z0v4XNdGlrXISdpuwiYpGdskuqYH5jBFVdwXJDmpKkwxpDrAXuB+3rnBy0tZVKZ
         XT1w==
X-Forwarded-Encrypted: i=1; AJvYcCUEBsJ9BUQP8YZxUM0PVXJ8hNcxyPKUXyjbT6MpT7QyJAMIY9tjsvD/qW7pwShXSFLyAUsbVCcrxSDf66o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjqLcrNMAT2n4yBDk6V754gcmCjE/WP0wZrmwsyFXxJv9N3sew
	Dpl1qkOlloWoVgYgMBkHZpQrzQdijSHyQpYVpP5Okt9pgTzm/G+zcRJj20JPvVI8YnJkdCY3zD0
	FPvz42vpijhfWN05GtBlF3adYN+c41Bs=
X-Gm-Gg: ASbGncshBhW7MUnHjfhuo/9fX39wGwxNVoysFuoHE8gL+DV53LKpIVvbfhkf4gHoXVu
	+eUFBy19Bq3PlRAswzc+4Uruf+SvF5OXOGgzmzthArpL5Vgj06MyYx/qzvX2pgduJf72VRt9Qps
	TSSg7ck6+8pC6P6231HadUaoEBNWEhweOB93sbiIORhf9URmYEyXY167t6BK8/9FLW/VUMRXjar
	TRAWfIuBQo=
X-Google-Smtp-Source: AGHT+IHqvEea2P3gZapZ7WwlegqtHpa3ecGMHI6Ur9DTfr6rTk3jnzICltbuq7nedWKvU+dhuo0b2dODtNrs673nXtk=
X-Received: by 2002:a05:6402:5242:b0:618:196b:1f8a with SMTP id
 4fb4d7f45d1cf-623725ed8ebmr6204594a12.4.1757342080926; Mon, 08 Sep 2025
 07:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-12-ryncsn@gmail.com>
 <vj7utcgrseaot6ktpbwgshthmjza7w7vk2glede273tza7yfi6@cyxppxoney5u>
In-Reply-To: <vj7utcgrseaot6ktpbwgshthmjza7w7vk2glede273tza7yfi6@cyxppxoney5u>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 8 Sep 2025 22:34:04 +0800
X-Gm-Features: AS18NWAwbwczGgNQk1yhM1T5cz_8DfGfywC5MgRQgLVIxrrVVLjBFsAmV5awcxk
Message-ID: <CAMgjq7CLSuSfRwMYqNL9ZU3ehpZfR6oewHsYtLD4CTXcvEKOTg@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] mm, swap: use the swap table for the swap cache
 and switch API
To: Klara Modin <klarasmodin@gmail.com>
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

On Sun, Sep 7, 2025 at 8:59=E2=80=AFPM Klara Modin <klarasmodin@gmail.com> =
wrote:
>
> On 2025-09-06 03:13:53 +0800, Kairui Song wrote:
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
> >
> > Co-developed-by: Chris Li <chrisl@kernel.org>
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  MAINTAINERS          |   1 +
> >  include/linux/swap.h |   2 -
> >  mm/huge_memory.c     |  13 +-
> >  mm/migrate.c         |  19 ++-
> >  mm/shmem.c           |   8 +-
> >  mm/swap.h            | 157 +++++++++++++++++------
> >  mm/swap_state.c      | 289 +++++++++++++++++++------------------------
> >  mm/swap_table.h      |  97 +++++++++++++++
> >  mm/swapfile.c        | 100 +++++++++++----
> >  mm/vmscan.c          |  20 ++-
> >  10 files changed, 458 insertions(+), 248 deletions(-)
> >  create mode 100644 mm/swap_table.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1c8292c0318d..de402ca91a80 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16226,6 +16226,7 @@ F:    include/linux/swapops.h
> >  F:   mm/page_io.c
> >  F:   mm/swap.c
> >  F:   mm/swap.h
> > +F:   mm/swap_table.h
> >  F:   mm/swap_state.c
> >  F:   mm/swapfile.c
> >
>
> ...
>
> >  #include <linux/swapops.h> /* for swp_offset */
>
> Now that swp_offset() is used in folio_index(), should this perhaps also =
be
> included for !CONFIG_SWAP?

Hi, Thanks for looking at this series.

>
> >  #include <linux/blk_types.h> /* for bio_end_io_t */
> >
...

> >       if (unlikely(folio_test_swapcache(folio)))
>
> > -             return swap_cache_index(folio->swap);
> > +             return swp_offset(folio->swap);
>
> This is outside CONFIG_SWAP.

Right, but there are users of folio_index that are outside of
CONFIG_SWAP (mm/migrate.c), and swp_offset is also outside of SWAP so
that's OK.

If we wrap it, the CONFIG_SWAP build will fail. I've test !CONFIG_SWAP
build on this patch and after the whole series, it works fine.

We should drop the usage of folio_index in migrate.c, that's not
really related to this series though.

>
> >       return folio->index;
> >  }
>
> ...
>
> Regards,
> Klara Modin
>

