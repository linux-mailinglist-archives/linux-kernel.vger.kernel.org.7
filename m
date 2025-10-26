Return-Path: <linux-kernel+bounces-870195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F36C0A27F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 05:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 761804E199C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 04:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D696B21CFF6;
	Sun, 26 Oct 2025 04:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rr7R4bHX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398AD1990A7
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 04:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761453609; cv=none; b=GRgT6FfdoCbsDa3m62JdrzY+QyRShW4z5sZ25tJzziGpsZOiNuJsXkaLp/cMknV+9t7FjVPo7JFJx0tsItCtldubcrRqjAaLPm5tekK31KXWQW5/EpTr1IGLOzasGs56YSQoRnhAnVwxmIIERKo0VpIVPLed6B6La3L9QXLJCtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761453609; c=relaxed/simple;
	bh=FDldBYNu9OOsuTnGhGPzDkHwWzpYPvYf6kAIzN+sI+w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lJfG4q4aWAUwXf/xVshjyw7MsmQ/2Ma7RESMXycdSXDwxwItBi/px9t35Kkock1E0zYuJkc/idczwIMUdrxoM8SypvFdJfBJ60Yat3wvcKRWhHobt/4ysdkfVNsjKyhhD0z6MOEZWFWGoTCxfT8tGKJsWSzn7u664kus7BPnWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rr7R4bHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55075C4CEE7;
	Sun, 26 Oct 2025 04:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761453608;
	bh=FDldBYNu9OOsuTnGhGPzDkHwWzpYPvYf6kAIzN+sI+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rr7R4bHXfFhKR8vYgEqIjFNpfqFk6wc50HcffRyvSgULZ8KV6qM/7H+xOPpj0sQ5d
	 DO92mqomuCDC25HUD4JEm6vlX0QMqeZUtWRytw3C9t6v5O5FtQm4aeOS0zMLrr9JSI
	 x1mczdh0HdlJRxLCOV8ZRTofVv4YEyXVYrBJkcyE=
Date: Sat, 25 Oct 2025 21:40:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, David
 Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@kernel.org>, Qi Zheng
 <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Axel Rasmussen
 <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu
 <weixugc@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/vmscan: skip increasing kswapd_failures when
 reclaim was boosted
Message-Id: <20251025214007.736d659ee266a416c40aa6e5@linux-foundation.org>
In-Reply-To: <20251024022711.382238-1-jiayuan.chen@linux.dev>
References: <20251024022711.382238-1-jiayuan.chen@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 24 Oct 2025 10:27:11 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> We encountered a scenario where direct memory reclaim was triggered,
> leading to increased system latency:

Who is "we", if I may ask?

> 1. The memory.low values set on host pods are actually quite large, some
>    pods are set to 10GB, others to 20GB, etc.
> 2. Since most pods have memory protection configured, each time kswapd is
>    woken up, if a pod's memory usage hasn't exceeded its own memory.low,
>    its memory won't be reclaimed.
> 3. When applications start up, rapidly consume memory, or experience
>    network traffic bursts, the kernel reaches steal_suitable_fallback(),
>    which sets watermark_boost and subsequently wakes kswapd.
> 4. In the core logic of kswapd thread (balance_pgdat()), when reclaim is
>    triggered by watermark_boost, the maximum priority is 10. Higher
>    priority values mean less aggressive LRU scanning, which can result in
>    no pages being reclaimed during a single scan cycle:
> 
> if (nr_boost_reclaim && sc.priority == DEF_PRIORITY - 2)
>     raise_priority = false;
> 
> 5. This eventually causes pgdat->kswapd_failures to continuously
>    accumulate, exceeding MAX_RECLAIM_RETRIES, and consequently kswapd stops
>    working. At this point, the system's available memory is still
>    significantly above the high watermark — it's inappropriate for kswapd
>    to stop under these conditions.
> 
> The final observable issue is that a brief period of rapid memory
> allocation causes kswapd to stop running, ultimately triggering direct
> reclaim and making the applications unresponsive.
> 

This logic appears to be at least eight years old.  Can you suggest why
this issue is being observed after so much time?

>
> ...
>
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -7128,7 +7128,12 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
>  		goto restart;
>  	}
>  
> -	if (!sc.nr_reclaimed)
> +	/*
> +	 * If the reclaim was boosted, we might still be far from the
> +	 * watermark_high at this point. We need to avoid increasing the
> +	 * failure count to prevent the kswapd thread from stopping.
> +	 */
> +	if (!sc.nr_reclaimed && !boosted)
>  		atomic_inc(&pgdat->kswapd_failures);
>  

Thanks, I'll toss it in for testing and shall await reviewer input
before proceeding further.

