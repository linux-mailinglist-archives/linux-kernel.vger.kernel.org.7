Return-Path: <linux-kernel+bounces-805429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B23B4886D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD283B797E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF142F068E;
	Mon,  8 Sep 2025 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iga563uX"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C4D2EFD81
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323747; cv=none; b=kqoz4JGhZJxKVhKeof5z5tt/BzUuPGQ5QVUwcG01Kf2FFhAMBNK7WIvNfuGngJEnV0hXLue1JwoNgRsR6sFFM0yRKjuwwJnF0AbKXqDq0IOIfhMuINzun7z1iA+qidsxpCH03VvxMtbHKY+Y04jNaUMWaogoVlux5DO3V2/l0U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323747; c=relaxed/simple;
	bh=dvTFtkpvbBAQ74mYvHwTRIWN4szgqSmdrZSt7X8douQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Py3TnsGTi4DR0oL0BHAl3Q8edsEcfUp8C1JLVR0RB48TZ0Vycx86gOMP66unnT/fLWGMsNLi8IsFX4mV9gqX56ye70Zn5d9va0P3xr52AntKI3huRiNDAyiryPbnuB8ACswyO+vFCIL68V7+Cdjo/CllP/pNdE7hNiIymr3Wdkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iga563uX; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6229f5ed47fso2913983a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757323743; x=1757928543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ooin1G88GdZ0+3wSDhxUHtkMqwER0rPq5jXYI5jvdI=;
        b=iga563uX2y9W8KwNlyfm/v0L3S1Wlizww67ICjgR737TCRG/Ng4J89+dogPcLp2S4D
         13QJYviocLuuwTLz6pYeilZl+oy8ckl2NEa7TEqOCMdldiJNJwwGJueZ0q0ptHX2Tkh6
         HFB/Z6OM5I7f+//NENHVzmEQ+qWI0bL28f14qYp87mLJO8mbThGt2wHM80kUy2WCJII7
         nZ5684FL8KBS62Dz5huj08ZSeuwgVTI6z9kTKzgpa7Tqru49b9BSyt9HmV/g8G4wlpXX
         Bx/jFwKhFIfDBXIfqTe0p+kKvu9Yhpx2vfGygmftQjNllLfeO0Ree3zLFxZYnIgxdtHZ
         Q4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757323743; x=1757928543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ooin1G88GdZ0+3wSDhxUHtkMqwER0rPq5jXYI5jvdI=;
        b=h/kQvVEvZBB39NCeQ5wCU5tx6aHiPGjKSz05vsQqJ3EtBn/uR+LzBYpDHatdz024F1
         uoloWyt5JsjCzvcftseAg5DLLBtsNUDdrHjKXUBJmJzHlfgSnvF+tnyGkTLd1VnVoeRK
         uaJf5r43a4s+IdtYA/R+TVRgTABPCPKkCi0CiOfkV3SuvJCOwdlyuKHIFev1uNHK404P
         aneTTz6oURxCQUfKwhZbD/fgYmYHds9651dwdMq6zGk0VGUUIZYb1orCHc5YmLx/wEbo
         3th9qc7pqoPzzp/KkjTidHZiplbAGlrBmyMIKx87e/r+4kDwrxzi8oYBRe7Vi5iJpF+N
         hi2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJOVGo1gxpJBsTbqmRcPhXE+bt8m+nwQdhbxjX0aR69i/J/u03yrqg7j+9sMpSWRpeBPZ1DQAXORPj0lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyuZnqqTUPD5DnCb53xxZag1AjqLQkV3DATRDfZDSIFzfWH/FM
	FmwwHKvaImqmLxQLwXCv/UTWHFFAXQ6HCGcu/InAJDQZUgxGLwQgYw9AyH7zq0ERh+ii3a1ivDp
	c/f75CRk+L39cXiLXjP9vIbOMJOI/nC4=
X-Gm-Gg: ASbGncvIUDrXQlu4+dBrwJTLYYtqsIOlRsvB0mCoo+Hd5h+bjXJuYPpSTyfw5nH7eSO
	SSySD4jm3KFYawSJmQVFrRZUbHIMCSDZZKr9RuZEdfpDPRxqjfCk7NTGlQ9f2GOkhBiZXUbmps6
	Iwk+8PbeQX4s+hjOikkzFrLt9OPDzN0dz9piVoUDajXNgBl+48tNOkgXZVw9+ajv7eI8O27G+sH
	8ZrHdE3Nk+fABwvHZDEYQ==
X-Google-Smtp-Source: AGHT+IEOq1WZvNp7RsZJzT2joT2V7EGbKS0rr1lEaYYRTxNqeng2QJ7n+ufynse4ZchY5MrJtEMb73i93D4BHKB+qzk=
X-Received: by 2002:a05:6402:1eca:b0:627:4ee2:311b with SMTP id
 4fb4d7f45d1cf-6274ee234c9mr4021795a12.10.1757323743116; Mon, 08 Sep 2025
 02:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-9-ryncsn@gmail.com>
 <1ee09786-ed3c-485e-99e4-48c4d2b92ced@linux.alibaba.com>
In-Reply-To: <1ee09786-ed3c-485e-99e4-48c4d2b92ced@linux.alibaba.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 8 Sep 2025 17:28:25 +0800
X-Gm-Features: AS18NWBOELUCiaRBWWIvM9ECMaTp2eBhzWUmPrmjMqEJtKCwjrbscaUw6f9dQlg
Message-ID: <CAMgjq7DPgUNT41pS+591UUR2TfR5pCrABD8y6CKWF-ENpPBN0g@mail.gmail.com>
Subject: Re: [PATCH v2 08/15] mm/shmem, swap: remove redundant error handling
 for replacing folio
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 2:04=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/9/6 03:13, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > Shmem may replace a folio in the swap cache if the cached one doesn't
> > fit the swapin's GFP zone. When doing so, shmem has already double
> > checked that the swap cache folio is locked, still has the swap cache
> > flag set, and contains the wanted swap entry. So it is impossible to
> > fail due to an Xarray mismatch. There is even a comment for that.
> >
> > Delete the defensive error handling path, and add a WARN_ON instead:
> > if that happened, something has broken the basic principle of how the
> > swap cache works, we should catch and fix that.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > ---
> >   mm/shmem.c | 42 ++++++++++++------------------------------
> >   1 file changed, 12 insertions(+), 30 deletions(-)
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 4e27e8e5da3b..cc6a0007c7a6 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1698,13 +1698,13 @@ int shmem_writeout(struct folio *folio, struct =
swap_iocb **plug,
> >               }
> >
> >               /*
> > -              * The delete_from_swap_cache() below could be left for
> > +              * The swap_cache_del_folio() below could be left for
> >                * shrink_folio_list()'s folio_free_swap() to dispose of;
> >                * but I'm a little nervous about letting this folio out =
of
> >                * shmem_writeout() in a hybrid half-tmpfs-half-swap stat=
e
> >                * e.g. folio_mapping(folio) might give an unexpected ans=
wer.
> >                */
> > -             delete_from_swap_cache(folio);
> > +             swap_cache_del_folio(folio);
> >               goto redirty;
> >       }
>
> You should reorganize your patch set, as the swap_cache_del_folio()
> function is introduced in patch 9.
>
> >       if (nr_pages > 1)
> > @@ -2082,7 +2082,7 @@ static struct folio *shmem_swap_alloc_folio(struc=
t inode *inode,
> >       new->swap =3D entry;
> >
> >       memcg1_swapin(entry, nr_pages);
> > -     shadow =3D get_shadow_from_swap_cache(entry);
> > +     shadow =3D swap_cache_get_shadow(entry);
>
> Ditto.
>
> >       if (shadow)
> >               workingset_refault(new, shadow);
> >       folio_add_lru(new);
> > @@ -2158,35 +2158,17 @@ static int shmem_replace_folio(struct folio **f=
oliop, gfp_t gfp,
> >       /* Swap cache still stores N entries instead of a high-order entr=
y */
> >       xa_lock_irq(&swap_mapping->i_pages);
> >       for (i =3D 0; i < nr_pages; i++) {
> > -             void *item =3D xas_load(&xas);
> > -
> > -             if (item !=3D old) {
> > -                     error =3D -ENOENT;
> > -                     break;
> > -             }
> > -
> > -             xas_store(&xas, new);
> > +             WARN_ON_ONCE(xas_store(&xas, new));
> >               xas_next(&xas);
> >       }
> > -     if (!error) {
> > -             mem_cgroup_replace_folio(old, new);
> > -             shmem_update_stats(new, nr_pages);
> > -             shmem_update_stats(old, -nr_pages);
> > -     }
> >       xa_unlock_irq(&swap_mapping->i_pages);
> >
> > -     if (unlikely(error)) {
> > -             /*
> > -              * Is this possible?  I think not, now that our callers
> > -              * check both the swapcache flag and folio->private
> > -              * after getting the folio lock; but be defensive.
> > -              * Reverse old to newpage for clear and free.
> > -              */
> > -             old =3D new;
> > -     } else {
> > -             folio_add_lru(new);
> > -             *foliop =3D new;
> > -     }
> > +     mem_cgroup_replace_folio(old, new);
> > +     shmem_update_stats(new, nr_pages);
> > +     shmem_update_stats(old, -nr_pages);
> > +
> > +     folio_add_lru(new);
> > +     *foliop =3D new;
> >
> >       folio_clear_swapcache(old);
> >       old->private =3D NULL;
> > @@ -2220,7 +2202,7 @@ static void shmem_set_folio_swapin_error(struct i=
node *inode, pgoff_t index,
> >       nr_pages =3D folio_nr_pages(folio);
> >       folio_wait_writeback(folio);
> >       if (!skip_swapcache)
> > -             delete_from_swap_cache(folio);
> > +             swap_cache_del_folio(folio);
> >       /*
> >        * Don't treat swapin error folio as alloced. Otherwise inode->i_=
blocks
> >        * won't be 0 when inode is released and thus trigger WARN_ON(i_b=
locks)
> > @@ -2459,7 +2441,7 @@ static int shmem_swapin_folio(struct inode *inode=
, pgoff_t index,
> >               folio->swap.val =3D 0;
> >               swapcache_clear(si, swap, nr_pages);
> >       } else {
> > -             delete_from_swap_cache(folio);
> > +             swap_cache_del_folio(folio);

Oh you are right, or I should keep the delete_from_swap_cache here.

Let me just rebase and move this patch later then. Thanks!

> >       }
> >       folio_mark_dirty(folio);
> >       swap_free_nr(swap, nr_pages);
>
>

