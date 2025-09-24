Return-Path: <linux-kernel+bounces-829844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A28B98090
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0327419C5289
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 01:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A97E20C029;
	Wed, 24 Sep 2025 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FAe01ahT"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388A978F3E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758678938; cv=none; b=UtgQ+3sRZL7G22vm/xS/tdzD8JnguLc43WBFYXGC29PCFY6zZbpQ1aPEMTKHdBWgNjDsvubwF7USUQaQWN0PuyPNEBD/BMTwko78sA0ce8NNSHw7tpQ0VxBto4urdxX+pfnbJchR+XzMN/XS+hzEiS9DIYHzc/CsTBg5pGGUGPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758678938; c=relaxed/simple;
	bh=ZaxCTFxy5T1KCccizEL36oe3EUuXmHwQ1cfq8KHo+Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=taqXF0W+7OyksdYwQObtNoM0Mxrioj2OyFE0lIRNaQX2coL38t0M4QuycSbqw1uDUF8UFooiUOMxCJvWDHH4k52RRoVvPdrlaiDFJLNGBEPM4I4/tousyYyYByjc9Qx3fEntomNVneYgWjy3qtlc0EsHxaE68R5seOd+uGi9Y8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FAe01ahT; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758678935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufAR0E8vWAJ7aKhSLbVugadd2N2E3jpqW0t2IuSnjKk=;
	b=FAe01ahTk3V3zybi2WJwBOO/PwKj1tjY7PX6Jphkux/WnMCuj8d6q5GyD7fy6DGvFVuk2r
	7szG/IgpIuUTlCDhjjeVR/kViNuI4ixDEqLwRGrcTVq6FI/6HjL3Mlwf1ovZZXGNeP5Ol9
	psow99o5pELxwfctKOkcwLHefM1Ofj0=
From: menglong.dong@linux.dev
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject:
 Re: [PATCH 2/2] tracing: fprobe: Fix to remove recorded module addresses from
 filter
Date: Wed, 24 Sep 2025 09:55:15 +0800
Message-ID: <3379975.44csPzL39Z@7940hx>
In-Reply-To: <175867359903.600222.10400702167171128567.stgit@devnote2>
References:
 <175867358989.600222.6175459620045800878.stgit@devnote2>
 <175867359903.600222.10400702167171128567.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/9/24 08:26 Masami Hiramatsu (Google) <mhiramat@kernel.org> write:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Even if there is a memory allocation failure in fprobe_addr_list_add(),
> there is a partial list of module addresses. So remove the recorded
> addresses from filter if exists.
> This also removes the redundant ret local variable.

I think this is what you do in the previous patch?

The rest looks good to me.

Reviewed-by: Menglong Dong <menglong8.dong@gmail.com>

(I think I should use Reviewed-by here, rather than Acked-by,
right?)

Thanks!
Menglong Dong

> 
> Fixes: a3dc2983ca7b ("tracing: fprobe: Cleanup fprobe hash when module unloading")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/fprobe.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 12ec194fdfed..95e43814b85b 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -434,8 +434,9 @@ static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long ad
>  {
>  	unsigned long *addrs;
>  
> -	if (alist->index >= alist->size)
> -		return -ENOMEM;
> +	/* Previously we failed to expand the list. */
> +	if (alist->index == alist->size)
> +		return -ENOSPC;
>  
>  	alist->addrs[alist->index++] = addr;
>  	if (alist->index < alist->size)
> @@ -497,7 +498,7 @@ static int fprobe_module_callback(struct notifier_block *nb,
>  	} while (node == ERR_PTR(-EAGAIN));
>  	rhashtable_walk_exit(&iter);
>  
> -	if (alist.index < alist.size && alist.index > 0)
> +	if (alist.index > 0)
>  		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
>  				      alist.addrs, alist.index, 1, 0);
>  	mutex_unlock(&fprobe_mutex);
> 
> 
> 





