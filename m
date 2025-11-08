Return-Path: <linux-kernel+bounces-891240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F75CC4239E
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 02:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E97664E2684
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 01:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621FA29DB65;
	Sat,  8 Nov 2025 01:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I5rSzadg"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED42280CC9
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 01:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762564327; cv=none; b=bi7A66Q4NxZ5zEvgSFPdxJ9kZuj+cgXTOFyl8bCA0CzLxASGDJ6Ap3XCye2tXo1TFNzmFGLXy0ap2Z6G8uupAnAxCTTTbPOdWfzanPhxsZWNRVYLxC4n550B3gH5iPZD1fNhyu04XFwiGjdXJCcnCN0+80jfcgTJDeQx8vIAkYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762564327; c=relaxed/simple;
	bh=5KqDn4pqwaFP67oJfEASAYElCFOwmnkW8Ys2b3kSXm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1ycj8IdhAwnp2KQkoPK9MYtILYcvjD0R291Kxdh/XSYllERtIo6kiOXMpSzFX6kaYhKLleodMfN0MQN86SH3bRCBIiVAVqqw6v6rwkZJw2TRiN0hK3siEWA6ST6TyDRdRmgg1RlBInakiJIuDV3o1pU+LBYt6I0n/MPYXGV27c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I5rSzadg; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 7 Nov 2025 17:11:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762564323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZbaHET7zK1X93cUl1eWP2E4xGTD3LFygd8aVoi2Wrw=;
	b=I5rSzadgX52p8BgtcjjBQ1EnC0y/Iix4dKzL789+/HBp1XeHGhz7OPqARZUbg4/LwgeTaQ
	FTtFXHqsnUeZJRTbcJ2FlbVPupoPbHqRNZE4kljiXWx637jsItRXEcaKDJ8hMEil0zxa8e
	6nsY1JEVd0UfcjFkyISfEz/K9ppS+lo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/vmscan: skip increasing kswapd_failures when
 reclaim was boosted
Message-ID: <e5bdgvhyr6ainrwyfybt6szu23ucnsvlgn4pv2xdzikr4p3ka4@hyyhkudfcorw>
References: <20251024022711.382238-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251024022711.382238-1-jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 24, 2025 at 10:27:11AM +0800, Jiayuan Chen wrote:
> We encountered a scenario where direct memory reclaim was triggered,
> leading to increased system latency:
> 
> 1. The memory.low values set on host pods are actually quite large, some
>    pods are set to 10GB, others to 20GB, etc.
> 2. Since most pods have memory protection configured, each time kswapd is
>    woken up, if a pod's memory usage hasn't exceeded its own memory.low,
>    its memory won't be reclaimed.

Can you share the numa configuration of your system? How many nodes are
there?

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

Am I understanding this correctly that watermark boost increase the
chances of this issue but it can still happen?

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
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> 
> ---
> v1 -> v2: Do not modify memory.low handling
> https://lore.kernel.org/linux-mm/20251014081850.65379-1-jiayuan.chen@linux.dev/
> ---
>  mm/vmscan.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 92f4ca99b73c..fa8663781086 100644
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

In general I think not incrementing the failure for boosted kswapd
iteration is right. If this issue (high protection causing kswap
failures) happen on non-boosted case, I am not sure what should be right
behavior i.e. allocators doing direct reclaim potentially below low
protection or allowing kswapd to reclaim below low. For min, it is very
clear that direct reclaimer has to reclaim as they may have to trigger
oom-kill. For low protection, I am not sure.


