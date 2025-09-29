Return-Path: <linux-kernel+bounces-836332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF917BA95D2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C173B510A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B302F306B04;
	Mon, 29 Sep 2025 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XbOCTvXU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H0uHvPul"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262AA305070
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759153009; cv=none; b=O0iREqntzJ0ROhj7Z5/tzhFOu7kSLsyDSD0f2dg+84OmLBOKGjkokCiPMBektbq54znO6s4wjJluTUOC8BQuoGsOnhewV5YcKcGAzC/V5+C5THeBpcE0y56v2TeB6ezLfF/RJEoTTCx8yFN5hKpMPiJFwUvXvU+RMQCvl7z6ewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759153009; c=relaxed/simple;
	bh=vISEnDX/Utio3BgNwoadz8h0zOSAeBN3E0SKbL82Sy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dppbmyv8OeM382/E1fOukmVApxFrlIWfiR2+2DqDJZYWym53hpJeUf6zoLDI+Tc4/wFO8aZDpzu4Awe7b2NxjqTAEdxp1TmgvbKYF0nK7SkBsV1vm0nEQkAlaodIJCDkXnc8bKD7pRdt46AG7+2TrmMbsD1q0yYRRclmmvK0rkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XbOCTvXU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H0uHvPul; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759153005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HyMPd0xZBtDiQlFvkCXHcE2G+ZvXKkfpi3RYR9t70H0=;
	b=XbOCTvXUb5RIn1kjXT3A1ZXaTPInULj0aUZBGYnYJQJK6kb/ZCiy2fAXk52ej57ZEW1Tkw
	dElHuk7UmB9jFagvhNW46GmcAxHXX/ptTy5eVt5RCL/msQTP+y9OFfObjIoONLaHfop28H
	RxIln2mrVxZKfa+xR02rM9k+SLRx51U1z33ELP+7jA+nAwWgovi2ojC7RkBiWmpDDMYiDz
	+YOBa4y8gJt4/jGLFqVB5L3K90Y6GYcRkrIYiRe+pLm0HALLA7cSS4gfwNvYq1h7xlMWdN
	94bitViv7QgPp3l0qadaLAUDGNzxlxoU5vmrczbYygI+8+TE+GgWmHRvPSQpCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759153005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HyMPd0xZBtDiQlFvkCXHcE2G+ZvXKkfpi3RYR9t70H0=;
	b=H0uHvPulSnHLLv32IXk835dYaLyyoL7omv9O9vXZhZwG1UvDSVRoru95qbwlchDybM4t3I
	RGRyaAdEfPzs7IAA==
To: Petr Mladek <pmladek@suse.com>, Breno Leitao <leitao@debian.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Mike Galbraith <efault@gmx.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 0/1] Allow unsafe ->write_atomic() for panic
In-Reply-To: <aNp4-xslkeO-29BP@pathway.suse.cz>
References: <20250912121852.2666874-1-john.ogness@linutronix.de>
 <5hgyof3yowdw3v76ygz2oxkzv7vpz5kp62nx36gynmr646yrjs@ag4mvynlin4k>
 <844ispin6a.fsf@jogness.linutronix.de>
 <bqihuqqrfc4ayghycmtfjcowyflvbku4ledy7pwajryptlp2wg@hq6cctbmimi3>
 <aNp4-xslkeO-29BP@pathway.suse.cz>
Date: Mon, 29 Sep 2025 15:42:44 +0206
Message-ID: <84ldlxl6s3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-29, Petr Mladek <pmladek@suse.com> wrote:
> On Fri 2025-09-26 08:17:53, Breno Leitao wrote:
>> On Fri, Sep 26, 2025 at 11:27:49AM +0206, John Ogness wrote:
>> > On 2025-09-17, Breno Leitao <leitao@debian.org> wrote:
>> > > Upon further consideration, it's worth noting that not all network
>> > > drivers rely on irq-unsafe locks. In practice, only a subset of drivers
>> > > use them, while most network drivers I'm familiar with maintain IRQ-safe
>> > > TX paths.
>> > >
>> > > If we could determine the IRQ safety characteristics (IRQ-safe vs
>> > > IRQ-unsafe TX) during netconsole registration, this would enable more
>> > > optimized behavior: netconsole could register as CON_NBCON_ATOMIC_UNSAFE
>> > > only when the underlying network adapter uses IRQ-unsafe locks. For
>> > > adapters with IRQ-safe implementations, netconsole could safely utilize
>> > > the ->write_atomic path without restrictions.
>> > 
>> > This is good to read. But note that if CON_NBCON_ATOMIC_UNSAFE is not
>> > set, it is expected that ->write_atomic() will also function in NMI. So
>> > being IRQ-safe may not be enough.
>> 
>> What are the other requirements for ->write_atomic() so it could be
>> executed inside a NMI?
>
> Ideally, it should be synchronized only via the nbcon console context
> API and should not need any additional lock.
>
> Note that the nbcon console context should get synchronized with
> the normal device lock via some wrappers, for example, see
> uart_port_lock() in include/linux/serial_core.h.

I would also like to add that write_atomic() calls are synchronized
against "unsafe sections"[0] of write_thread() and write_atomic()

... EXCEPT ...

As a last resort during panic, nbcon will perform hostile
takeovers. This means write_atomic() can be called even though the
driver is in unsafe sections. So your write_atomic() could be called
when your write_thread() is in an unsafe section. However,
write_atomic() can detect this by looking at unsafe_takeover of struct
nbcon_write_context. If true, you know your write_thread() was in an
unsafe section and you might need to be more careful or avoid certain
actions.

John

[0] Code surround by nbcon_enter_unsafe()/nbcon_exit_unsafe().

