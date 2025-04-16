Return-Path: <linux-kernel+bounces-608041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1810A90DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 23:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0730F447E17
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 21:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C675E23536C;
	Wed, 16 Apr 2025 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZVMQ/Jmh"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D947233120
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744839658; cv=none; b=aHNKMYqEp/mToujbKCKTZId7uG1hKNoA3aoAzL6mCMbxu9gHDRHlokr8KWiCu+2alazZyb+9Flak5fkMa6GgGwHQ+wEiZgvgnrFN0dinxDJGLqq5LFQZolSCUOwDTKnoZqmrDeO8G9daIZ/7DZ2egJRgbQy8dcWwAdnNOiYTgdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744839658; c=relaxed/simple;
	bh=Akuhkguz9lZ7ogV7BZwatXKI1L5hSvQMKf9rfWq+EjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTXbZOdnwhdxpq10QP04BH4AdpcSp++D34IvtCABK5Asa9c2bRzw3vWvCPo2AmGMc2ZWcq3zN6wC3gc+pwXlV+O9YNVW9GDDdgKDw1TKvxEqvezSC5e5mtPm5hsW4FZopGUE04yQep7C4ZcmM4LJSjqqdTPVm/p2jOwDblwHppQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZVMQ/Jmh; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <235030ca-93a4-4666-93f8-93f8d81ff650@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744839643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gOdc+K/KW6LG2lJV2OfaDngWl4h/oV6BdYZhgh8d5M=;
	b=ZVMQ/Jmhj/6fVk1TZaMu4zk0rK4L/5c8VUb5YiJ3v6Bhp9vz36HOMXyXbSzeu+BSD/SnGa
	WXxl5wyCDtJLteOBzlJOaIUqPn9Ald2m0CcX29tmfwt8C3KCCZLZ8f1/vD+gZqZOTaLtRO
	I6JLeES2NCsrJFdnD4VW2tJN/pns55I=
Date: Thu, 17 Apr 2025 05:40:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 00/11] pcache: Persistent Memory Cache for Block
 Devices
To: Jens Axboe <axboe@kernel.dk>, Dan Williams <dan.j.williams@intel.com>,
 hch@lst.de, gregory.price@memverge.com, John@groves.net,
 Jonathan.Cameron@huawei.com, bbhushan2@marvell.com, chaitanyak@nvidia.com,
 rdunlap@infradead.org, agk@redhat.com, snitzer@kernel.org,
 mpatocka@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-bcache@vger.kernel.org,
 nvdimm@lists.linux.dev, dm-devel@lists.linux.dev
References: <20250414014505.20477-1-dongsheng.yang@linux.dev>
 <67fe9ea2850bc_71fe294d8@dwillia2-xfh.jf.intel.com.notmuch>
 <15e2151a-d788-48eb-8588-1d9a930c64dd@kernel.dk>
 <07f93a57-6459-46e2-8ee3-e0328dd67967@linux.dev>
 <d3231630-9445-4c17-9151-69fe5ae94a0d@kernel.dk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dongsheng Yang <dongsheng.yang@linux.dev>
In-Reply-To: <d3231630-9445-4c17-9151-69fe5ae94a0d@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

+ccing md-devel

On 2025/4/16 23:10, Jens Axboe wrote:
> On 4/16/25 12:08 AM, Dongsheng Yang wrote:
>> On 2025/4/16 9:04, Jens Axboe wrote:
>>> On 4/15/25 12:00 PM, Dan Williams wrote:
>>>> Thanks for making the comparison chart. The immediate question this
>>>> raises is why not add "multi-tree per backend", "log structured
>>>> writeback", "readcache", and "CRC" support to dm-writecache?
>>>> device-mapper is everywhere, has a long track record, and enhancing it
>>>> immediately engages a community of folks in this space.
>>> Strongly agree.
>>
>> Hi Dan and Jens,
>> Thanks for your reply, that's a good question.
>>
>>      1. Why not optimize within dm-writecache?
>>  From my perspective, the design goal of dm-writecache is to be a
>> minimal write cache. It achieves caching by dividing the cache device
>> into n blocks, each managed by a wc_entry, using a very simple
>> management mechanism. On top of this design, it's quite difficult to
>> implement features like multi-tree structures, CRC, or log-structured
>> writeback. Moreover, adding such optimizations?especially a read
>> cache?would deviate from the original semantics of dm-writecache. So,
>> we didn't consider optimizing dm-writecache to meet our goals.
>>
>>      2. Why not optimize within bcache or dm-cache?
>> As mentioned above, dm-writecache is essentially a minimal write
>> cache. So, why not build on bcache or dm-cache, which are more
>> complete caching systems? The truth is, it's also quite difficult.
>> These systems were designed with traditional SSDs/NVMe in mind, and
>> many of their design assumptions no longer hold true in the context of
>> PMEM. Every design targets a specific scenario, which is why, even
>> with dm-cache available, dm-writecache emerged to support DAX-capable
>> PMEM devices.
>>
>>      3. Then why not implement a full PMEM cache within the dm framework?
>> In high-performance IO scenarios?especially with PMEM hardware?adding
>> an extra DM layer in the IO stack is often unnecessary. For example,
>> DM performs a bio clone before calling __map_bio(clone) to invoke the
>> target operation, which introduces overhead.
>>
>> Thank you again for the suggestion. I absolutely agree that leveraging
>> existing frameworks would be helpful in terms of code review, and
>> merging. I, more than anyone, hope more people can help review the
>> code or join in this work. However, I believe that in the long run,
>> building a standalone pcache module is a better choice.
> I think we'd need much stronger reasons for NOT adopting some kind of dm
> approach for this, this is really the place to do it. If dm-writecache
> etc aren't a good fit, add a dm-whatevercache for it? If dm is
> unnecessarily cloning bios when it doesn't need to, then that seems like
> something that would be worthwhile fixing in the first place, or at
> least eliminate for cases that don't need it. That'd benefit everyone,
> and we would not be stuck with a new stack to manage.
>
> Would certainly be worth exploring with the dm folks.

well, introducing dm-pcache (assuming we use this name) could, on one 
hand, attract more users and developers from the device-mapper community 
to pay attention to this project, and on the other hand, serve as a way 
to validate or improve the dm framework’s performance in 
high-performance I/O scenarios. If necessary, we can enhance the dm 
framework instead of bypassing it entirely. This indeed sounds like 
something that would “benefit everyone.”

Hmm, I will seriously consider this approach.

Hi Alasdair, Mike, Mikulas,  Do you have any suggestions?

Thanx

>

