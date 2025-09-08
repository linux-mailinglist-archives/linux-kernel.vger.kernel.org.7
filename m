Return-Path: <linux-kernel+bounces-805741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDA4B48CE2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C143C4BC3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C8A2FB097;
	Mon,  8 Sep 2025 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aXIxN90A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jh7b8Llc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1453F2F7AD7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333352; cv=none; b=Q0a65iQuQwt8EnTErdEOfSIDrXFXjOFs2PH5JYIBjCCFPgmVsnHJ4U5DdPDsSu2NAA2Ln1+0aiyBqfGPXyt4HFTKKXasFjibGCYFjSjZy3N3C1q3TNqAog1lZdVMxqzDSipyp7wUV9A0leJvN0GItAtgQbJ2Ba/yhrrRf1bIMJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333352; c=relaxed/simple;
	bh=/t8BPTl4IpiRuzHRuKxJiZZJy0ABbfg4ll9mzhCdJaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eJIEV5AqUi9FCp0c9QJoN6qR5WSrg6s/S3s3n59MD2I+VQtqkcH6idBT624iWDxtemmabNU0AqMzRyEJjxwWIWTekKrTvKgoo1VzlZKGeM2dUNPH0PhoDgT6/YT342SIDNL2iqkiw+USeY5se9MHfyiJG0rdL0x6XhPKaPBWK1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aXIxN90A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jh7b8Llc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757333349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bj4RYa63yog+buQ1zCGr7JNawWTRp4botS1M7B2K2Vs=;
	b=aXIxN90AEh5CSoRHW5KSGj/MG67dqWG4pntFi+Z/cF2plG6ESffCsxgnu02x8qoAIwyFkn
	dkkffTGABDdPJCI8h/jwCcVfny5wD4Z627ivZG77g31eYQAQrDlk4cAX17WweBh/CwD0GL
	MBExR0oduVPOvCRaXg384PojFLfg/KSQAIn3dPq+pi2OiqU8c+beULBwKVhxKX547g8GMM
	50PSPtSYhTFppZB8aI98s/+VYUCqdKSLKIdPPeHBKEFADSQ+h9ZkBexpVbz2qLuPbWBuZW
	tFSqV5NexVIHeUqNrASk0waxyuDID/ap1bg7RyuawVs2mH+ooURhxg3UJ/84Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757333349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bj4RYa63yog+buQ1zCGr7JNawWTRp4botS1M7B2K2Vs=;
	b=jh7b8LlcPKO6AYUugZ+dkgQ+L4SdirJvM1JbuW2a+8IZhjr0K1aZ8undcW7tlcfnID+1tI
	BQ/AMS3J1RJD21DQ==
To: Petr Mladek <pmladek@suse.com>, Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson
 <danielt@kernel.org>, Douglas Anderson <dianders@chromium.org>,
 linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v3 2/4] printk: nbcon: Introduce KDB helpers
In-Reply-To: <aLsOBwV6CVBwG9JV@pathway.suse.cz>
References: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
 <20250902-nbcon-kgdboc-v3-2-cd30a8106f1c@suse.com>
 <aLsOBwV6CVBwG9JV@pathway.suse.cz>
Date: Mon, 08 Sep 2025 14:15:08 +0206
Message-ID: <84ikht87tn.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-05, Petr Mladek <pmladek@suse.com> wrote:
> On Tue 2025-09-02 15:33:53, Marcos Paulo de Souza wrote:
>> These helpers will be used when calling console->write_atomic on
>> KDB code in the next patch. It's basically the same implementaion
>> as nbcon_device_try_acquire, but using NBCON_PORIO_EMERGENCY when
>> acquiring the context.
>> 
>> For release we need to flush the console, since some messages could be
>> added before the context was acquired, as KDB emits the messages using
>> con->{write,write_atomic} instead of storing them on the ring buffer.
>
> I am a bit confused by the last paragraph. It is a very long sentence.
>
> Sigh, I wanted to propose a simple and clear alternative. But I ended
> in a rabbit hole and with a rather complex text:
>
> <proposal>
> The atomic flush in the release function is questionable. vkdb_printf()
> is primary called only when other CPUs are quiescent in kdb_main_loop()
> and do not call the classic printk(). But, for example, the
> write_atomic() callback might print debug messages. Or there is
> one kdb_printf() called in kgdb_panic() before other CPUs are
> quiescent. So the flush might be useful. Especially, when
> the kdb code fails to quiescent the CPUs and returns early.
>
> Let's keep it simple and just call __nbcon_atomic_flush_pending_con().
> It uses write_atomic() callback which is used by the locked kdb code
> anyway.
>
> The legacy loop (console_trylock()/console_unlock()) is not
> usable in kdb context.
>
> It might make sense to trigger the flush via the printk kthread.
> But it would not work in panic() where is the only known kdb_printf()
> called when other CPUs are not quiescent. So, it does not look
> worth it.
> </proposal>
>
> What do you think?
>
> My opinion:
>
> Honestly, I think that the flush is not much important because
> it will most offten have nothing to do.
>
> I am just not sure whether it is better to have it there
> or avoid it. It might be better to remove it after all.
> And just document the decision.

IMHO keeping the flush is fine. There are cases where there might be
something to print. And since a printing kthread will get no chance to
print as long as kdb is alive, we should have kdb flushing that
console.

Note that this is the only console that will actually see the new
messages immediately as all the other CPUs and quiesced. For this reason
we probably want to use __nbcon_atomic_flush_pending() to try to flush
_all_ the consoles.

As to the last paragraph of the commit message, I would keep it simple:

After release try to flush all consoles since there may be a backlog of
messages in the ringbuffer. The kthread console printers do not get a
chance to run while kdb is active.

John

