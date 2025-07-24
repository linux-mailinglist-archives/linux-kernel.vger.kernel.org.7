Return-Path: <linux-kernel+bounces-744796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76D0B11113
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 234DE7BD19C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCE82EE288;
	Thu, 24 Jul 2025 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LxTG8CRa"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A22EE27B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382506; cv=none; b=mOv5NepCDbDhjRGp5QPDhCmHoRH/jQKGjdoadBmWDFhV4s8yUZBeO/0YCzvVMlam26Niw7oAQZ4ijILHBqV8WMrGfobaAtN44mxnRpTJdONnAvRqi7VN6/n7vZ9uO+A/i2zql7aPo8QNvZjNKyUEu0V1GTTHFRewpUnyjru5qL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382506; c=relaxed/simple;
	bh=UOwoGaDOvoje/9q1jcfzkopAP+bmCXpqgcS9RU00fkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFA2YjpvXpnP23QyWxBhTEueLNm7IiOAjWX3iXQhSv8/w2t3fwj+3Izt62KBbcmd2Q7XyIZlxs4nq340O8ATL4KlB0OSKlwrISuwcwpBLPPLNilJGDX5tynZ/Qtsty3mEtHzlUhLSjGPNTqEY9cRsmy/QkwaVoMEU50TVZtpZ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LxTG8CRa; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30687111693so214639fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753382502; x=1753987302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1HWlZ2q1kj2IfdBM1XqDySr0QM/i4rMvQ57Io2GLV0=;
        b=LxTG8CRaRwICQ+enPfg6ghra7oYvS6Iblco9sgqEVtQzt8t6zX9YN+gpqOf+pvkUBb
         mzxjpftet4NpvBb7YYXq+5MGSR03RcS8qRqa9UTDLzFhjNZe2SbWcXktF3AqPIeL8UAu
         Uj1pCe/DRd5+KAlNt1gyArow3BYGyABtOIEJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753382502; x=1753987302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1HWlZ2q1kj2IfdBM1XqDySr0QM/i4rMvQ57Io2GLV0=;
        b=as/JRIxAj03m2Eem3cS67hDkLpfu6hVZynUZzfD88g2+YrAosaaF8iZ9yf4F9ay7nC
         Pa2L848/9KQketOoGuh7XCB4cgkYZ1gJNSLnG1x/FM/8F55WKeX3c6/Zydiv88p2D0Uk
         swuTjGENcNsK7SyYLu32sG091Qg8K+/phUaZnDfRjFaXeAzYwnqEJAFXlVI/ZYfZ6GZN
         zsqPQ3hY0ICVU8a4iUEDxB4VF359vekX69WYLcRnH0sFPtbwYgbVuOwOx9pqxe3UMD3R
         kRjo32ko+cYDpAADPGSOZV6D0cDZrnF1pwS+mqRnxT+klRamPg/yUE/At3jQC4KGwbnb
         SdMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwPZhrjSebFiSgrPZHbU9t/pPPfV7FQ05Ki+HiAqGI0d+A3h0BoLZH3pEss6SCZushUBp0JpAVJxXXA4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrsppdjq6emPEK1Z7FDy4sCgv5z8Tx1QM+RtxirT41rqmUXz6d
	x/cZElPnEBTF5YX8uG5EEWfgXYpto+yZljSHVrSu6p7+rB4oo5WGdUnEsxBP4pKz3fLMKF1rO6J
	Pw3fFm7HfrLyIyICBuz5+uIUBsLf8E5gr+smiqhwi
X-Gm-Gg: ASbGncvCN1Q9qnNtR44nhkJ7AtiKlLieh2RCuugUPOb/TwC8ykmJGlgcvcF0a9uT9Ft
	YNsX1xrxIXkDnzBH/LNWYp0kO9BMUt+c6RdW+pfvPEzpPvWpzOIb0rBgHRyv4CzyhDVabmUuCdP
	7kzVELBRHCbVdyOP/IritPNSeMBSbDSDOTwB0CAsCV8nI4YQ14nJbUQo3yBKNo2LdWhHbMeMdCN
	rdMTpKzzA1yS485hODXyDo31oDYI2YS848E
X-Google-Smtp-Source: AGHT+IFGOCABTTvB+uzF9wmiyKAOSjp+0YvJguYqvnGbeIpD4kNUAbPp92D+Kc9fHRgycq+ZSZnoA+bqeSnlnTMvEN0=
X-Received: by 2002:a05:6871:71c5:b0:2b8:f99d:7ce6 with SMTP id
 586e51a60fabf-306c6f21d67mr1770212fac.3.1753382502323; Thu, 24 Jul 2025
 11:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com> <9ae70e1c509d790cf174f16e491975efd9be50b6.1752687069.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <9ae70e1c509d790cf174f16e491975efd9be50b6.1752687069.git.lorenzo.stoakes@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 24 Jul 2025 11:41:30 -0700
X-Gm-Features: Ac12FXycf8JmBrOhOyz1OgvG94mrvgZe6JkSBqJucvHYxI-9914zkEue6RQd-ZA
Message-ID: <CABi2SkXQsao-S+uy63k6Zc=y4W-pik6XZSzw+05f_Ws_frqZmQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] mm/mseal: rework mseal apply logic
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
> The logic can be simplified - firstly by renaming the inconsistently name=
d
> apply_mm_seal() to mseal_apply().
>
> We then wrap mseal_fixup() into the main loop as the logic is simple enou=
gh
> to not require it, equally it isn't a hugely pleasant pattern in mprotect=
()
> etc.  so it's not something we want to perpetuate.
>
> We eliminate the need for invoking vma_iter_end() on each loop by directl=
y
> determining if the VMA was merged - the only thing we need concern
> ourselves with is whether the start/end of the (gapless) range are offset
> into VMAs.
>
> This refactoring also avoids the rather horrid 'pass pointer to prev
> around' pattern used in mprotect() et al.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Jeff Xu <jeffxu@chromium.org>

Thanks and regards,
-Jeff
> ---
>  mm/mseal.c | 67 ++++++++++++++++--------------------------------------
>  1 file changed, 20 insertions(+), 47 deletions(-)
>
> diff --git a/mm/mseal.c b/mm/mseal.c
> index 61c07b1369cb..0ab12e09792a 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -15,28 +15,6 @@
>  #include <linux/sched.h>
>  #include "internal.h"
>
> -static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *=
vma,
> -               struct vm_area_struct **prev, unsigned long start,
> -               unsigned long end, vm_flags_t newflags)
> -{
> -       int ret =3D 0;
> -       vm_flags_t oldflags =3D vma->vm_flags;
> -
> -       if (newflags =3D=3D oldflags)
> -               goto out;
> -
> -       vma =3D vma_modify_flags(vmi, *prev, vma, start, end, newflags);
> -       if (IS_ERR(vma)) {
> -               ret =3D PTR_ERR(vma);
> -               goto out;
> -       }
> -
> -       vm_flags_set(vma, VM_SEALED);
> -out:
> -       *prev =3D vma;
> -       return ret;
> -}
> -
>  /* Does the [start, end) range contain any unmapped memory? */
>  static bool range_contains_unmapped(struct mm_struct *mm,
>                 unsigned long start, unsigned long end)
> @@ -55,38 +33,33 @@ static bool range_contains_unmapped(struct mm_struct =
*mm,
>         return prev_end < end;
>  }
>
> -/*
> - * Apply sealing.
> - */
> -static int apply_mm_seal(unsigned long start, unsigned long end)
> +static int mseal_apply(struct mm_struct *mm,
> +               unsigned long start, unsigned long end)
>  {
> -       unsigned long nstart;
>         struct vm_area_struct *vma, *prev;
> -       VMA_ITERATOR(vmi, current->mm, start);
> +       unsigned long curr_start =3D start;
> +       VMA_ITERATOR(vmi, mm, start);
>
> +       /* We know there are no gaps so this will be non-NULL. */
>         vma =3D vma_iter_load(&vmi);
> -       /*
> -        * Note: check_mm_seal should already checked ENOMEM case.
> -        * so vma should not be null, same for the other ENOMEM cases.
> -        */
>         prev =3D vma_prev(&vmi);
>         if (start > vma->vm_start)
>                 prev =3D vma;
>
> -       nstart =3D start;
>         for_each_vma_range(vmi, vma, end) {
> -               int error;
> -               unsigned long tmp;
> -               vm_flags_t newflags;
> -
> -               newflags =3D vma->vm_flags | VM_SEALED;
> -               tmp =3D vma->vm_end;
> -               if (tmp > end)
> -                       tmp =3D end;
> -               error =3D mseal_fixup(&vmi, vma, &prev, nstart, tmp, newf=
lags);
> -               if (error)
> -                       return error;
> -               nstart =3D vma_iter_end(&vmi);
> +               unsigned long curr_end =3D MIN(vma->vm_end, end);
> +
> +               if (!(vma->vm_flags & VM_SEALED)) {
> +                       vma =3D vma_modify_flags(&vmi, prev, vma,
> +                                       curr_start, curr_end,
> +                                       vma->vm_flags | VM_SEALED);
> +                       if (IS_ERR(vma))
> +                               return PTR_ERR(vma);
> +                       vm_flags_set(vma, VM_SEALED);
> +               }
> +
> +               prev =3D vma;
> +               curr_start =3D curr_end;
>         }
>
>         return 0;
> @@ -185,10 +158,10 @@ int do_mseal(unsigned long start, size_t len_in, un=
signed long flags)
>          * reaching the max supported VMAs, however, those cases shall
>          * be rare.
>          */
> -       ret =3D apply_mm_seal(start, end);
> +       ret =3D mseal_apply(mm, start, end);
>
>  out:
> -       mmap_write_unlock(current->mm);
> +       mmap_write_unlock(mm);
>         return ret;
>  }
>
> --
> 2.50.1
>

