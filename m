Return-Path: <linux-kernel+bounces-641608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EB5AB13D0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 14:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B524317C393
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 12:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF22221286;
	Fri,  9 May 2025 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VM7q8w0D"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002B123184E
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795145; cv=none; b=FcUs1a6NAi8IZjDpjEpK0cT0FdeNOISDcSSC1lYpS2zlz9DnXkl7TocWOA+xadfkdGGgpxLMD4bqtQkPWhGEANpvN1apML7kVQ5CzjxMPXxXGZl0ZkQfjE2aqh10XVxIiKiFgGl0j91W5cGUE0ofaVUpViU6HTNHVX5KBIuGPwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795145; c=relaxed/simple;
	bh=h/N09pbexzYE+qk2m7nfdm7xlx2BYT1NlbACj5xI9lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pu89OnF9y7Dk7g5oiDLWal/lGatSDl1Iipr13Rm8UImdNI/MTMob8YX3HhsXX4WGoMfXS+ivoJ3hvmOM1FadzxUNq2Zk54D8z/8JS+D3ENP65V3h8Z2JHO2RlX5UKjM2iTTm/vnnUu58JXqG04A89O5u5Uql7QKyBn2dIq32SrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VM7q8w0D; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8a6fc2de-a2aa-497c-9938-ff66f18ef097@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746795130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EganV1pOL8M2SSHAnKvcj8ajVnaVjVE4HDPaqbaAc40=;
	b=VM7q8w0D43/CF/jbWDcht+Wv3+3/IpTgz+yUNA0IOhhYl9Y8HafuY9ddSULS2rP8cNIdxt
	uZZmH6HJNHSD2B15ib4Ct41LAN9nwVYM3eo5rVI7XiKT2RPd1mmkVuw5HiiIPl7zBeazb0
	OKk8dgqKyw+0mzWMTeWRORUVJYX7Sss=
Date: Fri, 9 May 2025 14:52:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v2 2/2] RDMA/rxe: Enable asynchronous prefetch
 for ODP MRs
To: Daisuke Matsuda <dskmtsd@gmail.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
References: <20250503134224.4867-1-dskmtsd@gmail.com>
 <20250503134224.4867-3-dskmtsd@gmail.com>
 <dbc1bcdf-144d-44d2-8fc8-77bc2ad58b51@linux.dev>
 <2a6081b8-1772-4064-97d8-70d636b1868e@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <2a6081b8-1772-4064-97d8-70d636b1868e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 09.05.25 14:19, Daisuke Matsuda wrote:
> 
> 
> On 2025/05/06 0:25, Zhu Yanjun wrote:
>> On 03.05.25 15:42, Daisuke Matsuda wrote:
>>> Calling ibv_advise_mr(3) with flags other than IBV_ADVISE_MR_FLAG_FLUSH
>>> invokes asynchronous requests. It is best-effort, and thus can safely be
>>> deferred to the system-wide workqueue.
>>>
>>> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
>>
>> I have made tests with rdma-core after applying this patch series. It 
>> seems that it can work well.
>> I read through this commit. Other than the following minor problems, I 
>> am fine with this commit.
>>
>> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>>> ---
>>>   drivers/infiniband/sw/rxe/rxe_odp.c | 81 ++++++++++++++++++++++++++++-
>>>   1 file changed, 80 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c 
>>> b/drivers/infiniband/sw/rxe/rxe_odp.c
>>> index e5c60b061d7e..d98b385a18ce 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
>>> @@ -425,6 +425,73 @@ enum resp_states rxe_odp_do_atomic_write(struct 
>>> rxe_mr *mr, u64 iova, u64 value)
>>>       return RESPST_NONE;
>>>   }
>>> +struct prefetch_mr_work {
>>> +    struct work_struct work;
>>> +    u32 pf_flags;
>>> +    u32 num_sge;
>>> +    struct {
>>> +        u64 io_virt;
>>> +        struct rxe_mr *mr;
>>> +        size_t length;
>>> +    } frags[];
>>> +};
>>
>> The struct prefetch_mr_work should be moved into header file? IMO, it 
>> is better to move this struct to rxe_loc.h?
> 
> This struct is not likely to be used in other files.
> I think leaving it here would be easier for other developers to 
> understand because relevant codes are gathered.
> If there is any specific reason to move, I will do so.
> 
>>
>>> +
>>> +static void rxe_ib_prefetch_mr_work(struct work_struct *w)
>>> +{
>>> +    struct prefetch_mr_work *work =
>>> +        container_of(w, struct prefetch_mr_work, work);
>>> +    int ret;
>>> +    u32 i;
>>> +
>>> +    /* We rely on IB/core that work is executed if we have num_sge 
>>> != 0 only. */
>>> +    WARN_ON(!work->num_sge);
>>> +    for (i = 0; i < work->num_sge; ++i) {
>>> +        struct ib_umem_odp *umem_odp;
>>> +
>>> +        ret = rxe_odp_do_pagefault_and_lock(work->frags[i].mr, 
>>> work->frags[i].io_virt,
>>> +                            work->frags[i].length, work->pf_flags);
>>> +        if (ret < 0) {
>>> +            rxe_dbg_mr(work->frags[i].mr, "failed to prefetch the 
>>> mr\n");
>>> +            continue;
>>> +        }
>>> +
>>> +        umem_odp = to_ib_umem_odp(work->frags[i].mr->umem);
>>> +        mutex_unlock(&umem_odp->umem_mutex);
>>
>> Obviously this function is dependent on the mutex lock umem_mutex. So 
>> in the beginning of this function, it is better to  add 
>> lockdep_assert_held(&umem_odp->umem_mutex)?
> 
> The mutex **must not** be locked at the beginning, so
> perhaps we can add lockdep_assert_not_held() instead at the beginning,
> but this one is not used frequently, and we can do without that.
> 
> umem_mutex is locked in rxe_odp_do_pagefault_and_lock() in the for loop.
> The function calls ib_umem_odp_map_dma_and_lock(), which locks the mutex 
> only when pagefault is successful.

Sure. umem_mutex is locked in other functions. It is not necessary to 
use lockdep_assert_held at the beginning of this function.

Zhu Yanjun

> If ib_umem_odp_map_dma_and_lock() fails, an error is returned and then 
> the mutex is not locked.
> 
> Daisuke
> 
>>
>> Zhu Yanjun
>>
>>> +    }
>>> +
>>> +    kvfree(work);
>>> +}
>>> +
>>> +static int rxe_init_prefetch_work(struct ib_pd *ibpd,
>>> +                  enum ib_uverbs_advise_mr_advice advice,
>>> +                  u32 pf_flags, struct prefetch_mr_work *work,
>>> +                  struct ib_sge *sg_list, u32 num_sge)
>>> +{
>>> +    struct rxe_pd *pd = container_of(ibpd, struct rxe_pd, ibpd);
>>> +    u32 i;
>>> +
>>> +    INIT_WORK(&work->work, rxe_ib_prefetch_mr_work);
>>> +    work->pf_flags = pf_flags;
>>> +
>>> +    for (i = 0; i < num_sge; ++i) {
>>> +        struct rxe_mr *mr;
>>> +
>>> +        mr = lookup_mr(pd, IB_ACCESS_LOCAL_WRITE,
>>> +                   sg_list[i].lkey, RXE_LOOKUP_LOCAL);
>>> +        if (IS_ERR(mr)) {
>>> +            work->num_sge = i;
>>> +            return PTR_ERR(mr);
>>> +        }
>>> +        work->frags[i].io_virt = sg_list[i].addr;
>>> +        work->frags[i].length = sg_list[i].length;
>>> +        work->frags[i].mr = mr;
>>> +
>>> +        rxe_put(mr);
>>> +    }
>>> +    work->num_sge = num_sge;
>>> +    return 0;
>>> +}
>>> +
>>>   static int rxe_ib_prefetch_sg_list(struct ib_pd *ibpd,
>>>                      enum ib_uverbs_advise_mr_advice advice,
>>>                      u32 pf_flags, struct ib_sge *sg_list,
>>> @@ -478,6 +545,8 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd 
>>> *ibpd,
>>>                        u32 flags, struct ib_sge *sg_list, u32 num_sge)
>>>   {
>>>       u32 pf_flags = RXE_PAGEFAULT_DEFAULT;
>>> +    struct prefetch_mr_work *work;
>>> +    int rc;
>>>       if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH)
>>>           pf_flags |= RXE_PAGEFAULT_RDONLY;
>>> @@ -490,7 +559,17 @@ static int rxe_ib_advise_mr_prefetch(struct 
>>> ib_pd *ibpd,
>>>           return rxe_ib_prefetch_sg_list(ibpd, advice, pf_flags, 
>>> sg_list,
>>>                              num_sge);
>>> -    /* Asynchronous call is "best-effort" */
>>> +    /* Asynchronous call is "best-effort" and allowed to fail */
>>> +    work = kvzalloc(struct_size(work, frags, num_sge), GFP_KERNEL);
>>> +    if (!work)
>>> +        return -ENOMEM;
>>> +
>>> +    rc = rxe_init_prefetch_work(ibpd, advice, pf_flags, work, 
>>> sg_list, num_sge);
>>> +    if (rc) {
>>> +        kvfree(work);
>>> +        return rc;
>>> +    }
>>> +    queue_work(system_unbound_wq, &work->work);
>>>       return 0;
>>>   }
>>
> 


