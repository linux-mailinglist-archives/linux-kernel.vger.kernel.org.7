Return-Path: <linux-kernel+bounces-752232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5A4B172C9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410575874BD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD9D2D1F64;
	Thu, 31 Jul 2025 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XR/CQQqI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jWUiEbiO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A567677104
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970586; cv=none; b=fWk8H0aOWVUH/0UnwZoNBP9dDDhb0FMQe7ccgUWO5xc9XEYjlPhlqALJypfTAlCvOc0JZUbhwZhv2W8+QhmPCzBQu6oHcI2nkf1dgixuPK+khtuANNwX0D8A+NGVfnQ43GJgwN3/JcnBkRlCYzG7C/y0IFnDm6vb5Rigekg7gRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970586; c=relaxed/simple;
	bh=0oh8wo7xVTT76cmvuEvmodoOVeXkQ2vO9iJXyx4T76k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hJ1mvBpDRjVRb27hEBauaRIAqptWyFWZOo7zUhMVUhhgRS4V6hbT5MWQx1qZSRG1XQEPx49N+eIMi/htv35ncx3Nfgm66PmwKCAyqPn8FY+hUGLuwL4QsGAMsgYCDGlEBXQZPa01CMwRI2nHeiPnak24VFyEx8ZSiggR2BYuTpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XR/CQQqI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jWUiEbiO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753970582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/jUB7+mqJ6vOu9bYPCfa2+TuZR2QobbeGi99NqhPw0=;
	b=XR/CQQqIxkjhty4gyYn0+QF9INSWICBtL2FypdYnrwc4hg2mR4T9S+zZ2RpJGGtJt7Ft+B
	sKLh8ShWlR3Jvf24Cps5Pq46OPAA/VHZlQfU7ggBUIrpGBRzVtl1Njq9NQ8rSgDTBt+OR7
	n4LQJCSzIfAEK1CiQ6mS8waHwJcuGsrOVw3YoeAGu51bDB8Gwv19kcFdAYliNmHpFUmPS9
	NYoeReZdwFq1Xicy1srlPhNUl7q9KIj07FjoRlvb+folf54IJ2ABloMhov//8jQ//kQ5yt
	mTCzCRgepYusHQRG4xj9FgVK2LX0hRHEPO3BkW/pmLwUfYoMzM8IAdVQCzeS2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753970582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y/jUB7+mqJ6vOu9bYPCfa2+TuZR2QobbeGi99NqhPw0=;
	b=jWUiEbiOLeOjbqF1VT1CubB8dEPFjkaZ1Lx4rkLHzDxAoyhUrhkiOwsAdjM3hLCBAjM/8u
	k1YesinPBnEyc7CQ==
To: Oliver Sang <oliver.sang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org,
 ltp@lists.linux.it, oliver.sang@intel.com
Subject: Re: [tip:locking/futex] [futex]  56180dd20c:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/nsproxy.c
In-Reply-To: <87cy9gilo8.ffs@tglx>
References: <202507231021.dcf24373-lkp@intel.com> <87a54usty4.ffs@tglx>
 <aINKAQt3qcj2s38N@xsang-OptiPlex-9020> <87seikp94v.ffs@tglx>
 <aIgUUhKWesDpM0BJ@xsang-OptiPlex-9020> <87wm7ro3r7.ffs@tglx>
 <aIrJipeLsGUM92+R@xsang-OptiPlex-9020> <87cy9gilo8.ffs@tglx>
Date: Thu, 31 Jul 2025 16:03:01 +0200
Message-ID: <874iusihka.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 31 2025 at 14:34, Thomas Gleixner wrote:
> On Thu, Jul 31 2025 at 09:40, Oliver Sang wrote:
>> On Tue, Jul 29, 2025 at 09:27:56AM +0200, Thomas Gleixner wrote:
>>> > but bot seems not be able to capture other new dmesg stats.
>>> 
>>> Ah. The tracer does not dump on warnings by default. You need
>>> 'panic_on_warn' on the command line as well. Forgot about that earlier.
>>
>> attached one dmesg FYI.
>
> Hmm, that trace dump was cut off before it completed by a reset
> (probably your test timeout).
>
> Either you make the timeout longer or try the following on the kernel
> command line instead of 'ftrace_dump_on_cpu':

  instead of 'ftrace_dump_ooops'

obviously

