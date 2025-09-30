Return-Path: <linux-kernel+bounces-837684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BB3BACF13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68CED189330A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC1C2FC88B;
	Tue, 30 Sep 2025 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lL0FY3Az";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1hg8AnXj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D921B4236
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236859; cv=none; b=Rlzo+KwF58ed3Wou0f+P3FdPztXornrvyXi8YKgQcJ/pIr2Y3T+CPXenwqvnU1OZyST+pHcmeKdoW3uNgZnwunQb47tZa3x6ufm0XPhvyNDqwvE3SRVpMbRynhjbPkM9D3Dgvt1wiD5F5a7Gu64V690Jv0Ute70sWscR/vooob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236859; c=relaxed/simple;
	bh=vXpldruJYhbfDoxDWzmNDNZQcDUfHyYa2KrRL+D5MA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XFSuEfh3sxROMOk185Te5jOMY+8JFfCuytUwm3JbRH0sEiE8ZCZbFbV/rar6lQvGRD7eW7GubLYXk7TiFITsEyehGgP5atU2+twf8u6KvW5YDalQTCEuyEmQEGGEwci+Q3S226ctPkOeX+UrUNzatts8n+ZCDY9B0Myq6VAbwng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lL0FY3Az; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1hg8AnXj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759236849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VwlejN6/I1xN6mFz8KIsqVY0jlQ9hYQPLHG0XlHA7Z0=;
	b=lL0FY3AzqjVTVXHOdj2n2evQiaXMPwv/ySzEjEz9rzaapVXu4DUFWhGgcM4cx2pXr+3cHs
	MQn9UgcvhjrTdE8jYnhXDtmL6SieOhg6PRqfTpoyVb7O9F3jvToBJu21pkwVKyvAn77xdy
	d7Ww++uFk9vftD98VBSgXbwe/q64C00Ou4pSjjwdz1qUBAnp5vfpztM3e2aeLqRhOf2NeB
	glFBnlSsC06gXTFnnaHvM85Wr8D/dAYoSWg1SsnlXn1+4/0c9cNE6i87az33M2Alf/fi2K
	uLvk6YhB4qhLO+oIfoKI3AytIB/bzQPCO2xGbI7NFfAn4qr4JKMoJn1/+v+fzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759236849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VwlejN6/I1xN6mFz8KIsqVY0jlQ9hYQPLHG0XlHA7Z0=;
	b=1hg8AnXjpMk7pHW1okpDqoq300aM7oEPEOB1tnIEFDj8OEcDwGPpEvuBpYcRO7Hi07GkBj
	TLwmnqX8/yVdr0BQ==
To: Andrew Murray <amurray@thegoodpenguin.co.uk>, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: Re: [PATCH v2 1/3] printk: Introduce console_flush_one_record
In-Reply-To: <20250927-printk_legacy_thread_console_lock-v2-1-cff9f063071a@thegoodpenguin.co.uk>
References: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
 <20250927-printk_legacy_thread_console_lock-v2-1-cff9f063071a@thegoodpenguin.co.uk>
Date: Tue, 30 Sep 2025 15:00:09 +0206
Message-ID: <84qzvoje32.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-27, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 0efbcdda9aaba9d8d877df5e4f1db002d3a596bc..060d4919de320fe21fd7aca73ba497e27c4ff334 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3161,6 +3161,100 @@ static inline void printk_kthreads_check_locked(void) { }
>  
>  #endif /* CONFIG_PRINTK */
>  
> +
> +/*
> + * Print out one record for each console.
> + *
> + * @do_cond_resched is set by the caller. It can be true only in schedulable
> + * context.
> + *
> + * @next_seq is set to the sequence number after the last available record.
> + * The value is valid only when this function returns true.
> + *
> + * @handover will be set to true if a printk waiter has taken over the
> + * console_lock, in which case the caller is no longer holding the
> + * console_lock. Otherwise it is set to false.
> + *
> + * @any_usable will be set to true if there are any usable consoles.
> + *
> + * Returns true when there was at least one usable console and a record was
> + * flushed. A returned false indicates there were no records to flush for any
> + * of the consoles. It may also indicate that there were no usable consoles,
> + * the context has been lost or there is a panic suitation. Regardless the
> + * reason, the caller should assume it is not useful to immediately try again.
> + *
> + * Requires the console_lock.
> + */
> +static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *handover,
> +				     bool *any_usable)
> +{
> +	struct console_flush_type ft;
> +	struct console *con;
> +	bool any_progress;
> +	int cookie;
> +
> +	any_progress = false;

I would let this be a definition initializer. And then place it sorted
by length:

	struct console_flush_type ft;
	bool any_progress = false;
	struct console *con;
	int cookie;

John

