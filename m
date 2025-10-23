Return-Path: <linux-kernel+bounces-866414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D024BFFB07
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A993ACE4B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1C22DC339;
	Thu, 23 Oct 2025 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aGd44HrT"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912142DC332
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761205790; cv=none; b=HWrZZae4K//YUY5tmiiO3CJpRkIhr8VM1zoysZ36hKZ0ctI/2/PYeKOsjk4UxpiHMiBXwXlYbqNkpS8wNVR5sOzvAtupT1/70INPn96z7p4mWmVqlUMqulXFunvswhbkfbkgi+VfTAoYiqksQBSX8ffU+pODlfWO9KVsUBfDF94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761205790; c=relaxed/simple;
	bh=0Mp8jxfiDjx+6SGWq944sEmqfWZv44pZHzsKR+o0Y/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ks0geSsBGqOfh3kmRhK05jzVbfpHE7H0W7jThCaAeWV5hjoRsq486p8hMGsZXg+1xfCftTRstIw/ER2p49XjepAOJc5aevdFpdqHiI/cLvvSIr16gxL/pLlrLnmx6667AMSZWDuVYFTYufArfWd5ijDbQfCaYAfgMIZwsKJ1lZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aGd44HrT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-471131d6121so3240155e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761205786; x=1761810586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=buhrfKCKAUbV93ahXUhbdLbSj4yiyZO38zRVoc8nGc0=;
        b=aGd44HrT6KriYW7syyu3KrNIQur6T5XYewgynCn4K6vY8k38cHsRcbQjClWVYQ1mjg
         QjuwREgk8nB68PxaIBBiCOV7Nmbw25MFs5nExvPkvUgboQkPf167cosW5pwB3B7+m6Le
         8SvOOK7rfm5pYM7f2jPuvtOF48kJYm+i6FBYvmi5uUEl3SPwkdC25ByTEbpYl9aw3h1u
         no1yaKGMYZ3Kynq9PILDTIPfPVNhurqecFvcy+Ge/Jal3R6Co70vSm+8kfiZly+qLJxT
         g2IO6q5pMWhcoBzETFtzLYAMcUE8M2S5WhJSwtedqsWKOHkdLAwJaGtVoo9UwnF6aMUk
         wIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761205786; x=1761810586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buhrfKCKAUbV93ahXUhbdLbSj4yiyZO38zRVoc8nGc0=;
        b=kDi6qjynJzXo5R18EiAzd+thmH5uEpO5WwCwH+lQkTwH/Ez4PeIWXfsVSiOHrysMdd
         qLn/incueRBCSlzPmvtj/RE7O1mcOPLd2EyjdmemlYkGR5ks8WOCVGQNoqoNNYOaf3bV
         fDHsJo7Lp3CasTYuISNhDuudpN7DDc+jKYdz5iA8QQRNN6/EaQcHMum5YBG6GWMSs/U0
         F8X2ksPp9nVIrbtweamNzuCfRDsd1+dYTeY4iTljusXQvYwXmo5OKsi8R7H2prn0cwEA
         q4DoA45IEPUiDdbWyDuBVsLhPiQCc5bEWVLw4HdjNRWHFifZO9563U9YhcotISPosIUV
         IjXw==
X-Forwarded-Encrypted: i=1; AJvYcCV9fAh7HPcNhZ1r1NSXJlJG7K5GsSQgrOdJ6Q80Fn0coFW9yzxwu8dYyAPXchd7Fh4wJsXiW+VF1YmVPdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx55eLRySnJBPy8OwFh4yIyPx94jnySjxIQKkHvzzD3ryUnmhqC
	MGgNxgkKhsZOMBMlKw+A6GSZKILTt1JAPzkewwjYhnbedNo8raHstbG5oyq7npt1CcE=
X-Gm-Gg: ASbGncvkAQ35D4rUWcwRgZkzWQQxFlIOmp4EBlH1VyeUBIuivxY2Ey8N+vOu7shTjzW
	9nNBeaDkVKZWHkX8NLnglk08skD9PvHfhIggostgcPUB+E7JyPkR+Px99nBull+i/alkErCi+Qs
	0PhmOlq8P/lzNErvR6JrVyBNxDw/COO8Zg1KCiXzkxHB2dRmvFQMOcrxEXh60soMzc4AjY0Jmmw
	QnqIeJlPay4h1LV5T3cjVi423eT/buLqaeWwl+s9hhUIM6pYLHjl87uIIJkfT8LavcSerBxgf35
	S7UyZuvmZE3LdhqcOWdiWJl6/N/634B3hhDax3VM1aB+dAGu5vjF23L6557ZNJ4S4SXu5mDTk3a
	jz2GO/1GTadZnmw0zXB6DiBQ85f9SaL1CxLA4hZKXCAF5uO3BY4AHiJI6w0Abde8hzkgsbopG5v
	WKtNbLLPl+XChDXyATcYqor8b0EjpibOh00Cl+yN4=
X-Google-Smtp-Source: AGHT+IFDHlwH4uQN0NhngE5GpDoyJ/84JrAW5QDGqlOvPH9h/SMikykg+/9OnKS0fpX5phTxKoEdIQ==
X-Received: by 2002:a05:600d:62b1:b0:46f:b43a:aef4 with SMTP id 5b1f17b1804b1-471b5341411mr75736425e9.38.1761205785863;
        Thu, 23 Oct 2025 00:49:45 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4342368sm84834305e9.9.2025.10.23.00.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 00:49:45 -0700 (PDT)
Date: Thu, 23 Oct 2025 09:49:38 +0200
From: Petr Mladek <pmladek@suse.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Message-ID: <aPneEnDQmHhpvRkG@pathway.suse.cz>
References: <20251022154115.GA22400@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022154115.GA22400@redhat.com>

On Wed 2025-10-22 17:41:15, Oleg Nesterov wrote:
> printk_legacy_map is used on !PREEMPT_RT to avoid false positives from
> CONFIG_PROVE_RAW_LOCK_NESTING about raw_spinlock/spinlock nesting.
> 
> However, LD_WAIT_SLEEP is not exactly right; it fools lockdep as if it
> is fine to acquire a sleeping lock.
> 
> Change DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map) to use LD_WAIT_CONFIG.
> 
> (We can also make printk_legacy_allow_spinlock_enter/exit() depend on
>  !PREEMPT_RT && CONFIG_PROVE_RAW_LOCK_NESTING)

I do not have strong opinion about adding (&& CONFIG_PROVE_RAW_LOCK_NESTING).
This dependency is already handled in LD_WAIT_CONFIG definition.

> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Anyway, the change makes sense to me. It seems that this better fits
the purpose.

Reviewed-by: Petr Mladek <pmladek@suse.com>

See a note below.

> ---
>  kernel/printk/printk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 5aee9ffb16b9..f11b2f31999b 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3007,7 +3007,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>   * false positive. For PREEMPT_RT the false positive condition does not
>   * occur.

From the comment, it was not obvious to me why the condition does not
occur for PREEMPT_RT. I had to check the commit message from the
commit daeed1595b4ddf314b ("printk: Avoid false positive lockdep
report for legacy printing").

<paste>
    However, on PREEMPT_RT the printing path from atomic context is
    always avoided and the console driver is always invoked from a
    dedicated thread. Thus the lockdep splat on !PREEMPT_RT is a
    false positive.
 </paste>

This is much more clear. It might make sense to improve the comment,
for example:

<proposal>
/*
 * Legacy console printing from printk() caller context does not respect
 * raw_spinlock/spinlock nesting. However, on PREEMPT_RT the printing
 * path from atomic context is always avoided and the console driver
 * is always invoked from a dedicated thread. Thus the lockdep splat
 * on !PREEMPT_RT is a false positive.
 *
 * This map is used to temporarily establish LD_WAIT_CONFIG context for the
 * console write() callback when legacy printing to avoid false positive
 * lockdep complaints, thus allowing lockdep to continue to function for
 * real issues.
 */
</proposal>

But it can be done in a separate patch...

>   *
> - * This map is used to temporarily establish LD_WAIT_SLEEP context for the
> + * This map is used to temporarily establish LD_WAIT_CONFIG context for the
>   * console write() callback when legacy printing to avoid false positive
>   * lockdep complaints, thus allowing lockdep to continue to function for
>   * real issues.
> @@ -3016,7 +3016,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>  static inline void printk_legacy_allow_spinlock_enter(void) { }
>  static inline void printk_legacy_allow_spinlock_exit(void) { }
>  #else
> -static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_SLEEP);
> +static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_CONFIG);
>  
>  static inline void printk_legacy_allow_spinlock_enter(void)
>  {

Best Regards,
Petr

PS: I would take this patch via the printk tree. But I am going to wait
    for feedback from others (John, Sebastian, ...).

