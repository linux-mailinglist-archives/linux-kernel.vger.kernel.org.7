Return-Path: <linux-kernel+bounces-803125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE61B45AC9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3988A607B3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13566371E9F;
	Fri,  5 Sep 2025 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfqoQX0C"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9490B36CE1D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083430; cv=none; b=RJQ0gzbi5Ush5sapz3u7tUFoqGWpJpKJWERPeQ5xTBmjIRACc6H86mKQ6JddlC+5ORE/pvkmlTUXBOtJbaGOtHH9ZxKvQw3klzt/Gq+t15NNZG0ee+11kISH5DbQ7+cpIiu9SCMnAFFMtIou0I14wDrG4roXFemnTAb0GzpfgVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083430; c=relaxed/simple;
	bh=SXAksEB+Zw4a3or8qPJNRrMo1yTLsj901ZKAySc0z8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qy7GWyxAKWHxXMvlElsKZai17KRnfG1b8t/mDnSXJrgQzrJY/wtEnci/RMIp1KlTkCl9Wsyg65OlETKSnArbp8DA5ozS3Y1ON8/OkOp/VZGX2pRmQGPVzarNiWEJLPb5J3fjCzb/WxjPBsHtP7fRQodzpXQYgPCzb7vq5sIFX8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfqoQX0C; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45ddcb1f495so1063255e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757083427; x=1757688227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gwJaAVz81BObi+H/arsIEh5sBDwsjXLHGvxI5p+NvZc=;
        b=SfqoQX0COVMs9m9QEoVQYWyXvuTCksnwrIYoKnhhHuC0o7aYLcDP7W8KwtaW/SN5Mw
         8FVABnj1Ohhydw7D8pa2greH28EZ+83S29+Dlt4T5nlCM+VZ4lW050WcssEmIMnfrENi
         JYb9AB9dpyeBwlejn+wBmHWX4SxhDSgx6CJdFIfka7D3IAMj7m7JyuL9kTibnEZ7H9v0
         vPjI7+wYF5uQXRrS+UXmMW7vjrqbU2Yk3Fx5KZLwD6A0LZIsr8BvWTDltjVDehFQ30TW
         AFVMlK+X9QwE5jwFbaatK/F347XVj3lmQWUXgAFS22bVjkdHJ19lx9z8DiiuxVZeuT7f
         zPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757083427; x=1757688227;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwJaAVz81BObi+H/arsIEh5sBDwsjXLHGvxI5p+NvZc=;
        b=Bbh7xVnOhxy2BL42o3LWop8IOl1AJueg3UtrIiapZS6pWFiimzHwiCiaoVS7P5pH81
         AV6RPuR0r5WEUejUHUUO3YgvE2n0e/P5sm9jJKvv9Pg+BBQ6thxF55YLRmdH+JjYeYB1
         AcjrPOs2XeKztYyQjJ1IT43D0VIbNoHCXX//x1nUpV/xugtNeRILc/oFnh71eBvameGM
         RTn09SdVSDH6njYaS94MmXEs2rw0iWrNnW2yg6NqvxaFSPIn1W9AJofDPv80lmSRHkXa
         HiFeDYJ3gFObAc1YRp6oyTbwCjPkD6XDJpChULfu48E2MBbuPCKSSO22HktDzksXOH6t
         YxSw==
X-Gm-Message-State: AOJu0Yz0oHUKT4TTPYpgX2bJZ/yN9NcaYA9kNxO4SQsz74V7l64i56Im
	j9RrtTgyctRsQtdC6xOLDlzmBNWL1/GbJGx+2N5XkqgBDq5sBV2JKbCy
X-Gm-Gg: ASbGnctGIpSrZybglM22LTexJI4HG4F6EH1EDlamf9wEM7039Yj/9YJitHpa6Jh0W+S
	HBNfiAZQ4xx9vOZ40hcCDve7y51bTzq66xPLf7JZh+Gauc3ApLOUe+PyqcrDmjboVz29R8OPgMo
	O37v36ycIDTw4UEdAGNrM39e7Z8t6ND6+gTiKS1K6wmNywAKQPi5Kni7QPA6LYQ61sf1QB+QQIL
	zw8ATg5CnqTUl8U0l0QW87QfW+rpf7888f2Frp1PhGTyyHjZ208tTKMnYogNyCSI0ErktXbTREG
	ZrgdkB99Ok67v8aE81+BFjeAtDSV3oL1VU9wHJPx7uhD36wS11a9KVXeqeCkAJhQxja1qfMu44N
	ecBrAmKeNUrQ0rQ8qBpE8yxUmnIOdR0GpJi0+H6ihCgsH/chtaV718Ezp4Cv1sLOYfxLxrwE=
X-Google-Smtp-Source: AGHT+IGTEmyI3GJ5+Bu7s94GgTAOG29U9ayxB6BDUIhPl8/Z0BjlcNHrWbUoE21RMRPW1bmYwLPBlg==
X-Received: by 2002:a05:600c:4715:b0:45b:43cc:e558 with SMTP id 5b1f17b1804b1-45b8558ad00mr208282635e9.35.1757083426547;
        Fri, 05 Sep 2025 07:43:46 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1449:d619:96c0:8e08? ([2620:10d:c092:500::4:4f66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8f2d3c88sm200044495e9.19.2025.09.05.07.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 07:43:45 -0700 (PDT)
Message-ID: <d5c34688-30b8-4360-bb71-8c85f01bc8f4@gmail.com>
Date: Fri, 5 Sep 2025 15:43:43 +0100
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
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>
References: <20250905141137.3529867-1-david@redhat.com>
 <7B0B1E09-5083-449F-851D-FD63D32D2B3D@nvidia.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <7B0B1E09-5083-449F-851D-FD63D32D2B3D@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/09/2025 15:37, Zi Yan wrote:
> On 5 Sep 2025, at 10:11, David Hildenbrand wrote:
> 
>> We added an early exit in thp_underused(), probably to avoid scanning
>> pages when there is no chance for success.
>>
>> However, assume we have max_ptes_none = 511 (default).
>>
>> Nothing should stop us from freeing all pages part of a THP that
>> is completely zero (512) and khugepaged will for sure not try to
>> instantiate a THP in that case (512 shared zeropages).
>>
>> This can just trivially happen if someone writes a single 0 byte into a
>> PMD area, or of course, when data ends up being zero later.
>>
>> So let's remove that early exit.
>>
>> Do we want to CC stable? Hm, not sure. Probably not urgent.
>>
>> Note that, as default, the THP shrinker is active
>> (/sys/kernel/mm/transparent_hugepage/shrink_underused = 1), and all
>> THPs are added to the deferred split lists. However, with the
>> max_ptes_none default we would never scan them. We would not do that. If
>> that's not desirable, we should just disable the shrinker as default,
>> also not adding all THPs to the deferred split lists.
>>
>> Easy to reproduce:
>>
>> 1) Allocate some THPs filled with 0s
>>
>> <prog.c>
>>  #include <string.h>
>>  #include <stdio.h>
>>  #include <stdlib.h>
>>  #include <unistd.h>
>>  #include <sys/mman.h>
>>
>>  const size_t size = 1024*1024*1024;
>>
>>  int main(void)
>>  {
>>          size_t offs;
>>          char *area;
>>
>>          area = mmap(0, size, PROT_READ | PROT_WRITE,
>>                      MAP_ANON | MAP_PRIVATE, -1, 0);
>>          if (area == MAP_FAILED) {
>>                  printf("mmap failed\n");
>>                  exit(-1);
>>          }
>>          madvise(area, size, MADV_HUGEPAGE);
>>
>>          for (offs = 0; offs < size; offs += getpagesize())
>>                  area[offs] = 0;
>>          pause();
>>  }
>> <\prog.c>
>>
>> 2) Trigger the shrinker
>>
>> E.g., memory pressure through memhog
>>
>> 3) Observe that THPs are not getting reclaimed
>>
>> $ cat /proc/`pgrep prog`/smaps_rollup
>>
>> Would list ~1GiB of AnonHugePages. With this fix, they would get
>> reclaimed as expected.
>>
>> Fixes: dafff3f4c850 ("mm: split underused THPs")
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>> Cc: Nico Pache <npache@redhat.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Dev Jain <dev.jain@arm.com>
>> Cc: Barry Song <baohua@kernel.org>
>> Cc: Usama Arif <usamaarif642@gmail.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  mm/huge_memory.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
> LGTM. Acked-by: Zi Yan <ziy@nvidia.com>
> 
> I also notice that thp_underused() checks num_zero_pages directly
> against khugepaged_max_ptes_none. This means mTHPs will never be regarded
> as underused. A similar issue you are discussing in Nico’s khugepaged
> mTHP support. Maybe checks against these khugepaged_max* variables
> should be calculated based on nr_pages of a large folio, like
> making these variables a ratio in other discussion.

I unfortunately didnt follow the series in the latest revisions.

In the earlier revisions, I think it was decided to not add mTHPs to shrinker
as a start, as there are diminshing returns for smaller THPs and having a lot
of smaller mTHPs in the deferred list might mean that we get to PMD mapped THPs
a lot slower?

> 
> Best Regards,
> Yan, Zi


