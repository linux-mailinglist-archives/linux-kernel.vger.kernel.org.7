Return-Path: <linux-kernel+bounces-803142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C59B45AFF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83ECA1B25600
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABDC36CDE5;
	Fri,  5 Sep 2025 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcpsaLdl"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3E9148850
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084046; cv=none; b=ncDqWovFJTam2eumVzZjFKTxbXG7gIwgbo5w8PEIj0i/1wXqRlDBsQtN22fHup8dBs63F8v/iWjrPXYKVaJ2esFhObBHzt3kGNKgOESzVFTOrNkqTdGwKgaZbFZyeEDYR+SSCJIxfwTlqQ63C32QSxA1xICs/uMBmxtw8VGt4aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084046; c=relaxed/simple;
	bh=4lV2YquFrBwumWDqjtPf6vrYgYIZl4BT+5bpmKTmkWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmtpytRIpBeDyRODvjoRb/D8+Wprp+bcaXrzQ60yRaymlMWfjv+JOigA8epav88fALaBFRDyYv+KjXkUSfWe/JCJAA5x+5wmoB0rS2EPbHJcerb4DmJ59uOzoo4PmEwImgyihmrtjZ1Z1LkOQCAhjpoLMAVPLqGg8AXrBDRk7Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcpsaLdl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3e34dbc38easo555160f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757084043; x=1757688843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+1ki06iYpj+ewE6s7Y+9ZydcBaRBzNiVkNilJgQiAH8=;
        b=YcpsaLdl2e4XkX0gbMVRbtWK6G9dIhszF+AhffrU+Cvk77pgBl+yxjKlspYpJ+AF7G
         O+JD/CY70z8P1bjA/xWYTzOPYHelNXmbEJ1gX1WdYRkzKY+uPAXHndgyzRCbaMKDXPzl
         aOKot7wlXuI1A781GwT+MmxKLf2BHkGNKULCGydYXPwvmuxgFAFfZj7MIMTbHY4rpPWD
         wzNnxxyrA1LkhihEYiwNRM63omf/GwSrDW+ud88qyQ9LnCYj3FSDZ9jGEAgUsgt1k/Ru
         iljUZXwJyvQS71S1az8OHUcPgwHVjecvxLPUfGj9L6oyOy7LoDHCcvB7cLu+gmNN2Ren
         o5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757084043; x=1757688843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1ki06iYpj+ewE6s7Y+9ZydcBaRBzNiVkNilJgQiAH8=;
        b=hUCM2upyDsYYvmsOwp5tz7LuyqwFc1VBrB9+JXvFcY7vcNLClsyo7EG3eLyHoR0+mt
         NhYIsaXQx68dCJYlquI2ZN0ZtfxA190ikzzQhGlVKmdS/K3/gwxujxYpD4nMBCixI1Mz
         QCOvV/kB4cR2KCmWjDSkaJFxUZejgba227jvWONbmqJY49hVNCPYec5hIh95JDXu23WI
         2sz+JqGuHstThdZYi4JgiGx7FInrCSVji+NODTZmRKC7qhJii65Mp1YMSdYUk0A2+RAx
         SEFderfPOjRfFVuQ/rI1+p1NBF1R4QpahHxov6A1AAUjTVM5rhC5mcMCyPcdQ3h/NH6c
         iz+A==
X-Forwarded-Encrypted: i=1; AJvYcCWH7pouzI+QKmrl4gviIFTpawZzcvMfh+QXpSJpfWgaSeyg5WcbTSZY8cIbhHZRtJwXjgiq4qXJWXPFsJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqhCMFpAsKHsAfLvqbU5PWECfFk5kPq6ZM2G+F0LgrIDJV8lyz
	dkQYCh0hbgezD49vpWMqwe6U/JhKL4FVts6IdbpNC1nUp/iep7ui6HhLZ+xCK/U+A1o=
X-Gm-Gg: ASbGncvbwXJySH5Hv8GindKFvyNlHY+0quEwJNNAMvbPqBzaCrFJP5pIC0eQcOTFdhV
	JoQVawzUyWaed/yaluOxy0cM63q+fTpd7ghhF9DUt0nbDCVbW6sw1mTB+VttLtux8ECb4Uatps8
	FCfOR3Qpk70ona/zLVfdmtrEB1vfrHVmceF5JpqkS+NoRCUC3RF2dKsO3NBi/BV3UD2H/ISgcTe
	ZL7FhkQFzhV+HfeN2R0Xuq9D5oRf3q8z/mn52mjZVykaq/UNj6oeRL3p5mo7OhwZUSu270ZnAOC
	HHaP4zqAChqkNwAa91A4YgN9m5XuTET1piezJP1OEfNPxnmnsNVw3W+VKx1E/leRnXR/IcpDtKa
	JtANxNmp3ZTuRzYyll9/Adp1uBWtqNKPzVIk4/dEFd9Ce1oXSn7rYYA7DUqGbSTGC2bMaGnUPvK
	ZYxdl/yg==
X-Google-Smtp-Source: AGHT+IHGutNFXBpxj8SMepvOz4hjsxKNNsZIUg4ENk/gO7vKInJCsTI+b65PQGjSrF51dESUxTVGiQ==
X-Received: by 2002:a05:6000:2f84:b0:3e4:74dc:a3bb with SMTP id ffacd0b85a97d-3e474dcd583mr1734804f8f.40.1757084042867;
        Fri, 05 Sep 2025 07:54:02 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1449:d619:96c0:8e08? ([2620:10d:c092:500::4:4f66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d95df59e50sm16689769f8f.23.2025.09.05.07.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 07:54:01 -0700 (PDT)
Message-ID: <8b9ee2fe-91ef-4475-905c-cf0943ada720@gmail.com>
Date: Fri, 5 Sep 2025 15:53:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/huge_memory: fix shrinking of all-zero THPs with
 max_ptes_none default
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>
References: <20250905141137.3529867-1-david@redhat.com>
 <06874db5-80f2-41a0-98f1-35177f758670@gmail.com>
 <1aa5818f-eb75-4aee-a866-9d2f81111056@redhat.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <1aa5818f-eb75-4aee-a866-9d2f81111056@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/09/2025 15:46, David Hildenbrand wrote:
> [...]
> 
>>
>> The reason I did this is for the case if you change max_ptes_none after the THP is added
>> to deferred split list but *before* memory pressure, i.e. before the shrinker runs,
>> so that its considered for splitting.
> 
> Yeah, I was assuming that was the reason why the shrinker is enabled as default.
> 
> But in any sane system, the admin would enable the shrinker early. If not, we can look into handling it differently.

Yes, I do this as well, i.e. have a low value from the start.

Does it make sense to disable shrinker if max_ptes_none is 511? It wont shrink
the usecase you are describing below, but we wont encounter the increased CPU usage.> 
>>
>>> Easy to reproduce:
>>>
>>> 1) Allocate some THPs filled with 0s
>>>
>>> <prog.c>
>>>   #include <string.h>
>>>   #include <stdio.h>
>>>   #include <stdlib.h>
>>>   #include <unistd.h>
>>>   #include <sys/mman.h>
>>>
>>>   const size_t size = 1024*1024*1024;
>>>
>>>   int main(void)
>>>   {
>>>           size_t offs;
>>>           char *area;
>>>
>>>           area = mmap(0, size, PROT_READ | PROT_WRITE,
>>>                       MAP_ANON | MAP_PRIVATE, -1, 0);
>>>           if (area == MAP_FAILED) {
>>>                   printf("mmap failed\n");
>>>                   exit(-1);
>>>           }
>>>           madvise(area, size, MADV_HUGEPAGE);
>>>
>>>           for (offs = 0; offs < size; offs += getpagesize())
>>>                   area[offs] = 0;
>>>           pause();
>>>   }
>>> <\prog.c>
>>>
>>> 2) Trigger the shrinker
>>>
>>> E.g., memory pressure through memhog
>>>
>>> 3) Observe that THPs are not getting reclaimed
>>>
>>> $ cat /proc/`pgrep prog`/smaps_rollup
>>>
>>> Would list ~1GiB of AnonHugePages. With this fix, they would get
>>> reclaimed as expected.
>>>
>>> Fixes: dafff3f4c850 ("mm: split underused THPs")
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>>> Cc: Nico Pache <npache@redhat.com>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Cc: Dev Jain <dev.jain@arm.com>
>>> Cc: Barry Song <baohua@kernel.org>
>>> Cc: Usama Arif <usamaarif642@gmail.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   mm/huge_memory.c | 3 ---
>>>   1 file changed, 3 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 26cedfcd74189..aa3ed7a86435b 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -4110,9 +4110,6 @@ static bool thp_underused(struct folio *folio)
>>>       void *kaddr;
>>>       int i;
>>>   -    if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
>>> -        return false;
>>> -
>>
>> I do agree with your usecase, but I am really worried about the amount of
>> work and cpu time the THP shrinker will consume when max_ptes_none is 511
>> (I dont have any numbers to back up my worry :)), and its less likely that
>> we will have these completely zeroed out THPs (again no numbers to back up
>> this statement).
> 
> Then then shrinker shall be deactivated as default if that becomes a problem.
> 
> Fortunately you documented the desired semantics:
> 
> "All THPs at fault and collapse time will be added to _deferred_list,
> and will therefore be split under memory pressure if they are considered
> "underused". A THP is underused if the number of zero-filled pages in
> the THP is above max_ptes_none (see below)."
> 
>> We have the huge_zero_folio as well which is installed on read.
> 
> Yes, only if the huge zero folio is not available. Which will then also get properly reclaimed.
> 


