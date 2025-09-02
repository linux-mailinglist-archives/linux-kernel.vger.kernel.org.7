Return-Path: <linux-kernel+bounces-797190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22281B40D28
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4391B26E4F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1082E2EEF;
	Tue,  2 Sep 2025 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lsGNfofa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="haqr5kX/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9568832F75B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837893; cv=none; b=hrVEsB5wnE7McP3wFEmYR8B8wb+qe87Cx/3k4sB7S/6mxfFHzHOqfKy/HgKffWEOXj1+zIjFTHiFPbHsLhsH4xqe3Ofsk4pmXW9hFLJwu2eWvvWZqYrR2U09Jyn47HixDspZpKkg3//QOxZyDBbOXWc+YeNsXPoSCmzHzg7x+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837893; c=relaxed/simple;
	bh=bZOYVXXZ2ikO0bCHFqNa4jLXDEwneJoyAdCp82lzXwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PcrdXyXYUqeucXnkq5eOiWEkClcXcu08X8VG4F8APgb2Nlt654qImE89lUItFk8l/xmHZhnv5x4/Bl7DolrWqH6EeEuFLIvXNePdKs0iC2QlHCG0JWodRbOtcGeXGtcXuF5idid1jMrz6HUT8176Nw/ulW+PWRQE5qHCrWaM8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lsGNfofa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=haqr5kX/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756837887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fanpy00esSnBGlX30vnme9VcWlTYggqUcX1WnDOVCMg=;
	b=lsGNfofaJxLUk0sg0yJJMG4QpXH/B/2hzGcIREa4XFk+gV+fYWV7d5ZUEsIDHk/oFVltsY
	3Ru+hW6QTECSx7PThf0knJVaWuqgzhW7dEKZW22fbozfPOF6MR+yP8WXs1GZ7qU/zvRdvX
	2nK6YtLddwhX5ZPzwsNIds1iBEFe5CEbhraUlNtIU3Qg0L0JMziA6UkJr8lMt5xw6VccHs
	KQkbcK+0ZVudjfZplAQeMrnRo9CG5gVGLfdUBzHNXyeyuQUu90192BCbfeNqGVMZh8YorV
	EbXNAwb3R+qYQIjST29e7jyKmdM9zXWlVuU+0Xi9dNfouTnDzxPRMJBzJlyPlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756837887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fanpy00esSnBGlX30vnme9VcWlTYggqUcX1WnDOVCMg=;
	b=haqr5kX/r7lmJ6xoCoqO8/y/aAfmAcgGPE1zSMtGCDj3EvL0lTrq06zI8+wY2LnuGbJ2UH
	VpW2BFkThyPJx5DA==
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
Subject: Re: [patch V2 27/37] rseq: Implement fast path for exit to user
In-Reply-To: <8d2380be-20c1-4c0d-8067-efedcce6c9d5@efficios.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161655.000005616@linutronix.de>
 <8d2380be-20c1-4c0d-8067-efedcce6c9d5@efficios.com>
Date: Tue, 02 Sep 2025 20:31:26 +0200
Message-ID: <87ldmwzoxt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 26 2025 at 11:33, Mathieu Desnoyers wrote:
> On 2025-08-23 12:40, Thomas Gleixner wrote:
>> +	 * A sane compiler requires four instructions for the nothing to do
>> +	 * case including clearing the events, but your milage might vary.
>
> See my earlier comments about:
>
> - Handling of dynamic numa node id to cpu mapping reconfiguration on
>    powerpc.

Still not relevant :)

> - Validation of the abort handler signature on production kernels.

Brought it back already.

