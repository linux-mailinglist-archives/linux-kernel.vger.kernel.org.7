Return-Path: <linux-kernel+bounces-877458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB2DC1E285
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53D93AF09D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2366F32ABD6;
	Thu, 30 Oct 2025 02:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YXjCM2kb"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00BF1B041A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761792244; cv=none; b=hk59jljmgFlyTm0OiD44Syd9ooqkn/p/LBTTM9HkLDz/caYjzdzFzZOYYZoV7VaaYOi8r1ILgXro+vPjmHCrDCfBzs1I2jVpwlxzsw5eoPmHhIdpuc9aj+fRm6z/5UCW9GEdJng8z9ESinQrQjkRTqnRaXZew+UHhCkSg+U0PQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761792244; c=relaxed/simple;
	bh=DfOGEOr+ZWItEdsyHaCYdxtCrUpYU6IvOFm+waMAB6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3fkNqJtvmhLvICNxY9xG2bzh/FltdFuBzSa2cO8xVsFmmYeQl8kDFr6dsg3uOBEJsCYEWfxffqCMorhK5SWE/SXJh7Cua0VUuYbscCLzKcxKvXdUm4mFi8RKPgiCom8HGAMoS9RWJXyryprIPVvKzD9h3vLqrt2tbq90ru1Zck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YXjCM2kb; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761792230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXYnC3K3LDk/2WfKoZt4rs/JfbsDXoEJ5L7oBgFc64Y=;
	b=YXjCM2kbyVTzStgk7lJtk68m2WI/bFmlNImUIFnnnNwTnA0zpzIgrsom9OeoX0A1wyaxkP
	2GCK9rJbSbcpu820w1FxPY9S7UvKh1Y9Pw6Z08FdHYomvQJjzyH5j91DFzXNoyLgdUIoem
	Z4GtoKDugYf4A4x7neuveW7mtyzxisA=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, jolsa@kernel.org, mathieu.desnoyers@efficios.com,
 jiang.biao@linux.dev, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject:
 Re: [PATCH] tracing: fprobe: use ftrace if CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Date: Thu, 30 Oct 2025 10:43:43 +0800
Message-ID: <6206414.lOV4Wx5bFT@7950hx>
In-Reply-To: <20251030094047.9f8aa77cb90897a14c8adada@kernel.org>
References:
 <20251029021514.25076-1-dongml2@chinatelecom.cn>
 <20251030094047.9f8aa77cb90897a14c8adada@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/30 08:40, Masami Hiramatsu wrote:
> On Wed, 29 Oct 2025 10:15:14 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
> 
> > For now, we will use ftrace for the fprobe if fp->exit_handler not exists
> > and CONFIG_DYNAMIC_FTRACE_WITH_REGS is enabled.
> > 
> > However, CONFIG_DYNAMIC_FTRACE_WITH_REGS is not supported by some arch,
> > such as arm. What we need in the fprobe is the function arguments, so we
> > can use ftrace for fprobe if CONFIG_DYNAMIC_FTRACE_WITH_ARGS is enabled.
> > 
> > Therefore, use ftrace if CONFIG_DYNAMIC_FTRACE_WITH_REGS or
> > CONFIG_DYNAMIC_FTRACE_WITH_ARGS enabled.
> > 
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  kernel/trace/fprobe.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index ecd623eef68b..9fad0569f521 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -254,7 +254,11 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
> >  	return ret;
> >  }
> >  
> > -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > +#if defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS) || defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
> > +#define FPROBE_USE_FTRACE
> > +#endif
> > +
> > +#ifdef FPROBE_USE_FTRACE
> >  /* ftrace_ops callback, this processes fprobes which have only entry_handler. */
> >  static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
> >  	struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > @@ -295,7 +299,7 @@ NOKPROBE_SYMBOL(fprobe_ftrace_entry);
> >  
> >  static struct ftrace_ops fprobe_ftrace_ops = {
> >  	.func	= fprobe_ftrace_entry,
> > -	.flags	= FTRACE_OPS_FL_SAVE_REGS,
> > +	.flags	= FTRACE_OPS_FL_SAVE_ARGS,
> >  };
> >  static int fprobe_ftrace_active;
> >  
> > @@ -349,7 +353,7 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
> >  {
> >  	return false;
> >  }
> > -#endif
> > +#endif /* !FPROBE_USE_FTRACE */
> >  
> >  /* fgraph_ops callback, this processes fprobes which have exit_handler. */
> >  static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> > @@ -599,7 +603,7 @@ static int fprobe_module_callback(struct notifier_block *nb,
> >  	if (alist.index > 0) {
> >  		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
> >  				      alist.addrs, alist.index, 1, 0);
> > -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > +#ifdef FPROBE_USE_FTRACE
> >  		ftrace_set_filter_ips(&fprobe_ftrace_ops,
> >  				      alist.addrs, alist.index, 1, 0);
> >  #endif
> 
> Instead of introducing FPROBE_USE_FTRACE, I think it is better to add another
> wrapper to be called here.

Sounds better! I'll modify it in the next version.

Thanks!
Menglong Dong

> 
> #if defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS) || defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
> 
> static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove, int reset)
> {
> 		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
> 				      alist.addrs, alist.index, 1, 0);
> 		ftrace_set_filter_ips(&fprobe_ftrace_ops,
> 				      alist.addrs, alist.index, 1, 0);
> }
> ...
> #else
> static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove, int reset)
> {
> 		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
> 				      alist.addrs, alist.index, 1, 0);
> }
> #endif
> 
> Thank you,
> 
> 





