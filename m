Return-Path: <linux-kernel+bounces-874320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C608FC16060
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D0763561FB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B675345CAF;
	Tue, 28 Oct 2025 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tIvKLku+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SsmRz55a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6E6346E60
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670939; cv=none; b=oWH7fw9TmNDnkihOU5fetokrnVDVHizP5iKxHy5Yy1XE3XWSekDs2UIFOUlgC+g3b7SnavlAr38rj240707l8Iw3qj9HAwu7zoCGXi4z0ox/uMdLNd+pkmK8Q0WF9/fQfgIuWmJy/ea+rM3IwNN5wLpj0jhN+1CPVPTTAS8S810=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670939; c=relaxed/simple;
	bh=mIHCDBneARV/D79vO8G3Q5OixyzPofnVcbazIj+e86E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RIuAoJ0zf+Z0v+4avvvUNiNeiTca9+Tt0TIEoSArPYGIT0dSfM7T6Tw715Iexb3gKfpJ99lRthfaXK5Wz6x+G7mqYIi/Q4v8X3jmShBa15LXSw/ZL5Puati6xZamL8YKFBmDlPLee3TmmOycvyX67E0xkh2g95sBScekYNhMbHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tIvKLku+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SsmRz55a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761670935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EBC2/PaCuZzLlmaXcuxa0lpVptWnhiXtfGRdC3ZzrwI=;
	b=tIvKLku+LWmAzFgI2jF7oUKZdfEq6KXqonqW55TkifjWFG2jmjlTJPpd31TmUy2lPq9oS0
	/Ep9fxihhMQD2n7QzgAWQG7RMuvzEdz4hhWEtT0WPRnxz7lJsRoeereLdc5p630EPidnYp
	LqD9WNyNhLTvgqXh25nz+sLEb1jj79vHJCzHtu/e17JFaFgE+CIGoyC1hsxDGBcgrIr0cy
	xsq/hHcZrjTS9BCTHTv5QAD/f0ZDTu2wbj6wCBWgxtINY8tgoGE1YqcZrHbZBN2HiA0pKk
	C0BkYw7GQixfGULhJ3tW2rkCr+GrEBZcaew4iW/GTxwfoziil9o6+AqgdSRwaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761670935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EBC2/PaCuZzLlmaXcuxa0lpVptWnhiXtfGRdC3ZzrwI=;
	b=SsmRz55ak6H5CXQwRowIPxRIka94QRe1NbkMKGMtC91Wne+G0dh7F2tk4yCDoGrapC27QI
	RnUWqqtTJDVXPyCg==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, x86@kernel.org, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch V6 15/31] rseq: Record interrupt from user space
In-Reply-To: <05d439ae-8f25-4b23-bb0c-3a3ce04eebbe@efficios.com>
References: <20251027084220.785525188@linutronix.de>
 <20251027084306.905067101@linutronix.de>
 <05d439ae-8f25-4b23-bb0c-3a3ce04eebbe@efficios.com>
Date: Tue, 28 Oct 2025 18:02:14 +0100
Message-ID: <87cy67ufhl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 28 2025 at 11:26, Mathieu Desnoyers wrote:
> On 2025-10-27 04:44, Thomas Gleixner wrote:
> [...]
>> @@ -281,6 +281,7 @@ static __always_inline void exit_to_user
>>   static __always_inline void irqentry_enter_from_user_mode(struct pt_regs *regs)
>>   {
>>   	enter_from_user_mode(regs);
>> +	rseq_note_user_irq_entry();
>>   }
>>   
> Looking at x86, both exc_debug_user() and exc_int3() invoke
> irqentry_enter_from_user_mode(), but there are various
> other traps that can come from userspace (e.g. math_error,
> exc_general_protection, ...). Some of those traps don't
> necessarily end with a signal delivery to the offending
> process. And some of those traps enable interrupts.

They all go through irqentry_enter_from_user_mode(). See
DEFINE_IDTENTRY*() macros. They invoke:

   irqentry_enter()
     if (user_mode())
        irqentry_enter_from_user_mode();

If that wouldn't be the case then all the RCU/NOHZ magic would not work
either. So any exception, trap, interrupt must go through this to
establish state correctly. Whether that's explicit as it's required for
int3 and debug_user or implicit through the IDTENTRY magic.

Thanks,

        tglx

