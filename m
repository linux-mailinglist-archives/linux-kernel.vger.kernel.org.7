Return-Path: <linux-kernel+bounces-808388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E43EB4FF24
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5805E01DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD63342C98;
	Tue,  9 Sep 2025 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PqaGk1D5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2nCol7o8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFC01553A3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427480; cv=none; b=gJSaGG1NUFYu1WyvbClatofOfYsRg0F5BLIcO4IHDST/Z4pwIaeK65S06/KENhMPvuzD1mKGA3veoXnaAIYMPduAO7DWtDiQG5qH9GCrfU2tQqTYZnCchw6VJitbppxIyezOj1XtmQRG5NEEmoJ0Cr14Yl3OC1tkUpMzwL1KUNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427480; c=relaxed/simple;
	bh=7Gmo3a7pESQltpZ9RdaQUBxFCUORBSSfC0rsagv3xlo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z2+ae+TTGvTZ2P87CrnJSPUh9NAtYiBDNcpiP6jNIgWq7s8dHcJcyGMOepo2VPTB4JrZVH4IHE+Om9tRxWBYlXyTiou1MG95MKS5X7cPfbDgtpWpvDGKwPb2t8i0ed9+WqnnQ/HRlITXKX61qfz/Z4noq1LGn/mfKeg8lbbPDQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PqaGk1D5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2nCol7o8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757427476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1LyQA98wvR3voNidWP/si5VQTWPYqq/tKAxaM7Wr3U=;
	b=PqaGk1D5ixpoS9ODrbt9Xz2d7GWllJoCVIvjDd0emVAfcOKqM2QzOb9akAgeWu3CRngZie
	trW13lhSU6oOD5IkQCC3fGoTAseKMRvRgiAzpKWZvvQYAJzyBT0oMO1KI1Okf+liNWD53E
	tMtEGmJCh8sn+/KCc+BaeW70vvKN7XbhklDStcUixk/OuvY3GXcIMDHmMLvrQ1nKk+YtvF
	XhF3WlGnieUlglEcmsOY5iT43scgVQhyho+PgxNt9jYIp+e7oNTLHSfcwnqUwmH1fKywHl
	SJ3CoscovRATheCXQJ/5IAQrKC2XoVAMPLUW0uhsC6lPdRX37sKwMvzsGbUjoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757427476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1LyQA98wvR3voNidWP/si5VQTWPYqq/tKAxaM7Wr3U=;
	b=2nCol7o8moXnqFuTvW/A7+c+Ay98rdKuDq+4Q4/2tPamY2jvXT5BE2VBVgnmayPK4nSp9v
	6SaBsH5ZDOXlnnBg==
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
Subject: Re: [patch V4 15/36] rseq: Record interrupt from user space
In-Reply-To: <5911c934-db16-433b-a1b8-c5367e420248@efficios.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212926.225746125@linutronix.de>
 <5911c934-db16-433b-a1b8-c5367e420248@efficios.com>
Date: Tue, 09 Sep 2025 16:17:55 +0200
Message-ID: <87ecsfvhf0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 09 2025 at 09:53, Mathieu Desnoyers wrote:
>>   static __always_inline void rseq_exit_to_user_mode(void)
>>   {
>> -	if (IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
>> -		if (WARN_ON_ONCE(current->rseq.event.has_rseq &&
>> -				 current->rseq.event.events))
>> -			current->rseq.event.events = 0;
>> -	}
>> +	struct rseq_event *ev = &current->rseq.event;
>> +
>> +	if (IS_ENABLED(CONFIG_DEBUG_RSEQ))
>> +		WARN_ON_ONCE(ev->sched_switch);
>
> OK. Now I'm confused.
>
> It is perfectly legal to issue a system call from userspace as long
> as it's not from within an rseq critical section.
>
> That system call can be scheduled out, and can set the ev->sched_switch.
>
> This would cause the rseq_exit_to_user_mode from system call to
> hit this.
>
> What is disallowed is only issuing a system call from a rseq critical
> section. The other parts of rseq (updates of cpu id and mm cid) still
> have to happen when returning from a system call.
>
> What am I missing ?

The fact that any setting of ev->sched_switch has to be handled on the
way out independent of user interrupt or not as MM CID can change
obviously.

This is not any different from the state before this patch. Just that it
now only looks at sched_switch instead of the full event as that might
contain a set user_irq bit w/o sched_switch being set, no?

Thanks,

        tglx



