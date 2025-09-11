Return-Path: <linux-kernel+bounces-812482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9715DB538BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FC1188D174
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A063126D3;
	Thu, 11 Sep 2025 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gSTdd235";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZB+mVSl6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A9F2E8B64
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606779; cv=none; b=IJgL1WWsin5LJFD7LJIQMOBTnENlXbJt1Tme5j6D02r7Piz35EUinBTuJ5poEt+fny+AXLNUkiZBWkYD9TRdbVV/cMwjE1IQreKriTvSrDhqGdGKlc0g9kRvwJTRmnVM1PnO7OFSf3FxMex007BknUy8v3b2iPOMx/SPzCC7n74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606779; c=relaxed/simple;
	bh=iU2DoUdqIu/41hlO4Et0rRmSpD6vdN9AaGC5KGkS+dE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=njBC2dD3kW0FzpiiI35tJY5WdUpsvRE699tYVU8bg3N0cxjBnZt3inAV1XqI7LWRT9sJ9I1u6Z0TH9WIzG+Q2mHM3AfI+F8xziaYNlmTX6knRUUquV0qf5XQpyDJORclKDcLIYKajXQfQo3CF6n2/3B/dqrZRWdLU9IXzS/BQSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gSTdd235; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZB+mVSl6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757606774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hFzYOLWww3rLOwtwzx5pY9E/jU+fw35Yk7/XtGADgnc=;
	b=gSTdd235J60TO0HDVpw9QqWXwFFy9bAUXDs0jq1dM9r//KU7XsyEzUdkoF5OeTTgsKs3xB
	uTAS5Q7KHiqcG+zYrXvIB9ljcBOoW6hdpj2xc/x0XLPqNsmMqv0wDEKx219F5gBBMijj29
	8kD2oY2ygdbpLriJgSrugj/cX+pCUbznICuTktctttKF89OSRPIZvP/iE+a3SO8N5lV0z6
	0rVUyTsGnMsJHX24Sp3BcrACes+na+QnQzY9yIBpCdiioDIt49yxhEWdOYX7xgHuqKvGqy
	X/8V6NvrL5k6+DNb/VT+rgspT/7rPeG1v3ZHbPSN1RqC6OYJipGmZuzRBgrtiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757606774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hFzYOLWww3rLOwtwzx5pY9E/jU+fw35Yk7/XtGADgnc=;
	b=ZB+mVSl6zrHSwolxdMC+4S+azSv0PlSyOLMgM7mfeDaZna6uVcNJry//254fDmR5pbRoSe
	lnSTzGm27q729DAw==
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
Subject: Re: [patch V4 26/36] rseq: Optimize event setting
In-Reply-To: <6e0bcd7c-f842-4db0-b30b-5f6857b45b66@efficios.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212926.929787629@linutronix.de>
 <6e0bcd7c-f842-4db0-b30b-5f6857b45b66@efficios.com>
Date: Thu, 11 Sep 2025 18:06:13 +0200
Message-ID: <871podrn2i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 11 2025 at 10:03, Mathieu Desnoyers wrote:
> On 2025-09-08 17:32, Thomas Gleixner wrote:
>>   static inline void rseq_handle_notify_resume(struct pt_regs *regs)
>>   {
>> -	if (current->rseq.event.has_rseq)
>> +	/* '&' is intentional to spare one conditional branch */
>> +	if (current->rseq.event.sched_switch & current->rseq.event.has_rseq)
>
> I wonder.. except for the corner case of rseq unregistration,
> when can we have sched_switch set but not has_rseq ?
>
> We could remove a load from the fast path and the AND if we
> clear the sched_switch flag on rseq unregistration.

We probably could. Though I doubt it matters much and I opted for
correctness instead of premature optimization.

Thanks,

        tglx

