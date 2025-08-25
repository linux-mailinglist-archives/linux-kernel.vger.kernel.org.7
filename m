Return-Path: <linux-kernel+bounces-783844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F9BB3336E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73DB67ADFB2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 01:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467B918A6AD;
	Mon, 25 Aug 2025 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tiGwmXPo"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB5C393DD1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756083713; cv=none; b=Eu26i+F7Q1wvDteZzQHIM19oxUI++abGykxpL8+3R68RniISI7WoRaxi1QSmeHx8rkgv4Ag/ebqA3I19uQ4QI42XQjjy4xXxJNzxWTdE9jZLWtrNu2p5oIHDLZsUruLNpZJC7zLNIE5iGqRdhZtHENjQ7iIQBJerpOk7qWwEl6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756083713; c=relaxed/simple;
	bh=qzvjptTdbu1HRrNm17uglIEKW/C3ojiHltnOpJd8zPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5Chuna8+DyzPnE7rLM1QWrNJYlxZU2jYtpAaru/zliWAeWVqC4K/b6ifUqy1K7PyHRYC9AANYU+wFn9kq0jGu/QNagLs33cHiHdtLbsnFEhODnuO7kkfMmUvgMZ0LKkv+2r67CFzIFdaTzIvKQ5/OsRJkbRVGi244xE1GQMzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tiGwmXPo; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756083703; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=hT7fyki4cRVVgwQPXO+m+tGFXjnan9mDi20ca9rK7Dw=;
	b=tiGwmXPoXYeNquWUg+tYm5AfvUfsiaJzVZYUNwdf/hvBsxl53vHPvmdIGNNeyl/QzornbqzQw+LYqH/bf1QJ0XvGWoY/k4gcPbO/AAYR69LMIVvTNGY3Xqv+OpqDGxzs2RRaMcCd3a+jU9uFXrA5PEWTOJJsNeO9f72QEgFLfac=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WmPcp-O_1756083701 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 Aug 2025 09:01:42 +0800
Date: Mon, 25 Aug 2025 09:01:41 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Lance Yang <lance.yang@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	paulmck@kernel.org, john.ogness@linutronix.de,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] panic: Clean up message about deprecated
 'panic_print' parameter
Message-ID: <aKu19RZ4tffb8eNC@U-2FWC9VHC-2323.local>
References: <aKRJKZHgcxyNF3y7@pathway.suse.cz>
 <202508200907.PsZ3geub-lkp@intel.com>
 <ae9bb2ea-c6e5-4a4b-ae25-aea1d6fe084d@linux.dev>
 <33a897b4-7d9a-4641-9c7a-07c19bb9cb6f@linux.dev>
 <7a34da58-874d-4271-9dbb-7991468d58ff@linux.dev>
 <aKWWcPOf9qPIoCe4@pathway.suse.cz>
 <aKWYELPjbhC7R8NO@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aKWYELPjbhC7R8NO@pathway.suse.cz>

On Wed, Aug 20, 2025 at 11:40:32AM +0200, Petr Mladek wrote:
> Remove duplication of the message about deprecated 'panic_print'
> parameter.
> 
> Also make the wording more direct. Make it clear that the new
> parameters already exist and should be used instead.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Thanks for the cleanup!

Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>

> ---
> Changes since v1:
> 
>   - fixed compilation with CONFIG_SYSCTL disabled (kernel test
>     robot <lkp@intel.com>)
> 
> Thanks Lance Yang <lance.yang@linux.dev> for debugging the compilation
> error reported by the test robot.
> 
>  kernel/panic.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 12a10e17ab4a..24bca263f896 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -77,6 +77,11 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
>  
>  EXPORT_SYMBOL(panic_notifier_list);
>  
> +static void panic_print_deprecated(void)
> +{
> +	pr_info_once("Kernel: The 'panic_print' parameter is now deprecated. Please use 'panic_sys_info' and 'panic_console_replay' instead.\n");
> +}
> +
>  #ifdef CONFIG_SYSCTL
>  
>  /*
> @@ -125,7 +130,7 @@ static int proc_taint(const struct ctl_table *table, int write,
>  static int sysctl_panic_print_handler(const struct ctl_table *table, int write,
>  			   void *buffer, size_t *lenp, loff_t *ppos)
>  {
> -	pr_info_once("Kernel: 'panic_print' sysctl interface will be obsoleted by both 'panic_sys_info' and 'panic_console_replay'\n");
> +	panic_print_deprecated();
>  	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
>  }
>  
> @@ -944,13 +949,13 @@ core_param(panic_console_replay, panic_console_replay, bool, 0644);
>  
>  static int panic_print_set(const char *val, const struct kernel_param *kp)
>  {
> -	pr_info_once("Kernel: 'panic_print' parameter will be obsoleted by both 'panic_sys_info' and 'panic_console_replay'\n");
> +	panic_print_deprecated();
>  	return  param_set_ulong(val, kp);
>  }
>  
>  static int panic_print_get(char *val, const struct kernel_param *kp)
>  {
> -	pr_info_once("Kernel: 'panic_print' parameter will be obsoleted by both 'panic_sys_info' and 'panic_console_replay'\n");
> +	panic_print_deprecated();
>  	return  param_get_ulong(val, kp);
>  }
>  
> -- 
> 2.50.1

