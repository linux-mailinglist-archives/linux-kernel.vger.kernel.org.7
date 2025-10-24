Return-Path: <linux-kernel+bounces-868500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5E3C055E1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CA63BF8E7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911B330AAD7;
	Fri, 24 Oct 2025 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XAqg/BYy"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045EB309DDB
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298129; cv=none; b=aSWa7MGuh/57Hrc2WSDekKCgX/Can1zvTMeRy5CUexabXusWq0gFd4KTj8MgMEiQh0NeXXAD5FPwINhS6ns3kNc5RjyBwVAFwhP8jejfWuo7gT0H2ByW3dVFcD4o3uRVmYbNVzvNU5y5Af80Pw+1didAlzvZx4FZPXAr5S1rpss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298129; c=relaxed/simple;
	bh=m4BLhHZXdjh2iwjG/zJOsm1CBApBNV7A3ou7yjSqAzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgTHHNz1tGNIbh6Q3o7+CtoYX0Lv/UPellhAgKstCjNUsaxnZlgiuSYeiRUYnfMPNNrA0Obmd470cu5brB+gAMzt+nRVOnGV7X1jbjfwH9luVZpeTQbaOSzge9NLhVWExlasLSnHfC5ooPtwq7akSRZXo/F5lJYsGH/X7bAGihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XAqg/BYy; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1b865cb8-5262-432f-a090-c0bd9064dae2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761298116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QBktKnlrIBdyESz/dntO65W2y940pekQFw5gMFfNVZs=;
	b=XAqg/BYy4QWHa/nRUoS46nposda8lMJgPTaBNCAX+Dz6CITwQpBmmlppMWLKWmAhmN54Lk
	xL1hD2KQ/UGVKp3PBYU6fgYaR5+ROP//RBq1B+D9BHz4OGcsZie8HUHgEv1YHvFUxxd48E
	NBJphFKQLbBmrVh2yqR1YCxHD4oVlOg=
Date: Fri, 24 Oct 2025 17:27:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] LoongArch: kexec_file: print out debugging message if
 required
To: Qiang Ma <maqianga@uniontech.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, kernel@xen0n.name,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251021091114.982820-1-maqianga@uniontech.com>
 <CAAhV-H5P9GGbSz0=J+a1hVkLVLwQWq1LfH7dxq4XHLqpgx7wDQ@mail.gmail.com>
 <8b3b0e36-510f-4c50-aa22-0aa5317c5a42@linux.dev>
 <4FED52AA3D608E61+96b50af7-cc24-40b0-a723-3b01f8428831@uniontech.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <4FED52AA3D608E61+96b50af7-cc24-40b0-a723-3b01f8428831@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/24/25 17:04, Qiang Ma wrote:
>
> 在 2025/10/24 15:26, Youling Tang 写道:
>> On 10/24/25 15:04, Huacai Chen wrote:
>>
>>> Hi, Youling,
>>>
>>> What do you think about this?
>>>
>>> Huacai
>>>
>>> On Tue, Oct 21, 2025 at 5:12 PM Qiang Ma <maqianga@uniontech.com> 
>>> wrote:
>>>> When specifying '-d' for kexec_file_load interface, loaded locations
>>>> of kernel/initrd/cmdline etc can be printed out to help debug.
>>
>> Although kexec_image_info() could be considered for removal in the 
>> case of kexec_file,
>> in the context of kexec_load, when using the -d parameter of 
>> kexec-tools, although the
>> userspace program outputs extensive debugging information, it is 
>> recommended to retain
>> this information during the debugging phase to verify the accuracy of 
>> data transmission
>> after it is passed into the kernel.
>>
> In the system call kexec_file_load(), after machine_kexec_prepare() is 
> executed,
>
> there will be the same print information as the kexec_image_info(), 
> and no modifications
>
> were made to the printed information during this period. Therefore, it 
> can also verify
>
> the accuracy of the data, right?


If only for kexec_file_load, we can directly remove kexec_image_info().
But for kexec_load, I suggest keeping it.

Youling.
>
>
> Thanks,
>
> Qiang.
>
>
>> Thanks,
>> Youling.
>>>>
>>>> Commit eb7622d908a0 ("kexec_file, riscv: print out debugging message
>>>> if required") fixes the same issue on RISC-V.
>>>>
>>>> So, remove kexec_image_info() because the content has been printed
>>>> out in generic code.
>>>>
>>>> And on Loongson-3A5000, the printed messages look like below:
>>>>
>>>> [  288.667939] kexec_file: kernel: 00000000d9aad283 kernel_size: 
>>>> 0x2e77f30
>>>> [  288.668414] kexec_file(EFI): No LoongArch PE image header.
>>>> [  288.703104] kexec_file: Loaded initrd at 0x80000000 
>>>> bufsz=0x1637cd0 memsz=0x1638000
>>>> [  288.703674] kexec_file(ELF): Loaded kernel at 0x9c20000 
>>>> bufsz=0x27f1800 memsz=0x2950000
>>>> [  288.704092] kexec_file: nr_segments = 2
>>>> [  288.704277] kexec_file: segment[0]: buf=0x00000000cc3e6c33 
>>>> bufsz=0x27f1800 mem=0x9c20000 memsz=0x2950000
>>>> [  288.741213] kexec_file: segment[1]: buf=0x00000000bb75a541 
>>>> bufsz=0x1637cd0 mem=0x80000000 memsz=0x1638000
>>>> [  288.757182] kexec_file: kexec_file_load: type:0, start:0xb15d000 
>>>> head:0x18db60002 flags:0x8
>>>>
>>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>>>> ---
>>>>   arch/loongarch/kernel/machine_kexec.c | 22 ----------------------
>>>>   1 file changed, 22 deletions(-)
>>>>
>>>> diff --git a/arch/loongarch/kernel/machine_kexec.c 
>>>> b/arch/loongarch/kernel/machine_kexec.c
>>>> index e4b2bbc47e62..2d64b7c81e5e 100644
>>>> --- a/arch/loongarch/kernel/machine_kexec.c
>>>> +++ b/arch/loongarch/kernel/machine_kexec.c
>>>> @@ -39,34 +39,12 @@ static unsigned long systable_ptr;
>>>>   static unsigned long start_addr;
>>>>   static unsigned long first_ind_entry;
>>>>
>>>> -static void kexec_image_info(const struct kimage *kimage)
>>>> -{
>>>> -       unsigned long i;
>>>> -
>>>> -       pr_debug("kexec kimage info:\n");
>>>> -       pr_debug("\ttype:        %d\n", kimage->type);
>>>> -       pr_debug("\tstart:       %lx\n", kimage->start);
>>>> -       pr_debug("\thead:        %lx\n", kimage->head);
>>>> -       pr_debug("\tnr_segments: %lu\n", kimage->nr_segments);
>>>> -
>>>> -       for (i = 0; i < kimage->nr_segments; i++) {
>>>> -               pr_debug("\t    segment[%lu]: %016lx - %016lx", i,
>>>> -                       kimage->segment[i].mem,
>>>> -                       kimage->segment[i].mem + 
>>>> kimage->segment[i].memsz);
>>>> -               pr_debug("\t\t0x%lx bytes, %lu pages\n",
>>>> -                       (unsigned long)kimage->segment[i].memsz,
>>>> -                       (unsigned long)kimage->segment[i].memsz /  
>>>> PAGE_SIZE);
>>>> -       }
>>>> -}
>>>> -
>>>>   int machine_kexec_prepare(struct kimage *kimage)
>>>>   {
>>>>          int i;
>>>>          char *bootloader = "kexec";
>>>>          void *cmdline_ptr = (void *)KEXEC_CMDLINE_ADDR;
>>>>
>>>> -       kexec_image_info(kimage);
>>>> -
>>>>          kimage->arch.efi_boot = fw_arg0;
>>>>          kimage->arch.systable_ptr = fw_arg2;
>>>>
>>>> -- 
>>>> 2.20.1
>>>>
>>
>

