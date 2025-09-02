Return-Path: <linux-kernel+bounces-796882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D86B408C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7BE45606A5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C262330507B;
	Tue,  2 Sep 2025 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bR2xLFPe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ImtitBwc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2F32DE6F3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756826389; cv=none; b=QyI5vefwDHA0v4up6TxoareWSs2LFhHc7LAPfshfBGuLi766jiQsKWgcxj+xfZqPUC7q9fcBnjUjyMOQ+1LiLzcmsEULACXiWgjWQDcymnhOe/8RoYw/IZZFY9g+gRlhHNzKqIIftHYajGRz7snkP5a9HgAs9JuwDb8GpPoyFBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756826389; c=relaxed/simple;
	bh=IGplCY3XY7BL6dryWwO22D33kkmTSdbfZcyxUX7njCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GxKIbnHtB2cXEFamkala4PzvWvlry4LqFLfUhZ/Ps/sfkZ6NkjqZR9BmKq0+COteE98BEmVskRW2m/kdNfbrk/mCCO7nVmZldQYKFE32fnbwyzJ0QAMCogxmFf2N/BXpkfQFvJOM3JHQqtYIzywvZgDQMzPy92HdNoCgtpEVfJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bR2xLFPe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ImtitBwc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756826385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PoT00wtkWbjRAKe7iGpzKuH4cK69DTQcB1A+qYRyAI0=;
	b=bR2xLFPeSRrhRDIlnBGJCUBdYMnJJFzaqzWnykvbhrp2T2k54L5WdlKviry3o1W3g8TF3S
	Ar8ruiL39yAvqV+vy3XBSlcXBqKbmzBivFxPD85q55/ujY8f8tRkEyYz9f/WJa6ZUk6GPo
	sGCWDOeL/fpwMTvwfh0z+svOBdC0cKqEQneOH8EdKzfCehxqhYNjYyJA4sNwJ8nVHuHXO4
	sWR1sHOR/EMnKhKCyCOQtyiXx5P/+x/xW4kJL/nqWiYpAxo0Jz8kGu7F2EIPBeNC4w4ard
	MU3zA5L/ydox5Ii1tzGYbhFWUgx1UvOLAX0UApw85rEQO7pnOrhlL+3ObL7+4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756826385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PoT00wtkWbjRAKe7iGpzKuH4cK69DTQcB1A+qYRyAI0=;
	b=ImtitBwcodhH5VLaBRKrAlb9OFLgPPNNsaNuuY4a4/z1CXS2jcYujrueWBw+nk3NnqyfYi
	w6IKS5BZL7EjeLDg==
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
Subject: Re: [patch V2 19/37] rseq: Provide and use rseq_update_user_cs()
In-Reply-To: <c1eaedb5-0d38-4b32-be27-b0e91bb24752@efficios.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161654.485063556@linutronix.de>
 <c1eaedb5-0d38-4b32-be27-b0e91bb24752@efficios.com>
Date: Tue, 02 Sep 2025 17:19:44 +0200
Message-ID: <873494286n.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 25 2025 at 15:16, Mathieu Desnoyers wrote:
> On 2025-08-23 12:39, Thomas Gleixner wrote:
>> If user space truly cares about
>> the security of the critical section descriptors, then it should set them
>> up once and map the descriptor memory read only.
>
> AFAIR, the attack pattern we are trying to tackle here is:

  ^^^^^ - so I'm not the only one who struggles to find some explanation
          for that in code, change logs etc. :)

> The attacker has write access to some memory (e.g. stack or heap) and
> uses his area to craft a custom rseq_cs descriptor. Using this home-made
> descriptor and storing to rseq->rseq_cs, it can set an abort_ip to e.g.
> glibc system(3) and easily call any library function through an aborting
> rseq critical section, thus bypassing ROP prevention mechanisms.
>
> Requiring the signature prior to the abort ip target prevents using rseq
> to bypass ROP prevention, because those ROP gadget targets don't have
> the signature.

Fair enough. Let me see how to integrate this properly along with a big
fat comment explaining what it actually does.

Thanks,

        tglx

