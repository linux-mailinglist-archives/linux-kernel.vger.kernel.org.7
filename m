Return-Path: <linux-kernel+bounces-802036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA6DB44CFB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3371BC0FDF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30A3257830;
	Fri,  5 Sep 2025 05:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="33+dHx2G"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384A91DF985
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 05:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757048875; cv=none; b=k8VDPe03UoAjxqkji63UlJFCMxQa2sbEThWScQo43RSYXwXE0I32U0XzYqV25J4n9xqelfervT9uPZbA5kSkTabtkqoGOPt6N1BIxaepKNan3J9OKNpy6L+fiQers8Ej0AgXFpEIDReDKQJPIO3m8jd3/Pb29oaI6xQraKjT3ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757048875; c=relaxed/simple;
	bh=OOEmsL0qXuuvxyU863D9ENc6WfMmcFh93LjMEAqqtkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2o9rSFCgB1xXxKYtXmGkVKxDaxadKMeS2rzwc7jy6uhYSSxLSzGzx0EnUVmqPgqOIsL3w3usBh2DvBl5W+goqsgMILi0Q7H4WvP9LIdWdYirfugYJAf0PF9+RVisRDPq6hGbAA5YVv30ODoyvWcxAEUpv/u7vQvWGS8ofO4xlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=33+dHx2G; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-52a8b815a8aso930443137.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 22:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757048871; x=1757653671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYLPhe2ZlMGm5f6xhDYv2w/D/UJ5kWg6nZ20L3SWBmc=;
        b=33+dHx2GS78cVP+WMSlf+dJ2+bIQThXSXhgcKF/9XUAkmoSHZQ1yHMepn9RNA+lQmr
         CeMW6a6SNTWTgLkBi3S3jPAoNUDQniaIWlLeh6aYY909SZEBm43F+3dlIOkX5edFkGeB
         v9c/aypawjbudiCHzJeObaC0xPMWLKPFwjpVCkPQ9Zo4KWtIcUdoMW+HQl1bzSc7mgkQ
         GGGxNsNSok10aOkqA26trrHslb8b7Q29PL97mwmCzjVag4jbFGnxGlEyi1lwbT/j2zN5
         5e0/0jjOhuH6xmsuDWVHROj6DEfS1Boaj998mzHWnhgVWFcNWUuRe3dakkcXm/Ir1Tzx
         2ZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757048871; x=1757653671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYLPhe2ZlMGm5f6xhDYv2w/D/UJ5kWg6nZ20L3SWBmc=;
        b=fT3s6E5ur4snsihBYyU6NViq+anOf8r0YfFW1e9ifnT06pXrFF3B5KriTK2Uo/IqLs
         ah4sxP5Xv0Qri3KZ0PUGbCzEMujPOv6Mc8Jfvb5r/+yQNnkHsRYZfl4Mdf7A/KuOANuD
         h8yCivuv/l8gwdLH7ky5lDuc8Su8STB/w13cUjGKAM0q3jmCucil+S1JMtsTqfQAafPQ
         2mhkk7atAIWMYRtKooSWwLrdn1zXky3wyxqmskxnVGo9LwimzOz4wf9VRbwywlMnEj4A
         5g/0Ux30ygudEg7EwlD4vCkJPOIu7WO4IS2JAYlg9Cv9FlLR+po5ac4FVnGvdcOWC+1l
         CkXw==
X-Forwarded-Encrypted: i=1; AJvYcCVJKPrdWNzZjbsoqlWMnUtfogmz3yX823PgLQiWQP8WbOKHPkFI+ubJhERuNUVl6CWPCWOgtvtQtonsOrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywplh62tCOUc0fIlnCtgHh8BQ1hU+oh9i25mFD1mPVmmydhVe5w
	vUGj7RFcIqoD+Om+QNwlWpeKZ0K5FgaEff6f65H7urygvhQRCyo7Ut8rCP4Qwb2YOSeTZHXXYO8
	fdotAYYT1mcTHKZKaYd9OIZyZRibFz9+cXyWbIzg7
X-Gm-Gg: ASbGncvoMHXjmg7BvetoMEhU6iRUsC9+MzT+ZWtcfNe4JHLzdg3ZT2ba7Qol88LqNoG
	C0Ie5LfPG77FI6BfeF715hNiZyH0pR7qBVEiXc6uUFFxFKEns3WzzV8o/OoBfAaGBrz9kf3ty63
	KereR2Y1VMUjt+kUPRm5hl/JXGqzUQDBElfue9EKxZLvhozpilLQofwqLPsUHzRvM/antlzc4vC
	uaGrGGpf71G
X-Google-Smtp-Source: AGHT+IEsL79O68OTNvb89F9iHUZTOaRT9QGifl8mhXc2xY8l+OJiaz04OhlW33Y1yeTaFRkTQAsYhaiqWYqvXsh9VdY=
X-Received: by 2002:a05:6102:5a92:b0:521:27b:bea4 with SMTP id
 ada2fe7eead31-52b1974a6a7mr6133344137.6.1757048870743; Thu, 04 Sep 2025
 22:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821004237.2712312-1-wusamuel@google.com> <20250821004237.2712312-3-wusamuel@google.com>
 <CAJZ5v0gT2h_SgPDh=t-XWxgWnm8diG_rMuDVo-RnQxqvA7chPw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gT2h_SgPDh=t-XWxgWnm8diG_rMuDVo-RnQxqvA7chPw@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 5 Sep 2025 12:07:13 +0700
X-Gm-Features: Ac12FXxS8dpIf7UXGZq7779yjiD3y1D87JbJzwlDcBFq-3xJ2xmbqUVEXTpPhqk
Message-ID: <CAGETcx-3n9Qkiu70Pd2=sjSRsXNMf=CsJQdNLbHUS089qf=vsw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] PM: Support aborting suspend during filesystem sync
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 2:22=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Thu, Aug 21, 2025 at 2:43=E2=80=AFAM Samuel Wu <wusamuel@google.com> w=
rote:
> >
> > At the start of suspend, filesystems will sync to save the current stat=
e
> > of the device. However, the long tail of the filesystem sync can take
> > upwards of 25 seconds. If during this filesystem sync there is some
> > wakeup or abort signal, it will not be processed until the sync is
> > complete; from a user's perspective, this looks like the device is
> > unresponsive to any form of input.
> >
> > This patch adds functionality to handle a suspend abort signal when in
> > the filesystem sync phase of suspend. This topic was first discussed by
> > Saravana Kannan at LPC 2024 [1], where the general consensus was to
> > allow filesystem sync on a parallel thread.
> >
> > [1]: https://lpc.events/event/18/contributions/1845/
> >
> > Suggested-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Samuel Wu <wusamuel@google.com>
>
> The idea is fine with me, but I have comments on the implementation.
>
> First off, I'm not sure how the split of patch [3/3] from this one
> helps because that patch adds mandatory functionality.

It makes the reviewing a lot easier -- at least for me. Especially if
you want to come back and look at the change history. But we are happy
to squash it if you feel strongly.

>  Patch [2/3]
> cannot be applied without patch [3/3], so as far as I'm concerned, it
> is not applicable at all.
>
> > ---
> >  drivers/base/power/wakeup.c |  8 +++++++
> >  include/linux/suspend.h     |  2 ++
> >  kernel/power/suspend.c      | 48 +++++++++++++++++++++++++++++++++++--
> >  3 files changed, 56 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > index d1283ff1080b..af4cf3e6ba44 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wakeup_s=
ource *ws)
> >
> >         /* Increment the counter of events in progress. */
> >         cec =3D atomic_inc_return(&combined_event_count);
> > +       /*
> > +        * wakeup_source_activate() aborts suspend only if events_check=
_enabled
> > +        * is set (see pm_wakeup_pending()). Similarly, abort suspend d=
uring
> > +        * fs_sync only if events_check_enabled is set.
> > +        */
> > +       if (events_check_enabled)
> > +               suspend_abort_fs_sync();
> >
> >         trace_wakeup_source_activate(ws->name, cec);
> >  }
> > @@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
> >  void pm_system_wakeup(void)
> >  {
> >         atomic_inc(&pm_abort_suspend);
> > +       suspend_abort_fs_sync();
> >         s2idle_wake();
> >  }
> >  EXPORT_SYMBOL_GPL(pm_system_wakeup);
> > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > index 317ae31e89b3..68d2e8a7eeb1 100644
> > --- a/include/linux/suspend.h
> > +++ b/include/linux/suspend.h
> > @@ -276,6 +276,7 @@ extern void arch_suspend_enable_irqs(void);
> >
> >  extern int pm_suspend(suspend_state_t state);
> >  extern bool sync_on_suspend_enabled;
> > +extern void suspend_abort_fs_sync(void);
> >  #else /* !CONFIG_SUSPEND */
> >  #define suspend_valid_only_mem NULL
> >
> > @@ -296,6 +297,7 @@ static inline bool idle_should_enter_s2idle(void) {=
 return false; }
> >  static inline void __init pm_states_init(void) {}
> >  static inline void s2idle_set_ops(const struct platform_s2idle_ops *op=
s) {}
> >  static inline void s2idle_wake(void) {}
> > +static inline void suspend_abort_fs_sync(void) {}
> >  #endif /* !CONFIG_SUSPEND */
> >
> >  static inline bool pm_suspend_in_progress(void)
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index 4bb4686c1c08..edacd2a4143b 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -31,6 +31,7 @@
> >  #include <linux/compiler.h>
> >  #include <linux/moduleparam.h>
> >  #include <linux/fs.h>
> > +#include <linux/workqueue.h>
> >
> >  #include "power.h"
> >
> > @@ -74,6 +75,19 @@ bool pm_suspend_default_s2idle(void)
> >  }
> >  EXPORT_SYMBOL_GPL(pm_suspend_default_s2idle);
> >
> > +static DECLARE_COMPLETION(suspend_fs_sync_complete);
> > +
> > +/**
> > + * suspend_abort_fs_sync - Abort fs_sync to abort suspend early
>
> This name is kind of misleading because the function doesn't abort
> fs_sync.  It aborts suspend while fs_sync is in progress.
>
> The fs_sync is continuing and needs to be waited for to complete, at
> least in subsequent suspend/hibernate cycles.
>
> Does system shutdown need to wait for it too?

If the system shutdown does a sync in parallel, does it matter this
one is going on in parallel too? Doesn't seem any different then
shutting down right after userspace calls fsync.

Also, we allow skip sync on suspend today. So I doubt shutdown depends
on sync on suspend for correctness of shutdown.

> > + *
> > + * This function aborts the fs_sync stage of suspend so that suspend i=
tself can
> > + * be aborted early.
> > + */
> > +void suspend_abort_fs_sync(void)
> > +{
> > +       complete(&suspend_fs_sync_complete);
> > +}
> > +
> >  void s2idle_set_ops(const struct platform_s2idle_ops *ops)
> >  {
> >         unsigned int sleep_flags;
> > @@ -403,6 +417,34 @@ void __weak arch_suspend_enable_irqs(void)
> >         local_irq_enable();
> >  }
> >
> > +static void sync_filesystems_fn(struct work_struct *work)
> > +{
> > +       ksys_sync_helper();
> > +       complete(&suspend_fs_sync_complete);
> > +}
> > +static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
> > +
> > +/**
> > + * suspend_fs_sync_with_abort - Trigger fs_sync with ability to abort
> > + *
> > + * Return 0 on successful file system sync, otherwise returns -EBUSY i=
f file
> > + * system sync was aborted.
> > + */
> > +static int suspend_fs_sync_with_abort(void)
>
> The "with_abort" part is not needed in this name and I'd prefer
> pm_sleep_ to be used instead of suspend_
>
> > +{
> > +       reinit_completion(&suspend_fs_sync_complete);
> > +       schedule_work(&sync_filesystems);
>
> If you used a dedicated workqueue for this, waiting for the previously
> scheduled filesystems sync would be as simple as calling
> flush_workqueue(pm_fs_sync_wq);

Yeah, that was our first thought too. But unfortunately, we might want
to abort the suspend while the flush is happening (patch 3/3). Which
we can't do with flush_workqueue() and we go back to square one where
a suspend can't be aborted for a long time. That's why we need to
write it this way.

>
> > +       /*
> > +        * Completion is triggered by fs_sync finishing or a suspend ab=
ort
> > +        * signal, whichever comes first
> > +        */
> > +       wait_for_completion(&suspend_fs_sync_complete);
> > +       if (pm_wakeup_pending())
> > +               return -EBUSY;
> > +
> > +       return 0;
> > +}
> > +
> >  /**
> >   * suspend_enter - Make the system enter the given sleep state.
> >   * @state: System sleep state to enter.
> > @@ -588,14 +630,16 @@ static int enter_state(suspend_state_t state)
> >         if (state =3D=3D PM_SUSPEND_TO_IDLE)
> >                 s2idle_begin();
> >
> > +       pm_wakeup_clear(0);
> >         if (sync_on_suspend_enabled) {
> >                 trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> > -               ksys_sync_helper();
> > +               error =3D suspend_fs_sync_with_abort();
>
> The same thing would also be useful for hibernation.  Is there any
> reason for not doing it there?

No reason not to. We could add support for that in a different patch
series? Hibernate abort is not the top priority for us right now.

Thanks,
Saravana

>
> >                 trace_suspend_resume(TPS("sync_filesystems"), 0, false)=
;
> > +               if (error)
> > +                       goto Unlock;
> >         }
> >
> >         pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels=
[state]);
> > -       pm_wakeup_clear(0);
> >         pm_suspend_clear_flags();
> >         error =3D suspend_prepare(state);
> >         if (error)
> > --

