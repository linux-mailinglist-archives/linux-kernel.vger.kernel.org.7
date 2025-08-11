Return-Path: <linux-kernel+bounces-762761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D782B20AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484603A8FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7FF1E1C1A;
	Mon, 11 Aug 2025 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lqhaLi57"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3743217A309
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920182; cv=none; b=QRAqESMpn5EwClO9TRDM4+y4XVa7pQee3vf33Lo8WuRMOvdiA6vE7nQZF4KOAhM9bJsJTKzPAA46ExXacvmQ0KNaVK6O0XmQZ/U6ZW+IqCm+HSNMk/6/+XwEOk3h+FYpHkY9tj1KnA/sA04WKZuGaSOP043AzQoTx8Zxqz4Y+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920182; c=relaxed/simple;
	bh=16MYZdwOr2DIwfp0R+6/5ShdPVQOEm0KLR4Yoetd+1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RclVWCrpYUj2GhehbBq8/BmDjzx1QxIECgIgJz757hfeP5pK7w5aOeV8TN8FOziW/qfazt8bi9CwZJR/Ak05MOgfHXZfSpwL2/SI5mYvKEEU+k8vDelvAxSLq6HawPw5KtcYLkLouRiZuyUV8KSfbpvt1gjKeF5TiWdj2F7QcNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lqhaLi57; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2b593684-4409-485b-9edf-e44a402ecf3a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754920174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mH1dwGdtcwcbBs2MNBEYNTdWM+9bK1UZ13Yctjs7vxg=;
	b=lqhaLi57M/KrANS/X7T7w1BDIPJ5y8GOqLJVARpNB1BkjUNl/s6MXi8Dkmz1B2MBh7Puil
	fhv7B5eVn7XClsCeNdHT5tLJz5tX5CTiC5NRG90IVm6JLtg/klrxRebwYVg5NUn31fnD76
	kLp6c4Za0z7bk3Oy8dWCcBDZAGKtgOY=
Date: Mon, 11 Aug 2025 06:48:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] rdma_rxe: call comp_handler without holding cq->cq_lock
To: Philipp Reisner <philipp.reisner@linbit.com>,
 Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250806123921.633410-1-philipp.reisner@linbit.com>
 <5a31f3ef-358f-4382-8ad1-8050569a2a23@linux.dev>
 <CADGDV=UgDb51nEtdide7k8==urCdrWcig8kBAY6k0PryR0c7xw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CADGDV=UgDb51nEtdide7k8==urCdrWcig8kBAY6k0PryR0c7xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/8/10 22:26, Philipp Reisner 写道:
> On Thu, Aug 7, 2025 at 3:09 AM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>
>> 在 2025/8/6 5:39, Philipp Reisner 写道:
>>> Allow the comp_handler callback implementation to call ib_poll_cq().
>>> A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver.
>>> And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock deadlock.
>>>
>>> The Mellanox and Intel drivers allow a comp_handler callback
>>> implementation to call ib_poll_cq().
>>>
>>> Avoid the deadlock by calling the comp_handler callback without
>>> holding cq->cw_lock.
>>>
>>> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
>>
>> ERROR: test_resize_cq (tests.test_cq.CQTest.test_resize_cq)
>> Test resize CQ, start with specific value and then increase and decrease
>> ----------------------------------------------------------------------
>> Traceback (most recent call last):
>>     File "/root/deb/rdma-core/tests/test_cq.py", line 135, in test_resize_cq
>>       u.poll_cq(self.client.cq)
>>     File "/root/deb/rdma-core/tests/utils.py", line 687, in poll_cq
>>       wcs = _poll_cq(cq, count, data)
>>             ^^^^^^^^^^^^^^^^^^^^^^^^^
>>     File "/root/deb/rdma-core/tests/utils.py", line 669, in _poll_cq
>>       raise PyverbsError(f'Got timeout on polling ({count} CQEs remaining)')
>> pyverbs.pyverbs_error.PyverbsError: Got timeout on polling (1 CQEs
>> remaining)
>>
>> After I applied your patch in kervel v6.16, I got the above errors.
>>
>> Zhu Yanjun
>>
> 
> Hello Zhu,
> 
> When I run the test_resize_cq test in a loop (100 runs each) on the
> original code and with my patch, I get about the same failure rate.

Add Daisuke Matsuda

If I remember it correctly, when Daisuke and I discussed ODP patches, we 
both made tests with rxe, from our tests results, it seems that this 
test_resize_cq error does not occur.

Yanjun.Zhu

> 
> without my patch success=87 failure=13
> without my patch success=82 failure=18
> without my patch success=81 failure=19
> with my patch    success=89 failure=11
> with my patch    success=90 failure=10
> with my patch    success=82 failure=18
> 
> The patch I am proposing does not change the failure rate of this test.
> 
> Best regards,
>   Philipp
> 
> #!/bin/bash
> 
> success=0
> failure=0
> 
> for (( i = 0; i < 100; i++ )) do
>        if rdma-core/build/bin/run_tests.py -k test_resize_cq; then
>    success=$((success+1))
>        else
>    failure=$((failure+1))
>        fi
> done
> echo success=$success failure=$failure


