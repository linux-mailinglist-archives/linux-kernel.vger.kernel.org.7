Return-Path: <linux-kernel+bounces-776709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7128CB2D0B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8918D7B3942
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B894B1684AC;
	Wed, 20 Aug 2025 00:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vviL69Pa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90813BB48
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755649877; cv=none; b=cjBRDkYx9KonPgzzPNFjuAFnG1Pj4sg0xTfWs6gX/rBzf/I8U7v1dUtlCBuxyQO4wsScWLo5+ESBEpMhk3ylfAtfb1TR25aWC7agxzybQJ4EiMZirg68gUuI+vT3DPmMcVB+067TC5p2sSLqPX93yotMioE5CgoilxKWFvGah0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755649877; c=relaxed/simple;
	bh=a+rr+2zL+DBv7am64i01iujgX7lpz9V+YnwpK1m1TL0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SqehAmHAPy2eZxF6BN/7RO94sw2xvdQj2zjHsXvMtZNqGmLCmtpQKJn7PUoQ4lVL7A9i9HOPi67t1FT0PgVb9WSidzA5duohAD8TmXQoRJtQ7NkDi5hmZfpVcythz8usXBL+0uoV+lFDm26FcMItmUHTwCbRx/BJi8j7gCJoElA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vviL69Pa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083A3C113CF;
	Wed, 20 Aug 2025 00:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755649876;
	bh=a+rr+2zL+DBv7am64i01iujgX7lpz9V+YnwpK1m1TL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vviL69PaWq7ODy8RB7mn+u98Ymj7LRjtV+zSdyl5/BjX/YcJUxQASuMYO1De5A+BJ
	 5OI3NBA6tgOvf9ZXdisrYykHZ0zICR52Bjg7btgyFO7pfTaqM/MKmjvqmJWRXCMYdv
	 42Y/prdSa8yQx4UZVPmg4pvMSqyjGaW0tQaZiAlc=
Date: Tue, 19 Aug 2025 17:31:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, gaoxiang17
 <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH] mm/cma: add 'available count' and 'total count' to
 trace_cma_alloc_start
Message-Id: <20250819173115.55194150617998021b4130b9@linux-foundation.org>
In-Reply-To: <20250819134817.247495-1-gxxa03070307@gmail.com>
References: <20250819134817.247495-1-gxxa03070307@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 21:48:17 +0800 Xiang Gao <gxxa03070307@gmail.com> wrote:

> From: gaoxiang17 <gaoxiang17@xiaomi.com>
> 
> This makes cma info more intuitive during debugging.
> 
> ...
>
> --- a/include/trace/events/cma.h
> +++ b/include/trace/events/cma.h
>
> ...
>
>  	TP_STRUCT__entry(
>  		__string(name, name)
> -		__field(unsigned long, count)
> +		__field(unsigned long, request_count)
> +		__field(unsigned long, available_count)
> +		__field(unsigned long, total_count)
>  		__field(unsigned int, align)
>  	),
>  
>  	TP_fast_assign(
>  		__assign_str(name);
> -		__entry->count = count;
> +		__entry->count = request_count;
> +		__entry->available_count = available_count;
> +		__entry->total_count = total_count;
>  		__entry->align = align;
>  	),
>  
>  	TP_printk("name=%s count=%lu align=%u",
>  		  __get_str(name),
> -		  __entry->count,
> +		  __entry->request_count,
> +		  __entry->available_count,
> +		  __entry->total_count,
>  		  __entry->align)

adds three args to the printk but didn't add their conversions to the
printk control string?



