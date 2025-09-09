Return-Path: <linux-kernel+bounces-808434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C6DB4FFA8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462413BBCBF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C68C34F48C;
	Tue,  9 Sep 2025 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FEzTsEMB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MolD4iO/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD1834F47E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428730; cv=none; b=M60YJSkex0IA/qSKsN/O3wGfngAwF5V/7BQwoL0CXdbWjbIuRLzS8rQEEjXqHu7h2XLF+u8hLZOZRNhpJHWyGVsc0MjewRDAQfi+RcsVqMwiXAwwYBtNB2E6pmDxxq9vIb8FSj1q1D330gVmljjQGdpgqCbb+0rt0K++y+1hS4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428730; c=relaxed/simple;
	bh=KJkTBSSmyY2Nryj6hg25r4nV3vnGyFpstuiIU/yUm/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n473vlsjhR+yl5Qf0z4wSjl8rCLeDKulSxcZQFCvDRSd7ehvcDX/ndT6OSAK5x/+IeNS2+uE4F86OU3LSBMtOKoVte6aosBgu3UKofzuR+Z4OnVKC+25E4h8jBeO6BQ/pQBIu8WRIPE1xWss9Pgp7G19gY6YZ7ZPxRB2LpEdJkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FEzTsEMB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MolD4iO/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757428726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gua7LrpeR7bfs/7a6ZHZwdAWNdKrp1balt4Ii4jEoHk=;
	b=FEzTsEMBKXm1fbrbX+orrqrOGzM9ioIkjDlxsDbWjYdfTw7BjtnmJuNlH6TXpoVc2JLj6s
	eO8xBO9ysFDry9TydJAGijkYiKwnZPtuE3aieI7Y30IAn88aAmtIppBB2cmrJRoj3cRTBk
	el3p/v1xMeorYQ9WQ9yyDS+ngGfoqQJOebkIjYvc+jQ2Q5BSnHmByCBaUSZi5YxMOktlyx
	oe/FFPuLfAiflf8wdiS5oFlzykPNqgOaIEoYIxQyUarYTi60oYzDdDjLsRdpN9R1BjZR1t
	kkybf6UQ+kXiQjCkSgt4Y7xqcRQ2VVOUXb/nquz3XgoFNKAVyIfiTfgcH+EdFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757428726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gua7LrpeR7bfs/7a6ZHZwdAWNdKrp1balt4Ii4jEoHk=;
	b=MolD4iO/F/Lg+pMUeTUOs1CC3XuUTOR3ZwmM9BLPF5QKqUcuxjf2qptqh1IH6LvBxVcXqK
	gMY2EGfM+C3N8FBg==
To: Petr Mladek <pmladek@suse.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Jason Wessel
 <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v3 2/4] printk: nbcon: Introduce KDB helpers
In-Reply-To: <aMA34mPqHFC3v3Kf@pathway.suse.cz>
References: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
 <20250902-nbcon-kgdboc-v3-2-cd30a8106f1c@suse.com>
 <aLsOBwV6CVBwG9JV@pathway.suse.cz> <84ikht87tn.fsf@jogness.linutronix.de>
 <aMA34mPqHFC3v3Kf@pathway.suse.cz>
Date: Tue, 09 Sep 2025 16:44:45 +0206
Message-ID: <84ecsfk7wq.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-09, Petr Mladek <pmladek@suse.com> wrote:
>> > Honestly, I think that the flush is not much important because
>> > it will most offten have nothing to do.
>> >
>> > I am just not sure whether it is better to have it there
>> > or avoid it. It might be better to remove it after all.
>> > And just document the decision.
>> 
>> IMHO keeping the flush is fine. There are cases where there might be
>> something to print. And since a printing kthread will get no chance to
>> print as long as kdb is alive, we should have kdb flushing that
>> console.
>> 
>> Note that this is the only console that will actually see the new
>> messages immediately as all the other CPUs and quiesced.
>
> I do not understand this argument. IMHO, this new
> try_acquire()/release() API should primary flush only
> the console which was (b)locked by this API.
>
> It will be called in kdb_msg_write() which tries to write
> to all registered consoles. So the other nbcon consoles will
> get flushed when the try_acquire() succeeds on them. And the
> legacy conosles were never flushed.

Right. I oversaw that it acquires each of the nbcon's.

> I would prefer to keep __nbcon_atomic_flush_pending_con().
> I mean to flush only the console which was blocked.

Agreed.

>> After release try to flush all consoles since there may be a backlog of
>> messages in the ringbuffer. The kthread console printers do not get a
>> chance to run while kdb is active.
>
> I like this text.

OK, but then change it to talk only about the one console.

After release try to flush the console since there may be a backlog of
messages in the ringbuffer. The kthread console printers do not get a
chance to run while kdb is active.

John

