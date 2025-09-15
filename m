Return-Path: <linux-kernel+bounces-817328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0781CB580D0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420761771D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B8024728E;
	Mon, 15 Sep 2025 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e0Fc/uFP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9zAwmzD6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3AE1EA7C9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949911; cv=none; b=SqsO8h6J2GJgKgbpCwy9o6/7Hx69NL3j3QtkPTYfbkTKAa2smVWIZHijarHtxSDmA4pLVEeAJuXUWoA/MaVDchusmcNk+ywpg/Ba9CwEpcq6xWi8FhO7KhxEajhUCN1c5RdQHwz5q99FbZEWTXWR3hXjwCfMaNtpSjeZXcuTAC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949911; c=relaxed/simple;
	bh=YujghhzScq1tQeZdr+F+14FUbAvCIhG4NToRNGQwyWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DbYvd+SMyoJHnb9RDreM+9OvZtrCeZp41pMpRyWyAuEo1fx72EtOyJ5CkCBdHi1QWHkT+bV9XybuNiPYR5xHlg3LMGDC7EapeKUy0EauMBXEmBj71Th5575BjQDphIukh1nytsSpVPRJ9DceXSM7EEZOvNDV4zlKSWA8+LI+Z5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e0Fc/uFP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9zAwmzD6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757949907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jn+peWeg/5+mxfbxEm+yr90wjySGFs1kosdiAWG9Jv0=;
	b=e0Fc/uFP40+L8daozXVtAZpQZrlmzTSZyhPYaVdAsrBDZns3L7Yeoi80oa3WgZMeyxaRQR
	W7QC4dY+iv5+pxPqJU3xVjULb7+eBkBy+L1+P05y/UycPdX3WrrqY3qGvKq64sRrhbEgDj
	iWU/GLtCnz9WO3rJYdW69CVB0QksnWBmoFBaQAy5P1aKE2X64bm/AnxnsEEs6jc5bkfFsE
	1rDJ9r6g2Fixeb+Ohz80sYoI31GKHO2g9H6rs1wWFApWYJaOx7QbdiW0uAm8o6Sp2CAvxT
	7mEdvIXeom+97hhDkUoUIhq5l3I1qXI83caLDlZJh5tZWWH2HfTC3+GEGJ4rZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757949907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jn+peWeg/5+mxfbxEm+yr90wjySGFs1kosdiAWG9Jv0=;
	b=9zAwmzD6SBftK9i2WNk1NVkz64LQJEVqrYa065yEFUOygjsnvdtUJP4cNlovxRRFmylLly
	JsG0yCHgT+Z0g1Dg==
To: Petr Mladek <pmladek@suse.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 0/2] printk_ringbuffer: don't needlessly wrap data
 blocks around
In-Reply-To: <aMgr0dId_UfBptzW@pathway.suse.cz>
References: <20250905144152.9137-1-d-tatianin@yandex-team.ru>
 <aMLrGCQSyC8odlFZ@pathway.suse.cz> <aMLxt5k5U1vpmaQ3@pathway.suse.cz>
 <84bjnhx91r.fsf@jogness.linutronix.de> <aMPm8ter0KYBpyoW@pathway.suse.cz>
 <aMPt8y-8Wazh6ZmO@pathway.suse.cz> <aMQzD9CLP1F01Rry@pathway.suse.cz>
 <84a52zy0iu.fsf@jogness.linutronix.de> <aMgr0dId_UfBptzW@pathway.suse.cz>
Date: Mon, 15 Sep 2025 17:31:07 +0206
Message-ID: <84tt137n70.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-15, Petr Mladek <pmladek@suse.com> wrote:
> It might be possible to catch this in either in data_alloc().
> or in get_next_lpos(). They could ignore/yell about when
> the really occupied space would be bigger than DATA_SIZE(data_ring).
>
> Something like:
>
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 17b741b2eccd..d7ba4c0d8c3b 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -1056,8 +1056,16 @@ static char *data_alloc(struct printk_ringbuffer *rb, unsigned int size,
>  	do {
>  		next_lpos = get_next_lpos(data_ring, begin_lpos, size);
>  
> -		if (!data_push_tail(rb, next_lpos - DATA_SIZE(data_ring))) {
> -			/* Failed to allocate, specify a data-less block. */
> +		/*
> +		 * Double check that the really used space won't be bigger than
> +		 * the ring buffer. Wrapped messages need to reserve more space,
> +		 * see get_next_lpos.
> +		 *
> +		 * Specify a data-less block when the check or the allocation
> +		 * fails.
> +		 */
> +		if (WARN_ON_ONCE(next_lpos - begin_lpos > DATA_SIZE(data_ring)) ||
> +		    !data_push_tail(rb, next_lpos - DATA_SIZE(data_ring))) {
>  			blk_lpos->begin = FAILED_LPOS;
>  			blk_lpos->next = FAILED_LPOS;
>  			return NULL;
>
>
> Similar check would need to be done also in data_realloc().

I like this. It is an important sanity check and safe error handling in
case (for whatever reason) the data ring gets corrupted.

John

