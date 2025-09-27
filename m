Return-Path: <linux-kernel+bounces-834783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9D2BA583B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 04:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B1A4A3280
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 02:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241491A9FB8;
	Sat, 27 Sep 2025 02:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UQjsXL9h"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E1045C0B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 02:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758940760; cv=none; b=NJvZAbPeokvN/0LgUrz2a9z4xPQCPsw+7LOESuGjI9GwannPvGrzzQbMEY0Zy8JTFkaUnc/Py+1LgpBNCN09FMOUHfjYAUksc/Hv1PjwvLMpMfg0ZXuM98yuy0ISzh0/qnfmpNvsEuCT2NkEveX83oj1WsOzeww7obB22vrPqvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758940760; c=relaxed/simple;
	bh=scG9pplp01I6YSKouxM/l3n/5lfAncL1ZSBHouiOZ/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Cj2Sx62JrLe0dIUk+Rsm4pbOw7vm2b868++wCeJG5P7jeUK1z2cH8G0kf18w7GC5F4YzKUVSR0CvmqylPMj2CMur9g2KWYeQEO8/Wkefcxi6p+ki/iZ91h2s7PyVCZdAwZaA5YT0xcJPQfjSJyEtagY3YsGMUUn3a/WeafIyOIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UQjsXL9h; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3ae5cbea-d320-4d28-a894-5e11e048158f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758940755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8AE0EMzqHb/3HJuPI7UiqokGi0gSWVZfZYrdqV2qYM=;
	b=UQjsXL9hvdE/v3XugRpcyr+I5P81hxwTX/Ae0v4/7YD/uZ3KB+9fsxoOl1VWIW7c4k72Lk
	5v764EvLSxkF6QC81LuAdfr1A2MkP5T67w71ukZhdP2IGFbEg6EeKlQrU1X/jO4PqTu4Dw
	5YHVFCDSQul5K7Q6o9dYSqSufnPDVmg=
Date: Sat, 27 Sep 2025 10:39:08 +0800
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
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
 joel.granados@kernel.org, feng.tang@linux.alibaba.com, pauld@redhat.com,
 kees@kernel.org, rostedt@goodmis.org, pawan.kumar.gupta@linux.intel.com,
 akpm@linux-foundation.org, dave.hansen@linux.intel.com, mingo@kernel.org,
 paulmck@kernel.org, corbet@lwn.net, mhiramat@kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250925060605.2659-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/25 14:06, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Currently, when hung_task_panic is enabled, kernel will panic immediately
> upon detecting the first hung task. However, some hung tasks are transient
> and the system can recover fully, while others are unrecoverable and
> trigger consecutive hung task reports, and a panic is expected.
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

Hmm... the documentation here seems a bit misleading.

hung_task_panic=1 will always cause an immediate panic, regardless of
the hung_task_count_to_panic setting, right?

Perhaps something like this would be more accurate?

```
hung_task_count_to_panic
========================

When set to a non-zero value, a kernel panic will be triggered if
the number of detected hung tasks reaches this value.

Note that setting hung_task_panic=1 will still cause an immediate
panic on the first hung task, overriding this setting.
```

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

Nit: while static variables are guaranteed to be zero-initialized, it's
a good practice and clearer for readers to initialize them explicitly.

static unsigned int __read_mostly sysctl_hung_task_count_to_panic = 0;


Otherwise, this patch looks good to me!
Acked-by: Lance Yang <lance.yang@linux.dev>

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


