Return-Path: <linux-kernel+bounces-866098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2655FBFEDF3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AC73A5CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E981D5CD4;
	Thu, 23 Oct 2025 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvDY4lhO"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4EE47F4A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761184139; cv=none; b=KQb6zZ/U2eBEsOy52S+cnWlXWggYU2m+tcigEFuUVr574whziAmGFzW5DOFvj8g+X3HWhAnf22GGLkeQJpde2Bmj/McANGdTH15ngo7oOBHmmoJwPe9djCZIoQ2Rgta0liSwO15+f3qb/AXj9FchmiXeImJS8v7IZHBuxqnTPBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761184139; c=relaxed/simple;
	bh=3bZE4UA1L0yD1IVoPp18bgdwWZBwc3tJKIS5Era+DNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzF44bPuURnVNhS0jvxUSmX4eaQu/Gg0HFMTlQW2Hycfcnoy5MZnyN5YGs8BNoQ3zToA1m4kqDJc+W9RsaGkxFrWbASUu0okyePBrhZyAY6fH11W+tbja9TVEKq78FOVYA65S/NdUFFklKtsOJAM7F3miWCAzmvIBAh64njbySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvDY4lhO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-290ac2ef203so2155635ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761184137; x=1761788937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3bZE4UA1L0yD1IVoPp18bgdwWZBwc3tJKIS5Era+DNY=;
        b=gvDY4lhO2n4WbA76G15SbVqD1Azw+xuzycAgUghTAk4wDzLSFMcuXkqNKKIiEqFM5u
         gNNVGlGyKuVAIZaq+RJc8oC09y5fMlAgrUCIsdYuxW1bIxPYEF22L7ypuVH/fP4FzBcK
         nO0l7fZGfBOh2CpTvtHsv8kqdDVcIh1R6N1TWjkZYtf5gaRlGpWbh9sVxt/HNIx+ywju
         Jmv9WTZdeFLBvDJVLhK0l4jk8NLlNzZRv3NCH4KgShRnYcfc5F94P/IMKvDVfeIPlDXc
         b73GiEFNcbihsbEY1nu2k3ItnpXw9VEqd/FO0F68m5YGchCJANKSlqnkCF7UOM12jYPN
         PIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761184137; x=1761788937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bZE4UA1L0yD1IVoPp18bgdwWZBwc3tJKIS5Era+DNY=;
        b=FvkrTNOgaj5ERipgo6aTDxYOpWCvTKwc5vf2aZDPdsiWK7FzXaQsSSwaDs+XwSuEiv
         0dTcjtczibMKYl6A0BPYQFGa7QjHSgay9KisSd5NBW/eN8nA8InamH+pghXggWDfAe2E
         zeFbOemqvOEJKBvpOVFStwpChVkW7OHb86FOFymjfqrTnw04pP4z+MasFrbjF3tM7xAV
         llPgScwkTbJktdY5hH0VtdZghlYq6kLKrE+8E7jdAM/uYiN2cgxEbdd/2sO6ovMzyXi6
         EIH1up6mfDRfjFUS3CpfrzN+0rFJfVQVR/u0baItgCzHoPVh6428H3xPD/hpby/HWr7f
         VlfA==
X-Forwarded-Encrypted: i=1; AJvYcCUVUbZYhMrDYpFwOzjhyp04ihsgRevD5Hq62C3GZUPK74RYD1pFCTtMgcMGK6k73zF86eoAxyqpirzAFI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHXJ1wjqQXPSGnQBmfY/v9SWiwc36IYFgb9urdlCjDONhEkrGu
	xgNkGwPXSH2h/f1jdvaX4d0HIwkUMx2F5nb/UslYMEzd7u0vDgeEms7Q
X-Gm-Gg: ASbGnctCi4uJ2My+NY7xGyBz2kg6xhIqx9PVyqDF9+1N1FjTvElCkYJNU7dZPhP1L4J
	3dh4ZTkoizTL+fwlVeffAXcAM6G9sH73HB510gX10B6+JsJ+0B1NwWcu/gPgksajPgWbjMCQnfC
	97OFSuRt3uZmKfOhAXhMl6oeh69Za8wK3no1SlcKwATc7Nl5TLCe0UWelpwzxkrNad+cPBV+Azu
	IsA1htJyFWp1C7RyCIrfIcIWXEKNJ9YxYlujYgCFHEMpXAlgtprOuxKPo5u+l9rvzoXZyUj2FbK
	KVwfymCdcG2xLyj7JnAPtTPrSPB5Te1nGrA8ppzAWxQCeRUGP3MweZ4xewLF5uyDTeWaEVbinfA
	+bDFgeWr2Niw1KoFK5iL0lhJB9/dJIrmtjOnSNme9TZTD53gvfErNUShFaIu8FSAMKGWjecca0J
	tHMLxqvQHIfjw/q5QGKM2UvM0zNPy4NPSoCz9anNp9YXR6jGqxYnZmMV0IeONemQo=
X-Google-Smtp-Source: AGHT+IEKcWqMd+Ibu+5o3ItMIQKDF2MZdBQkD0wrpJAHT7sKfd2+s1DFgDv6i1HEiqvV30MRG2j1Hw==
X-Received: by 2002:a17:902:f605:b0:26e:62c9:1cc4 with SMTP id d9443c01a7336-290c9c89da2mr253507475ad.4.1761184136681;
        Wed, 22 Oct 2025 18:48:56 -0700 (PDT)
Received: from ?IPV6:2804:14c:5fc8:8033:f287:781:fdff:28fd? ([2804:14c:5fc8:8033:f287:781:fdff:28fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e0f419csm5126715ad.89.2025.10.22.18.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 18:48:56 -0700 (PDT)
Message-ID: <07cd9c09-2a4f-48d5-845f-0c958b7b45d0@gmail.com>
Date: Wed, 22 Oct 2025 22:48:52 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 craftfever <craftfever@airmail.cc>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251022153059.22763-1-pedrodemargomes@gmail.com>
 <20251022133118.f13f924348e8cdc6d49ef268@linux-foundation.org>
 <f42b7b67-7de4-4a7b-8074-25ca87a952a6@redhat.com>
Content-Language: en-US
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
In-Reply-To: <f42b7b67-7de4-4a7b-8074-25ca87a952a6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/22/25 17:52, David Hildenbrand wrote:

> On 22.10.25 22:31, Andrew Morton wrote:
>> On Wed, 22 Oct 2025 12:30:59 -0300 Pedro Demarchi Gomes <pedrodemargomes@gmail.com> wrote:
>>
>>> Currently, scan_get_next_rmap_item() walks every page address in a VMA
>>> to locate mergeable pages. This becomes highly inefficient when scanning
>>> large virtual memory areas that contain mostly unmapped regions.
>>>
>>> This patch replaces the per-address lookup with a range walk using
>>> walk_page_range(). The range walker allows KSM to skip over entire
>>> unmapped holes in a VMA, avoiding unnecessary lookups.
>>> This problem was previously discussed in [1].
>>>
>>> [1] https://lore.kernel.org/linux-mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/
>>>
>>
>> Thanks.  It would be helpful of the changelog were to tell people how
>> significant this change is for our users.
>>
>>> Reported-by: craftfever <craftfever@airmail.cc>
>>> Closes: https://lkml.kernel.org/r/020cf8de6e773bb78ba7614ef250129f11a63781@murena.io
>>
>> Buried in here is a claim that large amount of CPU are being used, but
>> nothing quantitative.
>>
>> So is there something we can tell people who are looking at this patch
>> in Feb 2026 and wondering "hm, should I add that to our kernel"?
>>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Co-developed-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> Fixes: 31dbd01f3143 ("ksm: Kernel SamePage Merging")
>>
>> If the observed runtime problem is bad enough then a cc:stable might be
>> justified.  But a description of that observed runtime behavior would
>> be needed for that, please.
>
> Agreed.
>
> With the following simple program
>
> #include <unistd.h>
> #include <stdio.h>
> #include <sys/mman.h>
>
> /* 32 TiB */
> const size_t size = 32ul * 1024 * 1024 * 1024 * 1024;
>
> int main() {
>         char *area = mmap(NULL, size, PROT_READ | PROT_WRITE,
>                           MAP_NORESERVE | MAP_PRIVATE | MAP_ANON, -1, 0);
>
>         if (area == MAP_FAILED) {
>                 perror("mmap() failed\n");
>                 return -1;
>         }
>
>         /* Populate a single page such that we get an anon_vma. */
>         *area = 0;
>
>         /* Enable KSM. */
>         madvise(area, size, MADV_MERGEABLE);
>         pause();
>         return 0;
> }
>
> $ ./ksm-sparse  &
> $ echo 1 > /sys/kernel/mm/ksm/run
>
> ksmd goes to 100% for quite a long time.
>
> Now imagine if a cloud user spins up a couple of these programs.
>
> KSM in the system is essentially deadlocked not able to deduplicate
> anything of value.
>
> @Pedro, can you incorporate all that in the patch description? 

Ok, I will send a v5 with a better changelog and patch description.
Thanks!

