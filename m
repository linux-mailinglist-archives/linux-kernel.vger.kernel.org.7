Return-Path: <linux-kernel+bounces-803982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD0AB4683A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40A5A4502F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 02:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70641E1C02;
	Sat,  6 Sep 2025 02:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrCfJBIZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1374515CD74
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 02:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757124067; cv=none; b=OS4Cd+AO8Og+pNWr9JSsULCdXxRW7JQOYnz95SpgWoQwMx1Lrlnnb0A2UTuIGPzKS6PN/+gfi9ELcam3+s2FiisUweTTUYoNnezyVre+UFLGRaW+HtZLphj5apn30yXO6lWdc6pAgDYkwENzatXNM7TEzKcc6YwLeD+kTaNX/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757124067; c=relaxed/simple;
	bh=Bt8M4XzKv+TALs6kSBhqbCJl3uqzCi+K19+0VZxkykI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7/xDmHGiFjjsS6a7i0YGaVdDCcg48mFQ2Mk+WaRi71xE3HmUlgKHT2WQ/nkmW0xU1UB0ALA88AtfC1qJPMYFXdN+Btwn0GSSRvTp6zxSOPmzw+UxWBMS7FgmbjgGSTiKmRjGHD6/7gHReOi+19Ds/IrJsU2pH5BswHGaBmrsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrCfJBIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2D4C4AF0C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 02:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757124066;
	bh=Bt8M4XzKv+TALs6kSBhqbCJl3uqzCi+K19+0VZxkykI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hrCfJBIZmlutaRS35+CCLj1CEGPeN2PhQIETDaylYH725FTEILLcudUErLxr1hmaa
	 EDnblbg/4pHN7QFbMa1zUTGzPA9u27z/3l6s5B4sDG2xlPSZjktiJegb5YN+V6qv/w
	 5X3vhzV5iSQH1705SNtN5iSD99M/X/+fql1YGKuBOzrosnasQhsvwvASk6/bzfGljV
	 2oY65Ye+EWwsk1kCNc7NQT23nskY3CMgSgaYJ98Ya1qWaae/d6Oz2NNXidbeC1N4Vo
	 qiY0rGPL4UzosbTdt/MY1Ju3ukcgf/BcNTDJj8bU9Tg9Dpj708gNyYy8jMBm/QxQxo
	 otBuc2bq6WRUw==
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45ddca76f22so16485e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 19:01:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUA8JECsCLRs6DRVaGxS6vFCPLU3x4bhPhkRPpBZY6IEq0nV+k98oIQYlLne7zay3OzquQBN2y8aP+dm38=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMGIgRgZePRN2ggPZlWxtEpmQB2cK+bygJ43g27JENSg1jF1wc
	xdOaLzSuqiu5rfd6OXOI93njCLdnc8rnpgx2a3+xzc7zCZSqsZmO+lADqa5zRsVzcLUsDFJxkuk
	MMZMoPoCjEfT0NEDy/jeKJ7QxB+jXflpoFW0BDUYi
X-Google-Smtp-Source: AGHT+IHsU9FY2VqIGXmiq0V+dlQFLizOxn+lEe6yU6xu9+VXWgkhS8wguDgQDnsAddQmW9b7x1YQ9CKtMcWV8PT0B5k=
X-Received: by 2002:a05:600c:35d3:b0:45c:b4fb:f0b3 with SMTP id
 5b1f17b1804b1-45dde171ab0mr286205e9.3.1757124065095; Fri, 05 Sep 2025
 19:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-5-ryncsn@gmail.com>
In-Reply-To: <20250905191357.78298-5-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 5 Sep 2025 19:00:54 -0700
X-Gmail-Original-Message-ID: <CAF8kJuP=Fm788hcc0oykU1V1ZpyuzVBjXH1XZykASTf==y3OYQ@mail.gmail.com>
X-Gm-Features: Ac12FXxH3yMevmtXiv7sHwQk_WTezUYpP5pTJgnfA9_PbB9gRKPG7JZK6WDqdvI
Message-ID: <CAF8kJuP=Fm788hcc0oykU1V1ZpyuzVBjXH1XZykASTf==y3OYQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] mm, swap: check page poison flag after locking it
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Separating this patch out makes it easier to read for me. Thank you.
The last V1 mixed diff is very messy. My last attempt missing the
out_page will unlock the HWPoison page as well. Now it is obviously
correct to me.

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Fri, Sep 5, 2025 at 12:14=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> Instead of checking the poison flag only in the fast swap cache lookup
> path, always check the poison flags after locking a swap cache folio.
>
> There are two reasons to do so.
>
> The folio is unstable and could be removed from the swap cache anytime,
> so it's totally possible that the folio is no longer the backing folio
> of a swap entry, and could be an irrelevant poisoned folio. We might
> mistakenly kill a faulting process.
>
> And it's totally possible or even common for the slow swap in path
> (swapin_readahead) to bring in a cached folio. The cache folio could be
> poisoned, too. Only checking the poison flag in the fast path will miss
> such folios.
>
> The race window is tiny, so it's very unlikely to happen, though.
> While at it, also add a unlikely prefix.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memory.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 10ef528a5f44..94a5928e8ace 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4661,10 +4661,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 goto out;
>
>         folio =3D swap_cache_get_folio(entry);
> -       if (folio) {
> +       if (folio)
>                 swap_update_readahead(folio, vma, vmf->address);
> -               page =3D folio_file_page(folio, swp_offset(entry));
> -       }
>         swapcache =3D folio;
>
>         if (!folio) {
> @@ -4735,20 +4733,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 ret =3D VM_FAULT_MAJOR;
>                 count_vm_event(PGMAJFAULT);
>                 count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
> -               page =3D folio_file_page(folio, swp_offset(entry));
> -       } else if (PageHWPoison(page)) {
> -               /*
> -                * hwpoisoned dirty swapcache pages are kept for killing
> -                * owner processes (which may be unknown at hwpoison time=
)
> -                */
> -               ret =3D VM_FAULT_HWPOISON;
> -               goto out_release;
>         }
>
>         ret |=3D folio_lock_or_retry(folio, vmf);
>         if (ret & VM_FAULT_RETRY)
>                 goto out_release;
>
> +       page =3D folio_file_page(folio, swp_offset(entry));
>         if (swapcache) {
>                 /*
>                  * Make sure folio_free_swap() or swapoff did not release=
 the
> @@ -4761,6 +4752,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                              page_swap_entry(page).val !=3D entry.val))
>                         goto out_page;
>
> +               if (unlikely(PageHWPoison(page))) {
> +                       /*
> +                        * hwpoisoned dirty swapcache pages are kept for =
killing
> +                        * owner processes (which may be unknown at hwpoi=
son time)
> +                        */
> +                       ret =3D VM_FAULT_HWPOISON;
> +                       goto out_page;
> +               }
> +
>                 /*
>                  * KSM sometimes has to copy on read faults, for example,=
 if
>                  * folio->index of non-ksm folios would be nonlinear insi=
de the
> --
> 2.51.0
>
>

