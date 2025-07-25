Return-Path: <linux-kernel+bounces-746089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE49B12305
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8AEAC6807
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AC32EFD87;
	Fri, 25 Jul 2025 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HZKnCSK7"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F399E48CFC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753464623; cv=none; b=FhssesNhNBt0oVyB+DbheXWDIX9XC9heVOfuEfc3bd/pUkYKTWw/Vmp0rMKdf2Ztu0msHuPC3F9aaeeOE9Spo+3mcoUq7JvtZJPWaJLgU3mMfXQkK+ed8PdSMpMg5E6diHqUwQ+JYdCMdrjqZuB7YWFyoU96EWqmQKeSNywYb4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753464623; c=relaxed/simple;
	bh=6biO4cxCQOdK34SRChV5Rp8sQXu6WVbGWI+bNmSGfug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hmllp07J6Qata1YfgQON+NUtBFPnSsE/IHdTSszwrOmbS75hlV5YdIx4QfOUjep4KQGx8n/48yd0n2oiIGj8rCBKaXuVX1o5Hr/jrHqYxMgnuc2T8UZ8dERNjNJsyBRc+HoMnRb4VgzagdUaGBY8J92qYcjBrRD+rURyPWabA8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HZKnCSK7; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2ffb27793fdso14628fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753464621; x=1754069421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQ0Bu/BvQWMgs0y0itEC4STNhBs0pVrCSveit39+ORc=;
        b=HZKnCSK7e5Khs1utkN1/zsOJYFyfa2QdtvbBLnKCTkPYcGdyY7s/lplAtJi4LAEP5D
         fo6/EgoUrmfQ7nQTTqfY3+vVdt5KUnXb+a5wSDSdRUm+O3SdTRU4yNHeQfxbrTcL2Ma+
         WnLFc32hZOu1rB7qvi+6cFvaM/oHdc7Rxii9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753464621; x=1754069421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQ0Bu/BvQWMgs0y0itEC4STNhBs0pVrCSveit39+ORc=;
        b=S+E/yIpJtmryjWHhVuWbZDJPjtdp7NOXQzZ8eg1VoPf9e7x+7l9yJCxXttz3RRwzbX
         ET2kFw2XIERBwF7Aj6A/yKOejSI7VciLrzF0Xcn/NhhspWe6CPCrR4X9uOEtLAJEyV/g
         kVjdWt+5ZAgtlFbn1MLWAF0a5Z5S8C/MFxutYsYQ3AzIp/7qU+mFSQMAB1UvObE1ySsz
         3dL4uBnvV6EyFrkySQoWve69v0e/sZoLxZ3sFQOtfOvd5KmsfU8aWrKHociWrSPFM3B9
         BEvjvfr5Ub9RejvydqlViWbFP543nB3kcR9e4UVonrq3cj1bVidp0gj2p1UOpZBu57Sa
         hn8w==
X-Forwarded-Encrypted: i=1; AJvYcCUvqc2gr8WBwY47N+/2E+cv0bvP4gW/xYh8lK4UKci1X4yvHsFZQoZDB0O5+Emi2BEQwo4EjGy4+jAhd9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/CmdM+qN0/yxLYXGXnDAh4nXI9IqKWFIw0foTL0FEwoNDvxBw
	GBcShT3CF5+q9rCMj5zcPZAXreC9dgVAkMPenFGDhU26kLYk0v/QteNoHERMIUBLCsV35kPngrx
	eqTFSws4ywEusbx6SLXoaCcnX77SrR44LY6S4RjGR
X-Gm-Gg: ASbGncvij9i/xI5QLXQu5Xm4XHas6Y4i3lT0VYeDsTJs6QUf13oUnHpLF1zcoYkPH3L
	ItYfAR2nwl0xph9NXrd8SIM9aOMsZfHY1waxXEB4JnbCUkFXFUZ50+/tw0rsuVGryEKmdLrtYf/
	OazFgyErIkwSlP0bv4S/YM/rVdKukDIJmJ0A1qync30Zu0yysKssGNihAjSRh77mbtAFxi3fm/v
	/gXC8TlDD1wdqVI3R8FeqyAJ09o3Z8esXnnOCrxypI=
X-Google-Smtp-Source: AGHT+IHnkJmphoDh/b+ws8PYtxQHNySEY2goMZD4LausV3pkCZsARdu+y7zcV959yuoTBZwdv797T/qXFyB5w/Sg2pc=
X-Received: by 2002:a05:6871:610e:b0:297:2582:c66c with SMTP id
 586e51a60fabf-30701615412mr696302fac.0.1753464620858; Fri, 25 Jul 2025
 10:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753431105.git.lorenzo.stoakes@oracle.com> <dd50984eff1e242b5f7f0f070a3360ef760e06b8.1753431105.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <dd50984eff1e242b5f7f0f070a3360ef760e06b8.1753431105.git.lorenzo.stoakes@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 25 Jul 2025 10:30:08 -0700
X-Gm-Features: Ac12FXz_xBH_L3lj7AJvo6vEKgPTtF4nqiSbTlrCYQYJlbOo0M4g2knFYQTFhzg
Message-ID: <CABi2SkVeHWt+SKWWodXUNhXZi1Wv9YazEOGWEUJLvgPbopqBrA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] mm/mseal: simplify and rename VMA gap check
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

On Fri, Jul 25, 2025 at 1:30=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> The check_mm_seal() function is doing something general - checking whethe=
r
> a range contains only VMAs (or rather that it does NOT contain any
> unmapped regions).
>
> So rename this function to range_contains_unmapped().
>
Thanks for keeping the comments.

In the prior version of this patch, I requested that we keep the
check_mm_seal()  and its comments. And this version keeps the comments
but removes the check_mm_seal() name.

As I said, check_mm_seal() with its comments is a contract for
entry-check for mseal().  My understanding is that you are going to
move range_contains_unmapped() to vma.c. When that happens, mseal()
will lose this entry-check contract.

Contact is a great way to hide implementation details. Could you
please keep check_mm_seal() in mseal.c and create
range_contains_unmapped() in vma.c. Then you can refactor as needed.

Thanks and regards,
-Jeff





> Additionally simplify the logic, we are simply checking whether the last
> vma->vm_end has either a VMA starting after it or ends before the end
> parameter.
>
> This check is rather dubious, so it is sensible to keep it local to
> mm/mseal.c as at a later stage it may be removed, and we don't want any
> other mm code to perform such a check.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/mseal.c | 39 ++++++++++++++++-----------------------
>  1 file changed, 16 insertions(+), 23 deletions(-)
>
> diff --git a/mm/mseal.c b/mm/mseal.c
> index adbcc65e9660..1059322add34 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -38,31 +38,28 @@ static int mseal_fixup(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
>  }
>
>  /*
> - * Check for do_mseal:
> - * 1> start is part of a valid vma.
> - * 2> end is part of a valid vma.
> - * 3> No gap (unallocated address) between start and end.
> - * 4> map is sealable.
> + * Does the [start, end) range contain any unmapped memory?
> + *
> + * We ensure that:
> + * - start is part of a valid VMA.
> + * - end is part of a valid VMA.
> + * - no gap (unallocated memory) exists between start and end.
>   */
> -static int check_mm_seal(unsigned long start, unsigned long end)
> +static bool range_contains_unmapped(struct mm_struct *mm,
> +               unsigned long start, unsigned long end)
>  {
>         struct vm_area_struct *vma;
> -       unsigned long nstart =3D start;
> +       unsigned long prev_end =3D start;
>         VMA_ITERATOR(vmi, current->mm, start);
>
> -       /* going through each vma to check. */
>         for_each_vma_range(vmi, vma, end) {
> -               if (vma->vm_start > nstart)
> -                       /* unallocated memory found. */
> -                       return -ENOMEM;
> -
> -               if (vma->vm_end >=3D end)
> -                       return 0;
> +               if (vma->vm_start > prev_end)
> +                       return true;
>
> -               nstart =3D vma->vm_end;
> +               prev_end =3D vma->vm_end;
>         }
>
> -       return -ENOMEM;
> +       return prev_end < end;
>  }
>
>  /*
> @@ -184,14 +181,10 @@ int do_mseal(unsigned long start, size_t len_in, un=
signed long flags)
>         if (mmap_write_lock_killable(mm))
>                 return -EINTR;
>
> -       /*
> -        * First pass, this helps to avoid
> -        * partial sealing in case of error in input address range,
> -        * e.g. ENOMEM error.
> -        */
> -       ret =3D check_mm_seal(start, end);
> -       if (ret)
> +       if (range_contains_unmapped(mm, start, end)) {
> +               ret =3D -ENOMEM;
>                 goto out;
> +       }
>
>         /*
>          * Second pass, this should success, unless there are errors
> --
> 2.50.1
>

