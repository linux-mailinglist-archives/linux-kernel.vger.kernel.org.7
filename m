Return-Path: <linux-kernel+bounces-765732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB066B23D93
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F686856CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 01:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D4545009;
	Wed, 13 Aug 2025 01:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HMHuFpmJ"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809972C0F87
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755047137; cv=none; b=WwsFMipgE5IFqd0ruC2HJSKo4FqjVW/guWqF5A+h7ZVMTe3DB8ooW1CiLRo9b8s46pWA6R8tZc/jc9ygDZmMQka6UvGjuDPPLmnduoyDy5pArCEAq8DCuSbU4PtzmAC6S+QG8HIDqBIOBEd5eq/3HaqaqEtP9hPDc0ltfP0b60Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755047137; c=relaxed/simple;
	bh=coueRxZDBbI2c+4uGY3Fvbd/3LDl4+NdeitMlGgrRO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0vjqWCnsJ4ZpfimpQwMgQvOWPRDf8LQQ/jn1+JU23Mne+ulpFdX4mJvFD5HCw9Y2YcZOMD+3CzMdbFhGP3g39+vVsLdnsTXoMjz9XnxG9in3ld6a7WxwplugfKfH7SSWP/EvEYyEGNVMeSqG97hm+JpOGjt0mb8U5XteZVY8Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HMHuFpmJ; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755047132; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=tZT7E1BHgVXlaH4RRgjdlwUpFmZn01djhpWNdtzrIJo=;
	b=HMHuFpmJSRGgF22T1EA3RgfS+SSEYoReBrQiyWh8djkiStULEHWwPH8qs2PXvlRZnJsnqjbD0h1ZkkixYPTNXX9a0/a4DGEcjbWXr+POy9gb00wUb8W8guVopABlVz6FbdLIDAYfs0nHs5zgaOamTdSMyB6fsiD90vHSH1Qq280=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wld9SGn_1755047131 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Aug 2025 09:05:31 +0800
Date: Wed, 13 Aug 2025 09:05:30 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v3 5/5] panic: add note that panic_print sysctl interface
 is deprecated
Message-ID: <aJvk2ti-D3t3EUsX@U-2FWC9VHC-2323.local>
References: <20250703021004.42328-1-feng.tang@linux.alibaba.com>
 <20250703021004.42328-6-feng.tang@linux.alibaba.com>
 <aJsrGgTYxtEhZ7jX@pathway>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJsrGgTYxtEhZ7jX@pathway>

On Tue, Aug 12, 2025 at 01:52:58PM +0200, Petr Mladek wrote:
> On Thu 2025-07-03 10:10:04, Feng Tang wrote:
> > Add a dedicated core parameter 'panic_console_replay' for controlling
> > console replay, and add note that 'panic_print' sysctl interface  will
> > be obsoleted by 'panic_sys_info' and 'panic_console_replay'.  When it
> > happens, the SYS_INFO_PANIC_CONSOLE_REPLAY can be removed as well.
> > 
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -77,6 +78,13 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
> >  EXPORT_SYMBOL(panic_notifier_list);
> >  
> >  #ifdef CONFIG_SYSCTL
> > +static int sysctl_panic_print_handler(const struct ctl_table *table, int write,
> > +			   void *buffer, size_t *lenp, loff_t *ppos)
> > +{
> > +	pr_info_once("Kernel: 'panic_print' sysctl interface will be obsoleted by both 'panic_sys_info' and 'panic_console_replay'\n");
> > +	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
> > +}
> 
> This warning is printed "only" when the value is accessed via the
> procfs. It would be great to print it also when it is set
> via the command line parameter.

Yes, this is indeed a remaining issue to be solved, as mentioned in
the cover letter.

> 
> It would require replacing
> 
> core_param(panic_print, panic_print, ulong, 0644);
> 
> with
> 
> core_param_cb(panic_print, &panic_print_ops, &panic_print, 0644);

When testing the change, I found  a problem:  'core_param_cb' is not
the real counterpart of 'core_param', that it is a module parameter
instead of kernel/core parameter, and adds the module.prefix to the
parameter, say, the effective cmdline parameter is changed to
'panic.panic_print=' instead of 'panic_print='.

While below patch of adding a new 'kernel_param_cb' can work without
the "panic" prefix, but I'm not sure if it is worth the change:

---
diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index bfb85fd13e1f..71053d078cea 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -194,6 +194,9 @@ struct kparam_array
 #define core_param_cb(name, ops, arg, perm)		\
 	__level_param_cb(name, ops, arg, perm, 1)
 
+#define kernel_param_cb(name, ops, arg, perm) \
+	__module_param_call("", name, ops, arg, perm, -1, 0)
+
 /**
  * postcore_param_cb - general callback for a module/cmdline parameter
  *                     to be evaluated before postcore initcall level

Thanks,
Feng

