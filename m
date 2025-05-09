Return-Path: <linux-kernel+bounces-641933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7A1AB1840
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 17:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57E1189AFF2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 15:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060D422D4FD;
	Fri,  9 May 2025 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rNMBIrhb"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40E1212B3E
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803983; cv=none; b=huqVqy+pW2pLJRvDyxLWgM3ZZMD4vUNpCK9Fl+qA89giNFJYa6AurjjiC08gLwgb7sEyPhNBZu+6jR5XWnBvGnQqKwhJNNIFJrqU7penl2okI2jq5NJwTe2MFXLXa9d5Q6ZilQ/iIsn4T+6/sTPXX7m2METYP/HT0FKvmQdX1IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803983; c=relaxed/simple;
	bh=2xHWD4KLfdNpzQ97wTKuNF6OyatfQp6W3sjEptEz6RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TIGm2Sl4SNeZc2FWrOxt/L3Y/3S2QSO5QdQjGc1Dru+5qcoHDpya/JG9mQ9PtqA+SnCZZEObG7LLLlMFaQa06DONfq6mVDeAMzxdMMmEYSnd+oOGtWyCBF6jcsZpUw339lEZ40KoqG1voaD0aoKafuldI0WV32HIfD2agkMiLcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rNMBIrhb; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cdea578b-5570-4a8d-98cc-61081a281a84@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746803967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y6xXAi6Y6zyC7gogZ2MCtrxpjOOwSTEh1MN+VnZXjk4=;
	b=rNMBIrhbb4mYp7nTa6mvh8zkijnl5oliIvISBkrgxRbF2bsfSVv2Uy7ieFSUoGI0/vkw/M
	r9VI5HKFDGot8j4WDiVRqg7dJvQ2Rg6dTf+oX3KpYGTx1i5uQiYyYmuYXPwVEzR3tGmhTK
	XCKVR6UY29qau0047wDcxkPJbI1mc5o=
Date: Fri, 9 May 2025 17:19:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v2 1/2] RDMA/rxe: Implement synchronous prefetch
 for ODP MRs
To: Daisuke Matsuda <dskmtsd@gmail.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
References: <20250503134224.4867-1-dskmtsd@gmail.com>
 <20250503134224.4867-2-dskmtsd@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250503134224.4867-2-dskmtsd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 03.05.25 15:42, Daisuke Matsuda wrote:
> Minimal implementation of ibv_advise_mr(3) requires synchronous calls being
> successful with the IBV_ADVISE_MR_FLAG_FLUSH flag. Asynchronous requests,
> which are best-effort, will be added subsequently.
> 
> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe.c     |  7 +++
>   drivers/infiniband/sw/rxe/rxe_loc.h | 10 ++++
>   drivers/infiniband/sw/rxe/rxe_odp.c | 86 +++++++++++++++++++++++++++++
>   3 files changed, 103 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 3a77d6db1720..e891199cbdef 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -34,6 +34,10 @@ void rxe_dealloc(struct ib_device *ib_dev)
>   	mutex_destroy(&rxe->usdev_lock);
>   }
>   
> +static const struct ib_device_ops rxe_ib_dev_odp_ops = {
> +	.advise_mr = rxe_ib_advise_mr,
> +};
> +
>   /* initialize rxe device parameters */
>   static void rxe_init_device_param(struct rxe_dev *rxe, struct net_device *ndev)
>   {
> @@ -103,6 +107,9 @@ static void rxe_init_device_param(struct rxe_dev *rxe, struct net_device *ndev)
>   		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_SRQ_RECV;
>   		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_FLUSH;
>   		rxe->attr.odp_caps.per_transport_caps.rc_odp_caps |= IB_ODP_SUPPORT_ATOMIC_WRITE;
> +
> +		/* set handler for ODP prefetching API - ibv_advise_mr(3) */
> +		ib_set_device_ops(&rxe->ib_dev, &rxe_ib_dev_odp_ops);
>   	}
>   }
>   
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index f7dbb9cddd12..21b070f3dbb8 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -197,6 +197,9 @@ enum resp_states rxe_odp_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
>   int rxe_odp_flush_pmem_iova(struct rxe_mr *mr, u64 iova,
>   			    unsigned int length);
>   enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value);
> +int rxe_ib_advise_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
> +		     u32 flags, struct ib_sge *sg_list, u32 num_sge,
> +		     struct uverbs_attr_bundle *attrs);
>   #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>   static inline int
>   rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
> @@ -225,6 +228,13 @@ static inline enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr,
>   {
>   	return RESPST_ERR_UNSUPPORTED_OPCODE;
>   }
> +static inline int rxe_ib_advise_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
> +				   u32 flags, struct ib_sge *sg_list, u32 num_sge,
> +				   struct uverbs_attr_bundle *attrs)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>   
>   #endif /* RXE_LOC_H */
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index 6149d9ffe7f7..e5c60b061d7e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -424,3 +424,89 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>   
>   	return RESPST_NONE;
>   }
> +
> +static int rxe_ib_prefetch_sg_list(struct ib_pd *ibpd,
> +				   enum ib_uverbs_advise_mr_advice advice,
> +				   u32 pf_flags, struct ib_sge *sg_list,
> +				   u32 num_sge)
> +{
> +	struct rxe_pd *pd = container_of(ibpd, struct rxe_pd, ibpd);
> +	unsigned int i;
> +	int ret = 0;
> +
> +	for (i = 0; i < num_sge; ++i) {
> +		struct rxe_mr *mr;
> +		struct ib_umem_odp *umem_odp;
> +
> +		mr = lookup_mr(pd, IB_ACCESS_LOCAL_WRITE,
> +			       sg_list[i].lkey, RXE_LOOKUP_LOCAL);
> +
> +		if (IS_ERR(mr)) {
> +			rxe_dbg_pd(pd, "mr with lkey %x not found\n", sg_list[i].lkey);
> +			return PTR_ERR(mr);
> +		}
> +
> +		if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
> +		    !mr->umem->writable) {
> +			rxe_dbg_mr(mr, "missing write permission\n");
> +			rxe_put(mr);
> +			return -EPERM;
> +		}
> +
> +		ret = rxe_odp_do_pagefault_and_lock(mr, sg_list[i].addr,
> +						    sg_list[i].length, pf_flags);
> +		if (ret < 0) {
> +			if (sg_list[i].length == 0)
> +				continue;
> +
> +			rxe_dbg_mr(mr, "failed to prefetch the mr\n");
> +			rxe_put(mr);
> +			return ret;
> +		}
> +
> +		umem_odp = to_ib_umem_odp(mr->umem);
> +		mutex_unlock(&umem_odp->umem_mutex);
> +
> +		rxe_put(mr);
> +	}
> +
> +	return 0;
> +}
> +
> +static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
> +				     enum ib_uverbs_advise_mr_advice advice,
> +				     u32 flags, struct ib_sge *sg_list, u32 num_sge)
> +{
> +	u32 pf_flags = RXE_PAGEFAULT_DEFAULT;
> +
> +	if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH)
> +		pf_flags |= RXE_PAGEFAULT_RDONLY;
> +
> +	if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
> +		pf_flags |= RXE_PAGEFAULT_SNAPSHOT;
> +
> +	/* Synchronous call */
> +	if (flags & IB_UVERBS_ADVISE_MR_FLAG_FLUSH)
> +		return rxe_ib_prefetch_sg_list(ibpd, advice, pf_flags, sg_list,
> +					       num_sge);
> +
> +	/* Asynchronous call is "best-effort" */

Asynchronous call is not implemented now, why does this comment appear?

Zhu Yanjun

> +
> +	return 0;
> +}
> +
> +int rxe_ib_advise_mr(struct ib_pd *ibpd,
> +		     enum ib_uverbs_advise_mr_advice advice,
> +		     u32 flags,
> +		     struct ib_sge *sg_list,
> +		     u32 num_sge,
> +		     struct uverbs_attr_bundle *attrs)
> +{
> +	if (advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH &&
> +	    advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
> +	    advice != IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_NO_FAULT)
> +		return -EOPNOTSUPP;
> +
> +	return rxe_ib_advise_mr_prefetch(ibpd, advice, flags,
> +					 sg_list, num_sge);
> +}


