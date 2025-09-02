Return-Path: <linux-kernel+bounces-796689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32A4B405EC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00AC1202134
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E56E30C377;
	Tue,  2 Sep 2025 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nwUCgJg/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ByVINmU9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C0C2DAFD2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821297; cv=none; b=GHZdEqr2c6A7kFU0q2dyLdFBgZrXiQlV63CF+w/O4sifoUGr5efq0LofMvD26bnqFc8ldZAXst9+34NyhURU8IR0I62kicrqfplkqrA4WoT04S/OIxlYiPLIKlEAxIHJI8GIlODvjNFFagmzD3l5qI+wflDIOCDJQhUol7s2LHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821297; c=relaxed/simple;
	bh=6Ma0WXCn1nT2qCwuyxcC7DOa6yJpeuefVjviPzUo3us=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MyTF9r+GnBST/cIzfeaa69Q3UWLAwQJFysh+nkRGIv1CyliFRAirKBA33LIXJ9wZtV2tvx/Z4VRcU3KG0h513X2aBbRu8bAimTqVg4+PebMkrkCSxWme192umabUVwR865CmpO2aQ+Hh7wxXXz+N835E2sqmiXwtTyuTPXwtPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nwUCgJg/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ByVINmU9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756821291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EuU4OreWkiGAPOc2UAUy4FGmrJEY8bk1Yh+uMcUCO3U=;
	b=nwUCgJg/UGpabG09K0FRIp57z/+eclibaSdzIqcam6Bfuoa55LIVUPZjmpqwihZsQlTSfw
	0cMtmlgpWmo70t0GTINqZiUZfF7ys8b1+kY9faV+Uu5+YSvC03x7EaY4xi1xw6UBPxp/zp
	cNJO7WGgEGTjVPVB2zOCJVaSxOfYiGwn1dRBt8WKYiY4Rzp7mGLgRBohu0oSxsds/5LtPD
	MXg07+oKFAcXz9MZ/rMVWjzQD4UFyzVQEcFGQvbWF29B9yc0ywIKKKJA06Z5frgJsd8y7F
	1o2LzsqGor3SmJ9q4/6fFQBNTT5wuubkWkCmTyoc66fKCBPYW6uHhnQkDCqauA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756821291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EuU4OreWkiGAPOc2UAUy4FGmrJEY8bk1Yh+uMcUCO3U=;
	b=ByVINmU9rxqnpdAEaMi1fBcicVTXDbNZyMafym7c7XNDTqjjzeAS3EJTUu704Ls/4AKbsk
	KbKaaG2UFIZuINAQ==
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
Subject: Re: [patch V2 15/37] rseq: Record interrupt from user space
In-Reply-To: <775c7f2e-975d-4262-964f-7d2ed0554fad@efficios.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161654.228227253@linutronix.de>
 <775c7f2e-975d-4262-964f-7d2ed0554fad@efficios.com>
Date: Tue, 02 Sep 2025 15:54:50 +0200
Message-ID: <87ecsp0xjp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 25 2025 at 14:29, Mathieu Desnoyers wrote:
> On 2025-08-23 12:39, Thomas Gleixner wrote:
>> code. If your architecture does not use it, bad luck.
>> 
>
> Should we eventually add a "depends on GENERIC_IRQ_ENTRY" to RSEQ then ?

I wish we could, but that'd break MIPS, POWER and ARM*...

>> @@ -281,6 +281,7 @@ static __always_inline void exit_to_user
>>   static __always_inline void irqentry_enter_from_user_mode(struct pt_regs *regs)
>>   {
>>   	enter_from_user_mode(regs);
>> +	rseq_note_user_irq_entry();
>
> As long as this also covers the following scenarios I'm ok with this:
>
> - trap/exception from an rseq critical section,

It does. Traps and exceptions go through that entry path.

> - NMI over an rseq critical section.

That's irrelevant as NMIs are not going through the regular exit to user
path and therefore can't reschedule. If they trigger something which
requires a reschedule they raise IRQ work, which then goes through the
regular irqentry/exit path. 

Thanks,

        tglx

