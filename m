Return-Path: <linux-kernel+bounces-885795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFAEC33EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 05:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CA1189F512
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 04:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E60224AEB;
	Wed,  5 Nov 2025 04:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Mu6k5nbZ"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BF2153598
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 04:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762317233; cv=none; b=C0soyrygzEC1XA+30ZmTqz7e6Vr9AX8OfyFaJvJSe5HrNzs7A6YcDN/HOd7tonPcg36xAQ/SFVpL/i+6KuAj7LJWJiZT4z4+t1vSAa9/9X6mfWmc7qj50rFSfEonmKauanvWDUxn6cwKnd/pIq/KpZC5WL1lg4XFd6nbC35xlBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762317233; c=relaxed/simple;
	bh=/xApc7JPeLpV0U6AkHyleu4h5wlN0YAP2dh/lOrUkPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXMeK23DvsInsJjPij3nQIuPSvFlJ7h0evp9YB5Bt3T8fX4daYYKGjU5fUMYa+HKKGmfmpHbarOBfYxAczmBwGGvW0Lh68g31AvDRCSXrxBpk1KxcC9vpGoEJbCV/asd5lyt7FC9fsTuN6vj6BlNLILs2z9Li6XwKFFjeiFMqPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Mu6k5nbZ; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762317166;
	bh=IzRkElXePV0e5YJI1LL9d23HgU39352OJQ6VVeYJKEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Mu6k5nbZZxZE9H8O4BVi2LQU7nXCv59m91kkg5hDyjcnRJpr0dkKdO/c2otPPklIo
	 KFZlI8WNzsetfoNHYizIk0izCmas1TIJ01si5swn+ov1Bizc+g80Vrf1eWmwEpeu0t
	 orUgqi3+83P7fmijvdv9hi/8e6wxfkI/jgdzOWeM=
X-QQ-mid: zesmtpgz7t1762317163t58b5e436
X-QQ-Originating-IP: IVuLNbt0LM4XVn04dFFo5bmVH3eL0NEBQpBWLy9Dm8g=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 12:32:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5240506837288176278
Message-ID: <CCA9495F3D18EFF3+40304116-c894-4b4b-9f9f-e0398bc4deac@uniontech.com>
Date: Wed, 5 Nov 2025 12:32:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] kexec: add kexec_core flag to control debug
 printing
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251103063440.1681657-1-maqianga@uniontech.com>
 <20251103063440.1681657-3-maqianga@uniontech.com>
 <aQq/2WN8Sqz6m6xc@MiWiFi-R3L-srv>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <aQq/2WN8Sqz6m6xc@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MkB8ALqi1u9wA9WpJpvI3pzCPR7FOINZ512Mm3x6iHJCTKcTr/9iwLs8
	gmE57fi2nUw4btu5CCxYBCLQDc+lRkK589ZbN2Dz6pStnlgIjwer2G7mTw3lFslAVdRWBm5
	6Zof93o2edMvfQo2i3AeCNl5T9pxAnB2fbeq7JMP1jpy7eUiqXWq6GOr4hiSl1uaHhDQ/m1
	mlLUfd167vREg2lkDDZOEwTAoVNuJAfwaSAJEvaLMsQeFT3/z3dDfluIitsjSMbn0dBIbJA
	fOEE/ZJSleNQJn0sAjnNmLvlBZZeKlEq1uS4XlsfVKM24VxxQRp83ZbYXIvhGQjkbqz9wii
	QfsLZ4Skz97mXCDTc/SdCsxDJTCUIFhgnSX8ED5YXCAVx98i6dc1KH0xm7vYNTA9NGVtNQh
	8mOm2jEAVmB5oppvitrCpfSZo31kBOHA65O1RiNa3q/CP0CnQ1w2XHxzb7w9Yo5Y8GPweEO
	B4VSU4fffO8iW/ccONcSmwoUn8AS72kcU76HzugTZEVkJLH1Hh73pCuAx65LJruBVQUwE/T
	lq5U9SFHQZP+n8m5vB8ZlIFcop4birFVA3M5++UKfVsJTQWH2pwwU8wkqazOeXYapr5TaHn
	KCTlB7VjcqdLlGAzLA1wWr+ewlbN8bLydyq9DaqAOF1oannCfjs/Sr8HHDXTQGuw9fWRZsN
	NAtG5Wr5yBbVNXFtAcNVhe/ovKVA4BDuJ/ikqYni7ypmMD2/NW+ndpDXRHuPZTvCpOX7qJP
	0oP+TK/SodxuiyjiUm9gIFx2nwxb6g03vNcE6Akd9JBQWV+ltvxA7aM9iR+7k7LQrVdTfkN
	8cctXOWlazdDTCkhqqAmlbGezP2xW7V+QlskD5643t9+TuwtqlJ07394ZEvzTVbhpMUzvA0
	6i84R861xkofoytGOjQkuB+wF5FrqhT5JqKjyaDhd+h3eHSVk87ev84FoRZey6gjLXbr0iR
	j8vVvmR8V0SdKkUOjL38JpMRgaRVf1fFHS9+YAMhZ50zWXibNlM50ltY0fl9waPIAC2nXew
	ApBYlYMC0wIQ+xCUl3
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0


在 2025/11/5 11:09, Baoquan He 写道:
> On 11/03/25 at 02:34pm, Qiang Ma wrote:
>> The commit a85ee18c7900 ("kexec_file: print out debugging message
>> if required") has added general code printing in kexec_file_load(),
>> but not in kexec_load().
>>
>> Since kexec_load and kexec_file_load are not triggered
>> simultaneously, we can unify the debug flag of kexec and kexec_file
>> as kexec_core_dbg_print.
> After reconsidering this, I regret calling it kexec_core_dbg_print.
> That sounds a printing only happening in kexec_core. Maybe
> kexec_dbg_print is better. Because here kexec refers to a generic
> concept, but not limited to kexec_load interface only. Just my personal
> thinking.
This sounds reasonable. The next version will be renamed kexec_dbg_print.
>
> Other than the naming, the whole patch looks good to me. Thanks.
>
>> Next, we need to do four things:
>>
>> 1. rename kexec_file_dbg_print to kexec_core_dbg_print
>> 2. Add KEXEC_DEBUG
>> 3. Initialize kexec_core_dbg_print for kexec
>> 4. Set the reset of kexec_file_dbg_print to kimage_free
>>
>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>> ---
>>   include/linux/kexec.h      | 9 +++++----
>>   include/uapi/linux/kexec.h | 1 +
>>   kernel/kexec.c             | 1 +
>>   kernel/kexec_core.c        | 4 +++-
>>   kernel/kexec_file.c        | 4 +---
>>   5 files changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index ff7e231b0485..cad8b5c362af 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -455,10 +455,11 @@ bool kexec_load_permitted(int kexec_image_type);
>>   
>>   /* List of defined/legal kexec flags */
>>   #ifndef CONFIG_KEXEC_JUMP
>> -#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR | KEXEC_CRASH_HOTPLUG_SUPPORT)
>> +#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR | KEXEC_CRASH_HOTPLUG_SUPPORT | \
>> +			KEXEC_DEBUG)
>>   #else
>>   #define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR | \
>> -			KEXEC_CRASH_HOTPLUG_SUPPORT)
>> +			KEXEC_CRASH_HOTPLUG_SUPPORT | KEXEC_DEBUG)
>>   #endif
>>   
>>   /* List of defined/legal kexec file flags */
>> @@ -525,10 +526,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
>>   static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
>>   #endif
>>   
>> -extern bool kexec_file_dbg_print;
>> +extern bool kexec_core_dbg_print;
>>   
>>   #define kexec_dprintk(fmt, arg...) \
>> -        do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
>> +	do { if (kexec_core_dbg_print) pr_info(fmt, ##arg); } while (0)
>>   
>>   extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
>>   extern void kimage_unmap_segment(void *buffer);
>> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
>> index 55749cb0b81d..819c600af125 100644
>> --- a/include/uapi/linux/kexec.h
>> +++ b/include/uapi/linux/kexec.h
>> @@ -14,6 +14,7 @@
>>   #define KEXEC_PRESERVE_CONTEXT	0x00000002
>>   #define KEXEC_UPDATE_ELFCOREHDR	0x00000004
>>   #define KEXEC_CRASH_HOTPLUG_SUPPORT 0x00000008
>> +#define KEXEC_DEBUG		0x00000010
>>   #define KEXEC_ARCH_MASK		0xffff0000
>>   
>>   /*
>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>> index 9bb1f2b6b268..c7a869d32f87 100644
>> --- a/kernel/kexec.c
>> +++ b/kernel/kexec.c
>> @@ -42,6 +42,7 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
>>   	if (!image)
>>   		return -ENOMEM;
>>   
>> +	kexec_core_dbg_print = !!(flags & KEXEC_DEBUG);
>>   	image->start = entry;
>>   	image->nr_segments = nr_segments;
>>   	memcpy(image->segment, segments, nr_segments * sizeof(*segments));
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index fa00b239c5d9..865f2b14f23b 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -53,7 +53,7 @@ atomic_t __kexec_lock = ATOMIC_INIT(0);
>>   /* Flag to indicate we are going to kexec a new kernel */
>>   bool kexec_in_progress = false;
>>   
>> -bool kexec_file_dbg_print;
>> +bool kexec_core_dbg_print;
>>   
>>   /*
>>    * When kexec transitions to the new kernel there is a one-to-one
>> @@ -576,6 +576,8 @@ void kimage_free(struct kimage *image)
>>   	kimage_entry_t *ptr, entry;
>>   	kimage_entry_t ind = 0;
>>   
>> +	kexec_core_dbg_print = false;
>> +
>>   	if (!image)
>>   		return;
>>   
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index eb62a9794242..4a24aadbad02 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -138,8 +138,6 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>>   	 */
>>   	kfree(image->image_loader_data);
>>   	image->image_loader_data = NULL;
>> -
>> -	kexec_file_dbg_print = false;
>>   }
>>   
>>   #ifdef CONFIG_KEXEC_SIG
>> @@ -314,7 +312,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
>>   	if (!image)
>>   		return -ENOMEM;
>>   
>> -	kexec_file_dbg_print = !!(flags & KEXEC_FILE_DEBUG);
>> +	kexec_core_dbg_print = !!(flags & KEXEC_FILE_DEBUG);
>>   	image->file_mode = 1;
>>   
>>   #ifdef CONFIG_CRASH_DUMP
>> -- 
>> 2.20.1
>>
>


