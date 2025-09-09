Return-Path: <linux-kernel+bounces-808861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD4EB50595
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E175D4E7689
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895F830215D;
	Tue,  9 Sep 2025 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s6wGVZma"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7DB301008
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443819; cv=none; b=PkIfv/VZdQbprZZ2f+IYhTB1Jvv/iNwDphVgebNUNoTBhZaE4p2kpMHeCV62b2qf+0eMBuTnu1Ssj4qCHchu6MT+pLenri5AvCz1/W0/1zqJuAHCFwk+MNadPDE5Kmf454yBrB7cBLp8HpiJ6exal8ZY0j/zBbfOSuNPfWqEjmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443819; c=relaxed/simple;
	bh=WITU87MwMgtR7ZF+/20JbhVsgsKMon1UiBZBXhg4Z/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lApQTK+kEfzizKfvH7hVQZxtiRi4ajH6DrNDlvuVruTxDiaJx2TRaEG7R66fmSldbZdjVmR/4Vo/alG73++21CFi1UcWf51gAdoSlNizZ1z77GSbDMUYTh24he1DivbDmcy9SwmuvVZyxdqjSTjSAW1u8A8eUHlmn+APD14BQ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s6wGVZma; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-407a4e744ddso20535ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757443817; x=1758048617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eC3mUBzIF335HxcW34dFQJ7jnn4NSV7DuTmu23IsQDA=;
        b=s6wGVZmaI+vcv+eYwl8RyevFVZoBvTjB02cZ7HK1GoWjnHUk78khfMzH0tmIYMuCpq
         2JbZQwu0N7F42xZFcTlQW/gBpJQV+3zZbXaLUUXUzDNHU7iX4ylHxabMejOFtu1Ha4ng
         XGj2BefP8KPOXXkPgRCpTSvCoPtejSGSxkvCZwIQMUgAs68qbsjp9h0dtVPNfNq4ruFV
         QHFAty1JiqLnfyaPZttUkKRAFcrVqaQTjshn3DpqlLbGSAY3pagK0dHGXDEDBy0Pi6+N
         Gzb5XOhanHVYQL5LYzEzKHfmvOHrlHgR6jxWA9hzwqCmoXp4qaPeb6kinldJiWt7Qq2L
         5o7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443817; x=1758048617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eC3mUBzIF335HxcW34dFQJ7jnn4NSV7DuTmu23IsQDA=;
        b=vZglPNQVQxLj4KrHnxaLNqB/LhqTXVxNGOQ9ims3P0H66Jl74uPechlmbNphfrW3/J
         sgICvwpaOYnF99lzQ8nlCn8IU4nIWzMor7YGCqQyh98e2pivdVy3YebtGfw3i4uOW8JL
         OhwpvFqlg3hk6ejxqU0r1uhXZJZvap369XfT95AaAEeMdQI1ecQwXeR0MhxH6qlU+LRs
         3apyQpoy/EXxt04qmp6y6g6VdUITiqhHGgoCkIqSS9jQz7/3GIdAHSfj0YgwB9dWwCQf
         MSFJl+YDHGAgwnfbVMhyU4Yly4IeSGDbjHRTDwG/wLD0wXMCfphT0NrkqSb2uEIty1y1
         eCVA==
X-Forwarded-Encrypted: i=1; AJvYcCW1Nuazmsd+8Tn3FT4XXZHIxkmouWBwsFPHFS29IZuD0cpXUdWPrGUZOp+UiLJ1K6k3y0VxllaHz5ijDHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY2zOblN5YnxVK2ltBV3QfZDFNziOrFP5cB+rOf/iKgn/T19Kh
	pjILgY4AHMy8jP2ErYivqfbyIy1/pUaTpOIqmBlrbhEMA5kl7Fr0oKrsRzzq6xQ/R9MlFVHyEup
	RH7ZRWMdxHLFNW0gJP3NcWNqC+/jTl4dkh5980bgm
X-Gm-Gg: ASbGncv3iA6/IFOhwCQP9Ny36uH2hRoL59rLEA0wacHT+1Xjn9zs7drVFRdWV9HLb17
	xgdUnyZuPlnGts/7YIQYq6OXibcQXvVwH4KOsax1Pwa+hSIQ2FJHKd61BDHAx68UTNWxNoYF24u
	8DMrgvJRvoaCFhlOitEXA5dJRLKa72TADEc2IaT79d+PhBI+fbt650Ub2c0jiV1rOsHbh/KQvLr
	GvKH2BmGUDnOLI=
X-Google-Smtp-Source: AGHT+IG6p9OBV2LHpHJ2dnCTdEF/QlDlw3uEMnpPINTz7IGwtNn9XHfXL0nT5x0TVBBY4V1jajlMi/f/7FwLhI4UYXw=
X-Received: by 2002:a05:6e02:190e:b0:40b:e7e1:cfb5 with SMTP id
 e9e14a558f8ab-4164d86db7fmr699395ab.2.1757443816692; Tue, 09 Sep 2025
 11:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908075028.38431-1-dev.jain@arm.com> <20250908075028.38431-2-dev.jain@arm.com>
In-Reply-To: <20250908075028.38431-2-dev.jain@arm.com>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Tue, 9 Sep 2025 11:49:39 -0700
X-Gm-Features: Ac12FXypQR8Ban_kXoWF6-UtTEU_BSzjrhtVgpc1eMzOq3TH_kElX763QBqhNKo
Message-ID: <CAAa6QmRtP9T8SVCVXkgLDtzZYYujh89R_FYzUanSckfe5znyyg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: Enable khugepaged anonymous collapse on
 non-writable regions
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, kas@kernel.org, 
	willy@infradead.org, hughd@google.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	baohua@kernel.org, richard.weiyang@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 12:51=E2=80=AFAM Dev Jain <dev.jain@arm.com> wrote:
>
> Currently khugepaged does not collapse an anonymous region which does not
> have a single writable pte. This is wasteful since a region mapped with
> non-writable ptes, for example, non-writable VMAs mapped by the
> application, won't benefit from THP collapse.
>
> An additional consequence of this constraint is that MADV_COLLAPSE does n=
ot
> perform a collapse on a non-writable VMA, and this restriction is nowhere
> to be found on the manpage - the restriction itself sounds wrong to me
> since the user knows the protection of the memory it has mapped, so
> collapsing read-only memory via madvise() should be a choice of the
> user which shouldn't be overridden by the kernel.

Sorry ; late to the party. Certainly agree wrt MADV_COLLAPSE.

Ditto for khugepaged as well. Check added when support for
non-writable pages were added to khugepaged, though retaining
heuristic that at least one pte should be writable;  10359213d05a
("mm: incorporate read-only pages into transparent huge pages"), which
predates max_ptes_swap.

> Therefore, remove this restriction by not honouring SCAN_PAGE_RO.>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Reviewed-by: Kiryl Shutsemau <kas@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Zach O'Keefe <zokeefe@google.com>

> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/khugepaged.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4ec324a4c1fe..a0f1df2a7ae6 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -676,9 +676,7 @@ static int __collapse_huge_page_isolate(struct vm_are=
a_struct *vma,
>                         writable =3D true;
>         }
>
> -       if (unlikely(!writable)) {
> -               result =3D SCAN_PAGE_RO;
> -       } else if (unlikely(cc->is_khugepaged && !referenced)) {
> +       if (unlikely(cc->is_khugepaged && !referenced)) {
>                 result =3D SCAN_LACK_REFERENCED_PAGE;
>         } else {
>                 result =3D SCAN_SUCCEED;
> @@ -1421,9 +1419,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct=
 *mm,
>                      mmu_notifier_test_young(vma->vm_mm, _address)))
>                         referenced++;
>         }
> -       if (!writable) {
> -               result =3D SCAN_PAGE_RO;
> -       } else if (cc->is_khugepaged &&
> +       if (cc->is_khugepaged &&
>                    (!referenced ||
>                     (unmapped && referenced < HPAGE_PMD_NR / 2))) {
>                 result =3D SCAN_LACK_REFERENCED_PAGE;
> @@ -2830,7 +2826,6 @@ int madvise_collapse(struct vm_area_struct *vma, un=
signed long start,
>                 case SCAN_PMD_NULL:
>                 case SCAN_PTE_NON_PRESENT:
>                 case SCAN_PTE_UFFD_WP:
> -               case SCAN_PAGE_RO:
>                 case SCAN_LACK_REFERENCED_PAGE:
>                 case SCAN_PAGE_NULL:
>                 case SCAN_PAGE_COUNT:
> --
> 2.30.2
>
>

