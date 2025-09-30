Return-Path: <linux-kernel+bounces-837694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF98FBACF67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AAC47A1220
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95095264A72;
	Tue, 30 Sep 2025 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2/G1SM2i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b97220Hc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028C32D3237
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759237434; cv=none; b=i2GVWZUSuuqOME4oIfOk2YW15XNe/AP+6DRQgS+bnBAAsBudit2TT4lqOjU9ITWi/Ivk4yorpjne3X1Vb3Gn2DLcoG6Hb7gAYupZJZ7L8om1LSeBNt81KSG7JYnCgycYKZuaG2uiY0D8TJ/ODzK+6+jnq3E1uIaciOUivR53kQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759237434; c=relaxed/simple;
	bh=AGcvxwycRqLLUN6/GXg/jmiFpMjzJtI3D5YFs4IeLDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RLmbhSwvtSwxttXoRbRfNi+tGo6XbJSHLBa9C3szzWBzHUMenJ9YKt8r+MxWDgYi9g2euuIbshUzm0pEX2ecYtlb0YM1xjtTBJZuU1O4k0goAL4sZhL2P4b+Id5XjTudECYNNjT0wxOUIU3jYV7XCrIIB4y4d19IfhI+5nYY6Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2/G1SM2i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b97220Hc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759237429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LE5EX2pgn6D/ifa4P1XORGJPcO1OadE0wg7VY0lqttI=;
	b=2/G1SM2iEMyc8CEG/ptCUm3jEFZ5mH/dt+YahU2F8PVVC10GxwpuXd5GwkV7Q2r3x5izRo
	GIvb1K1AiqK31tH/AIUUNJLTMs8x+vcoe1u7jD7QZ2xaoLHgg/GQQwVxXis1ZDEIQBJ9vP
	pGvEQ721PHdXSligb4HZ/44Too9JPTKBfa7BJ7zwLogC2IAdbCMATTY7PBWyEMkDk41003
	v+isY1EPpdyS5lqiEDSs/lbN0b2gY8FXNGtH4Fh0LIe/0CIAY5NLo1TvVhmZfM3rrSKS+P
	VpzfLd6CVPhVUgzgh78xeuJS4XQBTSF4dTJPNBMKP8hBQSOFFvq/WhZ3V4xVGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759237429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LE5EX2pgn6D/ifa4P1XORGJPcO1OadE0wg7VY0lqttI=;
	b=b97220HcnL2ONvgXZz32duKShgrk7T90vHUf1ER8ccBstqiZsG2JcjhW+hq3cZrYL6ZyFv
	XxIVfFR3wEsY/7Dg==
To: Andrew Murray <amurray@thegoodpenguin.co.uk>, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: Re: [PATCH v2 3/3] printk: Use console_flush_one_record for legacy
 printer kthread
In-Reply-To: <20250927-printk_legacy_thread_console_lock-v2-3-cff9f063071a@thegoodpenguin.co.uk>
References: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
 <20250927-printk_legacy_thread_console_lock-v2-3-cff9f063071a@thegoodpenguin.co.uk>
Date: Tue, 30 Sep 2025 15:09:48 +0206
Message-ID: <84ldlwjdmz.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-27, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index e2c1cacdb4164489c60fe38f1e2837eb838107d6..2c9b9383df76de956a05211537264fd6e06366da 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3668,17 +3668,29 @@ static bool legacy_kthread_should_wakeup(void)
>  
>  static int legacy_kthread_func(void *unused)
>  {
> -	for (;;) {
> -		wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());
> +	bool any_progress;
> +
> +wait_for_event:
> +	wait_event_interruptible(legacy_wait,
> +				 legacy_kthread_should_wakeup());
> +
> +	do {
> +		bool any_usable;
> +		bool handover = false;
> +		u64 next_seq;

Please sort by length. It looks nicer. ;-)

		bool handover = false;
		bool any_usable;
		u64 next_seq;

Note that it is fine that @any_usable is not initialized here because
legacy_kthread_func() does not actually care about this variable.

John

