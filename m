Return-Path: <linux-kernel+bounces-796646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985F1B4053A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94FC6176B29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778793019C2;
	Tue,  2 Sep 2025 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aOm0wQ1h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9u1Kxh78"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756DA3043BD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820519; cv=none; b=HSOJwWoxHNP6Fj7xahZZX3pRFJyVOtfy1IMXNQxqOPccsp0YqggrFFsK99tYX/xr7t4nfcLdqNL73yWzRpbbnBLRmBdhVLvcDZhAY0ElBxgIxvvL41pk3bmEh1WZKAnLjim9ZvdXKZovhkbyc0ObI4khBuy0e8/0xJNGIOB+4u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820519; c=relaxed/simple;
	bh=LsKuPUD7QCXct6SYsgtR6734LXBnjuFoCckwb0t9/mk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T6CK28BBOI2TnC9RoghaFFMVxwLRikoOpwq9CggmfDJC37jjgMakSpUYdO/unlqL9hkwJXRh7B5SQ7dDreTr0NXGyV7g3UizU/I9ted3Wabtn870lo9VawJztTmMQNUviLk5QI3OiKC5tUm/M/kw62wKQQDaPNQ57K8i2fyD+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aOm0wQ1h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9u1Kxh78; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756820516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SY++CHVuSFd7FKLFxnZeXtzSR6EPM5/tg3vwg+UKC90=;
	b=aOm0wQ1hGUhDsvD06ZJsDOA5LsksecTJQB9E80uxxte0CgZCL8WLAl6fpFOMATesVZxDia
	eRW9vt/OLrdm3escatTfimImdx++hQDZChDEeJxiY31wnpYAYxWdGNESxIW1rlbKA794tl
	EU+kNvZj8EEKg5BFNi4wG1kMuZ3XD+EVxts77U8Cik9NDm4QyFLAy5lWW86Y7ZAQ4vtb1s
	KsH33bIhAGB5MMj7bolQFFPuHBmVz/FfUm3iJJ22JBFK39DeuMOztL6Z1YGnGm6N1JQqSY
	F+ureJSliyMFZ9/q8JOZnuQq1CjyOLyqTOVpsrqSKsnoBpOR3q9VIXrk07/ElA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756820516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SY++CHVuSFd7FKLFxnZeXtzSR6EPM5/tg3vwg+UKC90=;
	b=9u1Kxh781qVuQoz2/HPDlx5UQ2hOsCz9uVEAZMKMDTTws3lwpQbKPoqr7082twIa8Pefb/
	k1sMasyrIRnTWZBw==
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
Subject: Re: [patch V2 08/37] rseq: Avoid CPU/MM CID updates when no event
 pending
In-Reply-To: <566bd13f-54b7-42e3-808a-619a58ce05ab@efficios.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161653.778777669@linutronix.de>
 <566bd13f-54b7-42e3-808a-619a58ce05ab@efficios.com>
Date: Tue, 02 Sep 2025 15:41:53 +0200
Message-ID: <87ms7d0y5a.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 25 2025 at 14:02, Mathieu Desnoyers wrote:
> On 2025-08-23 12:39, Thomas Gleixner wrote:
>> There is no need to update these values unconditionally if there is no
>> event pending.
>
> I agree with this change.
>
> On a related note, I wonder if arch/powerpc/mm/numa.c:
> find_and_update_cpu_nid() should set the rseq_event pending bool to true
> for each thread in the system ?

What for? That's the hotplug path, which establishes the CPU to node
relationship for newly added CPUs and their [hyper]threads _before_
those CPUs are able to run anything.

Thanks,

        tglx

