Return-Path: <linux-kernel+bounces-746086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8AFB122FE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0999189011D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C992EFD81;
	Fri, 25 Jul 2025 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CGfzdbul"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EF12EF2AD
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753464552; cv=none; b=a5DCPUpVn7UIBFzbqRe14x4oRFDBCsp7GHxudjSsRGoP7ArccuITYh8T3mskMLm68st/4QGrrBpad76suIxkBJu1O8k3YTF2ysQqhfFduzSIl9pJPDaOkssyDaATBxGr/5hb2uOBBrKDVTpqRquOkR4HvjuatkdKlZcjtHYKRYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753464552; c=relaxed/simple;
	bh=Ybq6HVDTOe9Pd1J4ECOh0tbaJ4bFLpThdQwqZike1i8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f44Yaee6DRYMajykXjdWUlud/upBLCyR6bVfj/KveW4RZ55XrVtL2kdgs95LanRhBAxidXKSeX7Hlx7nYkSjERnxOwyW5PzPkVdZOSKGhXi5hEKM7W1robntgQX1cg1uQ8gCzPnJRlEK+is5+cCvmoI4EoE6PvTcZY6avcjZBFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CGfzdbul; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2ff92caabcaso258969fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753464550; x=1754069350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSaE+fdvZNJRb9bk+7FrHFzB6ezZdAXVqKWN6jX9fuc=;
        b=CGfzdbul8cpmh4nOd54OURPjtgk5vupyeaOMTuG+9TdSILSoZ1X8vFO/UqtXeodAYi
         F63WQus+RcOSN7Zk07QVtt/Iluewxv6k20a3ZCssGhmyndmyu1NP3wFWU+0tMhM7BOyE
         U6xq2LZD1c3X2i1YcUkMDyJ3WBzE99xMfyY48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753464550; x=1754069350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSaE+fdvZNJRb9bk+7FrHFzB6ezZdAXVqKWN6jX9fuc=;
        b=L4AG+ysE6vfwXApwQK3MeqtGfWr9kCGN3g9j84Khb+dsZ5PBcwuZbPQXIE0j7fwDZi
         VA/ZhS/CqNsoKF6q61yJj1LbnkjtBCzJP73W7LySFJce1iNqdTtFTHvVvxo3iGwYvWBn
         pg5xhWMUavkyQxkIhFbfV9wZnGCb2PFUNdS5u3WJIYphyqHYXEk6n59Kf+jhufLCz1uW
         As8pu4p0JoLXNujz21LKJmWaKMso9SdqNN8VWBfpeVrGAWPo6hM0wU6TyRNeS5qT9CY9
         cSi1xbBXeOBVJlWi3tDTygBFSCdzrsMPL4XqxV/IlpnfNnKFVSiRkY9l4kZyKbLqWuBf
         c1gQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8RzskA6vNjYpbikafRxs9v7WHTMzznvCT4jMe6hTkoVzLxJfx5/FiuBNyMv70ks1FoofAYY6oF0zNAqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ3NbwaBlKWV6P4lEw4LBrrdRcJyRjoS5/M3cjIH9PI3xzbiyw
	QN3Flzve2ykGL/h61NmQUxn854zDdohp6Gg+mTokykw/VQNbMl8swX50frt5Yhe/oeEqznsPNDW
	1ecmdr92poaIcYIQN3M1dBpSgd4ZuCbslMG/YUCoR
X-Gm-Gg: ASbGncujcryX6EOQTz1O0XoJ1ODGNycy3olyEgo6CWyTptOvgZiUxwVKxcuzDhSoqq2
	HdcEtCXHVxKD96TiRH+ent+4ZTNqJNatqiWVC42piKyXlg6VyaGwGaPUJCMmd5EpWvh0cX8bQGg
	Rws7bL74BiWGPT6bfxNFtJlEheEdg0YoiPctaCr9bZ1ydi7OIbF+SyjYkk0cwie/Z5T/UJNGc5g
	taNvCNpOjxfivYvOIWowzuv0257ldb6+N8hLQ==
X-Google-Smtp-Source: AGHT+IEFqlrwTnKDoR7DIn2NqYJ23XBMp5ePhuoZhZWSSkqYz9HxqLYfIgNGRVP8ewYjbRm4dTAB2AFJDFMz9nij6pk=
X-Received: by 2002:a05:6870:3801:b0:2b8:f99d:7ce6 with SMTP id
 586e51a60fabf-30701e53f8emr649983fac.3.1753464549754; Fri, 25 Jul 2025
 10:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753431105.git.lorenzo.stoakes@oracle.com> <492a98d9189646e92c8f23f4cce41ed323fe01df.1753431105.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <492a98d9189646e92c8f23f4cce41ed323fe01df.1753431105.git.lorenzo.stoakes@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 25 Jul 2025 10:28:57 -0700
X-Gm-Features: Ac12FXz_pXsJ1IDMKlfMO5R9PgQPO6x_W1wy-9G-nGooGD61YrZpGMC1Em0jUKM
Message-ID: <CABi2SkVSjRV_zz0mhuRF3t3UJM_x=+gct1jbV=qd7eNMPBbvkQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] mm/mseal: update madvise() logic
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo

On Fri, Jul 25, 2025 at 1:30=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> The madvise() logic is inexplicably performed in mm/mseal.c - this ought
> to be located in mm/madvise.c.
>
> Additionally can_modify_vma_madv() is inconsistently named and, in
> combination with is_ro_anon(), is very confusing logic.
>
> Put a static function in mm/madvise.c instead - can_madvise_modify() -
> that spells out exactly what's happening.  Also explicitly check for an
> anon VMA.
>
> Also add commentary to explain what's going on.
>
> Essentially - we disallow discarding of data in mseal()'d mappings in
> instances where the user couldn't otherwise write to that data.
>
> We retain the existing behaviour here regarding MAP_PRIVATE mappings of
> file-backed mappings, which entails some complexity - while this, strictl=
y
> speaking - appears to violate mseal() semantics, it may interact badly wi=
th
> users which expect to be able to madvise(MADV_DONTNEED) .text mappings fo=
r
> instance.
>
> We may revisit this at a later date.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/madvise.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  mm/mseal.c   | 49 ------------------------------------
>  mm/vma.h     |  7 ------
>  3 files changed, 70 insertions(+), 57 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index bb80fc5ea08f..7f9af2dbd044 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -19,6 +19,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/mm.h>
>  #include <linux/mm_inline.h>
> +#include <linux/mmu_context.h>
>  #include <linux/string.h>
>  #include <linux/uio.h>
>  #include <linux/ksm.h>
> @@ -1256,6 +1257,74 @@ static long madvise_guard_remove(struct madvise_be=
havior *madv_behavior)
>                                &guard_remove_walk_ops, NULL);
>  }
>
> +#ifdef CONFIG_64BIT
> +/* Does the madvise operation result in discarding of mapped data? */
> +static bool is_discard(int behavior)
> +{
> +       switch (behavior) {
> +       case MADV_FREE:
> +       case MADV_DONTNEED:
> +       case MADV_DONTNEED_LOCKED:
> +       case MADV_REMOVE:
> +       case MADV_DONTFORK:
> +       case MADV_WIPEONFORK:
> +       case MADV_GUARD_INSTALL:
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +/*
> + * We are restricted from madvise()'ing mseal()'d VMAs only in very part=
icular
> + * circumstances - discarding of data from read-only anonymous SEALED ma=
ppings.
> + *
> + * This is because users cannot trivally discard data from these VMAs, a=
nd may
> + * only do so via an appropriate madvise() call.
> + */
> +static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
> +{
> +       struct vm_area_struct *vma =3D madv_behavior->vma;
> +
> +       /* If the VMA isn't sealed we're good. */
> +       if (can_modify_vma(vma))
> +               return true;
> +
> +       /* For a sealed VMA, we only care about discard operations. */
> +       if (!is_discard(madv_behavior->behavior))
> +               return true;
> +
> +       /*
> +        * We explicitly permit all file-backed mappings, whether MAP_SHA=
RED or
> +        * MAP_PRIVATE.
> +        *
> +        * The latter causes some complications. Because now, one can mma=
p()
> +        * read/write a MAP_PRIVATE mapping, write to it, then mprotect()
> +        * read-only, mseal() and a discard will be permitted.
> +        *
> +        * However, in order to avoid issues with potential use of madvis=
e(...,
> +        * MADV_DONTNEED) of mseal()'d .text mappings we, for the time be=
ing,
> +        * permit this.
> +        */
> +       if (!vma_is_anonymous(vma))
> +               return true;
> +
> +       /* If the user could write to the mapping anyway, then this is fi=
ne. */
> +       if ((vma->vm_flags & VM_WRITE) &&
> +           arch_vma_access_permitted(vma, /* write=3D */ true,
> +                       /* execute=3D */ false, /* foreign=3D */ false))
> +               return true;
> +
> +       /* Otherwise, we are not permitted to perform this operation. */
> +       return false;
> +}
> +#else
> +static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
> +{
> +       return true;
> +}
> +#endif
> +
>  /*
>   * Apply an madvise behavior to a region of a vma.  madvise_update_vma
>   * will handle splitting a vm area into separate areas, each area with i=
ts own
> @@ -1269,7 +1338,7 @@ static int madvise_vma_behavior(struct madvise_beha=
vior *madv_behavior)
>         struct madvise_behavior_range *range =3D &madv_behavior->range;
>         int error;
>
> -       if (unlikely(!can_modify_vma_madv(madv_behavior->vma, behavior)))
> +       if (unlikely(!can_madvise_modify(madv_behavior)))
>                 return -EPERM;
>
>         switch (behavior) {
> diff --git a/mm/mseal.c b/mm/mseal.c
> index c27197ac04e8..1308e88ab184 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -11,7 +11,6 @@
>  #include <linux/mman.h>
>  #include <linux/mm.h>
>  #include <linux/mm_inline.h>
> -#include <linux/mmu_context.h>
>  #include <linux/syscalls.h>
>  #include <linux/sched.h>
>  #include "internal.h"
> @@ -21,54 +20,6 @@ static inline void set_vma_sealed(struct vm_area_struc=
t *vma)
>         vm_flags_set(vma, VM_SEALED);
>  }
>
> -static bool is_madv_discard(int behavior)
> -{
> -       switch (behavior) {
> -       case MADV_FREE:
> -       case MADV_DONTNEED:
> -       case MADV_DONTNEED_LOCKED:
> -       case MADV_REMOVE:
> -       case MADV_DONTFORK:
> -       case MADV_WIPEONFORK:
> -       case MADV_GUARD_INSTALL:
> -               return true;
> -       }
> -
> -       return false;
> -}
> -
> -static bool is_ro_anon(struct vm_area_struct *vma)
> -{
> -       /* check anonymous mapping. */
> -       if (vma->vm_file || vma->vm_flags & VM_SHARED)
> -               return false;

In this patch, the check for anonymous mapping are replaced with:

 if (!vma_is_anonymous(vma))
      return true;

vma_is_anonymous()  is implemented as following:
static inline bool vma_is_anonymous(struct vm_area_struct *vma)
{
   return !vma->vm_ops;
}

I'm curious to know if those two checks have the exact same scope.

The original intention is only file-backed mapping can allow
destructive madvise while sealed. I want to make sure that we don't
accidentally increase the scope.

Thanks and regards,
-Jeff



> -
> -       /*
> -        * check for non-writable:
> -        * PROT=3DRO or PKRU is not writeable.
> -        */
> -       if (!(vma->vm_flags & VM_WRITE) ||
> -               !arch_vma_access_permitted(vma, true, false, false))
> -               return true;
> -
> -       return false;
> -}
> -
> -/*
> - * Check if a vma is allowed to be modified by madvise.
> - */
> -bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
> -{
> -       if (!is_madv_discard(behavior))
> -               return true;
> -
> -       if (unlikely(!can_modify_vma(vma) && is_ro_anon(vma)))
> -               return false;
> -
> -       /* Allow by default. */
> -       return true;
> -}
> -
>  static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *=
vma,
>                 struct vm_area_struct **prev, unsigned long start,
>                 unsigned long end, vm_flags_t newflags)
> diff --git a/mm/vma.h b/mm/vma.h
> index acdcc515c459..85db5e880fcc 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -577,8 +577,6 @@ static inline bool can_modify_vma(struct vm_area_stru=
ct *vma)
>         return true;
>  }
>
> -bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior);
> -
>  #else
>
>  static inline bool can_modify_vma(struct vm_area_struct *vma)
> @@ -586,11 +584,6 @@ static inline bool can_modify_vma(struct vm_area_str=
uct *vma)
>         return true;
>  }
>
> -static inline bool can_modify_vma_madv(struct vm_area_struct *vma, int b=
ehavior)
> -{
> -       return true;
> -}
> -
>  #endif
>
>  #if defined(CONFIG_STACK_GROWSUP)
> --
> 2.50.1

