Return-Path: <linux-kernel+bounces-724750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94413AFF690
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB17482D32
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2FF27E7FD;
	Thu, 10 Jul 2025 01:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iKlp836K"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7569C25C711
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752112695; cv=none; b=MHCjHN9zmD2mHa6lEE5Yg9bvbKIBd8M7TXnyNuNFDHG+8s5gundGWp5SwDi0kL7R8ccbzJeMNzlHQgni7u2gV09K5sOtbjCaXMB3XCkO+dhI8oILrWhcBI7bunaNv1Ki5FvUSrQFJSIdZXeMEwkNAtPHuXS29FqW77/ByNw2/9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752112695; c=relaxed/simple;
	bh=ZcaLLyOB3tqdrpaoeuobLjo7b3y+N7vwVh9wdduZieM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rX030gGN1J4ft9heJ9K2RzFCVlOL5/GD1ioL4EVsyD4TQAXJ1Rxm1nwvpeCzNWwQ8HvKqdY1qux+SyN5psnP27Qa0CsQ0v9lq1hPiEZiPMNF11Q1SaGf2EAlwgKiP/YkPCgBeWT3qTlNRN+jJpTKDV+p+N0Je+TH2uol4uo2iL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iKlp836K; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752112683; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MyRObTRkklQz6NQ2WdLXWBBkOrBh2ZjGUjiRtUdCUHc=;
	b=iKlp836KEwetgOdcVFnIGUTjj5QhDBywSvjlrOAztZFOIl2Rm45t+FG8PKFp+DAAuPHnvn27JEmfKsNL+9wtiQmpBSRAarCAEQWQU0iVDNW3d6Voanx16L6/jlMgzWOkHQS6K2E9GVzPYEUUQzEloPh1woMU0EdCLiDU/OTzs84=
Received: from 30.74.144.111(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WiaZUIW_1752112681 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Jul 2025 09:58:02 +0800
Message-ID: <ccce870e-3117-4044-96e6-4d0e15bef913@linux.alibaba.com>
Date: Thu, 10 Jul 2025 09:58:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] fix MADV_COLLAPSE issue if THP settings are
 disabled
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
 ziy@nvidia.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Pedro Falcato <pfalcato@suse.de>
References: <cover.1750815384.git.baolin.wang@linux.alibaba.com>
 <573eb43a-8536-4206-a7c6-d0daa1fd7e70@lucifer.local>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <573eb43a-8536-4206-a7c6-d0daa1fd7e70@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/9 20:36, Lorenzo Stoakes wrote:
> +cc Pedro as he'd raised concerns here also.
> 
> Hi Baolin,
> 
> Just for some clarification on this - thank you very much for this series,
> but based on discussion with David and concerns raised by Hugh + others,
> overall it feels as if, while the documentation is no doubt vague in ways
> it ought not to be, this behaviour is something we have put out into the
> world and we should continue to support it.
> 
> So overall I feel that this series should not be applied.

Fair enough.

> 
> Your work here is great, and really massive apologies for this after all
> the work you've put in (and of course the review work here also), but on
> reflection I think it's a risk we shouldn't take.

Consensus is the key. Thank you and David for the discussion and 
suggestions.

> I understand this means that MADV_COLLAPSE can't be used to collapse at a
> mTHP granularity - we definitely need to have a think about how we might
> provide this sensibly.
> 
> As for how to move forward - I will go ahead and update documentation to
> make the situation absolutely crystal clear, both in the man page and the
> rst.

OK. Great. Thanks.

> Thanks, Lorenzo
> 
> On Wed, Jun 25, 2025 at 09:40:08AM +0800, Baolin Wang wrote:
>> When invoking thp_vma_allowable_orders(), if the TVA_ENFORCE_SYSFS flag is not
>> specified, we will ignore the THP sysfs settings. Whilst it makes sense for the
>> callers who do not specify this flag, it creates a odd and surprising situation
>> where a sysadmin specifying 'never' for all THP sizes still observing THP pages
>> being allocated and used on the system. And the MADV_COLLAPSE is an example of
>> such a case, that means it will not set TVA_ENFORCE_SYSFS when calling
>> thp_vma_allowable_orders().
>>
>> As we discussed in the previous thread [1], the MADV_COLLAPSE will ignore
>> the system-wide anon/shmem THP sysfs settings, which means that even though
>> we have disabled the anon/shmem THP configuration, MADV_COLLAPSE will still
>> attempt to collapse into a anon/shmem THP. This violates the rule we have
>> agreed upon: never means never.
>>
>> For example, system administrators who disabled THP everywhere must indeed very
>> much not want THP to be used for whatever reason - having individual programs
>> being able to quietly override this is very surprising and likely to cause headaches
>> for those who desire this not to happen on their systems.
>>
>> This patch set will address the MADV_COLLAPSE issue.
>>
>> Test
>> ====
>> 1. Tested the mm selftests and found no regressions.
>> 2. With toggling different Anon mTHP settings, the allocation and madvise collapse for
>> anonymous pages work well.
>> 3. With toggling different shmem mTHP settings, the allocation and madvise collapse for
>> shmem work well.
>> 4. Tested the large order allocation for tmpfs, and works as expected.
>>
>> [1] https://lore.kernel.org/all/1f00fdc3-a3a3-464b-8565-4c1b23d34f8d@linux.alibaba.com/
>>
>> Changes from v3:
>>   - Collect reviewed tags. Thanks.
>>   - Update the commit message, per David.
>>
>> Changes from v2:
>>   - Update the commit message and cover letter, per Lorenzo. Thanks.
>>   - Simplify the logic in thp_vma_allowable_orders(), per Lorenzo and David. Thanks.
>>
>> Changes from v1:
>>   - Update the commit message, per Zi.
>>   - Add Zi's reviewed tag. Thanks.
>>   - Update the shmem logic.
>>
>> Baolin Wang (2):
>>    mm: huge_memory: disallow hugepages if the system-wide THP sysfs
>>      settings are disabled
>>    mm: shmem: disallow hugepages if the system-wide shmem THP sysfs
>>      settings are disabled
>>
>>   include/linux/huge_mm.h                 | 51 ++++++++++++++++++-------
>>   mm/shmem.c                              |  6 +--
>>   tools/testing/selftests/mm/khugepaged.c |  8 +---
>>   3 files changed, 43 insertions(+), 22 deletions(-)
>>
>> --
>> 2.43.5
>>


