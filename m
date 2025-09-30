Return-Path: <linux-kernel+bounces-837724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C83A3BAD09D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0153188B92D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB753043D4;
	Tue, 30 Sep 2025 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="B+BQU15h"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807893043D2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238446; cv=none; b=S67uu2tZKqf6ju/7oU2VnJWFp49fxpryBjVMJ3KQ3g+JkVFOSB+ckS2LmrNV+/RPPVv6lz96AVtDavQv01jcEUoJxOHUjLjjvROEfOfXcJhV1orZ8PQbzhPJiWqP1iUQCRjRRJK3EqxddG624kqLBSAo1OVJWnvMN7JqU0I+WlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238446; c=relaxed/simple;
	bh=MPkPIgWBGxeqXRvC9xjLii8VCNfWLWVPjw7ZFlSZwRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6Et4c2iLl4qSGJJ6hVkj/JCczxYrhQ1Ibu8kq0oCfCyB5xe4FXiqWJ45kT9OWXEqnLP3XjeHaj6vY71+PHCtcwWsYElob/Ge0Xc57dkFhzlerbZYYUNuJYbH6ngGkDGozhcJOTuA65QvRfG4unp3Azz9HQaLwo3KJrVySMaGnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=B+BQU15h; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-930cfdfabb3so60384439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1759238443; x=1759843243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X1aAARBtZmZdJR0YpOn0YWIxy/UEFW1RX/JFCQlsYkU=;
        b=B+BQU15hS8vDG2vPV+6kWU5cscmfjUUBt8Mdo5PstrcSY+vUYAMG5c9R/AhQnANaE+
         eoc3A9AiPA6O84YaSrDEF6v45yqCojo/G18ceAJJrVqQn3AD86EwWXmxAcEZ1m0iw6HV
         /t3BU8Rv18aAyfDN7fytVdb+LMqGj7eHVxPtpVzxFOTP2EM5MHdDhigSs7rihA7Qbhp6
         2V78EZEVM/G9gdwaNSMjLAnX9/BDPOeCfQPNLdxyOuOXgqVcHiWVvZ1egFDoLIkp/r5h
         4GEnbC4TB1eMwEFvwkwBOYQTVmL552Fi6cpfz2w7emoHWoIVU8PBamL67dgaHx/bfEzO
         lJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759238443; x=1759843243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1aAARBtZmZdJR0YpOn0YWIxy/UEFW1RX/JFCQlsYkU=;
        b=wZs7fxl6GFslDjSzqzyg46fHhsLmwHsqz3D4MP1j1daTqGEPwzPYR5OJosHk0KjGM7
         N17MctxAtSInIvcCcKbn7UoLPH1G4BjPIS/1nHu3LCuEZYdsUtupalArHOXB76CgcdgN
         wtT3IqErmoNs3X5lXsA/0+tPeyx44In3Ju/MEuSXl65xpIN+/z/HyIVy++CBvUR9Wlzh
         ZyLJ/TZ3g8kAhNe2PdLxwkfI3bnKtwHKMhNEctiAOtYScJxpN82Mqn/H40XoNRGZ12vS
         d5/JZmbqNhEu2/GIIHbDbzDFOoLBbJ24flzJnYhBbvPtbYeAuWXxPHgLaRNczIXpiXTe
         FzeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYv/8144IJ+kUYXjHyJz2UFvtmMixwuFqf0NeR0zIZyh4xga2CmSnZtggfrx6xz32I7qF3YouJIImljyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe2o+iWXYYHZID/FoS6TkkBbuEmQVeweNnNisG+i/qbXEbT/ca
	SqXHUH8DnP9OELIARPkELP+CXt3UD/2DZc24Qc+QgAWkKJ/EUpkRM8ye/npJYzlxOzotnWwrDwN
	uCX+idLz6Cc/Qrtx7rPFMGDmY11RV/Weuyu2KblYgVA==
X-Gm-Gg: ASbGncsKHHQSf9DFTwjgHT6sTniFVENmF7iemcO7swTwO0AADtVXxaLzNnaMvlxHzCf
	poGhWvodFTYpdcpXU9s+txys+Sq56JaqI9RTtwzPy5V+n4cNdh/msTeVIbqypAQ1FYx9tRb7MLG
	iYN979uEjqYif4DJebrzw8xf5KVy0oXNdsONuPo6MkzyHFwCldMwJUtZ8vG44E5SbsRwSJa6Cxr
	2GGTsfaz2tlmFmJ3HeJjCep1YgxRDfdmHH3wU8LlfhwtTt1WKWVkfa0ym1FobHskD7K2mDGVVE=
X-Google-Smtp-Source: AGHT+IFiaNtXy/rVLsjT5705mY3SGXQbf06dDJ0ArITPMCNhObF1PrthWXJhKMLxq0VBwHLLi2NCDJGQFk+zKjmOHP0=
X-Received: by 2002:a05:6e02:1708:b0:423:f113:749d with SMTP id
 e9e14a558f8ab-42d0eb43781mr56890365ab.4.1759238443374; Tue, 30 Sep 2025
 06:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
 <20250927-printk_legacy_thread_console_lock-v2-3-cff9f063071a@thegoodpenguin.co.uk>
 <84ldlwjdmz.fsf@jogness.linutronix.de>
In-Reply-To: <84ldlwjdmz.fsf@jogness.linutronix.de>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Tue, 30 Sep 2025 14:20:32 +0100
X-Gm-Features: AS18NWBoKyMkWcS5Lh1H8LGvmoRvw5m41BOpB__IygLMqoiwtAoiodvrJ5bRhTs
Message-ID: <CALqELGx05kdGzVDtDXD=cAiSK8vrbON24qHRZPX-mYGV_8t8DQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] printk: Use console_flush_one_record for legacy
 printer kthread
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Sept 2025 at 14:03, John Ogness <john.ogness@linutronix.de> wrote:
>
> On 2025-09-27, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index e2c1cacdb4164489c60fe38f1e2837eb838107d6..2c9b9383df76de956a05211537264fd6e06366da 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3668,17 +3668,29 @@ static bool legacy_kthread_should_wakeup(void)
> >
> >  static int legacy_kthread_func(void *unused)
> >  {
> > -     for (;;) {
> > -             wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());
> > +     bool any_progress;
> > +
> > +wait_for_event:
> > +     wait_event_interruptible(legacy_wait,
> > +                              legacy_kthread_should_wakeup());
> > +
> > +     do {
> > +             bool any_usable;
> > +             bool handover = false;
> > +             u64 next_seq;
>
> Please sort by length. It looks nicer. ;-)
>
>                 bool handover = false;
>                 bool any_usable;
>                 u64 next_seq;

I agree :)


>
> Note that it is fine that @any_usable is not initialized here because
> legacy_kthread_func() does not actually care about this variable.

Yes, that's correct. I wasn't sure whether to set it to something
which would likely get optimised away, or if there was some way I
could mark it as not used (didn't see anything beneficial).

Thanks,

Andrew Murray

>
> John

