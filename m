Return-Path: <linux-kernel+bounces-899845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D61C59022
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCBDD54912B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54030369990;
	Thu, 13 Nov 2025 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MS+ynX7R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC936997D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051922; cv=none; b=CBe6XhoSzv8N2KI4e9DAIZP63YwJDvRARYcsCkM4pJls8FeCB6OgqQmKOOmgVV8gIj7XDHUhZDBNU20mSArGdrUWZfl7nSnK0qex6BF4kYq7GFMEeyd47OpVP0HL5LrZC2uuX3jlq/TOe+1Bk3gZreGHnl5iBgwubh1GBqlfGeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051922; c=relaxed/simple;
	bh=7JmJjlOLM7YF/aoEOfnmZDsS7mYHbiyo63BRjbVcVU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGqi+Z2mrDAoOEB/xLuh0V6fGH//HYOMDZzV+w0Tm9bh3hnR3oLH+JuqUoFoHrPPi+FyHY0BWf4h0SFE+IZJ/jslPIT9OgHUmjr7D/+lL+qVLt8v7p59x8jIKVlVO50wI0x9mh5QU/JZyXS5rH/P8ssJwhO6/wpoydrOTHc+PDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MS+ynX7R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763051919;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=xe+X3mdag6fV8h/+NMdsDvwRa8jS9KrFnwPQstc7Xho=;
	b=MS+ynX7RPN9+IrvKHwwhBZSlCykc9l2gnUNJ0d4NkWiuzrJBgyAlxhsQid2cWycSZQjCxC
	hlNskomhwgAAu9b2FAVypMl2AhlTqYbPLLOOspno7FZ/e4J9+h+Eooa4oAKd7yriZBbT3q
	vDJDrMQS4LimcXb2vU9fT4GRy+3NBXw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-xtmH_0HjM_iy2Ln-1pnZYA-1; Thu,
 13 Nov 2025 11:38:38 -0500
X-MC-Unique: xtmH_0HjM_iy2Ln-1pnZYA-1
X-Mimecast-MFC-AGG-ID: xtmH_0HjM_iy2Ln-1pnZYA_1763051916
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C04318AB423;
	Thu, 13 Nov 2025 16:38:36 +0000 (UTC)
Received: from localhost (unknown [10.22.88.185])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA15819560B9;
	Thu, 13 Nov 2025 16:38:35 +0000 (UTC)
Date: Thu, 13 Nov 2025 11:38:33 -0500
From: Derek Barbosa <debarbos@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sherry Sun <sherry.sun@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Jon Hunter <jonathanh@nvidia.com>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH printk v2 2/2] printk: Avoid scheduling irq_work on
 suspend
Message-ID: <jvn24vsnd2utypz33k33n3ol3ihh44tcyhcbtjhfxnepuvb7hn@qhcikbtwioyk>
Reply-To: debarbos@redhat.com
References: <20251113160351.113031-1-john.ogness@linutronix.de>
 <20251113160351.113031-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113160351.113031-3-john.ogness@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Nov 13, 2025 at 05:09:48PM +0106, John Ogness wrote:

> ---
>  @sherry.sun: This patch is essentially the same as v1, but since
>  two WARN_ON_ONCE() were added, I decided not to use your
>  Tested-by. It would be great if you could test again with this
>  series.
> 
>  kernel/printk/internal.h |  8 +++---
>  kernel/printk/nbcon.c    |  7 +++++
>  kernel/printk/printk.c   | 58 +++++++++++++++++++++++++++++-----------
>  3 files changed, 55 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 73f315fd97a3e..730d14f6cbc58 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1276,6 +1276,13 @@ void nbcon_kthreads_wake(void)
>  	if (!printk_kthreads_running)
>  		return;
>  
> +	/*
> +	 * It is not allowed to call this function when console irq_work
> +	 * is blocked.
> +	 */
> +	if (WARN_ON_ONCE(console_irqwork_blocked))
> +		return;
> +

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index dc89239cf1b58..b1c0d35cf3caa 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -462,6 +462,9 @@ bool have_boot_console;
>  /* See printk_legacy_allow_panic_sync() for details. */
>  bool legacy_allow_panic_sync;
>  
> +/* Avoid using irq_work when suspending. */
> +bool console_irqwork_blocked;
> +
>  #ifdef CONFIG_PRINTK
>  DECLARE_WAIT_QUEUE_HEAD(log_wait);
>  static DECLARE_WAIT_QUEUE_HEAD(legacy_wait);
> @@ -2426,7 +2429,7 @@ asmlinkage int vprintk_emit(int facility, int level,
>  
>  	if (ft.legacy_offload)
>  		defer_console_output();
> -	else
> +	else if (!console_irqwork_blocked)
>  		wake_up_klogd();
>  
>  	return printed_len;
> @@ -2730,10 +2733,20 @@ void console_suspend_all(void)
>  {
>  	struct console *con;
>  
> +	if (console_suspend_enabled)
> +		pr_info("Suspending console(s) (use no_console_suspend to debug)\n");
> +
> +	/*
> +	 * Flush any console backlog and then avoid queueing irq_work until
> +	 * console_resume_all(). Until then deferred printing is no longer
> +	 * triggered, NBCON consoles transition to atomic flushing, and
> +	 * any klogd waiters are not triggered.
> +	 */
> +	pr_flush(1000, true);
> +	console_irqwork_blocked = true;
> +

Thanks for this. I have recently have been seeing the same issue with a large-CPU
workstation system in which the serial console been locking up entry/exit of S4
Hibernation sleep state at different intervals.

I am still running tests on the V1 of the series to determine reproducibility,
but I will try to get this version tested in a timely manner as well.

I did, however, test the proto-patch at [0]. The original issue was reproducible
with this patch applied. Avoiding klogd waking in vprintk_emit() and the
addition of the check in nbcon.c (new in this series) opposed to aborting
callers outright seems more airtight.


[0] https://github.com/Linutronix/linux/commit/ae173249d9028ef159fba040bdab260d80dda43f
-- 
Derek <debarbos@redhat.com>


