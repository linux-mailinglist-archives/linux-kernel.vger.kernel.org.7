Return-Path: <linux-kernel+bounces-834942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD285BA5E26
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98CBC3B7987
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73C82DF3CC;
	Sat, 27 Sep 2025 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="x25jAKr1"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11CE19EEC2
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758971442; cv=none; b=kesKnuHVD7hO7V2ckeVr5Nzzy/9vNzNkPpXP9VaugfA2pRTGW4++7U9ake1MdawAJaElxEGUDNhAd2R0ddjL1Mogb+zQwM1X0IaM7tycsyeKvTa3ds/G8M4t226C4OQppwMFpjvwUnZkA+Bmxdh+SUuI9pk0IyxzNG1f380WEws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758971442; c=relaxed/simple;
	bh=O5NAzpdbNeFqW7wKbXQ9QCzukeipdiB/SYrAACVbp2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZONyOGfzyZteF1tQ3PiSjRJzZRClOMO8skPVqjjfHZM4EcqTnjNgIhuH14WWHQT1WpW93mUp8Vza+ie6zbNEofk5qO+lHwW9lHbzW7bkdoRVFj37BDzBQDCcWY9VCHIvtXs1O0Wj6x47p+tXG64Lz2mI2hasOYEY+duUc+cYim4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=x25jAKr1; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-426f9f275b2so8372905ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 04:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1758971440; x=1759576240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nZ9V8CAECGoNuba4+1p1zk8NcrJcFYqCvXjYD4m4DDI=;
        b=x25jAKr1+XRCOZo2bmkJWDInn+hGlMYR10ed+RJtFFAhtMMn32N9A6bBP3MWSjR7IW
         3b8fzzAL+5KMP7dlZLZ72GpNk1COAykqfiX6sUL0LeMwizTLRh/+NYPLv16LGiw5IEid
         WfP5IkoY8xBFDROvp+J3JNo7tztaYrqfTsIyeudp4r4KN5o1d6+bhK0l3fhPIgGu3gNf
         X939pzZm8FhPDS+1fW8C9sESSjti+65Hc/FTD1yuVD9TgiYsNhgW8WpyYDiKXJ6pGSeI
         5LDLtWKToOt7xjXWqbFN+SkvaLxScqQPtng2LBvGKflg1LLIeHq/2cRGWM6gk/DpLlLe
         +gRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758971440; x=1759576240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZ9V8CAECGoNuba4+1p1zk8NcrJcFYqCvXjYD4m4DDI=;
        b=RWJHEnDjpjMlNmACNGOagg3VUfVXclHyJF+ozsYj6wzNIWIoYJP9EZfdX0youGlhx6
         oDwayE4cBK2VmU0rd+h1GA4Cl5zSO7KHWi0R1KejynJIdDgTrODa3yUvReFzUNjrMES5
         GzPQ1LdhrrpvmGvFe2cXNRXnqquSPW73n3oqyMB7JG9ZpQSJcF/3/Bmg2QUTRoYl9Xsx
         gtQJ1KQYpySWBrKWiNWZsJCJH0Cc0IVwn8EHTUjohFIRVeVoN0gm6XsYMoexBA4gddgj
         VhhZeM8Q6xwhgMshc+29v/NVPdpuNYg5c9Z0bDKLAvYe9CSyCqlie0Q44V13oM1CEHuq
         H5XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmscHMSNrGX0qZKRXJjOAjG2wy3SwFkiLKI2pzYK7XDrWBIwwz+5fMjY87UizV7fKIfF66QKr0NbvCI4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8eD+aGdiRxJQeWyC+d/JU7o5qFKHlt1ouRvEm+dRMYVQlkIoF
	dPKdO1AJohYr3dMCbAtF75BoKvf4rui/5BBKOIPwgTxpVrtK6c6cxaebguhV8taaMnCzv4j0a6z
	DBdIVUBXVWBJzTfywL7mB56270D3BQlArOKy+LFsFzeUotBc8499PKLRtI08W
X-Gm-Gg: ASbGncvHfjWAFBtyiNroekdDtgYb2a1sBKN+oNRdl0gOattUeEE395PtGh93dHOH4Jd
	l+ozg9V6icpw0FsEGbCZgwctjAq5O36NLvSOFxfXEb/f98I+oYDeXZaAcNL90lC7TEYM7rMq1lY
	/Xik8aQbDA3qyyAwxx6ZzcOpMVrMX4C8s+vkB1flIBsTjMbd31Px6O/u6FshTBpZHD/f4CFgdHQ
	BY14rCqMU6eFRfS36V7xq+TpjFEj6703/gXfoI3
X-Google-Smtp-Source: AGHT+IFUCILED/nkIkmGj+vvB8lq1JY5GUH/g9IRIKI2l2s57vfCR27ai5cxsjlP5/768SQ1ASkIh/pfqG1e8TOPr3Y=
X-Received: by 2002:a05:6e02:184e:b0:425:8857:6e3c with SMTP id
 e9e14a558f8ab-425955f47f9mr148657855ab.11.1758971439652; Sat, 27 Sep 2025
 04:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk>
 <20250915-printk_legacy_thread_console_lock-v1-1-f34d42a9bcb3@thegoodpenguin.co.uk>
 <aMwjmJOVP5QW4rtD@pathway.suse.cz> <CALqELGypek7O5y9HCP1p_MeYZCmd4EeyHks+QJ_2tqUe6wZ=fQ@mail.gmail.com>
 <aNKhAVy6h7g_59OX@pathway.suse.cz>
In-Reply-To: <aNKhAVy6h7g_59OX@pathway.suse.cz>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Sat, 27 Sep 2025 12:10:28 +0100
X-Gm-Features: AS18NWARI2Hd76Dz0LFgIt_LO6gYSVOptE_w7aGtq1blgYsNXKmpCdHB6dl7mFc
Message-ID: <CALqELGz7yXi0GbNcsq+_esC9OQY-SKwg9QzsaHU_KsHBnrc9WQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] printk: Introduce console_flush_one_record
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 14:30, Petr Mladek <pmladek@suse.com> wrote:
>
> On Fri 2025-09-19 14:06:24, Andrew Murray wrote:
> > On Thu, 18 Sept 2025 at 16:22, Petr Mladek <pmladek@suse.com> wrote:


> > Thus to preserve functionality, I'd need to additionally add these changes:
> >
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 75a3c47e9c0e..060d4919de32 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3193,7 +3193,6 @@ static bool console_flush_one_record(bool
> > do_cond_resched, u64 *next_seq, bool *
> >         bool any_progress;
> >         int cookie;
> >
> > -       *any_usable = false;
> >         any_progress = false;
> >
> >         printk_get_console_flush_type(&ft);
> > @@ -3281,7 +3280,7 @@ static bool console_flush_one_record(bool
> > do_cond_resched, u64 *next_seq, bool *
> >   */
> >  static bool console_flush_all(bool do_cond_resched, u64 *next_seq,
> > bool *handover)
> >  {
> > -       bool any_usable;
> > +       bool any_usable = false;
> >         bool any_progress;
> >
> >         *next_seq = 0;
> >
> > Are you happy for me to keep your reviewed-by with these changes?
>
> Feel free to do this in v2 and keep my reviewed-by.
> It is always better to reshufle a code without changing
> the behavior.

No problem, I've squashed the above into a v2 of this first patch.

I've also included the reverse of this change into your cleanup patch,
thus ensuring we set any_usable to false at the start of
console_flush_one_record, as suggested.


>
> > > > -                     /*
> > > > -                      * console_flush_all() is only responsible for nbcon
> > > > -                      * consoles when the nbcon consoles cannot print via
> > > > -                      * their atomic or threaded flushing.
> > > > -                      */
> > > > -                     if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
> > > > -                             continue;
> > > > -
> > > > -                     if (!console_is_usable(con, flags, !do_cond_resched))
> > > > -                             continue;
> > > > -                     any_usable = true;
> > > > -
> > > > -                     if (flags & CON_NBCON) {
> > > > -                             progress = nbcon_legacy_emit_next_record(con, handover, cookie,
> > > > -                                                                      !do_cond_resched);
> > > > -                             printk_seq = nbcon_seq_read(con);
> > > > -                     } else {
> > > > -                             progress = console_emit_next_record(con, handover, cookie);
> > > > -                             printk_seq = con->seq;
> > > > -                     }
> > > > -
> > > > -                     /*
> > > > -                      * If a handover has occurred, the SRCU read lock
> > > > -                      * is already released.
> > > > -                      */
> > > > -                     if (*handover)
> > > > -                             return false;
> > > > -
> > > > -                     /* Track the next of the highest seq flushed. */
> > > > -                     if (printk_seq > *next_seq)
> > > > -                             *next_seq = printk_seq;
> > > > -
> > > > -                     if (!progress)
> > > > -                             continue;
> > > > -                     any_progress = true;
> > > > -
> > > > -                     /* Allow panic_cpu to take over the consoles safely. */
> > > > -                     if (other_cpu_in_panic())
> > > > -                             goto abandon;
> > > > +             if (*handover)
> > > > +                     return false;
> > > >
> > > > -                     if (do_cond_resched)
> > > > -                             cond_resched();
> > > > -             }
> > > > -             console_srcu_read_unlock(cookie);
> > > > +             if (other_cpu_in_panic())
> > > > +                     return false;
> > > >       } while (any_progress);
> > > >
> > > >       return any_usable;
> > >
> > > The semantic of the function was always complicated. It results
> > > into duplicated checks in the callers.
> >
> > Yes, I've found this confusing.
> >
> > any_usable is used by callers for different purposes. For
> > __console_flush_and_unlock, its used to determine if its possible to
> > try and do more work (i.e. to check if they should bother attempting
> > to print messages which may have been added between flush and
> > unlock)
>
> This implements a historic approach when the current console_lock
> owner is responsible for flushing all pending messages.
>
> It makes sure that all messages are flushed to the console.
> And parallel printk() does not need to wait for console_lock.
>
> The "try and do more work" handles the following race:
>
> CPU0                            CPU1
>
> printk()
>
>   console_trylock()
>   console_unlock()
>     __console_flush_and_unlock()
>       console_flush_all()
>
>                                 printk()
>                                 console_trylock()
>                                   # fails because console_sem
>                                   # is still owned by CPU0
>
>
>       __console_unlock()
>
> Problem: Nobody owns console_lock but the message added by
>          CPU1 has not been flushed yet.
>
> Solution: The last owner must check whether there is a new
>           message after releasing console_lock. And it must
>           try to flush it.
>
>           The try_lock might fail when another CPU gets
>           the console_lock in the meantime. But it is fine.
>           The new owner will flush the message then.
>
>
> > - i.e. useable consoles exist but also no panics or handovers have
> > happened.
>
> These are situations when this context is not longer responsible
> for flushing the rest because:
>
>    + there are no usable consoles.
>
>    + non-panic CPUs are going to be stopped. And the messages
>      will get flushed by panic CPU, either by printk() called
>      on panic CPU or by explicit flush in panic().
>
>    + the console_lock ownership has been passed to another
>      CPU via console_trylock_spinning(). The new owner will
>      flush the pending messages. It helps to reduce the risk
>      of softlockup reports with this historic approach.
>
>
> > For get_init_console_seq it is used to determine if init_seq
> > was updated.
>
> I would rather say that it is used to determine whether init_seq
> has a reliable value. Where reliable means that it flushed and
> checked all usable consoles.
>
> Note that this value is use to prevent duplicate output when
> a proper console driver replaces an early console driver.
>
> We are not able to detect which early/proper drivers are using
> the same physical device => it is better to flush all consoles
> and use the last next_seq which should be the same on all consoles.
>
>
> > The comment for console_flush_all says:
> >
> >  * Returns true when there was at least one usable console and all messages
> >  * were flushed to all usable consoles.
> >
> > But I don't think that's true. It returns true when there was at least
> > one usable console and at least one message was attempted to be
> > written (I guess nbcon_legacy_emit_next_record or
> > console_emit_next_record could bail out before writing its message).
> > Unless I'm missing some assumptions about what can change in
> > iterations of the do/while loop.
>
> The "bail out" should be detected. This is why console_flush_all()
> explicitly returns "false" in the following situations:
>
>   + handover happened
>   + other_cpu_in_panic() returns true
>   + both any_progress and any_usable are false
>
> Hmm, I agree that the last case is not 100% correct:
>
>   1. The original code did not reset any_usable in each cycle.
>      It might be true even when all usable consoles have been
>      disabled in the meantime.
>
>      Well, it is a corner case and should not cause problems.
>
>      In the worst case, console_unlock() will do one more
>      cycle (try_lock + console_flush_all) and the new
>      console_flush_all() would return false because
>      there won't be any usable console
>
>      This problem should not happen with get_init_console_seq()
>      because it is called under console_list_lock. Consoles
>      could not be disabled in parallel.
>
>      This will actually be fixed by resetting "any_usable" in
>      each cycle.
>
>
>    2. "any_progress" is set to true when at least one console
>       made progress.
>
>       It is not a big deal:
>
>         + console_flush_all() would explicitly return false when
>           there was a handover or other_cpu_in_panic()
>           returned true.
>
>         + console_emit_next_record() always finishes the job
>           when there is a pending message.
>
>         + nbcon_legacy_emit_next_record() might lose the owner
>           ship. But the new owner will become responsible for
>           flushing everything. And console_flush_all() would
>           try one more cycle...
>
>       It seems to be working correctly in all situations after all.

Thanks for the explanations, much appreciated.


>
>
> > > I think that we could do slightly better in this particular case.
> > > But I would do the refactoring in a separate patch to make this
> > > one easier for review.
> > >
> > > I played with the code and came up with:
> > >
> > > From 7a3c930a12d7c0157f404a4a834d1f92f3070799 Mon Sep 17 00:00:00 2001
> > > From: Petr Mladek <pmladek@suse.com>
> > > Date: Thu, 18 Sep 2025 16:57:58 +0200
> > > Subject: [RFC] printk: console_flush_one_record() code cleanup
> > >
> > > console_flush_one_record() and console_flush_all() duplicate several
> > > checks. They both want to tell the caller that consoles are not
> > > longer usable in this context because it has lost the lock or
> > > the lock has to be reserved for the panic CPU.
> > >
> > > Pass this information by clearing the @any_usable parameter value
> > > which has the same effect.
> > >
> > > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > > ---
> > >  kernel/printk/printk.c | 20 +++++++++-----------
> > >  1 file changed, 9 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > index 53daab5cdee5..2cceedcc3d34 100644
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -3175,7 +3175,8 @@ static inline void printk_kthreads_check_locked(void) { }
> > >   * console_lock, in which case the caller is no longer holding the
> > >   * console_lock. Otherwise it is set to false.
> > >   *
> > > - * @any_usable will be set to true if there are any usable consoles.
> > > + * @any_usable will be set to true if there are any usable consoles
> > > + * in this context.
> > >   *
> > >   * Returns true when there was at least one usable console and a record was
> > >   * flushed. A returned false indicates there were no records to flush for any
> > > @@ -3230,7 +3231,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
> > >                  * is already released.
> > >                  */
> > >                 if (*handover)
> > > -                       return false;
> > > +                       goto unusable;
> > >
> > >                 /* Track the next of the highest seq flushed. */
> > >                 if (printk_seq > *next_seq)
> > > @@ -3242,7 +3243,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
> > >
> > >                 /* Allow panic_cpu to take over the consoles safely. */
> > >                 if (other_cpu_in_panic())
> > > -                       goto abandon;
> > > +                       goto unusable_srcu;
> > >
> > >                 if (do_cond_resched)
> > >                         cond_resched();
> > > @@ -3251,8 +3252,10 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
> > >
> > >         return any_progress;
> > >
> > > -abandon:
> > > +unusable_srcu:
> > >         console_srcu_read_unlock(cookie);
> > > +unusable:
> > > +       *any_usable = false;
> >
> > I'm struggling to understand this. I think your intention is to start
> > with any_usable being true (which would have to be set in
> > console_flush_all)
>
> No, my intention is to start with @any_usable set to "false".
>
> It would be set to "true" only when console_is_usable() returned
> true for at least one console.
>
> And it would be set back to "false" when the function was not
> able to finish the job (bailed out) because:
>
>     + handover
>     + other_cpu_in_panic()
>
> By other words, the variable @any_usable would have the same
> semantic as console_flush_all() return value.

Thanks for explaining, I'm happy with this patch now, I've rebased it
onto my series. As suggested, I've updated it to ensure any_usable is
false at the start of console_flush_one_record.


>
> Maybe, we could rename the variable to "flushed". It would
> be set to "true" when the function was able to flush on
> all usable consoles and when it was not interrupted.

Thanks,

Andrew Murray

