Return-Path: <linux-kernel+bounces-796400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6BFB4000A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21424189C69D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BF12F83D4;
	Tue,  2 Sep 2025 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvoF5wYz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68B528726E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815488; cv=none; b=j1WlJ0cHn/Lnbw8sKynVlEkSXRI/cGmsMW4Aqpmj7zGjPbdlhEAzJkwzda0UMx0fZlr8fn7Wyn/ya+98np/tLi6W/W+O0mwH+6QlMtd1+BkPolSy/AOBPzt94iyz8Q0xyffdpXQUBKu2N0tRIw+QWUh0zpXKHzylIchRyK9pX3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815488; c=relaxed/simple;
	bh=ZTSQwA+EpSV9+ojOsAvLyoFKMHNvauRlTuvilm25yM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldWVA0BcjnMHFLtle9mGp0+xRlvm18auZESqLmxhcbMVIbCAaBlJ9fb07y9JhVgA576J7iDowb9f9Yg5N2naXbwPH6cGqeYlL0EVk0FaA/zEcdP6SFPChKf4LZaqSu1cJrEWtlbUHPnviioBQAtsxh5QRX9VABNKW8gh0r/+sv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvoF5wYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EC5C4CEF9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756815488;
	bh=ZTSQwA+EpSV9+ojOsAvLyoFKMHNvauRlTuvilm25yM4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dvoF5wYzcFG9Nrl6nny3ed0swGUNu7wEsqqlI6jaIUZ7UWokOtEe8tpEM+cpYYl93
	 Xemi+o08AjNxxBWzRTXO8FxLzzbJcxrmrBAQ7hzud0ySVzUUTWkQ3FxH51A5hoGq66
	 7RAm5R+RIHBCDYyxiMAvhH8luvUhtQgG80KgBZgQrl9oZrKXyODkFpiXsVHYVWduDy
	 vg3qArNHOBTeQF0i0Dr1UyNuiBv6bLAprg06d5dS97krGEb6+oYVMM5Iv26mzleYNj
	 REs0jtz7dg0TP55oRyGCgkm9/67SYd/Iwi2MJKm6VKEjAR/3yNoBOfUJKyo6rIg1Pb
	 Q3hgOnOUcWYnQ==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-72267c05050so25649947b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:18:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2pm5kvSHeHp6wjVh4lmjNlNJezvSttKRRPkUvElhRTQ/8pFszbGLIWW8L2jwUuJbJdJ66r+HY4D0LELE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoQMBiSx9vgQ6pllhG6wtuDEyjaroayLnPfVdbzKi2NIAnyKVX
	i2SjVVqZEADxTg2xRToGW/E/YkZZP8j7NLw5IfLoJGBISSzhQfnMRdQacCP2shzpmKUgyf+QIQN
	42VwtooQm8dBh5Opk69Ozr8KITJ6A76L1BJtEuoU86g==
X-Google-Smtp-Source: AGHT+IF/fv8Z/lXj5JP5clHJ8aYfTcZOW+8f7Hi0XMCpJtw1fdJZ8y33yDnQyUMOboAz/G8jvSnLVwL7BHJdmVDe/zg=
X-Received: by 2002:a05:690c:6c8f:b0:722:731d:f622 with SMTP id
 00721157ae682-7227636c98cmr110511477b3.17.1756815487736; Tue, 02 Sep 2025
 05:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806161748.76651-1-ryncsn@gmail.com> <20250806161748.76651-3-ryncsn@gmail.com>
In-Reply-To: <20250806161748.76651-3-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 2 Sep 2025 05:17:56 -0700
X-Gmail-Original-Message-ID: <CACePvbWbNeQ1+nk_BHgFyyFM0m1iQvXqa09iPWTRnsUp5Be_Yg@mail.gmail.com>
X-Gm-Features: Ac12FXwYM-QjowMD2uLpV6vp34CLhFUBAr49slLfUGLs_PraM_RMeUsbnnKX7LE
Message-ID: <CACePvbWbNeQ1+nk_BHgFyyFM0m1iQvXqa09iPWTRnsUp5Be_Yg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm, swap: remove fragment clusters counter
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Wed, Aug 6, 2025 at 9:18=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> From: Kairui Song <kasong@tencent.com>
>
> It was used for calculating the iteration number when the swap allocator
> wants to scan the whole fragment list. Now the allocator only scans one
> fragment cluster at a time, so no one uses this counter anymore.
>
> Remove it as a cleanup; the performance change is marginal:
>
> Build linux kernel using 10G ZRAM, make -j96, defconfig with 2G cgroup
> memory limit, on top of tmpfs, 64kB mTHP enabled:
>
> Before:  sys time: 6278.45s
> After:   sys time: 6176.34s
>
> Change to 8G ZRAM:
>
> Before:  sys time: 5572.85s
> After:   sys time: 5531.49s
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/swap.h | 1 -
>  mm/swapfile.c        | 7 -------
>  2 files changed, 8 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 2fe6ed2cc3fd..a060d102e0d1 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -310,7 +310,6 @@ struct swap_info_struct {
>                                         /* list of cluster that contains =
at least one free slot */
>         struct list_head frag_clusters[SWAP_NR_ORDERS];
>                                         /* list of cluster that are fragm=
ented or contented */
> -       atomic_long_t frag_cluster_nr[SWAP_NR_ORDERS];
>         unsigned int pages;             /* total of usable pages of swap =
*/
>         atomic_long_t inuse_pages;      /* number of those currently in u=
se */
>         struct swap_sequential_cluster *global_cluster; /* Use one global=
 cluster for rotating device */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 1f1110e37f68..5fdb3cb2b8b7 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -470,11 +470,6 @@ static void move_cluster(struct swap_info_struct *si=
,
>         else
>                 list_move_tail(&ci->list, list);
>         spin_unlock(&si->lock);
> -
> -       if (ci->flags =3D=3D CLUSTER_FLAG_FRAG)
> -               atomic_long_dec(&si->frag_cluster_nr[ci->order]);
> -       else if (new_flags =3D=3D CLUSTER_FLAG_FRAG)
> -               atomic_long_inc(&si->frag_cluster_nr[ci->order]);
>         ci->flags =3D new_flags;
>  }
>
> @@ -965,7 +960,6 @@ static unsigned long cluster_alloc_swap_entry(struct =
swap_info_struct *si, int o
>                  * allocation, but reclaim may drop si->lock and race wit=
h another user.
>                  */
>                 while ((ci =3D isolate_lock_cluster(si, &si->frag_cluster=
s[o]))) {
> -                       atomic_long_dec(&si->frag_cluster_nr[o]);
>                         found =3D alloc_swap_scan_cluster(si, ci, cluster=
_offset(si, ci),
>                                                         0, usage);
>                         if (found)
> @@ -3217,7 +3211,6 @@ static struct swap_cluster_info *setup_clusters(str=
uct swap_info_struct *si,
>         for (i =3D 0; i < SWAP_NR_ORDERS; i++) {
>                 INIT_LIST_HEAD(&si->nonfull_clusters[i]);
>                 INIT_LIST_HEAD(&si->frag_clusters[i]);
> -               atomic_long_set(&si->frag_cluster_nr[i], 0);
>         }
>
>         /*
> --
> 2.50.1
>

