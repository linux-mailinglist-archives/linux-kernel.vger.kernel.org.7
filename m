Return-Path: <linux-kernel+bounces-837852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C67BADA21
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E275A1943F34
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4D7307AF8;
	Tue, 30 Sep 2025 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="1sc7nqdB"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141FC246BB0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245275; cv=none; b=ZMj0ZbGTJUUiRiytcJz+5nWOo1aj4235RoKzWD1Pat2GLptsbnDrFbzr8GSoRJVtqQJIJW13W6GxW1DFMjIDk8vEBZjCZ3rhVxM3BzvJXgI0gu4tARzXEsQL5punMzKZ3nXIicevC5l2llmB4wkh54VjJthNfKyWtA9FzfuxsTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245275; c=relaxed/simple;
	bh=Aem4l7UNOuAtkk7BQvOnyibyDROWaU1X+2uNNF6K4LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfHVum29WqV+lRD196A3LIkzBdoucDmVuj+48/gKLeRiTnYiisqYNRxWPZ2JpPeipgS8lXS30Rf+eqFIj+5BiDtnJdMXa0mJH1CWr26jqwWl3iI31ydQCmQqqqXjzhau3riIGXR52DZEg9RrPtoRJra4n8QQP/13c7WKJpQQHuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=1sc7nqdB; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-91524f5e6a8so359348939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1759245271; x=1759850071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WO1HjvdYOdY6TFiA410hr4lwpJbj7pY1G18aib2+5g0=;
        b=1sc7nqdBMdJmoATMei6q/vVpBntLqYPo7m1gmi7gmT9KAOoP6GEJV7zqO9lnqualfL
         3P6AZ70zuP3FQLUByQtwu/garkw93c+nywZuKoNx/bAwDOuhgrKSOwzKB2PgILMg9eCK
         H+VwjQr6BGa8nN1H+WW3qgzJV1NbVingj5nbAQruQ+wO/3JExtWwa9u1TEhGSVBXVP/r
         cmwaQXBV0gC7Yq9P//3JBna+DRm+gZoNJDP8KfIlP8lEVxocGLq16d0B3UOMU30RrWyB
         FLHogHaClveCzWFuBLXG6XDWey5PUfEr2Ch21ApxOJLIyRRithKOc8819QZ1YQ+Y2xtS
         CMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759245271; x=1759850071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WO1HjvdYOdY6TFiA410hr4lwpJbj7pY1G18aib2+5g0=;
        b=iWPxVod0VEPxjY2i+qOxixwlsPpSs0HF8+TqoEroYwrV9/udrQWcCPqUqhwSgZtIA/
         V0jJJyVq7SXfq1SNTZ+lqPGwPfELKDp8AuHHVzvliIRUhpyxwe3pF6IqofpQNp3wWrdz
         CP6COQA/sKuygT7vklH4e1NTZiyVhU/hst4n3pZ3cM/zpe059tQN6jLgbsx5yXSAk3Ic
         SAnXDsQyrAuoRBRsKggefHKtES+dULR03NtX+aus/GPM6vRDE4L2EQEMa1asxSTgPJgB
         X2W4Dg2tluf7Yxj5NYA0fAo9eMqZAqPAQ/u4PPr033S2eX8xY5NIYxBDTBWopKuVFs1h
         QdDw==
X-Forwarded-Encrypted: i=1; AJvYcCURWeJW3vcLZLisxL0Mwo9MH9s5lJhneQL3jTEwGlRoQnvs9ktpS8di++biMI5gwKZkbA8vfoooQSC3vcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTFK0UxM0Iu2sRS6pUckPW6wUbPxaFjIqWjmJj3HJNR/6aP1bu
	3nh99bB3InUhTdvsWFBaCRt7z7HC0nOyC/rZeq7E/fjA8KYaMflyMUwAY65BNoJTcWE1yn0u38s
	jBybj9ig2lHkf6pYUya3tQ1NeH5wc/M1SSTADNh5XWQ==
X-Gm-Gg: ASbGncvpcdJECawxgK525EP9qH1ie9P3dRLl2IwmpHPUPBuZ95cQWMFOYCS87u+Brj2
	+bc9NE3+UzTWjNmScmdeaO2R8S8rdYmMVtuB3Xfrk77f8eSi5CJfhI33r9ibJxIRCZqno3Iu+AR
	Fj0ElxnVGbmSbEEMi1WhrC0tQS+2wJJ3jRnWjgNgkw6e3ajGcmfP2ao8JscjQB+toLABuesTYqx
	CYetvD4C6Onqj3ncNwot+NJ1XAyAJ6A1ZyY0+7k0DAG2NqJmRVoUNRQSDPfR6hL
X-Google-Smtp-Source: AGHT+IEUZDd7ioH0cNCmXTjPD8qi4E6e703yvZZ5Gd2jUjmF77pnAYEwpGhBEdOYDx4PuB6OWViEI3KFdZIFGWx07aY=
X-Received: by 2002:a05:6e02:1d94:b0:429:a1b7:ee3d with SMTP id
 e9e14a558f8ab-42d815cebe3mr3745165ab.2.1759245271056; Tue, 30 Sep 2025
 08:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
 <20250927-printk_legacy_thread_console_lock-v2-2-cff9f063071a@thegoodpenguin.co.uk>
 <84o6qsjduw.fsf@jogness.linutronix.de>
In-Reply-To: <84o6qsjduw.fsf@jogness.linutronix.de>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Tue, 30 Sep 2025 16:14:19 +0100
X-Gm-Features: AS18NWAQReXxp3TaIbQ9qOFwVOMglgCinQ_17T5O2T-xm5Q4V3PG8wEu8gVeKTY
Message-ID: <CALqELGwd1CiRAYNBVWsrgb5T3eJ9ugP+0wG2WKZGvSfowqgaaQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] printk: console_flush_one_record() code cleanup
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Sept 2025 at 13:59, John Ogness <john.ogness@linutronix.de> wrote:
>
> On 2025-09-27, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 060d4919de320fe21fd7aca73ba497e27c4ff334..e2c1cacdb4164489c60fe38f1e2837eb838107d6 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3193,6 +3194,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
> >       bool any_progress;
> >       int cookie;
> >
> > +     *any_usable = false;
>
> Since it is expected that @next_seq and @handover are initialized by
> their callers (if their callers are interested in the values), then I
> would expect @any_usable to be initialized by the
> caller. console_flush_one_record() never reads this variable.

Yes, that's correct. Perhaps the comments for the parameters should
indicate otherwise?


>
> > @@ -3280,21 +3284,16 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
> >   */
> >  static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
> >  {
> > -     bool any_usable = false;
> > +     bool any_usable;
>
> Since console_flush_all() does read @any_usable, I would expect it to
> initialize @any_usable. So I would not remove this definition initialization.

Prior to this series, console_flush_all would set any_usable to false.
It would be set to true if at any point a usable console is found,
that value would be returned, or otherwise false if handover or panic.
When the first patch split out this function, any_usable was kept as
it was, leading to any_usable being true, even if a handover or panic
had happened (hence additional checks needed, which are removed in
this patch).

By setting any_usable at the start of flush_one_record, it allows for
any_usable to revert back to false, in the case where a once usable
console is no longer usable. Thus representing the situation for the
last record printed. It also makes console_flush_one_record easier to
understand, as the any_usable flag will always be set, rather than
only changing from false to true.

At least that was the intent discussed here [1].

Alternatively, it may be possible for console_flush_one_record to
return any_usable, thus dropping it as an argument and removing the
return of any_progress. Instead the caller could keep calling
console_flush_one_record until it returns false or until next_seq
stops increasing? Thus semantically, the return value of
console_flush_one_record tells you that nothing bad happened and you
can call it again, and the benefit of calling it again depends on if
progress is being made (as determined by the caller through the
existing seq argument).

>
> >       bool any_progress;
> >
> >       *next_seq = 0;
> >       *handover = false;
> >
> >       do {
> > -             any_progress = console_flush_one_record(do_cond_resched, next_seq, handover,
> > -                                                     &any_usable);
> > +             any_progress = console_flush_one_record(do_cond_resched, next_seq,
> > +                                                     handover, &any_usable);
> >
>
> Since the second line of the call to console_flush_one_record() already
> has a ton of whitespace, I would remove the above blank line.

Sure.


>
> John


[1] https://lkml.org/lkml/2025/9/27/200

Andrew Murray

