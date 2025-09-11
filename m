Return-Path: <linux-kernel+bounces-812565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52338B539D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835FE1CC23B3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1671435FC27;
	Thu, 11 Sep 2025 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7mfW1A1"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7E435CEBB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610087; cv=none; b=p512ORN+A/QQQhLoVqcORK1amRCnaglXRZNYfiSBLK1gXPwJc3X6eB7wzBR5ITCA50OQMRRu759gVeYqQGpBr41oq3IhuhjcGo8i+VmmkDgXh5lX6kq89kJLnXG2SBCxXm++456wHwkrH35BKiBk+57p2Wsw+ADuuDIw6AJjlWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610087; c=relaxed/simple;
	bh=CqTv1zwEyZyj0+3m0m7flmibVOFx21tD+/Vv/+TsdaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ybc5aKFcA0CvpT3T9cTZMy6i11lMdT/D0jrEjRT2WYQznyEcothTkr9V11FuX3vQ5fpA3S2PvTcCcVdEoCi3vuMOOe3STuvNWPNG15eiXtd6RADxujYG8GXYmmHQ8OnQn64fyaBr1G/CXlj6LsCyk0kyv07xQjVRAacXZLUARMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S7mfW1A1; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b4bcb9638aso29291cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757610085; x=1758214885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6YrfqY/kfgSYj+oS+1XLN+/+rpi+sAaHCEvGJrLudw=;
        b=S7mfW1A1b1mdEDA7ZYJ/Za7o/EixFa9X4NPStV3RU+7+6N7x8goqn3DPc6D4p4IuA0
         73veKhnvcPKMd5L1AkW5Yqs5JZM6KKNBvGldZXbvC3TzLwLnPnsPR00amTq+sX2ZrjBs
         0Bff0l2wSIMwomrFlu+/pa2AP1JGs+dsw9rd67SXoqxRvZe9syluEtedMT3WQuYqXr3w
         8IfckhkdP+f3jbbmp/vnS0yYDJWBKLT9bkj+JE+RG9HDzuZ7DPHGhesAfjve2QSqwhkM
         sLWp3zR8UULPjEWB6uTyqhdwlhV+R3iT3BQ9z7+4hjZaUvnFr9cwdzkBe1UWP1hsWAWd
         liHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757610085; x=1758214885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6YrfqY/kfgSYj+oS+1XLN+/+rpi+sAaHCEvGJrLudw=;
        b=ajKdgge5RRbKoZB7YEZNNI2jpmzmBrJG2kpMk4N11CV0fadTzJeWYu+6eNyF5eXDpu
         4Q5lb9QnuiJfxgGyUHJ0d6FSrBAxQ9mWVeympcmbhT+HailjTZMYAXB5EamDGgj6AZII
         dm9PKl8lwsHMg7+DG9TTc13BIeyXFeMi2lr2sOGgHuBcDu10N0gw6SFlUf/fE7wlhxxd
         o0ZJpNw2UUD4ovYWsHg5sXzlnf9pS9wClU+kYrtWSmH76+GSxE3OrbnDaFtMQ5QfwOk9
         anqOO1uiaoY41671X2CcCCDrcnwWoUYBTYk2uXMpFcDqAHY6tVFAoGlJP1b947v25Hrf
         KTxg==
X-Forwarded-Encrypted: i=1; AJvYcCVLzSb1oZeL9tbT67m/PNiFb+6aDwDO7jKdSZCpHaAzdxDSbTghYsH6ILmYBjKnEr4+96+5WniI9RNPcQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRKOSdCaepCmgJnWQD5Tp4qsnDwWHYLZzGhUsfSxNzKJkmjvL9
	AeOJXv00IEAH0nzQQZ5bSED9zaZtNmNLUem2Qphs5xWbvY+ls9uVJ+gE+BU0l4U6k2cPCebLLTj
	ibIwl5GaOs3rQnc1lu73xhW/3BhXAWKZ1V1xjUsnY
X-Gm-Gg: ASbGncvgJ0KBwvgQSZfp7Zp5TyN4BqkYs8le2aHD52hCNcwsmU04cTxUik+z2lPt5A/
	h5smE2cMakd7TVqxkEF0YQxOFfQd33CHfz3j4R9+ohqDHMEE9uaJTLaIwMLzWMwEb8aQDyji+JO
	aYehhSK5RpgtFDrK2SLS5BSO0z+ng3Y2yDCsriwRABcmTVRusSyp3SgXNce6wqBYhJalMCJgyaH
	gt0NDcGmIiBBQuZtL46A3lTRNEzKWXV9pbDgBXoy4XuZ7qstgCnK04=
X-Google-Smtp-Source: AGHT+IG/kGtpeM1Gey5HXQIudODeDgi5j+h1iwkur2YPNebrI0EBbETji52IST4YryPwZxkruYtTb0YI2mIqsfHjVA0=
X-Received: by 2002:ac8:7f04:0:b0:4b3:509b:8031 with SMTP id
 d75a77b69052e-4b626ecdc80mr13291841cf.13.1757610083966; Thu, 11 Sep 2025
 10:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909233409.1013367-1-surenb@google.com> <20250909233409.1013367-3-surenb@google.com>
 <8c4967ca-a125-458f-9998-6de4f8257dd5@gmail.com>
In-Reply-To: <8c4967ca-a125-458f-9998-6de4f8257dd5@gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Sep 2025 10:01:11 -0700
X-Gm-Features: AS18NWAZbkq8dvCKSAxdNbLr7ujTjPXQQ54Sf8B1FoS7wHGiZNmF7lvVrv9CrLA
Message-ID: <CAJuCfpG3_Rhxg3y08PRivOYJY5CDVdzVg6uakeQ0HXKU1b8dpA@mail.gmail.com>
Subject: Re: [PATCH 2/3] alloc_tag: prevent enabling memory profiling if it
 was shut down
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	shakeel.butt@linux.dev, 00107082@163.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:52=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 10/09/2025 00:34, Suren Baghdasaryan wrote:
> > Memory profiling can be shut down due to reasons like a failure during
> > initialization. When this happens, the user should not be able to
> > re-enable it. Current sysctrl interface does not handle this properly
> > and will allow re-enabling memory profiling. Fix this by checking for
> > this condition during sysctrl write operation.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  lib/alloc_tag.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
>
> Acked-by: Usama Arif <usamaarif642@gmail.com>
>
>
>
> > diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > index 95688c4cba7a..79891528e7b6 100644
> > --- a/lib/alloc_tag.c
> > +++ b/lib/alloc_tag.c
> > @@ -767,6 +767,16 @@ struct page_ext_operations page_alloc_tagging_ops =
=3D {
> >  EXPORT_SYMBOL(page_alloc_tagging_ops);
> >
> >  #ifdef CONFIG_SYSCTL
>
> nit: might be good to add a comment here that we are not using default as=
 we dont want to enable
> it back if it fails once. But not worth a respin as someone can always ch=
eck git log if curious.

Ok, if I respin the series will add it. Thanks!

>
> > +static int proc_mem_profiling_handler(const struct ctl_table *table, i=
nt write,
> > +                                   void *buffer, size_t *lenp, loff_t =
*ppos)
> > +{
> > +     if (!mem_profiling_support && write)
> > +             return -EINVAL;
> > +
> > +     return proc_do_static_key(table, write, buffer, lenp, ppos);
> > +}
> > +
> > +
> >  static struct ctl_table memory_allocation_profiling_sysctls[] =3D {
> >       {
> >               .procname       =3D "mem_profiling",
> > @@ -776,7 +786,7 @@ static struct ctl_table memory_allocation_profiling=
_sysctls[] =3D {
> >  #else
> >               .mode           =3D 0644,
> >  #endif
> > -             .proc_handler   =3D proc_do_static_key,
> > +             .proc_handler   =3D proc_mem_profiling_handler,
> >       },
> >  };
> >
>

