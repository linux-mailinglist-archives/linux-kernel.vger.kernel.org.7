Return-Path: <linux-kernel+bounces-809997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784C7B51462
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32DD14E1780
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C23D31770D;
	Wed, 10 Sep 2025 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FanGdJei";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AkzQg0un"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7C1318143
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501293; cv=none; b=MYQm4djhowkQzceAjPZl+prfgKs0LLulOkJGZ9nPycXRrJxmeX6S1uoqtea1CN6sQJwBSh9y2KOSLeawehh75zMSekUGZrysnHfo6lAqESOlO/E1DkK8HDZATl1PweeMxujGwHXFGcm5tOQWxzlz+aMAj72xFbOxCxJrSypEVlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501293; c=relaxed/simple;
	bh=wjmFNl1+kBNvX+NtEBNvJvp3e0VVMlmcS7genD/poNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7793rdDuO8QpWH5kYCD8eOJuzdOH2RxSCiBhZMotCmEVrJY3sAr8BvGA0NRgX77hfyMD5ObEgN0Lf1t6ZB548TIeoZN+uliwVbWFjSJmnnrzHQzZipT5ixo7s6wiVYPzf0Efy0QjI6ZBmfmGeBIIDGfM+XUkX19b0WmK+9fQgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FanGdJei; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AkzQg0un; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Sep 2025 12:48:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757501287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zeQ4ssHFNquz4UbcvBi0OLkLQu/CjmGkXKDzLmFBgAU=;
	b=FanGdJeimtiVlePMD1t0Pv75dwIt14vIZLvpakcsO2k+soPGxvSGp6kJMjkyXt7q3pfIwF
	rAu3K8tblaeFiMkgoa34HdigIFfHw7SGMHHqrnc6sGX6JpAHox8ekYhva9bYETysURsa2s
	7XSFRWo/pfWE1LduBu87hvdz2t9WxUbYUZpeEXlVt7KhLqbKH4BZplYyk29RnWhopgQgwn
	taU9xvZZsOY0XaPsus03D1zLI06HzAIf8CNNFrlqlG+YpuAqD95XvqbEy3zfAUJPY1dr/g
	lUsb3r381XoYOP1jrYkbc16BXRE/NjN1s+q4OUwAk7mhD+XDEdGXGHE9bmToPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757501287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zeQ4ssHFNquz4UbcvBi0OLkLQu/CjmGkXKDzLmFBgAU=;
	b=AkzQg0unzaBCZS12KIttLsblJxn+0bgeJoNz+q1pe6sfOsvVHQZkKNjeWNNOOfPjoEoT4y
	TSWnhbbHyzAzPHAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
	syzbot <syzbot+034246a838a10d181e78@syzkaller.appspotmail.com>,
	andrealmeid@igalia.com, dave@stgolabs.net, dvhart@infradead.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] futex: Prevent use-after-free during requeue-PI
Message-ID: <20250910104806.Jkzd5ya1@linutronix.de>
References: <68b75989.050a0220.3db4df.01dd.GAE@google.com>
 <20250902214628.GL4067720@noisy.programming.kicks-ass.net>
 <20250903130712.br0G6lOq@linutronix.de>
 <a1808501-559e-4762-b0ea-f1fffd2e7f19@kernel.dk>
 <20250904162820.NS1U-oZp@linutronix.de>
 <4918e983-9964-46a2-aee0-59c91a9c6b35@kernel.dk>
 <875xdruzl4.ffs@tglx>
 <20250910104243.TUMt9HM0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250910104243.TUMt9HM0@linutronix.de>

On 2025-09-10 12:42:45 [+0200], To Thomas Gleixner wrote:
> --- a/kernel/futex/requeue.c
> +++ b/kernel/futex/requeue.c
> @@ -243,10 +244,11 @@ void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
>  	futex_hash_get(hb);
>  	q->drop_hb_ref = true;
>  	q->lock_ptr = &hb->lock;
> +	task = READ_ONCE(q->task);
>  
>  	/* Signal locked state to the waiter */
>  	futex_requeue_pi_complete(q, 1);

once understood, adding an mdelay(500) here greatly improves the chances
to trigger.
futex_requeue_pi_complete() uses atomic_try_cmpxchg() which has full
ordering. This means that the q->drop_hb_ref assignment earlier is
visible to the other thread after that cmpxchg, correct? 

> -	wake_up_state(q->task, TASK_NORMAL);
> +	wake_up_state(task, TASK_NORMAL);
>  }

Sebastian

