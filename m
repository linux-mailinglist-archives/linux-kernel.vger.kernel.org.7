Return-Path: <linux-kernel+bounces-766834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D98EB24BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F963A9922
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FAD2ECEAC;
	Wed, 13 Aug 2025 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iXmwWUhy"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D7A2ECD31
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755094515; cv=none; b=cVREPmJOJ0HRAfVN92jG5cTWRlD0fQ9WgevGLc54OyDsAbf2b1K5a0fXQaZliXZAhedIdQBA3FaiFoypBmUHUl2+VlptvpdCd83cOfzoafcG7UwwIp7wsjYJMRWWPpfDdrg0aeRQP6T/acQGMDMByuZurMgE3Qsg1HO37YMX43s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755094515; c=relaxed/simple;
	bh=Y1F5y7YMmYTvjcPHi1UHMNHBFgc9htNL1Zkoh9SHKqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/FsWS7Ow/9PCaatjT+CcnPH7Ra5OzXSfulx31Li2MpnWQ7f974YA/4DCE2zsyrlpWDA54D5Nzfrs7INlAKZG5St+73cSCsuiKiXbYuNpMEYgp/tUabpDaxfkj7v1orpn2JyE7sjRV4mld6lEqQAvBkNVHhbD/anbiL5NoUKSW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iXmwWUhy; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-618076fd48bso8966a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755094512; x=1755699312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCdyA5C6sl+D7SKSeD+kNt6VztluFSoqXBmRZjXidnc=;
        b=iXmwWUhyV3DnudeZ01rvDiD/6wUb2hP8M2rL2W0qqFWETxSfr3NHzrTwtX5aUmkPZI
         FA3BGqBKzG5HVoWvn9CU42sEvBnMYwqy1FzxuzRcaGqwHM71mgJNQevnUIehHmGB2X4c
         mUDIJGh7z+o1MNXZ0hgG3Gb8rxrJVssjGUU0Sp6siZj9ID6B9dZ4U+MyX4FjSGUwU6jP
         tXI6wHkwFGtmYGgacw4rjVT/1c3b0ixkVkQb0jHbM/d2kx2SYDrj7BBTX5R9wF/Qskca
         eWHf02BxzAYUqhehgfCV5nYhB3USCunpsfTKWxD/PH3yUq+B8j2gUwnDSUKaR7Amo+bm
         4IPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755094512; x=1755699312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCdyA5C6sl+D7SKSeD+kNt6VztluFSoqXBmRZjXidnc=;
        b=U+GqhmlO999FMgelHxnOhmpk4ZP/8TQpdB/yHHI9FBfXizQ1o5h27Jt2MP0+hDlj1V
         TfiGSASFgj0SrfyFF42w1wTCOc5k/5M4JzTd5TWderHUy4nLOpNP7c+8KXmWsILPu9Er
         v183XihVllEMfsldLD1/6pA8Y4iNj6YkkbnBo13BI5nPfteTRPV8NCN3J/BPM4wIPnuV
         jiInvR5kGu/6/Cqmade2y/t0ryX7zbfBoJ/CMYPsMMiwS4O+NuzpBkKfJdoTb3ecDXBI
         nzOJFuYlOUvZDdCC1qjSkhJin9AGdOcUzQJLmzsdTC0dv6By74TX6I/6b5nNinK9RJoM
         Picw==
X-Forwarded-Encrypted: i=1; AJvYcCUhtIrT0Xd2hV9PDoSCV3yx9hbxB1KZ7ebKDUOVPL6zMrmfoAaiw1MzesP/1L+/hhlPxkTOPuaiEuRaC1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFqdtTFDPB6kDXOuDJ1e9LPBwLF3HWPL4BqH7pM6Nz+RrIqlCx
	q++PCxPsLlLqlYYtVzOpkNOAz3FRViYcIgD8Gb203OcyFlZgBCGt7EXnf+mESuEjpjrSesCLZCZ
	Iys/9asK6pqzyPQvb7yXVDrZbysAJ7LN2ZoRV+uN7
X-Gm-Gg: ASbGncsE5vpOgOeq5DjlMGh+zib6Cdkxgucyovc23iAijYNwA1WreMiMRyE3Pf8YRCZ
	Y2cxvNEEQAZTJ8K2UxTYBf0gOa4vGFRR1LaaCFAix2Xd5f1qr/Xb9Z7epfbQsQqyCW9a8CuOIi4
	ocfSjgOOmQ9nkbbf16runjLbqSmmZwlf09GHLfvfnJdhJaT47cF00tB6E/CEv2TftQ7CCespTli
	r6zcUNSQPIWvx8RDHTLZWKp6DAt9qDvepBj7erj46Xh9wOMQiM=
X-Google-Smtp-Source: AGHT+IGrHXsjBerb6H4iA2/G9f9W9aXY6fFEQY+IlMLrfnIuvzCCyHxV/OD1sC5gfrO8L1dGijqw2XDpP7IbxWdLy7g=
X-Received: by 2002:a05:6402:1f4f:b0:617:b4c9:4f90 with SMTP id
 4fb4d7f45d1cf-6186d54e613mr95378a12.5.1755094511897; Wed, 13 Aug 2025
 07:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810062912.1096815-1-lokeshgidra@google.com>
 <CAGsJ_4wbXkfaAn+79g20SfE-0Ak4QACVP+Mw2vAvMnxBCcLAsQ@mail.gmail.com>
 <CA+EESO4JFCR5P9PFoY2zo+X1Y-qv+-yy8X887isoqXwfQBtn1Q@mail.gmail.com> <CAGsJ_4zK5iLtYaT2o6ctnZNUgRoxrxkDJ4gnGrTOD7CW5vuRHw@mail.gmail.com>
In-Reply-To: <CAGsJ_4zK5iLtYaT2o6ctnZNUgRoxrxkDJ4gnGrTOD7CW5vuRHw@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Wed, 13 Aug 2025 07:15:00 -0700
X-Gm-Features: Ac12FXwcVcIIOY2FQk5ryN01K33bglvd-HUWD6CVhaDAZn5gaMfb8TIOumWEKEI
Message-ID: <CA+EESO5ny0L8qiB6_b8t9guCVj6+ygjKf5+x6bR2aXjEcJE5Rg@mail.gmail.com>
Subject: Re: [PATCH v4] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 2:29=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Aug 12, 2025 at 11:50=E2=80=AFPM Lokesh Gidra <lokeshgidra@google=
.com> wrote:
>
> > > [...]
> > >
> > > >         /*
> > > > @@ -1257,7 +1327,7 @@ static int move_pages_pte(struct mm_struct *m=
m, pmd_t *dst_pmd, pmd_t *src_pmd,
> > > >                 if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES))
> > > >                         err =3D -ENOENT;
> > > >                 else /* nothing to do to move a hole */
> > > > -                       err =3D 0;
> > > > +                       err =3D PAGE_SIZE;
> > >
> > > To be honest, I find `err =3D PAGE_SIZE` quite odd :-) Could we refin=
e the
> > > code to make it more readable?
> > >
> > Agreed! I'll replace 'err' with 'ret' as the function no longer only
> > returns error but also bytes-moved if there is no error.
> >
>
> Looks good. Should we also include the following?
>
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1246,6 +1246,7 @@ static int move_zeropage_pte(struct mm_struct *mm,
>  /*
>   * The mmap_lock for reading is held by the caller. Just move the page(s=
)
>   * from src_pmd to dst_pmd if possible, and return number of bytes moved=
.
> + * On failure, an error code is returned instead
>   */
>  static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd,
> pmd_t *src_pmd,
>                             struct vm_area_struct *dst_vma,
>
>
Of course. I'll add this.
> > > [...]
> > >
> > > > @@ -1857,10 +1930,13 @@ ssize_t move_pages(struct userfaultfd_ctx *=
ctx, unsigned long dst_start,
> > > >                                 break;
> > > >                         }
> > > >
> > > > -                       err =3D move_pages_pte(mm, dst_pmd, src_pmd=
,
> > > > -                                            dst_vma, src_vma,
> > > > -                                            dst_addr, src_addr, mo=
de);
> > > > -                       step_size =3D PAGE_SIZE;
> > > > +                       ret =3D move_pages_ptes(mm, dst_pmd, src_pm=
d,
> > > > +                                             dst_vma, src_vma, dst=
_addr,
> > > > +                                             src_addr, src_end - s=
rc_addr, mode);
> > > > +                       if (ret < 0)
> > > > +                               err =3D ret;
> > > > +                       else
> > > > +                               step_size =3D ret;
> > >
> > > also looks a bit strange :-)
> >
> > Any suggestions on how to improve this? 'step_size' is expected to be
> > different in each iteration of the loop even without this patch.
>
> Usually, we have:
>
> if (ret < 0) {
>     goto or break things;
> }
> step_size =3D ret;
>
> Given the context, it does seem quite tricky to handle. I=E2=80=99m not s=
ure,
> so maybe your code is fine. :-)

Yeah, the special handling for -EAGAIN warrants the current
implementation. I'll keep it as is then.

Thanks
>
> > >
> > > >                 }
> > > >
> > > >                 cond_resched();
> > > >
> > > > base-commit: 561c80369df0733ba0574882a1635287b20f9de2
> > > > --
> > > > 2.50.1.703.g449372360f-goog
>
> Thanks
> Barry

