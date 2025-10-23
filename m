Return-Path: <linux-kernel+bounces-866541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3661BC000C9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAFD54E3212
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8522D3043BE;
	Thu, 23 Oct 2025 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a3tAGKa0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="avQl5VNY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF9C2F619F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209923; cv=none; b=edTggcGVCMPXsK4Z2vYGeVAX4B9ZlDkx7U0JE9o9KOPmV1saSJpjjzGVAeMk30loo0Kg99PN7wiryqOmZaaKsmjOKBSMmhWj+JNfUicUsUVp7ymTl23mI6fqbWO22I+BcifL/gm9+DzDl0MphQ6lsSbBxA6xwn/aCtbFf6lGSYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209923; c=relaxed/simple;
	bh=s1V5NUgfcVoe2np5LYt6jSvq/1Ih04uV56UMxAqRFR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NSEQkwhOreexgrhROluvTUqEM5PwZLYu+UAV0Woaha4OmGNKR+/cd4fpARa7wfKOJt72AB0/yne7kcR2Epof5OT7qNs4Nnlmz568Ssm0W1y/tqkli2u5MiWD5B6GW4gArCCTY/QmUc6ZEXo+fHfKeRU3EEKv5zUOycXGUVZyYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a3tAGKa0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=avQl5VNY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761209919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QuwUZvHfyPsMgLdq4j63QT7s3TKZ7fMrWD55Nom5+gM=;
	b=a3tAGKa0Z4F917CSuuvlgY1jNnNIFFjZaF+o/JH9WAmJ3pYXB4tUV777idSITF5+4zUGWv
	qn+W95XYFSiEXYxgyN1s3YLmC3qGWL9edlvz1/3z4qENRrgLWEA+PkCoHod4lwbzBwIY6/
	UR+b2ZrZfS1nYYYrDJET4Hequ6KwC/c4l6CH3wTc9KmcedrnBpjJSXyUNKTA911gSzyahu
	6hS5lgw15LBaBZYF38utDLu93nnwdRf22s84pUtY9ESHbFn3h1z/I0jmDyExkEP+qooiuM
	Jm6vIQ9hOw2HHQ2G7uhWfirOcXdeZUGaC505Cx1g8WhyrwQdOIyw1JUAm7zicg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761209919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QuwUZvHfyPsMgLdq4j63QT7s3TKZ7fMrWD55Nom5+gM=;
	b=avQl5VNYr2nyDaHg9Uu2U+nC+LL1m58N27s0I3cP3pdbUX3ghJQo4fQ13ZvNdmEn249XuK
	8POyiEQNpMXb3xCw==
To: Petr Mladek <pmladek@suse.com>, Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
In-Reply-To: <aPneEnDQmHhpvRkG@pathway.suse.cz>
References: <20251022154115.GA22400@redhat.com>
 <aPneEnDQmHhpvRkG@pathway.suse.cz>
Date: Thu, 23 Oct 2025 11:04:38 +0206
Message-ID: <87a51ic7up.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-10-23, Petr Mladek <pmladek@suse.com> wrote:
>> printk_legacy_map is used on !PREEMPT_RT to avoid false positives from
>> CONFIG_PROVE_RAW_LOCK_NESTING about raw_spinlock/spinlock nesting.
>> 
>> However, LD_WAIT_SLEEP is not exactly right; it fools lockdep as if it
>> is fine to acquire a sleeping lock.
>> 
>> Change DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map) to use LD_WAIT_CONFIG.
>> 
>> (We can also make printk_legacy_allow_spinlock_enter/exit() depend on
>>  !PREEMPT_RT && CONFIG_PROVE_RAW_LOCK_NESTING)
>
> I do not have strong opinion about adding (&& CONFIG_PROVE_RAW_LOCK_NESTING).
> This dependency is already handled in LD_WAIT_CONFIG definition.

I prefer avoiding CONFIG_PROVE_RAW_LOCK_NESTING since it is not necessary.

>> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
>
> Anyway, the change makes sense to me. It seems that this better fits
> the purpose.
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> See a note below.
>
>> ---
>>  kernel/printk/printk.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 5aee9ffb16b9..f11b2f31999b 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -3007,7 +3007,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>>   * false positive. For PREEMPT_RT the false positive condition does not
>>   * occur.
>
> From the comment, it was not obvious to me why the condition does not
> occur for PREEMPT_RT. I had to check the commit message from the
> commit daeed1595b4ddf314b ("printk: Avoid false positive lockdep
> report for legacy printing").
>
> <paste>
>     However, on PREEMPT_RT the printing path from atomic context is
>     always avoided and the console driver is always invoked from a
>     dedicated thread. Thus the lockdep splat on !PREEMPT_RT is a
>     false positive.
>  </paste>
>
> This is much more clear. It might make sense to improve the comment,
> for example:
>
> <proposal>
> /*
>  * Legacy console printing from printk() caller context does not respect
>  * raw_spinlock/spinlock nesting. However, on PREEMPT_RT the printing
>  * path from atomic context is always avoided and the console driver
>  * is always invoked from a dedicated thread. Thus the lockdep splat
>  * on !PREEMPT_RT is a false positive.
>  *
>  * This map is used to temporarily establish LD_WAIT_CONFIG context for the
>  * console write() callback when legacy printing to avoid false positive
>  * lockdep complaints, thus allowing lockdep to continue to function for
>  * real issues.
>  */
> </proposal>

I am OK with this proposal.

> But it can be done in a separate patch...
>
>>   *
>> - * This map is used to temporarily establish LD_WAIT_SLEEP context for the
>> + * This map is used to temporarily establish LD_WAIT_CONFIG context for the
>>   * console write() callback when legacy printing to avoid false positive
>>   * lockdep complaints, thus allowing lockdep to continue to function for
>>   * real issues.
>> @@ -3016,7 +3016,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>>  static inline void printk_legacy_allow_spinlock_enter(void) { }
>>  static inline void printk_legacy_allow_spinlock_exit(void) { }
>>  #else
>> -static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_SLEEP);
>> +static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_CONFIG);
>>  
>>  static inline void printk_legacy_allow_spinlock_enter(void)
>>  {
>
> Best Regards,
> Petr
>
> PS: I would take this patch via the printk tree. But I am going to wait
>     for feedback from others (John, Sebastian, ...).

AFAICT LD_WAIT_CONFIG would be an improvement by allowing detection of
non-spinlock-sleeping.

Reviewed-by: John Ogness <john.ogness@linutronix.de>

I would like to see an official ACK from Sebastian as well.

