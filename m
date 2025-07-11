Return-Path: <linux-kernel+bounces-726730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A41EAB0107A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 02:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28D57660C4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8479345948;
	Fri, 11 Jul 2025 00:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RWQ5NCWS"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D753A1CD
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195273; cv=none; b=QcrxE0B2rNfQ5YlR+LKkNqS1juug07ylU+8DcgjiVsg/OI1cUbR9MhABrU7553SHVpitLx8ReZDE5qJUjq/5Wxn7duxSp+qWKQzQ81zowF9U2xjH511k3hQh5TOU8aj5K7ll4ygxJl2xUSG0b3qtAH/pkQdmZ74oMWJtfU8BDQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195273; c=relaxed/simple;
	bh=E4En0poOPpFUsuWkC3GC6ndoQPZT/ojJMPEI798QACc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0s+mjtY0mAJWnxE//xPS9vPBCp5w4zS9JZGP3mpTXNTcXLMT24VERoi2VMQseF79c+yLmamgTJl4VH3AtPEtnViMwoIwIdynj3+m+D5RL+48dy+UEA0J47XE+yOLdlrBsW8Yz4sUXkUS4B5BXsHvpiDSq40YbAXzOdvmQVZ/N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RWQ5NCWS; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752195268; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=3TriclWw+V1uYJW7V2oYO+E7swnLCQdNXUrv8MdZsc0=;
	b=RWQ5NCWSKD0ALmxeyQM8aSz5t0yaBWAUktMH6o6lLoZTAOieVSUce8Y4P317dv7zxp37p2a8uVhvNC9ta/TVxyvr2oJeY53HN78ZGiMvP/YUZNEF5fWRXzkIQsaU/P/sg2dO8+ljWgEEoyCply3UFZcvhbC43OXMCJ0T3Jmm7XM=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wieq3dW_1752195267 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Jul 2025 08:54:27 +0800
Date: Fri, 11 Jul 2025 08:54:25 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v1 1/1] panic: Fix compilation error (`make W=1`)
Message-ID: <aHBgwRrFfmEWcp-T@U-2FWC9VHC-2323.local>
References: <20250710094816.771656-1-andriy.shevchenko@linux.intel.com>
 <20250710150133.680679cf8a0f6b2f0bf3369f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250710150133.680679cf8a0f6b2f0bf3369f@linux-foundation.org>

On Thu, Jul 10, 2025 at 03:01:33PM -0700, Andrew Morton wrote:
> On Thu, 10 Jul 2025 12:48:16 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Compiler is not happy about the recently added code:
> > 
> > lib/sys_info.c:52:19: error: variable 'sys_info_avail' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> >    52 | static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
> >       |                   ^~~~~~~~~~~~~~
> > 
> > Fix it in the same way how, for example, lib/vsprintf.c does in the similar
> > cases, i.e. by using string literal directly as sizeof() parameter.
> > 
> > ...
> >
> 
> > --- a/lib/sys_info.c
> > +++ b/lib/sys_info.c
> > @@ -49,13 +49,11 @@ unsigned long sys_info_parse_param(char *str)
> >  
> >  #ifdef CONFIG_SYSCTL
> >  
> > -static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
> > -
> >  int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
> >  					  void *buffer, size_t *lenp,
> >  					  loff_t *ppos)
> >  {
> > -	char names[sizeof(sys_info_avail) + 1];
> > +	char names[sizeof("tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks") + 1];
> >  	struct ctl_table table;
> >  	unsigned long *si_bits_global;
> >  
> 
> Yes, that's neater than the fix we currently have.  I'll grab, thanks.

Hi Andrew, Andy,

sys_info_avail[] has another purpose for being a counterpart of si_names[],
which could be extended in future, so we make it obviously stand-alone. As
for definition of si_names[], we explicitly added comment:  

	/*
	 * When 'si_names' gets updated,  please make sure the 'sys_info_avail'
	 * below is updated accordingly.
	 */
	static const struct sys_info_name  si_names[] = {
		{ SYS_INFO_TASKS,		"tasks" },
		{ SYS_INFO_MEM,			"mem" },
		
which has also been discussed in another thread:
https://lore.kernel.org/lkml/aG3o2RFHc5iXnJef@U-2FWC9VHC-2323.local/

And I suggest to keep sys_info_avail[], and either Nathan or Sergey's patch
works for me.

Sorry for the inconvenience, and I should upgrade my gcc :) 

Thanks,
Feng



