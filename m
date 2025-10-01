Return-Path: <linux-kernel+bounces-839228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 473B9BB1199
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8F12A37DB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE0827F72C;
	Wed,  1 Oct 2025 15:37:16 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B11327F195
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759333036; cv=none; b=L9GV+EmjKi7oKQdzvD0RlKq0ffd9zEGIwjK4aJJgLAtrP3xB3lmqKFDBQOtIkQdc72lCBh05ZLRFzfsQ6V/5Y2Jq9NltiD+XIJQcI6JudJWK1If6cpnC24Oj4xxGxzf05s6tm+rQwi1fI3JJlKgfxp+Mv5xkr3bpyaT621F6S+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759333036; c=relaxed/simple;
	bh=R2M5ba+g7fms9WPtgWKuS/veVQT5krnAqAiUVa180oI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9NaKdbizKYRjzE7Ey1RmJlAIUXCRLUopiN+KL8w+2UAB4ZX8EUnLrWnxllZ3C6S7UCtTlNh+NFK234Zl7bR5srK71CR6Vd+DBDPeoNiQuOXK62QI5egQqzEZUO3Pa4nBPtKvdM1iTLrVGxt9eSeg2nyDzG8tNizEQeIew4uanI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 04A32160167;
	Wed,  1 Oct 2025 15:37:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 62AF81C;
	Wed,  1 Oct 2025 15:37:11 +0000 (UTC)
Date: Wed, 1 Oct 2025 11:38:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] unwind: Clarify calling context
Message-ID: <20251001113849.65a95421@gandalf.local.home>
In-Reply-To: <20250924080119.122507632@infradead.org>
References: <20250924075948.579302904@infradead.org>
	<20250924080119.122507632@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: pca1njd6d3smdyh7k8idqiwmefprpjcs
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 62AF81C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1877jpSR7zd8d4telYDSL1KsTZh8xjCurU=
X-HE-Tag: 1759333031-156842
X-HE-Meta: U2FsdGVkX1/W3/+TaAlS8GRX+PbieIo8iSTvcFEVh7lLApH3dzk2/Adyn5QRk/7Opz7zlfR6coGzaCMVvUIgmFyy7FaldaPjj/ZZeK6SwkRDiq7GI9hub5sosiIRx3cRD6fT4vVjCPBqYfl2kdTCM2q5pEPW/lHjs5NjovQ+BDB9G3NNxpEoO3fmsLKx4elDmM6QX2tMyQELG/QPyzRGg388/CuzmndpsK1jj9gyfGY6bjDJcYW2VDR1hY72tZOywKe3ym8Jiu61DrEHqillNiBdvjjQtqsbvHxSEH6r7ylYA59awlIw3/zXSceEWLXOqCrD1rlAFIMcabxqn2HI3AamrXiNQZGlwavuQEBi2HNgLOSBonIn8tPODUX5/GtWtS2CGgMlnCn2Vi41PNwiTV+cPtfEQtoLkwkLe5oq1cw3St7QnALMgVH7h21h0fXx

On Wed, 24 Sep 2025 09:59:55 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> The get_cookie() function hard relies on IRQs being disabled, but this
> isn't immediately obvious when reading the function.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/unwind/deferred.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/kernel/unwind/deferred.c
> +++ b/kernel/unwind/deferred.c
> @@ -79,6 +79,8 @@ static u64 get_cookie(struct unwind_task
>  {
>  	u32 cnt = 1;
>  
> +	lockdep_assert_irqs_disabled();
> +
>  	if (info->id.cpu)
>  		return info->id.id;
>  
> 


