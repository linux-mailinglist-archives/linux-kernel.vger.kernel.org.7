Return-Path: <linux-kernel+bounces-796205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F754B3FD47
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5EF2C238D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB172F3C1D;
	Tue,  2 Sep 2025 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3hDWsS/q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yd65ERWL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D686528505D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811036; cv=none; b=hmgccSmoq7p32wtdSby0QxVxpXA8pB1WvDu9x+bQRqGS0eiAJ4KqUqoGmGnEFUV0dJeu15aDXmMTiMn8q+UIS1dcOfDxGldwIBk0FWCFapOrmWI8fK2fMkIk0XwgNvKUkYzfZDKULglx8Bi/hOfAFpEJ9ZWgE7iNaF8KXRb0fIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811036; c=relaxed/simple;
	bh=o2QfzNqPPN0Rc36Rg/h5ic6JvVyz43Nqz00mNzNUxUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A+K66n2iF/3FIDfgVvRptLqVw5kM/WS32oPZrfHx331C/ChsqtQUANrwuhexGCjXP8TQLkZgq9pDLnJ10geh/VHwn49UlkqvIHN1xJ9MtKtzYrDmrSaJXNEQefzcBKxyXPYDfeV6jZHAcu/BQqBQq0tR8GFdbDtWGepSsXuAzeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3hDWsS/q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yd65ERWL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756811033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cHjmy6L5PWux2E3+hZ8SuKJy85l7AejeHTQiGk4VWGU=;
	b=3hDWsS/qM5RlF3JvSaUotmU61EogVW+oEXexGbh42rrShZBxJqLhUHMYAHrQKbdHoS3I23
	6wTNIZ3jNO6oIBAX8gkWOCFIvfCQN+3Sw7Jwz6rDVoxYOinzqDpVWe4XBECz2zgVtVgPQj
	uIqWUnbUSmDpFkOKWDEftvKKXUP4Ivaip6A5oBlaWcuPyz2VvUyywRb+TEIb6qckwLRYBn
	rqSEXNeO9EmoIhULmeMEiyqrlbiUNjT3T41BNePM3HWlIHKfpNFsd02Ad2bA5xyaJ5VQwo
	dxUjFI6neI5VeP5z9HyiQTJ4zw1nZbYux5LQgDqFHO2e4VsAJTaSTPXSqcsJNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756811033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cHjmy6L5PWux2E3+hZ8SuKJy85l7AejeHTQiGk4VWGU=;
	b=Yd65ERWLZEYmRaq3ojGwtcxO2cK0qWDG6ONw8XNRjEcUysJCjy3+nulCO1ZRfsMFQUKpxd
	xvRgYQVh955PYCAg==
To: Sean Christopherson <seanjc@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun
 Feng <boqun.feng@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patch V2 36/37] rseq: Switch to TIF_RSEQ if supported
In-Reply-To: <aKzBQRKuEmrNtCiB@google.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161655.586695263@linutronix.de> <aKzBQRKuEmrNtCiB@google.com>
Date: Tue, 02 Sep 2025 13:03:52 +0200
Message-ID: <877byh2k13.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 25 2025 at 13:02, Sean Christopherson wrote:
> On Sat, Aug 23, 2025, Thomas Gleixner wrote:
>> @@ -122,7 +122,7 @@ static inline void rseq_force_update(voi
>>   */
>>  static inline void rseq_virt_userspace_exit(void)
>>  {
>> -	if (current->rseq_event.sched_switch)
>> +	if (!IS_ENABLED(CONFIG_HAVE_GENERIC_TIF_BITS) && current->rseq_event.sched_switch)
>
> Rather than pivot on CONFIG_HAVE_GENERIC_TIF_BITS, which makes the "why" quite
> difficult to find/understand, what if this checks TIF_RSEQ == TIF_NOTIFY_RESUME?
> That would also allow architectures to define TIF_RSEQ without switching to the
> generic TIF bits implementation (though I don't know that we want to encourage
> that?).

Did you read the cover letter?

Consolidating on common infrastructure is the goal here. Stop
proliferating the architecture specific hackery, which has zero value
and justification. If people want to harvest the core improvements, then
they should get their act together and mop up their architecture
code. If they can't be bothered, so be it.

I'm happy to add a comment which explains that.

Thanks,

        tglx





