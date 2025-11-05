Return-Path: <linux-kernel+bounces-885953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C16C345DB
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 712DF4E17C0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C1F2D0C62;
	Wed,  5 Nov 2025 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hEKvgYq/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7zBADfMi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6400154BF5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762329454; cv=none; b=kHiDuTStOEW294Eqy8mfPrDRNxlBsHQHtzcAjUg8mAZWrj27J0WOcO7x5xGNUIZfYk+sFzea7fgKUmTppXZkZzoLqRHg4Uizr/nS6pd85+gTkdVyOa38B8JvHTSmragOMK4WyIccLN+RHcbhNllkndx+QA/2/lvkKaGVJHLxflE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762329454; c=relaxed/simple;
	bh=E5Ki4vzBHbSj1LvWJd5z0IXG2apyZbX8koQWcuq1xa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fs5peC8B8oo3kJDUUkJk/LG+NJSK3J+svkjD9uq2WpmwflX1kJAjV2N7wXyI8beviK+ELlkt1ZLuh3VB28pMJcIUy9KB501134NbnE36vpUOTjfQluNOC6e/zZ607AXcfwbJb8m/HOutGbWyjzCPREILepZxO2CIHDAakXCNZOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hEKvgYq/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7zBADfMi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Nov 2025 08:57:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762329450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fnH9f6P0T39G/alpUyVBKmPv5X17u1TsyuzY3sKEf/s=;
	b=hEKvgYq/TZsVqzUZs6OyFLuu/N07MWHHwK2joeHT7FlOF/rAhqwNuRJiSyj3Le5J7wwu+f
	dAgq4G5Hr2Y1LJAmW/bbn0JCIlRq1iBgJPhj7sdSz13iriWDXI74popnhad1a0OaiE4E1m
	5bSjOE8bqLRppxZV6/SpDTzWaVneOaXU8O0BhH0guzkH2Z/ienZX9vTEtGnkSX5LddWoVo
	QKaHCwKTg/CBsBMl082Aziv4HHiDbk6o92nQWHJpEO0M7TulVBpi7XpoEcP5KmPhc3e5Vo
	IJFMrErMY8y3Mwmg9FuOvyyrnTioq0GUKgXflufF9k2jjNgETjT13d8Iv6Ai1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762329450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fnH9f6P0T39G/alpUyVBKmPv5X17u1TsyuzY3sKEf/s=;
	b=7zBADfMiViL13sl2wFyahFPtAV/FOA9ZV1EPfnFVRlimNGKnHPfghiPu1XL7A0+/KgUN4n
	Yfq6JDVQe6JtQLAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] locking/mutex: Redo __mutex_init()
Message-ID: <20251105075729.SJ4cL1rz@linutronix.de>
References: <20251104140023.jV9j77ld@linutronix.de>
 <4207482b-fc63-4db7-ab98-36b31a600173@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4207482b-fc63-4db7-ab98-36b31a600173@redhat.com>

On 2025-11-04 11:21:27 [-0500], Waiman Long wrote:
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +void mutex_init_ld(struct mutex *lock, const char *name, struct lock_class_key *key);
> > +
> > +static inline void __mutex_init(struct mutex *lock, const char *name,
> > +				struct lock_class_key *key)
> > +{
> > +	mutex_init_ld(lock, name, key);
> > +}
> > +#else
> > +extern void mutex_init_plain(struct mutex *lock);
> > +
> > +static inline void __mutex_init(struct mutex *lock, const char *name,
> > +				struct lock_class_key *key)
> > +{
> > +	mutex_init_plain(lock);
> > +}
> > +#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
> 
> I think it is a good idea to eliminate useless strings in non-lockdep
> kernel. However, the function names are kind of awkward to me. First of all,
> it is hard to associate "ld" with lockdep as ld is also the name of the GNU
> linker. I would prefer to fully spell out as "lockdep". The "_plain" suffix
> also looks odd to me. How about using the original __mutex_init for the
> plain version and __mutex_init_lockdep as the lockdep version which calls
> __mutex_init and use similar naming scheme for the RT versions. What do you
> think?

What about
	mutex_init_plain() -> mutex_init_generic()
	mutex_init_ld() -> mutex_init_lockdep()

Using __mutex_init() for the basic/ generic init could work but we have
already users 13 users (drivers/ mm/ net/) and the rust bindings are
also attached to it. I would prefer the generic/ lockdep suffix.

If you want __mutex_init() for the generic, regardless, we would first
need to make room and then something like mutex_init_lockdep() could be
the public interface replacing __mutex_init() in its current function.

> Cheers,
> Longman

Sebastian

