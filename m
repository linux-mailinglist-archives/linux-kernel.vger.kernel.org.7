Return-Path: <linux-kernel+bounces-878025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BFAC1F989
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3A61884088
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667D9354AC2;
	Thu, 30 Oct 2025 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jml/em/O"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A1625A322
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820587; cv=none; b=DgkghHdusv1KnuZ9vLM7Npaqif3IPb03Luw0lwALhxen2BjLFr5rRfY6OnZKK9mCng6ARkPok4t0hcWXRGVYSEOktx3J7VWNv0+llqalgI7X0ryI77Ow/cFlHaCfQS/w14BaBG9/D4awuyTYurQyH2ydAaEys9h1o9ed9Z+HUUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820587; c=relaxed/simple;
	bh=mffLHxksDJb1tDLV2b9r1iQZf5P8vukn1uPN41l42Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhoduLXh2I34hjD8CszfNnJnJZuSlEP9U9OW0GrDXB8oga1VIKdYHQaPvTnCub4gEEJ/smbaSAjBS5zGDDmHQVFi+IfLLGFkdqEZoZffjrYKrr3OlYom6VPYSRge+0lwp5NK/Ddbh0m8oeR2uGn3VXWwKjf+4vMLWPeWlixTxYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jml/em/O; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761820575; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=QiuUxJD/XTpYtVc6d3NlCZbEDROxJ84ewEp3018iv1M=;
	b=jml/em/OlBUF15ObINZSWfBDWVkTFCwwPYbPp8tIDBvtpdGJP+kjKNXiYkKxg8TmLQ0k9Jr9p7pZ+o0iw+WqqOWsFEMQWk/N/sCvd6FsWaGSx/OmmVdHhIj/95xgCFE1XL4P4Reghb53zquKjNOo0kBDKnYpRxsTLM48yVEQJWE=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WrK3-N3_1761820574 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Oct 2025 18:36:15 +0800
Date: Thu, 30 Oct 2025 18:36:14 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 3/6] panic: sys_info: Replace struct sys_info_name
 with plain array of strings
Message-ID: <aQM_nrp4gQzxGixr@U-2FWC9VHC-2323.local>
References: <20251029111202.3217870-2-andriy.shevchenko@linux.intel.com>
 <20251029111202.3217870-5-andriy.shevchenko@linux.intel.com>
 <aQLHDaIqkMQTJHTT@U-2FWC9VHC-2323.local>
 <aQMVivr15od8Mpct@smile.fi.intel.com>
 <aQMlpFoLuPhVwijR@U-2FWC9VHC-2323.local>
 <aQMqdyh9n7h8Wedm@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQMqdyh9n7h8Wedm@smile.fi.intel.com>

On Thu, Oct 30, 2025 at 11:05:59AM +0200, Andy Shevchenko wrote:
> On Thu, Oct 30, 2025 at 04:45:24PM +0800, Feng Tang wrote:
> > On Thu, Oct 30, 2025 at 09:36:42AM +0200, Andy Shevchenko wrote:
> > > On Thu, Oct 30, 2025 at 10:01:49AM +0800, Feng Tang wrote:
> > > > On Wed, Oct 29, 2025 at 12:07:38PM +0100, Andy Shevchenko wrote:
> > > > > There is no need to keep a custom structure just for the need of
> > > > > a plain array of strings. Replace struct sys_info_name with plain
> > > > > array of strings.
> > > > > 
> > > > > With that done, simplify the code, in particular, naturally use
> > > > > for_each_set_bit() when iterating over si_bits_global bitmap.
> 
> ...
> 
> > > > >  		names[0] = '\0';
> > > > > -		for (i = 0; i < ARRAY_SIZE(si_names); i++) {
> > > > > -			if (si_bits & si_names[i].bit) {
> > > > > -				len += scnprintf(names + len, sizeof(names) - len,
> > > > > -					"%s%s", delim, si_names[i].name);
> > > > > -				delim = ",";
> > > > > -			}
> > > > > +		for_each_set_bit(i, &si_bits, ARRAY_SIZE(si_names)) {
> > > > > +			len += scnprintf(names + len, sizeof(names) - len,
> > > > > +					 "%s%s", delim, si_names[i]);
> > > > > +			delim = ",";
> > > > 
> > > > For SYS_INFO_PANIC_CONSOLE_REPLAY bit, it is a NULL string, no need for
> > > > an extra ','?
> > > 
> > > If you look closer to the original code, the behaviour is the same. Feel free
> > > to update behaviour separately as I tried to keep the functionality to be not
> > > changed with my series (with the exceptions of the fetching issue).
> > 
> > I gave the comment by code-reading.
> > 
> > And to double check it, I just run a simple test by adding "panic_print=0xff"
> > to cmdline, with the current kernel, by running "sysctl  kernel.panic_sys_info"
> > on current kernel, it will get:
> > 
> > 	'kernel.panic_sys_info = tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks'
> > 
> > And after applying your first 3 patches, it will show:
> > 	
> > 	'kernel.panic_sys_info = tasks,mem,timers,locks,ftrace,,all_bt,blocked_task'
> 
> Thanks for the test, now I see the issue! Before si_names has no entry for that bit.
> I will address this in next version. Sorry for the confusion.

No problem. Thanks for helping to improve the code!

- Feng

