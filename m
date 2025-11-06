Return-Path: <linux-kernel+bounces-887729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E488C38F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 04:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B7F54E478A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 03:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB67A2BE65E;
	Thu,  6 Nov 2025 03:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vOy/b4V2"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C438F7D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 03:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762399705; cv=none; b=gFarQCoJEMaN716vAdvVDi3AoM9YyMm/15JLoQY0rMvu/WVJexE9yY7+7+80toCQ9oS1e25y8njkUkihKm7kED8U0J6i7szDlIaP8+Z51tqA1vTahxCZfmTBTxGjNeaDG1uyLhA3BSPIf96awmxXCjOjLeDrvr0bdONt/iV/tAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762399705; c=relaxed/simple;
	bh=ygGhAEsm/DgacE9ed4AT5iPZd8bo6QYT56nuwSGU6ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=cuU8OzfR3XE3S2q7ObIetwSobmv15PT8aizkE9CCaj9KYkl8Nia/CdIRQxFA6wAS1y3Cl6xPDpuhEzF6Pm042Fn9wU5PU/3z9TT1RVagsCpnoxcZxtyXovo9jrfopKtkuopl/N5vNHJVfIxJTcYbfWdqVAiESUfRTFzCg9TFa2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vOy/b4V2; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <572e1211-79e2-4b8e-b36f-4eeca125427c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762399700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VOHOPn4QCB15dSJZ7+b8x1PMPq/q4Gg0i4DM3Y+iQWc=;
	b=vOy/b4V28O0kz32IbysxSJJGwYOJAQFtdJAvPF+QqykarGcP4qtCC7agZFjeRpUfzbk4Mw
	Zaq+gh5G7rtgtoyKyh3q2mykyC9CiymWWpu1Y9tNdsXPPxulntTDXtaW+XIfs/7mIa+voG
	+T+N/4zUOrHqIt2ZL5IIa6u9D2mKNTA=
Date: Thu, 6 Nov 2025 11:28:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] hung_task: Add hung_task_sys_info sysctl to dump sys
 info on task-hung
To: Feng Tang <feng.tang@linux.alibaba.com>
References: <20251106023032.25875-1-feng.tang@linux.alibaba.com>
 <20251106023032.25875-3-feng.tang@linux.alibaba.com>
Content-Language: en-US
Cc: paulmck@kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Lance Yang <ioworker0@gmail.com>,
 Petr Mladek <pmladek@suse.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251106023032.25875-3-feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/6 10:30, Feng Tang wrote:
> When task-hung happens, developers may need different kinds of system
> information (call-stacks, memory info, locks, etc.) to help debugging.
> 
> Add 'hung_task_sys_info' sysctl knob to take human readable string like
> "tasks,mem,timers,locks,ftrace,...", and when task-hung happens, all
> requested information will be dumped. (refer kernel/sys_info.c for more
> details).
> 
> Meanwhile, the newly introduced sys_info() call is used to unify some
> existing info-dumping knobs.

Thanks! Just one nit below.

> 
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> ---
>   Documentation/admin-guide/sysctl/kernel.rst |  5 +++
>   kernel/hung_task.c                          | 39 +++++++++++++++------
>   2 files changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index a397eeccaea7..45b4408dad31 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -422,6 +422,11 @@ the system boot.
>   
>   This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
>   
> +hung_task_sys_info
> +==================
> +A comma separated list of extra system information to be dumped when
> +hung task is detected, for example, "tasks,mem,timers,locks,...".
> +Refer 'panic_sys_info' section below for more details.
>   
>   hung_task_timeout_secs
>   ======================
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 84b4b049faa5..102be5a8e75a 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -24,6 +24,7 @@
>   #include <linux/sched/sysctl.h>
>   #include <linux/hung_task.h>
>   #include <linux/rwsem.h>
> +#include <linux/sys_info.h>
>   
>   #include <trace/events/sched.h>
>   
> @@ -60,12 +61,23 @@ static unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
>   static int __read_mostly sysctl_hung_task_warnings = 10;
>   
>   static int __read_mostly did_panic;
> -static bool hung_task_show_lock;
>   static bool hung_task_call_panic;
> -static bool hung_task_show_all_bt;
>   
>   static struct task_struct *watchdog_task;
>   
> +/*
> + * A bitmask to control what kinds of system info to be printed when
> + * a hung task is detected, it could be task, memory, lock etc. Refer
> + * include/linux/sys_info.h for detailed bit definition.
> + */
> +static unsigned long hung_task_si_mask;
> +
> +/*
> + * There are several sysctl knobs, and this serves as the runtime
> + * effective sys_info knob
> + */

Nit: let's make the comment for cur_si_mask even more explicit.
+/*
+ * The effective sys_info mask for the current detection cycle. It
+ * aggregates the base hung_task_si_mask and any flags triggered
+ * by other conditions within this cycle. It is cleared after use.
+ */
> +static unsigned long cur_si_mask;

That makes its lifecycle (aggregate, use, and clear) super obvious ;)

With that, LGTM!

Reviewed-by: Lance Yang <lance.yang@linux.dev>

[...]

