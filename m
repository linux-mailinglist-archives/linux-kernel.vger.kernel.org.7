Return-Path: <linux-kernel+bounces-867008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2140CC01551
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7E38505334
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF35B2E5404;
	Thu, 23 Oct 2025 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L2aFtXvs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FRp581Xn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7A219C556
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225578; cv=none; b=SKF18sD+fwifTzkmINWjXJHElvJr2glKn91RlQ4XLDYdCVcY4N5QilYbUlH1ljRE1lN2zoAwUrlsBs9chsR1xNQCF/HycfjRDAnUnZzZtV6ALEVQfTmYlvAIhY3m+KokX4mB3LXUkVLvuVAd56M46Jg+0xb4IsPnCwnGYccNp0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225578; c=relaxed/simple;
	bh=T+F1g+ALY6wTUxOEGzwSqTW1Q6bWAtf0ZptrXp+VkG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EXPrhdZwhEn+1HEV9YpbGF+dr+JR6YJv443uqgg93IV2bTyN/6jl4tAEKO656cBEFfpEOlplzNW+Gn9GH//v4FE5oZTz2R+YERIMsdg1rwOpwbCvGrL62D4oYxpWViuAOm+FDc33n12vWh+2heUyGu0Nk9ZWzBc82rbTVTtP0OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L2aFtXvs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FRp581Xn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761225574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kj85f/RBw71zQsTY0GuD1EzROFtTmqxngP7pBtJuVvs=;
	b=L2aFtXvsFEV1Sfb4e8uP5p8UgUKjC/RmcS7T9pJu2T9d+39HLYmvOKu4p+mQdqNSptMXPx
	Rj/3gTZORRHgouAplBoqVrhfapqY21IeSc8almD/efaV/Ar17ORe1eA2nC8mr/EXdFxm/m
	r1/Vh8OlOijVwqFrsGbq3yDcEUvUt0NlQIbPoRfSCJjpQHM1ruvu9pIHgZu7w4/D76SCcO
	I1flc2wHpY0HbvnEVyorYz6ixe/1O3TO4mvKUliwfwLCl893TGIuEb/Lgfbjjq6nc1+YPY
	VBEzegM6cCLu8pvyuxNCWvHoLwvotxAgTGiODOSTzcsJVRrRDFSCvIEd0P49vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761225574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kj85f/RBw71zQsTY0GuD1EzROFtTmqxngP7pBtJuVvs=;
	b=FRp581XnXHBPgY5yItYCWpco3sewwnAkrsrOsuUqz4CczWhtQZPs59rjzj00CXQmIyQXRA
	Sft+s5paPS4B78Dg==
To: Andrew Murray <amurray@thegoodpenguin.co.uk>, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: Re: [PATCH v3 3/3] printk: Use console_flush_one_record for legacy
 printer kthread
In-Reply-To: <20251020-printk_legacy_thread_console_lock-v3-3-00f1f0ac055a@thegoodpenguin.co.uk>
References: <20251020-printk_legacy_thread_console_lock-v3-0-00f1f0ac055a@thegoodpenguin.co.uk>
 <20251020-printk_legacy_thread_console_lock-v3-3-00f1f0ac055a@thegoodpenguin.co.uk>
Date: Thu, 23 Oct 2025 15:25:34 +0206
Message-ID: <87zf9hbvrt.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-10-20, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 6c846d2d37d9d20bad58c6e3a7caada3be9552ca..2665a7a59f03b3a357b3346de1735606e77c3496 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3644,17 +3644,26 @@ static bool legacy_kthread_should_wakeup(void)
>  
>  static int legacy_kthread_func(void *unused)
>  {
> -	for (;;) {
> -		wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());
> +	bool try_again;
> +
> +wait_for_event:
> +	wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());
> +
> +	do {
> +		u64 next_seq = 0;
> +		bool handover = false;

Nit: I prefer to sort by line length:

		bool handover = false;
		u64 next_seq = 0;

With change:

Reviewed-by: John Ogness <john.ogness@linutronix.de>

