Return-Path: <linux-kernel+bounces-877426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7E5C1E164
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CFCA4E0EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377982F3C2C;
	Thu, 30 Oct 2025 02:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tdl4MIBT"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A72DC330
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761789717; cv=none; b=cxpFfS9/q3TpoLGg47l+FXRujRIM0rKeRTX9pCm4S3XmvrXBwNX8pNsE9Q+TTNA1Z2D8t03BOUVDj1oFPJkJWJpyEKokG8ssT81+nSz4Lp6qYXLSnNVZRlZYBhOlS//JSB8oHyNHR9Mmu04aIMAVH7pNlly0JUdzdYscMdS5kOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761789717; c=relaxed/simple;
	bh=FjmgpbGbIBRF90WtCLcfeoKlRq6Ivil82tkfy88Ri+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXelPdruyGk7DLCWmkTaxTuKN2gBuK1DyC4N41/9o1jzTh7c7wwVIZdCl4M4fmu3ZOnuq53y3fruHGBVk042JvIuBUsSo0fTok5vC8XOLH9FphPb5pd+53kWF463ZjGuu/7xIuSss2nR5Qg6hZ+guvGzGadsaid5YW/ZWeM/BZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tdl4MIBT; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761789712; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=ONa2JnyxwGemGd98bSqEDy54P4iqcrdypXOgt0YKdaY=;
	b=tdl4MIBToNJsJI/KoN0Zvyzc+iPDj0itXItyfKt9Q32yJtSv5EBm8opGGGcBw5K/8LsIuq6p6CzqfJi7WguRP931kYXGbAKzxyA1qCOg6nnC6CTFFloG+F/m1eIT+qKdxw7Z/ydo0kKyoZavsjmLyLyEoDmn3dV4uqvB1D5yYZA=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WrHtbr._1761789711 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Oct 2025 10:01:51 +0800
Date: Thu, 30 Oct 2025 10:01:49 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 3/6] panic: sys_info: Replace struct sys_info_name
 with plain array of strings
Message-ID: <aQLHDaIqkMQTJHTT@U-2FWC9VHC-2323.local>
References: <20251029111202.3217870-2-andriy.shevchenko@linux.intel.com>
 <20251029111202.3217870-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029111202.3217870-5-andriy.shevchenko@linux.intel.com>

On Wed, Oct 29, 2025 at 12:07:38PM +0100, Andy Shevchenko wrote:
> There is no need to keep a custom structure just for the need of
> a plain array of strings. Replace struct sys_info_name with plain
> array of strings.
> 
> With that done, simplify the code, in particular, naturally use
> for_each_set_bit() when iterating over si_bits_global bitmap.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/sys_info.c | 48 +++++++++++++++++++++---------------------------
>  1 file changed, 21 insertions(+), 27 deletions(-)
> 
> diff --git a/lib/sys_info.c b/lib/sys_info.c
> index 6b0188b30227..5aecf4b6025f 100644
> --- a/lib/sys_info.c
> +++ b/lib/sys_info.c
> @@ -1,30 +1,29 @@
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
> +	[ilog2(SYS_INFO_TASKS)]			= "tasks",
> +	[ilog2(SYS_INFO_MEM)]			= "mem",
> +	[ilog2(SYS_INFO_TIMERS)]		= "timers",
> +	[ilog2(SYS_INFO_LOCKS)]			= "locks",
> +	[ilog2(SYS_INFO_FTRACE)]		= "ftrace",
> +	[ilog2(SYS_INFO_PANIC_CONSOLE_REPLAY)]	= "",
> +	[ilog2(SYS_INFO_ALL_BT)]		= "all_bt",
> +	[ilog2(SYS_INFO_BLOCKED_TASKS)]		= "blocked_tasks",
>  };
>  
>  /* Expecting string like "xxx_sys_info=tasks,mem,timers,locks,ftrace,..." */
> @@ -36,12 +35,9 @@ unsigned long sys_info_parse_param(char *str)
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
> @@ -85,12 +81,10 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
>  		si_bits = READ_ONCE(*si_bits_global);
>  
>  		names[0] = '\0';
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

For SYS_INFO_PANIC_CONSOLE_REPLAY bit, it is a NULL string, no need for
an extra ','?

Thanks,
Feng

