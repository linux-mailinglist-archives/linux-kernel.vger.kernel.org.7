Return-Path: <linux-kernel+bounces-796638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD72B4048C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87E604E3E1E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7683F3126C5;
	Tue,  2 Sep 2025 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JRP3ci48";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jHjJaylY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D637261593
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820367; cv=none; b=cltCVTgLnnTajRHr8ULKWBuuTyCe6T0yVqMC/xwd4GqRc6dVjLham6Y8Rki1awa4tK8owCWiHhSQnuAIUDoIiDz03MXkred9GaAycPLUW/FHkscfivG0kG4x33oupGfJpZZtTqo4XmgFCszQvMGD3ODfkdK7e7LJAMU1rmpmUt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820367; c=relaxed/simple;
	bh=sCow4GCGOxOgvrD4ygMPvUZzAMhRoalVVPAcS3UImVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HmPCN9bEBTD4kurR/1jcxZ1BlZb5jQzt80GNG3PEPA4rC8L8t4ai2p+wbf5I3ZW7ydVuY1TiuouCKQYII5bR/EMR4drXy1Z48kXAJTbThq4eA/BoCyWjrLKRz7yZKXvw4/TugF1pN42QfnW0mNuG64iQaJLhKUExOv1WBgaLoFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JRP3ci48; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jHjJaylY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756820364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSfMqS9MQ8r+pru/P72e11/GlNeLydR+kxwfIp/qzKo=;
	b=JRP3ci48u6sgRaAm+6PR5r6reugmCN7lv+o0li2f4JIpqpvUHEd4pC0HRGOj+6cOxVgMva
	CeALBK23n832551YRMF7/9JfoOkAyH3/cOV0rNDuYK6UoHLYC/mjWotuX9c5SoHDHEWQh/
	g8VKoSBB6CyluT7ucFMXwEt7JvL8oG/HjflMWNUypG+ciHCHiyAMNQsGsO29nEhMmOItVg
	x3ltapjeBOY3aruel4XjrrmNWDEgr2JpuWjVKe5wsyqCcgv+q7ossRg9NSehn+xPhByPWW
	fp4UCfrXQDwJNjXrqfzTzzKp/sJbvrl+eaoBQsD8/33g7OJ8UmqThbXjd3F4MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756820364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSfMqS9MQ8r+pru/P72e11/GlNeLydR+kxwfIp/qzKo=;
	b=jHjJaylYSt2F5BCZ/alOfec34DpGFeAjJDnftTnseT3cQ0cWNSXodeq+P9Ec+PMiVg5Vej
	/MApuesJVeGOaqCA==
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
Subject: Re: [patch V2 06/37] rseq: Simplify the event notification
In-Reply-To: <9aa047e6-cea5-4f84-b763-36d8d5ad4731@efficios.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161653.644902433@linutronix.de>
 <9aa047e6-cea5-4f84-b763-36d8d5ad4731@efficios.com>
Date: Tue, 02 Sep 2025 15:39:22 +0200
Message-ID: <87plc90y9h.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 25 2025 at 13:36, Mathieu Desnoyers wrote:
> On 2025-08-23 12:39, Thomas Gleixner wrote:
>> Since commit 0190e4198e47 ("rseq: Deprecate RSEQ_CS_FLAG_NO_RESTART_ON_*
>> flags") the bits in task::rseq_event_mask are meaningless and just extra
>> work in terms of setting them individually.
>> 
>> Aside of that the only relevant point where an event has to be raised is
>> context switch. Neither the CPU nor MM CID can change without going through
>> a context switch.
>
> Note: we may want to include the numa node id field as well in this
> list of fields.

What for? The node to CPU relationship is not magically changing, so you
can't have a situation where the task stays on the same CPU and suddenly
runs on a different node.

>> -	unsigned long rseq_event_mask;
>> +	bool				rseq_event_pending;
>
> AFAIU, this rseq_event_pending field is now concurrently set from:
>
> - rseq_signal_deliver (without any preempt nor irqoff guard)
> - rseq_sched_switch_event (with preemption disabled)
>
> Is it safe to concurrently store to a "bool" field within a structure
> without any protection against concurrent stores ? Typically I've used
> an integer field just to be on the safe side in that kind of situation.
>
> AFAIR, a bool type needs to be at least 1 byte. Do all architectures
> supported by Linux have a single byte store instruction, or can we end
> up incorrectly storing to other nearby fields ? (for instance, DEC
> Alpha ?)

All architectures which support RSEQ do and I really don't care about
ALPHA, which has other problems than that.

Thanks,

        tglx

