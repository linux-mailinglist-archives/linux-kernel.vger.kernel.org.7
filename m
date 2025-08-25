Return-Path: <linux-kernel+bounces-784444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD59B33BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B430C17FE03
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0994C2D0C95;
	Mon, 25 Aug 2025 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U1L3L4df";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="foPLQgWZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07F2293C4E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115601; cv=none; b=sOj/giizsoNdMDBTXDDZnsrzhwg3laF72GXe09AfbOJX9gVGZVA3TNu0898NNMdZn4e366ogJXlUVijkLHDFLmpdV3mXCA2s7eAngCA2NO2qpYrvkH1P82/2cZqrK7npNEdIEENR6ZpweRUqK6a+NG1apDFv2VgdtSVw2ru6Vjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115601; c=relaxed/simple;
	bh=xJpFqzaqKgISiM7zMtTwHanAHWCN1r02jm2naeRcyPU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pxAErSBRs/ht9HZ2ibfzuiXAEN6eNSmJn+1XUNF3WZPPGsEJWouVx95Jhjy8KrktTHYixw6U8HG0x9nKrrNeDNdxK4LBhZ4EUmuSen2v6o700ZZbOiPLxOkjPUuT49FkJ68mnNZJ3bmgaxtv+RTo+UTD5tlRffOg7tq06AhMhog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U1L3L4df; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=foPLQgWZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756115596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35B4fjhngLRBiTOVgGZswSonEiPbq+2cC52RJ1vGSQ4=;
	b=U1L3L4df+74JpwTccXgHr42RRvmQfGXY9KMWRMXHJHoupCQVGe5f7ZEeowcB+gRiPJlkty
	nUSIsIhO1346QvyKCdX8e4wKeJf7H/INVxoGO8TIaZ3KfeNf4lclVaKl3IxZREx0C4fRlq
	5vdJ0qhpncFWblTo93NjRS25yjEOsg3CDUo/1OSMPwD5JdBlxbxfo+tGsowj6AefdGJliR
	yfZZ/t7X6H/iWyWijgImjKhdAi0lFejBHsggjB1ciGZWFn5CchFQmAHJzg7JdUpNvMj9Ys
	i/DbB3FJNtCnz/+9dsH/Aqdbm2mJaXOoGGrp3/GEJzU5cOzHB17o7vbNZEt8pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756115596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35B4fjhngLRBiTOVgGZswSonEiPbq+2cC52RJ1vGSQ4=;
	b=foPLQgWZfCJRXUR/yHmICMfN69C4ZHPqjeX79OgcwU8VMDUXMPQOKZHR1eFbYwG0VVahgG
	WSaAYzkYgFIxQoAw==
To: Jinchao Wang <wangjinchao600@gmail.com>, pmladek@suse.com,
 akpm@linux-foundation.org, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, feng.tang@linux.alibaba.com,
 joel.granados@kernel.org, wangjinchao600@gmail.com, namcao@linutronix.de,
 sravankumarlpu@gmail.com
Subject: Re: [PATCH 6/9] printk/nbcon: use panic_on_this_cpu() helper
In-Reply-To: <20250820091702.512524-7-wangjinchao600@gmail.com>
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
 <20250820091702.512524-2-wangjinchao600@gmail.com>
 <20250820091702.512524-3-wangjinchao600@gmail.com>
 <20250820091702.512524-4-wangjinchao600@gmail.com>
 <20250820091702.512524-5-wangjinchao600@gmail.com>
 <20250820091702.512524-6-wangjinchao600@gmail.com>
 <20250820091702.512524-7-wangjinchao600@gmail.com>
Date: Mon, 25 Aug 2025 11:59:16 +0206
Message-ID: <84wm6rbucz.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-08-20, Jinchao Wang <wangjinchao600@gmail.com> wrote:
> nbcon_context_try_acquire() compared
> panic_cpu directly with smp_processor_id().
> This open-coded check is now provided by
> panic_on_this_cpu().
>
> Switch to panic_on_this_cpu() to simplify
> the code and improve readability.
>
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  kernel/printk/nbcon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 646801813415..7490865e2f44 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -2,6 +2,7 @@
>  // Copyright (C) 2022 Linutronix GmbH, John Ogness
>  // Copyright (C) 2022 Intel, Thomas Gleixner
>  
> +#include "linux/panic.h"
>  #include <linux/atomic.h>
>  #include <linux/bug.h>
>  #include <linux/console.h>

Please use angle brackets. Also, the includes are sorted
alphabetically. So it should look like this:

 #include <linux/irqflags.h>
 #include <linux/kthread.h>
 #include <linux/minmax.h>
+#include <linux/panic.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/slab.h>

> @@ -589,7 +590,6 @@ static struct printk_buffers panic_nbcon_pbufs;
>   */
>  static bool nbcon_context_try_acquire(struct nbcon_context *ctxt, bool is_reacquire)
>  {
> -	unsigned int cpu = smp_processor_id();
>  	struct console *con = ctxt->console;
>  	struct nbcon_state cur;
>  	int err;
> @@ -614,7 +614,7 @@ static bool nbcon_context_try_acquire(struct nbcon_context *ctxt, bool is_reacqu
>  	/* Acquire succeeded. */
>  
>  	/* Assign the appropriate buffer for this context. */
> -	if (atomic_read(&panic_cpu) == cpu)
> +	if (panic_on_this_cpu())
>  		ctxt->pbufs = &panic_nbcon_pbufs;
>  	else
>  		ctxt->pbufs = con->pbufs;

With the above changes:

Reviewed-by: John Ogness <john.ogness@linutronix.de>

