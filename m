Return-Path: <linux-kernel+bounces-833805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E5CBA31DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6FD1BC4E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44113270EDE;
	Fri, 26 Sep 2025 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Si9JjpEj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lFyR+/T2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D6A13FEE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878519; cv=none; b=VChB5atkRrs2WJShfEDtOFkNptjyZXlXGEGwCTmAMBq6QmfmxecRPm8YLQ23RznAIOdLoGpvgjjNsq6wOAIlD/i/yjz7KsKkc3xRqGLqriVi9O8wgrtMJ7FHJHn/x/NLiBv50iKVV1PbM8g/QwfJ1uzBLJFTD6TB3qiOzJ+7cAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878519; c=relaxed/simple;
	bh=1LVb6grkPy+4VBU2f0YUAkNRcxw1o6ScZHuqAz7kDJA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Twinnn9pstTR1V247wuZCy4wzez1KiGbta9vkNsBYqLrSQX131jIctEBVlPDH6NhlVLQIRVmPrrTbkXN+828FM+jBClZ7y+rMZ0CrE9ID1RaZT1hOLan9ZyK8fNfD/n/l+rOp75WTlUxxQabwNnRCVxw3Ysz4v/AF9ewxL0mNms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Si9JjpEj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lFyR+/T2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758878509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1LVb6grkPy+4VBU2f0YUAkNRcxw1o6ScZHuqAz7kDJA=;
	b=Si9JjpEjyDWqZ/XyoYyEqlahM7jluQqNluhjUkuqK8Qg4zjuv6TICVFoqiW07h+i9XQkkA
	R6+V7U/lKvfSC8uZJQy742t9K9RGyoJXCCI3X8bXjEwUkAlaV4GJ8H+dCwfVlUmkR+h1X/
	Dp6CsfqfWwTQDLr4LqnMU044Dl5U2shFXtsh4JsfhgVx4IJK10tda5zLnVSs/6r1x9nAYy
	fVW0fWX7KPSw9/ECEEdKIpNLI9zn6vB/obSYsX5AWALFFlUYCHyH50x6AHP25fjVy5jsQs
	qoqAwLIuqV5/nC2smznOK0R1upO1jW+go5QBCapER55QL8YQvnwbXAt0f26cyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758878509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1LVb6grkPy+4VBU2f0YUAkNRcxw1o6ScZHuqAz7kDJA=;
	b=lFyR+/T2cLtSisoEuc0mzs4KKfu3AovYwk48n9HiTNPn43FY3cjAGpp/eTBwpug+5GTlqh
	uBTzYZSjb8nRRqBw==
To: Breno Leitao <leitao@debian.org>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Mike
 Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 0/1] Allow unsafe ->write_atomic() for panic
In-Reply-To: <5hgyof3yowdw3v76ygz2oxkzv7vpz5kp62nx36gynmr646yrjs@ag4mvynlin4k>
References: <20250912121852.2666874-1-john.ogness@linutronix.de>
 <5hgyof3yowdw3v76ygz2oxkzv7vpz5kp62nx36gynmr646yrjs@ag4mvynlin4k>
Date: Fri, 26 Sep 2025 11:27:49 +0206
Message-ID: <844ispin6a.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Breno,

On 2025-09-17, Breno Leitao <leitao@debian.org> wrote:
> Upon further consideration, it's worth noting that not all network
> drivers rely on irq-unsafe locks. In practice, only a subset of drivers
> use them, while most network drivers I'm familiar with maintain IRQ-safe
> TX paths.
>
> If we could determine the IRQ safety characteristics (IRQ-safe vs
> IRQ-unsafe TX) during netconsole registration, this would enable more
> optimized behavior: netconsole could register as CON_NBCON_ATOMIC_UNSAFE
> only when the underlying network adapter uses IRQ-unsafe locks. For
> adapters with IRQ-safe implementations, netconsole could safely utilize
> the ->write_atomic path without restrictions.

This is good to read. But note that if CON_NBCON_ATOMIC_UNSAFE is not
set, it is expected that ->write_atomic() will also function in NMI. So
being IRQ-safe may not be enough.

John Ogness

