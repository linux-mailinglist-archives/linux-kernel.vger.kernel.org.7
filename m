Return-Path: <linux-kernel+bounces-771367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C241AB28621
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B777F566D45
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD3C1E231E;
	Fri, 15 Aug 2025 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gwa62D3O"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953F9E571
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755284644; cv=none; b=o/kxoV2/HQbw7BOh1+4/87LLBGo6TfDtiEWfNhmZmr+4E6N/naclKTFQuqHEVWX8ltN1wFz8tJmBODWUnfgVcT05LenTQJpcSsxcJthCjm0ET/8f3BBm25x9z1zNTk8squrGKsIwhF1IUBEy+M3sZN4ahXexZskzrHphWdY7NNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755284644; c=relaxed/simple;
	bh=IdGKjYusAWxO3GhNwNyO5nA/vWlN8g7dp/Hyc4voRjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OiIkgNr4Ly7vfmB/9CW8jc5aGMCMRGhbhNo9RaKUwQh52MdHR23Gf2CPNpb9gKuqr08V3XN4vbrZDqrqazknwGi0C3lusnEdmbq2ye5/oSWcfwtHDaCU+XZ2UgUD4J835f/a21VJGng01uTJx1FHsmJxORM3aRX852HJBKRuS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gwa62D3O; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb78c66dcso325780966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 12:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755284641; x=1755889441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ot9kwbdRBQrXKAmF1f6A9v5tTsNpHkW6/cReT63iuQ=;
        b=gwa62D3O1XnMm9Z1YxBdFB0Yh2+Gt6uCEJ343wfcIiYxZG4TRGIAXAk9zzuV+Rbsi1
         kn3Rjp2/b30pj2MP7UxcHWyeh/2i8pRm9jo5qizFpR3TcTzVaPE2D4wluoeMQibrmWiu
         b2Y67+i+kbvtWpXb0z65f5/Dhoj0g5mZtCOSdxZ04dRVZ1vMrwIUlqNBJgN1n8jPwxuZ
         BgBV4HKdSfgJKYlY0IqMEjcR9UxL0l9hYGRXwJaGt7c/Mv4daNXOvdtIHK5Nyoy24I/L
         Z2M5HLfHbTnO2dLvu9jeSC0B+tw3ZSSLEBULCyAosHJ88zYi4zsmgVJp0ENm5SqDd+bH
         oH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755284641; x=1755889441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ot9kwbdRBQrXKAmF1f6A9v5tTsNpHkW6/cReT63iuQ=;
        b=k5DPnjyRTgLaPPPaoAAxnuiaM0FkRY+cPP7CugE52odXZywqNgC19/MDgsdyBq8TRD
         9F4MbmplVwMMSGuJ6geac6snGra7ziTJzfqxRPQI1wN7R+vz6cbkSHqlTmUrZkGIntpx
         Dn+SwSpd6HKX78amDk52kfi0176XZQ1NfIkj+1EbKXQAhiQWWHpBeEvXgG4xkGZu/eWR
         +gUciDsogK9MgXn6LCF+YdCUvKlPHm9eKqYbjzLaVgfbiw7Xk/0Lzx2tdF5kG68mEbFH
         EgsIAkAc9Y/tjEP1RkTyz9G+cdTRoNtE5NmQga7KvbyhtLZTCxDWAGo3UThPWissTUyj
         VKUg==
X-Forwarded-Encrypted: i=1; AJvYcCVk5F23A7sl5lffdN31tM3nqvwNTYsGvkV0uVra61QNutclp331qOC/qB0kq2oyDBDb3Cmb+VWhXeRv8SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxstAxyO6Ihid4AcTq03Q1yEWle0X9SmUphjGz6Hqnj61Ce1VAn
	3rD+jM3MfCc1k7YACGJxP92XCl4KkIMF6VuDuFSWRP8uCYhy9I/mDx8jRgrfH7rmQ32OE/GPOV1
	2ZgBmWboNJVQCE3A6mRDWH08WlLsV4e62a5+N2+VP
X-Gm-Gg: ASbGncvkpV8lewuC/QEVUa2JEUX5Ey3KTbmRUZauNb1iz3u6er+Xwz4LV4IU8Q23MPY
	K8rWTPD2yEQylgS/Q0es2da5H+v/SBWPoKkp+AL3eb0Xia0GhTIqaiP7LuFpGeS60x+ldIxN9Rg
	izJ9awfB6qP97Zp+kLvsB2sGZFhLIV45QpcKGFrR1AP+LwZx8MWWbn5/jzrwE2ewnBFknZHUr3H
	Cvv4ubIZJHwrTwulsaTJqit/UqE2ZDA6gRj4XV5/RAZ
X-Google-Smtp-Source: AGHT+IFUwcOZYe7GemOK5mz92sxB+UnQmSLaHqsI7eNMgTWM8WkMYvFa8P7uF7az7Tb71f5b/r1TsRCe7BdGYKgrvV8=
X-Received: by 2002:a17:907:3c88:b0:ae3:5185:541a with SMTP id
 a640c23a62f3a-afceae9fd2fmr3087866b.54.1755284640698; Fri, 15 Aug 2025
 12:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815004635.3684650-1-wusamuel@google.com> <2025081538-grappling-crewmate-8cf5@gregkh>
In-Reply-To: <2025081538-grappling-crewmate-8cf5@gregkh>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 15 Aug 2025 12:03:49 -0700
X-Gm-Features: Ac12FXzQSC2Mt76YZH7KdgDV1IYdWVMg-dO55UvpZyzBXy2tCLZi2CKEsxpdYYo
Message-ID: <CAG2KctozO9cVeS5KO8o_S04u7uhbTzheFLE8r9mBXTW7nwnQOw@mail.gmail.com>
Subject: Re: [PATCH v2] PM: Support aborting suspend during filesystem sync
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Saravana Kannan <saravanak@google.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 11:20=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 14, 2025 at 05:46:34PM -0700, Samuel Wu wrote:
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
> > ---
> >  drivers/base/power/wakeup.c |  8 ++++
> >  include/linux/suspend.h     |  3 ++
> >  kernel/power/process.c      |  1 -
> >  kernel/power/suspend.c      | 85 ++++++++++++++++++++++++++++++++++++-
> >  4 files changed, 95 insertions(+), 2 deletions(-)
> >
> > v1 -> v2:
> > - Added documentation for suspend_abort_fs_sync()
> > - Made suspend_fs_sync_lock and suspend_fs_sync_complete declaration st=
atic
> >
> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > index d1283ff1080b..304368c3a55f 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -570,6 +570,13 @@ static void wakeup_source_activate(struct wakeup_s=
ource *ws)
> >
> >       /* Increment the counter of events in progress. */
> >       cec =3D atomic_inc_return(&combined_event_count);
> > +     /*
> > +      * To maintain the same behavior as pm_wakeup_pending(),
> > +      * aborting suspend will only happen if events_check_enabled. Sim=
ilarly,
> > +      * the abort during fs_sync needs the same check.
> > +      */
> > +     if (events_check_enabled)
> > +             suspend_abort_fs_sync();
> >
> >       trace_wakeup_source_activate(ws->name, cec);
> >  }
> > @@ -899,6 +906,7 @@ EXPORT_SYMBOL_GPL(pm_wakeup_pending);
> >  void pm_system_wakeup(void)
> >  {
> >       atomic_inc(&pm_abort_suspend);
> > +     suspend_abort_fs_sync();
> >       s2idle_wake();
> >  }
> >  EXPORT_SYMBOL_GPL(pm_system_wakeup);
> > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > index 317ae31e89b3..21b1ea275c79 100644
> > --- a/include/linux/suspend.h
> > +++ b/include/linux/suspend.h
> > @@ -276,6 +276,8 @@ extern void arch_suspend_enable_irqs(void);
> >
> >  extern int pm_suspend(suspend_state_t state);
> >  extern bool sync_on_suspend_enabled;
> > +
> > +extern void suspend_abort_fs_sync(void);
> >  #else /* !CONFIG_SUSPEND */
> >  #define suspend_valid_only_mem       NULL
> >
> > @@ -296,6 +298,7 @@ static inline bool idle_should_enter_s2idle(void) {=
 return false; }
> >  static inline void __init pm_states_init(void) {}
> >  static inline void s2idle_set_ops(const struct platform_s2idle_ops *op=
s) {}
> >  static inline void s2idle_wake(void) {}
> > +static inline void suspend_abort_fs_sync(void) {}
> >  #endif /* !CONFIG_SUSPEND */
> >
> >  static inline bool pm_suspend_in_progress(void)
> > diff --git a/kernel/power/process.c b/kernel/power/process.c
> > index dc0dfc349f22..8ff68ebaa1e0 100644
> > --- a/kernel/power/process.c
> > +++ b/kernel/power/process.c
> > @@ -132,7 +132,6 @@ int freeze_processes(void)
> >       if (!pm_freezing)
> >               static_branch_inc(&freezer_active);
> >
> > -     pm_wakeup_clear(0);
> >       pm_freezing =3D true;
> >       error =3D try_to_freeze_tasks(true);
> >       if (!error)
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index b4ca17c2fecf..dc37ab942bcb 100644
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
> > @@ -74,6 +75,21 @@ bool pm_suspend_default_s2idle(void)
> >  }
> >  EXPORT_SYMBOL_GPL(pm_suspend_default_s2idle);
> >
> > +static bool suspend_fs_sync_queued;
> > +static DEFINE_SPINLOCK(suspend_fs_sync_lock);
> > +static DECLARE_COMPLETION(suspend_fs_sync_complete);
> > +
> > +/**
> > + * Triggers the completion that aborts suspend. This completion will o=
nly have
> > + * an effect if called during filesystems sync step of suspend.
> > + */
> > +void suspend_abort_fs_sync(void)
>
> This is not kerneldoc format, I think the parser will fail on it, right?
> Have you tried building the kernel documentation with this patch
> applied?

You're right, I will update to the proper format in v3. Moving forward, I'l=
l add
kernel-doc.pl to my validation workflow; I was only using checkpatch.pl and
extra gcc checks.

> > +{
> > +     spin_lock(&suspend_fs_sync_lock);
> > +     complete(&suspend_fs_sync_complete);
> > +     spin_unlock(&suspend_fs_sync_lock);
> > +}
> > +
> >  void s2idle_set_ops(const struct platform_s2idle_ops *ops)
> >  {
> >       unsigned int sleep_flags;
> > @@ -403,6 +419,71 @@ void __weak arch_suspend_enable_irqs(void)
> >       local_irq_enable();
> >  }
> >
> > +static void sync_filesystems_fn(struct work_struct *work)
> > +{
> > +     ksys_sync_helper();
> > +
> > +     spin_lock(&suspend_fs_sync_lock);
> > +     suspend_fs_sync_queued =3D false;
> > +     complete(&suspend_fs_sync_complete);
> > +     spin_unlock(&suspend_fs_sync_lock);
> > +}
> > +static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
> > +
> > +/**
> > + * suspend_fs_sync_with_abort- Start filesystem sync and handle potent=
ial aborts
> > + *
> > + * Starts filesystem sync in a workqueue, while the main thread uses a
> > + * completion to wait for either the filesystem sync to finish or for =
a wakeup
> > + * event. In the case of filesystem sync finishing and triggering the
> > + * completion, the suspend path continues as normal. If the complete i=
s due to a
> > + * wakeup or abort signal, the code jumps to the suspend abort path wh=
ile the
> > + * filesystem sync finishes in the background.
> > + *
> > + * An aborted suspend that is followed by another suspend is a potenti=
al
> > + * scenario that complicates the sequence. This patch handles this by
> > + * serializing any filesystem sync; a subsequent suspend's filesystem =
sync
> > + * operation will only start when the previous suspend's filesystem sy=
nc has
> > + * finished. Even while waiting for the previous suspend's filesystem =
sync to
> > + * finish, the subsequent suspend will still break early if a wakeup c=
ompletion
> > + * is triggered, solving the original issue of filesystem sync blockin=
g abort.
> > + */
>
> Shouldn't this documentation go up in the public one?
>
> thanks,
>
> greg k-h

I felt this doc was appropriate here as suspend_fs_sync_with_abort() does t=
he
main lifting of the feature. I'm perfectly fine moving it if that way is mo=
re
clear or is the convention.

Appreciate the feedback.

-- Samuel Wu

