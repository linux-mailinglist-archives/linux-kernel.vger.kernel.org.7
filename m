Return-Path: <linux-kernel+bounces-780999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB40B30C18
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4B6603813
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 02:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4413223DEA;
	Fri, 22 Aug 2025 02:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MNfbA6DW"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A9393DC6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755831423; cv=none; b=QK36MAPj26PdyOWvhgoKJ7dqFY+oLVLnfUE9RHyAAyOvm5gPDKTWMWh544lgj5+vSOVAbAU8AUDTtMXCKHtKurs20YO9MOVgMr/Kx/3xXsQl/4ZQrz3J6vGYBOscsRv4uayE0TF4l+AYdVP2Cn7D1lH2ixa2vCl+DcYNWX0pcP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755831423; c=relaxed/simple;
	bh=Xe1mIlMUN/qE/w3Jl/dBXANrKxCrD47d8KPhFwwAD3g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IaPKYzxM/x4AdvmDmede0ZivQycw4rKLwmAPfOOOmzgseV6tqI0XPnZLp2GH/N55E8ugZzguYSfRJwUFGTdWGso05ly0zp8CyjusPOIt4zuv+IYsaB7zj/cfCtVeF1pn/KPu1BrXqXFeA330SZkjhf95KYtz/oMcG4BufmDnVmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MNfbA6DW; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a15ad5bd-f54d-466c-8bdd-6f5b5936abee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755831418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8RMr52Vx027eFgdwve0pRlzAd7K1nsGWklGu/IVtsk=;
	b=MNfbA6DWXbs61EwGbWFtyZfJMPBnQOE+3euszT51Gn/emRWME8MMlW5rWbIX2WR8qW1XdF
	60WmRN7Wje94WbdMMfQXt2rg9OS+JzHMDC2qw2+TwfKfFaePNWZ8zoMHwhSxTjn0bI6dsU
	Tq3jm69lTNBDMyGe4A6P9C7wKFxM56A=
Date: Fri, 22 Aug 2025 10:56:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/5] LoongArch: Add kexec_file support
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Yao Zi <ziyao@disroot.org>, Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20250820055700.24344-1-youling.tang@linux.dev>
 <20250820055700.24344-3-youling.tang@linux.dev> <aKVwHOM9KNEpUZF4@pie>
 <5f6eeefb-681a-424e-9a6b-2e91eaf87571@linux.dev>
Content-Language: en-US
In-Reply-To: <5f6eeefb-681a-424e-9a6b-2e91eaf87571@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2025/8/20 17:13, Youling Tang wrote:

> Hi, Yao
>
> On 2025/8/20 14:50, Yao Zi wrote:
>
>> On Wed, Aug 20, 2025 at 01:56:57PM +0800, Youling Tang wrote:
>>> From: Youling Tang <tangyouling@kylinos.cn>
>>>
>>> This patch adds support for kexec_file on LoongArch.
>>>
>>> The efi_kexec_load() as two parts:
>>> - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
>>> - the second part loads other segments (eg: initrd, cmdline)
>>>
>>> This initrd will be passed to the second kernel via the command line
>>> 'initrd=start,size'.
>>>
>>> Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are 
>>> supported,
>>> but ELF format is not supported.
>>>
>>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
>>> ---
>>>   arch/loongarch/Kconfig                     |   9 ++
>>>   arch/loongarch/include/asm/image.h         |  17 +++
>>>   arch/loongarch/include/asm/kexec.h         |  12 +++
>>>   arch/loongarch/kernel/Makefile             |   1 +
>>>   arch/loongarch/kernel/kexec_efi.c          | 111 +++++++++++++++++++
>>>   arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
>>>   arch/loongarch/kernel/machine_kexec_file.c | 117 
>>> +++++++++++++++++++++
>>>   7 files changed, 289 insertions(+), 11 deletions(-)
>>>   create mode 100644 arch/loongarch/kernel/kexec_efi.c
>>>   create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
>> ...
>>
>>> diff --git a/arch/loongarch/include/asm/image.h 
>>> b/arch/loongarch/include/asm/image.h
>>> index 1f090736e71d..655d5836c4e8 100644
>>> --- a/arch/loongarch/include/asm/image.h
>>> +++ b/arch/loongarch/include/asm/image.h
>>> @@ -36,5 +36,22 @@ struct loongarch_image_header {
>>>       uint32_t pe_header;
>>>   };
>>>   +static const uint8_t loongarch_image_pe_sig[2] = {'M', 'Z'};
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
>>> +}
>> This check is still too weak and doesn't improve comparing to v1.
>>
>>> This could be simplified with a memcmp(). Also, this check isn't
>>> strict enough: PE files for any architectures, and even legacy MS-DOS
>>> COM executables all start with "MZ".
>> I've pointed this out in my previous reply[1].
> Previously, I had considered adding a specific LoongArch magic
> number (such as "Loongson") in the loongarch_image_header, but
> this is incompatible with older versions of the kernel, so it
> remains the same without further checks.
>>
>>>   #endif /* __ASSEMBLY__ */
>>>   #endif /* __ASM_IMAGE_H */
>> ...
>>
>>> diff --git a/arch/loongarch/kernel/kexec_efi.c 
>>> b/arch/loongarch/kernel/kexec_efi.c
>>> new file mode 100644
>>> index 000000000000..7741f1139a12
>>> --- /dev/null
>>> +++ b/arch/loongarch/kernel/kexec_efi.c
>> ...
>>
>>> +static void *efi_kexec_load(struct kimage *image,
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
>>> +    kbuf.buf_max = ULONG_MAX;
>>> +    kbuf.top_down = false;
>>> +
>>> +    kbuf.buffer = kernel;
>>> +    kbuf.bufsz = kernel_len;
>>> +    kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>> +    kbuf.memsz = le64_to_cpu(h->image_size);
>>> +    text_offset = le64_to_cpu(h->text_offset);
>>> +    kbuf.buf_min = text_offset;
>>> +    kbuf.buf_align = SZ_2M;
>>> +
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
>> And this still assumes the loaded, secondary kernel is relocatable,
>> with neither extra check nor comment explaining its limitation.
>>
>> Please see my previous reply[2] that explains why loading a
>> non-relocatble kernel with kexec_file API is reasonable.
> LoongArch is a non-position independent (non-PIE) kernel when
> the RELOCATABLE option is not enabled, the kernel contains certain
> instructions such as la.abs, which prevent it from being relocated to
> arbitrary memory addresses for execution. As a result, limitations
> exist that make features like kdump or kexec_file dependent on
> the RELOCATABLE option.
>
> Strictly speaking, we need to add additional checks: if the kernel is
> non-relocatable, the loading operation should fail directly. For a
> running kernel, we can easily determine this by calling
> kallsyms_lookup_name("relocate_kernel"). However, for a kernel
> that is being loaded but has not yet started execution, it is difficult
> to easily determine whether the currently loaded kernel has the
> RELOCATABLE configuration option enabled.
>
> For ELF format images, we can determine whether the loaded image
> contains the ".la_abs" section in the following way:
> static struct mem_shdr *laabs_section(const struct mem_ehdr *ehdr)
> {
>         struct mem_shdr *shdr, *shdr_end;
>         unsigned char *strtab;
>
>         strtab = (unsigned char *)ehdr->e_shdr[ehdr->e_shstrndx].sh_data;
>         shdr_end = &ehdr->e_shdr[ehdr->e_shnum];
>         for (shdr = ehdr->e_shdr; shdr != shdr_end; shdr++) {
>                 if (shdr->sh_size &&
>                         strcmp((char *)&strtab[shdr->sh_name], 
> ".la_abs") == 0) {
>                         return shdr;
>                 }
>         }
>
>         return NULL;
> }
I attempted to parse the pe header to obtain the sections information
and found that there were only two sections, '.text' and '.data'. We
cannot parse whether there is a '.la_abs' section like in the ELF format.

The reason is that when generating vmlinux.efi, when the ELF vmlinux
is converted to the original binary file through the 'objdump -O binary'
operation (arch/loongarch/boot/Makefile), the remaining sections are
merged into the '.text' and '.data' sections.

Youling.
>
> Thanks,
> Youling.
>>
>>> +    kexec_dprintk("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>>> +              kernel_segment->mem, kbuf.bufsz,
>>> +              kernel_segment->memsz);
>>> +
>>> +    return NULL;
>>> +}
>>> +
>>> +const struct kexec_file_ops kexec_efi_ops = {
>>> +    .probe = efi_kexec_probe,
>>> +    .load = efi_kexec_load,
>>> +};
>> Thanks,
>> Yao Zi
>>
>> [1]: https://lore.kernel.org/all/aJojDiHWi8cgvA2W@pie/
>> [2]: https://lore.kernel.org/all/aJwFa8x5BQMouB1y@pie/

