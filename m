Return-Path: <linux-kernel+bounces-809091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE808B5085E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786FF3B07AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE2B260587;
	Tue,  9 Sep 2025 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gzZCQWvG"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE316253951
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757454262; cv=none; b=lNY2fVZj6Rnd3nWo+vrfgEMiyMu/Tv5eg1suK2xyy7enc4IuhXk6YpFinRRzfNiw4b3z6piMCXIqT2M89qJ9kTYfzMrg4w1Omz2iAVzM7hiq7v5jeeoqJCIlQhAhIK+jU01VUuZIe84iOhLOJDEZzYqVaS8nE8cfhLZbk3ucIIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757454262; c=relaxed/simple;
	bh=Ouc86iuD2u/uoicrSLE4J2FL5645bILq558AbjHR74Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fr+mZItg6+48by8fh+JIZeD0azkVqfr/6pJL4mkkfq2HxfbtFyFj5fT71ExFkNLIB+jFXVr5WoenTBtHVVdVdxWxB/fz4GNxw7UewWg6Wmmu2oUPynNtNScoPJfxNw5+UO8dDmwGEsPHzePzk12Ex2J6GQhBuiQZ3RiuNGCPnhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gzZCQWvG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61d14448c22so1541a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757454259; x=1758059059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cORFDYgvyY2ZoZSCiHszBh/KszgVx6wKBPF6YytGcNM=;
        b=gzZCQWvGcPFroqpTEzLCkHCbz7waXNnVDkH6WPPEunqTx+NZoR4mYTxtEqboq4GLzS
         hkGx9wpJRy2R5oIAyfYoCbGWDfD28mBOZzhC5/K+CkKhk9K/2l+F/IKlLfiOSz1Qo8Ni
         V8Mnk4+ueNzNUBc6NFeLI2cjCh4phG6SmjGUIeRp1Ek9FZOLzVx1g1+V1/RwjhR3PzRu
         ZAEOG8Hibj1xq1E+L7YZ+quWmh9g/59AwA5yZhQ+gkYSk7c7SkGGW8cMv5Xqh5VP2EAM
         lzJi7a0iztf1dXww9cJzZ4vS8Ofz7LTcfJy/RI9jV1H1oT20xVlfbUc7UB30U/Ewa0dh
         hy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757454259; x=1758059059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cORFDYgvyY2ZoZSCiHszBh/KszgVx6wKBPF6YytGcNM=;
        b=NWv7uZqTy/tQbFNYTN80wfAoQWiXbQojVH6cD7KbfNXoVKz4kdL1Ts/n/UInoJgnHh
         1zIVQ4bL9bDUijgB2ksU4YNjpHxNV1qCglPd5vusSPAoAyDH2A3Pd+TCzjIR8u5mr7/V
         u4XJzcuwPZnpkTYLhasl7QHd6uuqZxmYGQsiE0v69csvJ9fxY+My6Hf8+DKqIXzF4pR1
         /Dbr/pdjYaE/eGBvH/ZPOqJfDTX6lEZHqIs+uFJXy/Jnhrwh8Ux0Ipjy3NLywf4+Qcqi
         hwedOaT5Yovtco01zekgOH5tELIcpOH/NFyiIR5Srt/mX+RB27csY1EW5oWkx3XlNE3X
         8fpA==
X-Forwarded-Encrypted: i=1; AJvYcCXNVvDtp3UyFAcHnnzl+cxIh640Rlr+Rt+FHgDsPdpPi/qMHwlScLtdOHsdsjDtztBZLJXOt7Degu6uLXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwNlXw5cljvMll2PZKnF2ec3YZMjE9HjZTkXWEYYt0tFPBVKjg
	xSfRp/qmGnvibWJpvwh0MFOruBkA22L0chr5zf9ht6GhB7IDnyoQ2ba5MJMrVcdA+Z8h3VMYpY9
	Lup30fWR12zY5h/RK4hPBdZFSdKQQSze8dP+r5cr6
X-Gm-Gg: ASbGncsECtGzNZwX9O+DK1sAK8CMyz0u41pMQjNIOgU5PZw5rnCfuKcxJkMeQAaKh0c
	rca7hcV8MUBcWIvhsA44WpzVDYN8kt7tmYGeJ67rdu8IGW72Sx4qbmdO86vQBSuWbvvI8Wy5KfU
	/FYX72P/M6y5nUwRXx5SSuqCXiIuKBiG7LilYjTQogi9oy859/4R6pMErNy4t4BL6ZgrIqzdBVn
	Bn77naL5ClGtXNh2j4qwB8E9VizaO04xlAI8cywsUw7
X-Google-Smtp-Source: AGHT+IHHjSzf3NV2oNZ+4jCL+Q3CGiZLU++ghIuFZUaAwP39HPwBNCyTkdmKOXeri3KEzlLXlrupijbAwtkieYahwpc=
X-Received: by 2002:aa7:d392:0:b0:623:27a7:25fc with SMTP id
 4fb4d7f45d1cf-62d4e6c02d0mr6933a12.5.1757454258460; Tue, 09 Sep 2025 14:44:18
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com> <20250909190945.1030905-8-Liam.Howlett@oracle.com>
In-Reply-To: <20250909190945.1030905-8-Liam.Howlett@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Sep 2025 14:44:05 -0700
X-Gm-Features: AS18NWDp7h4tRRYW9-ZNijDGSt7aO40ogQOfSscUNHcKVszsllLYH7lJ_PsLcVQ
Message-ID: <CAJuCfpG4D4ikZO1c8zN7HNgLTAco1ggk21rg9AUFwoztA95qSA@mail.gmail.com>
Subject: Re: [PATCH v1 7/9] mm: Introduce unmap_desc struct to reduce function arguments
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

On Tue, Sep 9, 2025 at 12:11=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> The unmap_region code uses a number of arguments that could use better
> documentation.  With the addition of a descriptor for unmap (called
> unmap_desc), the arguments can be more self-documenting and increase the
> descriptions within the declaration.
>
> No functional change intended
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 12 ++++++++----
>  mm/vma.c  | 27 ++++++++++++---------------
>  mm/vma.h  | 35 ++++++++++++++++++++++++++++++++---
>  3 files changed, 52 insertions(+), 22 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index aa4770b8d7f1e..5c9bd3f20e53f 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1883,11 +1883,15 @@ __latent_entropy int dup_mmap(struct mm_struct *m=
m, struct mm_struct *oldmm)
>                 if (max) {
>                         vma_iter_set(&vmi, 0);
>                         tmp =3D vma_next(&vmi);
> +                       UNMAP_REGION(unmap, &vmi, /* first vma =3D */ tmp=
,
> +                                    /* min vma addr =3D */ 0,
> +                                    /* max vma addr =3D */ max,
> +                                    /* prev =3D */ NULL, /* next =3D */ =
NULL);
> +
> +                       /* Don't free the pgtables higher than the failur=
e */
> +                       unmap.tree_max =3D max;

Sorry, the naming still feels confusing... tree_max is described as /*
Maximum for the vma tree search */ and here we set it to /* Don't free
the pgtables higher than the failure */.

>                         flush_cache_mm(mm);
> -                       unmap_region(&vmi.mas, /* vma =3D */ tmp,
> -                                    /*vma_min =3D */ 0, /* vma_max =3D *=
/ max,
> -                                    /* pg_max =3D */ max, /* prev =3D */=
 NULL,
> -                                    /* next =3D */ NULL);
> +                       unmap_region(&unmap);
>                         charge =3D tear_down_vmas(mm, &vmi, tmp, max);
>                         vm_unacct_memory(charge);
>                 }
> diff --git a/mm/vma.c b/mm/vma.c
> index 4c850ffd83a4b..c92384975cbb2 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -473,22 +473,20 @@ void remove_vma(struct vm_area_struct *vma)
>   *
>   * Called with the mm semaphore held.
>   */
> -void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> -               unsigned long vma_min, unsigned long vma_max, unsigned lo=
ng pg_max,
> -               struct vm_area_struct *prev, struct vm_area_struct *next)
> +void unmap_region(struct unmap_desc *desc)
>  {
> -       struct mm_struct *mm =3D vma->vm_mm;
> +       struct mm_struct *mm =3D desc->first->vm_mm;
> +       struct ma_state *mas =3D desc->mas;
>         struct mmu_gather tlb;
>
>         tlb_gather_mmu(&tlb, mm);
>         update_hiwater_rss(mm);
> -       unmap_vmas(&tlb, mas, vma, vma_min, vma_max, vma_max,
> -                  /* mm_wr_locked =3D */ true);
> -       mas_set(mas, vma->vm_end);
> -       free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_AD=
DRESS,
> -                     next ? next->vm_start : USER_PGTABLES_CEILING,
> -                     pg_max,
> -                     /* mm_wr_locked =3D */ true);
> +       unmap_vmas(&tlb, mas, desc->first, desc->vma_min, desc->vma_max,
> +                  desc->vma_max, desc->mm_wr_locked);
> +       mas_set(mas, desc->tree_reset);
> +       free_pgtables(&tlb, mas, desc->first, desc->first_pgaddr,
> +                     desc->last_pgaddr, desc->tree_max,
> +                     desc->mm_wr_locked);
>         tlb_finish_mmu(&tlb);
>  }
>
> @@ -2414,15 +2412,14 @@ static int __mmap_new_file_vma(struct mmap_state =
*map,
>
>         error =3D mmap_file(vma->vm_file, vma);
>         if (error) {
> +               UNMAP_REGION(unmap, vmi, vma, vma->vm_start, vma->vm_end,
> +                            map->prev, map->next);
>                 fput(vma->vm_file);
>                 vma->vm_file =3D NULL;
>
>                 vma_iter_set(vmi, vma->vm_end);
>                 /* Undo any partial mapping done by a device driver. */
> -               unmap_region(&vmi->mas, vma, vma->vm_start, vma->vm_end,
> -                            map->next ? map->next->vm_start : USER_PGTAB=
LES_CEILING,
> -                            map->prev, map->next);
> -
> +               unmap_region(&unmap);
>                 return error;
>         }
>
> diff --git a/mm/vma.h b/mm/vma.h
> index b0ebc81d5862e..4edd5d26ffcfc 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -152,6 +152,37 @@ struct vma_merge_struct {
>
>  };
>
> +struct unmap_desc {
> +       struct  ma_state *mas;        /* the maple state point to the fir=
st vma */
> +       struct vm_area_struct *first; /* The first vma */
> +       unsigned long first_pgaddr;   /* The first pagetable address to f=
ree */
> +       unsigned long last_pgaddr;    /* The last pagetable address to fr=
ee */
> +       unsigned long vma_min;        /* The min vma address */
> +       unsigned long vma_max;        /* The max vma address */
> +       unsigned long tree_max;       /* Maximum for the vma tree search =
*/
> +       unsigned long tree_reset;     /* Where to reset the vma tree walk=
 */
> +       bool mm_wr_locked;            /* If the mmap write lock is held *=
/
> +};
> +
> +#define UNMAP_REGION(name, _vmi, _vma, _vma_min, _vma_max, _prev, _next)=
      \

Maybe DEFINE_UNMAP_REGION() similar to DEFINE_PER_CPU() or DEFINE_SPINLOCK(=
)?

> +       struct unmap_desc name =3D {                                     =
     \
> +               .mas =3D &(_vmi)->mas,                                   =
       \
> +               .first =3D _vma,                                         =
       \
> +               .first_pgaddr =3D _prev ?                                =
       \
> +                       ((struct vm_area_struct *)_prev)->vm_end :       =
     \
> +                       FIRST_USER_ADDRESS,                              =
     \
> +               .last_pgaddr =3D _next ?                                 =
       \
> +                       ((struct vm_area_struct *)_next)->vm_start :     =
     \
> +                       USER_PGTABLES_CEILING,                           =
     \
> +               .vma_min =3D _vma_min,                                   =
       \
> +               .vma_max =3D _vma_max,                                   =
       \
> +               .tree_max =3D _next ?                                    =
       \
> +                       ((struct vm_area_struct *)_next)->vm_start :     =
     \
> +                       USER_PGTABLES_CEILING,                           =
     \
> +               .tree_reset =3D _vma->vm_end,                            =
       \
> +               .mm_wr_locked =3D true,                                  =
       \
> +       }
> +
>  static inline bool vmg_nomem(struct vma_merge_struct *vmg)
>  {
>         return vmg->state =3D=3D VMA_MERGE_ERROR_NOMEM;
> @@ -260,9 +291,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm=
_struct *mm,
>
>  void remove_vma(struct vm_area_struct *vma);
>
> -void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
> -               unsigned long min, unsigned long max, unsigned long pg_ma=
x,
> -               struct vm_area_struct *prev, struct vm_area_struct *next)=
;
> +void unmap_region(struct unmap_desc *desc);
>
>  /* We are about to modify the VMA's flags. */
>  __must_check struct vm_area_struct
> --
> 2.47.2
>

