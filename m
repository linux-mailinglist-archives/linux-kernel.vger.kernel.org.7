Return-Path: <linux-kernel+bounces-796661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AECB4059E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8511B24A29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE16233CEAC;
	Tue,  2 Sep 2025 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xYH31KQJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9o6DWhKI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E1E324B02
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820751; cv=none; b=CT+fODLnYtTiVUHe7DeH2ohaszFKOstpbcB2s4rCEfmIxgaFWMNHSeRME/RVKLkjnXg1yOVdZ0fNk32AKvMeJjf+2FBG2ZdB3/x4e9BNEalZyZpqnGwpYjCRkDGWes3j11etiNqgjpb5CJsAuplIJCu3w5JS5Q2VVYE8PBdBbbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820751; c=relaxed/simple;
	bh=+oyr6TNfvEGai2tHmAsMUdGK0F86ufk1C332gGol6rY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mbpLK0KVPcDflxbAVZWhW/E1R9AYiqrk3QjBfI7UKEn73wCm+kI3hLuJUm+t4F7as/nOk/4fb4oSdq686ueWq7A395r/bt6ECiRHLthf+JpXRjiekeuG5a0GUsGkPNbT34y396fy6EpbeUhoijehR/kKmZjdh1KAMtNCYt1b37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xYH31KQJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9o6DWhKI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756820747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U9p+nRb5XuklUSbmdiKjvuliV6oCMcyIA3bYHogG/hI=;
	b=xYH31KQJQWE9xHHPJQ1ckWr4op3pOXfgt6KT43WmOIaRzQ+zmXsyz1yj9QchEeTRFo2tgX
	58HGHCY+v38+0YmCGpEBiGrSp9V5ickUX4Le63Ay1VnPQp3HTFrGNJYrUfi4zU9vfgU0Wz
	kKfsHw9cTPN/NAOxZ330/c/ZUn4GDp9P/Iz/4F9QVQIUZZC70LGQTajLXS234i22he9TN9
	RhN/2v9qV6oYSS4Yg2iwm7IS9Q5ricH9JN/2wWuMgJWwYdh/aoRzbRjyfs70tfFMGYuUwS
	diPhYtPsy2Zy3SKQ7BzItdRO+NgaVvxCh6nIecbqObjUdls6UbK0aL3RUJIibA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756820747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U9p+nRb5XuklUSbmdiKjvuliV6oCMcyIA3bYHogG/hI=;
	b=9o6DWhKIGFSnvfbB0dVda1gbe3FmcoDY7qbzyU/RL73M2vFW24dbgTOx57RKWRW6eOWYTR
	2jzpWZFcr3O23KAQ==
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
Subject: Re: [patch V2 09/37] rseq: Introduce struct rseq_event
In-Reply-To: <9a94b9d4-708c-476a-bf7d-7deb1c14f1ac@efficios.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161653.843757955@linutronix.de>
 <9a94b9d4-708c-476a-bf7d-7deb1c14f1ac@efficios.com>
Date: Tue, 02 Sep 2025 15:45:44 +0200
Message-ID: <87jz2h0xyv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 25 2025 at 14:11, Mathieu Desnoyers wrote:
>> + * @sched_switch:	True if the task was scheduled out
>> + * @has_rseq:		True if the task has a rseq pointer installed
>> + */
>> +struct rseq_event {
>> +	union {
>> +		u32				all;
>> +		struct {
>> +			union {
>> +				u16		events;
>> +				struct {
>> +					u8	sched_switch;
>> +				};
>
> Is alpha still supported, or can we assume bytewise loads/stores ?

Alpha is on life support, but that does not mean we have to cater for it
in new features.

> Are those events meant to each consume 1 byte (which limits us to 2
> events for a 2-byte "events"/4-byte "all"), or is the plan to update
> them with bitwise or/~ and ?

No. Bitwise or/and is creating horrible ASM code and needs serialization
in the worst case.

There is a no need for tons of events. See changes further down the
series.

Thanks,

        tglx



