Return-Path: <linux-kernel+bounces-758652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5D5B1D20E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11F244E373B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 05:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298AA1F4198;
	Thu,  7 Aug 2025 05:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtgUymzN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877851E25E3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 05:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754544871; cv=none; b=cMW1pIaWIe9V2qIODwe44xzcDsg7O6EtYUlt3i6uN3Isj3456nTFaqKeIVkZTIVZcwntXYJIVPC7+/Eijjx9I23hc4IEyVJdHQvsqFsgy7VS1pj1zB5vKGQSDNHLvSGFKhqLaOGp+4/UOAC5fLTeyUjdbDDDupfk6ZFVMcsAjWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754544871; c=relaxed/simple;
	bh=RiUS7KSgyHes9dhNZkvcCRdWhBjwo7hlSmrC0k9Zo6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkQstC+YNpi7YXxpcRqkfT40WTQCk4ywqjvOeMgNIMiPvm5RP6hDzgakp3zS/o/VopbWL9Plsm2R6nbakqvTqA8OaV+rd44OEZF8Z5aEIs+O0cWH1oTwSwoNxY71yr6dMcf24flXb82odqFLaojxvkU1t8TU/eVnbMqe42gFhSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtgUymzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6702DC4AF09
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 05:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754544871;
	bh=RiUS7KSgyHes9dhNZkvcCRdWhBjwo7hlSmrC0k9Zo6A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CtgUymzNh53kTukKYdQFncA2wzaaMlLvuoVQAf2wIuGou/soT396FVrzmfhXXfvu5
	 orf4Qea/PZy9rPI9+lXK2rp9QMUCYvtcewMbyfsA5zVjKM8x8ipRIIDj7TJzY4Gg3b
	 3aq7JIqUEuD348XKwscYCJc8CThXe0bTSSIfDT8BIMzpxjcumrK6qLzpWzux7h6Lxe
	 NHEXItQYbcio3/JqynER49PHFu3tqodFDQMZMO2kvXgstq7G3ztIv8UvqfqXsVrawK
	 iP1y6YZJTypg1+KR8NQ8YPSsyqzzrmWNuk8XvpPYqMtddGpEXej/3OOajy08fwvuHK
	 PvGCFeQ5QF82w==
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-459e497776cso44035e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 22:34:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/N7iXRhjZDmQbZLg8BCi184yImgRezqbqoXZPf5zKmlPa4fZcl7opXO+awhoYYiwBo4bSms1d7Ej6TnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz84m5pKTNarYG/C4OzKhIoHGfc7BSV7R4GbhsOkmIP3uWrXfBC
	T6JDKfqIAj1WGYRt4AbwtUU0v1tYToPcvRV8BAnzRHpvHrGZlgGblbpUsWQ43Tc3K7wids/7hSG
	tYQhbRpWxCUOcNxLt1Gfa9f0C+55l6m+R6goGWrI+
X-Google-Smtp-Source: AGHT+IFIrjsa3bqiUdILHj0K82UG+gs0VXdeHKXr68Tr9yha8S6Xfrc88nTWNYBeV/BoCilZCd/fft4sfMojVba1RW0=
X-Received: by 2002:a05:600c:3148:b0:456:4607:b193 with SMTP id
 5b1f17b1804b1-459f0357255mr303415e9.7.1754544870120; Wed, 06 Aug 2025
 22:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806161748.76651-1-ryncsn@gmail.com> <20250806161748.76651-3-ryncsn@gmail.com>
In-Reply-To: <20250806161748.76651-3-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 6 Aug 2025 22:34:19 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMxnMP67GT9poH2eopOSJaXcnior47rEQGipmDCPuc5eQ@mail.gmail.com>
X-Gm-Features: Ac12FXwJ1IgtZ56cqLlvklOoOtpKEXAtVQDzpJTF-FJ8utQN16JVaoRrM7ujyB0
Message-ID: <CAF8kJuMxnMP67GT9poH2eopOSJaXcnior47rEQGipmDCPuc5eQ@mail.gmail.com>
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
>

