Return-Path: <linux-kernel+bounces-835258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8935BA6987
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834B33BC272
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ED1299A94;
	Sun, 28 Sep 2025 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bRcSsaKr"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF76D22FE02
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759042572; cv=none; b=DtZsqIXNVrOunX1SxvjprEHMxLziDJd8far3g2/NFkDLx2ytFhO7///F4Pr8wKpXU9j0tedLoSSe+D/HK+t55NiAS31ytqHehI+DfPF6JzOZvTBaZjLY/fD2I3RWcMK4wlwduj6YtntnCp/KNPfR0mCTJ+EBYLXIPaoXSPljv7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759042572; c=relaxed/simple;
	bh=v/jxQ03CMnyAoLhNERZdyWhwcc3q87yNM7rXLSjZOco=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Xc+E/QYofki4UYcsbwRVUL5ZaM8Kz++hAFrXuAl7Pn2CggLpeP2TkWBi0kCspx17/g8dtXDcs6TX4C/I1he9pR8os2a2fwRUhh6Cq824v7+cRd+isGO2PDqEFRW7iwlc0xhIF0S0O6eY/tKf+T3Wi8J3AxR9cwU4ctZx7DCd2Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bRcSsaKr; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3c44a757-f823-4671-b3d5-548fe04e52e3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759042557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VuydFKA9AN/BAvt5T3Qq3i+P5df99gQQUA7oFByoAi8=;
	b=bRcSsaKr7+h/zTv9KO06FkBOG9gbnERtynGf1cvFcbzSa/zbxIdFT76hn+vcPA0M94G3a3
	pzKJRFGqiDRzcrUMh6ReBmB5a0enb9fOGwN6Tpioyc15kCWBOu0L9S5CFUbpvGfocqxqQr
	1WQ5eB1PG8FKjWYUpynxq9PxqTKUyZo=
Date: Sun, 28 Sep 2025 14:55:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][v2] hung_task: Panic after fixed number of hung tasks
Content-Language: en-US
To: lirongqing <lirongqing@baidu.com>
References: <20250928053137.3412-1-lirongqing@baidu.com>
Cc: corbet@lwn.net, mingo@kernel.org, pauld@redhat.com,
 joel.granados@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, dave.hansen@linux.intel.com,
 akpm@linux-foundation.org, feng.tang@linux.alibaba.com, kees@kernel.org,
 mhiramat@kernel.org, paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
 rostedt@goodmis.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250928053137.3412-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hey Li,

On 2025/9/28 13:31, lirongqing wrote:
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
> Acked-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---

It's working as expect. So:
Tested-by: Lance Yang <lance.yang@linux.dev>

But on second thought: regarding this new sysctl parameter, I was wondering
if a name like max_hung_task_count_to_panic might be a bit more explicit,
just to follow the convention from max_rcu_stall_to_panic.

No strong opinion on this, though :)

Cheers,
Lance

> Diff with v1: change documentation as Lance suggested
> 
>   Documentation/admin-guide/sysctl/kernel.rst |  8 ++++++++
>   kernel/hung_task.c                          | 14 +++++++++++++-
>   2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 8b49eab..98b47a7 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -405,6 +405,14 @@ This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
>   1 Panic immediately.
>   = =================================================
>   
> +hung_task_count_to_panic
> +=====================
> +
> +When set to a non-zero value, a kernel panic will be triggered if the
> +number of detected hung tasks reaches this value.
> +
> +Note that setting hung_task_panic=1 will still cause an immediate panic
> +on the first hung task.
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


