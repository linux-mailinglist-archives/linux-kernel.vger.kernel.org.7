Return-Path: <linux-kernel+bounces-744794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA15DB11102
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08A01744F5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284B02E9EB6;
	Thu, 24 Jul 2025 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g7iV9rCz"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB47A148830
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382473; cv=none; b=BJ7UQADgz3N7qyOAPrKjRFDHqZa+7BTrQ1R5OHrUdlDWTb5e4elCivTjRBhnA+UZdp5VBXT7Po4mwIq5lbJovQQDH10s26QLhadYrUp7Ikodclifm4DhmUQBt/wZgigkH53jv7mmRLL0gk/qHtczKWTCh960wesQzC6A0Og/ILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382473; c=relaxed/simple;
	bh=IlyfWnsgnG/qOi3cvsxobjLRobl4VgBJf+TWR2bCOfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAVmI/qaZVbCovo79wRWK8TZLUXISB5C1+S6wy+/BRP6AAFilZe2j978OlGQbDXTAktMU7ryh7GbTHgcmSrAJFMma+aufwWMb06+QsEszVbkNTzX3HWn1vfpzEO49zZD6FOAT7geBFr/hUq/0QblS7L7DnKQ5IKDV6RGKD4Qz1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g7iV9rCz; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2f3b9afe4a0so31830fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753382471; x=1753987271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdGmQQBULDak1afO6wOGgGVbsIT5jshSzS0GzXEZM9Q=;
        b=g7iV9rCzSluWBP/LMdOvVIA26kXNpef6vaPXbosUoVyt9UtDmdq2aWuvH3b9XUyhKc
         ZkgQVGesg//dd3FwvLQGxznV5CDHOORzCq+5NRTjOp8kLOle3zRwM8+fsqjX4UJA3Ks8
         dFKV6TOXIPpM9MIZfNlQMd29NSQO+YbF0vOKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753382471; x=1753987271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdGmQQBULDak1afO6wOGgGVbsIT5jshSzS0GzXEZM9Q=;
        b=jV8YjNxJ2NPVwJM2wjAzf0wsSAKObwY3v1qRuZC7i+wSNnQ8kByo56lr4CtKSu3r1J
         //xLVqEO9AWcMqeMGgVyMCfgpERKG7NfriJDiAEYaa0vZRftJz2se154FXh0W1r/s0U9
         RnsM30ZUcmiW8LnH61htaR+YSK1LdczGfptvlUPKunFyjjZR6RZ32m9E5AU72ST8W5ww
         2VC9qwhkTlTY74sY4qhVJPjhyU+o8eyRHQl0ssrdE/d4W37h04BIYniuqjEZlzLQorzJ
         akoicp+6lKzbIclst+ne6KMA8iSJpJdr8qOdZreYjHwIEqJTvnVWGuDsXt8KFPNd0Lhm
         cG7g==
X-Forwarded-Encrypted: i=1; AJvYcCWIngAiBDz03zW+3uQG0MAcQx2FNcG47ECXw/eDEBF8wpJ/hQ1GuMp1clAPR5a3PbkrtIQVv5WW5NO5gh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWhPox8LNgVD/LTbaNNop6Vk9YY+Qz8fuzR+Nks8hc6pcBRVF2
	eAYUDIPYtUEMtOIS3GOzH49ntdIAExpOAHx9lbiT8YycLgebh4Tvy/mp2WS0OR/uhKvAcVV0bOF
	5BtpaWVSbnnIlnU77fqk5gdQggc1q70Ns7yeXY7fW
X-Gm-Gg: ASbGncu6ETV2C66ZmHwmSN+JEOdXeUk7sw8rWxcHLiTvptFn3aXmVCww+UQ5qRec51Y
	DmoB4QOQRsYuT42XAQSTsBmtjaEvTcxwC3KJyVjIfBn0IqtZh8kxoNhf5LSWQOpop9LNYomPst1
	4aDM3Qt+R+iGftMtR5/nNXFqjCmH/BIoofiN/n/2ZBX3p98jrY+EBYsCNJwEWGP+WfZfWl+Nj9w
	SZjVKTv6M/LK449HCExBD8SBP7Rm3QAfXnW
X-Google-Smtp-Source: AGHT+IEoYM1EWKvzwa2CPrTTDfzZ7Ksf2AOfnilQct0N6oYa/w+7054kRqvJaSR7CoWM8egO7TBFq4f8ZqpZ1JK1c6I=
X-Received: by 2002:a05:6870:d2c6:b0:2e9:fd62:9068 with SMTP id
 586e51a60fabf-306c73182d7mr2083260fac.10.1753382470954; Thu, 24 Jul 2025
 11:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com> <f4dda4c4840c69b2ea735bcb6d54ae70d527a48a.1752687069.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <f4dda4c4840c69b2ea735bcb6d54ae70d527a48a.1752687069.git.lorenzo.stoakes@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 24 Jul 2025 11:40:59 -0700
X-Gm-Features: Ac12FXybD_pjPvOBCwcY-hNwuSV51_tRDl2BKwa1m5oQnEMvCGJNkN39CTK8H50
Message-ID: <CABi2SkWgp1M5FWbo8p6_byF+5FzQtcSg3ui0rQ9Mpy6z2_BB5Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] mm/mseal: Simplify and rename VMA gap check
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
> The check_mm_seal() function is doing something general - checking whethe=
r
> a range contains only VMAs (or rather that it does NOT contain any
> unmapped regions).
>
> So rename this function to range_contains_unmapped().
>
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
>  mm/mseal.c | 36 +++++++++++-------------------------
>  1 file changed, 11 insertions(+), 25 deletions(-)
>
> diff --git a/mm/mseal.c b/mm/mseal.c
> index adbcc65e9660..61c07b1369cb 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -37,32 +37,22 @@ static int mseal_fixup(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
>         return ret;
>  }
>
> -/*
> - * Check for do_mseal:
> - * 1> start is part of a valid vma.
> - * 2> end is part of a valid vma.
> - * 3> No gap (unallocated address) between start and end.
> - * 4> map is sealable.
> - */
> -static int check_mm_seal(unsigned long start, unsigned long end)
Is it possible to leave the check_mm_seal() function together with its
header comments? My original reason was to have a contract that
documents the exact entry check for mseal(). That way, no matter how
the code is refactored in the future, as long as the contract remains
true, I won't need to worry about behavior changes for mseal(). This
could be helpful if you move range_contains_unmapped into vma.c in the
future.

Note: "4> map is sealable." can be removed,  which is obsolete, we no
longer use sealable flags.

Thanks and regards,
-Jeff
> +/* Does the [start, end) range contain any unmapped memory? */
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
> @@ -184,14 +174,10 @@ int do_mseal(unsigned long start, size_t len_in, un=
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

