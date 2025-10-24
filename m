Return-Path: <linux-kernel+bounces-868458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17667C053CA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20E9F4FF2A4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3663093C4;
	Fri, 24 Oct 2025 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="F+SMQsXb"
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47D322FE0A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761296723; cv=none; b=Gf8QJO9fuOegrLk69w52sZbVrLH7zFGpiOCIXglu69/w1Gyce4PagMnptXeUhzomFkjN8DprcaaUI/F84bC+nqTS5EcNZCuPaS54XpHgxNchpxnD15i/ePJpXRB3GCvsawFM7maxJcwHDXSknUMwl4bCAelhRBcNxxP4cG6pKCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761296723; c=relaxed/simple;
	bh=79qbo/AHZRfjkFGDiwTOAN743MooeXf6nlk2k6RWppc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bRV8Whk9EHN2BVgnCsB1wOoqr9M/WHwUaj/S66BL31rUb4cZWE1fF8dzaqRiRkHBg9VBAmxp8/Ns0MkZPaOryOa/q2Deq3HidSxPAUw/t2cobvxrwpSSkYPvc6VmSJ0gVUIUX2qpt0rjled35xt7Q6vd7nBWWYsNc9qmCQZk+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=F+SMQsXb; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761296669;
	bh=VuuoycJDXJBFsUJPfc3SYgkVQWGjBc2RzXunYQLaWNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=F+SMQsXb+/McbqUeRj4hDqptHdfs9QawS6f5mk0z8Gglo9nDnT4UdfwY/NN0RtmMW
	 huKC+aCd0sWAS7bHtUIOYgQl6duxYXVsYnyzZfrnDRM/B+B4LDiSBhHHrTaVLkp3f0
	 eMSAjWfYiuIwgFPp3+qwRIbhfJnBpG3UQ3V2vbPw=
X-QQ-mid: zesmtpip2t1761296666tf299b41a
X-QQ-Originating-IP: He6okBxSsgolDxpxABn6m+HWvPlK5ajZXhX7DL4Uqog=
Received: from [IPV6:240e:668:120a::208:56d] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Oct 2025 17:04:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10975784350456047308
Message-ID: <4FED52AA3D608E61+96b50af7-cc24-40b0-a723-3b01f8428831@uniontech.com>
Date: Fri, 24 Oct 2025 17:04:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LoongArch: kexec_file: print out debugging message if
 required
To: Youling Tang <youling.tang@linux.dev>, Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251021091114.982820-1-maqianga@uniontech.com>
 <CAAhV-H5P9GGbSz0=J+a1hVkLVLwQWq1LfH7dxq4XHLqpgx7wDQ@mail.gmail.com>
 <8b3b0e36-510f-4c50-aa22-0aa5317c5a42@linux.dev>
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <8b3b0e36-510f-4c50-aa22-0aa5317c5a42@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MyhNtuNETreeelToE94A6SVDAnrZU/Lr3e/uU7xyzkZa24STNrubAkfN
	OCOKmbCLFs4qmOA/c0C7xaTvgUTlqBG1kyQXOLZuxD9N/UacvQGChlGah9QMiDGT/kJ9rE/
	aZ5EeQUdlJzKRaO49xdGskpf3833m0zlLGJjL6IsfxbKmb53rnHpuHJVnOJYRoOp2tKsB7G
	dD5zjZLCZBtW6l+g4+/wrCh0ke7uuYh4KAcG5RXdtGWH4U6Ovflep6A7SidlSgCl8FUEQlF
	WnSVkjk6Z6mPr3XZI1kTk9zUTC82NhnO8pJAm3DvwqcLja3hrU/NtnlzwhHJZP73yNSGkfk
	fwNcppwvidz8FOGVkjc6DKfx6Rn6/BeHAVWteTtYuz4Q2LliqpVDosMLhUht4XxlsHWy34F
	Mz9WrB2JlqbKF4wwnqR1cohgoDA1P8npzR8ZrAgMI9xFJY1C6TJUrH5IXxG0ITA/USAr169
	bsQ2+y1KdAks6/SWopEFXM1wtRV8hQCzJyqaU/SIpl40+oN2VSw9eDN5mJ4Gv6DjaI8Qj2F
	JCYTpIKaw8I/dGahDf2g0jbsZCPzWNniUu/VQK5yhdNrkK0/bRZwJIMyMgygevHFdsr18xK
	dUuBydj3nwNj48q8vBONNhYiSH1+QmZjtt/26sD08kJqkFk0H40MAHvwXE6mN0E5+rmN6EZ
	0PcKThqtaUZq5KvQx4936r/Y3pD+9/KVyoI69oEV/l8yATvTtYm6mu06uvfsvTl6I9suv62
	sCqrelJuS5tgUe6jAz4oIEsvf+MYmXEYGQk5+YwLtQiyjjK9myN0NUubk9cw2o7i+3QcBCk
	MJq9ehZztarq3TQyFHkL/HcJJYzLfGTfqmFfpXT11lmgIilqFuEZ/6HtlmMO+DlhTIkTMFE
	/bSZCLI4yJIT4KcFY7SXXzp2kH/og7Eof5lORjoye2yeebSrnKEJT9SdCITG/m+Krv80fqF
	We+I3ejbW4PyswmWQRIQOW84mW2Z/UT+SghkrF5jB9Wy9Gw9PdSOPqmgj
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0


在 2025/10/24 15:26, Youling Tang 写道:
> On 10/24/25 15:04, Huacai Chen wrote:
>
>> Hi, Youling,
>>
>> What do you think about this?
>>
>> Huacai
>>
>> On Tue, Oct 21, 2025 at 5:12 PM Qiang Ma <maqianga@uniontech.com> wrote:
>>> When specifying '-d' for kexec_file_load interface, loaded locations
>>> of kernel/initrd/cmdline etc can be printed out to help debug.
>
> Although kexec_image_info() could be considered for removal in the 
> case of kexec_file,
> in the context of kexec_load, when using the -d parameter of 
> kexec-tools, although the
> userspace program outputs extensive debugging information, it is 
> recommended to retain
> this information during the debugging phase to verify the accuracy of 
> data transmission
> after it is passed into the kernel.
>
In the system call kexec_file_load(), after machine_kexec_prepare() is 
executed,

there will be the same print information as the kexec_image_info(), and 
no modifications

were made to the printed information during this period. Therefore, it 
can also verify

the accuracy of the data, right?


Thanks,

Qiang.


> Thanks,
> Youling.
>>>
>>> Commit eb7622d908a0 ("kexec_file, riscv: print out debugging message
>>> if required") fixes the same issue on RISC-V.
>>>
>>> So, remove kexec_image_info() because the content has been printed
>>> out in generic code.
>>>
>>> And on Loongson-3A5000, the printed messages look like below:
>>>
>>> [  288.667939] kexec_file: kernel: 00000000d9aad283 kernel_size: 
>>> 0x2e77f30
>>> [  288.668414] kexec_file(EFI): No LoongArch PE image header.
>>> [  288.703104] kexec_file: Loaded initrd at 0x80000000 
>>> bufsz=0x1637cd0 memsz=0x1638000
>>> [  288.703674] kexec_file(ELF): Loaded kernel at 0x9c20000 
>>> bufsz=0x27f1800 memsz=0x2950000
>>> [  288.704092] kexec_file: nr_segments = 2
>>> [  288.704277] kexec_file: segment[0]: buf=0x00000000cc3e6c33 
>>> bufsz=0x27f1800 mem=0x9c20000 memsz=0x2950000
>>> [  288.741213] kexec_file: segment[1]: buf=0x00000000bb75a541 
>>> bufsz=0x1637cd0 mem=0x80000000 memsz=0x1638000
>>> [  288.757182] kexec_file: kexec_file_load: type:0, start:0xb15d000 
>>> head:0x18db60002 flags:0x8
>>>
>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>>> ---
>>>   arch/loongarch/kernel/machine_kexec.c | 22 ----------------------
>>>   1 file changed, 22 deletions(-)
>>>
>>> diff --git a/arch/loongarch/kernel/machine_kexec.c 
>>> b/arch/loongarch/kernel/machine_kexec.c
>>> index e4b2bbc47e62..2d64b7c81e5e 100644
>>> --- a/arch/loongarch/kernel/machine_kexec.c
>>> +++ b/arch/loongarch/kernel/machine_kexec.c
>>> @@ -39,34 +39,12 @@ static unsigned long systable_ptr;
>>>   static unsigned long start_addr;
>>>   static unsigned long first_ind_entry;
>>>
>>> -static void kexec_image_info(const struct kimage *kimage)
>>> -{
>>> -       unsigned long i;
>>> -
>>> -       pr_debug("kexec kimage info:\n");
>>> -       pr_debug("\ttype:        %d\n", kimage->type);
>>> -       pr_debug("\tstart:       %lx\n", kimage->start);
>>> -       pr_debug("\thead:        %lx\n", kimage->head);
>>> -       pr_debug("\tnr_segments: %lu\n", kimage->nr_segments);
>>> -
>>> -       for (i = 0; i < kimage->nr_segments; i++) {
>>> -               pr_debug("\t    segment[%lu]: %016lx - %016lx", i,
>>> -                       kimage->segment[i].mem,
>>> -                       kimage->segment[i].mem + 
>>> kimage->segment[i].memsz);
>>> -               pr_debug("\t\t0x%lx bytes, %lu pages\n",
>>> -                       (unsigned long)kimage->segment[i].memsz,
>>> -                       (unsigned long)kimage->segment[i].memsz /  
>>> PAGE_SIZE);
>>> -       }
>>> -}
>>> -
>>>   int machine_kexec_prepare(struct kimage *kimage)
>>>   {
>>>          int i;
>>>          char *bootloader = "kexec";
>>>          void *cmdline_ptr = (void *)KEXEC_CMDLINE_ADDR;
>>>
>>> -       kexec_image_info(kimage);
>>> -
>>>          kimage->arch.efi_boot = fw_arg0;
>>>          kimage->arch.systable_ptr = fw_arg2;
>>>
>>> -- 
>>> 2.20.1
>>>
>


