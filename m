Return-Path: <linux-kernel+bounces-868878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2187C0663F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90371A60928
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0BC31B136;
	Fri, 24 Oct 2025 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="JxNN2XOI"
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F702AE8E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761310982; cv=none; b=f9FdVRrq05/PSj3zadgjHlClNyieYW/+AwyGEMZzdu4oaPceYkXpACRNh5uHJ7fpGlIFq+Qez4LZh/qHGM/kf6jexr11YogTbwKJB5iNxckmwKI/Y0KLglwv2xtyIccoHrXQ9uRh+T3tWW+B7r6oqXeM/6fkt5l/89hREg0SXx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761310982; c=relaxed/simple;
	bh=q1l3goU0Cvv1hNOMHu4sN1jflaBDaONjn/PGsiOB7M4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLP+JOjoZHt/xZlnkUk1m2rGFwIBBJlG0vq8STRMFBG2Vwb78uM4tljVkXTvFCfq06B5PEqXmVjqykbDCX+/0JCEewDYjgC+g1KQrKodvLplwPOr6RuJV4JSxFgYkQm7cbK4Bso2M2/CIOEXF95HUpM1CX7yY0w92T4GRmOJKZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=JxNN2XOI; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761310908;
	bh=WL1mT3sh6drxv+rfWtrvPWQtFlVBjv200b1b77rBnas=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=JxNN2XOIjrdDZTN05mbaVgGIsuiUSQcXPx4Fm9O0giAPhTc9ThXdpRTNByaGWpEN0
	 UihhEEye3GYGv1qQhpp4ixHMbB40Vi3Fmf4L0kSQvBu/7IQQAwm0V0T1/Vss8lo3wv
	 6/0EAJ7xRDpGyaeQWFsNCLUwi9dSVQbJQoHwk6XQ=
X-QQ-mid: zesmtpgz8t1761310906td16f8ab6
X-QQ-Originating-IP: ZX0ygo/Z4S3PAWWxEKyX90q5+zM1sxL6z0ZUAVhZ19M=
Received: from [172.16.6.119] ( [58.19.38.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Oct 2025 21:01:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13637814479689066807
Message-ID: <4BEEB4B9B4B77DC9+01857891-fef2-4160-8981-939adb46368a@uniontech.com>
Date: Fri, 24 Oct 2025 21:01:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LoongArch: kexec_file: print out debugging message if
 required
To: Youling Tang <youling.tang@linux.dev>
Cc: Huacai Chen <chenhuacai@kernel.org>, kernel@xen0n.name,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251021091114.982820-1-maqianga@uniontech.com>
 <CAAhV-H5P9GGbSz0=J+a1hVkLVLwQWq1LfH7dxq4XHLqpgx7wDQ@mail.gmail.com>
 <8b3b0e36-510f-4c50-aa22-0aa5317c5a42@linux.dev>
 <4FED52AA3D608E61+96b50af7-cc24-40b0-a723-3b01f8428831@uniontech.com>
 <1b865cb8-5262-432f-a090-c0bd9064dae2@linux.dev>
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <1b865cb8-5262-432f-a090-c0bd9064dae2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MdzdX6p4PZzkkXlXHMXX0j4hAx82zqWO2uooqqRQib8VlXujkt8t6RRI
	b3Hn7tEFtGhq983F8tR7nMaGBdbR0reKXE2EEHWPZqE33C2mCvmBADV+1Bf/TBrk4e1I1KW
	itQC5hygNqg/u1MaIPVtNJ46Qm3x+4PRIsp5WkCffR2ZA626yeyaBpAFd78entIxkAsnTy8
	qMyoFwAo2GmmyzC12eISrAFGghzmze6tGpKTOuzWxYbm9kA+XB1dcnr83khHcswqaomBQ0N
	TKZP4Z1VCcC3ibiipMg/PXS3x33YDl+OdsmbkfwB0wkXBRCwSqv3yoHW6U+G8KA9GVa1Pea
	r057fbVovq3/gOkgZRMZ+wDP4a1RtRdhuPcqvSrTF0xuD1fqfwYccQ5ZLrQGnErm30GRqnN
	OWYhPgR7/V7vwDsx08sCz/f+ON3UdWQ2ZNhbQBYQkO12OWAbVGZUP4wxh1Z50sCwEsgvPW7
	nz+RNrVZvqtdxoziRu6IoR1R3sRZq3GWHw9MzYH6nD3qlY7ZQiOyi4YnU+ZEHaJ+Q/CvnEL
	0mWStbP+OJxMsiJMSiMSXwcg6uvfuzIU/S6fd6EXkist1i4PaFv1HZSSeDQ/i6W/2SkISXX
	+zbnqybfydsyCL0vclhK5EbVPLZbkXn4r5boGQ1FxtorLgPx5Mc8Yt+GAbAqzr7ZzB9TosN
	NqzTc/8O/KiWM1HRSuv91H5rqlrS8/Kv05LoA4QWnkWZJ6XZfm94pfOqPD2+iEBrPLdE5A+
	r7cVOeOk4ROK/z4JVA9phxDxGtB4YMsev0UDBLSz70TDvmdkm4Dg+NkXskf3+SX+vEeFJwl
	SXTIxy0rN2+nUrgTmtsr+v15mU4l8EzZMReRGI/lqT+FBKSoN4z3cDzu/68cynGegUwxJdR
	nmcFFCa/dXEWa7Qcubdkbeab5x0FtfduZbp3yNA7Yo30O5DSy1rpW4Ms//YxyQg+GUMHQL8
	rNYNC6aXz00gdLizG+itgNMRu4Jw6fG3EeEU33ZWEg6LcMeDmovPPghhqUJdM6HiDVf+jSW
	YZOpK5jN5Opw3P127IakUSI1G2fnJBize54zb5iCZUgTEbkgohdlfs/8kfMp0hzB55BSNEf
	mT8HZgsWZpR/2Y9SjQmNHk=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0


在 2025/10/24 17:27, Youling Tang 写道:
>
> On 10/24/25 17:04, Qiang Ma wrote:
>>
>> 在 2025/10/24 15:26, Youling Tang 写道:
>>> On 10/24/25 15:04, Huacai Chen wrote:
>>>
>>>> Hi, Youling,
>>>>
>>>> What do you think about this?
>>>>
>>>> Huacai
>>>>
>>>> On Tue, Oct 21, 2025 at 5:12 PM Qiang Ma <maqianga@uniontech.com> 
>>>> wrote:
>>>>> When specifying '-d' for kexec_file_load interface, loaded locations
>>>>> of kernel/initrd/cmdline etc can be printed out to help debug.
>>>
>>> Although kexec_image_info() could be considered for removal in the 
>>> case of kexec_file,
>>> in the context of kexec_load, when using the -d parameter of 
>>> kexec-tools, although the
>>> userspace program outputs extensive debugging information, it is 
>>> recommended to retain
>>> this information during the debugging phase to verify the accuracy 
>>> of data transmission
>>> after it is passed into the kernel.
>>>
>> In the system call kexec_file_load(), after machine_kexec_prepare() 
>> is executed,
>>
>> there will be the same print information as the kexec_image_info(), 
>> and no modifications
>>
>> were made to the printed information during this period. Therefore, 
>> it can also verify
>>
>> the accuracy of the data, right?
>
>
> If only for kexec_file_load, we can directly remove kexec_image_info().
> But for kexec_load, I suggest keeping it.

I see.

But I think it's not necessary to add this print information to both

kexec_load and kexec_file_load. Just keep one.


Qiang.


>
> Youling.
>>
>>
>> Thanks,
>>
>> Qiang.
>>
>>
>>> Thanks,
>>> Youling.
>>>>>
>>>>> Commit eb7622d908a0 ("kexec_file, riscv: print out debugging message
>>>>> if required") fixes the same issue on RISC-V.
>>>>>
>>>>> So, remove kexec_image_info() because the content has been printed
>>>>> out in generic code.
>>>>>
>>>>> And on Loongson-3A5000, the printed messages look like below:
>>>>>
>>>>> [  288.667939] kexec_file: kernel: 00000000d9aad283 kernel_size: 
>>>>> 0x2e77f30
>>>>> [  288.668414] kexec_file(EFI): No LoongArch PE image header.
>>>>> [  288.703104] kexec_file: Loaded initrd at 0x80000000 
>>>>> bufsz=0x1637cd0 memsz=0x1638000
>>>>> [  288.703674] kexec_file(ELF): Loaded kernel at 0x9c20000 
>>>>> bufsz=0x27f1800 memsz=0x2950000
>>>>> [  288.704092] kexec_file: nr_segments = 2
>>>>> [  288.704277] kexec_file: segment[0]: buf=0x00000000cc3e6c33 
>>>>> bufsz=0x27f1800 mem=0x9c20000 memsz=0x2950000
>>>>> [  288.741213] kexec_file: segment[1]: buf=0x00000000bb75a541 
>>>>> bufsz=0x1637cd0 mem=0x80000000 memsz=0x1638000
>>>>> [  288.757182] kexec_file: kexec_file_load: type:0, 
>>>>> start:0xb15d000 head:0x18db60002 flags:0x8
>>>>>
>>>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>>>>> ---
>>>>>   arch/loongarch/kernel/machine_kexec.c | 22 ----------------------
>>>>>   1 file changed, 22 deletions(-)
>>>>>
>>>>> diff --git a/arch/loongarch/kernel/machine_kexec.c 
>>>>> b/arch/loongarch/kernel/machine_kexec.c
>>>>> index e4b2bbc47e62..2d64b7c81e5e 100644
>>>>> --- a/arch/loongarch/kernel/machine_kexec.c
>>>>> +++ b/arch/loongarch/kernel/machine_kexec.c
>>>>> @@ -39,34 +39,12 @@ static unsigned long systable_ptr;
>>>>>   static unsigned long start_addr;
>>>>>   static unsigned long first_ind_entry;
>>>>>
>>>>> -static void kexec_image_info(const struct kimage *kimage)
>>>>> -{
>>>>> -       unsigned long i;
>>>>> -
>>>>> -       pr_debug("kexec kimage info:\n");
>>>>> -       pr_debug("\ttype:        %d\n", kimage->type);
>>>>> -       pr_debug("\tstart:       %lx\n", kimage->start);
>>>>> -       pr_debug("\thead:        %lx\n", kimage->head);
>>>>> -       pr_debug("\tnr_segments: %lu\n", kimage->nr_segments);
>>>>> -
>>>>> -       for (i = 0; i < kimage->nr_segments; i++) {
>>>>> -               pr_debug("\t    segment[%lu]: %016lx - %016lx", i,
>>>>> -                       kimage->segment[i].mem,
>>>>> -                       kimage->segment[i].mem + 
>>>>> kimage->segment[i].memsz);
>>>>> -               pr_debug("\t\t0x%lx bytes, %lu pages\n",
>>>>> -                       (unsigned long)kimage->segment[i].memsz,
>>>>> -                       (unsigned long)kimage->segment[i].memsz /  
>>>>> PAGE_SIZE);
>>>>> -       }
>>>>> -}
>>>>> -
>>>>>   int machine_kexec_prepare(struct kimage *kimage)
>>>>>   {
>>>>>          int i;
>>>>>          char *bootloader = "kexec";
>>>>>          void *cmdline_ptr = (void *)KEXEC_CMDLINE_ADDR;
>>>>>
>>>>> -       kexec_image_info(kimage);
>>>>> -
>>>>>          kimage->arch.efi_boot = fw_arg0;
>>>>>          kimage->arch.systable_ptr = fw_arg2;
>>>>>
>>>>> -- 
>>>>> 2.20.1
>>>>>
>>>
>>
>


