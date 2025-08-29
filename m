Return-Path: <linux-kernel+bounces-791274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D02FB3B466
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF87365E60
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223E426F2B6;
	Fri, 29 Aug 2025 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u0QLOyaz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1uq244WD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028A81BC5C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756452885; cv=none; b=O2NNlw9PHU0ByFi5hwUB6HOZazfNBQE/h+woo9zVsrAJuKJMS6fbMt5Fc2R90erZSdZloFSW2mKN3mMGaD8l55c+2RjugiJm1vVIRRIOBnDntlJX0mGdww/Eyg2f0Qkg0EwQhTdmABz93toeRbtHks32Z8knkeOzGMkgSZWGTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756452885; c=relaxed/simple;
	bh=uIksg7Zi0o85LKuFai1b3sYVObqNgA7g2rNOq0UAmnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HgqkwOIRVN1B1rwOkHhgAYR3vRlyW+rtopdiYzTNFYtp5jf9yBmoFTqA4j7n8HzebFxRRF6tOeXzmma4Z+3TkFVyVWBzB+C/igbPk24Pd87PHp1QOO9Uwy8h2nd15tdNLNeAi+u8is1Z3mHK6ATTAf6QbSpY5q+SmNl+7Q/mHAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u0QLOyaz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1uq244WD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756452882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zv5+MLBi7cjYgI+dNGrVuJkftVQLCugu1DPpPxUZzkI=;
	b=u0QLOyazaFd/TDZuH+hXP7xeJsoLmIgnQBJq0RHP7NX74To0c+wlgHqd01pElcIVht1Y1P
	c7wfIOoJKb3brPbCyO7ZiExgaKgxtVT4iIU5ougchX8i97OtsbKKU1jbevM/jpjNzqqcHX
	HdvXhl2phB22eM+3Y0gcPvdYAnaW+DJKQ+nhHz/SmLAnf6XfpR+B8O93m2EVmEEXKYmer4
	kSK3cQkaw/vrMKy6RZTSTFdu3CiWJCB5yBMGPpxNUhO+6qml1uqxP9AQUZ5SUW/CZrR+LO
	ZPYUOcm/mxDgy2wjkb1HcoGL0Nf3cMXQsoFgly7whbT4KVzjN2q2ZrUwfO9JsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756452882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zv5+MLBi7cjYgI+dNGrVuJkftVQLCugu1DPpPxUZzkI=;
	b=1uq244WDzvHrn8vtKPd/Mvr+qpWsvCRYxCuiNDRSbNw8+qU5MQTc1RSRAO624JpFL8KHsW
	XAfEPOfGziHuK5Bw==
To: Jinchao Wang <wangjinchao600@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Qianqiang Liu <qianqiang.liu@163.com>
Cc: linux-kernel@vger.kernel.org, Jinchao Wang <wangjinchao600@gmail.com>,
    Petr Mladek <pmladek@suse.com>,
    Steven Rostedt <rostedt@goodmis.org>,
    Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] panic: use angle-bracket include for panic.h
In-Reply-To: <20250829051312.33773-1-wangjinchao600@gmail.com>
References: <20250829051312.33773-1-wangjinchao600@gmail.com>
Date: Fri, 29 Aug 2025 09:40:41 +0206
Message-ID: <84349ainse.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Added CC printk folks...

On 2025-08-29, Jinchao Wang <wangjinchao600@gmail.com> wrote:
> Replace quoted includes of panic.h with `#include <linux/panic.h>` for
> consistency across the kernel.
>
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

> ---
>  kernel/crash_core.c    | 2 +-
>  kernel/printk/nbcon.c  | 2 +-
>  kernel/printk/printk.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index bb38bbaf3a26..a5e8523dd6eb 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -4,7 +4,6 @@
>   * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
>   */
>  
> -#include "linux/panic.h"
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/buildid.h>
> @@ -23,6 +22,7 @@
>  #include <linux/btf.h>
>  #include <linux/objtool.h>
>  #include <linux/delay.h>
> +#include <linux/panic.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 171480135830..558ef3177976 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -2,7 +2,6 @@
>  // Copyright (C) 2022 Linutronix GmbH, John Ogness
>  // Copyright (C) 2022 Intel, Thomas Gleixner
>  
> -#include "linux/panic.h"
>  #include <linux/atomic.h>
>  #include <linux/bug.h>
>  #include <linux/console.h>
> @@ -13,6 +12,7 @@
>  #include <linux/irqflags.h>
>  #include <linux/kthread.h>
>  #include <linux/minmax.h>
> +#include <linux/panic.h>
>  #include <linux/percpu.h>
>  #include <linux/preempt.h>
>  #include <linux/slab.h>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 236f03937107..5aee9ffb16b9 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -17,7 +17,6 @@
>   *	01Mar01 Andrew Morton
>   */
>  
> -#include "linux/panic.h"
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/kernel.h>
> @@ -49,6 +48,7 @@
>  #include <linux/sched/clock.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched/task_stack.h>
> +#include <linux/panic.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/sections.h>
> -- 
> 2.43.0

