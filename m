Return-Path: <linux-kernel+bounces-828998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55091B9603A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563E419C1FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E38832275D;
	Tue, 23 Sep 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e3V9Ap00"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5877A13A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634249; cv=none; b=VCTnr7lmgyaVMUX6zaMDd5//lGvN+opK4NTosXBolmJiG5Tk6qkGVd2EhtPijemrquNWKReomUso5NQjPgXq6qTW4ZNjY+EsfCMDMAx+Hjd/FINCusjHWgexF14/ARKHlznXW6XhioYpqAZlHirb4XriLqW8cDT5mmLqFsCmC7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634249; c=relaxed/simple;
	bh=PcwOdwZQjvOMQiRaOBuBTWNHe9HG2iU7IQsHo88pg2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foXU97PyQNPd52XfqG4y5i7FeT3vzcUy9/Zl0bEIFHSzwfAjMb30FG2A59g51A+sw5iTEF8ZpWsedcEdTIIPHLaqfae5G4nvjQ100ogb8TEOTXJMeFq1Yaw5+4jwxoCn7D7r4INc22pVWjFj8zcZtBU3+7ewFg/GALYFbUvgGA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e3V9Ap00; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b29ebf9478bso370380066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758634245; x=1759239045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGmf0b/uKQ6a2kDXVv/frKdgH5dec1z22mBtMfyQWlg=;
        b=e3V9Ap00mbHBBYkZldBjuJorH+A7aG2oRoW5DzEyZf0oJUcTXJDXV6RCq9+Xshf8ya
         CVo8ObtyyDMxAijaCQlzkTn/T0QvsrzWxwGUD2ano/X5wNUegIdGMlffp89gg8sNwwEe
         L/5jj1jgJOI7qbtUGTB90t1vvfO1rYsu9FNfO3BVYb2KGc6azqvdL+3y03AcXZxV1GJR
         v/Px1Rg0CKZevztBWjdH+iXtXfAFpvq6TY6W14leShxedtqEjWOGuflKoKaGTtJKiBa4
         e+p2A3LTCjW4AkmXICyNvOWXE2brI/59AzwWGMET7jhz6eq0PeqktSvmbSiraR4eGdT0
         UjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758634245; x=1759239045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGmf0b/uKQ6a2kDXVv/frKdgH5dec1z22mBtMfyQWlg=;
        b=QkZcdkTz4dGf5l4wWq677uYZBmngmsdYsf0B4GpBI4fNSF2lYhwpPDF2KmVr1toXmm
         dUv/KeHU56fTxB7FDxWzA26E0mS02ZER5Sa1gkErNQRLbd9Pm+I+WVrVOo3lg5Kzq74D
         Z3XtLLhdgNiHkIysXhyai2XGYjb7HW4Zacpj9M0d+TVC7/Zj9CrGSzv55Pm8884kwV+T
         jBlWiEDFsl5xxobJ4F/tCzewcsc5vsBAfwoJtHE1OTOc/H+FKqlDIezU7JrchTGwiRk3
         b1F93vhiQX3BlUNT5LIDW+oZcyYRHoE18ww5XI0TaAuLM3/LByJr1jYzXGSEaxwyB66m
         6O7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCl/IlD5PvQTdTp0LVgOOv+FzqMaRGL8RbACFE9ny4bwuVF1tUknjlxkhwQVFwzb9fn7zwhd09Cfur+1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMcgdA/bV31UmBnwnzNF7zmQY3W/7khbX2dVYDCm569FW/MF+P
	Oe4qT4PToUahk3wii0WvjAsigObcDe9cGi+5hwVdI8y103zdKR+A8vY556OwnqSlxNw=
X-Gm-Gg: ASbGncvnM+ZmTatdrmbCLtepvemL7S6sKpLRYAKyDi7ho2LpYIpPZqbSi8wbRr62MJ7
	pGjJWWFvFqGcnCaFYiqoWDNi1krqhipYu9tiHJjyRkziFcO3CioKiPbdV27KaNlXEnQN2rs5Axy
	FNX5MYcmpcR70RzKvJPRgXpzqss/oiDV6bRiBmV+FJkgjYYh5hPCFpHfIexVzE4oyT6SsVqtEph
	BuZff6ff9jvjuaVHVQSq9pW1sVe/iN7hiLazy0la/ZYhlTX9xuTMHmmEWqbIIV8/+YJpISVZBfU
	HaqMyVKTYzh+pjyqjYF5iejtjppL5KMKpeL2jtaKVMgSyAEA+v0YPpmpXalF41LXjJsMBLUx+ja
	KLfaN9lywrWf+zmC2IOiSvIx2NA==
X-Google-Smtp-Source: AGHT+IGIV0TN7/aUIkO4hRehOnkmqXbtB5LkFp37xOhngb1KF73b9gMSQqI4KFGjyT0MdCv9BMwbAQ==
X-Received: by 2002:a17:907:9628:b0:ad8:914b:7d0b with SMTP id a640c23a62f3a-b30263b2f16mr245669466b.11.1758634244425;
        Tue, 23 Sep 2025 06:30:44 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5f121f2sm10766747a12.28.2025.09.23.06.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:30:43 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:30:41 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] printk: Introduce console_flush_one_record
Message-ID: <aNKhAVy6h7g_59OX@pathway.suse.cz>
References: <20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk>
 <20250915-printk_legacy_thread_console_lock-v1-1-f34d42a9bcb3@thegoodpenguin.co.uk>
 <aMwjmJOVP5QW4rtD@pathway.suse.cz>
 <CALqELGypek7O5y9HCP1p_MeYZCmd4EeyHks+QJ_2tqUe6wZ=fQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALqELGypek7O5y9HCP1p_MeYZCmd4EeyHks+QJ_2tqUe6wZ=fQ@mail.gmail.com>

On Fri 2025-09-19 14:06:24, Andrew Murray wrote:
> On Thu, 18 Sept 2025 at 16:22, Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Mon 2025-09-15 13:43:05, Andrew Murray wrote:
> > > console_flush_all prints all remaining records to all usable consoles
> > > whilst its caller holds console_lock. This can result in large waiting
> > > times for those waiting for console_lock especially where there is a
> > > large volume of records or where the console is slow (e.g. serial).
> > >
> > > Let's extract the parts of this function which print a single record
> > > into a new function named console_flush_one_record. This can later
> > > be used for functions that will release and reacquire console_lock
> > > between records.
> > >
> > > This commit should not change existing functionality.
> > >
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -3186,77 +3281,24 @@ static inline void printk_kthreads_check_locked(void) { }
> > >   */
> > >  static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
> > >  {
> > > -     struct console_flush_type ft;
> > > -     bool any_usable = false;
> > > -     struct console *con;
> > > +     bool any_usable;
> > >       bool any_progress;
> > > -     int cookie;
> > >
> > >       *next_seq = 0;
> > >       *handover = false;
> > >
> > >       do {
> > > -             any_progress = false;
> > > -
> > > -             printk_get_console_flush_type(&ft);
> > > -
> > > -             cookie = console_srcu_read_lock();
> > > -             for_each_console_srcu(con) {
> > > -                     short flags = console_srcu_read_flags(con);
> > > -                     u64 printk_seq;
> > > -                     bool progress;
> > > +             any_progress = console_flush_one_record(do_cond_resched, next_seq, handover,
> > > +                                                     &any_usable);
> 
> Ah, there was an error in my patch. Previously console_flush_all would
> set any_usable to false at the start, and then set it to true if any
> usable consoles were seen whilst printing any of the records. My
> changes resulted in any_usable being set to false on each entry of
> console_flush_one_record - thus effectively only indicating if any
> consoles were usable for *only* the last record.

I noticed the change but I considered it cosmetic. In fact, I think
that it is better to reset the value in each cycle and return the value
reflecting the current situation.

If I get it correctly, it should not have any bad consequences.
In the worst case, we would return false when the last usable
console was disabled. It actually looks like the right value
for all callers.

> Thus to preserve functionality, I'd need to additionally add these changes:
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 75a3c47e9c0e..060d4919de32 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3193,7 +3193,6 @@ static bool console_flush_one_record(bool
> do_cond_resched, u64 *next_seq, bool *
>         bool any_progress;
>         int cookie;
> 
> -       *any_usable = false;
>         any_progress = false;
> 
>         printk_get_console_flush_type(&ft);
> @@ -3281,7 +3280,7 @@ static bool console_flush_one_record(bool
> do_cond_resched, u64 *next_seq, bool *
>   */
>  static bool console_flush_all(bool do_cond_resched, u64 *next_seq,
> bool *handover)
>  {
> -       bool any_usable;
> +       bool any_usable = false;
>         bool any_progress;
> 
>         *next_seq = 0;
> 
> Are you happy for me to keep your reviewed-by with these changes?

Feel free to do this in v2 and keep my reviewed-by.
It is always better to reshufle a code without changing
the behavior.

> > > -                     /*
> > > -                      * console_flush_all() is only responsible for nbcon
> > > -                      * consoles when the nbcon consoles cannot print via
> > > -                      * their atomic or threaded flushing.
> > > -                      */
> > > -                     if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
> > > -                             continue;
> > > -
> > > -                     if (!console_is_usable(con, flags, !do_cond_resched))
> > > -                             continue;
> > > -                     any_usable = true;
> > > -
> > > -                     if (flags & CON_NBCON) {
> > > -                             progress = nbcon_legacy_emit_next_record(con, handover, cookie,
> > > -                                                                      !do_cond_resched);
> > > -                             printk_seq = nbcon_seq_read(con);
> > > -                     } else {
> > > -                             progress = console_emit_next_record(con, handover, cookie);
> > > -                             printk_seq = con->seq;
> > > -                     }
> > > -
> > > -                     /*
> > > -                      * If a handover has occurred, the SRCU read lock
> > > -                      * is already released.
> > > -                      */
> > > -                     if (*handover)
> > > -                             return false;
> > > -
> > > -                     /* Track the next of the highest seq flushed. */
> > > -                     if (printk_seq > *next_seq)
> > > -                             *next_seq = printk_seq;
> > > -
> > > -                     if (!progress)
> > > -                             continue;
> > > -                     any_progress = true;
> > > -
> > > -                     /* Allow panic_cpu to take over the consoles safely. */
> > > -                     if (other_cpu_in_panic())
> > > -                             goto abandon;
> > > +             if (*handover)
> > > +                     return false;
> > >
> > > -                     if (do_cond_resched)
> > > -                             cond_resched();
> > > -             }
> > > -             console_srcu_read_unlock(cookie);
> > > +             if (other_cpu_in_panic())
> > > +                     return false;
> > >       } while (any_progress);
> > >
> > >       return any_usable;
> >
> > The semantic of the function was always complicated. It results
> > into duplicated checks in the callers.
> 
> Yes, I've found this confusing.
> 
> any_usable is used by callers for different purposes. For
> __console_flush_and_unlock, its used to determine if its possible to
> try and do more work (i.e. to check if they should bother attempting
> to print messages which may have been added between flush and
> unlock)

This implements a historic approach when the current console_lock
owner is responsible for flushing all pending messages.

It makes sure that all messages are flushed to the console.
And parallel printk() does not need to wait for console_lock.

The "try and do more work" handles the following race:

CPU0				CPU1

printk()

  console_trylock()
  console_unlock() 
    __console_flush_and_unlock()
      console_flush_all()

				printk()
				console_trylock()
				  # fails because console_sem
				  # is still owned by CPU0


      __console_unlock()

Problem: Nobody owns console_lock but the message added by
	 CPU1 has not been flushed yet.

Solution: The last owner must check whether there is a new
	  message after releasing console_lock. And it must
	  try to flush it.

	  The try_lock might fail when another CPU gets
	  the console_lock in the meantime. But it is fine.
	  The new owner will flush the message then.


> - i.e. useable consoles exist but also no panics or handovers have
> happened.

These are situations when this context is not longer responsible
for flushing the rest because:

   + there are no usable consoles.

   + non-panic CPUs are going to be stopped. And the messages
     will get flushed by panic CPU, either by printk() called
     on panic CPU or by explicit flush in panic().

   + the console_lock ownership has been passed to another
     CPU via console_trylock_spinning(). The new owner will
     flush the pending messages. It helps to reduce the risk
     of softlockup reports with this historic approach.


> For get_init_console_seq it is used to determine if init_seq
> was updated.

I would rather say that it is used to determine whether init_seq
has a reliable value. Where reliable means that it flushed and
checked all usable consoles.

Note that this value is use to prevent duplicate output when
a proper console driver replaces an early console driver.

We are not able to detect which early/proper drivers are using
the same physical device => it is better to flush all consoles
and use the last next_seq which should be the same on all consoles.


> The comment for console_flush_all says:
> 
>  * Returns true when there was at least one usable console and all messages
>  * were flushed to all usable consoles.
>
> But I don't think that's true. It returns true when there was at least
> one usable console and at least one message was attempted to be
> written (I guess nbcon_legacy_emit_next_record or
> console_emit_next_record could bail out before writing its message).
> Unless I'm missing some assumptions about what can change in
> iterations of the do/while loop.

The "bail out" should be detected. This is why console_flush_all()
explicitly returns "false" in the following situations:

  + handover happened
  + other_cpu_in_panic() returns true
  + both any_progress and any_usable are false

Hmm, I agree that the last case is not 100% correct:

  1. The original code did not reset any_usable in each cycle.
     It might be true even when all usable consoles have been
     disabled in the meantime.

     Well, it is a corner case and should not cause problems.

     In the worst case, console_unlock() will do one more
     cycle (try_lock + console_flush_all) and the new
     console_flush_all() would return false because
     there won't be any usable console

     This problem should not happen with get_init_console_seq()
     because it is called under console_list_lock. Consoles
     could not be disabled in parallel.

     This will actually be fixed by resetting "any_usable" in
     each cycle.


   2. "any_progress" is set to true when at least one console
      made progress.

      It is not a big deal:

	+ console_flush_all() would explicitly return false when
	  there was a handover or other_cpu_in_panic()
	  returned true.

	+ console_emit_next_record() always finishes the job
	  when there is a pending message.

	+ nbcon_legacy_emit_next_record() might lose the owner
	  ship. But the new owner will become responsible for
	  flushing everything. And console_flush_all() would
	  try one more cycle...

      It seems to be working correctly in all situations after all.


> > I think that we could do slightly better in this particular case.
> > But I would do the refactoring in a separate patch to make this
> > one easier for review.
> >
> > I played with the code and came up with:
> >
> > From 7a3c930a12d7c0157f404a4a834d1f92f3070799 Mon Sep 17 00:00:00 2001
> > From: Petr Mladek <pmladek@suse.com>
> > Date: Thu, 18 Sep 2025 16:57:58 +0200
> > Subject: [RFC] printk: console_flush_one_record() code cleanup
> >
> > console_flush_one_record() and console_flush_all() duplicate several
> > checks. They both want to tell the caller that consoles are not
> > longer usable in this context because it has lost the lock or
> > the lock has to be reserved for the panic CPU.
> >
> > Pass this information by clearing the @any_usable parameter value
> > which has the same effect.
> >
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > ---
> >  kernel/printk/printk.c | 20 +++++++++-----------
> >  1 file changed, 9 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 53daab5cdee5..2cceedcc3d34 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3175,7 +3175,8 @@ static inline void printk_kthreads_check_locked(void) { }
> >   * console_lock, in which case the caller is no longer holding the
> >   * console_lock. Otherwise it is set to false.
> >   *
> > - * @any_usable will be set to true if there are any usable consoles.
> > + * @any_usable will be set to true if there are any usable consoles
> > + * in this context.
> >   *
> >   * Returns true when there was at least one usable console and a record was
> >   * flushed. A returned false indicates there were no records to flush for any
> > @@ -3230,7 +3231,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
> >                  * is already released.
> >                  */
> >                 if (*handover)
> > -                       return false;
> > +                       goto unusable;
> >
> >                 /* Track the next of the highest seq flushed. */
> >                 if (printk_seq > *next_seq)
> > @@ -3242,7 +3243,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
> >
> >                 /* Allow panic_cpu to take over the consoles safely. */
> >                 if (other_cpu_in_panic())
> > -                       goto abandon;
> > +                       goto unusable_srcu;
> >
> >                 if (do_cond_resched)
> >                         cond_resched();
> > @@ -3251,8 +3252,10 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
> >
> >         return any_progress;
> >
> > -abandon:
> > +unusable_srcu:
> >         console_srcu_read_unlock(cookie);
> > +unusable:
> > +       *any_usable = false;
> 
> I'm struggling to understand this. I think your intention is to start
> with any_usable being true (which would have to be set in
> console_flush_all)

No, my intention is to start with @any_usable set to "false".

It would be set to "true" only when console_is_usable() returned
true for at least one console.

And it would be set back to "false" when the function was not
able to finish the job (bailed out) because:

    + handover
    + other_cpu_in_panic()

By other words, the variable @any_usable would have the same
semantic as console_flush_all() return value.

Maybe, we could rename the variable to "flushed". It would
be set to "true" when the function was able to flush on
all usable consoles and when it was not interrupted.

I hope that it makes more sense now.
 
> 
> >         return false;
> >  }
> >
> > @@ -3288,14 +3291,9 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
> >         *handover = false;
> >
> >         do {
> > -               any_progress = console_flush_one_record(do_cond_resched, next_seq, handover,
> > -                                                       &any_usable);
> > +               any_progress = console_flush_one_record(do_cond_resched, next_seq,
> > +                                                       handover, &any_usable);
> >
> > -               if (*handover)
> > -                       return false;
> > -
> > -               if (other_cpu_in_panic())
> > -                       return false;
> 
> Ah, that makes a lot of sense, any_progress will be false in these cases anyway.
> 
> 
> >         } while (any_progress);
> >
> >         return any_usable;

Best Regards,
Petr

