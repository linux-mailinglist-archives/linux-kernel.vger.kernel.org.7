Return-Path: <linux-kernel+bounces-727832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A16B4B02050
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31F016F53E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997972D3A96;
	Fri, 11 Jul 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Uwan/YWz"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20CC1552E0
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752247289; cv=none; b=iAzrFmt/6WocgwIbY5TaRROuUM/kgzeCTtgbEkV0rHH7MIlqJaG8jzi0wwD3XpqYF7Vrdy9cYwiuK+U7GbTrTl0C+LCSasEiaagYFr1KqaDl93hNJ6I4KnJC9/wF7u89deShlCGfr9JvR4Mpf+69DvThuiB1v52T8IfpbX4t+wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752247289; c=relaxed/simple;
	bh=ttegLe5CbjHZzHGO7O3sgSWBCbluX12t1TAaXmpb4II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z63F5lp+hhKrL6OF/6I4dL9CnOPxkH0E38eGW07jxibgZqYTmLLyL7r89OYoQxmuxJa/FEXL2Oc255QHYOi87piDB2pcUHeCI12pXvxMlL300itfcvR6jjHavefLV/FQSAtQCwMbA+ZiiDTCfVb7lCNyDLOjQGRJW53aOjwXVP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Uwan/YWz; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752247283; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=i8e/LESHClpCq8gviFl2Lvhf3xC5XTdq2yrcuM5BlX4=;
	b=Uwan/YWzL2zXKJlIasPB3CB6JBCVGkSvJGhcdBu3FAPdNXu9kUSj/0bssGmZPeE8UxusQRlXfoUaws9dFskk5MGiSUUW3ttbK++PnDNSr//pWuEK2ReB/2Sxjf+0h32SkBIdeCFTEXo/MqXqI4vZtjMascbeZxtzuszQzXXmJL4=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WihP-DC_1752247281 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Jul 2025 23:21:22 +0800
Date: Fri, 11 Jul 2025 23:21:20 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v1 4/7] panic: sys_info: Replace struct sys_info_name
 with plain array of strings
Message-ID: <aHEr8NO4xHGPNjJo@U-2FWC9VHC-2323.local>
References: <20250711095413.1472448-1-andriy.shevchenko@linux.intel.com>
 <20250711095413.1472448-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250711095413.1472448-5-andriy.shevchenko@linux.intel.com>

On Fri, Jul 11, 2025 at 12:51:10PM +0300, Andy Shevchenko wrote:
> There is no need to keep a custom structure just for the need of
> a plain array of strings. Replace struct sys_info_name with plain
> array of strings.
> 
> With that done, simplify the code, in particular, naturally use
> for_each_set_bit() when iterating over si_bits_global bitmap.

My earlier reply seems to get lost, so I'll resend. (Please ignore this
if your alreay received the reply to 4/7 patch.)

IIUC, this will not work.

Actually there is a hole in the bitmap definition:

#define SYS_INFO_PANIC_CONSOLE_REPLAY	0x00000020

Ad Petr pointed in his review, it's only for panic use, that's why
we make it invisible in sys_info.c. Eventually, we plan to deprecate
'panic_print', and use 'panic_sys_info' and 'panic_console_replay' to
replace it. After that happens that user only see string interface,
we can change these bitmap definition and remove the hole, and use
your cleanup here.

Thanks,
Feng

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/sys_info.c | 47 ++++++++++++++++++++---------------------------
>  1 file changed, 20 insertions(+), 27 deletions(-)
> 
> diff --git a/lib/sys_info.c b/lib/sys_info.c
> index 5d98560f3f53..7965984c6d67 100644
> --- a/lib/sys_info.c
> +++ b/lib/sys_info.c
> @@ -1,30 +1,28 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#include <linux/sched/debug.h>
> +#include <linux/bitops.h>
>  #include <linux/console.h>
> +#include <linux/log2.h>
>  #include <linux/kernel.h>
>  #include <linux/ftrace.h>
> -#include <linux/sysctl.h>
>  #include <linux/nmi.h>
> +#include <linux/sched/debug.h>
> +#include <linux/string.h>
> +#include <linux/sysctl.h>
>  
>  #include <linux/sys_info.h>
>  
> -struct sys_info_name {
> -	unsigned long bit;
> -	const char *name;
> -};
> -
>  /*
>   * When 'si_names' gets updated,  please make sure the 'sys_info_avail'
>   * below is updated accordingly.
>   */
> -static const struct sys_info_name  si_names[] = {
> -	{ SYS_INFO_TASKS,		"tasks" },
> -	{ SYS_INFO_MEM,			"mem" },
> -	{ SYS_INFO_TIMERS,		"timers" },
> -	{ SYS_INFO_LOCKS,		"locks" },
> -	{ SYS_INFO_FTRACE,		"ftrace" },
> -	{ SYS_INFO_ALL_BT,		"all_bt" },
> -	{ SYS_INFO_BLOCKED_TASKS,	"blocked_tasks" },
> +static const char * const si_names[] = {
> +	[ilog2(SYS_INFO_TASKS)]		= "tasks",
> +	[ilog2(SYS_INFO_MEM)]		= "mem",
> +	[ilog2(SYS_INFO_TIMERS)]	= "timers",
> +	[ilog2(SYS_INFO_LOCKS)]		= "locks",
> +	[ilog2(SYS_INFO_FTRACE)]	= "ftrace",
> +	[ilog2(SYS_INFO_ALL_BT)]	= "all_bt",
> +	[ilog2(SYS_INFO_BLOCKED_TASKS)]	= "blocked_tasks",
>  };
>  
>  /* Expecting string like "xxx_sys_info=tasks,mem,timers,locks,ftrace,..." */
> @@ -36,12 +34,9 @@ unsigned long sys_info_parse_param(char *str)
>  
>  	s = str;
>  	while ((name = strsep(&s, ",")) && *name) {
> -		for (i = 0; i < ARRAY_SIZE(si_names); i++) {
> -			if (!strcmp(name, si_names[i].name)) {
> -				si_bits |= si_names[i].bit;
> -				break;
> -			}
> -		}
> +		i = match_string(si_names, ARRAY_SIZE(si_names), name);
> +		if (i >= 0)
> +			__set_bit(i, &si_bits);
>  	}
>  
>  	return si_bits;
> @@ -84,12 +79,10 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
>  		/* The access to the global value is not synchronized. */
>  		si_bits = READ_ONCE(*si_bits_global);
>  
> -		for (i = 0; i < ARRAY_SIZE(si_names); i++) {
> -			if (si_bits & si_names[i].bit) {
> -				len += scnprintf(names + len, sizeof(names) - len,
> -					"%s%s", delim, si_names[i].name);
> -				delim = ",";
> -			}
> +		for_each_set_bit(i, &si_bits, ARRAY_SIZE(si_names)) {
> +			len += scnprintf(names + len, sizeof(names) - len,
> +					 "%s%s", delim, si_names[i]);
> +			delim = ",";
>  		}
>  
>  		table = *ro_table;
> -- 
> 2.47.2

