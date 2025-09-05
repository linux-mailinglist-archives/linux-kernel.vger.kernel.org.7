Return-Path: <linux-kernel+bounces-803153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C868B45B5B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757467C2682
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0E0306B1E;
	Fri,  5 Sep 2025 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fd1v5WsG"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65E5306B3A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084288; cv=none; b=EnPCJPa2uV3JF1HfZlM79GexU0jhj0Y9yz2XwB8Yc9BLnpNyNoE+V9yZpVbS2gInuGdn411M5lcZQ9ZAMKbvRRnGvpPWpdEYEV3MVm9SvPRKRflWMwesTl9ZHpXkjALXm7UBDJyh7sE5Xo0Ev+OfUNkhaWKMJT8W9RcdTNWUofE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084288; c=relaxed/simple;
	bh=8YKf/Rf+EIbnXFVcpcraPIQg48oNyeON6uUDodvYdHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/LAWxCWHFpnENGNmXQNuyxLpYI1gS9dFjN+9JB7WfMubS6NY/jMd1+gamxc+6rvZfF3XexP4KsZ+3viDl+N/EPi5mWWXpjOyyoEostmNqSClAY682tXiDOZcJW4XEVOseqcBJncMYzIUfrza5qjN+3+u8eEg+Y4vidO1WNpPKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fd1v5WsG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dd16c484dso12664485e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757084285; x=1757689085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zIHMAPIeT27Jo7B11YJpwPj+3fw+ijnx3zKE5eN5gTk=;
        b=fd1v5WsG2SUD2D/VYEuqKdCP2EEfX6IAv0g7a6ZvCpUYRGvZEfrITZmtZrqPZpKZvH
         rEqCs2pT3vTvgKheo+8Hw4NvZyjqRY9vBKxxHzMgSzXwveub64Qr9bFK5SDKw+0K0bT/
         sFU0zp1+hxtkr9orzkQVpQ8DXxb0cH3NdNgHCt8ZFKp4K+U0DVD4ip9Y+QQ5HUsNpmdK
         cqCah78fiR5lJvrFw+1kh1C3Q+xSE5TzRBWo7dqbqPzKjFlVk/YE1XDxQ3Fh5X3kic/l
         JnfQsxxtEsE/u3mfQHzu9aSuWJV4E2FQZSczBps5/+cUhQjKy2WUfDgMH74ppluC1ra3
         i2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757084285; x=1757689085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIHMAPIeT27Jo7B11YJpwPj+3fw+ijnx3zKE5eN5gTk=;
        b=fxQLY3up7OqKSqiLGUe0O3GXEsCUo+3HoMZqucPO9D5SCwk2ngc0P2VU40LuQiF4LE
         /Uv5R0vYDk7hZOVNRe/AjqveQife63n0JuWcNKw3NKLZ4plIoBx5/uJLyTtrjPHyB9/b
         Z7lsmHMtj+cN5/h/ibSmTMCgoNCVQs6OTI4xKmXXElFCC7ISJwLLJdEN2zK7YrLENjHA
         bCfUpQNO2fBYQasLziek9pVSi6iE3NCKmZllYxn1xQaynb/J5vfhjnQlusOoNtHhHHXm
         AjHVFbAfAm8Go1r9PBUQTRanBhF2LDIUbRFWRx4Ee6IBchKJrdQxYBcoTcTXrwMfJ3zJ
         6wuQ==
X-Gm-Message-State: AOJu0Yy/BNWKCZXita4z611KCEH/IFJoUEw/5AazBQyAZo0T3QcBm2pi
	Rq5IiXkjvZbQIiRStEU4WVIYdkByVW862fEIGRXEFBUTZWo57AqHbwtx
X-Gm-Gg: ASbGncuBxswF3gHfTTt3M7g2i/3xTNVZjyinSPbntW+8k9gZEusukOnF10vviE8falU
	mKOVAUA8cL+BlbdlKVuLDlqZwXB0M2LXEsoj8V4zJk/L9V9i6Dm1ucLFYX4mjleaC/2ULw47a8N
	21IZ1Rydn3SfCu3mHmVrC9QzmJSwZkZqzd7Y8z//7gMcR2kxSbpmF1h28TciukNwHMuwoeuWOBz
	dR1Hrrcvf2Bba5/YTfsLBv7PC/FQs1RSQS2LFL1x8t5jM8jjUgM3NvJ+IM2besGapDvO9oJNl4P
	SJ/dhdg2grQjnmIr37bsmFeULnTNMKIKkiWgq8xOOpzsW27JPenej+YGPWnaLr5PnaT6JhO7l3s
	1qUHS5xRID8tsDus0g6WwZlVYGebVTRmf/gNUkzBR7o1uzTaJq8sKYLTMNZ0Ta2GqWAWXE2+YjK
	PCH0iQQg==
X-Google-Smtp-Source: AGHT+IHEZqg2PpFyPMX/8YqcR+J/39bEuy86qTsdqLp3CwbzN0a0HOm/VofRaSah3z6ZjRQ4/NaO+A==
X-Received: by 2002:a05:6000:310c:b0:3e3:59cc:65ba with SMTP id ffacd0b85a97d-3e359cc6eb4mr1968245f8f.50.1757084285026;
        Fri, 05 Sep 2025 07:58:05 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1449:d619:96c0:8e08? ([2620:10d:c092:500::4:4f66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d6cf485eb7sm21775367f8f.3.2025.09.05.07.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 07:58:04 -0700 (PDT)
Message-ID: <deea94bc-8497-4f73-bf0a-7f3d61f9cc94@gmail.com>
Date: Fri, 5 Sep 2025 15:58:01 +0100
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
To: David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>
References: <20250905141137.3529867-1-david@redhat.com>
 <7B0B1E09-5083-449F-851D-FD63D32D2B3D@nvidia.com>
 <d5c34688-30b8-4360-bb71-8c85f01bc8f4@gmail.com>
 <e50c8f08-5739-4b12-bb7f-85ff045800d6@redhat.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <e50c8f08-5739-4b12-bb7f-85ff045800d6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/09/2025 15:47, David Hildenbrand wrote:
> On 05.09.25 16:43, Usama Arif wrote:
>>
>>
>> On 05/09/2025 15:37, Zi Yan wrote:
>>> On 5 Sep 2025, at 10:11, David Hildenbrand wrote:
>>>
>>>> We added an early exit in thp_underused(), probably to avoid scanning
>>>> pages when there is no chance for success.
>>>>
>>>> However, assume we have max_ptes_none = 511 (default).
>>>>
>>>> Nothing should stop us from freeing all pages part of a THP that
>>>> is completely zero (512) and khugepaged will for sure not try to
>>>> instantiate a THP in that case (512 shared zeropages).
>>>>
>>>> This can just trivially happen if someone writes a single 0 byte into a
>>>> PMD area, or of course, when data ends up being zero later.
>>>>
>>>> So let's remove that early exit.
>>>>
>>>> Do we want to CC stable? Hm, not sure. Probably not urgent.
>>>>
>>>> Note that, as default, the THP shrinker is active
>>>> (/sys/kernel/mm/transparent_hugepage/shrink_underused = 1), and all
>>>> THPs are added to the deferred split lists. However, with the
>>>> max_ptes_none default we would never scan them. We would not do that. If
>>>> that's not desirable, we should just disable the shrinker as default,
>>>> also not adding all THPs to the deferred split lists.
>>>>
>>>> Easy to reproduce:
>>>>
>>>> 1) Allocate some THPs filled with 0s
>>>>
>>>> <prog.c>
>>>>   #include <string.h>
>>>>   #include <stdio.h>
>>>>   #include <stdlib.h>
>>>>   #include <unistd.h>
>>>>   #include <sys/mman.h>
>>>>
>>>>   const size_t size = 1024*1024*1024;
>>>>
>>>>   int main(void)
>>>>   {
>>>>           size_t offs;
>>>>           char *area;
>>>>
>>>>           area = mmap(0, size, PROT_READ | PROT_WRITE,
>>>>                       MAP_ANON | MAP_PRIVATE, -1, 0);
>>>>           if (area == MAP_FAILED) {
>>>>                   printf("mmap failed\n");
>>>>                   exit(-1);
>>>>           }
>>>>           madvise(area, size, MADV_HUGEPAGE);
>>>>
>>>>           for (offs = 0; offs < size; offs += getpagesize())
>>>>                   area[offs] = 0;
>>>>           pause();
>>>>   }
>>>> <\prog.c>
>>>>
>>>> 2) Trigger the shrinker
>>>>
>>>> E.g., memory pressure through memhog
>>>>
>>>> 3) Observe that THPs are not getting reclaimed
>>>>
>>>> $ cat /proc/`pgrep prog`/smaps_rollup
>>>>
>>>> Would list ~1GiB of AnonHugePages. With this fix, they would get
>>>> reclaimed as expected.
>>>>
>>>> Fixes: dafff3f4c850 ("mm: split underused THPs")
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>>>> Cc: Nico Pache <npache@redhat.com>
>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>> Cc: Dev Jain <dev.jain@arm.com>
>>>> Cc: Barry Song <baohua@kernel.org>
>>>> Cc: Usama Arif <usamaarif642@gmail.com>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>   mm/huge_memory.c | 3 ---
>>>>   1 file changed, 3 deletions(-)
>>>>
>>> LGTM. Acked-by: Zi Yan <ziy@nvidia.com>
>>>
>>> I also notice that thp_underused() checks num_zero_pages directly
>>> against khugepaged_max_ptes_none. This means mTHPs will never be regarded
>>> as underused. A similar issue you are discussing in Nico’s khugepaged
>>> mTHP support. Maybe checks against these khugepaged_max* variables
>>> should be calculated based on nr_pages of a large folio, like
>>> making these variables a ratio in other discussion.
>>
>> I unfortunately didnt follow the series in the latest revisions.
>>
>> In the earlier revisions, I think it was decided to not add mTHPs to shrinker
>> as a start, as there are diminshing returns for smaller THPs and having a lot
>> of smaller mTHPs in the deferred list might mean that we get to PMD mapped THPs
>> a lot slower?
> 
> Probably we would want lists per order etc.
> 

Yes that makes sense! and we start with the highest order list.


