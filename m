Return-Path: <linux-kernel+bounces-832200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741B3B9EA01
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74067162C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40C62E9ED2;
	Thu, 25 Sep 2025 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FGVvuqMw"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FBD2EA17E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795974; cv=none; b=VnYXlJyDLNusx8IO1OeC5AQQAGNbnIAlPLxt7Yd0bwjrsTzCuS9IJwJhDB1SKizYqDd1rbsN3VW5/9IvL7tQQaLsPDvdIOGtK7SqBemdBI7mGBI8yw9mLvsaN9bCbDaZaBDCpq9STFEW6DzTpda02+4n27zg6uyAJXy0GkXOOlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795974; c=relaxed/simple;
	bh=HR307Ikujc4g3Jw+JvXIwj64igIG4jHBJVOXhXUZ7Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=tQxZoHBSf3gX46p+HRhdBR9dxUivXc8j7xZwZhVyYVhMQ6pFQh1+8fDvoCSuyJeuCis3ikYwp+VtTwwPG9UK7wB5zeDsoc/mQp47N9WZuD2iysKfsJSiKDkV5vj/mKaYvmpSMiGXWTSjq+sHisSQqemHyAc+RfRrxKNXST2UPtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FGVvuqMw; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8c4cd66c-9c3f-411a-82df-0130b78e889c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758795968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSBp7mwd6IegmizNUgNJ2Rdv3+ICK9Hl1UxkDAxxj/Q=;
	b=FGVvuqMwIZ/H+tNl4SgRd2rEOY7gTr4pUbdred2iBj0q8AjRHqW2wVBhu/26PKDz6rneE8
	YQIll6RfW3ZtqGJEmLA9LiOtFiprSpLRTVdcZwCvrPusUujzedD/JtaUAFV01zf3K4f9Z3
	RKAkbUVchSuJ/BGLvv66v3dutGqbBUo=
Date: Thu, 25 Sep 2025 18:26:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] hung_task: Panic after fixed number of hung tasks
Content-Language: en-US
To: lirongqing <lirongqing@baidu.com>
References: <20250925060605.2659-1-lirongqing@baidu.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, arnd@arndb.de,
 feng.tang@linux.alibaba.com, joel.granados@kernel.org, kees@kernel.org,
 rostedt@goodmis.org, pauld@redhat.com, pawan.kumar.gupta@linux.intel.com,
 mhiramat@kernel.org, dave.hansen@linux.intel.com, corbet@lwn.net,
 akpm@linux-foundation.org, paulmck@kernel.org, mingo@kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250925060605.2659-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


Thanks for the patch!

On 2025/9/25 14:06, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Currently, when hung_task_panic is enabled, kernel will panic immediately
> upon detecting the first hung task. However, some hung tasks are transient
> and the system can recover fully, while others are unrecoverable and
> trigger consecutive hung task reports, and a panic is expected.

The new hung_task_count_to_panic relies on an absolute count, but I
assume the real indicator you're trying to capture is the trend or
rate of increase over a time window (e.g., "panic if count increases
by 5 in 10 minutes").

IMHO, this kind of time-windowed, trend-based logic seems much more
flexible and better suited for a userspace monitoring agent :)

In other words, why is this the right place for this feature?

Please sell it to us ;)
Lance

> 
> This commit adds a new sysctl parameter hung_task_count_to_panic to allows
> specifying the number of consecutive hung tasks that must be detected
> before triggering a kernel panic. This provides finer control for
> environments where transient hangs maybe happen but persistent hangs should
> still be fatal.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   Documentation/admin-guide/sysctl/kernel.rst |  6 ++++++
>   kernel/hung_task.c                          | 14 +++++++++++++-
>   2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 8b49eab..4240e7b 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -405,6 +405,12 @@ This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
>   1 Panic immediately.
>   = =================================================
>   
> +hung_task_count_to_panic
> +=====================
> +
> +When set to a non-zero value, after the number of consecutive hung task
> +occur, the kernel will triggers a panic
> +
>   
>   hung_task_check_count
>   =====================
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 8708a12..87a6421 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -83,6 +83,8 @@ static unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
>   static unsigned int __read_mostly sysctl_hung_task_panic =
>   	IS_ENABLED(CONFIG_BOOTPARAM_HUNG_TASK_PANIC);
>   
> +static unsigned int __read_mostly sysctl_hung_task_count_to_panic;
> +
>   static int
>   hung_task_panic(struct notifier_block *this, unsigned long event, void *ptr)
>   {
> @@ -219,7 +221,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>   
>   	trace_sched_process_hang(t);
>   
> -	if (sysctl_hung_task_panic) {
> +	if (sysctl_hung_task_panic ||
> +	    (sysctl_hung_task_count_to_panic &&
> +	     (sysctl_hung_task_detect_count >= sysctl_hung_task_count_to_panic))) {
>   		console_verbose();
>   		hung_task_show_lock = true;
>   		hung_task_call_panic = true;
> @@ -388,6 +392,14 @@ static const struct ctl_table hung_task_sysctls[] = {
>   		.extra2		= SYSCTL_ONE,
>   	},
>   	{
> +		.procname	= "hung_task_count_to_panic",
> +		.data		= &sysctl_hung_task_count_to_panic,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +	},
> +	{
>   		.procname	= "hung_task_check_count",
>   		.data		= &sysctl_hung_task_check_count,
>   		.maxlen		= sizeof(int),


