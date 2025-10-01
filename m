Return-Path: <linux-kernel+bounces-839255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911DFBB12F5
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4017F4A5264
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F6D28151C;
	Wed,  1 Oct 2025 15:53:58 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7B51459FA
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334038; cv=none; b=rFXMZyrsHbkfbCPXs/SZL5K6q4F+nZR4szTlZgBkouCy+AdyKwnTFsXaE10ZtU06YF6CvznyFCe6i3sIu/ndhiSaOBxVVYvJB1MU+7ofAz/pKS6nedy7qzqp9g/vKd6oLvb1cX391jJfjCUhwLV5i1Jh8NbqrmJ2P7ol7tZYz/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334038; c=relaxed/simple;
	bh=BbUIDmZb0NQDEwdNaPaTTdh7O3aTvUHmxq4FJDS6HrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YODmMdcUONZLYGo+H1wotOKOcgCULvZ3e2P+6acF4J6k9kJT/HaKlpPsuU/UC63KzMFuATDG+WOB+6PHKdvHOPabbGmyrFSvpAoFjTvB6G1RQm2EzR8Qy6QYVL/Il8dZeA3D3cmDT3NltP36zWBRnGruhTHSedtVMC3tv1gGQrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id C898C16016A;
	Wed,  1 Oct 2025 15:53:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 27D002002D;
	Wed,  1 Oct 2025 15:53:47 +0000 (UTC)
Date: Wed, 1 Oct 2025 11:55:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] unwind: Simplify unwind_user_next_fp() alignment
 check
Message-ID: <20251001115524.24542fd8@gandalf.local.home>
In-Reply-To: <20250924080119.497867836@infradead.org>
References: <20250924075948.579302904@infradead.org>
	<20250924080119.497867836@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qtdswknpbedtngo6awkx81jhaitpdzuu
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 27D002002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Js/VskR/5kI1U/3D/PNdTCuhmassniik=
X-HE-Tag: 1759334027-101059
X-HE-Meta: U2FsdGVkX19HnIUODOHvDmrNiuAZxVro1ClXouxlwR/tmADVdDO2IE7TjDML+sY9rToT9lnwrLQk7yt7aSPJiyIV+x6ffF30sLmkBJI7S9eJv3nfjZtzaBAqtYmBKFdO8mBtVnSSyJLvi3J9WYGcGKTrYSHTNHARtVaPojWTIiLJPn9TRaM95PyS5RNPzGwXkysh2xCwv0tpjkk4gvEkxcr7iGLifvMSaLSwdtJsrB+xpAb3naVkMB4sE83rNwjP1cBLZMpsnGJ4UqS0OmiYd5By+VfGLt/ZbEdcDO/0uGcINo14iupKUBwDY/Ehaq1eJT3dhk8tKzEiIzgQcy7OYl0iLjLL+weY8RtXEJBxyE2RovpDIye9dDFuzMCK82dz9TzyTGfvsH/D3mhFUoP9KhuZF0UqL3si4yt6o6ppG957KxsYQqsXo1geATxXvYUO

On Wed, 24 Sep 2025 09:59:58 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

I would add a change log. Something like:

  sizeof(long) is 4 or 8. Where 4 = 1 << 2 and 8 = 1 << 3.
  Calculating shift to be 2 or 3 and then passing that variable into
  (1 << shift) is the same as just using sizeof(long).

I blame lack of sleep for writing that code :-p

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/unwind/user.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> --- a/kernel/unwind/user.c
> +++ b/kernel/unwind/user.c
> @@ -19,7 +19,6 @@ static int unwind_user_next_fp(struct un
>  {
>  	const struct unwind_user_frame *frame = &fp_frame;
>  	unsigned long cfa, fp, ra;
> -	unsigned int shift;
>  
>  	if (frame->use_fp) {
>  		if (state->fp < state->sp)
> @@ -37,8 +36,7 @@ static int unwind_user_next_fp(struct un
>  		return -EINVAL;
>  
>  	/* Make sure that the address is word aligned */
> -	shift = sizeof(long) == 4 ? 2 : 3;
> -	if (cfa & ((1 << shift) - 1))
> +	if (cfa & (sizeof(long) - 1))
>  		return -EINVAL;
>  
>  	/* Find the Return Address (RA) */
> 


