Return-Path: <linux-kernel+bounces-768513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22297B261D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0105A694D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBC72E8885;
	Thu, 14 Aug 2025 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VZmnqBoF"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3062264CF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165822; cv=none; b=X+J4lcdB4a5WOfnzvrQ88e+dcidFOJcZgAF64ReMdV7c++APQCnyS7x6zlHtZhIPT/s6BsGDbApjq2KltCjghu4hwDuX6YqN4dNCTadJ+H2rUuQICdMgR5DAMeTdT3x+f4IFQ6XTp+gnqSN+9PHp7EktBq+QI/RygdJRPb0xw6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165822; c=relaxed/simple;
	bh=THF2iyildJN7JJ8MP+yNCExbHNYfFH5VwD1KwRNgbC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhp4BBBD2erTwo/CAyTEJ19HUoBgDrsFZbXXwpuYk/J+C9ivIrtOzd3L8t/cIv3MuFVTJfCxBJ3cDGPh+ay/eTp8MpxGTRaDe38FwSvTptoujoSDYmcAQORNHwcCoVCb+3qDBRUZXRLacKYBICgMoZCkcnGICxIX3XXAqoBE8P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VZmnqBoF; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755165809; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ocqGFWwlEESKe0BZACXQhN4GorNLeklOvmcYh0YlYp8=;
	b=VZmnqBoFYHe4CKwy74cVt0WvDSxJj64VUEHM2a6e8VQHPHeb8FGHicpHWHNVi0thcl/cAzv7a8H4JiRBhM2k5T0r1MbSE4//FNu/ZCVtTVDQQzLOekx4mEKa5AyUJ8LShZTSS7bhL9nAc5VlEOZzEFN2gFQUGC+zeqgntYK6D1o=
Received: from 30.74.144.115(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WljqW7d_1755165806 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Aug 2025 18:03:27 +0800
Message-ID: <323ed726-fc69-4d80-a7e8-e3762c161ee1@linux.alibaba.com>
Date: Thu, 14 Aug 2025 18:03:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: shmem: fix the strategy for the tmpfs 'huge='
 options
To: Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <701271092af74c2d969b195321c2c22e15e3c694.1753863013.git.baolin.wang@linux.alibaba.com>
 <e6898dca-d6c6-465c-a373-8298858839ab@linux.alibaba.com>
 <3705f034-808a-4afe-5dde-4b4e9815a8d0@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <3705f034-808a-4afe-5dde-4b4e9815a8d0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/8/13 14:59, Hugh Dickins wrote:
> On Tue, 12 Aug 2025, Baolin Wang wrote:
>> On 2025/7/30 16:14, Baolin Wang wrote:
>>> After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs"),
>>> we have extended tmpfs to allow any sized large folios, rather than just
>>> PMD-sized large folios.
>>>
>>> The strategy discussed previously was:
>>>
>>> "
>>> Considering that tmpfs already has the 'huge=' option to control the
>>> PMD-sized large folios allocation, we can extend the 'huge=' option to
>>> allow any sized large folios.  The semantics of the 'huge=' mount option
>>> are:
>>>
>>>       huge=never: no any sized large folios
>>>       huge=always: any sized large folios
>>>       huge=within_size: like 'always' but respect the i_size
>>>       huge=advise: like 'always' if requested with madvise()
>>>
>>> Note: for tmpfs mmap() faults, due to the lack of a write size hint, still
>>> allocate the PMD-sized huge folios if huge=always/within_size/advise is
>>> set.
>>>
>>> Moreover, the 'deny' and 'force' testing options controlled by
>>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the same
>>> semantics.  The 'deny' can disable any sized large folios for tmpfs, while
>>> the 'force' can enable PMD sized large folios for tmpfs.
>>> "
>>>
>>> This means that when tmpfs is mounted with 'huge=always' or
>>> 'huge=within_size',
>>> tmpfs will allow getting a highest order hint based on the size of write()
>>> and
>>> fallocate() paths. It will then try each allowable large order, rather than
>>> continually attempting to allocate PMD-sized large folios as before.
>>>
>>> However, this might break some user scenarios for those who want to use
>>> PMD-sized large folios, such as the i915 driver which did not supply a write
>>> size hint when allocating shmem [1].
>>>
>>> Moreover, Hugh also complained that this will cause a regression in
>>> userspace
>>> with 'huge=always' or 'huge=within_size'.
>>>
>>> So, let's revisit the strategy for tmpfs large page allocation. A simple fix
>>> would be to always try PMD-sized large folios first, and if that fails, fall
>>> back to smaller large folios. However, this approach differs from the
>>> strategy
>>> for large folio allocation used by other file systems. Is this acceptable?
>>>
>>> [1]
>>> https://lore.kernel.org/lkml/0d734549d5ed073c80b11601da3abdd5223e1889.1753689802.git.baolin.wang@linux.alibaba.com/
>>> Fixes: acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>> Note: this is just an RFC patch. I would like to hear others' opinions or
>>> see if there is a better way to address Hugh's concern.
> 
> Sorry, I am still evaluating this RFC patch.
> 
> Certainly I observe it taking us in the right direction, giving PMD-sized
> pages on tmpfs huge=always, as 6.13 and earlier releases did - thank you.
> 
> But the explosion of combinations which mTHP and FS large folios bring,
> the amount that needs checking, is close to defeating me; and I've had
> to spend a lot of the time re-educating myself on the background -
> not looking to see whether this particular patch is right or not.
> Still working on it.

OK. Thanks.

>> If we use this approach to fix the PMD large folio regression, should we also
>> change tmpfs mmap() to allow allocating any sized large folios, but always try
>> to allocate PMD-sized large folios first? What do you think? Thanks.
> 
> Probably: I would like the mmap allocations to follow the same rules.
> 
> But finding it a bit odd how the current implementation limits tmpfs
> large folios to when huge=notnever (is that a fair statement?), whereas

Yes, this is mainly to ensure backward compatibility with the 'huge=' 
options. Moreover, in the future, we could set the default value of 
‘tmpfs_huge’ to ‘always’ (controlled via the cmdline: 
transparent_hugepage_tmpfs=) to allow all tmpfs mounts to use large 
folios by default.

> other filesystems are now being freely given large folios - using
> different GFP flags from what MM uses (closest to defrag=always I think),
> and with no limitation - whereas MM folks are off devising ever newer
> ways to restrict access to huge pages.
> 
> And (conversely) I am unhappy with the way write and fallocate (and split
> and collapse? in flight I think) are following the FS approach of allowing
> every fractal, when mTHP/shmem_enabled is (or can be) more limiting.  I
> think it less surprising (and more efficient when fragmented) for shmem
> FS operations to be restricted to the same subset as "shared anon".

Understood. We discussed this before, but it didn’t get support :(

