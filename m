Return-Path: <linux-kernel+bounces-758591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56775B1D121
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 05:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2973B565A48
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CD61A254E;
	Thu,  7 Aug 2025 03:07:11 +0000 (UTC)
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FF9C133
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 03:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754536031; cv=none; b=pz6ktAhmNfKu9hPcBb5jptQYK3hJ4CYvthB2l2/ed8CyJAbARexT0C5ixPgOtxTjRR0SBb0M5//uAASocZZLVir/wkJMy6bb6wrkz2nBOJZF0XD2Ppt8MBZYXwt8/2kBDE3apEUcnVbGyjY2xlyrJ6yMahfGubJcW+v3gjnopuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754536031; c=relaxed/simple;
	bh=QXAExtGoYnkZNd29M/cfGlJacKDEtEnzWkJ21uO5gzo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9ZdQUUQSSfcvCl6ETucrjMd0+bRWyKIo+zBs2CfdlYnQogwJjloEUt1dPpR0+4sEvvmJ5T7+BIJNJJZ12CGuo+RL764O4Tj/Cb1rlBehvUtONSRpKWNXbhfk+9+fm6PNMvoxrJpj3sUR7Eav/y/l9Fphtjh1yKIRHwtQ5s0NyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: +dECrOpUR3GfMfqzLmRmNQ==
X-CSE-MsgGUID: 8853IuAbTgSN8PY41i3P6w==
X-IronPort-AV: E=Sophos;i="6.17,271,1747670400"; 
   d="scan'208";a="148487293"
Date: Thu, 7 Aug 2025 11:06:50 +0800
From: Fang Xiang <fangxiang3@xiaomi.com>
To: Zicheng Qu <quzicheng@huawei.com>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<tanghui20@huawei.com>, <zhangqiao22@huawei.com>, <judy.chenhui@huawei.com>
Subject: Re: [PATCH] sched/fair: Fix overflow in vruntime_eligible() causing
 NULL return
Message-ID: <aJQYShudNtx5eeVV@oa-fangxiang3.localdomain>
References: <20250709093829.3213647-1-quzicheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250709093829.3213647-1-quzicheng@huawei.com>
X-ClientProxiedBy: BJ-MBX05.mioffice.cn (10.237.8.125) To BJ-MBX15.mioffice.cn
 (10.237.8.135)

On Wed, Jul 09, 2025 at 09:38:29AM +0000, Zicheng Qu wrote:
> In the vruntime_eligible() function, the original comparison:
> 	return avg >= (s64)(vruntime - cfs_rq->min_vruntime) * load;
> could produce incorrect results due to integer overflow in the 'avg' or
> s64 part.
> 
> This overflow causes the comparison to return false even when the
> mathematical result should be true, leading all tasks to be falsely
> deemed ineligible. Consequently, pick_eevdf() returns NULL, triggering a
> kernel crash.
> 
> The best approach should be to dig deep into why overflow occurs, which
> attributes lead to the overflow, whether it is normal, and how to avoid
> it. Not pretty sure if this part of the modification will introduce new
> issues, but it may be incorrect to simply spot a potentially
> overflowing integer type and directly use the >= sign for comparison.
> Therefore, drawing on the enqueue method in the rb tree, to avoid the
> impact of overflow, the method of first performing subtraction and then
> comparing with 0 is also adopted.
> 
> The following are the relevant attributes that cause the return of NULL:
> crash> struct cfs_rq.avg_vruntime,avg_load,min_vruntime
> ffff9ea77ecb4280
>   avg_vruntime = -4392414779907141680,
>   avg_load = 28644,
>   min_vruntime = 239776551994501,
> 
> sched_entity: curr
> crash> struct sched_entity.deadline,min_vruntime,vruntime,load,vlag
> 0xffff9ea74510d800
>   deadline = 86432035728535,
>   min_vruntime = 86431486021988,
>   vruntime = 86431531134184,
>   load = {
>     weight = 6066,
>     inv_weight = 0
>   },
>   vlag = 86431823023195,
> 
> the sched_entity mapping to the root node in the cfs_rq
> crash> struct sched_entity.deadline,min_vruntime,vruntime,load,vlag -l
> sched_entity.run_node 0xffff9ea849fbc350
>   deadline = 18446615868453340281,
>   min_vruntime = 18446615868452621390,
>   vruntime = 18446615868453018539,
>   load = {
>     weight = 9777152,
>     inv_weight = 449829
>   },
>   vlag = -5599,
> 
> the sched_entity mapping to the leftmost node in the csf_rq, also the
> left child of root node.
> crash> struct sched_entity.deadline,min_vruntime,vruntime,load,vlag -l
> sched_entity.run_node 0xffff9ea78d0280d0
>   deadline = 18446615868452943132,
>   min_vruntime = 18446615868452621390,
>   vruntime = 18446615868452621390,
>   load = {
>     weight = 9777152,
>     inv_weight = 449829
>   },
>   vlag = 444143,
> 
> the sched_entity mapping to the rightmost node in the csf_rq, also the
> right child of root node.
> crash> struct sched_entity.deadline,min_vruntime,vruntime,load,vlag -l
> sched_entity.run_node 0xffff9ea783144350
>   deadline = 515705106937888,
>   min_vruntime = 515705106616146,
>   vruntime = 515705106616146,
>   load = {
>     weight = 9777152,
>     inv_weight = 449829
>   },
>   vlag = -260493,
> 
> Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7a14da5396fb..bfa4090cef93 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -734,7 +734,7 @@ static int vruntime_eligible(struct cfs_rq *cfs_rq, u64 vruntime)
>  		load += weight;
>  	}
>  
> -	return avg >= (s64)(vruntime - cfs_rq->min_vruntime) * load;
> +	return avg - (s64)(vruntime - cfs_rq->min_vruntime) * load >= 0;
>  }
>  
>  int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
> -- 
> 2.34.1
> 
May I ask which specific version of the 6.6 LTS branch are you using? 
On the 6.6.54 kernel version, I've also encountered the same issue in my device.
The following are the relevant attributes that cause the return of NULL in pick_eevdf():
cfs_rq:
  avg_vruntime = -34534164181975319,
  avg_load = 1531079,
  min_vruntime = 26052230711305,
  nr_running = 245,
  h_nr_running = 245,

sched_entity: curr is NULL

the sched_entity mapping to the root node in the cfs_rq
  deadline = 26052232578140,
  min_vruntime = 17382361763776,
  vruntime = 26052229578140,
  load = {
    weight = 1048576,
    inv_weight = 4194304
  },
  vlag = 656101,

the sched_entity mapping to the leftmost node in the csf_rq
  deadline = 17382364763776,
  min_vruntime = 17382361763776,
  vruntime = 17382361763776,
  load = {
    weight = 1048576,
    inv_weight = 4194304
  },
  vlag = 8648818863863,

