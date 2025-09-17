Return-Path: <linux-kernel+bounces-820713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98489B7E7AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 770BE7B6DA1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0695323417;
	Wed, 17 Sep 2025 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4qOjxg6y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IPLSbxpP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35A3233F2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113251; cv=none; b=jdQLJIyAqmwcZp4FNqZKJGLFtacMqMNHnI4eXbYm7xEk4qyOsIARuyd4m5x6P0ar942qQ4uBG1g5blqzm5cQGkWtX2NVaso3SJ8cnlw0duowtA9nGYB26G68DnHd2X1sOCNlTX6xZbmBdxI28OK9xwGro1VVMYsZHlNooNNPAdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113251; c=relaxed/simple;
	bh=WffBdoWpcz5PkzF8NZicaXUSgruJ1zcsmHD6nDlP4Fw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CmyL8Fxj3DLEs/Eymyd6O6VjGJU2rsrcIqLoN4+rVrG/S6IqCr1TjAek5xhjMfXU0WKZqe5MlrGA6zBXy8//KL0ug7xVkLDlJUpTS5pP+/uSVhfSbipkSUlnCefni8xFrwEpmddebeAWGg4BVzFRNcDXzG/l2gNcGc1ojPjISio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4qOjxg6y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IPLSbxpP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758113246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1DuNpjx2WI4QDN0equ+r1Kgbp0viQJM///xaQ5DpHfM=;
	b=4qOjxg6ybCilTD7GsMqd5OKQoSHa5fXDUR4rsxXWyKHrEEozUIIKeqyr+wMbLuP0gtmYL/
	2YROpCtx2ym2lp0ydekFWHLQNfd75uQt0nSVFeT/+UkKyKTNVWhnObT5VM7lyc94jciJR8
	+a3X4I1ohcxxj7LDB+cRNQTZV9JtfuJV5usMQdZgO7gzInm7UzyteKhwLz1xOncqRBl1Ah
	ADNKZqbzHtAGf5lauB5gynWNGb6Yv/SjUiqrf0XZuvgGWuziFrJ4fhAH1f+y0TVT2wPuaM
	zJTrJn9wA0J06Z7MQPCux2+vK5dTa3Cc8Spf9ZiFlmtdK33iafQFGVFkIq00JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758113246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1DuNpjx2WI4QDN0equ+r1Kgbp0viQJM///xaQ5DpHfM=;
	b=IPLSbxpPfgPdL8B/3mC5XaKGk8pZM3T9rOLu9vWanDtFbVSCR8S3xpLs7YBKC53U1tjsQB
	LoBwB2BZBwNxT3Cw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Breno Leitao <leitao@debian.org>, Mike Galbraith
 <efault@gmx.de>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 1/1] printk: nbcon: Allow unsafe
 write_atomic() for panic
In-Reply-To: <aMl8xX9QCM9jslLH@pathway.suse.cz>
References: <20250912121852.2666874-1-john.ogness@linutronix.de>
 <20250912121852.2666874-2-john.ogness@linutronix.de>
 <aMl8xX9QCM9jslLH@pathway.suse.cz>
Date: Wed, 17 Sep 2025 14:53:26 +0206
Message-ID: <848qidw8ip.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-16, Petr Mladek <pmladek@suse.com> wrote:
>> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
>> index 646801813415..8c2966b85ac3 100644
>> --- a/kernel/printk/nbcon.c
>> +++ b/kernel/printk/nbcon.c
>> @@ -972,14 +972,18 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
>>  	/*
>>  	 * This function should never be called for consoles that have not
>>  	 * implemented the necessary callback for writing: i.e. legacy
>> -	 * consoles and, when atomic, nbcon consoles with no write_atomic().
>> +	 * consoles and, when atomic, nbcon consoles with no write_atomic()
>> +	 * or an unsafe write_atomic() without allowing unsafe takeovers.
>>  	 * Handle it as if ownership was lost and try to continue.
>>  	 *
>>  	 * Note that for nbcon consoles the write_thread() callback is
>>  	 * mandatory and was already checked in nbcon_alloc().
>>  	 */
>> -	if (WARN_ON_ONCE((use_atomic && !con->write_atomic) ||
>> -			 !(console_srcu_read_flags(con) & CON_NBCON))) {
>> +	if (WARN_ON_ONCE(!(console_srcu_read_flags(con) & CON_NBCON) ||
>> +			 (use_atomic &&
>> +			  (!con->write_atomic ||
>> +			   (!ctxt->allow_unsafe_takeover &&
>> +			    (console_srcu_read_flags(con) & CON_NBCON_ATOMIC_UNSAFE)))))) {
>
> The condition seems to be correct. But it is evil. I wonder whether
> it would make sense to replace this with:
>
> 	flags = console_srcu_read_flags(con);
>
> 	if (WARN_ON_ONCE(!(flags & CON_NBCON) ||
> 			 !console_is_usable(con, flags, use_atomic, ctxt->allow_unsafe_takeover))) {
>
>
> Note that I have added the 4th parameter intentionally, see below.

...

> It would be more reliable when the check was integrated into
> console_is_usable(). I guess that you did not do it because
> it added another parameter...

Not all console_is_usable() call sites have a printing context. That is
why I only added the checks only to the actual ->write_atomic() paths
that were possible via nbcon_atomic_flush_unsafe().

> Or maybe, we could define @allow_unsafe_takeover via a global variable,
> e.g. panic_nbcon_allow_unsafe_takeover. And it might be valid
> only on the panic CPU, e.g.
>
> static inline
> bool nbcon_allow_unsafe_takeover(void)
> {
> 	return panic_on_this_cpu() && panic_nbcon_allow_unsafe_takeover;
> }
>
> It is a kind of hack. But it might be better than the 4th parameter.
> And it would simplify few other APIs.

After weighing the pros/cons I think that a global variable makes the
most sense. It will simplify internal APIs and provide all
console_is_usable() users a correct value. And the end result is no
different than what we do now.

We could also keep its setting inside nbcon_atomic_flush_unsafe() so
that the variable remains a printk-internal variable.

John

