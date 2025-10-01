Return-Path: <linux-kernel+bounces-839232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA46BB11D2
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E57A3A76D7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFCE2773D2;
	Wed,  1 Oct 2025 15:39:21 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52632628D
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759333161; cv=none; b=WFTd9kA/5NV0VatpDXpWuJ2gSCb0hfBGQrOiJls2RpPoLF0ss6W2Jr+l6zg/Dd6A8LiVEfj2CvcEYo8w3CQ8WPHF72A4WCVoHvyvXWN9rBfcgDLPb7h0lH4ucqGv8zSY+Rp6SFDR5o4ZI0gvg4m2dcNwy5We/Ht0UaTOQJ4AZxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759333161; c=relaxed/simple;
	bh=H/lOpBRdzr+aqcXu3lSz/ATUOFC5D4c1Q7h6wcedKrk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YrxkQfCROSWSwDwVK+EYUzJrzcwL6lEQcGpRKYD2BSAxSdebpzrO5W2cjZU13vG7O9P/1m815eB+T+gwILV0nu5y4ebS+QDvCcLOU+KqWbEyZ+EwGEgig0nA7+F54USy1dhDYHpVOMesTjp5IFv4x+7izmJ/GR0kOAK8mHjVByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id C0EAA1A0142;
	Wed,  1 Oct 2025 15:39:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 1371F80013;
	Wed,  1 Oct 2025 15:39:16 +0000 (UTC)
Date: Wed, 1 Oct 2025 11:40:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] unwind: Simplify unwind_user_faultable()
Message-ID: <20251001114053.242997aa@gandalf.local.home>
In-Reply-To: <20250924080119.271671514@infradead.org>
References: <20250924075948.579302904@infradead.org>
	<20250924080119.271671514@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: sx7n4y7nrp7her46was7d39wpzagxtyw
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 1371F80013
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Axg8srxliomzZqHslx35on5L65RESdQM=
X-HE-Tag: 1759333155-463918
X-HE-Meta: U2FsdGVkX18lNBJEsa72/o6jiKSwqLpB4zUwDHLUm4BjyrirhCH+jMvHTi44LCp7+AX8YyakJlQgxNgEp5p/UkwMpYTLfl3Kmvv72WRySuARx+TEdIiKFWEY7OkzPPF/iCE0+sZVIuIYZAMc0HZanD0TfCC5BSbcsJrywSciQ+2IWHRlr99VrA1Nz8uHi2QyPawTNgNFhdiPpLUUnTHdUOPTiv0G3dp7Jih7VMyjfo1oCJAgJ5eAR97R6Qho+jHLVVtVxnoif2N7rXFuIEeRSRx+hO6ZpLfWk43rbi42yWawJ+QHlBy37n3+6vnE+nwKBQm8PybpqfdrFnDJ8zVYjgTl8ROFzNIpgvy+trjw9YlvjHk9yh7q2qriViZ44WyQ

On Wed, 24 Sep 2025 09:59:56 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/unwind/deferred.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> --- a/kernel/unwind/deferred.c
> +++ b/kernel/unwind/deferred.c
> @@ -128,17 +128,15 @@ int unwind_user_faultable(struct unwind_
>  
>  	cache = info->cache;
>  	trace->entries = cache->entries;
> -
> -	if (cache->nr_entries) {
> +	trace->nr = cache->nr_entries;
> +	if (trace->nr) {
>  		/*
>  		 * The user stack has already been previously unwound in this
>  		 * entry context.  Skip the unwind and use the cache.
>  		 */
> -		trace->nr = cache->nr_entries;
>  		return 0;
>  	}

Could we turn the above into:

	/*
	 * If the user stack has already been previously unwound in this
	 * entry context.  Skip the unwind and use the cache.
	 */
	if (trace->nr)
		return 0;

So we could remove the squiggly brackets?

-- Steve



>  
> -	trace->nr = 0;
>  	unwind_user(trace, UNWIND_MAX_ENTRIES);
>  
>  	cache->nr_entries = trace->nr;
> 


