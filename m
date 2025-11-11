Return-Path: <linux-kernel+bounces-896101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13181C4FA58
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113FF3B4A95
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191BC3254A8;
	Tue, 11 Nov 2025 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqzhCNhs"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918AD333448
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890503; cv=none; b=Nesx4mBVY5Gftk70xxsiS1sCO0aQXOb9lFOrfaknj0zZI9uZxnMcJTLAUzLfbH7V2RxFzqkgg2bsb0XtNZbjHIgIRWUUzIk2g5rRJCp0PEusTEyGPJrhydetcm0CbvQGfm5BftP3tSV6kevNVU9E60q9K8Nxx8z+HmIXG7gUjzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890503; c=relaxed/simple;
	bh=Xh24Itbbl1KCQJ7CVFff70n5D94ZpTRVFhp/97mFiyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIzVuckY3udu/0Pt10JRxx8VrChTYWRC94G0s2FPATHdapDJg45X53ZecWj3fxLCxRrntxYS09uhlFpKGjRuPf9EjQa1iucc/EC8G8Az5TgqjZqgO1hPaROOTYOpX+IA01KAiFty4s+osENlZgaGtV4MXAFyxp8R+ULZm274zcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqzhCNhs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47774d3536dso140075e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762890500; x=1763495300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbE0DBTQIFEdPxSSdzhQNw1lCZYmDmkNb+ii//A3mIs=;
        b=VqzhCNhsIzF2LZwbbb2IFGXUnnhPhLXSY2BpAFY9y8eUAWdizLEDFGrU/9RNRYBgo4
         jg6FsLLVGOU0C4C0LErqMeZ8/9ZGfpu5Y1eubAEdMJDciaLXN9cyJ7xA7GLMyYJvoLyo
         bojZT4pxLYpkeh75OJiiK5KvEUkkmIyKD7/9aVHa9jtTiJD4OhIT2bjrbbPx+AjWKVbk
         BS3qdcqyNYlWiCXoa3UD4wQnyEJtXmx2o4SIhnIUEYHCQzNdBgtAga8PmrcG/qe9WGvq
         HZogRPZDz/e3wLaIzEq4gxkKKehwUeJfrIO11PpxHHH/jwCGt/Hy3y+eLFkj5SGWScsR
         TF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890500; x=1763495300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UbE0DBTQIFEdPxSSdzhQNw1lCZYmDmkNb+ii//A3mIs=;
        b=RkMzHV0ikp4yeo4i3p1QpSa1rAbSR5Li50xU/KBKbINsQ80Wb84r/BQ0M+pVPNQ3LP
         P+DMeV+DJUbuF15e7CZojEDkib2adL+QkURf1rJ7RmqRu8vcsOACOCdcBKCY0CuvsKjj
         Cis1qZyXlOQcbJe9mv2awDHp4xpYpW7QqKdDKLwJwNmuqcW/T7lA6i1RGtGksb+TjWiO
         VDQVwG+4o3wOHlDJbh9j7g4YeBpq1ICV9qhrCiOE3pwLlVurUXRAWx81n5X1FaiPSt14
         7EuokxWWPfPmSVLMdKbN25LmjrDxIkISbt7+tR2Zgc2XUF61rp92ZB29HSwKbyLOfJ56
         MNHA==
X-Forwarded-Encrypted: i=1; AJvYcCXYVp7NfK3UC1EMwHveltxNAfde9vYlOTTYPSwKGUnFm6CMZm5v8v8jFJiCNjHBzotqTxsq10Z3x2+4uYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIohR1QO1AgGxzqzi02u+OvBkFc52n3MEv3XLjX/P3kWGrQ9My
	mDM4dLiLRG2rMPapWGXKTpBSZosxQBuNQ14y5RQsK8JlJ0pRJCVEGVIdqHMSGQA2l6EhwVIGpUe
	U2IIO/xV1jJQ+kcejLlFLpXiI1YRvviw=
X-Gm-Gg: ASbGncsYsvVl+V5EglQmW3xME7Uu37ce4RmWaeWg+KY3izIBE/OG8NKZoNVESXG3fwU
	aPEvG1zLVa0hZis5feOf7DbFVGsRGvrQY5LqTb3wKBTcWUy9XFIhALPtcDh732k0i47flsgiZFy
	3ejVo3XMiB86t9or/XSWubunIHD+BzsXvSAra8Ur0IeN3UXPFrQhhPDos37FC1n4ERiO6fFdYuC
	FyopptvXtZC+fWd0wZGoKt+LdBQwyVZJ4bFxcFbD0L9y8x+aG+Amc/CF/nW
X-Google-Smtp-Source: AGHT+IFXK4RlJhG5N0ePOzGo2aczS5G6iw+lxf53O9oDZtZdPYxRASWBOWz3i7tmyMb7gaU0omWaNjuw8uXf/sXa9jw=
X-Received: by 2002:a05:600c:2942:b0:475:de06:dbaf with SMTP id
 5b1f17b1804b1-4778144eaf9mr29391645e9.17.1762890499699; Tue, 11 Nov 2025
 11:48:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111-swap-fix-vma-uaf-v1-1-41c660e58562@tencent.com>
In-Reply-To: <20251111-swap-fix-vma-uaf-v1-1-41c660e58562@tencent.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 11 Nov 2025 11:48:08 -0800
X-Gm-Features: AWmQ_bkqvQTvzr2wIJqIY0mYNqX5zE1OAJvC7EppmNrvuhY6ZoKspaTSdmcDjb4
Message-ID: <CAKEwX=OuhWBZWAKs0JYG6mLqe=NvyiD9L0dOEb=5ZJB-jfFi1Q@mail.gmail.com>
Subject: Re: [PATCH] mm, swap: fix potential UAF issue for VMA readahead
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Huang Ying <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 5:36=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> Since commit 78524b05f1a3 ("mm, swap: avoid redundant swap device
> pinning"), the common helper for allocating and preparing a folio in the
> swap cache layer no longer tries to get a swap device reference
> internally, because all callers of __read_swap_cache_async are already
> holding a swap entry reference. The repeated swap device pinning isn't
> needed on the same swap device.
>
> Caller of VMA readahead is also holding a reference to the target
> entry's swap device, but VMA readahead walks the page table, so it might
> encounter swap entries from other devices, and call
> __read_swap_cache_async on another device without holding a reference to
> it.
>
> So it is possible to cause a UAF when swapoff of device A raced with
> swapin on device B, and VMA readahead tries to read swap entries from
> device A. It's not easy to trigger, but in theory, it could cause real
> issues.
>
> Make VMA readahead try to get the device reference first if the swap
> device is a different one from the target entry.
>
> Cc: stable@vger.kernel.org
> Fixes: 78524b05f1a3 ("mm, swap: avoid redundant swap device pinning")
> Suggested-by: Huang Ying <ying.huang@linux.alibaba.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
> Sending as a new patch instead of V2 because the approach is very
> different.
>
> Previous patch:
> https://lore.kernel.org/linux-mm/20251110-revert-78524b05f1a3-v1-1-88313f=
2b9b20@tencent.com/
> ---
>  mm/swap_state.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 0cf9853a9232..da0481e163a4 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -745,6 +745,7 @@ static struct folio *swap_vma_readahead(swp_entry_t t=
arg_entry, gfp_t gfp_mask,
>
>         blk_start_plug(&plug);
>         for (addr =3D start; addr < end; ilx++, addr +=3D PAGE_SIZE) {
> +               struct swap_info_struct *si =3D NULL;
>                 softleaf_t entry;
>
>                 if (!pte++) {
> @@ -759,8 +760,19 @@ static struct folio *swap_vma_readahead(swp_entry_t =
targ_entry, gfp_t gfp_mask,
>                         continue;
>                 pte_unmap(pte);
>                 pte =3D NULL;
> +               /*
> +                * Readahead entry may come from a device that we are not
> +                * holding a reference to, try to grab a reference, or sk=
ip.
> +                */
> +               if (swp_type(entry) !=3D swp_type(targ_entry)) {
> +                       si =3D get_swap_device(entry);
> +                       if (!si)
> +                               continue;
> +               }
>                 folio =3D __read_swap_cache_async(entry, gfp_mask, mpol, =
ilx,
>                                                 &page_allocated, false);
> +               if (si)
> +                       put_swap_device(si);

Shouldn't we reset si to NULL here?

Otherwise, suppose we're swapping in a readahead window. One of the
swap entries in the window is on a different swapfile from the target
entry. We look up and get a reference to that different swapfile,
setting it to si.

We do the swapping in work, then we release the recently acquired reference=
.

In the next iteration in the for loop, we will still see si !=3D NULL,
and we put_swap_device() it again, i.e double releasing reference to
that swap device.

Or am I missing something?

>                 if (!folio)
>                         continue;
>                 if (page_allocated) {
>

