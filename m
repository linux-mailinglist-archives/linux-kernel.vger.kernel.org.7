Return-Path: <linux-kernel+bounces-867005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86397C01511
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5911A070CB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9973128DC;
	Thu, 23 Oct 2025 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A1EIdV7z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f7No0xt+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E72030AD04
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225498; cv=none; b=guQTaURzlg5kFFp7OZTVR+XJCPlRRAkEdLGrnStmRDn4AzJqJg5ang92AXI2fJhMcFbKysabyV2haCaxY/4xfBbbQXuYIhQCg7Am7jHVPVzOD+AGIrmyVpLqiup7SFA97ebzVaZo5pOBxIqjDutky0u7cFJe/p/4mCKSksN4uJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225498; c=relaxed/simple;
	bh=9eXWEPq+v1PCop+sTcCUUgwtBYjzQWP1p/id2HfEI6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c+Je1GXWLFF5w+kr135VQVYNt6Cpd/WVHRZ+jrjUlgv5tJ8ie+XtVelqBlbzCtRyjLmE0R809HA8QegiR4meDEEHnbneBWCGCqAVqZjU4JqeJZG58a2A/57oqBzLjKBmQX+emvAIze71OPYURlsqE7IW7bLK2yIRtSlNQp0F3Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A1EIdV7z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f7No0xt+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761225495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EmwRsS5Ign3VMIJM5n89YAaCArVa9+idL9NEn3aBDzY=;
	b=A1EIdV7zYm0wmjvZy8jUqATF0GmruWTybeHjs/tXbnD6tTWu75xoZVLUj0hvarEV2BG1kW
	8xygVT4PbmxtTOGouFqkNCfrtbfikbD00a39z5h2jSTab8yAFmjmIAJEPE0DzSvjAhc4Q1
	83JEFHz0ZHfIwLyWM+mIrB2t3uTFHZgbO2hcuIcTpTJKx3i3p1TVVg0Cn5axWo8RXJSUnC
	G0hXOUrwHW5NyrYqslN4aawfHNxlJS1uMv7q5jteSDPX+NRntWkZRnCdpq0IKJD/935gOo
	pdY0hf186kXK+qHAjfsqcgiTnAS6WwUyP3R+OOlLUauvwTCIW0jrcn8oE8zM/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761225495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EmwRsS5Ign3VMIJM5n89YAaCArVa9+idL9NEn3aBDzY=;
	b=f7No0xt+Czlvs7P+nJ9q0NkUQz9mHS7d3dl8ffHm0AtCdVp3hyj7ojTOh/POszcAb02YsE
	3mqoNvSs9iCec7Bg==
To: Andrew Murray <amurray@thegoodpenguin.co.uk>, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: Re: [PATCH v3 2/3] printk: console_flush_one_record() code cleanup
In-Reply-To: <20251020-printk_legacy_thread_console_lock-v3-2-00f1f0ac055a@thegoodpenguin.co.uk>
References: <20251020-printk_legacy_thread_console_lock-v3-0-00f1f0ac055a@thegoodpenguin.co.uk>
 <20251020-printk_legacy_thread_console_lock-v3-2-00f1f0ac055a@thegoodpenguin.co.uk>
Date: Thu, 23 Oct 2025 15:24:14 +0206
Message-ID: <873479daeh.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-10-20, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 1c048c66d09919967e57326e1732bd17c10f3c76..6c846d2d37d9d20bad58c6e3a7caada3be9552ca 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3142,31 +3142,33 @@ static inline void printk_kthreads_check_locked(void) { }
>   * context.
>   *
>   * @next_seq is set to the sequence number after the last available record.
> - * The value is valid only when there is at least one usable console and all
> - * usable consoles were flushed.
> + * The value is valid only when all usable consoles were flushed. It is
> + * when the function returns true (can do the job) and @try_again parameter
> + * is set to false, see below.
>   *
>   * @handover will be set to true if a printk waiter has taken over the
>   * console_lock, in which case the caller is no longer holding the
>   * console_lock. Otherwise it is set to false.
>   *
> - * @any_usable will be set to true if there are any usable consoles.
> + * @try_again will be set to true when it still makes sense to call this
> + * function again. The function could do the job, see the return value.
> + * And some consoles still make progress.
>   *
> - * Returns true when there was at least one usable console and a record was
> - * flushed. A returned false indicates there were no records to flush for any
> - * of the consoles. It may also indicate that there were no usable consoles,
> - * the context has been lost or there is a panic suitation. Regardless the
> - * reason, the caller should assume it is not useful to immediately try again.
> + * Returns true when the function could do the job. Some consoles are usable,
> + * and there was no takeover and no panic_on_other_cpu().
>   *
>   * Requires the console_lock.
>   */
>  static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *handover,
> -				     bool *any_usable)
> +				     bool *try_again)
>  {
>  	struct console_flush_type ft;
> -	bool any_progress = false;
> +	int any_usable = false;

Nit: This should be a bool.

With the change:

Reviewed-by: John Ogness <john.ogness@linutronix.de>

