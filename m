Return-Path: <linux-kernel+bounces-807005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC1BB49EC6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCD444491C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EEB22F755;
	Tue,  9 Sep 2025 01:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b8bwLMNz"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838BA21255A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757382135; cv=none; b=fSa/shgYhKXtnWXOtzbZvjurvOFiKBGsiTbrFrVwpb7gST3GVoYjeCjMOxCu6ZE0ob2IL/KB/bZrwRkhHAaYosRiV5v+GUcjmyun6OPEweqPhJNVLqiiCYLNslDncT6UjZ5V2fimkwf7tMmU563rn2JcAyfeWECnpFRMUwF+3Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757382135; c=relaxed/simple;
	bh=oJhN3z3H5QEIgAJhWdiwxVmZqq21uVCwvZbBwZUXNS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kh1+tKtfMv+xv+R8fXXH9qgRSvlgUlTIoiDFQf2+pSntskHdXtEbHyyNlRhcqvq9xQeLMs5iJ7z6vOfvjvBrsq0fRzX73RyCXAMbvJmWaQTYuCyg3iz36qdqao8Ay4dZ7N7q0W22ddBRQCLaGe+nc7NNgnLsRMYumfHLc3dVD40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b8bwLMNz; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-50f8bf5c518so3890726137.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 18:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757382131; x=1757986931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yq92p50racd2GkMTL0hC1g4bBfuWl2nmhdLmR0buDtY=;
        b=b8bwLMNzW5VAowZXaNN5KP8de9zhsjZCAgi0D6G8TvBINF/1vRdQiqeud/Zg/jXQwW
         CA+ySFYcSnWgzGt3lUIha4gKIbj5qJy1YVbZhvUyCCpWxCVC4fybz4AkaKdY/o/wwii5
         2EM1FYToQvBLa8s2W9w2mKBP5YLwLKqg/nksM+j6P0aAx/ZIhw7yuyjaIyLKvwQV98sT
         WbosQrVfNC1JXR/NgXL3v3/OyEQAbkJJz3PnTD/5G5awKuomaKUFSt5rM+xdDrTnamcr
         no34a0v3sd31BEmf+3sliRlv8oHUX+hCCps/yU8MSOdSx/NbmzrUpXb5ECrWaDozSUGB
         Cb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757382131; x=1757986931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yq92p50racd2GkMTL0hC1g4bBfuWl2nmhdLmR0buDtY=;
        b=H5HETNVcooYGm08hxXEKHnqpRvz9t4i992G7OXmWGBJgvn7gUczQG1309qcrpSKxss
         SzK4T+AdxAaJztryN6zO+YnBKeTKALqF0DahqYVK8OHqXaVvJ+4P05rNGnUHQtjpXjfO
         PGMWcwSJFW53iYHvbWPfuguRcUf9agqDQYqM9P4z9eAzatngixUS96opQLDjHYdd5OJy
         AtV1T7WtQFcREZpyWnXAegZxF0DinopQOJLOErLeacTsM29T47j1KonsSFgv0mqSErme
         eHvRZH/EoQgroBmHnfhH3RjeEFZHCttmhk8J/jg9af+6rAbtPFiGz+VHOzOAPB7p7OhD
         JhFg==
X-Forwarded-Encrypted: i=1; AJvYcCV7Alm8B9rBTWcLsdImKT9nf83iboQmEs2/WdqIbhZr0027LWkA25kNSkF6WhcytM1Q8iExDPX/ig7BPgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFgP0Z3LWh6DKDaEgLkjQtrwTZ3o48IkWZ9NU4u1QpmSHGF72t
	FIcn5I62e+AmPZuNmnQEBFC2YV+DTOOWTEX4jgi96QDPYYZCiGon9BAyA9Lp/qhzIcGd5CS7Ebf
	Q9Msv4iredAeAvoebj1f/OJQBdps43QtWb6orLaJu
X-Gm-Gg: ASbGncvKOq0+Un70XKK0uhzGRCdiAUnBt/3lIwb5OD68DgYrSkfqPRyqQ8DLIasafMc
	GYFTO+e5AIOsI/op6gBOoCfUgSW5kM1ZYPHWxAInkcjAM5Fl/7192bJcqfpUcCzo7yDc2kiAvDy
	MPmGrYkUkMJ2jEf0K0dJCQsWVW4PPZ1D+tp9fjMoLzxub6Zr6rfYzKtHUWWq4SC1fGZyo4KSF95
	o12pkmm5cicl9gC
X-Google-Smtp-Source: AGHT+IF3vhdZPmb5ybTgxyrmoQoXJwh0Mf3bRPKRutRWXQTtu8T57KEv3Ttry6FrenAzhRe0bcLcRUgdkmXs6s7w27s=
X-Received: by 2002:a05:6102:4a98:b0:4fd:53e0:b522 with SMTP id
 ada2fe7eead31-53d21db63c7mr2937824137.19.1757382131115; Mon, 08 Sep 2025
 18:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821004237.2712312-1-wusamuel@google.com> <20250821004237.2712312-3-wusamuel@google.com>
 <CAJZ5v0gT2h_SgPDh=t-XWxgWnm8diG_rMuDVo-RnQxqvA7chPw@mail.gmail.com>
 <CAGETcx-3n9Qkiu70Pd2=sjSRsXNMf=CsJQdNLbHUS089qf=vsw@mail.gmail.com> <CAJZ5v0gerKe7fmTh==F4HOOAmF60devB2N8pV1fn9QzX45JzAA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gerKe7fmTh==F4HOOAmF60devB2N8pV1fn9QzX45JzAA@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 8 Sep 2025 18:41:34 -0700
X-Gm-Features: AS18NWBGMgHafWWmMBMQU-LCiP507gytlnc-4UBn_03OWYCIAP5kGsJMd_y-Ip0
Message-ID: <CAGETcx8x5G75sQ9zVkxe+BpK7WsEk+LS6KDMd5BBR=xWPMtevg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] PM: Support aborting suspend during filesystem sync
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 2:38=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Fri, Sep 5, 2025 at 7:07=E2=80=AFAM Saravana Kannan <saravanak@google.=
com> wrote:
> >
> > On Fri, Sep 5, 2025 at 2:22=E2=80=AFAM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> > >
> > > On Thu, Aug 21, 2025 at 2:43=E2=80=AFAM Samuel Wu <wusamuel@google.co=
m> wrote:
> > > >
> > > > At the start of suspend, filesystems will sync to save the current =
state
> > > > of the device. However, the long tail of the filesystem sync can ta=
ke
> > > > upwards of 25 seconds. If during this filesystem sync there is some
> > > > wakeup or abort signal, it will not be processed until the sync is
> > > > complete; from a user's perspective, this looks like the device is
> > > > unresponsive to any form of input.
> > > >
> > > > This patch adds functionality to handle a suspend abort signal when=
 in
> > > > the filesystem sync phase of suspend. This topic was first discusse=
d by
> > > > Saravana Kannan at LPC 2024 [1], where the general consensus was to
> > > > allow filesystem sync on a parallel thread.
> > > >
> > > > [1]: https://lpc.events/event/18/contributions/1845/
> > > >
> > > > Suggested-by: Saravana Kannan <saravanak@google.com>
> > > > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > >
> > > The idea is fine with me, but I have comments on the implementation.
> > >
> > > First off, I'm not sure how the split of patch [3/3] from this one
> > > helps because that patch adds mandatory functionality.
> >
> > It makes the reviewing a lot easier -- at least for me. Especially if
> > you want to come back and look at the change history. But we are happy
> > to squash it if you feel strongly.
> >
> > >  Patch [2/3]
> > > cannot be applied without patch [3/3], so as far as I'm concerned, it
> > > is not applicable at all.
> > >
> > > > ---
> > > >  drivers/base/power/wakeup.c |  8 +++++++
> > > >  include/linux/suspend.h     |  2 ++
> > > >  kernel/power/suspend.c      | 48 +++++++++++++++++++++++++++++++++=
++--
> > > >  3 files changed, 56 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeu=
p.c
> > > > index d1283ff1080b..af4cf3e6ba44 100644
> > > > --- a/drivers/base/power/wakeup.c
> > > > +++ b/drivers/base/power/wakeup.c
> > > > @@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wake=
up_source *ws)
> > > >
> > > >         /* Increment the counter of events in progress. */
> > > >         cec =3D atomic_inc_return(&combined_event_count);
> > > > +       /*
> > > > +        * wakeup_source_activate() aborts suspend only if events_c=
heck_enabled
> > > > +        * is set (see pm_wakeup_pending()). Similarly, abort suspe=
nd during
> > > > +        * fs_sync only if events_check_enabled is set.
> > > > +        */
> > > > +       if (events_check_enabled)
> > > > +               suspend_abort_fs_sync();
> > > >
> > > >         trace_wakeup_source_activate(ws->name, cec);
> > > >  }
> > > > @@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
> > > >  void pm_system_wakeup(void)
> > > >  {
> > > >         atomic_inc(&pm_abort_suspend);
> > > > +       suspend_abort_fs_sync();
> > > >         s2idle_wake();
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(pm_system_wakeup);
> > > > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > > > index 317ae31e89b3..68d2e8a7eeb1 100644
> > > > --- a/include/linux/suspend.h
> > > > +++ b/include/linux/suspend.h
> > > > @@ -276,6 +276,7 @@ extern void arch_suspend_enable_irqs(void);
> > > >
> > > >  extern int pm_suspend(suspend_state_t state);
> > > >  extern bool sync_on_suspend_enabled;
> > > > +extern void suspend_abort_fs_sync(void);
> > > >  #else /* !CONFIG_SUSPEND */
> > > >  #define suspend_valid_only_mem NULL
> > > >
> > > > @@ -296,6 +297,7 @@ static inline bool idle_should_enter_s2idle(voi=
d) { return false; }
> > > >  static inline void __init pm_states_init(void) {}
> > > >  static inline void s2idle_set_ops(const struct platform_s2idle_ops=
 *ops) {}
> > > >  static inline void s2idle_wake(void) {}
> > > > +static inline void suspend_abort_fs_sync(void) {}
> > > >  #endif /* !CONFIG_SUSPEND */
> > > >
> > > >  static inline bool pm_suspend_in_progress(void)
> > > > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > > > index 4bb4686c1c08..edacd2a4143b 100644
> > > > --- a/kernel/power/suspend.c
> > > > +++ b/kernel/power/suspend.c
> > > > @@ -31,6 +31,7 @@
> > > >  #include <linux/compiler.h>
> > > >  #include <linux/moduleparam.h>
> > > >  #include <linux/fs.h>
> > > > +#include <linux/workqueue.h>
> > > >
> > > >  #include "power.h"
> > > >
> > > > @@ -74,6 +75,19 @@ bool pm_suspend_default_s2idle(void)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(pm_suspend_default_s2idle);
> > > >
> > > > +static DECLARE_COMPLETION(suspend_fs_sync_complete);
> > > > +
> > > > +/**
> > > > + * suspend_abort_fs_sync - Abort fs_sync to abort suspend early
> > >
> > > This name is kind of misleading because the function doesn't abort
> > > fs_sync.  It aborts suspend while fs_sync is in progress.
> > >
> > > The fs_sync is continuing and needs to be waited for to complete, at
> > > least in subsequent suspend/hibernate cycles.
> > >
> > > Does system shutdown need to wait for it too?
> >
> > If the system shutdown does a sync in parallel, does it matter this
> > one is going on in parallel too? Doesn't seem any different then
> > shutting down right after userspace calls fsync.
> >
> > Also, we allow skip sync on suspend today. So I doubt shutdown depends
> > on sync on suspend for correctness of shutdown.
>
> What if the sync is still in progress when shutdown takes place?
> Could shutdown somehow break it and cause data corruption, say?

We will take a closer look.

>
> > > > + *
> > > > + * This function aborts the fs_sync stage of suspend so that suspe=
nd itself can
> > > > + * be aborted early.
> > > > + */
> > > > +void suspend_abort_fs_sync(void)
> > > > +{
> > > > +       complete(&suspend_fs_sync_complete);
> > > > +}
> > > > +
> > > >  void s2idle_set_ops(const struct platform_s2idle_ops *ops)
> > > >  {
> > > >         unsigned int sleep_flags;
> > > > @@ -403,6 +417,34 @@ void __weak arch_suspend_enable_irqs(void)
> > > >         local_irq_enable();
> > > >  }
> > > >
> > > > +static void sync_filesystems_fn(struct work_struct *work)
> > > > +{
> > > > +       ksys_sync_helper();
> > > > +       complete(&suspend_fs_sync_complete);
> > > > +}
> > > > +static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
> > > > +
> > > > +/**
> > > > + * suspend_fs_sync_with_abort - Trigger fs_sync with ability to ab=
ort
> > > > + *
> > > > + * Return 0 on successful file system sync, otherwise returns -EBU=
SY if file
> > > > + * system sync was aborted.
> > > > + */
> > > > +static int suspend_fs_sync_with_abort(void)
> > >
> > > The "with_abort" part is not needed in this name and I'd prefer
> > > pm_sleep_ to be used instead of suspend_
> > >
> > > > +{
> > > > +       reinit_completion(&suspend_fs_sync_complete);
> > > > +       schedule_work(&sync_filesystems);
> > >
> > > If you used a dedicated workqueue for this, waiting for the previousl=
y
> > > scheduled filesystems sync would be as simple as calling
> > > flush_workqueue(pm_fs_sync_wq);
> >
> > Yeah, that was our first thought too. But unfortunately, we might want
> > to abort the suspend while the flush is happening (patch 3/3). Which
> > we can't do with flush_workqueue() and we go back to square one where
> > a suspend can't be aborted for a long time. That's why we need to
> > write it this way.
>
> So this is an optimization which I'm not sure is really necessary.
> Maybe let's start with the flush_workqueue() approach and then
> complicate things if it is demonstrated to be insufficient?

Unfortunately, back to back suspend attempts are very common in
Android. When we have a lot of dirty pages and approach the long tail
of 25 seconds to sync the file system, this is not a corner case at
all.

Also, even if it's only a 1% chance of happening, that's 10 million
users when the total population is a billion users. And this is very
user perceptible issue that significantly degrades the user experience
(it has happened to me too).

>
> > >
> > > > +       /*
> > > > +        * Completion is triggered by fs_sync finishing or a suspen=
d abort
> > > > +        * signal, whichever comes first
> > > > +        */
> > > > +       wait_for_completion(&suspend_fs_sync_complete);
> > > > +       if (pm_wakeup_pending())
> > > > +               return -EBUSY;
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  /**
> > > >   * suspend_enter - Make the system enter the given sleep state.
> > > >   * @state: System sleep state to enter.
> > > > @@ -588,14 +630,16 @@ static int enter_state(suspend_state_t state)
> > > >         if (state =3D=3D PM_SUSPEND_TO_IDLE)
> > > >                 s2idle_begin();
> > > >
> > > > +       pm_wakeup_clear(0);
> > > >         if (sync_on_suspend_enabled) {
> > > >                 trace_suspend_resume(TPS("sync_filesystems"), 0, tr=
ue);
> > > > -               ksys_sync_helper();
> > > > +               error =3D suspend_fs_sync_with_abort();
> > >
> > > The same thing would also be useful for hibernation.  Is there any
> > > reason for not doing it there?
> >
> > No reason not to. We could add support for that in a different patch
> > series?
>
> Not really.
>
> > Hibernate abort is not the top priority for us right now.
>
> With all due respect, please handle them both or none.  Otherwise,
> you'd create an arbitrary divergence that would become a maintenance
> burden going forward.

Fair enough. We can take care of that too.

Thanks,
Saravana

