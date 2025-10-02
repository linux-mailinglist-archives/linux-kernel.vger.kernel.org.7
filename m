Return-Path: <linux-kernel+bounces-839746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668A4BB24F3
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 03:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305C73B1E31
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 01:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EE01482F2;
	Thu,  2 Oct 2025 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EBMo7NOK"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F168EA59
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 01:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759370328; cv=none; b=C6IVhF+VpuTzsMLrswvhotlDaF0K+XtWaEJjM+6C9mQrMZY4cIIvF4GzvBHTLZ+KaNJRiYKTgW0bHN23QeGzgUkZVi3ZJvlpEhLQWlXn86MMYScKQbXMOuhaVMQUCNdXZO66i18WNcXJPj2424Hv7sCpvnhe5EcuAcc1HRshSxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759370328; c=relaxed/simple;
	bh=YufCdfcenG1M8YhjLUdYtSD9vMRXMicvB/f8kXJEIQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UF8imlya1RjaKVt5lDz+Vemw8buSypuFIL7fMcw0NyAcugsXuqims5Y0VVLKLLg/LuCyuNDeBgNMTZan0xXIP3Zk9t/Ivhh/rpDWgYKB0fNM9QNr1eDnJONC9NLcZCw/aj4wD6ofyTXcjdEplB51VHrHwWAhtnMlCwVeRLpAC5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EBMo7NOK; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a647617f-add7-499c-81c9-a5ed628e34f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759370322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGJj77OJTJPdfBOSmZlqr5kypF1L3WfLsVzSKBfYABs=;
	b=EBMo7NOKA303LIr+j3Uw8EFdp5qc6UaffZTX1Y1PftVy86HHaW+EYWawkURYOvRx+EvFsR
	uPHbv9w2XK2x6YoxacfI6ZjLgklN2baW8h+sVETQXeDZ4gQMNyQvuGAWfkA5uTjLilIyR4
	5YjGTQ06U2PzWD0/O8mHZxrDdkzA3+c=
Date: Thu, 2 Oct 2025 09:58:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] mm/page_owner: Rename proc-prefixed variables for
 clarity
To: Hu Song <husong@kylinos.cn>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250930092153.843109-1-husong@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <20250930092153.843109-1-husong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/30 17:21, Hu Song 写道:
> From: Song Hu <husong@kylinos.cn>
>
> The `proc_page_owner_operations` and related variables were renamed to
> `page_owner_fops` to better reflect their association with `debugfs` rather
> than `/proc`. This improves code clarity and aligns with kernel naming
> conventions.
>
> Signed-off-by: Song Hu <husong@kylinos.cn>


Reviewed-by: Ye Liu <liuye@kylinos.cn>

> ---
>  mm/page_owner.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index c3ca21132c2c..bb88b72b6062 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -848,7 +848,7 @@ static void init_early_allocated_pages(void)
>  		init_zones_in_node(pgdat);
>  }
>  
> -static const struct file_operations proc_page_owner_operations = {
> +static const struct file_operations page_owner_fops = {
>  	.read		= read_page_owner,
>  	.llseek		= lseek_page_owner,
>  };
> @@ -929,7 +929,7 @@ static int page_owner_stack_open(struct inode *inode, struct file *file)
>  	return seq_open_private(file, &page_owner_stack_op, 0);
>  }
>  
> -static const struct file_operations page_owner_stack_operations = {
> +static const struct file_operations page_owner_stack_fops = {
>  	.open		= page_owner_stack_open,
>  	.read		= seq_read,
>  	.llseek		= seq_lseek,
> @@ -948,7 +948,7 @@ static int page_owner_threshold_set(void *data, u64 val)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(proc_page_owner_threshold, &page_owner_threshold_get,
> +DEFINE_SIMPLE_ATTRIBUTE(page_owner_threshold_fops, &page_owner_threshold_get,
>  			&page_owner_threshold_set, "%llu");
>  
>  
> @@ -961,13 +961,12 @@ static int __init pageowner_init(void)
>  		return 0;
>  	}
>  
> -	debugfs_create_file("page_owner", 0400, NULL, NULL,
> -			    &proc_page_owner_operations);
> +	debugfs_create_file("page_owner", 0400, NULL, NULL, &page_owner_fops);
>  	dir = debugfs_create_dir("page_owner_stacks", NULL);
>  	debugfs_create_file("show_stacks", 0400, dir, NULL,
> -			    &page_owner_stack_operations);
> +			     &page_owner_stack_fops);
>  	debugfs_create_file("count_threshold", 0600, dir, NULL,
> -			    &proc_page_owner_threshold);
> +			    &page_owner_threshold_fops);
>  
>  	return 0;
>  }

-- 
Thanks,
Ye Liu


