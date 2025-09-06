Return-Path: <linux-kernel+bounces-803977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA871B4682C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 03:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D31A561A1C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 01:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9141B3937;
	Sat,  6 Sep 2025 01:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="estJMMTy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4D1CD2C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 01:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757123528; cv=none; b=IAU1+dr+MQRaC3JtYTI9jSYm0qUzB6jzhi7WT79H16s8DWNXJBrFh+BuB/KKSKunW1iVFVI9mTH4qwsmIEq8HVE2fA+9v37xvWZpTBzJfjoR6Oyzq/QypHSC1eFXMcwsKyuBAdUAdXPLgVCXWYFjCsVhshTTAKt49Z65vax6dwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757123528; c=relaxed/simple;
	bh=ZLbf025TbCAVDMDw7jHKU6+3GLV2AL3hEjSNyCSVYUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jv+fb8wSM/gmQolxNGo5T3SCexStu9mLuHvWf44G6AlirYaWXfYCi0a0x4rLSYQMa4Zx5yOh9jwc1jMuEhEb12dWlHotRJsOdCZNonAxzOzjq1drilC8nDpJy9hiQhyXtm2rtrORPMLaC9Rh2aZ7AML5N19DbFJxLSoDoDy54ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=estJMMTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A6AC4CEFD
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 01:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757123528;
	bh=ZLbf025TbCAVDMDw7jHKU6+3GLV2AL3hEjSNyCSVYUc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=estJMMTyTXmL1nm+XsscuMIpFgsVOr3n/GrHcTm3dR23L622KfMZdYNyZUqj0TU7q
	 q8MH9tKjcA8q84vBddmA3U+INxKJw3RhZgZ99uwdXFS6iyr9W/+z4Te30IdSMV+X5T
	 n7T+91najnbQuYqoy1rYeJjbMtyhVfDiFawWHxc/J/cFabsVRaxMPhp/CpIdAqSHzf
	 kVeVzbWdUnOvuic9jziQwWFOj9puVuqOroYwxLmZlkkomuKRSArnxQorETHUmTn1yB
	 SqqRmGmPQ8tO1OvnKovcDp/HhFicaqGAhtkHK1uDW4pAF4GLCz/UaSlIWhO5X2JsW0
	 rMwxq4mKoiryA==
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b72f7f606so11965e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 18:52:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcwXwDr9Ul26rdkSVzsCVtHgFN+rKzUu+wYvjGLS0DbiqZyhnkUaRofaYBmQvRf1yBbLkeJw8bJLVY/w0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC8YPyenpewQX3EqzD16zqD9MWWPZbmgj1zeASkOakDxHiCavu
	xxUrt1p8dwUFPTk4RggBaDzEAnJIkVzDZVc8J74E/UKEM43mdr/moomqoL9EI3QnEGOhaLhAgr+
	SA/w+RWOl1GB71vkzbHwgo9FoO+vYfZTzdEhkKchj
X-Google-Smtp-Source: AGHT+IGjhaMGuFmKSOq65rNSbqau2mH4/CE4IKPEkkUp0bWy0sfHbOKtsF7sr8Su4snCzHDeblXqp/kDF3PezcaZFSo=
X-Received: by 2002:a05:600c:a406:b0:45b:74f7:9d30 with SMTP id
 5b1f17b1804b1-45dde17196dmr303035e9.1.1757123527039; Fri, 05 Sep 2025
 18:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-4-ryncsn@gmail.com>
In-Reply-To: <20250905191357.78298-4-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 5 Sep 2025 18:51:55 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNhLDovRO+8Y25ArdMBVFjXnYBVjmASzMBtdsdZkQ0NLQ@mail.gmail.com>
X-Gm-Features: Ac12FXyor9jYrHazaQfXv_bf0RLrytfgAReOG_V6sM-QISnVMBGJCjjC0Py78a8
Message-ID: <CAF8kJuNhLDovRO+8Y25ArdMBVFjXnYBVjmASzMBtdsdZkQ0NLQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] mm, swap: fix swap cahe index error when
 retrying reclaim
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

Hi Kairui,

The patch looks obviously correct to me with some very minor nitpicks follo=
wing.

Acked-by: Chris Li <chrisl@kernel.org>

On Fri, Sep 5, 2025 at 12:14=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> The allocator will reclaim cached slots while scanning. Currently, it
> will try again if the reclaim found a folio that is already removed from
> the swap cache due to a race. But the following lookup will be using the
> wrong index. It won't cause any OOB issue since the swap cache index is
> truncated upon lookup, but it may lead to reclaiming of an irrelevant
> folio.
>
> This should not cause a measurable issue, but we should fix it.
>
> Fixes: fae8595505313 ("mm, swap: avoid reclaiming irrelevant swap cache")
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swapfile.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4b8ab2cb49ca..4c63fc62f4cb 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -240,13 +240,13 @@ static int __try_to_reclaim_swap(struct swap_info_s=
truct *si,
>          * Offset could point to the middle of a large folio, or folio
>          * may no longer point to the expected offset before it's locked.
>          */
> -       entry =3D folio->swap;
Nitpick:
This and the following reuse the folio->swap dereference and
swp_offset() many times.
You can use some local variables to cache the value into a register
and less function calls. I haven't looked into if the compiler will do
the same expression elimination on this, a good compiler should. The
following looks less busy and doesn't need the compiler to optimize it
for you.

           fe =3D folio->swap;
           eoffset =3D swp_offset(fe);
           if (offset < eoffset ) || offset >=3D eoffset + nr_pages) {
...
           }
           offset =3D eoffset;

This might generate better code due to less function code. If the
compiler does the perfect jobs the original code can generate the same
optimized code as well.

> -       if (offset < swp_offset(entry) || offset >=3D swp_offset(entry) +=
 nr_pages) {
> +       if (offset < swp_offset(folio->swap) ||
> +           offset >=3D swp_offset(folio->swap) + nr_pages) {
>                 folio_unlock(folio);
>                 folio_put(folio);
>                 goto again;
>         }
> -       offset =3D swp_offset(entry);
> +       offset =3D swp_offset(folio->swap);

So the first entry is only assigned once in the function and never changed?

You can use const to declare it.

Chris

>
>         need_reclaim =3D ((flags & TTRS_ANYWAY) ||
>                         ((flags & TTRS_UNMAPPED) && !folio_mapped(folio))=
 ||
> --
> 2.51.0
>
>

