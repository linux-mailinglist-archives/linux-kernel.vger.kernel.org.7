Return-Path: <linux-kernel+bounces-745979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A763FB12124
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56321CC5330
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2278C170826;
	Fri, 25 Jul 2025 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nWi+22jj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2wlev3Mb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F162EE987
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458308; cv=none; b=nPbfxQ2bTzg9vYvZk1Og5JEzB10HXOlgSBzOroij9gGaSt8OqCKJketfksORktiD6w6L3WnV/17f9GlYf9YL6zoZZ1js+GJVyo53QEbeIdvIx/gG5/XPcq505BI9VcTDkvwrQuYuh8mdZtUo8HLHaOLTB7sG45ZCWgv6TGEfNjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458308; c=relaxed/simple;
	bh=ENJE94gAKBn4rYfbHDvsOYQ2vda2+iFCm68UABQzqmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W09LtKIeRiJLwnRsiD/im+vUEkHn8kgv2an0T3Mh/5NdXCjwc7wJpIi90dtoITv2cqax8tCGyWRwolwidWPB2oP0kVrV1bBPF3d2DDm8CkhVPyoQLDfMryQ4brVeUyIUzknQ+THVmA/ruM/iaJvSpZpKAdFRa8G0I5FsfxMULeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nWi+22jj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2wlev3Mb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753458305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zfNlU9QkQSDk6X3acZW9Zv6watdmS4XLb2lpyLgX3PU=;
	b=nWi+22jj/D7vpJ3jHZNLznk1KJL9waj+gQWBvee9c3DCDjBGRQxnd34ePojIYdP6v+eVKG
	yG5tj6U0W7XvzcafeahhiJ7DsZKZL6kJKmzMVL+Ks4v2x2urTkyCLbR1OnkDjrqoOl6sj+
	VnOF6P3Ga+8BpoAwTI8VywKIdWY0K+7xbhld/p0uekv7pnRBIEx6fFFyji+bMunGgJuuVR
	URcoNjbaLEWjMDmaTrtJMO4834tjUkaAgIjqQOLkccuir0WvwA/yq2VibB7phjMZHWuSQX
	g2prDMKR6GuQEP0js+MSZVdBI+cCC7zeSkfA3PhRO2hIPyB1B09Vv+ZLZ/v7ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753458305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zfNlU9QkQSDk6X3acZW9Zv6watdmS4XLb2lpyLgX3PU=;
	b=2wlev3Mb1+z/3Pnnum1fsrCZ/wKE+6fI5t7UzhlvwaPmKxn6SEQEbGzJg3YvvNkBEQ1RKj
	qNo7Fzzu1wV4ZADg==
To: Oliver Sang <oliver.sang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org,
 ltp@lists.linux.it, oliver.sang@intel.com
Subject: Re: [tip:locking/futex] [futex]  56180dd20c:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/nsproxy.c
In-Reply-To: <aINKAQt3qcj2s38N@xsang-OptiPlex-9020>
References: <202507231021.dcf24373-lkp@intel.com> <87a54usty4.ffs@tglx>
 <aINKAQt3qcj2s38N@xsang-OptiPlex-9020>
Date: Fri, 25 Jul 2025 17:45:04 +0200
Message-ID: <87seikp94v.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oliver!

On Fri, Jul 25 2025 at 17:10, Oliver Sang wrote:
> On Wed, Jul 23, 2025 at 07:22:43PM +0200, Thomas Gleixner wrote:
>> > [  286.673775][   C97] BUG: sleeping function called from invalid context at kernel/nsproxy.c:233   <---- (1)
>> > [  286.673784][   C97] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6748, name: oom03
>> > [  286.673787][   C97] preempt_count: 7ffffffe, expected: 0
>> 
>> Ooops. That's a corrupted preempt counter, which has underflown twice.
>> 
>> Can you please enable CONFIG_DEBUG_PREEMPT, so we can see where this
>> happens?
>
> after enable CONFIG_DEBUG_PREEMPT, the config is as attached
> config-6.16.0-rc5-00002-g56180dd20c19

Thank you for trying, but I just realized that it tells us only when it
underflows, but we don't see where the actual extra decrement happens
before that.

Can you please enable CONFIG_PREEMPT_TRACER and add

'trace_event=preemptirq:preempt_disable,preemptirq:preempt_enable ftrace_dump_on_oops'

to the kernel command line. The latter will dump the recorded
preempt_enable/disable events and we can pinpoint the function which is
responsible for that.

Thanks,

        tglx



