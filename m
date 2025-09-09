Return-Path: <linux-kernel+bounces-809024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE653B507A7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BE5175BA0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B357724677C;
	Tue,  9 Sep 2025 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tYy7dWm/"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2C242D6B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451961; cv=none; b=CwLiicBLkgkFZBjcAS68svziT6CCsE62onnJII80zKkVrj4sUu8ma/r1fJpXT15ivzSHz9Y9IAnBvZe2WzXqYdY0FcKvd/mBQYuCQHXVGokavGOgqP/NC+DpsOqWeUdqMF7QiYDejYcRLMDk3Bc8FKJB18L3Ex0Oh1Ic/DIvV/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451961; c=relaxed/simple;
	bh=QemAtFw3CG4U5ZBt4fLSjt+USk6R0A6nOXvdC1gjoQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0GGxZXFDNGiQg3Kt6WFg03e5PrJOErdkIqGdwscyQUSLq66m0QXPbcZujYGI5A2saBvtIldCy8aRI0qIOWx7U4awSc+yMvRECd6EX9iyC2OayFvbG30kRNVEHArhZnxwTJWDi4h5juSL3KpxK34bpPPXTB1QbZS6K0eXOq5eL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tYy7dWm/; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b350971a2eso24631cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757451959; x=1758056759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7aPxEQ+PcTqWBMeSB4ZYtBZNSzyodKpLG/dBw3V5jw=;
        b=tYy7dWm/nu2fEqtiZAO0/cinl0FtfrQ6L/+Ft51mZxBB0jlm3yfS57yUu7fjOp7vn6
         yMKLnwcQdgODxuaOCjKmAlZKWRtP9vZBaNuqcZubVp8CIXoXwTUaWGwseYw7GWIcFeHl
         EtE4zvmUwiwuqSgmTfexbgcHkUAVeCNVIaq6/voxvzRwUU/q5QMEH3azJxjT3aXtDRqD
         K43LsdEVRwGINx5huintmp0WCjDhQLzQ7Pd0x5qbKwwbHyOjQTBU77xjrz8Z/1LZWLLI
         DjMwwZO6iQb+wSgbFpBxi5UXoNAeGbqDap+u2oNI81VEYWtQwAMP+JQp6A14sxkWzPNu
         Y+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757451959; x=1758056759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7aPxEQ+PcTqWBMeSB4ZYtBZNSzyodKpLG/dBw3V5jw=;
        b=d19pZwkEVFf4sUBrTs39qJt2x0uErLYuZcKH2U/peIkcVF0teTbgbcn4i+Uje+uNTB
         92s8Df+0qaLJLUlGY56V8xuMTvQ/V/lX5gFEU9FEv7VcmlMCGonkUtdRP+HJaf/MewUx
         g3+79ADIAyBwCE4NhxJKakVrZNaDYleIpigf4i5SiDz/UNEl1uQNbkh5njTgAofLzaqU
         nR8K1snS9VPQ0paK2C0C3sH7KhMgigxSuunPXWKNyeoP1IbdGv2MhPgoCdRwtv/x7gCf
         +lLJK8AJY+TO6DoafJxW0Z2zeN1GoGJz4cw4s6RQuxcHBzzjqpa6p7f5L4r3S4zE+smJ
         +MIA==
X-Forwarded-Encrypted: i=1; AJvYcCV8E6FO58NjBmS6hiMPgl1g78SB6WS9vU+8ltWHSV0Exwq6DsGqG1sIUJxad5C7iLeCIOmJxOr9kQ0pUKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9DzXedY9DNV7xastwRA6SdLfknHwU8O+VwrHLmTKzL8Uztxc8
	tx69N5wTCe6takaoY+VFscRtEqivD604kB7OG0l14wrgyoS/zY82AAg+PCPCPhVPEpd8tDLzHvi
	E8lbwcV1MENKcVBrb2ydsfqIyzd5ca0cRdt7BE9Tw
X-Gm-Gg: ASbGnctsJkb2mrirS7+QB/XSMQNg/wY5LfreHSsN/NWkCtTujh/rl/vkxedopgBZszC
	bdUGhZmXgFxwJr1xHef4SOAa3bVFL+vqpHCiYypVjWZQfHzCiPukWqMlBYPEATDd0rBDDEydocR
	WcR/wstpK58k8xhaqggBpIwYLh90/LJApeco6jURs4LuNSH6SHFN/RD75iCPZ8ueJBCFzemh0t6
	UrUpNHUmTt89WJnWcOS0CUEMF2cag9hgmakWXXvs6+mzu0c2MhiJrStRwylkVZp+Q==
X-Google-Smtp-Source: AGHT+IHYqLGZwcCj8WIVAJW8IX3MTEP6IpYbXuPKVIphZeJfdaSHiOIX5C7fhE1xa3LrvrxWk3YrRhPxvgF6g7kIjH0=
X-Received: by 2002:a05:622a:83:b0:4b2:febb:fc96 with SMTP id
 d75a77b69052e-4b626e89b95mr338601cf.9.1757451958611; Tue, 09 Sep 2025
 14:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com> <20250909190945.1030905-5-Liam.Howlett@oracle.com>
In-Reply-To: <20250909190945.1030905-5-Liam.Howlett@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Sep 2025 14:05:47 -0700
X-Gm-Features: AS18NWDhW-RpyHOFHP86Anwyxq8qqVpegZ1q2Iz_pJoyckneNoNTTx8eojGrgpQ
Message-ID: <CAJuCfpEqVNyYtEabhDc4DqHbgJdYXcMvryvfxmXU8uJGe0FdRA@mail.gmail.com>
Subject: Re: [PATCH v1 4/9] mm/memory: Add tree limit to free_pgtables()
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

On Tue, Sep 9, 2025 at 12:10=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> The ceiling and tree search limit need to be different arguments for the
> future change in the failed fork attempt.
>
> Add some documentation around free_pgtables() and the limits in an
> attempt to clarify the floor and ceiling use as well as the new
> tree_max.
>
> Test code also updated.
>
> No functional changes intended.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/internal.h                    |  4 +++-
>  mm/memory.c                      | 28 +++++++++++++++++++++++++---
>  mm/mmap.c                        |  2 +-
>  mm/vma.c                         |  3 ++-
>  tools/testing/vma/vma_internal.h |  3 ++-
>  5 files changed, 33 insertions(+), 7 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 63e3ec8d63be7..d295252407fee 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -444,7 +444,9 @@ void folio_activate(struct folio *folio);
>
>  void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>                    struct vm_area_struct *start_vma, unsigned long floor,
> -                  unsigned long ceiling, bool mm_wr_locked);
> +                  unsigned long ceiling, unsigned long tree_max,
> +                  bool mm_wr_locked);
> +
>  void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
>
>  struct zap_details;
> diff --git a/mm/memory.c b/mm/memory.c
> index 3e0404bd57a02..24716b3713f66 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -369,12 +369,34 @@ void free_pgd_range(struct mmu_gather *tlb,
>         } while (pgd++, addr =3D next, addr !=3D end);
>  }
>
> +/*
> + * free_pgtables() - Free a range of page tables
> + * @tlb: The mmu gather
> + * @mas: The maple state
> + * @vma: The first vma
> + * @floor: The lowest page table address
> + * @ceiling: The highest page table address
> + * @tree_max: The highest tree search address
> + * @mm_wr_locked: boolean indicating if the mm is write locked
> + *
> + * Note: Floor and ceiling are provided to indicate the absolute range o=
f the
> + * page tables that should be removed.  This can differ from the vma map=
pings on
> + * some archs that may have mappings that need to be removed outside the=
 vmas.
> + * Note that the prev->vm_end and next->vm_start are often used.
> + *
> + * The tree_max differs from the ceiling when a dup_mmap() failed and th=
e tree
> + * has unrelated data to the mm_struct being torn down.
> + */
>  void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>                    struct vm_area_struct *vma, unsigned long floor,
> -                  unsigned long ceiling, bool mm_wr_locked)
> +                  unsigned long ceiling, unsigned long tree_max,
> +                  bool mm_wr_locked)
>  {
>         struct unlink_vma_file_batch vb;
>
> +       /* underflow can happen and is fine */

This comment is a bit confusing... I think the below check covers 2 cases:
1. if ceiling =3D=3D 0 then tree_max can be anything;
2. if ceiling > 0 then tree_max <=3D ceiling;
Is that what you intended? If so, maybe amend the comments for the
free_pgtables() function explaining this more explicitly?

> +       WARN_ON_ONCE(tree_max - 1 > ceiling - 1);

I would prefer WARN_ON_ONCE(ceiling && tree_max > ceiling); as more
descriptive but that might be just me.

> +
>         tlb_free_vmas(tlb);
>
>         do {
> @@ -385,7 +407,7 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_=
state *mas,
>                  * Note: USER_PGTABLES_CEILING may be passed as ceiling a=
nd may

You replaced ceiling with tree_max, so the above comment needs to be
updated as well.

>                  * be 0.  This will underflow and is okay.
>                  */
> -               next =3D mas_find(mas, ceiling - 1);
> +               next =3D mas_find(mas, tree_max - 1);
>                 if (unlikely(xa_is_zero(next)))
>                         next =3D NULL;
>
> @@ -405,7 +427,7 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_=
state *mas,
>                  */
>                 while (next && next->vm_start <=3D vma->vm_end + PMD_SIZE=
) {
>                         vma =3D next;
> -                       next =3D mas_find(mas, ceiling - 1);
> +                       next =3D mas_find(mas, tree_max - 1);
>                         if (unlikely(xa_is_zero(next)))
>                                 next =3D NULL;
>                         if (mm_wr_locked)
> diff --git a/mm/mmap.c b/mm/mmap.c
> index a290448a53bb2..0f4808f135fe6 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1311,7 +1311,7 @@ void exit_mmap(struct mm_struct *mm)
>         mt_clear_in_rcu(&mm->mm_mt);
>         vma_iter_set(&vmi, vma->vm_end);
>         free_pgtables(&tlb, &vmi.mas, vma, FIRST_USER_ADDRESS,
> -                     USER_PGTABLES_CEILING, true);
> +                     USER_PGTABLES_CEILING, USER_PGTABLES_CEILING, true)=
;
>         tlb_finish_mmu(&tlb);
>
>         /*
> diff --git a/mm/vma.c b/mm/vma.c
> index a648e0555c873..1bae142bbc0f1 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -486,6 +486,7 @@ void unmap_region(struct ma_state *mas, struct vm_are=
a_struct *vma,
>                    /* mm_wr_locked =3D */ true);
>         mas_set(mas, vma->vm_end);
>         free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_AD=
DRESS,
> +                     next ? next->vm_start : USER_PGTABLES_CEILING,
>                       next ? next->vm_start : USER_PGTABLES_CEILING,
>                       /* mm_wr_locked =3D */ true);
>         tlb_finish_mmu(&tlb);
> @@ -1232,7 +1233,7 @@ static inline void vms_clear_ptes(struct vma_munmap=
_struct *vms,
>         mas_set(mas_detach, 1);
>         /* start and end may be different if there is no prev or next vma=
. */
>         free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start,
> -                     vms->unmap_end, mm_wr_locked);
> +                     vms->unmap_end, vms->unmap_end, mm_wr_locked);
>         tlb_finish_mmu(&tlb);
>         vms->clear_ptes =3D false;
>  }
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_int=
ernal.h
> index 07167446dcf42..823d379e1fac2 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -900,7 +900,8 @@ static inline void unmap_vmas(struct mmu_gather *tlb,=
 struct ma_state *mas,
>
>  static inline void free_pgtables(struct mmu_gather *tlb, struct ma_state=
 *mas,
>                    struct vm_area_struct *vma, unsigned long floor,
> -                  unsigned long ceiling, bool mm_wr_locked)
> +                  unsigned long ceiling, unsigned long tree_max,
> +                  bool mm_wr_locked)
>  {
>         (void)tlb;
>         (void)mas;
> --
> 2.47.2
>

