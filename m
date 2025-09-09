Return-Path: <linux-kernel+bounces-808942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDB7B506BD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337125603F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBE2307AC4;
	Tue,  9 Sep 2025 20:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z6vhTTBF"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF94302157
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448579; cv=none; b=HIeJjkaIio2ch7eyQ+AWf6u2xzpOksePNvT84S4y+jeX2MXTdIMXYvNwoBcn+MxR5LAsYQK7fgB8wXfyeW7BSt8g1y9WHcmwVjMB3wV9QRDnZMlyW4T08Rw7JAljorbWTqOO9ITFMESC88LUnZp96Ko8nmSJYl0QBRNDbdsiiM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448579; c=relaxed/simple;
	bh=QkxEohqardbkvINPMXouUvzqnN2PFkLeNB/7xveQjrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPyOnKSORbqtsowyypX5D70gXq/hXM/B9ijVLSPLO0uNad9t/Ii8PorFIFHbjp6WOw2n1BjVIM/Ur/sbNYs5uOFMqvcE551AE5YbjfpGkOTGLgyx4SkTWpAohGisBC+wJMZVEQ822Ufk3Tf30Dar0VVxhf02c5sguipB/EmVGRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z6vhTTBF; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b48fc1d998so14091cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 13:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757448576; x=1758053376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2iEu3UkPnmUFQcRlFrbHDvxDgSjAEfpS4soOoNd4oI=;
        b=z6vhTTBFOC2P3EymaNCA8UbaevLB4Ta0ipFRqN17Bh6BgnHAjEGeSIn0pe8QRlYwqW
         HXTnW5t9eF5BLw9XhlQ4wADwUJ/Ovs72BUGTTtqC5rCVXqDPpHbPofc23gVai4leeCHX
         jEh//Vw7r4XgW8RypNi01VyAE5steYvoV3qI94qpyPrOz/28+sbnOPBKqsTTd+Gmyj/G
         u8i9My5kKutMKKAffdlpOij6mf1DYECcKhKLExSx1cMRmKuooBMlxHQK7FyI0fbxgrCS
         Tw5MoiBbmIXbhUvQWCSwZUzWl96lQ3MSAXhD0ICeKzkAjrGu1DHSpMKQzxnjRART4yQy
         Af0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757448576; x=1758053376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2iEu3UkPnmUFQcRlFrbHDvxDgSjAEfpS4soOoNd4oI=;
        b=iG2/Cm0NiqXVIEjwpovKNMA2FocQGKHE9gZQQRBiDx1DQqv5nrVfShkMIJeN202ksA
         eCNuntX+MB96bB8hWGBuyQKYWHKcKjcHVKhKfZzuCTaGFAcJAJI7N3ZxJVxd2A8ROXrH
         ukyyJDFYMk4gVY9GhHQx005mqZmPgdtr9OWks+ppxG5XXF+hXiMRe17xZq+HIx1bFR8l
         JXh7lzBC3uW5stD5J3XjD8+dQsby/Gsjj41DzwJtajhp4rfMnvyULm99ljUWen6TVaMj
         33eLVeAHM/gyxa3N4cAvJmjnF3M89y2MAjfN7QLenuohoRLZ/wb+/HbMTZBnf2SDfycL
         rO/w==
X-Forwarded-Encrypted: i=1; AJvYcCVVgsB+0q76nyFt+80IHspuajBboXzLeTB6drjhMsjHVjJuQ7O8o6YKgMm8+2E+Lvd27Oy5gCP9cG3G3uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJBjGknM9AdQRnnLY/tGxSBgx61waskNlE1LTvWCqRRoHIt9XG
	rtMIMSSzpUevCdAUSgUFHZa0C64b81ulvlrxl0Ar1nq8DBru3+eINFeleSQXTktr3/cEWHX2ics
	tDwenyGQEvIawL5E+HR2hXo/xSbOz4wQCu10g0GkZ
X-Gm-Gg: ASbGncuU200bqRuzkd6nLqmTryn2ijk+iX5beC99z+tzoMECmh5s56ozwzoN9+xYq3o
	aX2+UsNdpNIc4g5ehJgrwtFF5DdxQmTmFNJp9fbrqNdoSfy2ciAafV8+OW3FUSFwzR+owbzPAOI
	ZUqiA2Sax10pe6/IEl3LTDZp59u7luz1GCYH7EBK/9d1aOBBm4bTjzWS/Rf/E3D8VhUwuRrrv0o
	70EbR6KSOklNRSoSghMw9IZnSq9Rr7V/pN+PP9rtuQ4iKCz5ZH36JY=
X-Google-Smtp-Source: AGHT+IGTNwq+7MViYUlFJ2vyU1cgy8m+5k5wmGXsJgTGt3s4JBmennrId+EoWqDbJIEA0d2+A3uYjG/h63nRoBrR2lo=
X-Received: by 2002:ac8:5a95:0:b0:4b0:82e5:946b with SMTP id
 d75a77b69052e-4b625102754mr1224361cf.4.1757448575785; Tue, 09 Sep 2025
 13:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com> <20250909190945.1030905-3-Liam.Howlett@oracle.com>
In-Reply-To: <20250909190945.1030905-3-Liam.Howlett@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Sep 2025 13:09:24 -0700
X-Gm-Features: AS18NWDlSEXaT8xC9-9GCN6E5E8NjDo0Ac393Cnh_Tc5RiGu5Zt4J6irQLdxDmI
Message-ID: <CAJuCfpFOt3_W+YQNy+xPzY_R6JUM3EOsbaZh+uznSNpF1RKX0Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] mm/mmap: Abstract vma clean up from exit_mmap()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com, 
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, 
	chrisl@kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 12:09=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> Create the new function tear_down_vmas() to remove a range of vmas.
> exit_mmap() will be removing all the vmas.
>
> This is necessary for future patches.
>
> No functional changes intended.
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/mmap.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index b07b3ec5e28f5..a290448a53bb2 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1250,6 +1250,29 @@ int vm_brk_flags(unsigned long addr, unsigned long=
 request, vm_flags_t vm_flags)
>  }
>  EXPORT_SYMBOL(vm_brk_flags);
>
> +static inline

nit: Maybe let the compiler decide whether to inline this one?

> +unsigned long tear_down_vmas(struct mm_struct *mm, struct vma_iterator *=
vmi,
> +               struct vm_area_struct *vma, unsigned long max)
> +{
> +       unsigned long nr_accounted =3D 0;
> +       int count =3D 0;
> +
> +       mmap_assert_write_locked(mm);
> +       vma_iter_set(vmi, vma->vm_end);
> +       do {
> +               if (vma->vm_flags & VM_ACCOUNT)
> +                       nr_accounted +=3D vma_pages(vma);
> +               vma_mark_detached(vma);
> +               remove_vma(vma);
> +               count++;
> +               cond_resched();
> +               vma =3D vma_next(vmi);
> +       } while (vma && vma->vm_end <=3D max);
> +
> +       WARN_ON_ONCE(count !=3D mm->map_count);
> +       return nr_accounted;
> +}
> +
>  /* Release all mmaps. */
>  void exit_mmap(struct mm_struct *mm)
>  {
> @@ -1257,7 +1280,6 @@ void exit_mmap(struct mm_struct *mm)
>         struct vm_area_struct *vma;
>         unsigned long nr_accounted =3D 0;
>         VMA_ITERATOR(vmi, mm, 0);
> -       int count =3D 0;
>
>         /* mm's last user has gone, and its about to be pulled down */
>         mmu_notifier_release(mm);
> @@ -1297,18 +1319,7 @@ void exit_mmap(struct mm_struct *mm)
>          * enabled, without holding any MM locks besides the unreachable
>          * mmap_write_lock.
>          */
> -       vma_iter_set(&vmi, vma->vm_end);
> -       do {
> -               if (vma->vm_flags & VM_ACCOUNT)
> -                       nr_accounted +=3D vma_pages(vma);
> -               vma_mark_detached(vma);
> -               remove_vma(vma);
> -               count++;
> -               cond_resched();
> -               vma =3D vma_next(&vmi);
> -       } while (vma && likely(!xa_is_zero(vma)));
> -
> -       BUG_ON(count !=3D mm->map_count);
> +       nr_accounted =3D tear_down_vmas(mm, &vmi, vma, ULONG_MAX);
>
>  destroy:
>         __mt_destroy(&mm->mm_mt);
> --
> 2.47.2
>

