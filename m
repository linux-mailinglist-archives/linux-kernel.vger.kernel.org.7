Return-Path: <linux-kernel+bounces-814228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 864EAB5514A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF195C049D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C003101B2;
	Fri, 12 Sep 2025 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v5uVUc/Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pEacxfmj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA61F92E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686952; cv=none; b=QfK39FKJtaCJ2Y1E+++/CdcjwCT9Q9q/JHbSscTBRjZ29CznxjFceCUJPwlz/voJ1adSvPJ44GJSA0cfV0rXXREkoSgoRYzitGoOLvgp6TOX9J/oRq8qGVqrP6rRnAxSxPgX9qrfwIov9dpCbZUNWyClh6S3pwPdKACrPyTe96E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686952; c=relaxed/simple;
	bh=+kONGBz/wgiRVWFuJx4MySvfB+RSpP7jYoWHJ8d4/WU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gmOCLYFLw3MaoP7IcmCLXJeY2gaoALNCKl0iF2c7eBgXvUuxtzMgEEQeADxf1e6bRtHtltDevEm5he23ltn+9U4EVTmOlDSrqTczXWvXVq+yfJRp9zX+yV8sJAqhjXk0MnEc/uN0zC0zoo6JAhErI4AmFs1LnT3MN30T/g5N0j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v5uVUc/Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pEacxfmj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757686947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=68BF7jsNwtv28FOkFisnMQyz/hSEG+qt4Wf8uH4/ZCY=;
	b=v5uVUc/Z/DsOc/AKjOHlWHQWdrEWT5NEhNQYGfm9txID5rFKakBPz0tkutUF1aLtO9nrK/
	d9d/E648svcEQhgBGg085WeJu+MMwhf76+qQjSqqJqwaIavDs9NdU8lfYXDiBX2TE28KXN
	iqzBvWHpwpOvNtOqsAF8vHazz9wPGFZJIYs15W4kf9B5ZsyjkS7n8tvyWeLkq+O0ikMOCv
	H+Sqf1JNOPbpRLb8Y6iZLRkW6NcP6fqF13Bx/x8QORemv7yMW8Wy53WqKFWto15597xCpu
	NtAK+GYT6nse7IUnKbFLjJE38DhKRXeh5H6QHsxymCMzfGJE/mArj6OmLV+jNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757686947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=68BF7jsNwtv28FOkFisnMQyz/hSEG+qt4Wf8uH4/ZCY=;
	b=pEacxfmj8aj+49PJRLgTgTHPgBHvhN+C4JkCAmA+65RU8rgk3i+UjibCNmJX/xmrSibWAJ
	XlCZ7n32zNYj8MDw==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patch V4 28/36] rseq: Switch to fast path processing on exit
 to user
In-Reply-To: <cda37321-691d-47db-8b71-7a79dedb4bb6@efficios.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212927.058801648@linutronix.de>
 <84d9beb2-85e7-4fc0-b403-0514bd87ae8b@efficios.com> <87v7lpq6l7.ffs@tglx>
 <cda37321-691d-47db-8b71-7a79dedb4bb6@efficios.com>
Date: Fri, 12 Sep 2025 16:22:26 +0200
Message-ID: <87frcrrbrx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 11 2025 at 16:00, Mathieu Desnoyers wrote:
> On 2025-09-11 12:47, Thomas Gleixner wrote:
>> The normal case is that the fault is pretty much guaranteed to happen
>> because the scheduler places the child on a different CPU and therefore
>> the CPU/MM IDs need to be updated anyway.
>
> Is this "normal case" the behavior you wish the scheduler to have or
> is it based on metrics ?

I did measurements and that's how I came to the conclusion. I measured
forks vs. faults in the page which holds the RSEQ memory, aka. TLS.

> Here is the result of a sched_fork() instrumentation vs the first
> pick_next_task that follows for each thread (accounted with schedstats
> see diff at the end of this email, followed by my kernel config), and we
> can observe the following pattern with a parallel kernel build workload
> (64-core VM, on a physical machine that has 384 logical cpus):
>
> - When undercommitted, in which case the scheduler has idle core
>    targets to select (make -j32 on a 64-core VM), indeed the behavior
>    favors spreading the workload to different CPUs (in which case we
>    would hit a page fault on return from fork, as you predicted):
>    543 same-cpu vs 62k different-cpu.
>    Most of the same-cpu are on CPU 0 (402), surprisingly,
>
> - When using all the cores (make -j64 on a 64-core VM) (and
>    also for overcommit scenarios tested up to -j400), the
>    picture differs:
>    27k same-cpu vs 32k different-cpu, which is pretty much even.

Sure. In overcommit there is obviously a higher probability to stay on
the same CPU.

> This is a kernel build workload, which consist mostly of
> single-threaded processes (make, gcc). I therefore expect the
> rseq mm_cid to be always 0 for those cases.

Sure, but that does not mean the CPU stays the same.

>> The only cases where this is not true, are when there is no capacity to
>> do so or on UP or the parent was affine to a single CPU, which is what
>> the child inherits.
>
> Wrong. See above.

Huch? You just confirmed what I was saying. It's not true for
overcommit, i.e. there is no capacity to do place it on a different CPU
right away.

> Moreover, a common userspace process execution pattern is fork followed
> by exec, in which case whatever page faults happen on fork become
> irrelevant as soon as exec replaces the entire mapping.

That's correct, but for exec to happen it needs to complete the fork
first and go out to user space to do the exec without touching TLS and
without being placed on a different CPU, right?

So again, that depends on the ability of placement where this ends up.

>> the fault will happen in the fast path first, which means the exit code
>> has to go another round through the work loop instead of forcing the
>> fault right away on the first exit in the slowpath, where it can be
>> actually resolved.
>
> I think you misunderstood my improvement suggestion: I do _not_
> recommend that we pointlessly take the fast-path on fork, but rather
> than we keep the cached cpu_cid value (from the parent) around to check
> whether we actually need to store to userspace and take a page fault.
> Based on this, we can choose whether we use the fast-path or go directly
> to the slow-path.

That's not that trivial because you need extra an extra decision in the
scheduler to take the slowpath based on information whether that's the
first schedule and change after fork so the scheduler can set either
TIF_RSEQ or NOTIFY along with the slowpath flag.

But that's just not worth it. So forcing the slowpath after fork seemed
to be a sensible thing to do.

Anyway, I just took the numbers for a make -j128 build on a 64CPU
systems again with the force removed. I have to correct my claim about
vast majority for that case, but 69% of forked childs which fault in the
TLS/RSEQ page before exit or exec is definitely not a small number.

The pattern, which brought me to actually force the slowpath
unconditionally was:

  child()
  ...
  return to user:

    fast_path -> faults
    slow_path -> faults and handles the fault
    fast_path    (usually a NOOP, but not necessarily)
    done

Though I'm not insisting on keeping the fork force slowpath mechanics.

As we might eventually agree on, it depends on the workload and the
state of the system, so the milage may vary pretty much.

Thanks,

        tglx

