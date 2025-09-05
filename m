Return-Path: <linux-kernel+bounces-803135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D08D4B45AE5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840A216F7B7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133923570A6;
	Fri,  5 Sep 2025 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqCoWqXB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74684202F7B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083709; cv=none; b=bI0auL4dg9AhAoCjZ2YsYTUDbYOsZXQhAfIIQ+7PiUzpR0m09Stteow31NOFOQrvAYlGo5rTftfVroft0vqjNbtSn/vxhsrw9QEfzN2IJ8D+twAEtrfJHyL798MgKGvs9p/NYqUaqYSWjDAHUsncruVu4jlJajlzu6e4tKAugh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083709; c=relaxed/simple;
	bh=b/N6N3j0Ae/OQ1+hBRJDp18/IQlHk4UbIm3zQN9HLxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6O8HzAU2uFaIUTB5Xp0a6KaiX37GM+bc4Df1dMWEv6JhQAcW5tNFvRk7WwNRK371coJxLsdQmOCRlWyp/FXqMkjNwcKcI0ZFoFava6ytyjQD9MtVPzSEtpQ4T+vIhh6hQ5v3DQdc1mzVtAVMSjix1/hiQTRSkxBMQOmCGy8RJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqCoWqXB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757083706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4SQ0Ro6r3VEH/SXK6+NjfaydDSDk6LrxamH9i5Bcmx4=;
	b=JqCoWqXBWN6nG1VqdbpjkkkcvvVfnMkeHDtR/1dw0KyOPKKRNRT5UxmDbP+PGguQGGGd4k
	Zaf5z8ejTRQs1HK9nUw/x+UEOg67rbo1jDJNHDgdNN0EIZLhSnd7hzuFhkxQLZaPnxWldb
	c4v9FVqYL+hwry7txBXQHqq/slS2w9k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-Q7TwUV6eP5iICe8JuDj5uQ-1; Fri, 05 Sep 2025 10:47:17 -0400
X-MC-Unique: Q7TwUV6eP5iICe8JuDj5uQ-1
X-Mimecast-MFC-AGG-ID: Q7TwUV6eP5iICe8JuDj5uQ_1757083635
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3df9f185c7cso1871258f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757083635; x=1757688435;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4SQ0Ro6r3VEH/SXK6+NjfaydDSDk6LrxamH9i5Bcmx4=;
        b=raVnLre1IF53iQdZBVrtiL8gZ7eUxx3bt6ZjSlXI7F0FJQfbQiXJzHnFuORtcH8g+K
         dwODAa+LGyu/yxGTQXEdLFfgGES0YpHE2ReiRkvoNKGz8Yvokh85V1kS1X+/kBM3VSEE
         b7xCoCD+QP6g18E9RyL7mWlof75oFygm0eN8qsnlzkrnE6jUTH9pxre7BOkKwQGpfg4h
         I6NKczIS8YSUV9xgh8s7npLuanIRXe/daqSQyRnc79Y7vdjXMLcDckgGWn0DUV+eHzCK
         DAhKlCa920195ZDzyQAOjuiVj6mPu/fb7T6haM2TMXvHA3SBrM2S88+1SXievuiqT43r
         AUBA==
X-Gm-Message-State: AOJu0Yx6fg9MbzFpXzkDjDTaBdvoQ07CBhE1xmhCoU9OKzVmDTa5Pcxa
	0BE4GWjEWVX/h4SMkCwvn5AcAwZhLaMEqPbHLlJXA+J5ym0bd32T8G2uddlKNdkn0CBSCLDdJaB
	yOp5EArGbMcJGHb/5LvWAeFW+20xQuOGQFaOj58W95LknZCk2upu91dkt2wOLkTV3ig==
X-Gm-Gg: ASbGncsd+bpTzJsB65yH0e3WdgU9DuiBmNV7p4G5xXQwDVVB7m8da5Gh5uD11SS3Muj
	S1nRJ3icyIvQ49LfdkSo/j9QqWJ6+unhR7L46xEnBDvwmCsuZQb3DohWwBFdIrrAsj0PVBts+lL
	Fdkgzf5U22VjQgq37/cy77I56cfecTcYcwTc3HMDPngIMN8gEUcRpudwIehm33VISzLmFYl/IZW
	TJhxmQg574KyO/89NGywh2v+6Tw4Ux+2XR/1CNPyJAnNT0h6ECY1ul3Cd9g6TSD4IN0qh/lb7N7
	DED+s0iqX94Xxoohq9yDsPMQoQK8qBI2svZI4/T9nJOnlaJ+axDkXD5I2dfqtg/c7vE6lm7JafJ
	wSu2ySEJvgys2cfJJk0W1mCxeKEthPkcwCy+xQ6thQpg9ls1bNQ8zwlKP
X-Received: by 2002:a5d:5d12:0:b0:3e5:25c2:9635 with SMTP id ffacd0b85a97d-3e525d1dc27mr438668f8f.56.1757083634855;
        Fri, 05 Sep 2025 07:47:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsUupoJXbadFaOODLu7jEx9s5JVw11Dqu700eHEpd8jEbAgw1rjB4CH/KLDO9aKS3NLxFfjQ==
X-Received: by 2002:a5d:5d12:0:b0:3e5:25c2:9635 with SMTP id ffacd0b85a97d-3e525d1dc27mr438641f8f.56.1757083634411;
        Fri, 05 Sep 2025 07:47:14 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:e00:298:59cc:2514:52? (p200300d82f4d0e00029859cc25140052.dip0.t-ipconnect.de. [2003:d8:2f4d:e00:298:59cc:2514:52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fba9fbsm31805962f8f.50.2025.09.05.07.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 07:47:13 -0700 (PDT)
Message-ID: <e50c8f08-5739-4b12-bb7f-85ff045800d6@redhat.com>
Date: Fri, 5 Sep 2025 16:47:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/huge_memory: fix shrinking of all-zero THPs with
 max_ptes_none default
To: Usama Arif <usamaarif642@gmail.com>, Zi Yan <ziy@nvidia.com>
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <d5c34688-30b8-4360-bb71-8c85f01bc8f4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.09.25 16:43, Usama Arif wrote:
> 
> 
> On 05/09/2025 15:37, Zi Yan wrote:
>> On 5 Sep 2025, at 10:11, David Hildenbrand wrote:
>>
>>> We added an early exit in thp_underused(), probably to avoid scanning
>>> pages when there is no chance for success.
>>>
>>> However, assume we have max_ptes_none = 511 (default).
>>>
>>> Nothing should stop us from freeing all pages part of a THP that
>>> is completely zero (512) and khugepaged will for sure not try to
>>> instantiate a THP in that case (512 shared zeropages).
>>>
>>> This can just trivially happen if someone writes a single 0 byte into a
>>> PMD area, or of course, when data ends up being zero later.
>>>
>>> So let's remove that early exit.
>>>
>>> Do we want to CC stable? Hm, not sure. Probably not urgent.
>>>
>>> Note that, as default, the THP shrinker is active
>>> (/sys/kernel/mm/transparent_hugepage/shrink_underused = 1), and all
>>> THPs are added to the deferred split lists. However, with the
>>> max_ptes_none default we would never scan them. We would not do that. If
>>> that's not desirable, we should just disable the shrinker as default,
>>> also not adding all THPs to the deferred split lists.
>>>
>>> Easy to reproduce:
>>>
>>> 1) Allocate some THPs filled with 0s
>>>
>>> <prog.c>
>>>   #include <string.h>
>>>   #include <stdio.h>
>>>   #include <stdlib.h>
>>>   #include <unistd.h>
>>>   #include <sys/mman.h>
>>>
>>>   const size_t size = 1024*1024*1024;
>>>
>>>   int main(void)
>>>   {
>>>           size_t offs;
>>>           char *area;
>>>
>>>           area = mmap(0, size, PROT_READ | PROT_WRITE,
>>>                       MAP_ANON | MAP_PRIVATE, -1, 0);
>>>           if (area == MAP_FAILED) {
>>>                   printf("mmap failed\n");
>>>                   exit(-1);
>>>           }
>>>           madvise(area, size, MADV_HUGEPAGE);
>>>
>>>           for (offs = 0; offs < size; offs += getpagesize())
>>>                   area[offs] = 0;
>>>           pause();
>>>   }
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
>>>   mm/huge_memory.c | 3 ---
>>>   1 file changed, 3 deletions(-)
>>>
>> LGTM. Acked-by: Zi Yan <ziy@nvidia.com>
>>
>> I also notice that thp_underused() checks num_zero_pages directly
>> against khugepaged_max_ptes_none. This means mTHPs will never be regarded
>> as underused. A similar issue you are discussing in Nico’s khugepaged
>> mTHP support. Maybe checks against these khugepaged_max* variables
>> should be calculated based on nr_pages of a large folio, like
>> making these variables a ratio in other discussion.
> 
> I unfortunately didnt follow the series in the latest revisions.
> 
> In the earlier revisions, I think it was decided to not add mTHPs to shrinker
> as a start, as there are diminshing returns for smaller THPs and having a lot
> of smaller mTHPs in the deferred list might mean that we get to PMD mapped THPs
> a lot slower?

Probably we would want lists per order etc.

-- 
Cheers

David / dhildenb


