Return-Path: <linux-kernel+bounces-721265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F20EDAFC6DA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B85657A5BF7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119B57E107;
	Tue,  8 Jul 2025 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VtBBQQlm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W0swQmsn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95D08488
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751966191; cv=none; b=J+DJCqnjVvWtR7G+3qHylTHTJDxfIar7M0QK7VQxW2PPLIuYc+XdDpx59QaS3qzDdL6nmwfe+CLlToO0Xz1/KcUqQWAtYyDZeyFVSXleAie6gHohuPHnZQAN9c5s7Zl3P42XvGcxQLkJoRDkbcONPIU696PFx/m3HlZxuUXqHxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751966191; c=relaxed/simple;
	bh=GCFlR2DlpoOBxVuSw1K9MHVepCkM645sbkKt2GKuPAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoMDMS5m6PJudBNj1lUx9iWlmjY5wIaiHhRMvFcGZGM+V7wpSR8+H0dKLelwVHS6hZIKzZs3pDkEinsDsJLywdQf37zyXfOeQM3+b1tPrPopPCSoFgzEJndt/+nyg8vuj/Jp+sPVhqoAsD1PHP56SY89fDJPfGrwyFc8pJK3Gnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VtBBQQlm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W0swQmsn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 8 Jul 2025 11:16:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751966187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kH6Q5UEgAZ4pYQlXZxsf0p+WOykj/75YVMnZ2RAK+4E=;
	b=VtBBQQlmWpSaZjd/zZfqIANLEE8MLUBfP5CUqT2aaos9munLJT9M8iRKVG/wE/PI/wkfmq
	ktE6PXZjEcoguUmqhezQ93RzvKCYZcvzEl2gdWe+0H+YtQnrHGql6rARhbufww4am47KoZ
	pGm6scE4vA4pwWM/Ii3y6rEkoFL1CnJbkGz2qZga/RZIaKcI19zgYAFFYqPL6RfqakIHyu
	D5TpQacRZTN04AUsKLkiGHuSvoCPQN1JfqaXdbc/fd1yCTsYqxuUOuSeF9ZCQzsYSPpSu6
	2OLY+d57jg/Uj9s0iW0+seY2ojej9jyxt06zQhnxqrGQgwWzDdbLLGqFz/5CFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751966187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kH6Q5UEgAZ4pYQlXZxsf0p+WOykj/75YVMnZ2RAK+4E=;
	b=W0swQmsnUW4Y3mOHc6iX2LRoLrQWlev2rE255jAQwGbGQJj7k3zqvGq8CDX/HiJUk5YCzX
	d8Qs8VADqGR0SYBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hillf Danton <hdanton@sina.com>
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/3] futex: Use RCU-based per-CPU reference counting
 instead of rcuref_t
Message-ID: <20250708091626.BYR6lG2J@linutronix.de>
References: <20250707143623.70325-1-bigeasy@linutronix.de>
 <20250708085640.2918-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708085640.2918-1-hdanton@sina.com>

On 2025-07-08 16:56:39 [+0800], Hillf Danton wrote:
> On Mon,  7 Jul 2025 16:36:22 +0200 Sebastian Andrzej Siewior wrote:
> > +static bool futex_ref_get(struct futex_private_hash *fph)
> > +{
> > +	struct mm_struct *mm = fph->mm;
> > +
> > +	guard(rcu)();
> > +
> Like regular refcount_t, it is buggy to touch fph if futex_atomic drops
> to 0. And more important guard(rcu) does not prevent it from dropping to 0.

What is your intention with this? There is an inc-if-not-zero to ensure
this does not happen. And it has to drop to zero in order to get
replaced.

> > +	if (smp_load_acquire(&fph->state) == FR_PERCPU) {
> > +		this_cpu_inc(*mm->futex_ref);
> > +		return true;
> > +	}
> > +
> > +	return atomic_long_inc_not_zero(&mm->futex_atomic);
> > +}
> > +
> > +static bool futex_ref_put(struct futex_private_hash *fph)
> > +{
> > +	struct mm_struct *mm = fph->mm;
> > +
> > +	guard(rcu)();
> > +
> > +	if (smp_load_acquire(&fph->state) == FR_PERCPU) {
> > +		this_cpu_dec(*mm->futex_ref);
> > +		return false;
> > +	}
> > +
> > +	return atomic_long_dec_and_test(&mm->futex_atomic);
> > +}

Sebastian

