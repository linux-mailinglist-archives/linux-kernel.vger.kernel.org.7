Return-Path: <linux-kernel+bounces-796734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A17B40684
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B52B16E855
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4DA2F6192;
	Tue,  2 Sep 2025 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ppiBttP4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PG7HWZ1R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8122DAFB8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822657; cv=none; b=Xf2y2IFmMCiwOF+Qvj0hnQNa3DlSAEm47uPpehg9cAChb9Nhskv0pjG1kg2+pVbmv5riNGbb0nrcm/7sndwBdWD5VKeNdN/bx4JWyY+BGuAkV+gwKv3kKO7HARY690PFPLKtCNcF/1ZH4nL668YU9KZGMCWWymJSEgPL31QwEfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822657; c=relaxed/simple;
	bh=Pxyx5iPddH8aT71rSvsXK11OV1UOc1DYXFIXwoCOTkY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CifODWFnsJ2KXe4r09e9PWaII8jq4fO6rdaU2IMiVZmA1M9GtUJbLw4tLTcS+on+o0aX9/LunHzdeiQBpBbfyzFN5BMA/LapqLgvCYLL67B3uC1vY5s7dcuP3DorvjTJLgGSFi3LHFFVkNJCcySWgWAFYvjVTLdKDjFYU6nDugU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ppiBttP4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PG7HWZ1R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756822653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OLJUbTQJEsPkAlDhCahmfCTcArL/3hREBdOQgBkQH+k=;
	b=ppiBttP4Xl/aCFbqywCKvACq8AVkoNosWJHCAYYFzKnlR7gh4WHlCS1F9K3Hxi9NMkRL+D
	qlDLgqx53CdAzWocvojOdHa7/un3ee0kQaOF16nN/GtVV81aenDHbg3extUnhi5NoyMkiF
	+KpLsCevUKcQa9CMci23RGloPoMzTGObLIOrlXhA6/6sKtQsT2BLW6yokYBLKLz1FDjVsr
	0R5c+wJrEfMS1SDYINJm1wyac3yw40cOPjiGHf6VrqNnBQqcv9Aqa7sr9JCgbAOqqDWi5D
	SzpjEuGxakOd4O3rRd8Ix2d+TaWs/I/FQdRhM59QzWp71/NRhI5bfoqz/tMk6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756822653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OLJUbTQJEsPkAlDhCahmfCTcArL/3hREBdOQgBkQH+k=;
	b=PG7HWZ1Ru3xOi/kbfqeyGyBn2laQ9FNhDc8sDYX4w7NKVxVUWmfl+Y2pvhFJfaZsA18ofQ
	cCewoiZlAZaDBOAg==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Sean
 Christopherson <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Huacai
 Chen <chenhuacai@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patch V2 26/37] rseq: Optimize event setting
In-Reply-To: <80f966ea-d8a5-401d-ad2f-dba5035cce0c@efficios.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161654.935413328@linutronix.de>
 <80f966ea-d8a5-401d-ad2f-dba5035cce0c@efficios.com>
Date: Tue, 02 Sep 2025 16:17:32 +0200
Message-ID: <875xe10whv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 26 2025 at 11:26, Mathieu Desnoyers wrote:
>> Add a event flag, which is set when the CPU or MM CID or both change.
>
> We should figure out what to do for powerpc's dynamic numa node id
> to cpu mapping here.

:)

> The combination of patch
> "rseq: Simplify the event notification" and this
> ends up moving those three rseq_migrate events to __set_task_cpu:
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index be00629f0ba4..695c23939345 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3364,7 +3364,6 @@ void set_task_cpu(struct task_struct *p, unsigned 
> int new_cpu)
>                  if (p->sched_class->migrate_task_rq)
>                          p->sched_class->migrate_task_rq(p, new_cpu);
>                  p->se.nr_migrations++;
> -               rseq_migrate(p);
>                  sched_mm_cid_migrate_from(p);
>                  perf_event_task_migrate(p);
>          }
> @@ -4795,7 +4794,6 @@ int sched_cgroup_fork(struct task_struct *p, 
> struct kernel_clone_args *kargs)
>                  p->sched_task_group = tg;
>          }
>   #endif
> -       rseq_migrate(p);
>          /*
>           * We're setting the CPU for the first time, we don't migrate,
>           * so use __set_task_cpu().
> @@ -4859,7 +4857,6 @@ void wake_up_new_task(struct task_struct *p)
>           * as we're not fully set-up yet.
>           */
>          p->recent_used_cpu = task_cpu(p);
> -       rseq_migrate(p);
>          __set_task_cpu(p, select_task_rq(p, task_cpu(p), &wake_flags));
>          rq = __task_rq_lock(p, &rf);
>          update_rq_clock(rq);
>
> AFAIR those were placed in the callers to benefit from the conditional
> in set_task_cpu():
>
>          if (task_cpu(p) != new_cpu) {
>
> perhaps it's not a big deal, but I think it's relevant to point it out.

They ended up setting the event all over the place. The only relevant
point which matters is __set_task_cpu().

Thanks,

        tglx

