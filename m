Return-Path: <linux-kernel+bounces-744793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033A5B11101
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF3B5A4972
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C66A2701D6;
	Thu, 24 Jul 2025 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OyaNlm1N"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E005A26CE2A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382416; cv=none; b=gIL6fvVUwUAQb+IrN86nbPnOXS/ihSt9NkU2hul6un7sfoxKA+Kj8sJ9TXOYAKXdpYYsYn4HIiTMjn1ONA5fXiTh7D1w2EmBs/aTrJZTioyNtNjinQ+FHe8QVs545T5my6GCRcVm3r0RCs+oyM5cQn/tupYwpL+q7GzrRseT5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382416; c=relaxed/simple;
	bh=8GkZkXvRavBH9B3NFyyarkpIMnKHJRPaj9XdVoFyU2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rp8HKSZb5z1MsI0X/T9FBTQIthM+JRJN6Yu7PQodouMwQjLCABdWl7zDUZ3G062Z796b2QIPBD2ti3H6yCup8ecg1lHBCD5KQaVbF7FlsfbNST9SH3fl/TLcxC10Bz6i5ga0wi41PfLACm5SbgwUOiWu0tPV27UaDexd0cEPgZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OyaNlm1N; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2ffaa4b4f32so31577fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753382414; x=1753987214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BMNHZLCVEeiqDvQaiWaHPR4yi2NaTZkc3BJ0ttGl9Y=;
        b=OyaNlm1NcbDByicM7WWsifKr6iAMLDLlvPeQobtW1gfjOBXs576Ve74iA7uUgt5NpA
         jUfTQe9wD8v8F57rzaAGwEAlzVzlmBkvAhml1NFkuGIaR5mGtn2QQ2PGGXx2kVroChd4
         8AAzLc7i8J3Omc1CwTY0Rx46DdeUS57HsLhwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753382414; x=1753987214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BMNHZLCVEeiqDvQaiWaHPR4yi2NaTZkc3BJ0ttGl9Y=;
        b=fu6A5WipT5+0LdRyI2coer2pTsrQp7Fj2B7zFgGjk1J2OjiRrpDvLMvlJxPSpt0TwF
         t6/y+Xg8FFnGoIhqM4ikye3kbOVQ5sR6B4wSEsDriLbSkmtXYbrUwkvlIaleuxcYA1F3
         +wLIQ7kukokhWVYB+QWSnyX1jAprAZzMOrK9OPTFF3MnqxaOjbtW7Skt88EgkmhKToqZ
         /0QqNYdNsEAm4cnLMhkYDwzMgZlP8NxAhxv1T80kndpA83gu4beFDu26YrFtyplttkxm
         lLsC74CZjsSGbFWcgdZCJLuvGCSXeux8ZRUT+ZvWbhC5Aw53ePbzZsoZo64BRm9k1zeY
         1qBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwVi6TPyworBhbjIcRZqDQzGit9kRMm9+4zrdWbvEV5DZQb5+PpJL6lTUmHyW8fxY7NDTb/PjKjNc84uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTTAvpgH5IECW9Yf05pF8DpfSFLLTe6xRwdJpT5NCe7KkoHiRd
	CPOWDllKbU9z/DpfDf7v3ECE0Dr8XOMxDLEPnI8MlSTC4s98f8HkSSN9saMbYbwUGMRK6Nh6nu8
	MNdmruB56IiVZkB2zk6ahNiKzwOP7GFgtF5tgNah4
X-Gm-Gg: ASbGncvvz1JNPhYhpP4m7pJpBHVq9v2NTPXL7K4826Psxujzhn7wmPUvxALxooBANnK
	AqDwoXsjtA5mIVz7CY8bhTBRSMJW/9e/IIqY8Hkzu0V1PJdiECpedEv0AYowgm9FLVLw88hWoQF
	40m8w5lzQw31Oko6h5wgZmJJ5VcbGGUGI9NQQCJQNCkaIfa3BxAZFV8ONnvH4lI0uWQoo9O+fZE
	KM96A7d/MgeQtKmD/S+dTmjJtIqfFSAExdV
X-Google-Smtp-Source: AGHT+IHIg+HNobqPln9IVjLqjazZFObcWO0xYiJwOyYA5v6NMPyUL45KIuuKS1EbBH0g5KjtFnTF/JHPrS1eWYH49pw=
X-Received: by 2002:a05:6871:3427:b0:2c1:b4ce:e43b with SMTP id
 586e51a60fabf-306c735ce5cmr2179176fac.12.1753382413658; Thu, 24 Jul 2025
 11:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com> <ac51c2a3c68a2475149b54180ff012fffab72c02.1752687069.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <ac51c2a3c68a2475149b54180ff012fffab72c02.1752687069.git.lorenzo.stoakes@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 24 Jul 2025 11:40:01 -0700
X-Gm-Features: Ac12FXznMGya-BnO3U5H6mKpJLmpNyl0TeBQAlHn33pD748OLsKUzh_9L0k-wdw
Message-ID: <CABi2SkXHyF+dHo7Rv5V1jPZ4B5_v4Hva-A4XphtRMQJTrw_jqQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] mm/mseal: small cleanups
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

On Wed, Jul 16, 2025 at 10:38=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Drop the wholly unnecessary set_vma_sealed() helper(), which is used only
> once, and place VMA_ITERATOR() declarations in the correct place.
>
> Retain vma_is_sealed(), and use it instead of the confusingly named
> can_modify_vma(), so it's abundantly clear what's being tested, rather th=
en
> a nebulous sense of 'can the VMA be modified'.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Jeff Xu <jeffxu@chromium.org>

Thanks and regards
-Jeff
> ---
>  mm/madvise.c  |  2 +-
>  mm/mprotect.c |  2 +-
>  mm/mremap.c   |  2 +-
>  mm/mseal.c    |  9 +--------
>  mm/vma.c      |  4 ++--
>  mm/vma.h      | 20 ++------------------
>  6 files changed, 8 insertions(+), 31 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index dc3d8497b0f4..da6e0e7c00b5 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1286,7 +1286,7 @@ static bool can_madvise_modify(struct madvise_behav=
ior *madv_behavior)
>         struct vm_area_struct *vma =3D madv_behavior->vma;
>
>         /* If the VMA isn't sealed we're good. */
> -       if (can_modify_vma(vma))
> +       if (!vma_is_sealed(vma))
>                 return true;
>
>         /* For a sealed VMA, we only care about discard operations. */
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 88709c01177b..807939177065 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -605,7 +605,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_g=
ather *tlb,
>         unsigned long charged =3D 0;
>         int error;
>
> -       if (!can_modify_vma(vma))
> +       if (vma_is_sealed(vma))
>                 return -EPERM;
>
>         if (newflags =3D=3D oldflags) {
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 5b7fe8f36074..8e93eca86721 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1649,7 +1649,7 @@ static int check_prep_vma(struct vma_remap_struct *=
vrm)
>                 return -EFAULT;
>
>         /* If mseal()'d, mremap() is prohibited. */
> -       if (!can_modify_vma(vma))
> +       if (vma_is_sealed(vma))
>                 return -EPERM;
>
>         /* Align to hugetlb page size, if required. */
> diff --git a/mm/mseal.c b/mm/mseal.c
> index 1308e88ab184..adbcc65e9660 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -15,11 +15,6 @@
>  #include <linux/sched.h>
>  #include "internal.h"
>
> -static inline void set_vma_sealed(struct vm_area_struct *vma)
> -{
> -       vm_flags_set(vma, VM_SEALED);
> -}
> -
>  static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *=
vma,
>                 struct vm_area_struct **prev, unsigned long start,
>                 unsigned long end, vm_flags_t newflags)
> @@ -36,7 +31,7 @@ static int mseal_fixup(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
>                 goto out;
>         }
>
> -       set_vma_sealed(vma);
> +       vm_flags_set(vma, VM_SEALED);
>  out:
>         *prev =3D vma;
>         return ret;
> @@ -53,7 +48,6 @@ static int check_mm_seal(unsigned long start, unsigned =
long end)
>  {
>         struct vm_area_struct *vma;
>         unsigned long nstart =3D start;
> -
>         VMA_ITERATOR(vmi, current->mm, start);
>
>         /* going through each vma to check. */
> @@ -78,7 +72,6 @@ static int apply_mm_seal(unsigned long start, unsigned =
long end)
>  {
>         unsigned long nstart;
>         struct vm_area_struct *vma, *prev;
> -
>         VMA_ITERATOR(vmi, current->mm, start);
>
>         vma =3D vma_iter_load(&vmi);
> diff --git a/mm/vma.c b/mm/vma.c
> index fc502b741dcf..75fd2759964b 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1351,7 +1351,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap=
_struct *vms,
>                 }
>
>                 /* Don't bother splitting the VMA if we can't unmap it an=
yway */
> -               if (!can_modify_vma(vms->vma)) {
> +               if (vma_is_sealed(vms->vma)) {
>                         error =3D -EPERM;
>                         goto start_split_failed;
>                 }
> @@ -1371,7 +1371,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap=
_struct *vms,
>         for_each_vma_range(*(vms->vmi), next, vms->end) {
>                 long nrpages;
>
> -               if (!can_modify_vma(next)) {
> +               if (vma_is_sealed(next)) {
>                         error =3D -EPERM;
>                         goto modify_vma_failed;
>                 }
> diff --git a/mm/vma.h b/mm/vma.h
> index 85db5e880fcc..b123a9cdedb0 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -559,31 +559,15 @@ struct vm_area_struct *vma_iter_next_rewind(struct =
vma_iterator *vmi,
>  }
>
>  #ifdef CONFIG_64BIT
> -
>  static inline bool vma_is_sealed(struct vm_area_struct *vma)
>  {
>         return (vma->vm_flags & VM_SEALED);
>  }
> -
> -/*
> - * check if a vma is sealed for modification.
> - * return true, if modification is allowed.
> - */
> -static inline bool can_modify_vma(struct vm_area_struct *vma)
> -{
> -       if (unlikely(vma_is_sealed(vma)))
> -               return false;
> -
> -       return true;
> -}
> -
>  #else
> -
> -static inline bool can_modify_vma(struct vm_area_struct *vma)
> +static inline bool vma_is_sealed(struct vm_area_struct *vma)
>  {
> -       return true;
> +       return false;
>  }
> -
>  #endif
>
>  #if defined(CONFIG_STACK_GROWSUP)
> --
> 2.50.1
>

