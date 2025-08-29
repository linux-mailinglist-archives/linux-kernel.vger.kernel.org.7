Return-Path: <linux-kernel+bounces-791879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 620FBB3BD3B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9F2E7A3E89
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D23F31E0F0;
	Fri, 29 Aug 2025 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B/GNABan";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qwMSUN/7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0883B2627F9
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756476752; cv=none; b=N8aUIU8rLJlk5J/9BfJFghkY7OqoCJ8fIF0lDU/BkdoNtSgJ/NnhOZZomArOrXuLTMYCcjd+bcTB0mbyUt1M44ED5yPu0WO3Xu0NmLkq9D6QsHnnEyQFV+w+YwVexKYIGATjAIx04FrQTdNQ+4Rzy7on6dwkSgjhIWr+5B3IMwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756476752; c=relaxed/simple;
	bh=KFek2OnQS2bD6qaX+JDonT6zV4n2NnguZH314YGPtPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uBz8B1g10FknPGux7GSeMQ/G9SJoMmCxrL98F8JCXhcLklkFDZTPgzzPBidFcVB3HORC133dzTSMUnNL6X5B7zz+27HsXyvO8QXEKPPu9mdkYNweCUwJoKIze/5XSRrMBySvJreYoakQvZ3RWtH/vp0NTc17n0zl6Ex7efAQ2nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B/GNABan; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qwMSUN/7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756476749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LQnz+vrS9Wnn35wJiQxDvUxQEOtZwuQ9bHN8SozSAqM=;
	b=B/GNABanHeICru7VvdYWGEjYhfF8CAaJAJ/6sxByPEUiclWBJLvX8vSyp1lGdsx6GkKFoA
	2hLVYIt54hCC8hfDCr0lsXwxg31MNv+cdO8pXudlsXfGeBrb/x54xy3FZ5KlCgXWyta7Z4
	UacL/aqnDiZEwEBX3MCH3kkJnWRRZUsHonsYkjuqLr1ZZ3BkVVu6WGoYH2dqWhlaTht0kg
	R066inH2FwzZcuMuXjL6Ny6V/oAv58Tv6imOn3uoE2OYAMkabMK9nw3SaWzr6iVEDl0JF7
	JiqiWI8epJIhEhpKwUw7Lg0Ho/vacYE9YT1UmoWDcho/x67f3fsN1oqvs+01lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756476749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LQnz+vrS9Wnn35wJiQxDvUxQEOtZwuQ9bHN8SozSAqM=;
	b=qwMSUN/7sbTNlPTYFgR0c0m3xsI7jUJ6qZRorNy370/KCHsI0smxbsPg/Ps9pHo0RDDHpy
	+iXQvdb0uLJb2QBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>, Daniel Thompson
 <daniel@riscstar.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v2 3/3] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
In-Reply-To: <aLGoBDapczoLH9-Y@pathway.suse.cz>
References: <20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com>
 <20250811-nbcon-kgdboc-v2-3-c7c72bcdeaf6@suse.com>
 <aJoAYD_r7ygH9AdS@aspen.lan>
 <6035c35f72eb1ac8817396ca08aae71d097ca42c.camel@suse.com>
 <84h5xukti3.fsf@jogness.linutronix.de> <aLGoBDapczoLH9-Y@pathway.suse.cz>
Date: Fri, 29 Aug 2025 16:18:28 +0206
Message-ID: <84v7m6gqsz.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-08-29, Petr Mladek <pmladek@suse.com> wrote:
>      c) kdb_msg_write() also writes the message on all other consoles
> 	registered by printk. I guess that this is what John meant
> 	by mirroring.

Yes.

>> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
>> index 79d8c74378061..2c168eaf378ed 100644
>> --- a/kernel/printk/nbcon.c
>> +++ b/kernel/printk/nbcon.c
>> @@ -10,6 +10,7 @@
>>  #include <linux/export.h>
>>  #include <linux/init.h>
>>  #include <linux/irqflags.h>
>> +#include <linux/kgdb.h>
>>  #include <linux/kthread.h>
>>  #include <linux/minmax.h>
>>  #include <linux/percpu.h>
>> @@ -247,6 +248,8 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
>>  		 * Panic does not imply that the console is owned. However,
>>  		 * since all non-panic CPUs are stopped during panic(), it
>>  		 * is safer to have them avoid gaining console ownership.
>> +		 * The only exception is if kgdb is active, which may print
>> +		 * from multiple CPUs during a panic.
>>  		 *
>>  		 * If this acquire is a reacquire (and an unsafe takeover
>>  		 * has not previously occurred) then it is allowed to attempt
>> @@ -255,6 +258,7 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
>>  		 * interrupted by the panic CPU while printing.
>>  		 */
>>  		if (other_cpu_in_panic() &&
>> +		    atomic_read(&kgdb_active) == -1 &&
>
> This would likely work for most kgdb_printk() calls. But what about
> the one called from kgdb_panic()?

Nice catch.

> Alternative solution would be to allow it only for the CPU locked
> by kdb, something like:
>
> 		    READ_ONCE(kdb_printf_cpu) != raw_smp_processor_id() &&

Yes, I like this.

> Note that I used READ_ONCE() to guarantee an atomic read. The
> condition will fail only when we are inside a code locked by
> the kdb_printf_cpu().

Neither the READ_ONCE() nor any memory barriers are needed because the
only interesting case is when the CPU sees that it is the one stored in
@kdb_printf_cpu. In which case it was the one that did the storing and
the value is always correctly loaded.

>> [0] https://lore.kernel.org/lkml/20210803131301.5588-4-john.ogness@linutronix.de
>
> Sigh, I have already forgotten that we discussed this in the past.

After so many years, I do not think there is a printk scenario we have
not discussed. ;-)

John

