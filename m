Return-Path: <linux-kernel+bounces-837690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CF3BACF4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4CC1752F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB03302772;
	Tue, 30 Sep 2025 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PMKCgMlu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6wGUUNVm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64ECF4FA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759237149; cv=none; b=HLqaE4GOXEWc0d2I1oY3y1CGelMCcXUwErYW2Nc838hKfz5HCRW1a+NZCZtAijKmbEipCpwPXxKoczANaA1+xzPKi/CLX85eVhRPhLNfNW2v0IHe0OEL/wPckgv4j/CiAbSn1vDJ6lO+thpmBdMBDQEaaOycaUsALdODxBUQgII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759237149; c=relaxed/simple;
	bh=1dl/cP7+OtbeP+RUUdTTgedSwuLF05svFJMNonP8zGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=usQ5jaDpI/3mIw5Yx0+j5n448NzMCQRwUPREJg/DTr3ZMcQn0X0EQIDg+Kk8ikrJ50l2FuQA1lI6V0aZoq6BFWWsicsDOSQ8Z87cjCbjz/M708AcOr002lznE+6hB7GSLGgCyXt1za6K1q0yZK5nN2S9gDwTd5cjAxy9kj1927Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PMKCgMlu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6wGUUNVm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759237144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+NehTWFwT7q42+Pi2NENAgBxXd2qLOQoDQ70/3FTjcI=;
	b=PMKCgMluRXpF8W5qf5ufGYcIE7bHMOIPUADZvLH1tML06s8TB72g0DNATmVzumMGUCrdTx
	CcxoWi3Lg8qmc4piqF3VthrvF3fiz9FP+yOz/OoGD0Ekky+xyfNUbuX25qWkOdFu2mpFoN
	k34RG0trzlgWlZ2zKznh8ZHtRkUCNe+erjWGJor+3JWcc/GzmOm/mml4abK2dotZU581NX
	9LMD3DoAntLsURirDCtruB8jiFj/Qsf52hIH5lSGYFbCrM8Sev9qZ8hGoOHUK+ssvCSqKa
	UCUop3UJN7RgoTVWsUhHHuMKKICWzwgWtdBbq2eIIXf5SZK6uEHnXJGVWyaJaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759237144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+NehTWFwT7q42+Pi2NENAgBxXd2qLOQoDQ70/3FTjcI=;
	b=6wGUUNVmmClQMSEaLS9lu+YAFtP3LDBrZhMGspwRAEk1vS9YKVtNdZF9OhsvSWtZ4osjtE
	xkZ3QNKj4PmuN6CA==
To: Andrew Murray <amurray@thegoodpenguin.co.uk>, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: Re: [PATCH v2 2/3] printk: console_flush_one_record() code cleanup
In-Reply-To: <20250927-printk_legacy_thread_console_lock-v2-2-cff9f063071a@thegoodpenguin.co.uk>
References: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
 <20250927-printk_legacy_thread_console_lock-v2-2-cff9f063071a@thegoodpenguin.co.uk>
Date: Tue, 30 Sep 2025 15:05:03 +0206
Message-ID: <84o6qsjduw.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-27, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 060d4919de320fe21fd7aca73ba497e27c4ff334..e2c1cacdb4164489c60fe38f1e2837eb838107d6 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3193,6 +3194,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
>  	bool any_progress;
>  	int cookie;
>  
> +	*any_usable = false;

Since it is expected that @next_seq and @handover are initialized by
their callers (if their callers are interested in the values), then I
would expect @any_usable to be initialized by the
caller. console_flush_one_record() never reads this variable.

> @@ -3280,21 +3284,16 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
>   */
>  static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
>  {
> -	bool any_usable = false;
> +	bool any_usable;

Since console_flush_all() does read @any_usable, I would expect it to
initialize @any_usable. So I would not remove this definition initialization.

>  	bool any_progress;
>  
>  	*next_seq = 0;
>  	*handover = false;
>  
>  	do {
> -		any_progress = console_flush_one_record(do_cond_resched, next_seq, handover,
> -							&any_usable);
> +		any_progress = console_flush_one_record(do_cond_resched, next_seq,
> +							handover, &any_usable);
>  

Since the second line of the call to console_flush_one_record() already
has a ton of whitespace, I would remove the above blank line.

John

