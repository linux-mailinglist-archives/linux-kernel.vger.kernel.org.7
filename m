Return-Path: <linux-kernel+bounces-845978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2D4BC69E9
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 22:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD1F2420699
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 20:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649042777F9;
	Wed,  8 Oct 2025 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ys4ncc22"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00B326E716
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759957138; cv=none; b=BH6It3Wq0IB7cGoQkom5TPEj9uELn8wGR2qJzfO3nmHtDzEJBOnrikEJ8P01j7WenGDVxGBbOJfgPx13ptFzmvo0YpYch6X59B5vTS4VCY0i4uEhjg6sxcvRQTEnE+qm2HFUWk600eYaAPdgGNUhShczgasYJuhwcCPU4VnvkSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759957138; c=relaxed/simple;
	bh=I/O5cFAIVReUYpBF2BqP5uRgVY4CVJzEBglG9Ag9N1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0/0TZ9w3EH/lSXd6vTH+Dqmk4JOVFvCHJ3lK32RtWCE5c9Jn0pvANwYx+2IbBOkpVUdhSMRtg0R7Jv0HK/jEO7r9o1wBbrACB/rupqhenNrqqodSOje1FitEaM2kuKH7FTUlueYHlGIdrk8jQENyLxkJz9NjPT6/xYST30Uq7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ys4ncc22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A800C4CEE7
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 20:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759957138;
	bh=I/O5cFAIVReUYpBF2BqP5uRgVY4CVJzEBglG9Ag9N1c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ys4ncc2238l++WKdLlwPuP9Dhfkv0tOhxX6aBWkPTsZd5E1V4elf4rMrzL1Fpk17N
	 4I4EmHUkjsII5KGgMR7AMtvNNlPFZAHepB/l27uboV+Y8Nv9XeNPHt8esi+ThQ/P7n
	 C/zPlGWD3XBMUqWtXR7zo+zaSXyEdVmBgxj5l8iPAeZTSayhg4mh8F6xgFV1zkr7AD
	 rDNBNHJvFqOpCd5UkIF7HzV1WK/JYB1FhX1UQA8wBMdarheSvOnAL9sX8P7Z2qEvE2
	 NaQS/EiFPcRMgPRc+0P9LX+HYxzQ9qwWf1qfn2Nj/XAI4s7JzlMcZ/CcJjCbsJXQqk
	 Y4+wU87lk/ecA==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-77f947312a5so2874627b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 13:58:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXt+ZnE0dc+nh8+9JU2xC2PQ32CFPhrJty/Qj1yt7CC61c9HkDr22gdsqmrwUZOQ5pfT/CDF0J/8r/GF9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YweEEuQbWUi3f65QFFZF5pXX5/rd+Pj0xnGp1aXr2GG/6p++CdI
	XPF0bqqnkG9ocZNJYA9w9Tdr+KYHvSTpQODClvKL7lhQdsHZc8qR6DkBhUPdYSQ6tIp5VEEFfc3
	reQtN8V8raAN4mQNAhjyWGQ8mWZDWntzTcz7uZ5nESQ==
X-Google-Smtp-Source: AGHT+IFmDct8NBJB7hs7xpsIKwGqjrJKi8DA5w41X122GCxOpuP97IsVpRnLD3pg7rvYeA6vDxTtei2PmX8W22XUzTk=
X-Received: by 2002:a53:cb41:0:b0:634:751b:1d13 with SMTP id
 956f58d0204a3-63ccb85da27mr3897822d50.23.1759957137556; Wed, 08 Oct 2025
 13:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
 <20251007-swap-clean-after-swap-table-p1-v1-2-74860ef8ba74@tencent.com>
In-Reply-To: <20251007-swap-clean-after-swap-table-p1-v1-2-74860ef8ba74@tencent.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 8 Oct 2025 13:58:45 -0700
X-Gmail-Original-Message-ID: <CACePvbXtWQq0g+K0YtQLi3Sz5ukS5YS3XF-_VDEmUR0Y3f_Agg@mail.gmail.com>
X-Gm-Features: AS18NWDUClHnjux-YVCXQbI0rvRka3sDNL5Dc2iIYoaxaQjpkAmt0AU3DR9zlUc
Message-ID: <CACePvbXtWQq0g+K0YtQLi3Sz5ukS5YS3XF-_VDEmUR0Y3f_Agg@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm, swap: rename helper for setup bad slots
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Mon, Oct 6, 2025 at 1:03=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> From: Kairui Song <kasong@tencent.com>
>
> The name inc_cluster_info_page is very confusing, as this helper is only
> used during swapon to mark bad slots. Rename it properly and turn the
> VM_BUG_ON in it into WARN_ON to expose more potential issues. Swapon is
> a cold path, so adding more checks should be a good idea.
>
> No feature change except new WARN_ON.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swapfile.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 0d1924f6f495..732e07c70ce9 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -751,14 +751,14 @@ static void relocate_cluster(struct swap_info_struc=
t *si,
>  }
>
>  /*
> - * The cluster corresponding to page_nr will be used. The cluster will n=
ot be
> - * added to free cluster list and its usage counter will be increased by=
 1.
> - * Only used for initialization.
> + * The cluster corresponding to @offset will be accounted as having one =
bad
> + * slot. The cluster will not be added to the free cluster list, and its
> + * usage counter will be increased by 1. Only used for initialization.
>   */
> -static int inc_cluster_info_page(struct swap_info_struct *si,
> -       struct swap_cluster_info *cluster_info, unsigned long page_nr)
> +static int swap_cluster_setup_bad_slot(struct swap_cluster_info *cluster=
_info,
> +                                      unsigned long offset)
>  {
> -       unsigned long idx =3D page_nr / SWAPFILE_CLUSTER;
> +       unsigned long idx =3D offset / SWAPFILE_CLUSTER;
>         struct swap_table *table;
>         struct swap_cluster_info *ci;
>
> @@ -772,8 +772,8 @@ static int inc_cluster_info_page(struct swap_info_str=
uct *si,
>
>         ci->count++;
>
> -       VM_BUG_ON(ci->count > SWAPFILE_CLUSTER);
> -       VM_BUG_ON(ci->flags);
> +       WARN_ON(ci->count > SWAPFILE_CLUSTER);
> +       WARN_ON(ci->flags);
>
>         return 0;
>  }
> @@ -3396,7 +3396,7 @@ static struct swap_cluster_info *setup_clusters(str=
uct swap_info_struct *si,
>          * See setup_swap_map(): header page, bad pages,
>          * and the EOF part of the last cluster.
>          */
> -       err =3D inc_cluster_info_page(si, cluster_info, 0);
> +       err =3D swap_cluster_setup_bad_slot(cluster_info, 0);
>         if (err)
>                 goto err;
>         for (i =3D 0; i < swap_header->info.nr_badpages; i++) {
> @@ -3404,12 +3404,12 @@ static struct swap_cluster_info *setup_clusters(s=
truct swap_info_struct *si,
>
>                 if (page_nr >=3D maxpages)
>                         continue;
> -               err =3D inc_cluster_info_page(si, cluster_info, page_nr);
> +               err =3D swap_cluster_setup_bad_slot(cluster_info, page_nr=
);
>                 if (err)
>                         goto err;
>         }
>         for (i =3D maxpages; i < round_up(maxpages, SWAPFILE_CLUSTER); i+=
+) {
> -               err =3D inc_cluster_info_page(si, cluster_info, i);
> +               err =3D swap_cluster_setup_bad_slot(cluster_info, i);
>                 if (err)
>                         goto err;
>         }
>
> --
> 2.51.0
>

