Return-Path: <linux-kernel+bounces-777482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C613B2D9F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B09E1C272F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17E62E040D;
	Wed, 20 Aug 2025 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gylopjft"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D635E24339D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755685344; cv=none; b=MhGNUrD2fGwaEGsz7On8Qr/ASGTA9bI3mkrhWlR9iFou3qVM1WZHilNzSikaQFlqgwqB2g8oMpCkLI8QYzKoOgz6WrIuobAXtdpQfMoR94dL5Iph8z5sBuz+Gvamar3B1lTONLjP2AVbUc4EYLf4LGEY9/64d+5fMn7AuFErAkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755685344; c=relaxed/simple;
	bh=0MIxxlnsFlE6wMohjAf52vfPhSPMrRKH08nE3rYNXbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TI1ic6ypZOq8JJ+v9L/bFkZ9vAmzZ/UkEjvROvzTA88B2vxcVMK1Pubgl+INOdTRQcezrEjqK7LV6FSduciW8/x7IuftJTCP3gqwy/jC5yHjfsVLi26D75/AkvjfqAfPC9bTNp/Bn8eWf8t7Dmdwgd+wMxVyxOc4zTgTfN6Jg0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gylopjft; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6188b5b11b2so7754325a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 03:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755685340; x=1756290140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zFC5QnIalTSrK7rWNbwCun2cktTHrJwzb5OTVlazBro=;
        b=gylopjfthDg/Z6ZUbdIVG5N25mvWJk45AoiUVege4c4QbCEgHO7yUXCBj2TK4MgS3M
         y9Ohad5JxXr5tM0Lpkgw2yhmcIeRjgruP6GCMXj3MeY7OzBBlk0gG73PyRFvZ0gpJ6kY
         Bcy8q2+7laReoCvUKC60oL73jpeRRHCjWF5IO51/8UbEYdaQ4M0dXIgGa8qY6ko1i7UP
         bbkP8V6/60LTqo4LB+UflAAfiMdZCONIWAOZ5P6PVdvsHPFkqLcaTMLF2LaO3KW5Hku6
         9+JRUqJK+Teaa2N93PWtXHc0mIrPqXCdBVu5GTsSC+wUni8QzKR56xs2XujIwBhaH1yf
         9YFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755685340; x=1756290140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFC5QnIalTSrK7rWNbwCun2cktTHrJwzb5OTVlazBro=;
        b=OWeZ7mIDJE8j+Q1JfHgLpB2g7ikEyt3CndBiWWRARnIT5jgQEtDqLT8jo0LlCRvW8Y
         qvtGdPHB3qKh1LTuXaH9DUI5sj5MQSrvyij6PW7S30ESdBpp7OVYmW4OkuYj9mzXQAhI
         te2sUKrCGyph0KT8mV9hFPEvczmAdwzKLIxjyVDI2Nj0vOQDrIIemRmEazFwF6UtzK9f
         HhgURs5RzIYUhuHST80GWAMRyAvScjmTeYiHhDbWciKwITh4GAGzylvhb14Y/edu35Km
         YARxC1byoEpJuZYqIAHKssIWX2/uMuxbhxFr81WMDwF4XOdYGRUyBn5bPisbJvS74v2A
         uU3w==
X-Forwarded-Encrypted: i=1; AJvYcCVnaWszXBftxQ1tvXMP0fLUaKMWhf7Z7jx1Ncnze2RAAfL3lyXPS/WpzEKVnFTM0jbOpSlILVFvXVcObOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRSP4MDsxeOQMf1M5Gu8wqf69OG7NDahf4wCmIl1qXt6ZPQHjf
	Aa3TnbzQtx676LT6feOxTMb0uB6R7l/3ukaaSYGY0aMK0nTfHsjaD5rbIrolN433mo3P34Vs5F4
	D3ei3
X-Gm-Gg: ASbGncvMzOy+siHcx5zbbxs4/hPaGr4KjZTaSlS9YKVTuSqVuAQhZZhQukTMr1Wz15X
	T8YYhyH8YG7Kt0Mjtv5kKDFc32Kw74pYcBj+55QZ35kXYh67WLAJZ669Pnktb3KGNhuVBPSkSn8
	SzZySJPjz2bVFGhNeGYGPfk1+0ZcHPZCGgg6Yhs38gjiA2GDEi0vfXYDm1eKbrfqjRtvsfOtRBy
	O9/6vSAwTgE0XNWyjZr/E6/aaE6EFA5A9XewqPMdykammEX/lOzUQoflMJJ1SP9HbJ/SbiMJUaO
	Evl3nMj7Wvvex/EgaTPmuxxaqylLN76Tp4SNlyGql/QeFhQzp5rCGAZ3igwZflh1Y5W+KBp3bdv
	C0vVsFH2gVVtC12r6S4x1eKHqLQ==
X-Google-Smtp-Source: AGHT+IFniwEUqFY61/eSW8b97xvSqR+1n4hgqzUbi0jHyu6onDS0pFv41RvZW/MhYd1VcaT1HB1CiQ==
X-Received: by 2002:a05:6402:23d3:b0:618:adff:7f42 with SMTP id 4fb4d7f45d1cf-61a9752c3a8mr2080966a12.6.1755685340040;
        Wed, 20 Aug 2025 03:22:20 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a755d9f3bsm3217563a12.1.2025.08.20.03.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 03:22:19 -0700 (PDT)
Date: Wed, 20 Aug 2025 12:22:17 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jinchao Wang <wangjinchao600@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: John Ogness <john.ogness@linutronix.de>,
	Joel Granados <joel.granados@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Sravan Kumar Gundu <sravankumarlpu@gmail.com>,
	Ryo Takakura <takakura@valinux.co.jp>, linux-kernel@vger.kernel.org,
	Wei Liu <wei.liu@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] panic: call hardlockup_detector_perf_stop in panic
Message-ID: <aKWh2R0ZVZ7nnLiw@pathway.suse.cz>
References: <20250730030638.65355-1-wangjinchao600@gmail.com>
 <aKSRzbUvuEkVz-Gk@pathway.suse.cz>
 <970366ee-0fc0-4a64-816e-3c3ac738e24a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <970366ee-0fc0-4a64-816e-3c3ac738e24a@gmail.com>

Adding Peter Zijlstra into Cc.

The nested panic() should return. But panic() was never supposed to
return. It seems that it is not marked as noreturn but I am not sure
whether some tricks are not hidden somewhere, in objtool, or...

On Wed 2025-08-20 14:22:52, Jinchao Wang wrote:
> On 8/19/25 23:01, Petr Mladek wrote:
> > On Wed 2025-07-30 11:06:33, Wang Jinchao wrote:
> > > When a panic happens, it blocks the cpu, which may
> > > trigger the hardlockup detector if some dump is slow.
> > > So call hardlockup_detector_perf_stop() to disable
> > > hardlockup dector.
> > 
> > Could you please provide more details, especially the log showing
> > the problem?
> 
> Here's what happened: I configured the kernel to use efi-pstore for kdump
> logging while enabling the perf hard lockup detector (NMI). Perhaps the
> efi-pstore was slow and there were too many logs. When the first panic was
> triggered, the pstore dump callback in kmsg_dump()->dumper->dump() took a
> long time, which triggered the NMI watchdog. Then emergency_restart()
> triggered the machine restart before the efi-pstore operation finished.
> The function call flow looked like this:
> 
> ```c
> real panic() {
> 	kmsg_dump() {
> 		...
> 		pstore_dump() {
> 			start_dump();
> 			... // long time operation triggers NMI watchdog
> 			nmi panic() {
> 				...
> 				emergency_restart(); //pstore unfinished
> 			}
> 			...
> 			finish_dump(); // never reached
> 		}
> 	}
> }
> ```
> 
> This created a nested panic situation where the second panic interrupted
> the crash dump process, causing the loss of the original panic information.

I believe that we should prevent the nested panic() in the first
place. There already is the following code:

void vpanic(const char *fmt, va_list args)
{
[...]
	 * Only one CPU is allowed to execute the panic code from here. For
	 * multiple parallel invocations of panic, all other CPUs either
	 * stop themself or will wait until they are stopped by the 1st CPU
	 * with smp_send_stop().
	 *
	 * cmpxchg success means this is the 1st CPU which comes here,
	 * so go ahead.
	 * `old_cpu == this_cpu' means we came from nmi_panic() which sets
	 * panic_cpu to this CPU.  In this case, this is also the 1st CPU.
	 */
	old_cpu = PANIC_CPU_INVALID;
	this_cpu = raw_smp_processor_id();

	/* atomic_try_cmpxchg updates old_cpu on failure */
	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
		/* go ahead */
	} else if (old_cpu != this_cpu)
		panic_smp_self_stop();


We should improve it to detect nested panic() call as well,
something like:

	this_cpu = raw_smp_processor_id();
	/* Bail out in a nested panic(). Let the outer one finish the job. */
	if (this_cpu == atomic_read(&panic_cpu))
		return;

	/* atomic_try_cmpxchg updates old_cpu on failure */
	old_cpu = PANIC_CPU_INVALID;
	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
		/* go ahead */
	} else if (old_cpu != this_cpu)
		panic_smp_self_stop();


> > That said, it might make sense to disable the hardlockup
> > detector during panic. But I do not like the proposed way,
> > see below.
> > 
> > > --- a/kernel/panic.c
> > > +++ b/kernel/panic.c
> > > @@ -339,6 +339,7 @@ void panic(const char *fmt, ...)
> > >   	 */
> > >   	local_irq_disable();
> > >   	preempt_disable_notrace();
> > > +	hardlockup_detector_perf_stop();
> > 
> > Anyway, it does not look safe. panic() might be called in any context,
> > including NMI, and I see:
> > 
> >   + hardlockup_detector_perf_stop()
> >     + perf_event_disable()
> >       + perf_event_ctx_lock()
> >         + mutex_lock_nested()
> > 
> > This might cause deadlock when called in NMI, definitely.
> > 
> > Alternative:
> > 
> > A conservative approach would be to update watchdog_hardlockup_check()
> > so that it does nothing when panic_in_progress() returns true. It
> > would even work for both hardlockup detectors implementation.
> Yes, I think it is a better solution.
> I didn't find panic_in_progress() but found hardlockup_detector_perf_stop()
> available instead :)
> I will send another patch.

OK.

Best Regards,
Petr

