Return-Path: <linux-kernel+bounces-765718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3C1B23D44
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7933B0345
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5D027472;
	Wed, 13 Aug 2025 00:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BrUGe7uu"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31770143C69
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755045586; cv=none; b=L2pOXggFh0Tc5Zrv4DoJTjENKdApSeYdfdUe9yEu+d9rgnWZNGYE0kHKBDaKT/s2Qpmx4AtXGBWfcw3rMaU04dsUUufHWbGQhE/UcOBzuzPKHo9X66mu5oqdqH6xolf7GTCipIif8czwTcwy32US2nrYEiEkQTd9JpxnX3LpSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755045586; c=relaxed/simple;
	bh=Jj73x4d2mEt/x/uax+byA1rOVGHDc6va2nX8OEb1lc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYEcfEFm9t48gtwfFyn08Pyq9swbJrjEUt4B+0KQW1lZMd3vjLGR85KGiZqH5PMTXPXI/0gHj07nuncVuMxP4JCfv5oVR6DIbLPVmJWwphpq79UNTnpfX4hBU1BYZJr4xb4QR7K8LshKVcyxcDwUYkAQZCtqIFFezGKWRCrfrGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BrUGe7uu; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755045579; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=VBE96bo12oToz+D1FLxpOMcPOl48/oNNWdgyR8Bt6/4=;
	b=BrUGe7uuj16zuP7YtdqJa33mDc3FUa46JwPES9ooD8ZKWG70HcWiaJZmKmGybdeSveAuSZwF13+D+qtapBnBL4ukw3m4pfiyvaAKiTJhUnSQDXOHwQu/0VNRpmJDZRNL/thBz/QUope8QTZQp+1dG0wSozgnci7pSzeA05sbVO4=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WldHvLC_1755045578 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Aug 2025 08:39:38 +0800
Date: Wed, 13 Aug 2025 08:39:37 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH 3/5] panic: add 'panic_sys_info' sysctl to take human
 readable string parameter
Message-ID: <aJveydkcbT7NxvQx@U-2FWC9VHC-2323.local>
References: <20250703021004.42328-1-feng.tang@linux.alibaba.com>
 <20250703021004.42328-4-feng.tang@linux.alibaba.com>
 <aJsWCxc42f2Qjbs3@pathway>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJsWCxc42f2Qjbs3@pathway>

On Tue, Aug 12, 2025 at 12:23:07PM +0200, Petr Mladek wrote:
> On Thu 2025-07-03 10:10:02, Feng Tang wrote:
> > Bitmap definition for 'panic_print' is hard to remember and decode.
> > Add 'panic_sys_info='sysctl to take human readable string like
> > "tasks,mem,timers,locks,ftrace,..." and translate it into bitmap.
> > 
> > The detailed mapping is:
> > 	SYS_INFO_TASKS		"tasks"
> > 	SYS_INFO_MEM		"mem"
> > 	SYS_INFO_TIMERS		"timers"
> > 	SYS_INFO_LOCKS		"locks"
> > 	SYS_INFO_FTRACE		"ftrace"
> > 	SYS_INFO_ALL_CPU_BT	"all_bt"
> > 	SYS_INFO_BLOCKED_TASKS	"blocked_tasks"
> > 
> > --- a/lib/sys_info.c
> > +++ b/lib/sys_info.c
> > +static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
> > +
> > +int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
> > +					  void *buffer, size_t *lenp,
> > +					  loff_t *ppos)
> > +{
> > +	char names[sizeof(sys_info_avail) + 1];
> 
> The "+ 1" looks superfluous.
> 
> I guess that it is for the trailing '\0'. But sys_info_avail[] already
> includes the trailing '\0' so it should be already counted by the sizeof().
> 
> Note that it would be needed with strlen(). But it should not be
> needed with sizeof().

Yes, you are right. Will remove it.

> > +	struct ctl_table table;
> > +	unsigned long *si_bits_global;
> > +
> > +	si_bits_global = ro_table->data;
> > +
> > +	if (write) {
> > +		unsigned long si_bits;
> > +		int ret;
> > +
> > +		table = *ro_table;
> > +		table.data = names;
> > +		table.maxlen = sizeof(names);
> > +		ret = proc_dostring(&table, write, buffer, lenp, ppos);
> > +		if (ret)
> > +			return ret;
> > +
> > +		si_bits = sys_info_parse_param(names);
> > +		/* The access to the global value is not synchronized. */
> > +		WRITE_ONCE(*si_bits_global, si_bits);
> > +		return 0;
> > +	} else {
> > +		/* for 'read' operation */
> > +		char *delim = "";
> > +		int i, len = 0;
> > +
> 
> It looks to me that names[] can later be used non-initialized when
> *si_bits_global == 0. We should initialized it here, something like:
> 
> 		names[0] = '\0';

Good catch! Will add this.

> > +		for (i = 0; i < ARRAY_SIZE(si_names); i++) {
> > +			if (*si_bits_global & si_names[i].bit) {
> > +				len += scnprintf(names + len, sizeof(names) - len,
> > +					"%s%s", delim, si_names[i].name);
> > +				delim = ",";
> > +			}
> > +		}
> > +
> > +		table = *ro_table;
> > +		table.data = names;
> > +		table.maxlen = sizeof(names);
> > +		return proc_dostring(&table, write, buffer, lenp, ppos);
> > +	}
> > +}
> > +#endif
> 
> Otherwise, it looks good.
 
Thanks for reviewing the patchset!

- Feng

> Best Regards,
> Petr

