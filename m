Return-Path: <linux-kernel+bounces-744992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851BFB1137A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1B51681D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09EA2417F8;
	Thu, 24 Jul 2025 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nejusQ7G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RPgv96XF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6F421858A;
	Thu, 24 Jul 2025 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753394394; cv=none; b=MgnIAgqhjASCvQJqhasahqZamxQ33f+RZrbkLWcya+AooST10bh7avIK4Jvz7bV4bUDKPsYid5iUQEvu2qhH9NjtU0OdxPl3xBxCnCdiLCtsk34EHgKN8SEZrxZVxrdS2/oHA6q6DBlmFrr/DzRVxof/8UiwAeno8XnvLiFd1lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753394394; c=relaxed/simple;
	bh=enA0+R4KlVQsB2+gsMerGTr2ZGdR8MjJ8EpyD/BzHkc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O27DbTgeLk3IMSwIBH2MRDWUKuBd9nkOV+Zjb2M97P7I8/mlbewObtdpnWCAx8/659lIInHFjcsHak12inj5ahwc0scKs+uTLZGLoAAPc+9+NnVMnaekYzWNXXChqI/i34fR/kBaRyTfMrZ2i/7yZ5mGPqFcbjBJ9hUjRpWZr1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nejusQ7G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RPgv96XF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753394388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=enA0+R4KlVQsB2+gsMerGTr2ZGdR8MjJ8EpyD/BzHkc=;
	b=nejusQ7GjW0lG9RPO1CF7sFmWk7heNnYtDgtu92R3MUQLyynbOxXgGMa+Y1XUhxaMGjKlL
	hfXtUmyWzfv8oeOZ44Oi0cW77l4vYRyquh9Vt+S+/RHA47HbEcymuh9fXE98xJod6iYJZN
	UJ+T5M78Uwxbyb3ombiEVuopskIUG4JjrA+JtLYfxb4HNB7kVNF63eZ7vFy0qEJYveLQ30
	3F0ttK9MfuorP9ZCJaZxs6WmhUXyElWth0FXxYOqiGKrdXSQT+MtkkzBMgejDBlIC57DY2
	38Q+aeFb1690mmD530z7Qjy+4vsQZqsMxHPikAkMdyFZ0R0bLOvbGs1YdGxDig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753394388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=enA0+R4KlVQsB2+gsMerGTr2ZGdR8MjJ8EpyD/BzHkc=;
	b=RPgv96XFx0+GjNQ+OWv50r4D2NDkzYXvPbVdEHBVaYwVlbHaxBD7Mej4cX5eY9PL+8krww
	5yGhPvRojlJTzvCw==
To: Lyude Paul <lyude@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Dirk Behme <dirk.behme@gmail.com>,
 rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
 airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, will@kernel.org,
 Waiman
 Long <longman@redhat.com>, linux-kernel@vger.kernel.org, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 wedsonaf@gmail.com, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>,
 aliceryhl@google.com, Trevor Gross <tmgross@umich.edu>
Subject: Re: w/r/t "irq & spin_lock: Add counted interrupt
 disabling/enabling": holes in pcpu_hot?
In-Reply-To: <012ccaab7df3d884f924d6af52dd36ebc4da80ce.camel@redhat.com>
References: <20241018055125.2784186-2-boqun.feng@gmail.com>
 <87a5eu7gvw.ffs@tglx>
 <20241023195152.GE11151@noisy.programming.kicks-ass.net>
 <012ccaab7df3d884f924d6af52dd36ebc4da80ce.camel@redhat.com>
Date: Thu, 24 Jul 2025 23:59:46 +0200
Message-ID: <874iv1qmgd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 24 2025 at 16:36, Lyude Paul wrote:
> Hey! Sorry to be a bit late here but I just noticed this comment in your email
> that I didn't before
>
> On Wed, 2024-10-23 at 21:51 +0200, Peter Zijlstra wrote:
>> We still have a few holes in pcpu_hot iirc.
>
> I assume you mean we still have space for adding things into pcpu_hot? And if
> so, where exactly are these holes? At some point when working on this series I
> attempted adding a single unsigned long to pcpu_hot and the build failed as a
> result of not having enough space. But if there's somewhere we can add
> something else, that might actually help with a few of the issues in this
> patch series

That's the current lot we have.

ffffffff82f6a000 D __per_cpu_hot_start
ffffffff82f6a000 D hardirq_stack_ptr
ffffffff82f6a008 D __ref_stack_chk_guard
ffffffff82f6a008 D __stack_chk_guard
ffffffff82f6a010 D const_cpu_current_top_of_stack
ffffffff82f6a010 D cpu_current_top_of_stack
ffffffff82f6a018 D const_current_task
ffffffff82f6a018 D current_task
ffffffff82f6a020 D __x86_call_depth
ffffffff82f6a028 D this_cpu_off
ffffffff82f6a030 D __preempt_count
ffffffff82f6a034 D cpu_number
ffffffff82f6a038 D __softirq_pending
ffffffff82f6a03a D hardirq_stack_inuse
ffffffff82f6a03b D __per_cpu_hot_end

So there is a 5 byte hole there at the end, which is obviously too small
for an unsigned long on 64-bit :)


