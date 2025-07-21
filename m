Return-Path: <linux-kernel+bounces-739727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D41B0CA27
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3471AA4486
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4832D3757;
	Mon, 21 Jul 2025 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE91d7zQ"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5082B9A8
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753120529; cv=none; b=tCUfOtRkP6FdQhsdIfU/PJIDs8sRrtNIelickpUz4gKp4OxyiaqMbhLdeOOeAzXX+QDXhH7+p866BjIAMKs6FrrWluPq/nDX7JmkonsPfwsjQEo43+9c2rOuBAY3xqK3fJ1CocZTt9EQfRqQp1dMCl+Xoc2S74PI2mm9hQI0NNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753120529; c=relaxed/simple;
	bh=J/GTbWq5CcAKSYtdDXxxTwOI5UWLGo5DfIaZSWUrdVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGc1FIkQS0eBymICTBNEP3ujZUZ3DHd+0KuwiIi7Cq98S+C/Q3bNEJ1rM8Jl5jIj2IAmLhv+VC3b9cI66AtUCKD9ct9uyx3qAL6bZLBCAKpObkr2OPyOLOkJ926tstLc4Sy2SZ9h+siFOw24YOt1MEephIQfddIUMTP4Tg7TGR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XE91d7zQ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32b43c5c04fso51038021fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753120526; x=1753725326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrkuuoMFnjNnyN4EGKSAvsjDnC4VRrZnL1lKzFulqZo=;
        b=XE91d7zQpZYvrqS3kb4dIUGyZzXZu5Ye2GvlGWljnJs9+rsfbdBSUq43TttvJK+Nbi
         tqoZbmBMnkfPEL64SnVhVKiXq/FZyK6EFPRq+x2l5N9AdeLYAlUBAsUqWs09pm+FwuDB
         2glmyRdgVF6HbkPO99d983sFn6U3k1K6Vu4cUkzuhz1PAz0PgGOIEAl0mkuFhCyopqrU
         in2fUY8CeS6WIAZwCybf2HIcczgyzydp8AMweczPPNdO1CVPX3YjNx0LE1aMxV8g79Ij
         91oQBDr5XvLWretSsrVb+tObrdNWLOAjGQGnOgoFSV/X87+S9FcK0KFSVuUKuf9A4uwX
         8KKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753120526; x=1753725326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrkuuoMFnjNnyN4EGKSAvsjDnC4VRrZnL1lKzFulqZo=;
        b=Cz3fA4oGcKGL55NTH6snHpcaXT8ytJuQA5xs7FAxNRtfZ0zIcXfEcPXAsotYXXJw0m
         yTK/R5ywmd9zfWuPQxVJwVE9Djca1dc8oYpZbI91/KbLz08Fy4oGQjdKz0UqtsoSiyGZ
         eou6vEERV1jJM0xN9lbGxJEDSkOA2+QB8fy45SMcdbTtZZBR2Q32LS8kLylwczGTX6u0
         hKzdqQxQHlIghJTuxeOzFncW3TPWGdwud++LyPWJwhfKe/uuk5Y7cm/mdzCW7BtJWSg8
         U5onWNhFOnkLKpZs43ET6yrxYJjHMJbPRX1y9nWMqgz5JWTZI8maIYsfHxGItC+NimgX
         KfBA==
X-Forwarded-Encrypted: i=1; AJvYcCWhBV/bRStiF1E0qB7e60Y+tu4n7y2Fda8u47zi0YBYk9JtEx5cGI6zgbB9EarynnhLJ+Fm8+/N/SF+aCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4klw5QgbEAPSG+BTyIqigvhJOY/qLcl0crNW0TaSoXZTa/G53
	InZVIGFzO3kngA3MqJ3cxQSI3X3IbmZkzbuZLa3vhxNzvVNvn/j9qSJ0u8dce3D6rdhNDE2d4LS
	lbV2Eu9SqORwTNQfyPoZBKV9EiiiPolE=
X-Gm-Gg: ASbGncu6NvmLjJMi2o4qeIO/Pk8mkvp0BpQ1zvJEkpwPV2t2fI+beSOch6wH/zavoxg
	6afNh4LxOrpBtopM0YItMezzLBuYAUMYpiE4joojpgpVkt2aWQiB3z36kNV8ZRAzsC7oYQuwboQ
	zYyWrXGmIKy3/1Ph4iu8WZ9BQptgtk7nYhZWdjPLBYYAnEgmsMe54xCA7ov8nzyBFT1Dp+04msT
	69a4NwW
X-Google-Smtp-Source: AGHT+IEBZNG4EAB29FW7u+2QKV577OMsk1kn2rLGCVkV0FCNpxuApY+lFJ80jIdavWr5znA+wJbXYBWPwP7A+gd51NI=
X-Received: by 2002:a2e:8a82:0:b0:32b:968d:1fe4 with SMTP id
 38308e7fff4ca-330d264bdb2mr703831fa.14.1753120525308; Mon, 21 Jul 2025
 10:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87beaec6-a3b0-ce7a-c892-1e1e5bd57aa3@google.com>
In-Reply-To: <87beaec6-a3b0-ce7a-c892-1e1e5bd57aa3@google.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 22 Jul 2025 01:54:47 +0800
X-Gm-Features: Ac12FXzuKPqdRzilZJZ9PfrOhS-4V7Snv2ZZdRZ9zGzCBekbhLwa5jp9bupPS-M
Message-ID: <CAMgjq7CtLM0psoHmSguv6SFH3BH+vMOn7CJnjVxnUhoc_chTuA@mail.gmail.com>
Subject: Re: [PATCH mm-new 1/2] mm/shmem: hold shmem_swaplist spinlock (not
 mutex) much less
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 4:06=E2=80=AFPM Hugh Dickins <hughd@google.com> wro=
te:
>
> A flamegraph (from an MGLRU load) showed shmem_writeout()'s use of the
> global shmem_swaplist_mutex worryingly hot: improvement is long overdue.
>
> 3.1 commit 6922c0c7abd3 ("tmpfs: convert shmem_writepage and enable swap"=
)
> apologized for extending shmem_swaplist_mutex across add_to_swap_cache(),
> and hoped to find another way: yes, there may be lots of work to allocate
> radix tree nodes in there.  Then 6.15 commit b487a2da3575 ("mm, swap:
> simplify folio swap allocation") will have made it worse, by moving
> shmem_writeout()'s swap allocation under that mutex too (but the worrying
> flamegraph was observed even before that change).
>
> There's a useful comment about pagelock no longer protecting from evictio=
n
> once moved to swap cache: but it's good till shmem_delete_from_page_cache=
()
> replaces page pointer by swap entry, so move the swaplist add between the=
m.
>
> We would much prefer to take the global lock once per inode than once per
> page: given the possible races with shmem_unuse() pruning when !swapped
> (and other tasks racing to swap other pages out or in), try the swaplist
> add whenever swapped was incremented from 0 (but inode may already be on
> the list - only unuse and evict bother to remove it).
>
> This technique is more subtle than it looks (we're avoiding the very lock
> which would make it easy), but works: whereas an unlocked list_empty()
> check runs a risk of the inode being unqueued and left off the swaplist
> forever, swapoff only completing when the page is faulted in or removed.
>
> The need for a sleepable mutex went away in 5.1 commit b56a2d8af914
> ("mm: rid swapoff of quadratic complexity"): a spinlock works better now.
>
> This commit is certain to take shmem_swaplist_mutex out of contention,
> and has been seen to make a practical improvement (but there is likely
> to have been an underlying issue which made its contention so visible).
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/shmem.c | 59 ++++++++++++++++++++++++++++++------------------------
>  1 file changed, 33 insertions(+), 26 deletions(-)

Thanks a lot! I've also seen this issue, and we observed this
contention on 5.4 kernels and I wasn't sure about how we can optimize
it. This is very helpful.

> diff --git a/mm/shmem.c b/mm/shmem.c
> index 60247dc48505..33675361031b 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -292,7 +292,7 @@ bool vma_is_shmem(struct vm_area_struct *vma)
>  }
>
>  static LIST_HEAD(shmem_swaplist);
> -static DEFINE_MUTEX(shmem_swaplist_mutex);
> +static DEFINE_SPINLOCK(shmem_swaplist_lock);
>
>  #ifdef CONFIG_TMPFS_QUOTA
>
> @@ -432,10 +432,13 @@ static void shmem_free_inode(struct super_block *sb=
, size_t freed_ispace)
>   *
>   * But normally   info->alloced =3D=3D inode->i_mapping->nrpages + info-=
>swapped
>   * So mm freed is info->alloced - (inode->i_mapping->nrpages + info->swa=
pped)
> + *
> + * Return: true if swapped was incremented from 0, for shmem_writeout().
>   */
> -static void shmem_recalc_inode(struct inode *inode, long alloced, long s=
wapped)
> +static bool shmem_recalc_inode(struct inode *inode, long alloced, long s=
wapped)
>  {
>         struct shmem_inode_info *info =3D SHMEM_I(inode);
> +       bool first_swapped =3D false;
>         long freed;
>
>         spin_lock(&info->lock);
> @@ -450,8 +453,11 @@ static void shmem_recalc_inode(struct inode *inode, =
long alloced, long swapped)
>          * to stop a racing shmem_recalc_inode() from thinking that a pag=
e has
>          * been freed.  Compensate here, to avoid the need for a followup=
 call.
>          */
> -       if (swapped > 0)
> +       if (swapped > 0) {
> +               if (info->swapped =3D=3D swapped)
> +                       first_swapped =3D true;
>                 freed +=3D swapped;
> +       }
>         if (freed > 0)
>                 info->alloced -=3D freed;
>         spin_unlock(&info->lock);
> @@ -459,6 +465,7 @@ static void shmem_recalc_inode(struct inode *inode, l=
ong alloced, long swapped)
>         /* The quota case may block */
>         if (freed > 0)
>                 shmem_inode_unacct_blocks(inode, freed);
> +       return first_swapped;
>  }
>
>  bool shmem_charge(struct inode *inode, long pages)
> @@ -1399,11 +1406,11 @@ static void shmem_evict_inode(struct inode *inode=
)
>                         /* Wait while shmem_unuse() is scanning this inod=
e... */
>                         wait_var_event(&info->stop_eviction,
>                                        !atomic_read(&info->stop_eviction)=
);
> -                       mutex_lock(&shmem_swaplist_mutex);
> +                       spin_lock(&shmem_swaplist_lock);
>                         /* ...but beware of the race if we peeked too ear=
ly */
>                         if (!atomic_read(&info->stop_eviction))
>                                 list_del_init(&info->swaplist);
> -                       mutex_unlock(&shmem_swaplist_mutex);
> +                       spin_unlock(&shmem_swaplist_lock);
>                 }
>         }
>
> @@ -1526,7 +1533,7 @@ int shmem_unuse(unsigned int type)
>         if (list_empty(&shmem_swaplist))
>                 return 0;
>
> -       mutex_lock(&shmem_swaplist_mutex);
> +       spin_lock(&shmem_swaplist_lock);
>  start_over:
>         list_for_each_entry_safe(info, next, &shmem_swaplist, swaplist) {
>                 if (!info->swapped) {
> @@ -1540,12 +1547,12 @@ int shmem_unuse(unsigned int type)
>                  * (igrab() would protect from unlink, but not from unmou=
nt).
>                  */
>                 atomic_inc(&info->stop_eviction);
> -               mutex_unlock(&shmem_swaplist_mutex);
> +               spin_unlock(&shmem_swaplist_lock);
>
>                 error =3D shmem_unuse_inode(&info->vfs_inode, type);
>                 cond_resched();
>
> -               mutex_lock(&shmem_swaplist_mutex);
> +               spin_lock(&shmem_swaplist_lock);
>                 if (atomic_dec_and_test(&info->stop_eviction))
>                         wake_up_var(&info->stop_eviction);
>                 if (error)
> @@ -1556,7 +1563,7 @@ int shmem_unuse(unsigned int type)
>                 if (!info->swapped)
>                         list_del_init(&info->swaplist);
>         }
> -       mutex_unlock(&shmem_swaplist_mutex);
> +       spin_unlock(&shmem_swaplist_lock);
>
>         return error;
>  }
> @@ -1646,30 +1653,30 @@ int shmem_writeout(struct folio *folio, struct sw=
ap_iocb **plug,
>                 folio_mark_uptodate(folio);
>         }
>
> -       /*
> -        * Add inode to shmem_unuse()'s list of swapped-out inodes,
> -        * if it's not already there.  Do it now before the folio is
> -        * moved to swap cache, when its pagelock no longer protects
> -        * the inode from eviction.  But don't unlock the mutex until
> -        * we've incremented swapped, because shmem_unuse_inode() will
> -        * prune a !swapped inode from the swaplist under this mutex.
> -        */
> -       mutex_lock(&shmem_swaplist_mutex);
> -       if (list_empty(&info->swaplist))
> -               list_add(&info->swaplist, &shmem_swaplist);
> -
>         if (!folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOMEMALLOC | __GF=
P_NOWARN)) {
> -               shmem_recalc_inode(inode, 0, nr_pages);
> +               bool first_swapped =3D shmem_recalc_inode(inode, 0, nr_pa=
ges);
> +
> +               /*
> +                * Add inode to shmem_unuse()'s list of swapped-out inode=
s,
> +                * if it's not already there.  Do it now before the folio=
 is
> +                * removed from page cache, when its pagelock no longer
> +                * protects the inode from eviction.  And do it now, afte=
r
> +                * we've incremented swapped, because shmem_unuse() will
> +                * prune a !swapped inode from the swaplist.
> +                */
> +               if (first_swapped) {
> +                       spin_lock(&shmem_swaplist_lock);
> +                       if (list_empty(&info->swaplist))
> +                               list_add(&info->swaplist, &shmem_swaplist=
);
> +                       spin_unlock(&shmem_swaplist_lock);
> +               }
> +
>                 swap_shmem_alloc(folio->swap, nr_pages);
>                 shmem_delete_from_page_cache(folio, swp_to_radix_entry(fo=
lio->swap));
>
> -               mutex_unlock(&shmem_swaplist_mutex);
>                 BUG_ON(folio_mapped(folio));
>                 return swap_writeout(folio, plug);
>         }
> -       if (!info->swapped)
> -               list_del_init(&info->swaplist);
> -       mutex_unlock(&shmem_swaplist_mutex);
>         if (nr_pages > 1)
>                 goto try_split;
>  redirty:
> --
> 2.43.0

Reviewed-by: Kairui Song <kasong@tencent.com>

