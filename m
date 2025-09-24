Return-Path: <linux-kernel+bounces-831301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA696B9C4F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD9E37A9645
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D2C288C2B;
	Wed, 24 Sep 2025 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAylZhzv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9FF287253
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758750961; cv=none; b=DQYqTyI0B3ieD00w65EvUvupdRqzxePTnrezllA8/DFlLTiI5UV+7l7PChwxMot5A/Lji5NfDHdnxnr/MSdHFhwngrfKlCvusToBhAB8yciBsq+J2DdBdHTWcUTM3oh4NrXOJ8BwR2sd6jbKySr2m992K8VR0jjA4ldfslEEsHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758750961; c=relaxed/simple;
	bh=0IApxeWFDP3AXr4lFm31bOZo/GEJt0YPuVBszXf2fe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmfVxKjtBAhQdSD7QRokEBW8JGAC6OLGItxeyDXOZZut8B/Ko5/vh39MEu/iv5FncLEIZqFhM5Mq3HPe60KH+l/JUGCeL4DBTDRnHylr/l2gRG4gVnJVZJZc8bhPrt6PpSF9uLRs+ORtMFYC0CJkTCTOeWEcHGl7Bo7zLz3SJSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAylZhzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54615C2BCAF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758750960;
	bh=0IApxeWFDP3AXr4lFm31bOZo/GEJt0YPuVBszXf2fe8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NAylZhzvpE8YibeqOhfRyvoWOsiHO2udVr4+xohY8enhGyRWIYBmKZL2pitllzF6e
	 LCdQT1FYeCOzkZItCoyPFNbGLNavX43crU81iDv62jAvFGlJSPpOCL7CjlwWNbWpdO
	 U2FavtnWmsi4wMY5L3xlgjGyIa1whmwlt9Je4JQMIDaEaWqq3Xp9U3lL0GZljdvw3X
	 5tlSkxHk1xhWyTQq+Bmb0dk0Nyw56BFi11X85/V117izrsxfGLUdV7vGQVb9AFX+fH
	 LrxaAShYsVdTq2Uz2LiQmE8YpQTUp4jETztLBmyR5IXcycTbuqczT4vpXjYHh7Q4dt
	 BFbTG3INjTL8g==
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-4248b431b41so314995ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:56:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/wPez9h+CjDBRiyL+u+RcMdLvIW4EJwmMi2egjAEhdMNGjKwJnmIYMC6A5d8oXkZq4OOk7lZZzl9BllU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEzn93wwqQ3WOn8ls7y7IMraeJXh9KJWyf5k/6mJwjDUoku1Ux
	VYEdPu00ZbQBTUPWtOm6H58dI93R/aedUpm/vspjDx30F8Fz+0sXyV7cgtsPmjxx6+moRUQLwi+
	7LI1ialt3MGbW1kkw8u2KpkhgyNxEzp3ZB+amtgCl
X-Google-Smtp-Source: AGHT+IFgJBpNuxi3ocERek8ZEjpOAjiislMEQWgqugk5bKqlDdTRvki16pecSgbGbndODqmMuHfBJGffO6pv5HRyXsM=
X-Received: by 2002:a05:6e02:12e6:b0:425:7567:7487 with SMTP id
 e9e14a558f8ab-42594ea7fd2mr3152535ab.5.1758750959188; Wed, 24 Sep 2025
 14:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-1-ryncsn@gmail.com> <20250916160100.31545-10-ryncsn@gmail.com>
In-Reply-To: <20250916160100.31545-10-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 24 Sep 2025 14:55:46 -0700
X-Gmail-Original-Message-ID: <CAF8kJuOyck_4bsy1=Ek2MFADfj9p09_+aQ+59-0NtpSjNHuNGg@mail.gmail.com>
X-Gm-Features: AS18NWBQx31zmrvTS7h1YvQaXb6rQlk-DLD4IkRJLY1_5cZ-sA6anhebF4UaAh0
Message-ID: <CAF8kJuOyck_4bsy1=Ek2MFADfj9p09_+aQ+59-0NtpSjNHuNGg@mail.gmail.com>
Subject: Re: [PATCH v4 09/15] mm/shmem, swap: remove redundant error handling
 for replacing folio
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:02=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> Shmem may replace a folio in the swap cache if the cached one doesn't
> fit the swapin's GFP zone. When doing so, shmem has already double
> checked that the swap cache folio is locked, still has the swap cache
> flag set, and contains the wanted swap entry. So it is impossible to
> fail due to an XArray mismatch. There is even a comment for that.
>
> Delete the defensive error handling path, and add a WARN_ON instead:
> if that happened, something has broken the basic principle of how the
> swap cache works, we should catch and fix that.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Chris Li <chrisl@kernel.org>

Chris

> ---
>  mm/shmem.c | 32 +++++++-------------------------
>  1 file changed, 7 insertions(+), 25 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 077744a9e9da..dc17717e5631 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2121,35 +2121,17 @@ static int shmem_replace_folio(struct folio **fol=
iop, gfp_t gfp,
>         /* Swap cache still stores N entries instead of a high-order entr=
y */
>         xa_lock_irq(&swap_mapping->i_pages);
>         for (i =3D 0; i < nr_pages; i++) {
> -               void *item =3D xas_load(&xas);
> -
> -               if (item !=3D old) {
> -                       error =3D -ENOENT;
> -                       break;
> -               }
> -
> -               xas_store(&xas, new);
> +               WARN_ON_ONCE(xas_store(&xas, new) !=3D old);
>                 xas_next(&xas);
>         }
> -       if (!error) {
> -               mem_cgroup_replace_folio(old, new);
> -               shmem_update_stats(new, nr_pages);
> -               shmem_update_stats(old, -nr_pages);
> -       }
> +
> +       mem_cgroup_replace_folio(old, new);
> +       shmem_update_stats(new, nr_pages);
> +       shmem_update_stats(old, -nr_pages);
>         xa_unlock_irq(&swap_mapping->i_pages);
>
> -       if (unlikely(error)) {
> -               /*
> -                * Is this possible?  I think not, now that our callers
> -                * check both the swapcache flag and folio->private
> -                * after getting the folio lock; but be defensive.
> -                * Reverse old to newpage for clear and free.
> -                */
> -               old =3D new;
> -       } else {
> -               folio_add_lru(new);
> -               *foliop =3D new;
> -       }
> +       folio_add_lru(new);
> +       *foliop =3D new;
>
>         folio_clear_swapcache(old);
>         old->private =3D NULL;
> --
> 2.51.0
>
>

