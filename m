Return-Path: <linux-kernel+bounces-824578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0CCB89983
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829CD5602A7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C4722D7B9;
	Fri, 19 Sep 2025 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="mztyZhPQ"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38513308F1D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287199; cv=none; b=KShOCIFB7H67iN2UJ4c+2ojeIFhd3D9r+eXy0OXUABeAocWfX07UxKlxQaOTY0U2wMcQMGzOOXlqAUiT7hN9qF7IWgdLThoEmIf9g72yKmD1oG7tOhJkGeoU7r1sH+CBNgypHMRo+KyRukVxi5PbdLcqikHB/CVAC1UM1Ah5eC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287199; c=relaxed/simple;
	bh=dd6fzvDDqnJNozgGM2VWVz924kMWzFI1OgUernXEAFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2z9y1qucRg082gZUg4bDixAyT9pgnRTKKZVuvh5JUfd59AsT7f33kl0Se1eMR/1EwgP7yKCdSMAUbPflX+jVshKC8DuDDjxQ8Mh9ftx+50bVWQamfQF4moIvwVaGSkXS+y3+v8lpbECHgATOck6Pu/NtJGZjNd0aPH/Bm3O+/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=mztyZhPQ; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-88cdb27571eso78313039f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1758287196; x=1758891996; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7joEhqdexByZrx5tqDtA/EuoCNqYu2cVNRC+4AsCeEI=;
        b=mztyZhPQRpiRVWt9pNBia+iRh81ZlJ0nj0H4WE0DFjrdIwvEJJATrCl7O+ozzaPyPy
         /Mr105cBl6K+X90odIzF8VMQO//srvxnyr2efKME+htYPP1tsKzVqK/gHB7MN/OnyWe5
         LuNqGF6dxqWKIdHzf18nKPG5EzKxkBLs6f5U8C9FPzEQDingBVjvg4IXTj84i7sotAhZ
         M9vutaYbKB4X9iOSn1OZsvpGmowHLq6ZRtE/m9LobJDJYYM8LsQuSWl8JnFbs5dJEveO
         sqHQxeoQmJY+XZuOB5NgnRTJnNSTUKu3IHQJw66AdMfb4ar8gVC9212HFVEeB1OKUoYp
         SSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287196; x=1758891996;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7joEhqdexByZrx5tqDtA/EuoCNqYu2cVNRC+4AsCeEI=;
        b=fbgq/8AamnZFOa3vNV6ZPD8QyZDAJfR5JRuiZ6I99Y+zYqK9CLHvEJWQLE7biuk0jV
         x9JQn41kcgrwvXFirVCrrNPmE7tqnQ40V6v8LNUbDPxCJS7F+ORdJe2x7HmWkpie80cq
         naMgmtPhu2gOT8UqV1zmgdvlXZiQEPN6c6ZEvsStcM2qZoLujqqI7+F9Ojbj/i6YK73w
         BND1BbNjjwGo7BESCuO63UY+CPa2EemA1yQK+vBIiQO/8rpM74BmLMXJLW8ISacfX6N7
         5QwXjWQVRW9LxSTtiJKHkGJzixmjCGsNsA51LMGgsQgt2yPxFTQf8D3RJuw1N8MNbGgw
         fa8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVl8RThp6zf9gcylXKiUPdbrUOUlHueySPVy8rUhBG99Zm+oyJzsvOMn1/ICxCajAr5k3KUK4CMsgxnWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0KbHGnb12oHpYAoZsFlPzW0R3y2DIPnjEFCGll3EhJNI0rRh7
	2reZcMaprs441vaDYHVvHsN3dymyPajiKdXoNv6fl9pmRnnpekm5TfwPWf8if7ZIDFCzl9sx0tf
	B+vVYvkeumuTcZmX3wQmKePct4zwE6IqdR4zStO2guPWEe7lCtRobA5s=
X-Gm-Gg: ASbGncsMVBKRdPGOW1NncaYWXlIO0+TkuUP5SzXESBIVhiCEl+OkgXUMZEmcniFMeRQ
	46eVJd7qKECDDTtgAdUrDqN9RQ4qDCpqaCn8qdCa9akIPnvJ6vX1Wvfpi9ubrT7zItHyJh3fVRP
	BUvdSMxB93NuCUD4OCcBpsZF/mbroZnPCEjNmCsv3TsdyaXE3TJSLoP/rt1Y3sghsasFZi8YaVl
	TlRr9vKwIL81rA5Mm+1gJ40ux5BuPPgH+qA59gYzOH1aDM5LYo=
X-Google-Smtp-Source: AGHT+IHaZe0I2pf0onniOobxw85mYufAdMJ3uUdY/H26bCz6rBCB9CirLh5MidCAudIoHMPtrgCWjTmliFXm5DBHAO4=
X-Received: by 2002:a92:cdad:0:b0:423:f8c9:66b5 with SMTP id
 e9e14a558f8ab-424819ad179mr50228695ab.31.1758287196042; Fri, 19 Sep 2025
 06:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk>
 <20250915-printk_legacy_thread_console_lock-v1-1-f34d42a9bcb3@thegoodpenguin.co.uk>
 <aMwjmJOVP5QW4rtD@pathway.suse.cz>
In-Reply-To: <aMwjmJOVP5QW4rtD@pathway.suse.cz>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Fri, 19 Sep 2025 14:06:24 +0100
X-Gm-Features: AS18NWBoKiHSYJ2e9cn-Omzk7Jc0KrtkQgu-1zw6H0CQA6DskGpuZoCO4Dq3c2Y
Message-ID: <CALqELGypek7O5y9HCP1p_MeYZCmd4EeyHks+QJ_2tqUe6wZ=fQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] printk: Introduce console_flush_one_record
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 16:22, Petr Mladek <pmladek@suse.com> wrote:
>
> On Mon 2025-09-15 13:43:05, Andrew Murray wrote:
> > console_flush_all prints all remaining records to all usable consoles
> > whilst its caller holds console_lock. This can result in large waiting
> > times for those waiting for console_lock especially where there is a
> > large volume of records or where the console is slow (e.g. serial).
> >
> > Let's extract the parts of this function which print a single record
> > into a new function named console_flush_one_record. This can later
> > be used for functions that will release and reacquire console_lock
> > between records.
> >
> > This commit should not change existing functionality.
> >
> > Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
>
> The code shufling looks correct to me. Feel free to use:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks.


>
> See a nit below.
>
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3186,77 +3281,24 @@ static inline void printk_kthreads_check_locked(void) { }
> >   */
> >  static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
> >  {
> > -     struct console_flush_type ft;
> > -     bool any_usable = false;
> > -     struct console *con;
> > +     bool any_usable;
> >       bool any_progress;
> > -     int cookie;
> >
> >       *next_seq = 0;
> >       *handover = false;
> >
> >       do {
> > -             any_progress = false;
> > -
> > -             printk_get_console_flush_type(&ft);
> > -
> > -             cookie = console_srcu_read_lock();
> > -             for_each_console_srcu(con) {
> > -                     short flags = console_srcu_read_flags(con);
> > -                     u64 printk_seq;
> > -                     bool progress;
> > +             any_progress = console_flush_one_record(do_cond_resched, next_seq, handover,
> > +                                                     &any_usable);

Ah, there was an error in my patch. Previously console_flush_all would
set any_usable to false at the start, and then set it to true if any
usable consoles were seen whilst printing any of the records. My
changes resulted in any_usable being set to false on each entry of
console_flush_one_record - thus effectively only indicating if any
consoles were usable for *only* the last record.

Thus to preserve functionality, I'd need to additionally add these changes:

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 75a3c47e9c0e..060d4919de32 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3193,7 +3193,6 @@ static bool console_flush_one_record(bool
do_cond_resched, u64 *next_seq, bool *
        bool any_progress;
        int cookie;

-       *any_usable = false;
        any_progress = false;

        printk_get_console_flush_type(&ft);
@@ -3281,7 +3280,7 @@ static bool console_flush_one_record(bool
do_cond_resched, u64 *next_seq, bool *
  */
 static bool console_flush_all(bool do_cond_resched, u64 *next_seq,
bool *handover)
 {
-       bool any_usable;
+       bool any_usable = false;
        bool any_progress;

        *next_seq = 0;

Are you happy for me to keep your reviewed-by with these changes?


> >
> > -                     /*
> > -                      * console_flush_all() is only responsible for nbcon
> > -                      * consoles when the nbcon consoles cannot print via
> > -                      * their atomic or threaded flushing.
> > -                      */
> > -                     if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
> > -                             continue;
> > -
> > -                     if (!console_is_usable(con, flags, !do_cond_resched))
> > -                             continue;
> > -                     any_usable = true;
> > -
> > -                     if (flags & CON_NBCON) {
> > -                             progress = nbcon_legacy_emit_next_record(con, handover, cookie,
> > -                                                                      !do_cond_resched);
> > -                             printk_seq = nbcon_seq_read(con);
> > -                     } else {
> > -                             progress = console_emit_next_record(con, handover, cookie);
> > -                             printk_seq = con->seq;
> > -                     }
> > -
> > -                     /*
> > -                      * If a handover has occurred, the SRCU read lock
> > -                      * is already released.
> > -                      */
> > -                     if (*handover)
> > -                             return false;
> > -
> > -                     /* Track the next of the highest seq flushed. */
> > -                     if (printk_seq > *next_seq)
> > -                             *next_seq = printk_seq;
> > -
> > -                     if (!progress)
> > -                             continue;
> > -                     any_progress = true;
> > -
> > -                     /* Allow panic_cpu to take over the consoles safely. */
> > -                     if (other_cpu_in_panic())
> > -                             goto abandon;
> > +             if (*handover)
> > +                     return false;
> >
> > -                     if (do_cond_resched)
> > -                             cond_resched();
> > -             }
> > -             console_srcu_read_unlock(cookie);
> > +             if (other_cpu_in_panic())
> > +                     return false;
> >       } while (any_progress);
> >
> >       return any_usable;
>
> The semantic of the function was always complicated. It results
> into duplicated checks in the callers.

Yes, I've found this confusing.

any_usable is used by callers for different purposes. For
__console_flush_and_unlock, its used to determine if its possible to
try and do more work (i.e. to check if they should bother attempting
to print messages which may have been added between flush and unlock)
- i.e. useable consoles exist but also no panics or handovers have
happened. For get_init_console_seq it is used to determine if init_seq
was updated.

The comment for console_flush_all says:

 * Returns true when there was at least one usable console and all messages
 * were flushed to all usable consoles.

But I don't think that's true. It returns true when there was at least
one usable console and at least one message was attempted to be
written (I guess nbcon_legacy_emit_next_record or
console_emit_next_record could bail out before writing its message).
Unless I'm missing some assumptions about what can change in
iterations of the do/while loop.


>
> I think that we could do slightly better in this particular case.
> But I would do the refactoring in a separate patch to make this
> one easier for review.
>
> I played with the code and came up with:
>
> From 7a3c930a12d7c0157f404a4a834d1f92f3070799 Mon Sep 17 00:00:00 2001
> From: Petr Mladek <pmladek@suse.com>
> Date: Thu, 18 Sep 2025 16:57:58 +0200
> Subject: [RFC] printk: console_flush_one_record() code cleanup
>
> console_flush_one_record() and console_flush_all() duplicate several
> checks. They both want to tell the caller that consoles are not
> longer usable in this context because it has lost the lock or
> the lock has to be reserved for the panic CPU.
>
> Pass this information by clearing the @any_usable parameter value
> which has the same effect.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/printk/printk.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 53daab5cdee5..2cceedcc3d34 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3175,7 +3175,8 @@ static inline void printk_kthreads_check_locked(void) { }
>   * console_lock, in which case the caller is no longer holding the
>   * console_lock. Otherwise it is set to false.
>   *
> - * @any_usable will be set to true if there are any usable consoles.
> + * @any_usable will be set to true if there are any usable consoles
> + * in this context.
>   *
>   * Returns true when there was at least one usable console and a record was
>   * flushed. A returned false indicates there were no records to flush for any
> @@ -3230,7 +3231,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
>                  * is already released.
>                  */
>                 if (*handover)
> -                       return false;
> +                       goto unusable;
>
>                 /* Track the next of the highest seq flushed. */
>                 if (printk_seq > *next_seq)
> @@ -3242,7 +3243,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
>
>                 /* Allow panic_cpu to take over the consoles safely. */
>                 if (other_cpu_in_panic())
> -                       goto abandon;
> +                       goto unusable_srcu;
>
>                 if (do_cond_resched)
>                         cond_resched();
> @@ -3251,8 +3252,10 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
>
>         return any_progress;
>
> -abandon:
> +unusable_srcu:
>         console_srcu_read_unlock(cookie);
> +unusable:
> +       *any_usable = false;

I'm struggling to understand this. I think your intention is to start
with any_usable being true (which would have to be set in
console_flush_all) and then set it to false where necessary (i.e.
invert the current logic). unusable_srcu and unusable are two cases
where false should be returned - however false should also be returned
where there are no consoles (for_each_console_srcu gives nothing) - or
where *all* of the consoles it provides are either NBCON(atomic or
offload) or where the !console_is_usable. I.e. console_flush_all may
erroneously return true, which may cause the loop in
__console_flush_and_unlock to iterate too many times.


>         return false;
>  }
>
> @@ -3288,14 +3291,9 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
>         *handover = false;
>
>         do {
> -               any_progress = console_flush_one_record(do_cond_resched, next_seq, handover,
> -                                                       &any_usable);
> +               any_progress = console_flush_one_record(do_cond_resched, next_seq,
> +                                                       handover, &any_usable);
>
> -               if (*handover)
> -                       return false;
> -
> -               if (other_cpu_in_panic())
> -                       return false;

Ah, that makes a lot of sense, any_progress will be false in these cases anyway.


>         } while (any_progress);
>
>         return any_usable;
> --
> 2.51.0
>
> Best Regards,
> Petr

Thanks,

Andrew Murray

