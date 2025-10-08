Return-Path: <linux-kernel+bounces-845725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9766BBC5F16
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 549C34EC051
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761772BD02A;
	Wed,  8 Oct 2025 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yTOk5OU/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0WteRm89"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51519209F5A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939588; cv=none; b=OuGu+9VlCOAE/WcktPX8qkh6sHG9P1Y/zHuJGpnKRFzyULefGf1kHRf/eN2uVF2q3YDKyD0bCaxe5/JWcZk2BnacANqPBDVIA2D7yIN8aeRBdffV6VYQH0g02domTps5JFeQlLMKNlNVGWIQ2L7yxPbTxxy1b3TtWdojwO6kHfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939588; c=relaxed/simple;
	bh=JYJu2ahjeQH0dPXW2/7GRMD4IlCeH8DIRsn/TeiVSHk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cMIxyE7Jji/fIDcQ9BxEq2tnR+XgzsLdzQHwyYdWfEdME3t4PnuIRCC7jxHmAqcrIRu61hc2y6HR1SmyVDF2miw6I8OPezpSu4GwiAP53iIfVofjhlgVv/nIz0NduAcQp0br8/IoP5DehN2HBOLry7aTUVrpq1UPrNqwv9aMO7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yTOk5OU/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0WteRm89; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759939585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l2QJQuQC53R2PDYMQSGmMSwZa5exJe3Ich5J62UdjpI=;
	b=yTOk5OU/0IpOnKJfDv141Ycm4sJNlokdpdzoErzdZGCPzTcEiOM08XHjG1MRjjuFyGRu0I
	e+PGQzgDvSBnJXVhMVeXFO9dKLCLqB4MIR6AL0bDw4GT+eLqvQz1lrqTlw/bw90xQ7NQXU
	ANkqHOGLUVi3v0Q7nGul/qLrvfdih9oQZ+kRdx1mzrNAD513LEATmtFJGN7R7Q3JBtpuy7
	udgIHFfQ0uVadA5/kNSYz0/aPdUL+6+Ifi23LUzUzQVdHaOlXlBZ+rmE+nYXfj+8y6qVnE
	Q+9UDSnZ71QmV/Wr1BT4gHoUtFyr/p7aGDxR44m69bYu+SMGCcgA85SVBJToMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759939585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l2QJQuQC53R2PDYMQSGmMSwZa5exJe3Ich5J62UdjpI=;
	b=0WteRm893zl+y+qn3n40nLtLhnHmOqn7VA1hIO69DMQwvNkRp9JyJTOC3/d8vTfBlv3vb5
	45E+/9zHHTxN+tCA==
To: Petr Mladek <pmladek@suse.com>, Andrew Murray
 <amurray@thegoodpenguin.co.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] printk: console_flush_one_record() code cleanup
In-Reply-To: <aN_3id2CF7ivC42R@pathway.suse.cz>
References: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
 <20250927-printk_legacy_thread_console_lock-v2-2-cff9f063071a@thegoodpenguin.co.uk>
 <84o6qsjduw.fsf@jogness.linutronix.de>
 <CALqELGwd1CiRAYNBVWsrgb5T3eJ9ugP+0wG2WKZGvSfowqgaaQ@mail.gmail.com>
 <84seg3gd89.fsf@jogness.linutronix.de>
 <CALqELGw8wtbbihLsOcNgnV2vGoSR7kD8_tHmt7ESY4d3buwrLQ@mail.gmail.com>
 <aN5Pp2cFf_pedhxe@pathway.suse.cz> <aN_3id2CF7ivC42R@pathway.suse.cz>
Date: Wed, 08 Oct 2025 18:12:25 +0206
Message-ID: <847bx5peda.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-10-03, Petr Mladek <pmladek@suse.com> wrote:
> From 30f5302b11962f8ec961ca85419ed097a5b76502 Mon Sep 17 00:00:00 2001
> From: Petr Mladek <pmladek@suse.com>
> Date: Sat, 27 Sep 2025 23:05:36 +0100
> Subject: [PATCH 2/3] printk: console_flush_one_record() code cleanup
>
> console_flush_one_record() and console_flush_all() duplicate several
> checks. They both want to tell the caller that consoles are not
> longer usable in this context because it has lost the lock or
> the lock has to be reserved for the panic CPU.
>
> Remove the duplication by changing the semantic of the function
> console_flush_one_record() return value and parameters.
>
> The function will return true when it is able to do the job. It means
> that there is at least one usable console. And the flushing was
> not interrupted by a takeover or panic_on_other_cpu().
>
> Also replace the @any_usable parameter with @try_again. The @try_again
> parameter will be set to true when the function could do the job
> and at least one console made a progress.
>
> Motivation:
>
> The callers need to know when
>
>   + they should continue flushing => @try_again
>   + when the console is flushed => can_do_the_job(return) && !@try_again
>   + when @next_seq is valid => same as flushed
>   + when lost console_lock => @takeover
>
> The proposed change makes it clear when the function can do
> the job. It simplifies the answer for the other questions.
>
> Also the return value from console_flush_one_record() can
> be used as return value from console_flush_all().
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

