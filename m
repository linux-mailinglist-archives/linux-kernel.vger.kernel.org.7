Return-Path: <linux-kernel+bounces-818246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB238B58EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C07A7ABD02
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005B62E3AF5;
	Tue, 16 Sep 2025 07:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iFG9hULC"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06912E11B0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758006355; cv=none; b=Jh/IGydTrLZVtF5Zt+8VCZ8gMYV5ZKt9dZvbnQ1Z1zKayoYzIf6wuqR2BP55tnKNK5Mu4IJMpWd6Xn1gqZ09xyn2FzjTs8RgWKUw0v7DeY1gJVow/sOIvK/PcBKyXk8IEB4GvIbRj+nXywCvszaewtu6+M7pAZLt45AmLUCKI2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758006355; c=relaxed/simple;
	bh=+y/eEEKKXQN7aK6Kkodz+hQeZnrOKlkRRKodOnrnh2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0K4KflmMEqi93V+bNmaHF++osdSL8kMM4Nzk3Y+Su8BiBJEjArwOALY3qkynbSNzj4mq5/a6YhSsEZ0bA4MB5ncs9kduqw2wzzLuytwJF/r37BUGh8kU9WGQIj5bvcnsZ32UkoMFIlWjX56kzqIRO0AOis6OpDicSyJYDKLVZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iFG9hULC; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <36f7c6b0-eaa8-476d-b060-46c2c172d428@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758006350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkCYU2hnN7SdTU8iIMlWGHc/y+53owK9PLewiGtjRNU=;
	b=iFG9hULCYBZq5cJd2sOYRANHbw+GXBnvdYIHqurF20TrMZ7oLijfxKpTnFHP89kknDYT10
	hApkwu1wO5SeI/uIeYqHbgd/OyJ3SU88qaGPj9sl/Qv4gOKdbNsxU5JcEGMqjAM1RZa2oX
	uLtppLW2XNVSKPNZG6CzpeBqHrGk5xc=
Date: Tue, 16 Sep 2025 15:05:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 1/3] mm/khugepaged: skip unsuitable VMAs earlier in
 khugepaged_scan_mm_slot()
Content-Language: en-US
To: Hugh Dickins <hughd@google.com>, david@redhat.com,
 lorenzo.stoakes@oracle.com
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250914143547.27687-1-lance.yang@linux.dev>
 <20250914143547.27687-2-lance.yang@linux.dev>
 <bc86d5f7-5b23-14fb-0365-b47f5a6f13c9@google.com>
 <a0ec4014-384b-4c04-bf0b-777c989eabcb@linux.dev>
 <70da1948-b0f2-f54b-e0eb-ff901e007ccc@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <70da1948-b0f2-f54b-e0eb-ff901e007ccc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/16 14:42, Hugh Dickins wrote:
> On Tue, 16 Sep 2025, Lance Yang wrote:
> 
>> Hi Hugh,
>>
>> Thanks for taking a look and for raising this important point!
>>
>> On 2025/9/16 13:32, Hugh Dickins wrote:
>>> On Sun, 14 Sep 2025, Lance Yang wrote:
>>>
>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>
>>>> Let's skip unsuitable VMAs early in the khugepaged scan; specifically,
>>>> mlocked VMAs should not be touched.
>>>
>>> Why?  That's a change in behaviour, isn't it?
>>>
>>> I'm aware that hugepage collapse on an mlocked VMA can insert a fault
>>> latency, not universally welcome; but I've not seen discussion, let
>>> alone agreement, that current behaviour should be changed.
>>> Somewhere in yet-to-be-read mail?  Please give us a link.
>>>
>>> Hugh
>>
>> You're right, this is indeed a change in behaviour. But it's specifically
>> for khugepaged.
>>
>> Users of mlock() expect low and predictable latency. THP collapse is a
>> heavy operation that introduces exactly the kind of unpredictable delays
>> they want to avoid. It has to unmap PTEs, copy data from the small folios
>> to a new THP, and then remap the THP back to the PMD ;)
>>
>> IMO, that change is acceptable because THP is generally transparent to
>> users, and khugepaged does not guarantee when THP collapse or split will
>> happen.
> 
> I disagree.  Many of those who have khugepaged enabled would prefer
> it to give them hugepages, even or especially on mlocked areas.
> 
> If you make that change, it must be guarded by a sysfs or sysctl tuning.

Thanks for the feedback!

Well, seems like we're not on the same page. Let's gather more opinions from
other folks ;)

> 
> Perhaps it could share the sysctl_compact_unevictable_allowed tuning
> (I'm not sure whether that's a good or bad idea: opinions will differ).

Thanks,
Lance

> 
> Hugh
> 
>>
>> Well, we don't have a discussion on that, just something I noticed.
>>
>> Thanks,
>> Lance


