Return-Path: <linux-kernel+bounces-706401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEE0AEB60E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 13:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFC34A6711
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 11:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6378F29B78E;
	Fri, 27 Jun 2025 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ba7wgyry"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99381280CF6
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022885; cv=none; b=jMWgGPlS6Yp5yy2/tXFAXF1hZ59DxPWNpRFxOM8DvMLA/R2ymsYD9XC8tzIg1mkMvxYNYGNsUCzb60TosPJ2sU3mRTS2iUOi2trEh4qK0EodheZmOVFe2WM/JJf2eigDTskw6ygDcSSYnwa7jiYPVDaMmRe63WS9ZGXRhy0s2Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022885; c=relaxed/simple;
	bh=w4MVazwHyGvA4nmO+5orzSzKQM8Ol8qd0ZCA8/lQu0g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o/v4Elml1pXJFNqiIUSf9oQYS32GQFzXS/Vm1l0q0A2D2xcoQFfO1FoIFtjNRwwx84YVVV5q6w6UjAuj51/aAhrwGBLZxtyRWpq0YS7pnx62vb/yKP/wwd6XrQUzIuodadbrno4s9DTpcBW2qpVtmyjI1sXdsJvQIDI9wRjDa8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ba7wgyry; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45348bff79fso20659305e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 04:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751022882; x=1751627682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sT2Dty8HASo3E301EIpFBwg887/bkP44U7q2iAJe4Gc=;
        b=ba7wgyrys8Nen/h9u+bXusV2IJ1xLTJL68LtLHSSXbqafpS5TWeOl0RJWTP9A24Wg8
         nEWWYLqqlOAhrwpBJMMMbhCw7HOrApSN5jZ3/ZguxCMiUQFw8ttJzAFProFCgAXO8mh2
         1rLIluUFfSsjl0UkCyl49twlnmtnpD1BtoiG4PuGox4t/RSf9w4jQYVqYvXLm3oZBLm4
         4MIP0yFzqceAedEVriueRrqSXqUlhCjzdKTiis04aCWTd37omYuRlIeZ8XOVNlP5RESi
         IyfsXpGml3paUhLmSk/PAIZ1lCLpItw86EhzjBirg4hFe4V+S7uCYv8kTDrlyjuIhO8X
         rfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751022882; x=1751627682;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sT2Dty8HASo3E301EIpFBwg887/bkP44U7q2iAJe4Gc=;
        b=NJ3tWpmvy3NhrU+OAU38B+7JnLUqjqHqIRcxt3hZHTlCwNq3J4gP5A+ZtdKiS+meRf
         32W7DANtD9OUe0ZII3iYU7pziWqFXCe9Vm3nk1TlEj7Q5Y/iTsCx1KJGFIvHogs4q8S4
         Ja48p3pH+dA8xMubx1xo8AmaTwUCBJUyCrdwUZCwPUa+mgvbTkA7nsVI6d2RoDrZ/lo8
         Fs9dWm5lsD0AoIM1Ic8k/92hsTlXtiij1+AfjruVqgLiR8KMqxmF3IqDU+B04OEJddJ/
         7MtZDA5q7WHnmH9ZeFJRaVEeb5MthaI8qGIAe1W3PcwaS78b1Y2H/LRE4tGJy0KDMKSX
         ORbA==
X-Gm-Message-State: AOJu0YwyLGlfbbwNWqIUC+dH910J94gVu2Asxyv3YzPanyZIR4Te6xN0
	qH2TvmLmI3Kr3NQ/KHYxVRD3Uef1wNjla+iZ1goMfCgI6tJYIy7NZRrphESSNiCGuto=
X-Gm-Gg: ASbGncv4XjvcVtLBQBV22CVLi6jiZVEQ2iHPwWLIlgh+izBrhCss/AkQQo9SkZHLEtr
	HdFfFSK45GiojVDtvYPL3fcaqRGNjt4Xl9GTwCg5SEphr3AtaC8i5OZbLumlleG9X4z9HZfdo9p
	Hsyuzka1dSHVkRL9+8EDOaCyEAFsqDTZ6ZmTooET7CbQzB+1rc/LUVibKmM2RRoeLskkF88bLJr
	8+wmM6JnsQ+eB4jbxIfBptv7RvTDihN57BgSVadNKCPvbJmYVjsYMR4gMRBtkMNSo8f6knjOUuK
	4A+NLCmNZlPJptvWC5fxyWY1rytjQsMvEHNOn7vWTePKeflztYQ4HpVbkvwi8oBv3w==
X-Google-Smtp-Source: AGHT+IEwKKnJLjCucj3H+V14bUMgMBDIHsq7dD9B3IJhgOXR9ECVYmDuqEFe23uc3SMhFyT2EvpZ/g==
X-Received: by 2002:a05:600c:5249:b0:450:cfe1:a827 with SMTP id 5b1f17b1804b1-4538ee95284mr35636735e9.31.1751022881721;
        Fri, 27 Jun 2025 04:14:41 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.159.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e6f23sm2498309f8f.11.2025.06.27.04.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 04:14:41 -0700 (PDT)
Message-ID: <fda62d41-ad87-4e33-9662-11d397a26f7c@suse.com>
Date: Fri, 27 Jun 2025 14:14:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/22] x86/mce/amd: Put list_head in threshold_bank
From: Nikolay Borisov <nik.borisov@suse.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 linux-acpi@vger.kernel.org
References: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
 <20250624-wip-mca-updates-v4-8-236dd74f645f@amd.com>
 <68039ee2-5407-4bd4-9735-62674805eaad@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <68039ee2-5407-4bd4-9735-62674805eaad@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/25/25 19:52, Nikolay Borisov wrote:
> 
> 
> On 6/24/25 17:16, Yazen Ghannam wrote:
>> The threshold_bank structure is a container for one or more
>> threshold_block structures. Currently, the container has a single
>> pointer to the 'first' threshold_block structure which then has a linked
>> list of the remaining threshold_block structures.
>>
>> This results in an extra level of indirection where the 'first' block is
>> checked before iterating over the remaining blocks.
>>
>> Remove the indirection by including the head of the block list in the
>> threshold_bank structure which already acts as a container for all the
>> bank's thresholding blocks.
>>
>> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Tested-by: Tony Luck <tony.luck@intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> ---
>>
>> Notes:
>>      Link:
>>      https://lore.kernel.org/r/20250415-wip-mca-updates- 
>> v3-4-8ffd9eb4aa56@amd.com
>>      v3->v4:
>>      * No change.
>>      v2->v3:
>>      * Added tags from Qiuxu and Tony.
>>      v1->v2:
>>      * New in v2.
>>
>>   arch/x86/kernel/cpu/mce/amd.c | 43 +++++++++++ 
>> +-------------------------------
>>   1 file changed, 12 insertions(+), 31 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/ 
>> amd.c
>> index 0ffbee329a8c..5d351ec863cd 100644
>> --- a/arch/x86/kernel/cpu/mce/amd.c
>> +++ b/arch/x86/kernel/cpu/mce/amd.c
>> @@ -241,7 +241,8 @@ struct threshold_block {
>>   struct threshold_bank {
>>       struct kobject        *kobj;
>> -    struct threshold_block    *blocks;
>> +    /* List of threshold blocks within this MCA bank. */
>> +    struct list_head    miscj;
>>   };
>>   static DEFINE_PER_CPU(struct threshold_bank **, threshold_banks);
>> @@ -900,9 +901,9 @@ static void log_and_reset_block(struct 
>> threshold_block *block)
>>    */
>>   static void amd_threshold_interrupt(void)
>>   {
>> -    struct threshold_block *first_block = NULL, *block = NULL, *tmp = 
>> NULL;
>> -    struct threshold_bank **bp = this_cpu_read(threshold_banks);
>> +    struct threshold_bank **bp = this_cpu_read(threshold_banks), 
>> *thr_bank;
>>       unsigned int bank, cpu = smp_processor_id();
>> +    struct threshold_block *block, *tmp;
>>       /*
>>        * Validate that the threshold bank has been initialized 
>> already. The
>> @@ -916,16 +917,11 @@ static void amd_threshold_interrupt(void)
>>           if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
>>               continue;
> 
> <slight off topic>
> 
> nit: I wonder if instead of using per_cpu and manual bit testing can't a 
> direct
> call to x86_this_cpu_test_bit be a better solution. The assembly looks 
> like:
> 
> [OLD]
> 
> xorl    %r14d, %r14d    # ivtmp.245
> movq    %rax, 8(%rsp)   # cpu, %sfp
> # arch/x86/kernel/cpu/mce/amd.c:917:        if (!(per_cpu(bank_map, cpu) 
> & BIT_ULL(bank)))
> movq    $bank_map, %rax #, __ptr
> movq    %rax, (%rsp)    # __ptr, %sfp
> .L236:
> movq    8(%rsp), %rax   # %sfp, cpu
> # arch/x86/kernel/cpu/mce/amd.c:917:        if (!(per_cpu(bank_map, cpu) 
> & BIT_ULL(bank)))
> movq    (%rsp), %rsi    # %sfp, __ptr
> # arch/x86/kernel/cpu/mce/amd.c:917:        if (!(per_cpu(bank_map, cpu) 
> & BIT_ULL(bank)))
> movq    __per_cpu_offset(,%rax,8), %rax # __per_cpu_offset[cpu_23], 
> __per_cpu_offset[cpu_23]
> # arch/x86/kernel/cpu/mce/amd.c:917:        if (!(per_cpu(bank_map, cpu) 
> & BIT_ULL(bank)))
> movq    (%rax,%rsi), %rax
> # arch/x86/kernel/cpu/mce/amd.c:917:        if (!(per_cpu(bank_map, cpu) 
> & BIT_ULL(bank)))
> btq %r14, %rax
> 
> [NEW]
> 
> xorl    %r15d, %r15d    # ivtmp.246
> .L236:
> # 917 "arch/x86/kernel/cpu/mce/amd.c" 1
> btl %r15d, %gs:bank_map(%rip)   # ivtmp.246, *_9
> 
> 
> That way you end up with a single btl (but I guess a version that uses 
> btq should be added as well)
> inside the loop rather than a bunch of instructions moving data around 
> for per_cpu.
> 
> Alternatively, since this is running in interrupt context can't you use 
> directly this_cpu_read(bank_map) and eliminate the smp_processor_id 
> invocation?


Actually the total number of banks are at most 128 as per the layout of 
MCG_CAP register, so using btl is fine. Also I'm not sure why the 
original code uses BIT_ULL vs just BIT since we can't have a 64bit value.


> 
> </slight off topic>
> 
> 
> <snip>
> 


