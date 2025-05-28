Return-Path: <linux-kernel+bounces-664873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033A4AC61B2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 08:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5390171013
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 06:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325CB214204;
	Wed, 28 May 2025 06:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nDuXxbNU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RDVieAar"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F57212B3F;
	Wed, 28 May 2025 06:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748412704; cv=none; b=q2MW2MzQ78cgqtkyF8z/zg+7WK4sBr9M0686XFjws0dUGef7LQ4J194QWiqLDCi++667mV2mgklk4uTGbmYM614iYgiz6BktrHAMFINrNK4w/ZImhRhia9mzGl4h3SXYXbZJysIsGOz2RyY+ESOP2KFg0s6DkO8DpgVq71EmXLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748412704; c=relaxed/simple;
	bh=th6onijDmEAqKQNBouMaWlCRYU8Gs+p4CxlQ9kwbO7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnN92E5a5a8coKXEO/Y7agF1tQn7LqzOSm6ZHyfWISPu81RCnL/VTHb1AQZDf5o5O9Sgq1K2s2VA0PJs8w7RQ1GdXqBdlsQvVODmgq8sKvMl5rzENF1VJIxcIZ3LdZDv8y+Uf+gmd4VMNuqDiM+UGOOuoY2pJeGolYUt4eTMewE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nDuXxbNU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RDVieAar; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 May 2025 08:11:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748412700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=16YBBqCiZhinPTnmceXSxQCAGhulKhyOEucK93L3/6Y=;
	b=nDuXxbNUG+IfucsOEgIpuE37NDn2WnRNjloqdPvW2+JNSU5hQG6xrJ/7SWBT/bKgzBkD69
	1Kb6a0w9XAU+Jo1HRDUQcr9b5RnhObUMWdSel8BIkJm1P5sU4IU9vTlq761MkMvtETDI82
	POyi2Y3+OYiyBaefWkOGqWBAdHZ5+bZTJKn9i79ZXi62zr51zt0pJCeqVBJRrLjqtii6+M
	ZzhBI/E4kUGcdCb392b6W3InVViO8eCFCh/PSFJlohyzlM1gNk23ALs5EEF3iPnjT8MhPb
	20SaJR9rSLnkXRqUWeNdmshSdJXPvYZQk99Wzwg8HKjYnL06ffqRiRNABhrGtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748412700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=16YBBqCiZhinPTnmceXSxQCAGhulKhyOEucK93L3/6Y=;
	b=RDVieAarL/NxlTX3kgjO/lS4BPTq3Ap1FSSufSQNGwtzI5doPyQ1HkfDol92snApSGTgR/
	Wfd0NzbxdNpwJxBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Subject: Re: [RFC RESEND v10 14/14] locking: Switch to
 _irq_{disable,enable}() variants in cleanup guards
Message-ID: <20250528061139.MduTfTBS@linutronix.de>
References: <20250527222254.565881-1-lyude@redhat.com>
 <20250527222254.565881-15-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250527222254.565881-15-lyude@redhat.com>

On 2025-05-27 18:21:55 [-0400], Lyude Paul wrote:
> diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
> index 6ea08fafa6d7b..f54e184735563 100644
> --- a/include/linux/spinlock_rt.h
> +++ b/include/linux/spinlock_rt.h
> @@ -132,6 +132,12 @@ static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
>  	rt_spin_unlock(lock);
>  }
>  
> +static __always_inline int spin_trylock_irq_disable(spinlock_t *lock)
> +{
> +	return rt_spin_trylock(lock);
> +}
> +
> +

no extra space, please. It appears this should be part of another patch.
That patch where the spin_trylock_irq_disable() was introduced.

>  #define spin_trylock(lock)				\
>  	__cond_lock(lock, rt_spin_trylock(lock))
>  

Sebastian

