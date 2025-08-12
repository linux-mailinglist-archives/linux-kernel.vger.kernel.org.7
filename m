Return-Path: <linux-kernel+bounces-764167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C14B21EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420F63B66F8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2850A2D6E7C;
	Tue, 12 Aug 2025 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jN9CFcAY"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0D02D6E68
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754982440; cv=none; b=OE/y0nygGSG9xfPJmAjaxoQGMM+O8FMZoQOaVLWs3n1hma/fLUM2WA2twcWfyYIwJYfUhPy06yiSGD4IRvi8Vih2aTBWCOMEO2fe4prGohC4+WdX3+YMbLaurxhVYBR9B7ReUQGa3IpPkkDR6ScQE5tEegnsuQ+jDCUkYOyDSKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754982440; c=relaxed/simple;
	bh=nrakdrhkRwGpFtnCCE4VckhtR8ZGhpb9C6LAT4HaATw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=T0AGWNN2fJL0qRegsz5eO2xPePVEb0d57FuF2HE25JYAnQeI2v+P1Noppmmo9OGFq2Z2MlX4+IOgh96ii8UpyctV33gsvZz+AqpH1apz+tOQsVeWad7/BaIlseyNLO5ubV+9+78F8Khy7vqBTIGXd+JfiqwuCvCZeXE+GLHRRd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jN9CFcAY; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <af866071-81c1-44d5-ae02-273d6e9c04d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754982435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RwJM3f9nRMF2TtZAXO7jrMi5qc6ON6d3RJbMvmWguSQ=;
	b=jN9CFcAYTTpE/i7mPS/lR0KNpsyTKwcet7Tgk6gsPw93zu4G3ARQnWzUHW316vCSbhOeNu
	xnMs/xASdsRAk+YpZ+Fyi0RQ98Dws2s7CWUMRJBe1/ownNj0+7X07bs4RdSIgTusRAaLLs
	AnD7ZIMKmBjO7MnTAoI2d8tb9isd6FU=
Date: Tue, 12 Aug 2025 15:06:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/6] LoongArch: Add kexec_file support
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Yao Zi <ziyao@disroot.org>, Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-3-youling.tang@linux.dev> <aJojDiHWi8cgvA2W@pie>
 <6de97571-7ef0-4bbd-b55f-5ad41898a6ec@linux.dev>
Content-Language: en-US
In-Reply-To: <6de97571-7ef0-4bbd-b55f-5ad41898a6ec@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2025/8/12 14:15, Youling Tang wrote:
> Hi, Yao
> On 2025/8/12 01:06, Yao Zi wrote:
>> On Mon, Aug 11, 2025 at 05:26:55PM +0800, Youling Tang wrote:
>>> From: Youling Tang <tangyouling@kylinos.cn>
>>>
>>> This patch adds support for kexec_file on LoongArch.
>>>
>>> The image_load() as two parts:
>>> - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
>>> - the second part loads other segments (eg: initrd, cmdline)
>>>
>>> Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are 
>>> supported,
>>> but ELF format is not supported.
>>>
>>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
>>> ---
>>>   arch/loongarch/Kconfig                     |   8 ++
>>>   arch/loongarch/include/asm/image.h         |  18 ++++
>>>   arch/loongarch/include/asm/kexec.h         |  12 +++
>>>   arch/loongarch/kernel/Makefile             |   1 +
>>>   arch/loongarch/kernel/kexec_image.c        | 112 
>>> +++++++++++++++++++++
>>>   arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
>>>   arch/loongarch/kernel/machine_kexec_file.c |  46 +++++++++
>>>   7 files changed, 219 insertions(+), 11 deletions(-)
>>>   create mode 100644 arch/loongarch/kernel/kexec_image.c
>>>   create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
>> ...
>>
>>> diff --git a/arch/loongarch/include/asm/image.h 
>>> b/arch/loongarch/include/asm/image.h
>>> index 1f090736e71d..829e1ecb1f5d 100644
>>> --- a/arch/loongarch/include/asm/image.h
>>> +++ b/arch/loongarch/include/asm/image.h
>>> @@ -36,5 +36,23 @@ struct loongarch_image_header {
>>>       uint32_t pe_header;
>>>   };
>>>   +static const uint8_t loongarch_image_pe_sig[2] = {'M', 'Z'};
>>> +static const uint8_t loongarch_pe_machtype[6] = {'P', 'E', 0x0, 
>>> 0x0, 0x64, 0x62};
>> loongarch_pe_machtype isn't used at all.
> It will be removed.
>>
>>> +
>>> +/**
>>> + * loongarch_header_check_pe_sig - Helper to check the loongarch 
>>> image header.
>>> + *
>>> + * Returns non-zero if 'MZ' signature is found.
>>> + */
>>> +
>>> +static inline int loongarch_header_check_pe_sig(const struct 
>>> loongarch_image_header *h)
>>> +{
>>> +    if (!h)
>>> +        return 0;
>>> +
>>> +    return (h->pe_sig[0] == loongarch_image_pe_sig[0]
>>> +        && h->pe_sig[1] == loongarch_image_pe_sig[1]);
>> This could be simplified with a memcmp(). Also, this check isn't strict
>> enough: PE files for any architectures, and even legacy MS-DOS COM
>> executables all start with "MZ".
>>
>>> +}
>>> +
>>>   #endif /* __ASSEMBLY__ */
>>>   #endif /* __ASM_IMAGE_H */
>> ...
>>
>>> diff --git a/arch/loongarch/kernel/kexec_image.c 
>>> b/arch/loongarch/kernel/kexec_image.c
>>> new file mode 100644
>>> index 000000000000..fdd1845b4e2e
>>> --- /dev/null
>>> +++ b/arch/loongarch/kernel/kexec_image.c
>>> @@ -0,0 +1,112 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Kexec image loader for LoongArch
>>> +
>>> + * Author: Youling Tang <tangyouling@kylinos.cn>
>>> + * Copyright (C) 2025 KylinSoft Corporation.
>>> + */
>>> +
>>> +#define pr_fmt(fmt)    "kexec_file(Image): " fmt
>>> +
>>> +#include <linux/err.h>
>>> +#include <linux/errno.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/kexec.h>
>>> +#include <linux/pe.h>
>>> +#include <linux/string.h>
>>> +#include <asm/byteorder.h>
>>> +#include <asm/cpufeature.h>
>>> +#include <asm/image.h>
>>> +
>>> +static int image_probe(const char *kernel_buf, unsigned long 
>>> kernel_len)
>>> +{
>>> +    const struct loongarch_image_header *h =
>>> +        (const struct loongarch_image_header *)(kernel_buf);
>> Parentheses around "kernel_buf" are unnecessary.
> It will be removed.
>>
>>> +    if (!h || (kernel_len < sizeof(*h))) {
>> Comparisons have higher priority than logic operations, so this pair of
>> parentheses is redundant, too.
> Yes, but the parentheses will be retained for greater readability.
>>
>>> +        pr_err("No loongarch image header.\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (!loongarch_header_check_pe_sig(h)) {
>>> +        pr_err("Bad loongarch PE image header.\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static void *image_load(struct kimage *image,
>>> +                char *kernel, unsigned long kernel_len,
>>> +                char *initrd, unsigned long initrd_len,
>>> +                char *cmdline, unsigned long cmdline_len)
>>> +{
>>> +    struct loongarch_image_header *h;
>>> +    struct kexec_buf kbuf;
>>> +    unsigned long text_offset, kernel_segment_number;
>>> +    struct kexec_segment *kernel_segment;
>>> +    int ret;
>>> +
>>> +    h = (struct loongarch_image_header *)kernel;
>>> +    if (!h->image_size)
>>> +        return ERR_PTR(-EINVAL);
>>> +
>>> +    /* Load the kernel */
>>> +    kbuf.image = image;
>>> +    kbuf.buf_min = 0;
>>> +    kbuf.buf_max = ULONG_MAX;
>>> +    kbuf.top_down = false;
>>> +
>>> +    kbuf.buffer = kernel;
>>> +    kbuf.bufsz = kernel_len;
>>> +    kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>> +    kbuf.memsz = le64_to_cpu(h->image_size);
>>> +    text_offset = le64_to_cpu(h->text_offset);
>>> +    kbuf.buf_align = SZ_2M;
>> I think this aligment is unnecessary for relocatable LoongArch kernels:
>> it should be enough to align to the page size. See also my comments
>> below.
>>
>>> +    kernel_segment_number = image->nr_segments;
>>> +
>>> +    /*
>>> +     * The location of the kernel segment may make it impossible to 
>>> satisfy
>>> +     * the other segment requirements, so we try repeatedly to find a
>>> +     * location that will work.
>>> +     */
>>> +    while ((ret = kexec_add_buffer(&kbuf)) == 0) {
>>> +        /* Try to load additional data */
>>> +        kernel_segment = &image->segment[kernel_segment_number];
>>> +        ret = load_other_segments(image, kernel_segment->mem,
>>> +                      kernel_segment->memsz, initrd,
>>> +                      initrd_len, cmdline, cmdline_len);
>>> +        if (!ret)
>>> +            break;
>>> +
>>> +        /*
>>> +         * We couldn't find space for the other segments; erase the
>>> +         * kernel segment and try the next available hole.
>>> +         */
>>> +        image->nr_segments -= 1;
>>> +        kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
>>> +        kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>> +    }
>>> +
>>> +    if (ret) {
>>> +        pr_err("Could not find any suitable kernel location!");
>>> +        return ERR_PTR(ret);
>>> +    }
>>> +
>>> +    kernel_segment = &image->segment[kernel_segment_number];
>>> +
>>> +    /* Make sure the second kernel jumps to the correct 
>>> "kernel_entry". */
>>> +    image->start = kernel_segment->mem + h->kernel_entry - 
>>> text_offset;
>> A non-relocatable loongarch kernel cannot be loaded to arbitrary
>> address. Thus this loading function seems to only work for relocatable
>> kernels, maybe it's better to leave a comment indicating the limitation.
>>
>> For now, we don't seem to have a way to find out whether the kernel is
>> relocatable (for example, a flag in kernel image header), so it's
>> impossible to point out whether the loaded kernel boots fine with
>> arbitrary loading address...
> LoongArch enables the relocation of the kernel when the kdump
> feature is enabled.
>
> config ARCH_SELECTS_CRASH_DUMP
>         def_bool y
>         depends on CRASH_DUMP
>         select RELOCATABLE
>
When enabling KEXEC_FILE, the RELOCATABLE configuration should
also be enabled. Both kexec and kdump require this.

Youling.
> After enabling the relocation, LoongArch is the PIE kernel. For
> more details, please refer to commit d8da19fbdedd ("LoongArch:
> Add support for kernel relocation")
>>> +    kexec_dprintk("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>>> +              kernel_segment->mem, kbuf.bufsz,
>>> +              kernel_segment->memsz);
>>> +
>>> +    return NULL;
>>> +}
>>> +
>>> +const struct kexec_file_ops kexec_image_ops = {
>>> +    .probe = image_probe,
>>> +    .load = image_load,
>>> +};
>>> diff --git a/arch/loongarch/kernel/machine_kexec.c 
>>> b/arch/loongarch/kernel/machine_kexec.c
>>> index f9381800e291..008f43e26120 100644
>>> --- a/arch/loongarch/kernel/machine_kexec.c
>>> +++ b/arch/loongarch/kernel/machine_kexec.c
>>> @@ -70,18 +70,28 @@ int machine_kexec_prepare(struct kimage *kimage)
>> ...
>>
>>> -    if (!kimage->arch.cmdline_ptr) {
>>> -        pr_err("Command line not included in the provided image\n");
>>> -        return -EINVAL;
>>> +        if (!kimage->arch.cmdline_ptr) {
>>> +            pr_err("Command line not included in the provided 
>>> image\n");
>>> +            return -EINVAL;
>>> +        }
>>>       }
>>>         /* kexec/kdump need a safe page to save reboot_code_buffer */
>>> @@ -288,7 +298,8 @@ void machine_kexec(struct kimage *image)
>>>       local_irq_disable();
>>>         pr_notice("EFI boot flag 0x%lx\n", efi_boot);
>>> -    pr_notice("Command line at 0x%lx\n", cmdline_ptr);
>>> +    pr_notice("Command line addr at 0x%lx\n", cmdline_ptr);
>>> +    pr_notice("Command line at %s\n", (char *)cmdline_ptr);
>> The printed message doesn't match meaning of the pointer: you're
>> printing the content of cmdline_ptr, instead of its address, thus
>> "Command line at" sounds confusing to me.
> I will correct it.
>
> Thanks,
> Youling.
>>
>> Furthermore, this chunk isn't related to "support for kexec_file", I
>> think it's better to separate it into another patch (or even another
>> series).
>>
>>>       pr_notice("System table at 0x%lx\n", systable_ptr);
>>>       pr_notice("We will call new kernel at 0x%lx\n", start_addr);
>>>       pr_notice("Bye ...\n");
>> Best regards,
>> Yao Zi

