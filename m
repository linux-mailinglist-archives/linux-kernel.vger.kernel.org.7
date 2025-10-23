Return-Path: <linux-kernel+bounces-867179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CE2C01C26
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C13D503AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D11432B9B6;
	Thu, 23 Oct 2025 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ERCc67/U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ggQclIAJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F4532B996
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229620; cv=none; b=h16+PEhpjGjXQfEK7iUDPqY4nRK3cg2KoK9Y/xnzIALLUMpdIVj2OrcvuKX6Px4uZO+TFSJVSkrA2VAbnQ7qNt+Q8czRKGmUI+w/2JIV0YGVhbIkJVWzrCboaRkhmctZ0P+sONrX7Oy1oidJXSx8jiYfTQItQrq0hG2b7Fw69mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229620; c=relaxed/simple;
	bh=1ytfs+c7ZOZMRI59+AnnslCK4WTAOg3vupCUTljN+d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZPaEBtgxHZ+t2GV0iIWkC66mi9eK1aY+d/NQEDcnqhGtL6Z9viWemBC0XiHwCaP1dfjPOHOKz/Ek86I4HHYNmzc7idldXbWQfm7RcvYF4uTUsufC63UBt4en6HoUoOm4sixGsJm9Ch6YO7E5RpNM3PmrVhrhSJqxXWGs8lTDGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ERCc67/U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ggQclIAJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 23 Oct 2025 16:26:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761229616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M20dvO8zVexDWgxLdZYk6n0OJ90mI0jyl6AP5arVLwQ=;
	b=ERCc67/U25spV4pQWWa0n9F0NImRzNGrxvMHQpH90e3JIZFcBakvCUjLrHJklg426uFI7u
	ta/M1dw/myG9zys70sQEWCvBfmophuacjRbyrh6GvSddixeBpmq7nNexQhSiC9CpBnerPY
	KPjo5AGdpOrbwlAFM5w1E+bTYV8pmohTEulSZT4s5cjZbSF46xcfZOm/7jYPszaWJcbX4j
	p8PH7zH7IIQdXbuNIKjkljbN9C2urfc4eiBJEix3/5x5rOctPojKhDoDcnYcNYyQJFQRIz
	J9ivJl01/mpG7g1NBlnRDEAZcSNOc9b3b2YKsbm/6GzsjfqXrN4SwcCJpccc4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761229616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M20dvO8zVexDWgxLdZYk6n0OJ90mI0jyl6AP5arVLwQ=;
	b=ggQclIAJysww8s8NWSJ7j/LIBzCTsUOyGgVvw7MD58mnF/P2zes7rH5l24xM81Gojj8uMG
	+K+bsMUQ9HOBG4AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oleg Nesterov <oleg@redhat.com>, Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Message-ID: <20251023142655.FvZkeSa-@linutronix.de>
References: <20251022154115.GA22400@redhat.com>
 <20251023103234.GA27415@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251023103234.GA27415@redhat.com>

On 2025-10-23 12:32:34 [+0200], Oleg Nesterov wrote:
> printk_legacy_map is used on !PREEMPT_RT to avoid false positives from
> CONFIG_PROVE_RAW_LOCK_NESTING about raw_spinlock/spinlock nesting.

Could we please get rid of CONFIG_PROVE_RAW_LOCK_NESTING here? This is
lockdep internal implementation and has nothing to do with printk or
anything. The nesting is documented in
	Documentation/locking/locktypes.rst

and this counts regardless of PREEMPT_RT. The only reason why this is
still around is that non-RT architectures tend to do it wrong (sparc)
and I didn't get around to fix it all. And people started to give me
lockdep splats and after some time I gave up and it is enforced only on
RT architectures.


  printk_legacy_map is using the wrong override type. LD_WAIT_SLEEP is for
  always sleeping lock types like mutex_t. LD_WAIT_CONFIG is for sleeping
  on PREEMPT_RT lock types like spinlock_t.

> However, LD_WAIT_SLEEP is not exactly right; it fools lockdep as if it
> is fine to acquire a sleeping lock.
> 
> Change DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map) to use LD_WAIT_CONFIG.
> 
> Also, update the comment to make it more clear as suggested by Petr.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 5aee9ffb16b9..80f0bedf5cb7 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3003,11 +3003,12 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>  
>  /*
>   * Legacy console printing from printk() caller context does not respect
> - * raw_spinlock/spinlock nesting. For !PREEMPT_RT the lockdep warning is a
> - * false positive. For PREEMPT_RT the false positive condition does not
> - * occur.
> + * raw_spinlock/spinlock nesting. However, on PREEMPT_RT the printing
> + * path from atomic context is always avoided and the console driver
> + * is always invoked from a dedicated thread. Thus the lockdep splat
> + * on !PREEMPT_RT is a false positive.

  The legacy console always acquires a spinlock_t from its printing
  callback. This violates lock nesting if the caller acquired a
  raw_spinlock_t while invoking printk(). This is not a problem on
  PREEMPT_RT because legacy consoles print always from a dedicated thread
  and never from within printk(). Therefore we tell lockdep that a
  spinlock_t is okay here.

> - * This map is used to temporarily establish LD_WAIT_SLEEP context for the
> + * This map is used to temporarily establish LD_WAIT_CONFIG context for the
>   * console write() callback when legacy printing to avoid false positive
>   * lockdep complaints, thus allowing lockdep to continue to function for
>   * real issues.
> @@ -3016,7 +3017,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>  static inline void printk_legacy_allow_spinlock_enter(void) { }
>  static inline void printk_legacy_allow_spinlock_exit(void) { }
>  #else
> -static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_SLEEP);
> +static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_CONFIG);

We could use this lock_map_acquire_try() directly but okay having it in
one spot with a comment might have its benefit. But _why_ is here a
CONFIG_PREEMPT_RT? This is supposed to work in both cases. Should a
legacy driver be invoked on RT then the comment is not accurate, lockdep
won't yell but we still have CONFIG_DEBUG_ATOMIC_SLEEP making its own
judgement.

>  static inline void printk_legacy_allow_spinlock_enter(void)
>  {

Sebastian

