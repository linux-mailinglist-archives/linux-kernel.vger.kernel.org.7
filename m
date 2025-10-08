Return-Path: <linux-kernel+bounces-845742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5CABC6020
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9094342197E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2C71EF09B;
	Wed,  8 Oct 2025 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dptOlpJV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bQoZ1pKf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81A58F49
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940143; cv=none; b=fxvHFYpPsG3bx4KGJQl87wsvocQH8KZTFCOzeSwICNT1I+uZpTQd3NWwMEXPNjARycPKgUkLN/rLakstp6W2M5wWpWq4D8u/Oq4W2yWDKx+xxFp0Vro9/PKKGBgsHlxiDR+VHktuizBt4R553BPdYtUjlQHAet3YK1Dm6KLGNKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940143; c=relaxed/simple;
	bh=wB8gPaPCoPRggkNa2NJF1htR3Kjts2V6/Lb+iF8T6FQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FQEh50Hc2V4vCiZYJTXneAyy+Ux3iQGpUTjDy61yx2X13n79kXs8T/YwYvqWHabVVIBdOj7rYDIati5yZag7CH2Z4MzcZgsW5QBeSnrkG7gm4ZAGgVN/OHj1JBKm/Ckpqg7uK2h/LASmckxAjfpTfkUJZBiML8If2b0C8Wsr9MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dptOlpJV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bQoZ1pKf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759940139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QB21/0CvEuLmBTRfAfXcOzC7ry9QkKtf2uUH8S2hcq8=;
	b=dptOlpJVkdXQC4lSLy9c8YpTx8ZijWNbj/Dk7ZX8jLUQxBuC2Wu+n3BCaNtGr2Ovb9aGQC
	WkuGpEzvz6SvRs2kl2A0nAXFrD1IwBf7dbw7okF2iiC8dCRZk5viOdxf6Qc0dQ6O8DM6Ky
	9t9Q3Aq28RyS+1i2xC1zdU0bANwi+RGl0okVYC3rCrLOn70mMY49USg2t7VHZBxboSQgOj
	ShK5dRn6NILIMGuQkQfQgSDzwNPOz9YvEyF7M5SU2CScwo+3QQVt/TGJOd8N6wJTS+0rYS
	WcobSvDyY/ShLAwmimsY1Mr5C3QLh6kTfMU2C5WlEjRM7LUcezbNXWUlWyQjGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759940139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QB21/0CvEuLmBTRfAfXcOzC7ry9QkKtf2uUH8S2hcq8=;
	b=bQoZ1pKfHMTcB7UF1ys9yy59XVTCd2ui34rthRnccKJPvCxAEEUndD05islM4RbqRcxtG2
	p4Y2hVfAPTROiQBA==
To: Petr Mladek <pmladek@suse.com>, Andrew Murray
 <amurray@thegoodpenguin.co.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] printk: Use console_flush_one_record for legacy
 printer kthread
In-Reply-To: <aN_5OQkomghqQVwH@pathway.suse.cz>
References: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
 <20250927-printk_legacy_thread_console_lock-v2-3-cff9f063071a@thegoodpenguin.co.uk>
 <aN_5OQkomghqQVwH@pathway.suse.cz>
Date: Wed, 08 Oct 2025 18:21:39 +0206
Message-ID: <844is9pdxw.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-10-03, Petr Mladek <pmladek@suse.com> wrote:
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 6c846d2d37d9..885506fa0178 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3644,17 +3644,27 @@ static bool legacy_kthread_should_wakeup(void)
>  
>  static int legacy_kthread_func(void *unused)
>  {
> -	for (;;) {
> -		wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());
> +	bool try_again;
> +
> +wait_for_event:
> +	wait_event_interruptible(legacy_wait,
> +				 legacy_kthread_should_wakeup());

This should be on one line. Even with an 80-character limit it would
fit. ;-)

> +
> +	do {
> +		bool handover = false;
> +		u64 next_seq;

Even though legacy_kthread_func() does not care, @next_seq should be
initialized to something since console_flush_one_record() reads this
value to decide if it should be increased. It really doesn't matter what
it is initialized to, but I guess 0 makes the most sense.

John

