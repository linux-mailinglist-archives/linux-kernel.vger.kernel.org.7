Return-Path: <linux-kernel+bounces-826578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23E3B8ED7D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B45016F860
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30192D876A;
	Mon, 22 Sep 2025 03:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YiHQIeiB"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E9BEEC0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758510601; cv=none; b=hHb4BwKdPSJKF03qJSgvKj1D1hXR7xMy79JA0rwjCyvtLJJpMzrKQh1qkVyfL0sWoCeEeHkdR9rlDZreUF0pfo1wxrM/maQQjHUyXJtOOvbd9LDTZbfylKGw9Mk4GofBe0Bv6p7rITQyKqx5wF0kOnBxnMU9KC7BrH2jypQgVkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758510601; c=relaxed/simple;
	bh=hpiIyoXsxjMWun8dmnY33g0FhoPmrmqM7B4poJiDfbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6nUeNK1uO33pJjcksr4iVcP7cbdpm4AyxklmPiGqKdHeS2TZXjsQ75j9aI5MVx2hqRxHOCOahJ1wock89RV3H3m/pUFellIm8w9HnBYI9uQoIXM9e+hWrLTocLb4p5QSPU7ozaUQAw2wbA3yJrO0/UougEIes8pfdp0m6/i1Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YiHQIeiB; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758510595; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aZ2gdkX08ci0+g9mdPNAJE+ZbpX5mtgiwL2vmxSQH40=;
	b=YiHQIeiBseD2zrIf0TlSS7zlZp7tJzLM5XnlE1Ps+KDpj1r1oBf8yqZiQOuRc8gPvA3p7vRjlZdF4Z1tVtISJKycZ/EtJkksyzdUkTzgeE9UxcuMbLwMRgZebsBcGUG7sq1na+ZnL7F9tfq0mCpjXHgF7zezLq2YmgtmgFCYpOE=
Received: from 30.74.144.144(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WoR-W6p_1758510594 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Sep 2025 11:09:54 +0800
Message-ID: <58895de6-58e5-4cb5-b2b3-4a66283908a8@linux.alibaba.com>
Date: Mon, 22 Sep 2025 11:09:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shmem: fix too little space for tmpfs only fallback
 4KB
To: Vernon Yang <vernon2gm@gmail.com>
Cc: hughd@google.com, akpm@linux-foundation.org, da.gomez@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Vernon Yang <yanglincheng@kylinos.cn>
References: <20250908123128.900254-1-vernon2gm@gmail.com>
 <c245dbb5-2e2b-4308-a296-f711b74002eb@linux.alibaba.com>
 <3349E5A6-BCDC-47B9-956B-CB0D0BC02D84@gmail.com>
 <fd0664f4-2ee7-420c-a63c-b4b1c923e1c2@linux.alibaba.com>
 <kh5nq3ycj5neufhmiqetl5vtosictiflk73xyb2fdl2p4txmu3@4ndr7cw4b2j6>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <kh5nq3ycj5neufhmiqetl5vtosictiflk73xyb2fdl2p4txmu3@4ndr7cw4b2j6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/22 10:51, Vernon Yang wrote:
> On Mon, Sep 22, 2025 at 09:46:53AM +0800, Baolin Wang wrote:
>>
>>
>> On 2025/9/9 20:29, Vernon Yang wrote:
>>>
>>>
>>>> On Sep 9, 2025, at 13:58, Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2025/9/8 20:31, Vernon Yang wrote:
>>>>> From: Vernon Yang <yanglincheng@kylinos.cn>
>>>>> When the system memory is sufficient, allocating memory is always
>>>>> successful, but when tmpfs size is low (e.g. 1MB), it falls back
>>>>> directly from 2MB to 4KB, and other small granularity (8KB ~ 1024KB)
>>>>> will not be tried.
>>>>> Therefore add check whether the remaining space of tmpfs is sufficient
>>>>> for allocation. If there is too little space left, try smaller large
>>>>> folio.
>>>>
>>>> I don't think so.
>>>>
>>>> For a tmpfs mount with 'huge=within_size' and 'size=1M', if you try to write 1M data, it will allocate an order 8 large folio and will not fallback to order 0.
>>>>
>>>> For a tmpfs mount with 'huge=always' and 'size=1M', if you try to write 1M data, it will not completely fallback to order 0 either, instead, it will still allocate some order 1 to order 7 large folios.
>>>>
>>>> I'm not sure if this is your actual user scenario. If your files are small and you are concerned about not getting large folio allocations, I recommend using the 'huge=within_size' mount option.
>>>>
>>>
>>> No, this is not my user scenario.
>>>
>>> Based on your previous patch [1], this scenario can be easily reproduced as
>>> follows.
>>>
>>> $ mount -t tmpfs -o size=1024K,huge=always tmpfs /xxx/test
>>> $ echo hello > /xxx/test/README
>>> $ df -h
>>> tmpfs            1.0M  4.0K 1020K   1% /xxx/test
>>>
>>> The code logic is as follows:
>>>
>>> shmem_get_folio_gfp()
>>>       orders = shmem_allowable_huge_orders()
>>>       shmem_alloc_and_add_folio(orders) return -ENOSPC;
>>>           shmem_alloc_folio() alloc 2MB
>>>           shmem_inode_acct_blocks()
>>>               percpu_counter_limited_add() goto unacct;
>>>           filemap_remove_folio()
>>>       shmem_alloc_and_add_folio(order = 0)
>>>
>>>
>>> As long as the tmpfs remaining space is too little and the system can allocate
>>> memory 2MB, the above path will be triggered.
>>
>> In your scenario, wouldn't allocating 4K be more reasonable? Using a 1M
>> large folio would waste memory. Moreover, if you want to use a large folio,
>> I think you could increase the 'size' mount option. To me, this doesn't seem
>> like a real-world usage scenario, instead it looks more like a contrived
>> test case for a specific situation.
> 
> The previous example is just an easy demo to reproduce, and if someone
> uses this example in the real world, of course the best method is to
> increase the 'size'.
> 
> But the scenario I want to express here is that when the tmpfs space is
> *consumed* to less than 2MB, only 4KB will be allocated, you can imagine
> that when a tmpfs is constantly consumed, but someone is reclaiming or
> freeing memory, causing often tmpfs space to remain in the range of
> [0~2MB), then tmpfs will always only allocate 4KB.

Please increase your 'size' mount option for testing. I don't see why we 
need to add more such logic without a solid reason.

Andrew, please drop this patch.

