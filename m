Return-Path: <linux-kernel+bounces-735912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4225B09528
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9481C4733A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37664212B0A;
	Thu, 17 Jul 2025 19:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qUZnas5/"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E181A3177
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752781667; cv=none; b=Nu3X6wqe+flMg8yOPIvpOwv9mPUS6ETqhAAiL42MgtTK9WPYvuhP2HM/sHJi1tlElIoqOCKNW3I1kHk4/9Sge5pgKmAM1vLYYgW3RSMQAjzVaQ9y5O4z+LNoiwOPInfgJfxKvipqV/nSIcRR9vBsbXKlSW+CNGAA1qv5qGBb8Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752781667; c=relaxed/simple;
	bh=8EU5RZkOr9w246jZgEa5ZMLg/xdhvInjQOdF2qT6S2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWDKhK8z11RAtrNDSnurBjdYPCKLzSXymoQU6a6XTk7sny4hRV1SZmzTCI590tAUt/NangARiJGG/gDn+daP2rCV2z/nPI3ON/pWfcp7kKInTmA0m/P4Gm8BdHXCExB8Mk2c5qky2npR34TPfaJAjk/p+9g5f9jr/vY7Iw8QYFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qUZnas5/; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 17 Jul 2025 12:47:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752781662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LTcOOeh9jbiQH0ZRsc0tYHUQUX5dHK6KVzy+NE67bU8=;
	b=qUZnas5/mlZVVjUq09//K0yKxN2SRkikK55pb6rmgTkA8J814VUvfVWKVjuvTLD9QY3PDA
	ruzGslTxL3bfzg+V8wuHU/KpCywwXa7XcG9+74q/fBWrqKESJ8aXUWYzZ2+gBU9zhldWPa
	+kJz/7OCXmayHIIq9onEBU0tYSdMwKk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, yuzhao@google.com, yuanchu@google.com, 
	mhocko@kernel.org, lorenzo.stoakes@oracle.com, kinseyho@google.com, 
	hannes@cmpxchg.org, gthelen@google.com, david@redhat.com, axelrasmussen@google.com, 
	zhengqi.arch@bytedance.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH] mm/mglru: Update MG-LRU proactive reclaim statistics
 only to memcg
Message-ID: <z3n3dfpgrctgf3mlkqydmos2svh353v3qzd22n4g3iygji6rsr@4l4zgkrl5w35>
References: <20250717082845.34673-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717082845.34673-1-jiahao.kernel@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Hao,

On Thu, Jul 17, 2025 at 04:28:45PM +0800, Hao Jia wrote:
> From: Hao Jia <jiahao1@lixiang.com>
> 
> Users can use /sys/kernel/debug/lru_gen to trigger proactive memory reclaim
> of a specified memcg.

Are you using this interface for proactively reclaiming a specific
memcg? I see run_cmd() using mem_cgroup_from_id() to get memcg from a
given id but I don't think we expose ids from mem_cgroup_ids to the
userspace. Usually we use cgroup_id which is just an inode number for
the cgroup folder. I wonder if the current users of this interface are
providing memcg id.

> Currently, statistics such as pgrefill, pgscan and
> pgsteal will be updated to the /proc/vmstat system memory statistics.
> 
> This will confuse some system memory pressure monitoring tools, making
> it difficult to determine whether pgscan and pgsteal are caused by
> system-level pressure or by proactive memory reclaim of some specific
> memory cgroup.
> 
> Therefore, make this interface behave similarly to memory.reclaim.
> Update proactive memory reclaim statistics only to its memory cgroup.
> 
> Signed-off-by: Hao Jia <jiahao1@lixiang.com>

The patch looks fine though.

> ---
>  mm/vmscan.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f8dfd2864bbf..bc92ec338065 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5545,6 +5545,7 @@ static int run_cmd(char cmd, int memcg_id, int nid, unsigned long seq,
>  	if (memcg_id != mem_cgroup_id(memcg))
>  		goto done;
>  
> +	sc->target_mem_cgroup = memcg;
>  	lruvec = get_lruvec(memcg, nid);
>  
>  	if (swappiness < MIN_SWAPPINESS)
> @@ -5581,6 +5582,7 @@ static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
>  		.may_swap = true,
>  		.reclaim_idx = MAX_NR_ZONES - 1,
>  		.gfp_mask = GFP_KERNEL,
> +		.proactive = true,
>  	};
>  
>  	buf = kvmalloc(len + 1, GFP_KERNEL);
> -- 
> 2.34.1
> 

