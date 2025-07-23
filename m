Return-Path: <linux-kernel+bounces-742973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2E7B0F8F9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3701CC3984
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B62215793;
	Wed, 23 Jul 2025 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uTwfdT4g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0zsDEKsn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CDF212FB6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291368; cv=none; b=ohPqqj9egEbyyd+jxXVgBiEaITIEANHZglAJ0ffoUTxeI8ei2V6n3XY5bgYMhY108d6Oe+O8RS1K+3AH+G45x8jD5s2Z4j5uLJttB6eEc9OzUTCoF2be2IKrnCpJaDeNwEsUpRTHndvLL5fSMYZ7HUfbKgna2/GlN6AN6MN3pZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291368; c=relaxed/simple;
	bh=od2amenXWPTjxH486JTwg+nJ9AIZfcr87f7kpaRWZaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IkSXPXLSihJPZPN6ZR3dk+BpY25uoSfIsM1jnIXGGdnURnOqpFdGE/qqXQJhyUeBdEMg+M7vQwws6KiiUPggSgh6fONUwLD7NxyB9QTTp67hwi3Y2emEJF4GJGPmnepFCjLYhg073XfsBCz7fxGQ0FtsNZFCxVvtY+4rjbBSScU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uTwfdT4g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0zsDEKsn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753291364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HWMo6N7DknydD/H3u9J3QQxi5mYUqnkI0qT9deB89w8=;
	b=uTwfdT4gS3CIP1z3mkGpl4P8Gf92GQXuhhmIYlvD1xVncO7izDn+jAV4Apa0RGHBKEJKR4
	vhowu68fJPYIp78+Vl8EvbWe95N/5nHlgLx62Z20l5+2NyF+v0SLrMY5MWzNiKsvI7NZyI
	93GZKTT6hHfJWxZE7VeUDnSP6Dk6hCxJhLSzMWi3yqnL74T7qBAuZj8v6BLTeCKLEUIrAw
	YUvxUS+9IkzVfPI+qFCWKMSLDi22FmmBoVzvvjdF68hCXdxT0xWDqx3RzOfvXENFQknH0S
	oHkK0dkui1r/6esISb5CKAKDKdfR52DLcAnvjsfkBTL6j+gmCX5Q9bZS1+ebCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753291364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HWMo6N7DknydD/H3u9J3QQxi5mYUqnkI0qT9deB89w8=;
	b=0zsDEKsnDDRc17JusZ6oZ+IxZboqKL/mREeqzblTxb3++XoS5iND//bsgxkB0oMKgADZDg
	YbYlqM7vHU9zaLBg==
To: kernel test robot <oliver.sang@intel.com>, Peter Zijlstra
 <peterz@infradead.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-mm@kvack.org, ltp@lists.linux.it, oliver.sang@intel.com
Subject: Re: [tip:locking/futex] [futex]  56180dd20c:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/nsproxy.c
In-Reply-To: <202507231021.dcf24373-lkp@intel.com>
References: <202507231021.dcf24373-lkp@intel.com>
Date: Wed, 23 Jul 2025 19:22:43 +0200
Message-ID: <87a54usty4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 23 2025 at 16:46, kernel test robot wrote:
> kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_kernel/nsproxy.c" on:
>
> commit: 56180dd20c19e5b0fa34822997a9ac66b517e7b3 ("futex: Use RCU-based per-CPU reference counting instead of rcuref_t")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git locking/futex
>
> the issue (1)(2) happen randomly upon 56180dd20c.

Hmm.

> a255b78d14324f8a 56180dd20c19e5b0fa34822997a
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :50          48%          24:50    dmesg.BUG:scheduling_while_atomic    <---- (2)
>            :50          48%          24:50    dmesg.BUG:sleeping_function_called_from_invalid_context_at_kernel/nsproxy.c   <---- (1)
>          50:50           0%          50:50    dmesg.Mem-Info
>          50:50           0%          50:50    dmesg.invoked_oom-killer:gfp_mask=0x
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202507231021.dcf24373-lkp@intel.com
>
>
> [  286.673775][   C97] BUG: sleeping function called from invalid context at kernel/nsproxy.c:233   <---- (1)
> [  286.673784][   C97] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6748, name: oom03
> [  286.673787][   C97] preempt_count: 7ffffffe, expected: 0

Ooops. That's a corrupted preempt counter, which has underflown twice.

Can you please enable CONFIG_DEBUG_PREEMPT, so we can see where this
happens?

Thanks,

        tglx

