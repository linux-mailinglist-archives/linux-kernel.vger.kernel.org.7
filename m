Return-Path: <linux-kernel+bounces-855277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C3DBE0B61
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C40743535E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FDA2D47EA;
	Wed, 15 Oct 2025 20:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="sQ8hNMNP"
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7319F2046BA;
	Wed, 15 Oct 2025 20:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760561687; cv=none; b=F+MUf6Q3wLekWD3/0VQww2bDYydy/ZMBcM5xiNgv5VCk0uLyhFd6OyWAb1Ih0ibGxeraeF7q6djqqWyuoFH3Icp7LMrtd9gSSK8vprsBzFya1rekaera4N0d/fXW7KP9AKurPqvbp7vMKmOhc7D452UjXAnuYeVeqVMV1cufCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760561687; c=relaxed/simple;
	bh=1ncFKWGpcvPLXTYm6YbBeaW1i3SAczsj9LiCky/G6r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvvi0qVHsN/+tOnE0nwhLnlu3lIs/ZLUQOiVtt4ZUKRGwSb3M8kvs2tEd8dSlwztRM1muJK2hCSyLV3sXLmNyV/vvT+OxVhjs/Tg7stktWE9T6HCoTo/aoWDFk6vWUl4y/zp9Wn09BN7TS7nSo6M62BOXADPD84KSWYkinFvu7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=sQ8hNMNP; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cn3HL00L4zm16kl;
	Wed, 15 Oct 2025 20:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1760561672; x=1763153673; bh=grQqE8NOnFu1cP4MJIe5OHb3
	urYLhp2K5hoWpXpbxRs=; b=sQ8hNMNPbdsMRXfTQLyJAyaiXkXs3pnqatvfed6E
	w7XaIkYPX2/y/gBD+ATyJK+jCK1SQTTHEgT7B1rTwxC/+ZrTTuliEoYnoDQo972X
	ZsrnK2oDXXTrcyC/32a+ICv6nEsTInE1fu702LJTUWp+3ijjL+9p3kcJHSc64KUo
	Ho0nghFJGGrzVE69o5uUzNdC1VA9N45GGowx3EclnRm98/KiBkkAweQRwG+xyi5N
	uVmuGAmSz8+F9wFrhCF+qY3/+xZE5cQIfMaZZiSQpmemnoQXdZ9g/RCYWwZSL3xc
	/NKCgz/kNKxjZ6M6JYDHgbrvgzduhUWCLd7BGxml47H5wQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WtySCtqgW_Gc; Wed, 15 Oct 2025 20:54:32 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cn3Gl5xhNzm16kk;
	Wed, 15 Oct 2025 20:54:06 +0000 (UTC)
Message-ID: <7a98eb42-bc54-4f22-bc85-0f6d41f39fc7@acm.org>
Date: Wed, 15 Oct 2025 13:54:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 05/17] irq & spin_lock: Add counted interrupt
 disabling/enabling
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Joel Fernandes <joelagnelf@nvidia.com>, Ryo Takakura <ryotkkr98@gmail.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
References: <20251013155205.2004838-1-lyude@redhat.com>
 <20251013155205.2004838-6-lyude@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251013155205.2004838-6-lyude@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 8:48 AM, Lyude Paul wrote:
> Currently the nested interrupt disabling and enabling is present by
> _irqsave() and _irqrestore() APIs, which are relatively unsafe, for
> example:
> 
> 	<interrupts are enabled as beginning>
> 	spin_lock_irqsave(l1, flag1);
> 	spin_lock_irqsave(l2, flag2);
> 	spin_unlock_irqrestore(l1, flags1);
> 	<l2 is still held but interrupts are enabled>
> 	// accesses to interrupt-disable protect data will cause races.
> 
> This is even easier to triggered with guard facilities:
> 
> 	unsigned long flag2;
> 
> 	scoped_guard(spin_lock_irqsave, l1) {
> 		spin_lock_irqsave(l2, flag2);
> 	}
> 	// l2 locked but interrupts are enabled.
> 	spin_unlock_irqrestore(l2, flag2);
> 
> (Hand-to-hand locking critical sections are not uncommon for a
> fine-grained lock design)
> 
> And because this unsafety, Rust cannot easily wrap the
> interrupt-disabling locks in a safe API, which complicates the design.
> 
> To resolve this, introduce a new set of interrupt disabling APIs:
> 
> *	local_interrupt_disable();
> *	local_interrupt_enable();
> 
> They work like local_irq_save() and local_irq_restore() except that 1)
> the outermost local_interrupt_disable() call save the interrupt state
> into a percpu variable, so that the outermost local_interrupt_enable()
> can restore the state, and 2) a percpu counter is added to record the
> nest level of these calls, so that interrupts are not accidentally
> enabled inside the outermost critical section.
> 
> Also add the corresponding spin_lock primitives: spin_lock_irq_disable()
> and spin_unlock_irq_enable(), as a result, code as follow:
> 
> 	spin_lock_irq_disable(l1);
> 	spin_lock_irq_disable(l2);
> 	spin_unlock_irq_enable(l1);
> 	// Interrupts are still disabled.
> 	spin_unlock_irq_enable(l2);
> 
> doesn't have the issue that interrupts are accidentally enabled.
> 
> This also makes the wrapper of interrupt-disabling locks on Rust easier
> to design.

Is a new counter really required to fix the issues that exist in the
above examples? Has it been considered to remove the spin_lock_irqsave()
and spin_lock_irqrestore() definitions, to introduce a macro that saves
the interrupt state in a local variable and restores the interrupt state
from the same local variable? With this new macro, the first two examples
above would be changed into the following (this code has not been tested
in any way):

scoped_irq_disable {
   spin_lock(l1);
   spin_lock(l2);
   ...
   spin_unlock(l1);
   spin_unlock(l2);
}

scoped_irq_disable {
   scoped_irq_disable {
     scoped_guard(spin_lock, l1) {
       spin_lock(l2);
     }
   }
   spin_unlock(l2);
}

scoped_irq_disable could be defined as follows:

static inline void __local_irq_restore(void *flags)
{
	local_irq_restore(*(unsigned long *)flags);
}

#define scoped_irq_disable \
	__scoped_irq_disable(__UNIQUE_ID(flags), __UNIQUE_ID(label))

#define __scoped_irq_disable(_flags, _label)                          \
	for (unsigned long _flags __cleanup(__local_irq_restore);     \
	     ({ local_irq_save(_flags); }), true; ({ goto _label; })) \
		if (0) {                                              \
_label:                                                               \
			break;                                        \
		} else


Thanks,

Bart.

