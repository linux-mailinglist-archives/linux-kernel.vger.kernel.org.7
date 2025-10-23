Return-Path: <linux-kernel+bounces-866244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E89ABFF49C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C3B74EEDF3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8439A23AE9A;
	Thu, 23 Oct 2025 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hpv5Tswr"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D851DF252
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199086; cv=none; b=lxvs24AOUZ6sLN772s69jGJet3ivWsB2iYnfrQCvtcBB/E05sGviUDVarxXp1TUl9HWVS/Fg6yzNjTczxmLPMd36uhNy72m9ZDecx0/gEVuEOHjqpsxCFFP1se1wuXGYT1KMdwLwM+fRUMCcbRu3TOTimNinnv9a0vMvgOq0Hfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199086; c=relaxed/simple;
	bh=7VdE+T5JvEjyRxHDFVuvpipqpakTLilpPltYb4d6WAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FO6B5oWaRoNkuJG0v0k4U/8qZKa+YN7+7i+v1yTYAfdKScAr+UuUYi2pyWTHj1YjwPlQEWsQMOvuwXpBGj6e3JCP42w5MLyAwiJjUzLIk5c1bzWEvRHkYap3WpYp7QFkj4oroYgTZwZ8xK2RxRXC9+DWQyVF6wJ7IvGwN/Jt2Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hpv5Tswr; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b472842981fso58061666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761199082; x=1761803882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqT3fmbl/NyFgzc1chkjaxa8Hzi6O3hC82OBdEi+dws=;
        b=Hpv5Tswr07+6oFtdT0GtAgpBRFteYM8bhLd929TAfjNjwQNsP/5skO1qn47PfMJqku
         QfiWAEAP9qBPVgWDtoq1hVkViGDUjBGFifSY6KG3ihQMDow0/XRK5WIwysXDFYHRHldV
         SNehzupnhCtztcCnJq2Nf8cw8TobNwQqfDHeS/2v7yrJZ/NriEd9UL3TmxF1mHr8CN+h
         IH8s6tvukQpZ6126Q1b843ubHNAnjTd3WwrW5YvapNfiqy4Yb6wV2lvyRWdyCACCBop3
         VDj4LSlrBWp23b+L3vZcTP5xUEyplRD5Wv4NeFmqdEtv195/pvB7aJAZiXWN8cEn9SiC
         7jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761199082; x=1761803882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqT3fmbl/NyFgzc1chkjaxa8Hzi6O3hC82OBdEi+dws=;
        b=C/NscwpR7ufCbmhngvRkODvSCtLsSHxCMG9q5gl5LTrbN8avPPwxCIGWlgO7VFrBdU
         UM+IyIy8551heF+OInHRAU2zDBlR9ABq+fezyT+zn8ldMLZeHrRHdMyj7w9us572Xj2I
         cY21DKle2VSziHgRlmEWlB33572ap5AwVrmDdTltKwHRTkGuqlI1PJro77Vu0qPS7RO6
         zcXTs70E//X2lWASJlf+vrCWZDrvtyuX9MSzuGx8mWMoAfILHdB2QaLtT0hpcA6w38qz
         YPrep/eaU+n+dLr9EvWHJrwsiC0jatkvqUQC302QOqQGHscbx66KWYfMp9judFWpcHbW
         J5EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC6/rxN9MJX63zZlz4ehjueAkuK9AF1IZ1Tg8F4D5Htk3gURd1nQH30kOSvmQ1RJ2uqMaUQZlehTrm+Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzV+OCv4GmhhzJcu4A4nHNtQ6JPa3SvOu5cdJdaewb96AxGZGR
	1b674Tphq9lgVjWcSazes613vJoqayMOAOCMb5q5F+KEIWIkCkwQKDXLmckRWjZeIX4otwa3AxU
	ZR7dWqVYZdgE3pL4G8pYmq/UFjFae6Xo=
X-Gm-Gg: ASbGncur4xPkjvnGgjigc1mekmHcSs9WMg6c82llTd695E9sO07uiufkAtGy3ulZGwB
	y5oXbfUSeNq9ZCzaS3mSiEk0ErF4L8Ia6USXCe6OyU+S3PfFibkqHHbubSE72O5LQKZXp1eu03P
	5r0Z0jA/WPt9GdAwqUCT0a1i3UsxNHgPUKiuRdAwFNBmY4hNXhBkk4QVYfwqX6+1G5Mcv2v9aON
	KpC2cyyUmIBvqUYmbU4a2Yz7MJmkr9hzTjqexnNrd7NA/XwByFb2mE5bFvn
X-Google-Smtp-Source: AGHT+IHEgrhoMFz9wAJKmZGqrPoGLd0Yc4jrCJX0a9ZPmSZc59sboKW2LRJQWOCdJd5RmikbQ3D38I9zHdHcXkeQpug=
X-Received: by 2002:a17:907:3f12:b0:b6d:5718:d43f with SMTP id
 a640c23a62f3a-b6d5718d7b1mr65656366b.39.1761199082291; Wed, 22 Oct 2025
 22:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022105719.18321-1-ryncsn@gmail.com> <CAGsJ_4zKcxO-Tacy0jCZSs83+fGsgqQYNib9nCXoLTuL+hdLxQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zKcxO-Tacy0jCZSs83+fGsgqQYNib9nCXoLTuL+hdLxQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 23 Oct 2025 13:57:24 +0800
X-Gm-Features: AWmQ_bkGCKMn-MW625Ff-LLLuPlBu8nKTWVvjEa-19moLgG3QM5ri2QsiZJtA4k
Message-ID: <CAMgjq7CdQK_k_oGfOwCtMm18uAXrGwfwUz93pt7kaN-S64G0Cg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/shmem: fix THP allocation and fallback loop
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, 
	Dev Jain <dev.jain@arm.com>, David Hildenbrand <david@redhat.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Mariano Pache <npache@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 1:51=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index b50ce7dbc84a..7559773ebb30 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1895,10 +1895,11 @@ static struct folio *shmem_alloc_and_add_folio(=
struct vm_fault *vmf,
> >                 order =3D highest_order(suitable_orders);
> >                 while (suitable_orders) {
> >                         pages =3D 1UL << order;
> > -                       index =3D round_down(index, pages);
> > -                       folio =3D shmem_alloc_folio(gfp, order, info, i=
ndex);
> > -                       if (folio)
> > +                       folio =3D shmem_alloc_folio(gfp, order, info, r=
ound_down(index, pages));
> > +                       if (folio) {
> > +                               index =3D round_down(index, pages);
> >                                 goto allocated;
> > +                       }
>
> Could this be a temporary variable to store round_down(index, pages)?

Right we can do that, but the generated code should be the same, the
compiler is smart enough, I just checked the generated code with gcc /
clang.

Do you think the code will be cleaner with a temporary variable? I can
send a V3 if anyone suggests, it's really a trivial change.

