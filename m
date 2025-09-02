Return-Path: <linux-kernel+bounces-796668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE83BB405C0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB5818841AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CAC308F24;
	Tue,  2 Sep 2025 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LE6a9p2D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sdkuGTta"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19713594B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820888; cv=none; b=qmQQrGrFsrIY7Ei6w/BU6b6BjgPRb2IxymQuoxev8zejwFAcgkopFSAw6Iz166uUlv0REpuuQpUL4dNk/nA08eh11/wWHybRy1awQiLX/eAhe/25LGI1lNeE1b/fSeTE1P70HjZ/4CR3VtWoZGNibV66QLdhbiNOVM0Zoy0vE7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820888; c=relaxed/simple;
	bh=3n/KFfbN7HctPn0qF4RPJk37oP0xleQ1a71VoTgTufc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ehc2XJJY7GGanUYKcsJ9iEVHI9Pfio/oBe0xz4U3x6+oNG3H5It9Gra813z/y6kct1wdX7MEAZA/N+oti+GaC92p2HOtWmkKzuG0bQCv3WV7sZAG4iuMEJxDdPPzifiw4ncGFXepwnpwKIUNTLt1nSbWKTAQGMSyt9w6TQszm8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LE6a9p2D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sdkuGTta; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756820885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Qd7xDqLySecXV+gmEJeBhSsP1AFEufVROlwZ2/SczI=;
	b=LE6a9p2D7l24Nq58tMlqS+CseZZSqH55fjwAwk5Kd7mwsliNuIGCztMgUGoTwVamhbojd2
	9Qa8yFjSSFu5HZuNdbSa8BcOQcS1X+emQBaoY06XsDGXmKwH9Cvc32j36XF+SOhaTsr638
	/O/bV+j0XDsRENvWmluWs7f2PtvIQAGEdMnoAW9t25fG1EKAcKlj8oC8pSMazL21+9QQB4
	BWW0NgGFv4ywRkUFpXl5hNfSPMDiBllovfCv5Dto6TRggQZfIQHkobT2rSfLN8DuQXsx2i
	cptwyexu7U3X//SVuRHx70m2iAIDCeb6dhzcJrN2kfjv5UiKWWtcKB3Dfz6Aqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756820885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Qd7xDqLySecXV+gmEJeBhSsP1AFEufVROlwZ2/SczI=;
	b=sdkuGTtaUXNY09bNY3LQcmWKKWjBxmzl+BUWsq89F21/uv/1mVJQmVWmjOYrvZqrXOXEbi
	b4Ca2Lh/OopmDgCw==
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
Subject: Re: [patch V2 14/37] rseq: Cache CPU ID and MM CID values
In-Reply-To: <130e2d99-6c8f-471e-9a72-d858431741ee@efficios.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161654.164761547@linutronix.de>
 <130e2d99-6c8f-471e-9a72-d858431741ee@efficios.com>
Date: Tue, 02 Sep 2025 15:48:02 +0200
Message-ID: <87h5xl0xv1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 25 2025 at 14:19, Mathieu Desnoyers wrote:
> On 2025-08-23 12:39, Thomas Gleixner wrote:
>> In preparation for rewriting RSEQ exit to user space handling provide
>> storage to cache the CPU ID and MM CID values which were written to user
>> space. That prepares for a quick check, which avoids the update when
>> nothing changed.
>
> What should we do about the numa node_id field ?
>
> On pretty much all arch except powerpc (AFAIK) it's invariant for
> the topology, so derived from cpu_id.
>
> On powerpc, we could perhaps reset the cached cpu_id to ~0U for
> each thread to trigger an update ? Or just don't care about this ?

It's invariant on powerPC as well after the CPU was [hot]added to the
kernel.

Otherwise any usage of cpu_to_node() would be broken on powerPC, no?

Thanks,

        tglx

