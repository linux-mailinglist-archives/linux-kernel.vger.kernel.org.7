Return-Path: <linux-kernel+bounces-839286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA62BB13FF
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 18:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210FA4A6AC0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 16:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D178284880;
	Wed,  1 Oct 2025 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="jtWD1GXm"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E410226D4C2
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759336000; cv=none; b=qMaDZrkBe/XyY+21tGdS7N5tuTAOBHsbK+YJi5qbN05SIIe1YZ/P+qTTuo/+FQyaNK+zCPhr+2VArFtdV1z+s2bA8dbi6Zqk+ZWICLZgZeRRg/FaOiDZ0a4YZ+BLZL4oQCLm508Johvcje3dlEAdWgsT2SXVdilq64BpQnY9HHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759336000; c=relaxed/simple;
	bh=DqBGCwXhXmBj9I2K6nBR8r/lOpwG9Z1hiCtHWa0KJt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVP/pA1fD1gCANlblDxdLx4XhaYunNsqXwGDOVL/f8dACfrrnne93MydSdhCcrOntyaLLuwwGRCcOdeEJRTv5prWBS4BFgfdJ//Vr2fZHMlTJuSFajpk6jarYjzwhLlK0/mSqnpzejFHrNCbtMeZErbWPqN+hWnGXi1BcJtccnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=jtWD1GXm; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-90926724bceso264539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1759335998; x=1759940798; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z8fLjEGl1PHOcP49OeF5B0SK322rqh01Lg9xclx26zY=;
        b=jtWD1GXm7OY5I6DK4g/lDJGr+gT0AfgN6DZFrkbdBr6JpRE7RJ1PXzDQwVc6WgKk3H
         o/FuEI3Tul5p2u1HOu6YpW+KW0z1g903elcAMUhqX0IMACqkyh9mdPi1WtmR3xiF3h5y
         qRd8D5BYrXA5B7W58a5dXQSoxsZnNr8L0NXs/LvgW5bQTF9YYmpxiopGrTkYqLxxItp1
         NJ0gQk/VptDwNxju20lKjuFGGefS4lDxfHFKH+lKqcBr4YFl4XaAxBOpRvUulr4UYrbR
         70b2Vt3gEp7WkMPVtkwxzxlOXo1ZopO04070NzURxpYsiH7qrY2S5wyRc8e22CFMt7uk
         sAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759335998; x=1759940798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8fLjEGl1PHOcP49OeF5B0SK322rqh01Lg9xclx26zY=;
        b=ORVZrkIYhwh5GvEXqZiihnWUwwyK0U+5ItkY2GDiYP5rLEFnhkZe9YwUFk3GaygF7z
         vO4wh/Obbo5gkPDyLRzGusfZa51VEbWVG+lY+CV1UlwwFBIus8yB7GX7iw72wVesy5RV
         2yZyPbE6hEnHX5fvrhwhGsZYT/BnVsphTIo1DFGN+OmThoVLBjVp+GkdwNajD1Wzivxt
         QDJG+TqYr8wAIJZcomvveZrt0sKNmOq6UQ6t44c8F0yptmdPSFms64zdnspHDGnpqp55
         zBsOErFjKdQhUXtVepbRNAR+x3hrZqc2Bo/QtPD1Lu8zY1XvBE24pknK0rzgHDLraTyc
         VS9g==
X-Forwarded-Encrypted: i=1; AJvYcCXHdCYieoFInzQlJdC7yS5hWgxqlSrvmOzl9UyzwZovN8opzPlwIRzjxRAlqzVV2wLfBGiuFv0LU286EAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwfNpkDa5ZRHmFOgYoHMEm4IzwIFqeECDeS5VtnjciYqIgSo/Z
	Tkbh/Ey67F515DS5x0zxS7/AkfpbPfDrZ387i9PqdTL8VpwNMWop5OxIOVl+Sig4AN4EaHkBnTx
	t7gcOs3V9lpYa/8DYJviLl9t0GWsLEzCjs1KW9eixRA==
X-Gm-Gg: ASbGnctHU/vsL8F3llojaxcIujjKbfZbdJi1AvxM1uaGnBl6sIbENENlhEJ3o0eeRPN
	hR9Z6Y8bOo8ipXnYfQzRK34UlzGo1eF5AOeyjEE7CqRM+Q6mZxOyexZE0q4b6IdBVMZwQAiBi4T
	BisnGFZV7VzO5+4clOJ45odMb40dgo25KyNDRsPk1O2+foX//e6312xpan1AxcanYQHJ8jFILqU
	ldHFKVDT8ELeNwUmKKVETsMCZPVXHP7kXlmdrd5LsqCaUe7oL+o9TeezdWVKvTl
X-Google-Smtp-Source: AGHT+IHmgdzSgJVNk1yBgNw16XHMCI78RmYOjuEnD4kwL/M9l6oilOiNC2ErhYWWInixS+CPorv7QqYbjHconAO/teY=
X-Received: by 2002:a05:6e02:156e:b0:42d:89b9:5d30 with SMTP id
 e9e14a558f8ab-42d89b95f25mr19096885ab.19.1759335997812; Wed, 01 Oct 2025
 09:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
 <20250927-printk_legacy_thread_console_lock-v2-2-cff9f063071a@thegoodpenguin.co.uk>
 <84o6qsjduw.fsf@jogness.linutronix.de> <CALqELGwd1CiRAYNBVWsrgb5T3eJ9ugP+0wG2WKZGvSfowqgaaQ@mail.gmail.com>
 <84seg3gd89.fsf@jogness.linutronix.de>
In-Reply-To: <84seg3gd89.fsf@jogness.linutronix.de>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Wed, 1 Oct 2025 17:26:27 +0100
X-Gm-Features: AS18NWCRyj7IzDMituJuuwtQmHAJkR9n_fPGePI6K4tE0EN2XiPPstOACEJVxyY
Message-ID: <CALqELGw8wtbbihLsOcNgnV2vGoSR7kD8_tHmt7ESY4d3buwrLQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] printk: console_flush_one_record() code cleanup
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 10:53, John Ogness <john.ogness@linutronix.de> wrote:
>
> On 2025-09-30, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> >> On 2025-09-27, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> >> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> > index 060d4919de320fe21fd7aca73ba497e27c4ff334..e2c1cacdb4164489c60fe38f1e2837eb838107d6 100644
> >> > --- a/kernel/printk/printk.c
> >> > +++ b/kernel/printk/printk.c
> >> > @@ -3193,6 +3194,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
> >> >       bool any_progress;
> >> >       int cookie;
> >> >
> >> > +     *any_usable = false;
> >>
> >> Since it is expected that @next_seq and @handover are initialized by
> >> their callers (if their callers are interested in the values), then I
> >> would expect @any_usable to be initialized by the
> >> caller. console_flush_one_record() never reads this variable.
> >
> > Yes, that's correct. Perhaps the comments for the parameters should
> > indicate otherwise?
>
> They should clarify. For example, @next_seq is "valid only when this
> function returns true" but @handover validitiy is not specified and is
> also not related to the return value.
>
> I would like to see the helper function provide clear usage. If the
> caller is expected to initialize the parameters (which IMHO it should be
> the case for all of the pointer parameters), then that should be
> specified.

OK.


>
> >> > @@ -3280,21 +3284,16 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
> >> >   */
> >> >  static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
> >> >  {
> >> > -     bool any_usable = false;
> >> > +     bool any_usable;
> >>
> >> Since console_flush_all() does read @any_usable, I would expect it to
> >> initialize @any_usable. So I would not remove this definition initialization.
> >
> > Prior to this series, console_flush_all would set any_usable to false.
> > It would be set to true if at any point a usable console is found,
> > that value would be returned, or otherwise false if handover or panic.
> > When the first patch split out this function, any_usable was kept as
> > it was, leading to any_usable being true, even if a handover or panic
> > had happened (hence additional checks needed, which are removed in
> > this patch).
> >
> > By setting any_usable at the start of flush_one_record, it allows for
> > any_usable to revert back to false, in the case where a once usable
> > console is no longer usable. Thus representing the situation for the
> > last record printed. It also makes console_flush_one_record easier to
> > understand, as the any_usable flag will always be set, rather than
> > only changing from false to true.
>
> OK. But then just have console_flush_all() set @any_usable in the loop:
>
> static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
> {
>         bool any_progress;
>         bool any_usable;
>
>         *next_seq = 0;
>         *handover = false;
>
>         do {
>                 any_usable = false;
>                 any_progress = console_flush_one_record(do_cond_resched, next_seq,
>                                                         handover, &any_usable);
>         } while (any_progress);
>
>         return any_usable;
> }

Yes, that seems like common sense, I have no idea why I didn't think of that :|


>
> > Alternatively, it may be possible for console_flush_one_record to
> > return any_usable, thus dropping it as an argument and removing the
> > return of any_progress. Instead the caller could keep calling
> > console_flush_one_record until it returns false or until next_seq
> > stops increasing? Thus semantically, the return value of
> > console_flush_one_record tells you that nothing bad happened and you
> > can call it again, and the benefit of calling it again depends on if
> > progress is being made (as determined by the caller through the
> > existing seq argument).
>
> Sorry, I could not follow how this would work. It sounds like a
> simplification. If you can make it work, go for it.

Against my patches, something like this:

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2c9b9383df76..f38295cc3645 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3186,16 +3186,13 @@ static inline void
printk_kthreads_check_locked(void) { }
  *
  * Requires the console_lock.
  */
-static bool console_flush_one_record(bool do_cond_resched, u64
*next_seq, bool *handover,
-                                    bool *any_usable)
+static bool console_flush_one_record(bool do_cond_resched, u64
*next_seq, bool *handover)
 {
        struct console_flush_type ft;
        struct console *con;
-       bool any_progress;
        int cookie;

-       *any_usable = false;
-       any_progress = false;
+       bool any_usable = false;

        printk_get_console_flush_type(&ft);

@@ -3215,7 +3212,7 @@ static bool console_flush_one_record(bool
do_cond_resched, u64 *next_seq, bool *

                if (!console_is_usable(con, flags, !do_cond_resched))
                        continue;
-               *any_usable = true;
+               any_usable = true;

                if (flags & CON_NBCON) {
                        progress = nbcon_legacy_emit_next_record(con,
handover, cookie,
@@ -3239,7 +3236,6 @@ static bool console_flush_one_record(bool
do_cond_resched, u64 *next_seq, bool *

                if (!progress)
                        continue;
-               any_progress = true;

                /* Allow panic_cpu to take over the consoles safely. */
                if (other_cpu_in_panic())
@@ -3250,12 +3246,11 @@ static bool console_flush_one_record(bool
do_cond_resched, u64 *next_seq, bool *
        }
        console_srcu_read_unlock(cookie);

-       return any_progress;
+       return any_usable;

 unusable_srcu:
        console_srcu_read_unlock(cookie);
 unusable:
-       *any_usable = false;
        return false;
 }

@@ -3286,15 +3281,15 @@ static bool console_flush_all(bool
do_cond_resched, u64 *next_seq, bool *handove
 {
        bool any_usable;
        bool any_progress;
+       u64 last_seq;

        *next_seq = 0;
        *handover = false;

        do {
-               any_progress =
console_flush_one_record(do_cond_resched, next_seq,
-                                                       handover, &any_usable);
-
-       } while (any_progress);
+               last_seq = *next_seq;
+               any_usable = console_flush_one_record(do_cond_resched,
next_seq, handover);
+       } while (*next_seq > last_seq);

        return any_usable;
 }
@@ -3674,21 +3669,20 @@ static int legacy_kthread_func(void *unused)
        wait_event_interruptible(legacy_wait,
                                 legacy_kthread_should_wakeup());

+       u64 last_seq, next_seq = 0;
        do {
-               bool any_usable;
                bool handover = false;
-               u64 next_seq;

                if (kthread_should_stop())
                        return 0;

                console_lock();
-               any_progress = console_flush_one_record(true, &next_seq,
-                                               &handover, &any_usable);
+               last_seq = next_seq;
+               console_flush_one_record(true, &next_seq, &handover);
                if (!handover)
                        __console_unlock();

-       } while (any_progress);
+       } while (next_seq > last_seq);

        goto wait_for_event;
 }
-- 
2.34.1

This also has the benefit of removing code (and more could be removed
if the progress variable in console_flush_one_record is removed - i.e.
we could unconditionally bail on panic and resched each time).

Thanks,

Andrew Murray

