Return-Path: <linux-kernel+bounces-884143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6B9C2F72E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 07:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8335334C6F6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 06:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C009B35962;
	Tue,  4 Nov 2025 06:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aX1YonBj"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50651B7F4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762237997; cv=none; b=ab2LOFmUAks6H3jWvmbcyPtgtPIrU1bXeMsxiUE4VmupgKN32doHumX3bmUF8L8Yx/Iz0b0lqA9MRFSXQOpYRqzZPwrwqDC7hhncNj/ku/Zn/QU7MoHTeXJdcLJGII28cxXU+MNsIM4MtUqVHU4Wo75+2iUO/JtMdpBv6QD+0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762237997; c=relaxed/simple;
	bh=qKgcoi3pcrygjpc0AFwC0zHhzM9thZzXIOSInB4buXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0yQJuEDKmry2+YyfUB8tGJwdlak7qBitPaSBt8lowPGWknUUDOz55Vg103Y2bBob1NMYT343F23oKZUb5NSJcnQCrTtCNA8ahLZHiy57plLkbnyZ0RjCKVsnk0BFEVj2jAwkUTiSrJNFenJLf479kj+hVtkEdN80AFNnXwXS9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aX1YonBj; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a9fb6fccabso1814428b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 22:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762237994; x=1762842794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okre2wWfSe1mulYIwiBesIuo2idWuGwL5MuWvzP58j8=;
        b=aX1YonBjKHBikCR5gs8ypN6PMt2lOEzIusmxV11zv5Vpmm1glq3iSPCBMHwdwoFNrp
         QmXLLvfu1oPio3ZumuNelFeSaxBZQqoCukguXRI8X/4L9EkTGbQYAE25QyopP3KIkCvi
         AmuWgzZHhqPEkGQYqXHkb/WeOduFQyWH0tK1195ZIG4yfxT3hJkINGi7Tdkk7zMpwZpR
         Il/Wkh0YEGSqOQ5xzjL9gEgpdnup6GuMcY3k5BkuGRbCU9Xo5Yk9VCHQbprccfMNJFf7
         Zhbc6gyJ7+SVabbrd7BbhFK3zIyNM/4eOqzq2xyDd0kd1QUecd8HL3uUN/sPMgLFQzW9
         Hhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762237994; x=1762842794;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=okre2wWfSe1mulYIwiBesIuo2idWuGwL5MuWvzP58j8=;
        b=MKLwHo5/2Ei8z/ylYekRbyu+zx5fFzhfNfrkHPApryW1Yn7y04xBLXOyqGXoLrkUdn
         RwXi2aq8DwEIy0R8ig5u1e58+pMEf+OKWrmnq+QyulZwlmHOkPmtyrUjCzpVkIrP12pd
         gj9HG4r4joQiqB2VCuTaHISyYRIw2LvGQE19mTiyZrrUBEaKZDEsG0TzM+vVzCMefzY5
         gF0egYWZs4x+ETopgIiVxDv5UUQ47MerQOKVM21MIRSFQmQLIehNGYt0iDv/UBpe373T
         vxAbymBDdlAWYVN0g0hdpQweuzcevkW7xaANqQxxPjOA2KCQ0PkCvSniyyLXjhlEQs5V
         Nwxw==
X-Forwarded-Encrypted: i=1; AJvYcCVqRVqvZHjSUxJN7MUVIi0PgB2Sg08M/+7MmMuHu4k3aadMkTuQ1jEMusoT9PMkQ9V4aQguOqYi9RrQHmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxrI6WuAjy9aVHx7HH8kH2mDsGLFScnIOmKCPnnW5DdMt2/GNO
	BZkKKnUoOIQ+KZeOiFzT6QWvDfwzM1Aqzr4LxifLK05hNyn7oix81EoymiXB7azlKls=
X-Gm-Gg: ASbGncsJtpx2zOp6a2FUqSOkUJ3Dqp2OcJ/3xEfmyDP3d09RPEJ+wuLib0FahmU0MAg
	C0SYR02qB/5YTxFY2y8OX6t/oMmwwjVqKb2XeNoDNu2HtADhZNHzwz9le4dspPCzMOe8X+aqhjI
	wTpVIseUhxZXhRxz6++5XULlTJ1zM8qmVgr4OPMqPI4XeuI1GBORc27Bag/hd4Vlhh8W+MasrzQ
	8Byq76iZoD+Foupfw8wuwpkpfHij8IWnaXpy9K213F13a/909Ls3DmSBm0+zcXwWn2V8rzLj4Vp
	bPrfLY7/T2SNQTQwgSdg8EmcrXQMj7J5+9NuGhAxDKMZJNXlg6mF2yBn1Ltp+ULLoEn8V5xZCW9
	xF7Nky3AVwoHYR863nfCTEUpQXfRUUFLl9TvHMjg49WCmm82ranj2vihKR8ubrzPBQlBh1VQLcX
	cF1ssNQP1Y8hsVEx6HnVWXuj4Wo57c2+NYXgwkhQ==
X-Google-Smtp-Source: AGHT+IEsK3Ywd+KdKURpAwPHwPCTZY4XIOGPtIduvvF1tV0A6LQireFulxj6l1bJiYfahHfhZiyCQw==
X-Received: by 2002:a05:6a20:918a:b0:33f:df99:11e5 with SMTP id adf61e73a8af0-348cbda9889mr20185915637.28.1762237994112;
        Mon, 03 Nov 2025 22:33:14 -0800 (PST)
Received: from [100.82.90.5] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd62428dfsm1576009b3a.60.2025.11.03.22.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 22:33:13 -0800 (PST)
Message-ID: <827b647d-798f-4775-bb31-ef735485c6bb@bytedance.com>
Date: Tue, 4 Nov 2025 14:33:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: Enable CONFIG_PT_RECLAIM on all architectures
To: Dev Jain <dev.jain@arm.com>, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 david@redhat.com, hannes@cmpxchg.org
Cc: ryan.roberts@arm.com, hpa@zytor.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, ppt@kernel.org, surenb@google.com,
 mhocko@suse.com, shakeel.butt@linux.dev, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251103063718.90743-1-dev.jain@arm.com>
 <044e3f9a-3de2-4939-afff-3bb527eb024b@bytedance.com>
 <666e012e-0b13-4def-82de-55ccd5868d36@arm.com>
 <9359ce51-5ac7-4312-8ef8-79fa51d014f5@bytedance.com>
 <2be04785-d725-4e79-a609-87f174271f83@arm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <2be04785-d725-4e79-a609-87f174271f83@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/4/25 12:02 PM, Dev Jain wrote:
> 
> On 03/11/25 2:37 pm, Qi Zheng wrote:
>> Hi Dev,
>>
>> On 11/3/25 4:43 PM, Dev Jain wrote:
>>>
>>> On 03/11/25 12:33 pm, Qi Zheng wrote:
>>>> Hi Dev,
>>>>
>>>> On 11/3/25 2:37 PM, Dev Jain wrote:
>>>>> The implementation of CONFIG_PT_RECLAIM is completely contained in 
>>>>> generic
>>>>> mm code. It depends on the RCU callback which will reclaim the 
>>>>> pagetables -
>>>>> there is nothing arch-specific about that. So, enable this config for
>>>>> all architectures.
>>>>
>>>> Thanks for doing this!
>>>>
>>>> But unfortunately, not all architectures call tlb_remove_ptdesc() in
>>>> __pte_free_tlb(). Some architectures directly call pte_free() to
>>>> free PTE pages (without RCU).
>>>
>>> Thanks! This was not obvious to figure out.
>>>
>>> Is there an arch bottleneck because of which they do this? I mean to 
>>> say,
>>>
>>> is something stopping us from simply redirecting __pte_free_tlb to 
>>> tlb_remove_ptdesc
>>
>> Some architectures have special handling in __pte_free_tlb(), and cannot
>> simple redirect __pte_free_tlb() to tlb_remove_ptdesc(), such as m68k,
>> powerpc, etc.
>>
>> For those architectures that call pte_free() in __pte_free_tlb(), it
>> should be easy to modify them.
>>
>> If you're not in a rush, I can take the time to finish the above tasks.
> 
> Right then, I'll leave that up to you!

OK, I will do it ASAP.

> 
> 
>>
>>>
>>> or pte_free_defer?
>>>
>>>
>>> I am looking to enable this config at least on arm64 by default, I 
>>> believe it will be legal
>>>
>>> to do this at least here.
>>
>> IIRC, arm64 can directly enable CONFIG_PT_RECLAIM, as it is supported
>> at the architecture level.
>>
>> Thanks,
>> Qi
>>
>>>
>>>
>>>>
>>>> We need to modify these architectures first, otherwise it will
>>>> lead to UAF. This approach is feasible because Hugh provides similar
>>>> support in pte_free_defer().
>>>>
>>>> Enabling PT_RECLAIM on all architecture has always been on my
>>>> TODO list, but it's been blocked by other things. :(
>>>>
>>>> Thanks,
>>>> Qi
>>>>
>>>>>
>>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>>> ---
>>>>>   arch/x86/Kconfig | 1 -
>>>>>   mm/Kconfig       | 5 +----
>>>>>   mm/pt_reclaim.c  | 2 +-
>>>>>   3 files changed, 2 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>>>> index fa3b616af03a..5681308a5650 100644
>>>>> --- a/arch/x86/Kconfig
>>>>> +++ b/arch/x86/Kconfig
>>>>> @@ -327,7 +327,6 @@ config X86
>>>>>       select FUNCTION_ALIGNMENT_4B
>>>>>       imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>>>>>       select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>>>>> -    select ARCH_SUPPORTS_PT_RECLAIM        if X86_64
>>>>>       select ARCH_SUPPORTS_SCHED_SMT        if SMP
>>>>>       select SCHED_SMT            if SMP
>>>>>       select ARCH_SUPPORTS_SCHED_CLUSTER    if SMP
>>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>>> index 0e26f4fc8717..903c37d02555 100644
>>>>> --- a/mm/Kconfig
>>>>> +++ b/mm/Kconfig
>>>>> @@ -1355,13 +1355,10 @@ config ARCH_HAS_USER_SHADOW_STACK
>>>>>         The architecture has hardware support for userspace shadow 
>>>>> call
>>>>>             stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>>>>>   -config ARCH_SUPPORTS_PT_RECLAIM
>>>>> -    def_bool n
>>>>> -
>>>>>   config PT_RECLAIM
>>>>>       bool "reclaim empty user page table pages"
>>>>>       default y
>>>>> -    depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>>>>> +    depends on MMU && SMP
>>>>>       select MMU_GATHER_RCU_TABLE_FREE
>>>>>       help
>>>>>         Try to reclaim empty user page table pages in paths other 
>>>>> than munmap
>>>>> diff --git a/mm/pt_reclaim.c b/mm/pt_reclaim.c
>>>>> index 7e9455a18aae..049e17f08c6a 100644
>>>>> --- a/mm/pt_reclaim.c
>>>>> +++ b/mm/pt_reclaim.c
>>>>> @@ -1,6 +1,6 @@
>>>>>   // SPDX-License-Identifier: GPL-2.0
>>>>>   #include <linux/hugetlb.h>
>>>>> -#include <asm-generic/tlb.h>
>>>>> +#include <asm/tlb.h>
>>>>>   #include <asm/pgalloc.h>
>>>>>     #include "internal.h"
>>>>
>>


