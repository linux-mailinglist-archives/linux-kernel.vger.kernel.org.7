Return-Path: <linux-kernel+bounces-821350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DA1B81090
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22AB66206A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F19C2F9DB2;
	Wed, 17 Sep 2025 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UQnhgblb"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA02F6167
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126788; cv=none; b=D5TM3Sg9Pvb0AxjXOJhEBHeN3H0PK8ZJJ8TkuyMlfVHFRoYNquX0oQ6+4rAXIzZsuz3cDyOfya2zhZdAp/lB77IU7Hv1XSBRiLbxVfPZTdghLl6L7lD+NvikfgZZqKt/zKDgmbzgnLg+uaNKWHMaXQtVIvR+LhbrEmGXewosx6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126788; c=relaxed/simple;
	bh=uO4D3OsHhD90QlcbzxGhQOKy7Tak90Wh75VxpzKH3po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUYH8RWbONGz4TSterpVm9eoDfPFzpVAl4wHpKy2jACWeIQmCxuxomqoZbheqN+xjwynrz2/MHdqRH7vI/6TEj2uVa2cVmdzMF/S4UYmb4DBU1dB8rogQygiwTC4s2ySEH1CjQ8DHuUWENQn8QGL7zJqyJ2rCP7+wqb7qrPsX1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UQnhgblb; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b78657a35aso2671cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758126786; x=1758731586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uds75xiPQny3nAcn7jJTv3KO0Ae24HOX9EQMMOudzFA=;
        b=UQnhgblbGbuY2zK4SsZhNSBfJtYx/HOEU5rUPRI2pl8IkfUkyEY3aJYWe6VLQ3pJ5b
         kW/j+mZ5Gvi6SM2+kZGGeKfwcW2EzKg9AZgUpDWuP1YyZYFRo+xMi7s0RkdLjFkn0kKj
         jIhYpph16RRc3ilFJcjKF+1kEGsZSXKUPpe3EtLM3q1rH81vrc8wuR7q+JyeQqO2qd+i
         Sbf9QqYG6+TdjlZBlBIoZOq3+8RQ9ZqHZjl3SWHpmPVG0zJQBtbaFE0Y8bHth9otVHxN
         S0P/zAgUCvCB+iwIKJs3Lq+n4axSa2Q+te1y4qZVZF6rZ7AA/rPUcSE5asHyGYogttJ3
         5vcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758126786; x=1758731586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uds75xiPQny3nAcn7jJTv3KO0Ae24HOX9EQMMOudzFA=;
        b=edmtOLzotFWq6F7iyCtNgPrhslwZGZJiEBKCXNa+cU0mlHogH/MxF1IZSAEepA3wS1
         MunAM/q4rggWuP/xoHpVUL0xZQJ9dsEMm1ig7H80SDj5moSKgv6EF1+nxoGcz2sE+6pP
         fGTh4p9v1A9mgjn224qftKmQuz29pc8piA0ojlHt/C7isXcMtgF1E8MatvD/grZHXrl/
         W8JWsT0DMah8WY+6YqVh/88KCIamyMZioSLrhWd1zXQJ/alZyOCNc/FwvnyMTTrLHUke
         mBTw8lqephSuVsinHx2zciUt+0XU43LVce/sTLcpDxoBd6/axZ3dlHlzeSWlIEUX51AJ
         oZMg==
X-Forwarded-Encrypted: i=1; AJvYcCVc6KpaSvquv4amD8hUf7nWRfmV6dZuNyL+YTQTAFifl1b01vBFYM2PcL1vcO+AJ0cL3Mc+uI3wbu0jQf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynaILDEq8wp7JZ5UJyGwBvVg1qVOD/Qp3Ukh/BJIkG+AE82RBl
	+ocoX0VtQhQXxNNDrnVJBhM93liYiGCsJXMkWrH3mFaVadyGaCNx56onXr3fXNFgot1FfHkp+yf
	v6i6yJqxMYRtJ4v5R5MkBdMOcglvW0LtMCFyx9AU0
X-Gm-Gg: ASbGncsFg3enJK11RRUPOwf1q36enSdA4SbdL4f1ZMIb3seUGO+V2Gnbk7VIovKoX1M
	8atwuMJSv7L8ExFJ7zdRU+11CGp6XV4YUmyPGIr2/YNrHabMGD5x1DNcYfZ8I84FJI/oLqayKeC
	CiO991NMxt+uXet8VPoHdhpLuXsqUc7zJtMr4JHH5wwarrRA7aaUIrT9lL09aB++eRT47Z2/LXO
	6CIwUkJdkgrOOk8WOh4Uep0fbz3aqcZXUfi7wV+9qFW6XPMbrAGIA==
X-Google-Smtp-Source: AGHT+IHDjYAKo/HFz5Lqx+uYGIvXkMzMumPFbP+PJq+LX0ziWtVuf25KfO3VwGwrXMhchX1uBRVF5QDn8lX/sUTDngI=
X-Received: by 2002:ac8:7e88:0:b0:4b3:4ed0:c6f6 with SMTP id
 d75a77b69052e-4bc3ee35e34mr2199501cf.16.1758126784926; Wed, 17 Sep 2025
 09:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-mm-rcuwait-v1-1-39a3beea6ec3@linutronix.de>
 <CAJuCfpE-DPBp-0b0908FHvguSo_PqxE2LdUXvBiMLu1UCd5icQ@mail.gmail.com> <20250917080725-14901c66-b02d-4d81-8a42-1283333d3966@linutronix.de>
In-Reply-To: <20250917080725-14901c66-b02d-4d81-8a42-1283333d3966@linutronix.de>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Sep 2025 09:32:53 -0700
X-Gm-Features: AS18NWAA3QcuAor9q7Hcth6_vAR8M3SPhjnhyadOvVoWh3vDXkpc8r3e4zubaX4
Message-ID: <CAJuCfpGAJgfP6P4907RPeJmtfaEd9Z1tFxyDOvrEz22DiGqHeg@mail.gmail.com>
Subject: Re: [PATCH] mm: forward declare struct rcuwait together with rcuwait_wake_up()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 11:12=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Tue, Sep 16, 2025 at 03:04:21PM -0700, Suren Baghdasaryan wrote:
> > On Tue, Sep 16, 2025 at 6:59=E2=80=AFAM Thomas Wei=C3=9Fschuh
> > <thomas.weissschuh@linutronix.de> wrote:
> > >
> > > At the point of the forward declaration of rcuwait_wake_up()
> > > in mmap_lock.h 'struct rcuwait' may have not yet been declared,
> > > leading to compiler errors.
> > >
> > > Add an explicit forward declaration for the struct.
> > >
> > > Fixes: 75404e07663b ("mm: move mmap/vma locking logic into specific f=
iles")
> > > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de=
>
> > > ---
> > > This doesn't seem to break any in-tree code right now.
> > > I stumbled upon it while building a series for the next cycle.
> > > Instead of putting this fix into my series and spamming all the mm
> > > maintainers with it, maybe this could be part of the last mm bugfix p=
ull
> > > for this cycle.
> >
> > `struct rcuwait` is defined inside include/linux/types.h and
> > mmap_lock.h includes that file.
>
> Yes, linux/types.h is included, but only after the usage of 'struct rcuwa=
it'.
> We could also order around the '#include <linux/types.h>' before the
> declaration of rcuwait_wake_up(), but to me my current proposal looks cle=
aner.
>
> > Could you please explain in more
> > detail what exactly failed when you were building it?
>
> With the following change for test purposes:
>
> diff --git a/init/main.c b/init/main.c
> index 0d4510a7a5c2..7523786e6ad1 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -10,6 +10,8 @@
>   *  Simplified starting of init:  Michael A. Griffith <grif@acm.org>
>   */
>
> +#include <linux/mmap_lock.h>
> +
>  #define DEBUG          /* Enable initcall_debug */
>
>  #include <linux/types.h>
>
>
> This is the error:
>
> In file included from .../init/main.c:13:
> .../include/linux/mmap_lock.h:6:35: error: 'struct rcuwait' declared insi=
de parameter list will not be visible outside of this definition or declara=
tion [-Werror]
>     6 | extern int rcuwait_wake_up(struct rcuwait *w);
>       |                                   ^~~~~~~
> In file included from .../include/linux/percpu-rwsem.h:7,
>                  from .../include/linux/fs.h:34,
>                  from .../include/linux/proc_fs.h:10,
>                  from .../init/main.c:21:
> .../include/linux/rcuwait.h:26:12: error: conflicting types for 'rcuwait_=
wake_up'; have 'int(struct rcuwait *)'
>    26 | extern int rcuwait_wake_up(struct rcuwait *w);
>       |            ^~~~~~~~~~~~~~~
> .../include/linux/mmap_lock.h:6:12: note: previous declaration of 'rcuwai=
t_wake_up' with type 'int(struct rcuwait *)'
>     6 | extern int rcuwait_wake_up(struct rcuwait *w);
>       |            ^~~~~~~~~~~~~~~
>

I see, thanks!
I would prefer simply moving rcuwait_wake_up() forward declaration
after the includes, like this:


 #ifndef _LINUX_MMAP_LOCK_H
 #define _LINUX_MMAP_LOCK_H

-/* Avoid a dependency loop by declaring here. */
-extern int rcuwait_wake_up(struct rcuwait *w);
-
 #include <linux/lockdep.h>
 #include <linux/mm_types.h>
 #include <linux/mmdebug.h>
@@ -14,6 +11,9 @@ extern int rcuwait_wake_up(struct rcuwait *w);
 #include <linux/cleanup.h>
 #include <linux/sched/mm.h>

+extern int rcuwait_wake_up(struct rcuwait *w);
+
 #define MMAP_LOCK_INITIALIZER(name) \


This would avoid extra forward declarations. Not sure why it was
placed before includes in the first place. I tried moving it and
things build just fine. Lorenzo, do you recall specific reasons the
forward declaration should have been placed before the includes?

> > > ---
> > >  include/linux/mmap_lock.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > > index 11a078de9150df1beff4f0bfb16e199333767614..9792dd4fff0ff73829833=
aae8ea3229a31757d61 100644
> > > --- a/include/linux/mmap_lock.h
> > > +++ b/include/linux/mmap_lock.h
> > > @@ -3,6 +3,7 @@
> > >  #define _LINUX_MMAP_LOCK_H
> > >
> > >  /* Avoid a dependency loop by declaring here. */
> > > +struct rcuwait;
> > >  extern int rcuwait_wake_up(struct rcuwait *w);
> > >
> > >  #include <linux/lockdep.h>
> > >
> > > ---
> > > base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> > > change-id: 20250916-mm-rcuwait-03c5fe95f36d
> > >
> > > Best regards,
> > > --
> > > Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

