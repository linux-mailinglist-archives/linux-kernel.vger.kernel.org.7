Return-Path: <linux-kernel+bounces-756697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF5EB1B7E1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEBBA163567
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C332928F51B;
	Tue,  5 Aug 2025 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rGISkHgu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7wVexZJM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39692AF1D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754409726; cv=none; b=bX53qZ64f6bEVs3mrM+500XqTqK9Z9BHC0rSNv53i5ljD9s8IZso4teApAeJglVkF/643Lh8jve4XYW8YgiB6F21K/HGaOWTDesFm4zeb0Nl/yb+3Djkv2vskDXbSTUYbatWZ1GRnYRWBua3ldBpdbvH4gbjENbWCE4xZs0xhZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754409726; c=relaxed/simple;
	bh=USipV52d/rjF9/N0ZM0wGXgPda+r6s4p6q8HsSWdINM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oSBKhDgJjVl55MsZbtL7mFuZpgGAOJSPr3zZ8UpMUN2XBkFVr5+agjsKydvL926tWoOJZtIhm7agJLebvMeZ/ErqDzE1SgfZ8zz+Zn84c2xfHQkYity3LjgLoBEfBXaIQ2Lc00dvFE0wA8NisKur7oI5oagD2nPFbCumRY57oEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rGISkHgu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7wVexZJM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754409722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OjUpl3D+nV7PnfJSMgtaqQwj/p3x9pkClHwfr8sk4TI=;
	b=rGISkHgu9s++NgzmXFuwoVK9/yzAMoWkubWqGh4I/o80rTL5gp7OFUG18QYJAB2dBo1X7L
	qUYm8Obuocud+J3g+6NOGyxo3dmoXOD2ww/A6MumR795OZrdc9eM6vO5HO1xjAY+aS2LGR
	mhxy3JR8VhHGbCAV0hHEPc2rcrJxSotNduQitYqEn9d/Oh9lN8iHm8ht/HUaTBi2jL8cPX
	44ygeDLVgXpC7jCIjKrghPAJv/ysRyveG1AG5W95kIDleZgS0pYAz+7ARpRR7ITnejELao
	EPRuWoBk0RXFYvy0jNoIKcSJTxh+TOtihB9+7zjEpRzREDWKxsP1sTNPgCQZeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754409722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OjUpl3D+nV7PnfJSMgtaqQwj/p3x9pkClHwfr8sk4TI=;
	b=7wVexZJMBGwPmQNmpAnViqc/PI7DbPGle0gCKHBGNJ3zSqF5izB880PMhpVz5PUqZ7WCoJ
	Xpra8Wc9+yBGw8Bg==
To: zhongjinji@honor.com, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
 shakeel.butt@linux.dev, npache@redhat.com, linux-kernel@vger.kernel.org,
 mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
 dave@stgolabs.net, andrealmeid@igalia.com, liulu.liu@honor.com,
 feng.han@honor.com
Subject: Re: [[PATCH v2] 1/2] futex: Add check_robust_futex to verify
 process usage of robust_futex
In-Reply-To: <20250801153649.23244-1-zhongjinji@honor.com>
References: <20250801153649.23244-1-zhongjinji@honor.com>
Date: Tue, 05 Aug 2025 18:02:01 +0200
Message-ID: <87cy99g3k6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 01 2025 at 23:36, zhongjinji@honor.com wrote:

Please use foo() notation for functions in subject and change log.

> The check_robust_futex function is added to detect whether a process uses
> robust_futex.

Explain the problem first and do not start with what the patch is doing.

> According to the patch discussion
> (https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u),

Can you properly describe what you are trying to solve as part of the
change log? A link can be provided for further information, but not
instead of a proper explanation.

> executing the OOM reaper too early on processes using robust_futex may cause
> the lock holder to wait indefinitely.
>
> Therefore, this patch introduces check_robust_futex to identify such

# git grep 'This patch' Documentation/process/

See also:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

> +bool __check_robust_futex(struct task_struct *p)
> +{
> +	struct task_struct *t;
> +
> +	for_each_thread(p, t) {
> +		if (unlikely(t->robust_list))

This is a racy access as the thread might concurrently write to it. So
it has to be annotated with data_race().

> +			return true;
> +#ifdef CONFIG_COMPAT
> +		if (unlikely(t->compat_robust_list))
> +			return true;
> +#endif
> +	}
> +	return false;
> +}
> +
> +bool check_robust_futex(struct task_struct *p)

The name sucks. Public futex functions are prefixed with
futex.

But this is about checking a process, no? So something like
process_has_robust_futex() makes it clear what this is about.

> +{
> +	bool has_robust;
> +
> +	rcu_read_lock();
> +	has_robust = __check_robust_futex(p);
> +	rcu_read_unlock();
> +	return has_robust;
> +}

Why do you need two functions here?

If the OOM killer is invoked, then saving a rcu_read_lock()/unlock() is
just a pointless optimization with zero value. rcu_read_lock() nests
nicely.

But I'm not convinced yet, that this is actually a sane approach.

Thanks,

        tglx


