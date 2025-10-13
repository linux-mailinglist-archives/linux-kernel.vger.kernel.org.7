Return-Path: <linux-kernel+bounces-850378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC78BD2A84
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F4A189C427
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC4530596B;
	Mon, 13 Oct 2025 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FONJ52u6"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A78730597B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352846; cv=none; b=r3NrffKXC1t6111oy94Qp0K0kDWPzQST5hAY7VbekgW3g27kFZcIBJxP6N8UtMFxqlGKrV/0iWOsndmfB7dKdxGYTaG7marXGN78t90ROJ47qshrsf7zPhmtB3pExYtAfMo6daRCBRHD7dKT43AvXE+2DOCfGB3hQ/4lEfxZRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352846; c=relaxed/simple;
	bh=fo2RqUTcyutivecZR8WGprOJS3KT913GtBs+zJ6Fcao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gkZHmiEX7wFHB1hda3CO3Ib1XoaYbeafzhzThpeTAAJhTvz+zQumFLgdAIlU/m9EMBwQKxXDJ1ZKutJhhkjKuVnSR2E6YlFeG7lr5AIq9cH3OJeSGN5kK9JZztgXhLhWjN9KL8QYHI7ySJ5VgAA28yQcqBLD7qhjUGrlbSa6kU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FONJ52u6; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760352840; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=7av/l3Moeie30gOardFP+67jNH1eurZJ1Kd7+FIS0wc=;
	b=FONJ52u6l5i+3n6ETv2fCb76eOTfv2Eeq2AZGzIliUYetOs4WuWa8UIFV3G/KkxSNDEGuZrMAwdf3nTXk4ybWGzi42cLA4De+3dkR4kOF8sA2LedTXbael/udibyEUtJLTgrfewwxFZRn93pIr8isF+oo4PfQ6Mqh3ZJisMe0sM=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wq2kNLH_1760352830 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Oct 2025 18:53:58 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Luo Gengkun <luogengkun@huaweicloud.com>
Cc: mingo@redhat.com,  peterz@infradead.org,  juri.lelli@redhat.com,
  vincent.guittot@linaro.org,  dietmar.eggemann@arm.com,
  rostedt@goodmis.org,  bsegall@google.com,  mgorman@suse.de,
  vschneid@redhat.com,  huang.ying.caritas@gmail.com,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/topology: Fix memory leak in the error path of
 sched_init_numa
In-Reply-To: <20251013041348.350886-1-luogengkun@huaweicloud.com> (Luo
	Gengkun's message of "Mon, 13 Oct 2025 04:13:48 +0000")
References: <20251013041348.350886-1-luogengkun@huaweicloud.com>
Date: Mon, 13 Oct 2025 18:53:48 +0800
Message-ID: <87ikgjt6mb.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Luo Gengkun <luogengkun@huaweicloud.com> writes:

> In sched_init_numa, masks are used to store memory, but the error path
> returns directly without freeing the allocated memory.
> To fix this, the freeing logic in sched_reset_numa can be extraced into a
> new function, free_masks, which can be called on the error path.

Good catch!  Thanks!

> Fixes: 0fb3978b0aac ("sched/numa: Fix NUMA topology for systems with CPU-less nodes")
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> ---
>  kernel/sched/topology.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 444bdfdab731..fd03bb6669f5 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1924,6 +1924,20 @@ static void init_numa_topology_type(int offline_node)
>  
>  #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
>  
> +static void free_masks(struct cpumask ***masks, int nr_levels)

The function name appears too general.  How about __sched_free_masks()?

> +{
> +	int i, j;
> +
> +	for (i = 0; i < nr_levels && masks; i++) {
> +		if (!masks[i])
> +			continue;
> +		for_each_node(j)
> +			kfree(masks[i][j]);
> +		kfree(masks[i]);
> +	}
> +	kfree(masks);
> +}
> +
>  void sched_init_numa(int offline_node)
>  {
>  	struct sched_domain_topology_level *tl;
> @@ -2003,15 +2017,19 @@ void sched_init_numa(int offline_node)
>  	 */
>  	for (i = 0; i < nr_levels; i++) {
>  		masks[i] = kzalloc(nr_node_ids * sizeof(void *), GFP_KERNEL);
> -		if (!masks[i])
> +		if (!masks[i]) {
> +			free_masks(masks, nr_levels);
>  			return;
> +		}
>  
>  		for_each_cpu_node_but(j, offline_node) {
>  			struct cpumask *mask = kzalloc(cpumask_size(), GFP_KERNEL);
>  			int k;
>  
> -			if (!mask)
> +			if (!mask) {
> +				free_masks(masks, nr_levels);
>  				return;
> +			}
>  
>  			masks[i][j] = mask;
>  
> @@ -2079,18 +2097,9 @@ static void sched_reset_numa(void)
>  	masks = sched_domains_numa_masks;
>  	rcu_assign_pointer(sched_domains_numa_masks, NULL);
>  	if (distances || masks) {
> -		int i, j;
> -
>  		synchronize_rcu();
>  		kfree(distances);
> -		for (i = 0; i < nr_levels && masks; i++) {
> -			if (!masks[i])
> -				continue;
> -			for_each_node(j)
> -				kfree(masks[i][j]);
> -			kfree(masks[i]);
> -		}
> -		kfree(masks);
> +		free_masks(masks, nr_levels);
>  	}
>  	if (sched_domain_topology_saved) {
>  		kfree(sched_domain_topology);

Otherwise, the patch LGTM.  Feel free to add my

Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>

in the future versions.

---
Best Regards,
Huang, Ying

