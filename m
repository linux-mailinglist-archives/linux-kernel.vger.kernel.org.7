Return-Path: <linux-kernel+bounces-874852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FADC173DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915593B3AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061A436A5EB;
	Tue, 28 Oct 2025 22:53:28 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF95236A5E6
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692007; cv=none; b=mFPv1iEnLMIQgZ+21sMibtCZoVPa9CHi+W5TO+K8yN+bsimYHC5QbV5TJrk4eYV+B+dnkPYpMz3+FQ6z3o/MpkCuIXWvNPZQYuNoaW8Wxr/4t/xR3R1QSCjAlT9w1tC6iTmc1K52eX3PPhsssXVJljzjBM+TBmNdcRtWa/DAYsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692007; c=relaxed/simple;
	bh=VA/50lW1vCkT731hgvkr6oq1CNTztzPrIPAiyjCETNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIgf0iIX7raC2vrBTcWdIizKXzFPpx6R/D90ngPSDD7X0mICkqPihiRQhHdWiIT9QY98hxZP1vMZhupEM10laAX2+ttoml1U0dSCAn1jCzrr5PzD+u9IYnoNoeBz9eMZgW/zHeiPzxgBTxntHq6spPtmaiAf16xQpNvqManIJuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b63e5da0fdeso643624a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761692005; x=1762296805;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjSnd5l8S3dUErL7gowllXRoXAKycS7W8eLKtMWtz7w=;
        b=VyJCFkAQPwLksqZkCtfljclAoFoe3wF6fDG2m+vJ0sTXb80rS24ipmjHk77bjGq0fW
         0/0h/X1pgb62TleBDbxHFZsXHwkCKkemCLokyxFS5vs7DOb+3jhLkOw11Ux+7DnRZgK9
         nf+G023N7Rcp4YRiDTjjARBIbmFla/Yt+u3c9nebtdt8Bn3eWTzpBgJBQjC4Rcv9ERaA
         JpEGyjPsszK4Ksnd//N7N5LgKV+xk1FGjT+ljbXoepm40RzEdJjJ1eeSgmDkLE+tVqC+
         +pV/juEpY2B3AotjpFATmlbzCFquHOzDFjw2E/7uvgUToouAn1cl3VTtVbcYgKsy4qes
         Azlg==
X-Forwarded-Encrypted: i=1; AJvYcCWwOU+mQsHd3PDIXEMKVnsoXXAgXSkdRF+DUhcYh2XWUSzP/a+0xgyjLZd5zJcfdVzA8uVQnglp+p/Y4IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBGd21PyOElZQYYu7MSgTRyVWChy5E+IEVmzLcJQSr0ONlryN1
	B8TRw9HvKnSJ8ScRUmCXDtZsb73cAlWIl6ri7djr7/iRTUQbI/+udkZI
X-Gm-Gg: ASbGncvx3EuNVCTC1vcTL4y4dBso/Rxu0+BDb18cpsB6SosLaj8pjjfa766+WExPTR8
	XheyhNYxocDk7uxoAp9/rGVIexV1lcILXwyT0fNuC9YoSGRa0DuXOvarFZMv+djB73RACzV7y0p
	2Nqvm+HkU+CBhbKLEO4Y7b+RQTbgMq1soS+2qtH71jS5swprOU1ohTQxbXLekmAlmQXrcrMyX0L
	inVrgF5B1wNc8+ZkTwPEfK4H4Ec0YEp8L46d7ofGlqO8sdpHWlKrqOH9WHaKxKgmRJ5smg1eHMC
	jbW5ClLx/isGkJLi7+Yb2DWsc2tdQ1wetHdMP9P6kopgMmticGmBzYON/i0M43hwYAGyHZ1Aeqr
	fFJI/ZzQ3S8jDzN2Cxfp4O7AxJeAPF6SRt16xAtkQbIK2rZtNl1TDPDlw3snZNQS8pPL/qv4jab
	LAjN1FJLnL8nYT//AnjqtWfv7oPT6CEnI9z0riFcEnqv2yK5Fnh7g2BCMpVGh6QRyElxCKsFSBB
	w1q
X-Google-Smtp-Source: AGHT+IEG6YZVGR3FN78i1rQlW8UfbphShHXpGFbD0oLHzjMRZ6d3TKgzn5msHJQixINYVCaCn2PhVQ==
X-Received: by 2002:a05:6a20:258c:b0:2e3:a914:aabe with SMTP id adf61e73a8af0-34652718874mr468308637.2.1761692004971;
        Tue, 28 Oct 2025 15:53:24 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712f4a8833sm11430147a12.37.2025.10.28.15.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 15:53:24 -0700 (PDT)
Message-ID: <eed6ff19-a944-4e4c-96e4-0f44e888c71d@kzalloc.com>
Date: Wed, 29 Oct 2025 07:53:20 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] Detecting Sleep-in-Atomic Context in PREEMPT_RT via RV
 (Runtime Verification) monitor rtapp:sleep
To: Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <nam.cao@linaro.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Tomas Glozar <tglozar@redhat.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Byungchul Park <byungchul@sk.com>, syzkaller@googlegroups.com,
 linux-rt-devel@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
References: <32839fb6-dbcb-4c5c-9e3f-d46f27ae9a73@kzalloc.com>
 <d23d133b52ef574d669f1656789b78d07c91c9f5.camel@redhat.com>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <d23d133b52ef574d669f1656789b78d07c91c9f5.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gabriele,

On 10/27/25 9:20 PM, Gabriele Monaco wrote:
> On Mon, 2025-10-27 at 15:54 +0900, Yunseong Kim wrote:
>> Hi Nam,
>>
>> I've been very interested in RV (Runtime Verification) to proactively detect
>> "sleep in atomic" scenarios on PREEMPT_RT kernels. Specifically, I'm looking
>> for ways to find cases where sleeping spinlocks or memory allocations are used
>> within preemption-disabled or irq-disabled contexts. While searching for
>> solutions, I discovered the RV subsystem.
>>
> 
> Hi Yunseong,
> 
> I'm sure Nam can be more specific on this, but let me add my 2 cents here.

Thank you so much for your detailed response! It cleared up many of the
questions I had.

> The sleep monitor doesn't really do what you want, its violations are real time
> tasks (typically userspace tasks with RR/FIFO policies) sleeping in a way that
> might incur latencies. For instance using non PI locks or imprecise sleep.

So that’s the role of rtapp:sleep you mentioned. Thank you again for
clarifying it.

> What you need here is to validate kernel code, RV was actually designed for
> that, but there's currently no monitor that does what you want.

It’s a valuable chance to make a contribution to RV!

> The closest thing I can think of is monitors like scpd and snep in the sched
> collection [1]. Those however won't catch what you need because they focus on
> the preemption tracepoints and schedule, which works fine also in your scenario.
> 
> We could add similar monitors to catch what you want though:
> 
>                      |
>                      |
>                      v
>                    +-----------------+
>                    |   cant_sleep    | <+
>                    +-----------------+  |
>                      |                  |
>                      | preempt_enable   | preempt_disable
>                      v                  |
>     kmalloc                             |
>     lock_acquire                        |
>   +---------------      can_sleep       |
>   |                                     |
>   +-------------->                     -+
> 
> which would become slightly more complicated if considering irq enable/disable
> too. This is a deterministic automaton representation (see [1] for examples),
> you could use an LTL like sleep as well, I assume (needs a per-CPU monitor which
> is not merged yet for LTL).
> 
> This is simplified but you can of course put conditions on what kind of
> allocations and locks you're interested in.

If the goal is to detect this state before the output from __might_resched()
under CONFIG_DEBUG_ATOMIC_SLEEP (i.e., before an actual context switch occurs),
I am considering whether Deterministic Automata (.dot/DA) or Linear Temporal
Logic (.ltl/LTL) would be more appropriate for modeling this check. I'm also
thinking about whether I need to create a comprehensive table of all sleepable
functions for this purpose on the PREEMPT_RT kernel.

If this check is necessary, I’m planning to try the following verification:

RULE = always ((IN_ATOMIC or IRQS_DISABLED) imply not CALLS_RT_SLEEPER)

I’m also planning to add sleepable functions, including sleepable spinlocks
and memory allocations callable under PREEMPT_RT preempt/IRQ-disabled states,
to the RV monitor kernel module.

I’m considering adding the following functions as a result:

 // Mutex & Semaphore (or Lockdep's 'lock_acquire' for lock cases)
 "mutex_lock",
 "mutex_lock_interruptible",
 "mutex_lock_killable",
 "down_interruptible",
 "down_killable",
 "rwsem_down_read_failed",
 "rwsem_down_write_failed",
 "ww_mutex_lock",
 "rt_spin_lock",
 "rt_read_lock",
 "rt_write_lock",
 // or just "lock_acquire" for LOCKDEP enabled kernel.

 // sleep & schedule
 "msleep",
 "ssleep",
 "usleep_range",
 "wait_for_completion",
 "schedule",
 "cond_resched",

 // User-space memory access
 "copy_from_user",
 "copy_to_user",
 "__get_user_asm",
 "__put_user_asm",

 // memory allocation
 "__vmalloc",
 "__kmalloc"

> Now this specific case would require lockdep for the definition of lock_acquire
> tracepoints. So I'm not sure how useful this monitor would be since lockdep is
> going to complain too. You could use contention tracepoints to catch exactly
> when sleep is going to occur and not /potential/ failures.

I’ll look into this lockdep realated part further as well.

> I only gave a quick thought on this, there may be better models/event fitting
> your usecase, but I hope you get the idea.
> 
> [1] - https://docs.kernel.org/trace/rv/monitor_sched.html#monitor-scpd

Thank you for providing a diagram and references that make it easier to
understand!

>> Here are my questions:
>>
>> 1. Does the rtapp:sleep monitor proactively detect scenarios that
>>    could lead to sleeping in atomic context, perhaps before
>>    CONFIG_DEBUG_ATOMIC_SLEEP (enabled) would trigger at the actual point of
>>    sleeping?
> 
> I guess I answered this already, but TL;DR no, you'd need a dedicated monitor.
> 
>> 2. Is there a way to enable this monitor (e.g., rtapp:sleep)
>>    immediately as soon as the RV subsystem is loaded during boot time?
>>    (How to make this "default turn on"?)
> 
> Currently not, but you could probably use any sort of startup script to turn it
> on soon enough.
> 
>> 3. When a "violation detected" message occurs at runtime, is it
>>    possible to get a call stack of the location that triggered the
>>    violation? The panic reactor provides a full stack, but I'm
>>    wondering if this is also possible with the printk reactor.
> 
> You can use ftrace and rely on error tracepoints instead of reactors. Each RV
> violation triggers a tracepoint (e.g. error_sleep) and you can print a call
> stack there. E.g.:
> 
>   echo stacktrace > /sys/kernel/tracing/events/rv/error_sleep/trigger
> 
> Here I use sleep as an example, but all monitors have their own error events
> (e.g. error_wwnr, error_snep, etc.).
> 
> Does this all look useful in your scenario?

Thank you once again for your thorough explanation. Many of the questions
I initially had have now been resolved!

> Gabriele

Best regards,
Yunseong Kim

