Return-Path: <linux-kernel+bounces-877802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 817F4C1F0DE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBEDB4E9B6C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108AA2E5B1D;
	Thu, 30 Oct 2025 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eaQo+zkQ"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496542F6586
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761813937; cv=none; b=gFiVxePsRNDlSIdI+djNxoIaiG1qqXnfti9IXYLjy6T3yZBCSv4cyI+RsDAE16EHHxB5RyUImb/QrDoM6B8agO6M5ZGk3ZnpjSLe3XOcvMALkBdagts2hEMRJgEfDd2SwoqAUREoobc0ikK41Hmmg2ssiXiRQ7rr+Xre9/JhS0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761813937; c=relaxed/simple;
	bh=UQR2Dz6FidlI211wqsmdHNXJ2+yZkvXoJouaNXyCQGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/zI6JdG8gbI5f0E64WCelsfNnRhf9FAH7SuXWp/PbXKHdbpXEC7m8orcCrAnTqFOYptjrzvd/uJzejOSmVgsv2+p9eNbtKVnLS3/0cW1U8c8yWhv4ShDIchggQBIzJgs+Jd1cnV9MQiswovXr4LEZqW0LBa9uqARmZ5IRJJlDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eaQo+zkQ; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761813926; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=PpiGci4gpMl4WbYRClFUCE1CFSQ2yrgyBFry1Z/7r9Q=;
	b=eaQo+zkQzQ484GxvbGqGWu5YrmLl0hk/TpI0weJBSRivvlAiaY5Bv8AgmTP55uqQuMs5MaFQc8xGn611ek3BMTiQRx7wksE+lTGTlX54J/Z5oWUEy3+6MmRti3S087EIWnPniv4eymdiImGV8P/95i2Y37Q2QfgiwFzTaNqSKDI=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WrJc58h_1761813925 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Oct 2025 16:45:25 +0800
Date: Thu, 30 Oct 2025 16:45:24 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 3/6] panic: sys_info: Replace struct sys_info_name
 with plain array of strings
Message-ID: <aQMlpFoLuPhVwijR@U-2FWC9VHC-2323.local>
References: <20251029111202.3217870-2-andriy.shevchenko@linux.intel.com>
 <20251029111202.3217870-5-andriy.shevchenko@linux.intel.com>
 <aQLHDaIqkMQTJHTT@U-2FWC9VHC-2323.local>
 <aQMVivr15od8Mpct@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQMVivr15od8Mpct@smile.fi.intel.com>

On Thu, Oct 30, 2025 at 09:36:42AM +0200, Andy Shevchenko wrote:
> On Thu, Oct 30, 2025 at 10:01:49AM +0800, Feng Tang wrote:
> > On Wed, Oct 29, 2025 at 12:07:38PM +0100, Andy Shevchenko wrote:
> > > There is no need to keep a custom structure just for the need of
> > > a plain array of strings. Replace struct sys_info_name with plain
> > > array of strings.
> > > 
> > > With that done, simplify the code, in particular, naturally use
> > > for_each_set_bit() when iterating over si_bits_global bitmap.
> 
> ...
> 
> > >  		names[0] = '\0';
> > > -		for (i = 0; i < ARRAY_SIZE(si_names); i++) {
> > > -			if (si_bits & si_names[i].bit) {
> > > -				len += scnprintf(names + len, sizeof(names) - len,
> > > -					"%s%s", delim, si_names[i].name);
> > > -				delim = ",";
> > > -			}
> > > +		for_each_set_bit(i, &si_bits, ARRAY_SIZE(si_names)) {
> > > +			len += scnprintf(names + len, sizeof(names) - len,
> > > +					 "%s%s", delim, si_names[i]);
> > > +			delim = ",";
> > 
> > For SYS_INFO_PANIC_CONSOLE_REPLAY bit, it is a NULL string, no need for
> > an extra ','?
> 
> If you look closer to the original code, the behaviour is the same. Feel free
> to update behaviour separately as I tried to keep the functionality to be not
> changed with my series (with the exceptions of the fetching issue).

I gave the comment by code-reading.

And to double check it, I just run a simple test by adding "panic_print=0xff"
to cmdline, with the current kernel, by running "sysctl  kernel.panic_sys_info"
on current kernel, it will get:

	'kernel.panic_sys_info = tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks'

And after applying your first 3 patches, it will show:
	
	'kernel.panic_sys_info = tasks,mem,timers,locks,ftrace,,all_bt,blocked_task'

Thanks,
Feng


