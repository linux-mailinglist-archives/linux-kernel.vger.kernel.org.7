Return-Path: <linux-kernel+bounces-789216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE2AB39251
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D12981302
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D643520DD75;
	Thu, 28 Aug 2025 03:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EGDiDTRN"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2D2AD04
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756352823; cv=none; b=SaoghdkY5SnjcYlyKs/knCsQ3Lazyyzl0d/9z0KnG7cZb0YZFQ99AUwWjgB6Ypx2qaO0lBttyVobEaGuIJETaUpPHItF+b8jWxZ0dmg6ndMgRWBL122tE1+vJp6zrNeCO4HZyNZPCAnGvodkcePZduse9M763+/I41lDox46cqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756352823; c=relaxed/simple;
	bh=rr5u2hbyJ6uEWJnA6Uj38VsqNtIijf5YpDjbqNirSVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUWjB+sPO446mzIHGNcW+Kil/j0yo8Wxz+CwIce9aUCzJGr+k9nwnEAnBIBSVHbJrS0Q/W/oEP7s6eL3oTN9HalcTukyf9eVUlNf8KXf+pGmSYQ8DSVU3bvHJDOMn4vaiirunU9NQLv5Yobe3EqSAkq5wHm0EfS3hKb+bJr3dag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EGDiDTRN; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756352818; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=A3IvQ0HlQISTG9Y08uabppL+Va4vjCOc8DxFpqh3OnA=;
	b=EGDiDTRNFxcR0adi/809oGBVIHD97W9JN/HWqB/nT/c4k4hVRQbKv0wsXe/9QbaOIMEpaFBsVRqofr2bDqG0u0K1oem6NCI3aFNgX7Mu3/zuv1SAaAnIUHkTYMSp1t44qKAEwZNsjGqORWjmYFwF3dYBZoE8o1UddGlYjNHSNIw=
Received: from 30.74.144.114(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmlOm7W_1756352499 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Aug 2025 11:41:40 +0800
Message-ID: <c12b9236-903f-4a8f-aa9e-fd4d9ca1bffd@linux.alibaba.com>
Date: Thu, 28 Aug 2025 11:41:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] mm, swap: always lock and check the swap cache folio
 before use
To: Kairui Song <ryncsn@gmail.com>, Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>,
 Nhat Pham <nphamcs@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>,
 Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250822192023.13477-1-ryncsn@gmail.com>
 <20250822192023.13477-3-ryncsn@gmail.com>
 <CAF8kJuO0efOE-os=qi=i5jT1YWxspHYc=Ti1KN=uKgyFpWTRbA@mail.gmail.com>
 <CAMgjq7AkUc7hKrEL8cQ7jJTeXYBq7WqM55uQ_SZNNY8vJ7+ODQ@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAMgjq7AkUc7hKrEL8cQ7jJTeXYBq7WqM55uQ_SZNNY8vJ7+ODQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/8/27 22:35, Kairui Song wrote:
> On Wed, Aug 27, 2025 at 4:21 PM Chris Li <chrisl@kernel.org> wrote:
>>
>> On Fri, Aug 22, 2025 at 12:21 PM Kairui Song <ryncsn@gmail.com> wrote:
>>
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index e9d0d2784cd5..b4d39f2a1e0a 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -2379,8 +2379,6 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>>                          count_vm_event(PGMAJFAULT);
>>>                          count_memcg_event_mm(fault_mm, PGMAJFAULT);
>>>                  }
>>> -       } else {
>>> -               swap_update_readahead(folio, NULL, 0);
>>
>> Also this update readahead move to later might have a similar problem.
>> All the bail out in the move will lose the readahead status update.
>>
>> The readahead deed is already done. Missing the status update seems
>> incorrect.
> 
> Thanks for the detailed review.
> 
> The only change I wanted here is that swap readahead update should be
> done after checking the folio still corresponds to the swap entry
> triggering the swapin. That should have slight to none effect compared
> to before considering the extremely tiny time window. We are only
> following the convention more strictly.
> 
> In theory it might even help to reduce false updates: if the folio no
> longer corresponds to the swap entry, we are hitting an unrelated
> folio, doing a readahead update will either mislead vma readahead's
> address hint, or could clean up the readahead flag of an unrelated
> folio without actually using it. If the folio does get hit in the
> future, due to the missing readahead flag, the statistic will go
> wrong.

Yes, that’s what I thought as well.

By the way, can we do it right all at once in patch 1 (I mean the shmem 
changes)?

