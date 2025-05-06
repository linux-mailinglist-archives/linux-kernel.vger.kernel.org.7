Return-Path: <linux-kernel+bounces-636226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670BDAAC7F7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 16:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D923A887B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 14:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CD42820BA;
	Tue,  6 May 2025 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L6CWnG40"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006D52820B8
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541785; cv=none; b=SitnVrak9kLSGty28l5sOhuQaa0AswK6IxwnpAyqmGpocP55sLMdy/YlLnxhiuzq8GTgsTMUuFiLGtnee3WD2zIyaAZE0Uvb1f7s1PsQqWdypYwPedKkLpN23K72y+SvXisf6sFZVF5Lz18GfteaotZm6p49SHxhlGkg6PY0+QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541785; c=relaxed/simple;
	bh=IeQ32Wt0emys7Pw4ki8iHJ34FpgxeFXUPDTob3kkO7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGY5fo8QzSl6HY+S2eYyxJbvdFH26p1uuSBPHZOY+/fk387k5ZJ8IRCdC18M2gi3LdQ7lyHIzooZD9kX/emMrxrMsHA9SPI8OECXa9Zvc7iSk4ApeqY/bx8p0Kc0p4Cm7dp9LjHsxF7pTo/MdUXfKoRXfpqRbanyfo/XKFKlEVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L6CWnG40; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 6 May 2025 14:29:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746541780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FZdoLjH6McKstMGWUeBwY/Dgrb1+g/Z6AtVwWyTPs0Q=;
	b=L6CWnG40yKyz6GGBvg8291Y4gSaqWW+IZts7gM4r3Nudhhy7Uj813V0FENidJ5yUrjITIh
	6CD3yrCT0d7nHyJLazUuPfHkf3zCRIVtUeBCAGx6lf/NitIogYdXIXX/msct3WL1eYRQ1Y
	45C9UnJd1vtwnccKiDVuPlpPNCGXZnM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Larabel <Michael@michaellarabel.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] KVM: SVM: Set/clear SRSO's BP_SPEC_REDUCE on 0 <=> 1
 VM count transitions
Message-ID: <aBoc0MhlvO4hR03u@google.com>
References: <20250505180300.973137-1-seanjc@google.com>
 <aBnbBL8Db0rHXxFX@google.com>
 <aBoZpr2HNPysavjd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBoZpr2HNPysavjd@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 06, 2025 at 07:16:06AM -0700, Sean Christopherson wrote:
> On Tue, May 06, 2025, Yosry Ahmed wrote:
> > On Mon, May 05, 2025 at 11:03:00AM -0700, Sean Christopherson wrote:
> > > +static void svm_srso_vm_destroy(void)
> > > +{
> > > +	if (!cpu_feature_enabled(X86_FEATURE_SRSO_BP_SPEC_REDUCE))
> > > +		return;
> > > +
> > > +	if (atomic_dec_return(&srso_nr_vms))
> > > +		return;
> > > +
> > > +	guard(spinlock)(&srso_lock);
> > > +
> > > +	/*
> > > +	 * Verify a new VM didn't come along, acquire the lock, and increment
> > > +	 * the count before this task acquired the lock.
> > > +	 */
> > > +	if (atomic_read(&srso_nr_vms))
> > > +		return;
> > > +
> > > +	on_each_cpu(svm_srso_clear_bp_spec_reduce, NULL, 1);
> > 
> > Just a passing-by comment. I get worried about sending IPIs while
> > holding a spinlock because if someone ever tries to hold that spinlock
> > with IRQs disabled, it may cause a deadlock.
> > 
> > This is not the case for this lock, but it's not obvious (at least to
> > me) that holding it in a different code path that doesn't send IPIs with
> > IRQs disabled could cause a problem.
> > 
> > You could add a comment, convert it to a mutex to make this scenario
> > impossible,
> 
> Using a mutex doesn't make deadlock impossible, it's still perfectly legal to
> disable IRQs while holding a mutex.

Right, but it's illegal to hold a mutex while disabling IRQs. In this
case, if the other CPU is already holding the lock then there's no risk
of deadlock, right?

> 
> Similarly, I don't want to add a comment, because there is absolutely nothing
> special/unique about this situation/lock.  E.g. KVM has tens of calls to
> smp_call_function_many_cond() while holding a spinlock equivalent, in the form
> of kvm_make_all_cpus_request() while holding mmu_lock.

Agreed that it's not a unique situation at all. Ideally we'd have some
debugging (lockdep?) magic that identifies that an IPI is being sent
while a lock is held, and that this specific lock is never spinned on
with IRQs disabled.

> 
> smp_call_function_many_cond() already asserts that IRQs are disabled, so I have
> zero concerns about this flow breaking in the future.

That doesn't really help tho, the problem is if another CPU spins on the
lock with IRQs disabled, regardless of whether or not it. Basically if
CPU 1 acquires the lock and sends an IPI while CPU 2 disables IRQs and
spins on the lock.

> 
> > or dismiss my comment as being too paranoid/ridiculous :)
> 
> I wouldn't say your thought process is too paranoid; when writing the code, I had
> to pause and think to remember whether or not using on_each_cpu() while holding a
> spinlock is allowed.  But I do think the conclusion is wrong :-)

That's fair. I think protection against this should be done more
generically as I mentioned earlier, but it felt like it would be
easy-ish to side-step it in this case.

