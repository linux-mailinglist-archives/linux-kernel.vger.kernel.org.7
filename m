Return-Path: <linux-kernel+bounces-839221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C5ABB114E
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8297E3BB49A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F55C149C7B;
	Wed,  1 Oct 2025 15:33:39 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548E5243367
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332819; cv=none; b=RSdDNsvTW4k+XGK4wRL+VFM0pWbVzAzeYaQYLo7+Mw4hb7RtGqXv177MW1NQJN1QgatjPPgHzbW7DnHQ2c7pg2Sd+qq0Ph6GdhhkhcSFDim10rbuhVUhvDGwevNfEfjGA63MUnaYOO5LB1KaepWhXk+uCRzbqr48I2KCMn3Zz/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332819; c=relaxed/simple;
	bh=b2ROy7pJUvmvpizoALmuXSfKM5WqsgV8jdrYsYCRhOY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4ShOoJi2sdseW3LlEOy5gf+Ix8EdJBx14gegBzEBlxFnen7I11twMMudK506iIUFBAw590UO5zXyuWnl+y6rRQF2MFsXLXvrlVewmIZeHhaUVbq2dnyNFt9AoEVLhgI5CIrijzf7PDRjjYRwuAPK1J4aD+WBZzHSwem9M7zZxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 3692914014C;
	Wed,  1 Oct 2025 15:33:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 773A92000E;
	Wed,  1 Oct 2025 15:33:27 +0000 (UTC)
Date: Wed, 1 Oct 2025 11:35:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] unwind: Add comment to
 unwind_deferred_task_exit()
Message-ID: <20251001113505.25281444@gandalf.local.home>
In-Reply-To: <20250924080118.893367437@infradead.org>
References: <20250924075948.579302904@infradead.org>
	<20250924080118.893367437@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7c5ybzz6h17cu59mkcupwqiz4thyqnm7
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 773A92000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/CFcaf/RKIM2DC6hcTHUFcz2XRrCMloJo=
X-HE-Tag: 1759332807-167624
X-HE-Meta: U2FsdGVkX1/wDDV+bqNp7UK+Q8h+FxnkEAUZEpp11uOLbQrTyg/ZgM5B5laTNoNS7/AC3fjKPWeDs4iYpsVE8s6qEkkUIQvat9+yT+27d1RIC94QVT87vxOayk0aSjKkvxtG6v6hW2kwgUSqrvl31cbotqsVDqLaujbQUCQf0genB+sqiuLffndhWbbtBwD2YPcmurJjYL2tdGtnzno9jJcJ0zlBJjx+ZCDgLw7bcLUBItiqtW1+5meHWqkYmjy2l3MJ995kMl2tMKuAebcepT0LTyr1436j+p5PZvI6eKyRqbid3DHQB0oCQYAgA9M+3Mnrg7HqiLb2GCFb9OGmDwARpjE6JaIG9JzXt4Rg64y7G890i/upbXRZf4hFXoQl

On Wed, 24 Sep 2025 09:59:53 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Explain why unwind_deferred_task_exit() exist and its constraints.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/exit.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -934,7 +934,6 @@ void __noreturn do_exit(long code)
>  
>  	tsk->exit_code = code;
>  	taskstats_exit(tsk, group_dead);
> -	unwind_deferred_task_exit(tsk);
>  	trace_sched_process_exit(tsk, group_dead);
>  
>  	/*
> @@ -945,6 +944,12 @@ void __noreturn do_exit(long code)
>  	 * gets woken up by child-exit notifications.
>  	 */
>  	perf_event_exit_task(tsk);
> +	/*
> +	 * PF_EXITING (above) ensures unwind_deferred_request() will no
> +	 * longer add new unwinds. While exit_mm() (below) will destroy the
> +	 * abaility to do unwinds.


I would state that it also flushes any unwind that is currently pending, as
exit_mm() will prevent it from happening.

-- Steve


> +	 */
> +	unwind_deferred_task_exit(tsk);
>  
>  	exit_mm();
>  
> 


