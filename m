Return-Path: <linux-kernel+bounces-754858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36BEB19D95
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B1F3AE1B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C124169F;
	Mon,  4 Aug 2025 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JTdKBRwL"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D213241679
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295992; cv=none; b=mmzwFiCiP1DZoKpQ6zrOM2deFFdsf/TobbsbalGehd98cXWIRgbHxaKOb0hmtRX/q8TS/wMuVxjv4pXJ0S/XlRaiQuUl2rbm7ubJcnyG7fItBQqdf5UmX4Ae7CNSefp5H68UPu5oNqsBCpor6XNNz6u5H/WIEUvo63f/SGEoUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295992; c=relaxed/simple;
	bh=k6axiLMya216FjZjl5h1D9HIyTUtgV1q5zr7XBeioVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZO78YAp+UnqE0ZFYWhosoj8sX8jwggiMlsa6u9dyygjFMydYI1FIfdLsI5Y3a2TXI9DZZg1IxvRHqLGI9IMVeFTp8hHYs09s8Pr0hQCQf5O+9LcMep7B82XHUzge1i0ePHqnOy0PV0G0C9bDmJjR8Isf0U4Qq8QBz12lFQ+mGw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JTdKBRwL; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70736b2ea12so15349926d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 01:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1754295989; x=1754900789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2RyP9At/8cShb7Or89FoHpjZvuniUFsB7aTWcP0pvY=;
        b=JTdKBRwLqS+BYw56QeO0V1Vm31X8v56mKy7SfT4AoLL4ZtV5iV4poDyZ7vwrPjpvyE
         ZOtKH0/mpZWpSgzwKaf3kuwi2QKmrp9BxKvNj21ZKoewDY0xyLrE6CM+zze6g4/d8UjI
         VfsrGEeWEZtenboAHTUzUJL69nT3k6dTo60jL5B+uUD24Q4h3pyKbqmyw4YNRbbg7/bi
         1dPaKVBpg/axaWFV8LINU8ubD58ggdfui2JZieA6vRfOrI9ntUW6a8MgoYqQJYy9D3MM
         mlnFshoWRSy/NRwcWmReSW4L2P86xYmBUKjekQdiy0ibB+dpOmUVJ8UxCYu1GYOBn8cD
         WNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754295989; x=1754900789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m2RyP9At/8cShb7Or89FoHpjZvuniUFsB7aTWcP0pvY=;
        b=pEE31PueAj2elfZ6HnjjBn9PgaKrElRP03CHCdOxULsWNVMxlT18aa9/KLebS9KSQ4
         O63aYu+P3/80bkSylzEHHV5Xw38MHw9dZ2Q8nI07XvQC0HLxJ+I61OJRtZwt8/Q8wefu
         1ILLBGa0msQgWSmkExrfjs9N2q7t5J1ZY/zeB3oiX/0GzbcTW3jIeoIIUYwWbr77KHzg
         /u2PYiU3o+Ht/CGYinz573ASoc3h1bDAVZJ9gt7QgjIHX71KX1IYiJ6rPoaeriP+fntX
         unAUcEVQyBXF15kovjY+esMjO6QDbE5jjapOJ7Y9aFEP2mAOPYH1U+gdwTP4D4WGHf/J
         jZ9w==
X-Forwarded-Encrypted: i=1; AJvYcCU0Q+27tvGekVJXSZSI6KJpEHZzxu1WKriJOPi+L4kp8MXl2gMci4sGCMUdOxRXbEbotGVeJGZ15rCjujI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+vFUhHNle/SNobai9ZDdXKHuYmhU9XRo2oG1Va5AEn84jc0nI
	gmkH36CJU5PtRx1S0jLSZJxZbnQomjCYXfqhK45s9qNVKYQ1vc12XWPhzz23pyQpw2o=
X-Gm-Gg: ASbGncuclqKe8Ei3mFDITyVOsHIHQJtRIQEmRelZZje03Pg+buEltt9NOwqiFyb0CVS
	oiorZajMop62/Y8zQj6Nwh10YIjNob8FH/T5nJyWYB0F9In2giry8cbvB27SKHyF5b61eF0TaZw
	tUZIBqAQ3IhX0v6yP1xe/arAFC64AjE/LjGAnf6d8/9jXmqrit4HFQCG3mx8IKur2ZK+nnz6fKU
	L/yeVzv429b8clMx15VXkvSrX32+9lUSxGpsLveMtQpuUoMFOt4EmLkQDZEjOjE3BGBMIRr7G0z
	NSdZhrIqiMxK/7potHIk3Vsl5TIMlF2A8qW2SlOVAIO6yFDsxLqBR+ge48vhVmEPwLGB6hV6z5m
	2I9BbZENneaYyrvEcP+liR3FsjmWMWP4ftFNBZVICkqkBdx4=
X-Google-Smtp-Source: AGHT+IGaNMXElcAJh0JfCTL7zEVzpv0E94UnfVK1i/Gfn/pvcITIZCAEwwbjfZEzPrFoBpsNBSwL8w==
X-Received: by 2002:ad4:5749:0:b0:709:205a:d90c with SMTP id 6a1803df08f44-70935f0e681mr124688606d6.3.1754295989130;
        Mon, 04 Aug 2025 01:26:29 -0700 (PDT)
Received: from [10.68.122.90] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cdf4831sm55138656d6.75.2025.08.04.01.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 01:26:28 -0700 (PDT)
Message-ID: <4fa8f492-c7ef-451c-8dc7-38b031c8a092@bytedance.com>
Date: Mon, 4 Aug 2025 16:26:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: use per_vma lock for MADV_DONTNEED
To: David Hildenbrand <david@redhat.com>, "Lai, Yi"
 <yi1.lai@linux.intel.com>, Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Suren Baghdasaryan <surenb@google.com>, Lokesh Gidra
 <lokeshgidra@google.com>, Tangquan Zheng <zhengtangquan@oppo.com>,
 yi1.lai@intel.com
References: <20250607220150.2980-1-21cnbao@gmail.com>
 <aJAFrYfyzGpbm+0m@ly-workstation>
 <1d1d97f9-2a67-4920-850e-accf4c82440e@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <1d1d97f9-2a67-4920-850e-accf4c82440e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/4/25 3:57 PM, David Hildenbrand wrote:
> On 04.08.25 02:58, Lai, Yi wrote:
>> Hi Barry Song,
>>
>> Greetings!
>>
>> I used Syzkaller and found that there is general protection fault in 
>> __pte_offset_map_lock in linux-next next-20250801.
>>
>> After bisection and the first bad commit is:
>> "
>> a6fde7add78d mm: use per_vma lock for MADV_DONTNEED
>> "
>>
>> All detailed into can be found at:
>> https://github.com/laifryiee/syzkaller_logs/tree/ 
>> main/250803_193026___pte_offset_map_lock
>> Syzkaller repro code:
>> https://github.com/laifryiee/syzkaller_logs/tree/ 
>> main/250803_193026___pte_offset_map_lock/repro.c
>> Syzkaller repro syscall steps:
>> https://github.com/laifryiee/syzkaller_logs/tree/ 
>> main/250803_193026___pte_offset_map_lock/repro.prog
>> Syzkaller report:
>> https://github.com/laifryiee/syzkaller_logs/tree/ 
>> main/250803_193026___pte_offset_map_lock/repro.report
>> Kconfig(make olddefconfig):
>> https://github.com/laifryiee/syzkaller_logs/tree/ 
>> main/250803_193026___pte_offset_map_lock/kconfig_origin
>> Bisect info:
>> https://github.com/laifryiee/syzkaller_logs/tree/ 
>> main/250803_193026___pte_offset_map_lock/bisect_info.log
>> bzImage:
>> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/ 
>> main/250803_193026___pte_offset_map_lock/bzImage_next-20250801
>> Issue dmesg:
>> https://github.com/laifryiee/syzkaller_logs/blob/ 
>> main/250803_193026___pte_offset_map_lock/next-20250801_dmesg.log
> 
> Skimming over the reproducer, we seem to have racing MADV_DONTNEED and 
> MADV_COLLAPSE on the same anon area, but the problem only shows up once 
> we tear down that MM.
> 
> If I would have to guess, I'd assume it's related to PT_RECLAIM 
> reclaiming empty page tables during MADV_DONTNEED -- but the kconfig 
> does not indicate that CONFIG_PT_RECLAIM was set.

On the x86_64, if PT_RECLAIM is not manually disabled, PT_RECLAIM should
be enabled; but since __pte_offset_map_lock() holds the RCU lock, there
should be no problem even if PT_RECLAIM frees the PTE page (via RCU).
Anyway, I will also find time to reproduce the problem locally and then
look into this issue.

Thanks.

> 


