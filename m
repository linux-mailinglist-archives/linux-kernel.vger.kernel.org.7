Return-Path: <linux-kernel+bounces-803024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2FEB45991
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5859F7C4C15
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D5235E4C7;
	Fri,  5 Sep 2025 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QXrSOSNc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tUh6xKhO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7285935CED4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080156; cv=none; b=lIPzNUsLbOYVCrxV485LgHXhvJyCTdIpouBbxMJUyD7yyBFPCZZvWfrfTkZe9f7tj0vlHFdLxriAhXLygKxjh2VQOwdgZsN562+cptR1DwLYXQLVDFqz/dgxBIFc0rXqdvh1U2PQNG0LsX9B8I/c84qCTbvc0kMSiomAjrw9GGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080156; c=relaxed/simple;
	bh=Hyij9GvnO9P7fewDJxzbJ5TTnNsqvSnXtJRP7mrBQQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gXy/PX7Nwk93nXZ8Ih9SlHbNfQTuRLH8MKCkUW6sFkrrsQLbcA1Om9JZMIM5R0xBdyuk/RMVKqtPp9s3kqTgxuOmb9Q6cq0ncUd+FztW0LcZI/zfRC8VZrDA4E2sj/V4luy7DbjRlJMjQu9TaDYO7NZJlo2EcYPwaG5cuaanOfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QXrSOSNc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tUh6xKhO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757080152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+YCOhnbTUm+NTl9QRitDqMw0nh1plhowmudd5M+EQ1I=;
	b=QXrSOSNccIFlTMqWW1ERDYMTnWbq8ZNNx9oqnpZwVzm/gCYwRY9pZmcZ9Do4KDE9X3CzQJ
	G8isaTVc6tzOVAgd6h0Vz9jUItttnROkdwbOi7WiTj6qgf+7xL72gFMH26HA4cWDKBLIgA
	7Qxw56JIzGN/u5kQw68mApfKn11AqWooVGrYAwMiKmovfxFMhydaGscseckbWPluGJrHlw
	3kjFCKZZt7Oln7yNYhzPNvpnfYhN5A22KoKI5Hjmr3R0wg6su/lkCYu64Pm20Ecrf4XMTs
	PqOAKRwpYdPsWYO2g+U+xCMnCQ2gSyYZG0uaTJ0en7kWI/q4f/WwLfoKEdPK0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757080152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+YCOhnbTUm+NTl9QRitDqMw0nh1plhowmudd5M+EQ1I=;
	b=tUh6xKhOhRBa/pDd+9fCPnosUnBQUM0ZJPwjPT+gJ7tymJoh/gowRl553li8BCsisywYWH
	pNf5kN8KN/idUGBA==
To: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>, Feng Tang <feng.tang@linux.alibaba.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] panic: Remove redundant panic-cpu backtrace
In-Reply-To: <20250903100418.410026-1-pmladek@suse.com>
References: <20250903100418.410026-1-pmladek@suse.com>
Date: Fri, 05 Sep 2025 15:55:11 +0206
Message-ID: <844ithf1rc.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-03, Petr Mladek <pmladek@suse.com> wrote:

> From: Sergey Senozhatsky <senozhatsky@chromium.org>
>
> Backtraces from all CPUs are printed during panic() when
> SYS_INFO_ALL_CPU_BT is set. It shows the backtrace for
> the panic-CPU even when it has already been explicitly
> printed before.
>
> Do not change the legacy code which prints the backtrace
> in various context, for example, as part of Oops report,
> right after panic message. It will always be visible in
> the crash dump.
>
> Instead, remember when the backtrace was printed, and skip
> it when dumping the optional backtraces on all CPUs.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Link: https://lore.kernel.org/r/20250731030314.3818040-1-senozhatsky@chromium.org
> [pmladek@suse.com: Handle situations when the backtrace was not printed for the panic CPU.]
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 72fcbb5a071b..e3cec9bc05ef 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -422,13 +432,15 @@ void vpanic(const char *fmt, va_list args)
>  		buf[len - 1] = '\0';
>  
>  	pr_emerg("Kernel panic - not syncing: %s\n", buf);
> -#ifdef CONFIG_DEBUG_BUGVERBOSE
>  	/*
>  	 * Avoid nested stack-dumping if a panic occurs during oops processing
>  	 */
> -	if (!test_taint(TAINT_DIE) && oops_in_progress <= 1)
> +	if (test_taint(TAINT_DIE) || oops_in_progress > 1) {
> +		panic_this_cpu_backtrace_printed = true;
> +	} else if (IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE)) {
>  		dump_stack();
> -#endif
> +		panic_this_cpu_backtrace_printed = true;
> +	}

It took me a while to wrap my brain around this new logic. I guess in
part because the comment above only tells a part of the story. I tried
to write a suggestion for the comment, but it ended up being just as
confusing as the code. So, I guess we just leave it...

It seems this patch has already been picked up in the mm-tree (with a
patch on top), but if not:

Reviewed-by: John Ogness <john.ogness@linutronix.de>

