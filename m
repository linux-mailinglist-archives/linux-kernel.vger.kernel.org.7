Return-Path: <linux-kernel+bounces-776701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4918B2D0A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65CF41BC773E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72927E573;
	Wed, 20 Aug 2025 00:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g167KeLX"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C044035335A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755649387; cv=none; b=FJGb9oQVjPCKivPUNuuocOoeaQ84y6P172HP3Ku9oEkRVZk7h9vvlhPc4YP8V1jrlbyStExPKadxaziLYtKzHvsWYgc2yoTTQkreX9fc07OfbSJ/DcTySTH5CaqkX+Dav0VUTB7wiWAyKH/Anb5MzO2YUj9BlK2wizKFELxTI5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755649387; c=relaxed/simple;
	bh=OPus0vxolO/VNPHiO1/7rlNF53uJLn7GHPKb0g58/7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4FkhCWGMVqwSTAqzLfsoisyFFPhZhqVd9feYr17HzHVgeh5CkuaAlBpL3WVLX6zKfVBgYNNYIqQGrDl5UCC/22fRKpgW1BN/j+ljGP9WAb7Cl9sexE4IUg6h5yziTq8SezPn4jQLLgPCWziYWW1izLQbNkPcRsvkeqjKLqtaLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g167KeLX; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-50f8bf6a9d7so1555061137.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755649385; x=1756254185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkNKxOXnA841VLAMrQlOelYaWXKqV98Qjy3zwkF4W3M=;
        b=g167KeLXutwJ/Aio0QavEYfpmYfcOQWAIKFD+ovy1Rtlp4wqqsUK6a/KflQZQUMlbT
         ncTkJhJQJbVWojuGxwmZ5OjTyT+u1u9lTzYu6MgfI+9CSbgHUzSax6iTsPQAswcYrFhO
         ynaX2QJ3g7HFw2BR+Z2dFn5eMTjrOUE3A9vYYehK1Hq+8U9qOq7cH4wNEMmD/t/LAav5
         AZQ/Yw1c7kCQCCnbTdLuzunafuddDna7vfbHLAsBWmC/euPo2kkYZR8zfgisaL4Gd3/P
         UXNf+cXUDuKAWOxdw2Y1kkdddSqCpRiOC2/9VBcI9zRrpVcpun2CflHbWsCguqaIQqAJ
         lE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755649385; x=1756254185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkNKxOXnA841VLAMrQlOelYaWXKqV98Qjy3zwkF4W3M=;
        b=j293L3jRR72UTTSvaT0Zid0XkiSTSG6i/GmQWnfU92kIbFqhqDspD7+eHq1Cdwq/j2
         5I2rxcBDEd1IS9I740O6shAv6bthuv7B0BfuEU9sAp8VvGFQx1Y66B5XdBM4QHp4CWcv
         vbci/RT8egbHc/RKuuGexr3RPL4o33t5kORw0u/sIZxKqLywX00JysF6W9su6mfNLQUR
         VKhqc+zqtslVt10V2wwlA1ay8GJQxAEwYKqUsTC2TbgRm/V7bh0ks1V3L1CWu3jtDJbN
         l81/qoRcG1KB1S387ocg8gguv/C3h8dO+9kIbCyAaog6mZzrEMRDWrj0jHf+XtqlQqoh
         8jkg==
X-Forwarded-Encrypted: i=1; AJvYcCUFJzrQ8OUh/XHl8Jb3XDbYuRz6KQdV/Q0OcmDNjciFawyuRLs8WpIctFdBQ53TvVyIFVgx1q95CHEnW38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yziw4ZkMfV33cU3DjuFoMFYePAk2cl2qZVFaITRTg/DSP/ucUPO
	o9CVBaNu1Lhc701Ako7O5QaCnVxc9AipmlVQv5FZ6viCKCyr6ixTEQZUmU+ePRtBsHtXXjcw0+b
	9hBcYNFiVGmSOeBG8QClqNx/sDkoju7R7/9dr007j
X-Gm-Gg: ASbGncs3A/kEMrvxT8zk5YLMbufT5DAC/qLa2Le5DmShfEOvKeVN/kZVhof2TVTfCec
	ma5dBM62uLsQdsRD8wNhXN1Hyituu9iX5Nux2l2Zr1W6guSYChY+e+hoEhewwGpNDYkqwIWAjHJ
	T2famS+CHuDFbQsNo5eYkfkCUuTqbD+H6aLW8OIMpVEFyxXHJCAZbZ9dElEtDPcB81j9LW239sj
	BObvvO1cJcFUDmA/Z4Z28ay0VU/iJ3PDuKKNhPqCxhc
X-Google-Smtp-Source: AGHT+IGjzLS8qrGqTNmWR/LP41AI9LYDaBlQgEH3L2uRs/VsdSKupwuZAvKUcAAlAGI81m3e1PctwYa6uF3YdOKe5R8=
X-Received: by 2002:a05:6102:f0f:b0:4f9:69a9:4ec5 with SMTP id
 ada2fe7eead31-51a5119926cmr306457137.27.1755649384211; Tue, 19 Aug 2025
 17:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815004635.3684650-1-wusamuel@google.com>
In-Reply-To: <20250815004635.3684650-1-wusamuel@google.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 19 Aug 2025 17:22:26 -0700
X-Gm-Features: Ac12FXwhP-z57JIwvojaaiXAYO85iOpjGt6ehTHSMwEQC65wital8z3QRsCM3Rw
Message-ID: <CAGETcx_2cH6vyAUx3Zb=2GDCp_WK4A=JpF+8DXc0iLFT9S21Hg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: Support aborting suspend during filesystem sync
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 5:46=E2=80=AFPM Samuel Wu <wusamuel@google.com> wro=
te:
>
> At the start of suspend, filesystems will sync to save the current state
> of the device. However, the long tail of the filesystem sync can take
> upwards of 25 seconds. If during this filesystem sync there is some
> wakeup or abort signal, it will not be processed until the sync is
> complete; from a user's perspective, this looks like the device is
> unresponsive to any form of input.
>
> This patch adds functionality to handle a suspend abort signal when in
> the filesystem sync phase of suspend. This topic was first discussed by
> Saravana Kannan at LPC 2024 [1], where the general consensus was to
> allow filesystem sync on a parallel thread.
>
> [1]: https://lpc.events/event/18/contributions/1845/
>
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Samuel Wu <wusamuel@google.com>

Minor comments on documentation. The code itself seems good to me.

> ---
>  drivers/base/power/wakeup.c |  8 ++++
>  include/linux/suspend.h     |  3 ++
>  kernel/power/process.c      |  1 -
>  kernel/power/suspend.c      | 85 ++++++++++++++++++++++++++++++++++++-
>  4 files changed, 95 insertions(+), 2 deletions(-)
>
> v1 -> v2:
> - Added documentation for suspend_abort_fs_sync()
> - Made suspend_fs_sync_lock and suspend_fs_sync_complete declaration stat=
ic
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index d1283ff1080b..304368c3a55f 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wakeup_sou=
rce *ws)
>
>         /* Increment the counter of events in progress. */
>         cec =3D atomic_inc_return(&combined_event_count);
> +       /*
> +        * To maintain the same behavior as pm_wakeup_pending(),
> +        * aborting suspend will only happen if events_check_enabled. Sim=
ilarly,
> +        * the abort during fs_sync needs the same check.
> +        */

Maybe something like this would be clearer?
wakeup source active aborts suspend only if events_check_enabled is
set (See pm_wakeup_pending()). Similarly, it should abort fs_sync only
if events_check_enabled is set.

> +       if (events_check_enabled)
> +               suspend_abort_fs_sync();
>
>         trace_wakeup_source_activate(ws->name, cec);
>  }
> @@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
>  void pm_system_wakeup(void)
>  {
>         atomic_inc(&pm_abort_suspend);
> +       suspend_abort_fs_sync();
>         s2idle_wake();
>  }
>  EXPORT_SYMBOL_GPL(pm_system_wakeup);
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 317ae31e89b3..21b1ea275c79 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -276,6 +276,8 @@ extern void arch_suspend_enable_irqs(void);
>
>  extern int pm_suspend(suspend_state_t state);
>  extern bool sync_on_suspend_enabled;
> +
> +extern void suspend_abort_fs_sync(void);
>  #else /* !CONFIG_SUSPEND */
>  #define suspend_valid_only_mem NULL
>
> @@ -296,6 +298,7 @@ static inline bool idle_should_enter_s2idle(void) { r=
eturn false; }
>  static inline void __init pm_states_init(void) {}
>  static inline void s2idle_set_ops(const struct platform_s2idle_ops *ops)=
 {}
>  static inline void s2idle_wake(void) {}
> +static inline void suspend_abort_fs_sync(void) {}
>  #endif /* !CONFIG_SUSPEND */
>
>  static inline bool pm_suspend_in_progress(void)
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index dc0dfc349f22..8ff68ebaa1e0 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -132,7 +132,6 @@ int freeze_processes(void)
>         if (!pm_freezing)
>                 static_branch_inc(&freezer_active);
>
> -       pm_wakeup_clear(0);
>         pm_freezing =3D true;
>         error =3D try_to_freeze_tasks(true);
>         if (!error)
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index b4ca17c2fecf..dc37ab942bcb 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -31,6 +31,7 @@
>  #include <linux/compiler.h>
>  #include <linux/moduleparam.h>
>  #include <linux/fs.h>
> +#include <linux/workqueue.h>
>
>  #include "power.h"
>
> @@ -74,6 +75,21 @@ bool pm_suspend_default_s2idle(void)
>  }
>  EXPORT_SYMBOL_GPL(pm_suspend_default_s2idle);
>
> +static bool suspend_fs_sync_queued;
> +static DEFINE_SPINLOCK(suspend_fs_sync_lock);
> +static DECLARE_COMPLETION(suspend_fs_sync_complete);
> +
> +/**
> + * Triggers the completion that aborts suspend. This completion will onl=
y have
> + * an effect if called during filesystems sync step of suspend.
> + */

This is explaining the implementation of the function. It's better to
explain the semantics of the API.

For example (please feel free to rewrite it):

/* suspend_abort_fs_sync - Abort fs_sync to abort suspend early
*
* This function aborts the fs_sync stage of suspend so that suspend
itself can be aborted early.
*/

> +void suspend_abort_fs_sync(void)
> +{
> +       spin_lock(&suspend_fs_sync_lock);
> +       complete(&suspend_fs_sync_complete);
> +       spin_unlock(&suspend_fs_sync_lock);
> +}
> +
>  void s2idle_set_ops(const struct platform_s2idle_ops *ops)
>  {
>         unsigned int sleep_flags;
> @@ -403,6 +419,71 @@ void __weak arch_suspend_enable_irqs(void)
>         local_irq_enable();
>  }
>
> +static void sync_filesystems_fn(struct work_struct *work)
> +{
> +       ksys_sync_helper();
> +
> +       spin_lock(&suspend_fs_sync_lock);
> +       suspend_fs_sync_queued =3D false;
> +       complete(&suspend_fs_sync_complete);
> +       spin_unlock(&suspend_fs_sync_lock);
> +}
> +static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
> +
> +/**
> + * suspend_fs_sync_with_abort- Start filesystem sync and handle potentia=
l aborts
> + *
> + * Starts filesystem sync in a workqueue, while the main thread uses a
> + * completion to wait for either the filesystem sync to finish or for a =
wakeup
> + * event. In the case of filesystem sync finishing and triggering the
> + * completion, the suspend path continues as normal. If the complete is =
due to a
> + * wakeup or abort signal, the code jumps to the suspend abort path whil=
e the
> + * filesystem sync finishes in the background.

This is again talking about implementation. Not great for a function
doc. It's better to have these next to the implementation.

> + *
> + * An aborted suspend that is followed by another suspend is a potential
> + * scenario that complicates the sequence. This patch handles this by

Don't talk about a specific patch in an inline comment. This will be
here long after your patch is merged.

> + * serializing any filesystem sync; a subsequent suspend's filesystem sy=
nc
> + * operation will only start when the previous suspend's filesystem sync=
 has
> + * finished. Even while waiting for the previous suspend's filesystem sy=
nc to
> + * finish, the subsequent suspend will still break early if a wakeup com=
pletion
> + * is triggered, solving the original issue of filesystem sync blocking =
abort.

Most of the context of this comment is already explained below. I
don't think this function needs a function doc. But if you must, a
simple semantic documentation should be enough:

/* suspend_fs_sync_with_abort -- Tigger fs_sync with ability to abort.

This function initiates a file system sync with the ability to abort.

Return 0 on successful file system sync.
Or -EBUSY if file system sync was aborted
*/

> + */
> +static int suspend_fs_sync_with_abort(void)
> +{
> +       bool need_suspend_fs_sync_requeue;
> +
> +       pm_wakeup_clear(0);
> +Start_fs_sync:
> +       spin_lock(&suspend_fs_sync_lock);
> +       reinit_completion(&suspend_fs_sync_complete);
> +       /*
> +        * Handle the case where a suspend immediately follows a previous
> +        * suspend that was aborted during fs_sync. In this case, seriali=
ze

In this case, wait for the previous file system sync to finish. Then
do another file system sync so any subsequent changes to the file
systems are synced before suspending.

Assuming you address these non-functional comments:
Reviewed-by: Saravana Kannan <saravanak@google.com>

Thanks,
Saravana

> +        * fs_sync by only starting fs_sync of the subsequent suspend whe=
n the
> +        * fs_sync of the previous suspend has finished.
> +        */
> +       if (suspend_fs_sync_queued) {
> +               need_suspend_fs_sync_requeue =3D true;
> +       } else {
> +               need_suspend_fs_sync_requeue =3D false;
> +               suspend_fs_sync_queued =3D true;
> +               schedule_work(&sync_filesystems);
> +       }
> +       spin_unlock(&suspend_fs_sync_lock);
> +
> +       /*
> +        * Completion is triggered by fs_sync finishing or a suspend abor=
t
> +        * signal, whichever comes first
> +        */
> +       wait_for_completion(&suspend_fs_sync_complete);
> +       if (pm_wakeup_pending())
> +               return -EBUSY;
> +       if (need_suspend_fs_sync_requeue)
> +               goto Start_fs_sync;
> +
> +       return 0;
> +}
> +
>  /**
>   * suspend_enter - Make the system enter the given sleep state.
>   * @state: System sleep state to enter.
> @@ -590,8 +671,10 @@ static int enter_state(suspend_state_t state)
>
>         if (sync_on_suspend_enabled) {
>                 trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> -               ksys_sync_helper();
> +               error =3D suspend_fs_sync_with_abort();
>                 trace_suspend_resume(TPS("sync_filesystems"), 0, false);
> +               if (error)
> +                       goto Unlock;
>         }
>
>         pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[s=
tate]);
> --
> 2.51.0.rc1.167.g924127e9c0-goog
>

