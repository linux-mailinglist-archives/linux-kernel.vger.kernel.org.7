Return-Path: <linux-kernel+bounces-829903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 228DCB9827B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5AD219C032E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA453224234;
	Wed, 24 Sep 2025 03:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nrC4DWIb"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C082AE77
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758685806; cv=none; b=M2BBzW+3KEDDzN8fvv2bZaMc6bkJTVBjmXBqSvusED1LOA4+YmDiVv5zDSNjeH5BZnW/0DdYgjt2mKAMwA9G/a7Kskf9JnM0SNVx8/D1yK2ngEyI0nZJc7aqF6UwVN0bcRiPiRy4ZTH6Y8npfGbrAoVsEqMZPE+Gy0wqXEJbKzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758685806; c=relaxed/simple;
	bh=s+7Gh+7gXKjvqZS4LNGpi8Df/1fvT5nOX+pQvwQOLQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMXtGGjGM9p++fU2fHnjxCDh9TQedf1DtIqAr6S0kcrDi4+mYCK/ioF4s9XSuiIz1UmEcGegDbAyGT24tRioqyxYjIc6jwP8+Q/LOsw0Q3ogUzb1S5UQgTEqUj5zLcJRoz8Uc3lrIHQA+59PvGYXM1BhMwp07lW59zZX3yaJ6Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nrC4DWIb; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758685791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QfS2bmksKLmDtfQBfYaU21eiCkBRFD1BaUAUPpUXugo=;
	b=nrC4DWIb6Pz8x6OBmlTOFkcjTjrrsXEHXS+Q/nY0vZze15vWlffJ6UENBRKU/DsZnCSIv4
	xxyZDv8psShhzx3DOOojQXNTgzqluZwsjh8QBUKbZq0wrGDW+2gQbnq3DToQlercEP2iwK
	Tq5IbrbbdnC4sWzjchZ9xp1iqwOPkB0=
From: menglong.dong@linux.dev
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject:
 Re: [PATCH 2/2] tracing: fprobe: Fix to remove recorded module addresses from
 filter
Date: Wed, 24 Sep 2025 11:49:39 +0800
Message-ID: <9510801.CDJkKcVGEf@7940hx>
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
> 
> Fixes: a3dc2983ca7b ("tracing: fprobe: Cleanup fprobe hash when module unloading")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/fprobe.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Hi, Masami. Should I send the V2 of the patch:

  tracing: fprobe: optimization for entry only case

after this series applied?

Thanks!
Menglong Dong

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





