Return-Path: <linux-kernel+bounces-877422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0346C1E140
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D6C034D1A0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64902E6CAD;
	Thu, 30 Oct 2025 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="s+0oU0Ni"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13532E4274
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761789591; cv=none; b=Lbn9QaCjRMxmQAi7vIFxCCNhVCQAQs+fFVeK2KMlT6n1JDa261OwlbT9Ap9JoshBDGjyc5xx96uxXgvM94K5hR2d0pSkXREbXgvgZz0pHvDC8rVDbMMJT68DdlQGalkGEEm6Eod+zT93E/jd5TQjUtIhCH190QQtbRzI7GXt+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761789591; c=relaxed/simple;
	bh=qHgkJEoo9vKbt8bJwNliKNRAJvcjE4nFUuPvCoiouPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yzhg8Uklr2baU3VHCS1vV870C4MjjdhJ9YVHR3ePHERUYIq7kCBv5lgl2o5TKgwdunirMkm1941NYTsdljkJrp6Vqcd8y7WmXgMaiv52A5HUw8/rVXcCWJMX0uxRJt+WrkZCAP5opSJYYcI6/bp+mAfgJfLFy7W4RyMW2V/3lc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=s+0oU0Ni; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761789579; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Ml0yY3472o5Ybqsrj9t3E0TSOTI/vlBi/P/JSeFDAKM=;
	b=s+0oU0Nixi/HcIk9vSsY5SkgR/uuklpkF5xsKtur5gs376QMpIKmMrNM4msYOFggstJ/1GyeEjh17sOYfJOr4RM42vNwdV67l1BrfcAl6gyYeUOiBhorf29aC3FpcgSWoVx4h9NN/gQoU/IhOFtDiqxeEWq7mNQV4ykd2w7xOpc=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WrHtajt_1761789578 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Oct 2025 09:59:38 +0800
Date: Thu, 30 Oct 2025 09:59:35 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 2/6] panic: sys_info: Align constant definition names
 with parameters
Message-ID: <aQLGhzh9UOYNM-V7@U-2FWC9VHC-2323.local>
References: <20251029111202.3217870-2-andriy.shevchenko@linux.intel.com>
 <20251029111202.3217870-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029111202.3217870-4-andriy.shevchenko@linux.intel.com>

On Wed, Oct 29, 2025 at 12:07:37PM +0100, Andy Shevchenko wrote:
> Align constant definition names with parameters to make it easier
> to map. It's also better to maintain and extend the names while
> keeping their uniqueness.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>

Thanks,
Feng

>
> ---
>  include/linux/sys_info.h | 2 +-
>  kernel/panic.c           | 2 +-
>  lib/sys_info.c           | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sys_info.h b/include/linux/sys_info.h
> index 89d77dc4f2ed..a5bc3ea3d44b 100644
> --- a/include/linux/sys_info.h
> +++ b/include/linux/sys_info.h
> @@ -14,7 +14,7 @@
>  #define SYS_INFO_LOCKS			0x00000008
>  #define SYS_INFO_FTRACE			0x00000010
>  #define SYS_INFO_PANIC_CONSOLE_REPLAY	0x00000020
> -#define SYS_INFO_ALL_CPU_BT		0x00000040
> +#define SYS_INFO_ALL_BT			0x00000040
>  #define SYS_INFO_BLOCKED_TASKS		0x00000080
>  
>  void sys_info(unsigned long si_mask);
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 341c66948dcb..0d52210a9e2b 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -401,7 +401,7 @@ static void panic_trigger_all_cpu_backtrace(void)
>   */
>  static void panic_other_cpus_shutdown(bool crash_kexec)
>  {
> -	if (panic_print & SYS_INFO_ALL_CPU_BT)
> +	if (panic_print & SYS_INFO_ALL_BT)
>  		panic_trigger_all_cpu_backtrace();
>  
>  	/*
> diff --git a/lib/sys_info.c b/lib/sys_info.c
> index d542a024406a..6b0188b30227 100644
> --- a/lib/sys_info.c
> +++ b/lib/sys_info.c
> @@ -23,7 +23,7 @@ static const struct sys_info_name  si_names[] = {
>  	{ SYS_INFO_TIMERS,		"timers" },
>  	{ SYS_INFO_LOCKS,		"locks" },
>  	{ SYS_INFO_FTRACE,		"ftrace" },
> -	{ SYS_INFO_ALL_CPU_BT,		"all_bt" },
> +	{ SYS_INFO_ALL_BT,		"all_bt" },
>  	{ SYS_INFO_BLOCKED_TASKS,	"blocked_tasks" },
>  };
>  
> @@ -118,7 +118,7 @@ void sys_info(unsigned long si_mask)
>  	if (si_mask & SYS_INFO_FTRACE)
>  		ftrace_dump(DUMP_ALL);
>  
> -	if (si_mask & SYS_INFO_ALL_CPU_BT)
> +	if (si_mask & SYS_INFO_ALL_BT)
>  		trigger_all_cpu_backtrace();
>  
>  	if (si_mask & SYS_INFO_BLOCKED_TASKS)
> -- 
> 2.50.1

