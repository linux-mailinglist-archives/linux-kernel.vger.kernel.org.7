Return-Path: <linux-kernel+bounces-726795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15599B0115B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D9A4881F8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 02:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECEF157E6B;
	Fri, 11 Jul 2025 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uy6x9FWA"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CD210E9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 02:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752202122; cv=none; b=A9rAm8g/cK62yxMdUwVSuta6/8kxZOa1hGQf+XUOVg7ddqMaopnmYJqjMIr6H08CFcIv5eClGqnlKFnwp1s3vXVC9+zCXkbhsfipw5bq1v27Cq7In3mLO87SAKF8P7x/+KsLBmLWATNx3gwLRRdpX7QqqANEOp1nI0AAN7vObFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752202122; c=relaxed/simple;
	bh=jP/J7vWHv7N+brwiaopmYpmF9BfJIn1E1i+4cetS7Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xkcdk+trOOG3tHlHcxbVqBpJ+F8tGR/J3vIRqspf9oHeeco3h3wYCIb0zNWze5/7HLRmYiJ4MSWpUPeaomxVGBMxGTH75bw3A4EKVOVBYa6qes8WBT3j4AI47gPT90/p/sIvXLePnBqyvp3FlSx7z3RPbInqThN+PUg8TGQThQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uy6x9FWA; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752202110; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=UCCNYztx9T1d42FdTHtF/Z61Cuws050+HHs6h4WWS/0=;
	b=uy6x9FWARLbKqyFwVw/g8B2E0sD6gJQKyKF1fK150r2bAS77ju/R5tzv4ntkV730JXgy1ojYfovFJIKXQJjnUoJAjipih1OflfgKVA5JgCDb0pcTyc/DRUbCWnXIv5/bcpKGWYy5biv+U3WQPv4YyNWvu7NVnfimzCukw7JsjKQ=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WifCw-._1752202109 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Jul 2025 10:48:30 +0800
Date: Fri, 11 Jul 2025 10:48:29 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v1 1/1] panic: Fix compilation error (`make W=1`)
Message-ID: <aHB7fV7QgNp8Fre4@U-2FWC9VHC-2323.local>
References: <20250710094816.771656-1-andriy.shevchenko@linux.intel.com>
 <20250710150133.680679cf8a0f6b2f0bf3369f@linux-foundation.org>
 <aHBgwRrFfmEWcp-T@U-2FWC9VHC-2323.local>
 <20250711014947.GA863150@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250711014947.GA863150@ax162>

On Thu, Jul 10, 2025 at 06:49:47PM -0700, Nathan Chancellor wrote:
> On Fri, Jul 11, 2025 at 08:54:25AM +0800, Feng Tang wrote:
> > On Thu, Jul 10, 2025 at 03:01:33PM -0700, Andrew Morton wrote:
> > > On Thu, 10 Jul 2025 12:48:16 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > 
> > > > Compiler is not happy about the recently added code:
> > > > 
> > > > lib/sys_info.c:52:19: error: variable 'sys_info_avail' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> > > >    52 | static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
> > > >       |                   ^~~~~~~~~~~~~~
> > > > 
> > > > Fix it in the same way how, for example, lib/vsprintf.c does in the similar
> > > > cases, i.e. by using string literal directly as sizeof() parameter.
> > > > 
> > > > ...
> > > >
> > > 
> > > > --- a/lib/sys_info.c
> > > > +++ b/lib/sys_info.c
> > > > @@ -49,13 +49,11 @@ unsigned long sys_info_parse_param(char *str)
> > > >  
> > > >  #ifdef CONFIG_SYSCTL
> > > >  
> > > > -static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
> > > > -
> > > >  int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
> > > >  					  void *buffer, size_t *lenp,
> > > >  					  loff_t *ppos)
> > > >  {
> > > > -	char names[sizeof(sys_info_avail) + 1];
> > > > +	char names[sizeof("tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks") + 1];
> > > >  	struct ctl_table table;
> > > >  	unsigned long *si_bits_global;
> > > >  
> > > 
> > > Yes, that's neater than the fix we currently have.  I'll grab, thanks.
> > 
> > Hi Andrew, Andy,
> > 
> > sys_info_avail[] has another purpose for being a counterpart of si_names[],
> > which could be extended in future, so we make it obviously stand-alone. As
> > for definition of si_names[], we explicitly added comment:  
> > 
> > 	/*
> > 	 * When 'si_names' gets updated,  please make sure the 'sys_info_avail'
> > 	 * below is updated accordingly.
> > 	 */
> > 	static const struct sys_info_name  si_names[] = {
> > 		{ SYS_INFO_TASKS,		"tasks" },
> > 		{ SYS_INFO_MEM,			"mem" },
> > 		
> > which has also been discussed in another thread:
> > https://lore.kernel.org/lkml/aG3o2RFHc5iXnJef@U-2FWC9VHC-2323.local/
> > 
> > And I suggest to keep sys_info_avail[], and either Nathan or Sergey's patch
> > works for me.
> 
> We could do something like this to keep the sizeof() obvious and
> separate, while still eliminating the variable? Happy to bike shed
> aspects of it like the macro name and such.
> 
> diff --git a/lib/sys_info.c b/lib/sys_info.c
> index 46d6f4f1ad2a..c1df502a2c0d 100644
> --- a/lib/sys_info.c
> +++ b/lib/sys_info.c
> @@ -14,7 +14,7 @@ struct sys_info_name {
>  };
>  
>  /*
> - * When 'si_names' gets updated,  please make sure the 'sys_info_avail'
> + * When 'si_names' gets updated,  please make sure SYS_INFO_MAX_LEN
>   * below is updated accordingly.
>   */
>  static const struct sys_info_name  si_names[] = {
> @@ -49,13 +49,13 @@ unsigned long sys_info_parse_param(char *str)
>  
>  #ifdef CONFIG_SYSCTL
>  
> -static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
> +#define SYS_INFO_MAX_LEN (sizeof("tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks") + 1)
>  
>  int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
>  					  void *buffer, size_t *lenp,
>  					  loff_t *ppos)
>  {
> -	char names[sizeof(sys_info_avail) + 1];
> +	char names[SYS_INFO_MAX_LEN];
>  	struct ctl_table table;
>  	unsigned long *si_bits_global;
  
Looks great to me, thanks!

We can even move the SYS_INFO_MAX_LEN definition close to si_names[],
initially sys_info_avail[] was next to si_names[], and was moved inside 
"#ifdef CONFIG_SYSCTL" region for compiling CONFIG_SYSCTL=n case.

> ---
> 
> > Sorry for the inconvenience, and I should upgrade my gcc :) 
> 
> I am not sure that GCC has this warning, I have only ever seen it with
> clang.

Got it.

Thanks,
Feng

