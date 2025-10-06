Return-Path: <linux-kernel+bounces-842689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E41BBD4ED
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 10:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C37334990D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 08:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE88F25A65B;
	Mon,  6 Oct 2025 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFvV4wPQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C0D191F84
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738095; cv=none; b=dS2/3KGiV2tmpDQF+kG2yPmkx/0HUcOLiyR4UqM4g8n/vnT1iD6eGyjcb2NEIwKK0WfbD3cmrBaKRFCJO1nCKIz5RvdReqSdOvqg5J7vmdR4ENdufebE9S7EAY+9Uli/Q9xvphqDxPtf1dPGHCJne+pCMJ1tbqBfM3A1ceUIFEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738095; c=relaxed/simple;
	bh=4YF+sLFDAM9U/MQ0assch3XomT796YOK20Cc/hXEyZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/8Upwpc1d14SWF/5IdP5/j0aPBYBjgvTHLhGGXXHyTrGZwJ1NhSdLgoEanv4lPhEObtqDhJnbKtFE1x4MNuW8ciPeHeIwP/3F2uii0gEHOJNvTsS+qXJTVQgSw/pZqEwsEVajnnHKP8iKr4sD1vTlu8AECsG2/csCkPhWUzPk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GFvV4wPQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759738090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1LH7gg0R/zagF5YNDwUK9dgqqWQV3CkJhLn5zZf6KyM=;
	b=GFvV4wPQkj369Tanu4uUycJ47qHzjKdWWMRxiPlm6Nsmv20iGIqIqUhP4yolx599TCDxqt
	xNgjCmbSLj8MXhT9NQa1qN0ReeBmMuznPAshoX0PUX4M4Eu1oFGLqBZTY2EeFmWlEZnskB
	vNQXtcJN1kfamhI0qQW0gcUECmU+qiI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-wD7zGo7ON0-oUxuvt6j7lA-1; Mon, 06 Oct 2025 04:08:09 -0400
X-MC-Unique: wD7zGo7ON0-oUxuvt6j7lA-1
X-Mimecast-MFC-AGG-ID: wD7zGo7ON0-oUxuvt6j7lA_1759738088
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b2f9dc3264bso470166866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 01:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759738088; x=1760342888;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LH7gg0R/zagF5YNDwUK9dgqqWQV3CkJhLn5zZf6KyM=;
        b=hizcRWpeZROyjcoaF1+yzcDwQyQRCpZRtTdUhfhKh1UE4Ae6kPrDw4A2Sd1fd/JXbQ
         RfGlg02w0T1y+kLfu5V8Ifj18yXTKyNiYHkX+yqNAQe4BGpRDtE6asCDS5ZAq6ax+Ftq
         jkCpT+CWCsfjmbcvq73xZk89rELT/AqlrWjI5uzfls/mNGiGd/SLo8WYB253+5OEkxfV
         q3goRB2Mq7FOOEaaTy1lKgMP4RJp/ue89rsyIQUBQpr0FeNkgOauYLruHzM/zPEkifeZ
         w1QpkzOSbEtXODt7qtR7VqCyf6kbI2S8J+OJ88vfIx/zpFmqmXt6Gpa/dE6sBCCjiR/D
         UqOA==
X-Forwarded-Encrypted: i=1; AJvYcCUDkeRg3zFDOclreWUTw/b9W73lj1BBnxELC1lNKvDRhHjsGwOcdOURkKfGBrZ1SrY6lOSQA+bRBUSLjYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn8ozxoidEf9e0k2FsTOGnbFZDKh0U4bucA7udX1eRAaVTpmhd
	8MguW1HDPIbYlwbPVxnL8qGzVC91sDClqqSfqZJM0UKI4FoAeDXpC7H5iOhnf4K/ct2kSfaE23K
	cgPyZxL8v+UCZ1w/lvxwXw3zKEj89X/23wvV+tMOfoR6bOvw7lFjGYj9RjG9fUgPL+Q==
X-Gm-Gg: ASbGncsCwsLY84c3ALAa0WpV9bOffEvcVDLnuOho5lS9aKHRTRIcEDipybGhVPskZeD
	19w3gAnmzXWtv/6QUJddbhTkUvC9y9dy29dTMdX7WZWCt1wrMcZIRJUJBTfeTmlT18B7XNzbSjS
	K2dZecoUvIA4Cr8NEQlINAZM54GXGQvq2jy08ABY0SCcXOC7vk8kMqVWCNUHHvDMV2bXQnfEU6R
	JLGe1ElpgTwqI1g2pGbDbCTTXX2brb8Dv/3GJJZnyzgQMlsSJa8ismnwPAP1XavM5iujOcE8T1c
	FG/O3ppBLqEPYzqtSuVIArnk4RULtY0DHw/kEElQax6oWkZTmToZadj4YXQQa+o2NuyCjPHGetH
	EZnTkycCx3w==
X-Received: by 2002:a17:907:3f8a:b0:b40:e7ee:b5e2 with SMTP id a640c23a62f3a-b49c324734amr1494043766b.55.1759738088119;
        Mon, 06 Oct 2025 01:08:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtakkYoJz6K7M3XZUyaPDhC81kQRvghygvuJwDXhhhYduIH44D07jM28OZulcGAgavfB3ooQ==
X-Received: by 2002:a17:907:3f8a:b0:b40:e7ee:b5e2 with SMTP id a640c23a62f3a-b49c324734amr1494040966b.55.1759738087657;
        Mon, 06 Oct 2025 01:08:07 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net. [47.64.114.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b30asm1107001866b.59.2025.10.06.01.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 01:08:07 -0700 (PDT)
Message-ID: <1ef2b1b3-dab4-49c6-93ce-0868913e6dcc@redhat.com>
Date: Mon, 6 Oct 2025 10:08:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/41] hexagon: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 non-uapi headers
To: Brian Cain <brian.cain@oss.qualcomm.com>, linux-kernel@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-14-thuth@redhat.com>
 <b0052a1e-4089-44de-a02d-a39143d5d9c3@oss.qualcomm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <b0052a1e-4089-44de-a02d-a39143d5d9c3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/04/2025 17.16, Brian Cain wrote:
> 
> On 3/14/2025 2:09 AM, Thomas Huth wrote:
>> While the GCC and Clang compilers already define __ASSEMBLER__
>> automatically when compiling assembly code, __ASSEMBLY__ is a
>> macro that only gets defined by the Makefiles in the kernel.
>> This can be very confusing when switching between userspace
>> and kernelspace coding, or when dealing with uapi headers that
>> rather should use __ASSEMBLER__ instead. So let's standardize on
>> the __ASSEMBLER__ macro that is provided by the compilers now.
>>
>> This is a completely mechanical patch (done with a simple "sed -i"
>> statement).
>>
>> Cc: Brian Cain <brian.cain@oss.qualcomm.com>
>> Cc: linux-hexagon@vger.kernel.org
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
> 
> 
> Acked-by: Brian Cain <brian.cain@oss.qualcomm.com>

  Hi Brian!

Could you please merge the two hexagon patches through the hexagon tree? 
(most of the patches for the other architectures have also been picked up by 
the respective architecture maintainers)

  Thanks,
   Thomas


> 
>>   arch/hexagon/include/asm/hexagon_vm.h  |  4 ++--
>>   arch/hexagon/include/asm/mem-layout.h  |  6 +++---
>>   arch/hexagon/include/asm/page.h        |  4 ++--
>>   arch/hexagon/include/asm/processor.h   |  4 ++--
>>   arch/hexagon/include/asm/thread_info.h | 12 ++++++------
>>   5 files changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/hexagon/include/asm/hexagon_vm.h b/arch/hexagon/include/ 
>> asm/hexagon_vm.h
>> index 9aa2493fe7863..e1e702eb9e12a 100644
>> --- a/arch/hexagon/include/asm/hexagon_vm.h
>> +++ b/arch/hexagon/include/asm/hexagon_vm.h
>> @@ -39,7 +39,7 @@
>>   #define HVM_TRAP1_VMGETREGS        22
>>   #define HVM_TRAP1_VMTIMEROP        24
>> -#ifndef __ASSEMBLY__
>> +#ifndef __ASSEMBLER__
>>   enum VM_CACHE_OPS {
>>       hvmc_ickill,
>> @@ -178,7 +178,7 @@ static inline long __vmintop_clear(long i)
>>   #else /* Only assembly code should reference these */
>> -#endif /* __ASSEMBLY__ */
>> +#endif /* __ASSEMBLER__ */
>>   /*
>>    * Constants for virtual instruction parameters and return values
>> diff --git a/arch/hexagon/include/asm/mem-layout.h b/arch/hexagon/include/ 
>> asm/mem-layout.h
>> index e2f99413fe56e..8bad920d8928a 100644
>> --- a/arch/hexagon/include/asm/mem-layout.h
>> +++ b/arch/hexagon/include/asm/mem-layout.h
>> @@ -25,7 +25,7 @@
>>    */
>>   #ifdef CONFIG_HEXAGON_PHYS_OFFSET
>> -#ifndef __ASSEMBLY__
>> +#ifndef __ASSEMBLER__
>>   extern unsigned long    __phys_offset;
>>   #endif
>>   #define PHYS_OFFSET    __phys_offset
>> @@ -44,7 +44,7 @@ extern unsigned long    __phys_offset;
>>   #define STACK_TOP            TASK_SIZE
>>   #define STACK_TOP_MAX            TASK_SIZE
>> -#ifndef __ASSEMBLY__
>> +#ifndef __ASSEMBLER__
>>   enum fixed_addresses {
>>       FIX_KMAP_BEGIN,
>>       FIX_KMAP_END,  /*  check for per-cpuism  */
>> @@ -101,7 +101,7 @@ extern int max_kernel_seg;
>>    * and pkmap_base begins.
>>    */
>>   #define VMALLOC_END (PKMAP_BASE-PAGE_SIZE*2)
>> -#endif /*  !__ASSEMBLY__  */
>> +#endif /*  !__ASSEMBLER__  */
>>   #endif /* _ASM_HEXAGON_MEM_LAYOUT_H */
>> diff --git a/arch/hexagon/include/asm/page.h b/arch/hexagon/include/asm/ 
>> page.h
>> index 137ba7c5de481..7e651428a08c0 100644
>> --- a/arch/hexagon/include/asm/page.h
>> +++ b/arch/hexagon/include/asm/page.h
>> @@ -48,7 +48,7 @@
>>   #include <vdso/page.h>
>>   #ifdef __KERNEL__
>> -#ifndef __ASSEMBLY__
>> +#ifndef __ASSEMBLER__
>>   /*
>>    * This is for PFN_DOWN, which mm.h needs.  Seems the right place to 
>> pull it in.
>> @@ -128,7 +128,7 @@ static inline unsigned long virt_to_pfn(const void 
>> *kaddr)
>>   /* XXX Todo: implement assembly-optimized version of getorder. */
>>   #include <asm-generic/getorder.h>
>> -#endif /* ifdef __ASSEMBLY__ */
>> +#endif /* ifdef __ASSEMBLER__ */
>>   #endif /* ifdef __KERNEL__ */
>>   #endif
>> diff --git a/arch/hexagon/include/asm/processor.h b/arch/hexagon/include/ 
>> asm/processor.h
>> index 0cd39c2cdf8f7..b93c2cc4be22e 100644
>> --- a/arch/hexagon/include/asm/processor.h
>> +++ b/arch/hexagon/include/asm/processor.h
>> @@ -8,7 +8,7 @@
>>   #ifndef _ASM_PROCESSOR_H
>>   #define _ASM_PROCESSOR_H
>> -#ifndef __ASSEMBLY__
>> +#ifndef __ASSEMBLER__
>>   #include <asm/mem-layout.h>
>>   #include <asm/registers.h>
>> @@ -124,6 +124,6 @@ struct hexagon_switch_stack {
>>       unsigned long        lr;
>>   };
>> -#endif /* !__ASSEMBLY__ */
>> +#endif /* !__ASSEMBLER__ */
>>   #endif
>> diff --git a/arch/hexagon/include/asm/thread_info.h b/arch/hexagon/ 
>> include/asm/thread_info.h
>> index e90f280b9ce3e..a0da6c694c87b 100644
>> --- a/arch/hexagon/include/asm/thread_info.h
>> +++ b/arch/hexagon/include/asm/thread_info.h
>> @@ -10,7 +10,7 @@
>>   #ifdef __KERNEL__
>> -#ifndef __ASSEMBLY__
>> +#ifndef __ASSEMBLER__
>>   #include <asm/processor.h>
>>   #include <asm/registers.h>
>>   #include <asm/page.h>
>> @@ -20,7 +20,7 @@
>>   #define THREAD_SIZE        (1<<THREAD_SHIFT)
>>   #define THREAD_SIZE_ORDER    (THREAD_SHIFT - PAGE_SHIFT)
>> -#ifndef __ASSEMBLY__
>> +#ifndef __ASSEMBLER__
>>   /*
>>    * This is union'd with the "bottom" of the kernel stack.
>> @@ -47,13 +47,13 @@ struct thread_info {
>>       unsigned long        sp;
>>   };
>> -#else /* !__ASSEMBLY__ */
>> +#else /* !__ASSEMBLER__ */
>>   #include <asm/asm-offsets.h>
>> -#endif  /* __ASSEMBLY__  */
>> +#endif  /* __ASSEMBLER__  */
>> -#ifndef __ASSEMBLY__
>> +#ifndef __ASSEMBLER__
>>   #define INIT_THREAD_INFO(tsk)                   \
>>   {                                               \
>> @@ -73,7 +73,7 @@ struct thread_info {
>>   register struct thread_info *__current_thread_info 
>> asm(QUOTED_THREADINFO_REG);
>>   #define current_thread_info()  __current_thread_info
>> -#endif /* __ASSEMBLY__ */
>> +#endif /* __ASSEMBLER__ */
>>   /*
>>    * thread information flags
> 


