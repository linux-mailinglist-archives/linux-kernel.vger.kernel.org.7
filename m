Return-Path: <linux-kernel+bounces-792678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D07B3C77E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 04:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33CB3B25C2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 02:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2FA2652A6;
	Sat, 30 Aug 2025 02:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lmj1+lj1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E05E264A77
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 02:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756521693; cv=none; b=oDR7iYXCm6En9nEyuEhwpoKQoJnlnWNy4eNkz+Mrx/FUFmHd6dbsbkhOc36WAZuRC+ZGkZ7AHV/YeG++HjbBRsq/Z8fOfmvUpfffg/f8/VheKGcGpZoQjELwN9JU3RMn6+YPJhKXo6s69DF3q15NmkSZ6a2frv5+eY27kQ2/PZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756521693; c=relaxed/simple;
	bh=5G9qiu/3oCfZ8wkaAtF7wRf2rZ6I1+X24VOlhJZYYtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlQZYxsZTpZiK4VY7r3lJrB9kvqXOdmDILhOL0cPGTzLnttzbkefZrKbB2jVAgma0WB2FZ1rcu11aUE9VtFYovrYX9WGTKEskkAFWKJUosW+Ty3cEG36snGlfAjTCNEGsCfTDuCTXDnKogxhuAi622KoiV6aYoXbaHT79Oji8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lmj1+lj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620C8C4AF0B
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 02:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756521692;
	bh=5G9qiu/3oCfZ8wkaAtF7wRf2rZ6I1+X24VOlhJZYYtQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Lmj1+lj1X0oKH8Bz7zcE+7CjtnLbobOZgOsOS0OZ11HW12V1HTsUZHm3kAnA9IUFh
	 HR0VApKVkD1yXmO03fFQ2ibG25ZU6TB9fgN3MLUlx9LhX7JON14IvSdascHebI+znw
	 kgovQrd+UZtN9YmyJ6AJZ1ebbvcOsKSC8YsUp1j2oQyDf4zXnERo4cblWLMkNM0BmV
	 wcBbL1QVwHVGB4GEbYAHWyjUGo9BbOIFs9ZgcRmenQS42eA80pymonFjjDWmrL0VhA
	 qdeawbBU9LLyelfVuk2Kf/BN4To2TGgCbsIyX3PV0/tC1Qj7VltSWbEJpzNW4iLDc4
	 nNJUMiZ5AigBw==
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e931cddb0e2so2418655276.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:41:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV7ynTamg8kTfYRHxcbMiChQQtoGZH7lAHDKlRZ2FzO/fOTGv7uOe2nL1q2Hi7oHRQK0ejymwh5hFc1B7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/+u4k+UTe3AYLpEoYJkNJfd3ApTJcz/AePxWxr9GUi08blfFe
	2L0ZMGYDMA0S4UfasGoo9PaEIPcD8yhCAO3GLRnMApVeDqmPf/cIBjhpPO8rV+Qix29f8YlsykD
	4/WEIOklKGLUA2LcCDMLZooymiXvafSuz0nykbI2VqQ==
X-Google-Smtp-Source: AGHT+IGQ/k6INOYWvFdwTiuHTFlhFF5y46EnkbBNJMpXn3ZucQkUXRKv0aX51LSFkQRpwfIt0tzcNZNittrjRchbbbM=
X-Received: by 2002:a05:690c:490b:b0:721:6adc:4364 with SMTP id
 00721157ae682-722764cb124mr8314527b3.33.1756521691714; Fri, 29 Aug 2025
 19:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-6-ryncsn@gmail.com>
 <0fc6e083-b7be-4144-a50c-d1a7a2e1c3a5@linux.alibaba.com> <CAMgjq7A7_ZbSWJQj8wjhPb6vt=iLhHc5r=cJdzMeNpog-PcstQ@mail.gmail.com>
In-Reply-To: <CAMgjq7A7_ZbSWJQj8wjhPb6vt=iLhHc5r=cJdzMeNpog-PcstQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 29 Aug 2025 19:41:20 -0700
X-Gmail-Original-Message-ID: <CACePvbV=HkuP8w=LvifvAv1O8VD0V0XPOfckVtLiEfHS3NnhZA@mail.gmail.com>
X-Gm-Features: Ac12FXxQ_kp6T58GjnYmxVVATJWYvm8TfahAQG6V-Cc0HTgxhU7fBqlqLgbOncI
Message-ID: <CACePvbV=HkuP8w=LvifvAv1O8VD0V0XPOfckVtLiEfHS3NnhZA@mail.gmail.com>
Subject: Re: [PATCH 5/9] mm/shmem, swap: remove redundant error handling for
 replacing folio
To: Kairui Song <ryncsn@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Nhat Pham <nphamcs@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 2:46=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Mon, Aug 25, 2025 at 11:09=E2=80=AFAM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
> >
> >
> >
> > On 2025/8/23 03:20, Kairui Song wrote:
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > Shmem may replace a folio in the swap cache if the cached one doesn't
> > > fit the swapin's GFP zone. When doing so, shmem has already double
> > > checked that the swap cache folio is locked, still has the swap cache
> > > flag set, and contains the wanted swap entry. So it is impossible to
> > > fail due to an Xarray mismatch. There is even a comment for that.
> > >
> > > Delete the defensive error handling path, and add a WARN_ON instead:
> > > if that happened, something has broken the basic principle of how the
> > > swap cache works, we should catch and fix that.
> > >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> > >   mm/shmem.c | 28 +++-------------------------
> > >   1 file changed, 3 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index b4d39f2a1e0a..e03793cc5169 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -2158,35 +2158,13 @@ static int shmem_replace_folio(struct folio *=
*foliop, gfp_t gfp,
> > >       /* Swap cache still stores N entries instead of a high-order en=
try */
> > >       xa_lock_irq(&swap_mapping->i_pages);
> > >       for (i =3D 0; i < nr_pages; i++) {
> > > -             void *item =3D xas_load(&xas);
> > > -
> > > -             if (item !=3D old) {
> > > -                     error =3D -ENOENT;
> > > -                     break;
> > > -             }
> > > -
> > > -             xas_store(&xas, new);
> > > +             WARN_ON_ONCE(xas_store(&xas, new));
> > >               xas_next(&xas);
> > >       }
> > > -     if (!error) {
> > > -             mem_cgroup_replace_folio(old, new);
> > > -             shmem_update_stats(new, nr_pages);
> > > -             shmem_update_stats(old, -nr_pages);
> > > -     }
> >
> > It looks like the shmem statistics update was mistakenly deleted?
>
> Ah, you are right, I'll need to add it back. I somehow misread this as
> the error handling path. Need to add it back just drop the !error
> check.

+1, I will wait for your next version then. Otherwise the patch looks
fine to me.

Chris

