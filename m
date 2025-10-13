Return-Path: <linux-kernel+bounces-850085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B72C6BD1CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60CA7348971
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E575E2E9722;
	Mon, 13 Oct 2025 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BNutXIZ+"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CF82E8E14
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340581; cv=none; b=n5Nftl3YAnu9aOzYtRGQi/mPlW4l0TkZTPIKgLhx4bQd+7iF2raQ1SfQ37L1vJEO9cjo2oLGaJweSX5xiSpYeYNNi1EZ8OMJdMlVQn/dXHym36DQcfxKxpwa0J/QDlz+QcAKmuTIt1133hqayMgu/j2hprFcxN+u+lW2grbpPO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340581; c=relaxed/simple;
	bh=lh1ojtXM+TO/pCbuzBlCz8MfGt6zSeQlY0BcDmXgxRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LP9LrvbZ5c5wOT/sEXXtlOWMNst4NwwKK2WhHJxYYfTAazVV3q/4Vij9suK1YxQHFS/6xr2WhX7k9r43vVH7xZAfz+F76sSGZTxz2C3Y1AfVcaJpds2O0yxnWG8uzQ04xsNLnbQGdxxZ715ohylk/Nhe+ORGcnFLyYou4fg82no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BNutXIZ+; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ab6edd99-30a3-486c-bc47-ffcac3d93b51@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760340574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/vZP9HpsjeKEWQ9ykCUaY7omAgoRs+k/b14bmmT76T0=;
	b=BNutXIZ+c4siKB0mcFGD5RRZLQ3PNEf4I+6qjrSKnIkaPg0w193ytJEFODM97FcOGAKkFr
	h3TfaalDIraRKKKPNhyRj0RIk99hSEnanM8rJMAFGpPqpQOTvpybOD19xKYlGgOqyxwCfP
	/U+6UvEP1XKa3jDhi3iMXOtrkadH7tE=
Date: Mon, 13 Oct 2025 15:29:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 4/4] mm: thp: reparent the split queue during memcg
 offline
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1759510072.git.zhengqi.arch@bytedance.com>
 <a01588414c9911f2bc912fa87f181aa5620d89d4.1759510072.git.zhengqi.arch@bytedance.com>
 <sdpkprxqf43emy5sttfzxnv4aemlarimdybdva4xyywyndajtx@zyvckuxgujzm>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <sdpkprxqf43emy5sttfzxnv4aemlarimdybdva4xyywyndajtx@zyvckuxgujzm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Shakeel,

On 10/8/25 1:56 AM, Shakeel Butt wrote:
> On Sat, Oct 04, 2025 at 12:53:18AM +0800, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Similar to list_lru, the split queue is relatively independent and does
>> not need to be reparented along with objcg and LRU folios (holding
>> objcg lock and lru lock). So let's apply the similar mechanism as list_lru
>> to reparent the split queue separately when memcg is offine.
>>
>> This is also a preparation for reparenting LRU folios.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   include/linux/huge_mm.h |  4 +++
>>   mm/huge_memory.c        | 54 +++++++++++++++++++++++++++++++++++++++++
>>   mm/memcontrol.c         |  1 +
>>   3 files changed, 59 insertions(+)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index f327d62fc9852..0c211dcbb0ec1 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -417,6 +417,9 @@ static inline int split_huge_page(struct page *page)
>>   	return split_huge_page_to_list_to_order(page, NULL, ret);
>>   }
>>   void deferred_split_folio(struct folio *folio, bool partially_mapped);
>> +#ifdef CONFIG_MEMCG
>> +void reparent_deferred_split_queue(struct mem_cgroup *memcg);
>> +#endif
>>   
>>   void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>>   		unsigned long address, bool freeze);
>> @@ -611,6 +614,7 @@ static inline int try_folio_split(struct folio *folio, struct page *page,
>>   }
>>   
>>   static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
>> +static inline void reparent_deferred_split_queue(struct mem_cgroup *memcg) {}
>>   #define split_huge_pmd(__vma, __pmd, __address)	\
>>   	do { } while (0)
>>   
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 59ddebc9f3232..b5eea2091cdf6 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1099,6 +1099,11 @@ static struct deferred_split *memcg_split_queue(int nid, struct mem_cgroup *memc
>>   {
>>   	return memcg ? &memcg->deferred_split_queue : split_queue_node(nid);
>>   }
>> +
>> +static bool memcg_is_dying(struct mem_cgroup *memcg)
>> +{
>> +	return memcg ? css_is_dying(&memcg->css) : false;
>> +}
> 
> Please move the above function to include/linux/memcontrol.h

OK, will do.

> 
> With that, please add:
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Thanks!

> 


