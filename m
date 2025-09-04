Return-Path: <linux-kernel+bounces-801243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A12B44291
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2129F1C82967
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7636F21E0BA;
	Thu,  4 Sep 2025 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PoDvkClK"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB7F222593
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002849; cv=none; b=g70rK+5X7FPqrB5o+0FBm2oqiuEUL0qxoSPM8eFn9XsSOZvOCzuDHAPn1YC//jTHmjGLJbWr32iADD6/jFdIBnONmrqBmXaarMv8GCHWdE2kZR0EYkyy6ovVioXNhGsulAk0dYeyQez+XRdAP7uYp2luSviCKFntqAr+wmk9tcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002849; c=relaxed/simple;
	bh=V+jqaTDYjgK5DoB5r7uYu0OVPQZDPcU1l52CP+ln41A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inklt3cU7rZb/gJZoNtP9P11aQtRe5AZsECs/kH+wz/aNrVaupM2TtgUDsaX8TYwFAb6gMmmayuzcx6Fh/9OHzWAa3+tNVv/04o3LpaY4J0LGMJP4jUFEw6FWgjWoi1vM+K9/TlvsvJr+KKe45ok0mk5RO/mvIr3t7Pv8nfsyGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PoDvkClK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24ab15b6f09so208355ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757002846; x=1757607646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0t6bhmQA22wX44ktbmUqj5cgU/my1Kdps55OJZMqkk=;
        b=PoDvkClKDB03l7asDiRpyZav2hQp6dWhzjWcOD+CZDCHOwslcjfRZEkXKS2VKoFZYa
         bXN4dzTH3EdCu5CXMvBBWbwouWFE22AXwl30eZhO+eCNSjrkmo/1XG9eEzgRBssoJn61
         5k5TL6OqNAGwX8uHRcbLbCgt0cGxzB8e/KCmXCp78cGJKQyxLeK81LqyW+6PNu93duU/
         x5u1TCiA6WuYy8LEp5Sa2oKd0oDknrBD+hEEyRB6L28ASJeP8W8NYXNaQDduVWizjqxG
         /yRFAEz6Z0bLcO9C5/Ouiuwybj+fKGBE7QznFodLJURAH8s58o+i4TspqByuDwmcWEZG
         EGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757002846; x=1757607646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0t6bhmQA22wX44ktbmUqj5cgU/my1Kdps55OJZMqkk=;
        b=ctHUL2jOlWHEABBEy7yktMPVRZqwDtZFRIkT7bT/Jqp+3415szFgSE+sNvYvVlZ7A2
         88xPSb4bWbpuwG0bQF/Ci4PAxYV0F41nG3ZK5LY2t+T4GP6LomuS7twosB2R14vrJIaZ
         zvoRBKGAdtzKw9mLTPv6Saleih50cyUnhAA3B+BIRhvwvKYF6iLXrZ1FKPFlb/+li2tB
         wWtSKA+hT02v0U4b7iVJndMDXx5yrPjrCjMWdTifg6p854U6gulp2jxNtAMchRHhnyj+
         0Odi4y9FgnAu81BumGXUbnve966+pmqcpr6cHp454AC65k910ZYPwY3WVTRjYYIjbpva
         3Q6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEPWx5AupvZ0k3bw2o/7/lE+xNJt03eNWZlt4T+fUrRut5LXSS+VziU1hr2ZcePiLj9VlbwahvDa7xuAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzamOlOBOpCRqK+P5BYxAvMOQGU0KVogrVxj3I8Cm277ZjNWLfa
	YeRbdDAWKK6lZo/2pyiDgt8vAwx5r4eiRcoHiElhWP+kDfpjb1SQz3WIVi9w/huWGpOCTz0z5Oi
	RZBM+sgcmeixk8tkBtreMC9MaZhuJP9SaYzuwpKs4
X-Gm-Gg: ASbGncufcfSadx6rq6DEnmC4kKK42a00R3fpvtB4e9+NKEpR1muKXAqFyqERfP9hVYn
	/pe0Gl+aMUVksidYohqTucI0YvoEtjiV/bj/kf7zUCkmUWcQH0dNOZ8I6mX/ZZztQEIZi4QKwXr
	7ywgQmKNhp1lS6eqfkjqSYShzow0TR+WDi7EvqcbEOt+0lQ71lWttcU0JJCn1XpUyrqszdsWS/j
	XL+6pnfC/jrxeqchFnl+goR2mXvOTorTFgx2TJUOjhaCh5wm5t9A4MJuLglYaVLpw==
X-Google-Smtp-Source: AGHT+IHThq6GwO2/qHwlSP0iRWoql/gtSI+KBd6TV5CKErad41aW7prfJ1BHV/t4PpXi6b9rJmJsWOcxBCxqXuBOLZg=
X-Received: by 2002:a17:902:ecd0:b0:249:2f1e:5d0c with SMTP id
 d9443c01a7336-24ccccc4c7amr2934785ad.7.1757002846099; Thu, 04 Sep 2025
 09:20:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903232437.1454293-1-kaleshsingh@google.com> <aLk_zbXxYxHs1Igk@kernel.org>
In-Reply-To: <aLk_zbXxYxHs1Igk@kernel.org>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Thu, 4 Sep 2025 09:20:34 -0700
X-Gm-Features: Ac12FXwM78mo5ZQ5cUxcmH3ulwLdG7jBYopJRFbNNqJcd7ybiS1glWTpedGl5Rg
Message-ID: <CAC_TJvciKbEOyBv_V01s8nJF8MMKznKq-Gw6+Shv9AAppJ46+w@mail.gmail.com>
Subject: Re: [PATCH] mm: centralize and fix max map count limit checking
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	kernel-team@android.com, android-mm@google.com, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 12:29=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Wed, Sep 03, 2025 at 04:24:35PM -0700, Kalesh Singh wrote:
> > The check against the max map count (sysctl_max_map_count) was
> > open-coded in several places. This led to inconsistent enforcement
> > and subtle bugs where the limit could be exceeded.
> >
> > For example, some paths would check map_count > sysctl_max_map_count
> > before allocating a new VMA and incrementing the count, allowing the
> > process to reach sysctl_max_map_count + 1:
> >
> >     int do_brk_flags(...)
> >     {
> >         if (mm->map_count > sysctl_max_map_count)
> >             return -ENOMEM;
> >
> >         /* We can get here with mm->map_count =3D=3D sysctl_max_map_cou=
nt */
> >
> >         vma =3D vm_area_alloc(mm);
> >         ...
> >         mm->map_count++   /* We've now exceeded the threshold. */
> >     }
> >
> > To fix this and unify the logic, introduce a new function,
> > exceeds_max_map_count(), to consolidate the check. All open-coded
> > checks are replaced with calls to this new function, ensuring the
> > limit is applied uniformly and correctly.
> >
> > To improve encapsulation, sysctl_max_map_count is now static to
> > mm/mmap.c. The new helper also adds a rate-limited warning to make
> > debugging applications that exhaust their VMA limit easier.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  include/linux/mm.h | 11 ++++++++++-
> >  mm/mmap.c          | 15 ++++++++++++++-
> >  mm/mremap.c        |  7 ++++---
> >  mm/nommu.c         |  2 +-
> >  mm/util.c          |  1 -
> >  mm/vma.c           |  6 +++---
> >  6 files changed, 32 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 1ae97a0b8ec7..d4e64e6a9814 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -192,7 +192,16 @@ static inline void __mm_zero_struct_page(struct pa=
ge *page)
> >  #define MAPCOUNT_ELF_CORE_MARGIN     (5)
> >  #define DEFAULT_MAX_MAP_COUNT        (USHRT_MAX - MAPCOUNT_ELF_CORE_MA=
RGIN)
> >
> > -extern int sysctl_max_map_count;
> > +/**
> > + * exceeds_max_map_count - check if a VMA operation would exceed max_m=
ap_count
> > + * @mm: The memory descriptor for the process.
> > + * @new_vmas: The number of new VMAs the operation will create.
> > + *
> > + * Returns true if the operation would cause the number of VMAs to exc=
eed
> > + * the sysctl_max_map_count limit, false otherwise. A rate-limited war=
ning
> > + * is logged if the limit is exceeded.
>
> kernel-doc will be unhappy because of missing Return: description. Please
> s/Returns/Return:/

Hi Mike, thanks for catching this. I'll fix it in the next version.

-- Kalesh

>
> > + */
> > +extern bool exceeds_max_map_count(struct mm_struct *mm, unsigned int n=
ew_vmas);
>
> No need for 'extern' here. And the declaration should go to mm/internal.h
>
> >  extern unsigned long sysctl_user_reserve_kbytes;
> >  extern unsigned long sysctl_admin_reserve_kbytes;
>
> --
> Sincerely yours,
> Mike.

