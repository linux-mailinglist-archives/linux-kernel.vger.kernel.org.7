Return-Path: <linux-kernel+bounces-751517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF80B16A85
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B7B56636B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AAD21771F;
	Thu, 31 Jul 2025 02:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qUnVHuy3"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CBC27450
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753929691; cv=none; b=rdii5xU/vPxGGLOgrWlJb/N0w5n4sK2ZOf5Xe2VyCfkYdZemg25SIRlgZBUdqQXnLr8kYOSFF6q4SPX+YCjC8/v79UNlog9nJpzrnXdOU7+/MyxSJHtOS8LzkR4FJBZGcYPGistKZgGxNQSGb9mZ5vQDNh/qEL+Y+V73Sobzw+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753929691; c=relaxed/simple;
	bh=sDZ/TPbuIy+BZluCVLYG7q8iusei8uFe9WWuoWGgbA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYgUsawgZiUFQrl2lcqgYmcnYzThGHbgtB5NbskPUe1Ufa0vprS8kOCXzgpZmz4XmstwmeTvXVFEnm92u/XWFqqDu2NMWJ7YxY65np7VKKa+tWhz3Vn7lA3AIVdKu2LvZeXSJcflBzEjhCZMneo3o54W1pdqeXiflEJcSinU+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qUnVHuy3; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753929686; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gqxVT+RbD+xwh7/14ML2dYytB9lSy/1Uy05C7j5gfdk=;
	b=qUnVHuy3wA1yk0fszs3uONb6a4O0eBA4iG9DN3L+XiM09Nscv2T32EJfQUJuvfvue25o3zJ23mbjFVwK9E76pxRFhavwE7ZDRgw7WJPflGRkBzlXHDX/M1POrmxezNRcpAbkQy5nEcG8DkwMvitj66iZamfE+zTCroUcmq8hz60=
Received: from 30.74.144.125(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WkWRHUP_1753929684 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Jul 2025 10:41:25 +0800
Message-ID: <78c0f8ba-7e71-41da-9ac8-bcd26717dc71@linux.alibaba.com>
Date: Thu, 31 Jul 2025 10:41:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: shmem: fix the strategy for the tmpfs 'huge='
 options
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <701271092af74c2d969b195321c2c22e15e3c694.1753863013.git.baolin.wang@linux.alibaba.com>
 <0a689e9f-082b-497d-a32b-afc3feddcdb8@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <0a689e9f-082b-497d-a32b-afc3feddcdb8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/30 17:30, David Hildenbrand wrote:
> On 30.07.25 10:14, Baolin Wang wrote:
>> After commit acd7ccb284b8 ("mm: shmem: add large folio support for 
>> tmpfs"),
>> we have extended tmpfs to allow any sized large folios, rather than just
>> PMD-sized large folios.
>>
>> The strategy discussed previously was:
>>
>> "
>> Considering that tmpfs already has the 'huge=' option to control the
>> PMD-sized large folios allocation, we can extend the 'huge=' option to
>> allow any sized large folios.  The semantics of the 'huge=' mount option
>> are:
>>
>>      huge=never: no any sized large folios
>>      huge=always: any sized large folios
>>      huge=within_size: like 'always' but respect the i_size
>>      huge=advise: like 'always' if requested with madvise()
>>
>> Note: for tmpfs mmap() faults, due to the lack of a write size hint, 
>> still
>> allocate the PMD-sized huge folios if huge=always/within_size/advise is
>> set.
>>
>> Moreover, the 'deny' and 'force' testing options controlled by
>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the 
>> same
>> semantics.  The 'deny' can disable any sized large folios for tmpfs, 
>> while
>> the 'force' can enable PMD sized large folios for tmpfs.
>> "
>>
>> This means that when tmpfs is mounted with 'huge=always' or 
>> 'huge=within_size',
>> tmpfs will allow getting a highest order hint based on the size of 
>> write() and
>> fallocate() paths. It will then try each allowable large order, rather 
>> than
>> continually attempting to allocate PMD-sized large folios as before.
>>
>> However, this might break some user scenarios for those who want to use
>> PMD-sized large folios, such as the i915 driver which did not supply a 
>> write
>> size hint when allocating shmem [1].
>>
>> Moreover, Hugh also complained that this will cause a regression in 
>> userspace
>> with 'huge=always' or 'huge=within_size'.
>>
>> So, let's revisit the strategy for tmpfs large page allocation. A 
>> simple fix
>> would be to always try PMD-sized large folios first, and if that 
>> fails, fall
>> back to smaller large folios. However, this approach differs from the 
>> strategy
>> for large folio allocation used by other file systems. Is this 
>> acceptable?
> 
> My opinion so far has been that anon and shmem are different than 
> ordinary FS'es ... primarily because 
> allocation(readahead)+reclaim(writeback) behave differently.
> 
> There were opinions in the past that tmpfs should just behave like any 
> other fs, and I think that's what we tried to satisfy here: use the 
> write size as an indication.
> 
> I assume there will be workloads where either approach will be 
> beneficial. I also assume that workloads that use ordinary fs'es could 
> benefit from the same strategy (start with PMD), while others will 
> clearly not.

Yes, using the write size as an indication to allocate large folios is 
certainly reasonable in some scenarios, as it avoids memory bloat while 
leveraging the advantages of large folios.

Personally, I prefer to use this method by default for allocating tmpfs 
large folios, but we also need to consider how to avoid regression if 
the 'huge=always/within_size' mount option is set.

> So no real opinion, it all doesn't feel ideal ... at least with his 
> approach here we would stick more to the old tmpfs behavior.


