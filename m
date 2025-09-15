Return-Path: <linux-kernel+bounces-817417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FA2B581F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5279116A1FE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364252641CA;
	Mon, 15 Sep 2025 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeM7OfYn"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FC81F419B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953520; cv=none; b=X3jxSxNAPyPNB/pxr8HJnAprRZivau2jv80N93CUIeC797DZ3Ivhd1E8B8QG6GyGMxRaTvgzDx+CMZ6xSpr0Rg+CTNDA+d/Z0JEmfr2lXFQKlpxbu8pdvcUrVQlr0p+GAQk7FMfx81R2K+qT9oWIaycO/q6txwtrRfZ4cvtSz8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953520; c=relaxed/simple;
	bh=m0VcHa+/JHQJXf451OE9Te576i9puC8LakrJ7RgeKaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAS4baK1o5P4b9hauStz/zDMcR4lRiy8NdVMYFn4NFi6CL8YToK6hvw2YMjZAKsY4C9dHBCm+C7vsXW+agY8F3ia423xAHVhmXb+rJHg2DbY5jS07Qr8uflYpDijH1Lo5GTZ3bmgALQdLbskiO19/P1318qwg2/D7nP2gG+pW58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeM7OfYn; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b0787fa12e2so624180666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757953517; x=1758558317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMJNhdJv+scko5BawZPjnYJ0aP4LRJcbG8zsCsFfSa8=;
        b=IeM7OfYnTnWYba7Y9J2y8K8XetUEskes40N9e3akzAtLCEEGlmHmMys68RinqaeXk3
         NLMUT75g++ECaFViOop+HiqEkHNlr5jvHh5Xyx2p7GgPKA+aF6kUFkeDlVPCxrNR4KT6
         wpTZpc33kdy2HYciBIvwO8SZtSx4Up7qu7hHEMJV/iF50dR0uWinqORvhHhKwztrmU4x
         rOzp/vzvZIwrnp7HSS6n5BsSJS/NmdhBoTA+2IUPQPsVCT4hN/NmOV7vVhdJTry6O1SS
         o4/tRNr/SHkxE7fRDTdYlWeZNTwj3jg+HN5oTEl3ssC8XDkyJxB9SJH0xRQNcylrIp7l
         Ps7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953517; x=1758558317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMJNhdJv+scko5BawZPjnYJ0aP4LRJcbG8zsCsFfSa8=;
        b=NiqQT0ycOvBkMmAt6RsYE3kHXHVLvoObtGtqo3GEKDSutOHYIJtv2NvlEKDWQ9sWny
         ozRmKxRu+l6uYAzP85W0fvU7YkHFblmWaPySbBGbAdVyRzY2fPUkw8fxiQA4Xr0KAWJR
         Pze9vGZqETozIdBGk0+UuhS5Benp4t0q3+kV9NqsrV6fKgJibqlIBvCGoFOZJsovIKwJ
         Fpm9/QAN+EhFcoZBlaE5JTuhrgP6uRwAGzHt+PaLACF2v4r2YDZs0nWGB2tC8uykiSbL
         vH6BKO8ajtAowQs/pQHqcFeV/NRv7X4zo/vsaDOdnhOzOAb3F/gdqPl4ubCl32O7cHYf
         ohow==
X-Forwarded-Encrypted: i=1; AJvYcCUJ4FmlgSG6lqG8Kt+M3/NZNh7XieigiVZG31vS9fTuVV0ckMd93gqgRNb47VXP2BKC/ozp+SddK0FRmSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLQ7StaMRGU7CH0eObginbwVg0tw2dyW5drWO275y0I/lVNHs8
	XkBNqWJHHU9wytqUhsB5LxABh24aRtXNSOPwWj9WFflvqziqAt2IkhN0ndmb3UtswWydj9r58lT
	Zi5DMsTZ6tmIOaAlb+QRBsucRLimgavE=
X-Gm-Gg: ASbGncshvAlPv2xZ+7VJTXsCQCEod+wcK1Nn42eebnV4MUR7EXYVMjyI60lVETJFEp9
	7cMXZUXoLMIvKOiSr+ZPxOOBcng3ieOdZTdhph+rqkiTzMeiXGHofihQi9vTL8B0flm5FVnuJzH
	8UAOJBfyJ/r34qTgBeFwghFrVVZ8+iBp+0u5RTXmN2+lsHjso+vHMwUCpbuc7jTmOR4KFDklvxC
	wdhQzidttZrhN3IErnG+Q==
X-Google-Smtp-Source: AGHT+IGKKrKGYhH6a3eAVycEo8JHovvecpIDVESUCCwt0LR+vetnxGlT4YcHWXMDxH271NLb0pokN/iSIjUZjGOiddg=
X-Received: by 2002:a17:907:6ea8:b0:b04:37b2:c184 with SMTP id
 a640c23a62f3a-b07c35d4be0mr1434123466b.25.1757953516544; Mon, 15 Sep 2025
 09:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910160833.3464-15-ryncsn@gmail.com> <20250915150719.3446727-1-clm@meta.com>
In-Reply-To: <20250915150719.3446727-1-clm@meta.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 16 Sep 2025 00:24:39 +0800
X-Gm-Features: AS18NWDS6bsQxblqYbh_bcvmIy7iEJRQRRFAqbNTw1YIXPg7Vr1ljkQHLNBiatg
Message-ID: <CAMgjq7A1hqQ+yboCtT+JF=5Tfijph2s4ooSqNwnexQ9kwJOCtA@mail.gmail.com>
Subject: Re: [PATCH v3 14/15] mm, swap: implement dynamic allocation of swap table
To: Chris Mason <clm@meta.com>
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

On Mon, Sep 15, 2025 at 11:55=E2=80=AFPM Chris Mason <clm@meta.com> wrote:
>
> On Thu, 11 Sep 2025 00:08:32 +0800 Kairui Song <ryncsn@gmail.com> wrote:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > Now swap table is cluster based, which means free clusters can free its
> > table since no one should modify it.
> >
> > There could be speculative readers, like swap cache look up, protect
> > them by making them RCU protected. All swap table should be filled with
> > null entries before free, so such readers will either see a NULL pointe=
r
> > or a null filled table being lazy freed.
> >
> > On allocation, allocate the table when a cluster is used by any order.
> >
> > This way, we can reduce the memory usage of large swap device
> > significantly.
> >
> > This idea to dynamically release unused swap cluster data was initially
> > suggested by Chris Li while proposing the cluster swap allocator and
> > it suits the swap table idea very well.
> >
> > Co-developed-by: Chris Li <chrisl@kernel.org>
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Acked-by: Chris Li <chrisl@kernel.org>
> > ---
> >  mm/swap.h       |   2 +-
> >  mm/swap_state.c |   9 +--
> >  mm/swap_table.h |  37 ++++++++-
> >  mm/swapfile.c   | 202 ++++++++++++++++++++++++++++++++++++++----------
> >  4 files changed, 199 insertions(+), 51 deletions(-)
> >
>
> [ ... ]
>
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 89659928465e..faf867a6c5c1 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> >
>
> [ ... ]
>
> > +/*
> > + * Allocate a swap table may need to sleep, which leads to migration,
> > + * so attempt an atomic allocation first then fallback and handle
> > + * potential race.
> > + */
> > +static struct swap_cluster_info *
> > +swap_cluster_alloc_table(struct swap_info_struct *si,
> > +                      struct swap_cluster_info *ci,
> > +                      int order)
> >  {
> > -     unsigned int ci_off;
> > -     unsigned long swp_tb;
> > +     struct swap_cluster_info *pcp_ci;
> > +     struct swap_table *table;
> > +     unsigned long offset;
> >
> > -     if (!ci->table)
> > -             return;
> > +     /*
> > +      * Only cluster isolation from the allocator does table allocatio=
n.
> > +      * Swap allocator uses a percpu cluster and holds the local lock.
> > +      */
> > +     lockdep_assert_held(&ci->lock);
> > +     lockdep_assert_held(&this_cpu_ptr(&percpu_swap_cluster)->lock);
> > +
> > +     table =3D kmem_cache_zalloc(swap_table_cachep,
> > +                               __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_N=
OWARN);
> > +     if (table) {
> > +             rcu_assign_pointer(ci->table, table);
> > +             return ci;
> > +     }
> > +
> > +     /*
> > +      * Try a sleep allocation. Each isolated free cluster may cause
> > +      * a sleep allocation, but there is a limited number of them, so
> > +      * the potential recursive allocation should be limited.
> > +      */
> > +     spin_unlock(&ci->lock);
> > +     if (!(si->flags & SWP_SOLIDSTATE))
> > +             spin_unlock(&si->global_cluster_lock);
> > +     local_unlock(&percpu_swap_cluster.lock);
> > +     table =3D kmem_cache_zalloc(swap_table_cachep, __GFP_HIGH | GFP_K=
ERNEL);
> >
> > -     for (ci_off =3D 0; ci_off < SWAPFILE_CLUSTER; ci_off++) {
> > -             swp_tb =3D __swap_table_get(ci, ci_off);
> > -             if (!swp_tb_is_null(swp_tb))
> > -                     pr_err_once("swap: unclean swap space on swapoff:=
 0x%lx",
> > -                                 swp_tb);
> > +     local_lock(&percpu_swap_cluster.lock);
> > +     if (!(si->flags & SWP_SOLIDSTATE))
> > +             spin_lock(&si->global_cluster_lock);
> > +     /*
> > +      * Back to atomic context. First, check if we migrated to a new
> > +      * CPU with a usable percpu cluster. If so, try using that instea=
d.
> > +      * No need to check it for the spinning device, as swap is
> > +      * serialized by the global lock on them.
> > +      *
> > +      * The is_usable check is a bit rough, but ensures order 0 succes=
s.
> > +      */
> > +     offset =3D this_cpu_read(percpu_swap_cluster.offset[order]);
> > +     if ((si->flags & SWP_SOLIDSTATE) && offset) {
> > +             pcp_ci =3D swap_cluster_lock(si, offset);
> > +             if (cluster_is_usable(pcp_ci, order) &&
> > +                 pcp_ci->count < SWAPFILE_CLUSTER) {
> > +                     ci =3D pcp_ci;
>                        ^^^^^^^^^^^^^
> ci came from the caller, and in the case of isolate_lock_cluster() they
> had just removed it from a list.  We overwrite ci and return something
> different.

Yes, that's expected. See the comment above. We have just dropped
local lock so it's possible that we migrated to another CPU which has
its own percpu cache ci (percpu_swap_cluster.offset).

To avoid fragmentation, drop the isolated ci and use the percpu ci
instead. But you are right that I need to add the ci back to the list,
or it will be leaked. Thanks!

