Return-Path: <linux-kernel+bounces-686127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FABAAD9365
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 19:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839E918930E9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 17:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7380421B195;
	Fri, 13 Jun 2025 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wVAhFgzS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PuY4vm91"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C878472
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834186; cv=none; b=db98+oW8wyGwL0uc6BcEKfZE8O7aP10IvYnei0Ouh/08MBNHLtQE/jLsI5qzYWsyZBQjKLpftwrhPsb5FHS9/9JYfojMTIlEF0SKOxqJ3Temn1lPpr6+v9u7fPXbAI5Wf2KImF2xj/Orj9RKP3f62LJ0J1WxKMV7o8rXiozZV5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834186; c=relaxed/simple;
	bh=/r40uZR/KO3gsL0fdXn7quqO1Y7noMETxV4Ji86P3s4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dlrtr+U2w4wHdnEKCrPAoUjZNVZ355a0yCz8oI9K9NF7l5euG4WfvQenzhV2Atk8rAhvNIBdXZkFs80J9s+e/+g+g+v0Hq7Wc+XvG4tb+Ac9sV1+Qxuv1DiwHLj3mPbzUUZ3J+vsJd9oEuiLvYLZYfTCcov75VI6LPZqGMmWFsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wVAhFgzS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PuY4vm91; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749834183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7NfgeF2dC2QINSkCwFY7dOB7Pf1iyEUqChtxCjfUjFw=;
	b=wVAhFgzSVm6kS9Ztjloehah17EJj+npVOpu28Rq3gsN1hS4V1h2mSEIlJRWU4AJnlIKbNr
	z38NJ4+88VYuLXah9EzRxhATJpgB7BfnVQMwRHnq3LMRjnn22QT471Fut4bYze/PZTh53K
	QkBBHHbXkwDjPtVFNpidWFJEh8nI0Ou4cLwB4utWMAFkFxE2AayA43MMus4D8+3hKGLjNi
	P15woFv/kylxgiqQ1+7dzJ3xxqrGUXRVzi13pluT9BCFaP26jwgWtgJYZnUmMnBd8SZpxu
	HghbHz9XBwav8SlKFMjlEPeuZQD67QyKELdrAFb3tomsEjRn28zUicyAFOBwyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749834183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7NfgeF2dC2QINSkCwFY7dOB7Pf1iyEUqChtxCjfUjFw=;
	b=PuY4vm91yJw+AZX3wKbnV/GEGRYKRqnpCNpkt4TvNPtP58geJXOrMmrJCjwm5Dj+AgqFE+
	lFRWNWHAW5SxrFBQ==
To: patchwork-bot+linux-riscv@kernel.org, Andrew Bresticker
 <abrestic@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, anup@brainfault.org,
 palmer@dabbelt.com, alex@ghiti.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/riscv-imsic: Start local sync timer on correct CPU
In-Reply-To: <174957291849.2454024.7268696984666677694.git-patchwork-notify@kernel.org>
References: <20250514171320.3494917-1-abrestic@rivosinc.com>
 <174957291849.2454024.7268696984666677694.git-patchwork-notify@kernel.org>
Date: Fri, 13 Jun 2025 19:03:02 +0200
Message-ID: <87sek3poah.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 10 2025 at 16:28, patchwork-bot wrote:
> Hello:
>
> This patch was applied to riscv/linux.git (fixes)
> by Thomas Gleixner <tglx@linutronix.de>:

No. I never apply patches to the riscv tree :)

> On Wed, 14 May 2025 10:13:20 -0700 you wrote:
>> When starting the local sync timer to synchronize the state of a remote
>> CPU it should be added on the CPU to be synchronized, not the initiating
>> CPU. This results in interrupt delivery being delayed until the timer
>> eventually runs (due to another mask/unmask/migrate operation) on the
>> target CPU.
>> 
>> Fixes: 0f67911e821c ("irqchip/riscv-imsic: Separate next and previous pointers in IMSIC vector")
>> Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
>> 
>> [...]
>
> Here is the summary with links:
>   - irqchip/riscv-imsic: Start local sync timer on correct CPU
>     https://git.kernel.org/riscv/c/08fb624802d8
>
> You are awesome, thank you!

That patch has been committed to the tip tree and is already upstream.

Can you fix your bot scripts please?

