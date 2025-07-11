Return-Path: <linux-kernel+bounces-726766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ED4B010ED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 03:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F4A76506E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88020149C4A;
	Fri, 11 Jul 2025 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcBlvN4m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B3713FD86
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752198594; cv=none; b=XkznOz/WUllke9xnhm/zVlk7x5zGXlCzaFHxTBFUSGlQw5illQ5tTjOAweEo7i3wdsutq6rpym7cMmbJxx9hNWGb54LZd0bV+Uw249WPDxz4n955DY0mT3Po3lQR4SwVyWsJKdEmpPakV214uBFQlaZd+YuakyOJg6qfYxaZVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752198594; c=relaxed/simple;
	bh=54L0zoL2BiYIGld6wKFnU9kKZ12rltWXLrGaZR5hSso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIT32OfpDjlONX1xprpPjR/zpJjVb3KJH41MFh0SDhepwBYLThoiU1tkXy/aDyBS7cmrKomm1UhIOUxFy7EcLW+VPBj9jjjXPS54bKdORAI9Y3xLwLuabY+6peeIUatmHjk0fbx6MMyoaNuCvmTmIIstmcAY5NDM/q6d8nqtLAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcBlvN4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7565C4CEE3;
	Fri, 11 Jul 2025 01:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752198593;
	bh=54L0zoL2BiYIGld6wKFnU9kKZ12rltWXLrGaZR5hSso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PcBlvN4mFb9Xd8AIpRzpkB4GERLMeXZFs/O5cJRfGsNjENzQvNgJSZ/N4rqV9G379
	 eAi3OYhBCGrpDI6uefGueUpT3oSFei5bsb3ia427i77/ub+BiCP3c783so410a9Nmm
	 rYXtjveER6HlLrvhwZleh0wQMjxEi7AwoQducQpoawKBJbhLxUDdfmLQM4DzjKnmfX
	 74xmEWom2PiXig0L3m42bEjsou+QQnd/s5Si60v4HNb5FMkA+sy22uJhWj4QdVjndo
	 PDmAk0BzfuOMlFsa3v6XjGxP2HeeGGqQ2ycrevO4s5EkbumPH7GeJfaeLL2xnhGxsE
	 i1eoytOdDYY9A==
Date: Thu, 10 Jul 2025 18:49:47 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v1 1/1] panic: Fix compilation error (`make W=1`)
Message-ID: <20250711014947.GA863150@ax162>
References: <20250710094816.771656-1-andriy.shevchenko@linux.intel.com>
 <20250710150133.680679cf8a0f6b2f0bf3369f@linux-foundation.org>
 <aHBgwRrFfmEWcp-T@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHBgwRrFfmEWcp-T@U-2FWC9VHC-2323.local>

On Fri, Jul 11, 2025 at 08:54:25AM +0800, Feng Tang wrote:
> On Thu, Jul 10, 2025 at 03:01:33PM -0700, Andrew Morton wrote:
> > On Thu, 10 Jul 2025 12:48:16 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > Compiler is not happy about the recently added code:
> > > 
> > > lib/sys_info.c:52:19: error: variable 'sys_info_avail' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> > >    52 | static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
> > >       |                   ^~~~~~~~~~~~~~
> > > 
> > > Fix it in the same way how, for example, lib/vsprintf.c does in the similar
> > > cases, i.e. by using string literal directly as sizeof() parameter.
> > > 
> > > ...
> > >
> > 
> > > --- a/lib/sys_info.c
> > > +++ b/lib/sys_info.c
> > > @@ -49,13 +49,11 @@ unsigned long sys_info_parse_param(char *str)
> > >  
> > >  #ifdef CONFIG_SYSCTL
> > >  
> > > -static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
> > > -
> > >  int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
> > >  					  void *buffer, size_t *lenp,
> > >  					  loff_t *ppos)
> > >  {
> > > -	char names[sizeof(sys_info_avail) + 1];
> > > +	char names[sizeof("tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks") + 1];
> > >  	struct ctl_table table;
> > >  	unsigned long *si_bits_global;
> > >  
> > 
> > Yes, that's neater than the fix we currently have.  I'll grab, thanks.
> 
> Hi Andrew, Andy,
> 
> sys_info_avail[] has another purpose for being a counterpart of si_names[],
> which could be extended in future, so we make it obviously stand-alone. As
> for definition of si_names[], we explicitly added comment:  
> 
> 	/*
> 	 * When 'si_names' gets updated,  please make sure the 'sys_info_avail'
> 	 * below is updated accordingly.
> 	 */
> 	static const struct sys_info_name  si_names[] = {
> 		{ SYS_INFO_TASKS,		"tasks" },
> 		{ SYS_INFO_MEM,			"mem" },
> 		
> which has also been discussed in another thread:
> https://lore.kernel.org/lkml/aG3o2RFHc5iXnJef@U-2FWC9VHC-2323.local/
> 
> And I suggest to keep sys_info_avail[], and either Nathan or Sergey's patch
> works for me.

We could do something like this to keep the sizeof() obvious and
separate, while still eliminating the variable? Happy to bike shed
aspects of it like the macro name and such.

diff --git a/lib/sys_info.c b/lib/sys_info.c
index 46d6f4f1ad2a..c1df502a2c0d 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -14,7 +14,7 @@ struct sys_info_name {
 };
 
 /*
- * When 'si_names' gets updated,  please make sure the 'sys_info_avail'
+ * When 'si_names' gets updated,  please make sure SYS_INFO_MAX_LEN
  * below is updated accordingly.
  */
 static const struct sys_info_name  si_names[] = {
@@ -49,13 +49,13 @@ unsigned long sys_info_parse_param(char *str)
 
 #ifdef CONFIG_SYSCTL
 
-static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
+#define SYS_INFO_MAX_LEN (sizeof("tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks") + 1)
 
 int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
-	char names[sizeof(sys_info_avail) + 1];
+	char names[SYS_INFO_MAX_LEN];
 	struct ctl_table table;
 	unsigned long *si_bits_global;
 
---

> Sorry for the inconvenience, and I should upgrade my gcc :) 

I am not sure that GCC has this warning, I have only ever seen it with
clang.

Cheers,
Nathan

