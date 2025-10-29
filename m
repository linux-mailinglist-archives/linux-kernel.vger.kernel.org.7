Return-Path: <linux-kernel+bounces-877159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19303C1D553
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA313BC6C1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083C130E0F3;
	Wed, 29 Oct 2025 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aCX0u5ar";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wuPmDJra"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4291284890
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771642; cv=none; b=iZlpfRer24czJx9s8OGlhRPE2lqbHew6GeAUEf2yIHWmNAbPHoj4DzxAteHSemnMcPqzXS3arft8R2o09ohepZsYRgjTj9bynFrfkSecwYe/v/S+w2/ZPgytpvgYo0c7j7NfEfwkX3f+8r64nhyXPAklhH2IVSAkXlUDiaemVK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771642; c=relaxed/simple;
	bh=67GnMlwNA1K+5IMeXZ58R0V8ELyqNiyis8VU62GGv2o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sxq5GMCMFWGhbfXutJzUge2KVXYeYeo1BK+XFx1GWeAmFPgkC0GUez2rxqsPIv5sqYSva/0b0bf7qwfXVNuw7if88NATuBd6HHAvivIguVztRhpToBucqEgGHPX/N5nCbCwq0Spa88NGLdesTulCIj/XhJLcV37nuDEwLQ0HSZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aCX0u5ar; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wuPmDJra; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761771638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qupf6LXbF/UmtslTNyE7DyJC0VuM71s+oWKjeYlo/I=;
	b=aCX0u5arMtbgz+dX1T8mM1PzUGyXGptd7nlGm6ypWJbhhkz1llEme5PaMiGvjar+OX6zPw
	xZMKePP072NL1EQy+T+cK8yPZHt52jmSzyJXLpveAKT2zWynfeD8maepIWB7idsmTf9Yz+
	sIjbhXUrdjaaTAP55MjaKqg9Snz8OyztCutbbf8wpuxFCDUNiL23EYZS9pNwy3LzmnuRfj
	06dk5eW9wYfsrXAIHYas2kOZ6dhkM9zMfv0zIt4rXXOT7Vbn5ooZbc+2+kJlrTtK099xsZ
	vwiMs05eR9mVjSnwX7FIeYc6V0Dlo47raL/cCtL5ai5rvagsILdKeu/ARd1XqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761771638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qupf6LXbF/UmtslTNyE7DyJC0VuM71s+oWKjeYlo/I=;
	b=wuPmDJraZ9tJ+hjoe6N+6Z71dync/Hvy5I5bFKCjEG6nadU5k8TyvtHx8cqCmexHPs/0t9
	tUMRd+LGX1WZsOAQ==
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, Sean
 Christopherson <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch V6 19/31] rseq: Provide and use rseq_update_user_cs()
In-Reply-To: <20251029120405.569f9376@gandalf.local.home>
References: <20251027084220.785525188@linutronix.de>
 <20251027084307.151465632@linutronix.de>
 <20251029120405.569f9376@gandalf.local.home>
Date: Wed, 29 Oct 2025 22:00:37 +0100
Message-ID: <871pmlv2x6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 29 2025 at 12:04, Steven Rostedt wrote:
>> +bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr);
>
> So rseq_debug_update_user_cs() is always declared.

And?

>> +#ifdef RSEQ_BUILD_SLOW_PATH
>
> But the function is only defined if RSEQ_BUILD_SLOW_PATH is defined.

Right.
>
> There's no:
>
> #else
>
> bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs,
> 			       unsigned long csaddr)
> {
> 	return false;
> }

And why would you need that?
>> +	if (static_branch_unlikely(&rseq_debug_enabled))
>> +		return rseq_debug_update_user_cs(t, regs, csaddr);
>
> Wouldn't the above reference to rseq_debug_update_user_cs() fail to build
> if RSEQ_BUILD_SLOW_PATH is not defined?
>
> Or am I missing something?

Yes. None of this is compiled at all when CONFIG_RSEQ=n.

When CONFIG_RSEQ=y then the slowpath muck is compiled into kernel/rseq.c
because that file defines RSEQ_BUILD_SLOW_PATH.

> I see that it looks like RSEQ_BUILD_SLOW_PATH is always defined, but why
> have this logic if it can't be not defined?

The fastpath inline version is compiled into the entry code and that
does not define RSEQ_BUILD_SLOW_PATH and therefore needs the
unconditional forward declaration of the debug function.

I made it this way because I wanted to keep the debug and non-debug
version next to each other as it's simpler that way to keep them in sync
instead of forgetting about the other variant because it's in a
different file.

Thanks,

        tglx

