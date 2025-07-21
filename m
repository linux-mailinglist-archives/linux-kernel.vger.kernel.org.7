Return-Path: <linux-kernel+bounces-739396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C27B0C5CF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 648237A706F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE4A2D8383;
	Mon, 21 Jul 2025 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qsU+Fkjg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6bttIhnp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097412D1914
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106846; cv=none; b=tVSim8YGLy459kgdUKzTfXaPX66Fbi7GLjeg+gQoSpVgXuGk5NGrdC+26TS4INTP2avQ42V+eQfrvuslFIEim4hRKvtoqoWL4q8OqyMpUatSpu8JezVJ5uZSxrUp80TH+KW1NTopaGYl3gZlJK4weDN+erqNNgpPtmkjfKGDX0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106846; c=relaxed/simple;
	bh=bfr4loJDw0vEo72RnHDIcOGh10KvzAEg46K0z/sjH6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=naS8sloNz5Cm7go8kpwG5k5NKWt9KORVBMAI60rWupYDOssONj1BR3nBq7HjMAV12tt1Apif7iZ05PZfE1nRISf2u18xg/hPTSGxyA+FHJD0oawMcSlY9b73dAnv2Q5XN799eKFeVig25lkYax5q4gW1Yz2ZI4uQDDzgQl/z9p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qsU+Fkjg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6bttIhnp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753106843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14B8g6eSb4EjlTHnllsNke5J77D0W2iTwRcpAh4Jgq0=;
	b=qsU+FkjguIS8yLlPeYmFRDV4jM+Gsq8UIiTu9BaDCmqSgjDznVKa6vUEZu+YWgujrmd2Wi
	34CBsW5MRFtq8/ry37U2EhKSEopRAFmre0efMCcI8H5WadLz8qwYWvxJOOXXvSAiNOS6Cw
	BLgnfjcyEQp5FECthxNyrce5pKRQIcsmfmaCjr+Jh2SP/RPgIeqmcxp+m3EuVVc6PI7MEq
	dtO7a8ILHX5cPBZ9LRQxz0YS0Wrj6Bw8AQAJ4WZAqAp+2uq56nhrqAfzsKbPBOj6uz8+qt
	cJwAuLPm6EJi6ZucNHQeLO3M8iNIix4pMpluIJF+8ySZWb7M9zZx8Tirrgdg9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753106843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14B8g6eSb4EjlTHnllsNke5J77D0W2iTwRcpAh4Jgq0=;
	b=6bttIhnplcR8/gtCx8dBtyghI2VmR9IwkXhujPhVDibj2zksAPM9GtL8YT5Jrh0FcvM2iN
	ZYK7hILxaFqX4KCA==
To: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] irq: simplify irq_im_handle_irq()
In-Reply-To: <20250719211818.402115-1-yury.norov@gmail.com>
References: <20250719211818.402115-1-yury.norov@gmail.com>
Date: Mon, 21 Jul 2025 16:07:22 +0200
Message-ID: <87zfcxtz6t.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yury!

On Sat, Jul 19 2025 at 17:18, Yury Norov wrote:

'irq:' is not the correct prefix here. See:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-submission-notes

Also irq_im_handle_irq() is not a known function name.

> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>
> Hi Thomas,

Since when is a greeting part of the changelog?

> The function calls bitmap_empty() for potentially every bit in
> work_ctx->pending, which makes a simple bitmap traverse O(N^2).
> Fix it by switching to the dedicated for_each_set_bit().
>
> While there, fix using atomic clear_bit() in a context where atomicity
> cannot be guaranteed.

Seriously? See below.

>  static void irq_sim_handle_irq(struct irq_work *work)
>  {
>  	struct irq_sim_work_ctx *work_ctx;
> -	unsigned int offset = 0;
> +	unsigned int offset;
>  	int irqnum;
>  
>  	work_ctx = container_of(work, struct irq_sim_work_ctx, work);
>  
> -	while (!bitmap_empty(work_ctx->pending, work_ctx->irq_count)) {
> -		offset = find_next_bit(work_ctx->pending,
> -				       work_ctx->irq_count, offset);
> -		clear_bit(offset, work_ctx->pending);
> +	for_each_set_bit(offset, work_ctx->pending, work_ctx->irq_count) {
> +		__clear_bit(offset, work_ctx->pending);

This is just wrong.

__clear_bit() can only be used when there is _NO_ concurrency
possible. But this has concurrency:

irq_sim_set_irqchip_state()
...
        assign_bit(hwirq, irq_ctx->work_ctx->pending, state);

That function can be executed on a different CPU concurrently while the
other CPU walks the bitmap and tries to clear a bit. The function
documentation of __clear_bit() has this documented very clearly:

 * Unlike clear_bit(), this function is non-atomic. If it is called on the same
 * region of memory concurrently, the effect may be that only one operation                                                                                    * succeeds.

No?

Thanks,

        tglx

