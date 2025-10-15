Return-Path: <linux-kernel+bounces-855112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F48ABE0429
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31612188972E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1552FF667;
	Wed, 15 Oct 2025 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IkmAozM0"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D5630147D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554254; cv=none; b=K5IRDtcYGpo6s21lw0cn3ovuDF9+xMLmcNad2FdaVJM7de0o51f28PsOO3fnOXiSOF1xUmPXy7GdgtFZ0GXaJM8SOiBnO7OH9OJZDyFk3SIHGfS9Z+GVTYgE2B59Z3hh5bg7/yXuuCF7Dbk46Oy2yEjX62lRonXmmGAkD7DIa3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554254; c=relaxed/simple;
	bh=nza7NoVd37hs/+7qcBuUcq7vkmbwoooaC8RpgvQTYEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jb2FenhyWIdTzNXBuiNlik9ji3FsG7HZv6CAp64BWkSVsA33C3UDdA4O8Rf5yNs0FhBrE3EVim2Agd2C2trgNQjEu5u5IZkgKCLBEHhZKJuRPBVNU9RGZffz0jduI7PBv59DPAxuvRFoj/khyG2clQ5x4TKUfd78vXnona97mRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IkmAozM0; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-42f8e736ecaso97195ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760554251; x=1761159051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYCQTmcwAOXbAVYyQVpb75US8clqghkkSeMpq0zlPIY=;
        b=IkmAozM0yqzkzCk0Y60eB9MzxlGe9VIKJXrMYNqR0LFhgCvlxLph6ZC+e5O5oO+DaT
         T87SVix6nBSpt9XFaOnUu1r2JM1p4XFXGytvq2KYEAGiCj8XtXY0tFopxG3SHY0Nn7rj
         v7nTMwOGCGuotCBev6UkI2nqk2RWz9FXlU/ADIZQRiLHm2rvfINMCldKn0CGPpzLErZ/
         E6PkD7aKq0+7ToAB1CldLv3prFDX9ZkGGwBmFxhsGWcPwhJfLBXElmJc3cCIoSpvAZ4G
         JwgHvr9fcH1JIqTUuLFAC+g4e336fKYfYWDCkYn6ALwtHMd4QJOYPUUoMPGIurZTr9ub
         Vphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760554252; x=1761159052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYCQTmcwAOXbAVYyQVpb75US8clqghkkSeMpq0zlPIY=;
        b=tLfJjh6IqFT+L/5WwlXLm/a4c3CMifD6BM6R8K1m24tnQBkRghfCx+QcnCQcGFiSjA
         2b0zAY0RArI61gLQVQJGUCdfgDnfZ0cr+NOsgLqSn7mdZLFsiL8k4uOMmWVaLW+oz4OX
         xGj879mxGJ98wQPGmZ1PKFrXCRK0p3+qFpdFMQZY5hGB0YnU9nyje6FZ+RJ+hxxz654J
         L/R5BFwFE6qMxsoLtdPY7VpfTS1h9WpmHUGsJvkzKl3kP6DzqIEGPUDIcqtOQXVyBeml
         RaFjQ+08nkrqXPXocULI30EsRjouPR5CtIrSQpZrle9ldA2jJQ93tonFfKImoRqGqAVc
         lAQw==
X-Forwarded-Encrypted: i=1; AJvYcCWg+pNFuXs0c0wrokcu5H7IWsjF/3M7ZvDDsvdcgW1iGQQ1Xw4Ly6BpA/kbKKdw08T0qQ8UaANf7kX8W/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeAzIaSlBr2HN6M0RNJJ9ESvHmt0Ai7upc5HU1ODQGXv4ocAkL
	7Z7FvEf77Nld+Yv63mIi4hyyzHFJdFFCsOIFgDYHdIPbs1OkTqkoqrTTYWPWqB4nLj54GEK0KRp
	h8VWQl+hvOIQSa3LxSW9sgDeUL4ppDp5gNeogbzdo
X-Gm-Gg: ASbGnct6/hykCCbMIn2KMk+kOYuNFl80m43Ns8bGWDn8vU4Xj85Z6Zp8v3qNtzGRRR9
	enpNH1sIYKJ+3y54yYoZykf8j0nlck3vO94qD1EnP+wv9RNWbj6WpVwIsiZgFPl4rKfwXlCZbxz
	CjFAJXflKUUjbkoAPFVX1y6/5puZ8JDD2Nb0Dnxspy6TRoHygHR9AjiyQigvOzK7muv1xRakiH+
	7bdvGZPt8QKH6ZnraFGD05Aao5Gb5NF7zDyY9aptMX4Kflu1l4f4EV/ItJ5+Jc=
X-Google-Smtp-Source: AGHT+IFhtYvLnXNUH8ojZN5pHVMGppEJ3dHRLngpUPsGt/2HbLQnvaa6Up8QbYh+CMCi32sdwQK+DoIp2AwmDxVZeG4=
X-Received: by 2002:a05:622a:4c05:b0:4b7:94d7:8b4c with SMTP id
 d75a77b69052e-4e882c9e0e3mr8734281cf.0.1760554250891; Wed, 15 Oct 2025
 11:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015145143.3001503-1-joshua.hahnjy@gmail.com> <421c7c42-bf7d-4277-b364-525c63254205@suse.cz>
In-Reply-To: <421c7c42-bf7d-4277-b364-525c63254205@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 15 Oct 2025 11:50:38 -0700
X-Gm-Features: AS18NWCIA6Box0YKS8r3evI7XRw-ZheLidTmF5dXIWqHzjDgYO5Jm_gzVDaEftw
Message-ID: <CAJuCfpHDr95JnAkK_KzTU+VMLnHAuDVkFjPn4XnG4KpLtqEGLw@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: simplify and cleanup pcp locking
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 9:08=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/15/25 16:51, Joshua Hahn wrote:
> > On Wed, 15 Oct 2025 11:36:09 +0200 Vlastimil Babka <vbabka@suse.cz> wro=
te:
> >
> >> The pcp locking relies on pcp_spin_trylock() which has to be used
> >> together with pcp_trylock_prepare()/pcp_trylock_finish() to work
> >> properly on !SMP !RT configs. This is tedious and error-prone.
> >>
> >> We can remove pcp_spin_lock() and underlying pcpu_spin_lock() because =
we
> >> don't use it. Afterwards pcpu_spin_unlock() is only used together with
> >> pcp_spin_trylock(). Therefore we can add the UP_flags parameter to the=
m
> >> and handle pcp_trylock_prepare()/finish() within them.
> >>
> >> Additionally for the configs where pcp_trylock_prepare() is a no-op (S=
MP
> >> || RT) make it pass &UP_flags to a no-op inline function. This ensures
> >> typechecking and makes the local variable "used" so we can remove the
> >> __maybe_unused attributes.
> >>
> >> In my compile testing, bloat-o-meter reported no change on SMP config,
> >> so the compiler is capable of optimizing away the no-ops same as befor=
e,
> >> and we have simplified the code using pcp_spin_trylock().
> >>
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >
> > Hello Vlastimil, I hope you are doing well!
> >
> > Thank you for this patch. This is a pattern that I found quite cumberso=
me,
> > so this patch really makes the code so much easier to understand and re=
ad.
>
> Hi, that's good to hear!
> >> ---
> >> based on mm-new
> >> ---
> >>  mm/page_alloc.c | 99 +++++++++++++++++++++++-------------------------=
---------
> >>  1 file changed, 40 insertions(+), 59 deletions(-)
> >>
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> index 0155a66d7367..2bf707f92d83 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -99,9 +99,12 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
> >>  /*
> >>   * On SMP, spin_trylock is sufficient protection.
> >>   * On PREEMPT_RT, spin_trylock is equivalent on both SMP and UP.
> >> + * Pass flags to a no-op inline function to typecheck and silence the=
 unused
> >> + * variable warning.
> >>   */
> >> -#define pcp_trylock_prepare(flags)  do { } while (0)
> >> -#define pcp_trylock_finish(flag)    do { } while (0)
> >> +static inline void __pcp_trylock_prepare(unsigned long *flags) { }
> >> +#define pcp_trylock_prepare(flags) __pcp_trylock_prepare(&(flags))
> >> +#define pcp_trylock_finish(flags)   do { } while (0)
> >>  #else
> >
> > I have one question here. I was a bit unsure why we do the typechecking=
 and
> > silencing for the unused variable warning for only pcp_trylock_prepare,=
 but
> > not for pcp_trylock_finish. Is it because pcp_trylock_finish will alway=
s
> > be called after pcp_trylock_prepare, so the flag will have been used at
> > that point?
>
> Exactly.
>
> > I was concerned that there would have been some area where only
> > pcp_trylock_finish would have been used, but compiling with W=3D1 seems=
 to show
> > no errors on my end : -) So it looks good to me! Feel free to add:
>
> Yeah we can change that if ever we end up with some code that needs it
> (hopefully not).
>
> > Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Very nice!

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> Thanks!
>
> > Thank you! I hope you have a great day!
> > Joshua
>

