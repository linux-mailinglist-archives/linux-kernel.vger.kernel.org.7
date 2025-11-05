Return-Path: <linux-kernel+bounces-885666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2CEC33A09
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 02:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A66244F1C6A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 01:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3F8242D91;
	Wed,  5 Nov 2025 01:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="at0Ugswd"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C54D1C01
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 01:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305654; cv=none; b=qVFI70mYZd5TfcHKVunY5mrrqJgYZikmcFITcgT5f/7dljxmhPUKBzD4yFegr0tEcub7NO+2pa4YNR1Ra26j2xDx4GwMNm+ELR/CPei/MC89gCaTsaVd/ICbR7CpBj9SndgwGmTJ9ABMFBjOrEzH5C8eLOfnkfp6i7aGHSL+Yr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305654; c=relaxed/simple;
	bh=+BvOjstNdthscfcGN46++3tHZYMI8w0sGNk4MpZikcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ni+27btko0FdXXFBvxiO7zaygxEtuXtxqHeC2iGcjMcuBpZ8rbpLdzDGluju/XwPYc0n1qWmqlttBLZWJ0mM3jnKCvWSh2BQGEq0TvAWHIyrxQXv9/INW/F7jKtIMRJ7E8VwV+ThhFT3fhnyXv2cH0Yrm2FBuTM8Cao0cWG0flM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=at0Ugswd; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6407e617ad4so754877a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 17:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762305651; x=1762910451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYCtOX6JdfLkpXjrVaBs6n3i8C5xzqN11bh5ynZORqQ=;
        b=at0UgswdEaq6Jxgx5um9F3kXeg+gOY3arYaDNUsV53xAEocDTjjPSLC8X/lFAGYADM
         iTrkOQ1wGou8kQy1jC9Rj2vRo2DLIQdgdj8mNlVEU7d5NqR9vcrPsLuDWPfk368e0IHZ
         SOlDyLUxHVOkQB6TO/lGuxY8aNHlGdoZ3a+WonlRLObMay7B26MUgzTNwkKjMJLG4mnX
         mPdjka370t53FgjwIF2bI8Nz9IB4a2qADBwwOpvyA9HoBhR32zurbbt0fOd2QhGrLyrT
         Ury+SxWxCA5vBD7QpR2W9uFaSftW4RCmW24zWBgy0q8zvqXvK0akRFUxmnfXFOB61pxX
         5/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762305651; x=1762910451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYCtOX6JdfLkpXjrVaBs6n3i8C5xzqN11bh5ynZORqQ=;
        b=aysavFcb1jkrb0uVQ1G3H5QakSiCBESH3GUZP3pK5dMdpm+KmCgtPeGJquUqAuFR/1
         h727QpjezwbFe5TP75OpbjtbRGCSv1eYD3B4OOfCk1n2u+KAu5JamCn3MZ6d9lQtJMyi
         FI+9LX8B6ZJs+avjD9ysP8Y7BZdIChK9Qj53rJtOFMV8c/9GTtJ5DXD2Kjf2EvS5XlHN
         CB1eSDsxjyby2gAqHfRdcUU9DI66y4/hOAcTkdApjAV9n2Tv6vaGuc7b5c9kYHExPlfn
         t1GcI7dXp5K/hl2Y5zXONWxv8Hc5r+PODSuOWQNcioYlIvFNJdEH86DeK725eTbAJ20d
         77+g==
X-Forwarded-Encrypted: i=1; AJvYcCW/v5qmIsV/LlkxT9Q7u4e++689ANu6grfexYn9A4n7k/VDHViOmlKuJhv5fgpkXJvQafEr0Q4WaQIyIVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz22D5NpfNk9bmDiTZeNmBv01PyXObrUYKJw+05wB/FRZiEI8o8
	BtHddya/zZsLW30uGplmKd8+BpNp35r7+0n+tNWOiF2walE692vWzrwSEsXsjzP7OqCaJN978EY
	/R1fq2idtcImhHsaARTiwp+wlbWubzQBa8yhlgjmi
X-Gm-Gg: ASbGncs9DIloqSrLNcP5l8+Oyow/PLE98fL6WW/u8lxCqOCfjZop3lh7CejTNU2FMqs
	RLwg23NU6RW1hShy1V0E8CsdOt9HiW0/gRykDT1r+ryW8Mg5J6l7WrMdvzPUvcYLOExgJVOsc3Z
	rmtsPHG6/AwCY32Ba68n/hyM+6sPKS/ZCn4D1OlC8ltSYLQwe/y4YMlqmttqxwW3a6XyzGv2sYw
	JXuaq7CYHqNg8xxxMRuP7Pn/BAggsywUVZ26JYoBO91E9xcxoes/Qj7If38SvNcPTLbOZWZWExg
	pEfIKZEB3245Ntk=
X-Google-Smtp-Source: AGHT+IER/Rl328p8Mbq9Kpo3IyO2sLgJt2wPzx3JJ1RzOtnXHrglyDPRuOnejaVQmhvkP3wGIphnkwxudGVd+UL2XE0=
X-Received: by 2002:a17:907:6eac:b0:b72:6224:7e95 with SMTP id
 a640c23a62f3a-b7263023406mr162766066b.1.1762305650588; Tue, 04 Nov 2025
 17:20:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030210110.298612-1-wusamuel@google.com> <CAJZ5v0gzKN1cXfj508G4_9O2hKR0HncW4et3BNbaV+5Erh=LMA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gzKN1cXfj508G4_9O2hKR0HncW4et3BNbaV+5Erh=LMA@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 4 Nov 2025 17:20:38 -0800
X-Gm-Features: AWmQ_bncBwv0EAdZpBVqmr6E11lPWwEekjyA5IZwVkjxL8pp9OZvfSmdjj6Qnss
Message-ID: <CAG2KctonFbbN9KrKWweQWaRKNN=rZkpWQCmyyY2rKfcAUzF=sA@mail.gmail.com>
Subject: Re: [PATCH v6] PM: Support aborting sleep during filesystem sync
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, tuhaowen@uniontech.com, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 10:52=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Oct 30, 2025 at 10:01=E2=80=AFPM Samuel Wu <wusamuel@google.com> =
wrote:
> >
> > At the start of suspend and hibernate, filesystems will sync to save th=
e
> > current state of the device. However, the long tail of the filesystem
> > sync can take upwards of 25 seconds. If during this filesystem sync
> > there is some wakeup or abort signal, it will not be processed until th=
e
> > sync is complete; from a user's perspective, this looks like the device
> > is unresponsive to any form of input.
> >
> > This patch adds functionality to handle a sleep abort signal when in
> > the filesystem sync phase of suspend or hibernate. This topic was first
> > discussed by Saravana Kannan at LPC 2024 [1], where the general
> > consensus was to allow filesystem sync on a parallel thread. In case of
> > abort, the suspend process will stop waiting on an in-progress
> > filesystem sync, and continue by aborting suspend before the filesystem
> > sync is complete.
> >
> > Additionally, there is extra care needed to account for back-to-back
> > sleeps while maintaining functionality to immediately abort during the
> > filesystem sync stage. Furthermore, in the case of the back-to-back
> > sleeps, a subsequent filesystem sync is needed to ensure the latest
> > files are synced right before sleep. If necessary, a subsequent sleep's
> > filesystem sync will be queued, and will only start when the previous
> > sleep's filesystem sync has finished. While waiting for the previous
> > sleep's filesystem sync to finish, the subsequent sleep will still abor=
t
> > early if a wakeup event is triggered, solving the original issue of
> > filesystem sync blocking abort.
> >
> > [1]: https://lpc.events/event/18/contributions/1845/
> >
> > Suggested-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > ---
> > Changes in v6:
> > - Use spin_lock_irq() in thread context
> > - Use dedicated ordered workqueue for sync work items
> > - Use a counter instead of two bools for synchronization
> > - Queue fs_sync if it's not already pending on workqueue
> > - pm_wakeup_clear(0) is prequisite to this feature, so move it within f=
unction
> > - Updated commit text for motive of back-to-back fs syncs
> > - Tighter lock/unlock around setup, checks, and loop
> > - Fix function definitions for CONFIG_PM_SLEEP=3Dn
> > - v5 link: https://lore.kernel.org/all/20251017233907.2305303-1-wusamue=
l@google.com/
> >
> > Changes in v5:
> > - Update spin_lock() to spin_lock_irqsave() since abort can be in IRQ c=
ontext
> > - Updated changelog description to be more precise regarding continuing=
 abort
> >   sleep before fs_sync() is complete
> > - Rename abort_sleep_during_fs_sync() to pm_stop_waiting_for_fs_sync()
> > - Simplify from a goto to do-while in pm_sleep_fs_sync()
> > - v4 link: https://lore.kernel.org/all/20250911185314.2377124-1-wusamue=
l@google.com
> >
> > Changes in v4:
> > - Removed patch 1/3 of v3 as it is already picked up on linux-pm
> > - Squashed patches 2/3 and 3/3 from v3 into this single patch
> > - Added abort during fs_sync functionality to hibernate in addition to =
suspend
> > - Moved variables and functions for abort from power/suspend.c to power=
/main.c
> > - Renamed suspend_fs_sync_with_abort() to pm_sleep_fs_sync()
> > - Renamed suspend_abort_fs_sync() to abort_sleep_during_fs_sync()
> > - v3 link: https://lore.kernel.org/all/20250821004237.2712312-1-wusamue=
l@google.com/
> >
> > Changes in v3:
> > - Split v2 patch into 3 patches
> > - Moved pm_wakeup_clear() outside of if(sync_on_suspend_enabled) condit=
ion
> > - Updated documentation and comments within kernel/power/suspend.c
> > - v2 link: https://lore.kernel.org/all/20250812232126.1814253-1-wusamue=
l@google.com/
> >
> > Changes in v2:
> > - Added documentation for suspend_abort_fs_sync()
> > - Made suspend_fs_sync_lock and suspend_fs_sync_complete declaration st=
atic
> > - v1 link: https://lore.kernel.org/all/20250815004635.3684650-1-wusamue=
l@google.com
> >
> >  drivers/base/power/wakeup.c |  8 ++++
> >  include/linux/suspend.h     |  4 ++
> >  kernel/power/hibernate.c    |  5 ++-
> >  kernel/power/main.c         | 81 +++++++++++++++++++++++++++++++++++++
> >  kernel/power/suspend.c      |  4 +-
> >  5 files changed, 100 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > index d1283ff1080b..689c16b08b38 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wakeup_s=
ource *ws)
> >
> >         /* Increment the counter of events in progress. */
> >         cec =3D atomic_inc_return(&combined_event_count);
> > +       /*
> > +        * wakeup_source_activate() aborts sleep only if events_check_e=
nabled
> > +        * is set (see pm_wakeup_pending()). Similarly, abort sleep dur=
ing
> > +        * fs_sync only if events_check_enabled is set.
> > +        */
> > +       if (events_check_enabled)
> > +               pm_stop_waiting_for_fs_sync();
> >
> >         trace_wakeup_source_activate(ws->name, cec);
> >  }
> > @@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
> >  void pm_system_wakeup(void)
> >  {
> >         atomic_inc(&pm_abort_suspend);
> > +       pm_stop_waiting_for_fs_sync();
> >         s2idle_wake();
> >  }
> >  EXPORT_SYMBOL_GPL(pm_system_wakeup);
> > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > index b02876f1ae38..4795f55f9cbe 100644
> > --- a/include/linux/suspend.h
> > +++ b/include/linux/suspend.h
> > @@ -450,6 +450,8 @@ void restore_processor_state(void);
> >  extern int register_pm_notifier(struct notifier_block *nb);
> >  extern int unregister_pm_notifier(struct notifier_block *nb);
> >  extern void ksys_sync_helper(void);
> > +extern void pm_stop_waiting_for_fs_sync(void);
> > +extern int pm_sleep_fs_sync(void);
> >  extern void pm_report_hw_sleep_time(u64 t);
> >  extern void pm_report_max_hw_sleep(u64 t);
> >  void pm_restrict_gfp_mask(void);
> > @@ -505,6 +507,8 @@ static inline void pm_restrict_gfp_mask(void) {}
> >  static inline void pm_restore_gfp_mask(void) {}
> >
> >  static inline void ksys_sync_helper(void) {}
> > +static inline void pm_stop_waiting_for_fs_sync(void) {}
> > +static inline int pm_sleep_fs_sync(void) { return 0; }
> >
> >  #define pm_notifier(fn, pri)   do { (void)(fn); } while (0)
> >
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index 53166ef86ba4..1874fde4b4f3 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -820,7 +820,10 @@ int hibernate(void)
> >         if (error)
> >                 goto Restore;
> >
> > -       ksys_sync_helper();
> > +       error =3D pm_sleep_fs_sync();
> > +       if (error)
> > +               goto Restore;
> > +
> >         if (filesystem_freeze_enabled)
> >                 filesystems_freeze();
> >
> > diff --git a/kernel/power/main.c b/kernel/power/main.c
> > index a6cbc3f4347a..23ca87a172a4 100644
> > --- a/kernel/power/main.c
> > +++ b/kernel/power/main.c
> > @@ -582,6 +582,84 @@ bool pm_sleep_transition_in_progress(void)
> >  {
> >         return pm_suspend_in_progress() || hibernation_in_progress();
> >  }
> > +
> > +static int pm_sleep_fs_syncs_queued;
> > +static DEFINE_SPINLOCK(pm_sleep_fs_sync_lock);
> > +static DECLARE_COMPLETION(pm_sleep_fs_sync_complete);
> > +static struct workqueue_struct *pm_fs_sync_wq;
> > +
> > +static int __init pm_start_fs_sync_workqueue(void)
> > +{
> > +       pm_fs_sync_wq =3D alloc_ordered_workqueue("pm_fs_sync_wq", 0);
> > +
> > +       return pm_fs_sync_wq ? 0 : -ENOMEM;
> > +}
> > +
> > +/**
> > + * pm_stop_waiting_for_fs_sync - Abort fs_sync to abort sleep early
> > + *
> > + * This function causes the suspend process to stop waiting on an in-p=
rogress
> > + * filesystem sync, such that the suspend process can be aborted befor=
e the
> > + * filesystem sync is complete.
> > + */
> > +void pm_stop_waiting_for_fs_sync(void)
> > +{
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
> > +       complete(&pm_sleep_fs_sync_complete);
> > +       spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags);
> > +}
>
> Apart from the kernel test robot reports,

Of course, I'll fix this in v7.

> pm_stop_waiting_for_fs_sync() has become slightly too heavy for
> calling it from wakeup_source_activate().

Trying to understand- are you saying spin_lock_irqsave() makes
pm_stop_waiting_for_fs_sync() too slow?

> Waking up the suspend process from there should be sufficient.  The
> completion is not necessary for that in principle.

Can you elaborate more on what "there" means and why completion isn't
necessary? From what I can see, the only way to abort the suspend
_early_ is with the completion.

Thanks!
Sam

