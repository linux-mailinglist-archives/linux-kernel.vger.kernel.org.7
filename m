Return-Path: <linux-kernel+bounces-770674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ED5B27DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B30589061
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC0F2FE06B;
	Fri, 15 Aug 2025 09:58:48 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595652FCBE0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251928; cv=none; b=bUHtK5gG4owlgUcfL1p268nF23vWbox4XEVy0FfVt8gY2T91gGqxo1GNxXtDUJiP+5EjkmiG86hVQ9MtmSRGqZ22HNceZGj8/gJNBL2NvZ0VZb36lWNBNJEqGsNOts9aBvgTMmM9S8IAjE8b64vl7vMDBODqWHaKJvQ4oajO7Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251928; c=relaxed/simple;
	bh=V107UjHcydop6RCplKG1+8J7LGnPqeCcPa7ZlFGic9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VeOPkfUNSciXFhOQAIzmSMHuAe+wRU06jLWJ0WbECV8hKOnB0t0UDAwx3/w2Kkqpq30Bo2hCJ2SGuiFDJ+Br59PaeQb0cbVOFC+1ybkBO+NUpvjaaVYiGcuYSmOhYpAUsgChHqfNZ3R8sFTbgYtwhPYIe/HLfonN1hrAvpZJ6IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c3HXX13Gbz13NJr;
	Fri, 15 Aug 2025 17:55:08 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id E9854180486;
	Fri, 15 Aug 2025 17:58:34 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemp500007.china.huawei.com (7.202.195.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 17:58:34 +0800
Message-ID: <16d9e356-d0b0-4f62-9d92-9b696d7ffb4b@huawei.com>
Date: Fri, 15 Aug 2025 17:58:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: avoid redundant memcpy and sha256() for
 dedupe
To: wangzijie <wangzijie1@honor.com>, <hsiangkao@linux.alibaba.com>
CC: <bintian.wang@honor.com>, <feng.han@honor.com>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<stopire@gmail.com>, <xiang@kernel.org>
References: <f2c93019-5f92-4ee2-88bc-feda330d8a55@linux.alibaba.com>
 <20250815095449.4163442-1-wangzijie1@honor.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <20250815095449.4163442-1-wangzijie1@honor.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemp500007.china.huawei.com (7.202.195.151)

Hi Zijie,

It would be quite appreciated if you could help us polish the 
multithreading -Ededupe implementation. I will try to rebase the 
existing code to the latest codebase ASAP.

You could find the design decision in multithreading -Ededupe in this paper:

https://dl.acm.org/doi/pdf/10.1145/3671016.3671395


Thanks,

Yifan

On 2025/8/15 17:54, wangzijie wrote:
>> Hi Zijie,
>>
>> On 2025/8/15 16:44, wangzijie wrote:
>>> We have already use xxh64() for filtering first for dedupe, when we
>>> need to skip the same xxh64 hash, no need to do memcpy and sha256(),
>>> relocate the code to avoid it.
>>>
>>> Signed-off-by: wangzijie <wangzijie1@honor.com>
>> Thanks for the patch, it makes sense to me since we only keep one
>> record according to xxh64 (instead of sha256) for now:
>>
>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>
>> Although I think multi-threaded deduplication is more useful, see:
>> https://github.com/erofs/erofs-utils/issues/25
>> but I'm not sure if you're interested in it... ;-)
> Hi Xiang,
> Thank you for providing this information, I want to optimize mkfs time with
> dedupe option and send this patch. I will find time to research Yifan's demo
> of multi-threaded deduplication and try to provide some help.
>
>> Thanks,
>> Gao Xiang
>
>

