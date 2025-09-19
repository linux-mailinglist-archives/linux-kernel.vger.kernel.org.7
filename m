Return-Path: <linux-kernel+bounces-824628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0023B89B4B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55FC27B961D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A27E2DCF6B;
	Fri, 19 Sep 2025 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="pgnZu1Nj"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7C1DEFE8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758289108; cv=none; b=r8Co2KOcGh18ds48QJFKT29bJd0Cguu17WPIGUxk0zToYwpOIonPzxk8dAYcgdz3MISc3EFVbWaV/j/EMxuuPkw4mQdxnVQuOwxa6T4E/3krhDWwPMaQ+x/nu+9GuSVnYF0AK08G/b7UUB6YXB71dKsByPuLoTTBg1hvB1uVUu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758289108; c=relaxed/simple;
	bh=0o9910XIEoDnmjWN5aY5tPnQHagS2ntobJq5rKqFduI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGQW1EYgPQhP0S1DK+CO7vpr/T/S5EbT8zMQxdRpcDp0MQFahb9grg043X6NSZZ+QIx+jxztsUjYLqm2FI0+03hrvpsfCBeFNeiwOVmhlZc08PH8OL/lIX2mX3KkdfHYJrb1fMZ8Q9eTeuI809rMxs/149piHXCrsPueeb+swLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=pgnZu1Nj; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8a3e61fa206so96074239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1758289106; x=1758893906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E9h4WteoEw90HLqZWHRhrV8RufKe8X71eJhbcdmHjLY=;
        b=pgnZu1Nj9ZaKjCrUgv7OXTC0vqAQkshjEArcs4lUf7WohoYvzINcd2JrzJUd2fLt+t
         w/F2cDCY7ZDf/avUo7Ja02gjJcNYOdIJN79uNu8f0YjfVQQ143kjGXFQ9m/TWRga1YJZ
         VVlaIVc3EhZClkcFbv1HhKSq6H/L+7H5R32IjHDa7UtE8qaacOqxQXQeRTzZaFP7iU5E
         wMwh29MOI0vcQxcT/y9vNbNvWeDiNaa+rRwyZjESZxCZNVsGEaoMqJ2Vhjffn96D1cMZ
         rjT8jK2s6FSuCnLJjC+tz67nWB11OzJEH1osuIwIV6CkLW0XXUppA3d4m3dx0vcLZ9ag
         b6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758289106; x=1758893906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9h4WteoEw90HLqZWHRhrV8RufKe8X71eJhbcdmHjLY=;
        b=ZDEaUthPCny8QJDU1Dovxq8dSILCFYDOluGmQRQpREAGAYzSZOFe4xXy58wwK4vhn2
         6A7hi9zJqm859kUBwy2stJ3YmveRpx267ZSZnSG7N9APU5r5+ItF4OcFj57ZbOiyjy+L
         pug/oH3oLu2OSNww8F0RMXlZJXgyLbz9XxLB4oYguvatsXvwGFYf4YvHwTmTJxOD8mZL
         LW+lICkH2GuM/BZ+qsCA9wgzgvY7NfH9Pl1AFuqiQvLHYE4FWxFTjgUk0rQZEh6iPGm8
         7Q/LNHcLVkkKh+OLGDSUv8fhWhXkYy6DddvYxw2Ejn1kutJXKH7/Ig9TbIIFlWxr8e/8
         orDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRrlpAQ1LC1nK6cSeHnp5aRv4ASEFqPK3VXPJBgHxVKXcCWchv2SupoP+VFJ1UGWv17efm2lab4nCx068=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8uwf1YOrDNyYVzJfVbsh9LGhk1D2FXuLk6KJ4gx3yCRJnI/sU
	Xj8m9Fvx7Cd+foK0fWlLQF+dci7RvpT/8yE+ytYNjuvwl02xnSNdGTeCu8i8DABY49B1R+BS9Cj
	9ynIINcruCPzm/D1pAzrO2AoUaGr72mta1zml/0oFfg==
X-Gm-Gg: ASbGncsJFxdUDWWuI9WADQuyPxE4SF1jBx9vqefe2bbLr6P1I2mQQmTr8+VllBqhoCi
	zomccj+7L0mEZ5Xxy7Pgxij04nc8lb5PGV3rEre0nHow0zm+YXtGFN0inpz7Hcjg50to1GXGasx
	729eIPWcUMCMQ/LI4XtT6SOm8++xK5x31OyxV5uvZRA2pZRS1S8n+BBdZorxFhTZEbLwDJ8++rw
	eWkl8QDnaX5GBF7cyAex2EgD626ogrBc9sg17jU
X-Google-Smtp-Source: AGHT+IEGhUw9qC9TLc/rD0hE+Orof8BAE9y0lVo3cDWlTvo/bu0IdSRXNdpa0x5lIjHtypTpcUyr6lz7UUYcjd4Dl4g=
X-Received: by 2002:a05:6e02:17cf:b0:423:2666:4687 with SMTP id
 e9e14a558f8ab-424817a2c41mr48543935ab.15.1758289105921; Fri, 19 Sep 2025
 06:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk>
 <20250915-printk_legacy_thread_console_lock-v1-2-f34d42a9bcb3@thegoodpenguin.co.uk>
 <aMwy7pFM7EExLxaX@pathway.suse.cz>
In-Reply-To: <aMwy7pFM7EExLxaX@pathway.suse.cz>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Fri, 19 Sep 2025 14:38:14 +0100
X-Gm-Features: AS18NWBPT_0Aw--9bqaGTW5Y8WHBAwH1mjIXmbEjvOTaG6N06TblVGKJjJ-7HOE
Message-ID: <CALqELGz4ug+YyBvdmPp5aHR3x4qUEp4u4cCpWLL5143VCrf3-w@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] printk: Use console_flush_one_record for legacy
 printer kthread
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 17:27, Petr Mladek <pmladek@suse.com> wrote:
>
> On Mon 2025-09-15 13:43:06, Andrew Murray wrote:
> > The legacy printer kthread uses console_lock and
> > __console_flush_and_unlock to flush records to the console. This
> > approach results in the console_lock being held for the entire
> > duration of a flush. This can result in large waiting times for
> > those waiting for console_lock especially where there is a large
> > volume of records or where the console is slow (e.g. serial). This
> > contention is observed during boot, as the call to filp_open in
> > console_on_rootfs will delay progression to userspace until any
> > in-flight flush is completed.
>
> It would be great to add here the boot logs from the cover letter
> so that the real life numbers are stored in the git log.

No problem, I'll add them to the next revision.


>
> > Let's instead use __console_flush_unlocked which releases and
> > reacquires console_lock between records.
>
> It seems that the patch does the right thing.
> I would just suggest some refactoring, see below.
>
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3301,6 +3301,46 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
> >       return any_usable;
> >  }
> >
> > +/*
> > + * Print out all remaining records to all consoles.
> > + *
> > + * @next_seq is set to the sequence number after the last available record.
> > + * The value is valid only when this function returns true. It means that all
> > + * usable consoles are completely flushed.
> > + *
> > + * @handover will be set to true if a printk waiter has taken over the
> > + * console_lock, in which case the caller is no longer holding the
> > + * console_lock. Otherwise it is set to false.
> > + *
> > + * Returns true when there was at least one usable console and all messages
> > + * were flushed to all usable consoles. A returned false informs the caller
> > + * that everything was not flushed (either there were no usable consoles or
> > + * another context has taken over printing or it is a panic situation and this
> > + * is not the panic CPU). Regardless the reason, the caller should assume it
> > + * is not useful to immediately try again.
> > + */
> > +static bool console_flush_all_unlocked(u64 *next_seq, bool *handover)
> > +{
> > +     bool any_usable;
> > +     bool any_progress;
> > +
> > +     *next_seq = 0;
> > +     *handover = false;
> > +
> > +     do {
> > +             console_lock();
> > +             any_progress = console_flush_one_record(true, next_seq, handover, &any_usable);
> > +
> > +             if (*handover)
> > +                     return false;
> > +
> > +             __console_unlock();
> > +
> > +     } while (any_progress);
> > +
> > +     return any_usable;
> > +}
>
> This is yet another console_flush() API with a complicated semantic.
> (return value, parameters). It is not bad. But it would be nice
> if we did not need it ;-)

Yes, my approach/rationale was to replace the chain of calls from the
__console_flush_and_unlock call in legacy_kthread_func to functions
that don't require console_lock. Thus __console_flush_and_unlock
became __console_flush_unlocked, and console_flush_all became
console_flush_all_unlocked. I hoped I could then change existing users
of the locked versions over to the unlocked versions and perhaps
eliminate the locked versions. However, given that hasn't worked out,
open-coding as you suggest seems like a better approach.


>
> >  static void __console_flush_and_unlock(void)
> >  {
> >       bool do_cond_resched;
> > @@ -3346,6 +3386,17 @@ static void __console_flush_and_unlock(void)
> >       } while (prb_read_valid(prb, next_seq, NULL) && console_trylock());
> >  }
> >
> > +static void __console_flush_unlocked(void)
> > +{
> > +     bool handover;
> > +     bool flushed;
> > +     u64 next_seq;
> > +
> > +     do {
> > +             flushed = console_flush_all_unlocked(&next_seq, &handover);
> > +     } while (flushed && !handover && prb_read_valid(prb, next_seq, NULL));
> > +}
>
> The semantic of this function is not much clear from the name.
> IMHO, it would be a puzzle for people who would try to understand
> the code in the future.
>
> > +
> >  /**
> >   * console_unlock - unblock the legacy console subsystem from printing
> >   *
> > @@ -3676,8 +3727,7 @@ static int legacy_kthread_func(void *unused)
> >               if (kthread_should_stop())
> >                       break;
> >
> > -             console_lock();
> > -             __console_flush_and_unlock();
> > +             __console_flush_unlocked();
>
> IMHO, it would be pretty hard to understand what it does by trying to
> understand all the layers of the code.
>
> It might be better to open code it. And I would take inspiration
> in the nbcon_kthread_func().

Yes, I agree.


>
> I played with the code and came up with:
>
> static int legacy_kthread_func(void *unused)
> {
>         bool any_progress;
>
> wait_for_event:
>         wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());
>
>         do {
>                 bool any_usable;
>                 bool handover;
>                 u64 next_seq;
>
>                 if (kthread_should_stop())
>                         return 0;

This changes the behaviour from the existing legacy_kthread_func. Thus
allowing the thread to exit mid way through printing remaining
records, whereas previously the whole set of unprinted records would
first be printed. But that's probably a good thing.


>
>                 console_lock();
>                 any_progress = console_flush_one_record(true, &next_seq, &handover, &any_usable);
>                 if (!handover)
>                         __console_unlock();
>
>                 /*
>                  * There is no need to check whether there is any usable
>                  * console in this context or whether there are pending
>                  * messages. It is checked by legacy_kthread_should_wakeup()
>                  * anyway.

Ah, I hadn't realised this, thus the prb_read_valid call in my loop
isn't required. Thanks.


> And console_lock() will never succeed again if
>                  * there was panic in progress.
>                  */
>         } while (any_progress);
>
>         goto wait_for_event;
> }
>
> What do you think, please?
>
> Best Regards,
> Petr

I'll respin this series.

Thanks,

Andrew Murray

