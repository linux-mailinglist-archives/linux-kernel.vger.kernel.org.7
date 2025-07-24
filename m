Return-Path: <linux-kernel+bounces-744012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67150B106E3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2990A7A3F74
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB0D252917;
	Thu, 24 Jul 2025 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EnuBEIBt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ZcUlrKE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5295825392C;
	Thu, 24 Jul 2025 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350488; cv=none; b=auA9FEC8DDHcOOvUvqhSPl0oyPP4cmleuH381iP3fhrlppeIQFq4+D5QBEXRk/vHKl0cgv22dhrPgKalwSqya4KyIqxP1fjgpRIHohoABiRjEvLhh50LqpauoEUQZiXSUxKYDx9msRVP1ga/U1gzoAkjLyU3SQJI1FLsNgR1X0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350488; c=relaxed/simple;
	bh=/1tWzqL7UxMp1H+AfaF6+XpjaUZmflmMx1fjd44oxGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F5OxV+Cf7LYemHUHi1JVaJiDim+/FWd8H+4BNEJ12yP699q5wBuAJdmH+a8PUxGXKshK+u6XyzzckhaPO+etLU4wwLWGXd1pYke/4JuMcGuYuADRQUkFT7fdQkufgc51gIOjmiN0r3MaQmSmQRuahSWHA80bEaAxdHS7Z2uZPp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EnuBEIBt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4ZcUlrKE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753350484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ajMk0Gfoce2q99uKJCUvLtkGhsdcJhVATHmyd91KLBY=;
	b=EnuBEIBtbTVMESbdrMdzJgS+0EBGAw9EWJDPShNlGPe0+pbhzz+83m3w4pgBmd9FtzYW4r
	cjvDKRTF/Fz2wnmKotqCeCKnNVXp97um6ZwVZSwgD05r3/24gkGQ3XDdVQq58QKj7Zjr+u
	J6bi7YQEVbNHb9+ftpTY8/FpzNOdE9DAKuRkLyk3CbofdeivdSbLnIyLULrr3SH/GcR4XE
	vhBcjeVMaLU91HwcYerOvxwH2g8Y8p74kNTbI9RXIm8TukwbmL9TG4VPt7pm3Q8Y5Je95T
	/XjsWF6nxL7zJfDFwFUOq1fHxEIiHYGzsH8VIG/v9o82vqTthyQk/t7Mm4cg4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753350484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ajMk0Gfoce2q99uKJCUvLtkGhsdcJhVATHmyd91KLBY=;
	b=4ZcUlrKEypgBxE3J2UYXZN76IFEv2nz50YtzGhfuGPtJVr5gVUh1U9JUf6OzOdsNknd+i3
	Bpq9gl+GG555c2Bg==
To: Jiri Slaby <jirislaby@kernel.org>, Wladislav Wiebe
 <wladislav.wiebe@nokia.com>, corbet@lwn.net, jirislaby@kernel.org
Cc: akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, bp@alien8.de, arnd@arndb.de,
 fvdl@google.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: Re: [PATCH v3] genirq: add support for warning on long-running IRQ
 handlers
In-Reply-To: <aeeb783d-d921-450c-885d-c8e8b328f81b@kernel.org>
References: <20250723182836.1177-1-wladislav.wiebe@nokia.com>
 <aeeb783d-d921-450c-885d-c8e8b328f81b@kernel.org>
Date: Thu, 24 Jul 2025 11:47:38 +0200
Message-ID: <87ldodrkcl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 24 2025 at 07:18, Jiri Slaby wrote:

> On 23. 07. 25, 20:28, Wladislav Wiebe wrote:
>> Introduce a mechanism to detect and warn about prolonged IRQ handlers.
>> With a new command-line parameter (irqhandler.duration_warn_us=),
>> users can configure the duration threshold in microseconds when a warning
>> in such format should be emitted:
>> 
>> "[CPU14] long duration of IRQ[159:bad_irq_handler [long_irq]], took: 1330 us"
>> 
>> The implementation uses local_clock() to measure the execution duration of the
>> generic IRQ per-CPU event handler.
> ...> +static inline void irqhandler_duration_check(u64 ts_start, 
> unsigned int irq,
>> +					     const struct irqaction *action)
>> +{
>> +	/* Approx. conversion to microseconds */
>> +	u64 delta_us = (local_clock() - ts_start) >> 10;
>
> Is this a microoptimization -- have you measured what speedup does it 
> bring? IOW is it worth it instead of cleaner "/ NSEC_PER_USEC"?

A 64-bit division is definitely more expensive than a shift operation
and on 32-bit w/o a 64-bit divide instruction it's more than horribly
slow.

> Or instead, you could store the diff in irqhandler_duration_threshold_ns 
> (mind that "_ns") and avoid the shift and div completely.

That's the right thing to do. The setup code can do a *1000 and be done.

> And what about the wrap? Don't you need abs_diff()?

~500 years after boot :)

Thanks,

        tglx

