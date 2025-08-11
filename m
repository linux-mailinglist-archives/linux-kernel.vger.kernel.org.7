Return-Path: <linux-kernel+bounces-762622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9285DB2090F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEEC51882817
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259FB2D3ECB;
	Mon, 11 Aug 2025 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mzib+9mG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bKfGDO4p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C846145A05
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916182; cv=none; b=jJ9npmBQFPTQxupXQolwCiYVrDPcMCwWKzWKeYAZDRERycMBHHxEbRxs/lwwXw42B2zjS80uw1TEnrfklJyeIU9aSB0gJaldXzhwjLQZswjCjJWcStfHTCxWfEN+R5Ebq8GWaZvK/oOoThIDbEm2dZ3efMNk46bxF0FJbwh2n88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916182; c=relaxed/simple;
	bh=qSpppMhBZ4rAZCaE+TpwCfhglLuzf5pnvKaja4dbmtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hSTJjeiwhWm+6xf2FM/KKqceTgcqI1BUFzyFWOvCxnb9UoPI7Bk+Qwn3PuqCPFf+lcn9bTI2ZLZyzjxxZ665fURqH9FrTq11lCjUIcJnzGg5fo9ScVo9fW90IviPs90VL0BrSL+FgXW36qzeDbKVIzap8ffLNWTAM0nw7bX+Bxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mzib+9mG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bKfGDO4p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754916179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lf+Y4Vt2Px7FQhGLXfsoCqWEz2Cn8CJfWi8P8lbjJj8=;
	b=mzib+9mGE7DlWlU7MqQOzIGCqrHS+zibd1X8vNvDoSDCAr8ezroZz9TZ0oURg+Ngj94VTa
	0UkS8tCBMll5gbLA9XEv+/z4VvZLB3lj2ck/QeKcqw/Jq4UPo2GWQNfHh43NJtMI2MyoJB
	f4jVRGJlhGUmTkW7AQbajrgnkAGXYBKgSBBlIOzrXx9PCtlus0iTj1+e24xFRHQuqn7rWd
	eVS6Hf3VhOwQ3HTa/n3kl/pflf3bQ99FJn1GmWxBaM1d0Y02eD5O0P9Gosp+J58q1pGivm
	Wc5pNUEwVB+Uz6blnYgjKKuuG2j1KBtCKj7bQRs0U2NyDQ5PVUHjbY357iW8Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754916179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lf+Y4Vt2Px7FQhGLXfsoCqWEz2Cn8CJfWi8P8lbjJj8=;
	b=bKfGDO4py2nSb7GnNWB3RZLTxCpdnFK9xjY6m2HZ7mW2725zQFzpqQ4sHhsm6FSYFi+HQQ
	K008uuPP7iSj2PAA==
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>
Subject: Re: [patch V2 m@/6] perf/core: Split out mlock limit handling
In-Reply-To: <20250811104940.GF1613200@noisy.programming.kicks-ass.net>
References: <20250811065859.660930338@linutronix.de>
 <20250811070620.463634790@linutronix.de>
 <20250811104940.GF1613200@noisy.programming.kicks-ass.net>
Date: Mon, 11 Aug 2025 14:42:58 +0200
Message-ID: <87o6sm81wt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 11 2025 at 12:49, Peter Zijlstra wrote:
> On Mon, Aug 11, 2025 at 09:06:37AM +0200, Thomas Gleixner wrote:
>> To prepare for splitting the buffer allocation out into seperate functions
>> for the ring buffer and the AUX buffer, split out mlock limit handling into
>> a helper function, which can be called from both.
>> 
>> No functional change intended.
>> 
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> 
>> ---
>
> Does this not also need this? I found this stray user_extra when I
> eventually removed the local user_extra variable.
>
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6997,8 +6997,6 @@ static int perf_mmap(struct file *file,
>  	if (vma_size != PAGE_SIZE * nr_pages)
>  		return -EINVAL;
>  
> -	user_extra = nr_pages;
> -
>  	mutex_lock(&event->mmap_mutex);
>  	ret = -EINVAL;
>  

No. That's how user_extra is initialized in the first place.

To remove that nr_pages must become an argument to that function.


